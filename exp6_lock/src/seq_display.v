`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date:   
// Design Name:  
// Module Name:  
// Project Name: 
// Target Devices: Gowin
// Tool Versions: 
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
module seq_display(
    input               clk,
    input               enter_trig,
    input               init_trig,
    input               com_result,
    input       [3:0]   ctrl,
    
    output reg  [7:0]   smg,
    output reg  [3:0]   dig
);

    //============================================================================
    //显示状态区分
    reg      seq_status= 1'b0;
    always @(posedge clk)
    begin
        if(enter_trig)
            seq_status <= `UD 1'b1;
        else if(init_trig)
            seq_status <= `UD 1'b0;
    end
    
    //============================================================================
    //数码管显示荣控制
    reg [3:0] key0_cnt=4'd0,key1_cnt=4'd0,key2_cnt=4'd0,key3_cnt=4'd0;
    always @(posedge clk)
    begin
        if(seq_status) //输入的密码状态
        begin
            if(com_result) //如果正确显示8888，否则显示7777
            begin
                key0_cnt <= `UD 4'd8;
                key1_cnt <= `UD 4'd8;
                key2_cnt <= `UD 4'd8;
                key3_cnt <= `UD 4'd8;
            end
            else
            begin
                key0_cnt <= `UD 4'd7;
                key1_cnt <= `UD 4'd7;
                key2_cnt <= `UD 4'd7;
                key3_cnt <= `UD 4'd7;
            end
        end
        else
        begin
            key0_cnt <= `UD {2'd0,ctrl[1:0]};
            key1_cnt <= `UD {2'd0,ctrl[3:2]};
            key2_cnt <= `UD 4'd0;
            key3_cnt <= `UD 4'd0;
        end
    end

    /*===================================================
                        时钟分频
    ===================================================*/
    wire clk_1khz;
    div_clk div_clk
    (
        .clk        (clk),
        .clk_1khz   (clk_1khz)
    );
    /*===================================================
                        数码管显示
    ===================================================*/
    reg  [1:0]sel=0;
    wire [3:0]dig0,dig1,dig2,dig3;
    wire [7:0]smg0,smg1,smg2,smg3;
    
    always @(posedge clk_1khz)
    begin
        sel <= `UD sel+1'b1;
    end 
    
    seq_control seq_control_0
    (
        .sel(2'd3),
        .key(key0_cnt),
        .dig(dig0),
        .smg(smg0)
    );

    seq_control seq_control_1
    (
        .sel(2'd2),
        .key(key1_cnt),
        .dig(dig1),
        .smg(smg1)
    );

    seq_control seq_control_2
    (
        .sel(2'd1),
        .key(key2_cnt),
        .dig(dig2),
        .smg(smg2)
    );

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
