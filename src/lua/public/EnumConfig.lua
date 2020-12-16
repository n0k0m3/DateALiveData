
--[[
全局配置表规则：
    1. 为了区分于其他全局，在定义枚举的时候统一以 "EC_+枚举名" 开头
    2. 必须写上注释
]]--

-- 按钮类型点击音效
EC_BTN = {
    NORMAL = 1,    -- 普通按钮
    CLOSE = 2,     -- 关闭按钮
    BACK = 3,      -- 返回按钮
}

-- 特殊道具ID
EC_SItemType = {
    GOLD = 500001,                   -- 金币
    DIAMOND = 500002,                -- 钻石
    FRIENDSHIP = 500003,             -- 友情点
    POWER = 500004,                  -- 体力
    PLAYEREXP = 500005,              -- 主角经验
    CURFAVOR = 500007,               --好感度（当前看伴娘）
    CURMOOD = 500008,                --心情值（当前看伴娘）
    SPIRITEXP = 500006,              -- 精灵经验
    DAYDATINGTIMES = 500011,         --日常约会次数
    ROLETOUCHTIMES = 500012,         --看板娘触摸次数
    ACTIVITY = 500014,               -- 活跃度
    FAVOR = 500016,                  -- 好感度（当前出战队伍角色的所有看伴娘）
    YOUXIBI = 500017,                -- 游戏币
    TIANGONGBI = 500018,             -- 天宫币
    ZHUANZHU = 500019,               -- 专注
    MEILI = 500020,                  -- 魅力
    WENROU = 500021,                 -- 温柔
    ZHISHI = 500022,                 -- 知识
    XINGYUN = 500023,                -- 幸运
    ENERGY = 500024,                 -- 精力
    FUBENFAVOR = 500027,             -- 副本约会好感度
    KABALA_ESSENCE = 570101,         -- 生命精华
    KABALA_ENERGY = 500025,          -- 空舰燃油
    CONTRIBUTION = 500031,           -- 贡献度（万由里boss）
    THEATER_COUNT = 500030,          -- 万由里boss挑战次数
    AGORA_DONATE = 500033,           -- 集会所贡献度
    UNION_REDPACKET = 500035,           -- 红包代发道具
    WORKER_CARD = 595010,            -- 员工工牌
    TRAINING_MATRIX_SCORE = 500054,  -- 特训矩阵个人积分
    TRAINING_UNION_SCORE = 500055,  -- 特训矩阵社团积分
    SX_BIRTHDAY_POWER = 500056,  -- 十香生日活动行动力
    REVERSAL = 500057,           -- 十香反转值
    LOVER = 500058,              -- 十香亲密度   
    TokenMoney = 500096,           -- 代币
	SZDY_TOUZI = 500112				-- 时之赌约骰子
}

-- 副本难度
EC_FBDiff = {
    SIMPLE = 1,    -- 简单
    HARD = 2,    -- 困难
    LIMBO = 3,    -- 地狱
}

-- 副本难度名字
EC_FBDiffName = {
    [EC_FBDiff.SIMPLE] = 300120,
    [EC_FBDiff.HARD] = 300121,
    [EC_FBDiff.LIMBO] = 300122,
}

-- 关卡类型（关卡表dungonType）
EC_FBLevelType = {
    FIGHTING = 1,    -- 战斗关卡
    DATING = 2,    -- 约会关卡
    CITYDATING = 3,    -- 外转约会
    SPRITE = 5,    -- 精灵挑战关卡
    PRACTICE = 6,    -- 练习模式
    SPRITE_EXTRA = 7, --模拟试练
    HALLOWEEN = 8, -- 万圣节活动
    THEATER_DATING = 9,    -- 万由里约会
    THEATER_FIGHTING = 10,    -- 万由里战斗
    KABALATREE = 11,    --卡巴拉战斗
    THEATER_BOSS = 12,    -- 万由里boss
    CHRISTMAS = 13,     --圣诞关卡
    DALMAP = 14,        --大凉山副本
    NIANBREAST = 15,     --年兽关卡
    TXJZ = 16,    -- 特训矩阵
    NOOBSUMMON = 17,     --萌新试玩副本
    SKYLADDER = 20,     --天梯
    HUNTER = 21,     -- 追猎计划
    TEAMFIGHT_EX_PARENT = 30,     --高级组队主关卡
    TEAMFIGHT_EX_CHILD  = 31,     --高级组队子关卡
	MONSTER_TRIAL = 35,			--魔王试炼
    KUANGSAN_FIGHTING = 40,    -- 万由里战斗
    KUANGSAN_DATING = 41,    -- 万由里约会
    NEWYEAR_DATING = 41,     --新年魔禁约会
    HWX_DATING = 41,            --海王星约会由于表现一样所以还是用一个ID，加个枚举为看扩展
    HWX = 42,                   --海王星
    HWX_TOWER = 43,             --海王星爬塔
    MUSIC_GAME = 44,             --端午音律游戏
	WORLD_BOSS = 45,           -- 社团世界Boss
    BOSS_CHALLENGE = 46,           -- Boss挑战
}

-- 万由里关卡类型
EC_TheaterLevelType = {
    NONE = 1,    -- 引子
    MAIN_DATING = 2,    -- 主线约会
    MAIN_FIGHTING = 3,    -- 主线战斗
    BRANCH_DATING = 4,    -- 支线约会
    BRANCH_FIGHTING = 5,    -- 支线战斗
    OPTION = 6,    -- 选项
    CG_DATING = 7,    -- CG约会
    CONDITION = 8,    -- 条件
    LAST_FIGHTING = 9,    -- 最后战斗
    FIGHTRESULT = 10,    -- 战斗结果分支
    BOSS_ENTANCE = 11,    -- boss入口
    BOSS_FIGHT = 12,    -- boss入口
    BOSS_FIGHT1 = 13,    -- boss入口
    BOSS_JUNAI = 14,    -- 鞠奈boss入口
    LAST_DATING = 15,    -- 最后的约会关卡
}

-- 万由里boss类型
EC_TheaterBossType = {
    LINGBO = 1,    -- 灵波值
    PERMANENT = 2,    -- 常驻
}

-- 万由里开放状态
EC_TheaterStatus = {
    CLOSING = 0,    -- 关闭期
    ING = 1,    -- 进行期
    CLEARING = 2,    -- 结算期
}

-- 万由里奖励领取状态
EC_TheaterReceiveStatus = {
    ING = 0,    -- 进行中
    GET = 1,    -- 可领取
    GETED = 2,    -- 已领取
}

-- 关卡组类型(DungeonLevelGroup dungeonType)
EC_FBLevelGroupType = {
    MAINLINE = 1,    -- 主线
    NORMAL = 2,    -- 普通
    DAILY = 3,    -- 日常
    THEATER = 9,    -- 万由里
    KUANGSAN = 23,  -- 狂三
    LINKAGE = 100,  -- 海王星联动
    LINKAGEHWX = 103, --海王星下卷联动
}

-- 副本类型(Dungeonchapter type字段)
EC_FBType = {
    PLOT = 1,    -- 剧情副本
    DAILY = 2,    -- 日常副本
    THEATER = 3,    -- 剧场
    ACTIVITY = 4,    -- 活动作战
    HOLIDAY = 5,    -- 节日活动
    THEATER_BOSS = 6,    -- 万由里boss
    THEATER_HARD = 7,    -- 万由里困难
	MONSTER_TRIAL = 8,    -- 魔王试炼
    NIANBREAST_LEVEL = 15,    -- 年兽抓捕
    SKYLADDER = 16,     --天梯
    HUNTER = 21,     --追猎计划
    LINKAGE = 22, -- 海王星联动
    MEMORY = 31,     --周年庆回忆关卡
	HOLIDAY2 = 1001, --
	KSAN_FUBEN = 23,    --狂三副本
	NEWYEAR_FUBEN = 24,
    HWX_FUBEN = 25,     --海王星副本
    WORLD_BOSS = 45,    -- 社团世界Boss
}

-- 活动副本id
EC_ActivityFubenType = {
    ENDLESS = 401,    -- 无尽副本
    TEAM = 402,    -- 组队副本
    KABALA = 403,   --卡巴拉
    SPRITE = 404,    -- 精灵挑战
    SPRITE_EXTRA = 405, --精灵外传
    HALLOWEEN = 406,    -- 万圣节活动
    TEAM_PVE = 407,     -- 春季特训
    SKYLADDER = 408,    --天梯
	MONSTER = 421,		--魔王试炼
    CHRISTMAS = 901,    -- 圣诞节活动
    NEWYEAR = 1001,    -- 新年活动
    BIG_WORLD = 409,     -- 大世界
    SIMULATION_TRIAL = 411,     -- 模拟试炼活动
    SIMULATION_TRIAL_2 = 412,     -- 模拟试炼活动
    SIMULATION_TRIAL_3 = 413,     -- 模拟试炼活动
    SIMULATION_TRIAL_4 = 414,     -- 模拟试炼活动
    SIMULATION_TRIAL_5 = 416,     -- 模拟试炼活动
	HALLOWEEN2019 = 415,	--万圣节活动2019
    BOSS_CHALLENGE = 422,    --BOSS挑战入口
}

-- 活动副本
EC_DailyType = {
    EXP = 200001,    -- 经验大作战
    GOLD = 200002,    -- 金币大作战
    PRAY = 200003,    -- 祈愿大作战
    ZHIDIAN = 200004,    -- 质点大作战
    XINWU= 200005, --信物大作战
}

-- 副本类型
EC_DISPATCHType = {
    DAILY = 1,    -- 日常副本
    SPRITE = 2,    -- 精灵试炼
    THEATER = 3,    -- 雷霆圣堂
    TEAM = 4,    -- 联机副本
    DATING = 5,  --约会
}

-- 战斗类型
EC_BattleType = {
    COMMON = 1,    -- 普通模式
    ENDLESS = 2,    -- 无尽模式
    TEAM_FIGHT = 3,    -- 组队模式
    HIGH_TEAM_FIGHT = 30,    -- 高级组队模式
}

-- 无尽模式状态
EC_EndlessState = {
    READY = 0,    -- 准备期
    ING = 1,    -- 进行期
    CLEARING = 2,    -- 结算期
}

-- 无尽模式关卡类型
EC_EndlessLevelType = {
    BOSS = 1,    -- BOSS
    SPRITE = 2,    -- 精灵
    ELITE = 3,    -- 精英
    SOLIDER = 4,    -- 杂兵
}

-- 无尽模式状态字符串
EC_EndlessStateStr = {
    [EC_EndlessState.READY] = 2100019,
    [EC_EndlessState.ING] = 2100020,
    [EC_EndlessState.CLEARING] = 2100021,
}

-- 关卡胜利条件
EC_LevelPassCond = {
    DESTORY = 1,    -- 歼灭
    SURVIVAL = 2,    -- 生存
    SPECIFICID = 3,    -- 指定怪物id
    SPECIFICTYPE = 4,    -- 指定怪物类型
    SPECIFICCOUNT = 5,    -- 指定怪物数量
    GUARDMODE = 6,    -- 守护模式
    WAVE      = 7,    --波次
    PRACTICE = 8,    -- 连续
    HALLOWEEN_DESTORY = 9,    -- 万圣节活动(歼灭模式)
    SURVIVAL_HURT = 10,    -- 生存(统计伤害)
    GUARDMODE_EX = 11,    -- 新守护模式(带波次显示)
    SCORE = 12,    -- 积分模式(组队)
    SCORE2= 13 , --积分模式二
    GUARDMODE_3 = 14,    -- 守护模式(恢复守护对象生命值)
    LIMIT_TIME_KILL = 15,    -- 限时杀怪
    COMBO_COUNT = 16,    -- 连击数
    SCORE3 = 17,    -- 日常副本积分
    LIMIT_TIME_KILL2 = 18, -- 日常副本(限时杀怪)
    TIMING = 19,  -- 日常副本计时
}

-- 主线剧情类型
EC_MainLineType = {
    LEVEL = 1,                  -- 关卡
    VIDEO = 2,                  -- 视频
    DIALOGUE = 3,               -- 对话剧本
    CG = 4,                     -- CG动画
}

-- 副本评分星星数规则
EC_FBStarRule = {
    PASS = 1,    -- 通关
    COMBO = 2,    -- 连击
    TIME = 3,    -- 时间
    HP = 4,    -- 血量
    DEATH = 5,    -- 死亡人数
    HIT = 6,    -- 受击次数
    FALL = 7,    -- 倒地次数
    SKILL_AWAKE = 8 ,   --使用x次觉醒技能
    SKILL_ENTER_KILL = 9 ,   --使用角色出场技击败x个敌人
    ASSIST      = 10,   --选择一个助战角色
    HERO_BATTLE        = 11,   --队伍中包含某角色(助战不算)
    LIMIT_KILL         = 12,   --X秒里必须杀死1个敌人
    SKILL_COUNT        = 13,   --使用总技能次数(只包含觉醒和大招)
    TEAM_DEATH         = 14,   --队伍中不能有队员死亡
    GET_MONSTER_ITEM   = 21,    --吃到X个怪物道具
    GET_MONSTER_ITEM_COM = 22,  --连续吃到X个怪物道具
    PASS_LEVEL_NO_ITEM = 23,    --不吃道具通关
    KILL_COUNT = 31,    -- 击杀怪物数量
    SCORE = 32,    -- 积分
    SKILL_DODGE = 33 ,   --使用x次闪避技能
    NOT_USE_DODGE = 34 ,   --不使用闪避技能
    SCORE3 = 35 ,   --日常副本积分
    MORE_REMAINING_TIME = 36, --剩余时间大于 
    SKILL_AWAKE_KILL = 37, --使用觉醒技击杀x个怪
}

