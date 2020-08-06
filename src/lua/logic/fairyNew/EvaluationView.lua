local EvaluationView = class("EvaluationView", BaseLayer)

function EvaluationView:ctor(data)
    self.super.ctor(self,data)
    self.heroId = data.heroId
    self.callfunc = data.callfunc
    self.heroOrEquip = data.heroOrEquip
    self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.evaluationViewEx")
end

function EvaluationView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Label_hero_name = TFDirector:getChildByPath(ui, "Label_hero_name")
    self.Panel_comment_item = TFDirector:getChildByPath(ui, "Panel_comment_item")
    self.ScrollView_content = TFDirector:getChildByPath(ui, "ScrollView_content")

    if self.heroOrEquip == 1 then
        self.Label_hero_name:setText(EquipmentDataMgr:getEquipName(self.heroId))
    else
        self.Label_hero_name:setText(HeroDataMgr:getNameById(self.heroId))
    end
    self.TextField_com = TFDirector:getChildByPath(ui,"TextField_com")

    self.Button_send = TFDirector:getChildByPath(ui,"Button_send")
    self.Button_cancel = TFDirector:getChildByPath(ui,"Button_cancel")

    self.Button_tab_new = TFDirector:getChildByPath(ui,"Button_tab_new")
    self.Button_tab_history    = TFDirector:getChildByPath(ui,"Button_tab_history")

    self.lableItem = TFDirector:getChildByPath(ui,"Panel_newCommentLabel")

    self.ListView_item = UIListView:create(self.ScrollView_content)
    self.ListView_item:setItemModel(self.Panel_comment_item)
    

    local params = {
        _type = EC_InputLayerType.OK,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer,1000)
    self:onTabBtnTouch(self.Button_tab_new)
    local toSendId = self.heroId

    if self.heroOrEquip == 1 then
        toSendId = EquipmentDataMgr:getEquipCid(self.heroId)
    end
    local msg = {self.heroOrEquip, toSendId}
    dump(msg)
    CommentDataMgr:sendReqAllComments(msg)
end

function EvaluationView:loadListView()
    
end

function EvaluationView:onTouchSendBtn()

end

function EvaluationView:onCloseInputLayer()
    self.TextField_com:closeIME()
end


function EvaluationView:registerEvents()
    EventMgr:addEventListener(self,EV_COMMENT_COMMENTRESULT,handler(self.onCommentResult, self));
    EventMgr:addEventListener(self,EV_COMMENT_GETCOMMENT,handler(self.onGetAllComments, self));
    EventMgr:addEventListener(self,EV_COMMENT_PRISERESULT,handler(self.onPriseResult, self));
    
    self.Button_tab_new:onClick(function()
        self:onTabBtnTouch(self.Button_tab_new)
    end)
    self.Button_tab_history:onClick(function()
        self:onTabBtnTouch(self.Button_tab_history)
    end)

    local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        input:setText(text)
        self.TextField_com:setString(text)
        self.inputLayer:listener(text)
    end

    local function onTextFieldAttachAcc(input)
        local text = input:getText()
        input:setText(text)
        self.inputLayer:show()
        self.inputLayer:listener(text)
    end

    self.TextField_com:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_com:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_com:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_send:onClick(function ()
        local text = self.TextField_com:getText()
        if #text == 0 then
            -- toastMessage("发送内容不能为空")
            Utils:showTips(800104)
        else
            local toSendId = self.heroId

            if self.heroOrEquip == 1 then
                toSendId = EquipmentDataMgr:getEquipCid(self.heroId)
            end

            self.TextField_com:setText("")

            local msg = {self.heroOrEquip, toSendId, text}
            CommentDataMgr:sendComment(msg)
        end
    end)

    self.Button_cancel:onClick(function()
            if self.callfunc then
                self.callfunc(false)
                AlertManager:close()
            end
        end)

end

function EvaluationView:onTabBtnTouch(btn)
    if self.curSelBtn == btn then
        return
    end
    self.curSelBtn = btn
    if btn == self.Button_tab_new then
        self.Button_tab_new:setTextureNormal("ui/fairy/new_ui/new_22.png")
        self.Button_tab_history:setTextureNormal("ui/fairy/new_ui/new_21.png")
    elseif btn == self.Button_tab_history then
        self.Button_tab_new:setTextureNormal("ui/fairy/new_ui/new_21.png")
        self.Button_tab_history:setTextureNormal("ui/fairy/new_ui/new_22.png")
    end
