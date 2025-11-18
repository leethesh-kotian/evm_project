class evm_active_agent extends uvm_agent;

  `uvm_component_utils(evm_active_agent)

  evm_driver evm_drv;
  evm_sequencer evm_sqr;
  evm_input_monitor ip_mon_h;

  function new(string name = "evm_active_agent" ,uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      evm_drv = evm_driver::type_id::create("evm_drv",this);
      evm_sqr = evm_sequencer::type_id::create("evm_sqr", this);
    end
    ip_mon_h = evm_input_monitor::type_id::create("ip_mon_h", this);
  endfunction


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active == UVM_ACTIVE) begin
      evm_drv.seq_item_port.connect(evm_sqr.seq_item_export);
    end
  endfunction

endclass





  


