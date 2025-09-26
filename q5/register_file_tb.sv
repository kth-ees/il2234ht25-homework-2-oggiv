module registerfile_tb;

    logic clk;
    logic rst_n;
    logic write_en;
    logic [3:0] write_addr;
    logic [7:0] data_in;
    logic [3:0] read_addr1;
    logic [3:0] read_addr2;
    logic [7:0] data_out1;
    logic [7:0] data_out2;

    registerfile reg_file(
        .clk(clk),
        .rst_n(rst_n),
        .write_en(write_en),
        .write_addr(write_addr),
        .data_in(data_in),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .data_out1(data_out1),
        .data_out2(data_out2)
    );

    initial begin
        // initial state
        clk        = 0;
        rst_n      = 0;
        write_en   = 0;
        write_addr = 0000;
        data_in    = 00000000;
        read_addr1 = 0000;
        read_addr2 = 0000;
        #10ns;

        // setup a write, but don't write yet (no write_en)
        // we should not see an output
        clk        = 1;
        rst_n      = 1;
        write_en   = 0;
        write_addr = 0001;
        data_in    = 11111111;
        read_addr1 = 0001;
        read_addr2 = 0010;
        #10ns;
        clk = 0;
        #10ns;

        // write
        clk        = 1;
        rst_n      = 1;
        write_en   = 1;
        write_addr = 0010;
        data_in    = 11111111;
        read_addr1 = 0001;
        read_addr2 = 0010;
        #10ns;
        clk = 0;
        #10ns;

        // write another
        clk        = 1;
        rst_n      = 1;
        write_en   = 1;
        write_addr = 0001;
        data_in    = 00001111;
        read_addr1 = 0001;
        read_addr2 = 0010;
        #10ns;
        clk = 0;
        #10ns;

        // override write
        clk        = 1;
        rst_n      = 1;
        write_en   = 1;
        write_addr = 0010;
        data_in    = 00110011;
        read_addr1 = 0001;
        read_addr2 = 0010;
        #10ns;
        clk = 0;
        #10ns;

        // read empty
        clk        = 1;
        rst_n      = 1;
        write_en   = 0;
        write_addr = 0010;
        data_in    = 00110011;
        read_addr1 = 0010;
        read_addr2 = 1100;
        #10ns;
        clk = '0;
        #10ns;

        // write again
        clk        = 1;
        rst_n      = 1;
        write_en   = 1;
        write_addr = 1100;
        data_in    = 00110011;
        read_addr1 = 0010;
        read_addr2 = 1100;
        #10ns;
        clk = '0;
        #10ns;

        // reset
        clk        = 1;
        rst_n      = 0;
        write_en   = 0;
        write_addr = 0010;
        data_in    = 00110011;
        read_addr1 = 0001;
        read_addr2 = 0010;
        #10ns;
        clk = 0;
        #10ns;

        // no write
        clk        = 1;
        rst_n      = 1;
        write_en   = 0;
        write_addr = 0010;
        data_in    = 00110011;
        read_addr1 = 0001;
        read_addr2 = 0010;
        #10ns;
        clk = 0;
        #10ns;

        // done
        $stop;
    end

endmodule