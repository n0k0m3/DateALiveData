
--[[
全局事件表配置:
    1. 事件名按模块分，命名规则：EV_模块名_事件名 = "全部名称小写"
    2. 事件尽量分模块放在一起，便于以后查看
    3. 写上每个事件的注释
]]--


-- 副本
EV_FUBEN_UPDATEMAINLINEPROGRESS = "ev_fuben_updatemainlineprogress"    -- 主线进度更新
EV_FUBEN_UPDATEMAINLINEPROGRESS2 = "ev_fuben_updatemainlineprogress2"    -- 主线进度更新（This is not what I want）
EV_FUBEN_PHASECOMPLETE = "ev_fuben_phasecomplete"     -- 主线剧情阶段结束
EV_FUBEN_ASSISTANTUPDATE = "ev_fuben_assistantupdate"    -- 助战列表更新
EV_FUBEN_LEVELGROUPREWARD = "ev_fuben_levelgroupreward"    -- 领取关卡组奖励
EV_FUBEN_LEVELVIEWCLOSED = "ev_fuben_levelviewclosed"    -- 关卡界面关闭
EV_FUBEN_DAILYBUYCOUNT = "ev_fuben_dailybuycount"    -- 日常副本购买次数
EV_FUBEN_LEVELINFOUPDATE = "ev_fuben_levelinfoupdate"    -- 日常副本购买次数
EV_FUBEN_UPDATEENDLESSINFO = "ev_fuben_updateendlessinfo"    -- 更新无尽回廊信息
EV_FUBEN_ENDLESSFIGHTSTART = "ev_fuben_endlessfightstart"    -- 无尽回廊战斗开始
EV_FUBEN_ENDLESSFIGHTVICTORY = "ev_fuben_endlessfightvictory"    --无尽回廊战斗胜利
EV_FUBEN_ENDLESSFIGHTFAILD = "ev_fuben_endlessfightfaild"    -- 无尽回廊战斗失败
EV_FUBEN_ENDLESS_UPDATERANK = "ev_fuben_endless_updaterank"    -- 无尽排行榜
EV_FUBEN_ENDLESS_CONTINUE = "ev_fuben_endless_continue"    -- 无尽副本继续下一关
EV_FUBEN_ENDLESS_BUFFER = "ev_fuben_endless_buffer"    -- 竞速模式关卡buff
EV_FUBEN_ENDLESS_JUMPLEVEL = "ev_fuben_endless_jumplevel"    -- 通知跳层
EV_FUBEN_BATTLEOVER_WIN = "ev_fuben_battleover_win"    -- 战斗结束胜利通知
EV_FUBEN_BATTLEOVER_LOSE = "ev_fuben_battleover_lose"    -- 战斗结束失败通知
EV_FUBEN_UPDATE_LIMITHERO = "ev_fuben_update_limithero"    -- 限制英雄信息
EV_FUBEN_UPDATE_CHALLENGE_COUNT = "ev_fuben_update_challenge_count"    -- 更新挑战次数
EV_FUBEN_PLOTLEVEL_BUY_COUNT = "ev_fuben_plotlevel_buy_count"    -- 主线副本购买次数
EV_FUBEN_ENTER_DATING_LEVEL = "ev_fuben_enter_dating_level"    -- 进入约会关卡
EV_FUBEN_SPRITE_UPDATE_BUFF = "ev_fuben_sprite_update_buff"    -- 精灵副本更新buff
EV_FUBEN_SPRITE_GET_REWARD = "ev_fuben_sprite_get_reward"    -- 精灵副本领取宝箱奖励
EV_FUBEN_SPRITE_UPDATE_INFO = "ev_fuben_sprite_update_info"    -- 刷新精灵副本信息
EV_FUBEN_SPRITE_EXTRA_UPDATE_INFO = "ev_fuben_sprite_extra_update_info"     --刷新精灵外传信息
EV_FUBEN_THEATER_BOSS_INFO = "ev_fuben_theater_boss_info"    -- 万由里boss信息
EV_FUBEN_THEATER_RANK = "EV_FUBEN_THEATER_RANK"    -- 万由里排行榜信息
EV_FUBEN_THEATER_NODE_REWARD = "ev_fuben_theater_node_reward"    --万由里节点奖励领取
EV_FUBEN_THEATER_UPDATE_NOTICE = "ev_fuben_theater_update_notice"    -- 万由里boss挑战信息更新
EV_FUBEN_THEATER_RECEIVE_REWARD = "ev_fuben_theater_receive_reward"    -- 万由里贡献度任务奖励领取
EV_FUBEN_THEATER_CONTRO_PROCESS = "ev_fuben_theater_contro_process"    -- 剧场副本流程控制数据获取成功
EV_FUBEN_ADD_DISPATCH_DANGUP = "EV_FUBEN_DISPATCH_DANGUP"    -- 副本派遣挂机
EV_FUBEN_CANCEL_DISPATCH_DANGUP = "EV_FUBEN_CANCEL_DISPATCH_DANGUP"    -- 取消挂机
EV_FUBEN_GET_DISPATCH_DANGUP_REWARD = "EV_FUBEN_GET_DISPATCH_DANGUP_REWARD"    -- 领取挂机奖励
EV_FUBEN_ADD_DISPATCH_HEROS = "EV_FUBEN_ADD_DISPATCH_HEROS"    -- 上阵挂机精灵
EV_FUBEN_SPEEDUP_DISPATCH = "EV_FUBEN_SPEEDUP_DISPATCH"    -- 加速完成挂机

-- 战斗
EV_BATTLE_FIGHTSTART = "EV_BATTLE_FIGHTSTART"      -- 战斗开始
EV_BATTLE_FIGHTOVER = "ev_battle_fightover"      -- 战斗结束
EV_RES_LOAD_STATUS  = "ev_res_load_status"       -- 资源加载进度
EV_RES_LOAD_CREATE_MODEL = "ev_res_load_create_model"       -- 创建模型
EV_BATTLE_END_TRIGGER_EVENT = "ev_battle_end_trigger_event" --触发器触发的战斗结束事件
-- 登录
EV_LOGIN_UPDATESERVERNAME = "ev_login_updateservername"   -- 登录界面更新服务器显示名称

-- 阵容
EV_FORMATION_CHANGE = "ev_formation_change"           -- 阵容数据更新
EV_UPDATE_PRE_TEAM = "EV_UPDATE_PRE_TEAM"             -- 预设队伍刷新
EV_SET_PRE_TEAM = "EV_SET_PRE_TEAM"                   -- 设置预设队伍

--英雄
EV_HERO_LEVEL_UP  	= "EV_HERO_LEVEL_UP"			--英雄升级
EV_HERO_REFRESH     = "EV_HERO_REFRESH"
EV_HERO_ACTIVECRYSTAL = "EV_HERO_ACTIVECRYSTAL"     --突破结晶
EV_HERO_ACTIVECRYSTAL_BATCH = "EV_HERO_ACTIVECRYSTAL_BATCH"
EV_HERO_PROPERTYCHANGE = "EV_HERO_PROPERTYCHANGE"   --属性改变
EV_HERO_ANGLE_UPGRADE_SKILL = "EV_HERO_ANGLE_UPGRADE_SKILL" --升级或降级天使技能
EV_HERO_ANGLE_CHANGE_TAB_NAME = "EV_HERO_ANGLE_CHANGE_TAB_NAME" --修改天使标签名字
EV_HERO_ANGLE_USE_TAB = "EV_HERO_ANGLE_USE_TAB"     --使用天使页
EV_HERO_ANGLE_LOAD_PASSIVE_SKILL = "EV_HERO_ANGLE_LOAD_PASSIVE_SKILL" --装备或卸载天使被动技能
EV_HERO_ANGLE_AWAKE = "EV_HERO_ANGLE_AWAKE" --天使觉醒
EV_HERO_PUT_SPRIT_POINTS = "EV_HERO_PUT_SPRIT_POINTS" --英雄灵力值加点
EV_HERO_RESET_SPRIT_POINTS = "EV_HERO_RESET_SPRIT_POINTS" --重置灵力点
EV_HERO_UPGRADE_SPRIT_POINTS = "EV_HERO_UPGRADE_SPRIT_POINTS" --灵力突破
EV_HERO_USE_ITEM_UP_SPRIT = "EV_HERO_USE_ITEM_UP_SPRIT" --灵力升级
EV_HERO_REFRESH_SPRIT = "EV_HERO_REFRESH_SPRIT" --灵力刷新
EV_HERO_ANGEL_BREAK = "EV_HERO_ANGEL_BREAK" --天使灵力突破



--聊天
EV_RECV_CHATINFO    = "ev_revc_chatinfo"            --接收到聊天消息
EV_PUSH_CHATINFOS    = "EV_PUSH_CHATINFOS"          --定时按时间段推送聊天
EV_RECV_PLAYERINFO  = "ev_revc_playerinfo"          --玩家基本信息
EV_BLOCK_PLAYERS    = "ev_block_players"            --屏蔽玩家聊天信息
EV_UNBLOCK_PLAYERS  = "ev_unblock_players"          --解锁屏蔽玩家聊天信息
EV_SWITCH_PRIVATE   = "ev_switch_private"           --切换到私聊
EV_REFRESH_WORLDROOM = "ev_refresh_worldRoom"       --刷新世界聊天房间号
EV_EV_REFRESH_TEAMYQ ="ev_refresh_teamYq"           --刷新邀请组队聊天信息
EV_CHAT_UPDATE_TEAM_INVITE = "ev_chat_update_team_invite" --刷新组队邀请消息
EV_DIFFICULTY_CHANGE = "ev_difficulty_change"        --难度选择变更
EV_AI_ADVICE = "EV_AI_ADVICE"                       -- ai通知

--好友
EV_ADD_FRIENDS       = "ev_add_friends"              --添加好友
EV_DELETE_FRIENDS    = "ev_delete_friends"           --删除好友

--约会
EV_DATING_EVENT = {
    refreshRole = "refreshRole",                --刷新看板娘相关信息
    refreshRoleModel = "refreshRoleModel",      --刷新看板娘模型
    switchRole = "switchRole",      --切换看板娘
    changeDress = "changeDress",                --换装
    refreshRoleDonate = "refreshRoleDonate",    --赠送礼物
    refreshFavorLevel = "refreshFavorLevel",    --好感度升级
    refreshFavorLevelUP = "refreshFavorLevelUP",--好感度升级
    refreshMainDS = "refreshMainDS",            --主线约会
    refreshDailyDS = "refreshDailyDS",          --日常约会
    refreshScore = "refreshScore",              --日常约会积分刷新
    refreshSettlement = "refreshSettlement",    --约会结算
    getDating = "getDating",                     --获取剧本
    refreshRedTips = "refreshRedTips",           --约会提示（约会触发，邀请触发，过期触发，未完成约会）
    cityDatingTips = "cityDatingTips",           -- 城市约会提示刷新
    unLockGoods = "unLockGoods",                 --解锁物品
    triggerScript = "triggerScript",             --触发剧本（特殊剧本）
    addRole = "addRole",                         --添加看板娘
    touchRoleToFavor = "touchRoleToFavor",       --触摸看板娘提升好感度提示
    touchRole = "touchRole",                     --触摸看板娘弹窗
    changeRoleRoom = "changeRoleRoom",           --更改房间
    unLockRoleRoom = "unLockRoleRoom",           --解锁房间
    datingFail = "datingFail",                   --约会失败（暂时支持主线约会失败）
    datingOverTime = "datingOverTime",            --约会过期（暂时支持邀请约会失败）
    acceptDating = "acceptDating",
    getMainList = "getMainlist",                  --获取主线列表相关状态信息
    getMainReward = "getMainReward",              --领取主线分支奖励
    triggerPhoneDating = "triggerPhoneDating",    --手机约会提示
    phoneDating = "phoneDating",                  --手机约会
    acceptPhoneDating = "acceptPhoneDating",      --点击选项后反馈
    miniGameCloseInfo = "miniGameCloseInfo",      --小游戏在剧本中返回消息
    delectCityDating = "delectCityDating",        --删除城市约会（出游，预定移除时）
    roomFuncRedPoint = "roomFuncRedPoint",        --房间功能红点刷新
    outTimePhoneDating = "outTimePhoneDating",    --手机约会过期
    datingcompleted = "datingcompleted",           --约会完成
    datingPhoneAward = "datingPhoneAward",        --手机约会完成奖励展示
    checkSendDialogue = "checkSendDialogue",      --检查自己发送的内容(在服务器过一遍屏蔽字库)
    robotDialogue = "robotDialogue",              --返回机器人的对话
    relieveForbid = "relieveForbid",              --解除精灵禁止状态
    closeSriptView = "closeSriptView",            --约会界面关闭
    onLogin = "onLogin",            --约会界面关闭
    getRoleAttrData = "getRoleAttrData",           -- 获得精灵属性值
    updateDanMuData = "updateDanMuData",           --刷新弹幕数据
}

