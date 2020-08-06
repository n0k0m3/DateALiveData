local SettlementLayer = class("SettlementLayer",BaseLayer)
local ElvesNpcTable = require("lua.logic.common.ElvesNpc")

function SettlementLayer:initData(data)
    self.data_ = data
    self.curScript = DatingDataMgr:getCurDatingScript()
    self.roleId = DatingDataMgr:getDatingRuleRoleId(self.curScript.datingRuleCid) or RoleDataMgr:getCurId()
    self.useRoleInfo = clone(RoleDataMgr:getRoleInfo(self.roleId))
    self.datingType = self.curScript.datingType
    self.ruleData = DatingDataMgr:getDatingRuleData(self.curScript.datingRuleCid)
    local styleId = self.datingType*10 
    if self.ruleData and self.ruleData.datingTypeNew then
        styleId = self.ruleData.datingTypeNew
    end
    self.typeMgrCfg = TabDataMgr:getData("DatingTypeMgr")[styleId] or TabDataMgr:getData("DatingTypeMgr")[1000]
    DatingDataMgr:clearDatingSettlementMsg()
    self.mainPageIdx = 0
    self.mainPageOptionList = {}
    self.showType = 1
    self.selectCgIdx = 0
    self.upDuration = true
end

function SettlementLayer:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)
    self:init("lua.uiconfig.dating.settlementLayer")
end

function SettlementLayer:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Image_bg = TFDirector:getChildByPath(self.ui,"Image_bg")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui,"Panel_prefab")
    self.Panel_content = TFDirector:getChildByPath(self.ui,"Panel_content")
    self.Panel_bg = TFDirector:getChildByPath(self.ui,"Panel_bg")
    self.Panel_main = TFDirector:getChildByPath(self.ui,"Panel_main")
    self.Panel_info = TFDirector:getChildByPath(self.ui,"Panel_info")
    self.Panel_pageItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_pageItem")
    self.Image_option = TFDirector:getChildByPath(self.Panel_prefab,"Image_option")
    self.Panel_cgItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_cgItem")

    self.animation_nodes = {}
    self.Image_bg7 = TFDirector:getChildByPath(self.Panel_info,"Image_bg7")
    self.Image_bg8 = TFDirector:getChildByPath(self.Panel_info,"Image_bg8")
    self.Image_bg9 = TFDirector:getChildByPath(self.Panel_info,"Image_bg9")
    self.Image_bg10 = TFDirector:getChildByPath(self.Panel_info,"Image_bg10")
    self.Image_bg11 = TFDirector:getChildByPath(self.Panel_info,"Image_bg11")
    self.Image_bg12 = TFDirector:getChildByPath(self.Panel_info,"Image_bg12")
    self.Image_bg13 = TFDirector:getChildByPath(self.Panel_info,"Image_bg13"):hide()
    self.animation_nodes[1] = self.Image_bg7
    self.animation_nodes[2] = self.Image_bg8
    self.animation_nodes[3] = self.Image_bg9
    self.animation_nodes[4] = self.Image_bg10
    self.animation_nodes[5] = self.Image_bg11
    self.animation_nodes[6] = self.Image_bg12
    --self.animation_nodes[7] = self.Image_bg13

    self.pageView = TFDirector:getChildByPath(self.Panel_main, "PageView_datingLetter")
    self.pageView:setScrollEnabled(false)
    self.page_down = TFDirector:getChildByPath(self.Panel_main, "page_down")
    self.page_up = TFDirector:getChildByPath(self.Panel_main, "page_up")
    self.Panel_option = TFDirector:getChildByPath(self.Panel_main, "Panel_option")
    self.btn_share = TFDirector:getChildByPath(self.Panel_main, "btn_share")
    self.Button_cg_back = TFDirector:getChildByPath(self.Panel_main, "Button_cg_back")

    self.Panel_role_info = TFDirector:getChildByPath(self.Panel_info,"Panel_role_info")
    self.Panel_exp = TFDirector:getChildByPath(self.Panel_info,"Panel_exp"):hide()
    self.Panel_favor = TFDirector:getChildByPath(self.Panel_info,"Panel_favor"):hide()
    self.Panel_mod = TFDirector:getChildByPath(self.Panel_info,"Panel_mod"):hide()
    self.Panel_info_gift = TFDirector:getChildByPath(self.Panel_info,"Panel_info_gift")
    self.Panel_cg = TFDirector:getChildByPath(self.Panel_info,"Panel_cg")

    self.Label_desc = TFDirector:getChildByPath(self.Panel_role_info,"Label_desc")
    self.Image_end_title = TFDirector:getChildByPath(self.Panel_info,"Image_end_title")
    self.Label_cg_page = TFDirector:getChildByPath(self.Panel_info,"Label_cg_page")

    self.Label_favor = TFDirector:getChildByPath(self.Panel_favor,"Label_favor")
    self.Label_mod = TFDirector:getChildByPath(self.Panel_mod,"Label_mod")

    self.ScrollView_gift = TFDirector:getChildByPath(self.Panel_info_gift,"ScrollView_info_gift")
    self.ScrollView_info_gift = UIListView:create(self.ScrollView_gift)
    self.ScrollView_info_gift:setItemsMargin(4)

    self.Panel_touch = TFDirector:getChildByPath(self.ui,"Panel_touch")
    self.Label_continu = TFDirector:getChildByPath(self.ui,"Label_continu")
    Public:BlinkAction(self.Label_continu)
    --记录5星评价
    CommonManager:setStarEvaluateFlage(true)
    self.Panel_main:hide()
    self:initContent()
