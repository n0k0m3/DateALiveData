
local enum = {}

--存储Hero 里各种 bool 变量的标识
enum.eFlag = 
{
    FirstUpdate   = 1, --首次update
    Dead          = 2, --死亡
    EndOfBattle   = 3, --战斗结束
    PlayedEndAction = 4, --播放战斗结束动画完成
    PlotMode = 5, --剧情模式
    FALL     = 6, --倒地(ST_FALL 包含倒地动作和倒地)
    DEAD_Statistics = 7, --死亡统计
    ------木桩-------
    HP_AUTO_RECOVERY = 8,  --死亡前自动回血
    SUPER_SKILL      = 9,  --技能无CD无消耗
    HITED      = 10,  --记录命中状态 满足峰哥怪物命中切换动作的需求
}

--阵营分类
--1固定为我方角色
--2到5为怪物
-->6为陷阱
enum.eCampType =
{
    Hero      = 1,  --绑定角色使用  1
    Monster   = 2,  --怪物          2 - 5
    Other     = 3,  --其他          6 - 10
    Call      = 4,  --召唤怪        11 -20
}


--组队战斗类型
enum.eTeamType =
{
    Team      = 1,  --普通组队
    CJTX      = 2,  --春季特训
    DSJ       = 3,  --大世界
    ZML       = 4,  --招募令
    ZLJH      = 5,  --追猎计划(世界Boss)
    BOSS      = 8,  --BOSS挑战
}




--摄像机模式
enum.eMode =
{
    FOLLOW  = 1, --跟随模式
    MANUAL  = 2,  --指定位置
    FOLLOW_NODE = 3,  --跟随指定节点
}

--角色颜色类型[值也用作显示优先级]
enum.eColorType = 
{
    Default            = 1 , --默认颜色
    Frozen             = 2 , --冰冻效果 
    FloatingProtection = 3 , --浮空保护
    Hit                = 4 , --受击
}

