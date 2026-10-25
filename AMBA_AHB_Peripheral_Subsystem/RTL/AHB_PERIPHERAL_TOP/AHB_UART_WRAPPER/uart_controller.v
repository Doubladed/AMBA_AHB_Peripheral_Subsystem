module uart_controller(

        input CLK,
        input RST_n,

        input tx_start,
        input [31:0] TXDATA,
        input [2:0] tx_byte_size,

        input Rx,
        input rx_valid_clr,
        input [2:0] rx_byte_size,

        output Tx,
        output tx_busy,

        output [31:0] RXDATA,
        output rx_valid
);

wire Txclk_en;
wire Rxclk_en;

baudrate_gen u_baudrate_gen(
        .CLK(CLK),
        .RST_n(RST_n),
        .Txclk_en(Txclk_en),
        .Rxclk_en(Rxclk_en)
);

tx_module u_tx_module(
        .CLK(CLK),
        .RST_n(RST_n),
        .Txclk_en(Txclk_en),
        .tx_start(tx_start),
        .TXDATA(TXDATA),
        .tx_byte_size(tx_byte_size),
        .Tx(Tx),
        .tx_busy(tx_busy)
);

rx_module u_rx_module(
        .CLK(CLK),
        .RST_n(RST_n),
        .Rxclk_en(Rxclk_en),
        .Rx(Rx),
        .rx_valid_clr(rx_valid_clr),
        .rx_byte_size(rx_byte_size),
        .RXDATA(RXDATA),
        .rx_valid(rx_valid)
);

endmodule
