--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
*  
* 
]]

local ARMainLayer = class("ARMainLayer", BaseLayer)

function ARMainLayer:ctor( data )
    self.super.ctor(self, data)
    self:initData(data)
    self:init("lua.uiconfig.ar.ARMainLayer")
end

function ARMainLayer:initData( data )
    self:initUIData(RoleDataMgr:getUseId())
    self:initSkinData(HeroDataMgr:getHeroIdByRoleId(RoleDataMgr:getUseId()))
end

function ARMainLayer:initUIData( roleId, modelId )
    self.modelId = self.modelId or nil
    self.live2dInitScale = 0.5
    self.live2dMaxSize = 1
    self.cameraViewNode = self.cameraViewNode or nil
    self.elvesNpc = self.elvesNpc or nil
    self.roleId = roleId
    self.defaultModelId = self:initKanBanInfo(self.roleId)
    
    self.dressCfgTable = TabDataMgr:getData("Dress")
    self.rotate = self.rotate or 0
    self.changeCameraStatus = true

    self.kanBanAnimationBtnList1 = self.kanBanAnimationBtnList1 or {}
    self.kanBanAnimationBtnList2 = self.kanBanAnimationBtnList2 or {}
end

function ARMainLayer:initSkinData( skinHeroId, skinId )
    self.skinHeroId = skinHeroId
    self.skinIdList = HeroDataMgr:getSkins(self.skinHeroId)
    self.curSkinId = skinId or HeroDataMgr:getCurSkin(self.skinHeroId)
end

function ARMainLayer:initKanBanInfo( roleId, modelId )
    local modelId = modelId or RoleDataMgr:getModel(roleId)
    local roleInfo = RoleDataMgr:getRoleInfo(roleId)
    local dressTable = TabDataMgr:getData("Dress")
    local dressData = dressTable[roleInfo.dressId]
    if dressData and dressData.type and dressData.type == 2 then
        modelId = dressData.highRoleModel
    end

    local roleId = RoleDataMgr:getRoleId(modelId)
    local roleInfo = RoleDataMgr:getRoleInfo(roleId)
    if not roleInfo then return end
    local favorLevel = roleInfo.favorLevel
    self.unLockKanBanInfo = {}
    self.allKanBanInfo = {}
    local iTable = TabDataMgr:getData("Interaction")
    for k,v in pairs(iTable) do
        local kanbaninfo = self:bindKanBanTouchPartsInfo(v)
        if (modelId == nil or (modelId and v.modelId == modelId)) and v.favor == favorLevel then
            table.insert(self.unLockKanBanInfo, kanbaninfo)
        end
        table.insert(self.allKanBanInfo, kanbaninfo)
    end
    table.sort(self.unLockKanBanInfo, function( a,b )
        return a.id < b.id
    end)
    table.sort(self.allKanBanInfo, function( a,b )
        return a.id < b.id
    end)
    return modelId
end

function ARMainLayer:bindKanBanTouchPartsInfo(kanBanInfoParts)
    local live2dParts = {}
    if kanBanInfoParts == nil then
        return {}
    end
    live2dParts.consecutiveClicks = 0                    -- 部位连续点击次数
    live2dParts.partsName = kanBanInfoParts.position     -- 部位名
    live2dParts.favor = kanBanInfoParts.favor            -- 好感度
    live2dParts.condition1 = {} --普通事件触发条件
    live2dParts.condition1.type = tonumber(string.split(kanBanInfoParts.condition1,";")[1])
    live2dParts.condition1.clickNum = tonumber(string.split(kanBanInfoParts.condition1,";")[2])
    live2dParts.voice1 = string.split(kanBanInfoParts.voice1, "-")           --普通事件语音
    live2dParts.action1 = string.split(kanBanInfoParts.action1, "-")         --普通事件动画
    live2dParts.lines1 = kanBanInfoParts.lines1          --普通事件台词
    live2dParts.condition2 = {} --特殊事件触发条件
    live2dParts.condition2.type = tonumber(string.split(kanBanInfoParts.condition2,";")[1])
    live2dParts.condition2.clickNum = tonumber(string.split(kanBanInfoParts.condition2,";")[2])
    live2dParts.voice2 = kanBanInfoParts.voice2          --特殊事件语音
    live2dParts.action2 = kanBanInfoParts.action2        --特殊事件动画
    live2dParts.lines2 = kanBanInfoParts.lines2          --特殊事件台词
    live2dParts.lineShow = kanBanInfoParts.lineShow      --看板娘台词组
    live2dParts.lineStop = kanBanInfoParts.lineStop      --看板娘台词时间组
    live2dParts.effect = kanBanInfoParts.effect          --特效名字
    live2dParts.anime = kanBanInfoParts.anime            --特效名字
    live2dParts.id = kanBanInfoParts.id
    return live2dParts
end

