
local blurFrag = [[
#ifdef GL_ES                                    
precision highp float;                           
#endif                                                                   
varying vec4        v_fragmentColor;            
varying vec2        v_texCoord;                 
uniform sampler2D   CC_Texture0;                      

vec2 resolution = vec2(1.0, 1.0);
uniform float blurRadius;// = 0.01;
uniform float sampleNum;// = 2.5;

void main(void)
{
    vec3 col = vec3(0.0);
    //vec2 unit = 1.0 / resolution.xy;
    vec2 unit = resolution;
        
    float r = blurRadius;
    float sampleStep = r / sampleNum;
        
    float count = 0.0;
        
    for(float x = -r; x < r; x += sampleStep)
    {
        for(float y = -r; y < r; y += sampleStep)
        {
            float weight = (r - abs(x)) * (r - abs(y));
            col += texture2D(CC_Texture0, v_texCoord + vec2(x * unit.x, y * unit.y)).rgb * weight;
            count += weight;
        }
    }
        
	gl_FragColor = vec4(col / count, 1.0) * v_fragmentColor;
} 
]]

local zoomBlurFrag = [[
#ifdef GL_ES                                  
precision highp float;                           
#endif                                                                   
varying vec4        v_fragmentColor;            
varying vec2        v_texCoord;                 
uniform sampler2D   CC_Texture0;                      

vec2 u_blurCenter = vec2(0.5);
float u_blurSize = 1.0;

void main()
{
    // TODO: Do a more intelligent scaling based on resolution here
    vec2 samplingOffset = 1.0/100.0 * (u_blurCenter - v_texCoord) * u_blurSize;
    
#ifdef GL_ES
    lowp vec4 fragmentColor = texture2D(CC_Texture0, v_texCoord) * 0.18;
#else
    vec4 fragmentColor = texture2D(CC_Texture0, v_texCoord) * 0.18;
#endif
    fragmentColor += texture2D(CC_Texture0, v_texCoord + samplingOffset) * 0.15;
    fragmentColor += texture2D(CC_Texture0, v_texCoord + (2.0 * samplingOffset)) *  0.12;
    fragmentColor += texture2D(CC_Texture0, v_texCoord + (3.0 * samplingOffset)) * 0.09;
    fragmentColor += texture2D(CC_Texture0, v_texCoord + (4.0 * samplingOffset)) * 0.05;
    fragmentColor += texture2D(CC_Texture0, v_texCoord - samplingOffset) * 0.15;
    fragmentColor += texture2D(CC_Texture0, v_texCoord - (2.0 * samplingOffset)) *  0.12;
    fragmentColor += texture2D(CC_Texture0, v_texCoord - (3.0 * samplingOffset)) * 0.09;
    fragmentColor += texture2D(CC_Texture0, v_texCoord - (4.0 * samplingOffset)) * 0.05;
    
    gl_FragColor = fragmentColor;
}

]]

local gaussianBlurFrag = [[
#ifdef GL_ES                                    
precision highp float;                           
#endif  
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

uniform float texelWidthOffset;
uniform float texelHeightOffset;

void main()
{
	vec4 sum = vec4(0.0);
	vec2 singleStepOffset = vec2(texelWidthOffset, texelHeightOffset);
	sum += texture2D(CC_Texture0, v_texCoord) * 0.026429;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 1.498535)  * 0.052601;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 1.498535)  * 0.052601;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 3.496582)  * 0.051585;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 3.496582)  * 0.051585;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 5.494629)  * 0.049804;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 5.494629)  * 0.049804;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 7.492676)  * 0.047341;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 7.492676)  * 0.047341;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 9.490724)  * 0.044302;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 9.490724)  * 0.044302;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 11.488771) * 0.040816;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 11.488771) * 0.040816;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 13.486818) * 0.037022;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 13.486818) * 0.037022;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 15.484867) * 0.033061;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 15.484867) * 0.033061;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 17.482916) * 0.029066;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 17.482916) * 0.029066;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 19.480965) * 0.025158;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 19.480965) * 0.025158;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 21.479017) * 0.021438;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 21.479017) * 0.021438;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 23.477066) * 0.017986;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 23.477066) * 0.017986;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 25.475119) * 0.014855;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 25.475119) * 0.014855;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 27.473169) * 0.012080;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 27.473169) * 0.012080;
	sum += texture2D(CC_Texture0, v_texCoord + singleStepOffset * 29.471224) * 0.009670;
	sum += texture2D(CC_Texture0, v_texCoord - singleStepOffset * 29.471224) * 0.009670;
    gl_FragColor = sum * v_fragmentColor;
}
]]

