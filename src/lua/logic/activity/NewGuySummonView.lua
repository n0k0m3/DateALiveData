local NewGuySummonView = class("NewGuySummonView", BaseLayer)
require "lua.public.ScrollMenu"

local enum_awardSate = {
    disable = 0,        --不能领取
    enable = 1,         --可以领取
    geted = 2,          --已领取
}

function NewGuySummonView:ctor(callbck)

    self.super.ctor(self)
    self:initData(callbck)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.newGuySummonView")
end

function NewGuySummonView:initData(callbck)
    self.showidx = 1
    self.callbck = callbck
end

function NewGuySummonView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_hero 	    = TFDirector:getChildByPath(ui, "Panel_hero")

    self.Image_hero			= TFDirector:getChildByPath(ui, "Image_hero")
    self.Panel_hero_touch   = TFDirector:getChildByPath(ui, "Panel_hero_touch")

    self.Label_hero_name	= TFDirector:getChildByPath(ui, "Label_hero_name")

    self.Panel_heroItem = TFDirector:getChildByPath(ui, "Panel_hero")

    local ScrollView_hero  = TFDirector:getChildByPath(ui, "ScrollView_hero")
    self.ListView_hero = UIListView:create(ScrollView_hero)
    self.ListView_hero:setItemsMargin(2)
    self.Button_practice    = TFDirector:getChildByPath(ui, "Button_practice")
    self.hero_pos = self.Image_hero:getPosition()

    self.Label_time = TFDirector:getChildByPath(ui, "Label_time")
    self.Label_time:setSkewX(15)
    self.Label_goto = TFDirector:getChildByPath(ui, "Label_goto")
    self.Label_goto:setSkewX(15)
    self.Label_summon_name = TFDirector:getChildByPath(ui, "Label_summon_name")
    self.Label_summon_name:setSkewX(15)
    self.Label_summon_num = TFDirector:getChildByPath(ui, "Label_summon_num")
    self.Label_summon_num:setSkewX(15)
    self.Label_summon_cnt = TFDirector:getChildByPath(ui, "Label_summon_cnt")
    self.Label_summon_cnt:setSkewX(15)

    self.Button_goto =  TFDirector:getChildByPath(ui, "Button_goto")

    self.Button_get = TFDirector:getChildByPath(ui, "Button_get")
    self.Label_get = TFDirector:getChildByPath(self.Button_get, "Label_get")
    self.Button_practice = TFDirector:getChildByPath(ui, "Button_practice")
    self.Label_getcnt = TFDirector:getChildByPath(ui, "Label_getcnt")

    ---领取确认界面
    self.Panel_awardConfirm = TFDirector:getChildByPath(ui, "Panel_awardConfirm"):hide()
    self.Button_ok = TFDirector:getChildByPath(self.Panel_awardConfirm, "Button_ok")
    self.Label_awardConfirmtip = TFDirector:getChildByPath(self.Panel_awardConfirm, "Label_tip")
    self.Label_awardConfirmtip1 = TFDirector:getChildByPath(self.Panel_awardConfirm, "Label_tip1")
    self.Button_closeConfirm = TFDirector:getChildByPath(self.Panel_awardConfirm, "Button_closeConfirm")

    local summonTimes = Utils:getKVP(14007, "summonTimes")
    self.Label_summon_cnt:setText(summonTimes)

    self:initHeroList()
    self:selectItem(1)
    self:updateSummonInfo()
end

function NewGuySummonView:initHeroList()

    self.ListView_hero:removeAllItems()
    self.itemInfo = {}
    self.initOwnHero = {}
    local summonGiftCfg = SummonDataMgr:getSummonGiftCfg()
    if not summonGiftCfg then
        return
    end

    for k,v in ipairs(summonGiftCfg) do
        local heroid = v.heroId
        if not heroid then return end
        local item = self.Panel_heroItem:clone()
        local icon = TFDirector:getChildByPath(item,"Image_head")
        icon:setTexture(HeroDataMgr:getIconPathById(heroid))
        icon:setScale(1.2)
        self.ListView_hero:pushBackCustomItem(item)
        local Image_select = TFDirector:getChildByPath(item,"Image_select")
        local Image_level = TFDirector:getChildByPath(item,"Image_level")
        local Image_geted = TFDirector:getChildByPath(item,"Image_geted")
        local ishave = HeroDataMgr:getIsHave(heroid)
        Image_geted:setVisible(ishave)
        if ishave then
            self.initOwnHero[heroid] = 1
        end
        local tab = {}
        tab.item = item
        tab.Image_level = Image_level
        tab.select = Image_select
        tab.Image_geted = Image_geted
        tab.heroid = heroid
        tab.dungeonId = v.dungeonId
        tab.heroLimitId = v.heroLimitId
        table.insert(self.itemInfo,tab)
    end

end


function NewGuySummonView:selectItem(i)

    if self.lastSelectIndsex == i then
        return
    end

    if self.lastSelectIndsex then
        self.itemInfo[self.lastSelectIndsex].select:setVisible(false)
    end
    self.lastSelectIndsex = i
    self.itemInfo[i].select:setVisible(true)

    local heroid = self.itemInfo[i].heroid
    self.selectHeroId = heroid
    self.selectDungeonId = self.itemInfo[i].dungeonId
    self.selectHeroLimitId = self.itemInfo[i].heroLimitId

    self.Image_hero:stopAllActions()
    self.Image_hero:setPosition(self.hero_pos)
    ViewAnimationHelper.doMoveFadeInAction(self.Image_hero, {direction = 1, distance = 30, ease = 1})

    self.Label_hero_name:setString(HeroDataMgr:getName(heroid))
    self.anim_hero = Utils:createHeroModel(heroid, self.Image_hero)
    self.anim_hero:setScale(0.76)


