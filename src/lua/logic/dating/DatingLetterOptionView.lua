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
* -- 约会信件选项
]]
local DatingLetterOptionView = class("DatingLetterOptionView",BaseLayer)

function DatingLetterOptionView:ctor(data, isFirst, callBack)
	self.super.ctor(self,data)
	self.itemInfo = data
	self.isFirst = isFirst
	self.callback_ = callBack
	self:init("lua.uiconfig.dating.letterOptionView")
end

function DatingLetterOptionView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.ui:setTouchEnabled(true)
	self.Panel_close = TFDirector:getChildByPath(ui,"Panel_close")
	self.Panel_open = TFDirector:getChildByPath(ui,"Panel_open"):hide()
	self.Spine_effect = TFDirector:getChildByPath(self.Panel_close,"Spine_effect")

	local label_dec = TFDirector:getChildByPath(ui,"label_dec")
	local ScrollView_text = TFDirector:getChildByPath(ui,"ScrollView_text")
	label_dec:setTextById(self.itemInfo.letterLines)
	label_dec:retain()
	label_dec:removeFromParent()
	self.textList = UIListView:create(ScrollView_text);
	self.textList:pushBackCustomItem(label_dec)
	label_dec:release()
	
	local label_dec1 = TFDirector:getChildByPath(ui,"label_dec1")
	local Image_line = TFDirector:getChildByPath(ui,"Image_line")
	local optionBtn = {}
	optionBtn[1] = TFDirector:getChildByPath(ui,"Button_option1")
	optionBtn[2] = TFDirector:getChildByPath(ui,"Button_option2")
	local ScrollView_reward = TFDirector:getChildByPath(ui,"ScrollView_reward")
	self.rewardList = UIListView:create(ScrollView_reward);

	ScrollView_reward:setVisible(self.isFirst)
	Image_line:setVisible(self.isFirst)
	label_dec1:setVisible(self.isFirst)

	label_dec1:setTextById(self.itemInfo.awardText)

	for k,v in pairs(self.itemInfo.awardShow) do
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		PrefabDataMgr:setInfo(Panel_goodsItem, v)
		Panel_goodsItem:setScale(0.55)
		self.rewardList:pushBackCustomItem(Panel_goodsItem)
	end
	local index = 1
 	for j,l in pairs(self.itemInfo.jumpCon) do
 		local label = TFDirector:getChildByPath(optionBtn[index],"Label_get")
 		label:setText(l.text)
        if l.cdt == 0 or GoodsDataMgr:getItemCount(l.cdt) > 0 then
        	optionBtn[index]:setGrayEnabled(true)
            optionBtn[index]:setTouchEnabled(false)
        else
            optionBtn[index]:setGrayEnabled(false)
            optionBtn[index]:setTouchEnabled(true)
        end

		optionBtn[index]:onClick(function ( ... )
			local callBack = self.callback_
			self:removeFromParent(true)
			callBack(j)
		end)
        index = index + 1
    end

    self.Panel_close:setTouchEnabled(true)
	self.Panel_close:onClick(function ( ... )
		self.Spine_effect:play("effect_ZNQ_xinfeng3",0)
		self.Panel_close:setTouchEnabled(false)
		self.Spine_effect:addMEListener(TFARMATURE_COMPLETE,function()
			self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
			self.Panel_open:show()
        end)
	end)
	self.Spine_effect:setupPoseWhenPlay(false)
	self.Spine_effect:play("effect_ZNQ_xinfeng1",0)
	self.Spine_effect:addMEListener(TFARMATURE_COMPLETE,function()
			self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
			self.Spine_effect:play("effect_ZNQ_xinfeng2",1)
        end)
end

return DatingLetterOptionView