--(1角色，2助战伙伴，3所有怪物(包含Boss)，4特指Boss，5普通怪物，6精英怪物
--关卡目标类型 TODO 1 3 生效
enum.ePointTargetType =
{
    Hero           = 1, --角色
    Hero_Assit     = 2, --助战角色
    Monster_All    = 3, --所有怪
    Boss           = 4, --特定boss
    Monster_Noraml = 5, --普通怪物
    Monster_Elite  = 6, --精英怪物
}

--震屏类型
enum.eShakeType=
{
    MOVE  = 1, --三角抖动
    SCALE = 2, --缩放
}
-- 英雄状态
enum.eState ={
	ST_BORN   = 1 ,
	ST_STAND  = 2 ,
	ST_MOVE   = 3,
	ST_SKILL  = 4,
	ST_HIT    = 8,
	ST_FLOAT  = 10,
	ST_FALL   = 11,
	ST_STANDUP  = 12,
	ST_QUICKMOVE  = 14,  --快速移动
	ST_DIE    = 15, --死亡
	ST_VERTIGO  =16 , --眩晕
	ST_MOVEEX = 17 , --手动移动
    -- ST_ENTRANCE   = 18 , --进场
    ST_DEPARTURE  = 19, --退场
    ST_RELIVE  = 20, --复活
    ST_FROZEN  = 21, --冻结
    ST_WIN     = 22, --胜利状态
    ST_GRASP   = 23, --(被)抓取
    ST_PARALYSIS   = 24, --麻痹
}

enum.eStateEvent ={
	BH_BORN   = "ST_BORN" ,
	BH_STAND  = "ST_STAND" ,
	BH_MOVE   = "ST_MOVE", --自动移动

	BH_SKILL  = "ST_SKILL",
	BH_HIT    = "ST_HIT",
	BH_FLOAT  = "ST_FLOAT",
	BH_FALL   = "ST_FALL",
	BH_STANDUP    = "ST_STANDUP",
	BH_QUICKMOVE  = "ST_SPEED",  --快速移动
	BH_DIE        = "ST_DIE",    --
	BH_VERTIGO    = "ST_VERTIGO" , --眩晕
	BH_MOVEEX     = "ST_MOVEEX", --手动移动
    -- BH_ENTRANCE   = "ST_ENTRANCE" , --进场
    BH_DEPARTURE  = "ST_DEPARTURE", --退场
    BH_RELIVE     = "ST_RELIVE", --复活
    BH_FROZEN     = "ST_FROZEN", --冻结
    BH_WIN        = "ST_WIN", --获胜
    BH_GRASP      = "ST_GRASP", --(被)抓取
    BH_PARALYSIS  = "ST_PARALYSIS", --麻痹
}

--角色动作
-- [u'move', u'die1', u'floor', u'die2', u'float', u'hurt', u'born', u'quickmove',
--u'stand', u'fall', u'skillC',u'skillA', u'standup', u'skillD']
enum.eAnimation =
{
	BORN      = "born",
    DEPARTURE = "departure", --退场动作：departure
	DIE       = "die1",  --死亡
	VERTIGO   = "die2",  --眩晕
    ENTRANCE  = "entrance", --入场动作：entrance
    FLOATHURT = "floathurt",
    FLOAT     = "float",
    FLOOR     = "floor",
    HURT1     = "hurt1",  --受击动画1
    HURT2     = "hurt2",  --受击动画2
    MOVE      = "move",  --向前移动
    WALK      = "walk",    --向前移动
    RETREAT   = "retreat", --后退移动
    QUICKMOVE = "quickmove",
    STAND     = "stand",
    STANDUP   = "standup",
    RELIVE    = "floorRelive", --躺地复活
    KNEEL_RELIVE    = "kneelRelive", --瘫痪复活(TODO 暂未做处理)
    WIN       = "win" ,--胜利动作 
    FROZEN    = "hurt3", --冻结 frozen TODO 需要修改
    GRASP     = "floor"--"grasp" --抓取

}

enum.eFlightState = {
    ST_BORN     = 1,
    ST_DEBUT    = 2,
    ST_STAND    = 3,
    ST_FORWARD  = 4,
    ST_BACKWARD = 5,
    ST_MOVE     = 6,
    ST_HIT      = 7,
    ST_SKILL    = 8,
    ST_OFFSTAGE = 9,
    ST_DIE      = 10,
    ST_FALL     = 11,
    ST_WIN      = 12,
}

enum.eFlightStateEvent = {
    BH_BORN     = "ST_BORN",
    BH_DEBUT    = "BH_DEBUT",
    BH_STAND    = "ST_STAND",
    BH_FORWARD  = "ST_FORWARD",
    BH_BACKWARD = "ST_BACKWARD",

    BH_MOVE     = "ST_MOVE",

    BH_SKILL    = "ST_SKILL",
    BH_HIT      = "ST_HIT",
    BH_OFFSTAGE = "ST_OFFSTAGE",
    BH_DIE      = "ST_DIE",
    BH_FALL     = "ST_FALL",
    BH_WIN      = "ST_WIN",
}

enum.eFlightAnimation  = {
    BORN             = "born",
    DEBUT            = "born",
    STAND            = "stand",
    FORWARD          = "forward",
    BACKWARD         = "backward",
    FORWARD2BACKWARD = "forward2backward", -- 前进过度到后退
    BACKWARD2FORWARD = "backward2forward", --后退过度到前进
    SKILL            = "skill",
    MOVE             = "move",
    DIE              = "die", --死亡
    FALL             = "fall", --下坠
}

enum.eMapMoveDirection = {
    NONE = 0,
    LEFT = 1,
    RIGHT = 2,
    BOTTOM = 3,
    TOP = 4
}

enum.eFlightItemDropType = {
    PLAYER_BARRAGE_UP  = 1, --1-精灵弹幕提升道具
    WINGMAN_BARRAGE_UP = 2, --2-僚机弹幕提升/形态切换道具，
    ANGER_RECOVER      = 3, --3-怒气点恢复道具
}
-- --关卡胜利条件
-- enum.eVictoryType =
-- {
--     VT_DESTORY   =  1 , --歼灭
--     VT_LIVE      =  2 , --生存
--     VT_TIME      =  3 , --限时
--     VT_KILL_OBJ  =  4 , --目标击杀-具体怪物
--     VT_KILL_TYPE =  5 , --目标击杀-怪物类型
--     VT_KILL_NUM  =  6 , --目标击杀-怪物数量
-- }

enum.eHurtType =
{
    DODGE  = 0, --闪避
    PUGONG = 1, --普通攻击
    PARRY  = 2, --格挡
    CRIT   = 3, --暴击
    PREICE = 4, --穿透
    SKILL  = 5, --技能攻击


    DODGE1 = 8, --用来显示我方闪避

    RUO_DIAN  = 9, --弱点伤害类型(展示用)

    CRIT_PREICE= 10--穿透和暴击并存

}

--特效挂点类型
enum.eHostType =
{
    HERO   = 0, --英雄
    MAP    = 1, --地图
}
--技能伤害类型
enum.eDamageType =
{
    PT    = 1, --（普攻）
    FZ    = 2, --（分支）  技能一
    XL    = 3, --（蓄力）  技能二
    CCJ   = 4, --（出场技）
    -- QTE   = 5, --（QTE技）
    DZ    = 6, --（大招）
    JX    = 7, --（觉醒）
    -- BD    = 8, --（被动技能）
    -- SB    = 9, --（闪避技能）

    EXTRA_SKILL_1 = 10,
    EXTRA_SKILL_2 = 11,
    EXTRA_SKILL_3 = 12,
    EXTRA_SKILL_4 = 13,
    EXTRA_SKILL_5 = 14


}

--技能伤害属性
enum.eDamageAttr =
{
    PYHSIC  = 1 ,  --物理伤害加
    FROZEN  = 2 ,  --冰冻伤害加
    FLAME   = 3 ,  --燃烧伤害加
    BLAST   = 4 ,  --疾风伤害加
    THUNDER = 5 ,  --雷电伤害加
    POISON  = 6 ,  --毒素伤害加
    LIGHT   = 7 ,  --光属性伤害加
    DARK    = 8 ,  --暗属性伤害加
    MIND    = 9 ,  --精神属性伤害加
    SPACE   = 10,  --空间伤害加成
}

--buffer二级属性
enum.eDamageAttr2 =
{
    FIRE  = 1 , --燃烧伤害
    BLOOD = 2 , --流血伤害
    WIND  = 3 , --狂风伤害
}

--生物类型（0.人类1.生物 2.机械 3.灵体）
enum.eBodyType =
{
    HUMAN     = 0, --人类
    BIOLOGY   = 1, --生物
    MACHINERY = 2, --机械
    SPIRIT    = 3, --灵体
}

--怪物类型
enum.eMonsterType =
{
    MT_UNKNOW   = 0 , --未知
    MT_NORMAL   = 1 , --普通
    MT_ELITE    = 2 , --精英怪
    MT_BOSS     = 3 , --boss
    MT_GUARD    = 4 , --守护怪
    MT_TRAP     = 5 , --陷阱
}
--buffer可被清楚特殊标识
enum.eSpecialType =
{
    ST_BLOOD = 1 , --血爆
    ST_WIND  = 2 , --狂风
}

local eAttrType = {
-- 生命(最大生命)
ATTR_MAX_HP = 1,
-- 攻击
ATTR_ATK = 2,
-- 防御
ATTR_DEF = 3,
-- 增伤
ATTR_DMADD = 4,
-- 减伤
ATTR_DMSUB = 5,
-- 攻速
ATTR_SPD = 6,
-- 护盾
ATTR_SLD = 7,
-- Max怒气
ATTR_MAX_AGR = 8,
-- 怒气恢复值
ATTR_RECOVER_AGR = 9,
-- 负重
ATTR_COST = 10,
-- 移动速度
ATTR_MOVE_SPEED = 11,
--破防
ATTR_SAB  = 12,
--服务器占用字段
ATTR_XXOO  = 13,  --被无情占用不知道干啥的
--非强制消耗能量值
ATTR_MAX_ENERGY = 14,
--最大抵挡值
ATTR_MAX_RST   = 15,
--最大撕裂值
ATTR_MAX_TEAR  = 18,

ATTR_SPD_NORMAL  = 20, --普攻击速度

-- 战斗用属性（需服务器记录）
ATTR_NOW_AGR = 51 ,              -- 当前怒气值
ATTR_NOW_HP      = 52 ,              -- 当前生命值
ATTR_NOW_SLD = 53 ,              -- 当前护盾值  完全吸收
ATTR_NOW_RST = 54 ,              -- 当前抵挡值  百分比吸收 resist

ATTR_NOW_ENERGY         = 56,    --非强制消耗能量(释放技能使用)
ATTR_NOW_TEAR           = 57,    --当前撕裂值
ATTR_CHILL              = 59,    --冰寒额外伤害点
ATTR_NOW_HURT_STIFF     = 60,    --僵直(影响动画的播放速度)
ATTR_DESPAIR      = 61, --绝望点(反折使用)
ATTR_MAX_DESPAIR  = 62, --绝望点上限(反折使用)
ATTR_SUPER_ENERGY = 63, --特殊能量
ATTR_SUPER_ENERGY_LEVEL = 64, --能量消耗档位

----------------------

-- 固定百分比属性（累加显示百分比）
-- 客户端显示百分比/10000
ATTR_DMADD_PER = 501 ,             -- 增伤率
ATTR_DMSUB_PER  = 502 ,             -- 减伤率

ATTR_PREICE_PER   = 503 ,             -- 穿透率
ATTR_PARRY_PER    = 504 ,             -- 格挡率

ATTR_HIT_PER    = 505 ,             -- 命中率
ATTR_DODGE_PER  = 506 ,             -- 闪避率
ATTR_CRIT_PER   = 507 ,             -- 暴击率 (通用)
ATTR_UNCRIT_PER = 508 ,             -- 抗暴率
ATTR_HADD_PER   = 509 ,             -- 暴击伤害率
ATTR_HSUB_PER   = 510 ,             -- 暴击减伤率
ATTR_CTRL_PER   = 511 ,             -- 控制时间加成 （通用）
ATTR_UNCTRL_PER = 512 ,             -- 受控时间减免 （通用）
ATTR_BUFF_PER   = 513 ,             -- 增益时间加成
ATTR_DEBUFF_PER = 514 ,             -- 减益时间减免
ATTR_TREATMENT_RATE = 515,          -- 被治疗率(玩家生命实际增加值=基础增加值*（1+被治疗率))
ATTR_RSTDMSUB_RATIO = 516,          -- 护盾减伤比 (TODO原护盾吸收比现用做抵抗吸收比)

--
ATTR_CD_RATIO            = 517, --CD减少率
ATTR_HURT_SHARE_RATIO    = 518, --伤害平摊比率
ATTR_WEAKNESS_ATTACK_PERCENT = 519, --弱点攻击伤害比

ATTR_CRIT_INVALID_PERCENT = 520, --暴击失效率
ATTR_PREICE_INVALID_PERCENT = 521, --穿透失效率
ATTR_PREICE_ADD_PERCENT = 522, --穿透伤害加成  by龚老板
ATTR_DMSUB_RATIO_EX = 523, --再减伤比  by波哥

--各种类型的暴击率
ATTR_CRIT_PT    = 551, -- 暴击率（普攻）
ATTR_CRIT_FZ    = 552, -- 暴击率（F技能）
ATTR_CRIT_XL    = 553, -- 暴击率（S技能）
ATTR_CRIT_CCJ   = 554, -- 暴击率（出场技）
ATTR_CRIT_DZ    = 556, -- 暴击率（大招）
ATTR_CRIT_JX    = 557, -- 暴击率（觉醒）

--受控制时间加成
ATTR_CTRL_XY = 571,    -- 控制时间加成（眩晕）
ATTR_CTRL_DJ = 572,    -- 控制时间加成（冻结）
ATTR_CTRL_JZ = 573,    -- 控制时间加成（静止）
ATTR_CTRL_MH = 574,    -- 控制时间加成（魅惑）
--受控制时间减免
ATTR_UNCTRL_XY = 581, --受控时间减免（眩晕）
ATTR_UNCTRL_DJ = 582, --受控时间减免（冻结）
ATTR_UNCTRL_JZ = 583, --受控时间减免（静止）



ATTR_DMADD_PYHSIC  = 601 ,  --物理伤害加成  601 万分比，增加所造成的物理伤害。
ATTR_DMADD_FROZEN  = 602 ,  --冰冻伤害加成  602 万分比，增加所造成的冰系伤害。
ATTR_DMADD_FLAME   = 603 ,  --燃烧伤害加成  603 万分比，增加所造成的燃烧伤害。
ATTR_DMADD_BLAST   = 604 ,  --疾风伤害加成  604 万分比，增加所造成的风属性伤害。
ATTR_DMADD_THUNDER = 605 ,  --雷电伤害加成  605 万分比，增加所造成的雷电伤害。
ATTR_DMADD_POISON  = 606 ,  --毒素伤害加成  606 万分比，增加所造成的毒素伤害。
ATTR_DMADD_LIGHT   = 607 ,  --光属性伤害加成 607 万分比，增加所造成的光属性伤害。
ATTR_DMADD_DARK    = 608 ,  --暗属性伤害加成 608 万分比，增加所造成的暗属性伤害。
ATTR_DMADD_MIND    = 609 ,  --精神伤害加成 609 万分比，增加所造成的精神属性伤害
ATTR_DMADD_SPACE    = 610 ,  --空间伤害加成 610 万分比，增加所造成的空间属性伤害


--Biology, machinery, spirit
ATTR_DMADD_HERO       = 651, --伤害加成（针对角色）
ATTR_DMADD_BIOLOGY    = 652, --伤害加成（针对生物）
ATTR_DMADD_MACHINERY  = 653, --伤害加成（针对机械）
ATTR_DMADD_SPIRIT     = 654, --伤害加成（针对灵体）

------
ATTR_DMADD_NORMAL     = 661, --伤害加成（普通怪伤害加成）
ATTR_DMADD_ELITE      = 662, --伤害加成（精英伤害加成）
ATTR_DMADD_BOSS       = 663, --伤害加成（Boss怪伤害加成）


ATTR_DMSUB_HERO       = 751, --受伤减免（针对角色）
ATTR_DMSUB_BIOLOGY    = 752, --受伤减免（针对生物）
ATTR_DMSUB_MACHINERY  = 753, --受伤减免（针对机械）
ATTR_DMSUB_SPIRIT     = 754, --受伤减免（针对灵体）




ATTR_DMSUB_PYHSIC  = 701 ,  --物理受伤减免  701 万分比，减少所受到的的物理伤害。
ATTR_DMSUB_FROZEN  = 702 ,  --冰冻受伤减免  702 万分比，减少所受到的的冰系伤害。
ATTR_DMSUB_FLAME   = 703 ,  --燃烧受伤减免  703 万分比，减少所受到的燃烧伤害。
ATTR_DMSUB_BLAST   = 704 ,  --疾风受伤减免  704 万分比，减少所受到的风属性伤害。
ATTR_DMSUB_THUNDER = 705 ,  --雷电受伤减免  705 万分比，减少所受到的的雷电伤害。
ATTR_DMSUB_POISON  = 706 ,  --毒素受伤减免  706 万分比，减少所受到的的毒素伤害。
ATTR_DMSUB_LIGHT   = 707 ,  --光属性受伤减免 707 万分比，减少所受到的的光属性伤害。
ATTR_DMSUB_DARK    = 708 ,  --暗属性受伤减免 708 万分比，减少所受到的的暗属性伤害。
ATTR_DMSUB_MIND    = 709 ,  --精神性受伤减免 708 万分比，减少所受到的精神属性伤害。
ATTR_DMSUB_SPACE    = 710 ,  --空间性受伤减免 710 万分比，减少所受到的空间属性伤害。


--战斗临时属性 (skillHurt damageType)
ATTR_DMADD_PT    = 801, -- 伤害加成（普攻）  用于增加伤害类型为普通伤害时，造成的伤害值
ATTR_DMADD_FZ    = 802, -- 伤害加成（F技能）
ATTR_DMADD_XL    = 803, -- 伤害加成（S技能）
ATTR_DMADD_CCJ   = 804, -- 伤害加成（出场技）
ATTR_DMADD_DZ    = 806, -- 伤害加成（大招）
ATTR_DMADD_JX    = 807, -- 伤害加成（觉醒）
ATTR_DMADD_EXTRA_1    = 811, -- 伤害加成（额外技能1）

ATTR_DMADD_PT_BASE      = 821, -- 基础技能伤害加成（普攻）
ATTR_DMADD_FZ_BASE      = 822, -- 基础技能伤害加成（F技能）
ATTR_DMADD_XL_BASE      = 823, -- 基础技能伤害加成（S技能）
ATTR_DMADD_CCJ_BASE     = 824, -- 基础技能伤害加成（出场技）
ATTR_DMADD_DZ_BASE      = 826, -- 基础技能伤害加成（大招)
ATTR_DMADD_JX_BASE      = 827, -- 基础技能伤害加成（觉醒）
ATTR_DMADD_EXTRA_1_BASE = 831, -- 基础技能伤害加成（额外技能1））