local contrastFrag = [[
#ifdef GL_ES			                        
precision highp float; 		
#endif					
					
varying vec4 v_fragmentColor;		
varying vec2 v_texCoord;			

//uniform float u_contrast;
float u_contrast = 0.7;
				
void main()									
{			 
    vec4 textureColor = texture2D(CC_Texture0, v_texCoord);
    textureColor *= texture2D(CC_Texture1, v_texCoord).r;

    gl_FragColor = vec4(((textureColor.rgb - vec3(0.5)) * u_contrast + vec3(0.5)), textureColor.w) * v_fragmentColor;	
    //gl_FragColor = vec4((textureColor.rgb * u_contrast), textureColor.w) * v_fragmentColor;	
}	
]]


local saturationFrag = [[
#ifdef GL_ES			                        
precision highp float; 		
#endif					
					
varying vec4 v_fragmentColor;		
varying vec2 v_texCoord;			

//uniform float u_saturation;
float u_saturation = 0.25;
const vec3 luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);

void main()
{
    vec4 textureColor = texture2D(CC_Texture0, v_texCoord);
    textureColor *= texture2D(CC_Texture1, v_texCoord).r;

    float luminance = dot(textureColor.rgb, luminanceWeighting);
    vec3 greyScaleColor = vec3(luminance);
    gl_FragColor = vec4(mix(greyScaleColor, textureColor.rgb, u_saturation), textureColor.w) * v_fragmentColor;
}

]]

