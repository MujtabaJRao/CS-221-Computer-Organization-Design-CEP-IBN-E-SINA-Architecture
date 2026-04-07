# Ibn-e-Sina Processor ⚡

### 16-bit 0-Address Stack-Based Architecture

The **Ibn-e-Sina Processor** is a custom-designed 16-bit Instruction Set Architecture (ISA) based on a **0-address (stack-based)** execution model, optimized for efficient expression evaluation and high code density.

---

## Key Features

* 🧱 **Stack-Based (0-Address) Architecture**
  Eliminates operand fields, reducing instruction size and improving code density.

* ⚡ **Hybrid Stack-Register Design**
  Dedicated hardware buffers:

  * **TOS (Top of Stack)**
  * **NOS (Next of Stack)**
    → Enables **single-cycle arithmetic and logical operations**

* 🧠 **Single-Cycle Datapath**
  Complete datapath design with integrated control logic.

* 🧭 **Flexible Addressing Modes**

  * Stack-Relative (`PEEK`)
  * PC-Relative branching

* 📏 **Fixed 16-bit Instruction Encoding**
  Compact and efficient instruction format.

---

## 🏗️ Architecture Overview

This processor bridges the gap between:

* 🧮 Traditional stack machines (compact but slow)
* ⚡ Register-based systems (fast but complex)

By introducing **TOS/NOS hardware buffering**, the design avoids repeated memory access, significantly improving execution speed while maintaining simplicity.

---

## 📂 Project Structure

```
/src         -> Verilog modules (ALU, Control Unit, Stack, etc.)
/testbench   -> Simulation testbenches
/docs        -> Architecture and ISA documentation (optional)
```

---

## 🛠️ Technologies Used

* Verilog HDL
* Digital Design (RTL)
* Stack-Based ISA Design

---

## 🎯 Learning Objectives

* ISA Design from scratch
* Datapath & Control Unit implementation
* Stack-based execution model optimization
* Hardware-software co-design concepts

---

## 🚀 Future Improvements

* Pipelined version of the processor
* Extended instruction set
* Hazard handling & performance optimizations

---

## 👑 Author
Muhammad Ahmed Qazi (CS-24045) &
Mujtaba Jawaid Rao(CS-24047)
Developed as part of **Computer Organization & Design (CS-221)** coursework.