function ARMainLayer:initUI( ui )
    self.super.initUI(self, ui)
    self.modelPanel1 = TFDirector:getChildByPath(ui, "panel_model_1"):hide()
    self.live2dNameModel1 = TFDirector:getChildByPath(ui, "btn_live2dNameModel_1"):hide()

    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.cameraUIPanel = TFDirector:getChildByPath(self.rootPanel, "panel_camera_ui") 
    self.cameraPanel = TFDirector:getChildByPath(self.cameraUIPanel, "panel_camera") 
    self.live2dPanel = TFDirector:getChildByPath(self.cameraUIPanel, "panel_live2d")
    self.skinPanel = TFDirector:getChildByPath(self.cameraUIPanel, "panel_skin"):hide()

    self.landscapeUiPanel = TFDirector:getChildByPath(self.rootPanel, "panel_ui_landscape") 
    self.landscapeUiPanel.closeLabel = TFDirector:getChildByPath(self.landscapeUiPanel, "label_close") 
    self.landscapeUiPanel.closeBtn = TFDirector:getChildByPath(self.landscapeUiPanel, "btn_close") 
    self.landscapeUiPanel.cameraBtn = TFDirector:getChildByPath(self.landscapeUiPanel, "btn_camera") 
    self.landscapeUiPanel.changeCameraBtn = TFDirector:getChildByPath(self.landscapeUiPanel, "btn_changeCamera") 
    self.landscapeUiPanel.rotateBtn = TFDirector:getChildByPath(self.landscapeUiPanel, "btn_rotate") 
    
    self.landscapeUiPanel.panel1 = TFDirector:getChildByPath(self.landscapeUiPanel, "panel_1"):show()
    self.landscapeUiPanel.panel1.btn1 = TFDirector:getChildByPath(self.landscapeUiPanel.panel1, "btn_1") 
    self.landscapeUiPanel.panel1.btn2 = TFDirector:getChildByPath(self.landscapeUiPanel.panel1, "btn_2") 
    self.landscapeUiPanel.panel1.btn3 = TFDirector:getChildByPath(self.landscapeUiPanel.panel1, "btn_3") 
    self.landscapeUiPanel.panel1.btn3.lockImg = TFDirector:getChildByPath(self.landscapeUiPanel.panel1.btn3, "img_lock") 
    self.landscapeUiPanel.panel1.btn4 = TFDirector:getChildByPath(self.landscapeUiPanel.panel1, "btn_4") 
    
    self.landscapeUiPanel.panel2 = TFDirector:getChildByPath(self.landscapeUiPanel, "panel_2"):hide()
    self.landscapeUiPanel.panel2.backBtn = TFDirector:getChildByPath(self.landscapeUiPanel.panel2, "btn_back") 
    for i=1,6 do
        local btn = TFDirector:getChildByPath(self.landscapeUiPanel.panel2, "btn_" ..i) 
        btn.lockImg = TFDirector:getChildByPath(btn, "img_lock")
        table.insert(self.kanBanAnimationBtnList1, btn)
    end

    self.landscapeUiPanel.panel3 = TFDirector:getChildByPath(self.landscapeUiPanel, "panel_3"):hide()
    self.landscapeUiPanel.panel3.backBtn = TFDirector:getChildByPath(self.landscapeUiPanel.panel3, "btn_back") 
    self.landscapeUiPanel.panel3.clothesScrollView = TFDirector:getChildByPath(self.landscapeUiPanel.panel3, "scrollView_clothes") 
    self.landscapeUiPanel.panel3.clothesUIListView = UIListView:create(self.landscapeUiPanel.panel3.clothesScrollView)
    self.landscapeUiPanel.panel3.clothesUIListView:setItemModel(self.modelPanel1)

    self.landscapeUiPanel.panel3.live2dNameScrollView = TFDirector:getChildByPath(self.landscapeUiPanel.panel3, "scrollview_name") 
    self.landscapeUiPanel.panel3.live2dNameUIListView = UIListView:create(self.landscapeUiPanel.panel3.live2dNameScrollView)

    self.landscapeUiPanel.panel4 = TFDirector:getChildByPath(self.landscapeUiPanel, "panel_4"):hide()
    self.landscapeUiPanel.panel4.backBtn = TFDirector:getChildByPath(self.landscapeUiPanel.panel4, "btn_back") 

    self.landscapeUiPanel.panel4.suitScrollView = TFDirector:getChildByPath(self.landscapeUiPanel.panel4, "scrollView_suit") 
    self.landscapeUiPanel.panel4.suitUIListView = UIListView:create(self.landscapeUiPanel.panel4.suitScrollView)
    self.landscapeUiPanel.panel4.suitUIListView:setItemModel(self.modelPanel1)

    self.landscapeUiPanel.panel4.live2dNameScrollView = TFDirector:getChildByPath(self.landscapeUiPanel.panel4, "scrollview_name") 
    self.landscapeUiPanel.panel4.live2dNameUIListView = UIListView:create(self.landscapeUiPanel.panel4.live2dNameScrollView)

    self.landscapeUiPanel.scaleSlider = TFDirector:getChildByPath(self.landscapeUiPanel, "slider_scale") 
    self.landscapeUiPanel:show()

    self.portraitUiPanel = TFDirector:getChildByPath(self.rootPanel, "panel_ui_portrait") 
    self.portraitUiPanel.closeLabel = TFDirector:getChildByPath(self.portraitUiPanel, "label_close") 
    self.portraitUiPanel.closeBtn = TFDirector:getChildByPath(self.portraitUiPanel, "btn_close") 
    self.portraitUiPanel.cameraBtn = TFDirector:getChildByPath(self.portraitUiPanel, "btn_camera") 
    self.portraitUiPanel.changeCameraBtn = TFDirector:getChildByPath(self.portraitUiPanel, "btn_changeCamera") 
    self.portraitUiPanel.rotateBtn = TFDirector:getChildByPath(self.portraitUiPanel, "btn_rotate") 

    self.portraitUiPanel.panel1 = TFDirector:getChildByPath(self.portraitUiPanel, "panel_1"):show()
    self.portraitUiPanel.panel1.btn1 = TFDirector:getChildByPath(self.portraitUiPanel.panel1, "btn_1") 
    self.portraitUiPanel.panel1.btn2 = TFDirector:getChildByPath(self.portraitUiPanel.panel1, "btn_2") 
    self.portraitUiPanel.panel1.btn3 = TFDirector:getChildByPath(self.portraitUiPanel.panel1, "btn_3") 
    self.portraitUiPanel.panel1.btn3.lockImg = TFDirector:getChildByPath(self.portraitUiPanel.panel1.btn3, "img_lock") 
    self.portraitUiPanel.panel1.btn4 = TFDirector:getChildByPath(self.portraitUiPanel.panel1, "btn_4") 

    self.portraitUiPanel.panel2 = TFDirector:getChildByPath(self.portraitUiPanel, "panel_2"):hide()
    self.portraitUiPanel.panel2.backBtn = TFDirector:getChildByPath(self.portraitUiPanel.panel2, "btn_back") 
    for i=1,6 do
        local btn = TFDirector:getChildByPath(self.portraitUiPanel.panel2, "btn_" ..i) 
        btn.lockImg = TFDirector:getChildByPath(btn, "img_lock")
        table.insert(self.kanBanAnimationBtnList2, btn)
    end

    self.portraitUiPanel.panel3 = TFDirector:getChildByPath(self.portraitUiPanel, "panel_3"):hide()
    self.portraitUiPanel.panel3.backBtn = TFDirector:getChildByPath(self.portraitUiPanel.panel3, "btn_back") 
    self.portraitUiPanel.panel3.clothesScrollView = TFDirector:getChildByPath(self.portraitUiPanel.panel3, "scrollView_clothes") 
    self.portraitUiPanel.panel3.clothesUIListView = UIListView:create(self.portraitUiPanel.panel3.clothesScrollView)
    self.portraitUiPanel.panel3.clothesUIListView:setItemModel(self.modelPanel1)

    self.portraitUiPanel.panel3.live2dNameScrollView = TFDirector:getChildByPath(self.portraitUiPanel.panel3, "scrollview_name") 
    self.portraitUiPanel.panel3.live2dNameUIListView = UIListView:create(self.portraitUiPanel.panel3.live2dNameScrollView)

    self.portraitUiPanel.panel4 = TFDirector:getChildByPath(self.portraitUiPanel, "panel_4"):hide()
    self.portraitUiPanel.panel4.backBtn = TFDirector:getChildByPath(self.portraitUiPanel.panel4, "btn_back") 

    self.portraitUiPanel.panel4.suitScrollView = TFDirector:getChildByPath(self.portraitUiPanel.panel4, "scrollView_suit") 
    self.portraitUiPanel.panel4.suitUIListView = UIListView:create(self.portraitUiPanel.panel4.suitScrollView)
    self.portraitUiPanel.panel4.suitUIListView:setItemModel(self.modelPanel1)

    self.portraitUiPanel.panel4.live2dNameScrollView = TFDirector:getChildByPath(self.portraitUiPanel.panel4, "scrollview_name") 
    self.portraitUiPanel.panel4.live2dNameUIListView = UIListView:create(self.portraitUiPanel.panel4.live2dNameScrollView)


    self.portraitUiPanel.scaleSlider = TFDirector:getChildByPath(self.portraitUiPanel, "slider_scale") 
    self.portraitUiPanel:hide()

    if not(CC_TARGET_PLATFORM == CC_PLATFORM_WIN32) then
        local cameraViewNode = requireNew("lua.public.CameraViewNode"):new()
        self.cameraViewNode = cameraViewNode
        self:addLayerToNode(cameraViewNode, self.cameraPanel)
    end   

    self:updateUI()
