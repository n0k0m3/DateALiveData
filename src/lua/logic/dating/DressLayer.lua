local DressLayer = class("DressLayer",BaseLayer)
local dressTable = TabDataMgr:getData("Dress")

function DressLayer:ctor(data)
    self.super.ctor(self,data)

    self:init("lua.uiconfig.dating.dressLayer")
end

function DressLayer:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Label_name = TFDirector:getChildByPath(ui,"Label_dressTitle")
    self.Label_des = TFDirector:getChildByPath(ui,"Label_dressDescribe")
end

function DressLayer:initData(id)
    local data = dressTable[id]
    if not data then
        Box("数据为空，id: "..id)
        return
    end

    local name = TextDataMgr:getText(data.nameTextId)
    local des = TextDataMgr:getText(data.desTextId)

    self.Label_name:setString(name)
    self.Label_des:setString(des)
end

function DressLayer:onClose()
    self.super.onClose(self)
end

function DressLayer:onShowDressLayer()
    self:setVisible(true)
end

function DressLayer:onHideDressLayer()
    self:setVisible(false)
end

function DressLayer:registerEvents()
    EventMgr:addEventListener(self, "showDressLayer", handler(self.onShowDressLayer, self))
    EventMgr:addEventListener(self, "hideDressLayer", handler(self.onHideDressLayer, self))
end

-- 每次AlertManager:show()之后调用；子弹窗关闭时调用；断线重连时调用
function DressLayer:onShow()
    self.super.onShow(self)
    self:enterAction()
end

function DressLayer:enterAction()
end

return DressLayer;
