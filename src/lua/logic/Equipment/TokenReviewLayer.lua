--[[
    @desc：TokenReviewLayer
    @date: 2021-01-19 14:54:36
]]

local TokenReviewLayer = class("TokenReviewLayer",BaseLayer)

function TokenReviewLayer:initData(isSave, heroId)
    self.isSave = isSave
    self.heroId = heroId
    self.tokenModels = {}
    self.selectIdx = 1
end

function TokenReviewLayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.Equip.tokenReviewLayer")
end

function TokenReviewLayer:initUI(ui)
    self.super.initUI(self,ui)

    self.gridViewToken = UIGridView:create(self._ui.ScrollView_token)
    self.gridViewToken:setColumn(3)
    self.gridViewToken:setColumnMargin(0)
    self.gridViewToken:setRowMargin(25)
    self.gridViewToken:setItemModel(self._ui.Panel_suit_model)

    self._ui.Button_save:setVisible(self.isSave)
    self._ui.Button_use:setVisible(not self.isSave)

    self:initGridView()
end

function TokenReviewLayer:initGridView()
    local count = TabDataMgr:getData("DiscreteData",52001).data.max
    for i = 1, count do
        self.tokenModels[i] = self.gridViewToken:pushBackDefaultItem()
    end
    self.gridViewToken:setVisible(false)
end

function TokenReviewLayer:registerEvents()
    EventMgr:addEventListener(self,TOKEN_BACKUP_INFO, handler(self.onRecvBackUpInfo, self))
    EventMgr:addEventListener(self,TOKEN_USE_BACKUP_INFO, function()
        AlertManager:close(self)
    end)

    self._ui.Button_save:onClick(function()
        local function saveSuit()
            local tokenInfos = {}
            for i = 1, 6 do
                local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, i)
                if euipMent then
                    table.insert(tokenInfos, {i - 1, tostring(euipMent.id)})
                end
            end
            local txt = TextDataMgr:getText(15011277, self.selectIdx)
            EquipmentDataMgr:requestSavaToken(self.heroId, self.selectIdx, txt, tokenInfos)
        end
        local info = self.backUpInfos[self.selectIdx]
        if info then
            local view = Utils:openView("common.ConfirmBoxView")
            view:setCallback(saveSuit)
            view:setContent(TextDataMgr:getText(15011278))
        else
            saveSuit()
        end
    end)

    self._ui.Button_use:onClick(function()
        local function useTokenBackup()
            EquipmentDataMgr:requestUseToken(self.heroId, self.selectIdx)
            AlertManager:close(self)
        end

        local info = self.backUpInfos[self.selectIdx]
        local nameStr = ""
        local state = false
        local sumCost = HeroDataMgr:getCost(self.heroId)
        for k, v in ipairs(info.plan) do
            local _data = GoodsDataMgr:getSingleItem(v.equipId)
            local cid = _data.cid
            local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(cid)
            local equipCfg = EquipmentDataMgr:getNewEquipCfg(cid)
            if equipInfo.heroId and string.len(equipInfo.heroId) > 1 and tonumber(equipInfo.heroId) ~= self.heroId then
                state = true
                nameStr = nameStr..HeroDataMgr:getNameById(tonumber(equipInfo.heroId)).."  "
            end
            sumCost = sumCost + equipCfg.cost
        end

        local costMax = HeroDataMgr:getCostMax(self.heroId)
        if type(costMax) == "table" then
            costMax = costMax.val
        end
        if sumCost > costMax then
            Utils:showTips(225008)
            return
        end

        if state then
            Utils:openView("common.ChangeEquipConfirmView", {heroName = nameStr, title = TextDataMgr:getText(100000049), tips = "r30003", callback = useTokenBackup})
        else
            useTokenBackup()
        end
    end)

    self._ui.Button_rename:onClick(function()
        local function renameFunc(txt)
            EquipmentDataMgr:requestTokenRename(self.heroId, self.selectIdx, txt)
        end
        Utils:openView("Equipment.ModifySuitNameView",{okClickReqCallback = renameFunc})
    end)
end

