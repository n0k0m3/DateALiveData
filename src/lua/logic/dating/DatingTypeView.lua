local DatingTypeView = class("DatingTypeView",BaseLayer)

local EC_DatingOption = {
    mainOption = 1,
    dayOption = 2,
    outsideOption = 3,
    giftAndDressOption = 4
}

function DatingTypeView:initData(roleId)
    if roleId then
        RoleDataMgr:setCurId(roleId)
    end
    self.roleId_ = RoleDataMgr:getCurId()
    self.selectOption_ = EC_DatingOption.mainOption
    self.optionList_ = {}
    self.useRoleInfo = clone(RoleDataMgr:getCurRoleInfo())
end

function DatingTypeView:ctor(data)
    self.super.ctor(self)

    self:initData(data)
    self:init("lua.uiconfig.dating.datingTypeView")


    self.voiceHandle = VoiceDataMgr:playVoice("button_dating",RoleDataMgr:getCurId())
end

function DatingTypeView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self:initRole()
    self:initOption()

    self:setBackBtnCallback(function()
            if self.voiceHandle then
                TFAudio.stopEffect(self.voiceHandle)
            end
             if self.closeCallBack then
                 self.closeCallBack()
             end
             AlertManager:closeLayer(self)
        end)
end

function DatingTypeView:initRole()
    local acName = "id4"
    local modelId = RoleDataMgr:getModel(self.roleId_)
    local Image_npc = TFDirector:getChildByPath(self.ui,"Image_npc")
    self.elvesNpc = ElvesNpcTable:createLive2dNpcID(modelId,false,false).live2d

    Image_npc:getParent():addChild(self.elvesNpc)
    self.elvesNpc:setZOrder(Image_npc:getZOrder())
    self.elvesNpc:setScale(0.7)
    local pos = Image_npc:Pos()
    self.elvesNpc:Pos(pos)
    Image_npc:hide()

    self.elvesNpc:hide()
    self.ui:timeOut(function()
        self.elvesNpc:playIn(0.3)
        end,0.2)
end

function DatingTypeView:initOption()
    self.Panel_option = TFDirector:getChildByPath(self.ui,"Panel_option")
    self:initMainOption()
    self:initDayOption()
    self:initoutsideOption()
    self:initGiftAndDressOption()
end

function DatingTypeView:initMainOption()
    self.Image_main = TFDirector:getChildByPath(self.Panel_option,"Image_main")
    local Label_title = TFDirector:getChildByPath(self.Image_main,"Label_title")
    local Label_state = TFDirector:getChildByPath(self.Image_main,"Label_state"):hide()
    local Image_newState = TFDirector:getChildByPath(self.Image_main,"Image_newState"):hide()
    local Image_moodIcon = TFDirector:getChildByPath(self.Image_main,"Image_moodIcon")
    local moodIconPath = self.useRoleInfo.moodPath
    local moodIconName = string.format("%s%d.png",moodIconPath,self.useRoleInfo.moodLevel)
    -- Image_moodIcon:setTexture(moodIconName)

    -- local idx = RoleDataMgr:getMainLiveDatingNewIdx()
    -- print("idx",idx)
    -- if not idx then
    --     Box("看板娘没有任何主线剧情配置")
    --     return
    -- end
    -- local datingRuleCid = RoleDataMgr:getMainLiveScriptByIdx(idx)
    -- local datingTitleId = DatingDataMgr:getDatingRuleData(datingRuleCid).datingTitle
    -- local Label_number = TFDirector:getChildByPath(self.Image_main,"Label_number")
    -- Label_number:setText("No."..idx)
    -- local Label_scriptName = TFDirector:getChildByPath(self.Image_main,"Label_scriptName")
    -- Label_scriptName:setTextById(datingTitleId)


    local state = RoleDataMgr:getMainLiveDatingState()
    if state == EC_DatingScriptState.NO_FINISH then
        Label_state:setTextById(304004)
        Label_state:show()
    elseif state == EC_DatingScriptState.TRIGGER then
        Image_newState:show()
    end

    self.Image_main.optionType = EC_DatingOption.mainOption
    table.insert(self.optionList_,self.Image_main)
