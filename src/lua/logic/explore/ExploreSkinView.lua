--[[
    @desc：飞船皮肤界面
]]

local ExploreSkinView = class("ExploreSkinView",BaseLayer)

function ExploreSkinView:initData(closeFunc)
    self.closeFunc = closeFunc
    self.shipSkinCfg = {}
    for i, v in pairs(TabDataMgr:getData("ShipSkin")) do
        table.insert(self.shipSkinCfg, v)
    end
    table.sort(self.shipSkinCfg, function(a, b)
        return a.id < b.id
    end)
    for i, v in ipairs(self.shipSkinCfg) do
        if v.id == ExploreDataMgr:getCurShipSkinId() then
            self.curSelectIdx = i
            break
        end
    end
    self.items = {}
end

function ExploreSkinView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.explore.exploreSkinView")
end

function ExploreSkinView:initUI(ui)
    self.super.initUI(self,ui)
    self._ui.lab_attrTxt:hide()
    self.scrollView_attrLab = UIListView:create(self._ui.ScrollView_attrLab)
    self.scrollView_attrLab:setItemsMargin(20)
    self.listView = UIListView:create(self._ui.ScrollView_selectView)
    self._ui.Spine_flyShip:setupPoseWhenPlay(false)
    self:updateInfo()
    self:initListView()
end

function ExploreSkinView:addItem()
    local item = self._ui.Panel_item:clone()
    local foo = {}
    foo.root = item
    foo.img_icon = TFDirector:getChildByPath(foo.root, "img_icon")
    foo.img_using = TFDirector:getChildByPath(foo.root, "img_using")
    foo.Spine_select = TFDirector:getChildByPath(foo.root, "Spine_select")
    foo.Spine_select:play("animation", true)
    foo.btn_choose = TFDirector:getChildByPath(foo.root, "btn_choose")
    foo.img_lock = TFDirector:getChildByPath(foo.root, "img_lock")
    foo.btn_go = TFDirector:getChildByPath(foo.img_lock, "btn_go")
    self.listView:pushBackCustomItem(item)
    self.items[item] = foo
end

function ExploreSkinView:initListView()
    self.listView:removeAllItems()
    for i = 1, #self.shipSkinCfg do
        self:addItem()
    end
    self:updateListView()
    self.listView:scrollToItem(self.curSelectIdx)
end

function ExploreSkinView:updateListView()
    for i, v in ipairs(self.listView:getItems()) do
        local foo = self.items[v]
        local cfg = self.shipSkinCfg[i]
        local spineCfg = TabDataMgr:getData("AfkRole", cfg.roleId)
        local isUnLock = ExploreDataMgr:isHadUnlock(cfg.id)

        foo.img_icon:setTexture(spineCfg.skinShow)
        foo.img_using:setVisible(cfg.id == ExploreDataMgr:getCurShipSkinId())
        foo.Spine_select:setVisible(self.curSelectIdx == i)
        foo.btn_choose:setVisible(isUnLock and not foo.img_using:isVisible())
        foo.img_lock:setVisible(not isUnLock)
        foo.img_icon:setTouchEnabled(true)
        foo.img_icon:onClick(function()
            if self.curSelectIdx == i then
                return
            end
            self.curSelectIdx = i
            self:updateListView()
            self:updateInfo()
        end)
        foo.btn_choose:onClick(function()
            self.curSelectIdx = i
            ExploreDataMgr:Send_EXPLORE_REQ_EXPLORE_UPDATE_SKIN(cfg.id)
        end)
        foo.btn_go:onClick(function()
            FunctionDataMgr:jStore(327000)
        end)
    end
end

