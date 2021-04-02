local KeyStateMgr = import(".KeyStateMgr")
local BattleUtils = import(".BattleUtils")
local BattleConfig= import(".BattleConfig")
local enum  = import(".enum")
local eVKeyCode = enum.eVKeyCode
local ePKeyCode = enum.ePKeyCode
local eEvent = enum.eEvent
local eGuideAction = enum.eGuideAction
local ResLoader = import(".ResLoader")
local BattleGuide = import(".BattleGuide")
--local print  = BattleUtils.print
--摇杆半径
local Radius   = 50
-- local Lengeth  = math.sqrt(Radius*Radius/2)

-- local Roker_State_Tab =
-- {
--     { pos =me.p(Radius,0),          vKeyCodes = {eVKeyCode.RIGHT}},
--     { pos =me.p(Lengeth,Lengeth),   vKeyCodes = {eVKeyCode.RIGHT,eVKeyCode.UP}},
--     { pos =me.p(0,Radius),          vKeyCodes = {eVKeyCode.UP}},
--     { pos =me.p(-Lengeth,Lengeth),  vKeyCodes = {eVKeyCode.LEFT,eVKeyCode.UP}},
--     { pos =me.p(-Radius,0),         vKeyCodes = {eVKeyCode.LEFT}},
--     { pos =me.p(-Lengeth,-Lengeth), vKeyCodes = {eVKeyCode.LEFT,eVKeyCode.DOWN}},
--     { pos =me.p(0,-Radius),         vKeyCodes = {eVKeyCode.DOWN}},
--     { pos =me.p(Lengeth,-Lengeth),  vKeyCodes = {eVKeyCode.RIGHT,eVKeyCode.DOWN}}
-- }

--
local VKeyBind = {}
VKeyBind[eVKeyCode.LEFT]     = {bindPKeyCodes={ePKeyCode.LEFT,ePKeyCode.A}  }
VKeyBind[eVKeyCode.RIGHT]    = {bindPKeyCodes={ePKeyCode.RIGHT,ePKeyCode.D} }
VKeyBind[eVKeyCode.UP]       = {bindPKeyCodes={ePKeyCode.UP,ePKeyCode.W}    }
VKeyBind[eVKeyCode.DOWN]     = {bindPKeyCodes={ePKeyCode.DOWN,ePKeyCode.S}  }
VKeyBind[eVKeyCode.SKILL_A]  = {bindPKeyCodes={ePKeyCode.J}, bindWidgetName ="A"}
VKeyBind[eVKeyCode.SKILL_B]  = {bindPKeyCodes={ePKeyCode.H}, bindWidgetName ="B"}
VKeyBind[eVKeyCode.SKILL_C]  = {bindPKeyCodes={ePKeyCode.K}, bindWidgetName ="C"}
VKeyBind[eVKeyCode.SKILL_D]  = {bindPKeyCodes={ePKeyCode.L}, bindWidgetName ="D"}
VKeyBind[eVKeyCode.SKILL_E]  = {bindPKeyCodes={ePKeyCode.M}, bindWidgetName ="E"}
VKeyBind[eVKeyCode.SKILL_F]  = {bindPKeyCodes={ePKeyCode.U}, bindWidgetName ="F"}
VKeyBind[eVKeyCode.SKILL_G]  = {bindPKeyCodes={ePKeyCode.I}, bindWidgetName ="G"}
VKeyBind[eVKeyCode.SKILL_H]  = {bindPKeyCodes={ePKeyCode.O}, bindWidgetName ="H"}
VKeyBind[eVKeyCode.SKILL_I]  = {bindPKeyCodes={ePKeyCode.Y}, bindWidgetName ="I"}

local VKeySubSkill = {}

local function pGetAngle(self,other)
    local a2 = me.pNormalize(self)
    local b2 = me.pNormalize(other)
    local angle = math.atan2(me.pCross(a2, b2), me.pDot(a2, b2) )
    if math.abs(angle) < 1.192092896e-7 then
        return 0.0
    end
    return angle
end


local KeyBoard = class("KeyBoard",BaseLayer)

local FixDir   = BattleConfig.ROKE_DIR_NUM/4
local FixValue = 1/FixDir 

function KeyBoard.setRokeVector(vx,vy) 
    local _vx = BattleUtils.round(vx * 100 / FixDir)*FixDir*0.01
    local _vy = BattleUtils.round(vy * 100 / FixDir)*FixDir*0.01
    if vx > - FixValue and vx < FixValue then
        _vx = 0
    end
    -- print_(string.format("%s-%s",_vx,_vy))
    KeyStateMgr.setRokeVector(_vx ,_vy)
end
function KeyBoard:ctor()
    self.vKeyNodes = {}
    self.super.ctor(self)
    self:init("lua.uiconfig.battle.ctrlView")
    me.Director:getEventDispatcher():setSingleEnabled(false)

end

function KeyBoard:getWidget(widget)
    if widget == "image_roke" then
        return self.image_background
    elseif widget == "skillA" then
        return self.vKeyNodes[eVKeyCode.SKILL_A]
    elseif widget == "skillC" then
        return self.vKeyNodes[eVKeyCode.SKILL_C]
    elseif widget == "skillB" then
        return self.vKeyNodes[eVKeyCode.SKILL_B]
    elseif widget == "skillD" then
        return self.vKeyNodes[eVKeyCode.SKILL_D]
    end

end
function KeyBoard:hideButtonChat()
    self.Panel_menu:hide()
    self.Button_talk:hide()
