local FairyEnergyUseView = class("FairyEnergyUseView", BaseLayer)
require("lua.logic.common.ChooseMessageBox")

function FairyEnergyUseView:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self.pramsSelectIdx = data and data.selectIdx or 1
    self.selectAttrIdx = 0
    self.skillPoints = {}
    self.changedPoints = {}
    self.propertyCfgs = {}
    self.propertyData = {}
    self.startUpdate = false

    self:init("lua.uiconfig.fairyNew.fairyEnergyUseView")
end

function FairyEnergyUseView:getClosingStateParams()
    return {self.paramData_}
end

function FairyEnergyUseView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

    self.Panel_left = TFDirector:getChildByPath(ui, "Panel_left")
    self.Panel_right = TFDirector:getChildByPath(ui, "Panel_right")
    self.Spine_juhe = TFDirector:getChildByPath(self.Panel_left, "Spine_juhe"):hide()

    self.Image_title_bg = TFDirector:getChildByPath(self.Panel_right, "Image_title_bg")
    self.Label_title = TFDirector:getChildByPath(self.Image_title_bg, "Label_title")
    self.Image_title_icon = TFDirector:getChildByPath(self.Image_title_bg, "Image_title_icon")

    self.Button_reset      = TFDirector:getChildByPath(ui, "Button_reset")
    self.Button_ok      = TFDirector:getChildByPath(ui, "Button_ok")
    self.Label_tips = TFDirector:getChildByPath(ui, "Label_tips")
    self.Label_tips:setTextById(1329123)

    self.Label_total_num = TFDirector:getChildByPath(self.Panel_right, "Label_total_num")
    self.Panel_attrs = TFDirector:getChildByPath(self.Panel_left, "Panel_attrs")

    self.attr_infos = {}
    for i=1,3 do
        local item = TFDirector:getChildByPath(self.Panel_left, "Panel_attr"..i)
        local foo = {}
        foo.root = item
        foo.Image_attr_icon = TFDirector:getChildByPath(item, "Image_attr_icon")
        foo.Label_name = TFDirector:getChildByPath(item, "Label_name")
        foo.Label_num = TFDirector:getChildByPath(item, "Label_num")
        foo.Image_select = TFDirector:getChildByPath(item, "Image_select"):hide()
        self.attr_infos[i] = foo
    end

    self.ScrollView_skills = UIListView:create(TFDirector:getChildByPath(self.Panel_right, "ScrollView_skills"))
    self.ScrollView_skills:setItemsMargin(10)
    self.Panel_skill_item = TFDirector:getChildByPath(ui, "Panel_skill_item")

    self:selectAttrItem(self.pramsSelectIdx or 1)
end

function FairyEnergyUseView:selectAttrItem(idx)
    if self.selectAttrIdx == idx then
        return
    end
    if self.selectImage then
        self.selectImage:setVisible(false)
    end
    local foo = self.attr_infos[idx]
    foo.Image_select:setVisible(true)
    self.selectImage = foo.Image_select
    self.selectAttrIdx = idx
    self:updateSkillUI()
end

function FairyEnergyUseView:updateSkillUI()
    self.propertyCfgs = HeroDataMgr:getHeroEnergyPropertyCfgs(self.selectAttrIdx)
    self.propertyData = HeroDataMgr:getHeroEnergyPropertyData(self.selectAttrIdx)
    self.skill_items = {}
    self.changedPoints = {}

    local items = self.ScrollView_skills:getItems()
    local gap = #items - #self.propertyCfgs
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self.ScrollView_skills:removeItem(1)
        end
    end

    for i, cfg in ipairs(self.propertyCfgs) do
        local item = self.ScrollView_skills:getItem(i)
        if not item then
            item = self.Panel_skill_item:clone()
            self.ScrollView_skills:pushBackCustomItem(item)
        end
        self.skill_items[i] = item
    end
    self:updateSkillItems()
    self:updateEnergyInfo()
end

