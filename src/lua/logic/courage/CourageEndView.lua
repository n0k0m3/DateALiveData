local CourageEndView = class("CourageEndView", BaseLayer)

function CourageEndView:initData()

    self.gongnewImgRes = {"014.png","015.png","016.png","017.png","018.png","019.png","020.png"}

    self.barEnd = true
    self.flyIconEnd = true

end

function CourageEndView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.courage.courageEndView")
end

function CourageEndView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_root, "Label_desc")
    self.Label_ap_value = TFDirector:getChildByPath(self.Panel_root, "Label_ap_value")
    self.LoadingBar_ap = TFDirector:getChildByPath(self.Panel_root, "LoadingBar_ap")
    self.Image_gongnue = TFDirector:getChildByPath(self.Panel_root, "Image_gongnue")
    local ScrollView_item = TFDirector:getChildByPath(self.Panel_root, "ScrollView_item")
    self.ListView_item = UIListView:create(ScrollView_item)

    self.Image_fly = TFDirector:getChildByPath(self.Panel_root, "Image_fly"):hide()
    self.Image_icon = TFDirector:getChildByPath(self.Image_fly, "Image_icon")
    self.Label_num = TFDirector:getChildByPath(self.Image_fly, "Label_num")
    self.beginPos = self.Image_fly:getPosition()


    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch"):hide()
    self.Panel_touch:setSize(GameConfig.WS)

    self.Label_tip = TFDirector:getChildByPath(self.Panel_root, "Label_tip")
    self.Label_tip2 = TFDirector:getChildByPath(self.Panel_root, "Label_tip2")

    self.Panel_hero = TFDirector:getChildByPath(self.Panel_root, "Panel_hero")
    self.panelItemContent = self.Panel_hero:getContentSize()
    self.Panel_head = TFDirector:getChildByPath(self.Panel_root, "Panel_head")
    self.headSize =  self.Panel_head:getContentSize()

    self.Spine_star = TFDirector:getChildByPath(self.Panel_root, "Spine_star"):hide()

    self.Panel_item = TFDirector:getChildByPath(self.Panel_root, "Panel_item")

    self.Panel_gameover = TFDirector:getChildByPath(self.Panel_root, "Panel_gameover"):hide()

    self:initUILogic()
end

function CourageEndView:initUILogic()

    self.script,self.rewardInfo,self.apItemInfo = CourageDataMgr:getEndInfo()
    self.script = self.script or {}
    self.rewardInfo = self.rewardInfo or {}
    self.apItemInfo = self.apItemInfo or {}
    self.Label_desc:setTextById(13311706)
    --self.script[1] = 385
    --self.apItemInfo["id"] = 522022
    --self.apItemInfo["num"] = 7
    dump(self.script)
    dump(self.rewardInfo)
    dump(self.apItemInfo)
    if #self.script == 0 then
        self.Panel_gameover:show()
        self:timeOut(function()
            self:exitGame()
        end,2)
    else
        self:updateApVlaue()
        self:updateHeroItem()
    end


end

function CourageEndView:updateApVlaue()
    local apInfo = CourageDataMgr:getApInfo()
    if not apInfo then
        return
    end
    local cur,max = apInfo.value,apInfo.limit
    cur = cur >= 0 and cur or 0
    max = max == 0 and 1 or max
    local percent = math.floor(cur/max*100)
    self.LoadingBar_ap:setPercent(percent)
    self.Label_ap_value:setText(cur.."/"..max)
end

function CourageEndView:updateHeroItem()

    self.Label_tip:setText("攻略达成")
    self.Label_tip2:setText("Exparerice")

    self.Panel_hero:setOpacity(255)
    local cellWidth = self.headSize.width+5
    local firstPosX = 0
    self.script = self.script or {}
    for k,v in ipairs(self.script) do
        local headItem = self.Panel_head:clone()
        local x = firstPosX + (k-1)*cellWidth
        headItem:setPosition(ccp(x,2))
        self.Panel_hero:addChild(headItem)
        local cfg = TabDataMgr:getData("DatingRule")[v]
        if cfg then
            local Image_icon = TFDirector:getChildByPath(headItem, "Image_icon")
            Image_icon:setTexture(cfg.iconPortail)
        end
    end
    self.id = 0
    local seq = CCSequence:create({
        CCMoveBy:create(0.5,ccp(-cellWidth,0)),
        CCCallFunc:create(function()
            self.id = self.id + 1
            if self.id > #self.script then
                self:timeOut(function()
                    self:updateItem()
                end,0.5)
                self.Panel_hero:stopAllActions()
                return
            end
            if self.id >= #self.script then
                self.Panel_hero:stopAllActions()
                local act = CCSequence:create({
                    CCDelayTime:create(1),
                    CCFadeOut:create(0.2),
                    CCCallFunc:create(function()
                        self:timeOut(function()
                            self:updateItem()
                        end,0.5)
                        self.Panel_hero:stopAllActions()
                    end)
                })
                self.Panel_hero:runAction(act)
            end
            if self.gongnewImgRes[self.id] then
                self.Image_gongnue:setTexture("ui/activity/courage/end/"..self.gongnewImgRes[self.id])
            end
            if self.id == 3 or self.id == 5 then
                self.Spine_star:setVisible(true)
                self.Spine_star:play("award",false)
            elseif self.id == 7 then
                self.Spine_star:play("award_loop",true)
            end
        end)
    })
    self.Panel_hero:runAction(CCRepeatForever:create(seq))
