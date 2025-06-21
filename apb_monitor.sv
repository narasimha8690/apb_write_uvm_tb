class apb_monitor extends uvm_monitor;
  virtual apb_if vif;
  uvm_analysis_port #(apb_txn) mon_ap;

  `uvm_component_utils(apb_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon_ap = new("mon_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not set")
  endfunction

  task run_phase(uvm_phase phase);
    apb_txn tx;
    forever begin
      @(posedge vif.PCLK);
      if (vif.PSEL && vif.PENABLE && vif.PWRITE) begin
        tx = apb_txn::type_id::create("tx");
        tx.addr = vif.PADDR;
        tx.data = vif.PWDATA;
        mon_ap.write(tx);
      end
    end
  endtask
endclass