end
function KeyBoard:showButtonChat(callFunc)
    self.Button_talk:show()
    self.Button_talk:onTouch(function (event)
        local name   = event.name
        local target = event.target
        if name == "began" then
            self.Panel_menu:show()
            for i,v in ipairs(self.Panel_menu.selectItems) do
                v:hide()
            end
            self.selectIndex = nil
        elseif name == "moved" then
            local _touchPos = me.p(target:getTouchMovePos())
            _touchPos =  target:convertToNodeSpace(_touchPos)
            local length = me.pGetLength(_touchPos)
            -- dump({_touchPos,self.btn_show_talk:getPosition(),length})
            self.selectIndex = nil
            if length > 20 and length <=145 and _touchPos.x < 0 then 
                local value = math.abs(_touchPos.y/_touchPos.x)
                if _touchPos.y >= 0 then 
                    if value >  1 then 
                        self.selectIndex = 1
                    else
                        self.selectIndex = 2
                    end
                else
                    if value > 1 then 
                        self.selectIndex = 4
                    else
                        self.selectIndex = 3
                    end
                end
            end
            for i,v in ipairs(self.Panel_menu.selectItems) do
                v:setVisible(i == self.selectIndex)
            end
        elseif name == "ended" then
            self.Panel_menu:hide()
            for i,v in ipairs(self.Panel_menu.selectItems) do
                v:hide()
            end
            if self.selectIndex then
                Utils:makeCDProgressBar(self.Button_talk,3,self.Button_talk:getTextureNormalName())
                if callFunc then 
                    callFunc(self.selectIndex)
                end
            end
        end
    end)
end

function KeyBoard:initUI(ui)
    self.super.initUI(self, ui)
    self.panel_root       = TFDirector:getChildByPath(ui, "Panel")
    local size = me.size(me.EGLView:getDesignResolutionSize())


    self.panel_ctrlpad = TFDirector:getChildByPath(self.panel_root, "Panel_ctrlPad")
    if size.width/size.height > 1.775 then --1136/640
        size.width = size.width - 100
        self.panel_ctrlpad:setSize(size)
    end
    self.Image_specialEnergy = TFDirector:getChildByPath(self.panel_ctrlpad, "Image_specialEnergy"):hide()
    self.LoadingBar_specialEnergy = TFDirector:getChildByPath(self.Image_specialEnergy, "LoadingBar_specialEnergy")
    self.image_background = TFDirector:getChildByPath(self.panel_ctrlpad, "Image_roker"):hide()
    self.image_ctrl       = TFDirector:getChildByPath(self.panel_ctrlpad, "Image_ctrl")
    local skillKeyBG = TFDirector:getChildByPath(self.panel_ctrlpad, "Image_ctrlA")
    BattleGuide:registCtrlKeyBG(skillKeyBG)
    self.skillKeyBG_A = skillKeyBG
    self.skillKeyBG_B = TFDirector:getChildByPath(self.panel_ctrlpad, "Image_ctrlB")
    self.button_ctrl      = TFDirector:getChildByPath(self.panel_ctrlpad, "Button_ctrl")
    self.panel_roke_touch = TFDirector:getChildByPath(self.panel_ctrlpad, "Panel_roke_touch")
    self.image_ctrl:hide()
    self.button_ctrl:setTouchEnabled(false)
    self.image_background.initPos = self.image_background:getPosition()
    EventMgr:addEventListener(self,eEvent.EVENT_CAPTAIN_CHANGE, handler(self.onCaptainChange,self))
    EventMgr:addEventListener(self,eEvent.EVENT_VKSTATE_CHANGE, handler(self.onVKStateChange,self))
    EventMgr:addEventListener(self,eEvent.EVENT_SKILLEX_REFRESH, handler(self.onSkillExChange,self))
    EventMgr:addEventListener(self,eEvent.EVENT_SUB_SKILL_SHOW, handler(self.onSubSkillChange,self))

    self.panel_revive     = TFDirector:getChildByPath(self.panel_root, "Panel_revive"):hide()
    self.button_revive    = TFDirector:getChildByPath(self.panel_root, "Button_revive")
    
    self.pause_btn  = TFDirector:getChildByPath(self.panel_root, "Button_pause")
    self.skill_help_btn = TFDirector:getChildByPath(self.panel_root, "Button_skill_help"):hide()
    self.skill_help_btn:getChildByName("Label_title"):setTextById(224013)
    self.guide_panel = TFDirector:getChildByPath(self.panel_root, "Panel_guide"):hide()
    BattleGuide:registGuidePanel(self.guide_panel)
    BattleGuide:registDirectCtrl(self.panel_roke_touch)
    --TODO 摇杆区域
    if BattleConfig.SHOW_ROKE_TOUCH_AREA then
        local position = self.panel_roke_touch:getPosition()
        local drawNode = TFDrawNode:create()
        drawNode:drawCircle(position, 233, 360, 36, false,ccc4(1, 1, 0, 1))
        self.panel_ctrlpad:addChild(drawNode)
    end
    self.panel_effect = TFDirector:getChildByPath(self.panel_root, "Panel_effect")
    --粒子预制体
    self.prefabe_particle = TFDirector:getChildByPath(self.panel_root, "prefabe_particle")
    --TODO 这还能为空？
    if self.prefabe_particle then
        self.prefabe_particle:hide()
    end
    self.button_ex = TFDirector:getChildByPath(self.panel_ctrlpad, "Button_ex"):hide()
    self.button_ex:setTouchEnabled(false)
    self.button_ex.Image_icon   = TFDirector:getChildByPath(self.button_ex, "Image_icon")
    self.button_ex.Image_mask   = TFDirector:getChildByPath(self.button_ex, "Image_mask")
    self.button_ex.Label_cdTime = TFDirector:getChildByPath(self.button_ex, "Label_cdTime")
    self.button_ex.Label_times  = TFDirector:getChildByPath(self.button_ex, "Label_times")
    self.button_ex:onClick(function ()
        if self.button_ex.skillEx then 
            self.button_ex.skillEx:doUse()
            local hero = battleController.getCaptain()
            if hero then
                hero:useCard(self.button_ex.skillEx:getBuffId())
            end
        end
    end)

