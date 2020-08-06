local KanBanLayer = class("KanBanLayer", BaseLayer)
require "lua.public.ScrollMenu"

function KanBanLayer:ctor(isHide)
    self.super.ctor(self)

    self:initData(isHide)

    self:init("lua.uiconfig.dating.kanBanLayer")
end

function KanBanLayer:initData(isHide)
    self.isHide = isHide
    self.isShowDress = false;
    self.defaultSelectIndex_ = 1
    self.selectIndex_ = 0
    self.dressList = {}
    self.dressDatas = {}
    self.useId = RoleDataMgr:getCurId()
    self.modelId = RoleDataMgr:getModel(self.useId);
    self.model = nil
    self.selectModeId = nil
    self.modelList_ = {}
end

function KanBanLayer:initModelList()
    self:removeModelList()
    for i=1,5 do
        local modelId = RoleDataMgr:getModel(100 + i)
        local model = ElvesNpcTable:createLive2dNpcID(modelId,true).live2d:hide()
        model:registerEvents();
        local Image_npc = TFDirector:getChildByPath(self.Panel_middle,"Image_npc")
        Image_npc:getParent():addChild(model)
        self.modelList_[modelId] = model
    end
end

function KanBanLayer:removeModelList()
    -- for k, v in pairs(self.modelList_) do
    --     v:removeFromParent()
    -- end
    -- self.modelList_ = {}
    if self.model then
        self.model:removeFromParent()
    end
    self.model = nil
end

function KanBanLayer:refreshDressDataList(id)
    self.dressDatas = {}
    local dressIdList = RoleDataMgr:getDressList(id)
    self.dressDatas = {}
    for i,v in ipairs(dressIdList) do
        local dressData = {}
        dressData.id = v
        self:refreshDressData(dressData)

        table.insert(self.dressDatas,dressData)
    end
end

function KanBanLayer:bindMode(model)
    local modelId = nil
    local pos = nil
    local scale = nil
    if model then
        modelId = model.modelId
        pos = model:Pos()
        scale = model:Scale()
    else
        modelId = self.selectModeId
    end
    if self.model then
        if not model then
            pos = self.model:Pos()
            scale = self.model:Scale()
        end
    end
    self:removeModel()

    self:showModel(modelId,model)
end

function KanBanLayer:showModel(modelId,model)
    -- self.model = self.modelList_[modelId]
    self.model = ElvesNpcTable:createLive2dNpcID(modelId,true).live2d:hide()
    self.ui:addChild(self.model)
    if not self.model then
        Box("模型空，id: " .. modelId)
        return
    end
    self.model:setScale(0.7); --缩放
    self.model:setZOrder(20)
    local pos = ccp(me.width/2,-280)
    self.model:Pos(pos)

    self.ui:timeOut(function()
        self.model:playIn(0.3)
    end,0)
end

function KanBanLayer:removeModel()
    if self.model then
        self.model:removeFromParent()
    end
    -- for k,v in pairs(self.modelList_) do
    --     v:hide()
    -- end
end

function KanBanLayer:refreshDressData(dressData)
    if dressData.id == nil then
        return
    end
    local dressTable = TabDataMgr:getData("Dress")
    local data = dressTable[dressData.id]
    if data then
        dressData.name = TextDataMgr:getText(data.nameTextId)
        dressData.modelId = data.roleModel
        dressData.iconName = data.icon
        dressData.star = data.star
        if dressData.star == 0 then
            dressData.star = 1
        end
        dressData.des = TextDataMgr:getText(data.desTextId)
        if GoodsDataMgr:getDress(dressData.id) == nil then
            dressData.isUnlock = false
        else
            dressData.isUnlock = true
        end
    end
end

function KanBanLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	KanBanLayer.ui = ui

    self.Panel_middle_left  = TFDirector:getChildByPath(ui,"Panel_middle_left");
    self.Panel_middle_left.width = self.Panel_middle_left:Size().width
    self.Panel_middle_right = TFDirector:getChildByPath(ui,"Panel_middle_right");
    self.Panel_middle_right.width = self.Panel_middle_right:Size().width
    self.Image_changeDressOk = TFDirector:getChildByPath(self.Panel_middle_right,"Image_changeDressOk")
    self.panel_list      = TFDirector:getChildByPath(self.ui,"Panel_fairy_list");
    self.panel_item      = TFDirector:getChildByPath(ui,"Panel_item");
    self.panel_item_up      = TFDirector:getChildByPath(ui,"Panel_item_up");
    self.panel_item_down      = TFDirector:getChildByPath(ui,"Panel_item_down");
    self.Button_dress    = TFDirector:getChildByPath(ui,"Button_dress"):hide()   --新版本不需要
    self.Button_dress.savePos = self.Button_dress:Pos()
    self.Button_dress.tip = self.Button_dress:getChildByName("Spine_redTips"):hide()
    self.Button_dress.imTip = self.Button_dress:getChildByName("Image_redTips"):hide()

    if RoleDataMgr:getAllRoleDatingIsTip() then
        self.Button_dress.imTip:show()
    end
    self.Button_dressClose = TFDirector:getChildByPath(ui,"Button_dressClose"):hide()   --新版本不需要
    self.Button_dressClose:setTouchEnabled(false)
    self.Button_dressClose.savePos = self.Button_dressClose:Pos()
    self.Button_dressClose:setOpacity(0)

    if not self.isHide then
        self:showModel(self.modelId)
    end

    self:initDressScrollView()
    self:initMood()
    self:initTableView();
end

function KanBanLayer:initMood()
    local Panel_mood = TFDirector:getChildByPath(self.ui,"Panel_mood")

    local Image_moodDes = TFDirector:getChildByPath(Panel_mood,"Image_moodDes"):hide()

    self.Label_moodValue = TFDirector:getChildByPath(Panel_mood,"Label_moodValue")
    self.Label_moodValue:setString(RoleDataMgr:getMood(self.useId))

    self.Image_moodIcon = TFDirector:getChildByPath(Panel_mood,"Image_moodIcon")
    self.Image_moodIcon.imageMoodDes = Image_moodDes
    self.Image_moodIcon:setTexture(RoleDataMgr:getMoodIcon(self.useId))
end

function KanBanLayer:refreshMoodValue()
    self.Image_moodIcon:setTexture(RoleDataMgr:getMoodIcon(self.useId))
    self.Label_moodValue:setString(RoleDataMgr:getMood(self.useId))
end

function KanBanLayer:initDressScrollView()

    local Panel_dress = TFDirector:getChildByPath(self.ui, "Panel_dress"):hide() -- 屏蔽换装功能

    local ScrollView_dress = TFDirector:getChildByPath(self.ui, "ScrollView_dress")
    self.dressListView = UIListView:create(ScrollView_dress)

    self.Panel_dressItem =  TFDirector:getChildByPath(self.ui, "Panel_dressItem")

end

function KanBanLayer:refreshView()
    self:showDressList()
end

function KanBanLayer:showDressList()

    self.dressList = {}
    self.dressListView:removeAllItems()
    for i, v in ipairs(self.dressDatas) do

        local item = self.dressListView:getItem(i);
        if not item then
            item = self.Panel_dressItem:clone();
            self.dressListView:pushBackCustomItem(item)
        end

        self.dressList[i] = {}

        self.dressList[i].Image_normal = TFDirector:getChildByPath(item, "Image_normal")
        self.dressList[i].Image_select = TFDirector:getChildByPath(item, "Image_select")
        self.dressList[i].Image_dressBottom = TFDirector:getChildByPath(item, "Image_dressBottom")
        self.dressList[i].Image_dress = TFDirector:getChildByPath(item, "Image_dress")
        self.dressList[i].starList = {}
        for index=1,5 do
            self.dressList[i].starList[index] = TFDirector:getChildByPath(item, "Image_star0" .. index)
        end
        self.dressList[i].Image_lockBottom = TFDirector:getChildByPath(item, "Image_lockBottom")
        self.dressList[i].Image_useBottom = TFDirector:getChildByPath(item, "Image_useBottom")
        self.dressList[i].Label_name = TFDirector:getChildByPath(item, "Label_name")
        self.dressList[i].Panel_touch = TFDirector:getChildByPath(item, "Panel_touch")

        self.dressList[i].dressId = v.id
        self.dressList[i].modelId = v.modelId
        self.dressList[i].isUnlock = v.isUnlock

        self:initDressItem(self.dressList[i],v)

    end

    for i, v in ipairs(self.dressList) do
        v.Panel_touch:onClick(function()
                self:selectDressItem(i)
        end)
    end

    self.defaultSelectIndex_ = RoleDataMgr:getDressIndex(self.useId)
    self:selectDressItem(self.defaultSelectIndex_)
end

