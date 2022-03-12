`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date:   
// Design Name:  tb_water_led_top.v
// Module Name:  
// Project Name: 
// Target Devices: GW1N-UV4LQ144C6/I5
// Tool Versions: GOWIN Version: V1.9.1.01Beta
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
module tb_water_led_top();

    reg           clk;
                
    wire   [7:0]  led;
    wire   [2:0]  ld1;
    wire   [2:0]  ld2;
    wire   [2:0]  ld3;
    wire   [2:0]  ld4;

    always #10 clk = ~clk;
    
    initial
    begin
        clk=0;
    end

    water_led_top water_led_top(
        .clk      (  clk  ),//input          clk,

        .led      (  led  ),//output  [7:0]  led,
        .ld1      (  ld1  ),//output  [2:0]  ld1,
        .ld2      (  ld2  ),//output  [2:0]  ld2,
        .ld3      (  ld3  ),//output  [2:0]  ld3,
        .ld4      (  ld4  ) //output  [2:0]  ld4,
    );

endmodule