--快捷聊天相关初始化
    local fastChat = {2100163 ,2100164 ,2100165,2100166}
    self.Panel_pause  = TFDirector:getChildByPath(self.panel_root, "Panel_pause")
    self.Panel_menu   = TFDirector:getChildByPath(self.Panel_pause, "Panel_menu"):hide()
    self.Button_talk  = TFDirector:getChildByPath(self.Panel_pause, "Button_talk"):hide()
    self.Spine_face   = TFDirector:getChildByPath(self.Panel_pause, "Spine_face"):hide()
    
    self.Panel_menu.selectItems = {}
    for i=1,4 do
        local Image_select = self.Panel_menu:getChildByName("Image_select_"..i)
        local Image_noraml = self.Panel_menu:getChildByName("Image_"..i)
        local Label_font_select = TFDirector:getChildByPath(Image_select, "Label_font")
        local Label_font_normal = TFDirector:getChildByPath(Image_noraml, "Label_font")
        Label_font_select:setTextById(fastChat[i])
        Label_font_normal:setTextById(fastChat[i])
       self.Panel_menu.selectItems[i] = Image_select
    end
    -- self:showButtonChat(function(selectIndex)
    --     dump({"selectIndex:",selectIndex})
    -- end)
end

-- 2100163 活动作战-联机副本   打招呼
-- 2100164 活动作战-联机副本   点赞
-- 2100165 活动作战-联机副本   攻击
-- 2100166 活动作战-联机副本   快复活

function KeyBoard:onSkillExChange(skillEx)
    self.button_ex:show()
    self.button_ex.skillEx = skillEx
    local icon = skillEx:getIcon()
    if self.button_ex.__icon ~= icon then  
        self.button_ex.Image_icon:setTexture(icon)
        self.button_ex.Image_icon:setScale(0.5)
        self.button_ex.__icon = icon
    end  
    if skillEx:isEnabled() then 
        if skillEx:isCD() then 
            self.button_ex:setTouchEnabled(false)
            self.button_ex.Image_mask:show()  
            self.button_ex.Label_cdTime:show()
            local sTime = math.ceil(skillEx:getCDTime()*0.001)
            self.button_ex.Label_cdTime:setText(tostring(sTime))
        else
            self.button_ex:setTouchEnabled(true)
            self.button_ex.Image_mask:hide()  
            self.button_ex.Label_cdTime:hide()
        end
    else
        self.button_ex:setTouchEnabled(false)
        self.button_ex.Image_mask:show()  
        self.button_ex.Label_cdTime:hide()
    end
    local useTimes = skillEx:getUseTimes()
    local maxTimes = skillEx:getMaxUseTimes()
    self.button_ex.Label_times:setText(useTimes.."/"..maxTimes) 
end


--新增死亡能量获得效果
local Ran_Posy = { 300 , -300 , 0}
function KeyBoard:showParticles(position)
    --起始特效
    local function playEfect(effectName,animation,position,callFunc)
        local skeletonNode = ResLoader.createEffect(effectName,1)
        skeletonNode:play(animation,0)
        skeletonNode:setPosition(position)
        skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
            if callFunc then
                callFunc()
            end
            _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
            _skeletonNode:removeFromParent()
        end)
        self.panel_effect:addChild(skeletonNode)
    end
    --粒子特效
    local function flyEfect()
        local effectParticle 
        if self.prefabe_particle then
            effectParticle = self.prefabe_particle:clone():show()
        else
            effectParticle = TFParticle:create("particles/effect_monster_energy.plist")
        end
        if not effectParticle then  return end 
        effectParticle:show()
        effectParticle:setScale(0.7)
        self.panel_effect:addChild(effectParticle)
        effectParticle:setVisible(true)
        effectParticle:setPosition(position)
        effectParticle:resetSystem()  
        local targetPos  = self.vKeyNodes[eVKeyCode.SKILL_F]:getPosition()
        local centerPos = me.p(targetPos.x - 300 , targetPos.y + Ran_Posy[RandomGenerator._random(1,3)] )
        local time = (me.pGetDistance(position,centerPos) + me.pGetDistance(centerPos,targetPos))/800
        local actions = 
        {
            EaseSineOut:create(
                BezierTo:create(time, {position, centerPos, targetPos})
                )
            ,
            CallFunc:create(function()
                playEfect("effect_monster_die","effect_monster_die2",targetPos)
                effectParticle:removeFromParent()
            end)
        }
        effectParticle:runAction(Sequence:create(actions))
    end
    -- playEfect("effect_monster_die","effect_monster_die1",position,function()
        flyEfect()
    -- end)
end

