# 3-1 Assembly Lab Codes

Source codes from the assembly lab of 3rd year 1st semester Microprocessor and Assembly Language Lab.

## Overview

This repository contains ARM assembly language programs written for the Microprocessor and Assembly Language Lab course. The code is organized by lab assignments and includes various exercises covering fundamental assembly programming concepts.

## Development Environment

The projects are configured for ARM Cortex-M4 microcontrollers and use:
- **Keil MDK-ARM** (`.uvprojx` project files)
- **ARM Cortex-M4** target (STM32F446RE for some labs, ARMCM4 for others)
- **ARM Assembly** syntax

## Building and Running

1. Open the respective `.uvprojx` file in Keil MDK-ARM
2. Build the project (F7)
3. Debug/Flash to target device

## Notes

- Each lab folder contains the assembly source files (`.s`) for that lab's exercises
- Some labs include project configuration files for Keil MDK-ARM
- Lab reports are included where available (`.tex` files)
- Compiled object files and build artifacts are in the `Objects/` directories