--精灵
EV_ELVES_EVENT = {
    state = "state",                            --刷新状态
    showUI = "showUI",                          --打开精灵UI
    closeUI = "closeUI",                        --关闭精灵UI
}

--外传约会
EV_OUTSIDE_DATING_EVENT = {
    refreshOutsideMain = "refreshOutsideMain",   --刷新外传约会主界面信息
    refreshOutsideMenu = "refreshOutsideMenu",   --刷新外传约会菜单信息
    OutsideEntranceStartResult = "OutsideEntranceStartResult",  --外传事件开始请求结果
    OutsideOptionChoiceStatus = "OutsideOptionChoiceStatus", --外传选项可用状态请求结果
    OutsideScriptChoiceResult = "OutsideScriptChoiceResult",    --外传剧本选项选择结果
    QuitToMain = "QuitToMain",  --退到外传约会主界面
    LoadManualArchieveSuccess = "LoadManualArchieveSuccess",    --读取手动存档
}

-- 背包
EV_BAG_ITEM_UPDATE = "ev_bag_item_update"    -- 道具更新
EV_BAG_DRESS_UPDATE = "ev_bag_dress_update"  -- 时装更新
EV_BAG_EQUIPMENT_UPDATE = "ev_bag_equipment_update"  -- 装备更新
EV_BAG_SELL_PREVIEW = "ev_bag_sell_preview"     --道具出售结果预览
EV_BAG_NEW_EQUIPMENT_UPDATE = "ev_bag_new_equipment_update"  -- 新装备更新
EV_BAG_GEMS_UPDATE = "EV_BAG_GEMS_UPDATE"  -- 宝石更新
EV_BAG_RECOVER_ITEM = "EV_BAG_RECOVER_ITEM"  -- 新装备更新
EV_BAG_EXPLORE_TREATURE_UPDATE = "EV_BAG_EXPLORE_TREATURE_UPDATE"    -- 探索宝物更新
EV_BAG_EXPLORE_EQUIP_UPDATE = "EV_BAG_EXPLORE_EQUIP_UPDATE"    -- 探索装配更新

EV_BAG_USE_ITEM = "ev_bag_use_item"    -- 使用道具成功
EV_BAG_USE_TRAIL = "ev_bag_use_trail"    -- 使用试用卡成功

-- 商店
EV_STORE_BUY_SUCCESS = "ev_store_buy_success"    -- 购买成功
EV_STORE_REFRESH = "ev_store_refresh"    -- 商店刷新
EV_STORE_SELL_SUCCESS = "ev_store_sell_success"    -- 道具出售成功
EV_STORE_BUYINFO_UPDATE = "EV_STORE_BUYINFO_UPDATE"    -- 商店购买日志更新
EV_STORE_BUYRESOURCE = "EV_STORE_BUYRESOURCE"    -- 购买次数道具
EV_STORE_RESOURCEBUYLOG_UPDATE = "ev_store_resourcebuylog_update"    -- 次数道具购买日志更新
EV_STORE_UPDATE_CFG = "ev_store_update_cfg"    -- 更新商店配置

--小红点
EV_RED_POINT_UPDATE_CHAT = "ev_red_point_update_chat" --聊天小红点
EV_RED_POINT_UPDATE_MAIL = "ev_red_point_update_mail"    -- 邮件小红点

--玩家信息
EV_EXCHANGE_GIFT_CODE = "ev_exchange_gift_code"  --兑换码兑换礼包
EV_MODIFY_DEC = "ev_modify_dec" --修改宣言
EV_CHANGE_ASSIST =  "ev_change_assist" --更换助战
EV_UPDATE_PLAYERINFO = "ev_update_playerInfo" -- 刷新玩家信息
EV_PLAYINFO_CHANGE = "ev_playinfo_change"    -- 玩家信息变更
EV_CHANGE_NAME_ERROR = "ev_change_name_error" -- 玩家改名错误
EV_CHANGE_NAME_OK = "ev_change_name_ok" -- 玩家改名成功
EV_CHANGE_NAME_OK_TIP = "ev_change_name_ok_tip" -- 玩家改名成功提示

-- 城建
EV_CITY_TRANSFORM_START = "ev_city_transform_start"        -- 变换开始
EV_CITY_TRANSFORM_COMPLETE = "ev_city_transform_complete"  -- 变换结束
EV_CITY_UNLOCKBUILD_SUCCESS = "ev_city_unlockbuild_success"     -- 建筑解锁成功
EV_CITY_BUILD_BEGIN_UPGRADE = "ev_city_build_begin_upgrade"    -- 开始升级建筑
EV_CITY_BUILD_UPGRADEFINISH = "ev_city_build_upgradefinish"    -- 升级建筑完成
EV_CITY_BUILD_UPDATE = "ev_city_build_update"          -- 建筑更新
EV_CITY_SELECT_SPRITE = "ev_city_select_sprite"    -- 选择精灵
EV_CITY_WORKING_BEGIN = "ev_city_working_begin"    -- 开始打工
EV_CITY_WORKING_FINISH = "ev_city_working_finish"    -- 打工完成
EV_CITY_WORKING_GETREWARD = "ev_city_working_getreward"    -- 打完完成领奖
EV_CITY_WORKING_EVENT = "ev_city_working_event"    -- 打完事件触发
EV_CITY_INFO_CLOSE = "ev_city_info_startclose"    -- 城市信息界面关闭
EV_CITY_PART_TIME_JOB_LIST = "ev_city_part_time_joblist"    -- 城市兼职列表信息
EV_CITY_DO_PART_TIME_JOB = "ev_city_do_part_time_job"    -- 兼职任务
EV_CITY_PART_TIME_JOB_AWARD = "ev_city_part_time_jobaward"    -- 领取兼职任务奖励
EV_CITY_GIVE_UP_JOB = "ev_city_give_up_job"    -- 放弃兼职任务
EV_CITY_OPEN_ROOM = "ev_city_open_room"    -- 打开房间
EV_NEW_BUILDING_RES_SPEED_PART_TIME_JOB = "EV_NEW_BUILDING_RES_SPEED_PART_TIME_JOB" --兼职加速响应

--灵装
EV_EQUIPMENT_OPERATION = "EV_EQUIPMENT_OPERATION" -- 灵装操作
EQUIPMENT_CHANGE_SPECIAL_ATTR = "EQUIPMENT_CHANGE_SPECIAL_ATTR"
EQUIPMENT_REPLACE_SPECIAL_ATTR = "EQUIPMENT_REPLACE_SPECIAL_ATTR"
EQUIPMENT_LOCK_RESULT = "EQUIPMENT_LOCK_RESULT"
EQUIPMENT_RECYCLERESULTS = "EQUIPMENT_RECYCLERESULTS"
EQUIPMENT_REFORM_RESULT = "EQUIPMENT_REFORM_RESULT"
EQUIPMENT_GETRECYCLEITEMS = "EQUIPMENT_GETRECYCLEITEMS"
EQUIPMENT_CHANGE_SPECIAL_ATTRTIPS = "EQUIPMENT_CHANGE_SPECIAL_ATTRTIPS"
EQUIPMENT_RES_EQUIP_REMOULD_INFO = "EQUIPMENT_RES_EQUIP_REMOULD_INFO"
EQUIPMENT_STAR_UP_EQUIP_CHOOSE    = "EQUIPMENT_STAR_UP_EQUIP_CHOOSE"  --升星质点材料选择
EQUIPMENT_STAR_UP_OVER    = "EQUIPMENT_STAR_UP_OVER"  --升星完成

--质点突破
EV_EQUIP_STEP_UP = "EV_EQUIP_STEP_UP"                       --质点突破成功
EV_EQUIP_STEP_UP_PREVIEW = "EV_EQUIP_STEP_UP_PREVIEW"       --质点返还材料预览
EQUIPMENT_BACKUP_INFO    = "EQUIPMENT_BACKUP_INFO"  --装备保存方案
EQUIPMENT_SAVE_BACKUP_POS    = "EQUIPMENT_SAVE_BACKUP_POS"  --保存装备方案
EQUIPMENT_SAVE_BACKUP_NAME    = "EQUIPMENT_SAVE_BACKUP_NAME"  --设置方案名称
EQUIPMENT_USE_BACKUP_INFO    = "EQUIPMENT_USE_BACKUP_INFO"  --使用方案
EQUIPMENT_SELECT_CHOOSE_CONDITION = "EQUIPMENT_SELECT_CHOOSE_CONDITION"-- 装备更换筛选条件选择
EQUIPMENT_CONVERT_CHOOSE_CONDITION = "EQUIPMENT_CONVERT_CHOOSE_CONDITION"-- 装备洗练筛选条件选择

TOKEN_BACKUP_INFO = "TOKEN_BACKUP_INFO" -- 信物保存方案
TOKEN_SAVE_BACKUP_POS    = "EQUIPMENT_SAVE_BACKUP_POS"  --保存信物方案
TOKEN_SAVE_BACKUP_NAME    = "EQUIPMENT_SAVE_BACKUP_NAME"  --设置信物方案名称
TOKEN_USE_BACKUP_INFO    = "EQUIPMENT_USE_BACKUP_INFO"  --使用信物方案



--新装备羁绊相关
EQUIPMENT_DRESS_NEW_EQUIP = "EQUIPMENT_DRESS_NEW_EQUIP" --穿戴或卸下装备
EQUIPMENT_STRENGTHEN_NEW_EQUIP = "EQUIPMENT_STRENGTHEN_NEW_EQUIP" --强化装备
EQUIPMENT_ADVANCE_NEW_EQUIP = "EQUIPMENT_ADVANCE_NEW_EQUIP"  --进阶装备

