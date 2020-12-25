
local FubenSpriteRewardView = class("FubenSpriteRewardView", BaseLayer)

function FubenSpriteRewardView:initData()

end

function FubenSpriteRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fuben.fubenSpriteRewardView")
end

function FubenSpriteRewardView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Label_titleEn = TFDirector:getChildByPath(Image_content, "Label_titleEn")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Label_tips")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(Image_content, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    local ScrollView_reward = TFDirector:getChildByPath(Image_content, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_reward:setItemsMargin(5)

    self:refreshView()
end

function FubenSpriteRewardView:refreshView()
    self.Label_tips:setTextById(2106060)
    self.Label_title:setTextById(2106061)

    local reward, realDropCid = FubenDataMgr:getSpriteReward()
    local multipleReward, extraReward, allMultiple = ActivityDataMgr2:getDropReward(realDropCid)
    for i, v in ipairs(reward) do
        local flag = 0
        local arg = {}
        local itemId = v[1]
        local itemNum = v[2]
        local multiple = multipleReward[itemId]
        if multiple then
            flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
            arg.multiple = multiple
        end
        if allMultiple > 0 then
            flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
            arg.multiple = allMultiple
        end
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.8)
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {itemId, itemNum}, flag, arg)
        self.ListView_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end
    Utils:setAliginCenterByListView(self.ListView_reward, true)
end

function FubenSpriteRewardView:registerEvents()
    self.Button_ok:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

return FubenSpriteRewardView
