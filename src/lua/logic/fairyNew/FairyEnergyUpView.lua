local FairyEnergyUpView = class("FairyEnergyUpView", BaseLayer)
require "lua.public.ScrollMenu"

function FairyEnergyUpView:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self.showidx = 1
    self.selectCell = nil
    self.showSkinID = nil
    self.showListIds = HeroDataMgr:getHeroEnergyUpIds()

    self.showCount = #self.showListIds
    if data and data.showid then
    	self.showid = data.showid
    	self.showidx = table.indexOf(self.showListIds, self.showid)
    else
    	self.showid = self.showListIds[1]
    	self.showidx = 1
    end
    self:init("lua.uiconfig.fairyNew.fairyEnergyUpView")

    self.curPanel = nil
    self.lastPanel = nil
end

function FairyEnergyUpView:getClosingStateParams()
    local param1 = {}
    if self.paramData_ then
        param1.friend = self.paramData_.friend
    end
    param1.showid = self.showid
    return {param1}
end

function FairyEnergyUpView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	self.Panel_hero 	    = TFDirector:getChildByPath(ui, "Panel_hero")

	self.Image_hero			= TFDirector:getChildByPath(ui, "Image_hero")
	self.Panel_hero_touch   = TFDirector:getChildByPath(ui, "Panel_hero_touch")
	self.Label_power		= TFDirector:getChildByPath(ui, "Label_hero_power")
	self.Label_hero_name	= TFDirector:getChildByPath(ui, "Label_hero_name")
    self.Label_en_hero_name    = TFDirector:getChildByPath(ui, "Label_enName2")
    self.Label_en_hero_name2    = TFDirector:getChildByPath(ui, "Label_enName")
    self.Image_energy_rank = TFDirector:getChildByPath(ui, "Image_energy_rank")
    self.Panel_left = TFDirector:getChildByPath(ui, "Panel_left")


	self.Image_sss_level	= TFDirector:getChildByPath(ui, "Image_sss_level")
    self.Button_camera      = TFDirector:getChildByPath(ui, "Button_camera")
    self.Button_eval      = TFDirector:getChildByPath(ui, "Button_eval")
    self.Button_add      = TFDirector:getChildByPath(ui, "Button_add")
    self.Button_up      = TFDirector:getChildByPath(ui, "Button_up")
    self.Button_break = TFDirector:getChildByPath(ui, "Button_break")
    self.Image_red = TFDirector:getChildByPath(self.Button_add, "Image_red")
    self.Label_add_title = TFDirector:getChildByPath(self.Button_add, "Label_add_title")
    self.Label_up_title = TFDirector:getChildByPath(self.Button_up, "Label_up_title")
    self.Label_break_title = TFDirector:getChildByPath(self.Button_break, "Label_break_title")
    self.Label_add_title:setTextById(1329106)
    self.Label_up_title:setTextById(1329107)
    self.Label_break_title:setTextById(1329108)

    self.Panel_hero_list    = TFDirector:getChildByPath(ui, "Panel_hero_list")
	self.Panel_hero_item_s    = TFDirector:getChildByPath(ui, "Panel_hero_item_s")
    self.Panel_hero_item_uns    = TFDirector:getChildByPath(ui, "Panel_hero_item_uns")
    self.Label_suit_name    = TFDirector:getChildByPath(ui, "Label_suit_name")

    self.Panel_name_info = TFDirector:getChildByPath(ui, "Panel_name_info")
    self.Panel_right = TFDirector:getChildByPath(ui, "Panel_right")
    self.info_pos = self.Panel_name_info:getPosition()
    self.right_pos = self.Panel_right:getPosition()
    self.hero_pos = self.Image_hero:getPosition()

    self.Label_cur_level = TFDirector:getChildByPath(self.Panel_right, "Label_cur_level")
    self.Label_max_level = TFDirector:getChildByPath(self.Panel_right, "Label_max_level")
    self.Image_level_icon = TFDirector:getChildByPath(self.Panel_right, "Image_level_icon")
    self.Label_energy_exp = TFDirector:getChildByPath(self.Panel_right, "Label_energy_exp")
    self.LoadingBar_energy = TFDirector:getChildByPath(self.Panel_right, "LoadingBar_energy")
    self.Label_energy_num = TFDirector:getChildByPath(self.Panel_right, "Label_energy_num")
    self.Label_angel_num = TFDirector:getChildByPath(self.Panel_right, "Label_angel_num")

    self.Panel_attrs = TFDirector:getChildByPath(self.Panel_right, "Panel_attrs")
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_right, "Panel_touch")

    self.attr_infos = {}
    for i=1,3 do
        local item = TFDirector:getChildByPath(self.Panel_right, "Panel_attr"..i)
        local foo = {}
        foo.root = item
        foo.Image_attr_icon = TFDirector:getChildByPath(item, "Image_attr_icon")
        foo.Label_name = TFDirector:getChildByPath(item, "Label_name")
        foo.Label_num = TFDirector:getChildByPath(item, "Label_num")
        foo.Image_select = TFDirector:getChildByPath(item, "Image_select")
        self.attr_infos[i] = foo
    end

    self:initHeroListView()
