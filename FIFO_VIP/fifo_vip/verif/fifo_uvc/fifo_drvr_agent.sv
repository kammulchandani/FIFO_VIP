class fifo_agent extends uvm_agent;
 
  `uvm_component_utils_begin(fifo_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_component_utils_end 

  fifo_driver              drvr_h;
  fifo_drvr_monitor        mon_h;
  fifo_sequencer           seqr_h; 

  uvm_active_passive_enum  is_active; 

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	is_active = UVM_ACTIVE;
	mon_h     = fifo_drvr_monitor::type_id::create("mon_h", this);
	if (is_active == UVM_ACTIVE) begin 
	  drvr_h    = fifo_driver::type_id::create("drvr_h", this);
	  seqr_h    = fifo_sequencer::type_id::create("seqr_h", this);
	end 
  endfunction 

  function void connect_phase(uvm_phase phase);
	if (is_active == UVM_ACTIVE) 
	  drvr_h.seq_item_port.connect(seqr_h.seq_item_export);
  endfunction 

endclass 
