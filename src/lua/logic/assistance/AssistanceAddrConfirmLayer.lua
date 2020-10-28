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
*  ºÃÓÑÖúÁ¦
* 
]]

local AssistanceAddrConfirmLayer = class("AssistanceAddrConfirmLayer", BaseLayer)

function AssistanceAddrConfirmLayer:ctor( data )
    self.super.ctor(self, data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.assistance.assistanceAddrConfirmLayer")
end

function AssistanceAddrConfirmLayer:initData( data )
    self.modelPanelList = {}

    local json = require("LuaScript.extends.json")
    if data and data.address and data.address ~= "" then
        self.address = json.decode(data.address)
    end  
end

function AssistanceAddrConfirmLayer:initUI( ui )
	self.super.initUI(self, ui)
    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.okBtn = TFDirector:getChildByPath(self.rootPanel, "btn_ok")
    local infoScrollView = TFDirector:getChildByPath(self.rootPanel, "scrollView_info")
    self.infoUIListView = UIListView:create(infoScrollView)

    for i=1,5 do
        local modelPanel = TFDirector:getChildByPath(ui, "panel_model_" ..i)
        modelPanel:hide()
        table.insert(self.modelPanelList, modelPanel)
    end

    self:updateUI()
end

function AssistanceAddrConfirmLayer:onShow( )
    self.super.onShow(self)
end

function AssistanceAddrConfirmLayer:updateUI( )
    self.infoUIListView:removeAllItems()

    local namePanel = self.modelPanelList[1]:clone()
    self:updateNamePanel(namePanel)
    namePanel:show()
    self.infoUIListView:pushBackCustomItem(namePanel)

    local addressPanel = self.modelPanelList[2]:clone()
    self:updateAddressPanel(addressPanel)
    addressPanel:show()
    self.infoUIListView:pushBackCustomItem(addressPanel)

    local postPanel = self.modelPanelList[3]:clone()
    self:updatePostPanel(postPanel)
    postPanel:show()
    self.infoUIListView:pushBackCustomItem(postPanel)

    local telPanel = self.modelPanelList[4]:clone()
    self:updateTelPanel(telPanel)
    telPanel:show()
    self.infoUIListView:pushBackCustomItem(telPanel)

    local faceBookPanel = self.modelPanelList[5]:clone()
    self:updateFaceBookPanel(faceBookPanel)
    faceBookPanel:show()
    self.infoUIListView:pushBackCustomItem(faceBookPanel)
end

function AssistanceAddrConfirmLayer:updateNamePanel( panel )   
    local valueLabel = TFDirector:getChildByPath(panel, "label_value")
    valueLabel:setText("")
    if self.address == nil then return end
    local name = self.address.name
    valueLabel:setText(name)
end

function AssistanceAddrConfirmLayer:updateAddressPanel( panel )
    local valueLabel = TFDirector:getChildByPath(panel, "label_value")
    valueLabel:setText("")
    if self.address == nil then return end
    local oriSize = valueLabel:getSize()
    local address = self.address.address
    valueLabel:setText(address)
    local newSize = valueLabel:getContentSize()
    local addHeight = math.max(0, newSize.height - oriSize.height)
    panel:setContentSize(CCSize(panel:getContentSize().width, panel:getContentSize().height + addHeight))
end

function AssistanceAddrConfirmLayer:updatePostPanel( panel )  
    local valueLabel = TFDirector:getChildByPath(panel, "label_value")
    valueLabel:setText("")
    if self.address == nil then return end
    local post = self.address.post
    valueLabel:setText(post)
end

function AssistanceAddrConfirmLayer:updateTelPanel( panel )
    local valueLabel = TFDirector:getChildByPath(panel, "label_value")
    valueLabel:setText("")
    if self.address == nil then return end
    local tel = self.address.tel
    valueLabel:setText(tel)
end

function AssistanceAddrConfirmLayer:updateFaceBookPanel( panel )
    local valueLabel = TFDirector:getChildByPath(panel, "label_value")
    valueLabel:setText("")
    if self.address == nil then return end
    local faceBook = self.address.faceBook  
    valueLabel:setText(faceBook)
end

function AssistanceAddrConfirmLayer:registerEvents( )
	self.super.registerEvents(self)

    self.okBtn:onClick(function(sender)
        AlertManager:closeLayer(self)
    end)
end

function AssistanceAddrConfirmLayer:removeEvents( )
    self.super.removeEvents(self)
end

return AssistanceAddrConfirmLayer
