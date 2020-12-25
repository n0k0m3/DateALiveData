local AngelInfo = class("AngelInfo", BaseLayer)

local SKILL_PAGE_TYPE = {
    SKILL_TREE      = 1, --技能树页面
    PASSIVE_SKILL   = 2, --被动技能页面
}

-- local NOT_UNLOCK_TIPS = {
--     [10240001] = TextDataMgr:getText(450047),  
--     [10240002] = TextDataMgr:getText(450023),   
--     [10240003] = TextDataMgr:getText(450048),
--     [10240004] = TextDataMgr:getText(800031),   
-- }

function AngelInfo:ctor(data)
    self.super.ctor(self,data)
    -- self.skillid = data.skillid;
    -- self.heroid  = data.heroid;
    -- self.isfriend = data.isfriend;
    -- self.backTag = data.backTag

    dump(data)
    self.paramData_ = data
    self.heroid = data.heroid

    self.skillType = data.skillType

    self.skillId   = data.skillid

    self.showPageType = 0

    self.curAngleSkillItem = nil

    self.curAngleSkill = nil

    self.curPassiveSkillItem = nil

    self.curPassiveSkill = nil

    self.isShowFullSkill = false

    self.isPass = data.isPass

    self.isfriend = data.isfriend
    self.notAction = data.notAction

    self.enterWithWhichSlot = data.whichSlot

    self.lastUseSkillStrategy = data.lastUseSkillStrategy

    self:init("lua.uiconfig.angelNew.angelInfo")
    self:showTopBar();
end

function AngelInfo:getClosingStateParams()
    local data = clone(self.paramData_)
    data.skillType = self.skillType
    data.skillid = self.skillId
    data.showPageType = self.showPageType
    data.isfriend = self.isfriend
    data.lastUseSkillStrategy = self.lastUseSkillStrategy
    return {data}
end

function AngelInfo:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    AngelInfo.ui = ui

    self.Panel_left         = TFDirector:getChildByPath(ui, "Panel_left")
    self.Panel_right        = TFDirector:getChildByPath(ui, "Panel_right")
    self.Panel_angel_tree_page   = TFDirector:getChildByPath(ui, "Panel_angel_tree")
    self.Panel_passive_skill_page= TFDirector:getChildByPath(ui, "Panel_passive_skill")
    self.Panel_gem_view = TFDirector:getChildByPath(ui, "Panel_gem_view"):hide()


    local angelTreeUiCfg    = string.format("lua.uiconfig.angelNew.%s",AngelDataMgr:getAngelTreeUiCfg(self.heroid));
    self.Panel_skill        = createUIByLuaNew(angelTreeUiCfg)
    self.Panel_skill        = TFDirector:getChildByPath(self.Panel_skill, "Panel_base")
    self.Panel_Clip        = TFDirector:getChildByPath(self.Panel_left, "Panel_angelClip")
    self.Panel_skill:removeFromParent()
    self.Panel_skill:setContentSize(CCSizeMake(self.Panel_skill:getContentSize().width, self.Panel_skill:getContentSize().height - 300))
    self.tmpPos = ccp(self.Panel_skill:getPosition())
    self.Panel_skill:setPosition(0,0)
    -- self.Panel_skill:setScale(0.5)
    
    self.PanelMulTouch      = TFMultiTouchPanel:create(self.Panel_left:getContentSize(), self.Panel_skill:getContentSize())
    self.PanelMulTouch:addChild(self.Panel_skill)
    me.Director:setSingleEnabled(false)    
    self.Panel_angel_tree_page:addChild(self.PanelMulTouch,1,1)

    self.PanelMulTouchInnerContainer = self.Panel_skill
    self.PanelMulTouchInnerContainer:setPosition(self.tmpPos)

    self.Panel_skill = TFDirector:getChildByPath(self.Panel_skill, "Image_Angle_skill_1")
    self.Panel_skill:setTouchEnabled(true);

    self.Panel_passive_skill_base = createUIByLuaNew("lua.uiconfig.angelNew.angle_passive_skill")
    self.Panel_passive_skill_base= TFDirector:getChildByPath(self.Panel_passive_skill_base, "Panel_base")
    self.Panel_passive_skill_base:removeFromParent()
    self.Panel_passive_skill_page:addChild(self.Panel_passive_skill_base)
    self.Panel_passive_skill = TFDirector:getChildByPath(self.Panel_passive_skill_base, "Panel_skills")
    self.Panel_passive_skill_slot = TFDirector:getChildByPath(self.Panel_passive_skill_base, "Panel_skill_slot")

    self.Panel_angelskill_info = TFDirector:getChildByPath(self.Panel_right, "Panel_angelskill_info")
    self.Panel_passiveskill_info = TFDirector:getChildByPath(self.Panel_right, "Panel_passiveskill_info")
    self.ListView_skill_level  = TFDirector:getChildByPath(self.Panel_right, "ScrollView_level")
    --self.ListView_skill_level:setItemsMargin(5)

    self.ListView_angle_skill_desc = UIListView:create(TFDirector:getChildByPath(self.Panel_angelskill_info, "ScrollView_desc"))
    self.ListView_angle_skill_desc:setItemsMargin(3)
    self.ListView_passive_skill_desc = UIListView:create(TFDirector:getChildByPath(self.Panel_passiveskill_info, "ScrollView_desc"))

    self.ListView_gem_skill_desc = UIListView:create(TFDirector:getChildByPath(self.Panel_gem_view, "ScrollView_desc"))

    self.Button_angle_tree  = TFDirector:getChildByPath(self.Panel_right, "Button_angle_tree")
    self.Button_passive_skill = TFDirector:getChildByPath(self.Panel_right, "Button_passive_skill")
    self.Button_view  = TFDirector:getChildByPath(self.Panel_gem_view, "Button_view")

    self.Button_sub_skill_level = TFDirector:getChildByPath(self.Panel_right, "Button_sub_skill_level")
    self.Button_add_skill_level = TFDirector:getChildByPath(self.Panel_right, "Button_add_skill_level")
    self.Button_load_skill      = TFDirector:getChildByPath(self.Panel_right, "Button_load_skill")
    self.Button_change      = TFDirector:getChildByPath(self.Panel_right, "Button_change")
    self.Button_unload_skill    = TFDirector:getChildByPath(self.Panel_right, "Button_unload_skill")
    self.Button_angle_tab       = TFDirector:getChildByPath(self.Panel_left, "Button_angle_tab")
    self.Button_show_full_screen = TFDirector:getChildByPath(self.Panel_left, "Button_show_full_screen")

    self.Label_cur_angletab_name = TFDirector:getChildByPath(self.Button_angle_tab, "Label_cur_angletab_name")
    self.Label_points = TFDirector:getChildByPath(self.Button_angle_tab, "Label_points")

    self.Image_skill_point_bg = TFDirector:getChildByPath(self.Panel_right, "Image_skill_point_bg")
    self.Label_skill_point_use  = TFDirector:getChildByPath(self.Panel_right, "Label_skill_point_use")
    self.Label_slotLock = TFDirector:getChildByPath(self.Panel_right, "Label_slotLock")
    self.Image_skill_select = TFImage:create("ui/fairy_angle/022.png")
    self.Panel_skill:addChild(self.Image_skill_select)
    self.Image_passvie_skill_select = TFImage:create("ui/fairy_angle/new_76.png")
    self.Image_passvie_skill_select:setScale(1.5)

    --self.Image_passvie_skill_select:setPosition(ccp(-200, 200))
    self.Panel_passive_skill:addChild(self.Image_passvie_skill_select)
    self.Image_passvie_skill_select:setVisible(false)
    self.Image_passvie_skill_slot_select = TFImage:create("ui/fairy_angle/007.png")
    self.Panel_passive_skill_slot:addChild(self.Image_passvie_skill_slot_select)

    self.Label_desc_item = TFDirector:getChildByPath(ui, "Label_desc_item")
    self.Label_desc_item:setVisible(false)

    self.Label_desc_itemGray = TFDirector:getChildByPath(ui, "Label_desc_itemGray")
    self.Label_desc_itemGray:setVisible(false)

    self.mainIcons = {}
    for i=1, 7 do
        local mainIcon = TFDirector:getChildByPath(self.Panel_skill, "Icon_main_0"..i)
        local skillType= mainIcon:getTag()
        self.mainIcons[skillType] = mainIcon
    end
    self.skillIcons = {}
    for i=1, 200 do
        local icon     = TFDirector:getChildByPath(self.Panel_skill, "icon_"..i)
        if icon then
            local pos      = icon:getTag()
            self.skillIcons[pos] = icon
            icon:setVisible(false)
        end
    end

    self.passiveSkillIcons = {}
    for i=1, 16 do
        local icon = TFDirector:getChildByPath(self.Panel_passive_skill, "Image_skill_"..i)
        self.passiveSkillIcons[i] = icon
        icon:setScale(0.65)
        icon:setVisible(false)
    end

    self.passiveSkillSlots = {}
    for i=1, 4 do
        local icon = TFDirector:getChildByPath(self.Panel_passive_skill_slot, "Image_skill_slot_"..i)
        self.passiveSkillSlots[i] = icon
    end

    self:initNativeLanguage()

    self:updateSkillPointInfo()

    self:updateCurrAngleTabName()

    self:initAllSkillInfo()

    self:initAngleSkillLines()

    if self.paramData_.showPageType then
        self:changeShowPage(self.paramData_.showPageType)
    else
        if self.isPass then
            self:changeShowPage(SKILL_PAGE_TYPE.PASSIVE_SKILL)
        else
            self:changeShowPage(SKILL_PAGE_TYPE.SKILL_TREE)
        end
    end

    
