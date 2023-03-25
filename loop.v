`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:48:17 03/12/2023 
// Design Name: 
// Module Name:    loop 
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

module loop(clk,round0_in,round1_in,dout,enable_round0,enable_round1,enable_subbyte);
input clk,enable_round0,enable_round1;
input [7:0]round0_in,round1_in;
output reg[7:0] dout;
output reg enable_subbyte;

//assign enable_subbyte= enable_round0 || enable_round1;
always@(posedge clk)begin
enable_subbyte <= enable_round0 || enable_round1;
if(enable_round0==1'd1 && enable_round1 ==0)begin
dout <=round0_in;
//enable_subbyte <= enable_round0;
//enable_subbyte <= 1'd1;
end
//else begin
//enable_subbyte <= 1'd0;end
/*else if(enable_round0==1'd0)begin
enable_subbyte <= enable_round0;
end*/


if(enable_round1==1'd1)begin
dout <= round1_in;
//enable_subbyte <= enable_round1;
//enable_subbyte <= 1'd1;
end
//else begin
//enable_subbyte <= 1'd0; end
/*else if(enable_round1==1'd0)begin
enable_subbyte <= enable_round1;
end*/
end
endmodule
