class fifo_uvc extends uvm_env;
  
  function new(string name="fifo_uvc", uvm_component parent);
    super.new(name, parent);
  endfunction 

  `uvm_component_utils(fifo_uvc)

  fifo_dut_agent    dut_agnt_h; 
  fifo_agent        drvr_agnt_h;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	dut_agnt_h    = fifo_dut_agent::type_id::create("dut_agnt_h", this);
	drvr_agnt_h   = fifo_agent::type_id::create("drvr_agnt_h", this);
  endfunction 

endclass 
