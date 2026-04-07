module imm_gen(
    input [15:0] instruction,
    output [15:0] imm_out
);

assign imm_out = {8'b0, instruction[7:0]};

endmodule