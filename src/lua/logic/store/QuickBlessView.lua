--

local QuickBlessView = class("QuickBlessView", BaseLayer)

function QuickBlessView:initData()
    self.selectTxt = ""
end

function QuickBlessView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.quickBlessView")
end

function QuickBlessView:initUI(ui)
    self.super.initUI(self, ui)
    self.listView = UIListView:create(self._ui.scrollView)

    for i = 1 , 10 do
        local item = self._ui.pannel_item:clone()
        item:setVisible(true)
        local lab = item:getChildByName("lab")
        local btn_choose = item:getChildByName("btn_choose")
        lab:setText("我是祝福我是祝福我是祝福我是祝福"..i)
        btn_choose:onClick(function()
            self.selectTxt = lab:getText()
            AlertManager:close(self)
        end)
        self.listView:pushBackCustomItem(item)
    end
end

function QuickBlessView:registerEvents()
    self._ui.Button_close:onClick(function()
        AlertManager:close(self)
    end)
end

function QuickBlessView:getChooseTxt(func)
    self.callBackChoose_ = func
end

function QuickBlessView:onClose()
    self.super.onClose(self)
    handler(self.callBackChoose_(self.selectTxt), self)
end

return QuickBlessView