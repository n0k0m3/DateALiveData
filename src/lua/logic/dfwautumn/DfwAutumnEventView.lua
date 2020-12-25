
local DfwAutumnEventView = class("DfwAutumnEventView", BaseLayer)

function DfwAutumnEventView:initData(eventCid, baseReward, additionReward)
    self.eventCid_ = eventCid
    self.eventCfg_ = DfwDataMgr:getChessesEventCfg(self.eventCid_)
    self.isBuffAddition_ = false

    local reward = {}
    if baseReward then
        table.insertTo(reward, baseReward)
    end
    if additionReward then
        table.insertTo(reward, additionReward)
        self.isBuffAddition_ = #additionReward > 0
    end
    self.reward_ = Utils:mergeReward(reward)

end

function DfwAutumnEventView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dafuwong.dfwAutumnEventView")
end

function DfwAutumnEventView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Image_icon = TFDirector:getChildByPath(Image_content, "Image_icon")
    self.Image_head = TFDirector:getChildByPath(Image_content, "Image_head")
    self.Label_desc = TFDirector:getChildByPath(Image_content, "Label_desc")
    self.Label_buff = TFDirector:getChildByPath(Image_content, "Label_buff")
    local ScrollView_reward = TFDirector:getChildByPath(Image_content, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.Button_receive = TFDirector:getChildByPath(Image_content, "Button_receive")
    self.Label_receive = TFDirector:getChildByPath(self.Button_receive, "Label_receive")

    self:refreshView()
end

function DfwAutumnEventView:refreshView()
    self.Label_title:setTextById(self.eventCfg_.name)
    self.Label_desc:setTextById(self.eventCfg_.des)
    self.Image_icon:Scale(0.8):setTexture(self.eventCfg_.head)
    self.Label_receive:setTextById(900811)
    self.ListView_reward:setItemsMargin(10)
    self.Label_buff:setTextById(13210017)
    self.Label_buff:setVisible(self.isBuffAddition_)
    self.Image_head:setVisible(self.eventCfg_.showBoard)

    for i, v in ipairs(self.reward_) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.75)
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end
    Utils:setAliginCenterByListView(self.ListView_reward, true)
end

function DfwAutumnEventView:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_receive:onClick(function()
            AlertManager:closeLayer(self)
            Utils:showReward(self.reward_)
    end)
end

return DfwAutumnEventView
