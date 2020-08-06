local NewDatingDayView = class("NewDatingDayView",BaseLayer)
require "lua.public.UIObliqueList"

function NewDatingDayView:initData()
    self.buildData_ = RoleDataMgr:getDayBuildList()
    self.buildItem_ = {}
    self.buildDSIndex_ = 1
    self.buildSIndex_ = self.buildDSIndex_
    self.curBuildId = nil
end


function NewDatingDayView:ctor()
    self.super.ctor(self)

    self:initData()

    self:init("lua.uiconfig.dating.newDatingDayView")
end

function NewDatingDayView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Panel_base = TFDirector:getChildByPath(self.ui, "Panel_base")
    self.Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")
    self.Panel_cg = TFDirector:getChildByPath(self.ui, "Panel_cg")
    self.Panel_itemRoot = TFDirector:getChildByPath(self.ui, "Panel_itemRoot")
    self.Panel_itemRoot.Panel_item = TFDirector:getChildByPath(self.Panel_itemRoot, "Panel_item"):show()
    self.Panel_itemRoot.Panel_itemS = TFDirector:getChildByPath(self.Panel_itemRoot, "Panel_itemS"):hide()
    self.Panel_roleList = TFDirector:getChildByPath(self.ui, "Panel_roleList")
    self.Panel_reward = TFDirector:getChildByPath(self.ui, "Panel_reward")
    self.Button_enter = TFDirector:getChildByPath(self.ui, "Button_enter")
    self.Panel_info = TFDirector:getChildByPath(self.ui, "Panel_info")
    self.Panel_info.infoDi = TFDirector:getChildByPath(self.ui, "Image_infoDi")
    self.Panel_info.infoDi.savePos = self.Panel_info.infoDi:Pos()

    --屏蔽日常约会奖励
    --self:loadingReward()
    self:initTableView()
    self:tableCellTouched(true)
    self:initOther()
end

function NewDatingDayView:onShow()
    self.super.onShow(self)

    local Label_times = TFDirector:getChildByPath(self.ui, "Label_times")
    Label_times:setText(DatingDataMgr:getDayDatingTimes())
end

function NewDatingDayView:initOther()
    local Label_times = TFDirector:getChildByPath(self.ui, "Label_times")
    Label_times:setText(DatingDataMgr:getDayDatingTimes())
    local Label_maxTimes = TFDirector:getChildByPath(self.ui, "Label_maxTimes")
    Label_maxTimes:setText("/"..DatingDataMgr:getDayDatingMaxTimes())
end

function NewDatingDayView:refreshPanelInfo()

    local buildData = self.buildData_[self.buildSIndex_]
    local data = DatingDataMgr:getBuildDayScripInfo(buildData.buildId)
    local unlock = DatingDataMgr:isBuildEndUnLock(buildData)

    local Label_name = TFDirector:getChildByPath(self.Panel_info, "Label_name")
    local Image_unlock = TFDirector:getChildByPath(self.Panel_info, "Image_unlock"):hide()
    Image_unlock.title = TFDirector:getChildByPath(Image_unlock, "Label_title")
    Image_unlock.pro = TFDirector:getChildByPath(Image_unlock, "Label_pro")
    local Image_lock = TFDirector:getChildByPath(self.Panel_info, "Image_lock"):hide()
    Image_lock.title = TFDirector:getChildByPath(Image_lock, "Label_title")
    local Label_des = TFDirector:getChildByPath(self.Panel_info, "Label_des")

    if data.buildDes then
        Label_des:setTextById(data.buildDes)
    end

    local nameStr = ""
    if data.titleName and data.titleName ~= 0 then
        nameStr = TextDataMgr:getTextAttr(data.titleName).text
    else
        nameStr = TextDataMgr:getTextAttr(data.nameId).text
    end
    Label_name:setText(nameStr)

    Image_unlock.pro:setText(math.ceil(data.process) .. "%")

    local Image_favorStar = TFDirector:getChildByPath(Image_lock, "Image_favorStar"):hide()
    local Label_lock = TFDirector:getChildByPath(Image_favorStar, "Label_lock")
    local favorLevel = buildData.enter_condition.favor
    Label_lock:setText(favorLevel)

    local Label_fubenLock = TFDirector:getChildByPath(Image_lock, "Label_fubenLock"):hide()
    local name = FubenDataMgr:getLevelName(buildData.enter_condition.pass) or ""
    Label_fubenLock:setTextById(950056, name)

    if unlock then
        Image_unlock:show()
        self.Button_enter:setGrayEnabled(false)
    elseif Image_favorStar and Label_fubenLock then
        if  not isFavorPass then
            Image_favorStar:show()
        elseif not isFubenPass then
            Label_fubenLock:show()
        end
        Image_lock:show()
        self.Button_enter:setGrayEnabled(true)
    end
