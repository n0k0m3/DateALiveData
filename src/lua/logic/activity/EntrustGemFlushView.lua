--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 宝石刷新委托列表
]]

local EntrustGemFlushView = class("EntrustGemFlushView", BaseLayer)

function EntrustGemFlushView:initData(activityInfo)
    self.activityInfo = activityInfo
    self.itemCfg_ = GoodsDataMgr:getItemCfg(self.activityInfo.extendData.refreshItemId)
   	self.itemRecoverCfg = TabDataMgr:getData("ItemRecover",self.itemCfg_.buyItemRecover)
    local usedCount = self.activityInfo.extendData.refreshCount or 0
   	self.remainCount = #self.itemRecoverCfg.price - usedCount
    if self.remainCount <= 0 then
        usedCount = #self.itemRecoverCfg.price - 1 
    end
   	local cost = self.itemRecoverCfg.price[usedCount + 1][1][1]
   	self.costItemCid_ = cost.id
   	self.costItemNum_ = cost.num
end

function EntrustGemFlushView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.EntrustGemFlushView")
end

function EntrustGemFlushView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(Image_bg, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Label_title = TFDirector:getChildByPath(Image_bg, "Label_title")
    self.Label_remainCount = TFDirector:getChildByPath(Image_bg, "Label_remainCount")
    self.Label_tips = TFDirector:getChildByPath(Image_bg, "Label_tips")
    self.Image_costIcon = TFDirector:getChildByPath(Image_bg, "Image_costIcon")
    self.Label_costNum = TFDirector:getChildByPath(Image_bg, "Label_costNum")

    self:refreshView()
end

function EntrustGemFlushView:refreshView()
    self.Label_ok:setTextById(800010)
    self.Label_title:setTextById(800011)

    self.Label_tips:setTextById(12100078, tostring(self.remainCount))


    local itemCfg = GoodsDataMgr:getItemCfg(self.costItemCid_)
    self.Label_remainCount:setTextById(12100077,tostring(self.costItemNum_),TextDataMgr:getText(itemCfg.nameTextId))
    self.Image_costIcon:setTexture(itemCfg.icon)
    self.Label_costNum:setTextById(800007, tostring(self.costItemNum_))
end

function EntrustGemFlushView:registerEvents()

    self.Button_close:onClick(
        function()
            AlertManager:close()
        end, EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
            if self.remainCount > 0  then
                if GoodsDataMgr:currencyIsEnough(self.costItemCid_, self.costItemNum_) then
					TFDirector:send(c2s.ACTIVITY_REQ_REFRESH_ENTRUST_ACTIVITY_TASK,{self.activityInfo.id,2})
                    AlertManager:closeLayer(self)
                else
                    Utils:showAccess(self.costItemCid_)
                end
            else
               Utils:showTips(12100080)
            end
    end)
end

function EntrustGemFlushView:onDailyBuyCountEvent(levelGroupId)
    Utils:showTips(12100079)
end

return EntrustGemFlushView
