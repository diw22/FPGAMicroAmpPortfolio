module hexto7seg	(
	output logic [6:0]	out,
	input  logic [4:0]	in
);

	always_comb
		case (in)
		5'h0: out = 7'b1000000;
		5'h1: out = 7'b1111001;
		5'h2: out = 7'b0100100;
		5'h3: out = 7'b0110000;
		5'h4: out = 7'b0011001;
		5'h5: out = 7'b0010010;
		5'h6: out = 7'b0000010;
		5'h7: out = 7'b1111000;
		5'h8: out = 7'b0000000;
		5'h9: out = 7'b0011000;
		5'ha: out = 7'b0001000;
		5'hb: out = 7'b0000011;
		5'hc: out = 7'b1000110;
		5'hd: out = 7'b0100001;
		5'he: out = 7'b0000110;
		5'hf: out = 7'b0001110;
		5'b10000: out = 7'b0001111; //t
		5'b10001: out = 7'b1001011; //L
		5'b10111: out = 7'b1111111; //nothing
		5'b10010: out = 7'b0101111; //r
		5'b11011: out = 7'b0010000; //g
		default: out = 7'b0000000;
	endcase
	
endmodule