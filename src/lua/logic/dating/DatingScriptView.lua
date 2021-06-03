local DatingScriptView = class("DatingScriptView", BaseLayer)

require("lua.logic.dating.DatingPublic")
local isTest = false

local DatingConfig = require("lua.logic.dating.DatingConfig")
local DatingScriptConfig = require("lua.logic.dating.DatingScriptConfig")
local isScriptTest = false

local CTL_ZOrder = {
    bgZOrder = 1,
    changeBgFadeZOrder = 2,
    --sceneEffectZOrder_belong1or3 = 3, --加载在背景内部暂时不处理
    normalModelZOrder = 4,
    damuZorder = 4.5,
    cgZOrder = 5,
    cgInterZOrder = 6,
    sceneEffectZOrder_belong2 = 7,
    insertPicZOrder = 8,
    specialModelBottomZOrder = 9,
    otherZOrder = 10,
    imageTextBgZOrder = 11,
    specialModelZOrder = 12,
    optionZOrder = 13,
    phoneSpineZOrder = 14,
    topLayerZOrder = 15,
    videoZOrder = 16,
    changeBgOtherZOrder = 17,
    maxZOrder = 100,   --特殊时机使用
}

function DatingScriptView:initExtendData( param )
    if isScriptTest then
        self.optionActType = 0
    else
        self.optionActType = param.optionActType or 0 -- 选择完成后操作类型(1.城建数据，2.服务器验证。其他无操作)
    end
    self.showScore = param.showScore -- 好感度显示控制s
    self.showCompleteAni = param.showCompleteAni  -- 无奖励是是否显示complete动画
    self.finallyType = param.finallyType or 0 -- 结算界面类型
    self.resultActionType = param.resultActionType or 2 -- 结束后进行动作类型（ 1,城建数据刷新2, 限时约会，触发约会解决根据状态处理 3, 直接通知完成，并关闭界面4,发送数据验证 ,5  不做处理
    self.immediateClose = param.immediateClose or 1 -- 中途关闭是否提示
    self.show_obsolete = param.show_obsolete  -- 是否是预定约会
    self.saveNotFinishDatingInfo = param.saveNotFinishDatingInfo  -- 未完成退出是否记录数据
    self.noSkipBtn = param.noSkipBtn  -- 始终不显示跳过按钮
    self.showNoAwardResult = param.showNoAwardResult -- 无奖励显示结算面板
    self.alwaySkipBtn = param.alwaySkipBtn -- 无奖励显示结算面板
    self.callSynopsis = param.callSynopsis or 0 -- 无奖励显示结算面板
    self.noExitBtn = param.noExitBtn -- 无奖励显示结算面板
    self.alwayNoExitBtn = param.alwayNoExitBtn -- 始终不显示退出按钮

    self.settingBtnOffset = param.settingBtnOffset -- 设置按偏移
    self.logBtnOffset = param.logBtnOffset -- 日志按钮偏移
    self.waitSendRsp = param.waitSendRsp -- 等待验证返回
    self.isStopBgm = true
    if param.isStopBgm ~= nil then
        self.isStopBgm = param.isStopBgm
    end
end


function DatingScriptView:resetCTLZOrder(isUpZOrder)
    local disZOrder = 0
    if isUpZOrder then
        disZOrder = CTL_ZOrder.maxZOrder
    end
    if self.imageBg then
        self.imageBg:setZOrder(disZOrder + CTL_ZOrder.bgZOrder)
    end
    if self.changeBgView then
        if tonumber(self.itemData.appear) == 1 or tonumber(self.itemData.appear) == 12 then
            self.changeBgView:setZOrder(disZOrder + CTL_ZOrder.changeBgFadeZOrder)
        else
            self.changeBgView:setZOrder(disZOrder + CTL_ZOrder.changeBgOtherZOrder)
        end
    end

    if self.Panel_normalNpc then
        self.Panel_normalNpc:setZOrder(disZOrder + CTL_ZOrder.normalModelZOrder)
    end
    if self.Panel_specNpc then
        self.Panel_specNpc:setZOrder(disZOrder + CTL_ZOrder.specialModelZOrder)
    end
    for k, v in pairs(self.npcData_) do
        v:setZOrder(v.locationId)
    end

    if self.cgView then
        self.cgView:setZOrder(disZOrder + CTL_ZOrder.cgZOrder)
    end

    if self.interCgView then
        self.interCgView:setZOrder(disZOrder + CTL_ZOrder.cgInterZOrder)
    end

    for k, v in pairs(self.sceneEffect_) do
        if v.layerBelongTo == 2 then
            v:setZOrder(disZOrder + CTL_ZOrder.sceneEffectZOrder_belong2)
        end
    end

    if self.Panel_insertImage then
        self.Panel_insertImage:setZOrder(disZOrder + CTL_ZOrder.insertPicZOrder)
    end

    if self.Image_diceng then
        self.Image_diceng:setZOrder(disZOrder + CTL_ZOrder.specialModelBottomZOrder)
    end

    if self.imageTextBg then
        self.imageTextBg:setZOrder(disZOrder + CTL_ZOrder.imageTextBgZOrder)
    end

    if self.setButton then
        self.setButton:setZOrder(disZOrder + CTL_ZOrder.otherZOrder)
    end

    if self.reviewButton then
        self.reviewButton:setZOrder(disZOrder + CTL_ZOrder.otherZOrder)
    end

    if self.Image_loadingBar then
        self.Image_loadingBar:setZOrder(disZOrder + CTL_ZOrder.otherZOrder)
    end

    if self.Panel_optionView then
        self.Panel_optionView:setZOrder(disZOrder + CTL_ZOrder.optionZOrder)
    end

    if self.Panel_danmuView then
        self.Panel_danmuView:setZOrder(disZOrder + CTL_ZOrder.damuZorder)
    end

    if self.phoneSK then
        self.phoneSK:setZOrder(disZOrder + CTL_ZOrder.phoneSpineZOrder)
    end

    if self.Panel_pro then
        self.Panel_pro:setZOrder(disZOrder + CTL_ZOrder.topLayerZOrder)
    end

    if self.videoView then
        self.videoView:setZOrder(disZOrder + CTL_ZOrder.videoZOrder)
    end
end

local AUTO_SPEED_VAL = {
    1,
    3,
    5,
}

function DatingScriptView:ctor(isFubenShowBackBtn,isNoF)
    self.super.ctor(self)

    self.sceneEffect_ = {}
    self.isNoF = isNoF
    self.gIsStart = false
    self.score = DatingDataMgr:getDeScore()
    self.isGameStart = false
    self.cgView = nil
    self.isJumpOk = true
    self.isSkip = false
    self.isAuto = false
    self.isToEnd = false
    self.reviewTable = {}
    self.buttonList = {}
    self.selectBtn = nil
    self.scoreDisY = 0
    self.btnType = {
        skip = "skip",
        auto = "auto",
        review = "review",
        hide = "hide",
        set = "set"
    }

    self.isAuttoJump = false
    self.isTouchJump = true
    self.isHaveNpcVoice = false
    self.autoSpeed = 0

    self.isDatingDanMu = true

    self:initScriptData()

    self.bgm = nil
    if self.isStopBgm then
        TFAudio.stopMusic()
        TFAudio.stopAllEffects()
    end
    self.voiceHandle = nil
    self.sceneSoundEffectHandle = nil
    self.soundEffectHandle = nil
    self.isWaitInterCg = false

    self.isFubenShowBackBtn = isFubenShowBackBtn
    self:init("lua.uiconfig.dating.datingScriptView")
end

function DatingScriptView:initScriptData()
    self.curScript = clone(DatingDataMgr:getCurDatingScript())
    self.id = self.curScript.id
    self.optionList = self.curScript.optionList
    self.datingType = self.curScript.datingType or EC_DatingScriptType.SHOW_SCRIPT
    self.datingState = self.curScript.state
    self.isDatingFirst = self.curScript.isFirst

    self.roleId = DatingDataMgr:getDatingRuleRoleId(self.curScript.datingRuleCid) or RoleDataMgr:getCurId()
    RoleDataMgr:setCurId(self.roleId)
    self.useRoleInfo = clone(RoleDataMgr:getRoleInfo(self.roleId))

    self.scriptTableName = DatingDataMgr:getDatingRuleCallTableName(self.curScript.datingRuleCid)

    if not self.scriptTableName then
        self.scriptTableName = DatingScriptConfig.datingTypeToTableName[self.datingType]
    end

    self.currentNodeId = self.id
    local ruleData = DatingDataMgr:getDatingRuleData(self.curScript.datingRuleCid)
    local styleId = self.datingType*10 
    if ruleData and ruleData.datingTypeNew then
        styleId = ruleData.datingTypeNew
    end
    local extentData = TabDataMgr:getData("DatingTypeMgr")[styleId] or TabDataMgr:getData("DatingTypeMgr")[1000]
    self:initExtendData(extentData)

    if self.noSkipBtn then
        self.isDatingFirst = true
    end

    if self.alwaySkipBtn then
        self.isDatingFirst = false
    end

    if isScriptTest then
        self.isDatingFirst = false
    end
    print("initScriptData self.scriptTableName ", self.scriptTableName)
    print("initScriptData self.currentNodeId ", self.currentNodeId)
end

function DatingScriptView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    if isScriptTest then
        --self:loadingDatingEditView()
    end

    self.Panel_base = TFDirector:getChildByPath(self.ui, "Panel_base")
    self.Panel_main = TFDirector:getChildByPath(self.Panel_base, "Panel_main")

    self.Image_datingPhone = TFDirector:getChildByPath(self.Panel_main, "Image_datingPhone")
    self.Button_datingPhone = TFDirector:getChildByPath(self.Image_datingPhone,"Button_datingPhone")
    self.Spine_Datingphone = TFDirector:getChildByPath(self.Button_datingPhone,"Spine_Datingphone")
    self.Image_datingPhone:setVisible(false)
    self.Image_loadingBar = TFDirector:getChildByPath(self.Panel_main, "Image_loadingBar")
    self.Panel_optionView = TFDirector:getChildByPath(self.ui, "Panel_optionView")
    self.Panel_danmuView = TFDirector:getChildByPath(self.ui, "Panel_danmuView")
    if self.Image_loadingBar then
        self.Image_loadingBar:hide()
        self.Image_pro = TFDirector:getChildByPath(self.Image_loadingBar, "Image_pro")
    end

    local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer,1000)

    self:initOptionView()
    self:initOther()
    self:initPhone()
    self:initSceneEffect()
    self:initPicture()
    self:initElvesNpc()
    self:initChatContent()
    self:initButtonList()
    self:initPanelPro()

    self:initDanMuView()

    self:resetCTLZOrder()

    self:setBackBtnCallback(function()
        if isScriptTest then
            AlertManager:closeLayer(self)
            return
        end
        self:closeBtnClickHandle()
    end)

    --暂时只保留 主线约会，日常约会 返回按钮
    local trueType = EC_DatingScriptType.SHOW_SCRIPT
    if self.curScript and self.curScript.datingRuleCid then
        trueType = DatingDataMgr:getDatingRuleData(self.curScript.datingRuleCid).type
    end


    self.topLayer:hide()
    --self.closeBtn.isHide = true

    self.closeBtn:setVisible(true and (not (self.noExitBtn and self.isDatingFirst)) and (not self.alwayNoExitBtn))

    if self.settingBtnOffset.x and  self.settingBtnOffset.y then
        self.setButton:setPosition(ccp(self.settingBtnOffset.x + 50, 545 + self.settingBtnOffset.y))
    end

    if self.logBtnOffset.x and  self.logBtnOffset.y then
        self.reviewButton:setPosition(ccp(self.logBtnOffset.x + 50, 485 + self.logBtnOffset.y))
    end

    if DatingDataMgr:getMiniGameScriptId() then
        DatingDataMgr:saveMiniGameOption()
        return
    end
    self:showScriptMsg()
end

function DatingScriptView:initDanMuView()
    --TODO CLOSE
    -- dump(self.curScript.datingRuleCid)
    -- local barrageCfg = TabDataMgr:getData("Barrage")[self.curScript.datingRuleCid]
    --  if barrageCfg and barrageCfg.barrageType == EC_DanmuType.Dating then
    --      self:setDanMuPannelVisible(true)
    --      self.Panel_danMuOption:setVisible(true)
    --      self.isDatingDanMu = true
    --      TFDirector:send(c2s.CHAT_REQ_BULLET_INFO,{self.curScript.datingRuleCid})
    --      if not self.danmuView then
    --          self.danmuView = requireNew("lua.logic.dating.DatingDanMuViewNew"):new(self.curScript.datingRuleCid)
    --          self:addLayerToNode(self.danmuView, self.Panel_danmuView)
    --      else
    --          self.danmuView:resetData(self.curScript.datingRuleCid)
    --      end
    --  else
    --      self:setDanMuPannelVisible(false)
    --      self.isDatingDanMu = false
    --      self.Panel_danMuOption:setVisible(false)
    --  end

    self:setDanMuPannelVisible(false)
    self.isDatingDanMu = false
    self.Panel_danMuOption:setVisible(false)
end

function DatingScriptView:insertPageDanMuData()
    if self.danmuView then
        self.danmuView:updateDanMuData(self.itemData)
    end
end

function DatingScriptView:insertDanMu(str)
    if self.danmuView then
        self.danmuView:insertWord(str)
    end
end

function DatingScriptView:jumpDanMu()

    if not self.danmuView then
        return
    end



    local selectImg = self.skipButton.select
    local visible = selectImg:isVisible()

    if not self.cgView then
        self:setDanMuPannelVisible(not visible)
    end

    if visible then
        self.danmuView:stopAllDanum()
    else
        self.danmuView:jumpDanMu()
    end
end

function DatingScriptView:accelerationDanmu()
    if self.danmuView then
        self.danmuView:accelerationDanmu(self.autoSpeed)
    end
end

function DatingScriptView:initOptionView()
    self.optionView = require("lua.logic.dating.DatingOptionView"):new(self.scriptTableName,
            function(id, data)
                if id == -1 and not data then
                    self:closeBtnClickHandle()
                    return
                end
                self:saveReview()
                table.insert(self.reviewTable, id)
                if self.itemData.optionType == 4 then
                    self.isSkip = false
                    self.isAuto = false
                end
                self.itemData = {}
                self.itemData.jump = {data.jump[1]}
                if not self.interCgView then
                    self:sendDialogueMsg(id)
                end
                --self:showUI()
                if not self.skipButton.isHide then
                    self.skipButton:show()
                end

                if self.isAuto then
                else
                    --self:refreshButtonListState()
                end

                self:jumpToNext()
                self.currentNodeId = id
            end)
    self.optionView:setZOrder(10)
    self:addLayerToNode(self.optionView, self.Panel_optionView)

    --local ws = GameConfig.WS
    --if ws.width >= 1386 then
    --    self.optionView:PosX((1136 - ws.width) / 2)
    --end
end

function DatingScriptView:showOptionView(jumpTable)
    if not self.itemData then
        Box("showOption not found 剧本 ID:" .. tostring(self.id))
        return
    end
    self.isShowOption = true
    if self.itemData.optionType == 2 then
        self:hideUI()
    end

    --self.skipButton:hide()
    if self.itemData.optionType == 4 then
        self:showInterCg()
    else
        self.imageTextBg.mask:show()
        self.optionView:show(self.itemData, jumpTable)
    end
    self.isJumpOk = false
end

function DatingScriptView:showOptionLoadingBarCg(time)
    if time and time ~= 0 then
        self.Image_loadingBar:show()
        self.Image_pro:scaleTo(time,0)
        self.Image_pro:timeOut(function()
            if self.interCgView then
                self.interCgView:over(true)
            end
        end,time)
    end
end

function DatingScriptView:restoreOptionLoadingBarCg()
    self.Image_loadingBar:hide()
    self.Image_pro:Scale(1)
    self.Image_pro:stopAllActions()
end

