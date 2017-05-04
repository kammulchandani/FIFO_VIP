`timescale 1ns/1ns
`include "defines.sv"
`include "../../../rtl/fifoif.sv"
module fifo_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  // `include "defines.sv"                          // Define this file.. 
  `include "../fifo_uvc/fifo_env.svh"
  `include "../test/fifo_test.sv"

  reg clk, rst;

  int  delay;
 
  
  // interface instance
  fifoif #(`WIDTH, `DEPTH) fifo_if ();

  // Design instance
  fifo #(`WIDTH, `DEPTH) fifo_inst(fifo_if);

  initial begin
    // uvm_config_db #(virtual fifoif #(`WIDTH, `DEPTH))::set(null,"*","fifo_if",fifo_if);
    uvm_config_db #(virtual fifoif #(`WIDTH, `DEPTH))::set(null,"*","fifo_if",fifo_if);
    clk = 1;
    rst = 1;
    #50 rst = 0;
    delay   = 5;
    // #10000 $finish;
  end 

  always begin 
    #5  clk = !clk;
    // @(posedge clk) ;
    //   $display("CLK ON");
  end 

  // Assigning/Passing clk and rst to interface signals. 
  assign fifo_if.clk = clk;
  assign fifo_if.rst = rst;

  initial begin
    run_test("fifo_random_test");
  end 

  // Dumping output files. 
  initial begin
    $dumpfile("fifo.vcd");
    $dumpvars(0,fifo_top);
    `ifdef 9_7
      $display(" Displaying 9_7");
    `else
      $display(" Displaying Nothing");
    `endif
    $display("  Value of Depth: %d,  Width: %d   ",`DEPTH, `WIDTH);
  end 

  // bit assertion_check = 1; 

   //  property write_when_fifo_not_full;
   //    @(negedge fifo_if.push) disable iff(!assertion_check || rst) (fifo_if.push && full_flag) |-> (fifo_if.full == 1);
   //  endproperty 
  
   //  property read_when_fifo_not_empty;
   //    @(negedge fifo_if.pull) disable iff(!assertion_check || rst) (fifo_if.pull && empty_flag)  |-> (fifo_if.empty ==1);
   //  endproperty 

   //  Write_when_Not_full: assert property(write_when_fifo_not_full)
   //  else 
   //    $error(" Fifo Full Not asserted ", $time);
  
   //  Read_when_Not_empty: assert property(read_when_fifo_not_empty)
   //  else 
   //    $error(" Fifo Empty Not asserted", $time);

   //  int    cnt; 
   //  int    empty_cnt; 
   //  logic  full_flag; 
   //  logic  empty_flag; 

   //  always@(posedge clk) begin 
   //    if(rst || full_flag)  begin 
   //      cnt <= 'h0 ;
   //    end 
   //    else if(fifo_if.push && !fifo_if.full) begin
   //      cnt <= cnt+1 ;
   //    end 
   //    else if(fifo_if.pull && !fifo_if.empty) begin
   //      cnt <= cnt-1 ;
   //    end 
   //    else if(fifo_if.push && !fifo_if.full && fifo_if.pull && !fifo_if.empty) begin 
   //      cnt <= cnt ;
   //    end 
   //    else  begin 
   //      cnt <= cnt ;
   //    end 
   //  end 
  
   // assign full_flag   = (cnt == `DEPTH) ? 1'b1 : 1'b0;
   // assign empty_flag  = (cnt ==0) ? 1'b1 : 1'b0;

endmodule : fifo_top