--宝石相关
EQUIPMENT_GEM_DRESS_OR_DROP = "EQUIPMENT_GEM_DRESS_OR_DROP"  --宝石穿戴或卸下
EQUIPMENT_GEM_COMPOSE    = "EQUIPMENT_GEM_COMPOSE"  --宝石合成
EQUIPMENT_GEM_QUALITY_SORT    = "EQUIPMENT_GEM_QUALITY_SORT"  --宝石品质筛选
EQUIPMENT_GEM_TUZHI_SORT    = "EQUIPMENT_GEM_TUZHI_SORT"  --宝石图纸筛选
EQUIPMENT_GEM_REMOULD_GEM    = "EQUIPMENT_GEM_REMOULD_GEM"  --宝石重铸
EQUIPMENT_GEM_REMOULDED_GEM    = "EQUIPMENT_GEM_REMOULDED_GEM"  --宝石属性选择
EQUIPMENT_GEM_DECOMPOSE_GEM    = "EQUIPMENT_GEM_DECOMPOSE_GEM"  --宝石分解
EQUIPMENT_GEM_RECOMPOSE_GEM    = "EQUIPMENT_GEM_RECOMPOSE_GEM"  --宝石图纸合成



--看板娘
EV_SHOW_KANBAN = "EV_SHOW_KANBAN"
EV_HIDE_KANBAN = "EV_HIDE_KANBAN"
EV_KANBAN_CHANGE_SHOW_ONE = "EV_KANBAN_CHANGE_SHOW_ONE"
EV_KANBAN_SWITCH_SHOW_ONE = "EV_KANBAN_SWITCH_SHOW_ONE"

--邮件
EV_OPERATION_MAIL = "EV_OPERATION_MAIL"

-- 好友
EV_FRIEND_RECOMMENDFRIEND = "ev_friend_recommendfriend"    -- 推荐好友列表
EV_FRIEND_QUERYPLAYER = "ev_friend_queryplayer"    -- 查询好友
EV_FRIEND_OPERATEFRIEND = "ev_friend_operatefriend"    -- 操作好友
EV_FRIEND_REMOVEADDFRIEND = "ev_friend_removeaddfriend"    -- 删除推荐好友
EV_FRIEND_UPDATE = "ev_friend_update"    -- 好友数据更新
EV_FRIEND_INVITE_UPDATE = "EV_FRIEND_INVITE_UPDATE" --羁友更新
EV_FRIEND_WISHWORD_UPDATE = "EV_FRIEND_WISHWORD_UPDATE"  -- 好友寄语更新
EV_FRIEND_SENDWISH_SUCCESS = "EV_FRIEND_SENDWISH_SUCCESS" -- 好友寄语发送
EV_FRIEND_MASTER_UPDATE = "EV_FRIEND_MASTER_UPDATE" -- 师门或者徒弟列表刷新
EV_FRIEND_MASTERAPPLYLIST_UPDATE = "EV_FRIEND_MASTERAPPLYLIST_UPDATE"  -- 师傅徒弟申请列表刷新
EV_FRIEND_MASTERRECOMMEND_UPDATE = "EV_FRIEND_MASTERRECOMMEND_UPDATE"  -- 师徒推荐列表
EV_FRIEND_MASTERGETREWARD_UPDATE = "EV_FRIEND_MASTERGETREWARD_UPDATE"  -- 师徒领奖刷新
EV_FREND_MASTERGIVEGIFT_UPDATE = "EV_FREND_MASTERGIVEGIFT_UPDATE" -- 礼物赠送刷新
EV_FREND_MASTERGITGIFT_UPDATE = "EV_FREND_MASTERGITGIFT_UPDATE" -- 收到礼物刷新红点
EV_FRIEND_OUTMASTER_UPDATE = "EV_FRIEND_OUTMASTER_UPDATE"  -- 出师

-- 召唤
EV_SUMMON_RESULT = "ev_summon_result"    -- 召唤结果
EV_SUMMON_COMPOSE_UPDATE = "ev_summon_compose_update"    -- 更新合成
EV_SUMMON_COMPOSE_RECEIVE = "ev_summon_compose_receive"    -- 领取合成奖励
EV_SUMMON_TOUCH_CONTINUE = "ev_summon_touch_continue"    -- 显示高级奖励点击继续
EV_SUMMON_HISTORY = "ev_summon_history"    -- 召唤历史纪录
EV_SUMMON_SHOWRESULT_END = "ev_summon_showresult_end"    -- 召唤显示结果结束
EV_SUMMON_PANEL_INFO = "EV_SUMMON_PANEL_INFO"            -- 召唤面板信息
EV_SUMMON_UPATE_HERO = "EV_SUMMON_UPATE_HERO"            -- 召唤精准精灵
EV_SUMMON_UPATE_EQUIP = "EV_SUMMON_UPATE_EQUIP"          -- 召唤精准质点
EV_SUMMON_SELECT    = "EV_SUMMON_SELECT"                 -- 新手引导跳转
EV_SUMMON_COUNT_UPDATE = "EV_SUMMON_COUNT_UPDATE"    -- 召唤次数更新
EV_CHRISMAS_SUMMON_RECORD    = "EV_CHRISMAS_SUMMON_RECORD"  -- 圣诞召唤记录
EV_UPDATE_NOOBAWARD = "EV_UPDATE_NOOBAWARD"              --领取萌新召唤奖励
EV_BW_SUMMON_ACTIVE = "EV_BW_SUMMON_ACTIVE"                --大世界召唤
EV_BW_RANDOM_TARGET = "EV_BW_RANDOM_TARGET"                --大世界召唤随机目标
EV_UPDATE_SUMMONCONTRACT = "EV_UPDATE_SUMMONCONTRACT"       -- 等级礼包数据状态刷新
EV_SUMMON_HOTSPLOT_UPDATE = "ev_summon_hotsplot_update"    -- 热点召唤周期更新
EV_GM_SUMMON_RESULT = "EV_GM_SUMMON_RESULT"     --GM召唤刷新
EV_SUMMON_CELEBRATION_COUNT = "EV_SUMMON_CELEBRATION_COUNT"    -- 更新周年庆卡牌数量
EV_UPDATE_VOTE_DAYNUM = "EV_UPDATE_VOTE_DAYNUM"                   --刷新每日召唤次数

-- 任务更新
EV_TASK_UPDATE = "ev_task_update"    -- 任务更新
EV_TASK_RECEIVE = "ev_task_receive"    -- 领取奖励
EV_TASK_RECEIVE_LIST = "ev_task_receive_list"	--一键领取


-- GM
EV_GM_FIGHTSTART = "ev_gm_fightstart"    -- GM战斗开始
EV_GM_FIGHTOVER = "ev_gm_fightover"    -- GM战斗结束


-- 抓娃娃
EV_CATCHDOLL_POOL_INFO = "ev_catchdoll_pool_info"  -- 抓娃娃蛋池信息
EV_CATCHDOLL_START = "ev_catchdoll_start" -- 抓娃娃开始
EV_CATCHDOLL_REFRESH = "ev_catchdoll_refresh" -- 抓娃娃刷新
EV_CATCHDOLL_END = "ev_catchdoll_end" -- 抓娃娃结束

--充值
EV_RECHARGE_UPDATE = "EV_RECHARGE_UPDATE"
EV_MONTHCARD_STATUS_UPDATE = "EV_MONTHCARD_STATUS_UPDATE"
EV_MONTHCARD_RECHARGE_SUCESS = "EV_MONTHCARD_RECHARGE_SUCESS"
EV_MONTHCARD_GIFT_UPDATE = "EV_MONTHCARD_GIFT_UPDATE"
EV_LIMIT_GIFT_PUSH = "EV_LIMIT_GIFT_PUSH"
EV_GROWFUND_UPDATE = "EV_GROWFUND_UPDATE" -- 成长基金页面刷新
EV_WEEKCARD_UPDATE = "EV_WEEKCARD_UPDATE"  -- 周卡界面刷新
EV_PRIVILEGE_UPDATE = "EV_PRIVILEGE_UPDATE"  -- 特权刷新
EV_GOODS_EXCHANGE = "EV_GOODS_EXCHANGE"	--兑换

--广告
EV_MAIN_AD = "EV_MAIN_AD"

--广告
EV_SHOW_SHARE = "EV_SHOW_SHARE"
EV_SHOW_AWARD = "EV_SHOW_AWARD"
EV_UPDATE_RESUME = "EV_UPDATE_RESUME"

--皮肤
EV_HERO_CHANGE_SKIN = "EV_HERO_CHANGE_SKIN";

--活动
EV_ACTIVITY_UPDATE_UI = "EV_ACTIVITY_UPDATE_UI"
EV_ACTIVITY_LIST_CHANGE = "EV_ACTIVITY_LIST_CHANGE";

EV_ACTIVITY_SUBMIT_SUCCESS = "ev_activity_submit_success"    -- 提交活动条目成功
EV_ACTIVITY_UPDATE_PROGRESS = "ev_activity_update_progress"    -- 更新条目进度
EV_ACTIVITY_UPDATE_ITEM_INFO = "ev_activity_update_iteminfo"    -- 更新条目进度
EV_ACTIVITY_UPDATE_ACTIVITY = "ev_activity_update_activity"    -- 更新活动
EV_ACTIVITY_ASSIST_PROGRESS = "ev_activity_assist_progress"    -- 应援活动全服进度
EV_ACTIVITY_ASSIST_RANKING = "ev_activity_assist_ranking"    -- 应援活动排行榜
EV_ACTIVITY_LESS_RANK = "ev_activity_less_rank"    -- 万圣节活动排行榜
EV_ACTIVITY_MORE_RANK = "ev_activity_more_rank"    -- 万圣节活动排行榜
EV_ACTIVITY_REFRESH_ENTRUST = "EV_ACTIVITY_REFRESH_ENTRUST"    -- 委托活动刷新
EV_ACTIVITY_USE_FIREWORK = "EV_ACTIVITY_USE_FIREWORK"    -- 使用烟花成功
EV_ACTIVITY_REFRESH_NEWYEAR = "EV_ACTIVITY_REFRESH_NEWYEAR"    -- 新年约会活动刷新
EV_ACTIVITY_COMPOSE_SUC = "EV_ACTIVITY_COMPOSE_SUC"    -- 活动合成成功
EV_ACTIVITY_REFRESH_NIANBREAST = "EV_ACTIVITY_REFRESH_NIANBREAST"    -- 年兽刷新
EV_ACTIVITY_UPDATE_NEWYEAR_TASK = "EV_ACTIVITY_UPDATE_NEWYEAR_TASK"    -- 新年活动刷新
EV_ACTIVITY_WAR_ORDER_GET_REWARD = "EV_ACTIVITY_WAR_ORDER_GET_REWARD"    -- 战令奖励领取
EV_ACTIVITY_WAR_ORDER_UPDATE_INFO = "EV_ACTIVITY_WAR_ORDER_UPDATE_INFO"    -- 战令数据更新
EV_ACTIVITY_WAR_ORDER_UPGRADE_LEVEL = "EV_ACTIVITY_WAR_ORDER_UPGRADE_LEVEL"    -- 战令等级提升
EV_UPDATE_CHANGE_ASSIST_ADDRESS = "EV_UPDATE_CHANGE_ASSIST_ADDRESS"              --修改邮寄地址
EV_ACTIVITY_OVER_SERVER_SCORE = "EV_ACTIVITY_OVER_SERVER_SCORE"                 --在线积分活动
EV_GET_ASSIST_ADDRESS = "EV_GET_ASSIST_ADDRESS"              --获取邮寄地址
EV_SPRING_ACTIVITY_INIT = "EV_SPRING_ACTIVITY_INIT"              --获取邮寄地址
EV_ACTIVITY_DELETED = "EV_ACTIVITY_DELETED"              --活动删除