end

function DatingTypeView:initDayOption()
    self.Image_day = TFDirector:getChildByPath(self.Panel_option,"Image_day")
    local Label_title = TFDirector:getChildByPath(self.Image_day,"Label_title")
    local Label_timesDes = TFDirector:getChildByPath(self.Image_day,"Label_timesDes"):hide()
    -- Label_timesDes:setTextById(900338,DatingDataMgr:getDayDatingTimes())
    local Label_times = TFDirector:getChildByPath(self.Image_day,"Label_times"):hide()
    Label_times:setText(DatingDataMgr:getDayDatingTimes())
    local Image_moodIcon = TFDirector:getChildByPath(self.Image_day,"Image_moodIcon")
    local moodIconPath = self.useRoleInfo.moodPath
    local moodIconName = string.format("%s%d.png",moodIconPath,self.useRoleInfo.moodLevel)
    -- Image_moodIcon:setTexture(moodIconName)
    local Label_state = TFDirector:getChildByPath(self.Image_day,"Label_state"):hide()
    local Image_newState = TFDirector:getChildByPath(self.Image_day,"Image_newState"):hide()
    local state = RoleDataMgr:getDayDatingState()
    if state == EC_DatingScriptState.NO_FINISH then
        Label_state:setTextById(304004)
        Label_state:show()
    else
        Label_timesDes:show()
        Label_times:show()
    end

    self.Image_day.optionType = EC_DatingOption.dayOption
    table.insert(self.optionList_,self.Image_day)
end

function DatingTypeView:initoutsideOption()
    self.Image_outside = TFDirector:getChildByPath(self.Panel_option,"Image_outside")
    local Label_title = TFDirector:getChildByPath(self.Image_outside,"Label_title")
    local Image_moodIcon = TFDirector:getChildByPath(self.Image_outside,"Image_moodIcon")
    local moodIconPath = self.useRoleInfo.moodPath
    local moodIconName = string.format("%s%d.png",moodIconPath,self.useRoleInfo.moodLevel)
    -- Image_moodIcon:setTexture(moodIconName)
    local Label_state = TFDirector:getChildByPath(self.Image_outside,"Label_state"):hide()
    local Image_newState = TFDirector:getChildByPath(self.Image_outside,"Image_newState"):hide()
    local state = RoleDataMgr:getOutSideDatingState()
    if state == EC_DatingScriptState.NO_FINISH then
        Label_state:setTextById(304004)
        Label_state:show()
    end

    self.Image_outside.optionType = EC_DatingOption.outsideOption
    table.insert(self.optionList_,self.Image_outside)
end

function DatingTypeView:initGiftAndDressOption()
    self.Image_giftAndDress = TFDirector:getChildByPath(self.Panel_option,"Image_giftAndDress")
    local Label_title = TFDirector:getChildByPath(self.Image_giftAndDress,"Label_title")
    local Image_moodIcon = TFDirector:getChildByPath(self.Image_giftAndDress,"Image_moodIcon")
    local moodIconPath = self.useRoleInfo.moodPath
    local moodIconName = string.format("%s%d.png",moodIconPath,self.useRoleInfo.moodLevel)
    -- Image_moodIcon:setTexture(moodIconName)
    local Label_state = TFDirector:getChildByPath(self.Image_giftAndDress,"Label_state"):hide()
    local Image_newState = TFDirector:getChildByPath(self.Image_giftAndDress,"Image_newState"):hide()
    local state = RoleDataMgr:getTriggerDatingState()
    if state == EC_DatingScriptState.NO_FINISH then
        Label_state:setTextById(304004)
        Label_state:show()
    elseif state == EC_DatingScriptState.TRIGGER then
        Image_newState:show()
    end

    self.Image_giftAndDress.optionType = EC_DatingOption.giftAndDressOption
    table.insert(self.optionList_,self.Image_giftAndDress)
end

