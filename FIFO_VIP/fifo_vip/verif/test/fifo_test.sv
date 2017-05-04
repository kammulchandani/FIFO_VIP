class fifo_base_test extends uvm_test;
  
  fifo_tb           tb_h;
  fifo_vsequencer   fifo_vseqr; 

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 

  `uvm_component_utils(fifo_base_test);

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	tb_h      = fifo_tb::type_id::create("tb_h", this);
  endfunction 

  function void end_of_elaboration_phase(uvm_phase phase);
    fifo_vseqr  = tb_h.fifo_vseqr_h;
	uvm_top.print_topology();
  endfunction 
 
endclass 

class fifo_random_test  extends fifo_base_test;
  
  fifo_vseq   vseq_h;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 

  `uvm_component_utils(fifo_random_test)

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction 

  task run_phase(uvm_phase phase);
    begin
	  phase.raise_objection(this);
	  vseq_h  = fifo_vseq::type_id::create("vseq_h");
	  assert(vseq_h.randomize());
	  vseq_h.start(fifo_vseqr, null);
      #20000;
	  phase.drop_objection(this);
	end 
  endtask 

  
endclass 
