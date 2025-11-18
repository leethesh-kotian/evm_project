import uvm_pkg::*;
// import evm_pkg::*;
`include "uvm_macros.svh"
`include "evm_define.svh"
//`include "design.v"
`include "evm_package.sv"
module evm_top;

  logic clk;
  logic rst_n;

  evm_interface evm_if ( .clk(clk) , .rst_n(rst_n));

  evm dut (
    .clk	(evm_if.clk),
    .rst	(evm_if.rst_n),
    .vote_candidate_1	(evm_if.vote_candidate_1),
    .vote_candidate_2	(evm_if.vote_candidate_2),
    .vote_candidate_3   (evm_if.vote_candidate_3),
    .switch_on_evm	(evm_if.switch_on_evm),
    .candidate_ready     (evm_if.candidate_ready),
    .voting_session_done (evm_if.voting_session_done),
    .display_results     (evm_if.display_results),
    .display_winner      (evm_if.display_winner),
    .candidate_name      (evm_if.candidate_name),
    .invalid_results     (evm_if.invalid_results),
    .results             (evm_if.results),
    .voting_in_progress  (evm_if.voting_in_progress),
    .voting_done         (evm_if.voting_done)
  );
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst_n = 0;
    #10;
    rst_n = 1;
  end
  initial begin 
    uvm_config_db #(virtual evm_interface)::set(null, "*", "evm_if", evm_if);
  end

  initial begin
    run_test("evm_test");
  end


endmodule




