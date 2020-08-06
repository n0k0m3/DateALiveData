local NewRoleShowView = class("NewRoleShowView", BaseLayer)
require "lua.public.ScrollMenu"
local dressTable = TabDataMgr:getData("Dress")
local iTable = TabDataMgr:getData("Interaction")
local triggerEvent = TabDataMgr:getData("TriggerEvent")
function NewRoleShowView:initData(roleId, dressId)
    self.model = nil
    self.modelId = nil
    self.useId = RoleDataMgr:getUseId()
    self.curId = roleId or self.useId
    self.paramsDressId_ = dressId
    self.sendMsgType = 0 --1切换看板娘，2换装，3切换看板同时换装
    self:refreshData()
    self.dressDatingEvent_ = self:getDressDatingEvent()
    self.roleList = RoleDataMgr:getRoleIdList()
    self.unInfoListItems = {}
    self.dressItemsList = {}
    self.selectDIdx = self:findDressIdx()
    self.selectIdx = -1
    self.isFirst = true
    self.btnType_ = {
        dressType = 1,
        unInfoType = 2,
        infoType = 3,
    }
end

function NewRoleShowView:getDressDatingEvent()
    local dressDatingEvent = {}
    for k, v in pairs(triggerEvent) do
        local params = v.params
        local result = v.result
        if params.dressId and result.data.scriptId then
            dressDatingEvent[params.dressId] = result.data.scriptId
        end
    end
    return dressDatingEvent
end

function NewRoleShowView:refreshData()
    self.curRoleFavor = RoleDataMgr:getFavorLevel(self.curId)
    self.dressId_ = RoleDataMgr:getDressIdList(self.curId)
    self.curRoleInfo = RoleDataMgr:getRoleInfo(self.curId)
    self.useDressId = self.curRoleInfo.dressId or self.curRoleInfo.roleModel
    --if self.Panel_base then
    --    self.Panel_base:timeOut(function()
    --        self.selectDIdx = self:findDressIdx()
    --    end,0.2)
    --end
    self.selectDIdx = self:findDressIdx()
    self:showUnInfoList()
    self.list_ = RoleDataMgr:getTriggerDatingList(self.curId) or {}
    self:resetList()
end

function NewRoleShowView:resetList()
    local list = {}
    for i,v in ipairs(self.list_) do
        if 2 == DatingDataMgr:getDatingRuleData(v.datingRuleCid).item_type then
            table.insert(list,v)
        end
    end
    return list
end

function NewRoleShowView:findDressIdx()
    for i, v in ipairs(self.dressId_) do
        if v == self.useDressId then
            return i
        end
    end
end

function NewRoleShowView:ctor(roleId, dressId)
    self.super.ctor(self)

    self:initData(roleId, dressId)

    self:init("lua.uiconfig.role.newRoleShowView")
end

function NewRoleShowView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Panel_base = TFDirector:getChildByPath(self.ui, "Panel_base")
    self.Image_roleInfoBg = TFDirector:getChildByPath(self.ui, "Image_roleInfoBg")
    self.Image_bg2 = TFDirector:getChildByPath(self.ui, "Image_bg2"):hide()
    self.Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")
    self.Spine_sceneEffect = TFDirector:getChildByPath(self.ui, "Spine_sceneEffect"):hide()
    self.Spine_effectHB = TFDirector:getChildByPath(self.ui, "Spine_effectHB")
    self.Panel_black = TFDirector:getChildByPath(self.ui, "Panel_black")

    self.Button_switch = TFDirector:getChildByPath(self.ui, "Button_switch")
    self.Button_switch_set = TFDirector:getChildByPath(self.ui, "Button_switch_set")
    self.Label_change = TFDirector:getChildByPath(self.Button_switch, "Label_change")
    self.Panel_play = TFDirector:getChildByPath(self.Button_switch, "Panel_play")
    self.Image_notplay = TFDirector:getChildByPath(self.Button_switch, "Image_notplay")
    self.Image_circle = TFDirector:getChildByPath(self.Button_switch, "Image_circle")


    if self.Spine_effectHB then
        self.Spine_effectHB:hide()
    end

    EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)

    self:initLeft()
    self:initRight()
    self:initMid()
    --self:enterAction()

    self:showRoleList()

    self:tableCellTouched(true)

    self:updateSwitchState()
end

function NewRoleShowView:initMid()
    self.Panel_mid = TFDirector:getChildByPath(self.ui, "Panel_mid"):hide()
    self.Label_role_name = TFDirector:getChildByPath(self.Panel_mid, "Label_role_name")
    self.Label_enName = TFDirector:getChildByPath(self.Panel_mid, "Label_enName")
    self.Label_enName2 = TFDirector:getChildByPath(self.Panel_mid, "Label_enName2")

    self:initFavorAndMood()
end

function NewRoleShowView:refreshMid()
    self.Panel_right:show()
    self.Panel_mid:show()
    local heroId = HeroDataMgr:getHeroIdByRoleId(self.curId)
    self.Label_role_name:setString(RoleDataMgr:getName(self.curId))
    self.Label_enName:setString(HeroDataMgr:getEnName(heroId))
    self.Label_enName2:setString(HeroDataMgr:getEnName2(heroId))
    self:refreshFavorAndMood()