end

function ARMainLayer:onShow( )
    self.super.onShow(self)
    if HeitaoSdk then
        HeitaoSdk.openAR()
    end 
end

function ARMainLayer:registerEvents( )
    self.super.registerEvents(self)
    --时装
    self.landscapeUiPanel.panel1.btn1:onClick(function()
        self:showClothesSubUI(SCREEN_ORIENTATION_LANDSCAPE)    
    end)
    self.portraitUiPanel.panel1.btn1:onClick(function()
        self:showClothesSubUI(SCREEN_ORIENTATION_PORTRAIT)
    end)

    --灵装
    self.landscapeUiPanel.panel1.btn2:onClick(function()
        self:showSkinSubUI(SCREEN_ORIENTATION_LANDSCAPE)
    end)
    self.portraitUiPanel.panel1.btn2:onClick(function()
        self:showSkinSubUI(SCREEN_ORIENTATION_PORTRAIT)
    end)

    --动作
    self.landscapeUiPanel.panel1.btn3:onClick(function()
        self:showActionPanel(SCREEN_ORIENTATION_LANDSCAPE)
    end)
    self.portraitUiPanel.panel1.btn3:onClick(function()
        self:showActionPanel(SCREEN_ORIENTATION_PORTRAIT)
    end)

    for i=1,6 do
        self.kanBanAnimationBtnList1[i]:onClick(function()    
            if self.unLockKanBanInfo[i] == nil then return Utils:showTips(304002) end
            self.elvesNpc:kanbanTouchEvent(self.unLockKanBanInfo[i], ccp(self.elvesNpc:getPositionX(), self.elvesNpc:getPositionY() - 100))
        end)

        self.kanBanAnimationBtnList2[i]:onClick(function()    
            if self.unLockKanBanInfo[i] == nil then return Utils:showTips(304002) end
            self.elvesNpc:kanbanTouchEvent(self.unLockKanBanInfo[i], ccp(self.elvesNpc:getPositionX(), self.elvesNpc:getPositionY() - 100))
        end)
    end

    self.landscapeUiPanel.panel2.backBtn:onClick(function()
        self:onSubBackBtnClicked(self.landscapeUiPanel.panel2.backBtn)
    end)
    self.portraitUiPanel.panel2.backBtn:onClick(function()
        self:onSubBackBtnClicked(self.portraitUiPanel.panel2.backBtn)
    end)
    self.landscapeUiPanel.panel3.backBtn:onClick(function()
        self:onSubBackBtnClicked(self.landscapeUiPanel.panel3.backBtn)
    end)
    self.portraitUiPanel.panel3.backBtn:onClick(function()
        self:onSubBackBtnClicked(self.portraitUiPanel.panel3.backBtn)
    end)

    self.landscapeUiPanel.panel4.backBtn:onClick(function()
        self:onSubBackBtnClicked(self.landscapeUiPanel.panel4.backBtn)
    end)
    self.portraitUiPanel.panel4.backBtn:onClick(function()
        self:onSubBackBtnClicked(self.portraitUiPanel.panel4.backBtn)
    end)


    self.landscapeUiPanel.closeBtn:onClick(function()
        self:closeLayer()
    end)
    self.portraitUiPanel.closeBtn:onClick(function()
        self:closeLayer()
    end)

    --拍照
    self.landscapeUiPanel.cameraBtn:onClick(function()
        self.landscapeUiPanel:hide()
        self:timeOut(function()
            Utils:gameShare()
        end,1)

        self:timeOut(function()
            self.landscapeUiPanel:show()
        end,2)
    end)
    self.portraitUiPanel.cameraBtn:onClick(function()
        self.portraitUiPanel:hide()
        self:timeOut(function()
            Utils:gameShare()
        end,1)

        self:timeOut(function()
            self.portraitUiPanel:show()
        end,2)
    end)

    --切换镜头
    self.landscapeUiPanel.changeCameraBtn:onClick(function()
        self:changeCamera()
    end)
    self.portraitUiPanel.changeCameraBtn:onClick(function()
        self:changeCamera()
    end)

    --旋转
    self.landscapeUiPanel.rotateBtn:onClick(function()
        self.landscapeUiPanel:hide()
        self.portraitUiPanel:show()
        self.elvesNpc:setRotation(-90)
        self.heroSkinAnim:setRotation(-90)
        self.rotate = -90
        self:rectify()
        self.portraitUiPanel.scaleSlider:setPercent(self.landscapeUiPanel.scaleSlider:getPercent())
    end)
    self.portraitUiPanel.rotateBtn:onClick(function()
        self.landscapeUiPanel:show()
        self.portraitUiPanel:hide()
        self.elvesNpc:setRotation(0)
        self.heroSkinAnim:setRotation(0)
        self.rotate = 0
        self:rectify()
        self.landscapeUiPanel.scaleSlider:setPercent(self.portraitUiPanel.scaleSlider:getPercent())
    end)

    self.landscapeUiPanel.scaleSlider:addMEListener(
        TFSLIDER_CHANGED,
        function(...)
            local percent = self.landscapeUiPanel.scaleSlider:getPercent()
            self.elvesNpc:setScale(percent*0.01*self.live2dMaxSize)
            self.heroSkinAnim:setScale(percent*0.01*self.live2dMaxSize)
        end
    )
    self.portraitUiPanel.scaleSlider:addMEListener(
        TFSLIDER_CHANGED,
        function(...)
            local percent = self.portraitUiPanel.scaleSlider:getPercent()            
            self.elvesNpc:setScale(percent*0.01*self.live2dMaxSize)
            self.heroSkinAnim:setScale(percent*0.01*self.live2dMaxSize)
        end
    )

    local onTouchBegan = function( sender )
        local touchPos = self.live2dPanel:convertToNodeSpace(sender:getTouchStartPos())
        self.prevPoint = touchPos
    end
    self.live2dPanel:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)

    local onTouchMoved = function( sender )
        local touchPrevPos = self.prevPoint
        local touchMovePos =  self.live2dPanel:convertToNodeSpace(sender:getTouchMovePos())
        local disx = touchMovePos.x - touchPrevPos.x
        local disy = touchMovePos.y - touchPrevPos.y
        local pos = self.elvesNpc:Pos()
        if self.elvesNpc.type == 1 then
            pos.y = pos.y - me.Director:getWinSize().height/2
        end
        self.elvesNpc:setPosition(ccp(pos.x + disx, pos.y + disy))
        self.prevPoint = touchMovePos
    end
    self.live2dPanel:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved)

    local onTouchBegan = function( sender )
        local touchPos = self.skinPanel:convertToNodeSpace(sender:getTouchStartPos())
        self.skinPrevPoint = touchPos
    end
    self.skinPanel:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)

    local onTouchMoved = function( sender )
        local touchPrevPos = self.skinPrevPoint
        local touchMovePos =  self.skinPanel:convertToNodeSpace(sender:getTouchMovePos())
        local disx = touchMovePos.x - touchPrevPos.x
        local disy = touchMovePos.y - touchPrevPos.y
        local pos = self.heroSkinAnim:Pos()
        self.heroSkinAnim:setPosition(ccp(pos.x + disx, pos.y + disy))
        self.skinPrevPoint = touchMovePos
    end
    self.skinPanel:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved)

    --游戏切后台处理
    EventMgr:addEventListener(self,EV_APP_ENTERBACKGROUND, handler(self.onEnterBackGround,self))
    EventMgr:addEventListener(self,EV_APP_ENTERFOREGROUND, handler(self.onEnterForeGround,self))

    if self.cameraViewNode then
        self.cameraViewNode:register()
    end
