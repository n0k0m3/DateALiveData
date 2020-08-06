local DatingLetterViewNew = class("DatingLetterViewNew", BaseLayer)
local changePageTime = 0.5
function DatingLetterViewNew:initData()
    self.roleId = RoleDataMgr:getCurId()
    self.mainLiveList = RoleDataMgr:getNewMainList(self.roleId)
    self.curFavor = RoleDataMgr:getFavor(self.roleId)
    self.curFavorLevel = RoleDataMgr:getFavorLevel(self.roleId)
    self.mainPageIdx = 0
end

function DatingLetterViewNew:ctor()
    self.super.ctor(self)

    self:initData()

    self:init("lua.uiconfig.dating.datingLetterViewNew")
end

function DatingLetterViewNew:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")
    self.pageView = TFDirector:getChildByPath(self.ui, "PageView_datingLetter")
    self.pageView:setScrollEnabled(false)
    self.Image_favor = TFDirector:getChildByPath(self.ui, "Image_favor")
    local Label_favorValue = TFDirector:getChildByPath(self.Image_favor, "Label_favorValue")
    Label_favorValue:setText(self.curFavor)
    self.Image_favorTip = TFDirector:getChildByPath(self.Image_favor, "Image_favorTip")

    self.bgCgPanel = TFDirector:getChildByPath(self.ui, "panel_cgBg")
    self.btn_dating = TFDirector:getChildByPath(self.ui, "btn_dating")
    self.zhuangsi_yjs = TFDirector:getChildByPath(self.ui, "zhuangsi_yjs")
    self.zhuangsi_wjs = TFDirector:getChildByPath(self.ui, "zhuangsi_wjs")

    self.rewardPanel = TFDirector:getChildByPath(self.ui, "Panel_reward")

    


    self:initChapterList()  
    self:updateChapterList()  
    self:loadPageView()
    self:initMainItemList()
    self:selectMainPage(1)
    self:pageViewChanged()
end

function DatingLetterViewNew:loadingReward()
end

function DatingLetterViewNew:initChapterList( )
    self.containerPanel = TFDirector:getChildByPath(self.ui, "panel_container")
    self.datingLockImg = {}
    for i=1,5 do
        local img = TFDirector:getChildByPath(self.containerPanel, "img_datingLock_" ..i)
        img:hide()
        table.insert(self.datingLockImg, img)
    end
    self.datingMaskLockBtn = {}
    for i=1,5 do
        local img = TFDirector:getChildByPath(self.containerPanel, "btn_datingMaskLock_" ..i)
        img:hide()
        table.insert(self.datingMaskLockBtn, img)
    end
    self.lockImg = {}
    for i=1,5 do
        local img = TFDirector:getChildByPath(self.containerPanel, "img_lock_" ..i)
        img:hide()
        table.insert(self.lockImg, img)
    end
    self.datingBtn = {}
    for i=1,5 do
        local btn = TFDirector:getChildByPath(self.containerPanel, "btn_dating_" ..i)
        btn:hide()
        table.insert(self.datingBtn, btn)
    end
    self.noticeImg = {}
    for i=1,5 do
        local img = TFDirector:getChildByPath(self.containerPanel, "img_notice_" ..i)
        img:hide()
        table.insert(self.noticeImg, img)
    end
    self.datingPassBtn = {}
    for i=1,5 do
        local img = TFDirector:getChildByPath(self.containerPanel, "btn_datingPass_" ..i)
        img:hide()
        table.insert(self.datingPassBtn, img)
    end
    self.passImg = {}
    for i=1,5 do
        local img = TFDirector:getChildByPath(self.containerPanel, "img_pass_" ..i)
        img:hide()
        table.insert(self.passImg, img)
    end
    self.lvLabel = {}
    for i=1,5 do
        local label = TFDirector:getChildByPath(self.containerPanel, "label_lv_" ..i)
        label:hide()
        table.insert(self.lvLabel, label)
    end
    self.openSpine = {}
    for i=1,5 do
        local spine = TFDirector:getChildByPath(self.containerPanel, "spine_open_" ..i)
        spine:hide()
        table.insert(self.openSpine, spine)
    end
end

