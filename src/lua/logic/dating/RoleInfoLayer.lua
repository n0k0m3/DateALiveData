local RoleInfoLayer = class("RoleInfoLayer",BaseLayer)
local DatingLayerType = EC_DatingLayerType

function RoleInfoLayer:ctor()
    self.super.ctor(self,datingLayerType)

    self:initData()
    self:init("lua.uiconfig.dating.roleInfoLayer")
end

function RoleInfoLayer:initData()

    self.layerType = DatingLayerType.infoType
    self.useId = RoleDataMgr:getCurId()
    self.useRoleInfo = clone(RoleDataMgr:getCurRoleInfo())
    self.currentStarLevel = self.useRoleInfo.favorLevel
    self.isShowRoleList = false
    self.moodLayer = nil
end

function RoleInfoLayer:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.root = TFDirector:getChildByPath(ui,"Panel")
    self.nodeGrid = NodeGrid:create(CCRect(ccp(0,0),me.Director:getWinSize()))
    self.root:retain();
    self.root:removeFromParent();
    self:addChild(self.nodeGrid)
    self.nodeGrid:addChild(self.root)

    self.Panel_base = TFDirector:getChildByPath(ui,"Panel_base")

    self.top = self.topLayer

    self.backBtn = TFDirector:getChildByPath(self.topLayer, 'Button_back');
    self.closeBtn = TFDirector:getChildByPath(self.topLayer, 'Button_main');


    self.Image_bg = TFDirector:getChildByPath(ui,"Image_backGround"):hide()

    self.Panel_elvesNpc = TFDirector:getChildByPath(self.ui,"Panel_elvesNpc")
    self.imageNpc = self.Panel_elvesNpc:getChild("Image_npc")
    self.savePos = self.imageNpc:Pos()

    self:initElvesInfoBoard()
    self:initInfoTip()
    self:initButtonOptions()
    self:initElvesNpc()
    self:initGoodFeeling()
    self:initCamera()
    self:initRoleListLayer()
    self:initButtonElvesInfo()
    self:refreshRedTips()
    self:showRoom()

    self:setBackBtnCallback(function()
             self:backBtnClickHandle()
        end)
end

function RoleInfoLayer:onElvesInfoClick()
    if self.moodLayer then
        self.moodLayer.close()
        self.moodLayer = nil
    else
        if self.elvesInfoBoard.isVisible then
            local seq = CCSequence:create({MoveBy:create(0.2,ccp(250,0)), CCCallFunc:create(function()
                    self.Button_elvesInfo:Touchable(true)
                end)})
            self.elvesNpc:runAction(seq)
            self.ui:runAnimation("Action1",1)
            self.elvesInfoBoard.isVisible = false
        end

        local data = {}
        data.useId = self.useId
        data.worldPos = self.Image_moodDes:getParent():convertToWorldSpace(self.Image_moodDes:Pos())
        data.parent = self.ui
        self.moodLayer = require("lua.logic.dating.MoodLayer")
        self.moodLayer.show(data)
    end
end

function RoleInfoLayer:initButtonElvesInfo()
    self.Button_elvesInfo = TFDirector:getChildByPath(self.ui,"Button_elvesInfo")
    self.Image_moodDes = TFDirector:getChildByPath(self.ui,"Image_moodDes"):hide()
    self.Button_elvesInfo:onClick(function ()
        self:onElvesInfoClick()
    end)

    self:refreshButtonElvesInfo()
end

function RoleInfoLayer:refreshButtonElvesInfo()
    self.Button_elvesInfo.Label_moodValue = TFDirector:getChildByPath(self.Button_elvesInfo,"Label_moodValue")
    self.Button_elvesInfo.Label_moodValue:setString(self.useRoleInfo.mood)

    self.Button_elvesInfo.Image_moodIcon = TFDirector:getChildByPath(self.Button_elvesInfo,"Image_moodIcon")
    local moodIconPath = self.useRoleInfo.moodPath
    local moodIconName = string.format("%s%d.png",moodIconPath,self.useRoleInfo.moodLevel)
    self.Button_elvesInfo.Image_moodIcon:setTexture(moodIconName)
end

function RoleInfoLayer:initRoleListLayer()
    self.Panel_kanBan = TFDirector:getChildByPath(self.ui,"Panel_kanBan")
    self.KanBanLayer = require("lua.logic.dating.KanBanLayer"):new(true)
    self:addLayerToNode(self.KanBanLayer,self.Panel_kanBan)
    -- self.KanBanLayer:setZOrder(30)
