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

module fulladder (cin, a, b, s, cout);
	input cin, a, b;
	output s, cout; 
	
	assign cout = (b & a) | (b & cin) | (a & cin);
	assign s = (~a & ~b & cin) | (~a & b & ~cin) | (a & ~b & ~cin) | (a & b & cin);	
	
endmodule 

module part2(SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);
	input [7:0] SW;
	input [1:0] KEY;
	output [0:6] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	output [0:0] LEDR;
	reg [7:0] A;
	wire [7:0] S;
	wire c1,c2,c3,c4,c5,c6,c7,cout;
	
	// Press reset (KEY[0]) and set switches (SW[7:0]) to A
	always @ (negedge KEY[0], posedge KEY[1])
		if (!KEY[0])
			A <= 8'b0;
		else
			A <= SW;
	
	// Press clock (KEY1); At posedge, FF stores A
	// Set switches (SW[7:0]) to B
	
	// Add A and B
	fulladder u1(0, A[0], SW[0], S[0], c1);
	fulladder u2(c1, A[1], SW[1], S[1], c2);
	fulladder u3(c2, A[2], SW[2], S[2], c3);
	fulladder u4(c3, A[3], SW[3], S[3], c4);
	fulladder u5(c4, A[4], SW[4], S[4], c5);
	fulladder u6(c5, A[5], SW[5], S[5], c6);
	fulladder u7(c6, A[6], SW[6], S[6], c7);
	fulladder u8(c7, A[7], SW[7], S[7], cout);
	
	// Display deez nutz
	
	// A
	display_hex_7seg dA1(A[7], A[6], A[5], A[4], HEX3);
	display_hex_7seg dA2(A[3], A[2], A[1], A[0], HEX2);
	
	// B
	display_hex_7seg dB1(SW[7], SW[6], SW[5], SW[4], HEX1);
	display_hex_7seg dB2(SW[3], SW[2], SW[1], SW[0], HEX0);
	
	// S
	display_hex_7seg dS1(S[7], S[6], S[5], S[4], HEX5);
	display_hex_7seg dS2(S[3], S[2], S[1], S[0], HEX4);
	
	assign LEDR[0] = cout;
	
endmodule 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	