local hsvFrag = [[
#ifdef GL_ES                        
precision highp float; 
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform vec3 u_hsvColor;

const vec4 k_hsv = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
const vec4 k_rgb = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
const float e = 1.0e-10;

vec3 rgb2hsv(vec3 c)
{
    vec4 p = mix(vec4(c.bg, k_hsv.wz), vec4(c.gb, k_hsv.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec3 p = abs(fract(c.xxx + k_rgb.xyz) * 6.0 - k_rgb.www);
    return c.z * mix(k_rgb.xxx, clamp(p - k_rgb.xxx, 0.0, 1.0), c.y);
}

void main()
{
    vec4 color = (texture2D(CC_Texture0, v_texCoord) * texture2D(CC_Texture1, v_texCoord).r) * v_fragmentColor;
    gl_FragColor.rgb = hsv2rgb(rgb2hsv(color.rgb) + u_hsvColor.rgb) * color.a;
    gl_FragColor.a = color.a;
}
]]

local glowFrag = [[
    #ifdef GL_ES                        
    precision highp float; 
    #endif

    varying vec4 v_fragmentColor;
    varying vec2 v_texCoord;

    uniform vec2 TextureSize;
    uniform vec3 GlowColor;
    uniform float GlowRange;
    uniform float GlowExpand;

    void main()
    {
        vec4 tcolor = texture2D( CC_Texture0, v_texCoord );

        float R = 0.0, G = 0.0, B = 0.0, A = 0.0;
        float samplerPre = 2.0;                                                                                                    
        float radiusX = TextureSize.x;                                                                                       
        float radiusY = TextureSize.y;                                                                                      
        float glowAlpha = 0.0;                                                                                                    
        float count = 0.0;                                                                                
        for( float i = -GlowRange ; i <= GlowRange ; i += samplerPre )                                                            
        {                                                                                                                         
            for( float j = -GlowRange ; j <= GlowRange ; j += samplerPre )                                                        
            {                                                                                                                     
                vec2 samplerTexCoord = vec2( v_texCoord.x + j * radiusX , v_texCoord.y + i * radiusY );                           
                if( samplerTexCoord.x < 0.0 || samplerTexCoord.x > 1.0 || samplerTexCoord.y < 0.0 || samplerTexCoord.y > 1.0 )     
                {    
                    glowAlpha +=0.0;                                                                                              
                }
                else             
                {
                    glowAlpha += texture2D( CC_Texture0, samplerTexCoord ).a;     
                    count +=1.0;                                                                                                      
                }
            }                                                                                                                     
        }                                                                                                                          
        glowAlpha /= count;           
        R = GlowColor.r;                                                                                                          
        G = GlowColor.g;                                                                                                           
        B = GlowColor.b;                                                                                                         
        A = glowAlpha * GlowExpand; 

        gl_FragColor = (vec4(R * A, G * A, B * A, A) * (1.0 - tcolor.a) + tcolor) * v_fragmentColor;
    }
]]

local glowFrag_NoFragColor = [[
    #ifdef GL_ES                        
    precision highp float; 
    #endif

    varying vec2 v_texCoord;

    uniform vec2 TextureSize;
    uniform vec3 GlowColor;
    uniform float GlowRange;
    uniform float GlowExpand;

    void main()
    {
        vec4 tcolor = texture2D( CC_Texture0, v_texCoord );

        float R = 0.0, G = 0.0, B = 0.0, A = 0.0;
        float samplerPre = 2.0;                                                                                                    
        float radiusX = TextureSize.x;                                                                                       
        float radiusY = TextureSize.y;                                                                                      
        float glowAlpha = 0.0;                                                                                                    
        float count = 0.0;                                                                                
        for( float i = -GlowRange ; i <= GlowRange ; i += samplerPre )                                                            
        {                                                                                                                         
            for( float j = -GlowRange ; j <= GlowRange ; j += samplerPre )                                                        
            {                                                                                                                     
                vec2 samplerTexCoord = vec2( v_texCoord.x + j * radiusX , v_texCoord.y + i * radiusY );                           
                if( samplerTexCoord.x < 0.0 || samplerTexCoord.x > 1.0 || samplerTexCoord.y < 0.0 || samplerTexCoord.y > 1.0 )     
                {    
                    glowAlpha +=0.0;                                                                                              
                }
                else             
                {
                    glowAlpha += texture2D( CC_Texture0, samplerTexCoord ).a;     
                    count +=1.0;                                                                                                      
                }
            }                                                                                                                     
        }                                                                                                                          
        glowAlpha /= count;           
        R = GlowColor.r;                                                                                                          
        G = GlowColor.g;                                                                                                           
        B = GlowColor.b;                                                                                                         
        A = glowAlpha * GlowExpand; 

        gl_FragColor = (vec4(R * A, G * A, B * A, A) * (1.0 - tcolor.a) + tcolor);
    }
]]

local highlightFrag = [[
    #ifdef GL_ES                        
    precision highp float; 
    #endif

    varying vec4 v_fragmentColor;
    varying vec2 v_texCoord;
    
    uniform float HighRate;

    void main()
    {
        vec4 tex = texture2D(CC_Texture0, v_texCoord);	
        tex *= texture2D(CC_Texture1, v_texCoord).r;
                                
        if (tex.r == 0.0 && tex.g == 0.0 && tex.b == 0.0 && tex.a > 0.8)		
        {																		
            tex.r = tex.g = tex.b = 0.1;										
        }																		
        tex *= HighRate;																
        gl_FragColor = tex;	
    }
]]

local vert = [[  
attribute vec4 a_position;							
attribute vec2 a_texCoord;							
attribute vec4 a_color;								
													
#ifdef GL_ES										
varying lowp vec4 v_fragmentColor;					
varying mediump vec2 v_texCoord;					
#else												
varying vec4 v_fragmentColor;						
varying vec2 v_texCoord;							
#endif												
													
void main()											
{													
    gl_Position = CC_MVPMatrix * a_position;		
	v_fragmentColor = a_color;						
	v_texCoord = a_texCoord;						
}													
]]

local vert_no_color = [[  
attribute vec4 a_position;							
attribute vec2 a_texCoord;								
													
#ifdef GL_ES										
varying mediump vec2 v_texCoord;					
#else												
varying vec2 v_texCoord;							
#endif												
													
void main()											
{													
    gl_Position = CC_MVPMatrix * a_position;					
	v_texCoord = a_texCoord;						
}													
]]


--[[--
	shader管理器:

	--By: yuqing
	--2013/10/30
]]
TFShaderManager = class("TFShaderManager", TFShaderManager)

function TFShaderManager:init()
	-- self:addShaderWithFilename("TFFramework/shaders/meShader_OutLine2.fsh", "TFFramework/shaders/ccShader_TexturePositionColor.vsh", "OutLine2")
	-- self:addShaderWithFilename("TFFramework/shaders/ccShader_Label_df_glow.fsh", "TFFramework/shaders/ccShader_TexturePositionColor.vsh", "GLOW")
    self:initConstract()
    self:initSaturation()
    self:initBlur()
    self:initHSV()
    self:initGlow()
    self:initGlow_NoFragColor()
    self:initCustomHighlight()
end

function TFShaderManager:initGlow()
    local shaderName = "GlowEX"
    if me.ShaderCache:getGLProgram(shaderName) then return end
    local shader = TFShaderManager:addShaderWithContent(glowFrag, vert, shaderName)
end

function TFShaderManager:initGlow_NoFragColor()
    local shaderName = "GlowEX_NoFragColor"
    if me.ShaderCache:getGLProgram(shaderName) then return end
    local shader = TFShaderManager:addShaderWithContent(glowFrag_NoFragColor, vert_no_color, shaderName)
end

function TFShaderManager:initConstract()
    local shaderName = "Contrast"
    if me.ShaderCache:getGLProgram(shaderName) then return end
    local shader = TFShaderManager:addShaderWithContent(contrastFrag, vert, shaderName)
    -- TFShaderManager:setUniform1f(shaderName, "u_contrast", 0.7)
end

function TFShaderManager:initSaturation()
    local shaderName = "Saturation"
    if me.ShaderCache:getGLProgram(shaderName) then return end
    local shader = TFShaderManager:addShaderWithContent(saturationFrag, vert, shaderName)
    -- TFShaderManager:setUniform1f(shaderName, "u_saturation", 0.25)
end

function TFShaderManager:initBlur()
    local shaderName = "Blur"
    if me.ShaderCache:getGLProgram(shaderName) then return end
    local shader = TFShaderManager:addShaderWithContent(gaussianBlurFrag, vert, shaderName)
end

function TFShaderManager:initHSV()
    local shaderName = "HSV"
    if me.ShaderCache:getGLProgram(shaderName) then return end
    local shader = TFShaderManager:addShaderWithContent(hsvFrag, vert, shaderName)
end

function TFShaderManager:initCustomHighlight()
    local shaderName = "CustomHighlight"
    if me.ShaderCache:getGLProgram(shaderName) then return end
    local shader = TFShaderManager:addShaderWithContent(highlightFrag, vert, shaderName)
end

function TFShaderManager:setUniform1i(shadeName, uniformName, value)
	local shader = me.ShaderCache:programForKey(shadeName)
	if shader then 
		shader:use()
		local location = shader:getUniformLocationForName(uniformName)
		shader:setUniformLocationWith1i(location, value)
	end
end

function TFShaderManager:setUniform2i(shadeName, uniformName, ...)
	local shader = me.ShaderCache:programForKey(shadeName)
	if shader then 
		shader:use()
		local location = shader:getUniformLocationForName(uniformName)
		shader:setUniformLocationWith2i(location, ...)
	end
end

function TFShaderManager:setUniform3i(shadeName, uniformName, ...)
	local shader = me.ShaderCache:programForKey(shadeName)
	if shader then 
		shader:use()
		local location = shader:getUniformLocationForName(uniformName)
		shader:setUniformLocationWith3i(location, ...)
	end
end

function TFShaderManager:setUniform4i(shadeName, uniformName, ...)
	local shader = me.ShaderCache:programForKey(shadeName)
	if shader then 
		shader:use()
		local location = shader:getUniformLocationForName(uniformName)
		shader:setUniformLocationWith4i(location, ...)
	end
end

function TFShaderManager:setUniform1f(shadeName, uniformName, value)
	local shader = me.ShaderCache:programForKey(shadeName)
	if shader then 
		shader:use()
		local location = shader:getUniformLocationForName(uniformName)
		shader:setUniformLocationWith1f(location, value)
	end
end

function TFShaderManager:setUniform2f(shadeName, uniformName, ...)
	local shader = me.ShaderCache:programForKey(shadeName)
	if shader then 
		shader:use()
		local location = shader:getUniformLocationForName(uniformName)
		shader:setUniformLocationWith2f(location, ...)
	end
end

function TFShaderManager:setUniform3f(shadeName, uniformName, ...)
	local shader = me.ShaderCache:programForKey(shadeName)
	if shader then 
		shader:use()
		local location = shader:getUniformLocationForName(uniformName)
		shader:setUniformLocationWith3f(location, ...)
	end
end

function TFShaderManager:setUniform4f(shadeName, uniformName, ...)
	local shader = me.ShaderCache:programForKey(shadeName)
	if shader then 
		shader:use()
		local location = shader:getUniformLocationForName(uniformName)
		shader:setUniformLocationWith4f(location, ...)
	end
end

function TFShaderManager:addShaderWithFilename(szFFilename, szVFilename, szShaderName)
	if szVFilename == nil then
		szVFilename = "TFFramework/shaders/ccShader_TexturePositionColor.vsh"
	end
    if GLProgram then 
        local program = GLProgram:createWithFilenames(szVFilename, szFFilename)
        me.ShaderCache:addGLProgram(program, szShaderName)
        return program
    else 
	    return me.ShaderCache:addProgramWithFilename(szVFilename, szFFilename, szShaderName)
    end
end

function TFShaderManager:addShaderWithContent(szFContent, szVContent, szShaderName)
	if szVContent == nil then
		szVContent = vert
	end
    if GLProgram then 
        local program = GLProgram:createWithByteArrays(szVContent, szFContent)
        me.ShaderCache:addGLProgram(program, szShaderName)
        return program
    else 
	    return me.ShaderCache:addProgramWithShaderContent(szVContent,szFContent,szShaderName)
    end
end

function TFShaderManager:removeAllShader()
	me.ShaderCache:purge()
end

return TFShaderManager:new()