end

function RoleInfoLayer:switchShowOne()
    self:showRoom()
end

function RoleInfoLayer:bindRoleListEvent()
    EventMgr:addEventListener(self,EV_SHOW_KANBAN,handler(self.showRoleList, self))
    EventMgr:addEventListener(self,EV_HIDE_KANBAN,handler(self.hideRoleList, self))
    EventMgr:addEventListener(self,EV_KANBAN_CHANGE_SHOW_ONE,handler(self.changeShowOne, self))
    EventMgr:addEventListener(self,EV_KANBAN_SWITCH_SHOW_ONE,handler(self.switchShowOne, self))
end

function RoleInfoLayer:initCamera()
    self.Button_camera = TFDirector:getChildByPath(self.ui,"Button_camera")
    self.Button_camera:setVisible(true)
    -- 拍照按钮1
    self.Button_camera:onClick(function()
        self:changeOptionAction(true)
        self:hideOther()
        self.KanBanLayer:hide()
        self.Button_camera:setVisible(false)
        self.Button_camera2:setVisible(true)
    end)
    self.Button_camera2 = TFDirector:getChildByPath(self.ui,"Button_camera2")
    self.Button_camera2:setVisible(false)
    -- 拍照按钮2
    self.Button_camera2:onClick(function()
            self:optionExitAction(true)
            self:showOther()
            self.Button_camera:setVisible(true)
            self.Button_camera2:setVisible(false)
            self.KanBanLayer:show()
    end)
end

function RoleInfoLayer:addMoodValue(value)
    local moodIconPath = self.useRoleInfo.moodPath
    local moodIconName = string.format("%s%d.png",moodIconPath,self.useRoleInfo.moodLevel)

    self.Button_elvesInfo.Image_moodIcon:setTexture(moodIconName)
    self.Button_elvesInfo.Label_moodValue:setString(self.useRoleInfo.mood)
end

function RoleInfoLayer:initButtonOptions()
    self.panelButton = TFDirector:getChildByPath(self.ui,"Panel_button")
    self.panelButton:setZOrder(99)
    --兼职
    self.jobBtn = TFDirector:getChildByPath(self.ui,"Button_job")
    self.jobBtn:hide()
    --信息
    self.infoBtn = TFDirector:getChildByPath(self.ui,"Button_info")
    --赠送
    self.giveGiftsBtn = TFDirector:getChildByPath(self.ui,"Button_giveGifts")
    --换装
    self.changeDressBtn = TFDirector:getChildByPath(self.ui,"Button_changeDress")
    --装饰
    self.garnishBtn = TFDirector:getChildByPath(self.ui,"Button_garnish")
    --约会
    self.yueHuiBtn = TFDirector:getChildByPath(self.ui,"Button_dating")
    TFDirector:getChildByPath(self.yueHuiBtn,"Spine_redTips"):hide()
    self.yueHuiBtn.redTips = TFDirector:getChildByPath(self.yueHuiBtn,"Image_redTips"):hide()
    self.yueHuiBtn.ld = TFDirector:getChildByPath(self.yueHuiBtn, "Label_dating")
    --CG编辑
    self.cgEditBtn = TFDirector:getChildByPath(self.ui, "Button_cgEdit")
    self.cgEditBtn:hide()
    --剧本测试(暂时保留未使用)
    self.Button_datingTest = TFDirector:getChildByPath(self.ui, "Button_datingTest")
    self.Button_datingTest:hide()

    self:bindOptionsTouchEvent()
end

function RoleInfoLayer:refreshRedTips()
    if self.layerType == DatingLayerType.yuehuiType then
        return
    end
    print("refreshRedTips")
    if not RoleDataMgr:getDatingIsTip() then
        self.yueHuiBtn.redTips:hide()
    else
        self.yueHuiBtn.redTips:show()
    end

    if RoleDataMgr:getDatingIsNotFinish() then
        self.yueHuiBtn.ld:setTextById(900655)
    else
        self.yueHuiBtn.ld:setTextById(900654)
    end
end

function RoleInfoLayer:selectOptions(datingLayerType)
    if datingLayerType == DatingLayerType.giveGiftType then
        self:onGiveGiftsClick()
    elseif datingLayerType == DatingLayerType.changeDressType then
        self:onChangeDressClick()
    elseif datingLayerType == DatingLayerType.garnishType then
        self:onGarnishClick()
    elseif datingLayerType == DatingLayerType.yuehuiType then
        self:onYueHuiBtnClick()
    end
