
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

layout(location = 0) out vec4 outV1;
layout(location = 1) out vec4 outV2;
layout(location = 2) out vec4 outUp;
layout(location = 3) out vec4 outBitangent;

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
    
    outV1 = model * vec4(inV1.xyz, 1);
    outV1 /= outV1.w;
    outV1.w = inV1.w;
    
    outV2 = model * vec4(inV2.xyz, 1);
    outV2 /= outV2.w;
    outV2.w = inV2.w;

    outUp = vec4(normalize(inUp.xyz), inUp.w);

    float angle     = inV0.w;
    float height    = inV1.w;
    float width     = inV2.w;

    vec3 dir        = vec3(cos(angle), 0, sin(angle));
    vec3 up         = normalize(inUp.xyz);
    vec3 bitangent  = normalize(cross(up, dir));
    outBitangent = vec4(bitangent, 0);
}
