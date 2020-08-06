local SummonHeroView = class("SummonHeroView", BaseLayer)

function SummonHeroView:ctor(summonId)
    self.super.ctor(self)
    self:initData(summonId)
    self:init("lua.uiconfig.summon.summonHeroView")
end

function SummonHeroView:initData(summonId)
    
    self.summonId = summonId
    local cfg = TabDataMgr:getData("Summon")[self.summonId]
    self.showHeroId = cfg.heroId
    self.awardInfo = {}
    local summonInfo = SummonDataMgr:getServerSummonInfo(self.summonId)
    if summonInfo and summonInfo.summonShow then
        for k,v in pairs(summonInfo.summonShow) do
            local reward = {}
            reward.barValue = v.count
            local item = {}
            for index,itemId in ipairs(v.itemId) do
                local itemNums = v.itemNums[index] or 0
                item[itemId] = itemNums
            end
            reward.award = item
            table.insert(self.awardInfo,reward)
        end
        table.sort(self.awardInfo,function(a,b)
            return a.barValue < b.barValue
        end)
    end
    self.maxBarValue = self.awardInfo[#self.awardInfo].barValue

    self.awardItems_ = {}

    self.totalScore = summonInfo.summonNums or 0
    self.curScore = summonInfo.remainScore or 0
    self.loopCnt = summonInfo.count or 0

    --已领取奖励
    self.rewardRecord = {}
    local geted = summonInfo.getRewards or {}
    for k,v in ipairs(geted) do
        self.rewardRecord[v] = 1
    end
end

function SummonHeroView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

    self.Image_herobg = TFDirector:getChildByPath(self.ui, "Image_herobg")
    self.Image_barbg = TFDirector:getChildByPath(self.ui, "Image_barbg")
    self.LoadingBar_progress = TFDirector:getChildByPath(self.ui, "LoadingBar_progress")
    --self.LoadingBar_progress:setPercent(100)
    self.Panel_preview = TFDirector:getChildByPath(self.ui, "Panel_preview")
    self.Image_preview_zs = TFDirector:getChildByPath(self.Panel_preview, "Image_preview_zs")
    self.Image_preview_diban = TFDirector:getChildByPath(self.Panel_preview, "Image_preview_diban")
    local size_zs = self.Image_preview_zs:Size()
    local size_diban = self.Image_preview_diban:Size()
    self.previewOffsetHeight_ = size_zs.height - size_diban.height
    local ScrollView_preview = TFDirector:getChildByPath(self.Panel_preview, "ScrollView_preview")
    self.ListView_preview = UIListView:create(ScrollView_preview)
    
    self.Panel_click = TFDirector:getChildByPath(self.ui, "Panel_click")

    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Panel_awardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_awardItem")
    self.Panel_tipItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tipItem")

    self.Label_totalScore = TFDirector:getChildByPath(self.ui, "Label_totalScore")
    self.Label_curScore = TFDirector:getChildByPath(self.ui, "Label_curScore")
    self.Label_times = TFDirector:getChildByPath(self.ui, "Label_times")
    self.Label_tip = TFDirector:getChildByPath(self.ui, "Label_tip")
    self:uiLogic()
end

function SummonHeroView:uiLogic()

    --show mode
    self.Image_herobg:setScale(0.55)
    local anim_hero = Utils:createHeroModel(self.showHeroId, self.Image_herobg)
    anim_hero:setPosition(ccp(0,0))

    self.Image_barbg:removeAllChildren()
    for k,v in ipairs(self.awardInfo) do
        self:addAwardItem(k,v.barValue,v.id)
    end

    local percent = math.floor(self.curScore/self.maxBarValue*100)
    self.LoadingBar_progress:setPercent(percent)

    self.Label_totalScore:setText(self.totalScore)
    self.Label_curScore:setText(self.curScore)
    self.Label_times:setText(self.loopCnt)
    self.Label_tip:setTextById(1200055)
end

function SummonHeroView:updateAward(index,barValue)

    local foo = self.awardItems_[index]
    if not foo then
        return
    end
    foo.Label_num:setText(barValue)
    foo.Spine_receive:hide()
    local awardBgRes = "ui/summon/exchange/002.png"
    if self.curScore >= barValue and (not self.rewardRecord[barValue]) then
        awardBgRes = "ui/summon/exchange/001.png"
        foo.Image_item:setTexture("ui/task/box_2.png")
        foo.Spine_receive:show()
    end

    if self.rewardRecord[barValue] then
        foo.Image_item:setTexture("ui/task/box_3.png")
    else
        foo.Image_item:setTexture("ui/task/box_1.png")
    end

    foo.Image_awardBg:setTexture(awardBgRes)
end

function SummonHeroView:addAwardItem(index,barValue)
    local Panel_awardItem = self.Panel_awardItem:clone()
    local foo = {}
    foo.root = Panel_awardItem
    foo.Label_num = TFDirector:getChildByPath(foo.root, "Label_num")
    foo.Image_awardBg = TFDirector:getChildByPath(foo.root, "Image_awardBg")
    foo.Image_line1 = TFDirector:getChildByPath(foo.Image_awardBg, "Image_line1")
    foo.Image_line2 = TFDirector:getChildByPath(foo.Image_awardBg, "Image_line2")
    foo.Image_item = TFDirector:getChildByPath(foo.Image_awardBg, "Image_item")
    foo.Spine_receive = TFDirector:getChildByPath(foo.Image_awardBg, "Spine_receive")
    foo.Spine_receive:hide()
    foo.Label_num:setText(barValue)
    if index%2 ~= 0 then
        foo.Image_awardBg:setPosition(ccp(-101,-129))
    else
        foo.Image_awardBg:setPosition(ccp(-52,-94))
    end
 
    foo.Image_line1:setVisible(index%2 ~= 0)
    foo.Image_line2:setVisible(index%2 == 0)

    local awardBgRes = "ui/summon/exchange/002.png"
    if self.curScore >= barValue and (not self.rewardRecord[barValue]) then
        awardBgRes = "ui/summon/exchange/001.png"
        foo.Image_item:setTexture("ui/task/box_2.png")
        foo.Spine_receive:show()
        foo.Spine_receive:playByIndex(0,-1,-1,1)
    end
    foo.Image_awardBg:setTexture(awardBgRes)

    if self.rewardRecord[barValue] then
        foo.Image_item:setTexture("ui/task/box_3.png")
    else
        foo.Image_item:setTexture("ui/task/box_1.png")
    end

    local posX = barValue/self.maxBarValue*490-25
    Panel_awardItem:setPositionX(posX)
    self.Image_barbg:addChild(Panel_awardItem)
    self.awardItems_[index] = foo
end

function SummonHeroView:showPreview(index)

    local awardInfo = self.awardInfo[index]
    local item = self.awardItems_[index]
    if not awardInfo or not item then
        return
    end
    self.Panel_preview:setVisible(true)
    local wp = item.root:getParent():convertToWorldSpace(item.root:Pos())
    local np = self.Panel_preview:getParent():convertToNodeSpaceAR(wp)
    self.ListView_preview:removeAllItems()

    local taskCfg = TaskDataMgr:getTaskCfg(dailyTaskCid)
    for id, itemNum in pairs(awardInfo.award) do
        local itemCfg = GoodsDataMgr:getItemCfg(id)
        local Panel_tipItem = self.Panel_tipItem:clone()
        local Panel_icon = TFDirector:getChildByPath(Panel_tipItem, "Panel_icon")
        local Label_name = TFDirector:getChildByPath(Panel_tipItem, "Label_name")
        local Label_desc = TFDirector:getChildByPath(Panel_tipItem, "Label_desc")
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.8)
        PrefabDataMgr:setInfo(Panel_goodsItem, id, itemNum)
        Panel_goodsItem:AddTo(Panel_icon):Pos(0, 0)
        Label_name:setTextById(itemCfg.nameTextId)
        Label_desc:setTextById(itemCfg.desTextId)
        self.ListView_preview:pushBackCustomItem(Panel_tipItem)
    end
    Utils:setAliginCenterByListView(self.ListView_preview)

    self.ListView_preview:s():Pos(0, 0)
    local size = self.ListView_preview:getContentSize()
    local size1 = self.Panel_preview:Size()
    size1.height = size.height
    self.Panel_preview:Size(size1):Pos(0, 0)
    local size2 = self.Image_preview_diban:Size()
    size2.height = size.height
    self.Image_preview_diban:Size(size2):Pos(0, 0)
    local size3 = self.Image_preview_zs:Size()
    size3.height = size2.height + self.previewOffsetHeight_
    self.Image_preview_zs:Size(size3):Pos(0, 10)
    
    local posX = np.x-110
    self.Panel_preview:Pos(posX,np.y-140)
