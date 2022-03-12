`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Mill
// 
// Create Date: 2019-09-19 09:10
// Design Name: 
// Module Name: key_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 按键消抖，按键状态检测
// 
// 
// Revision: v1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1
module seq_det
(
    input             clk,
    input             key_det_led,//检测状态标记
    input [1:0]       key_in_led,//待检测序列
    input [3:0]       bm,//输入序列
    output reg [3:0]  data
);

    // 4bit data detecte 2 bit sequence，we need compare three numbers
    reg [2:0]flag=0;
    reg      det_en=0;
    
    reg key_det_led_1d=0;
    always @(posedge clk)
    begin
        key_det_led_1d <= `UD key_det_led; 
    end 
    
    always @(posedge clk)
    begin
        if(~key_det_led_1d && key_det_led) //检测按键触发后才进入 按下key4
            det_en <= `UD 1'b1; 
    end 

    always @(posedge clk)
    begin
        if(key_det_led && det_en)
        begin
            flag[0] <= `UD (bm[3:2]==key_in_led); //识别SW4 SW3
            flag[1] <= `UD (bm[2:1]==key_in_led); //识别SW3 SW2
            flag[2] <= `UD (bm[1:0]==key_in_led); //识别SW2 SW1
        end
    end
    
    always @(posedge clk)
    begin
        if(~key_det_led && key_det_led_1d)//检测结束统计结果 再次按下key4
            data <= `UD flag[2] + flag[1] + flag[0];  //所有识别结果显示在smg0上
    end 

endmodule

