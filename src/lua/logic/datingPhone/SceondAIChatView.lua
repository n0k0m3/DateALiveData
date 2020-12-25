--[[
    desc: 第二个ai聊天房间界面
]]
local SceondAIChatView = class("SceondAIChatView", BaseLayer)
local RoleTachMacro = require("lua.logic.datingPhone.RoleTachMacro")

-- 背景默认地图
local DEFAULT_BGRES  = "ui/mainLayer/new_ui/bg_morning.png"
-- 限定输入字符
local LIMIT_INPUTNUM = 80
-- 反转值升高播放对应id
local MODEL_UPID = 27
-- 反转值对应阶段默认回复动作id
local MODEL_STAGE_ID = {
    [70] = 28,
    [80] = 29,
    [90] = 30
}
-- 无表情播放动作
local DEFULT_MODELID = 32

function SceondAIChatView:ctor(...)
    self.super.ctor(self)
    
    self:initData(...)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.iphone.secondAIChatView")
end

function SceondAIChatView:initData(_roleId, _isComeFromPhone)
    -- 交谈精灵id
    self.roleId          =  101  --_roleId or RoleDataMgr:getUseId() 现在固定显示十香……
    -- 是否从手机页面跳转过来
    self.isComeFromPhone = _isComeFromPhone or false
    
    self.roleEmotionInfo = DatingPhoneDataMgr:getRoleEmotionInfo(self.roleId)

    local itemCost = Utils:getKVP(20008)
    for k,v in pairs(itemCost) do
        self.costItemId = k
        self.costItemNum = v
    end
    self.isHadInSceondAI = DatingPhoneDataMgr:getIsHadInSceondAI()
    
    TFDirector:send(c2s.DATING_REQ_AIPROP, {self.roleId})
end

function SceondAIChatView:initUI(ui)
    self.super.initUI(self,ui)
    self:showCg()
    self:initTopUI()
    -- 背景图
    local _txtTure = DatingPhoneDataMgr:keepMainBgTexture()
    if _txtTure then
        self._ui.img_Bg:setTexture(_txtTure)
    else
        self._ui.img_Bg:setTexture(DEFAULT_BGRES)
    end 

    self.chatView  = UIListView:create(self._ui.view)
    self.chatView:setItemsMargin(5)
    self.scrollBar = UIScrollBar:create(self._ui.Image_scrollBarModel, self._ui.Image_scrollBarInner)
    self.scrollBar:setVisible(false)
    self.chatView:setScrollBar(self.scrollBar)

    self.faceView  = UIListView:create(self._ui.view_face)

    self.inputView = UIListView:create(self._ui.view_input)
    self.inputView:setVisible(false)

    self.inputViewTemp = UIListView:create(self._ui.view_input1)

    self.keepSendPanelPosY = self._ui.sendPanel:getPositionY()

    -- 道具相关
    self._ui.Panel_buyTip:hide()
    self._ui.Panel_noItem:hide()

    self:loadLive2d()
    self:loadLocalMsg()
    self:loadFaceView()

    self._ui.txtField_input:setMaxLength(10)

    self._ui.panel_InputShow:setVisible(false)

    -- 调教功能页
    -- self.roleTeachLayer = require("lua.logic.datingPhone.RoleTeachFuncLayer"):new(self.roleId)
    -- self:addLayerToNode(self.roleTeachLayer,self._ui.addLayerPos)

    ViewAnimationHelper.doMoveFadeInAction(self._ui.panel_left, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self._ui.panel_right, {direction = 2, distance = 30, ease = 1})

    self._ui.pannelNoDatashow:hide()
    self:timeOut(function()
        if not RoleTeachDataMgr:getAchieveData() then
            self._ui.pannelNoDatashow:show()
            if not self.schedule then
                self.schedule = TFDirector:addTimer(3*1000, -1, nil, handler(self.scheduleUpdate, self))
            end
        else
            self._ui.pannelNoDatashow:hide()
        end
    end,1)
    
end

function SceondAIChatView:scheduleUpdate()
    if not RoleTeachDataMgr:getAchieveData() then
        RoleTeachDataMgr:SendTeachInfoRequest()
    else
        self:removeTime()
        self._ui.pannelNoDatashow:hide()
        self:refreshTeachRed()
    end
end

function SceondAIChatView:removeTime()
    if self.schedule then
        TFDirector:removeTimer(self.schedule)
        self.schedule = nil
    end
