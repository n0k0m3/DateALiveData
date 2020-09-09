
local LeagueSendRedPacketView = class("LeagueSendRedPacketView", BaseLayer)
require("lua.logic.common.ChooseMessageBox")

function LeagueSendRedPacketView:initData(packetType)
    self.packetType_ = packetType or 1
end

function LeagueSendRedPacketView:ctor(packetType)
    self.super.ctor(self)
    self:initData(packetType)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.leagueSendRedPacketView")
end

function LeagueSendRedPacketView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_base = TFDirector:getChildByPath(ui, "Panel_base")
    self.Panel_content = TFDirector:getChildByPath(ui, "Panel_content")

    self.Button_close = TFDirector:getChildByPath(self.Panel_content, "Button_close")
    self.Image_packet_bg = TFDirector:getChildByPath(self.Panel_content, "Image_packet_bg")
    self.Label_total_num = TFDirector:getChildByPath(self.Panel_content, "Label_total_num")
    self.Label_get_exp_desc = TFDirector:getChildByPath(self.Panel_content, "Label_get_exp_desc")
    self.Label_name = TFDirector:getChildByPath(self.Panel_content, "Label_name")
    self.Label_tips = TFDirector:getChildByPath(self.Panel_content, "Label_tips")
    
    self.Label_count = TFDirector:getChildByPath(self.Panel_content, "Label_count")
    self.TextField_zhufuyu = TFDirector:getChildByPath(self.Panel_content, "TextField_zhufuyu")
    self.Label_zhufuyu = TFDirector:getChildByPath(self.Panel_content, "Label_zhufuyu")
    self.Label_send_limit = TFDirector:getChildByPath(self.Panel_content, "Label_send_limit")

    self.Image_cost_bg = TFDirector:getChildByPath(self.Panel_content, "Image_cost_bg")
    self.Image_res_icon = TFDirector:getChildByPath(self.Panel_content, "Image_res_icon")
    self.Label_res_num = TFDirector:getChildByPath(self.Panel_content, "Label_res_num")
    self.Button_buy = TFDirector:getChildByPath(self.Panel_content, "Button_buy")
    self.Label_price = TFDirector:getChildByPath(self.Button_buy, "Label_price")
    self.Button_send = TFDirector:getChildByPath(self.Panel_content, "Button_send")
    self.Button_left = TFDirector:getChildByPath(self.Panel_content, "Button_left")
    self.Button_right = TFDirector:getChildByPath(self.Panel_content, "Button_right")
    self.Button_close = TFDirector:getChildByPath(self.Panel_content, "Button_close")

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

    self:refreshView()
end

function LeagueSendRedPacketView:onTouchSendBtn()
    self.TextField_zhufuyu:setText(self.Label_zhufuyu:getText())
end

function LeagueSendRedPacketView:onCloseInputLayer()
    self.TextField_zhufuyu:closeIME()
end

function LeagueSendRedPacketView:refreshView()
   local packetCfg = LeagueDataMgr:getPacketCfgByType(self.packetType_)
   if self.packetType_ == 1 then
        self.Label_tips:setTextById(270358)
        self.Image_cost_bg:setVisible(true)
        self.Button_send:setVisible(true)
        self.Button_buy:setVisible(false)
        if packetCfg.cost[1][1] then
            local itemCfg = GoodsDataMgr:getItemCfg(packetCfg.cost[1][1])
            local count = GoodsDataMgr:getItemCount(EC_SItemType.UNION_REDPACKET)
            if count > 0 then
                self.Image_res_icon:setTexture("ui/league/ui_49.png")
                self.Image_res_icon:setScale(0.6)
                self.Label_res_num:setText("1/"..count)
            else
                self.Image_res_icon:setTexture(itemCfg.icon)
                self.Image_res_icon:setScale(0.4)
                self.Label_res_num:setText(packetCfg.cost[1][2])
                if GoodsDataMgr:getItemCount(packetCfg.cost[1][1]) < packetCfg.cost[1][2] then
                    self.Label_res_num:setColor(ccc3(219,50,50))
                else
                    self.Label_res_num:setFontColor(ccc3(255,255,255))
                end
            end
        end
        self.Image_packet_bg:setTexture("ui/league/ui_45.png")
        self.Label_name:setTextById(270455)
   else
        self.Label_tips:setTextById(270359)
        self.Image_cost_bg:setVisible(false)
        self.Image_packet_bg:setTexture("ui/league/ui_08.png")
        self.Label_name:setTextById(270456)
        self.Button_send:setVisible(false)
        self.Button_buy:setVisible(true)
        local cfg = RechargeDataMgr:getOneRechargeCfg(packetCfg.rechargeID)
        self.Label_price:setTextById(1605003 , cfg.rechargeCfg.price * 0.01)
   end
   self.Label_total_num:setText("x"..packetCfg.bonus)
   
   self.Label_count:setTextById(270360, packetCfg.numbers)
   local surplsTimes = LeagueDataMgr:getSendPacketSurplsTimes(packetCfg.id)
   self.Label_send_limit:setTextById(270362, surplsTimes)
