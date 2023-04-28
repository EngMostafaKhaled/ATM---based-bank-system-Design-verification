class test extends uvm_test;

  ATM_sequence_enter ATM_sequence_enter_h ;
  ATM_sequence_balance ATM_sequence_balance_h ;
  // ATM_sequence_withdraw ATM_sequence_withdraw_h ;
  // ATM_sequence_deposit ATM_sequence_deposit_h ;

  ATM_env ATM_env_h;
  virtual ATM_IF ATM_IF_h;
  `uvm_component_utils(test)
  
  function new(string name = "test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual ATM_IF)::get(this, "", "ATM_IF_h", ATM_IF_h))
      `uvm_fatal("Driver_Data: ", "No vif is found!")
    
  
    ATM_sequence_enter_h = ATM_sequence_enter::type_id::create("ATM_sequence_enter_h", this);
    ATM_sequence_balance_h = ATM_sequence_balance::type_id::create("ATM_sequence_balance_h", this);
    // ATM_sequence_withdraw_h = ATM_sequence_withdraw::type_id::create("ATM_sequence_withdraw_h", this);
    // ATM_sequence_deposit_h = ATM_sequence_deposit::type_id::create("ATM_sequence_deposit_h", this);

    ATM_env_h = ATM_env::type_id::create("ATM_env_h", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("We are in test run_phase"), UVM_LOW)
       `uvm_info(get_type_name(), $sformatf("before initialize from UVM"), UVM_LOW)
    ATM_IF_h.initialize();
    `uvm_info(get_type_name(), $sformatf("after initialize from UVM"), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("before reset from UVM"), UVM_LOW)
    ATM_IF_h.Reset_ATM();
    `uvm_info(get_type_name(), $sformatf("after reset from UVM"), UVM_LOW)
 

    ATM_sequence_enter_h.start(ATM_env_h.agent1_h.sequencer_h);
    ATM_sequence_balance_h.start(ATM_env_h.agent1_h.sequencer_h);
    // ATM_sequence_withdraw_h.start(ATM_env_h.agent1_h.sequencer_h);
    // ATM_sequence_deposit_h.start(ATM_env_h.agent1_h.sequencer_h);
   
    phase.drop_objection(this);
    
  endtask
  
endclass