end

function SettlementLayer:initPanelExpView()
    if self.typeMgrCfg.topLeftPlaneType == 1 then
        self.Panel_exp:setVisible(true)
        self.Label_desc:setVisible(false)
        self.Label_level = TFDirector:getChildByPath(self.Panel_exp,"Label_level")
        self.Label_exp = TFDirector:getChildByPath(self.Panel_exp,"Label_exp")
        self.LoadingBar_hero_exp_white = TFDirector:getChildByPath(self.Panel_exp,"LoadingBar_hero_exp_white")
        self.LoadingBar_hero_exp = TFDirector:getChildByPath(self.Panel_exp,"LoadingBar_hero_exp")
        self.Label_exp_add = TFDirector:getChildByPath(self.Panel_exp,"Label_exp_add")

        local addExp = 0
        if self.data_.rewards then
            for k,v in pairs(self.data_.rewards) do
                if v.id == EC_SItemType.PLAYEREXP then
                    addExp = addExp + v.num
                end
            end
        end
        local curLv = MainPlayer:getPlayerLv()
        local expPercent = MainPlayer:getExpProgress()
        local curExp = MainPlayer:getPlayerExp()
        local curLevelMaxExp = TabDataMgr:getData("LevelUp",curLv).playerExp
        if curLevelMaxExp <= 0 then
            self.Label_exp:setString("MAX")
        else
            self.Label_exp:setString(curExp .."/".. curLevelMaxExp)
        end
        if curLevelMaxExp > 0 and addExp > 0 then
            self.Label_exp_add:setText("(+"..addExp..")")
        else
            self.Label_exp_add:setText("(+0)")
        end
        self.Label_level:setText("Lv."..curLv)

        self.LoadingBar_hero_exp:setPercent(expPercent)
        self.LoadingBar_hero_exp_white:setPercent(expPercent)
        self.LoadingBar_hero_exp.shadowBar = self.LoadingBar_hero_exp_white

        if curLevelMaxExp > 0 and addExp > 0 then
            local lastLvl, lastExp = MainPlayer:getLastLvAndExpByAddExp(addExp)
            local lastPercent = lastExp / TabDataMgr:getData("LevelUp",lastLvl).playerExp * 100
            self.LoadingBar_hero_exp:setPercent(lastPercent)
            self.LoadingBar_hero_exp_white:setPercent(lastPercent)
            self.Label_level:setText("Lv."..lastLvl)
            local offsetLevel = curLv - lastLvl
            local percent = {}
            for i = 1, offsetLevel do
                table.insert(percent, 100)
            end
            table.insert(percent, expPercent)
            local time = #percent > 1 and 0.3 or 0.4
            self:timeOut(function()
                local co
                local function resume()
                    coroutine.resume(co)
                end
                local function yield()
                    coroutine.yield(co)
                end
                local tempLevl = lastLvl
                co = coroutine.create(function()
                    for i, v in ipairs(percent) do
                        Utils:progressToEx(
                            self.LoadingBar_hero_exp,
                            time, v,
                            function()
                                if i < #percent then
                                    self.LoadingBar_hero_exp:setPercent(0)
                                end
                                tempLevl = tempLevl + 1
                                resume()
                            end
                        )
                        tempLevl = math.min(curLv, tempLevl)
                        self.Label_level:setText("Lv."..tempLevl)
                        local curLevelMaxExp = TabDataMgr:getData("LevelUp",tempLevl).playerExp
                        self.Label_exp:setString(curExp .."/".. curLevelMaxExp)
                        yield()
                    end
                end)
                resume()
            end, 1.5)
        end
    else
        self.Panel_exp:setVisible(false)
        self.Label_desc:setVisible(true)
        local tabName = {"DatingProcess","DatingRule","FavorEnd","DatingRule"}
        local cfgData = TabDataMgr:getData(tabName[self.typeMgrCfg.callSynopsis])
        local endId = self.data_.endId
        local descStr
        if self.typeMgrCfg.callSynopsis == 1 then
            local endType = DatingDataMgr:getFinishDayScriptEndType(DatingDataMgr:getFinishDayScriptEndId())
            local endIds = cfgData[self.curScript.datingRuleCid]["end"..endType]
            local descIds = cfgData[self.curScript.datingRuleCid]["end"..endType.."Synopsis"]
            descStr = DatingDataMgr:getEndTypeConfigEndName(endType).."\n"
            for i, v in ipairs(endIds) do
                if v == endId then
                    descStr = descStr..TextDataMgr:getText(descIds[i])
                    break
                end
            end
        elseif self.typeMgrCfg.callSynopsis == 2 then
            descStr = TextDataMgr:getText(cfgData[self.curScript.datingRuleCid].endSynopsis)
        elseif self.typeMgrCfg.callSynopsis == 3 then
            descStr = TextDataMgr:getText(cfgData[endId].endSynopsis)
        elseif self.typeMgrCfg.callSynopsis == 4 then
            descStr = TextDataMgr:getText(cfgData[self.curScript.datingRuleCid].endSynopsis)
        end
        descStr = descStr or ""
        self.Label_desc:setText(descStr)
    end