ATTR_DMSUB_PT    = 901, -- 伤害减免（普攻） 用于减少伤害类型为普通伤害时，受到的伤害值
ATTR_DMSUB_FZ    = 902, -- 伤害减免（F技能）
ATTR_DMSUB_XL    = 903, -- 伤害减免（S技能）
ATTR_DMSUB_CCJ   = 904, -- 伤害减免（出场技）
ATTR_DMSUB_DZ    = 906, -- 伤害减免（大招）
ATTR_DMSUB_JX    = 907, -- 伤害减免（觉醒）

}

-- 固定值加成属性（累加）
-- 客户端显示百分比/10000
local BASE_VAL = 1000
-- 生命加成 - 1001
eAttrType.ATTR_MAX_HP_RATIO             = BASE_VAL + eAttrType.ATTR_MAX_HP
-- 攻击加成 - 1002
eAttrType.ATTR_ATK_RATIO            = BASE_VAL + eAttrType.ATTR_ATK
-- 防御加成 - 1003
eAttrType.ATTR_DEF_RATIO            = BASE_VAL + eAttrType.ATTR_DEF

-- 攻速加成 - 1006
eAttrType.ATTR_SPD_RATIO            = BASE_VAL + eAttrType.ATTR_SPD
-- 护盾加成 - 1007
eAttrType.ATTR_SLD_RATIO            = BASE_VAL + eAttrType.ATTR_SLD
-- 最大怒气加成 - 1008
eAttrType.ATTR_MAX_AGR_RATIO        = BASE_VAL + eAttrType.ATTR_MAX_AGR
-- 怒气回复加成 - 1009
eAttrType.ATTR_RECOVER_AGR_RATIO    = BASE_VAL + eAttrType.ATTR_RECOVER_AGR

-- 移动加成 - 1011
eAttrType.ATTR_MOVE_SPEED_RATIO     = BASE_VAL + eAttrType.ATTR_MOVE_SPEED
-- 破防值加成 -1012
eAttrType.ATTR_SAB_RATIO            = BASE_VAL + eAttrType.ATTR_SAB
--普攻攻速加成1019
eAttrType.ATTR_SPD_NORMAL_RATIO     = BASE_VAL + eAttrType.ATTR_SPD_NORMAL

-----------没啥用只为属性补齐-------------
-- 增伤- 1004
eAttrType.ATTR_DMADD_RATIO = BASE_VAL + eAttrType.ATTR_DMADD
-- 减伤- 1005
eAttrType.ATTR_DMSUB_RATIO = BASE_VAL + eAttrType.ATTR_DMSUB
-- 附重1010
eAttrType.ATTR_COST_RATIO  = BASE_VAL + eAttrType.ATTR_COST
--1013
eAttrType.ATTR_XXOO_RATIO  =  BASE_VAL + eAttrType.ATTR_XXOO
--1014
eAttrType.ATTR_MAX_ENERG_RATIO  =  BASE_VAL + eAttrType.ATTR_MAX_ENERGY

eAttrType.ATTR_MAX_RST_RATIO  =  BASE_VAL + eAttrType.ATTR_MAX_RST
--1018
eAttrType.ATTR_MAX_TEAR_RATIO  =  BASE_VAL + eAttrType.ATTR_MAX_TEAR



--战斗临时属性（客户端使用）
eAttrType.ATTR_LOASS_HP           = 2001              -- 当前血量损失
eAttrType.ATTR_HURT               = 2002               -- 本次伤害
eAttrType.ATTR_REV_HURT           = 2003                -- 本次受伤
eAttrType.ATTR_COMBO              = 2004               -- 连击数
eAttrType.ATTR_ADD_AGR            = 2005                 -- 本次能量增加
eAttrType.ATTR_RED_AGR            = 2006                 -- 本次能量减少
eAttrType.ATTR_NOW_HP_PERCENT     = 2007    -- 当前血量百分比
eAttrType.ATTR_LOASS_HP_PERCENT   = 2008    -- 当前血量损失的百分比

eAttrType.ATTR_NOW_HURT_PERCENT   = 2009    -- 本次受伤百分比(当前失去血量占总血量的百分比)
eAttrType.ATTR_NOW_SPEED_PERCENT  = 2010    --当前移动速度百分比

eAttrType.ATTR_WEAKNESS_ATTACK_RATIO   = 2011 --弱点攻击概率

eAttrType.ATTR_ENEMY_NUMS        = 2013 --场上敌人数量
eAttrType.ATTR_CONFUSE_MAX_NUMS  = 2014 --魅惑数量上限
eAttrType.ATTR_CONFUSE_NUMS      = 2015 --当前魅惑人数
eAttrType.ATTR_ELECTRIC_HURT     = 2016 --感电伤害参照值
eAttrType.ATTR_REDUCE_MAX_HP     = 2017 --减血上限值 (大于0受到限制)
eAttrType.ATTR_IMPRINT_NUMS      = 2018 --敌对印记人数


