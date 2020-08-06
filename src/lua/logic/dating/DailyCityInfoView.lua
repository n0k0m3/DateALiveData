
local DailyCityInfoView = class("DailyCityInfoView", BaseLayer)

function DailyCityInfoView:initData(isShow)
    self.isShow = isShow      --isShow为true只做显示不提供约会入口

    self.buildData_ = RoleDataMgr:getDayBuildList()

    self.buildItem_ = {}
    self.endTypeItem_ = {}
    self.uEndItem_ = {}

    self.buildDSIndex_ = 1
    self.buildSIndex_ = self.buildDSIndex_
    self.endTypeSIndex_ = -1
end

function DailyCityInfoView:ctor(isShow)
    self.super.ctor(self)
    self:initData(isShow)
    self:init("lua.uiconfig.dating.dailyCityInfoView")
end

function DailyCityInfoView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self:initButtonList()
    self:initLeft()
    self:initRight()

    self:refreshLeft()
    self:refreshRight()

    -- self:enterAction()
end

function DailyCityInfoView:enterAction()
    self.Panel_left:PosX(self.Panel_left:PosX()-1200)
    self.Panel_left:runAction(MoveTo:create(0.5,self.Panel_left.savePos))
    self.Panel_right:PosX(self.Panel_right:PosX()+1200)
    self.Panel_right:runAction(MoveTo:create(0.5,self.Panel_right.savePos))
    self.Panel_bottom:PosY(self.Panel_bottom:PosY()-1200)
    self.Panel_bottom:runAction(MoveTo:create(0.5,self.Panel_bottom.savePos))
end

function DailyCityInfoView:initButtonList()
    self.Button_day = TFDirector:getChildByPath(self.ui, "Button_day")
    self.Button_goods = TFDirector:getChildByPath(self.ui, "Button_goods")
    self.Button_dress = TFDirector:getChildByPath(self.ui,"Button_dress")
    self.Button_day.bar = self.Button_day:getChildByName("LoadingBar_p")
    self.Button_day.pr = self.Button_day:getChildByName("Label_p")
    self.Button_goods.bar = self.Button_goods:getChildByName("LoadingBar_p")
    self.Button_goods.pr = self.Button_goods:getChildByName("Label_p")
    self.Button_dress.bar = self.Button_dress:getChildByName("LoadingBar_p")
    self.Button_dress.pr = self.Button_dress:getChildByName("Label_p")

    --self.Button_day.bar:setPercent(RoleDataMgr:getDayDatingPro(self.roleId))
    --self.Button_day.pr:setText(RoleDataMgr:getDayDatingPro(self.roleId) .. "%")
    --self.Button_goods.bar:setPercent(RoleDataMgr:getTriggerDatingProByType(self.roleId,1))
    --self.Button_goods.pr:setText(RoleDataMgr:getTriggerDatingProByType(self.roleId,1) .. "%")
    --self.Button_dress.bar:setPercent(RoleDataMgr:getTriggerDatingProByType(self.roleId,2))
    --self.Button_dress.pr:setText(RoleDataMgr:getTriggerDatingProByType(self.roleId,2) .. "%")

    -- self.Button_day:getChildByName("Panel_touch"):Touchable(true)
    -- self.Button_day:getChildByName("Panel_touch"):onClick(function()
    --     self:showDayView()
    -- end)

    self.Button_goods:getChildByName("Panel_touch"):Touchable(true)
    self.Button_goods:getChildByName("Panel_touch"):onClick(function()
        self:showGoodsView()
    end)

    self.Button_dress:getChildByName("Panel_touch"):Touchable(true)
    self.Button_dress:getChildByName("Panel_touch"):onClick(function()
        self:showDressView()
    end)

    self.Button_cg = TFDirector:getChildByPath(self.ui, "Button_cg")
    self.Button_cg:getChildByName("Panel_touch"):Touchable(true)
    self.Button_cg:getChildByName("Panel_touch"):onClick(function()
        self:showMainView()
    end)