function FairyEnergyUseView:updateSkillItems()
    for i, item in ipairs(self.skill_items) do
        self:updateSkillItem(i)
    end

    self.Label_title:setTextById(HeroDataMgr:getEnergyAttrNameId(self.selectAttrIdx))
    self.Image_title_icon:setTexture(HeroDataMgr:getEnergyAttrIcon(self.selectAttrIdx))
end

function FairyEnergyUseView:updateSkillItem(idx)
    local cfg = self.propertyCfgs[idx]
    local data = self.propertyData[cfg.id]
    local item = self.skill_items[idx]
    local Label_skill_name = TFDirector:getChildByPath(item, "Label_skill_name")
    local Label_skill_level = TFDirector:getChildByPath(item, "Label_skill_level")
    local Label_level_limit = TFDirector:getChildByPath(item, "Label_level_limit"):hide()
    local Image_skill_icon = TFDirector:getChildByPath(item, "Image_skill_icon")
    local Label_cur_attr_value = TFDirector:getChildByPath(item, "Label_cur_attr_value")
    local Label_add_num = TFDirector:getChildByPath(item, "Label_add_num")
    local Button_add = TFDirector:getChildByPath(item, "Button_add")
    local Button_sub = TFDirector:getChildByPath(item, "Button_sub")
    Label_skill_name:setTextById(tonumber(cfg.SkillName))
    local point = data and data.num or 0
    local added = self.changedPoints[idx] or 0
    point = point + added
    Label_add_num:setString(added)
    local attrValue = HeroDataMgr:getEnergyAttrValue(cfg.Attribute,point)
    Label_cur_attr_value:setString(attrValue)
    Label_skill_level:setString("Lv"..point)
    Image_skill_icon:setTexture(cfg.ShowPic)
    
    local energyLevel = HeroDataMgr:getHeroEnergyLevel()
    local limitLevel1 = 0
    local limitLevel2 = 0
    local limitPoint1 = 0
    for i = 1, #cfg.LimitLevel do
        local limit = cfg.LimitLevel[i]
        if i == #cfg.LimitLevel then
            if energyLevel > limit[1] then
                limitLevel1 = limit[1]
                limitLevel2 = limit[1]
                limitPoint1 = limit[2]
            end
        else
            local limit1 = cfg.LimitLevel[i + 1]
            if i == 1 and energyLevel <= limit[1] then
                limitLevel1 = limit[1]
                limitLevel2 = limit[1]
                limitPoint1 = limit[2]
            elseif energyLevel > limit[1] and energyLevel <= limit1[1] then
                limitLevel1 = limit[1]
                limitLevel2 = limit1[1]
                limitPoint1 = limit1[2]
            end 
        end
    end
    Button_add:setTextureNormal("ui/fairy/new_ui/energy/028.png")
    if point >= cfg.LimitPoint then
        Label_skill_level:setString("MAX")
        Button_add:setTextureNormal("ui/fairy/new_ui/energy/017.png")
    else
        if point >= limitPoint1 then
            Button_add:setTextureNormal("ui/fairy/new_ui/energy/017.png")
            Label_level_limit:setVisible(true)
            Label_level_limit:setTextById(1329122, limitLevel2 + 1)
        end
    end
    if self:getCurrentEnergyPoint() <= 0 then
        Button_add:setTextureNormal("ui/fairy/new_ui/energy/017.png")
    end
    
    if added > 0 then
        Button_sub:setTextureNormal("ui/fairy/new_ui/energy/027.png")
    else
        Button_sub:setTextureNormal("ui/fairy/new_ui/energy/016.png")
    end
    if point >= limitPoint1 or point >= cfg.LimitPoint or self:getCurrentEnergyPoint() <= 0 then
        if self.curAddIdx == idx then
            self:stopTimer()
        end
    end
    
    Button_add:onTouch(function(event)
        if point >= limitPoint1 or point >= cfg.LimitPoint or self:getCurrentEnergyPoint() <= 0 then
            return
        end
        if event.name == "began" then
            if self.startUpdate then
                return
            end
            self:holdDownAction(true, idx)
            self:onTouchButtonUp()
        elseif event.name == "ended" then
            self:stopTimer()
        end
    end)

    Button_sub:onTouch(function(event)
        if added < 1 then
            self:stopTimer()
            return
        end
        if event.name == "began" then
            if self.startUpdate then
                return
            end
            self:holdDownAction(false, idx)
            self:onTouchButtonDown()
        elseif event.name == "ended" then
            self:stopTimer()
        end
    end)
