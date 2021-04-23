local DatingLetterView = class("DatingLetterView", BaseLayer)
local changePageTime = 0.5
function DatingLetterView:initData()
    self.roleId = RoleDataMgr:getCurId()
    self.mainLiveList = RoleDataMgr:getMainList(self.roleId)
    self.curFavor = RoleDataMgr:getFavor(self.roleId)
    self.curFavorLevel = RoleDataMgr:getFavorLevel(self.roleId)
    self.rewardItemList = {}
    self.mainDatingData = nil
    self.mainPageIdx = 0
    self.mainPageOptionList = {}
    self.indexOfScrollT = {
    }

    for i = 1, #self.mainLiveList do
        self.indexOfScrollT[i-1] = i
    end
end

function DatingLetterView:ctor()
    self.super.ctor(self)

    self:initData()

    self:init("lua.uiconfig.dating.datingLetterView")
end

function DatingLetterView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")
    self.pageView = TFDirector:getChildByPath(self.ui, "PageView_datingLetter")
    self.pageView:setScrollEnabled(false)
    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_touch")
    self.Image_favor = TFDirector:getChildByPath(self.ui, "Image_favor")
    local Label_favorValue = TFDirector:getChildByPath(self.Image_favor, "Label_favorValue")
    Label_favorValue:setText(self.curFavor)
    self.Image_favorTip = TFDirector:getChildByPath(self.Image_favor, "Image_favorTip")

    self.page_down = TFDirector:getChildByPath(self.ui, "page_down")
    self.page_up = TFDirector:getChildByPath(self.ui, "page_up")
    self.btn_dating = TFDirector:getChildByPath(self.ui, "btn_dating")
    self.zhuangsi_yjs = TFDirector:getChildByPath(self.ui, "zhuangsi_yjs")
    self.zhuangsi_wjs = TFDirector:getChildByPath(self.ui, "zhuangsi_wjs")

    self:initOptionList()
    self:loadPageView()
    self:initMainItemList()
    self:selectMainPage(1)
    self:pageViewChanged()
end

function DatingLetterView:loadingReward()
end

function DatingLetterView:initMainItemList()
    for i = 1,#self.mainLiveList do
        self:updateMainLiveItem(i)
    end
end

function DatingLetterView:loadPageView()
    for i = 1, #self.mainLiveList do
        local PanelItem = TFDirector:getChildByPath(self.ui, "Panel_pageItem"):clone()
        self.pageView:insertPage(PanelItem, i)
    end
end

function DatingLetterView:onGetRewardHandle(reward)
    local newRewardList = {}
    for i, v in ipairs(reward) do
        local newReward = Utils:makeRewardItem(v[1], v[2])
        table.insert(newRewardList, newReward)
    end
    print("newRewardList ",newRewardList)
    Utils:showReward(newRewardList)
    self:showFavorRewardRedTip(  )
end
function DatingLetterView:changeCg(parent,cgName,bgpath)
    if parent.cg then
        local node = parent.cg
        -- parent.cg = nil
        -- local fade     = FadeOut:create(0.5)
        -- local callback = CallFunc:create(function()
            node:removeFromParent()
        -- end)
        -- node:setZOrder(2)
        -- local seq = Sequence:createWithTwoActions(fade, callback)
        -- node:runAction(seq)
    end
    local layer = require("lua.logic.common.CgView"):new(cgName, bgpath, nil, nil,false,function ()
            -- if parent.cg then
            --     local node = parent.cg
            --     parent.cg = nil
            --     local fade     = FadeOut:create(0.5)
            --     local callback = CallFunc:create(function()
            --         node:removeFromParent()
            --     end)
            --     node:setZOrder(2)
            --     local seq = Sequence:createWithTwoActions(fade, callback)
            --     node:runAction(seq)
            -- end
            -- self:changeCg(parent,cgName,bgpath)
        end)

    local parentSize = parent:Size()
    local scaleX = parentSize.width/layer:Size().width
    local scaleY = parentSize.height/layer:Size().height
    layer:setScale(math.max(scaleX,scaleY))
    -- local offsetX = (GameConfig.WS.width - 1136)/2
    -- layer:setPosition(ccp(offsetX*layer:getScaleX(), 0))
    parent:addChild(layer)
    parent.cg = layer
    layer:setName("cgLayer")
