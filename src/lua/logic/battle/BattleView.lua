local IconListView = import(".IconListView")
local BattleUtils = import(".BattleUtils")
local BattleConfig = import(".BattleConfig")
local BattleTimerManager = import(".BattleTimerManager")
local ResLoader  = import(".ResLoader")
local BattleMap = import(".BattleMap")
local Hero = import(".Hero")
local BattleController  = import(".BattleController")
local BattleCamera = import(".BattleCamera")
local AwakeMgr    = import(".AwakeMgr")
local enum        = import(".enum")
local eCampType   = enum.eCampType
local eState      = enum.eState
local eStateEvent = enum.eStateEvent
local eEvent      = enum.eEvent
local eCameraFlag = enum.eCameraFlag
local eHurtType   = enum.eHurtType
local eDir        = enum.eDir
local eShakeType  = enum.eShakeType
local eShowState  = enum.eShowState
local eBufferEffectIconEvent = enum.eBufferEffectIconEvent
local KeyBoard    = import(".KeyBoard")
local BattleMgr   = import(".BattleMgr")
local heroMgr     = BattleMgr.getHeroMgr()
local obstacleMgr = BattleMgr.getObstacleMgr()
local LockStep   = import(".LockStep")
local GameObject  = import(".GameObject")
local BattleGuide = import(".BattleGuide")
local AIAgent = import(".AIAgent")
local KeyStateMgr    = import(".KeyStateMgr")

local Roulette = import(".Roulette")
local BattleView = class("BattleView", BaseLayer)
CREATE_SCENE_FUN(BattleView)
--积分模式 积分区间映射的特效动作名
local score_effect_animations = {{"d_born","d_loop"},{"c_born","c_loop"},{"b_born","b_loop"},{"a_born","a_loop"},{"s_born","s_loop"}}

local eShaderType =
{
    BLUR    = 1,
    BLAST   = 2,
    DEFAULT = 3,
}

local eNumNodeType =
{
    PuGong    = 1,
    JiNeng    = 2,
    BaoJi     = 3,
    ChuanTou  = 4,
    Ruodian   = 5,
    ZhiYu     = 6,
    BaojiChuanTou   = 10,
}
local sinalQuality = {
        {ping = 150,percent = 20,color = ccc3(255,50,0)},
        {ping = 120,percent = 40,color = ccc3(255,200,0)},
        {ping = 90,percent = 60,color = ccc3(200,200,0)},
        {ping = 66,percent = 80,color = ccc3(120,200,0)},
        {ping = 0,percent = 100,color = ccc3(0,200,0)},
    }

function BattleView:_onExit()
    --战斗数据清理
    self:exitBattle()
    me.TextureCache:removeUnusedTextures()
    TFDirector:clearMovieClipCache()
    me.FrameCache:removeUnusedSpriteFrames()
    SpineCache:getInstance():clearUnused();
    GuideDataMgr:setIsBattle(false)
end

function BattleView:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
    if self.keyBoard then
        self.keyBoard:removeEvents()
    end
end

function BattleView:initData()
    if self.levelType_ == EC_FBLevelType.PRACTICE then
        self.practice_atk_toggle = false
        self.practice_infinite_toggle = false
        self.practice_hurt_toggle = false
        self.statistics_.practiceTimePause = true
        AIAgent:setEnabled(self.practice_atk_toggle)
    end
    self.elementCfg = TabDataMgr:getData("Restrain")
end

function BattleView:ctor(...)
    self.super.ctor(self, ...)
    self.lastTime = 0
    self.endMsgFlag_ = false
    self.endAniFlag_ = false
    self.uProgressFlag_ = false
    self.dropReward_ = {}
    self.fuzzyTime  = 0
    self.fuzzyLevel = 0
    self.fuzzyDecay = 0
    self.blastLevel = 0
    self.pause_ = false
    self.timing_ = nil
    self.endlessJumpLevel_ = nil
    BattleGuide:clear()
    local data = BattleDataMgr:getBattleData()
    -- battleController.init(data)
    battleController.view = self
    self.battleType_ = data.battleType
    self.levelCid_ = data.pointId
    self.statistics_ = battleController.getStatistics()
    self.victoryDecide_ = battleController.getVictoryDecide()
    self.levelCfg_ = BattleDataMgr:getLevelCfg()
    self.levelType_ = self.levelCfg_.dungeonType
    self.isCountdwon_ = (self.levelCfg_.time > 0)
    self.passLevelCond_ = self.victoryDecide_.nViewType

    

    self:initData()

    self:init("lua.uiconfig.battle.battleView")
    --加载地图
    self:loadMap()
    --创建摄像机
    self.camera = BattleCamera:new(battleController)
    --初始化战斗管理器
    self:refreshView()


--Test 裁剪
    -- local node = self.role_prefabs1:clone()
    -- self.Panel_ui:addChild(node)
end

local function showNodeSize(...)
    local nodes = {...}
    local texts = ""
    for i, node in ipairs(nodes) do
        local name = node:getName()
        local size = node:getSize()
        if #texts > 0 then
            texts = texts .."\n"
        end
        texts =  texts .. string.format("%s size[%s,%s]",name , size.width,size.height)
    end
    Box(texts)
end

--显示切换场景
function BattleView:showChangeDungeon()
    local size = self.Panel_ui_effect_top:getSize()
    local node = self.image_changedungeon:clone()
    node:show()
    local text = node:getChildByName("Label_fallow")
    if battleController.isLeader() then 
        text:setTextById(14110261)
    else
        text:setTextById(14110262)
    end
    text:setSkewX(15)
    node:setPosition(ccp(size.width/2,size.height*3/4))
    self.Panel_ui_effect_top:addChild(node)
end

function BattleView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_prefabs  = TFDirector:getChildByPath(ui, "Panel_prefabs"):hide()
    self.Panel_modality = TFDirector:getChildByPath(ui, "Panel_modality"):hide()
    self.Panel_modality:setTouchEnabled(false)

    self.image_changedungeon = TFDirector:getChildByPath(self.Panel_prefabs, "Image_changedungeon")
    self.image_changedungeon:hide()

    -- 战斗层
    self.Panel_fight   = TFDirector:getChildByPath(ui, "Panel_fight")
    self.Panel_map     = TFDirector:getChildByPath(self.Panel_fight, "Panel_map")
    self.Panel_effect  = TFDirector:getChildByPath(self.Panel_fight, "Panel_effect")
    -- showNodeSize(self.Panel_fight,self.Panel_map,self.Panel_effect)
    --连击
    self.Panel_combo           = TFDirector:getChildByPath(ui, "Panel_combo")
    BattleMgr.bindActionMgr(self.Panel_combo)
    self.Panel_combo:hide()
    self.image_combo           = TFDirector:getChildByPath(self.Panel_combo, "Image_hits")
    self.labelBMFont_combo_num = TFDirector:getChildByPath(self.Panel_combo, "LabelBMFont_combo")
