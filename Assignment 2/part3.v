module part3(SW, LEDR);

	input [8:0] SW; // slide switches
	output [7:0] LEDR; // red lights
	
	wire cin, c1, c2, c3, cout, s3, s2, s1, s0;
	
	assign cin = SW[8];
	
	fulladder U0 (cin, SW[4], SW[0], s0, c1);
	fulladder U1 (c1, SW[5], SW[1], s1, c2);
	fulladder U2 (c2, SW[6], SW[2], s2, c3);
	fulladder U3 (c3, SW[7], SW[3], s3, cout);
	
	assign LEDR[7] = cout;
	assign LEDR[6] = s3;
	assign LEDR[5] = c3;
	assign LEDR[4] = s2;
	assign LEDR[3] = c2;
	assign LEDR[2] = s1;
	assign LEDR[1] = c1;
	assign LEDR[0] = s0;
	
endmodule
	

module fulladder (cin, a, b, s, cout);
	input cin, a, b;
	output s, cout; 
	
	assign cout = (b & a) | (b & cin) | (a & cin);
	assign s = (~a & ~b & cin) | (~a & b & ~cin) | (a & ~b & ~cin) | (a & b & cin);	
	
endmodule
