
local TipOff = class("TipOff", BaseLayer)

function TipOff:ctor(data)
    self.super.ctor(self)
    self:showPopAnim(true)
    if type(data) == "table" then
        self.reportInfo = data
    else
        self.playerID = data
    end
    self:init("lua.uiconfig.playerInfo.tipOff")
end

function TipOff:initUI(ui)
	self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    local ScrollView = TFDirector:getChildByPath(ui, "ScrollView_access")
    self.ListView = UIListView:create(ScrollView)
    self.ListView:setItemsMargin(10)

    self.item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_item")
    self:createList();
end

function TipOff:createList()
    for k,v in pairs(EC_ReportPlayerType) do
        local item = self.item:clone();
        local label = TFDirector:getChildByPath(item,"Label_desc");
        label:setTextById(v)
        local btn = TFDirector:getChildByPath(item,"Button_report");
        btn:onClick(function()
                if self.playerID then
                    MainPlayer:reportPlayer(self.playerID,v)
                elseif self.reportInfo then
                    table.insert(self.reportInfo,v)
                    TeamFightDataMgr:requestInformPlayer(self.reportInfo)
                end
                AlertManager:closeLayer(self)
            end)
        self.ListView:pushBackCustomItem(item)
    end
end

function TipOff:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
        end)
end


function TipOff:removeEvents()

end

return TipOff
