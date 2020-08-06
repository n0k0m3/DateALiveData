
local SummonComposePreviewView = class("SummonComposePreviewView", BaseLayer)

function SummonComposePreviewView:initData()
    self.pointItem_ = {}
end

function SummonComposePreviewView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.summon.summonComposePreviewView")
end

function SummonComposePreviewView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_pointItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_pointItem")
    self.Panel_equip_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_equip_item")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")

    local ScrollView_point = TFDirector:getChildByPath(Image_content, "ScrollView_point")
    self.ListView_point = UIListView:create(ScrollView_point)
    self.ListView_point:setItemsMargin(5)

    self:refreshView()
end

function SummonComposePreviewView:refreshView()
    local data = SummonDataMgr:getComposePreview()
    for pointType, points in ipairs(data) do
        local Panel_pointItem = self.Panel_pointItem:clone()
        local pointCfg = points[1]
        local Image_icon = TFDirector:getChildByPath(Panel_pointItem, "Image_icon")
        local Label_name = TFDirector:getChildByPath(Panel_pointItem, "Label_name")
        local ScrollView_equips = UIListView:create(TFDirector:getChildByPath(Panel_pointItem, "ScrollView_equips"))
        ScrollView_equips:setItemsMargin(5)
        Image_icon:setTexture(pointCfg.icon)
        Label_name:setTextById(tonumber(pointCfg.pointName))

        for i,v in ipairs(points) do
            local item = self.Panel_equip_item:clone()
            local Image_item_bg = TFDirector:getChildByPath(item, "Image_item_bg")
            local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
            local Label_rate = TFDirector:getChildByPath(item, "Label_rate")
            local itemCfg = GoodsDataMgr:getItemCfg(v.name[1])
            local starLv = EquipmentDataMgr:getEquipStarLv(v.name[1])
            for i=1,5 do
                local star = TFDirector:getChildByPath(item, "Image_star"..i)
                star:setVisible(i <= starLv)
            end
        
            Image_item_bg:setTexture(EC_ItemIcon[itemCfg.quality])
            Image_icon:setTexture(itemCfg.icon)
            Label_rate:setText(v.name[2].."%")
            Image_item_bg:setTouchEnabled(true)
            Image_item_bg:onClick(function()
                Utils:showInfo(v.name[1], nil, true)
            end)
            ScrollView_equips:pushBackCustomItem(item)
        end
        self.ListView_point:pushBackCustomItem(Panel_pointItem)
    end
end

function SummonComposePreviewView:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:close()
    end)
end

return SummonComposePreviewView
