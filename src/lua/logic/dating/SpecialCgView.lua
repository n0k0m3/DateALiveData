local SpecialCgView = class("SpecialCgView", BaseLayer)

local DatingConfig = require("lua.logic.dating.DatingConfig")
local isTest = true

function SpecialCgView:initData(CgUIName,textCallBack,time,laBj)
    self.cgData = DatingDataMgr:getDatingInterCgData()[CgUIName]
    if not self.cgData then
        print("CgUIName : " .. CgUIName .. "is nil")
        return
    else
        print("CG互动ID：" .. CgUIName .. " 加载成功")
    end
    self.laBj = laBj
    self.clickAreaList ={}
    self.signAreaList = {}
    self.jumpId = nil
    self.textCallBack_ = textCallBack
    self.textIdx = 0
    self.CgUIName = CgUIName
    self.time = time
    self.isAddSign = true
    self.touchTimes = 0
    self.isTouchArea = true
    self.curTouchAreaName = nil
    self:loadTouchAreaNameTable()
end

function SpecialCgView:ctor(CgUIName,textCallBack,time,laBj)
    self.super.ctor(self)

    self:initData(CgUIName,textCallBack,time,laBj)
    local uiPath = string.format("lua.uiconfig.dating.%s",CgUIName)
    self:init(uiPath)
end

function SpecialCgView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    local Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg"):hide()
    local Panel_area = TFDirector:getChildByPath(self.ui,"Panel_area"):show()
    Panel_area:setOpacity(0)
    if isTest then
        self:refreshLaBj()
        Panel_area:setOpacity(255)
    end

    --最后3秒不添加标记，且不显示当前触发剧情最后一句
    if self.time and self.time > 3 then
        self.ui:timeOut(function()
            if isTest then
                Box("距离互动结束还有最后3秒")
            end
            self.isAddSign = false
        end,self.time - 3)
    end
    self:initAllClickArea()
end

function SpecialCgView:refreshLaBj()
    if not self.laBj then
        return
    end
    local s = ""
    for k, v in pairs(self.signAreaList) do
        s = s .. tostring(k) .. "  "
    end
    self.laBj:setTextById(100000033,s)
end

function SpecialCgView:setIsTouchArea(isTouchArea)
    self.isTouchArea = isTouchArea
    if isTouchArea then
        self:checkCgEnd(self.curTouchAreaName)
    end
end

function SpecialCgView:changeClickAreaListState(isVisible)
    for i, v in ipairs(self.clickAreaList) do
        v:setVisible(isVisible)
    end
end

function SpecialCgView:loadTouchAreaNameTable()
    self.touchAreaNameTable = {}
    for i, v in ipairs(self.cgData) do
        local touchAreaName = v.touchAreaName
        if touchAreaName and table.find(self.touchAreaNameTable,touchAreaName) == -1 then
            table.insert(self.touchAreaNameTable,touchAreaName)
        end
    end
end

function SpecialCgView:getCgTimeOutJumpIdAndScriptId()
    local jumpId
    local scriptId
    local priority = 0
    local id = 0
    for i, v in ipairs(self.cgData) do
        if v.touchAreaName == "" then
            local sign  = v.condition.sign
            local times = v.condition.times
            if v.priority > priority and (not times or (times and self.touchTimes >= times)) then
                if sign then
                    local num = 0
                    for is, vs in ipairs(sign) do
                        for k, vk in pairs(self.signAreaList) do
                            if k == vs then
                                num = num + 1
                            end
                        end
                    end
                    if num == table.count(sign) then
                        jumpId = v.jump
                        scriptId = v.triggerScriptStartId
                        priority = v.priority
                        id = v.id
                    end
                else
                    jumpId = v.jump
                    scriptId = v.triggerScriptStartId
                    priority = v.priority
                    id = v.id
                end
            end
        end
    end
    local data = {}
    data.jumpId = jumpId
    data.scriptId = scriptId
    data.id = id
    return data
end

function SpecialCgView:getCgDefaultJumpId(touchAreaName)
    local jumpId
    local priority = 0
    for i, v in ipairs(self.cgData) do
       if touchAreaName == v.touchAreaName then
           local sign  = v.condition.sign
           local num = 0
           local times = v.condition.times
           if v.priority > priority and not times or (times and self.touchTimes >= times) then
               if sign then
                   for is, vs in ipairs(sign) do
                       for k, vk in pairs(self.signAreaList) do
                           if k == vs then
                               num = num + 1
                           end
                       end
                   end
                   if num == table.count(sign) then
                       jumpId = v.jump
                       priority = v.priority
                   end
               else
                   jumpId = v.jump
                   if jumpId and jumpId ~= 0 then
                       priority = v.priority
                   end
               end
           end
       end
    end

    return jumpId
end

