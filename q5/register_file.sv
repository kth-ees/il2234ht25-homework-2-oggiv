module registerfile (
    input logic clk,
    input logic rst_n,
    input logic write_en,
    input logic [3:0] write_addr,
    input logic [7:0] data_in,
    input logic [3:0] read_addr1,
    input logic [3:0] read_addr2,
    output logic [7:0] data_out1,
    output logic [7:0] data_out2
);

    // this is a register file with a width of 8 bits and a depth of 16 registers
    // it has an asynchronous negative reset
    // it has a write-enable signal and one synchronous write input
    // it has two synchronous read outputs, each with their own respective read address inputs

    // a register file is an array of flip-flops
    // the width is defined first and the depth second
    logic [15:0][7:0] reg_file;

    // the main always_ff procedure should trigger both on clock and on reset
    always_ff @(posedge clk or negedge rst_n) begin
        // we reset the contents to the reg file if the rst_n signal is disabled (low)
        // this behavior is asynchrous, as it is triggered by rst_n rather than clk
        if(~rst_n) begin
            for (int i = 0; i < 16; i++) begin
                reg_file <= '0;
            end
        // we may only write if the write_en signal is enabled (high)
        end else if (write_en) begin
            reg_file[write_addr] <= data_in;
        end
    end

    // the specifications say that "the read is synchronized with the clock",
    // so we add flip-flops to the output to achieve this behavior
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            data_out1 <= '0;
            data_out2 <= '0;
        end else begin
            data_out1 <= reg_file[read_addr1];
            data_out2 <= reg_file[read_addr2];   
        end
    end

endmodule