function DatingScriptView:showInterCg()
    self.isJumpOk = false
    local jumpConfig = self.itemData.jumpConfig
    local time = jumpConfig.time
    --local time = 10
    self:showOptionLoadingBarCg(time)
    self:hideButtonList(0)
    self:hideImageTextBg(0)
    if isTest then
        if self.laBj then
            self.laBj:removeFromParent()
            self.laBj = nil
        end
        self.laBj = TFLabel:create()
        self.laBj:Pos(900,600)
        self.ui:addChild(self.laBj,100)
    end
    self.interCgView = require("lua.logic.dating.SpecialCgView"):new(
            jumpConfig.cg,
            function(scriptId,jumpId,isEnd)
                self.isEnd = isEnd
                self.isJumpOk = true
                self:changeInterAreaState(false)
                self.itemData = {}
                if jumpId and not scriptId then
                    scriptId = jumpId
                    self:sendDialogueMsg(scriptId)
                    self:restoreOptionLoadingBarCg()
                    self.interCgView:RemoveSelf()
                    self.interCgView = nil
                    self.isWaitInterCg = false
                    self.skipButton:show()
                    self.autoButton:show()
                    self.Button_camera:show()
                    self:showButtonList(0)
                    Box("CG 互动结束")
                    if self.laBj then
                        self.laBj:removeFromParent()
                        self.laBj = nil
                    end
                end
                self.itemData.jump = { scriptId }
                self:jumpToNext()
            end,
            time,
            self.laBj
    )
    if self.imageBg and self.imageBg.disScale then
        self.interCgView:Scale(self.imageBg.disScale)
        local disW = (-self.imageBg:Size().width)/2
        local disH = (-self.imageBg:Size().height)/2
        self.interCgView:Pos(disW,disH)
    end
    local Panel_inteCgRoot = TFDirector:getChildByPath(self.imageBg,"Panel_inteCgRoot")
    self:addLayerToNode(self.interCgView,self.imageBg)
end

function DatingScriptView:changeInterAreaState(isOk)
    self.interCgView:changeClickAreaListState(isOk)
    self.interCgView:setIsTouchArea(isOk)
    if isOk then
        --self:hideUI()
        self:hideImageTextBg(0.3)
    end

    if self.interCgView and self.interCgView.time and self.interCgView.time > 0 and not isTest then
        self.Image_loadingBar:setVisible(isOk)
    end
end

function DatingScriptView:loadingDatingEditView()
    self.datingEdit = require("lua.logic.dating.DatingEdit"):new(
            function()
                self.datingEdit:refreshId(self.itemData.id)
            end,
            function(data)
                print("接收data ", data)
                if data then
                    local tData = TabDataMgr:getData(self.scriptTableName)
                    for i, v in ipairs(data) do
                        if not tData[self.itemData.id] then
                            Utils:showTips(TextDataMgr:getText(304011, self.itemData.id).. TextDataMgr:getText(304015))
                        else
                            local key = v.key
                            local value = v.value
                            tData[self.itemData.id][key] = value
                        end
                    end
                    local filePath = me.FileUtils:fullPathForFilename("../../../src/lua/table")
                    local str = string.format("%s/%s.lua", filePath, self.scriptTableName)
                    print("&&&&&&&&&&filePath: ", str)
                    --io.writefile(str,ToStringEx(tData))
                    --saveDataTolua(tData,str)
                    table.writeTable(tData, str, true)

                    for i, v in ipairs(data) do
                        table.luaToCsv(self.scriptTableName, self.itemData.id, v.key, v.value)
                    end

                    self.itemData = clone(self.lastItemData)
                    self:jumpToNext()
                end
            end
    )
    self:addLayer(self.datingEdit, 1000)
end

function DatingScriptView:showReview()
    if self.datingReview then
        return
    end
    self.optionView:setVisible(false)
    local data = {}
    data.reviewTable = clone(self.reviewTable)
    data.infoData = clone(self.data)
    data.closeCallBack = function()
        self.optionView:setVisible(true)
        self:closeReview()
        self.datingReview = nil
        self.ui:runAnimation("Action0",1)
    end

    self.datingReview = requireNew("lua.logic.dating.DatingReview"):new(data)
    AlertManager:addLayer(self.datingReview, AlertManager.BLOCK)
    AlertManager:show()

    self:setDanMuPannelVisible(false)

end

function DatingScriptView:closeReview()
    self:checkNpc(true, true)
    self:showUI()
    self.isJumpOk = true
    self:stopShader()
    local selectImg = self.skipButton.select
    local visible = selectImg:isVisible()
    if  not self.cgView then
        if not visible then
            self:setDanMuPannelVisible(true)
        end
    end


end

function DatingScriptView:showVideoView()
    self.bgm = nil
    self.Panel_lockTouch:show()
    self.isJumpOk = false

    --self.isSkip = false
    --self.isAuto = false
    --
    --self:refreshButtonListState()
    self:hideButtonList(0)

    TFAudio.stopAllEffects()
    self:stopAllActions()
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
        self.voiceHandle = nil
    end

    self.videoView = Utils:openView("common.VideoView", unpack(self.itemData.video))
    self.videoView:bindEndCallBack(function()
        print("video end")
        self.Panel_lockTouch:hide()
        self:showButtonList(0)
        self.videoView = nil
        self:jumpToNext()
        self.isJumpOk = true
    end)
end

function DatingScriptView:showComplete(obsolete)
    print("showComplete obsolete ",obsolete)
    EventMgr:dispatchEvent(EV_DATING_EVENT.datingcompleted, self.id)
    local sMsg = DatingDataMgr:getDatingSettlementMsg() or {}
    if (not sMsg.rewards or #sMsg.rewards == 0) and not self.showCompleteAni then
        DatingDataMgr:clearDatingSettlementMsg()
        AlertManager:closeLayer(self)
    else
        --暂时屏蔽complete显示
        --self.ui:timeOut(function()
        --    Utils:openView("dating.DatingCompleteView", function()
        --        if not tolua.isnull(self) then
        --            self:completeBack(obsolete)
        --        end
        --    end)
        --end, 0.5)
        self:completeBack(obsolete)
    end
end

function DatingScriptView:initPanelPro()
    self.Panel_pro = TFDirector:getChildByPath(self.ui, "Panel_pro")
    self.Panel_score = TFDirector:getChildByPath(self.Panel_pro, "Panel_score"):hide()
    self.Panel_score.pro = TFDirector:getChildByPath(self.Panel_score, "LoadingBar_datingScriptView_1")
    self.Panel_attribute1 = TFDirector:getChildByPath(self.Panel_pro, "Panel_attribute1")
    self.Panel_attribute1.pro = TFDirector:getChildByPath(self.Panel_attribute1, "LoadingBar_datingScriptView_1")
    self.Panel_attribute2 = TFDirector:getChildByPath(self.Panel_pro, "Panel_attribute2")
    self.Panel_attribute2.pro = TFDirector:getChildByPath(self.Panel_attribute2, "LoadingBar_datingScriptView_1")
    self.Panel_attribute3 = TFDirector:getChildByPath(self.Panel_pro, "Panel_attribute3")
    self.Panel_attribute3.pro = TFDirector:getChildByPath(self.Panel_attribute3, "LoadingBar_datingScriptView_1")

    self.Panel_danMuOption = TFDirector:getChildByPath(self.Panel_pro, "Panel_danMuOption")
    self.Button_switch = TFDirector:getChildByPath(self.Panel_danMuOption, "Button_switch")
    self.Button_talk = TFDirector:getChildByPath(self.Panel_danMuOption, "Button_talk")
    self.TextField_danmu = TFDirector:getChildByPath(self.Panel_danMuOption,"TextField_danmu")
    self.TextField_danmu:setMaxLength(30)

    self.Panel_attribute1:setVisible(self.showScore)
    self.Panel_attribute2:setVisible(self.showScore)
    self.Panel_attribute3:setVisible(self.showScore)

    self.attributeList = {}

    table.insert(self.attributeList, self.Panel_attribute1)
    table.insert(self.attributeList, self.Panel_attribute2)
    table.insert(self.attributeList, self.Panel_attribute3)

    self.Panel_score.pro:setPercent(DatingDataMgr:getDeScore())

    if self.showScore then
        self:updateAttributes()
    end
end

function DatingScriptView:onCloseInputLayer()
    self.TextField_danmu:closeIME()
    self.TextField_danmu:setText("")
end

function DatingScriptView:onTouchSendBtn()

    local barrageCfg = TabDataMgr:getData("Barrage")[self.curScript.datingRuleCid]
    if not barrageCfg then
        return
    end
    local coolTime = barrageCfg.coolTime
    local lastSendTime = DanmuDataMgr:getLastSendTimeByType(self.curScript.datingRuleCid)
    local remandTime = lastSendTime - ServerDataMgr:getServerTime() + coolTime
    print(coolTime,lastSendTime,ServerDataMgr:getServerTime(),remandTime)
    if remandTime > 0 then
        local day,hour, min, sec = Utils:getDHMS(remandTime, true)
        Utils:showTips(14210328,sec)
        return
    end

    local content = self.TextField_danmu:getText()
    if content and #content > 0 then
        --self:insertDanMu(content)
        DanmuDataMgr:sendDanmu(self.curScript.datingRuleCid, content, self.itemData.id)
    end
end


function DatingScriptView:updateAttributes(quality)
    local datingVariable = TabDataMgr:getData("DatingVariable")
    local vIdList = RoleDataMgr:getDatingVariableToRole(self.roleId)
    local mQuality = quality or NewCityDataMgr:getMainLineDataQuality()
    local changeFlag = false
    local lastQuality = NewCityDataMgr:getLastMainLineQuality()
    if lastQuality then
        for k,v in pairs(lastQuality) do
            for k, v1 in pairs(mQuality) do
                if v1.qualityId == v.qualityId and v1.value ~=  v.value then
                    changeFlag = true
                end
            end
        end
    end
    print("NewCityDataMgr:getMainLineDataQuality() ", NewCityDataMgr:getMainLineDataQuality())
    for i, v in ipairs(vIdList) do
        local qId = v
        local data = datingVariable[qId]
        if data then
            local value
            if quality then
                for i, v in ipairs(quality) do
                    if v.qualityId == qId then
                        value = v.value or 0
                        break
                    end
                end
            else
                if mQuality[qId] then
                    value = mQuality[qId].value or 0
                else
                    value = 0
                end

            end
            value = value or 0
            local maxValue = data.limit[2] or 100
            print("updateAttributes maxValue ", maxValue)
            local Panel_attribute = self.attributeList[i]
            local Label_aName = Panel_attribute:getChildByName("Label_title")
            if data.name and data.name ~= 0 then
                Label_aName:setTextById(data.name)
            end
            Panel_attribute.pro:setPercent(value / maxValue * 100)

            local Panel_progress = Panel_attribute:getChild("Panel_progress")
            local progressidx = math.floor(value/maxValue*100/10)
            for i = 1, 10 do
                local image_progress = Panel_progress:getChild("Image_progress"..i)
                if i <= progressidx then
                    image_progress:setTexture("ui/newCity/city_main/jindu"..i..".png")
                else
                    image_progress:setTexture("ui/newCity/city_main/jindubg.png")
                end
            end

        end
    end
    return changeFlag
end

function DatingScriptView:changeScore(score)
    score = score > 100 and 100 or score
    self.score = score
    self.Panel_score.pro:setPercent(score)
end
function DatingScriptView:initButtonList()
    local Image_textBg = TFDirector:getChildByPath(self.ui, "Image_textBg")
    self.skipButton = TFDirector:getChildByPath(self.ui, "Button_skip")
    self.skipButton.savePos = self.skipButton:Pos()
    self.autoButton = TFDirector:getChildByPath(self.ui, "Image_auto")
    self.autoButton.savePos = self.autoButton:Pos()
    self.autoButton.Label_speed = TFDirector:getChildByPath(self.autoButton, "Label_speed"):hide()
    self.reviewButton = TFDirector:getChildByPath(self.ui, "Image_lookBack")
    self.Button_camera = TFDirector:getChildByPath(self.ui, "Button_camera")
    self.setButton = TFDirector:getChildByName(self.ui, "Button_set")

    self.setButton:setOpacity(0)
    self.reviewButton:setOpacity(0)

    self.skipButton:setVisible(not self.isDatingFirst)
    if self.isDatingFirst then
        Image_textBg:setTexture("ui/dating/newDating/content/034.png")
    else
        Image_textBg:setTexture("ui/dating/newDating/content/021.png")
    end
    self.skipButton.isHide = self.isDatingFirst

    self.skipButton:setOpacity(0)
    self.autoButton:setOpacity(0)
    self.Button_camera.isClick = true

    table.insert(self.buttonList, self.skipButton)
    self.skipButton.type = self.btnType.skip
    table.insert(self.buttonList, self.autoButton)
    self.autoButton.type = self.btnType.auto
    table.insert(self.buttonList, self.reviewButton)
    self.reviewButton.type = self.btnType.review
    table.insert(self.buttonList, self.Button_camera)
    self.Button_camera.type = self.btnType.hide
    table.insert(self.buttonList, self.setButton)
    self.setButton.type = self.btnType.set

    for i, v in ipairs(self.buttonList) do
        v.select = v:getChildByName("Image_select")
        if v.select then
            v.select:hide()
        end
    end
end

function DatingScriptView:setButtonListTouchState(isState)
    for i, v in ipairs(self.buttonList) do
        v:Touchable(isState)
    end
end

function DatingScriptView:sendDialogueMsg(id)
    if self.optionActType == 1 then 
        self.isSending = true
        NewCityDataMgr:sendChooseEntranceEvent(id, EC_DatingChoiceType.ChoiceScript)
    elseif self.optionActType == 2 then
        self.isSending = true
        DatingDataMgr:sendDialogueMsg(self.id, id, DatingDataMgr:getScriptType(), self.roleId)
    end
end

function DatingScriptView:showScriptMsg()
    if not self.isNoF then
        DatingDataMgr:clearReviewTable(DatingConfig.ReviewKey.YUEHUI_KEY, self.datingType)
    else
        self.reviewTable = DatingDataMgr:readReviewTable(DatingConfig.ReviewKey.YUEHUI_KEY, self.datingType)
    end

    self:loading()
end

function DatingScriptView:loading()
    self:refreshChatContent()
end

function DatingScriptView:loadingContent(deyTime, isChange)
    --deyTime = self:showImageTextBg(deyTime)

    if isChange == nil then
        self:changeElvesNpcShow()
    end
    if self.itemData.name ~= "" then
        self:showName(deyTime + 0.2)
    end
    deyTime = self:showText(deyTime)
    if self.isGameStart == false then
        self.isGameStart = true
        return
    end
end

function DatingScriptView:initOther()
    --返回
    self.closeBtn = TFDirector:getChildByPath(self.Panel_base, "Button_back")

    --背景
    self.imageBg = TFDirector:getChildByPath(self.ui, "Image_bg")
    self.imageBg.savePos = self.imageBg:getPosition()

    --回憶蒙版
    self.Image_black = TFDirector:getChildByPath(self.ui, "Image_black"):hide()

    self.Panel_lockTouch = TFDirector:getChildByPath(self.ui, "Panel_lockTouch"):hide()

    self:refreshBg(self.imageBg)
end

function DatingScriptView:initSceneEffect()
    self.Spine_sceneEffect = TFDirector:getChildByPath(self.ui, "Spine_sceneEffect")
    self.Spine_sceneEffect:Hide()
end

function DatingScriptView:initPhone()
    self.Spine_phone = TFDirector:getChildByPath(self.ui, "Spine_phone")
    self.Spine_phone:Hide()
    self.phoneSK = nil
end

function DatingScriptView:showPhone()
    local skPath = self.itemData.phonePath
    local aniName = self.itemData.phoneAction

    if #skPath == 0 then
        return
    end

    self.phoneSK = SkeletonAnimation:create(skPath)
    self.phoneSK:play(aniName, false)
    self.phoneSK:setPosition(self.Spine_phone:getPosition())
    self.Spine_phone:getParent():addChild(self.phoneSK, 1000)
    self.phoneSK.aniName = aniName
end

function DatingScriptView:stopSceneEffect(isFade)
    if self.itemData.effectId and #self.itemData.effectId ~= 0 then
        local isAllStop = self.itemData.effectId[1] == 1 and true or false
        for i, v in pairs(self.sceneEffect_) do
            local uEffectId = i
            if isAllStop or table.find(self.itemData.effectId,uEffectId) == -1 then
                local removeFun = function()
                    if self.sceneEffect_[uEffectId].newAddBg then
                        self.sceneEffect_[uEffectId].newAddBg:RemoveSelf()
                    end
                    self.sceneEffect_[uEffectId]:RemoveSelf()
                    self.sceneEffect_[uEffectId] = nil
                end
                if isFade then
                    local acArrOut = TFVector:create()
                    local worldPos = self.sceneEffect_[uEffectId]:convertToWorldSpace(ccp(0,0))
                    local disScale = self.sceneEffect_[uEffectId]:getParent():Scale()*self.sceneEffect_[uEffectId]:Scale()
                    self.sceneEffect_[uEffectId]:retain()
                    self.sceneEffect_[uEffectId]:RemoveSelf()
                    self.Panel_main:addChild(self.sceneEffect_[uEffectId],CTL_ZOrder.changeBgFadeZOrder+1)
                    self.sceneEffect_[uEffectId]:Scale(disScale)
                    self.sceneEffect_[uEffectId]:Pos(self.Panel_main:convertToNodeSpace(worldPos))

                    print("self.sceneEffect_[uEffectId]:Pos ",self.sceneEffect_[uEffectId]:Pos())
                    local fadeOut = CCFadeOut:create(1.5)
                    local removeFunBack = CCCallFunc:create(function()
                        removeFun()
                    end)
                    acArrOut:addObject(fadeOut)
                    acArrOut:addObject(removeFunBack)
                    self.sceneEffect_[uEffectId]:runAction(CCSequence:create(acArrOut))

                    if self.sceneEffect_[uEffectId].newAddBg then
                        local acArrOutP = TFVector:create()
                        acArrOutP:addObject(CCFadeOut:create(1.5))
                        self.sceneEffect_[uEffectId].newAddBg:runAction(CCSequence:create(acArrOutP))
                    end
                else
                    removeFun()
                end
            end
        end
    end
end

function DatingScriptView:checkSceneEffectSpeBg()
    for i, v in pairs(self.sceneEffect_) do
        if v.newAddBg then
            return true
        end
    end
    return false
end

function DatingScriptView:showSceneEffect()
    local appear = tonumber(self.itemData.appear)
    if (self.isSkip and not self.isAuto) or (appear ~= 1 and appear ~= 12) then
        self:stopSceneEffect()
    else
        self:stopSceneEffect(true)
    end
    local datingEffectMgrData = TabDataMgr:getData("DatingEffectMgr")
    if self.itemData.effectId and #self.itemData.effectId ~= 0 and datingEffectMgrData then
        local gSZorder = 1
        for i, v in ipairs(self.itemData.effectId) do
            local uEffectId = v
            if datingEffectMgrData[uEffectId] and not self.sceneEffect_[uEffectId] then
                local effectData = datingEffectMgrData[uEffectId]
                local effectSK = nil
                local layerZ = self.itemData.layerBelongTo and self.itemData.layerBelongTo[i] or 1
                if effectData.isLoop then
                    effectSK = self:showSceneLoopEffect(effectData,layerZ,gSZorder)
                    gSZorder = gSZorder + 1
                else
                    effectSK = self:showSceneSingleEffect(effectData,layerZ,uEffectId)
                end
                if effectSK then
                    self.sceneEffect_[uEffectId] = effectSK
                    self.sceneEffect_[uEffectId].disScale = self.sceneEffect_[uEffectId]:getParent().disScale or 1
                end
            end
        end
    end
end

function DatingScriptView:showSceneSingleEffect(effectData,layerZ,uEffectId)
    local skPath = effectData.path
    local aniName = effectData.action
    local layerBelongTo = layerZ
    if skPath == "" then return nil end
    local effectSK = SkeletonAnimation:create(skPath)
    effectSK:play(aniName, false)
    local scale = 1
    if effectData.scales and effectData.scales ~= 0 then
        scale = effectData.scales
    end
    --effectSK:Scale(scale)
    local offPos = effectData.offset
    if offPos and offPos.x and offPos.y then
        effectSK:setPosition(self.Spine_sceneEffect:getPosition() + ccp(offPos.x,offPos.y))
    else
        effectSK:setPosition(self.Spine_sceneEffect:getPosition())
    end
    if layerBelongTo == 1 or not layerBelongTo then
        effectSK:Scale(scale*self.imageBg.disScale)
        self.imageBg:addChild(effectSK)
        effectSK:setZOrder(3)
    elseif layerBelongTo == 2 then
        self.imageBg:getParent():addChild(effectSK)
        local ws = self.imageBg:getParent():Size()
        if offPos and offPos.x and offPos.y then
            effectSK:setPosition(ccp(ws.width/2,ws.height/2) + ccp(offPos.x,offPos.y))
        else
            effectSK:setPosition(ccp(ws.width/2,ws.height/2))
        end
    elseif layerBelongTo == 3 then
        effectSK:Scale(scale*self.imageBg.disScale)
        self.imageBg:addChild(effectSK)
    end
    if effectData.speBg and #effectData.speBg ~= 0 then
        local newAddBg = TFImage:create()
        newAddBg:setTexture(effectData.speBg)
        self.imageBg:addChild(newAddBg,2)
        newAddBg:Pos(ccp(0,0))
        newAddBg:Scale(scale*self.imageBg.disScale)
        effectSK.newAddBg = newAddBg
    end

    if effectData.isDelete then
        effectSK:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
            self.sceneEffect_[uEffectId] = nil
            skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
            skeletonNode:removeMEListener(TFARMATURE_EVENT)
            skeletonNode:removeFromParent()
        end)
    end
    effectSK.layerBelongTo = layerBelongTo
    return effectSK
