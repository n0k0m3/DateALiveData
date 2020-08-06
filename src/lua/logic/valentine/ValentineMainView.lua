
local ValentineMainView = class("ValentineMainView", BaseLayer)

function ValentineMainView:initData()
    self.rankItems_ = {}
    self.valentineRole_ = clone(ValentineDataMgr:getValentineRole())

    ValentineDataMgr:send_VALENTINE_VALENTINE_RANK()
end

function ValentineMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.valentine.valentineMainView")
end

function ValentineMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_rankItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rankItem")

    self.ScrollView_room = TFDirector:getChildByPath(self.Panel_root, "ScrollView_room")
    self.ScrollView_room:setContentSize(GameConfig.WS)
    self.Panel_room = TFDirector:getChildByPath(self.ScrollView_room, "Panel_room")
    local Image_map = TFDirector:getChildByPath(self.Panel_room, "Image_map")
    self.Panel_site = {}
    for i = 1, 7 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(Image_map, "Panel_site_" .. i)
        foo.root:setBackGroundColorType(0)
        self.Panel_site[i] = foo
    end
    self.Panel_rank = TFDirector:getChildByPath(self.Panel_root, "Panel_rank")
    local ScrollView_rank = TFDirector:getChildByPath(self.Panel_rank, "ScrollView_rank")
    self.ListView_rank = UIListView:create(ScrollView_rank)
    self.Button_expand = TFDirector:getChildByPath(self.Panel_rank, "Button_expand"):hide()
    self.Button_collapse = TFDirector:getChildByPath(self.Panel_rank, "Button_collapse"):show()
    self.Button_chocolate = TFDirector:getChildByPath(self.Panel_root, "Button_chocolate")
    self.Label_chocolate = TFDirector:getChildByPath(self.Button_chocolate, "Label_chocolate")
    self.Button_tacit = TFDirector:getChildByPath(self.Panel_root, "Button_tacit")
    self.Label_tacit = TFDirector:getChildByPath(self.Button_tacit, "Label_tacit")

    local rankSize = self.Panel_rank:getSize()
    self.collapseX_ = -GameConfig.WS.width * 0.5 - rankSize.width
    self.expandX_ = -GameConfig.WS.width * 0.5

    self:refreshView()
end

function ValentineMainView:initMap()
    for i, v in ipairs(self.valentineRole_) do
        local foo = self.Panel_site[i]
        local cfg = ValentineDataMgr:getValentineRoleCfg(v)
        local roleModelCfg = TabDataMgr:getData("CityRoleModel", cfg.cityRole)
        foo.Spine_role = SkeletonAnimation:create(roleModelCfg.rolePath)
        foo.root:addChild(foo.Spine_role)
        foo.Spine_role:setScale(0.8)
        foo.Spine_role:play(cfg.action, true)
        foo.Spine_role:addMEListener(
            TFARMATURE_COMPLETE,
            function(_, aniName)
                if aniName == "happy" then
                    foo.Spine_role:play(roleModelCfg.action, true)
                end
            end
        )
        foo.Spine_role:setTouchEnabled(true)
        foo.root:setScaleX(cfg.flip and -1 or 1)
        foo.Spine_role:onClick(function()
                Utils:openView("valentine.ValentineTaskView", v)
        end)
    end

    local size = self.ScrollView_room:getInnerContainerSize()
    local innerContainer = self.ScrollView_room:getInnerContainer()
    innerContainer:setPositionX(-size.width * 0.5)
end

function ValentineMainView:refreshView()
    self.Label_chocolate:setTextById(1710003)
    self.Label_tacit:setTextById(1710004)
    self.Panel_rank:PosX(self.expandX_)

    self:initMap()

    local size = self.Panel_room:Size()
    self.Panel_room:setPosition(ccp(0, size.height * 0.5))

    for i, v in ipairs(self.valentineRole_) do
        local foo = self:addRankItem()
        self.rankItems_[i] = foo
        self.ListView_rank:pushBackCustomItem(foo.root)
    end
    self:updateAllRandItem()
end

function ValentineMainView:addRankItem()
    local Panel_rankItem = self.Panel_rankItem:clone()
    local foo = {}
    foo.root = Panel_rankItem
    foo.Image_rank = {}
    for i = 1, 4 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Image_rank_" .. i)
        bar.Label_name = TFDirector:getChildByPath(bar.root, "Label_name")
        bar.Label_rank = TFDirector:getChildByPath(bar.root, "Label_rank")
        bar.Label_order = TFDirector:getChildByPath(bar.root, "Label_order")
        bar.Image_icon = TFDirector:getChildByPath(bar.root, "Image_icon")
        foo.Image_rank[i] = bar
    end
    return foo
end

function ValentineMainView:operateRank(isOpen)
    local x = isOpen and self.expandX_ or self.collapseX_
    local y = self.Panel_rank:PosY()
    self.Button_expand:setVisible(not isOpen)
    self.Button_collapse:setVisible(isOpen)
    local action = Sequence:create({
            EaseSineOut:create(MoveTo:create(0.5, ccp(x, y))),
            CallFunc:create(function()

            end)
    })
    self.Panel_rank:stopAllActions()
    self.Panel_rank:runAction(action)
end

function ValentineMainView:updateAllRandItem()
    for i, v in ipairs(self.valentineRole_) do
        local foo = self.rankItems_[i]
        local cfg = ValentineDataMgr:getValentineRoleCfg(v)
        local roleModelCfg = TabDataMgr:getData("CityRoleModel", cfg.cityRole)
        local order = i > 3 and 4 or i
        for j, bar in ipairs(foo.Image_rank) do
            bar.root:setVisible(j == order)
            bar.Label_name:setTextById(cfg.name)
            bar.Label_rank:setTextById(1710001)
            bar.Label_order:setText(i)
            bar.Image_icon:setTexture(roleModelCfg.modeHead)
            bar.Image_icon:Scale(0.55)
        end
    end
end

function ValentineMainView:registerEvents()
    EventMgr:addEventListener(self, EV_VALENTINE_RANK_UPDATE, handler(self.onRankUpdateEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))

    self.Button_collapse:onClick(function()
            self:operateRank(false)
    end)

    self.Button_expand:onClick(function()
            self:operateRank(true)
    end)

    self.Button_chocolate:onClick(function()
            Utils:openView("valentine.ValentineComposeView")
    end)

    self.Button_tacit:onClick(function()
            Utils:openView("valentine.ValentineRankView")
    end)
end

function ValentineMainView:onRankUpdateEvent()
    self.valentineRole_ = ValentineDataMgr:getValentineRoleRank()
    self:updateAllRandItem()
end

function ValentineMainView:onUpdateActivityEvent()
    local activityInfo = ValentineDataMgr:getActivityInfo()
    if not activityInfo then
        AlertManager:closeAll()
        Utils:showTips(1710021)
    end
end

return ValentineMainView