EV_NEW_YEAR_FUBEN_INFO_UPDATE = "EV_NEW_YEAR_FUBEN_INFO_UPDATE"            --新年活动副本数据更新
EV_NEW_YEAR_GAME_FINISH = "EV_NEW_YEAR_GAME_FINISH"                        --新年活动小游戏完成

EV_NEW_YEAR_FUBEN_INFO_UPDATE = "EV_NEW_YEAR_FUBEN_INFO_UPDATE"            --新年活动副本数据更新
EV_NEW_YEAR_GAME_FINISH = "EV_NEW_YEAR_GAME_FINISH"                        --新年活动小游戏完成

EV_ACTIVITY_BLACKWHITE_RANKING  = "EV_ACTIVITY_BLACKWHITE_RANKING"   --黑与白排行榜
EV_ACTIVITY_BLACKWHITE_Main  = "EV_ACTIVITY_BLACKWHITE_Main"   --黑与白主面板
EV_ACTIVITY_BLACKWHITE_Main_Update  = "EV_ACTIVITY_BLACKWHITE_Main_Update"   --黑与白主面板刷新


EV_SUMMON_RES_SIMULATE_SUMMON_INFO = "EV_SUMMON_RES_SIMULATE_SUMMON_INFO"	--接收模拟召唤的所有数据
EV_SUMMON_RES_SIMULATE_SUMMON = "EV_SUMMON_RES_SIMULATE_SUMMON"		--接收单次的召唤数据
EV_SUMMON_RES_SIMULATE_SUMMON_REPLACE = "EV_SUMMON_RES_SIMULATE_SUMMON_REPLACE" --接收保留操作后的数据
EV_SUMMON_RES_SIMULATE_SUMMON_EXCHANGE = "EV_SUMMON_RES_SIMULATE_SUMMON_EXCHANGE"	--接收兑换事件

--公告刷新
EV_NOTICE_UPDATE = "EV_NOTICE_UPDATE"

--组队战斗
EV_TEAM_FIGHT_LEVEL_STAT_LIST = "EV_TEAM_FIGHT_LEVEL_STAT_LIST" --收到组队副本关卡状态清单
EV_TEAM_FIGHT_TEAM_DATA         = "EV_TEAM_FIGHT_TEAM_DATA";
EV_TEAM_FIGHT_NOTIFY_KICK_OUT_TEAM     = "EV_TEAM_FIGHT_NOTIFY_KICK_OUT_TEAM";
EV_TEAM_FIGHT_MATCH_TIME_OUT    = "EV_TEAM_FIGHT_MATCH_TIME_OUT";
EV_TEAM_FIGHT_MATCH_CANCEL_FAIL = "EV_TEAM_FIGHT_MATCH_CANCEL_FAIL";
EV_TEAM_FIGHT_CREAT_TEAM        = "EV_TEAM_FIGHT_CREAT_TEAM";
EV_TEAM_FIGHT_SET_TEAM_STATUS   = "EV_TEAM_FIGHT_SET_TEAM_STATUS";
EV_TEAM_FIGHT_APPONT_LEADER     = "EV_TEAM_FIGHT_APPONT_LEADER";
EV_TEAM_FIGHT_JOIN_TEAM         = "EV_TEAM_FIGHT_JOIN_TEAM";
EV_TEAM_FIGHT_EXIT_TEAM         = "EV_TEAM_FIGHT_EXIT_TEAM";
EV_TEAM_FIGHT_CHANGE_HERO       = "EV_TEAM_FIGHT_CHANGE_HERO";
EV_TEAM_FIGHT_KICK_OUT          = "EV_TEAM_FIGHT_KICK_OUT";
EV_TEAM_FIGHT_SET_MEMBER_STATUS        = "EV_TEAM_FIGHT_SET_MEMBER_STATUS";
EV_TEAM_FIGHT_CANCEL_MATCH      = "EV_TEAM_FIGHT_CANCEL_MATCH";
EV_TEAM_FIGHT_FIGHT_REVIVE      = "EV_TEAM_FIGHT_FIGHT_REVIVE";
EV_TEAM_FIGHT_AUTO_JOIN         = "EV_TEAM_FIGHT_AUTO_JOIN"
EV_TEAM_FIGHT_CLOSE_NET_WAIT    = "EV_TEAM_FIGHT_CLOSE_NET_WAIT"; --关闭等待结束界面
EV_FUNC_STATE_CHANGE            = "EV_FUNC_STATE_CHANGE"; --功能开启状态变更
EV_TEAM_FIGHT_TEAMTIME_OUT_TEAM = "EV_TEAM_FIGHT_TEAMTIME_OUT_TEAM"--队伍超时踢出
EV_TEAM_BUY_CHANLENGE_COUNT = "EV_TEAM_BUY_CHANLENGE_COUNT" --组队副本购买挑战次数
EV_TEAM_RUN_BATTLE_SCENE = "EV_TEAM_RUN_BATTLE_SCENE" --组队副本即将切换到战斗场景
EV_TEAM_CLOSE_HERO_CHANGE_VIEW = "EV_TEAM_CLOSE_HERO_CHANGE_VIEW" --组队关闭人物切换
EV_TEAM_FIGHT_HERO_REWARD      = "EV_TEAM_FIGHT_HERO_REWARD" --組隊队员战斗奖励变更
EV_TEAM_IS_SHOWINROOM      = "EV_TEAM_IS_SHOWINROOM" --队伍是否展示到组队列表
EV_UPDATE_ROOMLIST             = "EV_UPDATE_ROOMLIST"    --刷新组队房间列表
EV_TEAM_MATCH_RANK = "EV_TEAM_MATCH_RANK";			--当前匹配的排名
EV_TEAM_FIGHT_OPEN_TEAM = "EV_TEAM_FIGHT_OPEN_TEAM"  --进入组队房间
EV_TEAM_PUSH_STATE = "EV_TEAM_PUSH_STATE"  --进入组队房间

EV_TEAMPVE_UPDATE_INFO = "EV_TEAMPVE_UPDATE_INFO"       --刷新春季特训状态信息
EV_TEAMPVE_LEVEL_INFO = "EV_TEAMPVE_LEVEL_INFO"         --春季特训关卡信息

EV_UPDATE_TEAM_HANDLE = "EV_UPDATE_TEAM_HANDLE"         --刷新组队操作界面

EV_BATTLE_BRUSH_MONSTER = "ev_battle_brush_monster"    -- 关卡编辑器刷怪
EV_SKILL_BRUSH_MONSTER = "ev_skill_brush_monster"    -- 技能刷怪
EV_PRACTICE_BRUSH_MONSTER = "ev_practice_brush_monster"    -- 练习模式刷怪
EV_BATTLE_CURTAIN = "EV_BATTLE_CURTAIN" --战斗幕布
EV_BATTLE_PLAYCG_ANIM = "EV_BATTLE_PLAYCG_ANIM" --战斗中播放CG动画
EV_BATTLE_PLAY_STORYTALK = "EV_BATTLE_PLAY_STORYTALK" --战斗中播放剧情对话
EV_BATTLE_CTRL_HANDLE = "EV_BATTLE_CTRL_HANDLE" --战斗中控制按键响应支持时间
EV_BATTLE_SUPER_MASK = "EV_BATTLE_SUPER_MASK" --战斗中全屏蒙版
EV_BATTLE_CTRLS_SHOW = "EV_BATTLE_CTRLS_SHOW" --战斗ui显示事件
EV_PRACTICE_SET_SKIN = "ev_practice_set_skin"    -- 灵装试用

--城建
EV_NEW_CITY = {
    resLoadStatus = "resLoadStatus",   --城建资源加载状态
    resUpdateFinish = "resUpdateFinish",--城建刷新加载结束
    cityUpdate = "cityUpdate", --城建城市刷新
    cityRemindEventSuccess = "cityRemindEventSuccess",--城建提醒消息处理成功
    favorDatingTestData = "favorDatingTestData", --主线测试消息
    enterMainLine = "enterMainLine",--进入主线
}

--城建约会相关
EV_NEWCITY_DATING_EVENT = {
    recvDatingLineStepInfo = "recvDatingLineStepInfo", --获得约会阶段信息
    refreshNewCityEvent = "refreshNewCityEvent",   --刷新城建事件
    refreshNewCityInfo = "refreshNewCityInfo", --刷新城建时间，属性信息
    OptionChoiceStatus = "OptionChoiceStatus", --选项可用状态请求结果
    ScriptChoiceResult = "ScriptChoiceResult",    --外传剧本选项选择结果
}


--料理制作
EV_FUNC_START_COOK              = "EV_FUNC_START_COOK"         --料理制作开始烹饪
EV_FUNC_AFTER_QTE               = "EV_FUNC_AFTER_QTE"          --qte操作完成之后
EV_FUNC_GET_BASE_AWARD          = "EV_FUNC_GET_BASE_AWARD"     --qte操作完成之后
EV_FUNC_NEW_FOOD                = "EV_FUNC_NEW_FOOD"           --检测是否有可烹饪的料理

--勋章
EV_MEDAL_RESP_ACTIVATE_MEDALS            = "EV_MEDAL_RESP_ACTIVATE_MEDALS"       --获取所有勋章
EV_MEDAL_READY_TO_REPLACE                = "EV_MEDAL_READY_TO_REPLACE"           --准备更换勋章
EV_MEDAL_WEAR_MEDAL_SUCCESS              = "EV_MEDAL_WEAR_MEDAL_SUCCESS"         --穿戴勋章
EV_MEDAL_DROP_MEDAL_SUCCESS              = "EV_MEDAL_DROP_MEDAL_SUCCESS"         --卸下勋章

--卡巴拉
EV_GET_TREE_INFO                = "EV_GET_TREE_INFO"           --获取卡巴拉树界面信息
EV_UPDATE_TREE_INFO             = "EV_UPDATE_TREE_INFO"        --刷新卡巴拉树界面信息
EV_FUNC_MOVE                    = "EV_FUNC_MOVE"               --移动事件反馈
EV_TRIGGER_EVENT                = "EV_TRIGGER_EVENT"           --移动触发事件
EV_UPDATE_FORMATION             = "EV_UPDATE_FORMATION"        --改变阵型信息
EV_UPDATE_KABALABAG             = "EV_UPDATE_KABALABAG"        --刷新卡巴拉背包
EV_UPDATE_KABALATASK            = "EV_UPDATE_KABALATASK"       --刷新卡巴拉任务
EV_UPDATE_HERO_INFECTION        = "EV_UPDATE_HERO_INFECTION"   --刷新英雄感染度
EV_TRIGGER_RANDOM_ATTACK        = "EV_TRIGGER_RANDOM_ATTACK"   --遭遇伏击事件
EV_TRIGGER_TRANSPORT            = "EV_TRIGGER_TRANSPORT"       --位置传送
EV_CLEAR_TILEDITEM              = "EV_CLEAR_TILEDITEM"         --清除格子上的道具
EV_UPDATE_RESOURCE              = "EV_UPDATE_RESOURCE"         --刷新资源(能量值,卡巴拉代币)
EV_SEARCH_RESULT                = "EV_SEARCH_RESULT"           --指定点探索结果反馈
EV_UPDATE_STORE                 = "EV_UPDATE_STORE"            --刷新商店数据
EV_GET_WORLD_INFO               = "EV_GET_WORLD_INFO"          --获取卡巴拉质点世界信息
EV_UPDATE_WORLD_INFO            = "EV_UPDATE_WORLD_INFO"       --刷新卡巴拉质点世界信息
EV_FLASH_RADAR                  = "EV_FLASH_RADAR"             --卡巴拉刷新雷达
EV_CG_END                       = "EV_CG_END"                  --cg对话播放完成
EV_GET_MINIMAP                  = "EV_GET_MINIMAP"             --打开小地图
EV_UPDATE_RANDOMEVENT           = "EV_UPDATE_RANDOMEVENT"      --刷新随机事件
EV_UPDATE_KABALABUFF            = "EV_UPDATE_KABALABUFF"       --刷新卡巴拉buff
EV_DISCOVER_TASK                = "EV_DISCOVER_TASK"           --发现任务
EV_UPDATE_HIDDENEVENT           = "EV_UPDATE_HIDDENEVENT"      --隐藏事件进度
EV_PLAY_HIDDENEVENT_EFFECT      = "EV_PLAY_HIDDENEVENT_EFFECT" --播放隐藏事件表现效果
EV_TRRIGGER_MINIGAME            = "EV_TRRIGGER_MINIGAME"       --触发小游戏
EV_REPLY_MINIGAME               = "EV_REPLY_MINIGAME"          --小游戏返回

