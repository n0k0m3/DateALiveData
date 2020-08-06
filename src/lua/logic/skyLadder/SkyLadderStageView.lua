local SkyLadderStageView = class("SkyLadderStageView", BaseLayer)
local Enum_type = {
    stageView = 1,            --段位预览
    CurHundred = 2,           --本期百强
    LastHundred = 3,          --上期百强
}
function SkyLadderStageView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.skyladder.skyladderStage")
end

function SkyLadderStageView:initData()

    self.stageInfo = {}
    local rankSortMathCfg = {}
    local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg()
    for k,v in pairs(rankMatchCfg) do
        table.insert(rankSortMathCfg,v)
    end
    table.sort(rankSortMathCfg,function(a,b)
        return a.id < b.id
    end)

    for k,v in pairs(rankSortMathCfg) do
        local rankID = v.rankID
        if not self.stageInfo[rankID] then
            self.stageInfo[rankID] = {}
        end
        table.insert(self.stageInfo[rankID],v)
    end

    self.rankIconRes = {
        "ui/activity/assist/038.png",
        "ui/activity/assist/039.png",
        "ui/activity/assist/040.png",
    }

    self.curHundredList = SkyLadderDataMgr:getCurHundredList()
    self.selfInHundred = SkyLadderDataMgr:getSelfInHundred()

    self.lastHundredList = SkyLadderDataMgr:getLastHundredList()
    self.selfInLastHundred = SkyLadderDataMgr:getSelfInLastHundred()
end

function SkyLadderStageView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Image_innerbg = TFDirector:getChildByPath(self.Panel_root, "Image_innerbg")
    self.Label_title = TFDirector:getChildByPath(self.Panel_root, "Label_title")
    self.Label_title:setTextById(3202056)

    self.Panel_rank = TFDirector:getChildByPath(self.Panel_root, "Panel_rank")

    self.Label_tiptx = TFDirector:getChildByPath(self.Panel_root, "Label_tiptx")

    self.Image_my_rank_bg = TFDirector:getChildByPath(self.Panel_root, "Image_my_rank_bg")
    local ScrollView_rank = TFDirector:getChildByPath(self.Panel_root, "ScrollView_rank")
    self.ListView_rank = UIListView:create(ScrollView_rank)

    self.Panel_stageItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_stageItem")
    self.Image_rank_item = TFDirector:getChildByPath(self.Panel_prefab, "Image_rank_item")

    self.typeBtn = {}
    for i=1,3 do
        local tab = {}
        tab.btn = TFDirector:getChildByPath(self.Panel_root, "Button_type_"..i)
        tab.select = TFDirector:getChildByPath(tab.btn, "Image_select")
        table.insert(self.typeBtn,tab)
    end

    self.descIds = {3203001,3202069,3202070}

    self:chooseType(Enum_type.stageView)
end

function SkyLadderStageView:chooseType(type_)

    self.choosedType = type_
    for k,v in ipairs(self.typeBtn) do
        v.select:setVisible(k == type_)
    end

    self.Image_innerbg:setVisible(type_ == Enum_type.stageView)
    self.Panel_rank:setVisible(type_ ~= Enum_type.stageView)

    self.Panel_rank:stopAllActions()

    if type_ == Enum_type.stageView then
        self:updateStage()
    else
        self:updateRankInfo()
    end

    self.Label_tiptx:setTextById(self.descIds[type_])

end

function SkyLadderStageView:updateStage()

    local curSubRankId = SkyLadderDataMgr:getCurSubRankId()

    for rankID = EC_SkyLadderType.BRONZE,EC_SkyLadderType.HONOUR do
        if self.stageInfo[rankID] then

            local stageItem = self.Image_innerbg:getChildByName("stageItem"..rankID)
            if not stageItem then
                stageItem = self.Panel_stageItem:clone()
                local posX = (rankID-1)*166 - 415
                stageItem:setPosition(ccp(posX,0))
                stageItem:setName("stageItem"..rankID)
                self.Image_innerbg:addChild(stageItem)
            end

            local rankName = SkyLadderDataMgr:getRankName(rankID)
            local Label_stage_name = TFDirector:getChildByPath(stageItem, "Label_stage_name")
            Label_stage_name:setTextById(rankName.cn)

            local firstStage = self.stageInfo[rankID][1]
            local Label_num_show = TFDirector:getChildByPath(stageItem, "Label_num_show")
            if firstStage then
                Label_num_show:setText(firstStage.subRankPoint)
            end

            local Image_medal = TFDirector:getChildByPath(stageItem, "Image_medal")
            Image_medal:setTexture(EC_SkyLadderMedal[rankID])
            Image_medal:setScale(0.6)

            local iscurRank = false
            for i=1,3 do
                local stage = self.stageInfo[rankID][i]
                if stage then
                    if stage.id == curSubRankId then
                        iscurRank = true
                        break
                    end
                end
            end

            local Image_normal = TFDirector:getChildByPath(stageItem, "Image_normal")
            Image_normal:setVisible(true)
            local Image_select = TFDirector:getChildByPath(stageItem, "Image_select")
            Image_select:setVisible(false)
            for i=1,3 do
                local Label_stage = TFDirector:getChildByPath(stageItem, "Label_stage_"..i)
                local Label_num = TFDirector:getChildByPath(stageItem, "Label_num_"..i)
                local chooseImg = TFDirector:getChildByPath(stageItem, "Image_selcet_"..i):hide()
                local stage = self.stageInfo[rankID][i]
                if stage then
                    local color = ccc3(167,169,188)
                    if stage.id == curSubRankId then
                        Image_normal:setVisible(false)
                        Image_select:setVisible(true)
                        chooseImg:setVisible(true)
                        color = ccc3(255,255,255)
                    end
                    Label_stage:setColor(color)
                    Label_stage:setVisible(iscurRank)
                    Label_num:setVisible(iscurRank)
                    Label_num:setText(stage.subRankPoint)
                    Label_num:setColor(color)
                    Label_stage:setTextById(stage.rankName)
                else
                    Label_stage:setVisible(false)
                    Label_num:setVisible(false)
                end
            end
        end
    end
