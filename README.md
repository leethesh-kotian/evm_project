# **Electronic Voting Machine (EVM) – UVM Verification Project**

A complete verification environment for an Electronic Voting Machine (EVM) designed in Verilog and verified using the **UVM methodology**. This project contains:

* RTL design of EVM
* UVM testbench with sequences, driver, monitors, scoreboard
* Complete FSM behavior explanation
* Verification plan & coverage goals
* Block diagrams & signal flow diagrams

---

# 🗳️ **1. Project Overview**

The Electronic Voting Machine (EVM) simulates real-world voting logic using a finite state machine. It accepts inputs from voters, counts votes for 3 candidates, detects invalid/tie scenarios, and displays winner or individual candidate results.


# 🔧 **2. Testbench Architecture**

![evm (1)](https://github.com/user-attachments/assets/24714f5f-bec0-48e9-80f2-0f342edbaebe)

# 📡 **3. EVM Inputs & Outputs**

### **Inputs**

* switch_on_evm
* candidate_ready
* vote_candidate_1/2/3
* voting_session_done
* display_results[1:0]
* display_winner

### **Outputs**

* candidate_name
* results
* invalid_results
* voting_done
* voting_in_progress


# 🔄 **4. FSM Description**

### States:

1. **IDLE** – Waiting for power ON.
2. **WAITING_FOR_CANDIDATE** – Waiting for candidate_ready.
3. **WAITING_FOR_CANDIDATE_TO_VOTE** – Candidate must vote within 100 cycles.
4. **CANDIDATE_VOTED** – Vote counted.
5. **VOTING_PROCESS_DONE** – Winner/result display.


# 🧪 **5. UVM Testbench Components**

###  **Driver**

* Drives DUT inputs from sequence items.
* Uses clocking block → ensures synchronous updates.

###  **Input Monitor**

* Samples all DUT input pins every clock.
* Sends transactions to scoreboard.

###  **Output Monitor**

* Reads DUT outputs every clock.
* Sends transactions to scoreboard.

###  **Scoreboard**

* Compares expected vote counts with DUT output.
* Checks:

  * Winner logic
  * Tie detection
  * Voting_done timing
  * State-dependent outputs

###  **Sequences**

* `evm_sequence` – basic randomized sequence.
* `evm_main_sequence` – full voting scenario:

  1. Switch ON
  2. Vote 5 times
  3. End session
  4. Display winner


# 📝 **6. Verification Plan Summary**

### ⭐ **Functional Coverage Goals**

* Cover all 5 FSM states
* Cover transitions
* Cover all vote combinations
* Cover tie cases
* Cover all display modes
* Cover timeouts (100 cycles)
* Cover priority rules (1 > 2 > 3)

### ⭐ **Scoreboard Checks**

* Match vote counts with expected model
* Validate voting_done
* Validate invalid_results logic
* Validate display output

