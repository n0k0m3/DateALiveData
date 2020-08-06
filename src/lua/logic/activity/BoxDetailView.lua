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
* --礼物盒详细界面
]]

local BoxDetailView = class("BoxDetailView",BaseLayer)

function BoxDetailView:ctor( activityId ,data )
	self.super.ctor(self,data)
	self.activityId = activityId
	self.itemInfo = data
    self:showPopAnim(true)
	self.progressInfo = ActivityDataMgr2:getProgressInfo(self.itemInfo.type,self.itemInfo.id)
	self:init("lua.uiconfig.activity.BoxDetailView")
end

function BoxDetailView:initUI( ui )
	self.super.initUI(self,ui)
	local panel_cg = TFDirector:getChildByPath(ui,"panel_cg")
	local label_des = TFDirector:getChildByPath(ui,"label_des")
	local image_ywc = TFDirector:getChildByPath(ui,"image_ywc")
	local btn_go = TFDirector:getChildByPath(ui,"btn_go")
	local Button_close = TFDirector:getChildByPath(ui,"Button_close")

	local Panel_dating = TFDirector:getChildByPath(ui,"Panel_dating")
	local Panel_reward = TFDirector:getChildByPath(ui,"Panel_reward")
	local panel_item = TFDirector:getChildByPath(ui,"panel_item")
	local btn_get = TFDirector:getChildByPath(ui,"btn_get")

	Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)
	if self.progressInfo.progress < tonumber(self.itemInfo.target) then
		label_des:setTextById(self.itemInfo.extendData.lockDes)
	else
		label_des:setTextById(self.itemInfo.extendData.unLockDes)
	end
	image_ywc:setVisible(self.progressInfo.status == EC_TaskStatus.GETED)
	btn_go:onClick(function ( ... )
		if self.progressInfo.progress < tonumber(self.itemInfo.target) then
        	toastMessage(TextDataMgr:getText(12100085))
			return
		end
        -- FunctionDataMgr:enterByFuncId(self.itemInfo.extendData.jumpInterface,self.itemInfo.extendData.datingScriptId)
		DatingDataMgr:startDating(self.itemInfo.extendData.datingScriptId)
		AlertManager:closeLayer(self)
	end)

	btn_get:setGrayEnabled(self.progressInfo.status == EC_TaskStatus.GETED)
	btn_get:setTouchEnabled(self.progressInfo.status ~= EC_TaskStatus.GETED)

	btn_get:onClick(function ( ... )
		if self.progressInfo.status == EC_TaskStatus.ING then
        	toastMessage(TextDataMgr:getText(12100085))
			return
		end
        -- FunctionDataMgr:enterByFuncId(self.itemInfo.extendData.jumpInterface,self.itemInfo.extendData.datingScriptId)
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.itemInfo.id)
		AlertManager:closeLayer(self)
	end)

	-- local cg_cfg = TabDataMgr:getData("Cg")[self.itemInfo.extendData.cg] or TabDataMgr:getData("Cg")[43]
 --    local layer = require("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil,false,function ()
           
 --        end)
 	Panel_dating:hide()
 	Panel_reward:hide()
    
    if self.itemInfo.extendData.cg and self.itemInfo.extendData.cg ~= 0 then
 		Panel_dating:show()
	 	local good =  GoodsDataMgr:getItemCfg(self.itemInfo.extendData.cg)
	 	local image = TFImage:create(good.icon)

	    local parentSize = panel_cg:Size()
	    local scaleX = parentSize.width/image:Size().width
	    local scaleY = parentSize.height/image:Size().height
	    image:setScale(math.max(scaleX,scaleY))
	 	image:setAnchorPoint(me.p(0,0))
	    panel_cg:addChild(image)
	else
 		Panel_reward:show()
 		local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(panel_goodsItem, self.itemInfo.extendData.rewardShow)
        panel_goodsItem:setPosition(me.p(0, 0))
        panel_item:addChild(panel_goodsItem)
	end

end

return BoxDetailView