function ExploreSkinView:updateInfo()
    local cfg = self.shipSkinCfg[self.curSelectIdx]
    local spineCfg = TabDataMgr:getData("AfkRole", cfg.roleId)
    self._ui.lab_topEn:setText(spineCfg.nameEn)
    self._ui.lab_topCh:setText(spineCfg.nameCn)
    self._ui.lab_bgDesc:setTextById(spineCfg.describe)
    self._ui.Spine_flyShip1:setFile(string.format("effect/exploreSkinEffects/%s/%s",spineCfg.id,spineCfg.appearResource))
    self._ui.Spine_flyShip:setFile(string.format("effect/exploreSkinEffects/%s/%s",spineCfg.id, spineCfg.showResource))
    self._ui.Spine_flyShip1:setPosition(ccp(spineCfg.showSite2.x, spineCfg.showSite2.y))
    self._ui.Spine_flyShip:setPosition(ccp(spineCfg.showSite2.x, spineCfg.showSite2.y))
    self._ui.Spine_flyShip:show()
    self._ui.Spine_flyShip:play(spineCfg.showAction,true)

    self._ui.lab_noAttr:setVisible(#cfg.talent == 0)

    self.scrollView_attrLab:removeAllItems()
    for i, id in ipairs(cfg.talent or {}) do
        local _txt = self._ui.lab_attrTxt:clone()
        _txt:show()
        _txt:setText(TabDataMgr:getData("AfkEffect", id).des2)
        _txt:setWidth(450)
        _txt:setLineHeight(30)
        self.scrollView_attrLab:pushBackCustomItem(_txt)
    end
end

function ExploreSkinView:registerEvents()
    self._ui.Button_back:onClick(function()
        -- ViewAnimationHelper.doMoveFadeInAction(self._ui.Panel_right, {direction = 1, distance = 0, ease = 2, delay = 0.5, time = 0.2})
		-- ViewAnimationHelper.doMoveFadeInAction(self._ui.Panel_bottom, {direction = 4, distance = 0, ease = 2, delay = 0.5, time = 0.2})
		-- local actions = Spawn:create({
		-- 	ScaleTo:create(0.4, 0.7),
		-- 	MoveTo:create(0.4,ccp(539,51)),
		-- })
        -- self._ui.Spine_flyShip:runAction(Sequence:create({actions, CallFunc:create(function()
            AlertManager:close(self)
			Utils:playSound(5048)
        -- end)}))
        return true
    end)

    EventMgr:addEventListener(self, EV_EXPLORE_SKINCHANGE, function()
        self:updateListView()
        self:updateInfo()
    end)

    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function()
        self:updateListView()
    end)
end

function ExploreSkinView:onShow()
    if not self.isInitView then
		self.isInitView = true
        self._ui.Spine_flyShip:hide()
        self._ui.Spine_flyShip1:hide()
        self._ui.Spine_shipDi:show()
        local cfg = ExploreDataMgr:getShipCfg()

        self._ui.Spine_shipDi:addMEListener(TFARMATURE_EVENT,function()
            self._ui.Spine_shipDi:removeMEListener(TFARMATURE_EVENT)
            self._ui.Spine_flyShip1:show()
            self._ui.Spine_flyShip1:play(cfg.appearAction,false)
            self._ui.Spine_flyShip1:addMEListener(TFARMATURE_EVENT,function ()
                self._ui.Spine_flyShip1:removeMEListener(TFARMATURE_EVENT)
                self:timeOut(function ()
                    self._ui.Spine_flyShip:show()
                    self._ui.Spine_flyShip:play(cfg.showAction,true)
                end, 0.1)
                
            end)
            self._ui.Spine_flyShip1:addMEListener(TFARMATURE_COMPLETE, function()
                self._ui.Spine_flyShip1:removeMEListener(TFARMATURE_COMPLETE)
                self._ui.Spine_flyShip1:hide()
            end)
        end)
        self._ui.Spine_shipDi:addMEListener(TFARMATURE_COMPLETE,function()
            self._ui.Spine_shipDi:removeMEListener(TFARMATURE_COMPLETE)
            self._ui.Spine_shipDi:play("effects_afkshipskin_loop", true)
        end)

        self._ui.Spine_shipDi:play("effects_afkshipskin_appear", false)
    end
end

function ExploreSkinView:onClose()
    self.super.onClose(self)
    if self.closeFunc then
        self.closeFunc()
    end
end

return ExploreSkinView