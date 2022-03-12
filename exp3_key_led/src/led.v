`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date:   
// Design Name:  
// Module Name:  led
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
module led(
    input         clk,//27MHz
    input  [1:0]  ctrl,
                  
    output [7:0]  led
);

    reg [24:0] led_light_cnt = 25'd0;
    reg [ 7:0] led_status = 8'b1000_0000;
    
    //  time counter
    always @(posedge clk)
    begin
        if(led_light_cnt == 25'd1349_9999)
            led_light_cnt <= `UD 25'd0;
        else
            led_light_cnt <= `UD led_light_cnt + 25'd1; 
    end
    
    reg [1:0] ctrl_1d=0;    //保存上一个led状态周期的ctrl值
    always @(posedge clk)
    begin
        if(led_light_cnt == 25'd0)
            ctrl_1d <= ctrl;
    end

    // led status change
    always @(posedge clk)
    begin
        if(led_light_cnt == 25'd1349_9999)//0.5s 周期
        begin
            case(ctrl)
                2'd0 :  //从高位到低位的led流水灯
                begin
                    if(ctrl_1d != ctrl)
                        led_status <= `UD 8'b0111_1111;
                    else
                        led_status <= `UD {led_status[0],led_status[7:1]};
                end
                2'd1 :  //从地位到高位的led流水灯
                begin
                    if(ctrl_1d != ctrl)
                        led_status <= `UD 8'b1111_1110;
                    else
                        led_status <= `UD {led_status[6:0],led_status[7]};
                end
                2'd2 :  //从高位到低位暗灯流水
                begin
                    if(ctrl_1d != ctrl || led_status == 8'b1111_1111)
                        led_status <= `UD 8'b1000_0000;
                    else
                        led_status <= `UD {led_status[0],led_status[7:1]};
                end
            endcase
        end
    end

    assign led = led_status;

endmodule
