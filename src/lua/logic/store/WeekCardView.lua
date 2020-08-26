--[[
    @desc: 周卡界面
]]

local WeekCardView = class("WeekCardView", BaseLayer)


function WeekCardView:ctor()
    self.super.ctor(self)
    self:init("lua.uiconfig.recharge.weekCardView")
end

function WeekCardView:registerEvents()

    self.Button_buyCard:onClick(function()
        RechargeDataMgr:getOrderNO(910004)
    end)

    self.Button_sign:onClick(function()
        RechargeDataMgr:sendWeekCardSign()
    end)

    EventMgr:addEventListener(self, EV_WEEKCARD_UPDATE, handler(self.refreshUI, self))
end

function WeekCardView:initUI(ui)
    self.super.initUI(self, ui)

    self.Image_bg1 = TFDirector:getChildByPath(ui, "Image_bg1") 
    self.Button_buyCard = TFDirector:getChildByPath(ui, "Button_buyCard")

    self.Button_sign = TFDirector:getChildByPath(ui, "Button_sign")
    self.Label_buyCard = TFDirector:getChildByPath(ui, "Label_buyCard")
    self.Label_leftDay = TFDirector:getChildByPath(ui, "Label_leftDay")
    self.Label_signDay = TFDirector:getChildByPath(ui, "Label_signDay")
    self.Label_signTips = TFDirector:getChildByPath(ui, "Label_signTips")
    self.Label_signTips:setTextById(1605015)

    local Panel_reward = TFDirector:getChildByPath(ui, "Panel_reward")
    self.ListView_reward = UIListView:create(TFDirector:getChildByPath(Panel_reward, "ScrollView_reward"))
    self.ListView_reward:setItemsMargin(5)

    self.scrollView = UIListView:create(TFDirector:getChildByPath(ui, "scrollView"))
    self.scrollView:setItemsMargin(10)
    self.img_welfare = TFDirector:getChildByPath(ui, "img_welfare"):hide()

    self:initWelfarelist()
    self:refreshUI()
end

function WeekCardView:initWelfarelist()
    local cfgs = RechargeDataMgr:getCardPrivilegeByType(EC_CardPrivilege.Week)
    for i = 1, #cfgs do
        local item = self.img_welfare:clone()
        item:show()
        local lab_indexNum = TFDirector:getChildByPath(item, "lab_indexNum")
        local lab_desc     = TFDirector:getChildByPath(item, "lab_desc")
        lab_desc:setTextById(cfgs[i].describe)

        local imgRes 
        if i % 2 == 0 then
            imgRes = "ui/weekCard/4.png"
        else
            imgRes = "ui/weekCard/5.png"
        end 
        item:setTexture(imgRes)
        lab_indexNum:setText(i)
        self.scrollView:pushBackCustomItem(item)
    end
end

function WeekCardView:refreshUI()
    local data = RechargeDataMgr:getWeekCardInfo()
    self.ListView_reward:removeAllItems()
    for i, v in ipairs(data.basrReward or {}) do
        local reward = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():Scale(0.6)
        PrefabDataMgr:setInfo(reward, v.id, v.num)
        self.ListView_reward:pushBackCustomItem(reward)
    end

    local lastTime = data.etime - ServerDataMgr:getServerTime()
    local havecard = tobool(lastTime > 0)
    if havecard then
        local days =  math.ceil(lastTime/(24*3600))
        self.Label_leftDay:setText(days)
    else
        self.Label_leftDay:setText(0)
    end

    self.Button_sign:setTouchEnabled(havecard and data.canSign)
    self.Button_sign:setGrayEnabled(not havecard or not data.canSign)
end

return WeekCardView