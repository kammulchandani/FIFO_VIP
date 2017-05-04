class fifo_dut_agent extends uvm_agent;
 
  `uvm_component_utils_begin(fifo_dut_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_component_utils_end 

  fifo_dut_monitor         dut_mon_h;

  uvm_active_passive_enum  is_active; 

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	is_active     = UVM_PASSIVE;
	dut_mon_h     = fifo_dut_monitor::type_id::create("fifo_dut_mon", this);
  endfunction 

endclass 