--TODO 解决控件 ScaleTo 无效果的问题
    local parentNode = self.labelBMFont_combo_num:getParent()
    local pos = self.labelBMFont_combo_num:getPosition()
    local bmFont = CCLabelBMFont:create()
    bmFont:setFntFile("font/lianji.fnt")
    bmFont:setZOrder(999)
    bmFont:setPosition(pos)
    bmFont.setText = bmFont.setString
    parentNode:addChild(bmFont)
    self.labelBMFont_combo_num:removeFromParent()
    self.labelBMFont_combo_num = bmFont


    -- -TODO test
    -- self.labelBMFont_combo_num = TFLabelBMFont:create()
    -- self.labelBMFont_combo_num:setFntFile("font/lianji1.fnt");
    -- self.labelBMFont_combo_num:setPosition(ccp(200,200))
    -- self.labelBMFont_combo_num:setText("888")
    -- self:addChild(self.labelBMFont_combo_num,10000)

    print(".................")
    self.image_combo_bg = {}
    self.image_combo_bg[1]  = TFDirector:getChildByPath(self.Panel_combo, "Image_combo_bg")
    self.image_combo_bg[2]  = TFDirector:getChildByPath(self.Panel_combo, "Image_combo_fg")
    -- self.image_combo_bg[1]:hide()
    -- self.image_combo_bg[2]:hide()
    self.Panel_combo.loadingBar_time = TFDirector:getChildByPath(self.Panel_combo, "LoadingBar_time")
    -- ui层
    self.Panel_ui = TFDirector:getChildByPath(ui, "Panel_ui")
    self.Panel_top = TFDirector:getChildByPath(self.Panel_ui, "Panel_top")
    self.image_go  = TFDirector:getChildByPath(self.Panel_ui, "Image_gogo")
    --关卡胜利条件
    self.Panel_victory    = TFDirector:getChildByPath(self.Panel_ui, "Panel_victory"):hide()
    self.Image_common_victory = TFDirector:getChildByPath(self.Panel_victory, "Image_common_victory")
    self.textVictoryTitle  = TFDirector:getChildByPath(self.Image_common_victory, "Label_title")
    self.textVictorycontent= TFDirector:getChildByPath(self.Image_common_victory, "Label_content")

    self.Image_common_victory2 = TFDirector:getChildByPath(self.Panel_victory, "Image_common_victory2"):hide()
    self.Image_common_victory2.title     = TFDirector:getChildByPath(self.Image_common_victory2, "Label_title")
    self.Image_common_victory2.content   = TFDirector:getChildByPath(self.Image_common_victory2, "Label_content")
    self.Image_common_victory2.title:setSkewX(15)
    self.Image_common_victory2.content:setSkewX(15)
    self.Image_common_victory3 = TFDirector:getChildByPath(self.Panel_victory, "Image_common_victory3"):hide()
    self.Image_common_victory3.textVictoryStates= {}
    self.Image_common_victory3.textVictoryLines= {}
    for index = 1, 3 do
        local image_point = TFDirector:getChildByPath(self.Image_common_victory3, "Image_point"..index)
        self.Image_common_victory3.textVictoryLines[index]= image_point 
        if index < 3 then 
            local image_line = TFDirector:getChildByPath(self.Image_common_victory3, "Image_line"..index)
            self.Image_common_victory3.textVictoryLines[index]= image_line
        end
    end

    self.Image_common_victory4 = TFDirector:getChildByPath(self.Panel_victory, "Image_common_victory4"):hide()
    self.Image_common_victory4.label_time     = TFDirector:getChildByPath(self.Image_common_victory4, "Label_time")
    self.Image_common_victory4.add_time = TFDirector:getChildByPath(self.Image_common_victory4, "Label_add_time"):hide()
    self.Image_common_victory4.label_time:setSkewX(15)
    self.Image_common_victory4.add_time:setSkewX(15)
    --星级显示
    self.Panel_passcond = TFDirector:getChildByPath(self.Panel_top, "Panel_passcond"):hide()
    self.Panel_passcond.loadbar       = TFDirector:getChildByPath(self.Panel_passcond, "LoadingBar_passcond")
    self.Panel_passcond.spine_effect  = TFDirector:getChildByPath(self.Panel_passcond, "Spine_loadbar")
    self.Panel_passcond.star_status   = {}
    for index = 1,3 do
        local Image_pass_star  = TFDirector:getChildByPath(self.Panel_passcond, "Image_pass_star"..index)
        Image_pass_star.spine_effect           = Image_pass_star:getChildByName("Spine_star_effect")
        Image_pass_star.label_pass_value       = Image_pass_star:getChildByName("Label_pass_value")
        Image_pass_star.label_pass_value:setSkewX(15)
        Image_pass_star.value = 0
        Image_pass_star.image_star_active       = Image_pass_star:getChildByName("Image_star_active"):hide()
        self.Panel_passcond.star_status[index] = Image_pass_star
    end
    self.Panel_passcond.spine_effect:addMEListener(TFARMATURE_EVENT,function(skeletonNode)
        self.Panel_passcond.spine_effect:hide()
    end)

    self.image_halloween_1 = TFDirector:getChildByPath(self.Panel_victory, "Image_halloween_1")
    self.image_halloween_2 = TFDirector:getChildByPath(self.Panel_victory, "Image_halloween_2")
    self.image_halloween_1.loadingBar_score = TFDirector:getChildByPath(self.image_halloween_1, "LoadingBar_score")
    self.image_halloween_1.label_score_percent = TFDirector:getChildByPath(self.image_halloween_1.loadingBar_score, "Label_score_percent")
    self.image_halloween_1.label_score_percent:setSkewX(15)
    self.image_halloween_1.label_time = TFDirector:getChildByPath(self.image_halloween_1, "Label_time_1")
    self.image_halloween_2.label_time = TFDirector:getChildByPath(self.image_halloween_2, "Label_time_2")
    self.image_halloween_2.label_time:setSkewX(15)
    self.image_halloween_1.label_time:setSkewX(15)
    self.image_halloween_1:hide()
    self.image_halloween_2:hide()
    self.image_halloween_1.spine_halloween = TFDirector:getChildByPath(self.image_halloween_1, "Spine_halloween")
    self.image_halloween_1.spine_halloween:hide()
    self.image_halloween_1.spine_halloween:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
        skeletonNode:hide()
    end)

    self.image_time = TFDirector:getChildByPath(self.Panel_ui, "Image_v_time"):hide()
    self.label_time = TFDirector:getChildByPath(self.image_time , "Label_v_time")
    self.textVictoryTitle:setSkewX(15)
    self.textVictorycontent:setSkewX(15)

    --守护模式提示下一波

    self.image_next_time = TFDirector:getChildByPath(self.Panel_ui, "Image_next_time"):hide()
    self.rText_next_time = TFDirector:getChildByPath(self.image_next_time , "RichText_next_time")
    --TODO无尽模式
    -- self.Panel_victoryTypeEndless = TFDirector:getChildByPath(self.Panel_victory, "Panel_victoryTypeEndless"):hide()
    -- self.Label_endlessTime = TFDirector:getChildByPath(self.Panel_victoryTypeEndless, "Image_bg1.Label_endlessTime")
    -- self.Label_victoryEndless_title = TFDirector:getChildByPath(self.Panel_victoryTypeEndless, "Label_victoryEndless_title")
    -- self.Label_victoryEndless_level = TFDirector:getChildByPath(self.Panel_victoryTypeEndless, "Label_victoryEndless_level")

    --挑战进度显示
    self.Panel_progress = TFDirector:getChildByPath(self.Panel_ui, "Panel_progress")
    self.Panel_progress:hide()
    self.label_tip1   = self.Panel_progress:getChildByName("Label_tip1")
    self.label_tip2   = self.Panel_progress:getChildByName("Label_tip2")
    self.Image_star   = self.Panel_progress:getChildByName("Image_star")
    self.label_tip1:setSkewX(15)
    self.label_tip2:setSkewX(15)
    --特训矩阵
    self.panel_txjz = TFDirector:getChildByPath(self.Panel_victory, "Panel_txjz"):hide()
    self.panel_txjz.spine_cjtx_score      = TFDirector:getChildByPath(self.panel_txjz, "Spine_cjtx_score")
    self.panel_txjz.label_tx_score        = TFDirector:getChildByPath(self.panel_txjz, "Label_tx_score")
    self.panel_txjz.label_tx_score:setSkewX(15)
    self.panel_txjz.spine_cjtx_percent    = TFDirector:getChildByPath(self.panel_txjz, "Spine_cjtx_percent")
    self.panel_txjz.spine_cjtx_activation = TFDirector:getChildByPath(self.panel_txjz, "Spine_cjtx_activation"):hide()
    self.panel_txjz.loadingBar_cjtx_score = TFDirector:getChildByPath(self.panel_txjz, "LoadingBar_cjtx_score")
    self.panel_txjz.spine_cjtx_percent:play("animation",1)
    self.panel_txjz.spine_cjtx_activation:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
            skeletonNode:hide()
        end)
    self.panel_txjz.spine_cjtx_score:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
            local animation = score_effect_animations[self.panel_txjz.rangeIndex or 1][2]
            if skeletonNode:getAnimation()~= animation then 
                skeletonNode:play(animation,1)
            end
        end)

    self.panel_txjz.loadingBar_cjtx_score._setPercent       = self.panel_txjz.loadingBar_cjtx_score.setPercent
    self.panel_txjz.loadingBar_cjtx_score.spine_cjtx_percent = self.panel_txjz.spine_cjtx_percent 

    self.panel_txjz.loadingBar_cjtx_score.setPercent = function(self,percent)
        self:_setPercent(percent)
        local width  = self:getSize().width*0.90
        self.spine_cjtx_percent:setPositionX(-0.5*width + width*percent*0.01 + 6) 
    end
    self.panel_txjz.loadingBar_cjtx_score:setPercent(30)
    --觉醒
    self.Panel_awake = TFDirector:getChildByPath(self.Panel_ui, "Panel_awake")
    self.Panel_awake:hide()

    self.Panel_ui_effect_top    = TFDirector:getChildByPath(self.Panel_ui, "Panel_ui_effect_top")
    self.Panel_ui_effect_top:setTouchEnabled(false)
    self.Panel_ui_effect_bottom = TFDirector:getChildByPath(self.Panel_ui, "Panel_ui_effect_bottom")

    self.effect_alert = TFDirector:getChildByPath(self.Panel_ui_effect_bottom, "Spine_alert")
    local size = self.Panel_ui_effect_bottom:getSize()
    self.effect_alert:setPosition(ccp(size.width/2,size.height/2 + 15))
    if me.EGLView:getDesignResolutionSize().width > 1136 then
        self.effect_alert:play("1386",1)
    else
        self.effect_alert:play("1136",1)
    end

    self.effect_alert.playAni  = function (self)
        self:show()
        self:resume()
    end
    self.effect_alert.stopAni  = function (self)
        self:stop()
        self:hide()
    end
    self.effect_alert:stopAni()


    BattleMgr.bindActionMgr(self.image_go)
    self.image_go:hide()
    --出招表
     self.image_keylist = TFDirector:getChildByPath(self.Panel_top,"Image_keylist"):hide()
     self.image_keylist.label_keylist = TFDirector:getChildByPath(self.image_keylist,"Label_keylist")

    self.panel_victory_time = TFDirector:getChildByPath(self.Panel_top,"Panel_time")
    self.panel_victory_time.Image_signal = TFDirector:getChildByPath(self.panel_victory_time,"Image_signal"):hide()
    self.panel_victory_time.LoadingBar_signal = TFDirector:getChildByPath(self.panel_victory_time,"LoadingBar_signal")
    self.panel_victory_time.Label_signal = TFDirector:getChildByPath(self.panel_victory_time,"Label_signal")
    self.label_victory_time = TFDirector:getChildByPath(self.panel_victory_time,"Label_time")

    self.button_set = TFDirector:getChildByPath(self.Panel_top,"Button_set")

    -- scrollView:show()
    -- self.listViewRole = UIListView:create(scrollView)
    --蓄力条

    self.image_gather   = self.Panel_top:getChildByName("Image_gather"):hide()
    self.image_gather.separateList = {} --存放分割符号
    self.loadbar_gather = self.image_gather:getChildByName("LoadingBar_gather")

    ---控制队员
    self.plyerNode = self.Panel_top:getChildByName("Panel_captain")
    self.plyerNode:hide()
    self.plyerNode.panel_role  = self.plyerNode:getChildByName("Panel_role")
    self.plyerNode.ClippingNode_head =TFDirector:getChildByPath(self.plyerNode ,"ClippingNode_head")
    self.plyerNode.imageHead   = TFDirector:getChildByPath(self.plyerNode,"Image_head")

    local startPos = self.plyerNode.imageHead:getPosition() + ccp(5 , 15)
    self.plyerNode.panel_element = Utils:createElementPanel(self.plyerNode.panel_role , 1 ,startPos , nil , 0.5)
    -- self.plyerNode.imageHead:hide()

    -- self.plyerNode.panel_heads = self.plyerNode:getChildByName("Panel_heads"):hide()

    local image_hp = self.plyerNode:getChildByName("Image_hp")
    self.plyerNode.loadingBar_hp = image_hp:getChildByName("LoadingBar_hp")


    self.plyerNode.label_sp  = self.plyerNode:getChildByName("Label_sp") --TODO 设置SP的名称
    self.plyerNode.label_sp:setSkewX(15)
    -- self.plyerNode.image_sp  = image_sp
    self.plyerNode.spNodes = {}
    for index =1,14 do

        if index < 7 then
            local node = self.plyerNode:getChildByName("Label_value")
            node:setSkewX(15)
            node.label_value  = node
            self.plyerNode.spNodes[index]= node
        else
            local node = self.plyerNode:getChildByName("Image_type"..tostring(index))
            node.loadingBar   = node:getChildByName("LoadingBar")
            if index == 8 or index == 7 or index == 10 or index == 14 then
                node.effect   = self.plyerNode:getChildByName("Spine_all_effect"..tostring(index))
                node.effect:hide()
            elseif index == 11 then -- 强化十香能量表现
                node.checkBoxs = {}
                for k = 1 , 3 do
                    node.checkBoxs[k] = node:getChildByName("CheckBox_"..k)
                    print("xxxxxxxxxxx",k,tostring(node.checkBoxs[k]~=nil))
                end
            end
            self.plyerNode.spNodes[index]= node
        end

    end

    --队员列表
    self.Panel_menbers = self.Panel_top:getChildByName("Panel_menbers"):hide()
    self.Panel_menbers.roleNodes = {}
    for i = 1 , 2 do
        local roleNode = self.Panel_menbers:getChildByName("Panel_role"..i)
        self.Panel_menbers.roleNodes[i] = roleNode
        roleNode.image_back    = TFDirector:getChildByPath(roleNode, "Image_back")
        roleNode.loadingBar_hp = TFDirector:getChildByPath(roleNode, "LoadingBar_hp")
        roleNode.image_mask    = TFDirector:getChildByPath(roleNode, "Image_mask")
        roleNode.label_cdTime  = TFDirector:getChildByPath(roleNode, "Label_cdTime")
        roleNode.label_cdTime:setSkewX(15)
        roleNode.image_dead    = TFDirector:getChildByPath(roleNode, "Image_dead")
        roleNode.image_head    = TFDirector:getChildByPath(roleNode, "Image_head")
        roleNode.clippingNode_head  = TFDirector:getChildByPath(roleNode, "ClippingNode_head")
    end

    -- 时间
    self.Panel_assist = TFDirector:getChildByPath(self.Panel_ui, "Panel_assist")
    self.Panel_assist._startPos = self.Panel_assist:getPosition() --记录原始位置
    self.Panel_assist.imageIcon = TFDirector:getChildByPath(self.Panel_assist, "Image_assist_icon")
    self.Panel_assist.textName  =  TFDirector:getChildByPath(self.Panel_assist, "Label_assist_name")
    self.Panel_assist.textName:setSkewX(15)
    self.Panel_assist:hide()

    --boss
    self.bossNode = self.Panel_top:getChildByName("Panel_boss")
    self.bossNode:hide()
    self.bossNode.loadingBarHps = {}
    for index = 1 , 4 do
        self.bossNode.loadingBarHps[index]  = TFDirector:getChildByPath(self.bossNode,"LoadingBar_hp"..index)
    end

    self.bossNode.loadingBar_np  = TFDirector:getChildByPath(self.bossNode,"LoadingBar_np")
    --名字
    self.bossNode.label_name    = TFDirector:getChildByPath(self.bossNode,"Label_name") --名字
    self.bossNode.label_name:setSkewX(15)
    --霸体条
    self.bossNode.image_bg_nnp   = TFDirector:getChildByPath(self.bossNode,"Image_bg_nnp") --
    self.bossNode.loadingBar_nnp = TFDirector:getChildByPath(self.bossNode,"LoadingBar_nnp") --霸体
    --词缀
    self.bossNode.label_affix         = TFDirector:getChildByPath(self.bossNode,"Label_affix") --名字
    self.bossNode.label_affix:setSkewX(15)
    self.bossNode.label_affix:hide()

    self.bossNode.imageAffixs ={}
    for index =1,4 do
        self.bossNode.imageAffixs[index] = self.bossNode:getChildByName("Image_affix"..index) --词缀
        self.bossNode.imageAffixs[index]:hide()
    end
    
    -- self.bossNode.image_affix         = TFDirector:getChildByPath(self.bossNode,"Image_affix") --名字
    -- self.bossNode.image_affix:hide()

    --血条条数
    self.bossNode.label_loadbar_num    = TFDirector:getChildByPath(self.bossNode,"Label_loadbar_num") --名字
    self.bossNode.label_loadbar_num:setSkewX(15)

    self.bossNode.panel_boss_head  = TFDirector:getChildByPath(self.bossNode,"Panel_boss_head")
    self.bossNode.ClippingNode_boss_head = TFDirector:getChildByPath(self.bossNode,"ClippingNode_boss_head")
    self.bossNode.imageHead      = TFDirector:getChildByPath(self.bossNode,"Image_boss_head") --名字
    self.bossNode.image_bg1      = TFDirector:getChildByPath(self.bossNode,"Image_affix_bg1") --
    self.bossNode.image_bg2      = TFDirector:getChildByPath(self.bossNode,"Image_affix_bg2") --

    local startPos = self.bossNode.imageHead:getPosition() + ccp(5 , 15)
    self.bossNode.panel_element = Utils:createElementPanel( self.bossNode.panel_boss_head , 1 ,startPos , nil , 0.5)


    -- 守护
    -- self.Panel_guard = TFDirector:getChildByPath(self.Panel_top, "Panel_guard"):hide()
    -- self.Label_guardTarget = TFDirector:getChildByPath(self.Panel_guard, "Label_guardTarget")
    -- local Image_guardProgress = TFDirector:getChildByPath(self.Panel_guard, "Image_guardProgress")
    -- self.LoadingBar_guardGreen = TFDirector:getChildByPath(Image_guardProgress, "LoadingBar_guardGreen"):show()
    -- self.LoadingBar_guardYellow = TFDirector:getChildByPath(Image_guardProgress, "LoadingBar_guardYellow"):hide()
    -- self.LoadingBar_guardRed = TFDirector:getChildByPath(Image_guardProgress, "LoadingBar_guardRed"):hide()

    -- 天梯
    self.Panel_ladder_buff = TFDirector:getChildByPath(self.Panel_top, "Panel_ladder_buff"):hide()
    self.Button_ladderBuff_open = TFDirector:getChildByPath(self.Panel_ladder_buff, "Button_ladderBuff_open"):hide()
    self.Label_ladderBuff_open = TFDirector:getChildByPath(self.Button_ladderBuff_open, "Label_ladderBuff_open")
    self.Button_ladderBuff_close = TFDirector:getChildByPath(self.Panel_ladder_buff, "Button_ladderBuff_close"):show()
    self.Label_eladderBuff_close = TFDirector:getChildByPath(self.Button_ladderBuff_close, "Label_eladderBuff_close")
    local ScrollView_ladderBuff = TFDirector:getChildByPath(self.Panel_ladder_buff, "ScrollView_ladderBuff"):show()
    self.ListView_ladderBuff = UIListView:create(ScrollView_ladderBuff)

    -- 无尽模式
    self.Panel_endlessTip = TFDirector:getChildByPath(self.Panel_top, "Panel_endlessTip"):hide()
    self.Label_endlessLevel = TFDirector:getChildByPath(self.Panel_endlessTip, "Label_endlessLevel")
    self.Panel_endlessStop = TFDirector:getChildByPath(self.Panel_top, "Panel_endlessStop"):hide()
    self.Panel_endlessResult = TFDirector:getChildByPath(self.Panel_top, "Panel_endlessResult"):hide()
    self.Label_endlessResult = TFDirector:getChildByPath(self.Panel_endlessResult, "Label_endlessResult")
    self.Label_endlessPassTime = TFDirector:getChildByPath(self.Panel_endlessResult, "Label_endlessPassTime")
    self.Panel_endlessBuff = TFDirector:getChildByPath(self.Panel_top, "Panel_endlessBuff"):hide()
    self.Button_endlessBuff_open = TFDirector:getChildByPath(self.Panel_endlessBuff, "Button_endlessBuff_open"):hide()
    self.Label_endlessBuff_open = TFDirector:getChildByPath(self.Button_endlessBuff_open, "Label_endlessBuff_open")
    self.Button_endlessBuff_close = TFDirector:getChildByPath(self.Panel_endlessBuff, "Button_endlessBuff_close"):show()
    self.Label_endlessBuff_close = TFDirector:getChildByPath(self.Button_endlessBuff_close, "Label_endlessBuff_close")
    local ScrollView_endlessBuff = TFDirector:getChildByPath(self.Panel_endlessBuff, "ScrollView_endlessBuff"):show()
    self.ListView_endlessBuff = UIListView:create(ScrollView_endlessBuff)
    self.Image_endless_victory = TFDirector:getChildByPath(self.Panel_victory, "Image_endless_victory"):hide()
    self.Label_endless_jump = TFDirector:getChildByPath(self.Image_endless_victory, "Label_endless_jump")
    self.Label_endless_jump:setTextById(300840)
    self.Label_endless_jump_level = TFDirector:getChildByPath(self.Image_endless_victory, "Label_endless_jump_level")
    self.LoadingBar_endless_time = TFDirector:getChildByPath(self.Image_endless_victory, "Image_endless_time.LoadingBar_endless_time")
    self.Label_endless_time = TFDirector:getChildByPath(self.Image_endless_victory, "Image_endless_time.Label_endless_time")
    self.Label_endlessLevel:setSkewX(15)
    self.Label_endlessResult:setSkewX(15)
    self.Label_endlessPassTime:setSkewX(15)
    self.Label_endlessBuff_open:setSkewX(15)
    self.Label_endlessBuff_close:setSkewX(15)
    self.Label_endless_jump:setSkewX(15)
    self.Label_endless_jump_level:setSkewX(15)
    -- 常规开场通关条件提示
    self.Panel_commonPassTip = TFDirector:getChildByPath(self.Panel_top, "Panel_commonPassTip"):hide()
    self.Label_commonPassContent = TFDirector:getChildByPath(self.Panel_commonPassTip, "Label_commonPassContent")
    -- 关卡属性限定提示
    self.Panel_propLimitTip = TFDirector:getChildByPath(self.Panel_top, "Panel_propLimitTip"):hide()
    self.Label_propLimitTitle = TFDirector:getChildByPath(self.Panel_top, "Label_propLimitTitle")
    self.Label_propLimit = TFDirector:getChildByPath(self.Panel_propLimitTip, "Label_propLimit")
    self.Label_propLimitTitle:setSkewX(15)
    self.Label_propLimit:setSkewX(15)
    -- prefabs
    self.prefabNums = {}
    self.prefabNums[eNumNodeType.Ruodian]  = TFDirector:getChildByPath(self.Panel_prefabs, "Node_ruodian")
    self.prefabNums[eNumNodeType.BaoJi]    = TFDirector:getChildByPath(self.Panel_prefabs, "Node_baoji")
    self.prefabNums[eNumNodeType.ChuanTou] = TFDirector:getChildByPath(self.Panel_prefabs, "Node_chuantou")
    self.prefabNums[eNumNodeType.JiNeng]   = TFDirector:getChildByPath(self.Panel_prefabs, "Node_jineng")
    self.prefabNums[eNumNodeType.PuGong]   = TFDirector:getChildByPath(self.Panel_prefabs, "Node_pugong")
    self.prefabNums[eNumNodeType.ZhiYu]    = TFDirector:getChildByPath(self.Panel_prefabs, "Node_zhiyu")
    self.prefabNums[eNumNodeType.BaojiChuanTou]= TFDirector:getChildByPath(self.Panel_prefabs, "Node_baojichuantou")
    --新歼灭模式状态
    self.prefabVictorStates = {}
    for index=1,3 do
        self.prefabVictorStates[index]  = TFDirector:getChildByPath(self.Panel_prefabs, "Image_state"..index)
    end
    --怪物突破了防御
    self.prefab_imageAlert = TFDirector:getChildByPath(self.Panel_prefabs,"Image_alert"):hide()
    -- for i, node in pairs(self.prefabNums) do
    --     node.bmFont    = node:getChildByName("LabelBMFont")
    --     node.imageSign = node:getChildByName("Image_sign")
    -- end
    --
    self.prefab_buff_icon  = TFDirector:getChildByPath(self.Panel_prefabs, "Panel_icon")

    self.prefab_wenzi    = TFDirector:getChildByPath(self.Panel_prefabs, "LabelBMFont_wenzi")
    --蓄力条分割符号
    self.prefab_separate = TFDirector:getChildByPath(self.Panel_prefabs, "Image_separate")
    --loadbar
    self.prefab_loadbar  = TFDirector:getChildByPath(self.Panel_prefabs, "Panel_loadbar")

    -- self.role_prefabs1      = TFDirector:getChildByPath(self.Panel_prefabs, "Panel_role2")
    self.team_role_prefabs  = TFDirector:getChildByPath(self.Panel_prefabs, "Panel_team_role")
    self.team_attack_model  = TFDirector:getChildByPath(self.Panel_prefabs, "Panel_team_attack")
    self.image_lianji_bg    = {}
    self.labelBMFont_lianji = {}
    -- for index =1,4 do
    --     self.image_lianji_bg[index]     = TFDirector:getChildByPath(self.Panel_prefabs, "Image_lianji_bg"..index)
    --     if index < 4 then
    --         self.labelBMFont_lianji[index]  = TFDirector:getChildByPath(self.Panel_prefabs, "LabelBMFont_lianji"..index)
    --     end
    -- end
    self.Panel_endlessBuffItem = TFDirector:getChildByPath(self.Panel_prefabs, "Panel_endlessBuffItem")
    self.Panel_skyladder_item = TFDirector:getChildByPath(self.Panel_prefabs, "Panel_skyladder_item")
    self.keyBoard = KeyBoard:new()
    self.Panel_top:addChild(self.keyBoard,10)
    if self.levelCfg_.id == 101101 then
        self.keyBoard.pause_btn:setVisible(FubenDataMgr:isPassPlotLevel(self.levelCfg_.id))
    else
        self.keyBoard.pause_btn:setVisible(true)
    end

    --出招帮助按钮
    self.keyBoard.skill_help_btn:hide()

