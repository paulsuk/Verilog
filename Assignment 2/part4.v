module part4(SW, LEDR, HEX5, HEX3, HEX1, HEX0 );

	input [9:0] SW; // slide switches
	output [9:0] LEDR; // red lights
	output [0:6] HEX5, HEX3, HEX1, HEX0;
	
	wire cin, c1, c2, c3, cout, s3, s2, s1, s0, z;
	wire [3:0] A, M;
	
	assign cin = SW[8];
	
	fulladder U0 (cin, SW[4], SW[0], s0, c1);
	fulladder U1 (c1, SW[5], SW[1], s1, c2);
	fulladder U2 (c2, SW[6], SW[2], s2, c3);
	fulladder U3 (c3, SW[7], SW[3], s3, cout);
	
	assign LEDR[4] = cout;
	assign LEDR[3] = s3;
	assign LEDR[2] = s2;
	assign LEDR[1] = s1;
	assign LEDR[0] = s0;
	
	// Comparator
	assign z = (s3 & s2) | (s3 & s1)| (cout);
	assign LEDR[8] = z;
	
	// Tens digit
	assign HEX1[0] = z;
	assign HEX1[1] = 0;
	assign HEX1[2] = 0;
	assign HEX1[3] = z;
	assign HEX1[4] = z;
	assign HEX1[5] = z;
	assign HEX1[6] = 1;
	
	// Circuit A
	assign A[3] = (cout & ~s3 & ~s2 & s1 & ~s0) | (cout & ~ s3 & ~s2 & s1 & s0);  
	assign A[2] = (~cout & s3 & s2 & s1) | (cout & ~s3 & ~s2 & ~s1);  
	assign A[1] = (~cout & s3 & s2 & ~s1) | (cout & ~s3 & ~s2 & ~s1); 
	assign A[0] = (~cout & s3 & s1 & s0) | (~cout & s3 & s2 & ~s1 & s0)  | (cout & ~s3 & ~s2 & s0);  
	
	// M
	assign M[0] = (~z & s0) | (z & A[0]);
	assign M[1] = (~z & s1) | (z & A[1]);
	assign M[2] = (~z & s2) | (z & A[2]);
	assign M[3] = (~z & s3) | (z & A[3]);
	
	// Ones Digit
	assign HEX0[0] = (~M[3] & M[2] & ~M[0]) | (~M[3] & ~ M[2] & ~M[1] & M[0]) | (M[3] & M[2]) | (M[3] & M[1]);
	assign HEX0[1] = (M[3] & M[2]) | (M[3] & M[1]) | (M[2] & ~M[1] & M[0]) | (M[2] & M[1] & ~M[0]);
	assign HEX0[2] = (M[3] & M[2]) | (M[3] & M[1]) | (~M[2] & M[1] & ~M[0]);
	assign HEX0[3] = (M[3] & M[2]) | (M[3] & M[1]) | (~M[3] & M[2] & ~M[1] & ~M[0])| (~M[3] & M[2] & M[1] & M[0]) | (~M[2] & ~M[1] & M[0]);
	assign HEX0[4] = (M[3] & M[2]) | (M[3] & M[1]) | (~M[3] & M[0]) | (~M[2] & ~M[1] & M[0]) | (~M[3] & M[2] & ~M[1]);
	assign HEX0[5] = (M[3] & M[2]) | (M[1] & M[0]) | (~M[2] & M[1]) | (~M[3] & ~M[2] & M[0]);
	assign HEX0[6] = (M[3] & M[2]) | (M[3] & M[1]) | (~M[3] & ~M[2] & ~M[1]) | (~M[3] & M[2] & M[1] & M[0]);
	
	// Display X
	assign HEX5[0] = (~SW[7] & SW[6] & ~SW[4]) | (~SW[7] & ~ SW[6] & ~SW[5] & SW[4]) | (SW[7] & SW[6]) | (SW[7] & SW[5]);
	assign HEX5[1] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (SW[6] & ~SW[5] & SW[4]) | (SW[6] & SW[5] & ~SW[4]);
	assign HEX5[2] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (~SW[6] & SW[5] & ~SW[4]);
	assign HEX5[3] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (~SW[7] & SW[6] & ~SW[5] & ~SW[4])| (~SW[7] & SW[6] & SW[5] & SW[4]) | (~SW[6] & ~SW[5] & SW[4]);
	assign HEX5[4] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (~SW[7] & SW[4]) | (~SW[6] & ~SW[5] & SW[4]) | (~SW[7] & SW[6] & ~SW[5]);
	assign HEX5[5] = (SW[7] & SW[6]) | (SW[5] & SW[4]) | (~SW[6] & SW[5]) | (~SW[7] & ~SW[6] & SW[4]);
	assign HEX5[6] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (~SW[7] & ~SW[6] & ~SW[5]) | (~SW[7] & SW[6] & SW[5] & SW[4]);
	
	//Display Y
	assign HEX3[0] = (~SW[3] & SW[2] & ~SW[0]) | (~SW[3] & ~ SW[2] & ~SW[1] & SW[0]) | (SW[3] & SW[2]) | (SW[3] & SW[1]);
	assign HEX3[1] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (SW[2] & ~SW[1] & SW[0]) | (SW[2] & SW[1] & ~SW[0]);
	assign HEX3[2] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (~SW[2] & SW[1] & ~SW[0]);
	assign HEX3[3] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (~SW[3] & SW[2] & ~SW[1] & ~SW[0])| (~SW[3] & SW[2] & SW[1] & SW[0]) | (~SW[2] & ~SW[1] & SW[0]);
	assign HEX3[4] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (~SW[3] & SW[0]) | (~SW[2] & ~SW[1] & SW[0]) | (~SW[3] & SW[2] & ~SW[1]);
	assign HEX3[5] = (SW[3] & SW[2]) | (SW[1] & SW[0]) | (~SW[2] & SW[1]) | (~SW[3] & ~SW[2] & SW[0]);
	assign HEX3[6] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (~SW[3] & ~SW[2] & ~SW[1]) | (~SW[3] & SW[2] & SW[1] & SW[0]);
	
	//Error term
	assign LEDR[9] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (SW[3] & SW[2]) | (SW[3] & SW[1]);
	
endmodule
	

module fulladder (cin, a, b, s, cout);
	input cin, a, b;
	output s, cout; 
	
	assign cout = (b & a) | (b & cin) | (a & cin);
	assign s = (~a & ~b & cin) | (~a & b & ~cin) | (a & ~b & ~cin) | (a & b & cin);	
	
endmodule 