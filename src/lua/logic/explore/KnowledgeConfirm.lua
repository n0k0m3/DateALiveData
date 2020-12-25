local KnowledgeConfirm = class("KnowledgeConfirm", BaseLayer)


function KnowledgeConfirm:ctor(knowledgeId)
    self.super.ctor(self)
    self:initData(knowledgeId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.explore.knowledgeConfirm")
end

function KnowledgeConfirm:initData(knowledgeId)

    self.knowledgeId = knowledgeId
end

function KnowledgeConfirm:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")

    self.Label_name = TFDirector:getChildByPath(self.Panel_root,"Label_name")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_root,"Label_desc")
    self.Label_effect = TFDirector:getChildByPath(self.Panel_root,"Label_effect")

    self.Panel_next = TFDirector:getChildByPath(self.Panel_root,"Panel_next"):hide()
    self.Label_next_effect = TFDirector:getChildByPath(self.Panel_root,"Label_next_effect")

    self.Panel_lock = TFDirector:getChildByPath(self.Panel_root,"Panel_lock"):hide()
    self.Label_condition = TFDirector:getChildByPath(self.Panel_lock,"Label_condition"):hide()
    local ScrollView_condition = TFDirector:getChildByPath(self.Panel_lock,"ScrollView_condition")
    self.ListView_condition = UIListView:create(ScrollView_condition)

    self.Panel_cost = TFDirector:getChildByPath(self.Panel_root,"Panel_cost"):hide()
    self.Image_cost = TFDirector:getChildByPath(self.Panel_cost,"Image_cost")
    self.Label_cost = TFDirector:getChildByPath(self.Panel_cost,"Label_cost")

    self.Button_ok = TFDirector:getChildByPath(self.Panel_root,"Button_ok")

    self:initUILogic()
end

function KnowledgeConfirm:initUILogic()

    self.Label_name:setText("明信片")
    self.Label_desc:setText("一张明信片等于一张电影票")

    self:updateKnowledgeInfo()
end

function KnowledgeConfirm:updateKnowledgeInfo()

    ---是否解锁
    local isLock = false
    self.Button_ok:setVisible(not isLock)
    self.Panel_cost:setVisible(not isLock)
    self.Panel_next:setVisible(not isLock)
    self.Panel_lock:setVisible(isLock)

    ---当前效果显示
    local curEffect = "提升3阶品质奖励权重200"
    self.Label_effect:setText(curEffect)

    ---下阶效果显示
    local nextEffect = "提升3阶品质奖励权重400"
    self.Label_next_effect:setText(nextEffect)

    self:updateLockCondition()
    self:updateCost()
end

function KnowledgeConfirm:updateLockCondition()

    self.ListView_condition:removeAllItems()
    for i=1,3 do
        local conditionItem = self.Label_condition:clone()
        conditionItem:setText("学习新年知识贺卡解锁")
        conditionItem:show()
        self.ListView_condition:pushBackCustomItem(conditionItem)
    end
end


function KnowledgeConfirm:updateCost()

    local itemCfg = GoodsDataMgr:getItemCfg(500066)
    if not itemCfg then
        return
    end
    self.Image_cost:setTexture(itemCfg.icon)

    local costCnt = 2
    local ownCnt = GoodsDataMgr:getItemCount(500066)
    self.Label_cost:setText(costCnt .. "/" .. ownCnt)

    local posX = self.Label_cost:getPositionX()
    local w = self.Label_cost:getContentSize().width
    local x = posX - w - 2
    self.Image_cost:setPositionX(x)
end

function KnowledgeConfirm:registerEvents()

    self.Button_ok:onClick(function()
        Utils:showTips("学习学习")
    end)
end

return KnowledgeConfirm
