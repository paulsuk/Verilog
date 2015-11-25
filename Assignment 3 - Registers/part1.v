module D_latch (D, Clk, Q);
	input D, Clk;
	output reg Q;
	always @ (D, Clk)
		if (Clk == 1)
			Q = D;
endmodule

module posD_FF (D, Clock, Q);
	input D, Clock;
	output reg Q;
	always @ (posedge Clock)
		Q <= D;
endmodule 

module negD_FF (D, Clock, Q);
	input D, Clock;
	output reg Q;
	always @ (negedge Clock)
		Q <= D;
endmodule 

module part1 (D, Clock, Qa, Qb, Qc);
	input D, Clock;
	output Qa, Qb, Qc;
	
	D_latch u0(D, Clock, Qa);
	posD_FF u1(D, Clock, Qb);
	negD_FF u2(D, Clock, Qc);

endmodule 