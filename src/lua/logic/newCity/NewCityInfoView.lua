local NewCityInfoView = class("NewCityInfoView", BaseLayer)

function NewCityInfoView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.newCity.newCityInfoView")
end

function NewCityInfoView:registerEvents()
    if NewCityDataMgr.curCityType ~= EC_NewCityType.NewCity_Normal and NewCityDataMgr.curCityType ~= EC_NewCityType.NewCity_Update then
        EventMgr:addEventListener(self, EV_NEWCITY_DATING_EVENT.refreshNewCityInfo, handler(self.onCityInfoUpdate, self))
    end
    EventMgr:addEventListener(self, EV_FUNC_NEW_FOOD, handler(self.checkCookFood, self)) 
    EventMgr:addEventListener(self, EV_FUNC_MANUAL_RED_POINT, handler(self.checkShougongRedPoint, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRedTips, handler(self.checkJianzhiRedPoint, self))
end

function NewCityInfoView:initData(bhidetop,fairyLayer)
    self.bHideTop = bhidetop or false
	self.fairyLayer = fairyLayer
end

function NewCityInfoView:initUI(ui)
    self.super.initUI(self,ui)

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_attItem = Panel_prefab:getChild("Panel_attItem")

    self.datingTips = TFDirector:getChildByPath(ui, "Image_datingTips")
    self.datingTips.name = self.datingTips:getChild("Label_name")
    self.datingTips.time = self.datingTips:getChild("Label_time")
    self.datingTips.head = self.datingTips:getChild("Image_headBg"):getChild("Image_head")
    self.datingTips:hide()

    self.Panel_top = TFDirector:getChildByPath(ui, "Panel_top")
    self.Label_place = self.Panel_top:getChild("Label_place")
    self.Label_weather1 = self.Panel_top:getChild("Label_weather1")
    self.Image_weather2 = self.Panel_top:getChild("Image_weather2")
    self.Label_weather3 = self.Panel_top:getChild("Label_weather3")
    self.Button_back = self.Panel_top:getChild("Button_back")
    self.Button_main = self.Panel_top:getChild("Button_main")
    self.Button_back:onClick(function()
        self.Button_back:Touchable(false)
        if cityController then
            cityController:exitCity()
        end
        AlertManager:changeScene(SceneType.MainScene)
        if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_FuBen then
            --FubenDataMgr:openFuben()
        end
    end)
    self.Button_main:onClick(function()
        self.Button_main:Touchable(false)
        if cityController then
            cityController:exitCity()
        end
        AlertManager:changeScene(SceneType.MainScene)
    end)
    self.Label_time = self.Panel_top:getChild("Label_time")
    self.Label_time:Touchable(true)
    self.Label_time:onClick(function()
        local prompt = ""
        if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine then
            prompt = TabDataMgr:getData("FavorStep", NewCityDataMgr:getMainLineData().stepId).prompt
        elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Outside then
            prompt = TabDataMgr:getData("OutsideStep", NewCityDataMgr:getOutsideData().stepId).prompt
        elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_FuBen then
            prompt = TabDataMgr:getData("NovelStep", NewCityDataMgr:getFubenLineData().stepId).prompt
        end
        Utils:showTips(prompt)
    end)

    self.Button_bag = TFDirector:getChildByPath(ui, "Button_bag")
    self.Button_info = TFDirector:getChildByPath(ui, "Button_info")
    self.Button_wenquan = TFDirector:getChildByPath(ui, "Button_wenquan")
    self.Button_jianzhi = TFDirector:getChildByPath(ui, "Button_jianzhi")
    self.Button_zhizuo = TFDirector:getChildByPath(ui, "Button_zhizuo")
    self.Button_liaoli = TFDirector:getChildByPath(ui, "Button_liaoli")
    self.liaoliNewtip = TFDirector:getChildByPath(self.Button_liaoli, "Image_newtip")
    self.shougongNewtip = TFDirector:getChildByPath(self.Button_zhizuo, "Image_newtip")
    self.jianzhiNewtip = TFDirector:getChildByPath(self.Button_jianzhi, "Image_newtip")

    self.Button_bag:onClick(function()
        local view = nil
        if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine then
            local bagdata = NewCityDataMgr:getMainLineData().bag or {}
            view = requireNew("lua.logic.newCity.NewCityDatingBagView"):new(bagdata)
        elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Outside then
            local bagdata = NewCityDataMgr:getOutsideData().bag or {}
            view = requireNew("lua.logic.newCity.NewCityDatingBagView"):new(bagdata)
        elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_FuBen then
            local bagdata = NewCityDataMgr:getFubenLineData().bag or {}
            view = requireNew("lua.logic.newCity.NewCityDatingBagView"):new(bagdata)
        else
            local bagdata = GoodsDataMgr:getBag(EC_Bag.NEWCITY) or {}
            view = requireNew("lua.logic.newCity.NewCityBagView"):new(bagdata)
        end
        AlertManager:addLayer(view, AlertManager.BLOCK_CLOSE, AlertManager.TWEEN_1)
        AlertManager:show()
    end)
    self.Button_info:onClick(function()
        local view = requireNew("lua.logic.newCity.NewCityPersonalInfoView"):new()
        AlertManager:addLayer(view, AlertManager.BLOCK_CLOSE, AlertManager.TWEEN_1)
        AlertManager:show()
    end)
    self.Button_wenquan:onClick(function()
        if NewCityDataMgr:getBuildFuncIsOpen(2) then
            cityController:jumpToFun(2)
        else
            Utils:showTips(12217)
        end
    end)
    self.Button_jianzhi:onClick(function()
        if NewCityDataMgr:getBuildFuncIsOpen(1) then
            cityController:jumpToFun(1)
            GameGuide:checkGuideEnd(self.guideFuncId)
        else
            Utils:showTips(12216)
        end
    end)
    self.Button_zhizuo:onClick(function()
        if NewCityDataMgr:getBuildFuncIsOpen(3) then
            cityController:jumpToFun(3)
        else
            Utils:showTips(12215)
        end
    end)
    self.Button_liaoli:onClick(function()
        if NewCityDataMgr:getBuildFuncIsOpen(4) then
            cityController:jumpToFun(4)
        else
            Utils:showTips(12215)
        end
    end)

    self.Panel_att = TFDirector:getChildByPath(ui, "Panel_att")

    if self.bHideTop then
        self.Panel_top:hide()
    else
        self.Button_wenquan:hide()
        self.Button_jianzhi:hide()
        self.Button_zhizuo:hide()
        self.Button_liaoli:hide()
        self:onCityInfoUpdate()
    end

    self:checkCookFood()
    self:checkShougongRedPoint()
    self:checkJianzhiRedPoint()
    
    self:timeOut(function()
        GameGuide:checkGuide(self);
    end,0.02)
end

--检测是否有可烹饪的料理
function NewCityInfoView:checkCookFood()

    local isNewLiaoli = false
    for foodType=1,3 do
        isNewLiaoli = MakeFoodDataMgr:existCookFood(foodType)
        if isNewLiaoli then
            break
        end 
    end
    self.liaoliNewtip:setVisible(isNewLiaoli)
end

function NewCityInfoView:checkShougongRedPoint()
    local flag = ManualMakeDataMgr:checkRedPoint()
    self.shougongNewtip:setVisible(flag)
end

function NewCityInfoView:checkJianzhiRedPoint()
    local flag = CityJobDataMgr:checkJobEventDown()
    self.jianzhiNewtip:setVisible(flag)
end

function NewCityInfoView:createAttributeInfo()
    local idList = RoleDataMgr:getDatingVariableToRole(RoleDataMgr:getCurId())
    local attribute = NewCityDataMgr:getMainLineData().quality or {}
    local ScrollView_att = self.Panel_att:getChild("ScrollView_att")
    if not self.ListView_att then
        self.ListView_att = UIListView:create(ScrollView_att)
    end
    self.ListView_att:removeAllItems()

    for k, v in pairs(idList) do
        local attr = attribute[v]
        local variableconf = TabDataMgr:getData("DatingVariable", v)
        local attitem = self.Panel_attItem:clone():show()
        attitem:getChild("Image_attr_icon"):setTexture(variableconf.icon)
        local attrname = attitem:getChild("Label_attr_name")
        --local attnum = attitem:getChild("Label_attr")
        local valuemax = math.abs(variableconf.limit[2] - variableconf.limit[1])
        local percent = 0
        local namestr = TextDataMgr:getText(variableconf.name)
        if attr then
            attrname:setText(namestr)
            --attnum:setText(tostring(attr.value).."/"..tostring(variableconf.limit[2]))
            percent = me.clampf(attr.value / valuemax, 0, 1)
        else
            attrname:setText(namestr)
            --attnum:setText(tostring(variableconf.initialValue).."/"..tostring(variableconf.limit[2]))
            percent = me.clampf(variableconf.initialValue / valuemax, 0, 1)
        end
        local Panel_progress = attitem:getChild("Panel_progress")
        local progressidx = math.floor(percent*100/10)
        for i = 1, 10 do
            local image_progress = Panel_progress:getChild("Image_progress"..i)
            if i <= progressidx then
                image_progress:setTexture("ui/newCity/city_main/jindu"..i..".png")
            else
                image_progress:setTexture("ui/newCity/city_main/jindubg.png")
            end
        end
        self.ListView_att:pushBackCustomItem(attitem)
    end
end

function NewCityInfoView:onCityInfoUpdate()
    local time = 0
    local stepconf = nil
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine then
        self.Panel_att:show()
        self:createAttributeInfo()
        time = NewCityDataMgr:getMainLineData().stepTime
        stepconf = TabDataMgr:getData("FavorStep", NewCityDataMgr:getMainLineData().stepId)
    elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Outside then
        self.Panel_att:hide()
        time = NewCityDataMgr:getOutsideData().stepTime
        stepconf = TabDataMgr:getData("OutsideStep", NewCityDataMgr:getOutsideData().stepId)
    elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_FuBen then
        self.Panel_att:hide()
        time = NewCityDataMgr:getFubenLineData().stepTime
        stepconf = TabDataMgr:getData("NovelStep", NewCityDataMgr:getFubenLineData().stepId)
    end
    local h = math.floor(time / 3600)
    local m = math.floor(time % 3600 / 60)
    local s = math.floor(time % 60)
    self.Label_time:setText(string.format("%02d:%02d:%02d", h, m, s))
    self.Label_weather1:setTextById(stepconf.weather1)
    self.Image_weather2:setTexture(stepconf.weather2)
    self.Label_weather3:setTextById(stepconf.weather3)
end

function NewCityInfoView:datingTipsUpdate(info)
    info = info or {}
    self.datingTips:show()
    local time = info.timeStr or ""
    local buildid = info.buildId or 101
    local roleid = info.roleId or 101
    self.datingTips.name:setText(time)
    self.datingTips.time:setTextById(TabDataMgr:getData("NewBuild", buildid).nameId)
    self.datingTips.head:setTexture(TabDataMgr:getData("Role", roleid).smallIcon)
end

function NewCityInfoView:hideDatingTips()
    self.datingTips:hide()
end



---------------------------guide------------------------------

--引导装备质点
function NewCityInfoView:excuteGuideFunc16001(guideFuncId)
    local targetNode = self.Button_jianzhi
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

--引导装备质点
function NewCityInfoView:excuteGuideFunc1006(guideFuncId)
	if self.fairyLayer then
		local targetNode = self.fairyLayer.ListView_fair:getItems()[1]
		self.guideFuncId = guideFuncId
		GameGuide:guideTargetNode(targetNode)
		self.fairyLayer.guideFuncId = guideFuncId
	end
end

return NewCityInfoView