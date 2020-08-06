#ifdef GL_ES
precision lowp float;
#endif

varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;

void main() {
	vec4 color = texture2D(CC_Texture0, v_texCoord);
	float alpha = color.a;
	float gray = dot(color.rgb, vec3(0.4, 0.7, 0.2));
	vec3 Purple_Test = vec3(0.57,0.44,0.89)*gray;
	gl_FragColor=vec4(Purple_Test.r,Purple_Test.g,Purple_Test.b,alpha);
}