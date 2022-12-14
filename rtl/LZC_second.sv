
module LZC_second #(
  parameter WIDTH = 16,                // can be 2 or more
  parameter WIDTH2 = 2**$clog2(WIDTH),
  parameter COUNT = $clog2(WIDTH2)
) (
  input   logic [WIDTH2-1 : 0]  A,
  output  logic [COUNT-1  : 0]  n_Z,
  output  logic                 n_V
);

  initial if (WIDTH2 != WIDTH) $display("\n\t\tIncorrect input WIDTH! Was changed on %d bit input A\n", WIDTH2);

  logic [WIDTH2-1 : 0]  subwire [0:COUNT];
  
  generate
    for (genvar i = COUNT; i > 0; i = i - 1) begin            // level 
      for (genvar j = 0; j < 2**(COUNT-i); j = j + 1) begin   // block
        base_element_second #(i) bes_i_j (
          .in(subwire[i-1][i*2*(j+1)-1 : i*2*j]),
          .out(subwire[i][(i+1)*(j+1)-1 : (i+1)*j])
        );
      end
      assign n_Z[i-1] = subwire[COUNT][COUNT-i];
    end
  endgenerate

  assign subwire[0][WIDTH2-1 : 0] = A[WIDTH2-1 : 0];
  assign n_V = subwire[COUNT][COUNT];

endmodule



module base_element_second #(
  parameter LEVEL = 4,               // can be 1 or more
  parameter WIDTH_ALL = LEVEL * 2
) (
  input   logic [WIDTH_ALL-1 : 0] in,
  output  logic [LEVEL       : 0] out
);

  logic [LEVEL-1 : 0] r;
  logic [LEVEL-1 : 0] l;

  assign r = in[LEVEL-1 : 0];
  assign l = in[WIDTH_ALL-1 : LEVEL];

  assign out[0] = l[LEVEL-1];
  assign out[LEVEL] = l[LEVEL-1] | r[LEVEL-1];

  genvar s;
  generate
    if (LEVEL > 1)
      for (s = 0; s < LEVEL-1; s = s + 1)
        assign out[s+1] = ~l[LEVEL-1] & r[s] | l[s] ;
  endgenerate  


endmodule
