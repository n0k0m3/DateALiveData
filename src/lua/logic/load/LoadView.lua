local ResLoader = require("lua.logic.battle.ResLoader")
local enum      = require("lua.logic.battle.enum")
local eEvent    = enum.eEvent
local LoadView  = class("LoadView", BaseLayer)
local textIds   = {300160,300161,300162,300163}

local INIT_POSITION_X =    
 {
        {-112.00},
        {-225,0},
        {-112 - 225 , -112, -112 + 225 },
        {-225 - 225 , -225, 0 , 225},
        {
        -112 - (225 ) *2, 
        -112 - (225 ), 
        -112, 
        -112 + (225 ) , 
        -112 + (225 ) *2
    }
    }
function LoadView:ctor()
    self.super.ctor(self)
    self:init("lua.uiconfig.load.LoadView")
    self:addMEListener(TFWIDGET_CLEANUP, handler(self._onCleanup,self))
end

function LoadView:initUI(ui)
    self.super.initUI(self,ui)
    

    self.prefabe_panel_role  = TFDirector:getChildByPath(ui,"Panel_role1"):hide()
    self.Panel_team = TFDirector:getChildByPath(ui,"Panel_team")
    self.image_bg_normal     = TFDirector:getChildByPath(ui,"Image_bg_normal")

    self.Image_xts = TFDirector:getChildByPath(self.image_bg_normal ,"Image_xts")

    -- self.image_bg_teamMore = TFDirector:getChildByPath(ui,"Image_bg_team"):hide()--4/5人
    -- self.image_bg_teamMore._size = 5
    -- self.image_bg_teamMore._pos    = 
    -- {
    --     {-115.00},
    --     {-340.00, 106.00,},
    --     {-340.00, -115.00, 106.00},
    --     {-568.00  + 110, -340.00 +110, -115.00 + 110, 106.00 + 110},
    --     {-568.00, -340.00, -115.00, 106.00, 339.00}
    -- }

    -- self.image_bg_teamMore._texture = "ui/battle/load/006_1.png"
    -- self.image_bg_team     = TFDirector:getChildByPath(ui,"Image_bg_team1"):hide() --小于四人显示
    -- self.image_bg_team._size = 3
    -- self.image_bg_team._texture = "ui/battle/load/106_1.png"
    -- self.image_bg_team._pos    = 
    -- {
    --     {-200},
    --     {-568.00  +200 -30, -200 + 200 -30},
    --     {-568.00, -200,162}
    -- }

    local pDirector = CCDirector:sharedDirector();
    local frameSize = pDirector:getOpenGLView():getFrameSize();
    local baseSize = CCSize(1136 , 640);
    self.realSize = CCSize(math.ceil(frameSize.width * baseSize.height / frameSize.height) , baseSize.height);


    self.label_tip         = TFDirector:getChildByPath(ui,"Label_tip")
    self.label_percent     = TFDirector:getChildByPath(ui,"Label_percent")
    self.loadingBar        = TFDirector:getChildByPath(ui,"LoadingBar")
    self.Image_bg          = TFDirector:getChildByPath(ui,"Panel_base")
    self.panel_load        = TFDirector:getChildByPath(ui,"Panel_load")
    

    self.loadingBar:setPercent(0)
    self.label_percent:setText("Loading...0%")
    self.label_tip:show()
    self.label_percent:hide()
    --日常 组队 试炼 3
    --剧情副本31-37  章节(1-7)
    --38 无尽 -- 39卡巴拉
    -- local levelCid  = BattleDataMgr:getCurLevelCid()
    -- Box("levelCid:"..tostring(levelCid))
    local fubenType = FubenDataMgr:getCacheSelectFubenType()
    local adType = 3
    if fubenType == EC_FBType.PLOT then --剧情副本
        local chapterCid =  FubenDataMgr:getCacheSelectChapter()
        local config = TabDataMgr:getData("DungeonChapter",chapterCid)
        adType = 30 + config.order
        -- Box("adType1:"..tostring(adType))
    elseif fubenType == EC_FBType.DAILY then --日常副本
        adType = 3
        -- Box("adType2:"..tostring(adType))
    elseif fubenType == EC_FBType.ACTIVITY then --活动作战
        local chapterCid =  FubenDataMgr:getCacheSelectChapter() 
        if chapterCid == EC_ActivityFubenType.ENDLESS then    --401无尽副本
            adType = 38
                       -- Box("adType3:"..tostring(adType))
        elseif chapterCid == EC_ActivityFubenType.TEAM then   --402,    -- 组队副本
            adType = 3
                       -- Box("adType4:"..tostring(adType))
        elseif chapterCid == EC_ActivityFubenType.KABALA then --403,   --卡巴拉
            adType = 39
                       -- Box("adType5:"..tostring(adType))
        elseif chapterCid == EC_ActivityFubenType.SPRITE then --404,    -- 精灵挑战
            adType = 3
                       -- Box("adType6:"..tostring(adType))
        end
    elseif fubenType == EC_FBType.HOLIDAY then --节日活动
        local chapterCid =  FubenDataMgr:getCacheSelectChapter() 
        if chapterCid == EC_ActivityFubenType.HALLOWEEN then    --节日活动
            adType = 40
        end
    end     


    --是否组队模式
    local data = BattleDataMgr:getBattleData()
    if data and data.battleType == EC_BattleType.TEAM_FIGHT then
        -- self.label_tip:hide()
        self.bLockStep = true 
        --组队模式根据角色数量创建
        self:initRoleList(data.heros,data.leader)
        if #data.heros > 1 then
            self:randomAD(adType)
            self.panel_load:hide()
            self.Panel_team:show()
        else
            self:randomAD(adType,true)
            self.panel_load:show()
            self.Panel_team:hide()
        end

    else
        self:randomAD(adType,true)
        self.panel_load:show()
        self.Panel_team:hide()
    end

    --适配处理
    local img = self.Image_bg:getBackGroundImage()
    local size = img:getSize();
    if self.realSize.width > 1386 and size.width == 1386 and size.height == 640 then
        img:setSize(self.realSize)
    elseif self.realSize.width > 1386 and size.width == 1386 then
        img:setSize(CCSizeMake(self.realSize.width,size.height))
    end
