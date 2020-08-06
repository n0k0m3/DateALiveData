me.shader = {
	PositionTextureColor              	= "ShaderPositionTextureColor",
	PositionTextureColorAlphaTest     	= "ShaderPositionTextureColorAlphaTest",
	PositionColor                     	= "ShaderPositionColor",
	PositionTexture                   	= "ShaderPositionTexture",
	PositionTexture_uColor            	= "ShaderPositionTexture_uColor",
	PositionTextureA8Color            	= "ShaderPositionTextureA8Color",
	Position_uColor                   	= "ShaderPosition_uColor",
	PositionLengthTexureColor         	= "ShaderPositionLengthTextureColor",
	ControlSwitch                     	= "Shader_ControlSwitch",
	Gray								= "GrayShader",
	HighLight							= "HighLight",
	OutLine								= "OutLine",
	Mix_uColor							= "Mix_uColor",
}

--[[

color=xy其中x（前景色）和y（背景色）分别可以取以下几种值：   
0 = 黑色       8 = 灰色
1 = 蓝色       9 = 淡蓝色
2 = 绿色       A = 淡绿色
3 = 浅绿色     B = 淡浅绿色
4 = 红色       C = 淡红色
5 = 紫色       D = 淡紫色
6 = 黄色       E = 淡黄色
7 = 白色       F = 亮白色

--]]
ConsoleColor = 
{
    forg = 
    {
        r = 0x4,
        g = 0x2,
        b = 0x1,
        l = 0x8,
        lr = 0xC,
        lg = 0xA,
        lb = 0x9,
        yellow = 0x6,   -- 黄色
        buff = 0xE,     -- 浅黄色
        ll = 0xB,
        p = 0x5,
        lavender = 0xD, -- 淡紫色
    },
    back = 
    {
        r = 0x40,
        g = 0x20,
        b = 0x10,
        l = 0x80,
        lr = 0xC0,
        lg = 0xA0,
        lb = 0x90,
    },
    none = 0,
}

function SetConcoleTextColor(r, g, b, br, bg, bb)
    r = r or ConsoleColor.forg.r
    g = g or ConsoleColor.forg.g
    b = b or ConsoleColor.forg.b
    br = br or 0 --ConsoleColor.back.r
    bg = bg or 0 --ConsoleColor.back.g
    bb = bb or 0 --ConsoleColor.back.b

    if SetConcoleTextColorType then 
        SetConcoleTextColorType(r, g, b, br, bg, bb)
    end
end