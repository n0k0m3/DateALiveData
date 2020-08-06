local MoodLayer = class("MoodLayer",BaseLayer)
local moodLayer = nil
function MoodLayer:ctor(data)
    self.super.ctor(self,data)

    if data then
        self.useId = data.useId
        self.worldPos = data.worldPos
        self.parent = data.parent
    end
    self:init("lua.uiconfig.dating.moodLayer")
end

function MoodLayer:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Image_bg = TFDirector:getChildByPath(ui,"Image_bg")
    self.Image_bg:setScale(0)

    local pos = self.parent:convertToNodeSpace(self.worldPos)
    print("MoodLayer:initUI self.worldPos",self.worldPos)
    print("MoodLayer:initUI pos",pos)
    self.Image_bg:Pos(pos)

    self.Lable_title = TFDirector:getChildByPath(ui,"Lable_title")
    self.Label_des = TFDirector:getChildByPath(ui,"Label_describe")
    self.Label_value = TFDirector:getChildByPath(ui,"Label_value")
    self.Panel_touch = TFDirector:getChildByPath(ui,"Panel_touch"):hide()
    -- self.Panel_touch:OnBegan(function(sender, pos)

    -- end)

    -- self.Panel_touch:OnEnded(function(sender, pos)
    --     self:outAction()

    --     self.ui:timeOut(function()
    --             self:onClose()
    --             self:removeFromParent()
    --             moodLayer = nil
    --         end,
    --         0.3)

    --     self.Panel_touch:setTouchEnabled(false)
    -- end)
    self:refreshUI()
    EventMgr:dispatchEvent("hideDressLayer")

    self:enterAction()
end


function MoodLayer:refreshUI()
    self.Label_des:setString(RoleDataMgr:getMoodDes(self.useId,RoleDataMgr:getMoodLevel(self.useId),10000))
    self.Label_value:setString(tostring(RoleDataMgr:getMood(self.useId)))
end

function MoodLayer:onClose()
    self.super.onClose(self)
    EventMgr:dispatchEvent("showDressLayer")
end

-- 每次AlertManager:show()之后调用；子弹窗关闭时调用；断线重连时调用
function MoodLayer:onShow()
    self.super.onShow(self)
    self:enterAction()
end

function MoodLayer:enterAction()
    self.Image_bg:scaleTo(0.2,0.9)
end

function MoodLayer:outAction()
    self.Image_bg:scaleTo(0.2,0)
end

function MoodLayer.close()
    if moodLayer then
        moodLayer:outAction()
        moodLayer.ui:timeOut(function()
                moodLayer:onClose()
                moodLayer:removeFromParent()
                moodLayer = nil
            end,
            0.3)
    end
end

function MoodLayer.show(data)
    if not moodLayer and data and data.parent then
        moodLayer = MoodLayer:new(data)
        data.parent:addChild(moodLayer,999)
    end
    return moodLayer
end

return MoodLayer;