end

function AngelInfo:registerEvents()
    EventMgr:addEventListener(self, EV_HERO_ANGLE_USE_TAB, handler(self.onUseAngleTab, self))
    EventMgr:addEventListener(self, EV_HERO_ANGLE_UPGRADE_SKILL, handler(self.onUpgradeSkill, self))
    EventMgr:addEventListener(self, EV_HERO_ANGLE_LOAD_PASSIVE_SKILL, handler(self.onLoadPassiveSkill, self))
    EventMgr:addEventListener(self, EV_HERO_ANGLE_CHANGE_TAB_NAME, handler(self.onChangeTabName, self))
    -- if self.isfriend == true and self.backTag == "teamFight" then
    --     -- self.topLayer.Button_main:setTexture("ui/cc.png")
    --     self:setMainBtnCallback(function()
    --             TeamFightDataMgr:openTeamView()
    --         end)
    -- end

    self.Button_angle_tab:onClick(function()
        local layer = require("lua.logic.angelNew.AngelTabLayer"):new({heroId=self.heroid})
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)
    self.Button_angle_tree:onClick(function()
        self:changeShowPage(SKILL_PAGE_TYPE.SKILL_TREE)

            local icon = self.mainIcons[6]

            local skillInfo = TabDataMgr:getData("Skill", icon.skillId)
            self.curAngleSkillItem = icon 
            local tmpSkillInfo = {
            icon = skillInfo.icon,
            skillType = skillInfo.skillType,
            nameId = skillInfo.name,
            tips1 = skillInfo.des,
            tips2 = skillInfo.des,
            isMainSkill = true,        
            video = skillInfo.video        
        }
        self.curAngleSkill = tmpSkillInfo
        self:updateAngleSkillDetailsInfo()

        self.Image_skill_select:retain()
        self.Image_skill_select:removeFromParent()
        icon:addChild(self.Image_skill_select,0,0)
        self.Image_skill_select:release()

    end)
    self.Button_passive_skill:onClick(function()

        
        self:changeShowPage(SKILL_PAGE_TYPE.PASSIVE_SKILL)
    end)
    self.Button_sub_skill_level:onClick(function()
        --技能降级前 要去扫描后置技能是否都为0级，否则不能降级
        for i, skillId in ipairs(self.curAngleSkill.PostPositionSkill) do
            local skillConfig = AngelDataMgr:getAngleConfig(skillId)
            local curLevel = AngelDataMgr:getSkillLevel(skillConfig.heroId, skillConfig.skillType, skillConfig.pos)
            if curLevel > 0 then
                toastMessage(TextDataMgr:getText(450026,TextDataMgr:getText(skillConfig.nameId)))
                return
            end
        end
        AngelDataMgr:doReqUpgradeSkill(self.heroid, self.curAngleSkill.skillType, self.curAngleSkill.position, 2)
    end)
    self.Button_add_skill_level:onClick(function()
        if self.Button_add_skill_level.errCode < 0 then
            local errCode = self.Button_add_skill_level.errCode
            local errTips = self.Button_add_skill_level.errTips
            local strTips = ""
            if errCode == -4 then
                strTips = TextDataMgr:getText(450021)
            elseif errCode == -1 then
                strTips = TextDataMgr:getText(450022,errTips)
            elseif errCode == -2 then
                strTips = TextDataMgr:getText(450023,errTips)
            elseif errCode == -3 then
                strTips = TextDataMgr:getText(450024,TextDataMgr:getText(errTips.nameId),errTips.lvl)
            end
            toastMessage(strTips)
            return
        end
        AngelDataMgr:doReqUpgradeSkill(self.heroid, self.curAngleSkill.skillType, self.curAngleSkill.position, 1)
    end)
    self.Button_load_skill:onClick(function()
        local state = self.Button_load_skill.state
        if state == 0 then
            AngelDataMgr:doReqEquipPassiveSkill(self.heroid, self.curPassiveSkill.id, self.clickSlotPos)
            return
        end
        if state == -1 then
            Utils:showTips(450027)
        elseif state == -2 then
            Utils:showTips(450028)
        end
    end)
    self.Button_change:onClick(function()
       
        AngelDataMgr:doReqEquipPassiveSkill(self.heroid, self.curPassiveSkill.id, self.clickSlotPos)
           
    end)
    self.Button_unload_skill:onClick(function()
        AngelDataMgr:doReqEquipPassiveSkill(self.heroid, self.curPassiveSkill.id)
    end)

    for k, icon in pairs(self.mainIcons) do
        icon:setTouchEnabled(true)
        icon:onClick(function()
            self:showMainSkillInfo(icon.skillId,icon)
        end)    
    end

    self.Button_show_full_screen:onClick(function()
        self:changeShowAngleSkillFullScreen()
    end)

    self.Button_view:onClick(function()
        if self.gemPos then
            local gemInfo = HeroDataMgr:getGemInfoByPos(self.heroid, self.gemPos)
            Utils:openView("fairyNew.BaoshiDetailView", {id = gemInfo.id, cid = gemInfo.cid, heroId = self.heroid,pos = self.gemPos,fromBag = true})
        end
    end)
end

function AngelInfo:initAllSkillInfo()
    self:initSkillUI()

    self:initPassiveSkillUI()
end

function AngelInfo:initSkillUI()
    local skillTypes = {EC_SKILL_TYPE.NORMAL, EC_SKILL_TYPE.SKILL_1, EC_SKILL_TYPE.SKILL_2, 
        EC_SKILL_TYPE.BISHA, EC_SKILL_TYPE.SHANBI, EC_SKILL_TYPE.JUEXING, EC_SKILL_TYPE.QIEHUAN}
    for i, skillType in pairs(EC_SKILL_TYPE) do
        if skillType < 8 then
            local icon = self.mainIcons[skillType]
            local skillid = HeroDataMgr:getSkinAngleSkillID(self.heroid,skillType)
            if skillid then
                local skillInfo = TabDataMgr:getData("Skill",skillid)
                icon.skillId = skillid
                icon.skillType = skillType        

                local Image_Angle_skill_icon = TFDirector:getChildByPath(icon, "Image_Angle_skill_icon")
                Image_Angle_skill_icon:setTexture(skillInfo.icon)
                local Label_Angle_skill_1 = TFDirector:getChildByPath(icon, "Label_Angle_skill_1")
                Label_Angle_skill_1:setTextById(EC_Angel_Type_Name_Id[skillType])

                if self.skillType == skillType then
                    self.curAngleSkillItem = icon
                    self:showMainSkillInfo(self.skillId, icon)
                end
            end
        end
    end

    local heroAngleConfig = AngelDataMgr:getAngleBaseData(self.heroid)
    for skillType, points in pairs(heroAngleConfig) do
        if skillType ~= EC_SKILL_TYPE.BEIDONG then --排除被动技能
            for pos, levels in pairs(points) do
                local showPos = AngelDataMgr:getOneTalentShowId(levels[1])
                local tag = skillType * 100 + showPos
                print("tag:"..tag)
                if self.skillIcons[tag] then
                    self:updateSkillItemInfo(self.skillIcons[tag], self.heroid, skillType, pos)
                    self.skillIcons[tag]:setVisible(true)
                end
            end
        end
    end

    local gemAngelPosSkill = HeroDataMgr:getGemAngelTypeSkills(self.heroid)
    local StoneAngel = TabDataMgr:getData("StoneAngel")
    local gemAngelCfg
    for k, v in pairs(StoneAngel) do
        if v.heroId == self.heroid then
            gemAngelCfg = v
            break
        end
    end
    for skillType, typeSkill in pairs(gemAngelPosSkill) do
        for i, v in ipairs(typeSkill) do
            local tag = gemAngelCfg["skillType"..skillType.."Angel"][i]
            if tag and self.skillIcons[tag] then
                self:updateGemSkillItemInfo(self.skillIcons[tag], self.heroid, v, tonumber(skillType))
                self.skillIcons[tag]:setVisible(true)
            end
        end
    end
end

function AngelInfo:updateGemSkillItemInfo(item, heroid, skillId, pos)
    local config = TabDataMgr:getData("PassiveSkills",skillId)
    local skillIcon = TFDirector:getChildByPath(item, "Image_Angle_skill_icon")
    skillIcon:setTexture(config.icon)

    local Label_Angle_skill_level = TFDirector:getChildByPath(item, "Label_Angle_skill_level")
    Label_Angle_skill_level:setVisible(false)
    Label_Angle_skill_level:setVisible(false)

    local spineEffect = SkeletonAnimation:create("effect/stone_skill/stone_skill")
    spineEffect:setAnimationFps(30) 
    item:addChild(spineEffect)
    spineEffect:playByIndex(0, -1, -1, 1)


    item:setTouchEnabled(true)
    item:onClick(function()
        self.curAngleSkillItem = item
        self.curAngleSkill = config
        self.gemPos = pos
        self.Image_skill_select:retain()
        self.Image_skill_select:removeFromParent()
        item:addChild(self.Image_skill_select,0,-1)
        self.Image_skill_select:release()


        self:updateGemAngleSkillDetailsInfo(pos)
        if self.isShowFullSkill then
            self:changeShowAngleSkillFullScreen(item)
        else
            self:moveSkillItemInMid(item)
        end
    end)
end

function AngelInfo:updateSkillItemInfo(item, heroid, skillType, pos)
    local curLevel = AngelDataMgr:getSkillLevel(heroid, skillType, pos)
    curLevel = curLevel>0 and curLevel or 1
    local configId = AngelDataMgr:getAngleBaseData(heroid, skillType, pos, curLevel)
    local configData = AngelDataMgr:getAngleConfig(configId)
    self:initOneSkillItem(item, configData)
