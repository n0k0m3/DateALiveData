
local KabalaTreeAwardBuff = class("KabalaTreeAwardBuff", BaseLayer)

function KabalaTreeAwardBuff:initData(buffCid)
    self.buffCid = buffCid
end

function KabalaTreeAwardBuff:ctor(...)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeAwardBuff")
end

function KabalaTreeAwardBuff:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_bg = TFDirector:getChildByPath(ui, "Panel_bg")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")

    self.Label_buff_name = TFDirector:getChildByPath(self.Panel_root, "Label_buff_name")
    self.Label_buff_desc = TFDirector:getChildByPath(self.Panel_root, "Label_buff_desc")
    self.Label_buff_effect = TFDirector:getChildByPath(self.Panel_root, "Label_buff_effect")
    self.Image_buff_bag = TFDirector:getChildByPath(self.Panel_root, "Image_buff_bag")
    KabalaTreeDataMgr:clearNewBuffs()
    self:refreshView()
end

function KabalaTreeAwardBuff:refreshView()

    local itemCfg = GoodsDataMgr:getItemCfg(self.buffCid)
    if not itemCfg then
        return
    end

    self.Label_buff_name:setTextById(itemCfg.nameTextId)

    local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
    Panel_goodsItem:setScale(0.8)
    PrefabDataMgr:setInfo(Panel_goodsItem, self.buffCid)
    Panel_goodsItem:setPosition(ccp(0,0))
    self.Image_buff_bag:addChild(Panel_goodsItem)
    self.Label_buff_desc:setTextById(itemCfg.desTextId)
    self.Label_buff_effect:setTextById(3004051)
end


function KabalaTreeAwardBuff:registerEvents()

end

function KabalaTreeAwardBuff:onShow()
    self.super.onShow(self)
end

function KabalaTreeAwardBuff:onHide()
    self.super.onHide(self)
    local eventPoints = KabalaTreeDataMgr:getHiddenEventPoints()
    if eventPoints then
        EventMgr:dispatchEvent(EV_PLAY_HIDDENEVENT_EFFECT)
    end
end

return KabalaTreeAwardBuff
