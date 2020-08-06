local NewSceneShowView = class("NewSceneShowView", BaseLayer)
require "lua.public.ScrollMenu"

local MenuType = {
    ["Scene"] = 1,
    ["Bgm"] = 2,
}

function NewSceneShowView:initData()

    self.selectSceneIdx = -1
    self.sceneItemsList = {}
    self.sceneGroupTab = SceneSoundDataMgr:getSceneGroupMap()
    self.soundCfg = SceneSoundDataMgr:getSoundCfg()

    self.useId = RoleDataMgr:getUseId()
    self.curModelId = RoleDataMgr:getModel(self.useId)
    self.curRoleInfo = RoleDataMgr:getRoleInfo(self.useId)
    self.useDressId = self.curRoleInfo.dressId or self.curRoleInfo.roleModel

    self.dressdata = nil
    local data = RoleDataMgr:useDressFindData()
    self.modelHaveBg = false
    if data and data.type and data.type == 2 then
        self.curModelId = data.highRoleModel
        self.dressdata = data
        self.modelHaveBg = true
        self.sceneBg = data.background
        if data.backgroundEffect and data.backgroundEffect ~= 0 then
            self.backgroundEffect = data.backgroundEffect
        end

        if data.kanbanEffect and data.kanbanEffect ~= 0 then
            self.kanbanEffect = data.kanbanEffect
        end
    end

    self.curGroupId = SceneSoundDataMgr:getCurSceneGroup()

    self.tempBgCid = {}
    self.tempBgmCid = {}
end

function NewSceneShowView:ctor(roleId, dressId)
    self.super.ctor(self)
    self:initData()

    self:init("lua.uiconfig.role.newSceneShowView")
end

function NewSceneShowView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_base = TFDirector:getChildByPath(self.ui, "Panel_base")

    self.Panel_left = TFDirector:getChildByPath(self.Panel_base, "Panel_left"):hide()
    self.Panel_sceneGroupList = TFDirector:getChildByPath(self.Panel_left, "Panel_sceneGroupList")

    self.Image_bg = TFDirector:getChildByPath(self.Panel_base, "Image_bg")

    self.Panel_black = TFDirector:getChildByPath(self.Panel_base, "Panel_black"):hide()
    self.Spine_sceneEffect = TFDirector:getChildByPath(self.ui, "Spine_sceneEffect"):hide()
    self.Spine_effectHB = TFDirector:getChildByPath(self.ui, "Spine_effectHB")

    self.Button_scene = TFDirector:getChildByPath(self.Panel_base, "Button_scene")
    self.Image_scene_select = TFDirector:getChildByPath(self.Button_scene, "Image_select")
    self.Button_bgm = TFDirector:getChildByPath(self.Panel_base, "Button_bgm")
    self.Image_bgm_select = TFDirector:getChildByPath(self.Button_bgm, "Image_select")

    self.Panel_ui = TFDirector:getChildByPath(self.Panel_base, "Panel_ui")
    self.Panel_scene = TFDirector:getChildByPath(self.Panel_ui, "Panel_scene")
    local ScrollView_sceneList = TFDirector:getChildByPath(self.Panel_ui, "ScrollView_sceneList")
    self.ListView_sceneList = UIListView:create(ScrollView_sceneList)
    self.Button_jump = TFDirector:getChildByPath(self.Panel_ui, "Button_jump")

    self.Panel_bgm = TFDirector:getChildByPath(self.Panel_ui, "Panel_bgm"):hide()
    local ScrollView_bgm = TFDirector:getChildByPath(self.Panel_ui, "ScrollView_bgm")
    self.ListViewBgm = UIListView:create(ScrollView_bgm)
    self.ListViewBgm:setItemsMargin(10)

    --local Image_scrollBarModel = TFDirector:getChildByPath(self.Panel_bgm, "Image_scrollBarModel")
    --local Image_scrollBarInner = TFDirector:getChildByPath(self.Panel_bgm, "Image_scrollBarInner")
    --local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    --self.ListViewBgm:setScrollBar(scrollBar)

    self.Button_rollback = TFDirector:getChildByPath(self.Panel_ui, "Button_rollback")
    self.rollbackIcon = TFDirector:getChildByPath(self.Button_rollback, "Image_huigu")
    self.Button_hideModel = TFDirector:getChildByPath(self.Panel_ui, "Button_hideModel")
    self.Image_forbid = TFDirector:getChildByPath(self.Button_hideModel, "Image_forbid"):hide()
    self.Button_hideUI = TFDirector:getChildByPath(self.Panel_ui, "Button_hideUI")
    self.Button_day = TFDirector:getChildByPath(self.Panel_ui, "Button_day")
    self.Button_night = TFDirector:getChildByPath(self.Panel_ui, "Button_night")

    self.Panel_mid = TFDirector:getChildByPath(self.ui, "Panel_mid")
    self.Label_role_name = TFDirector:getChildByPath(self.ui, "Label_role_name")
    self.Label_enName = TFDirector:getChildByPath(self.ui, "Label_enName")
 
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Panel_role_item_s = TFDirector:getChildByPath(self.Panel_prefab, "Panel_role_item_s")
    self.Panel_role_item_uns = TFDirector:getChildByPath(self.Panel_prefab, "Panel_role_item_uns")
    self.Panel_scene_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_scene_item")
    self.Panel_bgmItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_bgmItem")

    EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)

    self:setCurSceneBg()
    self:initLeft()
    self:showModelInfo()
    self:initBgmList()
    local menuType = self.modelHaveBg and MenuType.Bgm or MenuType.Scene
    self:chooseMenu(menuType)
    self:tableCellTouched(true)
