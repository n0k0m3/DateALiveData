local DatingOutsideView = class("DatingOutsideView",BaseLayer)

function DatingOutsideView:ctor(data)
    self.super.ctor(self)

    self:initData(data)

    self:init("lua.uiconfig.dating.datingOutsideView")
end

function DatingOutsideView:registerEvents()
    EventMgr:addEventListener(self, EV_OUTSIDE_DATING_EVENT.QuitToMain, handler(self.onQuitToMain, self))
    EventMgr:addEventListener(self, EV_OUTSIDE_DATING_EVENT.OutsideEntranceStartResult, handler(self.onEntranceStartResult, self))
end

function DatingOutsideView:initData(data)
    --self.outsideConf = OutsideDatingDataMgr:getOutsideConfig()
end

function DatingOutsideView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")
    local bgfile = self.outsideConf.tbconfig.bg or ""
    self.Image_bg:setTexture(bgfile)
    -- self.Image_bg:Size(GameConfig.WS)

    local Panel_buttons = TFDirector:getChildByPath(self.ui,"Panel_buttons")
    self.Button_final = TFDirector:getChildByPath(Panel_buttons, "Button_final")
    self.Button_menu = TFDirector:getChildByPath(Panel_buttons, "Button_menu")
    self.Button_enter = TFDirector:getChildByPath(Panel_buttons, "Button_enter")

    self.Button_final:onClick(function()
        local layer = require("lua.logic.dating.DatingOutsideFinialView"):new()
        AlertManager:addLayer(layer, AlertManager.BLOCK_CLOSE, AlertManager.TWEEN_1)
        AlertManager:show()
    end)
    self.Button_menu:onClick(function()
        local layer = require("lua.logic.dating.DatingOutsideMenuView"):new(EC_OutsideViewType.OutsideMain)
        AlertManager:addLayer(layer, AlertManager.BLOCK_CLOSE, AlertManager.TWEEN_1)
        AlertManager:show()
    end)

    self.Button_enter.isFirst = true
    self.Button_enter:onClick(function()
        self:enterClickFunc()
    end)
end

function DatingOutsideView:onShow()
    self.super.onShow(self)
    --local archivetime = OutsideDatingDataMgr:getOutsideArchieveTime()
    --if archivetime > 0 then
    --    self.Button_enter.isFirst = false
    --    self.Button_enter:getChild("Label_title"):setText("继续约会")
    --else
    --    self.Button_enter.isFirst = true
    --    self.Button_enter:getChild("Label_title"):setText("约会")
    --end
    -- self.topLayer:setCustomTittle(string.format("第%s天", OutsideDatingDataMgr:getOutsideOwnDay()))
end

function DatingOutsideView:enterClickFunc()
    --if true == self.Button_enter.isFirst then
    --    local outsidedata = OutsideDatingDataMgr:getOutsideData()
    --    local entrance = outsidedata.paragragh.entrances or {}
    --    if #entrance > 0 then
    --        OutsideDatingDataMgr:sendStartEntrance(entrance[1])
    --    else
    --        Utils:showTips(900693)
    --    end
    --else
    --    local layer = require("lua.logic.dating.DatingOutsideMenuView"):new(EC_OutsideViewType.OutSideMainDate)
    --    AlertManager:addLayer(layer, AlertManager.BLOCK_CLOSE, AlertManager.TWEEN_1)
    --    AlertManager:show()
    --end
end

function DatingOutsideView:onQuitToMain(bEnterCity)
    AlertManager:closeAllBeforLayer(self)
    if bEnterCity then
        Utils:openView("dating.DatingOutsideCityMainView")
    end

    TFAudio.stopMusic()
    TFAudio.playBmg("sound/bgm/date_003.mp3",true)
end

function DatingOutsideView:onEntranceStartResult(tType, tMsgId)
    --local getMsgConfData = function(tType)
    --    local outsideMessageTab = TabDataMgr:getData("OutsideMessage")
    --    local messageData = {}
    --    for k,v in pairs(outsideMessageTab) do
    --        if v.id == tMsgId then
    --            messageData = clone(v)
    --            break
    --        end
    --    end
    --    return messageData
    --end
    --
    --if tType == 1 then--进入剧本
    --    local function scriptStart()
    --        DatingDataMgr:setCurMsg({currentNodeId=tMsgId, datingType=EC_DatingScriptType.OUTSIDE_SCRIPT})
    --        Utils:openView("dating.DatingScriptView")
    --    end
    --    if OutsideDatingDataMgr:getIsCurEntranceNextStepChange() and self.Button_enter.isFirst == false then
    --        local view = Utils:openView("common.ChooseMessageBox")
    --        view:setCallback(scriptStart)
    --        view:setContent("是否进入下一阶段")
    --    else
    --        scriptStart()
    --    end
    --elseif tType == 2 then--信息提示
    --    local msgData = getMsgConfData()
    --    if msgData.type == 3 then
    --        OutsideDatingDataMgr:sendUpdateEntranceEvent(tMsgId, EC_OutsideChoiceType.OutsideChoiceMessage)
    --    else
    --        Utils:openView("dating.DatingOutsideCityEvent2View", msgData)
    --    end
    --end
end

return DatingOutsideView