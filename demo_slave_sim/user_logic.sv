//demo user logic function overview:
//receives shift right or shift left commands from the masters. perform corresponding shift operations (data >> i or data << j) on data stream.
//The shift value i and j will be read from command registers written by the masters.
//when masters signal a end of data stream command, the user logic will send masters an end of processing signal when done.

module user_logic
  (
   input logic 	       clk,
   input logic 	       reset_n,

   //interface to write-FIFO in slave
   output logic        wrreq,      //AHB slave write fifo enable
   output logic [31:0] wdata,      //write-data to write fifo
   input logic 	       wrfull,     //write fifo is full

   //interface to read-FIFO in slave
   output logic        rdack,       //acknowledge that AHB slave read fifo being read
   input logic [31:0]  rdata,       //read fifo read-data
   input logic 	       rdempty,     //read fifo is empty

   //interface to other registers in register file
   output logic        u_write,     //AHB slave register file write enable
   output logic [31:0] u_addr,      //register address
   output logic [31:0] u_wdata,     //write data to the register
   input logic [31:0]  u_data       //read data from register
   );

   logic [31:0]        data_in, data_out, data_extract;
   logic 	       new_data_flag;
   logic 	       rdempty_reg;
   logic [3:0] 	       cmd_in;

   typedef enum        {IDLE, SHIFT_R, SHIFT_L, DONE} state_t;
   state_t state;

   //instruction decode, extract upper four bits from the data_in
   //0001: stands for shift right operation
   //0010: stands for shift left operation
   //0100: stands for end of operation
   //1000: stands for a real data to be processed
   assign cmd_in = data_in[31:28];

   //state machine to control the different operations
   always_ff @ (posedge clk, negedge reset_n) begin
      if (!reset_n) begin
	   state <= IDLE;
      end
      else begin
           case (state)
	         IDLE: begin
	             if (cmd_in == 4'b0001) begin
		           state <= SHIFT_R;
	             end
	             if (cmd_in == 4'b0010) begin
		           state <= SHIFT_L;
	             end
	         end
	         SHIFT_R: begin   //shift right operation
	             if (cmd_in == 4'b0010) begin
	         	   state <= SHIFT_L;
	             end
	             if (cmd_in == 4'b0100) begin
		           state <= DONE;
	             end
	        end
	        SHIFT_L: begin   //shift left operation
	             if (cmd_in == 4'b0001) begin
	 	          state <= SHIFT_R;
	             end
	             if (cmd_in == 4'b0100) begin
		          state <= DONE;
	             end
	        end
	        DONE: begin      //processing done operation
	             state <= IDLE;
	        end
	        default: begin
	        end
 	    endcase
      end
   end

   //since each data is encoded, need to extract the actual data to be processed
   assign data_extract = {4'b0, data_in[27:0]};

   
   //ALU operation
   always_comb begin
      u_addr = 2;
      data_out = 0;
      u_write = 0;
      u_wdata = 0;
      case (state)
	   SHIFT_R: begin
	        u_addr = 2;
	        data_out = data_extract >> u_data;
	   end
	   SHIFT_L: begin
	        u_addr = 3;
	        data_out = data_extract << u_data;
	   end
	   DONE: begin  //write processing done signal 32'hFFFF into the register file to signal Atom processor
	        u_addr = 4;
	        u_write = 1'b1;
	        u_wdata = 32'hFFFF;
	   end
	   default: begin
	   end
      endcase
   end

   //flag of a new data to be processed comes in
   assign new_data_flag = (~rdempty_reg) & (cmd_in == 4'b1000);
	
   //register the data read from the read-fifo and read-fifo empty signal
   always_ff @ (posedge clk, negedge reset_n) begin
      if (!reset_n) begin
	 data_in <= 0;
	 rdempty_reg <= 1;
      end
      else begin
	 data_in <= rdata;
	 rdempty_reg <= rdempty;
      end
   end
    
   assign rdack = (~rdempty);   

   //processed data to be written into the write-fifo
   assign wdata = data_out;

   //write enable of write-fifo
   assign wrreq = new_data_flag;
   
endmodule

   
		  
