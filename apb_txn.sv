class apb_txn extends uvm_sequence_item;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  `uvm_object_utils(apb_txn)

  function new(string name = "apb_txn");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    $display("APB TXN -> addr: %0h data: %0h", addr, data);
  endfunction
endclass