function DatingLetterViewNew:updateChapterList( )
    for i = 1,#self.mainLiveList do
        self.datingLockImg[i]:show()
        self.datingMaskLockBtn[i]:show()
        self.lockImg[i]:show()
        self.datingBtn[i]:show()
        self.noticeImg[i]:show()
        self.datingPassBtn[i]:show()
        self.passImg[i]:show()
        self.lvLabel[i]:show()
        self.openSpine[i]:show()
    end

    for i = 1,#self.mainLiveList do
        local status = self:getStatus(i)
        if status == EC_DatingLetterStatus.STATUS_LOCK then
            self:updateChapterToLockUI(i)
        end
        if status == EC_DatingLetterStatus.STAUS_ING then
            self:updateChapterToIngUI(i)
        end
        if status == EC_DatingLetterStatus.STAUS_GET then
            self:updateChapterToGetUI(i)
        end
    end
end

function DatingLetterViewNew:updateChapterToLockUI( i )
    self.datingLockImg[i]:show()
    self.datingMaskLockBtn[i]:show()
    self.lockImg[i]:show()
    self.datingBtn[i]:hide()
    self.noticeImg[i]:hide()
    self.datingPassBtn[i]:hide()
    self.passImg[i]:hide()
    self.lvLabel[i]:show()
    self.openSpine[i]:hide()

    local mainItemInfo = self.mainLiveList[i]
    local favorLevel = mainItemInfo.condition[1] and mainItemInfo.condition[1][2] or 0
    self.lvLabel[i]:setTextById(111000106, favorLevel)
end

function DatingLetterViewNew:updateChapterToIngUI( i )
    self.datingLockImg[i]:hide()
    self.datingMaskLockBtn[i]:hide()
    self.lockImg[i]:hide()
    self.datingBtn[i]:show()
    self.noticeImg[i]:hide()
    self.datingPassBtn[i]:hide()
    self.passImg[i]:hide()
    self.lvLabel[i]:show()
    self.openSpine[i]:show()

    local mainItemInfo = self.mainLiveList[i]
    local favorLevel = mainItemInfo.condition[1] and mainItemInfo.condition[1][2] or 0
    self.lvLabel[i]:setTextById(111000106, favorLevel)

    self.openSpine[i]:runAction(Sequence:create({DelayTime:create(0.3), CallFunc:create(function()
    	    self.openSpine[i]:playByIndex(1, -1, -1, 0)
	        self.openSpine[i]:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
                self.openSpine[i]:removeMEListener(TFARMATURE_COMPLETE)
                self.openSpine[i]:playByIndex(0, -1, -1, 1)
                self.noticeImg[i]:show()
            end)
    end)}))
end

function DatingLetterViewNew:updateChapterToGetUI( i )
    self.datingLockImg[i]:hide()
    self.datingMaskLockBtn[i]:hide()
    self.lockImg[i]:hide()
    self.datingBtn[i]:hide()
    self.noticeImg[i]:hide()
    self.datingPassBtn[i]:show()
    self.passImg[i]:show()
    self.lvLabel[i]:hide()
    self.openSpine[i]:hide()

    local mainItemInfo = self.mainLiveList[i]
    local favorLevel = mainItemInfo.condition[1] and mainItemInfo.condition[1][2] or 0
    self.lvLabel[i]:setText(111000106, favorLevel)
end

function DatingLetterViewNew:initMainItemList()
    for i = 1,1 do
        self:updateMainLiveItem(i)
    end
end

function DatingLetterViewNew:loadPageView()
    for i = 1, 1 do
        local PanelItem = TFDirector:getChildByPath(self.ui, "Panel_pageItem"):clone()
        self.pageView:insertPage(PanelItem, i)
        self.cg_parent = TFDirector:getChildByPath(PanelItem, "cg_parent")
    end
end

function DatingLetterViewNew:onGetRewardHandle(reward)
    self:showFavorRewardRedTip()
end
function DatingLetterViewNew:changeCg(parent,cgName,bgpath)
    if parent.cg then
        parent.cg:removeFromParent(true)
        parent.cg = nil

    end
   
    local layer = require("lua.logic.common.CgView"):new(cgName, bgpath, nil, nil,false)
    local parentSize = parent:Size()
    local scaleX = parentSize.width/layer:Size().width
    local scaleY = parentSize.height/layer:Size().height
    layer:setScale(math.max(scaleX,scaleY))
    parent:addChild(layer)
    parent.cg = layer
    layer:setName("cgLayer")    
end

