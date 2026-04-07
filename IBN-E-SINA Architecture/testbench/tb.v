`timescale 1ns/1ps

module top_module_tb;

// ================= SIGNALS =================
reg clk;
reg reset;

// ================= DUT (Device Under Test) =================
top_module uut (
    .clk(clk),
    .reset(reset)
);

// ================= CLOCK GENERATOR =================
always #5 clk = ~clk;  // 100MHz Clock

// ================= INITIALIZATION & RESET =================
initial begin
    $display("--- Initializing Ibn-e-Sina Simulation ---");
    clk = 0;
    reset = 1;

    // Apply reset for 2 clock cycles
    #20;
    reset = 0;
    $display("--- Reset De-asserted. Execution Starting ---");
end

// ================= QUESTA WAVEFORM CONFIG =================
initial begin
    // These commands tell Questa to record all internal signals 
    // for the Wave window (.vcd or .wlf)
    $dumpfile("ibnesina_sim.vcd");
    $dumpvars(0, top_module_tb);
    
    // Safety Timeout: Prevents infinite loops if HALT is never reached
    #10000; 
    $display("❌ TIMEOUT: Simulation forced to stop after 10,000ns.");
    $finish;
end

// ================= ENHANCED MONITOR =================
// This displays the Format and Opcode separately for easier debugging
initial begin
    $display("\nTime\tPC\t[FMT][OPC]\tInstr\tTOS\tNOS\tSP\tHalt");
    $display("-----------------------------------------------------------------------------");

    forever begin
        @(negedge clk); // Sample on falling edge for stable signals
        if (!reset) begin
            $display("%0t\t%d\t[%b][%b]\t%h\t%d\t%d\t%d\t%b",
                $time,
                uut.pc_out,            // Your PC output
                uut.instruction[15:13],// Dedicated Format Field
                uut.instruction[12:9], // Dedicated Opcode Field
                uut.instruction,       // Full 16-bit Hex
                uut.TOS,               // Top of Stack Cache
                uut.NOS,               // Next of Stack Cache
                uut.sc.SP,             // Internal Stack Pointer from SC
                uut.halt               // Halt Signal
            );
        end
    end
end

// ================= STOP ON HALT =================
initial begin
    wait(uut.halt == 1);
    #20;
    $display("-----------------------------------------------------------------------------");
    $display("🚀 SUCCESS: HALT Instruction Executed.");
    $display("Simulation stopping at time %0t", $time);
    $stop; // Pauses in Questa so you can inspect the waves
end
initial begin
    #50;
    $display("Instruction = %h", uut.instruction);
end
endmodule