end

function FairyEnergyUpView:onBreakOver(data)
    self:heroInfoChange()
    Utils:openView("fairyNew.FairyEnergyBreakUpView",data)
end

function FairyEnergyUpView:onLevelUpOver(data)
    self:heroInfoChange()
    local curlevel = HeroDataMgr:getHeroEnergyLevel(self.showid)
    if self.lastLevel and curlevel > self.lastLevel then
        Utils:openView("fairyNew.FairyEnergyLevelUpView",data, self.lastLevel)
    end
end

function FairyEnergyUpView:registerEvents()
    EventMgr:addEventListener(self,EV_HERO_LEVEL_UP,handler(self.heroInfoChange, self))
    EventMgr:addEventListener(self,EV_HERO_PUT_SPRIT_POINTS,handler(self.heroInfoChange, self))
    EventMgr:addEventListener(self,EV_HERO_RESET_SPRIT_POINTS,handler(self.heroInfoChange, self))
    EventMgr:addEventListener(self,EV_HERO_USE_ITEM_UP_SPRIT,handler(self.onLevelUpOver, self))
    EventMgr:addEventListener(self,EV_HERO_REFRESH_SPRIT,handler(self.heroInfoChange, self))
    EventMgr:addEventListener(self,EV_HERO_UPGRADE_SPRIT_POINTS,handler(self.onBreakOver, self))
    
    self:setBackBtnCallback(function()
            AlertManager:close()
    end)

	self.Panel_hero_touch:onClick(function()
        
	end)

    self.Button_add:onClick(function()
        Utils:openView("fairyNew.FairyEnergyUseView",{showid = self.showid})
    end)

    self.Button_up:onClick(function()
        if HeroDataMgr:checkHeroMaxEnergyLevel(self.showid) then
            Utils:showTips(1329144)
            return
        end
        self.lastLevel = HeroDataMgr:getHeroEnergyLevel(self.showid)
        Utils:openView("fairyNew.FairyEnergyLevelUp",self.showid)
    end)

    self.Button_break:onClick(function()
        if HeroDataMgr:checkHeroMaxEnergyBreak(self.showid) then
            Utils:showTips(1329144)
            return
        end
        Utils:openView("fairyNew.FairyEnergyBreakView",{heroId = self.showid})
    end)

    self.Button_camera:onClick(function()
        self:onTouchBtnCamera()
    end)

    self.Button_eval:onClick(function()
        local layer = require("lua.logic.fairyNew.EvaluationView"):new({heroOrEquip = 2, heroId = self.showid, callfunc = function()
            
        end})
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)

    self.Panel_touch:setTouchEnabled(true)
    self.Panel_touch:onClick(function()
        Utils:openView("fairyNew.FairyEnergyUseView",{showid = self.showid})
    end)
end

function FairyEnergyUpView:initHeroListView()
    local params = {
        ["upItem"]                  = self.Panel_hero_item_uns,
        ["downItem"]                = self.Panel_hero_item_uns,
        ["selItem"]                 = self.Panel_hero_item_s,
        ["offsetX"]                 = 0,
        ["updateCellInfo"]          = handler(self.updateCellInfo,self),
        ["selCallback"]             = handler(self.selCallback,self),
        ["cellCount"]               = self.showCount,
        ["isLoop"]                  = true,
        ["size"]                    = self.Panel_hero_list:getContentSize(),
        ["isFromFairy"]             = true
    }
     local scrollMenu = ScrollMenu:create(params);
     scrollMenu:setPosition(self.Panel_hero_list:getPosition())
     self.Panel_hero_list:getParent():removeChild(self.Panel_hero_list:getParent():getChildByName("heroHeads"))
     self.Panel_hero_list:getParent():addChild(scrollMenu,10)
     scrollMenu:setName("heroHeads")
     self.scrollMenu = scrollMenu
     local jumpTo = HeroDataMgr:getSelectedHeroIdx(self.showid)
     self.scrollMenu:jumpTo(self.showidx)
end

