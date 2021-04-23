--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 
]]
local EnhuiSquadView = class("EnhuiSquadView",BaseLayer)

function EnhuiSquadView:ctor( groupId, levelId )
	-- body
	self.super.ctor(self)
    self.name = "EnhuiSquadView"
    self.groupId = groupId
    self.levelId = levelId
    self.formationData_ = {}
    self.curSelectIdx = 1
    self.linkageHeros = FubenDataMgr:getLinkAgeHeros()

    for k,v in pairs(self.linkageHeros) do
        local heroData = HeroDataMgr:getHero(v.heroId)
        self.formationData_[v.index] = heroData
    end

    for i = 1,3 do
        if self.formationData_[i] and not FubenDataMgr:checkSitIsLock(self.groupId,i) then
            self.curSelectIdx = i
            break
        end
    end
   
    self:init("lua.uiconfig.activity.enhuiSquadView")
end

function EnhuiSquadView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
    self.Panel_formation = TFDirector:getChildByPath(ui, "Panel_formation")
    self.Panel_enhui = TFDirector:getChildByPath(ui, "Panel_enhui")

    self.Button_ready = TFDirector:getChildByPath(ui,"Button_ready")
    self.Label_value = TFDirector:getChildByPath(ui,"Label_value")
    self.Label_cost = TFDirector:getChildByPath(ui,"Label_cost")
    self.Image_cost = TFDirector:getChildByPath(ui,"Image_cost")
    self.Image_costIcon = TFDirector:getChildByPath(ui,"Image_costIcon")

	self.Label_Lv = TFDirector:getChildByPath(self.Panel_enhui,"Label_Lv")
	self.Panel_attrItem = TFDirector:getChildByPath(ui,"Panel_attrItem")

	self.LoadingBar_progress = TFDirector:getChildByPath(self.Panel_enhui,"LoadingBar_progress")
	self.Label_progress = TFDirector:getChildByPath(self.Panel_enhui,"Label_progress")

	local ScrollView_attr = TFDirector:getChildByPath(self.Panel_enhui,"ScrollView_attr")
	self.uiList_attr = UIListView:create(ScrollView_attr)

    self.Panel_member = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_formation, "Panel_memeber_" .. i)
        item.Panel_role = TFDirector:getChildByPath(item.root, "Panel_role"):hide()
        item.Button_head = TFDirector:getChildByPath(item.root, "Button_head")
        item.Panel_model = TFDirector:getChildByPath(item.Panel_role, "Panel_model")
        item.Image_captain = TFDirector:getChildByPath(item.Panel_role, "Image_captain")
        item.Label_name = TFDirector:getChildByPath(item.Panel_role, "Label_name")
        item.Image_limit_type = TFDirector:getChildByPath(item.Panel_role, "Image_limit_type")
        item.Label_limit_type = TFDirector:getChildByPath(item.Image_limit_type, "Label_limit_type")
        item.Image_disable_type = TFDirector:getChildByPath(item.Panel_role, "Image_disable_type")
        item.Label_disable_type = TFDirector:getChildByPath(item.Image_disable_type, "Label_disable_type")
        item.Image_try_type = TFDirector:getChildByPath(item.root, "Image_try_type")
        item.Label_try_type = TFDirector:getChildByPath(item.Image_try_type, "Label_try_type")
        item.Panel_add = TFDirector:getChildByPath(item.root, "Panel_add"):hide()
        item.Button_add = TFDirector:getChildByPath(item.Panel_add, "Button_add")
        item.Label_empty = TFDirector:getChildByPath(item.Panel_add, "Label_empty")
        item.Panel_lock = TFDirector:getChildByPath(item.root, "Panel_lock"):hide()
        item.Button_lock = TFDirector:getChildByPath(item.Panel_lock, "Button_lock")
        item.Image_hp = TFDirector:getChildByPath(item.Panel_role, "Image_hp"):hide()
        item.Label_hp = TFDirector:getChildByPath(item.Image_hp, "Label_hp")
        item.LoadingBar_hp_progress = TFDirector:getChildByPath(item.Image_hp, "Image_hp_progress.LoadingBar_hp_progress")
        item.Label_hp_percent = TFDirector:getChildByPath(item.Image_hp, "Label_hp_percent")
        item.Image_endless_dead = TFDirector:getChildByPath(item.Panel_role, "Image_endless_dead"):hide()
        item.Label_endless_dead = TFDirector:getChildByPath(item.Image_endless_dead, "Label_endless_dead")
        item.Label_endless_dead:setTextById(310018)
        item.Image_skayladder = TFDirector:getChildByPath(item.Panel_role, "Image_skayladder"):hide()
        item.Label_remain_cnt = TFDirector:getChildByPath(item.Image_skayladder, "Label_remain_cnt")
        item.Button_check = TFDirector:getChildByPath(item.Image_skayladder, "Button_check")
        item.Panel_mojin_coin = TFDirector:getChildByPath(item.Panel_role, "Panel_mojin_coin"):hide()
        item.Panel_hwx_tip = TFDirector:getChildByPath(item.Panel_role, "Panel_hwx_tip"):hide()
        item.Panel_ksan_coin = TFDirector:getChildByPath(item.Panel_role, "Panel_ksan_coin"):hide()
        item.Image_select = TFDirector:getChildByPath(item.root, "Image_select"):hide()
        item.Panel_dark = TFDirector:getChildByPath(item.root, "Panel_dark"):hide()

        if self.fubenType_ == EC_FBType.KSAN_FUBEN then
            item.Button_add:setTextureNormal("ui/activity/kuangsan_fuben/fightReady/006.png")
        end
        self.Panel_member[i] = item
    end

    local levelCfg = FubenDataMgr:getLevelCfg(self.levelId)
    self.levelCfg_ = levelCfg_
    local cost = levelCfg.cost[1]
    if cost then
        self.Image_cost:show()
        local costItemCfg = GoodsDataMgr:getItemCfg(cost[1])
        self.Image_costIcon:setTexture(costItemCfg.icon)
        self.Label_cost:setText(cost[2])
    else
        self.Image_cost:hide()
    end

    self:updateFormation()
    self:updatePanelEnhui()
