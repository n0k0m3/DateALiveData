local GiftsView = class("GiftsView",BaseLayer)
local speAcData = TabDataMgr:getData("SpecialAction")
local giftTable = TabDataMgr:getData("Item")
local DatingConfig = require("lua.logic.dating.DatingConfig")
local live2dConfig = DatingConfig.live2dConfig

function GiftsView:initData(data)
    self.roleModelId = RoleDataMgr:getModel(RoleDataMgr:getCurId())
    --self.giftsId_ = RoleDataMgr:getGiftIdList()
    self.giftsId_ = {}
    for i, v in ipairs(RoleDataMgr:getAllGoodInfoList()) do
        if GoodsDataMgr:getItemCount(v.id) > 0 then
            table.insert(self.giftsId_,v.id)
        end
    end
    self.useRoleInfo = clone(RoleDataMgr:getCurRoleInfo())
    self.isGray = false
    self.isPlay = true
    self.giftWaitVoice = nil
end

function GiftsView:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)

    self:init("lua.uiconfig.dating.giftsView")
end

function GiftsView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Image_bg = TFDirector:getChildByPath(self.ui,"Image_bg"):hide()
    self:showRoom()

    self:initPrefab()
    self:initRole()
    self:initMoodView()
    self:initFavorView()
    self:initGiftTip()
    self:initScrollView()
    self:timeOut(function() self:showScrollView() end,0.3)

    self:playGiftWaitVoice()

    self.topLayer:show()

    self:setBackBtnCallback(function()
            if self.voiceHandle then
                TFAudio.stopEffect(self.voiceHandle)
            end
             if self.closeCallBack then
                 self.closeCallBack()
             end
             AlertManager:closeLayer(self)
        end)
    self.voiceHandle = VoiceDataMgr:playVoice("button_gift",RoleDataMgr:getCurId())
end

function GiftsView:showRoom()
    if self.roomView_ then
        self.roomView_:removeFromParent()
        self.roomView_ = nil
    end
    self.roomView_ = require("lua.logic.dating.RoomView"):new()
    self.Image_bg:hide()
    self.Image_bg:getParent():addChild(self.roomView_,self.Image_bg:getZOrder())
end

function GiftsView:initGiftTip()
    self.giftsLayer = require("lua.logic.dating.giftsLayer"):new()
    self.giftsLayer:hide()
    self:addLayer(self.giftsLayer,999)
end

function GiftsView:initPrefab()
    self.Panel_prefab = TFDirector:getChildByPath(self.ui,"Panel_prefab")
end

function GiftsView:initScrollView()
    self.Panel_table = TFDirector:getChildByPath(self.ui,"Panel_table")
    self.Panel_Item = TFDirector:getChildByPath(self.Panel_prefab,"Panel_Item")

    local scrollView = TFDirector:getChildByPath(self.ui,"ScrollView_gifts")
    self.listView = UIListView:create(scrollView)

    self.Panel_table.savePos = self.Panel_table:Pos()
    self.Panel_table:Pos(self.Panel_table.savePos + ccp(500,0))

    self:loadScrollViewData()
end

function GiftsView:loadScrollViewData()
    self.listView:removeAllItems()

    for i, v in ipairs(self.giftsId_) do
        local id = v
        local item = self.Panel_Item:clone()
        item.id = id
        self:initItem(item)
        self:updateItem(item)
        self.listView:pushBackCustomItem(item)
    end

    self:bindItemsTouchEvent()
end

function GiftsView:initItem(item)
    local icon = TFDirector:getChildByPath(item,"Image_item")
    icon.saveScale = icon:Scale()
    icon.savePos = icon:Pos()
    icon.logic = item
    item.icon = icon

    local labelNum = TFDirector:getChildByPath(item,"Label_num")
    item.labelNum = labelNum

    local idx = 0
    while true do
        idx = idx + 1
        local star = TFDirector:getChildByPath(item,"Image_star_"..idx)
        if star then
            item.starList = item.starList or {}
            table.insert(item.starList,star)
        else
            break
        end
    end
end

function GiftsView:updateItem(item)
    local id = item.id
    local data = giftTable[id]
    if not data then
        Box("数据为空，id: ".. id)
        return
    end

    item.type = data.subType
    --品质
    item.grade = data.quality

    item.icon:setTexture(data.icon)
    item.num = GoodsDataMgr:getItemCount(id)
    item.labelNum:setText(item.num)

    local itemCfg = GoodsDataMgr:getItemCfg(id)
    for i, v in ipairs(item.starList) do
        local visible = i <= itemCfg.star
        v:setVisible(visible)
    end
end

function GiftsView:bindItemsTouchEvent()
    if self.listView and table.count(self.listView:getItems()) ~= 0 then
        for i, v in ipairs(self.listView:getItems()) do
            local item = v
            self:bindItemTouchEvent(item)
        end
    end
