`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Mill
// 
// Create Date: 2019-09-20 10:19
// Design Name: 
// Module Name: watch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 数字时钟
// 
// Dependencies: 
// Revision: v1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1
module top_watch
(
    input        clk,
    input  [2:0] key,
    output       led,
    output [3:0] dig,
    output [7:0] smg
);

    parameter CLK_FRE = 26'd27_000_000;
    /*===================================================
                    复位信号的产生
    ===================================================*/
    reg [4:0] rstn_cnt=0;
    always @(posedge clk)
    begin
        if(rstn_cnt==5'h1f)
            rstn_cnt <= `UD rstn_cnt;
        else 
            rstn_cnt <= `UD rstn_cnt + 1'b1;
    end 
    
    wire rstn;
    assign rstn = rstn_cnt[4];
    
    /*===================================================
                        数字时钟的产生和控制
    ===================================================*/
    wire [3:0] hour_h,hour_l,minutes_h,minutes_l;
    wire [2:0] dig_ctl;
    wire       sec;
    watch_data_gen #(
        .CLK_FRE       (  CLK_FRE     )                                       
    ) u_watch_data_gen                                                        
    (                                                                         
        .clk           (  clk         ), //input clk,                         
        .rstn          (  rstn        ), //input rstn,                       
        .key           (  key         ), //input [2:0]key,                    
        .hour_h_o      (  hour_h      ), //output reg [3:0]hour_h_o,         
        .hour_l_o      (  hour_l      ), //output reg [3:0]hour_l_o,         
        .minutes_h_o   (  minutes_h   ), //output reg [3:0]minutes_h_o,       
        .minutes_l_o   (  minutes_l   ), //output reg [3:0]minutes_l_o,       
        .second_led    (  sec         ), //output reg second_led,             
        .state_flag    (  dig_ctl     )  //output reg [2:0]state_flag         
    );
    assign led = sec;

    display_ctl display_ctl    (                                                                                    
         .clk           (  clk        ),//input             clk,                         
         .dig_ctl       (  dig_ctl    ),//input      [2:0]  dig_ctl,                     
         .hour_h        (  hour_h     ),//input      [3:0]  hour_h,                      
         .hour_l        (  hour_l     ),//input      [3:0]  hour_l,                      
         .minutes_h     (  minutes_h  ),//input      [3:0]  minutes_h,                   
         .minutes_l     (  minutes_l  ),//input [3:0]       minutes_l,                    
         .sec_en        (  sec        ),//input              sec_en,                     
                                                                                         
         .dig           (  dig        ),//output reg [3:0]  dig,                         
         .smg           (  smg        ) //output reg [7:0]  smg                          
    );

endmodule
