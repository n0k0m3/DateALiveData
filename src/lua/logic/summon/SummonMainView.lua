
local SummonMainView = class("SummonMainView", BaseLayer)

function SummonMainView:initData()

end

function SummonMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.summon.summonMainView")
end

function SummonMainView:initUI(ui)
    self.super.initUI(self, ui)
    self:showTopBar()
    self:addLockLayer()
    
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_summon = TFDirector:getChildByPath(self.Panel_root, "Image_summon")
    self.Label_summon = TFDirector:getChildByPath(Image_summon, "Label_summon")
    self.Button_summon = TFDirector:getChildByPath(Image_summon, "Button_summon")
    self.Label_summon_en = TFDirector:getChildByPath(Image_summon, "Label_summon_en")
    self.Image_upTips = TFDirector:getChildByPath(Image_summon, "Image_upTips")

    local Image_compose = TFDirector:getChildByPath(self.Panel_root, "Image_compose")
    self.Label_compose = TFDirector:getChildByPath(Image_compose, "Label_compose")
    self.Label_compose_en = TFDirector:getChildByPath(Image_compose, "Label_compose_en")
    self.Button_compose = TFDirector:getChildByPath(Image_compose, "Button_compose")
    self.Image_compose_tip = TFDirector:getChildByPath(Image_compose, "Image_compose_tip")

    self:refreshView()
end

function SummonMainView:refreshView()
    self.Label_summon:setTextById(1200046)
    self.Label_compose:setTextById(1200047)

    local isOpen = SummonDataMgr:isOpenNoob()
    local contractInfo = SummonDataMgr:getSummonContractInfo()
    local remainTime = 0
    if contractInfo.summonInfo then
        remainTime = math.max(contractInfo.summonInfo.endTime - ServerDataMgr:getServerTime())
    end
    self.Image_upTips:setVisible(isOpen or remainTime > 0)

    if not self.Image_upTips:isVisible() then
                    local summon = SummonDataMgr:getSummon()
                    for k ,v in pairs(summon) do
                        local summonCfg = SummonDataMgr:getSummonCfg(v[1].id)
                        if summonCfg.up then
                            self.Image_upTips:setVisible(summonCfg.up)
                        end
                    end
                end
end

function SummonMainView:onShow()
    self.super.onShow(self)
    self:removeLockLayer()
    local isShow = SummonDataMgr:isShowRedPointInMainView()
    self.Image_compose_tip:setVisible(isShow)
    self:timeOut(function()
        GameGuide:checkGuide(self);
    end,0)
end

function SummonMainView:registerEvents()
    self.Button_summon:onClick(function()
            FunctionDataMgr:jSummon()
            GameGuide:checkGuideEnd(self.guideFuncId)
    end)

    self.Button_compose:onClick(function()
		--SimulationSummonDataMgr:reqSimulateSummonInfo()
           FunctionDataMgr:jCompose()
			--Utils:openView("summon.SimulationSummonView")
    end)
end






---------------------------guide------------------------------

--引导召唤
function SummonMainView:excuteGuideFunc9003(guideFuncId)
    local targetNode = self.Button_summon
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

return SummonMainView

