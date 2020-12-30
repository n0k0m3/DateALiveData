local BattleUtils = require("lua.logic.battle.BattleUtils")
local TeamFightTeamView = class("TeamFightTeamView", BaseLayer)

function TeamFightTeamView:initData()
    self.isTeamLeader = false
    self.isAutoReady = SettingDataMgr:getIsAutoReady() == 1  --是否自动准备
    self.teamItemsPos = {
        [1] = {ccp(0,0)},
        [2] = {ccp(-180,0),ccp(180,0)},
        --[3] = {ccp(-310,0),ccp(0,0),ccp(310,0)},
        [3] = {ccp(-412,0),ccp(-206,0),ccp(0,0),ccp(206,0),ccp(412,0)},
        [4] = {ccp(-360,0),ccp(-120,0),ccp(120,0),ccp(360,0)},
        [5] = {ccp(-412,0),ccp(-206,0),ccp(0,0),ccp(206,0),ccp(412,0)},
    }
    self.speaksCfg = {240018,240019,240020,240021,240022,190000502}
    self.myHeroInfo = {}
    self.isRepeatWithOther = false
    self.isReqCloseLayer = false
    self.isReqGoMain = false
    self.curLevelCfg = TeamFightDataMgr:getBattleCfg()
    self.teamMaxCount = self.curLevelCfg.capacity or 2
    self.inviteTimeCool = Utils:getKVP(21006,"time")
    self.teamItemsStatShow = {
        [1] = {ready = false,unready = false,warning = false}, --空位
        [2] = {ready = false,unready = true,warning = false}, --未准备
        [3] = {ready = true,unready = false,warning = false}, --已准备
        [4] = {ready = false,unready = false,warning = true}, --精灵冲突
        [5] = {ready = false,unready = false,warning = false}, --自己是队长就绪

    }
    self.teamRB_btn_title = {
        [1] = {img = "ui/onlineteam/btn_red.png",txt = 2100073,color = ccc3(255,255,255),animtip = true},--更换精灵
        [2] = {img = "ui/onlineteam/btn_red.png",txt = 2100070,color = ccc3(255,255,255),animtip = true}, --准备
        [3] = {img = "ui/onlineteam/btn_white.png",txt = 800029,color = ccc3(227,115,147),animtip = false}, --取消准备
        [4] = {img = "ui/onlineteam/btn_red.png",txt = 2100076,color = ccc3(255,255,255),animtip = true},--战斗开始
        [5] = {img = "ui/onlineteam/btn_red.png",txt = 2100076,color = ccc3(255,255,255),animtip = false}, --等待其他队员准备
    }
    self.teamItemCtrlCfg = {
        [1] = {
                [1] = {img = "ui/onlineteam/ctrl_logo_info.png",btnRes = "ui/onlineteam/ctrl_btn2.png",txt = 2100063,posY = -150}, --查看信息
                [2] = {img = "ui/onlineteam/ctrl_logo_captain.png",btnRes = "ui/onlineteam/ctrl_btn2.png",txt = 2100062,posY = 0}, --转移队长
                [3] = {img = "ui/onlineteam/ctrl_logo_kickout.png",btnRes = "ui/onlineteam/ctrl_btn.png",txt = 2100061,posY = 150}, --请出队伍
            },
        [2] = {
                [1] = {img = "ui/onlineteam/ctrl_logo_club.png",btnRes = "ui/onlineteam/ctrl_btn.png",txt = 2100065,posY = 150}, --社团邀请
                [2] = {img = "ui/onlineteam/ctrl_logo_friend.png",btnRes = "ui/onlineteam/ctrl_btn.png",txt = 2100066,posY = 0}, --好友邀请
                [3] = {img = "ui/onlineteam/ctrl_logo_world.png",btnRes = "ui/onlineteam/ctrl_btn.png",txt = 2100064,posY = -150}, --系统邀请
            },
    }

    self.visiblePic = {[0] = "ui/onlineteam/setting/7.png",
                       [1] = "ui/onlineteam/setting/6.png",
                       [2] = "ui/onlineteam/setting/8.png",
    }

    self.btns_click_enable = false
    self.ctrl_pad_func = {
        [1] = {
                [1] = function(itemidx)
                        --暂无此功能
                        local memberData = TeamFightDataMgr:getMemberInfo(itemidx.item_idx)
                        if memberData then
                            MainPlayer:sendPlayerId(memberData.pid)
                        end
                        -- Utils:showTips(900049)
                    end,--查看信息
                [2] = function(itemidx)
                        if self.isTeamLeader == true then
                            if self.curLevelCfg.allowLeader then -- 不能切换队长
                                Utils:showTips(14110154)
                                return
                            end
                            local memberData = TeamFightDataMgr:getMemberInfo(itemidx.item_idx)
                            if memberData then
                                TeamFightDataMgr:requestAppointLeader(memberData.pid)
                            end
                        else
                            --队长权限
                            Utils:showTips(2100096)
                        end
                    end,--转移队长
                [3] = function(itemidx)
                        if self.isTeamLeader == true then
                            local memberData = TeamFightDataMgr:getMemberInfo(itemidx.item_idx)
                            if memberData then
                                Utils:openView("teamFight.KickOutConfirmView",memberData)
                            end
                        else
                            --队长权限
                            Utils:showTips(2100096)
                        end
                    end,--请出队伍
            },
        [2] = {
                [1] = function(itemidx)
                        TeamFightDataMgr:inviteClub()
                    end,--社团邀请
                [2] = function(itemidx)
                        TeamFightDataMgr:openInviteFriend()
                    end,--好友邀请
                [3] = function(itemidx)
                        TeamFightDataMgr:invitePublic()
                    end,--系统邀请
            },
    }

    if self.curLevelCfg.heroLimitType == EC_LimitHeroType.LIMIT_NJ or self.curLevelCfg.heroLimitType == EC_LimitHeroType.LIMIT_J then
        TFDirector:send(c2s.DUNGEON_LIMIT_HERO_DUNGEON, {self.curLevelCfg.id})
    end
    if TeamFightDataMgr.nTeamType == 9 then --万圣节组队
        ActivityDataMgr2:reqHalloweenPass()
        for i,v in ipairs(self.teamRB_btn_title) do
            if i == 3 then
                v.color = ccc3(255,255,255)
                v.img = "ui/activity/activity_2020wsj/figthReady/btn_cancel.png"
            elseif i == 4 or i == 5 then
                v.color = ccc3(143,52,87)
                v.img = "ui/activity/activity_2020wsj/figthReady/btn.png"
            else
                v.color = ccc3(143,52,87)
                v.img = "ui/activity/activity_2020wsj/figthReady/btn_ready.png"
            end
        end
    end
end

function TeamFightTeamView:ctor(...)
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.teamFight.teamMatchView")
end

