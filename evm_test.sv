class evm_test extends uvm_test;

  `uvm_component_utils(evm_test)

  evm_env env;

  function new(string name = "evm_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  funtion void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = evm_env::type_id::create("env", this);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  function void report_phase(uvm_phase phase);
    uvm_report_server svr;
    super.report_phase(phase);
    svr=uvm_report_server::get_server();
    if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
                        `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
                        `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
                        `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
                end
                else begin
                        `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
                        `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
                        `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
                end
    `uvm_info("APB_TEST","Inside apb_test REPORT_PHASE",UVM_HIGH)
  endfunction
endclass


class evm_main_test extends evm_test;

  `uvm_component_utils(evm_main_test)
  evm_env env;
  evm_main_sequence evm_main_seq;

  function new(string name = "evm_main_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  evm_main_seq = evm_main_sequence ::type_id::create("evm_main_seq");
  env = evm_env::type_id::create("env", this);
  `uvm_info("EVM_MAIN_TEST","Inside build_phase", UVM_LOW);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    phase.raise_objection(this);
    `uvm_info("EVM_MAIN_TEST",
              "\n---------------------- EVM MAIN SEQUENCE START ----------------------\n",
              UVM_LOW)

    evm_main_seq.start(env.evm_a_agent.evm_sqr);

    `uvm_info("EVM_MAIN_TEST",
              "\n---------------------- EVM MAIN SEQUENCE END ------------------------\n",
              UVM_LOW)
    phase.drop_objection(this);
  endtask

endclass