end

function AngelInfo:initPassiveSkillUI()
    local heroPassiveConfig = AngelDataMgr:getPassiveSkillConfig(self.heroid)
    for i=1, 16 do
        local config = heroPassiveConfig[i]
        local item   = self.passiveSkillIcons[config.pos_position]
        self:initOnePassiveSkillItem(item, config)
        -- if i==1 then
        --     self:selectPassiveSkillItem(item)
        -- end
    end
    self:updatePassiveSkillSlots()
end

function AngelInfo:updatePassiveSkillSlots()
    for i=1, 4 do
        local data = AngelDataMgr:getHeroCurrUsePassiveSkillData(self.heroid, i)
        local item = self.passiveSkillSlots[i]
        self:initOnePassiveSkillSlot(item, data, i)
        -- if item.isUnlock and not item.isHaveLoadSkill then
        --     self.curPassiveSkillSlotItem = item
        --     self.curPassiveSkillSlotIndex = i
        --     -- if item.data then
        --     --     self.curPassiveSkill   = item.data
        --     -- end
        -- end
    end
    self.Image_passvie_skill_slot_select:setVisible(false)
end

function AngelInfo:initOneSkillItem(item, config)
    item.data = config

    if config.Frame and config.Frame~="" then
        item:setTexture(config.Frame)
    end

    local skillIcon = TFDirector:getChildByPath(item, "Image_Angle_skill_icon")
    skillIcon:setTexture(config.icon)

    local curLevel = AngelDataMgr:getSkillLevel(config.heroId, config.skillType, config.pos)
    local maxLevel = AngelDataMgr:getSkillMaxLevel(config.heroId, config.skillType, config.pos)
    local nextLv = curLevel+1 < maxLevel and curLevel+1 or maxLevel

    --是否解锁这个位置的技能，只需要去判断第1级是否解锁就可以了
    local oneLvSkillId = AngelDataMgr:getAngleBaseData(config.heroId, config.skillType, config.pos, 1)
    local isUnlock = AngelDataMgr:getIsUnlockSkill(oneLvSkillId, {constTrue = self.notAction,heroid = config.heroId,skillType = config.skillType,pos = config.pos})

    local Label_Angle_skill_level = TFDirector:getChildByPath(item, "Label_Angle_skill_level")
    Label_Angle_skill_level:setString(curLevel.."/"..maxLevel)
    Label_Angle_skill_level:setVisible(isUnlock)

    local imgLock  = TFDirector:getChildByPath(item, "Image_lock")
    if imgLock then
        if imgLock:isVisible() and isUnlock then
            local effect = SkeletonAnimation:create("effect/effect_heroGrow_ui9/effect_heroGrow_ui9")
            effect:setAnimationFps(GameConfig.ANIM_FPS) 
            item:addChild(effect)
            effect:playByIndex(0, -1, -1, 0) 
            effect:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
            _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
            _skeletonNode:removeFromParent()   
            end)
        end
        imgLock:setVisible(not isUnlock)

    else
        if not isUnlock then
            imgLock = TFImage:create("ui/fairy/new_ui/new_03.png")
            imgLock:setName("Image_lock")
            item:addChild(imgLock,3,10)
        end
    end
    
    Utils:setNodeGray(item, not isUnlock)   

    item:setTouchEnabled(true)
    item:onClick(function()
        self.gemPos = nil
        self.curAngleSkillItem = item
        self.curAngleSkill = config
        self.Image_skill_select:retain()
        self.Image_skill_select:removeFromParent()
        item:addChild(self.Image_skill_select,0,0)
        self.Image_skill_select:release()
        -- self.Image_skill_select:setPosition(item:getPosition())
        self:updateAngleSkillDetailsInfo()
        if self.isShowFullSkill then
            self:changeShowAngleSkillFullScreen(item)
        else
            self:moveSkillItemInMid(item)
        end
    end)
end

function AngelInfo:initOnePassiveSkillItem(item, config)
    item.data = config
    item:setVisible(true)

    -- local Image_skill_icon  = TFDirector:getChildByPath(item, "Image_skill_icon")
    item:setTexture(config.icon)

    local isUnlock = AngelDataMgr:getIsUnlockSkill(config.id, {constTrue = self.notAction,heroid = config.heroId,skillType = config.skillType,pos = config.pos})

    local Image_state = TFDirector:getChildByPath(item, "Image_select")
    Image_state:setVisible(false)

    local isLoadPassiveSkill = AngelDataMgr:getIsLoadPassiveSkill(config.heroId, config.id)
    if isUnlock and isLoadPassiveSkill then
        Image_state:setVisible(true)
        Image_state:setScale(1.5)
        Image_state:setTexture("ui/fairy_angle/009.png")
    end

    -- local Image_unlock = TFDirector:getChildByPath(item, "Image_unlock")
    -- if Image_unlock then Image_unlock:setVisible(false) end
    
    -- if isUnlock and (not isLoadPassiveSkill) then
    --     if Image_unlock then

    --         Image_unlock:setVisible(true)
    --         Image_unlock:setScale(1.5)
    --         Image_unlock:setTexture("ui/fairy_angle/unlock.png")
    --     end
    -- end

    local imgLock  = TFDirector:getChildByPath(item, "Image_lock")
    if imgLock then
        imgLock:setVisible(not isUnlock)
    else
        if not isUnlock then
            imgLock = TFImage:create("ui/fairy/new_ui/new_03.png")
            imgLock:setName("Image_lock")
            item:addChild(imgLock,3,10)
        end
    end
    Utils:setNodeGray(item, not isUnlock)

    item:onClick(function()
        self:selectPassiveSkillItem(item)

    end)
end

function AngelInfo:initOnePassiveSkillSlot(item, data, idx)
    item.data = data
    
    local isHaveLoadSkill = AngelDataMgr:getIsLoadPassiveSkillByPos(self.heroid, idx)
    local isUnlock,unlockLevel = AngelDataMgr:getIsUnlockPassiveSkillSlot(self.heroid, idx)

    item.isHaveLoadSkill = isHaveLoadSkill
    item.isUnlock = isUnlock

    local config = nil
    if isHaveLoadSkill then
        config = AngelDataMgr:getAngleConfig(data.skillId)
    end

    local Image_skill_icon = TFDirector:getChildByPath(item, "Image_skill_icon")
    Image_skill_icon:setVisible(isHaveLoadSkill)
    if isHaveLoadSkill then
        Image_skill_icon:setTexture(config.icon)
    end

    -- Utils:setNodeGray(item, not isUnlock)

    local Image_lock = TFDirector:getChildByPath(item, "Image_angle_passive_skill_1")
    Image_lock:setVisible(not isUnlock)

    -- local imgLock  = TFDirector:getChildByPath(item, "Image_lock")
    -- if imgLock then
    --     imgLock:setVisible(not isUnlock)
    -- else
    --     if not isUnlock then
    --         imgLock = TFImage:create("ui/common/lock.png")
    --         imgLock:setName("Image_lock")
    --         item:addChild(imgLock,3,3)
    --     end
    -- end
    local Label_unlock_level = TFDirector:getChildByPath(self.Label_slotLock, "Label_unlockLevel")
    Label_unlock_level:setString(unlockLevel)
    --Label_unlock_level:setZOrder(4)

    local Label_Add = TFDirector:getChildByPath(item, "Image_AddIcon")
    if not isHaveLoadSkill and isUnlock then
        Label_Add:setVisible(true)
        local actions =
        {   FadeTo:create(2,235),
            FadeTo:create(2,20)
        }
        local breath = CCRepeatForever:create(Sequence:create(actions))
        Label_Add:runAction(breath)
    else
        Label_Add:setVisible(false)
    end

    
    
    
    --item:setTouchEnabled(isUnlock)
    item:onClick(function()       
        self.clickSlotPos = idx
       -- self:clickOneSlot(item, isHaveLoadSkill, idx)

        local Label_Loaded = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_Loaded")
        local Image_skill_bg = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_bg")
        local Image_skill_bg2 = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_NoSkill")
        local Label_slot_lock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_slot_lock_tips")

        self.Image_passvie_skill_slot_select:retain()
        self.Image_passvie_skill_slot_select:removeFromParent()
        item:addChild(self.Image_passvie_skill_slot_select,0,0)
        self.Image_passvie_skill_slot_select:release()
        self.Image_passvie_skill_slot_select:setVisible(true)

        if isHaveLoadSkill then

            for i=1, 16 do
                local data = AngelDataMgr:getHeroCurrUsePassiveSkillData(self.heroid, idx)
                local item = self.passiveSkillIcons[i]
                if item and data and data.skillId ==  item.data.id then 
                    self.curPassiveSkillItem = item
                    self.curPassiveSkill = item.data
                end
            end

            self.Image_passvie_skill_select:retain()
            self.Image_passvie_skill_select:removeFromParent()
            Label_Loaded:setVisible(true)
            Image_skill_bg:setVisible(true)
            Image_skill_bg2:setVisible(false)
            Label_slot_lock_tips:setVisible(false)
            self.Label_slotLock:setVisible(false)
            
            self:updatePassiveSkillDetailsInfo()
            self.Button_unload_skill:setVisible(true)
            self.slotCondition = 1
        elseif isUnlock then
            self.Image_passvie_skill_select:retain()
            self.Image_passvie_skill_select:removeFromParent()
            Label_Loaded:setVisible(false)            
            Image_skill_bg:setVisible(false)
            Image_skill_bg2:setVisible(true)
            Label_slot_lock_tips:setVisible(false)
            self.Label_slotLock:setVisible(false)
            self.Button_unload_skill:setVisible(false)
            self.Button_change:setVisible(false)
            self.Button_load_skill:setVisible(false)
            local Label_unlock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_unlock_tips")
            Label_unlock_tips:setVisible(false)
            self.slotCondition = 2
        else
            local Label_unlock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_unlock_tips")
            Label_unlock_tips:setVisible(false)
            self.Image_passvie_skill_select:retain()
            self.Image_passvie_skill_select:removeFromParent()
            Label_Loaded:setVisible(false)
            Image_skill_bg:setVisible(false)
            Image_skill_bg2:setVisible(false)
            Label_slot_lock_tips:setVisible(false)
            self.Label_slotLock:setVisible(true)

            local isUnlock,unlockLevel = AngelDataMgr:getIsUnlockPassiveSkillSlot(self.heroid, idx)
            local Label_unlock_level = TFDirector:getChildByPath(self.Label_slotLock, "Label_unlockLevel")
            Label_unlock_level:setString(unlockLevel)   

            self.Button_unload_skill:setVisible(false)
            self.Button_load_skill:setVisible(false)
            self.Button_change:setVisible(false)


            Label_Loaded:setVisible(false)
            self.slotCondition = 3 
        end

        if self.notAction then
            self.Button_load_skill:hide()
            self.Button_unload_skill:hide()
            self.Button_change:hide()
        end
    end)
    
