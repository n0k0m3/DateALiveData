
local DifficultyChoice = class("DifficultyChoice", BaseLayer)

function DifficultyChoice:ctor(params)
    self.super.ctor(self)
    self:showPopAnim(true)
    self.iconRes = {"D.png","C.png","B.png","A.png","S.png","blackwhite.png"}
    self:init("lua.uiconfig.chat.difficultyChoice")
end

function DifficultyChoice:initUI(ui)
    self.super.initUI(self,ui)

    self.Panel_root   = TFDirector:getChildByPath(ui,"Panel_root");
    self.Button_close = TFDirector:getChildByPath(self.Panel_root,"Button_close")
    self.Button_ok    = TFDirector:getChildByPath(self.Panel_root,"Button_ok")
    self.Label_desc   = TFDirector:getChildByPath(self.Panel_root,"Label_desc")
    self.Label_desc:setTextById(2100167)

    self.buttonItem = TFDirector:getChildByPath(self.Panel_root,"Button_1")
    local ScrollView_difficulty = TFDirector:getChildByPath(self.Panel_root,"ScrollView_difficulty")
    self.GridView_difficulty = UIGridView:create(ScrollView_difficulty)

    self.GridView_difficulty:setItemModel(self.buttonItem)
    self.GridView_difficulty:setColumn(3)
    self.GridView_difficulty:setColumnMargin(100)
    self.GridView_difficulty:setRowMargin(50)
    
    self.difficultyItems = {}
    local selects =SettingDataMgr:getDifficultyChoice()
    for k,v in ipairs(self.iconRes) do
        local node = self.buttonItem:clone()
        node:show()
        self.GridView_difficulty:pushBackCustomItem(node)
        node.Image_select  = TFDirector:getChildByPath(node,"Image_select") 
        node.Label_times  = TFDirector:getChildByPath(node,"Label_times")
        node.Image_icon = TFDirector:getChildByPath(node,"Image_icon")
        local count = OSDDataMgr:getHuntingInvitationCount(k,true)
        local maxCount = TabDataMgr:getData("DiscreteData",81011).data.dayTime[k]
        if k >= 5 then
            count = OSDDataMgr:getHuntingInvitationCount(k,false)
            maxCount = TabDataMgr:getData("DiscreteData",81012).data.weekTime[k]
        end

        node.Image_select:setVisible(selects[k]== "1")
        node.Image_icon:setTexture("ui/teampve/huntingInvitation/"..v)
        self.difficultyItems[k] = node
    end
	
	--新增终焉之战的难度筛选
	self.blackAndWhiteDifficultyItems = {}
	local blackAndWhiteSelects =SettingDataMgr:getBlackAndWhiteDifficultyChoice()
    for i=1,3 do
        local node = TFDirector:getChildByPath(self.Panel_root,"Button_"..tostring(i) .. "_new") 
        node.Image_select  = TFDirector:getChildByPath(node,"Image_select") 
        node.Label_times  = TFDirector:getChildByPath(node,"Label_times")
       -- local count    = OSDDataMgr:getHuntingInvitationCount(i, i~=5)
        --if i == 5 then
        --    local maxCount = TabDataMgr:getData("DiscreteData",c).data.weekTime[5]
         --   node.Label_times:setTextById(2100169,count,maxCount)
        --else
        --    local maxCount = TabDataMgr:getData("DiscreteData",81025).data.dayTime
        --    node.Label_times:setTextById(2100168,count,maxCount)
        --end
		node.Label_times:hide()
        node.Image_select:setVisible(blackAndWhiteSelects[i]== "1")
        self.blackAndWhiteDifficultyItems[i] = node
    end
end

function DifficultyChoice:onShow()
    self.super.onShow(self)
    TFDirector:send(c2s.NEW_WORLD_REQ_REWARD_MISSION_RECORD,{})
end
function DifficultyChoice:refresh()
    local isHavePrivilege, cfg = RechargeDataMgr:getIsHavePrivilegeByType(101)
    for i ,node in ipairs(self.difficultyItems) do
        local count = OSDDataMgr:getHuntingInvitationCount(i,true)
        local maxCount = TabDataMgr:getData("DiscreteData",81011).data.dayTime[i]
        local textId = 2100168
        if i >= 5 then
            count = OSDDataMgr:getHuntingInvitationCount(i,false)
            maxCount = TabDataMgr:getData("DiscreteData",81012).data.weekTime[i]
            textId = 2100169
        end

        if isHavePrivilege then
            maxCount = maxCount + cfg.privilege.chance
        end
        node.Label_times:setTextById(textId,count,maxCount)
    end
end

function DifficultyChoice:registerEvents()
    EventMgr:addEventListener(self, EV_OSD.HUNTING_INVITATION_RECORD, handler(self.refresh, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
    self.Button_ok:onClick(function()
        local values = {}
        for i ,node in ipairs(self.difficultyItems) do
            values[i] = node.Image_select:isVisible() and 1 or 0
        end
        SettingDataMgr:setDifficultyChoice(values)

		local blackAndWhiteValues = {}
		for i ,node in ipairs(self.blackAndWhiteDifficultyItems) do
            blackAndWhiteValues[i] = node.Image_select:isVisible() and 1 or 0
        end
		SettingDataMgr:setBlackAndWhiteDifficultyChoice(blackAndWhiteValues)
		
        ChatDataMgr:filteChatInfo()
        EventMgr:dispatchEvent(EV_DIFFICULTY_CHANGE)
        AlertManager:closeLayer(self)
    end)
    for i ,node in ipairs(self.difficultyItems) do
        node:onClick(function()
            node.Image_select:setVisible(not node.Image_select:isVisible())
        end)
    end
	
	 for i ,node in ipairs(self.blackAndWhiteDifficultyItems) do
        node:onClick(function()
            node.Image_select:setVisible(not node.Image_select:isVisible())
        end)
    end

end
return DifficultyChoice
