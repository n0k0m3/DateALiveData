
local CallBackShareView = class("CallBackShareView", BaseLayer)

function CallBackShareView:initData(activityId)
    self.activityId = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId)
    if not self.activityInfo_ then
        return
    end
    self.dressTaskId = self.activityInfo_.extendData.fashion
end

function CallBackShareView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:init("lua.uiconfig.activity.callbackShareView")
end

function CallBackShareView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.label_back_num = TFDirector:getChildByPath(self.Panel_root, "label_back_num")
    self.label_invite_uid = TFDirector:getChildByPath(self.Panel_root, "label_invite_uid")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.label_dress_tip = TFDirector:getChildByPath(self.Panel_root, "label_dress_tip")
    self.label_dress_name = TFDirector:getChildByPath(self.Panel_root, "label_dress_name")

    self:refreshView()
end


function CallBackShareView:refreshView()

    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, self.dressTaskId)
    if itemInfo then
        local itemId
        for k,v in pairs(itemInfo.reward) do
            itemId = k
            break
        end

        if not itemId then
            return
        end
        local dressItemCfg = GoodsDataMgr:getItemCfg(itemId)
        if dressItemCfg then
            self.label_dress_name:setTextById(dressItemCfg.nameTextId)
        end
    end

    local callbackData = ActivityDataMgr2:getCallBackInfo()
    if not callbackData then
        return
    end
    local isReturnPerson = callbackData.isReturn
    self.label_invite_uid:setTextById(63694,callbackData.codeInfo)
    self.label_invite_uid:setVisible(not isReturnPerson)


    self:timeOut(function()
        local ret = self:shareResult()
        if ret then
            ActivityDataMgr2:ReqShareComplete(self.activityId)
        end
    end,0.1)

end

function CallBackShareView:shareResult()

    local ret = false
    if HeitaoSdk then
        ret = HeitaoSdk.takeScreenshot();
    else
        ret = takeScreenshot()
        ret = true
    end
    return ret
end

function CallBackShareView:responseView()
    self.Panel_response:setVisible(true)
end

function CallBackShareView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return CallBackShareView
