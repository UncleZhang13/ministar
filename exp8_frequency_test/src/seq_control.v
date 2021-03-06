`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Myminieye
// Engineer: Mill
// 
// Create Date: 2019-09-16 19:46
// Design Name: 
// Module Name: seq_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 分频得到100khz的时钟，即10ms
// 
// Dependencies: 
// Revision: v1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define UD #1
module seq_control
(
	input [1:0]sel,
	input [3:0]key,
	output reg [3:0]dig,
	output reg [7:0]smg
);
/*===================================================
					位选择映射
===================================================*/
always @(*)
begin
	case(sel)
		2'd0   :dig = 4'b0001;
		2'd1   :dig = 4'b0010;
		2'd2   :dig = 4'b0100;
		2'd3   :dig = 4'b1000;
		default:dig = 4'b0000;
	endcase
end
//===========================================
//IO_LOC "smg[0]" 1 -> G;
    //IO_LOC "smg[1]" 39 -> F;
    //IO_LOC "smg[2]" 40  -> E;
    //IO_LOC "smg[3]" 41  -> D;
    //IO_LOC "smg[4]" 43 -> C;
    //IO_LOC "smg[5]" 45 -> B;
    //IO_LOC "smg[6]" 47 -> A;
    //IO_LOC "smg[7]" 2  -> P;
//===========================================
// 0 1 2 3 4 5 6 7  
// G F E D C B A P
//共阳极数码管，为0有效，即点亮
//===========================================
always @(*)
begin
	case(key)
		4'd0   :smg = 8'b1000_0001;//"0"  8'b1000_0001
		4'd1   :smg = 8'b1100_1111;//"1"  8'b1100_1111
		4'd2   :smg = 8'b1001_0010;//"2"  8'b1001_0010
		4'd3   :smg = 8'b1000_0110;//"3"  8'b1000_0110
		4'd4   :smg = 8'b1100_1100;//"4"  8'b1100_1100
		4'd5   :smg = 8'b1010_0100;//"5"  8'b1010_0100
		4'd6   :smg = 8'b1010_0000;//"6"  8'b1010_0000
		4'd7   :smg = 8'b1000_1111;//"7"  8'b1000_1111
		4'd8   :smg = 8'b1000_0000;//"8"  8'b1000_0000
		4'd9   :smg = 8'b1000_0100;//"9"  8'b1000_0100
		4'd10  :smg = 8'b1100_0000;//"9"  8'b1000_0100
		default:smg = 8'b0000_0000;		
	endcase
end 

endmodule