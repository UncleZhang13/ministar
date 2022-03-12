`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Mill
// 
// Create Date: 2019-09-20 10:19
// Design Name: 
// Module Name: display_ctl
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
module display_ctl #(
     parameter      CLK_FRE = 26'd12_000_000
)
(
     input             clk,
     input      [2:0]  dig_ctl,
     input      [3:0]  hour_h,
     input      [3:0]  hour_l,
     input      [3:0]  minutes_h,
     input      [3:0]  minutes_l,
     input             sec_en,
     
     output reg [3:0]  dig,
     output reg [7:0]  smg
);
    
    /*===================================================
                        时钟分频
    ===================================================*/
    wire clk_1khz;
    div_clk div_clk (                              
        .clk        (  clk         ),
        .clk_1khz   (  clk_1khz   )
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
    
    seq_control seq_control_0
    (
        .clk           (  clk        ),                   
        .sec_en        (  sec_en     ),                   
        .control_dig   (  dig_ctl    ),                   
        .sel           (  2'd0       ),                   
        .key           (  hour_h     ),                   
        .dig           (  dig0       ),                   
        .smg           (  smg0       )                    
    );                                                    
                                                          
    wire [3:0]dig1;                                       
    wire [7:0]smg1;                                       
                                                          
    seq_control seq_control_1                             
    (                                                     
        .clk           (  clk        ),                   
        .sec_en        (  sec_en     ),                   
        .control_dig   (  dig_ctl    ),                   
        .sel           (  2'd1       ),                   
        .key           (  hour_l     ),                   
        .dig           (  dig1       ),                   
        .smg           (  smg1       )                    
    );                                                  
                                                        
    wire [3:0]dig2;                                     
    wire [7:0]smg2;                                     
                                                        
    seq_control seq_control_2                           
    (                                                   
        .clk           (  clk        ),                   
        .sec_en        (  sec_en     ),                   
        .control_dig   (  dig_ctl    ),                   
        .sel           (  2'd2       ),                   
        .key           (  minutes_h  ),                   
        .dig           (  dig2       ),                   
        .smg           (  smg2       )                    
    );                                                    
                                                          
    wire [3:0]dig3;                                       
    wire [7:0]smg3;                                       
                                                          
    seq_control seq_control_3                             
    (                                                     
        .clk          (  clk         ),                   
        .sec_en       (  sec_en      ),                   
        .control_dig  (  dig_ctl     ),                   
        .sel          (  2'd3        ),                   
        .key          (  minutes_l   ),                   
        .dig          (  dig3        ),                   
        .smg          (  smg3        )                    
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