end

function LoadView:randomAD(adType,randomBackgrond)
    local res , desIds = Utils:randomAD(adType)
    if randomBackgrond then 
        self.Image_bg:setBackGroundImage(res)
    end
    if desIds and  #desIds > 1 then
        table.sort(desIds)
        local textId = math.random(desIds[2] - desIds[1]) - 1 + desIds[1]
        local text   = TextDataMgr:getText(textId)
        self.label_tip:show()
        self.Image_xts:show()
        self.label_tip:setText(string.format("<%s>",text))
    else
        -- dump("ADWeight error adType:"..tostring(adType))
        -- local textId = textIds[math.random(#textIds)]
        -- local text   = TextDataMgr:getText(textId)
        -- self.label_tip:setText(string.format("<%s>",text))
        self.label_tip:hide()
        self.Image_xts:hide()
    end
end


function LoadView:setLoadBarPercent(panel_role,percent)
    local size = panel_role.load_percent:getSize()
    panel_role.load_percent:setPercent(percent)
    panel_role.label_percent:setText(string.format("%s",percent))
    panel_role.Image_ok:setVisible(percent>99)
    -- panel_role.label_percent_p:setFontColor()
    -- panel_role.label_percent:setFontColor()
    panel_role.label_percent_p:setVisible(percent<100)
    panel_role.label_percent:setVisible(percent<100)
    if percent > 99 and not panel_role.Spine_effect.played then
        panel_role.Spine_effect.played = true
        panel_role.Spine_effect:playByIndex(2,0)
        panel_role.Spine_effect:show()
        panel_role.Spine_effect:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
            panel_role.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
            panel_role.Spine_effect:hide()

        end)
    end

end

--组队模式下创建角色列表
function LoadView:initRoleList(heros,leader)
    self.roleList = {}
    local size = #heros
    local posX = INIT_POSITION_X[size]
    for index =1,size do
        local panel_role = self.prefabe_panel_role:clone():show()
        self.Panel_team:addChild(panel_role)
        panel_role:setPositionX(posX[index],60)

        local heroData = heros[index]

        panel_role.Image_back            = TFDirector:getChildByPath(panel_role,"Image_back")
        panel_role.Image_role            = TFDirector:getChildByPath(panel_role,"Image_role")
        panel_role.Image_leader_parent   = TFDirector:getChildByPath(panel_role,"Image_leader_parent") --是否是队长

        panel_role.Image_front004 = TFDirector:getChildByPath(panel_role,"Image_front004")
        panel_role.load_percent  = TFDirector:getChildByPath(panel_role,"Load_per")
        panel_role.label_percent = TFDirector:getChildByPath(panel_role,"Label_per")
        panel_role.label_percent_p = TFDirector:getChildByPath(panel_role,"Label_per_p")
        panel_role.Image_ok = TFDirector:getChildByPath(panel_role,"Image_ok"):hide()
        panel_role.label_name    = TFDirector:getChildByPath(panel_role,"Label_name")
        panel_role.Label_fight    = TFDirector:getChildByPath(panel_role,"Label_fight")  
        panel_role.Spine_effect   = TFDirector:getChildByPath(panel_role,"Spine_effect")  

        if heroData then
            self.roleList[heroData.pid] = panel_role
            -- dump(heroData)
            -- Box("aa")
            panel_role.Image_back:setTexture(heroData.backdrop)
            panel_role.Image_leader_parent:setVisible(heroData.pid == leader)
            panel_role.Image_front004:setVisible(heroData.pid == MainPlayer:getPlayerId())
            local skinData = TabDataMgr:getData("HeroSkin",heroData.skinId)
            panel_role.Image_role:setTexture(skinData.teamPic)
            panel_role.Image_role:setScale(skinData.pos.scale or 1)
            local pos = panel_role.Image_role:getPosition()
            pos.x = pos.x + (skinData.pos.x or 0)
            pos.y = pos.y + (skinData.pos.y or 0)
            panel_role.Image_role:setPosition(pos)
            panel_role.label_name:setText(heroData.pname)
            local fightPower = TeamFightDataMgr:getFightPower(heroData.pid)
            panel_role.Label_fight:setText(fightPower)
            if heroData.titleId and heroData.titleId > 0 then
                local effect = TitleDataMgr:getTitleEffectSkeletonModle(heroData.titleId,3)
                effect:setPosition(ccp(104,84))
                panel_role:addChild(effect,100)
            end
        end
        self:setLoadBarPercent(panel_role,0)
    end
end

function LoadView:refreshLoadProgress(id,percent)
    local panel_role = self.roleList[id]
    if panel_role then
        self:setLoadBarPercent(panel_role,percent)
    end
end


function LoadView:onStatusChange(percent)
    local percent = math.floor(percent)
    self.loadingBar:setPercent(percent)
    self.label_percent:setText(string.format("Loading...%s%%",percent))

    if self.bLockStep then
        local playerId = MainPlayer:getPlayerId()
        self:refreshLoadProgress(playerId,percent)
        if self.nLoadPercent ~= percent then
            if percent%5 == 0 or percent == 100 then  
                LockStep.sendLoadPercent(percent)
            end
        end
        self.nLoadPercent = percent
    end
end

--更新玩家进度
function LoadView:onTeamPlayerLoadProgress(progressList)
    for i , player in ipairs(progressList) do
        if player.pid ~= MainPlayer:getPlayerId() then --把自己排除掉
            self:refreshLoadProgress(player.pid,player.progress)
        end
    end
end


function LoadView:registerEvents()
    EventMgr:addEventListener(self,EV_RES_LOAD_STATUS, handler(self.onStatusChange, self))
    --加载状态更新
    EventMgr:addEventListener(self,eEvent.EVENT_TEAM_PLAYER_LOAD_STATUS, handler(self.onTeamPlayerLoadProgress, self))
    --组队进入失败离开战斗
    EventMgr:addEventListener(self,eEvent.EVENT_LEAVE, handler(self.onLeave, self))
    --加载过程中战斗结束直接退出战斗返回关卡
    EventMgr:addEventListener(self,eEvent.EVENT_TEAM_FIGHT_END, handler(self.onErroExit, self))
    

end

function LoadView:_onCleanup()
    ResLoader.stopTimer()
    EventMgr:removeEventListenerByTarget(self)
end

function LoadView:isLockStep()

end

function LoadView:onShow()
    self.super.onShow(self)
    --组队战斗
    if self.bLockStep then
        -- local data = BattleDataMgr:getBattleData()
        -- LockStep.reset()
        -- LockStep.setUDPCfg(data.fightServerHost,data.fightServerPort)
        -- LockStep.connect()--创建KCP链接
    end
end

--组队加载过程出错返回关卡界面
function LoadView:onLeave()
    if self.bLockStep then
        ResLoader.stopTimer()
        TeamFightDataMgr:reset()
        AlertManager:changeScene(SceneType.MainScene)
        FubenDataMgr:openFuben()
    end
end

function LoadView:onErroExit()
    if self.bLockStep then
        LockStep.closeUDP()
        ResLoader.stopTimer()
        TeamFightDataMgr:reset()
        AlertManager:changeScene(SceneType.MainScene)
        FubenDataMgr:openFuben()
        Utils:showTips(100000066)
    end
end

return LoadView