function TeamFightTeamView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_team     = TFDirector:getChildByPath(ui, "Panel_team")
    --if self.teamMaxCount > 3 then
    --    self.prefab_model = self.Panel_team:getChildByName("Panel_member_model"):show()
    --    self.Panel_team:getChildByName("Panel_member_model_big"):hide()
    --    Box("11111111111")
    --else
    --    self.Panel_team:getChildByName("Panel_member_model"):hide()
    --    self.prefab_model = self.Panel_team:getChildByName("Panel_member_model_big"):show()
    --    Box("2222222222")
    --end

    self.gmSkill_ = {}
    self.Panel_GongMing =  TFDirector:getChildByPath(ui, "Panel_GongMing")
    local isOpen = FunctionDataMgr:isOpen(151)
    self.Panel_GongMing:setVisible(isOpen)
    if self.Panel_GongMing then
        for i=1,4 do
            local btn = TFDirector:getChildByPath(self.Panel_GongMing, "Button_gm_skill"..i)
            local Image_icon_bg = TFDirector:getChildByPath(btn, "Image_icon_bg")
            local icon = TFDirector:getChildByPath(btn, "icon")
            icon:setScale(0.4)
            table.insert(self.gmSkill_,{btn = btn, iconBg = Image_icon_bg, skillIcon = icon})
        end
    end

    ---房间操作
    self.Panel_room_hadle =  TFDirector:getChildByPath(ui, "Panel_room_hadle")
    self.Image_match_state = TFDirector:getChildByPath(self.Panel_room_hadle, "Image_match_state"):hide()
    self.Label_match_state =  TFDirector:getChildByPath(self.Panel_room_hadle, "Label_match_state")
    self.Image_match_state_icon = TFDirector:getChildByPath(self.Panel_room_hadle, "Image_match_state_icon")
    self.Label_effect_state =  TFDirector:getChildByPath(self.Panel_room_hadle, "Label_effect_state")
    self.Label_limit_lv =  TFDirector:getChildByPath(self.Panel_room_hadle, "Label_limit_lv")
    self.Image_effect_state_icon = TFDirector:getChildByPath(self.Panel_room_hadle, "Image_effect_state_icon")
    self.Image_visibleTypeIcon = TFDirector:getChildByPath(self.Panel_room_hadle, "Image_visibleTypeIcon")
    self.Panel_room_hadle:setVisible(TeamFightDataMgr.nTeamType ~= EC_NetTeamType.Hunter)

    self.prefab_model = self.Panel_team:getChildByName("Panel_member_model"):show()
    self.Panel_team:getChildByName("Panel_member_model_big"):hide()

    self.root_panel = TFDirector:getChildByPath(ui, "Panel_root")
    local Label_title = self.root_panel:getChildByName("Image_title_bg"):getChildByName("Label_title")
    Label_title:setTextById(self.curLevelCfg.levelName)
    self.Button_preview = self.root_panel:getChildByName("Image_title_bg"):getChildByName("Button_preview")
    local pos  = Label_title:getPosition()
    local size = Label_title:getSize()
    pos.x = pos.x + size.width + 30
    self.Button_preview:setPosition(pos)
    self.Button_preview:hide()
    self.chat_img = TFDirector:getChildByPath(self.root_panel, "Image_chat")
    self.btn_speak = TFDirector:getChildByPath(self.root_panel, "Button_speak")
    self.Button_help = TFDirector:getChildByPath(self.root_panel, "Button_help")
    self.panel_speaks = TFDirector:getChildByPath(self.root_panel, "Panel_speaks")
    self.panel_speaks:hide()
    self.panel_speaklist = TFDirector:getChildByPath(self.panel_speaks, "Panel_speaklist")
    local speaks_scrollView = self.panel_speaklist:getChildByName("ScrollView_speak")
    local speak_cell = speaks_scrollView:getChildByName("Panel_cell")
    self.speak_listView = UIListView:create(speaks_scrollView)
    self.speak_listView:setItemModel(speak_cell)
    self.speak_listView:removeAllItems()
    self:addScrollBarFunction(self.panel_speaklist)

    local ScrollView_affix = TFDirector:getChildByPath(ui, "ScrollView_affix"):hide()
    self.ListView_affix = UIListView:create(ScrollView_affix)
    self.ListView_affix:setItemsMargin(5)
    self.Image_affix_item = TFDirector:getChildByPath(ui, "Image_affix_item")
    self.Label_noAffix = TFDirector:getChildByPath(ui, "Label_noAffix"):hide()
    self.Label_noAffix:setTextById(14110460)
    self.Image_buff_tip = TFDirector:getChildByPath(ui, "Image_buff_tip"):hide()
    self.Label_buff_tip = TFDirector:getChildByPath(ui, "Label_buff_tip")
    self.Panel_buff = TFDirector:getChildByPath(ui, "Panel_buff"):hide()
    self.buff_listView = UIListView:create(self.Panel_buff:getChildByName("ScrollView_buff"))
    self.buff_item = self.Panel_buff:getChildByName("Panel_buff_item")

    for k,v in ipairs(self.speaksCfg) do
        local item = self.speak_listView:pushBackDefaultItem()
        item:setVisible(true)
        item:getChildByName("Label_speak"):setTextById(v)
        item.speakId = v
        item:onClick(function(sender)
            local speakContent = TextDataMgr:getText(sender.speakId)
            local msg = {
                5,
                1,
                speakContent,
            }
            TFDirector:send(c2s.CHAT_CHAT,msg)
            self:speaksRefresh(5)
        end)
    end
    if TeamFightDataMgr.nTeamType == 9 then
        TFDirector:getChildByPath(ui, "Image_bg"):setTexture("ui/activity/activity_2020wsj/figthReady/bg.png")
        self.Image_buff_tip:setTexture("ui/activity/activity_2020wsj/figthReady/005.png")
    end

    self:initTeamPart()
    self:initCommonPart()
    self:onHandleTeamData()
    self:initAffixInfo()
    self:updateBuffInfos()

    self.panelTouchFunc = function()
        if self.isReqCloseLayer == true then
            return true
        end
        local alertparams = clone(EC_GameAlertParams)
        alertparams.msg = 2100111
        alertparams.comfirmCallback = function()
            self.isReqCloseLayer = true
            TeamFightDataMgr:requestExitTeam()
        end
        showGameAlert(alertparams)
    end
    self.Button_help:setVisible(self.curLevelCfg.allowTips)
    self:updateGMSkill()

    ---房间操作
    self:updateHandleInfo()

    AlertManager:closeLayerByName("ChatView")
end