end

function SummonHeroView:onRecvUpdateData()
    
    local summonInfo = SummonDataMgr:getServerSummonInfo(self.summonId)
    self.totalScore = summonInfo.summonNums or 0
    self.curScore = summonInfo.remainScore or 0
    self.loopCnt = summonInfo.count or 0

    --已领取奖励
    self.rewardRecord = {}
    local geted = summonInfo.getRewards or {}
    for k,v in ipairs(geted) do
        self.rewardRecord[v] = 1
    end

    for k,v in ipairs(self.awardInfo) do
        self:updateAward(k,v.barValue)
    end

    local percent = self.curScore/self.maxBarValue*100
    self.LoadingBar_progress:setPercent(percent)

    self.Label_totalScore:setText(self.totalScore)
    self.Label_curScore:setText(self.curScore)
    self.Label_times:setText(self.loopCnt)
end

function SummonHeroView:registerEvents()

    EventMgr:addEventListener(self, EV_SUMMON_UPATE_HERO, handler(self.onRecvUpdateData, self))

    for k,v in ipairs(self.awardItems_) do
        v.Image_awardBg:onClick(function()
            local barValue = self.awardInfo[k].barValue
            if self.curScore >= barValue  and (not self.rewardRecord[barValue]) then
                local msg = {
                    self.summonId,
                    barValue
                }
                SummonDataMgr:send_SUMMON_REQ_VALUE_AWARD(msg)
            else
                self:showPreview(k)
            end
        end)
    end

    self.Panel_click:onClick(function()
        self.Panel_preview:setVisible(false)
    end)
end

function SummonHeroView:onHide()
	self.super.onHide(self)
end

function SummonHeroView:removeUI()
	self.super.removeUI(self)
end

return SummonHeroView