EC_FBStarRuleStr = {
    [EC_FBStarRule.PASS] = 300051,
    [EC_FBStarRule.COMBO] = 300052,
    [EC_FBStarRule.TIME] = 300053,
    [EC_FBStarRule.HP] = 300054,
    [EC_FBStarRule.DEATH] = 300055,
    [EC_FBStarRule.HIT] = 300056,
    [EC_FBStarRule.FALL] = 300057,
    [EC_FBStarRule.SKILL_AWAKE] = 300058,
[EC_FBStarRule.SKILL_ENTER_KILL] = 300059,
[EC_FBStarRule.SKILL_AWAKE_KILL] = 300071,
    [EC_FBStarRule.ASSIST] = 300060,
    [EC_FBStarRule.HERO_BATTLE] = 300061,
    [EC_FBStarRule.LIMIT_KILL] = 300062,
    [EC_FBStarRule.SKILL_COUNT] = 300063,
    [EC_FBStarRule.TEAM_DEATH] = 300064,
    [EC_FBStarRule.KILL_COUNT] = 300065,
    [EC_FBStarRule.SCORE] = 300066,
    [EC_FBStarRule.SKILL_DODGE] = 300067, --使用x次闪避技能
    [EC_FBStarRule.NOT_USE_DODGE] = 300068, --不使用闪避技能
    [EC_FBStarRule.SCORE3] = 300069,
    [EC_FBStarRule.MORE_REMAINING_TIME]  = 300070,--剩余时间大于
    [EC_FBStarRule.GET_MONSTER_ITEM]  = 300071,
    [EC_FBStarRule.GET_MONSTER_ITEM_COM]  = 300072,
    [EC_FBStarRule.PASS_LEVEL_NO_ITEM]  = 300073,
}

-- 服务器操作类型
EC_SChangeType = {
	DEFAULT = 0,        -- 默认
	ADD = 1,            -- 新增
	DELETE = 2,         -- 删除
	UPDATE = 3,         -- 更新
}

-- 基础属性表
local __baseAttr = {
    HP = 1,                 -- 最大生命
    ATK = 2,                -- 攻击
    DEF = 3,                -- 防御
    DMADD = 4,              -- 固定增伤
    DMSUB = 5,              -- 固定减伤
    SPD = 6,                -- 攻速
    SLD = 7,                -- 护盾
    MAX_AGR = 8,            -- Max怒气
    RECOVER_AGR = 9,        -- 怒气恢复值
    COST = 10,              -- 负重
    MOVE_SPEED = 11,        -- 移动速度(新增)
    MOVE_SAB = 12,          -- 破防(新增)
    ATTR_SKILL_POINT = 13,  -- 天使技能点
    ENERGY_POINT = 19,      -- 灵力点

--固定百分比属性

    DMADD_PER = 501,         -- 增伤率(新增)
    DMSUB_PER = 502,         -- 减伤率(新增)
    PREICE = 503,            -- 穿透率
    PARRY = 504,             -- 格挡率
    HIT = 505,               -- 命中率
    DODGE = 506,             -- 闪避率
    CRIT = 507,              -- 暴击率
    UNCRIT = 508,            -- 抗暴率
    HADD = 509,              -- 暴伤率
    HSUB = 510,              -- 暴免率
    CTRL = 511,              -- 控制时间
    UNCTRL = 512,            -- 受控时间
    BUFF = 513,              -- 增益时间
    DEBUFF = 514,            -- 减益时间


}
local BASE_VAL = 1000
-- 属性表
EC_Attr = {
    HP_RATIO = BASE_VAL + __baseAttr.HP,        -- 生命加成比 - 1001
    ATK_RATIO = BASE_VAL + __baseAttr.ATK,        -- 攻击加成比 - 1002
    DEF_RATIO = BASE_VAL + __baseAttr.DEF,        -- 防御加成比 - 1003
    DMADD_RATIO = BASE_VAL + __baseAttr.DMADD,        -- 防御加成比 - 1004
    DMSUB_RATIO = BASE_VAL + __baseAttr.DMSUB,        -- 减伤加成比 - 1005
    SPD_RATIO = BASE_VAL + __baseAttr.SPD,        -- 攻速加成比 - 1006
    SLD_RATIO = BASE_VAL + __baseAttr.SLD,        -- 护盾加成比 - 1007
    PREICE_RATIO = BASE_VAL + __baseAttr.PREICE,        -- 穿透加成比 - 1008
    PARRY_RATIO = BASE_VAL + __baseAttr.PARRY,        -- 格挡加成比 - 1009
    COST_RATIO = BASE_VAL + __baseAttr.COST,           -- 负重加成比 - 1023
}
for k, v in pairs(__baseAttr) do
    EC_Attr[k] = v
end
for k, v in pairs(EC_Attr) do
    EC_Attr[v] = k
end

-- 属性显示文本id（String表）
EC_AttrText = {
    [EC_Attr.HP] = 11001,
    [EC_Attr.ATK] = 11002,
    [EC_Attr.DEF] = 11003,
}

--hero品质字符串
EC_HeroQuality = {
    [1] = "B",
    [2] = "A",
    [3] = "AA",
    [4] = "AAA",
    [5] = "S",
    [6] = "SS",
    [7] = "SSS"
}

EC_HeroQualityPic = {
    [1] = "ui/399.png",
    [2] = "ui/398.png",
    [3] = "ui/398.png",
    [4] = "ui/398.png",
    [5] = "ui/397.png",
    [6] = "ui/539.png",
    [7] = "ui/775.png"
}

EC_HeroQualitySmallPic = {
    [1] = "ui/836.png",
    [2] = "ui/835.png",
    [3] = "ui/835.png",
    [4] = "ui/835.png",
    [5] = "ui/834.png",
    [6] = "ui/833.png",
    [7] = "ui/832.png"
}

-- 道具品质
EC_ItemQuality = {
    WHITE = 1,             -- 白色
    GREEN = 2,             -- 绿色
    BLUE = 3,              -- 蓝色
    PURPLE = 4,            -- 紫色
    ORANGE = 5,            -- 橙色
    RED   = 6,             -- 红色
    GOLD = 7,              -- 金色
}

--
EC_EquipBoard = {
    [EC_ItemQuality.WHITE] = "ui/Equipment/new_ui/bg_normal.png",
    [EC_ItemQuality.GREEN] = "ui/Equipment/new_ui/bg_green.png",
    [EC_ItemQuality.BLUE] = "ui/Equipment/new_ui/bg_blue.png",
    [EC_ItemQuality.PURPLE] = "ui/Equipment/new_ui/bg_purp.png",
    [EC_ItemQuality.ORANGE] = "ui/Equipment/new_ui/bg_yellow.png",
    [EC_ItemQuality.RED] = "ui/Equipment/new_ui/bg_red.png",
}

EC_EquipFrame = {
    [EC_ItemQuality.WHITE] = "ui/Equipment/new_ui/frame_normal.png",
    [EC_ItemQuality.GREEN] = "ui/Equipment/new_ui/frame_green.png",
    [EC_ItemQuality.BLUE] = "ui/Equipment/new_ui/frame_blue.png",
    [EC_ItemQuality.PURPLE] = "ui/Equipment/new_ui/frame_purp.png",
    [EC_ItemQuality.ORANGE] = "ui/Equipment/new_ui/frame_yellow.png",
    [EC_ItemQuality.RED] = "ui/Equipment/new_ui/frame_red.png",
}

-- 道具Icon
EC_ItemIcon = {
    [EC_ItemQuality.WHITE] = "ui/common/frame_normal.png",
    [EC_ItemQuality.GREEN] = "ui/common/frame_green.png",
    [EC_ItemQuality.BLUE] = "ui/common/frame_blue.png",
    [EC_ItemQuality.PURPLE] = "ui/common/frame_purp.png",
    [EC_ItemQuality.ORANGE] = "ui/common/frame_yellow.png",
    [EC_ItemQuality.RED] = "ui/common/frame_red.png",
    [EC_ItemQuality.GOLD] = "ui/common/frame_jin.png",
}

EC_ItemLevelIcon = {
    [EC_ItemQuality.WHITE] = "ui/common/level_normal.png",
    [EC_ItemQuality.GREEN] = "ui/common/level_green.png",
    [EC_ItemQuality.BLUE] = "ui/common/level_blue.png",
    [EC_ItemQuality.PURPLE] = "ui/common/level_purp.png",
    [EC_ItemQuality.ORANGE] = "ui/common/level_yellow.png",
    [EC_ItemQuality.RED] = "ui/common/level_red.png",
    [EC_ItemQuality.GOLD] = "ui/common/level_jin.png",
}

--道具品质颜色icon
EC_ItemQualityColoricon = {
    [EC_ItemQuality.WHITE] = "ui/349.png",
    [EC_ItemQuality.GREEN] = "ui/353.png",
    [EC_ItemQuality.BLUE] = "ui/350.png",
    [EC_ItemQuality.PURPLE] = "ui/351.png",
    [EC_ItemQuality.ORANGE] = "ui/352.png",
}

-- 道具品质颜色值
EC_ItemQualityColor = {
    [EC_ItemQuality.WHITE] = ccc3(0xff, 0xff, 0xff),
    [EC_ItemQuality.GREEN] = ccc3(0xa4, 0xff, 0xa8),
    [EC_ItemQuality.BLUE] = ccc3(0xa4, 0xef, 0xff),
    [EC_ItemQuality.PURPLE] = ccc3(0xfa, 0xa4, 0xff),
    [EC_ItemQuality.ORANGE] = ccc3(0xff, 0xfc, 0xa4),
    [EC_ItemQuality.RED] = ccc3(0xff, 0x9f, 0x9f),
}

EC_EQUIP_STEP_COLOR = {
    [EC_ItemQuality.WHITE] = ccc3(255, 255, 255),
    [EC_ItemQuality.GREEN] = ccc3(162, 240, 224),
    [EC_ItemQuality.BLUE] = ccc3(154, 216, 255),
    [EC_ItemQuality.PURPLE] = ccc3(232, 183, 255),
    [EC_ItemQuality.ORANGE] = ccc3(253, 251, 166),
    [EC_ItemQuality.RED] = ccc3(255, 184, 214),
}

-- 道具品质颜色值
EC_ItemQualityhexColor = {
    [EC_ItemQuality.WHITE] = "#FFFFFF",
    [EC_ItemQuality.GREEN] = "#A4FFA8",
    [EC_ItemQuality.BLUE] = "#A4EFFF",
    [EC_ItemQuality.PURPLE] = "#FAA4FF",
    [EC_ItemQuality.ORANGE] = "#FFFCA4",
    [EC_ItemQuality.RED] = "#FF9F9F",
}

-- 道具品质特效(无白绿蓝)
EC_ItemQualityEffect = {
    [EC_ItemQuality.PURPLE] = {bg = "effect_props_purple_down", up = "effect_props_purple_up", up2 = "effect_props_purple_up2"},
    [EC_ItemQuality.ORANGE] = {bg = "effect_props_orange_down", up = "effect_props_orange_up", up2 = "effect_props_orange_up2"},
    [EC_ItemQuality.RED] = {bg = "effect_props_powder_down", up = "effect_props_powder_up", up2 = "effect_props_powder_up2"},
    [EC_ItemQuality.GOLD] = {bg = "effect_props_yellow_down", up = "effect_props_yellow_up", up2 = "effect_props_yellow_up2"},
}

-- 道具Icon（显示数量）
EC_ItemCIcon = {
    [EC_ItemQuality.WHITE] = "ui/091.png",
    [EC_ItemQuality.GREEN] = "ui/092.png",
    [EC_ItemQuality.BLUE] = "ui/093.png",
    [EC_ItemQuality.PURPLE] = "ui/094.png",
    [EC_ItemQuality.ORANGE] = "ui/095.png",
}

-- 背包类型
EC_Bag = {
    HERO = 1,              -- 英雄背包
    SPIRIT = 2,            -- 灵装背包(质点)
    ANGEL = 3,             -- 天使背包(武器)
    DRESS = 4,             -- 时装背包
    MATERIAL = 5,          -- 材料背包(材料)
    ITEM = 6,              -- 道具背包(材料)
    GIFT = 7,              -- 礼物背包(材料)
    HOUSE = 8,             -- 家居背包(材料)
    USEITEM = 9,           -- 可使用道具
    CG = 10,               -- CG
    SKIN = 11,             -- 皮肤背包(碎片)
    NEWCITY = 12,           -- 城建背包
    NEWEQUIP = 13,          --新装备
    BAOSHI = 14,          --宝石
    COURAGE_EQUIP = 15,      --试胆大会装备背包
    COURAGE_MATERIAL = 16,      --试胆大会材料背包
    COURAGE_FOOD = 17,      --试胆大会食物背包
    CRYSTYL = 18,       --------结晶
    FRAGMENT = 19,       --------碎片
    DRAWING = 20,       --------图纸
    MATERIAL_OTHER = 21,    --结晶碎片图纸之外其他材料
    EXPLORE_TREASURE = 22,   --探索背包
    EXPLORE_MATERIAL = 23,   --探索背包
    TRAILCARD = 32,          --试用卡
    SKYLADDER_CARD = 40,   -- 天梯卡牌
    TRAILBAG = 50,   --试用道具背包
    DFW_CARD = 95 -- 大富翁道具卡背包
}