function FairyEnergyUpView:updateCellInfo(cell,cellIdx)
    local heroid = self.showListIds[cellIdx]
    if not heroid then return end

    local ishave = HeroDataMgr:getIsHave(heroid)

    local icon = TFDirector:getChildByPath(cell,"Image_icon")
    icon:setTexture(HeroDataMgr:getIconPathById(heroid))
    --icon:setContentSize(CCSizeMake( 90,90))

    local Label_energy = TFDirector:getChildByPath(cell,"Label_energy")
    Label_energy:setString(HeroDataMgr:getHeroEnergyLevel(heroid))

    local Image_duty = TFDirector:getChildByPath(cell,"Image_duty")
    local Image_duty_1 = TFDirector:getChildByPath(cell,"Image_duty_1")
  
    local job = HeroDataMgr:getHeroJob(heroid)
    if job then
        if job == 1 then
            Image_duty:setVisible(ishave)
            Image_duty_1:setVisible(false)
        elseif job < 4 then
            Image_duty:setVisible(false)
            Image_duty_1:setVisible(ishave)
        else
            Image_duty:setVisible(false)
            Image_duty_1:setVisible(false)
        end
    end
end

function FairyEnergyUpView:selCallback(cell,cellIdx)
    self.Panel_name_info:stopAllActions()
    self.Panel_right:stopAllActions()
    self.Image_hero:stopAllActions()
    self.Panel_name_info:setPosition(self.info_pos)
    self.Panel_right:setPosition(self.right_pos)
    self.Image_hero:setPosition(self.hero_pos)
    if self.selectCellItem then
       
    end
    self.selectCellItem = cell
    self.selectCellItem:runAction(CCMoveBy:create(0.2, ccp(15, 0)))
    ViewAnimationHelper.doMoveFadeInAction(self.Image_hero, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_name_info, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})


    local heroid = self.showListIds[cellIdx]
    local ishave = HeroDataMgr:getIsHave(heroid)
    self.showid = heroid
    self.showidx = cellIdx
    self:updateHeroBaseInfo()
end

function FairyEnergyUpView:updateHeroBaseInfo()
	local skins = HeroDataMgr:getSkins(self.showid)
	self.anim_hero = Utils:createHeroModel(self.showid, self.Image_hero)
    self.anim_hero:setScale(0.75)
	self.Label_power:setString(math.floor(HeroDataMgr:getHeroPower(self.showid)))
	self.Label_hero_name:setString(HeroDataMgr:getName(self.showid))
    self.Label_en_hero_name:setString(HeroDataMgr:getEnName2(self.showid))
    self.Label_en_hero_name2:setString(HeroDataMgr:getEnName(self.showid))

    local ishave = HeroDataMgr:getIsHave(self.showid)
    if not ishave then
        self.Image_sss_level:setTexture(HeroDataMgr:getQualityPicNotHave(self.showid))
    else
        self.Image_sss_level:setTexture(HeroDataMgr:getQualityPic(self.showid))
    end
    self.Label_suit_name:setText(HeroDataMgr:getTitleStr(self.showid))
    self.Image_energy_rank:setVisible(false)
    self.Image_energy_rank:setPositionX(self.Label_hero_name:getPositionX() + self.Label_hero_name:getContentSize().width + 25)
    self:updateEnergyInfo()
end

function FairyEnergyUpView:updateEnergyInfo()
    local maxLevel = HeroDataMgr:getEnergyUpMaxLevel()
    local curMaxLevel = HeroDataMgr:getHeroEnergyMaxLevel(self.showid)
    local curLevel = HeroDataMgr:getHeroEnergyLevel(self.showid)
    if curLevel >= maxLevel then
        self.Label_cur_level:setString("MAX")
        self.Label_max_level:setString("")
    else
        self.Label_max_level:setString("/"..curMaxLevel)
        self.Label_cur_level:setString(curLevel)
    end
    self.Label_cur_level:setPositionX(self.Image_level_icon:getPositionX() + 2)
    self.Label_max_level:setPositionX(self.Label_cur_level:getPositionX() + self.Label_cur_level:getContentSize().width + 2)

    self.Label_energy_exp:setString(HeroDataMgr:getHeroEnergyExp(self.showid).."/"..HeroDataMgr:getHeroEnergyLevelUpExp(self.showid))
    self.LoadingBar_energy:setPercent(HeroDataMgr:getHeroEnergyExpPercent(self.showid))

    local curSKillPoint = AngelDataMgr:getAngleTabCurUseSkillPoint(self.showid)
    self.Label_angel_num:setString(curSKillPoint)

    local enableBreak = HeroDataMgr:checkEnergyEnableBreak(self.showid)
    self.Button_up:setVisible(not enableBreak)
    local canlevelup = HeroDataMgr:checkEnergyUpEnable(self.showid)
    if canlevelup then
        self.Button_up:setGrayEnabled(false)
        self.Button_up:setTouchEnabled(true)
    else
        self.Button_up:setGrayEnabled(true)
        self.Button_up:setTouchEnabled(false)
    end
    self.Image_red:setVisible(HeroDataMgr:checkEnergyRedpoint(self.showid))

    self.Button_break:setVisible(enableBreak)

    local data = HeroDataMgr:getHeroEnergyUseData(self.showid)
    local valueArray = {}
    local usedPoint = 0
    for i, foo in ipairs(self.attr_infos) do
        local point = data[i] or 0
        valueArray[i] = point
        usedPoint = usedPoint + point
        foo.Label_num:setString(point)
        foo.Label_name:setTextById(HeroDataMgr:getEnergyAttrNameId(i))
        foo.Image_attr_icon:setTexture(HeroDataMgr:getEnergyAttrIcon(i))
    end
    self:drawAttrPolygon(valueArray)

    local energyPoints = HeroDataMgr:getHeroEnergyPoints(self.showid)
    self.Label_energy_num:setString(energyPoints - usedPoint)
