local ShareMainView = class("ShareMainView", BaseLayer)


function ShareMainView:ctor()
    self.super.ctor(self)
    self:showPopAnim(true)
    self:init("lua.uiconfig.recharge.shareMainView")
end

function ShareMainView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	self.Button_back	= TFDirector:getChildByPath(ui,"Button_back")
	self.Button_share 	= TFDirector:getChildByPath(ui,"Button_share")
	self.Button_buy		= TFDirector:getChildByPath(ui,"Button_buy")

	self.Image_hero 	= TFDirector:getChildByPath(ui,"Image_hero")

	self.itemBg = {}
	for i=1,2 do
		self.itemBg[i] = {}
		self.itemBg[i].bg = TFDirector:getChildByPath(ui,"Image_item_bg"..i)
		self.itemBg[i].icon = TFDirector:getChildByPath(self.itemBg[i].bg,"Imag_item")
		self.itemBg[i].Label_num = TFDirector:getChildByPath(self.itemBg[i].bg,"Label_num")
	end 

	TFDirector:send(c2s.SHARE_REQ_SHARE_INFOS, {})
end

function ShareMainView:initUILogic()

	local info = ShareDataMgr:getShareInfoById(2)
	if not info then
		return
	end

	ShareDataMgr:setShareOpenFlag(info.id)

	--statue:1
	if info.statue == 0 then
		self.Button_share:setVisible(true)
		self.Button_buy:setVisible(false)
	elseif info.statue == 1 then
		self.Button_share:setVisible(false)
		self.Button_buy:setVisible(true)
	elseif info.statue == 2 then
		self.Button_share:setVisible(false)
		self.Button_buy:setVisible(false)
	end
	for k,v in ipairs(info.rewards) do
		if not self.itemBg[k] then  
			break
		end
		local itemCfg = GoodsDataMgr:getItemCfg(v.id)
		if itemCfg then
			self.itemBg[k].Label_num:setText("x"..v.num)
			self.itemBg[k].icon:setTexture(itemCfg.icon)
			self.itemBg[k].icon:setScale(0.8)
		end
		self.itemBg[k].icon:onClick(function()
			Utils:showInfo(v.id, nil, false)
		end)

	end
end

function ShareMainView:onRecvShare()
	self:initUILogic()
end

function ShareMainView:onRecvShareAward(id,award)

	if not award then
		return
	end
	self.Button_share:setVisible(false)
	self.Button_buy:setVisible(false)
	Utils:showReward(award)

end

function ShareMainView:registerEvents()

    EventMgr:addEventListener(self, EV_SHOW_AWARD, handler(self.onRecvShareAward, self))
    EventMgr:addEventListener(self, EV_SHOW_SHARE, handler(self.onRecvShare, self))
    
	self.Button_back:onClick(function()
    	AlertManager:closeLayer(self)
	end)

    self.Button_buy:onClick(function()
    	local info = ShareDataMgr:getShareInfoById(2)
    	if not info then 
    		return
    	end
    	TFDirector:send(c2s.SHARE_SUBMIT_SHARE, {info.id})
	end)

	self.Button_share:onClick(function()
		local info = ShareDataMgr:getShareInfoById(2)
		if not info then 
    		return
    	end
		local useSdk = self:useShareSdk()
		if useSdk then
			local ret = self:shareResult()
		    if ret then
		    	TFDirector:send(c2s.SHARE_SHARE, {info.id})
		    	self.Button_share:setVisible(false)
		    	self.Button_buy:setVisible(true)
		    end
		else
			TFDirector:send(c2s.SHARE_SHARE, {info.id})
	    	self.Button_share:setVisible(false)
	    	self.Button_buy:setVisible(true)
		end
	end)
end

function ShareMainView:shareResult()

	local ret = false
	if HeitaoSdk then
       ret = HeitaoSdk.takeScreenshot();
    else
       ret = takeScreenshot()
       ret = true
    end
    return ret
end

function ShareMainView:useShareSdk()

	do
		--默认全部打开
		return true;
	end

	local platformId = 0;
	if HeitaoSdk then
		platformId = HeitaoSdk.getplatformId() % 10000;
	end

	--只有官网和IOS才弹
	if platformId == 101 or platformId == 173 then
		return true
	end

	return false
end

return ShareMainView
