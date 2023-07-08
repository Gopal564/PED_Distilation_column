# Process Equipment Design of a Distillation Column

## Introduction
This project focuses on the design of a bubble cap distillation column for a binary mixture of benzene and toluene. The objective is to determine the column design parameters based on given input parameters and calculate the optimal operating conditions.

## Overview
The project involves the calculation of various design parameters and steps to determine the optimal design for the distillation column. These parameters include flow rates, compositions, pressures, stages, tray hydraulics, and costs.

## Problem Statement
Design a bubble cap distillation column to separate a binary mixture of benzene and toluene, given the flow rates, feed composition, and desired distillate and bottom concentrations.

## Approach to the Problem
1. Obtain data and input parameters for the binary mixture.
2. Perform calculations to determine the alpha value based on pressure.
3. Implement the McCabe method in MATLAB to obtain ideal and actual stages and the feed tray location.
4. Estimate the cost of the column by calculating the diameter, height, tray costs, and additional overhead costs.
5. Determine the optimum R/R_min with the lowest total cost.
6. Calculate tray hydraulics, bubble cap design, and pressure drops.

## Solution
The project involves the following steps of calculation:
1. Calculation of Alpha based on pressure.
2. Implementation of the McCabe method to obtain ideal and actual stages and the feed tray location.
3. Rough estimation of the cost to obtain the R/R_min optimum.
4. Tray hydraulics and bubble cap design calculations.

## Conclusion or Inferences
The calculated design parameters for the distillation column are as follows:
- Tray/Tower diameter (D): 1.6 m
- Tower area (A): 2.01 m²
- Active area (A_active): 1.2 m²
- Downcomer area (Adc): 0.24 m²
- Number of passes (NP): 1
- Weir height (hw): 73 mm
- Downcomer type: Segmental
- Tray spacing (TS): 600 mm
- Residence time: 8.9 seconds

The project successfully determined the optimal design parameters for the bubble cap distillation column based on the given input parameters.

Note - For more detailed result you can check our PED_Repot and You can also use excel file. There is also matlab code which can be used for McCabe Thiele Method to calculate ideal and actual number of stages and there is also code to graph the ideal McCabe Thiele Diagram.
