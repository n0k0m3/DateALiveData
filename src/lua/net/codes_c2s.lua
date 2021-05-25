local c2s = {}
--[[
	[1] = {--ReqRefreshGroupTeamList
		[1] = 'int32':giftId
	}
--]]
c2s.RECHARGE_REQ_REFRESH_GROUP_TEAM_LIST = 4380

--[[
	[1] = {--ReqEndlessBuff
		[1] = 'repeated int32':levelCids	[关卡id]
	}
--]]
c2s.ENDLESS_CLOISTER_REQ_ENDLESS_BUFF = 5382

--[[
	[1] = {--ReqVoteResult
	}
--]]
c2s.DETECTIVE_REQ_VOTE_RESULT = 8912

--[[
	[1] = {--ReqOperate
		[1] = 'int32':type	[ 操作类型]
		[2] = 'repeated int32':targets	[ 目标ID]
	}
--]]
c2s.FRIEND_REQ_OPERATE = 3074

--[[
	[1] = {--ReqComposeGem
		[1] = 'int32':id	[合成id]
		[2] = 'string':designId	[图纸id]
		[3] = 'repeated string':gemIds	[宝石id]
	}
--]]
c2s.EQUIPMENT_REQ_COMPOSE_GEM = 2834

--[[
	[1] = {--ReqStepEquip
		[1] = 'string':equipId	[要升阶的质点]
		[2] = 'string':costEquipId	[消耗的同名质点id]
	}
--]]
c2s.EQUIPMENT_REQ_STEP_EQUIP = 2860

--[[
	[1] = {--ReqEquipBackupInfo
	}
--]]
c2s.EQUIPMENT_REQ_EQUIP_BACKUP_INFO = 2841

--[[
	[1] = {--ReqWelfareInfo
	}
--]]
c2s.PLAYER_REQ_WELFARE_INFO = 288

--[[
	[1] = {--ReqExitFight
		[1] = 'bool':isExitFight	[ 解码器必须要有内容,所以加上这个bool]
		[2] = 'int32':hurt	[ 累计伤害]
	}
--]]
c2s.FIGHT_REQ_EXIT_FIGHT = 25608

--[[
	[1] = {--ReqManaLevelUp
		[1] = 'int32':id	[resonance表配置id]
	}
--]]
c2s.MANA_RESONANCE_REQ_MANA_LEVEL_UP = 7601

--[[
	[1] = {--Summon
		[1] = 'int32':cid	[召唤id]
		[2] = 'int32':cost	[消耗]
	}
--]]
c2s.SUMMON_SUMMON = 3329

--[[
	[1] = {--ReqSetNewEquipPlanName
		[1] = 'int32':heroId
		[2] = 'int32':index
		[3] = 'string':name
	}
--]]
c2s.EQUIPMENT_REQ_SET_NEW_EQUIP_PLAN_NAME = 2846

--[[
	[1] = {--ReqChasmStartFight
	}
--]]
c2s.CHASM_REQ_CHASM_START_FIGHT = 6145

--[[
	[1] = {--ProgressMsg
		[1] = 'int32':mainLineCid	[主线cid]
	}
--]]
c2s.DUNGEON_PROGRESS = 1795

--[[
	[1] = {--DestroyUnion
	}
--]]
c2s.UNION_DESTROY_UNION = 6665

--[[
	[1] = {--EquipMsg
		[1] = 'string':heroId	[英雄id]
		[2] = 'string':equipmentId	[灵装id]
		[3] = 'int32':position	[位置]
	}
--]]
c2s.EQUIPMENT_EQUIP = 2817

--[[
	[1] = {--ReqPlantLadderCardMsg
		[1] = 'int32':sourceCard	[源卡牌id]
		[2] = 'int32':targetCard	[目标卡牌id]
	}
--]]
c2s.LADDER_REQ_PLANT_LADDER_CARD = 8310

--[[
	[1] = {--ReqEndFight
		[1] = 'int32':randomSeed	[ 最终随机种子]
		[2] = 'bool':isWin	[ 是否胜利]
		[3] = {--repeated MemberData
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'int32':hurt	[ 累计伤害]
		},
		[4] = 'int32':fightTime	[ 战斗时间]
		[5] = 'int32':maxCombo	[ 战斗连击数]
		[6] = 'int32':killMonsterNum	[ 击杀怪物数]
		[7] = 'int32':killBossNum	[ 击杀boss数]
	}
--]]
c2s.FIGHT_REQ_END_FIGHT = 25605

--[[
	[1] = {--ReqStartFightEndless
	}
--]]
c2s.ENDLESS_CLOISTER_REQ_START_FIGHT_ENDLESS = 5378

--[[
	[1] = {--ReqGetExploreAwardMsg
		[1] = 'int32':id
	}
--]]
c2s.HANGUP_ACT_REQ_GET_EXPLORE_AWARD = 9009

