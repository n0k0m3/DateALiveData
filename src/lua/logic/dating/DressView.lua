local DressView = class("DressView",BaseLayer)
local dressTable = TabDataMgr:getData("Dress")

function DressView:initData(data)
    self.roleModelId = RoleDataMgr:getModel(RoleDataMgr:getUseId())
    self.dressId_ = RoleDataMgr:getDressIdList()
    self.useRoleInfo = clone(RoleDataMgr:getUseRoleInfo())
    self.useDressId = self.useRoleInfo.dressId
    self.selectIdx = self:findDressIdx()
end

function DressView:findDressIdx()
    for i, v in ipairs(self.dressId_) do
        if v == self.useDressId then
            return i
        end
    end
end

function DressView:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)

    self:init("lua.uiconfig.dating.dressView")
end

function DressView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Panel_base = TFDirector:getChildByPath(self.ui,"Panel_base")

    self.Image_black = TFDirector:getChildByPath(self.Panel_base, "Image_black"):hide()
    self.Image_bg2 = TFDirector:getChildByPath(self.Panel_base, "Image_bg2"):hide()
    self.Spine_sceneEffect = TFDirector:getChildByPath(self.Panel_base, "Spine_sceneEffect"):hide()


    self:initButtonList()
    self:initPrefab()
    self:initRole()
    self:initSpecialRole()
    self:initDressTip()
    self:initScrollView()
    self:timeOut(function() self:showScrollView() end,0.3)

    self.topLayer:setZOrder(10)

    self:setBackBtnCallback(function()
            if self.voiceHandle then
                TFAudio.stopEffect(self.voiceHandle)
            end
             if self.closeCallBack then
                 self.closeCallBack()
             end
             AlertManager:closeLayer(self)
        end)

    self.voiceHandle = VoiceDataMgr:playVoice("button_dress",RoleDataMgr:getUseId())

    self:selectItem(self.selectIdx)
end


function DressView:initButtonList()
    self.Panel_buttonList = TFDirector:getChildByPath(self.ui, "Panel_buttonList")
    self.Panel_buttonList.savePos = self.Panel_buttonList:Pos()
    self.Panel_buttonList:setOpacity(0)
    self.Panel_n = TFDirector:getChildByPath(self.Panel_buttonList, "Panel_n")
    self.Panel_n:show()
    self.Panel_h = TFDirector:getChildByPath(self.Panel_buttonList, "Panel_h")
    self.Panel_h:hide()
    self.Panel_preview = TFDirector:getChildByPath(self.Panel_n, "Panel_preview"):hide()
    self.Panel_preview.Button_preview = TFDirector:getChildByPath(self.Panel_preview, "Button_preview")
    self.Panel_get = TFDirector:getChildByPath(self.Panel_n, "Panel_get"):hide()
    self.Panel_get.Button_get = TFDirector:getChildByPath(self.Panel_get, "Button_get")
    self.Panel_getAndPreview = TFDirector:getChildByPath(self.Panel_n, "Panel_getAndPreview"):hide()
    self.Panel_getAndPreview.Button_preview = TFDirector:getChildByPath(self.Panel_getAndPreview, "Button_preview")
    self.Panel_getAndPreview.Button_get = TFDirector:getChildByPath(self.Panel_getAndPreview, "Button_get")
    self.Panel_backAndOk = TFDirector:getChildByPath(self.Panel_h, "Panel_backAndOk"):hide()
    self.Panel_backAndOk.Button_ok = TFDirector:getChildByPath(self.Panel_backAndOk, "Button_ok")
    self.Panel_backAndOk.Button_pBack = TFDirector:getChildByPath(self.Panel_backAndOk, "Button_pBack")
    self.Panel_backAndGet = TFDirector:getChildByPath(self.Panel_h, "Panel_backAndGet"):hide()
    self.Panel_backAndGet.Button_get = TFDirector:getChildByPath(self.Panel_backAndGet, "Button_get")
    self.Panel_backAndGet.Button_pBack = TFDirector:getChildByPath(self.Panel_backAndGet, "Button_pBack")
end

function DressView:onOk()
    self:useDress()
end

function DressView:onGet()
    local dressId = self.dressId_[self.selectIdx]
    Utils:showAccess(dressId)
end

