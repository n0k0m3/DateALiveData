
local CelebrationRuleView = class("CelebrationRuleView", BaseLayer)

function CelebrationRuleView:initData(activityId)
    self.targetValue = 200
    self.activityId_ = activityId

end

function CelebrationRuleView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.oneYear.celebrationRuleView")
end

function CelebrationRuleView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.selectBtn = {}
    for i=1,2 do
        local tab = {}
        tab.btn = TFDirector:getChildByPath(self.Panel_root, "Button_"..i)
        tab.Image_select = TFDirector:getChildByPath(tab.btn, "Image_select")
        table.insert(self.selectBtn,tab)
    end

    self.Panel_rule = TFDirector:getChildByPath(self.Panel_root, "Panel_rule")
    local ScrollView_rule = TFDirector:getChildByPath(self.Panel_root, "ScrollView_rule")
    self.ListView_rule = UIListView:create(ScrollView_rule)
    self.Label_contentCloneObj = TFDirector:getChildByPath(self.ui, "Label_contentCloneObj")

    self.Panel_award = TFDirector:getChildByPath(self.Panel_root, "Panel_award")
    local ScrollView_award = TFDirector:getChildByPath(self.Panel_root, "ScrollView_award")
    self.ListView_award = UIListView:create(ScrollView_award)
    self.Panel_award_item = TFDirector:getChildByPath(self.Panel_root, "Panel_award_item")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.Label_rule_tip = TFDirector:getChildByPath(self.Panel_root, "Label_rule_tip")
    self.Label_rule_tip:setTextById(63608)

    self:initContent()
    self:updateAwardInfo()
    self:choosePanel(1)
end

function CelebrationRuleView:initContent()
    local size = self.ListView_rule:getContentSize()
    local Label_content = self.Label_contentCloneObj:clone():Show()
    Label_content:setTextById(63601)
    Label_content:setDimensions(size.width, 0)
    self.ListView_rule:pushBackCustomItem(Label_content)
end

function CelebrationRuleView:choosePanel(id)

    for k,v in ipairs(self.selectBtn) do
        v.Image_select:setVisible(id == k)
    end

    self.Panel_award:setVisible(id == 1)
    self.Panel_rule:setVisible(id == 2)

end

function CelebrationRuleView:updateAwardInfo()

    local awards = OneYearDataMgr:getCelebrationRewards()
    self.ListView_award:removeAllItems()
    for type,v in ipairs(awards) do
        local awardItem = self.Panel_award_item:clone()
        awardItem:setVisible(true)
        self.ListView_award:pushBackCustomItem(awardItem)
        local Label_title = TFDirector:getChildByPath(awardItem, "Label_title")
        Label_title:setTextById(v.text)
        local Label_info = TFDirector:getChildByPath(awardItem, "Label_info")
        local str = v.amount ~= 0 and TextDataMgr:getText(112000259)..v.amount or TextDataMgr:getText(63599)
        Label_info:setText(str)
        local index = 0
        for k,num in pairs(v.show) do
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setScale(0.6)
            local itemId = tonumber(k)
            if itemId then
                index = index + 1
                PrefabDataMgr:setInfo(Panel_goodsItem, itemId, num)
                local posX = -150 + (index-1)*70
                Panel_goodsItem:Pos(posX, -15)
                awardItem:addChild(Panel_goodsItem)
            end
        end
    end
end

function CelebrationRuleView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for k,v in ipairs(self.selectBtn) do
        v.btn:onClick(function()
            self:choosePanel(k)
        end)
    end
end

return CelebrationRuleView
