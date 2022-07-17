#version 450

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 proj;
} ubo;

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec2 inTexCoord;
layout(location = 3) in vec3 inModelCenter;
layout(location = 4) in int inRotationCount;

layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec2 fragTexCoord;

void main() {
	vec4 rotateBuffer = vec4(inPosition - inModelCenter, 1.0);
	for(int i = 0; i < inRotationCount; i++)
	{
	rotateBuffer = ubo.model * rotateBuffer;
	}
	rotateBuffer = rotateBuffer + vec4(inModelCenter, 0.0);
    gl_Position = ubo.proj * ubo.view * rotateBuffer;
    fragColor = inColor;
    fragTexCoord = inTexCoord;
}