end

function NewRoleShowView:initFavorAndMood()
    self.Image_favorAndMood = TFDirector:getChildByPath(self.Panel_mid, "Image_favorAndMood"):hide()
    self.Label_favor = TFDirector:getChildByPath(self.Image_favorAndMood, "Label_favor")
    self.Label_mood = TFDirector:getChildByPath(self.Image_favorAndMood, "Label_mood")
end

function NewRoleShowView:refreshFavorAndMood()
    local ishave = RoleDataMgr:getIsHave(self.curId)
    --self.Image_favorAndMood:setVisible(ishave)
    self.Image_favorAndMood:hide() --暂时调整为不显示
    local favor = RoleDataMgr:getFavorLevel(self.curId)
    self.Label_favor:setText("Lv." .. favor)
    local mood = RoleDataMgr:getMood(self.curId)
    self.Label_mood:setText(mood)
end

function NewRoleShowView:initLeft()
    self.Panel_left = TFDirector:getChildByPath(self.ui, "Panel_left")
    self.Panel_role_item_s = TFDirector:getChildByPath(self.ui, "Panel_role_item_s")
    self.Panel_role_item_uns = TFDirector:getChildByPath(self.ui, "Panel_role_item_uns")
    self.Panel_roleList = TFDirector:getChildByPath(self.Panel_left, "Panel_roleList")
end

function NewRoleShowView:selectBtn(type)
    self.selectType = type

    self.Panel_dress:setVisible(type == self.btnType_.dressType)
    self.Panel_info:setVisible(type == self.btnType_.infoType)
    self.Panel_unInfo:setVisible(type == self.btnType_.unInfoType)
    self.Button_dress.select:setVisible(type == self.btnType_.dressType)
    self.Button_info.select:setVisible(type == self.btnType_.infoType)
    self.Button_unInfo.select:setVisible(type == self.btnType_.unInfoType)
    self.Button_dress:setTouchEnabled(type ~= self.btnType_.dressType)
    self.Button_info:setTouchEnabled(type ~= self.btnType_.infoType)
    self.Button_unInfo:setTouchEnabled(type ~= self.btnType_.unInfoType)
end

function NewRoleShowView:initRight()
    self.Panel_right = TFDirector:getChildByPath(self.ui, "Panel_right"):hide()

    self.Button_change = TFDirector:getChildByPath(self.ui, "Button_change")
    self.Button_huigu = TFDirector:getChildByPath(self.ui, "Button_huigu")
    self.Button_changeScene = TFDirector:getChildByPath(self.ui, "Button_changeScene")

    self.Button_dress = TFDirector:getChildByPath(self.Panel_right, "Button_dress")
    self.Button_dress.select = TFDirector:getChildByPath(self.Button_dress, "Image_select")
    self.Button_unInfo = TFDirector:getChildByPath(self.Panel_right, "Button_unInfo")
    self.Button_unInfo.select = TFDirector:getChildByPath(self.Button_unInfo, "Image_select")
    self.Button_info = TFDirector:getChildByPath(self.Panel_right, "Button_info")
    self.Button_info.select = TFDirector:getChildByPath(self.Button_info, "Image_select")

    self.Panel_info = TFDirector:getChildByPath(self.Panel_right, "Panel_info")
    self.Panel_dress = TFDirector:getChildByPath(self.Panel_right, "Panel_dress")
    self.Panel_unInfo = TFDirector:getChildByPath(self.Panel_right, "Panel_unInfo")

    self:initPanelDress()
    self:initPanelUnInfo()
end

function NewRoleShowView:initPanelDress()
    self:initDressScroll()
end

function NewRoleShowView:initPanelUnInfo()
    self:initUnInfoScroll()
end

