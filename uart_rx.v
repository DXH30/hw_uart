module uart_rx (
    input clk,
    input reset,
    input baud_tick,
    input rx,
    output reg [7:0] rx_data,
    output reg rx_ready
);

reg [3:0] bit_counter;
reg [7:0] shift_reg;
reg rx_state;

parameter IDLE = 1'b0;
parameter RECEIVE = 1'b1;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        rx_data <= 0;
        rx_ready <= 0;
        bit_counter <= 0;
        shift_reg <= 0;
        rx_state <= IDLE;
    end else begin
        case (rx_state)
            IDLE: begin
                rx_ready <= 0;
                if (~rx) begin // start bit detected
                    bit_counter <= 0;
                    rx_state <= RECEIVE;
                end
            end
            RECEIVE: begin
                if (baud_tick) begin
                    if (bit_counter < 8) begin
                        shift_reg <= {rx, shift_reg[7:1]};
                        bit_counter <= bit_counter + 1;
                    end else begin
                        rx_data <= shift_reg;
                        rx_ready <= 1;
                        rx_state <= IDLE;
                    end
                end
            end
        endcase
    end
end

endmodule
