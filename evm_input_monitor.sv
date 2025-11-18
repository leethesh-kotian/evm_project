class evm_input_monitor extends uvm_monitor;
  `uvm_component_utils(evm_input_monitor)

  virtual evm_interface evm_if;

  evm_seq_item ip_mon_seq;

  uvm_analysis_port #(evm_seq_item) ip_mon_port;
 
  function new (string name = "evm_input_monitor", uvm_component parent);    super.new(name,parent);
    ip_mon_port = new("ip_mon_port", this);
  endfunction

  virtual function void  build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db #(virtual evm_interface)::get(this,"","evm_if",evm_if)))
       `uvm_fatal("input monitor ","failed to find intf");
  endfunction


  virtual task run_phase(uvm_phase phase);
    ip_mon_seq = evm_seq_item::type_id::create("ip_mon_seq");

   forever begin
     @(posedge evm_if.mon_cb);
      ip_mon_seq.switch_on_evm = evm_if.switch_on_evm;
      ip_mon_seq.candidate_ready = evm_if.candidate_ready;
      ip_mon_seq.vote_candidate_1 = evm_if.vote_candidate_1;
      ip_mon_seq.vote_candidate_2 = evm_if.vote_candidate_2;
      ip_mon_seq.vote_candidate_3 = evm_if.vote_candidate_3;
      ip_mon_seq.voting_session_done = evm_if.voting_session_done;
      ip_mon_seq.display_results = evm_if.display_results;
      ip_mon_seq.display_winner = evm_if.display_winner;
      $display("driving",$time);
      ip_mon_seq.print();
      ip_mon_port.write(ip_mon_seq);
    end
   endtask
endclass


















   