function NewRoleShowView:initUnInfoScroll()
    self.Panel_unInfoItem = TFDirector:getChildByPath(self.ui, "Panel_unInfoItem")
    local ScrollView_unInfo = TFDirector:getChildByPath(self.Panel_unInfo, "ScrollView_unInfo")
    self.unInfoListView = UIListView:create(ScrollView_unInfo)
    self.unInfoListView:setItemsMargin(10)

    local Image_scrollBarModel = TFDirector:getChildByPath(self.Panel_unInfo, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(self.Panel_unInfo, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.unInfoListView:setScrollBar(scrollBar)

    self:showUnInfoList()
end

function NewRoleShowView:showUnInfoList()
    if not self.unInfoListView then
        return
    end
    self.unInfoListView:removeAllItems()

    local selectId = self.dressId_[self.selectDIdx]
    local data = dressTable[selectId]
    if not data then
        self.unInfoIdList = {}
    else
        self.unInfoIdList = data.playAction or {}
    end

    for i, v in ipairs(self.unInfoIdList) do
        local item = self.Panel_unInfoItem:clone()
        self:initUnInfoItem(item,i)
        table.insert(self.unInfoListItems, item)
        self.unInfoListView:pushBackCustomItem(item)
    end
end

function NewRoleShowView:initUnInfoItem(item,idx)
    local data = iTable[self.unInfoIdList[idx]]
    item.desTime = 0
    for i, v in ipairs(data.lineShow) do
        local time = data.lineStop[i]
        if time then
            item.desTime = item.desTime + time
        end
    end

    local selectId = self.dressId_[self.selectDIdx]
    local dressData = dressTable[selectId]
    local Label_des = TFDirector:getChildByPath(item, "Label_des"):hide()
    Label_des:setTextById(dressData.playWord[idx])
    local Label_lockDes = TFDirector:getChildByPath(item, "Label_lockDes"):hide()
    Label_lockDes:setTextById(dressData.playWord[idx])
    local Panel_unLockT = TFDirector:getChildByPath(item, "Panel_unLockT"):hide()
    item.Panel_unLockT = Panel_unLockT
    local Label_unLockTDes = TFDirector:getChildByPath(Panel_unLockT, "Label_unLockTDes")
    local Button_c = TFDirector:getChildByPath(item, "Button_c"):hide()
    local ishave = RoleDataMgr:getIsHave(self.curId)
    if self.curRoleFavor >= data.favor and ishave then
        Button_c:show()
        Label_des:show()
    else
        Label_lockDes:show()
        Panel_unLockT:show()
        Label_unLockTDes:setText("Lv." .. data.favor)
    end
    item.Button_c = Button_c
    Button_c:onClick(function()
        self:updateAllUnInfoItemsState(true)
        item.Button_c:timeOut(function()
            self:updateAllUnInfoItemsState(false)
        end,item.desTime)
        if self.model then
            if self.voiceHandle then
                TFAudio.stopEffect(self.voiceHandle)
                self.voiceHandle = nil
            end
            local live2dParts = self.model:parseKanBanInfo(self.model.modelId,data.favor)
            local isPlayOk = self.model:newStartAction(live2dParts[data.position].action1, EC_PRIORITY.FORCE,nil,nil,nil,0,true)
            if isPlayOk ~= -1  then
                self.model:showKanbanLines(live2dParts[data.position],ccp(360,100))
            end
        end
    end)
end

function NewRoleShowView:updateAllUnInfoItemsState(isGay)
    for i, v in ipairs(self.unInfoListItems) do
        local item = v
        if item.Button_c then
            item.Button_c:setGrayEnabled(isGay)
            item.Button_c:setTouchEnabled(not isGay)
        end
    end
end

function NewRoleShowView:initItem(item,idx)
    item.Image_bottomNormal = TFDirector:getChildByPath(item, "Image_bottomNormal"):show()
    item.Image_bottomSelect = TFDirector:getChildByPath(item, "Image_bottomSelect"):hide()
    self:updateCellInfo(item,idx)
end

function NewRoleShowView:initDressScroll()
    self.Panel_dress_item = TFDirector:getChildByPath(self.ui, "Panel_dress_item")
    local ScrollView_dressList = TFDirector:getChildByPath(self.Panel_right, "ScrollView_dressList")
    self.TurnView_dressList = UITurnView:create(ScrollView_dressList)
    self.TurnView_dressList:setItemModel(self.Panel_dress_item)

    self:showDressScroll()
end

function NewRoleShowView:showDressScroll()
    self.TurnView_dressList:removeAllItems()
    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()
    
    --self.selectDIdx = self:findDressIdx()
    self.dressItemsList = {}
    for i, v in ipairs(self.dressId_) do
        if not self.dressItemsList[i] then
            self:addDressItem(i)
        end

        self:updateDressItem(i)
    end

    local realIdx = 1
    if self.firstIn and self.paramsDressId_ then
        for i, v in ipairs(self.dressId_) do
            if tonumber(v) == self.paramsDressId_ then
                realIdx = i
                self.paramsDressId_ = nil
                break
            end
        end
    end
    self.TurnView_dressList:jumpToItem(realIdx)
    self.selectDIdx = realIdx

    
    --self.TurnView_dressList:jumpToItem(self.selectDIdx)

    --local ScrollView_dressList = TFDirector:getChildByPath(self.Panel_right, "ScrollView_dressList")
    --ScrollView_dressList:hide()
    --ScrollView_dressList:timeOut(function()
    --    ScrollView_dressList:show()
    --end,0.3)
end

function NewRoleShowView:onPlotTurnViewSelect(target, selectIndex)
    self.TurnView_dressList.isScrolling = false
    local foo = self.dressItemsList[selectIndex]
    if not foo then
        return
    end
    local item = foo.root
    print("item.modelId ",item.modelId)
    print("self.modelId ",self.modelId)
    --if item.modelId == self.modelId then
    --    return
    --end
    self.selectDIdx = selectIndex
    self:updateRoleModel(item.modelId)
end

function NewRoleShowView:addDressItem(idx)
    local item = self.TurnView_dressList:pushBackItem()
    item.id = self.dressId_[idx]
    item.idx = idx
    item.Image_dressBottom = TFDirector:getChildByPath(item, "Image_dressBottom")
    item.Image_dress = TFDirector:getChildByPath(item, "Image_dress")
    item.Image_lockBottom = TFDirector:getChildByPath(item, "Image_lockBottom")
    item.Image_useBottom = TFDirector:getChildByPath(item, "Image_useBottom")
    item.Label_name = TFDirector:getChildByPath(item, "Label_name")
    item.Panel_touch = TFDirector:getChildByPath(item, "Panel_touch")
    item.Button_detail = TFDirector:getChildByPath(item, "Button_detail")
    item.Image_switchBpttom = TFDirector:getChildByPath(item, "Image_switchBpttom"):hide()
    item.Button_switch = TFDirector:getChildByPath(item, "Button_switch")
    item.Image_ok = TFDirector:getChildByPath(item, "Image_ok")
    item.Button_detail:onClick(function()
        --Box("item.id " .. tostring(item.id))
        Utils:showInfo(item.id,nil,not item.isUnlock)
    end)
    item.Panel_touch:onClick(function()
        self.TurnView_dressList:scrollToItem(idx)
        self.selectDIdx = idx
        self:updateRoleModel(item.modelId)
    end)
    local foo = {}
    foo.root = item

    item.Button_switch:onClick(function()
        RoleSwitchDataMgr:handleSwitchList(item.id)
    end)

    self.dressItemsList[idx] = foo
    return foo.root
end

function NewRoleShowView:updateDressItem(idx)

    local foo = self.dressItemsList[idx]
    local item = foo.root
    local idx = item.idx
    local id = item.id
    local data = dressTable[id]
    if not data then
        Box("数据为空，id: ".. id)
        return
    end
    item.modelId = data.roleModel
    item.isUnlock = GoodsDataMgr:getDress(id)
    item.isSelect = idx == self.selectDIdx
    item.data = data

    item.Image_dress:setTexture(data.dressImg)
    item.Image_lockBottom:setVisible(not item.isUnlock)
    item.Image_useBottom:hide()
    item.Label_name:setTextById(data.nameTextId)
    local ishave = RoleDataMgr:getIsHave(self.curId)
    local switchState = RoleSwitchDataMgr:getSwitchState()
    item.Button_switch:setVisible(ishave and data.type == 2 and item.isUnlock and switchState)
    if data.type == 2 then
        local isInSwitch = RoleSwitchDataMgr:isInSwitchList(id)
        item.Image_ok:setVisible(isInSwitch)
        item.Image_switchBpttom:setVisible(ishave and item.isUnlock and switchState and isInSwitch)
    end


    if item.id == self.useDressId and self.curId == self.useId then
        item.Image_useBottom:show()
    end
end

function NewRoleShowView:onOk()
    self:useDress()
end

function NewRoleShowView:useDress()
    local selectId = self.dressId_[self.selectDIdx]
    if selectId and self.curRoleInfo.sid then
        if GoodsDataMgr:getDress(selectId) == nil then
            local str = TextDataMgr:getText(304001)
            toastMessage(str)
        else
            RoleDataMgr:sendDress(self.curRoleInfo.sid,selectId)
        end
    end
end

function NewRoleShowView:showRoleList()
    local params = {
        ["upItem"]                  = self.Panel_role_item_uns,
        ["downItem"]                = self.Panel_role_item_uns,
        ["selItem"]                 = self.Panel_role_item_s,
        ["offsetX"]                 = 0,
        ["updateCellInfo"]          = handler(self.updateCellInfo,self),
        ["selCallback"]             = handler(self.selCallback,self),
        ["cellCount"]               = RoleDataMgr:getRoleCount(),
        ["isLoop"]                  = true,
        ["size"]                    = self.Panel_roleList:getContentSize(),
        ["isFromFairy"]             = true,
        ["callTouchBeganBack"]      = handler(self.tableCellTouchBegan,self),
        ["callTouchEndBack"]        = handler(self.tableCellTouched,self)
    }
    local scrollMenu = ScrollMenu:create(params);
    scrollMenu:setPosition(self.Panel_roleList:getPosition())
    self.Panel_roleList:getParent():removeChild(self.Panel_roleList:getParent():getChildByName("roleHeads"))
    self.Panel_roleList:getParent():addChild(scrollMenu,10)
    scrollMenu:setName("roleHeads")
    local jumpTo = RoleDataMgr:getRoleIdx(self.curId)
    scrollMenu:jumpTo(jumpTo);
    self.scrollMenu = scrollMenu
end

function NewRoleShowView:tableCellTouchBegan()
end

function NewRoleShowView:tableCellTouched(isFirst)
    self.ui:timeOut(function()
        if self.selectIdx ~= -1 or isFirst then
            self.firstIn = isFirst
            ViewAnimationHelper.doMoveFadeInAction(self.Panel_mid, {direction = 1, distance = 30, ease = 1})
            ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})
            self:selectOne(self.selectIdx)
            print("tableCellTouched self.selectIdx ",self.selectIdx)
            self.selectIdx = -1
        end
    end,isFirst and 0 or 0.35)