--圆形转盘
    self.roulette = Roulette:new(self.Panel_menbers)
    self.roulette:setVisible(false)
    self.roulette:setSelectListener(handler(self.onCaptainSelect,self))

    --键盘适配处理
    local pSize = self.Panel_top:getSize()
    local cSize = self.keyBoard:getSize()
    self.keyBoard:setPosition(me.p((pSize.width - cSize.width)/2,(pSize.height - cSize.height)/2))
    self.keyBoard:hideRevive()
    self.Panel_top:getChildByName("Panel_team_rank"):setVisible(false)

    --buffer icon
    self.Panel_buffer_effect_icon_captain = TFDirector:getChildByPath(self.plyerNode, "Panel_buffer_effect_icon")
    self.captainIconListView = IconListView:create()
    self.Panel_buffer_effect_icon_captain:addChild(self.captainIconListView)

    self.Panel_buffer_effect_icon_boss = TFDirector:getChildByPath(self.bossNode, "Panel_buffer_effect_icon")
    self.bossIconListView = IconListView:create()
    self.Panel_buffer_effect_icon_boss:addChild(self.bossIconListView)

    self.Panel_flight_helpTips = TFDirector:getChildByPath(self.Panel_top, "Panel_flight_helpTips"):hide()
    self.Label_flight_helpTips = TFDirector:getChildByPath(self.Panel_flight_helpTips, "Label_flight_helpTips")
    self.Label_flight_helpTips:setSkewX(15)

    self.Panel_top:getChildByName("Panel_team_talk"):hide()

    -- 木桩副本
    self.Panel_practice = TFDirector:getChildByPath(self.Panel_top, "Panel_practice"):hide()
    self.Button_practice_set = TFDirector:getChildByPath(self.Panel_practice, "Button_practice_set")
    self.Label_practice_set = TFDirector:getChildByPath(self.Button_practice_set, "Label_practice_set")
    self.Label_practice_set:setTextById(2107005)
    self.Button_practice_reset = TFDirector:getChildByPath(self.Panel_practice, "Button_practice_reset")
    self.Label_practice_reset = TFDirector:getChildByPath(self.Button_practice_reset, "Label_practice_reset")
    self.Label_practice_reset:setTextById(2107006)
    self.Button_practice_exit = TFDirector:getChildByPath(self.Panel_practice, "Button_practice_exit")
    self.Label_practice_exit = TFDirector:getChildByPath(self.Button_practice_exit, "Label_practice_exit")
    self.Label_practice_exit:setTextById(2107004)

    self.Panel_practice_infinite = TFDirector:getChildByPath(self.Panel_practice, "Panel_practice_infinite")
    self.Image_practice_infinite_on = TFDirector:getChildByPath(self.Panel_practice_infinite, "Image_practice_infinite_on")
    self.Image_practice_infinite_off = TFDirector:getChildByPath(self.Panel_practice_infinite, "Image_practice_infinite_off")
    self.Label_practice_infinite_on = TFDirector:getChildByPath(self.Panel_practice_infinite, "Label_practice_infinite_on")
    self.Label_practice_infinite_off = TFDirector:getChildByPath(self.Panel_practice_infinite, "Label_practice_infinite_off")
    self.Label_practice_infinite = TFDirector:getChildByPath(self.Panel_practice_infinite, "Label_practice_infinite")
    self.Label_practice_infinite:setTextById(2107002)
    self.Panel_practice_infinite_touch = TFDirector:getChildByPath(self.Panel_practice_infinite, "Panel_practice_infinite_touch")

    self.Panel_practice_atk = TFDirector:getChildByPath(self.Panel_practice, "Panel_practice_atk")
    self.Image_practice_atk_on = TFDirector:getChildByPath(self.Panel_practice_atk, "Image_practice_atk_on")
    self.Image_practice_atk_off = TFDirector:getChildByPath(self.Panel_practice_atk, "Image_practice_atk_off")
    self.Label_practice_atk_on = TFDirector:getChildByPath(self.Panel_practice_atk, "Label_practice_atk_on")
    self.Label_practice_atk_off = TFDirector:getChildByPath(self.Panel_practice_atk, "Label_practice_atk_off")
    self.Label_practice_atk = TFDirector:getChildByPath(self.Panel_practice_atk, "Label_practice_atk")
    self.Label_practice_atk:setTextById(2107003)
    self.Panel_practice_atk_touch = TFDirector:getChildByPath(self.Panel_practice_atk, "Panel_practice_atk_touch")

    self.Panel_practice_hurt = TFDirector:getChildByPath(self.Panel_practice, "Panel_practice_hurt")
    self.Image_practice_hurt_on = TFDirector:getChildByPath(self.Panel_practice_hurt, "Image_practice_hurt_on")
    self.Image_practice_hurt_off = TFDirector:getChildByPath(self.Panel_practice_hurt, "Image_practice_hurt_off")
    self.Label_practice_hurt_on = TFDirector:getChildByPath(self.Panel_practice_hurt, "Label_practice_hurt_on")
    self.Label_practice_hurt_off = TFDirector:getChildByPath(self.Panel_practice_hurt, "Label_practice_hurt_off")
    self.Label_practice_hurt = TFDirector:getChildByPath(self.Panel_practice_hurt, "Label_practice_hurt")
    self.Label_practice_hurt:setTextById(2107033)
    self.Panel_practice_hurt_touch = TFDirector:getChildByPath(self.Panel_practice_hurt, "Panel_practice_hurt_touch")
    self.Image_hurt = TFDirector:getChildByPath(self.Panel_practice, "Image_hurt")
    self.Button_hurt_reset = TFDirector:getChildByPath(self.Image_hurt, "Button_hurt_reset")
    self.Button_hurt_pause = TFDirector:getChildByPath(self.Image_hurt, "Button_hurt_pause"):hide()
    self.Button_hurt_resume = TFDirector:getChildByPath(self.Image_hurt, "Button_hurt_resume")
    self.Label_hurt_timimg = TFDirector:getChildByPath(self.Image_hurt, "Label_hurt_timimg")
    self.Label_hurt = TFDirector:getChildByPath(self.Image_hurt, "Label_hurt")


    --组队新增的关卡模式
    self.panel_team_victory = self.Panel_top:getChildByName("Panel_team_victory"):hide()
    self.panel_type_score = self.panel_team_victory:getChildByName("Image_type_score"):hide()
    self.panel_type_score.Label_team_title = TFDirector:getChildByPath(self.panel_type_score , "Label_team_title")
    -- self.panel_type_score.Label_team_value = TFDirector:getChildByPath(self.panel_type_score , "Label_team_value") 
    self.panel_type_score.Label_percent    = TFDirector:getChildByPath(self.panel_type_score , "Label_percent")
    self.panel_type_score.LoadingBar       = TFDirector:getChildByPath(self.panel_type_score , "LoadingBar")
    self.panel_type_score.Spine_get        = TFDirector:getChildByPath(self.panel_type_score , "Spine_get")
    self.panel_type_score.Label_team_title:setSkewX(15)
    -- self.panel_type_score.Label_team_value:setSkewX(15) 
    self.panel_type_score.Label_percent:setSkewX(15)
    self.panel_type_score.Spine_get:hide()
    self.panel_type_score.Spine_get:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
        skeletonNode:hide()
    end)




    self.panel_type_guard = self.panel_team_victory:getChildByName("Image_type_guard"):hide()
    self.panel_type_guard.Label_team_title = TFDirector:getChildByPath(self.panel_type_guard , "Label_team_title")
    self.panel_type_guard.Label_percent    = TFDirector:getChildByPath(self.panel_type_guard , "Label_percent")
    self.panel_type_guard.LoadingBar       = TFDirector:getChildByPath(self.panel_type_guard , "LoadingBar")
    self.panel_type_guard.Label_team_title:setSkewX(15)
    self.panel_type_guard.Label_percent:setSkewX(15)


    --暂时添加关卡打印信息
    if GAME_LANGUAGE_VAR ~= "" then
        if me.platform == "win32" then
            if type(self.levelCfg_.levelScript) == "string" then
                TFDirector:getChildByPath(ui , "Label_level_info"):setText("前关卡的levelScript字段信息为： "..self.levelCfg_.levelScript)
            else
                local levelCfgName = ""
                for k ,v in pairs(self.levelCfg_.levelScript) do
                    levelCfgName = levelCfgName..v.." "
                end
                TFDirector:getChildByPath(ui , "Label_level_info"):setText("前关卡的levelScript字段信息为： "..levelCfgName)
            end
            
        else
            TFDirector:getChildByPath(ui ,"Label_level_info"):hide()
        end
    end
    
end

--显示下一波倒计时
function BattleView:showNextWaveCountDownTime(time)
    time = time or 5000
    time = time*0.001
    if self.timeHandler then 
        BattleTimerManager:stopTimer(self.timeHandler)
        self.timeHandler = nil
    end
    self.image_next_time:show()
    self.image_next_time.time =time
    self.rText_next_time:setTextById("r140001", self.image_next_time.time)
    self.timeHandler = BattleTimerManager:addTimer(1000,time,
        function() 
            self.image_next_time:hide()
            self.timeHandler = nil
        end ,
        function( )
            self.image_next_time.time = self.image_next_time.time - 1
            self.rText_next_time:setTextById("r140001", self.image_next_time.time)
        end)
end

--怪物突破防御
function BattleView:showAlert(time)
    time = time or 5 
    local size = self.Panel_top:getSize()
    local image_alert = self.prefab_imageAlert:clone()
    image_alert:show()
    image_alert:setPosition(ccp(size.width/2,size.height/3))
    local action = Sequence:create({
            DelayTime:create(time),
            -- Hide:create(),
            RemoveSelf:create()
        })
    image_alert:runAction(action)
    image_alert:setCameraMask(self.Panel_top:getCameraMask())
    self.Panel_top:addChild(image_alert)
end


--怪物突破防御
function BattleView:showKeyList(keys)
    if keys and #keys > 0 then  
        self.image_keylist:stopAllActions()
        self.image_keylist:show()
        self.image_keylist:setOpacity(255) 
        self.image_keylist.label_keylist:setText(keys)
    else
        -- if self.image_keylist:isVisible() then 
        --     self.image_keylist:stopAllActions()
        --     local action = Sequence:create({
        --         DelayTime:create(1),
        --         Hide:create()
        --     })
        -- end
        -- self.image_keylist:hide()
        if self.image_keylist:getOpacity() == 255 then 
            self.image_keylist:runAction(FadeOut:create(0.5))
        end
    end 
end



function BattleView:heroDeadAlertCheck(hero)
    local captain = battleController.getCaptain()
    if captain == hero then
        local percent = hero:getHpPercent() * 0.01
        if percent < 20 then
            self.effect_alert:playAni()
        else
            self.effect_alert:stopAni()
        end
    end
end

function BattleView:refreshView()

    if self.battleType_ == EC_BattleType.COMMON then
        self:reLoadVictoryView()
        if self.levelType_ == EC_FBLevelType.SKYLADDER then
            self:showLadderBuffInfo()
        end
    elseif self.battleType_ == EC_BattleType.ENDLESS then
        local isRacingMode = FubenDataMgr:isEndlessRacingMode(self.levelCid_)
        if isRacingMode then
            self:showEndlessBuffInfo()
        end
        self:refreshEndlessVictoryState()
    elseif self.battleType_ == EC_BattleType.TEAM_FIGHT then
        self:reLoadVictoryView()
        self:initTeamLeftPad()
    end
end

--蓄力条
function BattleView:onGatherBarUpdate(state,skill)
    if state == 1 then --初始化
        self.image_gather:show()
        local size  = self.image_gather:getSize()
        local len   = #skill.timeList
        local separateList = self.image_gather.separateList
        for index , percent in ipairs(skill.timeList) do
            if index < len  then
                local node
                if index < #separateList then
                    node = separateList[index]
                else
                    node = self.prefab_separate:clone()
                    self.image_gather:addChild(node)
                    table.insert(separateList,node)
                end
                node:show()
                node:setPosition(ccp(size.width*percent*0.01 - size.width*0.5,0))
            end
        end

        self.loadbar_gather:setPercent(skill:getGatherValue())
    elseif state == 2 then --更新
        self.loadbar_gather:setPercent(skill:getGatherValue())
    elseif state == 3 then --隐藏蓄力条
        self.image_gather:hide()
        local separateList = self.image_gather.separateList
        for index , node in ipairs(separateList) do
            node:hide()
        end
        self.loadbar_gather:setPercent(0)
    end
end