end

function DatingLetterView:updateMainLiveItem(pageIdx)
    --local PanelItem = TFDirector:getChildByPath(self.ui, "Panel_" .. pageIdx)
    local PanelItem = self.pageView:getPage(pageIdx-1)
    local mainItemInfo = self.mainLiveList[pageIdx]
    PanelItem:setPositionY(-88)
    local cg_parent = TFDirector:getChildByPath(PanelItem, "cg_parent")
    local cg_cfg = TabDataMgr:getData("Cg")[mainItemInfo.cg]
    self:changeCg(cg_parent,cg_cfg.cg3,cg_cfg.backGround)

    local Label_mainName = TFDirector:getChildByPath(PanelItem, "Label_mainName")
    local Label_chapter = TFDirector:getChildByPath(PanelItem, "Label_chapter")
    local Image_huigu = TFDirector:getChildByPath(PanelItem, "Image_huigu"):hide()
    Label_chapter:setTextById(mainItemInfo.datingName)
    Label_mainName:setTextById(mainItemInfo.datingTitle)
    local Label_lock = TFDirector:getChildByPath(PanelItem,"Label_lock")
    local Label_tiaojian1 = TFDirector:getChildByPath(PanelItem,"Label_tiaojian1")
    Label_tiaojian1:setVisible(false)
    local Label_tiaojian2 = TFDirector:getChildByPath(PanelItem,"Label_tiaojian2")
    Label_tiaojian2:setVisible(false)
    local cg_mask = TFDirector:getChildByPath(PanelItem, "cg_mask")
    local image_lockIcon = TFDirector:getChildByPath(PanelItem, "Image_lock")

    print("mainItemInfo ",mainItemInfo.id)
    print("roleId ",self.roleId)
    local isLock = self:checkIsUnLocked(pageIdx,Label_tiaojian1,Label_tiaojian2)
    if isLock then
        if not Label_tiaojian1:isVisible() or not Label_tiaojian2:isVisible() then
            Label_lock:setPositionY(-156)
            if Label_tiaojian1:isVisible() then
                Label_tiaojian1:setPositionY(-192)
            end
        else
            Label_tiaojian1:setPositionY(-156)
            Label_lock:setPositionY(-118)
        end
    end
    image_lockIcon:setVisible(isLock)
    cg_mask:setVisible(not isLock)

    local panel_reward = TFDirector:getChildByPath(PanelItem, "Panel_reward")
    self.datingRewardView = self.datingRewardView or {}
    if not self.datingRewardView[pageIdx] then
        self.datingRewardView[pageIdx] = require("lua.logic.dating.DatingRewardInfoView"):new()
        panel_reward:addChild(self.datingRewardView[pageIdx],1000)
    end

    self:flushDatingRewardView(pageIdx)
end

function DatingLetterView:flushAllDatingRewardView( )
    for i = 1,#self.mainLiveList do
        self:flushDatingRewardView(i)
    end
end

function DatingLetterView:flushDatingRewardView( pageIndex )
    local mainItemInfo = self.mainLiveList[pageIndex]
    local taskId = mainItemInfo.taskId or 0
    local rewardData = TaskDataMgr:getTaskCfg(taskId) or {}
    local taskInfo = TaskDataMgr:getTaskInfo(taskId) or {}
    local progress = taskInfo.progress or 0 -- 已激活结局
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

function DatingLetterView:checkIsUnLocked( pageIdx ,Label_tiaojian1, Label_tiaojian2, Image_huigu)
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
            if not isPrePass then
                local preMainItemInfo = self.mainLiveList[pageIdx-1]
                if preMainItemInfo then
                    local preName = TextDataMgr:getTextAttr(preMainItemInfo.datingName).text
                    if Label_tiaojian1 then
                        Label_tiaojian1:setVisible(true)
                        Label_tiaojian1:setTextById(950056,preName)
                    end
                end
            end
           isLock = true
        elseif state == EC_TaskStatus.GET then
            if Image_huigu then
                Image_huigu:setVisible(isFirstPass)
            end
            isLock = false
        end
    else
        if not isFubenPass then
            if Label_tiaojian1 then
                Label_tiaojian1:setVisible(true)
                Label_tiaojian1:setTextById(304007, FubenDataMgr:getLevelName(fubenId))
            end
        end
        if self.curFavorLevel < favorLevel then
            if Label_tiaojian2 then
                Label_tiaojian2:setVisible(true)
                Label_tiaojian2:setTextById(304003,favorLevel)
            end
        end
        isLock = true
    end
    return isLock