eAttrType.ATTR_FIRE_SPIRIT_NUM    = 58      --当前火灵数量  临时属性，用于实现琴里的质点技能需要的属性，初始为0。上限值为5。此属性需要纳入buff触发段中的属性检查
eAttrType.ATTR_BASE_FIRE_DAMAGE   = 2101    --基础燃烧伤害  临时属性，用于计算燃烧buff的伤害值，初始为0
eAttrType.ATTR_BASE_BLEED_DAMAGE  = 2102    --基础流血伤害  临时属性，用于计算流血buff的伤害值，初始为0
eAttrType.ATTR_KUANGSAN_SSZ       = 2103    --狂三食时值，2103

eAttrType.ATTR_2104     = 2104    --备用属性
eAttrType.ATTR_2105     = 2105    --备用属性
eAttrType.ATTR_2106     = 2106    --备用属性
eAttrType.ATTR_2107     = 2107    --备用属性
eAttrType.ATTR_2108     = 2108    --备用属性
eAttrType.ATTR_2109     = 2109    --备用属性
eAttrType.ATTR_2110     = 2110    --备用属性

enum.eAttrType = eAttrType

--受击位移类型
enum.eHurtMoveType =
{
	HMT_NORMAL_EX      = 1 , --常规位移(相对于施法者的)
	HMT_NORMAL         = 2 , --常规位移(相对于施法者的)
	HMT_CENTER_EX      = 3 , --中心点位移
	HMT_CENTER         = 4 , --中心点位移
}


--伤害判断触发方式
enum.eHurtWay =
{
    HW_NONE      = 0,  --无伤害判定
    HW_FRAME     = 1,  --帧事件
    HW_HIT_TEST  = 2,  --碰撞检测
}

-- 1普攻，2技能一，3小技能二，4必杀，5闪避技能，6觉醒技能，7下落技能，8切换登场技能，9起身震飞
--技能触发类型
enum.eSkillType = {
    GENERAL = 1,
    Skill_1 = 2,
    Skill_2 = 3,
    CRI     = 4,
    DODGE   = 5,  --闪避技能
    AWAKE   = 6,  --觉醒技能
    DOWN    = 8,  --下落技能
    ENTER   = 7,  --登场技能
    STANDUP = 9,  --起身技能
    EXTRA_SKILL_1 = 10,  
    EXTRA_SKILL_2 = 11,  
    EXTRA_SKILL_3 = 12,  
    EXTRA_SKILL_4 = 13,  
    EXTRA_SKILL_5 = 14,  
}

enum.eRoleType = {
	Hero     = 1,    --英雄
	Monster  = 2,    --怪物
    Assist   = 3,    --助战 TODO
    Team     = 4,    --组队角色
    Trap     = 6,    --陷阱
}

enum.eProperty =
{
	AtkSpeed    = 1,  --攻擊速度
	AtkDistance = 2,  --攻擊距離
	Hp          = 3,
	MaxHp       = 4,
	Defense     = 5,  --防御力
	PhysicalAtk = 6,  --物攻击
	MagicAtk    = 7,  --魔攻击
}

--寻敌类型
enum.eSelectType =
{
-- 技能目标选择条件
	NEARLY = 1   ,     -- 最近的
	FAR    = 2   ,     -- 最远的
	LOWHP  = 3   ,     -- 生命最低的
	DIE    = 4   ,     -- 阵亡的
	MYSELF = 5   ,     -- 自己
	RANDOM = 6   ,     -- 随机
	RECT   = 7   ,     -- 矩形区域
    NO_DIR_RECT   = 8   ,     -- 矩形区域不做方向检查
	-- ALL    = 2   ,     -- 全屏
}


-- 特效类型
enum.eEffectType =
{
	NORMAL      = 1,                -- 普通型(原地播放)
	EMIT        = 2,                -- 发射型(会移动)
}



-- 1.自己（buff提供者）
-- 2.buff触发对象
-- 3.状态来源方
-- 4.状态对应方
-- 5.队友
-- 6.敌人
-- 7.己方召唤单位
-- 8.敌方召唤单位
-- 9.指定队友
-- 作用对象(TODO 未完)
enum.eBFTargetType =
{
    TT_ME         = 1 , --自己（buff提供者）
    TT_TRIGGER    = 2 , --buff触发对象
    TT_EVENT_SRC  = 3 , --状态来源方(和触发对象同一种)
    TT_EVENT_TAR  = 4 , --状态对应方(状态目标)
    TT_FRIENT     = 5 , -- 5.队友
    TT_ENEMY      = 6 , -- 6.敌人
    TT_FRIENT_TEAM = 7 , --7.包涵自己
    TT_FRIENT_HERO    = 8 , --友方 角色
    TT_FRIENT_MONSTER = 9 , --友方 怪
    TT_ENEMY_RANDOM = 10 , --随机 敌人
    TT_FRIENT_RANDOM = 11 , --随机 队友包含自己
}


--生效类型
enum.eBFETakeType =
{
    TT_AT_ONECE       = 1 , --即刻生效
    TT_INTERVAL       = 2 , --间隔生效
    TT_SKILL_EFFECT   = 4 , --间隔检查(特效与目标发生碰撞)
    TT_EVENT          = 3 , --事件(条件)触发生效
    TT_CHECK_EFFECT    = 5 , --条件检查触发生效
}

--生效额外条件
enum.eBFETakeCondition =
{
    TC_TARGET_FRIEND       = 1 , --友方目标（包括召唤物）
    TC_TARGET_ENEMY        = 2 , --敌方目标（包括召唤物）
    TC_TARGET_ALL          = 3 , --所有目标（包括召唤物）
    TC_TARGET_FRIEND_CALL  = 4 , --友方召唤物
    TC_TARGET_ENEMY_CALL   = 5,  --敌方召唤物
    TC_TARGET_CALL         = 6 , --所有召唤物
}

--    effectiveWay字段配置为3时，效果为持续x次攻击。
--    effectiveWay字段配置为4时，效果为持续x次受击。
--    effectTimes字段配置对应的生效次数。


--触发buffer的技能事件
enum.eBFSkillEvent =
{
    SE_HURT      = 1,        --hurt 事件触发
}


--Buff触发类型
-- 1.天赋类（触发对象存活即可）
-- 2.属性变化类
-- 3.状态类
-- 4.操作类
-- 5.指定buff类
-- 6.释放技能
-- 7.受到技能
enum.eBFTriggerType =
{
	TT_TALENT      = 1,        -- 天赋类
	TT_ATTR        = 2,        -- 属性变化
	TT_EVENT       = 3,        -- 事件类
    TT_INTERVAL    = 4,        -- 间隔触发
    TT_SKILL       = 5,        -- 释放技能
    TT_STATE       = 6,        -- 状态类
    TT_USE_SKILL   = 7,        -- 状态类
    TT_USE_CARD    = 8,        -- 使用卡牌
}

--Buffer触发对象
-- 1.自己（buff提供者）
-- 2.随机敌人
-- 3.随机队友
-- 4.指定队友

enum.eBFTriggerObject      =
{
	TO_ME             = 1,        -- 自己
	TO_RAN_FRIEND     = 2,        -- 随机队友
	TO_RAN_ENEMY      = 3,        -- 随机敌人
	TO_APPOINT_FRIEND = 4,        -- 指定队友
    TO_RAN_FRIEND_HERO = 5,       -- 随机队友(角色)
    TO_RAN_FRIEND_MONSTER = 6,    -- 随机队友(怪)

}



--效果叠加类型
enum.eBFAddType =
{
    AT_NONE    = 1 , --不叠加
    AT_REPLACE = 2 , --替换
    AT_ADD1    = 3 , --完全叠加,效果时间单独处理  TODO 这钟创建多个实例处理
    AT_ADD2    = 4 , --效果叠加,时间公用          --只处理叠加层数
    AT_ADD3    = 5 , --效果不叠,时间累加
    --叠加,时间公用
}
--效果作用的目标类型
enum.eBFObjectType =
{
    OT_HERO    = 1 , --作用于角色
    OT_AREA    = 2 , --作用于一定区域
}




