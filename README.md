Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* H1yori233
  * [Github](https://github.com/H1yori233)
  * https://h1yori233.github.io
  * https://www.linkedin.com/in/kaiqin-kong-4709b0357/
* Tested on: **Google Chrome 137.0.7107.0, canary** on Windows 11, AMD Ryzen 7 5800H @ 3.20GHz 16GB, RTX 3050 Laptop 4GB

## Project Overview

This project implements a real-time grass rendering system using Vulkan. The grass simulation uses Bezier curves to represent individual grass blades, with compute shaders performing physics calculations and culling operations. The remaining visible blades are rendered through a graphics pipeline featuring tessellation shaders for dynamic geometry generation.

![grass_rendering](/img/grass_rendering.gif)

## Features Implemented

* **Compute Shader Physics Simulation**
  * Gravity, recovery, and wind forces on grass blades
  * Bezier curve-based grass blade representation
* **Culling Optimizations**
  * Orientation culling (view-perpendicular blades)
  * View-frustum culling
  * Distance-based culling

![grass](/img/my_grass.gif)
