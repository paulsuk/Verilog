module part3(SW,LEDR);

input[9:0] SW;
output[1:0] LEDR;
wire[1:0] U, V, W, M;
wire s0, s1;

assign s1 = SW[9];
assign s0 = SW[8];
assign U = SW[1:0];
assign V = SW[3:2];
assign W = SW[5:4];

assign M[0] = (~s1 & ((~s0 & U[0]) | (s0 & V[0]))) | (s1 & W[0]);
assign M[1] = (~s1 & ((~s0 & U[1]) | (s0 & V[1]))) | (s1 & W[1]);

assign LEDR[0] = M[0];
assign LEDR[1] = M[1];

endmodule