end

function RoleInfoLayer:bindOptionsTouchEvent()
    self.infoBtn:onClick(handler(self.onInfoClick,self))
    self.giveGiftsBtn:onClick(handler(self.onGiveGiftsClick,self))
    self.changeDressBtn:onClick(handler(self.onChangeDressClick,self))
    self.garnishBtn:onClick(handler(self.onGarnishClick,self))
    self.yueHuiBtn:onClick(handler(self.onYueHuiBtnClick,self))
    self.Image_infoTip:onClick(handler(self.onYueHuiBtnClick,self))

    self.cgEditBtn:onClick(handler(self.onCgEditBtnClick,self))
    self.Button_datingTest:onClick(handler(self.onDatingTestBtnClick,self))
    self.jobBtn:onClick(handler(self.onJobBtnClick,self))
end

function RoleInfoLayer:initInfoTip()
    self.Image_infoTip = TFDirector:getChildByPath(self.ui,"Image_infoTip"):hide()
    self.Label_infoTip = TFDirector:getChildByPath(self.Image_infoTip,"Label_infoTip")
    self.Label_infoTip:setString("...")
end

function RoleInfoLayer:showInfoTip()
    if self.layerType == DatingLayerType.infoType then
        self.Image_infoTip:show()
    end
end

function RoleInfoLayer:hideInfoTip()
    self.Image_infoTip:hide()
end

--看板娘
function RoleInfoLayer:initElvesNpc(modelId,pos,scale)
    if modelId == nil then
        local useid = self.useId;
        modelId = RoleDataMgr:getModel(useid);
    end
    self.modelId = modelId
    self.elvesNpc = ElvesNpcTable:createLive2dNpcID(self.modelId,true,true).live2d
    self.elvesNpc:hide()
    if not self.isShowRoleList then
        --self.elvesNpc:show()
         self.ui:timeOut(function()
             self.elvesNpc:playIn(0.3)
             end,0.2)
    end
    self.elvesNpc:setScale(0.7)
    self.elvesNpc.saveScale = self.elvesNpc:getScale()
    self.elvesNpc:registerEvents()

    self.Panel_elvesNpc:addChild(self.elvesNpc)
    self.elvesNpc:setZOrder(10)

    -- if pos then
    --     self.elvesNpc:setPosition(pos)
    --     self.elvesNpc:setScale(scale)
    -- else
        self.elvesNpc:setPosition(self.savePos)
    -- end

    self.imageNpc:setVisible(false)

end

function RoleInfoLayer:refreshElvesNpc(modelId)
    local useid = self.useId;
    local useModelId = RoleDataMgr:getModel(useid);
    print("refreshElvesNpc useModelId",useModelId)
    --live2d换装采用换模型方案
    local pos = self.elvesNpc:getPosition()
    local scale = self.elvesNpc:getScale()
    self.elvesNpc:removeFromParent()
    self:initElvesNpc(modelId,pos,scale)
end

--看板娘信息
function RoleInfoLayer:initElvesInfoBoard()
    local elvesInfoBoard = TFDirector:getChildByPath(self.ui,"Panel_elvesInfo")
    self.Image_roleInfoBg = TFDirector:getChildByPath(elvesInfoBoard,"Image_roleInfoBg")
    elvesInfoBoard.isVisible = false
    self.elvesInfoBoard = elvesInfoBoard

    --年龄
    -- self.label_age = TFDirector:getChildByPath(self.ui,"Label_age")
    --星座
    -- self.label_constellation = TFDirector:getChildByPath(self.ui,"Label_constellation")
    --身高
    self.label_height = TFDirector:getChildByPath(self.ui,"Label_height")
    --三维
    self.label_threeDimensional = TFDirector:getChildByPath(self.ui, "Label_threeDimensional")
    --生日
    self.Label_birthday = TFDirector:getChildByPath(self.ui, "Label_birthday")
    --体重
    self.label_weight = TFDirector:getChildByPath(self.ui, "Label_weight")
    --喜欢的食物
    self.label_favoriteFood_ = {}
    -- self.label_favoriteFood = TFDirector:getChildByPath(self.ui, "Label_favoriteFood")
    for i=1,4 do
        self.label_favoriteFood_[i] = TFDirector:getChildByPath(self.ui, "Label_favoriteFood" .. i)
    end

    --喜欢的衣服
    self.label_favoriteClothes_ = {}
    -- self.label_favoriteClothes = TFDirector:getChildByPath(self.ui, "Label_favoriteClothes")
    for i=1,4 do
        self.label_favoriteClothes_[i] = TFDirector:getChildByPath(self.ui, "Label_favoriteClothes" .. i)
    end

    --看板娘名字
    self.Label_name = TFDirector:getChildByPath(self.ui,"Label_name")
    --声优
    self.Label_theme = TFDirector:getChildByPath(self.ui,"Label_theme")

    self:refreshElvesInfoBoard()
