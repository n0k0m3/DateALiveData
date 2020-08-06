local NewCityLoadView = class("NewCityLoadView", BaseLayer)

function NewCityLoadView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.newCity.newCityLoadView")
end

function NewCityLoadView:registerEvents()
    EventMgr:addEventListener(self, EV_NEW_CITY.resLoadStatus, handler(self.onLoadStatus, self))
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update then
        EventMgr:addEventListener(self, EV_NEW_CITY.cityUpdate, handler(self.onCityUpdate, self))
    end
end

function NewCityLoadView:onExit()
    self.super.onExit(self)
end

function NewCityLoadView:initData()
    local pDirector = CCDirector:sharedDirector();
    local frameSize = pDirector:getOpenGLView():getFrameSize();
    local baseSize = CCSize(1136 , 640);
    self.realSize = CCSize(math.ceil(frameSize.width * baseSize.height / frameSize.height) , baseSize.height);
end

function NewCityLoadView:initUI(ui)
    self.super.initUI(self,ui)

    self.label_tip = TFDirector:getChildByPath(ui,"Label_tip"):hide()
    self.label_percent = TFDirector:getChildByPath(ui,"Label_percent")
    self.loadingBar = TFDirector:getChildByPath(ui,"LoadingBar")
    self.Image_bg          = TFDirector:getChildByPath(ui,"Panel_base")

    self.Image_xts = TFDirector:getChildByPath(ui,"Image_xts")
    self.loadingBar:setPercent(0)
    --self.label_percent:setText("Loading...0%")
    --local textIds   = {300160,300161,300162,300163}
    --local textId = textIds[math.random(#textIds)]
    --local text   = TextDataMgr:getText(textId)
    --self.label_tip:setText(string.format("<%s>",text))
    self.label_tip:show()
    self.label_percent:hide()
    local roleId = NewCityDataMgr:getCurMainLineRoleId() or 2
    local res , desIds = Utils:randomAD(roleId)
    self.Image_bg:setBackGroundImage(res)
    if desIds and #desIds > 1 then
        local textId = math.random(desIds[2] - desIds[1]) - 1 + desIds[1]
        local text   = TextDataMgr:getText(textId)
        self.label_tip:show()
        self.Image_xts:show()
        self.label_tip:setText(string.format("<%s>",text))
    else
        self.Image_xts:hide()
        self.label_tip:hide()
    end

    local img = self.Image_bg:getBackGroundImage()
    local size = img:getSize();
    if self.realSize.width > 1386 and size.width == 1386 and size.height == 640 then
        img:setSize(self.realSize)
    elseif self.realSize.width > 1386 and size.width == 1386 then
        img:setSize(CCSizeMake(self.realSize.width,size.height))
    end
    --img:setSize(self.realSize);
end

function NewCityLoadView:onLoadStatus(cur, total)
    local percent = math.floor(cur / total * 100)
    Utils:loadingBarAddAction(self.loadingBar, percent, nil, function()
        if cur >= total then
            self:timeOut(function()
                AlertManager:changeScene(SceneType.NewCity)
            end, 0.1)
        end
    end)
end

function NewCityLoadView:onCityUpdate()
    NewCityDataMgr:enterNewCity(NewCityDataMgr.curCityType)
end

function NewCityLoadView:update()
    --self.label_percent:setText(string.format("%s%%",self.loadingBar:getPercent()))
end

return NewCityLoadView