function BattleView:showPrewarTip()
    if self.battleType_ == EC_BattleType.ENDLESS then
        local action = Sequence:create({
                Show:create(),
                DelayTime:create(2),
                Hide:create(),
        })
        self.Panel_endlessTip:runAction(action)
        self.Label_endlessLevel:setTextById(300832, self.levelCfg_.order)
    elseif self.battleType_ == EC_BattleType.COMMON then
        if self.levelCfg_.victoryTypeDescribeForOpening ~= 0 then
            local action = Sequence:create({
                    Show:create(),
                    DelayTime:create(2),
                    Hide:create(),
            })
            self.Panel_commonPassTip:runAction(action)
            self.Label_commonPassContent:setTextById(self.levelCfg_.victoryTypeDescribeForOpening)
        end
    end

    if self.battleType_ ~= EC_BattleType.ENDLESS or (self.battleType_ == EC_BattleType.ENDLESS and #self.statistics_.endlessPassLevel == 0) then
        if self.levelCfg_.limitAttributesDescribe and #self.levelCfg_.limitAttributesDescribe > 0 then
            local offsetX = GameConfig.WS.width * 0.5
            self.Panel_propLimitTip:PosX(self.Panel_propLimitTip:PosX() - offsetX)
            self.Label_propLimitTitle:setTextById(300823)
            self.Label_propLimit:setTextById(self.levelCfg_.limitAttributesDescribe)
            local action = Sequence:create({
                    DelayTime:create(2),
                    Show:create(),
                    MoveBy:create(0.3, ccp(offsetX, 0)),
                    DelayTime:create(1.5),
                    MoveBy:create(0.3, ccp(-offsetX, 0)),
                    Hide:create(),
            })
            self.Panel_propLimitTip:runAction(action)
        end
    end
end

local titleTexts = {300811 ,300812,300813,300814,300814,300868,300875,300811,300811 ,300891,300868,300868,300868,300868,300897,300899,301176
,301177,301178}
function BattleView:refreshCommonVictoryState()
    local victoryDecide = battleController.getVictoryDecide()
    local victoryCfgs = victoryDecide.getData()
    local viewType    = victoryDecide.nViewType
    if self.battleType_ ~= EC_BattleType.TEAM_FIGHT then
        self.Panel_victory:setVisible(viewType ~= EC_LevelPassCond.PRACTICE)
    end
    if viewType ~= 0 and self.Panel_victory:isVisible() then
        local text = TextDataMgr:getText(titleTexts[viewType])
        self.textVictoryTitle:setText(text)
    end
    if viewType == 0 then
    elseif viewType == EC_LevelPassCond.DESTORY then  -- (歼灭模式)
        -- print("歼灭模式:[",victoryDecide.nStage,"/",battleController.getMaxStage(),"]")
        local maxStage = battleController.getMaxStage()
        local stage = victoryDecide.nStage
        self.textVictorycontent:setText(string.format("%s/%s", stage, maxStage))
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))
    elseif viewType == EC_LevelPassCond.SURVIVAL then  -- (生存模式)   300815
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))
        self.textVictorycontent:setText(string.format("%s:%s", min, sec))
    elseif viewType ==  EC_LevelPassCond.SURVIVAL_HURT then
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))
        -- self.textVictoryTitle:setText("本次伤害:")
        self.textVictorycontent:setText(tostring(self.statistics_.hitValue))
    elseif viewType == EC_LevelPassCond.WAVE then --波次模式
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))
        local cfg = victoryCfgs[1]
        local maxWave = cfg.victoryParam[1]  --TODO 读取当前关卡配置？
        local wave    = victoryDecide.getWave()
        wave = math.min(wave,maxWave)
        self.textVictorycontent:setText(string.format("%s/%s",wave,maxWave))
    elseif viewType == EC_LevelPassCond.SPECIFICID  then --限时击杀
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))

        local maxNum = 0
        local num    = 0
        local desc   = 0
        local cfg = victoryCfgs[1]
        num    = victoryDecide.getKillTargetNum(cfg.victoryParam[1])
        maxNum = cfg.victoryParam[2]
        -- local monsterCfg  = TabDataMgr:getData("Monster", cfg.victoryParam[1])
        -- if monsterCfg.targetIcon then
        --     node.imageIcon:setTexture(monsterCfg.targetIcon)
        -- end
        self.textVictorycontent:setText(string.format("%s/%s",num,maxNum))
        -- node.imagekill:setVisible(num >= maxNum )
    elseif viewType == EC_LevelPassCond.SPECIFICTYPE then
        local maxNum = 0
        local num    = 0
        local text   = ""
        for index, cfg in ipairs(victoryCfgs) do
            num    = victoryDecide.getKillTypeNum(cfg.victoryParam[1])
            maxNum = cfg.victoryParam[2]
            text = text..string.format("%s/%s",num,maxNum)
            -- self.textVictorycontent:setText(string.format("[%s/%s]",num,maxNum))
        end
        self.textVictorycontent:setText(text)
     elseif viewType == EC_LevelPassCond.SPECIFICCOUNT then
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))
        local cfg  = victoryCfgs[1]
        local num    = victoryDecide.getKillNum()
        local maxNum = cfg.victoryParam[1]
        self.textVictorycontent:setText(string.format("%s/%s",num,maxNum))
        -- node.imagekill:setVisible(num >= maxNum )
    elseif viewType == EC_LevelPassCond.GUARDMODE then
        -- local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        -- self.label_victory_time:setText(string.format("%s:%s", min, sec))
        self.label_victory_time:hide() --右上角时间隐藏
    elseif viewType == EC_LevelPassCond.GUARDMODE_3 then
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))
        self.label_victory_time:show() 
        self.Image_common_victory2:show() 
        self.Image_common_victory2.title:setText(TextDataMgr:getText(300830)) --怪物波次
        self.Image_common_victory2.content:hide()
    elseif viewType == EC_LevelPassCond.GUARDMODE_EX then  
        self.label_victory_time:hide() --右上角时间隐藏  
        --显示波次
        local cfg = victoryCfgs[1]
        local maxWave = cfg.victoryParam[1]  --TODO 读取当前关卡配置？
        local wave    = victoryDecide.getWave()
        wave = math.min(wave,maxWave)
        self.Image_common_victory2:show() 
        self.Image_common_victory2.title:setText(TextDataMgr:getText(300890)) --怪物波次
        self.Image_common_victory2.content:setText(string.format("%s/%s",wave,maxWave)) 
    elseif viewType == EC_LevelPassCond.HALLOWEEN_DESTORY then  -- (万圣节活动-歼灭模式)
        local millisecond = math.floor(math.floor(self.statistics_.time)%1000*0.1)
        local _, hour, min, sec = Utils:getDHMS(self.statistics_.time*0.001, true)
        local score = victoryDecide.getScore()
        if score < 100 then
            self.image_halloween_1:show()
            self.image_halloween_2:hide()
            self.image_halloween_1.label_time:setText(string.format("%s:%s" , min, sec))
            self.image_halloween_1.loadingBar_score:setPercent(score)
            self.image_halloween_1.label_score_percent:setText(string.format("%s%%",score))
            local textID = self.levelCfg_.victoryTypeDescribe[1]
            local text   = TextDataMgr:getText(textID)
            self.textVictoryTitle:setTextById(100000012,text)
            if score > 0 and self.image_halloween_1._score ~= score then
                if not self.image_halloween_1.spine_halloween:isVisible() then
                    self.image_halloween_1.spine_halloween:play("animation",0)
                    self.image_halloween_1.spine_halloween:show()
                end
                self.image_halloween_1._score = score
            end
        else
            self.image_halloween_1:hide()
            self.image_halloween_2:show()
            self.image_halloween_2.label_time:setText(string.format("%s:%s" , min, sec))
            -- local text = FubenDataMgr:getPassCondDesc(BattleDataMgr:getPointId(), 1)
            local textID = self.levelCfg_.victoryTypeDescribe[2]
            local text   = TextDataMgr:getText(textID)
            self.textVictoryTitle:setTextById(100000012,text)
        end
        self.label_victory_time:hide() --右上角时间隐藏
        self.textVictorycontent:hide()
    elseif viewType == EC_LevelPassCond.SCORE2 then  -- (积分模式2)
        --时间刷新
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
        self.label_victory_time:setText(string.format("%s:%s", min, sec))
        self.panel_txjz:show() 
        self.Image_common_victory:hide()
        local score = victoryDecide.getScore()
        local params = victoryCfgs[1].victoryParam
        local index =  victoryDecide.getRating()
        self.panel_txjz.label_tx_score:setText(tostring(score))
        local minV = params[index]
        local maxV = params[index+1]
        if index <= 4 then 
            local percent = math.ceil((score -minV)*100/(maxV - minV)) 
            self.panel_txjz.loadingBar_cjtx_score:setPercent(percent)
        else
            self.panel_txjz.loadingBar_cjtx_score:setPercent(100)
        end
        if self.panel_txjz.rangeIndex ~= index then  
            --评级
            if self.panel_txjz.rangeIndex == nil then
                self.panel_txjz.spine_cjtx_score:play(score_effect_animations[index][2],1)
            else
                self.panel_txjz.spine_cjtx_score:play(score_effect_animations[index][1],0)
                self.panel_txjz.spine_cjtx_activation:show()
                self.panel_txjz.spine_cjtx_activation:play("animation2",0)
            end
            self.panel_txjz.rangeIndex = index
        end
    elseif viewType == EC_LevelPassCond.LIMIT_TIME_KILL
        or viewType == EC_LevelPassCond.LIMIT_TIME_KILL2
        or viewType == EC_LevelPassCond.TIMING
        or viewType == EC_LevelPassCond.SCORE3 
        or viewType == EC_LevelPassCond.COMBO_COUNT  then  -- 击杀怪物
        self.Image_common_victory4:show()
        self.label_victory_time:hide()
        local millisecond = math.floor(math.floor(victoryDecide.nRemainingTime)%1000*0.1)
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nRemainingTime*0.001, true)
        self.Image_common_victory4.label_time:setText(string.format("%s:%s'%02d" , min, sec ,millisecond))        
        
        local starCfg  = self.statistics_:getStarCfg()
        -- dump(starCfg)
        local maxValue = starCfg[#starCfg].starParam
        local curValue = self.statistics_.killNum
        if viewType == EC_LevelPassCond.COMBO_COUNT then 
            curValue = self.statistics_.maxComboNum
        elseif viewType == EC_LevelPassCond.SCORE3 then
            curValue = self.statistics_.getScore3() 
        elseif viewType == EC_LevelPassCond.TIMING then 
            curValue = self.statistics_.killNum
        elseif viewType == EC_LevelPassCond.LIMIT_TIME_KILL2 then 
            curValue = victoryDecide.nSecondTime
            maxValue = math.ceil(victoryDecide.nTime*0.001)
        end
        self.textVictorycontent:hide()
        -- self.textVictorycontent:setText(curValue)

        local percent  = math.floor(curValue*100 / maxValue) 
        if not self.Panel_passcond.isInit then
            local length = self.Panel_passcond:getSize().width
            self.Panel_passcond:show()
            for index, Image_pass_star in ipairs(self.Panel_passcond.star_status) do
                 local starInfo = starCfg[index]
                 if starInfo then
                    Image_pass_star:show()
                    Image_pass_star.value = starInfo.starParam
                    if viewType == EC_LevelPassCond.LIMIT_TIME_KILL2 then
                        Image_pass_star.label_pass_value:setText(TextDataMgr:getText(800040,starInfo.starParam))
                    else
                        Image_pass_star.label_pass_value:setText(starInfo.starParam)
                    end
                    local posX = Image_pass_star.value/maxValue*length
                    Image_pass_star:setPositionX(posX)
                else
                    Image_pass_star:hide()
                    Image_pass_star.value = 0
                end
            end
            self.Panel_passcond.isInit = true
        end
        self.Panel_passcond.loadbar:setPercent(percent)

        if viewType == EC_LevelPassCond.LIMIT_TIME_KILL2 then 
            for i, Image_pass_star in ipairs(self.Panel_passcond.star_status) do
                Image_pass_star.image_star_active:setVisible(curValue >= Image_pass_star.value)
            end
        else
            for i, Image_pass_star in ipairs(self.Panel_passcond.star_status) do
                if curValue >= Image_pass_star.value then 
                    Image_pass_star.value = 999999999
                    Image_pass_star.spine_effect:show()
                    Image_pass_star.image_star_active:show()
                    Image_pass_star.spine_effect:playByIndex(0, 0)
                    Image_pass_star.spine_effect:addMEListener(TFARMATURE_EVENT,function(skeletonNode)
                        skeletonNode:hide()
                        skeletonNode:removeMEListener(TFARMATURE_EVENT)
                    end)
                end
            end
        end

    end
    if viewType == EC_LevelPassCond.TIMING then
        self.image_time:hide()
    else
        if victoryDecide.nSecondTime < 11 and victoryDecide.nSecondTime > 0 then
            self.image_time:show()
            self.label_time:setText(tostring(victoryDecide.nSecondTime))
        else
            self.image_time:hide()
        end
    end

end

--组队通关条件
function BattleView:refreshTeamFightVictoryState()

    local victoryDecide = battleController.getVictoryDecide()
    local victoryCfgs   = victoryDecide.getData()
    local viewType      = victoryDecide.nViewType
    if viewType ~= 0 and self.Panel_victory:isVisible() then
        local text = TextDataMgr:getText(titleTexts[viewType])
        self.textVictoryTitle:setText(text)
    end
    print_("viewType:"..tostring(viewType))
    if viewType == EC_LevelPassCond.SCORE then
        local maxValue = victoryCfgs[1].victoryParam[1]
        local score = victoryDecide.getScore()
        local percent = math.min(100,math.floor(score*100/maxValue)) 
        -- self.panel_type_score.Label_team_value:setText(tostring(score))
        self.panel_type_score.Label_percent:setText(string.format("%s/%s",score,maxValue))   
        self.panel_type_score.LoadingBar:setPercent(percent)       
    end
    --网络状态显示
    self.panel_victory_time.Image_signal:setVisible(true)
    local ping = LockStep.getNetDelayTime(MainPlayer:getPlayerId())
    self.panel_victory_time.Label_signal:setString(tostring(math.floor(ping)))
    for i,v in ipairs(sinalQuality) do
        if ping > v.ping then
            self.panel_victory_time.LoadingBar_signal:setPercent(v.percent)
            self.panel_victory_time.Label_signal:setColor(v.color) 
            break
        end
    end

    --时间更新
    local _, hour, min, sec = Utils:getDHMS(victoryDecide.nSecondTime, true)
    self.label_victory_time:setText(string.format("%s:%s", min, sec))
    -- 倒计时展示
    if viewType == EC_LevelPassCond.TIMING then
        self.image_time:hide()
    else
        if victoryDecide.nSecondTime < 11 and victoryDecide.nSecondTime > 0 then
            self.image_time:show()
            self.label_time:setText(tostring(victoryDecide.nSecondTime))
        else
            self.image_time:hide()
        end
    end
    -- self.panel_team_victory:show()
    -- self.panel_type_score:hide()
    -- self.panel_type_guard:show()

    --积分模式
    --守护模式
end

function BattleView:showLadderBuffInfo()

    local curCircleInfo =  SkyLadderDataMgr:getCurCircleInfo()
    if not curCircleInfo then
        return
    end
    self.regionBuffs = curCircleInfo.regionBuffs or {}
    if not next(self.regionBuffs) then
        return
    end
    self.Panel_ladder_buff:show()
    self.Image_common_victory:hide()
    self.ListView_ladderBuff:removeAllItems()
    for k,v in ipairs(self.regionBuffs) do
        local effectItem = self.Panel_skyladder_item:clone()
        local buffCfg = SkyLadderDataMgr:getRankMatchBuff(v)
        local Label_tip = TFDirector:getChildByPath(effectItem, "Label_tip")
        Label_tip:setTextById(buffCfg.buffDescribe)
        self.ListView_ladderBuff:pushBackCustomItem(effectItem)
    end

end

function BattleView:showEndlessBuffInfo()
    self.Panel_endlessBuff:show()
    local endlessBuff = BattleDataMgr:getRacingEndlessBuff()
    for i, v in ipairs(endlessBuff) do
        local buffCfg = TabDataMgr:getData("EndlessBuff", v)
        local Panel_endlessBuffItem = self.Panel_endlessBuffItem:clone()
        local Image_buffIcon = TFDirector:getChildByPath(Panel_endlessBuffItem, "Image_buffIcon")
        local Label_buffDesc = TFDirector:getChildByPath(Panel_endlessBuffItem, "Label_buffDesc")
        Image_buffIcon:setTexture(buffCfg.buffIcon)
        Label_buffDesc:setTextById(buffCfg.buffDescribe)
        self.ListView_endlessBuff:pushBackCustomItem(Panel_endlessBuffItem)
    end
end

function BattleView:refreshEndlessVictoryState()
    local isRacingMode = FubenDataMgr:isEndlessRacingMode(self.levelCid_)
    self.Panel_victory:setVisible(not isRacingMode)
    self.label_victory_time:setVisible(isRacingMode)
    self.Image_common_victory:hide()

    if isRacingMode then
        local _, hour, min, sec = Utils:getDHMS(self.victoryDecide_.nSecondTime, true)
        self.label_victory_time:setTextById(800014, min, sec)
    else
        self.Image_endless_victory:show()
        local remainSec = math.max(0, self.levelCfg_.time - self.victoryDecide_.nSecondTime)
        local jumpLevel = FubenDataMgr:getEndlessJumpLevel(remainSec * 1000)
        if not self.endlessJumpLevel_ then
            self.endlessJumpLevel_ = jumpLevel
        end

        if self.endlessJumpLevel_ ~= jumpLevel then
            local action = Sequence:create({
                    ScaleTo:create(0.2, 1.4),
                    CallFunc:create(function()
                            self.textVictorycontent:setText(jumpLevel)
                            self.endlessJumpLevel_ = jumpLevel
                    end),
                    ScaleTo:create(0.2, 1.0),
            })
            self.Label_endless_jump_level:runAction(action)
        else
            self.Label_endless_jump_level:setText(jumpLevel)
        end

        local _, hour, min, sec = Utils:getDHMS(self.victoryDecide_.nSecondTime, true)
        self.Label_endless_time:setTextById(800014, min, sec)
        local percent = math.floor(self.victoryDecide_.nSecondTime / self.levelCfg_.time * 100)
        self.LoadingBar_endless_time:setPercent(percent)
    end

end


function BattleView:refreshVictoryState()
    if self.battleType_ == EC_BattleType.COMMON then
        self:refreshCommonVictoryState()
        if self.levelType_ == EC_FBLevelType.SKYLADDER then
            self.Panel_victory:setVisible(false)
        end
    elseif self.battleType_ == EC_BattleType.ENDLESS then
        self:refreshEndlessVictoryState()
    elseif self.battleType_ == EC_BattleType.TEAM_FIGHT then
        self:refreshTeamFightVictoryState()
    end

end

function BattleView:updateLevelTypeDisplay()
    self.Panel_practice:setVisible(self.levelCfg_.dungeonType == EC_FBLevelType.PRACTICE)
    self.panel_victory_time:setVisible(self.levelCfg_.dungeonType ~= EC_FBLevelType.PRACTICE)

    if self.levelType_ == EC_FBLevelType.PRACTICE then
        self.keyBoard.pause_btn:hide()
        self.Image_practice_atk_off:setVisible(not self.practice_atk_toggle)
        self.Image_practice_atk_on:setVisible(self.practice_atk_toggle)
        self.Image_practice_infinite_off:setVisible(not self.practice_infinite_toggle)
        self.Image_practice_infinite_on:setVisible(self.practice_infinite_toggle)
        self.Image_practice_hurt_off:setVisible(not self.practice_hurt_toggle)
        self.Image_practice_hurt_on:setVisible(self.practice_hurt_toggle)
        self.Image_hurt:setVisible(self.practice_hurt_toggle)

        self:updatePracticeHurtInfo()
    end
end


--    守护血量低于30%时，字体用红色（或者高亮字体）标注。
--    当守护血量低于1%时，不能显示为0%，始终显示为1%。


function BattleView:reLoadVictoryView()
    local victoryDecide = battleController.getVictoryDecide()
    local viewType = victoryDecide.nViewType
    if viewType == EC_LevelPassCond.GUARDMODE
    or viewType == EC_LevelPassCond.GUARDMODE_3 
    or viewType == EC_LevelPassCond.GUARDMODE_EX then  -- 守护模式
        self.textVictorycontent:setTextColor(me.c4b(0xFF,0xFF,0xFF,0xFF))
        self.textVictorycontent:setText("100/100")
    end
    if self.battleType_ == EC_BattleType.TEAM_FIGHT then -- 组队模式
        if self.passLevelCond_ == EC_LevelPassCond.GUARDMODE   --守护模式
        or self.passLevelCond_ == EC_LevelPassCond.GUARDMODE_3 
        or self.passLevelCond_ == EC_LevelPassCond.GUARDMODE_EX then
            self.panel_team_victory:show()
            self.panel_type_guard:show()
            self.panel_type_score:hide()
            self.label_victory_time:hide() --右上角时间隐藏  
        elseif self.passLevelCond_ == EC_LevelPassCond.SCORE then
            self.panel_team_victory:show()
            self.panel_type_guard:hide()
            self.panel_type_score:show()
        else
            self.panel_team_victory:hide()
        end
    end
    self:refreshVictoryState()
    self:updateLevelTypeDisplay()
end

function BattleView:_fadeOut()
    local panel   = TFPanel:create()
    -- BattleMgr.bindActionMgr(panel)
    -- panel:setAnchorPoint(me.p(0.5,0.5))
    panel:setBackGroundColorType(TF_LAYOUT_COLOR_SOLID)
    panel:setBackGroundColor(me.c3b(0,0,0))
    panel:setSize(self:getSize())
    local callback = CallFunc:create(function()
        panel:removeFromParent()
    end)
    local actions = {FadeOut:create(0.6),callback}
    panel:runAction(Sequence:create(actions))

    self:addChild(panel)
end

function BattleView:onShow()
    self.super.onShow(self)
    print("------------onShow-------------")
    if not self.bOnShow then
        self.Panel_fight:setCameraMask(eCameraFlag.CF_MAP)
        self:_fadeOut()
        self.bOnShow = true
        --开始战斗
        battleController.start()

        if battleController.isLockStep() then 
            LockStep.start()
        end
        --断线情况下显示暂停
        if not CommonManager:getConnectionStatus() then
            self:showPause()
        end
    end
end

function BattleView:exitBattle()
    self.mapView:clean()

    battleController.exitBattle()
    --清理场景上的节点
    self.Panel_map:removeAllChildren()
    --清理觉醒相关的子节点
    self.Panel_awake:removeAllChildren()
end


--加载地图
function BattleView:loadMap()
    self.mapView = BattleMap:new(battleController)
    self.Panel_map:addChild(self.mapView)
    --创建跳转点
    battleController.createJumpPoint()
end

function BattleView:onPause(keepSound)
    self.pause_ = true
    if not keepSound then
        TFAudio:pauseAllEffects()
        TFAudio:pauseMusic()
    end
end

function BattleView:onResume()
    self.pause_ = false
    TFAudio:resumeMusic()
    TFAudio:resumeAllEffects()
end

function BattleView:onLeave()
    if self.battleType_ == EC_BattleType.ENDLESS then
        self:showEndlessResult()
    else
        self:showFuben()
    end
end

function BattleView:backGame()
    self:onResume()
end

function BattleView:registerEvents()
    -------全局事件-----
    -- EventMgr:addEventListener(self,eEvent.EVENT_HERO_DEAD_BEFORE, handler(self.onHeroDeadBefore, self))
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_CHANGE_DUNGEON, handler(self.showChangeDungeon, self))
    --蓄力条更新
    EventMgr:addEventListener(self,eEvent.EVENT_GATHER_BAR_UPDATE, handler(self.onGatherBarUpdate, self))
    EventMgr:addEventListener(self,eEvent.EVENT_INITED_TEAM, handler(self.onTeamInited, self))
    EventMgr:addEventListener(self,eEvent.EVENT_ACTOR_ADD_TO_LAYER, handler(self.onActorAddToLayer, self))
    EventMgr:addEventListener(self,eEvent.EVENT_TIP, handler(self.showTip, self))
    EventMgr:addEventListener(self,eEvent.EVENT_EFFECT_ADD_TO_LAYER, handler(self.onEffectAddToLayer, self))
    EventMgr:addEventListener(self,eEvent.EVENT_SCREEN_WOBBLE, handler(self.onScreenWobble, self))
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_AWAKE, handler(self.onShowAwake, self))
    EventMgr:addEventListener(self,eEvent.EVENT_HIDE_AWAKE, handler(self.onHideAwake, self))
    EventMgr:addEventListener(self,eEvent.EVENT_CAMERA_EVENT, handler(self.onCameraEvent, self))
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_COMBO, handler(self.onShowCombo, self))
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_BATTLE_START, handler(self.onBattleStart, self))
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW__STACE_CLEAR, handler(self.onStaceClear, self))
    EventMgr:addEventListener(self,eEvent.EVENT_PAUSE, handler(self.onPause, self))
    EventMgr:addEventListener(self,eEvent.EVENT_RESUME, handler(self.onResume, self))
    EventMgr:addEventListener(self,eEvent.EVENT_LEAVE, handler(self.onLeave, self))
    --显示目标提示

    EventMgr:addEventListener(self,eEvent.EVENT_PREWARTIP_SHOW, handler(self.showPrewarTip, self))
    ----
    EventMgr:addEventListener(self,eEvent.EVENT_VISUAL_HERO_ADD_TO_LAYER, handler(self.onAddVisualHeroToLayer, self))
    --英雄状态
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_STATE, handler(self.onShowState, self))
    EventMgr:addEventListener(self, eEvent.EVENT_HERO_DEAD, handler(self.onHeroDead, self))
    --update
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    self:addMEListener(TFWIDGET_EXIT, handler(self._onExit, self))
    -- 常规战斗结束
    EventMgr:addEventListener(self, EV_BATTLE_FIGHTOVER, handler(self.onEndBattleEvent, self))
    -- 无尽模式战斗通关
    EventMgr:addEventListener(self, EV_FUBEN_ENDLESSFIGHTVICTORY, handler(self.onEndlessPassEvent, self))
    -- 无尽模式继续
    EventMgr:addEventListener(self, EV_FUBEN_ENDLESS_CONTINUE, handler(self.onEndlessContinueEvent,self))
    -- 复活成功
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_FIGHT_REVIVE, handler(self.onReviveSuccess, self))

    EventMgr:addEventListener(self,EV_FUNC_STATE_CHANGE, handler(self.onFuncStateChange,self))
    EventMgr:addEventListener(self,EV_RECV_CHATINFO, handler(self.onRecvChatMsg,self))
    -- 木桩副本刷怪
    EventMgr:addEventListener(self, EV_PRACTICE_BRUSH_MONSTER, handler(self.onPracticeBrushEvent, self))
    --断线
    EventMgr:addEventListener(self,EV_OFFLINE_EVENT, handler(self.onOffline,self))
    --重连
    EventMgr:addEventListener(self,EV_RECONECT_EVENT, handler(self.onReconnect,self))
    --游戏切后台处理
    EventMgr:addEventListener(self,EV_APP_ENTERBACKGROUND, handler(self.onEnterBackGround,self))
    --显示提示事件信息
    EventMgr:addEventListener(self,eEvent.EVENT_BATTLE_TIPS, handler(self.onBattleEvtTips, self))
    -------------UI事件--------------
    if self.battleType_ == EC_BattleType.TEAM_FIGHT then
        self.keyBoard.pause_btn:setTextureNormal("ui/battle/n212.png")
        self.keyBoard.pause_btn:setScale(0.75)
        self.button_set:show()
        self.button_set:setTouchEnabled(true)
    else
        self.button_set:hide()
        self.button_set:setTouchEnabled(false)
    end
    self.button_set:onClick(function()
        local layer = Utils:openView("settings.SettingsView") -- 策划需求直接定位战斗页签
        layer:showPanelBattle()
        layer:changeBtnSelStatus("battle")
    end)
    -- 暂停
    self.keyBoard.pause_btn:onClick(function()
        --组队模式
        if self.battleType_ == EC_BattleType.TEAM_FIGHT then
            TeamFightDataMgr:showExitTeamFightBox()
        elseif self.battleType_ == EC_BattleType.COMMON then
            -- self:commonPauseGame()
            if not battleController.isClearing then
                BattleUtils:openView("battle.BattlePauseView")
                self:onPause()
            end
        elseif self.battleType_ == EC_BattleType.ENDLESS then
            Utils:openView("battle.EndlessPauseView")
            self:onPause()
        end
        -- TODO 测试
        -- Utils:openView("battle.LevelInfoLayer")
        -- self:showChangeDungeon()
    end)

    -- 练习模式设置怪物
    self.Button_practice_set:onClick(function()
            Utils:openView("battle.PracticeSetView", self.practiceSelectIndex_)
    end)
    -- 练习模式重置怪物
    self.Button_practice_reset:onClick(function()
            EventMgr:dispatchEvent(EV_PRACTICE_BRUSH_MONSTER, self.practiceSelectIndex_)
    end)
    -- 练习模式离开
    self.Button_practice_exit:onClick(function()
            self:onLeave()
    end)
    -- 练习模式攻击开关
    self.Panel_practice_atk_touch:onClick(function()
            self.practice_atk_toggle = not self.practice_atk_toggle
            self.Image_practice_atk_off:setVisible(not self.practice_atk_toggle)
            self.Image_practice_atk_on:setVisible(self.practice_atk_toggle)
            AIAgent:setEnabled(self.practice_atk_toggle)
            print_("AI 开关..:"..tostring(self.practice_atk_toggle))
    end)
    -- 练习模式无尽能量
    self.Panel_practice_infinite_touch:onClick(function()
            self.practice_infinite_toggle = not self.practice_infinite_toggle
            self.Image_practice_infinite_off:setVisible(not self.practice_infinite_toggle)
            self.Image_practice_infinite_on:setVisible(self.practice_infinite_toggle)
            local captain = battleController.getCaptain()
            if self.practice_infinite_toggle then
                captain:setPracticeInfinite(true)
            else
                captain:setPracticeInfinite(false)
            end
    end)
    -- 练习模式伤害面板开关
    self.Panel_practice_hurt_touch:onClick(function()
            self.practice_hurt_toggle = not self.practice_hurt_toggle
            self.Image_practice_hurt_off:setVisible(not self.practice_hurt_toggle)
            self.Image_practice_hurt_on:setVisible(self.practice_hurt_toggle)
            self.Image_hurt:setVisible(self.practice_hurt_toggle)

            self.statistics_.practiceTimePause = true
            self.statistics_.practiceTime = 0
            self.statistics_.hitValue = 0
            self.Button_hurt_resume:show()
            self.Button_hurt_pause:hide()
            self:updatePracticeHurtInfo()
    end)

    self.Button_endlessBuff_open:onClick(function()
            self.Button_endlessBuff_open:hide()
            self.Button_endlessBuff_close:show()
            self.ListView_endlessBuff:s():show()
    end)

    self.Button_endlessBuff_close:onClick(function()
            self.Button_endlessBuff_open:show()
            self.Button_endlessBuff_close:hide()
            self.ListView_endlessBuff:s():hide()
    end)

    self.Button_ladderBuff_open:onClick(function()
        self.Button_ladderBuff_open:hide()
        self.Button_ladderBuff_close:show()
        self.ListView_ladderBuff:s():show()
    end)

    self.Button_ladderBuff_close:onClick(function()
        self.Button_ladderBuff_open:show()
        self.Button_ladderBuff_close:hide()
        self.ListView_ladderBuff:s():hide()
    end)


    self.Button_hurt_reset:onClick(function()
            self.statistics_.practiceTimePause = true
            self.statistics_.practiceTime = 0
            self.statistics_.hitValue = 0
            self.Button_hurt_resume:show()
            self.Button_hurt_pause:hide()
            self:updatePracticeHurtInfo()
    end)

    self.Button_hurt_resume:onClick(function()
            self.statistics_.practiceTimePause = false
            self.Button_hurt_resume:hide()
            self.Button_hurt_pause:show()
    end)

    self.Button_hurt_pause:onClick(function()
            self.statistics_.practiceTimePause = true
            self.Button_hurt_resume:show()
            self.Button_hurt_pause:hide()
    end)

    self.keyBoard.skill_help_btn:onClick(function( ... )
        self:onPause()
        local captain = battleController.getCaptain()
        Utils:openView("battle.SkillHelpView",captain:getData().id)
    end)

    EventMgr:addEventListener(self,eEvent.EVENT_CAPTAIN_CHANGE, handler(self.onCaptainChange,self))
    --角色属性变更
    EventMgr:addEventListener(self,eEvent.EVENT_HERO_ATTR_CHANGE, handler(self.onHeroAttrChange,self))
    --boss变更通知UI刷新
    EventMgr:addEventListener(self,eEvent.EVENT_BOSS_CHANGE, handler(self.onBossChange,self))
    --boss出现预警
    EventMgr:addEventListener(self,eEvent.EVENT_BOSS_WARNING, handler(self.onBossWarning,self))
    --角色不在屏幕以内时小箭头提示
    EventMgr:addEventListener(self,eEvent.EVENT_ADD_PROMPT, handler(self.onAddPrompt,self))
    --引导前进
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_GO, handler(self.onShowGo,self))
    --显示挑战进度
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_CHALLENGE_PROGRESS, handler(self.onShowChallengeProgress,self))
    --onShowHitLine
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_HITLINE, handler(self.onShowHitLine,self))
    --角色入场CD
    EventMgr:addEventListener(self,eEvent.EVENT_ENTER_BATTLE_CD, handler(self.onEnterBattleCD,self))
    --
    EventMgr:addEventListener(self,eEvent.EVENT_HIT_BLUR, handler(self.onHitBlur,self))
    EventMgr:addEventListener(self,eEvent.EVENT_HIT_BLAST, handler(self.onHitBlast,self))
    EventMgr:addEventListener(self,eEvent.EVENT_MAP_MASK, handler(self.onMapMask,self))
    EventMgr:addEventListener(self,eEvent.EVENT_ADDTO_UI_EFFECT, handler(self.onAddToUIEffect,self))
    EventMgr:addEventListener(self,eEvent.EVENT_FIX_CAMERA_Z, handler(self.onFixCameraZ,self))
    EventMgr:addEventListener(self,eEvent.EVENT_REFRESH_VICTORY_STATE, handler(self.refreshVictoryState,self))
    EventMgr:addEventListener(self,eEvent.EVENT_BUFFER_EFFECT_ICON, handler(self.onBufferEffectIcon,self))
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_ASSIT, handler(self.onShowAssit,self))
    EventMgr:addEventListener(self,eEvent.EVENT_KEYBOARD_SHOW, handler(self.onKeyBoardShow,self))
    EventMgr:addEventListener(self,eEvent.EVENT_BATTLE_UI_SHOW, handler(self.onBattleUIShow,self))
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_COUNTDOWN, handler(self.onShowCountDown,self))
    EventMgr:addEventListener(self,eEvent.EVENT_SHOW_KEYLIST, handler(self.showKeyList, self))
    EventMgr:addEventListener(self,eEvent.EVENT_MONSTER_WARNING, handler(self.showNextWaveCountDownTime, self))

    --TODO 测试开关
    -- local _count = 0
    -- self.plyerNode.image_head:setTouchEnabled(true)
    -- self.plyerNode.image_head:addMEListener(TFWIDGET_CLICK, function()
    --         _count = (_count + 1)%5  --0-4
    --         if _count == 4 then
    --             BattleConfig.SHADER_BLUR  = false
    --             BattleConfig.SHADER_BLAST = false
    --             self:applyShader(eShaderType.DEFAULT)
    --         elseif _count == 3 then
    --             BattleConfig.SHADER_BLUR  = true
    --             BattleConfig.SHADER_BLAST = true
    --         end
    --         print("_count:".._count)
    --     end)

    EventMgr:addEventListener(self,"applicationDidEnterBackground", handler(self.onApplicationDidEnterBackground, self))
