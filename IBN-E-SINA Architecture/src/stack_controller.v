module stack_controller(
    input clk,
    input reset,
    input push,
    input pop,
    input peek_en,
    input [15:0] data_in,
    input [15:0] peek_addr_data,

    output reg [15:0] TOS,
    output reg [15:0] NOS,
    output reg [7:0] SP,

    // memory interface
    output reg [7:0] mem_addr,
    output reg [15:0] mem_write_data,
    output reg mem_write_en,
    input [15:0] mem_read_data
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        SP <= 0;
        TOS <= 0;
        NOS <= 0;
    end
    else begin
        mem_write_en <= 0;

        // ================= PUSH =================
        if (push) begin
            if (SP >= 2) begin
                // spill NOS to memory
                mem_addr <= SP - 2;
                mem_write_data <= NOS;
                mem_write_en <= 1;
            end

            NOS <= TOS;
            TOS <= data_in;
            SP <= SP + 1;
        end

        // ================= POP =================
        else if (pop) begin
            TOS <= NOS;

            if (SP > 2) begin
                mem_addr <= SP - 3;
                NOS <= mem_read_data;
            end

            SP <= SP - 1;
        end

        // ================= PEEK =================
        else if (peek_en) begin
            NOS <= TOS;
            TOS <= peek_addr_data;
            SP <= SP + 1;
        end
    end
end

endmodule