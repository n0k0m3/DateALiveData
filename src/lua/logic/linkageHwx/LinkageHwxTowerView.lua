local LinkageHwxTowerView = class("LinkageHwxTowerView",BaseLayer)
local towerLevelType = {
    dating = 0,
    nomal = 1,
    goddess = 2,
    boss = 3
}
function LinkageHwxTowerView:initData()

    self.dungeonCfg = TabDataMgr:getData("DungeonLevel")
    self.floorCfg = TabDataMgr:getData("HwxDungeonFloor")

    self.towerItems_ = {}
end

function LinkageHwxTowerView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.linkageHwx.linkageHwxTowerView")
end

function LinkageHwxTowerView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_time = TFDirector:getChildByPath(self.Panel_root, "Panel_time")
    self.Label_turnNo = TFDirector:getChildByPath(self.Panel_time, "Label_turnNo")
    self.Label_timeDay = TFDirector:getChildByPath(self.Panel_time, "Label_timeDay")
    self.Label_timeHour = TFDirector:getChildByPath(self.Panel_time, "Label_timeHour")

    self.Image_levelPic = TFDirector:getChildByPath(self.Panel_root, "Image_center_bg")
    self.Label_levelName = TFDirector:getChildByPath(self.Panel_root, "Label_level_name")
    local ScrollView_level = TFDirector:getChildByPath(self.Panel_root, "ScrollView_level")

    self.Panel_level_item = TFDirector:getChildByPath(ui, "Panel_level_item")

    self.TurnView_level = UITurnView:create(ScrollView_level)
    self.TurnView_level:setItemModel(self.Panel_level_item)

    local Panel_right = TFDirector:getChildByPath(self.Panel_root, "Panel_right")
    self.Label_theme_des = TFDirector:getChildByPath(Panel_right, "Label_theme_des")
    self.Label_theme_des1 = TFDirector:getChildByPath(Panel_right, "Label_theme_des1")
    self.Label_theme_des1:setTextById(12031162)
    local ScrollView_theme = TFDirector:getChildByPath(Panel_right, "ScrollView_theme")
    self.ListView_theme = UIListView:create(ScrollView_theme)

    self.Image_nv = TFDirector:getChildByPath(Panel_right, "Image_nv")
    self.Label_nv_name = TFDirector:getChildByPath(self.Image_nv, "Label_nv_name")
    self.Label_boss_name = TFDirector:getChildByPath(self.Image_nv, "Label_boss_name")
    self.Label_nv_tip = TFDirector:getChildByPath(self.Image_nv, "Label_nv_tip")
    local ScrollView_nv_desc = TFDirector:getChildByPath(self.Image_nv, "ScrollView_nv_desc")
    self.listview_buff = UIListView:create(ScrollView_nv_desc)
    self.Label_nv_des = TFDirector:getChildByPath(self.Image_nv, "Label_nv_des"):hide()

    local Image_grade = TFDirector:getChildByPath(Panel_right, "Image_grade")
    self.Label_best_time = TFDirector:getChildByPath(Image_grade, "Label_best_time")
    self.Label_best_score = TFDirector:getChildByPath(Image_grade, "Label_best_score")
    self.Label_total_score = TFDirector:getChildByPath(Image_grade, "Label_total_score")

    self.Button_right = TFDirector:getChildByPath(self.Panel_root, "Button_right")
    self.Button_left = TFDirector:getChildByPath(self.Panel_root, "Button_left")

    self.Button_buff = TFDirector:getChildByPath(self.Panel_root, "Button_buff")
    self.Panel_red_tip = TFDirector:getChildByPath(self.Panel_root, "Panel_red_tip"):hide()

    self.Button_fight = TFDirector:getChildByPath(self.Panel_root, "Button_fight")
    self.Label_sfight = TFDirector:getChildByPath(self.Button_fight, "Label_sfight")
    self.Label_sfight:setTextById(12031196)

    self.Label_best_time = TFDirector:getChildByPath(self.Panel_root, "Label_best_time")
    self.Label_best_time:setSkewX(15)
    self.Label_best_score = TFDirector:getChildByPath(self.Panel_root, "Label_best_score")
    self.Label_best_score:setSkewX(15)
    self.Label_total_score = TFDirector:getChildByPath(self.Panel_root, "Label_total_score")
    self.Label_total_score:setSkewX(15)
    self:updateTowerLogic()

