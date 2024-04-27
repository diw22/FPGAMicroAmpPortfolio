module countingreaction(
    input logic reactiontrigger,
    input logic tick_ms,
    input logic button,
    input logic rst,
    output logic [13:0] reaction_time
);

logic [13:0] count;


always_ff @ (posedge tick_ms, posedge button, posedge rst) begin
    if (rst) begin
        count <= 14'b0;
        reaction_time <= 14'b0;
    end
    else if (button)
    reaction_time <= count;
    else if (reactiontrigger)
    count <= count + 14'b1;
    else
    count <= count;
    
end

endmodule