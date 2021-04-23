local ConcealProto = class("ConcealProto", BaseLayer)

function ConcealProto:ctor(data)
    self.super.ctor(self)
    self:init("lua.uiconfig.loginScene.concealProto")
end


function ConcealProto:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self.Button_close = TFDirector:getChildByPath(self.ui,"Button_close")	
	self.Button_ok = TFDirector:getChildByPath(self.ui,"Button_ok")
	self:showPopAnim(true)

	local ScrollView_desc = TFDirector:getChildByPath(self.ui, "ScrollView_desc")
    self.ListView_desc = UIListView:create(ScrollView_desc)
    self.Label_title_model = TFDirector:getChildByPath(self.ui, "Label_title_model")
    self.Label_desc_model = TFDirector:getChildByPath(self.ui, "Label_desc_model")
    self.Label_name_model = TFDirector:getChildByPath(self.ui, "Label_name_model")

    local Image_scrollBarModel = TFDirector:getChildByPath(self.ui, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.ListView_desc:setScrollBar(scrollBar)
    self.ListView_desc:setItemsMargin(5)
    local Label_name = TFDirector:getChildByPath(self.ui, "Label_name")
    Label_name:setTextById(15010512)
    self.Button_ok:setVisible(not LogonHelper:isAgreedProto())
    self.ui:setTouchEnabled(true)
	self:initContent()
end

function ConcealProto:initContent()
    local stringIds = TabDataMgr:getData("DiscreteData",90041).data.stringId2
    local size = self.ListView_desc:getContentSize()
    for i,ID in ipairs(stringIds) do
        if ID >= 15010500 and ID <= 15010999 then
            local Label_content = self.Label_title_model:clone():Show()
            Label_content:setTextById(ID)
            Label_content:setDimensions(size.width, 0)
            self.ListView_desc:pushBackCustomItem(Label_content)
        else
            local Label_content1 = self.Label_desc_model:clone():Show()
            Label_content1:setTextById(ID)
            Label_content1:setDimensions(size.width, 0)
            self.ListView_desc:pushBackCustomItem(Label_content1)
        end
        if ID == 15011014 then
            local img = TFImage:create("ui/login/conceal01.png")
            self.ListView_desc:pushBackCustomItem(img)
        end
    end
    local Label_name_model = self.Label_name_model:clone():Show()
    Label_name_model:setTextById(15011030)
    self.ListView_desc:pushBackCustomItem(Label_name_model)
end

function ConcealProto:registerEvents()

	self.Button_close:onClick(function()
        if not LogonHelper:isAgreedProto() then
            LogonHelper:setAgreeConcealProto(false)
            LogonHelper:setAgreeUserProto(false)
        end
        self:getParent():removeLayer(self,true)
    end)


	self.Button_ok:onClick(function()
        LogonHelper:setAgreeConcealProto(true)
        if LogonHelper:isAgreedUserProto() then
            LogonHelper:setAgreeProto(true)
        else
            Utils:openView("login.UserProto")
        end
        self:getParent():removeLayer(self,true)
    end)

end

return ConcealProto
