
local DlsTreasureRewardView = class("DlsTreasureRewardView", BaseLayer)

function DlsTreasureRewardView:initData(site)
    self.site_ = site
    local questionInfo = DlsDataMgr:getCacheQuestion()
    self.question_ = questionInfo[site]
    self.questionCfg_ = DlsDataMgr:getQuestionCfg(self.question_.id)

    local summons = SummonDataMgr:getDlsSummon()
    local summon = summons[1][1]
    local summonCfg = SummonDataMgr:getSummonCfg(summon.id)
    self.summonCid_ = summon.id
    self.costItemCid_, self.costItemCount_ = next(summonCfg.cost[1])
end

function DlsTreasureRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dls.dlsTreasureRewardView")
end

function DlsTreasureRewardView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    self.Image_photo = TFDirector:getChildByPath(Image_content, "Image_photo")
    self.Label_desc = TFDirector:getChildByPath(Image_content, "Image_desc.Label_desc")
    self.Button_open = TFDirector:getChildByPath(Image_content, "Button_open")
    self.Label_open = TFDirector:getChildByPath(self.Button_open, "Label_open")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Button_open, "Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(self.Button_open, "Label_cost_num")

    self:refreshView()
end

function DlsTreasureRewardView:refreshView()
    self.Label_name:setTextById(self.questionCfg_.titleId)

    local costItemCfg = GoodsDataMgr:getItemCfg(self.costItemCid_)
    self.Image_cost_icon:setTexture(costItemCfg.icon)
    self.Label_cost_num:setText(self.costItemCount_)

    local descId = self.questionCfg_.descId[self.question_.index]
    self.Label_desc:setLineHeight(36)
    self.Label_desc:setTextById(descId)
    self.Image_photo:setTexture(self.questionCfg_.pic)
end

function DlsTreasureRewardView:registerEvents()
    EventMgr:addEventListener(self, EV_SUMMON_RESULT, handler(self.onSummonResultEvent, self))

    self.Button_open:onClick(function()
            if GoodsDataMgr:currencyIsEnough(self.costItemCid_, self.costItemCount_) then
                SummonDataMgr:send_SUMMON_SUMMON(self.summonCid_, 1)
            else
                Utils:showTips(2101405)
            end
    end)

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

function DlsTreasureRewardView:onSummonResultEvent(reward)
    Utils:showReward(reward)
    DlsDataMgr:setQuestionOpenState(self.site_, true)
    EventMgr:dispatchEvent(EV_DLS_OPEN_FORCER)
    AlertManager:closeLayer(self)
end

return DlsTreasureRewardView
