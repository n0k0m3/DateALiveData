local WhiteQueenScoreRankView = class("WhiteQueenScoreRankView", BaseLayer)
local Enum_type = {
    tab_1 = 1,           
    tab_2 = 2,          
    tab_3 = 3,
}
function WhiteQueenScoreRankView:ctor(activityId)
    self.super.ctor(self)
    self:initData(activityId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.whiteQueenScoreRankView")
end

function WhiteQueenScoreRankView:initData(activityId)

    self.rankIconRes = {
        "ui/activity/assist/038.png",
        "ui/activity/assist/039.png",
        "ui/activity/assist/040.png",
    }

    self.rankBgRes = {
        "ui/activity/whiteQueenAssist/activityRank/002.png",
        "ui/activity/whiteQueenAssist/activityRank/003.png",
    }


    self.activityId_ = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.ONLINE_SCORE_REWARD)[1]
    self:updateActivityData()
end

function WhiteQueenScoreRankView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")


    self.Panel_rank = TFDirector:getChildByPath(self.Panel_root, "Panel_rank")


    local ScrollView_rank = TFDirector:getChildByPath(self.Panel_root, "ScrollView_rank")
    self.ListView_rank = UIListView:create(ScrollView_rank)

    self.Image_rank_item = TFDirector:getChildByPath(self.Panel_prefab, "Image_rank_item")
    self.Panel_rewardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rewardItem")

    self.typeBtn = {}
    self.panel_info = {}

    for i=1,3 do
        local tab = {}
        tab.btn = TFDirector:getChildByPath(self.Panel_root, "Button_type_"..i)
        tab.select = TFDirector:getChildByPath(tab.btn, "Image_select")
        table.insert(self.typeBtn,tab)
        self.panel_info[i] = TFDirector:getChildByPath(self.Panel_root , "Panel_info_"..i)


    end


    self.smallTabBtn = {}

    for i=1,2 do
        self.smallTabBtn[i] = TFDirector:getChildByPath(self.panel_info[3] ,  "Button_tab_"..i)
        self.smallTabBtn[i].select = self.smallTabBtn[i]:getChildByName("Image_select")
    end


    self:chooseType(Enum_type.tab_1)
    self:smallChooseType(1)

    ActivityDataMgr2:request_ACTIVITY_REQ_ALL_ACTIVITY_ITEM(self.activityInfo_.id)
    
end


function WhiteQueenScoreRankView:updateActivityData()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
end

function WhiteQueenScoreRankView:chooseType(type_)
    self.choosedType = type_
    for k,v in ipairs(self.typeBtn) do
        v.select:setVisible(k == type_)
        self.panel_info[k]:setVisible(k == type_)
    end
    if type_ == Enum_type.tab_1 then
        ActivityDataMgr2:send_ACTIVITY_REQ_ACTIVITY_RANK(self.activityInfo_.id)
    elseif type_ == Enum_type.tab_2 then
        ActivityDataMgr2:request_ACTIVITY_REQ_UNION_RANK_ACT_SCORE(self.activityInfo_.id)
    else
        self:smallChooseType(1)
    end

end

function WhiteQueenScoreRankView:updateSelfPanel(data)

        local Image_self_rank = self.panel_info[1]:getChildByName("Image_self_rank")
        local Image_rank_icon = Image_self_rank:getChildByName("Image_rank_icon")
        local Label_rank_num = Image_self_rank:getChildByName("Label_rank_num")
        if data.myRank < 1 then
            Image_rank_icon:setVisible(false)
            Label_rank_num:setVisible(true)
            Label_rank_num:setTextById(263009)
        elseif data.myRank <= 3 then
            Image_rank_icon:setVisible(true)
            Label_rank_num:setVisible(false)
            Image_rank_icon:setTexture(self.rankIconRes[data.myRank])
        else
            Label_rank_num:setText(data.myRank)
            Image_rank_icon:setVisible(false)
            Label_rank_num:setVisible(true)
        end

        local Image_icon_frame = Image_self_rank:getChildByName("Image_icon_frame")
        local Image_icon = Image_self_rank:getChildByName("Image_icon")
        local Label_name = Image_self_rank:getChildByName("Label_name")
        local Label_lv = Image_self_rank:getChildByName("Label_lv")
        local Label_score = Image_self_rank:getChildByName("Label_score")

        Image_icon:setTexture(AvatarDataMgr:getSelfAvatarIconPath())
        local frame_icon,effect = AvatarDataMgr:getSelfAvatarFrameIconPath()
        Image_icon_frame:setTexture(frame_icon)
        Label_name:setText(MainPlayer:getPlayerName())
        Label_name:setFontSize(18)
        Label_lv:setText("LV."..MainPlayer:getPlayerLv())
        Label_score:setText(tostring(math.max(0,data.myScore)))
