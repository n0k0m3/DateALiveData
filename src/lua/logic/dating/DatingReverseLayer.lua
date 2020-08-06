local DatingReverseLayer = class("DatingReverseLayer",BaseLayer)

function DatingReverseLayer:initData(...)

    self.ruleCid = DatingDataMgr:getCurDatingScriptRuleCid()
    self.roleModelId = DatingDataMgr:getCityDatingModelId(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid)
    self.roleId = DatingDataMgr:getCityDatingRoleId(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid)
    self.lines = clone(DatingDataMgr:getCityDatingLines(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid))
    self.buildId = DatingDataMgr:getCityDatingBuildId(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid)
    self.datingTimeFrame = DatingDataMgr:getCityDatingTimeFrame(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid)
    self.datingId = DatingDataMgr:getCityDatingId(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid)
    self.bg = DatingDataMgr:getCityDatingBg(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid)
    self.answer = DatingDataMgr:getCityDatingAnswer(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid)

    self.actionName_ = {}

    self.useRoleInfo = clone(RoleDataMgr:getRoleInfo(self.roleId))
    self.maxNum = 5
    self.curNum = 0
end

function DatingReverseLayer:ctor(...)
    self.super.ctor(self,data)

    self:initData(...)
    self:init("lua.uiconfig.dating.datingReverseLayer")
end

function DatingReverseLayer:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    local Image_bg = TFDirector:getChildByPath(self.ui,"Image_bg")
    Image_bg:setTexture(self.bg)

    self:initRoleInfo()
    self:initCityInfo()
    self:initOptions()
    local Panel_goodFeeling = TFDirector:getChildByPath(self.ui, "Panel_goodFeeling"):hide()
    local Image_mood = TFDirector:getChildByPath(self.ui,"Image_mood"):hide()
    -- self:initFavorView()
    -- self:initMoodView()

    self.ui:runAnimation("Action0",-1);
end

function DatingReverseLayer:initFavorView()
    local Panel_goodFeeling = TFDirector:getChildByPath(self.ui, "Panel_goodFeeling"):hide()
    local data = {}
    data.isHide = true
    data.pos = Panel_goodFeeling:Pos()
    data.isShowFavorUp = true
    self.favorView        = require("lua.logic.dating.FavorView"):new(data);
    self:addLayerToNode(self.favorView,Panel_goodFeeling:getParent(),1);
    self.favorView:setZOrder(100)

end

function DatingReverseLayer:initMoodView()
    local Image_mood = TFDirector:getChildByPath(self.ui,"Image_mood"):hide()
    local data = {}
    data.isHide = true
    data.pos = Image_mood:Pos()
    self.moodView        = require("lua.logic.dating.MoodView"):new(data);
    self:addLayerToNode(self.moodView,Image_mood:getParent(),1);
    self.moodView:setZOrder(100)
end

function DatingReverseLayer:initRoleInfo()
    self.Panel_roleInfo = TFDirector:getChildByPath(self.ui,"Panel_roleInfo")

    self:initRole()
    self:showInfoTip()
end

function DatingReverseLayer:initRole()
    self.Image_npc = TFDirector:getChildByPath(self.Panel_roleInfo,"Image_npc")
    local idle = DatingDataMgr:getCityDatingRoleIdle(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid)
    self.elvesNpc = ElvesNpcTable:createLive2dNpcID(self.roleModelId,false,false,idle).live2d
    local scale = DatingDataMgr:getCityDatingInfoByRuleCid(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid).data.roleModelScale 
    self.elvesNpc:setScale(scale)
    self.Image_npc:getParent():addChild(self.elvesNpc)
    self.elvesNpc:setZOrder(self.Image_npc:getZOrder())
    local pos = self.Image_npc:getPosition() - ccp(0,self.Image_npc:getSize().height/2-40)
    self.elvesNpc:setPosition(pos)
    self.Image_npc:setVisible(false)
end