function DressView:refreshPreview()
    local dressId = self.dressId_[self.selectIdx]
    local isHave = tobool(GoodsDataMgr:getDress(dressId))
    local data = dressTable[dressId]
    self.Panel_backAndOk:hide()
    self.Panel_backAndGet:hide()

    if isHave then
        self.Panel_backAndOk:show()
    else
        self.Panel_backAndGet:show()
    end
end

function DressView:onPreview()

    self:refreshPreview()

    self.elvesNpc:playOut(0.3)
    self.Panel_table:hide()
    self:hideDressTip()
    self.Image_black:show()
    self.Image_black:setOpacity(0)
    local ac = {
        CCFadeIn:create(1),
        CCCallFunc:create(function()
            self.Image_bg2:show()
            if self.effectSK then
                self.effectSK:show()
            end
            self:refreshDressTip(true)
            self.specialElvesNpc:show()
            --self.specialElvesNpc:playIn(0.3)
            self.Panel_n:hide()
            self.Panel_h:show()
            self:showDressTip()
        end),
        CCDelayTime:create(0.5),
        CCFadeOut:create(1),
        CCCallFunc:create(function()
            self.Image_black:hide()
        end)
    }
    self.Image_black:runAction(CCSequence:create(ac))
end

function DressView:onBack()
    self.specialElvesNpc:playOut(0.3)
    self.Image_black:show()
    self.Image_black:setOpacity(0)
    self:hideDressTip()
    local ac = {
        CCFadeIn:create(1),
        CCCallFunc:create(function()
            self.Image_bg2:hide()
            if self.effectSK then
                self.effectSK:hide()
            end
            self:refreshDressTip()
        end),
        CCDelayTime:create(0.5),
        CCCallFunc:create(function()
            self.Panel_h:hide()
            self.Panel_n:show()
            self.Panel_table:show()
            self:showDressTip()
            self.elvesNpc:show()
        end),
        CCFadeOut:create(1),
        CCCallFunc:create(function()
            self.Image_black:hide()
        end)
    }
    self.Image_black:runAction(CCSequence:create(ac))
end

function DressView:bindButtonClickEvent()
    self.Image_changeDressOk:onClick(function()
        self:onOk()
    end)
    self.Panel_backAndOk.Button_ok:onClick(function()
        self:onOk()
    end)

    self.Panel_get.Button_get:onClick(function()
        self:onGet()
    end)
    self.Panel_getAndPreview.Button_get:onClick(function()
        self:onGet()
    end)
    self.Panel_backAndGet.Button_get:onClick(function()
        self:onGet()
    end)

    self.Panel_preview.Button_preview:onClick(function()
       self:onPreview()
    end)

    self.Panel_getAndPreview.Button_preview:onClick(function()
        self:onPreview()
    end)

    self.Panel_backAndGet.Button_pBack:onClick(function()
       self:onBack()
    end)
    self.Panel_backAndOk.Button_pBack:onClick(function()
        self:onBack()
    end)
end

function DressView:initPrefab()
    self.Panel_prefab = TFDirector:getChildByPath(self.ui,"Panel_prefab")
end

function DressView:initDressTip()
    self.dressLayer = require("lua.logic.dating.DressLayer"):new()
    self.dressLayer:setOpacity(0)
    self.Panel_base:addChild(self.dressLayer,999)
    self:refreshDressTip()
end

function DressView:refreshDressTip(isH)
    if isH then
        self.dressLayer:Pos(750,250)
    else
        self.dressLayer:Pos(0,10)
    end
    self:refreshButtonList(isH)
end

function DressView:refreshButtonList(isH)
    if isH then
        self.Panel_buttonList:Pos(self.Panel_buttonList.savePos + ccp(750,240))
    else
        self.Panel_buttonList:Pos(self.Panel_buttonList.savePos)
    end
end

function DressView:showDressTip()
    self.dressLayer:fadeIn(1)
    self.Panel_buttonList:fadeIn(1)
end

function DressView:hideDressTip()
    self.dressLayer:fadeOut(0.5)
    self.Panel_buttonList:fadeOut(0.5)
end

