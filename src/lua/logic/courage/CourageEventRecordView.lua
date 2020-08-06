local CourageEventRecordView = class("CourageEventRecordView", BaseLayer)

function CourageEventRecordView:initData(selectType)

    self.selectType = selectType or 1
    self.selectType = 2
end

function CourageEventRecordView:ctor(selectType)
    self.super.ctor(self)
    self:initData(selectType)
    self:showPopAnim(true)
    self:init("lua.uiconfig.courage.courageRecordView")
end

function CourageEventRecordView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_base")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    local ScrollView_target = TFDirector:getChildByPath(self.Panel_root, "ScrollView_target")
    self.ListView_target = UIListView:create(ScrollView_target)
    local ScrollView_event = TFDirector:getChildByPath(self.Panel_root, "ScrollView_event")
    self.ListView_event = UIListView:create(ScrollView_event)

    self.Image_titlebg = TFDirector:getChildByPath(self.Panel_root, "Image_titlebg")
    self.Label_title = TFDirector:getChildByPath(self.Panel_root, "Label_title")

    self.select_ = {}
    for i=1,2 do
        local Panel = TFDirector:getChildByPath(self.Panel_root, "Panel_"..i)
        local select = TFDirector:getChildByPath(Panel, "Button_select")
        local normal = TFDirector:getChildByPath(Panel, "Image_normal")
        local view = i==1 and ScrollView_target or ScrollView_event
        table.insert(self.select_,{Panel = Panel, select = select, normal = normal, view = view})
    end

    self.Panel_item = TFDirector:getChildByPath(self.Panel_root, "Panel_item"):hide()
    self.Panel_item1 = TFDirector:getChildByPath(self.Panel_root, "Panel_item1"):hide()
    self:initUILogic()
end

function CourageEventRecordView:onShow()
    self.super.onShow(self)
    self:timeOut(function()
        GameGuide:checkGuide(self);
    end,0.1)
end

function CourageEventRecordView:initUILogic()
    --self:loadTarget()
    self:loadEvent()
    self:chooseType(self.selectType)
end

function CourageEventRecordView:loadTarget()

    for i=1,10 do
        local isMain = i == 1
        local targetItem = self.Panel_item:clone()
        targetItem:setVisible(true)
        local Image_icon = TFDirector:getChildByPath(targetItem, "Image_icon")
        local res = isMain and "006.png" or "004.png"
        Image_icon:setTexture("ui/activity/courage/note/"..res)
        local Label_title = TFDirector:getChildByPath(targetItem, "Label_title")
        local titleStr = isMain and "【主线目标】" or "【支线任务"..i.."】"
        Label_title:setText(titleStr)
        local Label_info = TFDirector:getChildByPath(targetItem, "Label_info")
        Label_info:setDimensions(311, 0)
        Label_info:setText("目标描述目标描述目标描述目标描述目标描述目标描述")
        local h = Label_info:getContentSize().height
        targetItem:setContentSize(CCSizeMake(360,h + 40))
        self.ListView_target:pushBackCustomItem(targetItem)
    end
end

function CourageEventRecordView:loadEvent()

    self.ListView_event:removeAllItems()
    local mainLogInfo = CourageDataMgr:getMainLogInfo()
    local branchLogInfo = CourageDataMgr:getBranchLogInfo()
    local allMainLogInfo = {}
    table.insertTo(allMainLogInfo,mainLogInfo)
    table.insertTo(allMainLogInfo,branchLogInfo)

    table.sort(allMainLogInfo,function(a,b)
        local stateA = a.finished and  1 or 0
        local stateB = b.finished and  1 or 0
        if stateA == stateB then
            local cfgA = CourageDataMgr:getLogCfgData(a.logId)
            local cfgB = CourageDataMgr:getLogCfgData(b.logId)
            if cfgA.mainLogType == cfgB.mainLogType then
                return a.time < b.time
            else
                return cfgA.mainLogType < cfgB.mainLogType
            end
        else
            return stateA < stateB
        end
    end)

    for k,v in ipairs(allMainLogInfo) do
        local targetItem = self.Panel_item1:clone()
        targetItem:setVisible(true)
        local Label_title = TFDirector:getChildByPath(targetItem, "Label_title")
        local cfg = CourageDataMgr:getLogCfgData(v.logId)
        if cfg then
            Label_title:setText(cfg.logBase)
            local mainColor = v.finished and ccc3(128,128,128) or  ccc3(81,74,103)
            Label_title:setColor(mainColor)
            local ScrollView_subInfo = TFDirector:getChildByPath(targetItem, "ScrollView_subInfo")
            local list_subInfo = UIListView:create(ScrollView_subInfo)
            list_subInfo:removeAllItems()

            local Panel_info = TFDirector:getChildByPath(targetItem, "Panel_info")
            local subLogIds = CourageDataMgr:getSubLogCfgByMainCid(v.logId)
            for index,subInfo in ipairs(subLogIds) do
                local isFinishSubLog = CourageDataMgr:getSubLogInfo(subInfo.id)
                if isFinishSubLog then
                    local Panel_infoClone = Panel_info:clone()
                    local infoText = Panel_infoClone:getChildByName("Label_info")
                    Panel_infoClone:setVisible(true)
                    infoText:setDimensions(332, 0)
                    infoText:setText(subInfo.logBase)
                    local height = infoText:getContentSize().height
                    Panel_infoClone:setContentSize(CCSizeMake(360,height +10))

                    ---主条目完成所有子条目也完成
                    local mainColor = v.finished and ccc3(128,128,128) or  ccc3(81,74,103)
                    infoText:setColor(mainColor)
                    list_subInfo:pushBackCustomItem(Panel_infoClone)
                end
            end
            local innerSize = list_subInfo:getInnerContainerSize()
            list_subInfo:setContentSize(CCSizeMake(innerSize.width,innerSize.height))

            targetItem:setContentSize(CCSizeMake(360,34 + innerSize.height+15))

            self.ListView_event:pushBackCustomItem(targetItem)
        end
    end
end

function CourageEventRecordView:chooseType(id)

    for k,v in ipairs(self.select_) do
        v.select:setVisible(k == id)
        v.view:setVisible(k == id)
        v.normal:setVisible(k ~= id)
    end

    local res = id == 1 and "003.png" or "001.png"
    self.Image_titlebg:setTexture("ui/activity/courage/note/"..res)

    local str = id == 1 and "任务目标" or "事件回忆"
    self.Label_title:setText(str)
end


---事件
function CourageEventRecordView:excuteGuideFunc30011(guideFuncId)
    local targetNode = self.Button_close
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function CourageEventRecordView:registerEvents()

    EventMgr:addEventListener(self, EV_COURAGE.EV_UPDATE_EVENT_LOG, handler(self.loadEvent, self))

    self.Button_close:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        AlertManager:closeLayer(self)
    end)

    for k,v in ipairs(self.select_) do
        v.Panel:onClick(function()
            self:chooseType(k)
        end)
    end

end


return CourageEventRecordView
