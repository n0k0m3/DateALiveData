local BaseDataMgr = import(".BaseDataMgr")
local FamilyDataMgr = class("FamilyDataMgr", BaseDataMgr)


function FamilyDataMgr:ctor()
    self:init()
end

function FamilyDataMgr:init()
	self.familyCfg = {}
	self.familyIdList = {}

	for _,_cfg in pairs(TabDataMgr:getData("NewPokedexFamily")) do
		self.familyCfg[_cfg.heroId] = _cfg
        if _cfg.show > 0 then
            table.insert(self.familyIdList, _cfg.heroId)
        end		
	end

    self.waitToDisplayCollects = TFArray:new()
    self.friendFamily = false
end

function FamilyDataMgr:reset()
    self.waitToDisplayCollects:clear()
end

function FamilyDataMgr:getFamilyaListId( )
	-- body
	return self.familyIdList
end

--获取灵装zorder
function FamilyDataMgr:getZorderById( heroid )
	-- body
	local cfg = self.familyCfg[heroid]
	if cfg == nil then return 0 end
	return cfg.sort
end

function FamilyDataMgr:getScale( heroid )
	-- body
	local cfg = self.familyCfg[heroid]
	if cfg == nil then return 1 end
	return cfg.scale
end

function FamilyDataMgr:getPos( heroid )
	-- body
	local cfg = self.familyCfg[heroid]
	if cfg == nil then return 0,0 end
	return cfg.paintPosition.x, cfg.paintPosition.y
end

function FamilyDataMgr:getShow( heroid )
    -- body
    local cfg = self.familyCfg[heroid]
    if cfg == nil then return 0 end
    return cfg.show
end

function FamilyDataMgr:createAnimation( heroid, panel )
	local skinId = HeroDataMgr:getCurSkin(heroid)
    local skinInfo = TabDataMgr:getData("HeroSkin", skinId)
    local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint);
    local model = SkeletonAnimation:create(modelInfo.paint)
    model:setAnimationFps(GameConfig.ANIM_FPS)
    model:playByIndex(0, -1, -1, 1)
    --TODO 临时解决批量渲染的导致spine动画层级错误的问题
    local tt= TFLabel:create()
    tt:setText(" ")
    model:addChild(tt)
    model:setZOrder(self:getZorderById(heroid))

    model:setScale(self:getScale(heroid))
    local posx, posy = self:getPos(heroid)
    model:setPosition(ccp(posx, posy))
    panel:addChild(model)
    if not HeroDataMgr:getIsHave(heroid) then
    	model:setColor(ccc3(80,80,80))
        --屏蔽未解锁精灵放到最后
        --model:setZOrder(model:getZOrder() - 100)
    end
	return model
end

function FamilyDataMgr:showNewPokedexFamilyNode( collects )
    if collects == nil then return end
    if #collects <= 0  then return end

    for _idx,_collect in ipairs(collects) do
        if _collect.element then
            local unLockNum, allNum = CollectDataMgr:getNewPokedexNumInfo(_collect.type)
            for s,t in ipairs(_collect.element) do   
                local info = {id = t.cid, unLockNum = unLockNum, allNum = allNum, index = 0, collectsCount = 0 }                            
                self.waitToDisplayCollects:push(info)
            end
        end
    end

    for _info in self.waitToDisplayCollects:iterator() do
        local index = self.waitToDisplayCollects:indexOf(_info)
        _info.index = index
        _info.collectsCount = self.waitToDisplayCollects:length()
    end

    self:startShowNewPokedexFamilyNode()
end

function FamilyDataMgr:startShowNewPokedexFamilyNode( )
    -- body
    if self.waitToDisplayCollects:length() <= 0 then return end
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
    self.timer = TFDirector:addTimer(5000, -1, nil, function( dt )
        self:update(dt)
    end)
end

function FamilyDataMgr:update( dt )
    local currentScene = Public:currentScene()
    if currentScene == nil then return end
    if currentScene.__cname == "BattleScene" or currentScene.__cname == "LoadScene" then return end
    local layer = currentScene:getTopLayer()
    if layer == nil then return end
    local topname = layer and layer.__cname or ""
    if (topname == "SummonResultView" or topname ==  "SummonGetEquipmentView" or  topname ==  "NewPokedexFamilyTipLayer") then return false end
    local collectInfo = self.waitToDisplayCollects:popFront()
    if collectInfo == nil then return false end
    local newPokedexFamilyTipLayer = layer:getChildByName("newPokedexFamilyTipLayer")
    if newPokedexFamilyTipLayer then newPokedexFamilyTipLayer:removeFromParent() end
    if not newPokedexFamilyTipLayer then
        newPokedexFamilyTipLayer = require("lua.logic.common.NewPokedexFamilyTipLayer"):new(collectInfo)
        newPokedexFamilyTipLayer:setName("newPokedexFamilyTipLayer")
        layer:addChild(newPokedexFamilyTipLayer)
        self.showingLayer = newPokedexFamilyTipLayer
        local anchor = layer:getAnchorPoint()
        newPokedexFamilyTipLayer:setPosition(ccp((0-anchor.x)*layer:getSize().width,(0-anchor.y)*layer:getSize().height))
        newPokedexFamilyTipLayer:setZOrder(999)
        local action = Sequence:create({
                DelayTime:create(3.2),
                RemoveSelf:create(),
            })
        newPokedexFamilyTipLayer:runAction(action)
    end

    if self.waitToDisplayCollects:length() <= 0 then
        if self.timer then
            TFDirector:removeTimer(self.timer)
        end
        self.timer = nil
    end
end

function FamilyDataMgr:openFamilyMainLayer( )
    -- body
    Utils:openView("collect.CollectFamilyLayer")
end

function FamilyDataMgr:getWaitToDisplayCollects( )
    -- body
    return self.waitToDisplayCollects
end

function FamilyDataMgr:clearWaitToDisplayCollects( )
    -- body
    self.waitToDisplayCollects = {}
end

function FamilyDataMgr:setIsFriendFamily( isFriend )
    -- body
    self.friendFamily = isFriend
end

function FamilyDataMgr:getIsFriendFamily( )
    -- body
    return self.friendFamily
end


return FamilyDataMgr:new()