`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:02:15 02/25/2023 
// Design Name: 
// Module Name:    AES_encrypty 
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
module AES_encrypty(clk,data,key,chiper);
input [7:0]data,key;
input clk;
output wire [7:0]chiper;
wire [7:0] round1_out,col_out,round2_out;
wire enable_subBytes;
wire [7:0]subBytes_out;
wire [7:0]row_out,keysboxin,keysboxout;
wire enable_row,enable_col,enable_key1,enable_key2,enable_key3,enable_key4,enable_key5,enable_key6,enable_key7,enable_key8,enable_key9,enable_key10;
wire [7:0] key1,key2,key3,key4,key5,key6,key7,key8,key9,key10;
wire enable_r0,enable_r1,enable_subbyte,enable_r2;
wire enable_sboxkey,enable_sboxkey1,enable_sboxkey2,enable_sboxkey3,enable_sboxkey4,enable_sboxkey5,enable_sboxkey6,enable_sboxkey7,enable_sboxkey8;
wire [7:0]k1,k2,k3,k4,k5,k6,k7,k8,k9,k10;
wire[7:0] keyexp,rowNo;
wire enable_key,round_complete;
wire enable;
assign keysboxout = (enable_sboxkey)?k1:(enable_sboxkey1)?k2:(enable_sboxkey2)?k3:(enable_sboxkey3)?k4:(enable_sboxkey4)?k5:(enable_sboxkey5)?k6:(enable_sboxkey6)?k7:(enable_sboxkey7)?k8:(enable_sboxkey8)?k9:(enable_sboxkey9)?k10:0;

assign keyexp  = (enable_key1==1)? key1:(enable_key2==1)?key2:(enable_key3==1)?key3:(enable_key4==1)?key4:(enable_key5==1)?key5:(enable_key6==1)?key6:(enable_key7==1)?key7:(enable_key8==1)?key8:(enable_key9==1)?key9:(enable_key10==1)?key10:0;

assign enable = enable_key1 || enable_key2 ||enable_key3  ||enable_key4 ||enable_key5 ||enable_key6 ||enable_key7 ||enable_key8||enable_key9 ||enable_key10;

round0 h1(
    .clk(clk), 
    .din(data), 
    .key(key), 
	 .en(enable_r0),
    .round0(round1_out)
    );

S_box h2 (
  .clka(clk), // input clka
  .ena(enable_subbyte), // input ena
  .addra(chiper), // input [7 : 0] addra
  .douta(subBytes_out) // output [7 : 0] douta
);

ShiftRow h3 (
    .clk(clk), 
    .din(subBytes_out), 
    .en_din(enable_subbyte), 
    .en_dout(enable_row), 
    .dout(row_out),
	 .row(rowNo)
    );
Mix_Columns h4 (
    .clk(clk), 
    .din(row_out), 
    .dout(col_out), 
    .en(enable_row),
	  .enable_out(enable_col),
	  .rowNo(rowNo)
    );

	 keyExp1 h5(
    .clk(clk), 
    .din(key), 
    .addr_out(k1), 
    .sbox_in(keysboxin), 
    .dout(key1),
	 .enable_out(enable_key1),
	 .enable_sbox(enable_sboxkey)
     
    );
keyExp2 h5_1 (
    .clk(clk), 
    .din(key1), 
    .addr_out(k2), 
    .sbox_in(keysboxin), 
    .dout(key2), 
    .enable_out(enable_key2), 
    .enable_sbox(enable_sboxkey1),
	 .enable_din(enable_key1),
	 .round_complete(enable_r1)
    );
	 
	 keyExp3 h5_2 (
    .clk(clk), 
    .din(key2), 
    .addr_out(k3), 
    .sbox_in(keysboxin), 
    .dout(key3), 
    .enable_out(enable_key3), 
    .enable_sbox(enable_sboxkey2),
	 .enable_din(enable_key2),
	 .round_complete(enable_r1)
    );
	 
	  keyExp4 h5_3 (
    .clk(clk), 
    .din(key3), 
    .addr_out(k4), 
    .sbox_in(keysboxin), 
    .dout(key4), 
    .enable_out(enable_key4), 
    .enable_sbox(enable_sboxkey3),
	 .enable_din(enable_key3),
	 .round_complete(enable_r1)
    );
	 
	   keyExp5 h5_4 (
    .clk(clk), 
    .din(key4), 
    .addr_out(k5), 
    .sbox_in(keysboxin), 
    .dout(key5), 
    .enable_out(enable_key5), 
    .enable_sbox(enable_sboxkey4),
	 .enable_din(enable_key4),
	 .round_complete(enable_r1)
    );
	 
	 keyExp6 h5_5 (
    .clk(clk), 
    .din(key5), 
    .addr_out(k6), 
    .sbox_in(keysboxin), 
    .dout(key6), 
    .enable_out(enable_key6), 
    .enable_sbox(enable_sboxkey5),
	 .enable_din(enable_key5),
	 .round_complete(enable_r1)
    );
	 
	  keyExp7 h5_6 (
    .clk(clk), 
    .din(key6), 
    .addr_out(k7), 
    .sbox_in(keysboxin), 
    .dout(key7), 
    .enable_out(enable_key7), 
    .enable_sbox(enable_sboxkey6),
	 .enable_din(enable_key6),
	 .round_complete(enable_r1)
    );
	 
	  keyExp8 h5_7 (
    .clk(clk), 
    .din(key7), 
    .addr_out(k8), 
    .sbox_in(keysboxin), 
    .dout(key8), 
    .enable_out(enable_key8), 
    .enable_sbox(enable_sboxkey7),
	 .enable_din(enable_key7),
	 .round_complete(enable_r1)
    );
	 
	 keyExp9 h5_8 (
    .clk(clk), 
    .din(key8), 
    .addr_out(k9), 
    .sbox_in(keysboxin), 
    .dout(key9), 
    .enable_out(enable_key9), 
    .enable_sbox(enable_sboxkey8),
	 .enable_din(enable_key8),
	 .round_complete(enable_r1)
    );
	 
	 keyExp10 h5_9 (
    .clk(clk), 
    .din(key9), 
    .addr_out(k10), 
    .sbox_in(keysboxin), 
    .dout(key10), 
    .enable_out(enable_key10), 
    .enable_sbox(enable_sboxkey9),
	 .enable_din(enable_key9),
	 .round_complete(enable_r1)
    );


keySbox h6 (
  .clka(clk), // input clka
  .addra(keysboxout), // input [7 : 0] addra
  .douta(keysboxin) // output [15 : 0] douta
);

round1 h7 (
    .clk(clk), 
    .col_din(col_out), 
    .key_din(keyexp), 
    .en_col(enable_col), 
    .en_key(enable), 
    .dout(round2_out), 
    .enable_out(enable_r1)
    );

loop h8(
    .clk(clk), 
    .round0_in(round1_out), 
    .round1_in(round2_out), 
    .dout(chiper), 
    .enable_round0(enable_r0), 
    .enable_round1(enable_r1),
	 .enable_subbyte(enable_subbyte)
    );
endmodule
