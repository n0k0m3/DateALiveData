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
* --- 图鉴激活提示
]]

local NewPokedexFamilyTipLayer = class("NewPokedexFamilyTipLayer",BaseLayer)

function NewPokedexFamilyTipLayer:ctor( collectInfo )
	self.super.ctor(self,collectInfo)
	self:initData(collectInfo)
	self:init("lua.uiconfig.common.newPokedexFamily")
end

function NewPokedexFamilyTipLayer:initData( collectInfo )
	self.collectInfo = collectInfo
end

function NewPokedexFamilyTipLayer:initUI( ui )
	self.super.initUI(self,ui)

	self.rootPanel = TFDirector:getChildByPath(ui,"panel_root")
	self.label1 = TFDirector:getChildByPath(self.rootPanel,"label_1")
	self.label2 = TFDirector:getChildByPath(self.rootPanel,"label_2")
	self.label3 = TFDirector:getChildByPath(self.rootPanel,"label_3")
	self.label4 = TFDirector:getChildByPath(self.rootPanel,"label_4")
	self.loadingBar = TFDirector:getChildByPath(self.rootPanel,"loadingBar_1")

	self:update()

	self.rootPanel:setOpacity(0)

	local seq = Sequence:create({CCFadeIn:create(0.6), DelayTime:create(2), CCFadeOut:create(0.6)})
	self.rootPanel:runAction(seq)
end

function NewPokedexFamilyTipLayer:update( )
	-- body
	if self.collectInfo == nil then return end
	local id = self.collectInfo.id

	--编号
	self.label1:setTextById(122000002, CollectDataMgr:getNewPokedexSortr(id))
	
	--名字
	local nameTextId = CollectDataMgr:getNewPokedexNameTextId(id)
	self.label3:setTextById(122000001, TextDataMgr:getText(nameTextId))

	--进度
	self.label4:setTextById("r99990000",self.collectInfo.unLockNum,self.collectInfo.allNum )
	local percent = (self.collectInfo.unLockNum/self.collectInfo.allNum)*100
    self.loadingBar:setPercent(percent)

    --剩余显示数量
	local index = self.collectInfo.index
	local collectsCount = self.collectInfo.collectsCount	
	self.label2:setText(collectsCount - index)


end

function NewPokedexFamilyTipLayer:dispose(  )
	self.super.dispose(self)
end

return NewPokedexFamilyTipLayer