function KanBanLayer:initDressItem(dress,data)
    dress.Image_normal:show()
    dress.Image_select:hide()
    local index = (90 + data.star)
    local dressBottomStr = string.format("ui/mainLayer/%03d.png",index)
    dress.Image_dressBottom:setTexture(dressBottomStr)
    dress.Image_dress:setTexture(data.iconName)
    for i=1,#dress.starList do
        if data.star < i then
            dress.starList[i]:hide()
        else
            dress.starList[i]:show()
        end
    end
    dress.Image_lockBottom:setVisible(not data.isUnlock)
    dress.Image_useBottom:hide()
    dress.Label_name:setString(data.name)
    dress.Label_name:setFontColor(ccc3(255,255,255))
end

function KanBanLayer:selectDressItem(index)
    if self.selectIndex_ == index then return end
    self.selectIndex_ = index

    self:refreshDressList()
end

function KanBanLayer:onActivationRole(useId)
    if RoleDataMgr:getAllRoleDatingIsTip() then
        self.Button_dress.imTip:show()
    end
    self.scrollMenu:removeFromParent()
    self.scrollMenu = nil
    self:initTableView(useId)
end

function KanBanLayer:registerEvents()
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRoleModel, handler(self.onRefreshRoleModel, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.addRole, handler(self.onActivationRole,self))

    self.Button_dress:onClick(function()
            self:onTouchDressBtn()
        end)

    self.Button_dressClose:onClick(function()
            self:onTouchCloseDressBtn()
        end)

    self.Image_changeDressOk:onClick(function()
            if self.Image_changeDressOk.cellIdx then
                self:switchRole(self.Image_changeDressOk.cellIdx)
            end
        end)

    -- self.Image_moodIcon:onClick(function()
    --         local data = {}
    --         data.useId = self.useId
    --         data.worldPos = self.Image_moodIcon.imageMoodDes:getParent():convertToWorldSpace(self.Image_moodIcon.imageMoodDes:Pos())
    --         data.parent = self.ui
    --         local moodLayer = require("lua.logic.dating.MoodLayer")
    --         moodLayer.show(data)
    --     end)

end

function KanBanLayer:refreshDressList()

    self.Image_changeDressOk:setGrayEnabled(true)
    self.Image_changeDressOk:setTouchEnabled(false)

    for i, v in ipairs(self.dressList) do
        if self.selectIndex_ == i then
            v.Image_select:show()
            v.Image_normal:hide()
            self.selectModeId = v.modelId
            if self.isShowDress then
                self:bindMode()
            end
            self.Image_changeDressOk:setGrayEnabled(false)
            self.Image_changeDressOk:setTouchEnabled(true)

            self.Image_changeDressOk.modelId = v.modelId
            self.Image_changeDressOk.id = v.dressId
        else
            v.Image_select:hide()
            v.Image_normal:show()
        end
        v.Image_useBottom:hide()
        if RoleDataMgr:getUseRoleInfo() and v.dressId == RoleDataMgr:getUseRoleInfo().dressId then
            v.Image_useBottom:show()
            if self.selectIndex_ == i then
                self.Image_changeDressOk:setGrayEnabled(true)
                self.Image_changeDressOk:setTouchEnabled(false)
            end
        end

        if self.selectIndex_ == i then
            v.Label_name:setFontColor(ccc3(235,53,105))
        elseif RoleDataMgr:getUseRoleInfo() and v.dressId == RoleDataMgr:getUseRoleInfo().dressId then
            v.Label_name:setFontColor(ccc3(251,222,58))
        elseif v.isUnlock == false then
            v.Label_name:setFontColor(ccc3(116,116,125))
        else
            v.Label_name:setFontColor(ccc3(255,255,255))
        end
        if v.isUnlock == false then
           if self.selectIndex_ == i then
               self.Image_changeDressOk:setGrayEnabled(true)
               self.Image_changeDressOk:setTouchEnabled(false)
           end
        end
    end
end

