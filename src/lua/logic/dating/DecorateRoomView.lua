local DecorateRoomView = class("DecorateRoomView",BaseLayer)

function DecorateRoomView:initData(data)
    self.roomListData_ = RoleDataMgr:getRoleRoomInfoList()
    print("self.roomListData_---------- ",self.roomListData_)
    self.selectIndex_ = RoleDataMgr:getRoleUseRoomIdx() or 1
    self.roleId = RoleDataMgr:getCurId()
    self.roomView_ = nil
    self.effectListItem = {}
    self.isShowUnLockBtn = true
end

function DecorateRoomView:ctor(data)
    self.super.ctor(self,data)

    self:initData()

    self:init("lua.uiconfig.dating.decorateRoomView")
end

function DecorateRoomView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Image_bg = TFDirector:getChildByPath(self.ui,"Image_bg"):hide()
    self.Panel_room = TFDirector:getChildByPath(self.ui,"Panel_room")

    self:initRole()
    self:initPrefab()
    self:initRoomInfo()
    self:initRoomUnLockInfo()
    self:initPanelScroll()

    self:setBackBtnCallback(function()
            if self.voiceHandle then
                TFAudio.stopEffect(self.voiceHandle)
            end
            TFAudio.stopMusic()
            TFAudio.playBmg("sound/bgm/date_003.mp3",true)
             if self.closeCallBack then
                 self.closeCallBack()
             end
             AlertManager:closeLayer(self)
        end)

   self.voiceHandle = VoiceDataMgr:playVoice("button_room",RoleDataMgr:getCurId())
end

function DecorateRoomView:initRole(modelId,scale)
    local speAcData = TabDataMgr:getData("SpecialAction")
    local speData = clone(speAcData[self.roleId])
    local acName = speData["room"].action

    local modelId = RoleDataMgr:getModel(self.roleId)
    local Image_npc = TFDirector:getChildByPath(self.ui,"Image_npc")
    self.elvesNpc = ElvesNpcTable:createLive2dNpcID(modelId,false,false,acName).live2d
    self.elvesNpc:setScale(0.7)
    Image_npc:getParent():addChild(self.elvesNpc)
    self.elvesNpc:setZOrder(Image_npc:getZOrder())
    local pos = Image_npc:Pos()
    self.elvesNpc:Pos(pos)
    Image_npc:hide()

    self.elvesNpc:hide()
    self.ui:timeOut(function()
        self.elvesNpc:playIn(0.3)
        end,0.2)
end

function DecorateRoomView:initPanelScroll()
    self.Panel_scroll = TFDirector:getChildByPath(self.ui,"Panel_scroll")
    self:initRoomScroll()

    self:loadRoomScroll()
end

function DecorateRoomView:initRoomScroll()
    local ScrollView_room = TFDirector:getChildByPath(self.Panel_scroll,"ScrollView_room")
    self.roomScroll = UIListView:create(ScrollView_room)
end

function DecorateRoomView:initPrefab()
    self.Panel_prefab = TFDirector:getChildByPath(self.ui,"Panel_prefab")
    self.Panel_roomItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_roomItem")
    self.Panel_goodItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_goodItem")
    self.Image_effectItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_effectItem")
end

function DecorateRoomView:loadRoomScroll()
    self.roomScroll:removeAllItems()

    for i,v in ipairs(self.roomListData_) do
        local roomItem = self.Panel_roomItem:clone()
        self:initRoomItem(roomItem,v)
        self:updateRoomItem(roomItem,i)
        self.roomScroll:pushBackCustomItem(roomItem)
    end
end

function DecorateRoomView:initRoomItem(roomItem,roomData)
    local Image_room = TFDirector:getChildByPath(roomItem,"Image_room")
    Image_room:setTexture(roomData.roomIcon)
    Image_room:Size(230,130)
    local name = TFDirector:getChildByPath(roomItem,"Label_name")
    name:setTextById(roomData.nameTextId)

    -- local clip = CCClippingNode:create()
    -- -- clip:setInverted(true)
    -- clip:Pos(Image_room:Pos())
    -- clip:AnchorPoint(Image_room:AnchorPoint())
    -- clip:setAlphaThreshold(0.5)
    -- Image_room:getParent():Add(clip,1)
    -- local icon = TFImage:create(roomData.roomIcon)
    -- icon:Size(220,130)
    -- clip:Add(icon)
    -- local stencil = TFImage:create("ui/883.png")
    -- clip:setStencil(stencil)
    -- Image_room:RemoveSelf()
    -- roomItem.icon = clip
    roomItem.icon = Image_room