function DressView:initScrollView()
    self.Panel_table = TFDirector:getChildByPath(self.ui,"Panel_table")
    self.Panel_table.savePos = self.Panel_table:Pos()
    print("last self.Panel_table.savePos ",self.Panel_table.savePos)
    self.Panel_table:Pos(self.Panel_table.savePos + ccp(500,0))

    self.Image_changeDressOk = TFDirector:getChildByPath(self.Panel_table,"Image_changeDressOk")

    self.Panel_Item = TFDirector:getChildByPath(self.Panel_prefab,"Panel_Item")

    local scrollView = TFDirector:getChildByPath(self.Panel_table,"ScrollView_dress")
    self.listView = UIListView:create(scrollView)

    self:loadScrollViewData()
end

function DressView:showScrollView()

end

function DressView:hideScrollView()

end

function DressView:loadScrollViewData()
    self.listView:removeAllItems()

    for i, v in ipairs(self.dressId_) do
        local id = v
        local item = self.Panel_Item:clone()
        item.id = id
        item.idx = i
        self:initItem(item)
        self:updateItem(item)
        self.listView:pushBackCustomItem(item)
    end

    self:bindItemsTouchEvent()
end

function DressView:initItem(item)
    item.Image_select = TFDirector:getChildByPath(item, "Image_select")
    item.Image_dressBottom = TFDirector:getChildByPath(item, "Image_dressBottom")
    item.Image_dress = TFDirector:getChildByPath(item, "Image_dress")
    item.Image_hDressIcon = TFDirector:getChildByPath(item, "Image_hDressIcon"):hide()
    item.starList = {}
    for index=1,5 do
        item.starList[index] = TFDirector:getChildByPath(item, "Image_star0" .. index)
    end
    item.Image_lockBottom = TFDirector:getChildByPath(item, "Image_lockBottom")
    item.Image_useBottom = TFDirector:getChildByPath(item, "Image_useBottom")
    item.Label_name = TFDirector:getChildByPath(item, "Label_name")
    item.Panel_touch = TFDirector:getChildByPath(item, "Panel_touch")
end

function DressView:updateItem(item)
    local idx = item.idx
    local id = item.id
    local data = dressTable[id]
    if not data then
        Box("数据为空，id: ".. id)
        return
    end
    item.modelId = data.roleModel
    item.isUnlock = GoodsDataMgr:getDress(id)
    item.isSelect = idx == self.selectIdx
    item.data = data

    if item.Image_hDressIcon and data.type == 2 then
        item.Image_hDressIcon:show()
    else
        item.Image_hDressIcon:hide()
    end

    item.Image_select:setVisible(item.isSelect)
    local star = data.star
    if star == 0 then
        star = 1
    end
    local index = (90 + star)
    local dressBottomStr = string.format("ui/%03d.png",index)
    -- dress.Image_dressBottom:setTexture(dressBottomStr)
    item.Image_dress:setTexture(data.dressImg)
    for i=1,#item.starList do
        if data.star < i then
            item.starList[i]:hide()
        else
            item.starList[i]:show()
        end
    end
    item.Image_lockBottom:setVisible(not item.isUnlock)
    item.Image_useBottom:hide()
    item.Label_name:setTextById(data.nameTextId)

    if item.id == self.useDressId then
        item.Image_useBottom:show()
    end

    if item.isSelect == true then
        item.Label_name:setFontColor(ccc3(235,53,105))
    elseif item.id == self.useDressId then
        item.Label_name:setFontColor(ccc3(251,222,58))
    elseif item.isUnlock == false then
        item.Label_name:setFontColor(ccc3(116,116,125))
    else
        item.Label_name:setFontColor(ccc3(255,255,255))
    end

    if self.dressLayer and item.isSelect and item.id then
        self.dressLayer:initData(item.id)
        self:showDressTip()
    end
end

function DressView:bindItemsTouchEvent()
    if self.listView and table.count(self.listView:getItems()) ~= 0 then
        for i, v in ipairs(self.listView:getItems()) do
            local item = v
            self:bindItemTouchEvent(item)
        end
    end
end

