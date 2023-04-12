#ifdef GL_ES
precision mediump float;
#endif 

varying mediump vec2 TexCoord;

uniform sampler2D ourTexture1;
//uniform sampler2D ourTexture2;

void main()
{
  vec4 texColor = texture2D(ourTexture1, TexCoord);
  if (texColor.a < 0.1)
    discard;
//  gl_FragColor = texColor;
  // mix(texture2D(ourTexture1, TexCoord), texture2D(ourTexture2, TexCoord), 0.2);
gl_FragColor = texture2D(ourTexture1, TexCoord);
}