end

function RoleInfoLayer:refreshElvesInfoBoard()
    local giftTable = TabDataMgr:getData("Item")
    --年龄
    -- self.label_age:setString(self.useRoleInfo.age)
    --星座
    -- self.label_constellation:setString(self.useRoleInfo.constellation)
    --身高
    self.label_height:setString(self.useRoleInfo.height)
    --三维
    self.label_threeDimensional:setTextById(self.useRoleInfo.threeDimensional)
    --名字
    self.Label_name:setTextById(self.useRoleInfo.nameId)
    --声优
    self.Label_theme:setString(TextDataMgr:getText(self.useRoleInfo.akiraId))
    --生日
    self.Label_birthday:setTextById(self.useRoleInfo.birthday)
    --体重
    self.label_weight:setTextById(self.useRoleInfo.weight)


    print("self.useRoleInfo.openFoodsId ",self.useRoleInfo.openFoodsId)
    --喜欢的食物
    local foodStr = ""
    for i,v in ipairs(self.useRoleInfo.openFoodsId) do
        local id = v
        local foodData = nil
        if giftTable then
            foodData = giftTable[id]
        end
        local foodName = ""
        if foodData then
            foodName = TextDataMgr:getText(foodData.nameTextId) or ""
        else
            foodName = TextDataMgr:getText(304017)
        end

        foodStr = foodStr .. foodName

        self.label_favoriteFood_[i]:setText(foodName)
    end

    --喜欢的礼物
    print("self.useRoleInfo.openGiftId ",self.useRoleInfo.openGiftId)
    local clotheStr = ""
    for i,v in ipairs(self.useRoleInfo.openGiftId) do
        local id = v
        local clotheData = nil
        if giftTable then
            clotheData = giftTable[id]
        end
        local clotheName = ""
        if clotheData then
            clotheName = TextDataMgr:getText(clotheData.nameTextId) or ""
        else
            clotheName = TextDataMgr:getText(304018)
        end

        clotheStr = clotheStr .. clotheName

        self.label_favoriteClothes_[i]:setText(clotheName)
    end

end

function RoleInfoLayer:initGoodFeeling()
    if self.favorView then
        self.favorView:refreshInfo()
        return
    end
    local data = {}
    self.Panel_goodFeeling = TFDirector:getChildByPath(self.ui, "Panel_goodFeeling")
    data.pos = self.Panel_goodFeeling:Pos()
    self.favorView = require("lua.logic.dating.FavorView"):new(data);
    self:addLayerToNode(self.favorView,self.Panel_goodFeeling,1);
    self.favorView:setZOrder(100)
end

function RoleInfoLayer:addFavorValue(value)

end

function RoleInfoLayer:closeBtnClickHandle(btn)
    self.closeBtn:setTouchEnabled(false)
    AlertManager:changeScene(SceneType.MainScene)
end

function RoleInfoLayer:backBtnClickHandle(btn)
    if self.layerType ~= DatingLayerType.infoType then
        self:refreshElvesNpc()
        self:initGoodFeeling()
        self.layerType = DatingLayerType.infoType
        self:optionExitAction()
    else
        self.backBtn:setTouchEnabled(false)
        self:closeBtnClickHandle()
    end
end

function RoleInfoLayer:onInfoClick(btn)
    btn:Touchable(false)
    if self.elvesInfoBoard.isVisible then
        self.elvesInfoBoard.isVisible = false
    else
        self.elvesInfoBoard.isVisible = true
    end
    if self.elvesInfoBoard.isVisible then
        self.ui:runAnimation("Action0",1)
        if self.moodLayer then
            self.moodLayer.close()
            self.moodLayer = nil
        end
        local seq = CCSequence:create({MoveBy:create(0.2,ccp(-250,0)), CCCallFunc:create(function()
                btn:Touchable(true)
            end)})
        self.elvesNpc:runAction(seq)
    else
        self.ui:runAnimation("Action1",1)
        local seq = CCSequence:create({MoveBy:create(0.2,ccp(250,0)), CCCallFunc:create(function()
                btn:Touchable(true)
            end)})
        self.elvesNpc:runAction(seq)
    end
