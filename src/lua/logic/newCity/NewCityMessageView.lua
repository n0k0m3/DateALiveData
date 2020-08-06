local NewCityMessageView = class("NewCityMessageView", BaseLayer)

function NewCityMessageView:ctor(messageid)
    self.super.ctor(self)

    self:initData(messageid)
    self:showPopAnim(true)
    self:init("lua.uiconfig.newCity.newCityMessageView")
end

function NewCityMessageView:registerEvents()
    EventMgr:addEventListener(self, EV_NEWCITY_DATING_EVENT.OptionChoiceStatus, handler(self.choiceOptionStatus, self))
end

function NewCityMessageView:initData(messageid)
    self.buttonChoose = {}
    self.msgConf = {}
    if NewCityDataMgr.curDatingCityType == EC_NewCityType.NewCity_MainLine then
        self.msgConf = TabDataMgr:getData("FavorMessage", messageid)
    elseif NewCityDataMgr.curDatingCityType == EC_NewCityType.NewCity_Outside then
        self.msgConf = TabDataMgr:getData("OutsideMessage", messageid)
    end
end

function NewCityMessageView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")

    self.Label_tittle = TFDirector:getChildByPath(self.ui, "Label_tittle")
    self.TextArea_eventDes = TFDirector:getChildByPath(self.ui, "TextArea_eventDes")
    for i=1,2 do
        local button = TFDirector:getChildByPath(self.ui, "Button_choose"..i)
        local label = button:getChild("Label_choose"..i)
        button:Touchable(false)
        button:setGrayEnabled(true)
        table.insert(self.buttonChoose, {bt=button,lab=label})
    end

    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_touch"):hide()
    self.Label_touch = self.Panel_touch:getChild("Label_touch")
    self.Panel_touchMask = TFDirector:getChildByPath(self.ui, "Panel_touchMask"):hide()

    self.Label_tittle:setTextById(self.msgConf.titleDes)
    self.TextArea_eventDes:setTextById(self.msgConf.content)

    self:initEventView()
end

function NewCityMessageView:initEventView()
    local msgType = self.msgConf.type
    if msgType == 1 then
        self:viewSetByType1()
    elseif msgType == 2 then
        self:viewSetByType2()
    end
end


function NewCityMessageView:hideChooseBt(touchcallback)
    for i,v in ipairs(self.buttonChoose) do
        v.bt:hide()
    end
    self.Panel_touch:show()
    self.Panel_touch:Touchable(true)
    self.Panel_touch:onClick(touchcallback)
    self.Label_touch:setTextById(800018)
end

function NewCityMessageView:viewSetByType1()
    local bgparentsize = self.Image_bg:getParent():getSize()
    self.Image_bg:Pos(bgparentsize.width * 0.5, bgparentsize.height * 0.5)
    for i,v in ipairs(self.buttonChoose) do
        if i == 1 then
            v.lab:setTextById(self.msgConf["option"..i])
            v.bt:setPositionX(0)
            v.bt:Touchable(true)
            v.bt:setGrayEnabled(false)
            v.bt:onClick(function(sender)
                AlertManager:closeLayer(self)
            end)
        else
             v.bt:hide()
        end
        
    end
    -- self.Label_touch:setPositionX(bgparentsize.width * 0.5)
    -- self:hideChooseBt(function()
    --     AlertManager:closeLayer(self)
    -- end)
end

function NewCityMessageView:viewSetByType2()
    NewCityDataMgr:sendGetEntranceEventChoices(self.msgConf.id, EC_DatingChoiceType.ChoiceMessage)
    for i,v in ipairs(self.buttonChoose) do
        v.lab:setTextById(self.msgConf["option"..i])
        v.bt:onClick(function(sender)
            NewCityDataMgr:sendChooseEntranceEvent(self.msgConf.id, EC_DatingChoiceType.ChoiceMessage, i)
            AlertManager:closeLayer(self)
        end)
    end
end

function NewCityMessageView:choiceOptionStatus(tOption)
    for i,v in ipairs(tOption) do
        local tv = tonumber(v)
        if self.buttonChoose[tv] then
            local bt = self.buttonChoose[tv].bt
            bt:Touchable(true)
            bt:setGrayEnabled(false)
        end
    end
end

return NewCityMessageView