module register_file(
    input clk,
    input write_enable,
    input [1:0] reg_sel,
    input [15:0] write_data,
    output [15:0] reg_out
);

reg [15:0] regs [0:3];

always @(posedge clk) begin
    if (write_enable)
        regs[reg_sel] <= write_data;
end

assign reg_out = regs[reg_sel];

endmodule