end

function SettlementLayer:initPanelFavorView()
    if not self.typeMgrCfg.favorPlane then
        return
    end
    self.Panel_favor:setVisible(true)
    self.Label_favor:setText("+"..math.max(self.data_.addFavor, 0))
end

function SettlementLayer:initPanelMoodView()
    if not self.typeMgrCfg.moodPlane then
        return
    end
    self.Panel_mod:setVisible(true)
    self.Label_mod:setText("+"..math.max(self.data_.addMood, 0))
end


function SettlementLayer:initPanelGiftView()
    if self.typeMgrCfg.itemPlaneType ~= 1 then
        return
    end
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:Scale(0.8)
    self.ScrollView_info_gift:removeAllItems()
    local count = 0
    for i,v in ipairs(self.data_.rewards) do
        if v.id ~= EC_SItemType.PLAYEREXP 
            and v.id ~= EC_SItemType.GOLD
            and v.id ~= EC_SItemType.SPIRITEXP 
            and v.id ~= EC_SItemType.CURFAVOR
            and v.id ~= EC_SItemType.FAVOR
            and v.id ~= EC_SItemType.FUBENFAVOR
            and v.id ~= EC_SItemType.CURMOOD then
            local giftItem = Panel_goodsItem:clone()
            giftItem:Scale(0.8)
            item = cgItem
            PrefabDataMgr:setInfo(giftItem,v.id,v.num)
            self.ScrollView_info_gift:pushBackCustomItem(giftItem)
            count = count + 1
        end
    end
    local minX = math.min((count * 90), self.ScrollView_gift:getSize().width)
    self.ScrollView_gift:setPositionX(self.ScrollView_gift:getPositionX() - minX)