end

function EvaluationView:onHide()
    self.super.onHide(self)
end

function EvaluationView:removeUI()
    self.super.removeUI(self)
end

function EvaluationView:onCommentResult()
    local toSendId = self.heroId

    if self.heroOrEquip == 1 then
        toSendId = EquipmentDataMgr:getEquipCid(self.heroId)
    end
    local msg = {self.heroOrEquip, toSendId}
    CommentDataMgr:sendReqAllComments(msg)
end

function EvaluationView:onPriseResult()
    self.toPriseImg:setColor(ccc3(100,163,200))
    CCUserDefault:sharedUserDefault():setStringForKey(MainPlayer:getPlayerId() .. self.toPrisePlayerId .. self.toPriseDate, "up")
    self.upNumLabel:setText(self.nowPriseNum + 1)
end

function EvaluationView:onGetAllComments(data)
    self.ListView_item:removeAllItems()
    local function handleEachInfo(info)
        for i, v in ipairs(info) do
            local item = self.Panel_comment_item:clone()
            local playerName = TFDirector:getChildByPath(item, "Label_name")
            local comment = TFDirector:getChildByPath(item, "Label_desc")
            local upNum = TFDirector:getChildByPath(item, "Label_up_num")
            local playerIcon = TFDirector:getChildByPath(item, "Image_icon")
            local playerId = TFDirector:getChildByPath(item, "Label_number")
            local Image_up = TFDirector:getChildByPath(item, "Image_up")
            local Image_item_bg = TFDirector:getChildByPath(item, "Image_item_bg")
            if  CCUserDefault:sharedUserDefault():getStringForKey(MainPlayer:getPlayerId() .. v.playerId .. v.commentDate) == "up" then
                Image_up:setTexture("ui/fairy/new_ui/new_45_1.png")
            end
            if MainPlayer:getPlayerId() == v.playerId then
                Image_item_bg:setTexture("ui/fairy/new_ui/new_43_1.png")
            end
            Image_up:onClick(function()
                if  CCUserDefault:sharedUserDefault():getStringForKey(MainPlayer:getPlayerId() .. v.playerId .. v.commentDate) == "up" then
                    return
                end
                if MainPlayer:getPlayerId() == v.playerId then
                   -- Utils:showTips(600020)
                end
                local tempImg = TFImage:create("ui/fairy/new_ui/new_45.png")
                Image_up:addChild(tempImg)
                local scale = ScaleTo:create(0.2, 1.5)
                local fade = FadeOut:create(0.2)
                local remove = CallFunc:create(function() tempImg:removeFromParent() end)
                local spw = {scale, fade}
                local seq = {Spawn:create(spw), remove}
                tempImg:runAction(Sequence:create(seq))
                local toSendId = self.heroId

                if self.heroOrEquip == 1 then
                    toSendId = EquipmentDataMgr:getEquipCid(self.heroId)
                end
                local msg = {v.playerId, self.heroOrEquip, toSendId, item:getTag()}
                CommentDataMgr:sendUp(msg)
                self.toPriseImg = Image_up
                self.toPrisePlayerId = v.playerId
                self.toPriseDate = v.commentDate
                self.nowPriseNum = v.prise
                self.upNumLabel = upNum
                end)
            playerName:setText(v.name)
            comment:setText(v.comment)
            upNum:setText(v.prise < 9999 and v.prise or "9999+")
            playerId:setText(v.playerId)
            item:setTag(v.commentDate)
            playerIcon:setTexture(HeroDataMgr:getSmallIconPathByIdInEvaview(v.heroId))

            self.ListView_item:pushBackCustomItem(item)
        end
    end
    if data.hotInfo then
        handleEachInfo(data.hotInfo)
    end
    if data.newInfo then
        local lableItem = self.lableItem:clone()
        self.ListView_item:pushBackCustomItem(lableItem)
        handleEachInfo(data.newInfo)
    end

end

return EvaluationView