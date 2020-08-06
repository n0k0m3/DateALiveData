
local KuangsanTaskAwardScan = class("KuangsanTaskAwardScan",BaseLayer)


function KuangsanTaskAwardScan:ctor( data )
    self.super.ctor(self,data)
    self.activityId = data
    self:initData()
    self:init("lua.uiconfig.activity.kuangsanTaskAwardScan")
end

function KuangsanTaskAwardScan:initData()

end

function KuangsanTaskAwardScan:initUI( ui )

    self.super.initUI(self,ui)

    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

    self.Panel_prefab = TFDirector:getChildByPath(ui,"Panel_prefab")
    self.Image_Item = TFDirector:getChildByPath(self.Panel_prefab,"Image_Item")

    local ScrollView_award = TFDirector:getChildByPath(ui,"ScrollView_award")
    self.ListView_award = UIListView:create(ScrollView_award)
    self:updateView()
end

function KuangsanTaskAwardScan:updateView()

    self.ListView_award:removeAllItems()

    local randomIds = KsanCardDataMgr:getRandomIds()

    table.sort(randomIds,function(a,b)
        local finishNumA = KsanCardDataMgr:finishMatchNum(a)
        local finishNumB = KsanCardDataMgr:finishMatchNum(b)
        if finishNumA == finishNumB then
            return a > b
        else
            return finishNumA < finishNumB
        end
    end)

    for k,v in ipairs(randomIds) do
        local item = self.Image_Item:clone()
        self:updateItem(item,v)
        self.ListView_award:pushBackCustomItem(item)
    end
end

function KuangsanTaskAwardScan:updateItem(item,id)

    local Image_Icon = TFDirector:getChildByPath(item,"Image_Icon")
    local Label_name = TFDirector:getChildByPath(item,"Label_name")
    local Label_getall = TFDirector:getChildByPath(item,"Label_getall")
    local Image_progress = TFDirector:getChildByPath(item,"Image_progress"):hide()
    local Label_peogress = TFDirector:getChildByPath(item,"Label_peogress")

    local cardCfg = KsanCardDataMgr:getCardCfg(id)
    if not cardCfg then
        return
    end
    local showItemId = cardCfg.itemShow
    local num = cardCfg.itemMap[showItemId]
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Image_Icon:addChild(Panel_goodsItem)
    Panel_goodsItem:Pos(ccp(0,0))
    print(showItemId)
    PrefabDataMgr:setInfo(Panel_goodsItem, showItemId,num)

    local itemCfg = GoodsDataMgr:getItemCfg(showItemId)
    Label_name:setTextById(itemCfg.nameTextId)

    local finishNum = KsanCardDataMgr:finishMatchNum(id)
    Label_getall:setVisible(finishNum > 1)
end

function KuangsanTaskAwardScan:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end


return KuangsanTaskAwardScan