end

function EnhuiSquadView:registerEvents( ... )
    -- body
    self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_LINKAGE_HERO_UPDATE, function ( ... )
        -- body
        self.linkageHeros = FubenDataMgr:getLinkAgeHeros()

        for k,v in pairs(self.linkageHeros) do
            local heroData = HeroDataMgr:getHero(v.heroId)
            self.formationData_[v.index] = heroData
        end

        self:updateFormation()
        self:updatePanelEnhui()
    end)
    self.Button_ready:onClick(handler(self.onFightingClick,self))
end

function EnhuiSquadView:onFightingClick()
    if self.levelCfg_ then
        local isCanFighting = true
        local cost = self.levelCfg_.cost[1]
        if cost then
            isCanFighting = GoodsDataMgr:currencyIsEnough(cost[1], cost[2] * 1)
        end
        if not isCanFighting then
            local goodsCfg = GoodsDataMgr:getItemCfg(cost[1])
            local name = TextDataMgr:getText(goodsCfg.nameTextId)
            Utils:showTips(2100034, name)
            return
        end

        local enabled = true
        if table.indexOf(self.levelCfg_.heroForbiddenID, self.formationData_[self.curSelectIdx].cid) ~= -1 then
            enabled = false
        end
        if not enabled then
            Utils:showTips(2100035)
        end
    end

    if not self.formationData_[self.curSelectIdx] then
        Utils:showTips(16000586)
        return
    end

    for k,v in pairs(self.linkageHeros) do
        if v.index == self.curSelectIdx then
            if not FubenDataMgr:isUnlockGraceLevel(v.level) then -- 伟业等级未解锁不能进行战斗
                if FubenDataMgr:getGraceMaxExp(v.level) == 1 then -- 等级以到上限
                    Utils:showTips(16000644)
                else
                    Utils:showTips(16000502)
                end
                return
            end
        end
    end

    local heros = {}
    table.insert(heros, {1, self.formationData_[self.curSelectIdx].id})
    

    local battleController = require("lua.logic.battle.BattleController")
    
    battleController.requestFightStart(self.levelId, 0, 0, heros, 0, false)
end

function EnhuiSquadView:updatePanelEnhui( ... )
	-- body
    
    local attrs = {}
    for k,v in pairs(self.linkageHeros) do
        if v.index == self.curSelectIdx then
            attrs = FubenDataMgr:getLinkAgeHeroAttrs(v)
            self.selectLinkageHero = v
        end
    end

	for k,v in ipairs(attrs) do
		local item = self.uiList_attr:getItem(k)
        if not item then
            item = self.Panel_attrItem:clone()
            self.uiList_attr:pushBackCustomItem(item)
        end
		self:updateAttrItem(item,v)
	end

    local maxExp = 0
    if self.selectLinkageHero then
        maxExp = FubenDataMgr:getGraceMaxExp(self.selectLinkageHero.level)
        self.LoadingBar_progress:setPercent(self.selectLinkageHero.exp*100/maxExp)
        self.Label_progress:setText(self.selectLinkageHero.exp.."/"..maxExp)
        self.Label_Lv:setText(self.selectLinkageHero.level - 1)
        if maxExp == 1 then
            self.Label_progress:setText("MAX")
        end
    else
        self.LoadingBar_progress:setPercent(0)
        self.Label_progress:setText("0/"..maxExp)
        self.Label_Lv:setText("0")
    end