end

function DailyCityInfoView:showMainView()
    Utils:openView("dating.DatingPokedexSpriteView")
    AlertManager:closeLayer(self)
    -- local layer = require("lua.logic.dating.DatingPokedexSpriteView"):new()
    -- AlertManager:closeLayer(self)
    -- AlertManager:addLayer(layer, AlertManager.BLOCK)
    -- AlertManager:show()
end

function DailyCityInfoView:showDayView()
    Utils:openView("dating.DailyCityInfoView")
    AlertManager:closeLayer(self)
    -- local layer = require("lua.logic.dating.DailyCityInfoView"):new(true)
    -- AlertManager:closeLayer(self)
    -- AlertManager:addLayer(layer, AlertManager.BLOCK)
    -- AlertManager:show()
end

function DailyCityInfoView:showGoodsView()
    Utils:openView("dating.DatingGiftView")
    AlertManager:closeLayer(self)
    -- local layer = require("lua.logic.dating.DatingGiftView"):new()
    -- AlertManager:closeLayer(self)
    -- AlertManager:addLayer(layer, AlertManager.BLOCK)
    -- AlertManager:show()
end

function DailyCityInfoView:showDressView()
    Utils:openView("dating.DatingDressView")
    AlertManager:closeLayer(self)
    -- local layer = require("lua.logic.dating.DatingDressView"):new()
    -- AlertManager:closeLayer(self)
    -- AlertManager:addLayer(layer, AlertManager.BLOCK)
    -- AlertManager:show()
end

function DailyCityInfoView:initLeft()
    self.Panel_left = TFDirector:getChildByPath(self.Panel_root,"Panel_left")
    self.Panel_left.savePos = self.Panel_left:Pos()

    self:initBuildView()
    self:showBuildView()

    self:selectBuildItem(self.buildDSIndex_)
end

function DailyCityInfoView:initBuildView()
    local ScrollView_build = TFDirector:getChildByPath(self.Panel_left,"ScrollView_build")

    self.buildListView = UIListView:create(ScrollView_build)

    self.Panel_buildItem =  TFDirector:getChildByPath(self.Panel_prefab, "Panel_buildItem")
end

function DailyCityInfoView:refreshLeft()
    self:refreshBuildView()
end

function DailyCityInfoView:refreshBuildView()
    self:showBuildView()
end

function DailyCityInfoView:showBuildView()

    self.buildListView:removeAllItems()

    for i, v in ipairs(self.buildData_) do
        local Panel_buildItem = self.Panel_buildItem:clone()
        Panel_buildItem.data = v
        self.buildItem_[i] = Panel_buildItem
        self:initBuildItem(Panel_buildItem)
        self.buildListView:pushBackCustomItem(Panel_buildItem)
    end

    self:refreshBuildItems()
end