end

function LeagueSendRedPacketView:sendRedPacketSuccess()
    AlertManager:closeLayer(self)
end

function LeagueSendRedPacketView:onUnionInfoReset()
    AlertManager:closeLayer(self)
end

function LeagueSendRedPacketView:onQuitUnionBack()
    AlertManager:closeAll()
    AlertManager:changeScene(SceneType.MainScene)
end

function LeagueSendRedPacketView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_QUIT_UNION, handler(self.onQuitUnionBack, self))
    EventMgr:addEventListener(self, EV_UNION_SEND_PACKET_SUCCESS, handler(self.sendRedPacketSuccess, self))
    EventMgr:addEventListener(self, EV_RECHARGE_UPDATE, handler(self.sendRedPacketSuccess, self))
    EventMgr:addEventListener(self, EV_UNION_INFO_RESET, handler(self.onUnionInfoReset, self))

    local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        local list = string.UTF8ToCharArray(text)
        if #list <= 25 then
            self.Label_zhufuyu:setText(input:getText())
            self.inputLayer:listener(input:getText())
        end
        if string.len(self.Label_zhufuyu:getText()) < 1 then
            self.Label_zhufuyu:setTextById(270361)
        end
    end

    local function onTextFieldAttachAcc(input)
        local text = ""
        input:setText(text)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
    end

    self.TextField_zhufuyu:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_zhufuyu:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_zhufuyu:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Label_zhufuyu:onClick(function()
        self.Label_zhufuyu.isSet = true
        self.TextField_zhufuyu:openIME()
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_send:onClick(function()
        local packetCfg = LeagueDataMgr:getPacketCfgByType(self.packetType_)
        local surplsTimes = LeagueDataMgr:getSendPacketSurplsTimes(packetCfg.id)
        if surplsTimes < 1 then
            Utils:showTips(270416)
            return
        end
        local text = self.Label_zhufuyu:getText()
        if GoodsDataMgr:getItemCount(EC_SItemType.UNION_REDPACKET) > 0 then
            LeagueDataMgr:SendRedPacket(packetCfg.id, text)
        else
            local cost = packetCfg.cost[1][2]
            if GoodsDataMgr:getItemCount(packetCfg.cost[1][1]) < cost then
                    Utils:showTips(800048)
                return
            end
            showChooseMessageBox(TextDataMgr:getText(800011), TextDataMgr:getText(276011, cost), function()
                AlertManager:close()
                LeagueDataMgr:SendRedPacket(packetCfg.id, text)
            end)
        end
    end)

    self.Button_buy:onClick(function()
        local packetCfg = LeagueDataMgr:getPacketCfgByType(self.packetType_)
        local text = self.Label_zhufuyu:getText()
        local info = {cid = tostring(packetCfg.id), bless = text}
        local string = json.encode(info)
        RechargeDataMgr:getOrderNO(packetCfg.rechargeID, string)
    end)

    self.Button_left:onClick(function()
        if self.packetType_ == 1 then
            self.packetType_ = 2
        else
            self.packetType_ = 1
        end
        self:refreshView()
    end)

    self.Button_right:onClick(function()
        if self.packetType_ == 1 then
            self.packetType_ = 2
        else
            self.packetType_ = 1
        end
        self:refreshView()
    end)
end

return LeagueSendRedPacketView