end

function DecorateRoomView:refreshRoomScroll()
    for i,v in ipairs(self.roomScroll:getItems()) do
        self:updateRoomItem(v,i)
    end
end

function DecorateRoomView:updateRoomItem(roomItem,idx)
    local isSelect = self.selectIndex_ == idx
    if isSelect then
        self:changeShowOne()
    end
    local roomData = self.roomListData_[idx]

    local Image_select = TFDirector:getChildByPath(roomItem,"Image_select")
    Image_select:setVisible(isSelect)
    local Image_noSelect = TFDirector:getChildByPath(roomItem,"Image_noSelect")
    Image_noSelect:setVisible(not isSelect)
    local Panel_changeItem = TFDirector:getChildByPath(roomItem,"Panel_changeItem")
    local Image_moodIcon = TFDirector:getChildByPath(roomItem,"Image_moodIcon"):hide()
    local Label_lock = TFDirector:getChildByPath(roomItem,"Label_lock")
    local Image_use = TFDirector:getChildByPath(roomItem,"Image_use"):hide()

    local roomId = RoleDataMgr:getRoleRoomInfoId(idx)
    local roomByRoleId = RoleDataMgr:getRoomByRoleUse(roomId)
    if roomByRoleId then
        if idx ~= 1 then
            local moodIconPath = RoleDataMgr:getRoleInfo(roomByRoleId).moodPath
            local moodLevel = RoleDataMgr:getRoleInfo(roomByRoleId).moodLevel
            local moodIconName = string.format("%s%d.png",moodIconPath,moodLevel)
            Image_moodIcon:setTexture(moodIconName)
            Image_moodIcon:show()
        end
        Image_use:show()
    end

    for i=1,5 do
        local str = string.format("Image_star%02d",i)
        local starItem = TFDirector:getChildByPath(roomItem,str)
        if self.roomListData_[idx].star >= i then
            starItem:show()
        else
            starItem:hide()
        end
    end

    if not roomData.isUnLock then
        Panel_changeItem:setColor(me.c3b(0x80,0X80,0X80))
        Label_lock:show()
    else
        Panel_changeItem:setColor(me.c3b(0xFF,0XFF,0XFF))
        Label_lock:hide()
    end
end

function DecorateRoomView:selectRoom(idx)
    if self.selectIndex_ == idx then
        return
    else
        self.selectIndex_ = idx
        self:refreshRoomScroll()
    end
end

function DecorateRoomView:changeShowOne(idx)
    idx = idx or self.selectIndex_
    local roomData = self.roomListData_[idx]
    self.Image_bg:setTexture(roomData.roomBg)

    self:checkRoomUnLock(idx)

    self:refreshRoomOne(idx)

    self:loadGoodsScroll()
end

function DecorateRoomView:checkRoomUnLock(idx)
    idx = idx or self.selectIndex_
    local roomData = self.roomListData_[idx]
    self.Image_bg:setTexture(roomData.roomBg)

    if roomData.isUnLock then
        self:showRoomInfo()
        self:hideRoomUnlockInfo()
    else
        self:hideRoomInfo()
        self:showRoomUnlockInfo()
    end
end

function DecorateRoomView:showRoomInfo()
    self.Image_roomInfo:show()
    self:refreshRoomInfo()
end

function DecorateRoomView:hideRoomInfo()
    self.Image_roomInfo:hide()
end

function DecorateRoomView:showRoomUnlockInfo()
    self.Image_roomUnlockInfo:show()
    self:refreshRoomUnLockInfo()
end

function DecorateRoomView:hideRoomUnlockInfo()
    self.Image_roomUnlockInfo:hide()
end

