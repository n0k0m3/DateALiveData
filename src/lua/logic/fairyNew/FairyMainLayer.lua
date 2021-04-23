local FairyMainLayer = class("FairyMainLayer", BaseLayer)
require "lua.public.ScrollMenu"

function FairyMainLayer:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self.topBarType_ = {EC_TopbarType.DIAMOND, EC_TopbarType.GOLD, EC_TopbarType.POWER}
    self.showid = HeroDataMgr:getTeamLeaderId();
    self.showidx = 1;
    self.selectCell = nil;
    self.showSkinID = nil;
    if data and data.friend then
    	self.isfriend = true;
    	HeroDataMgr:resetShowList(true);
    	if data.backTag then
    		self.backTag = data.backTag
    	end
        self.friendLv = data.friendLv
    else
    	HeroDataMgr:resetShowList();
    end

    if data and data.showid then
    	self.showid = data.showid;
    	self.showidx = HeroDataMgr:getShowIdxById(self.showid);
    	self.showCount = HeroDataMgr:getShowCount();
    else
    	self.showid = HeroDataMgr:getTeamLeaderId();
    	self.showidx = 1;
    	self.showCount = HeroDataMgr:getShowCount();
    end

    if data and data.fromChatShare and data.chatType then
        self.fromChatShare = data.fromChatShare
        self.chatType = data.chatType
        self.pid = data.pid
    end
    self.firstTouchIn = false;
    self:init("lua.uiconfig.fairyNew.fairyMain")

    -- self:showTopBar()

    self.curPanel = nil;
    self.lastPanel = nil;
end

function FairyMainLayer:getClosingStateParams()
    local param1 = {}
    if self.paramData_ then
        param1.friend = self.paramData_.friend
    end
    param1.backTag = self.backTag
    param1.showid = self.showid
    return {param1}
end

function FairyMainLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	FairyMainLayer.ui = ui
    self:addLockLayer()

	self.Panel_hero 	    = TFDirector:getChildByPath(ui, "Panel_hero")

	self.Image_hero			= TFDirector:getChildByPath(ui, "Image_hero")
	self.Panel_hero_touch   = TFDirector:getChildByPath(ui, "Panel_hero_touch")
	self.Image_attr_bg1	= TFDirector:getChildByPath(ui, "Image_attr_bg1")
	self.Label_level		= TFDirector:getChildByPath(ui, "Label_level")
	self.Label_power		= TFDirector:getChildByPath(ui, "Label_power")
	self.Label_hero_name	= TFDirector:getChildByPath(ui, "Label_hero_name")
    self.Label_en_hero_name    = TFDirector:getChildByPath(ui, "Label_enName2")
    self.Label_en_hero_name2    = TFDirector:getChildByPath(ui, "Label_enName")
    self.Image_energy_rank = TFDirector:getChildByPath(ui, "Image_energy_rank")
    self.Panel_left = TFDirector:getChildByPath(ui, "Panel_left")


	self.Label_hero_desc	= TFDirector:getChildByPath(ui, "Label_hero_desc")
	self.Image_sss_level	= TFDirector:getChildByPath(ui, "Image_sss_level")
	self.Image_unlock_item_icon  = TFDirector:getChildByPath(ui, "Image_unlock_item_icon")
	self.Label_unlock_item_count = TFDirector:getChildByPath(ui, "Label_unlock_item_count")
	self.Button_unlock_hero = TFDirector:getChildByPath(ui, "Button_unlock_hero")
    self.Image_UpStagereddot = TFDirector:getChildByPath(self.Button_unlock_hero,"Image_reddot"):hide();
    self.Panel_unlock  = TFDirector:getChildByPath(ui, "Panel_unlock")

    self.Panel_hero_list    = TFDirector:getChildByPath(ui, "Panel_hero_list")
	self.Panel_hero_item_s    = TFDirector:getChildByPath(ui, "Panel_hero_item_s")
    self.Panel_hero_item_uns    = TFDirector:getChildByPath(ui, "Panel_hero_item_uns")
    self.Panel_level_power    = TFDirector:getChildByPath(ui, "Panel_level_power")
    self.Button_detail    = TFDirector:getChildByPath(ui, "Button_detail")
    self.Label_suit_name    = TFDirector:getChildByPath(ui, "Label_suit_name")
    self.Panel_trailTime    = TFDirector:getChildByPath(ui, "Panel_trailTime")
    self.Label_trailTime    = TFDirector:getChildByPath(self.Panel_trailTime, "Label_trail_time")
    self.Button_oneKey    = TFDirector:getChildByPath(ui, "Button_oneKey"):hide()

    --精灵攻略
    self.Button_fairyStrategy    = TFDirector:getChildByPath(ui, "Button_fairyStrategy")
    self.Button_practice    = TFDirector:getChildByPath(ui, "Button_practice")
    self.Button_experiential = TFDirector:getChildByPath(ui, "Button_experiential")
    self.Button_change_skin = TFDirector:getChildByPath(ui, "Button_change_skin")
    self.Button_share = TFDirector:getChildByPath(ui, "Button_share")
    self.fairyStrategyRedDot = TFDirector:getChildByPath(self.Button_fairyStrategy, "Image_reddot")
    self.Button_tryUse = TFDirector:getChildByPath(ui, "Button_tryUse")
    self.Label_outTime = TFDirector:getChildByPath(self.Button_tryUse, "Label_outTime")
    self.Label_outTimeName = TFDirector:getChildByPath(self.Button_tryUse, "Label_outTimeName")
    self.Label_outTime:setSkewX(15)
    self.Label_outTimeName:setSkewX(15)
    self.Panel_unlock:setVisible(not self.isfriend)
    self.Button_practice:setVisible(not self.isfriend)
    self.Button_experiential:setVisible(not self.isfriend)
    self.Button_tryUse:setVisible(not self.isfriend)
    self.Panel_name_info = TFDirector:getChildByPath(ui, "Panel_name_info")
    self.Panel_right = TFDirector:getChildByPath(ui, "Panel_right")
    self.info_pos = self.Panel_name_info:getPosition()
    self.right_pos = self.Panel_right:getPosition()
    self.hero_pos = self.Image_hero:getPosition()


     --创建克制icon
   -- local startPos = self.Button_detail:getPosition()
   -- self.panel_element = Utils:createElementPanel( self.Panel_right ,1 , ccp(startPos.x - 90 , startPos.y))

    
    self:initHeroListView()
   -- ViewAnimationHelper.doMoveFadeInAction(self.scrollMenu, {direction = 1, distance = 30, ease = 1})
   self.panelTouchFunc = function ( ... )     
        AlertManager:closeTopLayer()    
   end


   
