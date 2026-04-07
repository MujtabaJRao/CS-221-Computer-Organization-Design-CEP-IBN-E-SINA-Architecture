module alu(
    input [15:0] A,
    input [15:0] B,
    input [3:0] alu_op,   // ✅ FIXED

    output reg [15:0] result,
    output reg Z,
    output reg N
);

always @(*) begin
    case (alu_op)
        4'b0001: result = A + B;
        4'b0010: result = A - B;
        4'b0011: result = A * B;
        4'b0100: result = (B != 0) ? A / B : 0;
        4'b0101: result = A & B;
        4'b0110: result = A | B;
        default: result = 0;
    endcase

    Z = (result == 0);
    N = result[15];
end

endmodule