end

function EnhuiSquadView:updateAttrItem( item, attrData )
	-- body
	local Image_n = TFDirector:getChildByPath(item, "Image_n")
	local Image_desire_bg = TFDirector:getChildByPath(item, "Image_desire_bg")
	local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
	local Label_name = TFDirector:getChildByPath(item, "Label_name")
	local Label_attr = TFDirector:getChildByPath(item, "Label_attr")
	local Image_desire = TFDirector:getChildByPath(item, "Image_desire")

    Image_n:setVisible(self.selectLinkageHero.desire ~= attrData.attributeId)
    Image_desire_bg:setVisible(self.selectLinkageHero.desire == attrData.attributeId)
    Image_desire:setVisible(self.selectLinkageHero.desire == attrData.attributeId)

    local attrCfg = HeroDataMgr:getAttributeConfig(attrData.attributeId)
    Image_icon:setTexture(attrCfg.icon)
    Label_name:setTextById(attrCfg.name)
    Label_attr:setText(string.format(attrCfg.displayFormat,attrData.value))

    item:setTouchEnabled(true)
    item:onClick(function ( ... )
        -- body
        local function callFunc( ... )
            if self.selectLinkageHero.desire ~= attrData.attributeId then
                FubenDataMgr:SEND_DUNGEON_REQ_CHANGE_LINK_AGE_DESIRE(attrData.attributeId,self.selectLinkageHero.heroId)
            end
        end

        local args = {
            tittle = 2107025,
            reType = "dicuoDesire",
            content = TextDataMgr:getText(16000505),
            confirmCall = callFunc,
            showCancle = true,
            uiPath = "lua.uiconfig.activity.diCuoReConfirmTipsView",
        }
        Utils:showReConfirm(args)
    end)
end


function EnhuiSquadView:updateFormation()

    for i, v in ipairs(self.Panel_member) do
        local heroData = self.formationData_[i]

        v.Panel_role:setVisible(heroData)
        local isLock = FubenDataMgr:checkSitIsLock(self.groupId,i)
        v.Panel_lock:setVisible(isLock)
        v.Panel_add:setVisible(not v.Panel_role:isVisible())
        v.Image_select:setVisible(self.curSelectIdx == i)

        v.Label_limit_type:setTextById(300016)
        v.Label_try_type:setTextById(300015)
        v.Label_disable_type:setTextById(300017)
        v.Label_empty:setTextById(300018)

        v.Image_limit_type:setVisible(false )
        v.Image_disable_type:setVisible(false)
        v.Image_try_type:setVisible(false)
      
        if heroData then
            local skinData = TabDataMgr:getData("HeroSkin", heroData.skinCid)
            v.Label_name:setTextById(heroData.nameTextId)
            v.Button_head:setTextureNormal(skinData.backdrop)

            local model = Utils:createHeroModel(heroData.id, v.Panel_model, 0.45, heroData.skinCid)
            model:update(0.1)
            model:stop()
        end

 
        v.Panel_mojin_coin:hide()
        v.Panel_hwx_tip:hide()
        v.Panel_ksan_coin:hide()
      
        v.Button_head:onClick(function()
        	if self.curSelectIdx == i then return end
            self.curSelectIdx = i
            self:updateFormation()
            self:updatePanelEnhui()
        end)
        v.Button_add:onClick(function()
            local ingoreHeros = {}
            for k,v in pairs(self.linkageHeros) do
                table.insert(ingoreHeros, v.heroId)
            end
            Utils:openView("liandongChapter.HeroChoiceLayer",function ( heroId )
                -- body
                local function sendMsg( ... )
                    -- body
                    AlertManager:closeLayerByName("HeroChoiceLayer")
                    FubenDataMgr:SEND_DUNGEON_REQ_SET_LINK_AGE_HERO(i,heroId)
                end

                if sitData then
                    local args = {
                        tittle = 2107025,
                        reType = "dicuoDesire",
                        content = TextDataMgr:getText(16000510),
                        confirmCall = sendMsg,
                        showCancle = true,
                        uiPath = "lua.uiconfig.activity.diCuoReConfirmTipsView",
                    }
                    Utils:showReConfirm(args)
                else
                    sendMsg()
                end
            end, ingoreHeros)
        end)

        v.Panel_dark:setVisible(false)

        local lockTipIds = {0,16000503,16000504}
        v.Button_lock:onClick(function()
            Utils:showTips(lockTipIds[i])
        end)

        v.Button_check:onClick(function()
            
        end)
    end
end


return EnhuiSquadView