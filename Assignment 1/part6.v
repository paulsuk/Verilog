module part6 (SW, LEDR, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

	input [9:0] SW; // slide switches
	output [9:0] LEDR; // red lights
	output [0:6] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0; // 7-seg display
	wire [1:0] M5, M4, M3, M2, M1, M0;
	
	mux_2bit_6to1 U5 (SW[9:7], SW[2:1], SW[2:1], SW[2:1], SW[5:4], SW[3:2], SW[1:0], M5);
	char_7seg H5 (M5, HEX5);
	
	mux_2bit_6to1 U4 (SW[9:7], SW[2:1], SW[2:1], SW[5:4], SW[3:2], SW[1:0], SW[2:1], M4);
	char_7seg H4 (M4, HEX4);
	
	mux_2bit_6to1 U3 (SW[9:7], SW[2:1], SW[5:4], SW[3:2], SW[1:0], SW[2:1], SW[2:1], M3);
	char_7seg H3 (M3, HEX3);
	
	mux_2bit_6to1 U2 (SW[9:7], SW[5:4], SW[3:2], SW[1:0], SW[2:1], SW[2:1], SW[2:1], M2);
	char_7seg H2 (M2, HEX2);
	
	mux_2bit_6to1 U1 (SW[9:7], SW[3:2], SW[1:0], SW[2:1], SW[2:1], SW[2:1], SW[5:4], M1);
	char_7seg H1 (M1, HEX1);
	
	mux_2bit_6to1 U0 (SW[9:7], SW[1:0], SW[2:1], SW[2:1], SW[2:1], SW[5:4], SW[3:2], M0);
	char_7seg H0 (M0, HEX0);
	
	assign LEDR = SW;

endmodule



// implements a 2-bit wide 6-to-1 multiplexer
module mux_2bit_6to1 (S, U, V, W, X, Y, Z, M);
	input [2:0] S;
	input [1:0] U, V, W, X, Y, Z ;
	output [1:0] M; 
	
	assign M[0] = (~S[2] & ~S[1] & ~S[0] & U[0]) | (~S[2] & ~S[1] & S[0] & V[0]) | (~S[2] & S[1] & ~S[0] & W[0]) | (~S[2] & S[1] & S[0] & X[0]) | (S[2] & ~S[1] & ~S[0] & Y[0]) | (S[2] & ~S[1] & S[0] & Z[0]);
	assign M[1] = (~S[2] & ~S[1] & ~S[0] & U[1]) | (~S[2] & ~S[1] & S[0] & V[1]) | (~S[2] & S[1] & ~S[0] & W[1]) | (~S[2] & S[1] & S[0] & X[1]) | (S[2] & ~S[1] & ~S[0] & Y[1]) | (S[2] & ~S[1] & S[0] & Z[1]);	
	
endmodule


// implements a 7-segment decoder for d, E, 1 and ‘blank’
module char_7seg (C, Display);
	input [1:0] C; // input code
	output [0:6] Display; // output 7-seg code

	assign Display[0] = ~C[0] | C[1];
	assign Display[1] = C[0];
	assign Display[2] = C[0];
	assign Display[3] = C[1];
	assign Display[4] = C[1];
	assign Display[5] = ~C[0] | C[1];
	assign Display[6] = C[1];
	
endmodule
