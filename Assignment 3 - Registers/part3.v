module T_FF (Clock, T, Q, Clearn);
	input Clock, T, Clearn;
	output reg Q;
	always @ (posedge Clock, negedge Clearn)
	begin
		if(!Clearn)
			Q <= 1'b0;
		else
			if (T)
				Q <= ~Q;
	end
endmodule 
// begin & end?

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

module part3(KEY, SW, HEX1, HEX0, LEDR);
	
	input [0:0] KEY;
	input [1:0] SW;
	output [0:6] HEX1, HEX0;
	output [7:0] LEDR;
	wire [7:0] Q;
	wire [6:0] and_out;
	
	T_FF u0 (KEY[0], SW[1], Q[0], SW[0]);
	assign and_out[0] = Q[0] & SW[1];
	
	T_FF u1 (KEY[0], and_out[0], Q[1], SW[0]);
	assign and_out[1] = Q[1] & and_out[0];
	
	T_FF u2 (KEY[0], and_out[1], Q[2], SW[0]);
	assign and_out[2] = Q[2] & and_out[1];
	
	T_FF u3 (KEY[0], and_out[2], Q[3], SW[0]);
	assign and_out[3] = Q[3] & and_out[2];
	
	T_FF u4 (KEY[0], and_out[3], Q[4], SW[0]);
	assign and_out[4] = Q[4] & and_out[3];
	
	T_FF u5 (KEY[0], and_out[4], Q[5], SW[0]);
	assign and_out[5] = Q[5] & and_out[4];
	
	T_FF u6 (KEY[0], and_out[5], Q[6], SW[0]);
	assign and_out[6] = Q[6] & and_out[5];
	
	T_FF u7 (KEY[0], and_out[6], Q[7], SW[0]);

	//Display on HEX1/0
	display_hex_7seg d0(Q[7], Q[6], Q[5], Q[4], HEX1);
	display_hex_7seg d1(Q[3], Q[2], Q[1], Q[0], HEX0);	
	
	assign LEDR = Q;
endmodule 