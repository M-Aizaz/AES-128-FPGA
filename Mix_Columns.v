`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:47:26 02/27/2023 
// Design Name: 
// Module Name:    Mix_Columns 
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
module Mix_Columns(clk,din,dout,en,enable_out,rowNo);
input clk,en;
input [7:0] din ,rowNo;
output reg [7:0] dout;
output enable_out;
reg enable_out =1'd0;
reg[7:0] c=8'd0;
reg [7:0] mem_din [0:15];
reg [7:0] mem_col [0:15];
reg[7:0] state = 8'd0;
reg[7:0] c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
reg[7:0] p0,p1,p2,p3;
reg[7:0] cs=8'd0;
reg[7:0] co=8'd0;
reg[7:0] cor=8'd0;
always@(posedge clk)begin
case(state)
8'd0:begin
if(c<=8'd15 && en==1'd1 && rowNo <= 8'd8)begin
 mem_din[c] <= din;
 c <= c +1'd1;
end
else if (c== 8'd16)begin
state<= 8'd1;
end
if(cor<=8'd15 && en==1'd1 && rowNo == 8'd9)begin
mem_din[cor] <= din;
 cor <= cor +1'd1;
end
else if (cor== 8'd16)begin
state<= 8'd3;
end
end

8'd1:begin
if(cs<=8'd4)begin
if(mem_din[cs] > 8'd127)begin
   c0 <= (mem_din[cs]<<1) ^ 8'h1b;
end
else begin
c0<=mem_din[cs]<<1;
end

c1<=mem_din[cs+8'd12];
c2<=mem_din[cs+8'd8];
if(mem_din[cs+8'd4] > 8'd127)begin
c3 <= (mem_din[cs +8'd4]<<1) ^ 8'h1b ^mem_din[cs+4];
end
else begin
c3 <= (mem_din[cs+8'd4]<<1)^mem_din[cs+8'd4];
end
p0=c0^c1^c2^c3;
////////////pos1////////////////////
 c4<= mem_din[cs];
////////////////////2///////////////////	  
	if(mem_din[cs+4] > 8'd127)begin
       c5 <= (mem_din[cs+4]<<1) ^ 8'h1b;
      end
else begin
      c5<=mem_din[cs+4]<<1;
end  
////////////////3////////////////////////
if(mem_din[cs+8] > 8'd127)begin
c6 <= (mem_din[cs+8]<<1) ^ 8'h1b ^mem_din[cs+8];
end
else begin
c6 <= (mem_din[cs+8]<<1)^mem_din[cs+8];
end

c7 <= mem_din[cs+12];

p1=c4^c5^c6^c7;
////////////pos1////////////////////
////////////pos2////////////////////

c8<= mem_din[cs];
c9<= mem_din[cs+4];
////////////////////2///////////////////	  
	if(mem_din[cs+8] > 8'd127)begin
       c10 <= (mem_din[cs+8]<<1) ^ 8'h1b;
      end
else begin
      c10<=mem_din[cs+8]<<1;
end  
////////////////3////////////////////////
if(mem_din[cs+12] > 8'd127)begin
c11 <= (mem_din[cs+12]<<1) ^ 8'h1b ^mem_din[cs+12];
end
else begin
c11 <= (mem_din[cs+12]<<1)^mem_din[cs+12];
end
p2=c8^c9^c10^c11;
////////////pos2////////////////////
////////////pos3////////////////////

////////////////3////////////////////////
if(mem_din[cs] > 8'd127)begin
c12 <= (mem_din[cs]<<1) ^ 8'h1b ^mem_din[cs];
end
else begin
c12 <= (mem_din[cs]<<1)^mem_din[cs];
end

c13<= mem_din[cs+4];
c14<= mem_din[cs+8];
////////////////////2///////////////////	  
	if(mem_din[cs+12] > 8'd127)begin
       c15 <= (mem_din[cs+12]<<1) ^ 8'h1b;
      end
else begin
      c15<=mem_din[cs+12]<<1;
end
p3=c12^c13^c14^c15;
 mem_col[cs-1] <= p0;
mem_col[cs+4-1] <= p1; 
mem_col[cs+8-1] <= p2; 
mem_col[cs+12-1] <= p3; 
 cs = cs +8'd1;
 if (cs == 8'd5)begin
 state <=8'd2;
 end
 end
 end
8'd2:begin
  enable_out =1'd1;
  if(co<=8'd15)begin
  dout <= mem_col[co];
  co <= co +8'd1;
  end
  else if (co<= 8'd16)begin
  enable_out =1'd0;
  state <=8'd0;
  co<=8'd0;
  cs=8'd0;
  c<=8'd0;
  end
  
  end
8'd3:begin
  enable_out =1'd1;
  if(co<=8'd15)begin
  dout <= mem_din[co];
  co <= co +8'd1;
  end
else if (co<= 8'd16)begin
  enable_out =1'd0;
  end
  end

default : state <=8'd0;
endcase
end
endmodule
