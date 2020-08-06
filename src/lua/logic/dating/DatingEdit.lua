local DatingEdit = class("DatingEdit",BaseLayer)

local DatingScriptConfig = require("lua.logic.dating.DatingScriptConfig")

function DatingEdit:initData(callFuncIn,callFuncOut)
    self.callFuncIn_ = callFuncIn
    self.callFuncOut_ = callFuncOut
    self.itemList = {}
end

function DatingEdit:ctor(callFuncIn,callFuncOut)
    self.super.ctor(self)

    self:initData(callFuncIn,callFuncOut)

    self:init("lua.uiconfig.dating.datingEdit")
end

function DatingEdit:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Panel_view = TFDirector:getChildByPath(self.ui, "Panel_view"):hide()
    self.Button_continue = TFDirector:getChildByPath(self.ui, "Button_continue")
    self.Button_scriptEdit = TFDirector:getChildByPath(self.ui,"Button_scriptEdit")
    self.Label_datingId = TFDirector:getChildByPath(self.ui, "Label_datingId")

    self:initListView()
end

--剧情ID
function DatingEdit:refreshId(id)
    self.id = id
    self.Label_datingId:setText("id: " .. id)
end

function DatingEdit:showView()
    self.Panel_view:show()
    self:showListView()
    self.Button_scriptEdit:hide()
end

function DatingEdit:hideView()
    self.Panel_view:hide()
    self:hideListView()
    self.Button_scriptEdit:show()
end

function DatingEdit:initListView()
    local ScrollView_option = TFDirector:getChildByPath(self.ui, "ScrollView_option")
    self.listView = UIListView:create(ScrollView_option)
end

function DatingEdit:showListView()
    local Panel_item = TFDirector:getChildByPath(self.ui, "Panel_item")
    for i,v in ipairs(DatingScriptConfig.fieldConfig) do
        local item = Panel_item:clone()
        self:initItem(item,v)
        self.listView:pushBackCustomItem(item)
        self.itemList[i] = item
    end
end

function DatingEdit:initItem(item,data)
    item.name = data.name
    item.sType = data.sType
    local Label_title = TFDirector:getChildByPath(item, "Label_title")
    Label_title:setTextById(data.title)
    local TextField_input = TFDirector:getChildByPath(item, "TextField_input")
    item.textField = TextField_input
end

function DatingEdit:hideListView()
    self.listView:removeAllItems()
end

function DatingEdit:registerEvents()
    self.super.registerEvents(self)

    self.Button_continue:onClick(function()
            local data = {}
            for i, v in ipairs(self.itemList) do
                print("v.name ",v.name)
                if v.textField and v.name and #v.textField:getText() > 0 then
                    local uData = {}
                    uData.key = v.name
                    local content = v.textField:getText()
                    if v.sType == "number" then
                        if not tonumber(content)then
                            -- Utils:showTips(uData.key .. "输入值错误，请输入正确的数据")
                            Utils:showTips(uData.key .. TextDataMgr:getText(100000020))
                            return
                        end
                    end
                    if v.sType == "table" then
                        uData.value = {}
                        uData.value.x = tonumber(string.split(content, ",")[1])
                        uData.value.y = tonumber(string.split(content, ",")[2])
                    else
                        uData.value = content
                    end

                    table.insert(data,uData)
                end
            end
            print(" 发送data ",data)
            self.callFuncOut_(data)
            self:hideView()
        end)

    self.Button_scriptEdit:onClick(function()
            self:showView()
            self.callFuncIn_()
        end)

end

function DatingEdit:onClose()
    self.super.onClose(self)
end


return DatingEdit
