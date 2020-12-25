
local CoffeeDetailsView = class("CoffeeDetailsView", BaseLayer)

function CoffeeDetailsView:initData(isEmbed, maidId)
    self.maidId_ = maidId
    self.isEmbed_ = isEmbed
end

function CoffeeDetailsView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.coffee.coffeeDetailsView")
end

function CoffeeDetailsView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(self.Image_content, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.Image_content, "Label_title")
    self.Image_info = TFDirector:getChildByPath(self.Panel_root, "Image_info")
    local Image_model = TFDirector:getChildByPath(self.Image_info, "Image_model")
    self.Image_modelIcon = TFDirector:getChildByPath(Image_model, "Image_modelIcon")
    self.Label_power = TFDirector:getChildByPath(Image_model, "Image_power.Label_power")
    local Label_power_title = TFDirector:getChildByPath(Image_model, "Image_power.Label_power_title")
    Label_power_title:setTextById(13400254)
    self.Label_rush = TFDirector:getChildByPath(Image_model, "Image_rush.Label_rush")
    local Label_rush_title = TFDirector:getChildByPath(Image_model, "Image_rush.Label_rush_title")
    Label_rush_title:setTextById(13400255)
    self.Label_cuisine = TFDirector:getChildByPath(Image_model, "Image_cuisine.Label_cuisine")
    local Label_cuisine_title = TFDirector:getChildByPath(Image_model, "Image_cuisine.Label_cuisine_title")
    Label_cuisine_title:setTextById(13400256)
    local Image_name = TFDirector:getChildByPath(self.Image_info, "Image_name")
    local Label_name_title = TFDirector:getChildByPath(Image_name, "Label_name_title")
    Label_name_title:setTextById(13410013)
    self.Label_name = TFDirector:getChildByPath(Image_name, "Label_name")
    local Image_code = TFDirector:getChildByPath(self.Image_info, "Image_code")
    local Label_code_title = TFDirector:getChildByPath(Image_code, "Label_code_title")
    Label_code_title:setTextById(13410014)
    self.Label_code = TFDirector:getChildByPath(Image_code, "Label_code")
    local Image_goodCuisine = TFDirector:getChildByPath(self.Image_info, "Image_goodCuisine")
    local Label_goodCuisineTitle = TFDirector:getChildByPath(Image_goodCuisine, "Label_goodCuisineTitle")
    Label_goodCuisineTitle:setTextById(13410015)
    self.Label_goodCuisine = TFDirector:getChildByPath(Image_goodCuisine, "Label_goodCuisine")
    local Image_service = TFDirector:getChildByPath(self.Image_info, "Image_service")
    local Label_service_title = TFDirector:getChildByPath(Image_service, "Label_service_title")
    Label_service_title:setTextById(13410016)
    self.Label_service = TFDirector:getChildByPath(Image_service, "Label_service")
    self.Label_desc = TFDirector:getChildByPath(self.Image_info, "Image_desc.Label_desc")

    self.listView = UIListView:create(TFDirector:getChildByPath(self.Image_info, "listView"))
    self.listView:setItemsMargin(10)

    self.Image_fetters = {}
    for i = 1, 2 do
        local foo = {}
        local item = TFDirector:getChildByPath(self.Image_info, "Image_fetters_" .. i)
        item:hide()
        foo.root = item:clone()
        foo.root:show()
        self.listView:pushBackCustomItem(foo.root)
        foo.Panel_have = TFDirector:getChildByPath(foo.root, "Panel_have")
        foo.Image_active = TFDirector:getChildByPath(foo.Panel_have, "Image_active")
        foo.Image_notActive = TFDirector:getChildByPath(foo.Panel_have, "Image_notActive")
        foo.Image_elf = {}
        for j = 1, 3 do
            local bar = {}
            bar.root = TFDirector:getChildByPath(foo.Panel_have, "Image_elf_" .. j)
            bar.Image_head = TFDirector:getChildByPath(bar.root, "Image_head")
            bar.Image_head:setScale(0.75)
            bar.Image_gou = TFDirector:getChildByPath(bar.root, "Image_gou")
            foo.Image_elf[j] = bar
        end
        foo.Label_name = TFDirector:getChildByPath(foo.Panel_have, "Label_name")
        foo.Label_desc = TFDirector:getChildByPath(foo.Panel_have, "Label_desc")
        foo.Panel_notHave = TFDirector:getChildByPath(foo.root, "Panel_notHave")
        local Label_notHave = TFDirector:getChildByPath(foo.Panel_notHave, "Image_notHave.Label_notHave")
        Label_notHave:setTextById(13410030)
        self.Image_fetters[i] = foo
    end

    local Image_desc_3 = TFDirector:getChildByPath(self.Image_info, "Image_desc_3")
    Image_desc_3:hide()
    self.Image_desc_3_ = Image_desc_3:clone()
    self.Image_desc_3_:show()
    self.listView:pushBackCustomItem(self.Image_desc_3_)

    self.Button_feeding = TFDirector:getChildByPath(self.Image_info, "Button_feeding")
    self.Label_feeding = TFDirector:getChildByPath(self.Button_feeding, "Label_feeding")
    self:refreshView()
