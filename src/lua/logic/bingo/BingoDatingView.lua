
local BingoDatingView = class("BingoDatingView", BaseLayer)

function BingoDatingView:initData()

end

function BingoDatingView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.bingo.bingoDatingView")
end

function BingoDatingView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    local ScrollView_task = TFDirector:getChildByPath(self.Panel_root, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab , "Panel_taskItem")
    self:updateDating()
end

function BingoDatingView:updateDating()
    self.ListView_task:removeAllItems()
    local cfg = BingoDataMgr:getEvtDatingCfg()
    for k ,v in ipairs(cfg) do
        local isUnLock = BingoDataMgr:isUnLockDating(v.ruleId)
        local Panel_taskItem = self.Panel_taskItem:clone()
        local Label_desc = TFDirector:getChildByPath(Panel_taskItem, "Label_desc")
        local descStr = isUnLock and v.desc or v.descPre
        Label_desc:setTextById(descStr)

        local Image_ing_tag = TFDirector:getChildByPath(Panel_taskItem, "Image_ing_tag")
        local img = isUnLock and "ui/activity/bingoGame/unlock.png" or "ui/activity/bingoGame/lock.png"
        Image_ing_tag:setTexture(img)

        local Button_receive = TFDirector:getChildByPath(Panel_taskItem, "Button_receive")
        local Label_receive = TFDirector:getChildByPath(Button_receive, "Label_receive")

        local btnStr = 500005
        Label_receive:setTextById(btnStr)
        Button_receive:setTouchEnabled(isUnLock)
        Button_receive:setGrayEnabled(not isUnLock)
        Button_receive:onClick(function()
            self:playCg(v.ruleId)
        end)
        self.ListView_task:pushBackCustomItem(Panel_taskItem)
    end

end

function BingoDatingView:playCg(ruleId)
    DatingDataMgr:startDating(ruleId)
end

function BingoDatingView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

end

return BingoDatingView