end

function NewSceneShowView:setCurSceneBg()

    local tempDayCid,tempNightCid = SceneSoundDataMgr:getTempSceneCid()
    if not tempDayCid or not tempNightCid then
        return
    end

    local cid = tempDayCid
    local hour = Utils:getTime(ServerDataMgr:getServerTime())
    if hour <= 18 and hour >= 6 then
        cid = tempDayCid
    else
        cid = tempNightCid
    end

    local sceneChangeCfg = SceneSoundDataMgr:getMainSceneChange(cid)
    if self.sceneBg then
        --self.Image_bg:setTexture(self.sceneBg)
        self:refreshBg(self.Image_bg,self.sceneBg)
    else
        if sceneChangeCfg then
            --self.Image_bg:setTexture(sceneChangeCfg.background)
            self:refreshBg(self.Image_bg,sceneChangeCfg.background)
        end
    end

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

    if self.backgroundEffect then
        self:refreshEffect(self.backgroundEffect,true)
    end

    if self.kanbanEffect then
        self:refreshEffect(self.kanbanEffect)
    end
end

function NewSceneShowView:refreshEffect(effectIds,isBgEffect)
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
function NewSceneShowView:chooseMenu(menuType)

    self.menuType = menuType
    self.Panel_left:setVisible(menuType == MenuType.Scene)

    self.Image_scene_select:setVisible(menuType == MenuType.Scene)
    self.Image_bgm_select:setVisible(menuType == MenuType.Bgm)

    self.Panel_scene:setVisible(menuType == MenuType.Scene)
    self.Panel_sceneGroupList:setVisible(menuType == MenuType.Scene)
    self.Panel_bgm:setVisible(menuType == MenuType.Bgm)

    local posX = menuType == MenuType.Scene and 160 or 73
    self.Button_jump:setPositionX(posX)

    local posX = menuType == MenuType.Scene and 636 or 790
    local btnRes = menuType == MenuType.Scene and "ui/role/newScene/icon_01.png" or "ui/role/newScene/icon_07.png"
    self.rollbackIcon:setTexture(btnRes)
    self.Button_rollback:setPositionX(posX)
    self.Button_hideModel:setVisible(menuType == MenuType.Scene)
    self.Button_hideUI:setVisible(menuType == MenuType.Scene)

    if menuType == MenuType.Scene then
        self:updateSceneItemList()
    else
        self:updateBgmList()
    end
end