end

function NewRoleShowView:initItem(item,idx)
    item.Image_bottomNormal = TFDirector:getChildByPath(item, "Image_bottomNormal"):show()
    item.Image_bottomSelect = TFDirector:getChildByPath(item, "Image_bottomSelect"):hide()
    self:updateCellInfo(item,idx)
end

function NewRoleShowView:enterAction()

end

function NewRoleShowView:refreshBg(imageBg, bgPath)
    if bgPath then
        imageBg:setTexture(bgPath)
    end
    local height = imageBg:Size().height
    local width = imageBg:Size().width
    local scaleDisH = GameConfig.WS.height / height
    local scaleDisW = GameConfig.WS.width / width
    local scale = scaleDisH < scaleDisW and scaleDisW or scaleDisH
    local newWidth = width * scale
    local newHeigth = height * scale
    imageBg.disScale = scale
    imageBg.disSize = imageBg:Size()
    imageBg:setContentSize(CCSizeMake(newWidth, newHeigth))
end

function NewRoleShowView:updateRoleModel(modelId)
    local selectId = self.dressId_[self.selectDIdx]
    local data = dressTable[selectId]
    local curModelId = modelId or RoleDataMgr:getModel(self.curId)
    local isHModel = false
    if data and data.type and data.type == 2 then
        curModelId = data.highRoleModel
        isHModel = true
    end
    if self.modelId == curModelId then
        return
    end

    local curDayCid,curNightCid = SceneSoundDataMgr:getTempSceneCid()
    local sceneDayCfg = SceneSoundDataMgr:getMainSceneChange(curDayCid)
    local sceneNightCfg = SceneSoundDataMgr:getMainSceneChange(curNightCid)
    local hour = Utils:getTime(ServerDataMgr:getServerTime())
    local bgRes = "ui/mainLayer/new_ui/bg_morning.png"
    if hour <= 18 and hour >= 6 then
        if sceneDayCfg and sceneDayCfg.background then
            bgRes = sceneDayCfg.background
        end
    else
        if sceneNightCfg and sceneNightCfg.background then
            bgRes = sceneNightCfg.background
        end
    end
    self:refreshBg(self.Image_bg,bgRes)
    local isOk,isUnlock,ishave = self:checkChangeOk()
    self.Button_change:setGrayEnabled(not isOk)
    self.Button_change:setTouchEnabled(isOk)
    self.Button_changeScene:setVisible(isUnlock and ishave and not isOk)

    local isShowHuigu = self:findDressDatingTrigger()
    self.Button_huigu:setVisible(isShowHuigu)

    self.modelId = curModelId

    print("updateRoleModel self.modelId ",self.modelId)
    print("updateRoleModel self.curId ",self.curId)
    if self.model then
        if self.model.effectHandle then
            TFAudio.stopEffect(self.model.effectHandle)
            self.model.effectHandle = nil
        end
        self.model:removeFromParent()       
    end

    self.model = ElvesNpcTable:createLive2dNpcID(self.modelId,false,false,nil,true).live2d:hide()
    self.Panel_base:addChild(self.model,1)
    self.model:setScale(0.7); --缩放
    local pos = ccp(410,-100)
    self.model:setPosition(pos);--位置
    self.effectSK = self.effectSK or {}
    for k,v in pairs(self.effectSK) do
        v:removeFromParent()
        self.effectSK[k] = nil      
    end
    self.effectSKB = self.effectSKB or {}
    for k,v in pairs(self.effectSKB) do
        v:removeFromParent()
        self.effectSKB[k] = nil
    end

    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()

    local offPos = data.offSet
    if offPos and offPos.x and offPos.x ~= 0 and offPos.y and offPos.y ~= 0 then
        if data and data.type and data.type == 2 then
            self.model:setPosition(pos + ccp(offPos.x,offPos.y))
        else
            self.model:setPosition(pos + ccp(offPos.x-50,offPos.y))
        end
    end
    self.Panel_black:hide()

    if data.background and #data.background ~= 0 then
        if self.notFirst then
            self.Panel_black:show()
            self.Panel_black:setOpacity(255)
            self.Panel_black:runAction(CCFadeOut:create(0.5))
        end
        self.notFirst = true
        self.Image_bg2:show()
        self.Image_bg2:setTexture(data.background)
    else
        if self.Image_bg2:isVisible() then
            self.Panel_black:show()
            self.Panel_black:setOpacity(255)
            self.Panel_black:runAction(CCFadeOut:create(0.5))
            self.Image_bg2:hide()
        end
    end

    if data.backgroundEffect and data.backgroundEffect ~= 0 then
        self:refreshEffect(data.backgroundEffect,true)
    end

    if data.kanbanEffect and data.kanbanEffect ~= 0 then
        self:refreshEffect(data.kanbanEffect)
    end

    self:playBgm()
    self.model:show()

    if data and data.type and data.type == 2 then
        return
    end
    self.model:playMoveRightIn(0.3)
    --self.model:setZOrder(-1)
    --self.ui:timeOut(function()
    --    self.model:setZOrder(1)
    --    self.model:playMoveRightIn(0.3)
    --end,0.1)
