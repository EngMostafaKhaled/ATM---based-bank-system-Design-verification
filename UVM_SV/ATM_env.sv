class ATM_env extends uvm_env;

  ///////////////// declarations of agents and scoreboard /////////////////////
  agent1            agent1_h ;
  agent2            agent2_h ;
  scoreboard        scoreboard_h ;
  // coverage          coverage_h;
  ////////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(ATM_env)
  
  function new(string name = "ATM_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("We are in enviroment build phase"), UVM_LOW) 
    agent1_h        = agent1::type_id::create("agent1_h", this);
    agent2_h        = agent2::type_id::create("agent2_h", this);
    // coverage_h      = coverage::type_id::create("coverage_h", this);
    scoreboard_h    = scoreboard::type_id::create("scoreboard_h", this);
  endfunction
  
  /////////////////// need to be updated ////////////////////////////
  virtual function void connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("We are in enviroment connect phase"), UVM_LOW)
    // f_agt.f_mon.item_got_port.connect(scoreboard_h.item_got_export);
  endfunction
  
endclass

