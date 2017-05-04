class fifo_vsequencer extends uvm_sequencer; 
  
  `uvm_component_utils(fifo_vsequencer)

  function new(string name="fifo_vsequencer", uvm_component parent);
    super.new(name, parent);
  endfunction 
  
  fifo_sequencer  fifo_seqr;
   
endclass 
