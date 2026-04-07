module branch_logic(
    input Z,
    input N,
    input [2:0] format,
    input [3:0] opcode,
    input [15:0] pc,
    input [15:0] offset,

    output reg take_branch,
    output reg [15:0] target_pc
);

always @(*) begin
    take_branch = 0;
    target_pc = pc + 1;

    if (format == 3'b100) begin
        case (opcode)
            4'b0001: take_branch = Z;
            4'b0010: take_branch = !Z;
            4'b0011: take_branch = N;
            4'b0100: take_branch = (!Z && !N);
        endcase
    end

    else if (format == 3'b101) begin
        take_branch = 1;
    end

    if (take_branch)
        target_pc = pc + offset;
end

endmodule