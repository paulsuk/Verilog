module part3(SW, CLOCK_50, KEY, LEDR);

	input [2:0] SW;
	input CLOCK_50;
	input [1:0] KEY;
	output reg [0:0] LEDR;

	reg y, Y;
	wire [2:0] n;
	reg [2:0] number;
	wire [3:0] bin_code; // converts dots and dashes to be fed into decoder
	reg [3:0] shift_reg;
	reg [3:0] k;
	reg [32:0] clock;
	initial clock= 0;
	
	
	// call the counter module to obtain number of dots/ dashes
	counter c1(SW[2:0], n, bin_code);
	
	always @(*)
		case(y)
			0: 
				if (!KEY[1])	//enable
					Y=1;
				else
					Y=0;
			1: 
			begin		// start shifting based on bin_code
				if (number == 0)
					Y=0;
				else
					Y=1;
			end
			default: Y=0;
		endcase
		

 //asynchronous FF assigns the next value
 always @(posedge CLOCK_50, negedge KEY[0])
	if (!KEY[0])	//reset
		y <= 0;
	else
		y <= Y;
		
always @ (posedge CLOCK_50) 
	begin
		if(y) 
			begin
				if(!KEY[1])		//enable
					begin
						LEDR[0] = 0;
						shift_reg= bin_code;
						number = n; // starting case= 0;
					end
				if( KEY[1] && clock == 0 && LEDR[0] == 1) 
					begin
						LEDR[0] =0;
						clock = 25000000; 
						number <= number -1;
						shift_reg [0] <= shift_reg [1];		// shift everything down
						shift_reg [1] <= shift_reg [2];
						shift_reg [2] <= shift_reg[3];
					end
				else if(KEY[1] && clock == 0 && LEDR[0] == 0) // indicates the 0.5 s break in between letters
					begin
						LEDR[0]= 1; //instant turn of the LED
						if (shift_reg[0] == 0) 
							begin
								clock= 25000000; // dot
							end
						else 
							begin
								clock= 75000000;   // dash
							end
					end
				else if (KEY[1]) // count down for the clock 
					clock <= clock -1;
			end
		else
			LEDR[0] = 0;
	end
endmodule


// Length counter
module counter(letter, n, bin_code);
	input [2:0] letter;
	output reg [2:0] n;
	output reg [3:0] bin_code;
	// dot= 0, dash= 1
	// right to left
	always @(*)
		case(letter)
			3'b000:
				begin
				n=2;  
				bin_code=0010;
				end
			3'b001:
				begin
				n=4;
				bin_code=0001;
				end
			3'b010:
				begin
				n=4;
				bin_code=0101;
				end
			3'b011:
				begin
				n=3;
				bin_code= 0001;
				end
			3'b100:
				begin
				n=1;
				bin_code= 0000;
				end
			3'b101:
				begin
				n=4;
				bin_code= 0100;
				end
			3'b110:
				begin
				n=3;
				bin_code= 0011;
				end
			3'b111:
				begin
				n=4;
				bin_code=0000;
				end
			default:
				begin
				n=0;
				bin_code= 0000;
				end
			endcase
endmodule			