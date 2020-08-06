--[[
    固定配置

    --By: haidong.gan
    --2013/11/11
]]
local GameConfig = {}

if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
	GameConfig.FPS                	= 60;	--游戏帧率
else
	GameConfig.FPS                	= 60;	--游戏帧率
end

if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
	GameConfig.ANIM_FPS             = 60; 	--动作帧率
else
	GameConfig.ANIM_FPS             = 60; 	--动作帧率
end
GameConfig.FONT_TYPE                = "Arial";                                    --默认字体
GameConfig.WS                       = CCDirector:sharedDirector():getWinSize();   --窗口大小
GameConfig.COMMON_IMAGE_SIZE	    = CCSize(314,493);                            --卡牌大小
GameConfig.COMMON_ICON_SIZE	        = CCSize(100,100);                            --卡牌头像大小

GameConfig.DESIGN_SIZE = CCSize(1386, 640)

GameConfig.FAIL	                    = 0;                          --失败
GameConfig.SUCCUSS	                = 1;                          --成功

GameConfig.Normal_Fight_Speed 		= 1.2
GameConfig.Max_Fight_Speed 			= 1.7

GameConfig.Normal_Time_Scale 		= 1
GameConfig.Double_Time_Scale		= 1.2

if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
		GameConfig.game_font = "fangzheng_zhunyuan"

elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
	GameConfig.game_font = "fonts/ttf/fangzheng_zhunyuan.ttf"

elseif CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
	GameConfig.game_font = "fangzheng_zhunyuan"
end

-- 是否开发版本
GameConfig.Debug = VERSION_DEBUG

return GameConfig;

