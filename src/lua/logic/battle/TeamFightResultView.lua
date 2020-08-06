local ResLoader = import(".ResLoader")
local enum     = import(".enum")
local eEvent   = enum.eEvent
local TeamFightResultView = class("TeamFightResultView", BaseLayer)
function TeamFightResultView:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:init("lua.uiconfig.battle.teamClearingView")
end

function TeamFightResultView:initData(data)
    self.clickState = 0
    self.data = data
    self.rewardList_ = {}
    self.playerExpAdd = 0
    self.curPageIdx = 1
    for i, v in ipairs(self.data.rewards) do
        if v.id == EC_SItemType.PLAYEREXP then
            self.playerExpAdd = v.num
        elseif v.id == EC_SItemType.SPIRITEXP then
            self.spiritExp_ = v.num
        elseif v.id == EC_SItemType.FAVOR then
            self.favorExp_ = v.num
        else
            table.insert(self.rewardList_, v)
        end
    end
    self.uiAnimList = {"page_a_chuxian",{"Panel_item_1_MVP","Panel_item_2_MVP","Panel_item_3_MVP"},"page_a_b"}
    self.UIAnimPlayList = {"page_a_chuxian","Panel_item_1_MVP","page_a_b"}
    self.MPInfo = {}
    self.MPInfo.curLv = MainPlayer:getPlayerLv()
    self.MPInfo.curExp = MainPlayer:getPlayerExp()
    local levelUpCfg = TabDataMgr:getData("LevelUp")
    local prevExp = self.MPInfo.curExp - self.playerExpAdd
    self.MPInfo.prevExp = prevExp
    for i,v in ipairs(levelUpCfg) do
        if prevExp < v.heroExp then
            self.MPInfo.prevLv = i
        end
        if i == self.MPInfo.curLv then
            self.MPInfo.nextExp = v.playerExp 
        end
    end

end

function TeamFightResultView:runTitleAnim()
    self.titleAnimIdx = 1
    self.titleAnims = {"chuxian","chuxianlizi","xuanhuan"}
    self.success_title:setVisible(true)
    self.success_title:addMEListener(TFARMATURE_COMPLETE,function(sklete)
        self.titleAnimIdx = self.titleAnimIdx + 1
        if self.titleAnimIdx==3 then
            self.success_title:removeMEListener(TFARMATURE_COMPLETE)
            sklete:play(self.titleAnims[self.titleAnimIdx],-1)
        else
            sklete:play(self.titleAnims[self.titleAnimIdx],0)
        end
    end)
    self.success_title:play(self.titleAnims[self.titleAnimIdx],0)
end

