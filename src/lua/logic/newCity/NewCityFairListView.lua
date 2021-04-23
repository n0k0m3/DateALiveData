local NewCityFairListView = class("NewCityInfoView", BaseLayer)

function NewCityFairListView:ctor(fairclickfunc)
    self.super.ctor(self)
    self:initData(fairclickfunc)
    self:init("lua.uiconfig.newCity.newCityFairListView")
end

function NewCityFairListView:registerEvents()
    EventMgr:addEventListener(self, EV_ELVES_EVENT.state, handler(self.onCreateFairList, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.getMainList, handler(self.onGetMainListHandle, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.getMainReward, handler(self.onGetRewardHandle, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onGetRewardHandle, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRole, handler(self.onGetRewardHandle, self))
    EventMgr:addEventListener(self, EV_CITY_OPEN_ROOM, handler(self.openRoomHandle, self))
    EventMgr:addEventListener(self, EV_GETFAVORDATING_REWARD, handler(self.onGetRewardHandle, self))
end

function NewCityFairListView:initData(fairclickfunc)
    self.fairclickfunc = fairclickfunc
    self.fairIconTb = {}
    self.selectRoleId = nil
    self.funcList = {
        [1] = {
            action = function()
                if self.fairclickfunc then
                    self.fairclickfunc(self.selectRoleId)
                end
            end,

            checkVisible = function ()
                return true
            end
        },
        [2] ={
            action = function()
                local state = RoleDataMgr:getNewDayDatingState()
                if state == EC_DatingScriptState.NO_FINISH then
                    DatingDataMgr:showDatingLayer(EC_DatingScriptType.FAVOR_SCRIPT,nil,true)
                    return
                end
                Utils:openView("dating.DatingLetterViewNew")
                --RoleDataMgr:sendGetMainMsg(RoleDataMgr:getCurId())
            end,

            checkVisible = function ()
                local mainLiveList = RoleDataMgr:getMainList(self.selectRoleId)
                return #mainLiveList > 0
            end
        },
        [3] ={
            action = function()
                local state = RoleDataMgr:getDayDatingState()
                if state == EC_DatingScriptState.NO_FINISH then
                    DatingDataMgr:showDatingLayer(EC_DatingScriptType.DAY_SCRIPT,nil,true)
                    return
                end
                if not DispatchDataMgr:checkIsDispatching(EC_DISPATCHType.DATING) then
                    Utils:openView("dating.NewDatingDayView")
                end
            end,

            checkVisible = function ()
                local buildData_ = RoleDataMgr:getDayBuildList(self.selectRoleId)
                return #buildData_ > 0
            end
        },
        [4] ={
            action = function()
                --Utils:openView("dating.DatingPokedexSpriteView")
                FunctionDataMgr:jPokedex()
            end,
            checkVisible = function ()
                return true
            end
        }
    }
end

function NewCityFairListView:initUI(ui)
    self.super.initUI(self,ui)

    self.Panel_list = TFDirector:getChildByPath(ui, "Panel_list")
    local ScrollView_fair = TFDirector:getChildByPath(ui, "ScrollView_fair")
    self.ListView_fair = UIListView:create(ScrollView_fair)

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_fair = Panel_prefab:getChild("Panel_fair")

    self.Panel_func = TFDirector:getChildByPath(ui, "Panel_func")

    self:onCreateFairList()
end

function NewCityFairListView:onCreateFairList()
    self.ListView_fair:removeAllItems()
    local fairlist = RoleDataMgr:getRoleIdList() or {}
    self.selectRoleId = nil
    --dump(fairlist, "fairlist")
    for i, v in ipairs(fairlist) do
        if RoleDataMgr:getIsHave(v) then
            local fairitem = self.Panel_fair:clone():show()
            self.fairIconTb[tostring(v)] = fairitem
            fairitem:Pos(me.p(0, 0))
            fairitem.ownRoleId = v
            fairitem.panelFunc = fairitem:getChild("Panel_func")
            fairitem.imageState = TFDirector:getChildByPath(fairitem.panelFunc, "Image_state")
            fairitem.labelState = TFDirector:getChildByPath(fairitem.panelFunc, "Label_state")
            fairitem.Image_mainHongdian = TFDirector:getChildByPath(fairitem.panelFunc, "Image_mainHongdian")
            fairitem.Image_dayHongdian = TFDirector:getChildByPath(fairitem.panelFunc, "Image_dayHongdian")
            if fairitem.Image_mainHongdian then
                fairitem.Image_mainHongdian:hide()
                if RoleDataMgr:checkNewMainRewardState(v) then
                    fairitem.Image_mainHongdian:show()
                end
            end
            if fairitem.Image_dayHongdian then
                fairitem.Image_dayHongdian:hide()
                if RoleDataMgr:checkDayRewardState(v)then
                    fairitem.Image_dayHongdian:show()
                end
            end

            fairitem:getChild("Image_head"):setTexture(NewCityDataMgr:getCityRoleModeHead(v) or "")
            self.selectRoleId = v
            for j, l in ipairs(self.funcList) do
                local funcbt = TFDirector:getChildByPath(fairitem.panelFunc, "Button_func"..j)
                local enabled = l.checkVisible()
                funcbt:setTouchEnabled(enabled)
                funcbt:setGrayEnabled(not enabled)
                funcbt:onClick(function()
                    RoleDataMgr:setCurId(fairitem.ownRoleId)
                    l.action()
                    self:openRoomHandle()
                end)
            end
            local state = RoleDataMgr:getElvesShowState(v)
            if state and state > 0 then
                fairitem:getChild("Image_state"):setTexture(EC_FairStateIcon[state])
            end
            fairitem:Touchable(true)
            fairitem:onClick(function(sender)
                if self.selectRoleId == v then
                    self.selectRoleId = nil
                else
                    self.selectRoleId = v
                end
                local nowstate = RoleDataMgr:getElvesShowState(sender.ownRoleId)
                if nowstate == EC_ElvesState.datingReserveRequest or nowstate == EC_ElvesState.datingReserve or nowstate == EC_ElvesState.datingOut then
                    if self.fairclickfunc then
                        self.fairclickfunc(sender.ownRoleId)
                    end
                    self.selectRoleId = nil
                end
                for fk, fv in pairs(self.fairIconTb) do
                    local isshow = (tonumber(fk) == self.selectRoleId)
                    if isshow then
                        fv.panelFunc:stopAllActions()
                        fv.panelFunc:setScaleX(0)
                        fv.panelFunc:runAction(CCScaleTo:create(0.1, 1))
                        fv.panelFunc:show()
                        RoleDataMgr:setCurId(tonumber(fk))
                        local fairstate = RoleDataMgr:getElvesShowState(tonumber(fk))
                        if fairstate and fairstate > 0 then
                            fv.imageState:show()
                            --RoleDataMgr:setCurId(tonumber(fk))
                            fv.labelState:setTextById(EC_FairStateDescription[fairstate])
                        else
                            fv.imageState:hide()
                        end
                    else
                        if fv.panelFunc:isVisible() then
                            fv.panelFunc:stopAllActions()
                            fv.panelFunc:setScaleX(1)
                            fv.panelFunc:runAction(CCSequence:create({CCScaleTo:create(0.1, 0, 1), CCHide:create()}))
                        end
                    end
                end
                --if self.fairclickfunc then
                --    self.fairclickfunc(v)
                --end
				GameGuide:checkGuideEnd(self.guideFuncId)
            end)
            self.ListView_fair:pushBackCustomItem(fairitem)
        end
    end
    self.selectRoleId = nil
end

function NewCityFairListView:onGetRewardHandle()
    for i, v in ipairs(self.ListView_fair:getItems()) do
        local fairstate = RoleDataMgr:getElvesShowState(v.ownRoleId)
        if fairstate and fairstate > 0 then
            v.imageState:show()
            v.labelState:setTextById(EC_FairStateDescription[fairstate])
        else
            v.imageState:hide()
        end
        v:getChild("Image_state"):setTexture(EC_FairStateIcon[fairstate])
        if v.Image_mainHongdian then
            v.Image_mainHongdian:hide()
            if RoleDataMgr:checkNewMainRewardState(v.ownRoleId) then
                v.Image_mainHongdian:show()
            end
        end
        if v.Image_dayHongdian then
            v.Image_dayHongdian:hide()
            if RoleDataMgr:checkDayRewardState(v.ownRoleId)then
                v.Image_dayHongdian:show()
            end
        end
    end
    --self:onCreateFairList()
end

function NewCityFairListView:openRoomHandle()
    self.selectRoleId = nil
    for fk, fv in pairs(self.fairIconTb) do
        if fv.panelFunc:isVisible() then
            fv.panelFunc:stopAllActions()
            fv.panelFunc:setScaleX(1)
            fv.panelFunc:runAction(CCSequence:create({CCScaleTo:create(0.1, 0, 1), CCHide:create()}))
        end
    end
end

function NewCityFairListView:onGetMainListHandle()
    Utils:openView("dating.DatingLetterViewNew")
end

return NewCityFairListView