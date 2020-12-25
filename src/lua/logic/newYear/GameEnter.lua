
local GameEnter = class("GameEnter",BaseLayer)

function GameEnter:ctor( city, area, gameType)
    self.super.ctor(self)
    self:initData(city, area, gameType)
    self:init("lua.uiconfig.NewYear.gameEnter")
end

function GameEnter:initData(city, area, gameType)
   self.city, self.area, self.gameType = city, area, gameType
   self.CostInfo = Utils:getKVP(90013)
   self.ruKouCfg = TabDataMgr:getData("MJrukou")[gameType]
    dump(self.ruKouCfg)
end

function GameEnter:initUI( ui )
    -- body
    self.super.initUI(self,ui)
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    self.Label_title = TFDirector:getChildByPath(ui, "Label_title")
    self.Label_game = TFDirector:getChildByPath(ui, "Label_game")
    self.Image_icon = TFDirector:getChildByPath(ui, "Image_icon")
    self.Label_desc = TFDirector:getChildByPath(ui, "Label_desc")
    self.Label_cost_num = TFDirector:getChildByPath(ui, "Label_cost_num")
    self.Image_cost = TFDirector:getChildByPath(ui, "Image_cost")
    self.Image_cost_icon = TFDirector:getChildByPath(ui, "Image_cost_icon")
    self.Button_enter = TFDirector:getChildByPath(ui, "Button_enter")
    
    self:initUILogic()
end

function GameEnter:initUILogic()

    if not self.ruKouCfg then
        return
    end

    self.Label_title:setTextById(self.ruKouCfg.tip)
    self.Label_game:setTextById(self.ruKouCfg.tip)
    self.Image_icon:setTexture(self.ruKouCfg.res)
    self.Label_desc:setTextById(self.ruKouCfg.des)

    local costId,costNum
    for k,v in pairs(self.CostInfo) do
        costId,costNum = k,v
        break
    end
    if not costId or not costNum then
        return
    end
    local haveNum = GoodsDataMgr:getItemCount(costId)
    local itemCfg = GoodsDataMgr:getItemCfg(costId)
    self.Image_cost_icon:setTexture(itemCfg.icon)
    self.Label_cost_num:setText(haveNum.."/"..costNum)

    self.Image_cost:onClick(function()
        Utils:showInfo(costId)
    end)
end

function GameEnter:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_enter:onClick(function()
        ActivityDataMgr2:Req2020FestivalGameInit(self.city, self.area)
        AlertManager:closeLayer(self)
    end)
end


return GameEnter