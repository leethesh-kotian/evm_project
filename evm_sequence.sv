class evm_sequence extends uvm_sequence #(evm_seq_item);

  `uvm_object_utils(evm_sequence)

  function new(string name = "evm_sequence");
    super.new(name);
  endfunction

  virtual task body();
    req = evm_seq_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
  endtask

endclass

class evm_main_sequence extends uvm_sequence #(evm_seq_item);
  `uvm_object_utils(evm_main_sequence)

  function new(string name = "evm_main_sequence");
    super.new(name);
  endfunction

  virtual task body();
    req = evm_seq_item::type_id::create("req");

    // EVM ON
    wait_for_grant();
    void'(req.randomize() with {switch_on_evm == 1; voting_session_done == 0;});
    send_request(req);
    wait_for_item_done();

    // Voting Phase
    repeat (100) begin
      wait_for_grant();
      void'(req.randomize() with { switch_on_evm == 1; candidate_ready == 1; voting_session_done == 0; });
      send_request(req);
      wait_for_item_done();

      wait_for_grant();
      void'(req.randomize() with { switch_on_evm == 1; voting_session_done == 0; candidate_ready dist {0 := 70, 1 := 30};
        {vote_candidate_1, vote_candidate_2, vote_candidate_3}
          dist {
            3'b100 := 15,
            3'b010 := 15,
            3'b001 := 15,
            3'b110 := 15,
            3'b011 := 15,
            3'b101 := 15,
            3'b111 := 10
          };
      });
      send_request(req);
      wait_for_item_done();
    end

    // Display Results
    wait_for_grant();
    void'(req.randomize() with { switch_on_evm == 1; candidate_ready == 0;  voting_session_done == 0; display_results inside {[0:2]}; });
    send_request(req);
    wait_for_item_done();

    // Display Winner
    wait_for_grant();
    void'(req.randomize() with {
      switch_on_evm == 1;
      candidate_ready == 0;
      voting_session_done == 1;
      display_winner == 1;
      display_results inside {[0:2]};
    });
    send_request(req);
    wait_for_item_done();

    // Display all result combinations
    int results_arr[4] = '{3,1,2,0};
    for (int i = 0; i < 4; i++) begin
      wait_for_grant();
      void'(req.randomize() with {
        switch_on_evm == 1;
        candidate_ready == 0;
        voting_session_done == 1;
        display_winner == 0;
        display_results == results_arr[i];
      });
      send_request(req);
      wait_for_item_done();
    end

    // EVM OFF
    repeat (2) begin
      wait_for_grant();
      void'(req.randomize() with {
        switch_on_evm == 0;
        candidate_ready == 0;
        voting_session_done == 0;
      });
      send_request(req);
      wait_for_item_done();
    end

  endtask
endclass





