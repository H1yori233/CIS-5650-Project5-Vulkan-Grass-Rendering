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

vec3 light_dir = normalize(vec3(0.3, 0.4, 0.5));
vec3 ambientColor = vec3(0.1, 0.3, 0.1); // Dark green ambient
vec3 diffuseColor = vec3(0.3, 0.7, 0.3); // Brighter green diffuse

void main() {
    // TODO: Compute fragment color
    vec3 N = normalize(normal);
    float diffuseFactor = max(dot(N, light_dir), 0.0);
    vec3 finalColor = ambientColor + diffuseColor * diffuseFactor;

    outColor = vec4(finalColor, 1.0);
}