function DressView:selectItem(idx)
    self.selectIdx = idx

    self.Image_changeDressOk:setGrayEnabled(false)
    self.Image_changeDressOk:setTouchEnabled(true)

    local item = self.listView:getItems()[idx]
    if item.id == self.useDressId or not item.isUnlock then
        self.Image_changeDressOk:setGrayEnabled(true)
        self.Image_changeDressOk:setTouchEnabled(false)
    end

    local dressId = self.dressId_[self.selectIdx]
    local isHave = tobool(GoodsDataMgr:getDress(dressId))
    local data = dressTable[dressId]
    self.Panel_preview:hide()
    self.Panel_getAndPreview:hide()
    self.Panel_get:hide()
    if data.type and data.type == 2 and data.id ~= self.useDressId then
        if isHave then
            self.Panel_preview:show()
        else
            self.Panel_getAndPreview:show()
        end
    else
        if not isHave then
            self.Panel_get:show()
        end
    end
end

function DressView:bindItemTouchEvent(item)
    item.Panel_touch:Touchable(true)
    item.Panel_touch:onClick(function()
        if item.isSelect == true then
            return
        end

        self:hideDressTip()
        self:selectItem(item.idx)
        self:onChangeDressEvent(item.modelId,item.data)
        --self:loadScrollViewData()
    end)
end

function DressView:initRole(modelId,scale)
    local speAcData = TabDataMgr:getData("SpecialAction")
    local speData = clone(speAcData[RoleDataMgr:getUseId()])
    local acName = speData["dressilde"].action

    local Image_npc = TFDirector:getChildByPath(self.ui,"Image_npc")
    self.elvesNpc = ElvesNpcTable:createLive2dNpcID(self.roleModelId,false,false,acName).live2d

    local scale = self.elvesNpc.type == 1 and 0.7 or 0.5
    self.elvesNpc:setScale(scale)
    self.elvesNpc.defaultScale = scale
    Image_npc:getParent():addChild(self.elvesNpc)
    self.elvesNpc:setZOrder(Image_npc:getZOrder())
    local pos = ccp(self.Panel_base:Size().width/2,-100)
    self.elvesNpc:setPosition(pos)
    Image_npc:hide()

    if not modelId then
        self.elvesNpc:hide()
        self.ui:timeOut(function()
            self.elvesNpc:playIn(0.3)
            end,0.2)
    end
end

function DressView:initSpecialRole(data,scale)
    if self.specialElvesNpc then
        self.specialElvesNpc:removeFromParent()
        self.specialElvesNpc = nil
    end
    if self.effectSK then
        self.effectSK:removeFromParent()
        self.effectSK = nil
    end
    data = data or RoleDataMgr:useDressFindData()
    local spModelId = nil
    if data and data.type and data.type == 2 then
        spModelId = data.highRoleModel
    end

    if not spModelId or data.id == self.useDressId then
        return
    end
    if data.background and #data.background ~= 0 then
        print("data.background 3333333333 ",data.background)
        self.Image_bg2:setTexture(data.background)
    end

    if data.backgroundEffect and data.backgroundEffect ~= 0 then
        self:refreshEffect(data.backgroundEffect)
    end
    local speAcData = TabDataMgr:getData("SpecialAction")
    local speData = clone(speAcData[RoleDataMgr:getUseId()])
    local acName = speData["dressilde"].action

    local Image_npc = TFDirector:getChildByPath(self.ui,"Image_npc")
    self.specialElvesNpc = ElvesNpcTable:createLive2dNpcID(spModelId,false,false,acName).live2d

    local scale = self.specialElvesNpc.type == 1 and 0.7 or 0.5
    self.specialElvesNpc:setScale(scale)
    self.specialElvesNpc.defaultScale = scale
    Image_npc:getParent():addChild(self.specialElvesNpc)
    self.specialElvesNpc:setZOrder(Image_npc:getZOrder())

    local offPos = data.offSet
    if offPos and offPos.x and offPos.x ~= 0 and offPos.y and offPos.y ~= 0 then
        self.specialElvesNpc:setPosition(ccp(330,-100) + ccp(offPos.x,offPos.y))
    else
        self.specialElvesNpc:setPosition(ccp(450,-50));--位置
    end

    self.specialElvesNpc:hide()
end

function DressView:refreshEffect(effectId)
    
    self.effectSK = Utils:createEffectByEffectId(effectId)
    self.effectSK:setPosition(self.Spine_sceneEffect:getPosition())
    self.Spine_sceneEffect:getParent():addChild(self.effectSK, self.Spine_sceneEffect:getZOrder())

    --self.effectSK:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
    --    skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
    --    skeletonNode:removeMEListener(TFARMATURE_EVENT)
    --    skeletonNode:removeFromParent()
    --end)

    self.effectSK:hide()
