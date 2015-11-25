module part5(SW, LEDR, HEX5, HEX3, HEX1, HEX0 );
	input [9:0] SW; // slide switches
	output [9:0] LEDR;
	output [0:6] HEX5, HEX3, HEX1, HEX0;
	
	wire cin, c1, c2, c3;
	wire C1, C2, C3, C4, Cout;
	wire [3:0] A, M;
	wire [4:0] T, S;
	
	reg [4:0] Z;
	reg C;
	
	assign cin = SW[8];
	
	// T = A + B + cin
	fulladder U0 (cin, SW[4], SW[0], T[0], c1);
	fulladder U1 (c1, SW[5], SW[1], T[1], c2);
	fulladder U2 (c2, SW[6], SW[2], T[2], c3);
	fulladder U3 (c3, SW[7], SW[3], T[3], T[4]);

always @(*)
begin
	if ( T > 5'd 9)
		begin
		Z[0] = 0;
		Z[1] = 1;
		Z[2] = 0;
		Z[3] = 1;
		Z[4] = 0;
		C = 1;
		end
	else
		begin
		Z[0] = 0;
		Z[1] = 0;
		Z[2] = 0;
		Z[3] = 0;
		Z[4] = 0;
		C = 0;
		end
end

//For Debugging
	// assign LEDR[0] = Z[0];
	// assign LEDR[1] = Z[1];
	// assign LEDR[2] = Z[2];
	// assign LEDR[3] = Z[3];
	// assign LEDR[4] = Z[4];
	
	//Calculate S = T - Z
	//subtractor V0 (0, T[0], Z[0], S[0], C1);
	//subtractor V1 (C1, T[1], Z[1], S[1], C2);
	//subtractor V2 (C2, T[2], Z[2], S[2], C3);
	//subtractor V3 (C3, T[3], Z[3], S[3], C4);
	//subtractor V4 (C4, T[4], Z[4], S[4], Cout);
	
	assign S = T - Z;
	
	// Display A
	assign HEX5[0] = (~SW[7] & SW[6] & ~SW[4]) | (~SW[7] & ~ SW[6] & ~SW[5] & SW[4]) | (SW[7] & SW[6]) | (SW[7] & SW[5]);
	assign HEX5[1] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (SW[6] & ~SW[5] & SW[4]) | (SW[6] & SW[5] & ~SW[4]);
	assign HEX5[2] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (~SW[6] & SW[5] & ~SW[4]);
	assign HEX5[3] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (~SW[7] & SW[6] & ~SW[5] & ~SW[4])| (~SW[7] & SW[6] & SW[5] & SW[4]) | (~SW[6] & ~SW[5] & SW[4]);
	assign HEX5[4] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (~SW[7] & SW[4]) | (~SW[6] & ~SW[5] & SW[4]) | (~SW[7] & SW[6] & ~SW[5]);
	assign HEX5[5] = (SW[7] & SW[6]) | (SW[5] & SW[4]) | (~SW[6] & SW[5]) | (~SW[7] & ~SW[6] & SW[4]);
	assign HEX5[6] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (~SW[7] & ~SW[6] & ~SW[5]) | (~SW[7] & SW[6] & SW[5] & SW[4]);
	
	//Display B
	assign HEX3[0] = (~SW[3] & SW[2] & ~SW[0]) | (~SW[3] & ~ SW[2] & ~SW[1] & SW[0]) | (SW[3] & SW[2]) | (SW[3] & SW[1]);
	assign HEX3[1] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (SW[2] & ~SW[1] & SW[0]) | (SW[2] & SW[1] & ~SW[0]);
	assign HEX3[2] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (~SW[2] & SW[1] & ~SW[0]);
	assign HEX3[3] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (~SW[3] & SW[2] & ~SW[1] & ~SW[0])| (~SW[3] & SW[2] & SW[1] & SW[0]) | (~SW[2] & ~SW[1] & SW[0]);
	assign HEX3[4] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (~SW[3] & SW[0]) | (~SW[2] & ~SW[1] & SW[0]) | (~SW[3] & SW[2] & ~SW[1]);
	assign HEX3[5] = (SW[3] & SW[2]) | (SW[1] & SW[0]) | (~SW[2] & SW[1]) | (~SW[3] & ~SW[2] & SW[0]);
	assign HEX3[6] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (~SW[3] & ~SW[2] & ~SW[1]) | (~SW[3] & SW[2] & SW[1] & SW[0]);
	
	// Ones Digit
	assign HEX0[0] = (~S[3] & S[2] & ~S[0]) | (~S[3] & ~ S[2] & ~S[1] & S[0]) | (S[3] & S[2]) | (S[3] & S[1]);
	assign HEX0[1] = (S[3] & S[2]) | (S[3] & S[1]) | (S[2] & ~S[1] & S[0]) | (S[2] & S[1] & ~S[0]);
	assign HEX0[2] = (S[3] & S[2]) | (S[3] & S[1]) | (~S[2] & S[1] & ~S[0]);
	assign HEX0[3] = (S[3] & S[2]) | (S[3] & S[1]) | (~S[3] & S[2] & ~S[1] & ~S[0])| (~S[3] & S[2] & S[1] & S[0]) | (~S[2] & ~S[1] & S[0]);
	assign HEX0[4] = (S[3] & S[2]) | (S[3] & S[1]) | (~S[3] & S[0]) | (~S[2] & ~S[1] & S[0]) | (~S[3] & S[2] & ~S[1]);
	assign HEX0[5] = (S[3] & S[2]) | (S[1] & S[0]) | (~S[2] & S[1]) | (~S[3] & ~S[2] & S[0]);
	assign HEX0[6] = (S[3] & S[2]) | (S[3] & S[1]) | (~S[3] & ~S[2] & ~S[1]) | (~S[3] & S[2] & S[1] & S[0]);

	// Tens Digit
	assign HEX1[0] = C;
	assign HEX1[1] = 0;
	assign HEX1[2] = 0;
	assign HEX1[3] = C;
	assign HEX1[4] = C;
	assign HEX1[5] = C;
	assign HEX1[6] = 1;
	
	//Error term
	assign LEDR[9] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (SW[3] & SW[2]) | (SW[3] & SW[1]);
	
endmodule

module fulladder (cin, a, b, s, cout);
	input cin, a, b;
	output s, cout; 
	assign cout = (b & a) | (b & cin) | (a & cin);
	assign s = (~a & ~b & cin) | (~a & b & ~cin) | (a & ~b & ~cin) | (a & b & cin);	
endmodule 

module subtractor (cin, a, b, s, cout);
	input cin, a, b;
	output s, cout;
	assign s = (~cin & ~a & b) | (~cin & a & ~b) | (cin & a & b) | (cin & ~a & ~b);
	assign cout = (cin & b) | (cin & ~a) | (~a & b);
endmodule 