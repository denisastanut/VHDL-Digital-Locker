# VHDL-Digital-Locker

## Overview
This project is a simple **digital locker system** implemented in **VHDL**.  
The locker is secured with a custom 3-character code and is designed to run on an FPGA board using **Xilinx Vivado**.

## Features
- Lock/unlock functionality  
- LED indicators for system status  
- 7-segment display for user interaction  
- Reset option to return to initial state  

## Components
- **Counter** – used for character selection
- **RAM Memory** – stores the 3-character code and compares it with the user input  
- **Decoder (DCD)** – converts binary values to 7-segment display signals  
- **MPG (Multipulse Generator)** – debounces button inputs and synchronizes signals  
- **Control Unit (UC)** – handles the system’s state machine (lock, unlock, reset)  
- **Execution Unit (UE)** – manages resources like memory, counter, and display  
- **LED Indicators** – show locker status
