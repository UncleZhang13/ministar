`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Mill
// 
// Create Date: 2019-09-16 19:11
// Design Name: 
// Module Name: seq
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 四个数码管显示不同的数字，按键KEY0控制第一个数码管，
//        按一下数字加1，从0到9，按键KEY1控制第二个数码管，按一下数字加1，
//        从0到9，按键KEY2控制第三个数码管，按键KEY3控制第四个数码管。
// 
// Revision: v1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1
module top_seq2
(
	input clk,//27MHZ
	input [3:0]button,
	output reg [3:0]dig,
	output reg [7:0]smg
);

    /*===================================================
    					按键消斗
    ===================================================*/
    wire [3:0] key;
    
    btn_deb#(                    
        .BTN_WIDTH   (  4'd4        ), //parameter                  BTN_WIDTH = 4'd8
        .MS_20       (  20'd540000  ) //原值为20'd540000 测试时修改为20'd540
    ) U_btn_deb                           
    (                            
        .clk         (  clk         ),//input                      clk,
        .btn_in      (  button      ),//input      [BTN_WIDTH-1:0] btn_in,
                                    
        .btn_deb     (  key         ) //output reg [BTN_WIDTH-1:0] btn_deb
    );
    /*===================================================
    					4个按键的计数
    ===================================================*/
    wire [3:0] key0_cnt;
    key_cnt key0
    (
    	.clk(clk),
    	.key(key[0]),
    	.key_times(key0_cnt)
    );
    
    wire [3:0] key1_cnt;
    key_cnt key1
    (
    	.clk(clk),
    	.key(key[1]),
    	.key_times(key1_cnt)
    );
    
    wire [3:0] key2_cnt;
    key_cnt key2
    (
    	.clk(clk),
    	.key(key[2]),
    	.key_times(key2_cnt)
    );
    
    wire [3:0] key3_cnt;
    key_cnt key3
    (
    	.clk(clk),
    	.key(key[3]),
    	.key_times(key3_cnt)
    );
    /*===================================================
    					时钟分频
    ===================================================*/
    wire clk_1khz;
    div_clk div_clk
    (
    	.clk		(clk),
    	.clk_1khz   (clk_1khz)
    );
    /*===================================================
    					数码管显示
    ===================================================*/
    reg  [1:0]sel=0;
    wire [3:0]dig0;
    wire [7:0]smg0;
    
    always @(posedge clk_1khz)
    begin
    	sel <= sel+1'b1;
    end 
    
    seq_control seq_control_0
    (
    	.sel(2'd3),
    	.key(key0_cnt),
    	.dig(dig0),
    	.smg(smg0)
    );
    
    wire [3:0]dig1;
    wire [7:0]smg1;
    
    seq_control seq_control_1
    (
    	.sel(2'd2),
    	.key(key1_cnt),
    	.dig(dig1),
    	.smg(smg1)
    );
    
    wire [3:0]dig2;
    wire [7:0]smg2;
    
    seq_control seq_control_2
    (
    	.sel(2'd1),
    	.key(key2_cnt),
    	.dig(dig2),
    	.smg(smg2)
    );
    
    wire [3:0]dig3;
    wire [7:0]smg3;
    
    seq_control seq_control_3
    (
    	.sel(2'd0),
    	.key(key3_cnt),
    	.dig(dig3),
    	.smg(smg3)
    );
    
    
    always @(posedge clk_1khz)
    begin
    	if(sel==2'b00)
    		dig <= dig0;
    	else if(sel==2'b01)
    		dig <= dig1;
    	else if(sel==2'b10)
    		dig <= dig2;
    	else if(sel==2'b11)
    		dig <= dig3;
    end 
    
    
    always @(posedge clk_1khz)
    begin
    	if(sel==2'b00)
    		smg <= smg0;
    	else if(sel==2'b01)
    		smg <= smg1;
    	else if(sel==2'b10)
    		smg <= smg2;
    	else if(sel==2'b11)
    		smg <= smg3;
    end

endmodule 
