local DatingRewardInfoView = class("DatingRewardInfoView",BaseLayer)

function DatingRewardInfoView:refreshData(params)
    self.itemList = params.itemList or {}
    self.pro = params.pro or 0
    self.status = params.status or EC_TaskStatus.ING
    self.bili = params.bili
    self.taskId = params.taskId

    print("DatingRewardInfoView self.itemList ",self.itemList)
end


function DatingRewardInfoView:ctor()
    self.super.ctor(self)

    self:init("lua.uiconfig.dating.datingRewardInfoView")
end

function DatingRewardInfoView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_touch")
    self.Panel_pbTouch = TFDirector:getChildByPath(self.ui, "Panel_pbTouch")
    if self.Panel_pbTouch then
        self.Panel_pbTouch:show()
    end
    self.Panel_clip = TFDirector:getChildByPath(self.ui, "Panel_clip")
    self.Panel_clip.di = TFDirector:getChildByPath(self.Panel_clip, "Image_di")
    self.Panel_clip.di:Pos(420,0)
    self.Panel_item = TFDirector:getChildByPath(self.ui, "Panel_item"):hide()

    self:initFinishD()
    self:initUnFinishD()
    self:initOpenD()
    self:initListView()
end

function DatingRewardInfoView:refreshDes()
    local Label_des = TFDirector:getChildByPath(self.ui, "Label_des")
    local Label_dbi = TFDirector:getChildByPath(self.ui, "Label_dbi")
    --Label_des:setTextById(1330004)
    Label_dbi:setText(self.bili)
    Label_dbi:show()
end

function DatingRewardInfoView:setCounstomDesc( stringId  , ...)
     local Label_des = TFDirector:getChildByPath(self.ui, "Label_des")
     Label_des:setTextById(stringId ,...)
end

function DatingRewardInfoView:initListView()
    local ScrollView_list = TFDirector:getChildByPath(self.ui, "ScrollView_list")
    self.listView = UIListView:create(ScrollView_list)
end

function DatingRewardInfoView:refreshListView()
    self.listView:removeAllItems()
    for i, v in ipairs(self.itemList) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.7)
        PrefabDataMgr:setInfo(Panel_goodsItem, v[1], v[2])
        if self.status == EC_TaskStatus.GETED then
            local item = self.Panel_item:clone()
            item:show()
            item:Pos(0,0)
            Panel_goodsItem:addChild(item)
        end
        self.listView:pushBackCustomItem(Panel_goodsItem)
    end
end

function DatingRewardInfoView:initUnFinishD()
    self.Image_unFinishD = TFDirector:getChildByPath(self.ui, "Image_unFinishD"):hide()
    self.Image_unFinishD.bar = TFDirector:getChildByPath(self.Image_unFinishD, "LoadingBar_p")
end

function DatingRewardInfoView:initFinishD()
    self.Image_finishD = TFDirector:getChildByPath(self.ui, "Image_finishD"):hide()
end

function DatingRewardInfoView:initOpenD()
    self.Image_openD = TFDirector:getChildByPath(self.ui, "Image_openD"):hide()
    self.Image_openD.bar = TFDirector:getChildByPath(self.Image_openD, "LoadingBar_p")
    self.Image_openD.close = TFDirector:getChildByPath(self.Image_openD, "Image_close")
end

function DatingRewardInfoView:refresh(params)
    self:refreshData(params)
    self:refreshUI()
end

function DatingRewardInfoView:refreshUI()
    self:refreshPro()
    self:refreshStatus()
    self:refreshListView()
    self:refreshDes()
end

function DatingRewardInfoView:refreshPro()
    self.Image_openD.bar:setPercent(self.pro)
    self.Image_unFinishD.bar:setPercent(self.pro)
end

function DatingRewardInfoView:refreshStatus()
    self.Image_finishD:hide()
    self.Image_unFinishD:hide()
    if self.status == EC_TaskStatus.GET or self.status == EC_TaskStatus.GETED then
        self.Image_finishD:show()
        local Image_hongdian = TFDirector:getChildByPath(self.Image_finishD, "Image_hongdian")
        if self.status == EC_TaskStatus.GETED then
            Image_hongdian:hide()
        else
            Image_hongdian:show()
        end
    elseif self.status == EC_TaskStatus.ING then
        self.Image_unFinishD:show()
    end
end

function DatingRewardInfoView:onTaskReceiveEvent(reward,cid)
    if self.taskId == cid then
        Utils:showReward(reward)
        self.status = EC_TaskStatus.GETED
        self:refreshStatus()
        self:refreshDes()
    end
end

function DatingRewardInfoView:registerEvents()

    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))

    self.Panel_touch:onClick(function()
        if self.Panel_touch.isOpen then
            self.Image_openD:hide()
            self.Panel_touch.isOpen = false
            self.ui:runAnimation("ActionClose")
            if self.Panel_pbTouch then
                self.Panel_pbTouch:show()
            end
            self:refreshStatus()
        else
            if self.status == EC_TaskStatus.GET and self.taskId then
                TaskDataMgr:send_TASK_SUBMIT_TASK(self.taskId)
            else
                if self.Panel_pbTouch then
                    self.Panel_pbTouch:hide()
                end

                self.Image_unFinishD:hide()
                self.Image_finishD:hide()
                self.Image_openD:show()
                self.Panel_touch.isOpen = true
                self.ui:runAnimation("ActionOpen")
            end
        end
    end)
end




return DatingRewardInfoView