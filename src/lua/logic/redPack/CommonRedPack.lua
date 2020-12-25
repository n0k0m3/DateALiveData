--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 通用红包发送界面
]]


local CommonRedPack = class("CommonRedPack", BaseLayer)
require("lua.logic.common.ChooseMessageBox")

function CommonRedPack:initData(packetIds)
    local packetIds = {}

    local packetCfg = TabDataMgr:getData("Packet")
    for k,v in pairs(packetCfg) do
        if v.type == 1 and v.show then
            table.insert( packetIds, v.id )
        end
    end

    self.packetIds = packetIds
    self.curIdx = 1
end

function CommonRedPack:ctor()
    self.super.ctor(self)
    self:initData(packetIds)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.commonSendRedPacketView")
end

function CommonRedPack:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_base = TFDirector:getChildByPath(ui, "Panel_base")
    self.Panel_content = TFDirector:getChildByPath(ui, "Panel_content")

    self.Button_close = TFDirector:getChildByPath(self.Panel_content, "Button_close")
    self.Image_packet_bg = TFDirector:getChildByPath(self.Panel_content, "Image_packet_bg")
    self.Label_total_num = TFDirector:getChildByPath(self.Panel_content, "Label_total_num")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_content, "Label_desc")
    self.Label_name = TFDirector:getChildByPath(self.Panel_content, "Label_name")
    self.Label_tips = TFDirector:getChildByPath(self.Panel_content, "Label_tips")
    
    self.Label_count = TFDirector:getChildByPath(self.Panel_content, "Label_count")
    self.TextField_zhufuyu = TFDirector:getChildByPath(self.Panel_content, "TextField_zhufuyu")
    self.Label_zhufuyu = TFDirector:getChildByPath(self.Panel_content, "Label_zhufuyu")
    self.Label_send_limit = TFDirector:getChildByPath(self.Panel_content, "Label_send_limit")

    self.Image_cost_bg = TFDirector:getChildByPath(self.Panel_content, "Image_cost_bg")
    self.Image_res_icon = TFDirector:getChildByPath(self.Panel_content, "Image_res_icon")
    self.Label_res_num = TFDirector:getChildByPath(self.Panel_content, "Label_res_num")
    self.Button_send = TFDirector:getChildByPath(self.Panel_content, "Button_send")
    self.Button_left = TFDirector:getChildByPath(self.Panel_content, "Button_left")
    self.Button_right = TFDirector:getChildByPath(self.Panel_content, "Button_right")
    self.Button_close = TFDirector:getChildByPath(self.Panel_content, "Button_close")
    self.Button_left:setVisible(#self.packetIds > 1)
    self.Button_right:setVisible(#self.packetIds > 1)

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

function CommonRedPack:onTouchSendBtn()
    self.TextField_zhufuyu:setText(self.Label_zhufuyu:getText())
end

function CommonRedPack:onCloseInputLayer()
    self.TextField_zhufuyu:closeIME()
end

function CommonRedPack:refreshView()
    local packetCfg = TabDataMgr:getData("Packet",self.packetIds[self.curIdx])
    self.Label_tips:setTextById(packetCfg.text)
    self.Image_cost_bg:setVisible(true)
    self.Button_send:setVisible(true)
    local costId,num = next(packetCfg.cost)
    if costId then
        local itemCfg = GoodsDataMgr:getItemCfg(costId)
        self.Image_res_icon:setTexture(itemCfg.icon)
        self.Image_res_icon:setScale(0.4)
        self.Image_res_icon:setTouchEnabled(true)
        self.Image_res_icon:onClick(function ( ... )
            Utils:showInfo(costId)
        end)
        self.Label_res_num:setText(num)
        if GoodsDataMgr:getItemCount(costId) < num then
            self.Label_res_num:setColor(ccc3(219,50,50))
        else
            self.Label_res_num:setFontColor(ccc3(255,255,255))
        end
    end
    self.Image_packet_bg:setTexture(packetCfg.icon)
    -- self.Label_name:setTextById(270455)
    local id,maxItem = next(packetCfg.item)   
    self.Label_total_num:setText("x"..maxItem)
   
    self.Label_count:setTextById(270360, packetCfg.count)
    local envelopeInfo = EnvelopeDataMgr:getRedEnvelopeInfo(packetCfg.id)
    self.Label_send_limit:setTextById(270362, math.max(0, packetCfg.send - envelopeInfo.sendCount))
end

function CommonRedPack:sendRedPacketSuccess()
    AlertManager:closeLayer(self)
end

function CommonRedPack:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_SEND_PACKET_SUCCESS, handler(self.sendRedPacketSuccess, self))
    EventMgr:addEventListener(self, EV_RECHARGE_UPDATE, handler(self.sendRedPacketSuccess, self))

    local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        local list = string.UTF8ToCharArray(text)
        if #list <= 10 then
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

    --self.Label_zhufuyu:onClick(function()
    --    self.Label_zhufuyu.isSet = true
    --    self.TextField_zhufuyu:openIME()
    --end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_send:onClick(function()

        local packetId = self.packetIds[self.curIdx]
        local packetCfg = TabDataMgr:getData("Packet",packetId)
        local envelopeInfo = EnvelopeDataMgr:getRedEnvelopeInfo(packetId)

        if envelopeInfo.sendCount >= packetCfg.send then
            Utils:showTips(14300101,packetCfg.send)
            return
        end

        local time = math.ceil(ServerDataMgr:getServerTime() - envelopeInfo.lastTime/1000)
        if time < packetCfg.interval then
            Utils:showTips(14300104, packetCfg.interval - time)
            return
        end

        local costId,cost = next(packetCfg.cost)
        if GoodsDataMgr:getItemCount(costId) < cost then
            Utils:showTips(14300108)
            return
        end
        local itemName = TextDataMgr:getText(GoodsDataMgr:getItemCfg(costId).nameTextId)
        showChooseMessageBox(TextDataMgr:getText(800011), TextDataMgr:getText(14300109, cost,itemName), function()
            AlertManager:close()
            AlertManager:closeLayer(self)
            EnvelopeDataMgr:triggerEnvelopeRsp(packetId, self.Label_zhufuyu:getText())
        end)
    end)

    self.Button_left:onClick(function()
        if self.curIdx == 1 then
            self.curIdx = #self.packetIds
        else
            self.curIdx = self.curIdx - 1
        end
        self:refreshView()
    end)

    self.Button_right:onClick(function()
       if self.curIdx == #self.packetIds then
            self.curIdx = 1
        else
            self.curIdx = self.curIdx + 1
        end
        self:refreshView()
    end)
end

return CommonRedPack
