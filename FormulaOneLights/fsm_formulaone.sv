module fsm(
    input logic clk, //tick_ms
    input logic tick, //tick_halfs
    input logic trigger, rst, // ~KEY[1], ~KEY[0]
    input logic time_out, //coming from delay
    output logic en_lfsr, // enable for lfsr
    output logic start_delay,
    output logic [9:0] ledr,
	 output logic reactiontrigger
);
 
    //Define our states 
    typedef enum {all_off, zero, one, two, three, four, five, six, seven, eight, nine, all_on} mystate;
	 mystate current_state, next_state;

    //state transition
    always_ff @(posedge clk, posedge rst)
        if(rst)     current_state <= all_off;
        else        current_state <= next_state;

    //next state logic 
    always_comb
        case(current_state)
            all_off:    if(trigger == 1'b1)     next_state=zero;
                        else                    next_state = current_state;
            zero:    	if(tick == 1'b1) 			next_state = one;
                        else                		next_state = current_state;
				one:    		if(tick == 1'b1) 			next_state = two;
                        else                		next_state = current_state;
				two:    		if(tick == 1'b1) 			next_state = three;
                        else                		next_state = current_state;
				three:    	if(tick == 1'b1) 			next_state = four;
                        else                		next_state = current_state;
				four:    	if(tick == 1'b1) 			next_state = five;
                        else                		next_state = current_state;
				five:    	if(tick == 1'b1) 			next_state = six;
                        else                		next_state = current_state;
				six:    		if(tick == 1'b1) 			next_state = seven;
                        else                		next_state = current_state;
				seven:    	if(tick == 1'b1) 			next_state = eight;
                        else                		next_state = current_state;
				eight:    	if(tick == 1'b1) 			next_state = nine;
                        else                		next_state = current_state;
				nine:    	if(tick == 1'b1) 			next_state = all_on;
                        else                		next_state = current_state;
            all_on:     if(time_out == 1'b1) 	next_state = all_off;
                        else                 	next_state = current_state;
            default: next_state = all_off;
        endcase
    
    //output logic
    always_comb
        case (current_state)
            all_off:     begin
									 reactiontrigger = 1'b1;
									 ledr = 10'b0;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
            zero:        begin
									 reactiontrigger = 1'b0;
									 ledr = 10'b0;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
				one:        begin
									 reactiontrigger = 1'b0;
									 ledr = 10'b0000000001;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
				two:        begin
									 reactiontrigger = 1'b0;
									 ledr = 10'b0000000011;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
				three:        begin
									 reactiontrigger = 1'b0;
									 ledr = 10'b0000000111;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
				four:        begin
									 reactiontrigger = 1'b0;
									 ledr = 10'b0000001111;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
				five:        begin
									 reactiontrigger = 1'b0;
									 ledr = 10'b0000011111;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
				six:        begin
									 reactiontrigger = 1'b0;
									 ledr = 10'b0000111111;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
				seven:        begin
									 reactiontrigger = 1'b0;
									 ledr = 10'b0001111111;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
				eight:        begin
									 reactiontrigger = 1'b0;
									 ledr = 10'b0011111111;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
				nine:        begin
									 reactiontrigger = 1'b0;
									 ledr = 10'b0111111111;
                            en_lfsr = 1'b0;
                            start_delay = 1'b0;
									 end
            all_on:         begin 
									 reactiontrigger = 1'b0;
									 ledr = 10'd1023;
                            en_lfsr = 1'b0;
                            start_delay = 1'b1;
									 end
				default:        begin
									 reactiontrigger = 1'b0;
								    ledr = 10'b0;
                            en_lfsr = 1'b1;
                            start_delay = 1'b0;
									 end
        endcase
endmodule 
    
//module fsm(
//    input logic clk, //tick_ms
//    input logic tick, //tick_halfs
//    input logic trigger, rst, // ~KEY[1], ~KEY[0]
//    input logic time_out, //coming from delay
//    output logic en_lfsr, // enable for lfsr
//    output logic start_delay,
//    output logic [9:0] ledr
//);
//    logic [9:0] count; 
//	assign count = 10'b0;
//
//    //Define our states 
//    typedef enum {all_off, ramp_up, all_on} mystate;
//	 mystate current_state, next_state;
//
//    //state transition
//    always_ff @(posedge clk, posedge rst)
//        if(rst)     current_state <= all_off;
//        else        current_state <= next_state;
//
//    //next state logic 
//    always 
//        case(current_state)
//            all_off:    if(trigger == 1'b1)     next_state=ramp_up;
//                        else                    next_state = current_state;
//            ramp_up:    if((tick == 1'b1) & (count == 10'b0111111111)) next_state = all_on;
//                        else if(tick == 1'b1)                next_state = current_state;
//            all_on:     if(time_out == 1'b1) next_state = all_off;
//                        else                 next_state = current_state;
//            default: next_state = all_off;
//        endcase
//    
//    //output logic
//    always
//        case (current_state)
//            all_off:        begin
//									 ledr = 10'b0;
//                            en_lfsr = 1'b0;
//                            start_delay = 1'b0;
//									 end
//            ramp_up:        begin
//									 ledr = count;
//                            if(count == 10'b0)  count = count + 1;
//                            else                count = {count[8:0], 1'b1};
//                            en_lfsr = 1'b0;
//                            start_delay = 1'b0;
//									 end
//            all_on:         begin 
//									 ledr = 10'd1023;
//                            en_lfsr = 1'b1;
//                            start_delay = 1'b1;
//									 end
//        default:            begin
//								    ledr = 10'b0;
//                            en_lfsr = 1'b0;
//                            start_delay = 1'b0;
//									 end
//        endcase
//endmodule 
    






