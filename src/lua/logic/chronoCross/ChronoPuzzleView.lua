
local ChronoPuzzleView = class("ChronoPuzzleView", BaseLayer)

function ChronoPuzzleView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.chronoCross.chronoPuzzleView")
end

function ChronoPuzzleView:initData()
    self.handAccount_ = DfwDataMgr:getHandAccount(EC_HadleAccountType.ChronoCross)
    self.handAccountCfg  = DfwDataMgr:getHandAccountCfg(self.handAccount_[1])
    local cgCfg = Utils:getKVP(46020)
    self.cgId = cgCfg.cgId
    self.collectType = cgCfg.collectType

end

function ChronoPuzzleView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Label_num = TFDirector:getChildByPath(self.Panel_root, "Label_num")
    self.Image_award = TFDirector:getChildByPath(self.Panel_root, "Image_award")
    self.Label_btn = TFDirector:getChildByPath(self.Panel_root, "Label_btn")
    self.Label_award_tip = TFDirector:getChildByPath(self.Panel_root, "Label_award_tip")
    self.Label_award_tip:setTextById(13310349)
    self.puzzleGidInfo_ = {}
    for i=1,10 do
        local puzzleGid = TFDirector:getChildByPath(ui, "Image_puzzle"..i)
        local needItemId = self.handAccountCfg.piece[i]
        table.insert(self.puzzleGidInfo_,{bg = puzzleGid,needItemId = needItemId})
    end
    self.Button_goto = TFDirector:getChildByPath(self.Panel_root, "Button_goto")
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")
    self.Panel_touch:setSize(GameConfig.WS)
    self:updatePuzzleInfo()
    self:updateCollectState()
end



function ChronoPuzzleView:updatePuzzleInfo()

    local finishCnt = 0
    for k,v in ipairs(self.puzzleGidInfo_) do
        local num = GoodsDataMgr:getItemCount(v.needItemId)
        local lockRes = string.format("b%d_1.png",k)
        local normalRes = string.format("b%d.png",k)
        local res = num > 0 and normalRes or lockRes
        v.bg:setTexture("ui/ChronoCros/puzzle/"..res)
        if num > 0 then
            finishCnt = finishCnt + 1
        end
    end
    self.Label_num:setText(finishCnt .. "/" .. #self.puzzleGidInfo_)

end

function ChronoPuzzleView:updateCollectState()

    local activityCGCfg = CollectDataMgr:getActivityCGCfg(self.cgId)
    local isunclock,itemInfo = CollectDataMgr:isCollectItemExist(self.collectType,self.cgId)
    local itemId
    for k,v in pairs(activityCGCfg.reward) do
        itemId = k
        break

    end
    if itemId then
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setPosition(me.p(0.5,0.5))
        self.Image_award:addChild(Panel_goodsItem)
        Panel_goodsItem:Pos(0, 0)
        --Panel_goodsItem:setScale(0.6)
        PrefabDataMgr:setInfo(Panel_goodsItem, itemId)
    end
    if isunclock then
        self.Button_goto:setGrayEnabled(itemInfo.rewardStat ~= 1)
        self.Button_goto:setTouchEnabled(itemInfo.rewardStat == 1)
        if itemInfo.rewardStat == 2 then
            self.Label_btn:setTextById(270491)
        else
            self.Label_btn:setTextById(700013)
        end
    else
        self.Label_btn:setTextById(700013)
        self.Button_goto:setGrayEnabled(true)
        self.Button_goto:setTouchEnabled(false)
    end
end

function ChronoPuzzleView:registerEvents()

    EventMgr:addEventListener(self,EV_COLLECT_UPDATE_INFO,handler(self.updateCollectState, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updatePuzzleInfo, self))

    self.Panel_touch:onClick(function()
        local canDating = true
        for k,v in ipairs(self.puzzleGidInfo_) do
            local num = GoodsDataMgr:getItemCount(v.needItemId)
            if num < 1 then
                canDating = false
                break
            end
        end

        if canDating then
            local isFinish = DatingDataMgr:checkScriptIdIsFinish(self.handAccountCfg.dating)
            FunctionDataMgr:jStartDating(self.handAccountCfg.dating)
        end
    end)

    self.Button_goto:onClick(function()
        local activityCGCfg = CollectDataMgr:getActivityCGCfg(self.cgId)
        local isunclock,itemInfo = CollectDataMgr:isCollectItemExist(self.collectType,self.cgId)
        if isunclock then
            if itemInfo.rewardStat ~= 1 then
                return
            end
            CollectDataMgr:getCollectRewards(activityCGCfg.id)
        end
    end)
end

return ChronoPuzzleView
