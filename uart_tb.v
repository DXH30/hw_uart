module uart_tb;
reg clk;
reg reset;
reg [7:0] tx_data;
reg tx_start;
wire tx;
wire [7:0] rx_data;
wire rx_ready;
wire tx_busy;
reg rx;

uart uut (
    .clk(clk),
    .reset(reset),
    .tx_data(tx_data),
    .tx_start(tx_start),
    .rx(rx),
    .tx(tx),
    .rx_data(rx_data),
    .rx_ready(rx_ready),
    .tx_busy(tx_busy)
);

initial begin
    $dumpfile("uart_wavefrom.vcd");
    $dumpvars(0, uart_tb);

    clk = 0;
    reset = 1;
    tx_data = 8'hA5;
    tx_start = 0;
    rx = 1;

    #10 reset = 0;
    #20 tx_start = 1;
    #10 tx_start = 0;
    #100000;

    rx = 0;

    #10417 rx = 1; // Bit 0
    #10417 rx = 0; // Bit 1
    #10417 rx = 1; // Bit 2
    #10417 rx = 0; // Bit 3
    #10417 rx = 1; // Bit 4
    #10417 rx = 0; // Bit 5
    #10417 rx = 1; // Bit 6
    #10417 rx = 0; // Bit 7

    #10417;

    $finish;
end

always #5 clk = ~clk; // 100 MHz clock

endmodule
