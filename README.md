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

### 1. Grass Representation
- **Bezier Curve Model**: Each grass blade is represented as a Bezier curve with three control points:
  - `v0`: Position on the geometry
  - `v1`: Guide point above `v0` (relative to the blade's up vector)
  - `v2`: Physical guide for force simulation
- **Per-Blade Characteristics**: 
  - Up vector (normal of the geometry at `v0`)
  - Orientation (blade's facing direction)
  - Height and width parameters
  - Stiffness coefficient for physics simulation

### 2. Physics Simulation (Compute Shader)
- **Gravity Force**: Implemented environmental gravity with front-facing component
- **Recovery Force**: Based on Hooke's law to restore blades to equilibrium position
- **Wind Force**: Time-dependent directional forces with wind alignment factor
- **Position Correction**: Ensures blade length preservation and prevents ground penetration

### 3. Culling Optimizations
The project implements three different culling techniques to improve performance:

| Orientation Culling | View-Frustum Culling | Distance Culling |
|-------------------|----------------|-------------|
| ![orientation](/img/orientation.gif) | ![frustum](/img/frustum.gif) | ![distance](/img/distance.gif) |
| Culls blades whose front face is nearly perpendicular to the view vector, avoiding sub-pixel rendering artifacts | Removes blades outside the camera's view frustum using a three-point visibility test (`v0`, `v2`, and midpoint) | Implements distance-based LOD culling with multiple buckets, progressively removing more blades at greater distances |


## Implementation Details

### Bezier Curve Data Structure
Each grass blade's data is packed into four `vec4`s:
- `v0.xyz`: Position, `v0.w`: Orientation
- `v1.xyz`: First control point, `v1.w`: Height
- `v2.xyz`: Second control point, `v2.w`: Width
- `up.xyz`: Up vector, `up.w`: Stiffness coefficient

### Force Calculation
The total force applied to each blade is calculated as:
```
totalForce = gravity + recovery + wind
```
Where:
- `gravity = environmentalGravity + frontGravity`
- `recovery = (initialV2 - currentV2) * stiffness`
- `wind = windDirection * windAlignment`

![grass](/img/my_grass.gif)
