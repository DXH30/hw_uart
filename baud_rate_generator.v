module baud_rate_generator (
    input clk,
    input reset,
    output reg baud_tick
);

parameter BAUD_DIVISOR = 10417; // divisor for 9600 baud rate with 100 MHz clock

reg[13:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 0;
        baud_tick <= 0;
    end else begin
        if (counter == BAUD_DIVISOR - 1) begin
            counter <= 0;
            baud_tick <= 1;
        end else begin
            counter <= counter + 1;
            baud_tick <= 0;
        end
    end
end

endmodule
