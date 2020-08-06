--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 组队副本帮助界面
]]

local TeamLevelHelpView = class("TeamLevelHelpView", BaseLayer)

function TeamLevelHelpView:ctor(nteamType, dungeonId)
    self.super.ctor(self)
    self.nteamType = nteamType
    self.dungeonId = dungeonId
    self:showPopAnim(true)
    self:init("lua.uiconfig.osd.LevelHelpView")
end

function TeamLevelHelpView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_tittle = TFDirector:getChildByPath(self.ui, "Label_tittle")

    self.PageView_item = TFDirector:getChildByPath(self.ui, "PageView_item")
    self.Panel_help_item = TFDirector:getChildByPath(self.ui, "Panel_help_item")
    self.Panel_page = TFDirector:getChildByPath(self.ui, "Panel_page")
    -- local ScrollView_list = TFDirector:getChildByPath(self.ui, "ScrollView_list")
    -- self.text_list = UIListView:create(ScrollView_list)
    -- self.text_list:setItemsMargin(20)

    self:initContent()
end

function TeamLevelHelpView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    
end

function TeamLevelHelpView:initContent(  )
	-- body
	local cfg = TeamFightDataMgr:getTeamLevelCfg(self.nteamType,self.dungeonId)
    local rewardNode1 = TFDirector:getChildByPath(self.Panel_help_item,"reward1")
    local ScrollView_reward = TFDirector:getChildByPath(rewardNode1,"ScrollView_reward")
    local UIList_reward = UIListView:create(ScrollView_reward)
    UIList_reward:setItemsMargin(10)
    for i = 1,#cfg.showLeader do
        local point = UIList_reward:getItem(i)
        if not point then
            point = TFDirector:getChildByPath(rewardNode1,"point1"):clone()
            point.goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            point.goodItem:setPosition(ccp(0,0))
            point:addChild(point.goodItem)
            UIList_reward:pushBackCustomItem(point)
        end

        local reward = cfg.showLeader[i]

        point:hide()
        if reward then
            point:show()
            PrefabDataMgr:setInfo(point.goodItem,reward,cfg.showLeaderNum[i])
        end
    end

    local rewardNode2 = TFDirector:getChildByPath(self.Panel_help_item,"reward2")
    ScrollView_reward = TFDirector:getChildByPath(rewardNode2,"ScrollView_reward")
    UIList_reward = UIListView:create(ScrollView_reward)
    UIList_reward:setItemsMargin(10)
    for i = 1,#cfg.showMate do
        local point = UIList_reward:getItem(i)
        if not point then
            point = TFDirector:getChildByPath(rewardNode2,"point1"):clone()
            point.goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            point.goodItem:setPosition(ccp(0,0))
            point:addChild(point.goodItem)
            UIList_reward:pushBackCustomItem(point)
        end

        local reward = cfg.showMate[i]

        point:hide()
        if reward then
            point:show()
            PrefabDataMgr:setInfo(point.goodItem,reward,cfg.showMateNum[i])
        end
    end

    local target1 = TFDirector:getChildByPath(self.Panel_help_item,"target1")
    local targetLabel = TFDirector:getChildByPath(target1,"targetContent")

    targetLabel:setTextById(cfg.levelTarget)

end


return TeamLevelHelpView
