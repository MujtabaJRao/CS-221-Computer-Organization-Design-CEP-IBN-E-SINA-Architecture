module instruction_memory(
    input [15:0] address,
    output [15:0] instruction_out
);

reg [15:0] memory [0:255];

initial begin
    $readmemh("program.mem", memory);  // ✅ ENABLED
end

assign instruction_out = memory[address];

endmodule