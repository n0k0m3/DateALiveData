--[[
version: creator 2.4.1
Author: 张鹏程
Date: 2021-01-18 15:06:36
--]]
local COLOR_RED = ccc3(196,84,93)
local COLOR_BLACK = ccc3(73,106,138)
local DIALOG_STRING = {
    18000020,
    18000021,
    18000022,
    18000023,
    18000024,
    18000025,
    18000026,
    18000027,
    18000028,
    18000029,
    18000030,
    18000031,
    18000032,
    18000033,
    18000034,
}

local FireFactoryView = class("FireFactoryView", BaseLayer)

function FireFactoryView:ctor(...)
    self.super.ctor(self)
    --self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.activity.fireFactoryView")
end

function FireFactoryView:initData()
    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.FIREWORKS_PRODUCT)[1]
    self.activityData = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.items = ActivityDataMgr2:getItems(self.activityId)

    dump(self.activityData)
    self.defaultMaterial = {}
    local price = self.activityData.extendData.price or {}
    for k, v in pairs(price) do
        table.insert(self.defaultMaterial, tonumber(k))
    end
    table.sort(self.defaultMaterial, function(a,b)
        return a < b
    end)

    self.modules = {}
    self.materials = {}
    self.curModule = nil
    self.dialogIndex = 1
    dump(self.activityData)
end

function FireFactoryView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")
    self.Panel_Make = TFDirector:getChildByPath(ui,"Panel_Make")
    self.Panel_Make.origin = self.Panel_Make:getPosition()
    self.Panel_Module = TFDirector:getChildByPath(ui,"Panel_Module")
    self.Button_Make = TFDirector:getChildByPath(ui,"Button_Make")
    self.Button_Storage = TFDirector:getChildByPath(ui,"Button_Storage")
    self.Panel_RawMaterial = TFDirector:getChildByPath(ui,"Panel_RawMaterial")
    self.Panel_Module_Shield = TFDirector:getChildByPath(ui,"Panel_Module_Shield"):hide()
    self.Spine_girl = TFDirector:getChildByPath(ui,"Spine_girl"):show()
    self.Panel_TouchShield = TFDirector:getChildByPath(ui,"Panel_TouchShield"):hide()
    self.dialog = TFDirector:getChildByPath(ui,"dialog"):hide()
    self.dialog.dialogText = TFDirector:getChildByPath(self.dialog,"dialogText"):show()

    self:initView()
end

function FireFactoryView:addDialogTimer()
    local timing = 0
    local timing2 = 0
    local showStart = false
    local function showDialog()
        self.dialog:show() 
        self.dialog.dialogText:setTextById(DIALOG_STRING[self.dialogIndex])
    end
    
    self:timeOut(function()
        showDialog()
    end, 3)  
    if self._dialogTimer == nil then
        self._dialogTimer = TFDirector:addTimer(1000,-1,nil,function()
            if showStart == false then
                timing = timing + 1
            end
            
            if timing > 10 then
                timing = 0
                                   
                showStart = true 
                
                showDialog()
                self.dialogIndex = self.dialogIndex + 1
                if self.dialogIndex > #DIALOG_STRING then
                    self.dialogIndex = 1
                end
            end
            if showStart then
                timing2 = timing2 + 1
                if timing2 > 5 then 
                    showStart = false                                         
                    timing2 = 0
                    self.dialog:hide()
                end
            end               
        end)
    end
end

function FireFactoryView:removeEvents()
    self.super.removeEvents(self)
    if self._dialogTimer then
        TFDirector:stopTimer(self._dialogTimer)
        TFDirector:removeTimer(self._dialogTimer)
        self._dialogTimer = nil
    end
end

function FireFactoryView:initView()
    self:addDialogTimer()
    self:initModule()
    self:initMakeWorks()

    self:selectModule(self.modules[1])
end

function FireFactoryView:initModule()
    for i=1, 5 do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType,self.items[i])

        local module = TFDirector:getChildByPath(self.Panel_Module,"Panel_Module_"..i)
        module.composeId = next(itemInfo.reward)
        module.itemTaskId = self.items[i]
        module.itemInfo = itemInfo

        local cfg = GoodsDataMgr:getItemCfg(module.composeId)

        module.pos = module:getPosition()
        module.btn = TFDirector:getChildByPath(module,"Button")
        module.btn:onClick(function()
            self:selectModule(module)
        end)
        module.brightLit = TFDirector:getChildByPath(module,"brightLit"):show()
        module.brightLit:stopAllActions()
        module.Image_unselect = TFDirector:getChildByPath(module,"Image_unselect"):show()
        module.Image_unselect.label = TFDirector:getChildByPath(module.Image_unselect,"Label_Btn")
        module.Image_unselect.label:setTextById(cfg.nameTextId)
        module.Image_select = TFDirector:getChildByPath(module,"Image_select"):hide()
        module.Image_select.label = TFDirector:getChildByPath(module.Image_select,"Label_Btn")
        module.Image_select.label:setTextById(cfg.nameTextId)
        module.Image_updateTip = TFDirector:getChildByPath(module,"Image_updateTip"):hide()

        
        table.insert(self.modules, module)
    end

    self:updateRedPoint()
