
module LZC_proposed #(
  parameter WIDTH = 16,                // can be 2 or more
  parameter WIDTH2 = 2**$clog2(WIDTH),
  parameter COUNT = $clog2(WIDTH2)
) (
  input   logic [WIDTH2-1 : 0]  A,
  output  logic [COUNT-1  : 0]  n_Z,
  output  logic                 n_V
);

  initial if (WIDTH2 != WIDTH) $display("\n\t\tIncorrect input WIDTH! Was changed on %d bit input A\n", WIDTH2);

  logic [3*WIDTH2/2-1 : 0]  subwire [0:COUNT];
  
  genvar i, j;
  generate
    for (i = COUNT; i > 0; i = i - 1) begin                   // level  max -> 1
      for (j = COUNT-i; j < 2**(COUNT-i); j = j + 1) begin    // block  0 -> max
        base_element_proposed #(i) bep_i_j (
          .in(subwire[i-1][(4*i-2)*(j+1)-1 : (4*i-2)*j]),
          .out(subwire[i][(2*i+1)*(j+1)-1 : (2*i+1)*j])
        );
      end
      assign n_Z[COUNT-i] = subwire[COUNT][2*i-1];
    end
  endgenerate

  assign subwire[0][WIDTH2-1 : 0] = A[WIDTH2-1 : 0];
  assign n_V = subwire[COUNT][COUNT*2];

endmodule



module base_element_proposed #(
  parameter LEVEL = 4,               // can be 1 or more
  parameter WIDTH_IN = LEVEL*4 - 2,
  parameter WIDTH_OUT = LEVEL*2 + 1
) (
  input   logic [WIDTH_IN-1  : 0] in,
  output  logic [WIDTH_OUT-1 : 0] out
  );

  logic [WIDTH_IN/2-1 : 0] r;
  logic [WIDTH_IN/2-1 : 0] l;

  assign r = in[WIDTH_IN/2-1 : 0];
  assign l = in[WIDTH_IN-1   : WIDTH_IN/2];

  assign out[0] = ~r[WIDTH_IN/2-1];
  assign out[1] =  l[WIDTH_IN/2-1];
  assign out[WIDTH_OUT-1] = l[WIDTH_IN/2-1] | r[WIDTH_IN/2-1];

  genvar s;
  generate
    if (LEVEL > 1)
      for (s = 0; s < LEVEL-1; s = s + 1) begin
        assign out[2*(s+1)] = l[s*2] & r[s*2];
        assign out[2*(s+1)+1] = l[s*2+1] | l[s*2] & r[s*2+1];
      end
  endgenerate  


endmodule