EV_QLIPHOTH_SHOP_INFO           = "EV_QLIPHOTH_SHOP_INFO"       --卡巴拉商店请求

--评价
EV_COMMENT_COMMENTRESULT        = "EV_COMMENT_COMMENTRESULT"    --评价的结果
EV_COMMENT_GETCOMMENT           = "EV_COMMENT_GETCOMMENT"       --获取所有的评论
EV_COMMENT_PRISERESULT           = "EV_COMMENT_PRISERESULT"       --获取所有的评论

--手工制作
EV_FUNC_MANUAL_MAKING_INFO              = "EV_FUNC_MANUAL_MAKING_INFO"     --取得手工制作信息
EV_FUNC_START_MAKE_MANUAL               = "EV_FUNC_START_MAKE_MANUAL"      --开始手工制作返回
EV_FUNC_UPDATE_MANUAL_SCORE          = "EV_FUNC_UPDATE_MANUAL_SCORE"       --更新手工积分返回
EV_FUNC_GET_MANUAL_REWARD          = "EV_FUNC_GET_MANUAL_REWARD"           --领取奖励返回
EV_FUNC_MANUAL_RED_POINT               = "EV_FUNC_MANUAL_RED_POINT"           --检测是否有手工可做

EV_GET_ACTIVITYPOKER_REWAARD = "EV_GET_ACTIVITYPOKER_REWAARD"       --领取活动图鉴奖励
EV_COLLECT_UPDATE_INFO = "EV_COLLECT_UPDATE_INFO" --刷新图鉴

--登陆排队
EV_FUNC_LOGINWAITING            = "EV_FUNC_LOGINWAITING"        --登陆排队

--设置变更
EV_SETTING_CHANGE           = "EV_SETTING_CHANGE"        --设置变更

--玩家信息变更
EV_PLAYER_INFO_CHANGE = "EV_PLAYER_INFO_CHANGE"

--玩家开关更新
EV_PLAYER_SWITCH_UPDATE = "EV_PLAYER_SWITCH_UPDATE"

EV_MAIN_WENJUAN_UPDATE = "ev_main_wenjuan_update"    -- 问卷状态更新
EV_MAIN_FOCUS_UPDATE = "EV_MAIN_FOCUS_UPDATE"    -- 关注状态更新

EV_AVATAR_UPDATE = "EV_AVATAR_UPDATE"    -- 头像更新

EV_APP_ENTERBACKGROUND = "EV_APP_ENTERBACKGROUND"       --游戏切后台事件
EV_APP_ENTERFOREGROUND = "EV_APP_ENTERFOREGROUND"       --游戏切回来事件

EV_EXT_ASSET_DOWNLOAD_VIEW_CLOSE = "EV_EXT_ASSET_DOWNLOAD_VIEW_CLOSE" --关闭分包下载界面
EV_EXT_ASSET_DOWNLOAD_EXTLIST = "EV_EXT_ASSET_DOWNLOAD_EXTLIST"
EV_EXT_ASSET_DOWNLOAD_RETRY_EXTLIST = "EV_EXT_ASSET_DOWNLOAD_RETRY_EXTLIST"

--断线重连事件
EV_RECONECT_EVENT = "EV_RECONECT_EVENT"

--断线事件派发
EV_OFFLINE_EVENT = "EV_OFFLINE_EVENT"

EV_AI_MODIFY_LEVELEDITOR_EVENT = "ev_ai_modify_leveleditor_event"    -- ai修改关卡编辑器状态

--隐藏主界面live2d
EV_HIDE_MAIN_LIVE2D = "EV_HIDE_MAIN_LIVE2D"

--集会所
EV_AGORA = {
    ContributionUpdate = "ContributionUpdate",--贡献度更新
    ShowRollInfo = "ShowRollInfo",--显示跑马灯
    UpdateStationPlayerInfos = "UpdateStationPlayerInfos",--更新情报站玩家消息
    UpdateStationTopInfos = "UpdateStationTopInfos",--更新情报站置顶消息
    ComposeStatusUpdate = "ComposeStatusUpdate",--合成状态刷新
    MapBoxUpdate = "MapBoxUpdate",--地图宝箱刷新
    UpdateLevelInfo = "UpdateLevelInfo",--关卡刷新
}

--社团
EV_UNION_CREATE_UNION_SUCCESS   = "EV_UNION_CREATE_UNION_SUCCESS" --创建社团成功
EV_UNION_BASE_INFO_UPDATE       = "EV_UNION_BASE_INFO_UPDATE"     --社团信息更新
EV_UNION_QUERY_UNION_LIST       = "EV_UNION_QUERY_UNION_LIST" --请求社团列表
EV_UNION_SEARCH_UNION           = "EV_UNION_SEARCH_UNION" --搜索社团返回
EV_UNION_APPLY_JOIN_UNION       = "EV_UNION_APPLY_JOIN_UNION"  --申请加入返回
EV_UNION_FAST_JOIN_UNION        = "EV_UNION_FAST_JOIN_UNION"  --快速加入社团
EV_UNION_QUIT_UNION             = "EV_UNION_QUIT_UNION"  --退出社团
EV_UNION_DIABAND_UNION          = "EV_UNION_DIABAND_UNION"  --解散社团
EV_UNION_TRANSFER_LEADER        = "EV_UNION_TRANSFER_LEADER"  --转让团长
EV_UNION_IMPEACH_LEADER         = "EV_UNION_IMPEACH_LEADER"  --弹劾团长
EV_UNION_DELATE_TIME_UPDATE     = "EV_UNION_DELATE_TIME_UPDATE"  --弹劾时间更新
EV_UNION_OPERAT_APLIES          = "EV_UNION_OPERAT_APLIES"  --处理申请
EV_UNION_NOTIFY_UPDATE          = "EV_UNION_NOTIFY_UPDATE"  --动态更新
EV_UNION_MEMBER_UPDATE          = "EV_UNION_MEMBER_UPDATE"  --成员更新
EV_UNION_KICK_MEMBER            = "EV_UNION_KICK_MEMBER"  --踢出成员
EV_UNION_APPLY_UPDATE           = "EV_UNION_APPLY_UPDATE"  --申请更新
EV_UNION_TRAINMATRIX_REVERT     = "EV_UNION_TRAINMATRIX_REVERT"   --特训矩阵主题重置
EV_UNION_MODIFY_NAME            = "EV_UNION_MODIFY_NAME"    --社团名字修改
EV_UNION_DEGREE_CHANGE          = "EV_UNION_DEGREE_CHANGE"  --社团职位变更
EV_UNION_NOTICE_CHANGE          = "EV_UNION_NOTICE_CHANGE"  --社团公告修改
EV_UNION_FLAG_CHANGE            = "EV_UNION_FLAG_CHANGE"    --社团徽记修改
EV_UNION_EXP_LEVEL_CHANGE       = "EV_UNION_EXP_LEVEL_CHANGE"    --经验，等级更新
EV_UNION_LEVEL_CHANGE           = "EV_UNION_LEVEL_CHANGE"    --等级更新
EV_UNION_WEEK_EXP_CHANGE       = "EV_UNION_WEEK_EXP_CHANGE"    --周贡献更新
EV_UNION_GET_ACTIVE_REWARD      = "EV_UNION_GET_ACTIVE_REWARD"    --聚变器阶段奖励
EV_UNION_SEND_PACKET_SUCCESS    = "EV_UNION_SEND_PACKET_SUCCESS"    --发红包成功
EV_UNION_GET_SUPPLY_SUCCESS     = "EV_UNION_GET_SUPPLY_SUCCESS"    --领取空头补给成功
EV_UNION_GET_SUPPLY_RECORD      = "EV_UNION_GET_SUPPLY_RECORD"    --空头补给日志更新
EV_UNION_REDPACKET_INFO         = "EV_UNION_REDPACKET_INFO"        --聊天红包刷新
EV_UNION_INFO_RESET             = "EV_UNION_INFO_RESET"        --社团信息重置
EV_UNION_RED_PACKET_COUNT       = "EV_UNION_RED_PACKET_COUNT"        --社团红包数量更新
EV_UNION_IMPATCH_LIST           = "EV_UNION_IMPATCH_LIST"        --弹劾列表更新
EV_UNION_TRAIN_INFO_UPDATE      = "EV_UNION_TRAIN_INFO_UPDATE"        --特训信息更新
EV_UNION_GET_TRAIN_ACTIVE_REWARD      = "EV_UNION_GET_TRAIN_ACTIVE_REWARD"    --特训矩阵阶段奖励
EV_UNION_GET_TRAIN_SELF_ACTIVE_REWARD      = "EV_UNION_GET_TRAIN_SELF_ACTIVE_REWARD"    --特训矩阵个人积分奖励
EV_UNION_CHANGE_COUNTRY         = "EV_UNION_CHANGE_COUNTRY"  --社团国家信息修改


EV_VOICE_SDK_BACK = "EV_VOICE_SDK_BACK"

EV_KEYBOARD_UP = "EV_KEYBOARD_UP"
EV_WEBVIEW_CLOSE = "EV_WEBVIEW_CLOSE"
EV_WEBVIEW_URL_BACK = "EV_WEBVIEW_URL_BACK"

EV_NEW_GUIDE_COMPLETE = "EV_NEW_GUIDE_COMPLETE"


--物品回收返回
EV_ITEM_RECYCLING_RESULT = "EV_ITEM_RECYCLING_RESULT"

--大凉山探秘
EV_DAL_MAP = {
    TriggerEvent = "TriggerEvent",              --触发事件
    CleanItem = "CleanItem",                    --删除格子道具
    Move = "Move",                              --玩家移动
    Transfer = "Transfer",                      --传送
    UpdateMap = "UpdateMap",                    --刷新地图数据
    GetMap = "GetMap",                          --得到地图数据
    Task = "Task",                              --任务更新
    EventClear = "EventClear",                  --事件完成信息
    MiniGame = "MiniGame",                      --小游戏弹窗
    Formation = "Formation",                    --阵容
    CloseDal = "CloseDal",                      --关闭
    MiniGameReply = "MiniGameReply",            --小游戏反馈
    MiniMapSpwanTiled = "MiniMapSpwanTiled",    --小地图产生格子
    MiniMapSpwanItem = "MiniMapSpwanItem",      --小地图产生道具
    MiniMapPlayerMove = "MiniMapPlayerMove",    --小地图移动
    MiniMapCleanItem = "MiniMapCleanItem",      --小地图清除
    MiniMapTransfer = "MiniMapTransfer",        --小地图传送
}
-- 大凉山
EV_DLS_OPEN_FORCER = "ev_dls_open_forcer"    -- 宝库打开奖励
EV_DLS_LEVEL_UNLOCK = "ev_dls_level_unlock"    -- 关卡解锁
EV_DLS_TASK_COMPLETE = "ev_dls_task_complete"    -- 任务完成
EV_DLS_EVENT_COMPLETE = "ev_dls_task_complete"    -- 事件完成

