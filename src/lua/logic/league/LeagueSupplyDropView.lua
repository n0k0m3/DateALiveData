
local LeagueSupplyDropView = class("LeagueSupplyDropView", BaseLayer)
require("lua.logic.common.ChooseMessageBox")

function LeagueSupplyDropView:initData()
    
end

function LeagueSupplyDropView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.league.leagueSupplyDropView")
end

function LeagueSupplyDropView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")
    self.Panel_log_Item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_log_Item")

    self.Panel_supply = TFDirector:getChildByPath(self.Panel_root, "Panel_supply")

    self.Label_supply_title = TFDirector:getChildByPath(self.Panel_supply, "Label_supply_title")
    self.Label_supl_num = TFDirector:getChildByPath(self.Panel_supply, "Label_supl_num")
    self.Image_suppy_icon = TFDirector:getChildByPath(self.Panel_supply, "Image_suppy_icon")
    self.Image_res_icon = TFDirector:getChildByPath(self.Panel_supply, "Image_res_icon")
    self.Label_res_num = TFDirector:getChildByPath(self.Panel_supply, "Label_res_num")
    self.Label_free = TFDirector:getChildByPath(self.Panel_supply, "Label_free")
    self.Label_free:setTextById(2100087)

    self.Button_supply = TFDirector:getChildByPath(self.Panel_supply, "Button_supply")
    self.Label_no_logs = TFDirector:getChildByPath(self.Panel_supply, "Label_no_logs")
    self.Label_no_logs:setVisible(false)
    local Image_logBar = TFDirector:getChildByPath(self.Panel_supply, "Image_logBar")
    local Image_logScrollBar = TFDirector:getChildByPath(Image_logBar, "Image_logScrollBar")
    local scrollBar = UIScrollBar:create(Image_logBar, Image_logScrollBar)
    local ScrollView_log = TFDirector:getChildByPath(self.Panel_supply, "ScrollView_log")
    self.ScrollView_log = UIListView:create(ScrollView_log)
    self.ScrollView_log:setScrollBar(scrollBar)
    self.ScrollView_log:setItemsMargin(5)

    self.Label_supply_title:setTextById(270363)
    self:refreshView()
    LeagueDataMgr:ReqSupplyRecord()
end

function LeagueSupplyDropView:refreshView()
    local getTimes = LeagueDataMgr:getSupplyReceiveTimes()
    local supplyCfg = LeagueDataMgr:getCurSupplyCfg()
    local maxTimes = LeagueDataMgr:getSupplyMaxTimes()
    self.Label_supl_num:setText(tostring(maxTimes - getTimes).."/"..maxTimes)
    local extractexpend = supplyCfg.extractexpend
    if table.count(extractexpend) < 1 then
        self.Image_res_icon:setVisible(false)
        self.Label_res_num:setVisible(false)
        self.Label_free:setVisible(true)
    else
        self.Image_res_icon:setVisible(true)
        self.Label_res_num:setVisible(true)
        self.Label_free:setVisible(false)
        for k, v in pairs(extractexpend) do
            local itemCfg = GoodsDataMgr:getItemCfg(tonumber(k))
            self.Label_res_num:setText(v)
            if GoodsDataMgr:getItemCount(tonumber(k)) < v then
                self.Label_res_num:setColor(ccc3(219,50,50))
            else
                self.Label_res_num:setFontColor(ccc3(255,255,255))
            end

            self.Image_res_icon:setTexture(itemCfg.icon)
            break
        end
    end
end

function LeagueSupplyDropView:getSupplySuccess()
    self:refreshView()
    LeagueDataMgr:ReqSupplyRecord()
end

