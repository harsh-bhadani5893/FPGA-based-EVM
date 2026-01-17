library verilog;
use verilog.vl_types.all;
entity EVM is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        mode            : in     vl_logic;
        candid_button   : in     vl_logic_vector(3 downto 0);
        vot_logged      : out    vl_logic_vector(3 downto 0);
        valid_vote      : out    vl_logic;
        invalid_vote    : out    vl_logic;
        display_out     : out    vl_logic_vector(7 downto 0)
    );
end EVM;
