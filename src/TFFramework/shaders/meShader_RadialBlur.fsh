#ifdef GL_ES
precision lowp float;
#endif

varying vec2 v_texCoord;
uniform vec2 u_centerpos;
uniform float u_sampleDist;
uniform float u_sampleStrength;
uniform sampler2D CC_Texture0;

void main() {

	float level = u_sampleDist;
	float contrast = u_sampleStrength;
	
	vec2 center = u_centerpos;
	vec2 uv = v_texCoord - center;
	vec4 c = vec4(0.0);
	vec3 c1 = vec3(0.0);
	
	for(float i = 0.0; i <= level; i = i + 1.0)
	{
		c1+=texture2D(CC_Texture0, uv*(1.0-0.01*i)+center).rgb;  
	}
	c.rgb=c1/level;
	c.a=1.0;
		
	gl_FragColor = c * contrast;
}
