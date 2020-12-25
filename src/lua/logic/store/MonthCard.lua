local MonthCard = class("MonthCard", BaseLayer)

function MonthCard:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.recharge.monthCard")
end

function MonthCard:initData(data)
    self.helpIds = data[1] or {}
    self.rechargeData = data[2]
    self.showBtn = not data.noBtn
    self.pageIcons = {}
end

function MonthCard:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_tittle = TFDirector:getChildByPath(self.ui, "Label_tittle")
    self.Label_desc   = TFDirector:getChildByPath(self.ui, "Label_desc")
    self.Label_desc:setTextById("r2504");

	self.Label_monthCard_1 = TFDirector:getChildByPath(self.ui, "Label_monthCard_1")

    self.Image_head   = TFDirector:getChildByPath(self.ui,"Image_head")

	local extraData = AvatarDataMgr:getExtraData() or {}
    self.Image_head:setTexture(TabDataMgr:getData("Portrait",10003).toggle[extraData.month or 1].icon);
    self.Image_head:setSize(CCSizeMake(90,90))

    self.Label_price  = TFDirector:getChildByPath(self.ui,"Label_price");
    self.Label_price:setString("￥"..self.rechargeData.rechargeCfg.price);

    self.Button_buy   = TFDirector:getChildByPath(self.ui,"Button_buy");
    self.Button_buy:onClick(function()
            RechargeDataMgr:getOrderNO(self.rechargeData.rechargeCfg.id)
        end)

    self.PageView_item = TFDirector:getChildByPath(self.ui, "PageView_item")
    self.Panel_help_item = TFDirector:getChildByPath(self.ui, "Panel_help_item")
    self.Panel_page = TFDirector:getChildByPath(self.ui, "Panel_page")
    self.Label_text = TFDirector:getChildByPath(self.ui, "Label_text")
    self.Image_diban   = TFDirector:getChildByPath(self.ui,"Image_diban")
    self.Image_diban:setVisible(self.showBtn)

    local ScrollView_list = TFDirector:getChildByPath(self.ui, "ScrollView_list")
    if not self.showBtn then
        ScrollView_list:setContentSize(CCSizeMake(625,440))
        ScrollView_list:setPositionY(ScrollView_list:getPositionY() - 129)
    end

    self.text_list = UIListView:create(ScrollView_list)
    self.text_list:setItemsMargin(20)
    self:initContent()
end

function MonthCard:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for i, v in ipairs(self.pageIcons) do
        v:onClick(function()
            self.PageView_item:scrollToPage(i - 1, 0)
        end)
    end

    self.PageView_item:addMEListener(TFPAGEVIEW_SCROLLENDED, function()
        self:updateTitle()
    end)
	EventMgr:addEventListener(self,EV_MONTHCARD_RECHARGE_SUCESS,function(args)
		AlertManager:closeLayer(self)
	end)
end

function MonthCard:initContent()
	if (me.platform == "ios" and tonumber(TFDeviceInfo:getCurAppVersion()) >= 3.65) or me.platform == "win32" then
		local helpData = TopHelpDataMgr:getHelpDataByIds(self.helpIds)
		local textType = false
		for i,v in ipairs(helpData) do
		    if v.type == 0 then
		        textType = true
		        for i,id in ipairs(v.desc) do
		            local label = self.Label_text:clone()
		            label:setTextById(id)
		            label:setWidth(615)
		            self.text_list:pushBackCustomItem(label)
		            if i == 2 and self.helpIds[1] == 998 then --月卡续费协议
		                dump(TextDataMgr:getText(id))
		                label:setTouchEnabled(true)
		                label:onClick(function()
		                        Box(TextDataMgr:getText(id))
		                        TFDeviceInfo:openUrl(TextDataMgr:getText(id));
		                    end)
		            end
		        end
		    else
		        local item = self.Panel_help_item:clone()
		        self:updateOneItem(item, v)
		        self.PageView_item:addPage(item)
		    end
		end
		if textType then

		else
		    self.PageView_item:scrollToPage(0, 0)
		    for i,v in ipairs(self.helpIds) do
		        local pageIcon = TFImage:create("ui/common/page_controller_normal.png")
		        self.Panel_page:addChild(pageIcon)
		        pageIcon:setTouchEnabled(true)
		        pageIcon:setPositionX((#self.helpIds * -15) - 15  + i * 30)
		        self.pageIcons[i] = pageIcon
		    end
		end
		self:updateTitle()
	else
		local label = self.Label_text:clone()
		label:setTextById(15010230)
		label:setWidth(615)
		self.text_list:pushBackCustomItem(label)
		self.Label_monthCard_1:setTextById(14210305)
		--self.Label_price:setString("￥"..30);
	end    
end

function MonthCard:updateTitle()
    local curIndex = self.PageView_item:getCurPageIndex()
    local info = TopHelpDataMgr:getHelpDataById(self.helpIds[curIndex + 1])
    if info then
        self.Label_tittle:setTextById(info.title)
    end
    for i, v in ipairs(self.pageIcons) do
        if (curIndex + 1) == i then
            v:setTexture("ui/common/page_controller_select.png")
        else
            v:setTexture("ui/common/page_controller_normal.png")
        end
    end
end

function MonthCard:updateOneItem(item, helpInfo)
    local Image_line = TFDirector:getChildByPath(item, "Image_line"):hide()
    local Panel_middle = TFDirector:getChildByPath(item, "Panel_middle"):hide()
    local Panel_left = TFDirector:getChildByPath(item, "Panel_left"):hide()
    local Panel_right = TFDirector:getChildByPath(item, "Panel_right"):hide()
    local desParameter = helpInfo.desParameter[1]
    if helpInfo.type == 1 then
        Panel_middle:show()
        self:addIconsToItem(Panel_middle, helpInfo.pictureParameter)
        if desParameter then
            self:updateItemUI(Panel_middle, desParameter)
        end
    else
        Image_line:show()
        Panel_left:show()
        Panel_right:show()
        self:addIconsToItem(Panel_left, helpInfo.pictureParameter)
        if  desParameter then
            self:updateItemUI(Panel_left, desParameter)
        end
        desParameter = helpInfo.desParameter[2]
        if desParameter then
            self:updateItemUI(Panel_right, desParameter)
        end
    end
end

function MonthCard:addIconsToItem(item, pictureParameter)
    for k,v in pairs(pictureParameter) do
        local icon = TFImage:create(v.icon)
        icon:setScale(v.size)
        local pos = v.position
        icon:setPosition(ccp(pos.x, pos.y))
        item:addChild(icon)
    end
end

function MonthCard:updateItemUI(item, desParameter)
    local Image_frame = TFDirector:getChildByPath(item, "Image_frame")
    local Label_dsc = TFDirector:getChildByPath(item, "Label_dsc")

    if desParameter then
        if desParameter.type == 1 then
            Image_frame:setSize(CCSizeMake(300,120))
            Label_dsc:setDimensions(260, 0)
        else
            Image_frame:setSize(CCSizeMake(300,67))
            Label_dsc:setDimensions(260, 0)
        end
        Label_dsc:setTextById(desParameter.des)
        local pos = desParameter.position
        Image_frame:setPosition(ccp(pos.x, pos.y))
    end
end

return MonthCard