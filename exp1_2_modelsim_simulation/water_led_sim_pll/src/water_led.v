`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Nill
// 
// Create Date:  2019-09-04 20:22
// Design Name: water_led
// Module Name: water_led
// Project Name: 
// Target Devices: Gowin
// Tool Versions: 
// Description: 
//     make the led on and off
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define UD #1

module water_led(
    input          clk,
    
    output [2:0]   ld1,
    output [2:0]   ld2,
    output [2:0]   ld3,
    output [2:0]   ld4,
    output [7:0]   led
);

    reg [24:0] led_light_cnt = 25'd0;
    reg [ 7:0] led_status = 8'b0000_0001;
    reg [ 11:0] ld_status = 12'b101_101_110_011;
    
    //  time counter
    always @(posedge clk)
    begin
        if(led_light_cnt == 25'd599)//_9999)
            led_light_cnt <= `UD 25'd0;
        else
            led_light_cnt <= `UD led_light_cnt + 25'd1; 
    end

    // led status change
    always @(posedge clk)
    begin
        if(led_light_cnt == 25'd599)//_9999)
            led_status <= `UD {led_status[0],led_status[7:1]};
    end
    
    always @(posedge clk)
    begin
        if(led_light_cnt == 25'd599)//_9999)
        begin
            ld_status <= `UD {ld_status[9],ld_status[11:10],ld_status[6],ld_status[8:7],ld_status[3],ld_status[5:4],ld_status[0],ld_status[2:1]};
        end
    end

    assign led = led_status;
    assign ld1 = ld_status[2:0];
    assign ld2 = ld_status[5:3];
    assign ld3 = ld_status[8:6];
    assign ld4 = ld_status[11:9];

endmodule
