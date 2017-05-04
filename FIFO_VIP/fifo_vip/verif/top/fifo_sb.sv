`uvm_analysis_imp_decl(_tx)
`uvm_analysis_imp_decl(_rx)

class fifo_scoreboard extends uvm_scoreboard;
 
  uvm_analysis_imp_tx #(fifo_seq_item, fifo_scoreboard)  tx_fifo; 
  uvm_analysis_imp_rx #(fifo_seq_item, fifo_scoreboard)  rx_fifo;

  fifo_seq_item         seq_item_h; 
  logic  [`WIDTH:0]     q[$];        
  logic  [`WIDTH-1:0]   drv_data; 
  logic  [`WIDTH-1:0]   exp_data; 
  logic  [`WIDTH-1:0]   rcvd_data; 

  int                   txn_in, 
                        txn_out, 
                        txn_failed,
                        txn_dropped,
                        txn_compared, 
                        txn_passed; 

  function  new(string name, uvm_component parent);
    super.new(name, parent);
	tx_fifo  = new("tx_fifo", this); 
	rx_fifo  = new("rx_fifo", this); 
  endfunction 

  `uvm_component_utils(fifo_scoreboard)

  virtual function void drv_stimulus(fifo_seq_item tx);
    if(tx.push  && !tx.full) begin   // Get full and empty pins on drv_monitor also 
      txn_in++; 
      drv_data = tx.datain; 
      q.push_back(drv_data); 
    end 
  endfunction 

  virtual function  void write_tx(fifo_seq_item tx);
    drv_stimulus(tx);
  endfunction 

  virtual function void rcvd_stimulus(fifo_seq_item rx);
    if(rx.pull && !rx.empty) begin   // Get full and empty pins on drv_monitor also 
      txn_out++; 
      rcvd_data = rx.dataout; 
      exp_data  = q.pop_front(); 
      if(exp_data !== rcvd_data) begin 
        `uvm_error("DATA Mismatch",$sformatf("expected %h received %h",exp_data,rcvd_data));
        txn_failed++; 
        txn_compared++;
      end 
      else begin
        `uvm_info("DATA Matched",$sformatf("expected %h received %h",exp_data,rcvd_data), UVM_LOW);
        txn_passed++;
        txn_compared++;
      end 
    end
  endfunction 

  virtual function  void write_rx(fifo_seq_item rx);
    rcvd_stimulus(rx);
  endfunction 

  function void report_phase(uvm_phase phase);
    `uvm_info("    $$$$$$     ", "############################################################### \n", UVM_LOW)
    `uvm_info("    TXN_IN     ", $sformatf("Num. of Transactions input to the DUT     %0d",txn_in), UVM_LOW)
    `uvm_info("    TXN_OUT    ", $sformatf("Num. of Transactions output from the DUT  %0d",txn_out), UVM_LOW)
    `uvm_info("    TXN_STATUS ", $sformatf("                   \n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Txn compared %0d \n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Txn Passed   %0d \n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Txn Failed    %0d \n  \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Txn Dropped   %0d \n",txn_compared, txn_passed, txn_failed, txn_dropped), UVM_LOW)
    `uvm_info("    $$$$$$     ", "############################################################### \n", UVM_LOW)
  endfunction

endclass 
