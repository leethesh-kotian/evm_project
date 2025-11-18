class evm_driver extends uvm_driver;
  `uvm_component_utils(evm_driver)


  function new(string name = "evm_driver",uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual evm_interface evm_if;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db #(virtual evm_interface)::get(this, "*", "evm_if", evm_if)))
     `uvm_fatal("evm_driver","unable to get intf");
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   forever begin
    req =evm_seq_item::type_id::create("req");
     seq_item_port.get_next_item(req);
     drive();
     seq_item_port.item_done();
   end
  endtask

  virtual task drive();
   repeat(2)@(evm_if.drv_cb);
     @(evm_if.drv_cb) begin
   evm_if.switch_on_evm <= req.switch_on_evm;
   evm_if.candidate_ready <= req.candidate_ready;
   evm_if.vote_candidate_1 <= req.vote_candidate_1;
   evm_if.vote_candidate_2 <= req.vote_candidate_2;
   evm_if.vote_candidate_3 <= req.vote_candidate_3;
   evm_if.voting_session_done <= req.voting_session_done;
   evm_if.display_results <= req.display_results;
   evm_if.display_winner <= req.display_winner;
   $display("driving",$time);
   req.print();
  endtask
endclass

 










