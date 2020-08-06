attribute vec4 a_position;
attribute vec2 a_texCoord;
#ifdef GL_ES
varying mediump vec2 v_texCoord;
#else
varying vec2 v_texCoord;
#endif

//uniform	float u_radius;
//uniform	float u_angle;

vec2 vortex( vec2 uv )
{
	float radius = 0.5;
	float angle = 0.5;
	uv -= vec2(0.5, 0.5);
	float dist = length(uv);
	float percent = (radius - dist) / radius;
	if ( percent < 1.0 && percent >= 0.0) 
	{
		float theta = percent * percent * angle * 8.0;
		float s = sin(theta);
		float c = cos(theta);
		uv = vec2(dot(uv, vec2(c, -s)), dot(uv, vec2(s, c)));
	}
	uv += vec2(0.5, 0.5);

	return uv;
}

void main()
{
    gl_Position = CC_MVPMatrix * a_position;
    v_texCoord = vortex( a_texCoord );
}