end

function FairyEnergyUseView:onAddEnergy()
    if self:getCurrentEnergyPoint() <= 0 then
        return
    end
    if self.changedPoints[self.curAddIdx] then
        self.changedPoints[self.curAddIdx] = self.changedPoints[self.curAddIdx] + 1
    else
        self.changedPoints[self.curAddIdx] = 1
    end
end

function FairyEnergyUseView:onSubEnergy()
    if self.changedPoints[self.curAddIdx] then
        self.changedPoints[self.curAddIdx] = math.max(0, self.changedPoints[self.curAddIdx] - 1)
    else
        self.changedPoints[self.curAddIdx] = 0
    end
end


function FairyEnergyUseView:updateEnergyInfo()
    local data = HeroDataMgr:getHeroEnergyUseData()
    local valueArray = {}
    local addNum = 0
    local useNum = 0
    for i, foo in ipairs(self.attr_infos) do
        local point = data[i] or 0
        useNum = useNum + point
        local added = 0
        if self.selectAttrIdx == i then
            for k, v in pairs(self.changedPoints) do
                added = added + v
            end
        end
        addNum = addNum + added
        valueArray[i] = point + added
        foo.Label_num:setString(valueArray[i])
        foo.Label_name:setTextById(HeroDataMgr:getEnergyAttrNameId(i))
        foo.Image_attr_icon:setTexture(HeroDataMgr:getEnergyAttrIcon(i, self.selectAttrIdx == i))
    end
    self:drawAttrPolygon(valueArray)
    self.Button_reset:setTouchEnabled(useNum > 0)
    self.Button_reset:setGrayEnabled(useNum <= 0)
    self.Button_ok:setTouchEnabled(addNum > 0)
    self.Button_ok:setGrayEnabled(addNum <= 0)

    self.Label_total_num:setString(self:getCurrentEnergyPoint())
end

function FairyEnergyUseView:drawAttrPolygon(valueArray)
    self.Panel_attrs:removeAllChildren()
    local PI = 3.1415926
    local solidMax = 104
    local solidMax1 = 124
    local percents = {0, 0, 0}
    local baseMax = 900
    local baseValue = 100
    for i,v in ipairs(valueArray) do
        percents[i] = math.min(1, (v + baseValue) / baseMax)
    end
    local pointsSolid = {
    ccp(-solidMax * math.cos(1 / 6 * PI) * percents[2], solidMax * math.sin(1 / 6 * PI) * percents[2]),
    ccp(solidMax * math.cos(1 / 6 * PI) * percents[3], solidMax * math.sin(1 / 6 * PI) * percents[3]),
    ccp(0, -solidMax1 * math.cos(1 / 6 * PI) * percents[1]),
    }

    local attrNode = TFDrawNode:create()
    self.Panel_attrs:addChild(attrNode, 100)
    attrNode:drawSolidPoly(pointsSolid, ccc4(200 / 255, 234 / 255, 248 / 255, 1))
    attrNode:setPosition(ccp(0, 0))
end

function FairyEnergyUseView:getCurrentEnergyPoint()
    local data = HeroDataMgr:getHeroEnergyUseData()
    local usedPoint = 0
    for i = 1, 3 do
        local point = data[i] or 0
        local added = 0
        usedPoint = usedPoint + point
        if self.selectAttrIdx == i then
            for k, add in pairs(self.changedPoints) do
                added = added + add
            end
        end
        usedPoint = usedPoint + added
    end

    local energyPoints = HeroDataMgr:getHeroEnergyPoints()
    energyPoints = energyPoints - usedPoint
    energyPoints = math.max(0, energyPoints)
    return energyPoints
end

