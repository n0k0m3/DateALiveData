
local AutumnActivityView = class("AutumnActivityView", BaseLayer)

function AutumnActivityView:initData(activityId)
    self.activityId_ = activityId
    self.taskItems_ = {}
    self.resource = {}
end

function AutumnActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.autumnActivityView")
end

function AutumnActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")

    self.Label_time_title = TFDirector:getChildByPath(self.Panel_root, "Label_time_title")
    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")
    self.Button_goto = TFDirector:getChildByPath(Image_content, "Button_goto")
    self.Label_goto = TFDirector:getChildByPath(self.Button_goto, "Label_goto")
    self.Label_tip = TFDirector:getChildByPath(Image_content, "Label_tip")

    self.itemtab = {}
    for i=1,2 do
        self.itemtab[i] = {}
        self.itemtab[i].bg = TFDirector:getChildByPath(self.Panel_root, "Image_icon"..i)
        self.itemtab[i].numTx = TFDirector:getChildByPath(self.itemtab[i].bg, "Label_num")
        self.itemtab[i].icon = TFDirector:getChildByPath(self.itemtab[i].bg, "Image_icon")
    end

    self:refreshView()
end

function AutumnActivityView:updateItem()
    for i=1,2 do
        local itemId = self.resource[i]
        if itemId then
            local itemCfg = GoodsDataMgr:getItemCfg(itemId)
            local num = GoodsDataMgr:getItemCount(itemId)
            self.itemtab[i].icon:setTexture(itemCfg.icon)
            self.itemtab[i].numTx:setText(num)
            self.itemtab[i].bg:setVisible(true)
        else
            self.itemtab[i].bg:setVisible(false)
        end
    end
end

function AutumnActivityView:refreshView()
    self.Label_goto:setTextById(310016)
    self.Label_time_title:setTextById(1710002)
end

function AutumnActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.Label_time:setText(Utils:getActivityDateString(self.activityInfo_.startTime, self.activityInfo_.endTime, self.activityInfo_.extendData.dateStyle))
    self.Label_tip:setTextById(self.activityInfo_.extendData.dec)

    local extendData = self.activityInfo_.extendData or {}
    self.resource = extendData.resourceView or {}
    self:updateItem()
end

function AutumnActivityView:registerEvents()
    EventMgr:addEventListener(self, EV_DFW_ENTER_MAIN, handler(self.onEnterDfwEvent, self))

    self.Button_goto:onClick(function()
        DfwDataMgr:send_SACRIFICE_REQ_SPRING_SACRIFICE()
    end)
end

function AutumnActivityView:onEnterDfwEvent()
    Utils:openView("dfwautumn.DfwAutumnMainView")
    if self.activityInfo_.extendData.interDating then
        local key = "playDating"..self.activityInfo_.id.."player"..MainPlayer:getPlayerId()
        local string = CCUserDefault:sharedUserDefault():getStringForKey(key)
        if string ~= "true" then
            CCUserDefault:sharedUserDefault():setStringForKey(key,"true")
            FunctionDataMgr:jStartDating(self.activityInfo_.extendData.interDating)
        end
    end
end

return AutumnActivityView
