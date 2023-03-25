`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:18 02/26/2023 
// Design Name: 
// Module Name:    ShiftRow 
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
module ShiftRow(clk,din,en_din,en_dout,dout,row);
input clk,en_din;
input [7:0] din;
output en_dout;
output reg[7:0] dout;
output[7:0] row;
reg [7:0] row=8'd0;
reg en_dout = 1'd0;
reg [7:0] state =8'd0;
reg [7:0] co =8'd0;
reg [7:0] mem_row [0:15];
reg [7:0] mem_shift [0:15];
always@(posedge clk)begin
case(state)
8'd0: begin
if(en_din == 1'd1)begin
state <= 8'd1;
end
end

8'd1: begin
if(co<=8'd15)begin
mem_row[co]<= din;
co <= co +8'd1;
end
else if(co==8'd16)begin
state <= 8'd2;
co <=8'd0;
end
end

8'd2: begin 
if(co<=8'd3)begin
     mem_shift[co] <=mem_row[co];
     co <= co +8'd1;
end

else if(co==8'd4)begin
     mem_shift[co+3] <=mem_row[co];
     co <= co +8'd1;
end

else if(co>=8'd5 && co<= 8'd7)begin
     mem_shift[co-1] <=mem_row[co];
     co <= co +8'd1;
end

else if(co>=8'd8 && co<= 8'd9)begin
     mem_shift[co+2] <=mem_row[co];
     co <= co +8'd1;
end

else if(co>=8'd10 && co<= 8'd11)begin
     mem_shift[co-2] <=mem_row[co];
     co <= co +8'd1;
end

else if(co>=8'd12 && co<= 8'd14)begin
     mem_shift[co+1] <=mem_row[co];
     co <= co +8'd1;
end

else if(co==8'd15)begin
     mem_shift[co-3] <=mem_row[co];
     co <= co +8'd1;
end


else if(co==8'd16)begin
state <=8'd3;
co <= 8'd0;
end
end
8'd3: begin

if(co<=8'd15)begin
en_dout <= 1'd1;
dout<= mem_shift[co];
co <= co +8'd1;
end
else if(co==8'd16)begin
en_dout <= 1'd0;
state<=8'd0;
co <=8'd0;
row =row +8'd1;
end
end
 
default : state <=8'd0;
endcase
end

endmodule
