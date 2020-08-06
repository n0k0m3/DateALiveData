local NewCityRemindView = class("NewCityRemindView", BaseLayer)

function NewCityRemindView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.newCity.newCityRemindView")
end

function NewCityRemindView:registerEvents()
    EventMgr:addEventListener(self, EV_NEW_CITY.cityRemindEventSuccess, handler(self.showReminds, self))
end

function NewCityRemindView:initData()
    self.showEvents = NewCityDataMgr:getRemindEvents()
    self.showTime = 1.5
end

function NewCityRemindView:initUI(ui)
    self.super.initUI(self,ui)

    --local ScrollView_remind = TFDirector:getChildByPath(ui, "ScrollView_remind")
    --self.GridView_remind = UIGridView:create(ScrollView_remind)

    self:showReminds()
end

function NewCityRemindView:showReminds()
    --self.GridView_remind:removeAllItems()
    --默认解锁所有建筑
    if #self.showEvents.build > 0 then
        NewCityDataMgr:sendFinishRemindMsg(EC_NewCityRemindType.Build)
        --local str = ""
        --for i, v in ipairs(self.showEvents.build) do
        --    local nameid = TabDataMgr:getData("NewBuild", v.buildingId).nameId
        --    str = str..", "..TextDataMgr:getText(nameid)
        --end
        --self:timeOut(function()
        --    --不提示建筑解锁
        --    toastMessageUnlock(TextDataMgr:getText(500035), str, "", 3)
        --    NewCityDataMgr:sendFinishRemindMsg(EC_NewCityRemindType.Build)
        --end, 0.1)
        --return
    end
    

    if #self.showEvents.buildfuns > 0 then
        NewCityDataMgr:sendFinishRemindMsg(EC_NewCityRemindType.BuildFuncs)
        -- local str = ""
        -- for i, v in ipairs(self.showEvents.buildfuns) do
        --     local nameid = TabDataMgr:getData("CityEffect", v.funId).name
        --     local buildNameId = TabDataMgr:getData("NewBuild", v.buildingId).nameId
        --     str = str..", "..TextDataMgr:getText(buildNameId)..TextDataMgr:getText(nameid)
        -- end
        -- self:timeOut(function()
        --     toastMessageUnlock(TextDataMgr:getText(500042), str, "", self.showTime)
        --     NewCityDataMgr:sendFinishRemindMsg(EC_NewCityRemindType.BuildFuncs)
        -- end, 0)
        -- return
    end

    if #self.showEvents.role > 0 then
        local str = ""
        for i, v in ipairs(self.showEvents.role) do
            local nameId = TabDataMgr:getData("Role", v.exeId).nameId
            str = str..", "..TextDataMgr:getText(nameId)
        end
        self:timeOut(function()
            toastMessageUnlock(TextDataMgr:getText(500041), str, "", self.showTime)
            NewCityDataMgr:sendFinishRemindMsg(EC_NewCityRemindType.Role)
        end, 0.2)
        return
    end
    AlertManager:closeLayer(self)
end

return NewCityRemindView