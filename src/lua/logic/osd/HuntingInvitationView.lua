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
* -- 狩猎邀请
]]
local ResLoader      = require("lua.logic.battle.ResLoader")
local HuntingInvitationView = class("HuntingInvitationView",BaseLayer)

function HuntingInvitationView:ctor( data )
	self.super.ctor(self,data)
	self:init("lua.uiconfig.osd.HuntingInvitationView")
end

function HuntingInvitationView:removeUI( )
    if self.flushTimer then
        TFDirector:stopTimer(self.flushTimer)
        TFDirector:removeTimer(self.flushTimer)
        self.flushTimer = nil
    end
end

function HuntingInvitationView:initUI( ui )
	self.super.initUI(self,ui)
	self.panel_item = TFDirector:getChildByPath(ui,"panel_item") 
	local main_scroll = TFDirector:getChildByPath(ui,"main_scroll") 
	self.TurnView_mainScroll = UITurnView:create(main_scroll)
    self.TurnView_mainScroll:setItemModel(self.panel_item)
	self.button_shop = TFDirector:getChildByPath(ui,"button_shop")
    self.label_noCard = TFDirector:getChildByPath(ui,"label_noCard")
    self.button_help = TFDirector:getChildByPath(ui,"button_help")
    self.label_noCard:setTextById(190000123)

    self:flushList()
    self.TurnView_mainScroll:scrollToItem(1)
    self.flushTimer = TFDirector:addTimer(1000,-1,nil,handler(self.flushItems,self))
end

function HuntingInvitationView:onShow(  )
    self.super.onShow(self)
    OSDDataMgr:showLastTeamFightResult()
end

function HuntingInvitationView:registerEvents()
	self.super.registerEvents(self)
	self.button_shop:onClick(function ( ... )
        FunctionDataMgr:jWarStore()
	end)
    
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.flushList, self))

    self.button_help:onClick(function ( ... )
        Utils:openView("osd.HuntingInvitationCountHelpView")
    end)

    local function scrollCallback(target, offsetRate, customOffsetRate)
        local items = target:getItem()
        for i, item in ipairs(items) do
            local rate = offsetRate[i]
            if rate then
                local rrate = 1 - rate
                local customRate = customOffsetRate[i]
                item:setOpacity(255 * rrate)
                if customRate then
                    item:setPositionZ(-customRate * 100)
                end
                item:setZOrder(rrate * 100)
            end
        end
    end
    self.TurnView_mainScroll:registerScrollCallback(scrollCallback)
    self.TurnView_mainScroll:registerSelectCallback(function ( target, selectIndex )
        self.selectDIdx = selectIndex
    end)
end

