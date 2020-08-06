local FubenEndlessTotalRank = class("FubenEndlessTotalRank", BaseLayer)
local Enum_type = {
    CurHundred = 1,           --本期百强
    LastHundred = 2,          --上期百强
}
function FubenEndlessTotalRank:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.fuben.fubenEndlessTotalRank")
end

function FubenEndlessTotalRank:initData()

    self.rankIconRes = {
        "ui/activity/assist/038.png",
        "ui/activity/assist/039.png",
        "ui/activity/assist/040.png",
    }

    self.curHundredList,self.selfInHundred = FubenDataMgr:getCurEndlessRankInfo()
    self.lastHundredList,self.selfInLastHundred = FubenDataMgr:getLastEndlessRankInfo()

end

function FubenEndlessTotalRank:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.Label_name3 = TFDirector:getChildByPath(self.Panel_root, "Label_name3")
    self.Label_name3:setTextById(100000150)
    self.Panel_rank = TFDirector:getChildByPath(self.Panel_root, "Panel_rank")

    self.Label_tiptx = TFDirector:getChildByPath(self.Panel_root, "Label_tiptx")

    self.Image_my_rank_bg = TFDirector:getChildByPath(self.Panel_root, "Image_my_rank_bg")
    local ScrollView_rank = TFDirector:getChildByPath(self.Panel_root, "ScrollView_rank")
    self.ListView_rank = UIListView:create(ScrollView_rank)

    self.Image_rank_item = TFDirector:getChildByPath(self.Panel_prefab, "Image_rank_item")

    self.typeBtn = {}
    for i=1,2 do
        local tab = {}
        tab.btn = TFDirector:getChildByPath(self.Panel_root, "Button_type_"..i)
        tab.select = TFDirector:getChildByPath(tab.btn, "Image_select")
        table.insert(self.typeBtn,tab)
    end

    self.descIds = {3202068,3202067}

    self:chooseType(Enum_type.CurHundred)
end

function FubenEndlessTotalRank:chooseType(type_)

    self.choosedType = type_
    for k,v in ipairs(self.typeBtn) do
        v.select:setVisible(k == type_)
    end
    self.Panel_rank:stopAllActions()
    self:updateRankInfo()
    self.Label_tiptx:setTextById(self.descIds[type_])

end

function FubenEndlessTotalRank:updateRankInfo()

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

function FubenEndlessTotalRank:updateRankItem(rankItem,rankData)

    rankItem:runAction(CCFadeIn:create(0.5))

    if not rankData then
        return
    end

    local rankIcon = TFDirector:getChildByPath(rankItem, "Image_rank_icon")
    local rankNum = TFDirector:getChildByPath(rankItem, "Label_rank_num")
    local rankName = TFDirector:getChildByPath(rankItem, "Label_name")
    local rankLv = TFDirector:getChildByPath(rankItem, "Label_lv")
    local Label_pass_time = TFDirector:getChildByPath(rankItem, "Label_pass_time")
    local Label_pass_floor = TFDirector:getChildByPath(rankItem, "Label_pass_floor")
    local Image_icon = TFDirector:getChildByPath(rankItem, "Image_icon")
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

    Label_pass_floor:setTextById(2100016 ,rankData.stage)

    local timestamp = math.floor(rankData.costTime / 1000)
    local _, hour, min, sec = Utils:getDHMS(timestamp, true)
    Label_pass_time:setTextById(800026, hour, min, sec)

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

function FubenEndlessTotalRank:onQueryInfoEvent(playerInfo)
    local view = AlertManager:getLayer(-1)
    if view.__cname == self.__cname then
        Utils:openView("chat.PlayerInfoView", playerInfo)
    end
end

function FubenEndlessTotalRank:registerEvents()

    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryInfoEvent, self))

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

return FubenEndlessTotalRank