-- 1.属性变化
-- 2.附加状态
-- 3.概率变化
-- 4.释放技能
-- 5.受到技能
-- 6.执行buff
-- 7.特殊
--效果类型 TODO 未完成
enum.eBFEffectType =
{
    ET_ATTR_CHANGE          = 1,        -- 属性变化 纯伤害
    ET_STATE_CHANGE         = 2,        -- 增加状态
    ET_BUFFER_PRO_CHANGE    = 3,        -- BUF概率变更
    ET_TRIGGER_EFFECT       = 4,        -- 触发特效
    ET_REDUCE_SKILL_CD      = 5,        -- 减少技能CD
    ET_TEMP_ATTR_CHANGE     = 6,        -- 临时属性变化
    ET_SHARE_HURT           = 7,        -- 分摊伤害
    ET_CHANGE_CAMP          = 8,        -- 修改阵营
    ET_STATE_CHANGE_RANDOM  = 9,        -- 随机1种状态
    ET_CHANGE_SKIN          = 10,       -- 变换形态
    ET_MODEL_SCALE          = 11,       -- 模型缩放
    ET_USE_SKILL            = 12,       -- 释放技能
    ET_TIMESCALE_CHANGE     = 13,       -- 角色时间减缓
    ET_TO_FLASH_BACK        = 14,       -- 回溯
    ET_SET_SKILL_CD         = 15,       -- 设置固定技能CD使用
    ET_EFFECT_UNABLED       = 16,       -- 屏蔽指定buff效果
    ET_FORCE_CHANGE_SKIN    = 17,       -- 强制变换形态
}







-- 1.无参照对象
-- 2.buff触发对象
-- 3.buff作用对象
-- 4.状态来源方
-- 5.状态对应方

enum.eBFRTargetType =
{
    RTT_NONE       = 1 , --无参照对象
    RTT_TRIGGER    = 2 , --buff触发对象
    RTT_TARGET     = 3 , --buff作用对象
    RTT_PROV       = 4,  --buff提供者
    RTT_EVENT_TAR  = 5 , --状态对应方
}



-------角色状态
enum.eBFHeroState =
{
    HS_VERTIGO        = 19,        -- 眩晕
}


--魔女时间触发类型
enum.eWitchTimeTriggerType =
{
    NULL        = 0, --不触发
    SKILL       = 1, --技能触发
    LIMIT_DODGE = 2, --极限闪避触发
}

--魔女时间持续类型
enum.eWitchTimeContinuedType =
{
    SKILL_TIME   = 0, --技能时间
    FIEXED_TIME  = 1, --固定时间

}

--招架方位
enum.eWithstandDir =
{
    FRONT  = 1 , --前方
    BEHIND = 2 , --后方
    AROUND = 3 , --前后两方
}

--展示状态

enum.eShowState =
{
    -- IMMUNE = 1 , --免疫
    -- ABSORB = 2 , --吸收
    -- PARRY  = 3 , --招架
    GeDang = TextDataMgr:getText(100000093) ,   --格挡
    ShanBi = TextDataMgr:getText(100000094) ,   --闪避
    -- MianYi = TextDataMgr:getText(100000095) ,   --免疫
    XiShou = TextDataMgr:getText(100000096) ,   --吸收
    Miss   = TextDataMgr:getText(100000119) ,   --MISS

    ZhaoJia  = TextDataMgr:getText(100000097) ,   --招架
    ChuXue   = TextDataMgr:getText(100000098) ,   --出血
    BingDong = TextDataMgr:getText(100000099) ,   --冰冻

    ZhongDu = TextDataMgr:getText(100000100) ,   --中毒
    DianRan = TextDataMgr:getText(100000101) ,   --点燃
    MianYi  = TextDataMgr:getText(100000102) ,   --免疫
    GanDian = TextDataMgr:getText(100000103) ,   --感电

    ZhuoShao  = TextDataMgr:getText(100000104),    --灼烧
    ZhuoShang = TextDataMgr:getText(100000105) ,   --灼伤
    YiShang   = TextDataMgr:getText(100000106) ,   --易伤
    MeiHuo    = TextDataMgr:getText(100000107)    --魅惑

}



-- 1	待机
-- 2	移动
-- 3	普攻并命中
-- 4	受到普攻
-- 5	治疗
-- 6	被治疗
-- 7	暴击
-- 8	被暴击
-- 9	闪避
-- 10	被闪避（包括普攻和技能）
-- 11	格挡
-- 12	被格挡（仅普攻）
-- 13	造成伤害
-- 14	受到伤害
-- 15	死亡
-- 16	复活






