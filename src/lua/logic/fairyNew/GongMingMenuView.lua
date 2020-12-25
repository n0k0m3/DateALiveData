local GongMingMenuView = class("GongMingMenuView", BaseLayer)

function GongMingMenuView:ctor()
    self.super.ctor(self)
    self:initData()
    --self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.gongmingMenuView")
end

function GongMingMenuView:initData()
    self.skillItems_ = {}
    self.selectItem = nil
end

function GongMingMenuView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_item = TFDirector:getChildByPath(ui, "Panel_item")
    local ScrollView_list = TFDirector:getChildByPath(ui, "ScrollView_list")
    self.GridView_item = UIGridView:create(ScrollView_list)
    self.GridView_item:setItemModel(self.Panel_item)
    self.GridView_item:setColumn(4)

    self.Image_icon = TFDirector:getChildByPath(ui, "Image_icon")
    self.Label_skill_name = TFDirector:getChildByPath(ui, "Label_skill_name")
    self.Label_skill_desc = TFDirector:getChildByPath(ui, "Label_skill_desc")
    self.Label_Lv = TFDirector:getChildByPath(ui, "Label_Lv")

    self.Image_cost_bg = TFDirector:getChildByPath(ui, "Image_cost_bg")
    self.Label_own = TFDirector:getChildByPath(self.Image_cost_bg, "Label_own")
    self.Label_cost = TFDirector:getChildByPath(self.Image_cost_bg, "Label_cost")
    self.Image_cost = TFDirector:getChildByPath(self.Image_cost_bg, "Image_cost")

    self.Button_up = TFDirector:getChildByPath(ui, "Button_up")
    self.Label_btn = TFDirector:getChildByPath(self.Button_up, "Label_btn")

    self:initMenu()

end

function GongMingMenuView:initMenu()
    --local arrayData = ResonanceDataMgr:getManaResonanceArray()
    --for skillType,infos_ in ipairs(arrayData) do
    --    for _,data in ipairs(infos_) do
    --        local item = self:addSkillItem(data)
    --        self:updateMenuItem(item, data)
    --        if not self.selectItem then
    --            self:selectMenuItem(item,data)
    --        end
    --    end
    --end

    local arrayData = ResonanceDataMgr:getManaMenu()
    for _,data in ipairs(arrayData) do
        local item = self:addSkillItem(data)
        self:updateMenuItem(item, data)
        if not self.selectItem then
            self:selectMenuItem(item,data)
        end
    end
end

function GongMingMenuView:updateMenu()
    for k,v in pairs(self.skillItems_) do
        self:updateMenuItem(k, v.data)
    end
end

function GongMingMenuView:addSkillItem(data)

    local item = self.GridView_item:pushBackDefaultItem()
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Image_max = TFDirector:getChildByPath(item, "Image_max")
    local Image_up = TFDirector:getChildByPath(item, "Image_up")
    local Image_unlock = TFDirector:getChildByPath(item, "Image_unlock")
    local Image_lock = TFDirector:getChildByPath(item, "Image_lock")
    local Image_nomal = TFDirector:getChildByPath(item, "Image_nomal")
    local Image_select = TFDirector:getChildByPath(item, "Image_select"):hide()
    self.skillItems_[item] = { root = item, Image_icon = Image_icon,Image_select = Image_select,
                               Image_max = Image_max, Image_up = Image_up, Image_lock = Image_lock,Image_nomal = Image_nomal, Image_unlock = Image_unlock, data = data}
    return item
end

function GongMingMenuView:updateMenuItem(item,data)

    if not data or not item then
        return
    end
    local skillItem = self.skillItems_[item]
    skillItem.Image_icon:setTexture(data.icon)

    ---not lv 表示未解锁
    local lv = ResonanceDataMgr:getSkillLv(data.id)
    local isUnlock = lv and true or false
    skillItem.Image_lock:setVisible(not isUnlock)
    skillItem.Image_max:setVisible(isUnlock)
    skillItem.Image_up:setVisible(isUnlock)

    local quality = data.quality
    if EC_ItemIcon[quality+1] then
        skillItem.Image_nomal:setTexture(EC_ItemIcon[quality+1])
    end

    lv = lv or 0
    local nextLv = lv + 1
    local costInfo = ResonanceDataMgr:getManaCostData(quality,nextLv)
    local itemId = data.costItem
    if isUnlock then
        skillItem.Image_unlock:setVisible(false)
        local isMax = costInfo == nil and true or false
        skillItem.Image_max:setVisible(isMax)
        skillItem.Image_up:setVisible(not isMax)
        if not isMax then
            if not itemId or not costInfo then
                return
            end
            local ownCnt = GoodsDataMgr:getItemCount(itemId)
            local fitItem = ownCnt >= costInfo.cost
            local Level = MainPlayer:getPlayerLv()
            local fitLv = Level >= costInfo.restriction
            skillItem.Image_up:setVisible(fitItem and fitLv)
        end
    else
        if itemId and costInfo then
            local ownCnt = GoodsDataMgr:getItemCount(itemId)
            skillItem.Image_unlock:setVisible(ownCnt >= costInfo.cost)
        end
    end

    skillItem.root:onClick(function()
        self:selectMenuItem(item,data)
    end)
