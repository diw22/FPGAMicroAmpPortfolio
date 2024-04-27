module counterofbits(
input logic in,
input logic rst,
input logic en,
output logic [12:0] out
);

always_ff @(posedge in)
if (rst) out <= 13'b0;
else out <= out + {12'b0, en};
endmodule