end

function FairyMainLayer:registerEvents()
    -- EventMgr:addEventListener(self,EV_FORMATION_CHANGE,handler(self.onFormationChange, self));
    EventMgr:addEventListener(self,EV_HERO_LEVEL_UP,handler(self.onPropertyChange, self));
    EventMgr:addEventListener(self,EV_HERO_CHANGE_SKIN,handler(self.onSkinChange, self));
    EventMgr:addEventListener(self,EV_HERO_PROPERTYCHANGE,handler(self.onPropertyChange, self));
    EventMgr:addEventListener(self,EV_HERO_LEVEL_UP,handler(self.heroInfoChange, self));
    EventMgr:addEventListener(self,EV_HERO_REFRESH,handler(self.onRefresh, self));
    
    self:setBackBtnCallback(function()
            AlertManager:close();
    end)
    if self.isfriend == true then
        if self.backTag == "teamFight" then
            -- self.topLayer.Button_main:setTexture("ui/cc.png")
            self:setMainBtnCallback(function()
                TeamFightDataMgr:openTeamView()
            end)
        end
    end
    self.Button_unlock_hero:onClick(function()
        local hero = HeroDataMgr:getHero(self.showid)
        if hero.ishave and hero.heroStatus ~= 2 then
            local needs = HeroDataMgr:getProgressNeed(self.showid);--合成
            local costId, costNum
            costId = needs[1]
            costNum = needs[2]

            if HeroDataMgr:reachMaxQuality(self.showid) then
                Utils:showTips(100000054)
            -- elseif GoodsDataMgr:currencyIsEnough(costId, costNum) then
            --     HeroDataMgr:heroProgress(self.showid)
            else
                self.notHide = true
                -- Utils:showAccess(costId)
                Utils:openView("fairyNew.BeforeEvloutionShowView",{self.Image_unlock_item_icon:getTexture(),
                                                                    self.Label_unlock_item_count:getString(),
                                                                    self.showid})
            end
        else
            if HeroDataMgr:isCanCompose(self.showid) then
                HeroDataMgr:composeHero(self.showid);
            else
                local needs = HeroDataMgr:getComposeNeed(self.showid);--合成
                local costId, costNum
                for k, v in pairs(needs) do
                    costId = k
                    costNum = v
                    break
                end
                self.notHide = true
                Utils:showAccess(costId)
            end
        end
	end)

	self.Panel_hero_touch:onClick(function()
        local ishave = HeroDataMgr:getIsHave(self.showid);
        if ishave then
            self:showHeroDetailsInfo();
        else
            Utils:showTips(800076)
        end
	end)

    self.Button_detail:onClick(function()
        local ishave = HeroDataMgr:getIsHave(self.showid);
        if ishave then
            self:showHeroDetailsInfo();
        else
            Utils:showTips(800076)
        end
        GameGuide:checkGuideEnd(self.guideFuncId)
    end)
    
    self.Button_fairyStrategy:onClick(function()
        self:handleHeroDot()
        Utils:openView("fairyNew.FairyStrategyView",self.showid)
    end)

    self.Button_practice:onClick(function()
            if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_Practice) then
                FubenDataMgr:enterPracticeLevel(self.showid)
            else
                local args = {
                    tittle = 2107025,
                    content = TextDataMgr:getText(2107024),
                    reType = EC_OneLoginStatusType.ReConfirm_Practice,
                    confirmCall = function()
                        FubenDataMgr:enterPracticeLevel(self.showid)
                    end,
                }
                Utils:showReConfirm(args)
            end
    end)
    self.Button_experiential:onClick(function()
        local args = {
            tittle = 2107025,
            content = TextDataMgr:getText(2108011),
            reType = EC_OneLoginStatusType.ReConfirm_Experiential,
            confirmCall = function()
                local funcIsOpen = FunctionDataMgr:checkFuncOpen(59)
                if funcIsOpen then
                    local chapterCfg = FubenDataMgr:getChapterCfg(EC_ActivityFubenType.SPRITE_EXTRA)
                    local playerLevel = MainPlayer:getPlayerLv()
                    local unlock = chapterCfg.unlockLevel <= playerLevel

                    if FubenDataMgr:getSpriteExtraIsOpen() and unlock then
                        --精灵模拟试练
                        Utils:openView("fuben.FubenSpriteExtraView", EC_ActivityFubenType.SPRITE_EXTRA,EC_ExperientialHeros[self.showid])
                    end
                end
            end,
        }
        Utils:showReConfirm(args)
    end)

    self.Button_tryUse:onClick(function()
        if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_TryUseHero) then
            if self.trailItemId then
                GoodsDataMgr:useTrailCard(self.trailItemId)
                self.trailItemId = nil
            end
        else
            local args = {
                tittle = 2107025,
                content = TextDataMgr:getText(301027),
                reType = EC_OneLoginStatusType.ReConfirm_TryUseHero,
                confirmCall = function()
                    if self.trailItemId then
                        GoodsDataMgr:useTrailCard(self.trailItemId)
                        self.trailItemId = nil
                    end
                end,
            }
            Utils:showReConfirm(args)
        end
    end)

    self.Button_change_skin:onClick(function()
        if HeroDataMgr:checkEnableChangeSkin(self.showid) then
            local curSkinId = HeroDataMgr:getCurSkin(self.showid)
            local superSkin = HeroDataMgr:getHeroSuperSkin(self.showid)
            if superSkin and superSkin == curSkinId then
                local skinCidTemp = HeroDataMgr:getHeroTempSkinCid(self.showid)
                HeroDataMgr:changeSkin(self.showid,skinCidTemp, false)
            else
                HeroDataMgr:changeSkin(self.showid,superSkin, true)
            end
        end
    end)

    self.Button_share:onClick(function()
        local content = {}
        content.heroName = "「"..HeroDataMgr:getNameById(self.showid).."」"
        content.heroId = self.showid
        local contentStr = json.encode(content)
        ChatDataMgr:sendChatInfo(self.chatType,contentStr,self.pid,EC_ChatState.HERO_SHARE)
        AlertManager:close(self)
    end)

    self.Button_oneKey:onClick(function()
        local ishave = HeroDataMgr:getIsHave(self.showid)
        if not ishave then
            return
        end

        local cmd = string.format("./fightScore %s", self.showid)
        local chatState = EC_ChatState.CHAT
        TFDirector:send(c2s.CHAT_CHAT, {1, chatState,cmd})
    end)