end


function WhiteQueenScoreRankView:updateRankInfo()
    self.Panel_rank:setPositionY(-263)

    self.rankData = self.rankData or {}
    local rankItemLen = #self.rankData
    
    local rankItem = self.Image_rank_item
    if self.choosedType == Enum_type.tab_1 then
        self.ListView_rank:setContentSize(CCSize(910 , 360))
    elseif self.choosedType == Enum_type.tab_2 then
        self.ListView_rank:setContentSize(CCSize(910 , 445))

    else
        self.Panel_rank:setPositionY(-294)
        self.ListView_rank:setContentSize(CCSize(910 , 409))
         
        rankItem = self.Panel_rewardItem

        self.smallChooseTypeIdx = self.smallChooseTypeIdx or 1

    end


    self.ListView_rank:removeAllItems()
    local items = self.ListView_rank:getItems()
     local gap = #items - rankItemLen

        for i = 1, math.abs(gap) do
            if gap > 0 then
                local item = self.ListView_rank:getItem(1)
                self.ListView_rank:removeItem(1)
            else
              local item = rankItem:clone()
              self.ListView_rank:pushBackCustomItem(item)
              if self.choosedType ~= Enum_type.tab_3 then  --如果是普通排行

                    item.Image_bg = item:getChildByName("Image_rank_item")
                    item.image_rank = item:getChildByName("Image_rank_icon")
                    item.label_rank = item:getChildByName("Label_rank_num")
                    item.label_name = item:getChildByName("Label_name")
                    item.image_head = item:getChildByName("Image_icon")
                    item.label_level = item:getChildByName("Label_lv")
                    item.label_score = item:getChildByName("Label_score")
                    item.image_icon_frame = item:getChildByName("Image_icon_frame")
                    item.label_name:setFontSize(18)
              else
                    item.label_rank_num = item:getChildByName("Label_level_normal")
                    item.image_reward = {}
                    for i=1,4 do
                        item.image_reward[i] = item:getChildByName("Image_reward_"..i)
                        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                          Panel_goodsItem:setTouchEnabled(true)
                          Panel_goodsItem:Pos(0, 0)
                          Panel_goodsItem:AddTo(item.image_reward[i]:getChildByName("Image_icon"))
                          item.image_reward[i].Panel_goodsItem = Panel_goodsItem
                    end
              end
            end
        end
        for i, v in ipairs(self.ListView_rank:getItems()) do
            self:updateRankItem(v , self.rankData[i] , i)
        end

    
end

function WhiteQueenScoreRankView:smallChooseType(type_)
    self.smallChooseTypeIdx = type_
    for k,v in ipairs(self.smallTabBtn) do
        v.select:setVisible(k == type_)
    end
    if type_ == 1 then
        self.rankData = ActivityDataMgr2:getActivityItemsInfoBySubType(self.activityInfo_.id, 27001) or {}
    else
        self.rankData = ActivityDataMgr2:getActivityItemsInfoBySubType(self.activityInfo_.id, 27005) or {}
    end
    self:updateRankInfo()
end

