module PC(
    input clk,
    input reset,
    input pc_en,
    input [15:0] pc_in,
    output reg [15:0] pc_out
);

always @(posedge clk or posedge reset) begin
    if (reset)
        pc_out <= 0;
    else if (pc_en)
        pc_out <= pc_in;
end

endmodule
