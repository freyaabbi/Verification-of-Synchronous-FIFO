interface fifo_intf;
  logic clk;
  logic reset;
  logic FIFO_WR_EN;
  logic FIFO_RD_EN;
  logic [31:0] FIFO_DATA_IN;
  logic [31:0] FIFO_DATA_OUT;
  logic FIFO_FULL;
  logic FIFO_EMPTY;
  logic [3:0] WR_PTR;
  logic [3:0] RD_PTR;
endinterface
