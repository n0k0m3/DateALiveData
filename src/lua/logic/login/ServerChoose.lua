
local ServerChoose = class("ServerChoose", BaseLayer)

function ServerChoose:initData()
    self.server_ = ServerDataMgr:getGameServerList()
end

function ServerChoose:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.loginScene.serverChoose")
end

function ServerChoose:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    local ScrollView_groupList = TFDirector:getChildByPath(self.Panel_root, "ScrollView_groupList")
    self.ListView_groupList = UIListView:create(ScrollView_groupList)
    self.ListView_groupList:setItemsMargin(6)
    self.Button_serverListItem = TFDirector:getChildByPath(self.Panel_prefab, "Button_serverListItem")

    self:refreshView()
end

function ServerChoose:refreshView()
    self:showServerGroup()
end

function ServerChoose:showServerGroup()
    for _serverIndex, serverData in pairs(self.server_) do
        local item = self.Button_serverListItem:clone()
        self.ListView_groupList:pushBackCustomItem(item)
        local Label_name = TFDirector:getChildByPath(item, "Label_name")
        Label_name:setText(serverData.groupName)

        item:onClick(function()

                local function callback()
                    ServerDataMgr:setCurrentServerIndex(_serverIndex)
                    self:getParent():removeLayer(self,true)
                    EventMgr:dispatchEvent(EV_LOGIN_UPDATESERVERNAME, serverData.group_id, serverData.serverId)
                end

                if not ServerDataMgr:getCurrentServerHasRole(_serverIndex) and ServerDataMgr:getServerGroupID(_serverIndex) == 8 then
                    Utils:openView("login.LoginNotice",callback);
                    return 
                end

                callback();
        end)
    end
end

function ServerChoose:showServerList(groupName)
    local serverList = self.server_[groupName]
    self.ListView_serverList:removeAllItems()
    for _, serverName in ipairs(serverList) do
        local item = self.Button_serverListItem:clone()
        self.ListView_serverList:pushBackCustomItem(item)
        local Label_name = TFDirector:getChildByPath(item, "Label_name")
        Label_name:setText(serverName)

        item:onClick(function()
                LogonHelper:switchLogin(groupName, serverName)
                self:getParent():removeLayer(self,true)
                EventMgr:dispatchEvent(EV_LOGIN_UPDATESERVERNAME, groupName, serverName)
        end)
    end
end

function ServerChoose:registerEvents()
    self.Panel_root:onClick(function()
            self:getParent():removeLayer(self,true)
    end)
end

return ServerChoose