function DailyCityInfoView:initBuildItem(buildItem)
    local buildData = buildItem.data

    local buildId = buildData.buildId
    local isFavorPass = buildData.isFavorPass
    local isFubenPass = buildData.isFubenPass
    local nameId = buildData.nameId
    local unlock = DatingDataMgr:isBuildEndUnLock(buildData)
    local data = DatingDataMgr:getBuildDayScripInfo(buildId)

    buildItem.Image_normal = TFDirector:getChildByPath(buildItem, "Image_normal"):hide()
    local Label_buildName = TFDirector:getChildByPath(buildItem.Image_normal, "Label_buildName")
    local nameStr = ""
    if data.titleName and data.titleName ~= 0 then
        nameStr = TextDataMgr:getTextAttr(data.titleName).text
    else
        nameStr = TextDataMgr:getTextAttr(nameId).text
    end
    Label_buildName:setText(nameStr)
    local Image_tubiao = TFDirector:getChildByPath(buildItem.Image_normal, "Image_tubiao")
    local smallIconPath = DatingDataMgr:getBuildSmallIcon(buildId)
    Image_tubiao:setTexture(smallIconPath)

    buildItem.Image_select = TFDirector:getChildByPath(buildItem, "Image_select"):hide()
    local Image_buildIcon = TFDirector:getChildByPath(buildItem.Image_select, "Image_buildIcon")
    local iconPath = DatingDataMgr:getBuildIcon(buildId)
    Image_buildIcon:setTexture(iconPath)
    Image_buildIcon:Size(249,94)

    buildItem.Image_lock = TFDirector:getChildByPath(buildItem, "Image_lock"):hide()
    local Image_favorStar = TFDirector:getChildByPath(buildItem.Image_lock, "Image_favorStar"):hide()
    local Label_lock = TFDirector:getChildByPath(Image_favorStar, "Label_lock")
    local favorLevel = buildData.enter_condition.favor
    Label_lock:setText(favorLevel)

    local Label_fubenLock = TFDirector:getChildByPath(buildItem.Image_lock, "Label_fubenLock"):hide()
    local name = FubenDataMgr:getLevelName(buildData.enter_condition.pass) or ""
    Label_fubenLock:setTextById(950056, name)

    local Image_wanshang = TFDirector:getChildByPath(buildItem, "Image_wanshang"):hide()
    --Image_wanshang:setVisible(buildData.daytime == 1)
    if unlock then
        buildItem.Image_normal:show()
    else
        if  not isFavorPass then
            Image_favorStar:show()
        elseif not isFubenPass then
            Label_fubenLock:show()
        end
        buildItem.Image_lock:show()
    end

    buildItem.unlock = unlock
end

function DailyCityInfoView:refreshBuildItems()
    for i,v in ipairs(self.buildItem_) do
        self:updateBuildItem(v,i == self.buildSIndex_)
    end
end

function DailyCityInfoView:updateBuildItem(buildItem,isSelect)
    local buildData = buildItem.data
    local buildId = buildData.buildId
    local unlock = DatingDataMgr:isBuildEndUnLock(buildData)

    buildItem.Image_select:hide()
    buildItem.Image_normal:hide()
    buildItem.Image_lock:hide()

    if unlock then
        if isSelect then
            buildItem.Image_select:show()
        else
            buildItem.Image_normal:show()
        end
    else
        buildItem.Image_lock:show()
    end
end

function DailyCityInfoView:initRight()
    self.Panel_right = TFDirector:getChildByPath(self.Panel_root,"Panel_right")
    self.Panel_right.savePos = self.Panel_right:Pos()

    self:initEndTypeList()
    self:initEndView()
end

function DailyCityInfoView:refreshBuildInfo()
    local buildData = self.buildData_[self.buildSIndex_]

    local buildId = buildData.buildId
    local isFavorPass = buildData.isFavorPass
    local isFubenPass = buildData.isFubenPass
    local nameId = buildData.nameId
    local unlock =buildData.isUnlock
    local data = DatingDataMgr:getBuildDayScripInfo(buildId)

    local Label_name = TFDirector:getChildByPath(self.Panel_right,"Label_name")
    local Label_progress = TFDirector:getChildByPath(self.Panel_right,"Label_progress")
    Label_progress:setText(math.ceil(data.process))
    local LoadingBar_pro = TFDirector:getChildByPath(self.Panel_right,"LoadingBar_pro")
    LoadingBar_pro:setPercent(data.process)
    local nameStr = ""
    if data.titleName and data.titleName ~= 0 then
        nameStr = TextDataMgr:getTextAttr(data.titleName).text
    else
        nameStr = TextDataMgr:getTextAttr(nameId).text
    end
    Label_name:setTextById(950059,nameStr)

end

function DailyCityInfoView:initEndTypeList()
    self.Panel_endTypeList = TFDirector:getChildByPath(self.Panel_right,"Panel_endTypeList")
    local ScrollView_endTypeList = TFDirector:getChildByPath(self.Panel_endTypeList,"ScrollView_endTypeList")
    self.Panel_endTypeItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_endTypeItem")

    self.endTypeListView = UIListView:create(ScrollView_endTypeList)
    self.endTypeListView:setItemsMargin(10)

    self:showEndTypeListView()
