local UnlockGoodsView = class("UnlockGoodsView",BaseLayer)

function UnlockGoodsView:initData(data)
    if not data then
        data = {}
    end
    self.useRoleInfo = data.lastRoleInfo or {}
    self.sMsg = DatingDataMgr:getDatingSettlementMsg()
    self.cgs = self.sMsg.cgs or {}
    self.dressData = self.sMsg.dressData or {}
    self.datas = {}
    for i,v in ipairs(self.cgs) do
        v.type = "cg"
        table.insert(self.datas,v)
    end
    for i,v in ipairs(self.dressData) do
        v.type = "dress"
        table.insert(self.datas,v)
    end
    self.pathName = data.pathName
    self.curIndex = 1
end

function UnlockGoodsView:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)
    self:init("lua.uiconfig.dating.unlockGoods")
end

function UnlockGoodsView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    local Image_bg = TFDirector:getChildByPath(self.ui,"Image_bg")
    Image_bg:setTexture(self.pathName)

    self.Image_unlockCgTitle = TFDirector:getChildByPath(self.ui,"Image_unlockCgTitle"):hide()
    self.Image_unlockDressTitle = TFDirector:getChildByPath(self.ui,"Image_unlockDressTitle"):hide()

    self:initGoods()
    self:enter()
end

function UnlockGoodsView:enter()
    self:refreshGoods(self.datas[self.curIndex].iconPath,self.datas[self.curIndex].type)
    self:playAction()
end

function UnlockGoodsView:initGoods()
    self.Image_icon = TFDirector:getChildByPath(self.ui,"Image_icon")
    self.Image_icon:setOpacity(0)

    self.Spine_unlockGoodsBottom = TFDirector:getChildByPath(self.ui,"Spine_unlockGoodsBottom")
end

function UnlockGoodsView:refreshGoods(iconPath,goodType)
    if iconPath then
        self.Image_icon:setTexture(iconPath)
    end
    if goodType == "dress" then
        self.Spine_unlockGoodsBottom:hide()
        self.Image_unlockDressTitle:show()
        self.Image_unlockCgTitle:hide()
    elseif goodType == "cg" then
        self.Spine_unlockGoodsBottom:show()
        self.Image_unlockCgTitle:show()
        self.Image_unlockDressTitle:hide()
    end
end

function UnlockGoodsView:playAction()
    self.ui:show()
    self.ui:timeOut(function()
        self.Image_icon:fadeIn(0.5)
        end,0)
    self.ui:timeOut(function()
        self.ui:hide()
        self.Image_icon:setOpacity(0)
        end,3)
    self.ui:timeOut(function()
        if self.curIndex == #self.datas then
            local data = {}
            data.lastRoleInfo = clone(self.useRoleInfo)
            data.pathName = self.pathName
            AlertManager:closeLayer(self)
            local settlementLayer = require("lua.logic.dating.SettlementLayer"):new(data)
            AlertManager:addLayer(settlementLayer)
            AlertManager:show()
        else
            self.curIndex = self.curIndex + 1
            self:enter()
        end
        end,3)
end

function UnlockGoodsView:onClose()
    self.super.onClose(self)

    EventMgr:dispatchEvent(EV_DATING_EVENT.UnlockGoodsView)
end


function UnlockGoodsView:registerEvents()

end

return UnlockGoodsView;