end

function LinkageHwxTowerView:updateTowerLogic()
    self:updateTurnInfo()
    self:updateBuffRedTip()
end

function LinkageHwxTowerView:updateBuffRedTip()
    --state：1-锁定。2-可领取。3-已领取
    self.Panel_red_tip:hide()
    local buffState = 1
    for k,v in ipairs(self.floorCfg) do
        if next(v.buffPool) then
            local buffId = LinkageHwxDataMgr:getActiveBuffInfo(v.id)
            if not buffId then
                if v.id < self.targetLevelIndex then
                    buffState = 2
                else
                    if self.targetLevelIndex == #self.floorCfg  and self.bestTime > 0 then
                        buffState = 2
                    else
                        buffState = 1
                    end
                end
            else
                buffState = 3
            end

            if buffState == 2 then
                self.Panel_red_tip:show()
                break
            end
        end
    end


end

function LinkageHwxTowerView:updateTurnInfo()

    ---主题
    self.towerInfo = LinkageHwxDataMgr:getTowerInfo()
    if not self.towerInfo  then
        return
    end

    self.curDungeon = self.towerInfo.base.dungeon

    local dungeon = self.towerInfo.base.dungeonList or {}
    table.sort(dungeon,function(a, b)
        return a.key < b.key
    end)

    self.dungeonList = {}
    for k,v in ipairs(dungeon) do
        table.insert(self.dungeonList, v.value)
    end

    self.bestTime = self.towerInfo.base.bestTime

    local curLevelId = self.towerInfo.base.dungeon
    self.targetLevelIndex = table.indexOf(self.dungeonList,curLevelId)
    self.curLevelIndex = self.targetLevelIndex

    self.ListView_theme:removeAllItems()
    for k,v in ipairs(self.towerInfo.roundBuff) do
        local buffCfg = LinkageHwxDataMgr:getHwxBuffManageCfg(v)
        if buffCfg then
            local themeTextClone = self.Label_theme_des:clone()
            themeTextClone:setTextById(buffCfg.buffDescribe)
            themeTextClone:setDimensions(290,0)
            self.ListView_theme:pushBackCustomItem(themeTextClone)
        end
    end

    self:updateTimeInfo()
    self:updateLevels()
    self:updateFightInfo()
    self:updateSelectLevel()
end

function LinkageHwxTowerView:updateTimeInfo()

    if not self.towerInfo then
        return
    end
    local towerBaseInfo = self.towerInfo.base
    self.Label_turnNo:setText(towerBaseInfo.round)

    local remainTime = towerBaseInfo.endTime - ServerDataMgr:getServerTime()
    remainTime = remainTime < 0 and 0 or remainTime
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    self.Label_timeDay:setText(day*24+hour)
    self.Label_timeHour:setText(min)

    self.Panel_time:runAction(CCRepeatForever:create(CCSequence:create({
        CCDelayTime:create(60),
        CCCallFunc:create(function()
            self:updateTimeInfo()
        end),
    })))
end

function LinkageHwxTowerView:updateFightInfo()

    if not self.towerInfo then
        return
    end

    local day, hour, min, sec = Utils:getDHMS(self.towerInfo.base.bestTime/1000, true)
    self.Label_best_time:setText(min..":"..sec)
    self.Label_best_time:setVisible(self.towerInfo.base.bestTime ~= 0)
    self.Label_best_score:setText(self.towerInfo.base.roundScore)
    self.Label_total_score:setText(self.towerInfo.base.totalScore)

end


function LinkageHwxTowerView:updateLevels()

    for k,v in ipairs(self.dungeonList) do
        if not self.towerItems_[k] then
            local item = self.TurnView_level:pushBackItem()
            self.towerItems_[k] = item
        end
        local Image_icon = TFDirector:getChildByPath(self.towerItems_[k], "Image_icon")
        local displayCfg = LinkageHwxDataMgr:getCityDisplayCfg(v)
        if displayCfg then
            Image_icon:setTexture(displayCfg.invadeIcon)
        end
        local Image_pass = TFDirector:getChildByPath(self.towerItems_[k], "Image_pass")
        Image_pass:setVisible(k < self.targetLevelIndex)

        ---boss关卡
        if k == #self.dungeonList then
            Image_pass:setVisible(self.bestTime ~= 0)
        end
    end

    self.TurnView_level:scrollToItem(self.curLevelIndex)
