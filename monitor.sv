class monitor;
  transaction pkt;
  virtual fifo_intf vif;
  mailbox mon2scb;

  function new(mailbox mon2scb, virtual fifo_intf vif);
    this.mon2scb = mon2scb;
    this.vif = vif;
  endfunction

  task main();
    @(negedge vif.reset);
    forever begin
      @(posedge vif.clk);
      pkt = new();
      pkt.FIFO_WR_EN = vif.FIFO_WR_EN;
      pkt.FIFO_RD_EN = vif.FIFO_RD_EN;
      pkt.FIFO_DATA_IN = vif.FIFO_DATA_IN;
      pkt.FIFO_DATA_OUT = vif.FIFO_DATA_OUT;
      pkt.FIFO_FULL    = vif.FIFO_FULL;
      pkt.FIFO_EMPTY   = vif.FIFO_EMPTY;
      pkt.print("MON");
      mon2scb.put(pkt);
    end
  endtask
endclass
