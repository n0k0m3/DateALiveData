local MigrationServerLayer = class("MigrationServerLayer", BaseLayer)

function MigrationServerLayer:ctor(callback)
    self.super.ctor(self,callback)
    self.callback = callback
    self:init("lua.uiconfig.loginScene.migrationServerLayer")
end

function MigrationServerLayer:initUI(ui)
	self.super.initUI(self,ui)

	self.rootPanel = TFDirector:getChildByPath(ui,"panel_root")
	self.pulldown_panel = TFDirector:getChildByPath(self.rootPanel,"panel_pulldown")
	self.okBtn = TFDirector:getChildByPath(self.rootPanel,"btn_ok")
    self.backBtn = TFDirector:getChildByPath(self.rootPanel,"btn_back")
	self:initPullDown()
	local _exitCacheValue, migrationServerId = TFGlobalUtils:getMigrationServerId(true)
	self:setMigrationServerId(migrationServerId)

    self.titleLabel = TFDirector:getChildByPath(self.rootPanel,"label_title")
    self.titleLabel:setTextById(190000816)
end

function MigrationServerLayer:removeUI()
	self.super.removeUI(self)
end

function MigrationServerLayer:registerEvents()
	self.super.registerEvents(self)

	self.okBtn:onClick(function()
        local _exitCacheValue, migrationServerId = TFGlobalUtils:getMigrationServerId(true)
        local isUpdate = (migrationServerId ~= self.migrationServerId)
		TFGlobalUtils:setMigrationServerId(self.migrationServerId)
        if self.callback then
            self.callback(isUpdate)
        end
        self:getParent():removeLayer(self,true)
    end)

    self.backBtn:onClick(function()
        self:getParent():removeLayer(self,true)
    end)
end

function MigrationServerLayer:removeEvents()
	self.super.removeEvents(self)
end

function MigrationServerLayer:setMigrationServerId( migrationServerId )
	self.migrationServerId = migrationServerId
	self:updatePullDown(migrationServerId)
end

function MigrationServerLayer:updatePullDown( migrationServerId )
    self.pulldown_winCell:stopAllActions()
    
    self.curwindownsize = me.size(self.defaultPulldownCellSize.width,self.defaultPulldownCellSize.height*10)
    self.btn_pulldown.title = TFGlobalUtils:getMigrationServerTextById(migrationServerId)
    self.btn_pulldown:getChildByName("label_title"):setTextById(self.btn_pulldown.title)
    self.pulldown_btnlist:removeAllItems()
    self.pulldown_window:setContentSize(self.curwindownsize)
    self.pulldown_btnlist:setContentSize(self.curwindownsize)
    self.pulldown_winCell:setPosition(me.p(0,0))

    local list = {}
    for _,_migrationServerId in pairs(MIGRATION_SERVER_LIST) do
    	if _migrationServerId > MIGRATION_SERVER_LIST.UNKNOW then
    		table.insert(list, _migrationServerId)
    	end
    end
    table.sort(list, function( a, b )
    	return a > b
    end)

    for _idx,_migrationServerId in ipairs(list) do
        local tmitem = self.pulldown_btnlist:pushBackDefaultItem()
        tmitem:show()
        if _idx==1 and _idx < table.count(MIGRATION_SERVER_LIST) then
            tmitem:getChildByName("img_option"):setTexture("ui/playerInfo/medal/ui_09.png")
        elseif _idx < table.count(MIGRATION_SERVER_LIST) then
            tmitem:getChildByName("img_option"):setTexture("ui/playerInfo/medal/ui_12.png")
        else
            tmitem:getChildByName("img_option"):setTexture("ui/playerInfo/medal/ui_10.png")
        end
        tmitem.title = TFGlobalUtils:getMigrationServerTextById(_migrationServerId)
        tmitem:getChildByName("label_title"):setTextById(tmitem.title)
        tmitem:setTouchEnabled(true)
        tmitem:onClick(function()
            if self.btn_pulldown.unclick == true then
                return
            end
            self.btn_pulldown.unclick = true
            local actionarr = {MoveTo:create(0.1,me.p(0,0)),CallFunc:create(function()
                self.btn_pulldown.unclick = false
                self.btn_pulldown.stat = false
                if self.btn_pulldown.title ~= tmitem.title then
                    self.btn_pulldown.title = tmitem.title   
                    self:setMigrationServerId(_migrationServerId)
                end
            end)}
            self.pulldown_winCell:runAction(Sequence:create(actionarr))
            self.btn_pulldown:getChildByName("img_arrow"):setFlipY(not self.btn_pulldown:getChildByName("img_arrow"):isFlipY())
        end)
    end

    self.btn_pulldown:onClick(function()
        if self.btn_pulldown.unclick == true then
            return
        end
        self.btn_pulldown.unclick = true
        if self.btn_pulldown.stat == false then
            local actionarr = {MoveTo:create(0.1,me.p(0,-self.curwindownsize.height)),CallFunc:create(function()
                self.btn_pulldown.unclick = false
                self.btn_pulldown.stat = true
            end)}
            self.pulldown_winCell:runAction(Sequence:create(actionarr))
        else
            local actionarr = {MoveTo:create(0.1,me.p(0,0)),CallFunc:create(function()
                self.btn_pulldown.unclick = false
                self.btn_pulldown.stat = false
            end)}
            self.pulldown_winCell:runAction(Sequence:create(actionarr))
        end
        self.btn_pulldown:getChildByName("img_arrow"):setFlipY(not self.btn_pulldown:getChildByName("img_arrow"):isFlipY())
    end)
end

function MigrationServerLayer:initPullDown()
    self.btn_pulldown = self.rootPanel:getChildByName("btn_pulldown")
    self.pulldown_window = self.rootPanel:getChildByName("panel_window")
    self.pulldown_winCell = self.pulldown_window:getChildByName("panel_pullwin")
    local scroll_menu = self.pulldown_window:getChildByName("scrollView_menu")
    local pulldown_cell = scroll_menu:getChildByName("panel_cell")
    self.defaultPulldownCellSize = pulldown_cell:getContentSize()
    self.btn_pulldown.stat = false
    self.btn_pulldown.unclick = false
    self.pulldown_btnlist = UIListView:create(scroll_menu)
    self.pulldown_btnlist:setItemModel(pulldown_cell)
    pulldown_cell:setVisible(false)
end

return MigrationServerLayer;