-- 背包分类
EC_BagCategory = {
    ANGEL = 1,    -- 天使
    EQUIPMENT = 2,    -- 灵装
    MATERIAL = 3,    -- 材料
    ITEM = 4,    -- 道具
    NEWEQUIP = 5,  --新装备
    TRAILCARD = 6,  --新装备
    BAOSHI = 7,  --宝石
}

-- 道具出售类型
EC_BagSellType = {
    MULTISELECT = 1,    -- 多选（道具可选，数量固定）
    SINGLESELECT = 2,    -- 单选（道具固定，数据可选）
}

-- 资源类型
EC_ResourceType = {
    HERO = 1,              -- 英雄
    SPIRIT = 2,            -- 灵装
    ANGEL = 3,             -- 天使
    DRESS = 4,             -- 时装
    NUMBERIC = 5,          -- 数值资源
    MATERIAL = 6,          -- 功能材料
    ITEMGIFT = 7,          -- 道具礼包
    GIFT = 8,              -- 礼物
    HOUSE = 9,             -- 家居
    SKIN = 10,             -- 皮肤
    REWARD = 11,           -- 奖励
    MEDAL = 12,            -- 勋章
    OUTSIDEITEM = 14,      --外传物品
    MAINLINEITEM = 15,      --主线物品
    AVATAR = 16,            --头像
    FETTERS = 17,            --羁绊
    AVATAR_FRAME = 18,            --相框
    UNION_EXP = 19,            --社团活跃
    UNION_REDPACKET = 20,            --社团红包代发道具
    UNION_CONTRIBUTION = 23,            --社团贡献
    UNION_TRAIN_SCORE = 24,         --特训积分
    MAKEFOOD = 22,         --料理制作
    KABALA = 31,           --卡巴拉道具
    DLS = 32,    -- 大凉山道具
    TRAILCARD = 33,    -- 试用卡
    TRAILSKIN = 35,
    PHONE_AI = 37,          --手机Ai道具
    CHENGHAO = 38,          --称号
    SKYLADDER = 40,        --天梯
    BAOSHI = 43,    -- 宝石
    BAOSHITUZHI = 44,    -- 宝石图纸
    EXPLORE_TREASURE = 45, -- 探索系统宝物
    EXPLORE_TREASUREPIECE = 46, -- 探索系统碎片
    EXPLORE_ACCESSORIES = 47,         --探索系统配件
    HUNTINGINVITATIONCARD = 50, -- 悬赏令
    COURAGE_EQUIP = 60,     --试胆大会装备
    COURAGE_ITEM = 61,     --试胆大会普通道具
    COURAGE_USEITEM = 63,     --试胆大会可以使用道具
    FIRST_RECHARGE_ITEM = 66,   --首冲重置券
    CONTRACT_ITEM = 67,         --精灵锲约重置券
    ACTIVITY_ITEM = 71,         --活动道具类型
    DFW_NEW_CARD = 1001,        -- 新-大富翁道具卡
}

-- 资源条类型
EC_TopbarType = {
    GOLD = 1,              -- 金币
    DIAMOND = 2,           -- 钻石
    POWER = 3,             -- 体力
}

-- 资源条配置
EC_TopbarResource = {
    [EC_TopbarType.GOLD] = {
        icon = "ui/mainLayer/coin.png",
        txt = "ui/mainLayer/gold_txt.png",
        itemId = EC_SItemType.GOLD,
    },
    [EC_TopbarType.DIAMOND] = {
        icon = "ui/mainLayer/zuan.png",
        txt = "ui/mainLayer/diamond_txt.png",
        itemId = EC_SItemType.DIAMOND,
    },
    [EC_TopbarType.POWER] = {
        icon = "ui/mainLayer/tili.png",
        txt = "ui/mainLayer/strength_txt.png",
        itemId = EC_SItemType.POWER,
    },
}

-- 1.公共,2.私聊;3.帮派
EC_ChatType = {
    WORLD   = 1,    -- 公共
    PRIVATE = 2,    -- 私聊
    GUILD   = 3,    -- 帮派
    SYSTEM  = 4,    -- 系统消息
    TEAM    = 5,    --组队
    TEAM_YQ = 6,    --邀请组队
    COURAGE = 7,    --试胆大会
    RED_PACK = 8,   --红包
    BIG_WORLD = 10,   --同屏(客户端)
	DRESSWEEK = 11,  -- 时装周
    VOTE = 12,  -- 投票
}

EC_GroupType = {
	ALL = 1,
	Friend = 2
}
EC_GroupStatus = {
	NoStart = -1,
	ING = 0,
	CANGET = 1,
	FINISH = 2
}
EC_GroupOpenPanel = {
	Hall = 1,
	Room =2,
	Invit = 3,
	Create = 4
}

EC_ChatState = {
    CHAT = 1,       --聊天
    TEAM = 2,       --组队
    RED_PACK = 3,       --红包
    MARQUEE = 4,       --跑马灯
    RED_PACK_RECORD = 5,       --红包领取记录
    SYSTEM = 6,                 --系统消息
    HERO_SHARE = 7,                 --精灵分享
    RED_PACK1 = 8,                 --红包1
    RED_PACK_RECORD1 = 9,       --红包领取记录1
	GROUP_PURCHASE = 10,  --团购邀请
    AI_ROBOT = 999,    --Ai机器人(未经服务器)
    AI_ADVICE = 1000,  -- AI通知
}

--好感度等级描述
EC_FavorType = {
    [1] = 10016, --陌生
    [2] = 10017, --友善
    [3] = 10018, --信赖
    [4] = 10019, --亲密
    [5] = 10020, --恩爱
}

-- 商店刷新类型
EC_StoreFlushType = {
    NORMAL = 1,         -- 普通商店（固定商场)
    RANDOM = 2,         -- 随机商店
}

-- 商店限购类型
EC_StoreBuyLimit = {
    NONE = 0,    -- 不限购
    TIME = 1,    -- 刷新时间内限购
    DAY = 2,    -- 本天内限购
    FOREVER = 3,    -- 永久限购
    WHOLESERVER = 5,    -- 全服限购
}

EC_StoreLimitString = {
    [EC_StoreBuyLimit.NONE] = 15010107,
    [EC_StoreBuyLimit.TIME] = 15010108,
    [EC_StoreBuyLimit.DAY] = 15010109,
    [EC_StoreBuyLimit.FOREVER] = 15010110,
    [EC_StoreBuyLimit.WHOLESERVER] = 15010111,
}

-- 商店
EC_StoreType = {
    SUPPLY = 1,    -- 补给
    CITY = 2,    -- 城建
    BIRTHDAY = 4,    -- 生日商店
    SUPPORT_LIMIT = 5,    -- 特勤支援限时
    SUPPORT_FIXED = 6,    -- 特勤支援常驻
    DAFUWENG = 7,    -- 大富翁兑换
    SX_BIRTHDAY = 8,    -- 十香生日活动
    DUANWU = 9,    -- 端午粽子制作
    SUMMER = 10,        --夏日祭
    COURAGE = 11,   --试胆大会
    TWOYEAR = 12,   --2周年商店
    NEW_SUPPORT = 15, -- 新特勤支援
    ZNQ = 30 --周年庆
}

-- 商店购买记录信息类型
EC_StoreBuyLogType = {
    PERSONAL = 1,    -- 个人
    WHOLESERVER = 2,    -- 全服
}

--灵装SubType
EC_EquipSubType = {
    Kether = 1,         --王冠（攻速）
    Chokhmah = 2,       --智慧（抗暴）
    Binah = 3,          --理解（爆击）
    Chesed = 4,         --仁爱（闪避）
    Geburah = 5,        --严格（命中）
    Tiphareth = 6,      --美丽（HP）
    Netzach = 7,        --胜利（防御）
    Hod = 8,            --光辉（攻击）
    Yesod = 9,          --基础（怒气）
    Malkuth = 10,       --王国（护盾）
    Daat = 100,         --知识
    Wanneng = 101,      --万能材料质点
}

-- 社团成员操作
EC_UNIONType = {
    APLY = 1,      -- 申请加入
    QUIT = 2,      -- 退出
    ASSENT = 3,    -- 同意加入
    DECLINE = 4,   -- 拒绝申请
    KICK = 5,      -- 踢人
    TRANSFER = 6,  -- 转让团长
    FAST_JOIN = 7, --快速加入
    IMPEACH_LEADER = 8, --弹劾团长

}

-- 社团信息修改
EC_UNION_EDIT_Type = {
    FLAG = 1,              -- 修改社团徽记
    PROCLAMATION = 2,      -- 修改社团公告
    OPEN_APLY = 3,            -- 变更是否开启社团申请
    OPEN_AUTO_JOIN = 4,           -- 变更是否开启自动加入
    OPEN_JOIN_LIMIT = 5,           -- 变更加入限制
    DELATE_LEADER = 6,           -- 弹劾团长
    EXP_LEVEL_UPDATE = 7,           -- 经验等级变更
    WEEK_EXP_UPDATE = 8,           -- 周活跃经验变更
    DAILY_RESET = 9,           -- 跨天重置
    WEEK_RESET = 10,           -- 跨周重置
    RED_PACKET_COUNT = 11,           -- 社团红包数量更新
    TRAIN_THEME_ID = 12,           -- 特训主题ID
    TRAIN_UNION_SCORE = 13,           -- 特训社团积分
    TRAIN_REMAIN_TIMES = 14,           -- 特训剩余次数
    MODIFY_NAME = 15,          -- 修改社团名字
    MORALE_UPDATE = 16,        -- 世界boss士气更新
    CHANGE_COUNTRY = 28,     --国家修改设置
    SHOW_COUNTRY = 29,        --是否显示国家
}

-- 社团职位类型
EC_UNION_DEGREE_Type = {
    HEAD = 1,              -- 团长
    DEPUTY_HEAD = 2,      -- 副团长
    ELITE = 3,            -- 精英
    MEMBER = 4,           -- 成员
}

-- 社团职位权限
EC_UNION_PERMISSION_Type = {
    EDIT = 1,                   -- 编辑社团信息
    APPLY = 2,                  -- 管理加入申请
    IMPEACH = 3,                -- 发起弹劾
    CHANGE_DEGREE = 4,          -- 变更职位
    KICK = 5,                   -- 踢出成员
    CHANGE_FLAG = 6,            -- 旗帜
    OPEN_APPLY = 7,             -- 开放申请
    OPEN_LIMIT = 8,             -- 开放加入限制
    OPEN_AUTO_JOIN = 9,         -- 开放自动加入
}

-- 社团设置类型
EC_UNION_SETTING_Type = {
    OPEN_APPLY = 1,              -- 开放申请
    LIMIT_JOIN = 2,              -- 开放限制条件
    AUTO_JOIN = 3,               -- 开放自动加入
    SHOW_COUNTRY = 4,            -- 显示国家
}

EC_UNION_NOTIFY_Type = {
    CREATE = 1,                -- 创建社团 %s创建了社团
    JOIN = 2,                  -- 玩家加入社团 %s加入了社团
    QUIT = 3,                  -- 玩家离开社团 %s离开了社团
    DEGREE = 4,                -- 职位任命 %s被团长/副团长任命为%s 
    CHANGE_LEADER = 5,         -- 团长禅让 原团长%s将职位让于%s，祝贺%s成为本团新任团长
    LEADER_IMPEACH = 6,        -- 团长弹劾 因团长长时间不在线，%s发起了社长弹劾，请大家踊跃竞选
    LEADER_DELATE_FAIL = 7,    -- 弹劾终止 团长%s回归，弹劾终止
    LEADER_IMPEACH_SUCC = 8,   -- 弹劾结果 由%s发起的团长弹劾，最终由%s当选，成为本团新的团长 
    BUY_PACKAGE = 9,           -- 购买社团礼包 %s购买了%s礼包，为社团贡献了%d点活跃 
    LEVEL_UP = 10,              -- 社团升级 在大家的共同努力下，社团已达到%d级
    BUY_DONATE = 11,            -- 社团贡献 %s进行了%s，获得了%d点社团贡献
}

EC_BuidingType = {
    FUSION = 1,              -- 核心聚变器
}

EC_EquipSubTypeIconBig = {
    [EC_EquipSubType.Kether] = "icon/equipment/type_big/Kether.png",
    [EC_EquipSubType.Chokhmah] = "icon/equipment/type_big/Chokhmah.png",
    [EC_EquipSubType.Binah] = "icon/equipment/type_big/Binah.png",
    [EC_EquipSubType.Chesed] = "icon/equipment/type_big/Chesed.png",
    [EC_EquipSubType.Geburah] = "icon/equipment/type_big/Geburah.png",
    [EC_EquipSubType.Tiphareth] = "icon/equipment/type_big/Tiphareth.png",
    [EC_EquipSubType.Netzach] = "icon/equipment/type_big/Netzach.png",
    [EC_EquipSubType.Hod] = "icon/equipment/type_big/Hod.png",
    [EC_EquipSubType.Yesod] = "icon/equipment/type_big/Yesod.png",
    [EC_EquipSubType.Malkuth] = "icon/equipment/type_big/Malkuth.png",
}

