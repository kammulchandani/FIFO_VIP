class fifo_seq_item extends uvm_sequence_item;
 
  rand logic        push ;
  rand logic        pull ;
  // rand logic        write;
  // rand logic        read ;
  rand logic [`WIDTH:0] datain;
       logic            full ;
       logic            empty;
       logic [`WIDTH:0] dataout;


  `uvm_object_utils_begin(fifo_seq_item)
    `uvm_field_int(pull  ,  UVM_ALL_ON)
	`uvm_field_int(push  ,  UVM_ALL_ON)
	`uvm_field_int(datain,  UVM_ALL_ON)
  `uvm_object_utils_end


  function new(string name="fifo_seq_item");
    super.new(name);
  endfunction 

  constraint data_c { 
	                  datain inside {[0:2**31]};
                     }

endclass 