function NewSceneShowView:updateBgImg(selectCid)

    local mainScenceCfg = SceneSoundDataMgr:getMainSceneChange(selectCid)
    if not mainScenceCfg then
        return
    end

    self.chooseBgCid = selectCid

    if not self.notShowBlack then
        self.Panel_black:show()
        self.Panel_black:setOpacity(255)
        self.Panel_black:runAction(CCFadeOut:create(0.5))
    else
        self.notShowBlack = false
    end

    if self.modelHaveBg then
        return
    end

    self:refreshBg(self.Image_bg,mainScenceCfg.background)
    --self.Image_bg:setTexture(mainScenceCfg.background)

    local isUnLock = CollectDataMgr:isCollectItemExist(EC_CollectType.SCENE,self.chooseBgCid)
    if not isUnLock then
        self.Button_day:setTouchEnabled(false)
        self.Button_day:setGrayEnabled(true)
        self.Button_night:setTouchEnabled(false)
        self.Button_night:setGrayEnabled(true)
    else
        local tempDaySceneCid,tempNightSceneCid = SceneSoundDataMgr:getTempSceneCid()
        self.Button_day:setTouchEnabled(tempDaySceneCid ~= self.chooseBgCid)
        self.Button_day:setGrayEnabled(tempDaySceneCid == self.chooseBgCid)
        self.Button_night:setTouchEnabled(tempNightSceneCid ~= self.chooseBgCid)
        self.Button_night:setGrayEnabled(tempNightSceneCid == self.chooseBgCid)
    end
end

function NewSceneShowView:refreshBg(imageBg, bgPath)
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

function NewSceneShowView:showModelInfo()
    self.modelVisible = true

    self.model = ElvesNpcTable:createLive2dNpcID(self.curModelId,false,false,nil,true).live2d
    self.Panel_mid:addChild(self.model,1)
    self.model:setScale(0.7); --缩放
    local pos = ccp(330,-100)
    self.model:setPosition(pos);--位置
    self.model:playMoveRightIn(0.3)

    if self.dressdata then
        local offPos = self.dressdata.offSet
        if offPos and offPos.x and offPos.x ~= 0 and offPos.y and offPos.y ~= 0 then
            if self.dressdata.type and self.dressdata.type == 2 then
                self.model:setPosition(pos + ccp(offPos.x,offPos.y))
            else
                self.model:setPosition(pos + ccp(offPos.x-50,offPos.y))
            end
        end
    end
end

function NewSceneShowView:initBgmList()

    self.ListViewBgm:removeAllItems()
    self.bgmItemsList = {}
    local tempDayBgmCid,tempNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
    local bgmCid
    local hour = Utils:getTime(ServerDataMgr:getServerTime())
    if hour <= 18 and hour >= 6 then
        bgmCid = tempDayBgmCid
    else
        bgmCid = tempNightBgmCid
    end

    table.sort(self.soundCfg,function(a,b)
        local isunclockA = CollectDataMgr:isCollectItemExist(EC_CollectType.BGM,a.id)
        local isunclockB = CollectDataMgr:isCollectItemExist(EC_CollectType.BGM,b.id)
        local lockA = isunclockA and 1 or 0
        local lockB = isunclockB and 1 or 0
        return lockA > lockB
    end)

    local jumpTo
    for i, v in ipairs(self.soundCfg) do
        local item = self.Panel_bgmItem:clone()
        self:updateBgmItem(item,v)
        self.ListViewBgm:pushBackCustomItem(item,v)
        if v.id == bgmCid then
            jumpTo = i
        end
        self.bgmItemsList[i] = item
    end
    jumpTo = jumpTo or 1

    self.ListViewBgm:scrollToItem(jumpTo,0.1)
    self.ListViewBgm:doLayout()
    local selectItem = self.bgmItemsList[jumpTo]
    local Image_select = TFDirector:getChildByPath(selectItem, "Image_select")
    Image_select:setVisible(true)
    self.selectBgmImg = Image_select
    local Spine_playbgm = TFDirector:getChildByPath(selectItem, "Spine_playbgm")
    Spine_playbgm:setVisible(true)
    self.Spine_playbgm = Spine_playbgm

    self:playBgm(self.soundCfg[jumpTo].bgm,self.soundCfg[jumpTo].id)
end

