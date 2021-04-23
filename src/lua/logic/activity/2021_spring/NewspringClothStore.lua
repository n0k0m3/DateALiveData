--[[
version: creator 2.4.1
Author: 张鹏程
Date: 2021-01-24 11:30:47
--]]
local NewspringClothStore = class("NewspringClothStore",BaseLayer)
function NewspringClothStore:ctor(...)
    self.super.ctor(self)
    self.block = AlertManager.BLOCK_CLOSE
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.newspringClothStore")
end

function NewspringClothStore:initUI(ui)
    self.super.initUI(self,ui)

    self.Button_close                   = TFDirector:getChildByPath(ui,"Button_close")
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
    self.Button_get                     = TFDirector:getChildByPath(ui,"Button_get")
    self.Button_get:onClick(function()
        FunctionDataMgr:jGiftPacks(1, 2)
    end)

    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId, extendData )
        -- body
        -- if self.activityId == activityId then
        --     AlertManager:closeLayer(self)
        -- end
    end)
end

function NewspringClothStore:onShow()
    self.super.onShow(self)
    DatingDataMgr:triggerDating(self.__cname, "onShow")
end

return NewspringClothStore