function TeamFightTeamView:initAffixInfo()

    if TeamFightDataMgr.nTeamType == EC_NetTeamType.Hunter then
        return
    end

    self.ListView_affix:s():setVisible(true)

    self.ListView_affix:removeAllItems()
    local affixData
    local affixID = self.curLevelCfg.affixID
    if affixID and affixID > 0 then
        affixData = TabDataMgr:getData("MonsterAffix",affixID)
    end
    self.Label_noAffix:show()
    if not affixData then
        return
    end

    local affixName = affixData.affixName
    self.Label_noAffix:setVisible(#affixName <= 0)

    for k,v in ipairs(affixName) do
        local item = self.Image_affix_item:clone()
        self.ListView_affix:pushBackCustomItem(item)

        local affixIconRes  = affixData["affixIcon"..tostring(k)]
        if affixIconRes then
            local Image_icon = item:getChildByName("Image_icon")
            Image_icon:setTexture(affixIconRes)
            Image_icon:setScale(0.7)
        end

        local Label_name = item:getChildByName("Label_name")
        Label_name:setTextById(v)
        Label_name:setSkewX(15)

        local affixDescId = affixData.affixDesc[k]
        if affixDescId then
            local Label_desc = item:getChildByName("Label_desc")
            Label_desc:setTextById(affixDescId)
        end
    end
end

function TeamFightTeamView:updateBuffInfos()
    if self.curLevelCfg.buffID then
        if table.count(self.curLevelCfg.buffID) > 0 then
            self.buff_listView:removeAllItems()
            self.Panel_buff:show()
            if self.Label_noAffix:isVisible() then
                self.Label_noAffix:hide()
            end
            local unableBuff = ActivityDataMgr2:getHalloweenUnableSuperBuffIds()
            for k,v in pairs(self.curLevelCfg.buffID) do
                local visible = table.indexOf(unableBuff,v) ~= -1
                local item = self.buff_item:clone()
                local buffCfg = TabDataMgr:getData("HalloweenBuff", v)
                local Image_buff_bg = item:getChildByName("Image_buff_bg")
                local Label_buff_desc = item:getChildByName("Label_buff_desc")
                local Image_line = item:getChildByName("Image_line")
                Image_buff_bg:setTexture(visible and "ui/activity/activity_2020wsj/figthReady/003.png" or "ui/activity/activity_2020wsj/figthReady/002.png")
                Label_buff_desc:setTextById(buffCfg.buffDescribe)
                Label_buff_desc:setColor(visible and ccc3(98,125,214) or ccc3(191,225,249))
                Image_line:setVisible(visible)

                self.buff_listView:pushBackCustomItem(item)
            end
        else
            self.Panel_buff:hide()
        end
    end
end

function TeamFightTeamView:speaksRefresh(cdtime)
    local isShow = self.panel_speaks:isVisible()
    if isShow == true then
        local actionArr = {ScaleTo:create(0.2,0),CallFunc:create(function()
            self.panel_speaks:setVisible(false)
            self.btn_speak:setTextureNormal("ui/onlineteam/btn_open_speaks.png")
            if cdtime then
                Utils:makeCDProgressBar(self.btn_speak,cdtime,"ui/onlineteam/btn_open_speaks.png")
            end
        end)}
        self.panel_speaklist:runAction(Sequence:create(actionArr))
    end
    if isShow == false then
        self.panel_speaks:setVisible(true)
        local actionArr = {ScaleTo:create(0.2,1),CallFunc:create(function()
            self.btn_speak:setTextureNormal("ui/onlineteam/btn_close_speaks.png")
        end)}
        self.panel_speaklist:runAction(Sequence:create(actionArr))
    end
end

function TeamFightTeamView:initTeamPart()
    self.teamItems = {}
    local item_model = self.prefab_model
    for i = 1,self.teamMaxCount do
        self.teamItems[i] = {}
        if i == 1 then
            self.teamItems[i]["item_root"] = item_model
        else
            self.teamItems[i]["item_root"] = item_model:clone()
            self.Panel_team:addChild(self.teamItems[i]["item_root"])
        end
        self.teamItems[i]["item_root"]:setPosition(self.teamItemsPos[self.teamMaxCount][i])
        ------------------------------------------------------------------------------------------------------------------------------------------------
        self.teamItems[i]["player"] = {}
        self.teamItems[i]["player"]["hero_box"] = self.teamItems[i]["item_root"]:getChildByName("Panel_hero_box")
        self.teamItems[i]["player"]["hero"] = self.teamItems[i]["player"]["hero_box"]:getChildByName("Panel_hero")
        self.teamItems[i]["player"]["hero_bg"] = self.teamItems[i]["player"]["hero_box"]:getChildByName("Image_hero_bg")
        self.teamItems[i]["player"]["leader_logo"] = self.teamItems[i]["item_root"]:getChildByName("Image_leader_logo")
        self.teamItems[i]["player"]["leader_bg"] = self.teamItems[i]["item_root"]:getChildByName("Image_captain_bg")
        self.teamItems[i]["player"]["Lv_bg"] = self.teamItems[i]["item_root"]:getChildByName("Image_lv")
        self.teamItems[i]["player"]["Lv_value"] = self.teamItems[i]["player"]["Lv_bg"]:getChildByName("Label_lv")
        self.teamItems[i]["player"]["name"] = self.teamItems[i]["item_root"]:getChildByName("Label_name")
        self.teamItems[i]["player"]["quality"] = self.teamItems[i]["item_root"]:getChildByName("Image_quality")
        self.teamItems[i]["player"]["ready"] = self.teamItems[i]["item_root"]:getChildByName("Image_ready")
        self.teamItems[i]["player"]["getting_ready"] = self.teamItems[i]["item_root"]:getChildByName("Image_getting_ready")
        self.teamItems[i]["player"]["msg_bg"] = self.teamItems[i]["item_root"]:getChildByName("Image_msg_bubble")
        self.teamItems[i]["player"]["msg"] = self.teamItems[i]["player"]["msg_bg"]:getChildByName("TextArea_msg")
        self.teamItems[i]["player"]["empty"] = self.teamItems[i]["item_root"]:getChildByName("Image_empty")
        self.teamItems[i]["player"]["empty"].addBtn = self.teamItems[i]["player"]["empty"]:getChildByName("Button_add")
        self.teamItems[i]["player"]["repeat_tip"] = self.teamItems[i]["item_root"]:getChildByName("Image_warning")
        self.teamItems[i]["player"]["repeat_tip"]:setVisible(false)
        self.teamItems[i]["player"]["msg_bg"]:setVisible(false)
        self.teamItems[i]["player"]["Lv_bg"]:hide() --隐藏等级显示
        self.teamItems[i]["player"]["Image_fightPower"] =  TFDirector:getChildByPath(self.teamItems[i]["item_root"],"Image_fightPower")
        self.teamItems[i]["player"]["Label_fightPower"] =  TFDirector:getChildByPath(self.teamItems[i]["item_root"],"Label_fightPower")
        self.teamItems[i]["player"]["Image_buff_up"] =  TFDirector:getChildByPath(self.teamItems[i]["item_root"],"Image_buff_up")
        self.teamItems[i]["stat"] = {}
        self.teamItems[i]["stat"]["value"] = 1

        --创建克制icon
        local heroBoxSize = self.teamItems[i]["player"]["hero_box"]:getContentSize()
        local startPos = ccp(heroBoxSize.width/2 , 0) + ccp(- 30 , 30)
        self.teamItems[i]["player"]["panel_element"] = Utils:createElementPanel(self.teamItems[i]["player"]["hero_box"] , 1 ,startPos)
        self.teamItems[i]["player"]["panel_element"]:hide()

        self.teamItems[i]["ctrl"] = {}
        self.teamItems[i]["ctrl"]["ctrl_root"] = self.teamItems[i]["item_root"]:getChildByName("Image_ctrl_pad")
        self.teamItems[i]["ctrl"]["ctrl_root"]:setVisible(false)
        self.teamItems[i]["ctrl"]["ctrl_root"].ctrl_panel = self.teamItems[i]["ctrl"]["ctrl_root"]:getChildByName("Panel_ctrl")
        self.teamItems[i]["ctrl"]["ctrl_root"].isShow = false
        self.teamItems[i]["player"]["empty"].addBtn:onClick(function()
            if self.teamItems[i]["ctrl"]["ctrl_root"].isShow == false and self.teamItems[i]["stat"]["value"] ~= 4 and MainPlayer:getPlayerId() == TeamFightDataMgr:getLeaderId() then
                self:showCtrlPad(self.teamItems[i]["ctrl"]["ctrl_root"])
            end
            for j = 1,self.teamMaxCount do
                if self.teamItems[j]["ctrl"]["ctrl_root"].isShow == true and j ~= i then
                    self:hideCtrlPad(self.teamItems[j]["ctrl"]["ctrl_root"])
                end
            end
        end)
        self.teamItems[i]["player"]["empty"]:onClick(function()
            if self.teamItems[i]["ctrl"]["ctrl_root"].isShow == false and self.teamItems[i]["stat"]["value"] ~= 4 and MainPlayer:getPlayerId() == TeamFightDataMgr:getLeaderId() then
                self:showCtrlPad(self.teamItems[i]["ctrl"]["ctrl_root"])
            end
            for j = 1,self.teamMaxCount do
                if self.teamItems[j]["ctrl"]["ctrl_root"].isShow == true and j ~= i then
                    self:hideCtrlPad(self.teamItems[j]["ctrl"]["ctrl_root"])
                end
            end
        end)
        self.teamItems[i]["ctrl"]["ctrl_root"]:onClick(function( ... )
            if self.teamItems[i]["ctrl"]["ctrl_root"].isShow == true then
                self:hideCtrlPad(self.teamItems[i]["ctrl"]["ctrl_root"])
            end
        end)
        self.teamItems[i]["item_root"]:onClick(function()
            if self.teamInfoData[i] then
                if self.teamInfoData[i].pid == MainPlayer:getPlayerId() then
                    if self.teamItems[i]["stat"]["value"] == 2 or self.teamItems[i]["stat"]["value"] == 5 or self.teamItems[i]["stat"]["value"] == 4 then
                        self:openChangeHeroView()
                    elseif self.teamItems[i]["stat"]["value"] == 3 then
                        Utils:showError(2100108)
                    else

                    end
                else

                    if MainPlayer:getPlayerId() ~= TeamFightDataMgr:getLeaderId() then
                        --暂无此功能
                        MainPlayer:sendPlayerId(self.teamInfoData[i].pid)
                        -- Utils:showTips(2100109)
                    else
                        self:showCtrlPad(self.teamItems[i]["ctrl"]["ctrl_root"])
                    end
                end
            end
        end)


        for j = 1,3 do
            self.teamItems[i]["ctrl"]["btn_"..j] = self.teamItems[i]["ctrl"]["ctrl_root"].ctrl_panel:getChildByName("Button_ctrl_"..j)
            self.teamItems[i]["ctrl"]["btn_logo"..j] = self.teamItems[i]["ctrl"]["btn_"..j]:getChildByName("Image_logo")
            self.teamItems[i]["ctrl"]["btn_title"..j] = self.teamItems[i]["ctrl"]["btn_"..j]:getChildByName("Label_title")
            self.teamItems[i]["ctrl"]["btn_"..j].idx = {item_idx = i,btn_idx = j}
            self.teamItems[i]["ctrl"]["btn_"..j]:onClick(function()
                local itemfuncidx = self.teamItems[i]["ctrl"]["btn_"..j].idx
                local ctrl_stat = 2
                if self.teamItems[i]["stat"]["value"] == 1 then
                    ctrl_stat = 2
                elseif self.teamItems[i]["stat"]["value"] == 2 or self.teamItems[i]["stat"]["value"] == 3 then
                    ctrl_stat = 1
                else

                end
                self.ctrl_pad_func[ctrl_stat][itemfuncidx.btn_idx](itemfuncidx)
                self:hideCtrlPad(self.teamItems[i]["ctrl"]["ctrl_root"])
                self:updateTeamPart()
            end)
        end
    end
    self.root_panel:onClick(function()
        for i = 1,self.teamMaxCount do
            if self.teamItems[i]["ctrl"]["ctrl_root"].isShow == true then
                self:hideCtrlPad(self.teamItems[i]["ctrl"]["ctrl_root"])
            end
        end
    end)
end

function TeamFightTeamView:onLimitHeroEvent()
    HeroDataMgr:resetShowList(true)
    self.formationData_ = FubenDataMgr:getInitFormation(self.curLevelCfg.id)
    if self.formationData_ then
        HeroDataMgr:changeDataByLevelCfg(self.curLevelCfg, self.formationData_)
    end
    self:updateTeamPart()
end


function TeamFightTeamView:hideCtrlPad(ctrlpad)
    ctrlpad.ctrl_panel:stopAllActions()
    ctrlpad.ctrl_panel:setScale(1)
    ctrlpad.ctrl_panel:setRotation(0)
    ctrlpad.ctrl_panel:setOpacity(255)
    local scale0 = ScaleTo:create(0.1,0.001)
    local rotate0 = RotateTo:create(0.1,-180)
    local spawn0 = Spawn:create({scale0,rotate0})
    local actionList = {spawn0,Hide:create(),CCCallFunc:create(function()
        ctrlpad:setVisible(false)
        ctrlpad.isShow = false
    end)}
    ctrlpad.ctrl_panel:runAction(CCSequence:create(actionList))

end


function TeamFightTeamView:showCtrlPad(ctrlpad)
    ctrlpad:setVisible(true)
    ctrlpad.ctrl_panel:setVisible(true)
    ctrlpad.ctrl_panel:stopAllActions()
    ctrlpad.ctrl_panel:setScale(0.001)
    ctrlpad.ctrl_panel:setRotation(-180)
    ctrlpad.ctrl_panel:setOpacity(255)
    local scale0 = ScaleTo:create(0.1,1)
    local rotate0 = RotateTo:create(0.1,0)
    local spawn0 = Spawn:create({scale0,rotate0})
    local actionList = {spawn0,CCCallFunc:create(function()
        ctrlpad.isShow = true
    end)}
    ctrlpad.ctrl_panel:runAction(CCSequence:create(actionList))
end

function TeamFightTeamView:runMatchingAction()
    if self.waitingLayer == nil then
        self.waitingLayer = require("lua.logic.teamFight.TeamWaitingTimer"):new()
        self.root_panel:addChild(self.waitingLayer,999)
    end
end

function TeamFightTeamView:stopMatchingAction()
    if self.waitingLayer ~= nil then
        self.waitingLayer:removeFromParent()
        self.waitingLayer = nil
    end
end
local SELECT_POS = {me.p(-22,0),me.p(22,0)}
local langCode = TFLanguageMgr:getUsingLanguage()
if (langCode == cc.SPANISH) then
    SELECT_POS = {me.p(-32,0),me.p(32,0)}
end

function TeamFightTeamView:initCommonPart()
    local nTeamType = TeamFightDataMgr.nTeamType
    --队友特效开关
    self.Image_show_effect = self.root_panel:getChildByName("Image_show_effect")
    self.Image_show_effect:getChildByName("Label_title"):setTextById(2100162 )
    local Image_show_effect_ctrl = self.Image_show_effect:getChildByName("Image_auto_bg")
    self.Image_on_show_effect =  Image_show_effect_ctrl:getChildByName("Image_on")
    Image_show_effect_ctrl:onClick(function()
        local status = SettingDataMgr:getAttactEffect()
        if status == 1  then
            status = 2
        else
            status = 1
        end
        SettingDataMgr:setAttactEffect(status)
        self.Image_on_show_effect:setPosition(SELECT_POS[status])
    end)
    --队友特效开关小贴士
    self.Image_show_effect_tip = self.root_panel:getChildByName("Image_show_effects_tip")
    self.Panel_show_effects_tip = self.Image_show_effect_tip:getChildByName("Panel_show_effects_tip")
    self.Panel_show_effects_tip:setVisible(false)
    self.Image_show_effect_tip:setTouchEnabled(true)
    self.Image_show_effect_tip:onTouch(function(event)
        local name   = event.name
        local target = event.target
        if name == "began" then
           self.Panel_show_effects_tip:setVisible(true)
        -- elseif name == "moved" then
        elseif name == "ended" then
            self.Panel_show_effects_tip:setVisible(false)
        end
    end)
    --队友特效显示判断
    if nTeamType == 5 then
        self.Image_show_effect:hide()
        self.Image_show_effect_tip:hide()
    else
        --self.Image_show_effect:show()
        if BattleUtils.isLowDevice() then 
            self.Image_show_effect_tip:show()
        else
            self.Image_show_effect_tip:hide()
        end
        local status = SettingDataMgr:getAttactEffect()
        self.Image_on_show_effect:setPosition(SELECT_POS[status])
    end



     --联机战斗自动准备开关准备
    self.Panel_auto_ready = self.root_panel:getChildByName("Panel_auto_ready")
    self.Panel_auto_ready:getChildByName("Label_title"):setTextById(190000183 )
    local Image_auto_ready_ctrl = self.Panel_auto_ready:getChildByName("Image_auto_bg")
    self.Image_on_auto_ready =  Image_auto_ready_ctrl:getChildByName("Image_on")
    Image_auto_ready_ctrl:onClick(function()
        local status = SettingDataMgr:getIsAutoReady()
        if status == 1  then
            status = 2
        else
            status = 1
        end
        SettingDataMgr:setIsAutoReady(status)
        self.isAutoReady = status == 1
        self.Image_on_auto_ready:setPosition(SELECT_POS[status])
        self:updateTeamPart()
    end)
    self.Image_on_auto_ready:setPosition(SELECT_POS[SettingDataMgr:getIsAutoReady()])
    ---------------------------------
    self.commonWidget = {}


    self.commonWidget["leader"] = {}
    self.commonWidget["leader"]["leader_root"] = self.root_panel:getChildByName("Image_public_bg")
    self.commonWidget["leader"]["leader_root"]:getChildByName("Label_title"):setTextById(2100068)
    local btn_bg = self.commonWidget["leader"]["leader_root"]:getChildByName("Image_auto_bg")
    self.commonWidget["leader"]["img_on"] = btn_bg:getChildByName("Image_on")
    self.commonWidget["leader"]["stat"] = 1
    self.commonWidget["leader"]["leader_root"]:setVisible(false)
    btn_bg:onClick(function()
        if TeamFightDataMgr:isAutoMatching() == true then
            self.commonWidget["leader"]["img_on"]:setPosition(me.p(22,0))
            TeamFightDataMgr:requestChangeTeamStatus(1)
        else
            self.commonWidget["leader"]["img_on"]:setPosition(me.p(-22,0))
            TeamFightDataMgr:requestChangeTeamStatus(2)
        end
    end)

    self.commonWidget["leader"]["Image_in_team"] = self.root_panel:getChildByName("Image_in_team")
    local btn_bg = self.commonWidget["leader"]["Image_in_team"]:getChildByName("Image_auto_bg")
    self.commonWidget["leader"]["img_inteam_on"] = btn_bg:getChildByName("Image_on")
    self.commonWidget["leader"]["Image_in_team"]:setVisible(false)
    btn_bg:onClick(function()

    end)

    self.commonWidget["common"] = {}
    self.commonWidget["common"]["btn_c_r_g"] = self.root_panel:getChildByName("Button_c_r_g")
    self.commonWidget["common"]["btn_title"] = self.commonWidget["common"]["btn_c_r_g"]:getChildByName("Label_title")
    self.commonWidget["common"]["btn_animTip"] = self.commonWidget["common"]["btn_c_r_g"]:getChildByName("Spine_guide")
    self.commonWidget["common"]["stat"] = 1
    self.commonWidget["common"]["btn_c_r_g"]:onClick(function()
        if self.commonWidget["common"]["stat"] == 4 then
            local limitMember = self.curLevelCfg.countLimit
            local teamMemberCount = 0
            for k,v in pairs(self.teamInfoData) do
                if v then
                    teamMemberCount = teamMemberCount + 1
                end
            end
            if teamMemberCount >= limitMember then
                TeamFightDataMgr:requestStartFightInfo()
                self:stopMatchingAction()
                self.commonWidget["common"]["btn_animTip"]:setVisible(false)
            else
                Utils:showError(2100067,tostring(limitMember))
            end
        elseif self.commonWidget["common"]["stat"] == 1 then
            self:openChangeHeroView()
        elseif self.commonWidget["common"]["stat"] == 2 then
            TeamFightDataMgr:requestMemberReady(2)
        elseif self.commonWidget["common"]["stat"] == 3 then
            TeamFightDataMgr:requestMemberReady(1)
            self.isAutoReady = false
        elseif self.commonWidget["common"]["stat"] == 5 then
            Utils:showError(TextDataMgr:getText(240016))
        end
    end)


    self.commonWidget["open_desc"] = self.root_panel:getChildByName("Image_limit"):getChildByName("Label_limit_val")
end

function TeamFightTeamView:openChangeHeroView( ... )
   
    local list = {}
    if self.curLevelCfg.showhero then
        for k,v in ipairs(self.curLevelCfg.showhero) do
            local t = {id = v, limitId = self.curLevelCfg.heroLimitID[k]}
            table.insert(list,t)
        end
    end

    TeamFightDataMgr:openChangeHeroView(list)
end

function TeamFightTeamView:updateSwitchInRoomState()
    if self.isTeamLeader == true then
        --TODO CLOSE
        --self.commonWidget["leader"]["Image_in_team"]:setVisible(TeamFightDataMgr.nTeamType ~= EC_NetTeamType.Hunter)
        self.commonWidget["leader"]["Image_in_team"]:hide()
        local showInList = TeamFightDataMgr:isShowInRoomList()
        if showInList  == true then
            self.commonWidget["leader"]["img_inteam_on"]:setPosition(me.p(-22,0))
        else
            self.commonWidget["leader"]["img_inteam_on"]:setPosition(me.p(22,0))
        end

    else
        --TODO CLOSE
        --self.commonWidget["leader"]["Image_in_team"]:setVisible(false)
        self.commonWidget["leader"]["Image_in_team"]:hide()
    end
end

function TeamFightTeamView:refreshView()
    self:onRedPointUpdateChat()
end

function TeamFightTeamView:checkTeamBuff()
    local buffIds = {}
    if TeamFightDataMgr.nTeamType == 8 then  --挑战活动buff
        local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BOSS_CHALLENGE)[1]
        if activityId then 
            local activityInfo = ActivityDataMgr2:getActivityInfo(activityId) 
            local addBuff = activityInfo.extendData.addBuff or {}
            for i,v in ipairs(self.teamInfoData) do
                if addBuff[v.heroCid] and addBuff[v.heroCid][v.heroQuality] then
                    buffIds[v.heroCid] = addBuff[v.heroCid][v.heroQuality]
                end 
            end
        end
    end
    return buffIds
