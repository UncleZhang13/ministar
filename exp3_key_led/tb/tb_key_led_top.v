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
module tb_key_led_top();

    reg           clk;
    reg           key;

    wire   [7:0]  led;

    always #1 clk = ~clk;
    
    initial begin
        #1 clk = 0;
        // $finish;
    end

    key_led_top key_led_top(
        .clk      (  clk  ),//input          clk,

        .led      (  led  )
    );

endmodule
