
local CitySpriteSelectView = class("CitySpriteSelectView", BaseLayer)

function CitySpriteSelectView:initData(workingRole, selectRoleSid)
    local role = TabDataMgr:getData("Role")
    self.role_ = {}
    local workingTab = {}
    local freeTab = {}
    for k, v in pairs(role) do
        if RoleDataMgr:getIsHave(k) then
            local roleSid = RoleDataMgr:getRoleSid(k)
            if CityDataMgr:getRoleIsWorking(roleSid) then
                table.insert(workingTab, k)
            else
                table.insert(freeTab, k)
            end
        end
    end
    table.sort(workingTab, function(a, b)
                   local cfgA = RoleDataMgr:getRoleInfo(a)
                   local cfgB = RoleDataMgr:getRoleInfo(b)
                   return cfgA.order > cfgB.order
    end)
    table.sort(freeTab, function(a, b)
                   local cfgA = RoleDataMgr:getRoleInfo(a)
                   local cfgB = RoleDataMgr:getRoleInfo(b)
                   return cfgA.order > cfgB.order
    end)
    table.insertTo(self.role_, freeTab)
    table.insertTo(self.role_, workingTab)

    self.workingRole_ = workingRole or {}
    self.selectRoleSid_ = selectRoleSid

    self.spriteItem_ = {}
    self.selectIndex_ = nil

    self.defaultSelectIndex_ = 1
    if self.selectRoleSid_ then
        local roleId = RoleDataMgr:getRoleIdBySid(self.selectRoleSid_)
        local index = table.indexOf(self.role_, roleId)
        if index ~= -1 then
            self.defaultSelectIndex_ = index
        end
    end
end

function CitySpriteSelectView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.city.citySpriteSelectView")
end

function CitySpriteSelectView:initUI(ui)
	self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_spriteItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_spriteItem")

    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    local ScrollView_sprite = TFDirector:getChildByPath(Image_bg, "ScrollView_sprite")
    self.ListView_sprite = UIListView:create(ScrollView_sprite)
    self.Button_joinTeam = TFDirector:getChildByPath(Image_bg, "Button_joinTeam")
    self.Button_leaveTeam = TFDirector:getChildByPath(Image_bg, "Button_leaveTeam")
    self.Image_inTeam = TFDirector:getChildByPath(Image_bg, "Image_inTeam")
    self.Image_inTeam:setGrayEnabled(true)
    self.Image_line = TFDirector:getChildByPath(Image_bg, "Image_line")

    self:refreshView()
end

function CitySpriteSelectView:refreshView()
    for i, v in ipairs(self.role_) do
        local Panel_spriteItem = self.Panel_spriteItem:clone()
        local item = {}
        item.root = Panel_spriteItem
        item.Image_head = TFDirector:getChildByPath(item.root, "Image_head")
        item.Image_icon = TFDirector:getChildByPath(item.Image_head, "Image_icon")
        item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
        item.Image_working = TFDirector:getChildByPath(item.root, "Image_working")
        item.Image_name_normal = TFDirector:getChildByPath(item.root, "Image_name_normal")
        item.Label_name_normal = TFDirector:getChildByPath(item.Image_name_normal, "Label_name_normal")
        item.Label_name_normal:setLineHeight(22)
        item.Image_name_select = TFDirector:getChildByPath(item.root, "Image_name_select")
        item.Label_name_select = TFDirector:getChildByPath(item.Image_name_select, "Label_name_select")
        item.Label_name_select:setLineHeight(22)
        item.Panel_info = TFDirector:getChildByPath(item.root, "Panel_info")
        item.Label_mood = TFDirector:getChildByPath(item.Panel_info, "Image_frame.Label_mood")
        item.Image_smallIcon = TFDirector:getChildByPath(item.Panel_info, "Image_smallIcon")
        local Image_favorability = TFDirector:getChildByPath(item.root, "Image_favorability")
        item.Image_progress = {}
        for i = 1, 5 do
            item.Image_progress[i] = TFDirector:getChildByPath(Image_favorability, "Image_progress_" .. i)
        end

        self.spriteItem_[Panel_spriteItem] = item
        self.ListView_sprite:pushBackCustomItem(Panel_spriteItem)
    end

    for i, v in ipairs(self.ListView_sprite:getItems()) do
        self:updateSpriteItem(i)
    end

    self:selectRole(self.defaultSelectIndex_)
