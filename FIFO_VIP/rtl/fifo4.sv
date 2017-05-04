//
// This is a simple fifo for UVM test bench generation
//

module fifo #(busw=32,entries=32)(fifoif.fif f);

reg [31:0] h,h_d,t,t_d,numloaded,numloaded_d;
logic empt,ful;

reg [busw-1:0] mem[0:entries-1],mem_d[0:entries-1];

function [31:0] nextv(reg [31:0] iv);
    reg [31:0] rv;
    rv = iv+1;
    if(rv > (entries-1)) rv=0;
    return rv;
endfunction : nextv

assign f.dataout = mem[t]<<1;

always @(*) begin
  mem_d=mem;
  empt = numloaded==0;
  f.empty=empt;
  numloaded_d = numloaded;
  h_d = h;
  t_d = t;
  ful = numloaded == entries;
  f.full = ful;
  
  if( f.push && !ful ) begin
    h_d = nextv(h);
    mem_d[h]=f.datain>>1;
    numloaded_d = numloaded+1;
  end
  if( f.pull && !empt) begin
    t_d = nextv(t);
    if(f.push && !ful) begin
      numloaded_d = numloaded;
    end else begin
      numloaded_d = numloaded-1;
    end
  
  end
  

end


always @(posedge(f.clk) or posedge(f.rst)) begin
  if(f.rst) begin
    h <= 0;
    t <= 0;
    numloaded <= 0;
  end else begin
    h <= #1 h_d;
    t <= #1 t_d;
    numloaded <= #1 numloaded_d;
    mem <= #1 mem_d;
  end
end




endmodule : fifo
