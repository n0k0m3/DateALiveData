local LeagueDegreeView = class("LeagueDegreeView", BaseLayer)

function LeagueDegreeView:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.leagueDegreeView")
end

function LeagueDegreeView:initData(data)
   self.clubRights = TabDataMgr:getData("ClubRights")
   self.degreePermissions = LeagueDataMgr:getDegreePermissions()
   self.playerId = data and data.playerId
end

function LeagueDegreeView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    local Panel_info = TFDirector:getChildByPath(self.ui, "Panel_info")
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_top_tips = TFDirector:getChildByPath(Panel_info, "Label_top_tips")
    self.Label_degree_name = TFDirector:getChildByPath(Panel_info, "Label_degree_name")
    self.Label_degree_num = TFDirector:getChildByPath(Panel_info, "Label_degree_num")
    self.Label_cue_degree = TFDirector:getChildByPath(Panel_info, "Label_cue_degree")

    self.Panel_degree = TFDirector:getChildByPath(self.ui, "Panel_degree")
    local Panel_head = TFDirector:getChildByPath(self.Panel_degree, "Panel_head")
    self.degreeNames = {}
    self.degreeNums = {}
    self.degreeBtns = {}
    for i=1,4 do
        self.degreeNames[i] = TFDirector:getChildByPath(Panel_head, "Label_degree"..i)
        self.degreeNums[i] = TFDirector:getChildByPath(Panel_head, "Label_num"..i)
        self.degreeBtns[i] = TFDirector:getChildByPath(Panel_info, "Button_degree"..i)
    end

    local ScrollView_degree = TFDirector:getChildByPath(Panel_info, "ScrollView_degree")
    self.ScrollView_degree = UIListView:create(ScrollView_degree)
    self.ScrollView_degree:setItemsMargin(5)

    self.Panel_degree_item = TFDirector:getChildByPath(self.ui, "Panel_degree_item")

    self:refreshUI()
end

function LeagueDegreeView:refreshUI()
    self.ScrollView_degree:removeAllItems()
    local unionData = LeagueDataMgr:getMyUnionInfo()
    local size = self.Panel_degree:getContentSize()
    for i,data in ipairs(self.degreePermissions) do
        local item = self.Panel_degree_item:clone()
        self:updateItem(item, data)
        self.Panel_degree:addChild(item, 5)
        item:setPosition(ccp(size.width / 2, size.height - 111 - (i - 1) * 47))
    end
    self.Panel_degree:removeFromParent()
    self.ScrollView_degree:pushBackCustomItem(self.Panel_degree)
    self:updateDgreeState()
end

function LeagueDegreeView:updateItem(item, data)
    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    local Image_flags = {}
    for i=1,4 do
        local Image_flag = TFDirector:getChildByPath(item, "Image_flag"..i)
        if data.dgree[i] then
            Image_flag:setTexture("ui/league/ui_15.png")
        else
            Image_flag:setTexture("ui/league/ui_02.png")
        end
    end    
    Label_name:setText(data.name)
end

function LeagueDegreeView:updateDgreeState()
    for i,label_num in ipairs(self.degreeNums) do
        local curNum = LeagueDataMgr:getCurDegreeNum(i)
        if i < EC_UNION_DEGREE_Type.MEMBER then
            local maxNum = LeagueDataMgr:getDegreeNumMax(i)
            label_num:setText(curNum.."/"..maxNum)
        else
            label_num:setText(tostring(curNum))
        end
    end
    self.Label_top_tips:setVisible(false)
    self.Label_cue_degree:setVisible(false)
    for i,btn in ipairs(self.degreeBtns) do
        btn:setVisible(true)
        btn:setGrayEnabled(true)
        btn:setTouchEnabled(false)
    end
    if self.playerId then
        local memberInfo = LeagueDataMgr:getMemberInfoByPlayerId(self.playerId)
        local selfDegree = LeagueDataMgr:getSelfDegree()
        for i,btn in ipairs(self.degreeBtns) do
            if memberInfo.degree == i then
                self.Label_top_tips:setVisible(true)
                self.Label_cue_degree:setVisible(true)
                self.Label_cue_degree:setPosition(btn:getPosition())
                btn:setVisible(false)
                self.Label_top_tips:setTextById(270440, memberInfo.name)
            else
                if selfDegree == EC_UNION_DEGREE_Type.HEAD and i == EC_UNION_DEGREE_Type.HEAD then
                    btn:setGrayEnabled(false)
                    btn:setTouchEnabled(true)
                else
                    if selfDegree < i and not LeagueDataMgr:checkDegreeNumReachMax(i) then
                        btn:setGrayEnabled(false)
                        btn:setTouchEnabled(true)
                    end
                end
            end
        end
    else
        for i,btn in ipairs(self.degreeBtns) do
            btn:setVisible(false)
        end
    end
end

function LeagueDegreeView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_DEGREE_CHANGE, handler(self.updateDgreeState, self))
    EventMgr:addEventListener(self, EV_UNION_TRANSFER_LEADER, handler(self.updateDgreeState, self))
    EventMgr:addEventListener(self, EV_UNION_MEMBER_UPDATE, handler(self.updateDgreeState, self))

    for i,btn in ipairs(self.degreeBtns) do
        btn:onClick(function()
            if i == EC_UNION_DEGREE_Type.HEAD then
                local memberInfo = LeagueDataMgr:getMemberInfoByPlayerId(self.playerId)
                showChooseMessageBox(TextDataMgr:getText(270441), TextDataMgr:getText(270442, memberInfo.name),function()
                    AlertManager:close()
                    LeagueDataMgr:operateUnionMember(EC_UNIONType.TRANSFER, {self.playerId})
                end)
            else
                LeagueDataMgr:updateMembersDegree(i, self.playerId)
            end
        end)
    end

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return LeagueDegreeView