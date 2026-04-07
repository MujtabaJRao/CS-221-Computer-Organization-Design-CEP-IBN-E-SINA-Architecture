module control_unit(
    input [2:0] format,
    input [3:0] opcode,

    output reg push,
    output reg pop,
    output reg peek_en,
    output reg halt,

    output reg [3:0] alu_op,
    output reg reg_write_en,
    output reg branch_en,
    output reg [1:0] mux_sel
);

always @(*) begin
    // defaults
    push = 0; pop = 0; peek_en = 0;
    halt = 0;
    alu_op = 0;
    reg_write_en = 0;
    branch_en = 0;
    mux_sel = 0;

    case (format)

    // SYS
    3'b000: begin
        if (opcode == 4'b1111)
            halt = 1;
    end

    // ALU
    3'b001: begin
        pop = 1;
        push = 1;
        alu_op = opcode;
        mux_sel = 0;
    end

    // REG
    3'b010: begin
        if (opcode == 4'b0001) begin
            push = 1;
            mux_sel = 2;
        end
        else if (opcode == 4'b0010) begin
            pop = 1;
            reg_write_en = 1;
        end
    end

    // DATA
    3'b011: begin
        if (opcode == 4'b0001) begin
            push = 1;
            mux_sel = 1;
        end
        else if (opcode == 4'b0010) begin
            peek_en = 1;
        end
    end

    // COND
    3'b100: begin
        branch_en = 1;
        pop = 1;
    end

    // FLOW
    3'b101: begin
        branch_en = 1;
        if (opcode == 4'b0010) begin
            push = 1;
            mux_sel = 3; // push PC
        end
    end

    endcase
end

endmodule