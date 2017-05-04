class fifo_tb extends uvm_env;

  fifo_scoreboard     fifo_scbd_h;

  fifo_vsequencer     fifo_vseqr_h;

  fifo_uvc            fifo_uvc_h;

  `uvm_component_utils(fifo_tb)

  function new(string name="fifo_tb", uvm_component parent); 
    super.new(name, parent);
  endfunction 

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass 

function void fifo_tb::build_phase(uvm_phase phase);
  super.build_phase(phase);
  fifo_uvc_h    = fifo_uvc::type_id::create("fifo_uvc_h", this);
  fifo_vseqr_h  = fifo_vsequencer::type_id::create("fifo_vseqr_h", this); 
  fifo_scbd_h   = fifo_scoreboard::type_id::create("fifo_scbd_h", this);
endfunction 

function void fifo_tb::connect_phase(uvm_phase phase);
  fifo_vseqr_h.fifo_seqr   = fifo_uvc_h.drvr_agnt_h.seqr_h ;
  // Connect Scoreboard and Both Monitors here
  fifo_uvc_h.drvr_agnt_h.mon_h.drvr_ap.connect(fifo_scbd_h.tx_fifo);
  fifo_uvc_h.dut_agnt_h.dut_mon_h.dut_ap.connect(fifo_scbd_h.rx_fifo);
endfunction 
