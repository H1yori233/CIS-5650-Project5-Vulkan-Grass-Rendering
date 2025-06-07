#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec3 inV0[];
layout(location = 1) in vec3 inV1[];
layout(location = 2) in vec3 inV2[];
layout(location = 3) in vec3 inParams[];

layout(location = 0) out vec3 outV0[];
layout(location = 1) out vec3 outV1[];
layout(location = 2) out vec3 outV2[];
layout(location = 3) out vec3 outParams[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    outV0[gl_InvocationID] = inV0[gl_InvocationID];
    outV1[gl_InvocationID] = inV1[gl_InvocationID];
    outV2[gl_InvocationID] = inV2[gl_InvocationID];
    outParams[gl_InvocationID] = inParams[gl_InvocationID];

	// TODO: Set level of tesselation
    float z1 = (camera.proj * camera.view * vec4(outV1[gl_InvocationID], 1)).z;
    float z2 = (camera.proj * camera.view * vec4(outV2[gl_InvocationID], 1)).z;

    if(z1 < 0.95  && z2 < 0.95) {
        gl_TessLevelInner[0] = 2;
        gl_TessLevelInner[1] = 8;
        gl_TessLevelOuter[0] = 6;
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
