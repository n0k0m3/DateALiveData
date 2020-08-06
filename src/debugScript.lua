
local MODEL_HARU_DIR			= "live2d/haru/"
local MODEL_SHIZUKU_DIR			= "live2d/shizuku/"
local MODEL_WANKO_DIR       	= "live2d/wanko/"
local MODEL_SHILIXIANG_DIR      = "live2d/shilixiang/"

local MODEL_HARU				= "haru.model.json"
local MODEL_HARU_A				= "haru_01.model.json"
local MODEL_HARU_B				= "haru_02.model.json"
local MODEL_SHIZUKU				= "shizuku.model.json"
local MODEL_WANKO       		= "wanko.model.json"
local MODEL_SHILIXIANG 			= "shixiang.model.json"

local MOTION_GROUP_IDLE			="idle"
local MOTION_GROUP_TAP_BODY		="tap_body"

local HIT_AREA_NAME_HEAD		="head"
local HIT_AREA_NAME_BODY		="body"

local PRIORITY_NONE  			= 0
local PRIORITY_IDLE  			= 1
local PRIORITY_NORMAL			= 2
local PRIORITY_FORCE 			= 3


local scene = me.Director:getRunningScene()

scene:removeChildByTag(909, true)
scene:removeChildByTag(910, true)


if me.platform == "win32" then
	if gmView then
        AlertManager:closeLayer(gmView)
		gmView = nil
	end
	gmView = requireNew("lua.logic.test.GMView"):new()
	AlertManager:addLayer(gmView)
	AlertManager:show()
end

-- local live2d = TFLive2D:create()
-- live2d:add(MODEL_SHILIXIANG_DIR, MODEL_SHILIXIANG);

-- live2d:setPosition(ccp(300, 0))
-- live2d:setScale(0.5)
-- live2d:setTag(909)

-- live2d:addMEListener(TFLIVE2D_TAP, function(sender, idx, x, y)
-- 	if sender:checkHit(idx, HIT_AREA_NAME_HEAD, x, y) then 
-- 		sender:setRandomExpression(idx)
-- 	elseif sender:checkHit(idx, HIT_AREA_NAME_BODY, x, y) then 
-- 		sender:startRandomMotion(idx, MOTION_GROUP_TAP_BODY, PRIORITY_NORMAL)
-- 	end
-- end)

-- -- local node = CCNode:create():Size(me.Director:getWinSize())
-- -- live2d:setTag(910)
-- -- node:OnBegan(function(sender, pos)
-- -- 	live2d:handleTouchBegan(pos.x, pos.y)
-- -- end)
-- -- node:OnMoved(function(sender, pos)
-- -- 	live2d:handleTouchMoved(pos.x, pos.y)
-- -- end)
-- -- node:OnEnded(function(sender, pos)
-- -- 	live2d:handleTouchEnded(pos.x, pos.y)
-- -- end)

--  scene:addChild(live2d, 9999999)
--scene:addChild(node, 9999999)

-- local label = TFRichText:create(ccs(300, 300))
-- label:setText("°¢ÈøµÂÈöµ©Èöµ©Èöµ©Èöµ©Èöµ©Èöµ©Èöµ¹Èøµ¹ÈøµÄÊÇ")
-- scene:addChild(label, 9999999)


-- me.ArmatureDataManager:removeUnusedArmatureInfo()


-- TFLuaTime:b()

-- TFResourceHelper:instance():addArmatureFromJsonFile("armature/10315.xml")

-- TFLuaTime:e("Armature:")

--spine测试
-- local function testSpine(resPath ,action)
--     scene:removeChildByTag(99999,true)
--     resPath = resPath or  "effects_11301_1_skillC"
--     action  = action or "luobo"
-- 	local skeletonAnimation = SkeletonAnimation:create(string.format("effect/%s/%s",resPath,resPath))
-- 	scene:addChild(skeletonAnimation)
-- 	skeletonAnimation:setScale(1)
-- 	skeletonAnimation:play(action, 1)
-- 	skeletonAnimation:setPosition(ccp(300,300))
-- 	skeletonAnimation:setTag(99999)
-- end

-- testSpine()