end

function NewRoleShowView:refreshEffect(effectIds,isBgEffect)
    local mgrTab = nil
    local prefab = nil
    if not isBgEffect then
        mgrTab = self.effectSK or {}
        self.effectSK = mgrTab
        prefab = self.Spine_sceneEffect
    else
        mgrTab = self.effectSKB or {}
        self.effectSKB = mgrTab
        prefab = self.Spine_effectHB
    end

    for k,v in pairs(mgrTab) do
        v:removeFromParent()
        mgrTab[k] = nil
    end
    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()

    if type(effectIds) ~= "table" then
        local effectId = effectIds
        effectIds = {effectId}
    end

    for k,effectId in pairs(effectIds) do
        mgrTab[effectId] = Utils:createEffectByEffectId(effectId)
        if not mgrTab[effectId] then
            return
        end

        mgrTab[effectId]:setPosition(prefab:getPosition())
        prefab:getParent():addChild(mgrTab[effectId], prefab:getZOrder())
    end
end

function NewRoleShowView:updateRoleInfo()
    print("updateRoleInfo self.curId ", self.curId)
    local Label_desc = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_desc")
    Label_desc:setString(RoleDataMgr:getDesc(self.curId))

    local curRoleInfo = RoleDataMgr:getRoleInfo(self.curId)
    --身高
    local Label_height = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_height")
    Label_height:setString(curRoleInfo.height .. "cm")
    --三维
    local Label_threeDimensional = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_threeDimensional")
    Label_threeDimensional:setString(curRoleInfo.threeDimensional)
    --声优
    local Label_theme = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_theme")
    local akiraId = curRoleInfo.akiraId2 or curRoleInfo.akiraId
    Label_theme:setString(TextDataMgr:getText(akiraId))
    --生日
    local Label_birthday = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_birthday")
    Label_birthday:setString(curRoleInfo.birthday)
    --体重
    local Label_weight = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_weight")
    Label_weight:setString(curRoleInfo.weight .. "kg")