-- 情人节活动
EV_VALENTINE_RANK_UPDATE = "ev_valentine_rank_update"    -- 排行榜刷新
EV_VALENTINE_COMPOSE = "ev_valentine_compose"    -- 巧克力合成
EV_VALENTINE_GIFT = "ev_valentine_gift"    -- 赠送礼物
EV_VALENTINE_COMPLETE_DATING = "ev_valentine_complete_dating"    -- 约会完成

-- 大富翁
EV_DFW_LUCKY_WHEEL = "ev_dfw_lucky_wheel"    -- 转动轮盘
EV_DFW_ROLL_DICE = "ev_dfw_roll_dice"    -- 掷色子
EV_DFW_UPDATE_BUFF = "ev_dfw_update_buff"    -- buff更新
EV_DFW_ENTER_MAIN = "EV_DFW_ENTER_MAIN"    -- 进入大富翁

EV_DFW_NEW_ROLL_DICE = "ev_dfw_new_roll_dice"   -- 新-掷色子
EV_DFW_NEW_UPDATE_CARD = "ev_dfw_new_update_card"   -- 新-更新道具卡
EV_DFW_NEW_GET_CARD = "ev_dfw_new_get_card"     -- 新-获得道具卡


--大世界(同屏)
EV_OSD =
{
    EV_CLICK_HERO_EVENT = "EV_CLICK_HERO_EVENT",     --同屏中点击角色事件
    EV_REFRESH_OSDROOM = "EV_REFRESH_OSDROOM" ,      --刷新同屏房间号
    EV_REFRESH_CHAPTERINFO = "EV_REFRESH_CHAPTERINFO" ,      --刷新同屏房间号
    EV_LEAVE ="EV_LEAVE" ,--离开大世界
    FOCUS_CHANGE = "FOCUS_CHANGE",
    CHATINFO_ADD = "CHATINFO_ADD", --聊天消息变更
    OPEN_HUNTING_INVITATION = "OPEN_HUNTING_INVITATION", -- 打开悬赏令界面
    HUNTING_INVITATION_RECORD = "HUNTING_INVITATION_RECORD", --邀请记录
}

OSDConnector_ConnectError ="OSDConnectError"
OSDConnector_Connected    ="OSDConnected"
-- 十香生日活动
EV_SXBIRTHDAY_CITYINFO_UPDATE = "ev_sxbirthday_cityinfo_update"    -- 城市信息更新
EV_SXBIRTHDAY_EXPLORE = "ev_sxbirthday_explore"    -- 探索
EV_SXBIRTHDAY_GET_REWARD = "ev_sxbirthday_get_reward"    -- 获取奖励


--天梯排行榜
EV_SKYLADDER_CURCIRCLE = "EV_SKYLADDER_CURCIRCLE"       -- 刷新本周期数据
EV_SKYLADDER_RANK = "EV_SKYLADDER_RANK"                 -- 天梯排行榜
EV_SKYLADDER_LASTCIRCLE = "EV_SKYLADDER_LASTCIRCLE"     -- 上期数据(周期，赛季)
EV_SKYLADDER_EQUIP = "EV_SKYLADDER_EQUIP"               -- 刷新天梯装备数据
EV_ADD_CARDS = "EV_ADD_CARDS"                           -- 新增卡牌后刷新
EV_UPDATE_CARD_FORMATION = "EV_UPDATE_CARD_FORMATION"   -- 刷新卡牌阵容
EV_UPDATE_CARD_LV = "EV_UPDATE_CARD_LV"                 -- 卡牌升级
-- 称号
EV_UPDATE_TITLE = "EV_UPDATE_TITLE"    -- 刷新称号主界面
EV_EQUIP_OR_TAKEOFF_TITLE = "EV_EQUIP_OR_TAKEOFF_TITLE"    -- 装备称号

-- 女仆咖啡厅
EV_COFFEE_MAIDINFO_UPDATE = "ev_coffee_maidinfo_update"    -- 女仆信息
EV_COFFEE_RECRUIT_MAID = "ev_coffee_recruit_maid"    -- 招募成功
EV_COFFEE_REFRESH_RECRUIT = "ev_coffee_refresh_recruit"    -- 招募刷新
EV_COFFEE_MAID_FEED = "ev_coffee_maid_feed"    -- 喂食
EV_COFFEE_MAID_CHANGE = "ev_coffee_maid_change"    -- 更换上阵
EV_COFFEE_UPDATE_LOG = "EV_COFFEE_UPDATE_LOG"  -- 更新日志
EV_COFFEE_UPDATE_ROLE = "EV_COFFEE_UPDATE_ROLE"  -- 更新看板
EV_COFFEE_ISLOCK_ROLE = "EV_COFFEE_ISLOCK_ROLE" -- 解锁看板

-- 改变背景
EV_CHANGE_MAINSCENE_INFO = "EV_CHANGE_MAINSCENE_INFO"   --改变主场景背景和音效

EV_MAIN_LAYER_CLOSE_CHAT = "EV_MAIN_LAYER_CLOSE_CHAT"   --主界面关闭聊天

--关闭主界面
EV_CLOSE_MAIN_LAYER = "EV_CLOSE_MAIN_LAYER"


--组队战斗举报成功
EV_REPORT_SUCCESS = "EV_REPORT_SUCCESS"

--排行更新信息
EV_RANK_NOTICE_UPDATE = "ev_rank_notice_update"   --排行榜消息更新


--社团追猎计划
EV_HUNTER_RANKLIST_GET = "EV_HUNTER_RANKLIST_GET"
EV_HUNTER_RANKLIST_UPDATE = "EV_HUNTER_RANKLIST_UPDATE"
EV_HUNTER_REWARDLIST_GET = "EV_HUNTER_REWARDLIST_GET"
EV_HUNTER_REWARDLIST_UPDATE = "EV_HUNTER_REWARDLIST_UPDATE"
EV_HUNTER_INFO_UPDATE = "EV_HUNTER_INFO_UPDATE"
EV_REPORT_SUCCESS = "EV_REPORT_SUCCESS"

--精灵试炼
EV_SIMULATION_TRIAL_UPDATE = "EV_SIMULATION_TRIAL_LEVEL_UPDATE"

EV_SIMULATION_TRIAL_TASK_REWARD = "EV_SIMULATION_TRIAL_RECV_REWARD"    -- 领取精灵试炼任务奖励

--嘉年华宾果游戏
EV_BINGOGAME_RESULT = "EV_BINGOGAME_RESULT"              --宾果游戏开牌结果
EV_BINGOGAME_SUMMON = "EV_BINGOGAME_SUMMON"              --宾果召唤

--结晶转化
EV_HERO_RES_DECOMPOSE_MATERIALS = "EV_HERO_RES_DECOMPOSE_MATERIALS"
EV_BINGOGAME_SUMMON = "EV_BINGOGAME_SUMMON"              --宾果召唤

EV_UPDATE_CHRONOCROSS_RANK = "EV_UPDATE_CHRONOCROSS_RANK"   --刷新排行榜
EV_UPDATE_SERVERPOINT = "EV_UPDATE_SERVERPOINT"             --刷新全服贡献点
EV_UPDATE_NOTICE = "EV_UPDATE_NOTICE"                       --刷新全服贡献消息
EV_UPDATE_LASTTIME = "EV_UPDATE_LASTTIME"                   --刷新上次更新时间


EV_GETFAVORDATING_REWARD = "EV_GETFAVORDATING_REWARD"       --好感度约会奖励
--礼包合集
EV_TRIGGER_LIMIT_GIFT = "EV_TRIGGER_LIMIT_GIFT"             --触发礼包推送
EV_RECHARGE_RES_RECEIVE_LEVEL_AWARD = "EV_RECHARGE_RES_RECEIVE_LEVEL_AWARD" --运营活动基金等级奖励   
EV_RECHARGE_RES_FREE_GIFT_REWARD = "EV_RECHARGE_RES_FREE_GIFT_REWARD" --运用活动 免费礼包奖励获取
EV_RECHARGE_GET_RECHARGE_CFG = "EV_RECHARGE_GET_RECHARGE_CFG"   --礼包数据更新

EV_ASSISTANCE_FRIENDHELPINFOS = "EV_ASSISTANCE_FRIENDHELPINFOS" --好友助力
EV_RESQUICKRECEIVEFRIENDHELPTASK = "EV_RESQUICKRECEIVEFRIENDHELPTASK" --好友助力 一键领取
EV_RESRECEIVEFRIENDHELPTASK = "EV_RESRECEIVEFRIENDHELPTASK" --好友助力完成任务领取
EV_RESREFRESHFRIENDHELPTASK = "EV_RESREFRESHFRIENDHELPTASK" --刷新好友助力信息
EV_RESFRIENDHELPACTIVITYPRE = "EV_RESFRIENDHELPACTIVITYPRE"--好友助力 商店地址预览
EV_RESFRIENDHELPREWARDADDRESS = "EV_RESFRIENDHELPREWARDADDRESS"

EV_YOUCI_RSP_YOUCI = "EV_YOUCI_RSP_YOUCI"    ---尤茨游戏数据
EV_YOUCI_RSP_ROLL_YOUCI = "EV_YOUCI_RSP_ROLL_YOUCI"  --扔尤茨响应
EV_YOUCI_RSP_MAN_REFRESH_YOUCI = "EV_YOUCI_RSP_MAN_REFRESH_YOUCI"  --尤茨奖池刷新响应
EV_YOUCI_RSP_YOUCI_RANK = "EV_YOUCI_RSP_YOUCI_RANK"   --尤茨排行榜信息
EV_HUNTER_TEAMFIGHTERROR = "EV_HUNTER_TEAMFIGHTERROR"

--看板轮播
EV_UPDATE_SWITCH_STATE = "EV_UPDATE_SWITCH_STATE"                 --刷新看板轮播状态
EV_UPDATE_SWITCH_LIST = "EV_UPDATE_SWITCH_LIST"                   --刷新看板轮播列表
EV_START_SWITCH_TIME = "EV_START_SWITCH_TIME"                     --重启计时

--周年庆典
EV_UPDATE_NEW_LUCKYPLAYER = "EV_UPDATE_NEW_LUCKYPLAYER"        --幸运儿列表
EV_ADD_NEW_LUCKYPLAYER = "EV_ADD_NEW_LUCKYPLAYER"              --添加新的幸运儿
EV_UPDATE_SIGN_NUM = "EV_UPDATE_SIGN_NUM"                      --更新签到数量
EV_UPDATE_BASE_ONFO = "EV_UPDATE_BASE_ONFO"                    --同步基础信息
EV_UPDATE_CHANGE_ADDRESS = "EV_UPDATE_CHANGE_ADDRESS"              --添加新的幸运儿
EV_DANMU_DISPACTH = "EV_DANMU_DISPACTH"                     --重启计时
EV_DANMU_SEND =  "EV_DANMU_SEND"
EV_DANMU_AFTER_SEND =  "EV_DANMU_AFTER_SEND"

