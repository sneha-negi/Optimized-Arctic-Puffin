# Arctic Puffin Optimization (APO) - Algorithm Optimization

## Overview

This project involves optimizing the **Arctic Puffin Optimization (APO)** algorithm, which is inspired by the foraging behavior of puffins. The original algorithm uses a variety of strategies to search for optimal solutions in a given problem space. In this modified version, I introduced several enhancements to improve the algorithm's efficiency and performance.

## Key Modifications

### 1. **Dynamic `F` Parameter**

-   In the original APO algorithm, the **`F` parameter** (related to puffin's flight direction) was constant throughout the optimization process.
-   **Change:** I made `F` **dynamic**, allowing it to vary during the optimization. This change helps the algorithm adapt more effectively to the changing conditions during the search process, improving the balance between exploration and exploitation.

### 2. **Exponential Decay for the Value of `C`**

-   **Original Behavior:** The value of **`C`** (which controls the puffins' step size) was typically fixed.
-   **Change:** I introduced **exponential decay** for `C`, which reduces the step size over time as the algorithm progresses. This change ensures that the algorithm explores the search space more broadly in the early stages and refines its solutions as it converges, leading to better accuracy in the later stages of optimization.

### 3. **Modified Levy Flight Function**

-   **Original Behavior:** The Levy flight function was used to simulate random jumps by puffins, helping them escape local optima and explore new areas of the search space.
-   **Change:** I modified the **Levy flight function** so that the step size is no longer constant. Instead, the algorithm now decides how big a step to take based on the **best fitness value** encountered during the search. Specifically, if the algorithm is close to the best fitness value (global optimum), the step size is reduced to make finer adjustments; otherwise, larger steps are taken to explore more diverse areas of the search space.

## Results

The modified version of the Arctic Puffin Optimization algorithm outperformed the original in several benchmark tests. An **improvement ratio of 2%** was achieved, demonstrating the effectiveness of the changes. These modifications led to improvements in convergence rates and the ability to avoid local optima.