end

function TeamFightTeamView:updateTeamPart()
    local buffIds = self:checkTeamBuff()
    local isTeamFull = true
    local isHuntingModelPos = self.teamMaxCount > 3 
    for i = 1,self.teamMaxCount do
        local _pid =self.teamItems[i]._pid
        local tmpHero = self.teamInfoData[i]
        if tmpHero and table.count(HeroDataMgr:getHero(tmpHero.heroCid)) > 0 then
            --TODO 需要找服务器同学下发skinId
            local heroData = HeroDataMgr:getHero(tmpHero.heroCid)

            self.teamItems[i]["player"]["panel_element"]:show()
            PrefabDataMgr:setInfo(self.teamItems[i]["player"]["panel_element"] , heroData.magicAttribute)

            Utils:createTeamHeroModel(tmpHero.heroCid, self.teamItems[i]["player"]["hero"],tmpHero.skinCid,isHuntingModelPos)
            self.teamItems[i]["player"]["hero"]:setVisible(true)
            self.teamItems[i]["player"]["hero_box"]:setVisible(true)
            self.teamItems[i]["player"]["leader_logo"]:setVisible(tmpHero.pid == TeamFightDataMgr:getLeaderId())
            self.teamItems[i]["player"]["leader_bg"]:setVisible(tmpHero.pid == MainPlayer:getPlayerId())
            -- self.teamItems[i]["player"]["Lv_bg"]:setVisible(true)
            -- self.teamItems[i]["player"]["Lv_value"]:setVisible(true)
            -- self.teamItems[i]["player"]["Lv_value"]:setString("Lv."..tmpHero.heroLevel)
            self.teamItems[i]["player"]["name"]:setVisible(true)
            self.teamItems[i]["player"]["name"]:setString(tmpHero.name)
            
            self.teamItems[i]["player"]["Image_fightPower"]:show()
            self.teamItems[i]["player"]["Label_fightPower"]:show()
            self.teamItems[i]["player"]["Label_fightPower"]:setText(tostring(tmpHero.fightPower))
            if tmpHero.heroQuality then
                self.teamItems[i]["player"]["quality"]:setTexture(HeroDataMgr:getQualityPic(nil,tmpHero.heroQuality))
                self.teamItems[i]["player"]["quality"]:setVisible(true)
            end
            self.teamItems[i]["player"]["empty"]:setVisible(false)
            local skinInfo = TabDataMgr:getData("HeroSkin", tmpHero.skinCid)
            self.teamItems[i]["player"]["hero_bg"]:setTexture(skinInfo.backdrop)
            self.teamItems[i]["player"]["hero_bg"]:setVisible(true)
            self.teamItems[i]["player"]["Image_buff_up"]:setVisible(buffIds[tmpHero.heroCid] ~= nil)

            if tmpHero.pid == TeamFightDataMgr:getLeaderId() then
                if tmpHero.pid == MainPlayer:getPlayerId() then
                    self.teamItems[i]["stat"]["value"] = 5
                else
                    self.teamItems[i]["stat"]["value"] = 2
                end

            else
                if tmpHero.status == 1 then
                    self.teamItems[i]["stat"]["value"] = 2
                else
                    self.teamItems[i]["stat"]["value"] = 3
                end
            end
            if tmpHero.pid == self.myHeroInfo.pid then
                self.teamItems[i]["player"]["repeat_tip"]:setVisible(self.isRepeatWithOther)
                if self.isRepeatWithOther == true then
                    self.teamItems[i]["stat"]["value"] = 4
                end
            end
            self.teamItems[i]._pid = tmpHero.pid
        else
            self.teamItems[i]["stat"]["value"] = 1
            for k,v in pairs(self.teamItems[i]["player"]) do
                v:setVisible(false)
            end
            self.teamItems[i]["player"]["empty"]:setVisible(true)
            isTeamFull = false
            self.teamItems[i]._pid = -1
        end
        if self.teamItems[i]._pid ~= _pid then 
            self:hideCtrlPad(self.teamItems[i]["ctrl"]["ctrl_root"])
        end
        local tmheroStatShow = self.teamItemsStatShow[self.teamItems[i]["stat"]["value"]]
        self.teamItems[i]["player"]["repeat_tip"]:setVisible(tmheroStatShow.warning)
        self.teamItems[i]["player"]["ready"]:setVisible(tmheroStatShow.ready)
        self.teamItems[i]["player"]["getting_ready"]:setVisible(tmheroStatShow.unready)


        local ctrl_stat = 2
        if self.teamItems[i]["stat"]["value"] == 1 then
            ctrl_stat = 2
        elseif self.teamItems[i]["stat"]["value"] == 2 or self.teamItems[i]["stat"]["value"] == 3 then
            ctrl_stat = 1
        else

        end
        local ctrlPadCfg = self.teamItemCtrlCfg[ctrl_stat]
        for j = 1,3 do
            self.teamItems[i]["ctrl"]["btn_logo"..j]:setTexture(ctrlPadCfg[j].img)
            self.teamItems[i]["ctrl"]["btn_title"..j]:setTextById(ctrlPadCfg[j].txt)
            self.teamItems[i]["ctrl"]["btn_"..j]:setTextureNormal(ctrlPadCfg[j].btnRes)
            self.teamItems[i]["ctrl"]["btn_"..j]:setPositionY(ctrlPadCfg[j].posY)

            local timeoutLabel = self.teamItems[i]["ctrl"]["btn_"..j]:getChildByTag(9798)
            if timeoutLabel then
                timeoutLabel:removeFromParent()
            end
            
            if ctrl_stat == 1 and self.isTeamLeader == false then
                if j == 2 or j == 3 then
                    self.teamItems[i]["ctrl"]["btn_"..j]:setGrayEnabled(true)
                    self.teamItems[i]["ctrl"]["btn_"..j]:setTouchEnabled(false)
                end
            elseif ctrl_stat == 2 and self.isTeamLeader == false then
                self.teamItems[i]["ctrl"]["btn_"..j]:setGrayEnabled(true)
                self.teamItems[i]["ctrl"]["btn_"..j]:setTouchEnabled(false)

            else
                local disableInvite = self.curLevelCfg.disableInvite and self.curLevelCfg.disableInvite[j]
                if ctrl_stat == 2 then 
                    if self.curLevelCfg.type == 5 then --追猎计划 屏蔽好友和公用邀请
                        if j > 1 then 
                            disableInvite = true
                        end
                   
                    end 

                    -- TODO CLOSE 禁用社团邀请
                    if (not GlobalFuncDataMgr:isOpen(5)) then
                        if (j == 1) then 
                            disableInvite = true
                        end
                    end

                    self.teamItems[i]["ctrl"]["btn_"..j]:setGrayEnabled(disableInvite)
                    self.teamItems[i]["ctrl"]["btn_"..j]:setTouchEnabled(not disableInvite)
                else
                    self.teamItems[i]["ctrl"]["btn_"..j]:setGrayEnabled(false)
                    self.teamItems[i]["ctrl"]["btn_"..j]:setTouchEnabled(true)
                end


                if self.teamItems[i]["stat"]["value"] == 1 and self.isTeamLeader == true and ctrl_stat == 2 then
                    --检测邀请冷却

                    local reporttime
                    if j == 1 then
                        reporttime = TeamFightDataMgr:getLastClubInviteTime()

                    elseif j == 3 then
                        reporttime = TeamFightDataMgr:getLastPublicInviteTime()
                    else

                    end
                    if j ~= 2 then
                        if reporttime.lastSendTime and not disableInvite then
                            local curtime = ServerDataMgr:getServerTime()
                            local difftime = curtime - reporttime.lastSendTime

                            if difftime < self.inviteTimeCool then
                                timelong = reporttime.lastSendTime + self.inviteTimeCool - curtime
                                Utils:makeCDProgressBar(self.teamItems[i]["ctrl"]["btn_"..j],timelong,self.teamItems[i]["ctrl"]["btn_"..j]:getTextureNormalName())
                            end
                        end
                    end
                end
            end
        end
        --不是队长，暂时不准邀请
        if self.teamItems[i]["stat"]["value"] == 1 then
            self.teamItems[i]["player"]["empty"]:getChildByName("Button_add"):setVisible(self.isTeamLeader)
        end

    end
    if table.count(buffIds) > 0 then
        self.Image_buff_tip:setVisible(true)
        local cid,buffId = next(buffIds)
        local bufferCfg = TabDataMgr:getData("Buffer",buffId)
        self.Label_buff_tip:setText(bufferCfg and bufferCfg.des or "")
    else
        self.Image_buff_tip:setVisible(false)
    end
    if TeamFightDataMgr:isAutoMatching() == true and isTeamFull == false then
        --匹配中
        self:runMatchingAction()
    else
        self:stopMatchingAction()
    end

    print(self.isAutoReady  ,  self.isRepeatWithOther , self.commonWidget["common"]["stat"] , "6666666666666")
    if self.isAutoReady == true and self.isRepeatWithOther == false then
        if self.commonWidget["common"]["stat"] == 1 or self.commonWidget["common"]["stat"] == 2 then
            TeamFightDataMgr:requestMemberReady(2)
        end
    end

    self.Panel_auto_ready:setVisible(not self.isTeamLeader)