end

function DatingLetterView:checkFubenPass(id)
    return FubenDataMgr:isPassPlotLevel(id)
end

function DatingLetterView:initOptionList()
    self.Panel_optionList = TFDirector:getChildByPath(self.ui, "Panel_optionList")

    local Image_option = TFDirector:getChildByPath(self.ui, "Image_option")
    local disX = 30
    local startX = - (disX * (#self.mainLiveList-1))/2
    for i = 1, #self.mainLiveList do
        local option = Image_option:clone()
        option.select = TFDirector:getChildByPath(option, "Image_select")
        table.insert(self.mainPageOptionList, option)
        option:Pos(startX + (i-1)*disX,0)
        self.Panel_optionList:addChild(option)
    end
end

function DatingLetterView:selectMainPage(pageIdx)
    if self.mainPageIdx ~= pageIdx then
        -- self.mainPageIdx = pageIdx
        --self:refreshMainView()

        for i, v in ipairs(self.mainPageOptionList) do
            if pageIdx == i then
                v.select:show()
            else
                v.select:hide()
            end
        end

        -- self.pageView:scrollToPage(pageIdx-1,0.5);
        self:changePage(pageIdx)
    end
end

function DatingLetterView:backBtnClickHandle()
    AlertManager:close()
end

function DatingLetterView:onShowMainInfo(mainInfo)
    self:flushAllDatingRewardView() 
    if not self.curMainInfo then
        return
    end
    local layer = require("lua.logic.dating.DatingMainInfoView"):new(mainInfo,self.curMainInfo)
    AlertManager:addLayer(layer, AlertManager.BLOCK_AND_GRAY_CLOSE)
    AlertManager:show()
end

function DatingLetterView:pageViewChanged()
    -- local index = self.pageView:getCurPageIndex()
    -- local curIdx = self.indexOfScrollT[index]
    -- self.mainPageIdx = curIdx
    local curIdx = self.mainPageIdx
    self.page_down:setVisible(curIdx > 1)
    self.page_up:setVisible(curIdx < #self.mainLiveList)
    for i, v in ipairs(self.mainPageOptionList) do
        if curIdx == i then
            v.select:show()
        else
            v.select:hide()
        end
    end
    local mainItemInfo = self.mainLiveList[self.mainPageIdx]
    local Image_cost = TFDirector:getChildByPath(self.ui, "Image_cost")
    local energy = RoleDataMgr:getMainEnergy(self.roleId,mainItemInfo.id)
    local Label_costNum = TFDirector:getChildByPath(self.ui, "Label_costNum")
    Label_costNum:setText(energy)
    self.btn_dating:onClick(function()
        self.curMainInfo = mainItemInfo
        NewCityDataMgr:sendGetCitySetpData(EC_NewCityType.NewCity_MainLine,self.curMainInfo.id,self.roleId)
    end)

    local cg_cfg = TabDataMgr:getData("Cg")[mainItemInfo.cg]

    local image = self.Image_bg:clone()
    self.Image_bg:getParent():addChild(image)
    local isLock = self:checkIsUnLocked(self.mainPageIdx)
    if isLock then
        self.Image_bg:setTexture("scene/bg/bg_new.png")
        self.Image_bg:setShaderProgramDefault(true)
    else
        if not cg_cfg.backGround or cg_cfg.backGround == "" then
            self.Image_bg:setTexture("scene/bg/bg_new.png")
        else
            self.Image_bg:setTexture(cg_cfg.backGround)
        end
        self.Image_bg:setShaderProgram("Blur", true)
        local gLProgramState = self.Image_bg:getGLProgramState()
        gLProgramState:setUniformFloat("texelWidthOffset", 0.001)
        gLProgramState:setUniformFloat("texelHeightOffset", 0.001)
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
    self:showFavorRewardRedTip(  )
end

function DatingLetterView:showFavorRewardRedTip(  )
    self.Image_favorTip:setVisible(false)
    local rewardList = RoleDataMgr:getDatingRewardListToFavorLevel(self.roleId,self.mainPageIdx)
    local curFavor = RoleDataMgr:getFavor(self.roleId)
    for k,v in pairs(rewardList) do
        if RoleDataMgr:getDatingRewardState(self.roleId,v.id) ~= EC_TaskStatus.GETED and curFavor >= v.branchCondition then
            self.Image_favorTip:setVisible(true)
            break
        end
    end
end

function DatingLetterView:onShow()
    self.super.onShow(self)
    --self.super.onShow(self)
    if not TFAudio.isMusicPlaying() then
        if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine then
            SafeAudioExchangePlay().playBGM(self, true, "sound/bgm/date_001.mp3")
        else
            SafeAudioExchangePlay().playBGM(self, true)
        end
    end
end

function DatingLetterView:registerEvents()
    self.super.registerEvents(self)

    EventMgr:addEventListener(self,EV_NEWCITY_DATING_EVENT.recvDatingLineStepInfo, handler(self.onShowMainInfo, self))
    EventMgr:addEventListener(self,EV_TASK_UPDATE, handler(self.flushAllDatingRewardView, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.getMainReward, handler(self.onGetRewardHandle, self))

    for i, v in ipairs(self.mainPageOptionList) do
        v:Touchable(true)
        v:onClick(function()
            self:selectMainPage(i)
        end)
    end

    self.pageView:addMEListener(TFPAGEVIEW_CHANGED, function ()
        self:pageViewChanged();
    end)

    local function onTouchBegan(touch, location)
        touch.startPos = location
        return true;
    end

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
            self.page_down:setVisible(false)
        end
        self:selectMainPage(pageIndex)
    end

    local function onTouchMoved(touch, location)
        local offset = location.x - touch.startPos.x
        if math.abs(offset) > 10 then
            touch.isMoved = true
        end
    end

    local function onTouchUp(touch, location)
        local offset = location.x - touch.startPos.x
        if touch.isMoved and math.abs(offset) > 30 then
            if offset < 0 then
                pageUp()
            else
                pageDown()
            end
        end
    end

    self.Panel_touch:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan);
    self.Panel_touch:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved);
    self.Panel_touch:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp);
    self.Panel_touch:setSwallowTouch(false)

    self.page_up:onClick(pageUp)

    self.page_down:onClick(pageDown)

    self.Image_favor:onClick(function ()
        local levelView = requireNew("lua.logic.dating.DatingFavorRewardView"):new(self.roleId, self.mainPageIdx)
        AlertManager:addLayer(levelView)
        AlertManager:show()
    end)
end

function DatingLetterView:changePage(toIdx)
    if self.mainPageIdx == 0 then
        self.mainPageIdx = 1
    end
    if self.mainPageIdx == toIdx then 
        return 
    end
    local pageNode_f = self.pageView:getPage(self.mainPageIdx - 1)
    local pageNode_t = self.pageView:getPage(toIdx - 1)
    local direct = 1
    if toIdx > self.mainPageIdx then
        direct = -1
    end

    local offsetPosX = 30

    pageNode_f:setPositionX(0)
    pageNode_t:setPositionX(offsetPosX*direct*-1)
    pageNode_t:setVisible(true)
    pageNode_f:stopAllActions()
    pageNode_t:stopAllActions()
    local move     = MoveTo:create(changePageTime,ccp(offsetPosX*direct,pageNode_f:getPositionY()))
    local fade     = FadeOut:create(changePageTime)
    local callback = CallFunc:create(function()
        pageNode_f:setVisible(false)
    end)
    local seq = Sequence:createWithTwoActions(Spawn:createWithTwoActions(move,fade), callback)
    pageNode_f:runAction(seq)
    pageNode_t:setOpacity(0)
    pageNode_t:setZOrder(2)
    local arry = {}
    local move1     = MoveTo:create(changePageTime,ccp(0,pageNode_f:getPositionY()))
    local fade1     = FadeIn:create(changePageTime)
    local callback1 = CallFunc:create(function()
        pageNode_t:setZOrder(1)
    end)
    table.insert(arry,Spawn:createWithTwoActions(move1,fade1))
    table.insert(arry,callback1)
    local seq1 = Sequence:create(arry)
    pageNode_t:runAction(seq1)
    self.mainPageIdx = toIdx
    self:updateMainLiveItem(self.mainPageIdx)
    self:pageViewChanged()

end

return DatingLetterView