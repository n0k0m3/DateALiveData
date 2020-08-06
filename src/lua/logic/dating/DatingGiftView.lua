local DatingGiftView = class("DatingGiftView",BaseLayer)

function DatingGiftView:initData()
    self.type = 1
    self.list_ = RoleDataMgr:getTriggerDatingList() or {}
    self.optionList_ = {}
    self.selectOption_ = 1
    self.list_ = self:resetList()
    self.sFile = AudioExchangePlay.lastBgmFile
end

function DatingGiftView:resetList()
    local list = {}
    if self.type then
        for i,v in ipairs(self.list_) do
            if self.type == DatingDataMgr:getDatingRuleData(v.datingRuleCid).item_type then
                table.insert(list,v)
            end
        end
    end
    return list
end

function DatingGiftView:ctor()
    self.super.ctor(self)

    self:initData()

    self:init("lua.uiconfig.dating.datingGiftAndDressView")
end

function DatingGiftView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    local Panel_dressTitle = TFDirector:getChildByPath(self.ui, "Panel_dressTitle"):hide()
    local Panel_goodTitle = TFDirector:getChildByPath(self.ui, "Panel_goodTitle"):hide()
    local Image_buttonListBottomGood = TFDirector:getChildByPath(self.ui, "Image_buttonListBottomGood"):hide()
    local Image_buttonListBottomDress = TFDirector:getChildByPath(self.ui, "Image_buttonListBottomDress"):hide()
    local Label_tip = TFDirector:getChildByPath(self.ui, "Label_tip")
    Label_tip:setTextById(12210)
    Label_tip:setVisible(#self.list_ == 0)

    if self.type and self.type == 2 then
        Panel_dressTitle:show()
        Image_buttonListBottomDress:show()
        self:initButtonList(Image_buttonListBottomDress)
    else
        Panel_goodTitle:show()
        Image_buttonListBottomGood:show()
        self:initButtonList(Image_buttonListBottomGood)
    end

    self:initPrefab()
    self:initMainScroll()

    self:showMainScroll()
end

function DatingGiftView:initButtonList(item)
    self.Button_day = TFDirector:getChildByPath(item, "Button_day")
    self.Button_goods = TFDirector:getChildByPath(item, "Button_goods")
    self.Button_dress = TFDirector:getChildByPath(item,"Button_dress")
    self.Button_day.bar = self.Button_day:getChildByName("LoadingBar_p")
    self.Button_day.pr = self.Button_day:getChildByName("Label_p")
    self.Button_goods.bar = self.Button_goods:getChildByName("LoadingBar_p")
    self.Button_goods.pr = self.Button_goods:getChildByName("Label_p")
    self.Button_dress.bar = self.Button_dress:getChildByName("LoadingBar_p")
    self.Button_dress.pr = self.Button_dress:getChildByName("Label_p")

    --self.Button_day.bar:setPercent(RoleDataMgr:getDayDatingPro(self.roleId))
    --self.Button_day.pr:setText(RoleDataMgr:getDayDatingPro(self.roleId) .. "%")
    --self.Button_goods.bar:setPercent(RoleDataMgr:getTriggerDatingProByType(self.roleId,1))
    --self.Button_goods.pr:setText(RoleDataMgr:getTriggerDatingProByType(self.roleId,1) .. "%")
    --self.Button_dress.bar:setPercent(RoleDataMgr:getTriggerDatingProByType(self.roleId,2))
    --self.Button_dress.pr:setText(RoleDataMgr:getTriggerDatingProByType(self.roleId,2) .. "%")

    self.Button_day:getChildByName("Panel_touch"):Touchable(true)
    self.Button_day:getChildByName("Panel_touch"):onClick(function()
        self:showDayView()
    end)

    -- self.Button_goods:getChildByName("Panel_touch"):Touchable(true)
    -- self.Button_goods:getChildByName("Panel_touch"):onClick(function()
    --     self:showGoodsView()
    -- end)

    self.Button_dress:getChildByName("Panel_touch"):Touchable(true)
    self.Button_dress:getChildByName("Panel_touch"):onClick(function()
        self:showDressView()
    end)

    self.Button_cg = TFDirector:getChildByPath(item, "Button_cg")
    self.Button_cg:getChildByName("Panel_touch"):Touchable(true)
    self.Button_cg:getChildByName("Panel_touch"):onClick(function()
        self:showMainView()
    end)
end

function DatingGiftView:showMainView()
    Utils:openView("dating.DatingPokedexSpriteView")
    AlertManager:closeLayer(self)
    -- local layer = require("lua.logic.dating.DatingPokedexSpriteView"):new()
    -- AlertManager:closeLayer(self)
    -- AlertManager:addLayer(layer, AlertManager.BLOCK)
    -- AlertManager:show()
end

function DatingGiftView:showDayView()
    Utils:openView("dating.DailyCityInfoView")
    AlertManager:closeLayer(self)
    -- local layer = require("lua.logic.dating.DailyCityInfoView"):new(true)
    -- AlertManager:closeLayer(self)
    -- AlertManager:addLayer(layer, AlertManager.BLOCK)
    -- AlertManager:show()
end

function DatingGiftView:showGoodsView()
    Utils:openView("dating.DatingGiftView")
    AlertManager:closeLayer(self)
    -- local layer = require("lua.logic.dating.DatingGiftView"):new()
    -- AlertManager:closeLayer(self)
    -- AlertManager:addLayer(layer, AlertManager.BLOCK)
    -- AlertManager:show()
end

function DatingGiftView:showDressView()
    Utils:openView("dating.DatingDressView")
    AlertManager:closeLayer(self)
    -- local layer = require("lua.logic.dating.DatingDressView"):new()
    -- AlertManager:closeLayer(self)
    -- AlertManager:addLayer(layer, AlertManager.BLOCK)
    -- AlertManager:show()
end

function DatingGiftView:initPrefab()
    self.Panel_mainItem = TFDirector:getChildByPath(self.ui,"Panel_mainItem")
end

function DatingGiftView:initMainScroll()
    local ScrollView_main = TFDirector:getChildByPath(self.ui,"ScrollView_main")
    self.mainScroll = UIGridView:create(ScrollView_main)
    self.mainScroll:setItemModel(self.Panel_mainItem)
    self.mainScroll:setColumn(2)
    self.mainScroll:setColumnMargin(15)
    self.mainScroll:setRowMargin(10)
end

function DatingGiftView:showMainScroll()
    self.mainScroll:removeAllItems()

    for i,v in ipairs(self.list_) do
        local mainItem = self.Panel_mainItem:clone()
        self:initItem(mainItem,v)
        self:updateItem(mainItem)
        self.mainScroll:pushBackCustomItem(mainItem)
        table.insert(self.optionList_,mainItem)
    end
end

function DatingGiftView:initItem(item,v)
    local Label_des = TFDirector:getChildByPath(item,"Label_des")
    local datingContentId = DatingDataMgr:getDatingRuleData(v.datingRuleCid).datingContent
    Label_des:setTextById(datingContentId)

    local Label_title = TFDirector:getChildByPath(item,"Label_title")
    local datingTitleId = DatingDataMgr:getDatingRuleData(v.datingRuleCid).datingTitle
    Label_title:setTextById(datingTitleId)

    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local iconPath = DatingDataMgr:getDatingRuleData(v.datingRuleCid).item
    Image_icon:setTexture(iconPath)
    Image_icon:Size(100,100)

    item.btn = TFDirector:getChildByPath(item,"Button_enter")
end

function DatingGiftView:refreshItems()
    for i,v in ipairs(self.optionList_) do
        self:updateItem(v,i)
    end
end

function DatingGiftView:updateItem(item,idx)

end

function DatingGiftView:selectOption(idx)
    self.selectOption_ = idx
    self:refreshItems()
    local info = self.list_[self.selectOption_]
    DatingDataMgr:showDatingLayer(EC_DatingScriptType.SHOW_SCRIPT,info.currentNodeId,false,info.datingRuleCid)
end

function DatingGiftView:registerEvents()
    for i,v in ipairs(self.optionList_) do
        local optionItem = v
        if optionItem.btn then
            optionItem.btn:onClick(function()
                self:selectOption(i)
            end)
        end
    end
end

function DatingGiftView:onShow()
    self.super.onShow(self)
    AudioExchangePlay.playBGM(self, true,self.sFile)
end

function DatingGiftView:setCloseCallback(callBack)
    self.closeCallBack = callBack
end

function DatingGiftView:onClose()
    self.super.onClose(self)

    if self.closeCallBack then
        self.closeCallBack()
    end
end


return DatingGiftView