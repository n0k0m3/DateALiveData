local DatingMainView = class("DatingMainView",BaseLayer)

function DatingMainView:initData(data)
    self.list_ = RoleDataMgr:getMainLiveList()
    self.optionList_ = {}
    self.selectOption_ = 1
    self.roleId = RoleDataMgr:getCurId()
    self.roleInfo = RoleDataMgr:getRoleInfo(self.roleId)
end

function DatingMainView:ctor(data)
    self.super.ctor(self)

    self:initData(data)

    self:init("lua.uiconfig.dating.datingMainView")
end

function DatingMainView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Image_bg = TFDirector:getChildByPath(self.ui,"Image_bg")

    self:initPrefab()
    self:initMainScroll()
    self:initRoleInfo()
    self:showMainScroll()

end

function DatingMainView:initRoleInfo()
    local Image_head = TFDirector:getChildByPath(self.ui,"Image_head")
    Image_head:setTexture(self.roleInfo.mainRoleIcon)
    local Image_name = TFDirector:getChildByPath(self.ui,"Image_name")
    Image_name:setTexture(self.roleInfo.mainNameIcon)
end

function DatingMainView:initPrefab()
    self.Panel_mainItem = TFDirector:getChildByPath(self.ui,"Panel_mainItem")
end

function DatingMainView:initMainScroll()
    local ScrollView_main = TFDirector:getChildByPath(self.ui,"ScrollView_main")
    self.mainScroll = UIListView:create(ScrollView_main)
end

function DatingMainView:showMainScroll()
    self.mainScroll:removeAllItems()

    for i,v in ipairs(self.list_) do
        local mainItem = self.Panel_mainItem:clone()
        self:initItem(mainItem,i)
        self:updateItem(mainItem)
        self.mainScroll:pushBackCustomItem(mainItem)
        table.insert(self.optionList_,mainItem)
    end
end

function DatingMainView:initItem(item,idx)
    local Label_number = TFDirector:getChildByPath(item,"Label_number")
    Label_number:setTextById("r" .. tostring(70000+idx))

    local Image_main = TFDirector:getChildByPath(item,"Image_main")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    Image_icon:setTexture(RoleDataMgr:getMainIconPath(self.roleId,idx))
    local Image_new = TFDirector:getChildByPath(item,"Image_new"):hide()
    local Image_stateBottom = TFDirector:getChildByPath(item,"Image_stateBottom"):hide()
    local Label_title = TFDirector:getChildByPath(item,"Label_title"):hide()
    local datingRuleCid = RoleDataMgr:getMainLiveScriptByIdx(idx)
    -- Label_title:setText(string.format("剧本%s",datingRuleCid))
    local datingTitleId = DatingDataMgr:getDatingRuleData(datingRuleCid).datingTitle
    Label_title:setTextById(datingTitleId)

    local Label_lock = TFDirector:getChildByPath(item,"Label_lock"):hide()

    local state = RoleDataMgr:getMainLiveStateByIdx(idx)
    if state == EC_DatingScriptState.NO_FINISH then

    elseif state == EC_DatingScriptState.TRIGGER then
        Image_new:show()
        Label_title:show()
    elseif state == EC_DatingScriptState.NORMAL then
        Image_stateBottom:show()
        Label_title:show()
    elseif state == EC_DatingScriptState.LOCK then
        -- Image_main:setGrayEnabled(true)
        Image_main:setColor(me.c3b(0x80,0x80,0x80))
        Label_title:setColor(me.c3b(0x00,0x00,0x00))
        Label_title:setOpacity(100)

        item:Touchable(false)
        Label_lock:show()
        local str = TextDataMgr:getTextAttr(304003).text
        Label_lock:setText(string.format(str,idx))
    end

end

function DatingMainView:refreshItems()
    for i,v in ipairs(self.optionList_) do
        self:updateItem(v,i)
    end
end

function DatingMainView:updateItem(item,idx)

end

function DatingMainView:selectOption(idx)
    self.selectOption_ = idx

    local mainLive = RoleDataMgr:getMainLiveByIdx(self.selectOption_)
    local datingState = RoleDataMgr:getMainLiveStateByIdx(self.selectOption_)
    if datingState == EC_DatingScriptState.LOCK then
        Utils:showTips(900212)
    elseif datingState == EC_DatingScriptState.NORMAL then
        DatingDataMgr:showDatingLayer(EC_DatingScriptType.SHOW_SCRIPT,mainLive.currentNodeId,false,mainLive.script)
    elseif datingState == EC_DatingScriptState.TRIGGER then
        DatingDataMgr:sendGetSciptMsg(EC_DatingScriptType.MAIN_SCRIPT)
        RoleDataMgr:setMainLiveStateByIdx(self.selectOption_,EC_DatingScriptState.NO_FINISH)
    elseif datingState == EC_DatingScriptState.NO_FINISH then
        DatingDataMgr:showDatingLayer(EC_DatingScriptType.MAIN_SCRIPT,nil,true)
    end

    -- self:refreshItems()
end

function DatingMainView:registerEvents()
    for i,v in ipairs(self.optionList_) do
        local optionItem = v
        optionItem:Touchable(true)
        optionItem:onClick(function()
                self:selectOption(i)
            end)
    end
end

function DatingMainView:setCloseCallback(callBack)
    self.closeCallBack = callBack
end

function DatingMainView:onClose()
    self.super.onClose(self)

    if self.closeCallBack then
        self.closeCallBack()
    end
end


return DatingMainView