module processor (
	input  logic		sysclk,			// system clock
	input  logic [9:0]	data_in,		// 10-bit input data
	input  logic		data_valid,	// asserted when sample data is ready for processing
	input  logic		rst,
	output logic [9:0] 	data_out		// 10-bit output data
);

	logic [9:0]			x,y;
	logic				enable;
	logic				fifo_state;
	logic				full_sig;
	logic	[9:0]		q_sig;
	

	parameter 		ADC_OFFSET = 10'd512;
	parameter 		DAC_OFFSET = 10'd512;

	assign x = data_in[9:0] - ADC_OFFSET;		// x is input in 2's complement


	

	
	pulse_gen  PULSE (.clk(sysclk), .rst(1'b0), .in(data_valid), .pulse(enable) );

//	assign y = x[9:0] - ({q_sig[9], q_sig[9:1]}); multiple
//assign y = x[9:0] + ({q_sig[9], q_sig[9:1]}); single delay
	
//		fifo	fifo_inst (
//	.clock ( sysclk ),
//	.data ( x[9:0] ), //use y[9:0] for multiple
//	.rdreq ( fifo_state & enable ),
//	.wrreq ( enable ),
//	.full ( full_sig ),
//	.q ( q_sig )
//	);
//	
//	fifo_fsm fsm_inst (
//		.clk (sysclk),
//		.rst (rst),
//		.in (full_sig),
//		.fifo_state (fifo_state)
//		);
	



	assign data_out =  y + DAC_OFFSET;
			
	
		
endmodule




