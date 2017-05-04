class fifo_base_seq   extends  uvm_sequence  #(fifo_seq_item);
  
  `uvm_declare_p_sequencer(fifo_sequencer)

  fifo_tb   tb_cfg;

  `uvm_object_utils(fifo_base_seq) 

  function new(string name="fifo_base_seq");
    super.new(name);
  endfunction 

  virtual task pre_body();
    starting_phase.raise_objection(this);
  endtask 

  virtual task post_body();
    starting_phase.drop_objection(this);
  endtask 

endclass 

class fifo_wr extends fifo_base_seq;
  
  `uvm_object_utils(fifo_wr)

  fifo_seq_item   seq_h;

  function new(string name="fifo_wr");
    super.new(name);
  endfunction 

  virtual task body();
    `uvm_do_with(req, { push  == 1'b1; 
			            datain inside {[0:2**31]}; 
						pull == 1'b0;
					   })
  endtask 

endclass 

class fifo_rd extends fifo_base_seq;

  `uvm_object_utils(fifo_rd)

  fifo_seq_item   seq_h;

  function new(string name="fifo_rd");
    super.new(name);
  endfunction 
  
  virtual task body();
    `uvm_do_with(req, { push  == 1'b0; 
						pull  == 1'b1;
					   })
  endtask 
  
endclass 

class fifo_wr_rd extends fifo_base_seq;
  
  `uvm_object_utils(fifo_wr_rd)

  fifo_seq_item   seq_h;

  function new(string name="fifo_wr_rd");
    super.new(name);
  endfunction 

  virtual task body();
    `uvm_do_with(req, { push  inside {[0:1]}; 
			            datain inside {[0:2**31]}; 
						pull inside {[0:1]}; 
					   })
  endtask 

endclass