end

function SettlementLayer:initPanelGiftCgView()
    self.giftCgItems = {}
    local num = #self.data_.cgs
    for i = num, 1, -1 do
        local itemInfo = self.data_.cgs[i]
        local cgItem = self.Panel_cgItem:clone()
        local Image_icon = TFDirector:getChildByPath(cgItem, "Image_icon")
        local itemCfg = GoodsDataMgr:getItemCfg(itemInfo.id)
        Image_icon:setTexture(itemCfg.icon)
        Image_icon:setContentSize(CCSizeMake(370, 240))
        cgItem:setPosition(ccp(0,0))
        cgItem:setOpacity(0)
        self.Panel_cg:addChild(cgItem, num - i)
        self.giftCgItems[i] = cgItem
    end
    if num < 1 then
        local bgItem = self.Panel_cgItem:clone()
        local Image_icon = TFDirector:getChildByPath(bgItem, "Image_icon")
        local ruleData = DatingDataMgr:getDatingRuleData(self.curScript.datingRuleCid)
        if not ruleData then
            ruleData = NewCityDataMgr:getCurMainLineFavorCfg()
        end

        if ruleData then
            Image_icon:setTexture(ruleData.endBg)
        else
            Image_icon:setTexture("ui/dating/datingchangjing/bg_tiantai.png")
        end 
        Image_icon:setContentSize(CCSizeMake(370, 240))
        bgItem:setPosition(ccp(0,0))
        bgItem:setOpacity(0)
        self.Panel_cg:addChild(bgItem, 5)
        self.giftCgItems[1] = bgItem
    end
    self.selectCgIdx = num > 0 and 1 or 0
    self.Label_cg_page:setString(self.selectCgIdx.."/"..num)
end

function SettlementLayer:initContent()
    local cgData_ = self.data_.cgs or {}
    if #cgData_ > 0 then
        self:showCgView()
    else
        self:showGiftView()
    end
end

function SettlementLayer:showCgView()
    self.showType = 1
    self.Panel_main:setVisible(true)
    self.Panel_info:setVisible(false)
    for i = 1, #self.data_.cgs do
        local PanelItem = TFDirector:getChildByPath(self.ui, "Panel_pageItem"):clone()
        self.pageView:insertPage(PanelItem, i)
    end
    self:initOptionList()
    for i = 1,#self.data_.cgs do
        self:updateMainLiveItem(i)
    end
    if #self.data_.cgs < 2 then
        self.page_down:setVisible(false)
        self.page_up:setVisible(false)
        self.Panel_option:setVisible(false)
    end
    self:selectMainPage(1)
end