function KeyBoard:showRevive()
    self.panel_ctrlpad:hide()
    local reviveData = TeamFightDataMgr:getReviveData()
    if not reviveData then return end
    local params = reviveData.params
    self.panel_revive:getChildByName("Label_revive_value"):setTextById(14110440,params.has_revive_times)
    local cost_panel = TFDirector:getChildByPath(self.panel_revive,"Panel_cost")
    local free_panel = TFDirector:getChildByPath(self.panel_revive,"Panel_free")
    if params.cost_count == 0 then
        cost_panel:setVisible(false)
        free_panel:setVisible(true)
    else
        cost_panel:setVisible(true)
        free_panel:setVisible(false)

        local costitemCfg = GoodsDataMgr:getItemCfg(params.cost_id)
        cost_panel:getChildByName("Image_cost_icon"):setTexture(costitemCfg.icon)
        cost_panel:getChildByName("Image_cost_icon"):setContentSize(me.size(60,60))
        cost_panel:getChildByName("Label_cost_value"):setString(tostring(params.cost_count))
    end
    self.button_revive:onClick(function()
        if reviveData.reviveCount <= 0 then
            Utils:showTips(2100147)
        elseif GoodsDataMgr:currencyIsEnough(params.cost_id, params.cost_count) == false then
            Utils:showTips(2100146)
        else
            if params.reviveCallback then
                params.reviveCallback()
            end
        end
    end)
    self.panel_revive:show()
    self.panel_revive:setTouchEnabled(true)
    self.button_revive:setTouchEnabled(true)
end

function KeyBoard:hideRevive()
    self.panel_revive:hide()
    self.panel_revive:setTouchEnabled(false)
    self.button_revive:setTouchEnabled(false)
    self.panel_ctrlpad:show()
end

function KeyBoard:doSubSkillAction(node,isShow)
    if not node.showingState and not isShow then
        return
    end
    node.showingState = isShow
    node:stopAllActions()
    if isShow then
        node:setVisible(true)
        node:setOpacity(0)
        local actions = 
        {
            FadeTo:create(0.1,255)
            ,
            CallFunc:create(function()
                
            end)
        }
        node:runAction(Sequence:create(actions))
    else
        if node:isVisible() then
            node:setVisible(true)
            node:setOpacity(255)
            local actions = 
            {
                FadeTo:create(0.1,1)
                ,
                CallFunc:create(function()
                    node:setVisible(false)
                end)
            }
            node:runAction(Sequence:create(actions))
        end
    end
end

function KeyBoard:onSubSkillChange(skill)
    if not skill:isVisiable() then 
        return
    end
    local keyNode = self.vKeyNodes[skill:getKeyCode()]
    if not keyNode.Panel_sub_skill then
        return
    end
    if keyNode.Panel_sub_skill:isVisible() then
        self:doSubSkillAction(keyNode.Panel_sub_skill, false)
    else
        self:doSubSkillAction(keyNode.Panel_sub_skill, true)
    end
end

function KeyBoard:onVKStateChange(skill,flag)
    if flag then
        self:onCaptainChange()
        return
    end
    if not skill:isVisiable() then 
        return
    end

    local keyNode = self.vKeyNodes[skill:getKeyCode()]
    if keyNode then
        
        --觉醒技能
        if keyNode.widgetName == "F" then
            keyNode:setTouchEnabled(skill:_isEnoughAnger() and skill:_isEnoughSpecialEnergy())
            local percent = skill.hero:getAngerPercent()*0.01
            -- print("xxxxx",percent)
            -- Box("percent:"..tostring(percent))
            if keyNode.progress then
                keyNode.progress:setVisible(true)
                keyNode.progress:setPercent(percent)
            end
            if keyNode.cdTime then
                local cdTime = skill:getCDTime()
                cdTime = math.ceil(cdTime*0.001)
                if cdTime > 0 then  
                    if keyNode.cdTime.time ~= cdTime then
                        keyNode.cdTime:show()
                        keyNode.cdTime:setText(tostring(cdTime))
                        keyNode.cdTime.time = cdTime
                    end
                else
                    keyNode.cdTime.time = 0 
                    keyNode.cdTime:hide()
                end
            end

            if keyNode.image_silence then
                local slience = skill:getSilence()
                if slience == 2 then 
                    keyNode.image_silence:show()
                    keyNode.image_lock:show()
                elseif slience == 1 then 
                    keyNode.image_silence:show()
                    keyNode.image_lock:hide()
                else
                    keyNode.image_silence:hide()
                end
            end


        else
            -- local percent = 100 - skill:getCDPercent()
            -- if keyNode.progress then
            --     keyNode.progress:setVisible(true)
            --     keyNode.progress:setPercent(percent*0.8)
            -- end

            

            if keyNode.cdTime then
                local cdTime = skill:getCDTime()
                local test = cdTime 
                cdTime = math.ceil(cdTime*0.001)
                if cdTime > 0 then  
                    if keyNode.cdTime.time ~= cdTime then
                        keyNode.cdTime:show()
                        keyNode.cdTime:setText(tostring(cdTime))
                        keyNode.cdTime.time = cdTime
                    end
                else
                    keyNode.cdTime.time = 0
                    keyNode.cdTime:hide()
                end
            end
            local cacheTimes = skill:getCacheTimes()
            local maxTimes   = skill:getMaxCacheTimes()
            local bEnoughEnergy = skill:_isEnoughEnergy() and skill:_isEnoughSpecialEnergy()
            if cacheTimes > 0 then
                keyNode:setTouchEnabled(bEnoughEnergy)
            else
                keyNode:setTouchEnabled(false)
            end
            if keyNode.consume then
                keyNode.consume:setActive(bEnoughEnergy,skill:getCostEnergyShow())
            end

            if keyNode.cacheTimes then
                if maxTimes > 1 then
                    keyNode.cacheTimes:show()
                    keyNode.cacheTimes:setText(cacheTimes)
                else
                    keyNode.cacheTimes:hide()
                end
            end
            --能量不够图标才置灰
            -- keyNode:setGrayEnabled(not skill:_isEnoughEnergy())
            if keyNode.image_silence then
                local slience = skill:getSilence()
                -- print_("slience:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"..slience)
                if slience == 2 then 
                    keyNode.image_silence:show()
                    keyNode.image_lock:show()
                elseif slience == 1 then 
                    keyNode.image_silence:show()
                    keyNode.image_lock:hide()
                else
                    keyNode.image_silence:hide()
                end
            end

        end
    end
