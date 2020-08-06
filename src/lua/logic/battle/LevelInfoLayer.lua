
local LevelInfoLayer = class("LevelInfoLayer", BaseLayer)

function LevelInfoLayer:ctor(params)
    self.super.ctor(self)
    self:init("lua.uiconfig.battle.levelInfoLayer")
end


function LevelInfoLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.button_close = TFDirector:getChildByPath(self.panel_root, "Button_close")


    -- --关闭按钮
    -- self.btn_xb1   = TFDirector:getChildByPath(ui, "Button_xb1")
    -- self.text_xb1  = self.btn_xb1:getChildByName("Label_title")
    -- self.btn_xb2   = TFDirector:getChildByPath(ui, "Button_xb2")
    -- self.text_xb2  = self.btn_xb2:getChildByName("Label_title")
    -- self.btn_help  = TFDirector:getChildByPath(ui, "Button_help")
    -- self.btn_reset = TFDirector:getChildByPath(ui, "Button_reset")

    -- --
    -- self.image_arrow1 = TFDirector:getChildByPath(ui, "Image_arrow1")
    -- self.image_arrow2 = TFDirector:getChildByPath(ui, "Image_arrow2")
    -- self.image_box    = TFDirector:getChildByPath(ui, "Image_box")

    -- --奖励
    -- self.image_award1 = TFDirector:getChildByPath(ui, "Image_award1")
    -- self.image_award2 = TFDirector:getChildByPath(ui, "Image_award2")
    -- self.image_award3 = TFDirector:getChildByPath(ui, "Image_award3")


    -- self.targetItems = {}  
    -- for index = 1 , 3 do
    --     self.targetItems[index] = TFDirector:getChildByPath(ui, "Image_award"..tostring(index))
    -- end

    -- --寻宝一次消耗
    -- self.text_consume1 = TFDirector:getChildByPath(ui, "Label_consume1")
    -- --寻宝十次消耗
    -- self.text_consume2 = TFDirector:getChildByPath(ui, "Label_consume2")
    
    -- self.image_icon1 = TFDirector:getChildByPath(ui, "Image_icon1")
    -- self.image_icon2 = TFDirector:getChildByPath(ui, "Image_icon2")


    -- --旋转
    -- self.image_disk_turn = TFDirector:getChildByPath(ui, "Image_disk_turn")
    -- self.selectItems = {}

    -- --奖项
    -- local Panel_prize = TFDirector:getChildByPath(ui, "Panel_prize")
    -- for index = 1 , 10 do
    --     -- print(i)
    --     self.selectItems[index]           = TFDirector:getChildByPath(Panel_prize, "Image_prize_"..tostring(index))
    --     self.selectItems[index].focusNode = self.selectItems[index]:getChildByName("Image_select")
    -- end
    -- ------------------------------------------------------------------
    -- local datas = TabDataMgr:getData("Summon")
    -- self.cfgs   = {}
    -- for k, data in pairs(datas) do
    --     if data.interfaceType == EC_SummonShowPlaceType.Team then 
    --         table.insert(self.cfgs,data)
    --     end
    -- end
    -- table.sort(self.cfgs,function (a,b)
    --     return a.cardCount < b.cardCount
    -- end)
    -- --寻宝一次消耗
    -- local cfg = self.cfgs[1]
    -- for i, costs in ipairs(cfg.cost) do
    --     for k , num in pairs(costs) do
    --         -- print(k,v)
    --         local data = TabDataMgr:getData("Item",k)
    --         self.image_icon1:setTexture(data.icon)
    --         self.text_consume1:setText("x"..num)
    --         break
    --     end
    -- end 

    -- self.text_xb1:setTextById(14110004,cfg.cardCount)
    -- --寻宝十次消耗
    -- cfg = self.cfgs[2]
    -- for i, costs in ipairs(cfg.cost) do
    --     for k , num in pairs(costs) do
    --         local data = TabDataMgr:getData("Item",k)
    --         self.image_icon2:setTexture(data.icon)
    --         self.text_consume2:setText("x"..num)
    --         break
    --     end
    -- end 
    -- self.text_xb2:setTextById(14110004,cfg.cardCount)



    -- --TODO 测试
    -- self:randomTarget()
end


function LevelInfoLayer:registerEvents()
    self.button_close:onClick(function()
            AlertManager:closeLayer(self)
        end)

    -- self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    -- self.btn_xb1:onClick(function()
    --         self:start({math.random(1,10)})
    --     end)
    -- self.btn_xb2:onClick(function()
    --         local func_random = _Random()
    --         self:start({func_random(),func_random(),func_random(),func_random(),func_random()})
    --     end)
    -- self.btn_help:onClick(function()
    --         Utils:openView("summon.SummonPreviewView", self.cfgs[1].groupId,14110005)
    --     end)
    -- self.btn_reset:onClick(function()
    --         Utils:openView("summon.SummonHistoryView",{{records={}}},14110006)
    --     end)  
end



function LevelInfoLayer:onHide()
    self.super.onHide(self)
end

function LevelInfoLayer:removeUI()
    self.super.removeUI(self)
    --测试移除 lua
    -- local TFUILoadManager       = require('TFFramework.client.manager.TFUILoadManager')
    -- TFUILoadManager:unLoadModule("lua.logic.osd.LuckdrawLayer")
end



return LevelInfoLayer