end

function NewRoleShowView:updateCellInfo(cell,cellIdx)
    local roleId = RoleDataMgr:getRoleIdByShowIdx(cellIdx);
    local ishave = RoleDataMgr:getIsHave(roleId)
    local icon = TFDirector:getChildByPath(cell,"Image_icon")
    icon:setTexture(RoleDataMgr:getHeadIconPath(roleId))
    local lock = TFDirector:getChildByPath(cell,"Image_lock")
    lock:setVisible(not ishave)
    local Image_use = TFDirector:getChildByPath(cell,"Image_use")
    Image_use:setVisible(roleId == self.useId)
end

function NewRoleShowView:selCallback(cell,cellIdx)
    --if self.isFirst then
    --    ViewAnimationHelper.doMoveFadeInAction(self.Panel_mid, {direction = 1, distance = 30, ease = 1})
    --    ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})
    --    self:selectOne(cellIdx)
    --    self.isFirst = false
    --end
    self.selectIdx = cellIdx
    print("selCallback cellIdx",cellIdx)
    cell:runAction(CCMoveBy:create(0.2, ccp(15, 0)))
end

function NewRoleShowView:selectOne(cellIdx)
    self:selectBtn(self.btnType_.dressType)
    local roleId = RoleDataMgr:getRoleIdByShowIdx(cellIdx)
    self.curId = roleId
    self:refreshData()
    self:showDressScroll()
    self:refreshMid()

    local isOk,isUnlock,ishave = self:checkChangeOk()
    self.Button_change:setGrayEnabled(not isOk)
    self.Button_change:setTouchEnabled(isOk)
    self.Button_changeScene:setVisible(isUnlock and ishave and not isOk)
    self:changeShowOne();

    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
    self.voiceHandle = VoiceDataMgr:playVoice("change_kanban",self.curId,self.dressId_[self.selectDIdx])

end

function NewRoleShowView:checkChangeOk()
    local dressId = self.dressId_[self.selectDIdx]
    local isUnlock = GoodsDataMgr:getDress(dressId)
    local ishave = RoleDataMgr:getIsHave(self.curId)

    local isOk = false
    local sendMsgType = 0
    if ishave then
        if self.curId ~= self.useId then
            sendMsgType = 1
            isOk = true
        end
    end
    if isUnlock and ishave then
        if dressId ~= self.useDressId then
            if sendMsgType == 0 then
                sendMsgType = 2
            else
                sendMsgType = 3
            end
            isOk = true
        end
    else
        isOk = false
    end
    self.sendMsgType = sendMsgType
    return isOk,isUnlock,ishave
end

function NewRoleShowView:changeShowOne()

    self:updateRoleInfo()
    self:updateRoleModel()
end

function NewRoleShowView:onSwitchRole()
    self.useId = RoleDataMgr:getUseId()
    --self:showRoleList()
    if self.scrollMenu.elements then
        for i, v in ipairs(self.scrollMenu.elements) do
            self:updateCellInfo(v,i)
        end
    end

    for i, v in ipairs(self.dressId_) do
        self:updateDressItem(i)
    end

    local isOk,isUnlock,ishave = self:checkChangeOk()
    self.Button_change:setGrayEnabled(not isOk)
    self.Button_change:setTouchEnabled(isOk)
    self.Button_changeScene:setVisible(isUnlock and ishave and not isOk)