end

function DatingScriptView:showSceneLoopEffect(effectData,layerZ,gSZorder)
    print("showSceneLoopEffect  effectData",effectData)
    local skPath = effectData.path
    local aniName = effectData.action
    local layerBelongTo = layerZ

    if skPath == "" then return nil end
    local effectSK = SkeletonAnimation:create(skPath)
    effectSK:play(aniName, true)
    local scale = 1
    if effectData.scales and effectData.scales ~= 0 then
        scale = effectData.scales
    end
    --effectSK:Scale(scale)
    local offPos = effectData.offset
    if offPos and offPos.x and offPos.y then
        effectSK:setPosition(self.Spine_sceneEffect:getPosition() + ccp(offPos.x,offPos.y))
    else
        effectSK:setPosition(self.Spine_sceneEffect:getPosition())
    end
    if effectData.speBg and #effectData.speBg ~= 0 then
        local newAddBg = TFImage:create()
        newAddBg:setTexture(effectData.speBg)
        self.imageBg:addChild(newAddBg,gSZorder)
        newAddBg:Pos(ccp(0,0))
        newAddBg:Scale(scale*self.imageBg.disScale)
        effectSK.newAddBg = newAddBg
    end

    if layerBelongTo == 1 or not layerBelongTo then
        effectSK:Scale(scale*self.imageBg.disScale)
        self.imageBg:addChild(effectSK)
        effectSK:setZOrder(gSZorder)
    elseif layerBelongTo == 2 then
        self.imageBg:getParent():addChild(effectSK)
        local ws = self.imageBg:getParent():Size()
        if offPos and offPos.x and offPos.y then
            effectSK:setPosition(ccp(ws.width/2,ws.height/2) + ccp(offPos.x,offPos.y))
        else
            effectSK:setPosition(ccp(ws.width/2,ws.height/2))
        end
    elseif layerBelongTo == 3 then
        effectSK:Scale(scale*self.imageBg.disScale)
        self.imageBg:addChild(effectSK,gSZorder-1)
    end
    effectSK.layerBelongTo = layerBelongTo
    return effectSK
end

function DatingScriptView:hidePhone(isChange)

    if self.phoneSK then
        self.phoneSK:RemoveSelf()
        self.phoneSK = nil
        if isChange then
            self:showPhone()
        end
    end
end

function DatingScriptView:initPicture()
    self.Panel_insertImage = TFDirector:getChildByPath(self.Panel_main, "Panel_insertImage")
    self.pictureArrayPos = self.pictureArrayPos or {}
    for i = 1, 5 do
        local Image_picture = TFDirector:getChildByPath(self.Panel_insertImage, "Image_picture" .. i):hide()
        self.pictureArray = self.pictureArray or {}
        table.insert(self.pictureArray, Image_picture)
        table.insert(self.pictureArrayPos, Image_picture:getPosition())
    end
end
--看板娘
function DatingScriptView:initElvesNpc()
    self.Panel_normalNpc = TFDirector:getChildByPath(self.ui, "Panel_normalNpc")
    self.Panel_specNpc = TFDirector:getChildByPath(self.ui, "Panel_specNpc")

    self.npcData_ = {}
end

function DatingScriptView:hidePicture()
    for i, v in ipairs(self.pictureArray) do
        if v.isVisible then
            local acArrOut = TFVector:create()
            local fadeOutAc = CCFadeOut:create(0.3)
            local hideFun = CCCallFunc:create(function()
                v:hide()
            end)
            acArrOut:addObject(fadeOutAc)
            acArrOut:addObject(hideFun)
            v:stopAllActions()
            v:runAction(CCSequence:create(acArrOut))
        end
    end
end

function DatingScriptView:showPicture()
    -- local num = 0
    -- for i = 1, 3 do
    --     if self.itemData["insertPic" .. i] and self.itemData["insertPic" .. i] == "" then
    --         num = num + 1
    --     end
    -- end

    -- if num == 1 then
    --     self.pictureArray[1]:show()
    --     self.pictureArray[1]:setTexture(self.itemData.insertPic1)
    -- elseif num == 2 then
    --     self.pictureArray[2]:show()
    --     self.pictureArray[2]:setTexture(self.itemData.insertPic1)
    --     self.pictureArray[3]:show()
    --     self.pictureArray[3]:setTexture(self.itemData.insertPic2)
    -- elseif num == 3 then
    --     self.pictureArray[1]:show()
    --     self.pictureArray[1]:setTexture(self.itemData.insertPic1)
    --     self.pictureArray[4]:show()
    --     self.pictureArray[4]:setTexture(self.itemData.insertPic2)
    --     self.pictureArray[5]:show()
    --     self.pictureArray[5]:setTexture(self.itemData.insertPic3)
    -- end
    if not self.itemData.insertPicture then
        return 
    end

    for k,v in pairs(self.itemData.insertPicture) do
        if v.disapr then -- 隐藏图片
            print("=============",k)
            local arr = {
                FadeOut:create(0.3),
                CallFunc:create(function ()
                self.pictureArray[k]:hide()
                self.pictureArray[k]:setOpacity(255)
                end)
            }
            self.pictureArray[k]:runAction(CCSequence:create(arr))
        
        else
            self.pictureArray[k]:show()
            self.pictureArray[k].isShowAnim = nil
            self.pictureArray[k]:setTexture(v.path)
            v.x = v.x or 0
            v.y = v.y or 0
            self.pictureArray[k]:setPosition(self.pictureArrayPos[k] + me.p(v.x,v.y))
        end
    end

    for i, v in ipairs(self.pictureArray) do
        
        if v.isVisible and not v.isShowAnim then
            v:stopAllActions()
            v:setOpacity(0)
            v:fadeIn(0.3)
            v.isShowAnim = true
        end
    end

    --self.Image_picture:setScale(self.itemData.pictureSize)
    --if self.itemData.picturePosition and #self.itemData.picturePosition == 2 then
    --    self.Image_picture:Pos(self.itemData.picturePosition[1],self.itemData.picturePosition[2])
    --end
end

function DatingScriptView:changeElvesNpcShow(deyTime)
    deyTime = deyTime or 0

    local deyShowNpcTime = 0
    for i = 1, 3 do
        if self.itemData["roleDisaprType" .. i] and not (self.isSkip and not self.isAuto) then
            deyShowNpcTime = 0.5
            break
        end
    end

    for i = 1, 3 do
        local elvesNpc = self.npcData_["id"..i]
        local value = self.itemData["modelId" .. i]
        if elvesNpc and elvesNpc.type ~= 2  then
            elvesNpc:stopRenderAction(true)
            elvesNpc:removeExpression()
        end
        if not value or value == 0 then
            deyTime = math.max(deyTime, self:hideElvesNpc(elvesNpc, i))
        else
            deyTime = math.max(deyTime, self:showElvesNpc(elvesNpc, i,deyShowNpcTime))
        end
    end
    self:playElvesNpcShowAni(deyShowNpcTime)
    --self:checkNpcShader()

    return deyTime
end

function DatingScriptView:setNpcPos(target, locationId, disX, disY)
    disX = disX or 0
    disY = disY or 0
    local normalPos = ccp(566,-40) + ccp(disX, disY)
    if locationId == 2 then
        target:setPosition(normalPos)
    elseif locationId == 1 then
        target:setPosition(normalPos - ccp(300, 0))
    elseif locationId == 3 then
        target:setPosition(normalPos + ccp(300, 0))
    elseif locationId == 4 then
        target:setPosition(normalPos - ccp(175, 0))
    elseif locationId == 5 then
        target:setPosition(normalPos + ccp(175, 0))
    elseif locationId == 6 then
        target:setPosition(normalPos - ccp(400, 210))
    end
    target.locationId = locationId
end


function DatingScriptView:showElvesNpc(elvesNpc, id,deyShowNpcTime)
    local ws = GameConfig.WS
    disScale = 1
    if ws.width >= 1386 then
        disScale = 0.8
    end
    local roleInfo = {}
    roleInfo.id = id
    roleInfo.disScale = disScale
    roleInfo.modelId = self.itemData["modelId" .. id] or 0
    roleInfo.eModelId = self.itemData["eModelId" .. id] or 0
    roleInfo.roleLocation = id
    if self.itemData["roleLocation" .. id] then
        roleInfo.roleLocation = tonumber(self.itemData["roleLocation" .. id])
    end
    roleInfo.roleAction = self.itemData["action" .. id] or ""
    roleInfo.expressionAction = self.itemData["expressionAction" .. id] or ""
    if self.itemData["roleScale" .. id] and self.itemData["roleScale" .. id] ~= 0 then
        roleInfo.roleScale = self.itemData["roleScale" .. id] * disScale
    elseif roleInfo.modelId ~= 1 and roleInfo.modelId ~= 0 then
        roleInfo.roleScale = 1.3 * disScale
    end
    roleInfo.locOffset = self.itemData["locOffset" .. id] or {}
    roleInfo.faceExpression = self.itemData["face" .. id] or ""

    if roleInfo.modelId == 1 then
        if elvesNpc then
            elvesNpc.isFirst = false
        end
    elseif roleInfo.modelId == 0 then
        return
    else
        self.itemData["roleDisaprType" .. id] = self.itemData["roleDisaprType" .. id] or 0
        if elvesNpc and elvesNpc.modelId == roleInfo.modelId and self.itemData["roleDisaprType" .. id] == 0 then
        else
            local disTime =  self:hideElvesNpc(elvesNpc, id)
            return self:createElvesNpc(deyShowNpcTime,roleInfo)
        end
    end
    self:updateElvesNpc(elvesNpc,roleInfo)
    return 0
end