enum.eAState             =
{
E_XUAN_YUN    = 1   ,--眩晕
E_DONG_JIE    = 2   ,--冻结
E_JING_ZHI    = 3   ,--静止

E_MEI_HUO     = 4   ,--魅惑    攻击友军
E_HUN_LUAN    = 5   ,--混乱    操作反向
E_PARALYSIS   = 7   ,--麻痹    
E_FU_KONG     = 11  ,--浮空
E_DAO_DI      = 12  ,--倒地
E_QIAN_YIN    = 13  ,--牵引
E_LIMIT_DODGE = 14  ,--极限闪避
-- E_TO_PARRY    = 15  ,--招架 (好像不需要)
E_BING_DONG   = 31  ,--冰冻
E_LIU_XUE     = 32  ,--流血
E_RAN_SHAO    = 33  ,--燃烧
E_GAN_DIAN    = 34  ,--感电  标记型，无实际作用
E_WIND        = 35  ,--狂风
E_WEAK        = 36  ,--虚弱36


E_FMYX        = 37 ,--负面影响 拥有debuff和控制的角色
E_SI_LIE      = 38 ,--撕裂（夕弦用的） 标记型，无实际作用
E_KBRH        = 39 ,--抗暴弱化 标记型，无实际作用
E_JIAN_SU     = 40 ,--减速   标记型，无实际作用
E_STOP_MOVE   = 46 ,--状态表新增了状态46-裁决
E_BINGHAN    = 53 ,--冰寒
E_IMPRINT    = 54 ,--印记
E_SHUANGXUE_ZHISHANG = 55 ,--霜雪之伤

E_STATE_56 = 56 ,--时间诅咒
E_STATE_57 = 57 ,--
E_STATE_58 = 58 ,--
E_STATE_59 = 59 ,--
E_STATE_60 = 60 , --该状态中不被怪物追踪


E_FORM_1     = 62 ,--处于1形态中   变身相关的状态
E_FORM_2     = 63 ,--处于2形态中   变身相关的状态
E_ZM_SHMY    = 64 ,--正面伤害免疫   

E_STATE_70 = 70 ,--
E_STATE_71 = 71 ,--
E_STATE_72 = 72 ,--
E_STATE_73 = 73 ,--
E_STATE_74 = 74 ,--
E_STATE_75 = 75 ,--
E_STATE_76 = 76 ,--
E_STATE_77 = 77 ,--
E_STATE_78 = 78 ,--
E_STATE_79 = 79 ,--
E_STATE_80 = 80 ,--
E_STATE_81 = 81 ,--
E_STATE_82 = 82 ,--
E_STATE_83 = 83 ,--
E_STATE_84 = 84 ,--
E_STATE_85 = 85 ,--暂无使用
E_STATE_86 = 86 ,--暂无使用
E_STATE_87 = 87 ,--暂无使用
E_STATE_88 = 88 ,--暂无使用
E_STATE_89 = 89 ,--暂无使用
E_STATE_90 = 90 ,--暂无使用
E_STATE_91 = 91 ,--暂无使用
E_STATE_92 = 92 ,--暂无使用
E_STATE_93 = 93 ,--暂无使用
E_STATE_94 = 94 ,--暂无使用
E_STATE_95 = 95 ,--暂无使用
E_STATE_96 = 96 ,--暂无使用
E_STATE_97 = 97 ,--暂无使用
E_STATE_98 = 98 ,--暂无使用
E_STATE_99 = 99 ,--暂无使用
E_STATE_100 = 100 ,--暂无使用

E_XUAN_YUN_MY     = 101 ,--眩晕免疫
E_DONG_JIE_MY     = 102 ,--冻结免疫
E_JING_ZHI_MY     = 103 ,--静止免疫
E_PARALYSIS_MY    = 107 ,--麻痹免疫 
E_QIANYIN_MY      = 113 ,--牵引免疫
E_BING_DONG_MY    = 131 ,--冰冻免疫
E_LIU_XUE_MY      = 132 ,--流血免疫
E_RAN_SHAO_MY     = 133 ,--燃烧免疫
E_GAN_DIAN_MY     = 134 ,--感电免疫
E_WIND_MY         = 135 ,--狂风免疫

E_CHANGE_SKIN_MY = 147 ,--变身免疫
E_GRAB_MY        = 148 ,--抓取免疫

E_MIANYI_DBUFF   = 160 ,--免疫负面效果
E_ZLWX        = 161 ,--治疗无效
E_WU_DI       = 162 ,--无敌
E_BA_TI       = 163 ,--霸体
E_JIANSU_MY   = 164 ,--减速免疫
E_BA_TI_EX    = 165 ,--霸体扩展
E_MIANYI_ATTR_DEBUFF   = 166 ,--免疫属性减少debuff
E_MIANYI_LOSH_HP   = 167 ,--免疫免疫扣血
E_RELIVE   = 61 ,--复活




E_SKILLTYPE_1_DISABLE = 181, --禁用普攻

E_SKILLTYPE_2_DISABLE = 182, --禁用2技能一

E_SKILLTYPE_3_DISABLE = 183, --禁用3小技能二

E_SKILLTYPE_4_DISABLE = 186, --禁用4必杀

E_SKILLTYPE_5_DISABLE = 188, --禁用5闪避技能

E_SKILLTYPE_6_DISABLE = 187, --禁用6觉醒技能

E_SKILLTYPE_7_DISABLE = 189, --禁用I

E_SKILLTYPE_8_DISABLE = 184, --禁用H

E_SKILLTYPE_10_DISABLE = 185, --禁用G额外技能

E_SKILLTYPE_1_DISABLE_CD = 191, --禁用普攻和CD

E_SKILLTYPE_2_DISABLE_CD = 192, --禁用2技能一和CD

E_SKILLTYPE_3_DISABLE_CD = 193, --禁用3技能二和CD

E_SKILLTYPE_4_DISABLE_CD = 196, --禁用4必杀和CD

E_SKILLTYPE_5_DISABLE_CD = 198, --禁用5闪避技能和CD

E_SKILLTYPE_6_DISABLE_CD = 197, --禁用6觉醒技能和CD

E_SKILLTYPE_7_DISABLE_CD = 199, --禁用I技能和CD

E_SKILLTYPE_8_DISABLE_CD = 194, --禁用H技能CD

E_SKILLTYPE_10_DISABLE_CD = 195, --禁用G额外技能CD

E_LOCK_HP_1  = 201, --锁血10%
E_LOCK_HP_2  = 202, --锁血20%
E_LOCK_HP_3  = 203, --锁血30%
E_LOCK_HP_4  = 204, --锁血40%
E_LOCK_HP_5  = 205, --锁血50%
E_LOCK_HP_6  = 206, --锁血60%
E_LOCK_HP_7  = 207, --锁血70%
E_LOCK_HP_8  = 208, --锁血80%
E_LOCK_HP_9  = 209, --锁血90%
E_LOCK_HP_10 = 210, --锁血100%
}
enum.eBFState =
{

E_STAND  =1 ,--  待机
E_MOVE   =2 ,--  移动
E_TREATE =3 ,--  治疗
E_DEAD   =4 ,--  死亡
E_DYING  =5 ,--  濒死
E_JI_SHA = 9, --击杀(战斗数据统计用)
E_PICKUP_ITEM  = 8 ,--  拾取道具
E_HERO_ENTER   = 7 ,--  出场(切换角色)

E_TRANS_1   = 11 ,--  变身[xx->1形态]
E_TRANS_2   = 10 ,--  变身[xxx-2形态]

E_GETHIT_IMMUNE   = 12 ,--  受击免疫
E_LOSE_HP_IMMUNE  = 13 ,--  扣血被抵挡
E_REV_TREATE   = 53,--  受到治疗
-- E_RELIVE       = 4 ,-- 复活 TODO 功能未实现
E_HERO_LEAVE   = 57,  --离场(切换角色)

E_ATTACK_SKILL= 199, --发动通用技能 
E_ATTACK    = 200, --发动通用攻击 (技能首动作触发)

E_PT_ACTION     = 201, --发动普攻攻击 (技能首动作触发)
E_SKILL1_ACTION = 202, --小技能1攻击 (技能首动作触发)
E_SKILL2_ACTION = 203, --小技能2攻击 (技能首动作触发)
E_CCJ_ACTION    = 204,--发动出场技 (技能首动作触发)
E_SB_ACTION     = 205, --使用闪避技能 (技能首动作触发)
E_DZ_ACITON     = 206, --发动大招攻击 (技能首动作触发)
E_JX_ACTION     = 207, --发动觉醒攻击 (技能首动作触发)

E_EXTRA_SKILL_1   = 210, --使用特殊技能1
E_EXTRA_SKILL_2   = 211, --使用特殊技能2
E_EXTRA_SKILL_3   = 212, --使用特殊技能3
E_EXTRA_SKILL_4   = 213, --使用特殊技能4
E_EXTRA_SKILL_5   = 214, --使用特殊技能5

--瞄准
E_EXTRA_SKILL_1_AIM   = 260, --使用特殊技能1 瞄准
E_EXTRA_SKILL_2_AIM   = 261, --使用特殊技能2 瞄准
E_EXTRA_SKILL_3_AIM   = 262, --使用特殊技能3 瞄准
E_EXTRA_SKILL_4_AIM   = 263, --使用特殊技能4 瞄准
E_EXTRA_SKILL_5_AIM   = 264, --使用特殊技能5 瞄准


E_EXTRA_SKILL_1_HITED   = 310, --使用特殊技能1 命中
E_EXTRA_SKILL_2_HITED   = 311, --使用特殊技能2 命中
E_EXTRA_SKILL_3_HITED   = 312, --使用特殊技能3 命中
E_EXTRA_SKILL_4_HITED   = 313, --使用特殊技能4 命中
E_EXTRA_SKILL_5_HITED   = 314, --使用特殊技能5 命中

E_EXTRA_SKILL_1_HURT   = 410, --使用特殊技能1 伤害
E_EXTRA_SKILL_2_HURT   = 411, --使用特殊技能2 伤害
E_EXTRA_SKILL_3_HURT   = 412, --使用特殊技能3 伤害
E_EXTRA_SKILL_4_HURT   = 413, --使用特殊技能4 伤害 
E_EXTRA_SKILL_5_HURT   = 414, --使用特殊技能5 伤害

E_BACK_SKILL_HURT   = 421, --制造背击伤害

E_EXTRA_SKILL_1_CRIT   = 510, --使用特殊技能1 暴击
E_EXTRA_SKILL_2_CRIT   = 511, --使用特殊技能2 暴击
E_EXTRA_SKILL_3_CRIT   = 512, --使用特殊技能3 暴击
E_EXTRA_SKILL_4_CRIT   = 513, --使用特殊技能4 暴击 
E_EXTRA_SKILL_5_CRIT   = 514, --使用特殊技能5 暴击


E_AIM           = 250, --发动通用技 瞄准
E_PT_AIM        = 251, --发动普攻 瞄准
E_SKILL1_AIM    = 252, --小技能1 瞄准
E_SKILL2_AIM    = 253, --小技能2 瞄准
E_CCJ_AIM       = 254, --发动出场技能 瞄准
E_DZ_AIM        = 256, --发动大招 瞄准
E_JX_AIM        = 257, --发动觉醒 瞄准

E_REV_AIM       = 270, --受到通用瞄准


E_HITED         = 300, --通用命中
E_PT_HITED      = 301, --普攻命中
E_SKILL1_HITED  = 302, --SKILL1命中
E_SKILL2_HITED  = 303, --SKILL2命中
E_CCJ_HITED     = 304, --出场技命中
E_DZ_HITED      = 306, --大招命中
E_JX_HITED      = 307, --觉醒命中


E_REV_DODGE     = 341, --被闪避
E_REV_PT_BLOCK  = 342, --被格挡

E_REV_HIT        = 350, --通用受击
E_PT_REV_HIT     = 351, --普攻受击
E_SKILL1_REV_HIT = 352, --SKILL1受击
E_SKILL2_REV_HIT = 353, --SKILL2受击
E_CCJ_REV_HIT    = 354, --出场技受击
E_QTE_REV_HIT    = 355, --QTE技受击
E_DZ_REV_HIT     = 356, --大招受击
E_JX_REV_HIT     = 357, --觉醒受击


E_DODGE         = 391, --闪避
E_BLOCK         = 392, --格挡


E_HURT           =400, --制造通用伤害
E_PT_HURT        =401, --制造普攻伤害
E_SKILL1_HURT    =402, --制造小技能1伤害
E_SKILL2_HURT    =403, --制造小技能2伤害
E_CCJ_HURT       =404, --制造出场技伤害
E_QTE_HURT       =405, --制造QTE伤害
E_DZ_HURT        =406, --制造大招伤害
E_JX_HURT        =407, --制造觉醒伤害

E_REV_HURT           =450, --受到通用伤害
E_REV_PT_HURT        =451, --受到普攻伤害
E_REV_SKILL1_HURT    =452, --受到技能1伤害
E_REV_SKILL2_HURT    =453, --受到技能2伤害
E_REV_CCJ_HURT       =454, --受到出场技伤害
E_REV_DZ_HURT        =456, --受到大招伤害
E_REV_JX_HURT        =457, --受到觉醒伤害


E_REV_REAL_HURT  = 440, --受到通用真实伤害（受击减血）


--通用背击
E_REV_BACK_HURT      =481, --通用受到背击伤害
E_MAKE_BACK_HURT      =482, --通用造成背击

E_CRIT          = 500, --通用暴击
E_PT_CRIT       = 501, --普攻暴击
E_SKILL1_CRIT   = 502, --技能1暴击
E_SKILL2_CRIT   = 503, --技能2暴击
E_CCJ_CRIT      = 504, --出场技暴击
E_DZ_CRIT       = 506, --大招暴击
E_JX_CRIT       = 507, --觉醒暴击

E_DO_PIERCE        = 520, --通用穿透
E_PT_DO_PIERCE     = 521, --普攻穿透
E_SKILL1_DO_PIERCE = 522, --SKILL1穿透
E_SKILL2_DO_PIERCE = 523, --SKILL2穿透
E_CCJ_DO_PIERCE    = 524, --出场技穿透
-- E_QTE_DO_PIERCE    = 525, --QTE技穿透
E_DZ_DO_PIERCE     = 526, --大招穿透
E_JX_DO_PIERCE     = 527, --觉醒穿透


E_REV_CRIT        = 550, --受到暴击
E_PT_REV_CRIT     = 551, --受到普攻暴击
E_SKILL1_REV_CRIT = 552, --受到技能1暴击
E_SKILL2_REV_CRIT = 553, --受到技能2暴击
E_CCJ_REV_CRIT    = 554, --受到出场技暴击
E_DZ_REV_CRIT     = 556, --受到大招暴击
E_JX_REV_CRIT     = 557, --受到觉醒暴击


E_DO_PHYSICAL      = 601, --制造物理伤害
E_DO_FROZEN        = 602, --制造冰属性伤害
E_DO_FLAME         = 603, --制造火属性伤害
E_DO_BLAST         = 604, --制造风属性伤害 
E_DO_THUNDER       = 605, --制造电属性伤害
E_DO_POISON        = 606, --制造毒属性伤害
E_DO_LIGHT         = 607, --制造光属性伤害
E_DO_DARK          = 608, --制造暗属性伤害
E_DO_MIND          = 609, --制造精神伤害
E_DO_SPACE         = 610, --制造空间伤害
E_REV_PHYSICAL      = 651, --受到物理伤害
E_REV_FROZEN        = 652, --受到冰属性伤害
E_REV_FLAME         = 653, --受到火属性伤害
E_REV_BLAST         = 654, --受到风属性伤害 
E_REV_THUNDER       = 655, --受到电属性伤害
E_REV_POISON        = 656, --受到毒属性伤害
E_REV_LIGHT         = 657, --受到光属性伤害
E_REV_DARK          = 658, --受到暗属性伤害
E_REV_MIND          = 659, --受到精神伤害
E_REV_SPACE         = 660, --受到空间伤害


}



