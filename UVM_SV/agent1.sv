class agent1 extends uvm_agent;
  sequencer       sequencer_h;
  Driver          Driver_h;
  monitor1        monitor1_h;
  `uvm_component_utils(agent1)
  
  function new(string name = "agent1", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer_h   = sequencer::type_id::create("sequencer_h", this);
    Driver_h      = Driver::type_id::create("Driver_h", this);
    monitor1_h    = monitor1::type_id::create("monitor1_h", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    //`uvm_info(get_type_name(), $sformatf("We are in agent1 connect phase"), UVM_LOW)
     Driver_h.seq_item_port.connect(sequencer_h.seq_item_export);

  endfunction
  
endclass