end

function FairyMainLayer:initHeroListView()
    local params = {
        ["upItem"]                  = self.Panel_hero_item_uns,
        ["downItem"]                = self.Panel_hero_item_uns,
        ["selItem"]                 = self.Panel_hero_item_s,
        ["offsetX"]                 = 0,
        ["updateCellInfo"]          = handler(self.updateCellInfo,self),
        ["selCallback"]             = handler(self.selCallback,self),
        ["cellCount"]               = HeroDataMgr:getShowCount(),
        ["isLoop"]                  = true,
        ["size"]                    = self.Panel_hero_list:getContentSize(),
        ["isFromFairy"]             = true
    }
     local scrollMenu = ScrollMenu:create(params);
     scrollMenu:setPosition(self.Panel_hero_list:getPosition())
     self.Panel_hero_list:getParent():removeChild(self.Panel_hero_list:getParent():getChildByName("heroHeads"))
     self.Panel_hero_list:getParent():addChild(scrollMenu,10)
     scrollMenu:setName("heroHeads")
     self.scrollMenu = scrollMenu
     local jumpTo = HeroDataMgr:getSelectedHeroIdx(self.showid)
     self.scrollMenu:jumpTo(self.showidx)
end

function FairyMainLayer:updateCellInfo(cell,cellIdx)

    local heroid = HeroDataMgr:getSelectedHeroId(cellIdx)
    if not heroid then return end

    local ishave = HeroDataMgr:getIsHave(heroid)

    local imgQuality = TFDirector:getChildByPath(cell,"Image_item_quality");
    if ishave then
        imgQuality:setTexture(HeroDataMgr:getQualityPic(heroid))
    else
        imgQuality:setTexture(HeroDataMgr:getQualityPicNotHave(heroid))
    end
    imgQuality:setVisible(true)

    local icon = TFDirector:getChildByPath(cell,"Image_icon")
    icon:setTexture(HeroDataMgr:getIconPathById(heroid))
    --icon:setContentSize(CCSizeMake( 90,90))

    local Image_duty = TFDirector:getChildByPath(cell,"Image_duty")
    local Image_duty_1 = TFDirector:getChildByPath(cell,"Image_duty_1")
  
    local job = HeroDataMgr:getHeroJob(heroid)
    if job then
        if job == 1 then
            Image_duty:setVisible(ishave)
            Image_duty_1:setVisible(false)
        elseif job < 4 then
            Image_duty:setVisible(false)
            Image_duty_1:setVisible(ishave)
        else
            Image_duty:setVisible(false)
            Image_duty_1:setVisible(false)
        end
    end
    local lock = TFDirector:getChildByPath(cell,"Image_lock")
    local Image_lock_word = TFDirector:getChildByPath(cell,"Image_lock_word")
    local Image_over_lock = TFDirector:getChildByPath(cell,"Image_over_lock")
    
    lock:setVisible(not ishave)


    
    local trail_flag = TFDirector:getChildByPath(cell,"trail_flag")
    local heroData = HeroDataMgr:getHero(heroid)

    trail_flag:hide()
    if heroData and heroData.heroStatus == 2 then
        trail_flag:show()
    end

    local Image_unlock = TFDirector:getChildByPath(cell,"Image_unlock")
    local haveCouldUnlockHero = false
    if not heroData.ishave or heroData.heroStatus == 2 then
        local needs = HeroDataMgr:getComposeNeed(heroid);--合成
        local id,needCnt
        for k,v in pairs(needs) do
            id = k;
            needCnt = v;
        end

        local spCnt = GoodsDataMgr:getItemCount(id);
        if spCnt >= needCnt then
            haveCouldUnlockHero = true
        end
    end
    Image_unlock:setVisible(haveCouldUnlockHero)

    ---角色可培养
    local Image_roleUp = TFDirector:getChildByPath(cell,"Image_roleUp"):hide()
    if not self.isfriend then
        if ishave then
            local roleUp = false
            if not haveCouldUnlockHero then
                roleUp = roleUp or HeroDataMgr:heroCouldUpStage(heroid)
                roleUp = roleUp or HeroDataMgr:heroCouldUpLevel(heroid)
                roleUp = roleUp or HeroDataMgr:heroCouldUpAngle(heroid)
                roleUp = roleUp or HeroDataMgr:heroCouldUpEquip(heroid)
                roleUp = roleUp or HeroDataMgr:heroCouldUpNewEquip(heroid)
                roleUp = roleUp or HeroDataMgr:haveStoneEquip(heroid)
                roleUp = roleUp or HeroDataMgr:crystalRedTip(heroid)
                Image_roleUp:setVisible(roleUp)
            end
        end
    end
