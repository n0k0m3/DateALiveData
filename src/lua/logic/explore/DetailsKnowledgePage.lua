local DetailsKnowledgePage = class("DetailsKnowledgePage", BaseLayer)


function DetailsKnowledgePage:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.explore.detailsKnowledgePage")
end

function DetailsKnowledgePage:initData()

    --ExploreDataMgr:Send_ExploreTechInfos()
end

function DetailsKnowledgePage:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui,"Panel_root")
    self.ScrollView_item = TFDirector:getChildByPath(self.ui,"ScrollView_item")

    self.Panel_items = TFDirector:getChildByPath(self.ui,"Panel_items")
    self.panel_point = TFDirector:getChildByPath(self.ui,"panel_point")

    self.contentSize = self.ScrollView_item:getContentSize()

    self.Image_details_bg = TFDirector:getChildByPath(self.Panel_root,"Image_details_bg")
    self.Label_name = TFDirector:getChildByPath(self.Image_details_bg,"Label_name")
    local Image_money = TFDirector:getChildByPath(self.Image_details_bg,"Image_money")
    self.Image_total = TFDirector:getChildByPath(Image_money,"Image_total")
    self.Label_total = TFDirector:getChildByPath(Image_money,"Label_total")

    self.Label_desc = TFDirector:getChildByPath(self.Image_details_bg,"Label_desc")
    self.Label_effect = TFDirector:getChildByPath(self.Image_details_bg,"Label_effect")
    self.Label_next = TFDirector:getChildByPath(self.Image_details_bg,"Label_next")
    self.Label_next_tip = TFDirector:getChildByPath(self.Image_details_bg,"Label_next_tip")
    self.Image_next_bg = TFDirector:getChildByPath(self.Image_details_bg,"Image_next_bg")

    self.Button_study = TFDirector:getChildByPath(self.Image_details_bg,"Button_study")

    self.Image_cost = TFDirector:getChildByPath(self.Panel_root,"Image_cost")
    self.Label_cost = TFDirector:getChildByPath(self.Image_cost,"Label_cost")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Image_cost,"Image_cost_icon")

    self.Panel_handel = TFDirector:getChildByPath(self.Image_details_bg,"Panel_handel")

    self.Label_condition = TFDirector:getChildByPath(self.Image_details_bg,"Label_condition")
    local ScrollView_condition = TFDirector:getChildByPath(self.Image_details_bg,"ScrollView_condition")
    self.ListView_condition = UIListView:create(ScrollView_condition)

    self:updateBaseInfo()
end

function DetailsKnowledgePage:updateBaseInfo()
    self.curNationCid = ExploreDataMgr:getCurNation()
    self.bossItem_ = {}

    self:loadKnowledgeItem()
end

function DetailsKnowledgePage:loadKnowledgeItem()

    self.knowledgeItem_ = {}
    local nationCfg = ExploreDataMgr:getAfkNationCfg(self.curNationCid)
    if not nationCfg then
        return
    end

    local maxX,maxY = 0,0
    local maxXcfg,maxYcfg

    for k,v in ipairs(nationCfg.knowledgeLayout) do

        local layoutCfg = TabDataMgr:getData("AfkKnowledgeLayout")[v.id]
        if layoutCfg then
            local item = self.panel_point:clone()
            item:show()
            item:setPosition(ccp(layoutCfg.pos.x,layoutCfg.pos.y))

            local darkLine = {}
            for i=1,6 do
                local line = TFDirector:getChildByPath(item,"Image_line"..i)
                darkLine[i] = TFDirector:getChildByPath(line,"dark")
                if v.dir[i] then
                    line:show()
                else
                    line:hide()
                end
            end

            if maxX < layoutCfg.pos.x then
                maxX = layoutCfg.pos.x
                maxXcfg = layoutCfg
            end

            if maxY < layoutCfg.pos.y then
                maxY = layoutCfg.pos.y
                maxYcfg = layoutCfg
            end


            local image_normal = TFDirector:getChildByPath(item,"image_normal")
            local image_learned = TFDirector:getChildByPath(item,"image_learned")
            local image_lock = TFDirector:getChildByPath(item,"image_lock")
            local image_icon = TFDirector:getChildByPath(item,"Image_icon")
            local Image_select = TFDirector:getChildByPath(item,"Image_select"):hide()
            local Label_level = TFDirector:getChildByPath(item,"Label_level")

            local isUnlockEffect = SkeletonAnimation:create("effect/effect_afk/effects_afk_abilityunlock")
            item:addChild(isUnlockEffect,99)

            item:setTouchEnabled(true)
            self.knowledgeItem_[v.id] = {root = item,icon = image_icon, image_normal = image_normal, learned = image_learned,unLockSpine = isUnlockEffect,
                                         darkLine = darkLine,lock = image_lock, select = Image_select,Label_level = Label_level,showCfg = nil, isPlay = false}
            self.Panel_items:addChild(item)


            if not self.selectIndex then
                self.selectIndex = v.id
            end
        end
    end
    local w = maxXcfg.pos.x + 100
    local h = maxYcfg.pos.y + 60
    self.Panel_items:setContentSize(CCSizeMake(w,h))
    self.ScrollView_item:setInnerContainerSize(CCSizeMake(self.Panel_items:getSize()))

    self:updateKnowledge()
