`include "interface.sv"
`include "test.sv"

module tb;
  fifo_intf inf();

  fifo_buffer dut (inf);

  test t1(inf);

  always #5 inf.clk = ~inf.clk;

  initial begin

    inf.clk = 0;
    inf.reset = 1;
    #3 inf.reset = 0;
  end

 endmodule