function DatingScriptView:updateElvesNpc(elvesNpc,roleInfo)
    local id = roleInfo.id
    if not elvesNpc then
        return
    else
        if roleInfo.eModelId and elvesNpc.type ~= 2 then
            ElvesNpcTable:addExpressionID(elvesNpc, roleInfo.eModelId, roleInfo.expressionAction)
        end
    end
    local locationId = roleInfo.roleLocation
    if roleInfo.modelId == 1 then
    else
        self:setNpcPos(elvesNpc, locationId)
        elvesNpc.savePos = elvesNpc:Pos()

        local disY = (roleInfo.roleScale - 1) * 205
        local disX = 0
        if roleInfo.locOffset and table.count(roleInfo.locOffset) > 0 then
            disX = roleInfo.locOffset.x
            disY = disY - roleInfo.locOffset.y
        end

        disY = disY + (1-roleInfo.disScale) * 200

        elvesNpc:Pos(elvesNpc.savePos.x + disX, elvesNpc.savePos.y - disY)

        elvesNpc:Scale(elvesNpc.defaultScale * roleInfo.roleScale)
        if elvesNpc.expression then
            elvesNpc.expression:Scale(elvesNpc.defaultScale * roleInfo.roleScale)
        end
    end
    if not elvesNpc.isFirst and (roleInfo.roleScale and roleInfo.roleScale ~= 0) then
        local disY = (roleInfo.roleScale - 1) * 208
        local disX = 0
        if roleInfo.locOffset and table.count(roleInfo.locOffset) > 0 then
            disX = roleInfo.locOffset.x
            disY = disY - roleInfo.locOffset.y
        end

        disY = disY + (1-roleInfo.disScale) * 200

        local elvesNpcSavePos = elvesNpc.savePos
        elvesNpc:stopAllActions()
        local spawnAc1 = {
            MoveTo:create(0.2, ccp(elvesNpcSavePos.x + disX, elvesNpcSavePos.y - disY)),
            CCScaleTo:create(0.2, elvesNpc.defaultScale * roleInfo.roleScale)
        }

        elvesNpc:runAction(CCSpawn:create(spawnAc1))
        if elvesNpc.expression then
            local spawnAc2 = {
                CCScaleTo:create(0.2, elvesNpc.defaultScale * roleInfo.roleScale)
            }

            elvesNpc.expression:runAction(CCSpawn:create(spawnAc2))
        end
    end

    if elvesNpc and self.itemData.roleLipAnime and elvesNpc.type ~= 2 then
        if type(self.itemData.roleLipAnime) == "number" then
            if self.itemData.roleLipAnime == id then
                elvesNpc:playNovoice()
            elseif self.itemData.roleLipAnime - 3 == id then
                elvesNpc:playNovoiceTuZui()
            end
        elseif type(self.itemData.roleLipAnime) == "table" then
            for i, v in ipairs(self.itemData.roleLipAnime) do
                if v == id then
                    elvesNpc:playNovoice()
                elseif v - 3 == id then
                    elvesNpc:playNovoiceTuZui()
                end
            end
        end
    end
    if elvesNpc and elvesNpc.type ~= 2 then

        local eyeMap = TabDataMgr:getData("RoleEyeOpenPara") or {}
        local isEyeBlink = true
        local eyeOpenPara = 1
        for i, v in ipairs(eyeMap) do
            if v.roleModel == elvesNpc.modelId then
                local isSetEye = false
                if v.animeType and v.animeType == 1 and v.faceId == roleInfo.faceExpression then
                    isSetEye = true
                elseif v.animeType and v.animeType == 2 and v.faceId == roleInfo.roleAction then
                    isSetEye = true
                end
                if isSetEye then
                    isEyeBlink = v.isEyeBlink
                    eyeOpenPara = v.eyeOpenPara
                    break
                end
            end
        end

        print("\n\n眨眼效果参数")
        print("eyeOpenPara ", eyeOpenPara)
        print("isEyeBlink ", isEyeBlink)
        print("roleInfo.faceExpression ", roleInfo.faceExpression)
        print("elvesNpc.modelId ", elvesNpc.modelId)
        print("\n\n")
        elvesNpc:changeEyeMaxValue(eyeOpenPara)
        elvesNpc:setEyeBlinkEnabled(0, isEyeBlink)
    end
    if elvesNpc and #roleInfo.roleAction > 0 and tonumber(roleInfo.roleAction) ~= 0 then
        if (self.itemData["isIgonreAction" .. id] and self.isSkip and not self.isAuto) then
            return
        end
        local roleAcTable = nil
        if type(roleInfo.roleAction) == "table" then
            roleAcTable = roleInfo.roleAction
        end

        self:stopNpcVoice()

        local soundValue = nil

        if (self.isSkip and not self.isAuto) or self.autoSpeed > 1 then
            soundValue = 0
        end

        if elvesNpc.type == 2 then
            --if elvesNpc.ac then
            --    local playAc = {
            --        CCFadeOut:create(0.2),
            --        CCCallFunc:create(function()
            --            elvesNpc:play(roleInfo.roleAction,true)
            --        end),
            --        CCFadeIn:create(0.2),
            --    }
            --    elvesNpc:runAction(CCSequence:create(playAc))
            --else
                elvesNpc:play(roleInfo.roleAction,true)
                elvesNpc.ac = true
            --end
            print("spine model roleAction " .. roleInfo.roleAction)
        elseif roleAcTable then
            local acName1 = roleAcTable.generalAc
            local acTime1 = roleAcTable.generalAcTime
            local acName2 = roleAcTable.loopAc
            elvesNpc:newStartAction(acName1, EC_PRIORITY.FORCE, acTime1, acName2, 3 * 1000,soundValue)
        else
            elvesNpc:newStartAction(roleInfo.roleAction, EC_PRIORITY.FORCE,nil,nil,nil,soundValue)
        end

        local voiceTime = 0
        if elvesNpc.type ~= 2 and elvesNpc:getCurrentEffectID(0) then
            voiceTime = elvesNpc:getCurrentEffectTime()
            if self.voiceHandle then
                TFAudio.stopEffect(self.voiceHandle)
                self.voiceHandle = nil
            end
        end
        if voiceTime > 0 then
            --Box("voiceTime " .. voiceTime)
            self.isHaveNpcVoice = true
            self.isAuttoJump = false
            self.isTouchJump = false
            self.Panel_base:timeOut(function()
                self.isTouchJump = true
                if self.isAuttoJump then
                    self:skipFun()
                else
                    self.isAuttoJump = true
                end
            end,voiceTime)
        end

        if roleInfo.faceExpression and elvesNpc.type ~= 2 then
            elvesNpc:playExpression(roleInfo.faceExpression)
        end
    end
end

function DatingScriptView:playElvesNpcShowAni( disTime )
    -- body
        self.Panel_lockTouch:timeOut(function()
            for id = 1,3 do
                    local npc = self.npcData_["id"..id]
                    if npc then
                        if self.itemData["roleShowType" .. id] and self.itemData["roleShowType" .. id] ~= 0
                                and not (self.isSkip and not self.isAuto) and npc.type ~= 2 then
                            npc:timeOut(function()
                                if self.itemData["roleShowType" .. id] == 2 then
                                    npc:playIn(0.3)
                                elseif self.itemData["roleShowType" .. id] == 3 then
                                    npc:playMoveLeftIn(0.3)
                                elseif self.itemData["roleShowType" .. id] == 4 then
                                    npc:playMoveRightIn(0.3)
                                elseif self.itemData["roleShowType" .. id] == 5 then
                                    npc:playMoveUpIn(0.3)
                                elseif self.itemData["roleShowType" .. id] == 6 then
                                    npc:playIn(0.15)    
                                end
                            end, 0.3)
                        else
                            npc:show()
                            if npc.type == 2 then
                                npc:setOpacity(0)
                                npc:fadeIn(0.3)
                            end
                        end
                    end
            end
        end,disTime)
end

function DatingScriptView:createElvesNpc(disTime,roleInfo)
    local id = roleInfo.id
    if self.itemData["roleDisaprType" .. id] and self.itemData["roleDisaprType" .. id] == 2 and not (self.isSkip and not self.isAuto) then
        disTime = disTime + 0.1
    end

    local deyTime = 0
    if self.itemData["roleShowType" .. id] and not (self.isSkip and not self.isAuto) and roleInfo.modelId then
        deyTime = disTime + 0.3 + 0.5
    else
        deyTime = disTime
    end

    if self.isSkip and not self.isAuto then
        deyTime = 0
    end

    local elvesNpc
    if roleInfo.modelId then
        local mTable = TabDataMgr:getData("RoleModel")
        local modelData = mTable[roleInfo.modelId]
        if modelData and modelData.type == 2 then
            print("spine model path " .. modelData.rolePath .. "/" .. modelData.roleName)
            elvesNpc = SkeletonAnimation:create(modelData.rolePath .. "/" ..modelData.roleName)
            elvesNpc.type = modelData.type
            elvesNpc.modelId = roleInfo.modelId
            elvesNpc.defaultScale = 1
        else
            elvesNpc = ElvesNpcTable:createLive2dNpcID(roleInfo.modelId, false, false, nil).live2d
            ElvesNpcTable:addExpressionID(elvesNpc, roleInfo.eModelId, roleInfo.expressionAction)
        end
        elvesNpc.isFirst = true
        if roleInfo.roleLocation == 6 then
            self.Panel_specNpc:addChild(elvesNpc)
        else
            self.Panel_normalNpc:addChild(elvesNpc)
        end
        elvesNpc:hide()
        self.npcData_["id"..id] = elvesNpc
    else
        return
    end
    if elvesNpc.touchNode then
        elvesNpc.touchNode:setTouchEnabled(false)
    end
    self:updateElvesNpc(elvesNpc,roleInfo)
    return deyTime
end

function DatingScriptView:hideElvesNpc(elvesNpc, id)
    if not elvesNpc then
        return 0
    end

    for k, v in pairs(self.npcData_) do
        if v == elvesNpc then
            self.npcData_[k] = nil
            break
        end
    end

    if elvesNpc.locationId == 6 and (self.isSkip and not self.isAuto) then
        self:removeNpc(elvesNpc)
        return 0
    end
    local time = 0
    if self.itemData["roleDisaprType" .. id] and not (self.isSkip and not self.isAuto)then
        time = 0.3
        print("roleDisaprType ", self.itemData["roleDisaprType" .. id])

        if elvesNpc.type == 2 then
            elvesNpc:fadeOut(time)
        elseif self.itemData["roleDisaprType" .. id] == 2 then
            elvesNpc:playOut(time)
        elseif self.itemData["roleDisaprType" .. id] == 3 then
            elvesNpc:playMoveLeftOut(time)
        elseif self.itemData["roleDisaprType" .. id] == 4 then
            elvesNpc:playMoveRightOut(time)
        elseif self.itemData["roleDisaprType" .. id] == 5 then
            elvesNpc:playMoveDownOut(time)
        else
            time = 0
        end
    end
    elvesNpc.locationId = nil
    elvesNpc:timeOut(function()
        self:removeNpc(elvesNpc)
    end, time)
    return time + 0.01
end

function DatingScriptView:removeNpc(elvesNpc)
    elvesNpc:stopAllActions()
    elvesNpc:removeFromParent()
end

--聊天内容
function DatingScriptView:refreshChatContent()
    self.data = nil
    self.data = TabDataMgr:getData(self.scriptTableName)

    self.itemData = {}
    self.itemData.start = true
    self.itemData.jump = { self.id }

    self:jumpToNext()
end

function DatingScriptView:initChatContent()

    self.imageTextBg = TFDirector:getChildByPath(self.ui, "Image_textBg")
    self.imageTextBg.mask = TFDirector:getChildByPath(self.imageTextBg, "Panel_mask"):hide()
    self.Image_diceng = TFDirector:getChildByPath(self.ui, "Image_diceng")
    if self.Image_diceng then
        self.Image_diceng:hide()
    end
    self.imageTextBg.savePos = self.imageTextBg:Pos()
    self.imageTextBg:setOpacity(0)
    self.Image_diceng:setOpacity(0)
    self.Panel_touchLayer = TFDirector:getChildByPath(self.ui, "Panel_touchLayer")

    self.Panel_touchLayer:addMEListener(TFWIDGET_CLICK, function(sender)
        self:onClickPanelTouchLayer()
    end)

    local textarea = TFDirector:getChildByPath(self.ui, "TextArea_talking")
    self.textarea = textarea
    self.textarea.savePos = self.textarea:Pos()
    self.textarea.saveSize = self.textarea:Size()
    self.textDeScale = 1.2
    --self.textarea:setFontSize(self.textarea:getFontSize() * self.textDeScale)
    self.textarea:setFontSize(26)
    self.textarea:Scale(1 / self.textDeScale)
    --设置行间距
    --self.textarea:setLineHeight(self.textarea:getLineHeight() / self.textDeScale )
    self.textarea:setText("")

    self.name = TFDirector:getChildByPath(self.ui, "Label_name")
    self.name.pos = self.name:getPosition()
    --self.name:setOpacity(0)

    self.Image_nameBottom = TFDirector:getChildByPath(self.ui, "Image_nameBottom")
    self.Image_nameBottom:setOpacity(0)
    self.Image_nameBottom:hide()
    self.Image_nameBottom.pos = self.Image_nameBottom:Pos()

    self.Image_jiasu = TFDirector:getChildByPath(self.ui, "Image_jiasu"):hide()
    self.Image_normal = TFDirector:getChildByPath(self.ui, "Image_normal")

end

function DatingScriptView:changeTextBottom()
    if self.itemData.textBottom and self.itemData.textBottom ~= 0 then

    else

    end
end

function DatingScriptView:showName(deyTime)

    deyTime = deyTime or 0.3
    local nameCopy = ""
    if self.itemData.name == "1" then
        if isScriptTest then
            nameCopy = "我"
        else
            nameCopy = MainPlayer:getPlayerName()
        end
    else
        nameCopy = self.itemData.name
    end

    self.Image_nameBottom:stopAllActions()
    --self.Image_nameBottom:Pos(self.Image_nameBottom.pos)
    self.Image_nameBottom:show()
    if self.isSkip and not self.isAuto then
        self.Image_nameBottom:setOpacity(255)
        self.name:setText(nameCopy)
        --self.name:setOpacity(255)
        if self:checkNpcSpeciaLocation() then
            self.Image_nameBottom:Pos(self.Image_nameBottom.pos.x + 280,self.Image_nameBottom.pos.y)
        else
            self.Image_nameBottom:Pos(self.Image_nameBottom.pos)
        end
        return
    end
    --self.Image_nameBottom:fadeIn(deyTime)

    local acArrIn = TFVector:create()
    local deyAc = DelayTime:create(deyTime)

    local function cb()
        if self:checkNpcSpeciaLocation() then
            self.Image_nameBottom:Pos(self.Image_nameBottom.pos.x + 280,self.Image_nameBottom.pos.y)
        else
            self.Image_nameBottom:Pos(self.Image_nameBottom.pos)
        end

        local savePos = self.Image_nameBottom:Pos()
        self.name:setText(nameCopy)
        self.Image_nameBottom:PosX(savePos.x - 20)
        local fadeIn = FadeIn:create(0.2)
        local moveIn = MoveTo:create(0.2, savePos)
        local spawnArr = { moveIn, fadeIn }
        local spawn = CCSpawn:create(spawnArr)
        self.Image_nameBottom:runAction(spawn)
    end
    local funAc = CallFunc:create(cb)

    local Arc = {
        deyAc,
        funAc
    }
    self:runAction(CCSequence:create(Arc))
end

function DatingScriptView:hideName(deyTime)

    deyTime = deyTime or 0

    if self.isSkip and not self.isAuto then
        self.Image_nameBottom:setOpacity(0)
        self.Image_nameBottom:hide()
        --self.name:setOpacity(0)
        return
    end

    self.Image_nameBottom:fadeOut(deyTime)

    local acArrOut = TFVector:create()
    local deyAc = DelayTime:create(deyTime)
    local fadeOut = CCFadeOut:create(0.2)
    local moveOut = MoveTo:create(0.2, self.name.pos - ccp(20, 0))
    local spawnArr = { moveOut, fadeOut }

    local calFun = CCCallFunc:create(function()
        self.Image_nameBottom:hide()
    end)
    local spawn = CCSpawn:create(spawnArr)

    acArrOut:addObject(deyAc)
    acArrOut:addObject(calFun)
    acArrOut:addObject(spawn)
    self.Image_nameBottom:runAction(CCSequence:create(acArrOut))
end

function DatingScriptView:stopNovoice()
    for k, v in pairs(self.npcData_) do
        local elvesNpc = v
        if elvesNpc then
            if not elvesNpc.stopNovoice then
                elvesNpc = nil
            else
                elvesNpc:stopNovoice()
                elvesNpc:stopNovoiceTuZui()
            end
        end
    end
end

