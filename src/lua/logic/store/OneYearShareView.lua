local OneYearShareView = class("OneYearShareView", BaseLayer)


function OneYearShareView:ctor()
    self.super.ctor(self)
    --self:showPopAnim(true)
    self:initData()
    self:init("lua.uiconfig.recharge.oneYearShareView")
end

function OneYearShareView:initData()

    self.cfg = TabDataMgr:getData("Share",3)
    self.curriculumCfg = TabDataMgr:getData("CurriculumVitae")
    self.curroculum = {}
    for k,v in pairs(self.curriculumCfg)  do
        table.insert(self.curroculum,v)
    end
    table.sort(self.curroculum,function(a,b)
        return a.rank<b.rank
    end)
end

function OneYearShareView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Button_share 	= TFDirector:getChildByPath(ui,"Button_share")
    self.Button_buy = TFDirector:getChildByPath(ui,"Button_buy")
    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

    local ScrollView_item = TFDirector:getChildByPath(ui,"ScrollView_item")
    self.ListView_item = UIListView:create(ScrollView_item)
    self.Image_item_bg = TFDirector:getChildByPath(ui,"Image_item_bg")

    self.Panel_richText = TFDirector:getChildByPath(ui,"Panel_richText")

    local ScrollView_content = TFDirector:getChildByPath(ui,"ScrollView_content")
    self.ListView_content = UIListView:create(ScrollView_content)
    self.Label_content = TFDirector:getChildByPath(ui,"Label_content")
    self.Panel_info = TFDirector:getChildByPath(ui,"Panel_info")

    self.Label_content_tip = TFDirector:getChildByPath(ui,"Label_content_tip")

    local Image_barbg = TFDirector:getChildByPath(ui,"Image_barbg")
    local Image_bar = TFDirector:getChildByPath(ui,"Image_bar")
    local scrollBar = UIScrollBar:create(Image_barbg, Image_bar)
    self.ListView_content:setScrollBar(scrollBar)

    TFDirector:send(c2s.SHARE_REQ_SHARE_INFOS, {})
end

function OneYearShareView:onRecvShare()
    self:initUILogic()
end

function OneYearShareView:initUILogic()

    local info = ShareDataMgr:getShareInfoById(3)
    if not info then
        return
    end
    dump(info)
    ShareDataMgr:setShareOpenFlag(info.id)

    --[0 未分享 1分享成功可领取 2奖励已经领取]
    if info.statue == 0 then
        self.Button_share:setVisible(true)
        self.Button_buy:setVisible(false)
    elseif info.statue == 1 then
        self.Button_share:setVisible(false)
        self.Button_buy:setVisible(true)
    elseif info.statue == 2 then
        self.Button_share:setVisible(false)
        self.Button_buy:setVisible(false)
    end

    self.ListView_item:removeAllItems()
    for k,v in ipairs(info.rewards) do
        local itemCfg = GoodsDataMgr:getItemCfg(v.id)
        if itemCfg then
            local Image_item_bgClone = self.Image_item_bg:clone()
            local Image_icon = Image_item_bgClone:getChildByName("Image_icon")
            Image_icon:setTexture(itemCfg.icon)
            Image_icon:setScale(0.6)
            self.ListView_item:pushBackCustomItem(Image_item_bgClone)
            Image_item_bgClone:onClick(function()
                Utils:showInfo(v.id, nil, false)
            end)
        end
    end

    local resumeTab = ShareDataMgr:getResumeTab()
    dump(resumeTab)
    if not resumeTab then
        ShareDataMgr:Send_GetResumeInfo()
    else
        self:updateResumeInfo()
    end
end

function OneYearShareView:updateListItem(data)

    local size = self.ListView_content:getContentSize()
    local Panel_richText = self.Panel_richText:clone():Show()
    local param = {}
    for k,v in ipairs(data.describe) do
        local value = self.resumeInfoTab_[tostring(v)]
        if value then
            if v == EC_PlayerResume.NAME_TIME or v == EC_PlayerResume.LEVEL_TIME
                    or v == EC_PlayerResume.HERO_TIME then
                local timeDate = Utils:getLocalDate(value/1000)
                value = timeDate:fmt("%Y年%m月%d日")
            elseif v == EC_PlayerResume.FIRST_FRIEND_TIME then
                local passTime = ServerDataMgr:getServerTime() - value
                passTime = passTime > 0 and passTime or 0
                local day, hour, min = Utils:getFuzzyDHMS(passTime, true)
                value = day
            elseif v == EC_PlayerResume.PLAYER_CREATE then
                local timeDate = Utils:getLocalDate(value)
                value = timeDate:fmt("%Y年%m月%d日")
            elseif v == EC_PlayerResume.ONLINE_TIME then
                local day,hour,min,sec = Utils:getTimeDHMZ(value)
                value = day*24 + hour
            elseif v == EC_PlayerResume.TOP3_POWER_HEROES then
                local name = ""
                for index,heroCid in ipairs(value) do
                    if index ~= 1 then
                        name = name .. "," ..HeroDataMgr:getNameById(heroCid)
                    else
                        name = HeroDataMgr:getNameById(heroCid)
                    end
                end
                value = name
            elseif v == EC_PlayerResume.HERO_ID then
                value = HeroDataMgr:getNameById(value)
            end
            table.insert(param,value)
        end
    end
    if #param ~= #data.describe then
        return
    end
    self.index = self.index + 1
    local richLabel = TFRichText:create(ccs(size.width, 0))
    richLabel:AnchorPoint(me.p(0, 1))
    richLabel:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r"..data.id),unpack(param)))
    richLabel:setPositionX(20+(self.index-1)*20)
    local h = richLabel:getContentSize().height
    Panel_richText:addChild(richLabel)
    Panel_richText:setContentSize(CCSizeMake(680, h+5))
    self.ListView_content:pushBackCustomItem(Panel_richText)
    self.ListView_content:doLayout()