end

function SkyLadderStageView:updateRankInfo()

    local myRankInfo = self.choosedType == Enum_type.CurHundred and self.selfInHundred or self.selfInLastHundred
    self:updateRankItem(self.Image_my_rank_bg,myRankInfo)

    self.loadIndex = 1

    local rankInfo = self.choosedType == Enum_type.CurHundred and self.curHundredList or self.lastHundredList
    rankInfo = rankInfo or {}
    self.ListView_rank:removeAllItems()
    local function loadRankItem()
        if self.loadIndex > #rankInfo then
            return
        end
        local item = self.ListView_rank:getItem(self.loadIndex)
        if not item then
            item = self.Image_rank_item:clone()
            item:setOpacity(0)
            self.ListView_rank:pushBackCustomItem(item)
        end
        self:updateRankItem(item,rankInfo[self.loadIndex])
        local seq = Sequence:create({
            DelayTime:create(0.02),
            CallFunc:create(function()
                self.loadIndex = self.loadIndex + 1
                loadRankItem()
            end)
        })
        self.Panel_rank:stopAllActions()
        self.Panel_rank:runAction(seq)
    end
    loadRankItem()
end

function SkyLadderStageView:updateRankItem(rankItem,rankData)

    rankItem:runAction(CCFadeIn:create(0.5))

    if not rankData then
        return
    end

    local rankIcon = TFDirector:getChildByPath(rankItem, "Image_rank_icon")
    local rankNum = TFDirector:getChildByPath(rankItem, "Label_rank_num")
    local rankName = TFDirector:getChildByPath(rankItem, "Label_name")
    local rankLv = TFDirector:getChildByPath(rankItem, "Label_lv")
    local laderScore = TFDirector:getChildByPath(rankItem, "Label_ladder_score")
    local Image_ladder = TFDirector:getChildByPath(rankItem, "Image_ladder")
    local Label_stage = TFDirector:getChildByPath(rankItem, "Label_stage")
    local Image_stage = TFDirector:getChildByPath(rankItem, "Image_stage")
    local Image_icon = TFDirector:getChildByPath(rankItem, "Image_icon")
    local Panel_join = TFDirector:getChildByPath(rankItem, "Panel_join")
    local Label_notjoin = TFDirector:getChildByPath(rankItem, "Label_notjoin")
    Label_notjoin:setTextById(3202071)
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

    Panel_join:setVisible(rankData.segment ~= 0)
    Label_notjoin:setVisible(rankData.segment == 0)

    local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg(rankData.segment)
    if rankMatchCfg then
        local lastRankId = rankMatchCfg.rankID
        Image_stage:setTexture(EC_SkyLadderMedal[lastRankId])
        Label_stage:setTextById(rankMatchCfg.rankName)
    end

    laderScore:setText(rankData.laderScore)

    local w = laderScore:getContentSize().width/2
    local posX = laderScore:getPositionX()
    Image_ladder:setPositionX(posX-w)

    local headIcon = rankData.headId
    if headIcon == 0 then
        headIcon = 101
    end
    local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
    Image_icon:setTexture(icon)

    if rankData.pid ~= MainPlayer:getPlayerId() then
        Image_icon:onClick(function()
            MainPlayer:sendPlayerId(rankData.pid)
        end)
    end
end

function SkyLadderStageView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for k,v in ipairs(self.typeBtn) do
        v.btn:onClick(function()
            if self.choosedType == k then
                return
            end
            self:chooseType(k)
        end)
    end
end

return SkyLadderStageView