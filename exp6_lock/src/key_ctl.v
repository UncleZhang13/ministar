`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date:   
// Design Name:  
// Module Name: key_ctl 
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
module key_ctl(
    input            clk,
    input      [1:0] key,
    input            enter,
    input            init,
    
    output           enter_trig,
    output           init_trig,
    output     [3:0] ctrl
);

    wire [3:0] btn_deb;
    // °´¼üÏû¶¶
    btn_deb#(                    
        .BTN_WIDTH   (  4'd4                ) , //parameter   BTN_WIDTH = 4'd8
        .MS_20       (  20'd540000          )
    ) btn_deb_key                           
    (                            
        .clk         (  clk                  ),//input           	clk,
        .btn_in      (  {enter,init,key}     ),//input [BTN_WIDTH-1:0] btn_in,
                  
        .btn_deb     (  btn_deb              ) //output reg [BTN_WIDTH-1:0]btn_deb
    );

    reg [1:0]  key1_push_cnt=2'd0;
    reg [1:0]  key2_push_cnt=2'd0;
    
    reg btn1_deb_1d,btn2_deb_1d;
    reg enter_deb_1d,init_deb_1d;
    
    assign enter_trig = ~btn_deb[3] & enter_deb_1d;
    assign init_trig = ~btn_deb[2] & init_deb_1d;

    always @(posedge clk)
    begin
        btn1_deb_1d  <= `UD btn_deb[0]; //Key1
        btn2_deb_1d  <= `UD btn_deb[1]; //Key2
        init_deb_1d  <= `UD btn_deb[2]; //Key3
        enter_deb_1d <= `UD btn_deb[3]; //Key4
    end

    always @(posedge clk)
    begin
        if(~btn_deb[2] & init_deb_1d) //?????Key3
            key1_push_cnt <= `UD 2'd0;
        else if(~btn_deb[0] & btn1_deb_1d) //Key1 ??+1
        begin
            key1_push_cnt <= `UD key1_push_cnt + 2'd1;
        end
    end
    
    always @(posedge clk)
    begin
        if(~btn_deb[2] & init_deb_1d) //?????Key3
            key2_push_cnt <= `UD 2'd0;
        else if(~btn_deb[1] & btn2_deb_1d) //Key2 ??+1
        begin
            key2_push_cnt <= `UD key2_push_cnt + 2'd1;
        end
    end

    assign ctrl = {key2_push_cnt,key1_push_cnt}; //Key1 ? Key2??

endmodule
