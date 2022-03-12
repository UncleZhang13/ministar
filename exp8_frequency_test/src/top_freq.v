`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Mill
// 
// Create Date: 2019-09-16 19:36
// Design Name: 
// Module Name: top_freq
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 频率测量顶层模块
// 
// Dependencies: 
// Revision: v1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1
module top_freq
(
    input             clk,
    input             key,
    output reg [3:0]  dig,
    output reg [7:0]  smg
);
    parameter CLK_FRE = 26'd27_000_000;
    /*===================================================
                    按键消抖
    ===================================================*/
    wire key_out;

    btn_deb#(                    
        .BTN_WIDTH   (  4'd1                ) , //parameter   BTN_WIDTH = 4'd8
        .MS_20       (  CLK_FRE/7'd50       )
    ) btn_deb_key                           
    (                            
        .clk         (  clk                  ),//input           	clk,
        .btn_in      (  key                  ),//input [BTN_WIDTH-1:0] btn_in,
                  
        .btn_deb     (  key_out              ) //output reg [BTN_WIDTH-1:0]btn_deb
    );
    /*===================================================
                    4个按键的计数
    ===================================================*/
    wire [3:0] key_times;
    key_cnt key0
    (
        .clk        (  clk        ),
        .key        (  key_out    ),
        .key_times  (  key_times  )
    );
    /*===================================================
                    频率的产生和测量
    ===================================================*/
    wire [3:0]seg0;
    wire [3:0]seg1;
    wire [3:0]seg2;
    wire [3:0]seg3;
    
    freq_test #(
        .CLK_FRE     (  CLK_FRE    )
    ) freq_test (
        .clk         (  clk        ),
        .key_times   (  key_times  ),
        .seg0        (  seg0       ),
        .seg1        (  seg1       ),
        .seg2        (  seg2       ),
        .seg3        (  seg3       )
    );
    /*===================================================
                        时钟分频
    ===================================================*/
    wire clk_1khz;
    div_clk div_clk (                              
        .clk        (  clk         ),
        .clk_1khz   (  clk_1khz    )
    );
    /*===================================================
                        数码管显示
    ===================================================*/
    reg  [1:0] sel=0;
    wire [3:0] dig0,dig1,dig2,dig3;
    wire [7:0] smg0,smg1,smg2,smg3;
    
    always @(posedge clk_1khz)
    begin
        sel <= `UD sel+1'b1;
    end 
    //个位
    seq_control seq_control_0
    (
        .sel  (  2'd3  ),
        .key  (  seg0  ),
        .dig  (  dig0  ),
        .smg  (  smg0  )
    );                 

    //十位
    seq_control seq_control_1
    (
        .sel  (  2'd2  ),
        .key  (  seg1  ),
        .dig  (  dig1  ),
        .smg  (  smg1  )
    );

    //百位
    seq_control seq_control_2
    (
        .sel  (  2'd1  ),
        .key  (  seg2  ),
        .dig  (  dig2  ),
        .smg  (  smg2  )
    );

    //千位
    seq_control seq_control_3
    (
        .sel  (  2'd0  ),
        .key  (  seg3  ),
        .dig  (  dig3  ),
        .smg  (  smg3  )
    );

    always @(posedge clk_1khz)
    begin
        if(sel==2'b00)
            dig <= `UD dig0;
        else if(sel==2'b01)
            dig <= `UD dig1;
        else if(sel==2'b10)
            dig <= `UD dig2;
        else if(sel==2'b11)
            dig <= `UD dig3;
    end 

    always @(posedge clk_1khz)
    begin
        if(sel==2'b00)
            smg <= `UD smg0;
        else if(sel==2'b01)
            smg <= `UD smg1;
        else if(sel==2'b10)
            smg <= `UD smg2;
        else if(sel==2'b11)
            smg <= `UD smg3;
    end

endmodule