end

function FairyMainLayer:selCallback(cell,cellIdx)
    self.Panel_name_info:stopAllActions()
    self.Panel_right:stopAllActions()
    self.Image_hero:stopAllActions()
    self.Panel_name_info:setPosition(self.info_pos)
    self.Panel_right:setPosition(self.right_pos)
    self.Image_hero:setPosition(self.hero_pos)
    if self.selectCellItem then
       --self.selectCellItem:stopAllActions() --获得精灵时会报错，先注释掉
    end
    self.selectCellItem = cell
    self.selectCellItem:runAction(CCMoveBy:create(0.2, ccp(15, 0)))
    ViewAnimationHelper.doMoveFadeInAction(self.Image_hero, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_name_info, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})


    local heroid = HeroDataMgr:getSelectedHeroId(cellIdx)
    local ishave = HeroDataMgr:getIsHave(heroid)
    self.showid = heroid
    self.showidx = cellIdx
    self:updateHeroBaseInfo()

    if self.curChangeHeroHandle then
        TFAudio.stopEffect(self.curChangeHeroHandle)
        self.curChangeHeroHandle = nil
    end
    self.curChangeHeroHandle = VoiceDataMgr:playVoiceByHeroID("change_hero",self.showid);

    GameGuide:checkGuideEnd(self.guideFuncId)