function HuntingInvitationView:flushList( )
    self.showCardList = GoodsDataMgr:getItemsBySuperTyper(EC_ResourceType.HUNTINGINVITATIONCARD)
    
    table.sort( self.showCardList, function ( obj1, obj2 )
        
        local itemCfg1 = GoodsDataMgr:getItemCfg(obj1.cid)

        local dungenCfg1 = TabDataMgr:getData("HighTeamDungeon",itemCfg1.useProfit.dungenID)
        
        local itemCfg2 = GoodsDataMgr:getItemCfg(obj2.cid)

        local dungenCfg2= TabDataMgr:getData("HighTeamDungeon",itemCfg2.useProfit.dungenID)

        if dungenCfg1.challangeLevel == dungenCfg2.challangeLevel then
            local outTime1 = obj1.outTime or 0
            local outTime2 = obj2.outTime or 0
            if outTime1 == outTime2 then
                return obj1.id > obj2.id
            else
                return outTime1 < outTime2
            end
        else
            return dungenCfg1.challangeLevel > dungenCfg2.challangeLevel
        end
    end )

    self.TurnView_mainScroll:removeAllItems()
    self.cardItemsList = {}
    for i, v in ipairs(self.showCardList) do
        self:addCardItem(i)


        self:updateCardItem(i)
    end

    self.label_noCard:setVisible(#self.showCardList == 0)
end


function HuntingInvitationView:flushItems()
   for i = 1, #self.cardItemsList do
        self:updateCardItem(i)
   end
end

function HuntingInvitationView:addCardItem( idx )
	local item = self.TurnView_mainScroll:pushBackItem()
    item.id = self.showCardList[idx].cid
    item.instanceId = self.showCardList[idx].id
    item.idx = idx
    item.label_1 = TFDirector:getChildByPath(item, "label_1")
    item.label_time = TFDirector:getChildByPath(item, "label_time")
    item.image_quality = TFDirector:getChildByPath(item, "image_quality")
    item.icon = TFDirector:getChildByPath(item, "icon")
    item.Label_name = TFDirector:getChildByPath(item, "label_name")
    item.label_level = TFDirector:getChildByPath(item, "label_level")
    item.item_bg = TFDirector:getChildByPath(item, "item_bg")
    item.item_bg = TFDirector:getChildByPath(item, "item_bg")
    item.button_see  = TFDirector:getChildByPath(item, "Button_see")
    item.imageAffixBg  = TFDirector:getChildByPath(item, "image_affix")
    item.imageAffixBg:hide()
    item.imageAffixs = {}
    for i=1,4 do
        item.imageAffixs[i] = TFDirector:getChildByPath(item.imageAffixBg, "Image_affix"..tostring(i))
        item.imageAffixs[i]:hide()
    end
   	
   	
    local foo = {}
    foo.root = item

    self.cardItemsList[idx] = foo
    return foo.root
end

function HuntingInvitationView:updateCardItem(idx)
    local foo = self.cardItemsList[idx]
    local item = foo.root
    local idx = item.idx
    local id = item.id

    local itemCfg = GoodsDataMgr:getItemCfg(id)

    local dungenCfg = TabDataMgr:getData("HighTeamDungeon",itemCfg.useProfit.dungenID)

    item.item_bg:setTouchEnabled(true)
    item.item_bg:onClick(function()
        self.TurnView_mainScroll:scrollToItem(idx)
        self.selectDIdx = idx
        TeamFightDataMgr:requestCreateTeam( dungenCfg.type,dungenCfg.id,item.instanceId)
    end)
    item.icon:setTexture(dungenCfg.bosspic)
    item.Label_name:setTextById(dungenCfg.levelName)
    item.label_1:setTextById(dungenCfg.challangeName)
    item.label_level:setTextById(dungenCfg.LevelDesc)
    local outTime = GoodsDataMgr:getSingleItem(item.instanceId).outTime
    local remainTime = 0

    if outTime then
        remainTime = math.max(0, outTime - ServerDataMgr:getServerTime())
    end

    local day, hour, min, sec = Utils:getTimeDHMZ(remainTime)
    if day == 0 and hour == 0 and min == 0 and sec > 0 then min = 1 end
    item.label_time:setTextById(14110136,day, hour, min)
    item.label_time:setVisible(remainTime > 0 )
    item.image_quality:setTexture(dungenCfg.levelIcon)
    local affixData
    if dungenCfg.affixID and dungenCfg.affixID > 0 then 
        affixData = TabDataMgr:getData("MonsterAffix",dungenCfg.affixID)
        item.button_see:setTouchEnabled(true)
        item.button_see:show()
        item.button_see:onClick(function()
            Utils:openView("osd.AffixPreviewLayer",{dungenCfg.affixID})
        end)
    else
        item.button_see:setTouchEnabled(false)
        item.button_see:hide()
    end 
    local flag = false
    local showCnt = 0
    for index, imageAffix in ipairs(item.imageAffixs) do
        if affixData then
            local affixIcon  = affixData["affixIcon"..tostring(index)] 
            if ResLoader.isValid(affixIcon) then 
                imageAffix:show()
                imageAffix:setScale(0.3)
                imageAffix:setTexture(affixIcon)
                flag = true
                showCnt = showCnt + 1
            else
                imageAffix:hide()
            end
        else
            imageAffix:hide()
        end
    end
    for k, v in ipairs(item.imageAffixs) do
        if v:isVisible() then
            v:setPositionX((k - (showCnt + 1) / 2) * 32)
        end
    end
    item.imageAffixBg:setVisible(flag)
end

return HuntingInvitationView