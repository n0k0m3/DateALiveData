local PreHalloweenView = class("PreHalloweenView",BaseLayer)

function PreHalloweenView:initData(activityId)

    self.activityId = activityId
    self.activityData = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.ghostId = 1
    dump(self.activityData)

    self.ghostActName = {"_chuxian","_xiaoshi","_xunhuan"}
    self.ghostPreName = "wanshengxiaogui"
    self.ghostTab = {}

end

function PreHalloweenView:ctor(activityId)
    self.super.ctor(self)
    self:initData(activityId)
    self:init("lua.uiconfig.activity.preHalloweenView")
end

function PreHalloweenView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Button_help = TFDirector:getChildByPath(ui,"Button_help")
    self.Panel_ghost = TFDirector:getChildByPath(ui,"Panel_ghost")

    local ScrollView_ghost = TFDirector:getChildByPath(ui,"ScrollView_ghost")
    self.ListView_ghost = UIListView:create(ScrollView_ghost)

    self.act_timeStart = TFDirector:getChildByPath(ui, "act_timeStart")
    self.act_timeEnd = TFDirector:getChildByPath(ui, "act_timeEnd")

    self.ghostAni = {}
    self.Panel_ghostTab = {}
    for i=1,3 do
        self.ghostAni[i] = TFDirector:getChildByPath(ui,"Spine_gost"..i)
        self.ghostAni[i]:stop()

        self.Panel_ghostTab[i] = TFDirector:getChildByPath(ui,"Panel_ghost"..i)
    end

    --ActivityDataMgr2:Send_getGhostInfo()

    --self:initUILogic()
end

function PreHalloweenView:updateActivity()

    local year, month, day = Utils:getDate(self.activityData.startTime)
    local format = TextDataMgr:getText(300324)
    local text = string.format(format, year).. string.format(format, string.format("%.2d", month)).. string.format("%.2d", day).."-"
    self.act_timeStart:setText(text)

    year, month, day = Utils:getDate(self.activityData.endTime)
    text = string.format(format, year).. string.format(format, string.format("%.2d", month)).. string.format("%.2d", day)
    self.act_timeEnd:setText(text)
    self:updateGhost()
end

function PreHalloweenView:updateGhost(isUpdate)

    local newGhost
    local ghostInfo = clone(ActivityDataMgr2:GetGhostInfo())
    if not isUpdate then
        self.ghostTab = ghostInfo
        for k,v in ipairs(self.ghostTab) do
            if v ~= 0 then
                self:updateAnimation(k,true)
                newGhost = true
            end
        end
    else
        for k,v in ipairs(ghostInfo) do
            local oldghostId = self.ghostTab[k] or 0
            if v == 0 and oldghostId ~= 0 then
                self:updateAnimation(k,false)
            end

            if v ~= 0 and oldghostId == 0 then
                newGhost = true
                self:updateAnimation(k,true)
            end
            self.ghostTab[k] = v
        end
    end

    print(newGhost,self.soundHandle)
    if newGhost and not self.soundHandle then
        self.soundHandle = Utils:playSound(6012,true)
    end

end

function PreHalloweenView:onHide()
    self.super.onHide(self)
    if self.soundHandle then
        TFAudio.stopEffect(self.soundHandle)
        self.soundHandle = nil
    end
end


function PreHalloweenView:updateAnimation(pos,isAdd)

    local spineAni = self.ghostAni[pos]
    if not spineAni then
        return
    end

    self.ghostActName = {"_chuxian","_xiaoshi","_xunhuan"}
    self.ghostPreName = "wanshengxiaogui"

    if isAdd then
        spineAni:play(self.ghostPreName..pos..self.ghostActName[1],false)
        spineAni:addMEListener(TFARMATURE_COMPLETE,function()
            self:timeOut(function()
                spineAni:removeMEListener(TFARMATURE_COMPLETE)
                if self.ghostTab[pos] ~= 0 then
                    spineAni:play(self.ghostPreName..pos..self.ghostActName[3],true)
                end
            end, 0)
        end)
    else
        spineAni:stop()
        spineAni:play(self.ghostPreName..pos..self.ghostActName[2],false)
    end

end

function PreHalloweenView:selectGhost(ghostPos)
    local ghostId = self.ghostTab[ghostPos]
    if not ghostId then
        return
    end

    if ghostId == 0 then
        return
    end

    local function callback(award)
        Utils:showReward(award or {})
    end

    local view = requireNew("lua.logic.activity.PreHalloweenGiftView"):new(ghostPos,ghostId,callback)
    AlertManager:addLayer(view, AlertManager.BLOCK)
    AlertManager:show()

end

function PreHalloweenView:hideActivityModel()

    if self.soundHandle then
        TFAudio.stopEffect(self.soundHandle)
        self.soundHandle = nil
    end
end


function PreHalloweenView:registerEvents()

    EventMgr:addEventListener(self, EV_PRE_HALLOWEEN_GHOST, handler(self.updateGhost, self))
    self.Button_help:onClick(function()
        Utils:openView("common.HelpView", {997})
        --local event = {}
        --event.data = {}
        --local phantomInfo = {}
        --table.insert(phantomInfo,{pos = 1,phantomId = 2})
        --table.insert(phantomInfo,{pos = 2,phantomId = 0})
        --table.insert(phantomInfo,{pos = 3,phantomId = 1})
        --event.data.phantomInfo = phantomInfo
        --event.data.type = 2
        --ActivityDataMgr2:onRespGhostInfo(event)
    end)

    --self.Panel_ghost:onClick(function()
    --    --self:selectGhost(1,3)
    --    --Utils:openView("common.HelpView", {997})
    --    local event = {}
    --    event.data = {}
    --    local phantomInfo = {}
    --    table.insert(phantomInfo,{pos = 1,phantomId = 0})
    --    table.insert(phantomInfo,{pos = 2,phantomId = 0})
    --    table.insert(phantomInfo,{pos = 3,phantomId = 0})
    --    event.data.phantomInfo = phantomInfo
    --    event.data.type = 2
    --
    --    ActivityDataMgr2:onRespGhostInfo(event)
    --end)

    for k,v in ipairs(self.Panel_ghostTab) do
        v:onClick(function()
            self:selectGhost(k)
        end)
    end
end



return PreHalloweenView