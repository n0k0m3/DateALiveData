
local FubenDailyBuyCountView = class("FubenDailyBuyCountView", BaseLayer)

function FubenDailyBuyCountView:initData(levelGroupId)
    self.levelGroupId_ = levelGroupId
    self.levelGroupCfg_ = FubenDataMgr:getLevelGroupCfg(levelGroupId)
    self.levelGroupInfo_ = FubenDataMgr:getLevelGroupInfo(levelGroupId)

    self.costItemCid_, self.costItemNum_ = next(self.levelGroupCfg_.price)
end

function FubenDailyBuyCountView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fuben.fubenBuyCountView")
end

function FubenDailyBuyCountView:initUI(ui)
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

function FubenDailyBuyCountView:refreshView()
    self.Label_ok:setTextById(800010)
    self.Label_title:setTextById(800011)
    self.Label_rets:setTextById(300007)

    local remainCount = FubenDataMgr:getDailyRemainFightCount(self.levelGroupId_)
    remainCount = math.min(remainCount, self.levelGroupCfg_.countLimit)
    self.Label_remainCount:setTextById("r20004", remainCount, self.levelGroupCfg_.countLimit)
    local remainBuyCount = FubenDataMgr:getDailyRemainBuyCount(self.levelGroupId_)
    self.Label_tips:setTextById("r20003", remainBuyCount)

    local itemCfg = GoodsDataMgr:getItemCfg(self.costItemCid_)
    self.Image_costIcon:setTexture(itemCfg.icon)
    self.Label_costNum:setTextById(800007, self.costItemNum_)
end

function FubenDailyBuyCountView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_DAILYBUYCOUNT, handler(self.onDailyBuyCountEvent, self))

    self.Button_close:onClick(
        function()
            AlertManager:close()
        end, EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
            local remainCount = FubenDataMgr:getDailyRemainFightCount(self.levelGroupId_)
            if remainCount < self.levelGroupCfg_.countLimit  then
                if GoodsDataMgr:currencyIsEnough(self.costItemCid_, self.costItemNum_) then
                    FubenDataMgr:send_DUNGEON_BUY_FIGHT_COUNT(self.levelGroupId_, 1)
                else
                    Utils:showAccess(self.costItemCid_)
                end
            else
               Utils:showTips(300592)
            end
    end)
end

function FubenDailyBuyCountView:onDailyBuyCountEvent(levelGroupId)
    AlertManager:closeLayer(self)
    Utils:showTips(800035)
end

return FubenDailyBuyCountView