end
function KeyBoard:onCaptainChange()
    local hero = battleController.getCaptain()
    if hero then
        self.image_background:show()
        if battleController.skillEx then 
            self:onSkillExChange(battleController.skillEx)
        end
    end
    --队长变更刷新技能按钮
    if hero then
        local dibanType = 1
        for keyCode , keyNode in pairs(self.vKeyNodes) do
            local skill = hero:getSkill(keyCode)
            if not skill then
                -- Box("keyCode::"..keyCode.." "..keyNode.widgetName)
                keyNode:setTouchEnabled(false)
                keyNode:setVisible(false)
                BattleGuide:updateKeyShowStat(keyCode,false)
            else
                -- print("skill:getData().icon",skill:getData().id ,keyCode, skill:getData().keyName  ,skill:getData().icon)
                local data = skill:getData()
                if skill:hasAnimation() then
                    if keyNode.skeletonNode then
                        keyNode._bTouchEnabled = nil
                        if keyNode.skeletonNode.resName_ ~= data.useWarn then
                            keyNode.skeletonNode:removeFromParent()
                            keyNode.skeletonNode = ResLoader.createEffect(data.useWarn,1)
                            keyNode.skeletonNode.resName_ = data.useWarn
                            keyNode.skeletonNode.appearAction     = data.appearAction
                            keyNode.skeletonNode.continuousAction = data.continuousAction
                            keyNode:addChild(keyNode.skeletonNode)
                        end
                    else
                        keyNode._bTouchEnabled = nil
                        keyNode.skeletonNode = ResLoader.createEffect(data.useWarn,1)
                        keyNode.skeletonNode.resName_ = data.useWarn
                        keyNode.skeletonNode.appearAction     = data.appearAction
                        keyNode.skeletonNode.continuousAction = data.continuousAction
                        keyNode:addChild(keyNode.skeletonNode)
                    end
                else
                    if keyNode.skeletonNode then
                        keyNode.skeletonNode:removeFromParent()
                        keyNode.skeletonNode = nil
                    end
                end

                keyNode.icon:setTexture(skill:getData().icon)
                if keyNode.image_name then
                    if data.keyTap and data.keyTap ~= "" then
                        keyNode.image_name:show()
                        keyNode.image_name:setTexture(data.keyTap)
                    else
                        keyNode.image_name:hide()
                    end
                end
                --是否显示变身按钮
                if keyNode.exchange then
                    local symbol = skill:getData().symbol
                    if symbol and symbol ~= "" then
                        keyNode.exchange:setTexture(skill:getData().symbol)
                        keyNode.exchange:setVisible(true)
                    else
                        keyNode.exchange:setVisible(false)
                    end
                end
                --子技能按钮
                VKeySubSkill[keyCode] = false
                if keyNode.Panel_sub_skill then
                    for i=1,3 do
                        local subSkill = skill:getData().skillSubclasses[i]
                        if subSkill then
                            VKeySubSkill[keyCode] = true
                            keyNode["Image_sub_icon"..i]:setVisible(true)
                            keyNode["Image_sub_skillbg_"..i]:setVisible(false)
                            keyNode["Image_sub_icon"..i]:setTexture(skill:getData().subclassesPicture[i] or "")
                        else
                            keyNode["Image_sub_icon"..i]:setVisible(false)
                            keyNode["Image_sub_skillbg_"..i]:setVisible(false)
                        end
                    end
                end

                if keyNode.cdTime then
                    local cdTime = skill:getCDTime()
                    cdTime = math.ceil(cdTime*0.001)
                    if cdTime > 0 then 
                        keyNode.cdTime:show()
                        if keyNode.cdTime.time ~= cdTime then
                            keyNode.cdTime:setText(tostring(cdTime))
                            keyNode.cdTime.time = cdTime
                        end
                    else
                        keyNode.cdTime.time = 0
                        keyNode.cdTime:hide()
                    end
                end

                local cacheTimes = skill:getCacheTimes()
                local maxTimes   = skill:getMaxCacheTimes()
                local bEnoughEnergy = skill:_isEnoughEnergy() and skill:_isEnoughSpecialEnergy()
                if cacheTimes > 0 then
                    keyNode:setTouchEnabled(bEnoughEnergy)
                else
                    keyNode:setTouchEnabled(false)
                end
                if keyNode.consume then
                    local costValue = skill:getCostEnergyShow()
                    keyNode.consume:setText(tostring(math.abs(costValue)))
                    keyNode.consume:setVisible(costValue ~= 0)
                    keyNode.consume:setActive(bEnoughEnergy,costValue)
                end

                if keyNode.cacheTimes then
                    if maxTimes > 1 then
                        keyNode.cacheTimes:show()
                        keyNode.cacheTimes:setText(cacheTimes)
                    else
                        keyNode.cacheTimes:hide()
                    end
                end
        
                keyNode:setTouchEnabled(true)
                keyNode:setVisible(true)

                BattleGuide:updateKeyShowStat(keyCode,true)
                self:onVKStateChange(skill)
                if keyCode == eVKeyCode.SKILL_I then 
                    dibanType = 2
                end
            end
        end
        if battleController.useCustomAttrModle() then
            dibanType = 3
        end
        if dibanType == 2 then 
            self.skillKeyBG_B:show()
            self.skillKeyBG_A:hide()
        elseif dibanType == 3 then 
            self.skillKeyBG_B:hide()
            self.skillKeyBG_A:hide()
        else
            self.skillKeyBG_B:hide()
            self.skillKeyBG_A:show()
        end
    end

