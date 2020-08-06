local ChristmasBag = class("ChristmasBag", BaseLayer)


function ChristmasBag:ctor()
    self.super.ctor(self)
    self:showPopAnim(true)
    self:init("lua.uiconfig.recharge.christmasBag")
end

function ChristmasBag:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    self.Button_buy		= TFDirector:getChildByPath(ui,"Button_buy")
    self.btnLable = TFDirector:getChildByPath(self.Button_buy,"Label_btn")
    self.btnLable:setTextById(800125)

    CommonManager:setChristmasBagFlage(true)
end


function ChristmasBag:registerEvents()

    self.Button_buy:onClick(function()

        local cfgInfo = MainAdDataMgr:getAdInfoById(26)
        if not cfgInfo then
            return
        end

        if cfgInfo.activityType == 1 then
            if ActivityDataMgr:getIsHaveActs() then
                Utils:openActivityPage(tonumber(cfgInfo.jumpId))
            end
        elseif cfgInfo.activityType == 2 then
            FunctionDataMgr:jActivity(tonumber(cfgInfo.jumpId))
        elseif cfgInfo.activityType == 3 then
            FunctionDataMgr:enterByFuncId(tonumber(cfgInfo.jumpId))
        else
            Utils:openView(cfgInfo.jumpId)
        end
        AlertManager:closeLayer(self)
    end)

end

return ChristmasBag
