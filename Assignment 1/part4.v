module part4(SW, HEX0);

input [1:0] SW;
output [0:6] HEX0;
wire c1, c0;

assign c1 = SW[1];
assign c0 = SW[0];

assign HEX0[0] = ~c0 | c1;
assign HEX0[1] = c0;
assign HEX0[2] = c0;
assign HEX0[3] = c1;
assign HEX0[4] = c1;
assign HEX0[5] = ~c0 | c1;
assign HEX0[6] = c1;

endmodule