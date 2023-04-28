class agent2 extends uvm_agent;
  monitor2        monitor2_h;
  `uvm_component_utils(agent2)
  
  function new(string name = "agent2", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor2_h    = monitor2::type_id::create("monitor2_h", this);
  endfunction
  
endclass