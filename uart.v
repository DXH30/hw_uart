module uart (
    input clk,
    input reset,
    input [7:0] tx_data,
    input tx_start,
    input rx,
    output tx,
    output [7:0] rx_data,
    output rx_ready,
    output tx_busy
);

wire baud_tick;

baud_rate_generator baud_gen (
    .clk(clk), 
    .reset(reset), 
    .baud_tick(baud_tick)
);

uart_tx transmitter (
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick),
    .tx_data(tx_data),
    .tx_start(tx_start),
    .tx(tx),
    .tx_busy(tx_busy)
);

uart_rx receiver (
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick),
    .rx_data(rx_data),
    .rx(rx)
);

endmodule
