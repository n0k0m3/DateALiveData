local GiftsLayer = class("GiftsLayer",BaseLayer)
local giftTable = TabDataMgr:getData("Item")

function GiftsLayer:ctor(data)
    self.super.ctor(self,data)

    self:init("lua.uiconfig.dating.giftsLayer")
end

function GiftsLayer:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Label_name = TFDirector:getChildByPath(ui,"Label_favoriteFoodTitle")
    self.Label_name.savePos = self.Label_name:Pos()
    self.Label_des = TFDirector:getChildByPath(ui,"Label_giftDescribe")
    self.Label_des:setTextAreaSize(me.size(290,0))
    self.Label_des.saveheight = self.Label_des:Size().height
    self.Label_moodValue = TFDirector:getChildByPath(ui,"Label_moodValue")
    self.Label_favorValue = TFDirector:getChildByPath(ui,"Label_favorValue")
    self.Image_giftInfo = TFDirector:getChildByPath(ui,"Image_giftInfo")
    self.Image_giftInfo.saveSize = self.Image_giftInfo:Size()
end

function GiftsLayer:initData(id)
    local data = giftTable[id]
    if not data then
        Box("数据为空，id: "..id)
        return
    end

    local name = TextDataMgr:getText(data.nameTextId)
    local des = TextDataMgr:getText(data.desTextId)

    self.Label_name:setString(name)
    self.Label_des:setString(des)

    local favorValue = 0
    local moodValue = 0
    if data.useProfit.fix then
        favorValue = data.useProfit.fix.items[1].num
        moodValue = data.useProfit.fix.items[2].num
    end
    local favorBuff = RoleDataMgr:getGoodEffectValue(data.useProfit.fix.items[1].id,RoleDataMgr:getCurRoleInfo().speState)
    local moodBuff = RoleDataMgr:getGoodEffectValue(data.useProfit.fix.items[2].id,RoleDataMgr:getCurRoleInfo().speState)
    if favorBuff > 0 then
        self.Label_moodValue:setString("+".. favorValue .. "(+" .. favorBuff .. ")")
    else
        self.Label_moodValue:setString("+".. favorValue)
    end

    if moodBuff > 0 then
        self.Label_moodValue:setString("+".. moodValue .. "(+" .. moodBuff .. ")")
    else
        self.Label_moodValue:setString("+".. moodValue)
    end

    self:refreshImageGiftInfo()
end

function GiftsLayer:refreshImageGiftInfo()
    local disHeight = self.Label_des:Size().height - self.Label_des.saveheight
    -- self.Label_name:Pos(self.Label_name.savePos.x,self.Label_name.savePos.y + disHeight)
    -- self.Image_giftInfo:Size(self.Image_giftInfo.saveSize.width,self.Image_giftInfo.saveSize.height + disHeight)
end

function GiftsLayer:onClose()
    self.super.onClose(self)
end

-- 每次AlertManager:show()之后调用；子弹窗关闭时调用；断线重连时调用
function GiftsLayer:onShow()
    self.super.onShow(self)
    self:enterAction()
end

function GiftsLayer:enterAction()
end

return GiftsLayer;
