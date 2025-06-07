#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec3 inV0[];
layout(location = 1) in vec3 inV1[];
layout(location = 2) in vec3 inV2[];
layout(location = 3) in vec3 inParams[];

layout(location = 0) out vec3 normal;
layout(location = 1) out vec2 uv;

vec3 lerp(vec3 A, vec3 B, float t) {
    return (1 - t) * A + t * B;
}

vec3 slerp(vec3 A, vec3 B, float t) {
	float dot = dot(A, B);
	dot = clamp(dot, -1.f, 1.f);
	
    float theta = acos(dot) * t;
	vec3 relative = normalize(B - A * dot);
	return A * cos(theta) + relative * sin(theta);
}

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    uv = vec2(u, v);
    vec3 v0 = inV0[0];
    vec3 v1 = inV1[0];
    vec3 v2 = inV2[0];

    vec3 a = lerp(v0, v1, v);
    vec3 b = lerp(v1, v2, v);
    float tCurve = v * v;              // quadratic ease-out
    vec3 c = lerp(a, b, tCurve);

    float angle = inParams[0].x;
    float height = inParams[0].y;
    float width = inParams[0].z;

    // Calculate bitangent in tese shader instead of vertex shader
    vec3 dir = vec3(cos(angle), 0, sin(angle));
    vec3 up = vec3(0, 1, 0); // Using world up instead of inUp
    vec3 bitangent = normalize(cross(up, dir));

    vec3 c0 = c - bitangent * width;
    vec3 c1 = c + bitangent * width;
    float t = u + 0.5f * v - u * v;

    vec3 pos = mix(c0, c1, t);
    gl_Position = camera.proj * camera.view * vec4(pos, 1.f);
}