end

function SceondAIChatView:onShow()
	self.super.onShow(self)
    self:refreshTeachRed()
end

function SceondAIChatView:showCg()
    if not self.isHadInSceondAI then
        DatingDataMgr:startDating(244)
    end
end

function SceondAIChatView:registerEvents()
    EventMgr:addEventListener(self,EV_DATING_EVENT.checkSendDialogue, handler(self.onSendDialogue, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.robotDialogue, handler(self.onRecvRobotDialogue, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.getRoleAttrData, handler(self.onRecvRoleAttr, self))
    EventMgr:addEventListener(self,EV_ROLETEACHCURLAYER_REFRESH, handler(self.refreshTeachRed, self))
    EventMgr:addEventListener(self,EV_KEYBOARD_UP, handler(self.onRecvKeyBoard, self))

    self._ui.Button_back:onClick(function()
        if self.isComeFromPhone then
            Utils:setScreenOrientation(SCREEN_ORIENTATION_PORTRAIT)
        else
            DatingPhoneDataMgr:writeDialogue()
        end
        self:removeTime()
        self._ui.txtField_input:closeIME()
        AlertManager:closeLayer(self)
    end)

    self._ui.Button_close:onClick(function()
        local currentScene = Public:currentScene();
        self:removeTime()
        if currentScene.__cname == "MainScene" then
            AlertManager:closeAll()
        else
            AlertManager:changeScene(SceneType.MainScene)
        end
    end)

    -- 消息发送按钮
    local function  messageSend()
        local state = DatingPhoneDataMgr:getHeroForbidState(self.roleId)
        if state == Enum_PhoneRoleState.NORMAL then
            self:onClickSendMsg()
        else
            self:initBuyPL()
            self._ui.Panel_buyTip:setVisible(true)
        end
        DatingPhoneDataMgr:setChatWithAI()
    end
    self._ui.btn_send:onClick(function()
        messageSend()
    end)
    self._ui.btn_send1:onClick(function()
        messageSend()
    end)

    -- 表情按钮
    self._ui.btn_face:onClick(function()
        self._ui.pannel_face:setVisible(not self._ui.pannel_face:isVisible())
        
    end)

    -- 道具使用
    self._ui.Button_useItem:onClick(function()
        local isEnough = GoodsDataMgr:currencyIsEnough(self.costItemId, self.costItemNum)
        if isEnough then
            TFDirector:send(c2s.DATING_REQ_RELIEVE_HEART_STATE, {self.roleId})
        else
            self._ui.Panel_noItem:setVisible(true)
        end
        self._ui.Panel_buyTip:setVisible(false)
    end)

    -- 拒绝道具
    self._ui.Button_refuse:onClick(function()
        self._ui.Panel_buyTip:setVisible(false)
    end)

    -- 跳转
    self._ui.Button_jump:onClick(function()
        self._ui.Panel_noItem:setVisible(false)
        Utils:openView("store.StoreMainView")
    end)

    self._ui.Panel_buyTip:onClick(function()
        self._ui.Panel_buyTip:setVisible(false)
    end)

    self._ui.Panel_noItem:onClick(function()
        self._ui.Panel_noItem:setVisible(false)
    end)

    -- 调教相关
    self._ui.btn_Achieve:onClick(function()
        Utils:openView("datingPhone.RoleTeachFuncLayer", self.roleId,RoleTachMacro.PAGETYPE.ACHIEVE)
    end)
    self._ui.btn_Teach:onClick(function()

        local isCanTeach = RoleTeachDataMgr:canTeachRole()
        if not isCanTeach then
            Utils:openView("datingPhone.JoinTipView")
            return
        end

        Utils:openView("datingPhone.RoleTeachFuncLayer", self.roleId,RoleTachMacro.PAGETYPE.TEACH,RoleTachMacro.TEACH.TeachSelf)
    end)
    self._ui.btn_Rank:onClick(function()
        Utils:openView("datingPhone.RoleTeachFuncLayer", self.roleId,RoleTachMacro.PAGETYPE.RANK)
    end)

    self._ui.touch_reversal:setTouchEnabled(true)
    self._ui.touch_reversal:onClick(function ()
        -- showItemCoolDownTips(EC_SItemType.REVERSAL, self._ui.touch_reversal)
        Utils:openView("datingPhone.AiLabshowView", 1,800132)
    end)

    self._ui.touch_lover:setTouchEnabled(true)
    self._ui.touch_lover:onClick(function ()
        -- showItemCoolDownTips(EC_SItemType.LOVER, self._ui.touch_lover)
        Utils:openView("datingPhone.AiLabshowView", 1,800133)
    end)

    self._ui.btn_addRoleTeachDay:onClick(function()

        Utils:openView("datingPhone.JoinTipView")
        --Utils:openView("datingPhone.TeachCardShowView")
    end)

    local function onTextFieldAttachAcc(input)
        self._ui.lab_tip:setVisible(false)
        self.inputView:setVisible(true)
        self.chatView:scrollToTop(0.5)
        self:setInputText(input:getText())
    end

    local function onTextFieldChangedHandleAcc(input)
        self:setInputText(input:getText())
    end
    
    self._ui.txtField_input:setMaxLengthEnabled(true)
    self._ui.txtField_input:setMaxLength(LIMIT_INPUTNUM)
    self._ui.txtField_input:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self._ui.txtField_input:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)
    -- self._ui.txtField_input:addMEListener(TFTEXTFIELD_INSERT, onTextFieldChangedHandleAcc)
    -- self._ui.txtField_input:addMEListener(TFTEXTFIELD_DELETE, onTextFieldChangedHandleDelete)
end

function SceondAIChatView:initTopUI()
    -- 精灵名字
    self._ui.lab_roleName:setTextById(TabDataMgr:getData("Phone", self.roleId)["nameId"])
    -- 手机时间
    local curTime = TFDate(ServerDataMgr:getServerTime()):tolocal()
    local hour, min = curTime:gettime()
    local timeStr = string.format("%02d:%02d", hour, min)
    self._ui.Label_Phone_time:setText(timeStr)

    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            local curTime = TFDate(ServerDataMgr:getServerTime()):tolocal()
            local hour,min = curTime:gettime()
            local timeStr = string.format("%02d:%02d",hour,min)
            self._ui.Label_Phone_time:setText(timeStr)
        end)
    })
    local repeatAct = CCRepeatForever:create(seqact)
    self._ui.Label_Phone_time:runAction(repeatAct)
    -- 手机电量
    self._ui.LoadingBar_battery:setPercent(TFDeviceInfo:getBatteryLevel())