function KanBanLayer:onTouchDressBtn()

    -- self:initModelList()

    self.useId = RoleDataMgr:getCurId()
    self.isShowDress = true;
    self.Panel_middle_left:runAction(Sequence:create({CCDelayTime:create(0.2),CCMoveBy:create(0.2,ccp(self.Panel_middle_left.width + 100,0))}));
    self.Panel_middle_right:runAction(Sequence:create({CCDelayTime:create(0.2),CCMoveBy:create(0.2,ccp(-self.Panel_middle_right.width - 100,0))}));

    self.Button_dress:setOpacity(255)
    self.Button_dress:fadeOut(0.3)
    self.Button_dress:setTouchEnabled(false)
    self.Button_dressClose:setTouchEnabled(false)
    local action = Sequence:createWithTwoActions(
        MoveTo:create(0.3,self.Button_dressClose.savePos),
        CallFunc:create(function()
            self.Button_dressClose:setTouchEnabled(true)
        end))
    self.Button_dress:runAction(action)
    self.Button_dressClose:Pos(self.Button_dressClose.savePos)
    self.Button_dressClose:setOpacity(0)
    self.Button_dressClose:fadeIn(0.3)

    self:selectDressItem(self.defaultSelectIndex_)
    local jumpTo = RoleDataMgr:getRoleIdx(self.useId)
    self.scrollMenu:jumpTo(jumpTo);
    EventMgr:dispatchEvent(EV_SHOW_KANBAN);
    --self.Panel_middle:setTouchEnabled(self.isShowDress);
end

function KanBanLayer:onTouchCloseDressBtn()
    if not self.isShowDress then
        return;
    end

    self:removeModelList()

    if RoleDataMgr:getAllRoleDatingIsTip() then
        self.Button_dress.imTip:show()
    else
        self.Button_dress.imTip:hide()
    end

    self.isShowDress = false;
    self.Panel_middle_left:runAction(CCMoveBy:create(0.2,ccp(-self.Panel_middle_left.width - 200,0)));
    self.Panel_middle_right:runAction(CCMoveBy:create(0.2,ccp(self.Panel_middle_right.width + 200,0)));
    self.Button_dressClose:setOpacity(255)
    self.Button_dressClose:fadeOut(0.2)
    self.Button_dressClose:setTouchEnabled(false)
    self.Button_dressClose:moveTo(0.2,self.Button_dress.savePos.x,self.Button_dress.savePos.y)
    self.Button_dress:Pos(self.Button_dress.savePos)
    self.Button_dress:setTouchEnabled(true)
    self.Button_dress:setOpacity(0)
    self.Button_dress:fadeIn(0.2)

    if not GoodsDataMgr:getDress(self.Image_changeDressOk.id) or self.Image_changeDressOk.modelId ~= RoleDataMgr:getModel(RoleDataMgr:getCurId()) then
        EventMgr:dispatchEvent(EV_KANBAN_CHANGE_SHOW_ONE,RoleDataMgr:getModel(RoleDataMgr:getCurId()))
        self.defaultSelectIndex_ = 1
    else
        EventMgr:dispatchEvent(EV_KANBAN_CHANGE_SHOW_ONE,self.modelId)
    end

    EventMgr:dispatchEvent(EV_HIDE_KANBAN);

    self.Panel_middle:setTouchEnabled(self.isShowDress);

    self:removeModel()
end

function KanBanLayer:initTableView(useId)
    local params = {
        ["upItem"]                  = self.panel_item_up,
        ["downItem"]                = self.panel_item_down,
        ["selItem"]                 = self.panel_item,
        ["offsetX"]                 = 55,
        ["updateCellInfo"]          = handler(self.updateCellInfo,self),
        ["selCallback"]             = handler(self.selCallback,self),
        ["cellCount"]               = RoleDataMgr:getRoleCount(),
        ["isLoop"]                  = false,
        ["size"]                    = self.panel_list:getContentSize();
    }
     local scrollMenu = ScrollMenu:create(params);
     scrollMenu:setPosition(self.panel_list:getPosition());
     self.panel_list:getParent():addChild(scrollMenu,10)
     self.scrollMenu = scrollMenu
     local id = useId or RoleDataMgr:getCurId()
     local jumpTo = RoleDataMgr:getRoleIdx(id)
     self.scrollMenu:jumpTo(jumpTo);
end

