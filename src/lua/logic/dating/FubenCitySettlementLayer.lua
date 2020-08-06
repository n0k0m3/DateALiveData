local FubenCitySettlementLayer = class("FubenCitySettlementLayer",BaseLayer)
local ElvesNpcTable = require("lua.logic.common.ElvesNpc")

function FubenCitySettlementLayer:initData(data)
    self.data_ = data
    self.curScript = DatingDataMgr:getCurDatingScript()
    self.roleId = DatingDataMgr:getDatingRuleRoleId(self.curScript.datingRuleCid) or RoleDataMgr:getCurId()
    self.pathName = data.pathName

    self.trueType = EC_DatingScriptType.SHOW_SCRIPT
    if self.curScript.datingType and self.curScript.datingType == EC_DatingScriptType.FUBEN_CITY_SCRIPT then
        self.trueType = self.curScript.datingType
    end
    DatingDataMgr:clearDatingSettlementMsg()
    GuideDataMgr:setCurPassLevel(FubenDataMgr:getCurLevelCid())
end

function FubenCitySettlementLayer:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)
    self:init("lua.uiconfig.dating.fubenCitySettlementLayer")
end

function FubenCitySettlementLayer:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Image_bg = TFDirector:getChildByPath(self.ui,"Image_bg")
    self.Image_bg:setTexture(self.pathName)

    self.Panel_public = TFDirector:getChildByPath(self.ui,"Panel_public")
    self.Panel_fuben = TFDirector:getChildByPath(self.ui,"Panel_fuben")

    self.Panel_touch = TFDirector:getChildByPath(self.ui,"Panel_touch")

    self:initLeft()
    self:initRight()
    -- self:playShader(0.0001,0.0002)

    local Image_1 = TFDirector:getChildByPath(self.ui, "Image_1")
    local Image_2 = TFDirector:getChildByPath(self.ui, "Image_2")
    local Image_endIcon = TFDirector:getChildByPath(self.ui, "Image_endIcon")
    local Image_endX = TFDirector:getChildByPath(self.ui, "Image_endX")

    ViewAnimationHelper.doMoveFadeInAction(Image_1, {direction = 2, distance = 350, adjust = 30, time = 0.15, ease = 2})
    ViewAnimationHelper.doMoveFadeInAction(Image_2, {direction = 1, distance = 300, adjust = 20, time = 0.15, ease = 2})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_fuben, {direction = 2, distance = 50, time = 0.2, delay = 0.15, ease = 1})
    ViewAnimationHelper.doScaleFadeInAction(Image_endIcon, {upscale = 1.2, uptime = 0.03, downtime = 0.05, delay = 0.35})
    ViewAnimationHelper.doScaleFadeInAction(Image_endX, {upscale = 1.2, uptime = 0.03, downtime = 0.05, delay = 0.35})
    self.elvesNpc:playMoveRightIn(0.3)
end

function FubenCitySettlementLayer:initLeft()
    self:initRole()
end

function FubenCitySettlementLayer:initRole()
    local speAcData = TabDataMgr:getData("SpecialAction")
    local speData = speAcData[self.roleId]
    local acName = ""
    local novelCfg = NewCityDataMgr:getCurFubenCityNovelCfg()
    if novelCfg then
        if novelCfg.endVoice and string.len(novelCfg.endVoice) > 0 then
            self.voiceHandle = TFAudio.playSound(novelCfg.endVoice)
        else
            self.voiceHandle = TFAudio.playSound("sound/ui/function_018.mp3")
        end
        self.modelId = novelCfg.modelId
        acName = novelCfg.endAction
    else
        self.modelId = RoleDataMgr:getModel(self.roleId)
    end
    
    self.Image_npc = TFDirector:getChildByPath(self.ui,"Image_npc")
    print("self.modelId ",self.modelId)
    self.elvesNpc = ElvesNpcTable:createLive2dNpcID(self.modelId,false,false).live2d
    self.elvesNpc:setScale(self.elvesNpc.defaultScale)
    self.elvesNpc:newStartAction(acName,EC_PRIORITY.FORCE)
    local scale = self.elvesNpc.type == 1 and 0.7 or 0.5
    self.elvesNpc:setScale(scale)
    self.Image_npc:getParent():addChild(self.elvesNpc)
    self.elvesNpc:setZOrder(self.Image_npc:getZOrder())
    local pos = self.Image_npc:getPosition() - ccp(-30,self.Image_npc:getSize().height/2 - 50)
    self.elvesNpc:setPosition(pos)
    self.Image_npc:setVisible(false)
end

function FubenCitySettlementLayer:initRight()
    self:initFubenUI()
end

