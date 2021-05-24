--[[
    @desc：PicWallTaskPopView
    @date: 2021-03-10 18:55:15
]]

local PicWallTaskPopView = class("PicWallTaskPopView",BaseLayer)

function PicWallTaskPopView:initData(state, taskInfo)
    self.state = state
    self.taskInfo = taskInfo
    dump(taskInfo)
end

function PicWallTaskPopView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.picWallTaskPopView")
end

function PicWallTaskPopView:initUI(ui)
    self.super.initUI(self,ui)
    self.rewardView = UIListView:create(self._ui.ScrollView)
    self.rewardView:setItemsMargin(40)

    self._ui.panel_cut:setContentSize(self._ui.img_mask:getContentSize())

    self:refreshUI()
end

function PicWallTaskPopView:registerEvents()
    self._ui.btn_Close:onClick(function()
        AlertManager:close(self)
    end)
end

function PicWallTaskPopView:refreshUI()
    self._ui.panel_lock:setVisible(self.state == EC_TASK_STATUS.Lock)
    self._ui.panel_ing:setVisible(self.state == EC_TASK_STATUS.Ing)
    self._ui.panel_complete:setVisible(self.state == EC_TASK_STATUS.Complete)
    self._ui.panel_btns:setVisible(self.state == EC_TASK_STATUS.Ing or self.state == EC_TASK_STATUS.Complete)

    if self._ui.panel_lock:isVisible() then
        self._ui.lab_lockDesc:setText(self.taskInfo.details)
    end

    if self._ui.panel_ing:isVisible() then
        self._ui.lab_ingDesc:setText(self.taskInfo.extendData.taskDes)
    end

    if self._ui.panel_complete:isVisible() then
        self._ui.lab_completeDesc:setText(self.taskInfo.extendData.synopsis)
        self._ui.img_complete:setTexture(self.taskInfo.extendData.cgIcon)
    end

    local dating1 = self.taskInfo.extendData.dating1
    self._ui.btnReview_1:setVisible(self.state ~= EC_TASK_STATUS.Lock and dating1)
    if dating1 then
        self._ui.btnReview_1:onClick(function()
            DatingDataMgr:startDating(dating1)
        end)
    end

    local dating2 = self.taskInfo.extendData.dating2
    self._ui.btnReview_2:setVisible(dating2 and self.state ~= EC_TASK_STATUS.Lock)
    self._ui.btnReview_2:setTouchEnabled(self.state == EC_TASK_STATUS.Complete)
    self._ui.btnReview_2:setGrayEnabled(self.state ~= EC_TASK_STATUS.Complete)
    self._ui.btnReview_2:onClick(function()
        if dating2 then
            DatingDataMgr:startDating(dating2)
        end
    end)
    self._ui.lab_review:setVisible(self.state == EC_TASK_STATUS.Complete)
    self._ui.lab_lock:setVisible(self.state == EC_TASK_STATUS.Ing)
    
    if not self._ui.btnReview_1:isVisible() and self._ui.btnReview_2:isVisible() then
        self._ui.btnReview_2:setPosition(self._ui.btnReview_1:getPosition())
    end

    local jumpId = self.taskInfo.extendData.jumpInterface
    self._ui.btn_jump:setVisible(self.state == EC_TASK_STATUS.Ing and jumpId)
    if jumpId then
        self._ui.btn_jump:onClick(function()
            AlertManager:close(self)
            FunctionDataMgr:enterByFuncId(jumpId, unpack(self.taskInfo.extendData.jumpParamters or {}))
        end)
    end
        
    self.rewardView:removeAllItems()
    for id, num in pairs(self.taskInfo.reward) do
        local item = self._ui.panel_awardItem:clone()
        local panel_pos = item:getChildByName("panel_pos")
        local img_hadGetted = item:getChildByName("img_hadGetted")
        img_hadGetted:setVisible(self.state == EC_TASK_STATUS.Complete)

        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        goods:setScale(0.9)
        PrefabDataMgr:setInfo(goods, id, num)
        goods:AddTo(panel_pos):Pos(0,0)
        self.rewardView:pushBackCustomItem(item)
    end
end

return PicWallTaskPopView