end

function SceondAIChatView:initBuyPL()

    self._ui.Label_itemdesc:setTextById(901180)
    self._ui.Label_noitemdesc:setTextById(901182)

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(Panel_goodsItem, self.costItemId)
    Panel_goodsItem:Pos(0,0):AddTo(self._ui.Image_item_frame)

    local cfg = GoodsDataMgr:getItemCfg(self.costItemId)
    if not cfg then
        return
    end

    self._ui.Label_item_name:setTextById(cfg.nameTextId)

    local own = GoodsDataMgr:getItemCount(self.costItemId)
    self._ui.Label_item_owncnt:setText(own)
end

function SceondAIChatView:setInputText(inputText)

    local maxHeight = 110
    if not self.richInput then
        self.richInput = TFRichText:create(ccs(370, 30))
        self.richInput:AnchorPoint(me.p(0, 0.5))
        self.inputView:pushBackCustomItem(self.richInput)
    end 
    -- 表情转换字符里面有“>”符号 所以输出显示会导致异常
    inputText = string.gsub(inputText, "<", "《")
    inputText = string.gsub(inputText, ">", "》")

    self._ui.txtField_input:setText(inputText)
    self.inputTxt = inputText
    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
    for k,v in ipairs(faceCfg) do
        local converTxt = string.gsub(v.conversioncode, "<", "《")
        converTxt = string.gsub(converTxt,">", "》")
        inputText = string.gsub(inputText,converTxt,v.convermotion)
        self.inputTxt = string.gsub(self.inputTxt, converTxt, v.conversioncode)
    end
    self.richInput:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r301010"), inputText))
    local size = self.richInput:getSize()
    local newWidth = size.width
    local newHeight = size.height
    if newWidth <= 370 then
        newWidth = 380
    end

    local richTextPosX = 2
    if newHeight < 45 then
        newHeight = 52
        richTextPosX = 5
    else
        newHeight = size.height + math.ceil(size.height / 30) * 10
    end

    if newHeight > maxHeight then
        newHeight = maxHeight
    end
    
    self.inputView:setContentSize(CCSize(newWidth + 10, newHeight))
    self._ui.img_Fieldbg:setContentSize(CCSize(newWidth + 10, newHeight))
    -- self._ui.img_SendPanel:setContentSize(CCSize(607,newHeight + 35))
    self._ui.pannel_face:setPositionY(self._ui.img_Fieldbg:getContentSize().height - 17)
    
    self.inputView:doLayout()
    self.inputView:jumpToBottom()
    self.richInput:setPositionX(richTextPosX)

    self:refreshKeboardShow()
