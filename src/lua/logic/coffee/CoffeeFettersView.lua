
local CoffeeFettersView = class("CoffeeFettersView", BaseLayer)

function CoffeeFettersView:initData(fettersList)
    self.fettersList_ = fettersList
end

function CoffeeFettersView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.coffee.coffeeFettersView")
end

function CoffeeFettersView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Panel_fetters = {}
    for i = 1, 2 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(Image_content, "Panel_fetters_" .. i)
        foo.Image_fetters = TFDirector:getChildByPath(foo.root, "Image_fetters")
        foo.Label_fetters_name = TFDirector:getChildByPath(foo.Image_fetters, "Label_fetters_name")
        foo.Image_elf = {}
        for j = 1, 3 do
            local bar = {}
            bar.root = TFDirector:getChildByPath(foo.Image_fetters, "Image_elf_" .. j)
            bar.Image_head = TFDirector:getChildByPath(bar.root, "Image_head")
            bar.Image_head:setScale(0.75)
            foo.Image_elf[j] = bar
        end
        foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
        foo.Image_noFetters = TFDirector:getChildByPath(foo.root, "Image_noFetters")
        foo.Label_noFetters = TFDirector:getChildByPath(foo.Image_noFetters, "Label_noFetters")
        foo.Label_noFetters:setTextById(13410030)
        self.Panel_fetters[i] = foo
    end

    self:refreshView()
end

function CoffeeFettersView:refreshView()
    self.Label_title:setTextById(13410029)

    for i, foo in ipairs(self.Panel_fetters) do
        local fettersCid = self.fettersList_[i]
        if fettersCid then
            local maidBuffCfg = CoffeeDataMgr:getMaidBuffCfg(fettersCid)
            foo.Label_desc:setTextById(maidBuffCfg.describe)
            foo.Label_fetters_name:setTextById(maidBuffCfg.name)

            for j, bar in ipairs(foo.Image_elf) do
                local maidCid = maidBuffCfg.role[j]
                if maidCid then
                    local maidCfg = CoffeeDataMgr:getMaidCfg(maidCid)
                    bar.Image_head:setTexture(maidCfg.icon1)
                end
                bar.root:setVisible(tobool(maidCid))
            end
        end
        foo.Image_fetters:setVisible(tobool(fettersCid))
        foo.Image_noFetters:setVisible(not tobool(fettersCid))
    end
end

function CoffeeFettersView:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

return CoffeeFettersView
