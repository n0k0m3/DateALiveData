local EditJoinLimitView = class("EditJoinLimitView", BaseLayer)

function EditJoinLimitView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.editJoinLimitView")
end

function EditJoinLimitView:initData()
    self.conditionData = {{cType = 1, title = "等级限制"}}
    self.valueData = {
       {title = "> 10", value = 10},
       {title = "> 20", value = 20},
       {title = "> 30", value = 30},
       {title = "> 40", value = 40},
       {title = "> 50", value = 50},
    }
    self.selectConditinIdx = 1
    self.selectValueIdx = 1
end

function EditJoinLimitView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Panel_condition = TFDirector:getChildByPath(self.ui, "Panel_condition")
    self.Panel_values = TFDirector:getChildByPath(self.ui, "Panel_values")
    self.Button_item = TFDirector:getChildByPath(self.ui, "Button_item")

    self.Button_left = TFDirector:getChildByPath(self.Panel_condition, "Button_left")
    self.Label_left = TFDirector:getChildByPath(self.Panel_condition, "Label_left")
    self.Image_arrow_left = TFDirector:getChildByPath(self.Panel_condition, "Image_arrow_left")
    self.Image_left = TFDirector:getChildByPath(self.Panel_condition, "Image_left")

    self.Button_right = TFDirector:getChildByPath(self.Panel_values, "Button_right")
    self.Label_right = TFDirector:getChildByPath(self.Panel_values, "Label_right")
    self.Image_arrow_right = TFDirector:getChildByPath(self.Panel_values, "Image_arrow_right")
    self.Image_right = TFDirector:getChildByPath(self.Panel_values, "Image_right")

    self:initPanelContent()
end

function EditJoinLimitView:initPanelContent()
    self.Image_left:setScaleY(0.1)
    self.Image_left:setOpacity(0)
    self.Image_right:setScaleY(0.1)
    self.Image_right:setOpacity(0)
    self.conditionBtns = {}
    self.valueBtns = {}
    for i,data in ipairs(self.conditionData) do
        local btn = self.Button_item:clone()
        local Label_content = TFDirector:getChildByPath(btn, "Label_content")
        Label_content:setText(data.title)
        self.Image_left:addChild(btn, 5)
        btn:setPosition(ccp(0, -20 - (i - 1) * 45))
        self.conditionBtns[#self.conditionBtns + 1] = btn
    end
    self.Image_arrow_left:setRotation(0)

    for i,data in ipairs(self.valueData) do
        local btn = self.Button_item:clone()
        local Label_content = TFDirector:getChildByPath(btn, "Label_content")
        Label_content:setText(data.title)
        self.Image_right:addChild(btn, 5)
        btn:setPosition(ccp(0, -20 - (i - 1) * 35))
        self.valueBtns[#self.valueBtns + 1] = btn
    end
    self.Image_arrow_right:setRotation(0)
    self:refreshUIContent()

    local valueData = self.valueData[self.selectValueIdx]
    local limitLevel = LeagueDataMgr:getJoinLimitLevel()
    self.Label_right:setText(tostring(limitLevel) or valueData.title)
end

function EditJoinLimitView:refreshUIContent()
    local conditionData = self.conditionData[self.selectConditinIdx]
    self.Label_left:setText(conditionData and conditionData.title or "")
    for i,btn in ipairs(self.conditionBtns) do
        local Label_content = TFDirector:getChildByPath(btn, "Label_content")
        if i == self.selectConditinIdx then
            Label_content:setColor(ccc3(252,225,64))
        else
            Label_content:setColor(ccc3(255,255,255))
        end
    end

    local valueData = self.valueData[self.selectValueIdx]
    self.Label_right:setText(valueData and valueData.title or "")
    for i,btn in ipairs(self.valueBtns) do
        local Label_content = TFDirector:getChildByPath(btn, "Label_content")
        if i == self.selectValueIdx then
            Label_content:setColor(ccc3(252,225,64))
        else
            Label_content:setColor(ccc3(255,255,255))
        end
    end
end

function EditJoinLimitView:updateLeftBtnState()
    if self.conditionOpen then
        self.conditionOpen = false
        self.Image_arrow_left:setRotation(0)
        self.Image_left:runAction(CCSpawn:create({CCFadeOut:create(0.15), CCScaleTo:create(0.15, 1, 0.01)}))
    else
        self.conditionOpen = true
        self.Image_arrow_left:setRotation(180)
        self.Image_left:runAction(CCSpawn:create({CCFadeIn:create(0.15), CCScaleTo:create(0.15, 1, 1)}))
    end
end

function EditJoinLimitView:updateRightBtnState()
    if self.valueOpen then
        self.valueOpen = false
        self.Image_arrow_right:setRotation(0)
        self.Image_right:runAction(CCSpawn:create({CCFadeOut:create(0.15), CCScaleTo:create(0.15, 1, 0.01)}))
    else
        self.valueOpen = true
        self.Image_arrow_right:setRotation(180)
        self.Image_right:runAction(CCSpawn:create({CCFadeIn:create(0.15), CCScaleTo:create(0.15, 1, 1)}))
    end
end

function EditJoinLimitView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_NOTICE_CHANGE, handler(self.onEditNoticeBack, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_ok:onClick(function()
        local valueData = self.valueData[self.selectValueIdx]
        local value = valueData and valueData.value or 0
        LeagueDataMgr:UpdateUnionInfo(EC_UNION_EDIT_Type.OPEN_JOIN_LIMIT, "true,"..value)
        AlertManager:closeLayer(self)
    end)

    self.Button_left:onClick(function()
        self:updateLeftBtnState()
    end)

    self.Button_right:onClick(function()
        self:updateRightBtnState()
    end)

    for i,btn in ipairs(self.conditionBtns) do
        btn:onClick(function()
            self.selectConditinIdx = i
            self:updateLeftBtnState()
            self:refreshUIContent()
        end)
    end

    for i,btn in ipairs(self.valueBtns) do
        btn:onClick(function()
            self.selectValueIdx = i
            self:updateRightBtnState()
            self:refreshUIContent()
        end)
    end
end

return EditJoinLimitView