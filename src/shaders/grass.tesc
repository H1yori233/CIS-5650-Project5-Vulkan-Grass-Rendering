#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];
layout(location = 3) in vec4 in_up[];

layout(location = 0) out vec4 out_v0[];
layout(location = 1) out vec4 out_v1[];
layout(location = 2) out vec4 out_v2[];
layout(location = 3) out vec4 out_up[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    out_v0[gl_InvocationID] = in_v0[gl_InvocationID];
    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];
    out_up[gl_InvocationID] = in_up[gl_InvocationID];

	// TODO: Set level of tesselation
    float z1 = (camera.proj * camera.view * vec4(out_v1[gl_InvocationID].xyz, 1)).z;
    float z2 = (camera.proj * camera.view * vec4(out_v2[gl_InvocationID].xyz, 1)).z;

    if(z1 < 0.95  && z2 < 0.95) {
        gl_TessLevelInner[0] = 3;
        gl_TessLevelInner[1] = 8;
        gl_TessLevelOuter[0] = 8;
        gl_TessLevelOuter[1] = 3;
        gl_TessLevelOuter[2] = 8;
        gl_TessLevelOuter[3] = 3;
    } else if (z1 < 0.8 && z2 < 0.8) {
        gl_TessLevelInner[0] = 2;
        gl_TessLevelInner[1] = 7;
        gl_TessLevelOuter[0] = 7;
        gl_TessLevelOuter[1] = 2;
        gl_TessLevelOuter[2] = 7;
        gl_TessLevelOuter[3] = 2;
    } else {
        gl_TessLevelInner[0] = 1;
        gl_TessLevelInner[1] = 3;
        gl_TessLevelOuter[0] = 3;
        gl_TessLevelOuter[1] = 1;
        gl_TessLevelOuter[2] = 3;
        gl_TessLevelOuter[3] = 1;
    }
}