end

function AngelInfo:clickWhichSlot(idx)
    self.Panel_right:show()
    self.Panel_gem_view:hide()
    self.clickSlotPos = idx
    for i=1, 16 do
        local data = AngelDataMgr:getHeroCurrUsePassiveSkillData(self.heroid, idx)
        local item = self.passiveSkillIcons[i]
        if item and data and data.skillId ==  item.data.id then 
            self.curPassiveSkillItem = item
            self.curPassiveSkill = item.data
            --self:selectPassiveSkillItem(item)
        end
    end
    self.Image_passvie_skill_slot_select:retain()
    self.Image_passvie_skill_slot_select:removeFromParent()
    self.passiveSkillSlots[idx]:addChild(self.Image_passvie_skill_slot_select,0,0)
    self.Image_passvie_skill_slot_select:release()
    self.Image_passvie_skill_slot_select:setVisible(true)
    local isHaveLoadSkill = AngelDataMgr:getIsLoadPassiveSkillByPos(self.heroid, idx)
    local isUnlock,unlockLevel = AngelDataMgr:getIsUnlockPassiveSkillSlot(self.heroid, idx)
    local Label_Loaded = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_Loaded")
    local Image_skill_bg = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_bg")
    local Image_skill_bg2 = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_NoSkill")
    local Label_slot_lock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_slot_lock_tips")

    if isHaveLoadSkill then
        self.slotCondition = 1
        self:updatePassiveSkillDetailsInfo() 
        self.Button_unload_skill:setVisible(true)

    elseif isUnlock then
        self.slotCondition = 2
        self.Image_passvie_skill_select:retain()
        self.Image_passvie_skill_select:removeFromParent()
        Label_Loaded:setVisible(false)            
        Image_skill_bg:setVisible(false)
        Image_skill_bg2:setVisible(true)
        Label_slot_lock_tips:setVisible(false)
        self.Label_slotLock:setVisible(false)

    else
        local Label_unlock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_unlock_tips")
        Label_unlock_tips:setVisible(false)
        self.Image_passvie_skill_select:retain()
        self.Image_passvie_skill_select:removeFromParent()
        Label_Loaded:setVisible(false)
        Image_skill_bg:setVisible(false)
        Image_skill_bg2:setVisible(false)
        --Label_slot_lock_tips:setVisible(true)
        self.Label_slotLock:setVisible(true)
        local isUnlock,unlockLevel = AngelDataMgr:getIsUnlockPassiveSkillSlot(self.heroid, idx)
        local Label_unlock_level = TFDirector:getChildByPath(self.Label_slotLock, "Label_unlockLevel")
        Label_unlock_level:setString(unlockLevel)


        --修改技能数文本显示
        local lable_unlock_info_1 = TFDirector:getChildByPath(self.Label_slotLock, "Label_angelInfo_1")
        local lable_unlock_info_2 = TFDirector:getChildByPath(self.Label_slotLock, "Label_angelInfo_2")

        Label_unlock_level:hide()
        lable_unlock_info_2:hide()
        lable_unlock_info_1:setTextById(190000044 , unlockLevel)

        --

        Label_Loaded:setVisible(false)
    end

    
    if self.notAction then
        self.Button_load_skill:hide()
        self.Button_unload_skill:hide()
        self.Button_change:hide()
    end
end

function AngelInfo:selectPassiveSkillItem(item)    
    self.curPassiveSkillItem = item
    self.curPassiveSkill   = item.data
    self:updatePassiveSkillDetailsInfo()
    self.Image_passvie_skill_select:retain()
    self.Image_passvie_skill_select:removeFromParent()
    item:addChild(self.Image_passvie_skill_select,-1,0)
    self.Image_passvie_skill_select:release()
    self.Image_passvie_skill_select:setVisible(true)
    --self.Image_passvie_skill_slot_select:setVisible(false)
    
    
    -- for i=1, 4 do
    --     local data = AngelDataMgr:getHeroCurrUsePassiveSkillData(self.heroid, i)
    --     local itemSlot = self.passiveSkillSlots[i]
    --     if itemSlot and data and data.skillId ==  item.data.id then 
    --         self.Image_passvie_skill_slot_select:retain()
    --         self.Image_passvie_skill_slot_select:removeFromParent()
    --         itemSlot:addChild(self.Image_passvie_skill_slot_select,0,0)
    --         self.Image_passvie_skill_slot_select:release()
    --         self.Image_passvie_skill_slot_select:setVisible(true)
    --     end
    -- end
end

function AngelInfo:updateGemAngleSkillDetailsInfo(pos)
    self.Panel_right:hide()
    self.Panel_gem_view:show()
    local config = self.curAngleSkill

    if not config then
        return
    end

    local Image_skill_icon = TFDirector:getChildByPath(self.Panel_gem_view, "Image_skill_icon")
    Image_skill_icon:setTexture(config.icon)

    local Label_gem_name = TFDirector:getChildByPath(self.Panel_gem_view, "Label_gem_name")
    local gemInfo = HeroDataMgr:getGemInfoByPos(self.heroid, pos)
    local cfg = EquipmentDataMgr:getGemCfg(gemInfo.cid)
    Label_gem_name:setTextById(tonumber(cfg.nameTextId))

    local Label_skill_name = TFDirector:getChildByPath(self.Panel_gem_view, "Label_skill_name")
    Label_skill_name:setTextById(tonumber(config.name))

    self.ListView_gem_skill_desc:removeAllItems()
    local size = self.ListView_gem_skill_desc:getContentSize()
    local Label_content = self.Label_desc_item:clone():Show()

    local gemInfo = HeroDataMgr:getGemInfoByPos(self.heroid, self.gemPos)
    local cfg = EquipmentDataMgr:getGemCfg(gemInfo.cid)
    local skillDesc = TextDataMgr:getTextAttr(tonumber(config.des)).text
    skillDesc = string.gsub(skillDesc, "#", TextDataMgr:getText(cfg.skillName))
    Label_content:setText(skillDesc)
    Label_content:setDimensions(size.width, 0)
    self.ListView_gem_skill_desc:pushBackCustomItem(Label_content)
end

