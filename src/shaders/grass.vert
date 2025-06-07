#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 inV0;
layout(location = 1) in vec4 inV1;
layout(location = 2) in vec4 inV2;
layout(location = 3) in vec4 inUp;

layout(location = 0) out vec3 outV0;
layout(location = 1) out vec3 outV1;
layout(location = 2) out vec3 outV2;
layout(location = 3) out vec3 outParams;

out gl_PerVertex {
    vec4 gl_Position;

    // add to fix validation layer error
    float gl_PointSize;
    float gl_ClipDistance[];
    float gl_CullDistance[];
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
    vec4 v0 = model * vec4(inV0.xyz, 1);
    gl_Position = v0;
    outV0 = v0.xyz / v0.w;
    
    vec4 v1 = model * vec4(inV1.xyz, 1);
    outV1 = v1.xyz / v1.w;
    
    vec4 v2 = model * vec4(inV2.xyz, 1);
    outV2 = v2.xyz / v2.w;

    // Pack angle, height, width into outParams
    outParams = vec3(inV0.w, inV1.w, inV2.w);
}
