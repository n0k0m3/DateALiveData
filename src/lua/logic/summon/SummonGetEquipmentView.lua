
local SummonGetEquipmentView = class("SummonGetEquipmentView", BaseLayer)

function SummonGetEquipmentView:initData(equipmentId)
    self.equipmentId_ = equipmentId
    self.equipmentCfg_ = GoodsDataMgr:getItemCfg(equipmentId)
end

function SummonGetEquipmentView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.summon.summonGetEquipmentView")
end

function SummonGetEquipmentView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch"):hide()
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Image_equipmentModel = TFDirector:getChildByPath(self.Panel_root, "Image_equipmentModel")
    self.Image_equipmentModel_shadow = TFDirector:getChildByPath(self.Panel_root, "Image_equipmentModel_shadow")
    self.Spine_down = TFDirector:getChildByPath(self.Panel_root, "Spine_down")
    self.Spine_up = TFDirector:getChildByPath(self.Panel_root, "Spine_up")
    self.Image_name = TFDirector:getChildByPath(self.Panel_root, "Image_name")
    self.Spine_ziti = TFDirector:getChildByPath(self.Panel_root, "Spine_ziti"):hide()

    self:initSkipBtn()
    self:refreshView()
end

function SummonGetEquipmentView:refreshView()
    self.Image_equipmentModel:setTexture(self.equipmentCfg_.paint)
    self.Image_equipmentModel_shadow:setTexture(self.equipmentCfg_.paint)
    self.Image_name:setTexture(self.equipmentCfg_.nameIcon)

    -- self.Image_equipmentModel:Pos(ccpAdd(self.Image_equipmentModel:Pos(), self.equipmentCfg_.paintPosition))
    self.Image_equipmentModel:Pos(self.equipmentCfg_.paintPosition)
    self.Image_equipmentModel:setScale(self.equipmentCfg_.size)

    self.Image_equipmentModel:Scale(1.0)
    local action = EaseSineOut:create(
        ScaleTo:create(0.8, self.equipmentCfg_.size)
    )
    self.Image_equipmentModel:runAction(action)

    self.Image_equipmentModel_shadow:Alpha(0.2):Scale(self.equipmentCfg_.size + 0.2)
    local action = EaseSineOut:create(
        MoveBy:create(0.8, ccp(400, 0))
    )
    self.Image_equipmentModel_shadow:runAction(action)

    self.Image_name:Alpha(0)
    local action = Sequence:create({
            DelayTime:create(0.2),
            CallFunc:create(function()
                    self.Spine_ziti:show():play("ziti", false)
            end),
            DelayTime:create(0.2),
            CallFunc:create(function()
                    self.Image_name:fadeIn(1.0)
            end)
    })
    self.Panel_root:runAction(action)

    self.Spine_down:play("ruchang", 0)
    self.Spine_down:addMEListener(
        TFARMATURE_COMPLETE,
        function(skeletonNode)
            self.Spine_down:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_down:play("xunhuan", 1)
        end
    )

    self.Spine_up:play("ruchang", 0)
    self.Spine_up:addMEListener(
        TFARMATURE_COMPLETE,
        function(skeletonNode)
            self.Spine_up:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_up:play("xunhuan", 1)
        end
    )

    self.Panel_root:timeOut(function()
            self.Panel_touch:show()
    end, 1.0)
end

function SummonGetEquipmentView:registerEvents()
    self.Panel_touch:onClick(function()
            AlertManager:close()
            EventMgr:dispatchEvent(EV_SUMMON_TOUCH_CONTINUE)
    end)
end

function SummonGetEquipmentView:onShow()
    self.super.onShow(self)
    if CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        return
    end

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS --[[and TFDeviceInfo:getCurAppVersion() == "2.80"--]] then
        return;
    end

    if self.shareImg then
        return;
    end

    if not self.shareImg then
        self.shareImg = TFImage:create("ui/common/btn_share.png")
        self.shareImg:Pos(50, 50)
        self.ui:addChild(self.shareImg, 999);
        self.shareImg:setTouchEnabled(true);
        self.shareImg:onClick(function()
                self.shareImg:setVisible(false);
                Utils:gameShare();
            end);
    end
end

function SummonGetEquipmentView:initSkipBtn()
    self.skipBtn = TFImage:create("ui/dating/skipVideo.png")
    self.skipBtn:setAnchorPoint(ccp(1 , 0.5))
    --self.skipBtn:setOpacity(0)
    self.skipBtn:Pos(1136,50)
    self.Panel_root:addChild(self.skipBtn, 70)
    self.skipBtn:setScale(1.5)

    -- local size = self.skipBtn:getSize();
    -- self.skipBtn:setSize(ccs(size.width * 2,self.height * 2))

    self.skipBtn:onClick(function()
        AlertManager:close()
        EventMgr:dispatchEvent(EV_SUMMON_TOUCH_CONTINUE)
    end)

    ViewAnimationHelper.doflashAction(self.skipBtn , 1 ,0)
end

return SummonGetEquipmentView
