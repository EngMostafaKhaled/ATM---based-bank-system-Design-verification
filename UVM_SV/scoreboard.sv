class scoreboard extends uvm_scoreboard;
  // uvm_analysis_imp#(f_sequence_item, scoreboard) item_got_export;
  `uvm_component_utils(scoreboard)
  
  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    // item_got_export = new("item_got_export", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("We are in scoreboard build phase"), UVM_LOW)
  endfunction
  
endclass