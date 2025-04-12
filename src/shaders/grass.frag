#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 normal;
layout(location = 1) in vec3 pos;
layout(location = 2) in vec2 uv;

layout(location = 0) out vec4 outColor;

vec3 light_dir = vec3(0.3, 0.4, 0.5);

void main() {
    // TODO: Compute fragment color
    vec3 color = normal * light_dir;
    outColor = vec4(color, 1.0);
}
