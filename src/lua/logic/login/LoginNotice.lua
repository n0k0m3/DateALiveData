local LoginNotice = class("LoginNotice", BaseLayer)

function LoginNotice:ctor(data)
    self.super.ctor(self)
    self.callBack = data;
    self:init("lua.uiconfig.loginScene.loginNotice")
end


function LoginNotice:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self.Button_close = TFDirector:getChildByPath(self.ui,"Button_close")	
	self.Button_ok = TFDirector:getChildByPath(self.ui,"Button_ok")
	self:showPopAnim(true)

	local ScrollView_desc = TFDirector:getChildByPath(self.ui, "ScrollView_desc")
    self.ListView_desc = UIListView:create(ScrollView_desc)
    self.Label_contentCloneObj = TFDirector:getChildByPath(self.ui, "Label_contentCloneObj")

    local Image_scrollBarModel = TFDirector:getChildByPath(self.ui, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.ListView_desc:setScrollBar(scrollBar)
    self.ListView_desc:setItemsMargin(5)
    
	self:initContent()
end

function LoginNotice:initContent()

    local size = self.ListView_desc:getContentSize()
    local Label_content = self.Label_contentCloneObj:clone():Show()
    Label_content:setTextById(1550008)
    Label_content:setFontSize(30)
    Label_content:setFontColor(me.RED)
    Label_content:setDimensions(size.width, 0)
    self.ListView_desc:pushBackCustomItem(Label_content)

    local Label_content1 = self.Label_contentCloneObj:clone():Show()
    Label_content1:setTextById(1550009)
    Label_content1:setDimensions(size.width, 0)
    self.ListView_desc:pushBackCustomItem(Label_content1)

end

function LoginNotice:registerEvents()

	self.Button_close:onClick(function()
        local currentScene = Public:currentScene();
        if currentScene.__cname == "LoginScene" then
            self:removeFromParent();
        else
            AlertManager:closeLayer(self)
        end
    end)


	self.Button_ok:onClick(function()
        if self.callBack then
            self.callBack();
        end
        local currentScene = Public:currentScene();
        if currentScene.__cname == "LoginScene" then
            self:removeFromParent();
        else
            AlertManager:closeLayer(self)
        end
    end)

end

return LoginNotice
