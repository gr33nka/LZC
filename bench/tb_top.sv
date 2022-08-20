`timescale 1ps / 1ps
`include "../rtl/LZC.sv"

`define TIME_SIM #1000

module tb_top;

LZC LZC_tb(.*);

initial begin
  $dumpvars;
  TIME_SIM;
  $finish;
end

endmodule
