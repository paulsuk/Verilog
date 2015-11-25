module part2 (SW, HEX1, HEX0);
	
	input [3:0] SW;
	output [0:6] HEX1, HEX0;
	wire z;
	wire [3:0] A, M;
	
	// Comparator
	assign z = (SW[3] & SW[2]) | (SW[3] & SW[1]);
	
	// Tens digit
	assign HEX1[0] = z;
	assign HEX1[1] = 0;
	assign HEX1[2] = 0;
	assign HEX1[3] = z;
	assign HEX1[4] = z;
	assign HEX1[5] = z;
	assign HEX1[6] = 1;
	
	// Circuit A
	assign A[3] = 0;
	assign A[2] = (SW[3] & SW[2] & SW[1]);
	assign A[1] = (SW[3] & SW[2] & ~SW[1]);
	assign A[0] = (SW[3] & SW[1] & SW[0]) | (SW[3] & SW[2] & SW[0]);
	
	// M
	assign M[0] = (~z & SW[0]) | (z & A[0]);
	assign M[1] = (~z & SW[1]) | (z & A[1]);
	assign M[2] = (~z & SW[2]) | (z & A[2]);
	assign M[3] = (~z & SW[3]) | (z & A[3]);
	
	// Ones Digit
	assign HEX0[0] = (~M[3] & M[2] & ~M[0]) | (~M[3] & ~ M[2] & ~M[1] & M[0]) | (M[3] & M[2]) | (M[3] & M[1]);
	assign HEX0[1] = (M[3] & M[2]) | (M[3] & M[1]) | (M[2] & ~M[1] & M[0]) | (M[2] & M[1] & ~M[0]);
	assign HEX0[2] = (M[3] & M[2]) | (M[3] & M[1]) | (~M[2] & M[1] & ~M[0]);
	assign HEX0[3] = (M[3] & M[2]) | (M[3] & M[1]) | (~M[3] & M[2] & ~M[1] & ~M[0])| (~M[3] & M[2] & M[1] & M[0]) | (~M[2] & ~M[1] & M[0]);
	assign HEX0[4] = (M[3] & M[2]) | (M[3] & M[1]) | (~M[3] & M[0]) | (~M[2] & ~M[1] & M[0]) | (~M[3] & M[2] & ~M[1]);
	assign HEX0[5] = (M[3] & M[2]) | (M[1] & M[0]) | (~M[2] & M[1]) | (~M[3] & ~M[2] & M[0]);
	assign HEX0[6] = (M[3] & M[2]) | (M[3] & M[1]) | (~M[3] & ~M[2] & ~M[1]) | (~M[3] & M[2] & M[1] & M[0]);
	
endmodule 