end

function NewDatingDayView:loadingReward()
    self.DatingRewardView = require("lua.logic.dating.DatingRewardInfoView"):new()
    self.DatingRewardView:Pos(self.Panel_reward:Pos())
    self.Panel_base:addChild(self.DatingRewardView,1000)
end

function NewDatingDayView:refreshPanelDown()
    if not self.curBuildId then
        Box("当前没有任何可用建筑")
        return
    end
    self.Panel_down = TFDirector:getChildByPath(self.ui, "Panel_down")
    for i = 1, 4 do
        local Panel_type = TFDirector:getChildByPath(self.Panel_down, "Panel_type" .. i)
        local Label_endType = TFDirector:getChildByPath(Panel_type, "Label_endType")
        local Label_endPro = TFDirector:getChildByPath(Panel_type, "Label_endPro")

        local endInfo = DatingDataMgr:getEndInfoByIdx(self.curBuildId,i)
        local num = #endInfo.finishList
        local allNum = #endInfo.list
        Label_endPro:setText(tostring(num) .. "/" .. tostring(allNum))
        Label_endType:setTextById(tonumber(DatingDataMgr:getEndTypeConfig(endInfo.type).endName))
    end

    local Panel_cgPro = TFDirector:getChildByPath(self.ui, "Panel_cgPro")
    local Label_cgPro = TFDirector:getChildByPath(Panel_cgPro, "Label_cgPro")
    local buildData = self.buildData_[self.buildSIndex_]
    local data = DatingDataMgr:getBuildDayScripInfo(buildData.buildId)
    local cgList = data.cg
    local num = 0
    for i, v in ipairs(cgList) do
        local isUnlock = CollectDataMgr:isCollectItemExist(EC_CollectType.CG, v)
        if isUnlock then
            num = num + 1
        end
    end
    Label_cgPro:setText(tostring(num) .. "/" .. tostring(#cgList))

    local Image_cost = TFDirector:getChildByPath(self.ui, "Image_cost")
    local Label_cost = TFDirector:getChildByPath(Image_cost, "Label_cost")
    Label_cost:setText("20")
end

function NewDatingDayView:initTableView()
    local params = {
        ["upItem"]                  = self.Panel_itemRoot,
        ["downItem"]                = self.Panel_itemRoot,
        ["selItem"]                 = self.Panel_itemRoot,
        ["offsetX"]                 = 100,
        ["numberInView"]            = 3,
        ["updateCellInfo"]          = handler(self.updateCellInfo,self),
        ["selCallback"]             = handler(self.selCallback,self),
        ["cellCount"]               = table.count(self.buildData_),
        ["isLoop"]                  = false,
        ["size"]                    = self.Panel_roleList:Size(),
        ["isFlippingX"]             = true,
        ["callTouchBeganBack"]      = handler(self.tableCellTouchBegan,self),
        ["callTouchEndBack"]        = handler(self.tableCellTouched,self)
    }
    self.scrollMenu = UIObliqueList:create(params);
    self.Panel_roleList:addChild(self.scrollMenu,10)
    local jumpTo = self.buildDSIndex_
    self.scrollMenu:jumpTo(jumpTo);

end

function NewDatingDayView:tableCellTouchBegan()
    self.Panel_info.infoDi:stopAllActions()
    local pos = self.Panel_info.infoDi.savePos
    local width = self.Panel_info.infoDi:Size().width
    self.Panel_info.infoDi:Pos(pos.x-width,pos.y)
    self.Panel_info.infoDi:hide()
    local Panel_itemS = TFDirector:getChildByPath(self.curCell, "Panel_itemS")
    Panel_itemS:hide()
    local Panel_item = TFDirector:getChildByPath(self.curCell, "Panel_item")
    Panel_item:show()
end

function NewDatingDayView:tableCellTouched(isFirst)
    local pos = self.Panel_info.infoDi.savePos
    local fun = function()
        self.Panel_info.infoDi:show()
        self.Panel_info.infoDi:moveTo(0.1,ccp(pos.x,pos.y))
        local Panel_itemS = TFDirector:getChildByPath(self.curCell, "Panel_itemS")
        Panel_itemS:show()
        local Panel_item = TFDirector:getChildByPath(self.curCell, "Panel_item")
        Panel_item:hide()
        --local Image_buildIcon = TFDirector:getChildByPath(self.curCell, "Image_buildIcon")
        --if Image_buildIcon.clip then
        --    Image_buildIcon.clip:Scale(1)
        --end
        self:selectOne(self.buildSIndex_)
    end
    if isFirst then
        fun()
        return
    end
    self.ui:stopAllActions()
    local ac = {
        CCDelayTime:create(0.2),
        CCCallFunc:create(function()
            fun()
        end)
    }
    self.ui:runAction(CCSequence:create(ac))
end

function NewDatingDayView:updateCellInfo(cell,cellIdx)
    if not self.buildData_ then
        Box("没有任何建筑相关数据")
        return
    end
    local Panel_itemS = TFDirector:getChildByPath(cell, "Panel_itemS")
    local Panel_item = TFDirector:getChildByPath(cell, "Panel_item")
    self:initBuildItem(Panel_itemS,cellIdx,1)
    self:initBuildItem(Panel_item,cellIdx,0)
end

function NewDatingDayView:initBuildItem(cell,cellIdx,type)
    print("cellIdx ",cellIdx)
    local buildData = self.buildData_[cellIdx]

    local buildId = buildData.buildId
    local isFavorPass = buildData.isFavorPass
    local isFubenPass = buildData.isFubenPass
    local endInfo = DatingDataMgr:getBuildDayScripInfo(buildId)
    self.finishList = DatingDataMgr:getEndFinishIdList(endInfo)
    self.list = DatingDataMgr:getEndIdList(endInfo)
    local unlock = DatingDataMgr:isBuildEndUnLock(buildData)

    local Panel_unlock = TFDirector:getChildByPath(cell, "Panel_unlock"):hide()
    local Panel_lock = TFDirector:getChildByPath(cell, "Panel_lock"):hide()
    local Image_buildIcon = TFDirector:getChildByPath(cell,"Image_buildIcon")
    local Image_tubiao = TFDirector:getChildByPath(Panel_unlock, "Image_tubiao")
    local Label_b = TFDirector:getChildByPath(Panel_unlock, "Label_b")

    if Label_b then
        Label_b:setText(table.count(self.finishList) .. "/" .. table.count(self.list))
    end

    local iconPath = DatingDataMgr:getBuildIcon(buildId)
    self:setClip(Image_buildIcon,iconPath,type)
    --if Image_buildIcon.clip then
    --    Image_buildIcon.clip:Scale(0.81)
    --end
    local smallIconPath = DatingDataMgr:getBuildSmallIcon(buildId)
    Image_tubiao:setTexture(smallIconPath)

    local Image_favorStar = TFDirector:getChildByPath(Panel_lock, "Image_favorStar")
    if Image_favorStar then
        Image_favorStar:hide()
        local Label_lock = TFDirector:getChildByPath(Image_favorStar, "Label_lock")
        local favorLevel = buildData.enter_condition.favor
        Label_lock:setText(favorLevel)
    end

    local Label_fubenLock = TFDirector:getChildByPath(Panel_lock, "Label_fubenLock")
    if Label_fubenLock then
        Label_fubenLock:hide()
        local name = FubenDataMgr:getLevelName(buildData.enter_condition.pass) or ""
        Label_fubenLock:setTextById(950056, name)
    end

    if unlock then
        Panel_unlock:show()
    elseif Image_favorStar and Label_fubenLock then
        if  not isFavorPass then
            Image_favorStar:show()
        elseif not isFubenPass then
            Label_fubenLock:show()
        end
        Panel_lock:show()
    end
end

function NewDatingDayView:selCallback(cell,cellIdx)
    local buildData = self.buildData_[cellIdx]
    local buildId = buildData.buildId
    self.curBuildId = buildId
    self.buildSIndex_ = cellIdx
    self.curCell = cell
end

function NewDatingDayView:selectOne(cellIdx)
    self:refreshPanelInfo()
    self:refreshRewardView()
    self:refreshPanelDown()
    local buildData = self.buildData_[cellIdx]
    local data = DatingDataMgr:getBuildDayScripInfo(buildData.buildId)
    self.cgList = data.cg
    self.cg_cfg = {}
    for i, v in ipairs(self.cgList) do
        local cgId = v
        local cgData = TabDataMgr:getData("Cg")
        for k, vd in pairs(cgData) do
            local isUnlock = CollectDataMgr:isCollectItemExist(EC_CollectType.CG, vd.cgId)
            if vd.cgId == cgId and isUnlock  then
                table.insert(self.cg_cfg,vd)
            end
        end
    end
    if #self.cg_cfg == 0 then
        local id = data.cgAnimation
        local cgData = TabDataMgr:getData("Cg")
        if cgData[id] then
            table.insert(self.cg_cfg,cgData[id])
        end
    end

    print("data.cgAnimation ",data.cgAnimation)
    print("self.cg_cfg ",self.cg_cfg)

    self.cgIdx = 1
    local node = self.Panel_cg.cg
    if node then
        node:setZOrder(3)
        local fade     = FadeOut:create(0.5)
        local callback = CallFunc:create(function()
            node:removeFromParent()
        end)
        local seq = Sequence:createWithTwoActions(fade, callback)
        node:runAction(seq)
    else

    end
    self:changeCg(self.Panel_cg,self.cg_cfg[self.cgIdx].cg2,self.cg_cfg[self.cgIdx].backGround)
end

function NewDatingDayView:changeCg(parent,cgName,bgpath)
    local layer = require("lua.logic.common.CgView"):new(cgName, bgpath, nil, nil,false,function ()
        if parent.cg

        then
            local node = parent.cg

            parent.cg = nil
            local fade     = FadeOut:create(0.5)
            local callback = CallFunc:create(function()
                node:removeFromParent()
            end)
            node:setZOrder(2)
            local seq = Sequence:createWithTwoActions(fade, callback)
            node:runAction(seq)
        end
        self.cgIdx = self.cgIdx + 1
        if self.cgIdx > #self.cg_cfg then
            self.cgIdx = 1
        end
        self:changeCg(parent,self.cg_cfg[self.cgIdx].cg2,self.cg_cfg[self.cgIdx].backGround)
    end)
    layer:setPosition(ccp(0, 0))
    parent:addChild(layer)
    parent.cg = layer
end

function NewDatingDayView:refreshRewardView()
    if not self.DatingRewardView then
        return
    end
    local buildData = self.buildData_[self.buildSIndex_]
    local data = DatingDataMgr:getBuildDayScripInfo(buildData.buildId)
    local taskId = data.taskId or 10001
    local rewardData = TaskDataMgr:getTaskCfg(taskId)
    local taskInfo = TaskDataMgr:getTaskInfo(taskId)

    print("taskId---------------------- ",taskId)

    local finishList = DatingDataMgr:getEndFinishIdList(data)
    local list = DatingDataMgr:getEndIdList(data)


    local params = {
        itemList = rewardData.reward or {},
        pro = data.process or 0,
        status = taskInfo and taskInfo.status,
        bili = table.count(finishList) .. "/" .. table.count(list),
        taskId = taskId
    }
    print("refreshRewardView params ",params)
    self.DatingRewardView:refresh(params)
end

function NewDatingDayView:setClip(imageIcon,iconPath,type)
     local clip = CCClippingNode:create()
     -- clip:setInverted(true)
     clip:Pos(imageIcon:Pos())
     clip:AnchorPoint(imageIcon:AnchorPoint())
     clip:setAlphaThreshold(0.5)
     imageIcon:getParent():Add(clip,1)
     local icon = TFImage:create(iconPath)
     icon:Scale(1.7)
     clip:Add(icon)
     local str1 = "ui/dating/1214Dating/day/012.png"
     local str2 = "ui/dating/1214Dating/day/016.png"
     local str = ""
     if type == 0 then
         str = str1
     else
         str = str2
     end
     local stencil = TFImage:create(str)
     clip:setStencil(stencil)
     clip:Scale(0.95)
     imageIcon:hide()
     imageIcon.clip = clip
end

function NewDatingDayView:showBuildView()

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

function NewDatingDayView:refreshBuildItems()
    for i,v in ipairs(self.buildItem_) do
        self:updateBuildItem(v,i == self.buildSIndex_)
    end
end

function NewDatingDayView:updateBuildItem(buildItem,isSelect)
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

function NewDatingDayView:enterDating()
    if DatingDataMgr:getDayDatingTimes() == 0 then
        local itemCfg = GoodsDataMgr:getItemCfg(EC_SItemType.DAYDATINGTIMES)
        if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
            Utils:openView("dating.BuyDatingTimesView", itemCfg.id)
        else
            Utils:showTips(900210)
        end
    else
        DatingDataMgr:sendGetSciptMsg(EC_DatingScriptType.DAY_SCRIPT,nil,self.curBuildId)
    end
end

function NewDatingDayView:registerEvents()
    self.Button_enter:onClick(function()
        self:enterDating()
    end)
end




return NewDatingDayView