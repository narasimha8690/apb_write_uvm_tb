class apb_scoreboard extends uvm_component;
  uvm_analysis_imp #(apb_txn, apb_scoreboard) sb_ap;

  `uvm_component_utils(apb_scoreboard)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    sb_ap = new("sb_ap", this);
  endfunction

  function void write(apb_txn tx);
    $display("SCOREBOARD: Received Write -> Addr: %0h Data: %0h", tx.addr, tx.data);
  endfunction
endclass