function AngelInfo:updateAngleSkillDetailsInfo()
    self.Panel_right:show()
    self.Panel_gem_view:hide()
    local config = self.curAngleSkill

    if not config then
        return
    end
    local curLevel = 0
    local maxLevel = 0
    local nextLevel= 0
    if not config.isMainSkill then
        curLevel = AngelDataMgr:getSkillLevel(config.heroId, config.skillType, config.pos)
        maxLevel = AngelDataMgr:getSkillMaxLevel(config.heroId, config.skillType, config.pos)
        nextLevel = curLevel+1 < maxLevel and curLevel+1 or maxLevel
        local showInfoLevel = curLevel<=0 and 1 or curLevel
        showInfoLevel = showInfoLevel>=maxLevel and maxLevel or showInfoLevel
        local skillId       = AngelDataMgr:getAngleBaseData(config.heroId, config.skillType, config.pos, showInfoLevel)
        config = AngelDataMgr:getAngleConfig(skillId)
        self.curAngleSkill = config
    end
    local isUnlockPos = true      --是否解锁这个位置的技能
    local notUnlockPosCode = nil
    local notUnlockPosTips = ""

    local isUnlockNextLv = true   --是否解锁下一等级的技能
    local notUnlockNextLvCode = nil
    local notUnlockNextLvTips = ""

    local nextLvSkillId = nil

    if not config.isMainSkill then
        --是否解锁此位置的技能，只需要判断第1级是否解锁就可以了。
        local oneLvSkillId = AngelDataMgr:getAngleBaseData(config.heroId, config.skillType, config.pos, 1)
        isUnlockPos,notUnlockPosCode,notUnlockPosTips = AngelDataMgr:getIsUnlockSkill(oneLvSkillId, {constTrue = self.notAction,heroid = config.heroId,skillType = config.skillType,pos = config.pos})

        nextLvSkillId = AngelDataMgr:getAngleBaseData(config.heroId, config.skillType, config.pos, nextLevel)
        isUnlockNextLv,notUnlockNextLvCode,notUnlockNextLvTips = AngelDataMgr:getIsUnlockSkill(nextLvSkillId, {constTrue = self.notAction,heroid = config.heroId,skillType = config.skillType,pos = config.pos})
    end

    local Image_skill_icon = TFDirector:getChildByPath(self.Panel_angelskill_info, "Image_skill_icon")
    Image_skill_icon:setTexture(config.icon)

    local Label_unlcok_pos = TFDirector:getChildByPath(self.Panel_angelskill_info, "Label_unlock_pos")
    Label_unlcok_pos:setString(isUnlockPos and "" or TextDataMgr:getText(450010))
    local Label_Level = TFDirector:getChildByPath(self.Panel_angelskill_info, "Label_Level")
    Label_Level:setText(curLevel)
    Label_Level:setVisible(isUnlockPos and not config.isMainSkill)



    local Image_levelIcon = TFDirector:getChildByPath(self.Panel_angelskill_info, "Image_levelIcon")
    Image_levelIcon:setVisible(isUnlockPos and not config.isMainSkill)

    self.ListView_skill_level:removeAllChildren()
    self.ListView_skill_level:setVisible(isUnlockPos)
    if not config.isMainSkill then
        if isUnlockPos then
            for i=1, maxLevel do
                local img = TFImage:create(i<=curLevel and "ui/fairy_angle/new_62.png" or "ui/fairy_angle/new_61.png")
                img:setPosition(ccp(i * 30, 10))
                self.ListView_skill_level:addChild(img)
            end
            -- local size = self.ListView_skill_level:getContentSize()
            -- size.width = maxLevel*20 + (maxLevel-1)*self.ListView_skill_level:getItemsMargin()
            -- self.ListView_skill_level:setContentSize(size)
        end
    end


    --觉醒技能是有等级的
    if config.skillType == EC_SKILL_TYPE.JUEXING then
        Label_Level:setVisible(true)
        Image_levelIcon:setVisible(true)
        self.ListView_skill_level:setVisible(true)
        local juexingLevel = HeroDataMgr:getAngelLevel(self.heroid)

        if self.notAction then -- 试用精灵的觉醒技能等级由配置表决定
            juexingLevel = AngelDataMgr:getSkillLevel(self.heroid,EC_SKILL_TYPE.JUEXING,1)
        end

        Label_Level:setText(juexingLevel)
        self.ListView_skill_level:removeAllChildren()
        for i=1, juexingLevel do
            local img = TFImage:create(i<=juexingLevel and "ui/fairy_angle/new_62.png" or "ui/fairy_angle/new_61.png")
            img:setPosition(ccp(i * 30, 10))
            self.ListView_skill_level:addChild(img)
        end

    end

    local Label_skill_name = TFDirector:getChildByPath(self.Panel_angelskill_info, "Label_skill_name")
    Label_skill_name:setTextById(config.nameId)

    self.ListView_angle_skill_desc:removeAllItems()
    local size = self.ListView_angle_skill_desc:getContentSize()

    if config.isMainSkill then
        Label_content = self.Label_desc_item:clone():Show()
        Label_content:setTextById(450035)
        Label_content:setDimensions(size.width, 0)
        self.ListView_angle_skill_desc:pushBackCustomItem(Label_content)

        if config.skillType ~= EC_SKILL_TYPE.SHANBI then
            Label_content = self.Label_desc_item:clone():Show()
            local allTips = string.split(config.hurtType, "-")
            local tipsString = ""
            local strHurt = TextDataMgr:getText(450044)
            for i = 1, #allTips, 1 do
                local str = allTips[i]
                local tips = TextDataMgr:getText(str)
                if i == 1 then
                    tipsString = tipsString .. tips
                else
                    tipsString = tipsString .. " " .. tips
                end
            end
            Label_content:setText(strHurt .. tipsString)
            Label_content:setDimensions(size.width, 0)
            self.ListView_angle_skill_desc:pushBackCustomItem(Label_content)
        end

        local Label_content = self.Label_desc_item:clone():Show()
        Label_content:setTextById(config.tips1)
        if config.skillType == EC_SKILL_TYPE.JUEXING then
            local config = TabDataMgr:getData("AngelSkillTree")
            for k, v in pairs(config) do
                if v.heroId == self.heroid and v.skillType == EC_SKILL_TYPE.JUEXING then
                    if v.lvl == (HeroDataMgr:getAngelLevel(self.heroid) - 1) then
                        Label_content:setTextById(v.tips1)
                    end
                end
            end
        end
        Label_content:setDimensions(size.width, 0)
        self.ListView_angle_skill_desc:pushBackCustomItem(Label_content)
    elseif curLevel < 0 then
        Label_content = self.Label_desc_item:clone():Show()
        Label_content:setTextById(config.tips1)
        Label_content:setDimensions(size.width, 0)
        self.ListView_angle_skill_desc:pushBackCustomItem(Label_content)        
    else
        if curLevel > 0 then
            if isUnlockPos then
                 Label_content = self.Label_desc_item:clone():Show()
                 Label_content:setTextById(450034)
                 Label_content:setDimensions(size.width, 0)
                 self.ListView_angle_skill_desc:pushBackCustomItem(Label_content)
            end

            Label_content = self.Label_desc_item:clone():Show()
            Label_content:setTextById(config.tips1)
            Label_content:setDimensions(size.width, 0)
            self.ListView_angle_skill_desc:pushBackCustomItem(Label_content)
        end

        if curLevel < maxLevel then
            --if isUnlockPos  then
                 Label_content = self.Label_desc_itemGray:clone():Show()
                 Label_content:setTextById(450032)
                 Label_content:setDimensions(size.width, 0)
                 self.ListView_angle_skill_desc:pushBackCustomItem(Label_content)
          --  end



            local skillId = AngelDataMgr:getAngleBaseData(config.heroId, config.skillType, config.pos, nextLevel)
            local nextConfig = AngelDataMgr:getAngleConfig(skillId)
            local Label_content = self.Label_desc_itemGray:clone():Show()
            Label_content:setTextById(nextConfig.tips1)
            Label_content:setDimensions(size.width, 0)
            self.ListView_angle_skill_desc:pushBackCustomItem(Label_content)
        end
    end


    local curSKillPoint = 0
    local nextLevelConfig = nil
    local isHaveSkillPoint = true
    self.Button_add_skill_level.errCode = 0
    if not config.isMainSkill then
        self.Button_sub_skill_level:setVisible(true)
        self.Button_add_skill_level:setVisible(true)

        self.Button_sub_skill_level:setTouchEnabled(curLevel>0)
        self.Button_add_skill_level:setTouchEnabled(curLevel<maxLevel)
        Utils:setNodeGray(self.Button_sub_skill_level, curLevel<=0)
        Utils:setNodeGray(self.Button_add_skill_level, curLevel>=maxLevel)
        
        if curLevel<maxLevel then
            curSKillPoint    = AngelDataMgr:getAngleTabCurUseSkillPoint(self.heroid)
            nextLevelConfig  = AngelDataMgr:getAngleBaseData(config.heroId, config.skillType, config.pos, nextLevel)
            nextLevelConfig  = AngelDataMgr:getAngleConfig(nextLevelConfig)
            isHaveSkillPoint = curSKillPoint >= nextLevelConfig.needSkillPiont
            if not notUnlockNextLvCode or notUnlockNextLvCode>=0 then  
                notUnlockNextLvCode = isHaveSkillPoint and 0 or -4
            end
        end

        self.Button_add_skill_level.errCode = notUnlockNextLvCode
        self.Button_add_skill_level.errTips = notUnlockNextLvTips
    else
        self.Button_sub_skill_level:setVisible(false)
        self.Button_add_skill_level:setVisible(false)
    end
    
    local Label_next_unlock_title = TFDirector:getChildByPath(self.Panel_angelskill_info, "Label_next_unlock_title")
    Label_next_unlock_title:setVisible(config.isMainSkill~=true)
    if not config.isMainSkill then
        Label_next_unlock_title:setVisible(curLevel<maxLevel)

        local strTips = ""
        if notUnlockNextLvCode == 0 or notUnlockNextLvCode == -4 then
            if curLevel<maxLevel then
                strTips = TextDataMgr:getText(450020,nextLevelConfig.needSkillPiont)
            end
        elseif notUnlockNextLvCode == -1 then
            strTips = TextDataMgr:getText(450011,notUnlockNextLvTips)
        elseif notUnlockNextLvCode == -2 then
            strTips = TextDataMgr:getText(450012,notUnlockNextLvTips)
        elseif notUnlockNextLvCode == -3 then
            strTips = TextDataMgr:getText(450025,TextDataMgr:getText(notUnlockNextLvTips.nameId),notUnlockNextLvTips.lvl)
        end

        Label_next_unlock_title:setString(strTips)
        Label_next_unlock_title:setColor(notUnlockNextLvCode==0 and ccc3(255,255,255) or ccc3(255,255,255))
    end

    local isHaveVideo = self.curAngleSkill.video~=nil and self.curAngleSkill.video~=""
    local Image_skill_bg = TFDirector:getChildByPath(self.Panel_angelskill_info, "Image_skill_bg")
    local Image_video_play = TFDirector:getChildByPath(self.Panel_angelskill_info, "Image_video_play")
    Image_video_play:setVisible(isHaveVideo)
    Image_video_play:setVisible(false)
    Image_video_play:setTouchEnabled(true)
    Image_video_play:onClick(function()
        if isHaveVideo then
            self.videoView = Utils:openView("angelNew.SkillPreView",self.curAngleSkill.video)
        end
    end)

    if self.notAction then
        self.Button_add_skill_level:hide()
        self.Button_sub_skill_level:hide()
        self.Button_angle_tab:hide()
    end
end

