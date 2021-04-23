
local FubenEndlessPlusBossView = class("FubenEndlessPlusBossView", BaseLayer)

function FubenEndlessPlusBossView:initData()

end

function FubenEndlessPlusBossView:ctor(levelCid)
    self.super.ctor(self)
    self:showPopAnim(true)
    self.levelCid = levelCid
    self.FloorDungeonLevelCfg = TabDataMgr:getData("FloorDungeonLevel")
    self:init("lua.uiconfig.fuben.fubenEndlessPlussBossView")
end

function FubenEndlessPlusBossView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local ScrollView_boss = TFDirector:getChildByPath(ui, "ScrollView_boss")
    self.UIListView_boss = UIListView:create(ScrollView_boss)

    self.Panel_bossItem = TFDirector:getChildByPath(ui, "Panel_bossItem")

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    self:initUILogic()
end

function FubenEndlessPlusBossView:initUILogic()

    local levelCfg =  self.FloorDungeonLevelCfg[self.levelCid]
    if not levelCfg then
        return
    end

    dump(levelCfg)

    self.UIListView_boss:removeAllItems()
    for k,v in ipairs(levelCfg.icon) do
        local level = levelCfg.monsterLevel[k]
        local bossItem = self.Panel_bossItem:clone()
        self.UIListView_boss:pushBackCustomItem(bossItem)

        local image = TFDirector:getChildByPath(bossItem, "Image_boss")
        image:setTexture(v)
        local Label_level = TFDirector:getChildByPath(bossItem, "Label_level")
        if level then
            Label_level:setText("Lv."..level)
        else
            Label_level:setText("")
        end

    end
    Utils:setAliginCenterByListView(self.UIListView_boss,true)
end

function FubenEndlessPlusBossView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return FubenEndlessPlusBossView
