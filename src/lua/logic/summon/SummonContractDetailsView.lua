
local SummonContractDetailsView = class("SummonContractDetailsView", BaseLayer)

function SummonContractDetailsView:initData()
    self.contractInfo = SummonDataMgr:getSummonContractInfo()
    self.contractCfg = TabDataMgr:getData("ContractSpirit",self.contractInfo.taskIndenture)
end

function SummonContractDetailsView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.summon.summonContractDetailsView")
end

function SummonContractDetailsView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_welfareItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_welfareItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_remainTime = TFDirector:getChildByPath(Image_content, "Label_remainTime")
    self.Label_timing = TFDirector:getChildByPath(Image_content, "Label_timing")
    local ScrollView_welfare = TFDirector:getChildByPath(Image_content, "ScrollView_welfare")
    self.ListView_welfare = UIListView:create(ScrollView_welfare)
    self.Button_build = TFDirector:getChildByPath(Image_content, "Button_build")
    self.Label_build = TFDirector:getChildByPath(self.Button_build, "Label_build")
    self.Image_flag = TFDirector:getChildByPath(self.Panel_root, "Image_flag")
    self.Label_num = TFDirector:getChildByPath(self.Image_flag, "Label_num")
    local Image_cost = TFDirector:getChildByPath(Image_content, "Image_cost")
    self.Image_raw_costIcon = TFDirector:getChildByPath(Image_cost, "Image_raw_costIcon")
    self.Label_raw_costNum = TFDirector:getChildByPath(Image_cost, "Label_raw_costNum")
    self.Image_costIcon = TFDirector:getChildByPath(Image_cost, "Image_costIcon")
    self.Label_costNum = TFDirector:getChildByPath(Image_cost, "Label_costNum")

    self.Button_summon = TFDirector:getChildByPath(Image_content, "Button_summon")
    local Label_summon = TFDirector:getChildByPath(self.Button_summon, "Label_summon")
    Label_summon:setTextById(1325318)

    self:refreshView()
end

function SummonContractDetailsView:removeUI(  )
    -- body
    self.super.removeUI(self)
    if self.timer then
        TFDirector:stopTimer(self.timer)
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

function SummonContractDetailsView:refreshView()
    local function flushLabelTime()
        local remainTime = math.max(self.contractInfo.summonInfo.endTime - ServerDataMgr:getServerTime())
        local day,hour,min,sec = Utils:getTimeDHMZ(remainTime)
        self.Label_timing:setTextById(1325313, hour, min, sec)
        if remainTime > 0 then
            self.Label_remainTime:setTextById(1325304)
        else
            self.Label_remainTime:setTextById(1325314)
        end
        self.Label_timing:setVisible(remainTime > 0)
        self.Button_summon:setVisible(remainTime > 0)
    end
    self.timer = TFDirector:addTimer(1000,-1,nil,flushLabelTime)
    flushLabelTime()
    self:updateView()
end

function SummonContractDetailsView:updateView()
    for i = 1, #self.contractCfg.Particulars do
        local Panel_welfareItem = self.Panel_welfareItem:clone()
        self.ListView_welfare:pushBackCustomItem(Panel_welfareItem)

        local Label_desc = TFDirector:getChildByPath(Panel_welfareItem, "Label_desc")
        Label_desc:setTextById(self.contractCfg.Particulars[i])
    end

    self.Label_raw_costNum:setText(self.contractCfg.OriginalCost)
    self.Label_costNum:setText(self.contractCfg.Price)

    local canBuy,cfg = SummonDataMgr:getCanBuildContract()
    -- if self.contractInfo.actIndentures and #self.contractInfo.actIndentures > 0 then
    --     local lastStageBuy = false
    --     for k,v in pairs(self.contractInfo.actIndentures) do
    --         local cfg = TabDataMgr:getData("ContractSpirit",v)
    --         if cfg.NextStage == 0 then
    --             lastStageBuy = true
    --         end
    --     end
    --     if canBuy then
    --         self.Label_build:setTextById(1325317)
    --     elseif lastStageBuy then
    --         self.Label_build:setTextById(1325319)
    --     else
    --         self.Label_build:setTextById(1325306,cfg.DemandLevel[1])
    --     end
    -- else
    --     self.Label_build:setTextById(1325305)
    -- end

    self.Label_build:setTextById(1325305,cfg.Price)
    self.Label_num:setText(cfg.ShowMultiple)

    if self.contractInfo.actIndentures and #self.contractInfo.actIndentures > 0  then
        for k,v in pairs(self.contractInfo.actIndentures) do
            local cfg = TabDataMgr:getData("ContractSpirit",v)
            if cfg.NextStage == 0 then
                lastStageBuy = true
            end
        end
    end

    if lastStageBuy then
        self.Label_build:setTextById(1325319)
        self.Image_flag:hide()
    end
    
    self.Button_build:setTouchEnabled(canBuy)
    self.Button_build:setGrayEnabled(not canBuy)
    cfg = cfg or self.contractInfo
    self.Label_raw_costNum:setText(cfg.OriginalCost)
    self.Label_costNum:setText(cfg.Price)
end

function SummonContractDetailsView:registerEvents()
    self.Button_build:onClick(function()
        local canBuy, cfg = SummonDataMgr:getCanBuildContract( )
        if canBuy then
            RechargeDataMgr:getOrderNO(cfg.SellingPrice);
        end
    end)

    EventMgr:addEventListener(self, EV_UPDATE_SUMMONCONTRACT, function ( ... )
        self:initData()
        self:updateView()
    end)

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_summon:onClick(function()
            FunctionDataMgr:jSummon(1)
    end)
end

return SummonContractDetailsView
