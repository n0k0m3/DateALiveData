local MonthCardNew = class("MonthCardNew", BaseLayer)

function MonthCardNew:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.recharge.monthCardNew")
end

function MonthCardNew:initData(data)
    self.helpIds = data[1] or {}
    self.rechargeData = data[2]
end

function MonthCardNew:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Button_buy   = TFDirector:getChildByPath(self.ui,"Button_buy");
    self.Button_buy:onClick(function()
            RechargeDataMgr:getOrderNO(self.rechargeData.rechargeCfg.id)
        end)

    self.Button_shiyong = TFDirector:getChildByPath(self.ui , "Button_shiyong")
    self.Button_shiyong:onClick(function ( ... )
        TFDeviceInfo:openUrl("http://en.datealive.com/user_pay_protocol.html")
    end)

    self.Button_yinsi = TFDirector:getChildByPath(self.ui , "Button_yinsi")
    self.Button_yinsi:onClick(function ( ... )
        TFDeviceInfo:openUrl("https://en.datealive.com/dal/policy")
    end)
    

    self.Label_text = TFDirector:getChildByPath(self.ui, "Label_text")

    local ScrollView_list = TFDirector:getChildByPath(self.ui, "ScrollView_list")

    self.text_list = UIListView:create(ScrollView_list)
    self.text_list:setItemsMargin(10)
    self:initContent()
end

function MonthCardNew:registerEvents()

end

function MonthCardNew:initContent()
    local helpData = TopHelpDataMgr:getHelpDataByIds(self.helpIds)
    local textType = false
    for i,v in ipairs(helpData) do
        if v.type == 0 then
            textType = true
            for i,id in ipairs(v.desc) do
                local label = self.Label_text:clone()
                label:setTextById(id)
                label:setWidth(340)
                self.text_list:pushBackCustomItem(label)
                if i == 2 and self.helpIds[1] == 998 then --月卡续费协议
                    dump(TextDataMgr:getText(id))
                    label:setTouchEnabled(true)
                    label:onClick(function()
                            Box(TextDataMgr:getText(id))
                            TFDeviceInfo:openUrl(TextDataMgr:getText(id));
                        end)
                end
            end
        end
    end
    
end


return MonthCardNew