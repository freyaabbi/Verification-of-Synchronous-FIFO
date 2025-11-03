class scoreboard;
  mailbox mon2scb;
  mailbox gen2scb;
  int pkt_count;
  event done;
  virtual fifo_intf vif;

  bit [31:0] ref_mem[$]; // dynamic queue

  function new(mailbox mon2scb, mailbox gen2scb);
    this.mon2scb = mon2scb;
    this.gen2scb = gen2scb;
  endfunction

  task main();
    transaction actual, expected;

    forever begin
      mon2scb.get(actual);
      gen2scb.get(expected);
      $display("Expected FIFO contents:--------------------");
      foreach (ref_mem[val]) begin
          $display("%08h ->", ref_mem[val]);
      end
      $display("-------------------------------------------");
      
      if (expected.FIFO_WR_EN && !actual.FIFO_FULL) begin
        ref_mem.push_back(expected.FIFO_DATA_IN);
      end

      if (expected.FIFO_RD_EN) begin
        if (ref_mem.size() > 0) begin
          expected.FIFO_DATA_OUT = ref_mem.pop_front();
        end else begin
          expected.FIFO_DATA_OUT = '0;
        end
      end
      else expected.FIFO_DATA_OUT = '0;

      if (expected.FIFO_RD_EN) begin
        if (actual.FIFO_DATA_OUT === expected.FIFO_DATA_OUT) begin
          $display("SCO: PASS expected=%08h actual=%08h", expected.FIFO_DATA_OUT, actual.FIFO_DATA_OUT);
        end else begin
          $error("SCO: FAIL expected=%08h actual=%08h", expected.FIFO_DATA_OUT, actual.FIFO_DATA_OUT);
        end
      end
      else begin
        if (actual.FIFO_DATA_OUT == '0) begin
          $display("SCO: PASS expected=00000000 actual=%08h", actual.FIFO_DATA_OUT);
        end else begin
          $error("SCO: FAIL expected=00000000 actual=%08h", actual.FIFO_DATA_OUT);
        end
      end

      pkt_count++;
      if (pkt_count == 30) $finish;
      ->done;
    end
  endtask
endclass
