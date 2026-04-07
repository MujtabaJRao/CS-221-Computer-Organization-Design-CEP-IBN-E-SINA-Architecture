module stack_memory(
    input clk,
    input [7:0] address,
    input [15:0] write_data,
    input write_enable,
    output reg [15:0] read_data
);

reg [15:0] mem [0:255];

always @(posedge clk) begin
    if (write_enable)
        mem[address] <= write_data;

    read_data <= mem[address];
end

endmodule