`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Mill
// 
// Create Date: 2019-09-16 19:36
// Design Name: 
// Module Name: div_clk
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 分频得到100khz的时钟，即10ms
// 
// Dependencies: 
// Revision: v1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1
module div_clk
(
    input clk,//27MHz
    output  clk_1khz
);
    //times =27000 : 37ns * 27000 = 1ms -> 1khz;
    reg [14:0]cnt;
    always @(posedge clk)
    begin
        if(cnt == 15'd26999) 
            cnt<= `UD 15'd0;
        else 
            cnt <= `UD cnt + 1'b1;
    end  
    
    reg flag=1'b0;
    always @(posedge clk)
    begin
        if(cnt == 15'd13499) 
            flag <= `UD 1'b1;
        else if(cnt == 15'd26999) 
            flag <= `UD 1'b0;
    end 
    assign clk_1khz = flag;
    // assign clk_1khz = clk; //测试专用

endmodule