function NewSceneShowView:updateBgmList(isJump)

    local jumpId = 1
    local tempDayBgmCid,tempNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
    for i, v in ipairs(self.soundCfg) do
        local item = self.bgmItemsList[i]
        self:updateBgmItem(item,v)
        if v.id == self.curBgmId then
            jumpId = i
        end
    end
    local Image_select = TFDirector:getChildByPath(self.bgmItemsList[jumpId], "Image_select")
    Image_select:setVisible(true)
    self.selectBgmImg = Image_select
    local Spine_playbgm = TFDirector:getChildByPath(self.bgmItemsList[jumpId], "Spine_playbgm")
    Spine_playbgm:setVisible(true)
    self.Spine_playbgm = Spine_playbgm
    self:playBgm(self.soundCfg[jumpId].bgm,self.soundCfg[jumpId].id)

    if isJump then
        self.ListViewBgm:scrollToItem(jumpId,0.1)
    end
end

function NewSceneShowView:updateBgmItem(item,data)

    local Label_bgmname = item:getChildByName("Label_bgmname")
    Label_bgmname:setTextById(data.name)
    local Image_select = item:getChildByName("Image_select"):hide()

    local tempDayBgmCid,tempNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
    local Image_daybgm = item:getChildByName("Image_daybgm")
    Image_daybgm:setVisible(tempDayBgmCid == data.id)
    local Image_nightbgm = item:getChildByName("Image_nightbgm")
    Image_nightbgm:setVisible(tempNightBgmCid == data.id)
    local Spine_playbgm = item:getChildByName("Spine_playbgm")
    Spine_playbgm:play("animation",1)
    Spine_playbgm:hide()

    if tempDayBgmCid == data.id and tempNightBgmCid == data.id then
        Image_daybgm:setPositionY(14)
        Image_nightbgm:setPositionY(-14)
    else
        Image_daybgm:setPositionY(0)
        Image_nightbgm:setPositionY(0)
    end

    local isUnLock = CollectDataMgr:isCollectItemExist(EC_CollectType.BGM,data.id)
    local Image_back = item:getChildByName("Image_back")
    Image_back:setVisible(isUnLock)

    local Image_lock = item:getChildByName("Image_lock")
    Image_lock:setVisible(not isUnLock)

    local Label_des1 = item:getChildByName("Label_des1")
    local posY = isUnLock and 0 or 14
    Label_des1:setPositionY(posY)
    local unlockStr = data.unlockDescribe2 and TextDataMgr:getText(data.unlockDescribe2) or ""
    local textStr = isUnLock and "BGM" or unlockStr
    Label_des1:setText("")
    local Label_des2 = item:getChildByName("Label_des2")
    Label_des2:setVisible(false)
    Label_des2:setTextById(data.unlockDescribe1)

    local color = isUnLock and ccc3(107, 118, 146) or ccc3(206, 212, 227)
    Label_bgmname:setColor(color)
    Label_des1:setColor(color)
    Label_des2:setColor(color)



    item:onClick(function()
        if self.curBgmId == data.id then
            return
        end
        if self.selectBgmImg then
            self.selectBgmImg:setVisible(false)
        end
        self.selectBgmImg = Image_select
        self.selectBgmImg:setVisible(true)

        if self.Spine_playbgm then
            self.Spine_playbgm:setVisible(false)
        end
        self.Spine_playbgm = Spine_playbgm
        self.Spine_playbgm:setVisible(true)

        self:playBgm(data.bgm,data.id)
    end)
end

function NewSceneShowView:playBgm(bgm,soundCid)

    if not bgm or not soundCid then
        return
    end
    self.curBgmId = soundCid

    ---配置表的默认音乐替换
    if bgm == "sound/bgm/main_OneYear.mp3" then
        local isOneYear = FunctionDataMgr:isMainLayerOneYearUI()
        bgm = isOneYear and "sound/bgm/main_OneYear.mp3" or "sound/bgm/main_001.mp3"
    end

    AudioExchangePlay.playBGM(self, true,bgm)

    local isUnLock = CollectDataMgr:isCollectItemExist(EC_CollectType.BGM,soundCid)
    if not isUnLock then
        self.Button_day:setTouchEnabled(false)
        self.Button_day:setGrayEnabled(true)
        self.Button_night:setTouchEnabled(false)
        self.Button_night:setGrayEnabled(true)
    else
        local tempDayBgmCid,tempNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
        self.Button_day:setTouchEnabled(tempDayBgmCid ~= self.curBgmId)
        self.Button_day:setGrayEnabled(tempDayBgmCid == self.curBgmId)
        self.Button_night:setTouchEnabled(tempNightBgmCid ~= self.curBgmId)
        self.Button_night:setGrayEnabled(tempNightBgmCid == self.curBgmId)
    end