end

function ARMainLayer:closeLayer( )
    self.elvesNpc:removeFromParent()
    self.elvesNpc = nil
    if not(CC_TARGET_PLATFORM == CC_PLATFORM_WIN32) then
        if self.cameraViewNode then
            self.cameraViewNode:dispose()
        end
        self:removeLayerFromNode(self.cameraViewNode, self.cameraPanel)
    end
    AlertManager:closeLayer(self)
end

function ARMainLayer:removeEvents( )
    self.super.removeEvents(self)
end

function ARMainLayer:removeUI()
    self.super.removeUI(self)
    self.cameraViewNode = nil
end

function ARMainLayer:showClothesSubUI( orientation )
    self.live2dPanel:show()
    self.skinPanel:hide()

    --竖屏
    if orientation == SCREEN_ORIENTATION_PORTRAIT then
        self.portraitUiPanel.panel1:hide()
        self.portraitUiPanel.panel2:hide()
        self.portraitUiPanel.panel3:show()
        self.portraitUiPanel.panel4:hide()
        return
    end
    --横屏
    if orientation == SCREEN_ORIENTATION_LANDSCAPE then
        self.landscapeUiPanel.panel1:hide()
        self.landscapeUiPanel.panel2:hide()
        self.landscapeUiPanel.panel3:show()
        self.landscapeUiPanel.panel4:hide()
        return
    end