function AngelInfo:updatePassiveSkillDetailsInfo()
    self.Panel_right:show()
    self.Panel_gem_view:hide()
    local config = self.curPassiveSkill

    local isUnlock,notUnlockCode,notUnlockData = AngelDataMgr:getIsUnlockSkill(config.id, {constTrue = self.notAction,heroid = config.heroId,skillType = config.skillType,pos = config.pos})
    
    local Image_skill_icon = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_icon")
    Image_skill_icon:setTexture(config.icon)

    local Label_angelInfo_2 = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_angelInfo_2")
    Label_angelInfo_2:setString(isUnlock and "" or TextDataMgr:getText(450010))

    local Label_skill_name = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_skill_name")
    Label_skill_name:setTextById(config.nameId)

    
    local strTips = ""
    if notUnlockCode == -1 then
        strTips = TextDataMgr:getText(450018,notUnlockData)
    elseif notUnlockCode == -2 then
        strTips = TextDataMgr:getText(450012,notUnlockData)
    end

    local isUnlock = AngelDataMgr:getIsUnlockSkill(config.id, {constTrue = self.notAction,heroid = config.heroId,skillType = config.skillType,pos = config.pos})
    local Label_unlock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_unlock_tips")
    Label_unlock_tips:setString(strTips)
   -- Label_unlock_tips:setColor(isUnlock and ccc3(255,255,255) or ccc3(0x2e,30,37))
    --local Label_slot_lock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_slot_lock_tips")

    Label_unlock_tips:setVisible(not isUnlock)
    --if not isUnlock then
    --    Label_slot_lock_tips:setVisible(false)
    --end

    self.ListView_passive_skill_desc:removeAllItems()
    local size = self.ListView_angle_skill_desc:getContentSize()

    local Label_content = self.Label_desc_item:clone():Show()
    Label_content:setTextById(config.tips1)
    Label_content:setDimensions(size.width, 0)
    self.ListView_passive_skill_desc:pushBackCustomItem(Label_content)

    Label_content = self.Label_desc_item:clone():Show()
    -- Label_content:setTextById(config.tips2)
    Label_content:setString(config.tips2)
    Label_content:setDimensions(size.width, 0)
    Label_content:setColor(ccc3(255,255,0))
    self.ListView_passive_skill_desc:pushBackCustomItem(Label_content)

    print("config.tips2=========>")
    print(config.tips2)

    self:updatePassiveSkillButtonState()

    if self.notAction then
        self.Button_load_skill:hide()
        self.Button_unload_skill:hide()
        self.Button_change:hide()
    end
end

function AngelInfo:updatePassiveSkillButtonState()
    local skillData = self.curPassiveSkill
    self.Button_unload_skill:setVisible(false)
    local isUnlock  = AngelDataMgr:getIsUnlockSkill(skillData.id, {constTrue = self.notAction,heroid = skillData.heroId,skillType = skillData.skillType,pos = skillData.pos})
    if not isUnlock then
        --技能未解锁
        local Image_skill_bg = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_bg")
        Image_skill_bg:setVisible(true)
        self.Button_load_skill:setVisible(false)
        --self.Button_load_skill:setTouchEnabled(false)
       -- Utils:setNodeGray(self.Button_load_skill, true)
       -- self.Button_unload_skill:setVisible(false)
        self.Button_load_skill.state = -1
        self.Button_change:setVisible(false)
        local Label_Loaded = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_Loaded")
        Label_Loaded:setVisible(false)
        local Label_slot_lock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_slot_lock_tips")
        Label_slot_lock_tips:setVisible(false)
        self.Label_slotLock:setVisible(false)
        local Image_skill_bg2 = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_NoSkill")
        Image_skill_bg2:setVisible(false)
        return
    end

    local isLoadPassiveSkill = AngelDataMgr:getIsLoadPassiveSkill(skillData.heroId, skillData.id)
    if isLoadPassiveSkill then
        --该技能已装备
        self.Button_load_skill:setVisible(false)
        --self.Button_unload_skill:setVisible(false)
        local Image_skill_bg = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_bg")
        Image_skill_bg:setVisible(true)
        local Image_skill_bg2 = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_NoSkill")
        Image_skill_bg2:setVisible(false)
        if self.slotCondition ~= 3 then
            local Label_Loaded = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_Loaded")
            Label_Loaded:setVisible(true)
        else
            local Label_slot_lock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_slot_lock_tips")
            Label_slot_lock_tips:setVisible(false)
        end
        self.Label_slotLock:setVisible(false)
        self.Button_load_skill.state = -3
        self.Button_change:setVisible(false)
        return
    end

    local isHaveEmptySlot = AngelDataMgr:getIsHaveEmptyPassiveSkillSlot(skillData.heroId)
    if not isHaveEmptySlot then
        --没有空余的被动技能槽
        -- self.Button_load_skill:setVisible(true)
        -- self.Button_load_skill:setTouchEnabled(false)
        -- Utils:setNodeGray(self.Button_load_skill, true)
        -- self.Button_load_skill:setVisible(false)
        -- self.Button_unload_skill:setVisible(false)
        -- self.Button_load_skill.state = -2
        --return
    end

    --可装备该技能
    -- self.Button_load_skill:setVisible(true)
    -- self.Button_load_skill:setTouchEnabled(true)
    -- Utils:setNodeGray(self.Button_load_skill, false)
    
    self.Button_load_skill.state = 0

    if isUnlock then
        if self.slotCondition == 1 then
            self.Button_change:setVisible(true)
            self.Button_load_skill:setVisible(false)
            local Label_Loaded = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_Loaded")
            Label_Loaded:setVisible(false)
        elseif self.slotCondition == 2 then
            self.Button_change:setVisible(false)
            self.Button_load_skill:setVisible(true)
            self.ListView_passive_skill_desc:setVisible(true)
            local Image_skill_bg2 = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_NoSkill")
            local Image_skill_bg = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_bg")
            Image_skill_bg:setVisible(true)
            Image_skill_bg2:setVisible(false)
        elseif self.slotCondition == 3 then
            local Image_skill_bg2 = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_NoSkill")
            self.Button_change:setVisible(false)
            self.Button_load_skill:setVisible(false)
            Image_skill_bg2:setVisible(false)
            local Label_slot_lock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_slot_lock_tips")
            Label_slot_lock_tips:setVisible(true)
            self.Label_slotLock:setVisible(false)
        else

        end
    end

    if self.slotCondition == 3 then
        local Image_skill_bg = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_bg")
        Image_skill_bg:setVisible(true)
    end

    local Label_Loaded = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_Loaded")
    Label_Loaded:setVisible(false)

end

function AngelInfo:updateSkillPointInfo()
    local curSKillPoint = AngelDataMgr:getAngleTabCurUseSkillPoint(self.heroid)
    self.Label_skill_point_use:setString(curSKillPoint)
end

function AngelInfo:updateCurrAngleTabName()
    local data = AngelDataMgr:getHeroCurrUseSkillStrategyData(self.heroid)
    self.Label_cur_angletab_name:setString(data.name)

    local totalLevel = 0
    if data.angeSkillInfos then
        for i, v in ipairs(data.angeSkillInfos) do
            totalLevel = totalLevel + v.lvl
        end
    end

    self.Label_points:setString(totalLevel)
end

function AngelInfo:showMainSkillInfo(skillId, icon)
    -- local skillId = HeroDataMgr:getSkinAngleSkillID(self.heroid, skillType)
    if not skillId then
        return
    end
    local skillInfo = TabDataMgr:getData("Skill", skillId)
    if not skillInfo then
        return
    end
    local tmpSkillInfo = {
        icon = skillInfo.icon,
        skillType = skillInfo.skillType,
        nameId = skillInfo.name,
        tips1 = skillInfo.des,
        tips2 = skillInfo.des,
        isMainSkill = true,        
        video = skillInfo.video,
        hurtType = skillInfo.HurtType       
    }
    self.curAngleSkill = tmpSkillInfo
    self.Image_skill_select:retain()
    self.Image_skill_select:removeFromParent()
    icon:addChild(self.Image_skill_select,0,0)
    self.Image_skill_select:release()
    -- self.Image_skill_select:setPosition(icon:getPosition())
    self:updateAngleSkillDetailsInfo()
    if self.isShowFullSkill then
        self:changeShowAngleSkillFullScreen(icon)
    else
        self:moveSkillItemInMid(icon)
    end
end

function AngelInfo:changeShowPage(pageType)
    if self.showPageType == pageType then
        return
    end
    self.showPageType = pageType
    
    self.Panel_angel_tree_page:setVisible(self.showPageType == SKILL_PAGE_TYPE.SKILL_TREE)
    self.Image_skill_point_bg:setVisible(self.showPageType == SKILL_PAGE_TYPE.SKILL_TREE and not self.notAction)
    self.Panel_angelskill_info:setVisible(self.showPageType == SKILL_PAGE_TYPE.SKILL_TREE)
    self.Panel_passive_skill_page:setVisible(self.showPageType == SKILL_PAGE_TYPE.PASSIVE_SKILL)
    self.Panel_passiveskill_info:setVisible(self.showPageType == SKILL_PAGE_TYPE.PASSIVE_SKILL)

    if self.showPageType == SKILL_PAGE_TYPE.SKILL_TREE then
        local tmpImg = TFDirector:getChildByPath(self.Button_passive_skill, "Image_Game_1")
        tmpImg:setTexture("ui/Equipment/new_ui/new_47.png")
        local tmpImg2 = TFDirector:getChildByPath(self.Button_angle_tree, "Image_Game_1")
        tmpImg2:setTexture("ui/Equipment/new_ui/new_48.png")
    else
        local tmpImg = TFDirector:getChildByPath(self.Button_passive_skill, "Image_Game_1")
        tmpImg:setTexture("ui/Equipment/new_ui/new_48.png")
        local tmpImg2 = TFDirector:getChildByPath(self.Button_angle_tree, "Image_Game_1")
        tmpImg2:setTexture("ui/Equipment/new_ui/new_47.png")
    end
    if self.showPageType == SKILL_PAGE_TYPE.PASSIVE_SKILL then
        if not self.curPassiveSkillItem then
            if not self.enterWithWhichSlot then
                self:clickWhichSlot(1)
            else
                self:clickWhichSlot(self.enterWithWhichSlot)
            end
        end
        
    else

        if not self.curAngleSkillItem then
            self:moveSkillItemInMid(self.mainIcons[6])
        else
            self:moveSkillItemInMid(self.curAngleSkillItem)
        end
    end

    if self.showPageType == SKILL_PAGE_TYPE.SKILL_TREE then

        self:panelRightShow(self.Panel_angelskill_info)
        self:panelLeftShow(self.Panel_angel_tree_page)
    else
        self:panelRightShow(self.Panel_passiveskill_info)
        self:panelLeftShow(self.Panel_passive_skill)
    end

