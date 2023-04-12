attribute vec3 position;
attribute vec2 texCoord;

varying vec2 TexCoord;

uniform mat4 transform;

void main()
{
    gl_Position = transform * vec4(position, 1.0);
    TexCoord = vec2(texCoord.x, 1.0 - texCoord.y);
}