end

function ARMainLayer:hideClothesSubUI( orientation )
    if orientation == SCREEN_ORIENTATION_LANDSCAPE then
        self.landscapeUiPanel.panel1:show()
        self.landscapeUiPanel.panel2:hide()
        self.landscapeUiPanel.panel3:hide()
        self.landscapeUiPanel.panel4:hide()
        self.landscapeUiPanel.panel1.btn3:setTouchEnabled(true)
        self.landscapeUiPanel.panel1.btn3.lockImg:hide()
        return
    end
    
    if orientation == SCREEN_ORIENTATION_PORTRAIT then
        self.portraitUiPanel.panel1:show()
        self.portraitUiPanel.panel2:hide()
        self.portraitUiPanel.panel3:hide()
        self.portraitUiPanel.panel4:hide()
        self.portraitUiPanel.panel1.btn3:setTouchEnabled(true)
        self.portraitUiPanel.panel1.btn3.lockImg:hide()
        return
    end
end

function ARMainLayer:showSkinSubUI( orientation )
    self.live2dPanel:hide()
    self.skinPanel:show()

    --竖屏
    if orientation == SCREEN_ORIENTATION_PORTRAIT then
        self.portraitUiPanel.panel1:hide()
        self.portraitUiPanel.panel2:hide()
        self.portraitUiPanel.panel3:hide()
        self.portraitUiPanel.panel4:show()
        return
    end
    --横屏
    if orientation == SCREEN_ORIENTATION_LANDSCAPE then
        self.landscapeUiPanel.panel1:hide()
        self.landscapeUiPanel.panel2:hide()
        self.landscapeUiPanel.panel3:hide()
        self.landscapeUiPanel.panel4:show()
        return
    end
end

function ARMainLayer:hideSkinSubUI( orientation )
   if orientation == SCREEN_ORIENTATION_LANDSCAPE then
        self.landscapeUiPanel.panel1:show()
        self.landscapeUiPanel.panel2:hide()
        self.landscapeUiPanel.panel3:hide()
        self.landscapeUiPanel.panel4:hide()
        self.landscapeUiPanel.panel1.btn3:setTouchEnabled(false)
        self.landscapeUiPanel.panel1.btn3.lockImg:show()
        return
    end
    
    if orientation == SCREEN_ORIENTATION_PORTRAIT then
        self.portraitUiPanel.panel1:show()
        self.portraitUiPanel.panel2:hide()
        self.portraitUiPanel.panel3:hide()
        self.portraitUiPanel.panel4:hide()
        self.portraitUiPanel.panel1.btn3:setTouchEnabled(false)
        self.portraitUiPanel.panel1.btn3.lockImg:show()
        return
    end
