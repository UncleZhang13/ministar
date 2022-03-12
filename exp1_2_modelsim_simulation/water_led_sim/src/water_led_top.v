`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date:   
// Design Name:  runber_test.v
// Module Name:  
// Project Name: 
// Target Devices: GW1N
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
module water_led_top(
    input          clk,
    
    output  [7:0]  led,
    output  [2:0]  ld1,
    output  [2:0]  ld2,
    output  [2:0]  ld3,
    output  [2:0]  ld4
);

    wire sys_clk;
    
//    sys_pll sys_pll(
//        .clkout    (  sys_clk  ),//output clkout
//        .clkin     (  clk      ) //input clkin
//    );
    
    water_led water_led(
        .clk           (  clk  ),//input          clk,
            
        .led           (  led  ),//output  [7:0]  led,
        .ld1           (  ld1  ),//output  [2:0]  ld1,
        .ld2           (  ld2  ),//output  [2:0]  ld2,
        .ld3           (  ld3  ),//output  [2:0]  ld3,
        .ld4           (  ld4  ) //output  [2:0]  ld4 
    );

endmodule
