local PhoneDatingView = class("PhoneDatingView", BaseLayer)

function PhoneDatingView:ctor(param,updateStep,callback)
	self.super.ctor(self)
	self:initData(param,updateStep,callback)
	self:init("lua.uiconfig.iphone.PhoneDatingView")
end

function PhoneDatingView:initData(param,updateStep,callback)


    self.tableName = param.scriptTableName
    self.datingId = param.datingId
    self.isSkip = param.isSkip
    self.isAuto = param.isAuto
    self.updateStep = updateStep
    self.callback = callback
    self.DatingBaseCfg = TabDataMgr:getData(self.tableName)

end

function PhoneDatingView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

    self.phoneBg = TFDirector:getChildByPath(self.ui,"Panel_iPhoneX")
    self.Label_page_name = TFDirector:getChildByPath(self.ui,"Label_page_name")

    self.Panel_chat_view = TFDirector:getChildByPath(self.ui,"Panel_chat_view")
    self.ScrollView_chat = TFDirector:getChildByPath(self.Panel_chat_view,"ScrollView_chat")
    self.ScrollView_chat:setSwallowTouch(false)
    self.chatListView = UIListView:create(self.ScrollView_chat)
    self.chatListView:setItemsMargin(5)
    
    --option界面
    self.Panel_option_view = TFDirector:getChildByPath(self.ui,"Panel_option_view")
    self.Image_option = TFDirector:getChildByPath(self.Panel_option_view,"Image_option")
    self.Image_optionDarkBg = TFDirector:getChildByPath(self.Panel_option_view,"Image_optionDarkBg")
    self.Image_optionListbg = TFDirector:getChildByPath(self.Panel_option_view,"Image_optionListbg")
    self.ScrollView_option = TFDirector:getChildByPath(self.Image_optionListbg,"ScrollView_option")
    self.optionListView = UIListView:create(self.ScrollView_option)
    self.optionListView:setItemsMargin(8)
    
    self.Panel_prefab = TFDirector:getChildByPath(self.ui,"Panel_prefab")
    self.leftCell = TFDirector:getChildByPath(self.Panel_prefab,"Panel_contact_lcell")
    self.rightCell = TFDirector:getChildByPath(self.Panel_prefab,"Panel_contact_rcell")
    self.Panel_optionItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_optionItem")

    --show界面
    local action = MoveTo:create(0.1,ccp(681,0))
    self.phoneBg:runAction(action)

    self:showDationInfo(self.datingId,true)
end

function PhoneDatingView:getDatingInfo( datingId )
    local datingInfo = self.DatingBaseCfg[datingId]
    datingInfo.nameId = datingInfo.nameId or 0
    datingInfo.text = datingInfo.text or ""
    datingInfo.headIcon = datingInfo.headIcon or ""
    datingInfo.jump = datingInfo.jump or {}
    return datingInfo
end
--function DatingScriptView:refreshChatContent()
--datingId:PhoneDating配置ID
function PhoneDatingView:showDationInfo(datingId,isInit)

    if not datingId then
        return
    end

    if not datingInfo then
        return
    end

    local datingInfo = self:getDatingInfo(datingId)

    local nameId = datingInfo.nameId
    if nameId == 0 then
        self:thisDatingEnd()
        return 
    end

    self.curdatingId = datingId
    if not isInit then
        if self.updateStep then            
            self.updateStep(self.curdatingId)
        end
    end 

    self.Label_page_name:setTextById(datingInfo.nameId)
    self:updateChatInfo(datingInfo)
    self:addCountDownTimer()
    --是否是最后的剧情
    local jumpInfo = datingInfo.jump
    --跳转面板
    if #jumpInfo == 1 then
        self.nextDatingId = jumpInfo[1]
        self.Panel_option_view:setVisible(false)
        self.Panel_chat_view:setTouchEnabled(true)
    else
        self:removeCountDownTimer()
        self.Panel_option_view:setVisible(true)
        self:updateOptionListInfo(datingInfo.jump)
        self.Panel_chat_view:setTouchEnabled(false)
    end

end
function PhoneDatingView:updateChatInfo(datingInfo)

    if not datingInfo then
        return
    end

    local headIcon = datingInfo.headIcon
    local cell = headIcon ~= "1" and self.leftCell:clone() or self.rightCell:clone()
    local Image_head = TFDirector:getChildByPath(cell,"Image_head")
    if headIcon ~= "1" then
        Image_head:setTexture(headIcon)
    else
        local heroCid = MainPlayer:getAssistId()
        Image_head:setTexture(HeroDataMgr:getIconPathById(heroCid))
    end
    local TextArea_msg = TFDirector:getChildByPath(cell,"TextArea_msg")
    local textStr =  string.gsub(datingInfo.text, "%%s", MainPlayer:getPlayerName())
    TextArea_msg:setText(textStr)
    self.chatListView:pushBackCustomItem(cell)
    self.chatListView:jumpToBottom()

end

--option界面
function PhoneDatingView:updateOptionListInfo(jumpInfo)

    --说明剧情结束
    if not next(jumpInfo) then
        return
    end

    for k,v in ipairs(jumpInfo) do
        local datingId = v
        local datingInfo = self:getDatingInfo(datingId)
        local optionItem = self.Panel_optionItem:clone()
        optionItem:setVisible(true)
        local TextArea_option = optionItem:getChildByName("TextArea_option")
        TextArea_option:setText(datingInfo.text)
        self.optionListView:pushBackCustomItem(optionItem)
        optionItem:onClick(function() 
            self:removeCountDownTimer()
            self.Panel_option_view:setVisible(false)            
            DatingDataMgr:sendDialogueMsg(self.curdatingId, datingId, DatingDataMgr:getScriptType(), RoleDataMgr:getCurId())
            self:showDationInfo(datingId)
        end)
    end
end

function PhoneDatingView:registerEvents()

    self.Panel_chat_view:onClick(function()        
        self:showDationInfo(self.nextDatingId)
    end)
end

function PhoneDatingView:thisDatingEnd()
    self:removeCountDownTimer()
    if self.callback then        
        if self.curdatingId then
            self.callback(self.curdatingId,self.isSkip,self.isAuto)
        end
    end
    self.nextDatingId = nil
    AlertManager:closeLayer(self)
end

function PhoneDatingView:removeEvents()
    self:removeCountDownTimer()
end

function PhoneDatingView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(2000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function PhoneDatingView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function PhoneDatingView:onCountDownPer()
    if not self.nextDatingId then
        return
    end
    self:showDationInfo(self.nextDatingId)
end

return PhoneDatingView