function TeamFightResultView:refreshPageA()
    local players = self.data.results
    local battleData = BattleDataMgr:getBattleData()
    local function _getHeroData(pid)
        for i, heroData in ipairs(battleData.heros) do
            if heroData.pid == pid then
                return heroData
            end
        end
    end
    for i=1,3 do
        local playerInfo = players[i]
        local roleitem = self.page_a:getChildByName("Panel_item_"..i)
        local hero_panel = roleitem:getChildByName("Panel_hero")
        local info_panel = roleitem:getChildByName("Panel_info")
        local mvp_panel = roleitem:getChildByName("Panel_mvp")
        local fight_panel = roleitem:getChildByName("Panel_fight")
        local ctrl_panel = roleitem:getChildByName("Panel_ctrl")
        if playerInfo then
            local heroData =_getHeroData(playerInfo.pid)
            local skinInfo = TabDataMgr:getData("HeroSkin", heroData.skinId)
            hero_panel:getChildByName("Image_role_bg"):setTexture(skinInfo.backdrop)
            hero_panel:getChildByName("Image_role_bg"):setVisible(true)
            hero_panel:getChildByName("Panel_role"):setVisible(true)
            local model_panel = hero_panel:getChildByName("Panel_role")
            local model = Utils:createHeroModel(-1, model_panel, 0.4,heroData.skinId)
            if playerInfo.pid == MainPlayer:getPlayerId() then
                self.mySkinId = heroData.skinId
            end
            model:update(0.001)
            model:stop()
            -- local shadowModel = Utils:createHeroModel(-1, model_panel, 0.75,heroData.skinId)
            -- shadowModel:update(0.001)
            -- shadowModel:stop()
            -- shadowModel:setColor(ccc3(0, 0, 0))
            info_panel:getChildByName("Image_captain_bg"):setVisible(TeamFightDataMgr:getLeaderId() == playerInfo.pid)
            info_panel:getChildByName("Label_name"):setString(tostring(heroData.pname))
            info_panel:getChildByName("Label_name"):setVisible(true)
            if playerInfo.mvp == true then
                self.UIAnimPlayList[2] = self.uiAnimList[2][i]
            end
            mvp_panel:getChildByName("Image_mvp_logo"):setVisible(playerInfo.mvp)
            mvp_panel:getChildByName("Image_mvp_title"):setVisible(playerInfo.mvp)
            fight_panel:getChildByName("Label_fight_num"):setString(tostring(playerInfo.hurt))
            fight_panel:getChildByName("Label_fight_num"):setVisible(true)
            fight_panel:getChildByName("Image_num_bg"):setVisible(true)
            fight_panel:getChildByName("Image_fight_logo"):setVisible(true)
            local btn_gg = ctrl_panel:getChildByName("Button_gg")
            local btn_add_frd = ctrl_panel:getChildByName("Button_add_friend")
            btn_add_frd:setVisible(false)
            btn_gg:setVisible(false)
            ctrl_panel:getChildByName("Image_ctrl_bg"):setVisible(false)
            -- if self:getFriendStatus(playerInfo.pid) == 0 then
            --     btn_add_frd.pid = playerInfo.pid
            --     btn_add_frd:setVisible(true)
            --     btn_add_frd:onClick(function()
            --         btn_add_frd:setTouchEnabled(false)
            --         btn_add_frd:setGrayEnabled(true)
            --         FriendDataMgr:addFriend(btn_add_frd.pid)
            --     end)
            -- end
        else
            hero_panel:getChildByName("Image_role_bg"):setVisible(false)
            hero_panel:getChildByName("Panel_role"):setVisible(true)
            info_panel:getChildByName("Image_captain_bg"):setVisible(false)
            info_panel:getChildByName("Label_name"):setVisible(false)
            mvp_panel:getChildByName("Image_mvp_logo"):setVisible(false)
            mvp_panel:getChildByName("Image_mvp_title"):setVisible(false)
            fight_panel:getChildByName("Label_fight_num"):setVisible(false)
            fight_panel:getChildByName("Image_num_bg"):setVisible(false)
            fight_panel:getChildByName("Image_fight_logo"):setVisible(false)
            ctrl_panel:getChildByName("Button_gg"):setVisible(false)
            ctrl_panel:getChildByName("Button_add_friend"):setVisible(false)
            ctrl_panel:getChildByName("Image_ctrl_bg"):setVisible(false)
            
        end
        
    end
    
end

function TeamFightResultView:refreshPageB()
    local reward_panel = self.page_b:getChildByName("Panel_reward")
    local big_role_panel = self.page_b:getChildByName("Panel_big_role")
    reward_panel:getChildByName("Label_role_name"):setString(MainPlayer:getPlayerName())
    reward_panel:getChildByName("Label_role_lv"):setString(string.format("Lv.%d",MainPlayer:getPlayerLv()))
    local head_face = HeroDataMgr:getPlayerIconPathById(HeroDataMgr:getTeamLeaderId())
    reward_panel:getChildByName("ClippingNode_mask"):getChildByName("Image_playerIcon"):setTexture(head_face)

    local curPercent = 100
    local expStr = ""
    if self.MPInfo.nextExp > 0 then
        curPercent = MainPlayer:getExpProgress()
        expStr = expStr..self.MPInfo.curExp.."/"..self.MPInfo.nextExp
    end

    reward_panel:getChildByName("Image_exp_bg"):getChildByName("LoadingBar_exp"):setPercent(curPercent)
    reward_panel:getChildByName("Image_exp_bg"):getChildByName("Label_exp"):setString(expStr)
    local timelong = math.ceil(self.data.fightTime/1000)
    local function getTimeStr(numt)
        if numt < 10 then
            return string.format("0%d",numt)
        end
        return tostring(numt)
    end
    reward_panel:getChildByName("Label_used_time"):setString(string.format("%d:%s",math.floor(timelong/60),getTimeStr(timelong%60)))
    local reward_scrollview = reward_panel:getChildByName("ScrollView_award")
    local rewardListView = UIListView:create(reward_scrollview)
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:Scale(0.6)
    rewardListView:setItemModel(Panel_goodsItem)
    if self.rewardList_ then --可能没有奖励
        for i, v in ipairs(self.rewardList_) do
            local item = rewardListView:pushBackDefaultItem()
            PrefabDataMgr:setInfo(item, v.id, v.num)
        end
    end

    local myselHeroInfo = TeamFightDataMgr:getMySelHeroInfo()
    local myHeroExpPercent = HeroDataMgr:getExpPercent(myselHeroInfo.heroCid)
    local myHeroExp = HeroDataMgr:getExp(myselHeroInfo.heroCid)
    local myHeroExpNeed = HeroDataMgr:getLevelUpExp(myselHeroInfo.heroCid)
    local myHero = HeroDataMgr:getHero(myselHeroInfo.heroCid)
    big_role_panel:getChildByName("Label_lv"):setString(string.format("Lv.%d",myHero.lvl))
    big_role_panel:getChildByName("Image_exp_bg"):getChildByName("LoadingBar_exp"):setPercent(myHeroExpPercent)
    local myheroExpShow = ""
    if myHeroExpNeed > 0 then
        myheroExpShow = myheroExpShow..myHeroExp.."/"..myHeroExpNeed
    end
    big_role_panel:getChildByName("Label_exp"):setString(myheroExpShow)
    local role_node = big_role_panel:getChildByName("Panel_role")
    local role_shadow = big_role_panel:getChildByName("Panel_role_shadow")

    local model = Utils:createHeroModel(myselHeroInfo.heroCid, role_node, 0.6,nil)
    model:update(0.001)
    model:stop()
    local shadowModel = Utils:createHeroModel(myselHeroInfo.heroCid, role_shadow, 0.6,nil)
    shadowModel:update(0.001)
    shadowModel:stop()
    shadowModel:setColor(ccc3(0, 0, 0))

