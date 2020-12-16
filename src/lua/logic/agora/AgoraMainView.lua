
local AgoraMainView = class("AgoraMainView", BaseLayer)

function AgoraMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.agora.agoraMainView")

end

function AgoraMainView:registerEvents()
    -- EventMgr:addEventListener(self, EV_AGORA.ContributionUpdate, handler(self.updateContribution, self))
    EventMgr:addEventListener(self, EV_AGORA.ShowRollInfo, handler(self.onShowRollInfo, self))
    EventMgr:addEventListener(self, EV_AGORA.UpdateStationPlayerInfos, handler(self.addStationInfo2, self))
    EventMgr:addEventListener(self, EV_AGORA.UpdateStationTopInfos, handler(self.updateStationInfo1, self))
    EventMgr:addEventListener(self, EV_AGORA.ComposeStatusUpdate, handler(self.checkMainRedPoint, self))

    self.Button_fight:onClick(function()

        local serverTime = ServerDataMgr:getServerTime()
        if self.fightTime and serverTime >= self.fightTime[1] and serverTime<= self.fightTime[2] then
            TFDirector:send(c2s.CHRISTMAS_REQ_CHRISTMAS_DUNGEONS, {})
        else
            Utils:showTips(303064)
        end
    end)

    self.Button_chat:onClick(function()
        local ChatView = require("lua.logic.chat.ChatView")
        ChatView.show(nil,false)
    end)

    self.Button_infoStation:onClick(function(sender)
        local isShowed = sender.panelInfos:isVisible()
        sender.panelInfos:setVisible(not isShowed)
        sender.imgNew:hide()
    end)
end

function AgoraMainView:onShow()
    self.super.onShow(self)
    self:checkMainRedPoint()
    

    if self.elvesRole then

        self.elvesRole:removeFromParent()
        self.elvesRole = nil
    end

    self:initLive2d()
end

function AgoraMainView:initData()
    self.funcsList = {
        {
            btTarget = nil,
            nameId = 500003,
            btTex = "ui/agora/6.png",
            clickCall = function()
                Utils:openView("store.StoreMainView", 180000)
            end,
            redPointCheck = function()
                return false
            end,
        },
        {
            btTarget = nil,
            nameId = 800072,
            btTex = "ui/agora/7.png",
            clickCall = function()
                Utils:openView("agora.AgoraComposeView")
            end,
            redPointCheck = function()
                return AgoraDataMgr:isHaveComposeCanGet()
            end,
        },
        {
            btTarget = nil,
            nameId = 1454023,
            btTex = "ui/agora/8.png",
            clickCall = function()
                Utils:openView("agora.AgoraTaskView")
            end,
            redPointCheck = function()
                return ActivityDataMgr2:isShowAgoraTaskRedPoint()
            end,
        },
        {
            btTarget = nil,
            nameId = 303023,
            btTex = "ui/agora/9.png",
            clickCall = function()
                Utils:openView("agora.AgoraLotteryView")
            end,
            redPointCheck = function()
                return false
            end,
        }
    }

    self.fightTime = Utils:getKVP(47005, "Time")
end

function AgoraMainView:initUI(ui)
    self.super.initUI(self, ui)

    local root = TFDirector:getChildByPath(ui, "Panel_root")
    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_funcBt = Panel_prefab:getChild("Panel_funcBt")
    self.Image_topNotice = Panel_prefab:getChild("Image_topNotice")
    self.Panel_playerNotice = Panel_prefab:getChild("Panel_playerNotice")
    self.Panel_ui = TFDirector:getChildByPath(root, "Panel_ui")
    self.Node_role = TFDirector:getChildByPath(root, "Node_role")
    self.Panel_reward = TFDirector:getChildByPath(root, "Panel_reward")
    -- self.Panel_contribute = TFDirector:getChildByPath(root, "Panel_contribute")
    -- self.LoadingBar_contribution = TFDirector:getChildByPath(root, "LoadingBar_contribution")
    -- self.Label_agoraContribution = TFDirector:getChildByPath(root, "Label_agoraContribution")
    -- self.Label_selfContribution = TFDirector:getChildByPath(root, "Label_selfContribution")
    -- self.Label_agoraLevel = TFDirector:getChildByPath(root, "Label_agoraLevel")
    self.Panel_notice = TFDirector:getChildByPath(root, "Panel_notice")
    self.Label_Rnotice = self.Panel_notice:getChild("Label_Rnotice")
    self.Label_notice = self.Panel_notice:getChild("Label_notice")

    self.Button_chat = TFDirector:getChildByPath(self.Panel_ui, "Button_chat")
    self.Button_fight = TFDirector:getChildByPath(self.Panel_ui, "Button_fight")
    self.Button_infoStation = TFDirector:getChildByPath(self.Panel_ui, "Button_infoStation")
    self.Button_infoStation.imgNew = TFDirector:getChildByPath(self.Button_infoStation, "Image_new")
    self.Button_infoStation.panelInfos = TFDirector:getChildByPath(self.Button_infoStation, "Panel_infos")
    self.Label_time = TFDirector:getChildByPath(self.Button_infoStation, "Label_time")
    local panelInfos = self.Button_infoStation.panelInfos
    for i = 1, 2 do
        local listview = UIListView:create(panelInfos:getChild("ScrollView_info"..i))
        self["ListView_info"..i] = listview
    end

    self:createFuncs()
    self:showStationInfo1()
    -- self:updateContribution()

    EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)

    --情报站置顶消息定时检测
    self:runAction(CCRepeatForever:create(CCSequence:create({
        CCCallFunc:create(function()
            AgoraDataMgr:agoraTopNoticeUpdateCheck()
        end),
        CCDelayTime:create(10.0)
    })))

    if self.fightTime then
        local sy, sm, sd = Utils:getUTCDate(self.fightTime[1] , GV_UTC_TIME_ZONE):getdate()
        local ey, em, ed = Utils:getUTCDate(self.fightTime[2] , GV_UTC_TIME_ZONE):getdate()
        local startstr = TextDataMgr:getText(600024, sm, sd)
        local endstr = TextDataMgr:getText(600024, em, ed)
        self.Label_time:setText(startstr.." - "..endstr..GV_UTC_TIME_STRING)

    end

