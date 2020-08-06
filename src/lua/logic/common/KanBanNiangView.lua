
local KanBanNiangView = class("KanBanNiangView", BaseLayer)

function KanBanNiangView:initData()

end

function KanBanNiangView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.common.kanBanNiangView")
end

function KanBanNiangView:initUI(ui)
	self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_model = TFDirector:getChildByPath(self.Panel_root, "Panel_model")
    self.Panel_model:setBackGroundColorType(0)
    self.Image_talkDialog = TFDirector:getChildByPath(self.Panel_root, "Image_talkDialog")
    self.Label_tips = TFDirector:getChildByPath(self.Image_talkDialog, "Label_tips")
    self.Label_title = TFDirector:getChildByPath(self.Image_talkDialog, "Image_title.Label_title")
    self.Button_kanbanExpand = TFDirector:getChildByPath(self.Panel_root, "Button_kanbanExpand")
    self.Button_kanbanClose = TFDirector:getChildByPath(self.Panel_root, "Button_kanbanClose")

    self:refreshView()
end

function KanBanNiangView:refreshView()
    self:expandKanBanNiang(true)
end

function KanBanNiangView:updateKanBanNiang(roleId)
    scale = scale or 0.6
    if self.curRoleId_ == roleId then return end
    self.curRoleId_ = roleId
    if self.elvesNpc_ then
        self.elvesNpc_:removeFromParent()
        self.elvesNpc_ = nil
    end
    local modelId = RoleDataMgr:getModel(roleId)
    self.elvesNpc_ = ElvesNpcTable:createLive2dNpcID(modelId).live2d
    self.elvesNpc_:registerEvents()
	self.Panel_model:addChild(self.elvesNpc_)

    local roleCfg = TabDataMgr:getData("Role", roleId)
    self.Label_title:setTextById(roleCfg.nameId)
end

function KanBanNiangView:setExpandVisible(visible)
    self.Button_kanbanExpand:setVisible(visible)
    self.Button_kanbanClose:setVisible(visible)
end

function KanBanNiangView:setRoleSetId(roleSetId, buildId)
    if self.roleSetId_ == roleSetId and not buildId then return end
    self.roleSetId_ = roleSetId
    self.roleSetCfg_ = DatingDataMgr:getRoleSetCfg(roleSetId)
    local roleId
    local text = ""
    if self.roleSetCfg_.roleType == 0 then
        roleId = self.roleSetCfg_.roleModle
        text = self.roleSetCfg_.text
    elseif self.roleSetCfg_.roleType == 1 then
        roleId = RoleDataMgr:getUseId()
        text = self.roleSetCfg_.text[roleId]
    elseif self.roleSetCfg_.roleType == 2 then
        local buildInfo = CityDataMgr:getBuildInfo(buildId)
        local heroIds = {}
        if #buildInfo.roleIds > 0 then
            local index = math.random(#buildInfo.roleIds)
            roleId = RoleDataMgr:getRoleIdBySid(buildInfo.roleIds[index])
            text = self.roleSetCfg_.text[roleId]
        end
    end

    if roleId then
        self.Panel_root:show()
        self:updateKanBanNiang(roleId)
        self.elvesNpc_:setScale(self.roleSetCfg_.modelSize)
        local index = math.random(#text)
        self.Label_tips:printer(text[index], function()
                                    return 0.01
        end)
    else
        self.Panel_root:hide()
    end
end

function KanBanNiangView:registerEvents()
    self.Button_kanbanExpand:onClick(function()
            self:expandKanBanNiang(true)
    end)

    self.Button_kanbanClose:onClick(function()
            self:expandKanBanNiang(false)
    end)
end

function KanBanNiangView:expandKanBanNiang(isExpand)
    self.Panel_model:setVisible(isExpand)
    self.Image_talkDialog:setVisible(isExpand)
    self.Button_kanbanClose:setVisible(isExpand)
    self.Button_kanbanExpand:setVisible(not isExpand)
end

function KanBanNiangView:onClose()
    if self.elvesNpc_ then
        self.elvesNpc_:removeFromParent()
        self.elvesNpc_ = nil
    end
end

return KanBanNiangView