end

function TeamFightTeamView:updateCommonPart()
    if self.isRepeatWithOther == true then
        self.commonWidget["common"]["stat"] = 1
    else
        if self.isTeamLeader == true then
            local isCanStart = true
            for k,v in pairs(self.teamInfoData) do
                if v.pid ~= MainPlayer:getPlayerId() then
                    if v.status == 1 then
                        isCanStart = false
                        break
                    end
                end
            end
            if isCanStart == true then
                self.commonWidget["common"]["stat"] = 4
            else
                self.commonWidget["common"]["stat"] = 5
            end
        else
            if self.myHeroInfo.status == 1 then
                self.commonWidget["common"]["stat"] = 2
            else
                self.commonWidget["common"]["stat"] = 3
            end
        end
    end
    if self.isTeamLeader == true then

        self.commonWidget["leader"]["leader_root"]:setVisible(TeamFightDataMgr.nTeamType == EC_NetTeamType.Hunter and not self.curLevelCfg.allowMate and not self.curLevelCfg.disableMatch)

        local isAutoMatch = TeamFightDataMgr:isAutoMatching()
        if isAutoMatch == true then
            self.commonWidget["leader"]["img_on"]:setPosition(me.p(-22,0))
        else
            self.commonWidget["leader"]["img_on"]:setPosition(me.p(22,0))
        end
    else
        self.commonWidget["leader"]["leader_root"]:setVisible(false)
    end

    -- if self.commonWidget["common"]["stat"] ~= 5 then
        if self.commonWidget["common"]["stat"] == 3 then
            EventMgr:dispatchEvent(EV_TEAM_CLOSE_HERO_CHANGE_VIEW)
        end
        local bottomBtnCfg = self.teamRB_btn_title[self.commonWidget["common"]["stat"]]
        self.commonWidget["common"]["btn_c_r_g"]:setTextureNormal(bottomBtnCfg.img)
        self.commonWidget["common"]["btn_title"]:setTextById(bottomBtnCfg.txt)
        self.commonWidget["common"]["btn_title"]:setColor(bottomBtnCfg.color)
        self.commonWidget["common"]["btn_animTip"]:setVisible(bottomBtnCfg.animtip)
    -- else
    --     local bottomBtnCfg = self.teamRB_btn_title[4]
    --     self.commonWidget["common"]["btn_c_r_g"]:setTextureNormal(bottomBtnCfg.img)
    --     self.commonWidget["common"]["btn_title"]:setTextById(bottomBtnCfg.txt)
    --     self.commonWidget["common"]["btn_title"]:setColor(bottomBtnCfg.color)
    --     self.commonWidget["common"]["btn_animTip"]:setVisible(bottomBtnCfg.animtip)
    -- end
    local memberNumLimit = self.curLevelCfg.countLimit
    self.commonWidget["open_desc"]:setText(tostring(memberNumLimit))
   
    self:updateSwitchInRoomState()

