local SkyLadderZonesView = class("SkyLadderZonesView", BaseLayer)

function SkyLadderZonesView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.skyladder.skyladderZonesView")
end

function SkyLadderZonesView:initData()

    local curSubRankId = SkyLadderDataMgr:getCurSubRankId()
    local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg(curSubRankId)
    self.rankId = rankMatchCfg.rankID
    self.curSubRankId = curSubRankId
    self.isScrolling = false
    self.curPartition  = 0 --当前显示阶段

    self.maxFloor = SkyLadderDataMgr:getMaxLevelFloor(curSubRankId)

    self.curFloor = SkyLadderDataMgr:getCurFloor()
    self.monsterAffixCfg = TabDataMgr:getData("MonsterAffix")
    self.bossBuffEffect = rankMatchCfg.bossBuff
end

function SkyLadderZonesView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_base")

    self.Image_top_bg = TFDirector:getChildByPath(self.Panel_root, "Image_top_bg")
    self.Label_zones_name = TFDirector:getChildByPath(self.Image_top_bg, "Label_zones_name")
    self.Label_boss = TFDirector:getChildByPath(self.Image_top_bg, "Label_boss"):hide()
    self.Label_blood = TFDirector:getChildByPath(self.Image_top_bg, "Label_blood")
    self.Label_fight_score = TFDirector:getChildByPath(self.Image_top_bg, "Label_fight_score")
    self.Label_tips_3 = TFDirector:getChildByPath(self.Image_top_bg, "Label_tips_3")
    self.Label_tips_3:setTextById(3202057)
    
    self.Panel_right = TFDirector:getChildByPath(self.ui, "Panel_right")
    local ScrollView_enemy_head = TFDirector:getChildByPath(self.Panel_right, "ScrollView_enemy_head")
    self.ListView_enemy_head = UIListView:create(ScrollView_enemy_head)
    self.ListView_enemy_head:setItemsMargin(10)
    self.affix_text = TFDirector:getChildByPath(self.Panel_right, "affix_text")
    self.Label_pass_score = TFDirector:getChildByPath(self.Panel_right, "Label_pass_score")
    self.Label_skill_tip = TFDirector:getChildByPath(self.Panel_right, "Label_skill_tip")
    self.Label_skill_tip:setTextById(3203003)
    self.Button_fight =  TFDirector:getChildByPath(self.Panel_right, "Button_fight")
    local ScrollView_zone_effect = TFDirector:getChildByPath(self.Panel_right, "ScrollView_zone_effect")
    self.ListView_Buffs = UIListView:create(ScrollView_zone_effect)
    self.ListView_Buffs:setItemsMargin(5)
    self.Label_Boss_buff = TFDirector:getChildByPath(self.Panel_right, "Label_Boss_buff")
    self.Image_more_effect = TFDirector:getChildByPath(self.Panel_right, "Image_more_effect")

    self.Panel_left = TFDirector:getChildByPath(self.ui, "Panel_left")
    self.Panel_content = TFDirector:getChildByPath(self.Panel_left, "Panel_content")
    self.Panel_level = TFDirector:getChildByPath(self.Panel_left, "Panel_level")
    self.Image_level_select = TFDirector:getChildByPath(self.Panel_left, "Image_level_select"):hide()
    self.Image_level_select:setZOrder(2)
    self.Panel_lines      = TFDirector:getChildByPath(self.Panel_left, "Panel_lines")
    self.Button_right = TFDirector:getChildByPath(self.Panel_left, "Button_right")
    self.Button_left = TFDirector:getChildByPath(self.Panel_left, "Button_left")

    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Image_page_item = TFDirector:getChildByPath(self.Panel_prefab, "Image_page_item")
    self.Image_level_item   = TFDirector:getChildByPath(self.Panel_prefab, "Image_level_item")
    self.Image_enemy_head_item = TFDirector:getChildByPath(self.Panel_prefab, "Image_enemy_head_item")
    self.Panel_effect_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_effect_item")

    local size = self.Panel_level:getContentSize()
    self.pnlBaseSize = CCSizeMake(size.width, size.height)
    size.width = size.width*10
    self.Panel_level:setContentSize(size)
    self.Panel_lines:setContentSize(size)

    self:initUILogic()
end

function SkyLadderZonesView:initUILogic()

    self:updateRankInfo()
    self:initPageItem()
    self:updateLevelInfo()

    local jumpFloor = self.curFloor
    local passFloor = SkyLadderDataMgr:isPassFloor(self.curSubRankId,self.curFloor)
    if passFloor then
        jumpFloor = self.curFloor + 1
        if jumpFloor > self.maxFloor then
            jumpFloor = self.maxFloor
        end
    end

    self:scrollToPage(jumpFloor,0)
    self:updateBuffs()
