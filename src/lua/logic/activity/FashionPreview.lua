--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local FashionPreview = class("FashionPreview", BaseLayer)

function FashionPreview:ctor(...)
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData(...)
	self:init("lua.uiconfig.activity.fashionPreView")
end
function FashionPreview:initData(fashionId)
	self.skinData = TabDataMgr:getData("HeroSkin", fashionId)
	--dump(self.skinData)
	self.modelCfg = TabDataMgr:getData("HeroModle", self.skinData.paint)
	--dump(self.modelCfg)
end
function FashionPreview:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root		= TFDirector:getChildByPath(ui,"Panel_root")

	self.Image_fashion		= TFDirector:getChildByPath(ui,"Image_fashion")

	self.fashionName	= TFDirector:getChildByPath(ui,"Label_title_en")
	self.fashionName:setText(self.skinData.des)
	
	local modelAnimation = Utils:createHeroModelByModelId(self.skinData.paint, 0.35)--SkeletonAnimation:create(self.modelCfg.paint)
	self.Image_fashion:addChild(modelAnimation)
	modelAnimation:play("animation",true)
	--modelAnimation:setScale(self.modelCfg.TeampaintSize)

	self.Button_close	= TFDirector:getChildByPath(ui,"Button_close")
	self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)
end



return FashionPreview
--endregion