EC_EquipSubTypeIcon = {
    [EC_EquipSubType.Kether] = "icon/equipType/Kether.png",
    [EC_EquipSubType.Chokhmah] = "icon/equipType/Chokhmah.png",
    [EC_EquipSubType.Binah] = "icon/equipType/Binah.png",
    [EC_EquipSubType.Chesed] = "icon/equipType/Chesed.png",
    [EC_EquipSubType.Geburah] = "icon/equipType/Geburah.png",
    [EC_EquipSubType.Tiphareth] = "icon/equipType/Tiphareth.png",
    [EC_EquipSubType.Netzach] = "icon/equipType/Netzach.png",
    [EC_EquipSubType.Hod] = "icon/equipType/Hod.png",
    [EC_EquipSubType.Yesod] = "icon/equipType/Yesod.png",
    [EC_EquipSubType.Malkuth] = "icon/equipType/Malkuth.png",
    [EC_EquipSubType.Daat] = "icon/equipType/Daat.png",
    [EC_EquipSubType.Wanneng] = "icon/equipType/Daat.png",
}

EC_EquipSubTypeIconBag = {
    [EC_EquipSubType.Kether] = "icon/equipment/type_bag/Kether.png",
    [EC_EquipSubType.Chokhmah] = "icon/equipment/type_bag/Chokhmah.png",
    [EC_EquipSubType.Binah] = "icon/equipment/type_bag/Binah.png",
    [EC_EquipSubType.Chesed] = "icon/equipment/type_bag/Chesed.png",
    [EC_EquipSubType.Geburah] = "icon/equipment/type_bag/Geburah.png",
    [EC_EquipSubType.Tiphareth] = "icon/equipment/type_bag/Tiphareth.png",
    [EC_EquipSubType.Netzach] = "icon/equipment/type_bag/Netzach.png",
    [EC_EquipSubType.Hod] = "icon/equipment/type_bag/Hod.png",
    [EC_EquipSubType.Yesod] = "icon/equipment/type_bag/Yesod.png",
    [EC_EquipSubType.Malkuth] = "icon/equipment/type_bag/Malkuth.png",
    [EC_EquipSubType.Daat] = "icon/equipment/type_bag/Daat.png",
    [EC_EquipSubType.Wanneng] = "icon/equipment/type_bag/Daat.png",
}

EC_EquipSubTypeIcon2 = {
    [EC_EquipSubType.Kether] = "icon/equipment/type/Kether.png",
    [EC_EquipSubType.Chokhmah] = "icon/equipment/type/Chokhmah.png",
    [EC_EquipSubType.Binah] = "icon/equipment/type/Binah.png",
    [EC_EquipSubType.Chesed] = "icon/equipment/type/Chesed.png",
    [EC_EquipSubType.Geburah] = "icon/equipment/type/Geburah.png",
    [EC_EquipSubType.Tiphareth] = "icon/equipment/type/Tiphareth.png",
    [EC_EquipSubType.Netzach] = "icon/equipment/type/Netzach.png",
    [EC_EquipSubType.Hod] = "icon/equipment/type/Hod.png",
    [EC_EquipSubType.Yesod] = "icon/equipment/type/Yesod.png",
    [EC_EquipSubType.Malkuth] = "icon/equipment/type/Malkuth.png",
    [EC_EquipSubType.Daat] = "icon/equipment/type/Daat.png",
    [EC_EquipSubType.Wanneng] = "icon/equipment/type/Daat.png",
}

EC_EquipSubTypeGrayIcon = {
    [EC_EquipSubType.Kether] = "icon/equipType/Kether_gray.png",
    [EC_EquipSubType.Chokhmah] = "icon/equipType/Chokhmah_gray.png",
    [EC_EquipSubType.Binah] = "icon/equipType/Binah_gray.png",
    [EC_EquipSubType.Chesed] = "icon/equipType/Chesed_gray.png",
    [EC_EquipSubType.Geburah] = "icon/equipType/Geburah_gray.png",
    [EC_EquipSubType.Tiphareth] = "icon/equipType/Tiphareth_gray.png",
    [EC_EquipSubType.Netzach] = "icon/equipType/Netzach_gray.png",
    [EC_EquipSubType.Hod] = "icon/equipType/Hod_gray.png",
    [EC_EquipSubType.Yesod] = "icon/equipType/Yesod_gray.png",
    [EC_EquipSubType.Malkuth] = "icon/equipType/Malkuth_gray.png",
    [EC_EquipSubType.Daat] = "icon/equipType/Daat_gray.png",
    [EC_EquipSubType.Wanneng] = "icon/equipType/Daat_gray.png",
}

EC_EquipSubTypeTitle = {
    [EC_EquipSubType.Kether] = "artFont/equipTypeName/Kether.png",
    [EC_EquipSubType.Chokhmah] = "artFont/equipTypeName/Chokhmah.png",
    [EC_EquipSubType.Binah] = "artFont/equipTypeName/Binah.png",
    [EC_EquipSubType.Chesed] = "artFont/equipTypeName/Chesed.png",
    [EC_EquipSubType.Geburah] = "artFont/equipTypeName/Geburah.png",
    [EC_EquipSubType.Tiphareth] = "artFont/equipTypeName/Tiphareth.png",
    [EC_EquipSubType.Netzach] = "artFont/equipTypeName/Netzach.png",
    [EC_EquipSubType.Hod] = "artFont/equipTypeName/Hod.png",
    [EC_EquipSubType.Yesod] = "artFont/equipTypeName/Yesod.png",
    [EC_EquipSubType.Malkuth] = "artFont/equipTypeName/Malkuth.png",
    [EC_EquipSubType.Daat] = "artFont/equipTypeName/Daat.png",
    [EC_EquipSubType.Wanneng] = "artFont/equipTypeName/Daat.png",
}

EC_EquipSubTypeGrayTitle = {
    [EC_EquipSubType.Kether] = "artFont/equipTypeName/Kether_gray.png",
    [EC_EquipSubType.Chokhmah] = "artFont/equipTypeName/Chokhmah_gray.png",
    [EC_EquipSubType.Binah] = "artFont/equipTypeName/Binah_gray.png",
    [EC_EquipSubType.Chesed] = "artFont/equipTypeName/Chesed_gray.png",
    [EC_EquipSubType.Geburah] = "artFont/equipTypeName/Geburah_gray.png",
    [EC_EquipSubType.Tiphareth] = "artFont/equipTypeName/Tiphareth_gray.png",
    [EC_EquipSubType.Netzach] = "artFont/equipTypeName/Netzach_gray.png",
    [EC_EquipSubType.Hod] = "artFont/equipTypeName/Hod_gray.png",
    [EC_EquipSubType.Yesod] = "artFont/equipTypeName/Yesod_gray.png",
    [EC_EquipSubType.Malkuth] = "artFont/equipTypeName/Malkuth_gray.png",
    [EC_EquipSubType.Daat] = "artFont/equipTypeName/Daat_gray.png",
    [EC_EquipSubType.Wanneng] = "artFont/equipTypeName/Daat_gray.png",
}

--灵装属性类型+EC_AttrAddText = 灵装属性描述
EC_AttrAddText = 420000

-- 城建进入类型
EC_CityEntranceType = {
    NORMAL = 1,         -- 正常进入
    DATING = 2,         -- 约会进入
}

-- 城市类型
EC_CityType = {
    COMMON = 1,    -- 通用
    DATING = 2,    -- 约会
    SPECIAL = 3,    -- 特殊
}

-- 建筑状态
EC_BuildState = {
    FREE = 1,              -- 空闲
    UPGRADE = 2,           -- 升级中
    UPGRADE_FINISH = 3,    -- 升级完成
    WORK = 4,              -- 打工中
    WORK_FINISH = 5,       -- 打工完成
}

-- 建筑解锁条件
EC_BuildUnlockCond = {
    LEVEL = 1,             -- 等级
    CHAPTER = 2,           -- 章节
}

-- 建筑升级条件
EC_BuildUpgradeCond = {
    LEVEL = 1,             -- 等级
    CHAPTER = 2,           -- 章节
}

-- 城建功能列表
EC_BuildFeatureType = {
    WORK = 1,              -- 打工
    SHOP = 2,              -- 商店
    UPGRADE = 3,           -- 升级
}

-- 城建打工要求
EC_BuildWorkCond = {
    COND_1 = 1,    -- 至少派遣N个精灵
    COND_2 = 2,    -- 队伍中必须包含某个精灵
    COND_3 = 3,    -- 队伍中精灵好感度达到X
    COND_4 = 4,    -- 队伍中精灵心情值达到X
}

-- 城建打工日志类型
EC_BuildWorkLogType = {
    REWARD = 1,    -- 奖励
    BEGIN = 2,    -- 开始打工
    FINISH = 3,    -- 打工结束
}

-- 城建打工日提示
EC_BuildWorkLogTipsType = {
    ReConfirm_GiveUpJob = "ReConfirm_GiveUpJob",--放棄兼職
}

--约会类型
EC_DatingScriptType = {
    SHOW_SCRIPT = 0, --展示约会
    MAIN_SCRIPT = 1, -- 主线剧本
    DAY_SCRIPT = 2, -- 日常剧本
    RESERVE_SCRIPT = 3, -- 预约约会剧本
    TRIGGER_SCRIPT = 4, -- 触发约会剧本(事件约会)
    WORK_SCRIPT = 5,  --打工约会剧本
    OUT_SCRIPT = 6, --出游约会剧本
    FUBEN_SCRIPT = 7, --副本约会
    OUTSIDE_SCRIPT = 8, -- 外传约会剧本
    FUBEN_CITY_SCRIPT = 9,--副本城建约会
    PHONE_SCRIPT = 10,--手机约会
    SPECIAL_SCRIPT = 20, --特殊剧本   
    COURAGE_SCRIPT = 21, --试胆大会剧本
    FAVOR_SCRIPT = 30, --好感度约会
}

--城建约会精灵状态
EC_ElvesState = {
    datingMain = 1, -- 主线约会
    datingReserveRequest = 2, -- 预定约会邀请
    datingReserve = 3, -- 预定约会
    datingOut = 4, -- 出游约会
    datingDayNoFinish = 5, -- 日常约会（未完成)
    hunger = 6, -- 饥饿
    angry = 7, -- 生气
    bored = 8, -- 无聊
    reward = 100, -- 主线日常约会礼包奖励领取状态
}

--约会类型对应精灵状态关系
EC_ElvesStateToDatingScriptType = {
    [EC_DatingScriptType.MAIN_SCRIPT] = EC_ElvesState.datingMain,
    [EC_DatingScriptType.RESERVE_SCRIPT .. 1] = EC_ElvesState.datingReserveRequest,
    [EC_DatingScriptType.RESERVE_SCRIPT .. 2] = EC_ElvesState.datingReserve,
    --[EC_DatingScriptType.RESERVE_SCRIPT] = {[1] = EC_ElvesState.datingReserveRequest,[2] = EC_ElvesState.datingReserve},
    [EC_DatingScriptType.OUT_SCRIPT] = EC_ElvesState.datingOut,
    [EC_DatingScriptType.DAY_SCRIPT] = EC_ElvesState.datingDayNoFinish,
}

--约会状态
EC_DatingScriptState = {
    LOCK      = -1,--未解锁
    NORMAL    = 0,
    TRIGGER   = 1, --触发约会
    NO_FINISH = 2, -- 未完成
    FAIL      = 3 --约会失败（预约的约会过期）
}

--日常约会结局类型
EC_DayDatingEndType = {
    HAPPYEND = 1,
    TUREEND = 2,
    NORMALEND = 3,
    BADEND = 4,
    HIDDENEND = 5
}

--城市约会状态(原邀请约会)城市约会包括：打工，出游，邀请
EC_CityDatingState = {
    noDating = 0,--无约会（邀请已过）
    noAccept = 1,--有邀请未接受
    accept = 2, --接受邀请
    normal = 3, --正常约会
    overtime = 4 --约会超时（预约的时间已过）
}

EC_DatingLayerType = {
    infoType = "infoLayer",
    giveGiftType = "giveGiftLayer",
    changeDressType = "changeDressLayer",
    garnishType = "garnishLayer",
    yuehuiType = "yuehuiLayer",
    jobType = "jobType"
}


EC_InputLayerType = {
    OK = 1,
    SEND = 2,
}

--live2d动画播放优先级
EC_PRIORITY = {
    NONE = 0,
    IDLE = 1,
    NORMAL = 2,
    FORCE = 3,
    SPECIAL = 4
}

--live2d点击区域部件
EC_HIT_AREA_NAME = {
    HEAD        ="head", --头
    BODY        ="body", --胸
    FUBU        ="fubu", --腹部
    TUI         ="tui" , --腿
    HAND_R      ="hand_r", --右腿
    HAND_L      ="hand_l", --左腿
}

EC_Angel_Skill_Point = 500009
EC_Angel_Skill_Point_Icon = "icon/system/78.png"

