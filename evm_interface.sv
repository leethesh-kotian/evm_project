//`include "define.sv"
interface evm_interface #(parameter WIDTH = 7)(input logic clk, rst);

  logic vote_candidate_1;
  logic vote_candidate_2;
  logic vote_candidate_3;
  logic switch_on_evm;
  logic candidate_ready;
  logic voting_session_done;
  logic [1:0] display_results;
  logic display_winner;

  logic [1:0] candidate_name;
  logic invalid_results;
  logic [6:0] results;
  logic voting_in_progress;
  logic voting_done;

  clocking driver_cb @(posedge clk);
    default input #0 output #0;
    output vote_candidate_1, vote_candidate_2, vote_candidate_3;
    output switch_on_evm, candidate_ready, voting_session_done;
    output display_results, display_winner;
    input candidate_name, invalid_results, results;
    input voting_in_progress, voting_done;
  endclocking

  clocking mon_cb @(posedge clk);
    default input #0 output #0;
    input vote_candidate_1, vote_candidate_2, vote_candidate_3;
    input switch_on_evm, candidate_ready, voting_session_done;
    input display_results, display_winner;
    input candidate_name, invalid_results, results;
    input voting_in_progress, voting_done;
  endclocking

  modport DRV (clocking driver_cb, input clk);
  modport MON (clocking mon_cb, input clk);

  always_comb begin
    if (!rst) begin
      if (!$isunknown({candidate_name, results, invalid_results,
                       voting_in_progress, voting_done})) begin
        assert ((candidate_name == 0) &&
                (results == 0) &&
                !invalid_results &&
                !voting_in_progress &&
                !voting_done)
        else
          `uvm_info("RST_CHECK","Outputs not default during reset",UVM_NONE)
      end
    end
  end
endinterface