function WhiteQueenScoreRankView:updateRankItem(rankItem,rankData ,index)


    if self.choosedType ~= Enum_type.tab_3 then

         rankItem.Image_bg:setTexture(self.rankBgRes[index%2 + 1])

        rankItem.image_head:setTouchEnabled(false)

        if index <= 3 then
            rankItem.image_rank:setVisible(true)
            rankItem.image_rank:setTexture(self.rankIconRes[index])
            rankItem.label_rank:setText("")
        else
            rankItem.label_rank:setText(index)
            rankItem.image_rank:setVisible(false)
        end

        if self.choosedType == Enum_type.tab_1 then  --个人排行
            rankItem.label_score:setText(rankData.score)
            rankItem.label_name:setText(rankData.playerName)
            local headIcon = rankData.headIcon
            if headIcon == 0 then
                headIcon = 101
            end
            local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
            rankItem.image_head:setTexture(icon)

            rankItem.image_head:setTouchEnabled(true)
            rankItem.image_head:onClick(function()
                    if rankData.playerId ~= MainPlayer:getPlayerId() then
                        MainPlayer:sendPlayerId(rankData.playerId)
                    end
            end)

            rankItem.label_level:setTextById(700034 , rankData.level)

            local avatarFrameIcon,avatarFrameEffect = nil, nil
            if rankData.frameCid == 0 or rankData.frameCid == nil then  --设置默认头像框
                avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(10000)
            else
                avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(rankData.frameCid)
            end
            if avatarFrameIcon and avatarFrameIcon ~= "" then
                rankItem.image_icon_frame:setTexture(avatarFrameIcon)
            end
            rankItem.image_icon_frame:setVisible(true)

            if avatarFrameEffect and avatarFrameEffect ~= "" then
                if rankItem.HeadFrameEffect then
                    rankItem.HeadFrameEffect:removeFromParent()
                    rankItem.HeadFrameEffect = nil
                end
                if not rankItem.HeadFrameEffect then
                    rankItem.HeadFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
                    rankItem.HeadFrameEffect:setAnchorPoint(ccp(0,0))
                    rankItem.HeadFrameEffect:setPosition(ccp(0,0))
                    rankItem.HeadFrameEffect:play("animation", true)
                    rankItem.image_icon_frame:addChild(rankItem.HeadFrameEffect, 1)
                end
            else
                if rankItem.HeadFrameEffect then
                    rankItem.HeadFrameEffect:removeFromParent()
                    rankItem.HeadFrameEffect = nil
                end
            end

            rankItem.image_head:setScale(0.7)
        else   --如果是社团排行
            rankItem.image_head:setTouchEnabled(false)
            rankItem.image_icon_frame:setVisible(false)
            local emblemCfg = LeagueDataMgr:getEmblemCfgById(rankData.unionIcon or 101)
            rankItem.image_head:setTexture(emblemCfg.icon)
            rankItem.image_head:setScale(0.5)


            rankItem.label_score:setText(rankData.score)
            rankItem.label_name:setText(rankData.unionName)

            rankItem.label_level:setTextById(700034 , rankData.unionLvl)
        end
    else  --查看奖励

        rankItem:getChildByName("Image_bg"):setTexture(self.rankBgRes[index%2 + 1])
        local reward = rankData.reward
        local idx = 1
        for k ,v in pairs(reward) do
            PrefabDataMgr:setInfo(rankItem.image_reward[idx].Panel_goodsItem, k, v)
            idx = idx + 1
        end
        for i= 1,4 do
            if i >= idx then
                rankItem.image_reward[i]:hide()
            else
                rankItem.image_reward[i]:show()
            end

        end
        rankItem.label_rank_num:setText(Utils:MultiLanguageStringDeal(rankData.extendData.des2))
    end
    
end

function WhiteQueenScoreRankView:onUpdateRankInfo(data)
    if data.activityId ~= self.activityInfo_.id then return end
    self.rankData = data.ranks

    
    self:updateRankInfo()
end
function WhiteQueenScoreRankView:onUpdateSingleRankInfo( data )
    if data.activityId ~= self.activityInfo_.id then return end
    self.rankData = data.ranks

    self:updateSelfPanel(data)

    self:updateRankInfo()
end


function WhiteQueenScoreRankView:registerEvents()

    EventMgr:addEventListener(self, EV_ACTIVITY_RES_UNION_RANK_ACT_SCORE, handler(self.onUpdateRankInfo, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_MORE_RANK, handler(self.onUpdateSingleRankInfo, self))

    EventMgr:addEventListener(self,EV_RECV_PLAYERINFO, handler(self.onShowPlayerInfoView, self))

    


    for k,v in ipairs(self.typeBtn) do
        v.btn:onClick(function()
            if self.choosedType == k then
                return
            end
            self:chooseType(k)
        end)
    end

    for k,v in ipairs(self.smallTabBtn) do
        v:onClick(function()
            if self.smallChooseTypeIdx == k then
                return
            end
            self:smallChooseType(k)
        end)
    end
end


--玩家信息
function WhiteQueenScoreRankView:onShowPlayerInfoView(playerInfo)
    if not self.checkingShareHero then
        local PlayerInfoView = require("lua.logic.chat.PlayerInfoView"):new(playerInfo)
        AlertManager:addLayer(PlayerInfoView,AlertManager.BLOCK_AND_GRAY_CLOSE)
        AlertManager:show()
    else
        HeroDataMgr:changeDataToFriend()
        HeroDataMgr.showid = self.shareHeroId
        Utils:openView("fairyNew.FairyDetailsLayer", {showid=self.shareHeroId, friend=true, fromChatShare = true,friendLv = playerInfo.lvl})
        self.checkingShareHero = false
    end
end

return WhiteQueenScoreRankView