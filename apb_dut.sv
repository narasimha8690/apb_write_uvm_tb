module apb_dut (
  input logic PCLK, PRESETn,
  input logic PSEL, PENABLE, PWRITE,
  input logic [7:0] PADDR,
  input logic [7:0] PWDATA
);
  logic [7:0] mem[0:255];

  always @(posedge PCLK or negedge PRESETn) begin
    if (!PRESETn)
      mem[0] <= 0;
    else if (PSEL && PENABLE && PWRITE)
      mem[PADDR] <= PWDATA;
  end
endmodule