end

function SceondAIChatView:refreshKeboardShow()
    local inputText = self.inputTxt
    if not self.richInput1 then
        self.richInput1 = TFRichText:create(ccs(970, 24))
        self.richInput1:AnchorPoint(me.p(0, 0.5))
        self.inputViewTemp:pushBackCustomItem(self.richInput1)
    end 

    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
    for k,v in ipairs(faceCfg) do
        inputText = string.gsub(inputText,v.conversioncode,v.convermotion)
    end
    self.richInput1:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r301011"), inputText))
    self.inputViewTemp:doLayout()
    self.richInput1:setPositionX(2)
end

function SceondAIChatView:refreshTeachRed()
    local _, _bool = RoleTeachDataMgr:getTeachRedShow()
    self._ui.btnTeachRedNew:setVisible(_bool)
    self._ui.roleTeachDayRed:setVisible(RoleTeachDataMgr:roleTeachLostDays() < 3 and RoleTeachDataMgr:isHaveBoughtTeachCard())
    self._ui.btnAchieveRedNew:setVisible(RoleTeachDataMgr:getRoleTeachAchieveRed())
     -- 调教剩余天数
    self._ui.txt_roleTeachDays:setText(RoleTeachDataMgr:roleTeachLostDays())
end

-- 输入框保持在系统输入法上方
function SceondAIChatView:onRecvKeyBoard(keyboardHeight)
    self:timeOut(function()
        local bool = false
        if keyboardHeight > 0 then
            bool = true
            self._ui.movePanel:setPositionY(keyboardHeight)
        end
        self._ui.panel_InputShow:setVisible(bool)
    end, 0.1)
end

function SceondAIChatView:onClickSendMsg()
    self._ui.pannel_face:setVisible(false)

    if self.inputTxt and #self.inputTxt > 0 and not Utils:getTxtExistSpace(self.inputTxt) then
        DatingPhoneDataMgr:sendAiDialogue(EC_PhoneChatType.Normal, self.inputTxt, self.roleId)
        -- 保留自己上次提的问题
        self.keepLastInputTxt = self.inputTxt

        self.inputView:setVisible(false)
    else
        Utils:showTips(800104)
        self._ui.lab_tip:setVisible(true)
    end
    self.inputTxt = ""
    self._ui.txtField_input:setText("")
    self:setInputText("")
end

function SceondAIChatView:loadLive2d()

    local _live2d = ElvesNpcTable:createLive2dNpcID(self.roleEmotionInfo.ModelId).live2d

    if not _live2d then
        return
    elseif self.elvesNpc then
        self.elvesNpc:removeFromParent()
    end
    
    self.elvesNpc = _live2d
    self.elvesNpc:registerEvents()
    self.elvesNpc:setScale(1.2) 
    
    self._ui.img_npc:getParent():addChild(self.elvesNpc)
    self.elvesNpc:setPosition(self._ui.img_npc:getPosition())
    self.elvesNpc:setZOrder(self._ui.img_npc:getZOrder())
end

function SceondAIChatView:onSendDialogue(data)

    if not data then
        return
    end

    if data.datingType ~= 1 then
        return
    end

    local chatMsg = self:transformDigueStr(data.msg)
    self:updateDialogue(true, chatMsg, true)
end

