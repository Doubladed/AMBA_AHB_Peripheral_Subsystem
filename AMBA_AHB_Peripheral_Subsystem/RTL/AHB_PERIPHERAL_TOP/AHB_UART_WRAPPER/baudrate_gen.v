module baudrate_gen(

        input CLK,
        input RST_n,

        output reg Txclk_en,
        output reg Rxclk_en
);

// CLK = 100MHz, Baud Rate = 115200

parameter Tx_Div = 868;
parameter Rx_Div = 54;

reg [9:0] tx_counter;
reg [5:0] rx_counter;

always @(posedge CLK or negedge RST_n) begin

        if(!RST_n) begin

                tx_counter <= 0;
                Txclk_en <= 0;
        end
        else begin

                if(tx_counter == Tx_Div - 1) begin

                        tx_counter <= 0;
                        Txclk_en <= 1;
                end
                else begin

                        tx_counter <= tx_counter + 1;
                        Txclk_en <= 0;
                end
        end
end

always @(posedge CLK or negedge RST_n) begin

        if(!RST_n) begin

                rx_counter <= 0;
                Rxclk_en <= 0;
        end
        else begin

                if(rx_counter == Rx_Div - 1) begin

                        rx_counter <= 0;
                        Rxclk_en <= 1;
                end
                else begin

                        rx_counter <= rx_counter + 1;
                        Rxclk_en <= 0;
                end
        end
end

endmodule