end

function DailyCityInfoView:initEndView()
    self.Panel_endView = TFDirector:getChildByPath(self.ui,"Panel_endView"):hide()
    self.Button_closeView = TFDirector:getChildByPath(self.Panel_endView,"Button_closeView")
    self.Image_endType = TFDirector:getChildByPath(self.Panel_endView,"Image_endType")
    self.Label_endType = TFDirector:getChildByPath(self.Panel_endView, "Label_endType")
    local ScrollView_uEndList = TFDirector:getChildByPath(self.Panel_endView,"ScrollView_uEndList")
    self.Panel_sEndItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_sEndItem")

    self.uEndListView = UIListView:create(ScrollView_uEndList)
    local Image_scrollBarModel = TFDirector:getChildByPath(self.Panel_endView, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(self.Panel_endView, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.uEndListView:setScrollBar(scrollBar)

end

function DailyCityInfoView:showEndView(endInfo)
    self.Panel_endView:show()
    self:refreshEndView(endInfo)
end

function DailyCityInfoView:refreshEndView(endInfo)
    self.Image_endType:setTexture(DatingDataMgr:getEndTypeConfig(endInfo.type).endIcon)
    self.Label_endType:setText(DatingDataMgr:getEndTypeConfig(endInfo.type).endName)
    self:refreshUEndListView(endInfo)
end

function DailyCityInfoView:refreshUEndListView(endInfo)
    self:showUEndListView(endInfo)
end

function DailyCityInfoView:showUEndListView(endInfo)

    self.uEndListView:removeAllItems()
    self.uEndItem_ = {}

    for i, v in ipairs(endInfo.infoList) do
        local uEndInfo = v
        local Panel_sEndItem = self.Panel_sEndItem:clone()
        Panel_sEndItem.finish = uEndInfo.isFinsh
        Panel_sEndItem.desId = uEndInfo.desId
        self.uEndItem_[i] = Panel_sEndItem
        self.uEndListView:pushBackCustomItem(Panel_sEndItem)
    end

    self:initUEndItems()
end

function DailyCityInfoView:initUEndItems()
    for i,v in ipairs(self.uEndItem_) do
        self:initUEndItem(v)
    end
end

function DailyCityInfoView:initUEndItem(uEndItem)
    local Label_endDes = TFDirector:getChildByPath(uEndItem,"Label_endDes")
    Label_endDes:setTextById(uEndItem.desId)
    local Image_fnish = TFDirector:getChildByPath(uEndItem,"Image_fnish")
    Image_fnish:setVisible(uEndItem.finish)
    local Image_noFnish = TFDirector:getChildByPath(uEndItem,"Image_noFnish")
    Image_noFnish:setVisible(not uEndItem.finish)
end

function DailyCityInfoView:refreshEndTypeListView()
    self:showEndTypeListView()
end

function DailyCityInfoView:showEndTypeListView()

    self.endTypeListView:removeAllItems()
    local buildData = self.buildData_[self.buildSIndex_]
    local id = buildData.id
    local buildCfg = CityDataMgr:getBuildCfg(id)
    local endTypeListData = DatingDataMgr:getBuildEndList(buildData.buildId)

    if endTypeListData == nil then
        return
    end
    for i, v in ipairs(endTypeListData) do
        local Panel_endTypeItem = self.Panel_endTypeItem:clone()
        Panel_endTypeItem.endInfo = DatingDataMgr:getEndInfoByIdx(buildData.buildId,i)
        self.endTypeItem_[i] = Panel_endTypeItem
        self.endTypeListView:pushBackCustomItem(Panel_endTypeItem)
        Panel_endTypeItem:setOpacity(0)
        Panel_endTypeItem:timeOut(function()
            Panel_endTypeItem:fadeIn(0.1)
        end,i*0.1)
    end
    self:initEndTypeItems()
end

function DailyCityInfoView:initEndTypeItems()
    for i,v in ipairs(self.endTypeItem_) do
        self:initEndTypeItem(v)
        local Panel_endTypeTouch = v:getChildByName("Panel_endTypeTouch")
        Panel_endTypeTouch:onClick(function()
            self:selectEndTypeItem(i)
            end)
    end
    self:refreshEndTypeItems()
end

function DailyCityInfoView:initEndTypeItem(endTypeItem)
    local endInfo = endTypeItem.endInfo
    local Image_endhead = TFDirector:getChildByPath(endTypeItem,"Image_endhead")
    Image_endhead:setTexture(endInfo.moodPath .. DatingDataMgr:getEndTypeConfig(endInfo.type).headPath)
    local Image_endIcon = TFDirector:getChildByPath(endTypeItem,"Image_endIcon")
    Image_endIcon:setTexture(DatingDataMgr:getEndTypeConfig(endInfo.type).endIcon)
    local Label_endIcon = TFDirector:getChildByPath(endTypeItem, "Label_endIcon")
    Label_endIcon:setText(DatingDataMgr:getEndTypeConfig(endInfo.type).endName)

    self:initEndPro(endTypeItem)
end

function DailyCityInfoView:initEndPro(endTypeItem)
    local Panel_endPro = TFDirector:getChildByPath(endTypeItem,Panel_endPro)
    local Label_pro = TFDirector:getChildByPath(Panel_endPro,"Label_pro")
    local LoadingBar_end = TFDirector:getChildByPath(Panel_endPro,"LoadingBar_end")
    local Label_bili = TFDirector:getChildByPath(Panel_endPro,"Label_bili")

    local endInfo = endTypeItem.endInfo
    local num = #endInfo.finishList
    local allNum = #endInfo.list
    LoadingBar_end:setPercent(endInfo.process)
    Label_pro:setText( math.ceil(endInfo.process) .. "%" )
    Label_bili:setText(tostring(num) .. "/" .. tostring(allNum))
end

function DailyCityInfoView:refreshEndTypeItems()
    for i,v in ipairs(self.endTypeItem_) do
        self:updateEndTypeItem(v,i == self.endTypeSIndex_)
    end
end

function DailyCityInfoView:updateEndTypeItem(endTypeItem,isSelect)
    -- if isSelect == true then
    --     endTypeItem.select:show()
    -- else
    --     endTypeItem.select:hide()
    -- end
end

function DailyCityInfoView:selectEndTypeItem(index)
    if self.endTypeSIndex_ == index then return end
    self.endTypeSIndex_ = index

    self:refreshEndTypeItems()
    self:showEndView(self.endTypeItem_[index].endInfo)
end


function DailyCityInfoView:selectBuildItem(index)
    if self.buildSIndex_ == index then return end
    self.buildSIndex_ = index
    self:refreshBuildItems()
    self:refreshRight()
end

function DailyCityInfoView:refreshRight()
    local builData = self.buildData_[self.buildSIndex_]
    DatingDataMgr:selectBuildItem(builData)

    self:refreshEndTypeListView()
    self:refreshBuildInfo()
end

function DailyCityInfoView:onShow()
    self.super.onShow(self)
end

function DailyCityInfoView:onClose()
    self.super.onClose(self)
end

function DailyCityInfoView:registerEvents()
    self.Button_closeView:onClick(
        function()
            self.Panel_endView:hide()
            self.endTypeSIndex_ = -1
            self:refreshEndTypeItems()
        end,
        EC_BTN.BACK)

    for i,v in ipairs(self.buildItem_) do
        local buildTouch = v:getChildByName("Panel_buildTouch")
        buildTouch:onClick(function()
                local unlock = v.unlock
                if unlock then
                    self:selectBuildItem(i)
                else
                    Utils:showTips(206006)
                end
            end)
    end

    self.Panel_endView:onClick(function()
        self.Panel_endView:hide()
        self.endTypeSIndex_ = -1
        self:refreshEndTypeItems()
    end)
end
return DailyCityInfoView