end

function TeamFightResultView:initUI(ui)
	self.super.initUI(self, ui)
    self.uinode = ui
    self.Panel_root     = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_root:setTouchEnabled(false)
    self.page_a = self.Panel_root:getChildByName("Panel_page_a")
    self.page_b = self.Panel_root:getChildByName("Panel_page_b")
    self.success_title = self.Panel_root:getChildByName("Spine_title")
    local Label_continue = self.Panel_root:getChildByName("Label_continue")
    Utils:blinkRepeatAni(Label_continue)
    self:refreshPageA()
    self:refreshPageB()
    self.page_b:setVisible(false)
    self:runTitleAnim()
end

function TeamFightResultView:onShow( ... )
    self.super.onShow(self)
    
    self.uinode:runAnimation(self.UIAnimPlayList[1],1)
    self.uinode:setAnimationCallBack(self.UIAnimPlayList[1], TFANIMATION_END, function(data)
        self.uinode:runAnimation(self.UIAnimPlayList[2],1)
    end, nil)
    self.uinode:setAnimationCallBack(self.UIAnimPlayList[2], TFANIMATION_END, function(data)
        self.Panel_root:setTouchEnabled(true)
    end, nil)
    
end

function TeamFightResultView:getFriendStatus(pid)
    if MainPlayer:getPlayerId() == pid then
        return -1
    end
    if FriendDataMgr:isFriend(pid) then
        return 1
    end
    return 0
end

function TeamFightResultView:refreshView()
    --刷新添加好友按钮 和 点暂按钮
    -- for i, heroItem in ipairs(self.heroItems) do
    --     if heroItem:isVisiable() then
    --         if self:getFriendStatus(heroItem.pid) == 0 then
    --             heroItem.button_add_friend:setTouchEnabled(true)
    --             heroItem.button_add_friend:setGrayEnabled(false)
    --         else
    --             heroItem.button_add_friend:setTouchEnabled(false)
    --             heroItem.button_add_friend:setGrayEnabled(true)
    --             -- heroItem.button_add_friend:hide()
    --         end
    --         -- heroItem.button_gg
    --     end
    -- end

end

function TeamFightResultView:registerEvents()
    EventMgr:addEventListener(self,EV_FRIEND_OPERATEFRIEND, handler(self.refreshView, self))
    self.Panel_root:onClick(function()
        if self.curPageIdx == 1 then
            self:showReward()
        else
            self.Panel_root:setTouchEnabled(false)
            EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
            AlertManager:closeLayer(self)
        end
        
    end)
end

--显示奖励
function TeamFightResultView:showReward()
    self.curPageIdx = self.curPageIdx + 1
    self.page_a:setVisible(false)
    self.page_b:setVisible(true)
    self.uinode:runAnimation(self.UIAnimPlayList[3])
end

return TeamFightResultView
