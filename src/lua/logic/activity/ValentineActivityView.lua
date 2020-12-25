
local ValentineActivityView = class("ValentineActivityView", BaseLayer)

function ValentineActivityView:initData(activityId)
    self.activityId_ = activityId
    self.taskItems_ = {}
end

function ValentineActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.valentineActivityView")
end

function ValentineActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    
    self.Panel_cg = TFDirector:getChildByPath(ui, "Panel_cg")
    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    local Image_time = TFDirector:getChildByPath(Image_content, "Image_time")
    self.Label_time_title = TFDirector:getChildByPath(Image_content, "Label_time_title")
    self.Label_time = TFDirector:getChildByPath(Image_content, "Label_time")
    self.Button_goto = TFDirector:getChildByPath(Image_content, "Button_goto")
    self.Label_goto = TFDirector:getChildByPath(self.Button_goto, "Label_goto")
    self.Label_tip = TFDirector:getChildByPath(Image_content, "Label_tip")

    self:refreshView()
end

function ValentineActivityView:refreshView()
    self.Label_goto:setTextById(310016)
    self.Label_time_title:setTextById(1710002)
end

function ValentineActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    local startDate = Utils:getLocalDate(self.activityInfo_.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(self.activityInfo_.endTime)
    local endDateStr = endDate:fmt("%Y.%m.%d")
    self.Label_time:setTextById(800041, startDateStr, endDateStr)

    if not self.cgView_ then
        local cg_cfg = TabDataMgr:getData("Cg")[self.activityInfo_.extendData.cg]
        local cgView = requireNew("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil, false, function() end)
        local size = self.Panel_cg:getSize()
        local scaleX = size.width/cgView:Size().width
        local scaleY = size.height/cgView:Size().height
        cgView:setScale(math.max(scaleX, scaleY))
        self.Panel_cg:addChild(cgView)
        self.cgView_ = cgView
    end
    self.Label_tip:setText(self.activityInfo_.extendData.dec)
end

function ValentineActivityView:registerEvents()
    self.Button_goto:onClick(function()
            Utils:openView("valentine.ValentineMainView")
    end)
end

return ValentineActivityView
