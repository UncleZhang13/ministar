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
module tb_key_ctl();

    reg           clk;
    reg           key;

    wire   [1:0]  ctrl;

    always #1 clk = ~clk;
    
    initial begin
        clk = 0;
        key = 0;
        #1080 key = 1;
        #1080 key = 0;
        #1080 key = 1;
        #1080 key = 0;
        #3000 $finish;
    end

    key_ctl key_ctl(
        .clk      (  clk  ),//input          clk,
        .key      (  key  ),

        .ctrl      (  ctrl  )
    );

endmodule
