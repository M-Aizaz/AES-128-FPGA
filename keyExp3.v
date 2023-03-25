`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:20 03/21/2023 
// Design Name: 
// Module Name:    keyExp3 
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
module keyExp3 (clk,din,addr_out,sbox_in,dout,enable_out,enable_sbox,enable_din,round_complete);
input clk,enable_din,round_complete;
input [7:0]din,sbox_in;
output reg[7:0]dout,addr_out;
output enable_out,enable_sbox;
reg enable_out =1'd0;
reg enable_sbox =1'd0;
reg [7:0] co =8'd0;
reg [7:0] ca =8'd0;
reg [7:0] cb =8'd3;
reg [7:0] cc =8'd0;
reg [7:0] state =8'd0;
reg [7:0]mem_key[0:15];
reg [7:0] mem_rot [0:3];
reg [7:0] mem_col1 [0:3];
reg [7:0] mem_addr [0:3];
reg [7:0] mem_sbox [0:3];
reg [7:0] key_out [0:15];
reg a=0;
always@(posedge clk)begin
case(state)
8'd0:begin
    if(co<=8'd15 && enable_din==1)begin
	    mem_key[co] <= din;
		 co <= co +8'd1;
		 end
		 else if  (co == 8'd16)begin
		 state <= 8'd1;
end
end
8'd1:begin
   if(ca <= 8'd3 && cb <= 8'd15)begin
	   mem_rot[ca] <= mem_key[cb];
		ca <= ca +8'd1;
		cb <= cb + 8'd4;
	end
	else if(ca == 8'd4)begin
		 state <= 8'd2;
end
end
8'd2:begin
 if(cc <= 8'd2)begin
     mem_addr[cc] <= mem_rot[cc +1];
	  cc <= cc +8'd1;
end
else if(cc == 8'd3)begin
mem_addr[cc] <=  mem_rot[cc-3];
       cc <= cc +8'd1;
end


else if (cc == 8'd4)begin
     state <= 8'd3;
	  co <= 8'd0;
	  cc<=8'd0;
end
end
8'd3:begin
if(co == 8'd0)begin
enable_sbox =1'd1;
addr_out <= mem_addr[co];
  co <= co +8'd1;
end
if(co>=8'd1 && co<= 8'd3)begin
a =1'd1;
enable_sbox =1'd1;
addr_out <= mem_addr[co];
  co <= co +8'd1;
  
  cc<=8'd0;
end
if(co==8'd4)begin
enable_sbox =1'd0;
end
if(cc <= 8'd4 && a==1)begin
mem_sbox[cc-1] <= sbox_in;
 cc <= cc +8'd1;
end
else if (cc == 8'd5)begin
state <= 8'd4;
co <= 8'd0;
cc <= 8'd1;
enable_sbox =1'd0;
end
end

8'd4:begin
 if(co==8'd0)begin
 key_out[co] <= mem_key[co] ^ mem_sbox[co] ^ 8'd4;
  co <= co +8'd4;
  end
  else if(co>=8'd4 && co<= 8'd12 && cc<=3)begin
  key_out[co] <= mem_key[co] ^ mem_sbox[cc];
  co <= co +8'd4;
  cc <= cc +8'd1;
  end
  else if(co==8'd16 && cc== 8'd4)begin
    state <= 8'd5;
co <= 8'd1;
  end
  end
  
  8'd5:begin
   if(co<=8'd13)begin
   key_out[co] <= mem_key[co] ^ key_out[co-1];
   co <= co +8'd4;
  end
  else if(co==8'd17)begin
    state <= 8'd6;
co <= 8'd2;
  end
  end
8'd6:begin  
  if(co<=8'd14)begin
   key_out[co] <= mem_key[co] ^ key_out[co-1];
   co <= co +8'd4;
  end
  else if(co==8'd18)begin
    state <= 8'd7;
   co <= 8'd3;
  end  
  end
8'd7:begin   
  if(co<=8'd15)begin
   key_out[co] <= mem_key[co] ^ key_out[co-1];
   co <= co +8'd4;
  end
  else if(co==8'd19)begin
    state <= 8'd8;
   co <= 8'd0;
  end  
  end
  8'd8:begin
     if(round_complete==1 && co<= 8'd2)begin
         	  co<=co+8'd1;
				  end
		else if (co >=8'd3 && co <= 8'd16)begin
		 co<=co+8'd1;
              end		
				  else if(co==8'd17)begin
				  state<=8'd9;
				  co <= 8'd0;
				  end
				  end
  8'd9:begin
         enable_out<=1'd1;
			 if(co<=8'd15)begin
			 dout <= key_out[co];
			 co <= co +8'd1; 
end	
     else if(co == 8'd16)begin
	  enable_out<=1'd0;
end	  
  end
default : state <=8'd0;
endcase
end

endmodule