end

local function _convertPosition(node,position)
    position = node:convertToNodeSpace(position)
    local size  = node:getSize()
    position.x = position.x - size.width/2
    position.y = position.y - size.height/2
    -- dump(position)
    return position
end

--计算摇杆位置
function KeyBoard:calcuCenterPos(target)
    local defaultPos = self.image_background.initPos
    if BattleConfig.ROKER_FIX_POSTION then
        self.image_background:setPosition(defaultPos)
    else
        local _touchPos = me.p(target:getTouchStartPos())
        _touchPos = _convertPosition(target,_touchPos)
        local touchPos  = me.pSub(_touchPos,defaultPos)
        -- dump({_touchPos , defaultPos})
        local _R  = BattleConfig.ROKER_R --活动范围半径
        local _SR = me.pGetLength(touchPos)
        if _SR < _R then
            self.image_background:setPosition(_touchPos)
        else
            _touchPos.x  = _R/_SR*touchPos.x
            _touchPos.y  = _R/_SR*touchPos.y
            self.image_background:setPosition(me.pAdd(_touchPos,defaultPos))
        end
    end
end

--摇杆操作
function KeyBoard:onTouch(event)
    -- print("Roker touch event:",event.name)
    local name   = event.name
    local target = event.target

    if name == "began" then
        self:calcuCenterPos(target)
        self.image_background:setOpacity(255)
        self.button_ctrl:stopAllActions()
        self.button_ctrl:setPosition(me.p(0,0))
        -- self.button_ctrl:setTexture(PRESSED_TEXTURE)
        self.button_ctrl:setHighLightEnabled(true)
        BattleGuide:onDirectTouch()
    elseif name == "moved" then
        local touchPos = me.p(target:getTouchMovePos())
        touchPos = _convertPosition(target,touchPos)
        local pos = self.image_background:getPosition()
        touchPos = me.pSub(touchPos,pos)
        local length = me.pGetLength(touchPos)
        if length < 20 then
            --更新小点点的位置
            self.button_ctrl:setPosition(touchPos)
            KeyBoard.setRokeVector(0,0)
            self.image_ctrl:hide()
            return
        elseif length < Radius then
            self.button_ctrl:setPosition(touchPos)
            self:calcuRokerState(touchPos)
        else
            self:calcuRokerState(touchPos)
            self.button_ctrl:setPosition(touchPos)
        end
        self.image_ctrl:show()
    elseif name == "ended" then
         --归位
        self.image_background:setOpacity(150)
        local defaultPos = self.image_background.initPos -- me.p(150,140)
        self.image_background:setPosition(defaultPos)
        -- self.button_ctrl:setTexture(NORMAL_TEXTURE)
        self.button_ctrl:setHighLightEnabled(false)
        self.button_ctrl:stopAllActions()
        self.button_ctrl:runAction(MoveTo:create(0.1,me.p(0,0)))
        self.image_ctrl:hide()
        KeyStateMgr.clearKeyState()
        KeyBoard.setRokeVector(0,0)
    end
end

function KeyBoard:transPos(pos)
    local defaultPos = self.image_background.initPos
    pos.x = pos.x - defaultPos.x
    pos.y = pos.y - defaultPos.y
    return pos
end


function KeyBoard:calcuRokerState(touchPos)
    --计算摇杆位置
    local distance = me.pGetDistance(touchPos,me.p(0,0))
    KeyBoard.setRokeVector(touchPos.x/distance,touchPos.y/distance)
    touchPos.x = Radius/distance * touchPos.x
    touchPos.y = Radius/distance * touchPos.y
    --TODO 可以适当优化
    --计算角度
    local angle    = pGetAngle(ccp(0,0),touchPos)
    local angle = -angle*180/math.pi + 90
    self.image_ctrl:setRotation(angle)
end

local function bindFunc(node)
    node.setGrayEnabled = function (self,enabled)
        -- self.icon:setGrayEnabled(enabled)
    end

    node.setTouchEnabled = function (node,enabled)
        -- node:setHighLightEnabled(false,true)
        -- node:setGrayEnabled(not enabled)
        -- node:setEnabled(enabled)
        if node.widgetName == "F" then
            node.icon:setOpacity(enabled and 255 or 100)
            node:setBright(enabled)
        end

        CCNode.setTouchEnabled(node,enabled)
        if node.mask then
            node.mask:setVisible(not enabled)
        end
        if node.Panel_sub_skill and not enabled and node.Panel_sub_skill:isVisible() then
            KeyBoard:doSubSkillAction(node.Panel_sub_skill, false)
        end
        if node.effect then
            node.effect:setVisible(enabled)
            if enabled and node._bTouchEnabled ~= enabled then
                node.effect:playByIndex(0,1)
            end
        end

        if node.skeletonNode then 
            node.skeletonNode:setVisible(enabled)
            if enabled then
                if node._bTouchEnabled ~= enabled then
                    node.skeletonNode:play(node.skeletonNode.appearAction, 0)
                    node.skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
                        node.skeletonNode:play(node.skeletonNode.continuousAction,1)
                        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                    end)
                end
            end
        end
        node._bTouchEnabled = enabled
    end