end

function NewSceneShowView:initLeft()

    local params = {
        ["upItem"]                  = self.Panel_role_item_uns,
        ["downItem"]                = self.Panel_role_item_uns,
        ["selItem"]                 = self.Panel_role_item_s,
        ["offsetX"]                 = 0,
        ["updateCellInfo"]          = handler(self.updateCellInfo,self),
        ["selCallback"]             = handler(self.selCallback,self),
        ["cellCount"]               = #self.sceneGroupTab,
        ["isLoop"]                  = true,
        ["size"]                    = self.Panel_sceneGroupList:getContentSize(),
        ["isFromFairy"]             = true,
        ["callTouchBeganBack"]      = handler(self.tableCellTouchBegan,self),
        ["callTouchEndBack"]        = handler(self.tableCellTouched,self)
    }
    local scrollMenu = ScrollMenu:create(params);
    scrollMenu:setPosition(self.Panel_sceneGroupList:getPosition())
    self.Panel_sceneGroupList:getParent():removeChild(self.Panel_sceneGroupList:getParent():getChildByName("roleHeads"))
    self.Panel_sceneGroupList:getParent():addChild(scrollMenu,10)
    scrollMenu:setName("sceneGroup")

    local tempDayCid,tempNightCid = SceneSoundDataMgr:getTempSceneCid()
    local cid = tempDayCid
    local hour = Utils:getTime(ServerDataMgr:getServerTime())
    if hour <= 18 and hour >= 6 then
        cid = tempDayCid
    else
        cid = tempNightCid
    end
    local sceneCfg = SceneSoundDataMgr:getMainSceneChange(cid)
    local groupId = self.curGroupId
    if sceneCfg then
        groupId = sceneCfg.groupBelong
    end
    local jumpTo = 1
    for k,v in ipairs(self.sceneGroupTab) do
        if groupId == v.id then
            jumpTo = k
            break
        end
    end
    scrollMenu:jumpTo(jumpTo);
    self.scrollMenu = scrollMenu

end

function NewSceneShowView:updateCellInfo(cell,cellIdx)
    local groupInfo = self.sceneGroupTab[cellIdx]
    if not groupInfo then
        return
    end
    local icon = TFDirector:getChildByPath(cell,"Image_icon")
    icon:setTexture(groupInfo.icon)
    local lock = TFDirector:getChildByPath(cell,"Image_lock")
    lock:setVisible(false)
    local Image_day = TFDirector:getChildByPath(cell,"Image_day")
    local Image_night = TFDirector:getChildByPath(cell,"Image_night")
    local isUsingDay,isUsingNight = SceneSoundDataMgr:isUsingGroup(groupInfo.id)
    Image_day:setVisible(isUsingDay)
    Image_night:setVisible(isUsingNight)
end

function NewSceneShowView:selCallback(cell,cellIdx)
    self.selectIdx = cellIdx
    cell:runAction(CCMoveBy:create(0.2, ccp(15, 0)))
end

function NewSceneShowView:tableCellTouched(isFirst)
    self.ui:timeOut(function()
        if self.selectIdx ~= -1 or isFirst then
            self.firstIn = isFirst
            if isFirst then
                ViewAnimationHelper.doMoveFadeInAction(self.Panel_mid, {direction = 1, distance = 30, ease = 1})
                ViewAnimationHelper.doMoveFadeInAction(self.Panel_ui, {direction = 2, distance = 30, ease = 1})
            end
            self.selectSceneIdx = self.selectIdx
            self:showSceneItemList()
            self.selectIdx = -1
        end
        me.TextureCache:removeUnusedTextures()
        SpineCache:getInstance():clearUnused()
    end,isFirst and 0 or 0.35)

end