end


function BattleView:onApplicationDidEnterBackground(...)
    if not battleController.isLockStep() then 
        self:showPause()
    end
end
local Ran_Posy = { 300 , -300 , 0}
function BattleView:showScore(score,pos)

-- 粒子飞行特效
    local function playParticle()    
        --转换为UI里位置
        local position = self.camera:transPosition(pos)
        --粒子特效
        local effectParticle = TFParticle:create("particles/particle.plist")
        effectParticle:show()
        self.Panel_top:addChild(effectParticle)
        effectParticle:setVisible(true)
        effectParticle:setPosition(position)
        effectParticle:resetSystem()  
        local targetPos = self.panel_type_score.LoadingBar:getPosition()
        local worldpos  = self.panel_type_score.LoadingBar:getParent():convertToWorldSpace(targetPos)
        targetPos = self.Panel_top:convertToNodeSpace(worldpos)
        local centerPos = me.p(targetPos.x - 300 , targetPos.y + Ran_Posy[RandomGenerator._random(1,3)] )
        local time = (me.pGetDistance(position,centerPos) + me.pGetDistance(centerPos,targetPos))/800
        local actions = 
        {
            EaseSineOut:create(
                BezierTo:create(time, {position, centerPos, targetPos})
                )
            ,
            CallFunc:create(function()
                self.panel_type_score.Spine_get:play("blue_1",0)
                self.panel_type_score.Spine_get:show()
                effectParticle:removeFromParent()
            end)
        }
        effectParticle:runAction(Sequence:create(actions))
    end



-- #FF5DCCFF
    --显示积分特效
    local skeletonNode = ResLoader.createEffect("effect_point_01",1)
    if score < 5 then 
        skeletonNode:play("green",0) --3 green purple
    elseif score == 5 then 
        skeletonNode:play("blue",0) --5 blue
    elseif score > 5 then  
        skeletonNode:play("purple",0) --10 purple
    end
    skeletonNode:setPosition(pos)
    skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        playParticle()
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
    end)
    skeletonNode:setZOrder(201)
    skeletonNode:setCameraMask(self.Panel_effect:getCameraMask())
    self.Panel_effect:addChild(skeletonNode)

    
end

function BattleView:showStarEffect(pos)
    local time = os.time()
    if self.Panel_passcond.playTime then
        if time - self.Panel_passcond.playTime   < 1 then
            return
        end
    end
    self.Panel_passcond.spine_effect:show()
    self.Panel_passcond.spine_effect:playByIndex(0,0)
    self.Panel_passcond.playTime = time
end



function BattleView:showPause()
    if battleController.isClearing then --战斗结算不处理断线暂停
        return
    end
    if self.levelCfg_.dungeonType == EC_FBLevelType.PRACTICE then
        return
    end
    if self.battleType_ == EC_BattleType.TEAM_FIGHT then
        --组队模式不需要处理
    elseif self.battleType_ == EC_BattleType.COMMON then
        if self.levelType_ ~= EC_FBLevelType.PRACTICE then
            if not AlertManager:isLayerInQueue("PauseView") then  --避免重复弹窗
                BattleUtils:openView("battle.BattlePauseView")
            end
            self:onPause()
        end
    elseif self.battleType_ == EC_BattleType.ENDLESS then
        if not AlertManager:isLayerInQueue("EndlessPauseView") then
            Utils:openView("battle.EndlessPauseView")
        end
        self:onPause()
    end
end

function BattleView:onKeyBack()
    if battleController.isClearing then --战斗结算处理返回按钮
        if self.battleType_ == EC_BattleType.TEAM_FIGHT then
            TeamFightDataMgr:reset()
        end
        if GuideDataMgr:isInNewGuide() and AlertManager:getMainSceneCacheLayerNum() < 1 then
            AlertManager:setOpenFubenCom(true)
        end
        GuideDataMgr:setPlotLvlBackState(false)
        AlertManager:changeScene(SceneType.MainScene)
        return
    end
    if self.battleType_ == EC_BattleType.TEAM_FIGHT then
        TeamFightDataMgr:showExitTeamFightBox()
    else
        if self.battleType_ == EC_BattleType.COMMON and self.levelType_ == EC_FBLevelType.PRACTICE then
            self:onLeave()
        else
            self:showPause()
        end
    end
end

function BattleView:onEnterBackGround()
    self:showPause()
end

--断线
function BattleView:onOffline()
    self:showPause()
end

--重连
function BattleView:onReconnect()
    --TODO 重连成功不做处理由玩家手动继续游戏
    --fix 战斗结算在跳出特效时断网，卡死 2020-7-11
    if (not self.endMsgFlag_) and self.endAniFlag_ then
        AlertManager:changeScene(SceneType.MainScene)
    end
end


function BattleView:cloneLoadBar()
    return self.prefab_loadbar:clone()
end

function BattleView:onKeyBoardShow(isShow)
    self.keyBoard:setVisible(isShow)
end

function BattleView:onBattleUIShow(isShow)
    self.Panel_ui:setVisible(isShow)
    self.Panel_effect:setVisible(isShow)
end



--buffer effect icon state change
function BattleView:onBufferEffectIcon(object,state)
    print("icon event:",state)
    local listView = self.captainIconListView
    local hero
    if state == eBufferEffectIconEvent.RELOAD then --重先载入(切换角色时触发)
        hero = object
    else
        hero = object.host
    end
    if hero:isBoss() then
        listView = self.bossIconListView
        if self.bossIconListView.objectId ~= hero:getObjectID() then
            return
        end
    else
        listView = self.captainIconListView
    end

    if state == eBufferEffectIconEvent.ADD then --添加
        listView:createItem(object,true,self.prefab_buff_icon)
    elseif state == eBufferEffectIconEvent.REMOVE then --移除
        listView:removeItem(object)
    elseif state == eBufferEffectIconEvent.UPDATE_ADDTIMES then --更新次数
        listView:refresh(object)
    elseif state == eBufferEffectIconEvent.TWINKLE  then --闪烁
        listView:twinkle(object)
    elseif state == eBufferEffectIconEvent.RELOAD then --重先载入(切换角色时触发)
        listView:reload(object,false,self.prefab_buff_icon)
    end
end

--功能状态变更
function BattleView:onFuncStateChange(func)
    if func then
        if func.switchType == EC_FunctionEnum.TEAM_FIGHT then
            if not func.open then
                AlertManager:changeScene(SceneType.MainScene)
            end
        end
    end
end

function BattleView:onFixCameraZ(time,fixZ)
    if self.camera then
        self.camera:setFixZ(time,fixZ)
    end
end



function BattleView:onMapMask(visible)
    local pos3D = battleController.getCameraPos3D()
    if visible then
        self.mapView:showMask(pos3D)
    else
        self.mapView:hideMask()
    end
end

function BattleView:onAddToUIEffect(effect)
    local size = self.Panel_ui_effect_bottom:getSize()
    effect:setPosition(me.p(size.width/2,size.height/2))
    effect:setCameraMask(self.Panel_ui_effect_bottom:getCameraMask())
    self.Panel_ui_effect_bottom:addChild(effect)
end

-- 助战报幕
function BattleView:onShowAssit(hero)
    hero = hero or battleController.getTeam():getAssist()
    if hero then
        self.Panel_assist.textName:setText(hero:getName())
        self.Panel_assist.imageIcon:setTexture(hero:getData().heroIcon)
    end
    local size = self.Panel_assist:getSize()
    self.Panel_assist:show()
    self.Panel_assist:setPositionX(size.width + 100)
    local actions =
    {
        MoveTo:create(0.5,me.p(0,0)),
        DelayTime:create(1),
        MoveTo:create(0.5,me.p(size.width + 100,0)),
        Hide:create()
    }
    self.Panel_assist:runAction(Sequence:create(actions))
end

--显示挑战进度 356
function BattleView:onShowHitLine(pos)
    local skeletonNode = ResLoader.createEffect("effects_HitLine",1)
    local actIdx = RandomGenerator._random(0,3)
    skeletonNode:playByIndex(actIdx,0)
    skeletonNode:setPosition(pos)
    skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
    end)
    self.mapView:addObject3(skeletonNode)
end

--显示挑战进度 356
function BattleView:onShowChallengeProgress(index)
    local statistics = self.statistics_
    local starCfg = statistics:getStarCfg()
    local starInfo = starCfg[index]

    local starType = starInfo.starType
    local starDescribe = EC_FBStarRuleStr[starType]
    if starInfo then
        local isReach = statistics.getStarIsReach(index)
        self.Panel_progress:show()
        self.Panel_progress:stopAllActions()
        self.Panel_progress:fadeIn(0.1)
        self.Panel_progress:timeOut(function ()
            self.Panel_progress:fadeOut(0.5)
        end,2)
        -- if isReach then
        --     self.label_tip2:setColor(me.c3b(0x00,0xff,0x00))
        -- else
        --     self.label_tip2:setColor(me.c3b(0xBB,0xBB,0xBB))
        -- end

        self.label_tip1:setText(TextDataMgr:getText(starDescribe ,starInfo.starParam))
        local curValue = statistics.getStarRuleValue(starType,starInfo.starParam)
        local desc = FubenDataMgr:getStarRuleDesc(self.levelCid_, starInfo.pos)
        self.label_tip1:setText(desc)
        local condRule1, condRule2, condRule3, condRule4, condRule5 = statistics.getAllCondStarType()
        if table.indexOf(condRule1, starType) ~= -1 then
            if isReach then
                self.label_tip2:setTextById(100000006, curValue, starInfo.starParam)
            else
                self.label_tip2:setTextById(800063)
            end
            self.Image_star:setGrayEnabled(true)
        elseif table.indexOf(condRule2, starType) ~= -1 then
            if isReach then
                self.label_tip2:setTextById(300611)
            else
                self.label_tip2:setTextById(304004)
            end
            self.Image_star:setGrayEnabled(not isReach)
        elseif table.indexOf(condRule3, starType) ~= -1 then
            if isReach then
                self.label_tip2:setTextById(300611)
            else
                self.label_tip2:setTextById(100000006, curValue, starInfo.starParam)
            end
            self.Image_star:setGrayEnabled(not isReach)
        elseif table.indexOf(condRule4, starType) ~= -1 then
            if isReach then
                self.label_tip2:setTextById(100000007)
            else
                self.label_tip2:setTextById(100000008)
            end
            self.Image_star:setGrayEnabled(not isReach)
        elseif table.indexOf(condRule5, starType) ~= -1 then
            if isReach then
                self.label_tip2:setTextById(100000009)
            else
                self.label_tip2:setTextById(100000008)
            end
            self.Image_star:setGrayEnabled(true)
        end
    end
end

--引导前进
function BattleView:onShowGo(visible)
    self.image_go:stopAllActions()
    if not visible then
        self.image_go:hide()
    else
        self.image_go:runAction(RepeatForever:create(Blink:create(2,3)))
        self.image_go:show()
    end
end

--角色不在屏幕以内时小箭头提示
function BattleView:onAddPrompt(node)
    node:retain()
    node:removeFromParent()
    self.Panel_ui:addChild(node)
    node:setCameraMask(self.Panel_ui:getCameraMask())
    node:release()
end

--竞速模式倒计时动画
function BattleView:onShowCountDown(callFunc)
    local size = self.Panel_ui_effect_top:getSize()
    local skeletonNode = ResLoader.createEffect("effect_online_ui1",1)
    -- skeletonNode:playByIndex(0,0)
    local size =  me.EGLView:getDesignResolutionSize()
    skeletonNode:play("animation",0)
    skeletonNode:setPosition(me.p(size.width/2,size.height/2))
    skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
        if callFunc then
            callFunc()
        end
    end)
    self.Panel_ui_effect_top:addChild(skeletonNode)
end
--boss 预警动画
function BattleView:onBossWarning(callFunc)
    local size = self.Panel_ui_effect_top:getSize()
    local skeletonNode = ResLoader.createEffect("battle_enemy",1)
    -- skeletonNode:playByIndex(0,0)
    local size =  me.EGLView:getDesignResolutionSize()
    if size.width > 1136 then
        skeletonNode:play("1386",0)
    else
        skeletonNode:play("1136",0)
    end
    skeletonNode:setPosition(me.p(size.width/2,size.height/2))
    skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
        if callFunc then
            callFunc()
        end
    end)
    self.Panel_ui_effect_top:addChild(skeletonNode)
end



