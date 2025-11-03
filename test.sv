`include "environment.sv"
module test(fifo_intf inf);
  environment env;
  initial begin
    env = new(inf);
    env.gen.repeat_count = 30;
    env.run();
  end
endmodule
