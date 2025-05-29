#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 inV0[];
layout(location = 1) in vec4 inV1[];
layout(location = 2) in vec4 inV2[];
layout(location = 3) in vec4 inUp[];

layout(location = 0) out vec3 normal;
layout(location = 1) out vec3 pos;
layout(location = 2) out vec2 uv;

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
    vec3 v0 = inV0[0].xyz;
    vec3 v1 = inV1[0].xyz;
    vec3 v2 = inV2[0].xyz;

    vec3 a = lerp(v0, v1, v);
    vec3 b = lerp(v1, v2, v);
    vec3 c = lerp(a , b , v);

    float angle     = inV0[0].w;
    float height    = inV1[0].w;
    float width     = inV2[0].w;

    vec3 dir = vec3(cos(angle), 0, sin(angle));
    vec3 tangent = normalize(b - a);
    normal = normalize(cross(tangent, dir));

    vec3 camFwd = normalize(vec3(camera.view[0].z, camera.view[1].z, camera.view[2].z));
    vec3 right;
    if (dot(camFwd, normal) > 0.f)
    {
        normal  = -normal;
        tangent = -tangent;
    }
    right = cross(tangent, normal);
    
    a = slerp(normal, -right, 0.4f);
    b = reflect(-a, normal);
    normal = normalize(slerp(a, b, u));

    vec3 c0 = c - dir * width;
    vec3 c1 = c + dir * width;
    float t = u + 0.5f * v - u * v;

    pos = mix(c0, c1, t);
    gl_Position = camera.proj * camera.view * vec4(pos, 1.f);
}