end

function ARMainLayer:updateUI( )
    self:updateLive2d(self.defaultModelId)
    self:updateKanBanAniStatus()
    self:updateClothesUIListView()
    self:updateSkinUIList()
    self:updateSkinModel()

    self.landscapeUiPanel.scaleSlider:setPercent(self.live2dInitScale/self.live2dMaxSize*100)
    self.portraitUiPanel.scaleSlider:setPercent(self.live2dInitScale/self.live2dMaxSize*100)
end

function ARMainLayer:updateLive2d( modelId )
    if self.elvesNpc then
        self.elvesNpc:removeFromParent()
    end
    local elvesNpcTable = ElvesNpcTable:createLive2dNpcID(modelId,true,false,nil,false)
    if not elvesNpcTable then
        return 
    end
    self.elvesNpc = elvesNpcTable.live2d
    self.elvesNpc:setRotation(self.rotate)
    self:rectify()
    self.elvesNpc:registerEvents()
    self.elvesNpc:setScale(self.live2dInitScale) --缩放
    self.elvesNpc.roleTextViewExPos = ccp(self.elvesNpc:getPositionX(), self.elvesNpc:getPositionY() - 100)
    self.elvesNpc:setRotation(self.rotate)
    self.live2dPanel:addChild(self.elvesNpc)
    self.modelId = modelId
    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()
end

function ARMainLayer:rectify( )
    if self.elvesNpc and self.rotate == 0 then
        self.elvesNpc:setPosition(ccp(0,-350))
    elseif self.elvesNpc and self.rotate == -90 then
        self.elvesNpc:setPosition(ccp(-100,-320))
    end

    if self.heroSkinAnim and self.rotate == 0 then
        self.heroSkinAnim:setPosition(ccp(0,-320))
    elseif self.heroSkinAnim and self.rotate == -90 then
        self.heroSkinAnim:setPosition(ccp(250, 0))
    end
end

function ARMainLayer:updateKanBanAniStatus( )
    local imgPath = {}
    imgPath[EC_HIT_AREA_NAME.HEAD] = "ui/ar/ar_acamer_34.png"
    imgPath[EC_HIT_AREA_NAME.BODY] = "ui/ar/ar_acamer_33.png"
    imgPath[EC_HIT_AREA_NAME.FUBU] = "ui/ar/ar_acamer_35.png"
    imgPath[EC_HIT_AREA_NAME.TUI] = "ui/ar/ar_acamer_35.png"
    imgPath[EC_HIT_AREA_NAME.HAND_R] = "ui/ar/ar_acamer_35.png"
    imgPath[EC_HIT_AREA_NAME.HAND_L] = "ui/ar/ar_acamer_35.png"

    for i=1,6 do
        local btn1 = self.kanBanAnimationBtnList1[i]
        btn1.lockImg:hide()
        if self.unLockKanBanInfo[i] == nil then
            btn1.lockImg:show()
        end
        local btn2 = self.kanBanAnimationBtnList2[i]
        btn2.lockImg:hide()
        if self.unLockKanBanInfo[i] == nil then
            btn2.lockImg:show()
        end
        local favorNum = 0
        local kanbaninfo = self.allKanBanInfo[i]
        if kanbaninfo then
            favorNum = kanbaninfo.favor
        end
        local labelTitle1 = TFDirector:getChildByPath(btn1, "label_title") 
        labelTitle1:setTextById(190000041, favorNum)

        local labelTitle2 = TFDirector:getChildByPath(btn2, "label_title") 
        labelTitle2:setTextById(190000041, favorNum)

        local img1 = TFDirector:getChildByPath(btn1, "img_1") 
        img1:setTexture(imgPath[kanbaninfo.partsName] or imgPath[EC_HIT_AREA_NAME.TUI])

        local img2 = TFDirector:getChildByPath(btn2, "img_1") 
        img2:setTexture(imgPath[kanbaninfo.partsName] or imgPath[EC_HIT_AREA_NAME.TUI])
    end
end