end

function TeamFightTeamView:onHandleTeamData()
    self.btns_click_enable = false
    self.teamInfoData = TeamFightDataMgr:getTeamInfo()
    local mypid = MainPlayer:getPlayerId()
    self.isTeamLeader = (mypid == TeamFightDataMgr:getLeaderId())
    for k,v in pairs(self.teamInfoData) do
        if mypid == v.pid then
            self.myHeroInfo = v
            break
        end
    end
    --检查重复精灵
    self.isRepeatWithOther = false

    if not self.curLevelCfg.ignoreRepeat then -- 忽略重复英雄
        for k,v in pairs(self.teamInfoData) do
            if mypid ~= v.pid then
                if HeroDataMgr:getHeroRoleId(v.heroCid) == HeroDataMgr:getHeroRoleId(self.myHeroInfo.heroCid) then
                    self.isRepeatWithOther = true
                    break
                end
            end
        end
    end
    self:updateTeamPart()
    self:updateCommonPart()
    self.btns_click_enable = true
end

function TeamFightTeamView:onBeKickout()
    local isLayerInQueue,layer = AlertManager:isLayerInQueue("TeamRoomSettingView")
    if isLayerInQueue then
        AlertManager:closeLayer(layer)
    end
    AlertManager:closeLayer(self)
    Utils:showTips(2100094)