end

function RoleInfoLayer:onGiveGiftsClick(btn)
    self.layerType = DatingLayerType.giveGiftType
    self:showOption()
    self:changeOptionAction()
end

function RoleInfoLayer:onChangeDressClick(btn)
    self.layerType = DatingLayerType.changeDressType
    self:showOption()
    self:changeOptionAction()
end

function RoleInfoLayer:onGarnishClick(btn)
    self.layerType = DatingLayerType.garnishType
    self:showOption()
    self:changeOptionAction()
end

function RoleInfoLayer:onYueHuiBtnClick(btn)
    self.layerType = DatingLayerType.yuehuiType
    self:showOption()
    self:changeOptionAction()
end

function RoleInfoLayer:onJobBtnClick(btn)
    self.layerType = DatingLayerType.jobType
    self:showOption()
    self:changeOptionAction()
end

function RoleInfoLayer:onCgEditBtnClick(btn)
    if GameConfig.Debug then
        local specialEffectsTestLayer = require("lua.logic.dating.SpecialEffectsTestLayer"):new()
        AlertManager:addLayer(specialEffectsTestLayer,AlertManager.BLOCK,AlertManager.TWEEN_NONE)
        AlertManager:show()
    end
end

function RoleInfoLayer:onDatingTestBtnClick(btn)
    if GameConfig.Debug then
        -- local datingTestView = Utils:openView("dating.DatingTestView")
        Utils:openView("dating.DatingLetterViewNew")
    end
end

function RoleInfoLayer:changeShowOne(modelId)
    if self.isShowRoleList == true then
        self.useId = RoleDataMgr:getCurId()
        self.useRoleInfo = clone(RoleDataMgr:getCurRoleInfo())
        self:refreshElvesNpc(modelId)
        self:initGoodFeeling()
        self:refreshElvesInfoBoard()
        self:onRefreshRedTips()
        self:refreshButtonElvesInfo()
        self:showRoom()
    end
end

function RoleInfoLayer:showRoleList()
    self.Button_camera:hide()
    self:changeOptionAction()
    self:hideOther(true)
    self.isShowRoleList = true
    if self.KanBanLayer then
        self.KanBanLayer:bindMode(self.elvesNpc)
    end
end

function RoleInfoLayer:hideRoleList()
    self.Button_camera:show()
    self:optionExitAction()
    self:showOther(true)
    self.isShowRoleList = false
end

function RoleInfoLayer:showOption()
    if self.layerType == DatingLayerType.changeDressType then
        self:showDressView()
    elseif self.layerType == DatingLayerType.giveGiftType then
        self:showGiftsView()
    elseif self.layerType == DatingLayerType.garnishType then
        self:showGarnishView()
    elseif self.layerType == DatingLayerType.yuehuiType then
        self:showYueHuiView()
    elseif self.layerType == DatingLayerType.jobType then
        self:showCityJobView()
    end
end

function RoleInfoLayer:showGiftsView()
    local layer = Utils:openView("dating.GiftsView")
    layer:setCloseCallback(function()
            self:backBtnClickHandle()
        end)
end

function RoleInfoLayer:showDressView(dressIds)
    local layer = Utils:openView("dating.DressView")

    layer:setCloseCallback(function()
            self:backBtnClickHandle()
        end)
end

function RoleInfoLayer:showGarnishView()
    local layer = Utils:openView("dating.DecorateRoomView")
    layer:setCloseCallback(function()
            self:backBtnClickHandle()
        end)
end

function RoleInfoLayer:showYueHuiView()
    local layer = Utils:openView("dating.DatingTypeView")
    layer:setCloseCallback(function()
        self:backBtnClickHandle()
    end)
end

function RoleInfoLayer:showCityJobView()
    local layer = Utils:openView("city.CityJobView")
    layer:setCloseCallback(function()
            self:backBtnClickHandle()
        end)
end

function RoleInfoLayer:changeOptionAction(isShow)
    local time = 0.3
    local panelButtonMoveOutAc = MoveBy:create(time,ccp(0,-1200))
    self.panelButton:runAction(panelButtonMoveOutAc)
    if not isShow then
        -- self.elvesNpc:playOut(0.3)
        self.elvesNpc:hide()
    end
    if self.elvesInfoBoard.isVisible then
        self:onInfoClick(self.Button_elvesInfo)
    end
    if self.moodLayer then
        self:onElvesInfoClick()
    end
    self:hideOther(true)