end

function FireFactoryView:updateRedPoint()
    for i, module in ipairs(self.modules) do
        local itemInfo = module.itemInfo
        local price = itemInfo.extendData.price
        local enough = true
        for itemId, cost in pairs(price) do
            if GoodsDataMgr:getItemCount(tonumber(itemId)) < cost then
                enough = false
                break
            end
        end
        module.Image_updateTip:setVisible(enough)
    end
end

function FireFactoryView:initMakeWorks()
    --todo spine
    --
    self:initMaterial()
end

function FireFactoryView:onShow()
    self.super.onShow(self)   
    DatingDataMgr:triggerDating(self.__cname, "onShow")
end

function FireFactoryView:registerEvents()
    self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onRespGetReward, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateMaterialNum, self))

    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId, extendData )
        -- body
        if self.activityId == activityId then
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_Storage:onClick(function()
        Utils:openView("activity.2021_spring.FireBagView", self.activityId)
    end)

    self.Spine_girl:addMEListener(TFARMATURE_COMPLETE,function(spine,animationName)
        if animationName == "special1" then
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.curModule.itemTaskId, 1)
            spine:play("idle", true)
            self.Panel_TouchShield:hide()
       end
     end)

    self.Button_Make:onClick(function()
        if self.curModule ==nil then
            Utils:showTips(18000001)
            return
        end

        local notEnoughId, ownNum
        local itemInfo = self.curModule.itemInfo
        local price = itemInfo.extendData.price
        for k,v in pairs(price) do
            local num = GoodsDataMgr:getItemCount(tonumber(k))
            if num < tonumber(v) then
                notEnoughId = tonumber(k)
                ownNum = num
                break;
            end
        end
        if notEnoughId then
            local cfg = GoodsDataMgr:getItemCfg(notEnoughId)
            local text = TextDataMgr:getText(cfg.nameTextId)
            Utils:showTips(18000004, text)
            return
        end

        self.Spine_girl:play("special1")
        self.Panel_TouchShield:show()
    end)

    
end

function FireFactoryView:selectModule(module)
    if self.curModule == module then
        return
    end

    local function doAction(target, moveto, func)
        target:runAction(Sequence:create({moveto, CallFunc:create(
            function()                
                if func then
                    func()
                end               
            end)}))       
    end

    if self.curModule then      
        doAction(self.curModule, MoveTo:create(0.1, self.curModule.pos), function()
            self.curModule.Image_unselect:show()
            self.curModule.Image_select:hide()
            self:unloadMaterial()
        end)
    end

    doAction(module, MoveTo:create(0.1, ccp(module.pos.x, module.pos.y - 25)), function()
        module.Image_unselect:hide()
        module.Image_select:show()
        module.brightLit:stopAllActions()
        module.brightLit:play("main_effect_diaoshi_6")

        self:setupMaterial(module.itemInfo, self.curModule ~= nil)
        self.curModule = module        
    end)
    self.Panel_Module_Shield:setVisible(true)
end

function FireFactoryView:unloadMaterial()

end

function FireFactoryView:initMaterial()
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, self.items[1])
    local price = itemInfo.extendData.price or {}
    for i=1, 5 do        
        local material = TFDirector:getChildByPath(self.Panel_RawMaterial, "Material"..i)                    
        material.Image_Icon = TFDirector:getChildByPath(material, "Image_Icon")
        material.Image_labelbg = TFDirector:getChildByPath(material, "Image_labelbg")
        material.touch = TFDirector:getChildByPath(material, "touch")
        material.touch:setTouchEnabled(true)
        material.touch:setSwallowTouch(true)
        material.Label_num = TFDirector:getChildByPath(material, "Label_num")
        --if i <= 4 then
        local cfg = GoodsDataMgr:getItemCfg(self.defaultMaterial[i])
        material.Image_Icon:setTexture(cfg.iconShow)

        local count = GoodsDataMgr:getItemCount(self.defaultMaterial[i])
        if count > 0 then
            material.Label_num:setColor(COLOR_BLACK)
        else
            material.Label_num:setColor(COLOR_RED)
        end

        material.touch:addMEListener(TFWIDGET_CLICK,function()               
            -- Utils:openView("bag.ItemInfoView", self.defaultMaterial[i], nil, true)
        end)
        material.touch:onTouch(function(event)
            if event.name == "began" then
                material.Image_Icon:setHighLightEnabled(true,false)
            elseif event.name == "ended" then
                material.Image_Icon:setHighLightEnabled(false,false)
                Utils:openView("bag.ItemInfoView", self.defaultMaterial[i])
            end
        end)      
            
        local target = 0
        for u,s in pairs(price) do
            if cfg.id ==  tonumber(u) then
                target = s
                break
            end
        end
        if count >= target then
            material.Label_num:setColor(COLOR_BLACK)
        else
            material.Label_num:setColor(COLOR_RED)
        end

        material.Label_num:setTextById(13202307,count, target)
        --end

        table.insert(self.materials, material)
    end
    -- self.materials[5].Image_Icon:setOpacity(0)
    -- self.materials[5].Image_Icon:setScale(0.2)
    -- self.materials[5].Image_labelbg:hide()
