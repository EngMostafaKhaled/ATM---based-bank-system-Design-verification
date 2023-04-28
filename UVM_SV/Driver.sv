`timescale 1ns/100ps
class Driver extends uvm_driver#(ATM_sequence_item);
  virtual ATM_IF ATM_IF_h;
  ATM_sequence_item cmd;
  // time  variable_delay  = 0ns ;
  // time  fixed_delay     = 0ns ;
  // time  total_delay     = 0ns ;
  `uvm_component_utils(Driver)
  
  function new(string name = "Driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual ATM_IF)::get(this, "", "ATM_IF_h", ATM_IF_h))
      `uvm_fatal("Driver: ", "No vif is found!")
    `uvm_info(get_type_name(), $sformatf("We are in Driver build phase"), UVM_LOW)
  endfunction

  virtual task run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("We are in Driver run_phase"), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("We are in run phase of driver after seq item port ") , UVM_LOW)
    forever begin  
      seq_item_port.get_next_item(cmd);
     if(cmd.mode == 1)
     begin
         `uvm_info(get_type_name(), $sformatf("enter mode started , mode =%d",cmd.mode) , UVM_LOW)
         @(posedge ATM_IF_h.clk)
         #5ns
         ATM_IF_h.card_number = 6'b111011 ;
         ATM_IF_h.card_in = 1'b1 ;
         #10ns
         ATM_IF_h.card_in = 1'b0 ;
         #20ns  
         ATM_IF_h.English_button = 1'b1 ;
         #10
         ATM_IF_h.English_button = 1'b0 ;
         #20ns
      //in_password  = 'b0100_0000_0111_0110 ;
          ATM_IF_h.press_button(4'd3);
          #10ns;
          ATM_IF_h.press_button(4'd5);
          #10ns;
          ATM_IF_h.press_button(4'd0);
          #10ns;
          ATM_IF_h.press_button(4'd6);
          #10ns;
          ATM_IF_h.press_button(4'd11);
          ATM_IF_h.enter();
          #20ns; 
     end
    else if(cmd.mode == 2)begin
        `uvm_info(get_type_name(), $sformatf("balance mode started , mode =%d",cmd.mode) , UVM_LOW)
         @(posedge ATM_IF_h.clk)
               //**********   SHOW BALANCE   ****************
       ATM_IF_h.show_balance = 1'b1 ;
       #10ns;
       ATM_IF_h.show_balance = 1'b0 ;
       #17ns;

       ATM_IF_h.cancel();
    end

    else if(cmd.mode == 3)begin
      `uvm_info(get_type_name(), $sformatf("deposit mode started , mode =%d",cmd.mode) , UVM_LOW)
         @(posedge ATM_IF_h.clk)
        
                           //**********   DEPOSIT OPERATION --> WRONG ****************
        ATM_IF_h.deposit_button = 1'b1 ;
        #10ns;
        ATM_IF_h.deposit_button = 1'b0 ;
        #10ns;
        ATM_IF_h.actual_deposit_value = 'd2000 ;
        //chosen_deposit_value = 'd1000 ;
        #10ns;
        ATM_IF_h.multiple_1000_button = 1'b1 ;
        #10ns;
        ATM_IF_h.multiple_1000_button = 1'b0 ;
        #10ns;
        ATM_IF_h.press_button('d3);
        #10ns; 
        ATM_IF_h.press_button('d11);

        //deposit_value = 'd2000 ;
        ATM_IF_h.enter();
        #30ns;

        // @(posedge ATM_IF_h.clk)
        //          ATM_IF_h.another_service = 1'b1;
        //         #10;
        //          ATM_IF_h.another_service = 1'b0 ;
        //         #20;
    end

    else if(cmd.mode == 4)begin
          `uvm_info(get_type_name(), $sformatf("withdraw mode started , mode =%d",cmd.mode) , UVM_LOW)
             @(posedge ATM_IF_h.clk)
             ATM_IF_h.withdraw_button = 1'b1 ;
            #10ns;
            ATM_IF_h.withdraw_button = 1'b0 ;

            #10ns;
            ATM_IF_h.multiple_1000_button = 1'b1 ;
            #10ns;
            ATM_IF_h.multiple_1000_button = 1'b0 ;

            #10ns;
            ATM_IF_h.press_button('d5);
            #10ns;
            ATM_IF_h.press_button('d11);
            //withdraw_value = 'd2000 ;
            ATM_IF_h.enter();
            #30ns;
// @(posedge ATM_IF_h.clk)
//                  ATM_IF_h.another_service = 1'b1;
//                 #10;
//                  ATM_IF_h.another_service = 1'b0 ;
//                 #20;
    end

    else 
         `uvm_info(get_type_name(), $sformatf("invalid operation mode , mode= %d",cmd.mode) , UVM_LOW)  
    seq_item_port.item_done();
    end

  endtask
  
endclass
  