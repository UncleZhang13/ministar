`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Richard
// 
// Create Date:   
// Design Name:  tb_key_led_top.v
// Module Name:  
// Project Name: 
// Target Devices: GW1NSR-LV4CQN48PC7/16
// Tool Versions: GOWIN Version: V1.9.8.03
// Description: 
//      
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define UD #1
module tb_top_seq2();

    reg           clk;
    reg    [3:0]  button;

    wire   [3:0]  dig;
    wire   [7:0]  smg;

    always #1 clk = ~clk;
    
    initial begin
        #1 clk = 0;
    end

    top_seq2 top_seq2(
        .clk      (  clk  ),//input          clk,
        .button   (  button  ),

        .dig      (  dig  ),
        .smg      (  smg  )
    );

endmodule