end

function GiftsView:bindItemTouchEvent(item)
    item.icon:Touchable(true)
    item.icon:onTouch(function(event)
        self:onTouch(event)
    end)
end

function GiftsView:onTouch(event)
    local name = event.name
    local target = event.target
    local pos = nil
    if name == "began" then
        pos = target:getTouchStartPos()
        self:onTouchBegan(target,pos)
        self.elvesNpc:handleTouchBegan(pos.x, pos.y)
    elseif name == "moved" then
        pos = target:getTouchMovePos()
        self:onTouchMoved(target,pos)
        self.elvesNpc:handleTouchBegan(pos.x, pos.y)
    elseif name == "ended" then
        pos = target:getTouchEndPos()
        self:onTouchEnded(target,pos)
        self.elvesNpc:handleTouchBegan(pos.x, pos.y)
    end
end

function GiftsView:onTouchBegan(sender,pos)
    local item = sender.logic
    self.ui:stopAllActions()
    if self.giftWaitVoice then
        TFAudio.stopEffect(self.giftWaitVoice)
        self.giftWaitVoice = nil
    end
    self:playGiftWaitVoice()

    if RoleDataMgr:isFavorReachCriticality() then
        Utils:showTips(304002)
        return
    else
        if RoleDataMgr:isFavorReachMaxValue() then
            -- local name = TextDataMgr:getTextAttr(RoleDataMgr:getRoleInfo().nameId).text
            -- local str = string.format(TextDataMgr:getTextAttr(900307).text,name)
            -- Utils:showTips(str)
        end
    end

    if not sender.mobileIcon then
        local mobileIcon = item.icon:clone()
        mobileIcon:AnchorPoint(mobileIcon:AnchorPoint())
        mobileIcon:setZOrder(200)
        self.ui:addChild(mobileIcon)
        mobileIcon:setScale(1.0)
        mobileIcon:setPosition(pos)
        self.listView:setBounceEnabled(false)
        sender.mobileIcon = mobileIcon

        item.num = item.num - 1
        item.labelNum:setText(item.num)

        item.beganPos = item:Pos()

        item:setOpacity(100)

        self.giftsLayer:initData(item.id)
        if self.giftsLayer:isVisible() == false then
            self.giftsLayer:show()
        end

        if self.isPlay then
            local sendIdleAcName = ""
            local sendIdleAcTime = 0

            if item.type == 1 then
                sendIdleAcName = self.speData["food"].action
                sendIdleAcTime = self.speData["food"].actionTime or 5
            elseif item.type == 2 then
                sendIdleAcName = self.speData["gift"].action
                sendIdleAcTime = self.speData["gift"].actionTime or 5
            elseif item.type == 3 then
                sendIdleAcName = self.speData["gift"].action
                sendIdleAcTime = self.speData["gift"].actionTime or 5
            end
            self.elvesNpc:newStartAction(sendIdleAcName,EC_PRIORITY.FORCE,sendIdleAcTime,sendIdleAcName,sendIdleAcTime*1000)
        end
    end
end

function GiftsView:playGiftWaitVoice()
    if self.isPlay then
        local seq = Sequence:create({
            DelayTime:create(8),
            CallFunc:create(function()
                self.giftWaitVoice = VoiceDataMgr:playVoice("gifts_wait",RoleDataMgr:getCurId())
            end)
        })
        local action = RepeatForever:create(seq)
        self.ui:runAction(action)
    end
end

function GiftsView:onTouchMoved(sender, pos)
    if not sender.mobileIcon then
        return
    end
    sender.mobileIcon:Pos(self.ui:convertToNodeSpace(pos))
