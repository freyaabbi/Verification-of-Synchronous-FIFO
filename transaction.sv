class transaction;
  rand bit FIFO_WR_EN;
  rand bit FIFO_RD_EN;
  rand bit [31:0] FIFO_DATA_IN;
  bit [31:0] FIFO_DATA_OUT;
  bit FIFO_FULL;
  bit FIFO_EMPTY;

  constraint c1 { (FIFO_WR_EN == 0 && FIFO_RD_EN == 1) ||(FIFO_WR_EN == 1 && FIFO_RD_EN == 0); }
  
  function void print(string name);
    $display("[%0s] WR_EN=%0b, RD_EN=%0b, DATA_IN=%0h, DATA_OUT=%0h",
             name, FIFO_WR_EN, FIFO_RD_EN, FIFO_DATA_IN, FIFO_DATA_OUT);
  endfunction

  function transaction copy();
    copy = new();
    copy.FIFO_WR_EN = this.FIFO_WR_EN;
    copy.FIFO_RD_EN = this.FIFO_RD_EN;
    copy.FIFO_DATA_IN = this.FIFO_DATA_IN;
    copy.FIFO_DATA_OUT = this.FIFO_DATA_OUT;
    copy.FIFO_FULL   = this.FIFO_FULL;
    copy.FIFO_EMPTY  = this.FIFO_EMPTY;
    return copy;
  endfunction
endclass