end

function NewRoleShowView:switchRole()
    RoleDataMgr:switchRole(self.curId)
end

function NewRoleShowView:onChangeDressOk()

    self.useDressId = self.curRoleInfo.dressId
    local data = dressTable[self.useDressId]
    if not data then
        Box("数据为空，id: ".. self.useDressId)
        return
    end
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
    local quality = data.quality
    if quality == 1 then
        self.voiceHandle = VoiceDataMgr:playVoice("dress_low",self.curId)
    elseif quality > 1 then
        self.voiceHandle = VoiceDataMgr:playVoice("dress_high",self.curId)
    end
    for i, v in ipairs(self.dressId_) do
        self:updateDressItem(i)
    end

    local isOk,isUnlock,ishave = self:checkChangeOk()
    self.Button_change:setGrayEnabled(not isOk)
    self.Button_change:setTouchEnabled(isOk)
    self.Button_changeScene:setVisible(isUnlock and ishave and not isOk)

    self:playBgm()
end

function NewRoleShowView:onShow()
    self.super.onShow(self)
    self.list_ = RoleDataMgr:getTriggerDatingList(self.curId) or {}
    self:resetList()
    local isShowHuigu = self:findDressDatingTrigger()
    self.Button_huigu:setVisible(isShowHuigu)
    self:playBgm()
    if self.dressItemsList then
        for i, v in ipairs(self.dressItemsList) do
            self:updateDressItem(i)
        end
    end
    local isOk,isUnlock,ishave = self:checkChangeOk()
    self.Button_change:setGrayEnabled(not isOk)
    self.Button_change:setTouchEnabled(isOk)
    self.Button_changeScene:setVisible(isUnlock and ishave and not isOk)
    if self.model then
        self.model:show();
    end
end

function NewRoleShowView:onClose()
    self.super.onClose(self)
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
end

function NewRoleShowView:setBgm()
    local selectId = self.dressId_[self.selectDIdx]
    local data = dressTable[selectId]

    if data and data.type and data.type == 2 and data.kanbanBgmId then
        SceneSoundDataMgr:Send_SetBackGround(0,0,data.kanbanBgmId,data.kanbanBgmId)
    end
end

function NewRoleShowView:updateSwitchState()

    local isSwitch = RoleSwitchDataMgr:getSwitchState()
    self.Panel_play:setVisible(isSwitch)
    self.Image_notplay:setVisible(not isSwitch)
    local str = isSwitch and 111000105 or 111000104
    self.Label_change:setTextById(str)
    if not isSwitch then
        self.Image_circle:stopAllActions()
    else
        self.Image_circle:runAction(CCRepeatForever:create(CCRotateBy:create(3,360)))
    end

    for i, v in ipairs(self.dressId_) do
        self:updateDressItem(i)
    end
end

function NewRoleShowView:updateSwitchList()

    for i, v in ipairs(self.dressId_) do
        self:updateDressItem(i)
    end
end



