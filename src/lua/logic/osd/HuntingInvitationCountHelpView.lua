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

local HuntingInvitationCountHelpView = class("HuntingInvitationCountHelpView", BaseLayer)

function HuntingInvitationCountHelpView:ctor(nteamType, dungeonId)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:init("lua.uiconfig.osd.HuntingInvitationCountHelpView")
end

function HuntingInvitationCountHelpView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_tittle = TFDirector:getChildByPath(self.ui, "Label_tittle")

    self.PageView_item = TFDirector:getChildByPath(self.ui, "PageView_item")
    self.Panel_help_item = TFDirector:getChildByPath(self.ui, "Panel_help_item")
    self.Panel_page = TFDirector:getChildByPath(self.ui, "Panel_page")
    local ScrollView_help = TFDirector:getChildByPath(self.ui, "ScrollView_help")
    self.ListView_help = UIListView:create(ScrollView_help)
    self.targetItem = TFDirector:getChildByPath(self.Panel_help_item,"target1")
    --TODO CLOSE
    if TFGlobalUtils:isConnectMiniServer() then  --英文版打开质点预设
        self.targetTextIds = {14110156,14110157,14110158,14110159,14110160}
    else
        self.targetTextIds = {14110156,14110157,14110158,14110159,14110160,14110461}
    end 

    self:initContent()
end

function HuntingInvitationCountHelpView:registerEvents()
    EventMgr:addEventListener(self, EV_OSD.HUNTING_INVITATION_RECORD, handler(self.initContent, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end) 
end

function HuntingInvitationCountHelpView:onShow()
    self.super.onShow(self)
    TFDirector:send(c2s.NEW_WORLD_REQ_REWARD_MISSION_RECORD,{})
end

function HuntingInvitationCountHelpView:initContent()
	--for i = 1,5 do
	--    local target = TFDirector:getChildByPath(self.Panel_help_item,"target"..i)
	--    local targetLabel = TFDirector:getChildByPath(target,"targetContent")
	--    local labelCount = TFDirector:getChildByPath(target,"labelCount")
    --
	--    targetLabel:setTextById(14110156 + i - 1)
	--    local count = 0
	--    local maxCount = 0
	--    if i == 5 then
	--    	count = OSDDataMgr:getHuntingInvitationCount(5,false)
	--    	maxCount = TabDataMgr:getData("DiscreteData",81012).data.weekTime[5]
	--    else
	--   		count = OSDDataMgr:getHuntingInvitationCount(i,true)
	--    	maxCount = TabDataMgr:getData("DiscreteData",81011).data.dayTime[i]
	--    end
	--    labelCount:setText(count.."/"..maxCount)
	--end

    self.ListView_help:removeAllItems()
    local isHavePrivilege, cfg = RechargeDataMgr:getIsHavePrivilegeByType(101)
    for k,v in ipairs(self.targetTextIds) do
        local item = self.targetItem:clone()
        item:show()
        self.ListView_help:pushBackCustomItem(item)
        local targetLabel = TFDirector:getChildByPath(item,"targetContent")
        local labelCount = TFDirector:getChildByPath(item,"labelCount")
        targetLabel:setTextById(v)
        local count = OSDDataMgr:getHuntingInvitationCount(k,true)
        local maxCount = TabDataMgr:getData("DiscreteData",81011).data.dayTime[k]
        if k >= 5 then
            count = OSDDataMgr:getHuntingInvitationCount(k,false)
            maxCount = TabDataMgr:getData("DiscreteData",81012).data.weekTime[k]
        end
        if isHavePrivilege then
            maxCount = maxCount + cfg.privilege.chance
        end
        labelCount:setText(count.."/"..maxCount)
    end

end

return HuntingInvitationCountHelpView