function BattleView:onHeroAttrChange(hero)
    if not hero then 
        return 
    end
    self:heroDeadAlertCheck(hero)

    local property = hero.property
    local captain = battleController.getCaptain()
    if hero == captain then
        self.plyerNode.loadingBar_hp:setPercent(BattleUtils.fixPercent(hero:getHpPercent()*0.01))

        local resPath = hero:getData().fightIcon
        if self.plyerNode.imageHead._resPath ~= resPath then
            self.plyerNode.imageHead:setTexture(resPath) --TODO 这不科学
            self.plyerNode.imageHead._resPath = resPath

           PrefabDataMgr:setInfo(self.plyerNode.panel_element , hero:getData().magicAttribute , nil , false)


           --检查boss克制属性
            if self.bossNode:isVisible() then
                if self.bossNode.bossData then
                    self:onBossChange(self.bossNode.bossData)
                end
            end
        end


        local powerData = hero:getEnergyData()
        if powerData then
            if powerData.specialEnergyUI == 1 then 
                self.keyBoard.Image_specialEnergy:setVisible(true)  
                local percent = math.ceil(hero:getSpecialEnergyPercent()*0.005) + 50
                self.keyBoard.LoadingBar_specialEnergy:setPercent(percent)
            else
                self.keyBoard.Image_specialEnergy:setVisible(false)
            end
            self.plyerNode.label_sp:show()
            for i,node in ipairs(self.plyerNode.spNodes) do
                node:hide()
                if node.effect then
                    node.effect:hide()
                end
            end
            if self.plyerNode.label_sp._powerName ~= powerData.powerName then
                self.plyerNode.label_sp:setText(TextDataMgr:getText(powerData.powerName))
                self.plyerNode.label_sp._powerName = powerData.powerName
            end
            local spNode = self.plyerNode.spNodes[powerData.powerUI]
            spNode:show()
            if powerData.powerUI  == 11 then --强化十香 
                local energy    = hero:getEnergy()
                local maxEnergy = hero:getMaxEnergy()
                local num    = math.floor(energy/100)
                local value  = math.floor(energy)%100
                for k , checkBox in ipairs(spNode.checkBoxs) do
                    checkBox:setSelectedState(k <= num)
                end
                spNode.loadingBar:setPercent(value)
            else
                if spNode.label_value then
                    spNode.label_value:setText(string.format("%s/%s",hero:getEnergy(),hero:getMaxEnergy()))
                end
                if spNode.loadingBar then
                    spNode.loadingBar:setPercent(hero:getEnergyPercent()*0.01)
                end
                if spNode.effect then
                    if hero:getEnergyPercent() >= 10000 then
                        spNode.effect:setVisible(true)
                        if not spNode.effect.playing then
                            spNode.effect:playByIndex(0,1)
                            spNode.effect.playing = true
                        end
                    else
                        spNode.effect:setVisible(false)
                        spNode.effect.playing = false
                    end
                end
            end
        else
            self.keyBoard.Image_specialEnergy:setVisible(false)
            self.plyerNode.label_sp:hide()

        -- dump(self.plyerNode.spNodes)
            for i,node in ipairs(self.plyerNode.spNodes) do
                node:hide()
                if node.effect then
                    node.effect:hide()
                end
            end
        end
    end

    if self.roulette:isVisible() then
        self.roulette:refreshItem(hero)
    end
    -- --检查Boss 血条刷新
    if self.bossNode:isVisible() then
        if self.bossNode.objectId == hero:getObjectID() then
            self:onBossChange(hero)
        end
    end


    -- 守护英雄
    if self.passLevelCond_ == EC_LevelPassCond.GUARDMODE 
    or self.passLevelCond_ == EC_LevelPassCond.GUARDMODE_3
    or self.passLevelCond_ == EC_LevelPassCond.GUARDMODE_EX then
        if self.battleType_ == EC_BattleType.TEAM_FIGHT then
            if hero:getMonsterType() == EC_MonsterType.GUARD then
                local percent = hero:getHpPercent() * 0.01
                if percent < 50 then 
                    percent = math.ceil(percent)
                else
                    percent = math.floor(percent)
                end
                self.panel_type_guard.Label_team_title:setText(hero:getName())--角色名字 
                self.panel_type_guard.Label_percent:setText(string.format("%s/100",percent)) 
                self.panel_type_guard.LoadingBar:setPercent(percent)    
            end
        else  --非组队模式下的守护模式
            if hero:getMonsterType() == EC_MonsterType.GUARD then
                local percent = math.ceil(hero:getHpPercent() * 0.01)
                if percent < 30 then
                    self.textVictorycontent:setTextColor(me.c4b(0xFF,0,0,0xFF))
                else
                    self.textVictorycontent:setTextColor(me.c4b(0xFF,0xFF,0xFF,0xFF))   
                end
                self.textVictorycontent:setText(string.format("%s/100",percent))
            end
        end
    end
    if self.battleType_ == EC_BattleType.TEAM_FIGHT then
        self:updateTeamPad()
    end

end
--怪物属性刷新
function BattleView:onBossChange(hero)
    if hero then
        --用于追猎计划战斗状态查看UI
        EventMgr:dispatchEvent(eEvent.EVENT_STATUS_BOSS,hero) 
        if self.bossNode.objectId ~= hero:getObjectID() then
            self.bossIconListView.objectId = hero:getObjectID()
            self.bossIconListView:reload(hero,false,self.prefab_buff_icon) --重先载入buffer图标
            self.bossNode.objectId = hero:getObjectID()
            self.bossNode.bossData = hero
        end
        self.bossNode:show()
        self.bossNode:stopAllActions()
        -- local num = math.max(hero:getData().healthBar,1)
        -- self.bossNode.label_loadbar_num:setText(string.format("x%s",num))

        local resPath = hero:getData().fightIcon
        if self.bossNode.imageHead._resPath ~= resPath then
            self.bossNode.imageHead:setTexture(resPath)
            self.bossNode.imageHead._resPath = resPath
        end


        if self.lastCaptain ~= battleController:getCaptain() then
            local heroDat = hero:getData()
            local playerHeroData = battleController:getCaptain():getData()
            local pElementCfg = self.elementCfg[playerHeroData.magicAttribute]

            local isRefrain = nil   --是否克制
            for k ,v in pairs(pElementCfg.Refrain) do
                if v == heroDat.magicAttribute then
                    isRefrain = true
                    break
                end
            end
            if not isRefrain then
                for k ,v in pairs(pElementCfg.underrestraint) do
                    if v == heroDat.magicAttribute then
                        isRefrain = false
                        break
                    end
                end
            end
            self.lastCaptain = battleController:getCaptain()
            PrefabDataMgr:setInfo(self.bossNode.panel_element , heroDat.magicAttribute , isRefrain , false)
        end
        
       

        if hero:isUnlimitedHp() then 
            self.bossNode.label_loadbar_num:setText("x???")
            self.bossNode.label_loadbar_num:setVisible(true)
            local unlimitedHp = hero:getUnlimitedHp()
            local index = math.floor(unlimitedHp/100000)
            local showIndex = (index -1)%4 + 1
            local showIndex_= -1
            if index > 1 then
                showIndex_= showIndex -1
                showIndex_ = showIndex_ < 1 and (showIndex_ + 4) or showIndex_
            end
            local percent = math.floor(math.floor(unlimitedHp)%100000/1000)
            -- print("showIndex:",showIndex,percent)
            for i=1,4 do
                local loadbar = self.bossNode.loadingBarHps[i]
                if showIndex == i then
                    loadbar:show()
                    loadbar:setPercent(BattleUtils.fixPercent(percent))
                    loadbar:setZOrder(1)
                elseif showIndex_ == i then
                    loadbar:show()
                    loadbar:setPercent(100)
                    loadbar:setZOrder(0)
                else
                    loadbar:hide()
                end
            end
        else
            --血条(一共几条,显示当前的百分比)
            local index , percent = hero:getHpPercentEx()
            local showIndex = (index -1)%4 + 1
            local showIndex_= -1
            self.bossNode.label_loadbar_num:setText(string.format("x%s",index))
            self.bossNode.label_loadbar_num:setVisible(index>1)
      

            if index > 1 then
                showIndex_= showIndex -1
                showIndex_ = showIndex_ < 1 and (showIndex_ + 4) or showIndex_
            end
            for i=1,4 do
                local loadbar = self.bossNode.loadingBarHps[i]
                if showIndex == i then
                    loadbar:show()
                    loadbar:setPercent(BattleUtils.fixPercent(percent))
                    loadbar:setZOrder(1)
                elseif showIndex_ == i then
                    loadbar:show()
                    loadbar:setPercent(100)
                    loadbar:setZOrder(0)
                else
                    loadbar:hide()
                end
            end
        end
        --护盾值
        self.bossNode.loadingBar_np:setPercent(hero:getShieldPercent()*0.01)
        --霸体值
        if hero:getMaxResist() > 0 then
            self.bossNode.image_bg_nnp:show()
            self.bossNode.loadingBar_nnp:show()
            self.bossNode.loadingBar_nnp:setPercent(hero:getResistPercent()*0.01)
        else
            self.bossNode.image_bg_nnp:hide()
            self.bossNode.loadingBar_nnp:hide()
        end

        self.bossNode.label_name:setText(hero:getName())
        local affixData = hero:getAffixData()
        if affixData then
            for index, imageAffix in ipairs(self.bossNode.imageAffixs) do
                local affixIcon = affixData["affixIcon"..index]
                if ResLoader.isValid(affixIcon) then 
                    if imageAffix._texture ~= affixIcon then  --保存纹理路径避免重复setTexture
                        imageAffix:show()
                        imageAffix:setTexture(affixIcon)
                        imageAffix:setScale(0.4)
                        imageAffix._texture = affixIcon
                    end
                else
                    imageAffix._texture = nil
                    imageAffix:hide()
                end
            end

            -- self.bossNode.label_affix:show()
            -- self.bossNode.label_affix:setText(affixData.strName)
            self.bossNode.image_bg1:hide()
            self.bossNode.image_bg2:show()
        else
            for index, imageAffix in ipairs(self.bossNode.imageAffixs) do
                imageAffix:hide()
            end
            -- self.bossNode.label_affix:hide()
            self.bossNode.image_bg1:show()
            self.bossNode.image_bg2:hide()
        end
        --死亡倒计时2秒消失
        if hero:getHpPercent() == 0 then
            self.bossNode:timeOut(function()
                self.bossNode:hide()
            end,2)
        end
    else
        self.bossNode:hide()
    end

end




--角色切换冷却
function BattleView:onEnterBattleCD(hero,progress)
    if self.roulette:isVisible() then 
        self.roulette:refreshItem()
    end
end

function BattleView:onTeamInited()
    self._isInitlize = true
    self.plyerNode:setVisible(true)


    if battleController.isLockStep() then
        self.roulette:setVisible(false)
    else
        if self.levelType_ == EC_FBLevelType.PRACTICE then
            self.roulette:setVisible(false)
        else
            self.roulette:setVisible(true)
            self.roulette:doLayout()
        end
    end

    self:onHeroAttrChange(battleController.getCaptain())
    -- -- 通关条件显示
    -- if self.battleType_ ~= EC_BattleType.TEAM_FIGHT then
    --     self.Panel_victory:show()
    -- end
end

function BattleView:refreshRoulette()
    if self.roulette:isVisible() then 
        self.roulette:doLayout()
    end
end
--队长切换
function BattleView:onCaptainSelect(item)
    if not self._isInitlize then return end --TODO 临时解决切换角色导致无出生动作无回调的问题
    if not battleController:isRun() then return end
    local hero    = item.hero
    local captain = battleController.getCaptain()
    if hero ~= captain and hero:isAlive()  and hero:getProgress() < 1 then
        item.hero:setControl()
        self:refreshRoulette()
        self:onHeroAttrChange(item.hero)
    end
end
--队长切换
function BattleView:onCaptainChange()
    local hero = battleController.getCaptain()
    if hero ~= nil then
        self:refreshRoulette()
        self:onHeroAttrChange(hero)
        if self.levelCfg_.dungeonType == EC_FBLevelType.SPRITE_EXTRA then
            if hero:getData().id == 110102 then
                self.keyBoard.skill_help_btn:show()
            else
                 self.keyBoard.skill_help_btn:hide()
            end
        end
    end

end

function BattleView:update(target , deltaTime)
    if battleController.isLockStep() then -- 组队模式下开启帧同步
        LockStep.update(deltaTime,self)
    else
        self:gameRun(deltaTime)
    end
end

--要精确到毫秒只能每贞刷新
function BattleView:timeUpdate()
    local victoryDecide = battleController.getVictoryDecide()
    if victoryDecide.nViewType == EC_LevelPassCond.HALLOWEEN_DESTORY then  -- (万圣节活动-歼灭模式)
        local millisecond = math.floor(math.floor(self.statistics_.time)%1000*0.1)
        local _, hour, min, sec = Utils:getDHMS(self.statistics_.time*0.001, true)
        local score = victoryDecide.getScore()
        if score < 100 then
            self.image_halloween_1.label_time:setText(string.format("%s:%s" , min, sec ))
        else
            self.image_halloween_2.label_time:setText(string.format("%s:%s" , min, sec ))
        end
    elseif victoryDecide.nViewType == EC_LevelPassCond.LIMIT_TIME_KILL 
        or victoryDecide.nViewType == EC_LevelPassCond.SCORE3
        or victoryDecide.nViewType == EC_LevelPassCond.TIMING
        or victoryDecide.nViewType == EC_LevelPassCond.LIMIT_TIME_KILL2
        or victoryDecide.nViewType == EC_LevelPassCond.COMBO_COUNT  then
        local millisecond = math.floor(math.floor(victoryDecide.nRemainingTime)%1000*0.1)
        local _, hour, min, sec = Utils:getDHMS(victoryDecide.nRemainingTime*0.001, true)
        self.Image_common_victory4.label_time:setText(string.format("%s:%s'%02d" , min, sec ,millisecond))
    
    -- elseif victoryDecide.nViewType == EC_LevelPassCond.LIMIT_TIME_KILL2 then
    --     local starCfg  = self.statistics_:getStarCfg()
    --     local curValue = victoryDecide.nRemainingTime
    --     local maxValue = starCfg[1].starParam*1000   
    --     self.Panel_passcond.loadbar:setPercent(math.floor(curValue*100 / maxValue) )
    --     for i, Image_pass_star in ipairs(self.Panel_passcond.star_status) do
    --         Image_pass_star.image_star_active:setVisible(curValue >= Image_pass_star.value*1000)
    --     end
    --     local millisecond = math.floor(math.floor(victoryDecide.nRemainingTime)%1000*0.1)
    --     local _, hour, min, sec = Utils:getDHMS(victoryDecide.nRemainingTime*0.001, true)
    --     self.Image_common_victory4.label_time:setText(string.format("%s:%s'%02d" , min, sec ,millisecond))
    end

    if self.levelType_ == EC_FBLevelType.PRACTICE then
        self:updatePracticeHurtInfo()
    end
    --连击时间倒计时进度条
    local comboTime = self.statistics_.comboTime 
    if comboTime > 0 then
        local percent = 100 - math.ceil(comboTime*100 / BattleConfig.COMBO_TIME) 
        percent = math.max(0,percent)
        self.Panel_combo.loadingBar_time:setPercent(percent)
    end
end



function BattleView:gameRun(deltaTime)
    if self.pause_ then return end
    deltaTime = deltaTime*1000 * battleController.getTimeScale()
    --定贞处理
    if battleController.handlStopFrame(deltaTime) then
        return
    end
    if battleController.needUpdate() then
        battleController.update(deltaTime)
        BattleMgr.loop(deltaTime*0.001)
        self.camera:update(deltaTime)
        self.mapView:update(self.camera)
        self:timeUpdate()
        --模糊效果处理
        self:handleShader(deltaTime)
    else
        BattleMgr.loop(deltaTime*0.001)
        -- print("is not run.................")
    end
end

--角色添加到战斗场景
function BattleView:onActorAddToLayer(hero)
    local actor = hero.actor
    actor:addTo(self.mapView)
end

function BattleView:onEffectAddToLayer(effect,index)
    index = index or 2
    self.mapView:addObject(effect,index)
end

function BattleView:onAddVisualHeroToLayer(vHero,index)
    index = index or 2
    self.mapView:addObject(vHero,index)
end

function BattleView:onHeroDead(hero)
    if battleController.isLockStep() then
        if hero:getData().pid == MainPlayer:getPlayerId() then
            if battleController.isZLJH() then -- 追猎计划
                -- Box("显示队伍概况")
                if not battleController.isTeamMemberAllDead() then
                    AIAgent:setEnabled(false)
                    Utils:openView("battle.BattleStatus")
                end
            else
    
                local team = battleController.getTeam()
                if team and not team:isAllDeadByCampType(eCampType.Hero) then
                    self.keyBoard:showRevive()
                end
            end
        end
    end
-- end
-- function BattleView:onHeroDeadBefore(hero)
    --TODO 能量获得>0 的时候展示获取特效
    local campType = hero:getCampType()
    if campType == eCampType.Monster then
        local dropEnergy = hero:getData().dropEnergy or 0
        local position
        if dropEnergy > 0 then
            -- local position = hero:getPosition3D()
            position = hero:getBonePosition("root")
            position.y = position.y + 50
            local skeletonNode = ResLoader.createEffect("effect_monster_die",1)
            skeletonNode:play("effect_monster_die2",0)
            skeletonNode:setPosition(position)
            skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
                _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                _skeletonNode:removeFromParent()
            end)
            self:onEffectAddToLayer(skeletonNode,3)
            local pos = self.camera:transPosition(position)
            self.keyBoard:showParticles(pos)
        end
        if self.passLevelCond_ == EC_LevelPassCond.SCORE then --积分模式下才会显示获得积分
            local score = hero:getData().score or 0
            if score > 0 then 
                if not position then 
                    position = hero:getBonePosition("root")
                    position.y = position.y + 50
                end
                position.y = position.y + 150
                self:showScore(score,position)
            end
        elseif self.passLevelCond_ == EC_LevelPassCond.LIMIT_TIME_KILL then
            self:showStarEffect()
        elseif self.passLevelCond_ == EC_LevelPassCond.SCORE3 then --殺怪必然有積分獲取
            local data = hero:getData()
            if data.score and data.score > 0 then 
                self:showStarEffect()
            end
        elseif self.passLevelCond_ == EC_LevelPassCond.TIMING then  
            self:showStarEffect()
            if battleController:isRun() then
                local data = hero:getData()
                if data.killTime and data.killTime > 0 then 
                    self:showAddTime(data.killTime)
                end  
            end
        end
    end
end

local ADDTIME_POS_X = { -9, 3 ,0,-5}
local ADDTIME_INDEX = 1
function BattleView:showAddTime(time)
    local time = TextDataMgr:getText(800040,time)
    local x = 1
    local add_time = self.Image_common_victory4.add_time:clone()
    local pos = add_time:getPosition()
    self.Image_common_victory4:addChild(add_time)
    add_time:show()
    add_time:setText("+"..time)
    ADDTIME_INDEX = ADDTIME_INDEX + 1
    add_time:setPosition(ccp(ADDTIME_POS_X[ADDTIME_INDEX%4 + 1] + pos.x,pos.y))
    local actions = 
    {
        DelayTime:create(0.1),
        MoveBy:create(0.3,ccp(0,30)),
        RemoveSelf:create()
    }
    add_time:runAction(Sequence:create(actions))
end
function BattleView:onReviveSuccess()
    print("onReviveSuccess=======================>>>.")
    self.keyBoard:hideRevive()
end