function SpecialCgView:addSign(touchAreaName)
    for i, v in ipairs(self.cgData) do
        for ij, vj in ipairs(v.addSign) do
            if touchAreaName == v.touchAreaName and not self.signAreaList[vj] then
                local sign  = v.condition.sign
                local times = v.condition.times
                if not times or (times and self.touchTimes >= times) then
                    if sign then
                        local num = 0
                        for is, vs in ipairs(sign) do
                            for k, vk in pairs(self.signAreaList) do
                                if k == vs then
                                    num = num + 1
                                end
                            end
                        end
                        if num == table.count(sign) then
                            for id, vd in ipairs(v.addSign) do
                                self.signAreaList[vd] = touchAreaName
                                if isTest then
                                    Box("添加标记：" .. tostring(vd))
                                end
                            end
                            return
                        end
                    else
                        for id, vd in ipairs(v.addSign) do
                            self.signAreaList[vd] = touchAreaName
                            if isTest then
                                Box("添加标记：" .. tostring(vd))
                            end
                        end
                        return
                    end
                end
            end
        end
    end

end

function SpecialCgView:getTriggerScriptId(touchAreaName)
    local triggerScriptId
    local priority = 0
    for i, v in ipairs(self.cgData) do
        if touchAreaName == v.touchAreaName and v.priority > priority then
            local sign  = v.condition.sign
            local times = v.condition.times
            if not times or (times and self.touchTimes >= times) then
                if sign then
                    local num = 0
                    for is, vs in ipairs(sign) do
                        for k, vk in pairs(self.signAreaList) do
                            if k == vs then
                                num = num + 1
                            end
                        end
                    end
                    if num == table.count(sign) then
                        triggerScriptId = v.triggerScriptStartId
                        priority = v.priority
                    end
                else
                    triggerScriptId = v.triggerScriptStartId
                    priority = v.priority
                end
            end
        end
    end

    return triggerScriptId
end

function SpecialCgView:checkCgEnd(touchAreaName)
    if self.jumpId and self.jumpId ~= 0 then
        if self.isTimeOver then
            if self.isTScript then
                self.isTScript = nil
                self:over()
            else
                self.isTimeOver = false
                self.textCallBack_(nil,self.jumpId)
            end
        else
            self.isTScript = nil
            self:over()
        end
    elseif self.isAddSign then
        self:addSign(touchAreaName)
        self:refreshLaBj()
    elseif self.isTScript and self.isTimeOver then
        self.isTScript = nil
        self:over()
    end
end

function SpecialCgView:initAllClickArea()
    for i, v in ipairs(self.touchAreaNameTable) do
        local uiName = v
        local Panel_ClickArea = TFDirector:getChildByPath(self.ui, uiName)
        if not Panel_ClickArea then
            Box("没有找到对应UI控件：" .. uiName)
        else
            Panel_ClickArea.touchAreaName = uiName
            if isTest then
                local la = TFLabel:create()
                la:setText(uiName)
                la:setAnchorPoint(ccp(0.5, 0.5))
                la:Pos(Panel_ClickArea:Size().width/2,Panel_ClickArea:Size().height/2)
                Panel_ClickArea:addChild(la)
            end
            table.insert(self.clickAreaList, Panel_ClickArea)
        end
    end
end

function SpecialCgView:onClick(clickArea)
    if not self.isTouchArea then
        return
    end
    local touchAreaName = clickArea.touchAreaName
    if isTest then
        --Box("touchAreaName " .. touchAreaName)
    end

    local textId = self:getTriggerScriptId(touchAreaName)
    if textId then
        if textId == 0 then
            Box("剧本为空")
            return
        end
        self.curTouchAreaName = touchAreaName
        self.touchTimes = self.touchTimes + 1
        if isTest then
            --Box("self.touchTimes " .. tostring(self.touchTimes))
        end
        self.jumpId = self:getCgDefaultJumpId(touchAreaName)
        if isTest then
            --Box("self.touchTimes self.jumpId " .. tostring(self.jumpId))
        end

        self.isTScript = true
        self.textCallBack_(textId,self.jumpId)
    end
end

function SpecialCgView:playAnimation(action)
    if action and #action ~= 0 then
        if isTest then
            Box("播放动画 " .. action)
        end
        self.ui:runAnimation(action,1)
    end
end

function SpecialCgView:changeCgState(textData)
    local cgScriptData = textData
    if cgScriptData then

    end
end

function SpecialCgView:getIsAddSign()
    return self.isAddSign
end

function SpecialCgView:playOverScript()

end

function SpecialCgView:over(isTimeOver)
    self.isTimeOver = self.isTimeOver or isTimeOver


    if ( not self.jumpId or self.jumpId == 0 ) and not self.isAddSign then
        self.jumpId = self:getCgTimeOutJumpIdAndScriptId().jumpId
    end
    if self.isTScript and isTimeOver then
        return
    end

    local textId
    if not self.isAddSign then
        textId = self:getCgTimeOutJumpIdAndScriptId().scriptId
        Box("触发超时剧本：" .. textId)
    end
    if not textId and not self.jumpId then
        return
    end
    self.textCallBack_(textId,self.jumpId)
end

function SpecialCgView:registerEvents()
    for i, v in ipairs(self.clickAreaList) do
        v:Touchable(true)
        v:onClick(function()
            self:onClick(v)
        end)
    end
end

return SpecialCgView