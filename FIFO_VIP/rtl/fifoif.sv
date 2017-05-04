//
// A simple interface for testing the fifo
//

interface fifoif #(busw=32,entries=31)();
    reg clk,rst;
    reg push;
    reg full;
    reg [busw-1:0] datain;
    reg pull;
    reg empty;
    reg [busw-1:0] dataout;


    modport fif(input clk, input rst,input push, output full,
                input datain,input pull, output empty, output dataout);
  
     bit assertion_check = 1; 

     property write_when_fifo_not_full;
       @(posedge clk ) disable iff(!assertion_check || rst) (push && full_flag) |-> (full == 1);
     endproperty 
  
     property read_when_fifo_not_empty;
       @(posedge clk ) disable iff(!assertion_check || rst) (pull && empty_flag)  |-> (empty ==1);
     endproperty 

     property signal_not_equals_signal_flag(signal, signal_flag);
       @(posedge signal or signal_flag) disable iff(!assertion_check || rst)  signal == signal_flag; 
     endproperty

     Write_when_Not_full: assert property(write_when_fifo_not_full)
     else 
       $error(" Fifo Full Not asserted ", $time);
  
     Read_when_Not_empty: assert property(read_when_fifo_not_empty)
     else 
       $error(" Fifo Empty Not asserted", $time);

     full_not_equals_full_flag: assert property(signal_not_equals_signal_flag(full,full_flag))
     else 
       $error(" Fifo Full(RTL) Not Equal Full Flag", $time);

     empty_not_equals_empty_flag: assert property(signal_not_equals_signal_flag(empty,empty_flag))
     else 
       $error(" Fifo empty(RTL) Not Equal empty Flag", $time);


     int    cnt; 
     int    empty_cnt; 
     logic  full_flag; 
     logic  empty_flag; 

     always@(posedge clk) begin 
       if(rst )  begin 
         cnt <= #1 'h0 ;
       end 
       else if(push && !full && pull && !empty) begin 
         cnt <= #1 cnt ;
       end 
       else if(push && !full) begin
         cnt <= #1 cnt+1 ;
       end 
       else if(pull && !empty) begin
         cnt <= #1 cnt-1 ;
       end 
       else  begin 
         cnt <= #1 cnt ;
       end 
     end 
  
    assign full_flag   = (cnt == `DEPTH ) ? 1'b1 : 1'b0;
    assign empty_flag  = (cnt ==0) ? 1'b1 : 1'b0;

endinterface