end

---刷新召唤信息
function NewGuySummonView:updateSummonInfo(award)
    local noobInfo = SummonDataMgr:getNoobInfo()
    if not noobInfo then
        return
    end

    --领取按钮状态
    local enable = enum_awardSate.enable == noobInfo.awardState
    self.Button_get:setGrayEnabled(not enable)
    self.Button_get:setTouchEnabled(enable)
    local visible = enum_awardSate.geted ~= noobInfo.awardState
    --self.Button_get:setVisible(visible)

    local getCntStr = enum_awardSate.geted == noobInfo.awardState and 1890022 or 1890021
    self.Label_getcnt:setTextById(getCntStr)

    local getBtnStr = enum_awardSate.geted == noobInfo.awardState and 270491 or 1820002
    self.Label_get:setTextById(getBtnStr)

    --召唤次数
    self.Label_summon_num:setText(noobInfo.summonCount)

    --剩余时间
    local remainTime = noobInfo.endTime -ServerDataMgr:getServerTime()
    remainTime = remainTime > 0 and remainTime or 0
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    local str = TextDataMgr:getText(800044,day, hour, min)
    --self.Label_time:setText(day.."天"..hour.."时"..min.."分后结束")
    self.Label_time:setText(str)

    dump(award)
    dump(self.initOwnHero)
    if award then
        local heroId = award[1].id
        if self.initOwnHero[heroId] then
            Utils:openView("summon.SummonGetHeroView", heroId)
        end
    end
    self:updateHeroList()
    self:hideAwardConfirmView()
end

function NewGuySummonView:updateHeroList()
    for k,v in ipairs(self.itemInfo) do
        local ishave = HeroDataMgr:getIsHave(v.heroid)
        v.Image_geted:setVisible(ishave)
    end
end

function NewGuySummonView:showAwardConfirmView()

    self.Panel_awardConfirm:setVisible(true)
    local name = HeroDataMgr:getName(self.selectHeroId)
    self.Label_awardConfirmtip:setTextById(100000305,name)
    self.Label_awardConfirmtip1:setTextById(100000306)

end

function NewGuySummonView:hideAwardConfirmView()
    self.Panel_awardConfirm:setVisible(false)
end

function NewGuySummonView:fight()

    local args = {
        tittle = 2107025,
        content = TextDataMgr:getText(2107037),
        reType = EC_OneLoginStatusType.ReConfirm_NoobPractice,
        confirmCall = function()
            FubenDataMgr:send_DUNGEON_LIMIT_HERO_DUNGEON(self.selectDungeonId)
        end,
    }
    Utils:showReConfirm(args)

end

function NewGuySummonView:onLimitHeroEvent()

    local levelFormation =  FubenDataMgr:getLevelFormation(self.selectDungeonId)
    if not levelFormation then
        return
    end

    local formationData_ = FubenDataMgr:getInitFormation(self.selectDungeonId)
    if formationData_ then
        HeroDataMgr:changeDataByFuben(self.selectDungeonId, formationData_)
    end

    local heros = {}
    for i, v in ipairs(formationData_) do
        table.insert(heros, {limitType = v.type, limitCid = v.id})
    end

    FubenDataMgr:setFormation(levelFormation)
    local battleController = require("lua.logic.battle.BattleController")
    battleController.enterBattle(
            {
                levelCid = self.selectDungeonId,
                limitHeros = heros,
                isDuelMod = false,
            },
            EC_BattleType.COMMON
    )
end

function NewGuySummonView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_NOOBAWARD, handler(self.updateSummonInfo, self))
    EventMgr:addEventListener(self, EV_FUBEN_UPDATE_LIMITHERO, handler(self.onLimitHeroEvent, self))

    if self.itemInfo then
        for k,v in ipairs(self.itemInfo) do
            v.item:onClick(function()
                self:selectItem(k)
            end)
        end
    end

    self.Button_get:onClick(function()
        --self:showAwardConfirmView()
        self.callbck(self.selectHeroId)
    end)

    self.Button_goto:onClick(function()

        local jumpIndex
        local summon_ = SummonDataMgr:getSummon()
        if summon_ then
            for i, v in ipairs(summon_) do

                local summonCfg = SummonDataMgr:getSummonCfg(v[1].id)
                if summonCfg.summonType == EC_SummonType.DIAMOND then
                    jumpIndex = i
                    break
                end
            end
        end

        FunctionDataMgr:jSummon(jumpIndex)

        local isLayerInQueue,layer = AlertManager:isLayerInQueue("ActivityMain")
        if isLayerInQueue then
            AlertManager:closeLayer(layer)
        end
    end)

    self.Panel_awardConfirm:onClick(function()
        self:hideAwardConfirmView()
    end)

    self.Button_ok:onClick(function()
        SummonDataMgr:send_SUMMON_GET_NOOB_AEARD({self.selectHeroId})
    end)

    self.Button_closeConfirm:onClick(function()
        self:hideAwardConfirmView()
    end)

    self.Button_practice:onClick(function()
        self:fight()
    end)
end

return NewGuySummonView;