end



function FairyMainLayer:updateHeroBaseInfo()
	HeroDataMgr.showid = self.showid
	local skins = HeroDataMgr:getSkins(self.showid);

	self.anim_hero = Utils:createHeroModel(self.showid, self.Image_hero)
    self.anim_hero:setScale(0.75)
	local featurePath = HeroDataMgr:getFeaturePath(self.showid)
	self.Image_attr_bg1:setTexture(featurePath)
	self.Label_level:setString(HeroDataMgr:getLv(self.showid))
	self.Label_power:setString(math.floor(HeroDataMgr:getHeroPower(self.showid)))
	self.Label_hero_name:setString(HeroDataMgr:getName(self.showid))
    self.Label_en_hero_name:setString(HeroDataMgr:getEnName2(self.showid))
    self.Label_en_hero_name2:setString(HeroDataMgr:getEnName(self.showid))
	self.Label_hero_desc:setString(HeroDataMgr:getDesc(self.showid))
    self.Image_energy_rank:setVisible(false)
    self.Image_energy_rank:setPositionX(self.Label_hero_name:getPositionX() + self.Label_hero_name:getContentSize().width + 25)
    local ishave = HeroDataMgr:getIsHave(self.showid)
    if not ishave then
        self.Image_sss_level:setTexture(HeroDataMgr:getQualityPicNotHave(self.showid))
    else
        self.Image_sss_level:setTexture(HeroDataMgr:getQualityPic(self.showid))
    end

    if not self.isfriend then
        self.Button_practice:setVisible(ishave)
        local chapterCfg = FubenDataMgr:getChapterCfg(EC_ActivityFubenType.SPRITE_EXTRA)
        local playerLevel = MainPlayer:getPlayerLv()
        local unlock = chapterCfg.unlockLevel <= playerLevel
        local isOpen = FubenDataMgr:getSpriteExtraIsOpen()
        local expheroCfg = EC_ExperientialHeros[self.showid]
        if expheroCfg and expheroCfg.open == true and unlock and isOpen then
            self.Button_experiential:setVisible(not ishave)
        else
            self.Button_experiential:setVisible(false)
        end

        if not ishave then
            local haveTrailCardCid
            local trailCfg = TabDataMgr:getData("Trial")
            for k,v in pairs(trailCfg) do
                if v.useProfit.id == self.showid then
                    local itemCnt = GoodsDataMgr:getItemCount(k)
                    if itemCnt > 0 then
                        haveTrailCardCid = k
                    end
                end
            end
            if haveTrailCardCid then
                self.Button_tryUse:setVisible(true)
                local outTime = 0
                self.trailItemId = nil
                local itemTab = GoodsDataMgr:getItem(haveTrailCardCid)
                dump(itemTab)
                for k,v in pairs(itemTab) do
                    if v.cid == haveTrailCardCid then
                        outTime = v.outTime or 0
                        self.trailItemId = v.id
                        break
                    end
                end
                local seqact = Sequence:create({
                    CallFunc:create(function()
                        local remainTime = math.max(0, outTime - ServerDataMgr:getServerTime())
                        if remainTime == 0 then
                            self.Button_tryUse:setVisible(false)
                            self.Label_outTime:setTextById(301010)
                        else
                            local day, hour, min = Utils:getTimeDHMZ(remainTime)
                            self.Label_outTime:setTextById(14110137, day,hour, min)
                        end
                    end),
                    DelayTime:create(60),
                })
                self.Label_outTime:runAction(CCRepeatForever:create(seqact))
            else
                self.Button_tryUse:setVisible(false)
            end

        else
            self.Button_tryUse:setVisible(false)
        end
    end

    self.Panel_level_power:setVisible(ishave)
    self.Image_energy_rank:setVisible(ishave)

    --TODO close
