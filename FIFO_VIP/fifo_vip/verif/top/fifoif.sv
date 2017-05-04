//
// A simple interface for testing the fifo
//

`include "../fifo_vip/verif/top/defines.sv"
interface fifoif #(busw=32,entries=31)();
    reg clk,rst;
    reg push;
    reg full;
    reg [busw-1:0] datain;
    reg pull;
    reg empty;
    reg [busw-1:0] dataout;

    // bit assertion_check; 

    modport fif(input clk, input rst,input push, output full,
                input datain,input pull, output empty, output dataout);
  
    bit assertion_check = 1; 

    // property write_when_fifo_not_full;
    //   @(negedge push) disable iff(!assertion_check || rst) (push && full);
    // endproperty 
  
    // property read_when_fifo_not_empty;
    //   @(negedge pull) disable iff(!assertion_check || rst) (pull && empty);
    // endproperty 

    // Write_when_Not_full: assert property(write_when_fifo_not_full)
    //   $error(" Writing into FIFO when full", $time);
  
    // Read_when_Not_empty: assert property(read_when_fifo_not_empty)
    //   $error(" Reading from FIFO when empty", $time);

    // int    full_cnt; 
    // int    empty_cnt; 

    // always@(posedge clk) begin 
    //   if(rst) 
    //     full_cnt <= 'h0 ;
    //   else if(push & !full)
    //     full_cnt <= full_cnt+1 ;
    //   else 
    //     full_cnt <= full_cnt ;
    // end 


  
endinterface : fifoif