function DatingLetterViewNew:updateMainLiveItem(pageIdx)
    local PanelItem = self.pageView:getPage(0)
    local mainItemInfo = self.mainLiveList[pageIdx]
    PanelItem:setPositionY(-88)
    local cg_cfg = TabDataMgr:getData("Cg")[mainItemInfo.cg]
    self:changeCg(self.cg_parent,cg_cfg.cg4,cg_cfg.backGround)

    local Label_mainName = TFDirector:getChildByPath(PanelItem, "Label_mainName")
    local Label_chapter = TFDirector:getChildByPath(PanelItem, "Label_chapter")
    local Image_huigu = TFDirector:getChildByPath(PanelItem, "Image_huigu"):hide()
    Label_chapter:setTextById(mainItemInfo.datingName)
    Label_mainName:setTextById(mainItemInfo.datingTitle)
    local Label_tiaojian1 = TFDirector:getChildByPath(PanelItem,"Label_tiaojian1")
    Label_tiaojian1:setVisible(false)
    local Label_tiaojian2 = TFDirector:getChildByPath(PanelItem,"Label_tiaojian2")
    Label_tiaojian2:setVisible(false)
    local cg_mask = TFDirector:getChildByPath(PanelItem, "cg_mask")
    local image_lockIcon = TFDirector:getChildByPath(PanelItem, "Image_lock")

    Image_huigu:hide()
    local status = self:getStatus(pageIdx)
    if status == EC_DatingLetterStatus.STAUS_GET then
        Image_huigu:show()
    end

   
    local isLock = self:checkIsUnLocked(pageIdx,Label_tiaojian1,Label_tiaojian2)
    if isLock then
        if not Label_tiaojian1:isVisible() or not Label_tiaojian2:isVisible() then
            if Label_tiaojian1:isVisible() then
                Label_tiaojian1:setPositionY(-192)
            end
        else
            Label_tiaojian1:setPositionY(-156)            
        end
    end
    image_lockIcon:setVisible(isLock)
    cg_mask:setVisible(not isLock)

    self.rewardPanel:removeAllChildren()    
    self.datingRewardView = self.datingRewardView or {}  
    --self.datingRewardView[pageIdx] = require("lua.logic.dating.DatingRewardInfoView"):new()
    --self.rewardPanel:addChild(self.datingRewardView[pageIdx],1000)
    --self:flushDatingRewardView(pageIdx)
end

function DatingLetterViewNew:flushAllDatingRewardView( )
    for i = 1,#self.mainLiveList do
        self:flushDatingRewardView(i)
    end
end

function DatingLetterViewNew:flushDatingRewardView( pageIndex )
    local mainItemInfo = self.mainLiveList[pageIndex]
    local taskId = mainItemInfo.taskId or 0
    local rewardData = TaskDataMgr:getTaskCfg(taskId) or {}
    local taskInfo = TaskDataMgr:getTaskInfo(taskId) or {}
    local progress = taskInfo.progress -- 已激活结局
    local totalEndOfNum = rewardData.progress -- 总需要激活解决
    if totalEndOfNum == 0 then totalEndOfNum = 1 end
    
    local params = {
        itemList = rewardData.reward or {},
        pro = progress*100/totalEndOfNum or 0,
        status = taskInfo.status,
        bili = progress.."/"..totalEndOfNum,
        taskId = taskId,
    }
    print("refreshRewardView params ",params)
    self.datingRewardView[pageIndex]:refresh(params)
end

function DatingLetterViewNew:getStatus( pageIdx )
    local mainItemInfo = self.mainLiveList[pageIdx]
    --通关
    if DatingDataMgr:checkScriptIdIsFinish(mainItemInfo.datingRuleId) then
        return EC_DatingLetterStatus.STAUS_GET
    end
    -- 未解锁
    local favorLevel = mainItemInfo.condition[1] and mainItemInfo.condition[1][2] or 0
    if DatingDataMgr:checkScriptIdIsFinish(mainItemInfo.prepose) or self.curFavorLevel < favorLevel then
        return EC_DatingLetterStatus.STATUS_LOCK
    end
    return EC_DatingLetterStatus.STAUS_ING
end

