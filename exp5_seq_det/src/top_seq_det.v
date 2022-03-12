`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Mill
// 
// Create Date: 2019-09-19 09:06
// Design Name: 
// Module Name: top_seq_det
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 序列检测
// 
// 
// Revision: v1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1
module top_seq_det
(
    input 		clk,	// input clock
    input 		key_det,	// KEY 4 input control detected enable
    input [1:0]	key_in,	// KEY[1:0] input control detected sequence
    input [3:0]	bm,	// DIP Switch[3:0] input used to detecting
    output 		key_det_led, // display the detecte status
    output [1:0]	key_in_led,	// display the detected sequence
    output reg [3:0]	dig,	// output Digital tube Bit selection
    output reg [7:0]	smg	// output Digital tube segment selection
);

    /*===================================================
                        按键消斗及状态标记
    ===================================================*/
    wire [1:0]seq_data;
    key_control key_control
    (
        .clk    		(  clk        	    ),
        .key_det   		(  key_det      	),
        .key_in  		(  key_in     	    ),
        .key_det_led   	(  key_det_led   	),
        .key_in_led 	(  key_in_led[1:0]	),
        .seq_data		(  seq_data   	    )
    );
    
    /*===================================================
                        序列检测
    ===================================================*/
    wire [3:0]data;
    
    seq_det seq_det (
        .clk        	(  clk     	    ),
        .key_det_led  	(  ~key_det_led	),//检测状态标记
        .key_in_led 	(  seq_data	    ),//待检测序列
        .bm         	(  bm     	    ),//输入序列
        .data       	(  data    	    )
    );
    /*===================================================
                        时钟分频
    ===================================================*/
    wire clk_100khz;
    div_clk div_clk(
        .clk        	(  clk       	),
        .clk_1khz 	    (  clk_1khz	    )
    );
    /*===================================================
                        数码管显示
    ===================================================*/
    reg  [1:0]sel=0;
    wire [3:0]dig0;
    wire [7:0]smg0;
    
    always @(posedge clk_1khz)
    begin
        sel <= `UD sel+1'b1;
    end 
    // Digital Tube 0 output
    seq_control seq_control_0(
        .sel(sel),
        .key(data),
        .dig(dig0),
        .smg(smg0)
    );
    // Digital Tube 1 output
    wire [3:0]dig1;
    wire [7:0]smg1;
    seq_control seq_control_1
    (
        .sel(sel),
        .key(4'd0), //不显示
        .dig(dig1),
        .smg(smg1)
    );
    // Digital Tube 2 output
    wire [3:0]dig2;
    wire [7:0]smg2;
    seq_control seq_control_2
    (
        .sel(sel),
        .key(4'd0), //不显示
        .dig(dig2),
        .smg(smg2)
    );
    wire [3:0]dig3;
    wire [7:0]smg3; // Digital Tube 3 output
    seq_control seq_control_3
    (
        .sel(sel),
        .key(4'd0), //不显示
        .dig(dig3),
        .smg(smg3)
    );
    // display by Digital Tube
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
