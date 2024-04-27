module processorone (
    input logic [9:0] SW,
    input logic [9:0] data_in,
    input logic data_valid,
    input logic sysclk,
    output logic [9:0] data_out,
    output logic [3:0] BCD0, BCD1, BCD2, BCD3, BCD4
);

    logic [9:0]			x,y;
	 logic					enable;
    logic [12:0]        rdaddr_sig;
    logic [12:0]        wdaddr_sig;
    logic [9:0]         q_sig;
    logic [9:0]         subtractor;


	parameter 		ADC_OFFSET = 10'd512;
	parameter 		DAC_OFFSET = 10'd512;

	assign x = data_in[9:0] - ADC_OFFSET;
	


	pulse_gen  PULSE (.clk(sysclk), .rst(1'b0), .in(data_valid), .pulse(enable) );

    counterofbits CTR0 (.in(~data_valid), .rst(1'b0), .en(1'b1), .out(rdaddr_sig[12:0]));


assign wdaddr_sig = rdaddr_sig[12:0] + {SW[9:0], 3'b0};

RAM RAM_inst(
         .clock(sysclk),
         .data(y[9:1]), 
         .rdaddress(rdaddr_sig[12:0]),
         .rden(enable),
         .wraddress(wdaddr_sig),
         .wren(enable),
         .q(q_sig[9:0]),
    
    );

    assign subtractor = {q_sig[8],q_sig[8:0]};

	 assign y = x[9:0] - subtractor[9:0];

	
	//  Now clock y output with system clock
	always @(posedge sysclk)
		if (SW[9:0] == 10'b0)
		data_out <= x[9:0] + DAC_OFFSET;
		else if (enable == 1'b1)
			data_out <=  y + DAC_OFFSET;






logic [19:0] delay;
assign delay = SW[9:0] * 10'd819;

bin2bcd_16 converter (.x({6'b0, delay[19:10]}),
                    .BCD0(BCD0),
                    .BCD1(BCD1),
                    .BCD2(BCD2),
                    .BCD3(BCD3),
                    .BCD4(BCD4)
                    );



endmodule