end

function DetailsKnowledgePage:updateKnowledge(isUpgrade)

    self.knowledgeData = ExploreDataMgr:getNationKnowledge(self.curNationCid)
    for position,v in pairs(self.knowledgeItem_) do
        if not self.knowledgeData[position] then
            v.root:setVisible(false)
        else
            self:updateKnowledgeItem(v,self.knowledgeData[position],isUpgrade)
        end
    end

    self:jumpToKnowledgeItem(self.selectIndex)
end

function DetailsKnowledgePage:updateKnowledgeItem(widget,cfg,isUpgrade)

    ---展示下一个应该学习的天赋，如果都学习了则展示最后一个天赋
    local curLearnIndex = 0
    for k,v in ipairs(cfg) do
        local state = ExploreDataMgr:getKnowledgeState(v.type,v.id)
        if state == 1 then
            curLearnIndex = k
        end
    end

    local showIndex = curLearnIndex == 0 and 1 or curLearnIndex
    local showKnowledgeCfg = cfg[showIndex]
    if not showKnowledgeCfg then
        return
    end

    widget.showCfg = showKnowledgeCfg

    widget.root:setVisible(true)
    widget.icon:setTexture(showKnowledgeCfg.icon)
  
    widget.Label_level:setText(curLearnIndex.."/"..#cfg)

    local state = ExploreDataMgr:getKnowledgeState(showKnowledgeCfg.type,showKnowledgeCfg.id)
    widget.learned:setVisible(state == 1)
    local isLock = state == nil and true or false
    widget.lock:setVisible(isLock)

    if not isLock then
        if isUpgrade and widget.isPlay == false then
            widget.unLockSpine:show()
            widget.unLockSpine:play("animation",false)
            widget.unLockSpine:addMEListener(TFARMATURE_COMPLETE,function()
                widget.unLockSpine:hide()
            end)
            Utils:playSound(5052)
        end
        widget.isPlay = true
    end

    for k,v in ipairs(widget.darkLine) do
        v:setVisible(isLock)
    end
end

function DetailsKnowledgePage:isUnlockItem(preAbility,condition, isUnlock)

    local allCondition = {}

    local completedEventIds = condition.completedEvent or {}
    for k,v in ipairs(completedEventIds) do
        local isUnlock = ExploreDataMgr:isFinishEvent(v)
        local eventCfg = ExploreDataMgr:getAfkEventCfg(v)
        local cityName = ""
        local cityCfg = ExploreDataMgr:getAfkCityCfg(eventCfg.city)
        if cityCfg then
            cityName = TextDataMgr:getText(cityCfg.name)
        end
        ExploreDataMgr:getAfkCityCfg(v)
        local str = TextDataMgr:getText(13322009,TextDataMgr:getText(eventCfg.name),cityName)
        table.insert(allCondition,{str  = str,isLearn = isUnlock})
    end

    if not isUnlock then
        for k,v in ipairs(preAbility) do

            local knowledgeCfg = ExploreDataMgr:getKnowledgeCfg(v)
            local knowledgeData = self.knowledgeData[knowledgeCfg.position] or {}
            local learnedMaxLevel = 0
            for index,cfg in ipairs(knowledgeData)  do
                local state = ExploreDataMgr:getKnowledgeState(cfg.type,cfg.id)
                if state == 1 then
                    learnedMaxLevel = cfg.level
                end
            end
            local str = TextDataMgr:getText(13322010,TextDataMgr:getText(knowledgeCfg.name))
            table.insert(allCondition,{str  = str,isLearn = knowledgeCfg.level <= learnedMaxLevel})
        end
    end
    return allCondition
end

function DetailsKnowledgePage:jumpToKnowledgeItem(index, isDelay)

    self.selectIndex = index

    ----当前等级的天赋信息
    self.selectKnowledgeInfo = self.knowledgeItem_[index].showCfg
    dump(self.selectKnowledgeInfo)
    local knowledgeNode = self.knowledgeItem_[index].root
    local select = self.knowledgeItem_[index].select
    if self.nodeSelect then
        self.nodeSelect:hide()
    end
    self.nodeSelect = select
    self.nodeSelect:show()

    local position = knowledgeNode:Pos()
    local innerContainer = self.ScrollView_item:getInnerContainer()
    innerContainer:stopAllActions()
    local innerSize = innerContainer:getSize()
    local offset = self.ScrollView_item:getContentOffset()
    local posX = -(position.x - self.contentSize.width / 2)
    local posY = -(position.y - self.contentSize.height / 2)
    local maxX = 0
    local maxY = 0
    local minX = self.contentSize.width - innerSize.width
    local minY = self.contentSize.height - innerSize.height
    posX = posX > maxX and maxX or posX
    posX = posX < minX and minX or posX
    posY = posY > maxY and maxY or posY
    posY = posY < minY and minY or posY
    local distancX = math.abs(posX - offset.x)
    local distancY = math.abs(posY - offset.y)
    local distance = math.max(distancX, distancY)
    local time = distance / 1000

    self.ScrollView_item:setContentOffset(ccp(posX,posY), time)

    self:updateSelectKnowledgeInfo(index)
end

function DetailsKnowledgePage:updateSelectKnowledgeInfo()

    self.ListView_condition:removeAllItems()
    if not self.selectKnowledgeInfo then
        return
    end

    self.Label_desc:setTextById(self.selectKnowledgeInfo.describe)
    self.Label_effect:setText(self.selectKnowledgeInfo.des2)
    self.Label_name:setTextById(self.selectKnowledgeInfo.name)

    ----是否学习当前等级
    local state =  ExploreDataMgr:getKnowledgeState(self.selectKnowledgeInfo.type,self.selectKnowledgeInfo.id)
    local isLearn = state == 1
    local isUnlock = state and true or false
    self.Image_next_bg:setVisible(isLearn)
    if not isLearn then
        self.nextCfg = self.selectKnowledgeInfo;
        self.Image_next_bg:setVisible(not isUnlock)
    else
        local nationId,position = self.selectKnowledgeInfo.chapterID,self.selectKnowledgeInfo.position
        local curLevel = self.selectKnowledgeInfo.level
        local nextLevel = curLevel + 1
        local knowledgeList = ExploreDataMgr:getNationKnowledge(nationId,position)
        self.nextCfg = knowledgeList[nextLevel]
    end

    local color = isLearn and ccc3(75,78,134) or ccc3(128,128,128)
    self.Label_effect:setColor(color)

    self:updateCost()

    ---下级效果显示
    self.Label_next_tip:setTextById(13322011)
    if not self.nextCfg then
        self.Label_next:setTextById(13322012)
        self.Panel_handel:hide()
    else
        self.Label_next:setText("")
        self.Panel_handel:show()
    end

    if not isUnlock then
        self.Label_next_tip:setTextById(13322013)
        self.Label_next:setText("")
        self.Panel_handel:hide()
        self.Image_next_bg:show()

        local condition = self:isUnlockItem(self.selectKnowledgeInfo.preAbility,self.selectKnowledgeInfo.condition,isUnlock)
        for k,v in ipairs(condition) do
            local label = self.Label_condition:clone()
            label:show()
            label:setDimensions(390, 0)
            label:setText(v.str)
            local color = v.isLearn and ccc3(75,78,134) or ccc3(255,0,0)
            label:setColor(color)
            self.ListView_condition:pushBackCustomItem(label)
        end
        return
    end

    if self.nextCfg then
        local label = self.Label_condition:clone()
        label:show()
        label:setDimensions(390, 0)
        label:setText(self.nextCfg.des2)
        label:setColor(ccc3(75,78,134))
        self.ListView_condition:pushBackCustomItem(label)

        local condition = self:isUnlockItem(self.nextCfg.preAbility,self.nextCfg.condition,isUnlock)
        for k,v in ipairs(condition) do
            if not v.isLearn then
                local label = self.Label_condition:clone()
                label:show()
                label:setDimensions(390, 0)
                label:setText(v.str)
                local color = v.isLearn and ccc3(75,78,134) or ccc3(255,0,0)
                label:setColor(color)
                self.ListView_condition:pushBackCustomItem(label)
            end
        end
    end
end

function DetailsKnowledgePage:updateCost()
    self:updateTotal()
    if not self.nextCfg then
        return
    end
    local costId,costNum
    local costInfo = self.nextCfg.cost
    for k,v in pairs(costInfo) do
        costId,costNum = k,v
        break
    end
    self.Label_cost:setText(costNum)

    local itemCfg = GoodsDataMgr:getItemCfg(costId)
    if not itemCfg then
        return
    end
    self.Image_cost_icon:setTexture(itemCfg.icon)
end

function DetailsKnowledgePage:updateTotal()
    if not self.selectKnowledgeInfo then
        return
    end
    local costId,costNum
    local costInfo = self.selectKnowledgeInfo.cost
    for k,v in pairs(costInfo) do
        costId,costNum = k,v
        break
    end
    local itemCfg = GoodsDataMgr:getItemCfg(costId)
    if not itemCfg then
        return
    end
    self.Image_total:setTexture(itemCfg.icon)
    local ownCnt = GoodsDataMgr:getItemCount(costId)
    self.Label_total:setText(ownCnt)
end

function DetailsKnowledgePage:onUpGradeKnowLedge()
    self:updateKnowledge(true)
end

function DetailsKnowledgePage:registerEvents()
    
    EventMgr:addEventListener(self, EV_EXPLORE_UPGRADE_KNOWLEDGE, handler(self.onUpGradeKnowLedge, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateCost, self))
    for k,v in pairs(self.knowledgeItem_) do
        v.root:onClick(function()
            self:jumpToKnowledgeItem(k)
        end)
    end

    self.Button_study:onClick(function ()
        if not self.nextCfg then
            return
        end
        ExploreDataMgr:Send_ExploreTechUpgrade(self.nextCfg.type,self.nextCfg.chapterID,self.nextCfg.id)
    end)

end

return DetailsKnowledgePage
