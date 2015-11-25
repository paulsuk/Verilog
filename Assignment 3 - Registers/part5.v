module bin_to_dec_7seg(a3, a2, a1, a0, HEX);
	input a3, a2, a1, a0;
	output [0:6] HEX;

	assign HEX[0] = (~a3 & a2 & ~a0) | (~a3 & ~ a2 & ~a1 & a0) | (a3 & a2) | (a3 & a1);
	assign HEX[1] = (a3 & a2) | (a3 & a1) | (a2 & ~a1 & a0) | (a2 & a1 & ~a0);
	assign HEX[2] = (a3 & a2) | (a3 & a1) | (~a2 & a1 & ~a0);
	assign HEX[3] = (a3 & a2) | (a3 & a1) | (~a3 & a2 & ~a1 & ~a0)| (~a3 & a2 & a1 & a0) | (~a2 & ~a1 & a0);
	assign HEX[4] = (a3 & a2) | (a3 & a1) | (~a3 & a0) | (~a2 & ~a1 & a0) | (~a3 & a2 & ~a1);
	assign HEX[5] = (a3 & a2) | (a1 & a0) | (~a2 & a1) | (~a3 & ~a2 & a0);
	assign HEX[6] = (a3 & a2) | (a3 & a1) | (~a3 & ~a2 & ~a1) | (~a3 & a2 & a1 & a0);

endmodule 


module part5(CLOCK_50, SW, HEX0);
	input CLOCK_50;
	input [1:0] SW;
	output [0:6] HEX0;
	reg [25:0] Q;
	reg [3:0] A;
	wire sec;
	
	always @ (posedge CLOCK_50, negedge SW[0])
		if(~SW[0])
			Q <= 26'b1;
		else
			Q <= Q + 1;	
			
	assign sec = (Q == 0);
	
	always @ (posedge CLOCK_50, negedge SW[0])
		if(~SW[0])
			A <= 4'b0;
		else
			if(sec)
				if (A == 4'd9)
					A <= 4'b0;
				else
					A <= A + 1;
	
	bin_to_dec_7seg u0(A[3], A[2], A[1], A[0], HEX0);

endmodule 	
