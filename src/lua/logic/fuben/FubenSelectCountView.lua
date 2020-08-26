
local FubenSelectCountView = class("FubenSelectCountView", BaseLayer)

function FubenSelectCountView:initData(levelCid)
    self.levelCid_ = levelCid
    self.levelCfg_ = FubenDataMgr:getLevelCfg(levelCid)
end

function FubenSelectCountView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fuben.fubenSelectCountView")
end

function FubenSelectCountView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_countItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_countItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Label_title_en = TFDirector:getChildByPath(Image_content, "Label_title_en")
    local ScrollView_content = TFDirector:getChildByPath(Image_content, "ScrollView_content")
    self.ListView_content = UIListView:create(ScrollView_content)
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")

    self:refreshView()
end

function FubenSelectCountView:refreshView()
    self.Label_title:setTextById(350006)

    local costCid = self.levelCfg_.cost[1][1]
    local costNum = self.levelCfg_.cost[1][2]
    local costCfg = GoodsDataMgr:getItemCfg(costCid)
    local starNum = FubenDataMgr:getStarNum(self.levelCid_)

    local data = clone(self.levelCfg_.quickBattleParameter)
    local cardPrivilegeFreeNum = FubenDataMgr:getFreePrivilegeNumById(self.levelCid_)
    for i = 1, cardPrivilegeFreeNum do
        local useTmp = clone(data[#data]) -- 用最后一个数据结构作为叠加
        useTmp[1] = useTmp[1] + 1
        table.insert(data, useTmp)
    end

    for i, v in ipairs(data) do
        local Panel_countItem = self.Panel_countItem:clone()
        self.ListView_content:pushBackCustomItem(Panel_countItem)

        local Button_unlock = TFDirector:getChildByPath(Panel_countItem, "Button_unlock")
        local Image_lock = TFDirector:getChildByPath(Panel_countItem, "Image_lock")
        local Image_icon = TFDirector:getChildByPath(Panel_countItem, "Image_icon")
        local Label_cost = TFDirector:getChildByPath(Panel_countItem, "Label_cost")
        local Image_star = {}
        for j = 1, 3 do
            Image_star[j] = TFDirector:getChildByPath(Panel_countItem, "Image_star_" .. j)
        end
        local Label_unlock = TFDirector:getChildByPath(Panel_countItem, "Label_unlock")
        local Label_count = TFDirector:getChildByPath(Panel_countItem, "Label_count")
        local Label_desc = TFDirector:getChildByPath(Panel_countItem, "Label_desc")

        Image_icon:Scale(0.5):setTexture(costCfg.icon)
        Label_cost:setTextById()
        Label_unlock:setTextById(350005)
        Label_cost:setTextById(350003, costNum * v[1])
        local isUnlock = v[2] <= starNum
        Button_unlock:setTouchEnabled(isUnlock)
        Button_unlock:setVisible(isUnlock)
        Image_lock:setVisible(not isUnlock)
        Label_unlock:setVisible(not isUnlock)
        for j, item in ipairs(Image_star) do
            item:setVisible(j <= v[2])
        end
        Label_count:setTextById("r81001", v[1])
        Label_desc:setTextById("r81002", v[1])

        Button_unlock:onClick(function()
                EventMgr:dispatchEvent(EV_FUBEN_UPDATE_CHALLENGE_COUNT, v[1])
                AlertManager:close()
        end)
    end
end

function FubenSelectCountView:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:close()
    end)
end

return FubenSelectCountView
