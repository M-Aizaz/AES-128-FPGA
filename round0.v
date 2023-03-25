`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:33:15 02/22/2023 
// Design Name: 
// Module Name:    round0 
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
module round0(clk,din,key,en,round0);
input clk;
input [7:0] din,key;
output reg [7:0] round0;
output en;
reg en= 1'd0;
reg [7:0] mem_din [0:15];
reg [7:0] mem_key [0:15];
reg [7:0]counter =8'd0;
reg [7:0]co =8'd0;
reg [7:0]ro =8'd0;
reg [7:0]state = 8'd0;
always@(posedge clk)begin
 case(state)
 8'd0 : begin
if(counter <= 8'd15)begin
mem_din[counter] <= din;
counter <= counter +8'd1;

end
if(co <= 8'd15)begin
mem_key[co] <= key;
co <= co +8'd1;

end
if (counter == 8'd16 && co ==8'd16)begin
state <= 8'd1;
ro<= 8'd0;
end
end

8'd1 :begin
if (ro <= 8'd15)begin
en= 1'd1;
round0 <= mem_din[ro] ^ mem_key[ro];
ro <= ro + 8'd1;
end
else if (ro == 8'd16)begin
en= 8'd0;
end
end

default : state <=8'd0;
endcase
end
endmodule