EC_Angel_Type_Name = {
    [1] = 450002,--"攻",
    [2] = 450004,--"技",
    [3] = 450004,--"技",
    [4] = 450005,--"杀",
    [5] = 450003,--"闪",
    [6] = 450001,--"觉",
    [7] = 100000085,--"落",
    [8] = 450006,--"出",
    [9] = 100000086,--"震",
    [10] = 2200010,--"被",
}

EC_Angel_Type_Name_Id = {
    [1] = 450002,
    [2] = 450007,
    [3] = 450007,
    [4] = 450005,
    [5] = 450003,
    [6] = 450001,
    [7] = 450006,
}

EC_Angel_Type_Name2 = {
    [1] = 2200001,
    [2] = 2200002,
    [3] = 2200004,
    [4] = 2200005,
    [5] = 2200003,
}

EC_Num2Roman = {
    [1] = "I",
    [2] = "II",
    [3] = "III",
    [4] = "IV",
    [5] = "V",
}

-- 好友
EC_Friend = {
    FRIEND = 1,    -- 好友
    SHIELDING = 2,    -- 黑名单
    APPLY = 3,    -- 请求
    ADD = 4,    -- 添加
    INVITE = 5,   -- 羁友
    MASTER = 6,   -- 师徒
}

-- 好友师徒(对应好友师徒两个分页)
EC_FriendMaster = {
    Master = 1,     -- 师门
    Apprentice = 2  -- 徒弟
}

-- 师徒申请界面类型 
EC_FriendMasterApply = {
    ApplyList = 1,    -- 申请列表
    ApplyMaster = 2,  -- 拜师
    GetApprentice = 3 -- 收徒
}

-- 好友操作类型
EC_FriendOp = {
    APPLY_FRIEND = 1,    -- 申请好友
    DELETE_FRIEND = 2,    -- 删除好友
    SHIELD_PLAYER = 3,    -- 屏蔽玩家
    LIFTED_SHIELD = 4,    -- 取消屏蔽
    AGREE_APPLY = 5,    -- 同意申请
    REFUSE_APPLY = 6,    -- 拒绝申请
    GIVE_GIFT = 7,    -- 赠送礼品
    RECEIVE_GIFT = 8,    -- 收取礼品
}

--可以体验的精灵
EC_ExperientialHeros = {
    [110103] = {group = 1,open = true}, --反转十香
    [110602] = {group = 2,open = false}, --真那
    [110102] = {group = 3,open = false}, --强化十香
    [112001] = {group = 4,open = false}, --万由里
    [111301] = {group = 5,open = false}, --七罪
    [110302] = {group = 6,open = false}, --强化四糸乃
    [110208] = {group = 7,open = false}, --DEM折纸
    [110209] = {group = 8,open = false}, --精灵折纸
    [111701] = {group = 9,open = true}, --白井黑子
}

-- 召唤预览类型
EC_SummonPreviewType = {
    HERO = 1,    -- 幸运精灵
    EQUIPMENT = 2,    -- 幸运灵装
    CP = 3,    -- 综合概率
    DP = 4,    -- 详细概率
    AD = 5,    -- 广告
    PROBABILITY1 = 6,    -- 概率
}

-- 召唤类型
EC_SummonType = {
    DIAMOND = 1,    -- 钻石召唤
    APPOINT_EQUIPMENT = 2,    --精准质点
    APPOINT_HERO = 3,  --精准英雄
    FRIENDSHIP = 4,    -- 友情点召唤
    CLOTHESE = 7,    -- 时装召唤
    ELF_CONTRACT = 8,    -- 契约召唤
    SPECIAL_SUMMON = 14,    -- 契约召唤
    CLOTHESE_1 = 15,  -- 时装召唤1
    CLOTHESE_2 = 16, -- 时装召唤2
    HOT_ROLE = 998,    -- 热点召唤(角色)
    HOT_EQUIPMENT = 999,    -- 热点召唤(角色)
}

-- 热点召唤类型
EC_SummonLoopType = {
    ROLE = 1,    -- 角色
    EQUIPMENT = 2,    -- 装备
}

-- 召唤显示位置类型
EC_SummonShowPlaceType = {
    Summon_View = 1,--召唤界面
    Agora_Lottery = 2,--圣诞集会所抽奖
    DLS = 3,    -- 大凉山抽奖
    Team = 6,    -- 组队抽奖
    BingoGame = 12,     --宾果召唤
    CELEBRATION = 13,   --周年庆召唤
}

-- 任务分页
EC_TaskPage = {
    TRAININIG = 1, --特训
    MAIN = 2,    -- 主线任务
    DAILY = 3,    -- 日常任务
    HONOR = 4,    -- 荣誉任务
    ACTIVITY = 5,    -- 活动任务
    TRAININIG_TASK = 6,    -- 特训任务
}

-- 任务分页
EC_TaskPage = {
    TRAININIG = 1, --特训
    MAIN = 2,    -- 主线任务
    DAILY = 3,    -- 日常任务
    HONOR = 4,    -- 荣誉任务
    ACTIVITY = 5,    -- 活动任务
    TRAININIG_TASK = 6,    -- 特训任务
}

-- 任务类型
EC_TaskType = {
    MAIN = 1,    -- 主线任务
    DAILY = 2,    -- 日常任务
    HONOR = 3,    -- 荣誉任务
    ACTIVITY = 4,    -- 活动任务
    ACTIVE = 5,    -- 活跃度
    SIGNIN = 6,    -- 签到任务
    NEXTDAY = 7,    -- 次日任务
    BIRTHDAY = 8,    -- 生日任务
    SEVENEX  = 9,
    TRAINING_MATRIX = 12,   --特训矩阵
    FUSION_PERSONAL = 13,           --核心聚变器个人
    FUSION_UNION = 14,           --核心聚变器社团
    DLS = 17,    -- 大凉山任务
    DLS_CARD = 18,    -- 大凉山工牌任务
    TEAM_PVE = 19,     --春季特训
    UNION_TRAIN = 20,     --特训矩阵
    SKYLADDER = 30,     --天梯
    EVERY_DAY  = 31,     --每日任务类型
    EVERY_WEEK = 32,     --每周任务类型
    ROLE_TEACH = 33,     -- 精灵调教成就
    WORLD_BOSS = 38,     -- 世界boss个人伤害奖励任务类型
    DFW_NEW     = 34,   -- 新-大富翁任务
}

-- 任务状态
EC_TaskStatus = {
    ING = 0,    -- 进行中
    GET = 1,    -- 可领取
    GETED = 2,    -- 已领取
}

-- 任务子类型
EC_TaskSubType = {
    LEVEL = 1,    -- 关卡
}

-- 任务子类型
EC_ActivityEntrustSubType = {
    ENTRUST = 3,    -- 委托
    BOX = 4,    -- 礼物盒
}

-- 中文数字
EC_ChineseNumber = {
    [0] = 300211,
    [1] = 300201,
    [2] = 300202,
    [3] = 300203,
    [4] = 300204,
    [5] = 300205,
    [6] = 300206,
    [7] = 300207,
    [8] = 300208,
    [9] = 300209,
    [10] = 300210,
    [100] = 300212,
    [1000] = 300213,
}

-- 图鉴类型
EC_CollectType = {
    EQUIP = 2,    -- 装备
    DRESS = 4,    -- 时装
    CG = 10,    -- CG
    SKIN = 11,  --皮肤
    MEDAL = 12, --徽章
    PORTRAIT = 16, --头像
    TOKEN = 17, --信物
    PORTRAIT_FRAME = 18, --头像--框
    TITLE = 38,     --称号
    DATING = 104,  --约会--日常
    BGM = 105, --Sound--BGM
    MAIN_DATING = 107, --约会--主线
    VOICE = 108, --Sound--语音
    SCENE = 109,    --场景
}

--图鉴收集分页
EC_CollectPage = {
    SPRITE = 1, --精灵
    DRESS = 2, --时装
    EQUIP = 3, --质点
    DATING = 4, --约会
    CG = 5, --CG
    TOKEN = 6, --信物
    SOUND = 7, --音频
    MEDAL = 8, --徽章
    PORTRAIT = 9,--头像
    TITLE = 10,  --称号
    SCENE = 11, --场景
}

--图鉴设置配置
EC_CollectSettingCfg = {
    [1] = {icon = "ui/setting/uires/024.png",name = 300617}, --精灵
    [2] = {icon = "ui/setting/uires/25.png",name = 1700013}, --时装
    [3] = {icon = "ui/setting/uires/30.png",name = 1701034}, --质点
    [4] = {icon = "ui/setting/uires/29.png",name = 1701035}, --约会
    [5] = {icon = "ui/setting/uires/023.png",name = 1700009}, --CG
    [6] = {icon = "ui/setting/uires/27.png",name = 1701037}, --信物
    [7] = {icon = "ui/setting/uires/022.png",name = 1701067}, --音频
    [8] = {icon = "ui/setting/uires/28.png",name = 1454048}, --徽章
    [9] = {icon = "ui/setting/uires/26.png",name = 1701040},--头像

}

--活动类型
EC_ActivityType = {
    SIGN = 1,           --签到
    SEVENDAY = 2,       --七日
    POWER = 3,    -- 体力补给
    NEXTDAY = 4,         --次日
    SEVENEX = 5, --七日狂欢
    CHRISTMAS_SIGN = 6,    -- 圣诞签到
    MONTH_CARD = 7,     --月卡
    SUPPORT_STORE = 8,    -- 特勤支援商店
    NEWGUY_SUMMON = 9,    --萌新召唤
    TOUZIREN = 10,    --萌新召唤
}


--功能开放索引
EC_FunctionEnum = {
    RECHARGE        = 1, --充值
    TEAM_FIGHT      = 2, --组队副本
}

-- 怪物类型
EC_MonsterType = {
    COMMON = 1,    -- 普通怪
    ELITE = 2,    -- 精英怪
    BOSS = 3,    -- boss
    GUARD = 4,    -- 守护怪
}

EC_MonsterTypeName = {
    [EC_MonsterType.COMMON] = 300955,
    [EC_MonsterType.ELITE] = 300956,
    [EC_MonsterType.BOSS] = 300954,
}

-- 怪物子类型
EC_MonsterSubType = {
    HUMAN = 0,    -- 人类怪
    ENERGY = 1,    -- 能量怪
    MACHINE = 2,    -- 机械怪
    ELF = 3   -- 精灵怪
}

EC_MonsterSubTypeName = {
    [EC_MonsterSubType.HUMAN] = 300958,
    [EC_MonsterSubType.ENERGY] = 300959,
    [EC_MonsterSubType.MACHINE] = 300960,
    [EC_MonsterSubType.ELF] = 300961,
}

EC_Hero_Weapon_Name = {
    [1] = 10100,
    [2] = 10101,
    [3] = 10102,
    [4] = 10103,
}

--公告类型
EC_NoticeType = {
    GAME = 1,--游戏公告
    ACTIVE = 2,--活动公告
}

EC_equip_Special_icon = {
    [1] = "ui/Equipment/new_ui/new_23.png",
    [2] = "ui/Equipment/new_ui/new_19.png",
    [3] = "ui/Equipment/new_ui/new_18.png",
    [4] = "ui/Equipment/new_ui/new_21.png",
    [5] = "ui/Equipment/new_ui/new_20.png",
}

--外传约会界面类型（目前用于判断打开菜单的入口）
EC_OutsideViewType = {
    OutsideMain = 1,--外传主界面
    OutSideMainDate = 2,--外传主界面约会按钮
    OutsideCity = 3,--外传城市界面
}

--外传约会选择项
EC_OutsideChoiceType = {
    OutsideChoiceScript = 1,--剧本
    OutsideChoiceMessage = 2,--信息
}

