
local DlsReadyView = class("DlsReadyView", BaseLayer)

function DlsReadyView:initData(levelCid)
    self.levelCid_ = levelCid
    self.levelCfg_ = DlsDataMgr:getDungenCfg(levelCid)
end

function DlsReadyView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dls.dlsReadyView")
end

function DlsReadyView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    self.Image_title_line = TFDirector:getChildByPath(Image_content, "Image_title_line")
    self.Label_englishName = TFDirector:getChildByPath(Image_content, "Label_englishName")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Image_plate = TFDirector:getChildByPath(Image_content, "Image_plate")
    self.Label_desc = TFDirector:getChildByPath(self.Image_plate, "Label_desc")
    local Image_target = TFDirector:getChildByPath(Image_content, "Image_target")
    self.Label_targetTitle = TFDirector:getChildByPath(Image_target, "Label_targetTitle")
    self.Label_target = TFDirector:getChildByPath(Image_target, "Label_target")

    self.Panel_reward = TFDirector:getChildByPath(Image_content, "Panel_reward")
    self.Label_reward = TFDirector:getChildByPath(self.Panel_reward, "Label_reward")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_reward, "ScrollView_reward")
    self.GridView_reward = UIGridView:create(ScrollView_reward)
    self.GridView_reward:setColumn(2)
    self.GridView_reward:setColumnMargin(10)
    self.GridView_reward:setRowMargin(10)
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:Scale(0.65)
    self.GridView_reward:setItemModel(Panel_goodsItem)
    self.Button_unlock = TFDirector:getChildByPath(Image_content, "Button_unlock")
    self.Label_unlock = TFDirector:getChildByPath(self.Button_unlock, "Label_unlock")
    self.Button_enter = TFDirector:getChildByPath(Image_content, "Button_enter")
    self.Label_enter = TFDirector:getChildByPath(Image_content, "Label_enter")
    self.Button_cost = TFDirector:getChildByPath(Image_content, "Button_cost"):hide()
    self.Label_costNum = TFDirector:getChildByPath(self.Button_cost, "Label_costNum")
    self.Image_costIcon = TFDirector:getChildByPath(self.Button_cost, "Image_costIcon")
    self.Label_cost = TFDirector:getChildByPath(self.Button_cost, "Label_cost")

    self:refreshView()
end

function DlsReadyView:refreshView()
    self.Label_unlock:setTextById(2101011)
    self.Label_enter:setTextById(2101012)
    self.Label_desc:setTextById(self.levelCfg_.dungenDesc)
    self.Label_targetTitle:setTextById(300826, TextDataMgr:getText(2101009))
    self.Label_reward:setTextById(300826, TextDataMgr:getText(2101010))
    local worldCfg = TabDataMgr:getData("DlsWorld", self.levelCfg_.worldId)
    self.Label_target:setTextById(worldCfg.finalTaskDesc[1])
    self.Image_plate:setTexture(self.levelCfg_.dungenPic)
    self.Label_name:setTextById(worldCfg.worldName)

    local size = self.Label_name:Size()
    local position = self.Label_name:getPosition()
    local x = position.x + size.width + 5
    self.Image_title_line:PosX(x)
    x = x + 5
    self.Label_englishName:PosX(x)

    for i, v in ipairs(self.levelCfg_.rewards) do
        local Panel_goodsItem = self.GridView_reward:pushBackDefaultItem()
        PrefabDataMgr:setInfo(Panel_goodsItem, v)
    end

    local isUnlock = DlsDataMgr:isUnlockLevel(self.levelCid_)
    self.Button_unlock:setVisible(not isUnlock)
    self.Button_enter:setVisible(isUnlock)
    local cost = self.levelCfg_.costItem[1]
    if cost and self.Button_unlock:isVisible() then
        self.Button_cost:show()
        local costItemCfg = GoodsDataMgr:getItemCfg(cost[1])
        self.Image_costIcon:setTexture(costItemCfg.icon)
        self.Label_costNum:setText(cost[2])
        self.Label_cost:setTextById(300020)
    end
end

function DlsReadyView:registerEvents()
    EventMgr:addEventListener(self, EV_DLS_LEVEL_UNLOCK, handler(self.onLevelUnlockEvent, self))

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_unlock:onClick(function()
            if DlsDataMgr:isOpenTime() then
                DlsDataMgr:send_OFFICE_EXPLORE_AREA_MOVE(self.levelCid_)
            else
                Utils:showTips(1890001)
            end
    end)

    self.Button_enter:onClick(function()
            if DlsDataMgr:isOpenTime() then
                DlsDataMgr:send_OFFICE_EXPLORE_AREA_MOVE(self.levelCid_)
            else
                Utils:showTips(1890001)
            end
    end)
end

function DlsReadyView:enterWorld()
    AlertManager:closeLayer(self)
    Utils:openView("dalMap.DalMapMainView", self.levelCfg_.worldId)
end

function DlsReadyView:onLevelUnlockEvent(levelCid)
    self:enterWorld()
end

return DlsReadyView
