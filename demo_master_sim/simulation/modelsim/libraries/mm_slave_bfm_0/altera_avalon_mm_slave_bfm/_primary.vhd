library verilog;
use verilog.vl_types.all;
entity altera_avalon_mm_slave_bfm is
    generic(
        AV_ADDRESS_W    : integer := 16;
        AV_SYMBOL_W     : integer := 8;
        AV_NUMSYMBOLS   : integer := 4;
        AV_BURSTCOUNT_W : integer := 3;
        AV_READRESPONSE_W: integer := 8;
        AV_WRITERESPONSE_W: integer := 8;
        USE_READ        : integer := 1;
        USE_WRITE       : integer := 1;
        USE_ADDRESS     : integer := 1;
        USE_BYTE_ENABLE : integer := 1;
        USE_BURSTCOUNT  : integer := 1;
        USE_READ_DATA   : integer := 1;
        USE_READ_DATA_VALID: integer := 1;
        USE_WRITE_DATA  : integer := 1;
        USE_BEGIN_TRANSFER: integer := 1;
        USE_BEGIN_BURST_TRANSFER: integer := 1;
        USE_WAIT_REQUEST: integer := 1;
        USE_ARBITERLOCK : integer := 0;
        USE_LOCK        : integer := 0;
        USE_DEBUGACCESS : integer := 0;
        USE_TRANSACTIONID: integer := 0;
        USE_WRITERESPONSE: integer := 0;
        USE_READRESPONSE: integer := 0;
        USE_CLKEN       : integer := 0;
        AV_FIX_READ_LATENCY: integer := 0;
        AV_MAX_PENDING_READS: integer := 1;
        AV_MAX_PENDING_WRITES: integer := 0;
        AV_BURST_LINEWRAP: integer := 0;
        AV_BURST_BNDR_ONLY: integer := 0;
        AV_READ_WAIT_TIME: integer := 0;
        AV_WRITE_WAIT_TIME: integer := 0;
        REGISTER_WAITREQUEST: integer := 0;
        AV_REGISTERINCOMINGSIGNALS: integer := 0;
        VHDL_ID         : integer := 0
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        avs_clken       : in     vl_logic;
        avs_waitrequest : out    vl_logic;
        avs_write       : in     vl_logic;
        avs_read        : in     vl_logic;
        avs_address     : in     vl_logic_vector;
        avs_byteenable  : in     vl_logic_vector;
        avs_burstcount  : in     vl_logic_vector;
        avs_beginbursttransfer: in     vl_logic;
        avs_begintransfer: in     vl_logic;
        avs_writedata   : in     vl_logic_vector;
        avs_readdata    : out    vl_logic_vector;
        avs_readdatavalid: out    vl_logic;
        avs_arbiterlock : in     vl_logic;
        avs_lock        : in     vl_logic;
        avs_debugaccess : in     vl_logic;
        avs_transactionid: in     vl_logic_vector(7 downto 0);
        avs_readresponse: out    vl_logic_vector;
        avs_readid      : out    vl_logic_vector(7 downto 0);
        avs_writeresponserequest: in     vl_logic;
        avs_writeresponsevalid: out    vl_logic;
        avs_writeresponse: out    vl_logic_vector;
        avs_writeid     : out    vl_logic_vector(7 downto 0);
        avs_response    : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of AV_ADDRESS_W : constant is 1;
    attribute mti_svvh_generic_type of AV_SYMBOL_W : constant is 1;
    attribute mti_svvh_generic_type of AV_NUMSYMBOLS : constant is 1;
    attribute mti_svvh_generic_type of AV_BURSTCOUNT_W : constant is 1;
    attribute mti_svvh_generic_type of AV_READRESPONSE_W : constant is 1;
    attribute mti_svvh_generic_type of AV_WRITERESPONSE_W : constant is 1;
    attribute mti_svvh_generic_type of USE_READ : constant is 1;
    attribute mti_svvh_generic_type of USE_WRITE : constant is 1;
    attribute mti_svvh_generic_type of USE_ADDRESS : constant is 1;
    attribute mti_svvh_generic_type of USE_BYTE_ENABLE : constant is 1;
    attribute mti_svvh_generic_type of USE_BURSTCOUNT : constant is 1;
    attribute mti_svvh_generic_type of USE_READ_DATA : constant is 1;
    attribute mti_svvh_generic_type of USE_READ_DATA_VALID : constant is 1;
    attribute mti_svvh_generic_type of USE_WRITE_DATA : constant is 1;
    attribute mti_svvh_generic_type of USE_BEGIN_TRANSFER : constant is 1;
    attribute mti_svvh_generic_type of USE_BEGIN_BURST_TRANSFER : constant is 1;
    attribute mti_svvh_generic_type of USE_WAIT_REQUEST : constant is 1;
    attribute mti_svvh_generic_type of USE_ARBITERLOCK : constant is 1;
    attribute mti_svvh_generic_type of USE_LOCK : constant is 1;
    attribute mti_svvh_generic_type of USE_DEBUGACCESS : constant is 1;
    attribute mti_svvh_generic_type of USE_TRANSACTIONID : constant is 1;
    attribute mti_svvh_generic_type of USE_WRITERESPONSE : constant is 1;
    attribute mti_svvh_generic_type of USE_READRESPONSE : constant is 1;
    attribute mti_svvh_generic_type of USE_CLKEN : constant is 1;
    attribute mti_svvh_generic_type of AV_FIX_READ_LATENCY : constant is 1;
    attribute mti_svvh_generic_type of AV_MAX_PENDING_READS : constant is 1;
    attribute mti_svvh_generic_type of AV_MAX_PENDING_WRITES : constant is 1;
    attribute mti_svvh_generic_type of AV_BURST_LINEWRAP : constant is 1;
    attribute mti_svvh_generic_type of AV_BURST_BNDR_ONLY : constant is 1;
    attribute mti_svvh_generic_type of AV_READ_WAIT_TIME : constant is 1;
    attribute mti_svvh_generic_type of AV_WRITE_WAIT_TIME : constant is 1;
    attribute mti_svvh_generic_type of REGISTER_WAITREQUEST : constant is 1;
    attribute mti_svvh_generic_type of AV_REGISTERINCOMINGSIGNALS : constant is 1;
    attribute mti_svvh_generic_type of VHDL_ID : constant is 1;
end altera_avalon_mm_slave_bfm;