--单次登陆保存状态类型
EC_OneLoginStatusType = {
    ReConfirm_MailDelete = "ReConfirm_MailDelete",--邮件删除
    ReConfirm_Summon = "ReConfirm_Summon",--召唤
    ReConfirm_StoreFresh = "ReConfirm_StoreFresh",--商店刷新
    ReConfirm_EquipConvert = "ReConfirm_EquipConvert",--洗练确认
    ReConfirm_Practice = "ReConfirm_Practice",    -- 木桩副本
    ReConfirm_Experiential = "ReConfirm_Experiential",    -- 模拟练习
    ReConfirm_ShowBackTips = "ReConfirm_ShowBackTips",   --回归弹窗
    ReConfirm_AgoraLottery = "ReConfirm_AgoraLottery",  --集会所抽奖
    ReConfirm_NoobPractice = "ReConfirm_NoobPractice",  --萌新召唤英雄试玩
    ReConfirm_Dafuweng = "ReConfirm_Dafuweng",  -- 大富翁兑换
    ReConfirm_TeamSummon = "ReConfirm_TeamSummon",  -- 大世界召唤
    ReConfirm_SxBirthday = "ReConfirm_SxBirthday",    -- 十香生日活动探索
    ReConfirm_ExitTeamScene = "ReConfirm_ExitTeamScene",  -- 大世界召唤
    ReConfirm_MaidRecruit = "ReConfirm_MaidRecruit",  -- 女仆招募
    ReConfirm_NewSceneShowView = "ReConfirm_NewSceneShowView",  -- 改变场景背景图
    ReConfirm_HotSpotTryPlay = "ReConfirm_HotSpotTryPlay",  -- 热点召唤试玩
    ReConfirm_DuanwuTaskRefresh = "ReConfirm_HotSpotTryPlay",  -- 热点召唤试玩
    ReConfirm_TryUseHero = "ReConfirm_TryUseHero",  -- 试用卡
    ReConfirm_BingoSummon = "ReConfirm_BingoSummon",    --宾果召唤
    ReConfirm_ChronoCross = "ReConfirm_ChronoCross",     --折纸穿越活动
    ReConfirm_DispatchSpeed = "ReConfirm_DispatchSpeed",     --挂机加速
    ReConfirm_SwitchKanBan = "ReConfirm_SwitchKanBan",     --看板轮播
    ReConfirm_SwitchKanBanState = "ReConfirm_SwitchKanBanState",     --看板轮播状态
	ReConfirm_SimulationSummon = "ReConfirm_SimulationSummon",   --模拟召唤
    ReconFirm_Courage = "ReconFirm_Courage",   --试胆大会提示框
    ReconFirm_CourageEnter = "ReconFirm_CourageEnter",   --试胆大会提示框
    ReconFirm_UpgradeGMSkill = "ReconFirm_UpgradeGMSkill",       --升级共鸣技能
    ReConfirm_AssistanceGameScoreRefresh = "ReConfirm_AssistanceGameScoreRefresh" , --尤茨游戏刷新奖励
    ReconFirm_PreTeam = "ReconFirm_PreTeam",                     --预设队伍提示
    ReConfirm_AssistanceGameUseScore = "ReConfirm_AssistanceGameUseScore",   ---使用尤茨分数投掷
    ReConfirm_CrazyDiamond = "ReConfirm_CrazyDiamond",   ---疯狂钻石抽取
    ReConfirm_DafuwengRefreashCost = "ReConfirm_DafuwengRefreashCost"  --大富翁刷新二次确认消耗
}

EC_SKILL_TYPE = {
    NORMAL      = 1, --普攻
    SKILL_1     = 2, --技能1
    SKILL_2     = 3, --技能2
    BISHA       = 4, --必杀
    SHANBI      = 5, --闪避
    JUEXING     = 6, --觉醒
    XIALUO      = 7, --下落
    QIEHUAN     = 8, --切换登场技能
    ZHENFEI     = 9, --起身震飞
    BEIDONG     = 10, --被动
}

-- 限定精灵类型
EC_LimitHeroType = {
    NONE = 0,    -- 无限定
    LIMIT_NJ = 1,    -- 不能加入自己的精灵
    LIMIT_J = 2,    -- 可以加入自己的精灵
    DISABLE = 3,    -- 禁用精灵
    SIMULATION_TRIAL_LOCK = 4,    -- 限定 试炼精灵 不能加入自己的精灵
    SIMULATION_TRIAL = 5,    -- 限定 试炼精灵 可以加入自己的精灵
}

-- 战斗英雄类型
EC_BattleHeroType = {
    OWN = 1,    -- 玩家精灵
    LIMIT = 2,    -- 限定精灵
    SIMULATION = 3,    --模拟精灵
}

--约会相关选择项类型
EC_DatingChoiceType = {
    ChoiceScript = 1,--剧本
    ChoiceMessage = 2,--信息
    ChoiceFunction = 3,--功能入口
}

EC_FairStateIcon = {
    [EC_ElvesState.datingMain] = "ui/newCity/state/zhuxianyuehui.png", -- 主线约会
    [EC_ElvesState.datingReserveRequest] = "ui/newCity/state/yudingyaoqing.png", -- 预定约会邀请
    [EC_ElvesState.datingReserve] = "ui/newCity/state/yudingyuehui.png", -- 预定约会
    [EC_ElvesState.datingOut] = "ui/newCity/state/chuyou.png", -- 出游约会
    [EC_ElvesState.datingDayNoFinish] = "ui/newCity/state/weiwancheng.png", -- 日常约会（未完成)
    [EC_ElvesState.hunger] = "ui/newCity/state/jie.png", -- 饥饿
    [EC_ElvesState.angry] = "ui/newCity/state/shengqi.png", -- 生气
    [EC_ElvesState.bored] = "ui/newCity/state/wuliao.png", -- 无聊
    [EC_ElvesState.reward] = "ui/newCity/state/reward.png", -- 日常，主线约会奖励领取状态
}

--精灵城市状态描述
EC_FairStateDescription = {
    [EC_ElvesState.datingMain] = 901066,
    [EC_ElvesState.datingReserveRequest] = 901067,
    [EC_ElvesState.datingReserve] = 901068,
    [EC_ElvesState.datingOut] = 901069,
    [EC_ElvesState.datingDayNoFinish] = 901070,
    [EC_ElvesState.hunger] = 901071,
    [EC_ElvesState.angry] = 901072,
    [EC_ElvesState.bored] = 901073,
    [EC_ElvesState.reward] = 901170,
}

--城建类型
EC_NewCityType = {
    NewCity_Outside = 1,--外传城建
    NewCity_MainLine = 2,--主线城建
    NewCity_FuBen = 3,--副本城建
    NewCity_Update = 10,--城建刷新
    NewCity_Normal = 11,--通用默认城建
}

--城建白天黑夜
EC_NewCityDayType = {
    Day_Light = 0,--白天
    Day_Night = 1,--晚上
    Christmas = 100,--圣诞
    SpringFestival_Light = 101,--春节白天
    SpringFestival_Night = 102,--春节晚上
}

--城建主地图路径
EC_NewCityMainMapRoot = {
    [EC_NewCityDayType.Day_Light] = "newcity2",
    [EC_NewCityDayType.Day_Night] = "newcity2",
    [EC_NewCityDayType.Christmas] = "christmas/christmascity",
    [EC_NewCityDayType.SpringFestival_Light] = "newyear/newcity2",
    [EC_NewCityDayType.SpringFestival_Night] = "newyearnight/newcity2",
}

--城建类型房间地图路径
EC_NewCityDayRoomMapRoot = {
    [EC_NewCityDayType.Day_Light] = "",
    [EC_NewCityDayType.Day_Night] = "",
    [EC_NewCityDayType.Christmas] = "christmas/",
    [EC_NewCityDayType.SpringFestival_Light] = "newyear/",
    [EC_NewCityDayType.SpringFestival_Night] = "newyearnight/",
}

--城建界面层级
EC_NewCityZOrder = {
    InfoView = 0,
    FairListView = 1,
    Room = 2,
}

--城建层级
EC_NewCityLevel = {
    NewCity_Fore = 1, --前景层
    NewCity_Back = 2, --后景层
}

--城建模型类型
EC_NewCityModelType = {
    NewCity_Fair = 1,--精灵
    NewCity_Npc = 2,--npc
    NewCity_NianShou = 3,--年兽
}

--城建加载类型
EC_NewCityLoadType = {
    Load = 1,--默认加载
    Update = 2,--城建刷新
}

--城建提醒类型
EC_NewCityRemindType = {
    Build = 1,
    BuildFuncs = 2,
    Role = 3,
}

--勋章变化类型
EC_MedalChangeType = {
    DEFAULT = 0,--默认
    ADD = 1,--新增
    DELETE = 2,--删除
    UPDATE = 3,--更新
}

-- 活动商店限购类型
EC_ActivityStoreType = {
    NONE = 0,    -- 不限购
    DAY = 1,    -- 本天内限购
    TOTAL = 2,    -- 总量限购
    WHOLESERVER_DAY = 3,    -- 全服每天限购
    WHOLESERVER_TOTAL = 4,    -- 全服总量限购
}

-- 活动类型
EC_ActivityType2 = {
    STORE = 1,    -- 商店
    TASK = 2,    -- 任务
    ASSIST = 3,    --应援
    DROP = 4,    -- 掉落
    HALLOWEEN = 5,    -- 万圣节
    DOUBLE_CARD = 6,    -- 双倍月卡
    CHRISTMAS = 7,    -- 圣诞节
    CHRISTMAS_SIGN = 8,    -- 圣诞签到
    RECHARGE = 9,    -- 充值活动
    ADD_RECHARGE = 10,  --累计充值
    WHITEVALENTINE = 11,    -- 白色情人节活动
    CLOTHESE_SUMMON = 15,    -- 时装抽奖
    SX_BIRTHDAY = 14,    -- 十香生日活动
    MAID_COFFEE = 16,    -- 女仆咖啡厅
    DUANWU_1 = 17,    -- 端午
    SUMMONACTIVITY = 18,    -- 召唤活动
    DRAGONBOAT = 33, --端午节活动
    NEWYEARDATING = 1005,    -- 新年约会
    ENTRUST = 1004,    --  委托活动
    NEWPLAYER = 1003, --萌新
    BACKPLAYER = 1002, --回归指引
    BACKACTIVITY = 1001, --回归活动
    NEW_BACKACTIVITY = 1021, --新回归活动
    VALENTINE = 1006,    -- 情人节活动
    CGCOLLECTED = 1007,    -- CG收集活动
    DUANWU_2 = 1008,    -- 端午
    BINGOGAME = 19,     -- 宾果游戏
    WELFARE_RECHEAGE = 1009,    -- 福利礼包
    WELFARE_SIGN = 1010,    -- 福利登陆
    WELFARE_TASK = 21,    -- 福利任务
    WELFARE_JUMP = 22,    -- 福利跳转
    WELFARE_GIFT = 23,    -- 福利礼包
    CHRONO_CROSS = 1011,   -- 穿越使用
    TRAINING = 1012,        --战令活动
    BLACK_WHITE  = 1013,    --黑与白的终焉
    ANNIVERSARY_PREHEAT  = 100000,   -- 中秋周年庆预热 TODO 临时客户端用
    ANNIVERSARY_FEEDBACK = 26,   -- 周年庆回馈
    ONEYEAR_CELEBRATION = 25, --周年庆典
    ONEYEAR_WELFARE = 24,   --周年福利
    ZNQ_HG = 1014, -- 周年庆回忆
    ONEYEAR_DROP = 27,      --周年庆掉落
    DFW_AUTUMN = 29,      -- 大富翁秋日祭
    COURAGE = 30,           --试胆大会
    COURAGE_TASK = 28,           --试胆大会任务
    SERVER_GIFT = 31,           --全服礼包返利
    SERVER_FUND = 33,           --全服基金
    FUND = 32,                   --活动基金
    CHRISTMAS_FIGHT = 35,        --圣诞关卡活动
    KUANGSAN_FUBEN = 40,         --狂三副本
    ONLINE_SCORE_REWARD = 41,   --在线积分活动
    HANG_UP = 43,   --挂机活动
    YANHUA_COMPOSE = 47,   --挂机活动
    KSAN_CARD = 1015,           --狂三翻牌活动
    CHRISTMAS_PRE = 34,         --圣诞节预售
    FRIEND_BLESS = 44,          -- 好友寄语
    TANGHULU = 45,              -- 糖葫芦活动
    SCALE_9_GRID = 1016,
    PRAY_ACTIVITY = 1017,       --暮春祈愿
    NEWYEAR_FUBEN = 42,         --新年副本
    CALL_BACK = 48,             --回归活动
    GROUP_PURCHASE = 49,        --团购活动
    HWX_FUBEN = 51,             --海王星副本
    CRAZY_DIAMOND = 1017, --疯狂砖石
    TURNTABLE = 1075  ,  --占卜罗盘活动
    DFW_NEW = 1076,         -- 新-大富翁活动
    FANSHI_ASSIST = 1001,  --反十应援活动
	LOBARDAY_2020 = 52,         --2020劳动节活动
    AD_ACTIVITY = 54,           --综合广告宣传活动
    SZQY = 53,					--时之契约
    ALLSERVER_ASSISTANCE = 55,  -- 全服应援活动
    LEAGUE_BACK = 1018,         --社团召回活动
    EXPLORE = 56,               --探索活动
	DRESS_VOTE = 57,			--花嫁活动
	FASHIONWHOLESALE = 58,		--时装批发
	TREASUREHUNTING = 59,		--宝物狩猎
    DUANWU_HANGUP = 1019,               --端午挂机
    DETECTIVE_CHAPTER = 60,               --探索周目
    DETECTIVE_CLUE = 61,               --探索线索
    DETECTIVE_VOTE = 62,               --探索投票
    TURNTABLET2 = 63,          -- 2周年庆翻牌游戏
    TWOYEAR_FASHION_STORE = 64,  --2周年庆时装商店
	BALLOON_ACTIVITY = 66,     --气球活动
    SIMULATION_SUMMON = 67,     --模拟召唤
    DUNGEON_DROP = 68,         --固定关卡掉落翻倍活动
    WSJ_2020 = 70,         --固定关卡掉落翻倍活动
    HALLOWEEN_GHOST  = 69,         --万圣节小鬼活动
    PRIVILEGE_ACTIVITY_DATA = 1020,      --特权活动数据(这个活动开启，特权功能才有数据)
	BOSS_CHALLENGE = 1022,               --BOSS挑战
    NEWGIFT_PACK_EN = 85,       --新手礼包活动

    PINTU_ACTIVITY_EN = 86,  --拼图活动英文版

    LEAGUE_SCORE_ASSIT = 87 , --- 社团助力积分活动
    LEAGUE_SCORE_RANK = 88,  -- 社团助理排行榜活动

}