end

function CitySpriteSelectView:updateSpriteItem(index)
    local originItem = self.ListView_sprite:getItem(index)
    local item = self.spriteItem_[originItem]
    local roleId = self.role_[index]
    local roleSid = RoleDataMgr:getRoleSid(roleId)
    local roleCfg = RoleDataMgr:getRoleInfo(roleId)

    item.Label_name_normal:setTextById(roleCfg.nameId)
    item.Label_name_select:setTextById(roleCfg.nameId)
    item.Image_icon:setTexture(roleCfg.showIcon)
    item.Image_head:setTexture(roleCfg.backdrop)
    local moodIcon = RoleDataMgr:getMoodIcon(roleId)
    item.Image_smallIcon:setTexture(moodIcon)
    local mood = RoleDataMgr:getMood(roleId)
    item.Label_mood:setText(mood)
    local isWorking = CityDataMgr:getRoleIsWorking(roleSid)
    item.Image_working:setVisible(isWorking)

    local favLevel = RoleDataMgr:getFavorLevel(roleId)
    for i, v in ipairs(item.Image_progress) do
        v:setVisible(i <= favLevel)
    end

    item.root:onClick(function()
            self:selectRole(index)
    end)
end

function CitySpriteSelectView:selectRole(selectIndex)
    if self.selectIndex_ == selectIndex then return end
    self.selectIndex_ = selectIndex
    for i, v in ipairs(self.ListView_sprite:getItems()) do
        local isSelect = (i == selectIndex)
        local item = self.spriteItem_[v]
        item.Image_name_normal:setVisible(not isSelect)
        item.Image_name_select:setVisible(isSelect)
        item.Image_select:setVisible(isSelect)
    end

    self.Button_leaveTeam:hide()
    self.Button_joinTeam:hide()
    self.Image_inTeam:hide()
    self.Image_line:show()
    self.Image_line:setGrayEnabled(false)

    local roleId = self.role_[selectIndex]
    local roleSid = RoleDataMgr:getRoleSid(roleId)
    local inTeam = (table.indexOf(self.workingRole_, roleSid) ~= -1)
    if inTeam then
        if self.selectRoleSid_ == roleSid then
            self.Button_leaveTeam:show()
        else
            self.Image_inTeam:show()
            self.Image_line:setGrayEnabled(true)
        end
    else
        local isWork = CityDataMgr:getRoleIsWorking(roleSid)
        if isWork then
            local originItem = self.ListView_sprite:getItem(selectIndex)
            local item = self.spriteItem_[originItem]
            item.Image_working:show()
        end
        self.Button_joinTeam:show()
        self.Button_joinTeam:setGrayEnabled(isWork)
        self.Button_joinTeam:setTouchEnabled(not isWork)
        self.Image_line:setGrayEnabled(isWork)
    end
end

function CitySpriteSelectView:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:close()
                              end, EC_BTN.CLOSE)

    self.Button_joinTeam:onClick(function()
            local roleId = self.role_[self.selectIndex_]
            local roleSid = RoleDataMgr:getRoleSid(roleId)
            if self.selectRoleSid_ then
                table.removeItem(self.workingRole_, self.selectRoleSid_)
            end
            table.insert(self.workingRole_, roleSid)
            EventMgr:dispatchEvent(EV_CITY_SELECT_SPRITE, self.workingRole_)
            VoiceDataMgr:playVoice("work_play",roleId);
            AlertManager:close()
    end)

    self.Button_leaveTeam:onClick(function()
            if self.selectRoleSid_ then
                table.removeItem(self.workingRole_, self.selectRoleSid_)
            end
            EventMgr:dispatchEvent(EV_CITY_SELECT_SPRITE, self.workingRole_)
            AlertManager:close()
    end)
end

return CitySpriteSelectView
