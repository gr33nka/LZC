`timescale 1ps / 1ps
`include "../rtl/LZC_classic.sv"
`include "../rtl/LZC_proposed.sv"
`include "../rtl/LZC_second.sv"

`define TIME_SIM #1000

module tb_top;

  LZC_classic LZC_c_tb(.*);
  LZC_proposed LZC_p_tb(.*);
  LZC_second LZC_s_tb(.*);


  initial begin
    $dumpvars;
    TIME_SIM;
    $finish;
  end


  initial begin

  end

endmodule