end

function DressView:refreshRole(modelId,data)
    local scale = self.elvesNpc:Scale()
    self.elvesNpc:removeFromParent()
    self.elvesNpc = nil
    self.roleModelId = modelId
    self:initRole(modelId,scale)
    self:initSpecialRole(data,scale)
end

function DressView:onChangeDressEvent(modelId,data)
    if not modelId then
        Box("modelId 为空")
    end

    local selectId = self.dressId_[self.selectIdx]
    local data = dressTable[selectId]
    if not data then
        Box("数据为空，id: ".. selectId)
        return
    end

    local disTime = 2.0
    local changeDressAc = TFVector:create()

    local hideTableAc =  CCCallFunc:create(function()
        self.Panel_table:hide()
        VoiceDataMgr:playVoice("dress_wait",RoleDataMgr:getUseId())
    end)

    local updateRoleAc = CCCallFunc:create(function()
        self:refreshRole(modelId,data)
        local speAcData = TabDataMgr:getData("SpecialAction")
        local speData = clone(speAcData[RoleDataMgr:getUseId()])
        self.elvesNpc:newStartAction(speData["dress"].action,EC_PRIORITY.FORCE)
    end)

    local deyTimeAc = DelayTime:create(disTime)
    local loadScrollAc = CCCallFunc:create(function()
        self:loadScrollViewData()
        self.Panel_table:show()
        self.topLayer:show()
    end)

    changeDressAc:addObject(hideTableAc)
    changeDressAc:addObject(updateRoleAc)
    changeDressAc:addObject(deyTimeAc)
    changeDressAc:addObject(loadScrollAc)

    self.ui:runAction(CCSequence:create(changeDressAc))
end

function DressView:setCloseCallback(callBack)
    self.closeCallBack = callBack
end

function DressView:onChangeDressOk()

    self.useRoleInfo = clone(RoleDataMgr:getUseRoleInfo())
    self.useDressId = self.useRoleInfo.dressId

    self:selectItem(self.selectIdx)
    self.Image_changeDressOk:setGrayEnabled(true)
    self.Image_changeDressOk:setTouchEnabled(false)
    self.Panel_backAndOk.Button_ok:setGrayEnabled(true)
    self.Panel_backAndOk.Button_ok:setTouchEnabled(false)

    self:playBgm()
    self:timeOut(function()
        self:loadScrollViewData()
    end,0.2)
end

function DressView:registerEvents()
    self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_DATING_EVENT.changeDress, handler(self.onChangeDressOk, self))

   self:bindButtonClickEvent()
end

function DressView:useDress()
    local selectId = self.dressId_[self.selectIdx]
    if selectId then
        if GoodsDataMgr:getDress(selectId) == nil then
            local str = TextDataMgr:getText(304001)
            toastMessage(str)
        else
            RoleDataMgr:sendDress(self.useRoleInfo.sid,selectId)
            local data = dressTable[selectId]
            if not data then
                Box("数据为空，id: ".. selectId)
                return
            end
            local quality = data.quality
            if quality == 1 then
                self.voiceHandle = VoiceDataMgr:playVoice("dress_low",RoleDataMgr:getUseId(),selectId)
            elseif quality > 1 then
                self.voiceHandle = VoiceDataMgr:playVoice("dress_high",RoleDataMgr:getUseId(),selectId)
            end
        end
    end
end

function DressView:onShow()
    --self.super.onShow(self)
    self.super.onShow(self)
    self:enterAction()

    if self.listView and self.listView:getItems()[2] then

    end

    self:loadScrollViewData()
    self:playBgm()
end

function DressView:playBgm()
    local dressData = RoleDataMgr:useDressFindData()
    if dressData and dressData.type and dressData.type == 2 and dressData.kanbanBgm and #dressData.kanbanBgm ~= 0 then
        AudioExchangePlay.playBGM(self, true,dressData.kanbanBgm)
    else
        AudioExchangePlay.playBGM(self, true)
    end
end

function DressView:enterAction()
    local time = 0.2
    local tableAc = {
        DelayTime:create(time),
        MoveTo:create(0.5,self.Panel_table.savePos)
    }
    self.Panel_table:runAction(CCSequence:create(tableAc))
end

function DressView:onClose()
    self.super.onClose(self)

end

return DressView