function ARMainLayer:updateClothesUIListView( )
    self.landscapeUiPanel.panel3.clothesUIListView:removeAllItems()
    self.portraitUiPanel.panel3.clothesUIListView:removeAllItems()

    local dressId = RoleDataMgr:getDressIdList(self.roleId)
    for i,_id in ipairs(dressId) do
        local clothesItem1 = self.landscapeUiPanel.panel3.clothesUIListView:pushBackDefaultItem()
        clothesItem1:show()
        self:updateClothesItem(clothesItem1, i, SCREEN_ORIENTATION_LANDSCAPE)

        local clothesItem2 = self.portraitUiPanel.panel3.clothesUIListView:pushBackDefaultItem()
        clothesItem2:show()
        self:updateClothesItem(clothesItem2, i, SCREEN_ORIENTATION_PORTRAIT)
    end

    self.landscapeUiPanel.panel3.live2dNameUIListView:removeAllItems()
    self.portraitUiPanel.panel3.live2dNameUIListView:removeAllItems()
    local roleCount = RoleDataMgr:getRoleCount()
    for i=1,roleCount do
        local liva2dNameItem = self.live2dNameModel1:clone()
        liva2dNameItem:show()
        self:updateLive2dNameItem(liva2dNameItem, i, SCREEN_ORIENTATION_LANDSCAPE)
        self.landscapeUiPanel.panel3.live2dNameUIListView:pushBackCustomItem(liva2dNameItem)

        local liva2dNameItem = self.live2dNameModel1:clone()
        liva2dNameItem:show()
        self:updateLive2dNameItem(liva2dNameItem, i, SCREEN_ORIENTATION_PORTRAIT)
        self.portraitUiPanel.panel3.live2dNameUIListView:pushBackCustomItem(liva2dNameItem)
    end
end

function ARMainLayer:updateClothesItem( item, idx, orientation )
    local dressId = RoleDataMgr:getDressIdList(self.roleId)
    local dressId = dressId[idx]
    
    local lockImg = TFDirector:getChildByPath(item, "img_lock")
    lockImg:hide()
    local lockStatus = GoodsDataMgr:getDress(dressId)
    if not lockStatus then
        lockImg:show()
    end

    local titleLabel = TFDirector:getChildByPath(item, "label_title")
    local dressCfg = self.dressCfgTable[dressId]
    titleLabel:setTextById(190000042,idx)

    local iconImg = TFDirector:getChildByPath(item, "img_1")
    iconImg:setTexture(dressCfg.icon)
    --iconImg:setScale(0.45)

    local btn = TFDirector:getChildByPath(item, "model_btn")
    btn:onClick(function( )
        if not lockStatus then return end
        local dressCfg = self.dressCfgTable[dressId]
        if dressCfg == nil then return end
        local modelId = dressCfg.roleModel
        if dressCfg and dressCfg.type and dressCfg.type == 2 then
            modelId = dressCfg.highRoleModel
        end
        if self.modelId  == modelId then return end
        self:initKanBanInfo(HeroDataMgr:getHeroRoleId(self.roleId), modelId)
        self:updateKanBanAniStatus()
        self:updateLive2d( modelId )
    end)

    if orientation == SCREEN_ORIENTATION_PORTRAIT then
        item:setRotation(270)
    end
end

function ARMainLayer:updateSkinItem( item, idx, orientation )
    local skinId = self.skinIdList[idx]
    local skinData = TabDataMgr:getData("HeroSkin",skinId)
    
    local isUnlock = HeroDataMgr:checkSkinUnlock(skinId)
    local lockImg = TFDirector:getChildByPath(item, "img_lock")
    lockImg:hide()
    if not isUnlock then
        lockImg:show()
    end

    local itemCfg = GoodsDataMgr:getItemCfg(skinId)
    local img = TFDirector:getChildByPath(item, "img_1")
    img:setTexture(itemCfg.icon)

    local btn = TFDirector:getChildByPath(item, "model_btn")
    btn:onClick(function( )
        if not isUnlock then return end
        self:initSkinData(self.skinHeroId, skinId)
        self:updateUI()
    end)

    local labelTitle = TFDirector:getChildByPath(btn, "label_title") 
    labelTitle:hide()

    if orientation == SCREEN_ORIENTATION_PORTRAIT then
        item:setRotation(270)
    end
end

function ARMainLayer:updateLive2dNameItem( item, idx, orientation )
    local roleId = RoleDataMgr:getRoleIdByShowIdx(idx)
    local moodImg = TFDirector:getChildByPath(item, "img_mood")
    moodImg:setTexture(RoleDataMgr:getMoodPath(roleId) .."4.png")
    item:setColor(ccc3(80,80,80))

    if self.roleId == roleId then
        item:setColor(ccc3(255,255,255))
    end

    item:onClick(function()
        if self.roleId == roleId then return end 
        self:initUIData(roleId)
        self:updateUI()
    end)

    if orientation == SCREEN_ORIENTATION_PORTRAIT then
        item:setRotation(270)
    end
end

function ARMainLayer:updateSkinUIList( )
    self.landscapeUiPanel.panel4.live2dNameUIListView:removeAllItems()
    local showCount = HeroDataMgr:getShowCount()
    for i=1,showCount do
        local liva2dNameItem = self.live2dNameModel1:clone()
        liva2dNameItem:show()
        self:updateSkinNameItem(liva2dNameItem, i, SCREEN_ORIENTATION_LANDSCAPE)
        self.landscapeUiPanel.panel4.live2dNameUIListView:pushBackCustomItem(liva2dNameItem)
    end

    self.landscapeUiPanel.panel4.suitUIListView:removeAllItems()
    for i,v in ipairs(self.skinIdList) do
        local suitItem1 = self.landscapeUiPanel.panel4.suitUIListView:pushBackDefaultItem()
        suitItem1:show()
        self:updateSkinItem(suitItem1, i, SCREEN_ORIENTATION_LANDSCAPE)
    end

    self.portraitUiPanel.panel4.live2dNameUIListView:removeAllItems()
    for i=1,showCount do
        local liva2dNameItem = self.live2dNameModel1:clone()
        liva2dNameItem:show()
        self:updateSkinNameItem(liva2dNameItem, i, SCREEN_ORIENTATION_PORTRAIT)
        self.portraitUiPanel.panel4.live2dNameUIListView:pushBackCustomItem(liva2dNameItem)
    end

    self.portraitUiPanel.panel4.suitUIListView:removeAllItems()
    for i,v in ipairs(self.skinIdList) do
        local suitItem1 = self.portraitUiPanel.panel4.suitUIListView:pushBackDefaultItem()
        suitItem1:show()
        self:updateSkinItem(suitItem1, i, SCREEN_ORIENTATION_PORTRAIT)
    end