function DatingTypeView:showMainView()
    local state = RoleDataMgr:getMainLiveDatingState()
    if state == EC_DatingScriptState.NO_FINISH then
        print("showMainView NO_FINISH")
        DatingDataMgr:showDatingLayer(EC_DatingScriptType.MAIN_SCRIPT,nil,true)
        return
    end
    local layer = require("lua.logic.dating.DatingMainView"):new()
    AlertManager:addLayer(layer, AlertManager.BLOCK)
    AlertManager:show()
end

function DatingTypeView:showDayView()
    local state = RoleDataMgr:getDayDatingState()
    if state == EC_DatingScriptState.NO_FINISH then
        DatingDataMgr:showDatingLayer(EC_DatingScriptType.DAY_SCRIPT,nil,true)
        return
    end

    if DatingDataMgr:getDayDatingTimes() == 0 then
        -- Utils:showTips(201011)
        local itemCfg = GoodsDataMgr:getItemCfg(EC_SItemType.DAYDATINGTIMES)
        if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
            Utils:openView("dating.BuyDatingTimesView", itemCfg.id)
        else
            Utils:showTips(900210)
        end
    else
        local layer = require("lua.logic.dating.DailyCityInfoView"):new()
        AlertManager:addLayer(layer, AlertManager.BLOCK)
        AlertManager:show()
    end
end

function DatingTypeView:showOutsideView()
    local layer = require("lua.logic.dating.DatingOutsideView"):new()
    AlertManager:addLayer(layer, AlertManager.BLOCK)
    AlertManager:show()
end

function DatingTypeView:showGiftAndDressView()
    local layer = require("lua.logic.dating.DatingGiftAndDressView"):new()
    AlertManager:addLayer(layer, AlertManager.BLOCK)
    AlertManager:show()
end

function DatingTypeView:selectOption(datingOption)
    --self.selectOption_ = datingOption
    --
    --if self.selectOption_ == EC_DatingOption.mainOption then
    --    self:showMainView()
    --elseif self.selectOption_ == EC_DatingOption.dayOption then
    --    if RoleDataMgr:isFavorReachCriticality() then
    --        Utils:showTips(304002)
    --        return
    --    end
    --    self:showDayView()
    --elseif self.selectOption_ == EC_DatingOption.outsideOption then
    --    local outsideconf = OutsideDatingDataMgr:getOutsideConfigsByRoleId(RoleDataMgr:getCurId())
    --    if #outsideconf > 0 then
    --        OutsideDatingDataMgr:sendEnterOutsideDatingMain(outsideconf[1].tbconfig.id)
    --    else
    --        Utils:showTips(900389)
    --    end
    --    -- if RoleDataMgr:isFavorReachCriticality() then
    --    --     Utils:showTips(304002)
    --    --     return
    --    -- end
    --    -- self:showOutsideView()
    --elseif self.selectOption_ == EC_DatingOption.giftAndDressOption then
    --    if RoleDataMgr:isFavorReachCriticality() then
    --        Utils:showTips(304002)
    --        return
    --    end
    --    self:showGiftAndDressView()
    --end
end

function DatingTypeView:onBuyResourceEvent()
    local Label_times = TFDirector:getChildByPath(self.Image_day,"Label_times")
    Label_times:setText(DatingDataMgr:getDayDatingTimes())
end

function DatingTypeView:registerEvents()
    for i,v in ipairs(self.optionList_) do
        local optionItem = v
        optionItem:Touchable(true)
        local Image_bottom = TFDirector:getChildByPath(optionItem,"Image_bottom")
        optionItem:OnBegan(function(sender, pos)
            Image_bottom:setTexture("ui/1025.png")
            Image_bottom:Scale(1.2)
        end)

        optionItem:OnEnded(function(sender, pos)
            self:selectOption(optionItem.optionType)
            Image_bottom:setTexture("ui/1024.png")
            Image_bottom:Scale(1)
        end)
        -- optionItem:onClick(function()
        --         self:selectOption(optionItem.optionType)
        --     end)
    end

    EventMgr:addEventListener(self, EV_STORE_BUYRESOURCE, handler(self.onBuyResourceEvent, self))
end

function DatingTypeView:setCloseCallback(callBack)
    self.closeCallBack = callBack
end

function DatingTypeView:onClose()
    self.super.onClose(self)

end

return DatingTypeView
