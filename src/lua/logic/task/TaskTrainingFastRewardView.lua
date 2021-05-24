local TaskTrainingFastRewardView = class("TaskTrainingFastRewardView", BaseLayer)


function TaskTrainingFastRewardView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.task.taskTrainingFastRewardView")
end

function TaskTrainingFastRewardView:initData(data)
    
end

function TaskTrainingFastRewardView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Label_num      = TFDirector:getChildByPath(ui,"Label_num")

    self.Button_close  = TFDirector:getChildByPath(ui,"Button_close")
    self.Button_ok      = TFDirector:getChildByPath(ui,"Button_ok")
    self.panel_item     = TFDirector:getChildByPath(ui,"Panel_item")
    self.Button_get_all    = TFDirector:getChildByPath(ui,"Button_get_all")
    self.Button_unlock      = TFDirector:getChildByPath(ui,"Button_unlock")
    self.Slider_level      = TFDirector:getChildByPath(ui,"Slider_level")
    self.Label_desc      = TFDirector:getChildByPath(ui,"Label_desc")
    self.Label_tips      = TFDirector:getChildByPath(ui,"Label_tips")
    self.Image_res_icon      = TFDirector:getChildByPath(ui,"Image_res_icon")
    self.Label_res_num      = TFDirector:getChildByPath(ui,"Label_res_num")
    self.Label_tips:setTextById(14220077)
    self.ListView_free    = UIListView:create(TFDirector:getChildByPath(ui,"ScrollView_free"))
    self.ListView_charge    = UIListView:create(TFDirector:getChildByPath(ui,"ScrollView_charge"))
    self.ListView_free:setItemsMargin(10)
    self.ListView_charge:setItemsMargin(10)

    self:refreshUI()
end

function TaskTrainingFastRewardView:refreshUI()
    local freeRewards = TaskDataMgr:getTrainingCanGetRewards(1)
    self.ListView_free:AsyncUpdateItem(freeRewards,function ()
        local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        item:setScale(0.8)
        return item
    end,function (item,data)
        PrefabDataMgr:setInfo(item, data[1], data[2])
    end)

    local chargeRewards = TaskDataMgr:getTrainingCanGetRewards(2)
    self.ListView_charge:AsyncUpdateItem(chargeRewards,function ()
        local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        item:setScale(0.8)
        return item
    end,function (item,data)
        PrefabDataMgr:setInfo(item, data[1], data[2])
    end)
end

function TaskTrainingFastRewardView:registerEvents()
    self.Button_close:onClick(function ()
        AlertManager:closeLayer(self)
     end)

    self.Button_get_all:onClick(function()
        local activity = ActivityDataMgr2:getWarOrderAcrivityInfo()
        ActivityDataMgr2:reqGetWarOrderAward(activity.id,0)
        AlertManager:closeLayer(self)
    end)

    self.Button_unlock:onTouch(function(event)
        Utils:openView("task.TaskTrainingChargeView")
    end)
end

return TaskTrainingFastRewardView