end

function SkyLadderZonesView:updateBuffs()

    self.ListView_Buffs:removeAllItems()
    local curCircleInfo =  SkyLadderDataMgr:getCurCircleInfo()
    if not curCircleInfo then
        return
    end
    self.regionBuffs = curCircleInfo.regionBuffs or {}
    for k,v in ipairs(self.regionBuffs) do
        local effectItem = self.Panel_effect_item:clone()
        local buffCfg = SkyLadderDataMgr:getRankMatchBuff(v)
        local Label_tip = TFDirector:getChildByPath(effectItem, "Label_tip")
        Label_tip:setTextById(buffCfg.buffDescribe)
        Label_tip:setDimensions(426, 0)
        local h = Label_tip:getContentSize().height
        effectItem:setContentSize(CCSizeMake(488,h))
        self.ListView_Buffs:pushBackCustomItem(effectItem)
    end
end

function SkyLadderZonesView:initPageItem()

    self.pageItem = {}
    local size = self.Image_page_item:getContentSize()
    local newConetentSize = CCSizeMake(size.width*self.maxFloor, size.height)
    self.Panel_content:setContentSize(newConetentSize)
    self.Panel_content:setPosition(ccp(0,0))
    local firstPosX = -newConetentSize.width/2+19
    for i=1,self.maxFloor do
        local pageImgItem = self.Image_page_item:clone()
        pageImgItem:setPosition(ccp(firstPosX+(i-1)*size.width,0))
        self.Panel_content:addChild(pageImgItem)
        self.pageItem[i] = pageImgItem
    end
end

function SkyLadderZonesView:updateRankInfo()

    local curCircleInfo = SkyLadderDataMgr:getCurCircleInfo()
    if not curCircleInfo then
        return
    end

    local curSubRankId = curCircleInfo.segment
    local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg(curSubRankId)
    if not rankMatchCfg then
        return
    end

    local rankId = rankMatchCfg.rankID
    self.Image_top_bg:setTexture(EC_SkyLadderBorard[rankId])

    self.regionName = TextDataMgr:getText(rankMatchCfg.regionName)
    self.Label_zones_name:setColor(EC_SkyLadderColor[rankId])

    --self.Label_boss:setVisible(self.curFloor == self.maxFloor)
    self.Label_blood:setText(rankMatchCfg.bleedLevel)

    local battleScore = SkyLadderDataMgr:getBattleScore()
    self.Label_fight_score:setText(battleScore)

    local buffCfg = SkyLadderDataMgr:getRankMatchBuff(self.bossBuffEffect)
    self.Label_Boss_buff:setTextById(buffCfg.buffDescribe)
    self.Label_Boss_buff:setDimensions(426, 0)
end

function SkyLadderZonesView:updateLevelInfo()

    self.tabEvoItem = {}
    local pnlSize  = self.pnlBaseSize
    for floor=1, self.maxFloor do
        self.tabEvoItem[floor] = {}
        local levelInfo  = SkyLadderDataMgr:getRankLevelByFloor(self.curSubRankId,floor)
        for i, v in ipairs(levelInfo) do
            local img = self:createLevelItem(v,floor)
            local pos = clone(SkyLadderDataMgr:getLevelItemPos(v.positionOrder))
            img:setVisible(true)
            pos.x = pos.x + (floor-1)*pnlSize.width
            img:setPosition(pos)
            img:setZOrder(1)
            self.Panel_level:addChild(img)
            self.tabEvoItem[floor][v.positionOrder] = img
        end
    end

    self:updateLines()
end

function SkyLadderZonesView:updateLines()

    self.tabEvoLine = {}
    self.Panel_lines:removeAllChildren()
    --初始化突破点连线
    for page=1, self.maxFloor do
        local lineCount = 0
        local levelInfo  = SkyLadderDataMgr:getRankLevelByFloor(self.curSubRankId,page)
        for i, v in ipairs(levelInfo) do
            for i2, v2 in ipairs(v.neighbor) do
                local key = page.."-"..v.positionOrder.."-"..v2
                local key2 = page.."-"..v2.."-"..v.positionOrder
                if not self.tabEvoLine[key] and not self.tabEvoLine[key2] then
                    local startItem = self.tabEvoItem[page][v.positionOrder]
                    local endItem   = self.tabEvoItem[page][v2]
                    if startItem and endItem then
                        local startPos = ccp(startItem:getPosition())
                        local endPos   = ccp(endItem:getPosition())
                        local line = TFImage:create("ui/skyladder/zones/010.png")

                        local posX,posY = (startPos.x + endPos.x)/2,(startPos.y + endPos.y)/2
                        line:setAnchorPoint(ccp(0.5, 0.5))
                        line:setPosition(ccp(posX,posY))

                        local angle = HeroDataMgr:getAngleByPos(ccp(posX,posY),endPos)
                        line:setRotation(angle)

                        self.Panel_level:addChild(line,0,0)

                        self.tabEvoLine[key] = line
                        self.tabEvoLine[key2] = line

                        lineCount = lineCount + 1
                    end
                end
            end
        end

    end

