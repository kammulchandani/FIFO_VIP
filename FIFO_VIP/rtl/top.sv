//
// A debug driver to check code syntax
//

`include "fifoif.sv"


module top();

fifoif #(32,15) q();

reg [31:0] exp[$];

initial begin
  q.clk=1;
  repeat(1000) begin
    #5 q.clk=~q.clk;
  end
end

initial begin
  q.rst=1;
  q.pull=0;
  q.push=0;
  repeat(3) @(posedge(q.clk)) #1;
  q.rst=0;
  repeat(2) @(posedge(q.clk)) #1;
  
  repeat(15) begin
    q.push=1;
    q.datain=$random;
    exp.push_back(q.datain);
    @(posedge(q.clk)) #1;
  end
  q.push=0;
  repeat(15) begin
    q.pull=1;
    @(posedge(q.clk));
    if( q.dataout != exp.pop_front()) begin
      $display("Data didn't match at %t",$realtime);
    end
    #1;
  end
  q.pull=0;

end

initial begin
  $dumpfile("fifo.vpd");
  $dumpvars();
end

fifo #(32,15) f(q.fif);






endmodule : top

//`include "fifo.sv"
