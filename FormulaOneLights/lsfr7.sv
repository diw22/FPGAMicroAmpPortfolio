module lsfr13(
	input	logic clk,
	input logic rst,
	input logic en,
	output logic [14:1] data_out
	);
	logic [14:1] sreg;
	
	always_ff @ (posedge clk, posedge rst)
		if (rst)
			sreg <= 14'd1;
		else
			if (en)
				sreg <= {sreg[13:1], sreg[14] ^ sreg[10] ^ sreg[6] ^ sreg[1]};
			else 
			sreg <= sreg;

assign data_out = sreg;

	
endmodule