end

function SkyLadderZonesView:createLevelItem(data,floor)

    local item = self.Image_level_item:clone()
    item:setVisible(true)
    item.data = data

    local icon = TFDirector:getChildByPath(item, "Image_level_icon")
    icon:setTexture(data.icon)

    local Image_lock = TFDirector:getChildByPath(item, "Image_lock")
    if floor == 1 then
        Image_lock:setVisible(false)
    else
        local preFloors = floor-1
        local passFloor = SkyLadderDataMgr:isPassFloor(data.rankID,preFloors)
        Image_lock:setVisible(not passFloor)
    end

    local Image_finish = TFDirector:getChildByPath(item, "Image_finish")
    local isPass = SkyLadderDataMgr:isPasslevel(data.id)
    Image_finish:setVisible(isPass)
    local Image_boss = TFDirector:getChildByPath(item, "Image_boss")
    Image_boss:setVisible(data.isBoss)

    item:setTouchEnabled(true)
    item:setSwallowTouch(false)
    item:onClick(function()
        if not self.isScrolling then
            self:selectLevelItem(item,floor)
        end
    end)

    return item
end

---选择关卡
function SkyLadderZonesView:selectLevelItem(item,floor)
    if not item then
        return
    end

    self.selectItem = item

    local positionOrder = item.data.positionOrder
    local pos = SkyLadderDataMgr:getLevelItemPos(positionOrder)
    if pos then
        local x = pos.x + (floor-1)*self.pnlBaseSize.width
        self.Image_level_select:setVisible(true)
        self.Image_level_select:setPosition(ccp(x,pos.y))
    end

    self.ListView_enemy_head:removeAllItems()

    local levelCid = item.data.id

    SkyLadderDataMgr:setLastSelectLevelCid(levelCid)

    local affixName = ""
    local affixNameCnt = 0
    local monsterShow = item.data.monsterShow
    local lastAffixStr = {}
    for k,monsterId in ipairs(monsterShow) do
        local headItem = self.Image_enemy_head_item:clone()
        local monsterCfg = TabDataMgr:getData("Monster", monsterId)
        local Image_head = TFDirector:getChildByPath(headItem, "Image_head")
        Image_head:setTexture(monsterCfg.fightIcon)
        self.ListView_enemy_head:pushBackCustomItem(headItem)
        local monsterAffix  = monsterCfg.monsterAffix or {}
        for k,v in ipairs(monsterAffix) do
            if affixNameCnt < 5 then
                local affixTextId = self.monsterAffixCfg[v].affixName[1]
                local affixStr = TextDataMgr:getText(affixTextId)
                if not lastAffixStr[affixTextId] then
                    if k == 1 then
                        affixName = affixName..affixStr
                    else
                        affixName = affixName..","..affixStr
                    end
                    affixNameCnt = affixNameCnt + 1
                    lastAffixStr[affixTextId] = 1
                end
            end
        end
    end
    self.affix_text:setText(affixName)

    ---通关评分
    if item.data.timeRate > 0 then
        self.Label_pass_score:setTextById(3202012,item.data.passRate,item.data.timeRate)
    else
        self.Label_pass_score:setTextById(3202013,item.data.passRate)
    end

    local step = SkyLadderDataMgr:getStep()
    if step ~= EC_SKYLADDER_STEP.PROCCED then
        self.Button_fight:setGrayEnabled(true)
        self.Button_fight:setTouchEnabled(false)
        return
    end

    local isPass = SkyLadderDataMgr:isPasslevel(levelCid)
    local repeatFight = item.data.isAgain
    if repeatFight then
        self.Button_fight:setTouchEnabled(true)
        self.Button_fight:setGrayEnabled(false)
    else
        self.Button_fight:setTouchEnabled(not isPass)
        self.Button_fight:setGrayEnabled(isPass)
    end

end