--buff状态类型(区分正面还负面)
enum.eBuffStateType =
{
	ST_GAIN      = 1,        -- 增益
	ST_DEBUFFES  = 2,        -- 减益
	ST_ALL       = 3,        -- ALL
}

-- -- 怒气获取规则
enum.eAngerRule =
{
	RULE_GETHIT        = 1  ,           -- 受到攻击
	RULE_AUTO          = 2  ,           -- 自动恢复
	RULE_SWITCH_BATTLE = 3  ,           -- 切换战场
	RULE_BORN          = 4             -- 出场怒气
}

-- -- 角色附加状态类型
-- enum.eAState =
-- {
--     E_NONE       = 0,        -- 停
--     E_XUAN_YUN   = bit_lshift(1,1),        -- 眩晕
--     E_BA_TI      = bit_lshift(1,2),        -- 霸体
--     E_SHANG_MIAN = bit_lshift(1,3),        -- 伤免
--     -- E_HU_DUN     = bit_lshift(1,4),        -- 护盾
-- }




-- 朝向
enum.eDir =
{
	NONE       = 0,        -- 停
	LEFT       = bit_lshift(1,1),        -- 左
	RIGHT      = bit_lshift(1,2),        -- 右
	UP         = bit_lshift(1,3),        -- 上
	DOWN       = bit_lshift(1,4),        -- 下
}

--按键状态
enum.eKeyEventType =
{
    DOWN      = "down", --按下
    DOING     = "doing", --长按
    UP        = "up", --弹起
}

--虚拟按键键值
enum.eVKeyCode =
{
    ROKE       = -1,   --摇杆
    NONE       = 0,
    LEFT       = bit_lshift(1,1),        -- 左
    RIGHT      = bit_lshift(1,2),        -- 右
    UP         = bit_lshift(1,3),        -- 上
    DOWN       = bit_lshift(1,4),        -- 下

    SKILL_A    = bit_lshift(1,5),  --A技能
    SKILL_B    = bit_lshift(1,6),  --B技能
    SKILL_C    = bit_lshift(1,7),  --C技能
    SKILL_D    = bit_lshift(1,8),  --D技能
    SKILL_E    = bit_lshift(1,9),  --入场
    SKILL_F    = bit_lshift(1,10), --下落技能
    SKILL_G    = bit_lshift(1,11), --起身技能
    SKILL_H    = bit_lshift(1,12), --
    SKILL_I    = bit_lshift(1,13), --
}

--实体按键键值
enum.ePKeyCode =
{
    LEFT  = 37,
    UP    = 38,
    RIGHT = 39,
    DOWN  = 40,
    A = 65, B = 66, C = 67, D = 68, E = 69, F = 70, G = 71, 
    H = 72, I = 73, J = 74, K = 75, L = 76, M = 77, N = 78,
    O = 79, P = 80, Q = 81, R = 82, S = 83, T = 84, U = 85, 
    V = 86, W = 87, X = 88, Y = 89, Z = 90
}


--帧事件
enum.eArmtureEvent =
{
	HURT      = "hurt",   --伤害判定
	NEXT      = "next",   --连击触发
	EFFECT    = "effect", --特效触发
	MUSIC     = "music",  --音效
    SHOW      = "show",  --觉醒展示
    MOVE      = "move",  --动作位移
    CAMERA    = "camert",  --摄像机事情位移
    LIMIT_DODGE = "ed",  --极限闪避
    STIFF     = "stiff",  --僵直
    GRASP_START  = "siteStart",  --抓取
    GRASP_END    = "siteEnd",  --抓取
    GRASP_CHANGE = "change",  --抓取
    BUFFER    = "buffer",  --抓取
}

--
-- 1、	随机刷新
-- 2、	地图中心刷新
-- 3、	地图左侧刷新
-- 4、	地图右侧刷新
--怪物出现的位置
enum.ePlaceType =
{
	RANDOM     = 1,
	MAP_CENTER = 2,
	MAP_LEFT   = 3,
	MAP_RIGHT  = 4
}


-- 目标位置
enum.eCameraFlag =
{
	CF_UI     = 1,        --禁止
	CF_MAP    = 32,        --地图摄像机
    CF_EFFECT = 64,        --特效
    CF_EFFECT_BLAST = 128, --气浪特效
}

-- 目标位置
enum.eTargetType =
{
	MYSELF     = 1,        --自己
	TARGET     = 2,        --目标
}

enum.eResType =
{
	RT_SPINE  = 1,  --spine
	RT_IMAGE  = 2,  --图片
	RT_SOUND  = 3,  --音效
}

--战斗引导关注的行为
enum.eGuideAction = {
    TRIGGER_MONSTER = 1,--刷第一波怪
    SLIDE_ROKER     = 2,--滑动摇杆
    SKILL           = 3,--释放技能A
    MONSTER_DEAD    = 4,--怪物死亡
    MOVE            = 5,--角色移动
    -- SKILLC          = 6,--闪避技能

    NEXT            = 6,--完成上一触发
    ACTION          = 7,--分支技能
}

enum.eEvent = {
	EVENT_ACTOR_ADD_TO_LAYER = "actor_add_to_layer",   --"角色添加到战斗层"
	-- EVENT_TRIGGET_MONSTER    = "trigger_MONSTE",
	EVENT_TIP                 = "tips" ,
	-- EVENT_TIPX                = "tipsX",
	EVENT_SHOW_STATE          = "show_state",
	EVENT_EFFECT_ADD_TO_LAYER = "effect_add_to_layer" ,
	EVENT_SCREEN_WOBBLE       = "screen_wobble"       , --屏幕震动
	EVENT_SHOW_AWAKE          = "show_awake"          , --觉醒特写
	EVENT_HIDE_AWAKE          = "hide_awake"          , --隐藏觉醒特写

