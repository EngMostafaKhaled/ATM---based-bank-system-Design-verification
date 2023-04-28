class ATM_sequence_item extends uvm_sequence_item;

  rand     int                mode;
/////////////////////////rand///////////////////////////////////

  `uvm_object_utils(ATM_sequence_item)
  function new(string name = "ATM_sequence_item");
    super.new(name);
  endfunction

endclass

