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
* -- 背包物品回收
]]

local RecoverItemView = class("RecoverItemView",BaseLayer)

function RecoverItemView:ctor( data )
	self.super.ctor(self,data)
	self.data = data
    self:showPopAnim(true)
	self:init("lua.uiconfig.bag.recoverView")
end

function RecoverItemView:initUI( ui )
	self.super.initUI(self,ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    local ScrollView_reward = TFDirector:getChildByPath(Image_content, "ScrollView_reward")
    self.ListView_Recover = UIListView:create(ScrollView_reward)
    local ScrollView_reward1 = TFDirector:getChildByPath(Image_content, "ScrollView_reward1")
    self.ListView_profix = UIListView:create(ScrollView_reward1)
    self.Panel_headItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_headItem")
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")

    self.Button_close:onClick(function ( ... )
    	AlertManager:closeLayer(self)
    end)

    self.Button_ok:onClick(function ( ... )
    	AlertManager:closeLayer(self)
    end)

    for k,v in pairs(self.data.itemList) do
    	local panelItem = self.Panel_headItem:clone()
    	local Panel_head = TFDirector:getChildByPath(panelItem, "Panel_head")
    	local trail_flag = TFDirector:getChildByPath(panelItem, "trail_flag"):hide()
    	local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	    Panel_goodsItem:Pos(0, 0):AddTo(Panel_head, 1)
	    PrefabDataMgr:setInfo(Panel_goodsItem,v.id,v.num)
        self.ListView_Recover:pushBackCustomItem(panelItem)

    	local itemCfg = GoodsDataMgr:getItemCfg(v.id)
        if itemCfg.superType == EC_ResourceType.TRAILCARD then
        	trail_flag:show()
        end
    end

    if self.data.recoverProfit then
        for k,v in pairs(self.data.recoverProfit) do
        	local panelItem = self.Panel_headItem:clone()
        	local Panel_head = TFDirector:getChildByPath(panelItem, "Panel_head")
        	local trail_flag = TFDirector:getChildByPath(panelItem, "trail_flag"):hide()
        	local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    	    Panel_goodsItem:Pos(0, 0):AddTo(Panel_head, 1)
    	    PrefabDataMgr:setInfo(Panel_goodsItem,v.id,v.num)
            self.ListView_profix:pushBackCustomItem(panelItem)
        end
    end
    Utils:setAliginCenterByListView(self.ListView_profix,true)
    --Utils:setAliginCenterByListView(self.ListView_Recover,true)
end

return RecoverItemView