    EVENT_BOSS_WARNING        = "boss_warning" ,      --boss预警
    EVENT_ADD_PROMPT          = "add_prompt" ,        --添加角色不在屏幕里时的提示
    EVENT_SHOW_GO             = "show_go" ,           --显示前进
    EVENT_ENTER_BATTLE_CD     = "enter_battle_cd"              , --角色入场CD
    EVENT_SHOW_CHALLENGE_PROGRESS = "show_challenge_progress" ,           --显示挑战进度
    EVENT_REFRESH_VICTORY_STATE = "refresh_victory_state" ,         --刷新关卡胜利状态
    EVENT_SHOW_HITLINE        = "show_hit_line",
	EVENT_CAMERA_EVENT        = "camera_event"        , --隐藏觉醒特写

	EVENT_SHOW_COMBO          = "show_combo"              , --显示连击
    EVENT_MAP_MASK              = "show_mask" ,   --地图蒙层
    EVENT_ADDTO_UI_EFFECT            = "add_ui_effect"  , --显示UI层特效
	EVENT_SHOW_BATTLE_START        = "show_battle_start"  , --战斗开始动画
	EVENT_SHOW__STACE_CLEAR        = "show_stace_clear"  , --战斗开始动画
	-- EVENT_CREATE_HP_BAR            = "create_hp_bar"  , --觉醒血条
	EVENT_HERO_DEAD                = "hero_dead"  , --角色死亡
    EVENT_HERO_REMOVE                = "hero_remove"  , --角色非死亡移除

    EVENT_HERO_DEAD_BEFORE         = "hero_dead_before"  , --角色死亡前(开始渐隐小时时)
    EVENT_CAPTAIN_OFFSTAGE         = "captain_off_stage", -- 飞机 hp == 0，但还有子弹或者发射器存活
	EVENT_ADD_COMBO                = "add_combo"  , --增加连击
    EVENT_HERO_ATTR_CHANGE         = "hero_attr_change" , --角色属性变更
    EVENT_HERO_BORN                = "hero_born", --角色出生
    EVENT_BOSS_CHANGE              = "hero_boss_change" , --boss变更通知UI刷新
---
	EVENT_VKSTATE_CHANGE           = "vk_state_change" , --技能按钮状态变更
	EVENT_CAPTAIN_CHANGE           = "captain_change"  , --队伍队长变更
    EVENT_HP_CHANGE                = "hp_change" ,   --血量变更
    EVENT_LOSE_HP                  = "lose_hp" ,   --失血
    EVENT_NOTICE_HP                = "notice_hp" , --总血量
    EVENT_GETHIT                   = "get_hit" ,   --受到攻击、、
    EVENT_HIT                      = "do_hit" ,   --发动攻击、、
    EVENT_PICKUP                   = "pickup" ,   --拾取道具
    EVENT_HIT_BLUR                 = "hit_blur" ,   --攻击特效
    EVENT_HIT_BLAST                = "hit_blast" ,   --攻击特效
    EVENT_FALL                     = "fall" ,   --被击到
    EVENT_SKILL_AWAKE              = "skill_awake" ,   --使用觉醒技能
    EVENT_SKILL_DODGE              = "skill_dodge" ,   --使用闪避技能
    EVENT_SKILL                    = "skill" ,   --使用大招
    EVENT_SKILL_ENTER_KILL         = "skill_enter_kill" ,   --使用入场技能击杀
    EVENT_SKILL_AWAKE_KILL         = "skill_awake_kill" ,   --使用觉醒技能击杀
    EVENT_HERO_BATTLE              = "hero_battle" ,   --角色参战
    EVENT_GUIDE_TRIGGER            = "guide_trigger",   --战斗引导触发
    EVENT_GUIDE_END                = "guide_end",   --战斗引导结束
    EVENT_GUIDE_SKIP               = "guide_skip",   --战斗引导跳过操作
    EVENT_GUIDE_ACTION             = "guide_action",  --战斗引导操作
    EVENT_ASSIT_COUNT_DOWN         = "assit_count_down",  --战斗倒计时
    EVENT_FIX_CAMERA_Z             = "fix_camera_z",  --摄像机远近控制
    EVENT_PAUSE                    = "pause",    -- 暂停
    EVENT_RESUME                   = "resume",    -- 恢复
    EVENT_LEAVE                    = "leave",    -- 离开
    -- EVENT_CLOSE_NET_WATI           = "close_net_wait",    --关闭网络等待UI
    EVENT_SHOW_REVIVE_BOX          = "show_revive_box",    --显示复活二次确认框
    EVENT_BUFFER_EFFECT_ICON       = "buffer_effect_icon",    --buffer 效果图标
    EVENT_SHOW_ASSIT               = "show_assit",         -- 助战报幕

    ----------
    EVENT_KEYBOARD_SHOW            = "keyboardshow", --键盘显示事件
    EVENT_BATTLE_UI_SHOW           = "battle_ui_show", --战斗UI显示事件
    EVENT_VISUAL_HERO_ADD_TO_LAYER = "visual_hero_add_to_layer", --添加假人
    EVENT_PREWARTIP_SHOW           = "prewartip_show", --显示战斗目标
    EVENT_INITED_TEAM              = "inited_team", --初始化完成队伍
    EVENT_GATHER_BAR_UPDATE        = "gather_bar_update", --蓄力条更新
    EVENT_KILL_SCORE               = "event_kill_score", -- 击杀积分

    EVENT_CHANGE_MAP_SPEED         = "event_change_map_speed", --增加地图滚动速度
    EVENT_MAP_SCROLL_SWITCH        = "event_map_scroll_switch", -- 地图滚动开关

    EVENT_SHOW_COUNTDOWN           = "event_show_countdown", -- 显示倒计时

    EVENT_TEAM_PLAYER_LOAD_STATUS  = "team_player_load_status", -- 组队玩家加载进度

    EVENT_TEAM_FIGHT_END           = "team_fight_end", -- 组队退出处理(在加载界面收到消息的话强制退出)

    EVENT_MONSTER_WARNING          = "event_monster_warning", --下一波怪将要出现的预警时间

    EVENT_SHOW_KEYLIST             = "event_show_keylist", --显示出招表
    EVENT_BATTLE_TIPS              = "event_battle_tips", --显示事件提示

    EVENT_TRIGGER_JUMP             = "event_trigger_jump", --地图跳转
    EVENT_CHANGE_GUNGEON           = "event_change_gungeon", --切换关卡
    EVENT_CHANGE_JUMPPOINT_STATE   = "event_change_jumppoint_state" ,--变更跳转点的状态 
    EVENT_SHOW_CHANGE_DUNGEON      = "event_showChangeDungeon" ,--显示切换副本
    EVENT_SKILLEX_REFRESH          = "event_skillex_refresh" ,--高级技能按钮刷新
    --追猎计划队伍状态刷新
    EVENT_STATUS_HERO              = "event_status_hero" ,--角色伤害刷新
    EVENT_STATUS_BOSS              = "event_status_boss" ,--boss血量刷新
    EVENT_SKILL_OVER              = "event_skill_over" ,--技能释放完成
    EVENT_WORLDROOM_LEAVE                    = "EV_LEAVE",    -- 离开
}

-- 刷怪规则
enum.eBrushMonsterType = {
    COMMON = 1,    -- 常规
    LOOP = 2,    -- 循环
    TIMING = 3,    -- 定时
    LIMIT = 4,    -- 极限
}

-- 刷怪暂停条件
enum.eBrushPauseRule = {
    ABILITY = 1,    -- 击杀能力检测
    UPPERLIMIT = 2,    -- 数量上限检测
}

-- 1、 遇到强大的敌人
-- 2、 受到巨大的伤害
-- 3、 在战场上待机一段时间
-- 4、 击杀敌人
-- 5、 战斗胜利
-- 6、 战斗失败
-- 7、 入场
-- 8、动作帧事件

-- 音效触发类型
enum.eMusicTriggerType =
{
    ENEMY_SPOTTED = 1, --遇到强大敌人
    INJURED       = 2, --受到巨大的伤害
    IDLE          = 3, --待机一段时间
    KILL          = 4, --击杀敌人
    VERTIGO       = 5, --战斗胜利
    DEFEAT        = 6, --战斗失败
    BORN          = 7, --角色切换出场
    SAME_TEAM     = 8, --同队出场
}

-- buffer 效果图标变更事件
enum.eBufferEffectIconEvent = {
    ADD             = 1, -- 添加
    REMOVE          = 2, -- 移除
    UPDATE_ADDTIMES = 3, -- 更新叠加次数
    TWINKLE         = 4, -- 倒计时闪烁处理
    RELOAD          = 5, -- 重先载入(切换队长的时候调用)
}

return enum
