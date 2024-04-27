module reactiontime_top (
    input logic         MAX10_CLK1_50,
    input logic  [1:0]  KEY,
    output logic [9:0]  LEDR,
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4
);

logic tick_ms;
logic tick_halfs;
logic [13:0] x;
logic [13:0] data_out;
logic trigger;
logic time_out;
logic en_lfsr;
logic start_delay;
logic reactiontrigger;
logic [13:0] reaction_time;
//logic tick_2sec;



clktick div50k (   .clk(MAX10_CLK1_50),
                    .rst(1'b0),
                    .en(1'b1),
                    .N(16'd49999),
                    .tick(tick_ms)
                    );

clktick div500 (    .clk(MAX10_CLK1_50),
                    .rst(1'b0),
                    .en(tick_ms),
                    .N(16'd499),
                    .tick(tick_halfs)
                    );


fsm fsm_formone (

.clk(tick_ms),
.tick(tick_halfs),
.trigger(~KEY[1]),
.rst(1'b0),
.time_out(time_out),
.en_lfsr(en_lfsr),
.start_delay(start_delay),
.ledr(LEDR[9:0]),
.reactiontrigger(reactiontrigger)
);



lsfr13 lsfr1 (
    .clk(tick_ms),
    .en(en_lfsr),
    .rst(~KEY[1]),
    .data_out(x)
);


subtractor subs (.sreg(x),
					.data_out(data_out)
					);

delay delay_count (
				.N(data_out),
				.clk(tick_ms),
				.en_lfsr(en_lfsr),
				.trigger(start_delay),
				.time_out(time_out)
				
);
countingreaction reaction0 ( 	.reactiontrigger(reactiontrigger),
										.tick_ms(tick_ms),
										.button(~KEY[0]),
										.rst(~KEY[1]),
										.reaction_time(reaction_time)
										);

								
										
										
logic[3:0] BCD0, BCD1, BCD2, BCD3, BCD4;




bin2bcd_16 BCDcount (.x(reaction_time),
                .BCD0(BCD0),
                .BCD1(BCD1),
                .BCD2(BCD2),
                .BCD3(BCD3),
                .BCD4(BCD4)
);



hexto7seg SEG0 (.out(HEX0), .in(BCD0));
hexto7seg SEG1 (.out(HEX1), .in(BCD1));
hexto7seg SEG2 (.out(HEX2), .in(BCD2));
hexto7seg SEG3 (.out(HEX3), .in(BCD3));
hexto7seg SEG4 (.out(HEX4), .in(BCD4));

endmodule