function DatingScriptView:showText(deyTime)
    deyTime = deyTime or 0

    if self.itemData.video and #self.itemData.video > 0 then
        -- self:playVideo(self.itemData.video1)
        -- self.itemData.video1 = "0"

        if self.isSkip and not self.isAuto then
            TFAudio.stopAllEffects()
        else
            self:showVideoView()
            self.itemData.video = nil
            return deyTime
        end
    end

    if self.itemData.autoJump then
        self.isJumpOk = false
    end

    if self.isSkip == false then
        self.textarea:fadeOut(0.2)
    end

    if self:checkNpcSpeciaLocation() then
        self.textarea:PosX(self.textarea.savePos.x + 280)
        self.textarea:setWidth(self.textarea.saveSize.width - 280)
        if self.Image_diceng then
            self.Image_diceng:show()
        end
        if self.isDatingFirst then
            self.imageTextBg:setTexture("ui/dating/newDating/content/46.png")
        else
            self.imageTextBg:setTexture("ui/dating/newDating/content/47.png")
        end
    else
        if self.Image_diceng then
            self.Image_diceng:hide()
        end
        self.textarea:PosX(self.textarea.savePos.x)
        self.textarea:setWidth(self.textarea.saveSize.width)
    end

    local time = self:showLabelText(deyTime)
    self.isNotAJ = true
    local function refreshJump()
        self.isNotAJ = nil
        self:stopNovoice()
        local nameSetid = TabDataMgr:getData("DiscreteData", 11003).data["nameSet"];
        local isFubenPass = FubenDataMgr:isPassPlotLevel(FubenDataMgr:getCurLevelCid())
        if self.itemData.id == nameSetid and not self.isModifyName and not isFubenPass and not isScriptTest then
            self.isModifyName = true
            self.showModifyName = true
            self.Panel_lockTouch:show()
            self.isSkip = false
            self.isAuto = false
            self.isJumpOk = false
            self:refreshButtonListState()
            --改名
            Utils:sendHttpLog("role_create_Q")  --引导玩家创建上报
            local modifyNameView = require("lua.logic.playerInfo.ModifyNameView"):new({ function()
                Utils:sendHttpLog("role_created")  --角色改名创建成功上报
                self.showModifyName = false
                self.isJumpOk = true
                self:jumpToNext()
                self.Panel_lockTouch:hide()
            end, true })
            AlertManager:addLayer(modifyNameView)
            AlertManager:show()
        else
            self.isJumpOk = true
            if self.isSkip == true or self.itemData.autoJump then
                self:skipFun()
            end
        end
    end
    local ac = {
        DelayTime:create(time),
        CallFunc:create(refreshJump)
    }
    self:runAction(Sequence:create(ac))
    return time
end