end

function CourageEndView:updateItem()

    local apInfo = CourageDataMgr:getApInfo()
    if not apInfo then
        return
    end
    local cur,max = apInfo.value,apInfo.limit

    self.Label_tip:setText("奖励展示")
    self.Label_tip2:setText("Award")

    local cellWidth = self.headSize.width+10
    local item = {}
    for k,v in ipairs(self.rewardInfo) do
        table.insert(item,{id = v.id, num = v.num})
    end

    local apId,apNum = self.apItemInfo["id"],self.apItemInfo["num"]
    if apId and apNum then
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setAnchorPoint(ccp(0,0))
        PrefabDataMgr:setInfo(Panel_goodsItem, apId)
        Panel_goodsItem:setPosition(ccp(0,0))
        self.Image_icon:addChild(Panel_goodsItem)
    end

    for k,v in ipairs(item) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setAnchorPoint(ccp(0,0))
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        local x = (k-1)*cellWidth
        Panel_goodsItem:setPosition(ccp(x,2))
        self.Panel_item:addChild(Panel_goodsItem)
    end

    self.id = 0
    if #item >= 1 then
        local seq = CCSequence:create({
            CCMoveBy:create(0.2,ccp(-cellWidth,0)),
            CCCallFunc:create(function()
                self.id = self.id + 1
                if self.id >= #item then
                    self.Panel_item:stopAllActions()
                    self.Image_fly:setVisible(true)
                    self:updateBarAnimate()
                end
            end)
        })
        self.Panel_item:runAction(CCRepeatForever:create(seq))
    else
        self:updateBarAnimate()
        self.Image_fly:setVisible(true)
    end
end

function CourageEndView:updateBarAnimate()

    local apInfo = CourageDataMgr:getApInfo()
    if not apInfo then
        return
    end
    local cur,max = apInfo.value,apInfo.limit
    local pos = self.Panel_item:getPosition()
    pos = self.Panel_item:getParent():convertToWorldSpaceAR(pos)
    pos = self.Panel_root:convertToNodeSpaceAR(pos)
    pos = ccp(pos.x  - 110 - 2,pos.y+2)

    local targetNum = self.apItemInfo["num"]
    self.num = 0
    self.Label_num:setText(targetNum)
    if targetNum and targetNum >= 1 then
        local perTime = 1/targetNum
        self.flyIconEnd = false
        local act = CCSequence:create({
            CCDelayTime:create(perTime),
            CCCallFunc:create(function()
                self.num = self.num + 1
                if self.num <= targetNum then
                    self.Label_num:setText(self.num)
                else
                    self.Label_num:stopAllActions()
                    local act = CCSequence:create({
                        CCMoveTo:create(0.5,pos),
                        CCCallFunc:create(function()
                            self.flyIconEnd = true
                            if self.barEnd then
                                self.Panel_touch:setVisible(true) 
                            end
                        end)
                    })
                    self.Image_fly:runAction(act)
                end
            end)
        })
        self.Label_num:runAction(CCRepeatForever:create(act))
    end

    self.barEnd = false
    local function updateCallBack()
        local cur = math.ceil(self.LoadingBar_ap:getPercent() / 100 * max)
        self.Label_ap_value:setText(cur.."/"..max)
    end

    local function perCallback()
        self.barEnd = true
        if self.flyIconEnd then
            self.Panel_touch:setVisible(true)
        end
    end
    Utils:loadingBarChangeActionInTime(self.LoadingBar_ap,0,1,perCallback,perCallback, updateCallBack)
end

function CourageEndView:exitGame()
    EventMgr:dispatchEvent(EV_COURAGE.EV_COURAGE_END)
    AlertManager:closeLayer(self)
end

function CourageEndView:registerEvents()

    self.Panel_touch:onClick(function()
        self:exitGame()
    end)

    self.Panel_gameover:onClick(function()
        self:exitGame()
    end)
end


return CourageEndView
