# Info
modul UART (Universal Asynchronous Receiver Transmitter) dengan verilog

# Cara test bench
```bash
iverilog -o uart_sim baud_rate_generator.v uart_tx.v uart_rx.v uart.v uart_tb.v
```

# Cara generate wavefrom
```
vvp uart_sim
```

# Cara buka wavefrom
```
gtkwave uart_wavefrom.vcd
```
