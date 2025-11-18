class evm_seq_item extends uvm_sequence_item;

  rand bit vote_candidate_1;
  rand bit vote_candidate_2;
  rand bit vote_candidate_3;
  rand bit switch_on_evm;
  rand bit candidate_ready;
  rand bit voting_session_done;
  rand bit [1:0] display_results;
  rand bit display_winner;

  bit [1:0] candidate_name;
  bit invalid_results;
  bit [6:0] results;
  bit voting_in_progress;
  bit voting_done;

  rand int unsigned wait_cycles;

  `uvm_object_utils_begin(evm_seq_item)
    `uvm_field_int(vote_candidate_1,      UVM_ALL_ON)
    `uvm_field_int(vote_candidate_2,      UVM_ALL_ON)
    `uvm_field_int(vote_candidate_3,      UVM_ALL_ON)
    `uvm_field_int(switch_on_evm,         UVM_ALL_ON)
    `uvm_field_int(candidate_ready,       UVM_ALL_ON)
    `uvm_field_int(voting_session_done,   UVM_ALL_ON)
    `uvm_field_int(display_results,       UVM_ALL_ON)
    `uvm_field_int(display_winner,        UVM_ALL_ON)
    `uvm_field_int(wait_cycles,           UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "evm_seq_item");
    super.new(name);
    wait_cycles = 0;
  endfunction

endclass

