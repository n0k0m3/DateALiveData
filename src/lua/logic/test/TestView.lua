
local TestView = class("TestView", BaseLayer)

function TestView:ctor(...)
    self.super.ctor(self, ...)
    self:init("lua.uiconfig.test.testView")
end

function TestView:initUI(ui)
    self.super.initUI(self,ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Button_back = TFDirector:getChildByPath(self.Panel_root, "Button_back")


    self:refreshView()
end

function TestView:refreshView()
    self:testScrollview()
end

function TestView:testScrollview()
    local Panel_test_scrollview = TFDirector:getChildByPath(self.Panel_root, "Panel_test_scrollview")
    local Button_test = TFDirector:getChildByPath(Panel_test_scrollview, "Button_test")
    local ScrollView_test = TFDirector:getChildByPath(Panel_test_scrollview, "ScrollView_test")
    local Panel_content = TFDirector:getChildByPath(ScrollView_test, "Panel_content")
    local Button_func_1 = TFDirector:getChildByPath(Panel_content, "Button_func_1")
    local innerContainer = ScrollView_test:getInnerContainer()

    local anchorPoint = ScrollView_test:getAnchorPoint()
    local contentSize = ScrollView_test:getSize()
    local innerSize = innerContainer:getSize()
    local center = ccp(-contentSize.width * 0.5, -contentSize.height * 0.5)

    Button_test:onClick(function()
        local innerPos = innerContainer:getPosition()
        local minY = contentSize.height - innerSize.height
        local h = -minY
        local w = contentSize.width - innerSize.width

        local position = Button_func_1:getPosition()
        local wp = Button_func_1:getParent():convertToWorldSpaceAR(position)
        local np = ScrollView_test:convertToNodeSpaceAR(wp)

        local foo = ccpSub(innerPos, np)
        local dis = ccpSub(foo, center)
        local percentX = -dis.x * 100 / w
        local percentY = (dis.y - minY) * 100 / h

        ScrollView_test:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, 0.5, true, percentX, percentY)
    end)

    Button_func_1:onClick(function()
        -- local innerPos = innerContainer:getPosition()
        -- local minY = contentSize.height - innerSize.height
        -- local h = -minY
        -- local w = innerSize.width - contentSize.width

        -- local position = Button_func_1:getPosition()
        -- local wp = Button_func_1:getParent():convertToWorldSpaceAR(position)
        -- local np = ScrollView_test:convertToNodeSpaceAR(wp)

        -- local foo = ccpSub(innerPos, np)
        -- local dis = ccpSub(foo, origin)
        -- local percentX = -dis.x * 100 / w
        -- local percentY = (dis.y - minY) * 100 / h

        -- ScrollView_test:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_BOTH, 0.5, true, percentX, percentY)
    end)
end

function TestView:registerEvents()
    self.Button_back:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

return TestView
