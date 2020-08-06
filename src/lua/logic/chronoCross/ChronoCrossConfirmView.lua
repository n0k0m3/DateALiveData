
local ChronoCrossConfirmView = class("ChronoCrossConfirmView", BaseLayer)

function ChronoCrossConfirmView:ctor(taskId)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData(taskId)
    self:init("lua.uiconfig.chronoCross.chronoCrossConfirmView")
end

function ChronoCrossConfirmView:initData(taskId)

    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRONO_CROSS)
    self.activityId_ = activity[1]
    if self.activityId_ then
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    else
        Box("活动未开启")
        return
    end
    self.taskId = taskId
    self.progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, self.taskId)
    self.itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, self.taskId)

    self.taskType = self.itemInfo.extendData.type
end

function ChronoCrossConfirmView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Label_title = TFDirector:getChildByPath(self.Panel_root, "Label_title")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Image_icon = TFDirector:getChildByPath(self.Panel_root, "Image_icon")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_root, "Label_desc")
    self.Label_dating_desc = TFDirector:getChildByPath(self.Panel_root, "Label_dating_desc")
    self.Image_reward = TFDirector:getChildByPath(self.Panel_root, "Image_reward")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_root, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)

    self.Button_receive = TFDirector:getChildByPath(self.Panel_root, "Button_receive")
    self.Label_receive = TFDirector:getChildByPath(self.Panel_root, "Label_receive")

    self.Image_dating = TFDirector:getChildByPath(self.Panel_root, "Image_dating")
    self.Image_dating_bg = TFDirector:getChildByPath(self.Panel_root, "Image_dating_bg")
    self.Image_sepcial = TFDirector:getChildByPath(self.Panel_root, "Image_sepcial")
    self:updateView()
end

function ChronoCrossConfirmView:updateView()

    if not self.itemInfo then
        return
    end
    self.Label_title:setText(self.itemInfo.extendData.des)
    local inputText = string.gsub(self.itemInfo.extendData.des2,"\\n", "\n")
    self.Label_desc:setText(inputText)
    self.Label_dating_desc:setText(inputText)
    self.Image_icon:setTexture(self.itemInfo.extendData.iconShow)
    self.Image_dating:setTexture(self.itemInfo.extendData.iconShow)
    self.Image_reward:setVisible(self.taskType == EC_ChronoCrossTaskType.Special)
    if self.taskType == EC_ChronoCrossTaskType.Date or self.taskType == EC_ChronoCrossTaskType.Extra_Date then
        self:updateDatingTask()
    elseif self.taskType == EC_ChronoCrossTaskType.Special then
        self:updateSpecialTask()
    end
    self.Image_dating_bg:setVisible(self.taskType == EC_ChronoCrossTaskType.Date or self.taskType == EC_ChronoCrossTaskType.Extra_Date)
    self.Image_sepcial:setVisible(self.taskType == EC_ChronoCrossTaskType.Special)
end

function ChronoCrossConfirmView:updateDatingTask()

    local isGetedTask = self.itemInfo.extendData.state == EC_ChronoCrossDatingStatus.Finish
    if isGetedTask then
        self.Label_receive:setTextById(13310307)
        self.Label_title:setTextById(303039)
    elseif self.itemInfo.extendData.state == EC_ChronoCrossDatingStatus.Ing then
        self.Label_receive:setText("开始")
    elseif self.itemInfo.extendData.state == EC_ChronoCrossDatingStatus.Lock then
        self.Label_receive:setTextById(13310343)
        self.Label_dating_desc:setTextById(13310342)
        self.Label_title:setTextById(13310341)
    end


    self.Button_receive:setTouchEnabled(not isGetedTask)
    self.Button_receive:setGrayEnabled(isGetedTask)

end

function ChronoCrossConfirmView:updateSpecialTask()
    self.ListView_reward:removeAllItems()
    for k,v in pairs(self.itemInfo.reward) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
        Panel_goodsItem:Scale(0.7)
        self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end
    local isGetedTask = self.progressInfo.status == EC_TaskStatus.GETED
    local textStr = isGetedTask and 303039 or 1300009
    self.Label_receive:setTextById(textStr)
    self.Button_receive:setTouchEnabled(not isGetedTask)
    self.Button_receive:setGrayEnabled(isGetedTask)
end

function ChronoCrossConfirmView:registerEvents()

    self.Button_close:onClick(function ()
        AlertManager:closeLayer(self)
    end)

    self.Button_receive:onClick(function()
        self.Button_receive:setTouchEnabled(false)
        if self.itemInfo then
            if self.taskType == EC_ChronoCrossTaskType.Date or self.taskType == EC_ChronoCrossTaskType.Extra_Date then
                if self.itemInfo.extendData.state == EC_ChronoCrossDatingStatus.Ing then
                    local ScriptId = self.itemInfo.extendData.datingScriptId
                    DatingDataMgr:sendGetSciptMsg(EC_DatingScriptType.SPECIAL_SCRIPT,nil,nil, ScriptId)
                    ChronoCrossDataMgr:setDialogPlayState(false)
                end
                AlertManager:closeLayer(self)
            elseif self.taskType == EC_ChronoCrossTaskType.Special then
                local jumpId = self.itemInfo.extendData.jumpInterface
                AlertManager:closeLayer(self)
                FunctionDataMgr:enterByFuncId(jumpId)
            end
        else
            AlertManager:closeLayer(self)
        end
    end)
end

return ChronoCrossConfirmView