--    if ishave and HeroDataMgr:checkHeroEnableEnergyUp(self.showid)  then
--        self.Panel_energy:setVisible(true)
--    end

    self.Label_suit_name:setText(HeroDataMgr:getTitleStr(self.showid))

    local heroData = HeroDataMgr:getHero(self.showid)
    if heroData and heroData.heroStatus == 2 then
        self.Panel_trailTime:show()
        local day,hour,min,sec = Utils:getTimeDHMZ(heroData.deadLine - ServerDataMgr:getServerTime())
        if day + hour + min == 0 and sec > 0 then
            tmin = 1
        end
        self.Label_trailTime:setTextById(282101,day,hour,min)
    else
        self.Panel_trailTime:hide()
    end

    --更新克制icon
    --PrefabDataMgr:setInfo(self.panel_element , heroData.magicAttribute)

    self.Button_change_skin:setVisible(not self.isfriend and HeroDataMgr:checkEnableShowChangeSkinBtn(self.showid))
    self:checkHeroRedDot()
	self:updateCompose()
    self.Button_share:setVisible(not self.isfriend and ishave and self.fromChatShare)
    if self.Button_change_skin:isVisible() then
        self.Button_share:setPositionY(95)
    else
        self.Button_share:setPositionY(182)
    end
end

--攻略按钮小红点
function FairyMainLayer:checkHeroRedDot()
    --是否获得英雄
    local ishave = HeroDataMgr:getIsHave(self.showid)
    if ishave then
        self.fairyStrategyRedDot:setVisible(true)
        local pid = MainPlayer:getPlayerId()
        local allHeroInfoStr = CCUserDefault:sharedUserDefault():getStringForKey(pid.."allhero")
        local heroTab = string.split(allHeroInfoStr,"|")
        for k,v in ipairs(heroTab) do
            if self.showid == tonumber(v) then
                self.fairyStrategyRedDot:setVisible(false)
                break
            end
        end
    else
        self.fairyStrategyRedDot:setVisible(false)
    end

end

--攻略按钮小红点
function FairyMainLayer:handleHeroDot()

    local ishave = HeroDataMgr:getIsHave(self.showid)
    if not ishave then
        return
    end

    local pid = MainPlayer:getPlayerId()
    local allHeroInfoStr = CCUserDefault:sharedUserDefault():getStringForKey(pid.."allhero")
    local heroTab = string.split(allHeroInfoStr,"|")
    for k,v in ipairs(heroTab) do
        if self.showid == tonumber(v) then
            return
        end
    end

    self.fairyStrategyRedDot:setVisible(false)

    allHeroInfoStr = allHeroInfoStr.."|"..self.showid
    CCUserDefault:sharedUserDefault():setStringForKey(pid.."allhero",allHeroInfoStr)
end

