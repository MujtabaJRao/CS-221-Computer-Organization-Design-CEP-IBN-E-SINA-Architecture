module top_module(
    input clk,
    input reset
);

// ========= FETCH =========
wire [15:0] pc_out, instruction;
wire [2:0] format = instruction[15:13];
wire [3:0] opcode = instruction[12:9];

// ========= CONTROL =========
wire push, pop, peek_en, halt;
wire branch_en, reg_write_en;
wire [3:0] alu_op;   // ✅ FIXED WIDTH
wire [1:0] mux_sel;

// ========= DATA =========
wire [15:0] imm, alu_result, reg_data;
wire [15:0] TOS, NOS;
wire [15:0] write_back;
wire [15:0] new_pc;
wire take_branch;

wire Z, N;

// ========= MEMORY =========
wire [7:0] mem_addr;
wire [15:0] mem_write_data, mem_read_data;
wire mem_write_en;

// ========= PC NEXT LOGIC =========
wire [15:0] pc_next;
assign pc_next = (take_branch) ? new_pc : (pc_out + 1);

// ========= MODULES =========

PC pc(
    .clk(clk),
    .reset(reset),
    .pc_en(!halt),
    .pc_in(pc_next),   // ✅ FIXED
    .pc_out(pc_out)
);

instruction_memory im(
    .address(pc_out),
    .instruction_out(instruction)
);

control_unit cu(
    .format(format),
    .opcode(opcode),
    .push(push),
    .pop(pop),
    .peek_en(peek_en),
    .halt(halt),
    .alu_op(alu_op),
    .reg_write_en(reg_write_en),
    .branch_en(branch_en),
    .mux_sel(mux_sel)
);

imm_gen ig(
    .instruction(instruction),
    .imm_out(imm)
);

register_file rf(
    .clk(clk),
    .write_enable(reg_write_en),
    .reg_sel(instruction[1:0]),
    .write_data(TOS),
    .reg_out(reg_data)
);

alu alu_unit(
    .A(TOS),
    .B(NOS),
    .alu_op(alu_op),
    .result(alu_result),
    .Z(Z),
    .N(N)
);

branch_logic bl(
    .Z(Z),
    .N(N),
    .format(format),
    .opcode(opcode),
    .pc(pc_out),
    .offset(imm),
    .take_branch(take_branch),
    .target_pc(new_pc)
);

// ===== STACK MEMORY =====
stack_memory sm(
    .clk(clk),
    .address(mem_addr),
    .write_data(mem_write_data),
    .write_enable(mem_write_en),
    .read_data(mem_read_data)
);

// ===== MUX =====
assign write_back =
    (mux_sel == 2'b00) ? alu_result :
    (mux_sel == 2'b01) ? imm :
    (mux_sel == 2'b10) ? reg_data :
                         pc_out;

// ===== STACK =====
stack_controller sc(
    .clk(clk),
    .reset(reset),
    .push(push),
    .pop(pop),
    .peek_en(peek_en),
    .data_in(write_back),
    .peek_addr_data(mem_read_data),

    .TOS(TOS),
    .NOS(NOS),
    .SP(),

    .mem_addr(mem_addr),
    .mem_write_data(mem_write_data),
    .mem_write_en(mem_write_en),
    .mem_read_data(mem_read_data)
);

endmodule