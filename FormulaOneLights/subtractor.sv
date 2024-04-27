module subtractor(
    input logic [13:0] sreg,
    output logic [13:0] data_out
);

    always_comb begin
        if (sreg > 14'd15750)
		  data_out = sreg - 14'd15500;
        else
            data_out = sreg + 14'd250;
    end

endmodule

