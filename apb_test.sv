class apb_test extends uvm_test;
  apb_env env;

  `uvm_component_utils(apb_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    apb_txn tx;
    phase.raise_objection(this);
    repeat (10) begin
      tx = apb_txn::type_id::create("tx");
      assert(tx.randomize());
      env.drv.seq_item_port.put(tx);
    end
    #20;
    phase.drop_objection(this);
  endtask
endclass