function KanBanLayer:updateCellInfo(cell,cellIdx)
    local roleId = RoleDataMgr:getRoleIdByShowIdx(cellIdx);
    local ishave = RoleDataMgr:getIsHave(roleId)
    if ishave then
        cell:setColor(me.c3b(0xFF,0xFF,0xFF))
    else
        cell:setColor(me.c3b(0x80,0x80,0x80))
    end
    local Label_name = TFDirector:getChildByPath(cell,"Label_name");
    local Image_head = TFDirector:getChildByPath(cell,"Image_head");

    cell.tip = cell:getChildByName("Spine_redTips"):hide()
    cell.imTip = cell:getChildByName("Image_redTips"):hide()
    if RoleDataMgr:getDatingIsTip(roleId) then
        cell.imTip:show()
    else
        cell.imTip:hide()
    end

    local cellType = cell._type
    local headPath = "icon/role/face/" .. cellType .. '/'
    Image_head:setTexture(headPath .. RoleDataMgr:getHeadIconPath(roleId))
    Label_name:setString(RoleDataMgr:getName(roleId));
    local Label_qinmi_tips = TFDirector:getChildByPath(cell,"Label_qinmi_tips")
    if Label_qinmi_tips then
        Label_qinmi_tips:setVisible(ishave)
    end
    local Image_jiantoui = TFDirector:getChildByPath(cell,"Image_jiantoui")
    if Image_jiantoui then
        Image_jiantoui:setVisible(ishave)
    end
    local Panel_fairy = TFDirector:getChildByPath(cell,"Panel_fairy")
    if Panel_fairy then
        Panel_fairy:setVisible(ishave)
    end
    local Label_lock = TFDirector:getChildByPath(cell,"Label_lock")
    if Label_lock then
        Label_lock:setVisible(not ishave)
    end
    local Image_starb = TFDirector:getChildByPath(cell,"Image_starb")
    if Image_starb then
        Image_starb:setVisible(roleId == RoleDataMgr:getUseId())
    end

    local favorLv = RoleDataMgr:getFavorLevel(roleId)
    local Panel_fairy = TFDirector:getChildByPath(cell,"Panel_fairy")
    for i=1,5 do
        local Image_fairy_lv = TFDirector:getChildByPath(Panel_fairy,"Image_fairy_lv0" .. i)
        if i > favorLv then
            Image_fairy_lv:hide()
        else
            Image_fairy_lv:show()
        end
    end

end

function KanBanLayer:selCallback(cell,cellIdx)
    local roleId = RoleDataMgr:getRoleIdByShowIdx(cellIdx);
    --self:changeShowOne(roleId,cellIdx)
    local ishave = RoleDataMgr:getIsHave(roleId)
    cell:setColor(me.c3b(0xFF,0xFF,0xFF))
    cell:setGrayEnabled(not ishave)
    cell.tip = cell:getChildByName("Spine_redTips"):hide()
    cell.imTip = cell:getChildByName("Image_redTips"):hide()
end

function KanBanLayer:changeShowOne(id,cellIdx)
    self.selectIndex_ = 0
    local useId = id or RoleDataMgr:getCurId();
    self.modelId = RoleDataMgr:getModel(useId);
    self.Image_changeDressOk.sid = RoleDataMgr:getRoleSid(useId)
    self.Image_changeDressOk.cellIdx = cellIdx
    local Image_name = TFDirector:getChildByPath(self.Panel_middle_right,"Image_name"):hide()
    local Label_name = TFDirector:getChildByPath(self.Panel_middle_right,"Label_name")
    local Label_theme = TFDirector:getChildByPath(self.Panel_middle_right,"Label_theme")
    local Label_desc = TFDirector:getChildByPath(self.Panel_middle_right,"Label_desc");

    if cellIdx == nil then
        cellIdx = 1
    end
    Image_name:setTexture(RoleDataMgr:getNameIconPath(useId));
    Label_name:setString(RoleDataMgr:getName(useId))
    Label_theme:setString(RoleDataMgr:getAkira(useId))
    Label_desc:setString(RoleDataMgr:getDesc(useId));

    self:refreshDressDataList(useId)

    self.defaultSelectIndex_ = 1

    for i,v in ipairs(self.dressDatas) do
        if RoleDataMgr:getUseRoleInfo() and v.id == RoleDataMgr:getUseRoleInfo().dressId then
            self.defaultSelectIndex_ = i
            break
        end
    end

    RoleDataMgr:selectRole(useId)

    self.useId = useId

    self:refreshView()

    self:refreshMoodValue()
end

function KanBanLayer:switchRole(idx)
    local id = RoleDataMgr:getRoleIdByShowIdx(idx);
    if id ~= RoleDataMgr:getUseId() then
        RoleDataMgr:switchRole(id);
    end
end

function KanBanLayer:onShow()
    self.super.onShow(self)

    if not self.isHide then
        self:onTouchDressBtn()  --新版本使用
    else
        TFDirector:getChildByPath(self.ui,"Image_bg"):hide()
    end
end

function KanBanLayer:onRefreshRoleModel()
    self:changeShowOne();
    self:onActivationRole(self.useId)
end

return KanBanLayer;