end

function LinkageHwxTowerView:changeLevel(delta)

    local nextLevelIndex = self.curLevelIndex + delta
    if nextLevelIndex < 1 then
        return
    end
    if nextLevelIndex > #self.dungeonList then
        return
    end
    self.curLevelIndex = nextLevelIndex

    self.TurnView_level:scrollToItem(self.curLevelIndex)
end

function LinkageHwxTowerView:updateSelectLevel()

    self.Button_right:setVisible(self.curLevelIndex < #self.dungeonList)
    self.Button_left:setVisible(self.curLevelIndex > 1)

    local curLevelId = self.dungeonList[self.curLevelIndex]
    if not curLevelId then
        return
    end

    local cfg = self.dungeonCfg[curLevelId]
    if not cfg then
        return
    end

    local foorCfg = self.floorCfg[self.curLevelIndex]
    if not foorCfg then
        return
    end
    local preName = TextDataMgr:getText(foorCfg.name)
    local name = TextDataMgr:getText(cfg.name)
    self.Label_levelName:setText(preName..name)

    local displayCfg = LinkageHwxDataMgr:getCityDisplayCfg(curLevelId)
    if not displayCfg then
        return
    end

    local displayType = displayCfg.displayDetail
    self.Label_nv_name:setVisible(displayType == towerLevelType.goddess)
    self.Label_boss_name:setVisible(displayType == towerLevelType.boss)
    self.Image_nv:setVisible(displayType == towerLevelType.goddess or displayType == towerLevelType.boss)

    local strId = displayType == towerLevelType.goddess and 12031160 or 12031161
    self.Label_nv_tip:setTextById(strId)
    self.Label_nv_tip:setDimensions(300,0)

    self.listview_buff:removeAllItems()
    for i=1,3 do
        local extraDescribe = displayCfg.extraDescribe[i]
        if extraDescribe then
            local buffDesc = self.Label_nv_des:clone()
            buffDesc:show()
            buffDesc:setTextById(extraDescribe)
            buffDesc:setDimensions(300,0)
            self.listview_buff:pushBackCustomItem(buffDesc)
        end
    end

    self.Button_fight:setTouchEnabled(self.targetLevelIndex == self.curLevelIndex)
    self.Button_fight:setGrayEnabled(self.targetLevelIndex ~= self.curLevelIndex)
end

function LinkageHwxTowerView:onTurnViewSelect(target, selectIndex)
    self.curLevelIndex = selectIndex
    self:updateSelectLevel()
end

function LinkageHwxTowerView:fight()

    local levelCid = self.dungeonList[self.curLevelIndex]
    if not levelCid then
        return
    end
    local pass = false
    ---boss关卡
    if self.targetLevelIndex == #self.dungeonList then
        pass = self.bestTime ~= 0
    else
        pass = self.curLevelIndex < self.targetLevelIndex
    end

    local data = {dungeon = levelCid,pass = pass}
    Utils:openView("fuben.FubenSquadView",EC_FBType.HWX_FUBEN,data)

end

function LinkageHwxTowerView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_LINKAGEHWX_BUFF, handler(self.updateBuffRedTip, self))
    EventMgr:addEventListener(self, EV_UPDATE_HWX_TOWER, handler(self.updateTowerLogic, self))

    local function scrollCallback(target, offsetRate, customOffsetRate)
        local items = target:getItem()
        for i, item in ipairs(items) do
            local rate = offsetRate[i]
            local rrate = 1 - rate
            local customRate = customOffsetRate[i]
            if rrate >= 0.9 then
                item:setOpacity(255 * rrate)
            else
                item:setOpacity(200 * rrate)
            end

            item:setPositionZ(-customRate * 100)
            item:setZOrder(rrate * 100)
            item:setScale(rrate*1)
        end
    end

    self.TurnView_level:registerScrollCallback(scrollCallback)
    self.TurnView_level:registerSelectCallback(handler(self.onTurnViewSelect, self))

    self.Button_right:onClick(function()
        self:changeLevel(1)
    end)

    self.Button_left:onClick(function()
        self:changeLevel(-1)
    end)

    self.Button_buff:onClick(function()
        Utils:openView("linkageHwx.LinkageHwxBuffView")
    end)

    self.Button_fight:onClick(function()
        self:fight()
    end)
end

return LinkageHwxTowerView