function SceondAIChatView:onRecvRobotDialogue(data)

    if not data then
        return
    end

    if not data.returnMsg then
        return
    end
    DatingPhoneDataMgr:setHeroForbidState(data.roleId, data.sealState)

    local contentStr = {}
    local likeTab
    if data.type == EC_PhoneChatType.Normal then
        for k,jsonMessage in ipairs(data.returnMsg) do
            local message = json.decode(jsonMessage)
            local messageContent = self:transformDigueStr(message.content)
            local content = string.htmlspecialchars(messageContent)
            local moodid = message.moodid                   ---表情代码
            local faceNum = message.num                     ---表情数量
            local fileName = message.file_name or ""        ---语音文件文件名
            likeTab = {                               
                allowShow = message.allow_ilike == 1,
                isiLike   = message.isilike or 0,
                iLikeNum  = message.ilike_num  or 0,
                iDownNum  = message.idown_num or 0,
                id        = message.replyid,
                type      = message.replytype       } -- 点赞鄙视数据
              
            local faceInfo = DatingPhoneDataMgr:getFaceInfoById(moodid)
            if faceInfo then
                for i=1,faceNum do
                    content = content..faceInfo.sourcecode
                end
            end
            content = self:transformDigueStr(content)
            table.insert(contentStr, {content = content,type = EC_PhoneContentType.Normal,fileName = fileName})
           
            self.keepRoleAction = moodid == 0 and self.keepRoleAction or moodid
        end
    end
    
    if #contentStr == 0 then
        return
    end

    -- 精灵动作判定（写死）
    local function delLive2dFunc()
        local data = DatingPhoneDataMgr:getRoleAttrDataById(self.roleId)
        local hateVal = data and data.hateVal 
        if hateVal then
            if hateVal > 70 and hateVal <= 79 then
                self.keepRoleAction = MODEL_STAGE_ID[70]
            elseif hateVal >=80 and hateVal <= 89 then
                self.keepRoleAction = MODEL_STAGE_ID[80]
            elseif hateVal >= 90 and hateVal <= 99 then
                self.keepRoleAction = MODEL_STAGE_ID[90]
            end
        end

        if self.keepRoleAction == 0 then
            self.keepRoleAction = DEFULT_MODELID
        end
        self:playLive2dAction(self.keepRoleAction)
    end
    
    self:timeOut(function()
        delLive2dFunc()
    end,2.0)
    self:showRobotDialogue(contentStr,likeTab)
    TFDirector:send(c2s.DATING_REQ_AIPROP, {self.roleId})
end

function SceondAIChatView:onRecvRoleAttr()
    local data = DatingPhoneDataMgr:getRoleAttrDataById(self.roleId)

    if not data then
        return
    end

    local loverTxt = data.intimacy and self._ui.lab_lover:getText() or data.intimacy
    self._ui.lab_lover:setText(data.intimacy)

    local connectTxt = data.chatDays and self._ui.lab_connect:getText() or data.chatDays
    self._ui.lab_connect:setText(data.chatDays)

    local reversalTxt = nil
    if data.hateVal then
        -- 反转值升高
        local _txt = self._ui.lab_reversal:getText()
        if _txt then
            local oldReversal = string.split(_txt, "/")[1]
            if tonumber(oldReversal) < data.hateVal and data.hateVal <= 70 then
                self:playLive2dAction(MODEL_UPID)
            end
        end
        reversalTxt = data.hateVal.."/100"
    else
        reversalTxt = self._ui.lab_reversal:getText()
    end
    self._ui.lab_reversal:setText(reversalTxt)
end

function SceondAIChatView:showRobotDialogue(contentStr,likeTab)
    local contentId = 1
    self:updateDialogue(false,contentStr[contentId].content,true,likeTab)

    self:timeOut(function()
        local voiceInfo =  DatingPhoneDataMgr:getVoiceByName(contentStr[contentId].fileName)
        if voiceInfo and not self.isComeFromPhone then
            self.voiceHandle = TFAudio.playSound(voiceInfo.conversionvoice)
        end
    end,2.0)

    if #contentStr > 1 then
        local seqact = Sequence:create({
            DelayTime:create(2.0),
            CallFunc:create(function()
                contentId = contentId + 1
                local voiceInfo =  DatingPhoneDataMgr:getVoiceByName(contentStr[contentId].fileName)
                if voiceInfo and not self.isComeFromPhone then
                    self.voiceHandle = TFAudio.playSound(voiceInfo.conversionvoice)
                end
                self:updateDialogue(false,contentStr[contentId].content,true)

                if contentId >= #contentStr then
                    self._ui.Panel_root:stopAllActions()
                end
            end)
        })
        self._ui.Panel_root:runAction(CCRepeatForever:create(seqact))
    end
end