end

function FairyEnergyUpView:drawAttrPolygon(valueArray)
    self.Panel_attrs:removeAllChildren()
    local PI = 3.1415926
    local solidMax = 95
    local solidMax1 = 112
    local percents = {0, 0, 0}
    local baseMax = 900
    local baseValue = 100
    for i,v in ipairs(valueArray) do
        percents[i] = math.min(1, (v + baseValue) / baseMax)
    end
    local pointsSolid = {
    ccp(-solidMax * math.cos(1 / 6 * PI) * percents[2], solidMax * math.sin(1 / 6 * PI) * percents[2]),
    ccp(solidMax * math.cos(1 / 6 * PI) * percents[3], solidMax * math.sin(1 / 6 * PI) * percents[3]),
    ccp(0, -solidMax1 * math.cos(1 / 6 * PI) * percents[1]),
    }

    local attrNode = TFDrawNode:create()
    self.Panel_attrs:addChild(attrNode, 100)
    attrNode:drawSolidPoly(pointsSolid, ccc4(103 / 255, 222 / 255, 221 / 255, 1))
    attrNode:setPosition(ccp(0, 0))
end

function FairyEnergyUpView:onTouchBtnCamera()

    local OldValue = USE_NATIVE_VLC 
    if me.platform == 'android' then 
        USE_NATIVE_VLC = true
    end
    local heroCfg_ = GoodsDataMgr:getItemCfg(self.showid)
    local videoView = Utils:openView("common.VideoView", unpack(heroCfg_.bornVideo))
    videoView:setIshowShare(true)
    videoView:setEndLoop(true)
    videoView:bindVideoClickCallBack(function(index)    
        if index > 1 then
            videoView:stopVideo()
        end
        return false
    end)
    USE_NATIVE_VLC = OldValue
end

function FairyEnergyUpView:heroInfoChange()
    self:updateHeroBaseInfo()
    self:updateHeroListItems()
end

function FairyEnergyUpView:updateHeroListItems()
    for i = 1, self.scrollMenu:getCellCount() do
        self:updateCellInfo(self.scrollMenu:getCellByIndex(i), i)
    end
end

function FairyEnergyUpView:onSkinChange()
    self:initHeroListView()
end

function FairyEnergyUpView:onHide()
	self.super.onHide(self)
    if not self.notHide then
        self:panelLeftHide(self.scrollMenu)
    end
end

function FairyEnergyUpView:onShow()
    self.super.onShow(self)
    if not self.notHide then
        self:panelLeftShow(self.scrollMenu)
        self:panelLeftShow(self.Panel_hero)
    end
    self.notHide = false
end

function FairyEnergyUpView:panelRightShow(panel)
    panel:stopAllActions()
    panel:setOpacity(0)
    panel:setPositionX(panel:getPositionX() + 20)

    local actions = {
        CCMoveBy:create(0.2,ccp(-20,0)),
        CCFadeIn:create(0.2),
    }

    panel:runAction(Spawn:create(actions))
end

function FairyEnergyUpView:panelRightHide(panel)
    
end

function FairyEnergyUpView:panelLeftShow(panel)
    panel:stopAllActions()
    panel:setOpacity(0)
    panel:setPositionX(-20)

    local actions = {
        CCMoveTo:create(0.2,ccp(0,panel:getPositionY())),
        CCFadeIn:create(0.2),
    }

    panel:runAction(Spawn:create(actions))
end

function FairyEnergyUpView:panelLeftHide(panel)
    panel:stopAllActions()
    panel:setPositionX(panel:getPositionX() + 20)

    local actions = {
        CCMoveTo:create(0.2,ccp(-20,panel:getPositionY())),
        CCFadeOut:create(0.2),
    }

    panel:runAction(Spawn:create(actions))
end

return FairyEnergyUpView
