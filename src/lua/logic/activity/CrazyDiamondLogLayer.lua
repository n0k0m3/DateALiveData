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
*  
* 
]]

local CrazyDiamondLogLayer = class("CrazyDiamondLogLayer", BaseLayer)

function CrazyDiamondLogLayer:ctor( id )
    self.super.ctor(self, id)
    self:initData(id)
    self:init("lua.uiconfig.activity.crazyDiamondLogLayer")
end

function CrazyDiamondLogLayer:initData( id )
    self.activityId = id
end

function CrazyDiamondLogLayer:initUI( ui )
    self.super.initUI(self, ui)

    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    
    local historyScrollView = TFDirector:getChildByPath(self.rootPanel, "scrollView_history")
    self.historyListView = UIListView:create(historyScrollView)

    self.historyItemPanel1 = TFDirector:getChildByPath(ui, "panel_historyItem1")
    self.historyItemPanel2 = TFDirector:getChildByPath(ui, "panel_historyItem2")

    self.closeBtn = TFDirector:getChildByPath(self.rootPanel, "btn_close")

    self:updateUI()
end

function CrazyDiamondLogLayer:onShow( )
    self.super.onShow(self)
end

function CrazyDiamondLogLayer:updateUI( )
    self.historyListView:removeAllItems()
    local list = CrazyDiamondDataMgr:getOwnCrazyDiamondRank(self.activityId)
    for i,_info in ipairs(list) do
        local item = nil
        if math.mod(i, 2) == 1 then
            item = self.historyItemPanel1:clone()
        else
            item = self.historyItemPanel2:clone()
        end
        if item then
            self:updateHistoryItem(i, _info, item)
            self.historyListView:pushBackCustomItem(item)
        end
    end
end

function CrazyDiamondLogLayer:updateHistoryItem( idx, info, item )
    local timeLabel = TFDirector:getChildByPath(item, "label_time")
    timeLabel:setText(idx)
    local diamondLabel = TFDirector:getChildByPath(item, "label_diamond")
    local itemCfg = GoodsDataMgr:getItemCfg(info.itemId)
    diamondLabel:setText(TextDataMgr:getText(itemCfg.nameTextId) .." x " ..info.itemNum)
end

function CrazyDiamondLogLayer:registerEvents( )
    self.super.registerEvents(self)

    self.closeBtn:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function CrazyDiamondLogLayer:removeEvents( )
    self.super.removeEvents(self)
end

function CrazyDiamondLogLayer:removeUI()
    self.super.removeUI(self)
end

return CrazyDiamondLogLayer
