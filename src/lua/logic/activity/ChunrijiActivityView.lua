
local ChunrijiActivityView = class("ChunrijiActivityView", BaseLayer)

function ChunrijiActivityView:initData(activityId)
    self.activityId_ = activityId
    self.taskItems_ = {}
end

function ChunrijiActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.chunrijiActivityView")
end

function ChunrijiActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Panel_cg = TFDirector:getChildByPath(Image_content, "Image_frame.Panel_cg")
    local Image_time = TFDirector:getChildByPath(Image_content, "Image_time")
    self.Label_time_title = TFDirector:getChildByPath(Image_time, "Label_time_title")
    self.Label_time = TFDirector:getChildByPath(Image_time, "Label_time")
    self.Button_goto = TFDirector:getChildByPath(Image_content, "Button_goto")
    self.Label_goto = TFDirector:getChildByPath(self.Button_goto, "Label_goto")
    self.Label_tip = TFDirector:getChildByPath(Image_content, "Label_tip")

    self:refreshView()
end

function ChunrijiActivityView:refreshView()
    self.Label_goto:setTextById(310016)
    self.Label_time_title:setTextById(1710002)
end

function ChunrijiActivityView:updateActivity()
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

function ChunrijiActivityView:registerEvents()
    EventMgr:addEventListener(self, EV_DFW_ENTER_MAIN, handler(self.onEnterDfwEvent, self))

    self.Button_goto:onClick(function()
            DfwDataMgr:send_SACRIFICE_REQ_SPRING_SACRIFICE()
    end)
end

function ChunrijiActivityView:onEnterDfwEvent()
    Utils:openView("dafuwong.DfwMainView")
    if self.activityInfo_.extendData.interDating then
        local key = "playDating"..self.activityInfo_.id.."player"..MainPlayer:getPlayerId()
        local string = CCUserDefault:sharedUserDefault():getStringForKey(key) 
        if string  ~= "false" then
            CCUserDefault:sharedUserDefault():setStringForKey(key,"true")
            FunctionDataMgr:jStartDating(self.activityInfo_.extendData.interDating)
        end
    end
end

return ChunrijiActivityView
