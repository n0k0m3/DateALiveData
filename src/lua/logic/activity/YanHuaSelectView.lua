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
*--烟花使用界面
* 
]]

local YanHuaSelectView = class("YanHuaSelectView",BaseLayer)

function YanHuaSelectView:ctor( data )
	self.super.ctor(self,data)
    -- self:showPopAnim(true)
	self:init("lua.uiconfig.activity.YanHuaSelectView")
end

function YanHuaSelectView:initUI( ui )
	self.super.initUI(self,ui)
	self.tip1 = TFDirector:getChildByPath(ui,"tip1");
	self.tip2 = TFDirector:getChildByPath(ui,"tip2");
	self.btn_sure = TFDirector:getChildByPath(ui,"btn_sure");
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close");
	local ScrollView_pos = TFDirector:getChildByPath(ui,"ScrollView_pos");
	local posItem = TFDirector:getChildByPath(ui,"pos1"):hide();

	self.uiListView = UIListView:create(ScrollView_pos)

	self.tip1:setTextById(13100050)
	local cfg = TabDataMgr:getData("FireWork")
	self.fireWorks = {}
	for k,v in pairs(cfg) do
		self.fireWorks[v.type] = 1
	end

	for id,i in pairs(self.fireWorks) do
		if GoodsDataMgr:getItemCount(id) > 0 then
			self.selectId = id
			break;
		end
	end

	self.anis = {}
	local i = 1
	for k,v in pairs(self.fireWorks) do
		local pos = posItem:clone()
		pos:show()
		local ani = TFDirector:getChildByPath(pos,"spine_ani");
		local panel_click = TFDirector:getChildByPath(pos,"panel_click");
		self.uiListView:pushBackCustomItem(pos)
		local id = k
		self.anis[k] = ani
		ani:playByIndex(0,-1,-1,1)

	    local itemCfg = GoodsDataMgr:getItemCfg(id)
	    local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	    PrefabDataMgr:setInfo(panel_goodsItem, id,GoodsDataMgr:getItemCount(id))
	    panel_goodsItem:setPosition(me.p(0, 0))
	    pos:addChild(panel_goodsItem)
	    panel_goodsItem:setTouchEnabled(false)
	    panel_click.idx = k
	    panel_click:onClick(function ( ... )
	    	for _k,_v in pairs(self.anis) do
	    		_v:setVisible(_k==panel_click.idx)
	    		if _k == panel_click.idx then
		    		self.selectId = k
		    	end
	    	end
	    end)
	    i = i + 1
	end
	if self.selectId then
		local idx = 1
		for id,i in pairs(self.fireWorks) do
			if id == self.selectId then
				break;
			end
			idx = idx + 1
		end

		if idx > 3 then
			self.uiListView:jumpToRight(idx)
		else
			self.uiListView:jumpToLeft(idx)
		end		
		self.anis[self.selectId]:setVisible(true)
	end
end


function YanHuaSelectView:registerEvents( )
	self.super.registerEvents(self)
	self.btn_sure:onClick(function ()
		--确认使用烟花
		if not self.selectId then
			Utils:showTips(13100076)
			return
		else
			TFDirector:send(c2s.SPRING_FESTIVAL_REQ_USE_FIREWORKS,{self.selectId})
		end
		AlertManager:closeLayer(self)
	end)
	self.Button_close:onClick(function (  )
		AlertManager:closeLayer(self)
	end)
end



return YanHuaSelectView