end

function OneYearShareView:updateResumeInfo()

    self.index = 0
    self.ListView_content:removeAllItems()
    self.resumeInfoTab_ = ShareDataMgr:getResumeTab()
    if not self.resumeInfoTab_ then
        return
    end

    local playerDays = self.resumeInfoTab_[tostring(EC_PlayerResume.PLAYER_DAYS)] or 0
    self.Label_content_tip:setVisible(playerDays <= 3)
    if playerDays <= 3 then
        self.Label_content_tip:setTextById(14210295)
        return
    end
    local roleId,featureId
    for k,v in ipairs(self.curroculum) do
        if v.type == 1 then
            self:updateListItem(v)
        elseif v.type == 3 then
            local describe = v.describe[1]
            local param = tostring(describe)
            roleId = self.resumeInfoTab_[param]
            local param2 = tostring(v.describe[2])
            local cnt = self.resumeInfoTab_[param2]
            if describe == EC_PlayerResume.MOST_FAVOR_ROLE then
                featureId = 4
            elseif describe == EC_PlayerResume.TOUCH_HERO_ID then
                featureId = 2
            elseif describe == EC_PlayerResume.DATING_HERO_ID then
                featureId = 3
            end
            self:updateFeatureRoleInfo(roleId,featureId,cnt)
        end
    end
end

function OneYearShareView:updateFeatureRoleInfo(roleId,featureId,cnt)
    if not roleId or not featureId then
        return
    end

    local heroId = HeroDataMgr:getHeroIdByRoleId(roleId)
    local featureHero = self.curriculumCfg[heroId]
    if not featureHero  then
        return
    end

    local descTextId = featureHero.describe[featureId]
    if not descTextId then
        return
    end
    local tipTextId = featureHero.describe[1]
    if not tipTextId then
        return
    end

    local panelInfo = self.Panel_info:clone()
    local ScrollView_desc = panelInfo:getChildByName("ScrollView_desc")
    local ListView_desc = UIListView:create(ScrollView_desc)
    local size = ListView_desc:getContentSize()

    local roleName = RoleDataMgr:getName(roleId)

    local Label_content1 = self.Label_content:clone():Show()
    Label_content1:setDimensions(size.width, 0)

    Label_content1:setTextById(tipTextId,roleName)
    ListView_desc:pushBackCustomItem(Label_content1)

    local Label_content = self.Label_content:clone():Show()
    Label_content:setDimensions(size.width, 0)
    if cnt then
        Label_content:setTextById(descTextId,cnt)
    else
        Label_content:setTextById(descTextId)
    end
    ListView_desc:pushBackCustomItem(Label_content)

    local headIcon = HeroDataMgr:getIconPathById(heroId)
    local Image_head_bg = panelInfo:getChildByName("Image_head_bg")
    Image_head_bg:setTexture(self.curriculumCfg[heroId].icon)
    self.ListView_content:pushBackCustomItem(panelInfo)
end

function OneYearShareView:onRecvShareAward(id,award)

    if not award then
        return
    end
    Utils:showReward(award)
    self.Button_share:setVisible(false)
    self.Button_buy:setVisible(false)
end

function OneYearShareView:registerEvents()

    EventMgr:addEventListener(self, EV_SHOW_AWARD, handler(self.onRecvShareAward, self))
    EventMgr:addEventListener(self, EV_SHOW_SHARE, handler(self.onRecvShare, self))
    EventMgr:addEventListener(self, EV_UPDATE_RESUME, handler(self.updateResumeInfo, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_buy:onClick(function()
        local info = ShareDataMgr:getShareInfoById(3)
        TFDirector:send(c2s.SHARE_SUBMIT_SHARE, {info.id})
    end)

    self.Button_share:onClick(function()
        local info = ShareDataMgr:getShareInfoById(3)
        local ret = self:shareResult()
        if ret then
            TFDirector:send(c2s.SHARE_SHARE, {info.id})
            self.Button_share:setVisible(false)
            self.Button_buy:setVisible(true)
        end
    end)
end

function OneYearShareView:shareResult()

    local ret = false
    if HeitaoSdk then
        ret = HeitaoSdk.takeScreenshot();
    else
        ret = takeScreenshot()
        ret = true
    end
    return ret
end

return OneYearShareView
