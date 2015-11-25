module display_hex_7seg (a3, a2, a1, a0, HEX0);
	input a3, a2, a1, a0;
	output [0:6] HEX0;
	
	assign HEX0[0] = (~a3 & ~a2 & ~a1 & a0) | (~a3 & a2 & ~a0) | (a3 & a2 & ~a1 & a0) | (a3 & ~a2 & a1 & a0);
	assign HEX0[1] = (~a3 & a2 & ~a1 & a0) | (a2 & a1 & ~a0) | (a3 & a2 & ~a0) | (a3 & a1 & a0);
	assign HEX0[2] = (a3 & a2 & a1) | (a3 & a2 & ~a0) | (~a3 & ~a2 & a1 & ~a0);
	assign HEX0[3] = (a2 & a1 & a0) | (~a2 & ~a1 & a0) | (~a3 & a2 & ~a1 & ~a0) | (a3 & ~a2 & a1 & ~a0);
	assign HEX0[4] = (~a3 & a0) | (~a3 & a2 & ~a1) | (~a2 & ~a1 & a0);
	assign HEX0[5] = (~a3 & ~a2 & a0) | (~a3 & ~a2 & a1) | (~a3 & a1 & a0) | (a3 & a2 & ~a1 & a0);
	assign HEX0[6] = (~a3 & ~a2 & ~a1) | (a3 & a2 & ~a1 & ~a0) | (~a3 & a2 & a1 & a0);
	
endmodule 

module part4 (KEY, SW, HEX3, HEX2, HEX1, HEX0, LEDR);
	input [1:0] SW;
	input [1:1] KEY;
	reg [15:0] Q;
	output [0:6] HEX3, HEX2, HEX1, HEX0;
	output [7:0] LEDR;
	
	always @ (posedge KEY[1], negedge SW[0])
		if(~SW[0])
			Q <= 16'b0;
		else
			if(SW[1])
				Q <= Q + 1;
	
	display_hex_7seg u0(Q[3],Q[2],Q[1],Q[0],HEX0);
	display_hex_7seg u1(Q[7],Q[6],Q[5],Q[4],HEX1);
	display_hex_7seg u2(Q[11],Q[10],Q[9],Q[8],HEX2);
	display_hex_7seg u3(Q[15],Q[14],Q[13],Q[12],HEX3);
	
	assign LEDR = Q;
	
endmodule 