--[[
	[1] = {--OfficeWorldInfoMsg
		[1] = 'int32':worldCid	[当前世界cid]
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_WORLD_INFO = 7202

--[[
	[1] = {--ReqShareComplete
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_SHARE_COMPLETE = 5177

--[[
	[1] = {--ReqSevenCarnival
	}
--]]
c2s.SIGN_REQ_SEVEN_CARNIVAL = 5160

--[[
	[1] = {--ReqResultPreview
		[1] = 'string':equipmentId	[灵装id]
	}
--]]
c2s.EQUIPMENT_REQ_RESULT_PREVIEW = 2827

--[[
	[1] = {--ReqEquipGem
		[1] = 'int32':type	[1装备 2卸下]
		[2] = 'int32':heroId	[英雄id]
		[3] = 'string':gemId	[ 宝石id]
		[4] = 'int32':index	[位置]
	}
--]]
c2s.EQUIPMENT_REQ_EQUIP_GEM = 2833

--[[
	[1] = {--ReqRecommendFriends
	}
--]]
c2s.FRIEND_REQ_RECOMMEND_FRIENDS = 3075

--[[
	[1] = {--ReqRefreshContract
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_REFRESH_CONTRACT = 5186

--[[
	[1] = {--ReqDetectiveExplore
		[1] = 'int32':chapterId	[周目id]
		[2] = 'int32':areaId	[区域id]
	}
--]]
c2s.DETECTIVE_REQ_DETECTIVE_EXPLORE = 8901

--[[
	[1] = {--ReqGetPlayerUnionReCallRank
		[1] = 'int32':index	[返回当前的页数]
	}
--]]
c2s.UNION_REQ_GET_PLAYER_UNION_RE_CALL_RANK = 6676

--[[
	[1] = {--ReqFriends
	}
--]]
c2s.FRIEND_REQ_FRIENDS = 3073

--[[
	[1] = {--ReqValentineData
	}
--]]
c2s.ACTIVITY2_REQ_VALENTINE_DATA = 9409

--[[
	[1] = {--ReqRelieveHeartState
		[1] = 'int32':roleId	[精灵id]
	}
--]]
c2s.DATING_REQ_RELIEVE_HEART_STATE = 1557

--[[
	[1] = {--ReqLimitlessSummonScoreReward
		[1] = 'int32':activityId	[活动Id]
		[2] = 'int32':rewardId	[奖励Id]
	}
--]]
c2s.LIMITLESS_SUMMON_REQ_LIMITLESS_SUMMON_SCORE_REWARD = 3504

--[[
	[1] = {--ExploreTreasureStarUpMsg
		[1] = 'string':id	[ 宝物uid]
		[2] = {--repeated TreasureStarCosts
			[1] = 'int32':index
			[2] = {--repeated TreasureStarCostInfo
				[1] = 'string':templateId	[ 宝物升星消耗道具]
				[2] = 'int32':count	[ 宝物升星消耗道具数量]
			},
		},
	}
--]]
c2s.EXPLORE_EXPLORE_TREASURE_STAR_UP = 7831

--[[
	[1] = {--ReqReceiveGroupGift
		[1] = 'int32':giftId
	}
--]]
c2s.RECHARGE_REQ_RECEIVE_GROUP_GIFT = 4381

--[[
	[1] = {--ReqTrainDungeonInfo
	}
--]]
c2s.CHASM_REQ_TRAIN_DUNGEON_INFO = 6152

--[[
	[1] = {--OpenRedPacket
		[1] = 'int32':id	[ 红包id]
		[2] = 'int32':senderId	[ 发红包角色id]
		[3] = 'int64':createTime	[ 红包创建时间]
	}
--]]
c2s.UNION_OPEN_RED_PACKET = 6660

--[[
	[1] = {--ReqEquipPortrait
		[1] = 'int32':cid
	}
--]]
c2s.PORTRAIT_REQ_EQUIP_PORTRAIT = 7002

--[[
	[1] = {--ChangeSpecialAttrMsg
		[1] = 'string':sourceEquipmentId	[洗练灵装id]
		[2] = 'repeated int32':oldAttrIndex	[被洗练属性索引]
		[3] = 'string':costEquipmentId	[被消耗灵装id]
		[4] = 'repeated int32':costAttrIndex	[被消耗灵装的属性索引]
	}
--]]
c2s.EQUIPMENT_CHANGE_SPECIAL_ATTR = 2819

--[[
	[1] = {--TechTreeInfo
		[1] = 'int32':techType
		[2] = 'int32':nationId	[如果是国家天赋,则发送国家id,如果是形态天赋没有数据]
	}
--]]
c2s.EXPLORE_TECH_TREE_INFO = 7828

--[[
	[1] = {--ReqLoadProgress
		[1] = 'int32':progress	[进度]
	}
--]]
c2s.FIGHT_REQ_LOAD_PROGRESS = 25612

--[[
	[1] = {--ReqRiddleOnce
		[1] = 'int32':answer	[玩家答案]
	}
--]]
c2s.ACTIVITY2_REQ_RIDDLE_ONCE = 9408

--[[
	[1] = {--ReqLeveNewWorld
	}
--]]
c2s.NEW_WORLD_REQ_LEVE_NEW_WORLD = 6805

--[[
	[1] = {--ReqAITrainingAudit
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'int32':type	[类型- 0 审核中 1 审核通过 2 审核失败    //类型- 0 审核中 1 审核通过 2 审核失败]
		[3] = 'int32':targetPage	[目标页数]
		[4] = 'string':lastAid	[旧页最后一个条目id,用于无限翻页.目标页数在服务器缓存内可不传,超出不传则返回第一页数据]
	}
--]]
c2s.DATING_REQ_AITRAINING_AUDIT = 1568

--[[
	[1] = {--ReqCrazyDiamondDraw
		[1] = 'int32':activityId	[ 活动ID]
		[2] = 'bool':isDraw	[ true: 表示为抽奖,false:表示为获取活动信息]
	}
--]]
c2s.ACTIVITY_REQ_CRAZY_DIAMOND_DRAW = 5303

--[[
	[1] = {--ReqChangeHeroSkin
		[1] = 'string':heroId
		[2] = 'string':skinId
		[3] = 'bool':isSwitch
	}
--]]
c2s.HERO_REQ_CHANGE_HERO_SKIN = 1036

--[[
	[1] = {--ReqDynamicCommodity
	}
--]]
c2s.STORE_REQ_DYNAMIC_COMMODITY = 2566

--[[
	[1] = {--ReqRefreshFightPower
	}
--]]
c2s.EXPLORE_REQ_REFRESH_FIGHT_POWER = 7837

--[[
	[1] = {--ReqGetNewEquipPlans
		[1] = 'int32':heroId
	}
--]]
c2s.EQUIPMENT_REQ_GET_NEW_EQUIP_PLANS = 2845

--[[
	[1] = {--ReqChooseItem
		[1] = 'int32':index	[索引]
	}
--]]
c2s.ZILLIONAIRE_REQ_CHOOSE_ITEM = 5222

--[[
	[1] = {--NewReqYearActivityConfig
	}
--]]
c2s.ACTIVITY_NEW_REQ_YEAR_ACTIVITY_CONFIG = 5145

--[[
	[1] = {--ReqRankActivity
		[1] = 'int32':activityId	[ 活动ID]
	}
--]]
c2s.ACTIVITY_REQ_RANK_ACTIVITY = 5132

--[[
	[1] = {--ReqUseSkillStrategy
		[1] = 'string':heroId
		[2] = 'int32':skillStrategyId
	}
--]]
c2s.HERO_REQ_USE_SKILL_STRATEGY = 1040

--[[
	[1] = {--ReqNewWorldChat
		[1] = 'string':content	[  内容;]
	}
--]]
c2s.NEW_WORLD_REQ_NEW_WORLD_CHAT = 6808

--[[
	[1] = {--ReqSpecialTrainInfo
	}
--]]
c2s.CHASM_REQ_SPECIAL_TRAIN_INFO = 6151

--[[
	[1] = {--ReqKurumiHistoryRank
	}
--]]
c2s.ACTIVITY_REQ_KURUMI_HISTORY_RANK = 5164

--[[
	[1] = {--ReqGuideInfo
	}
--]]
c2s.EXPLORE_REQ_GUIDE_INFO = 7839

--[[
	[1] = {--ReqStartSpecialMakeFormula
	}
--]]
c2s.ACTIVITY_REQ_START_SPECIAL_MAKE_FORMULA = 5221

--[[
	[1] = {--GetBuyRecordInfo
	}
--]]
c2s.RECHARGE_GET_BUY_RECORD_INFO = 4357

--[[
	[1] = {--ReqGetFriendInviteInfo
	}
--]]
c2s.FRIEND_REQ_GET_FRIEND_INVITE_INFO = 3078

--[[
	[1] = {--ExploreEventStartBattle
		[1] = 'int32':activityId
		[2] = 'int32':nationId
		[3] = 'int32':cityId
		[4] = 'int32':eventId
	}
--]]
c2s.EXPLORE_EXPLORE_EVENT_START_BATTLE = 7818

--[[
	[1] = {--OfficePointExploreloMsg
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_POINT_EXPLORELO = 7217

--[[
	[1] = {--RecordClientErr
		[1] = 'string':err	[数据]
	}
--]]
c2s.PLAYER_RECORD_CLIENT_ERR = 279

--[[
	[1] = {--ReqNewbieStepInfo
	}
--]]
c2s.SUMMER_COURAGE_REQ_NEWBIE_STEP_INFO = 6914

--[[
	[1] = {--ReqYearResumeInfo
	}
--]]
c2s.PLAYER_REQ_YEAR_RESUME_INFO = 294

--[[
	[1] = {--ReqUpgradeLadderCard
		[1] = 'int32':cardId	[卡牌id]
	}
--]]
c2s.LADDER_REQ_UPGRADE_LADDER_CARD = 8309

--[[
	[1] = {--ReqHistoryRecord
		[1] = 'repeated int32':type	[ 1 钻石召唤 2 友情召唤 3 指定召唤]
	}
--]]
c2s.SUMMON_REQ_HISTORY_RECORD = 3335

--[[
	[1] = {--ReqAITrainingInfo
		[1] = 'int32':roleId	[精灵ID]
	}
--]]
c2s.DATING_REQ_AITRAINING_INFO = 1563

--[[
	[1] = {--ReqIndentureInfo
	}
--]]
c2s.INDENTURE_REQ_INDENTURE_INFO = 8201

--[[
	[1] = {--ReqBuyResources
		[1] = 'int32':cid
		[2] = 'int32':num
	}
--]]
c2s.PLAYER_REQ_BUY_RESOURCES = 275

--[[
	[1] = {--ReqSimulateSummonInfo
	}
--]]
c2s.SUMMON_REQ_SIMULATE_SUMMON_INFO = 3349

--[[
	[1] = {--ExploreTaskGetAward
		[1] = 'int32':taskId
	}
--]]
c2s.EXPLORE_EXPLORE_TASK_GET_AWARD = 7812

--[[
	[1] = {--ReqUseEquipBackup
		[1] = 'int32':id	[ 方案id]
		[2] = 'int32':heroCid	[英雄]
	}
--]]
c2s.EQUIPMENT_REQ_USE_EQUIP_BACKUP = 2844

--[[
	[1] = {--ReqAllManaInfo
	}
--]]
c2s.MANA_RESONANCE_REQ_ALL_MANA_INFO = 7603

--[[
	[1] = {--ReqEndlessCloisterInfo
	}
--]]
c2s.ENDLESS_CLOISTER_REQ_ENDLESS_CLOISTER_INFO = 5377

--[[
	[1] = {--ReqChangeUiChange
		[1] = 'int32':cid
	}
--]]
c2s.MEDAL_REQ_CHANGE_UI_CHANGE = 3011

--[[
	[1] = {--ReqAITrainingQuestions
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'int32':targetPage	[目标页数]
		[3] = 'string':lastQid	[旧页最后一个问题id,用于无限翻页.目标页数在服务器缓存内可不传,超出不传则返回第一页数据]
	}
--]]
c2s.DATING_REQ_AITRAINING_QUESTIONS = 1565

--[[
	[1] = {--ReqEquipItem
		[1] = 'int32':itemCid	[道具配置ID]
	}
--]]
c2s.ZILLIONAIRE_REQ_EQUIP_ITEM = 5321

--[[
	[1] = {--ReqNeptune2ndHalfMap
		[1] = 'int32':map	[地图]
	}
--]]
c2s.NEPTUNE2ND_HALF_REQ_NEPTUNE2ND_HALF_MAP = 7707

--[[
	[1] = {--ReqNotice
	}
--]]
c2s.ODEUM_REQ_NOTICE = 6502

--[[
	[1] = {--ReqBossState
		[1] = 'int32':id	[Boss ID]
		[2] = 'int32':posX	[位置X]
		[3] = 'int32':posY	[位置Y]
		[4] = 'int32':dir	[角色朝向]
		[5] = 'int32':hp	[角色血量]
		[6] = 'int32':operate	[操作]
		[7] = 'int32':sp	[怒气]
	}
--]]
c2s.FIGHT_REQ_BOSS_STATE = 25611

--[[
	[1] = {--ReqAnnivPassReward
		[1] = 'int32':id	[选择的配置表id]
	}
--]]
c2s.ANNIVERSARY2ND_REQ_ANNIV_PASS_REWARD = 9204

--[[
	[1] = {--NewReqActivityItems
	}
--]]
c2s.ACTIVITY_NEW_REQ_ACTIVITY_ITEMS = 5127

--[[
	[1] = {--ReqQuickExplorationMsg
		[1] = 'int32':activityId	[ 活动id]
	}
--]]
c2s.EXPLORE_REQ_QUICK_EXPLORATION = 7834

--[[
	[1] = {--ReqSwitchList
	}
--]]
c2s.ACTIVITY_REQ_SWITCH_LIST = 5200

--[[
	[1] = {--ReqCompose
		[1] = 'int32':id	[合成id]
		[2] = 'int32':count	[合成数量]
	}
--]]
c2s.CHRISTMAS_REQ_COMPOSE = 6602

--[[
	[1] = {--ReqUploadHandIntegral
		[1] = 'int32':manualId	[要制作手工id]
		[2] = 'int32':integral	[积分]
		[3] = 'int32':stime	[开始时间]
		[4] = 'int32':etime	[结束时间]
	}
--]]
c2s.NEW_BUILDING_REQ_UPLOAD_HAND_INTEGRAL = 2082

--[[
	[1] = {--ExploreTaskAcceleration
		[1] = 'int32':taskId
	}
--]]
c2s.EXPLORE_EXPLORE_TASK_ACCELERATION = 7810

--[[
	[1] = {--ReqGameStart
		[1] = 'int32':id	[游戏id,1电源开关,2点灯,3接电线,4迷宫]
	}
--]]
c2s.SUMMER_COURAGE_REQ_GAME_START = 6907

--[[
	[1] = {--ReqSetUiChange
		[1] = 'int32':id	[配置id]
		[2] = 'int32':state	[0 不变, 1 变]
	}
--]]
c2s.PLAYER_REQ_SET_UI_CHANGE = 303

--[[
	[1] = {--ReqSpecialMakeFormula
		[1] = {--repeated CatGoodExpItem
			[1] = 'int32':itemId	[道具id]
			[2] = 'int32':num	[道具数量]
		},
	}
--]]
c2s.ACTIVITY_REQ_SPECIAL_MAKE_FORMULA = 5226

--[[
	[1] = {--ReqNewPlayerGuide
		[1] = 'int32':guideId	[ 玩家当前已完成Id]
	}
--]]
c2s.PLAYER_REQ_NEW_PLAYER_GUIDE = 278

--[[
	[1] = {--ReqResetFlopGame
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_RESET_FLOP_GAME = 5158

--[[
	[1] = {--ReqSummonPanelInfo
	}
--]]
c2s.SUMMON_REQ_SUMMON_PANEL_INFO = 3336

--[[
	[1] = {--ReqSendSpringWish
		[1] = 'int32':friendId	[朋友id]
		[2] = 'string':content	[寄语]
	}
--]]
c2s.SPRING_WISH_REQ_SEND_SPRING_WISH = 7501

--[[
	[1] = {--GetTotalPayRewardCfg
	}
--]]
c2s.RECHARGE_GET_TOTAL_PAY_REWARD_CFG = 4362

--[[
	[1] = {--ReqOldSpiritFeedback
	}
--]]
c2s.HERO_SPIRIT_REQ_OLD_SPIRIT_FEEDBACK = 8408

--[[
	[1] = {--ReqEnterFight
		[1] = 'string':fightId	[ 进入战斗]
		[2] = 'int32':pid	[ 玩家PID]
	}
--]]
c2s.FIGHT_REQ_ENTER_FIGHT = 25601

--[[
	[1] = {--ChangeRoom
		[1] = 'int32':roleCid	[ 看板娘id]
		[2] = 'int32':roomCid	[ 房间cid]
	}
--]]
c2s.ROLE_CHANGE_ROOM = 1288

--[[
	[1] = {--ReqExploreInfo
	}
--]]
c2s.EXPLORE_REQ_EXPLORE_INFO = 7801

--[[
	[1] = {--ReqFightPing
		[1] = 'string':time	[ 时间]
	}
--]]
c2s.FIGHT_REQ_FIGHT_PING = 25609

--[[
	[1] = {--EnterGame
		[1] = 'string':token	[ 信息]
		[2] = 'int32':anti	[ 防沉迷状态: 1-认证已成年 2-认证未成年 3-未认证    // 防沉迷状态: 1-认证已成年 2-认证未成年 3-未认证]
	}
--]]
c2s.LOGIN_ENTER_GAME = 257

--[[
	[1] = {--ReqSendRose
		[1] = 'int32':optionId	[精灵图鉴id]
		[2] = 'int32':roseCount	[玫瑰数量]
	}
--]]
c2s.ACTIVITY2_REQ_SEND_ROSE = 9410

--[[
	[1] = {--ReqUnionLabourConvert
	}
--]]
c2s.ACTIVITY_REQ_UNION_LABOUR_CONVERT = 5183

--[[
	[1] = {--ReqActivityUnionItem
		[1] = 'int32':activityId	[ 活动ID]
	}
--]]
c2s.ACTIVITY_REQ_ACTIVITY_UNION_ITEM = 5306

--[[
	[1] = {--ReqPreEnterNewWorld
		[1] = 'int32':roomType	[大世界类型]
	}
--]]
c2s.NEW_WORLD_REQ_PRE_ENTER_NEW_WORLD = 6800

--[[
	[1] = {--ReqWorldRelevantData
		[1] = 'int32':roomType	[房间类型]
	}
--]]
c2s.NEW_WORLD_REQ_WORLD_RELEVANT_DATA = 6824

--[[
	[1] = {--ReqGetHangUpInfo
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_GET_HANG_UP_INFO = 5168

--[[
	[1] = {--ReqStrengthenNewEquip
		[1] = 'string':newEquipId	[新装备id]
	}
--]]
c2s.EQUIPMENT_REQ_STRENGTHEN_NEW_EQUIP = 2831

--[[
	[1] = {--ReqFlyBalloon
		[1] = 'repeated int32':itemIds	[道具id]
	}
--]]
c2s.ACTIVITY_REQ_FLY_BALLOON = 5192

--[[
	[1] = {--ReqCompletedEvent
		[1] = 'int32':activityId	[ 活动id]
		[2] = 'int32':itemId	[ 条目id]
		[3] = 'string':extendData	[ 扩展数据]
	}
--]]
c2s.ACTIVITY_REQ_COMPLETED_EVENT = 5141

--[[
	[1] = {--ReqFlopSpeedLink
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':location	[位置]
	}
--]]
c2s.ACTIVITY_REQ_FLOP_SPEED_LINK = 5151

--[[
	[1] = {--ReqShowNewSpirit
	}
--]]
c2s.HERO_SPIRIT_REQ_SHOW_NEW_SPIRIT = 8406

--[[
	[1] = {--ReqDetectiveVoteStatus
	}
--]]
c2s.DETECTIVE_REQ_DETECTIVE_VOTE_STATUS = 8913

--[[
	[1] = {--Dress
		[1] = 'string':roleId	[ 精灵ID]
		[2] = 'string':itemId	[ 装备]
	}
--]]
c2s.ROLE_DRESS = 1284

--[[
	[1] = {--ReqNodePrizeMsg
	}
--]]
c2s.ODEUM_REQ_NODE_PRIZE = 6504

--[[
	[1] = {--ReqFamousReward
		[1] = 'int32':level	[名师的等级]
	}
--]]
c2s.APPRENTICE_REQ_FAMOUS_REWARD = 7909

--[[
	[1] = {--SupportActivityProgress
		[1] = 'int32':activityId	[ 应援活动ID]
	}
--]]
c2s.ACTIVITY_SUPPORT_ACTIVITY_PROGRESS = 5129

--[[
	[1] = {--ReqGetHandWorkAward
		[1] = 'int32':manualId
	}
--]]
c2s.NEW_BUILDING_REQ_GET_HAND_WORK_AWARD = 2083

--[[
	[1] = {--RefreshStore
		[1] = 'int32':cid	[ 商店类型]
	}
--]]
c2s.STORE_REFRESH_STORE = 2563

--[[
	[1] = {--ReqMemoryLocation
	}
--]]
c2s.SNOW_FESTIVAL_REQ_MEMORY_LOCATION = 9305

--[[
	[1] = {--ReqFlopFlopGame
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':pos	[位置]
	}
--]]
c2s.ACTIVITY_REQ_FLOP_FLOP_GAME = 5159

--[[
	[1] = {--ReqTimeOutItemConvert
	}
--]]
c2s.ITEM_REQ_TIME_OUT_ITEM_CONVERT = 519

--[[
	[1] = {--ReqOldSpiritView
	}
--]]
c2s.HERO_SPIRIT_REQ_OLD_SPIRIT_VIEW = 8410

--[[
	[1] = {--HeroCompose
		[1] = 'int32':heroCid
	}
--]]
c2s.HERO_HERO_COMPOSE = 1031

--[[
	[1] = {--ReqChangeNation
		[1] = 'int32':type	[0 切换城市 , 1 切换国家]
		[2] = 'int32':nationId	[国家id]
		[3] = 'int32':cityId	[城市id]
		[4] = 'int32':activityId	[id]
	}
--]]
c2s.EXPLORE_REQ_CHANGE_NATION = 7829

--[[
	[1] = {--ReqAngelWake
		[1] = 'string':heroId
	}
--]]
c2s.HERO_REQ_ANGEL_WAKE = 1032

--[[
	[1] = {--ReqKurumiCityResource
		[1] = 'int32':city	[城市id]
		[2] = 'int32':count	[领取次数]
		[3] = 'int32':multiple	[领取倍数,暂时只有2倍]
	}
--]]
c2s.ACTIVITY_REQ_KURUMI_CITY_RESOURCE = 5165

--[[
	[1] = {--ReqUseItemMoveUnionExp
		[1] = 'int32':itemId
		[2] = 'int32':num
	}
--]]
c2s.ITEM_REQ_USE_ITEM_MOVE_UNION_EXP = 2157

--[[
	[1] = {--ReqVoteActivityInfo
	}
--]]
c2s.ACTIVITY_REQ_VOTE_ACTIVITY_INFO = 5190

--[[
	[1] = {--SceneSynchronizeMsg
		[1] = 'int32':spendTime	[场景用时]
	}
--]]
c2s.DUNGEON_SCENE_SYNCHRONIZE = 1810

--[[
	[1] = {--ReqRealEnter
	}
--]]
c2s.SUMMER_COURAGE_REQ_REAL_ENTER = 6916

--[[
	[1] = {--ReqAIProp
		[1] = 'int32':roleId	[精灵ID]
	}
--]]
c2s.DATING_REQ_AIPROP = 1562

--[[
	[1] = {--ReqGetARinfo
	}
--]]
c2s.ARREQ_GET_ARINFO = 9301

--[[
	[1] = {--ExploreTreasureEquipMsg
		[1] = 'string':id	[ 宝物uid]
		[2] = 'int32':index	[ 装备位索引]
	}
--]]
c2s.EXPLORE_EXPLORE_TREASURE_EQUIP = 7832

--[[
	[1] = {--CreateTeam
		[1] = 'int32':dungeonLevelCid
		[2] = 'bool':matching
	}
--]]
c2s.DUNGEON_CREATE_TEAM = 1803

--[[
	[1] = {--ReqReceiveFriendHelpTask
		[1] = 'int32':inviteeId	[ 对应邀请奖励配置表id]
		[2] = 'int32':taskId
	}
--]]
c2s.FRIEND_REQ_RECEIVE_FRIEND_HELP_TASK = 3091

--[[
	[1] = {--ReqGetWarOrderInfo
	}
--]]
c2s.ACTIVITY_REQ_GET_WAR_ORDER_INFO = 5147

--[[
	[1] = {--ReqShowGroupTeam
		[1] = 'int32':giftId
		[2] = 'bool':isShow	[是否显示]
	}
--]]
c2s.RECHARGE_REQ_SHOW_GROUP_TEAM = 4385

--[[
	[1] = {--ReqActivityItemRefresh
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_ACTIVITY_ITEM_REFRESH = 5179

--[[
	[1] = {--Req2020FestivalInfo
	}
--]]
c2s.SPRING_FESTIVAL_REQ2020_FESTIVAL_INFO = 6710

--[[
	[1] = {--ReqHuntingFDAward
		[1] = 'int32':dungeon	[领取的关卡]
	}
--]]
c2s.HUNTING_DUNGEON_REQ_HUNTING_FDAWARD = 8504

--[[
	[1] = {--ReqCancelMatch
	}
--]]
c2s.TEAM_REQ_CANCEL_MATCH = 5895

--[[
	[1] = {--ReqHandleApprentice
		[1] = 'int32':playerId
		[2] = 'int32':type
	}
--]]
c2s.APPRENTICE_REQ_HANDLE_APPRENTICE = 7902

--[[
	[1] = {--ReqAnnivDress
	}
--]]
c2s.ANNIVERSARY2ND_REQ_ANNIV_DRESS = 9206

--[[
	[1] = {--ReqEnterNewWorld
		[1] = 'string':roomId	[ 战斗ID]
		[2] = 'int32':pid	[ 玩家PID]
	}
--]]
c2s.NEW_WORLD_REQ_ENTER_NEW_WORLD = 6801

--[[
	[1] = {--ReqEquipSystemTitle
		[1] = 'int32':id	[称号ID]
	}
--]]
c2s.SYSTEM_TITLE_REQ_EQUIP_SYSTEM_TITLE = 8151

--[[
	[1] = {--ReqMySupportInfo
	}
--]]
c2s.HANGUP_ACT_REQ_MY_SUPPORT_INFO = 9014

--[[
	[1] = {--ReqGetHandWorkInfo
		[1] = 'bool':needSave	[默认为true,从约会进的传递false]
	}
--]]
c2s.NEW_BUILDING_REQ_GET_HAND_WORK_INFO = 2080

--[[
	[1] = {--GetDatingInfo
	}
--]]
c2s.DATING_GET_DATING_INFO = 1539

--[[
	[1] = {--ComposeFinish
		[1] = 'int32':zPointType	[质点类型]
	}
--]]
c2s.SUMMON_COMPOSE_FINISH = 3331

--[[
	[1] = {--ReqStopStronghold
		[1] = 'int32':id	[据点id]
	}
--]]
c2s.HANGUP_ACT_REQ_STOP_STRONGHOLD = 9013

--[[
	[1] = {--ReqAngelAddBit
		[1] = 'string':heroId
		[2] = 'int32':cid	[ 技能树ID]
	}
--]]
c2s.HERO_REQ_ANGEL_ADD_BIT = 1033

--[[
	[1] = {--GetHeros
	}
--]]
c2s.HERO_GET_HEROS = 1025

--[[
	[1] = {--ReqSetShapeMsg
		[1] = 'int32':type
	}
--]]
c2s.EXPLORE_REQ_SET_SHAPE = 7836

--[[
	[1] = {--ReqAITrainingSubmit
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'string':qid	[原问题id]
		[3] = 'string':query	[调教问题]
		[4] = 'string':reply	[调教回答]
		[5] = 'repeated int32':feeling	[好感度选项  0 通用,1 冷淡 2 友善 3 暧昧--0与其他互斥    //好感度选项  0 通用,1 冷淡 2 友善 3 暧昧--0与其他互斥]
		[6] = 'int32':type	[提交类型,根据黑桃规则新调教与二次调教为0,聊天室跳转取语料附带类型]
	}
--]]
c2s.DATING_REQ_AITRAINING_SUBMIT = 1566

--[[
	[1] = {--ReqBackgroundInfo
	}
--]]
c2s.PLAYER_REQ_BACKGROUND_INFO = 291

--[[
	[1] = {--ReqBindInviteCode
		[1] = 'string':inviteCode	[ 邀请码]
	}
--]]
c2s.FRIEND_REQ_BIND_INVITE_CODE = 3079

--[[
	[1] = {--OfficeFormationMsg
		[1] = 'int32':sourceHero	[源英雄id]
		[2] = 'int32':targetHero	[目标英雄id]
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_FORMATION = 7204

--[[
	[1] = {--ReqCheckGashaponResult
		[1] = 'repeated int32':cids	[抓到的娃娃id(可能一次抓到多个)    //抓到的娃娃id(可能一次抓到多个)]
	}
--]]
c2s.NEW_BUILDING_REQ_CHECK_GASHAPON_RESULT = 2064

--[[
	[1] = {--ReqJuNaiInvasionInfo
	}
--]]
c2s.JU_NAI_INVASION_REQ_JU_NAI_INVASION_INFO = 9101

--[[
	[1] = {--ReqStepEquipPreview
		[1] = 'string':equipId	[要升阶的质点]
		[2] = 'string':costEquipId	[消耗的同名质点id]
	}
--]]
c2s.EQUIPMENT_REQ_STEP_EQUIP_PREVIEW = 2861

--[[
	[1] = {--ReqSearchPlayer
		[1] = 'int32':targetId
	}
--]]
c2s.APPRENTICE_REQ_SEARCH_PLAYER = 7907

--[[
	[1] = {--ReqVerifyFightResult
		[1] = {--repeated ReleaseSkillInfo
			[1] = 'int32':skillId	[技能id]
			[2] = 'int32':count	[技能次数]
		},
		[2] = {--repeated MonsterInfo
			[1] = 'int32':monsterId	[怪物id]
			[2] = 'int32':monsterLevel	[怪物等级]
			[3] = 'int32':monsterNum	[怪物数量]
		},
		[3] = 'int32':sumHp	[扣除怪物总血量]
		[4] = 'int64':hurtCount	[总伤害次数]
		[5] = 'int64':hurt	[总伤害]
	}
--]]
c2s.DUNGEON_REQ_VERIFY_FIGHT_RESULT = 1812

--[[
	[1] = {--NewReqActivityProgress
	}
--]]
c2s.ACTIVITY_NEW_REQ_ACTIVITY_PROGRESS = 5128

--[[
	[1] = {--ReqPhantomGift
		[1] = 'int32':id	[配置id]
		[2] = 'int32':lv	[档位]
		[3] = 'int32':index	[小鬼在数组的位置,0开始]
	}
--]]
c2s.PLAYER_REQ_PHANTOM_GIFT = 302

--[[
	[1] = {--ReqAssistanceInfo
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_ASSISTANCE_INFO = 5211

--[[
	[1] = {--QliphothTreeInfoMsg
	}
--]]
c2s.QLIPHOTH_QLIPHOTH_TREE_INFO = 6201

--[[
	[1] = {--ReqElementType
	}
--]]
c2s.ELEMENT_COLLECT_REQ_ELEMENT_TYPE = 4869

--[[
	[1] = {--ReqRepairData
	}
--]]
c2s.ACTIVITY2_REQ_REPAIR_DATA = 9403

--[[
	[1] = {--ReqModifyPicInfo
		[1] = 'int32':index	[索引]
		[2] = 'int32':id	[配置ID]
		[3] = 'int32':zooming	[缩放大小]
		[4] = 'int32':rotate	[旋转度]
		[5] = 'string':text	[文本内容]
	}
--]]
c2s.ARREQ_MODIFY_PIC_INFO = 9302

--[[
	[1] = {--ReqHuntingPassAward
		[1] = 'int32':dungeon	[领取的关卡]
	}
--]]
c2s.HUNTING_DUNGEON_REQ_HUNTING_PASS_AWARD = 8505

--[[
	[1] = {--ExploreTreasureComposeMsg
		[1] = 'int32':id	[宝物templateid]
	}
--]]
c2s.EXPLORE_EXPLORE_TREASURE_COMPOSE = 7830

--[[
	[1] = {--ReqUpgradeSkill
		[1] = 'string':heroId
		[2] = 'int32':type
		[3] = 'int32':pos
		[4] = 'int32':operation	[1 升级 2 降级]
	}
--]]
c2s.HERO_REQ_UPGRADE_SKILL = 1038

--[[
	[1] = {--ReqAddBuff
		[1] = 'int32':itemId	[道具id]
		[2] = 'int32':location	[位置]
	}
--]]
c2s.SACRIFICE_REQ_ADD_BUFF = 8003

--[[
	[1] = {--ReqSeekNianBeast
	}
--]]
c2s.SPRING_FESTIVAL_REQ_SEEK_NIAN_BEAST = 6703

--[[
	[1] = {--ExploreActivityInfo
		[1] = 'int32':activityId
	}
--]]
c2s.EXPLORE_EXPLORE_ACTIVITY_INFO = 7823

--[[
	[1] = {--ReqActivateMedals
	}
--]]
c2s.MEDAL_REQ_ACTIVATE_MEDALS = 3001

--[[
	[1] = {--ReqAITrainingLike
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'string':query	[问题]
		[3] = 'string':reply	[回答]
		[4] = 'int32':like	[类型,1 点赞 2 鄙视]
	}
--]]
c2s.DATING_REQ_AITRAINING_LIKE = 1567

--[[
	[1] = {--Req2019ChristmasDungeon
	}
--]]
c2s.CHRISTMAS_REQ2019_CHRISTMAS_DUNGEON = 6613

--[[
	[1] = {--ReqFunctionSwitch
	}
--]]
c2s.LOGIN_REQ_FUNCTION_SWITCH = 280

--[[
	[1] = {--ReqSwitchFormation
		[1] = 'int32':formationType
	}
--]]
c2s.PLAYER_REQ_SWITCH_FORMATION = 272

--[[
	[1] = {--ReqFinishHeroDispatch
	}
--]]
c2s.HERO_DISPATCH_REQ_FINISH_HERO_DISPATCH = 8604

--[[
	[1] = {--AreaMoveMsg
		[1] = 'int32':areaCid	[目标区域cid]
	}
--]]
c2s.OFFICE_EXPLORE_AREA_MOVE = 7103

--[[
	[1] = {--ReqReverseTenWindow
	}
--]]
c2s.ACTIVITY2_REQ_REVERSE_TEN_WINDOW = 9401

--[[
	[1] = {--ReqEnter
		[1] = 'int32':datingValue	[当类型为外传时,值传外传ID,主线则为主线章节]
	}
--]]
c2s.EXTRA_DATING_REQ_ENTER = 5662

--[[
	[1] = {--QueryUnionList
	}
--]]
c2s.UNION_QUERY_UNION_LIST = 6651

--[[
	[1] = {--ReqOpenAllEnvelope
	}
--]]
c2s.RED_ENVELOPE_REQ_OPEN_ALL_ENVELOPE = 7305

--[[
	[1] = {--ChatMsg
		[1] = 'int32':channel	[	聊天类型:1.公共 2.私聊;3.帮派 4.系统 5.队伍]
		[2] = 'int32':fun	[ 	功能类型:1.聊天 2.深渊组队邀请]
		[3] = 'string':content	[  内容;]
		[4] = 'int32':playerId	[  私聊玩家编号]
		[5] = 'int32':giftId	[  团购礼包id]
	}
--]]
c2s.CHAT_CHAT = 2305

--[[
	[1] = {--ReqLimitlessSummonActivityInfo
		[1] = 'int32':activityId	[活动Id]
	}
--]]
c2s.LIMITLESS_SUMMON_REQ_LIMITLESS_SUMMON_ACTIVITY_INFO = 3501

--[[
	[1] = {--ReqGetHangUpAward
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':hangUpEventId	[事件id]
	}
--]]
c2s.ACTIVITY_REQ_GET_HANG_UP_AWARD = 5170

--[[
	[1] = {--ReqTakeRoseReward
		[1] = 'string':progress	[哪一个进度]
	}
--]]
c2s.ACTIVITY2_REQ_TAKE_ROSE_REWARD = 9411

--[[
	[1] = {--ReqPullNetFrame
		[1] = 'int32':fromIndex	[起始帧序]
		[2] = 'int32':pid	[ 玩家PID]
		[3] = 'string':fightId	[ 战斗ID]
	}
--]]
c2s.FIGHT_REQ_PULL_NET_FRAME = 25606

--[[
	[1] = {--OpenComposePanel
	}
--]]
c2s.CHRISTMAS_OPEN_COMPOSE_PANEL = 6607

--[[
	[1] = {--UpdateContributionMsg
	}
--]]
c2s.ODEUM_UPDATE_CONTRIBUTION = 6505

--[[
	[1] = {--GetStoreInfo
	}
--]]
c2s.STORE_GET_STORE_INFO = 2569

--[[
	[1] = {--ReqUpStarEquip
		[1] = 'string':equipmentId	[装备id]
		[2] = 'repeated string':costEquipmentId	[消耗装备id]
	}
--]]
c2s.EQUIPMENT_REQ_UP_STAR_EQUIP = 2835

--[[
	[1] = {--ReqSetBackground
		[1] = 'int32':dayBackground	[ 白天背景]
		[2] = 'int32':nightBackground	[夜晚背景]
		[3] = 'int32':dayBGM	[白天bgm]
		[4] = 'int32':nightBGM	[夜晚bgm]
	}
--]]
c2s.PLAYER_REQ_SET_BACKGROUND = 290

--[[
	[1] = {--ReqDispatchHeroStar
	}
--]]
c2s.HERO_DISPATCH_REQ_DISPATCH_HERO_STAR = 8607

--[[
	[1] = {--ReqRecommendList
		[1] = 'int32':kind	[1请求列表,2刷新]
		[2] = 'int32':type	[1徒弟推荐列表,2师父推荐列表]
	}
--]]
c2s.APPRENTICE_REQ_RECOMMEND_LIST = 7901

--[[
	[1] = {--ReqFreeSummonTime
	}
--]]
c2s.SUMMON_REQ_FREE_SUMMON_TIME = 3354

--[[
	[1] = {--LockMsg
		[1] = 'string':equipmentId	[灵装id]
	}
--]]
c2s.EQUIPMENT_LOCK = 2823

--[[
	[1] = {--ReqStatePush
		[1] = 'int32':type
		[2] = 'string':state
	}
--]]
c2s.CHASM_REQ_STATE_PUSH = 6156

--[[
	[1] = {--GetLevelInfo
	}
--]]
c2s.DUNGEON_GET_LEVEL_INFO = 1796

--[[
	[1] = {--ReqBuyChasmCount
		[1] = 'int32':id	[ 购买哪一关的]
	}
--]]
c2s.CHASM_REQ_BUY_CHASM_COUNT = 6150

--[[
	[1] = {--ReqOpenBag
	}
--]]
c2s.ITEM_REQ_OPEN_BAG = 516

--[[
	[1] = {--ReqPamphletLevelUp
		[1] = 'int32':id	[配置id]
	}
--]]
c2s.SNOW_FESTIVAL_REQ_PAMPHLET_LEVEL_UP = 9308

--[[
	[1] = {--SendRedPacket
		[1] = 'int32':id	[ 红包id]
		[2] = 'string':blessing	[祝福语]
	}
--]]
c2s.UNION_SEND_RED_PACKET = 6659

--[[
	[1] = {--ReqFightEnvelope
		[1] = 'string':id	[红包id]
	}
--]]
c2s.RED_ENVELOPE_REQ_FIGHT_ENVELOPE = 7303

--[[
	[1] = {--ReqAnnivMoveNext
	}
--]]
c2s.ANNIVERSARY2ND_REQ_ANNIV_MOVE_NEXT = 9203

--[[
	[1] = {--ReqLangugeSign
		[1] = 'int32':langugeSign	[ 1:中文版  2:英文版]
	}
--]]
c2s.SIGN_REQ_LANGUGE_SIGN = 5162

--[[
	[1] = {--ReqAnnivInfo
	}
--]]
c2s.ANNIVERSARY2ND_REQ_ANNIV_INFO = 9202

--[[
	[1] = {--ReqGetAllAfkTaskAward
	}
--]]
c2s.EXPLORE_REQ_GET_ALL_AFK_TASK_AWARD = 7844

--[[
	[1] = {--ReqGetMaidEventAward
		[1] = 'int32':eventId	[消耗类型]
	}
--]]
c2s.MAID_ACTIVITY_REQ_GET_MAID_EVENT_AWARD = 9159

--[[
	[1] = {--ReqEquipRemould
		[1] = 'string':equipmentId	[灵装id]
		[2] = 'repeated int32':attrIndex	[属性索引]
	}
--]]
c2s.EQUIPMENT_REQ_EQUIP_REMOULD = 2826

--[[
	[1] = {--ReqOperateFight
		[1] = 'int32':keyCode	[按键键值 (摇杆.按键)    //按键键值 (摇杆.按键)]
		[2] = 'int32':keyEvent	[按键状态  down/doing/up/摇杆角度]
		[3] = 'int32':keyEventEx	[按键状态扩展]
		[4] = 'int32':posX	[位置X]
		[5] = 'int32':posY	[位置Y]
		[6] = 'int32':dir	[角色朝向]
		[7] = 'int32':hp	[角色血量]
		[8] = 'int32':sp	[怒气]
	}
--]]
c2s.FIGHT_REQ_OPERATE_FIGHT = 25603

--[[
	[1] = {--Ping
	}
--]]
c2s.LOGIN_PING = 262

--[[
	[1] = {--ReqAITrainingRank
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'int32':type	[类型-1 周榜  2月榜    //类型-1 周榜  2月榜]
	}
--]]
c2s.DATING_REQ_AITRAINING_RANK = 1564

--[[
	[1] = {--MailHandleMsg
		[1] = 'repeated string':ids	[ 邮件ID]
		[2] = {--MailOperationType(enum)
			'v4':MailOperationType
		},
	}
--]]
c2s.MAIL_MAIL_HANDLE = 769

--[[
	[1] = {--ReqCookFoodbase
		[1] = 'int32':foodId
		[2] = 'int32':times
	}
--]]
c2s.NEW_BUILDING_REQ_COOK_FOODBASE = 2067

--[[
	[1] = {--ReqComposeFirecracker
		[1] = 'int32':composeId
		[2] = 'int32':num	[合成数量]
	}
--]]
c2s.SPRING_FESTIVAL_REQ_COMPOSE_FIRECRACKER = 6701

--[[
	[1] = {--ReqStartGameMsg
		[1] = 'int32':type	[ 游戏类型]
		[2] = 'repeated int32':params	[ 下注信息]
	}
--]]
c2s.ACTIVITY_REQ_START_GAME = 5136

--[[
	[1] = {--ReqChasmFightRevive
	}
--]]
c2s.CHASM_REQ_CHASM_FIGHT_REVIVE = 6146

--[[
	[1] = {--GetComposeInfo
	}
--]]
c2s.SUMMON_GET_COMPOSE_INFO = 3333

--[[
	[1] = {--ReqExpediteDispatch
		[1] = 'int32':type	[1 日常副本, 2  精灵试炼, 3  雷霆圣堂, 4  联机作战, 5  日常约会]
		[2] = 'int32':dungeon	[请求的关卡,主要用于验证前后端延迟的情况]
	}
--]]
c2s.HERO_DISPATCH_REQ_EXPEDITE_DISPATCH = 8609

--[[
	[1] = {--ReqFlopGameInfo
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_FLOP_GAME_INFO = 5157

--[[
	[1] = {--ReqGetMaidInfo
		[1] = 'int32':enterType	[进入方式]
	}
--]]
c2s.MAID_ACTIVITY_REQ_GET_MAID_INFO = 9150

--[[
	[1] = {--TaskEventDiscoverMsg
	}
--]]
c2s.QLIPHOTH_TASK_EVENT_DISCOVER = 6224

--[[
	[1] = {--ReqLoginUiChangeInfo
	}
--]]
c2s.PLAYER_REQ_LOGIN_UI_CHANGE_INFO = 304

--[[
	[1] = {--ReqActiveCrystal
		[1] = 'string':heroId
		[2] = 'int32':rarity
		[3] = 'int32':gridId
		[4] = 'bool':isReplace
	}
--]]
c2s.HERO_REQ_ACTIVE_CRYSTAL = 1042

--[[
	[1] = {--reqPhoneChat
		[1] = 'int32':type	[对话类型  手机约会类型   自由聊天type=1  视频聊天 type=2]
		[2] = 'string':chatMsg	[对话内容]
		[3] = 'int32':roleId	[对应的精灵id]
	}
--]]
c2s.DATINGREQ_PHONE_CHAT = 1555

--[[
	[1] = {--ReqRollYouci
	}
--]]
c2s.YOUCI_REQ_ROLL_YOUCI = 9352

--[[
	[1] = {--ReqPrise
		[1] = 'int32':playerId	[请求对象的玩家id]
		[2] = 'int32':type	[装备:1,英雄:2]
		[3] = 'int32':itemId	[请求的对象(装备/英雄)id    //请求的对象(装备/英雄)id]
		[4] = 'int32':commentDate	[评论日期]
	}
--]]
c2s.COMMENT_REQ_PRISE = 4003

--[[
	[1] = {--OpenPanelMsg
	}
--]]
c2s.ODEUM_OPEN_PANEL = 6501

--[[
	[1] = {--ReqDoPartTimeJob
		[1] = 'int32':buildingId	[建筑ID]
		[2] = 'int32':jobId	[兼职id]
	}
--]]
c2s.NEW_BUILDING_REQ_DO_PART_TIME_JOB = 2077

--[[
	[1] = {--ReqRefreshDailyTask
	}
--]]
c2s.ACTIVITY_REQ_REFRESH_DAILY_TASK = 5220

--[[
	[1] = {--ReqNWSummonInfo
	}
--]]
c2s.SUMMON_REQ_NWSUMMON_INFO = 3341

--[[
	[1] = {--OpenPanel
	}
--]]
c2s.CHRISTMAS_OPEN_PANEL = 6601

--[[
	[1] = {--ReqUnionRankActScore
		[1] = 'int32':activityId	[ 活动ID]
	}
--]]
c2s.ACTIVITY_REQ_UNION_RANK_ACT_SCORE = 5305

--[[
	[1] = {--ReqTrainMaxtriPrize
		[1] = 'int32':index	[ 奖励索引]
	}
--]]
c2s.UNION_REQ_TRAIN_MAXTRI_PRIZE = 6672

--[[
	[1] = {--ReqExploreActivityRank
	}
--]]
c2s.ACTIVITY_REQ_EXPLORE_ACTIVITY_RANK = 5188

--[[
	[1] = {--ReqLeaveTeam
	}
--]]
c2s.TEAM_REQ_LEAVE_TEAM = 5893

--[[
	[1] = {--ReqDetectiveChapter
	}
--]]
c2s.DETECTIVE_REQ_DETECTIVE_CHAPTER = 8905

--[[
	[1] = {--NewReqActivitys
	}
--]]
c2s.ACTIVITY_NEW_REQ_ACTIVITYS = 5124

--[[
	[1] = {--AnswerDatingInvitationMsg
		[1] = 'string':datingId	[约会id]
		[2] = 'int32':answer	[回答]
	}
--]]
c2s.DATING_ANSWER_DATING_INVITATION = 1544

--[[
	[1] = {--ReqTriggerSpringEnvelope
		[1] = 'string':bless	[祝福语]
		[2] = 'int32':id	[packet表里面的红包id]
	}
--]]
c2s.RED_ENVELOPE_REQ_TRIGGER_SPRING_ENVELOPE = 7306

--[[
	[1] = {--ValentineRankMsg
	}
--]]
c2s.VALENTINE_VALENTINE_RANK = 7401

--[[
	[1] = {--ReqExploreUpdateSkin
		[1] = 'int32':skinId
	}
--]]
c2s.EXPLORE_REQ_EXPLORE_UPDATE_SKIN = 7842

--[[
	[1] = {--ReqNeptune2ndHalfResource
		[1] = 'int32':dungeon	[需要领取的关卡]
		[2] = 'int32':count	[领取次数]
		[3] = 'int32':multiple	[领取倍数,暂时只有2倍]
	}
--]]
c2s.NEPTUNE2ND_HALF_REQ_NEPTUNE2ND_HALF_RESOURCE = 7702

--[[
	[1] = {--ReqUnionLabourScore
	}
--]]
c2s.ACTIVITY_REQ_UNION_LABOUR_SCORE = 5181

--[[
	[1] = {--OfficeSubmitGameMsg
		[1] = 'repeated int32':options	[ 选项列表]
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_SUBMIT_GAME = 7229

--[[
	[1] = {--ReqReverseTenReward
	}
--]]
c2s.ACTIVITY2_REQ_REVERSE_TEN_REWARD = 9402

--[[
	[1] = {--ReqHuntingDungeonInfo
	}
--]]
c2s.HUNTING_DUNGEON_REQ_HUNTING_DUNGEON_INFO = 8501

--[[
	[1] = {--ReqRemouldedGem
		[1] = 'string':gemId	[ 宝石id]
		[2] = 'bool':isRetain	[ 是否保留]
	}
--]]
c2s.EQUIPMENT_REQ_REMOULDED_GEM = 2837

--[[
	[1] = {--ReqStartCatExplore
		[1] = 'int32':taskId	[任务id]
		[2] = 'repeated int32':catList	[猫咪列表]
	}
--]]
c2s.ACTIVITY_REQ_START_CAT_EXPLORE = 5224

--[[
	[1] = {--ReqHuntingBossAward
	}
--]]
c2s.HUNTING_DUNGEON_REQ_HUNTING_BOSS_AWARD = 8506

--[[
	[1] = {--ReqCreateTeam
		[1] = {--TeamFeature
			[1] = 'int32':teamType	[ 队伍类型]
			[2] = 'int32':dungeonCid	[ 副本ID]
		},
		[2] = 'string':itemId	[ 消耗道具的实体id 悬赏副本用]
		[3] = 'int32':show_type	[0,显示所有;1,显示给好友;2,不显示]
		[4] = 'int32':level_limit	[等级限制]
		[5] = 'bool':auto_match	[是否自动匹配]
	}
--]]
c2s.TEAM_REQ_CREATE_TEAM = 5889

--[[
	[1] = {--ReqGetBeCallInfo
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_GET_BE_CALL_INFO = 5176

--[[
	[1] = {--ReqUpgradeWishTree
	}
--]]
c2s.ANNIVERSARY2ND_REQ_UPGRADE_WISH_TREE = 9233

--[[
	[1] = {--MatchingTeam
		[1] = 'int32':dungeonLevelCid
	}
--]]
c2s.DUNGEON_MATCHING_TEAM = 1804

--[[
	[1] = {--ReqCompleteSTTask
		[1] = 'int32':id	[ 任务id]
	}
--]]
c2s.HERO_REQ_COMPLETE_STTASK = 1047

--[[
	[1] = {--ReqSummerCourageEnter
	}
--]]
c2s.SUMMER_COURAGE_REQ_SUMMER_COURAGE_ENTER = 6909

--[[
	[1] = {--ReqEquipRecycleInfo
		[1] = 'string':equipmentId	[灵装id]
	}
--]]
c2s.EQUIPMENT_REQ_EQUIP_RECYCLE_INFO = 2828

--[[
	[1] = {--ReqSpringWithTreeList
	}
--]]
c2s.ACTIVITY2_REQ_SPRING_WITH_TREE_LIST = 9413

--[[
	[1] = {--ReqBlackWhite
	}
--]]
c2s.NEW_WORLD_REQ_BLACK_WHITE = 6818

--[[
	[1] = {--ExploreTaskRefresh
	}
--]]
c2s.EXPLORE_EXPLORE_TASK_REFRESH = 7814

--[[
	[1] = {--ReqTakeOffMedal
		[1] = 'int32':cid
	}
--]]
c2s.MEDAL_REQ_TAKE_OFF_MEDAL = 3003

--[[
	[1] = {--ValentineComposeMsg
		[1] = {--ValentineGiftInfo
			[1] = 'int32':giftCid	[ 礼物id]
			[2] = 'int32':giftNum	[ 礼物数量]
		},
	}
--]]
c2s.VALENTINE_VALENTINE_COMPOSE = 7402

--[[
	[1] = {--ReqFightHeartbeat
	}
--]]
c2s.FIGHT_REQ_FIGHT_HEARTBEAT = 25610

--[[
	[1] = {--ReqDressNewEquip
		[1] = 'int32':type	[1装备 2卸下]
		[2] = 'string':heroId	[英雄id]
		[3] = 'string':newEquipId	[新装备id]
		[4] = 'int32':index	[位置]
	}
--]]
c2s.EQUIPMENT_REQ_DRESS_NEW_EQUIP = 2830

--[[
	[1] = {--ReqEnterUnionRoom
		[1] = 'int32':roomType	[进入社团的房间类型]
	}
--]]
c2s.NEW_WORLD_REQ_ENTER_UNION_ROOM = 6807

--[[
	[1] = {--ReqUseingToy
		[1] = 'int32':itemId	[道具id]
	}
--]]
c2s.ACTIVITY_REQ_USEING_TOY = 5225

--[[
	[1] = {--ReqSelfContriPrize
		[1] = 'int32':prizeIndex	[奖励索引]
	}
--]]
c2s.ODEUM_REQ_SELF_CONTRI_PRIZE = 6512

--[[
	[1] = {--ReqLimitlessSummonRefreshPool
		[1] = 'int32':activityId	[活动Id]
	}
--]]
c2s.LIMITLESS_SUMMON_REQ_LIMITLESS_SUMMON_REFRESH_POOL = 3503

--[[
	[1] = {--CabinUpgrade
		[1] = 'int32':id	[舱室id]
	}
--]]
c2s.EXPLORE_CABIN_UPGRADE = 7803

--[[
	[1] = {--ReqTimeLinkageInfo
	}
--]]
c2s.DUNGEON_REQ_TIME_LINKAGE_INFO = 1815

--[[
	[1] = {--ShopInfoMsg
	}
--]]
c2s.QLIPHOTH_SHOP_INFO = 6213

--[[
	[1] = {--ReqUpgradeSpirit
		[1] = 'int32':costId	[选择的消耗]
	}
--]]
c2s.HERO_SPIRIT_REQ_UPGRADE_SPIRIT = 8403

--[[
	[1] = {--ReqAskSwitch
	}
--]]
c2s.PLAYER_REQ_ASK_SWITCH = 287

--[[
	[1] = {--ReqgetFoodbaseInfo
		[1] = 'bool':needSave	[默认为true,从约会进的传递false]
	}
--]]
c2s.NEW_BUILDING_REQGET_FOODBASE_INFO = 2066

--[[
	[1] = {--ReqPurchStore
		[1] = 'int32':storeId
	}
--]]
c2s.SIGN_REQ_PURCH_STORE = 5161

--[[
	[1] = {--ReqFavorDatingTestInfo
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'int32':favorDatingId	[Favor表对应id]
	}
--]]
c2s.EXTRA_DATING_REQ_FAVOR_DATING_TEST_INFO = 5660

--[[
	[1] = {--ReqStartStage
		[1] = 'bool':nonstop	[是否跳层]
	}
--]]
c2s.ENDLESS_CLOISTER_REQ_START_STAGE = 5383

--[[
	[1] = {--Share
		[1] = 'int32':id	[ ID]
	}
--]]
c2s.SHARE_SHARE = 6103

--[[
	[1] = {--ReqAcquireBulletScreen
		[1] = 'int32':version	[  版本号]
		[2] = 'int32':barrageId
	}
--]]
c2s.CHAT_REQ_ACQUIRE_BULLET_SCREEN = 2316

--[[
	[1] = {--ReqRewardStatus
	}
--]]
c2s.APPRENTICE_REQ_REWARD_STATUS = 7910

--[[
	[1] = {--ReqSuspectVote
		[1] = 'int32':id	[配置表id]
		[2] = 'int32':voteId	[投票项]
	}
--]]
c2s.DETECTIVE_REQ_SUSPECT_VOTE = 8911

--[[
	[1] = {--GetMails
	}
--]]
c2s.MAIL_GET_MAILS = 772

--[[
	[1] = {--ReqSubmitTaskMsg
		[1] = 'int32':taskId
		[2] = 'int32':goodId
		[3] = 'int32':count
		[4] = 'int32':activityId
	}
--]]
c2s.HANGUP_ACT_REQ_SUBMIT_TASK = 9007

--[[
	[1] = {--ReqDealFriendExchangeApply
		[1] = 'int32':friendId	[好友id]
		[2] = 'bool':accept	[是否接受 true 接受 false 拒绝]
		[3] = 'int32':otherOption	[其他选项 二进制或运算 1(1)不再接受对方 2(10)不再接受好友 3(11) 全部不接受    //其他选项 二进制或运算 1(1)不再接受对方 2(10)不再接受好友 3(11) 全部不接受]
	}
--]]
c2s.ACTIVITY_REQ_DEAL_FRIEND_EXCHANGE_APPLY = 5195

--[[
	[1] = {--ReqGetZZAllRankMsg
	}
--]]
c2s.ACTIVITY_REQ_GET_ZZALL_RANK = 5138

--[[
	[1] = {--ReqSaveEquipBackupDecr
		[1] = 'int32':id	[ 方案id]
		[2] = 'string':decr	[描述]
	}
--]]
c2s.EQUIPMENT_REQ_SAVE_EQUIP_BACKUP_DECR = 2843

--[[
	[1] = {--ReqGiftLoginCheck
	}
--]]
c2s.RECHARGE_REQ_GIFT_LOGIN_CHECK = 4386

--[[
	[1] = {--UseItemMsg
		[1] = 'int32':itemCid	[ 道具cid]
		[2] = 'int32':num	[ 道具数量]
		[3] = 'repeated int32':customParameList	[ 用户参数,如英雄列表]
	}
--]]
c2s.QLIPHOTH_USE_ITEM = 6214

--[[
	[1] = {--ReqQueryPlayer
		[1] = 'int32':pid	[ 玩家ID]
	}
--]]
c2s.FRIEND_REQ_QUERY_PLAYER = 3076

--[[
	[1] = {--ReqLadderInfo
	}
--]]
c2s.LADDER_REQ_LADDER_INFO = 8301

--[[
	[1] = {--ReqSendGift
		[1] = {--repeated GiftInfo
			[1] = 'int32':giftId
			[2] = 'int32':count
		},
	}
--]]
c2s.APPRENTICE_REQ_SEND_GIFT = 7904

--[[
	[1] = {--ReqAttrInfo
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':nationId	[国家id]
		[3] = 'int32':cityId	[城市id]
	}
--]]
c2s.EXPLORE_REQ_ATTR_INFO = 7840

--[[
	[1] = {--TouchRole
	}
--]]
c2s.ROLE_TOUCH_ROLE = 1287

--[[
	[1] = {--ReqDecomposeGem
		[1] = 'repeated string':gemId	[ 宝石id]
	}
--]]
c2s.EQUIPMENT_REQ_DECOMPOSE_GEM = 2838

--[[
	[1] = {--ReqChangeVoteInfo
		[1] = 'int32':itemId	[条目id]
	}
--]]
c2s.ACTIVITY_REQ_CHANGE_VOTE_INFO = 5191

--[[
	[1] = {--ReqStrongholdInfo
		[1] = 'int32':id	[据点id]
	}
--]]
c2s.HANGUP_ACT_REQ_STRONGHOLD_INFO = 9011

--[[
	[1] = {--ReqExploreEquipInfos
	}
--]]
c2s.EXPLORE_REQ_EXPLORE_EQUIP_INFOS = 7806

--[[
	[1] = {--ReqSwitchNewbie
	}
--]]
c2s.SUMMER_COURAGE_REQ_SWITCH_NEWBIE = 6915

--[[
	[1] = {--ReqActivityNotice
	}
--]]
c2s.ACTIVITY_REQ_ACTIVITY_NOTICE = 5139

--[[
	[1] = {--ReqPamphletInfo
	}
--]]
c2s.SNOW_FESTIVAL_REQ_PAMPHLET_INFO = 9304

--[[
	[1] = {--ReqNewWorldChangeDungeon
		[1] = 'int32':index	[格子索引]
		[2] = 'int32':restTime	[剩余时长]
	}
--]]
c2s.NEW_WORLD_REQ_NEW_WORLD_CHANGE_DUNGEON = 6813

--[[
	[1] = {--ReqClubWishTreeInfo
	}
--]]
c2s.ANNIVERSARY2ND_REQ_CLUB_WISH_TREE_INFO = 9231

--[[
	[1] = {--ReqDecomposeGemDesign
		[1] = {--repeated GemDesignInfo
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
c2s.EQUIPMENT_REQ_DECOMPOSE_GEM_DESIGN = 2840

--[[
	[1] = {--ReqEquipRemouldSwitch
	}
--]]
c2s.EQUIPMENT_REQ_EQUIP_REMOULD_SWITCH = 2825

--[[
	[1] = {--ReqRefreshTask
	}
--]]
c2s.ZILLIONAIRE_REQ_REFRESH_TASK = 5223

--[[
	[1] = {--ReqThrowDice
		[1] = 'int32':specifyDiceNum	[装备指定点数道具时,上传指定点数]
	}
--]]
c2s.ZILLIONAIRE_REQ_THROW_DICE = 5320

--[[
	[1] = {--ReqYouciMsg
	}
--]]
c2s.YOUCI_REQ_YOUCI = 9351

--[[
	[1] = {--ReqManRefreshYouci
	}
--]]
c2s.YOUCI_REQ_MAN_REFRESH_YOUCI = 9353

--[[
	[1] = {--ReqFormationBackupHero
		[1] = 'int32':id
		[2] = 'string':sourceHeroId
		[3] = 'string':targetHeroId
	}
--]]
c2s.PLAYER_REQ_FORMATION_BACKUP_HERO = 297

--[[
	[1] = {--ReqMainAdBoardInfo
	}
--]]
c2s.SIGN_REQ_MAIN_AD_BOARD_INFO = 5120

--[[
	[1] = {--ExploreEquipUpgrade
		[1] = 'string':id	[装备id]
		[2] = 'int32':cabinId	[exploreCabin id]
	}
--]]
c2s.EXPLORE_EXPLORE_EQUIP_UPGRADE = 7807

--[[
	[1] = {--ReqYouciRank
	}
--]]
c2s.YOUCI_REQ_YOUCI_RANK = 9354

--[[
	[1] = {--ReqStartGashapon
	}
--]]
c2s.NEW_BUILDING_REQ_START_GASHAPON = 2063

--[[
	[1] = {--ReqKurumiHistoryInfo
	}
--]]
c2s.ACTIVITY_REQ_KURUMI_HISTORY_INFO = 5163

--[[
	[1] = {--ReqYearLottoReward
	}
--]]
c2s.YEAR_LOTTO_REQ_YEAR_LOTTO_REWARD = 8704

--[[
	[1] = {--ReqYearLottoAddress
		[1] = 'string':address
	}
--]]
c2s.YEAR_LOTTO_REQ_YEAR_LOTTO_ADDRESS = 8705

--[[
	[1] = {--UseItem
		[1] = {--repeated ItemInfo
			[1] = 'string':itemId
			[2] = 'int32':num
		},
		[2] = 'string':heroId
		[3] = 'string':roleId
		[4] = 'repeated int32':customParame	[选择性礼包下标]
	}
--]]
c2s.ITEM_USE_ITEM = 514

--[[
	[1] = {--ReqRankMsg
		[1] = 'int32':rankType	[榜单类型:0 全服榜,1好友榜]
	}
--]]
c2s.ODEUM_REQ_RANK = 6503

--[[
	[1] = {--ReqCancelChallenge
	}
--]]
c2s.DUNGEON_REQ_CANCEL_CHALLENGE = 1819

--[[
	[1] = {--ReqDiceContract
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_DICE_CONTRACT = 5185

--[[
	[1] = {--ReqRewardTotalPay
		[1] = 'int32':id	[奖励id]
	}
--]]
c2s.RECHARGE_REQ_REWARD_TOTAL_PAY = 4363

--[[
	[1] = {--ExploreTaskDeal
		[1] = 'int32':taskId
		[2] = 'repeated int32':heroId
	}
--]]
c2s.EXPLORE_EXPLORE_TASK_DEAL = 7811

--[[
	[1] = {--ReqRefreshAfkAwardMsg
		[1] = 'int32':activityId
	}
--]]
c2s.EXPLORE_REQ_REFRESH_AFK_AWARD = 7835

--[[
	[1] = {--ReqFriendHelpActivityPre
	}
--]]
c2s.ACTIVITY_REQ_FRIEND_HELP_ACTIVITY_PRE = 5300

--[[
	[1] = {--ReqGetFoodBaseAward
		[1] = 'int32':foodId
	}
--]]
c2s.NEW_BUILDING_REQ_GET_FOOD_BASE_AWARD = 2069

--[[
	[1] = {--ReqJoinYearLotto
	}
--]]
c2s.YEAR_LOTTO_REQ_JOIN_YEAR_LOTTO = 8703

--[[
	[1] = {--ReqTakeReward
		[1] = 'int32':index	[某个级别的奖励,从0开始,对应配置的index]
		[2] = 'int32':type	[1是个人奖励,2是全服奖励]
	}
--]]
c2s.WORLD_HELP_REQ_TAKE_REWARD = 8801

--[[
	[1] = {--ReqGetUnionRank
		[1] = 'int32':type	[type=1表示本周,type=2表示上周]
	}
--]]
c2s.JU_NAI_INVASION_REQ_GET_UNION_RANK = 9107

--[[
	[1] = {--PerformEventMsg
		[1] = 'int32':x	[ x位置]
		[2] = 'int32':y	[ y位置]
		[3] = 'int32':event	[ 事件id]
	}
--]]
c2s.QLIPHOTH_PERFORM_EVENT = 6220

--[[
	[1] = {--WorldMoveMsg
		[1] = 'int32':x	[ x位置]
		[2] = 'int32':y	[ y位置]
	}
--]]
c2s.QLIPHOTH_WORLD_MOVE = 6205

--[[
	[1] = {--ReqDetectiveEnter
		[1] = 'int32':chapterId	[选择的周目]
	}
--]]
c2s.DETECTIVE_REQ_DETECTIVE_ENTER = 8906

--[[
	[1] = {--ReqRankInfo
		[1] = 'int32':type	[1是社团内部,2是社团之间]
	}
--]]
c2s.WORLD_HELP_REQ_RANK_INFO = 8802

--[[
	[1] = {--GroupMultipleRewardMsg
	}
--]]
c2s.DUNGEON_GROUP_MULTIPLE_REWARD = 1809

--[[
	[1] = {--ReqAddHeroDispatch
		[1] = 'int32':type	[1 日常副本, 2  精灵试炼, 3  雷霆圣堂, 4  联机作战, 5  日常约会]
		[2] = {--repeated HeroDispatchReqData
			[1] = 'int32':dungeon	[关卡id]
			[2] = 'int32':count	[挂机次数]
		},
	}
--]]
c2s.HERO_DISPATCH_REQ_ADD_HERO_DISPATCH = 8602

--[[
	[1] = {--ReqStartEntranceEvent
		[1] = 'int32':datingType	[约会类型1 外传 2 主线]
		[2] = 'int32':datingValue	[当类型为外传时,值传外传ID,主线则为主线章节]
		[3] = 'int32':entranceId	[入口id]
	}
--]]
c2s.EXTRA_DATING_REQ_START_ENTRANCE_EVENT = 5634

--[[
	[1] = {--ReqBuyResourcesLog
	}
--]]
c2s.PLAYER_REQ_BUY_RESOURCES_LOG = 276

--[[
	[1] = {--GetRechargeCfg
	}
--]]
c2s.RECHARGE_GET_RECHARGE_CFG = 4360

--[[
	[1] = {--ValentinePresentMsg
		[1] = 'int32':roleid	[ 情人节看板娘id]
		[2] = {--repeated ValentineGiftInfo
			[1] = 'int32':giftCid	[ 礼物id]
			[2] = 'int32':giftNum	[ 礼物数量]
		},
	}
--]]
c2s.VALENTINE_VALENTINE_PRESENT = 7403

--[[
	[1] = {--ReqUseFireworks
		[1] = 'int32':fireworkId	[ 请求使用烟花的id]
	}
--]]
c2s.SPRING_FESTIVAL_REQ_USE_FIREWORKS = 6705

--[[
	[1] = {--ValentineInfoMsg
	}
--]]
c2s.VALENTINE_VALENTINE_INFO = 7405

--[[
	[1] = {--ReqAllActivityItem
		[1] = 'int32':activityId	[ 活动ID]
	}
--]]
c2s.ACTIVITY_REQ_ALL_ACTIVITY_ITEM = 5156

--[[
	[1] = {--LevelUp
		[1] = 'int32':buildingId	[ 建筑id]
		[2] = 'int32':targetLevel
	}
--]]
c2s.UNION_LEVEL_UP = 6657

--[[
	[1] = {--CreateUnion
		[1] = 'string':name
		[2] = 'int32':country	[国家ID]
	}
--]]
c2s.UNION_CREATE_UNION = 6650

--[[
	[1] = {--ReqGetUnionReCallRank
	}
--]]
c2s.UNION_REQ_GET_UNION_RE_CALL_RANK = 6675

--[[
	[1] = {--OperUnionMember
		[1] = 'int32':operType	[ 1申请加入 2退出 3同意申请 4拒绝申请 5团长踢人 6转让团长 7快速加入 8弹劾团长]
		[2] = 'repeated int32':targets
	}
--]]
c2s.UNION_OPER_UNION_MEMBER = 6652

--[[
	[1] = {--UpdateUnionInfo
		[1] = 'int32':type	[ 1修改社团徽记 2修改社团公告 3变更是否开启社团申请 4变更是否开启自动加入 15改名  28国家ID 29是否显示国家]
		[2] = 'string':param
	}
--]]
c2s.UNION_UPDATE_UNION_INFO = 6654

--[[
	[1] = {--ReqSupplyRecord
	}
--]]
c2s.UNION_REQ_SUPPLY_RECORD = 6663

--[[
	[1] = {--ReplaceSpecialAttrMsg
		[1] = 'string':equipmentId	[灵装id]
		[2] = 'bool':replace	[是否替换]
	}
--]]
c2s.EQUIPMENT_REPLACE_SPECIAL_ATTR = 2821

--[[
	[1] = {--UpdateDegree
		[1] = 'int32':degree
		[2] = 'int32':target
	}
--]]
c2s.UNION_UPDATE_DEGREE = 6653

--[[
	[1] = {--UnionDonate
		[1] = 'int32':itemId	[ 货币id]
		[2] = 'int32':donateVal	[捐赠数量]
	}
--]]
c2s.UNION_UNION_DONATE = 6656

--[[
	[1] = {--ReqAngelReset
		[1] = 'string':heroId
		[2] = 'repeated int32':skillType	[ 技能树类型]
	}
--]]
c2s.HERO_REQ_ANGEL_RESET = 1034

--[[
	[1] = {--Kick
		[1] = 'int32':teamId	[队伍id]
		[2] = 'int32':pid	[被踢队员pid]
	}
--]]
c2s.DUNGEON_KICK = 1807

--[[
	[1] = {--ReqAIStepFrame
		[1] = 'int32':id	[Boss ID]
		[2] = 'int32':pid	[玩家id]
		[3] = 'int32':lastStep	[上一步AI]
		[4] = 'int32':curStep	[当前AI]
		[5] = 'int32':funcID	[执行方法ID]
		[6] = 'int32':param1	[参数1]
		[7] = 'int32':param2	[参数2]
		[8] = 'int32':param3	[参数3]
	}
--]]
c2s.FIGHT_REQ_AISTEP_FRAME = 25613

--[[
	[1] = {--ReqRepairSubmit
		[1] = 'int32':count	[提交的数量]
	}
--]]
c2s.ACTIVITY2_REQ_REPAIR_SUBMIT = 9404

--[[
	[1] = {--ReqFinishProcess
		[1] = 'int32':chapterId	[章节id]
	}
--]]
c2s.ODEUM_REQ_FINISH_PROCESS = 6514

--[[
	[1] = {--SearchUnion
		[1] = 'int32':id	[ 社团id]
		[2] = 'string':name	[ 社团名]
	}
--]]
c2s.UNION_SEARCH_UNION = 6664

--[[
	[1] = {--ReqTrainMaxtriInfo
	}
--]]
c2s.UNION_REQ_TRAIN_MAXTRI_INFO = 6669

--[[
	[1] = {--ReqNeptune2ndHalfBuyCount
		[1] = 'int32':hero	[英雄]
		[2] = 'int32':count	[次数]
	}
--]]
c2s.NEPTUNE2ND_HALF_REQ_NEPTUNE2ND_HALF_BUY_COUNT = 7706

--[[
	[1] = {--OfficeTransformMsg
		[1] = 'int32':x	[ x位置]
		[2] = 'int32':y	[ y位置]
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_TRANSFORM = 7211

--[[
	[1] = {--ReceiveSupply
		[1] = 'int32':id	[ 补给id]
	}
--]]
c2s.UNION_RECEIVE_SUPPLY = 6658

--[[
	[1] = {--ReqCatUpLevel
		[1] = 'int32':catId	[猫咪id]
		[2] = {--repeated CatGoodExpItem
			[1] = 'int32':itemId	[道具id]
			[2] = 'int32':num	[道具数量]
		},
	}
--]]
c2s.ACTIVITY_REQ_CAT_UP_LEVEL = 5216

--[[
	[1] = {--ReqSelfTrainMaxtriPrize
		[1] = 'int32':index	[ 奖励索引]
	}
--]]
c2s.UNION_REQ_SELF_TRAIN_MAXTRI_PRIZE = 6673

--[[
	[1] = {--Req2020FestivalGameInit
		[1] = 'int32':city	[城市]
		[2] = 'int32':area	[点位]
	}
--]]
c2s.SPRING_FESTIVAL_REQ2020_FESTIVAL_GAME_INIT = 6713

--[[
	[1] = {--ReqNotify
		[1] = 'int64':version	[ 动态版本号]
	}
--]]
c2s.UNION_REQ_NOTIFY = 6668

--[[
	[1] = {--ReqTakeOffLadderEquipMsg
		[1] = 'string':heroId	[英雄id]
		[2] = 'string':equipmentId	[灵装id]
		[3] = 'int32':position	[位置]
	}
--]]
c2s.LADDER_REQ_TAKE_OFF_LADDER_EQUIP = 8306

--[[
	[1] = {--ReqDischarge
		[1] = 'int32':equipId	[装备id]
	}
--]]
c2s.SUMMER_COURAGE_REQ_DISCHARGE = 6906

--[[
	[1] = {--ReqUnion
	}
--]]
c2s.UNION_REQ_UNION = 6662

--[[
	[1] = {--ReqRefreshAnnivDress
	}
--]]
c2s.ANNIVERSARY2ND_REQ_REFRESH_ANNIV_DRESS = 9207

--[[
	[1] = {--HeroAdvance
		[1] = 'string':heroId
	}
--]]
c2s.HERO_HERO_ADVANCE = 1028

--[[
	[1] = {--ReqFreeSummon
	}
--]]
c2s.SUMMON_REQ_FREE_SUMMON = 3353

--[[
	[1] = {--ReqAnnivFlop
		[1] = 'int32':index	[位置]
	}
--]]
c2s.ANNIVERSARY2ND_REQ_ANNIV_FLOP = 9201

--[[
	[1] = {--ReqImpeachList
	}
--]]
c2s.UNION_REQ_IMPEACH_LIST = 6671

--[[
	[1] = {--ReqChoiceNewWar
		[1] = 'int32':warId
	}
--]]
c2s.ACTIVITY2_REQ_CHOICE_NEW_WAR = 9418

--[[
	[1] = {--ReqWeekUpdate
	}
--]]
c2s.UNION_REQ_WEEK_UPDATE = 6670

--[[
	[1] = {--ReqGetExploreAward
		[1] = 'int32':cityId	[城市id]
	}
--]]
c2s.BIRTH_DAY_REQ_GET_EXPLORE_AWARD = 8103

--[[
	[1] = {--ReqFavorDatingRoleStatue
	}
--]]
c2s.EXTRA_DATING_REQ_FAVOR_DATING_ROLE_STATUE = 5653

--[[
	[1] = {--ReqDetectiveChooseArea
		[1] = 'int32':chapterId	[周目id]
		[2] = 'int32':areaId	[所在的区域id]
		[3] = 'int32':nextAreaId	[要进入的区域id]
	}
--]]
c2s.DETECTIVE_REQ_DETECTIVE_CHOOSE_AREA = 8903

--[[
	[1] = {--ReqTickGetUnionScore
	}
--]]
c2s.UNION_REQ_TICK_GET_UNION_SCORE = 6677

--[[
	[1] = {--ReqDealEventMsg
		[1] = 'int32':id
		[2] = 'int32':eventId
		[3] = 'bool':isSkip	[true 跳过 false 开始]
		[4] = 'int32':score	[比赛分数]
	}
--]]
c2s.HANGUP_ACT_REQ_DEAL_EVENT = 9004

--[[
	[1] = {--ReqAppreciate
		[1] = 'int32':targetPid	[ 请求给谁点赞]
		[2] = 'int32':dungeonId	[ 副本id]
	}
--]]
c2s.TEAM_REQ_APPRECIATE = 5899

--[[
	[1] = {--ReqChangeElementType
		[1] = {--repeated ElementType
			[1] = 'int32':elementType	[图鉴类型]
			[2] = 'int32':type	[ //类型   type=1 不展示  type=2 好友展示  type=3 全部可见]
		},
	}
--]]
c2s.ELEMENT_COLLECT_REQ_CHANGE_ELEMENT_TYPE = 4870

--[[
	[1] = {--ReqTreatMember
		[1] = 'int32':targetPid
		[2] = 'int32':type	[ 1:任命队长 2:踢出队伍]
	}
--]]
c2s.TEAM_REQ_TREAT_MEMBER = 5891

--[[
	[1] = {--ReqUploadQteIntegral
		[1] = 'int32':foodId
		[2] = 'int32':qteId
		[3] = 'int32':integral
	}
--]]
c2s.NEW_BUILDING_REQ_UPLOAD_QTE_INTEGRAL = 2068

--[[
	[1] = {--ReqCheat
	}
--]]
c2s.PLAYER_REQ_CHEAT = 286

--[[
	[1] = {--ReqChasmReport
		[1] = 'int32':targetPid	[ 举报谁]
		[2] = 'int32':dungeonId	[ 关卡id]
		[3] = 'int32':hurt
		[4] = 'int32':hurted
		[5] = 'int32':fightTime	[ 战斗时间]
		[6] = 'int32':type	[举报类型 600041 广告 600042 作弊  600043 骚扰]
	}
--]]
c2s.TEAM_REQ_CHASM_REPORT = 5900

--[[
	[1] = {--ReqUseBuff
		[1] = 'int32':buffId	[0为取消使用,其他为对应道具id]
	}
--]]
c2s.CHASM_REQ_USE_BUFF = 6153

--[[
	[1] = {--ReqSetTeamShowType
		[1] = 'int32':showType	[0,显示所有;1,显示给好友;2,不显示]
	}
--]]
c2s.TEAM_REQ_SET_TEAM_SHOW_TYPE = 5902

--[[
	[1] = {--ReqDetectiveGameFinish
		[1] = 'repeated int32':order	[玩家的顺序]
		[2] = 'int32':id	[配置表id]
	}
--]]
c2s.DETECTIVE_REQ_DETECTIVE_GAME_FINISH = 8904

--[[
	[1] = {--ReqExtraDatingInfo
		[1] = 'int32':datingType	[约会类型1 外传 2 主线]
		[2] = 'int32':datingValue	[当类型为外传时,值传外传ID,主线则为主线章节]
		[3] = 'int32':roleId	[精灵ID]
	}
--]]
c2s.EXTRA_DATING_REQ_EXTRA_DATING_INFO = 5633

--[[
	[1] = {--ReqChristmasDungeons
	}
--]]
c2s.CHRISTMAS_REQ_CHRISTMAS_DUNGEONS = 6608

--[[
	[1] = {--ReqRiddleData
	}
--]]
c2s.ACTIVITY2_REQ_RIDDLE_DATA = 9407

--[[
	[1] = {--ReqChangeHero
		[1] = 'int32':heroCid
		[2] = 'int32':limitedHero	[ 限定配置英雄,英雄数据优先级高于heroCid]
	}
--]]
c2s.TEAM_REQ_CHANGE_HERO = 5896

--[[
	[1] = {--ReqAllTeamInfo
		[1] = 'int32':teamType	[ 类型]
		[2] = 'int32':index
	}
--]]
c2s.TEAM_REQ_ALL_TEAM_INFO = 5901

--[[
	[1] = {--ReqMatchTeam
		[1] = {--TeamFeature
			[1] = 'int32':teamType	[ 队伍类型]
			[2] = 'int32':dungeonCid	[ 副本ID]
		},
	}
--]]
c2s.TEAM_REQ_MATCH_TEAM = 5892

--[[
	[1] = {--ReqRefreshStronghold
	}
--]]
c2s.HANGUP_ACT_REQ_REFRESH_STRONGHOLD = 9012

--[[
	[1] = {--ReqLimitlessSummon
		[1] = 'int32':activityId	[活动Id]
		[2] = 'int32':cid	[活动配置Id]
	}
--]]
c2s.LIMITLESS_SUMMON_REQ_LIMITLESS_SUMMON = 3502

--[[
	[1] = {--ReqChangeMemberStatus
		[1] = 'int32':status	[ 1:空闲 2:准备中]
	}
--]]
c2s.TEAM_REQ_CHANGE_MEMBER_STATUS = 5897

--[[
	[1] = {--ReqChangeTeamStatus
		[1] = 'int32':status	[ 1:关闭自动匹配 2:开启自动匹配]
	}
--]]
c2s.TEAM_REQ_CHANGE_TEAM_STATUS = 5890

--[[
	[1] = {--ReqLadderRankList
	}
--]]
c2s.LADDER_REQ_LADDER_RANK_LIST = 8302

--[[
	[1] = {--ReqUpgradeAngleSpirit
		[1] = 'int32':hero	[cid]
		[2] = 'int32':costId	[消耗id]
	}
--]]
c2s.HERO_SPIRIT_REQ_UPGRADE_ANGLE_SPIRIT = 8409

--[[
	[1] = {--ReqFavorReward
		[1] = 'int32':favorDatingId	[Favor表对应id]
	}
--]]
c2s.EXTRA_DATING_REQ_FAVOR_REWARD = 5651

--[[
	[1] = {--ReqGetUnionPlayerRank
	}
--]]
c2s.JU_NAI_INVASION_REQ_GET_UNION_PLAYER_RANK = 9106

--[[
	[1] = {--ReqRecomposeGem
		[1] = 'int32':heroId	[ 精灵id]
		[2] = 'int32':rarity	[ 稀有度]
		[3] = 'int32':index	[ 位置]
		[4] = 'int32':type	[ 图纸(44)还是宝石(43)    // 图纸(44)还是宝石(43)]
	}
--]]
c2s.EQUIPMENT_REQ_RECOMPOSE_GEM = 2839

--[[
	[1] = {--ReqMatchRank
		[1] = 'int32':teamType	[副本类型]
		[2] = 'int32':matchId	[符石挑战为副本等级,其他为副本id]
	}
--]]
c2s.TEAM_REQ_MATCH_RANK = 5903

--[[
	[1] = {--ReqPassStageEndless
		[1] = 'int32':levelCid	[关卡id]
		[2] = 'int32':costTime	[耗时(秒)    //耗时(秒)]
		[3] = {--repeated StageHeroHealth
			[1] = 'int32':heroCid	[英雄id]
			[2] = 'int32':health	[万分比血量]
		},
		[4] = 'bool':sucess	[是否通关]
		[5] = 'int32':batter	[最大连击数]
		[6] = 'int32':damage	[伤害值]
	}
--]]
c2s.ENDLESS_CLOISTER_REQ_PASS_STAGE_ENDLESS = 5379

--[[
	[1] = {--ReqJoinTeam
		[1] = 'string':teamId	[ 队伍ID]
		[2] = 'int32':join_from	[ 加入来源 0,非好友,1,好友,2,社团]
	}
--]]
c2s.TEAM_REQ_JOIN_TEAM = 5894

--[[
	[1] = {--ReqBackHomePage
	}
--]]
c2s.TEAM_REQ_BACK_HOME_PAGE = 5904

--[[
	[1] = {--ReqInitChatInfo
	}
--]]
c2s.CHAT_REQ_INIT_CHAT_INFO = 2311

--[[
	[1] = {--ReqTouchTask
		[1] = 'int32':taskId	[ 任务Id]
	}
--]]
c2s.TASK_REQ_TOUCH_TASK = 4099

--[[
	[1] = {--ReqTasks
	}
--]]
c2s.TASK_REQ_TASKS = 4097

--[[
	[1] = {--SubmitTaskList
		[1] = 'repeated int32':taskId	[ 任务Id]
	}
--]]
c2s.TASK_SUBMIT_TASK_LIST = 4096

--[[
	[1] = {--ReqGetGashaponInfo
	}
--]]
c2s.NEW_BUILDING_REQ_GET_GASHAPON_INFO = 2062

--[[
	[1] = {--Req2019ChristmasTalent
		[1] = 'int32':talent	[改造天赋id]
	}
--]]
c2s.CHRISTMAS_REQ2019_CHRISTMAS_TALENT = 6615

--[[
	[1] = {--SubmitTask
		[1] = 'int32':taskCid
	}
--]]
c2s.TASK_SUBMIT_TASK = 4098

--[[
	[1] = {--ReqResetSkill
		[1] = 'string':heroId
		[2] = 'int32':skillStrategyId
	}
--]]
c2s.HERO_REQ_RESET_SKILL = 1044

--[[
	[1] = {--ReqChangeSwitch
		[1] = {--repeated Switch
			[1] = 'int32':type	[1 : 好友交易开关]
			[2] = 'int32':value	[type = 1 (0:关闭全体交易黑名单,1:打开全体交易黑名单)    //type = 1 (0:关闭全体交易黑名单,1:打开全体交易黑名单)]
		},
	}
--]]
c2s.ACTIVITY_REQ_CHANGE_SWITCH = 5201

--[[
	[1] = {--ReqGetSystemTitleInfo
	}
--]]
c2s.SYSTEM_TITLE_REQ_GET_SYSTEM_TITLE_INFO = 8150

--[[
	[1] = {--ReqTakeOffSystemTitle
	}
--]]
c2s.SYSTEM_TITLE_REQ_TAKE_OFF_SYSTEM_TITLE = 8152

--[[
	[1] = {--ReqValueAward
		[1] = 'int32':summid	[ 召唤id]
		[2] = 'int32':num	[ 次数]
	}
--]]
c2s.SUMMON_REQ_VALUE_AWARD = 3337

--[[
	[1] = {--ReqSummonComposeSpeed
		[1] = 'int32':cid	[合成召唤id]
	}
--]]
c2s.SUMMON_REQ_SUMMON_COMPOSE_SPEED = 3345

--[[
	[1] = {--ReqAnnivStart
	}
--]]
c2s.ANNIVERSARY2ND_REQ_ANNIV_START = 9205

--[[
	[1] = {--ReqChangeNewWorldRoom
		[1] = 'int32':roomId
		[2] = 'int32':roomType	[更换房间的类型]
	}
--]]
c2s.NEW_WORLD_REQ_CHANGE_NEW_WORLD_ROOM = 6806

--[[
	[1] = {--ReqReportAD
		[1] = 'int32':pid	[被举报的玩家id]
		[2] = 'int32':type	[举报类型 600041 广告 600042 作弊  600043 骚扰]
	}
--]]
c2s.PLAYER_REQ_REPORT_AD = 285

--[[
	[1] = {--ReqSimulateSummonReplace
		[1] = 'bool':isReplace
		[2] = 'int32':order
	}
--]]
c2s.SUMMON_REQ_SIMULATE_SUMMON_REPLACE = 3351

--[[
	[1] = {--ReqActivityExchange
		[1] = 'repeated string':choiceId	[ 选择的物品ID]
		[2] = 'int32':targetModelId	[ 要兑换的物品ModelId]
	}
--]]
c2s.SUMMON_REQ_ACTIVITY_EXCHANGE = 3355

--[[
	[1] = {--ReqRecordNewbieStep
		[1] = 'int32':stepId	[步骤id]
	}
--]]
c2s.SUMMER_COURAGE_REQ_RECORD_NEWBIE_STEP = 6913

--[[
	[1] = {--ReqNoobAward
		[1] = 'int32':targetAwardId	[ 要兑换的物品]
	}
--]]
c2s.SUMMON_REQ_NOOB_AWARD = 3340

--[[
	[1] = {--ReqNWSummonReward
	}
--]]
c2s.SUMMON_REQ_NWSUMMON_REWARD = 3342

--[[
	[1] = {--ReqSetSupportRoleMsg
		[1] = 'repeated int32':roleId
	}
--]]
c2s.HANGUP_ACT_REQ_SET_SUPPORT_ROLE = 9006

--[[
	[1] = {--ChangeHelpFightHero
		[1] = 'string':heroId
	}
--]]
c2s.PLAYER_CHANGE_HELP_FIGHT_HERO = 269

--[[
	[1] = {--Req2020FestivalResource
		[1] = 'int32':dungeon	[需要领取的关卡]
		[2] = 'int32':count	[领取次数]
		[3] = 'int32':multiple	[领取倍数,暂时只有2倍]
	}
--]]
c2s.SPRING_FESTIVAL_REQ2020_FESTIVAL_RESOURCE = 6711

--[[
	[1] = {--ReqSpeedPartTimeJob
	}
--]]
c2s.NEW_BUILDING_REQ_SPEED_PART_TIME_JOB = 2075

--[[
	[1] = {--ReqHotSummonInfo
	}
--]]
c2s.SUMMON_REQ_HOT_SUMMON_INFO = 3343

--[[
	[1] = {--ReqChooseArea
		[1] = 'int32':chapterId	[周目id]
		[2] = 'int32':areaId	[所在的区域id]
		[3] = 'int32':nextAreaId	[要进入的区域id]
		[4] = 'int32':evtId	[事件id]
	}
--]]
c2s.SUMMER_COURAGE_REQ_CHOOSE_AREA = 6903

--[[
	[1] = {--ReqEvtFinish
		[1] = 'int32':chapterId	[周目id]
		[2] = 'int32':areaId	[区域i]
		[3] = 'int32':evtId	[事件id]
	}
--]]
c2s.SUMMER_COURAGE_REQ_EVT_FINISH = 6902

--[[
	[1] = {--ReqSummerCourageExplore
		[1] = 'int32':chapterId	[周目id]
		[2] = 'int32':areaId	[区域id]
	}
--]]
c2s.SUMMER_COURAGE_REQ_SUMMER_COURAGE_EXPLORE = 6901

--[[
	[1] = {--ReqGameFinish
		[1] = 'int32':type	[游戏类型]
		[2] = 'repeated int32':order	[玩家的顺序]
	}
--]]
c2s.SUMMER_COURAGE_REQ_GAME_FINISH = 6908

--[[
	[1] = {--ReqEquip
		[1] = 'int32':equipId	[装备id]
	}
--]]
c2s.SUMMER_COURAGE_REQ_EQUIP = 6905

--[[
	[1] = {--ReqChapterMap
		[1] = 'int32':chapterId	[周目id]
	}
--]]
c2s.SUMMER_COURAGE_REQ_CHAPTER_MAP = 6904

--[[
	[1] = {--ReqSimulateSummonExchange
		[1] = 'int32':cid
		[2] = 'int32':order
	}
--]]
c2s.SUMMON_REQ_SIMULATE_SUMMON_EXCHANGE = 3352

--[[
	[1] = {--ExploreTechUpgrade
		[1] = 'int32':type
		[2] = 'int32':nationId	[国家id]
		[3] = 'int32':techId	[要学习的技能id]
	}
--]]
c2s.EXPLORE_EXPLORE_TECH_UPGRADE = 7816

--[[
	[1] = {--ChallengeInfoMsg
	}
--]]
c2s.HERO_CHALLENGE_CHALLENGE_INFO = 6301

--[[
	[1] = {--BuyGoods
		[1] = 'int32':cid	[ 商品ID]
		[2] = 'int32':num	[ 购买数量]
	}
--]]
c2s.STORE_BUY_GOODS = 2562

--[[
	[1] = {--ReqChangeAppearance
		[1] = 'int32':changeType	[1切换皮肤和英雄id  2:切换特效]
		[2] = 'int32':heroId	[英雄]
		[3] = 'string':skinId
	}
--]]
c2s.NEW_WORLD_REQ_CHANGE_APPEARANCE = 6803

--[[
	[1] = {--ReqGetZZAllServerMsg
	}
--]]
c2s.ACTIVITY_REQ_GET_ZZALL_SERVER = 5137

--[[
	[1] = {--ReqPartTimeJobList
	}
--]]
c2s.NEW_BUILDING_REQ_PART_TIME_JOB_LIST = 2076

--[[
	[1] = {--SellGoodsPreview
		[1] = {--repeated SellGoods
			[1] = 'string':id	[ 物品id]
			[2] = 'int32':num	[出售数量]
		},
	}
--]]
c2s.STORE_SELL_GOODS_PREVIEW = 2567

--[[
	[1] = {--ReqReadAllSpringWish
	}
--]]
c2s.SPRING_WISH_REQ_READ_ALL_SPRING_WISH = 7503

--[[
	[1] = {--ReqQuickActiveCrystal
		[1] = 'string':heroId
		[2] = 'bool':isReplace
	}
--]]
c2s.HERO_REQ_QUICK_ACTIVE_CRYSTAL = 1050

--[[
	[1] = {--ReqAITriggerType
	}
--]]
c2s.DATING_REQ_AITRIGGER_TYPE = 1559

--[[
	[1] = {--ReqGetReward
	}
--]]
c2s.SPRING_WISH_REQ_GET_REWARD = 7505

--[[
	[1] = {--GetLevelGroupReward
		[1] = 'int32':cid	[副本组cid]
		[2] = 'int32':difficulty	[难度]
		[3] = 'string':starNum	[星数]
	}
--]]
c2s.DUNGEON_GET_LEVEL_GROUP_REWARD = 1802

--[[
	[1] = {--ReqSupportListMsg
	}
--]]
c2s.HANGUP_ACT_REQ_SUPPORT_LIST = 9005

--[[
	[1] = {--ReqRefreshSpringFestivalTask
		[1] = 'int32':mode	[ 1 普通刷新 2 钻石刷新]
		[2] = 'int32':roleId	[ 刷新哪个看板娘的]
	}
--]]
c2s.SPRING_FESTIVAL_REQ_REFRESH_SPRING_FESTIVAL_TASK = 6707

--[[
	[1] = {--ReqCrossRankActivity
		[1] = 'int32':activityId	[ 活动ID]
	}
--]]
c2s.ACTIVITY_REQ_CROSS_RANK_ACTIVITY = 5153

--[[
	[1] = {--ReqRewardInvite
		[1] = 'int32':cid	[ 对应邀请奖励配置表id]
	}
--]]
c2s.FRIEND_REQ_REWARD_INVITE = 3080

--[[
	[1] = {--Req2020FestivalGameFinish
		[1] = 'int32':city	[城市]
		[2] = 'int32':area	[点位]
		[3] = 'int32':group	[组合id]
		[4] = 'repeated int32':param	[游戏选项]
	}
--]]
c2s.SPRING_FESTIVAL_REQ2020_FESTIVAL_GAME_FINISH = 6714

--[[
	[1] = {--ReqSummonPreview
	}
--]]
c2s.SUMMON_REQ_SUMMON_PREVIEW = 3344

--[[
	[1] = {--ReqCancelMark
		[1] = 'int32':portraitType
	}
--]]
c2s.PORTRAIT_REQ_CANCEL_MARK = 7003

--[[
	[1] = {--ReqUseFirecracker
	}
--]]
c2s.SPRING_FESTIVAL_REQ_USE_FIRECRACKER = 6702

--[[
	[1] = {--ReqEnterMemory
		[1] = 'int32':taskId	[任务id]
	}
--]]
c2s.SNOW_FESTIVAL_REQ_ENTER_MEMORY = 9307

--[[
	[1] = {--ReqYearLottoList
	}
--]]
c2s.YEAR_LOTTO_REQ_YEAR_LOTTO_LIST = 8702

--[[
	[1] = {--SupplySign
		[1] = 'int32':id	[ 活动ID]
	}
--]]
c2s.SIGN_SUPPLY_SIGN = 5123

--[[
	[1] = {--ReqGetUnionPlayerAttr
	}
--]]
c2s.JU_NAI_INVASION_REQ_GET_UNION_PLAYER_ATTR = 9105

--[[
	[1] = {--ReqgetAwardSacrifice
		[1] = 'int32':itemId	[色子id]
		[2] = 'int32':step	[色子指定步数]
	}
--]]
c2s.SACRIFICE_REQGET_AWARD_SACRIFICE = 8001

--[[
	[1] = {--ReqApprenticeList
	}
--]]
c2s.APPRENTICE_REQ_APPRENTICE_LIST = 7903

--[[
	[1] = {--ReqFightSpringEnvelope
		[1] = 'int32':senderId	[发红包的玩家id]
		[2] = 'int64':createTime	[红包发出的时间]
		[3] = 'int32':id	[配置id]
	}
--]]
c2s.RED_ENVELOPE_REQ_FIGHT_SPRING_ENVELOPE = 7307

--[[
	[1] = {--SubmitGameMsg
		[1] = 'repeated int32':options	[ 选项列表]
	}
--]]
c2s.QLIPHOTH_SUBMIT_GAME = 6229

--[[
	[1] = {--SubmitSign
		[1] = 'int32':id	[ 活动ID]
	}
--]]
c2s.SIGN_SUBMIT_SIGN = 5122

--[[
	[1] = {--ReqSignInfos
	}
--]]
c2s.SIGN_REQ_SIGN_INFOS = 5121

--[[
	[1] = {--ReqLadderHeroList
		[1] = 'repeated int32':heroes	[精灵id]
	}
--]]
c2s.LADDER_REQ_LADDER_HERO_LIST = 8304

--[[
	[1] = {--ReqIntoPanel
		[1] = 'int32':id	[ ID]
	}
--]]
c2s.SHARE_REQ_INTO_PANEL = 6104

--[[
	[1] = {--ReqBlackWhiteRank
	}
--]]
c2s.NEW_WORLD_REQ_BLACK_WHITE_RANK = 6817

--[[
	[1] = {--ReqDetectiveSign
	}
--]]
c2s.DETECTIVE_REQ_DETECTIVE_SIGN = 8914

--[[
	[1] = {--ReqTimeLinkageCG
		[1] = 'int32':cid	[ 联动开场动画标识,客户端用]
	}
--]]
c2s.DUNGEON_REQ_TIME_LINKAGE_CG = 1816

--[[
	[1] = {--ReqSetChallengeHero
		[1] = 'int32':floor	[挑战楼层]
		[2] = {--repeated Formation
			[1] = 'int32':round	[派遣的关卡]
			[2] = {--repeated HeroIndex
				[1] = 'int32':index
				[2] = 'int32':hero
			},
		},
	}
--]]
c2s.DUNGEON_REQ_SET_CHALLENGE_HERO = 1821

--[[
	[1] = {--ReqUseTrialCard
		[1] = 'string':itemId
	}
--]]
c2s.ITEM_REQ_USE_TRIAL_CARD = 517

--[[
	[1] = {--ReqSpringSacrifice
	}
--]]
c2s.SACRIFICE_REQ_SPRING_SACRIFICE = 8000

--[[
	[1] = {--ChallengeAwardMsg
	}
--]]
c2s.HERO_CHALLENGE_CHALLENGE_AWARD = 6303

--[[
	[1] = {--ReqEquipPassiveSkill
		[1] = 'string':heroId
		[2] = 'int32':skillId
		[3] = 'int32':pos
	}
--]]
c2s.HERO_REQ_EQUIP_PASSIVE_SKILL = 1041

--[[
	[1] = {--BuyFightCount
		[1] = 'int32':cid	[副本组cid]
	}
--]]
c2s.DUNGEON_BUY_FIGHT_COUNT = 1800

--[[
	[1] = {--ReqQuickReceiveFriendHelpTask
	}
--]]
c2s.FRIEND_REQ_QUICK_RECEIVE_FRIEND_HELP_TASK = 3092

--[[
	[1] = {--ReqEquipMedal
		[1] = 'int32':cid
	}
--]]
c2s.MEDAL_REQ_EQUIP_MEDAL = 3002

--[[
	[1] = {--ReqDressGroup
	}
--]]
c2s.ROLE_REQ_DRESS_GROUP = 1292

--[[
	[1] = {--ReqSetDressGroup
		[1] = 'int32':dressId	[ 设置的看板id]
	}
--]]
c2s.ROLE_REQ_SET_DRESS_GROUP = 1293

--[[
	[1] = {--ReqKurumiCamp
		[1] = 'int32':camp	[阵营]
	}
--]]
c2s.ACTIVITY_REQ_KURUMI_CAMP = 5166

--[[
	[1] = {--UnlockRoom
		[1] = 'int32':roomCid	[ 房间cid]
	}
--]]
c2s.ROLE_UNLOCK_ROOM = 1289

--[[
	[1] = {--Donate
		[1] = 'string':roleId	[ 精灵ID]
		[2] = 'int32':itemCid	[ 赠送道具ID]
		[3] = 'int32':num	[ 赠送数量]
	}
--]]
c2s.ROLE_DONATE = 1282

--[[
	[1] = {--GetRole
	}
--]]
c2s.ROLE_GET_ROLE = 1281

--[[
	[1] = {--ReqSetRotationOpen
		[1] = 'bool':rotationState	[轮换是否开启]
	}
--]]
c2s.ROLE_REQ_SET_ROTATION_OPEN = 1291

--[[
	[1] = {--ReqSetRotationList
		[1] = 'repeated int32':rotationList	[轮换列表]
	}
--]]
c2s.ROLE_REQ_SET_ROTATION_LIST = 1290

--[[
	[1] = {--SwitchRole
		[1] = 'string':roleId	[ 精灵id]
	}
--]]
c2s.ROLE_SWITCH_ROLE = 1285

--[[
	[1] = {--TakeOffEquipmentMsg
		[1] = 'string':heroId	[英雄id]
		[2] = 'string':equipmentId	[灵装id]
		[3] = 'int32':position	[位置]
	}
--]]
c2s.EQUIPMENT_TAKE_OFF_EQUIPMENT = 2818

--[[
	[1] = {--ReqOpenEnvelope
		[1] = 'string':id	[红包id]
	}
--]]
c2s.RED_ENVELOPE_REQ_OPEN_ENVELOPE = 7304

--[[
	[1] = {--FightOverMsg
		[1] = 'int32':levelCid	[关卡cid]
		[2] = 'bool':isWin	[是否胜利]
		[3] = 'repeated int32':goals	[达成目标的下标]
		[4] = 'int32':batter	[最大连击数]
		[5] = 'int32':pickUpTypeCount	[拾取道具种类个数]
		[6] = 'int32':pickUpCount	[拾取道具个数]
		[7] = {--repeated KilledEnemyInfo
			[1] = 'int32':enemyCid	[敌人id]
			[2] = 'int32':enemyNum	[敌人数量]
		},
		[8] = 'int32':fightTime	[ 战斗时间]
		[9] = 'int64':damage	[ 总伤害值]
		[10] = 'int32':rating	[ 评级]
		[11] = {--repeated SkillKEnemyInfo
			[1] = 'int32':skillId	[技能id]
			[2] = 'int32':enemyNum	[敌人数量]
		},
	}
--]]
c2s.DUNGEON_FIGHT_OVER = 1794

--[[
	[1] = {--ReqChargeExchange
		[1] = 'int32':rechargeId	[充值档位id]
		[2] = 'string':discountId	[折扣券道具id]
		[3] = 'int32':redPackId	[社团红包id]
		[4] = 'string':bless	[社团红包祝福]
		[5] = 'int32':buyCount	[兑换数量]
	}
--]]
c2s.RECHARGE_REQ_CHARGE_EXCHANGE = 4368

--[[
	[1] = {--ReqMyGroupTeam
	}
--]]
c2s.RECHARGE_REQ_MY_GROUP_TEAM = 4383

--[[
	[1] = {--ExploreEquipPutOn
		[1] = 'string':id	[装备id]
		[2] = 'int32':cabinId	[舱室id]
		[3] = 'int32':index
	}
--]]
c2s.EXPLORE_EXPLORE_EQUIP_PUT_ON = 7808

--[[
	[1] = {--ReqRewardRecord
	}
--]]
c2s.WORLD_HELP_REQ_REWARD_RECORD = 8803

--[[
	[1] = {--NewReqYearActivityMonthProgress
		[1] = 'int32':activityId	[ 活动id]
		[2] = 'string':extendData	[ 扩展数据]
	}
--]]
c2s.ACTIVITY_NEW_REQ_YEAR_ACTIVITY_MONTH_PROGRESS = 5144

--[[
	[1] = {--ReqGrowthFundsInfo
	}
--]]
c2s.RECHARGE_REQ_GROWTH_FUNDS_INFO = 4370

--[[
	[1] = {--GainMonthCardItem
	}
--]]
c2s.RECHARGE_GAIN_MONTH_CARD_ITEM = 4354

--[[
	[1] = {--ReqGetFunAward
		[1] = 'int32':id	[ 系统基金id]
	}
--]]
c2s.RECHARGE_REQ_GET_FUN_AWARD = 4375

--[[
	[1] = {--ReqPhantomInfo
	}
--]]
c2s.PLAYER_REQ_PHANTOM_INFO = 301

--[[
	[1] = {--ReqSendBulletScreen
		[1] = 'string':content
		[2] = 'int32':barrageId	[如果是约会弹幕 约会剧本id]
		[3] = 'int32':dialogueId	[约会弹幕 句子id]
	}
--]]
c2s.CHAT_REQ_SEND_BULLET_SCREEN = 2315

--[[
	[1] = {--ReqMonthCardStore
		[1] = 'int32':id	[礼包id]
	}
--]]
c2s.RECHARGE_REQ_MONTH_CARD_STORE = 4367

--[[
	[1] = {--ReqResetSpiritPoints
		[1] = 'int32':spiritType	[灵力类型]
	}
--]]
c2s.HERO_SPIRIT_REQ_RESET_SPIRIT_POINTS = 8402

--[[
	[1] = {--ReqExitGroupTeam
		[1] = 'string':teamId
	}
--]]
c2s.RECHARGE_REQ_EXIT_GROUP_TEAM = 4379

--[[
	[1] = {--ReqConfirmTrade
		[1] = 'int32':friendId	[好友id]
	}
--]]
c2s.ACTIVITY_REQ_CONFIRM_TRADE = 5199

--[[
	[1] = {--ReqGroupGiftInfo
	}
--]]
c2s.RECHARGE_REQ_GROUP_GIFT_INFO = 4384

--[[
	[1] = {--ReqCreateGroupTeam
		[1] = 'int32':giftId	[团购礼包id]
		[2] = 'bool':isShow	[是否显示]
	}
--]]
c2s.RECHARGE_REQ_CREATE_GROUP_TEAM = 4376

--[[
	[1] = {--ReqWeekCardInfo
	}
--]]
c2s.RECHARGE_REQ_WEEK_CARD_INFO = 4387

--[[
	[1] = {--ReqSupportAddress
	}
--]]
c2s.ACTIVITY_REQ_SUPPORT_ADDRESS = 5155

--[[
	[1] = {--ReqVoteActivity
		[1] = 'int32':itemId	[条目id]
		[2] = 'int32':count	[投的几票]
	}
--]]
c2s.ACTIVITY_REQ_VOTE_ACTIVITY = 5189

--[[
	[1] = {--ReqUpdateSupportAddress
		[1] = 'string':address	[邮寄地址]
	}
--]]
c2s.ACTIVITY_REQ_UPDATE_SUPPORT_ADDRESS = 5154

--[[
	[1] = {--GetMonthCardWelfareInfo
	}
--]]
c2s.RECHARGE_GET_MONTH_CARD_WELFARE_INFO = 4365

--[[
	[1] = {--ReqReceiveSysFunInfo
	}
--]]
c2s.RECHARGE_REQ_RECEIVE_SYS_FUN_INFO = 4374

--[[
	[1] = {--ReqGetWeekAward
	}
--]]
c2s.RECHARGE_REQ_GET_WEEK_AWARD = 4388

--[[
	[1] = {--ReqReceiveLevelAward
		[1] = 'int32':id	[ 成长基金id]
	}
--]]
c2s.RECHARGE_REQ_RECEIVE_LEVEL_AWARD = 4371

--[[
	[1] = {--OfficePerformEventMsg
		[1] = 'int32':x	[ x位置]
		[2] = 'int32':y	[ y位置]
		[3] = 'int32':event	[ 事件id]
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_PERFORM_EVENT = 7220

--[[
	[1] = {--GetMonthCardInfo
	}
--]]
c2s.RECHARGE_GET_MONTH_CARD_INFO = 4356

--[[
	[1] = {--SellInfo
		[1] = {--repeated SellGoods
			[1] = 'string':id	[ 物品id]
			[2] = 'int32':num	[出售数量]
		},
	}
--]]
c2s.STORE_SELL_INFO = 2565

--[[
	[1] = {--ReqTaskReward
		[1] = 'int32':taskId	[任务id,对应阶段任务表]
	}
--]]
c2s.APPRENTICE_REQ_TASK_REWARD = 7908

--[[
	[1] = {--GetOrderNo
		[1] = 'int32':goodsId	[商品id]
		[2] = 'string':extinfo	[额外信息 json]
	}
--]]
c2s.RECHARGE_GET_ORDER_NO = 4353

--[[
	[1] = {--ReqFinishGame
		[1] = 'int32':gameId	[游戏id]
	}
--]]
c2s.SNOW_FESTIVAL_REQ_FINISH_GAME = 9306

--[[
	[1] = {--ComposeSummon
		[1] = 'int32':cid	[合成召唤id]
	}
--]]
c2s.SUMMON_COMPOSE_SUMMON = 3330

--[[
	[1] = {--ParticleWorldInfoMsg
		[1] = 'int32':worldCid	[当前世界cid]
	}
--]]
c2s.QLIPHOTH_PARTICLE_WORLD_INFO = 6202

--[[
	[1] = {--ReqRank
		[1] = 'int32':activityId	[ 活动ID]
	}
--]]
c2s.ACTIVITY_REQ_RANK = 5130

--[[
	[1] = {--QliphothTimeMsg
	}
--]]
c2s.QLIPHOTH_QLIPHOTH_TIME = 6222

--[[
	[1] = {--GetMainLineProgress
	}
--]]
c2s.DUNGEON_GET_MAIN_LINE_PROGRESS = 1798

--[[
	[1] = {--ReqRefreshEntrustActivityTask
		[1] = 'int32':activityId	[ 活动ID]
		[2] = 'int32':type	[ 1-普通刷新 2-钻石刷新    // 1-普通刷新 2-钻石刷新]
	}
--]]
c2s.ACTIVITY_REQ_REFRESH_ENTRUST_ACTIVITY_TASK = 5133

--[[
	[1] = {--ReqGetLinkAge
	}
--]]
c2s.DUNGEON_REQ_GET_LINK_AGE = 1825

--[[
	[1] = {--ReqCancelBalloonTrade
		[1] = 'int32':friendId	[好友id]
	}
--]]
c2s.ACTIVITY_REQ_CANCEL_BALLOON_TRADE = 5198

--[[
	[1] = {--ReqFormationBackupUse
		[1] = 'int32':id
	}
--]]
c2s.PLAYER_REQ_FORMATION_BACKUP_USE = 298

--[[
	[1] = {--ReqRecoverTime
	}
--]]
c2s.ACTIVITY_REQ_RECOVER_TIME = 5140

--[[
	[1] = {--ReqReviveFight
		[1] = 'bool':isReviveFight	[ 解码器必须要有内容,所以加上这个bool]
	}
--]]
c2s.FIGHT_REQ_REVIVE_FIGHT = 25607

--[[
	[1] = {--ReqActivatePortraits
	}
--]]
c2s.PORTRAIT_REQ_ACTIVATE_PORTRAITS = 7001

--[[
	[1] = {--ReqFormationBackupDesc
		[1] = 'int32':id
		[2] = 'string':desc	[名称描述]
	}
--]]
c2s.PLAYER_REQ_FORMATION_BACKUP_DESC = 299

--[[
	[1] = {--ReqEquipRecycle
		[1] = 'int32':type	[回收类型 1普通回收 2高级回收]
		[2] = 'string':equipmentId	[灵装id]
	}
--]]
c2s.EQUIPMENT_REQ_EQUIP_RECYCLE = 2824

--[[
	[1] = {--ReqExploreTechInfos
	}
--]]
c2s.EXPLORE_REQ_EXPLORE_TECH_INFOS = 7815

--[[
	[1] = {--ReqHuntingRank
	}
--]]
c2s.HUNTING_DUNGEON_REQ_HUNTING_RANK = 8502

--[[
	[1] = {--ReqDecomposeMaterials
		[1] = {--repeated CrystalMaterial
			[1] = 'int32':id	[ 材料id]
			[2] = 'int32':num	[ 数量]
		},
	}
--]]
c2s.HERO_REQ_DECOMPOSE_MATERIALS = 1049

--[[
	[1] = {--ReqSummonCount
	}
--]]
c2s.SUMMON_REQ_SUMMON_COUNT = 3339

--[[
	[1] = {--ShopPurchaseMsg
		[1] = 'int32':listId	[ 商品id]
		[2] = 'int32':num	[ 商品数量]
	}
--]]
c2s.QLIPHOTH_SHOP_PURCHASE = 6212

--[[
	[1] = {--GetScriptMsg
		[1] = {--ScriptType(enum)
			'v4':ScriptType
		},
		[2] = 'int32':roleId	[精灵id]
		[3] = 'int32':buildId	[ 建筑id]
		[4] = 'int32':scriptId	[剧本id]
		[5] = 'int32':cityId	[ 区域id]
		[6] = 'string':cityDatingId	[ 城市约会id]
	}
--]]
c2s.DATING_GET_SCRIPT = 1537

--[[
	[1] = {--SetPlayerInfo
		[1] = 'string':playerName	[ 玩家名字]
		[2] = 'string':remark	[ 玩家宣言]
	}
--]]
c2s.PLAYER_SET_PLAYER_INFO = 260

--[[
	[1] = {--GetAllElement
	}
--]]
c2s.ELEMENT_COLLECT_GET_ALL_ELEMENT = 4865

--[[
	[1] = {--ReqHalloweenPass
	}
--]]
c2s.ACTIVITY_REQ_HALLOWEEN_PASS = 5202

--[[
	[1] = {--ReqRefreshRecruit
		[1] = 'int32':type	[消耗类型]
	}
--]]
c2s.MAID_ACTIVITY_REQ_REFRESH_RECRUIT = 9154

--[[
	[1] = {--ReqSaveEquipBackupPos
		[1] = 'int32':id	[ 方案id]
		[2] = {--repeated EquipBackupClient
			[1] = 'int32':position	[质点位置]
			[2] = 'string':equipId	[质点id]
		},
	}
--]]
c2s.EQUIPMENT_REQ_SAVE_EQUIP_BACKUP_POS = 2842

--[[
	[1] = {--PanelStayTime
		[1] = 'int32':id	[面板功能id]
		[2] = 'int32':time	[面板停留时长]
	}
--]]
c2s.PLAYER_PANEL_STAY_TIME = 292

--[[
	[1] = {--ReqJoinGroupTeam
		[1] = 'string':teamId
	}
--]]
c2s.RECHARGE_REQ_JOIN_GROUP_TEAM = 4377

--[[
	[1] = {--ReqSelectBalloonId
		[1] = 'int32':friendId	[好友id]
		[2] = {--repeated Pair
			[1] = 'int32':key
			[2] = 'int32':value
		},
		[3] = 'bool':confirm	[锁定状态 true已锁定 false 未锁定]
	}
--]]
c2s.ACTIVITY_REQ_SELECT_BALLOON_ID = 5197

--[[
	[1] = {--TestMsg
		[1] = 'string':content
	}
--]]
c2s.PLAYER_TEST = 266

--[[
	[1] = {--ReqModifyStrategyName
		[1] = 'string':heroId
		[2] = 'int32':skillStrategyId
		[3] = 'string':name
	}
--]]
c2s.HERO_REQ_MODIFY_STRATEGY_NAME = 1039

--[[
	[1] = {--WorldTransformMsg
		[1] = 'int32':x	[ x位置]
		[2] = 'int32':y	[ y位置]
	}
--]]
c2s.QLIPHOTH_WORLD_TRANSFORM = 6211

--[[
	[1] = {--ReqGetRelieveHeartState
	}
--]]
c2s.DATING_REQ_GET_RELIEVE_HEART_STATE = 1558

--[[
	[1] = {--OperateFormation
		[1] = 'int32':formationType
		[2] = 'string':sourceHeroId
		[3] = 'string':targetHeroId
	}
--]]
c2s.PLAYER_OPERATE_FORMATION = 264

--[[
	[1] = {--ReqPartTimeJobAward
		[1] = 'int32':buildingId	[建筑ID]
		[2] = 'int32':jobId	[兼职id]
	}
--]]
c2s.NEW_BUILDING_REQ_PART_TIME_JOB_AWARD = 2078

--[[
	[1] = {--GetPlayerInfo
	}
--]]
c2s.PLAYER_GET_PLAYER_INFO = 267

--[[
	[1] = {--ReqNewWorldMissionInfo
	}
--]]
c2s.NEW_WORLD_REQ_NEW_WORLD_MISSION_INFO = 6811

--[[
	[1] = {--ReqEffectBuff
		[1] = 'repeated int32':roleId	[物品Map]
	}
--]]
c2s.HANGUP_ACT_REQ_EFFECT_BUFF = 9010

--[[
	[1] = {--ReqSimulateSummon
		[1] = 'int32':cid	[召唤id]
	}
--]]
c2s.SUMMON_REQ_SIMULATE_SUMMON = 3350

--[[
	[1] = {--ReqChangeLinkAgeDesire
		[1] = 'int32':attributeId	[属性id]
		[2] = 'int32':heroId	[英雄id]
	}
--]]
c2s.DUNGEON_REQ_CHANGE_LINK_AGE_DESIRE = 1827

--[[
	[1] = {--ReqSetLinkAgeHero
		[1] = 'int32':index	[位置]
		[2] = 'int32':heroId	[英雄id]
	}
--]]
c2s.DUNGEON_REQ_SET_LINK_AGE_HERO = 1826

--[[
	[1] = {--GetFormations
	}
--]]
c2s.PLAYER_GET_FORMATIONS = 265

--[[
	[1] = {--ReqCabinInfo
		[1] = 'int32':id	[舱室类型]
	}
--]]
c2s.EXPLORE_REQ_CABIN_INFO = 7802

--[[
	[1] = {--ReqRedPoint
		[1] = 'int32':id
	}
--]]
c2s.PLAYER_REQ_RED_POINT = 300

--[[
	[1] = {--ReqDeleteSpringWish
		[1] = 'string':id	[寄语id]
	}
--]]
c2s.SPRING_WISH_REQ_DELETE_SPRING_WISH = 7504

--[[
	[1] = {--ReqFavorDatingPanel
		[1] = 'int32':roleId	[精灵ID]
	}
--]]
c2s.EXTRA_DATING_REQ_FAVOR_DATING_PANEL = 5650

--[[
	[1] = {--ReqFreshRoleNotice
		[1] = 'int32':roleId	[精灵id]
	}
--]]
c2s.EXTRA_DATING_REQ_FRESH_ROLE_NOTICE = 5661

--[[
	[1] = {--ReqCatRecruit
	}
--]]
c2s.ACTIVITY_REQ_CAT_RECRUIT = 5218

--[[
	[1] = {--ReqResetSpeedLink
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_RESET_SPEED_LINK = 5150

--[[
	[1] = {--ReqLadderLastData
	}
--]]
c2s.LADDER_REQ_LADDER_LAST_DATA = 8303

--[[
	[1] = {--ReqChooseEntranceEvent
		[1] = 'int32':datingType	[约会类型1 外传 2 主线]
		[2] = 'int32':datingValue	[当类型为外传时,值传外传ID,主线则为主线章节]
		[3] = 'int32':eventId	[事件id,剧本/信息]
		[4] = 'int32':entranceId	[入口id]
		[5] = 'int32':choiceType	[ 选择项类型,1:剧本/2:信息]
		[6] = 'int32':choice	[ 选择项]
	}
--]]
c2s.EXTRA_DATING_REQ_CHOOSE_ENTRANCE_EVENT = 5635

--[[
	[1] = {--AreaOutlineMsg
	}
--]]
c2s.OFFICE_EXPLORE_AREA_OUTLINE = 7102

--[[
	[1] = {--ReqComment
		[1] = 'int32':type	[装备:1,英雄:2]
		[2] = 'int32':itemId	[请求的对象(装备/英雄)id    //请求的对象(装备/英雄)id]
	}
--]]
c2s.COMMENT_REQ_COMMENT = 4001

--[[
	[1] = {--ReqLookTriggerMessage
		[1] = 'int32':roleId	[精灵ID]
	}
--]]
c2s.DATING_REQ_LOOK_TRIGGER_MESSAGE = 1561

--[[
	[1] = {--ReqCrossSupportInfo
	}
--]]
c2s.ACTIVITY_REQ_CROSS_SUPPORT_INFO = 5205

--[[
	[1] = {--OfficeTaskDiscoverMsg
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_TASK_DISCOVER = 7224

--[[
	[1] = {--OfficeShopPurchaseMsg
		[1] = 'int32':listId	[ 商品id]
		[2] = 'int32':num	[ 商品数量]
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_SHOP_PURCHASE = 7212

--[[
	[1] = {--GetElementReward
		[1] = 'int32':cgid
	}
--]]
c2s.ELEMENT_COLLECT_GET_ELEMENT_REWARD = 4867

--[[
	[1] = {--ReqHeroDispatchInfo
	}
--]]
c2s.HERO_DISPATCH_REQ_HERO_DISPATCH_INFO = 8601

--[[
	[1] = {--ReqWirteUnionReCall
		[1] = 'int32':unionId	[社团id]
	}
--]]
c2s.UNION_REQ_WIRTE_UNION_RE_CALL = 6674

--[[
	[1] = {--OfficeShopInfoMsg
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_SHOP_INFO = 7213

--[[
	[1] = {--ReqDoHandWork
		[1] = 'int32':manualId	[要制作手工id]
		[2] = 'int32':times
	}
--]]
c2s.NEW_BUILDING_REQ_DO_HAND_WORK = 2081

--[[
	[1] = {--ReqClueVote
		[1] = 'int32':id	[配置表id]
		[2] = 'int32':voteId	[投票项]
	}
--]]
c2s.DETECTIVE_REQ_CLUE_VOTE = 8910

--[[
	[1] = {--ReqAssistanceFlopRank
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_ASSISTANCE_FLOP_RANK = 5213

--[[
	[1] = {--ReqChristmasMapBox
		[1] = 'int32':location	[宝箱位置]
	}
--]]
c2s.CHRISTMAS_REQ_CHRISTMAS_MAP_BOX = 6609

--[[
	[1] = {--ReqAssistanceFlop
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':count	[翻牌次数]
	}
--]]
c2s.ACTIVITY_REQ_ASSISTANCE_FLOP = 5212

--[[
	[1] = {--ReqGetWarOrderAward
		[1] = 'int32':activityId	[ 活动id]
		[2] = 'int32':propId	[获得道具id]
	}
--]]
c2s.ACTIVITY_REQ_GET_WAR_ORDER_AWARD = 5146

--[[
	[1] = {--OfficeWorldMoveMsg
		[1] = 'int32':x	[ x位置]
		[2] = 'int32':y	[ y位置]
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_WORLD_MOVE = 7205

--[[
	[1] = {--ReqSendSpringWithTree
		[1] = 'string':context	[文本]
	}
--]]
c2s.ACTIVITY2_REQ_SEND_SPRING_WITH_TREE = 9412

--[[
	[1] = {--ReqNewSpiritInfo
	}
--]]
c2s.HERO_SPIRIT_REQ_NEW_SPIRIT_INFO = 8407

--[[
	[1] = {--ReqRemindSuccess
		[1] = 'int32':eventType	[提醒类型]
	}
--]]
c2s.NEW_BUILDING_REQ_REMIND_SUCCESS = 2073

--[[
	[1] = {--ReqManaEquip
		[1] = 'int32':id	[resonance表配置id]
		[2] = 'int32':pos	[位置,1-4    //位置,1-4]
	}
--]]
c2s.MANA_RESONANCE_REQ_MANA_EQUIP = 7602

--[[
	[1] = {--ReqGetExperiment
	}
--]]
c2s.DUNGEON_REQ_GET_EXPERIMENT = 1817

--[[
	[1] = {--ReqReceiveNewFavorAward
		[1] = 'int32':awardId	[精灵ID]
	}
--]]
c2s.DATING_REQ_RECEIVE_NEW_FAVOR_AWARD = 1580

--[[
	[1] = {--OfficeExploreTimeMsg
	}
--]]
c2s.OFFICE_EXPLORE_OFFICE_EXPLORE_TIME = 7101

--[[
	[1] = {--ReqExchangeApply
		[1] = 'int32':friendId	[好友id]
		[2] = 'int32':operType	[操作类型 1 请求 2 取消]
	}
--]]
c2s.ACTIVITY_REQ_EXCHANGE_APPLY = 5193

--[[
	[1] = {--ReqExplore
		[1] = 'int32':cityId	[城市id]
	}
--]]
c2s.BIRTH_DAY_REQ_EXPLORE = 8102

--[[
	[1] = {--ReqVerifyHurt
		[1] = 'int32':target	[ 1 人对怪 2 怪对人]
		[2] = 'int32':limitType	[限定类型,1:玩家英雄类型,2:限定英雄类型]
		[3] = 'int32':heroId	[ 精灵cid]
		[4] = 'int32':limitCid	[限定英雄id]
		[5] = 'int32':mosterId	[ 怪物id]
		[6] = 'int32':mosterLevel	[ 怪物等级]
		[7] = 'int32':hurtId	[ 技能id]
		[8] = 'int32':extraHurtType	[ 额外的伤害类型 1普通攻击 2格挡 3暴击 4穿透 5技能攻击]
		[9] = 'int32':hurt	[ 客户端伤害]
		[10] = 'bool':isWeakness	[ 是否触发弱点伤害]
		[11] = 'bool':isSuperArmor	[ 霸体减伤0.5]
		[12] = 'int32':hurtScale
		[13] = 'int32':attack
	}
--]]
c2s.DUNGEON_REQ_VERIFY_HURT = 1813

--[[
	[1] = {--LimitHeroDungeonMsg
		[1] = 'int32':levelId	[关卡cid]
	}
--]]
c2s.DUNGEON_LIMIT_HERO_DUNGEON = 1808

--[[
	[1] = {--ReqNewGetWarOrderAward
		[1] = 'int32':activityId	[ 活动id]
		[2] = 'int32':propId	[获得道具id]
	}
--]]
c2s.ACTIVITY2_REQ_NEW_GET_WAR_ORDER_AWARD = 9415

--[[
	[1] = {--GetBillboardNotice
	}
--]]
c2s.NOTICE_GET_BILLBOARD_NOTICE = 3585

--[[
	[1] = {--ReqChasmExitFight
	}
--]]
c2s.CHASM_REQ_CHASM_EXIT_FIGHT = 6147

--[[
	[1] = {--ReqReconnect
		[1] = 'string':token	[ 信息]
		[2] = 'int32':anti	[ 防沉迷状态: 1-认证已成年 2-认证未成年 3-未认证    // 防沉迷状态: 1-认证已成年 2-认证未成年 3-未认证]
	}
--]]
c2s.LOGIN_REQ_RECONNECT = 261

--[[
	[1] = {--NewReqYearActivityMonthItems
		[1] = 'int32':activityId	[ 活动id]
		[2] = 'string':extendData	[ 扩展数据]
	}
--]]
c2s.ACTIVITY_NEW_REQ_YEAR_ACTIVITY_MONTH_ITEMS = 5143

--[[
	[1] = {--ReqGetHangUpSEventAward
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':id	[特殊事件id]
	}
--]]
c2s.ACTIVITY_REQ_GET_HANG_UP_SEVENT_AWARD = 5171

--[[
	[1] = {--ReqSummon
	}
--]]
c2s.CHRISTMAS_REQ_SUMMON = 6604

--[[
	[1] = {--CabinAddHero
		[1] = 'int32':id	[舱室id]
		[2] = 'int32':heroId
		[3] = 'int32':index
	}
--]]
c2s.EXPLORE_CABIN_ADD_HERO = 7804

--[[
	[1] = {--NewSubmitActivity
		[1] = 'int32':activitId	[ 活动ID]
		[2] = 'int32':activitEntryId	[ 活动条目ID]
		[3] = 'string':extendData	[ 扩展数据]
	}
--]]
c2s.ACTIVITY_NEW_SUBMIT_ACTIVITY = 5125

--[[
	[1] = {--ReqDonateActivity
		[1] = 'int32':activityId	[ 活动ID]
		[2] = {--repeated Pair
			[1] = 'int32':key
			[2] = 'int32':value
		},
	}
--]]
c2s.ACTIVITY_REQ_DONATE_ACTIVITY = 5304

--[[
	[1] = {--ReqWorldOperate
		[1] = 'int32':operateType
		[2] = 'string':ext	[操作信息]
	}
--]]
c2s.NEW_WORLD_REQ_WORLD_OPERATE = 6820

--[[
	[1] = {--BuyLevelCountMsg
		[1] = 'int32':levelId	[关卡cid]
	}
--]]
c2s.DUNGEON_BUY_LEVEL_COUNT = 1811

--[[
	[1] = {--ReqSpeedLinkInfo
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_SPEED_LINK_INFO = 5149

--[[
	[1] = {--ReqMonthCardSign
	}
--]]
c2s.RECHARGE_REQ_MONTH_CARD_SIGN = 4366

--[[
	[1] = {--ReqChangeAntiAddiction
		[1] = 'int32':anti	[当前防沉迷状态]
	}
--]]
c2s.PLAYER_REQ_CHANGE_ANTI_ADDICTION = 284

--[[
	[1] = {--ExploreGetAward
		[1] = 'int32':activityId
	}
--]]
c2s.EXPLORE_EXPLORE_GET_AWARD = 7821

--[[
	[1] = {--Quit
		[1] = 'int32':teamId	[队伍id]
	}
--]]
c2s.DUNGEON_QUIT = 1806

--[[
	[1] = {--ReqGetUnionMorale
	}
--]]
c2s.JU_NAI_INVASION_REQ_GET_UNION_MORALE = 9104

--[[
	[1] = {--ReqHeroExploreMsg
		[1] = 'int32':id	[据点id]
		[2] = 'repeated int32':roleId
		[3] = {--repeated C2sSupportRole
			[1] = 'int64':playerId
			[2] = 'int32':roleId
		},
	}
--]]
c2s.HANGUP_ACT_REQ_HERO_EXPLORE = 9002

--[[
	[1] = {--ReqRemouldGem
		[1] = 'string':gemId	[ 宝石id]
		[2] = 'int32':specialAttr	[ 特殊属性]
	}
--]]
c2s.EQUIPMENT_REQ_REMOULD_GEM = 2836

--[[
	[1] = {--ReqSubmitUnionProps
		[1] = {--repeated Props
			[1] = 'int32':id
			[2] = 'int32':count
		},
	}
--]]
c2s.ANNIVERSARY2ND_REQ_SUBMIT_UNION_PROPS = 9232

--[[
	[1] = {--ReqRewardMissionRecord
	}
--]]
c2s.NEW_WORLD_REQ_REWARD_MISSION_RECORD = 6814

--[[
	[1] = {--ReqTestMsg
		[1] = 'int32':xx
	}
--]]
c2s.LOGIN_REQ_TEST = 274

--[[
	[1] = {--ReqUpHangUpRoleLevel
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':roleId	[挂机精灵id]
	}
--]]
c2s.ACTIVITY_REQ_UP_HANG_UP_ROLE_LEVEL = 5169

--[[
	[1] = {--ReqStartExploreMsg
		[1] = 'int32':id
	}
--]]
c2s.HANGUP_ACT_REQ_START_EXPLORE = 9003

--[[
	[1] = {--ReqMakeFormula
		[1] = {--repeated CatGoodExpItem
			[1] = 'int32':itemId	[道具id]
			[2] = 'int32':num	[道具数量]
		},
	}
--]]
c2s.ACTIVITY_REQ_MAKE_FORMULA = 5227

--[[
	[1] = {--Req2019ChristmasFactory
	}
--]]
c2s.CHRISTMAS_REQ2019_CHRISTMAS_FACTORY = 6614

--[[
	[1] = {--ReqHelpFightPlayers
	}
--]]
c2s.PLAYER_REQ_HELP_FIGHT_PLAYERS = 273

--[[
	[1] = {--ReqPositionChange
		[1] = 'int32':posX	[ 位置X]
		[2] = 'int32':posY	[ 位置Y]
		[3] = 'int32':dir	[ 角色朝向]
		[4] = 'int32':dt	[ 时间验证]
	}
--]]
c2s.NEW_WORLD_REQ_POSITION_CHANGE = 6809

--[[
	[1] = {--ReqEnterRewardMission
	}
--]]
c2s.NEW_WORLD_REQ_ENTER_REWARD_MISSION = 6815

--[[
	[1] = {--ReqAreaShowData
		[1] = 'int32':roomType	[房间类型]
	}
--]]
c2s.NEW_WORLD_REQ_AREA_SHOW_DATA = 6826

--[[
	[1] = {--ReqClickAdActivity
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':taskItemId	[条目id]
		[3] = 'int32':type	[1 自动打开 2 主动打开 3自动打开点模块 4 主动打开点模块]
	}
--]]
c2s.ACTIVITY_REQ_CLICK_AD_ACTIVITY = 5187

--[[
	[1] = {--ReqSimulateTrainInfo
	}
--]]
c2s.HERO_REQ_SIMULATE_TRAIN_INFO = 1046

--[[
	[1] = {--ReqActInfoMsg
	}
--]]
c2s.HANGUP_ACT_REQ_ACT_INFO = 9001

--[[
	[1] = {--ReqElementRank
	}
--]]
c2s.ELEMENT_COLLECT_REQ_ELEMENT_RANK = 4868

--[[
	[1] = {--ReqGetAllBuildingInfo
	}
--]]
c2s.NEW_BUILDING_REQ_GET_ALL_BUILDING_INFO = 2071

--[[
	[1] = {--ReqFetchGift
	}
--]]
c2s.APPRENTICE_REQ_FETCH_GIFT = 7905

--[[
	[1] = {--ReqWriteBeCallPlayerId
		[1] = 'int32':activityId	[活动id]
		[2] = 'string':uid	[验证码]
	}
--]]
c2s.ACTIVITY_REQ_WRITE_BE_CALL_PLAYER_ID = 5178

--[[
	[1] = {--GetTotalPayRewardInfo
	}
--]]
c2s.RECHARGE_GET_TOTAL_PAY_REWARD_INFO = 4361

--[[
	[1] = {--ReqSaveNewEquipPlan
		[1] = 'int32':heroId
		[2] = 'int32':index
		[3] = 'string':name
		[4] = {--repeated ReqNewEquipPlan
			[1] = 'int32':index
			[2] = 'string':equipId
		},
	}
--]]
c2s.EQUIPMENT_REQ_SAVE_NEW_EQUIP_PLAN = 2848

--[[
	[1] = {--ReqFormationBackupList
	}
--]]
c2s.PLAYER_REQ_FORMATION_BACKUP_LIST = 296

--[[
	[1] = {--ReqGiveUpJob
		[1] = 'int32':buildingId	[建筑ID]
		[2] = 'int32':jobId	[兼职id]
	}
--]]
c2s.NEW_BUILDING_REQ_GIVE_UP_JOB = 2079

--[[
	[1] = {--GetCommodityBuyLog
	}
--]]
c2s.STORE_GET_COMMODITY_BUY_LOG = 2564

--[[
	[1] = {--ReqExchange
		[1] = 'repeated string':choiseId	[选择的物品ID]
		[2] = 'int32':targetModelId	[ 要兑换的物品ModelId]
		[3] = 'int32':summid	[ 召唤id]
	}
--]]
c2s.SUMMON_REQ_EXCHANGE = 3338

--[[
	[1] = {--FightStartMsg
		[1] = 'int32':levelCid	[关卡cid]
		[2] = 'int32':helpPlayerId	[助战玩家id]
		[3] = 'int32':helpHeroCid	[助战英雄id]
		[4] = {--repeated LimitedHeroInfo
			[1] = 'int32':limitType	[限定类型,1:玩家英雄类型,2:限定英雄类型 3:模拟试炼限制]
			[2] = 'int32':limitCid	[限定英雄id]
		},
		[5] = 'int32':quickCount	[ 快速战斗次数]
		[6] = 'bool':isDuelMod	[ 决斗模式]
	}
--]]
c2s.DUNGEON_FIGHT_START = 1793

--[[
	[1] = {--ReqUnionWeekActivePrize
		[1] = 'int32':index	[ 领取索引]
	}
--]]
c2s.UNION_REQ_UNION_WEEK_ACTIVE_PRIZE = 6655

--[[
	[1] = {--ContinueDating
		[1] = 'int32':datingType	[约会类型]
		[2] = 'int32':datingRuleCid	[ 约会id]
	}
--]]
c2s.DATING_CONTINUE_DATING = 1552

--[[
	[1] = {--ReqNeptune2ndHalfChosenBuff
		[1] = 'int32':liftId	[层数id]
		[2] = 'int32':buffId	[buffid]
	}
--]]
c2s.NEPTUNE2ND_HALF_REQ_NEPTUNE2ND_HALF_CHOSEN_BUFF = 7705

--[[
	[1] = {--ReqNeptune2ndHalfInfo
	}
--]]
c2s.NEPTUNE2ND_HALF_REQ_NEPTUNE2ND_HALF_INFO = 7701

--[[
	[1] = {--ReqChallengeInfo
	}
--]]
c2s.DUNGEON_REQ_CHALLENGE_INFO = 1820

--[[
	[1] = {--ReqExploreTaskPlan
	}
--]]
c2s.EXPLORE_REQ_EXPLORE_TASK_PLAN = 7843

--[[
	[1] = {--ReqTimeContract
		[1] = 'int32':activityId	[活动id]
	}
--]]
c2s.ACTIVITY_REQ_TIME_CONTRACT = 5184

--[[
	[1] = {--ReqActivityPrayTask
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':taskItemId	[条目id]
	}
--]]
c2s.ACTIVITY_REQ_ACTIVITY_PRAY_TASK = 5180

--[[
	[1] = {--ReqUiChangeInfo
	}
--]]
c2s.MEDAL_REQ_UI_CHANGE_INFO = 3010

--[[
	[1] = {--ReqUpdateFinishProcess
		[1] = 'int32':id	[完成进度id]
		[2] = 'int32':chapterId	[章节id]
	}
--]]
c2s.ODEUM_REQ_UPDATE_FINISH_PROCESS = 6513

--[[
	[1] = {--ReqRecruitMaid
		[1] = 'int32':location	[招募的位置]
	}
--]]
c2s.MAID_ACTIVITY_REQ_RECRUIT_MAID = 9153

--[[
	[1] = {--ReqSetMaidNessId
		[1] = 'int32':maidId	[女仆id]
	}
--]]
c2s.ACTIVITY_REQ_SET_MAID_NESS_ID = 5219

--[[
	[1] = {--ReqChangeMaidWork
		[1] = 'int32':changeId	[需要改变的id 唯一id]
		[2] = 'int32':originalId	[要替换的 唯一id]
	}
--]]
c2s.MAID_ACTIVITY_REQ_CHANGE_MAID_WORK = 9151

--[[
	[1] = {--ReqChangeRoleId
		[1] = 'int32':roleId	[消耗类型]
	}
--]]
c2s.MAID_ACTIVITY_REQ_CHANGE_ROLE_ID = 9157

--[[
	[1] = {--ReqEnterChasm
	}
--]]
c2s.CHASM_REQ_ENTER_CHASM = 6149

--[[
	[1] = {--ReqNewGetWarOrderInfo
	}
--]]
c2s.ACTIVITY2_REQ_NEW_GET_WAR_ORDER_INFO = 9416

--[[
	[1] = {--ReqNewUWarOrderLevel
		[1] = 'int32':level	[升级到的等级]
	}
--]]
c2s.ACTIVITY2_REQ_NEW_UWAR_ORDER_LEVEL = 9417

--[[
	[1] = {--ReqOutsideActiveInfo
	}
--]]
c2s.EXTRA_DATING_REQ_OUTSIDE_ACTIVE_INFO = 5639

--[[
	[1] = {--ReqFeedMaid
		[1] = 'int32':maidId	[喂食的女仆唯一id]
		[2] = 'int32':itemId	[道具id]
		[3] = 'int32':num	[道具数量]
	}
--]]
c2s.MAID_ACTIVITY_REQ_FEED_MAID = 9152

--[[
	[1] = {--ReqAddGuideStep
		[1] = 'int32':stepId	[步骤id]
	}
--]]
c2s.EXPLORE_REQ_ADD_GUIDE_STEP = 7838

--[[
	[1] = {--GiftCode
		[1] = 'string':giftCode
	}
--]]
c2s.LOGIN_GIFT_CODE = 270

--[[
	[1] = {--UpgradeMsg
		[1] = 'string':equipmentId	[升级灵装id]
		[2] = 'repeated string':costEquipmentId	[消耗灵装id列表]
	}
--]]
c2s.EQUIPMENT_UPGRADE = 2820

--[[
	[1] = {--ReqAdvanceNewEquip
		[1] = 'string':newEquipId	[新装备id]
	}
--]]
c2s.EQUIPMENT_REQ_ADVANCE_NEW_EQUIP = 2832

--[[
	[1] = {--ReqFavorDatingAward
	}
--]]
c2s.EXTRA_DATING_REQ_FAVOR_DATING_AWARD = 5663

--[[
	[1] = {--ReqYearLottoInfo
	}
--]]
c2s.YEAR_LOTTO_REQ_YEAR_LOTTO_INFO = 8701

--[[
	[1] = {--ReqWishTreeInfo
	}
--]]
c2s.ANNIVERSARY2ND_REQ_WISH_TREE_INFO = 9230

--[[
	[1] = {--ReqEquipRemouldInfo
		[1] = 'string':equipmentId	[灵装id]
	}
--]]
c2s.EQUIPMENT_REQ_EQUIP_REMOULD_INFO = 2829

--[[
	[1] = {--ReqShareInfos
	}
--]]
c2s.SHARE_REQ_SHARE_INFOS = 6101

--[[
	[1] = {--ReqUnionLabourRank
	}
--]]
c2s.ACTIVITY_REQ_UNION_LABOUR_RANK = 5182

--[[
	[1] = {--ReqRefreshGashaponPool
	}
--]]
c2s.NEW_BUILDING_REQ_REFRESH_GASHAPON_POOL = 2065

--[[
	[1] = {--ReqLadderNewEquip
		[1] = 'int32':type	[1装备 2卸下]
		[2] = 'string':heroId	[英雄id]
		[3] = 'string':newEquipId	[新装备id]
		[4] = 'int32':index	[位置]
	}
--]]
c2s.LADDER_REQ_LADDER_NEW_EQUIP = 8307

--[[
	[1] = {--ReqLuckyWheel
		[1] = 'int32':times	[转的次数]
	}
--]]
c2s.SACRIFICE_REQ_LUCKY_WHEEL = 8002

--[[
	[1] = {--ReqUpQuality
		[1] = 'string':heroId
	}
--]]
c2s.HERO_REQ_UP_QUALITY = 1035

--[[
	[1] = {--ReqOpenWelfareInfo
		[1] = 'int32':type	[按钮类型 204 关注 205 更新内容 206 广告弹出网页]
	}
--]]
c2s.PLAYER_REQ_OPEN_WELFARE_INFO = 289

--[[
	[1] = {--MatchingTeamFriend
	}
--]]
c2s.DUNGEON_MATCHING_TEAM_FRIEND = 1805

--[[
	[1] = {--ReqGetAssemblyInfo
	}
--]]
c2s.ACTIVITY2_REQ_GET_ASSEMBLY_INFO = 9414

--[[
	[1] = {--ReqGetParadiseMsg
	}
--]]
c2s.ACTIVITY_REQ_GET_PARADISE = 5135

--[[
	[1] = {--Settings
		[1] = 'string':data	[数据]
	}
--]]
c2s.PLAYER_SETTINGS = 281

--[[
	[1] = {--GetItems
	}
--]]
c2s.ITEM_GET_ITEMS = 515

--[[
	[1] = {--ReqAITrigger
		[1] = 'int32':clientTime	[客户端时间]
		[2] = 'int32':roleId	[精灵ID]
	}
--]]
c2s.DATING_REQ_AITRIGGER = 1560

--[[
	[1] = {--ReqTakeRepairOutput
	}
--]]
c2s.ACTIVITY2_REQ_TAKE_REPAIR_OUTPUT = 9405

--[[
	[1] = {--ReqFormulaUpLevel
		[1] = 'int32':formulaId	[配方id]
		[2] = {--repeated CatGoodExpItem
			[1] = 'int32':itemId	[道具id]
			[2] = 'int32':num	[道具数量]
		},
	}
--]]
c2s.ACTIVITY_REQ_FORMULA_UP_LEVEL = 5217

--[[
	[1] = {--ReqEndlessRankList
	}
--]]
c2s.ENDLESS_CLOISTER_REQ_ENDLESS_RANK_LIST = 5380

--[[
	[1] = {--SubmitShare
		[1] = 'int32':id	[ ID]
	}
--]]
c2s.SHARE_SUBMIT_SHARE = 6102

--[[
	[1] = {--ReqResetQuit
		[1] = 'int32':chapterId
	}
--]]
c2s.DETECTIVE_REQ_RESET_QUIT = 8915

--[[
	[1] = {--ExploreTaskInfos
	}
--]]
c2s.EXPLORE_EXPLORE_TASK_INFOS = 7813

--[[
	[1] = {--ReqFriendHelpRewardAddress
		[1] = 'int32':entityId	[ 道具id]
	}
--]]
c2s.ACTIVITY_REQ_FRIEND_HELP_REWARD_ADDRESS = 5301

--[[
	[1] = {--ReqBulletInfo
		[1] = 'int32':barrageId
	}
--]]
c2s.CHAT_REQ_BULLET_INFO = 2317

--[[
	[1] = {--CabinRemoveHero
		[1] = 'int32':id	[舱室id]
		[2] = 'int32':index
	}
--]]
c2s.EXPLORE_CABIN_REMOVE_HERO = 7805

--[[
	[1] = {--ReqLadderEquipMsg
		[1] = 'string':heroId	[英雄id]
		[2] = 'string':equipmentId	[灵装id]
		[3] = 'int32':position	[位置]
	}
--]]
c2s.LADDER_REQ_LADDER_EQUIP = 8305

--[[
	[1] = {--ReqNewYearWelfareUrl
	}
--]]
c2s.ACTIVITY_REQ_NEW_YEAR_WELFARE_URL = 5134

--[[
	[1] = {--ReqAfkTasksDeal
		[1] = {--repeated ExploreTaskDeal
			[1] = 'int32':taskId
			[2] = 'repeated int32':heroId
		},
	}
--]]
c2s.EXPLORE_REQ_AFK_TASKS_DEAL = 7845

--[[
	[1] = {--ReqInvestorScoreInfo
	}
--]]
c2s.PLAYER_REQ_INVESTOR_SCORE_INFO = 295

--[[
	[1] = {--ReqPutSpiritPoints
		[1] = {--repeated SpiritPointsInfo
			[1] = 'int32':cid	[cid]
			[2] = 'int32':num	[数量]
		},
	}
--]]
c2s.HERO_SPIRIT_REQ_PUT_SPIRIT_POINTS = 8401

--[[
	[1] = {--ReqSpiritUseItem
		[1] = {--repeated SpiritItemInfo
			[1] = 'int32':cid	[cid]
			[2] = 'int32':num	[数量]
		},
	}
--]]
c2s.HERO_SPIRIT_REQ_SPIRIT_USE_ITEM = 8404

--[[
	[1] = {--ReqOdeumLevelInfo
	}
--]]
c2s.ODEUM_REQ_ODEUM_LEVEL_INFO = 6509

--[[
	[1] = {--ReqPushNextStage
		[1] = 'int32':activityId	[ 活动id]
	}
--]]
c2s.ACTIVITY_REQ_PUSH_NEXT_STAGE = 5142

--[[
	[1] = {--PracticeLevelInfo
	}
--]]
c2s.HERO_PRACTICE_PRACTICE_LEVEL_INFO = 6401

--[[
	[1] = {--ReqSingleComment
		[1] = 'int32':type	[装备:1,英雄:2]
		[2] = 'int32':itemId	[请求的对象(装备/英雄)id    //请求的对象(装备/英雄)id]
		[3] = 'string':comment	[评论]
	}
--]]
c2s.COMMENT_REQ_SINGLE_COMMENT = 4002

--[[
	[1] = {--ReqChangeRoom
		[1] = 'int32':roomId	[房间号  < 0 则随机,否则转到指定房间]
	}
--]]
c2s.CHAT_REQ_CHANGE_ROOM = 2307

--[[
	[1] = {--ReqFriendHelpInfo
	}
--]]
c2s.FRIEND_REQ_FRIEND_HELP_INFO = 3090

--[[
	[1] = {--ReqUpOrDownHangUpRole
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':roleId	[挂机精灵id]
		[3] = 'bool':up	[上阵还是下针 true 上阵]
		[4] = 'int32':eventId	[事件id]
	}
--]]
c2s.ACTIVITY_REQ_UP_OR_DOWN_HANG_UP_ROLE = 5175

--[[
	[1] = {--HeroUpgrade
		[1] = 'string':heroId
		[2] = {--repeated HeroExpItem
			[1] = 'int32':itemId
			[2] = 'int32':num
		},
	}
--]]
c2s.HERO_HERO_UPGRADE = 1027

--[[
	[1] = {--DialogueMsg
		[1] = 'int32':branchNodeId	[ 分支节点id]
		[2] = 'int32':selectedNodeId	[选择的节点id]
		[3] = 'bool':isLastNode	[是否结束节点]
		[4] = 'int32':datingType	[约会类型]
		[5] = 'int32':roleId	[精灵id]
		[6] = 'string':datingId	[ 约会唯一ID]
	}
--]]
c2s.DATING_DIALOGUE = 1538

--[[
	[1] = {--ReqDetectiveEvtFinish
		[1] = 'int32':chapterId	[周目id]
		[2] = 'int32':areaId	[区域]
		[3] = 'int32':evtId	[事件id]
	}
--]]
c2s.DETECTIVE_REQ_DETECTIVE_EVT_FINISH = 8902

--[[
	[1] = {--Req2019ChristmasProduct
	}
--]]
c2s.CHRISTMAS_REQ2019_CHRISTMAS_PRODUCT = 6617

--[[
	[1] = {--ReqChangeTrialHeroSkin
		[1] = 'string':heroId
		[2] = 'string':trialSkinId
	}
--]]
c2s.HERO_REQ_CHANGE_TRIAL_HERO_SKIN = 1045

--[[
	[1] = {--ReqResetDispatchHero
		[1] = 'int32':type	[1 日常副本, 2  精灵试炼, 3  雷霆圣堂, 4  联机作战, 5  日常约会]
		[2] = 'repeated int32':heroes	[请求上阵的精灵]
	}
--]]
c2s.HERO_DISPATCH_REQ_RESET_DISPATCH_HERO = 8608

--[[
	[1] = {--ReqReadSpringWish
		[1] = 'string':id	[寄语id]
	}
--]]
c2s.SPRING_WISH_REQ_READ_SPRING_WISH = 7502

--[[
	[1] = {--ReqUseNewEquipPlan
		[1] = 'int32':heroId
		[2] = 'int32':index
	}
--]]
c2s.EQUIPMENT_REQ_USE_NEW_EQUIP_PLAN = 2847

--[[
	[1] = {--RefreshBuffMsg
	}
--]]
c2s.HERO_CHALLENGE_REFRESH_BUFF = 6302

--[[
	[1] = {--ExploreEventAddTimes
		[1] = 'int32':activityId
		[2] = 'int32':nationId
		[3] = 'int32':cityId
		[4] = 'int32':eventId
	}
--]]
c2s.EXPLORE_EXPLORE_EVENT_ADD_TIMES = 7819

--[[
	[1] = {--ReqGetSupportAwardMsg
	}
--]]
c2s.HANGUP_ACT_REQ_GET_SUPPORT_AWARD = 9008

--[[
	[1] = {--ReqMaidNessInfo
	}
--]]
c2s.ACTIVITY_REQ_MAID_NESS_INFO = 5215

--[[
	[1] = {--ReqAwakeAngel
		[1] = 'string':heroId
	}
--]]
c2s.HERO_REQ_AWAKE_ANGEL = 1037

--[[
	[1] = {--ReqRankList
		[1] = 'int32':type	[排行榜类别  ---> S2CRankMsg.RankType]
	}
--]]
c2s.RANK_REQ_RANK_LIST = 7100

--[[
	[1] = {--Req2019ChristmasRefresh
	}
--]]
c2s.CHRISTMAS_REQ2019_CHRISTMAS_REFRESH = 6616

--[[
	[1] = {--WorldPointExploreloMsg
	}
--]]
c2s.QLIPHOTH_WORLD_POINT_EXPLORELO = 6217

--[[
	[1] = {--ReqGetEventChoices
		[1] = 'int32':datingType	[约会类型1 外传 2 主线]
		[2] = 'int32':datingValue	[当类型为外传时,值传外传ID,主线则为主线章节]
		[3] = 'int32':eventId	[事件id,剧本/信息]
		[4] = 'int32':choiceType	[ 选择项类型,1:剧本/2:信息]
	}
--]]
c2s.EXTRA_DATING_REQ_GET_EVENT_CHOICES = 5640

--[[
	[1] = {--ReqActivityRank
		[1] = 'int32':activityId	[ 活动ID]
	}
--]]
c2s.ACTIVITY_REQ_ACTIVITY_RANK = 5131

--[[
	[1] = {--ExploreGetInfos
	}
--]]
c2s.EXPLORE_EXPLORE_GET_INFOS = 7820

--[[
	[1] = {--ExploreEquipPutDown
		[1] = 'int32':cabinId	[舱室id]
		[2] = 'int32':index
	}
--]]
c2s.EXPLORE_EXPLORE_EQUIP_PUT_DOWN = 7809

--[[
	[1] = {--OperateFormationMsg
		[1] = 'int32':sourceHero	[源英雄id]
		[2] = 'int32':targetHero	[目标英雄id]
	}
--]]
c2s.QLIPHOTH_OPERATE_FORMATION = 6204

--[[
	[1] = {--ReqRedPacket
		[1] = 'int32':id	[ 红包id]
		[2] = 'int32':senderId	[ 发红包角色id]
		[3] = 'int64':createTime	[ 红包创建时间]
	}
--]]
c2s.UNION_REQ_RED_PACKET = 6661

--[[
	[1] = {--ReqTargetPlayerInfo
		[1] = 'int32':targetPid
	}
--]]
c2s.PLAYER_REQ_TARGET_PLAYER_INFO = 271

--[[
	[1] = {--GetComposePrize
		[1] = 'int32':id	[合成id]
	}
--]]
c2s.CHRISTMAS_GET_COMPOSE_PRIZE = 6603

--[[
	[1] = {--ReqHuntingDamageAward
	}
--]]
c2s.HUNTING_DUNGEON_REQ_HUNTING_DAMAGE_AWARD = 8510

--[[
	[1] = {--ReqServerTime
	}
--]]
c2s.LOGIN_REQ_SERVER_TIME = 268

--[[
	[1] = {--ReqTenBirthDayInfo
	}
--]]
c2s.BIRTH_DAY_REQ_TEN_BIRTH_DAY_INFO = 8101

--[[
	[1] = {--ExploreEventGetAward
		[1] = 'int32':activityId
		[2] = 'int32':nationId
		[3] = 'int32':cityId
		[4] = 'int32':eventId
		[5] = 'string':treasureId
	}
--]]
c2s.EXPLORE_EXPLORE_EVENT_GET_AWARD = 7817

--[[
	[1] = {--ReqUWarOrderLevel
		[1] = 'int32':level	[升级到的等级]
	}
--]]
c2s.ACTIVITY_REQ_UWAR_ORDER_LEVEL = 5148

return c2s