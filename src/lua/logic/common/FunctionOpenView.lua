
local FunctionOpenView = class("FunctionOpenView", BaseLayer)

function FunctionOpenView:initData()
    self.openFuncList_ = FunctionDataMgr:getOpenFuncList()
end

function FunctionOpenView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.common.functionOpenView")
end

function FunctionOpenView:initUI(ui)
    self.super.initUI(self, ui)
    self:addLockLayer()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_funcItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_funcItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Label_tips")
    local ScrollView_function = TFDirector:getChildByPath(Image_content, "ScrollView_function")
    self.ListView_function = UIListView:create(ScrollView_function)
    self.Spine_effect = TFDirector:getChildByPath(self.Panel_root, "Spine_effect")

    self:refreshView()
end

function FunctionOpenView:onShow()
    self:removeLockLayer()
    self.super.onShow(self)
    if self.isShowGuide then
        self.isShowGuide = false
    end
    self:timeOut(function()
        if GameGuide:checkGuide(self) then
            if self.blockUI then
                self.blockUI:setBackGroundColorOpacity(50)
            end
        end
    end, 0)
end

function FunctionOpenView:refreshView()
    for i, v in ipairs(self.openFuncList_) do
        local functionCfg = FunctionDataMgr:getFunctionCfg(v)
        local Panel_funcItem = self.Panel_funcItem:clone()
        local Button_func = TFDirector:getChildByPath(Panel_funcItem, "Button_func")
        local Label_func = TFDirector:getChildByPath(Panel_funcItem, "Label_func")
        Button_func:setTextureNormal(functionCfg.icon)
        Label_func:setTextById(functionCfg.name)
        self.ListView_function:pushBackCustomItem(Panel_funcItem)

        Button_func:onClick(function()
                AlertManager:closeLayer(self)
                FunctionDataMgr:enterByFuncId(v)
                GameGuide:checkGuideEnd(self.guideFuncId)
        end)
    end
    self.ListView_function:setInertiaScrollEnabled(false)
    Utils:setAliginCenterByListView(self.ListView_function, true)

    self.Spine_effect:play("chuxian", 0)
    self.Spine_effect:play("ruchang", 0)
    self.Spine_effect:addMEListener(
        TFARMATURE_COMPLETE,
        function(skeletonNode)
            self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_effect:play("xunhuan", 1)
        end
    )
end

function FunctionOpenView:registerEvents()
    self:timeOut(function()
        self.Panel_root:onClick(function()
            if not self.isShowGuide then
                AlertManager:closeLayer(self)
            end 
        end)
    end, 1)
end


---------------------------guide------------------------------

--引导点击开放功能
function FunctionOpenView:excuteGuideFunc8001(guideFuncId)
    local targetNode
    for i, id in ipairs(self.openFuncList_) do
        if id == 23 or id == 29 or id == 34 or id == 32 or id == 33 then
            targetNode = self.ListView_function:getItem(i)
        end
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 10))
    self.isShowGuide = true
end

return FunctionOpenView
