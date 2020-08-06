local SkyLadderEndRankView = class("SkyLadderEndRankView", BaseLayer)

function SkyLadderEndRankView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.skyladder.skyladderEndRankView")
end

function SkyLadderEndRankView:initData()

    self.otherDelta = Utils:getKVP(61006, "otherAward")
    self.rankIconRes = {
        "ui/activity/assist/038.png",
        "ui/activity/assist/039.png",
        "ui/activity/assist/040.png",
    }
end

function SkyLadderEndRankView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(self.Panel_root, "Button_ok")
    self.Label_tip = TFDirector:getChildByPath(self.Panel_root, "Label_tip")
    self.Label_tip:setTextById(3203012)
    self.Label_title = TFDirector:getChildByPath(self.Panel_root, "Label_title")
    self.Image_title_bar = TFDirector:getChildByPath(self.Panel_root, "Image_title_bar")
    self.Image_medal = TFDirector:getChildByPath(self.Image_title_bar, "Image_medal")

    local ScrollView_rank = TFDirector:getChildByPath(self.Panel_root, "ScrollView_rank")
    self.ListView_rank = UIListView:create(ScrollView_rank)
    self.Panel_myRank = TFDirector:getChildByPath(self.Panel_root, "Panel_my_rank")


    self.Image_rank_item = TFDirector:getChildByPath(self.Panel_prefab, "Image_rank_item")

    self:updateRankList()
end

function SkyLadderEndRankView:updateRankList()

    self.ListView_rank:removeAllItems()
    local lastRankData = SkyLadderDataMgr:getLastCircleRankList()
    if not lastRankData then
        return
    end

    local lastRankList = lastRankData.rankList or {}
    for k,v in ipairs(lastRankList) do
        local rankItem = self.Image_rank_item:clone()
        self:updateRankItem(rankItem,v)
        self.ListView_rank:pushBackCustomItem(rankItem)
    end

    local myRankInfo = lastRankData.rank
    if myRankInfo then
        self:updateRankItem(self.Panel_myRank,myRankInfo)

        local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg(myRankInfo.segment)
        if not rankMatchCfg then
            return
        end
        local rankId = rankMatchCfg.rankID
        self.Image_title_bar:setTexture(EC_SkyLadderEndBorard[rankId])
        self.Image_medal:setTexture(EC_SkyLadderMedal[rankId])
        self.Label_title:setTextById(rankMatchCfg.rankName)
        self.Label_title:setColor(EC_SkyLadderColor[rankId])
    end
end

function SkyLadderEndRankView:updateRankItem(rankItem,rankData)

    local rankIcon = TFDirector:getChildByPath(rankItem, "Image_rank_icon")
    local rankNum = TFDirector:getChildByPath(rankItem, "Label_rank_num")
    local rankName = TFDirector:getChildByPath(rankItem, "Label_name")
    local rankLv = TFDirector:getChildByPath(rankItem, "Label_lv")
    local laderScore = TFDirector:getChildByPath(rankItem, "Label_ladder_score")
    local Image_total_icon = TFDirector:getChildByPath(laderScore, "Image_icon")
    local battleScore = TFDirector:getChildByPath(rankItem, "Label_fight_socre")
    local Image_icon = TFDirector:getChildByPath(rankItem, "Image_icon")
    local Label_ladder_delta = TFDirector:getChildByPath(rankItem, "Label_ladder_delta")
    local Image_delta_icon = TFDirector:getChildByPath(Label_ladder_delta, "Image_icon")
    if rankData.rank >= 1 and rankData.rank <= 3 then
        rankIcon:setVisible(true)
        rankIcon:setTexture(self.rankIconRes[rankData.rank])
        rankNum:setText("")
    else
        rankIcon:setVisible(false)
        if rankData.rank == 0 then
            rankNum:setTextById(263009)
        else
            rankNum:setText(rankData.rank)
        end
    end

    rankName:setText(rankData.pName)
    rankLv:setText("Lv."..rankData.level)
    laderScore:setText(rankData.laderScore)
    battleScore:setText(rankData.battleScore)

    local width = laderScore:getContentSize().width
    Image_total_icon:setPositionX(-width)

    local headIcon = rankData.headId
    if headIcon == 0 then
        headIcon = 101
    end
    local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
    Image_icon:setTexture(icon)

    local deltaScore = rankData.ladderAddtion
    if deltaScore then
        if deltaScore > 0 then
            Label_ladder_delta:setText("+"..deltaScore)
        else
            Label_ladder_delta:setText(deltaScore)
        end
        Image_delta_icon:setVisible(true)
    else
        Label_ladder_delta:setText("")
        Image_delta_icon:setVisible(false)
    end
    local width = Label_ladder_delta:getContentSize().width
    Image_delta_icon:setPositionX(-width)
end

function SkyLadderEndRankView:onHide()
    self.super.onHide(self)
    Utils:openView("skyLadder.SkyLadderEndView")
end

function SkyLadderEndRankView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_ok:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return SkyLadderEndRankView