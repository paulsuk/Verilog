module part1 (SW, HEX0, HEX1);

	input [7:0] SW; // slide switches
	output [0:6] HEX1, HEX0; // 7-seg display
	
	assign HEX0[0] = (SW[3] & SW[2]) | (SW[3] & ~ SW[2] & SW[1] & SW[0]) | (~SW[3] & SW[2] & ~SW[0]) | (~SW[3] & ~ SW[2] & ~SW[1] & SW[0]);
	assign HEX0[1] = (SW[3] & SW[2]) | (SW[3] & ~ SW[2] & SW[1] & SW[0]) | (SW[2] & ~SW[1] & SW[0]) | (SW[2] & SW[1] & ~SW[0]);
	assign HEX0[2] = (SW[3] & SW[2]) | (SW[3] & ~ SW[2] & SW[1] & SW[0]) | (~SW[3] & ~ SW[2] & SW[1] & ~SW[0]);
	assign HEX0[3] = (SW[3] & SW[2]) | (SW[3] & SW[1]) | (SW[3] & SW[0])| (SW[2] & SW[1] & SW[0]) | (SW[2] & ~SW[1] & ~SW[0]) | (~SW[2] & ~SW[1] & SW[0]);
	assign HEX0[4] = (SW[3] & SW[2]) | (SW[3] & ~ SW[2] & SW[1] & SW[0]) | (~SW[3] & SW[0]) | (~SW[2] & ~SW[1] & SW[0]) | (~SW[3] & SW[2] & ~SW[1]);
	assign HEX0[5] = (SW[3] & SW[2]) | (SW[1] & SW[0]) | (~SW[3] & ~SW[2] & SW[1]) | (~SW[3] & ~SW[2] & SW[0]);
	assign HEX0[6] = (SW[3] & SW[2]) | (SW[3] & ~ SW[2] & SW[1] & SW[0]) | (~SW[3] & ~SW[2] & ~SW[1]) | (~SW[3] & SW[2] & SW[1] & SW[0]);
	
	assign HEX1[0] = (SW[7] & SW[6]) | (SW[7] & ~SW[6] & SW[5] & SW[4]) | (~SW[7] & SW[6] & ~SW[4]) | (~SW[7] & ~ SW[6] & ~SW[5] & SW[4]);
	assign HEX1[1] = (SW[7] & SW[6]) | (SW[7] & ~SW[6] & SW[5] & SW[4]) | (SW[6] & ~SW[5] & SW[4]) | (SW[6] & SW[5] & ~SW[4]);
	assign HEX1[2] = (SW[7] & SW[6]) | (SW[7] & ~SW[6] & SW[5] & SW[4]) | (~SW[7] & ~SW[6] & SW[5] & ~SW[4]);
	assign HEX1[3] = (SW[7] & SW[6]) | (SW[7] & SW[5]) | (SW[7] & SW[4])| (SW[6] & SW[5] & SW[4]) | (SW[6] & ~SW[5] & ~SW[4]) | (~SW[6] & ~SW[5] & SW[4]);
	assign HEX1[4] = (SW[7] & SW[6]) | (SW[7] & ~SW[6] & SW[5] & SW[4]) | (~SW[7] & SW[4]) | (~SW[6] & ~SW[5] & SW[4]) | (~SW[7] & SW[6] & ~SW[5]);
	assign HEX1[5] = (SW[7] & SW[6]) | (SW[5] & SW[4]) | (~SW[7] & ~SW[6] & SW[5]) | (~SW[7] & ~SW[6] & SW[4]);
	assign HEX1[6] = (SW[7] & SW[6]) | (SW[7] & ~SW[6] & SW[5] & SW[4]) | (~SW[7] & ~SW[6] & ~SW[5]) | (~SW[7] & SW[6] & SW[5] & SW[4]);
	
endmodule
