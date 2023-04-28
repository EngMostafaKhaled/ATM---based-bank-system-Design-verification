`timescale 1ns/1ns
interface ATM_IF #(parameter    P_WIDTH = 16,
                                B_WIDTH = 20, 
							    C_WIDTH = 6);
   //////////////////clock ///////////////////
   bit                        clk ;
   bit                        rst ;
   bit [C_WIDTH-1:0]          card_number;
   bit                        card_in;
   //user_interface inputs 
   
   bit                        button_0;
   bit                        button_1;
   bit                        button_2;
   bit                        button_3;
   bit                        button_4;
   bit                        button_5;
   bit                        button_6;
   bit                        button_7;
   bit                        button_8;
   bit                        button_9;

   bit                        enter_button;
   bit                        cancel_button;
   bit                        correct_button;

   bit                        withdraw_button;
   bit                        deposit_button;
   bit                        show_balance;

   bit                        another_service;

   bit                        English_button;
   bit                        Arabic_button;
   

   bit                        touch_100_button;
   bit                        touch_300_button;
   bit                        touch_500_button;
   bit                        touch_700_button;
   bit                        touch_1000_button;
   bit                        multiple_100_button;
   bit                        multiple_1000_button;

   
   bit     [B_WIDTH-1:0]      actual_deposit_value;

   bit [31:0]                 threshold;
   
   wire  [B_WIDTH-1:0]        updated_balance; 
   wire                       operation_done; 
   wire                       error;
   wire                       wrong_password;


/////////////////////////internal signals////////////////////

    //wire  [B_WIDTH-1:0]  		withdraw_value ;
    //wire  [B_WIDTH-1:0]       chosen_deposit_value;

    wire  [B_WIDTH-1:0]       entry_value;

    //wire  [B_WIDTH-1:0]       updated_balance; //output from ATM_FSM to card_handling
    wire  [P_WIDTH-1:0]       password;//from card_handling to ATM_FSM
    wire  [B_WIDTH-1:0]       balance;//from card_handling to ATM_FSM
    wire                      pass_en;//from card_handling to ATM_FSM


    //user_interface
    wire  [P_WIDTH-1:0]       in_password ; //written password by user is sent to ATM_FSM to check on it and do services
    wire  [1:0]               operation ; //to ATM_FSM to indicate the operation

    //timer inputs 
    wire                       time_out ; //flag to ATM_FSM that time out the card will be executed (go to idle)

    //ATM_FSM
    wire                       start_timer ; // to adjust timer (start running time)
    wire                       restart_timer; //to reset timer between states 

    wire                       card_out ;

    wire     [1:0]             language ;

   
   always #5  clk= !clk ;  

   task Reset_ATM();
        @(negedge clk);
            rst = 1'b1 ;
        @(negedge clk);
            rst = 1'b0 ;
        @(negedge clk);
            rst = 1'b1 ;
            
   endtask : Reset_ATM

  task initialize();
    begin
        clk   = 1'b0 ;

        threshold = 32'd15 ;

        button_0 = 1'b0 ;
        button_1 = 1'b0 ;
        button_2 = 1'b0 ;
        button_3 = 1'b0 ;
        button_4 = 1'b0 ;
        button_5 = 1'b0 ;
        button_6 = 1'b0 ;
        button_7 = 1'b0 ;
        button_8 = 1'b0 ;
        button_9 = 1'b0 ;

        enter_button   = 1'b0 ;
        cancel_button  = 1'b0 ;
        correct_button = 1'b0 ;

        withdraw_button = 1'b0 ;
        deposit_button  = 1'b0 ;
        show_balance    = 1'b0 ;

        another_service = 1'b0 ;
        //withdraw_value       = 'd0;
        actual_deposit_value = 'd0;
        //chosen_deposit_value = 'd0;
    end
    endtask : initialize

    task press_button;
    input [3:0] button;
    begin
        button_0 = 1'b0 ;
        button_1 = 1'b0 ;
        button_2 = 1'b0 ;
        button_3 = 1'b0 ;
        button_4 = 1'b0 ;
        button_5 = 1'b0 ;
        button_6 = 1'b0 ;
        button_7 = 1'b0 ;
        button_8 = 1'b0 ;
        button_9 = 1'b0 ;

        case(button)
        4'd0 : button_0 = 1'b1 ;
        4'd1 : button_1 = 1'b1 ;
        4'd2 : button_2 = 1'b1 ;
        4'd3 : button_3 = 1'b1 ;
        4'd4 : button_4 = 1'b1 ;
        4'd5 : button_5 = 1'b1 ;
        4'd6 : button_6 = 1'b1 ;
        4'd7 : button_7 = 1'b1 ;
        4'd8 : button_8 = 1'b1 ;
        4'd9 : button_9 = 1'b1 ;
        default : begin
            button_0 = 1'b0 ;
            button_1 = 1'b0 ;
            button_2 = 1'b0 ;
            button_3 = 1'b0 ;
            button_4 = 1'b0 ;
            button_5 = 1'b0 ;
            button_6 = 1'b0 ;
            button_7 = 1'b0 ;
            button_8 = 1'b0 ;
            button_9 = 1'b0 ;
        end
        endcase
    end
    endtask : press_button

    task enter();
    begin
        enter_button = 1'b1 ;
        #10
        enter_button = 1'b0 ;
    end
    endtask :enter
     
         task cancel();
    begin
        cancel_button = 1'b1 ;
        #10
        cancel_button = 1'b0 ;
    end
         endtask :cancel


    /////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////// sequences ///////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////

// sequence cancel_cardout;
//     cancel_button & ATM_UVM.DUT.U0_ATM_FSM.card_out; //CARD OUT not in interface
// endsequence

sequence cancel_cardout;
    cancel_button & card_out; //CARD OUT not in interface
endsequence


sequence timeout_cardout;
    ATM_UVM.DUT.U0_ATM_FSM.time_out & ATM_UVM.DUT.U0_ATM_FSM.card_out;
endsequence

sequence cancel_starttimer;
    cancel_button ##1 !ATM_UVM.DUT.U0_ATM_FSM.start_timer; //CARD OUT not in interface
endsequence

sequence timeout_starttimer;
    ATM_UVM.DUT.U0_ATM_FSM.time_out ##1 !ATM_UVM.DUT.U0_ATM_FSM.start_timer;
endsequence

// sequence pass_starttimer;

// pass_en ##1 ATM_UVM.DUT.U0_ATM_FSM.start_timer ##[1:threshold] !ATM_UVM.DUT.U0_ATM_FSM.start_timer;
// endsequence


    /////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////// properties ///////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////

property cancel_cardout_property;
    @(posedge clk) disable iff(!rst) $rose(cancel_button) |-> cancel_cardout;
endproperty

// property timeout_cardout_property;
//     @(posedge clk) disable iff(!rst) $rose(ATM_UVM.DUT.U0_ATM_FSM.time_out) |-> timeout_cardout;
// endproperty

// property cancel_starttimer_property;
//     @(posedge clk) disable iff(!rst) $rose(cancel_button) |->  cancel_starttimer;
// endproperty




    /////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////// assertions ///////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////


cancel_cardout_assert: assert property(cancel_cardout_property) $display("succeed"); else $error("failed");
// timeout_cardout_assert: assert property(timeout_cardout_property) $display("succeed"); else $error("failed");
// cancel_starttimer_assert: assert property(cancel_starttimer_property) $display("succeed"); else $error("failed");





endinterface : ATM_IF