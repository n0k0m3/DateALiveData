local FavorUpgradeLayer = class("FavorUpgradeLayer",BaseLayer)

local speAcData = TabDataMgr:getData("SpecialAction")

function FavorUpgradeLayer:initData(data)
    --self.lastFavor = TextDataMgr:getText(EC_FavorType[data.lastLevel])
    --self.newFavor = TextDataMgr:getText(EC_FavorType[data.newLevel])
    --self.nextFavor = TextDataMgr:getText(EC_FavorType[data.newLevel + 1])

    self.lastFavor = data.lastLevel
    self.newFavor = data.newLevel
    self.nextFavor = data.newLevel + 1

    self.newLevel = data.newLevel
    self.maxFavorLv = RoleDataMgr:getFavorMaxLv(RoleDataMgr:getCurId())
    self.live2dUnlock = RoleDataMgr:getRoleInfo(RoleDataMgr:getCurId()).live2dUnlock
    self.voiceUnlock = RoleDataMgr:getRoleInfo(RoleDataMgr:getCurId()).voiceUnlock
    self.mainlineUnlock = RoleDataMgr:getRoleInfo(RoleDataMgr:getCurId()).mainlineUnlock
end

function FavorUpgradeLayer:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)
    self:init("lua.uiconfig.dating.favorUpgradeLayer")
    --TFAudio:stopAllEffects()
    VoiceDataMgr:playVoice("favor_up",RoleDataMgr:getCurId())
end

function FavorUpgradeLayer:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui,"Button_close")

    self.Panel_favorPro = TFDirector:getChildByPath(self.ui, "Panel_favorPro")
    self.Panel_favorPro.saveSize = self.Panel_favorPro:Size()
    self.Panel_favorPro:Size(CCSize(0,200))

    self.Image_favorLevelIcon1 = TFDirector:getChildByPath(self.ui, "Image_favorLevelIcon1")
    self.Image_favorLevelIcon1.laLv = TFDirector:getChildByPath(self.Image_favorLevelIcon1, "Label_lv")
    self.Image_favorLevelIcon2 = TFDirector:getChildByPath(self.ui, "Image_favorLevelIcon2")
    self.Image_favorLevelIcon2.laLv = TFDirector:getChildByPath(self.Image_favorLevelIcon2, "Label_lv")
    self.Image_favorLevelIcon3 = TFDirector:getChildByPath(self.ui, "Image_favorLevelIcon3")
    self.Image_favorLevelIcon3.laLv = TFDirector:getChildByPath(self.Image_favorLevelIcon3, "Label_lv")
    self.Image_favorLevelIcon1.laLv:setString("Lv." ..self.lastFavor)
    self.Image_favorLevelIcon2.laLv:setString("Lv." .. self.newFavor)
    if self.newFavor >= self.maxFavorLv then
        self.Image_favorLevelIcon3:hide()
    else
        self.Image_favorLevelIcon3.laLv:setString("Lv." .. self.nextFavor)
    end

    --self:initText()
    self:initElvesNpc()
    --self:initPanelFavorPro()

    self:playAction()
    self:initInfo()
end

function FavorUpgradeLayer:initInfo()
    for i = 1, 3 do
        local Image_info = TFDirector:getChildByPath(self.ui, "Image_info"..i)
        local laLv = TFDirector:getChildByPath(Image_info, "Label_lv")
        if i == 1 then
            if self.voiceUnlock and self.voiceUnlock[self.newLevel] and self.voiceUnlock[self.newLevel] ~= 0 then
                laLv:setTextById(self.voiceUnlock[self.newLevel])
            else
                Image_info:hide()
            end
        end
        if i == 2 then
            if self.live2dUnlock and self.live2dUnlock[self.newLevel] and self.live2dUnlock[self.newLevel] ~= 0 then
                laLv:setTextById(self.live2dUnlock[self.newLevel])
            else
                Image_info:hide()
            end
        end
--        if i == 3 then
--            if self.mainlineUnlock and self.mainlineUnlock[self.newLevel] and self.mainlineUnlock[self.newLevel] ~= 0 then
--                laLv:setTextById(self.mainlineUnlock[self.newLevel])
--            else
--                Image_info:hide()
--            end
--        end
        --屏蔽好感度约会item 英文版同步韩服好感度约会屏蔽
        if i == 3 then
            Image_info:hide()
        end
    end
end


