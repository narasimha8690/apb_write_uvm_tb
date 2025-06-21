interface apb_if(input logic PCLK, input logic PRESETn);
  logic [7:0] PADDR;
  logic [7:0] PWDATA;
  logic PWRITE;
  logic PENABLE;
  logic PSEL;
endinterface
