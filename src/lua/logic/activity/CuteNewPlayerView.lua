local CuteNewPlayerView = class("CuteNewPlayerView", BaseLayer)

function CuteNewPlayerView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.CuteNewPlayerView")
end

function CuteNewPlayerView:initData(data, content)
    self.data_ = data
    self.content_ = content
end

function CuteNewPlayerView:initUI(ui)
    self.super.initUI(self,ui)


    self.Label_desc = TFDirector:getChildByPath(ui, "Label_desc")
    self.Label_text = TFDirector:getChildByPath(self.ui, "Label_text")

    local ScrollView_desc = TFDirector:getChildByPath(ui, "ScrollView_desc")
    self.text_list = UIListView:create(ScrollView_desc)
    self.text_list:setItemsMargin(15)
    self.text_list:setGravity(UIListView.Gravity.LEFT)

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_gotoWar = TFDirector:getChildByPath(ui, "Button_gotoWar")

    self.Button_gotoWar:onClick(function()
        Utils:openView("fuben.FubenChapterView")
    end)

    local activitys = ActivityDataMgr2:getNewPlayerActivityInfo(true)
    if #activitys >= 1 then
        self.Label_startAndEndTime = TFDirector:getChildByPath(ui, "Label_startAndEndTime")
        local startDate = Utils:getLocalDate(activitys[1].startTime)
        local startDateStr = startDate:fmt("%Y.%m.%d")

        local endDate = Utils:getLocalDate(activitys[1].endTime)
        local endDateStr = endDate:fmt("%Y.%m.%d")
        self.Label_startAndEndTime:setText(startDateStr .. "-" .. endDateStr)

    end

    local label = self.Label_text:clone()
    label:setTextById(263251)
    local Label_dotNum = TFDirector:getChildByPath(label, "Label_dotNum")
    Label_dotNum:setText("1")
    self.text_list:pushBackCustomItem(label)

    local label = self.Label_text:clone()
    label:setTextById(263252)
    local Label_dotNum = TFDirector:getChildByPath(label, "Label_dotNum")
    Label_dotNum:setText("2")
    self.text_list:pushBackCustomItem(label)

    local label = self.Label_text:clone()
    label:setTextById(263253)
    local Label_dotNum = TFDirector:getChildByPath(label, "Label_dotNum")
    Label_dotNum:setText("3")
    self.text_list:pushBackCustomItem(label)

   
   
    self:refreshView()
end

function CuteNewPlayerView:refreshView()
    -- local label = self.Label_desc:clone()
    -- label:setTextById(self.content_)
    -- label:setWidth(500)
    -- self.text_list:pushBackCustomItem(label)

   
end


return CuteNewPlayerView