end

function AngelInfo:getPassiveSkillItem(skillId)
    for k, v in pairs(self.passiveSkillIcons) do
        if v and v.data.id == skillId then
            return v
        end
    end
end

function AngelInfo:panelRightShow(panel)
    panel:stopAllActions();
    panel:setOpacity(0);
    panel:setPositionX(panel:getPositionX() + 20)

    local actions = {
        CCMoveBy:create(0.2,ccp(-20,0));
        CCFadeIn:create(0.2);
    }

    panel:runAction(Spawn:create(actions));
end

function AngelInfo:panelRightHide(panel)
    panel:stopAllActions();
    panel:setPositionX(panel:getPositionX() - 20)

    local actions = {
        CCMoveBy:create(0.2,ccp(20,0));
        CCFadeOut:create(0.2);
    }

    panel:runAction(Spawn:create(actions));
end

function AngelInfo:panelLeftShow(panel)
    panel:stopAllActions();
    panel:setOpacity(0);
   

    panel:runAction(CCFadeIn:create(0.2))
end

function AngelInfo:panelLeftHide(panel)
    panel:stopAllActions();
   

    panel:runAction(CCFadeOut:create(0.2))
end

function AngelInfo:onUseAngleTab(data)
    self:initAllSkillInfo()
    self:updateAngleSkillDetailsInfo()
    self:updateSkillPointInfo()
    self:updateCurrAngleTabName()
    me.Director:setSingleEnabled(false)
    -- self:updatePassiveSkillDetailsInfo()
    for k, item in pairs(self.skillIcons) do
        if item:isVisible() and item.data then
            local skillData = item.data
            self:initAngleSkillLines(skillData)
        end 
    end
end

function AngelInfo:onChangeTabName(data)
    self:updateCurrAngleTabName()
end

function AngelInfo:onUpgradeSkill(data)
    if data.heroId ~= self.heroid then
        return
    end
    if self.curAngleSkill then
        if self.curAngleSkill.skillType == data.angeSkillInfo.type and self.curAngleSkill.pos == data.angeSkillInfo.pos then
            self:updateAngleSkillDetailsInfo()
        end
    end

    local needUpdateSkillType = data.angeSkillInfo.type
    for k, item in pairs(self.skillIcons) do
        local skillType = math.floor(k/100)
        if skillType == needUpdateSkillType and item:isVisible() and item.data then
            local skillData = item.data
            self:updateSkillItemInfo(item, self.heroid, skillType, skillData.pos)
            self:initAngleSkillLines(skillData)
        end 
    end

    self:updateSkillPointInfo()
    self:updateCurrAngleTabName()
end

function AngelInfo:onLoadPassiveSkill(data)
    self:initOnePassiveSkillItem(self.curPassiveSkillItem, self.curPassiveSkill)
    self:updatePassiveSkillSlots()
    self:updatePassiveSkillDetailsInfo()
    self:initPassiveSkillUI()


    local isHaveLoadSkill = AngelDataMgr:getIsLoadPassiveSkillByPos(self.heroid, self.clickSlotPos)
    local isUnlock = AngelDataMgr:getIsUnlockPassiveSkillSlot(self.heroid, self.clickSlotPos)
   

    local Label_Loaded = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_Loaded")
    local Image_skill_bg = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_bg")
    local Image_skill_bg2 = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_skill_NoSkill")
    local Label_slot_lock_tips = TFDirector:getChildByPath(self.Panel_passiveskill_info, "Label_slot_lock_tips")
    local item = self.passiveSkillSlots[self.clickSlotPos]

    self.Image_passvie_skill_slot_select:retain()
    self.Image_passvie_skill_slot_select:removeFromParent()
    item:addChild(self.Image_passvie_skill_slot_select,0,0)
    self.Image_passvie_skill_slot_select:release()
    self.Image_passvie_skill_slot_select:setVisible(true)

    if isHaveLoadSkill then

        for i=1, 16 do
            local data = AngelDataMgr:getHeroCurrUsePassiveSkillData(self.heroid, self.clickSlotPos)
            local item = self.passiveSkillIcons[i]
            if item and data and data.skillId ==  item.data.id then 
                self.curPassiveSkillItem = item
                self.curPassiveSkill = item.data
            end
        end

        self.Image_passvie_skill_select:retain()
        self.Image_passvie_skill_select:removeFromParent()
        Label_Loaded:setVisible(true)
        Image_skill_bg:setVisible(true)
        Image_skill_bg2:setVisible(false)
        Label_slot_lock_tips:setVisible(false)
        self.Label_slotLock:setVisible(false)
        self:updatePassiveSkillDetailsInfo()
        self.Button_unload_skill:setVisible(true)
        self.slotCondition = 1
        
    elseif isUnlock then
        self.Image_passvie_skill_select:retain()
        self.Image_passvie_skill_select:removeFromParent()
        Label_Loaded:setVisible(false)            
        Image_skill_bg:setVisible(false)
        Image_skill_bg2:setVisible(true)
        Label_slot_lock_tips:setVisible(false)
        self.Label_slotLock:setVisible(false)
        self.Button_unload_skill:setVisible(false)
        self.Button_change:setVisible(false)
        self.Button_load_skill:setVisible(false)

        self.slotCondition = 2

        
    end

    if self.notAction then
        self.Button_load_skill:hide()
        self.Button_unload_skill:hide()
        self.Button_change:hide()
    end
end

function AngelInfo:initAngleSkillLines(skillConfig)    
    local allMainSkillDatas = nil
    if skillConfig then
        allMainSkillDatas = {skillConfig}
    else
        allMainSkillDatas = AngelDataMgr:getAllMainSkillConfig(self.heroid)
    end
    self.lines = {}
    local panel = self.Panel_skill
    for i, v in ipairs(allMainSkillDatas) do
        if v.skillType ~= EC_SKILL_TYPE.JUEXING then
            local isUnlock1 = AngelDataMgr:getIsUnlockSkill(v.id, {constTrue = self.notAction,heroid = v.heroId,skillType = v.skillType,pos = v.pos})
            local tag1 = self:getSkillIconTag(v.skillType, v.pos_position)
            local icon = self.skillIcons[tag1]
            local isHaveFront = false
            for i2, v2 in ipairs(v.frontCondition) do
                for i3, v3 in ipairs(v2) do
                    local frontSkillConfig = AngelDataMgr:getAngleConfig(v3)
                    local tag2 = self:getSkillIconTag(frontSkillConfig.skillType, frontSkillConfig.pos_position)
                    local key1 = tag1.."-"..tag2
                    local key2 = tag2.."-"..tag1
                    if not self.lines[key1] and not self.lines[key2] then
                        local isUnlock2 = AngelDataMgr:getIsUnlockSkill(v3, {constTrue = self.notAction,heroid = v.heroId,skillType = v.skillType,pos = v.pos})

                        local frontIcon = self.skillIcons[tag2]
                        local line = self:createLine(icon, frontIcon, isUnlock1 and isUnlock2, v.skillType)
                        panel:addChild(line)

                        self.lines[key1] = imgLine
                        self.lines[key2] = imgLine
                        isHaveFront = true
                    else
                        local line = self.lines[key1] or self.lines[key2]
                        local isUnlock = isUnlock1 and isUnlock2
                        line:setBackGroundColor(isUnlock and ccc3(255,255,255) or ccc3(42,40,71))
                    end
                end
            end
            if not isHaveFront and v.Sign == 1 then
                local frontIcon = self.mainIcons[v.skillType]
                local tag2 = frontIcon:getTag()
                local key1 = tag1.."-"..tag2
                local key2 = tag2.."-"..tag1
                if not self.lines[key1] and not self.lines[key2] then
                    local line = self:createLine(icon, frontIcon, isUnlock1, v.skillType)
                    panel:addChild(line)
                    self.lines[key1] = imgLine
                    self.lines[key2] = imgLine
                else
                    local line = self.lines[key1] or self.lines[key2]
                    local isUnlock = isUnlock1
                    line:setBackGroundColor(isUnlock and ccc3(255,255,255) or ccc3(42,40,71))
                end
            end
        end
    end
end