function DatingScriptView:showLabelText(deyTime)

    self:insertPageDanMuData()
    self.textarea:setText("")
    deyTime = deyTime or 0
    if self.itemData.text == "" or self.itemData.isVisibleUI == 1 then
        return deyTime
    end
    local displayScore = self.itemData.displayScore

    if displayScore and displayScore == 1 and self.showScore then
        self.Panel_score:show()
    else
        self.Panel_score:hide()
        self.Panel_score.isHide = true
    end
    local textCopy
    local randMaxIdx = 1
    if self.itemData.radText and #self.itemData.radText ~= 0 then
        randMaxIdx = #self.itemData.radText
    end
    local randIdx = math.random(1, randMaxIdx)
    local cText = ""
    if randIdx == 1 then
        cText = self.itemData.text
    else
        cText = self.itemData.radText[randIdx - 1]
    end
    if isScriptTest then
        textCopy = string.gsub(cText, "%%s", "我");
    else
        textCopy = string.gsub(cText, "%%s", MainPlayer:getPlayerName());
    end

    local leIdxList_, strCopy, deyTimeMap_ = checkSpecText(clone(textCopy), false, true)

    if #leIdxList_ > 0 then
        print("leIdxList_ ", leIdxList_)
        print("self.itemData.text ", self.itemData.text)
    end

    local list, len = Public:stringSplit(strCopy)

    local str = ""
    local time = 0
    local disTime = 0
    if self.isSkip == true and self.isAuto == false then
        time = deyTime
        --disTime = SettingDataMgr:getSpeedSkipVal()
        disTime = 0.003
    else
        time = deyTime
        disTime = SettingDataMgr:getSpeedTextVal()
        if self.autoSpeed ~= 0 then
            disTime = disTime / AUTO_SPEED_VAL[self.autoSpeed]
        end
    end

    local idxLen = 1
    local leIdx = 1
    local isColor = false

    local specTextConfig = self.itemData.specTextConfig

    for i, v in ipairs(list) do
        str = str .. v
        local function dazi()
            local conText = str

            local acc = {
                CCDelayTime:create(time),
                CCCallFunc:create(function()
                    self.textarea:setOpacity(255)
                    self.textarea:setText(conText)

                    for ile = 1, i do                        
                        if specTextConfig then
                            local letter = self.textarea:getLetter(ile - 1)
                            if letter and specTextConfig.scales then
                                for is, vs in ipairs(specTextConfig.scales) do
                                    if ile > vs.start and ile < vs.ends then
                                        letter:Scale(vs.value / self.textDeScale)
                                        --Box("放大" .. vs.value)
                                        --letter:Scale(vs.value)
                                    end
                                end
                            end
                        end
                    end

                    if leIdx <= #leIdxList_ and v == leIdxList_[leIdx].startChr and i == leIdxList_[leIdx].loStartIdx then
                        isColor = true
                    end
                    
                    if isColor then
                        local letter = self.textarea:getLetter(i - 1)
                        if letter then
                            if leIdxList_[leIdx].color then
                                letter:setColor(ccc3(leIdxList_[leIdx].color[1], leIdxList_[leIdx].color[2], leIdxList_[leIdx].color[3]))
                            else
                                letter:setColor(ccc3(255, 222, 52))
                            end
                        end
                    else
                        local letter = self.textarea:getLetter(i - 1)
                        if letter then
                            letter:setColor(ccc3(255, 255, 255))
                        end
                    end

                    if leIdx <= #leIdxList_ and v == leIdxList_[leIdx].endChr and i == leIdxList_[leIdx].loEndIdx then
                        isColor = false
                        leIdx = leIdx + 1
                    end
                end)
            }

            self:runAction(CCSequence:create(acc))
        end
        dazi()
        if not self.itemData.textShowType or self.itemData.textShowType == 1 then
            if (self.isSkip and not isAuto) or self.autoSpeed > 1 then
            elseif deyTimeMap_[i] then
                time = time + deyTimeMap_[i]
            end
            time = time + disTime
        end
    end

    if self.isSkip and self.isAuto then
        if self.autoSpeed == 2 then
            time = time + (#list-15)/15 * 0.3+0.25
        elseif self.autoSpeed == 3 then
        else
            time = time + (#list-15)/15 * 0.3+0.5
        end
    end
    return time
end

function DatingScriptView:playHuiguShader()
    self:playShader(0.0001, 0.0002)
end

function DatingScriptView:checkNpc(isVisible, isClick)
    for k, v in pairs(self.npcData_) do
        v:setVisible(isVisible)
        v.isClick = isClick
    end
end

function DatingScriptView:checkNpcSpeciaLocation()
    for i = 1, 3 do
        local locationId = self.itemData["roleLocation" .. i]
        if locationId == 6 then
            --特殊位置模型
            return true
        end
    end
    for k, v in pairs(self.npcData_) do
        local locationId = v.locationId
        if locationId == 6 then
            --特殊位置模型
            return true
        end
    end
    return false
end

function DatingScriptView:stopNpcVoice()
    --getCurrentEffectID
    for k, v in pairs(self.npcData_) do
        local elvesNpc = v
        if elvesNpc and elvesNpc.type ~= 2 then
            if elvesNpc:getCurrentEffectID(0) then
                print("停止模型自带音效")
                TFAudio.stopEffect(elvesNpc:getCurrentEffectID(0))
            end
        end
    end
end

function DatingScriptView:checkNpcVoice()
    local isHaveNpcVoice = false
    for k, v in pairs(self.npcData_) do
        local elvesNpc = v
        if elvesNpc and elvesNpc.type ~= 2 then
            if elvesNpc:getCurrentEffectTime() > 0 then
                isHaveNpcVoice = true
                break
            end
        end
    end
    return isHaveNpcVoice
end

function DatingScriptView:checkNpcShader()
    local isShowShader = false

    for i, v in ipairs(self.pictureArray) do
        if v:isVisible() then
            isShowShader = true
            break
        end
    end

    for k, v in pairs(self.npcData_) do
        local elvesNpc = v
        if elvesNpc then
            isShowShader = true
            break
        end
    end
    if isShowShader then
        self:playNpcShader()
    else
        self:stopShader()
    end
end

function DatingScriptView:playNpcShader()
    self:playShader(0.00005, 0.0001)
end

function DatingScriptView:playShader(widthOffset, heightOffset)
    self.imageBg:setShaderProgram("Blur", true)
    local _GLProgramState = self.imageBg:getGLProgramState()
    _GLProgramState:setUniformFloat("texelWidthOffset", widthOffset)
    _GLProgramState:setUniformFloat("texelHeightOffset", heightOffset)
end

function DatingScriptView:stopShader()
    self.imageBg:setShaderProgramDefault(true)
end

function DatingScriptView:skipFun()
    if self.isToEnd then
        return
    end
    if self.isShowOption then
        return
    end

    if (self.isSkip and self.isAuto) and (self.isHaveNpcVoice or(self.voiceHandle and self.voiceHandle ~= -1)) and not self.isAuttoJump then
        self.isAuttoJump = true
        return
    end
    self.isAuttoJump = false
    self.isHaveNpcVoice = false
    self.Panel_base:stopAllActions()
    if not self:jumpToNext() and (self.isSkip and not self.isAuto) then
        for i, v in ipairs(self.npcData_) do
            v:setVoiceVolume(1)
        end
        if self.isHaveCg or self.isWaitInterCg then
            self:refreshButtonListState()
            if ( self.itemData.text == "" or self.itemData.text == " " )and not self.isOver then
                self:jumpToNext()
            end
        end
    end
end

function DatingScriptView:refreshButtonListState(selectBtn)
    if (selectBtn and selectBtn.type ~= self.btnType.auto) or not selectBtn then
        self.autoSpeed = 0
    end
    local isShowDanMu = true
    for i, v in ipairs(self.buttonList) do
        local btn = v
        if btn.select then
            if selectBtn then
                btn.select:setVisible(btn == selectBtn and self.selectBtn ~= selectBtn)
                if btn.Label_speed then
                    btn.select:setVisible(self.autoSpeed ~= 0)
                end
            else
                btn.select:hide()
            end
            if btn == self.skipButton and btn.select:isVisible() then
                isShowDanMu = false
            end
        end
    end
    if self.selectBtn == selectBtn then
        self.selectBtn = nil
    else
        self.selectBtn = selectBtn
    end

    if self.selectBtn and self.selectBtn.type == self.btnType.skip then
        self.Image_jiasu:show()
        self.Image_normal:hide()
        self.isSkip = true
    else
        self.Image_jiasu:hide()
        self.Image_normal:show()
        self.isSkip = false
    end

    if (self.selectBtn and self.selectBtn.type == self.btnType.auto) or self.autoSpeed ~= 0 then
        self.isAuto = true
        self.isSkip = true
    else
        self.isAuto = false
    end

    --if isShowDanMu then
        self:jumpDanMu()
    --end
    self:accelerationDanmu(self.autoSpeed)
end

function DatingScriptView:playChangeBgAction(appearType)
    if self.isSkip and not self.isAuto and not appearType then
        if self.itemData.backGround ~="" and tonumber(self.itemData.backGround) ~= 0 and tonumber(self.itemData.backGround) ~= 1 then
            self:refreshBg(self.imageBg, self.itemData.backGround)
            self:stopCg()
        end
        if self.itemData.cg ~="" and tonumber(self.itemData.cg) ~= 0 then
            self:playCg()
        end
        self:showSceneEffect()
        return
    elseif not(self.isSkip and not self.isAuto) then
        self.textarea:setText("")
    end
    local appear = appearType or tonumber(self.itemData.appear)
    if not self.isGameStart then
        if appear ~= 14 then
            appear = -1
        else
            appear = 0
        end

        if self.isNoF and self.itemData.text ~= "" then
            self.isNoFStart = true
        end
        self.isGameStart = true
    else
        self:hideUI(true)
    end

    if appear and appear ~= 0 and not(appear == 1 and self.itemData.cg ~= "") then
        self.skipButton:setTouchEnabled(false)
        self.autoButton:setTouchEnabled(false)
        print("playChangeBgAction appear ",appear)
        local closeCallFunc = function()
            self.changeBgView = nil
            self.skipButton:setTouchEnabled(true)
            self.autoButton:setTouchEnabled(true)
            if appearType then
                for i, v in ipairs(self.npcData_) do
                    v:setVoiceVolume(1)
                end
                self.skipAction = nil

                if self.isOption or self.isHaveCg then
                    self.isOption = falseImage_auto
                    self.isHaveCg = false
                    if not self.itemData.autoJump then
                        self:jumpToNext()
                    end
                end

                self.Panel_main:timeOut(function()
                    if self.isOver then
                        self:showResultLayer()
                    end
                end,0.8)
                return
            end
            if self.isNoFStart then
                self.isNoFStart = nil
                return
            end
            self:jumpToNext()
        end

        self.imageBg.logic = self.npcData_
        print("==========DatingChangeBgView==========")
        local isShowChangeBg = not self:checkSceneEffectSpeBg()
        local changeBgView = require("lua.logic.dating.DatingChangeBgView"):new(self.imageBg, appear, closeCallFunc, handler(self.refreshBgState, self),isShowChangeBg)
        self:addLayerToNode(changeBgView, self.imageBg:getParent());

        if appearType then
            self.skipAction = true
        end


        self.changeBgView = changeBgView

        if self.isNoFStart then
            return
        end

        if appearType then
            return
        else
            return true
        end
    else
        self:refreshBgState(true)
    end
end

function DatingScriptView:refreshBgState(isNoStop)
    self:stopShader()
    if self.itemData.bgManage == 1 then
        self.imageBg:setColor(me.RED)
    elseif self.itemData.bgManage == 2 then
        self.imageBg:setColor(me.GRAY)
    elseif self.itemData.bgManage == 3 then
        if self.maskBlack then
            self.maskBlack:removeFromParent()
            self.maskBlack = nil
        end
        local maskBlack = TFImage:create("ui/dating/other/maskBlack.png")
        if maskBlack then
            maskBlack:setOpacity(0)
            maskBlack:fadeIn(0.5)
            maskBlack:Size(self.imageBg:Size())
            maskBlack:Pos(self.imageBg:Pos())
            self.maskBlack = maskBlack
            self.imageBg:getParent():addChild(maskBlack)
        end
    elseif self.itemData.bgManage == 4 then
        self:playNpcShader()
    else
        if self.maskBlack then
            self.maskBlack:fadeOut(0.5)
            self:timeOut(function()
                if self.maskBlack then
                    self.maskBlack:removeFromParent()
                    self.maskBlack = nil
                end
            end, 0.5)
        end
        self.imageBg:setColor(me.WHITE)
    end
    self.Image_black:setVisible(self.itemData.memory)

    if self.itemData.backGround ~= "" and tonumber(self.itemData.backGround) ~= 0 and tonumber(self.itemData.backGround) ~= 1 then
        self:refreshBg(self.imageBg, self.itemData.backGround)
    end

    self:showSceneEffect()

    if self.itemData.cg == "" and not isNoStop then
        self:stopCg()
    end
    local appear = tonumber(self.itemData.appear)
    if appear == 1 and isNoStop then
        if self.itemData.cg ~= "" and tonumber(self.itemData.cg) ~= 0 then
            self:playCg()
        end
    else
        if self.itemData.cg ~= "" and tonumber(self.itemData.cg) ~= 0 then
            self:playCg()
        elseif not isNoStop then
            self:stopCg()
        end
    end

    local bgTime = 0.2
    if self.itemData.bgTime and self.itemData.bgTime ~= 0 then
        if self.itemData.bgTime == -1 then
            bgTime = 0
        else
            bgTime = self.itemData.bgTime
        end

    end
    local isScaleAction = true
    if not self.itemData.bgScale or self.itemData.bgScale == 0 then
        self.itemData.bgScale = self.imageBg:Scale()
        isScaleAction = false
    end

    print("self.itemData.bgScale ", self.itemData.bgScale)

    if not isNoStop then
        self.imageBg:stopAllActions()
    end

    if self.isSkip and not self.isAuto then
        self.imageBg:setScale(self.itemData.bgScale)
        -- if self.itemData.bgOffset and table.count(self.itemData.bgOffset) > 0 then
        --     self.imageBg:Pos(self.imageBg.savePos.x + self.itemData.bgOffset.x, self.imageBg.savePos.y + self.itemData.bgOffset.y)
        -- else
        --     self.imageBg:Pos(self.imageBg.savePos.x, self.imageBg.savePos.y)
        -- end
        local curPosX, curPosY = self:checkImageBgPos()
        self.imageBg:Pos(curPosX, curPosY)
    else
        if isScaleAction then
            self.imageBg:runAction(CCScaleTo:create(bgTime, self.itemData.bgScale))
        end

        if self.itemData.bgOffset and table.count(self.itemData.bgOffset) > 0 then
            local curPosX, curPosY = self:checkImageBgPos()
            self.imageBg:moveTo(bgTime, curPosX, curPosY)
        else
            local curPosX, curPosY = self:checkImageBgPos()
            --self.imageBg:Pos(curPosX, curPosY)
            self.imageBg:moveTo(bgTime, curPosX, curPosY)
        end
    end
end

function DatingScriptView:checkImageBgPos()
    local curPosX = self.imageBg:Pos().x
    local curPosY = self.imageBg:Pos().y
    local disMaxW = nil
    local disMaxH = nil
    if self.itemData.bgScale then
        local oScale = math.max(GameConfig.WS.width/self.imageBg:Size().width,GameConfig.WS.height/self.imageBg:Size().height)
        disMaxW = math.max((self.itemData.bgScale - oScale) * self.imageBg:Size().width/2,0)
        disMaxH = math.max((self.itemData.bgScale - oScale) * self.imageBg:Size().height/2,0)
    end

    if disMaxW and disMaxH then
        self.itemData.bgOffset = self.itemData.bgOffset or {}
        self.itemData.bgOffset.x = self.itemData.bgOffset.x or curPosX - self.imageBg.savePos.x
        self.itemData.bgOffset.y = self.itemData.bgOffset.y or curPosY - self.imageBg.savePos.y
        local offsetX = math.min(math.abs(self.itemData.bgOffset.x),disMaxW)
        local offsetY = math.min(math.abs(self.itemData.bgOffset.y),disMaxH)
        if self.itemData.bgOffset.x < 0 then
            offsetX = -offsetX
        end
        if self.itemData.bgOffset.y < 0 then
            offsetY = -offsetY
        end
        curPosX = self.imageBg.savePos.x + offsetX
        curPosY = self.imageBg.savePos.y + offsetY
    end
    return curPosX, curPosY
end

function DatingScriptView:refreshBg(imageBg, bgPath)
    if bgPath then
        imageBg:setTexture(bgPath)
    end
    local height = imageBg:Size().height
    local width = imageBg:Size().width
    local scaleDisH = GameConfig.WS.height / height
    local scaleDisW = GameConfig.WS.width / width
    local scale = scaleDisH < scaleDisW and scaleDisW or scaleDisH
    local newWidth = width * scale
    local newHeigth = height * scale
    imageBg.disScale = scale
    imageBg.disSize = imageBg:Size()
    imageBg:setContentSize(CCSizeMake(newWidth, newHeigth))
end

function DatingScriptView:playBgm()

    if self.itemData.video and #self.itemData.video > 1 then
        if self.isStopBgm then
            TFAudio.stopMusic()
        end
        self.Image_black:stopAllActions()
        self.bgm = nil
        return
    end

    if self.itemData.bgmSize and self.itemData.bgmSize ~= 0 then
        local baseVol = SettingDataMgr:getSoundMainVal()
        local bgmVol = SettingDataMgr:getSoundBgmVal()
        TFAudio.setMusicVolume(baseVol * bgmVol * self.itemData.bgmSize / 100)
    else
        --local baseVol = SettingDataMgr:getSoundMainVal()
        --local bgmVol = SettingDataMgr:getSoundBgmVal()
        --TFAudio.setMusicVolume(baseVol * bgmVol)
    end

    if tonumber(self.itemData.bgm) == 0 
        or self.itemData.bgm == "" 
        or (self.bgm and self.bgm == self.itemData.bgm) then
        return
    end

    local outMusicCallBack = function()
        if self.isStopBgm then
            TFAudio.stopMusic()
        end
    end
    local inMusicCallBack = function()
        TFAudio.playBmg(self.bgm, true)
    end

    if tonumber(self.itemData.bgm) == 1 then
        self.Image_black:stopAllActions()
        if self.isSkip and not self.isAuto then
            outMusicCallBack()
        else
            changeBgmVolume(self.Image_black, 0.8, 0.4, 0.8, outMusicCallBack)
        end
        self.bgm = nil
        return
    end

    local dBgm = self.itemData.bgm
    if self.bgm then
        print("changeBgmVolume")
        if self.isSkip and not self.isAuto then
            outMusicCallBack()
            inMusicCallBack()
        else
            changeBgmVolume(self.Image_black, 0.8, 0.4, 0.8, outMusicCallBack, inMusicCallBack)
        end
    else
        --TFAudio.stopMusic()
        TFAudio.playBmg(dBgm, true)
        if self.isSkip and not self.isAuto then
        else
            changeBgmVolume(self.Image_black, 0, 0, 0.8)
        end
    end
    self.bgm = self.itemData.bgm

    print("self.bgm ",self.bgm)
end

function DatingScriptView:playVoice(time)
    time = time or 0
    if self.autoSpeed > 1 or not self.itemData.voice or self.itemData.voice == "" or tonumber(self.itemData.voice) == 0 or (self.isSkip and not self.isAuto) then
        return
    end

    self.Panel_pro:timeOut(function()
        if self.voiceHandle then
            TFAudio.stopEffect(self.voiceHandle)
            self.voiceHandle = nil
        end
        self:stopNpcVoice()
        local voiceName = string.format("sound/role/%s.mp3", self.itemData.voice)
        voiceName = self.itemData.voice
        print("voiceName ", voiceName)
        print("text ",self.itemData.text)
        self.voiceHandle = TFAudio.playVoice(voiceName)
        if self.voiceHandle ~= -1 then
            local baseVol = SettingDataMgr:getSoundMainVal()
            local voiceVol = SettingDataMgr:getSoundVoiceVal()
            AudioEngine:setVolume(self.voiceHandle,baseVol * voiceVol)
            self.isAuttoJump = false
            self.isTouchJump = false
            TFAudio.setFinishCallback(self.voiceHandle,function()
                if tolua.isnull(self ) then return end
                self.isTouchJump = true
                if self.isAuttoJump then
                    if self.skipFun then
                        self:skipFun()
                    end
                else
                    self.isAuttoJump = true
                end
                self.voiceHandle = nil
                if self.stopNovoice then
                    self:stopNovoice()
                end
            end)
        end
    end,time)
end

function DatingScriptView:playSoundEffect(pathName)
    if pathName then
        TFAudio.playSound(pathName)
        return
    end

    if self.autoSpeed > 1 or not self.itemData.soundEffect or self.itemData.soundEffect == "" or tonumber(self.itemData.soundEffect) == 0 or (self.isSkip and not self.isAuto) then
        return
    end
    if self.soundEffectHandle then
        TFAudio.stopEffect(self.soundEffectHandle)
        self.soundEffectHandle = nil
    end

    local soundEffectName = self.itemData.soundEffect
    print("soundEffectName ", soundEffectName)
    self.soundEffectHandle = TFAudio.playSound(soundEffectName)
end

function DatingScriptView:playSceneSoundEffect(pathName)
    if pathName then
        TFAudio.playSound(pathName)
        return
    end

    if tonumber(self.itemData.sceneSoundEffect) == 1 and self.sceneSoundEffectHandle then
        self.Image_black:stopAllActions()
        if self.isSkip and not self.isAuto then
            TFAudio.stopEffect(self.sceneSoundEffectHandle)
            self.sceneSoundEffectHandle = nil
        else
            changeEffectVolume(self.Image_black, 0.8, 0.5, 0.8, function ( ... )
                TFAudio.stopEffect(self.sceneSoundEffectHandle)
                self.sceneSoundEffectHandle = nil
            end)
        end
        return
    end

    if self.autoSpeed > 1 or not self.itemData.sceneSoundEffect or self.itemData.sceneSoundEffect == "" or tonumber(self.itemData.sceneSoundEffect) == 0 or (self.isSkip and not self.isAuto) then
        return
    end

    if self.sceneSoundEffectHandle then
        if self.isSkip and not self.isAuto then
            TFAudio.stopEffect(self.sceneSoundEffectHandle)
            self.sceneSoundEffectHandle = nil
            local sceneSoundEffectName = self.itemData.sceneSoundEffect
            print("sceneSoundEffectName ", sceneSoundEffectName)
            self.sceneSoundEffectHandle = TFAudio.playSound(sceneSoundEffectName,true)
        else
            local handler = self.sceneSoundEffectHandle
            changeEffectVolume(self.Image_black, 0.8, 0.5, 0.8, function ( ... )
                TFAudio.stopEffect(handler)
                self.sceneSoundEffectHandle = nil
            end, function ( ... )
                local sceneSoundEffectName = self.itemData.sceneSoundEffect
                print("sceneSoundEffectName ", sceneSoundEffectName)
                self.sceneSoundEffectHandle = TFAudio.playSound(sceneSoundEffectName,true)
            end)
        end
    else
        --TFAudio.stopMusic()
        local sceneSoundEffectName = self.itemData.sceneSoundEffect
        print("sceneSoundEffectName ", sceneSoundEffectName)
        self.sceneSoundEffectHandle = TFAudio.playSound(sceneSoundEffectName,true)
        if self.isSkip and not self.isAuto then
        else
            changeEffectVolume(self.Image_black, 0, 0, 0.8)
        end
    end
end

function DatingScriptView:playCg()
    local appear = tonumber(self.itemData.appear)
    if appear == 1 then

    else
        self:stopCg()
    end

    local id = self.itemData.cg
    if not id or #id == 0 then
        return
    end

    if not self.skipButton.isHide then
        self.skipButton:show()
    end

    local bgPath = self.itemData.backGround
    local islockTouch = self.itemData.dataType == 2 and true or false
    local cgCallBack
    if islockTouch then
        cgCallBack = function()
            self.cgView = nil
            self.ui:timeOut(function()
                self:showButtonList(0.5)
            end, 2)
            self:jumpToNext()

        end
    else
        self:showButtonList(3)
    end

    local lastCgView = self.cgView
    self.Panel_danMuOption:setVisible(false)
    self:setDanMuPannelVisible(false)
    self.cgView = require("lua.logic.common.CgView"):new(id, bgPath, islockTouch, cgCallBack)
    self:addLayerToNode(self.cgView, self.imageBg:getParent());
    self:resetCTLZOrder()
    local ws = GameConfig.WS
    self.cgView:PosX((1136-ws.width)/2)
    if appear == 1 then
        local time = 1
        self.cgView:setOpacity(0)
        self.cgView:fadeIn(time)
        if lastCgView then
            lastCgView:timeOut(function()
                if lastCgView then
                    lastCgView:removeFromParent()
                end
            end,time)
        end
    end
end

function DatingScriptView:startMiniGame()
    if not self.itemData.game or self.itemData.game == 0 then
        return false
    end
    local config = self.itemData.gameRules
    self.isSkip = false
    self.isAuto = false
    self:refreshButtonListState()

    cityController:jumpToFun(self.itemData.game,{id = self.id})

    self.Panel_lockTouch:show()
    local jumpTable = nil
    if self.itemData.game == 5 then
        if self.optionList then
           for i, v in ipairs(self.optionList) do
               local branchNode = v
               if branchNode.datingId == self.id then
                   jumpTable = branchNode.nextNodeIds
                   break
               end
           end
        end

        jumpTable = jumpTable or self.itemData.jump
        print("startMiniGame jumpTable", jumpTable, self.id)
        DatingDataMgr:saveMiniGameOption(jumpTable, self.id)
        print("config ", config)
        local gameRules = self.itemData.gameRules or {intent = 700004, number = 1, times = 60, gashapon = 1 }
        CatchDollDataMgr:goCatchDoll({ isCollect = true, gameConfig = gameRules, isDating = true })
    elseif self.itemData.game == 6 then

        if self.optionList then
            for i, v in ipairs(self.optionList) do
                local branchNode = v
                if branchNode.datingId == self.id then
                    jumpTable = branchNode.nextNodeIds
                    break
                end
            end
        end

        jumpTable = jumpTable or self.itemData.jump
        DatingDataMgr:saveMiniGameOption(self.itemData.jump, self.id)

        local gameRules = self.itemData.gameRules
        if gameRules then
            local uiName = "courage."..gameRules.game
            if uiName == "courage.CourageDirGame" then
                local layer = require("lua.logic.courage.CourageDirGame"):new(gameRules)
                AlertManager:addLayer(layer, AlertManager.BLOCK)
                AlertManager:show()
            else
                Utils:openView(uiName,gameRules)
            end
        end
    end
    return true
end

function DatingScriptView:showButtonList(time)
    if self.interCgView or self.isWaitInterCg then
        return
    end

    self.skipButton:fadeIn(time)
    self.autoButton:fadeIn(time)
    self.reviewButton:fadeIn(time)
    self.Button_camera:fadeIn(time)
    self.setButton:fadeIn(time)
    self:setButtonListTouchState(true)
end

function DatingScriptView:hideButtonList(time)
    self.skipButton:fadeOut(time)
    self.autoButton:fadeOut(time)
    self.reviewButton:fadeOut(time)
    self.Button_camera:fadeOut(time)
    self.setButton:fadeOut(time)

    self:setButtonListTouchState(false)
end

function DatingScriptView:stopCg()


    local barrageCfg = TabDataMgr:getData("Barrage")[self.curScript.datingRuleCid]
    if barrageCfg and barrageCfg.barrageType == EC_DanmuType.Dating then
        local selectImg = self.skipButton.select
        local visible = selectImg:isVisible()
        if not visible then
            --self:setDanMuPannelVisible(true)
            self:setDanMuPannelVisible(false)
        end
        --self.Panel_danMuOption:setVisible(true)
        self.Panel_danMuOption:setVisible(false)
    end

    if self.cgView then
        self.cgView:removeFromParent()
        self.cgView = nil
    end
end

function DatingScriptView:showImageTextBg(time, deyTime)
    deyTime = deyTime or 0
    time = time or 1

    self.ui:timeOut(function()

        self.Panel_pro:fadeIn(time)
        if self.phoneSK then
            self.phoneSK:fadeIn(time)
        end

        self.imageTextBg:stopAllActions()
        self.imageTextBg:fadeIn(time)

        self.Image_diceng:stopAllActions()
        self.Image_diceng:fadeIn(time)

        self.setButton:stopAllActions()
        self.setButton:fadeIn(time)

        self.reviewButton:stopAllActions()
        self.reviewButton:fadeIn(time)

        if self.isWaitInterCg or self.interCgView then
            return
        end
        self.skipButton:Touchable(true)
        self.autoButton:Touchable(true)
        self.Button_camera:Touchable(true)
    end, deyTime)
    return deyTime + time
end

function DatingScriptView:hideImageTextBg(time)
    time = time or 1
    self.imageTextBg:stopAllActions()
    self.imageTextBg:fadeOut(time)

    self.Image_diceng:stopAllActions()
    self.Image_diceng:fadeOut(time)

    self.setButton:stopAllActions()
    self.setButton:fadeOut(time)

    self.reviewButton:stopAllActions()
    self.reviewButton:fadeOut(time)

    self.skipButton:Touchable(false)
    self.autoButton:Touchable(false)
    self.Button_camera:Touchable(false)
end

function DatingScriptView:jumpToNext()
    if self.isToEnd then
        return
    end

    if self.isSending and self.waitSendRsp then
        return
    end

    self.imageTextBg.mask:hide()
    self:stopNovoice()
    -- self:hidePicture()
    self:resetPos()
    if self.showModifyName then
        return
    end
    if not self.itemData then
        Box("ggnot found 剧本 ID:" .. tostring(self.id))
        return
    end

    if self.isShowOption then
        self.isShowOption = false
        if self.isSkip then
            self:skipFun()
            return
        end
    end

    self.isJumpOk = false
    if self:checkEnd(self.itemData.jump) == true then
        self.isOver = true
        self.isJumpOk = false
        self.Panel_lockTouch:show()
        if not self.skipAction then
            self:showResultLayer()
        end
        return false
    end
    if table.count(self.itemData.jump) == 0 and self.interCgView then
        self:changeInterAreaState(true)
        return false
    end
    if self:startMiniGame() then
        return false
    end
    if #self.itemData.jump > 1 or self.itemData.optionType == 5 or self.itemData.optionType == 4 then
        if self.itemData.optionType == 7 then
            for j,l in ipairs(self.itemData.jumpConfig.autoSelect) do
                if l.id == 0 or GoodsDataMgr:getItemCount(l.id) > 0 then
                    self:sendDialogueMsg(l.jump)
                    self.id = l.jump
                    self.lastItemData = clone(self.itemData)
                    if not self:getItemData(self.id) or self.id == -1 then
                        self:closeBtnClickHandle()
                        return
                    end
                    self.itemData = {}
                    self.itemData.jump = { l.jump }
                end
            end
            self:jumpToNext()
            return false
        end

        if self.itemData.optionType == 8 then
            local letterView = require("lua.logic.dating.DatingLetterOptionView"):new(self.itemData.jumpConfig,self.isDatingFirst, function ( id )
                self:sendDialogueMsg(id)

                self.id = id
                if self.id == -1 then
                    self:closeBtnClickHandle()
                    return
                end

                self.itemData = {}
                self.itemData.jump = { id }

                self:jumpToNext()
            end)
            letterView:setPositionX((1136 - GameConfig.WS.width )/2)
            letterView:setZOrder(10)
            self:addLayerToNode(letterView, self.Panel_optionView)
            return false
        end

        self.imageTextBg:setTexture("ui/dating/newDating/content/034.png")
        if self.optionList then
            local isShowD = false
            for i, v in ipairs(self.optionList) do
                local branchNode = v
                if branchNode.datingId == self.id then
                    self:showOptionView(branchNode.nextNodeIds)
                    isShowD = true
                    break
                end
            end
            if not isShowD then
                self:showOptionView() --容错处理服务器和客户端配置不一致时
            end
        elseif self.optionActType then
            self:showOptionView()
            if self.optionActType == 1 then
                NewCityDataMgr:sendGetEntranceEventChoices(self.id, EC_DatingChoiceType.ChoiceScript)
            end
        end
        return false
    else
        if self.isDatingFirst then
            self.imageTextBg:setTexture("ui/dating/newDating/content/034.png")
        else
            self.imageTextBg:setTexture("ui/dating/newDating/content/021.png")
        end
        self.id = self.itemData.jump[1]
        self.lastItemData = clone(self.itemData)
        if not self:getItemData(self.id) then
            Box("ssnot found 剧本 ID:" .. tostring(self.id) .. "from" .. self.scriptTableName)
            return
        end
        self.itemData = clone(self:getItemData(self.id))

        self.isHaveCg = false
        self.isOption = false

        if self.itemData and #self.itemData.jump > 1 or self.itemData.optionType == 5 then
            self.isOption = true
        elseif SettingDataMgr:getCgSkipVal() ~= 1 then
            if self.itemData  
                and self.itemData.cg ~= "" 
                and tonumber(self.itemData.cg) ~= 0 
                and not self.cgView then
                self.isHaveCg = true
            end
        end

        local isSkipStop = false
        if self.isHaveCg then
            isSkipStop = true
        end

        local jumpData = self.itemData.jump[1] and clone(self:getItemData(self.itemData.jump[1]))
        if jumpData and jumpData.jumpConfig and jumpData.jumpConfig.cg then
            isSkipStop = true
            self.isWaitInterCg = true
            self.skipButton:hide()
            self.autoButton:hide()
            self.Button_camera:hide()
            self:hideButtonList(0)
            self:refreshButtonListState()
        end

        if self.itemData.text and self.itemData.text ~= "" and self.itemData.isVisibleUI ~= 1 then
            table.insert(self.reviewTable, self.id)
        end
        self:playBgm()
        self:playSoundEffect()
        self:playSceneSoundEffect()
        self:changeTextBottom()
        self:playShakyAction()
        if self.interCgView then
            self.interCgView:playAnimation(self.itemData.jumpConfig.interCgAction)
        end
        if self.itemData.name == "" then
            self:hideName()
        end
        local deyTime = self:changeElvesNpcShow()

        local isChangeOk = self:playChangeBgAction()
        self:resetCTLZOrder()
        if isChangeOk then
            self:playVoice()
            return not isSkipStop
        end

        self:checkPhone()
        self:checkPhoneDating()
        self:playVoice(deyTime)
        self:showPicture()

        local textDisTime = deyTime
        if self.itemData.isVisibleUI == 1 then
            self:hideUI()
            print("=============",self.itemData.isVisibleUI,"=============")
        else
            textDisTime = self:showUI(deyTime)
        end
        if self.lastItemData.name ~= self.itemData.name then
            self:hideName()
            if self.itemData.name ~= "" then
                self:showName(deyTime)
            end
        end
        if self.talkView then
            self.talkView:removeEvents()
            self.talkView:removeFromParent(true)
            self.talkView = nil
        end

        if self.itemData.dialogScriptId then -- dialog 对话
            local param = {
                groupid = self.itemData.dialogScriptId,
                isHideSkip = true,
                callback = function ()
                    self:jumpToNext()
                end,
            }
            self.talkView = requireNew("lua.logic.talk.TalkMainLayer"):new(param)
            self.talkView:setPositionX((1136 - GameConfig.WS.width )/2)
            self.Panel_optionView:addChild(self.talkView)
            return false
        end

        self:showText(textDisTime)

        return not isSkipStop
    end
end

function DatingScriptView:showDatingReverseLayer()
    Utils:openView("dating.DatingReverseLayer")
    AlertManager:closeLayer(self)
end

function DatingScriptView:saveReview()
    if self.saveNotFinishDatingInfo then
        DatingDataMgr:saveReviewTable(self.reviewTable, DatingConfig.ReviewKey.YUEHUI_KEY, self.datingType)
    end
end

function DatingScriptView:checkPhoneDating()

    if self.itemData and self.itemData.nameId and self.itemData.nameId ~= 0 then
        self.Image_datingPhone:setVisible(true)
        if not self.phoneShaking then
            self.Spine_Datingphone:play("animation2",true)
            self.phoneShaking = true
        end
    else
        self.phoneShaking = false
        self.Image_datingPhone:setVisible(false)
        self.Spine_Datingphone:play("animation",true)
        self.Image_datingPhone:setVisible(false)
    end
end

function DatingScriptView:checkPhone()
    if self.itemData then
        self.itemData.phonePath = self.itemData.phonePath or ""
        local pTag = tonumber(self.itemData.phonePath)
        if pTag then
            if pTag == 0 then
                self:hidePhone()
            end
        else
            if self.phoneSK then
                self:hidePhone(true)
            else
                self:showPhone()
            end
        end
    end
end

function DatingScriptView:checkEnd(nextidTable)
    if table.count(nextidTable) == 0 and not self.interCgView then
        self.isToEnd = true
    else
        self.isToEnd = false
    end
    return self.isToEnd
end

function DatingScriptView:onClickPanelTouchLayer(btn)

    if self.Button_camera.isClick == false then
        self:checkNpc(true, true)
        return
    end

    --if self.isJumpOk == true and not self.isSkip and not self.isAuto then
    if self.isJumpOk and not self.isSkip and not self.isAuto then
        self:stopAllActions()
        self:jumpToNext()
    end
end

function DatingScriptView:closeBtnClickHandle(btn)
    --暂时只保留 新的主线约会未完成过一次，日常约会 情况返回记录未完成状态
    if self.saveNotFinishDatingInfo then
        DatingDataMgr:addNotFinishDatingInfo(self.score, self.datingType, self.currentNodeId, self.optionList, self.currentNodeId, nil, self.curScript.datingRuleCid,self.isDatingFirst)
    end
    AlertManager:closeLayer(self)
end

function DatingScriptView:hideUI(isShowClose)
    if self.itemData.isVisibleUI == 1 then
        self.textarea:setText("")
    end
    self:hideImageTextBg(0.3)
    if self.itemData.isVisibleUI ~= 1 and not isShowClose then
        --self.closeBtn:hide()
        --self.Image_mainStar:hide()
        --self.Panel_pro:hide()
        self.Panel_pro:fadeOut(0.5)
        if self.phoneSK then
            self.phoneSK:fadeOut(0.5)
        end
    end
end

function DatingScriptView:showUI(deyTime)
    local time = self:showImageTextBg(0.3, deyTime)
    if not self.closeBtn.isHide and not self.gIsStart then
        self.closeBtn:setVisible(true and (not (self.noExitBtn and self.isDatingFirst))and (not self.alwayNoExitBtn))
    end
    --self.Image_mainStar:show()
    if not self.Panel_score.isHide then
        self.Panel_score:show()
    end
    if self.isSkip and not self.isAuto then
        return
    end
    return time
end

function DatingScriptView:showResultLayer()
    print(" self.npcData_ ",self.npcData_)
    self:changeElvesNpcShow()
    self:stopAllActions()
    self.Panel_main:stopAllActions()
    self.isOver = nil
    local uState = EC_CityDatingState.noDating
    if self.curScript.datingRuleCid and DatingDataMgr:getCityDatingInfoByRuleCid(self.datingType, self.curScript.datingRuleCid) then
        uState = DatingDataMgr:getCityDatingInfoByRuleCid(self.datingType, self.curScript.datingRuleCid).uState or EC_CityDatingState.overtime
    end
    if self.resultActionType == 1 then -- 城建数据刷新
        NewCityDataMgr:sendChooseEntranceEvent(self.id, EC_DatingChoiceType.ChoiceScript)
    elseif self.resultActionType == 2 then -- 限时约会，触发约会解决根据状态处理
        if self.datingState == EC_DatingScriptState.TRIGGER then
            self:showDatingReverseLayer()
        elseif (uState == EC_CityDatingState.overtime or uState == EC_CityDatingState.noDating) then
            print("过期约会结局",uState)
            self:showComplete()
        else
            self:sendDialogueMsg()
        end
    elseif self.resultActionType == 3 then -- 直接通知完成，并关闭界面
            EventMgr:dispatchEvent(EV_FUBEN_PHASECOMPLETE)
            AlertManager:closeLayer(self)
    elseif self.resultActionType == 4 then -- 发送数据验证
        self:sendDialogueMsg()
    else
        self:showComplete()
    end
end

function DatingScriptView:onDelectCityDating(datingRuleCid)
    if self.curScript.datingRuleCid and self.curScript.datingRuleCid == datingRuleCid then
        self:showObsolete()
    end
end

function DatingScriptView:showObsolete()
    if self.obsoleteTips then
        return
    end
    if self.show_obsolete then
        self.obsoleteTips =  Utils:showTips(900823)
        self.ui:timeOut(function()
            AlertManager:closeLayer(self)
        end,0.3)
    end
end

function DatingScriptView:completeBack(obsolete)
    self:onCloseInputLayer()
    if isScriptTest then
        AlertManager:closeLayer(self)
        return
    end

    if obsolete and self.show_obsolete then
        print("completeBack obsolete ",obsolete)
        self:showObsolete()
        return
    end
    local layer,time = self:createResultView(nil,0)
    self.ui:timeOut(function()
        AlertManager:closeLayer(self)
    end, time)
end

function DatingScriptView:createResultView( _data, time)
    local layer = nil
    if not self.finallyType then return layer,time end


    if self.finallyType == 0 then -- 显示好感度，心情值
        self.datas = {}
        local sMsg = DatingDataMgr:getDatingSettlementMsg() or {}
        if sMsg.cgs then
            for i, v in ipairs(sMsg.cgs) do
                v.type = "cg"
                table.insert(self.datas, v)
            end
        end

        if sMsg.dressData then
            for i, v in ipairs(sMsg.dressData) do
                v.type = "dress"
                table.insert(self.datas, v)
            end
        end
        -- 活得物品，解锁cg展示
        local disTime = 0.5
        local acArr = TFVector:create()
        if sMsg.goods and #sMsg.goods ~= 0 then
            local rewardView = nil
            local showRewardCallBack = CCCallFunc:create(function()
                rewardView = Utils:openView("bag.GetItemView", sMsg.goods)
            end)
            acArr:addObject(showRewardCallBack)
            local deyTime = CCDelayTime:create(disTime)
            acArr:addObject(deyTime)
            local removeRewardCallBack = CCCallFunc:create(function()
                AlertManager:closeLayer(rewardView)
            end)
            acArr:addObject(removeRewardCallBack)
            time = time + disTime
        end

        if #self.datas ~= 0 then
            local cgItemView = nil
            local showCgItemViewCallBack = CCCallFunc:create(function()
                cgItemView = Utils:openView("common.GetCgItemView", self.datas)
            end)
            acArr:addObject(showCgItemViewCallBack)
            local deyTime = CCDelayTime:create(disTime)
            acArr:addObject(deyTime)
            local removeCgItemViewCallBack = CCCallFunc:create(function()
                AlertManager:closeLayer(cgItemView)
            end)
            acArr:addObject(removeCgItemViewCallBack)
            time = time + disTime
        end

        local favorAndMoodView = nil
        local deyTime1 = CCDelayTime:create(disTime)
        acArr:addObject(deyTime1)
        local showFavorAndMoodViewCallBack = CCCallFunc:create(function()
            local data = {}
            data.lastRoleInfo = self.useRoleInfo
            data.roleId = self.roleId
            favorAndMoodView = Utils:openView("common.FavorAndMoodView", data)
        end)
        acArr:addObject(showFavorAndMoodViewCallBack)
        -- local deyTime2 = CCDelayTime:create(2*disTime)
        -- acArr:addObject(deyTime2)

        -- local removeFavorAndMoodViewCallBack = CCCallFunc:create(function()
        --     if favorAndMoodView then
        --         AlertManager:closeLayer(favorAndMoodView)
        --     end
        -- end)
        -- acArr:addObject(removeFavorAndMoodViewCallBack)

        self:runAction(CCSequence:create(acArr))
        time = time + disTime + 0.1
    elseif self.finallyType == 1 then -- 正常结算
        local levelCid = FubenDataMgr:getCurLevelCid()
        if levelCid then
            local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
            if levelCfg then
                if levelCfg.dungeonType == EC_FBLevelType.THEATER_DATING 
                    or levelCfg.dungeonType == EC_FBLevelType.KUANGSAN_DATING then
                    layer = Utils:openView("battle.TheaterDatingResultView", levelCid)
                    FubenDataMgr:setCurLevelCid(nil)
                    return layer,time
                end
            end
        end
        local data = {}

        if self.callSynopsis == 1
            or self.callSynopsis == 4 then
            local msg = DatingDataMgr:getDatingSettlementMsg()
            data.rewards = msg.goods or {}
            data.cgs = msg.cgs or {}
            local roleId = DatingDataMgr:getDatingRuleRoleId(self.curScript.datingRuleCid) or RoleDataMgr:getCurId()
            local useRoleInfo = clone(RoleDataMgr:getRoleInfo(roleId))
            data.addFavor = msg.favor or useRoleInfo.favor - self.useRoleInfo.favor
            data.addMood = msg.mood and msg.mood or 0
            data.endId = msg.endId
        elseif self.callSynopsis == 2 
            or self.callSynopsis == 3 then
            local settlement = NewCityDataMgr:getTempScriptSettlement()
            data.rewards = settlement.finalReward or {}
            data.cgs = settlement.finalCgs or {}
            data.addFavor = 0
            data.addMood = 0
            data.endId = settlement.endId
            for k,v in pairs(data.rewards) do
                if v.id == EC_SItemType.CURFAVOR or v.id == EC_SItemType.FUBENFAVOR then
                    data.addFavor = data.addFavor + v.num
                end
                if v.id == EC_SItemType.CURMOOD then
                    data.addMood = data.addMood + v.num
                end
            end
        end
        data.pathName = self.imageBg:getTexture()

        layer = Utils:openView("dating.SettlementLayer", data)
    elseif self.finallyType == 3 then -- 弹出奖励
        local msg = DatingDataMgr:getDatingSettlementMsg() or {}
        if msg.goods then
            Utils:showReward(msg.goods)
        end
    end
    return layer,time
end

function DatingScriptView:onRefreshScore(data)
    self.isSending = false
    if self.waitSendRsp then
        self.jumpToNext()
    end
    if data.score then
        self:changeScore(data.score)
    end
end

function DatingScriptView:onSettlement(obsolete)
    -- if not self.showCompleteAni then
    --     EventMgr:dispatchEvent(EV_FUBEN_PHASECOMPLETE)
    --     AlertManager:closeLayer(self)
    -- else
        self:showComplete(obsolete)
    -- end

end

function DatingScriptView:onDatingFail()
    self.isSkip = false
    self.isAuto = false
    Utils:openView("dating.DatingFailView", function()
        AlertManager:closeLayer(self)
    end)
end

function DatingScriptView:onDatingScriptChoiceResult(quality)
    self.isSending = false

    if self.waitSendRsp then
        self.jumpToNext()
    end

    print("onDatingScriptChoiceResult quality ", quality)
    local changeFlag = false
    if self.showScore then
        changeFlag = self:updateAttributes(quality)
    end
    if not self.isToEnd then
        return
    end

    local settlement = NewCityDataMgr:getTempScriptSettlement()
    --dump(settlement, "settlement")
    local seqtb = {}
    local showview = nil

    local reward = {}
    if settlement.reward then
        for i, v in ipairs(settlement.reward) do
            table.insert(reward, v)
        end
    end
    if settlement.finalReward then
        for i, v in ipairs(settlement.finalReward) do
            table.insert(reward, v)
        end
    end

    if settlement.cost then
        if settlement.reward then
            settlement.cost.items = settlement.reward
        end
        local step1 = CCCallFunc:create(function()
            showview = Utils:openView("newCity.NewCityEventSettlementView", settlement.cost, false)
        end)
        local step2 = CCCallFunc:create(function()
            AlertManager:closeLayer(showview)
        end)
        table.insert(seqtb, step1)
        table.insert(seqtb, DelayTime:create(3))
        table.insert(seqtb, step2)
        table.insert(seqtb, DelayTime:create(0.2))
    else
        if settlement.reward then
            if (#settlement.reward > 0) and not settlement.finalReward then
                local step3 = CCCallFunc:create(function()
                    showview = Utils:openView("newCity.NewCityRewardView", settlement.reward, false)
                end)
                local step4 = CCCallFunc:create(function()
                    AlertManager:closeLayer(showview)
                end)
                table.insert(seqtb, step3)
                table.insert(seqtb, DelayTime:create(3))
                table.insert(seqtb, step4)
                table.insert(seqtb, DelayTime:create(0.2))
            end
        end

        if changeFlag then
            local step5 = CCCallFunc:create(function()
                showview = Utils:openView("dating.DatingQualityView")
            end)
            local step6 = CCCallFunc:create(function()
                AlertManager:closeLayer(showview)
            end)
            table.insert(seqtb, step5)
            table.insert(seqtb, DelayTime:create(3))
            table.insert(seqtb, step6)
            table.insert(seqtb, DelayTime:create(0.2))
        end
    end

    if settlement.finalCgs then
        -- local step5 = CCCallFunc:create(function()
        --     showview = Utils:openView("common.DatingRewardView", { cgData = settlement.finalCgs[1] })
        -- end)
        -- local step6 = CCCallFunc:create(function()
        --     AlertManager:closeLayer(showview)
        -- end)
        -- table.insert(seqtb, step5)
        -- table.insert(seqtb, DelayTime:create(3))
        -- table.insert(seqtb, step6)
    end

    if settlement.finalReward then
        local step5 = CCCallFunc:create(function()
            showview = self:createResultView(quality,0)
           end)
        table.insert(seqtb, step5)
    else
        table.insert(seqtb, CCCallFunc:create(function()
            if NewCityDataMgr:isHaveScriptFinishCallBack() then
                self:timeOut(function()
                    NewCityDataMgr:checkScriptFinishCallBack()
                end, 0.5)
            else
                if self.isStopBgm then
                    TFAudio.stopMusic()
                end
                AlertManager:closeAllToLayer(self)
            end
        end))
    end

    self.ui:runAction(CCSequence:create(seqtb))
end

function DatingScriptView:onMiniGameCloseInfo(datingId)

    self.Panel_lockTouch:hide()
    if datingId then
        print("onMiniGameCloseInfo datingId",datingId)
        self.id = datingId
        --Box("self.id " .. self.id)
        --self.itemData = clone(self.data[self.id])
        self.itemData = {}
        self.itemData.jump = { self.id }

        self:jumpToNext()
    end
end

function DatingScriptView:getItemData( id )
    local itemData = self.data[id]
    if itemData then
        itemData.name = itemData.name or ""
        itemData.bgm = itemData.bgm or ""
        itemData.backGround = itemData.backGround or ""
        itemData.cg = itemData.cg or ""
        itemData.text = itemData.text or ""
        itemData.jump = itemData.jump or {}
    end
    return itemData
end

function DatingScriptView:onShow()
    --self.super.onShow(self)
end

function DatingScriptView:onLogin()
    self:refreshButtonListState()
    -- body
    DatingDataMgr:getNotFinishDatingInfoByType(self.curScript.datingType,self.curScript.datingRuleCid,nil,true)
    self:initScriptData()
    self.isShowOption = false
    self.optionView:hideOption()
    self.isGameStart = false
    if self.talkView then
        self.talkView:removeEvents()
        self.talkView:removeFromParent(true)
        self.talkView = nil
    end
    self:loading()
end

function DatingScriptView:overGame()

    self.Panel_lockTouch:hide()
    local miniGameOption = DatingDataMgr:getMiniGameOption()
    local gameResult = CourageDataMgr:getMiniGameResult()
    dump("overGame:"..tostring(gameResult))
    local jumpId = gameResult and miniGameOption[1] or miniGameOption[2]

    dump(self.itemData.id,jumpId)
    self:sendDialogueMsg(jumpId)
    self.lastItemData = clone(self.itemData)
    if not self:getItemData(self.id) or self.id == -1 then
        self:closeBtnClickHandle()
        return
    end
    self.itemData = {}
    self.itemData.jump = { jumpId }
    self:jumpToNext()
    DatingDataMgr:saveMiniGameOption()
end

--注册事件
function DatingScriptView:registerEvents()

    EventMgr:addEventListener(self, EV_COURAGE.EV_MINIGAME_DATING_RESULT, handler(self.overGame, self))

    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshScore, handler(self.onRefreshScore, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshSettlement, handler(self.onSettlement, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.datingFail, handler(self.onDatingFail, self))

    EventMgr:addEventListener(self, EV_NEWCITY_DATING_EVENT.ScriptChoiceResult, handler(self.onDatingScriptChoiceResult, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.miniGameCloseInfo, handler(self.onMiniGameCloseInfo, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.delectCityDating, handler(self.onDelectCityDating, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.onLogin, handler(self.onLogin, self))

    --EventMgr:addEventListener(self, EV_DANMU_SEND, handler(self.insertDanMu, self))

    --EventMgr:addEventListener(self, EV_DANMU_SEND, handler(self.insertDanMu, self))

    self.skipButton:onClick(function()
        self:refreshButtonListState(self.skipButton)
        if self.isSkip and not self.isAuto and not(#self.itemData.jump > 1 or self.itemData.optionType == 5)  then
            --self:playChangeBgAction(-2)
            --self.skipButton:hide()
            self:stopAllActions()
            for i, v in ipairs(self.npcData_) do
                v:setVoiceVolume(0)
            end
        end
        --self:jumpDanMu()
        self:skipFun()
    end)

    self.autoButton:onClick(function()
        local Image_autoSpeed1 = TFDirector:getChildByPath(self.autoButton.select,"Image_autoSpeed1"):hide()
        local Image_autoSpeed2 = TFDirector:getChildByPath(self.autoButton.select,"Image_autoSpeed2"):hide()
        local Image_autoSpeed3 = TFDirector:getChildByPath(self.autoButton.select,"Image_autoSpeed3"):hide()
        if self.autoSpeed >= 3 then
            self.autoSpeed = 0
            self.autoButton.Label_speed:hide()
            self:refreshButtonListState()
        else
            self.autoSpeed = self.autoSpeed + 1
            self:refreshButtonListState(self.autoButton)
            --self.autoButton.Label_speed:show()
            --self.autoButton.Label_speed:setText("x" .. tostring(self.autoSpeed))

            if self.autoSpeed == 1 then
                Image_autoSpeed1:show()
            elseif self.autoSpeed == 2 then
                Image_autoSpeed2:show()
            elseif self.autoSpeed == 3 then
                Image_autoSpeed3:show()
            end
        end
        if not self.isNotAJ and not self.isShowOption then
            self:skipFun()
        end
    end)

    --回顾按钮
    self.reviewButton:onClick(function()
        --
        self:refreshButtonListState()

        --模糊
        self:playHuiguShader()

        self:showReview()

        self.ui:stopAllActions()
        self.imageTextBg:stopAllActions()
        self:hideUI()
        self:checkNpc(false, false)
    end)

    --照相按钮
    self.Button_camera:onClick(function()
        if self.Button_camera.isClick == false then
            return
        end
        self:refreshButtonListState()
        self.Button_camera.isClick = false

        self:hideUI()

        self:checkNpc(true, false)
        for k, v in pairs(self.npcData_) do
            if v.locationId and v.locationId == 6 then
                v:hide()
            end
        end
        self.ui:timeOut(function()
            self.Button_camera.isClick = true

            self:showUI()
            for k, v in pairs(self.npcData_) do
                if v.locationId and v.locationId == 6 then
                    v:show()
                end
            end
        end, 3)

    end)

    self.setButton:onClick(function()
        self:refreshButtonListState(self.setButton)
        Utils:openView("settings.SettingsView")
    end)

    self.Button_datingPhone:onClick(function()
        self:openPhoneDatingView()
    end)

    self.closeBtn:onClick(function()
        if not self.immediateClose or self.immediateClose == 0 then
            if self.isStopBgm then
                TFAudio.stopMusic()
                TFAudio.stopAllEffects()
            end
            self:closeBtnClickHandle()
        else
            showMessageBox(TextDataMgr:getText(self.immediateClose) , EC_MessageBoxType.okAndCancel,function()
                if self.isStopBgm then
                    TFAudio.stopMusic()
                    TFAudio.stopAllEffects()
                end
                GuideDataMgr:setPlotLvlBackState(true)
                FubenDataMgr:setCurLevelCid(nil)
                AlertManager:close()
                AlertManager:closeLayer(self)
            end)
        end
    end)

    self.Button_switch:onClick(function ( ... )

        local isVisible = self.Panel_danmuView:isVisible()

        local texture = "ui/danmu/004.png"
        if not isVisible then
            texture = "ui/danmu/003.png"
        end
        self.Button_switch:setTextureNormal(texture)

        self.isDatingDanMu = not isVisible

        self:setDanMuPannelVisible(not isVisible)
    end)

    local function onTextFieldChangedHandleAcc(input)
        self.inputLayer:listener(input:getText())
    end

    local function onTextFieldAttachAcc(input)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
    end

    self.TextField_danmu:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_danmu:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_danmu:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_talk:onClick(function (  )
        self.TextField_danmu:openIME()
    end)
end

function DatingScriptView:openPhoneDatingView()

    local param = {
        scriptTableName = self.scriptTableName,
        isSkip = self.isSkip,
        isAuto = self.isAuto,
        datingId = self.id
    }

    if self.isAuto and self.isSkip then
        self:refreshButtonListState(self.autoButton)
    end

    if self.isShowOption then
        self.optionView:hideOption()
    end

    local function callback(datingId,isSkip,isAuto)
        self.id = datingId
        self.isSkip = isSkip
        self.isAuto = isAuto
        if self.isAuto and self.isSkip then
            self:refreshButtonListState(self.autoButton)
        end
        self.itemData = clone(self:getItemData(self.id))
        self.Button_datingPhone:stopAllActions()
        self.Image_datingPhone:setVisible(false)
        self:jumpToNext()
    end

    local function updateStep(id)
        if id then
            self:saveReview()
            table.insert(self.reviewTable, id)
        end
    end
    Utils:openView("datingPhone.PhoneDatingView",param,updateStep,callback)
end

--屏幕抖动效果
function DatingScriptView:playShakyAction()
    --windowEfxPara = {
    --    [1] = 延时时间,
    --    [2] = 最小值,
    --    [3] = 最大值,
    --    [4] = 次数,
    --    [5] = 间隔,
    --},
    print("self.itemData.windowEfxPara ", self.itemData.windowEfxPara)
    if not self.itemData.windowEfxPara or #self.itemData.windowEfxPara ~= 5 then
        return
    end
    print("进来了吗")
    local time = self.itemData.windowEfxPara[1]
    local offsetMin = self.itemData.windowEfxPara[2]
    local offsetMax = self.itemData.windowEfxPara[3]
    local count = self.itemData.windowEfxPara[4]
    print("self.itemData.windowEffects ", self.itemData.windowEffects)
    self.ui:timeOut(function()
        local windowEffects = self.itemData.windowEffects or {}
        for i, v in ipairs(windowEffects) do
            local obj
            if v == 0 then
                obj = self.imageBg
            elseif v == 4 then
                obj = self.imageTextBg
            else
                for kNpc, vNpc in pairs(self.npcData_) do
                    if kNpc == "id" .. v and vNpc then
                        obj = vNpc
                        break
                    end
                end
            end
            if obj then
                local seq = self:screenShakeSeq(offsetMin, offsetMax, count)
                local aniArr = {
                    seq
                }
                local aniSeq = CCSequence:createWithTable(aniArr)
                obj:runAction(aniSeq)
            end
        end
    end, time)
end

function DatingScriptView:screenShakeSeq(offsetMin, offsetMax, count)
    local aniArr = {}
    local disTime = self.itemData.windowEfxPara[5]
    print("disTime ", offsetMin)
    print("offsetMin ", offsetMin)
    print("offsetMax ", offsetMax)
    print("count ", count)
    for i = 1, count do
        local x = math.random(offsetMin, offsetMax)
        local y = math.random(offsetMin, offsetMax)
        table.insert(aniArr, CCMoveBy:create(disTime, ccp(x, y)))
        table.insert(aniArr, CCMoveBy:create(disTime, ccp(-x, -y)))
        table.insert(aniArr, CCMoveBy:create(disTime, ccp(-x, -y)))
        table.insert(aniArr, CCMoveBy:create(disTime, ccp(x, y)))
    end
    local seq = CCSequence:createWithTable(aniArr)
    return seq
end

function DatingScriptView:resetPos(obj)
    if self.imageTextBg.savePos then
        self.imageTextBg:Pos(self.imageTextBg.savePos)
    end
end

--移除事件
function DatingScriptView:removeEvents()
    self.super.removeEvents(self)
end

function DatingScriptView:removeUI()
    self.super.removeUI(self)
    SpineCache:getInstance():clearUnused();
    me.TextureCache:removeUnusedTextures()
    EventMgr:dispatchEvent(EV_DATING_EVENT.closeSriptView)
    collectgarbage("collect")

end

function DatingScriptView:onClose()
    --关闭界面时置空回调
    if self.datingType ~= EC_DatingScriptType.FUBEN_SCRIPT then
        DatingDataMgr:setIsDating(false)
    end

    if not tolua.isnull(self.videoView) then
        self.videoView:bindEndCallBack(nil)
    end
    if self.sceneSoundEffectHandle then
        TFAudio.stopEffect(self.sceneSoundEffectHandle)
        self.sceneSoundEffectHandle = nil
    end
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
        self.voiceHandle = nil
    end
    self.ui:stopAllActions()
    self:stopAllActions()
    self.super.onClose(self)
    for k,v in pairs(self.npcData_) do
        v:stopTimer()
    end

end

function DatingScriptView:setDanMuPannelVisible(visible)
    if visible then
        visible = self.isDatingDanMu
    end
    self.Panel_danmuView:setVisible(visible)

end

function DatingScriptView:specialKeyBackLogic( )
    GuideDataMgr:setPlotLvlBackState(true)
    return false
end

function DatingScriptView:setDanMuPannelVisible(visible)
    if visible then
        visible = self.isDatingDanMu
    end
    self.Panel_danmuView:setVisible(visible)

end

return DatingScriptView;