end

function CoffeeDetailsView:refreshView()
    self.Label_title:setTextById(13410038)
    self.Label_feeding:setTextById(13410012)
    self.Image_content:setVisible(not self.isEmbed_)

    if self.maidId_ then
        self:updateInfo(self.maidId_)
    end
end

function CoffeeDetailsView:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_feeding:onClick(function()
            local maidInfo = CoffeeDataMgr:getMaidInfo(self.maidId_)
            local maidCfg = CoffeeDataMgr:getMaidCfg(self.maidId_)
            if maidInfo.strength < maidCfg.strength then
                Utils:openView("coffee.CoffeeRecoverView", self.maidId_)
            else
                Utils:showTips(13410040)
            end
    end)
end

function CoffeeDetailsView:updateInfo(maidId)
    local isHaveMaid = CoffeeDataMgr:isHaveMaid(maidId)
    if isHaveMaid then
        local maidInfo = CoffeeDataMgr:getMaidInfo(maidCid)
        self.maidId_ = maidId
    else
        self.maidId_ = nil
    end

    local maidCfg = CoffeeDataMgr:getMaidCfg(maidId)
    self.Label_desc:setTextById(maidCfg.describe3)
    self.Label_name:setTextById(maidCfg.name1)
    self.Label_code:setTextById(maidCfg.name2)
    self.Label_goodCuisine:setTextById(maidCfg.describe1)
    self.Label_service:setTextById(maidCfg.describe2)
    self.Label_power:setText(CoffeeDataMgr:converPower(maidCfg.strength))
    self.Label_rush:setText(maidCfg.showcase)
    self.Label_cuisine:setText(maidCfg.food)
    self.Image_modelIcon:setTexture(maidCfg.icon3)
    self.Button_feeding:setVisible(isHaveMaid)

    for i, foo in ipairs(self.Image_fetters) do
        local fettersCid = maidCfg.fetterList [i]
        if fettersCid then
            local maidBuffCfg = CoffeeDataMgr:getMaidBuffCfg(fettersCid)
            foo.Label_name:setTextById(maidBuffCfg.name)
            foo.Label_desc:setTextById(maidBuffCfg.describe)

            for j, bar in ipairs(foo.Image_elf) do
                local maidCid = maidBuffCfg.role[j]
                if maidCid then
                    local maidCfg = CoffeeDataMgr:getMaidCfg(maidCid)
                    local isHave = CoffeeDataMgr:isHaveSameMaid(maidCid)
                    bar.Image_head:setTexture(maidCfg.icon1)
                    if not self.isEmbed_ then
                        bar.Image_gou:setVisible(false)
                    else
                        bar.Image_gou:setVisible(CoffeeDataMgr:isBuffActive(fettersCid))
                        
                        if CoffeeDataMgr:isBuffActive(fettersCid) then
                            foo.Label_desc:setColor(ccc3(133,96,77))
                            foo.Label_desc:Alpha(1)
                        else
                            foo.Label_desc:setColor(ccc3(110,110,111))
                            foo.Label_desc:Alpha(0.5)
                        end
                    end
                    bar.root:Alpha(isHave and 1 or 0.5)
                end
                bar.root:setVisible(tobool(maidCid))
            end
        end
        foo.Panel_have:setVisible(tobool(fettersCid))
        foo.Panel_notHave:setVisible(not tobool(fettersCid))
    end
    local Label_desc3 = TFDirector:getChildByPath(self.Image_desc_3_, "Label_desc")
    Label_desc3:setTextById(CoffeeDataMgr:getMaidCfg(maidId).maidEventPersonality)
end

return CoffeeDetailsView
