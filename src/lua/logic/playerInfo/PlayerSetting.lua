local PlayerSetting = class("PlayerSetting", BaseLayer)

local PlayerInfoPublic = require("lua.logic.playerInfo.PlayerInfoPublic")
local PlayerInfoConfig = require("lua.logic.playerInfo.PlayerInfoConfig")

function PlayerSetting:initData(data)
    self.showid = MainPlayer:getAssistId()
    self.btnConfig_ = {
        {
            txt = 1454054,
            idx = 1,
            iconImg = "ui/playerInfo/new/003.png",
        },
        {
            txt = 1454055,
            idx = 2,
            iconImg = "ui/playerInfo/new/002.png",
        },
        {
            txt = 1454048,
            idx = 3,
            iconImg = "ui/playerInfo/new/001.png",
        },
    }
    local limitLevel = TabDataMgr:getData("DiscreteData",90008).data.contractLevel
    if MainPlayer:getPlayerLv() >= limitLevel then
        if GlobalFuncDataMgr:isOpen(15) then
            table.insert(self.btnConfig_, {
                txt = 63643,
                idx = 4,
                iconImg = "ui/playerInfo/new/040.png",
            })
        end
    end

    ---灵力共鸣是否开启
    local isOpen = FunctionDataMgr:isOpen(151)
    if isOpen  then  --增加小语种和英文版区别控制
        table.insert(self.btnConfig_, {
            txt = 14221105,
            idx = 5,
            iconImg = "ui/fairy/new_ui/gongming/3.png",
        })
    end

    self.defaultIdx = data and data.selectIdx or nil
    self.selectIndex_ = nil
    self.isFriend_ =  data and data.isFriend or nil
    if self.isFriend_ then
        table.remove(self.btnConfig_,1)
        table.remove(self.btnConfig_,1)
        table.remove(self.btnConfig_,2)
        self.defaultIdx = 1
    end



    self.showCount = table.count(HeroDataMgr:getShowList(true))
    self.selectHeroId = MainPlayer:getAssistId()
    self.showidx = HeroDataMgr:getShowIdxById(self.selectHeroId)

    self.medalCfgArray_ = {}
    self.loadedIndex_ = 1
    self.firstLoad = true
    self.medalItem_ = {}
    self.medalSortType = 0
    self.isReplaceModel_ = false    --是否是更换模式
    self.selectedMedalId_ = nil     --选中的准备穿戴的ID
end

function PlayerSetting:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)
    self:init("lua.uiconfig.playerInfo.playerSetting")
end

function PlayerSetting:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")
    self.Panel_spr_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_spr_item")
    self.Panel_medal_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_medal_item")
    self.Panel_phoneBind = TFDirector:getChildByPath(self.ui,"Panel_phoneBind");

    self:initLeft()
    self:refreshLeft()
    self:initRight()

    self:selectTabBtn(self.defaultIdx or 1)
    self:showTopBar()

    local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer,1000)
    -- self.inputLayer:setPositionX(-(GameConfig.WS.width - 1136) / 2)

    --self.ui:runAnimation("enterAction",1)
end

function PlayerSetting:onShow()
    self.super.onShow(self)
    self:updateTitleInfo()
end

