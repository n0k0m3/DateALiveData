local RoleSwitchSettingView =  class("RoleSwitchSettingView", BaseLayer)

function RoleSwitchSettingView:initData(openType)

    self.originalSwitchList = RoleSwitchDataMgr:getSwitchList()
    self.openType = openType
	print("轮播列表")
	dump(self.originalSwitchList)
end

function RoleSwitchSettingView:ctor(openType)
    self.super.ctor(self)
    self:initData(openType)
    self:init("lua.uiconfig.role.roleSwitchSettingView")
end

function RoleSwitchSettingView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    local ScrollView_select = TFDirector:getChildByPath(self.ui, "ScrollView_select")
    self.ListView_select = UIListView:create(ScrollView_select)

    self.Panel_selectItem = TFDirector:getChildByPath(self.ui, "Panel_selectItem")
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.TextButton_save = TFDirector:getChildByPath(self.ui, "TextButton_save")
    self.TextButton_cancel = TFDirector:getChildByPath(self.ui, "TextButton_cancel")

    self.Image_select_di = TFDirector:getChildByPath(self.ui, "Image_select_di")
    self.Image_select = TFDirector:getChildByPath(self.ui, "Image_select")
    local isRecord = RoleSwitchDataMgr:getOpenState()
    self.Image_select:setVisible(isRecord == 1)

    self.Label_tip = TFDirector:getChildByPath(self.ui, "Label_tip")
    self.Label_tip:setTextById(13310402)

    self:initHighRoleList()
end

function RoleSwitchSettingView:initHighRoleList()

    self.switchList = {}
    self.ListView_select:removeAllItems()
    local highDressList = RoleSwitchDataMgr:getAllHighDress()
	print("轮播设置列表")
	dump(highDressList)
    table.sort(highDressList,function(a,b)
        local isHaveRoleA = RoleDataMgr:getIsHave(a.roleId)
        local isHaveA = GoodsDataMgr:getDress(a.dressId)
        local idA = (isHaveA and isHaveRoleA) and 2 or 1
        local isHaveRoleB = RoleDataMgr:getIsHave(b.roleId)
        local isHaveB = GoodsDataMgr:getDress(b.dressId)
        local idB = (isHaveB and isHaveRoleB) and 2 or 1
        if idA == idB then
            return a.dressId < b.dressId
        end
        return idA > idB
    end)
    for k,v in ipairs(highDressList) do
        local selectItem = self.Panel_selectItem:clone()
        self.ListView_select:pushBackCustomItem(selectItem)
        self:updateItem(selectItem,v)
        self.switchList[selectItem] = v
    end

    local dressData = RoleDataMgr:useDressFindData()
    if dressData and dressData.type and dressData.type == 2 then
        local isSwitch = RoleSwitchDataMgr:isInSwitchList(dressData.id)
        if not isSwitch then
            local index = 1
            for k,v in ipairs(highDressList) do
                if v.dressId == dressData.id then
                    index = k
                    break
                end
            end
            self.ListView_select:jumpToItem(index)
        end
    end

end

function RoleSwitchSettingView:updateItem(item,data)

    local Image_normal_bg = TFDirector:getChildByPath(item, "Image_normal_bg"):hide()
    local Image_use = TFDirector:getChildByPath(item, "Image_use"):hide()
    local Image_notuse = TFDirector:getChildByPath(item, "Image_notuse"):hide()
    local Label_rolename =  TFDirector:getChildByPath(item, "Label_rolename")
    local Label_kanbanName = TFDirector:getChildByPath(item, "Label_kanbanName")
    local Button_cancle = TFDirector:getChildByPath(item, "Button_cancle")
    local Button_ok = TFDirector:getChildByPath(item, "Button_ok")
    local Label_switch_tip = TFDirector:getChildByPath(item, "Label_switch_tip")
    local dressCfg = RoleSwitchDataMgr:getDressCfg(data.dressId)
    Label_rolename:setTextById(dressCfg.roleName)
    Label_kanbanName:setTextById(dressCfg.nameTextId)

    local isHave = RoleDataMgr:getIsHave(data.roleId)
    if not isHave then
        Image_normal_bg:setVisible(true)
        return
    end

    local isHaveDress = GoodsDataMgr:getDress(data.dressId)
    if not isHaveDress then
        Image_normal_bg:setVisible(true)
        return
    end

    local isDressRoles = RoleDataMgr:checkRoleHaveByDressId(data.dressId)
    if not isDressRoles then
        Image_normal_bg:setVisible(true)
        return
    end

    Image_normal_bg:setVisible(false)
    local isInSwitchList = RoleSwitchDataMgr:isInSwitchList(data.dressId)
    Image_use:setVisible(isInSwitchList)
    Image_notuse:setVisible(not isInSwitchList)

    local isSwitch = RoleSwitchDataMgr:getSwitchState()
    print("isSwitch:",isSwitch)
    Label_switch_tip:setVisible(isSwitch)

    Button_cancle:onClick(function()
        RoleSwitchDataMgr:handleSwitchList(data.dressId,true)
    end)

    Button_ok:onClick(function()
        RoleSwitchDataMgr:handleSwitchList(data.dressId,true)
    end)
end

function RoleSwitchSettingView:onUpdateSwitchList()
    for k,v in pairs(self.switchList) do
        self:updateItem(k,v)
    end
end

function RoleSwitchSettingView:cancleChange()

    local haveChange = false
    local newSwitchList = RoleSwitchDataMgr:getSwitchList()
    if #newSwitchList ~= #self.originalSwitchList then
        haveChange = true
    else
        for k,v in ipairs(self.originalSwitchList) do
            if newSwitchList[k] ~= v then
                haveChange = true
                break
            end
        end
    end
    if not haveChange then
        RoleSwitchDataMgr:resetSwitchList(self.originalSwitchList)
        AlertManager:closeLayer(self)
    else
        local function callback()
            RoleSwitchDataMgr:resetSwitchList(self.originalSwitchList)
            AlertManager:closeLayer(self)
        end
        local content = TextDataMgr:getText(13310403)
        Utils:openView("common.ReConfirmTipsView", {tittle = 310019, content = content, confirmCall = callback, showCancle = true})
    end
end

function RoleSwitchSettingView:registerEvents()

    EventMgr:addEventListener(self,EV_UPDATE_SWITCH_LIST,handler(self.onUpdateSwitchList, self))
    self.Button_close:onClick(function()
        dump(self.originalSwitchList)
        self:cancleChange()
    end)

    self.TextButton_save:onClick(function()
        if self.openType == 1 then
            RoleSwitchDataMgr:Send_TurnSwitchState(true)
        end
        local newSwitchList = RoleSwitchDataMgr:getSwitchList()
		print("轮播新列表")
        dump(newSwitchList)
        RoleSwitchDataMgr:Send_NewSwithList(newSwitchList)
        AlertManager:closeLayer(self)
    end)

    self.TextButton_cancel:onClick(function()
        dump(self.originalSwitchList)
        self:cancleChange()
    end)

    self.Image_select_di:onClick(function()
        if self.Image_select:isVisible() then
            self.Image_select:hide();
            RoleSwitchDataMgr:setOpenState(0)
        else
            self.Image_select:show();
            RoleSwitchDataMgr:setOpenState(1)
        end
    end)
end

return RoleSwitchSettingView