function AngelInfo:createLine(startNode, endNode, isUnlock, skillType)
     --local imgLine = TFImage:create("ui/066.png")
    if not startNode then
        return
    end
    local startPos = ccp(startNode:getPosition())
    local endPos   = ccp(endNode:getPosition())
    local angle   = HeroDataMgr:getAngleByPos(startPos,endPos)
    local dist    = ccpDistance(startPos,endPos)
    -- imgLine:setRotation(angle)
    -- imgLine:setContentSize(CCSizeMake(5,dist))
    -- imgLine:setAnchorPoint(ccp(0, 0.5))
    -- imgLine:setPosition(icon:getPosition())
    -- panel:addChild(imgLine,10,10)
    local line = TFPanel:create()
    line:setContentSize(CCSizeMake(dist,4))
    line:setAnchorPoint(ccp(0, 0.5))
    line:setBackGroundColorType(1)
    
    line:setBackGroundColor(isUnlock and ccc3(255,255,255) or ccc3(42,40,71))
    if isUnlock then
        if skillType == EC_SKILL_TYPE.NORMAL then
            line:setBackGroundColor(ccc3(251,190,71)) 
            
        elseif skillType == EC_SKILL_TYPE.SKILL_1 then
            line:setBackGroundColor(ccc3(84,232,241))
        elseif skillType == EC_SKILL_TYPE.SKILL_2 then
            line:setBackGroundColor(ccc3(75,185,255))
        elseif skillType == EC_SKILL_TYPE.BISHA then           
            line:setBackGroundColor(ccc3(139,104,221))
        end
    end
    line:setOpacity(255)
    line:setPosition(startPos)
    line:setRotation(angle)


    return line
end

function AngelInfo:changeShowAngleSkillFullScreen(item)
    if self.showPageType == SKILL_PAGE_TYPE.PASSIVE_SKILL then
        return
    end
    local isShow = not self.isShowFullSkill
    self.isShowFullSkill = isShow

    self.Image_skill_point_bg:setVisible(not isShow)
    self.Button_angle_tab:setVisible(not isShow and not self.notAction)

    if isShow then
        self.Button_show_full_screen:setVisible(false)
    else
        self.Button_show_full_screen:setVisible(true)
    end

    self.Panel_right:stopAllActions()
    if isShow then
        self.Panel_right:setOpacity(255);
        local actions2 = {
            CCMoveBy:create(0.2,ccp(30,0));
            CCFadeOut:create(0.2);
        }
        local hide = CCHide:create()
        local seq  = CCSequence:create({Spawn:create(actions2),hide})
        self.Panel_gem_view:runAction(seq)
        self.Panel_right:runAction(CCSequence:create({Spawn:create({CCMoveBy:create(0.2,ccp(30,0)),CCFadeOut:create(0.2)}),CCHide:create()}))
            
        self.Panel_Clip:setClippingEnabled(false)
    else
        self.Panel_right:setOpacity(0);
        self.Panel_right:show()
        local actions2 = {
            CCMoveBy:create(0.2,ccp(-30,0));
            CCFadeIn:create(0.2);
        }
        if self.gemPos then
            self.Panel_gem_view:runAction(Spawn:create({CCMoveBy:create(0.2,ccp(-30,0)),CCFadeIn:create(0.2)}))
            self.Panel_right:runAction(CCMoveBy:create(0.2,ccp(-30,0)))
            self.Panel_right:setOpacity(255)
            self.Panel_right:hide()
        else
            self.Panel_right:runAction(Spawn:create({CCMoveBy:create(0.2,ccp(-30,0)),CCFadeIn:create(0.2)}))
            self.Panel_gem_view:runAction(CCMoveBy:create(0.2,ccp(-30,0)))
            self.Panel_gem_view:setOpacity(255)
            self.Panel_gem_view:hide()
        end
        
        self.Panel_Clip:setClippingEnabled(true)

    end

    local pos = self.tmpPos
    if item then
        local tmpScale = self.Panel_skill:getScale()
        --self.Panel_skill:setScale(1) --位置转换在有缩放的情况下有问题，所以先设置为1，转换位置后，再设置回原来的缩放值
        local pos1 = item:convertToWorldSpaceAR(ccp(0,0))
        pos1       = self.PanelMulTouch:convertToWorldSpaceAR(pos1) 
        local destPos = ccp(330,340) --以这个位置为中心点，把item移到这个位置
        local distPos = me.pSub(destPos, pos1)
        local curPos  = self.PanelMulTouchInnerContainer:getPosition()
        pos       = me.pAdd(curPos, distPos)
        --self.Panel_skill:setScale(tmpScale)

        dump(pos)
        local move = CCMoveTo:create(0.2,pos)
        self.PanelMulTouchInnerContainer:stopAllActions()
        self.PanelMulTouchInnerContainer:runAction(move)

        local scale = CCScaleTo:create(0.2, isShow and 0.55 or 0.6)
        self.Panel_skill:stopAllActions()
        self.Panel_skill:runAction(scale)

    elseif isShow then

        -- local panelSize = self.PanelMulTouch:getContentSize()
        -- local containerSize = self.PanelMulTouchInnerContainer:getContentSize()
        -- local x = -(containerSize.width - panelSize.width) * 0.5
        -- local y = -(containerSize.height - panelSize.height) * 0.5
        -- pos = ccp(x,y)
        local scaleRate = 0.5
        if AngelDataMgr:getAngelTreeUiCfg(self.heroid) == "Angle_skill_1104" or 
            AngelDataMgr:getAngelTreeUiCfg(self.heroid) == "Angle_skill_1107" then
            scaleRate = 0.4
        end
        local scale = CCScaleTo:create(0.2, isShow and scaleRate or 1)
        self.Panel_skill:runAction(scale)
        self:moveSkillItemInMid(self.mainIcons[6], true)
    end
    
end

function AngelInfo:moveSkillItemInMid(item, isFull)
    local pos = self.tmpPos
    if item then
       -- local tmpScale = self.Panel_skill:getScale()
        --self.Panel_skill:setScale(0.6) --位置转换在有缩放的情况下有问题，所以先设置为1，转换位置后，再设置回原来的缩放值
        local pos1 = item:convertToWorldSpaceAR(ccp(0,0))
        pos1       = self.PanelMulTouch:convertToWorldSpaceAR(pos1)
        local destPos = ccp(0, 0)
        if isFull then
            destPos = ccp(GameConfig.WS.width * 2 / 5 + (GameConfig.WS.width - 1136 ) * 3 / 5  ,GameConfig.WS.height / 2)
        else 
            destPos = ccp(GameConfig.WS.width * 1 / 4 + GameConfig.WS.width - 1136 , GameConfig.WS.height / 2) --以这个位置为中心点，把item移到这个位置
        end
        local distPos = me.pSub(destPos, pos1)
        local curPos  = self.PanelMulTouchInnerContainer:getPosition()
        pos       = me.pAdd(curPos, distPos)
        --self.Panel_skill:setScale(tmpScale)
    elseif isShow then
        local panelSize = self.PanelMulTouch:getContentSize()
        local containerSize = self.PanelMulTouchInnerContainer:getContentSize()
        local x = -(containerSize.width - panelSize.width) * 0.5
        local y = -(containerSize.height - panelSize.height) * 0.5
        pos = ccp(x,y)
    end
    dump(pos)
    local move = CCMoveTo:create(0.2,pos)
    self.PanelMulTouchInnerContainer:stopAllActions()
    self.PanelMulTouchInnerContainer:runAction(move)
end

function AngelInfo:getSkillIconTag(skillType, pos)
    return skillType*100+pos
end

function AngelInfo:getSkillIconItemBySkillTypeAndPos(skillType, pos)
    for k, icon in pairs(self.skillIcons) do
        if icon and icon.data and icon.data.skillType == skillType and icon.data.pos == pos then
            return icon
        end
    end
    return nil
end

function getRotationAngle(px1, py1, px2, py2) 
    local o = px2 - px1;
    local a = py2 - py1;
    local at = math.atan(o/a) / math.pi * 180.0;
    
    if a < 0 then
        if o < 0 then
            at = 180 + math.abs(at);
        else
            at = 180 - math.abs(at);    
        end
    end
    
    return at;
end

function AngelInfo:onHide()
    self.super.onHide(self)
end

function AngelInfo:removeUI()
    self.super.removeUI(self)

    if self.lastUseSkillStrategy then
        HeroDataMgr:setTmpUseSkillStrategy(self.heroid, self.lastUseSkillStrategy)
    end
end

function AngelInfo:initNativeLanguage()
    local stringIds = {450008,450009,450015,450016,450017,450019,450019,}
    local labels    = {
        TFDirector:getChildByPath(self.Panel_right, "Button_angle_tree.Label_angelInfo_1"),
        TFDirector:getChildByPath(self.Panel_right, "Button_passive_skill.Label_angelInfo_1"),
        TFDirector:getChildByPath(self.Panel_passive_skill, "Label_angle_passive_skill_1-Copy1"),
        TFDirector:getChildByPath(self.Panel_passiveskill_info, "Button_load_skill.Label_angelInfo_1"),
        TFDirector:getChildByPath(self.Panel_passiveskill_info, "Button_unload_skill.Label_angelInfo_1"),
        TFDirector:getChildByPath(self.Panel_angelskill_info, "Image_angelInfo_2.Label_angelInfo_1"),
        TFDirector:getChildByPath(self.Panel_passiveskill_info, "Image_angelInfo_2.Label_angelInfo_1"),
    }
    for i, lab in ipairs(labels) do
        if lab then
            if i < 3 then
                lab:setLineHeight(25)
            end
            lab:setTextById(stringIds[i])
        end
    end
end

function AngelInfo:onShow()
    self.super.onShow(self)
    --self.curAngleSkillItem = self.mainIcons[6]
    self:moveSkillItemInMid(self.curAngleSkillItem)
    self.Panel_skill:setScale(0.6)
end

return AngelInfo;