end

function GongMingMenuView:selectMenuItem(item,data)

    local skillItem = self.skillItems_[item]
    if not skillItem then
        return
    end
    if self.selectItem then
        self.selectItem.Image_select:setVisible(false)
    end
    skillItem.Image_select:setVisible(true)
    self.selectItem = skillItem
    self.selectData = data
    self:updateMenuItemInfo()
end

function GongMingMenuView:updateMenuItemInfo()

    if not self.selectData then
        return
    end

    self.Image_icon:setTexture(self.selectData.icon)
    self.Label_skill_name:setTextById(self.selectData.name)


    local lv = ResonanceDataMgr:getSkillLv(self.selectData.id)
    lv = lv or 0
    self.Label_Lv:setText(lv)
    self.Label_skill_desc:setText("")

    local curpassiveSkillId = ResonanceDataMgr:getPassiveSkillId(self.selectData.id,lv)
    if lv == 0 then
        curpassiveSkillId = ResonanceDataMgr:getPassiveSkillId(self.selectData.id,1)
    end
    if curpassiveSkillId then
        local curCfg = ResonanceDataMgr:getPassiveSkillCfg(curpassiveSkillId)
        if curCfg then
            self.Label_skill_desc:setTextById(curCfg.des)
        end
    end

    local quality = self.selectData.quality
    local nextLv = lv + 1
    local costInfo = ResonanceDataMgr:getManaCostData(quality,nextLv)
    if not costInfo then
        self.Image_cost_bg:setVisible(false)
        self.Button_up:setVisible(false)
        return
    end

    self.Image_cost_bg:setVisible(true)

    local itemId = self.selectData.costItem

    local ownCnt = GoodsDataMgr:getItemCount(itemId)
    local color = ownCnt >= costInfo.cost and ccc3(255,255,255) or ccc3(247,84,115)
    self.Label_own:setText(ownCnt)
    self.Label_own:setColor(color)
    self.Label_cost:setText("/"..costInfo.cost)
    local posX = self.Label_own:getPositionX() + self.Label_own:getContentSize().width
    self.Label_cost:setPositionX(posX)

    local Panel_goodsItem = self.Image_cost:getChildByName("Panel_goodsItem")
    if not Panel_goodsItem then
        Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setName("Panel_goodsItem")
        self.Image_cost:addChild(Panel_goodsItem)
        Panel_goodsItem:Pos(ccp(0,0))
    end
    PrefabDataMgr:setInfo(Panel_goodsItem,itemId)
    self.Button_up:setVisible(ownCnt >= costInfo.cost)

    local btnStrId = lv == 0 and 14221102 or 14221101
    self.Label_btn:setTextById(btnStrId)
end

function GongMingMenuView:onItemUpdateEvent()
    self:updateMenuItemInfo()
    self:updateMenu()
end

function GongMingMenuView:registerEvents()

    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_AFTER_UPGRADE_GM_SKILL, handler(self.onItemUpdateEvent, self))

    self.Button_up:onClick(function()

        local function doSomething()
            ResonanceDataMgr:Send_UpSkill(self.selectData.id)
        end
        if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReconFirm_UpgradeGMSkill) then
            doSomething()
        else
            local lv = ResonanceDataMgr:getSkillLv(self.selectData.id)
            lv = lv or 0
            local textId = lv == 0 and 14220109 or 14221104
            local rstr = TextDataMgr:getTextAttr(textId)
            local formatStr = rstr and rstr.text or ""
            local showData = {}
            showData.tittle = 13311184
            showData.content = formatStr
            showData.confirmCall = doSomething
            showData.reType = EC_OneLoginStatusType.ReconFirm_UpgradeGMSkill
            Utils:openView("common.ReConfirmTipsView", showData)
        end


    end)
end


return GongMingMenuView