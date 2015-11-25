module part1 (SW, KEY, LEDR);
	input [1:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
	
	reg [8:0] Y, y = 000000001;
	parameter A = 9'b 000000001;
	
	always @ (*)
	begin
		Y[8] = (y[7] & SW[1]) | (y[8] & SW[1]);
		Y[7] = y[6] & SW[1];
		Y[6] = y[5] & SW[1];
		Y[5] = (y[0] & SW[1]) | (y[1] & SW[1]) | (y[2] & SW[1]) | (y[3] & SW[1]) | (y[4] & SW[1]);
		Y[4] = (y[3] & ~SW[1]) | (y[4] & ~SW[1]);
		Y[3] = (y[2] & ~SW[1]);
		Y[2] = (y[1] & ~SW[1]);
		Y[1] = (y[0] & ~SW[1]) | (y[5] & ~SW[1]) | (y[6] & ~SW[1]) | (y[7] & ~SW[1]) | (y[8] & ~SW[1]);
		Y[0] = 0;
	end 
		
	always @ (posedge KEY[0])
		if (!SW[0])
			y <= A;
		else	
			y <= Y;
	
	assign LEDR[9] = (y[4] | y[8]);
	assign LEDR[8] = y[8];
	assign LEDR[7] = y[7];
	assign LEDR[6] = y[6];
	assign LEDR[5] = y[5];
	assign LEDR[4] = y[4];
	assign LEDR[3] = y[3];
	assign LEDR[2] = y[2];
	assign LEDR[1] = y[1];
	assign LEDR[0] = y[0];
endmodule 