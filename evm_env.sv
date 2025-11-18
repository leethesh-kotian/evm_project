class evm_env extends uvm_env;
  `uvm_component_utils(evm_env)

  evm_active_agent evm_a_agent;
  evm_passive_agent evm_p_agent;
//  evm_scb scb;
//  evm_cov cov;

  function new(string name = "evm_env", uvm_component parent = null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    evm_a_agent = evm_active_agent::type_id::create("evm_a_agent", this);
    evm_p_agent = evm_passive_agent::type_id::create("evm_p_agent", this);
  //  scb = evm_scb::type_id::create("scb", this);
//    cov = evm_cov::type_id::create("cov",this);
  endfunction
  
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
//    evm_a_agent.ip_mon_h.ip_mon_port.connect(scb.aport_ip);
//    evm_p_agent.op_mon_h.op_mon_port.connect(scb.aport_ip);
  //  evm_a_agent.ip_mon_h.ip_mon_port.connect(cov.ip_mon_imp);
   // evm_p_agent.op_mon_h.op_mon_port.connect(cov.op_mon_imp);
  endfunction

endclass
    


