local BattleUtils   = import(".BattleUtils")
local enum          = import(".enum")
local victoryDecide = import(".VictoryDecide")
local LockStep      = import(".LockStep")
local eEvent        = enum.eEvent

local BattleStatus = class("BattleStatus", BaseLayer)

function BattleStatus:ctor( ... )
    self.super.ctor(self, ...)
    self:init("lua.uiconfig.battle.battleStatus")
    self.nTime = 0
end

function BattleStatus:initUI(ui)
    self.super.initUI(self, ui)
    self.button_close = TFDirector:getChildByPath(ui, "Button_close")
    self.button_close:hide()
    self.buttonExit  = TFDirector:getChildByPath(ui, "Button_exit")
    self.label_time  = TFDirector:getChildByPath(ui, "Label_time")

    --Boss
    local Panel_boss       = TFDirector:getChildByPath(ui, "Panel_boss")
    self.image_boss_head   = TFDirector:getChildByPath(Panel_boss, "Image_boss_head")
    self.label_boss_name   = TFDirector:getChildByPath(Panel_boss, "Label_name")
    self.label_loadbar_num = TFDirector:getChildByPath(Panel_boss,"Label_loadbar_num") --血条数量
    self.loadBar_hps = {}
    for index = 1 , 4 do  --血条
        self.loadBar_hps[index]  = TFDirector:getChildByPath(Panel_boss,"LoadingBar_hp"..index)
    end
    self.label_boss_name:setSkewX(15)
    self.label_loadbar_num:setSkewX(15)
    --角色
    self.heroItems   = {}
    for index = 1,4 do
        local heroItem = TFDirector:getChildByPath(ui, "Panel_hero"..index)
        heroItem.imageIcon      = TFDirector:getChildByPath(heroItem, "Image_icon")
        heroItem.labelName      = TFDirector:getChildByPath(heroItem, "Label_name")
        heroItem.labelHurtValue = TFDirector:getChildByPath(heroItem, "Label_hurtValue")
        heroItem:hide()
        self.heroItems[index] = heroItem
    end
    self:initItems()
    self:initBoss()
end


function BattleStatus:initItems()
    local heros = battleController.getSimpleHeros()
    local count = 0 
    for index , hero in ipairs(heros) do
        local data =  hero:getData()
        -- dump(data)
        if data.pid ~= MainPlayer:getPlayerId() then
            count = count + 1
            local portraitData = TabDataMgr:getData("Portrait",data.portraitCid)
            local heroItem     = self.heroItems[count]
            if heroItem then 
                heroItem:show()
                heroItem.pid = data.pid
                heroItem.imageIcon:setTexture(portraitData.icon) --玩家头像
                heroItem.labelName:setText(hero:getPName()) --名字
                heroItem.labelHurtValue:setText(data.hurtValue) --伤害
            end
        end
    end
end

--刷新角色伤害值
function BattleStatus:onRefershHero(hero)
    local data = hero:getData()
    local pid  = data.pid
    for i, item in ipairs(self.heroItems) do
        if item:isVisible() then 
            if item.pid == pid then 
                item.labelHurtValue:setText(data.hurtValue) --伤害
            end
        end
    end
end


--刷新角色伤害值
function BattleStatus:initBoss()
    local hero = battleController.getBoss() --TODO 获取本场战斗的Boss 
    if not hero then 
        return
    end
    local data = hero:getData() 
    self.image_boss_head:setTexture(data.fightIcon) --头像
    self.label_boss_name:setText(hero:getName())   --名字
    --刷新血条
    self:onRefreshBoss(hero)
end

--刷新角色伤害值
function BattleStatus:onRefreshBoss(hero)
    if hero:isUnlimitedHp() then
        self.label_loadbar_num:setText("x???")
        self.label_loadbar_num:setVisible(true)
        local unlimitedHp = hero:getUnlimitedHp()
        local index = math.floor(unlimitedHp/100000)
        local showIndex = (index -1)%4 + 1
        local showIndex_= -1
        if index > 1 then
            showIndex_= showIndex -1
            showIndex_ = showIndex_ < 1 and (showIndex_ + 4) or showIndex_
        end
        local percent = math.floor(math.floor(unlimitedHp)%100000/1000)
        -- print("showIndex:",showIndex,percent)
        for i=1,4 do
            local loadbar = self.loadBar_hps[i]
            if showIndex == i then
                loadbar:show()
                loadbar:setPercent(BattleUtils.fixPercent(percent))
                loadbar:setZOrder(1)
            elseif showIndex_ == i then
                loadbar:show()
                loadbar:setPercent(100)
                loadbar:setZOrder(0)
            else
                loadbar:hide()
            end
        end
    else
        --血条(一共几条,显示当前的百分比)
        local index , percent = hero:getHpPercentEx()
        local showIndex = (index -1)%4 + 1
        local showIndex_= -1
        self.label_loadbar_num:setText(string.format("x%s",index))
        self.label_loadbar_num:setVisible(index>1)
  

        if index > 1 then
            showIndex_= showIndex -1
            showIndex_ = showIndex_ < 1 and (showIndex_ + 4) or showIndex_
        end
        for i=1,4 do
            local loadbar = self.loadBar_hps[i]
            if showIndex == i then
                loadbar:show()
                loadbar:setPercent(BattleUtils.fixPercent(percent))
                loadbar:setZOrder(1)
            elseif showIndex_ == i then
                loadbar:show()
                loadbar:setPercent(100)
                loadbar:setZOrder(0)
            else
                loadbar:hide()
            end
        end
    end
end


function BattleStatus:registerEvents()
    EventMgr:addEventListener(self,eEvent.EVENT_STATUS_HERO, handler(self.onRefershHero, self))
    EventMgr:addEventListener(self,eEvent.EVENT_STATUS_BOSS, handler(self.onRefreshBoss, self))
    -------------------------
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    self.buttonExit:onClick(function()
        local heros = battleController:getHeroData()
        local hurtValue = 0
        for i,heroData in ipairs(heros) do
            if heroData.pid == MainPlayer:getPlayerId() then
                hurtValue = heroData.hurtValue
                break
            end
        end
        --发送组队退出请求
        TeamFightDataMgr:requestExitFight(hurtValue)
        --关闭组队网路连接
        LockStep.closeUDP()
        --显示结算界面
        self:showInventedResult()
        AlertManager:closeLayer(self)
    end)
end

function BattleStatus:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
end

function BattleStatus:update()
    if self.nTime ~= victoryDecide.nSecondTime then
        self.nTime = victoryDecide.nSecondTime
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_time:setText(string.format("%s:%s", min, sec))
    end
end

--显示虚拟结算结果
function BattleStatus:showInventedResult()
    local battleData = BattleDataMgr:getBattleData()
    if battleData then --追猎计划加计算，用于判断不再显示结算界面
        battleData.jjs = true
    end
    --组织虚拟的战斗结果
    TeamFightDataMgr.battleEndData = battleController.createInventedResultData()
    Utils:openView("battle.BattleResultView")
end



return BattleStatus