function SkyLadderZonesView:scrollToPage(pageIndex, dt)
    if self.isScrolling then
        return
    end
    if not pageIndex then
        return
    end
    if pageIndex<1 or pageIndex>self.maxFloor then
        return
    end
    if pageIndex == self.curPartition then
        return
    end
    local moveToX = (pageIndex-1) * -self.pnlBaseSize.width
    dt = dt or 0.3
    local moveEvo = CCMoveTo:create(dt, ccp(moveToX, -3))
    local callEvo = CCCallFunc:create(function()
        self.isScrolling = false
    end)
    local moveLine = CCMoveTo:create(dt, ccp(moveToX, -3))
    local callLine = CCCallFunc:create(function()
        self.isScrolling = false
    end)
    local seqLine  = CCSequence:create({moveLine, callLine})
    local seqEvo  = CCSequence:create({moveEvo, callEvo})

    self.isScrolling = true
    self.Panel_level:stopAllActions()
    self.Panel_lines:stopAllActions()
    self.Panel_level:runAction(seqEvo)
    self.Panel_lines:runAction(seqLine)
    self.curPartition = pageIndex

    for i=1,self.maxFloor do
        local pageImgRes = self.curPartition == i and "ui/common/page_controller_select.png" or "ui/common/page_controller_normal.png"
        self.pageItem[i]:setTexture(pageImgRes)
    end

    self.Button_left:setVisible(self.curPartition ~= 1)
    self.Button_right:setVisible(self.curPartition ~= self.maxFloor)

    self.Label_zones_name:setText(self.regionName.." #"..self.curPartition)

    local curFloorInfo = self.tabEvoItem[self.curPartition]
    if not curFloorInfo then
        return
    end

    local lastSelectCid = SkyLadderDataMgr:getLastSelectLevelCid()

    local showBossBuffInfo = false
    local selectItem = curFloorInfo[7]
    for k,v in pairs(curFloorInfo) do
        if not selectItem then
            selectItem = v
        end
        local levelCid = v.data.id

        local rankLevelCfg = SkyLadderDataMgr:getRankMatchLevelCfg(levelCid)
        local positionOrder = v.data.positionOrder
        local isPass = SkyLadderDataMgr:isPasslevel(levelCid)
        local lastSeveltIsPass = SkyLadderDataMgr:isPasslevel(lastSelectCid)

        if not lastSelectCid then
            if not isPass and positionOrder < selectItem.data.positionOrder then
                selectItem = v
            end
        else
            if lastSeveltIsPass then
                if not isPass and positionOrder < selectItem.data.positionOrder then
                    selectItem = v
                end
            else
                if lastSelectCid == levelCid then
                    selectItem = v
                end
            end
        end

        if not rankLevelCfg.isBoss and not isPass then
            showBossBuffInfo = true
        end
    end

    if showBossBuffInfo then
        SkyLadderDataMgr:setBossBuffs(clone(self.bossBuffEffect))
    else
        SkyLadderDataMgr:setBossBuffs()
    end

    self.Image_more_effect:setVisible(showBossBuffInfo)
    self:selectLevelItem(selectItem,self.curPartition)
end

function SkyLadderZonesView:fight()

    if not self.selectItem then
        return
    end

    if self.curPartition ~= 1 then
        local preFloors = self.curPartition-1
        local passFloor = SkyLadderDataMgr:isPassFloor(self.selectItem.data.rankID,preFloors)
        if not passFloor then
            Utils:showTips(3203004)
            return
        end
    end

    local levelCid = self.selectItem.data.id
    local dungeonCfg = SkyLadderDataMgr:getDungeonLevelCfg(levelCid)
    if not dungeonCfg then
        Box("wrong levelCid:"..levelCid)
        return
    end

    HeroDataMgr:changeDataToSkyLadder()
    Utils:openView("fuben.FubenSquadView", EC_FBType.SKYLADDER,EC_ActivityFubenType.SKYLADDER,levelCid)
end

function SkyLadderZonesView:updateBaseInfo()

    self:updateRankInfo()
    local step = SkyLadderDataMgr:getStep()
    if step ~= EC_SKYLADDER_STEP.PROCCED then
        self.Button_fight:setGrayEnabled(true)
        self.Button_fight:setTouchEnabled(false)
        return
    end

end

function SkyLadderZonesView:registerEvents()

    EventMgr:addEventListener(self, EV_SKYLADDER_CURCIRCLE, handler(self.updateBaseInfo, self))

    self.startPos = nil
    local function onTouchBegan(touch, location)
        self.startPos = location
        return true
    end

    local function onTouchMoved(touch, location)
    end

    local function onTouchUp(touch, location)
        local startPos = self.startPos
        local endPos   = location
        local dist     = endPos.x - startPos.x
        if dist >= 40 then
            self:scrollToPage(self.curPartition - 1)
        elseif dist <= -40 then
            self:scrollToPage(self.curPartition + 1)
        end
    end

    self.Panel_level:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan);
    self.Panel_level:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved);
    self.Panel_level:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp);

    self.Button_right:onClick(function ()
        self:scrollToPage(self.curPartition + 1)
    end)

    self.Button_left:onClick(function ()
        self:scrollToPage(self.curPartition - 1)
    end)

    self.Button_fight:onClick(function()

        self:fight()
    end)

end

return SkyLadderZonesView
