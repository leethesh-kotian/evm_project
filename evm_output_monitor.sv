class evm_output_monitor extends uvm_monitor;

  `uvm_component_utils(evm_output_monitor)

  virtual evm_interface evm_if;
  evm_seq_item op_mon_seq;
  uvm_analysis_port#(evm_seq_item) op_mon_port;
 
  function new(string name = "evm_output_monitor", uvm_component parent);
    super.new(name, parent);
    op_mon_port = new("op_mon_port",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db #(virtual evm_interface)::get(this,"","evm_if",evm_if)))
    `uvm_fatal("OUTPUT MONITOR","missed intf");
  endfunction

  task run_phase(uvm_phase phase);
 
 repeat(2) @(evm_if.mon_cb);
    op_mon_seq = evm_seq_item::type_id::create("op_mon_seq");
   forever begin 
    @(evm_if.mon_cb);
     
    op_mon_seq.candidate_name = evm_if.candidate_name;
    op_mon_seq.invalid_results = evm_if.invalid_results; 
    op_mon_seq.results = evm_if.results;
    op_mon_seq.voting_done = evm_if.voting_done;
    op_mon_seq.voting_in_progress = evm_if.voting_in_progress;
    $display("OUTPUT MONITOR @%0t",$time);
    op_mon_seq.print();
    op_mon_port.write(op_mon_seq);
   end
  endtask
endclass






