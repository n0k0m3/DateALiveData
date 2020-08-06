
local DfwCardView = class("DfwCardView", BaseLayer)

function DfwCardView:initData()
    self.buffData_ = DfwDataMgr:getChessesBuff()
    self.defaultSelectIndex_ = 1
end

function DfwCardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dafuwong.dfwCardView")
end

function DfwCardView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_card = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_root, "Panel_card_" .. i)
        foo.Spine_select = TFDirector:getChildByPath(foo.root, "Spine_select")
        foo.Spine_select:play("ALL", true)
        foo.Button_card = TFDirector:getChildByPath(foo.root, "Button_card")
        foo.Label_num = TFDirector:getChildByPath(foo.root, "Label_num")
        foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
        foo.Button_use = TFDirector:getChildByPath(foo.root, "Button_use")
        foo.Label_use = TFDirector:getChildByPath(foo.Button_use, "Label_use")
        foo.Image_effect = TFDirector:getChildByPath(foo.root, "Image_effect"):hide()
        foo.Label_effect = TFDirector:getChildByPath(foo.Image_effect, "Label_effect")
        foo.Label_effect:setTextById(13210019)
        self.Panel_card[i] = foo
    end

    self:refreshView()
end

function DfwCardView:refreshView()
    for i, v in ipairs(self.Panel_card) do
        local buffCid = self.buffData_[i]
        local buffCfg = DfwDataMgr:getChessesBuffCfg(buffCid)
        local count = GoodsDataMgr:getItemCount(buffCid)
        local itemCfg = GoodsDataMgr:getItemCfg(buffCid)

        v.Label_desc:setTextById(itemCfg.desTextId)
        v.Label_num:setTextById(800005, count, itemCfg.totalMax)
        v.Button_card:setTextureNormal(buffCfg.buffCard)
    end

    self:selectCard(self.defaultSelectIndex_)
end

function DfwCardView:selectCard(index)
    if self.selectIndex_ == index then return end

    if self.selectIndex_ then
        Utils:playSound(5005)
    end

    self.selectIndex_ = index


    local buffCid = self.buffData_[index]
    local count = GoodsDataMgr:getItemCount(buffCid)

    local cellInfo = DfwDataMgr:getCellInfo()
    local isHaveBuff = table.indexOf(cellInfo.buffIds or {}, buffCid) ~= -1

    for i, v in ipairs(self.Panel_card) do
        local isSelect = i == index
        v.Image_effect:setVisible(isSelect and isHaveBuff)
        v.Spine_select:setVisible(isSelect)
    end

    for i, v in ipairs(self.Panel_card) do
        v.Button_use:setVisible(i == index and count > 0 and not isHaveBuff)
    end
end

function DfwCardView:registerEvents()
    EventMgr:addEventListener(self, EV_DFW_UPDATE_BUFF, handler(self.onUpdateBuffEvent, self))

    for i, v in ipairs(self.Panel_card) do
        local buffCid = self.buffData_[i]

        v.Button_card:onClick(function()
                self:selectCard(i)
        end)

        v.Button_use:onClick(function()
                DfwDataMgr:send_SACRIFICE_REQ_ADD_BUFF(buffCid)
        end)
    end
end

function DfwCardView:onUpdateBuffEvent()
    AlertManager:closeLayer(self)
end

return DfwCardView