end
function GiftsView:onTouchEnded(sender, pos)
    if sender.mobileIcon == nil then
        return
    end

    --将世界坐标转换为live2d坐标
    pos.x = self.elvesNpc:transformViewX(pos.x)
    pos.y = self.elvesNpc:transformViewY(pos.y)
    self:checkNpc(pos.x,pos.y)
    local item = sender.logic
    local function refreshTableTouch()
        self.listView:setBounceEnabled(true)
        sender:setTouchEnabled(not self.isGray)
        sender.mobileIcon = nil
        sender:getParent():setOpacity(255)
        if self.elvesNpc.isCheck == false then
            item.num = item.num + 1
            item.labelNum:setString(item.num)
            local sendName = live2dConfig.MOTION_GROUP_IDLE_SEND
            local time = live2dConfig.MOTION_GROUP_IDLE_SEND_TIME
            self.elvesNpc:newStartAction(sendName,EC_PRIORITY.FORCE,time,sendName,time*1000)
        else
            if item.num == 0 then
                table.removeItem(self.giftsId_,item.id)
                self.dataNum = table.count(self.giftsId_)

                self:loadScrollViewData()
            end
            self:playNpcAnimation(item.grade,item.type)
        end
        if self.giftsLayer:isVisible() == true then
            self.giftsLayer:setVisible(false)
        end
    end

    if self.elvesNpc.isCheck == true then
        RoleDataMgr:sendDonate(self.useRoleInfo.sid,item.id,1)

        local spawnAc = {
            MoveTo:create(0.3,DatingConfig.centerPos),
            ScaleTo:create(0.3,0.1)
        }
        local ac = {
            CCSpawn:create(
                    spawnAc
            ),
            CallFunc:create(refreshTableTouch),
            RemoveSelf:create()
        }
        sender.mobileIcon:runAction(CCSequence:create(ac))
    else
        local moveWorldPos = sender:getParent():convertToWorldSpace(sender.savePos)
        local movePos = self.ui:convertToNodeSpace(moveWorldPos)
        movePos = ccp(movePos.x + sender:Size().height/2,movePos.y + sender:Size().height/2)
        local ac = {
            MoveTo:create(0.3,movePos),
            FadeOut:create(0.1),
            CallFunc:create(refreshTableTouch),
            RemoveSelf:create()
        }
        sender.mobileIcon:runAction(CCSequence:create(ac))
    end

    sender:setTouchEnabled(false)
end

function GiftsView:checkNpc(x,y)
    self.elvesNpc.checkStr = ""
    local idx = 0
    self.elvesNpc.isCheck = true
    if self.elvesNpc:checkHit(idx, EC_HIT_AREA_NAME.HEAD, x, y) then
        self.elvesNpc.checkStr = EC_HIT_AREA_NAME.HEAD
    elseif self.elvesNpc:checkHit(idx, EC_HIT_AREA_NAME.BODY, x, y) then
        self.elvesNpc.checkStr = EC_HIT_AREA_NAME.BODY
    elseif self.elvesNpc:checkHit(idx, EC_HIT_AREA_NAME.FUBU, x, y) then
        self.elvesNpc.checkStr = EC_HIT_AREA_NAME.FUBU
    elseif self.elvesNpc:checkHit(idx, EC_HIT_AREA_NAME.TUI, x, y) then
        self.elvesNpc.checkStr = EC_HIT_AREA_NAME.TUI
    elseif self.elvesNpc:checkHit(idx, EC_HIT_AREA_NAME.HAND_R, x, y) then
        self.elvesNpc.checkStr = EC_HIT_AREA_NAME.HAND_R
    elseif self.elvesNpc:checkHit(idx, EC_HIT_AREA_NAME.HAND_L, x, y) then
        self.elvesNpc.checkStr = EC_HIT_AREA_NAME.HAND_L
    else
        self.elvesNpc.isCheck = false
    end
end