function DecorateRoomView:changeRoom(idx)
    idx = idx or self.selectIndex_
    local roomId = RoleDataMgr:getRoleRoomInfoId(idx)
    local roomByRoleId = RoleDataMgr:getRoomByRoleUse(roomId)

    if roomByRoleId and idx ~= 1 then
        local view = Utils:openView("common.ChooseMessageBox")
        view:setCallback(function()
                RoleDataMgr:changeRoleRoom(idx)
                VoiceDataMgr:playVoice("room_confirm",RoleDataMgr:getCurId())
        end)
        local name = TextDataMgr:getTextAttr(RoleDataMgr:getRoleInfo(roomByRoleId).nameId).text
        view:setRContent("r50005",name)
    else
        RoleDataMgr:changeRoleRoom(idx)
        VoiceDataMgr:playVoice("room_confirm",RoleDataMgr:getCurId())
    end
end

function DecorateRoomView:onChangeRoleRoom()
    self:checkRoom()
    self:refreshRoomScroll()
end

function DecorateRoomView:refreshRoomOne(idx)
    if self.roomView_ then
        self.roomView_:removeFromParent()
        self.roomView_ = nil
    end

    self.roomView_ = require("lua.logic.dating.RoomView"):new(self.roomListData_[idx].id,self.elvesNpc,true)
    self.Panel_room:addChild(self.roomView_)
end

function DecorateRoomView:initRoomInfo()
    self.Image_roomInfo = TFDirector:getChildByPath(self.ui,"Image_roomInfo"):hide()
    self.Image_roomInfo.saveSize = self.Image_roomInfo:Size()

    self.Button_preview = TFDirector:getChildByPath(self.Image_roomInfo,"Button_preview")
    self.Button_preview.isClick = true
    self.Button_change = TFDirector:getChildByPath(self.Image_roomInfo,"Button_change")
    self.Button_change.isClick = false

    self.Image_roomInfo.Panel_bottom01 = TFDirector:getChildByPath(self.Image_roomInfo,"Panel_bottom01")
    self.Image_roomInfo.Panel_bottom01.savePos = self.Image_roomInfo.Panel_bottom01:Pos()
    self.Image_roomInfo.Image_bottom02 = TFDirector:getChildByPath(self.Image_roomInfo,"Image_bottom02"):hide()

    self:checkRoom()
end

function DecorateRoomView:checkRoom()
    local useRoomId = RoleDataMgr:getRoleUseRoomId()
    local toRoomId = RoleDataMgr:getRoleRoomInfoId(self.selectIndex_)
    self.Button_change:setGrayEnabled(toRoomId == useRoomId)
    self.Button_change:setTouchEnabled(toRoomId ~= useRoomId)
end

function DecorateRoomView:refreshRoomInfo()
    local roomData = self.roomListData_[self.selectIndex_]
    local Label_name = TFDirector:getChildByPath(self.Image_roomInfo,"Label_name")
    Label_name:setTextById(roomData.nameTextId)
    local Label_des = TFDirector:getChildByPath(self.Image_roomInfo,"Label_des")
    Label_des:setTextById(roomData.desTextId)


    local effectList = roomData.effectTextId

    for i,v in ipairs(self.effectListItem) do
        v:removeFromParent()
    end
    self.effectListItem = {}

    local effectHeight = self.Image_roomInfo.Image_bottom02:Size().height

    local effectPos = self.Image_roomInfo.Image_bottom02:Pos()
    local effectDis = 2
    local disHeight = 0
    for i,v in ipairs(effectList) do
        local effectItem = self.Image_effectItem:clone()
        if i ~= 1 then
            disHeight = disHeight + effectHeight + effectDis
            effectPos.y = effectPos.y + effectHeight + effectDis
        end
        effectItem:Pos(effectPos)
        self.Image_roomInfo:addChild(effectItem)
        effectItem.desId = v

        self:updateEffectItem(effectItem)
        table.insert(self.effectListItem,effectItem)
    end

    local saveSize = self.Image_roomInfo.saveSize
    local savePos = self.Image_roomInfo.Panel_bottom01.savePos
    if #self.effectListItem > 0 then
        self.Image_roomInfo:Size(saveSize.width,saveSize.height + disHeight)
        self.Image_roomInfo.Panel_bottom01:Pos(savePos.x, savePos.y + disHeight)
    else
        self.Image_roomInfo:Size(saveSize.width,saveSize.height - effectHeight)
        self.Image_roomInfo.Panel_bottom01:Pos(savePos.x, savePos.y - effectHeight)
    end

    self:checkRoom()