function FubenCitySettlementLayer:initFubenUI()
    local Label_fuben_favor_level = TFDirector:getChildByPath(self.Panel_fuben,"Label_fuben_favor_level")
    local LoadingBar_fuben_favor = TFDirector:getChildByPath(self.Panel_fuben,"LoadingBar_fuben_favor")
    local Label_fuben_barFavorValue = TFDirector:getChildByPath(self.Panel_fuben,"Label_fuben_barFavorValue")
    local ScrollView_fuben_cg = TFDirector:getChildByPath(self.Panel_fuben,"ScrollView_fuben_cg")
    local Label_fuben_good_tiele = TFDirector:getChildByPath(self.Panel_fuben,"Label_fuben_good_tiele")
    local Image_head = TFDirector:getChildByPath(self.Panel_fuben,"Image_head")
    local Label_hero_name = TFDirector:getChildByPath(self.Panel_fuben,"Label_hero_name")
    local Label_hero_level = TFDirector:getChildByPath(self.Panel_fuben,"Label_hero_level")
    local LoadingBar_hero_exp = TFDirector:getChildByPath(self.Panel_fuben,"LoadingBar_hero_exp")
    local Label_exp_percent = TFDirector:getChildByPath(self.Panel_fuben,"Label_exp_percent")

    local Panel_left = TFDirector:getChildByPath(self.ui, "Panel_left"):show()
    local Image_endIcon = TFDirector:getChildByPath(self.ui,"Image_endIcon"):show()
    Image_endIcon:setTexture("ui/newCity/reward/020.png")

    Label_fuben_favor_level:setText("Lv."..RoleDataMgr:getFavorLevel(self.roleId))
    local curFavor = RoleDataMgr:getFavor(self.roleId)
    local maxFavor = RoleDataMgr:getCurLvMaxFavor(self.roleId)
    local percent = curFavor / maxFavor * 100
    local sMsg = DatingDataMgr:getDatingSettlementMsg()
    local addFavor = 0
    if sMsg and sMsg.rewards then
        for k,v in pairs(sMsg.rewards) do
            if v.id == EC_SItemType.CURFAVOR then
                addFavor = addFavor + v.num
            end
        end
    end
    if addFavor > 0 then
        Label_fuben_barFavorValue:setText(math.max((curFavor - addFavor), 0).."(+"..addFavor..") /"..maxFavor)
    else
        Label_fuben_barFavorValue:setText(curFavor.." /"..maxFavor)
    end

    local headPath = AvatarDataMgr:getSelfAvatarIconPath()
    Image_head:setTexture(headPath)
    Label_hero_name:setText(MainPlayer:getPlayerName())

    local expPercent = MainPlayer:getExpProgress()
    local lv = MainPlayer:getPlayerLv()
    Label_hero_level:setText("Lv."..lv)
    local curExp = MainPlayer:getPlayerExp()
    local curLevelMaxExp = TabDataMgr:getData("LevelUp",lv).playerExp
    if curLevelMaxExp <= 0 then
        Label_exp_percent:setString("MAX")
    else
        Label_exp_percent:setString(curExp .."/".. curLevelMaxExp)
    end    
    LoadingBar_fuben_favor:setPercent(addFavor > 0 and 0 or percent)
    LoadingBar_hero_exp:setPercent(expPercent)
    if addFavor > 0 then
        self:timeOut(function()
            Utils:loadingBarAddAction(LoadingBar_fuben_favor, percent)
        end, 0.5)
    end
    self:initFubenGift()
end

function FubenCitySettlementLayer:initFubenGift()
    local ScrollView_fuben_cg = TFDirector:getChildByPath(self.Panel_fuben,"ScrollView_fuben_cg")
    local Panel_giftItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_giftItem:Scale(0.8)

    self.ScrollView_fuben_cg = UIListView:create(ScrollView_fuben_cg)
    self.ScrollView_fuben_cg:setItemsMargin(2)

    local gifts_ = self.data_.finalReward
    for i,v in ipairs(gifts_) do
        if v.id ~= EC_SItemType.PLAYEREXP 
            and v.id ~= EC_SItemType.SPIRITEXP 
            and v.id ~= EC_SItemType.CURFAVOR
            and v.id ~= EC_SItemType.FAVOR
            and v.id ~= EC_SItemType.CURMOOD then
            local cgItem = Panel_giftItem:clone()
            cgItem:Scale(0.8)
            item = cgItem
            PrefabDataMgr:setInfo(cgItem,v.id,v.num)
            self.ScrollView_fuben_cg:pushBackCustomItem(cgItem)
        end
    end
end

function FubenCitySettlementLayer:playShader(widthOffset,heightOffset)
    self.Image_bg:setShaderProgram("Blur", true)
    local _GLProgramState = self.Image_bg:getGLProgramState()
    _GLProgramState:setUniformFloat("texelWidthOffset", widthOffset)
    _GLProgramState:setUniformFloat("texelHeightOffset", heightOffset)
end

function FubenCitySettlementLayer:registerEvents()
    self.enableTouching = false
    self:timeOut(function()
        self.enableTouching = true
    end, 2)

    self.panelTouchFunc = function(sender)
        if self.enableTouching then
            if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_FuBen then
                FubenDataMgr:send_DUNGEON_FIGHT_OVER(FubenDataMgr:getCurLevelCid(), true, {1}, 1, 1, 1)
            end
            if not GuideDataMgr:isInNewGuide() then
                AlertManager:closeLayer(self)
            end
        end
    end

    self.Panel_touch:onClick(self.panelTouchFunc)
end

function FubenCitySettlementLayer:onClose()
    self.super.onClose(self)
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
end

function FubenCitySettlementLayer:specialKeyBackLogic( )
    self:panelTouchFunc()
    return true
end

return FubenCitySettlementLayer