function FairyMainLayer:updateCompose()
	if self.isfriend then
		return;
	end

    local hero = HeroDataMgr:getHero(self.showid)
	local needs,id,needCnt;
	if not hero.ishave or hero.heroStatus == 2 then
		needs = HeroDataMgr:getComposeNeed(self.showid);--合成
		for k,v in pairs(needs) do
			id = k;
			needCnt = v;
		end
	else
		needs = HeroDataMgr:getProgressNeed(self.showid);--进阶
		id = needs[1]
		needCnt = needs[2]
	end

    if hero.ishave and (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 or RELEASE_TEST) then
        self.Button_oneKey:show()
    else
        self.Button_oneKey:hide()
    end
    
    if hero.ishave and HeroDataMgr:reachMaxQuality(self.showid) then
        self.Panel_unlock:setVisible(false)
    else
        self.Panel_unlock:setVisible(true)
    end

    --TODO close
    -- if hero.ishave and HeroDataMgr:checkHeroEnableEnergyUp(self.showid)  then
    --     self.Button_energy_up:setVisible(true)
    -- end

    -- local redpoint = HeroDataMgr:checkHeroEnergyRed(self.showid)
    -- self.Image_energy_red:setVisible(redpoint)

	local icon = self.Image_unlock_item_icon
	local iconPath = TabDataMgr:getData("Item",id).icon;
	icon:setTexture(iconPath);
	icon:setContentSize(CCSizeMake(64,64));

	local Label_sp = self.Label_unlock_item_count
	local spCnt = GoodsDataMgr:getItemCount(id);
	Label_sp:setString(spCnt.."/"..needCnt);

	local Label_unlock_btn_title = TFDirector:getChildByPath(self.Button_unlock_hero,"Label_unlock_btn_title");
	-- if spCnt < needCnt then
    --     Label_sp:setColor(ccc3(220,20,60));
    --     Label_unlock_btn_title:setTextById(100000055)
    -- else
    --     Label_sp:setColor(ccc3(255,255,255));
    --     if hero.ishave and hero.heroStatus ~= 2 then
    --        Label_unlock_btn_title:setTextById(100000056)
    --     else
    --    		Label_unlock_btn_title:setTextById(100000057);
    --    	end
    -- end

    if hero.ishave and hero.heroStatus ~= 2 then
        Label_sp:setColor(ccc3(255,255,255))
        Label_unlock_btn_title:setTextById(100000056)
        local upStage = HeroDataMgr:heroCouldUpStage(self.showid)
        self.Image_UpStagereddot:setVisible(upStage)
    else
        self.Image_UpStagereddot:setVisible(false)
        if spCnt < needCnt then
            Label_sp:setColor(ccc3(220,20,60))
            Label_unlock_btn_title:setTextById(100000055)
        else
            Label_sp:setColor(ccc3(255,255,255))
            Label_unlock_btn_title:setTextById(100000057)
        end
    end
end

function FairyMainLayer:initHeroHeadItem(item, heroData, idx)
    item:setVisible(true)
    item.data = heroData
    item.idx  = idx

    local selectPoints = {}

    -- for i=1,4 do
    --     local point = TFDirector:getChildByPath(item,"Image_select_"..i);
    --     point:setVisible(false);
    --     table.insert(selectPoints,point);
    -- end
    --
    local heroid = HeroDataMgr:getSelectedHeroId(idx);
    local qualityLab = TFDirector:getChildByPath(item,"Label_item_quality");
    qualityLab:setString(HeroDataMgr:getQualityStringById(heroid));

    local icon = TFDirector:getChildByPath(item,"Image_icon");
    icon:setTexture(HeroDataMgr:getIconPathById(heroid));
    icon:setContentSize(CCSizeMake( 120,114));

    local jobIcon = TFDirector:getChildByPath(item,"Image_duty");
    local iconpath = HeroDataMgr:getHeroJobIconPath(heroid);
    jobIcon:setVisible(iconpath ~= "")
    jobIcon:setTexture(iconpath);

    local ishave = HeroDataMgr:getIsHave(heroid);
    local lock   = TFDirector:getChildByPath(item,"Image_lock");
    lock:setVisible(not ishave);
end

