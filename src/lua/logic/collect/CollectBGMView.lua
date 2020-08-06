local CollectBGMView = class("CollectBGMView",BaseLayer)

function CollectBGMView:initData()
	self.pageUICfg = {}
	local tmPageUIcfg = CollectDataMgr:getPageUICfg(EC_CollectPage.SOUND)
	for k,v in pairs(tmPageUIcfg) do
		table.insert(self.pageUICfg,v)
	end
	table.sort( self.pageUICfg, function(a,b)
		return a.order < b.order
	end )
end

function CollectBGMView:ctor()
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.collect.collectBGMView")
end

function CollectBGMView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	local base_panel = self.root_panel:getChildByName("Panel_base")
	self.collectBaseView = require("lua.logic.collect.CollectBaseView"):new()
    base_panel:addChild(self.collectBaseView)
    self.childArr:push(self.collectBaseView)
    self.cgShowPanel = self.root_panel:getChildByName("Panel_cg")
    local bgm_list_cell = self.root_panel:getChildByName("Panel_bgm_cell")
    local scroll_list = self.root_panel:getChildByName("ScrollView_list")
    self.list_view = UIListView:create(scroll_list)
    self.list_view:setItemModel(bgm_list_cell)
    self.list_view:setScrollBar(self.collectBaseView.scrollBar)
    self:initBaseUI()
end

function CollectBGMView:initBaseUI()
	local callbackCfg = {tabSelCallback = handler(self.onSelTab,self),filtSelCallback = handler(self.onSelFiltTab,self)}
	self.collectBaseView:registCallback(callbackCfg)
	self.collectBaseView:makeLeftBar(self.pageUICfg)
end

function CollectBGMView:onSelTab(tabInfo)
	self.cgShowPanel:removeAllChildren()
	local pos = self.cgShowPanel:getPosition()
	local winsize = me.Director:getWinSize()
	local defaultSize = me.size(1136,640)
	local origin = me.p((defaultSize.width - winsize.width)/2,(defaultSize.height - winsize.height)/2)
	local cgPlayLayer = require("lua.logic.common.CgView"):new(tabInfo.photo)
    cgPlayLayer:setPosition(ccp(-pos.x + origin.x, -pos.y + origin.y))
    self.cgShowPanel:addChild(cgPlayLayer)
end

function CollectBGMView:onSelFiltTab(filtInfo,filtKey)
	self:updateInfoPage(filtInfo)
end

function CollectBGMView:updatePage()
	self.collectBaseView:updateTrophy(EC_CollectPage.SOUND)
	CollectDataMgr:clearRedShow(EC_CollectPage.SOUND)
end

function CollectBGMView:updateInfoPage(filtInfo)
	self.list_view:removeAllItems()
	local bgmTypeLogo = {[1] = "ui/collect/TJ_BGM_anniu_1.png",[2] = "ui/collect/TJ_BGM_anniu_2.png"}
	local collectCount = table.count(filtInfo)
	if collectCount >= 2 then
		table.sort( filtInfo, function(a,b)
			return a.order < b.order
		end )
	end
	if collectCount <= 0 then
		return
	end
	for i=1,collectCount do
		local itemCell = self.list_view:pushBackDefaultItem()
		itemCell:setVisible(true)
		local bgmInfo = filtInfo[i]
		itemCell:setVisible(true)
		itemCell:getChildByName("Image_select"):setVisible(false)
		itemCell:getChildByName("Spine_playBgm"):setVisible(false)
		local isunclock = CollectDataMgr:isCollectItemExist(bgmInfo.collecttype,bgmInfo.id)
		itemCell:getChildByName("Image_lock"):setVisible(not isunclock)
		local bgmCfg = CollectDataMgr:getBGMCfg(bgmInfo.id)
		itemCell.bgmCfg = bgmCfg
		itemCell.unclock = isunclock
		itemCell:getChildByName("Image_logo"):setTexture(bgmTypeLogo[bgmCfg.type1])
		itemCell:getChildByName("Image_logo"):setVisible(isunclock)
		itemCell:getChildByName("Image_lock"):getChildByName("Label_unlock_info_1"):setTextById(bgmCfg.unlockDescribe1)
		itemCell:getChildByName("Image_lock"):getChildByName("Label_unlock_info_1"):setVisible(bgmCfg.unlockDescribe1 ~= 0)

		itemCell:getChildByName("Image_lock"):getChildByName("Label_unlock_info_2"):setTextById(bgmCfg.unlockDescribe2)
		itemCell:getChildByName("Image_lock"):getChildByName("Label_unlock_info_2"):setVisible(bgmCfg.unlockDescribe2 ~= 0)
		

		itemCell:getChildByName("Label_name"):setVisible(bgmCfg.type1 == 1)
		itemCell:getChildByName("TextArea_desc"):setVisible(bgmCfg.type1 == 2)
		itemCell:getChildByName("Label_func"):setTextById(bgmCfg.describe)
		itemCell:getChildByName("Label_func"):setVisible(isunclock)
		itemCell:getChildByName("Image_mainBgm"):setVisible(bgmCfg.sortForMainBgm > 0)

		if bgmCfg.type1 == 1 then
			itemCell:getChildByName("Label_name"):setTextById(bgmCfg.name)
		else
			itemCell:getChildByName("TextArea_desc"):setTextById(bgmCfg.soundName)
			if isunclock == false then
				itemCell:getChildByName("TextArea_desc"):setString("???")
			end
		end
		itemCell.isSel = false
		itemCell:onClick(function()
			if CollectDataMgr:getItemClickEnable() == false then
				return
			end
			if itemCell.unclock == false then
				return
			end
			if itemCell.isSel == true then
				if itemCell.bgmCfg.type1 == 1 then
					TFAudio.stopMusic()
					SafeAudioExchangePlay().stopAllBgm()
					SafeAudioExchangePlay().playBGM(self, true)
				else
					if itemCell.playId then
						TFAudio.stopEffect(itemCell.playId)
						itemCell.playId = nil
					end
				end
				itemCell:getChildByName("Image_select"):setVisible(false)
				itemCell:getChildByName("Spine_playBgm"):setVisible(false)
				itemCell.isSel = false
				return
			end
			local allItems = self.list_view:getItems()
			for i,v in ipairs(allItems) do
				v:getChildByName("Image_select"):setVisible(false)
				v:getChildByName("Spine_playBgm"):setVisible(false)
				v.isSel = false
				if v.playId then
					TFAudio.stopEffect(v.playId)
					v.playId = nil
				end 
			end
			if itemCell.bgmCfg.type1 == 1 then
				TFAudio.stopMusic()
				SafeAudioExchangePlay().stopAllBgm()
				TFAudio.playBmg(itemCell.bgmCfg.bgm,true)
			else
				itemCell.playId = TFAudio.playVoice(itemCell.bgmCfg.bgm,false)
			end
			itemCell:getChildByName("Image_select"):setVisible(true)
			itemCell:getChildByName("Spine_playBgm"):play("animation",1)
			itemCell:getChildByName("Spine_playBgm"):setVisible(true)
			itemCell.isSel = true

		end)
	end
	
end

function CollectBGMView:onShow()
	self.super.onShow(self)
	self:updatePage()
end

function CollectBGMView:registerEvents()
	
end

return CollectBGMView