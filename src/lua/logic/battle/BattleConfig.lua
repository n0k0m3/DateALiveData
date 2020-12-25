
local BattleConfig = {}
--角色移动音效
BattleConfig.MOVE_EFFECT      ="sound/roleMusic_move.mp3"
--角色飞行音效
BattleConfig.FLY_EFFECT       ="sound/moveFly.mp3"
--强敌来袭音效
BattleConfig.BOSS_WARNING     ="sound/function_007.mp3"

BattleConfig.DEBUG            = false

--角色与空气墙之间的距离
BattleConfig.SPACE_AIRWALL    = 50
-----------------------
BattleConfig.MODAL_SCALE      = 0.6  --战斗中模型的缩放比
BattleConfig.FLIGHT_MODEL_SCALE = 0.36

--是否显示spine动画框
BattleConfig.DEBUG_SLOTS = false
--战斗的进行速度
BattleConfig.DEFAULT_TIMESCALE = 1.0
--战斗最后一击的速度
BattleConfig.MOTION_TIMESCALE = 0.3
--战斗最后一击的特效时间 2秒
BattleConfig.MOTION_TIME = 600
--连击持续时间
BattleConfig.COMBO_TIME = 3000 --毫秒

-- 宽屏情况下需要导出摄像机接口setViewport， 15号之前的包没有此接口， 扩展特效应该关闭
local WSize = me.Director:getOpenGLView():getFrameSize()
local GameSize = me.Director:getWinSize()
DEVICE_WIDE = false
if WSize.width / WSize.height < GameSize.width / GameSize.height then 
    DEVICE_WIDE = true
end

BattleConfig.SHADER_USE_EXT = Camera.setViewport ~= nil and WSize.width >= 1136

BattleConfig.SHADER_BLUR       = false and BattleConfig.SHADER_USE_EXT  --战斗模糊效果开关

BattleConfig.SHADER_BLAST      = false and BattleConfig.SHADER_USE_EXT  --战斗气浪效果开关

BattleConfig.COLLISION_TYPE    = 0  -- 0矩形碰撞 1多变形碰撞

BattleConfig.TO_SETUP_POSE     = false  -- 是否开启角色装配模式

BattleConfig.SHADER_LEVEL = { 0 , 0.3, 0.6, 1}  --特效强度

BattleConfig.SHOW_HITBOX  = false  -- 是否显示角色攻击框
--摇杆是否固定位置
BattleConfig.ROKER_FIX_POSTION = true
--摇杆活动范围
BattleConfig.ROKER_R = 100
--Y方向的速度衰减
BattleConfig.YV_ATTENUATION_RATIO = 0.7
--角色攻击范围
BattleConfig.SHOW_ATK_RECT = false
--摇杆响应区域
BattleConfig.SHOW_ROKE_TOUCH_AREA = false  --是否显示摇杆响应区域
--摇杆方向数
BattleConfig.ROKE_DIR_NUM = 16  --是否显示摇杆响应区域

BattleConfig.SHOW_ATTRS = false  --显示角色属性
--多人同屏的模型最小缩放比例
BattleConfig.MMO_MODAL_SCALE = 0.8 
--Boss状态同步间隔时间
BattleConfig.BOSS_STATE_SYNCHRON_TIME    = 500

if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
	BattleConfig.DAMAGE_TEST                	= true
else
	BattleConfig.DAMAGE_TEST                	= false
end
return BattleConfig
