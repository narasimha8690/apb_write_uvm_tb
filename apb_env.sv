class apb_env extends uvm_env;
  apb_driver     drv;
  apb_monitor    mon;
  apb_scoreboard sb;

  `uvm_component_utils(apb_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = apb_driver::type_id::create("drv", this);
    mon = apb_monitor::type_id::create("mon", this);
    sb  = apb_scoreboard::type_id::create("sb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    mon.mon_ap.connect(sb.sb_ap);
  endfunction
endclass