function DatingLetterViewNew:checkIsUnLocked( pageIdx ,Label_tiaojian1, Label_tiaojian2, Image_huigu)
    local mainItemInfo = self.mainLiveList[pageIdx]
    local prepose = mainItemInfo.prepose
    local isPrePass = RoleDataMgr:getMainFirstPass(self.roleId,prepose) -- 前置主线约会是否通过
    print("updateMainLiveItem prepose ",prepose)
    print("updateMainLiveItem isPrePass ",isPrePass)
    local favorLevel = mainItemInfo.condition[1] and mainItemInfo.condition[1][2] or 0
    local fubenId = mainItemInfo.condition[2] and  mainItemInfo.condition[2][2] or 0
    local isFubenPass  = true
    if fubenId ~= 0 then
        isFubenPass = self:checkFubenPass(fubenId)
    end
    local state = RoleDataMgr:getMainState(self.roleId,mainItemInfo.id)
    local isFirstPass = RoleDataMgr:getMainFirstPass(self.roleId,mainItemInfo.id)

    local isLock = false
    if isFubenPass and self.curFavorLevel >= favorLevel then
        if state == EC_TaskStatus.ING then
           isLock = true
        elseif state == EC_TaskStatus.GET then
            isLock = false
        end
    else
        isLock = true
    end
    return isLock
end

function DatingLetterViewNew:checkFubenPass(id)
    return FubenDataMgr:isPassPlotLevel(id)
end

function DatingLetterViewNew:selectMainPage(pageIdx)
    if self.mainPageIdx ~= pageIdx then
        self:changePage(pageIdx)
    end
end

function DatingLetterViewNew:backBtnClickHandle()
    AlertManager:close()
end

function DatingLetterViewNew:onShowMainInfo(mainInfo)
    --self:flushAllDatingRewardView() 
    if not self.curMainInfo then
        return
    end
    local layer = require("lua.logic.dating.DatingMainInfoView"):new(mainInfo,self.curMainInfo)
    AlertManager:addLayer(layer, AlertManager.BLOCK_AND_GRAY_CLOSE)
    AlertManager:show()
end

function DatingLetterViewNew:pageViewChanged()
    local curIdx = self.mainPageIdx
    local mainItemInfo = self.mainLiveList[self.mainPageIdx]
    local Image_cost = TFDirector:getChildByPath(self.ui, "Image_cost")
    local energy = RoleDataMgr:getMainEnergy(self.roleId,mainItemInfo.id)
    local Label_costNum = TFDirector:getChildByPath(self.ui, "Label_costNum")
    local itemCost = Utils:getKVP(110003)
    for k,v in pairs(itemCost) do       
        Label_costNum:setText(v)
    end

    self.btn_dating:onClick(function()
        self.curMainInfo = mainItemInfo         
        local itemCost = Utils:getKVP(110003)
        
        for k,v in pairs(itemCost) do    
            local itemId = k   
            local itemNum = v
            if not GoodsDataMgr:currencyIsEnough(itemId, itemNum) then               
                Utils:showAccess(itemId)
                return
            end
        end       
        DatingDataMgr:sendGetSciptMsg(EC_DatingScriptType.FAVOR_SCRIPT, mainItemInfo.role, nil, self.curMainInfo.datingRuleId)
        --NewCityDataMgr:sendGetCitySetpData(EC_NewCityType.NewCity_MainLine,self.curMainInfo.id,self.roleId)
    end)

    local cg_cfg = TabDataMgr:getData("Cg")[mainItemInfo.cg]

    local image = self.Image_bg:clone()
    self.Image_bg:getParent():addChild(image)
    local isLock = self:checkIsUnLocked(self.mainPageIdx)
    if isLock then
        self.Image_bg:setTexture("scene/bg/bg_new.png")
        --self.Image_bg:setShaderProgramDefault(true)
    else
        if not cg_cfg.backGround or cg_cfg.backGround == "" then
            self.Image_bg:setTexture("scene/bg/bg_new.png")
        else
            self.Image_bg:setTexture(cg_cfg.backGround)
        end
        -- self.Image_bg:setShaderProgram("Blur", true)
        -- local gLProgramState = self.Image_bg:getGLProgramState()
        -- gLProgramState:setUniformFloat("texelWidthOffset", 0.001)
        -- gLProgramState:setUniformFloat("texelHeightOffset", 0.001)
    end 
    local fade  = FadeOut:create(changePageTime)
    local callback = CallFunc:create(function()
        image:removeFromParent()
    end)
    local seq = Sequence:createWithTwoActions(fade, callback)
    image:runAction(seq)
    self.Image_bg:setOpacity(0)
    self.Image_bg:runAction(FadeIn:create(changePageTime))
    self.btn_dating:setTouchEnabled(not isLock)
    self.zhuangsi_yjs:setVisible(isLock)
    self.zhuangsi_yjs:setVisible(not isLock)
    self:showFavorRewardRedTip()
end

