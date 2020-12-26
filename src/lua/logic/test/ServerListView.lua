
local ServerListView = class("ServerListView", BaseLayer)

function ServerListView:initData(param)
    self.groupList = ServerDataMgr:getGroupList()

    self.usingGroupCfgId = param.groupCfgId
    self.usingGroupId = param.group_id
    self.usingServerId = param.serverId
end

function ServerListView:ctor( param )
    self.super.ctor(self)
    self:initData(param)
    self:init("lua.uiconfig.test.serverListView")
end

function ServerListView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local ScrollView_serverList = TFDirector:getChildByPath(self.Panel_root, "ScrollView_serverList"):hide()
    self.ListView_serverList = UIListView:create(ScrollView_serverList)
    self.ListView_serverList:setItemsMargin(6)
    local ScrollView_groupList = TFDirector:getChildByPath(self.Panel_root, "ScrollView_groupList")
    self.ListView_groupList = UIListView:create(ScrollView_groupList)
    self.ListView_groupList:setItemsMargin(6)

    self.Button_serverListItem = TFDirector:getChildByPath(self.Panel_prefab, "Button_serverListItem")
    if TFGlobalUtils:isConnectEnServer() then
        self.Button_serverListItem:setTextureNormal("ui/login/new1/b7.png")
        self.Button_serverListItem:setTexturePressed("ui/login/new1/b7.png")
    end

    self:refreshView()
end

function ServerListView:refreshView()
    self:showServerGroup()
end

function ServerListView:showServerGroup()
    for _, _group in ipairs(self.groupList) do
        local item = self.Button_serverListItem:clone()
        self.ListView_groupList:pushBackCustomItem(item)
        local Label_name = TFDirector:getChildByPath(item, "Label_name")

        if (_group.groupType == GLOBAL_SERVER_LIST.SERVER_NIMILANGUAGE) then

            local imgNew = TFImage:create("ui/recharge/new.png")
            imgNew:setPosition(80 , 20)
            item:addChild(imgNew)
        end
        Label_name:setText(_group.groupName)

        item:onClick(function()
            if _group.list and #_group.list > 1 then
                self.ListView_serverList:s():show()
                self:showServerList(_group)
                return
            end

            local serverId = nil
            if _group.list then
                serverId = _group.list[1].serverId
            end
            local function callback( )
                TFGlobalUtils:setCacheServer(_group.groupType)
                LogonHelper:switchLogin(_group.group_id, serverId, _group.id)
                --AlertManager:close()
                self:getParent():removeLayer(self,true)
                EventMgr:dispatchEvent(EV_LOGIN_UPDATESERVERNAME, _group.group_id, serverId, _group.id)
            end
            self:checkChangeLanaguage(_group, serverId, callback)
        end)
    end
end

function ServerListView:showServerList( group )
    self.ListView_serverList:removeAllItems()
    for _, _server in ipairs(group.list) do
        local item = self.Button_serverListItem:clone()
        self.ListView_serverList:pushBackCustomItem(item)
        local Label_name = TFDirector:getChildByPath(item, "Label_name")
        Label_name:setText(_server.serverName)

        item:onClick(function()
                local function callback( )
                    TFGlobalUtils:setCacheServer(group.groupType)
                    LogonHelper:switchLogin(group.group_id, _server.serverId, group.id)
                    --AlertManager:close()
                    self:getParent():removeLayer(self,true)
                    EventMgr:dispatchEvent(EV_LOGIN_UPDATESERVERNAME, group.group_id, _server.serverId, group.id)
                end
                self:checkChangeLanaguage(group, _server.serverId, callback)
        end)
    end
end

function ServerListView:checkChangeLanaguage( group, serverid, callback )
    local usingGroup = nil
    for _, _group in ipairs(self.groupList) do
        if _group.id == self.usingGroupCfgId then
            usingGroup = _group
            break
        end
    end
    if usingGroup and usingGroup.groupType ~= group.groupType then
        local alertparams = clone(EC_GameAlertParams)
        alertparams.msg = 190012010
        alertparams.comfirmCallback = function()
            LogonHelper:setCacheGroupCfgId(group.id)
            LogonHelper:setCacheServerId(serverid)
            LogonHelper:setCacheGroupId(group.group_id)
            TFGlobalUtils:setCacheServer(group.groupType)
            -- 重启客户端
            TFDirector:dispatchGlobalEventWith("Engine_Will_Restart", {})
            restartLuaEngine("")
        end
        showGameAlert(alertparams)
        return
    end

    callback()
end

function ServerListView:registerEvents()
    self.Panel_root:onClick(function()
            --AlertManager:close()
            self:getParent():removeLayer(self,true)
    end)
end

return ServerListView
