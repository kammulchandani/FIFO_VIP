class fifo_base_vseq extends uvm_sequence ;
 
 function new(string name="fifo_base_vseq");
   super.new(name);
 endfunction 

 `uvm_object_utils(fifo_base_vseq)

 `uvm_declare_p_sequencer(fifo_vsequencer)

 virtual task pre_body();
   if(starting_phase !=null)
       starting_phase.raise_objection(this, "Running Vseq");
 endtask 

 virtual task post_body();
   if(starting_phase !=null)
       starting_phase.drop_objection(this, "Dropping Vseq");
 endtask 

endclass 


class fifo_vseq extends fifo_base_vseq;

  `uvm_object_utils(fifo_vseq)

  function new(string name="fifo_vseq");
    super.new(name);
  endfunction
  
  fifo_rd           rd_h;
  fifo_wr           wr_h;
  fifo_wr_rd        wr_rd_h;

  virtual task body();
    repeat(300)
    `uvm_do_on(wr_h, p_sequencer.fifo_seqr);
    repeat(330) begin 
    `uvm_do_on(wr_h, p_sequencer.fifo_seqr);
    `uvm_do_on(rd_h, p_sequencer.fifo_seqr);
    end 
    repeat(400)
    `uvm_do_on(wr_h, p_sequencer.fifo_seqr);
    repeat(360)
    `uvm_do_on(rd_h, p_sequencer.fifo_seqr);
    repeat(350) begin 
    `uvm_do_on(wr_h, p_sequencer.fifo_seqr);
    `uvm_do_on(rd_h, p_sequencer.fifo_seqr);
    end 
    repeat(450)
    `uvm_do_on(wr_rd_h, p_sequencer.fifo_seqr);
  endtask 

endclass
