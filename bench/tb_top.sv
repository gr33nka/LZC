`timescale 1ps / 1ps
`include "../rtl/LZC_classic.sv"
`include "../rtl/LZC_proposed.sv"
`include "../rtl/LZC_second.sv"

`define TIME_SIM #1000

module tb_top;
  
  parameter WIDTH_IN = 16;
  parameter WIDTH2 = 2**$clog2(WIDTH_IN);
  parameter WIDTH_OUT = $clog2(WIDTH2) + 1;

  logic [WIDTH2-1  : 0]   A;
  logic [WIDTH_OUT-2 : 0] Z_c;
  logic                   V_c;
  logic [WIDTH_OUT-2 : 0] Z_p;
  logic                   V_p;
  logic [WIDTH_OUT-2 : 0] Z_s;
  logic                   V_s;

  logic [WIDTH_OUT-1 : 0] OUT_c;
  logic [WIDTH_OUT-1 : 0] OUT_p;
  logic [WIDTH_OUT-1 : 0] OUT_s;
  string                  wrong_c = "Classic - GOOD!\t";
  string                  wrong_p = "Proposed - GOOD!\t";
  string                  wrong_s = "Second - GOOD!";


  LZC_classic #(WIDTH2) LZC_c_tb (
    .A(A),
    .Z(Z_c),
    .n_V(V_c)
  );

  LZC_proposed #(WIDTH2) LZC_p_tb (
    .A(A),
    .n_Z(Z_p),
    .n_V(V_p)
  );

  LZC_second #(WIDTH2) LZC_s_tb (
    .A(A),
    .n_Z(Z_s),
    .n_V(V_s)
  );


  assign OUT_c = {~V_c, Z_c};
  assign OUT_p = {~V_p, ~Z_p};
  assign OUT_s = {~V_s, ~Z_s};


  initial begin
    $dumpvars;
    if (WIDTH_IN != WIDTH2) 
      $display("\n\t\tIncorrect input WIDTH_IN! Was changed on %d bit input A\n", WIDTH2);
    TIME_SIM;
    $display("\n\n\t\t\t%s %s %s", wrong_c, wrong_p, wrong_s);
    $finish;
  end


  integer i;
  integer zeros;
  logic   flag;

  always #10 begin
    A = $urandom_range(0, 2**$clog2(WIDTH2) - 1);
    
    zeros = 0;
    flag = 0;
    for (i = WIDTH2-1; i >= 0; i = i - 1) begin
      if (~flag & ~A[i])
        zeros = zeros + 1;
      else
        flag = 1;
    end
    
    #5;
    
    if (OUT_c == zeros) begin
      $display($time,, "A = %h,\tzeros = %d,\tclassic = %d", A, zeros, OUT_c);
    end else begin
      $display($time,, "A = %h,\tzeros = %d,\tclassic = %d\t<--- BAD!", A, zeros, OUT_c);
      wrong_c = "Classic -- BAD!\t";
    end
    
    if (OUT_p == zeros) begin
      $display($time,, "A = %h,\tzeros = %d,\tproposed = %d", A, zeros, OUT_p);
    end else begin 
      $display($time,, "A = %h,\tzeros = %d,\tproposed = %d\t<--- BAD!", A, zeros, OUT_p);
      wrong_p = "Proposed -- BAD!\t";
    end

    if (OUT_s == zeros) begin
      $display($time,, "A = %h,\tzeros = %d,\tsecond = %d", A, zeros, OUT_s);
    end else begin
      $display($time,, "A = %h,\tzeros = %d,\tsecond = %d\t<--- BAD!", A, zeros, OUT_s);
      wrong_s = "Second -- BAD!";
    end
  end

endmodule