end


function RoleInfoLayer:hideOther(hideelves)--hideelves true（隐藏个人信息按钮），默认false（隐藏）
    hideelves = hideelves or false
    local seq = CCSequence:create({FadeOut:create(0.3), Hide:create()})
    self.favorView:runAction(seq)
    self.top:runAction(seq:clone())
    if hideelves then
        self.Button_elvesInfo:runAction(seq:clone())
    end
    -- self.favorView:fadeOut(0.3)
    -- self.top:fadeOut(0.3)
end

function RoleInfoLayer:showOther(showelves)--showelves true（显示个人信息按钮），默认false（显示）
    showelves = showelves or false
    local seq = CCSequence:create({FadeIn:create(0.3), Show:create()})
    self.favorView:runAction(seq)
    self.top:runAction(seq:clone())
    if showelves then
        self.Button_elvesInfo:runAction(seq:clone())
    end
    -- self.favorView:fadeIn(0.3)
    -- self.top:fadeIn(0.3)
end

function RoleInfoLayer:optionExitAction(isShow)

    self:onRefreshRedTips()

    local time = 0.3
    local deyTime = 0

    local panelButtonMoveInAc = MoveBy:create(time,ccp(0,1200))
    local eanelButtonAc = {
        DelayTime:create(deyTime),
        panelButtonMoveInAc
    }
    self.panelButton:runAction(CCSequence:create(eanelButtonAc))
    if not isShow then
         self.elvesNpc:hide()
         self.ui:timeOut(function()
             self.elvesNpc:playIn(0.3)
             end,0.2)
        --self.elvesNpc:show()
    end

    self:showOther(true)
end

function RoleInfoLayer:onClose()
    self.super.onClose(self)
end

-- 每次AlertManager:show()之后调用；子弹窗关闭时调用；断线重连时调用
function RoleInfoLayer:onShow()
    self.super.onShow(self)

    -- self:playShakyAction()
end

function RoleInfoLayer:showRoom()
    if self.roomView_ then
        self.roomView_:removeFromParent()
        self.roomView_ = nil
    end
    self.roomView_ = require("lua.logic.dating.RoomView"):new()
    self.Image_bg:getParent():addChild(self.roomView_,self.Image_bg:getZOrder()-1)
end

function RoleInfoLayer:onEnter()
    self.super.onEnter(self)
end


function RoleInfoLayer:onRefreshKanBanNiangEvent()
    local lastFavor = self.useRoleInfo.favor
    local lastMood = self.useRoleInfo.mood
    self.useId = RoleDataMgr:getCurId()
    self.useRoleInfo = clone(RoleDataMgr:getCurRoleInfo())
    local addFavorValue = self.useRoleInfo.favor - lastFavor
    local addMoodValue = self.useRoleInfo.mood - lastMood

    if addFavorValue > 0 then
        self:addFavorValue(addFavorValue)
    end
    if addMoodValue > 0 then
        self:addMoodValue(addMoodValue)
    end
end


function RoleInfoLayer:onRefreshRoleModelEvent(modelId)
    self:refreshElvesNpc(modelId)
end

function RoleInfoLayer:onRefreshRedTips()
    self:refreshRedTips()
end

function RoleInfoLayer:onRefreshFavorLevel(favorStr)
    self:refreshElvesInfoBoard()
    self:refreshButtonElvesInfo()
end

--屏幕抖动效果
function RoleInfoLayer:playShakyAction()
    local ac = Shaky3D:create(2.0,ccs(1,1),2,false)

    -- ac = PageTurn3D:create(4, CCSize(20, 20))

    -- ac = FadeOutDownTiles:create(4, CCSize(20, 50))

    local Arc = {
        DelayTime:create(2),
        ac
    }
    self.nodeGrid:runAction(CCSequence:create(Arc))
end

--注册事件
function RoleInfoLayer:registerEvents()

    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRoleModel, handler(self.onRefreshRoleModelEvent, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRole, handler(self.onRefreshKanBanNiangEvent, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshFavorLevel, handler(self.onRefreshFavorLevel, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRedTips, handler(self.onRefreshRedTips,self))


    self:bindRoleListEvent()
end
--移除事件
function RoleInfoLayer:removeEvents()

end

return RoleInfoLayer;