function SceondAIChatView:playLive2dAction(emotionState)

    if not emotionState then
        return
    end

    local actIds = self.roleEmotionInfo["emotions"..emotionState]
    if not actIds then
        return
    end

    local actIndex = math.random(1,#actIds)
    local actName = DatingPhoneDataMgr:getEmotionActionName(actIds[actIndex],self.roleEmotionInfo.ModelId)
    if not actName then
        return
    end

    self.elvesNpc:newStartAction(actName, EC_PRIORITY.NORMAL)
    self.keepRoleAction = nil
end

-- 加载本地消息
function SceondAIChatView:loadLocalMsg()
    self.chatView:removeAllItems()

    if not DatingPhoneDataMgr:isUsedPhoneAi() then           -- 判断是否第一次使用ai聊天
        local helloStr = TextDataMgr:getText(901177)
        helloStr = "2"..helloStr
        DatingPhoneDataMgr:insertDialogue(self.roleId,helloStr)
        DatingPhoneDataMgr:setUsedAi()
    elseif not self.isHadInSceondAI then   -- 使用过聊天 但是是第一次进入第二ai聊天
        return
    end

    local localDialogue = DatingPhoneDataMgr:getLocalDialogue()
    if not localDialogue then
        return
    end

    local dialogue = localDialogue[self.roleId]
    if not dialogue then
        return
    end

    for k,v in ipairs(dialogue) do
        local dialogueStr = string.sub(v,2,-1)
        local identityId  = tonumber(v[1])
        if identityId == 0 then
            -- self:updateVoice(false,dialogueStr,false,true) 
        else
            dialogueStr = self:transformDigueStr(dialogueStr)
            self:updateDialogue(tonumber(identityId) == 1, dialogueStr)
        end
    end
end

function SceondAIChatView:loadFaceView()
    self.faceView:removeAllItems()
    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
    local lineNum = #self._ui.Panel_face:getChildren()
    local maxHorizatal = math.ceil(#faceCfg / lineNum)

    for i=1, maxHorizatal do

        local faceItem = self._ui.Panel_face_item:clone()
        faceItem:setVisible(true)
        self.faceView:pushBackCustomItem(faceItem)

        for j=1, lineNum do
            local btnFace = faceItem:getChildByName("Button_face_"..j)
            local faceIcon  = btnFace:getChildByName("icon_face")
            local faceId = (i - 1) * lineNum + j
            local faceInfo = faceCfg[faceId]
            if not faceInfo then
                btnFace:setVisible(false)
            else
                btnFace:setVisible(true)
                faceIcon:setTexture(faceInfo.motion)
                btnFace:onClick(function()
                    self:chooseFace(faceInfo.sourcecode)
                end)
            end
        end
    end
    self._ui.pannel_face:setVisible(false)
end

function SceondAIChatView:chooseFace(faceStr)
    self._ui.lab_tip:setVisible(false)
    self.inputView:setVisible(true)
    
    local newInputStr = faceStr
    
    if self.inputTxt then
        newInputStr = self.inputTxt..faceStr
    end
    self:setInputText(newInputStr)
end

function SceondAIChatView:transformDigueStr(inputStr)

    for k,v in ipairs(DatingPhoneDataMgr:getFaceEmotion()) do
        inputStr = string.gsub(inputStr,v.conversioncode,v.specialcode)
    end

    return inputStr
end

-- AI对话
function SceondAIChatView:updateDialogue(isSelf, dialogueStr, isNew, likeTab)

    local inputText = nil

    if not dialogueStr or dialogueStr == "" then
        return
    end
    
    -- 显示进度条
    if #self.chatView:getItems() == 5 then
        self.scrollBar:setVisible(true)
    end

    -- 显示正在输入中
    if not isSelf and isNew then
        inputText = TextDataMgr:getTextAttr(901179).text
    else
        inputText = dialogueStr
    end

    local roleInfo = DatingPhoneDataMgr:getRoleInfoById(self.roleId)
    local headIcon = roleInfo.icon
    local cell = isSelf and self._ui.msg_rcell:clone() or self._ui.msg_lcell:clone()
    cell:setVisible(true)

    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()

    for k,v in ipairs(faceCfg) do
        inputText = string.gsub(inputText,v.specialcode,v.convermotion)
    end

    inputText = string.gsub(inputText, "\n", "<br/>")
    inputText = string.gsub(inputText, "amp;", "")

    local Image_msg = TFDirector:getChildByPath(cell,"Image_msg")
    local rightText = TFRichText:create(ccs(410, 0))
    
    local pos = isSelf and ccp(-20,-17) or ccp(20,-17)
    if isSelf then
        rightText:AnchorPoint(me.p(1, 1))
    else
        rightText:AnchorPoint(me.p(0, 1))
    end
    rightText:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r301010"),inputText))
    rightText:setPosition(pos)
    Image_msg:addChild(rightText)
    
    local disWidth = 38
    local disHeight = 35

    local size = rightText:getSize()
    local newHight = size.height <= 25 and 25 or size.height
    local imgWidth = size.width + disWidth
    Image_msg:setContentSize(CCSizeMake(imgWidth < 150 and 150 or imgWidth, newHight + disHeight))
    cell:setContentSize(CCSizeMake(585, newHight + 54))
    self.chatView:insertCustomItem(cell, 1)
    self.chatView:jumpToTop()
    
    local function refreshCell()
        inputText = dialogueStr
        for k,v in ipairs(faceCfg) do
            inputText = string.gsub(inputText,v.specialcode,v.convermotion)
        end
        inputText = string.gsub(inputText, "\n", "<br/>")
        inputText = string.gsub(inputText, "amp;", "")
        rightText:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r301010"),inputText)) 
        local size = rightText:getSize()
        local newHight = size.height <= 25 and 25 or size.height
        local pannelMsgWidth = self._ui.pannelMsgTeachBtns:getContentSize().width
        local width = size.width + disWidth <= pannelMsgWidth and pannelMsgWidth or (size.width + disWidth)

        -- 点赞、鄙视、前往调教按钮
        if likeTab and likeTab.allowShow then
            local msgTeachPannel = self._ui.pannelMsgTeachBtns:clone()
            local btn_good = msgTeachPannel:getChildByName("btn_good")
            local img_btnGood = msgTeachPannel:getChildByName("img_btnGood")
            local labGood  = btn_good:getChildByName("num")
            local btn_bad  = msgTeachPannel:getChildByName("btn_bad")
            local img_btnBad = msgTeachPannel:getChildByName("img_btnBad")
            local labBad   = btn_bad:getChildByName("num")
            local btn_goToTeach = msgTeachPannel:getChildByName("btn_goToTeach")
            btn_goToTeach:setVisible(false)
            local dis = 5

            -- 按钮点击资源替换
            local function btnClickResrefresh()
                if btn_good.isHaveCilck then
                    img_btnGood:setTexture("ui/iphoneX/secondAIChat/35.png")
                    btn_good:setTextureNormal("ui/iphoneX/secondAIChat/33.png")
                else
                    img_btnGood:setTexture("ui/iphoneX/secondAIChat/27.png")
                    btn_good:setTextureNormal("ui/iphoneX/secondAIChat/29.png")
                end
                if btn_bad.isHaveCilck then
                    img_btnBad:setTexture("ui/iphoneX/secondAIChat/34.png")
                    btn_bad:setTextureNormal("ui/iphoneX/secondAIChat/32.png")
                else
                    img_btnBad:setTexture("ui/iphoneX/secondAIChat/28.png")
                    btn_bad:setTextureNormal("ui/iphoneX/secondAIChat/30.png")
                end
            end
            -- 点赞、鄙视点击方法
            local function teachClickFucn(sender)
                -- 点赞动作
                local function clickActionFunc(txt, showTip)
                    local txtTemp = txt:clone()
                    txtTemp:setText(showTip)
                    txtTemp:setScale(0.9)
                    -- txtTemp:setColor(ccc3(224,73,12))
                    txt:getParent():addChild(txtTemp, 99)
                    txtTemp:setPosition(ccp(txt:getPositionX() - 5,txt:getPositionY() + 5))
                    txtTemp:runAction(Sequence:create({
                        MoveBy:create(0.4, ccp(0,40)),
                        FadeIn:create(0.2),
                        FadeOut:create(0.2),
                        CallFunc:create(function()
                            txtTemp:removeFromParent()
                        end)}))
                end

                local txt = sender:getChildByName("num")
                txt:stopAllActions()
                if not sender.isHaveCilck then
                    sender.isHaveCilck = true
                    if txt:getString() ~= "999+" then
                        txt:setText(tonumber(txt:getString()) + 1) 
                    end
                    clickActionFunc(txt, "+1")
                    if sender:getName() == "btn_bad" and RoleTeachDataMgr:canTeachRole() then
                        btn_goToTeach:setVisible(true)
                    end
                else
                    sender.isHaveCilck = false
                    if txt:getString() ~= "999+" then
                        txt:setText(tonumber(txt:getString()) - 1)
                    end
                    clickActionFunc(txt, "-1")
                    if sender:getName() == "btn_bad" then
                        btn_goToTeach:setVisible(false)
                    end
                end
                btnClickResrefresh()
            end  

            Image_msg:setContentSize(CCSizeMake(width, newHight + disHeight + 10))
            btn_goToTeach:setPositionX(Image_msg:getContentSize().width - dis)
            -- isilike 0 未点击 1点赞 2鄙视
            if likeTab.isiLike == 0 then
                btn_good.isHaveCilck = false
                btn_bad.isHaveCilck  = false
            elseif likeTab.isiLike == 1 then
                btn_good.isHaveCilck = true
                btn_bad.isHaveCilck  = false
            elseif likeTab.isiLike == 2 then
                btn_good.isHaveCilck = false
                btn_bad.isHaveCilck  = true
            end
            btnClickResrefresh()
            labGood:setText(likeTab.iLikeNum >= 1000 and "999+" or likeTab.iLikeNum)
            labBad:setText(likeTab.iDownNum >= 1000 and "999+" or likeTab.iDownNum)

            btn_good:onClick(function(sender)
                if sender.isHaveCilck and not btn_bad.isHaveCilck then -- 点过赞
                    RoleTeachDataMgr:SendIsLike(self.keepLastInputTxt,dialogueStr,0)
                elseif not sender.isHaveCilck and not btn_bad.isHaveCilck then -- 都没点过
                    RoleTeachDataMgr:SendIsLike(self.keepLastInputTxt,dialogueStr,1)
                elseif not sender.isHaveCilck and btn_bad.isHaveCilck then -- 点过鄙视的情况下
                    RoleTeachDataMgr:SendIsLike(self.keepLastInputTxt,dialogueStr,0)
                    RoleTeachDataMgr:SendIsLike(self.keepLastInputTxt,dialogueStr,1)
                    teachClickFucn(btn_bad)
                end
                teachClickFucn(sender)
            end)
            btn_bad:onClick(function(sender)
                if sender.isHaveCilck and not btn_good.isHaveCilck  then
                    RoleTeachDataMgr:SendIsLike(self.keepLastInputTxt,dialogueStr,0)
                elseif not sender.isHaveCilck and not btn_good.isHaveCilck then
                    RoleTeachDataMgr:SendIsLike(self.keepLastInputTxt,dialogueStr,2)
                elseif not sender.isHaveCilck and btn_good.isHaveCilck then
                    RoleTeachDataMgr:SendIsLike(self.keepLastInputTxt,dialogueStr,0)
                    RoleTeachDataMgr:SendIsLike(self.keepLastInputTxt,dialogueStr,2)
                    teachClickFucn(btn_good)
                end
                teachClickFucn(sender)
            end)
            btn_goToTeach:onClick(function()
                Utils:openView("datingPhone.RoleTeachFuncLayer", 
                    self.roleId,
                    RoleTachMacro.PAGETYPE.TEACH,
                    RoleTachMacro.TEACH.TeachSelf,
                    self.keepLastInputTxt,
                    nil,
                    likeTab.id,
                    likeTab.type
                )
            end)
            Image_msg:addChild(msgTeachPannel)
            msgTeachPannel:setPosition(ccp(dis, -Image_msg:getContentSize().height + dis))

            cell:setContentSize(CCSizeMake(585, newHight + 54 + 10))
        else
            Image_msg:setContentSize(CCSizeMake(width, newHight + disHeight))
            cell:setContentSize(CCSizeMake(585, newHight + 54))
        end

        self.chatView:doLayout()
    end

    if not isSelf and isNew then
        self:timeOut(function()
            refreshCell()
        end, 2.0)
    end

    if isNew and not self.isComeFromPhone then
        local str = dialogueStr
        if isSelf then
            str = EC_PhoneSaveType.oneself..str
        else
            str = EC_PhoneSaveType.robot..str
        end
        DatingPhoneDataMgr:insertDialogue(self.roleId, str)
    end
    
end

return SceondAIChatView