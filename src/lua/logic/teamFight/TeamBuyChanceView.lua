TeamBuyChanceView = class("TeamBuyChanceView",BaseLayer)

function TeamBuyChanceView:ctor( ... )
	self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.teamFight.teamBuyChance")
end

function TeamBuyChanceView:initData(buyInfo)
	self.buyInfo = buyInfo
end

function TeamBuyChanceView:initUI(ui)
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
--{limitCount = limitCount,hasCount = hasCount,canBuyCount = canBuyCount,cost = costcfg}
function TeamBuyChanceView:refreshView()
    self.Label_ok:setTextById(800010)
    self.Label_title:setTextById(800011)
    self.Label_rets:setTextById(300007)

    local remainCount = self.buyInfo.hasCount
    
    self.Label_remainCount:setTextById("r20004", remainCount)
    local remainBuyCount = self.buyInfo.canBuyCount
    self.Label_tips:setTextById("r20003", remainBuyCount)

    local itemId, itemCount
    for k, v in pairs(self.buyInfo.cost) do
        itemId = k
        itemCount = v
        break
    end
    local itemCfg = GoodsDataMgr:getItemCfg(itemId)
    if itemCfg then
        self.Image_costIcon:setTexture(itemCfg.icon)
        self.Image_costIcon:onClick(function()
            Utils:showAccess(itemId)
        end)
        self.Image_costIcon:setTouchEnabled(true)
        self.Label_costNum:setTextById(800007, itemCount)
    end
end

function TeamBuyChanceView:registerEvents()
    EventMgr:addEventListener(self, EV_TEAM_BUY_CHANLENGE_COUNT, handler(self.onBuyRecvFromServer, self))

    self.Button_close:onClick(
        function()
            AlertManager:closeLayer(self)
        end, EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
        TeamFightDataMgr:requestAddFightCount(self.buyInfo.levelid)
    end)
end

function TeamBuyChanceView:onBuyRecvFromServer()
    AlertManager:closeLayer(self)
    Utils:showTips(800035)
end
return TeamBuyChanceView