function DatingReverseLayer:showInfoTip()

    VoiceDataMgr:playVoice("dating_invite_wait",self.roleId)

    self.curNum = self.curNum + 1
    for i=1,3 do
        if #self.lines == 0 then
            self.lines = clone(DatingDataMgr:getCityDatingLines(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid))
        end
        local imageInfoTip = TFDirector:getChildByPath(self.Panel_roleInfo,"Image_infoTip0" .. i)
        local Label_infoTip = TFDirector:getChildByPath(imageInfoTip,"Label_infoTip")
        Label_infoTip:ignoreContentAdaptWithSize(true)
        Label_infoTip:setWidth(0)
        local idx = math.random(1,#self.lines)
        Label_infoTip:setTextById(self.lines[idx])
        local maxWidth = 100
        Label_infoTip:setTextAreaSize(me.size(maxWidth,0))
        local size = Label_infoTip:Size()
        imageInfoTip:Size(maxWidth+30,90)
        if size.width > maxWidth then
            size.width = maxWidth
            size.height = size.height * 2
            Label_infoTip:setTextAreaSize(me.size(size.width,0))
            Label_infoTip:setTextById(self.lines[idx])
            Label_infoTip:Size(size.width,size.height)
            imageInfoTip:Size(size.width+30,size.height+30)
        end

        imageInfoTip:fadeIn(0.1)
        if self.curNum < self.maxNum then
            Label_infoTip:timeOut(function()
                imageInfoTip:fadeOut(0.1)
                end,6.9)
        end
        table.remove(self.lines,idx)
    end
    if self.curNum < self.maxNum then
        self:timeOut(function()
                self:showInfoTip()
            end,7)
    end
end

function DatingReverseLayer:initCityInfo()
    local Image_cityBottom = TFDirector:getChildByPath(self.ui,"Image_cityBottom")
    local Image_city = TFDirector:getChildByPath(self.ui,"Image_city")
    local Label_cityName = TFDirector:getChildByPath(Image_cityBottom,"Label_cityName")
    self.Label_time1 = TFDirector:getChildByPath(Image_cityBottom,"Label_time1")
    self.Label_time2 = TFDirector:getChildByPath(Image_cityBottom,"Label_time2")

    local buildCfg = CityDataMgr:getBuildCfg(self.buildId)
    Image_city:setTexture(buildCfg.wallPaper)
    Image_city:Size(320,180)
    Label_cityName:setTextById(buildCfg.nameId)
    if not self.datingTimeFrame then
        Utils:showTips(304013)
        return
    end
    print("self.datingTimeFrame ",self.datingTimeFrame)
    local timeStr = ""
    timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[1]) .. ":"
    timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[2]) .. "-"
    timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[3]) .. ":"
    timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[4]) .. ""
    self.Label_time1:setString(timeStr)

    if self.datingTimeFrame[5] then
        timeStr = ""
        timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[5]) .. ":"
        timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[6]) .. "-"
        timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[7]) .. ":"
        timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[8]) .. ""
        self.Label_time2:setString(timeStr)
    else
        self.Label_time2:hide()
    end
end

function DatingReverseLayer:initOptions()
    local Panel_options = TFDirector:getChildByPath(self.ui,"Panel_options")
    self.Panel_options = Panel_options
    local optionsData = clone(self.answer)
    for i=1,#optionsData do
        local TextButton_option = TFDirector:getChildByPath(Panel_options,"TextButton_option" .. i)
        local str = TextDataMgr:getTextAttr(optionsData[i].word).text
        local actionName = DatingDataMgr:getCityDatingRoleAction(EC_DatingScriptType.RESERVE_SCRIPT,self.ruleCid,i)
        self.actionName_[i] = actionName
        TextButton_option:setText(str)

        local Label_time = TFDirector:getChildByPath(TextButton_option,"Label_time")
        if optionsData[i].time then
            if optionsData[i].time == 0 then
                local timeStr = ""
                timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[1]) .. ":"
                timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[2]) .. "-"
                timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[3]) .. ":"
                timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[4]) .. ""
                Label_time:setText(timeStr)
            elseif optionsData[i].time == 1 and self.datingTimeFrame[5] then
                local timeStr = ""
                timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[5]) .. ":"
                timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[6]) .. "-"
                timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[7]) .. ":"
                timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[8]) .. ""
                Label_time:setText(timeStr)
            end
        else
            Label_time:hide()
        end
        TextButton_option:onClick(function()
            if self.isNoClick then
                return
            end
            -- EventMgr:dispatchEvent(EV_DATING_EVENT.cancelTriggerReverseRedTips)
            DatingDataMgr:answerDatingInvitationMsg(self.datingId,i)

            if self.answer[i].type == 1 then
                VoiceDataMgr:playVoice("dating_invite_yes",self.roleId)
            else
                VoiceDataMgr:playVoice("dating_invite_no",self.roleId)
            end

            if self.actionName_[i] then
                self.elvesNpc:newStartAction(self.actionName_[i],EC_PRIORITY.FORCE)
            end
            self.isNoClick = true
            self.Panel_options:timeOut(function()
                    AlertManager:closeLayer(self)
                end,5)
            self:hideOther()
            end)
    end
end

function DatingReverseLayer:onShowFavorAndMoodView()
    local favorAndMoodView = nil
    local data = {}
    data.lastRoleInfo = self.useRoleInfo
    data.roleId = self.roleId
    data.ruleId = self.ruleCid
    data.hideBg = true
    favorAndMoodView = Utils:openView("common.FavorAndMoodView",data)

    local time = 3
    self.ui:timeOut(function()
            AlertManager:closeLayer(favorAndMoodView)
        end,time)
end

function DatingReverseLayer:hideOther()
    for i=1,3 do
        local imageInfoTip = TFDirector:getChildByPath(self.Panel_roleInfo,"Image_infoTip0" .. i)
        local TextButton_option = TFDirector:getChildByPath(self.Panel_options,"TextButton_option" .. i)
        imageInfoTip:hide()
        imageInfoTip:stopAllActions()
        TextButton_option:hide()
    end
end

function DatingReverseLayer:onClose()
    self.super.onClose(self)
end

--注册事件
function DatingReverseLayer:registerEvents()
    self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_DATING_EVENT.acceptDating, handler(self.onShowFavorAndMoodView,self))
end

return DatingReverseLayer;
