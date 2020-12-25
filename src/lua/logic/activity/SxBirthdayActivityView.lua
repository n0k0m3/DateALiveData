
local SxBirthdayActivityView = class("SxBirthdayActivityView", BaseLayer)

function SxBirthdayActivityView:initData(activityId)
    self.activityId_ = activityId
    self.isHandle_ = false
    self.taskItems_ = {}
end

function SxBirthdayActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.sxBirthdayActivityView")
end

function SxBirthdayActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Panel_cg = TFDirector:getChildByPath(Image_content, "Image_frame.Panel_cg")
    local Image_time = TFDirector:getChildByPath(Image_content, "Image_time")
    self.Label_time_title = TFDirector:getChildByPath(Image_content, "Label_time_title")
    self.Label_time = TFDirector:getChildByPath(Image_content, "Label_time")
    self.Button_goto = TFDirector:getChildByPath(Image_content, "Button_goto")
    self.Label_goto = TFDirector:getChildByPath(self.Button_goto, "Label_goto")
    self.Label_tip = TFDirector:getChildByPath(Image_content, "Label_tip")

    self:refreshView()
end

function SxBirthdayActivityView:refreshView()
    self.Label_goto:setTextById(310016)
    self.Label_time_title:setTextById(1710002)
end

function SxBirthdayActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
	dump(self.activityInfo_)
    local startDate = Utils:getLocalDate(self.activityInfo_.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(self.activityInfo_.endTime)
    local endDateStr = endDate:fmt("%Y.%m.%d")
    self.Label_time:setTextById(800041, startDateStr, endDateStr)

--    if not self.cgView_ then
--        if self.activityInfo_.extendData.cg then
--            local cg_cfg = TabDataMgr:getData("Cg")[self.activityInfo_.extendData.cg]
--            local cgView = requireNew("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil, false, function() end)
--            local size = self.Panel_cg:getSize()
--            local scaleX = size.width/cgView:Size().width
--            local scaleY = size.height/cgView:Size().height
--            cgView:setScale(math.max(scaleX, scaleY))
--            self.Panel_cg:addChild(cgView)
--            self.cgView_ = cgView
--        end
--    end
--    self.Label_tip:setText(self.activityInfo_.extendData.dec)
end

function SxBirthdayActivityView:registerEvents()
    EventMgr:addEventListener(self, EV_SXBIRTHDAY_CITYINFO_UPDATE, handler(self.onEnterSxBirthdayEvent, self))

    self.Button_goto:onClick(function()
            SxBirthdayDataMgr:send_BIRTH_DAY_REQ_TEN_BIRTH_DAY_INFO()
    end)
end

function SxBirthdayActivityView:onShow()
    self.super.onShow(self)
    self.isHandle_ = false
end

function SxBirthdayActivityView:onEnterSxBirthdayEvent()
    if not self.isHandle_ then
        Utils:openView("activity.SxBirthdayMainView")
        self.isHandle_ = true
    end
end

return SxBirthdayActivityView