end

function AgoraMainView:createFuncs()
    local listViewFunc = UIListView:create(TFDirector:getChildByPath(self.Panel_ui, "ScrollView_func"))
    listViewFunc:setItemModel(self.Panel_funcBt)
    local function createBt(nameid, bttexture)
        local funcbt = self.Panel_funcBt:clone():show()
        funcbt.bt = TFDirector:getChildByPath(funcbt, "Button_func")
        funcbt.bt:getChild("Label_func"):setTextById(nameid)
        funcbt.bt:getChild("Image_func"):setTexture(bttexture)
        funcbt.imageRed = funcbt.bt:getChild("Image_red")
        return funcbt
    end
    for k, v in pairs(self.funcsList) do
        local funcBt = createBt(v.nameId, v.btTex)
        funcBt.bt:onClick(v.clickCall)
        v.btTarget = funcBt
        listViewFunc:pushBackCustomItem(funcBt)
    end

    -- local contributebt = createBt("贡献奖励")
    -- contributebt:Pos(me.p(0, 0))
    -- self.Panel_reward:addChild(contributebt)
    -- contributebt.bt:onClick(function()
    --     Utils:openView("agora.AgoraContributionView")
    -- end)
end

-- function AgoraMainView:updateContribution()
--     local curlv = AgoraDataMgr:getAgoraLv()
--     local selfDonate = AgoraDataMgr:getAgoraSelfContribution()
--     local startDonate, endDonate = AgoraDataMgr:getAgoraCurLevelContributionRage(curlv)
--     local agoraDonate = AgoraDataMgr:getAgoraContribution()
--     self.Label_agoraContribution:setText("全服贡献度："..agoraDonate.."/"..AgoraDataMgr:getAgoraMaxContribution())
--     self.Label_selfContribution:setText("个人贡献度："..selfDonate)
--     self.Label_agoraLevel:setText("Lv."..curlv)
--     local percent = math.floor((agoraDonate - startDonate) / (endDonate - startDonate) * 100)
--     self.LoadingBar_contribution:setPercent(percent)
-- end

function AgoraMainView:showStationInfo1()
    local infos = AgoraDataMgr:getStationInfo() or {}
    for i, v in ipairs(infos) do
        self:addStationInfo2()
    end
end

--集会所情报站置顶信息
function AgoraMainView:updateStationInfo1(topInfos)
    topInfos = topInfos or {}
    local curItems = self.ListView_info1:getItems()
    local curCount = #curItems
    local topCount = #topInfos
    local isInfoChange = false
    if curCount < topCount then
        local addcount = topCount - curCount
        for i = 1, addcount do
            local topitem = self.Image_topNotice:clone():show()
            topitem.id = 0
            topitem.richText = TFRichText:create(ccs(topitem:getSize().width - 15, 0))
            topitem.richText:AnchorPoint(me.p(0, 1))
            topitem.richText:Pos(-topitem:getSize().width*0.5, 0)
            topitem:addChild(topitem.richText)
            self.ListView_info1:pushBackCustomItem(topitem)
            curCount = curCount + 1
        end
    elseif curCount > topCount then
        for i = topCount + 1, curCount do
            self.ListView_info1:removeItem(i)
        end
    end
    for i = topCount, 1, -1 do
        local item = self.ListView_info1:getItem(i)
        if item then
            local top = topInfos[i]
            if top.id ~= item.id then
                isInfoChange = true
            end
            item.id = top.id
            local rid = "r"..tostring(top.stringid)
            item.richText:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr(rid)))
            item:setSize(me.size(item:getSize().width, item.richText:getSize().height*1.1))
        end
    end
    self.ListView_info1:doLayout()

    -- if not self.Button_infoStation.panelInfos:isVisible() and topCount > 0 and isInfoChange then
    --     self.Button_infoStation.imgNew:show()
    -- end
