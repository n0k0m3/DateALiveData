
local FubenPlotBuyCountView = class("FubenPlotBuyCountView", BaseLayer)

function FubenPlotBuyCountView:initData(levelCid)
    self.levelCid_ = levelCid
    self.levelCfg_ = FubenDataMgr:getLevelCfg(levelCid)

    self.costItemCid_ = self.levelCfg_.buyCost[1][1]
    self.costItemNum_ = self.levelCfg_.buyCost[1][2]
end

function FubenPlotBuyCountView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fuben.fubenBuyCountView")
end

function FubenPlotBuyCountView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(Image_bg, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Label_title = TFDirector:getChildByPath(Image_bg, "Label_title")
    self.Label_remainCount = TFDirector:getChildByPath(Image_bg, "Label_remainCount")
    self.Label_tips = TFDirector:getChildByPath(Image_bg, "Label_tips")
    self.Image_costIcon = TFDirector:getChildByPath(Image_bg, "Image_costIcon")
    self.Label_costNum = TFDirector:getChildByPath(Image_bg, "Label_costNum")
    self.Label_rets = TFDirector:getChildByPath(Image_bg, "Label_rets")

    self:refreshView()
end

function FubenPlotBuyCountView:refreshView()
    self.Label_ok:setTextById(800010)
    self.Label_title:setTextById(800011)
    self.Label_rets:setTextById(300007)

    local remainCount = FubenDataMgr:getPlotLevelRemainFightCount(self.levelCid_)
    self.Label_remainCount:setTextById("r20004", remainCount, self.levelCfg_.fightCount)
    local remainBuyCount = FubenDataMgr:getPlotLevelRemainBuyCount(self.levelCid_)
    self.Label_tips:setTextById("r20003", remainBuyCount)

    local itemCfg = GoodsDataMgr:getItemCfg(self.costItemCid_)
    self.Image_costIcon:setTexture(itemCfg.icon)
    self.Label_costNum:setTextById(800007, self.costItemNum_)
end

function FubenPlotBuyCountView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_PLOTLEVEL_BUY_COUNT, handler(self.onBuyCountEvent, self))

    self.Button_close:onClick(
        function()
            AlertManager:close()
        end, EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
            local remainCount = FubenDataMgr:getPlotLevelRemainFightCount(self.levelCid_)
            local fightCount = FubenDataMgr:getFreePrivilegeNumById(self.levelCid_) + self.levelCfg_.fightCount
            if remainCount < fightCount then
                if GoodsDataMgr:currencyIsEnough(self.costItemCid_, self.costItemNum_) then
                    FubenDataMgr:send_DUNGEON_BUY_LEVEL_COUNT(self.levelCid_)
                else
                    Utils:showAccess(self.costItemCid_)
                end
            else
               Utils:showTips(300592)
            end
    end)
end

function FubenPlotBuyCountView:onBuyCountEvent()
    AlertManager:closeLayer(self)
    Utils:showTips(800035)
end

return FubenPlotBuyCountView
