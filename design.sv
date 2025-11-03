module fifo_buffer (fifo_intf inf);

    // Memory Array (16-depth, 32-bit width)
    reg [31:0] memory [0:15];   

    // FIFO Status Signals
  assign inf.FIFO_FULL = (inf.WR_PTR == inf.RD_PTR - 1) || (inf.WR_PTR == 4'b1111 && inf.RD_PTR == 4'b0000);
  assign inf.FIFO_EMPTY = (inf.WR_PTR == inf.RD_PTR);

    // Write Operation
  always @(posedge inf.clk or posedge inf.reset) begin
      if (inf.reset) begin
            inf.WR_PTR <= 4'b0000;
            inf.FIFO_DATA_OUT <='0;
      end else if (inf.FIFO_WR_EN && !inf.FIFO_FULL) begin
        memory[inf.WR_PTR] <= inf.FIFO_DATA_IN;
            inf.WR_PTR <= inf.WR_PTR + 1;
            inf.FIFO_DATA_OUT <='0;
      end
        else if (inf.FIFO_WR_EN && inf.FIFO_FULL) begin
            inf.FIFO_DATA_OUT <='0;
        end
    end

    // Read Operation
  always @(posedge inf.clk or posedge inf.reset) begin
      if (inf.reset) begin
            inf.RD_PTR <= 4'b0000;
            inf.FIFO_DATA_OUT ='0;
      end else if (inf.FIFO_RD_EN && !inf.FIFO_EMPTY) begin
            inf.FIFO_DATA_OUT = memory[inf.RD_PTR];
            inf.RD_PTR <= inf.RD_PTR + 1;
        end
    else if (inf.FIFO_EMPTY) begin
            inf.FIFO_DATA_OUT = '0;
        end
    else if (!inf.FIFO_RD_EN) begin
            inf.FIFO_DATA_OUT = '0;
        end
    end

endmodule