end

function TeamFightTeamView:onTeamTimeout()
    local isLayerInQueue,layer = AlertManager:isLayerInQueue("TeamRoomSettingView")
    if isLayerInQueue then
        AlertManager:closeLayer(layer)
    end
    AlertManager:closeLayer(self)
    Utils:showTips(2100119)
end

---刷新共鸣技能列表
function TeamFightTeamView:updateGMSkill()
    
    local infos = ResonanceDataMgr:getEquipedSkills()
    if not infos then
        return
    end

    for k,v in ipairs(self.gmSkill_) do
        local equipedCid = infos[k]
        local cfg = ResonanceDataMgr:getManaResonanceCfg(equipedCid)
        if cfg then
            self.gmSkill_[k].iconBg:show()
            self.gmSkill_[k].skillIcon:setTexture(cfg.icon)
        else
            self.gmSkill_[k].iconBg:hide()
            self.gmSkill_[k].skillIcon:setTexture("")
        end
    end
end

function TeamFightTeamView:funcCloseNotice(data)
    if data.switchType == EC_FunctionEnum.TEAM_FIGHT and data.open == false then
        TeamFightDataMgr:requestExitTeam()
        AlertManager:closeLayer(self)
        AlertManager:changeScene(SceneType.MainScene)
    end
end
function TeamFightTeamView:onShow()
    self.super.onShow(self)
end

function TeamFightTeamView:handleTeamChat(chatInfo)
    if not chatInfo then
        return
    end
    if chatInfo.channel == 5 and chatInfo.fun == 1 then
        local teamMembers = TeamFightDataMgr:getTeamInfo()
        for k,v in pairs(teamMembers) do
            if v.pid == chatInfo.pid then
                self.teamItems[k]["player"]["msg_bg"]:stopAllActions()
                self.teamItems[k]["player"]["msg"]:setString(chatInfo.content)
                self.teamItems[k]["player"]["msg_bg"]:setVisible(true)
                self.teamItems[k]["player"]["msg"]:setVisible(true)
                local delaytime = CCDelayTime:create(3);
                local callfunc = CCCallFunc:create(function()
                    self.teamItems[k]["player"]["msg_bg"]:setVisible(false)
                end)
                self.teamItems[k]["player"]["msg_bg"]:runAction(CCSequence:create({delaytime,callfunc}))
            end
        end
    end