function SettlementLayer:initOptionList()
    self.Panel_optionList = TFDirector:getChildByPath(self.ui, "Panel_optionList")

    local disX = 30
    local startX = - (disX * (#self.data_.cgs-1))/2
    for i = 1, #self.data_.cgs do
        local option = self.Image_option:clone()
        option.select = TFDirector:getChildByPath(option, "Image_select")
        table.insert(self.mainPageOptionList, option)
        option:Pos(startX + (i-1)*disX,0)
        self.Panel_optionList:addChild(option)
    end
end

function SettlementLayer:updateMainLiveItem(pageIdx)
    local PanelItem = self.pageView:getPage(pageIdx-1)
    local itemInfo = self.data_.cgs[pageIdx]
    PanelItem:setPositionY(-88)
    local cg_parent = TFDirector:getChildByPath(PanelItem, "cg_parent")
    local cg_cfg = self:getCgCfgByItemId(itemInfo.id)
    self:changeCg(cg_parent,cg_cfg.cg,cg_cfg.backGround)
    local Spine_effect = TFDirector:getChildByPath(PanelItem, "Spine_effect")
    Spine_effect:setVisible(true)
    Spine_effect:play("animation",false)
    Spine_effect:addMEListener(TFARMATURE_COMPLETE,function()
        Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
        Spine_effect:play("animation2",true)
    end)
end

function SettlementLayer:getCgCfgByItemId(id)
    local cgMap = TabDataMgr:getData("Cg")
    for k,v in pairs(cgMap) do
        if v.cgId == id then
            return v
        end
    end
end

function SettlementLayer:changeCg(parent,cgName,bgpath)
    if parent.cg then
        local node = parent.cg
        node:removeFromParent()
    end
    local layer = require("lua.logic.common.CgView"):new(cgName, bgpath, nil, nil,false,function ()
        end)

    local parentSize = parent:Size()
    local scaleX = parentSize.width/layer:Size().width
    local scaleY = parentSize.height/layer:Size().height
    layer:setScale(math.max(scaleX,scaleY))
    parent:addChild(layer)
    parent.cg = layer
    layer:setName("cgLayer")
end

function SettlementLayer:selectMainPage(pageIdx)
    if self.mainPageIdx ~= pageIdx then
        for i, v in ipairs(self.mainPageOptionList) do
            if pageIdx == i then
                v.select:show()
            else
                v.select:hide()
            end
        end
        self:changePage(pageIdx)
    end
end

function SettlementLayer:changePage(toIdx)
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
    local move     = MoveTo:create(0.5,ccp(offsetPosX*direct,pageNode_f:getPositionY()))
    local fade     = FadeOut:create(0.5)
    local callback = CallFunc:create(function()
        pageNode_f:setVisible(false)
    end)
    local seq = Sequence:createWithTwoActions(Spawn:createWithTwoActions(move,fade), callback)
    pageNode_f:runAction(seq)
    pageNode_t:setOpacity(0)
    pageNode_t:setZOrder(2)
    local arry = {}
    local move1     = MoveTo:create(0.5,ccp(0,pageNode_f:getPositionY()))
    local fade1     = FadeIn:create(0.5)
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

function SettlementLayer:pageViewChanged()
    local curIdx = self.mainPageIdx
    self.page_down:setVisible(curIdx > 1)
    self.page_up:setVisible(curIdx < #self.data_.cgs)
    for i, v in ipairs(self.mainPageOptionList) do
        if curIdx == i then
            v.select:show()
        else
            v.select:hide()
        end
    end
end

function SettlementLayer:showGiftView()
    self.showType = 2
    self.timeStart = os.time()
    self.ableToClose = false
    self:timeOut(function()
        self.ableToClose = true
    end, 2)
    self.Panel_info:setVisible(false)

    self:initPanelExpView()
    self:initPanelFavorView()
    self:initPanelMoodView()
    self:initPanelGiftView()
    self:initPanelGiftCgView()
    self:doCgViewCloseAnimation()
end

function SettlementLayer:doCgViewCloseAnimation()
    local num = #self.data_.cgs
    local delayTime = 0
    for i = num, 1, -1 do
        local pageNode = self.pageView:getPage(num - i)
        if pageNode then
            pageNode:setVisible(true)
            pageNode:setOpacity(255)
            pageNode:setZOrder(i)
            pageNode:setPosition(ccp(0,0))
            local scale = CCScaleTo:create(0.3, 0.5)
            local fade = FadeTo:create(0.3, 0)
            local seq = CCSequence:create({CCDelayTime:create(delayTime),CCSpawn:create({scale, fade})})
            pageNode:runAction(seq)
            delayTime = delayTime + 0.12
        end
    end
    self:timeOut(function()
        self:doGiftViewAnimation()
    end, delayTime + 0.3)
end

function SettlementLayer:doGiftViewAnimation()
    self.Panel_main:setVisible(false)
    self.Panel_info:setVisible(true)
    self.Panel_role_info:setVisible(false)
    self.Image_end_title:setVisible(false)
    self.Label_cg_page:setVisible(false)
    local delayTime = 0
    for i,node in ipairs(self.animation_nodes) do
        node:setOpacity(0)
        node:setRotation(8)
        local pos = node:getPosition()
        node:setPosition(ccp(pos.x + 25, pos.y + 50))
        local rotate = RotateTo:create(0.2, 0)
        local fade = FadeIn:create(0.2)
        local move = CCMoveBy:create(0.2, ccp(-25, -50))
        local arr = {}
        table.insert(arr, CCDelayTime:create(delayTime))
        table.insert(arr, CCSpawn:create({rotate, fade, move}))
        node:runAction(CCSequence:create(arr))
        delayTime = delayTime + 0.1
    end    
    self:timeOut(function()
        self.ableToClose = true
        local delay = 0
        for i=#self.giftCgItems,1,-1 do
            local item = self.giftCgItems[i]
            item:setPositionY(100)
            item:setOpacity(0)
            local fade = FadeIn:create(0.3)
            local move = CCMoveBy:create(0.3, ccp(0, -100))
            local arr = {}
            table.insert(arr, CCDelayTime:create(delay))
            table.insert(arr, CCSpawn:create({fade, move}))
            item:runAction(CCSequence:create(arr))
            delay = delay + 0.15
        end
        self.Panel_role_info:setVisible(true)
        self.Image_end_title:setVisible(true)
        self.Panel_cg:setVisible(self.typeMgrCfg.cgPlaneType == 1)
        self.Label_cg_page:setVisible(self.typeMgrCfg.cgPlaneType == 1 and #self.data_.cgs > 0)
        self.Label_cg_page:setOpacity(0)
        self.Label_cg_page:runAction(CCFadeIn:create(0.4))
        ViewAnimationHelper.doMoveFadeInAction(self.Panel_role_info, {direction = 1, distance = 80, adjust = 20, time = 0.2, ease = 2})
        ViewAnimationHelper.doScaleFadeInAction(self.Image_end_title, {scale = 0.01, upscale = 1.3, uptime = 0.2, downscale = 1.0, downtime = 0.1, delay = 0.1})
        
        if self.typeMgrCfg.itemPlaneType == 1 then
            self.Panel_info_gift:setVisible(true)
            ViewAnimationHelper.doMoveFadeInAction(self.Panel_info_gift, {direction = 2, distance = 80, adjust = 20, time = 0.2, ease = 2})
            local rewardItems = self.ScrollView_info_gift:getItems()
            for i,v in ipairs(rewardItems) do
                ViewAnimationHelper.doScaleFadeInAction(v, {scale = 0.01, upscale = 1.0, uptime = 0.1, downscale = 0.8, downtime = 0.05, delay = i * 0.06 + 0.2})
            end
        end
    end, delayTime + 0.2)
end

function SettlementLayer:updateSelectCgState(state)
    self.selecting = true
    local num = #self.data_.cgs
    if self.selectCgIdx > 0 then
        local node = self.giftCgItems[self.selectCgIdx]
        if node then
            if state then
                local callFun = CCCallFuncN:create(function(node)
                    node:setVisible(false)
                    self.selecting = false
                end)
                local arr = {}
                table.insert(arr, CCSpawn:create({RotateTo:create(0.2, 15),CCMoveBy:create(0.2, ccp(0, 100)), CCFadeOut:create(0.2)}))
                table.insert(arr, callFun)
                node:runAction(CCSequence:create(arr))
            else
                node:setVisible(true)
                local callFun = CCCallFuncN:create(function(node)
                    self.selecting = false
                end)
                local arr = {}
                table.insert(arr, CCSpawn:create({RotateTo:create(0.2, 0),CCMoveBy:create(0.2, ccp(0, -100)), CCFadeIn:create(0.2)}))
                table.insert(arr, callFun)
                node:runAction(CCSequence:create(arr))
            end
        end
    end
end

function SettlementLayer:playShader(widthOffset,heightOffset)
    self.Image_bg:setShaderProgram("Blur", true)
    local _GLProgramState = self.Image_bg:getGLProgramState()
    _GLProgramState:setUniformFloat("texelWidthOffset", widthOffset)
    _GLProgramState:setUniformFloat("texelHeightOffset", heightOffset)
end

function SettlementLayer:onShow()
    self.super.onShow(self)

end

function SettlementLayer:onClose()
    self.super.onClose(self)
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
end

function SettlementLayer:close()
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_FuBen then
        FubenDataMgr:send_DUNGEON_FIGHT_OVER(FubenDataMgr:getCurLevelCid(), true, {1}, 1, 1, 1)
    elseif NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine then
        NewCityDataMgr:enterNewCity(EC_NewCityType.NewCity_Normal)
        return
    elseif self.datingType == EC_DatingScriptType.FUBEN_SCRIPT then
        FubenDataMgr:send_DUNGEON_FIGHT_OVER(FubenDataMgr:getCurLevelCid(), true, {1}, 1, 1, 1)
    elseif self.datingType == EC_DatingScriptType.DAY_SCRIPT then
    elseif self.datingType == EC_DatingScriptType.FAVOR_SCRIPT then
        
    elseif TFDirector:currentScene().__cname ~= "MainScene" then
        AlertManager:changeScene(SceneType.MainScene)
        return
    end
    if not GuideDataMgr:isInNewGuide() then
        AlertManager:closeLayer(self)
    end
end

function SettlementLayer:registerEvents()
    self.cg_back = true

    self.sharing = false
    self.btn_share:onClick(function()
        if not self.sharing then
            self.sharing = true
            self:timeOut(function()
                self.sharing = false
            end, 3)
            Utils:gameShare()
        end
    end)

    for i, v in ipairs(self.mainPageOptionList) do
        v:Touchable(true)
        v:onClick(function()
            self:selectMainPage(i)
        end)
    end

    self.pageView:addMEListener(TFPAGEVIEW_CHANGED, function ()
        self:pageViewChanged()
    end)

    local function onTouchBegan(touch, location)
        touch.startPos = location
        return true
    end

    local function pageUp()
        local pageIndex = self.mainPageIdx + 1
        if pageIndex > #self.data_.cgs then
            pageIndex = #self.data_.cgs
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
        if self.showType == 2 then
            self.timeStart = self.timeStart or os.time()
            local time = os.time()
            if time - self.timeStart > 2 then
                self:close()
            end
            return
        end
        if self.cg_back then
            self.cg_back = false
            self.Panel_option:setVisible(false)
            self.btn_share:setVisible(false)
            self:showGiftView()
        end
    end

    self.Panel_touch:setTouchEnabled(true)
    self.panelTouchFunc = function()
        if self.enableTouching then
            self:close()
        end
    end
    self.Panel_touch:onClick(self.panelTouchFunc)
    
    self.Panel_touch:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)
    self.Panel_touch:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved)
    self.Panel_touch:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp)
    self.Panel_touch:setSwallowTouch(false)

    self.page_up:onClick(pageUp)

    self.page_down:onClick(pageDown)

    self.Panel_cg:setTouchEnabled(true)
    self.selecting = false
    self.Panel_cg:onClick(function()
        if self.selecting then
            return
        end
        local num = #self.data_.cgs
        if self.selectCgIdx > 0 then
            if self.upDuration then
                if self.selectCgIdx < num then
                    self:updateSelectCgState(true)
                    self.selectCgIdx = self.selectCgIdx + 1
                    self.Label_cg_page:setString(self.selectCgIdx.."/"..num)
                    self.upDuration = self.selectCgIdx < num
                end
            else
                if self.selectCgIdx > 1 then
                    self.selectCgIdx = self.selectCgIdx - 1
                    self:updateSelectCgState(false)
                    self.Label_cg_page:setString(self.selectCgIdx.."/"..num)
                    self.upDuration = self.selectCgIdx == 1
                end
            end
        end
    end)
end

function SettlementLayer:specialKeyBackLogic( )
    GuideDataMgr:setPlotLvlBackState(false)
    self:panelTouchFunc()
    return true
end

return SettlementLayer