end

--玩家情报站信息
function AgoraMainView:addStationInfo2()
    local maxInfosCount = AgoraDataMgr:getMaxPlayerStationInfosCount()
    local curItems = self.ListView_info2:getItems()
    local curCount = #curItems
    local startIndex = maxInfosCount
    self.ListView_info2:setItemsMargin(8)
    if curCount < maxInfosCount then
        local playeritem = self.Panel_playerNotice:clone():show()
        playeritem.richText = TFRichText:create(ccs(playeritem:getSize().width - 25, 0))
        playeritem.richText:AnchorPoint(me.p(0, 1))
        playeritem.richText:Pos(-playeritem:getSize().width*0.5, 0)
        playeritem:addChild(playeritem.richText)
        self.ListView_info2:pushBackCustomItem(playeritem)
        curCount = curCount + 1
        startIndex = curCount
    end
    for i, v in ipairs(curItems) do
        local index = startIndex - i + 1
        local infodata = AgoraDataMgr:getStationInfoByIdx(index)
        if infodata then
            local name = string.htmlspecialchars(infodata.pname)
            v.richText:Text(self:getStationInfoText(infodata.type, name, infodata.param, infodata.reward))
            v:setSize(me.size(v:getSize().width, v.richText:getSize().height))
        end
    end
    self.ListView_info2:doLayout()
    -- if not self.Button_infoStation.panelInfos:isVisible() then
    --     self.Button_infoStation.imgNew:show()
    -- end
end

function AgoraMainView:initLive2d()
    local modelid = 210506
    self.elvesRole = ElvesNpcTable:createLive2dNpcID(modelid,false,false,nil,false).live2d
    self.elvesRole:registerEvents()
    self.Node_role:addChild(self.elvesRole)
    -- self.elvesRole:hide()
end

function AgoraMainView:checkMainRedPoint()
    for k, v in pairs(self.funcsList) do
        if v.redPointCheck then
            local isshow = v.redPointCheck()
            v.btTarget.imageRed:setVisible(isshow)
        end
    end
end

function AgoraMainView:getStationInfoText(type, name, param, rewards)
    rewards = rewards or {}
    local text = ""
    local rid = EC_AgoraStationInfoRId[type]
    local paramstr = ""
    if type == EC_AgoraStationInfoType.LotteryLucky or type == EC_AgoraStationInfoType.LotteryLuckyTop then
        local itemconf = GoodsDataMgr:getItemCfg(param)
        if itemconf then
            paramstr = TextDataMgr:getText(itemconf.nameTextId)
        else
            return ""
        end
        text = TextDataMgr:getFormatText(TextDataMgr:getTextAttr(rid) , tostring(name), paramstr)
    elseif type == EC_AgoraStationInfoType.CombineLucky then
        local reward = rewards[1]
        if not reward then
            return ""
        end
        local itemconf = GoodsDataMgr:getItemCfg(reward.id)
        if itemconf then
            local namestr = TextDataMgr:getText(itemconf.nameTextId)
            text = TextDataMgr:getFormatText(TextDataMgr:getTextAttr(rid) , tostring(name), namestr, tostring(reward.num))
        end
    elseif type == EC_AgoraStationInfoType.PassLevel then
        local dungenconf = TabDataMgr:getData("ChristmasDungenLevel", param)
        if dungenconf then
            paramstr = dungenconf.rstringID
        else
            return ""
        end
        text = TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r"..tostring(paramstr)), tostring(name))
    else
       paramstr = tostring(param)
       text = TextDataMgr:getFormatText(TextDataMgr:getTextAttr(rid) , tostring(name), paramstr)
    end
    return text
end

--显示跑马灯
function AgoraMainView:showRollInfo()
    local frontInfo = AgoraDataMgr:getFrontRollInfo()
    if not frontInfo then
        self.Panel_notice:hide()
        return
    end
    self.Panel_notice:show()
    local speed = 50
    self.Label_Rnotice:Text(self:getStationInfoText(frontInfo.type, frontInfo.pname, frontInfo.param))
    local panelNoticeSize = self.Panel_notice:getSize()
    self.Label_Rnotice:Pos(me.p(panelNoticeSize.width*0.5, 0))
    local width = panelNoticeSize.width + self.Label_Rnotice:getSize().width
    self.Label_Rnotice:runAction(CCSequence:create({
        CCMoveBy:create(width / speed, me.p(-width, 0)),
        CCDelayTime:create(0.5),
        CCCallFunc:create(function()
            AgoraDataMgr:removeFrontRollInfo()
            self:showRollInfo()
        end)}))
end

function AgoraMainView:onShowRollInfo()
    if not self.Panel_notice:isVisible() then
        self:showRollInfo()
    end
end

return AgoraMainView