module delay(
	input	logic		[13:0] N,
	input logic		en_lfsr,
	input logic 	clk,
	input logic 	trigger,
	output logic 	time_out
);

logic [13:0] count;


always_ff @ (posedge clk)
	
	if (~en_lfsr) begin
		time_out <= 1'b0;
		count <= N;
		if (trigger) begin
		if(count == 0) begin
			time_out <= 1'b1;
			count <= N;
			end
		else begin
		time_out <= 1'b0;
		count <= count - 1'b1;
		end
	end
	end
 

endmodule











 