end
function KeyBoard:registerEvents()
    -- printError("KeyBoard:registerEvents")
    self.panel_roke_touch:setTouchEnabled(true)
    self.panel_roke_touch:onTouch(function(event)
        if self.image_background:isVisible() then
            self:onTouch(event)
        end
    end)
    -----
    for vKeyCode , bindInfo in pairs (VKeyBind) do
        local pKeyCodes = bindInfo.bindPKeyCodes
        local widgetName = bindInfo.bindWidgetName
        for _ , pKeyCode in ipairs (pKeyCodes) do
            self:registerPKeyEvent(pKeyCode,vKeyCode)
        end
        --虚拟按键组件事件绑定
        if widgetName then
            print("widgetName:","Button_ctrl"..widgetName)
            local vKeyNode     = TFDirector:getChildByPath(self.panel_ctrlpad, "Button_ctrl"..widgetName)
            vKeyNode.widgetName= widgetName
            vKeyNode.effect    = vKeyNode:getChildByName("Spine_effect")--特效
            if vKeyNode.effect then
                vKeyNode.effect:hide()
            end
            vKeyNode.image_name = vKeyNode:getChildByName("Image_name") --按键显示的名称
            vKeyNode.image_silence = vKeyNode:getChildByName("Image_silence")
            if vKeyNode.image_silence then
                vKeyNode.image_lock = vKeyNode.image_silence:getChildByName("Image_lock")
                vKeyNode.image_silence:hide()
            end

            vKeyNode.active       = vKeyNode:getChildByName("Image_active")
            vKeyNode.progress     = vKeyNode:getChildByName("LoadingBar")
            vKeyNode.exchange     = vKeyNode:getChildByName("Image_exchange")
            -- if not vKeyNode.progress then
            --     Box("vKeyNode is null "..tostring(widgetName))
            -- end
            vKeyNode.icon         = vKeyNode:getChildByName("Image_icon")
            if widgetName == "A" then
                vKeyNode.icon:setScale(0.9)
            elseif widgetName == "I" then
            elseif widgetName == "B" then
                vKeyNode.icon:setScale(0.6)
            else
                vKeyNode.icon:setScale(0.75)
            end
            vKeyNode.consume      = vKeyNode:getChildByName("Label_sp")
            vKeyNode.cdTime       = vKeyNode:getChildByName("Label_cdTime")
            vKeyNode.cacheTimes   = vKeyNode:getChildByName("Label_cacheTimes")
            vKeyNode.Panel_sub_skill   = vKeyNode:getChildByName("Panel_sub_skill")
            if vKeyNode.cacheTimes then
                vKeyNode.cacheTimes:hide()
            end
            if vKeyNode.cdTime then
                vKeyNode.cdTime:setSkewX(15)
            end
            vKeyNode.mask         = vKeyNode:getChildByName("Image_mask")
            if vKeyNode.mask then
                vKeyNode.mask:hide()
            end
            if vKeyNode.Panel_sub_skill then
                for i=1,3 do
                    vKeyNode["Image_sub_skillbg_"..i]   = vKeyNode:getChildByName("Image_sub_skillbg_"..i)
                    vKeyNode["Image_sub_icon"..i]   = vKeyNode:getChildByName("Image_sub_icon"..i)
                    vKeyNode["Panel_sub_rect"..i]   = vKeyNode:getChildByName("Panel_sub_rect"..i)
                end

                vKeyNode.Panel_sub_skill:setVisible(false)
            end
            if vKeyNode.consume then
                 vKeyNode.consume:setSkewX(15)
                vKeyNode.consume.setActive = function(self , active, value)
                    if active then
                        self:setFontColor(me.WHITE)
                        if value > 0 then
                            self:enableStroke(ccc3(0xfd,0x38,0x70),1)
                        else
                            self:enableStroke(ccc3(18,32,136),1)         
                        end
                    else
                        self:setFontColor(me.BLACK)
                        self:enableStroke(ccc3(0x22,0x26,0x2d),1)
                        -- self:enableStroke(me.WHITE,1)
                        -- self:enableStroke(ccc3(0xfd,0x38,0x70),1)
                    end
                end
                vKeyNode.consume:setActive(true,0)
            end
            bindFunc(vKeyNode)
            vKeyNode:setTouchEnabled(false)
            -- vKeyNode:setGrayEnabled(false)
            vKeyNode:setVisible(false)


            self:registerVKeyEvent(vKeyNode,vKeyCode)
        end
    end
end



function KeyBoard:removeEvents()
    self:stopTimer()
    self:unRegisterPKeyEvent()
    KeyStateMgr.clear()
    EventMgr:removeEventListenerByTarget(self)
    me.Director:getEventDispatcher():setSingleEnabled(true)
