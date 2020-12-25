--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
*  祈愿分享界面
* 
]]

local PrayShareView = class("PrayShareView", BaseLayer)

function PrayShareView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:init("lua.uiconfig.activity.PrayShareView")
end

function PrayShareView:initData(activityId)
    self.activityId = activityId
end

function PrayShareView:initUI(ui)
    self.super.initUI(self, ui)

    self.btn_close = TFDirector:getChildByPath(ui, "btn_close")

    self:timeOut(function()
        local ret = self:shareResult()
        if ret then
            ActivityDataMgr2:ReqShareComplete(self.activityId)
        end
    end, 0.1)
end

function PrayShareView:shareResult()
    local ret = false
    if HeitaoSdk then
        ret = HeitaoSdk.takeScreenshot()
    else
        ret = takeScreenshot()
        ret = true
    end
    return ret
end

function PrayShareView:registerEvents()
    self.btn_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return PrayShareView