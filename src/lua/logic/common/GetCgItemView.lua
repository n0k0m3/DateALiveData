
local GetCgItemView = class("GetCgItemView", BaseLayer)

function GetCgItemView:initData(itemList)
    self.itemList_ = itemList or {}
    self.cgsItem_ = {}
end

function GetCgItemView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.bag.getItemView")
end

function GetCgItemView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_bg = TFDirector:getChildByPath(ui, "Panel_bg")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Spine_getItem = TFDirector:getChildByPath(ui, "Spine_getItem")

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Panel_cgItem = PrefabDataMgr:getPrefab("Panel_cgItem")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_content, "ScrollView_reward")
    ScrollView_reward:setPositionX(ScrollView_reward:getPositionX() + 5)
    ScrollView_reward:setDirection(SCROLLVIEW_DIR_HORIZONTAL)    

    local count = #self.itemList_
    local width = self.Panel_cgItem:Size().width * count + math.max((count - 1) * 10, 0)
    ScrollView_reward:setContentSize(CCSize(math.min(width , 730), 250))
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_reward:setItemsMargin(10)

    self:refreshView()
    self.Spine_getItem:play("chuxian",false)
    self.Spine_getItem:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_getItem:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_getItem:play("xunhuan",true)
        end, 0)
    end)
end

function GetCgItemView:refreshView()
    for i, v in ipairs(self.itemList_) do
        local data = v
        local Panel_cgItem = self.Panel_cgItem:clone()
        PrefabDataMgr:setInfo(Panel_cgItem, data.id, data.num)
        table.insert(self.cgsItem_, Panel_cgItem)
        self.ListView_reward:pushBackCustomItem(Panel_cgItem)
    end
    
    self:playAni()
    Utils:playSound(501)
end

function GetCgItemView:playAni()
    local delay = 0
    local offsetX = self.Panel_cgItem:Size().width * 0.5
    for row, item in ipairs(self.cgsItem_) do
        item:Alpha(0)

        delay = delay + 0.05
        local seq = Sequence:create({
                DelayTime:create(delay),
                CallFunc:create(function()
                    item:PosX(item:PosX() - offsetX)
                end),
                Spawn:create({
                        CCFadeIn:create(0.2),
                        MoveBy:create(0.2, ccp(offsetX, 0)),
                })
        })
        item:runAction(seq)
    end
end

function GetCgItemView:registerEvents()

end

function GetCgItemView:onShow()
    self.super.onShow(self)
end

return GetCgItemView