-- 精灵调教
EV_ROLETEACHCURLAYER_REFRESH = "EV_ROLETEACHCURLAYER_REFRESH" -- 刷新当前打开页面
EV_ROLETEACHRED_REFRESH = "EV_ROLETEACHRED_REFRESH"           -- 刷新精灵调教红点
EV_ROLETEACH_SUBNUM = "EV_ROLETEACH_SUBNUM"                   -- 调教提交 收到回复 
--试胆大会
EV_COURAGE = {
    EV_ASK_MOVE = "EV_ASK_MOVE",                           --请求移动之后
    EV_HANDLE_EQUIP = "EV_HANDLE_EQUIP",                   --改变装备
    EV_UPDATE_FINISH = "EV_UPDATE_FINISH",                  --事件完成
    EV_UPDATA_MAP = "EV_UPDATA_MAP",                      --刷新地图数据
    EV_MINIGAME_START = "EV_MINIGAME_START",              --小游戏开始
    EV_MINIGAME_FINISH = "EV_MINIGAME_FINISH",              --小游戏完成
    EV_UPDATE_EVENT_LOG = "EV_UPDATE_EVENT_LOG",          --
    EV_MINIGAME_MOVE = "EV_MINIGAME_MOVE",                  --移动小游戏触发
    EV_MINIGAME_RESULT = "EV_MINIGAME_RESULT",              --小游戏结果
    EV_MINIGAME_DATING_RESULT = "EV_MINIGAME_DATING_RESULT",--小游戏约会结果
    EV_COURAGE_END = "EV_COURAGE_END",                      --游戏结算
    EV_UPDATE_AP = "EV_UPDATE_AP",                          --刷新AP值
    EV_NEWGUIDE_STATE = "EV_NEWGUIDE_STATE",                --新手引导状态
    EV_NEWGUIDE_BASEINFO = "EV_NEWGUIDE_BASEINFO",                --基础信息
    EV_RESCUR_HERO = "EV_RESCUR_HERO",                      --解救英雄
}
EV_GET_NEW_COURAGE_ITEM = "EV_GET_NEW_COURAGE_ITEM"        --获得新道具
EV_BLOCKGAME_INFO_RSP = "EV_BLOCKGAME_INFO_RSP" -- 图块游戏数据返回
EV_BLOCKGAME_ACTION_RSP = "EV_BLOCKGAME_ACTION_RSP" -- 图块游戏操作数据返回
EV_KSAN_CARDS = "EV_KSAN_CARDS"
EV_KSAN_MATCH_CARDS = "EV_KSAN_MATCH_CARDS"                 --卡牌匹配
EV_KUANGSAN_FUBEN_RANKS = "EV_KUANGSAN_FUBEN_RANKS" -- 排行榜数据返回
EV_KUANGSAN_FUBEN_CITYRSP = "EV_KUANGSAN_FUBEN_CITYRSP" -- 图块游戏操作数据返回
EV_ACTIVITY_UPDATE_HANGUP_EVENTLIST = "EV_ACTIVITY_UPDATE_HANGUP_EVENTLIST" 
EV_ACTIVITY_UPDATE_HANGUP_ROLEINFO = "EV_ACTIVITY_UPDATE_HANGUP_ROLEINFO" 
EV_ACTIVITY_UPDATE_HANGUP_SPECIALAWARD = "EV_ACTIVITY_UPDATE_HANGUP_SPECIALAWARD" 
EV_AFTER_HANDLE_GM_SKILL = "EV_AFTER_HANDLE_GM_SKILL"       --操作共鸣技能
EV_AFTER_UPGRADE_GM_SKILL = "EV_AFTER_UPGRADE_GM_SKILL"     --共鸣技能升级
EV_ACTIVITY_HANGUP_ROLE_LEVELUP = "EV_ACTIVITY_HANGUP_ROLE_LEVELUP" --精灵等级提升
EV_ACTIVITY_CALL_BACK_INFO = "EV_ACTIVITY_CALL_BACK_INFO"           --回归活动信息
EV_ACTIVITY_SHARE_COMPLETE = "EV_ACTIVITY_SHARE_COMPLETE"				--分享完成
EV_ACTIVITY_CALL_BACK_BIND = "EV_ACTIVITY_CALL_BACK_BIND"           --回归活动绑定

EV_UPDATE_LINKAGEHWX = "EV_UPDATE_LINKAGEHWX"            --海王星下卷刷新
EV_FLYTO_SECONDMAP = "EV_FLYTO_SECONDMAP"
EV_UPDATE_LINKAGEHWX_BUFF = "EV_UPDATE_LINKAGEHWX_BUFF"
EV_UPDATE_BUY_FIGHTCNT = "EV_UPDATE_BUY_FIGHTCNT"        --购买战斗次数
EV_UPDATE_HWX_TOWER = "EV_UPDATE_HWX_TOWER"        --刷新爬塔

--团购礼包
EV_GROUP_PURCHASE_CREATE = "EV_GROUP_PURCHASE_CREATE"           --创建团购
EV_GROUP_PURCHASE_REFRESH = "EV_GROUP_PURCHASE_REFRESH"         --刷新团购
EV_GROUP_PURCHASE_JOIN = "EV_GROUP_PURCHASE_JOIN"				--自己加入团购
EV_GROUP_PURCHASE_OTHER_JOIN = "EV_GROUP_PURCHASE_OTHER_JOIN"				--其他人加入团购
EV_GROUP_PURCHASE_GET = "EV_GROUP_PURCHASE_GET"					--领取团购
EV_GROUP_PURCHASE_CANCEL = "EV_GROUP_PURCHASE_CANCEL"           --取消团购
EV_GROUP_PURCHASE_SELF = "EV_GROUP_PURCHASE_SELF"				--请求自己团购信息
EV_GROUP_PURCHASE_QUERY_GIFT = "EV_GROUP_PURCHASE_QUERY_GIFT"				--查询礼包
EV_GROUP_PURCHASE_RETURN_MAIN = "EV_GROUP_PURCHASE_RETURN_MAIN"				--返回主界面
EV_GROUP_PURCHASE_OPEN_PANEL = "EV_GROUP_PURCHASE_OPEN_PANEL"				--打开房间
EV_GROUP_PURCHASE_CLOSE_PANEL = "EV_GROUP_PURCHASE_CLOSE_PANEL"				--关闭房间
EV_GROUP_PURCHASE_DISSLUTION = "EV_GROUP_PURCHASE_DISSLUTION"				--解散
EV_GROUP_PURCHASE_SHOW_HALL = "EV_GROUP_PURCHASE_SHOW_HALL"				--操作在大厅显示

--劳动节活动
EV_LOBAR_DAY_SCORE_RECEIVE = "EV_LOBAR_DAY_SCORE_RECEIVE"		--响应总积分
EV_LOBAR_DAY_RANK_RECEIVE = "EV_LOBAR_DAY_RANK_RECEIVE"			--响应排行
EV_LOBAR_DAY_CONVERT_PROGRESS = "EV_LOBAR_DAY_CONVERT_PROGRESS"			--劳动转换进度
EV_DFW_USE_SPECIAL_ITEM = "EV_DFW_USE_SPECIAL_ITEM"  -- 大富翁使用特殊道具

--魔王试炼玩法消息
EV_RECV_MONSTER_TRIAL_INFO = "EV_RECV_MONSTER_TRIAL_INFO"
EV_RECV_MONSTER_TRIAL_SETTLEMENT = "EV_RECV_MONSTER_TRIAL_SETTLEMENT"

--时之契约
EV_SZQY_RESP_MAIN_DATA = "EV_SZQY_MAIN_DATA"		--时之契约数据
EV_SZQY_RESP_STEP = "EV_SZQY_RESP_STEP"				--时之契约走步数
EV_SZQY_RESP_RESET = "EV_SZQY_RESP_RESET"			--时之契约重置

-- 全服支援
EV_ALLSERVER_ASSISTANCE_RANK = "EV_ALLSERVER_ASSISTANCE_RANK" -- 全服支援排行
EV_ALLSERVER_ASSISTANCE_AWARD = "EV_ALLSERVER_ASSISTANCE_AWARD" -- 领奖

--社团召回活动
EV_LEAGUE_BACK_ALL_INFO = "EV_LEAGUE_BACK_ALL_INFO"             --社团召回信息更新
EV_LEAGUE_BACK_SCORE_UPDATE = "EV_LEAGUE_BACK_SCORE_UPDATE"     --社团召回积分更新

-- 社团的世界boss
EV_LEAGUE_WORLDBOSS_INFO = "EV_LEAGUE_WORLDBOSS_INFO"                           -- 刷新世界boss界面
EV_LEAGUE_WORLDBOSS_MORALE_UPDATE = "EV_LEAGUE_WORLDBOSS_MORALE_UPDATE"         -- 士气值更新
EV_LEAGUE_WORLDBOSS_ATTACKINFO_UPDATE = "EV_LEAGUE_WORLDBOSS_ATTACKINFO_UPDATE" -- 社团玩家士气攻打信息更新
EV_LEAGUE_WORLDBOSS_ATTACKRANK_UPDATE = "EV_LEAGUE_WORLDBOSS_ATTACKRANK_UPDATE" -- 社团玩家伤害排行榜更新
EV_LEAGUE_WORLDBOSS_LEAGUERANK_UPDATE = "EV_LEAGUE_WORLDBOSS_LEAGUERANK_UPDATE" -- 社团伤害排行榜更新

---新探索
EC_GET_EXPLORE_AWARD = "EC_GET_EXPLORE_AWARD"                   ---获取探索奖励
EC_EXPLORE_QUICK = "EC_EXPLORE_QUICK"                           ---快速探索
EV_EXPLORE_FIGHTBOSS = "EV_EXPLORE_FIGHTBOSS"                   ---跳转boss
EV_EXPLORE_UPDATE_EVENT = "EV_EXPLORE_UPDATE_EVENT"             ---刷新事件信息
EV_FINISH_EXPLORE_DOT = "EV_FINISH_EXPLORE_DOT"                --完成探索点
EV_EXPLORE_JUMPCITY = "EV_EXPLORE_JUMPCITY"                      --城市跳转
EV_EXPLORE_REMOVE_EVENT = "EV_EXPLORE_REMOVE_EVENT"              --移除地图事件
EV_EXPLORE_ACTIVITY = "EV_EXPLORE_ACTIVITY"                      --刷新整个探索数据(当前城市国家等信息)
EV_EXPLORE_SHIPATTR = "EV_EXPLORE_SHIPATTR"                      --飞船属性
EV_EXPLORE_SKINCHANGE = "EV_EXPLORE_SKINCHANGE"                  -- 皮肤更换

EV_EXPLORE_UPGRADE_KNOWLEDGE = "EV_EXPLORE_UPGRADE_KNOWLEDGE"            --天赋升级成功
EV_EXPLORE_CABIN_REFRESH = "EV_EXPLORE_CABIN_REFRESH"            --刷新舱室数据
EV_EXPLORE_CABIN_EQUIP_REFRESH = "EV_EXPLORE_CABIN_EQUIP_REFRESH"            --刷新舱室数据
EV_EXPLORE_CABIN_TASK_REFRESH = "EV_EXPLORE_CABIN_TASK_REFRESH"            --刷新舱室数据
EV_EXPLORE_CABIN_TECH_REFRESH = "EV_EXPLORE_CABIN_TECH_REFRESH"            --刷新舱室数据
EV_EXPLORE_SHIP_REFRESH = "EV_EXPLORE_SHIP_REFRESH"                 --飞舰刷新
EV_EXPLORE_CHOOSE_HERO = "EV_EXPLORE_CHOOSE_HERO"                 --选择或者取消精灵
EV_EXPLORE_SHIP_CLOSE = "EV_EXPLORE_SHIP_CLOSE"  
EV_EXPLORE_TASK_RED_POINT = "EV_EXPLORE_TASK_RED_POINT"  
EV_EXLPORE_ALL_PASS_JUMP = "EV_EXLPORE_ALL_PASS_JUMP"   ----新增优化所有通关后飞船跳转