function FairyMainLayer:showHeroDetailsInfo(...)
	if not self.showid then
		return
	end
    if not FunctionDataMgr:checkFuncOpen(30) then
        return
    end 
    local showid = self.showid
    local friend = self.isfriend
    local backTag = self.backTag
    --AlertManager:close()
    --local heroPos = self.Panel_hero:convertToWorldSpaceAR(self.Image_hero:getPosition())
    local heroPos = self.Image_hero:convertToWorldSpaceAR(self.anim_hero:getPosition())
 	Utils:openView("fairyNew.FairyDetailsLayer", {showid=showid, friend=friend, backTag=backTag, pos = heroPos, friendLv = self.friendLv })
end

function FairyMainLayer:onPropertyChange(heroId)
    if heroId ~= self.showid then
        return
    end

    self:updateHeroBaseInfo()
end

function FairyMainLayer:heroInfoChange()
    if Public:currentScene():getTopLayer().__cname == "FairyMainLayer" then
        Utils:playSound(1004)
    end
    self:updateHeroBaseInfo()
    self:updateHeroListItems()
end

function FairyMainLayer:updateHeroListItems()
    for i = 1, self.scrollMenu:getCellCount() do
        self:updateCellInfo(self.scrollMenu:getCellByIndex(i), i)
    end
end

function FairyMainLayer:onRefresh()
    --self:initHeroListView()
    
end

function FairyMainLayer:onSkinChange()
    self:initHeroListView()
end

function FairyMainLayer:onHide()
	self.super.onHide(self)
    -- self:panelRightHide(self.Panel_right)
    if not self.notHide then
        self:panelLeftHide(self.scrollMenu)
    end
end

function FairyMainLayer:removeUI()
	self.super.removeUI(self)
    HeroDataMgr:changeDataToSelf()
end

function FairyMainLayer:onShow()
    self.super.onShow(self)
    -- self:panelRightShow(self.Panel_right)
    if self.isfriend then
        HeroDataMgr:resetShowList(true)
    else
        HeroDataMgr:resetShowList()
    end

    HeroDataMgr:checkHeroEnergyUnlock()
    self:updateHeroBaseInfo()
    if not self.notHide then
        self:panelLeftShow(self.scrollMenu)
        self:panelLeftShow(self.Panel_hero)
        --self:panelRightShow(self.Panel_right)
    end
    self.notHide = false
    self:timeOut(function()
        self:removeLockLayer()
        GameGuide:checkGuide(self)
    end,0.05)
    self:updateHeroListItems()
end

function FairyMainLayer:panelRightShow(panel)
    panel:stopAllActions();
    panel:setOpacity(0);
    panel:setPositionX(panel:getPositionX() + 20)

    local actions = {
        CCMoveBy:create(0.2,ccp(-20,0));
        CCFadeIn:create(0.2);
    }

    panel:runAction(Spawn:create(actions));
end

function FairyMainLayer:panelRightHide(panel)
    
end

function FairyMainLayer:panelLeftShow(panel)
    panel:stopAllActions();
    panel:setOpacity(0);
    panel:setPositionX(-20)

    local actions = {
        CCMoveTo:create(0.2,ccp(0,panel:getPositionY()));
        CCFadeIn:create(0.2);
    }

    panel:runAction(Spawn:create(actions));
end

function FairyMainLayer:panelLeftHide(panel)
    panel:stopAllActions();
    panel:setPositionX(panel:getPositionX() + 20)

    local actions = {
        CCMoveTo:create(0.2,ccp(-20,panel:getPositionY()));
        CCFadeOut:create(0.2);
    }

    panel:runAction(Spawn:create(actions));
end


---------------------------guide------------------------------

--引导点击折纸
function FairyMainLayer:excuteGuideFunc10001(guideFuncId)
    local cell = self.scrollMenu:getCellByIndex(2)
    local targetNode = cell
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(12, 15))
end

--引导点击详细按钮
function FairyMainLayer:excuteGuideFunc10002(guideFuncId)
    local targetNode = self.Button_detail
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(-45, 0))
end

function FairyMainLayer:onClose()
    self.super.onClose(self)
    if self.curChangeHeroHandle then
        TFAudio.stopEffect(self.curChangeHeroHandle)
        self.curChangeHeroHandle = nil
    end
end

function FairyMainLayer:specialKeyBackLogic( )
    self:panelTouchFunc()
    return true
end

return FairyMainLayer;