function NewSceneShowView:showSceneItemList()

    self.ListView_sceneList:removeAllItems()
    me.TextureCache:removeUnusedTextures()
    
    self.sceneItemsList = {}
    self.selectImg = nil
    local groupInfo = self.sceneGroupTab[self.selectSceneIdx]
    if not groupInfo then
        return
    end

    self.Label_role_name:setTextById(groupInfo.name)
    self.Label_enName:setString("Scene")

    local sceneList = SceneSoundDataMgr:getMainSceneChangeMap(groupInfo.id)
    if not sceneList then
        return
    end

    table.sort(sceneList,function(a,b)
        local isunclockA = CollectDataMgr:isCollectItemExist(EC_CollectType.SCENE,a.id)
        local isunclockB = CollectDataMgr:isCollectItemExist(EC_CollectType.SCENE,b.id)
        local lockA = isunclockA and 1 or 0
        local lockB = isunclockB and 1 or 0

        return lockA > lockB
    end)


    local tempDayCid,tempNightCid = SceneSoundDataMgr:getTempSceneCid()
    local cid = tempDayCid
    local hour = Utils:getTime(ServerDataMgr:getServerTime())
    if hour <= 18 and hour >= 6 then
        cid = tempDayCid
    else
        cid = tempNightCid
    end

    local jumpTo
    for i, v in ipairs(sceneList) do
        local sceneItem = self.Panel_scene_item:clone()
        self:updateSceneItem(sceneItem,v)
        self.ListView_sceneList:pushBackCustomItem(sceneItem)
        if v.id == cid then
            jumpTo = i
        end
        self.sceneItemsList[i] = sceneItem
    end

    jumpTo = jumpTo or 1
    self.ListView_sceneList:scrollToItem(jumpTo,0.1)
    local selectItem = self.sceneItemsList[jumpTo]
    local Image_select = TFDirector:getChildByPath(selectItem, "Image_select")
    Image_select:setVisible(true)
    self.selectImg = Image_select
    self.ListView_sceneList:doLayout()
    self:updateBgImg(sceneList[jumpTo].id)
end

function NewSceneShowView:updateSceneItemList()

    local groupInfo = self.sceneGroupTab[self.selectSceneIdx]
    if not groupInfo then
        return
    end

    local sceneList = SceneSoundDataMgr:getMainSceneChangeMap(groupInfo.id)
    if not sceneList then
        return
    end

    local jumpTo = 1
    for i, v in ipairs(sceneList) do
        local sceneItem = self.sceneItemsList[i]
        self:updateSceneItem(sceneItem,v)
        if v.id == self.chooseBgCid then
            jumpTo = i
        end
    end
    local Image_select = TFDirector:getChildByPath(self.sceneItemsList[jumpTo], "Image_select")
    Image_select:setVisible(true)
    self.selectImg = Image_select
    self:updateBgImg(sceneList[jumpTo].id)
end

function NewSceneShowView:updateSceneItem(sceneItem,data)

    local Image_ground = TFDirector:getChildByPath(sceneItem, "Image_ground")
    local Label_name = TFDirector:getChildByPath(sceneItem, "Label_name")
    local Image_lock = TFDirector:getChildByPath(sceneItem, "Image_lock")
    local Image_select = TFDirector:getChildByPath(sceneItem, "Image_select"):hide()
    local Image_dayIcon = TFDirector:getChildByPath(sceneItem, "Image_dayIcon")
    local Image_nightIcon = TFDirector:getChildByPath(sceneItem, "Image_nightIcon")
    local Button_detail = TFDirector:getChildByPath(sceneItem, "Button_detail")
    Button_detail:setOpacity(153)
    Image_ground:setTexture(data.icon)
    Label_name:setTextById(data.name)
    local isunclock = CollectDataMgr:isCollectItemExist(EC_CollectType.SCENE,data.id)
    Image_lock:setVisible(not isunclock)
    local tempDayCid,tempNightCid = SceneSoundDataMgr:getTempSceneCid()
    Image_dayIcon:setVisible(data.id == tempDayCid)
    Image_nightIcon:setVisible(data.id == tempNightCid)
    Button_detail:onClick(function()
        Utils:showTips(data.unlockHint)
    end)
    sceneItem:onClick(function()

        if self.chooseBgCid == data.id then
            return
        end

        if self.selectImg then
            self.selectImg:setVisible(false)
        end
        Image_select:setVisible(true)
        self.selectImg = Image_select
        self:updateBgImg(data.id)
    end)