function NewRoleShowView:registerEvents()

    EventMgr:addEventListener(self,EV_UPDATE_SWITCH_LIST,handler(self.updateSwitchList, self))
    EventMgr:addEventListener(self,EV_UPDATE_SWITCH_STATE,handler(self.updateSwitchState, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.switchRole, handler(self.onSwitchRole, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.changeDress, handler(self.onChangeDressOk, self))

    local function scrollCallback(target, offsetRate, customOffsetRate)
        self.TurnView_dressList.isScrolling = true
        local items = target:getItem()
        for i, item in ipairs(items) do
            local rate = offsetRate[i]
            if rate then
                local rrate = 1 - rate
                local customRate = customOffsetRate[i]
                item:setOpacity(255 * rrate)
                if customRate then
                    item:setPositionZ(-customRate * 100)
                end
                item:setZOrder(rrate * 100)
            end
        end
    end
    self.TurnView_dressList:registerScrollCallback(scrollCallback)
    self.TurnView_dressList:registerSelectCallback(handler(self.onPlotTurnViewSelect, self))

    self.Button_change:onClick(function()

        local function callback()
            if self.sendMsgType == 1 then
                self:setBgm()
                self:switchRole()
            elseif self.sendMsgType == 2 then
                self:setBgm()
                self:onOk()
            elseif self.sendMsgType == 3 then
                self:setBgm()
                self:switchRole()
                self:onOk(0.2)
            end

            RoleSwitchDataMgr:Send_TurnSwitchState(false)
            self.sendMsgType = 0
        end

        local isSwitch = RoleSwitchDataMgr:getSwitchState()
        if not isSwitch then
            callback()
            return
        end

        if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_SwitchKanBanState) then
            callback()
        else
            local content =  TextDataMgr:getText(111000107)
            Utils:openView("common.ReConfirmTipsView", {tittle = 310019, content = content, reType = EC_OneLoginStatusType.ReConfirm_SwitchKanBanState, confirmCall = callback})
        end

    end)

    self.Button_dress:onClick(function()
        self:selectBtn(self.btnType_.dressType)
    end)

    self.Button_info:onClick(function()
        self:selectBtn(self.btnType_.infoType)
    end)

    self.Button_unInfo:onClick(function()
        if self.TurnView_dressList.isScrolling then return end
        local dressId = self.dressId_[self.selectDIdx]
        local isUnlock = GoodsDataMgr:getDress(dressId)
        local ishave = RoleDataMgr:getIsHave(self.curId)
        if not isUnlock or not ishave then
            Utils:showTips(1701265)
            return
        end
        self:selectBtn(self.btnType_.unInfoType)
        self:showUnInfoList()
    end)

    self.Button_huigu:onClick(function ()
        local info = self:findDressDatingTrigger()
        if info then
            self.model:hide();
            DatingDataMgr:showDatingLayer(EC_DatingScriptType.SHOW_SCRIPT,info.currentNodeId,false,info.datingRuleCid)
        end
    end)

    self.Button_changeScene:onClick(function()
        AlertManager:closeLayer(self)
        Utils:openView("role.NewSceneShowView")
    end)

    self:setBackBtnCallback(function()
        local function confirmCallBack()
            local tempDayCid,tempNightCid = SceneSoundDataMgr:getTempSceneCid()
            local tempDayBgmCid,tempNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
            SceneSoundDataMgr:Send_SetBackGround(tempDayCid,tempNightCid,tempDayBgmCid,tempNightBgmCid)
            AlertManager:closeLayer(self)
        end
        local function cancleCallBack()
            SceneSoundDataMgr:resetTempSaveData()
            AlertManager:closeLayer(self)
        end
        local haveChange = SceneSoundDataMgr:sceneIsChanged()
        if haveChange then
            Utils:openView("role.NewSceneChangeConfirm",confirmCallBack,cancleCallBack)
        else
            AlertManager:closeLayer(self)
        end
    end)

    self:setMainBtnCallback(function()
        local function confirmCallBack()
            local tempDayCid,tempNightCid = SceneSoundDataMgr:getTempSceneCid()
            local tempDayBgmCid,tempNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
            SceneSoundDataMgr:Send_SetBackGround(tempDayCid,tempNightCid,tempDayBgmCid,tempNightBgmCid)
            AlertManager:closeLayer(self)
        end
        local function cancleCallBack()
            SceneSoundDataMgr:resetTempSaveData()
            AlertManager:closeLayer(self)
        end
        local haveChange = SceneSoundDataMgr:sceneIsChanged()
        if haveChange then
            Utils:openView("role.NewSceneChangeConfirm",confirmCallBack,cancleCallBack)
        else
            AlertManager:closeLayer(self)
        end
        return true
    end)

    self.Button_switch:onClick(function()

        local isSwitch = RoleSwitchDataMgr:getSwitchState()
        if not isSwitch then
            local openState = RoleSwitchDataMgr:getOpenState()
            if openState == 0 then
                Utils:openView("role.RoleSwitchSettingView",1)
            else
                RoleSwitchDataMgr:Send_TurnSwitchState(not isSwitch)
            end
        else
            RoleSwitchDataMgr:Send_TurnSwitchState(not isSwitch)
        end

    end)

    self.Button_switch_set:onClick(function()
        Utils:openView("role.RoleSwitchSettingView",2)
    end)
end

function NewRoleShowView:findDressDatingTrigger()
    local dressId = self.dressId_[self.selectDIdx]
    local datingRuleCid = self.dressDatingEvent_[dressId]
    local info = nil

    for i, v in ipairs(self.list_) do
        if v.datingRuleCid == datingRuleCid then
            info = v
        end
    end
    return info
end

function NewRoleShowView:playBgm()
    local selectId = self.dressId_[self.selectDIdx]
    local data = dressTable[selectId]

    if selectId == self.useDressId and self.curId == self.useId then
        local curDayBgmCid,curNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
        local bgmCid
        local hour = Utils:getTime(ServerDataMgr:getServerTime())
        if hour <= 18 and hour >= 6 then
            bgmCid = curDayBgmCid
        else
            bgmCid = curNightBgmCid
        end
        local soundCfg = SceneSoundDataMgr:getSoundInfoByCid(bgmCid)
        if soundCfg then
            AudioExchangePlay.playBGM(self, true,soundCfg.bgm)
        else
            AudioExchangePlay.playBGM(self, true,AudioExchangePlay.getDefaultBgm())
        end
    else
        if data and data.type and data.type == 2 and data.kanbanBgm and #data.kanbanBgm ~= 0 then
            AudioExchangePlay.playBGM(self, true,data.kanbanBgm)
        else
            local curDayBgmCid,curNightBgmCid = SceneSoundDataMgr:getCurSceneBgmId()
            local soundCfg = SceneSoundDataMgr:getSoundInfoByCid(curDayBgmCid)
            if soundCfg then
                AudioExchangePlay.playBGM(self, true,soundCfg.bgm)
            else
                AudioExchangePlay.playBGM(self, true,AudioExchangePlay.getDefaultBgm())
            end
        end
    end
end

return NewRoleShowView