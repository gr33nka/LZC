module LZC_second (
  parametr WIDTH = 16,
  parametr COUNT = $clog2(WIDTH)
  ) (
  input   logic [WIDTH-1:0] A,
  output  logic [COUNT-1:0] n_Z,
  output  logic             n_V
);

endmodule
