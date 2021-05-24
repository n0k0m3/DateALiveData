--[[
    @desc：FanShiSharePopView
    @date: 2020-12-30 11:10:51
]]

local FanShiSharePopView = class("FanShiSharePopView",BaseLayer)

function FanShiSharePopView:initData(activityId, imgSrc)
    self.activityId = activityId
    self.imgSrc = imgSrc
end

function FanShiSharePopView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.fanShiSharePopView")
end

function FanShiSharePopView:initUI(ui)
    self.super.initUI(self,ui)
    if self.imgSrc then
        self._ui.Image_bg:setTexture(self.imgSrc)
    end

    self:timeOut(function()
        local ret = self:shareResult()
        if ret then
            ActivityDataMgr2:ReqShareComplete(self.activityId)
        end
    end,0.1)
end

function FanShiSharePopView:registerEvents()

end

function FanShiSharePopView:shareResult()

    local ret = false
    if HeitaoSdk then
        ret = HeitaoSdk.takeScreenshot();
    else
        ret = takeScreenshot()
        ret = true
    end
    return ret
end

return FanShiSharePopView