function FavorUpgradeLayer:initPanelFavorPro()
    self.Panel_favorProRoot = TFDirector:getChildByPath(self.ui, "Panel_favorProRoot")
    self.LoadingBar_favorPro = TFDirector:getChildByPath(self.ui, "LoadingBar_favorPro")
    self.LoadingBar_favorPro:setPercent(0)

    self.Image_favorLevelIcon1 = TFDirector:getChildByPath(self.ui, "Image_favorLevelIcon1")
    self.Image_favorLevelIcon2 = TFDirector:getChildByPath(self.ui, "Image_favorLevelIcon2")
    self.Image_favorLevelIcon3 = TFDirector:getChildByPath(self.ui, "Image_favorLevelIcon3")

    self.Image_favorLevelIcon1:setOpacity(0)
    self.Image_favorLevelIcon2:setOpacity(0)
    self.Image_favorLevelIcon3:setOpacity(0)

    local ac = {
        CCCallFunc:create(function()
            Utils:loadingBarAddAction(self.LoadingBar_favorPro, 30,
                    function()
                        return nil
                    end,
                    function()

                    end,
                    function()
                    end
            )
        end),
        CCCallFunc:create(function()
            self.Image_favorLevelIcon1:fadeIn(0.3)
        end),
        CCDelayTime:create(0.3),
        CCCallFunc:create(function()
            self.Panel_favorProRoot:moveBy(0.3,ccp(-200,0))
            self.Image_favorLevelIcon2:fadeIn(0.3)
            self.Image_favorLevelIcon3:fadeIn(0.3)
        end),
        CCDelayTime:create(2),
    }

    self.LoadingBar_favorPro:runAction(CCSequence:create(ac))
end

function FavorUpgradeLayer:initText()
    self.Label_lastFavor = TFDirector:getChildByPath(self.ui,"Label_lastFavor")
    self.Label_newFavor = TFDirector:getChildByPath(self.ui,"Label_newFavor")
    self.Label_lastFavor:setString(self.lastFavor)
    self.Label_lastFavor:setZOrder(101)
    self.Label_newFavor:setString(self.newFavor)
    self.Label_newFavor:setZOrder(101)
end

function FavorUpgradeLayer:initElvesNpc()
    --local roleId = RoleDataMgr:getModel(RoleDataMgr:getCurId())
    local dressTable = TabDataMgr:getData("Dress")
    local data = dressTable[RoleDataMgr:getRoleInfo(RoleDataMgr:getCurId()).correctRoleModel]

    local roleId = data.roleModel --暂时调整为默认模型（避免新出的模型没有升级动画）
    self.Panel_npc = TFDirector:getChildByPath(self.ui, "Panel_npc")
    self.imageNpc = TFDirector:getChildByPath(self.Panel_npc,"Image_npc")
    self.elvesNpc = ElvesNpcTable:createLive2dNpcID(roleId).live2d
    --self.elvesNpc:setScale(self.elvesNpc.defaultScale * 0.7/0.6)
    self.elvesNpc:setScale(self.elvesNpc.defaultScale*1.8)
    self.elvesNpc.saveScale = self.elvesNpc:getScale()
    self.elvesNpc:registerEvents()

    self.Panel_npc:addChild(self.elvesNpc)
    self.elvesNpc:setZOrder(80)

    self.elvesNpc.savePos = self.imageNpc:getPosition() - ccp(0,100)
    self.elvesNpc:setPosition(self.elvesNpc.savePos)

    self.imageNpc:setVisible(false)

    --self.elvesNpc:setVisible(false)

    self.speData = clone(speAcData[RoleDataMgr:getCurId()])
    if not self.speData then
        return
    end
    local upgradeName = self.speData["upgrade"].action
    -- local time = self.speData["upgrade"].actionTime
    self.elvesNpc:newStartAction(upgradeName,EC_PRIORITY.FORCE)
end

function FavorUpgradeLayer:playAction()
    --self.ui:timeOut(function()
    --    self.elvesNpc:playIn(0.1)
    --    end,0.1)
    self.proWidth = 0
    self.timer_ = TFDirector:addTimer(10, -1, nil, handler(self.updateSize, self))

    self.ui:runAnimation("Action0",1)
end

function FavorUpgradeLayer:updateSize(dt)
    self.proWidth = self.proWidth + 20
    if self.proWidth >= 700 then
        self.proWidth = 700
    end
    print("self.proWidth ",self.proWidth)
    self.Panel_favorPro:Size(self.proWidth,self.Panel_favorPro.saveSize.height)
    if self.proWidth == 700 then
        self:stopTimer()
    end
end

function FavorUpgradeLayer:stopTimer()
    if self.timer_ then
        TFDirector:removeTimer(self.timer_)
        self.timer_ = nil
    end
end

function FavorUpgradeLayer:onClose()
    self.super.onClose(self)
    self:stopTimer()
    EventMgr:dispatchEvent(EV_DATING_EVENT.refreshFavorLevel,self.newLevel)
end

function FavorUpgradeLayer:onShow()
    self.super.onShow(self)
end

function FavorUpgradeLayer:registerEvents()
    self.Button_close:onClick(
        function()
            AlertManager:close()
        end,
        EC_BTN.BACK)
end


return FavorUpgradeLayer;