end

function NewSceneShowView:onHide()
    self.super.onHide(self)
end

function NewSceneShowView:onShow()
    self.super.onShow(self)
end

function NewSceneShowView:hideOrShowModel()

    if not self.model then
        return
    end
    self.modelVisible = not self.modelVisible
    self.model:setVisible(self.modelVisible)
    self.Image_forbid:setVisible(not self.modelVisible)
end

function NewSceneShowView:hideOrShowUI(visible)

    self.Panel_ui:setVisible(visible)
    if visible then
        self:showTopBar()
    else
        self:hideTopBar()
    end
    --self.Panel_mid:setVisible(visible)
end

function NewSceneShowView:saveTempChoose(isDay)

    if self.menuType == MenuType.Scene then
        if isDay then
            self.tempBgCid.day = self.chooseBgCid
        else
            self.tempBgCid.night = self.chooseBgCid
        end
        SceneSoundDataMgr:setTempSceneCid(self.tempBgCid.day,self.tempBgCid.night)
        self:updateSceneItemList()

        if self.scrollMenu.elements then
            for i, v in ipairs(self.scrollMenu.elements) do
                self:updateCellInfo(v,i)
            end
        end

    elseif self.menuType == MenuType.Bgm then
        if isDay then
            self.tempBgmCid.day = self.curBgmId
        else
            self.tempBgmCid.night = self.curBgmId
        end
        SceneSoundDataMgr:setTempBgmCid(self.tempBgmCid.day,self.tempBgmCid.night)
        self:updateBgmList()
    end
end

function NewSceneShowView:senceRollBack()
    self.tempBgCid = {}
    local curDayCid,curNightCid = SceneSoundDataMgr:getCurSceneCid()
    SceneSoundDataMgr:setTempSceneCid(curDayCid,curNightCid)
    self:updateSceneItemList()
end

function NewSceneShowView:bgmRollBack()

    local mainScenceCfg = SceneSoundDataMgr:getMainSceneChange(self.chooseBgCid)
    if mainScenceCfg then
        self.curBgmId = mainScenceCfg.EXA
    end

    if self.modelHaveBg then
        self.curBgmId = self.dressdata.kanbanBgmId
    end
    self:updateBgmList(true)
end

function NewSceneShowView:registerEvents()

    self.Button_scene:onClick(function()
        if self.modelHaveBg then
            Utils:showTips(800130)
            return
        end
        self.notShowBlack = true
        self:chooseMenu(MenuType.Scene)
    end)

    self.Button_bgm:onClick(function()
        self:chooseMenu(MenuType.Bgm)
    end)

    self.Button_hideModel:onClick(function()
        self:hideOrShowModel()
    end)

    self.Button_hideUI:onClick(function()
        self.uiVisible = false
        self:hideOrShowUI(false)
    end)

    self.Image_bg:onClick(function()
        if self.uiVisible == false then
            self.uiVisible = true
            self:hideOrShowUI(true)
        end
    end)

    self.Button_rollback:onClick(function()

        if self.menuType == MenuType.Bgm then
            self:bgmRollBack()
        else
            local function confirmRollBack()
                self:senceRollBack()
            end
            if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_NewSceneShowView) then
                confirmRollBack()
            else
                if not self.tempBgCid.day and not self.tempBgCid.night then
                    return
                end
                local content = TextDataMgr:getText(1702396)
                Utils:openView("common.ReConfirmTipsView", {tittle = 1702395, content = content, reType = EC_OneLoginStatusType.ReConfirm_NewSceneShowView, confirmCall = confirmRollBack})
            end
        end
    end)

    self.Button_day:onClick(function()
        self:saveTempChoose(true)
    end)

    self.Button_night:onClick(function()
        self:saveTempChoose(false)
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

    self.Button_jump:onClick(function()
        Utils:openView("role.NewRoleShowView")
        AlertManager:closeLayer(self)
    end)
end

return NewSceneShowView