function LeagueSupplyDropView:refreshLog(data)
    if data.record and #data.record > 0 then
        self.Label_no_logs:setVisible(false)
    else
        self.Label_no_logs:setVisible(true)
    end
    if not data.record then
        self.ScrollView_log:removeAllItems()
        return
    end
    if #data.record > 40 then
        for i = #data.record, 40,-1 do
            table.remove(data.record,i)
        end
    end
    self.ScrollView_log:AsyncUpdateItem(data.record,function (  )
        return self.Panel_log_Item:clone()
    end,
    function (item,info)
        self:updateLogItem(item, info)
    end)
end

function LeagueSupplyDropView:updateLogItem(item, data)
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Label_player_name = TFDirector:getChildByPath(item, "Label_player_name")
    local ScrollView_reward = TFDirector:getChildByPath(item, "ScrollView_reward")
    local ScrollView_list = UIListView:create(ScrollView_reward)
    ScrollView_list:setItemsMargin(2)
    Label_player_name:setText(data.playerName)
    local quality = EC_ItemQuality.WHITE
    for k, v in pairs(data.rewards) do
        local cfg = GoodsDataMgr:getItemCfg(v.id)
        quality = math.max(quality, cfg.quality)
    end
    local rewardCount = #data.rewards
    if quality >= EC_ItemQuality.PURPLE then
        Image_icon:setTexture("ui/league/ui_48.png")
    elseif quality >= EC_ItemQuality.BLUE then
        Image_icon:setTexture("ui/league/ui_47.png")
    else
        Image_icon:setTexture("ui/league/ui_46.png")
    end
    for i,v in ipairs(data.rewards) do
        local prefebItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(prefebItem, v.id, v.num)
        prefebItem:setScale(0.7)
        ScrollView_list:pushBackCustomItem(prefebItem)
    end
end

function LeagueSupplyDropView:onUnionInfoReset()
    self:refreshView()
    LeagueDataMgr:ReqSupplyRecord()
end

function LeagueSupplyDropView:onQuitUnionBack()
    AlertManager:closeAll()
    AlertManager:changeScene(SceneType.MainScene)
end

function LeagueSupplyDropView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_QUIT_UNION, handler(self.onQuitUnionBack, self))
    EventMgr:addEventListener(self, EV_UNION_GET_SUPPLY_SUCCESS, handler(self.getSupplySuccess, self))
    EventMgr:addEventListener(self, EV_UNION_GET_SUPPLY_RECORD, handler(self.refreshLog, self))
    EventMgr:addEventListener(self, EV_UNION_INFO_RESET, handler(self.onUnionInfoReset, self))

    self.Button_supply:onClick(function()
        local receiveTimes = LeagueDataMgr:getSupplyReceiveTimes()
        local maxTimes = LeagueDataMgr:getSupplyMaxTimes()
        if receiveTimes >= maxTimes then
            Utils:showTips(270415)
            return
        end
        local supplyCfg = LeagueDataMgr:getCurSupplyCfg()
        local extractexpend = supplyCfg.extractexpend
        local cost = 0
        for k, v in pairs(extractexpend) do
            local itemCfg = GoodsDataMgr:getItemCfg(tonumber(k))
            if tonumber(k) == EC_SItemType.DIAMOND then
                cost = v
            end
            if GoodsDataMgr:getItemCount(tonumber(k)) < v then
                if tonumber(k) == EC_SItemType.GOLD then
                    Utils:showTips(493004)
                elseif tonumber(k) == EC_SItemType.DIAMOND then
                    Utils:showTips(800048)
                end
                return
            end
        end
        local supplyCfg = LeagueDataMgr:getCurSupplyCfg()
        local extractexpend = supplyCfg.extractexpend
        if cost > 0 then
            showChooseMessageBox(TextDataMgr:getText(800011), TextDataMgr:getText(276015, cost), function()
                AlertManager:close()
                LeagueDataMgr:UnionReceiveSupply(LeagueDataMgr:getCurSupplyCfg().id)
            end)
        else
            LeagueDataMgr:UnionReceiveSupply(LeagueDataMgr:getCurSupplyCfg().id)
        end
        
    end)
end

return LeagueSupplyDropView
