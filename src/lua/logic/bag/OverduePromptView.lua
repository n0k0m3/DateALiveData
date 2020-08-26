--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local OverduePromptView = class("OverduePromptView", BaseLayer)

local List_Type = {
    OutTime = 1,
    ReturnItem  = 2
}
local function isExist(tab, id)
    local ret = nil
    for k,v in pairs(tab) do
        if id == v.id then
            ret = k
            break;
        end
    end
    return ret
end

local function addItems(tab, item)
    local key = isExist(tab,item.id)
    if key then
        tab[key].num = tab[key].num + item.num
        return;
    end
    table.insert(tab, item)
end

function OverduePromptView:ctor(data)
    self.super.ctor(self,data)
    self.data = data 
--    or {
--        originItem = {{id = 522097, num = 3}, {id = 522097, num = 3}, {id = 522097, num = 3}, {id = 522097, num = 3}, {id = 522097, num = 3}, {id = 522097, num = 3}, {id = 522097, num = 3}, {id = 522097, num = 3}},
--        convertItem = {{id = 520050, num = 3}, {id = 520050, num = 3}, {id = 520050, num = 3}, {id = 520050, num = 3}, {id = 520050, num = 3}, {id = 520050, num = 3}, {id = 520050, num = 3}, {id = 520050, num = 3}},
--    }
    self:showPopAnim(true)
    self:init("lua.uiconfig.bag.overduePromptView")
end

function OverduePromptView:initUI( ui )
	self.super.initUI(self,ui)
    local panelBase = ui:getChildByName("Panel_base")
    self.btn_close = panelBase:getChildByName("Button_close")
    self.btn_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    local ScrollView_Recycle = panelBase:getChildByName("ScrollView_Recycle")
    self.ScrollView_Recycle = UIListView:create(ScrollView_Recycle)

    local ScrollView_Return = panelBase:getChildByName("ScrollView_Return")
    self.ScrollView_Return = UIListView:create(ScrollView_Return)

    self.Button_Confirm = panelBase:getChildByName("Button_Confirm")
    self.Button_Confirm:onClick(function()
        AlertManager:closeLayer(self)        
    end)

    self.prefebList = ui:getChildByName("Panel_list")
    self.prefebList:Hide()
    self.prefeb = ui:getChildByName("Panel_item")
    self.prefeb:Hide()

    self.prefebSize = self.prefeb:getContentSize()

    self.listViewItems = {}


    self:addCountDownTimer()
    self:updateView(self.data)
    self:updateCountDown()
end


function OverduePromptView:updateView(data)
   

--    local tempTab = {cItem = {}, oItem = {}}
--    for i = 1, #data do
--        local covertItems = data[i]
--        addItems(tempTab.cItem, covertItems.convertItem)
--        addItems(tempTab.oItem, covertItems.originItem)
--    end
    

    self:updateList(self.ScrollView_Recycle, data.originItem, List_Type.OutTime)
    self:updateList(self.ScrollView_Return, data.convertItem, List_Type.ReturnItem)
end

function OverduePromptView:updateList(list, data, type_)
    list:removeAllItems()
    local offset = self.prefebSize.width / 2 + 25
    local listNum =  math.ceil((table.count(data)) / 4)
    list:setItemsMargin(10)
    for i = 1, listNum do
        local clonePanel = self.prefebList:clone()
        clonePanel:setVisible(true)        
        list:pushBackCustomItem(clonePanel)

        for j = 1,4 do
            local info = data[(i - 1) * 4 + j]
            if info then               
                local cloneItem = self.prefeb:clone()
                clonePanel:addChild(cloneItem)
                cloneItem:setVisible(true)
                cloneItem:setPosition((self.prefebSize.width + 40) * (j - 1) + offset, self.prefebSize.height/2)
                cloneItem.Coupon = info
                cloneItem.time = cloneItem:getChildByName("label_outTime")
                table.insert(self.listViewItems , cloneItem)
                self:initItem(cloneItem, info, type_)
            end
        end
    end
end

function OverduePromptView:initItem(item, info,type_)
    local itemConfig = GoodsDataMgr:getItemCfg(info.cid)
    local icon = item:getChildByName("Image_icon")
    icon:setTexture(itemConfig.icon)

    item:setTouchEnabled(true)
    item:addMEListener(TFWIDGET_TOUCHENDED, function(sender)
        Utils:showInfo(info.cid)
    end)

    local Label_count = item:getChildByName("Label_count")
    Label_count:setText(info.num or "")

    if type_ == List_Type.ReturnItem then
        local tip_outtime = item:getChildByName("Image_outtime")
        tip_outtime:setVisible(false)
    end

end

function OverduePromptView:updateCountDown()
    for k,v in pairs(self.listViewItems) do
        local remainTime = math.max(0, v.Coupon.outTime - ServerDataMgr:getServerTime())
        if remainTime == 0 then
--          self:removeCountDownTimer()
            v.time:setTextById(301010)          
        else
            
            local day, hour, min = Utils:getTimeDHMZ(remainTime)
            v.time:setTextById(190000114, day,hour, min)
            v.time:setVisible(true)
        end
        v.remainTime = remainTime
    end
end

function OverduePromptView:onCountDownPer()
    self:updateCountDown()
end

function OverduePromptView:addCountDownTimer()
    if self.countDownTimer_ then return end
    self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
end

function OverduePromptView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function OverduePromptView:removeUI()
    self:removeCountDownTimer();
end

return OverduePromptView


--endregion