end

function FireFactoryView:updateMaterialNum()
    if self.curModule == nil then
        return
    end
    local itemInfo = self.curModule.itemInfo
    local price = itemInfo.extendData.price or {}
    for k,v in ipairs(self.materials) do
        local cfg = v.cfg
        local count = GoodsDataMgr:getItemCount(cfg.id)
        

        local target = 0
        for u,s in pairs(price) do
            if cfg.id ==  tonumber(u) then
                target = s
                break
            end
        end
        if count >= target then
            v.Label_num:setColor(COLOR_BLACK)
        else
            v.Label_num:setColor(COLOR_RED)
        end

        v.Label_num:setTextById(13202307,count, target)
    end

    self:updateRedPoint()
end

function FireFactoryView:setupMaterial(itemInfo, needUnload)
    local function doAction(pos, call, finishCall)
        if needUnload then
            self.Panel_Make:runAction(Sequence:create({MoveTo:create(0.3, ccp(pos.x-1200, pos.y)), CallFunc:create(function()
                if call then
                    call()
                end
            end), MoveTo:create(0.5, pos), CallFunc:create(function()
                if finishCall then
                    finishCall()
                end
            end)}))
        else
            if call then
                call()
            end
            self.Panel_Make:runAction(Sequence:create({MoveTo:create(0.15, pos), CallFunc:create(function()
                if finishCall then
                    finishCall()
                end
            end)}))
        end
    end

    local function setup()
        -- self.materials[5].Image_Icon:runAction(Sequence:create({Spawn:create({FadeIn:create(0.2), ScaleTo:create(0.2,1)}), CallFunc:create(function()
        --     self.materials[5].Image_labelbg:show()
        -- end)}))
        local index = 1
        local needItems = itemInfo.extendData.price
        local temp = {}
        for k,v in pairs(needItems) do
            table.insert(temp, {id=tonumber(k), num=tonumber(v)})
        end
        table.sort(temp, function(A, B)
            return A.id < B.id
        end)
        for k,v in ipairs(temp) do
            local cfg = GoodsDataMgr:getItemCfg(tonumber(v.id))
            local count = GoodsDataMgr:getItemCount(tonumber(v.id))
            local material = self.materials[index]
            material.cfg = cfg
            material.Label_num:setTextById(13202307,count,v.num)
            print("count",count,v.num)
            if count >= tonumber(v.num) then
                material.Label_num:setColor(COLOR_BLACK)
            else
                material.Label_num:setColor(COLOR_RED)
            end
            material.Image_Icon:setTexture(cfg.iconShow)
            material.touch:setTouchEnabled(true)
            material.touch:setSwallowTouch(true)
            material.touch:addMEListener(TFWIDGET_CLICK,function()
                --Utils:openView("bag.ItemInfoView", tonumber(v.id))
            end)
            material.touch:onTouch(function(event)
                if event.name == "began" then
                    material.Image_Icon:setHighLightEnabled(true,false)
                elseif event.name == "ended" then
                    material.Image_Icon:setHighLightEnabled(false,false)
                    Utils:openView("bag.ItemInfoView", tonumber(v.id))
                end
            end)    
    
            index = index + 1
        end
    end

    doAction(self.Panel_Make.origin, setup, function()
        self.Panel_Module_Shield:setVisible(false)
    end)
end

function FireFactoryView:onRespGetReward(actId, entryID, reward)
    if actId == self.activityId then
        Utils:showReward(reward, nil ,function(items)
            for i=1, #items do
                local item = items[i]
                item:retain()
                local worldpos = item:getParent():convertToWorldSpaceAR(item:getPosition())
                local nodePos = self.Button_Storage:getParent():convertToNodeSpaceAR(worldpos)
                item:removeFromParent(false)                
                item:setPosition(nodePos)
                self.Button_Storage:getParent():addChild(item)
                item:release()

                item:runAction(Sequence:create({Spawn:create({EaseOut:create(MoveTo:create(0.4, self.Button_Storage:getPosition()),0.3), ScaleTo:create(0.5,0.5), RotateTo:create(0.3,-500)}), RemoveSelf:create()}))
            end
        end)
        self:updateMaterialNum()
    end

end



return FireFactoryView