function BattleView:createNumNode(numNodeType,value)
    local node      = self.prefabNums[numNodeType]:clone()
    local bmFont    = node:getChildByName("Label_font")
    local imageSign = node:getChildByName("Image_sign")
    bmFont:setSkewX(15)
    bmFont:setText(tostring(value))
    if imageSign then
        local size = bmFont:getSize()
        bmFont:setPositionX(10)
        imageSign:setPositionX(-size.width/2 - 10)
    end
    return node
end



--蚊子展示
function BattleView:onShowState(state,pos)
    local node = self.prefab_wenzi:clone()
    node:setText(state)
    node:setSkewX(15)
    node:setPosition(pos)
    node:setCameraMask(eCameraFlag.CF_MAP)
    node:setZOrder(201)
    self.Panel_effect:addChild(node)
    BattleUtils.tipAniRed(node)
end

function BattleView:showTip(deltaHp,pos,hurtType)
    local node
    if deltaHp < 0 then
        deltaHp = math.abs(deltaHp)
        if hurtType == eHurtType.RUO_DIAN then
            node = self:createNumNode(eNumNodeType.Ruodian,deltaHp)
        elseif hurtType == eHurtType.PUGONG then
            node = self:createNumNode(eNumNodeType.PuGong,deltaHp)
        elseif hurtType == eHurtType.SKILL then
            node = self:createNumNode(eNumNodeType.JiNeng,deltaHp)
        elseif hurtType == eHurtType.PARRY then --格挡(属于普通攻击)
            self:onShowState(eShowState.GeDang,pos)
            return
        elseif hurtType == eHurtType.PREICE then --穿透
            node = self:createNumNode(eNumNodeType.ChuanTou,deltaHp)
        elseif hurtType == eHurtType.CRIT then --暴击
            node = self:createNumNode(eNumNodeType.BaoJi,deltaHp)
        elseif hurtType == eHurtType.CRIT_PREICE then --穿透暴击
            node = self:createNumNode(eNumNodeType.BaojiChuanTou,deltaHp)
        elseif hurtType == eHurtType.DODGE then --miss
            self:onShowState(eShowState.Miss,pos)
            return
        elseif hurtType == eHurtType.DODGE1 then --闪避
            self:onShowState(eShowState.ShanBi,pos)
            return
        end
    elseif deltaHp == 0 then
        if hurtType == eHurtType.PARRY then --格挡
            self:onShowState(eShowState.GeDang,pos)
            return
        elseif hurtType == eHurtType.DODGE then --miss
            self:onShowState(eShowState.Miss,pos)
            return
        elseif hurtType == eHurtType.DODGE1 then --闪避
            self:onShowState(eShowState.ShanBi,pos)
            return
        end
    else
        node = self:createNumNode(eNumNodeType.ZhiYu,deltaHp)
    end
    if node then
        BattleUtils.tipAni(node)
        node:setPosition(pos)
        node:setCameraMask(self.Panel_effect:getCameraMask())
        node:setZOrder(200)
        self.Panel_effect:addChild(node)
    end
end


local shakePoints = {
    me.p(0,1),
    me.p(1,0),
    me.p(0,-1),
    me.p(-1,0)
}

local function transAnchorPoint(node,anchorPoint)
    local _pos         = node:getPosition()
    local _size        = node:getSize()
    local _anchorPoint = node:getAnchorPoint()
    local pos    = ccp(_pos.x - _size.width*_anchorPoint.x,_pos.y-_size.height*_anchorPoint.y)
    local newPos = ccp(pos.x + _size.width*anchorPoint.x ,pos.y +_size.height*anchorPoint.y)
    node:setPosition(newPos)
    node.defaultPos = newPos
    node:setAnchorPoint(anchorPoint)
end

--屏幕震动
function BattleView:onScreenWobble(data)
    -- if not self.cameraSprite then
    --     return
    -- end
    local screenWobbleNode = self.Panel_map
    if not screenWobbleNode.defaultPos then
        screenWobbleNode.defaultPos = screenWobbleNode:getPosition()
    end
    screenWobbleNode:stopAllActions()
    screenWobbleNode:setScale(1)
    screenWobbleNode:setPosition(screenWobbleNode.defaultPos) --还原默认位置
    local shakeCount= data.shakeCount
    local shakeType = data.shakeType   --震动类型
    local shakeStrength  = data.shakeStrength
    local shakeInching   = data.shakeInching
    local shakeSpeed     = data.shakeSpeed
    shakeType = shakeType or 1
    shakeCount= shakeCount or 2
    shakeSpeed = shakeSpeed or 50
    shakeSpeed = shakeSpeed*0.001
    shakeStrength  = shakeStrength or 10 --抖动时候是移动的像素 /缩放时是缩放比,取值范围 0 - 100
    local actions = {}
    local flag = 1
    if shakeType == eShakeType.MOVE then --
        local point1 = me.pMult(shakePoints[RandomGenerator._random(4)],shakeStrength)
        local sign   = RandomGenerator._randomSign()
        local point2 = me.p(point1.y*sign,point1.x*sign)
        local point3 = me.pAdd(point1,point2)
        point3 = me.pMult(point3,-1)
        -- print(point1,point2,point3)
        for i = 1, shakeCount do
            if shakeInching then
                flag = i
            end
            table.insert(actions, MoveBy:create(shakeSpeed, me.pMult(point1,1/flag)))
            table.insert(actions, MoveBy:create(shakeSpeed, me.pMult(point2,1/flag)))
            table.insert(actions, MoveBy:create(shakeSpeed, me.pMult(point3,1/flag)))
        end
    elseif shakeType == eShakeType.SCALE then --缩放
        local hero = battleController.getCaptain()
        local pos  = hero:getPosition3D()
        local size = screenWobbleNode:getSize()
        local anchorPoint = ccp(pos.x/size.width,pos.y/size.height)
        transAnchorPoint(screenWobbleNode,anchorPoint)
        local scale = shakeStrength/100
        for i = 1, shakeCount do
            if shakeInching then
                flag = i
            end
            table.insert(actions, ScaleTo:create(shakeSpeed*i, 1 + scale/flag))
            table.insert(actions, ScaleTo:create(shakeSpeed*i, 1.0))
        end
    end
    --抖屏回调
    if data.callFunc then
        table.insert(actions, CallFunc:create(data.callFunc))
    end
    screenWobbleNode:runAction(Sequence:create(actions))
end

function BattleView:onShowAwake(node)
    self.Panel_awake:removeAllChildren()
    self.Panel_awake:addChild(node)
    self.Panel_awake:show()
    self.Panel_awake:setTouchEnabled(true)
    self.Panel_combo:stopAllActions()
    self.Panel_combo:hide()

end
function BattleView:onHideAwake()
    self.Panel_awake:removeAllChildren()
    self.Panel_awake:hide()
    if self.Panel_combo:isVisible() then
        self.Panel_combo:stopAllActions()
        self.Panel_combo:timeOut(function()
                self.Panel_combo:hide()
        end,1)
    end
end


function BattleView:onCameraEvent(...)
    self.camera:runAction(...)
end

local function __scaleActionTo(node,max)
    max = max or 1.1
    node:stopAllActions()
    node:setScale(0.8)
    local args =
    {
        ScaleTo:create(0.06,max),
        ScaleTo:create(0.04,1)
    }
    node:runAction(Sequence:create(args))
end

local function __scaleActionToE(node,time,scale1,scale2)
    node:stopAllActions()
    node:setScale(scale1)

    local args =
    {
        ScaleTo:create(time*0.6,scale2),
        ScaleTo:create(time*0.4,1)
    }
    node:runAction(Sequence:create(args))
    -- node:runAction(ScaleTo:create(time,scale2))
end

function BattleView:onShowCombo(combo,action)
    self.Panel_combo:show()
    self.Panel_combo:stopAllActions()
    self.Panel_combo:timeOut(function()
        if not AwakeMgr.isPlay() then
            self.Panel_combo:hide()
        end
    end,BattleConfig.COMBO_TIME*0.001)

    self.labelBMFont_combo_num:setText(tostring(combo))
    __scaleActionToE(self.image_combo_bg[1],0.1,1.1,1.5)
    __scaleActionToE(self.image_combo_bg[2],0.1,1.05,1.4)
    __scaleActionTo(self.image_combo,1.5)
    __scaleActionTo(self.labelBMFont_combo_num,2)

    if self.passLevelCond_ == EC_LevelPassCond.COMBO_COUNT then
        self.Panel_passcond.maxComboNum = self.Panel_passcond.maxComboNum or 0
        if self.statistics_.maxComboNum > self.Panel_passcond.maxComboNum  then 
            self.Panel_passcond.maxComboNum  = self.statistics_.maxComboNum 
            self:showStarEffect()
        end
    end
end

function BattleView:onBattleStart(callback)
    local size = self.Panel_ui_effect_top:getSize()
    local skeletonNode = ResLoader.createEffect("battle_Start",1)
    skeletonNode:playByIndex(0,0)
    skeletonNode:setPosition(me.p(size.width/2,size.height/2))
    skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
        if callback then
            callback()
        end
    end)
    self.Panel_ui_effect_top:addChild(skeletonNode)
end

function BattleView:endAniCallback(callback)
    if self.battleType_ == EC_BattleType.TEAM_FIGHT then
        if callback then
            callback()
        end
    elseif self.battleType_ == EC_BattleType.COMMON then
        if callback then
            callback()
        end
        --self:commonFightResult()
    elseif self.battleType_ == EC_BattleType.ENDLESS then
        if callback then
            callback()
        end
        --self:endlessFightResult()
    end
end

function BattleView:onStaceClear(callback)
    if self.levelCfg_ and self.levelCfg_.isPlayVictorAction then  --是否展示胜利失败动画
        self.endAniFlag_ = true
        local size = self.Panel_ui_effect_top:getSize()
        local bWin = battleController.isWin()
        local skeletonNode
        if bWin then
            skeletonNode = ResLoader.createEffect("battle_end_win",1)
            Utils:playSound(403)
        else
            skeletonNode = ResLoader.createEffect("battle_end_defeated",1)
        end
        skeletonNode:play("animation", 0)
        skeletonNode:setPosition(me.p(size.width/2, size.height/2))
        skeletonNode:removeMEListener(TFARMATURE_COMPLETE)    
        skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)                                    
                self:endAniCallback(callback)
        end)
        self.battleEndSkeletonNode_ = skeletonNode
        self.Panel_ui_effect_top:addChild(skeletonNode)
    else
        self.endAniFlag_ = true
        self:endAniCallback(callback)
    end
end

function BattleView:onEndBattleEvent(dropReward, isWin)
    self.dropReward_ = dropReward
    self.endMsgFlag_ = true
    self.isWin_ = isWin
    self:commonFightResult()
end

function BattleView:normalFightResult()
    if self.endMsgFlag_ and self.endAniFlag_ then
        self.endMsgFlag_ = false
        self.endAniFlag_ = false

        local levelId = BattleDataMgr:getPointId()
        if self.isWin_ then
            if self.levelType_ == EC_FBLevelType.THEATER_BOSS then
                Utils:openView("battle.TheaterBossResultView")
            elseif self.levelType_ == EC_FBLevelType.KABALATREE or  self.levelType_ == EC_FBLevelType.DALMAP then
                local victoryCfg = self.victoryDecide_:getData()
                local isSurvivalHurt = false
                for i, v in ipairs(victoryCfg) do
                    if v.victoryType == EC_LevelPassCond.SURVIVAL_HURT then
                        isSurvivalHurt = true
                        break
                    end
                end
                if isSurvivalHurt then
                    Utils:openView("battle.TheaterBossResultView")
                else
                    Utils:openView("battle.BattleResultView")
                end
            elseif self.levelType_ == EC_FBLevelType.NIANBREAST then
                if tolua.isnull(self.dropReward_) then
                    self:showFuben()
                else
                    Utils:openView("battle.BattleResultView")
                end
            elseif self.levelType_ == EC_FBLevelType.TXJZ then
                Utils:openView("battle.TxjzResultView")
            else
                Utils:openView("battle.BattleResultView")
            end
        else
            self:showFuben()
        end
    end
end

--返回活动副本

function BattleView:showFuben()
    if battleController.isLockStep() then
        TeamFightDataMgr:reset()
    end
    GuideDataMgr:setPlotLvlBackState(true)
    if battleController.lastSceneName == "BaseOSDScene" then 
        local OSDControl = require("lua.logic.osd.OSDControl")
        OSDControl:enterOSD({})
    else
        AlertManager:changeScene(SceneType.MainScene)
    end
end

function BattleView:commonFightResult()
    if self.levelType_ == EC_FBLevelType.PRACTICE or
        self.levelType_ == EC_FBLevelType.NOOBSUMMON then
        self:showFuben()
    else
        self:normalFightResult()
    end
end

function BattleView:endlessFightResult()
    if self.endAniFlag_ and self.endMsgFlag_ then
        local isWin = battleController.isWin()
        if isWin then
            local endlessInfo = FubenDataMgr:getEndlessInfo()
            if endlessInfo.step == EC_EndlessState.ING then
                local endlessCloisterLevel = FubenDataMgr:getEndlessCloisterLevel(self.levelCfg_.week)
                local maxLevel = FubenDataMgr:getEndlessMaxLevel()
                local normalMaxLevel = FubenDataMgr:getEndlessNormalMaxLevel()
                if self.levelCfg_.order == normalMaxLevel then
                    self:showEndlessResult()
                else
                    if self.levelCfg_.order < #endlessCloisterLevel and self.levelCfg_.order < maxLevel then
                        if self.battleEndSkeletonNode_ then
                            self.battleEndSkeletonNode_:setVisible(false)
                        end
                        Utils:openView("battle.EndlessLevelResultView", self.dropReward_)
                    else
                        self:showEndlessResult()
                    end
                end
            else
                self:showEndlessResult()
            end
        else
            self:showEndlessResult()
        end
    end
end

function BattleView:showEndlessResult()
    if #self.statistics_.endlessPassLevel > 0 then
        Utils:openView("battle.BattleResultView")
    else
        self:showFuben()
    end
end

function BattleView:createEndlessGate()
    local airRect = battleController.getAirwall()
    local origin = airRect.origin
    local size = airRect.size
    local x = origin.x + size.width * 0.7
    local y = origin.y + size.height * 0.5
    local data = TabDataMgr:getData("MapBarrier", 1001)
    local gate = GameObject.createBaseProp(data)
    gate:setPosition(ccp(x, y))
    self.mapView:addObject2(gate)
    gate:setRepeatEnable(false)
    gate:setTriggerCallback(function()
            FubenDataMgr:send_ENDLESS_CLOISTER_REQ_START_FIGHT_ENDLESS()
    end)
end

function BattleView:onHitBlur(fuzzyTime,fuzzyLevel)
    -- fuzzyTime       = 2000
    -- fuzzyLevel      = 50
    if BattleConfig.SHADER_BLUR then
        self.fuzzyTime  = fuzzyTime
        self.fuzzyLevel = fuzzyLevel
        self.fuzzyDecay = self.fuzzyLevel/self.fuzzyTime
        self:applyShader(eShaderType.BLUR)
    end
end

function BattleView:onHitBlast(blastLevel)
    if  BattleConfig.SHADER_BLAST then
        self.blastLevel = blastLevel
        self:applyShader(eShaderType.BLAST)
    end
end

function BattleView:handleShader(dt)
    if BattleConfig.SHADER_BLUR or BattleConfig.SHADER_BLAST then
        self:initCameraSprite()
        if BattleConfig.SHADER_BLUR and self.cameraSprite.shaderType == eShaderType.BLUR then  --是否开启模糊效果

            if self.fuzzyTime > 0 then
                -- print("xxxxxxx"..self.fuzzyTime , self.fuzzyTime*self.fuzzyDecay)
                self.captureSprite = true

                local _GLProgramState = self.cameraSprite:getGLProgramState()
                _GLProgramState:setUniformInt("flagBlur", 1)

                _GLProgramState:setUniformFloat("f_mlen", self.fuzzyTime*self.fuzzyDecay)
                local point = self.camera:getRoleAnchorPoint()
                _GLProgramState:setUniformVec2("v_center", point)

                self.fuzzyTime = self.fuzzyTime - dt
            else
                if self.captureSprite then
                    self.captureSprite = nil
                    --模糊效果关闭
                    local _GLProgramState = self.cameraSprite:getGLProgramState()
                    _GLProgramState:setUniformInt("flagBlur", 0)
                end
            end
        end
    end
end

--创建特效纹理
function BattleView:initCameraSprite()
    if not self.cameraSprite then
        --shader要用的文理
        self.noiseSprite = Sprite:create("ui/battle/noise.jpg")
        self.Panel_prefabs:addChild(self.noiseSprite)
        ---
        self.cameraSprite  = Sprite:createWithTexture(self.camera.camera1Texture)
        BattleMgr.bindActionMgr(self.cameraSprite)
        self.cameraSprite:setCameraMask(eCameraFlag.CF_EFFECT_BLAST)
        self.Panel_fight:addChild(self.cameraSprite)
        self.cameraSprite:setFlipY(true)
        self.cameraSprite:setAnchorPoint(me.p(0.5,0.5))
        local size = self.Panel_fight:getSize()
        self.cameraSprite.defaultPos = me.p(size.width/2,size.height/2)
        self.cameraSprite:setPosition(self.cameraSprite.defaultPos)
        --解决气浪安卓不能显示的问题
        local cameraSpriteBlast = Sprite:createWithTexture(self.camera.camera3Texture)
        BattleMgr.bindActionMgr(cameraSpriteBlast)
        cameraSpriteBlast:setFlipY(true)
        cameraSpriteBlast:setAnchorPoint(me.p(0.5,0.5))
        cameraSpriteBlast:setPosition(self.cameraSprite.defaultPos)
        self.Panel_fight:addChild(cameraSpriteBlast,9999)
    end
end


function BattleView:applyShader(shaderType)
    local obj = self.cameraSprite
    if obj and obj.shaderType ~= shaderType then
        if shaderType == eShaderType.BLUR then
            obj:setShaderProgram("DalMotionblur")
            local size = self.cameraSprite:getSize()
            local _GLProgramState = self.cameraSprite:getGLProgramState()
            _GLProgramState:setUniformFloat("f_ins", 1/size.width)
        elseif shaderType == eShaderType.BLAST then         -- 气浪
            -- local DalBlast = me.ShaderCache:getGLProgram("DalBlast")
            -- local _GLProgramState = GLProgramState:getOrCreateWithGLProgram(DalBlast)
            -- obj:setGLProgramState(_GLProgramState)
            obj:setShaderProgram("DalBlast")
            local _GLProgramState = obj:getGLProgramState()
            _GLProgramState:setUniformTexture("maskTex",  self.camera.camera2Texture)
            _GLProgramState:setUniformTexture("noiseTex", self.noiseSprite:getTexture())
            _GLProgramState:setUniformInt("flag", 1)
            _GLProgramState:setUniformFloat("GlowRange", self.blastLevel)
            _GLProgramState:setUniformVec2("TextureSize", ccp(1/me.winSize.width, 1/me.winSize.height))
        else
            obj:setShaderProgramDefault(true)
        end
        obj.shaderType = shaderType
    end
end

