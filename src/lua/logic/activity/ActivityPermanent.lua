--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local ActivityPermanent = class("ActivityPermanent", BaseLayer)

function ActivityPermanent:ctor(args)
    print()
    self.super.ctor(self, args)
    self:init("lua.uiconfig.activity.activityEnvelope")
end



return ActivityPermanent


--endregion
