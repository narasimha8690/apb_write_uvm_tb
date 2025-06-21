`include "apb_if.sv"
`include "apb_dut.sv"

module apb_top;
  bit PCLK = 0;
  always #5 PCLK = ~PCLK;
  bit PRESETn = 0;

  initial begin
    #10 PRESETn = 1;
  end

  apb_if vif(PCLK, PRESETn);
  apb_dut dut (
    .PCLK(vif.PCLK), .PRESETn(vif.PRESETn),
    .PSEL(vif.PSEL), .PENABLE(vif.PENABLE), .PWRITE(vif.PWRITE),
    .PADDR(vif.PADDR), .PWDATA(vif.PWDATA)
  );

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import apb_pkg::*;

  initial begin
    uvm_config_db#(virtual apb_if)::set(null, "*", "vif", vif);
    run_test("apb_test");
  end
endmodule