function PlayerSetting:initLeft()
    self.Panel_left = TFDirector:getChildByPath(self.ui,"Panel_left")
    self.Image_fairy = TFDirector:getChildByPath(self.Panel_left,"Image_fairy")
    self.Image_fairy_orgPos = self.Image_fairy:getPosition();
    self.Label_power = TFDirector:getChildByPath(self.Panel_left,"Label_power")
    self.Button_assist = TFDirector:getChildByPath(self.Panel_left,"Button_assist")
    self.panel_name     = TFDirector:getChildByPath(self.Panel_left,"Panel_name");
    self.fairyNameImg   = TFDirector:getChildByPath(self.panel_name,"Image_hero_name");
    self.titleImg       = TFDirector:getChildByPath(self.panel_name,"Image_hero_title");
    self.Label_hero_name       = TFDirector:getChildByPath(self.panel_name,"Label_hero_name");
    self.Image_sss_level       = TFDirector:getChildByPath(self.panel_name,"Image_sss_level");
    self.Label_dressName       = TFDirector:getChildByPath(self.panel_name,"Label_dressName");

    local ScrollView_tab = TFDirector:getChildByPath(self.ui, "ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)
    self.ListView_tab:setItemsMargin(2)
    self.tabBtn_ = {}
    for i, v in ipairs(self.btnConfig_) do
        local Panel_tabItem = self.Panel_tabItem:clone()
        local item = {}
        item.Label_name = TFDirector:getChildByPath(Panel_tabItem, "Label_name")
        item.Image_normal = TFDirector:getChildByPath(Panel_tabItem, "Image_normal")
        item.Image_select = TFDirector:getChildByPath(Panel_tabItem, "Image_select")
        item.Image_icon = TFDirector:getChildByPath(Panel_tabItem, "Image_icon")
        item.Image_touch = TFDirector:getChildByPath(Panel_tabItem, "Image_touch")
        self.tabBtn_[v.idx] = item
        item.Image_icon:setTexture(v.iconImg)
        item.Label_name:setTextById(v.txt)

        self.ListView_tab:pushBackCustomItem(Panel_tabItem)
    end
end

function PlayerSetting:selectTabBtn(index)
    if self.selectIndex_ == index then return end
    self.selectIndex_ = index

    for k, v in pairs(self.tabBtn_) do
        local isSelect = (k == index)
        v.Image_normal:setVisible(not isSelect)
        v.Image_select:setVisible(isSelect)
    end
    self:refreshRight()
end

function PlayerSetting:refreshRight()
    self.Panel_left:hide()
    self.Panel_player_info:hide()
    self.Panel_zhuzhan_info:hide()
    self.Panel_medal:hide()
    self.Panel_energy:hide()
    self.Panel_gongming:hide()

    if self.selectIndex_ == 1 then
        self.Panel_left:show()
        self.Panel_player_info:show()
        self:refreshInfo()
    elseif self.selectIndex_ == 2 then
        self.Panel_left:show()
        self.Panel_zhuzhan_info:show()
        self:refreshHeroInfo()
    elseif self.selectIndex_ == 3 then
        self.Panel_medal:show()
        if self.isFriend_ then
            self:loadMedalItemUI()
        else
            MedalDataMgr:sendReqActivateMedals()
        end
    elseif self.selectIndex_ == 4 then
        self.Panel_energy:show()
        HeroDataMgr:ReqNewSpiritInfo()
    elseif self.selectIndex_ == 5 then
        self.Panel_gongming:show()
    end
end

function PlayerSetting:refreshLeft()
    self.Image_fairy:setTexture(HeroDataMgr:getModelPathById(self.showid))
    Utils:createHeroModel(self.showid,self.Image_fairy)
    self.Label_power:setString(math.floor(HeroDataMgr:getHeroPower(self.showid)))
    self.fairyNameImg:setTexture(HeroDataMgr:getNamePic(self.showid))
    self.titleImg:setTexture(HeroDataMgr:getTitlePic(self.showid))

    self.Label_hero_name:setString(HeroDataMgr:getName(self.showid))
    local skinid = HeroDataMgr:getCurSkin(self.showid);
    self.Label_dressName:setString(HeroDataMgr:getTitleById(self.showid))
    self.Image_sss_level:setTexture(HeroDataMgr:getQualityPic(self.showid))
end

function PlayerSetting:initRight()
    self:initInfo()
    self:initHeroInfo()
    self:initMedalInfo()
    self:initEnergyInfo()
    self:initGongMingInfo()
end

function PlayerSetting:initGongMingInfo()
    self.Panel_gongming = TFDirector:getChildByPath(self.ui,"Panel_gongming")
    local gongMingUi = self.Panel_gongming:getChildByName("gongMingUi")
    if not gongMingUi then
        gongMingUi = requireNew("lua.logic.fairyNew.GongMingMainView"):new()
    end
    self.Panel_gongming:addChild(gongMingUi)
end

function PlayerSetting:initInfo()
    self.Panel_player_info = TFDirector:getChildByPath(self.ui,"Panel_player_info")
    local ScrollView_info = TFDirector:getChildByPath(self.Panel_player_info,"ScrollView_info")
    self.Panel_extra_info = TFDirector:getChildByPath(self.Panel_player_info,"Panel_extra_info")
    local Image_scrollBarModel = TFDirector:getChildByPath(self.Panel_player_info,"Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.ScrollView_info = UIListView:create(ScrollView_info)
    self.ScrollView_info:setScrollBar(scrollBar)
    self.Panel_extra_info:removeFromParent()
    self.ScrollView_info:pushBackCustomItem(self.Panel_extra_info)

    self.Image_head = TFDirector:getChildByPath(self.Panel_player_info,"Image_head")
    self.Image_head_cover_frame = TFDirector:getChildByPath(self.Panel_player_info,"Image_head_cover_frame")
    self.Image_avatar_new = TFDirector:getChildByPath(self.Panel_player_info,"Image_avatar_new"):hide()
    self.Label_playerName = TFDirector:getChildByPath(self.Panel_player_info,"Label_playerName")
    self.Label_playerId = TFDirector:getChildByPath(self.Panel_player_info,"Label_playerId")
    self.Label_as_name = TFDirector:getChildByPath(self.Panel_player_info,"Label_as_name")
    self.Button_modifyName = TFDirector:getChildByPath(self.Panel_player_info,"Button_modifyName")
    self.Button_copy = TFDirector:getChildByPath(self.Panel_player_info,"Button_copy")

    self.Label_lv = TFDirector:getChildByPath(self.Panel_player_info,"Label_lv")
    self.Label_maxLv = TFDirector:getChildByPath(self.Panel_player_info, "Label_maxLv")
    self.LoadingBar_lv  = TFDirector:getChildByPath(self.Panel_player_info,"LoadingBar_lv")
    self.Label_curExp = TFDirector:getChildByPath(self.Panel_player_info,"Label_curExp")

    self.Label_dec = TFDirector:getChildByPath(self.Panel_player_info,"Label_dec")
    self.TextField_des = TFDirector:getChildByPath(self.Panel_player_info,"TextField_des"):hide()
    self.Button_dec_modify = TFDirector:getChildByPath(self.Panel_player_info,"Button_dec_modify")
    self.Label_dec_modify = TFDirector:getChildByPath(self.Panel_player_info,"Label_dec_modify")
    self.Label_dec_modify_ok = TFDirector:getChildByPath(self.Panel_player_info,"Label_dec_modify_ok")

    self.Label_pb_name = TFDirector:getChildByPath(self.Panel_player_info, "Label_pb_name")
    self.Button_bind = TFDirector:getChildByPath(self.Panel_player_info, "Button_bind")
    self.Label_account_info = TFDirector:getChildByPath(self.Panel_player_info,"Label_account_info")
    self.Button_account_info_logout = TFDirector:getChildByPath(self.Panel_player_info,"Button_account_info_logout")
    self.Label_shiming_info = TFDirector:getChildByPath(self.Panel_player_info, "Label_shiming_info")
    self.Button_certification = TFDirector:getChildByPath(self.Panel_player_info, "Button_certification")

    self.Button_lianxi = TFDirector:getChildByPath(self.Panel_player_info, "Button_lianxi")
    self.Button_mima = TFDirector:getChildByPath(self.Panel_player_info, "Button_mima")
    self.Button_gift_exchange = TFDirector:getChildByPath(self.Panel_player_info,"Button_gift_exchange")

    self.Button_title = TFDirector:getChildByPath(self.Panel_player_info,"Button_title")
    self.Label_no_title = TFDirector:getChildByPath(self.Button_title,"Label_no_title")
    self.Image_title_effect_bg = TFDirector:getChildByPath(self.Button_title,"Image_title_effect_bg")
    self.Image_title_new = TFDirector:getChildByPath(self.Button_title,"Image_title_new"):hide()


   
    --屏蔽实名认真
    TFDirector:getChildByPath(self.Panel_player_info,"Panel_certification"):hide()
    


    self.Label_lv1 = TFDirector:getChildByPath(self.Panel_player_info,"Label_lv1")
    self.Label_maxLv1 = TFDirector:getChildByPath(self.Panel_player_info, "Label_maxLv1")
    self.LoadingBar_lv1  = TFDirector:getChildByPath(self.Panel_player_info,"LoadingBar_lv1")
    self.Label_curExp1 = TFDirector:getChildByPath(self.Panel_player_info,"Label_curExp1")
end

function PlayerSetting:refreshInfo()
    self.showid = MainPlayer:getAssistId()
    local playerName = MainPlayer:getPlayerName()
    local playerId = MainPlayer:getPlayerId()
    -- local asName = "未开放"
    local asName = TextDataMgr:getText(600027)
    if MainPlayer:getAs() then
        asName = MainPlayer:getAs().asName
    end
    self.Label_playerName:setString(playerName)
    self.Label_playerId:setString(playerId)
    self.Label_as_name:setString(LeagueDataMgr:getUnionName())

    self:refreshExtraInfo()
    self:onAvatarUpdata()
    self:updateTitleInfo()
end

function PlayerSetting:updateTitleInfo()

    local equipTitledId = TitleDataMgr:getEquipedTitleId()
    if equipTitledId and equipTitledId > 0 then
        self.Label_no_title:setVisible(false)

        local titleCfg = TitleDataMgr:getTitleCfg(equipTitledId)
        if titleCfg then
            self.Image_title_effect_bg:removeAllChildren()
            local skeletonTitleNode = TitleDataMgr:getTitleEffectSkeletonModle(titleCfg.id, 1)
            self.Image_title_effect_bg:addChild(skeletonTitleNode,1)
        end
        self.Image_title_effect_bg:setVisible(true)

    else
        self.Label_no_title:setVisible(true)
        self.Image_title_effect_bg:setVisible(false)
    end
    local redPoin = TitleDataMgr:checkTitleRedState()
    self.Image_title_new:setVisible(redPoin)
end

function PlayerSetting:refreshExtraInfo()
    local expPercent = MainPlayer:getExpProgress()
    local lv = MainPlayer:getPlayerLv()
    local curExp = MainPlayer:getPlayerExp()
    local curLevelMaxExp = TabDataMgr:getData("LevelUp",lv).playerExp
    self.LoadingBar_lv:setPercent(expPercent)
    if curLevelMaxExp <= 0 then
        self.Label_curExp:setString("max")
    else
        self.Label_curExp:setString(curExp .."/".. curLevelMaxExp)
    end    
    self.Label_lv:setString(MainPlayer:getPlayerLv())
    self.Label_maxLv:setText("/"..MainPlayer:getMaxPlayerLevel())

    self.Label_dec:show()
    local decStr = MainPlayer:getDeclaration()
    if decStr ~= "" then
        self.Label_dec:setString(decStr)
    end

    if HeitaoSdk then
        if MainPlayer:getPhoneNum() ~= nil then 
            if(CC_TARGET_PLATFORM == CC_PLATFORM_IOS and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.64) or 
                (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.61) then
                
                self.Label_pb_name:setTextById(600028);
            else
                self.Label_pb_name:setTextById(600040);
            end
        else
            self.Label_pb_name:setTextById(600029);
        end
    end

    if MainPlayer:getAntiAddcationStatus() == 0 then
        self.Label_shiming_info:setTextById(600030)
    else
        self.Label_shiming_info:setTextById(600031)
    end
    self.Button_certification:setGrayEnabled(MainPlayer:getAntiAddcationStatus() ~= 0);

    local accountStr = CCUserDefault:sharedUserDefault():getStringForKey("account")
    self.Label_account_info:setString(accountStr)


    local level, curProcess, maxProcess, maxLv = MainPlayer:getTouzirenLevel();
    self.Label_lv1:setText(level)
    self.LoadingBar_lv1:setPercent( curProcess*100 / maxProcess)
    self.Label_maxLv1:setText("/"..maxLv)
    self.Label_curExp1:setText(curProcess.. "/".. maxProcess)
end

function PlayerSetting:initHeroInfo()
    self.Panel_zhuzhan_info = TFDirector:getChildByPath(self.ui,"Panel_zhuzhan_info")
    local ScrollView_spr_list = TFDirector:getChildByPath(self.Panel_zhuzhan_info,"ScrollView_spr_list")
    self.Panel_extra_info = TFDirector:getChildByPath(self.Panel_zhuzhan_info,"Panel_extra_info")
    local Image_sprBarModel = TFDirector:getChildByPath(self.Panel_zhuzhan_info,"Image_sprBarModel")
    local Image_sprBarInner = TFDirector:getChildByPath(Image_sprBarModel, "Image_sprBarInner")
    local scrollBar = UIScrollBar:create(Image_sprBarModel, Image_sprBarInner)
    self.ScrollView_spr_list = UIListView:create(ScrollView_spr_list)
    self.ScrollView_spr_list:setScrollBar(scrollBar)
    self.ScrollView_spr_list:setItemsMargin(10)

    self.Label_spr_count = TFDirector:getChildByPath(self.Panel_zhuzhan_info,"Label_spr_count")
    self.Button_change = TFDirector:getChildByPath(self.Panel_zhuzhan_info,"Button_change")
    self:updateChangeBtn()
end

function PlayerSetting:refreshHeroInfo()
    self.ScrollView_spr_list:removeAllItems()
    for i = 1, self.showCount do
        local heroId = HeroDataMgr:getSelectedHeroId(i)
        if HeroDataMgr:getHero(heroId).heroStatus ~= 2 then
            local heroItem = self.Panel_spr_item:clone()
            self:updateHeroItem(heroItem, i)
            self.ScrollView_spr_list:pushBackCustomItem(heroItem)
        end
    end
    local maxNum = HeroDataMgr:getOpenedHeroNum()
    self.Label_spr_count:setString(tostring(self.showCount).."/"..tostring(maxNum))
end

function PlayerSetting:updateHeroItem(heroItem, idx)
    local heroId = HeroDataMgr:getSelectedHeroId(idx)
    local skinId = HeroDataMgr:getCurSkin(heroId)
    local data = TabDataMgr:getData("HeroSkin", skinId)

    local Image_assist   = TFDirector:getChildByPath(heroItem,"Image_assist")
    local Image_di = TFDirector:getChildByPath(heroItem, "Image_di")
    local icon = TFDirector:getChildByPath(heroItem,"Image_hero")
    local name = TFDirector:getChildByPath(heroItem,"Label_name")
    local jobIcon = TFDirector:getChildByPath(heroItem,"Image_duty")
    local Label_level       = TFDirector:getChildByPath(heroItem,"Label_level")
    local Image_assistant   = TFDirector:getChildByPath(heroItem,"Image_assistant")
    local Label_suit_name   = TFDirector:getChildByPath(heroItem,"Label_suit_name")
    local Label_power   = TFDirector:getChildByPath(heroItem,"Label_power")
    local Label_power_num   = TFDirector:getChildByPath(heroItem,"Label_power_num")
    local Image_quality = TFDirector:getChildByPath(heroItem,"Image_quality")

    icon:setTexture(HeroDataMgr:getPlayerIconPathById(heroId))
    icon:setSize(ccs(150,95))
    local iconpath = HeroDataMgr:getHeroJobIconPath(heroId) 
    jobIcon:setVisible(iconpath ~= "")
    jobIcon:setTexture(iconpath)
    Image_quality:setTexture(HeroDataMgr:getQualityPic(heroId))
    Label_power:setTextById(350011)

    name:setTextById(HeroDataMgr:getNameStrId(heroId))
    local heroLv = HeroDataMgr:getLv(heroId)
    Label_level:setText("[Lv."..heroLv.."]")
    Label_suit_name:setText("【"..TextDataMgr:getText(HeroDataMgr:getTitleStrId(heroId)).."】")
    Label_power_num:setString(math.floor(HeroDataMgr:getHeroPower(heroId)))

    --是否助战
    -- local assitance = HeroDataMgr:getIsAssist(heroId)
    -- Image_assistant:setVisible(assitance)

    if self.showidx == idx then
        Image_di:setTexture("ui/playerInfo/new/005.png")
        name:setColor(ccc3(255, 255, 255))
        Label_level:setColor(ccc3(255, 255, 255))
        Label_suit_name:setColor(ccc3(255, 255, 255))
        Label_power_num:setColor(ccc3(255, 255, 255))
        Label_power:setColor(ccc3(255, 255, 255))
        
        name:enableOutline(ccc4(223,121,151,255),1)
        Label_level:enableOutline(ccc4(223,121,151,255),1)
        Label_suit_name:enableOutline(ccc4(223,121,151,255),1)
        Label_power_num:enableOutline(ccc4(223,121,151,255),1)
        Label_power:enableOutline(ccc4(223,121,151,255),1)
    else
        Image_di:setTexture("ui/playerInfo/new/006.png")
        name:setColor(ccc3(48, 53, 74))
        Label_level:setColor(ccc3(48, 53, 74))
        Label_suit_name:setColor(ccc3(48, 53, 74))
        Label_power_num:setColor(ccc3(48, 53, 74))
        Label_power:setColor(ccc3(48, 53, 74))

        name:enableOutline(ccc4(223,121,151,0),1)
        Label_level:enableOutline(ccc4(223,121,151,0),1)
        Label_suit_name:enableOutline(ccc4(223,121,151,0),1)
        Label_power_num:enableOutline(ccc4(223,121,151,0),1)
        Label_power:enableOutline(ccc4(223,121,151,0),1)
    end

    Image_di:setTouchEnabled(true)
    Image_di:onClick(function()
        self.showidx = idx
        self.selectHeroId = heroId
        self:refreshHeroList()
        self:updateChangeBtn()
    end)
end

function PlayerSetting:updateChangeBtn()
    if MainPlayer:getAssistId() == self.selectHeroId then
        self.Button_change:setTouchEnabled(false)
        self.Button_change:setGrayEnabled(true)
    else
        self.Button_change:setTouchEnabled(true)
        self.Button_change:setGrayEnabled(false)
    end
end

function PlayerSetting:refreshHeroList()
    local items = self.ScrollView_spr_list:getItems()
    for i, item in ipairs(items) do
        self:updateHeroItem(item, i)
    end
end

function PlayerSetting:initMedalInfo()
    self.Panel_medal = TFDirector:getChildByPath(self.ui,"Panel_medal")
    self.Label_medal_count = TFDirector:getChildByPath(self.Panel_medal,"Label_medal_count")
    self.Medal_change = TFDirector:getChildByPath(self.Panel_medal,"Button_change"):hide()
    local Label_my_medal = TFDirector:getChildByPath(self.Panel_medal,"Label_my_medal")
    Label_my_medal:setTextById(4007011)
    self.Button_open = TFDirector:getChildByPath(self.Panel_medal,"Button_open")
    self.open_title = TFDirector:getChildByPath(self.Button_open,"Label_title")
    self.open_arrow = TFDirector:getChildByPath(self.Button_open,"Image_arrow")
    self.Image_buttons = TFDirector:getChildByPath(self.Panel_medal,"Image_buttons")
    self.Button_all = TFDirector:getChildByPath(self.Image_buttons,"Button_all")
    self.Button_jieri = TFDirector:getChildByPath(self.Image_buttons,"Button_jieri")
    self.Button_huodong = TFDirector:getChildByPath(self.Image_buttons,"Button_huodong")
    self.Button_cehngjiu = TFDirector:getChildByPath(self.Image_buttons,"Button_cehngjiu")
    self.Button_xianding = TFDirector:getChildByPath(self.Image_buttons,"Button_xianding")
    self.sortBtns = {}
    self.sortBtns[#self.sortBtns + 1] = self.Button_all
    self.sortBtns[#self.sortBtns + 1] = self.Button_jieri
    self.sortBtns[#self.sortBtns + 1] = self.Button_huodong
    self.sortBtns[#self.sortBtns + 1] = self.Button_xianding
    self.sortBtns[#self.sortBtns + 1] = self.Button_cehngjiu

    for i, btn in ipairs(self.sortBtns) do
        btn:onClick(function()
            self.medalSortType = i - 1
            self:loadMedalItemUI()
            self:onTouchButtonOpen()
        end)
    end

    local ScrollView_medal_list = TFDirector:getChildByPath(self.Panel_medal,"ScrollView_medal_list")
    local Image_medalBarModel = TFDirector:getChildByPath(self.Panel_medal,"Image_medalBarModel")
    local Image_medalBarInner = TFDirector:getChildByPath(Image_medalBarModel, "Image_medalBarInner")
    local scrollBar = UIScrollBar:create(Image_medalBarModel, Image_medalBarInner)
    self.ScrollView_medal_list = UIGridView:create(ScrollView_medal_list)
    self.ScrollView_medal_list:setItemModel(self.Panel_medal_item)
    self.ScrollView_medal_list:setColumn(6)
    self.ScrollView_medal_list:setColumnMargin(10)
    self.ScrollView_medal_list:setRowMargin(15)
    self.ScrollView_medal_list:setScrollBar(scrollBar)
end

function PlayerSetting:loadMedalItemUI()
    local medalTypeName = {1701041,300627,800098,100000128,1410011}
    self.open_title:setTextById(medalTypeName[self.medalSortType + 1])
    self.medalCfgArray_ = MedalDataMgr:getMedalCfgArrayData(self.medalSortType)
    self.loadedIndex_ = 1
    if self.firstLoad then
        self:loadMedalItem()
        self.firstLoad = false
    else
        self:refreshMedalItem()
    end
    local ownCount = 0
    for i, v in ipairs(self.medalCfgArray_) do
        if MedalDataMgr:getMedelInfoById(v.id) then
            ownCount = ownCount + 1
        end
    end
    self.Label_medal_count:setText(ownCount.."/"..#self.medalCfgArray_)
end

function PlayerSetting:loadMedalItem()
    local loadedIndex = self.loadedIndex_
    local medalCfg = self.medalCfgArray_[loadedIndex]
    if loadedIndex > #self.medalCfgArray_ then return end

    local item = self.ScrollView_medal_list:getItem(loadedIndex)
    if not item then
        item = self:createMedalItem()
        item:Alpha(0)
    end
    self:updateMedalItem(item, medalCfg)
    local fadeInDuration = 0.2
    local delayDuration = 0.05
    item:fadeIn(fadeInDuration)
    local action = Sequence:create({
            DelayTime:create(delayDuration),
            CallFunc:create(function()
                    self.loadedIndex_ = loadedIndex + 1
                    self:loadMedalItem()
            end)
    })
    item:runAction(action)
end

function PlayerSetting:refreshMedalItem()
    local loadedIndex = self.loadedIndex_
    local medalCfg = self.medalCfgArray_[loadedIndex]
    --if not medalCfg then return end

    local column = self.ScrollView_medal_list:getColumn()
    local fadeInDuration = 0.15
    local delayDuration = 0.05
    for i = loadedIndex, math.min(loadedIndex + column - 1, #self.ScrollView_medal_list:getItems()) do
        local item = self.ScrollView_medal_list:getItem(i)
        if not item then
            item = self:createMedalItem()
            item:Alpha(0)
        end
        item:fadeIn(fadeInDuration)
        self:updateMedalItem(item, self.medalCfgArray_[i])
    end
    local action = Sequence:create({
            DelayTime:create(delayDuration),
            CallFunc:create(function()
                    self.loadedIndex_ = loadedIndex + column
                    self:refreshMedalItem()
            end)
    })
    self.Panel_medal:stopAllActions()
    self.Panel_medal:runAction(action)
end

function PlayerSetting:createMedalItem()
    local item = self.ScrollView_medal_list:pushBackDefaultItem()
    local target = {}
    target.node = item
    target.Panel_content = TFDirector:getChildByPath(item, "Panel_content")
    target.Image_medal_bg = TFDirector:getChildByPath(item, "Image_medal_bg")
    target.Image_medal_icon = TFDirector:getChildByPath(item, "Image_medal_icon")
    target.Panel_wearing = TFDirector:getChildByPath(item, "Panel_wearing")
    target.Label_medal_name = TFDirector:getChildByPath(item, "Label_medal_name")
    target.Image_select = TFDirector:getChildByPath(item, "Image_select")
    target.Panel_click = TFDirector:getChildByPath(item, "Panel_click")
    target.Panel_star = TFDirector:getChildByPath(item, "Panel_star")
    target.Image_grey = TFDirector:getChildByPath(item, "Image_grey")
    target.Image_medal_lock = TFDirector:getChildByPath(item, "Image_medal_lock")

    for i=1,5 do
        local str = "Image_star"..i
        target[str] = TFDirector:getChildByPath(item, str)
    end
    self.medalItem_[item] = target
    return item
end


function PlayerSetting:updateMedalItem(item, medalCfg)
    local target = self.medalItem_[item]
    if not target then
        target = self.medalItem_[self:createMedalItem()]
    end
    if not medalCfg then
        target.Panel_content:hide()
        return
    end
    target.Panel_content:show()
    target.Image_select:setVisible(false)
    target.Panel_wearing:setVisible(false)
    target.Image_medal_bg:setTexture(MedalDataMgr:getMedalStarBg(medalCfg.star))
    target.Image_medal_bg:setContentSize(CCSize(160 , 260))
    target.Image_medal_icon:setTexture(medalCfg.icon)
    local scaleRate = medalCfg.size[1] or 100
    target.Image_medal_icon:setScale(scaleRate / 100)
    local medalInfo = MedalDataMgr:getMedelInfoById(medalCfg.id)
    if medalInfo then
        if medalInfo.isEquip then
            target.Panel_wearing:setVisible(true)
        end
        target.Image_grey:setVisible(false)
        target.Image_medal_lock:setVisible(false)
    else
        target.Image_grey:setVisible(true)
        target.Image_medal_lock:setVisible(true)
    end
    target.Label_medal_name:setTextById(medalCfg.name)
    for i=1,5 do
        if medalCfg.star >= i then
            target["Image_star"..i]:setVisible(true)
            target["Image_star"..i]:setPositionX((5 - medalCfg.star) * 9 + i * 20)
        else
            target["Image_star"..i]:setVisible(false)
        end
    end
    target.Panel_click:onClick(function()
        if self.isReplaceModel_ then
            if medalInfo and not medalInfo.isEquip then
                target.Image_select:setVisible(true)
                self.selectedMedalId_ = medalInfo.cid
                self.Medal_change:setVisible(true)
            else
                Utils:showTips(600033)
            end
        else
            Utils:openView("playerInfo.MedalInfoView", medalCfg.id)   --目前仅显示基本信息使用
            --Utils:openView("playerInfo.MedalDetailView", medalCfg.id) --后期展示属性和技能和相关操作时使用
        end
    end)
end

function PlayerSetting:initEnergyInfo()
    self.Panel_energy = TFDirector:getChildByPath(self.ui,"Panel_energy")
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_energy, "Panel_touch")
    self.Button_add      = TFDirector:getChildByPath(self.Panel_energy, "Button_add")
    self.Button_up      = TFDirector:getChildByPath(self.Panel_energy, "Button_up")
    self.Button_break = TFDirector:getChildByPath(self.Panel_energy, "Button_break")
    self.Button_reback = TFDirector:getChildByPath(self.Panel_energy, "Button_reback"):hide()
    self.Image_red = TFDirector:getChildByPath(self.Button_add, "Image_red")
    self.Label_add_title = TFDirector:getChildByPath(self.Button_add, "Label_add_title")
    self.Label_up_title = TFDirector:getChildByPath(self.Button_up, "Label_up_title")
    self.Label_break_title = TFDirector:getChildByPath(self.Button_break, "Label_break_title")
    self.Label_add_title:setTextById(63647)
    self.Label_up_title:setTextById(63644)
    self.Label_break_title:setTextById(63645)

    self.Label_cur_level = TFDirector:getChildByPath(self.Panel_energy, "Label_cur_level")
    self.Label_max_level = TFDirector:getChildByPath(self.Panel_energy, "Label_max_level")
    self.Image_level_icon = TFDirector:getChildByPath(self.Panel_energy, "Image_level_icon")
    self.Label_energy_exp = TFDirector:getChildByPath(self.Panel_energy, "Label_energy_exp")
    self.LoadingBar_energy = TFDirector:getChildByPath(self.Panel_energy, "LoadingBar_energy")
    self.Label_energy_num = TFDirector:getChildByPath(self.Panel_energy, "Label_energy_num")

    self.Panel_attrs = TFDirector:getChildByPath(self.Panel_energy, "Panel_attrs")

    self.attr_infos = {}
    for i=1,3 do
        local item = TFDirector:getChildByPath(self.Panel_energy, "Panel_attr"..i)
        local foo = {}
        foo.root = item
        foo.Image_attr_icon = TFDirector:getChildByPath(item, "Image_attr_icon")
        foo.Label_name = TFDirector:getChildByPath(item, "Label_name")
        foo.Label_num = TFDirector:getChildByPath(item, "Label_num")
        self.attr_infos[i] = foo
    end
end

function PlayerSetting:updateEnergyInfo()
    local spiritInfo = HeroDataMgr:getSpiritInfo()
    local maxLevel = HeroDataMgr:getEnergyUpMaxLevel()
    local curLevel = HeroDataMgr:getHeroEnergyLevel()
    self.Label_max_level:setString("/"..maxLevel)
    self.Label_cur_level:setString(curLevel)
    self.Label_cur_level:setPositionX(self.Image_level_icon:getPositionX() + 2)
    self.Label_max_level:setPositionX(self.Label_cur_level:getPositionX() + self.Label_cur_level:getContentSize().width + 2)

    self.Label_energy_exp:setString(HeroDataMgr:getHeroEnergyExp().."/"..HeroDataMgr:getHeroEnergyLevelUpExp())
    self.LoadingBar_energy:setPercent(HeroDataMgr:getHeroEnergyExpPercent())

    local enableBreak = HeroDataMgr:checkEnergyEnableBreak()
    self.Button_up:setVisible(not enableBreak)
    local canlevelup = HeroDataMgr:checkEnergyUpEnable()
    if canlevelup then
        self.Button_up:setGrayEnabled(false)
        self.Button_up:setTouchEnabled(true)
    else
        self.Button_up:setGrayEnabled(true)
        self.Button_up:setTouchEnabled(false)
    end
    self.Image_red:setVisible(HeroDataMgr:checkEnergyRedpoint())

    self.Button_break:setVisible(enableBreak)
    self.Button_reback:setVisible(not spiritInfo.feedback)

    local data = HeroDataMgr:getHeroEnergyUseData()
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

    local energyPoints = HeroDataMgr:getHeroEnergyPoints()
    self.Label_energy_num:setString(energyPoints - usedPoint)
end

function PlayerSetting:drawAttrPolygon(valueArray)
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
    attrNode:drawSolidPoly(pointsSolid, ccc4(200 / 255, 234 / 255, 248 / 255, 1))
    attrNode:setPosition(ccp(0, 0))
end

function PlayerSetting:spiritInfoChange()
    self:updateEnergyInfo()
end

function PlayerSetting:onBreakOver()
    Utils:openView("fairyNew.FairyEnergyBreakUpView")
end

function PlayerSetting:onLevelUpOver(data)
    local level = HeroDataMgr:getHeroEnergyLevel()
    if level ~= self.lastLevel then
        Utils:openView("fairyNew.FairyEnergyLevelUpView",self.lastLevel)
    end
end

function PlayerSetting:onReadyToReplaceMedal()
    self.isReplaceModel_ = true
end

function PlayerSetting:onGetActivateMedals()
    self:loadMedalItemUI()
end


function PlayerSetting:onInput()
    self.topLayer:hide()
end

function PlayerSetting:onOutput()
    self.topLayer:show()
end

function PlayerSetting:onChangeNameError()
    self.ui:timeOut(function() Utils:showTips(200006) end,0.1)
end

function PlayerSetting:onChangeNameOk()
    self.ui:timeOut(function() Utils:showTips(800025) end,0.1)
    self:refreshRight()
end

function PlayerSetting:onTouchButtonOpen()
    for i, btn in ipairs(self.sortBtns) do
        local Label_name = TFDirector:getChildByPath(btn, "Label_name")
        if self.medalSortType == i - 1 then
            Label_name:setFontColor(ccc3(252,225,64))
        else
            Label_name:setFontColor(ccc3(255,255,255))
        end
    end

    if self.isOpen then
        self.isOpen = false
        self.open_arrow:setRotation(180)
        self.Image_buttons:runAction(CCSpawn:create({CCFadeOut:create(0.15), CCScaleTo:create(0.15, 1, 0.01)}))
    else
        self.isOpen = true
        self.open_arrow:setRotation(0)
        self.Image_buttons:runAction(CCSpawn:create({CCFadeIn:create(0.15), CCScaleTo:create(0.15, 1, 1)}))
    end
end

function PlayerSetting:registerEvents()
    EventMgr:addEventListener(self, EV_CHANGE_ASSIST, handler(self.onChangeAssist, self))
    EventMgr:addEventListener(self, PlayerInfoConfig.EV_INPUT, handler(self.onInput, self))
    EventMgr:addEventListener(self, PlayerInfoConfig.EV_OUTPUT, handler(self.onOutput, self))
    EventMgr:addEventListener(self, EV_CHANGE_NAME_OK_TIP, handler(self.onChangeNameOk, self))
    EventMgr:addEventListener(self, EV_MODIFY_DEC, handler(self.onModifyDecEvent, self))
    EventMgr:addEventListener(self, EV_MEDAL_RESP_ACTIVATE_MEDALS, handler(self.onGetActivateMedals, self))
    EventMgr:addEventListener(self, EV_MEDAL_READY_TO_REPLACE, handler(self.onReadyToReplaceMedal, self))
    EventMgr:addEventListener(self, EV_PLAYER_INFO_CHANGE, handler(self.refreshExtraInfo, self))
    EventMgr:addEventListener(self, EV_AVATAR_UPDATE, handler(self.onAvatarUpdata, self))
    EventMgr:addEventListener(self, EV_EQUIP_OR_TAKEOFF_TITLE, handler(self.updateTitleInfo, self))
    EventMgr:addEventListener(self,EV_HERO_REFRESH_SPRIT,handler(self.spiritInfoChange, self))
    EventMgr:addEventListener(self,EV_HERO_USE_ITEM_UP_SPRIT,handler(self.onLevelUpOver, self))
    EventMgr:addEventListener(self,EV_HERO_UPGRADE_SPRIT_POINTS,handler(self.onBreakOver, self))
    EventMgr:addEventListener(self,EV_HERO_PROPERTYCHANGE,handler(self.refreshLeft, self));

    local function onTextFieldChangedHandleAcc(input)
        self.inputLayer:listener(input:getText())
    end

    local function onTextFieldAttachAcc(input)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
        EventMgr:dispatchEvent(PlayerInfoConfig.EV_INPUT)
    end

    self.TextField_des:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_des:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_des:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_dec_modify:onClick(function()

        if not FunctionDataMgr:getModifyFuncIsOpen() then
            Utils:showTips(63826)
            return
        end

        self.TextField_des:openIME()
    end)

    self.Button_modifyName:onClick(function()
        --改名
        
        if not FunctionDataMgr:getModifyFuncIsOpen() then
            Utils:showTips(63826)
            return
        end

        local modifyNameView = require("lua.logic.playerInfo.ModifyNameView"):new()
        AlertManager:addLayer(modifyNameView)
        AlertManager:show()
    end)

    self.Button_copy:onClick(function()
        local content = self.Label_playerId:getString()
        TFDeviceInfo:copyToPasteBord(content)
        Utils:showTips(600010)
    end)

    self.Button_account_info_logout:onClick(function()
        --登出
        local logoutView = require("lua.logic.playerInfo.LogoutView"):new()
        AlertManager:addLayer(logoutView)
        AlertManager:show()
    end)

    self.Button_gift_exchange:onClick(function()
        local exchangeCodeView = require("lua.logic.playerInfo.ExchangeCodeView"):new()
        AlertManager:addLayer(exchangeCodeView)
        AlertManager:show()
    end)
    local serverid = ServerDataMgr:getCurrentServerID();
    self.Button_gift_exchange:setVisible((serverid ~= 999001));

    self.Button_bind:onClick(function()
        if HeitaoSdk then
            if MainPlayer:getPhoneNum() == nil or 
                (CC_TARGET_PLATFORM == CC_PLATFORM_IOS and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.64) or 
                (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.61) then
                HeitaoSdk.isFunctionSupported("bindingPhoneNumber");
            else
                HeitaoSdk.isFunctionSupported("updatePhoneNumber");
            end
        else
            Box("绑定手机")
        end
    end)

    self.Button_certification:onClick(function()
        if HeitaoSdk then
            if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS and tonumber(TFDeviceInfo:getCurAppVersion()) >= 3.10) or 
               (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID and tonumber(TFDeviceInfo:getCurAppVersion()) >= 3.00) then
                HeitaoSdk.isFunctionSupported("showCertificationDialog");
            else
                HeitaoSdk.doAntiAddicationQuery();
            end
        else
            Box("实名认证")
        end
    end)

    self.Button_lianxi:onClick(function()
        if HeitaoSdk then
            HeitaoSdk.isFunctionSupported("contactCustomerService");
        else
            Box("联系客服")
        end
    end)
    local serverid = ServerDataMgr:getCurrentServerID()
    if ( (HeitaoSdk and (HeitaoSdk.getplatformId() % 10000 == 101)) or (HeitaoSdk and HeitaoSdk.getplatformId() % 10000 == 173 ) or (HeitaoSdk and HeitaoSdk.getplatformId() % 10000 == 682) ) and (serverid ~= 999001) then
        self.Button_lianxi:setVisible(true);
        self.Panel_phoneBind:setVisible(true);
    else
        self.Button_lianxi:setVisible(false);
        self.Panel_phoneBind:setVisible(false);
    end

    if HeitaoSdk and (HeitaoSdk.getplatformId() % 10000 == 101 or HeitaoSdk.getplatformId() % 10000 == 173 or HeitaoSdk.getplatformId() % 10000 == 682) then
        self.Button_mima:show();
    else
        self.Button_mima:hide();
    end

    self.Button_mima:onClick(function()
        if HeitaoSdk then
            HeitaoSdk.isFunctionSupported("updatePassword");
        else
            Box("修改密码")
        end
    end)

    self.Button_change:onClick(function()
        MainPlayer:setAssist(self.selectHeroId)
        self:refreshHeroList()
        self:updateChangeBtn()
    end)

    self.Medal_change:onClick(function()
        MedalDataMgr:sendReqEquipMedal(self.selectedMedalId_)
        self.isReplaceModel_ = false
        self.selectedMedalId_ = nil
        self.Medal_change:hide()
    end)

    for k, v in pairs(self.tabBtn_) do
        v.Image_touch:onClick(function()
                self:selectTabBtn(k)
        end)
    end

    self.Image_head:setTouchEnabled(true)
    self.Image_head:onClick(function()
        --头像更换
        --local avatarView = require("lua.logic.playerInfo.AvatarChangeView"):new()
        --AlertManager:addLayer(avatarView)
        --AlertManager:show()
        Utils:openView("playerInfo.AvatarChangeView")
    end)

    self.Button_open:onClick(function()
        self:onTouchButtonOpen()
    end)

    self.Button_title:onClick(function()
        if not FunctionDataMgr:checkFuncOpen(120) then
            return
        end 
        Utils:openView("Title.TitleMainView")
    end)

    self.Button_add:onClick(function()
        Utils:openView("fairyNew.FairyEnergyUseView")
    end)

    self.Button_up:onClick(function()
        if HeroDataMgr:checkHeroMaxEnergyLevel() then
            Utils:showTips(1329144)
            return
        end
        self.lastLevel = HeroDataMgr:getHeroEnergyLevel()
        Utils:openView("fairyNew.FairyEnergyLevelUp")
    end)

    self.Button_break:onClick(function()
        if HeroDataMgr:checkHeroMaxEnergyBreak() then
            Utils:showTips(1329144)
            return
        end
        Utils:openView("fairyNew.FairyEnergyBreakUp")
    end)

    self.Button_reback:onClick(function()
        HeroDataMgr:reqOldSpiritView()
    end)

    -- self.Panel_touch:setTouchEnabled(true)
    -- self.Panel_touch:onClick(function()
    --     Utils:openView("fairyNew.FairyEnergyUseView")
    -- end)

    for i, foo in ipairs(self.attr_infos) do
        foo.root:setTouchEnabled(true)
        foo.root:onClick(function()
            Utils:openView("fairyNew.FairyEnergyUseView",{selectIdx = i})
        end)
    end
end

function PlayerSetting:openMedalIndexView()
    local layer = Utils:openView("playerInfo.MedalIndexView")
end

function PlayerSetting:onTouchSendBtn()
    print("onTouchSendBtn")
    local content = self.TextField_des:getText()
    if content and #content > 0 then
        if not MainPlayer:setDeclaration(content) then
            Utils:showTips(200006)
        end
        self.TextField_des:setText("")
    else
        -- toastMessage("发送内容不能为空")
        Utils:showTips(800104)
    end
end

function PlayerSetting:onCloseInputLayer()
    EventMgr:dispatchEvent(PlayerInfoConfig.EV_OUTPUT)
    self.TextField_des:closeIME()
    self.TextField_des:setText("")
end

function PlayerSetting:onChangeAssist()
    self.showid = MainPlayer:getAssistId()
    self:refreshLeft()
    self:refreshRight()
end

function PlayerSetting:onModifyDecEvent()
    self:refreshRight()
end

function PlayerSetting:removeUI()
    self.super.removeUI(self)

    if self.isFriend_ then
        HeroDataMgr:changeDataToSelf()
    end
end

function PlayerSetting:onAvatarUpdata()
    local redPoin = AvatarDataMgr:getRedMask()
    self.Image_avatar_new:setVisible(redPoin)

    local iconPath = AvatarDataMgr:getSelfAvatarIconPath()
    self.Image_head:setTexture(iconPath)
    self.Image_head:setSize(CCSizeMake(98, 98))
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath()
    self.Image_head_cover_frame:setTexture(avatarFrameIcon)
    if avatarFrameEffect ~= "" then
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
        if not self.HeadFrameEffect then
            self.HeadFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
            self.HeadFrameEffect:setAnchorPoint(ccp(0,0))
            self.HeadFrameEffect:setPosition(ccp(0,0))
            self.HeadFrameEffect:play("animation", true)
            self.Image_head_cover_frame:addChild(self.HeadFrameEffect, 1)
        end
    else
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
    end
end


return PlayerSetting
