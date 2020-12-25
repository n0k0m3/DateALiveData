
local DuanwuActivityView = class("DuanwuActivityView", BaseLayer)

function DuanwuActivityView:initData(activityId)
    self.activityId_ = activityId
    self.isHandle_ = false
    self.taskItems_ = {}
end

function DuanwuActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    if ActivityDataMgr2:getActivityUIType() == 1 then
        self:init("lua.uiconfig.activity.midAutumnActivityView")
    elseif ActivityDataMgr2:getActivityUIType() == 2 then
        self:init("lua.uiconfig.activity.lanternFestivalActivityView")
    else
        self:init("lua.uiconfig.activity.duanwuActivityView")
    end
end

function DuanwuActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_goto = TFDirector:getChildByPath(Image_content, "Button_goto")
    self.Label_goto = TFDirector:getChildByPath(self.Button_goto, "Label_goto")
    self.Label_goto:setSkewX(15)
    
    if ActivityDataMgr2:getActivityUIType() == 1 then
        self.Panel_cg = TFDirector:getChildByPath(Image_content,"Panel_cg")
        local pannel_time = TFDirector:getChildByPath(Image_content, "pannel_time")
        self.Label_time_title = TFDirector:getChildByPath(pannel_time, "Label_time_title")
        self.Label_time = TFDirector:getChildByPath(pannel_time, "Label_time")
        self.Label_tip = TFDirector:getChildByPath(Image_content, "Image_frame.Label_tip")
    elseif  ActivityDataMgr2:getActivityUIType() == 2 then
        self.Panel_cg = TFDirector:getChildByPath(Image_content,"Panel_cg")
        local pannel_time = TFDirector:getChildByPath(Image_content, "pannel_time")
        self.Label_time_title = TFDirector:getChildByPath(pannel_time, "Label_time_title")
        self.Label_time = TFDirector:getChildByPath(pannel_time, "Label_time")
        self.Label_tip = TFDirector:getChildByPath(Image_content, "Label_tip")
    else
        self.Panel_cg = TFDirector:getChildByPath(Image_content, "Image_frame.Panel_cg")
        local Image_time = TFDirector:getChildByPath(Image_content, "Image_time")
        self.Label_time_title = TFDirector:getChildByPath(Image_time, "Label_time_title")
        self.Label_time = TFDirector:getChildByPath(Image_time, "Label_time")
        self.Label_tip = TFDirector:getChildByPath(Image_content, "Label_tip")
    end

    self:refreshView()
end

function DuanwuActivityView:refreshView()
    self.Label_goto:setTextById(310016)
    self.Label_time_title:setTextById(1710002)
end

function DuanwuActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.Label_time:setText(Utils:getActivityDateString(self.activityInfo_.startTime, self.activityInfo_.endTime))

    if not self.cgView_ then
        if self.activityInfo_.extendData.cg then
            local cg_cfg = TabDataMgr:getData("Cg")[self.activityInfo_.extendData.cg]
            local cgView = requireNew("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil, false, function() end)
            local size = self.Panel_cg:getSize()
            local scaleX = size.width/cgView:Size().width
            local scaleY = size.height/cgView:Size().height
            cgView:setScale(math.max(scaleX, scaleY))
            self.Panel_cg:addChild(cgView)
            self.cgView_ = cgView
        end
    end

    if ActivityDataMgr2:getActivityUIType() == 1 or ActivityDataMgr2:getActivityUIType() == 2 then
        local str = self.activityInfo_.activityTitle
        str = string.gsub(str, "\\n", "\n")
        self.Label_tip:setString(str)
    else
        self.Label_tip:setText(self.activityInfo_.extendData.dec)
    end
end

function DuanwuActivityView:registerEvents()
    self.Button_goto:onClick(function()
            Utils:openView("activity.DuanwuMainView")
    end)
end

return DuanwuActivityView