function TokenReviewLayer:updateGridUI(isForce)
    isForce = isForce == nil and true
    self.backUpInfos = EquipmentDataMgr:getTokenBackUpInfo()
    for i, model in ipairs(self.tokenModels) do
        model:show()
        local Image_model_bg = TFDirector:getChildByPath(model, "Image_model_bg")
        local Label_tips = TFDirector:getChildByPath(model, "Label_tips")
        local Panel_info = TFDirector:getChildByPath(model, "Panel_info")
        local info = self.backUpInfos[i]
        if info then
            Label_tips:hide()
            Panel_info:show()
            local Label_suit_name = TFDirector:getChildByPath(Panel_info, "Label_suit_name")
            Label_suit_name:setText(info.name)

            local plans = {}
            for i, v in ipairs(info.plan or {}) do
                plans[v.index + 1] = v.equipId
            end
            for pos = 1, 6 do
                local panelPos = TFDirector:getChildByPath(Panel_info, "pos_"..pos)
                panelPos:setVisible(nil ~= plans[pos])
                if plans[pos] then
                    local item = panelPos.token
                    if not item then
                        item = self._ui.Panel_equip_item:clone()
                        item:show()
                        item:setPosition(ccp(0,0))
                        panelPos:addChild(item)
                        panelPos.token = item
                    end
                    self:updateTokenItem(panelPos.token, plans[pos])
                end
            end

            if self.selectIdx == i then
                Image_model_bg:setTexture("ui/Equipment/tokenReview/04.png")
            else
                Image_model_bg:setTexture("ui/Equipment/tokenReview/01.png")
            end
        else
            Panel_info:hide()
            Label_tips:show()
            if self.selectIdx == i then
                Image_model_bg:setTexture("ui/Equipment/tokenReview/04.png")
            else
                Image_model_bg:setTexture("ui/Equipment/tokenReview/01.png")
            end
        end

        if isForce then
            Image_model_bg:setTouchEnabled(true)
            Image_model_bg:onClick(function()
                self.selectIdx = i
                self:updateGridUI(false)
            end)
        end
    end

    self:updateBtnState()
end

function TokenReviewLayer:updateTokenItem(token, tokenId)
    if not token.foo then
        local foo = {}
        local stars = {}
        foo.root = token
        foo.Image_bg = TFDirector:getChildByPath(foo.root,"Image_bg")
        foo.Image_icon = TFDirector:getChildByPath(foo.root,"Image_icon")
        foo.Image_level_bg = TFDirector:getChildByPath(foo.root,"Image_level_bg")
        foo.Label_level = TFDirector:getChildByPath(foo.Image_level_bg,"Label_level")
        foo.Image_use = TFDirector:getChildByPath(foo.root,"Image_use")
        for i = 1, 5 do
            stars[i] = TFDirector:getChildByPath(foo.root,"Image_star"..i)
        end
        foo.stars = stars
        token.foo = foo
    end

    local item = token.foo
    local cid = GoodsDataMgr:getSingleItem(tokenId).cid
    local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(cid)
    local equipCfg = EquipmentDataMgr:getNewEquipCfg(cid)
    if not equipInfo then
        equipInfo = {}
        equipInfo.level = equipCfg.level
        equipInfo.stage = equipCfg.star
    end

    item.Image_bg:setTexture(EC_ItemIcon[equipCfg.quality])
    item.Image_icon:setTexture(equipCfg.icon)
    item.Image_level_bg:setTexture(EC_ItemLevelIcon[equipCfg.quality])
    item.Label_level:setText(tostring(equipInfo.level))
    item.Image_use:setVisible(string.len(equipInfo.heroId) > 1)
    local maxStar = EquipmentDataMgr:getNewEquipMaxStar(cid)
    local posArrar = EquipmentDataMgr:getNewEquipStarPosArrar(maxStar)
    for j,v in ipairs(item.stars) do
        if j <= maxStar then
            v:setVisible(true)
            v:setPositionX(-55 + (5 - maxStar) * 10 + j * 18)
            if j <= equipInfo.stage then
                v:setTexture("ui/common/star.png")
            else
                v:setTexture("ui/common/starBack.png")
            end
        else
            v:setVisible(false)
        end
    end
    local bindHero = SkyLadderDataMgr:getSkyHeroNewEquipBind(equipInfo.id)
end

function TokenReviewLayer:updateBtnState()
    self._ui.Button_rename:setTouchEnabled(false)
    self._ui.Button_rename:setGrayEnabled(true)
    local info = self.backUpInfos[self.selectIdx]
    if self.isSave then
        if info then
            self._ui.Button_save:getChildByName("Label_save"):setTextById(3202045)
        else
            self._ui.Button_save:getChildByName("Label_save"):setTextById(15011276)
        end
    else
        self._ui.Button_use:setTouchEnabled(false)
        self._ui.Button_use:setGrayEnabled(true)
        if info then
            self._ui.Button_use:setTouchEnabled(true)
            self._ui.Button_use:setGrayEnabled(false)
        end
    end
    if info then
        self._ui.Button_rename:setTouchEnabled(true)
        self._ui.Button_rename:setGrayEnabled(false)
    end
end


function TokenReviewLayer:onRecvBackUpInfo()
    self.gridViewToken:setVisible(true)
    self:updateGridUI()
end

function TokenReviewLayer:onShow()
    self.super.onShow(self)
    EquipmentDataMgr:requestTokenPlan(self.heroId)
end

return TokenReviewLayer