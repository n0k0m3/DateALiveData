
local WelfareScanView = class("WelfareScanView", BaseLayer)

function WelfareScanView:initData()

end

function WelfareScanView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.oneYear.welfareScanView")
end

function WelfareScanView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_reward = TFDirector:getChildByPath(self.Panel_prefab, "Panel_reward")

    self.funbtn_ = {}
    for i=1,2 do
        local btn = TFDirector:getChildByPath(self.Panel_root, "Button_"..i)
        local Image_select = TFDirector:getChildByPath(btn, "Image_select")
        local btnText = TFDirector:getChildByPath(btn, "Label_btn")
        table.insert(self.funbtn_,{btn = btn,btnText = btnText, select = Image_select})
    end

    self.Image_scroll_bg = TFDirector:getChildByPath(self.Panel_root, "Image_scroll_bg")
    self.Panel_rule = TFDirector:getChildByPath(self.Panel_root, "Panel_rule")
    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")

    self.panel_award = {}
    for i=1,3 do
        local Panel_reward = TFDirector:getChildByPath(self.Panel_root, "Panel_reward_"..i)
        local Image_more = TFDirector:getChildByPath(self.Panel_root, "Image_more"..i)
        local ScrollView_type = TFDirector:getChildByPath(Panel_reward, "ScrollView_type")
        local ListView_type = UIListView:create(ScrollView_type)
        table.insert(self.panel_award,{listView = ListView_type,iconmore = Image_more})
    end

    self.Panel_item_cell = TFDirector:getChildByPath(self.Panel_prefab, "Panel_item_cell")

    local ScrollView_rule = TFDirector:getChildByPath(self.ui, "ScrollView_rule")
    self.ListView_rule = UIListView:create(ScrollView_rule)
    self.Label_contentCloneObj = TFDirector:getChildByPath(self.ui, "Label_contentCloneObj")
    local size = self.ListView_rule:getContentSize()
    local Label_content = self.Label_contentCloneObj:clone():Show()
    Label_content:setTextById(63600)
    Label_content:setDimensions(size.width, 0)
    self.ListView_rule:pushBackCustomItem(Label_content)
    
    self:refreshView()
    self:chooseFunction(1)
end

function WelfareScanView:chooseFunction(funcId)
    for k,v in ipairs(self.funbtn_) do
        v.select:setVisible(k == funcId)
        local color = k == funcId and ccc3(255,255,255) or ccc3(110,149,233)
        v.btnText:setColor(color)
    end

    self.Image_scroll_bg:setVisible(funcId == 1)
    self.Panel_rule:setVisible(funcId == 2)
end

function WelfareScanView:refreshView()

    for i=1,3 do
        local items = SummonDataMgr:getCelebrationPool(i)
        for k,v in ipairs(items) do
            local itemCell = self.Panel_item_cell:clone()
            local Image_type_bg1 = TFDirector:getChildByPath(itemCell, "Image_type_bg1")
            local Image_type_bg2 = TFDirector:getChildByPath(itemCell, "Image_type_bg2")
            local Image_type_bg3 = TFDirector:getChildByPath(itemCell, "Image_type_bg3")
            Image_type_bg1:setVisible(i==1)
            Image_type_bg2:setVisible(i==2)
            Image_type_bg3:setVisible(i==3)
            local Image_item = TFDirector:getChildByPath(itemCell, "Image_item")
            local Label_name = TFDirector:getChildByPath(itemCell, "Label_name")
            local Label_cnt = TFDirector:getChildByPath(itemCell, "Label_cnt")
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            local Image_frame = TFDirector:getChildByPath(Panel_goodsItem, "Image_frame"):hide()
            --Panel_goodsItem:setScale(0.4)
            PrefabDataMgr:setInfo(Panel_goodsItem, v.id)
            Panel_goodsItem:setPosition(ccp(0,0))
            Image_item:addChild(Panel_goodsItem)
            local itemCfg = GoodsDataMgr:getItemCfg(v.id)
            Label_name:setTextById(itemCfg.nameTextId)
            Label_cnt:setText("x"..v.num)
            self.panel_award[i].listView:pushBackCustomItem(itemCell)
        end
        local contentSize = self.panel_award[i].listView:getContentSize()
        local innerSize = self.panel_award[i].listView:getInnerContainerSize()
        self.panel_award[i].iconmore:setVisible(innerSize.width > contentSize.width)
    end

end

function WelfareScanView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:close()
    end)

    for k,v in ipairs(self.funbtn_) do
        v.btn:onClick(function()
            self:chooseFunction(k)
        end)
    end
end

return WelfareScanView
