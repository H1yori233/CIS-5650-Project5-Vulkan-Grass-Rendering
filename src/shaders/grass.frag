#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 normal;
layout(location = 1) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 color1 = vec3(0.39, 0.90, 0.36);
	vec3 color2 = vec3(0.26, 0.48, 0.26);
    vec3 color = mix(color2, color1, uv.y);
    outColor = vec4(color, 1.0);
}