EC_Activity_CHRISTMAS_Subtype = {
    ONLY_RECORD = 999,      --圣诞节只计数的活动
}

-- 应援活动条目子类型
EC_Activity_Assist_Subtype = {
    STAGE_REWARD = 26001,    -- 阶段奖励
    CG_LIST = 26002,    -- cg列表
    CG_UNLOCK = 26003,    --解锁列表
    RANK_REWARD = 26004,    --排名奖励
    REWARD_PREVIEW = 27001,    -- 节日活动类型副本奖励预览
    LEVEL = 9007,    -- 万圣节关卡
    TASK = 9008,    -- 万圣节任务
}

-- 应援活动条目状态
EC_Assist_Item_Status = {
    ING = 0,    -- 进行中
    GET = 1,    -- 可领取
    GETED = 2,    -- 已领取
}

--卡巴拉地图格子类型
EC_EventLayerGid = {
    Tile_Nil = 1,                   --无事件格子
    Tile_Birth = 2,                 --出生点
    Tile_Obstruct = 3,              --阻挡
    Tile_Safe = 4,                  --安全区域
    Tile_Danger = 5,                --危险区域
    Tile_Boss = 6,                  --Boss击杀
    Tile_Monster = 7,               --普通击杀
    Tile_Item = 8,                  --道具收集
    Tile_Occupy = 9,                --占领点
    Tile_SearchDot = 10,            --探索目标点
    Tile_Search = 11,               --探索区域
    Tile_Story = 12,                --任务剧情
    Tile_Transport = 13,            --传送点
    Tile_TransportTarget = 14,      --传送目标
    Tile_Normal = 15,               --普通地块
    Tile_Blue = 16,                 --蓝色地块
    Tile_Yellow = 17,               --黄色地块
    Tile_Red = 18,                  --红色地块
    Tile_AllYellow = 19,            --全黄色地块
    Tile_SmallObstruct = 29,        --小地图阻挡
    Tile_SmallNormal = 30,          --小地图普通格子
}

--卡巴拉触发事件类型
Enum_TriggerEventType = {
    EventType_Fight = 1,            --直接战斗
    EventType_CollectItem = 2,      --收集任务道具
    EventType_OccupyDot = 3,        --占领据点
    EventType_TaskStory = 4,        --任务剧情
    EventType_Search = 5,           --探索区域
    EventType_RandomItem = 6,       --拾取随机奖励
    EventType_Transport = 7,        --传送事件
    EventType_Store = 8,            --商店事件
    EventType_ConcealBoss = 9,      --隐藏Boss
}

--卡巴拉小游戏类型
Enum_TriggerGameType = {
    WiseCube = 1001,        --智者魔方
    ChipGame = 1002,        --博弈筹码
    Forgotton = 1003,       --遗忘残迹
    Dice = 1004,            --卡巴拉之骰
    Divination = 1005,      --占卜之源
}

--卡巴拉世界状态
Enum_WorldState = {
    State_Close = 0,                    --未配置状态
    State_stabilize = 1,                --稳定状态
    State_willOpen = 2,                 --即将开放
    State_Opening = 3,                  --开放中
}

--卡巴拉背包类型(item表的subType)
Enum_KabalaItemType = {
    ItemType_System = 0,            --体力类的通用道具
    ItemType_ForSingle = 1,         --针对某个精灵使用的道具
    ItemType_ForAll = 2,            --针对所有精灵使用的道具
    ItemType_Task = 4,              --任务道具
    ItemType_Buff = 5,              --BUFF
    ItemType_BuffItem = 6,          --BUFF道具
}

--卡巴拉buff品质
Enum_KabalaItemQuality = {
    blue = 1,
    purple = 2,
    orange = 3,
}

Enum_KabalaItemFrame = {
    [Enum_KabalaItemQuality.blue] = "icon/kabalabuff/frame_blue.png",
    [Enum_KabalaItemQuality.purple] = "icon/kabalabuff/frame_purple.png",
    [Enum_KabalaItemQuality.orange] = "icon/kabalabuff/frame_yellow.png",
}

--手机触发事件类型
Enum_PhoneSaveType = {
    SaveType_DaingId = 1,            --存储约会ID
    SaveType_Award = 2,              --存储奖励
    SaveType_OutTime = 3,            --存储过期约会详情
    SaveType_DatingInfo = 4,         --存储约会时间+地点
}

--手机精灵状态
Enum_PhoneRoleState = {
    NORMAL = 0,            --正常状态
    FORBID = 1,            --禁止状态
}

-- 主界面按钮类型
EC_MainFuncType = {
    FOLLOW = 204,    -- 关注
    UPDATE = 205,    -- 更新内容
    NEW_YEAR = 207,  -- 新年福利活动
    PREVIEW  = 208,  -- 预告
    SXSR  = 209,  -- 十香生日
    RESUME = 210,   --履历
    SCORE = 214,--积分活动
    ZHUIFAN = 215,--追番
    ZHIBO = 216,--直播
    ZNQ = 218,  --周年庆回忆
    --WUJIN = 229,   --无尽模式跳层开关(废弃)
}

--集会所情报站消息类型
EC_AgoraStationInfoType = {
    CombineLucky = 2,--在合成中触发了幸运等级为5的事件
    PassLevel = 1,--通关了某一个关卡
    --CombineCount = 3,--合成次数达到多少次
    --Contribute = 4,--贡献度达到XX点
    LotteryLucky = 3,--在圣诞幸运抽奖中获得了品质为5的道具
    LotteryLuckyTop = 100,--在圣诞幸运抽奖中获得了品质为5的道具（跑马灯）
}

--集会所情报站RString id
EC_AgoraStationInfoRId = {
    [EC_AgoraStationInfoType.CombineLucky] = "r150001",--在合成中触发了幸运等级为5的事件
    --[EC_AgoraStationInfoType.CombineCount] = "r151002",--合成次数达到多少次
    [EC_AgoraStationInfoType.PassLevel] = "r151001",--通关了某一个关卡
    -- [EC_AgoraStationInfoType.Contribute] = "r151003",--贡献度达到XX点
    [EC_AgoraStationInfoType.LotteryLucky] = "r151003",--在圣诞幸运抽奖中获得了品质为5的道具
    [EC_AgoraStationInfoType.LotteryLuckyTop] = "r151004",--在圣诞幸运抽奖中获得了品质为5的道具
}

--集会所合成状态
EC_AgoraComposeStatus = {
    CantCompose = 1,--不能合成，材料不足
    CanCompose = 2,--可合成
    CountDown = 3,--倒计时中
    CanGet = 4,--可领取
}

--手机聊天类型
EC_PhoneChatType = {
    Normal = 1,    -- 普通聊天
    Voice = 2,     -- 语音聊天
    Message = 3,   -- 主界面提示
}

EC_PhoneContentType = {
    Normal = 1,    -- 字符串
    Voice = 2,     -- 语音
}

EC_PhoneSaveType = {
    voice = 0,   --语音
    oneself = 1,    --自己
    robot = 2,   --机器人
}

-- 掉落UI展示类型
EC_DropShowType = {
    GETED = 1,    -- 已获得
    ACTIVITY_EXTRA = 2,    -- 活动额外掉落
    ACTIVITY_MULTIPLE = 4,    -- 活动翻倍
    FIRST_PASS = 8,    -- 首通
    TEAM_MASS = 16,     --集结奖励
    DATING_GETED = 32,    -- 约会已获得
}

-- 活动掉落结果类型
EC_ActivityDropChangeType = {
    MULTIPLE = 1,    -- 翻倍
    EXTRA = 2,    -- 额外掉落
}

-- 活动掉落检测类型
EC_ActivityDropInspectType = {
    DROP_ID = 1,    -- 根据dropid检测
    CHAPTER_TYPE = 2,    -- 根据drop配置副本类型
    DUNGEON_DROP_ID = 4,    -- 固定关卡的掉落翻倍
}

-- 大凉山关卡类型
EC_DlsLevelType = {
    MAIN = 1,    -- 主线
    BRANCH = 2,    -- 支线
    EVENT = 3,    -- 宝箱事件
}

--Dal地图格子类型
EC_DalEventLayerGid = {
    Tile_Nil = 1,                   --无事件格子
    Tile_Birth = 2,                 --出生点
    Tile_Obstruct = 3,              --阻挡
    Tile_Safe = 4,                  --安全区域
    Tile_Danger = 5,                --危险区域
    Tile_Boss = 6,                  --Boss击杀
    Tile_Monster = 7,               --普通击杀
    Tile_Item = 8,                  --道具收集
    Tile_Option = 9,                --春节选项(51-60)
    Tile_Transport = 10,            --传送点
    Tile_TransportTarget = 11,      --传送目标
    Tile_Other1 = 12,               --其他1
    Tile_Other2 = 13,               --其他2
    Tile_Other3 = 14,               --其他3
    Tile_Other4 = 15,               --其他4
    Tile_Other5 = 16,               --其他5
    Tile_Class1 = 17,               --教室1
    Tile_Class2 = 18,               --教室2
    Tile_Beach1 = 19,               --沙滩1
    Tile_Beach2 = 20,               --沙滩2
    Tile_Street = 21,               --街道
    Tile_SmallObstruct = 22,        --小地图阻挡
    Tile_SmallNormal = 23,          --小地图普通格子
}

EC_SKYLADDER_STEP = {
    PREPARE = 0,                    --准备期
    PROCCED = 1,                    --进行中
    BALANCE = 2,                    --结算期
}

-- 天梯阶段
EC_SkyLadderType = {
    BRONZE      = 1,                  --青铜
    SILVER      = 2,                  --白银
    GOLD        = 3,                  --黄金
    PLATINUM    = 4,                  --铂金
    DIAMOND     = 5,                  --钻石
    HONOUR      = 6,                  --荣耀
}

-- 天梯文字颜色
EC_SkyLadderColor = {
    [EC_SkyLadderType.BRONZE] = ccc3(72, 109, 106),
    [EC_SkyLadderType.SILVER] = ccc3(73, 85, 127),
    [EC_SkyLadderType.GOLD] = ccc3(138, 80, 41),
    [EC_SkyLadderType.PLATINUM] = ccc3(51, 70, 154),
    [EC_SkyLadderType.DIAMOND] = ccc3(102, 42, 187),
    [EC_SkyLadderType.HONOUR] = ccc3(187, 105, 0),
}

-- 天梯底板颜色
EC_SkyLadderBorard = {
    [EC_SkyLadderType.BRONZE] = "ui/skyladder/stage/bronze.png",
    [EC_SkyLadderType.SILVER] = "ui/skyladder/stage/silver.png",
    [EC_SkyLadderType.GOLD] = "ui/skyladder/stage/gold.png",
    [EC_SkyLadderType.PLATINUM] = "ui/skyladder/stage/platinum.png",
    [EC_SkyLadderType.DIAMOND] = "ui/skyladder/stage/diamond.png",
    [EC_SkyLadderType.HONOUR] = "ui/skyladder/stage/honour.png",
}

-- 天梯结算底板颜色
EC_SkyLadderEndBorard = {
    [EC_SkyLadderType.BRONZE] = "ui/skyladder/end/bronze.png",
    [EC_SkyLadderType.SILVER] = "ui/skyladder/end/silver.png",
    [EC_SkyLadderType.GOLD] = "ui/skyladder/end/gold.png",
    [EC_SkyLadderType.PLATINUM] = "ui/skyladder/end/platinum.png",
    [EC_SkyLadderType.DIAMOND] = "ui/skyladder/end/diamond.png",
    [EC_SkyLadderType.HONOUR] = "ui/skyladder/end/honour.png",
}

-- 天梯勋章
EC_SkyLadderMedal = {
    [EC_SkyLadderType.BRONZE] = "icon/skyLadder/bronze.png",
    [EC_SkyLadderType.SILVER] = "icon/skyLadder/silver.png",
    [EC_SkyLadderType.GOLD] = "icon/skyLadder/gold.png",
    [EC_SkyLadderType.PLATINUM] = "icon/skyLadder/platinum.png",
    [EC_SkyLadderType.DIAMOND] = "icon/skyLadder/diamond.png",
    [EC_SkyLadderType.HONOUR] = "icon/skyLadder/honour.png",
}

-- 天梯卡牌品质
EC_SkyLadderCardRarity = {
    ORDINARY = 1,    -- 普通
    GOOD = 2,    -- 精良
    RARE = 3,    -- 稀有
    PRECIOUS = 4,    -- 珍品
}

-- 天梯卡牌边框
EC_SkyLadderCardFrame = {
    [EC_SkyLadderCardRarity.ORDINARY] = "ui/skyladder/card/006.png",
    [EC_SkyLadderCardRarity.GOOD] = "ui/skyladder/card/007.png",
    [EC_SkyLadderCardRarity.RARE] = "ui/skyladder/card/008.png",
    [EC_SkyLadderCardRarity.PRECIOUS] = "ui/skyladder/card/009.png",
}

