class driver;
  transaction pkt;
  virtual fifo_intf vif;
  mailbox gen2drv;

  function new(mailbox gen2drv, virtual fifo_intf vif);
    this.gen2drv = gen2drv;
    this.vif = vif;
  endfunction

  task main();
    @(negedge vif.reset);
    forever begin
      gen2drv.get(pkt);
      vif.FIFO_WR_EN <= pkt.FIFO_WR_EN;
      vif.FIFO_RD_EN <= pkt.FIFO_RD_EN;
      vif.FIFO_DATA_IN <= pkt.FIFO_DATA_IN;
      pkt.print("DRV");
    end
  endtask
endclass