function BattleView:getObjectPoint(object)
        local dsSize       = me.size(me.EGLView:getDesignResolutionSize())
        local zeye         = me.Director:getZEye()
        local cameraPos    = self.camera:getPosition3D()
        local pos          = object:getPosition()
        local scale        = cameraPos.z / zeye
        local offectPos = me.p(pos.x - cameraPos.x  ,  pos.y - cameraPos.y )
        offectPos.x = (offectPos.x/scale +dsSize.width/2)
        offectPos.y = (offectPos.y/scale +dsSize.height/2)
        return offectPos
end


function BattleView:getWidget(widget)
    if widget == "image_roke" then
        self.keyBoard:getWidget(widget).xxxx = true
        return self.keyBoard:getWidget(widget)
    elseif widget == "skillA" then
        return self.keyBoard:getWidget(widget)
    elseif widget == "skillB" then
         return self.keyBoard:getWidget(widget)
    elseif widget == "skillC" then
        return self.keyBoard:getWidget(widget)
    elseif widget == "skillD" then
        return self.keyBoard:getWidget(widget)
    elseif widget == "playInfo" then
        self.plyerNode.xxxx = true
        return self.plyerNode --.loadingBar_hp --self.plyerNode
    elseif widget == "luzhang" then
        -- return self.plyerNode
        local list = obstacleMgr:getObjects()
        local object = nil
        for i = #list , 1 , -1 do
            if not object then
                object = list[i]
            else
                if list[i]:getPositionX() < object:getPositionX()  then
                    object = list[i]
                end
            end
        end
        -- return object
        if object then
            local pos  = self:getObjectPoint(object)
            local node = CCNode:create()
            pos.x = pos.x - 40
            node:setPosition(pos)
            node:setSize(me.size(100,150))
            node.xxxxx = true
            return node
        end
    end
end

function BattleView:onEndlessPassEvent(dropReward)
    self.endMsgFlag_ = true
    self.dropReward_ = dropReward
    local isWin = battleController.isWin()
    if isWin then
        self.statistics_.endlessPassEvent(self.levelCid_, dropReward)
    end
    self:endlessFightResult()
end

function BattleView:test()
    local effect = "effects_10101_skillC"
    local action = "skillC1_"
    local effectNode = ResLoader.createEffect(effect)
    effectNode:play(action..2,1)
    effectNode:addMEListener(TFARMATURE_EVENT,function (...)
        local event = BattleUtils.translateArmtureEventData(...)
        if event.name == "hurt" then
            local rect = effectNode:getBoundingBox2("bdbox_eff")
            print("event name:",event.name,rect)
        end
    end)
    effectNode:setPosition(ccp(200,200))
    effectNode:setCameraMask(self.Panel_ui_effect_bottom:getCameraMask())
    self.Panel_ui_effect_bottom:addChild(effectNode)
end

---------------------------组队战斗---------
--主队模式下显示自己的头像
function BattleView:showHead()
    -- local panel_role = self.plyerNode.panel_role
    -- panel_role:show()
    -- TFDirector:getChildByPath(panel_role, "LoadingBar_progress"):hide()
    -- TFDirector:getChildByPath(panel_role, "Image_select"):show()
    -- TFDirector:getChildByPath(panel_role, "Image_gray"):hide()
    -- TFDirector:getChildByPath(panel_role, "Image_dead"):hide()
    -- local image_head  = TFDirector:getChildByPath(panel_role, "Image_head"):show()
    -- -- local hero = battleController.getPlayer(MainPlayer:getPlayerId())
    -- -- image_head:setTexture(hero:getData().fightIcon)
    -- local heros = battleController.getHeroData()
    -- for i, heroData in ipairs(heros) do
    --     if MainPlayer:getPlayerId() == heroData.pid then
    --         image_head:setTexture(heroData.heroIcon)
    --     end
    -- end
end
--[[
1 招呼   effect_teamNew_05   effect_teamNew_09
2 点赞   effect_teamNew_07   effect_teamNew_11
3 攻击   effect_teamNew_04   effect_teamNew_08
4 复活   effect_teamNew_06   effect_teamNew_10

]]



function BattleView:showFaceMe(chatMsg) 
    if self.keyBoard.Spine_face then   
        self:showTeamDialog(self.keyBoard.Spine_face,chatMsg,2)
    end
end

local faces_anmations = 
{
    ["face1"] = {"effect_teamNew_05" ,  "effect_teamNew_09"},
    ["face2"] = {"effect_teamNew_07" ,  "effect_teamNew_11"},
    ["face3"] = {"effect_teamNew_04" ,  "effect_teamNew_08"},
    ["face4"] = {"effect_teamNew_06" ,  "effect_teamNew_10"}
}
function BattleView:showTeamDialog(chatNode,chatMsg,dir)
    -- dump({"chatMsg",chatMsg})
    dir = dir or 1
    if faces_anmations[chatMsg] == nil then return end
    if faces_anmations[chatMsg][dir] == nil then return end
    local anmiation = faces_anmations[chatMsg][dir]
    chatNode:play(anmiation,0)
    chatNode:stopAllActions()
    chatNode:setVisible(true)
    chatNode:setOpacity(0)
    local actionList = {FadeIn:create(0.3),DelayTime:create(2),FadeOut:create(0.3),CallFunc:create(function( ... )
        chatNode:setVisible(false)
    end)}
    chatNode:runAction(Sequence:create(actionList))

end

function BattleView:onRecvChatMsg(chatInfo)
    if not chatInfo then
        return
    end
    if chatInfo.channel ~= 5 or chatInfo.fun ~= 1 or self.teamMemberNum == nil then
        return
    end
    if self.teamMemberNum < 2 then
        return
    end

    if self.team_switch_btn.page_idx ~= 0 then
        return
    end
    if chatInfo.pid == MainPlayer:getPlayerId() then
        return
    end
    local items = self.team_left_list:getItems()
    for k,v in pairs(items) do
        if v.pid == chatInfo.pid then
            self:showTeamDialog(v:getChildByName("Spine_face"),chatInfo.content)
            return
        end
    end
end

function BattleView:updateTeamTalk()
    local team_talk_panel = self.Panel_top:getChildByName("Panel_team_talk")
    team_talk_panel:setVisible(true)

    -- self.teamMemberNum  一个人也显示 聊天按钮
    self.keyBoard:showButtonChat(function(selectIndex)
        if selectIndex  then
            local content = "face"..tostring(selectIndex)
            local msg = {5,1,content}
            TFDirector:send(c2s.CHAT_CHAT,msg)
            self:showFaceMe(content)
        end
    end)

    --小地图
    self.panelMiniMap = team_talk_panel:getChildByName("Panel_miniMap")
    self.panelMiniMap.image_focus = TFDirector:getChildByPath(self.panelMiniMap, "Image_focus")
    self.panelMiniMap.image_last  = TFDirector:getChildByPath(self.panelMiniMap, "Image_last")
    self.btn_check    = team_talk_panel:getChildByName("Button_check")
    if battleController.isLockStepEx() then 
        self.panelMiniMap:show()
        self.panelMiniMap.nodes = {}
        for index = 1 , 24 do
            local node       = TFDirector:getChildByPath(self.panelMiniMap, "Image_node-Copy"..index)
            node.image_state = node:getChildByName("Image_state")
            self.panelMiniMap.nodes[index] = node
        end
        self.panelMiniMap.lineNodes = {}
        for index = 1 , 23 do
            local key = "Image_line"..index.."_"..(index+1)
            local node  = TFDirector:getChildByPath(self.panelMiniMap, key)
            if node then
                self.panelMiniMap.lineNodes[key] = node
            end 
        end
        for index = 1 , 18 do
            local key = "Image_line"..index.."_"..(index+6)
            local node  = TFDirector:getChildByPath(self.panelMiniMap, key)
            if node then
                self.panelMiniMap.lineNodes[key] = node
            end 
        end
        self.btn_check:hide()
        -- self.btn_check:onClick(function()
        --     Box("show check")
        -- end)
        self:refreshMiniMap()
    else
        self.btn_check:hide()
        self.panelMiniMap:hide()
    end

end
--刷新小地图
function BattleView:refreshMiniMap()
-- this.data.dungeonNodes[this.data.dungeonIndex]
    if battleController.isLockStepEx() then 
        -- self.btn_check:show()
        local data = battleController.getBattleData()
        local curIndex = data.dungeonIndex
        if data.dungeonNodes then  
            self.panelMiniMap:show()
            for index, node in ipairs(self.panelMiniMap.nodes) do
                local nodeData = data.dungeonNodes[index]
                if nodeData then
                    node.image_state:setVisible(nodeData.pass)  
                    -- node:show()
                    --小地图显示规则调整
                    if nodeData.pass or curIndex == index then 
                        node:show()
                    else
                        node:hide()
                        for i , v in ipairs(nodeData.next) do
                            if v > 0 then 
                                if v == curIndex then 
                                    node:show()
                                else    
                                    if data.dungeonNodes[v].pass then 
                                        node:show()
                                    end
                                end
                            end
                        end
                    end
                    --最终关卡显示
                    if nodeData.last then 
                        self.panelMiniMap.image_last:setPosition(node:getPosition())
                        self.panelMiniMap.image_last:setVisible(node:isVisible())
                    end
                else
                    node:hide()
                end
            end
            --当前所在节点
            local nodeData = data.dungeonNodes[data.dungeonIndex]
            local node     = self.panelMiniMap.nodes[nodeData.index]
            self.panelMiniMap.image_focus:setPosition(node:getPosition())

            for k, node in pairs(self.panelMiniMap.lineNodes) do
                node:hide()
            end
            --
            for k , nodeData in pairs(data.dungeonNodes) do
                if self.panelMiniMap.nodes[k]:isVisible() then 
                    for i , v in ipairs(nodeData.next) do
                        if v > 0 then
                            if self.panelMiniMap.nodes[v]:isVisible() then  
                                if k < v then 
                                    local key = "Image_line"..k.."_"..v
                                    self.panelMiniMap.lineNodes[key]:show()
                                end
                            end
                        end
                    end
                end
            end

        else
            self.panelMiniMap:hide()
        end
    else
        self.panelMiniMap:hide()
        self.btn_check:hide()
    end

end


function BattleView:initTeamLeftPad()
    local heros = battleController.getHeroData()
    self.teamMemberNum = #heros
    self:updateTeamTalk()
    self.team_rank_panel = self.Panel_top:getChildByName("Panel_team_rank")
    self.team_rank_panel:setVisible(true)
    local scroll_view = self.Panel_top:getChildByName("ScrollView_roles")
    scroll_view:show()
    self.team_left_list = UIListView:create(scroll_view)

    self.team_switch_btn = self.team_rank_panel:getChildByName("Button_switch")
    self.team_switch_btn.page_idx = 0
    if self.teamMemberNum == 1 then
        self.team_switch_btn.page_idx = 1
        self.team_switch_btn:hide()
    else
        self.team_switch_btn:show()
    end
    self.team_switch_btn:onClick(function()
        if self.teamMemberNum== 1 then
            self.team_switch_btn:hide()
            return
        end
        self:switchTeamPadPage(self.team_switch_btn.page_idx + 1)
    end)
    self.team_list_refresh_enable = true
    self.team_rank_panel:setVisible(true)
    self:switchTeamPadPage(self.team_switch_btn.page_idx)
end

function BattleView:switchTeamPadPage(idx)
    self.team_list_refresh_enable = false
    self.team_switch_btn.page_idx = idx%2
    self.team_left_list:removeAllItems()
    local model_menu = {
        [0] = {item_model = self.team_role_prefabs,cellH = 70,swichImg = "ui/onlineteam/005.png"},
        [1] = {item_model = self.team_attack_model,cellH = 65,swichImg = "ui/onlineteam/006.png"}
    }
    local cellHeight = model_menu[self.team_switch_btn.page_idx].cellH
    local listView_height = cellHeight*self.teamMemberNum
    self.team_left_list:setContentSize(me.size(320,listView_height))
    self.team_switch_btn:setTextureNormal(model_menu[self.team_switch_btn.page_idx].swichImg)
    -- self.team_switch_btn:setPosition(me.p(81,-(65*self.teamMemberNum +12 )))
    for i=1,self.teamMemberNum do
        local isCanAdd = true
        if self.team_switch_btn.page_idx == 0 then
            if i == self.teamMemberNum then
                isCanAdd = false
            end
        end
        if isCanAdd == true then
            local item = model_menu[self.team_switch_btn.page_idx].item_model:clone()
            item:setVisible(true)
            item:setPosition(ccp(0,0))
            self.team_left_list:pushBackCustomItem(item)
        end
    end
    self.team_list_refresh_enable = true
    self:updateTeamPad()
end

function BattleView:updateTeamPad()
    if not battleController.isLockStep() then
        return
    end
    local heros = battleController.getTeamMembers() -- getSimpleHeros() --battleController:getBench()
    if self.teamMemberNum and #heros ~= self.teamMemberNum then
        self.teamMemberNum = #heros
        self:updateTeamTalk()
        self:switchTeamPadPage(self.team_switch_btn.page_idx)
        return
    end
    local curHeroInfo = {}
    for k,v in ipairs(heros) do
        if self.team_switch_btn.page_idx == 0 then
            if v:getData().pid ~= MainPlayer:getPlayerId() then
                curHeroInfo[#curHeroInfo + 1] = v
            end
        else
            curHeroInfo[#curHeroInfo + 1] = v
        end

    end
    if #curHeroInfo > 1 then
        table.sort( curHeroInfo, function(a,b)
            return a:getData().hurtValue > b:getData().hurtValue
        end)
    end
    for i = 1,#curHeroInfo do
        self:updateTeamItem(curHeroInfo[i],i)
    end
end

function BattleView:updateTeamItem(itemInfo,idx)
    if self.team_list_refresh_enable == true then
        local item = self.team_left_list:getItem(idx)
        if self.team_switch_btn.page_idx == 0 then
            self:updateTeamItemA(item,itemInfo)
        else
            self:updateTeamItemB(item,itemInfo,idx)
        end
    end
end

function BattleView:updateTeamItemA(item,itemInfo)
    item.pid = itemInfo:getData().pid
    local image_head = TFDirector:getChildByPath(item,"Image_head")

    local resPath    = itemInfo:getData().fightIcon
    if  image_head._resPath ~= resPath then
        image_head:setTexture(resPath)
        image_head._resPath = resPath
    end

    TFDirector:getChildByPath(item,"LoadingBar_hp"):setPercent(itemInfo:getHpPercent()*0.01)
    -- item:getChildByName("LoadingBar_np"):setPercent(itemInfo:getAngerPercent()*0.01)
    -- item:getChildByName("LoadingBar_progress"):setTexture(itemInfo:getData().fightIcon)
    -- item:getChildByName("LoadingBar_progress"):setPercent(itemInfo:getProgress())
    local dead_img = TFDirector:getChildByPath(item,"Image_dead")
    local isDead = itemInfo:isDead()
    dead_img:setVisible(isDead)
    image_head:setGrayEnabled(isDead)
    local signal_bar = TFDirector:getChildByPath(item,"LoadingBar_signal")
    local signal_txt = TFDirector:getChildByPath(item,"Label_signal")

    local ping = LockStep.getNetDelayTime(itemInfo:getData().pid)
    signal_txt:setString(tostring(math.floor(ping)))
    for i,v in ipairs(sinalQuality) do
        if ping > v.ping then
            signal_bar:setPercent(v.percent)
            signal_txt:setColor(v.color)
            break
        end
    end
end

function BattleView:updateTeamItemB(item,itemInfo,idx)
    item:getChildByName("Label_member_name"):setString(tostring(itemInfo:getData().pname))
    item:getChildByName("Label_member_idx"):setString("NO."..idx)
    item:getChildByName("Label_member_attack"):setString(tostring(itemInfo:getData().hurtValue))
end

function BattleView:updatePracticeHurtInfo()
    local practiceTime = self.statistics_.practiceTime
    local timestamp = math.floor(practiceTime / 1000)
    local msec = string.format("%02d", practiceTime % 1000 * 0.1)
    local _, hour, min, sec = Utils:getDHMS(timestamp)
    min = hour * 60 + min
    min = string.format("%02d", min)
    sec = string.format("%02d", sec)
    self.Label_hurt_timimg:setTextById(800056, min, sec ,msec)

    local practiceHurt = self.statistics_.hitValue
    local averagePracticeHurt = 0
    if timestamp > 0 then
        averagePracticeHurt = practiceHurt / timestamp
    end
    if practiceHurt < 100000 then
        self.Label_hurt:setTextById(2107034, practiceHurt, averagePracticeHurt)
    else
        if averagePracticeHurt < 100000 then
            self.Label_hurt:setTextById(2107035, practiceHurt / 10000, averagePracticeHurt)
        else
            self.Label_hurt:setTextById(2107036, practiceHurt / 10000, averagePracticeHurt / 10000)
        end
    end
end

function BattleView:onEndlessContinueEvent()
    local hero = battleController.getCaptain()
    hero:cancelToStand()
    KeyStateMgr.setEnable(true)

    local propMgr = BattleMgr.getPropMgr()
    local objects = propMgr:getObjects()
    -- print_("objects size:",#objects)
    for index = #objects , 1 , -1 do
        local prop = objects[index]
        prop:removeFromParent()
    end
    propMgr:clear()

    local function completeCallback()
        local endlessInfo = FubenDataMgr:getEndlessInfo()
        if endlessInfo.step == EC_EndlessState.ING then
            FubenDataMgr:send_ENDLESS_CLOISTER_REQ_START_FIGHT_ENDLESS()
        else
            self:showEndlessResult()
        end
    end

    local view = requireNew("lua.logic.battle.EndlessCountdownView"):new(completeCallback)
    AlertManager:addLayer(view, AlertManager.NONE)
    AlertManager:show()
end

function BattleView:onPracticeBrushEvent(selectIndex)
    self.practiceSelectIndex_ = selectIndex
end

function BattleView:onBattleEvtTips(cfg)
    self.keyBoard.guide_panel:setVisible(true)
    local img_guide_tip = self.keyBoard.guide_panel:getChildByName("Image_guide_bg")
    img_guide_tip:stopAllActions()
    img_guide_tip:getChildByName("Label_guide_tip"):setTextById(cfg.strid)
    local labelsize = img_guide_tip:getChildByName("Label_guide_tip"):getContentSize()
    local labelpos = img_guide_tip:getChildByName("Label_guide_tip"):getPosition()
    local img_tip_width = labelpos.x + labelsize.width + 20
    local cur_img_tip_size = img_guide_tip:getContentSize()
    local cur_img_tip_pos = img_guide_tip:getPosition()
    cur_img_tip_size.width = img_tip_width
    img_guide_tip:setContentSize(cur_img_tip_size)
    img_guide_tip:setPosition(me.p(693-img_tip_width/2,cur_img_tip_pos.y))
    img_guide_tip:setVisible(true)
    local actionArr = {DelayTime:create(cfg.duration/1000),CallFunc:create(function()
        self.keyBoard.guide_panel:setVisible(false)
        img_guide_tip:setVisible(false)
    end)}
    img_guide_tip:runAction(Sequence:create(actionArr))
end

function BattleView:specialKeyBackLogic( )
    GuideDataMgr:setPlotLvlBackState(true)
    return false
end

return BattleView
