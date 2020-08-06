
local ValentineRankView = class("ValentineRankView", BaseLayer)

function ValentineRankView:initData()
    self.valentineRole_ = ValentineDataMgr:getValentineRole()
    self.rankScale_ = {0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2}

    ValentineDataMgr:send_VALENTINE_VALENTINE_RANK()
end

function ValentineRankView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.valentine.valentineRankView")

end

function ValentineRankView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_spriteItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_spriteItem")
    self.Panel_tacitItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tacitItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Panel_sprite = {}
    for i = 1, 7 do
        local foo = {}
        local Panel_sprite = TFDirector:getChildByPath(Image_content, "Panel_sprite_" .. i)
        Panel_sprite:setBackGroundColorType(0)
        foo.root = self.Panel_spriteItem:clone():Pos(0, 0):AddTo(Panel_sprite)
        foo.Image_progress = {}
        for j = 1, 4 do
            foo.Image_progress[j] = TFDirector:getChildByPath(foo.root, "Image_progress_" .. j)
        end
        foo.Button_sprite = TFDirector:getChildByPath(foo.root, "Button_sprite")
        foo.Image_head = TFDirector:getChildByPath(foo.Button_sprite, "Image_head")
        self.Panel_sprite[i] = foo
    end

    self.Panel_tacit = {}
    for i = 1, 7 do
        local foo = {}
        local Panel_tacit = TFDirector:getChildByPath(Image_content, "Panel_tacit_" .. i)
        Panel_tacit:setBackGroundColorType(0)
        foo.root = self.Panel_tacitItem:clone():Pos(0, 0):AddTo(Panel_tacit)
        foo.Image_order = {}
        for j = 1, 4 do
            local bar = {}
            bar.root = TFDirector:getChildByPath(foo.root, "Image_order_" .. j)
            bar.Label_tacit = TFDirector:getChildByPath(bar.root, "Label_tacit")
            foo.Image_order[j] = bar
        end
        self.Panel_tacit[i] = foo
    end

    self:refreshView()
end

function ValentineRankView:refreshView()
    self:updateSprite()
    self:updateTacit()
end

function ValentineRankView:updateSprite()
    for i, v in ipairs(self.valentineRole_) do
        local foo = self.Panel_sprite[i]
        local cfg = ValentineDataMgr:getValentineRoleCfg(v)
        local roleModelCfg = TabDataMgr:getData("CityRoleModel", cfg.cityRole)
        local order = i > 3 and 4 or i
        for j, bar in ipairs(foo.Image_progress) do
            bar:setVisible(j == order)
        end
        foo.Image_head:setScale(0.8)
        foo.Image_head:setTexture(roleModelCfg.modeHead)
        foo.Button_sprite:onClick(function()
                Utils:openView("valentine.ValentineHandselView", v)
        end)
    end
end

function ValentineRankView:updateTacit()
    local valentineRole = ValentineDataMgr:getValentineRoleRank()
    local rank = {}
    for i, v in ipairs(valentineRole) do
        rank[v] = i
    end
    local maxTacit = ValentineDataMgr:getFullServerTacit(valentineRole[1])
    local maxScaleY = 0.8

    for i, v in ipairs(self.valentineRole_) do
        local rank = rank[v]
        local order = rank > 3 and 4 or rank
        local tacit = ValentineDataMgr:getFullServerTacit(v)

        local foo = self.Panel_tacit[i]
        for j, bar in ipairs(foo.Image_order) do
            bar.root:setVisible(j == order)
            bar.Label_tacit:setText(Utils:format_number_w(tacit))
        end

        local foo = self.Panel_sprite[i]
        for j, bar in ipairs(foo.Image_progress) do
            bar:setVisible(j == order)
            local scaleY = self.rankScale_[rank]
            bar:setScaleY(scaleY)
            if bar:isVisible() then
                local size = bar:getSize()
                local y = math.max(0, size.height * scaleY - 44)
                foo.Button_sprite:PosY(y - 10)
            end
        end
    end
end

function ValentineRankView:registerEvents()
    EventMgr:addEventListener(self, EV_VALENTINE_RANK_UPDATE, handler(self.onRankUpdateEvent, self))
end

function ValentineRankView:onRankUpdateEvent()
    self:updateTacit()
end

return ValentineRankView
