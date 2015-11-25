module part2 (SW, KEY, LEDR);
	input [1:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
	reg [3:0] y_Q, Y_D; // y_Q represents current state, Y_D represents next state
	parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100,
	F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000;

	always @(SW[1], y_Q)
	begin
		case (y_Q)
			A: if (!SW[1]) Y_D = B;
			else Y_D = F;
			
			B: if (!SW[1]) Y_D = C;
			else Y_D = F;
			
			C: if (!SW[1]) Y_D = D;
			else Y_D = F;
			
			D: if (!SW[1]) Y_D = E;
			else Y_D = F;
			
			E: if (!SW[1]) Y_D = E;
			else Y_D = F;
			
			F: if (!SW[1]) Y_D = B;
			else Y_D = G;
			
			G: if (!SW[1]) Y_D = B;
			else Y_D = H;
			
			H: if (!SW[1]) Y_D = B;
			else Y_D = I;
			
			I: if (!SW[1]) Y_D = B;
			else Y_D = I;
			
			default: Y_D = 4'bxxxx;
		endcase
	end // state_table
	
	always @(posedge KEY[0])
				if (!SW[0])
			y_Q <= A;
		else	
			y_Q <= Y_D;
	
	assign LEDR[9] = (y_Q == E) | (y_Q == I);
	assign LEDR[3] = y_Q[3];
	assign LEDR[2] = y_Q[2];
	assign LEDR[1] = y_Q[1];
	assign LEDR[0] = y_Q[0];
	
endmodule 