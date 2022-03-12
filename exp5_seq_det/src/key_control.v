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
module key_control
(
    input          	clk,	// input clock
    input       	key_det,     // KEY 8 input Key4
    input [1:0]	key_in,    // KEY[2:0] input Key1, Key2
    output reg 	key_det_led,  // LED3 control sigal
    output reg [1:0]	key_in_led,// LED[1:0] control signal
    output reg [1:0]	seq_data   // Sequence to be detected
);

//==按键消斗==========================================
    wire [1:0] key_out;
    wire       key_det_out;
    btn_deb#(                    
        .BTN_WIDTH   (  4'd2                ) , //parameter   BTN_WIDTH = 4'd8
        .MS_20       (  20'd540000          )
    ) btn_deb_key                           
    (                            
        .clk         (  clk                  ),//input           	clk,
        .btn_in      (  key_in              ),//input [BTN_WIDTH-1:0] btn_in,
                  
        .btn_deb     (  key_out             ) //output reg [BTN_WIDTH-1:0]btn_deb
    );

    btn_deb#(                    
        .BTN_WIDTH   (  4'd1                ) , //parameter   BTN_WIDTH = 4'd8
        .MS_20       (  20'd540000          )
    ) btn_deb_det                           
    (                            
        .clk         (  clk                  ),//input           	clk,
        .btn_in      (  key_det               ),//input [BTN_WIDTH-1:0] btn_in,
                  
        .btn_deb     (  key_det_out           ) //output reg [BTN_WIDTH-1:0]btn_deb
    );

    reg [1:0]key_out_reg;
    reg key_det_out_reg;
    
    always @(posedge clk)
    begin
        key_out_reg <= `UD key_out; 
        key_det_out_reg<= `UD key_det_out; 
        key_det_led <= `UD ~key_8_flag;//LED高电平熄灭
    end 
    
    reg key_8_flag = 1'b0;
    always @(posedge clk)
    begin
        if(!key_det_out && key_det_out_reg)  //边沿检测 Key4 是否按下
            key_8_flag <= `UD ~key_8_flag;
        else
            key_8_flag <= `UD key_8_flag;
    end 
    
    reg [1:0]key_flag=2'b00;
    always @(posedge clk)
    begin
        if(~(key_det_led || key_8_flag)) //检测结束，序列复位
            key_flag[0] <= `UD 1'b0;
        else if(!key_out[0] && key_out_reg[0]) //边沿检测 Key1 是否按下
            key_flag[0] <= `UD ~key_flag[0];
        else 
            key_flag[0] <= `UD key_flag[0];
    end 
    
    always @(posedge clk)
    begin
        if(~(key_det_led || key_8_flag))//检测结束，序列复位
            key_flag[1] <= `UD 1'b0;
        else if(!key_out[1] && key_out_reg[1]) //边沿检测 Key2 是否按下
            key_flag[1] <= `UD ~key_flag[1];
        else 
            key_flag[1] <= `UD key_flag[1];
    end 

    always @(posedge clk)
    begin
        key_in_led <= `UD ~key_flag;//LED高电平熄灭
    end
    
    //seq_data
    always @(posedge clk)
    begin
        if(key_8_flag)
            seq_data <= `UD ~key_in_led;
    end

endmodule