end
function KeyBoard:registerVKeyEvent(vKeyNode,vKeyCode)
    vKeyNode:onTouch(function(event)
        local name   = event.name
        local target = event.target
        if name == "began" then
           -- vKeyNode:setHighLightEnabled(true,true)
           local startpos = target:getTouchStartPos()
           self:doKeyPressed(vKeyCode)
        elseif event.name == "moved" then
            local movepos = target:getTouchMovePos()
            self:doKeyMoved(vKeyCode,movepos)
        elseif name == "ended" then
            local endtpos = target:getTouchEndPos()
           -- vKeyNode:setHighLightEnabled(false,true)
           self:doKeyReleased(vKeyCode)
        end
    end)
    self.vKeyNodes[vKeyCode] = vKeyNode
    BattleGuide:registCtrlKey(vKeyCode,vKeyNode)
    BattleGuide:updateKeyShowStat(vKeyCode,false)
end

----------------------------长按事件

function KeyBoard:doKeyPressed(keyCode)
    if VKeySubSkill[keyCode] then
        local vKeyNode = self.vKeyNodes[keyCode]
        vKeyNode.selectSubIdx = 0
        if vKeyNode.Panel_sub_skill then
            self:doSubSkillAction(vKeyNode.Panel_sub_skill, true)
        end
        return
    end
    
    KeyStateMgr.doKeyPressed(keyCode)
    self:startTimer(keyCode)
end

function KeyBoard:doKeyMoved(keyCode,movepos)
    if VKeySubSkill[keyCode] then
        local vKeyNode = self.vKeyNodes[keyCode]
        if vKeyNode and vKeyNode.Panel_sub_skill then
            vKeyNode.selectSubIdx = 0
            movepos = vKeyNode.Panel_sub_skill:convertToNodeSpace(movepos)
            for i=1,3 do
                vKeyNode["Image_sub_skillbg_"..i]:setVisible(false)
                if vKeyNode["Image_sub_icon"..i]:isVisible() then
                    local rect = vKeyNode["Image_sub_icon"..i]:boundingBox()
                    if me.rectContainsPoint(rect,movepos) then
                        vKeyNode.selectSubIdx = i
                        vKeyNode["Image_sub_skillbg_"..i]:setVisible(true)
                    end 
                end
            end
        end
        return
    end
end

function KeyBoard:doKeyReleased(keyCode)
    if VKeySubSkill[keyCode] then
        local vKeyNode = self.vKeyNodes[keyCode]
        if vKeyNode.selectSubIdx and vKeyNode.selectSubIdx > 0 then
            KeyStateMgr.doKeyPressed(keyCode,vKeyNode.selectSubIdx)
        end
        vKeyNode.selectSubIdx = 0
        if vKeyNode.Panel_sub_skill then
            self:doSubSkillAction(vKeyNode.Panel_sub_skill, false)
        end
        return
    end
    KeyStateMgr.doKeyReleased(keyCode)
    self:stopTimer()
end
--按键长按
function KeyBoard:doKeyDoing(keyCode)
    if VKeySubSkill[keyCode] then
        return
    end
    KeyStateMgr.doKeyDoing(keyCode)
end



--长按检查
function KeyBoard:startTimer(keyCode)
    self:stopTimer()
    local timerID
    timerID = TFDirector:addTimer(200, 1, function ()
        if self.stopTimer == nil then
            TFDirector:removeTimer(timerID)
        else
            self:stopTimer()
            self:doKeyDoing(keyCode)
        end
    end)
    self.timerID = timerID
end

function KeyBoard:stopTimer()
    if self.timerID then
        TFDirector:removeTimer(self.timerID)
    end
    self.timerID = nil
end

---------------------------键盘输入的相关处理-----------------------

function KeyBoard:doPKeyPressed(keyCode)
    if self.preKeyCode ~= keyCode then
        self:doKeyPressed(keyCode)
        self.preKeyCode = keyCode
    end
end

function KeyBoard:doPKeyReleased(keyCode)
    self:doKeyReleased(keyCode)
    self.preKeyCode  = -1
end


function KeyBoard:registerPKeyEvent(pKeyCode,vKeyNode)
    if me.platform == "win32" and DEBUG == 1 then
        print("registerPKeyEvent ",pKeyCode , vKeyNode)
        self.pKeyPressedHandles    = self.pKeyPressedHandles or {}
        self.pKeyReleasedHandles   = self.pKeyReleasedHandles or {}
        local pressedHandle = handler(self.doPKeyPressed,self)
        local releaseHandle = handler(self.doPKeyReleased,self)
        self.pKeyPressedHandles[pKeyCode]  = pressedHandle
        self.pKeyReleasedHandles[pKeyCode] = releaseHandle
        if TFDirector.registerKeyDown then
            TFDirector:registerKeyDown(pKeyCode, {nGap = 0}, pressedHandle,vKeyNode)
        end
        if TFDirector.registerKeyUp then
            TFDirector:registerKeyUp(pKeyCode, {nGap = 0}, releaseHandle,vKeyNode)
        end
    end
end

function KeyBoard:unRegisterPKeyEvent()
    if me.platform == "win32" and DEBUG == 1 then
        if self.pKeyPressedHandles then
            for pKeyCode , pKeyHandle in pairs(self.pKeyPressedHandles) do
                TFDirector:unRegisterKeyDown(pKeyCode,pKeyHandle)
            end
            self.pKeyPressedHandles = nil
        end
        if self.pKeyReleasedHandles then
            for pKeyCode , pKeyHandle in pairs(self.pKeyReleasedHandles) do
                TFDirector:unRegisterKeyUp(pKeyCode,pKeyHandle)
            end
            self.pKeyReleasedHandles = nil
        end
    end
end



return KeyBoard