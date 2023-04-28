class monitor2 extends uvm_monitor;
  virtual ATM_IF  ATM_IF_h;
  // f_sequence_item item_got;
  // uvm_analysis_port#(f_sequence_item) item_got_port;
  `uvm_component_utils(monitor2)
  
  function new(string name = "monitor2", uvm_component parent);
    super.new(name, parent);
    // item_got_port = new("item_got_port", this);
  endfunction
  

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // item_got = f_sequence_item::type_id::create("item_got");
    if(uvm_config_db#(virtual  ATM_IF)::get(this, "", " ATM_IF_h",  ATM_IF_h))
      `uvm_fatal("monitor2: ", "No vif is found!")
    `uvm_info(get_type_name(), $sformatf("We are in monitor2 build phase"), UVM_LOW)
  endfunction
      
  virtual task run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("We are in monitor2 run_phase"), UVM_LOW)
  endtask
endclass
