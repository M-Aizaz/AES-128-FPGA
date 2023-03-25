`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:10 02/22/2023 
// Design Name: 
// Module Name:    round1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module round1(clk,col_din,key_din,en_col,en_key,dout,enable_out);
input clk,en_col,en_key;
input [7:0] col_din,key_din;
output reg [7:0] dout;
output enable_out;
reg enable_out =1'd0;
reg [7:0] col [0:15];
reg [7:0] key [0:15];
reg [7:0] state =8'd0;
reg[7:0] co =8'd0;
reg[7:0] ca =8'd0;
reg[7:0] cz =8'd0;
always@(posedge clk)begin
case(state)
8'd0:begin
     if(co<=8'd15 && en_col ==1'd1)begin
	     col[co]<= col_din;
		  co<= co+8'd1;
		  end
     if(ca <= 8'd15 && en_key == 1'd1)begin
	     key[ca]<= key_din;
		  ca <= ca+8'd1;
		  end 
else if (co==8'd16 && ca == 8'd16)begin
state <=8'd1;
end
end
8'd1:begin
enable_out<=1'd1;
if(cz <=8'd15)begin
dout <= col[cz] ^key[cz];
cz <= cz +8'd1;
end
else if(cz <= 8'd16)begin
enable_out<=1'd0;
state <= 8'd0;
cz<=8'd0;
ca<=8'd0;
co<=8'd0;

end
end

default : state <=8'd0;
endcase
end
endmodule