function GiftsView:playNpcAnimation(itemGrade,sendType)

    if not self.isPlay then
        return
    end

    local likeFoodName = self.speData["lovefood"].action
    local noLikeFoodName = self.speData["likefood"].action
    local likeGiftName = self.speData["lovegift"].action
    local noLikeGiftName = self.speData["likegift"].action

    local likeFoodTime = self.speData["lovefood"].actionTime or 3
    local noLikeFoodTime = self.speData["likefood"].actionTime or 3
    local likeGiftTime = self.speData["lovegift"].actionTime or 3
    local noLikeGiftTime = self.speData["likegift"].actionTime or 3

    local likeFoodVoice = self.speData["lovefood"].voice
    local noLikeFoodVoice = self.speData["likefood"].voice
    local likeGiftVoice = self.speData["lovegift"].voice
    local noLikeGiftVoice = self.speData["likegift"].voice

    local sendName = self.speData["give"].action
    local interval = (self.speData["give"].actionTime or 3) * 1000

    self.voiceHandle = nil
    local deyTime = 0
    if sendType == 1 then
        if itemGrade > 2 then
            self.elvesNpc:newStartAction(likeFoodName,EC_PRIORITY.FORCE,likeFoodTime,sendName,interval)
            -- self.elvesNpc:playVoice(string.format("sound/role/%s.mp3",likeFoodVoice))
            self.voiceHandle = VoiceDataMgr:playVoice("food_high",RoleDataMgr:getCurId())
            deyTime = likeFoodTime
        else
            self.elvesNpc:newStartAction(noLikeFoodName,EC_PRIORITY.FORCE,noLikeFoodTime,sendName,interval)
            -- self.elvesNpc:playVoice(string.format("sound/role/%s.mp3",likeFoodVoice))
            self.voiceHandle = VoiceDataMgr:playVoice("food_low",RoleDataMgr:getCurId())
            deyTime = noLikeFoodTime
        end
    elseif sendType == 2 then
        if itemGrade > 2 then
            self.elvesNpc:newStartAction(likeGiftName,EC_PRIORITY.FORCE,likeGiftTime,sendName,interval)
            -- self.elvesNpc:playVoice(string.format("sound/role/%s.mp3",likeGiftVoice))
            self.voiceHandle = VoiceDataMgr:playVoice("gift_high",RoleDataMgr:getCurId())
            deyTime = likeGiftTime
        else
            self.elvesNpc:newStartAction(noLikeGiftName,EC_PRIORITY.FORCE,noLikeGiftTime,sendName,interval)
            -- self.elvesNpc:playVoice(string.format("sound/role/%s.mp3",noLikeGiftVoice))
            self.voiceHandle = VoiceDataMgr:playVoice("gift_low",RoleDataMgr:getCurId())
            deyTime = noLikeGiftTime
        end
    elseif sendType == 3 then
        if itemGrade > 2 then
            self.elvesNpc:newStartAction(likeGiftName,EC_PRIORITY.FORCE,likeGiftTime,sendName,interval)
            -- self.elvesNpc:playVoice(string.format("sound/role/%s.mp3",likeGiftVoice))
            self.voiceHandle = VoiceDataMgr:playVoice("gift_high",RoleDataMgr:getCurId())
            deyTime = likeGiftTime
        else
            self.elvesNpc:newStartAction(noLikeGiftName,EC_PRIORITY.FORCE,noLikeGiftTime,sendName,interval)
            -- self.elvesNpc:playVoice(string.format("sound/role/%s.mp3",noLikeGiftVoice))
            self.voiceHandle = VoiceDataMgr:playVoice("gift_low",RoleDataMgr:getCurId())
            deyTime = noLikeGiftTime
        end
    end

    local function setGray()
        self.isGray = true
        self:loadScrollViewData()
    end
    local function setNoGray()
        self.isGray = false
        self:loadScrollViewData()
    end

    local function setPlay()
        self.isPlay = true
        self.voiceHandle = nil
    end
    local function setNoPlay()
        self.isPlay = false
    end

    local acGray = {
        -- CallFunc:create(setGray),
        CallFunc:create(setNoPlay),
        DelayTime:create(deyTime),
        -- CallFunc:create(setNoGray)
        CallFunc:create(setPlay)
    }

    self:runAction(CCSequence:create(acGray))
end

function GiftsView:showScrollView()

end

function GiftsView:hideScrollView()

end

function GiftsView:initRole()

    self.speData = clone(speAcData[RoleDataMgr:getCurId()])
    local sendName = self.speData["give"].action
    -- local time = self.speData["give"].actionTime*2

    local Image_npc = TFDirector:getChildByPath(self.ui,"Image_npc")
    self.elvesNpc = ElvesNpcTable:createLive2dNpcID(self.roleModelId,false,false,sendName).live2d

    -- self.elvesNpc:setScale(self.elvesNpc.defaultScale*1.5)
    self.elvesNpc:setScale(0.7)
    Image_npc:getParent():addChild(self.elvesNpc)
    self.elvesNpc:setZOrder(Image_npc:getZOrder())
    local pos = Image_npc:Pos()
    self.elvesNpc:setPosition(pos)
    Image_npc:hide()

    self.elvesNpc:hide()
    self.ui:timeOut(function()
        self.elvesNpc:playIn(0.3)
        end,0.2)
end

function GiftsView:initFavorView()
    local Panel_goodFeeling = TFDirector:getChildByPath(self.ui, "Panel_goodFeeling"):hide()
    local data = {}
    data.isHide = true
    data.pos = Panel_goodFeeling:Pos()
    data.isShowFavorUp = true
    self.favorView = require("lua.logic.dating.FavorView"):new(data);
    self:addLayerToNode(self.favorView,Panel_goodFeeling:getParent(),1);
    self.favorView:setZOrder(100)
end

function GiftsView:initMoodView()
    local Image_mood = TFDirector:getChildByPath(self.ui,"Image_mood"):hide()
    local data = {}
    data.isHide = true
    data.pos = Image_mood:Pos()
    self.moodView        = require("lua.logic.dating.MoodView"):new(data);
    self:addLayerToNode(self.moodView,Image_mood:getParent(),1);
    self.moodView:setZOrder(100)
end

function GiftsView:setCloseCallback(callBack)
    self.closeCallBack = callBack
end

function GiftsView:onShow()
    self.super.onShow(self)

    self:enterAction()
end

function GiftsView:enterAction()
    local time = 0.2
    local tableAc = {
        DelayTime:create(time),
        MoveTo:create(0.5,self.Panel_table.savePos)
    }
    self.Panel_table:runAction(CCSequence:create(tableAc))
end

function GiftsView:onClose()
    self.super.onClose(self)
    print("GiftsView:onClose()")
end

function GiftsView:registerEvents()
    self.super.registerEvents(self)
end

return GiftsView