-- 天梯卡牌边框
EC_SkyLadderCardDiban = {
    [EC_SkyLadderCardRarity.ORDINARY] = "ui/skyladder/card/018.png",
    [EC_SkyLadderCardRarity.GOOD] = "ui/skyladder/card/019.png",
    [EC_SkyLadderCardRarity.RARE] = "ui/skyladder/card/020.png",
    [EC_SkyLadderCardRarity.PRECIOUS] = "ui/skyladder/card/021.png",
}

-- 天梯卡牌品质字符串
EC_SkyLadderCardRarityName = {
    [EC_SkyLadderCardRarity.ORDINARY] = 3202028,
    [EC_SkyLadderCardRarity.GOOD] = 3202029,
    [EC_SkyLadderCardRarity.RARE] = 3202031,
    [EC_SkyLadderCardRarity.PRECIOUS] = 3202030,
}

-- 天梯卡牌类型
EC_SkyLadderCardType = {
    PASSIVE = 1,    -- 被动
    INITIATIVE = 2,    -- 主动
}

-- 天梯卡牌类型icon
EC_SkyLadderCardTypeIcon = {
    [EC_SkyLadderCardType.PASSIVE] = "ui/skyladder/card/003.png",
    [EC_SkyLadderCardType.INITIATIVE] = "ui/skyladder/card/002.png",
}

-- 天体卡牌类型字符串
EC_SkyLadderCardTypeName = {
    [EC_SkyLadderCardType.PASSIVE] = 3202033,
    [EC_SkyLadderCardType.INITIATIVE] = 3202032,
}

-- 天梯卡牌类型底板
EC_SkyLadderCardTypeDiban = {
    [EC_SkyLadderCardType.PASSIVE] = "ui/skyladder/card/023.png",
    [EC_SkyLadderCardType.INITIATIVE] = "ui/skyladder/card/022.png",
}

-- 天梯卡包big图片
EC_SkyLadderPakageBigPic = {
    [EC_ItemQuality.WHITE] = "icon/item/card/300001.png",
    [EC_ItemQuality.GREEN] = "icon/item/card/300001.png",
    [EC_ItemQuality.BLUE] = "icon/item/card/300002.png",
    [EC_ItemQuality.PURPLE] = "icon/item/card/300003.png",
    [EC_ItemQuality.ORANGE] = "icon/item/card/300004.png",
    [EC_ItemQuality.RED] = "icon/item/card/300004.png",
}

EC_SkyLadderCardEffect = {
    normal = 0;
    up = 1,
    down = 2
}

EC_SkyLadderCardEffectInfo = {
    [EC_SkyLadderCardEffect.normal] =   {color = ccc3(255, 255, 255),   dotRes = "ui/skyladder/zones/005.png", arrowRes = ""},
    [EC_SkyLadderCardEffect.up] =       {color = ccc3(95, 237, 118),    dotRes = "ui/skyladder/fight/009.png", arrowRes = "ui/skyladder/fight/018.png"},
    [EC_SkyLadderCardEffect.down] =     {color = ccc3(255, 146, 170),   dotRes = "ui/skyladder/fight/010.png", arrowRes = "ui/skyladder/fight/017.png"}
}

EC_SceneSoundType = {
    Scene = 1;
    Bgm = 2,
}

EC_SceneSoundTime = {
    Day = 1;
    Night = 2,
}

--TODO CLOSE
-- EC_ReportPlayerType = {
--     GUANGGAO = 600041,
--     ZUOBI    = 600042,
--     SAORAO   = 600043,
--     GUAJI    = 600045,
-- }
EC_ReportPlayerType = {
    GUANGGAO = 600041,
    ZUOBI    = 600042,
    SAORAO   = 600043,
}

EC_FairyDetailUIType = {
    Attr = 1,           --属性
    Crystal = 2,        --结晶
    Equip = 3,          --质点
    Angle = 4,          --天使
    NewEquip = 5,       --羁绊
    BaoShi = 6,         --宝石
    Skin = 7            --灵装
}

--追猎计划阶段
EC_HunterStep = { 
    FUN_NOT_OPEN     =0 ,  --功能未开放, 
    READY_OPEN       =1 , --准备期开放, 
    READY_Settlement =2 , --准备期结算, 
    READY_END        =3 , --准备期结束, 
    FORMAL_OPEN      =11,--正式挑战开放, 
    FORMAL_SETTLEMENT=12, --正式挑战结算, 
    FORMAL_END       =13, --正式挑战结束
}

EC_BingoGameType = {
    Turnplate = 101,          --转盘
    Dice = 102,               --骰子
    Divination = 103,         --占卜
    Main = 104,               --主界面
}

EC_UnlockType = {
    win = 1,          --胜利
    lose = 2,          --失败
}

EC_DiceVoteType = {
    Big = 1,              --大
    Small = 2,            --小
    Baozi = 3,            --豹子
}

EC_HadleAccountType = {
    Spring = 1,              --春日祭
    Summer = 2,              --夏日祭
    ChronoCross = 3,         --折纸穿越活动
    AUTUMN = 4,         --折纸穿越活动
}

-- 按钮类型点击音效
EC_SimulationTrialRewradType = {
    JinYan   = 51,        -- 经验
    JinJie   = 52,        -- 精灵进阶
    TuPo     = 53,        -- 精灵突破
    JiNeng   = 54,        -- 技能方案
    ZhiDian  = 55,        -- 质点
    XinWu    = 56,        -- 信物
    BaoShi   = 57,        -- 宝石
}

EC_ChronoCrossTaskType = {
    Date = 1,           -- 约会
    AllServer = 2,           -- 全服任务
    Single = 5,         --个人任务
    Special = 6,        --特殊任务
    Extra_Date = 7,     --1类型约会完成之后的额外约会
}

-- 折纸穿越约会状态
EC_ChronoCrossDatingStatus = {
    Lock = 0,    -- 不可约会
    Ing = 1,    -- 可约会
    Finish = 2,    -- 已完成
}

EC_DatingLetterStatus = {
    STATUS_LOCK = -1,    --为解锁
    STAUS_ING = EC_TaskStatus.ING,      --进行中
    STAUS_GET = EC_TaskStatus.GET,      --通关
}

EC_dragonBoat_Summon = {
    SUMMON_1 = 1,
    SUMMON_10 = 10,
}

EC_FavorDatingRewardStatus = {
    STATUS_LOCK = 1,
    STATUS_GET = 2,
    STATUS_GETED = 3,
}

EC_rechargeArray = {
    LIMIT_GIGT = 1,--限时礼包
    GIFT = 2, --礼包
    FUND = 3, --基金
    MONTH_CARD = 4, --月卡
    DAY_LIMIT = 5,--每日限定
    WEEK_LIMIT = 6,--每周限定
    MONTH_LIMIT = 7,--每月限定
    ACTIVITY_LIMIT = 8,--活动限定
    GROWUP_FUND = 9, --养成基金
}

EC_fund_status = {
    STATUS_LOCK = 1,
    STATUS_GET = 2,
    STATUS_GETED = 3,
}

EC_INVITE_TASK = {
    TASK_1 = 1,
    TASK_2 = 2,
    TASK_3 = 3,
}

EC_FRIENDHELPTASKSTATUS = {
    UNFINISHED = 1,
    FINISHED = 2,
    RECEIVED = 3,
}

EC_DanmuType = {
    ZNQ = 1, -- 周年庆活动弹幕    
    CG = 2, -- CG
    VIDEO = 3, -- 视频
    SCRIPT = 4, -- 剧情脚本
    Dating = 6, -- 约会弹幕
    EVALUATION = 10, -- 剧情脚本
}

EC_YearActivityEventType = {
    LEVEL = 1, -- 关卡   
    DATING = 2, -- 关卡   
    AWARD = 3, -- 奖励   
    START = 4, -- 开始   
    END = 5, -- 结束   
    SHOP = 6, -- 商店 
    SUMMON = 7, -- 召唤   
    LETTER = 8, -- 信件   
}

---个人履历
EC_PlayerResume = {
        NAME = 1,                           --玩家第一次起名-名字
        NAME_TIME = 2,                      --玩家第一次起名-时间
        LEVEL = 3,                          --玩家最高等级
        LEVEL_TIME = 4,                     --玩家最高等级-升级时间
        LOGIN_DAYS = 5,                     --玩家累计登录天数
        HERO_ID = 6,                        --玩家最早获得EX精灵-id
        HERO_TIME = 7,                      --玩家最早获得EX精灵-获得时间
        DATE_TIMES = 8,                     --玩家约会次数
        BATTLE_TIMES = 9,                   --玩家战斗次数
        TOUCH_HERO_ID = 10,                 --被触摸最多的精灵-id
        TOUCH_HERO_TIMES = 11,              --被触摸最多的精灵-次数
        DATING_HERO_ID = 12,                --约会次数最多的精灵-id
        DATING_HERO_TIMES = 13,             --约会次数最多的精灵-约会次数
        PLAYER_CREATE = 1001,               --/角色创建时间戳
        PLAYER_DAYS = 1002,                 --已创建天数
        FIRST_FRIEND_TIME = 1003,           --第一个好友时间
        FIRST_FRIEND_NAME = 1004,           --第一个好友名字
        MOST_CG_ROLE = 1005,                --CG最多的精灵id
        TOP3_POWER_HEROES = 1006,           --战力前三的英雄
        ONLINE_TIME = 1007,                 --游戏时长（秒）
        MOST_FAVOR_ROLE = 1008,             --好感度最高的精灵id
        MOST_DRESS_ROLE = 1009,             --时装最多的精灵id
}

--1电源开关，2点灯，3接电线，4迷宫
EC_CourageMiniGameType = {
    SWITCH = 1,
    LIGHT = 2,
    WIRE = 3,
    MAZE = 4,
}

--新手引导所用功能类型，指针对触发约会
EC_GuideFuncType = {
    Courage = 1,
}

EC_NetTeamType = {
    Normal = 1,    ---联机副本
    High = 2,      ---高级组队(春日特训)
    Osd  = 3,      ---夏拉姆
    FuShi = 4,     ---符石挑战
    Hunter = 5     ---追猎计划
}

EC_JOINTEAM_TYPE = {
    NORAML = 0,    ---非好友，非社团成员
    FRIEND = 1,    ---好友
    LEAGUE = 2,    ---社团成员
}

---1-挂机，2-钓鱼，3-饮料，4-点灯，5-占卜，6-拼图
EC_NewYearGameType = {
    Hook = 1,      ---挂机
    Fish = 2,      ---钓鱼
    Drink = 3,     ---饮料
    Light = 4,     ---点灯
    Divine = 5,    ---占卜
    Puzzle = 6,    ---拼图
}

-- 1-月卡特权, 2-周卡特权
EC_CardPrivilege = {
    Month = 1,
    Week  = 2
}

-- 师徒相关的类型
EC_FriendMasterType = {
    Master = 1,          -- 师父
    SameGate = 2,        -- 师门
    Apprentice = 3,      -- 徒弟
    ApplyApprentice = 4, -- 申请收徒
    ApplyMaster = 5,     -- 申请拜师
}

-- 师徒显示标识图片
EC_MasterTagImgSrc = {
    OutMaster = "ui/friend/master/tag_1.png",  -- 出师
    Master = "ui/friend/master/tag_2.png",     -- 师门
    SameGate = "ui/friend/master/tag_3.png",   -- 同门
    Apprentice = "ui/friend/master/tag_4.png", -- 徒弟
    Friend = "ui/friend/master/tag_5.png",     -- 好友
    Club = "ui/friend/master/tag_6.png",       -- 社团
}

---AfkActivity id
EC_AfkActivityID = {
    Main = 101      ---主线活动
}


ShipRoomType = {
    COMMAND = 1, -- 指挥室
    WEAPON = 2, -- 武器室
    ARMOR = 3, -- 护甲室
    ACCESSORIES = 4, -- 配件室
    COLLECT = 5, -- 采集室
    EXHIBITION = 6, -- 陈列室

}

-- 世界boss状态
EC_WorldBossType = {
    REST = 0,   -- 休息
    Normal = 1, -- 普通boss
    World = 2,  -- 世界boss
}

-- 服务器红点功能id
RedPointFunctionId = {
    Explore_collectFull = 1, -- 探索搜集已满红点
}

-- 剧情副本ID
EC_FUBENTHEATER_ID = {
    WanYouli = 1,
    SiSiNai  = 2,
    JuNai    = 3,
    KuangSan = 4,
}

-- 大世界多人房间类型
WorldRoomType = {
    OSD_WORLD = 1, -- 夏拉姆大世界普通房间
    OSD_UNION = 2, -- 夏拉姆大世界社团房间
    ZNQ_WORLD = 3, -- 周年庆大世界社团房间
    ZNQ_UNION = 4, -- 周年庆大世界社团房间
}

-- 大世界多人房间操作类型
WorldRoomOperateType = {
    ACTION_BUILD = 1, -- 建筑操作
    CHANGE_EFFECT = 2, -- 更换特效
    CHANGE_SKIN = 3, -- 更换皮肤
    PLAY_ACTION = 4, -- 播放动作，表情 
    CHANGE_POS = 5, -- 自动移动到目标位置
}

EC_SWITCH_TYPE = {
    EXCHANGE_INVITE = 1,    --是否接受气球交易开关
	TEAM_PRIVACY = 2,		--玩家的阵容隐私开关
}

--语言类型设置
EC_LanguageType = 
{
    Chinese = "",
    English = "_en",
}
