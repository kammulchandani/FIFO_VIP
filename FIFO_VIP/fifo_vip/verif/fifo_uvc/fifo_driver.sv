
class fifo_driver extends uvm_driver #(fifo_seq_item);
   
  virtual fifoif #(`WIDTH, `DEPTH)  fifo_if;

  function new(string name="fifo_driver", uvm_component parent);
    super.new(name, parent);
  endfunction 

  `uvm_component_utils(fifo_driver)

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	`uvm_info("DRIVER", "In build phase", UVM_LOW)
	if(!uvm_config_db #(virtual fifoif #(`WIDTH, `DEPTH))::get(this, "", "fifo_if", fifo_if)) begin 
	  `uvm_error("INTERFACE", "Fifo Interface Not set?")
	end 
  endfunction 

  task run_phase(uvm_phase phase);
    forever begin
	  seq_item_port.get_next_item(req);
	  send_to_dut(req);
	  seq_item_port.item_done();
	end
  endtask 

  // Complete this 
  task send_to_dut(fifo_seq_item fifo_h);   
    reset_dut();
	wait(!fifo_if.rst);
	if(!fifo_if.rst) begin
	  @(posedge fifo_if.clk);
	  if(req.push  == 1'b1) begin
        fifo_if.datain <= req.datain; 
		fifo_if.push  <= req.push; 
	  end 
	  if(req.pull  == 1'b1) begin
		fifo_if.pull  <= req.pull; // 1'b1;
	    // @(posedge fifo_if.clk);
	  end 
	    @(posedge fifo_if.clk);
		fifo_if.push  <= 1'b0;
		fifo_if.pull  <= 1'b0;
	end 
  endtask 

  // Complete this 
  task reset_dut();
    if(fifo_if.rst) begin
	  fifo_if.push  <= 1'h0;
	  fifo_if.pull  <= 1'h0;
	  fifo_if.datain<= 8'h00;
	end 
  endtask 
  
endclass 
