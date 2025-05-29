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
	float ambient = 0.235;
	vec3 color1 = vec3(0.52, 0.84, 0.32);
	vec3 color2 = vec3(0.25, 0.12, 0.18);

    vec3 diffuse = mix(color2, color1, uv.y);
	vec3 lightDir = normalize(vec3(1.0, 2.0, -1.0));

    float NdotL = clamp(dot(normal, lightDir), 0.0, 1.0);
	vec3 color = (ambient + NdotL) * diffuse;
    outColor = vec4(color, 1.0);
}