end

function ARMainLayer:updateSkinNameItem( item ,idx, orientation)
    local moodImg = TFDirector:getChildByPath(item, "img_mood")
    local heroid = HeroDataMgr:getSelectedHeroId(idx)
    moodImg:setTexture("icon/role/ar/" ..heroid..".png")
    item:setColor(ccc3(80,80,80))

    if self.skinHeroId == heroid then
        item:setColor(ccc3(255,255,255))
    end

    item:onClick(function()
        if heroid == self.skinHeroId then return end
        self:initSkinData(heroid)
        self:updateUI()
    end)

    if orientation == SCREEN_ORIENTATION_PORTRAIT then
        item:setRotation(270)
    end
end

function ARMainLayer:updateSkinModel( )
    self.heroSkinAnim = Utils:createHeroModel(self.skinHeroId, self.skinPanel, nil, self.curSkinId)
    self.heroSkinAnim:setScale(0.5)
    self.heroSkinAnim:setRotation(self.rotate)
    self:rectify()
end

function ARMainLayer:showActionPanel( orientation )
    --竖屏
    if orientation == SCREEN_ORIENTATION_PORTRAIT then
        self.portraitUiPanel.panel1:hide()
        self.portraitUiPanel.panel2:show()
        self.portraitUiPanel.panel3:hide()
        self.portraitUiPanel.panel4:hide()
        return
    end
    --横屏
    if orientation == SCREEN_ORIENTATION_LANDSCAPE then
        self.landscapeUiPanel.panel1:hide()
        self.landscapeUiPanel.panel2:show()
        self.landscapeUiPanel.panel3:hide()
        self.landscapeUiPanel.panel4:hide()
        return
    end
end

function ARMainLayer:showSuitPanel( orientation )
    --竖屏
    if orientation == SCREEN_ORIENTATION_PORTRAIT then
        self.portraitUiPanel.panel1:hide()
        self.portraitUiPanel.panel2:hide()
        self.portraitUiPanel.panel3:hide()
        self.portraitUiPanel.panel4:show()
        return
    end
    --横屏
    if orientation == SCREEN_ORIENTATION_LANDSCAPE then
        self.landscapeUiPanel.panel1:hide()
        self.landscapeUiPanel.panel2:hide()
        self.landscapeUiPanel.panel3:hide()
        self.landscapeUiPanel.panel4:show()
        return
    end
end

function ARMainLayer:onSubBackBtnClicked( backBtn )
    if backBtn == self.landscapeUiPanel.panel2.backBtn then
        self.landscapeUiPanel.panel1:show()
        self.landscapeUiPanel.panel2:hide()
        self.landscapeUiPanel.panel3:hide()
        self.landscapeUiPanel.panel4:hide()
        return
    end
    if backBtn == self.portraitUiPanel.panel2.backBtn then
        self.portraitUiPanel.panel1:show()
        self.portraitUiPanel.panel2:hide()
        self.portraitUiPanel.panel3:hide()
        self.portraitUiPanel.panel4:hide()
        return
    end
    if backBtn == self.landscapeUiPanel.panel3.backBtn then
        self:hideClothesSubUI(SCREEN_ORIENTATION_LANDSCAPE)
        return
    end

    if backBtn == self.portraitUiPanel.panel3.backBtn then
        self:hideClothesSubUI(SCREEN_ORIENTATION_PORTRAIT)
        return
    end

    if backBtn == self.landscapeUiPanel.panel4.backBtn then
        self:hideSkinSubUI(SCREEN_ORIENTATION_LANDSCAPE)
        return
    end

    if backBtn == self.portraitUiPanel.panel4.backBtn then
        self:hideSkinSubUI(SCREEN_ORIENTATION_PORTRAIT)
        return
    end
end

function ARMainLayer:changeCamera( )
    -- body
    if self.cameraViewNode then
        if self.changeCameraStatus then
            self.changeCameraStatus = false
            self.cameraViewNode:changeCamera()
            self:timeOut(function()
                self.changeCameraStatus = true
            end,2)
        end
    end
end

function ARMainLayer:onEnterBackGround( )
    if HeitaoSdk then
        HeitaoSdk.closeAR()
    end
end

function ARMainLayer:onEnterForeGround( )
    if HeitaoSdk then
        HeitaoSdk.openAR()
    end
end

return ARMainLayer
