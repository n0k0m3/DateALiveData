
local RepeatActivityBuyTipsView = class("RepeatActivityBuyTipsView", BaseLayer)

function RepeatActivityBuyTipsView:initData(goodsId , num , callBack)
    self.goodsCid_, self.goodsCount_ = goodsId, num
    self.goodsCfg_ = GoodsDataMgr:getItemCfg(self.goodsCid_)
    self.callBack = callBack
end

function RepeatActivityBuyTipsView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.store.repeatBuyTipsView")
end

function RepeatActivityBuyTipsView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(Image_content, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Label_tips")
    self.Image_icon = TFDirector:getChildByPath(Image_content, "Image_icon")
    self.Label_count = TFDirector:getChildByPath(Image_content, "Label_count")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")

    self:refreshView()
end

function RepeatActivityBuyTipsView:refreshView()
    self.Label_ok:setTextById(800010)
    self.Label_tips:setTextById(302208)
    self.Label_name:setTextById(302207)

    -- 购买大富翁道具卡的提示
    if (self.goodsCfg_.superType == EC_ResourceType.DFW_NEW_CARD) then
        self.Label_tips:setTextById(190000040)
    end

    local convertCid, converNum = next(self.goodsCfg_.convertMax)
    convertCfg = GoodsDataMgr:getItemCfg(convertCid)
    self.Image_icon:setTexture(convertCfg.icon)
    self.Label_count:setTextById(800007, converNum * self.goodsCount_)

    self.Image_icon:onClick(function()
            Utils:showInfo(convertCid)
    end)
end

function RepeatActivityBuyTipsView:registerEvents()
    self.Button_ok:onClick(function()
            if self.callBack then
                self.callBack()
            end
            AlertManager:closeLayer(self)
    end)

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end


return RepeatActivityBuyTipsView

