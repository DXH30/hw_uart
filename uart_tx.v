module uart_tx (
    input clk,
    input reset,
    input baud_tick,
    input [7:0] tx_data,
    input tx_start,
    output reg tx,
    output reg tx_busy
);
    reg [3:0] bit_counter;
    reg [7:0] shift_reg;
    reg tx_state;

    parameter IDLE = 1'b0;
    parameter TRANSMIT = 1'b1;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tx <= 1;
            tx_busy <= 0;
            bit_counter <= 0;
            shift_reg <= 0;
            tx_state <= IDLE;
        end else begin
            case (tx_state)
                IDLE: begin
                    tx <= 1;
                    if (tx_start) begin
                        shift_reg <= tx_data;
                        tx_busy <= 1;
                        bit_counter <= 0;
                        tx_state <= TRANSMIT;
                    end
                end
                TRANSMIT: begin
                    if (baud_tick) begin
                        if (bit_counter == 0) begin
                            tx <= 0; // start bit
                        end else if (bit_counter <= 8) begin
                            tx <= shift_reg[0];
                            shift_reg <= shift_reg >> 1;
                        end else if (bit_counter == 9) begin
                            tx <= 1;
                        end else begin
                            tx_state <= IDLE;
                            tx_busy <= 0;
                        end
                        bit_counter <= bit_counter + 1;
                    end
                end
            endcase
        end
    end
endmodule