end

function DecorateRoomView:updateEffectItem(item)
    local Label_buff = TFDirector:getChildByPath(item,"Label_buff")
    Label_buff:setLineHeight(25)
    Label_buff:setTextById(item.desId)
end

function DecorateRoomView:initRoomUnLockInfo()
    self.Image_roomUnlockInfo = TFDirector:getChildByPath(self.ui,"Image_roomUnlockInfo"):hide()
    self.Image_roomUnlockInfo.saveSize = self.Image_roomUnlockInfo:Size()
    self.Button_unLock = TFDirector:getChildByPath(self.Image_roomUnlockInfo,"Button_unLock")

    self.Image_roomUnlockInfo.Panel_bottom01 = TFDirector:getChildByPath(self.Image_roomUnlockInfo,"Panel_bottom01")
    self.Image_roomUnlockInfo.Panel_bottom01.savePos = self.Image_roomUnlockInfo.Panel_bottom01:Pos()
    self.Image_roomUnlockInfo.Image_bottom02 = TFDirector:getChildByPath(self.Image_roomUnlockInfo,"Image_bottom02"):hide()

    self:initGoodsScroll()
    self:refreshRoomUnLockInfo()
end

function DecorateRoomView:initGoodsScroll()
    local ScrollView_goodsList = TFDirector:getChildByPath(self.Image_roomUnlockInfo,"ScrollView_goodsList")
    self.goodsScroll = UIListView:create(ScrollView_goodsList)

    local Image_scrollBarModel = TFDirector:getChildByPath(self.Image_roomUnlockInfo, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(self.Image_roomUnlockInfo, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.goodsScroll:setScrollBar(scrollBar)

end

function DecorateRoomView:refreshRoomUnLockInfo()
    local roomData = self.roomListData_[self.selectIndex_]
    local Label_name = TFDirector:getChildByPath(self.Image_roomUnlockInfo,"Label_name")
    Label_name:setTextById(roomData.nameTextId)
    local Label_des = TFDirector:getChildByPath(self.Image_roomUnlockInfo,"Label_des")
    Label_des:setTextById(roomData.desTextId)

    self:refreshGoodsScroll()

    local effectList = roomData.effectTextId

    for i,v in ipairs(self.effectListItem) do
        v:removeFromParent()
    end

    self.effectListItem = {}

    local effectHeight = self.Image_roomUnlockInfo.Image_bottom02:Size().height

    local effectPos = self.Image_roomUnlockInfo.Image_bottom02:Pos()
    local effectDis = 2
    local disHeight = 0
    for i,v in ipairs(effectList) do
        local effectItem = self.Image_effectItem:clone()
        if i ~= 1 then
            disHeight = disHeight + effectHeight + effectDis
            effectPos.y = effectPos.y + effectHeight + effectDis
        end
        effectItem:Pos(effectPos)
        self.Image_roomUnlockInfo:addChild(effectItem)
        effectItem.desId = v

        self:updateEffectItem(effectItem)
        table.insert(self.effectListItem,effectItem)
    end

    local saveSize = self.Image_roomUnlockInfo.saveSize
    local savePos = self.Image_roomUnlockInfo.Panel_bottom01.savePos
    if #self.effectListItem > 0 then
        self.Image_roomUnlockInfo:Size(saveSize.width,saveSize.height + disHeight)
        self.Image_roomUnlockInfo.Panel_bottom01:Pos(savePos.x, savePos.y + disHeight)
    else
        self.Image_roomUnlockInfo:Size(saveSize.width, saveSize.height - effectHeight)
        self.Image_roomUnlockInfo.Panel_bottom01:Pos(savePos.x, savePos.y - effectHeight)
    end
end

function DecorateRoomView:loadGoodsScroll()
    self.goodsScroll:removeAllItems()

    local roomId = RoleDataMgr:getRoleRoomInfoId(self.selectIndex_)
    local goodsListData = RoleDataMgr:getUnlockCost(roomId)
    print()
    for i,v in ipairs(goodsListData) do
        local goodItem = self.Panel_goodItem:clone()
        goodItem.goodId = v.id
        goodItem.maxNum = v.cost
        self:initGoodItem(goodItem)
        self.goodsScroll:pushBackCustomItem(goodItem)
    end

    self:refreshGoodsScroll()
end

function DecorateRoomView:initGoodItem(goodItem)
    local Image_icon = TFDirector:getChildByPath(goodItem,"Image_icon")
    local Label_name = TFDirector:getChildByPath(goodItem,"Label_name")
    local Label_num = TFDirector:getChildByPath(goodItem,"Label_num")

    Image_icon:Touchable(true)
    Image_icon:onClick(function()
            if Image_icon.costCfg then
                local data = Image_icon.costCfg
                print("data ",data)
                Utils:showInfo(data.id, nil, true)
            end
        end)
end

function DecorateRoomView:refreshGoodsScroll()
    self.isShowUnLockBtn = true
    for i,v in ipairs(self.goodsScroll:getItems()) do
        self:updateGoodItem(v)
    end

    self.Button_unLock:setGrayEnabled(not self.isShowUnLockBtn)
    self.Button_unLock:setTouchEnabled(self.isShowUnLockBtn)
end

function DecorateRoomView:updateGoodItem(goodItem)

    local goodId = goodItem.goodId
    local maxNum = goodItem.maxNum

    local costCfg = GoodsDataMgr:getItemCfg(goodId)

    local Image_icon = TFDirector:getChildByPath(goodItem,"Image_icon")
    Image_icon.costCfg = costCfg
    Image_icon:setTexture(costCfg.icon)
    Image_icon:Size(50,50)
    local Label_name = TFDirector:getChildByPath(goodItem,"Label_name")
    Label_name:setTextById(costCfg.nameTextId)
    local Label_num = TFDirector:getChildByPath(goodItem,"Label_num")
    local num = GoodsDataMgr:getItemCount(goodId)
    Label_num:setText(string.format("%d/%d",num,maxNum))

    if num < maxNum then
        self.isShowUnLockBtn = false
    end
    local Image_bottom1 = TFDirector:getChildByPath(goodItem, "Image_bottom1"):hide()
    local Image_bottom2 = TFDirector:getChildByPath(goodItem, "Image_bottom2"):hide()

    if num >= maxNum then
        Image_bottom1:show()
    else
        Image_bottom2:show()
    end
end

function DecorateRoomView:showAllUI()
    self.Panel_scroll:show()
    self:checkRoomUnLock()
end

function DecorateRoomView:hideAllUI()
    self.Panel_scroll:hide()
    self.Image_roomInfo:hide()
    self.Image_roomUnlockInfo:hide()
end

function DecorateRoomView:onUnLockRoleRoom()
    self:showRoomInfo()
    self:hideRoomUnlockInfo()
    self:refreshRoomScroll()
end

function DecorateRoomView:registerEvents()

    EventMgr:addEventListener(self, EV_DATING_EVENT.changeRoleRoom, handler(self.onChangeRoleRoom, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.unLockRoleRoom, handler(self.onUnLockRoleRoom, self))

    for i,v in ipairs(self.roomScroll:getItems()) do
        local roomItem = v
        roomItem:Touchable(true)
        roomItem:onClick(function()

            if #self.roomListData_[i].roomUIName == 0 then
                Utils:showTips(2000020)
                return
            end

            self:selectRoom(i)
            end)
    end

    self.Button_preview:onClick(function()
            self:hideAllUI()
            self.ui:timeOut(function()
                    self:showAllUI()
                end,3)
            -- Utils:showTips("预览")
        end)

    self.Button_change:onClick(function()
            self:changeRoom()
        end)
    self.Button_unLock:onClick(function()
            local roomId = RoleDataMgr:getRoleRoomInfoId(self.selectIndex_)
            RoleDataMgr:unLockRoleRoom(roomId)
        end)
end

function DecorateRoomView:setCloseCallback(callBack)
    self.closeCallBack = callBack
end

function DecorateRoomView:onClose()
    self.super.onClose(self)

end

return DecorateRoomView