function DatingLetterViewNew:showFavorRewardRedTip(  )
    self.Image_favorTip:setVisible(false)
    local getedRewardList = RoleDataMgr:getFavorRewardListByRoleId(self.roleId)
    local rewardIdList = {}
    for _,_id in ipairs(getedRewardList) do      
        rewardIdList[_id] = _id
    end 

    local rewardList = RoleDataMgr:getNewDatingRewardListToFavorLevel(self.roleId,self.mainPageIdx)
    local curFavor = RoleDataMgr:getFavor(self.roleId)
    for k,v in pairs(rewardList) do    
        if curFavor >= v.branchCondition and rewardIdList[v.id] == nil then   
            self.Image_favorTip:setVisible(true)
            break
        end
    end
end

function DatingLetterViewNew:onShow()
    self.super.onShow(self)
    if not TFAudio.isMusicPlaying() then
        if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine then
            SafeAudioExchangePlay().playBGM(self, true, "sound/bgm/date_001.mp3")
        else
            SafeAudioExchangePlay().playBGM(self, true)
        end
    end
end

function DatingLetterViewNew:registerEvents()
    self.super.registerEvents(self)

    EventMgr:addEventListener(self,EV_NEWCITY_DATING_EVENT.recvDatingLineStepInfo, handler(self.onShowMainInfo, self))
    --EventMgr:addEventListener(self,EV_TASK_UPDATE, handler(self.flushAllDatingRewardView, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.getMainReward, handler(self.onGetRewardHandle, self))
    EventMgr:addEventListener(self,EV_GETFAVORDATING_REWARD, handler(self.onGetRewardHandle, self))

    self.pageView:addMEListener(TFPAGEVIEW_CHANGED, function ()
        --self:pageViewChanged();
    end)

    local function pageUp()
        local pageIndex = self.mainPageIdx + 1
        if pageIndex > #self.mainLiveList then
            pageIndex = #self.mainLiveList
        end
        self:selectMainPage(pageIndex)
    end

    local function pageDown()
        local pageIndex = self.mainPageIdx - 1
        if pageIndex < 1 then
            pageIndex = 1
        end
        self:selectMainPage(pageIndex)
    end

    self.Image_favor:onClick(function ()
        local levelView = requireNew("lua.logic.dating.DatingFavorRewardViewNew"):new(self.roleId, self.mainPageIdx)
        AlertManager:addLayer(levelView)
        AlertManager:show()
    end)

    for _idx,_datingBtn in ipairs(self.datingBtn) do  
        _datingBtn:onClick(function()
            self:selectMainPage(_idx)            
        end)
    end    

    for _idx,_datingMaskLockBtn in ipairs(self.datingMaskLockBtn) do  
        _datingMaskLockBtn:onClick(function()
            self:selectMainPage(_idx)            
        end)
    end   

    for _idx,_datingPassMaskkBtn in ipairs(self.datingPassBtn) do  
        _datingPassMaskkBtn:onClick(function()
            self:selectMainPage(_idx)            
        end)
    end   
end

function DatingLetterViewNew:changePage(toIdx)
    if self.mainPageIdx == 0 then
        self.mainPageIdx = 1
    end

    if self.bgCgPanel.cg then
        self.bgCgPanel.cg:removeFromParent()
    end
    local mainItemInfo = self.mainLiveList[toIdx]
    local cg_cfg = TabDataMgr:getData("Cg")[mainItemInfo.cg]
    local bgCgLayer = require("lua.logic.common.CgView"):new(cg_cfg.cg4, cg_cfg.backGround, nil, nil,false)
    bgCgLayer:setName("cgLayer")
    -- bgCgLayer:setShaderProgram("DalBlur", true)
    -- local gLProgramState = bgCgLayer:getGLProgramState();
    -- gLProgramState:setUniformFloat("sampleNum", 2);
    -- gLProgramState:setUniformFloat("blurRadius", 0.006)
   
    local scaleX = GameConfig.WS.width/bgCgLayer:Size().width
    local scaleY = GameConfig.WS.height/bgCgLayer:Size().height
    bgCgLayer:setScale(math.max(scaleX,scaleY))
    --bgCgLayer:setPosition(ccp(0, 0))
    self.bgCgPanel:addChild(bgCgLayer)
    self.bgCgPanel.cg = bgCgLayer

    if self.mainPageIdx == toIdx then 
        return 
    end
    
    self.mainPageIdx = toIdx
    self:updateMainLiveItem(self.mainPageIdx)
    self:pageViewChanged()
end

return DatingLetterViewNew