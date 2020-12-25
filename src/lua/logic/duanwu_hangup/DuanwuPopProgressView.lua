--[[
    @descï¼šDuanwuPopProgressView
    @date: 2020-06-20 15:37:34
]]

local DuanwuPopProgressView = class("DuanwuPopProgressView",BaseLayer)

function DuanwuPopProgressView:initData(preFortData, fortData, reward)
    self.preFortData = preFortData
    self.fortData = fortData
    self.reward = reward
        self:showPopAnim(true)
    self.fortCfg = TabDataMgr:getData("HangupEvtFort",self.fortData.id)
end

function DuanwuPopProgressView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.duanwuPopProgressView")
end

function DuanwuPopProgressView:initUI(ui)
    self.super.initUI(self,ui)
    self:refreshView()
end

function DuanwuPopProgressView:refreshView()
    self._ui.lab_name:setTextById(self.fortCfg.name)
    local progress = math.floor(self.preFortData.progress*100/self.fortCfg.finishProg)
    self._ui.LoadingBar_progress:setPercent(progress)
    self._ui.lab_progress:setText(progress.."%")
    self._ui.Image_icon:setTexture(self.fortCfg.icon)
    local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    goods:setScale(0.7)
    local id,num = next(self.fortCfg.rewardShow)
    PrefabDataMgr:setInfo(goods, id)
    goods:AddTo(self._ui.panel_goodsPos):Pos(ccp(0,0))
end

function DuanwuPopProgressView:onShow(  )
    -- body
    self.super.onShow(self)
    self:showProgressAni()
end

function DuanwuPopProgressView:onClose( ... )
    -- body
    self.super.onClose(self)
    if self.reward then
        Utils:showReward(self.reward)
    end
end

function DuanwuPopProgressView:showProgressAni( ... )
    -- body
    local progress = math.floor(self.fortData.progress*100/self.fortCfg.finishProg)
    Utils:loadingBarAddAction(self._ui.LoadingBar_progress,progress,nil,function ( ... )
        -- body
        DatingDataMgr:triggerDating(self.__cname,"onClickFinish",{fortFinishCount = DuanwuHangUpDataMgr.completeStronghold })
        self._ui.Panel_touched:hide()
    end, function ( ... )
        -- body
        local percent = self._ui.LoadingBar_progress:getPercent()
        self._ui.lab_progress:setText(percent.."%")
    end)
end

function DuanwuPopProgressView:registerEvents()

end

return DuanwuPopProgressView