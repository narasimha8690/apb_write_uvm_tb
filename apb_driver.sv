class apb_driver extends uvm_driver #(apb_txn);
  virtual apb_if vif;

  `uvm_component_utils(apb_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not set")
  endfunction

  task run_phase(uvm_phase phase);
    apb_txn tx;
    forever begin
      seq_item_port.get_next_item(tx);
      drive_txn(tx);
      seq_item_port.item_done();
    end
  endtask

  task drive_txn(apb_txn tx);
    vif.PSEL    <= 1;
    vif.PWRITE  <= 1;
    vif.PADDR   <= tx.addr;
    vif.PWDATA  <= tx.data;
    vif.PENABLE <= 0;
    @(posedge vif.PCLK);
    vif.PENABLE <= 1;
    @(posedge vif.PCLK);
    vif.PSEL    <= 0;
    vif.PENABLE <= 0;
  endtask
endclass
