local LeagueTrainingStageView = class("LeagueTrainingStageView", BaseLayer)

function LeagueTrainingStageView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.leagueTrainingStageView")
end

function LeagueTrainingStageView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_TRAIN_INFO_UPDATE, handler(self.updateTask, self))
    EventMgr:addEventListener(self, EV_UNION_GET_TRAIN_ACTIVE_REWARD, handler(self.onActiveRewardUpdateEvent, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function LeagueTrainingStageView:initData()
    
end

function LeagueTrainingStageView:initUI(ui)
    self.super.initUI(self, ui)

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_taskItem = TFDirector:getChildByPath(Panel_prefab, "Panel_taskItem")

    self.Label_cur_score = TFDirector:getChildByPath(ui, "Label_cur_score")
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    local ScrollView_task = TFDirector:getChildByPath(ui, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.ListView_task:setItemsMargin(5)

    self:updateTask()
end

function LeagueTrainingStageView:updateTask()
    self.ListView_task:removeAllItems()
    local matrixInfo = LeagueDataMgr:getTrainMatrixInfo()
    local stageData = LeagueDataMgr:getUnionTrainingStageInfo(LeagueDataMgr:getUnionLevel())
    local receiveIndex = clone(matrixInfo.receivePrizeIndex)
    local sortData = {}
    local ing = {}
    local get = {}
    local geted = {}
    for i, v in ipairs(stageData) do
        local idx = table.indexOf(receiveIndex, i - 1)
        local info = {}
        info.idx = i 
        info.data = v 
        if v.stage > matrixInfo.score then
            table.insert(ing, info)
        elseif idx ~= -1 then
            table.insert(geted, info)
        else
            table.insert(get, info)
        end
    end
    table.insertTo(sortData, get)
    table.insertTo(sortData, ing)
    table.insertTo(sortData, geted)

    
    self.Label_cur_score:setTextById(270507,matrixInfo.score)
    for i, info in ipairs(sortData) do
        local taskitem = self.Panel_taskItem:clone():show()
        local Image_icon = TFDirector:getChildByPath(taskitem, "Image_icon")
        local Label_name = TFDirector:getChildByPath(taskitem, "Label_name")
        local btGet = TFDirector:getChildByPath(taskitem, "Button_receive")
        local Button_ing = TFDirector:getChildByPath(taskitem, "Button_ing")
        local Label_ing = TFDirector:getChildByPath(taskitem, "Label_ing")
        local Button_geted = TFDirector:getChildByPath(taskitem, "Button_geted")
        local ScrollView_award = UIListView:create(TFDirector:getChildByPath(taskitem, "ScrollView_award"))

        local data = info.data
        Label_name:setTextById(270508, data.stage)
        local idx = table.indexOf(receiveIndex, info.idx - 1)
        if data.stage > matrixInfo.score then
            btGet:hide()
            Button_ing:show()
            Button_ing:setTouchEnabled(false)
            Button_ing:setGrayEnabled(true)
            Label_ing:enableOutline(ccc4(255,192,203,255),1)
        elseif idx ~= -1 then
            btGet:hide()
            Button_geted:show()
            Button_geted:setTouchEnabled(false)
            Button_geted:setGrayEnabled(true)
        else
            btGet:show()
            Button_geted:hide()
            Button_ing:hide()
            btGet:onClick(function(sender)
                LeagueDataMgr:ReqUnionTrainActivePrize(info.idx - 1)
            end)
        end
        local quality = EC_ItemQuality.WHITE
        for i,v in ipairs(data.reward) do
            local itemPrefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
            local item = itemPrefab:clone()
            local cfg = GoodsDataMgr:getItemCfg(v.id)
            quality = math.max(quality, cfg.quality)
            item:setScale(0.7)
            PrefabDataMgr:setInfo(item, v.id, v.num)
            ScrollView_award:pushBackCustomItem(item)
        end
        if quality >= EC_ItemQuality.PURPLE then
            Image_icon:setTexture("ui/league/ui_48.png")
        elseif quality >= EC_ItemQuality.BLUE then
            Image_icon:setTexture("ui/league/ui_47.png")
        elseif quality >= EC_ItemQuality.ORANGE then
            Image_icon:setTexture("ui/league/ui_60.png")
        else
            Image_icon:setTexture("ui/league/ui_46.png")
        end
        self.ListView_task:pushBackCustomItem(taskitem)
    end
end

function LeagueTrainingStageView:onActiveRewardUpdateEvent(data)
    if data.rewards then
        Utils:showReward(data.rewards)
    end
    self:updateTask()
end

return LeagueTrainingStageView