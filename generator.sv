`include "transaction.sv"

class generator;
  rand transaction pkt;
  transaction ref_pkt;
  mailbox gen2drv;
  mailbox gen2scb;
  int repeat_count;
  event done;

  function new(mailbox gen2drv, mailbox gen2scb);
    this.gen2drv = gen2drv;
    this.gen2scb = gen2scb;
    pkt = new();
  endfunction

  task main();
    repeat (repeat_count) begin
      if (!pkt.randomize()) $fatal("Packet generation failed");
      pkt.print("GEN");
      ref_pkt = pkt.copy();
      gen2drv.put(pkt);
      gen2scb.put(ref_pkt);
      @done;
    end
  endtask
endclass
