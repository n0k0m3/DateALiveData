--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local ConfirmBoxViewSmall = class("ConfirmBoxViewSmall", BaseLayer)

function ConfirmBoxViewSmall:ctor(...)
	self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.confirmBoxViewSmall")
end


function ConfirmBoxViewSmall:initData(goodsId, extData)
	self.goodsId = goodsId
	self.data = RechargeDataMgr:getOneRechargeCfg(goodsId)
	self.extData = extData or {}
end


function ConfirmBoxViewSmall:initUI(ui)

	self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local Image_bg = TFDirector:getChildByPath(ui, "Image_bg")
	Image_bg:setTouchEnabled(true)
	Image_bg:setSwallowTouch(true)
    self.Rtext = TFDirector:getChildByPath(Image_bg, "Rtext")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    self.Label_title = TFDirector:getChildByPath(Image_bg, "Label_title")
    self.Button_ok = TFDirector:getChildByPath(Image_bg, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Label_content = TFDirector:getChildByPath(Image_bg, "Label_content")
	self.Label_own = TFDirector:getChildByPath(Image_bg, "Label_own")
	self.ownImg = TFDirector:getChildByPath(Image_bg, "ownImg")

	self:refreshView()
end


function ConfirmBoxViewSmall:setTitle(title)
    self.Label_title:setTitle(title)
end

function ConfirmBoxViewSmall:setContent(content)
    self.Label_content:setText(content)
end

function ConfirmBoxViewSmall:setRContent(contentId,...)
    self.Label_content:hide()
    local richLabel = TFRichText:create(ccs(350, 0))
    richLabel:AnchorPoint(me.p(0.5, 0.5))
	local rstr = TextDataMgr:getTextAttr(contentId)
	local formatStr = rstr and rstr.text or ""
	local text = string.format(formatStr, ...)
	text = string.format([[<font face="fangzheng_zhunyuan22" color="#ffffff">%s</font>]], text)
    richLabel:Text(text)
    richLabel:AddTo(self.Rtext)
end

function ConfirmBoxViewSmall:setCallback(callback)
    self.callback_ = callback
end

function ConfirmBoxViewSmall:refreshView()
    self.Label_title:setTextById(800011)
    self.Label_ok:setTextById(800010)
    self.Label_content:setText("")
	local cfg = GoodsDataMgr:getItemCfg(self.data.exchangeCost[1].id)
	self:setRContent(15010184,self.data.exchangeCost[1].num, cfg.icon, self.data.name)
	self.Label_own:setTextById(15010037, GoodsDataMgr:getItemCount(self.data.exchangeCost[1].id))
	self.ownImg:setTexture(GoodsDataMgr:getItemCfg(self.data.exchangeCost[1].id).icon)
end

function ConfirmBoxViewSmall:registerEvents()
	EventMgr:addEventListener(self, EV_GOODS_EXCHANGE, function()
		AlertManager:closeLayer(self)
	end)

    self.Button_close:onClick(
        function()
            AlertManager:closeLayer(self)
        end,
        EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
          if not self:currencyIsEnough() then
              Utils:showAccess(self.data.exchangeCost[1].id)
              return
          end
          RechargeDataMgr:RECHARGE_REQ_CHARGE_EXCHANGE(self.goodsId, self.extData.discount or "", self.extData.id or 0, self.extData.bless or "", self.extData.buyCount or 1)
    end)
end

function ConfirmBoxViewSmall:currencyIsEnough()
	local enough = true
	for i = 1, #self.data.exchangeCost do
		local cost = self.data.exchangeCost[i]
        local haveNum = GoodsDataMgr:getItemCount(cost["id"])
        if haveNum < cost["num"] * 1 then
			enough = false
			break;
		end     
    end
	return enough
end





return ConfirmBoxViewSmall

--endregion
