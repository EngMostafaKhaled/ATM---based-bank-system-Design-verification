module card_handling #(parameter C_WIDTH = 6,
                                 P_WIDTH = 16,
                                 B_WIDTH = 20)
(
    input wire                        clk,
    input wire                        rst,
    input wire  [C_WIDTH-1:0]         card_number,
    input wire                        card_in,
    input wire                        card_out,

    input wire  [B_WIDTH-1:0]         updated_balance,
	
    output reg  [P_WIDTH-1:0]         password,
    output reg  [B_WIDTH-1:0]         balance,
    output wire                       pass_en    // enable flag to FSM to transit from idle state
);

reg [P_WIDTH-1:0] password_memory [0:9] ;
reg [B_WIDTH-1:0] balance_memory  [0:9] ;



always @ (posedge clk or negedge rst)
begin
    if(!rst)
    begin
        password <= 'b0;
        balance  <= 'b0;
        //pass_en  <= 'b0;
    end
    else 
    begin
        case(card_number)
        6'b110001 : begin
            password <= 'b0011_0011_0111_0000;
            balance  <= 'd2000; //11111010000
            //pass_en  <= 1'b1;
        end

        6'b111011 : begin
            password <= 'b0011_0101_0000_0110;
            balance  <= 'd50000;
            //pass_en  <= 1'b1;
        end

        6'b110011 : begin
            password <= 'b0100_0000_0111_0110;
            balance  <= 'd100000;
            //pass_en  <= 1'b1;
        end

        6'b111110 : begin
            password <= 'b0011_0011_0111_0000;
            balance  <= 'd200000;
            //pass_en  <= 1'b1;
        end

        6'b000111 : begin
            password <= 'b0101_0011_1001_1000;
            balance  <= 'd1000000;
            //pass_en  <= 1'b1;
        end

        default : begin
            password <= 'b0;
            balance  <= 'd0;
            //pass_en  <= 1'b0;
        end
        endcase
    end
end

assign pass_en = card_in ;

endmodule