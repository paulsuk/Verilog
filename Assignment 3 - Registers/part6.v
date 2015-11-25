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


module part6(CLOCK_50, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input CLOCK_50;
	input [1:0] SW;
	output [0:6] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	reg [25:0] Q;
	reg [3:0] A;
	wire sec;
	reg [11:0] temp;
	
	// 50MHz to ~= 1 Hz
	always @ (posedge CLOCK_50, negedge SW[0])
		if(~SW[0])
			Q <= 26'b1;
		else
			Q <= Q + 1;	
	
	// Enable
	assign sec = (Q == 0);
	
	// 3Bit Counter
	always @ (posedge CLOCK_50, negedge SW[0])
		if(~SW[0])
			A <= 3'b0;
		else
			if(sec)
				if (A == 3'd5)
					A <= 3'b0;
				else
					A <= A + 1;
	
	// Cylcying through displays in ticker-tape fashion 	
	always @(A)
	case(A)
		3'b000: temp = 12'b111111000110;
		3'b001: temp = 12'b111100011011;
		3'b010: temp = 12'b110001101111;
		3'b011: temp = 12'b000110111111;
		3'b100: temp = 12'b011011111100;
		3'b101: temp = 12'b101111110001;
		default: temp = 12'b111111111111;
	endcase
		
	char_7seg u0(temp[1:0], HEX0);
	char_7seg u1(temp[3:2], HEX1);
	char_7seg u2(temp[5:4], HEX2);
	char_7seg u3(temp[7:6], HEX3);
	char_7seg u4(temp[9:8], HEX4);
	char_7seg u5(temp[11:10], HEX5);

endmodule 	