end

function TeamFightTeamView:onRedPointUpdateChat()
    local readState = ChatDataMgr:getReadState()
    self.chat_img:getChildByName("Image_redPoint"):setVisible(not readState)
end

function TeamFightTeamView:onClickBack( sender )
    if self.isReqCloseLayer == true then
        return true
    end
    local alertparams = clone(EC_GameAlertParams)
    alertparams.msg = 2100111
    alertparams.comfirmCallback = function()
        self.isReqCloseLayer = true
        TeamFightDataMgr:requestExitTeam()
    end
    showGameAlert(alertparams)
end

function TeamFightTeamView:onClickMain( sender )
    if self.isReqGoMain == true then
        return true
    end
    local alertparams = clone(EC_GameAlertParams)
    alertparams.msg = 2100111
    alertparams.comfirmCallback = function()
        self.isReqGoMain = true
        TeamFightDataMgr:requestExitTeam()

    end
    showGameAlert(alertparams)
    return true
end

function TeamFightTeamView:onExitTeamEvent()
    HeroDataMgr:changeDataToSelf()
    if self.isReqCloseLayer == true then
        AlertManager:closeLayer(self)
        return
    end
    if self.isReqGoMain == true then
        AlertManager:changeScene(SceneType.MainScene)
        return
    end

    if self.curLevelCfg.allowQuit then
        Utils:showTips(240038)
        local isLayerInQueue,layer = AlertManager:isLayerInQueue("TeamRoomSettingView")
        if isLayerInQueue then
            AlertManager:closeLayer(layer)
        end
        AlertManager:closeLayer(self)
        return
    end

end

function TeamFightTeamView:onRecvTeamMemberInfo(memberInfo)
    local view = requireNew("lua.logic.chat.PlayerInfoView"):new(memberInfo,"teamFight")
    AlertManager:addLayer(view,AlertManager.BLOCK_AND_GRAY_CLOSE)
    AlertManager:show()
end

function TeamFightTeamView:specialKeyBackLogic( )
    self:panelTouchFunc()
    return true
end

function TeamFightTeamView:hunterTeamFightError( )
    Utils:showTips(112000198)
    self.commonWidget["common"]["btn_c_r_g"]:setTouchEnabled(false)   
    self.commonWidget["common"]["btn_c_r_g"]:setGrayEnabled(true)   
end



function TeamFightTeamView:updateHandleInfo()

    self.Image_match_state:setVisible(true)

    ---自动匹配
    local isAutoMatch = TeamFightDataMgr:isAutoMatching()
    local text = isAutoMatch and 2101402 or 2101403
    self.Label_match_state:setTextById(text)
    self.Image_match_state_icon:setVisible(isAutoMatch)

    ---队友特效
    local status = SettingDataMgr:getAttactEffect()
    local text = status == 1 and 2101402 or 2101403
    self.Label_effect_state:setTextById(text)
    self.Image_effect_state_icon:setVisible(status == 1)

    ---等级限制
    local minLv = TeamFightDataMgr:getLimitLevel()
    self.Label_limit_lv:setText(minLv)

    local curVisibleType = TeamFightDataMgr:getTeamRoomVisibleType()
    self.Image_visibleTypeIcon:setTexture(self.visiblePic[curVisibleType])
end

function TeamFightTeamView:registerEvents()
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_TEAM_DATA, handler(self.onHandleTeamData, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_NOTIFY_KICK_OUT_TEAM, handler(self.onBeKickout, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_EXIT_TEAM, handler(self.onExitTeamEvent, self))
    EventMgr:addEventListener(self, EV_RED_POINT_UPDATE_CHAT,handler(self.onRedPointUpdateChat, self))
    EventMgr:addEventListener(self, EV_RECV_CHATINFO,handler(self.handleTeamChat, self))
    EventMgr:addEventListener(self, EV_FUNC_STATE_CHANGE,handler(self.funcCloseNotice,self))
    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onRecvTeamMemberInfo, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_TEAMTIME_OUT_TEAM, handler(self.onTeamTimeout, self))
    EventMgr:addEventListener(self, EV_TEAM_RUN_BATTLE_SCENE,handler(self.stopMatchingAction,self))
    EventMgr:addEventListener(self, EV_TEAM_IS_SHOWINROOM,handler(self.updateSwitchInRoomState,self))
    EventMgr:addEventListener(self, EV_FUBEN_UPDATE_LIMITHERO, handler(self.onLimitHeroEvent, self))
    EventMgr:addEventListener(self, EV_AFTER_HANDLE_GM_SKILL, handler(self.updateGMSkill, self))
    EventMgr:addEventListener(self, EV_UPDATE_TEAM_HANDLE, handler(self.updateHandleInfo, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_TEAM_DATA, handler(self.updateHandleInfo, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_HALLOWEEN_PASS_RSP, handler(self.updateBuffInfos, self))
    self.chat_img:onClick(function()
        local ChatView = require("lua.logic.chat.ChatView")
        ChatView.show(nil,false,true)
    end)
    self.btn_speak:onClick(function()
        self:speaksRefresh()
    end)
    self.panel_speaks:onClick(function()
        self:speaksRefresh()
    end)

    self.Button_help:onClick(function ( ... )
        Utils:openView("osd.TeamLevelHelpView",self.curLevelCfg.type,self.curLevelCfg.id)
    end)
    --返回
    self:setBackBtnCallback(handler(self.onClickBack,self))
    --主页
    self:setMainBtnCallback(handler(self.onClickMain,self))
    local dungenCfg = self.curLevelCfg
    local affixIDs = {}
    if dungenCfg.affixID and dungenCfg.affixID > 0 then
        table.insert(affixIDs,dungenCfg.affixID)
    elseif dungenCfg.affixIDs then
        affixIDs = clone(dungenCfg.affixIDs)
    end
    if #affixIDs > 0 then
        self.Button_preview:setTouchEnabled(true)
        self.Button_preview:show()
        self.Button_preview:onClick(function()
            Utils:openView("osd.AffixPreviewLayer",affixIDs)
        end)
    else
        self.Button_preview:setTouchEnabled(false)
        self.Button_preview:hide()
    end

    for k,v in ipairs(self.gmSkill_) do
        v.btn:onClick(function()
            FunctionDataMgr:jGMSkill()
        end)
    end

    self.Panel_room_hadle:onClick(function()
        Utils:openView("teamFight.TeamRoomSettingView",false,self.curLevelCfg.type)
    end)
end

function TeamFightTeamView:addScrollBarFunction(panelSpeak )
    local Image_scrollBarModel = TFImage:create("ui/common/scroll_bar_01.png")
    Image_scrollBarModel:setScale9Enabled(true)
    Image_scrollBarModel:setContentSize(CCSize(6 , 326))
    local Image_scrollBarInner = TFImage:create("ui/common/scroll_bar_02.png")
    Image_scrollBarInner:setScale9Enabled(true)
    Image_scrollBarInner:setContentSize(CCSize(6 , 326))
    Image_scrollBarModel:addChild(Image_scrollBarInner , 1)
    Image_scrollBarInner:setPosition(0 , 163)


    panelSpeak:addChild(Image_scrollBarModel , 1)
    Image_scrollBarModel:setPosition(362 , 0)
    Image_scrollBarModel:setAnchorPoint(ccp(0.5 , 0))
    local bar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.speak_listView:setScrollBar(bar)
end
return TeamFightTeamView