function FairyEnergyUseView:onPutPointsOver()
    self:updateSkillUI()
    self.Spine_juhe:setVisible(true)
    self.Spine_juhe:play("animation",false)
    self.Spine_juhe:addMEListener(TFARMATURE_COMPLETE,function()
        self.Spine_juhe:setVisible(false)
    end) 
end


function FairyEnergyUseView:holdDownAction(isAddOp, curIdx)
    self.speedTiming = 0
    self.timing = 0
    self.needTime = 0
    self.entryFalg = false
    self.isAddOp = isAddOp
    self.curAddIdx = curIdx
    self.startUpdate = true
end

function FairyEnergyUseView:update(target , dt)
    if self.startUpdate ~= true then
        return
    end
    self.timing = self.timing + dt
    self.speedTiming = self.speedTiming + dt
    if self.speedTiming >= 3.0 then
        self.entryFalg = true
        self.needTime = 0.01
    elseif self.speedTiming > 0.5 then
        self.entryFalg = true
        self.needTime = 0.05
    end
    if self.onTouchButtonUp and self.onTouchButtonDown then
        if self.entryFalg and self.timing >= self.needTime then
            if self.isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            self.timing = 0
        end
    end
end

function FairyEnergyUseView:onTouchButtonDown()
    self:onSubEnergy()
    self:updateSkillItems()
    self:updateEnergyInfo()
end

function FairyEnergyUseView:onTouchButtonUp()
    self:onAddEnergy()
    self:updateSkillItems()
    self:updateEnergyInfo()
end

function FairyEnergyUseView:stopTimer()
    self.startUpdate = false
end

function FairyEnergyUseView:onHide()
    self:stopTimer()
    self.super.onHide(self)
end

function FairyEnergyUseView:onClose()
    self:stopTimer()
    self.super.onClose(self)
end

function FairyEnergyUseView:registerEvents()
    EventMgr:addEventListener(self,EV_HERO_PUT_SPRIT_POINTS,handler(self.onPutPointsOver, self))
    EventMgr:addEventListener(self,EV_HERO_RESET_SPRIT_POINTS,handler(self.updateSkillUI, self))
    EventMgr:addEventListener(self,EV_HERO_UPGRADE_SPRIT_POINTS,handler(self.updateSkillUI, self))
    EventMgr:addEventListener(self,EV_HERO_USE_ITEM_UP_SPRIT,handler(self.updateSkillUI, self))
    EventMgr:addEventListener(self,EV_HERO_REFRESH_SPRIT,handler(self.updateSkillUI, self))
    
    for i, foo in ipairs(self.attr_infos) do
        foo.root:setTouchEnabled(true)
        foo.root:onClick(function()
            self:selectAttrItem(i)
        end)
    end

    self:setBackBtnCallback(function()
        local addNum = 0
        for k,v in pairs(self.changedPoints) do
            addNum = addNum + v
        end
        if addNum > 0 then
            showChooseMessageBox(nil, TextDataMgr:getText(1329127), function()
                local points = {}
                for k, v in pairs(self.changedPoints) do
                    local cfg = self.propertyCfgs[tonumber(k)]
                    table.insert(points, {cfg.id, v})
                end
                AlertManager:close()
                HeroDataMgr:putSpiritPoints(points)
            end,function()
                AlertManager:closeLayer(self)
                AlertManager:close()
            end)
        else
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_reset:onClick(function()
        Utils:openView("fairyNew.FairyEnergyResetView",{energyType = self.selectAttrIdx})
    end)

    self.Button_ok:onClick(function()
        local addNum = 0
        for k,v in pairs(self.changedPoints) do
            addNum = addNum + v
        end
        if addNum < 1 then
            return
        end
        local points = {}
        for k, v in pairs(self.changedPoints) do
            local cfg = self.propertyCfgs[tonumber(k)]
            table.insert(points, {cfg.id, v})
        end
        HeroDataMgr:putSpiritPoints(points)
    end)

    self:addMEListener(TFWIDGET_ENTERFRAME,handler(self.update,self))
end

return FairyEnergyUseView