--花嫁投票
EV_VOTE_DRESS_SUCESS = "EV_VOTE_DRESS_SUCESS"	--投票确认
EV_VOTE_DRESS_UPDATE = "EV_VOTE_DRESS_UPDATE"	--票数更新
EV_VOTE_DRESS_CHANGE = "EV_VOTE_DRESS_CHANGE"	--切换时装

--端午挂架
EV_DUANWU_HANGUP_RECV_BUFFS = "EV_DUANWU_HANGUP_RECV_BUFFS"  -- checkBuff 返回
EV_DUANWU_HANGUP_RECV_FORT = "EV_DUANWU_HANGUP_RECV_FORT"  -- 据点刷新
EV_DUANWU_HANGUP_RECV_SUPPORTROLE = "EV_DUANWU_HANGUP_RECV_SUPPORTROLE"  -- 支援数据刷新
EV_DUANWU_HANGUP_RECV_SUPPORTROLELIST = "EV_DUANWU_HANGUP_RECV_SUPPORTROLELIST"  -- 支援角色列表返回
EV_DUANWU_HANGUP_RECV_FORT_FINISH = "EV_DUANWU_HANGUP_RECV_FORT_FINISH"

EV_DETECTIVE = {
    DETECTIVE_ASK_MOVE = "DETECTIVE_ASK_MOVE",                          --请求移动之后
    DETECTIVE_UPDATE_FINISH = "DETECTIVE_UPDATE_FINISH",                --事件完成
    DETECTIVE_CHOOSE_AREA = "DETECTIVE_CHOOSE_AREA",                      --切换房间区域
    DETECTIVE_UPDATE_EVENT_LOG = "DETECTIVE_UPDATE_EVENT_LOG",          --更新任务日志
    DETECTIVE_SETTLEMENT = "DETECTIVE_SETTLEMENT",                --周目结算
    DETECTIVE_PICTURE_GAME_FILISH = "DETECTIVE_PICTURE_GAME_FILISH",                --拼图游戏完成
    DETECTIVE_SIGN_UPDATE = "DETECTIVE_SIGN_UPDATE",                          --标记解锁
    DETECTIVE_VOTE_RESULT = "DETECTIVE_VOTE_RESULT",                          --标记解锁
    DETECTIVE_VOTE_RECORD = "DETECTIVE_VOTE_RECORD",                          --标记解锁
    DETECTIVE_CHAPTER_UPDATE = "DETECTIVE_CHAPTER_UPDATE",                          --周目数据更新
}

EV_RED_POINT_UPDATE_BY_SERVER = "EV_RED_POINT_UPDATE_BY_SERVER"
EV_UPDATE_TWOYEAR_FASHION = "EV_UPDATE_TWOYEAR_FASHION" --刷新2周年时装活动

EV_DRESS_RECEVIE_GROUP = "EV_DRESS_RECEVIE_GROUP"				--请求时装组
EV_DRESS_SET_SCUESS = "EV_DRESS_SET_SCUESS"				--请求时装组设置
EV_UPDATE_WISHTREE_LV = "EV_UPDATE_WISHTREE_LV"                               --刷新许愿树等级
EV_UPDATE_CLUB_WISHTREE_LV = "EV_UPDATE_CLUB_WISHTREE_LV"                     --刷新社团许愿树等级}

-- 2周年庆翻牌
EV_TURNTABLET2_DATAUPDATE = "EV_TURNTABLET2_DATAUPDATE" -- 数据更新
EV_TURNTABLET2_BEGINTURNTABLET = "EV_TURNTABLET2_UPDATE"  -- 开始翻牌
EV_TURNTABLET2_TURNTABLETRESULT = "EV_TURNTABLET2_TURNTABLETRESULT"  -- 翻牌结果
EV_TURNTABLET2_GONEXTFLOOR = "EV_TURNTABLET2_GONEXTFLOOR"  -- 前往下一层
EV_TURNTABLET2_CHOOSEPASSAWARD = "EV_TURNTABLET2_CHOOSEPASSAWARD"  -- 选择通关奖励

EV_BALLOON_FLY_SUCC = "EV_BALLOON_FLY_SUCC"                             --放飞气球通知
EV_BALLOON_EXCHANGE_CANCEL = "EV_BALLOON_EXCHANGE_CANCEL"               --主动取消交换气球
EV_BALLOON_EXCHANGE_REPLY = "EV_BALLOON_EXCHANGE_REPLY"                 --回应交易的返回
EV_BALLOON_EXCHANGE_NOTIFY = "EV_BALLOON_EXCHANGE_NOTIFY"               --通知双方交易的返回
EV_BALLOON_CHOOSE_UPDATE = "EV_BALLOON_CHOOSE_UPDATE"                   --交易中气球的变化
EV_BALLOON_EXCHANGE_RESULT = "EV_BALLOON_EXCHANGE_RESULT"               --交易结果返回


EV_WORLD_ROOM_SETTING_CHANGE = "EV_WORLD_ROOM_SETTING_CHANGE"               --大世界设置改变
EV_WORLD_ROOM_EXTDATA_RSP = "EV_WORLD_ROOM_EXTDATA_RSP"               --大世界扩展数据接收
EV_WORLD_ROOM_SETTING_CHANGE = "EV_WORLD_ROOM_SETTING_CHANGE"               --交易结果返回
EV_WORLD_AREA_DATA  = "EV_WORLD_AREA_DATA"
EV_WORLD_AREA_TIME  = "EV_WORLD_AREA_TIME"
EV_WORLD_CLOSE_BASE_INFO  = "EV_WORLD_CLOSE_BASE_INFO"
EV_WORLD_ROKER_VIEW_SHOW  = "EV_WORLD_ROKER_VIEW_SHOW"


EV_ACTIVITY_HALLOWEEN_PASS_RSP  = "EV_ACTIVITY_HALLOWEEN_PASS_RSP"

EV_PRE_HALLOWEEN_GHOST = "EV_PRE_HALLOWEEN_GHOST"
EV_PRE_HALLOWEEN_GIFT = "EV_PRE_HALLOWEEN_GIFT"


EV_TRAIT_COLLECTIONDID_CHANGE = "EV_TRAIT_COLLECTIONDID_CHANGE" --ios13 深色模式切换
EV_ACTIVITY_RESP_CRAZY_DIAMOND_DRAW = "EV_ACTIVITY_RESP_CRAZY_DIAMOND_DRAW" --招财猫活动

EV_ACTIVITY_RES_DRAW_COMPASS = "EV_ACTIVITY_RES_DRAW_COMPASS"  --罗盘活动抽奖响应事件

EV_TRECHARGE_RES_TOTAL_PAY_REWARD_INFO = "EV_TRECHARGE_RES_TOTAL_PAY_REWARD_INFO" 



EV_ACTIVITY_RES_DONATE_ACTIVITY = "EV_ACTIVITY_RES_DONATE_ACTIVITY"  --全服助力捐赠响应

EV_ACTIVITY_RES_UNION_RANK_ACT_SCORE = "ACTIVITY_RES_UNION_RANK_ACT_SCORE"  --白王应援排行

EV_ACTIVITY_RES_ACTIVITY_UNION_ITEM = "EV_ACTIVITY_RES_ACTIVITY_UNION_ITEM"  --社团助力社团积分
-- 地错活动
EV_LAND_TURNTABLET_INFO = "EV_LAND_TURNTABLET_INFO"  -- 地错基本信息
EV_LAND_TURNTABLET_REWARD = "EV_LAND_TURNTABLET_REWARD"  -- 地错翻牌奖励
EV_LAND_TURNTABLET_RANK = "EV_LAND_TURNTABLET_RANK"  -- 地错排名数据
EV_LINKAGE_HERO_UPDATE = "EV_LINKAGE_HERO_UPDATE"
EV_LINKAGE_ATTR_LEVELUP = "EV_LINKAGE_ATTR_LEVELUP"


--下卷应援
EV_CROSS_SUPPORT_INFO = "EV_CROSS_SUPPORT_INFO"


-- 喵咪咖啡
EV_MAOKA_ALLDATA_RSP = "EV_MAOKA_ALLDATA_RSP"
EV_MAOKA_RECRUIT_RSP = "EV_MAOKA_RECRUIT_RSP"
EV_MAOKA_MAKE_RSP    = "EV_MAOKA_MAKE_RSP"
EV_MAOKA_START_MAKE_RSP    = "EV_MAOKA_START_MAKE_RSP"
--冰雪节
EV_ICE_SNOW_UPGRADE = "EV_ICE_SNOW_UPGRADE"
EV_ICE_SNOW_BOOK_DATA = "EV_ICE_SNOW_BOOK_DATA"

EV_ICE_SNOW_LEVEL_DETAIL = "EV_ICE_SNOW_LEVEL_DETAIL"
EV_ICE_SNOW_GAME_OVER = "EV_ICE_SNOW_GAME_OVER"
EV_ICE_SNOW_FOCUS_LOCATION = "EV_ICE_SNOW_FOCUS_LOCATION"
-- 冰雪大作战
EV_SNOWFESTIVAL_FIGHT_BUFF_INFO = "EV_SNOWFESTIVAL_FIGHT_BUFF_INFO" -- buff信息

-- 反十活动
EV_FANSHI_AWARD_DATA = "EV_FANSHI_AWARD_DATA"  -- 反十返还奖励

EV_FRIEND_WISH_LIST = "EV_FRIEND_WISH_LIST"     --获取许愿列表
EV_BUILD_REPAIR_DATA = "EV_BUILD_REPAIR_DATA"     --建筑修复
EV_AFTER_BUILD_REPAIR = "EV_AFTER_BUILD_REPAIR" --提交了修复道具反馈
EV_NIANSHOU_FIGHT_ITEM_INFO = "EV_NIANSHOU_FIGHT_ITEM_INFO" -- 年兽作战道具选择信息

--情人节2021活动数据
EV_VALENTINESDAY_MAIN_INFO = "EV_VALENTINESDAY_MAIN_INFO"   --请人节活动数据
EV_VALENTINESDAY_FLOWERS_VOTES = "EV_VALENTINESDAY_FLOWERS_VOTES"   --鲜花投票
EV_VALENTINESDAY_RPOGRESS_REWARD = "EV_VALENTINESDAY_RPOGRESS_REWARD" --领取进度奖
-- 2021答题
EV_RIDDLE_GET_QUESDATA = "EV_RIDDLE_GET_QUESDATA"  -- 获得题目数据
EV_RIDDLE_ANSAWE_AWARD = "EV_RIDDLE_ANSAWE_AWARD"  -- 答题奖励

-- 春分赠礼合成
EV_SPRING_GIFT_DATA = "EV_SPRING_GIFT_DATA"


---无尽plus
EV_UPDATE_ENDLESSPLUS_ALLINFO = "EV_UPDATE_ENDLESSPLUS_ALLINFO"
EV_UPDATE_ENDLESSPLUS_FORMATION = "EV_UPDATE_ENDLESSPLUS_FORMATION"
EV_FUBEN_ENDLESSPLUS_CONTINUE = "EV_FUBEN_ENDLESSPLUS_CONTINUE"    -- 继续下一关