local DatingReview = class("DatingReview", BaseLayer)

function DatingReview:ctor(activityId)
    self.super.ctor(self)
    self:initData(activityId)
    self:init("lua.uiconfig.activity.datingReview")
end

function DatingReview:initData(activityId)
    self.activityId = activityId
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.itemids_ = ActivityDataMgr2:getItems(self.activityId)
    self.sortIds = {}
    for i,itemId in ipairs(self.itemids_) do
        local _itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)
        if _itemInfo and _itemInfo.extendData.datingRuleId then
            local _progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, itemId)
            if _progressInfo.status == EC_TaskStatus.GETED then
                table.insert(self.sortIds,1,itemId)
            else
                table.insert(self.sortIds,itemId)
            end
        end
    end
end

function DatingReview:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self.Button_close = TFDirector:getChildByPath(self.ui,"Button_close")	
	self:showPopAnim(true)

	local ScrollView_dating = TFDirector:getChildByPath(self.ui, "ScrollView_dating")
    self.ListView_dating = UIListView:create(ScrollView_dating)
    self.Panel_dating_item = TFDirector:getChildByPath(self.ui, "Panel_dating_item")

    self.ListView_dating:setItemsMargin(2)
    
	self:initContent()
end

function DatingReview:initContent()
    for i,itemId in ipairs(self.sortIds) do
        local _itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)
        local _progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, itemId)
        local Panel_dating_item = self.Panel_dating_item:clone()
        local Image_item_bg = TFDirector:getChildByPath(Panel_dating_item, "Image_item_bg")
        local Label_desc = TFDirector:getChildByPath(Panel_dating_item, "Label_desc")
        local Image_lock = TFDirector:getChildByPath(Panel_dating_item, "Image_lock")
        local Button_dating = TFDirector:getChildByPath(Panel_dating_item, "Button_dating")
        Image_item_bg:setTexture(_progressInfo.status == EC_TaskStatus.GETED and "ui/activity/2020SnowDay/book/005.png" or "ui/activity/2020SnowDay/book/005-1.png")
        Image_lock:setVisible(_progressInfo.status ~= EC_TaskStatus.GETED)
        Button_dating:setVisible(_progressInfo.status == EC_TaskStatus.GETED)
        local cfg = TabDataMgr:getData("DatingRule",_itemInfo.extendData.datingRuleId)
        if cfg then
            Label_desc:setTextById(cfg.endSynopsis)
        else
            Label_desc:setText("-----------------------------")
        end
        Button_dating:onClick(function ( ... )
            if _itemInfo and _itemInfo.extendData.datingRuleId then
                FunctionDataMgr:jStartDating(_itemInfo.extendData.datingRuleId)
            end
        end)
        self.ListView_dating:pushBackCustomItem(Panel_dating_item)
    end
end

function DatingReview:registerEvents()

	self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

end

return DatingReview
