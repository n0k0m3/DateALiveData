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
* 综合广告宣传界面
* 
]]

local AdView = class("AdView", BaseLayer)

function AdView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.AdView")
end

function AdView:initData(data)
  self.isAutoOpen = data
	self:updateData()
end

function AdView:updateData()
    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.AD_ACTIVITY)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
end

function AdView:initUI(ui)
    self.super.initUI(self, ui)

    self.btn_close = TFDirector:getChildByPath(ui, "btn_close")

    self.adList = {}
    for i = 1, 5 do
    	local adPanel = TFDirector:getChildByPath(ui, "panel_ad" .. i)
    	adPanel:setTouchEnabled(false)
    	local clip_node = TFDirector:getChildByPath(adPanel, "clip_node")
    	clip_node = TFDirector:getChildByPath(ui, "clip_node")
    	clip_node:getStencil():setAnchorPoint(clip_node:getAnchorPoint())
    	clip_node:getStencil():setScale(1)
    	adPanel.img_ad = TFDirector:getChildByPath(adPanel, "img_ad")
    	adPanel.time_bg = TFDirector:getChildByPath(adPanel, "time_bg"):hide()
    	adPanel.time_txt = TFDirector:getChildByPath(adPanel, "time_txt")
    	self.adList[i] = adPanel
    	adPanel:onClick(function(sender)
			self:jumpFunc(sender)
		end)
    end
    self.img_front = TFDirector:getChildByPath(ui, "img_front"):hide()

    local img_line = TFDirector:getChildByPath(ui, "img_line")
    local txt_tip = TFDirector:getChildByPath(img_line, "txt_tip")
    local img_arrow = TFDirector:getChildByPath(img_line, "img_arrow")
    txt_tip:setTextById(213228)
    img_arrow:setPositionX(txt_tip:getContentSize().width + 17)

    self:updateUI()
end

function AdView:updateUI()
	if not self.activityInfo then return end

	local allItems = self.activityInfo.items
    for k, v in ipairs(allItems or {}) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, v)
        if not itemInfo then
          AlertManager:closeLayer(self)
          return
        end
        local adPanel = self.adList[k]
        adPanel.img_ad:setTexture(itemInfo.extendData.icon)
        adPanel:setTouchEnabled(false)
        adPanel.time_bg:hide()
        adPanel:setTouchEnabled(true)

        local beginTime = itemInfo.extendData.beginTime
        local endTime = itemInfo.extendData.endTime
        if beginTime and endTime then
          adPanel.time_bg:show()
          adPanel.time_txt:setText(Utils:getActivityDateString(beginTime, endTime))
          if ServerDataMgr:getServerTime() > endTime then
            adPanel:setTouchEnabled(false)
            adPanel.img_ad:setTexture(itemInfo.extendData.grayIcon)
          end
        end

       	local offset = ccp(0, 0)
       	if itemInfo.extendData.excursion then
       		offset.x = itemInfo.extendData.excursion[1]
       		offset.y = itemInfo.extendData.excursion[2]
       	end
       	adPanel.img_ad:setPosition(offset)
       	
        adPanel.itemInfo = itemInfo
       	adPanel.jumpInterface = itemInfo.extendData.jumpInterface
       	adPanel.jumpParamters = itemInfo.extendData.jumpParamters
    end
end

function AdView:jumpFunc(sender)
  local itemInfo = sender.itemInfo
	if not itemInfo then return end

  local beginTime = itemInfo.extendData.beginTime
  local serverTime = ServerDataMgr:getServerTime()
  if itemInfo.extendData.jumpInterface then
    if not beginTime or serverTime >= beginTime then
      if self.isAutoOpen then
        ActivityDataMgr2:sendReqClickAdActivity(self.activityId, itemInfo.id, 3)
      else
        ActivityDataMgr2:sendReqClickAdActivity(self.activityId, itemInfo.id, 4)
      end
      FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface, unpack(itemInfo.extendData.jumpParamters or {}))
      return
    end
  end

  local endTime = itemInfo.extendData.endTime
  if beginTime and endTime then
    Utils:showTips(Utils:getActivityDateString(beginTime, endTime))
  end
end

function AdView:updateUIByData()
    self:updateData()
    self:updateUI()
end

function AdView:registerEvents()
    self.btn_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateUIByData, self))
end

return AdView
