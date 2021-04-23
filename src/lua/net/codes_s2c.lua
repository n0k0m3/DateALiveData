local s2c = {}
--[[
	[1] = {--RespGetPlayerUnionReCallRank
		[1] = 'bool':open	[是否打开这个界面]
		[2] = 'int32':index	[返回当前的页数]
		[3] = 'int32':total	[返回总页数]
		[4] = {--repeated UnionPlayerReCallRank
			[1] = 'int32':playerId
			[2] = 'string':playerName
			[3] = 'int32':portraitCid	[头像框]
			[4] = 'int32':recallScore	[召回积分]
			[5] = 'int32':level	[玩家等级]
			[6] = 'int32':rank
			[7] = 'int32':portraitFrameCid	[ 玩家头像框CID]
		},
		[5] = 'int64':score	[返回总积分数]
		[6] = {--repeated UnionPlayerAwardInfo
			[1] = 'int32':awardScore	[社团积分]
			[2] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
	}
--]]
s2c.UNION_RESP_GET_PLAYER_UNION_RE_CALL_RANK = 6676

--[[
	[1] = {--GiftCodeRps
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.LOGIN_GIFT_CODE_RPS = 270

--[[
	[1] = {--RespGetWeekAward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.RECHARGE_RESP_GET_WEEK_AWARD = 4388

--[[
	[1] = {--AddSummonRecord
		[1] = 'repeated int32':records	[抽卡记录]
	}
--]]
s2c.CHRISTMAS_ADD_SUMMON_RECORD = 6606

--[[
	[1] = {--ResUnionRankActScore
		[1] = 'int32':activityId	[ 活动ID]
		[2] = {--repeated ActivityUnionRankMsg
			[1] = 'int32':rank	[ 排行]
			[2] = 'int32':score	[排行榜分数]
			[3] = 'int32':unionId	[社团ID(社团排行榜)    //社团ID(社团排行榜)]
			[4] = 'int32':unionIcon	[社团徽记]
			[5] = 'string':unionName	[社团名称]
			[6] = 'int32':unionLvl	[社团等级]
		},
		[3] = 'int32':myRank	[ 我的社团排名]
	}
--]]
s2c.ACTIVITY_RES_UNION_RANK_ACT_SCORE = 5305

--[[
	[1] = {--ResDetectiveExplore
		[1] = 'int32':evtId	[事件id]
	}
--]]
s2c.DETECTIVE_RES_DETECTIVE_EXPLORE = 8901

--[[
	[1] = {--RspYouciMsg
		[1] = 'int32':curPos	[本轮当前位置  0表示启点]
		[2] = 'int32':rounds	[总轮数(圈数)    //总轮数(圈数)]
		[3] = 'int32':rewardId	[本轮奖池ID]
		[4] = 'int64':nextRefreshTime	[下次系统刷新时间戳]
		[5] = 'repeated int32':posRewarded	[已领取了奖励的位置]
		[6] = {--repeated YouciRecordsMsg
			[1] = 'int64':time	[日期时间]
			[2] = 'int32':result	[投掷结果]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
	}
--]]
s2c.YOUCI_RSP_YOUCI = 9351

--[[
	[1] = {--Afk7808
	}
--]]
s2c.EXPLORE_AFK7808 = 7808

--[[
	[1] = {--ResFriendHelpInfo
		[1] = 'string':inviteCode
		[2] = {--repeated FriendHelpInfo
			[1] = 'int32':playerId
			[2] = 'string':playerName
			[3] = 'int32':portraitCid
			[4] = 'int32':portraitFrameCid
			[5] = 'int32':level
			[6] = {--repeated FriendHelpTaskInfo
				[1] = 'int32':taskId
				[2] = {--FriendHelpTaskStatus(enum)
					'v4':FriendHelpTaskStatus
				},
			},
		},
	}
--]]
s2c.FRIEND_RES_FRIEND_HELP_INFO = 3090

--[[
	[1] = {--ResHistoryRecord
		[1] = {--repeated HistoryRecord
			[1] = 'int32':type	[ 1 钻石召唤 2 友情召唤 3 指定召唤 4 精准质点 5 精准精灵]
			[2] = {--repeated Record
				[1] = 'int64':time
				[2] = 'int32':itemId
				[3] = 'int32':itemNum
			},
		},
	}
--]]
s2c.SUMMON_RES_HISTORY_RECORD = 3335

--[[
	[1] = {--RespGetExploreAward
		[1] = {--EventInfo
			[1] = 'int32':eventId	[事件id]
			[2] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
	}
--]]
s2c.BIRTH_DAY_RESP_GET_EXPLORE_AWARD = 8103

--[[
	[1] = {--RespAITriggerType
		[1] = 'bool':trigger	[是否触发   标识]
	}
--]]
s2c.DATING_RESP_AITRIGGER_TYPE = 1559

--[[
	[1] = {--ResAnnivMoveNext
	}
--]]
s2c.ANNIVERSARY2ND_RES_ANNIV_MOVE_NEXT = 9203

--[[
	[1] = {--RespRefreshMaidInfo
		[1] = {--MaidInfo
			[1] = 'int64':totle	[总的营业值]
			[2] = 'int32':customer	[揽客值]
			[3] = 'int32':cost	[消费]
			[4] = 'int32':turnOver	[每秒的营业值]
			[5] = 'repeated int32':attributes	[属性列表]
		},
		[2] = 'repeated int32':workLists	[工作列表]
	}
--]]
s2c.MAID_ACTIVITY_RESP_REFRESH_MAID_INFO = 9156

--[[
	[1] = {--ResUpgradeSkill
		[1] = 'string':heroId
		[2] = {--AngeSkillInfo
			[1] = 'int32':type
			[2] = 'int32':pos
			[3] = 'int32':lvl
		},
		[3] = 'int32':useSkillPiont	[ 已使用技能点]
	}
--]]
s2c.HERO_RES_UPGRADE_SKILL = 1038

--[[
	[1] = {--ResDeleteSpringWish
	}
--]]
s2c.SPRING_WISH_RES_DELETE_SPRING_WISH = 7504

--[[
	[1] = {--ResUseSkillStrategy
		[1] = 'string':heroId
		[2] = 'int32':skillStrategyId
	}
--]]
s2c.HERO_RES_USE_SKILL_STRATEGY = 1040

--[[
	[1] = {--RspSpiritRefresh
		[1] = {--HeroSpiritInfo
			[1] = 'int32':spiritPoints	[可用灵力点数]
			[2] = 'int32':grade	[品阶从0开始]
			[3] = 'int32':level	[级数从0开始]
			[4] = 'int64':exp	[经验值]
			[5] = {--repeated HeroSpiritProperty
				[1] = 'int32':cid	[cid]
				[2] = 'int32':num	[点数]
			},
			[6] = 'bool':firstShow	[首次开启展示true即为要显示false则不显示]
			[7] = 'bool':feedback	[旧灵力系统是否已返回资源]
			[8] = {--repeated HeroAngleSpirit
				[1] = 'int32':heroCid	[cid]
				[2] = 'int32':lv	[点数]
			},
			[9] = 'int32':maxLv	[可升级上限]
		},
	}
--]]
s2c.HERO_SPIRIT_RSP_SPIRIT_REFRESH = 8405

--[[
	[1] = {--UpdateLingboMsg
		[1] = 'int32':lingbo	[灵波值]
	}
--]]
s2c.ODEUM_UPDATE_LINGBO = 6507

--[[
	[1] = {--Afk7811
	}
--]]
s2c.EXPLORE_AFK7811 = 7811

--[[
	[1] = {--RespLeaveTeam
		[1] = 'int32':type	[ 1:主动退出 2:队长踢出 3队伍超时]
	}
--]]
s2c.TEAM_RESP_LEAVE_TEAM = 5893

--[[
	[1] = {--ResRiddleData
		[1] = 'int32':leftRiddleCount	[当日剩余灯谜数量]
		[2] = 'int32':leftRewardCount	[剩余可领奖次数]
		[3] = 'int32':rightCount	[当日答对数量]
		[4] = 'int32':id	[随机一个灯谜的配置id,传0就是今日没有灯谜了]
		[5] = 'int32':type	[1表示请求返回,2表示跨天推]
	}
--]]
s2c.ACTIVITY2_RES_RIDDLE_DATA = 9407

--[[
	[1] = {--RespJoinYearLotto
	}
--]]
s2c.YEAR_LOTTO_RESP_JOIN_YEAR_LOTTO = 8703

--[[
	[1] = {--ProgressMsg
		[1] = {--DungeonLevelGroupInfo
			[1] = 'string':id	[id]
			[2] = 'int32':cid	[cid]
			[3] = 'int32':fightCount	[战斗次数]
			[4] = 'int32':buyCount	[购买次数]
			[5] = {--repeated ListMap
				[1] = 'int32':key
				[2] = 'repeated int32':list
			},
			[6] = 'int32':mainLineCid	[当前关卡标记]
			[7] = 'int32':maxMainLine	[最大关卡进度]
		},
	}
--]]
s2c.DUNGEON_PROGRESS = 1795

--[[
	[1] = {--DestroyUnion
	}
--]]
s2c.UNION_DESTROY_UNION = 6665

--[[
	[1] = {--EquipMsg
		[1] = {--EquipmentInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[灵装id]
			[3] = 'int32':cid	[灵装cid]
			[4] = 'int32':level	[灵装等级]
			[5] = 'int32':exp	[灵装经验值]
			[6] = 'string':heroId	[英雄id]
			[7] = 'int32':position	[装备位置]
			[8] = {--repeated SpecialAttr
				[1] = 'int32':cid	[配置id]
				[2] = 'int32':value	[属性值]
				[3] = 'int32':index	[属性服务器顺序]
			},
			[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
			[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
			[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
			[12] = 'int32':outTime	[过期时间]
			[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
			[14] = 'int32':star	[额外星数]
			[15] = 'int32':stage	[阶段]
			[16] = 'int32':num	[数量]
			[17] = 'int32':step	[质点阶级]
		},
		[2] = {--EquipmentInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[灵装id]
			[3] = 'int32':cid	[灵装cid]
			[4] = 'int32':level	[灵装等级]
			[5] = 'int32':exp	[灵装经验值]
			[6] = 'string':heroId	[英雄id]
			[7] = 'int32':position	[装备位置]
			[8] = {--repeated SpecialAttr
				[1] = 'int32':cid	[配置id]
				[2] = 'int32':value	[属性值]
				[3] = 'int32':index	[属性服务器顺序]
			},
			[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
			[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
			[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
			[12] = 'int32':outTime	[过期时间]
			[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
			[14] = 'int32':star	[额外星数]
			[15] = 'int32':stage	[阶段]
			[16] = 'int32':num	[数量]
			[17] = 'int32':step	[质点阶级]
		},
	}
--]]
s2c.EQUIPMENT_EQUIP = 2817

--[[
	[1] = {--ResBlackWhiteRank
		[1] = {--repeated BwRank
			[1] = 'int32':rank	[排名,0则为未上榜]
			[2] = 'int32':costTime	[总用时]
			[3] = {--repeated BwRankPlayerInfo
				[1] = 'int32':pid	[玩家id]
				[2] = 'string':pName	[玩家名字]
				[3] = 'int32':level	[等级]
				[4] = 'int32':headId	[头像]
				[5] = 'int32':portraitFrameCid	[玩家头像框]
			},
		},
	}
--]]
s2c.NEW_WORLD_RES_BLACK_WHITE_RANK = 6817

--[[
	[1] = {--ResSetShapeMsg
		[1] = {--ShipAttr
			[1] = 'int32':shape	[飞机形态]
			[2] = {--repeated Attr
				[1] = 'int32':systemId	[0:全体系统,1:舱室升级(包含英雄上阵),2:形态天赋,3:武器培养,4:护甲培养,5:操作仓上阵, 6:宝物收集,7:配件上阵 ,8:飞舰皮肤    //0:全体系统,1:舱室升级(包含英雄上阵),2:形态天赋,3:武器培养,4:护甲培养,5:操作仓上阵, 6:宝物收集,7:配件上阵 ,8:飞舰皮肤]
				[2] = 'int32':fightPower
			},
		},
	}
--]]
s2c.EXPLORE_RES_SET_SHAPE = 7836

--[[
	[1] = {--RespSendSpecialEventAward
		[1] = 'int32':activityId	[活动id]
		[2] = {--repeated SpecialEventAward
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[奖励的id]
			[3] = 'int32':triggerId	[特殊事件的id]
		},
	}
--]]
s2c.ACTIVITY_RESP_SEND_SPECIAL_EVENT_AWARD = 5173

--[[
	[1] = {--RspLadderRankList
		[1] = {--repeated RspLadderRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':segment	[段位]
			[4] = 'int32':laderScore	[天梯分]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
			[8] = 'int32':battleScore	[区域作战分]
			[9] = 'int32':ladderAddtion	[天梯加减分]
		},
		[2] = {--RspLadderRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':segment	[段位]
			[4] = 'int32':laderScore	[天梯分]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
			[8] = 'int32':battleScore	[区域作战分]
			[9] = 'int32':ladderAddtion	[天梯加减分]
		},
		[3] = 'int32':refreshMinu	[刷新周期,分钟]
		[4] = {--repeated RspLadderRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':segment	[段位]
			[4] = 'int32':laderScore	[天梯分]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
			[8] = 'int32':battleScore	[区域作战分]
			[9] = 'int32':ladderAddtion	[天梯加减分]
		},
		[5] = {--RspLadderRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':segment	[段位]
			[4] = 'int32':laderScore	[天梯分]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
			[8] = 'int32':battleScore	[区域作战分]
			[9] = 'int32':ladderAddtion	[天梯加减分]
		},
		[6] = {--repeated RspLadderRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':segment	[段位]
			[4] = 'int32':laderScore	[天梯分]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
			[8] = 'int32':battleScore	[区域作战分]
			[9] = 'int32':ladderAddtion	[天梯加减分]
		},
		[7] = {--RspLadderRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':segment	[段位]
			[4] = 'int32':laderScore	[天梯分]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
			[8] = 'int32':battleScore	[区域作战分]
			[9] = 'int32':ladderAddtion	[天梯加减分]
		},
	}
--]]
s2c.LADDER_RSP_LADDER_RANK_LIST = 8302

--[[
	[1] = {--RespFestival2020Resource
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SPRING_FESTIVAL_RESP_FESTIVAL2020_RESOURCE = 6711

--[[
	[1] = {--LevelRecordMsg
		[1] = 'repeated int32':level	[当前关卡]
	}
--]]
s2c.ODEUM_LEVEL_RECORD = 6510

--[[
	[1] = {--RespServerTime
		[1] = 'int32':serverTime	[服务器时间]
	}
--]]
s2c.LOGIN_RESP_SERVER_TIME = 268

--[[
	[1] = {--StoreDataInfo
		[1] = {--repeated StoreInfo
			[1] = 'int32':storeId	[ 商店id]
			[2] = {--StoreInfomation
				[1] = 'string':icon	[icon]
				[2] = 'int32':name	[商店名称]
				[3] = 'int32':roleSet	[商店看板娘]
				[4] = 'repeated int32':showCurrency	[展示货币类型]
				[5] = 'bool':autoRefreshCorn	[自动刷新时间(分钟)    //自动刷新时间(分钟)]
				[6] = 'bool':manualRefresh	[是否可以手动刷新]
				[7] = 'int32':refreshCostId	[刷新消耗ID(货币id)    //刷新消耗ID(货币id)]
				[8] = 'repeated int32':refreshCostNum	[刷新消耗数量]
				[9] = 'int32':openContVal	[开启条件值]
				[10] = 'int32':openContType	[开启条件类型(1.玩家等级.2.需要通过的关卡,3社团等级,4七日狂欢开启,5七日狂欢结束,7大富翁开启)    //开启条件类型(1.玩家等级.2.需要通过的关卡,3社团等级,4七日狂欢开启,5七日狂欢结束,7大富翁开启)]
				[11] = 'int32':commoditySupplyType	[货源类型(1.固定类商城.2.随机商品商城)    //货源类型(1.固定类商城.2.随机商品商城)]
				[12] = 'int32':showBeginTime	[预开启时间]
				[13] = 'int32':buyBeginTime	[开始时间]
				[14] = 'int32':buyEndTime	[结束时间]
				[15] = 'int32':showEndTime	[预结束时间]
				[16] = 'int32':rank	[排序]
				[17] = 'int32':storeType	[商店类型]
				[18] = 'int32':openTimeType	[开启时间类型(1.任意时间.2.每日固定时刻.3.每周固定时刻.)    //开启时间类型(1.任意时间.2.每日固定时刻.3.每周固定时刻.)]
				[19] = 'string':extra	[额外信息]
			},
			[3] = {--repeated Commodity
				[1] = 'int32':id	[id]
				[2] = 'int32':grid	[id格子编号]
				[3] = 'int32':order	[排序]
				[4] = 'int32':openContType	[开启条件(1.玩家等级.2.需要达到的关卡.3社团等级,4特勤支援限时 5特勤支援常驻)    //开启条件(1.玩家等级.2.需要达到的关卡.3社团等级,4特勤支援限时 5特勤支援常驻)]
				[5] = 'int32':openContVal	[开启值]
				[6] = 'int32':buyBeginTime	[开始时间]
				[7] = 'int32':buyEndTime	[结束时间]
				[8] = 'int32':sellTimeType	[出售时间类型(1.任意时间.2.每日固定时刻.3.每周固定时刻.)    //出售时间类型(1.任意时间.2.每日固定时刻.3.每周固定时刻.)]
				[9] = 'int32':limitType	[限购(0.不限购.1.刷新时间内限购.2.服务器时间本天内限购.3.永久限购.5.全服限购且刷新时间重置.6.全服限购夸天重置.7.全服永久限购 8.本周限购 9.本月限购)    //限购(0.不限购.1.刷新时间内限购.2.服务器时间本天内限购.3.永久限购.5.全服限购且刷新时间重置.6.全服限购夸天重置.7.全服永久限购 8.本周限购 9.本月限购)]
				[10] = 'bool':batchBuy	[是否可以批量购买]
				[11] = 'int32':serLimit	[全服时个人限购值]
				[12] = 'int32':sellDescribtion	[限购描述]
				[13] = {--repeated GoodInfo
					[1] = 'int32':id	[道具id]
					[2] = 'int32':num	[道具数量]
				},
				[14] = 'repeated int32':priceType	[价格类型]
				[15] = 'repeated int32':priceVal	[ 价格数量]
				[16] = 'int32':des	[描述]
				[17] = 'int32':title	[标题]
				[18] = 'int32':tag	[折扣]
				[19] = 'bool':autoRefreshCorn	[自动刷新时间(分钟)    //自动刷新时间(分钟)]
				[20] = 'int32':showBeginTime	[预开启时间]
				[21] = 'int32':showEndTime	[预结束时间]
				[22] = 'int32':limitVal	[ 限购值]
				[23] = 'string':extra	[额外信息]
			},
			[4] = {--StoreRefresh
				[1] = 'int32':todayRefreshCount	[ 今天刷新次数]
				[2] = 'int32':totalRefreshCount	[ 总刷新次数]
				[3] = 'int32':nextRefreshTime	[ 下次自动刷新时间]
				[4] = 'int32':freeNum	[免费刷新次数]
			},
			[5] = 'string':pic	[侧边图(仅特勤商店用)    //侧边图(仅特勤商店用)]
			[6] = 'int32':groupRefreshTime	[分组下次刷新时间点(仅特勤商店用)    //分组下次刷新时间点(仅特勤商店用)]
		},
	}
--]]
s2c.STORE_STORE_DATA_INFO = 2569

--[[
	[1] = {--FavorDatingAward
		[1] = {--repeated ResFavorDatingPanel
			[1] = 'int32':roleId	[精灵Id]
			[2] = {--repeated FavorStatueInfo
				[1] = 'int32':favorId	[对应FavorDating表Id]
				[2] = 'int32':statue	[0未激活,1激活 2已领(奖励状态)    //0未激活,1激活 2已领(奖励状态)]
				[3] = 'int32':firstPass	[0还未通关过 1已经通关过]
				[4] = 'int32':energy	[消耗精力]
			},
		},
	}
--]]
s2c.EXTRA_DATING_FAVOR_DATING_AWARD = 5663

--[[
	[1] = {--RespBuyChasmCount
		[1] = {--ChasmInfo
			[1] = 'int32':id	[ 副本ID]
			[2] = 'int32':status	[ 状态		0:关闭 1:开启]
			[3] = 'int32':fightCount	[ 已挑战次数]
			[4] = 'int32':buyCount	[ 已购买次数]
			[5] = 'int32':remainCount	[ 剩余奖励次数]
			[6] = 'int32':awardStartTime	[ 特殊奖励开始时间]
			[7] = 'int32':awardEndTime	[ 特殊奖励结束时间]
			[8] = 'bool':isSpecial	[ 是否有特殊奖励]
			[9] = 'bool':finishOnce	[ 是否完成过]
		},
	}
--]]
s2c.CHASM_RESP_BUY_CHASM_COUNT = 6150

--[[
	[1] = {--RespRefreshEventList
		[1] = {--repeated MaidEventList
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[事件id]
			[3] = 'bool':reward	[是否领取奖励]
			[4] = 'int32':cfgId	[配置表id]
			[5] = 'int32':creatAt	[时间点]
			[6] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[7] = 'string':weather
		},
	}
--]]
s2c.MAID_ACTIVITY_RESP_REFRESH_EVENT_LIST = 9158

--[[
	[1] = {--ItemList
		[1] = {--repeated ItemInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int64':num	[ 数量]
			[5] = 'int32':outTime	[过期时间]
		},
		[2] = {--repeated EquipmentInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[灵装id]
			[3] = 'int32':cid	[灵装cid]
			[4] = 'int32':level	[灵装等级]
			[5] = 'int32':exp	[灵装经验值]
			[6] = 'string':heroId	[英雄id]
			[7] = 'int32':position	[装备位置]
			[8] = {--repeated SpecialAttr
				[1] = 'int32':cid	[配置id]
				[2] = 'int32':value	[属性值]
				[3] = 'int32':index	[属性服务器顺序]
			},
			[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
			[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
			[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
			[12] = 'int32':outTime	[过期时间]
			[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
			[14] = 'int32':star	[额外星数]
			[15] = 'int32':stage	[阶段]
			[16] = 'int32':num	[数量]
			[17] = 'int32':step	[质点阶级]
		},
		[3] = {--repeated DressInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'string':roleId	[ 装备精灵ID]
			[5] = 'int32':outTime	[过期时间]
		},
		[4] = {--repeated NewEquipmentInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[新装备id]
			[3] = 'int32':cid	[新装备cid]
			[4] = 'int32':stage	[新装备阶段等级]
			[5] = 'int32':level	[新装备等级]
			[6] = 'string':heroId	[英雄id]
			[7] = 'int32':position	[装备位置]
		},
		[5] = {--repeated GemInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[宝石id]
			[3] = 'int32':cid	[宝石cid]
			[4] = 'int32':heroId	[英雄id]
			[5] = 'repeated int32':randSkill	[随机技能]
			[6] = {--GemRandSkill
				[1] = 'int32':originalSkill	[ 原始id]
				[2] = 'int32':newSkill	[ 新id]
			},
		},
		[6] = {--repeated TreasureInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[宝物id]
			[3] = 'int32':cid	[宝物cid]
			[4] = 'int32':star	[宝物星级]
		},
		[7] = {--repeated ExploreEquip
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[探索装备id]
			[3] = 'int32':cid	[探索装备cid]
			[4] = 'int32':level	[探索装备星级]
		},
	}
--]]
s2c.ITEM_ITEM_LIST = 515

--[[
	[1] = {--ResEnterUnionRoom
		[1] = 'string':roomId	[ 战斗ID]
		[2] = 'string':fightServerHost	[ 战斗服务器地址]
		[3] = 'int32':fightServerPort	[ 战斗服务器端口]
		[4] = 'int32':roomType	[大世界类型]
	}
--]]
s2c.NEW_WORLD_RES_ENTER_UNION_ROOM = 6807

--[[
	[1] = {--RespGetWarOrderAward
		[1] = 'int32':activityid	[提交的活动ID]
		[2] = 'int32':propId	[提交的道具奖励id]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_RESP_GET_WAR_ORDER_AWARD = 5146

--[[
	[1] = {--ResActivityUnionItem
		[1] = 'int32':activityId	[ 活动ID]
		[2] = 'int64':num	[ 活动道具数量]
	}
--]]
s2c.ACTIVITY_RES_ACTIVITY_UNION_ITEM = 5306

--[[
	[1] = {--ResRefreshSpringFestivalTask
	}
--]]
s2c.SPRING_FESTIVAL_RES_REFRESH_SPRING_FESTIVAL_TASK = 6707

--[[
	[1] = {--ResSellGoodsPreview
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.STORE_RES_SELL_GOODS_PREVIEW = 2567

--[[
	[1] = {--ResRiddleOnce
		[1] = 'int32':answer	[玩家答案]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY2_RES_RIDDLE_ONCE = 9408

--[[
	[1] = {--RespAreaShowData
		[1] = {--AreaShowData
			[1] = 'int32':type
			[2] = 'int32':total
		},
	}
--]]
s2c.NEW_WORLD_RESP_AREA_SHOW_DATA = 6826

--[[
	[1] = {--RespSetNewEquipPlanName
	}
--]]
s2c.EQUIPMENT_RESP_SET_NEW_EQUIP_PLAN_NAME = 2846

--[[
	[1] = {--UpdateBlackWhiteDayTimes
		[1] = 'int32':dayTimes	[本日参与次数]
	}
--]]
s2c.NEW_WORLD_UPDATE_BLACK_WHITE_DAY_TIMES = 6819

--[[
	[1] = {--RespGetLinkAge
		[1] = {--repeated LinkAgeHero
			[1] = 'int32':heroId	[英雄id]
			[2] = 'int32':level	[伟业等级]
			[3] = 'int32':exp	[伟业经验值]
			[4] = 'int32':desire	[愿望]
			[5] = 'int32':index	[愿望]
			[6] = {--repeated AttributeLinkAge
				[1] = 'int32':attributeId
				[2] = 'int32':value
			},
		},
		[2] = 'repeated int32':additionHero	[加成列表]
	}
--]]
s2c.DUNGEON_RESP_GET_LINK_AGE = 1825

--[[
	[1] = {--RespResetDispatchHero
		[1] = {--repeated DispatchTypeHero
			[1] = 'int32':type	[1 日常副本, 2  精灵试炼, 3  雷霆圣堂, 4  联机作战, 5  日常约会]
			[2] = 'repeated int32':heroes	[请求派遣的精灵]
		},
	}
--]]
s2c.HERO_DISPATCH_RESP_RESET_DISPATCH_HERO = 8608

--[[
	[1] = {--ResSetSupportRoleMsg
		[1] = {--repeated SupportRole
			[1] = 'int64':playerId
			[2] = 'string':playerName
			[3] = 'int64':startTime
			[4] = 'int32':times
			[5] = {--Role
				[1] = 'int32':roleId
			},
			[6] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
		},
	}
--]]
s2c.HANGUP_ACT_RES_SET_SUPPORT_ROLE = 9006

--[[
	[1] = {--OpenRedPacket
		[1] = 'int32':id	[ 红包id]
		[2] = 'int32':senderId	[ 发红包角色id]
		[3] = 'int64':createTime	[ 红包创建时间]
		[4] = 'int32':moneyType	[ 抢到红包货币id]
		[5] = 'int32':moneyNum	[ 抢到红包数量]
	}
--]]
s2c.UNION_OPEN_RED_PACKET = 6660

--[[
	[1] = {--ChangeSpecialAttrMsg
		[1] = 'bool':success
		[2] = {--repeated RecycleItemInfo
			[1] = 'int32':id	[ id]
			[2] = 'int32':num	[ 数量]
		},
	}
--]]
s2c.EQUIPMENT_CHANGE_SPECIAL_ATTR = 2819

--[[
	[1] = {--RespChangeSwitch
		[1] = {--repeated Switch
			[1] = 'int32':type	[1 : 好友交易开关]
			[2] = 'int32':value
		},
	}
--]]
s2c.ACTIVITY_RESP_CHANGE_SWITCH = 5201

--[[
	[1] = {--RspUpgradeAngleSpirit
	}
--]]
s2c.HERO_SPIRIT_RSP_UPGRADE_ANGLE_SPIRIT = 8409

--[[
	[1] = {--RspLadderDungeonLevel
		[1] = {--LadderLevelInfo
			[1] = 'int32':battleScore	[作战积分]
			[2] = {--LevelInfo
				[1] = 'int32':cid	[关卡cid]
				[2] = 'repeated int32':goals	[达成目标的下标]
				[3] = 'int32':fightCount	[战斗次数]
				[4] = 'bool':win	[是否胜利]
				[5] = 'int32':buyCount	[购买次数]
				[6] = 'int32':freeCount	[ 周卡或者是月卡的免费次数]
			},
		},
		[2] = 'int32':battleScore	[区域作战分]
		[3] = 'int32':cardPoint	[卡牌点数]
	}
--]]
s2c.LADDER_RSP_LADDER_DUNGEON_LEVEL = 8314

--[[
	[1] = {--RespReceiveSysFunInfo
		[1] = {--repeated FundInfo
			[1] = 'int32':id	[配置id]
			[2] = 'int32':restDays	[剩余天数]
			[3] = 'bool':todayAward	[今天是否领取了奖励]
			[4] = {--ChangeType(enum)
				'v4':ChangeType
			},
		},
	}
--]]
s2c.RECHARGE_RESP_RECEIVE_SYS_FUN_INFO = 4374

--[[
	[1] = {--RespCatRecruit
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_RESP_CAT_RECRUIT = 5218

--[[
	[1] = {--RespAITrainingLike
	}
--]]
s2c.DATING_RESP_AITRAINING_LIKE = 1567

--[[
	[1] = {--ResAddGuideStep
	}
--]]
s2c.EXPLORE_RES_ADD_GUIDE_STEP = 7838

--[[
	[1] = {--ResDealFriendExchangeApply
	}
--]]
s2c.ACTIVITY_RES_DEAL_FRIEND_EXCHANGE_APPLY = 5195

--[[
	[1] = {--UpdateBossStatusMsg
		[1] = 'int32':status	[ 当前状态 0 关闭 1进行中 2 结算中]
	}
--]]
s2c.ODEUM_UPDATE_BOSS_STATUS = 6508

--[[
	[1] = {--RespDispatchHeroStar
		[1] = {--repeated HeroDispatchStar
			[1] = 'int32':hero
			[2] = 'int32':star
		},
	}
--]]
s2c.HERO_DISPATCH_RESP_DISPATCH_HERO_STAR = 8607

--[[
	[1] = {--UpdateActivityDungeon
		[1] = 'repeated int32':startIds	[活动开始副本组id]
		[2] = 'repeated int32':endIds	[活动结束副本组id]
	}
--]]
s2c.DUNGEON_UPDATE_ACTIVITY_DUNGEON = 1799

--[[
	[1] = {--ResChangeNewWorldRoom
		[1] = 'string':roomId	[ 战斗ID]
		[2] = 'string':fightServerHost	[ 战斗服务器地址]
		[3] = 'int32':fightServerPort	[ 战斗服务器端口]
		[4] = 'int32':roomType	[大世界类型]
	}
--]]
s2c.NEW_WORLD_RES_CHANGE_NEW_WORLD_ROOM = 6806

--[[
	[1] = {--ResEquipRecycleInfo
		[1] = 'string':equipmentId	[灵装id]
		[2] = {--repeated RecycleInfo
			[1] = 'int32':type	[ 回收类型]
			[2] = {--repeated RecycleItemInfo
				[1] = 'int32':id	[ id]
				[2] = 'int32':num	[ 数量]
			},
			[3] = {--repeated RecycleItemInfo
				[1] = 'int32':id	[ id]
				[2] = 'int32':num	[ 数量]
			},
		},
	}
--]]
s2c.EQUIPMENT_RES_EQUIP_RECYCLE_INFO = 2828

--[[
	[1] = {--RespUseBuff
	}
--]]
s2c.CHASM_RESP_USE_BUFF = 6153

--[[
	[1] = {--RespExpediteDispatch
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.HERO_DISPATCH_RESP_EXPEDITE_DISPATCH = 8609

--[[
	[1] = {--RespSevenCarnival
		[1] = 'int32':day	[天数]
		[2] = {--repeated SevenCarnivalStore
			[1] = 'int32':storeId	[购买的商品的id]
			[2] = 'int32':num	[购买的次数]
		},
		[3] = 'int32':state	[标示   1为新 0为老]
	}
--]]
s2c.SIGN_RESP_SEVEN_CARNIVAL = 5160

--[[
	[1] = {--UpdateSelectBalloonId
		[1] = 'int32':friendId	[好友id]
		[2] = {--repeated Pair
			[1] = 'int32':key
			[2] = 'int32':value
		},
		[3] = {--repeated Pair
			[1] = 'int32':key
			[2] = 'int32':value
		},
		[4] = 'bool':confirm	[我的确认状态]
		[5] = 'bool':friendConfirm	[好友的确认状态]
	}
--]]
s2c.ACTIVITY_UPDATE_SELECT_BALLOON_ID = 5197

--[[
	[1] = {--ResSearchPlayer
		[1] = {--repeated ApprenticeInfo
			[1] = 'int32':playerId	[ 玩家id]
			[2] = 'int32':portraitCId	[ 头像]
			[3] = 'string':name	[ 名字]
			[4] = 'int32':fightPower	[ 战力]
			[5] = 'int32':level	[ 等级]
			[6] = 'int64':lastLoginTime	[ 最后登录时间]
			[7] = 'bool':online	[ 是否在线]
			[8] = 'int32':portraitFrameCId	[ 头像框CID]
			[9] = 'bool':isFriend	[ 是否好友]
			[10] = 'bool':isUnion	[ 是否社团成员]
			[11] = 'bool':finished	[ 是否出师,徒弟列表需要的字段]
			[12] = 'int32':type	[ 1师父,2师门,3徒弟,4申请收徒,5申请拜师]
			[13] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[14] = 'int32':famousExp	[ 名师经验]
			[15] = 'bool':hasGift	[ 师父身上的该字段表示是否有礼物可领,true是的,只有师父会展示是否有礼物可领;徒弟身上的该字段表示是否可以赠送礼物,true可以赠送]
		},
		[2] = 'bool':success
	}
--]]
s2c.APPRENTICE_RES_SEARCH_PLAYER = 7907

--[[
	[1] = {--RespRemindSuccess
		[1] = 'bool':isSuccess	[是否成功]
		[2] = 'int32':eventType	[提醒类型]
	}
--]]
s2c.NEW_BUILDING_RESP_REMIND_SUCCESS = 2073

--[[
	[1] = {--ExploreEventStartBattle
		[1] = {--ExploreSysFight
			[1] = 'string':fid	[战报 ID]
			[2] = {--repeated ExploreReportMember
				[1] = 'int32':id	[id]
				[2] = 'string':name	[名字]
				[3] = 'int32':type	[成员类型]
				[4] = 'int32':hp	[血量]
				[5] = 'int32':shield	[护盾值]
			},
			[3] = 'int32':winner	[胜利者玩家id]
			[4] = 'string':version	[战报版本号]
			[5] = {--repeated ExploreReportEvent
				[1] = 'int32':event	[事件]
				[2] = 'repeated int32':intParams	[整型参数列表]
				[3] = 'repeated string':strParams	[字符参数列表,备用]
			},
		},
	}
--]]
s2c.EXPLORE_EXPLORE_EVENT_START_BATTLE = 7818

--[[
	[1] = {--RespAngelReset
	}
--]]
s2c.HERO_RESP_ANGEL_RESET = 1034

--[[
	[1] = {--ResWelfareInfo
		[1] = {--repeated ButtonShowInfo
			[1] = 'bool':openWelfare	[是否开启福利]
			[2] = 'string':welfareUrl	[福利地址]
			[3] = 'bool':isShowRed	[是否有红点]
			[4] = 'int32':type	[按钮类型]
		},
	}
--]]
s2c.PLAYER_RES_WELFARE_INFO = 288

--[[
	[1] = {--RespMaidNessInfo
		[1] = {--repeated CatInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[猫咪id]
			[3] = 'int32':level	[猫咪等级]
			[4] = 'int32':exp	[猫咪经验]
			[5] = 'int32':status	[猫咪状态]
			[6] = 'int32':taskId	[任务id]
			[7] = 'int32':creatAt	[获取时间]
		},
		[2] = {--repeated CatFormulaInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[配方id]
			[3] = 'int32':level	[配方等级]
			[4] = 'int32':exp	[配方经验]
			[5] = 'int32':creatAt	[获取时间]
			[6] = 'int32':num	[配方所增加的营业额度]
		},
		[3] = {--repeated MaidListInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[女仆id]
			[3] = 'int32':creatAt	[获取时间]
		},
		[4] = {--repeated CatTask
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[任务id]
			[3] = 'int32':stime	[开始时间]
			[4] = 'int32':etime	[结束时间]
		},
		[5] = {--repeated CatToy
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[玩具id]
			[3] = 'int32':etime	[结算时间]
		},
		[6] = 'int32':totalCat	[猫咪增加的营业额度]
		[7] = 'int32':totalNum	[每隔N分钟增加的总营业额度]
		[8] = 'int64':total	[所有的营业额度]
		[9] = 'int32':triggerTime	[营业额度增加的时间]
		[10] = 'int32':maidId	[看板id]
		[11] = 'int32':count	[刷新日常次数]
	}
--]]
s2c.ACTIVITY_RESP_MAID_NESS_INFO = 5215

--[[
	[1] = {--GetBillBoardNotice
		[1] = {--repeated BillBoardNotice
			[1] = 'int32':type	[公告类型(1-活动公告 2-游戏公告)    //公告类型(1-活动公告 2-游戏公告)]
			[2] = 'int32':index	[顺序]
			[3] = 'int32':tag	[标签(0-无 1-hot 2-new 3-限时)    //标签(0-无 1-hot 2-new 3-限时)]
			[4] = 'string':title	[标题]
			[5] = 'string':content	[内容]
			[6] = 'string':contextImg	[图片]
			[7] = 'string':param	[附加参数(json串格式)    //附加参数(json串格式)]
		},
	}
--]]
s2c.NOTICE_GET_BILL_BOARD_NOTICE = 3585

--[[
	[1] = {--RespVoteActivityInfo
		[1] = {--repeated VoteInfo
			[1] = 'int32':itemId	[条目id]
			[2] = 'int64':total	[当前多少票]
		},
	}
--]]
s2c.ACTIVITY_RESP_VOTE_ACTIVITY_INFO = 5190

--[[
	[1] = {--RespExploreActivityRank
		[1] = {--repeated ExploreActivityRank
			[1] = 'int32':playerId	[玩家id]
			[2] = 'string':playerName	[玩家名字]
			[3] = 'int32':playerLv	[玩家等级]
			[4] = 'int32':fightPower	[得分]
			[5] = 'int32':rank	[名次]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':headFrame	[头像框]
			[8] = 'int32':unionId	[社团id,0则没有社团]
			[9] = 'string':unionName	[社团名称]
		},
		[2] = {--ExploreActivityRank
			[1] = 'int32':playerId	[玩家id]
			[2] = 'string':playerName	[玩家名字]
			[3] = 'int32':playerLv	[玩家等级]
			[4] = 'int32':fightPower	[得分]
			[5] = 'int32':rank	[名次]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':headFrame	[头像框]
			[8] = 'int32':unionId	[社团id,0则没有社团]
			[9] = 'string':unionName	[社团名称]
		},
	}
--]]
s2c.ACTIVITY_RESP_EXPLORE_ACTIVITY_RANK = 5188

--[[
	[1] = {--RespTickGetUnionScore
		[1] = 'int64':score	[返回总积分数]
	}
--]]
s2c.UNION_RESP_TICK_GET_UNION_SCORE = 6677

--[[
	[1] = {--RecordClientErr
	}
--]]
s2c.PLAYER_RECORD_CLIENT_ERR = 279

--[[
	[1] = {--RespLoadProgress
		[1] = {--repeated LoadProgress
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'int32':progress	[进度]
		},
	}
--]]
s2c.FIGHT_RESP_LOAD_PROGRESS = 25612

--[[
	[1] = {--NotifyNetFrame
		[1] = {--NetFrame
			[1] = 'int32':index	[ 帧序]
			[2] = {--repeated OperateFrame
				[1] = 'int32':pid	[ 玩家ID]
				[2] = 'int32':keyCode	[ 按键键值 (摇杆.按键)    // 按键键值 (摇杆.按键)]
				[3] = 'int32':keyEvent	[ 按键状态  down/doing/up/摇杆角度]
				[4] = 'int32':keyEventEx	[按键状态扩展]
				[5] = 'int32':posX	[位置X]
				[6] = 'int32':posY	[位置Y]
				[7] = 'int32':dir	[角色朝向]
				[8] = 'int32':hp	[角色血量]
				[9] = 'int32':sp	[怒气]
			},
			[3] = {--repeated DataFrame
				[1] = 'int32':pid
				[2] = 'int32':action	[1:复活 2:离开]
			},
			[4] = {--repeated BossFrame
				[1] = 'int32':id	[Boss ID]
				[2] = 'int32':posX	[位置X]
				[3] = 'int32':posY	[位置Y]
				[4] = 'int32':dir	[角色朝向]
				[5] = 'int32':hp	[角色血量]
				[6] = 'int32':operate	[操作]
				[7] = 'int32':sp	[怒气]
			},
			[5] = {--repeated AIStepFrame
				[1] = 'int32':id	[Boss ID]
				[2] = 'int32':pid	[玩家id]
				[3] = 'int32':lastStep	[上一步AI]
				[4] = 'int32':curStep	[当前AI]
				[5] = 'int32':funcID	[执行方法ID]
				[6] = 'int32':param1	[参数1]
				[7] = 'int32':param2	[参数2]
				[8] = 'int32':param3	[参数3]
			},
		},
	}
--]]
s2c.FIGHT_NOTIFY_NET_FRAME = 25604

--[[
	[1] = {--HeroUpgradeResult
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.HERO_HERO_UPGRADE_RESULT = 1027

--[[
	[1] = {--ResTipInfo
		[1] = 'int32':status	[状态值:0-默认(无需确认) 1-确认后消失 2-确认后返回登录 3-确认后关闭游戏    //状态值:0-默认(无需确认) 1-确认后消失 2-确认后返回登录 3-确认后关闭游戏]
		[2] = 'string':content	[提示内容]
		[3] = 'int32':errCode
	}
--]]
s2c.PLAYER_RES_TIP_INFO = 282

--[[
	[1] = {--ExploreTaskGetAward
		[1] = {--AfkTask
			[1] = 'int32':id
			[2] = 'int32':state	[任务状态 0 未开始 1开始 2完成,3已领奖]
			[3] = 'repeated int32':heroId	[任务派遣的hero]
			[4] = 'int64':startTime	[任务开始执行的时间 0 就是还没有开始或者已经完成]
			[5] = 'int32':cabinId	[舱室id]
		},
		[2] = 'bool':bigAward
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EXPLORE_EXPLORE_TASK_GET_AWARD = 7812

--[[
	[1] = {--RespHuntingBossAward
		[1] = {--repeated HuntingBossAward
			[1] = 'int32':dungeon	[副本id]
			[2] = 'int32':status	[领取状态,1 未满足条件,2 可领取,3 已领取]
		},
		[2] = {--repeated HuntingBossAward
			[1] = 'int32':dungeon	[副本id]
			[2] = 'int32':status	[领取状态,1 未满足条件,2 可领取,3 已领取]
		},
		[3] = {--HuntingDamageAward
			[1] = 'int32':awardIndex	[奖励索引]
			[2] = 'int32':status	[领取状态,2 可领取,3 已领取]
		},
	}
--]]
s2c.HUNTING_DUNGEON_RESP_HUNTING_BOSS_AWARD = 8506

--[[
	[1] = {--SwitchRoleResult
		[1] = {--repeated RoleStatusInfo
			[1] = 'string':roleId
			[2] = 'int32':status
		},
	}
--]]
s2c.ROLE_SWITCH_ROLE_RESULT = 1285

--[[
	[1] = {--ResTakeRoseReward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = 'repeated string':takeList	[领过的进度奖]
	}
--]]
s2c.ACTIVITY2_RES_TAKE_ROSE_REWARD = 9411

--[[
	[1] = {--ResRewardMissionRecord
		[1] = {--repeated RewardMissionRecord
			[1] = 'int32':difficulty
			[2] = 'int32':count
		},
		[2] = {--repeated RewardMissionRecord
			[1] = 'int32':difficulty
			[2] = 'int32':count
		},
	}
--]]
s2c.NEW_WORLD_RES_REWARD_MISSION_RECORD = 6814

--[[
	[1] = {--ResSpeedJobNum
		[1] = 'int32':freeSpeedNum	[免费 当日已加速次数 月卡特权]
		[2] = 'int32':speedNum	[当日已加速次数]
	}
--]]
s2c.NEW_BUILDING_RES_SPEED_JOB_NUM = 2074

--[[
	[1] = {--NewRespYearActivityConfig
		[1] = {--repeated YearBirthConfig
			[1] = 'int32':id	[ 月份]
			[2] = 'int32':month	[ 月份]
			[3] = 'string':openTime	[真实开放时间]
			[4] = 'string':eventGroup	[事件集合]
			[5] = 'string':extendData	[额外信息]
		},
	}
--]]
s2c.ACTIVITY_NEW_RESP_YEAR_ACTIVITY_CONFIG = 5145

--[[
	[1] = {--EnterSuc
		[1] = 'int32':serverTime	[服务器时间]
		[2] = {--PlayerInfo
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':name	[ 玩家名称]
			[3] = 'int32':lvl	[ 玩家等级]
			[4] = 'int64':exp	[ 玩家经验]
			[5] = 'int32':vip_lvl	[ VIP等级]
			[6] = 'int64':vip_exp	[ VIP经验]
			[7] = {--Language(enum)
				'v4':Language
			},
			[8] = 'string':remark	[ 宣言]
			[9] = 'int32':helpFightHeroCid	[ 助战英雄ID]
			[10] = {--repeated PlayerAttr
				[1] = {--PlayerAttrKey(enum)
					'v4':PlayerAttrKey
				},
				[2] = 'int32':attrVal	[ 属性值]
			},
			[11] = 'bool':isFirstLogin	[是否初次登录]
			[12] = 'string':clientDiscreteData	[客户端离散数据]
			[13] = 'string':settings	[ 设置信息]
			[14] = 'repeated int32':recoverTimeList	[体力精力回复时间]
			[15] = 'int32':portraitCid	[ 玩家头像CID]
			[16] = 'int32':portraitFrameCid	[ 玩家头像框CID]
			[17] = {--GetAllElement
				[1] = {--repeated Elements
					[1] = 'int32':type	[类型]
					[2] = {--repeated Element
						[1] = 'int32':cid	[cid]
						[2] = 'int32':reward	[领奖状态 0不可领取  1可领取 2 已领取]
					},
					[3] = 'int32':trophy	[奖杯数]
					[4] = 'bool':scan	[是否可以浏览]
				},
				[2] = 'int32':rank	[排名]
				[3] = 'int32':totleTrophy	[总奖杯数]
			},
			[18] = 'int32':unionId	[ 玩家社团Id]
			[19] = 'string':unionName	[ 玩家社团名]
			[20] = 'int32':titleId	[ 称号id]
			[21] = 'int32':createTime	[ 建号时间]
			[22] = 'int32':famousExp	[ 名师经验]
		},
		[3] = 'int32':queue	[当前排队序号]
		[4] = 'int32':queueTime	[预计排队时间(分钟)    //预计排队时间(分钟)]
	}
--]]
s2c.LOGIN_ENTER_SUC = 257

--[[
	[1] = {--RespElementType
		[1] = {--repeated ElementType
			[1] = 'int32':elementType	[图鉴类型]
			[2] = 'int32':type	[类型   type=1 不展示  type=2 好友展示  type=3 全部可见]
		},
	}
--]]
s2c.ELEMENT_COLLECT_RESP_ELEMENT_TYPE = 4869

--[[
	[1] = {--ResSendRose
	}
--]]
s2c.ACTIVITY2_RES_SEND_ROSE = 9410

--[[
	[1] = {--ResqRankMsg
		[1] = 'int32':rankType	[榜单类型:0 全服榜,1好友榜]
		[2] = {--repeated ActivityRankMsg
			[1] = 'int32':rank	[ 排行]
			[2] = 'int32':playerId	[角色ID]
			[3] = 'string':playerName	[ 角色名]
			[4] = 'int32':score	[排行榜分数]
			[5] = 'int32':headIcon	[头像id]
			[6] = 'int32':helpFightHeroId	[助战id]
			[7] = 'int32':level	[等级]
			[8] = 'int32':frameCid	[头像框]
			[9] = 'int32':groupRank	[0:单人排名,1:组队排名]
			[10] = {--repeated RankPlayerInfo
				[1] = 'string':playerName	[ 角色名]
				[2] = 'int32':playerId	[角色ID]
				[3] = 'int32':level	[等级]
				[4] = 'int32':frameCid	[头像框]
				[5] = 'int32':headIcon	[头像id]
				[6] = 'int32':helpFightHeroId	[助战id]
				[7] = 'int32':heroId	[使用英雄id]
			},
		},
		[3] = 'int32':myRank	[ 我的排名]
		[4] = 'int32':myScore	[ 我的分数]
	}
--]]
s2c.ODEUM_RESQ_RANK = 6503

--[[
	[1] = {--ResActInfoMsg
		[1] = 'int64':supAwardTime	[获取支援奖励的时间]
		[2] = 'int64':supAwardTimes	[获取支援奖励的次数]
		[3] = 'int32':refreshTimes	[已经使用的刷新次数]
		[4] = 'int64':refreshTime	[上次刷新的时间]
		[5] = 'int32':completeStronghold	[完成的据点数量]
		[6] = 'int32':useSupTimes
		[7] = {--repeated Stronghold
			[1] = 'int32':id
			[2] = 'int32':state
			[3] = 'int64':startTime
			[4] = 'int64':endTime
			[5] = 'int32':useSupTimes
			[6] = 'int32':progress
			[7] = {--repeated Event
				[1] = 'int32':id
				[2] = 'int32':state
				[3] = 'int64':startTime
			},
			[8] = {--repeated Role
				[1] = 'int32':roleId
			},
			[9] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
			[10] = {--repeated SupportRole
				[1] = 'int64':playerId
				[2] = 'string':playerName
				[3] = 'int64':startTime
				[4] = 'int32':times
				[5] = {--Role
					[1] = 'int32':roleId
				},
				[6] = {--repeated Buff
					[1] = 'int32':buffId
					[2] = 'int32':buffLv
				},
			},
		},
		[8] = {--repeated SupportRole
			[1] = 'int64':playerId
			[2] = 'string':playerName
			[3] = 'int64':startTime
			[4] = 'int32':times
			[5] = {--Role
				[1] = 'int32':roleId
			},
			[6] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
		},
	}
--]]
s2c.HANGUP_ACT_RES_ACT_INFO = 9001

--[[
	[1] = {--RespActivityInnerData
		[1] = 'int32':actType	[活动类型]
		[2] = 'int32':actId	[活动id]
		[3] = 'string':jsonData	[数据]
	}
--]]
s2c.ACTIVITY_RESP_ACTIVITY_INNER_DATA = 5152

--[[
	[1] = {--ResRefreshGroupTeam
		[1] = {--GroupTeamInfo
			[1] = 'string':teamId	[队伍id]
			[2] = 'int32':createTime	[创建时间]
			[3] = 'int32':giftId	[礼包id]
			[4] = 'bool':isShow	[是否显示]
			[5] = 'bool':isComplete	[是否完成]
			[6] = 'bool':isDestroy	[是否销毁]
			[7] = {--repeated GroupTeamMember
				[1] = 'int32':playerId
				[2] = 'string':playerName
				[3] = 'int32':titleId
				[4] = 'int32':level
				[5] = 'bool':isCreator
				[6] = 'int32':portraitCid
				[7] = 'int32':portraitFrameId
			},
		},
	}
--]]
s2c.RECHARGE_RES_REFRESH_GROUP_TEAM = 4378

--[[
	[1] = {--ResUnlockPortrait
		[1] = 'int32':cid	[头像id]
		[2] = {--ChangeType(enum)
			'v4':ChangeType
		},
	}
--]]
s2c.PORTRAIL_RES_UNLOCK_PORTRAIT = 7004

--[[
	[1] = {--ResBackgroundInfo
		[1] = 'int32':dayBackground	[ 白天背景]
		[2] = 'int32':nightBackground	[夜晚背景]
		[3] = 'int32':dayBGM	[白天bgm]
		[4] = 'int32':nightBGM	[夜晚bgm]
	}
--]]
s2c.PLAYER_RES_BACKGROUND_INFO = 291

--[[
	[1] = {--ResAfkTasksDeal
	}
--]]
s2c.EXPLORE_RES_AFK_TASKS_DEAL = 7845

--[[
	[1] = {--RespSetLinkAgeHero
		[1] = {--LinkAgeHero
			[1] = 'int32':heroId	[英雄id]
			[2] = 'int32':level	[伟业等级]
			[3] = 'int32':exp	[伟业经验值]
			[4] = 'int32':desire	[愿望]
			[5] = 'int32':index	[愿望]
			[6] = {--repeated AttributeLinkAge
				[1] = 'int32':attributeId
				[2] = 'int32':value
			},
		},
	}
--]]
s2c.DUNGEON_RESP_SET_LINK_AGE_HERO = 1826

--[[
	[1] = {--QliphothItemsEventMsg
		[1] = 'int32':x	[ x位置]
		[2] = 'int32':y	[ y位置]
		[3] = {--ItemList
			[1] = {--repeated ItemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'int64':num	[ 数量]
				[5] = 'int32':outTime	[过期时间]
			},
			[2] = {--repeated EquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[灵装id]
				[3] = 'int32':cid	[灵装cid]
				[4] = 'int32':level	[灵装等级]
				[5] = 'int32':exp	[灵装经验值]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
				[8] = {--repeated SpecialAttr
					[1] = 'int32':cid	[配置id]
					[2] = 'int32':value	[属性值]
					[3] = 'int32':index	[属性服务器顺序]
				},
				[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
				[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
				[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
				[12] = 'int32':outTime	[过期时间]
				[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
				[14] = 'int32':star	[额外星数]
				[15] = 'int32':stage	[阶段]
				[16] = 'int32':num	[数量]
				[17] = 'int32':step	[质点阶级]
			},
			[3] = {--repeated DressInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'string':roleId	[ 装备精灵ID]
				[5] = 'int32':outTime	[过期时间]
			},
			[4] = {--repeated NewEquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[新装备id]
				[3] = 'int32':cid	[新装备cid]
				[4] = 'int32':stage	[新装备阶段等级]
				[5] = 'int32':level	[新装备等级]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
			},
			[5] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[6] = {--repeated TreasureInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝物id]
				[3] = 'int32':cid	[宝物cid]
				[4] = 'int32':star	[宝物星级]
			},
			[7] = {--repeated ExploreEquip
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[探索装备id]
				[3] = 'int32':cid	[探索装备cid]
				[4] = 'int32':level	[探索装备星级]
			},
		},
	}
--]]
s2c.QLIPHOTH_QLIPHOTH_ITEMS_EVENT = 6215

--[[
	[1] = {--RespTasks
		[1] = {--repeated TaskInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id
			[3] = 'int32':cid
			[4] = 'int32':progress	[当前进度]
			[5] = 'int32':status	[ 任务状态 0:进行中 1:可提交 2:已提交]
		},
	}
--]]
s2c.TASK_RESP_TASKS = 4097

--[[
	[1] = {--ResSubmitTaskMsg
		[1] = 'int32':taskId
		[2] = 'int32':goodId
		[3] = 'int32':count
	}
--]]
s2c.HANGUP_ACT_RES_SUBMIT_TASK = 9007

--[[
	[1] = {--AfkTask
		[1] = 'int32':id
		[2] = 'int32':state	[任务状态 0 未开始 1开始 2完成,3已领奖]
		[3] = 'repeated int32':heroId	[任务派遣的hero]
		[4] = 'int64':startTime	[任务开始执行的时间 0 就是还没有开始或者已经完成]
		[5] = 'int32':cabinId	[舱室id]
	}
--]]
s2c.EXPLORE_AFK_TASK = 7822

--[[
	[1] = {--OfficeTaskRewardMsg
		[1] = {--ItemList
			[1] = {--repeated ItemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'int64':num	[ 数量]
				[5] = 'int32':outTime	[过期时间]
			},
			[2] = {--repeated EquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[灵装id]
				[3] = 'int32':cid	[灵装cid]
				[4] = 'int32':level	[灵装等级]
				[5] = 'int32':exp	[灵装经验值]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
				[8] = {--repeated SpecialAttr
					[1] = 'int32':cid	[配置id]
					[2] = 'int32':value	[属性值]
					[3] = 'int32':index	[属性服务器顺序]
				},
				[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
				[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
				[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
				[12] = 'int32':outTime	[过期时间]
				[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
				[14] = 'int32':star	[额外星数]
				[15] = 'int32':stage	[阶段]
				[16] = 'int32':num	[数量]
				[17] = 'int32':step	[质点阶级]
			},
			[3] = {--repeated DressInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'string':roleId	[ 装备精灵ID]
				[5] = 'int32':outTime	[过期时间]
			},
			[4] = {--repeated NewEquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[新装备id]
				[3] = 'int32':cid	[新装备cid]
				[4] = 'int32':stage	[新装备阶段等级]
				[5] = 'int32':level	[新装备等级]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
			},
			[5] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[6] = {--repeated TreasureInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝物id]
				[3] = 'int32':cid	[宝物cid]
				[4] = 'int32':star	[宝物星级]
			},
			[7] = {--repeated ExploreEquip
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[探索装备id]
				[3] = 'int32':cid	[探索装备cid]
				[4] = 'int32':level	[探索装备星级]
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_TASK_REWARD = 7216

--[[
	[1] = {--RespUpHangUpRoleLevel
	}
--]]
s2c.ACTIVITY_RESP_UP_HANG_UP_ROLE_LEVEL = 5169

--[[
	[1] = {--RespShareComplete
	}
--]]
s2c.ACTIVITY_RESP_SHARE_COMPLETE = 5177

--[[
	[1] = {--ResGetReward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SPRING_WISH_RES_GET_REWARD = 7505

--[[
	[1] = {--ResRecomposeGem
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EQUIPMENT_RES_RECOMPOSE_GEM = 2839

--[[
	[1] = {--ResPamphletLevelUp
	}
--]]
s2c.SNOW_FESTIVAL_RES_PAMPHLET_LEVEL_UP = 9308

--[[
	[1] = {--RespSwitchList
		[1] = {--repeated Switch
			[1] = 'int32':type	[1 : 好友交易开关]
			[2] = 'int32':value
		},
	}
--]]
s2c.ACTIVITY_RESP_SWITCH_LIST = 5200

--[[
	[1] = {--ResNWSummonInfo
		[1] = {--repeated NWCombination
			[1] = 'int32':id
			[2] = 'bool':isActive
		},
	}
--]]
s2c.SUMMON_RES_NWSUMMON_INFO = 3341

--[[
	[1] = {--RechargeSuccess
		[1] = 'int32':cid
		[2] = 'int32':buyCount	[购买数量]
	}
--]]
s2c.RECHARGE_RECHARGE_SUCCESS = 4355

--[[
	[1] = {--RspLadderInfo
		[1] = {--LadderInfo
			[1] = 'int32':step	[活动阶段(0-准备期;1-进行期;2-结算期)    //活动阶段(0-准备期;1-进行期;2-结算期)]
			[2] = 'int32':historyBest	[历史最佳段位]
			[3] = 'int32':todayBest	[赛季最佳段位]
			[4] = 'int32':seasonBalance	[赛季结算的具体时刻(秒)    //赛季结算的具体时刻(秒)]
			[5] = 'int32':nextStepTime	[进入下阶段的具体时刻(秒)    //进入下阶段的具体时刻(秒)]
			[6] = {--RspLadderCycle
				[1] = 'int32':segment	[段位]
				[2] = 'int32':laderScore	[天梯分]
				[3] = 'int32':cardPoint	[卡牌点数]
				[4] = {--repeated RspBoundStuff
					[1] = 'string':itemId	[道具id,对应背包道具]
					[2] = 'int32':heroCid	[精灵cid]
				},
				[5] = {--repeated RspBoundStuff
					[1] = 'string':itemId	[道具id,对应背包道具]
					[2] = 'int32':heroCid	[精灵cid]
				},
				[6] = {--repeated HeroInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[ 实例ID]
					[3] = 'int32':cid	[ 配置ID]
					[4] = 'int32':lvl	[ 等级]
					[5] = 'int64':exp	[ 经验]
					[6] = {--repeated AttributeInfo
						[1] = 'int32':type	[ 属性类型]
						[2] = 'int32':val	[ 属性值]
					},
					[7] = 'int32':advancedLvl	[ 突破等级]
					[8] = {--repeated HeroEquipment
						[1] = 'int32':position	[装备位置]
						[2] = 'string':equipmentId	[装备id]
						[3] = {--EquipmentInfo
							[1] = {--ChangeType(enum)
								'v4':ChangeType
							},
							[2] = 'string':id	[灵装id]
							[3] = 'int32':cid	[灵装cid]
							[4] = 'int32':level	[灵装等级]
							[5] = 'int32':exp	[灵装经验值]
							[6] = 'string':heroId	[英雄id]
							[7] = 'int32':position	[装备位置]
							[8] = {--repeated SpecialAttr
								[1] = 'int32':cid	[配置id]
								[2] = 'int32':value	[属性值]
								[3] = 'int32':index	[属性服务器顺序]
							},
							[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
							[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
							[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
							[12] = 'int32':outTime	[过期时间]
							[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
							[14] = 'int32':star	[额外星数]
							[15] = 'int32':stage	[阶段]
							[16] = 'int32':num	[数量]
							[17] = 'int32':step	[质点阶级]
						},
					},
					[9] = 'bool':helpFight	[ 助战]
					[10] = 'int32':angelLvl	[ 天使等级]
					[11] = {--repeated AngeSkillInfo
						[1] = 'int32':type
						[2] = 'int32':pos
						[3] = 'int32':lvl
					},
					[12] = 'int32':useSkillPiont	[ 已使用技能点]
					[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
					[14] = 'int32':provide	[出处]
					[15] = 'int32':fightPower	[ 战斗力]
					[16] = 'int32':skinCid	[ 皮肤cid]
					[17] = {--repeated SkillStrategy
						[1] = 'int32':id
						[2] = 'string':name
						[3] = 'int32':alreadyUseSkillPiont
						[4] = {--repeated AngeSkillInfo
							[1] = 'int32':type
							[2] = 'int32':pos
							[3] = 'int32':lvl
						},
						[5] = {--repeated PassiveSkillInfo
							[1] = 'int32':pos
							[2] = 'int32':skillId
						},
					},
					[18] = 'int32':useSkillStrategy
					[19] = {--repeated CrystalInfo
						[1] = 'int32':rarity
						[2] = 'int32':gridId
					},
					[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
					[21] = {--repeated EuqipFetterInfo
						[1] = 'int32':index
						[2] = {--NewEquipmentInfo
							[1] = {--ChangeType(enum)
								'v4':ChangeType
							},
							[2] = 'string':id	[新装备id]
							[3] = 'int32':cid	[新装备cid]
							[4] = 'int32':stage	[新装备阶段等级]
							[5] = 'int32':level	[新装备等级]
							[6] = 'string':heroId	[英雄id]
							[7] = 'int32':position	[装备位置]
						},
					},
					[22] = {--HeroStatus(enum)
						'v4':HeroStatus
					},
					[23] = 'int32':deadLine
					[24] = {--repeated GemInfo
						[1] = {--ChangeType(enum)
							'v4':ChangeType
						},
						[2] = 'string':id	[宝石id]
						[3] = 'int32':cid	[宝石cid]
						[4] = 'int32':heroId	[英雄id]
						[5] = 'repeated int32':randSkill	[随机技能]
						[6] = {--GemRandSkill
							[1] = 'int32':originalSkill	[ 原始id]
							[2] = 'int32':newSkill	[ 新id]
						},
					},
					[25] = 'int32':skinCidTemp	[ 皮肤cid]
					[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
					[27] = 'int32':breakLv	[突破等级]
				},
				[7] = {--repeated RspUsingCount
					[1] = 'int32':itemCid	[道具cid]
					[2] = 'int32':count	[次数]
				},
				[8] = {--repeated RspUsingCount
					[1] = 'int32':itemCid	[道具cid]
					[2] = 'int32':count	[次数]
				},
				[9] = 'repeated int32':usingCards	[已使用的卡牌]
				[10] = {--repeated LadderLevelInfo
					[1] = 'int32':battleScore	[作战积分]
					[2] = {--LevelInfo
						[1] = 'int32':cid	[关卡cid]
						[2] = 'repeated int32':goals	[达成目标的下标]
						[3] = 'int32':fightCount	[战斗次数]
						[4] = 'bool':win	[是否胜利]
						[5] = 'int32':buyCount	[购买次数]
						[6] = 'int32':freeCount	[ 周卡或者是月卡的免费次数]
					},
				},
				[11] = 'int32':battleScore	[区域作战分]
				[12] = 'repeated int32':regionBuffs	[区域buff]
			},
			[7] = {--repeated LadderCardInfo
				[1] = 'int32':cardId	[卡牌id]
				[2] = 'int32':cardLv	[卡牌等级]
			},
			[8] = 'bool':showTips	[是否新周期提示]
			[9] = 'int32':clientSeason	[客户端展示赛季计数]
		},
	}
--]]
s2c.LADDER_RSP_LADDER_INFO = 8301

--[[
	[1] = {--OfficeHiddenEventsMsg
		[1] = {--repeated GridHiddenEventMsg
			[1] = 'int32':eventCid	[ 事件cid]
			[2] = 'repeated int64':progress	[ 进度]
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_HIDDEN_EVENTS = 7226

--[[
	[1] = {--ResFriendHelpRewardAddress
		[1] = 'int32':entityId	[提交的活动ID]
		[2] = 'string':address	[ 之前填的地址 可能为空]
	}
--]]
s2c.ACTIVITY_RES_FRIEND_HELP_REWARD_ADDRESS = 5301

--[[
	[1] = {--RespMainInfo
		[1] = {--DatingInfo
			[1] = 'int32':datingType	[约会类型1 外传 2 主线]
			[2] = 'int32':datingValue	[当类型为外传时,值传外传ID,主线则为主线章节]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'repeated int32':endings	[结局]
			[5] = 'int32':stepTime	[ 阶段时间]
			[6] = {--repeated EntranceInfo
				[1] = 'int32':entranceId	[入口id]
				[2] = 'bool':guide	[值]
			},
			[7] = {--repeated QualityInfo
				[1] = 'int32':qualityId	[对应DatingVariable表id]
				[2] = 'int32':value	[值]
			},
		},
	}
--]]
s2c.EXTRA_DATING_RESP_MAIN_INFO = 5633

--[[
	[1] = {--ResAdvanceNewEquip
		[1] = 'bool':isSuccess
	}
--]]
s2c.EQUIPMENT_RES_ADVANCE_NEW_EQUIP = 2832

--[[
	[1] = {--Equip
		[1] = 'string':id
		[2] = 'int32':cid
		[3] = 'int32':level
		[4] = 'int32':index	[镶嵌的位置,从1开始,如果为0,没有镶嵌]
		[5] = 'int32':cabinId	[舱室id]
	}
--]]
s2c.EXPLORE_EQUIP = 7807

--[[
	[1] = {--ResEquipRemouldInfo
		[1] = 'string':equipmentId	[灵装id]
		[2] = {--repeated AttrChange
			[1] = 'int32':index	[属性id]
			[2] = 'string':value	[变化值]
		},
	}
--]]
s2c.EQUIPMENT_RES_EQUIP_REMOULD_INFO = 2829

--[[
	[1] = {--RespGetHangUpSEventAward
		[1] = 'int32':activityId	[活动id]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_RESP_GET_HANG_UP_SEVENT_AWARD = 5171

--[[
	[1] = {--OfficeComplteEventsMsg
		[1] = {--OfficeComplteEvents
			[1] = 'int32':areaCid	[ 区域id]
			[2] = {--repeated OfficeComplteEvent
				[1] = 'int32':cid	[ 事件id]
				[2] = 'int32':num	[ 完成数量]
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_COMPLTE_EVENTS = 7106

--[[
	[1] = {--CellEvent
		[1] = 'int32':eventId	[事件id]
		[2] = 'bool':status	[事件是否完成(0未完成 1完成)    //事件是否完成(0未完成 1完成)]
	}
--]]
s2c.SACRIFICE_CELL_EVENT = 8004

--[[
	[1] = {--ResDetectiveVoteStatus
		[1] = {--repeated DetectiveDayVoteInfo
			[1] = 'int32':day	[天]
			[2] = 'int32':clueVote	[线索投票]
			[3] = 'int32':suspectVote	[嫌疑人投票]
		},
	}
--]]
s2c.DETECTIVE_RES_DETECTIVE_VOTE_STATUS = 8913

--[[
	[1] = {--MarqueeNotice
		[1] = 'string':content
	}
--]]
s2c.NOTICE_MARQUEE_NOTICE = 3586

--[[
	[1] = {--ResDetectiveChooseArea
		[1] = 'int32':currentAreaId	[区域id]
	}
--]]
s2c.DETECTIVE_RES_DETECTIVE_CHOOSE_AREA = 8903

--[[
	[1] = {--ShipAttr
		[1] = 'int32':shape	[飞机形态]
		[2] = {--repeated Attr
			[1] = 'int32':systemId	[0:全体系统,1:舱室升级(包含英雄上阵),2:形态天赋,3:武器培养,4:护甲培养,5:操作仓上阵, 6:宝物收集,7:配件上阵 ,8:飞舰皮肤    //0:全体系统,1:舱室升级(包含英雄上阵),2:形态天赋,3:武器培养,4:护甲培养,5:操作仓上阵, 6:宝物收集,7:配件上阵 ,8:飞舰皮肤]
			[2] = 'int32':fightPower
		},
	}
--]]
s2c.EXPLORE_SHIP_ATTR = 7837

--[[
	[1] = {--RespSendHangUpRoleInfo
		[1] = 'int32':activityId	[活动id]
		[2] = {--repeated HangUpRoleInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':roleId	[挂机精灵id]
			[3] = 'int32':level	[挂机精灵等级]
			[4] = 'int32':nextSettleTime	[挂机精灵的结算时间   0]
			[5] = 'int32':currentEventId	[挂机精灵现在的事件id]
			[6] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
	}
--]]
s2c.ACTIVITY_RESP_SEND_HANG_UP_ROLE_INFO = 5174

--[[
	[1] = {--ResqChasmFightRevive
		[1] = 'bool':isSuccess
	}
--]]
s2c.CHASM_RESQ_CHASM_FIGHT_REVIVE = 6146

--[[
	[1] = {--RespAssistanceInfo
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':round	[轮数]
		[3] = {--repeated AssistanceInfo
			[1] = 'int32':id	[配置id]
			[2] = 'bool':status	[翻牌状态]
		},
		[4] = 'int32':roundNum	[翻牌总层数记录]
	}
--]]
s2c.ACTIVITY_RESP_ASSISTANCE_INFO = 5211

--[[
	[1] = {--RepsSwitchFormation
	}
--]]
s2c.PLAYER_REPS_SWITCH_FORMATION = 272

--[[
	[1] = {--UpgradeMsg
		[1] = 'bool':success
	}
--]]
s2c.EQUIPMENT_UPGRADE = 2820

--[[
	[1] = {--RespNeptune2ndHalfInfo
		[1] = 'int32':stage	[阶段]
		[2] = 'int32':stageEnd	[阶段通用结束时间]
		[3] = {--repeated Neptune2ndHalfCity
			[1] = 'int32':id	[城市id]
			[2] = 'int32':dungeon	[当前关卡,如果为0则点位不可用]
			[3] = 'bool':resOpen	[是否解锁资源]
			[4] = 'int32':resCount	[资源可用次数]
			[5] = 'int32':resStartTime	[资源开始时间]
			[6] = 'int32':resUpTime	[下次资源增加时间]
			[7] = 'bool':replace	[是否替换关卡]
			[8] = 'int32':replaceEnd	[替换结束时间]
			[9] = 'int32':replaceGame	[替换的小游戏]
			[10] = 'bool':pass	[是否通关]
		},
		[4] = {--Neptune2ndHalfLift
			[1] = {--Neptune2ndHalfLiftBase
				[1] = 'int32':id	[城市id]
				[2] = 'int32':round	[爬塔轮次,0则未开启]
				[3] = 'int32':dungeon	[当前关卡]
				[4] = 'int32':startTime	[轮次开始时间]
				[5] = 'int32':endTime	[轮次结束时间]
				[6] = 'int32':roundScore	[轮次得分]
				[7] = 'int32':totalScore	[总得分]
				[8] = {--repeated Neptune2ndHalfIntTable
					[1] = 'int32':key	[键]
					[2] = 'int32':value	[值]
				},
				[9] = 'int32':bestTime	[最佳时间]
			},
			[2] = {--repeated Neptune2ndHalfIntTable
				[1] = 'int32':key	[键]
				[2] = 'int32':value	[值]
			},
			[3] = {--repeated Neptune2ndHalfIntTable
				[1] = 'int32':key	[键]
				[2] = 'int32':value	[值]
			},
			[4] = 'int32':battleCount	[初始最大战斗次数]
			[5] = {--repeated Neptune2ndHalfIntTable
				[1] = 'int32':key	[键]
				[2] = 'int32':value	[值]
			},
			[6] = 'repeated int32':roundBuff	[轮次主题buff]
			[7] = {--repeated Neptune2ndHalfChosenBuff
				[1] = 'int32':liftId	[层数id]
				[2] = 'repeated int32':buff	[待选择的buff]
			},
		},
		[5] = 'int32':map	[地图切换]
		[6] = 'int32':totalScore	[总得分,此处与爬塔轮次协议总分使用同一值,为了爬塔结束的显示]
	}
--]]
s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_INFO = 7701

--[[
	[1] = {--RespCrazyDiamondDraw
		[1] = 'int32':id	[活动id]
		[2] = {--repeated CrazyDiamondRankMsg
			[1] = 'int32':playerId	[角色ID]
			[2] = 'string':playerName	[ 角色名]
			[3] = 'int32':itemId	[获取道具id]
			[4] = 'int32':itemNum	[获取的道具数量]
		},
		[3] = {--repeated CrazyDiamondRankMsg
			[1] = 'int32':playerId	[角色ID]
			[2] = 'string':playerName	[ 角色名]
			[3] = 'int32':itemId	[获取道具id]
			[4] = 'int32':itemNum	[获取的道具数量]
		},
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[5] = 'int32':surplusDraw	[剩余抽奖次数]
		[6] = 'bool':isDraw	[ true: 表示为抽奖,false:表示为获取活动信息]
		[7] = 'int32':totalMoney	[活动期间充值金额(单位:美分)    //活动期间充值金额(单位:美分)]
	}
--]]
s2c.ACTIVITY_RESP_CRAZY_DIAMOND_DRAW = 5303

--[[
	[1] = {--RespUpOrDownHangUpRole
		[1] = 'bool':up	[上阵还是下针 true 上阵]
	}
--]]
s2c.ACTIVITY_RESP_UP_OR_DOWN_HANG_UP_ROLE = 5175

--[[
	[1] = {--RespOutsideActiveInfo
		[1] = 'repeated int32':activeOutsideIds	[可用的外传id]
		[2] = 'repeated int32':newOutsideIds	[新激活的外传id,用于界面显示如无需求不处理]
	}
--]]
s2c.EXTRA_DATING_RESP_OUTSIDE_ACTIVE_INFO = 5639

--[[
	[1] = {--RespUploadHandIntegral
	}
--]]
s2c.NEW_BUILDING_RESP_UPLOAD_HAND_INTEGRAL = 2082

--[[
	[1] = {--RefreshStore
		[1] = {--repeated StoreInfo
			[1] = 'int32':storeId	[ 商店id]
			[2] = {--StoreInfomation
				[1] = 'string':icon	[icon]
				[2] = 'int32':name	[商店名称]
				[3] = 'int32':roleSet	[商店看板娘]
				[4] = 'repeated int32':showCurrency	[展示货币类型]
				[5] = 'bool':autoRefreshCorn	[自动刷新时间(分钟)    //自动刷新时间(分钟)]
				[6] = 'bool':manualRefresh	[是否可以手动刷新]
				[7] = 'int32':refreshCostId	[刷新消耗ID(货币id)    //刷新消耗ID(货币id)]
				[8] = 'repeated int32':refreshCostNum	[刷新消耗数量]
				[9] = 'int32':openContVal	[开启条件值]
				[10] = 'int32':openContType	[开启条件类型(1.玩家等级.2.需要通过的关卡,3社团等级,4七日狂欢开启,5七日狂欢结束,7大富翁开启)    //开启条件类型(1.玩家等级.2.需要通过的关卡,3社团等级,4七日狂欢开启,5七日狂欢结束,7大富翁开启)]
				[11] = 'int32':commoditySupplyType	[货源类型(1.固定类商城.2.随机商品商城)    //货源类型(1.固定类商城.2.随机商品商城)]
				[12] = 'int32':showBeginTime	[预开启时间]
				[13] = 'int32':buyBeginTime	[开始时间]
				[14] = 'int32':buyEndTime	[结束时间]
				[15] = 'int32':showEndTime	[预结束时间]
				[16] = 'int32':rank	[排序]
				[17] = 'int32':storeType	[商店类型]
				[18] = 'int32':openTimeType	[开启时间类型(1.任意时间.2.每日固定时刻.3.每周固定时刻.)    //开启时间类型(1.任意时间.2.每日固定时刻.3.每周固定时刻.)]
				[19] = 'string':extra	[额外信息]
			},
			[3] = {--repeated Commodity
				[1] = 'int32':id	[id]
				[2] = 'int32':grid	[id格子编号]
				[3] = 'int32':order	[排序]
				[4] = 'int32':openContType	[开启条件(1.玩家等级.2.需要达到的关卡.3社团等级,4特勤支援限时 5特勤支援常驻)    //开启条件(1.玩家等级.2.需要达到的关卡.3社团等级,4特勤支援限时 5特勤支援常驻)]
				[5] = 'int32':openContVal	[开启值]
				[6] = 'int32':buyBeginTime	[开始时间]
				[7] = 'int32':buyEndTime	[结束时间]
				[8] = 'int32':sellTimeType	[出售时间类型(1.任意时间.2.每日固定时刻.3.每周固定时刻.)    //出售时间类型(1.任意时间.2.每日固定时刻.3.每周固定时刻.)]
				[9] = 'int32':limitType	[限购(0.不限购.1.刷新时间内限购.2.服务器时间本天内限购.3.永久限购.5.全服限购且刷新时间重置.6.全服限购夸天重置.7.全服永久限购 8.本周限购 9.本月限购)    //限购(0.不限购.1.刷新时间内限购.2.服务器时间本天内限购.3.永久限购.5.全服限购且刷新时间重置.6.全服限购夸天重置.7.全服永久限购 8.本周限购 9.本月限购)]
				[10] = 'bool':batchBuy	[是否可以批量购买]
				[11] = 'int32':serLimit	[全服时个人限购值]
				[12] = 'int32':sellDescribtion	[限购描述]
				[13] = {--repeated GoodInfo
					[1] = 'int32':id	[道具id]
					[2] = 'int32':num	[道具数量]
				},
				[14] = 'repeated int32':priceType	[价格类型]
				[15] = 'repeated int32':priceVal	[ 价格数量]
				[16] = 'int32':des	[描述]
				[17] = 'int32':title	[标题]
				[18] = 'int32':tag	[折扣]
				[19] = 'bool':autoRefreshCorn	[自动刷新时间(分钟)    //自动刷新时间(分钟)]
				[20] = 'int32':showBeginTime	[预开启时间]
				[21] = 'int32':showEndTime	[预结束时间]
				[22] = 'int32':limitVal	[ 限购值]
				[23] = 'string':extra	[额外信息]
			},
			[4] = {--StoreRefresh
				[1] = 'int32':todayRefreshCount	[ 今天刷新次数]
				[2] = 'int32':totalRefreshCount	[ 总刷新次数]
				[3] = 'int32':nextRefreshTime	[ 下次自动刷新时间]
				[4] = 'int32':freeNum	[免费刷新次数]
			},
			[5] = 'string':pic	[侧边图(仅特勤商店用)    //侧边图(仅特勤商店用)]
			[6] = 'int32':groupRefreshTime	[分组下次刷新时间点(仅特勤商店用)    //分组下次刷新时间点(仅特勤商店用)]
		},
	}
--]]
s2c.STORE_REFRESH_STORE = 2563

--[[
	[1] = {--ResAnnivPassReward
	}
--]]
s2c.ANNIVERSARY2ND_RES_ANNIV_PASS_REWARD = 9204

--[[
	[1] = {--RespGetHandWorkAward
		[1] = 'int32':manualId
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.NEW_BUILDING_RESP_GET_HAND_WORK_AWARD = 2083

--[[
	[1] = {--SearchUnion
		[1] = {--UnionSnapInfo
			[1] = 'int32':id
			[2] = 'string':name
			[3] = 'int32':level	[等级]
			[4] = 'int32':icon	[徽记]
			[5] = 'int32':memberCount	[成员数量]
			[6] = 'int32':memberCountMax	[人数上限]
			[7] = 'int32':active	[活跃度]
			[8] = 'int32':limitLevel	[加入需求等级]
			[9] = 'int32':limitPower	[加入需求战力]
			[10] = 'bool':apply	[申请状态]
			[11] = 'bool':canApply	[是否可以申请加入]
			[12] = 'string':leaderName	[团长名]
			[13] = 'string':notice	[社团公告]
			[14] = 'int32':country	[国家ID]
			[15] = 'bool':showCountry	[是否显示国家]
		},
	}
--]]
s2c.UNION_SEARCH_UNION = 6664

--[[
	[1] = {--RspStartStage
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = 'bool':nonstop	[是否跳层直通]
	}
--]]
s2c.ENDLESS_CLOISTER_RSP_START_STAGE = 5383

--[[
	[1] = {--ResOpenWelfareInfo
		[1] = {--repeated ButtonShowInfo
			[1] = 'bool':openWelfare	[是否开启福利]
			[2] = 'string':welfareUrl	[福利地址]
			[3] = 'bool':isShowRed	[是否有红点]
			[4] = 'int32':type	[按钮类型]
		},
	}
--]]
s2c.PLAYER_RES_OPEN_WELFARE_INFO = 289

--[[
	[1] = {--HeroCompose
		[1] = 'bool':success
	}
--]]
s2c.HERO_HERO_COMPOSE = 1031

--[[
	[1] = {--RespChangeElementType
	}
--]]
s2c.ELEMENT_COLLECT_RESP_CHANGE_ELEMENT_TYPE = 4870

--[[
	[1] = {--RspLadderHeroList
		[1] = {--repeated HeroInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int64':exp	[ 经验]
			[6] = {--repeated AttributeInfo
				[1] = 'int32':type	[ 属性类型]
				[2] = 'int32':val	[ 属性值]
			},
			[7] = 'int32':advancedLvl	[ 突破等级]
			[8] = {--repeated HeroEquipment
				[1] = 'int32':position	[装备位置]
				[2] = 'string':equipmentId	[装备id]
				[3] = {--EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
			},
			[9] = 'bool':helpFight	[ 助战]
			[10] = 'int32':angelLvl	[ 天使等级]
			[11] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[12] = 'int32':useSkillPiont	[ 已使用技能点]
			[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
			[14] = 'int32':provide	[出处]
			[15] = 'int32':fightPower	[ 战斗力]
			[16] = 'int32':skinCid	[ 皮肤cid]
			[17] = {--repeated SkillStrategy
				[1] = 'int32':id
				[2] = 'string':name
				[3] = 'int32':alreadyUseSkillPiont
				[4] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[5] = {--repeated PassiveSkillInfo
					[1] = 'int32':pos
					[2] = 'int32':skillId
				},
			},
			[18] = 'int32':useSkillStrategy
			[19] = {--repeated CrystalInfo
				[1] = 'int32':rarity
				[2] = 'int32':gridId
			},
			[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
			[21] = {--repeated EuqipFetterInfo
				[1] = 'int32':index
				[2] = {--NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
			},
			[22] = {--HeroStatus(enum)
				'v4':HeroStatus
			},
			[23] = 'int32':deadLine
			[24] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[25] = 'int32':skinCidTemp	[ 皮肤cid]
			[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
			[27] = 'int32':breakLv	[突破等级]
		},
	}
--]]
s2c.LADDER_RSP_LADDER_HERO_LIST = 8304

--[[
	[1] = {--ResUseFireworks
		[1] = 'int32':fireworkId	[ 使用烟花的id]
		[2] = 'int32':randomSeed	[ 随机种子]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SPRING_FESTIVAL_RES_USE_FIREWORKS = 6705

--[[
	[1] = {--ResAwakeAngel
		[1] = 'string':heroId
		[2] = 'int32':angelLvl
	}
--]]
s2c.HERO_RES_AWAKE_ANGEL = 1037

--[[
	[1] = {--NewRespActivityItems
		[1] = {--repeated ActivityItemMsg
			[1] = 'int32':id	[条目ID]
			[2] = 'int32':type	[活动类型]
			[3] = 'string':name	[标题]
			[4] = 'string':details	[条目描述]
			[5] = 'string':target	[条目目标]
			[6] = 'string':reward	[条目奖励]
			[7] = 'string':extendData	[扩展数据]
			[8] = 'int32':rank	[排序]
			[9] = 'int32':subType	[条目子类型]
		},
	}
--]]
s2c.ACTIVITY_NEW_RESP_ACTIVITY_ITEMS = 5127

--[[
	[1] = {--RespFlopSpeedLink
		[1] = {--SpeedLink
			[1] = 'int32':location	[位置]
			[2] = 'int32':id
		},
		[2] = 'repeated int32':remove	[位置]
	}
--]]
s2c.ACTIVITY_RESP_FLOP_SPEED_LINK = 5151

--[[
	[1] = {--RespGetParadiseMsg
		[1] = {--ChangeType(enum)
			'v4':ChangeType
		},
		[2] = {--repeated ParadiseDraw
			[1] = 'int32':drawId	[卡池id]
			[2] = {--repeated DrawRecord
				[1] = 'int32':itemId	[道具id]
				[2] = 'int32':num	[道具数量]
			},
		},
		[3] = 'repeated int32':drawId	[开放的卡池列表]
		[4] = {--repeated ParadiseDating
			[1] = 'int32':type	[游戏类型]
			[2] = 'int32':winNum	[赢的次数]
			[3] = 'int32':loseNum	[输的次数]
		},
	}
--]]
s2c.ACTIVITY_RESP_GET_PARADISE = 5135

--[[
	[1] = {--ExploreTreasureEquipMsg
		[1] = 'string':id	[ 宝物uid]
		[2] = 'int32':index	[ 装备位索引]
	}
--]]
s2c.EXPLORE_EXPLORE_TREASURE_EQUIP = 7832

--[[
	[1] = {--RespAITrainingAudit
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'int32':type	[类型- 0 审核中 1 审核通过 2 审核失败    //类型- 0 审核中 1 审核通过 2 审核失败]
		[3] = 'string':jsonList	[json列表数据]
		[4] = 'int32':page	[页数]
		[5] = 'int32':totlaPage	[总页数]
	}
--]]
s2c.DATING_RESP_AITRAINING_AUDIT = 1568

--[[
	[1] = {--RespChristmasMapBox
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--repeated ChristmasMapBoxes
			[1] = 'int32':location	[位置信息]
			[2] = 'int32':eventCid	[事件信息]
		},
	}
--]]
s2c.CHRISTMAS_RESP_CHRISTMAS_MAP_BOX = 6609

--[[
	[1] = {--RspChooseItem
		[1] = 'int32':index	[索引]
		[2] = {--RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ZILLIONAIRE_RSP_CHOOSE_ITEM = 5222

--[[
	[1] = {--RespFlopGameInfo
		[1] = {--repeated CardInfo
			[1] = 'int32':pos	[位置]
			[2] = 'int32':id	[配置id,翻开的牌会传id,没有翻开的牌没有这个字段]
		},
		[2] = 'repeated int32':ids	[所有id]
	}
--]]
s2c.ACTIVITY_RESP_FLOP_GAME_INFO = 5157

--[[
	[1] = {--ResDetectiveEvtFinish
	}
--]]
s2c.DETECTIVE_RES_DETECTIVE_EVT_FINISH = 8902

--[[
	[1] = {--RespFormationBackupList
		[1] = {--repeated FormationBackupInfo
			[1] = {--FormationInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'int32':type	[ 阵型类型]
				[3] = 'int32':status	[ 阵型状态 0 未启用 1 启用]
				[4] = 'repeated string':stance	[ 阵型英雄]
			},
			[2] = 'int32':id
			[3] = 'string':desc	[描述名称]
		},
	}
--]]
s2c.PLAYER_RESP_FORMATION_BACKUP_LIST = 296

--[[
	[1] = {--RespBackHomePage
	}
--]]
s2c.TEAM_RESP_BACK_HOME_PAGE = 5904

--[[
	[1] = {--TeamInfo
		[1] = 'string':teamId	[ 队伍ID]
		[2] = 'int32':leaderPid	[ 队长PID]
		[3] = {--repeated TeamMember
			[1] = 'int32':pid	[ 队员PID]
			[2] = 'int32':status	[ 队员状态	  1:空闲 2:准备中]
			[3] = 'int32':heroCid	[ 英雄]
			[4] = 'string':name	[ 昵称]
			[5] = 'int32':plv	[ 玩家等级]
			[6] = 'int32':skinCid	[ 英雄皮肤]
			[7] = 'int32':heroLevel	[英雄等级]
			[8] = 'int32':heroQuality	[英雄品质]
			[9] = 'int32':titleId	[ 称号]
			[10] = 'string':unionName	[ 公会名字]
			[11] = 'int32':fightPower	[ 战斗力]
		},
		[4] = 'int32':status	[ 队伍状态 1:关闭自动匹配 2:开启自动匹配]
		[5] = 'int32':teamType	[请求的类型]
		[6] = 'int32':battleId	[战斗的id]
		[7] = 'int32':show_type	[0,显示所有;1,显示给好友;2,不显示]
		[8] = 'int32':level_limit	[等级限制]
	}
--]]
s2c.TEAM_TEAM_INFO = 5898

--[[
	[1] = {--RspLadderEquipMsg
		[1] = {--repeated HeroInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int64':exp	[ 经验]
			[6] = {--repeated AttributeInfo
				[1] = 'int32':type	[ 属性类型]
				[2] = 'int32':val	[ 属性值]
			},
			[7] = 'int32':advancedLvl	[ 突破等级]
			[8] = {--repeated HeroEquipment
				[1] = 'int32':position	[装备位置]
				[2] = 'string':equipmentId	[装备id]
				[3] = {--EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
			},
			[9] = 'bool':helpFight	[ 助战]
			[10] = 'int32':angelLvl	[ 天使等级]
			[11] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[12] = 'int32':useSkillPiont	[ 已使用技能点]
			[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
			[14] = 'int32':provide	[出处]
			[15] = 'int32':fightPower	[ 战斗力]
			[16] = 'int32':skinCid	[ 皮肤cid]
			[17] = {--repeated SkillStrategy
				[1] = 'int32':id
				[2] = 'string':name
				[3] = 'int32':alreadyUseSkillPiont
				[4] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[5] = {--repeated PassiveSkillInfo
					[1] = 'int32':pos
					[2] = 'int32':skillId
				},
			},
			[18] = 'int32':useSkillStrategy
			[19] = {--repeated CrystalInfo
				[1] = 'int32':rarity
				[2] = 'int32':gridId
			},
			[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
			[21] = {--repeated EuqipFetterInfo
				[1] = 'int32':index
				[2] = {--NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
			},
			[22] = {--HeroStatus(enum)
				'v4':HeroStatus
			},
			[23] = 'int32':deadLine
			[24] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[25] = 'int32':skinCidTemp	[ 皮肤cid]
			[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
			[27] = 'int32':breakLv	[突破等级]
		},
	}
--]]
s2c.LADDER_RSP_LADDER_EQUIP = 8305

--[[
	[1] = {--RespAngelWake
	}
--]]
s2c.HERO_RESP_ANGEL_WAKE = 1032

--[[
	[1] = {--ResReceiveFriendHelpTask
		[1] = {--FriendHelpInfo
			[1] = 'int32':playerId
			[2] = 'string':playerName
			[3] = 'int32':portraitCid
			[4] = 'int32':portraitFrameCid
			[5] = 'int32':level
			[6] = {--repeated FriendHelpTaskInfo
				[1] = 'int32':taskId
				[2] = {--FriendHelpTaskStatus(enum)
					'v4':FriendHelpTaskStatus
				},
			},
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.FRIEND_RES_RECEIVE_FRIEND_HELP_TASK = 3091

--[[
	[1] = {--ResSTTaskChange
		[1] = {--repeated SimulateTrainTask
			[1] = 'int32':id	[ 任务id]
			[2] = {--STTaskStaus(enum)
				'v4':STTaskStaus
			},
		},
	}
--]]
s2c.HERO_RES_STTASK_CHANGE = 1048

--[[
	[1] = {--Afk7827
	}
--]]
s2c.EXPLORE_AFK7827 = 7827

--[[
	[1] = {--RespAITrainingQuestions
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'int32':page	[页数]
		[3] = 'string':jsonList	[json列表数据]
	}
--]]
s2c.DATING_RESP_AITRAINING_QUESTIONS = 1565

--[[
	[1] = {--UpdateTriggerDating
		[1] = 'int32':roleId
		[2] = 'repeated int32':datingRuleCid
	}
--]]
s2c.DATING_UPDATE_TRIGGER_DATING = 1550

--[[
	[1] = {--setPlayerInfo
	}
--]]
s2c.PLAYERSET_PLAYER_INFO = 260

--[[
	[1] = {--RespNeptune2ndHalfBuyCount
		[1] = {--repeated Neptune2ndHalfIntTable
			[1] = 'int32':key	[键]
			[2] = 'int32':value	[值]
		},
	}
--]]
s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_BUY_COUNT = 7706

--[[
	[1] = {--RespRefreshContract
	}
--]]
s2c.ACTIVITY_RESP_REFRESH_CONTRACT = 5186

--[[
	[1] = {--RespGetUnionMorale
		[1] = 'int32':morale	[返回总士气值]
	}
--]]
s2c.JU_NAI_INVASION_RESP_GET_UNION_MORALE = 9104

--[[
	[1] = {--RespWishTreeInfo
		[1] = 'int32':id	[当前等级id]
	}
--]]
s2c.ANNIVERSARY2ND_RESP_WISH_TREE_INFO = 9230

--[[
	[1] = {--ResStrengthenNewEquip
		[1] = 'bool':isSuccess
	}
--]]
s2c.EQUIPMENT_RES_STRENGTHEN_NEW_EQUIP = 2831

--[[
	[1] = {--EventsClearMsg
		[1] = 'int32':worldCid	[已完成的世界id]
	}
--]]
s2c.OFFICE_EXPLORE_EVENTS_CLEAR = 7105

--[[
	[1] = {--GetDatingInfo
		[1] = {--repeated NotFinishDating
			[1] = 'int32':score	[积分]
			[2] = 'int32':datingType	[约会类型]
			[3] = 'int32':currentNodeId	[当前进行到的节点]
			[4] = {--repeated BranchNode
				[1] = 'int32':datingId	[约会配置id]
				[2] = 'repeated int32':nextNodeIds	[下级节点id]
			},
			[5] = 'int32':selectedNode	[被选择节点]
			[6] = 'repeated int32':roleCid	[看板娘id]
			[7] = 'int32':datingRuleCid	[约会id]
			[8] = 'bool':isFirst	[是否是第一次约会]
		},
		[2] = 'repeated int32':datingRuleCid	[已经通过的剧本id]
		[3] = 'repeated int32':endings	[剧本结束节点]
		[4] = {--repeated CityDatingInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':cityDatingId	[城市约会id]
			[3] = 'repeated int32':datingTimeFrame	[约会时段]
			[4] = 'int32':datingRuleCid	[约会cid]
			[5] = 'int32':date	[约会日期]
			[6] = 'int32':state	[预定约会状态 0:无约会 1:有邀请,未接受 2:已接受邀请 3:正常约会时间 4:约会时间已过]
			[7] = 'bool':inDating	[ 是否在剧情中 true   false]
		},
		[5] = {--repeated UpdateTriggerDating
			[1] = 'int32':roleId
			[2] = 'repeated int32':datingRuleCid
		},
		[6] = 'int32':weChatSendTime	[约会发送的时间]
		[7] = {--repeated NewFavorAward
			[1] = 'int32':roleId
			[2] = 'repeated int32':awardId
		},
	}
--]]
s2c.DATING_GET_DATING_INFO = 1539

--[[
	[1] = {--ComposeFinish
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = 'int32':zPointType	[质点类型]
	}
--]]
s2c.SUMMON_COMPOSE_FINISH = 3331

--[[
	[1] = {--ExploreInfo
		[1] = {--repeated Cabin
			[1] = 'int32':id	[舱室id]
			[2] = 'int32':cid	[舱室配置id]
			[3] = 'int32':holeCount	[镶嵌孔位数量]
			[4] = {--repeated Equip
				[1] = 'string':id
				[2] = 'int32':cid
				[3] = 'int32':level
				[4] = 'int32':index	[镶嵌的位置,从1开始,如果为0,没有镶嵌]
				[5] = 'int32':cabinId	[舱室id]
			},
			[5] = {--repeated AfkTask
				[1] = 'int32':id
				[2] = 'int32':state	[任务状态 0 未开始 1开始 2完成,3已领奖]
				[3] = 'repeated int32':heroId	[任务派遣的hero]
				[4] = 'int64':startTime	[任务开始执行的时间 0 就是还没有开始或者已经完成]
				[5] = 'int32':cabinId	[舱室id]
			},
			[6] = {--repeated HeroDriver
				[1] = 'int32':index	[舱室指挥室位置]
				[2] = 'int32':heroId	[精灵id]
			},
			[7] = 'int32':fightPower	[精灵总战斗力]
			[8] = {--repeated Treasure
				[1] = 'int32':index	[格子索引]
				[2] = 'string':uuid	[装备在格子上的宝物uid]
			},
		},
		[2] = 'int32':skinId	[外形id]
	}
--]]
s2c.EXPLORE_EXPLORE_INFO = 7801

--[[
	[1] = {--RespUWarOrderLevel
	}
--]]
s2c.ACTIVITY_RESP_UWAR_ORDER_LEVEL = 5148

--[[
	[1] = {--Resp2019ChristmasTalent
	}
--]]
s2c.CHRISTMAS_RESP2019_CHRISTMAS_TALENT = 6615

--[[
	[1] = {--RspPassStageEndless
		[1] = 'int32':nextLevelCid	[下一关卡id]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ENDLESS_CLOISTER_RSP_PASS_STAGE_ENDLESS = 5379

--[[
	[1] = {--OfficeFormationMsg
		[1] = 'repeated int32':formation	[ 阵型信息]
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_FORMATION = 7204

--[[
	[1] = {--RespFunctionSwitch
		[1] = {--repeated FunctionSwitch
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':switchType
			[3] = 'bool':open
		},
	}
--]]
s2c.LOGIN_RESP_FUNCTION_SWITCH = 280

--[[
	[1] = {--RespKurumiCityResource
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_RESP_KURUMI_CITY_RESOURCE = 5165

--[[
	[1] = {--ResGameStart
		[1] = 'repeated int32':orderList	[电路游戏:配置id,其他游戏:随机出来的顺序]
	}
--]]
s2c.SUMMER_COURAGE_RES_GAME_START = 6907

--[[
	[1] = {--RespFlopFlopGame
		[1] = {--CardInfo
			[1] = 'int32':pos	[位置]
			[2] = 'int32':id	[配置id,翻开的牌会传id,没有翻开的牌没有这个字段]
		},
		[2] = 'repeated int32':cardId	[配对的牌id]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_RESP_FLOP_FLOP_GAME = 5159

--[[
	[1] = {--SummerLogNotice
		[1] = {--repeated SummerLogInfo
			[1] = 'int32':logId	[id]
			[2] = 'bool':finished	[是否完成,true完成]
			[3] = 'int64':time	[发生时间]
		},
		[2] = {--repeated MinorLogInfo
			[1] = 'int32':logId	[id]
			[2] = 'int64':time	[发生时间]
		},
		[3] = 'int32':type	[更新类型:1表示进入的时候全量,2表示只发的更新的]
	}
--]]
s2c.SUMMER_COURAGE_SUMMER_LOG_NOTICE = 6911

--[[
	[1] = {--RespUpQuality
		[1] = {--HeroInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int64':exp	[ 经验]
			[6] = {--repeated AttributeInfo
				[1] = 'int32':type	[ 属性类型]
				[2] = 'int32':val	[ 属性值]
			},
			[7] = 'int32':advancedLvl	[ 突破等级]
			[8] = {--repeated HeroEquipment
				[1] = 'int32':position	[装备位置]
				[2] = 'string':equipmentId	[装备id]
				[3] = {--EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
			},
			[9] = 'bool':helpFight	[ 助战]
			[10] = 'int32':angelLvl	[ 天使等级]
			[11] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[12] = 'int32':useSkillPiont	[ 已使用技能点]
			[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
			[14] = 'int32':provide	[出处]
			[15] = 'int32':fightPower	[ 战斗力]
			[16] = 'int32':skinCid	[ 皮肤cid]
			[17] = {--repeated SkillStrategy
				[1] = 'int32':id
				[2] = 'string':name
				[3] = 'int32':alreadyUseSkillPiont
				[4] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[5] = {--repeated PassiveSkillInfo
					[1] = 'int32':pos
					[2] = 'int32':skillId
				},
			},
			[18] = 'int32':useSkillStrategy
			[19] = {--repeated CrystalInfo
				[1] = 'int32':rarity
				[2] = 'int32':gridId
			},
			[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
			[21] = {--repeated EuqipFetterInfo
				[1] = 'int32':index
				[2] = {--NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
			},
			[22] = {--HeroStatus(enum)
				'v4':HeroStatus
			},
			[23] = 'int32':deadLine
			[24] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[25] = 'int32':skinCidTemp	[ 皮肤cid]
			[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
			[27] = 'int32':breakLv	[突破等级]
		},
	}
--]]
s2c.HERO_RESP_UP_QUALITY = 1035

--[[
	[1] = {--RspYouciRank
		[1] = {--repeated YouciRankInfo
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':headId	[头像]
			[4] = 'int32':frameId	[头像框]
			[5] = 'int32':rank	[排名]
			[6] = 'int32':rounds	[圈数]
			[7] = 'int32':lvl	[等级]
		},
		[2] = {--YouciRankInfo
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':headId	[头像]
			[4] = 'int32':frameId	[头像框]
			[5] = 'int32':rank	[排名]
			[6] = 'int32':rounds	[圈数]
			[7] = 'int32':lvl	[等级]
		},
	}
--]]
s2c.YOUCI_RSP_YOUCI_RANK = 9354

--[[
	[1] = {--RespFestival2020GameInit
		[1] = 'int32':game	[游戏类型]
		[2] = 'int32':group	[组合id]
		[3] = 'repeated int32':result	[答案]
		[4] = 'repeated int32':pool	[选项池]
	}
--]]
s2c.SPRING_FESTIVAL_RESP_FESTIVAL2020_GAME_INIT = 6713

--[[
	[1] = {--RespTakeOffMedal
		[1] = 'bool':success
	}
--]]
s2c.MEDAL_RESP_TAKE_OFF_MEDAL = 3003

--[[
	[1] = {--ResChangeAppearance
		[1] = 'int32':changeType	[1切换皮肤和英雄id  2:切换特效]
		[2] = 'int32':pid	[ 玩家ID]
		[3] = 'int32':heroCid
		[4] = 'int32':skinCid
		[5] = 'int32':effectId	[特效id]
		[6] = 'int32':roomType	[大世界类型]
	}
--]]
s2c.NEW_WORLD_RES_CHANGE_APPEARANCE = 6803

--[[
	[1] = {--ResRecommendList
		[1] = {--repeated ApprenticeInfo
			[1] = 'int32':playerId	[ 玩家id]
			[2] = 'int32':portraitCId	[ 头像]
			[3] = 'string':name	[ 名字]
			[4] = 'int32':fightPower	[ 战力]
			[5] = 'int32':level	[ 等级]
			[6] = 'int64':lastLoginTime	[ 最后登录时间]
			[7] = 'bool':online	[ 是否在线]
			[8] = 'int32':portraitFrameCId	[ 头像框CID]
			[9] = 'bool':isFriend	[ 是否好友]
			[10] = 'bool':isUnion	[ 是否社团成员]
			[11] = 'bool':finished	[ 是否出师,徒弟列表需要的字段]
			[12] = 'int32':type	[ 1师父,2师门,3徒弟,4申请收徒,5申请拜师]
			[13] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[14] = 'int32':famousExp	[ 名师经验]
			[15] = 'bool':hasGift	[ 师父身上的该字段表示是否有礼物可领,true是的,只有师父会展示是否有礼物可领;徒弟身上的该字段表示是否可以赠送礼物,true可以赠送]
		},
	}
--]]
s2c.APPRENTICE_RES_RECOMMEND_LIST = 7901

--[[
	[1] = {--YouciRewardIdMsg
		[1] = 'int32':rewardId	[本轮奖池ID (客户端需要自己清空	repeated int32 posRewarded = 5; //已领取了奖励的位置)    //本轮奖池ID (客户端需要自己清空	repeated int32 posRewarded = 5; //已领取了奖励的位置)]
		[2] = 'int64':nextRefreshTime	[下次系统刷新时间戳]
	}
--]]
s2c.YOUCI_YOUCI_REWARD_ID = 9355

--[[
	[1] = {--ResExpireItemList
		[1] = {--repeated ExpireItem
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ITEM_RES_EXPIRE_ITEM_LIST = 516

--[[
	[1] = {--LogoutSuc
		[1] = {--LogoutType(enum)
			'v4':LogoutType
		},
	}
--]]
s2c.LOGIN_LOGOUT_SUC = 258

--[[
	[1] = {--RespSubmitUnionProps
		[1] = {--ClubTreeInfo
			[1] = 'int32':id	[当前等级id]
			[2] = 'int32':exp	[当前等级经验]
			[3] = 'int32':submitTimes	[今日提交材料次数]
			[4] = 'int32':expLimit	[今日可提交的最多经验值]
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ANNIVERSARY2ND_RESP_SUBMIT_UNION_PROPS = 9232

--[[
	[1] = {--RespYearLottoAddress
	}
--]]
s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_ADDRESS = 8705

--[[
	[1] = {--NoticeList
		[1] = {--repeated NoticeInfo
			[1] = 'int32':id	[ 公告ID]
			[2] = 'int32':inx	[ 排序序号]
			[3] = 'int32':type	[ 公告类型]
			[4] = 'string':tag	[ 公告标签]
			[5] = 'string':title	[ 公告标题]
			[6] = 'string':context	[ 公告内容]
			[7] = 'string':contextImg	[ 内容图片]
		},
	}
--]]
s2c.LOGIN_NOTICE_LIST = 263

--[[
	[1] = {--ResAnnivDress
		[1] = 'repeated int32':randomDress	[随机出来的时装]
		[2] = 'int32':leftFreeCount	[剩余的免费刷新次数]
		[3] = 'int32':leftCount	[剩余总刷新次数]
		[4] = 'string':nextRestTime	[下次重置时间,时间戳,毫秒]
	}
--]]
s2c.ANNIVERSARY2ND_RES_ANNIV_DRESS = 9206

--[[
	[1] = {--RespWorldOperate
		[1] = 'int32':roomType	[房间类型]
		[2] = 'string':ext	[操作信息]
	}
--]]
s2c.NEW_WORLD_RESP_WORLD_OPERATE = 6820

--[[
	[1] = {--RespYearLottoJoinNum
		[1] = 'int32':num
	}
--]]
s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_JOIN_NUM = 8707

--[[
	[1] = {--RespUnionLabourRank
		[1] = {--repeated UnionLabourRank
			[1] = 'int32':playerId	[玩家id]
			[2] = 'string':playerName	[玩家名字]
			[3] = 'int32':playerLv	[玩家等级]
			[4] = 'int32':score	[得分]
			[5] = 'int32':rank	[名次]
			[6] = 'int32':headId	[头像]
		},
		[2] = {--UnionLabourRank
			[1] = 'int32':playerId	[玩家id]
			[2] = 'string':playerName	[玩家名字]
			[3] = 'int32':playerLv	[玩家等级]
			[4] = 'int32':score	[得分]
			[5] = 'int32':rank	[名次]
			[6] = 'int32':headId	[头像]
		},
	}
--]]
s2c.ACTIVITY_RESP_UNION_LABOUR_RANK = 5182

--[[
	[1] = {--RespCorssRankActivity
		[1] = 'int32':activityId	[ 活动ID]
		[2] = {--repeated ActivityRankMsg
			[1] = 'int32':rank	[ 排行]
			[2] = 'int32':playerId	[角色ID]
			[3] = 'string':playerName	[ 角色名]
			[4] = 'int32':score	[排行榜分数]
			[5] = 'int32':headIcon	[头像id]
			[6] = 'int32':helpFightHeroId	[助战id]
			[7] = 'int32':level	[等级]
			[8] = 'int32':frameCid	[头像框]
			[9] = 'int32':groupRank	[0:单人排名,1:组队排名]
			[10] = {--repeated RankPlayerInfo
				[1] = 'string':playerName	[ 角色名]
				[2] = 'int32':playerId	[角色ID]
				[3] = 'int32':level	[等级]
				[4] = 'int32':frameCid	[头像框]
				[5] = 'int32':headIcon	[头像id]
				[6] = 'int32':helpFightHeroId	[助战id]
				[7] = 'int32':heroId	[使用英雄id]
			},
		},
		[3] = 'int32':myRank	[ 我的排名]
		[4] = 'int32':myScore	[ 我的分数]
	}
--]]
s2c.ACTIVITY_RESP_CORSS_RANK_ACTIVITY = 5153

--[[
	[1] = {--RespUnionLabourConvert
		[1] = {--repeated UnionLabourConvertItem
			[1] = 'int32':itemCid	[转化的道具id]
			[2] = 'int32':totalNum	[已转化的数量]
		},
	}
--]]
s2c.ACTIVITY_RESP_UNION_LABOUR_CONVERT = 5183

--[[
	[1] = {--RespYearLottoList
		[1] = {--repeated YearLottoPlayerInfo
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':headId	[头像]
			[4] = 'int32':headFrame	[头像框]
			[5] = 'int32':level	[等级]
			[6] = 'int32':fightPower	[战力]
			[7] = 'int32':round	[轮次]
			[8] = 'int32':prize	[奖次]
			[9] = 'int32':sid	[服务器组id,不同组之间pid可能有相同]
			[10] = 'string':channel	[渠道appid,不同组之间pid可能有相同]
		},
	}
--]]
s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_LIST = 8702

--[[
	[1] = {--RespTakeOffSystemTitle
		[1] = 'int32':id
	}
--]]
s2c.SYSTEM_TITLE_RESP_TAKE_OFF_SYSTEM_TITLE = 8152

--[[
	[1] = {--UpadteLevelInfo
		[1] = {--LevelInfos
			[1] = {--repeated LevelInfo
				[1] = 'int32':cid	[关卡cid]
				[2] = 'repeated int32':goals	[达成目标的下标]
				[3] = 'int32':fightCount	[战斗次数]
				[4] = 'bool':win	[是否胜利]
				[5] = 'int32':buyCount	[购买次数]
				[6] = 'int32':freeCount	[ 周卡或者是月卡的免费次数]
			},
		},
		[2] = {--RefreshDungeonLevelGroupList
			[1] = {--repeated DungeonLevelGroupInfo
				[1] = 'string':id	[id]
				[2] = 'int32':cid	[cid]
				[3] = 'int32':fightCount	[战斗次数]
				[4] = 'int32':buyCount	[购买次数]
				[5] = {--repeated ListMap
					[1] = 'int32':key
					[2] = 'repeated int32':list
				},
				[6] = 'int32':mainLineCid	[当前关卡标记]
				[7] = 'int32':maxMainLine	[最大关卡进度]
			},
		},
	}
--]]
s2c.DUNGEON_UPADTE_LEVEL_INFO = 1814

--[[
	[1] = {--BuyGoods
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.STORE_BUY_GOODS = 2562

--[[
	[1] = {--RespYearLottoReward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_REWARD = 8704

--[[
	[1] = {--RespUnionLabourScore
		[1] = 'int32':totalScore	[社团总积分]
	}
--]]
s2c.ACTIVITY_RESP_UNION_LABOUR_SCORE = 5181

--[[
	[1] = {--RspUpgradeSpirit
		[1] = {--HeroSpiritInfo
			[1] = 'int32':spiritPoints	[可用灵力点数]
			[2] = 'int32':grade	[品阶从0开始]
			[3] = 'int32':level	[级数从0开始]
			[4] = 'int64':exp	[经验值]
			[5] = {--repeated HeroSpiritProperty
				[1] = 'int32':cid	[cid]
				[2] = 'int32':num	[点数]
			},
			[6] = 'bool':firstShow	[首次开启展示true即为要显示false则不显示]
			[7] = 'bool':feedback	[旧灵力系统是否已返回资源]
			[8] = {--repeated HeroAngleSpirit
				[1] = 'int32':heroCid	[cid]
				[2] = 'int32':lv	[点数]
			},
			[9] = 'int32':maxLv	[可升级上限]
		},
	}
--]]
s2c.HERO_SPIRIT_RSP_UPGRADE_SPIRIT = 8403

--[[
	[1] = {--ResTakeReward
		[1] = 'int32':type	[1是个人奖励,2是全服奖励]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.WORLD_HELP_RES_TAKE_REWARD = 8801

--[[
	[1] = {--OfficeAreaMapPoint
		[1] = {--GridMapPoint
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'int32':event	[ 事件id,大于0则有事件]
			[4] = 'bool':eventValid	[ 事件是否可用]
			[5] = 'bool':visual	[ 是否可视,即是否开启格子]
			[6] = {--repeated GridPointInfo
				[1] = 'int32':x	[ x位置]
				[2] = 'int32':y	[ y位置]
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_AREA_MAP_POINT = 7205

--[[
	[1] = {--ValentineRankMsg
		[1] = 'int32':circleMinu	[ 更新周期,分钟]
		[2] = {--repeated ValentineRankInfo
			[1] = 'int32':roleid	[ 情人节看板娘id]
			[2] = 'int64':privity	[ 默契值信息]
		},
	}
--]]
s2c.VALENTINE_VALENTINE_RANK = 7401

--[[
	[1] = {--CityDatingInfo
		[1] = {--ChangeType(enum)
			'v4':ChangeType
		},
		[2] = 'string':cityDatingId	[城市约会id]
		[3] = 'repeated int32':datingTimeFrame	[约会时段]
		[4] = 'int32':datingRuleCid	[约会cid]
		[5] = 'int32':date	[约会日期]
		[6] = 'int32':state	[预定约会状态 0:无约会 1:有邀请,未接受 2:已接受邀请 3:正常约会时间 4:约会时间已过]
		[7] = 'bool':inDating	[ 是否在剧情中 true   false]
	}
--]]
s2c.DATING_CITY_DATING_INFO = 1549

--[[
	[1] = {--ResUseEquipBackup
	}
--]]
s2c.EQUIPMENT_RES_USE_EQUIP_BACKUP = 2844

--[[
	[1] = {--OfficeGameEventMsg
		[1] = {--GridGameEventMsg
			[1] = 'int32':eventCid	[ 事件cid]
			[2] = 'int32':gameCid	[ 游戏cid]
			[3] = 'repeated int32':options	[ 选项列表]
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_GAME_EVENT = 7228

--[[
	[1] = {--ExploreTreasureComposeMsg
		[1] = 'int32':id	[宝物templateid]
	}
--]]
s2c.EXPLORE_EXPLORE_TREASURE_COMPOSE = 7830

--[[
	[1] = {--ResRewardRecord
		[1] = 'repeated int32':personalRecord	[个人领奖记录]
		[2] = 'repeated int32':serverRecord	[全服领奖记录]
		[3] = 'string':serverScore	[全服积分]
	}
--]]
s2c.WORLD_HELP_RES_REWARD_RECORD = 8803

--[[
	[1] = {--OperUnionMember
		[1] = 'int32':operType	[ 1申请加入 2退出 3同意申请 4拒绝申请 5团长踢人 6转让团长 7快速加入 8弹劾团长]
		[2] = 'repeated int32':targets
	}
--]]
s2c.UNION_OPER_UNION_MEMBER = 6652

--[[
	[1] = {--ResFavorReward
		[1] = 'int32':favorDatingId	[Favor表对应id]
		[2] = 'int32':statue	[ 1领取成功]
	}
--]]
s2c.EXTRA_DATING_RES_FAVOR_REWARD = 5651

--[[
	[1] = {--ValentineNewDatingMsg
		[1] = 'int32':datingCid	[ 新增使用约会id]
	}
--]]
s2c.VALENTINE_VALENTINE_NEW_DATING = 7404

--[[
	[1] = {--RspRefreshTask
	}
--]]
s2c.ZILLIONAIRE_RSP_REFRESH_TASK = 5223

--[[
	[1] = {--LevelUp
		[1] = 'int32':buildingId	[ 建筑id]
		[2] = 'int32':targetLevel
	}
--]]
s2c.UNION_LEVEL_UP = 6657

--[[
	[1] = {--CreateUnion
		[1] = 'bool':succ
		[2] = {--UnionInfo
			[1] = 'int32':id
			[2] = 'string':name
			[3] = 'int32':level	[等级]
			[4] = 'int32':icon	[徽记]
			[5] = 'int32':memberCount	[成员数量]
			[6] = 'int32':exp	[当前等级经验]
			[7] = 'string':leaderName	[团长名]
			[8] = 'string':notice	[公告]
			[9] = {--repeated ApplyInfo
				[1] = 'int32':playerId	[ 玩家ID]
				[2] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
				[3] = 'string':name	[ 名字]
				[4] = 'int32':fightPower	[ 战力]
				[5] = 'int32':lvl	[ 等级]
				[6] = 'int64':lastLoginTime	[ 最后登录时间]
				[7] = 'bool':online	[ 是否在线]
				[8] = 'int32':portraitCid	[ 头像CID]
				[9] = 'int32':portraitFrameCid	[ 头像框CID]
				[10] = {--ChangeType(enum)
					'v4':ChangeType
				},
			},
			[10] = {--repeated UnionMember
				[1] = 'int32':playerId	[ 玩家ID]
				[2] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
				[3] = 'string':name	[ 名字]
				[4] = 'int32':fightPower	[ 战力]
				[5] = 'int32':lvl	[ 等级]
				[6] = 'int64':lastLoginTime	[ 最后登录时间]
				[7] = 'bool':online	[ 是否在线]
				[8] = 'int32':portraitCid	[ 头像CID]
				[9] = 'int32':portraitFrameCid	[ 头像框CID]
				[10] = 'int32':degree	[职位]
				[11] = 'int32':weekContribution	[ 周贡献]
				[12] = 'int32':allContribution	[ 全部贡献]
				[13] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[14] = 'int64':joinTime	[ 加入时间]
				[15] = 'repeated int32':groupGiftIds	[团购礼包id]
			},
			[11] = 'bool':canApply	[是否可以申请加入]
			[12] = 'bool':autoJoin	[是否自动加入]
			[13] = 'bool':joinLimit	[是否开启加入限制]
			[14] = 'int32':limitLevel	[加入需求等级]
			[15] = 'int32':limitPower	[加入需求战力]
			[16] = 'int64':delateEndTime	[弹劾截止时间]
			[17] = 'int32':weekExp	[周经验]
			[18] = 'repeated int32':weekExpPrizeReceiveIndex	[周经验领取索引]
			[19] = 'int32':lastWeekActive	[上周活跃度]
			[20] = 'int32':receiveTimes	[本日领取的空投次数]
			[21] = 'int32':country	[国家ID]
			[22] = 'bool':showCountry	[是否显示国家]
			[23] = {--repeated RedpacketTimes
				[1] = 'int32':type	[类型   1:金币 2:钻石 3:体力]
				[2] = 'int32':num	[数量]
			},
		},
	}
--]]
s2c.UNION_CREATE_UNION = 6650

--[[
	[1] = {--RespFormationBackupHero
		[1] = {--FormationBackupInfo
			[1] = {--FormationInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'int32':type	[ 阵型类型]
				[3] = 'int32':status	[ 阵型状态 0 未启用 1 启用]
				[4] = 'repeated string':stance	[ 阵型英雄]
			},
			[2] = 'int32':id
			[3] = 'string':desc	[描述名称]
		},
	}
--]]
s2c.PLAYER_RESP_FORMATION_BACKUP_HERO = 297

--[[
	[1] = {--RespUnionWeekActivePrize
		[1] = 'int32':index	[ 领取索引]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.UNION_RESP_UNION_WEEK_ACTIVE_PRIZE = 6655

--[[
	[1] = {--ExploreTechUpgrade
		[1] = {--TechTree
			[1] = 'int32':techType
			[2] = 'int32':nationId	[如果是国家天赋,则发送国家id,如果是形态天赋没有数据]
			[3] = {--repeated Tech
				[1] = 'int32':techId
				[2] = 'int32':state	[0:解锁未学习 ,1:已学习  未解锁不发]
			},
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EXPLORE_EXPLORE_TECH_UPGRADE = 7816

--[[
	[1] = {--UpdateUnionInfo
		[1] = 'int32':type	[ 1修改社团徽记 2修改社团公告 3变更是否开启社团申请(参数true或false) 4变更是否开启自动加入(参数true或false) 5变更社团申请限制(是否开启限制,需求等级,需求战力) 15改名    // 1修改社团徽记 2修改社团公告 3变更是否开启社团申请(参数true或false) 4变更是否开启自动加入(参数true或false) 5变更社团申请限制(是否开启限制,需求等级,需求战力) 15改名]
		[2] = 'string':param
	}
--]]
s2c.UNION_UPDATE_UNION_INFO = 6654

--[[
	[1] = {--QueryUnionList
		[1] = {--repeated UnionSnapInfo
			[1] = 'int32':id
			[2] = 'string':name
			[3] = 'int32':level	[等级]
			[4] = 'int32':icon	[徽记]
			[5] = 'int32':memberCount	[成员数量]
			[6] = 'int32':memberCountMax	[人数上限]
			[7] = 'int32':active	[活跃度]
			[8] = 'int32':limitLevel	[加入需求等级]
			[9] = 'int32':limitPower	[加入需求战力]
			[10] = 'bool':apply	[申请状态]
			[11] = 'bool':canApply	[是否可以申请加入]
			[12] = 'string':leaderName	[团长名]
			[13] = 'string':notice	[社团公告]
			[14] = 'int32':country	[国家ID]
			[15] = 'bool':showCountry	[是否显示国家]
		},
	}
--]]
s2c.UNION_QUERY_UNION_LIST = 6651

--[[
	[1] = {--RespUseingToy
	}
--]]
s2c.ACTIVITY_RESP_USEING_TOY = 5225

--[[
	[1] = {--RespTimeLinkageCG
		[1] = 'repeated int32':cids	[ 联动开场动画标识,客户端用]
	}
--]]
s2c.DUNGEON_RESP_TIME_LINKAGE_CG = 1816

--[[
	[1] = {--ResDetectiveChapter
		[1] = {--repeated DetectiveChapterInfo
			[1] = 'int32':chapterId	[周目id]
			[2] = {--ChapterSt(enum)
				'v4':ChapterSt
			},
			[3] = 'int32':currentAreaId	[当前所在区域]
			[4] = 'bool':isNewChapter	[是否新周目]
			[5] = 'int32':currentEvtId	[当前事件id]
			[6] = 'repeated int32':saveEvtId	[6类型事件]
			[7] = 'bool':first	[是否首通过]
		},
		[2] = 'repeated int32':rewardGame	[领了奖的小游戏]
	}
--]]
s2c.DETECTIVE_RES_DETECTIVE_CHAPTER = 8905

--[[
	[1] = {--ResTriggerSpringEnvelope
		[1] = 'int32':senderId	[玩家id]
		[2] = 'int64':createTime	[触发时间]
		[3] = 'int32':id	[配置id]
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.RED_ENVELOPE_RES_TRIGGER_SPRING_ENVELOPE = 7306

--[[
	[1] = {--PushTeamBuff
		[1] = {--repeated PlayerBuff
			[1] = 'int32':playerId
			[2] = 'int32':buffId
			[3] = 'repeated int32':canUseBuff
		},
		[2] = 'int32':functionType
	}
--]]
s2c.CHASM_PUSH_TEAM_BUFF = 6154

--[[
	[1] = {--RespGetUnionReCallRank
		[1] = {--UnionReCallRank
			[1] = 'int32':id
			[2] = 'string':name
			[3] = 'int32':icon	[徽记]
			[4] = 'int32':recallScore	[召回积分]
			[5] = 'int32':recallNum	[召回玩家数量]
			[6] = 'int32':rank
		},
		[2] = {--repeated UnionReCallRank
			[1] = 'int32':id
			[2] = 'string':name
			[3] = 'int32':icon	[徽记]
			[4] = 'int32':recallScore	[召回积分]
			[5] = 'int32':recallNum	[召回玩家数量]
			[6] = 'int32':rank
		},
	}
--]]
s2c.UNION_RESP_GET_UNION_RE_CALL_RANK = 6675

--[[
	[1] = {--ResEnterNewWorld
		[1] = {--repeated AreaPlayerInfo
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':pname	[ 玩家昵称]
			[3] = 'int32':level
			[4] = 'int32':heroCid
			[5] = 'int32':skinCid
			[6] = 'int32':unionId
			[7] = 'string':unionName
			[8] = 'int32':titleId
			[9] = {--AreaPlayerPos
				[1] = 'int32':x
				[2] = 'int32':y
				[3] = 'int32':dir
				[4] = 'int32':dt
			},
			[10] = 'int32':buildId	[游戏id]
			[11] = 'int32':effectId	[特效id]
		},
		[2] = {--repeated RoomDecorate
			[1] = 'int32':decorateId	[建筑id]
			[2] = 'string':pid	[实例id]
			[3] = {--AreaPlayerPos
				[1] = 'int32':x
				[2] = 'int32':y
				[3] = 'int32':dir
				[4] = 'int32':dt
			},
			[4] = 'string':ext	[额外信息]
		},
		[3] = 'int32':roomType	[大世界类型]
	}
--]]
s2c.NEW_WORLD_RES_ENTER_NEW_WORLD = 6801

--[[
	[1] = {--RespClearFriendReceive
	}
--]]
s2c.FRIEND_RESP_CLEAR_FRIEND_RECEIVE = 3077

--[[
	[1] = {--UpdateDegree
		[1] = 'int32':degree
		[2] = 'int32':target
	}
--]]
s2c.UNION_UPDATE_DEGREE = 6653

--[[
	[1] = {--ResNewWorldChangeDungeon
		[1] = 'int32':index	[格子索引]
		[2] = 'int32':restTime	[剩余时长]
	}
--]]
s2c.NEW_WORLD_RES_NEW_WORLD_CHANGE_DUNGEON = 6813

--[[
	[1] = {--RespStartGameMsg
		[1] = 'int32':type	[游戏类型]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[3] = 'repeated int32':infomation	[ 信息]
		[4] = 'int32':winNum	[赢的次数]
		[5] = 'int32':loseNum	[输的次数]
		[6] = 'repeated int32':winType	[胜利]
	}
--]]
s2c.ACTIVITY_RESP_START_GAME = 5136

--[[
	[1] = {--RespUnion
		[1] = {--UnionInfo
			[1] = 'int32':id
			[2] = 'string':name
			[3] = 'int32':level	[等级]
			[4] = 'int32':icon	[徽记]
			[5] = 'int32':memberCount	[成员数量]
			[6] = 'int32':exp	[当前等级经验]
			[7] = 'string':leaderName	[团长名]
			[8] = 'string':notice	[公告]
			[9] = {--repeated ApplyInfo
				[1] = 'int32':playerId	[ 玩家ID]
				[2] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
				[3] = 'string':name	[ 名字]
				[4] = 'int32':fightPower	[ 战力]
				[5] = 'int32':lvl	[ 等级]
				[6] = 'int64':lastLoginTime	[ 最后登录时间]
				[7] = 'bool':online	[ 是否在线]
				[8] = 'int32':portraitCid	[ 头像CID]
				[9] = 'int32':portraitFrameCid	[ 头像框CID]
				[10] = {--ChangeType(enum)
					'v4':ChangeType
				},
			},
			[10] = {--repeated UnionMember
				[1] = 'int32':playerId	[ 玩家ID]
				[2] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
				[3] = 'string':name	[ 名字]
				[4] = 'int32':fightPower	[ 战力]
				[5] = 'int32':lvl	[ 等级]
				[6] = 'int64':lastLoginTime	[ 最后登录时间]
				[7] = 'bool':online	[ 是否在线]
				[8] = 'int32':portraitCid	[ 头像CID]
				[9] = 'int32':portraitFrameCid	[ 头像框CID]
				[10] = 'int32':degree	[职位]
				[11] = 'int32':weekContribution	[ 周贡献]
				[12] = 'int32':allContribution	[ 全部贡献]
				[13] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[14] = 'int64':joinTime	[ 加入时间]
				[15] = 'repeated int32':groupGiftIds	[团购礼包id]
			},
			[11] = 'bool':canApply	[是否可以申请加入]
			[12] = 'bool':autoJoin	[是否自动加入]
			[13] = 'bool':joinLimit	[是否开启加入限制]
			[14] = 'int32':limitLevel	[加入需求等级]
			[15] = 'int32':limitPower	[加入需求战力]
			[16] = 'int64':delateEndTime	[弹劾截止时间]
			[17] = 'int32':weekExp	[周经验]
			[18] = 'repeated int32':weekExpPrizeReceiveIndex	[周经验领取索引]
			[19] = 'int32':lastWeekActive	[上周活跃度]
			[20] = 'int32':receiveTimes	[本日领取的空投次数]
			[21] = 'int32':country	[国家ID]
			[22] = 'bool':showCountry	[是否显示国家]
			[23] = {--repeated RedpacketTimes
				[1] = 'int32':type	[类型   1:金币 2:钻石 3:体力]
				[2] = 'int32':num	[数量]
			},
		},
	}
--]]
s2c.UNION_RESP_UNION = 6662

--[[
	[1] = {--RespGetAllBuildingInfo
		[1] = {--repeated NewBuildingInfo
			[1] = 'int32':buildingId	[配置id]
			[2] = 'repeated int32':buildingFuns
		},
		[2] = {--repeated RoleInRoom
			[1] = 'int64':dressId	[配置功能模型id]
			[2] = 'int32':buildingId	[配置id;]
			[3] = 'int32':cityRoleId	[配置id;]
		},
		[3] = {--repeated RemindEvent
			[1] = 'int32':buildingId	[建筑id]
			[2] = 'int32':funId	[功能id]
			[3] = 'int32':exeId	[执行Id]
			[4] = 'int32':eventType	[提醒类型]
		},
		[4] = 'int32':dayType	[是白天还是黑夜]
	}
--]]
s2c.NEW_BUILDING_RESP_GET_ALL_BUILDING_INFO = 2071

--[[
	[1] = {--RespSupplyRecord
		[1] = {--repeated SupplyRecord
			[1] = 'string':playerId	[ 领取角色id]
			[2] = 'string':playerName	[ 领取角色名]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
			[5] = 'int32':portraitCid	[ 头像CID]
			[6] = 'int32':portraitFrameCid	[ 头像框CID]
		},
	}
--]]
s2c.UNION_RESP_SUPPLY_RECORD = 6663

--[[
	[1] = {--SendRedPacketSucc
		[1] = 'int32':id	[ 红包id]
	}
--]]
s2c.UNION_SEND_RED_PACKET_SUCC = 6659

--[[
	[1] = {--ResFamousReward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.APPRENTICE_RES_FAMOUS_REWARD = 7909

--[[
	[1] = {--RespTrainMaxtriInfo
		[1] = 'int32':theme	[当前主题]
		[2] = 'int32':remain	[剩余主题重置时间]
		[3] = 'int32':remainTimes	[剩余挑战次数]
		[4] = 'repeated int32':receivePrizeIndex	[已领取的奖励索引]
		[5] = 'int32':score	[当前社团特训积分]
		[6] = 'repeated int32':selfTrainPrizeIndex	[已领取的个人特训积分奖励索引]
	}
--]]
s2c.UNION_RESP_TRAIN_MAXTRI_INFO = 6669

--[[
	[1] = {--RespUseWeChatItem
		[1] = 'int32':preNum	[使用前的数量]
		[2] = 'int32':afterNum	[使用后的数量]
		[3] = 'int32':roleId	[精灵]
		[4] = 'int32':itemId	[道具id]
		[5] = 'int32':state	[返回的状态 0成功  1失败]
	}
--]]
s2c.ITEM_RESP_USE_WE_CHAT_ITEM = 518

--[[
	[1] = {--ResPreEnterNewWorld
		[1] = 'string':roomId	[ 战斗ID]
		[2] = 'string':fightServerHost	[ 战斗服务器地址]
		[3] = 'int32':fightServerPort	[ 战斗服务器端口]
		[4] = 'int32':roomType	[大世界类型]
	}
--]]
s2c.NEW_WORLD_RES_PRE_ENTER_NEW_WORLD = 6800

--[[
	[1] = {--ChatMsg
		[1] = 'int32':time	[禁言截止时间]
	}
--]]
s2c.CHAT_CHAT = 2305

--[[
	[1] = {--ResStopStronghold
		[1] = {--Stronghold
			[1] = 'int32':id
			[2] = 'int32':state
			[3] = 'int64':startTime
			[4] = 'int64':endTime
			[5] = 'int32':useSupTimes
			[6] = 'int32':progress
			[7] = {--repeated Event
				[1] = 'int32':id
				[2] = 'int32':state
				[3] = 'int64':startTime
			},
			[8] = {--repeated Role
				[1] = 'int32':roleId
			},
			[9] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
			[10] = {--repeated SupportRole
				[1] = 'int64':playerId
				[2] = 'string':playerName
				[3] = 'int64':startTime
				[4] = 'int32':times
				[5] = {--Role
					[1] = 'int32':roleId
				},
				[6] = {--repeated Buff
					[1] = 'int32':buffId
					[2] = 'int32':buffLv
				},
			},
		},
	}
--]]
s2c.HANGUP_ACT_RES_STOP_STRONGHOLD = 9013

--[[
	[1] = {--RedPacket
		[1] = {--RedPacketDetailInfo
			[1] = 'int32':id	[ 红包id]
			[2] = 'string':blessing	[祝福语]
			[3] = 'int32':count	[ 红包数量]
			[4] = 'int32':senderId	[ 发送者id]
			[5] = 'int64':createTime	[ 发送者id]
			[6] = 'string':senderName	[ 发送者名字]
			[7] = 'int32':moneyTempId	[ 发送者icon]
			[8] = {--repeated RedPackageRecord
				[1] = 'string':playerId	[ 领取角色id]
				[2] = 'string':playerName	[ 领取角色名]
				[3] = 'int32':openCount	[ 领取数量]
				[4] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
				[5] = 'int32':portraitCid	[ 头像CID]
				[6] = 'int32':portraitFrameCid	[ 头像框CID]
				[7] = 'int32':createTime	[ 抢红包时间]
			},
			[9] = 'int32':status	[ 1 抢红包 2查看红包]
			[10] = 'int32':senderLeaderCid	[ 发送者英雄CID(队长)    // 发送者英雄CID(队长)]
			[11] = 'int32':senderPortraitCid	[ 发送者头像CID]
			[12] = 'int32':senderPortraitFrameCid	[ 发送者头像框CID]
		},
	}
--]]
s2c.UNION_RED_PACKET = 6661

--[[
	[1] = {--RespTrainMaxtriPrize
		[1] = 'int32':index	[ 奖励索引]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.UNION_RESP_TRAIN_MAXTRI_PRIZE = 6672

--[[
	[1] = {--RespSelfTrainMaxtriPrize
		[1] = 'int32':index	[ 奖励索引]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.UNION_RESP_SELF_TRAIN_MAXTRI_PRIZE = 6673

--[[
	[1] = {--UpdateRoleMood
		[1] = {--repeated RoleMoodInfo
			[1] = 'string':roleId
			[2] = 'int32':mood
		},
	}
--]]
s2c.ROLE_UPDATE_ROLE_MOOD = 1286

--[[
	[1] = {--RespWirteUnionReCall
	}
--]]
s2c.UNION_RESP_WIRTE_UNION_RE_CALL = 6674

--[[
	[1] = {--ResReverseTenWindow
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY2_RES_REVERSE_TEN_WINDOW = 9401

--[[
	[1] = {--RspEndlessCloisterInfo
		[1] = {--EndlessCloisterInfo
			[1] = 'int32':step	[活动阶段(0-准备期;1-进行期;2-结算期)    //活动阶段(0-准备期;1-进行期;2-结算期)]
			[2] = 'int32':historyBest	[历史最佳成绩(层)    //历史最佳成绩(层)]
			[3] = 'int32':todayBest	[今日最佳成绩(层)    //今日最佳成绩(层)]
			[4] = 'int32':todayCostTime	[今日总耗时(秒)    //今日总耗时(秒)]
			[5] = 'int32':nextStepTime	[进入下阶段的具体时刻(秒)    //进入下阶段的具体时刻(秒)]
			[6] = 'int32':curStage	[当前层id]
			[7] = 'int32':nonStopStage	[可直通的层数]
			[8] = {--StageHeroHealth
				[1] = {--repeated SingleHeroHealth
					[1] = 'int32':heroCid	[英雄id]
					[2] = 'int32':health	[万分比血量]
				},
			},
		},
	}
--]]
s2c.ENDLESS_CLOISTER_RSP_ENDLESS_CLOISTER_INFO = 5377

--[[
	[1] = {--RespClubWishTreeInfo
		[1] = {--ClubTreeInfo
			[1] = 'int32':id	[当前等级id]
			[2] = 'int32':exp	[当前等级经验]
			[3] = 'int32':submitTimes	[今日提交材料次数]
			[4] = 'int32':expLimit	[今日可提交的最多经验值]
		},
	}
--]]
s2c.ANNIVERSARY2ND_RESP_CLUB_WISH_TREE_INFO = 9231

--[[
	[1] = {--ReceiveSupply
		[1] = 'int32':id	[ 补给id]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.UNION_RECEIVE_SUPPLY = 6658

--[[
	[1] = {--RespNeptune2ndHalfMap
		[1] = 'int32':map	[地图]
	}
--]]
s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_MAP = 7707

--[[
	[1] = {--RespApplyInfo
		[1] = {--repeated ApplyInfo
			[1] = 'int32':playerId	[ 玩家ID]
			[2] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
			[3] = 'string':name	[ 名字]
			[4] = 'int32':fightPower	[ 战力]
			[5] = 'int32':lvl	[ 等级]
			[6] = 'int64':lastLoginTime	[ 最后登录时间]
			[7] = 'bool':online	[ 是否在线]
			[8] = 'int32':portraitCid	[ 头像CID]
			[9] = 'int32':portraitFrameCid	[ 头像框CID]
			[10] = {--ChangeType(enum)
				'v4':ChangeType
			},
		},
	}
--]]
s2c.UNION_RESP_APPLY_INFO = 6667

--[[
	[1] = {--RespEntranceEventChoices
		[1] = 'int32':datingType	[1]
		[2] = 'bool':first	[是否首次进入本段剧本]
	}
--]]
s2c.EXTRA_DATING_RESP_ENTRANCE_EVENT_CHOICES = 5634

--[[
	[1] = {--RespAssistanceFlop
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':count	[翻牌次数]
		[3] = 'bool':open	[是否打开下一轮]
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_RESP_ASSISTANCE_FLOP = 5212

--[[
	[1] = {--RespJuNaiInvasionInfo
		[1] = 'int32':id	[ 配置表id]
		[2] = 'int32':type	[1 不能攻打 2:可以攻打]
		[3] = 'int32':showTime	[展示的时间]
		[4] = 'repeated int32':buffIds	[buff信息]
		[5] = 'int32':morale	[ 配置表id]
	}
--]]
s2c.JU_NAI_INVASION_RESP_JU_NAI_INVASION_INFO = 9101

--[[
	[1] = {--RespUnionMember
		[1] = {--repeated UnionMember
			[1] = 'int32':playerId	[ 玩家ID]
			[2] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
			[3] = 'string':name	[ 名字]
			[4] = 'int32':fightPower	[ 战力]
			[5] = 'int32':lvl	[ 等级]
			[6] = 'int64':lastLoginTime	[ 最后登录时间]
			[7] = 'bool':online	[ 是否在线]
			[8] = 'int32':portraitCid	[ 头像CID]
			[9] = 'int32':portraitFrameCid	[ 头像框CID]
			[10] = 'int32':degree	[职位]
			[11] = 'int32':weekContribution	[ 周贡献]
			[12] = 'int32':allContribution	[ 全部贡献]
			[13] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[14] = 'int64':joinTime	[ 加入时间]
			[15] = 'repeated int32':groupGiftIds	[团购礼包id]
		},
	}
--]]
s2c.UNION_RESP_UNION_MEMBER = 6666

--[[
	[1] = {--RspRefreshLadderCardCount
		[1] = {--repeated RspUsingCount
			[1] = 'int32':itemCid	[道具cid]
			[2] = 'int32':count	[次数]
		},
	}
--]]
s2c.LADDER_RSP_REFRESH_LADDER_CARD_COUNT = 8313

--[[
	[1] = {--PushDuanWuActInfo
		[1] = 'int64':supAwardTime	[获取支援奖励的时间]
		[2] = 'int64':supAwardTimes	[获取支援奖励的次数]
		[3] = 'int32':refreshTimes	[已经使用的刷新次数]
		[4] = 'int64':refreshTime	[上次刷新的时间]
		[5] = 'int32':completeStronghold	[完成的据点数量]
		[6] = 'int32':useSupTimes
	}
--]]
s2c.HANGUP_ACT_PUSH_DUAN_WU_ACT_INFO = 9015

--[[
	[1] = {--ResStartExploreMsg
		[1] = {--Stronghold
			[1] = 'int32':id
			[2] = 'int32':state
			[3] = 'int64':startTime
			[4] = 'int64':endTime
			[5] = 'int32':useSupTimes
			[6] = 'int32':progress
			[7] = {--repeated Event
				[1] = 'int32':id
				[2] = 'int32':state
				[3] = 'int64':startTime
			},
			[8] = {--repeated Role
				[1] = 'int32':roleId
			},
			[9] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
			[10] = {--repeated SupportRole
				[1] = 'int64':playerId
				[2] = 'string':playerName
				[3] = 'int64':startTime
				[4] = 'int32':times
				[5] = {--Role
					[1] = 'int32':roleId
				},
				[6] = {--repeated Buff
					[1] = 'int32':buffId
					[2] = 'int32':buffLv
				},
			},
		},
		[2] = 'int32':useSupTimes
	}
--]]
s2c.HANGUP_ACT_RES_START_EXPLORE = 9003

--[[
	[1] = {--RespGetUnionRank
		[1] = {--repeated UnionDamage
			[1] = 'int32':rank	[排名]
			[2] = 'int32':unionId	[玩家id]
			[3] = 'int64':damage	[伤害列表]
			[4] = 'string':unionName	[社团名称]
		},
		[2] = {--UnionDamage
			[1] = 'int32':rank	[排名]
			[2] = 'int32':unionId	[玩家id]
			[3] = 'int64':damage	[伤害列表]
			[4] = 'string':unionName	[社团名称]
		},
		[3] = 'int32':type	[ 客户端传的类型]
		[4] = 'int32':damage	[ 伤害]
	}
--]]
s2c.JU_NAI_INVASION_RESP_GET_UNION_RANK = 9107

--[[
	[1] = {--OfficeHiddenRewardMsg
		[1] = {--GridHiddenRewardMsg
			[1] = 'int32':eventCid	[ 事件cid]
			[2] = {--ItemList
				[1] = {--repeated ItemInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[ 实例ID]
					[3] = 'int32':cid	[ 配置ID]
					[4] = 'int64':num	[ 数量]
					[5] = 'int32':outTime	[过期时间]
				},
				[2] = {--repeated EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
				[3] = {--repeated DressInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[ 实例ID]
					[3] = 'int32':cid	[ 配置ID]
					[4] = 'string':roleId	[ 装备精灵ID]
					[5] = 'int32':outTime	[过期时间]
				},
				[4] = {--repeated NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
				[5] = {--repeated GemInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[宝石id]
					[3] = 'int32':cid	[宝石cid]
					[4] = 'int32':heroId	[英雄id]
					[5] = 'repeated int32':randSkill	[随机技能]
					[6] = {--GemRandSkill
						[1] = 'int32':originalSkill	[ 原始id]
						[2] = 'int32':newSkill	[ 新id]
					},
				},
				[6] = {--repeated TreasureInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[宝物id]
					[3] = 'int32':cid	[宝物cid]
					[4] = 'int32':star	[宝物星级]
				},
				[7] = {--repeated ExploreEquip
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[探索装备id]
					[3] = 'int32':cid	[探索装备cid]
					[4] = 'int32':level	[探索装备星级]
				},
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_HIDDEN_REWARD = 7227

--[[
	[1] = {--ResDissolveGroupTeam
		[1] = 'string':teamId
	}
--]]
s2c.RECHARGE_RES_DISSOLVE_GROUP_TEAM = 4382

--[[
	[1] = {--LockMsg
		[1] = 'bool':success	[操作是否成功]
		[2] = 'bool':isLock	[锁定/解锁,ture/false;]
		[3] = 'string':equipmentId	[灵装id]
	}
--]]
s2c.EQUIPMENT_LOCK = 2823

--[[
	[1] = {--LimitHeroDungeonMsg
		[1] = {--repeated LimitHeroInfo
			[1] = 'int32':limitId	[ 限定英雄id]
			[2] = {--HeroInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'int32':lvl	[ 等级]
				[5] = 'int64':exp	[ 经验]
				[6] = {--repeated AttributeInfo
					[1] = 'int32':type	[ 属性类型]
					[2] = 'int32':val	[ 属性值]
				},
				[7] = 'int32':advancedLvl	[ 突破等级]
				[8] = {--repeated HeroEquipment
					[1] = 'int32':position	[装备位置]
					[2] = 'string':equipmentId	[装备id]
					[3] = {--EquipmentInfo
						[1] = {--ChangeType(enum)
							'v4':ChangeType
						},
						[2] = 'string':id	[灵装id]
						[3] = 'int32':cid	[灵装cid]
						[4] = 'int32':level	[灵装等级]
						[5] = 'int32':exp	[灵装经验值]
						[6] = 'string':heroId	[英雄id]
						[7] = 'int32':position	[装备位置]
						[8] = {--repeated SpecialAttr
							[1] = 'int32':cid	[配置id]
							[2] = 'int32':value	[属性值]
							[3] = 'int32':index	[属性服务器顺序]
						},
						[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
						[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
						[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
						[12] = 'int32':outTime	[过期时间]
						[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
						[14] = 'int32':star	[额外星数]
						[15] = 'int32':stage	[阶段]
						[16] = 'int32':num	[数量]
						[17] = 'int32':step	[质点阶级]
					},
				},
				[9] = 'bool':helpFight	[ 助战]
				[10] = 'int32':angelLvl	[ 天使等级]
				[11] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[12] = 'int32':useSkillPiont	[ 已使用技能点]
				[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
				[14] = 'int32':provide	[出处]
				[15] = 'int32':fightPower	[ 战斗力]
				[16] = 'int32':skinCid	[ 皮肤cid]
				[17] = {--repeated SkillStrategy
					[1] = 'int32':id
					[2] = 'string':name
					[3] = 'int32':alreadyUseSkillPiont
					[4] = {--repeated AngeSkillInfo
						[1] = 'int32':type
						[2] = 'int32':pos
						[3] = 'int32':lvl
					},
					[5] = {--repeated PassiveSkillInfo
						[1] = 'int32':pos
						[2] = 'int32':skillId
					},
				},
				[18] = 'int32':useSkillStrategy
				[19] = {--repeated CrystalInfo
					[1] = 'int32':rarity
					[2] = 'int32':gridId
				},
				[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
				[21] = {--repeated EuqipFetterInfo
					[1] = 'int32':index
					[2] = {--NewEquipmentInfo
						[1] = {--ChangeType(enum)
							'v4':ChangeType
						},
						[2] = 'string':id	[新装备id]
						[3] = 'int32':cid	[新装备cid]
						[4] = 'int32':stage	[新装备阶段等级]
						[5] = 'int32':level	[新装备等级]
						[6] = 'string':heroId	[英雄id]
						[7] = 'int32':position	[装备位置]
					},
				},
				[22] = {--HeroStatus(enum)
					'v4':HeroStatus
				},
				[23] = 'int32':deadLine
				[24] = {--repeated GemInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[宝石id]
					[3] = 'int32':cid	[宝石cid]
					[4] = 'int32':heroId	[英雄id]
					[5] = 'repeated int32':randSkill	[随机技能]
					[6] = {--GemRandSkill
						[1] = 'int32':originalSkill	[ 原始id]
						[2] = 'int32':newSkill	[ 新id]
					},
				},
				[25] = 'int32':skinCidTemp	[ 皮肤cid]
				[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
				[27] = 'int32':breakLv	[突破等级]
			},
		},
		[2] = 'int32':leveId	[关卡id]
		[3] = {--FormationInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':type	[ 阵型类型]
			[3] = 'int32':status	[ 阵型状态 0 未启用 1 启用]
			[4] = 'repeated string':stance	[ 阵型英雄]
		},
	}
--]]
s2c.DUNGEON_LIMIT_HERO_DUNGEON = 1808

--[[
	[1] = {--GetLevelInfo
		[1] = {--LevelInfos
			[1] = {--repeated LevelInfo
				[1] = 'int32':cid	[关卡cid]
				[2] = 'repeated int32':goals	[达成目标的下标]
				[3] = 'int32':fightCount	[战斗次数]
				[4] = 'bool':win	[是否胜利]
				[5] = 'int32':buyCount	[购买次数]
				[6] = 'int32':freeCount	[ 周卡或者是月卡的免费次数]
			},
		},
		[2] = {--RefreshDungeonLevelGroupList
			[1] = {--repeated DungeonLevelGroupInfo
				[1] = 'string':id	[id]
				[2] = 'int32':cid	[cid]
				[3] = 'int32':fightCount	[战斗次数]
				[4] = 'int32':buyCount	[购买次数]
				[5] = {--repeated ListMap
					[1] = 'int32':key
					[2] = 'repeated int32':list
				},
				[6] = 'int32':mainLineCid	[当前关卡标记]
				[7] = 'int32':maxMainLine	[最大关卡进度]
			},
		},
	}
--]]
s2c.DUNGEON_GET_LEVEL_INFO = 1796

--[[
	[1] = {--RespNodePrizeMsg
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ODEUM_RESP_NODE_PRIZE = 6504

--[[
	[1] = {--ResGiftLoginCheck
	}
--]]
s2c.RECHARGE_RES_GIFT_LOGIN_CHECK = 4386

--[[
	[1] = {--ResGetAllAfkTaskAward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EXPLORE_RES_GET_ALL_AFK_TASK_AWARD = 7844

--[[
	[1] = {--ResRemouldedGem
		[1] = {--GemInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[宝石id]
			[3] = 'int32':cid	[宝石cid]
			[4] = 'int32':heroId	[英雄id]
			[5] = 'repeated int32':randSkill	[随机技能]
			[6] = {--GemRandSkill
				[1] = 'int32':originalSkill	[ 原始id]
				[2] = 'int32':newSkill	[ 新id]
			},
		},
	}
--]]
s2c.EQUIPMENT_RES_REMOULDED_GEM = 2837

--[[
	[1] = {--RespStartCatExplore
		[1] = 'int32':taskId	[任务id]
		[2] = 'int32':etime	[结算时间]
	}
--]]
s2c.ACTIVITY_RESP_START_CAT_EXPLORE = 5224

--[[
	[1] = {--reserveRemind
		[1] = 'int32':datingRuleCid	[精灵id]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[3] = 'int32':outTime	[过期时间]
	}
--]]
s2c.DATINGRESERVE_REMIND = 1554

--[[
	[1] = {--RespJoinTeam
		[1] = {--TeamInfo
			[1] = 'string':teamId	[ 队伍ID]
			[2] = 'int32':leaderPid	[ 队长PID]
			[3] = {--repeated TeamMember
				[1] = 'int32':pid	[ 队员PID]
				[2] = 'int32':status	[ 队员状态	  1:空闲 2:准备中]
				[3] = 'int32':heroCid	[ 英雄]
				[4] = 'string':name	[ 昵称]
				[5] = 'int32':plv	[ 玩家等级]
				[6] = 'int32':skinCid	[ 英雄皮肤]
				[7] = 'int32':heroLevel	[英雄等级]
				[8] = 'int32':heroQuality	[英雄品质]
				[9] = 'int32':titleId	[ 称号]
				[10] = 'string':unionName	[ 公会名字]
				[11] = 'int32':fightPower	[ 战斗力]
			},
			[4] = 'int32':status	[ 队伍状态 1:关闭自动匹配 2:开启自动匹配]
			[5] = 'int32':teamType	[请求的类型]
			[6] = 'int32':battleId	[战斗的id]
			[7] = 'int32':show_type	[0,显示所有;1,显示给好友;2,不显示]
			[8] = 'int32':level_limit	[等级限制]
		},
	}
--]]
s2c.TEAM_RESP_JOIN_TEAM = 5894

--[[
	[1] = {--RespChangeTeamStatus
		[1] = 'int32':status	[ 1:关闭自动匹配 2:开启自动匹配]
	}
--]]
s2c.TEAM_RESP_CHANGE_TEAM_STATUS = 5890

--[[
	[1] = {--RespIntoPanel
	}
--]]
s2c.SHARE_RESP_INTO_PANEL = 6104

--[[
	[1] = {--RespNeptune2ndHalfBuffChosen
		[1] = {--repeated Neptune2ndHalfIntTable
			[1] = 'int32':key	[键]
			[2] = 'int32':value	[值]
		},
		[2] = {--repeated Neptune2ndHalfChosenBuff
			[1] = 'int32':liftId	[层数id]
			[2] = 'repeated int32':buff	[待选择的buff]
		},
	}
--]]
s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_BUFF_CHOSEN = 7705

--[[
	[1] = {--RespMatchTeam
	}
--]]
s2c.TEAM_RESP_MATCH_TEAM = 5892

--[[
	[1] = {--RespGMCallBack
	}
--]]
s2c.CHAT_RESP_GMCALL_BACK = 2312

--[[
	[1] = {--RespCancelMatch
		[1] = 'int32':type	[ 1:主动取消 2:匹配超时]
	}
--]]
s2c.TEAM_RESP_CANCEL_MATCH = 5895

--[[
	[1] = {--RespDispatchExhaustions
		[1] = {--repeated HeroDispatchExhaustion
			[1] = 'int32':hero
			[2] = 'int32':exhaustion
			[3] = 'int32':nextTime	[ 下一次恢复时间点]
		},
	}
--]]
s2c.HERO_DISPATCH_RESP_DISPATCH_EXHAUSTIONS = 8605

--[[
	[1] = {--RespChangeMenberStatus
	}
--]]
s2c.TEAM_RESP_CHANGE_MENBER_STATUS = 5897

--[[
	[1] = {--RespChangeHero
	}
--]]
s2c.TEAM_RESP_CHANGE_HERO = 5896

--[[
	[1] = {--RespLangugeSign
		[1] = 'int32':langugeSign	[ 1:中文版  2:英文版]
	}
--]]
s2c.SIGN_RESP_LANGUGE_SIGN = 5162

--[[
	[1] = {--RespAITrigger
	}
--]]
s2c.DATING_RESP_AITRIGGER = 1560

--[[
	[1] = {--RespGetHangUpAward
		[1] = 'int32':activityId	[活动id]
		[2] = 'int32':hangUpEventId	[事件id]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_RESP_GET_HANG_UP_AWARD = 5170

--[[
	[1] = {--ResExploreTaskPlan
		[1] = {--repeated AfkTaskPlan
			[1] = 'int32':taskId	[任务id]
			[2] = 'repeated int32':heroId	[执行任务的精灵id]
		},
	}
--]]
s2c.EXPLORE_RES_EXPLORE_TASK_PLAN = 7843

--[[
	[1] = {--RespCreateTeam
		[1] = {--TeamInfo
			[1] = 'string':teamId	[ 队伍ID]
			[2] = 'int32':leaderPid	[ 队长PID]
			[3] = {--repeated TeamMember
				[1] = 'int32':pid	[ 队员PID]
				[2] = 'int32':status	[ 队员状态	  1:空闲 2:准备中]
				[3] = 'int32':heroCid	[ 英雄]
				[4] = 'string':name	[ 昵称]
				[5] = 'int32':plv	[ 玩家等级]
				[6] = 'int32':skinCid	[ 英雄皮肤]
				[7] = 'int32':heroLevel	[英雄等级]
				[8] = 'int32':heroQuality	[英雄品质]
				[9] = 'int32':titleId	[ 称号]
				[10] = 'string':unionName	[ 公会名字]
				[11] = 'int32':fightPower	[ 战斗力]
			},
			[4] = 'int32':status	[ 队伍状态 1:关闭自动匹配 2:开启自动匹配]
			[5] = 'int32':teamType	[请求的类型]
			[6] = 'int32':battleId	[战斗的id]
			[7] = 'int32':show_type	[0,显示所有;1,显示给好友;2,不显示]
			[8] = 'int32':level_limit	[等级限制]
		},
	}
--]]
s2c.TEAM_RESP_CREATE_TEAM = 5889

--[[
	[1] = {--ResComposeFirecracker
	}
--]]
s2c.SPRING_FESTIVAL_RES_COMPOSE_FIRECRACKER = 6701

--[[
	[1] = {--RespSummon
		[1] = 'repeated int32':records	[抽卡记录]
	}
--]]
s2c.CHRISTMAS_RESP_SUMMON = 6604

--[[
	[1] = {--RespMatchRank
		[1] = 'int32':rank	[-1:就没有获得排名  其他:排名    //-1:就没有获得排名  其他:排名]
	}
--]]
s2c.TEAM_RESP_MATCH_RANK = 5903

--[[
	[1] = {--ResChasmReport
		[1] = 'int32':pid	[ 被举报的id]
		[2] = 'string':name	[被举报名字]
	}
--]]
s2c.TEAM_RES_CHASM_REPORT = 5900

--[[
	[1] = {--HeroExpInfo
		[1] = 'string':id	[ 实例ID]
		[2] = 'int64':exp	[ 经验]
		[3] = 'int32':cid
	}
--]]
s2c.HERO_HERO_EXP_INFO = 1029

--[[
	[1] = {--RespAllTeamInfo
		[1] = {--repeated TeamInfo
			[1] = 'string':teamId	[ 队伍ID]
			[2] = 'int32':leaderPid	[ 队长PID]
			[3] = {--repeated TeamMember
				[1] = 'int32':pid	[ 队员PID]
				[2] = 'int32':status	[ 队员状态	  1:空闲 2:准备中]
				[3] = 'int32':heroCid	[ 英雄]
				[4] = 'string':name	[ 昵称]
				[5] = 'int32':plv	[ 玩家等级]
				[6] = 'int32':skinCid	[ 英雄皮肤]
				[7] = 'int32':heroLevel	[英雄等级]
				[8] = 'int32':heroQuality	[英雄品质]
				[9] = 'int32':titleId	[ 称号]
				[10] = 'string':unionName	[ 公会名字]
				[11] = 'int32':fightPower	[ 战斗力]
			},
			[4] = 'int32':status	[ 队伍状态 1:关闭自动匹配 2:开启自动匹配]
			[5] = 'int32':teamType	[请求的类型]
			[6] = 'int32':battleId	[战斗的id]
			[7] = 'int32':show_type	[0,显示所有;1,显示给好友;2,不显示]
			[8] = 'int32':level_limit	[等级限制]
		},
		[2] = 'int32':teamType
		[3] = 'int32':nextTime	[下一次请求的时间]
	}
--]]
s2c.TEAM_RESP_ALL_TEAM_INFO = 5901

--[[
	[1] = {--RespSetTeamShowType
		[3] = 'int32':showType	[0,显示所有;1,显示给好友;2,不显示]
	}
--]]
s2c.TEAM_RESP_SET_TEAM_SHOW_TYPE = 5902

--[[
	[1] = {--RespGiveUpJob
		[1] = {--JobInfo
			[1] = 'int32':buildingId	[建筑ID]
			[2] = 'int32':type	[白天还是黑夜]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[5] = 'int32':jobId	[兼职ID]
			[6] = 'int32':jobType	[兼职任务状态]
			[7] = 'int32':etime	[兼职任务结束时间]
		},
		[2] = {--JobInfoList
			[1] = 'int32':buildingId	[建筑ID]
			[2] = {--repeated JobInfo
				[1] = 'int32':buildingId	[建筑ID]
				[2] = 'int32':type	[白天还是黑夜]
				[3] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
				[4] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
				[5] = 'int32':jobId	[兼职ID]
				[6] = 'int32':jobType	[兼职任务状态]
				[7] = 'int32':etime	[兼职任务结束时间]
			},
			[3] = 'int32':level	[建筑兼职等级]
			[4] = 'int64':exp	[建筑兼职经验值]
		},
	}
--]]
s2c.NEW_BUILDING_RESP_GIVE_UP_JOB = 2079

--[[
	[1] = {--ResReverseTenReward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY2_RES_REVERSE_TEN_REWARD = 9402

--[[
	[1] = {--ResResetQuit
	}
--]]
s2c.DETECTIVE_RES_RESET_QUIT = 8915

--[[
	[1] = {--ResBulletInfo
		[1] = 'int32':barrageId	[类型标识]
		[2] = 'int32':lastSendTime
	}
--]]
s2c.CHAT_RES_BULLET_INFO = 2317

--[[
	[1] = {--RespKurumiHistoryInfo
		[1] = 'int32':camp	[阵营]
		[2] = 'int32':stage	[阶段]
		[3] = 'int32':stageEnd	[阶段通用结束时间]
		[4] = {--repeated KurumiHistoryCity
			[1] = 'int32':id	[城市id]
			[2] = 'int32':dungeon	[当前关卡]
			[3] = 'bool':resOpen	[是否解锁资源]
			[4] = 'int32':resCount	[资源可用次数]
			[5] = 'int32':resUpTime	[下次资源增加时间]
			[6] = 'bool':invaded	[是否入侵]
			[7] = 'int32':invadedEnd	[入侵结束时间]
			[8] = 'repeated int32':invadedCamp	[入侵阵营]
			[9] = 'int32':resStartTime	[资源开始时间]
			[10] = 'int32':fightTime	[战斗时间]
			[11] = 'int32':score	[贡献积分]
			[12] = 'bool':pass	[是否通关]
			[13] = 'bool':dunPass	[是否已通过关卡]
		},
	}
--]]
s2c.ACTIVITY_RESP_KURUMI_HISTORY_INFO = 5163

--[[
	[1] = {--StageHeroHealth
		[1] = {--repeated SingleHeroHealth
			[1] = 'int32':heroCid	[英雄id]
			[2] = 'int32':health	[万分比血量]
		},
	}
--]]
s2c.ENDLESS_CLOISTER_STAGE_HERO_HEALTH = 5381

--[[
	[1] = {--RespSubmitTaskList
		[1] = {--repeated ResultSubmitTask
			[1] = 'string':taskDbId
			[2] = 'int32':taskCid
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.TASK_RESP_SUBMIT_TASK_LIST = 4096

--[[
	[1] = {--RespGetSystemTitleInfo
		[1] = {--repeated SystemTitleInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':titleId	[配置id]
			[3] = 'int32':effectTime	[过期时间]
			[4] = 'bool':isEquip	[是否已装备]
			[5] = 'int32':createTime	[得到时间]
		},
	}
--]]
s2c.SYSTEM_TITLE_RESP_GET_SYSTEM_TITLE_INFO = 8150

--[[
	[1] = {--RespYearLottoInfo
		[1] = {--repeated RoundInfo
			[1] = 'int32':round
			[2] = 'bool':joinStatus	[ 报名状态 false 可能是没有参与也可能是数据被清理了]
			[3] = 'int32':joinNum	[ 报名人数]
		},
		[2] = 'string':address	[地址信息json]
		[3] = 'int32':realPrize	[实物奖励]
		[4] = 'int32':realRound	[实物奖励轮次]
	}
--]]
s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_INFO = 8701

--[[
	[1] = {--ResAntiAddictionInfo
		[1] = 'int32':status	[状态值: 0-未认证 1-认证未成年 2-认证已成年    //状态值: 0-未认证 1-认证未成年 2-认证已成年]
		[2] = 'int32':time	[累积在线时长(小时)    //累积在线时长(小时)]
	}
--]]
s2c.PLAYER_RES_ANTI_ADDICTION_INFO = 283

--[[
	[1] = {--RespEquipPortrait
		[1] = 'int32':portraitType	[1头像 2头像框 3气泡框]
		[2] = 'int32':equipCid	[当前的头像id]
		[3] = 'int32':changCid	[卸下来的头像id]
	}
--]]
s2c.PORTRAIL_RESP_EQUIP_PORTRAIT = 7002

--[[
	[1] = {--UnlockActionChange
		[2] = {--UnlockActionMsg
			[1] = 'int32':roleId	[看板娘ID]
			[2] = 'repeated int32':actionId	[已解锁动作id]
		},
	}
--]]
s2c.ARUNLOCK_ACTION_CHANGE = 9303

--[[
	[1] = {--ResComposeGem
		[1] = 'int32':id	[合成id]
		[2] = {--GemInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[宝石id]
			[3] = 'int32':cid	[宝石cid]
			[4] = 'int32':heroId	[英雄id]
			[5] = 'repeated int32':randSkill	[随机技能]
			[6] = {--GemRandSkill
				[1] = 'int32':originalSkill	[ 原始id]
				[2] = 'int32':newSkill	[ 新id]
			},
		},
	}
--]]
s2c.EQUIPMENT_RES_COMPOSE_GEM = 2834

--[[
	[1] = {--RespPrise
		[1] = 'bool':success	[成功:true]
	}
--]]
s2c.COMMENT_RESP_PRISE = 4003

--[[
	[1] = {--GetComposeInfo
		[1] = {--repeated ComposeInfo
			[1] = 'int32':cid	[合成配置id]
			[2] = 'int32':finishTime	[完成时间]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'int32':costTime	[消耗时间]
		},
		[2] = 'int32':freeNum	[一键加速的次数]
	}
--]]
s2c.SUMMON_GET_COMPOSE_INFO = 3333

--[[
	[1] = {--ResNoobAward
		[1] = {--SummonNoob
			[1] = 'bool':noobStatus	[ 功能是否可用]
			[2] = 'int32':endTime	[ 结束时间]
			[3] = 'int32':summonCount	[ 召唤次数]
			[4] = 'int32':awardState	[ 领奖状态,0 条件未达 1 可领取 2 已领取]
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SUMMON_RES_NOOB_AWARD = 3340

--[[
	[1] = {--ResReadSpringWish
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SPRING_WISH_RES_READ_SPRING_WISH = 7502

--[[
	[1] = {--ResultSubmitShare
		[1] = 'int32':id	[提交的分享ID]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SHARE_RESULT_SUBMIT_SHARE = 6102

--[[
	[1] = {--EquipmentInfo
		[1] = {--ChangeType(enum)
			'v4':ChangeType
		},
		[2] = 'string':id	[灵装id]
		[3] = 'int32':cid	[灵装cid]
		[4] = 'int32':level	[灵装等级]
		[5] = 'int32':exp	[灵装经验值]
		[6] = 'string':heroId	[英雄id]
		[7] = 'int32':position	[装备位置]
		[8] = {--repeated SpecialAttr
			[1] = 'int32':cid	[配置id]
			[2] = 'int32':value	[属性值]
			[3] = 'int32':index	[属性服务器顺序]
		},
		[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
		[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
		[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
		[12] = 'int32':outTime	[过期时间]
		[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
		[14] = 'int32':star	[额外星数]
		[15] = 'int32':stage	[阶段]
		[16] = 'int32':num	[数量]
		[17] = 'int32':step	[质点阶级]
	}
--]]
s2c.ITEM_EQUIPMENT_INFO = 2822

--[[
	[1] = {--ResAllManaInfo
		[1] = {--repeated ManaBagInfo
			[1] = 'int32':id
			[2] = 'int32':level
		},
		[2] = {--repeated ManaEquipInfo
			[1] = 'int32':id
			[2] = 'int32':pos
		},
	}
--]]
s2c.MANA_RESONANCE_RES_ALL_MANA_INFO = 7603

--[[
	[1] = {--TaskEventDiscoverMsg
		[1] = 'int32':x	[ x位置]
		[2] = 'int32':y	[ y位置]
		[3] = 'bool':add	[ true为新增,否则为移除]
	}
--]]
s2c.QLIPHOTH_TASK_EVENT_DISCOVER = 6224

--[[
	[1] = {--respPhoneChat
		[1] = 'string':msg	[返回的消息]
		[2] = 'int32':roleId	[精灵id]
		[3] = 'int32':datingType	[返回类型 手机约会类型   自由聊天type=1  视频聊天 type=2]
	}
--]]
s2c.DATINGRESP_PHONE_CHAT = 1555

--[[
	[1] = {--AddNewElement
		[1] = {--repeated Elements
			[1] = 'int32':type	[类型]
			[2] = {--repeated Element
				[1] = 'int32':cid	[cid]
				[2] = 'int32':reward	[领奖状态 0不可领取  1可领取 2 已领取]
			},
			[3] = 'int32':trophy	[奖杯数]
			[4] = 'bool':scan	[是否可以浏览]
		},
		[2] = 'int32':rank	[排名]
		[3] = 'int32':totleTrophy	[总奖杯数]
	}
--]]
s2c.ELEMENT_COLLECT_ADD_NEW_ELEMENT = 4866

--[[
	[1] = {--RespGetZZAllRankMsg
		[1] = {--repeated ZZRank
			[1] = 'string':playerName	[ 角色名]
			[2] = 'int32':serverCount	[贡献点值]
			[3] = 'int32':ranking	[排名]
		},
	}
--]]
s2c.ACTIVITY_RESP_GET_ZZALL_RANK = 5138

--[[
	[1] = {--RespNeptune2ndHalfLiftRefresh
		[1] = {--Neptune2ndHalfLift
			[1] = {--Neptune2ndHalfLiftBase
				[1] = 'int32':id	[城市id]
				[2] = 'int32':round	[爬塔轮次,0则未开启]
				[3] = 'int32':dungeon	[当前关卡]
				[4] = 'int32':startTime	[轮次开始时间]
				[5] = 'int32':endTime	[轮次结束时间]
				[6] = 'int32':roundScore	[轮次得分]
				[7] = 'int32':totalScore	[总得分]
				[8] = {--repeated Neptune2ndHalfIntTable
					[1] = 'int32':key	[键]
					[2] = 'int32':value	[值]
				},
				[9] = 'int32':bestTime	[最佳时间]
			},
			[2] = {--repeated Neptune2ndHalfIntTable
				[1] = 'int32':key	[键]
				[2] = 'int32':value	[值]
			},
			[3] = {--repeated Neptune2ndHalfIntTable
				[1] = 'int32':key	[键]
				[2] = 'int32':value	[值]
			},
			[4] = 'int32':battleCount	[初始最大战斗次数]
			[5] = {--repeated Neptune2ndHalfIntTable
				[1] = 'int32':key	[键]
				[2] = 'int32':value	[值]
			},
			[6] = 'repeated int32':roundBuff	[轮次主题buff]
			[7] = {--repeated Neptune2ndHalfChosenBuff
				[1] = 'int32':liftId	[层数id]
				[2] = 'repeated int32':buff	[待选择的buff]
			},
		},
	}
--]]
s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_LIFT_REFRESH = 7704

--[[
	[1] = {--HeroInfoList
		[1] = {--repeated HeroInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int64':exp	[ 经验]
			[6] = {--repeated AttributeInfo
				[1] = 'int32':type	[ 属性类型]
				[2] = 'int32':val	[ 属性值]
			},
			[7] = 'int32':advancedLvl	[ 突破等级]
			[8] = {--repeated HeroEquipment
				[1] = 'int32':position	[装备位置]
				[2] = 'string':equipmentId	[装备id]
				[3] = {--EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
			},
			[9] = 'bool':helpFight	[ 助战]
			[10] = 'int32':angelLvl	[ 天使等级]
			[11] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[12] = 'int32':useSkillPiont	[ 已使用技能点]
			[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
			[14] = 'int32':provide	[出处]
			[15] = 'int32':fightPower	[ 战斗力]
			[16] = 'int32':skinCid	[ 皮肤cid]
			[17] = {--repeated SkillStrategy
				[1] = 'int32':id
				[2] = 'string':name
				[3] = 'int32':alreadyUseSkillPiont
				[4] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[5] = {--repeated PassiveSkillInfo
					[1] = 'int32':pos
					[2] = 'int32':skillId
				},
			},
			[18] = 'int32':useSkillStrategy
			[19] = {--repeated CrystalInfo
				[1] = 'int32':rarity
				[2] = 'int32':gridId
			},
			[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
			[21] = {--repeated EuqipFetterInfo
				[1] = 'int32':index
				[2] = {--NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
			},
			[22] = {--HeroStatus(enum)
				'v4':HeroStatus
			},
			[23] = 'int32':deadLine
			[24] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[25] = 'int32':skinCidTemp	[ 皮肤cid]
			[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
			[27] = 'int32':breakLv	[突破等级]
		},
	}
--]]
s2c.HERO_HERO_INFO_LIST = 1025

--[[
	[1] = {--ResResultStatistics
		[1] = 'int32':cid	[卡池id]
		[2] = 'int32':count	[卡池次数]
		[3] = 'int32':startTime
		[4] = 'int32':endTime
		[5] = {--repeated SummonResultStatistics
			[1] = 'int32':id	[道具id]
			[2] = 'int32':num	[道具数量]
			[3] = 'int32':count	[抽取次数]
			[4] = 'int32':probability	[概率]
		},
	}
--]]
s2c.SUMMON_RES_RESULT_STATISTICS = 3346

--[[
	[1] = {--OpenPanelMsg
		[1] = 'int32':bossDungeonId	[boss关卡id]
		[2] = 'int64':serverContribution	[全服贡献值]
		[3] = {--repeated ContributionNodeMsg
			[1] = 'int32':contribution	[目标贡献度]
			[2] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
		[4] = 'int32':odeumType	[剧场类型 1限时灵波值活动 2常驻活动]
		[5] = 'int64':closeTime	[ 关闭时间]
		[6] = 'int32':status	[ 当前状态 0 关闭 1进行中 2 结算中]
		[7] = 'int32':lingbo	[不稳定灵波值]
		[8] = 'repeated int32':lingboGroup	[灵波组]
		[9] = 'int32':receiveStatus	[ 全服贡献度奖励领取状态 0未领取 1已领取]
		[10] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[11] = 'repeated int32':selfContriPrizeStatus	[ 个人贡献度领奖状态列表]
		[12] = 'bool':fightState	[是否通关过]
	}
--]]
s2c.ODEUM_OPEN_PANEL = 6501

--[[
	[1] = {--ResSimulateSummonInfo
		[1] = {--repeated SimulateSummon
			[1] = 'int32':cid
			[2] = 'int32':simulateSummonCount
			[3] = 'int32':sysSimulateSummonCount
			[4] = 'int32':exchangeCount
			[5] = {--repeated SimulateSummonRecord
				[1] = 'int32':order
				[2] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
				[3] = 'bool':isReceive
			},
		},
		[2] = 'int32':lastCid
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SUMMON_RES_SIMULATE_SUMMON_INFO = 3349

--[[
	[1] = {--RespHuntingDamageAward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--HuntingDamageAward
			[1] = 'int32':awardIndex	[奖励索引]
			[2] = 'int32':status	[领取状态,2 可领取,3 已领取]
		},
	}
--]]
s2c.HUNTING_DUNGEON_RESP_HUNTING_DAMAGE_AWARD = 8510

--[[
	[1] = {--ChristmasLevelRefresh
		[1] = {--ChristmasLevel
			[1] = 'int32':cid	[关卡cid]
			[2] = 'repeated int32':goals	[达成目标的下标]
			[3] = 'int32':fightCount	[战斗次数]
			[4] = 'bool':win	[是否胜利]
			[5] = 'int32':buyCount	[购买次数]
		},
	}
--]]
s2c.CHRISTMAS_CHRISTMAS_LEVEL_REFRESH = 6612

--[[
	[1] = {--OpenPanel
	}
--]]
s2c.CHRISTMAS_OPEN_PANEL = 6601

--[[
	[1] = {--RespScrollingInfo
		[1] = 'int32':scrollId	[  scroll表id]
		[2] = 'repeated string':params	[ 参数列表]
	}
--]]
s2c.CHAT_RESP_SCROLLING_INFO = 2314

--[[
	[1] = {--RedEnvelopeNotice
		[1] = {--repeated MailInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 邮件ID]
			[3] = 'int32':senderId	[ 发送者id]
			[4] = 'string':senderName	[ 发送者名字]
			[5] = 'int32':createTime	[ 创建时间]
			[6] = 'int32':modifiedTime	[ 邮件时间]
			[7] = 'int32':status	[ 状态]
			[8] = 'string':title	[ 邮件标题]
			[9] = 'string':body	[ 邮件正文]
			[10] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[11] = 'int32':mailType	[1是普通邮件,3是特殊邮件]
		},
	}
--]]
s2c.RED_ENVELOPE_RED_ENVELOPE_NOTICE = 7301

--[[
	[1] = {--DatingFail
		[1] = 'int32':datingRuleCid
	}
--]]
s2c.DATING_DATING_FAIL = 1551

--[[
	[1] = {--Summon
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--SummonNoob
			[1] = 'bool':noobStatus	[ 功能是否可用]
			[2] = 'int32':endTime	[ 结束时间]
			[3] = 'int32':summonCount	[ 召唤次数]
			[4] = 'int32':awardState	[ 领奖状态,0 条件未达 1 可领取 2 已领取]
		},
		[3] = 'repeated int32':activeId	[高级组队抽奖]
		[4] = 'int32':hotHeroSummonScore	[热点精灵召唤分数]
		[5] = 'int32':hotEquipSummonScore	[热点质点召唤分数]
		[6] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[7] = 'int32':id	[召唤id]
		[8] = {--FreeSummon
			[1] = 'int32':type	[召唤id]
			[2] = 'int32':nextFreeTime	[下一次召唤的时间]
			[3] = 'int32':summonNums	[召唤次数;]
		},
		[9] = {--FreeSummon
			[1] = 'int32':type	[召唤id]
			[2] = 'int32':nextFreeTime	[下一次召唤的时间]
			[3] = 'int32':summonNums	[召唤次数;]
		},
		[10] = 'int32':preciousCount	[高级保底次数]
	}
--]]
s2c.SUMMON_SUMMON = 3329

--[[
	[1] = {--SetDressGroupSucc
		[1] = 'int32':dressId	[ 设置的看板id]
		[2] = 'int32':groupId	[ 设置的看板分组]
	}
--]]
s2c.ROLE_SET_DRESS_GROUP_SUCC = 1293

--[[
	[1] = {--UpdateDayTimes
		[1] = 'int32':cid	[ 配置表id]
		[2] = 'int32':dayTimes	[ 抽卡次数]
	}
--]]
s2c.SUMMON_UPDATE_DAY_TIMES = 3348

--[[
	[1] = {--ResActivityExchange
		[1] = 'int32':itemCid	[ 道具id]
	}
--]]
s2c.SUMMON_RES_ACTIVITY_EXCHANGE = 3355

--[[
	[1] = {--ResSummonReward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SUMMON_RES_SUMMON_REWARD = 3342

--[[
	[1] = {--RespRefreshGashaponPool
		[1] = 'string':eggPool	[抓娃娃蛋池]
		[2] = 'int64':pollRefreshCdEndTime	[蛋池刷新cd结束时间]
		[3] = 'int32':eggPoolId	[蛋池id]
	}
--]]
s2c.NEW_BUILDING_RESP_REFRESH_GASHAPON_POOL = 2065

--[[
	[1] = {--RespTenBirthDayInfo
		[1] = {--repeated TenBirthCityInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':cityId	[城市id]
			[3] = {--repeated CityPartInfo
				[1] = 'int32':cityPartId	[城市id]
				[2] = 'int32':state	[开启状态]
			},
			[4] = {--EventInfo
				[1] = 'int32':eventId	[事件id]
				[2] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
			},
		},
	}
--]]
s2c.BIRTH_DAY_RESP_TEN_BIRTH_DAY_INFO = 8101

--[[
	[1] = {--TasksCompleteMsg
		[1] = 'repeated int32':finTasks	[已完成的任务]
	}
--]]
s2c.OFFICE_EXPLORE_TASKS_COMPLETE = 7104

--[[
	[1] = {--RespGetMaidInfo
		[1] = {--repeated MaidObject
			[1] = 'int32':onlyId	[女仆唯一id]
			[2] = 'int32':cid	[女仆配置id]
			[3] = 'int32':strength	[女仆的体力]
		},
		[2] = {--MaidInfo
			[1] = 'int64':totle	[总的营业值]
			[2] = 'int32':customer	[揽客值]
			[3] = 'int32':cost	[消费]
			[4] = 'int32':turnOver	[每秒的营业值]
			[5] = 'repeated int32':attributes	[属性列表]
		},
		[3] = 'repeated int32':workLists	[工作列表]
		[4] = {--RecruitInfo
			[1] = {--repeated Recruit
				[1] = 'int32':cid	[招募id]
				[2] = 'bool':state	[招募状态]
			},
			[2] = 'int32':nextTime	[下一次的免费刷新时间]
			[3] = 'int32':recruitTimes	[每一天的招募次数]
			[4] = 'int32':recruitBuyTimes	[每一天的购买刷新次数]
		},
		[5] = 'int32':enterType	[进入方式]
		[6] = {--MaidRole
			[1] = 'int32':roleId	[当前头像id]
			[2] = 'repeated int32':roleList	[当前头像列表]
		},
		[7] = {--repeated MaidEventList
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[事件id]
			[3] = 'bool':reward	[是否领取奖励]
			[4] = 'int32':cfgId	[配置表id]
			[5] = 'int32':creatAt	[时间点]
			[6] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[7] = 'string':weather
		},
	}
--]]
s2c.MAID_ACTIVITY_RESP_GET_MAID_INFO = 9150

--[[
	[1] = {--ResSummonComposeSpeed
		[1] = {--repeated ComposeInfo
			[1] = 'int32':cid	[合成配置id]
			[2] = 'int32':finishTime	[完成时间]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'int32':costTime	[消耗时间]
		},
		[2] = 'int32':freeNum	[一键加速的次数]
	}
--]]
s2c.SUMMON_RES_SUMMON_COMPOSE_SPEED = 3345

--[[
	[1] = {--RespCheckGashaponResult
		[1] = 'string':eggPool	[抓娃娃蛋池]
		[2] = 'repeated int32':eggIds	[抓到的蛋id(可能一次抓到多个)    //抓到的蛋id(可能一次抓到多个)]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.NEW_BUILDING_RESP_CHECK_GASHAPON_RESULT = 2064

--[[
	[1] = {--RspIndentureInfo
		[1] = 'int32':taskIndenture	[任务契约阶段]
		[2] = {--IndentureSummon
			[1] = 'int32':indenture	[契约阶段]
			[2] = 'int32':endTime	[结束时间]
			[3] = 'int32':leftCount	[剩余次数]
		},
		[3] = 'repeated int32':actIndentures	[已激活契约]
	}
--]]
s2c.INDENTURE_RSP_INDENTURE_INFO = 8201

--[[
	[1] = {--RespGetFoodBaseAward
		[1] = 'int32':foodId
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.NEW_BUILDING_RESP_GET_FOOD_BASE_AWARD = 2069

--[[
	[1] = {--ResHotSummonInfo
		[1] = 'int32':heroHotSummonOrder	[ 英雄热点召唤id]
		[2] = 'int32':heroHotSummonTime	[ 英雄热点召唤结束时间]
		[3] = 'int32':equipHotSummonOrder	[ 质点热点召唤id]
		[4] = 'int32':equipHotSummonTime	[ 质点热点召唤结束时间]
		[5] = 'int32':hotHeroSummonScore	[热点精灵召唤分数]
		[6] = 'int32':hotEquipSummonScore	[热点质点召唤分数]
	}
--]]
s2c.SUMMON_RES_HOT_SUMMON_INFO = 3343

--[[
	[1] = {--RespFreeSummon
		[1] = {--repeated FreeSummon
			[1] = 'int32':type	[召唤id]
			[2] = 'int32':nextFreeTime	[下一次召唤的时间]
			[3] = 'int32':summonNums	[召唤次数;]
		},
	}
--]]
s2c.SUMMON_RESP_FREE_SUMMON = 3353

--[[
	[1] = {--RespSelfContriPrize
		[1] = 'int32':prizeIndex	[奖励索引]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ODEUM_RESP_SELF_CONTRI_PRIZE = 6512

--[[
	[1] = {--RespTimeOutItemConvert
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ITEM_RESP_TIME_OUT_ITEM_CONVERT = 519

--[[
	[1] = {--RespMakeFormula
		[1] = 'bool':success	[成功  是吧]
		[2] = 'int32':formulaId	[配方id]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_RESP_MAKE_FORMULA = 5227

--[[
	[1] = {--RespFightPong
		[1] = 'string':time	[ 服务器时间]
		[2] = {--repeated CheckTimeData
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'int32':delayTime	[延迟]
		},
		[3] = 'int32':hostPlayerId	[ 主机玩家id]
	}
--]]
s2c.FIGHT_RESP_FIGHT_PONG = 25609

--[[
	[1] = {--ResSummonCount
		[1] = {--repeated SummonCount
			[1] = 'int32':cid	[ 配置表id]
			[2] = 'int32':count	[ 次数]
		},
	}
--]]
s2c.SUMMON_RES_SUMMON_COUNT = 3339

--[[
	[1] = {--ResFreeGiftReward
		[1] = 'int32':giftId
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[3] = 'int32':receiveCount
	}
--]]
s2c.RECHARGE_RES_FREE_GIFT_REWARD = 4373

--[[
	[1] = {--RespSpecialMakeFormula
		[1] = 'bool':success	[成功  是吧]
		[2] = 'int32':formulaId	[配方id]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_RESP_SPECIAL_MAKE_FORMULA = 5226

--[[
	[1] = {--AcceptDatingInvitationMsg
	}
--]]
s2c.DATING_ACCEPT_DATING_INVITATION = 1544

--[[
	[1] = {--UpdateCardNum
		[1] = 'int32':cid	[ 配置表id]
		[2] = 'int32':cardNum	[ 卡牌数量]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SUMMON_UPDATE_CARD_NUM = 3347

--[[
	[1] = {--RspResetSpiritPoints
		[1] = {--HeroSpiritInfo
			[1] = 'int32':spiritPoints	[可用灵力点数]
			[2] = 'int32':grade	[品阶从0开始]
			[3] = 'int32':level	[级数从0开始]
			[4] = 'int64':exp	[经验值]
			[5] = {--repeated HeroSpiritProperty
				[1] = 'int32':cid	[cid]
				[2] = 'int32':num	[点数]
			},
			[6] = 'bool':firstShow	[首次开启展示true即为要显示false则不显示]
			[7] = 'bool':feedback	[旧灵力系统是否已返回资源]
			[8] = {--repeated HeroAngleSpirit
				[1] = 'int32':heroCid	[cid]
				[2] = 'int32':lv	[点数]
			},
			[9] = 'int32':maxLv	[可升级上限]
		},
	}
--]]
s2c.HERO_SPIRIT_RSP_RESET_SPIRIT_POINTS = 8402

--[[
	[1] = {--RespTimeFreeSummon
		[1] = {--repeated FreeSummon
			[1] = 'int32':type	[召唤id]
			[2] = 'int32':nextFreeTime	[下一次召唤的时间]
			[3] = 'int32':summonNums	[召唤次数;]
		},
	}
--]]
s2c.SUMMON_RESP_TIME_FREE_SUMMON = 3354

--[[
	[1] = {--RespInitChatInfo
		[1] = 'int32':roomId
		[2] = {--repeated ChatInfo
			[1] = 'int32':channel	[	聊天类型:1.公共 2.私聊;3.帮派 4.系统 5.队伍 6.队伍系统邀请]
			[2] = 'int32':fun	[ 	功能类型:1.聊天 2.深渊组队邀请  6系统消息]
			[3] = 'string':content	[	内容]
			[4] = 'int32':pid	[	说话人的id]
			[5] = 'string':pname	[	说话人名称]
			[6] = 'int32':lvl	[ 	玩家等级]
			[7] = 'int32':helpFightHeroCid
			[8] = 'int32':portraitCid	[玩家头像]
			[9] = 'int32':portraitFrameCid	[玩家头像框]
			[10] = 'int32':titleId	[称号]
			[11] = 'int32':chatFrameCid	[气泡框]
		},
	}
--]]
s2c.CHAT_RESP_INIT_CHAT_INFO = 2311

--[[
	[1] = {--ResFinishGame
	}
--]]
s2c.SNOW_FESTIVAL_RES_FINISH_GAME = 9306

--[[
	[1] = {--RespPhantomGift
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.PLAYER_RESP_PHANTOM_GIFT = 302

--[[
	[1] = {--Afk7809
	}
--]]
s2c.EXPLORE_AFK7809 = 7809

--[[
	[1] = {--ResSimulateSummonReplace
		[1] = {--SimulateSummon
			[1] = 'int32':cid
			[2] = 'int32':simulateSummonCount
			[3] = 'int32':sysSimulateSummonCount
			[4] = 'int32':exchangeCount
			[5] = {--repeated SimulateSummonRecord
				[1] = 'int32':order
				[2] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
				[3] = 'bool':isReceive
			},
		},
	}
--]]
s2c.SUMMON_RES_SIMULATE_SUMMON_REPLACE = 3351

--[[
	[1] = {--RespRank
		[1] = 'int32':activityId	[ 活动ID]
		[2] = {--repeated ActivityRankMsg
			[1] = 'int32':rank	[ 排行]
			[2] = 'int32':playerId	[角色ID]
			[3] = 'string':playerName	[ 角色名]
			[4] = 'int32':score	[排行榜分数]
			[5] = 'int32':headIcon	[头像id]
			[6] = 'int32':helpFightHeroId	[助战id]
			[7] = 'int32':level	[等级]
			[8] = 'int32':frameCid	[头像框]
			[9] = 'int32':groupRank	[0:单人排名,1:组队排名]
			[10] = {--repeated RankPlayerInfo
				[1] = 'string':playerName	[ 角色名]
				[2] = 'int32':playerId	[角色ID]
				[3] = 'int32':level	[等级]
				[4] = 'int32':frameCid	[头像框]
				[5] = 'int32':headIcon	[头像id]
				[6] = 'int32':helpFightHeroId	[助战id]
				[7] = 'int32':heroId	[使用英雄id]
			},
		},
		[3] = 'int32':myRank	[ 我的排名]
	}
--]]
s2c.ACTIVITY_RESP_RANK = 5130

--[[
	[1] = {--ResSupportListMsg
		[1] = {--repeated SupportRole
			[1] = 'int64':playerId
			[2] = 'string':playerName
			[3] = 'int64':startTime
			[4] = 'int32':times
			[5] = {--Role
				[1] = 'int32':roleId
			},
			[6] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
		},
		[2] = 'int64':lastReqTime	[上次请求事件]
	}
--]]
s2c.HANGUP_ACT_RES_SUPPORT_LIST = 9005

--[[
	[1] = {--RespFeedMaid
		[1] = {--MaidObject
			[1] = 'int32':onlyId	[女仆唯一id]
			[2] = 'int32':cid	[女仆配置id]
			[3] = 'int32':strength	[女仆的体力]
		},
	}
--]]
s2c.MAID_ACTIVITY_RESP_FEED_MAID = 9152

--[[
	[1] = {--RespSetUiChange
	}
--]]
s2c.PLAYER_RESP_SET_UI_CHANGE = 303

--[[
	[1] = {--ResSimulateTrainInfo
		[1] = 'bool':isOpen	[是否开放]
		[2] = 'int32':startTime	[开始时间]
		[3] = 'int32':endTime	[结束时间]
		[4] = {--repeated SimulateTrainInfo
			[1] = 'int32':heroId	[试炼英雄]
			[2] = 'repeated int32':dungeonId	[开放关卡列表]
			[3] = {--repeated SimulateTrainTask
				[1] = 'int32':id	[ 任务id]
				[2] = {--STTaskStaus(enum)
					'v4':STTaskStaus
				},
			},
		},
	}
--]]
s2c.HERO_RES_SIMULATE_TRAIN_INFO = 1046

--[[
	[1] = {--WorldRoomDecorate
		[1] = {--ChangeType(enum)
			'v4':ChangeType
		},
		[2] = 'int32':roomType
		[3] = {--repeated RoomDecorate
			[1] = 'int32':decorateId	[建筑id]
			[2] = 'string':pid	[实例id]
			[3] = {--AreaPlayerPos
				[1] = 'int32':x
				[2] = 'int32':y
				[3] = 'int32':dir
				[4] = 'int32':dt
			},
			[4] = 'string':ext	[额外信息]
		},
	}
--]]
s2c.NEW_WORLD_WORLD_ROOM_DECORATE = 6821

--[[
	[1] = {--DatingSettlementMsg
		[1] = 'int32':score	[积分]
		[2] = 'int32':favor	[好感度]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[4] = 'int32':scriptId	[剧本id]
		[5] = 'repeated bool':starList	[ 星级等级]
		[6] = 'bool':obsolete	[剧本是否过时(预定约会和出游约会,系统定时清除)    //剧本是否过时(预定约会和出游约会,系统定时清除)]
		[7] = 'int32':endId	[剧本id]
	}
--]]
s2c.DATING_DATING_SETTLEMENT = 1540

--[[
	[1] = {--ResHeroExploreMsg
		[1] = 'repeated int32':roleId
		[2] = {--repeated SupportRole
			[1] = 'int64':playerId
			[2] = 'string':playerName
			[3] = 'int64':startTime
			[4] = 'int32':times
			[5] = {--Role
				[1] = 'int32':roleId
			},
			[6] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
		},
		[3] = {--repeated Buff
			[1] = 'int32':buffId
			[2] = 'int32':buffLv
		},
	}
--]]
s2c.HANGUP_ACT_RES_HERO_EXPLORE = 9002

--[[
	[1] = {--ResEvtFinish
		[1] = {--ApInfo
			[1] = 'int32':value	[ap值]
			[2] = 'int32':limit	[上限值]
		},
	}
--]]
s2c.SUMMER_COURAGE_RES_EVT_FINISH = 6902

--[[
	[1] = {--ResShowGroupTeam
	}
--]]
s2c.RECHARGE_RES_SHOW_GROUP_TEAM = 4385

--[[
	[1] = {--UpdateElement
		[1] = {--Elements
			[1] = 'int32':type	[类型]
			[2] = {--repeated Element
				[1] = 'int32':cid	[cid]
				[2] = 'int32':reward	[领奖状态 0不可领取  1可领取 2 已领取]
			},
			[3] = 'int32':trophy	[奖杯数]
			[4] = 'bool':scan	[是否可以浏览]
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ELEMENT_COLLECT_UPDATE_ELEMENT = 4867

--[[
	[1] = {--RspRankList
		[1] = {--repeated RankInfoMsg
			[1] = 'int32':pid	[玩家id (社团排行的时候为团长信息)    //玩家id (社团排行的时候为团长信息)]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':headId	[头像]
			[4] = 'int32':frameId	[头像框]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'string':params	[排名信息参数   根据排行榜类型--->等级/总战斗力(历史最高)/无尽层数(历史最高)/总充值金额(累计)    //排名信息参数   根据排行榜类型--->等级/总战斗力(历史最高)/无尽层数(历史最高)/总充值金额(累计)]
			[7] = 'int32':unionId	[社团ID(社团排行榜)    //社团ID(社团排行榜)]
			[8] = 'int32':unionIcon	[社团徽记]
			[9] = 'string':unionName	[社团名称]
			[10] = 'int32':heroId	[ 助战英雄CID]
			[11] = 'int32':skinCid	[ 助战英雄皮肤CID]
		},
		[2] = 'int32':refreshMinu	[刷新周期,分钟]
		[3] = 'int32':type	[排行榜类别  --->S2CRankMsg.RankType]
		[4] = {--RankInfoMsg
			[1] = 'int32':pid	[玩家id (社团排行的时候为团长信息)    //玩家id (社团排行的时候为团长信息)]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':headId	[头像]
			[4] = 'int32':frameId	[头像框]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'string':params	[排名信息参数   根据排行榜类型--->等级/总战斗力(历史最高)/无尽层数(历史最高)/总充值金额(累计)    //排名信息参数   根据排行榜类型--->等级/总战斗力(历史最高)/无尽层数(历史最高)/总充值金额(累计)]
			[7] = 'int32':unionId	[社团ID(社团排行榜)    //社团ID(社团排行榜)]
			[8] = 'int32':unionIcon	[社团徽记]
			[9] = 'string':unionName	[社团名称]
			[10] = 'int32':heroId	[ 助战英雄CID]
			[11] = 'int32':skinCid	[ 助战英雄皮肤CID]
		},
	}
--]]
s2c.RANK_RSP_RANK_LIST = 7100

--[[
	[1] = {--ValentineComposeMsg
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.VALENTINE_VALENTINE_COMPOSE = 7402

--[[
	[1] = {--RespOperation
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.MAIL_RESP_OPERATION = 769

--[[
	[1] = {--ResNewbieStepInfo
		[1] = 'repeated int32':stepInfo	[所有步骤]
		[2] = 'bool':open	[新手开关状态,true开启,false关闭]
	}
--]]
s2c.SUMMER_COURAGE_RES_NEWBIE_STEP_INFO = 6914

--[[
	[1] = {--ResEnterRewardMission
		[1] = 'bool':isFighting
		[2] = 'bool':isShowResult
		[3] = 'bool':isWin
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.NEW_WORLD_RES_ENTER_REWARD_MISSION = 6815

--[[
	[1] = {--GetOrderNo
		[1] = 'string':orderNo	[订单号]
		[2] = 'int32':goodsId	[商品id]
	}
--]]
s2c.RECHARGE_GET_ORDER_NO = 4353

--[[
	[1] = {--ResSwitchNewbie
		[1] = 'bool':open	[true表示开启,false关闭]
	}
--]]
s2c.SUMMER_COURAGE_RES_SWITCH_NEWBIE = 6915

--[[
	[1] = {--ResDischarge
		[1] = {--repeated EquipInfo
			[1] = 'int32':position	[位置]
			[2] = 'int32':equipId	[装备id]
		},
	}
--]]
s2c.SUMMER_COURAGE_RES_DISCHARGE = 6906

--[[
	[1] = {--RescueHeroNotice
		[1] = 'int32':scriptId	[剧本id]
	}
--]]
s2c.SUMMER_COURAGE_RESCUE_HERO_NOTICE = 6917

--[[
	[1] = {--RespEntranceEventChoosed
		[1] = 'int32':datingType	[约会类型1 外传 2 主线]
		[2] = 'int32':datingValue	[当类型为外传时,值传外传ID,主线则为主线章节]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[5] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[6] = {--repeated QualityInfo
			[1] = 'int32':qualityId	[对应DatingVariable表id]
			[2] = 'int32':value	[值]
		},
		[7] = 'int32':stepEnd	[1 如果值为1 则是阶段结局]
		[8] = 'int32':endId	[结局id]
	}
--]]
s2c.EXTRA_DATING_RESP_ENTRANCE_EVENT_CHOOSED = 5635

--[[
	[1] = {--RespUpgradeWishTree
		[1] = 'int32':id	[当前等级id]
	}
--]]
s2c.ANNIVERSARY2ND_RESP_UPGRADE_WISH_TREE = 9233

--[[
	[1] = {--ResTiggerRoleNotice
		[1] = 'int32':favorDatingId	[Favor表对应id]
		[2] = 'int32':statue	[0表示章节状态取消显示 1显示]
	}
--]]
s2c.EXTRA_DATING_RES_TIGGER_ROLE_NOTICE = 5652

--[[
	[1] = {--ResAnnivInfo
		[1] = 'repeated int32':openIndex	[翻开的格子]
		[2] = {--repeated LeftReward
			[1] = 'int32':id	[配置id]
			[2] = 'int32':num	[还剩的份数]
			[3] = 'int32':total	[总共的份数]
		},
		[3] = 'int32':layer	[层数]
		[4] = 'int32':freeCount	[免费的次数]
		[5] = 'int32':freeCountLimit	[免费次数上限]
		[6] = 'int32':passIndex	[通关奖励的位置,传了表示通关奖励出现了,没传表示没有出现]
		[7] = 'int32':passId	[通关奖励id]
		[8] = 'bool':started	[是否已经开始游戏了,点击开始游戏后设置]
		[9] = {--repeated PassCount
			[1] = 'int32':passId	[配置id]
			[2] = 'int32':count	[已经选择的次数]
		},
	}
--]]
s2c.ANNIVERSARY2ND_RES_ANNIV_INFO = 9202

--[[
	[1] = {--RespHuntingPassAward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--repeated HuntingBossAward
			[1] = 'int32':dungeon	[副本id]
			[2] = 'int32':status	[领取状态,1 未满足条件,2 可领取,3 已领取]
		},
	}
--]]
s2c.HUNTING_DUNGEON_RESP_HUNTING_PASS_AWARD = 8505

--[[
	[1] = {--CabinUpgrade
		[1] = {--Cabin
			[1] = 'int32':id	[舱室id]
			[2] = 'int32':cid	[舱室配置id]
			[3] = 'int32':holeCount	[镶嵌孔位数量]
			[4] = {--repeated Equip
				[1] = 'string':id
				[2] = 'int32':cid
				[3] = 'int32':level
				[4] = 'int32':index	[镶嵌的位置,从1开始,如果为0,没有镶嵌]
				[5] = 'int32':cabinId	[舱室id]
			},
			[5] = {--repeated AfkTask
				[1] = 'int32':id
				[2] = 'int32':state	[任务状态 0 未开始 1开始 2完成,3已领奖]
				[3] = 'repeated int32':heroId	[任务派遣的hero]
				[4] = 'int64':startTime	[任务开始执行的时间 0 就是还没有开始或者已经完成]
				[5] = 'int32':cabinId	[舱室id]
			},
			[6] = {--repeated HeroDriver
				[1] = 'int32':index	[舱室指挥室位置]
				[2] = 'int32':heroId	[精灵id]
			},
			[7] = 'int32':fightPower	[精灵总战斗力]
			[8] = {--repeated Treasure
				[1] = 'int32':index	[格子索引]
				[2] = 'string':uuid	[装备在格子上的宝物uid]
			},
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EXPLORE_CABIN_UPGRADE = 7803

--[[
	[1] = {--RespFormulaUpLevel
		[1] = {--CatFormulaInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[配方id]
			[3] = 'int32':level	[配方等级]
			[4] = 'int32':exp	[配方经验]
			[5] = 'int32':creatAt	[获取时间]
			[6] = 'int32':num	[配方所增加的营业额度]
		},
		[2] = 'int32':oldLevel	[旧的配方等级]
	}
--]]
s2c.ACTIVITY_RESP_FORMULA_UP_LEVEL = 5217

--[[
	[1] = {--RespGetFunAward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.RECHARGE_RESP_GET_FUN_AWARD = 4375

--[[
	[1] = {--RspLadderBoundStuffs
		[1] = {--repeated RspBoundStuff
			[1] = 'string':itemId	[道具id,对应背包道具]
			[2] = 'int32':heroCid	[精灵cid]
		},
		[2] = {--repeated RspBoundStuff
			[1] = 'string':itemId	[道具id,对应背包道具]
			[2] = 'int32':heroCid	[精灵cid]
		},
	}
--]]
s2c.LADDER_RSP_LADDER_BOUND_STUFFS = 8308

--[[
	[1] = {--BuyMonthCardInfo
		[1] = {--GetMonthCardInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':lastGainDate	[上次领取时间]
			[3] = 'int32':surplus_Gain_Count	[剩余领取次数]
			[4] = 'int32':cardCid	[卡cid]
			[5] = 'int32':etime	[剩余的时间]
			[6] = 'int32':lastEndTime	[上次月卡结束时间,0表示当前为首次购买]
		},
		[2] = {--ItemList
			[1] = {--repeated ItemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'int64':num	[ 数量]
				[5] = 'int32':outTime	[过期时间]
			},
			[2] = {--repeated EquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[灵装id]
				[3] = 'int32':cid	[灵装cid]
				[4] = 'int32':level	[灵装等级]
				[5] = 'int32':exp	[灵装经验值]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
				[8] = {--repeated SpecialAttr
					[1] = 'int32':cid	[配置id]
					[2] = 'int32':value	[属性值]
					[3] = 'int32':index	[属性服务器顺序]
				},
				[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
				[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
				[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
				[12] = 'int32':outTime	[过期时间]
				[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
				[14] = 'int32':star	[额外星数]
				[15] = 'int32':stage	[阶段]
				[16] = 'int32':num	[数量]
				[17] = 'int32':step	[质点阶级]
			},
			[3] = {--repeated DressInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'string':roleId	[ 装备精灵ID]
				[5] = 'int32':outTime	[过期时间]
			},
			[4] = {--repeated NewEquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[新装备id]
				[3] = 'int32':cid	[新装备cid]
				[4] = 'int32':stage	[新装备阶段等级]
				[5] = 'int32':level	[新装备等级]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
			},
			[5] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[6] = {--repeated TreasureInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝物id]
				[3] = 'int32':cid	[宝物cid]
				[4] = 'int32':star	[宝物星级]
			},
			[7] = {--repeated ExploreEquip
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[探索装备id]
				[3] = 'int32':cid	[探索装备cid]
				[4] = 'int32':level	[探索装备星级]
			},
		},
	}
--]]
s2c.RECHARGE_BUY_MONTH_CARD_INFO = 4359

--[[
	[1] = {--ResRecordNewbieStep
	}
--]]
s2c.SUMMER_COURAGE_RES_RECORD_NEWBIE_STEP = 6913

--[[
	[1] = {--ResRefreshFriendHelpTask
		[1] = {--FriendHelpInfo
			[1] = 'int32':playerId
			[2] = 'string':playerName
			[3] = 'int32':portraitCid
			[4] = 'int32':portraitFrameCid
			[5] = 'int32':level
			[6] = {--repeated FriendHelpTaskInfo
				[1] = 'int32':taskId
				[2] = {--FriendHelpTaskStatus(enum)
					'v4':FriendHelpTaskStatus
				},
			},
		},
	}
--]]
s2c.FRIEND_RES_REFRESH_FRIEND_HELP_TASK = 3093

--[[
	[1] = {--ResRealEnter
	}
--]]
s2c.SUMMER_COURAGE_RES_REAL_ENTER = 6916

--[[
	[1] = {--RespNeptune2ndHalfResource
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_RESOURCE = 7702

--[[
	[1] = {--RepsHelpFightPlayers
		[1] = {--repeated PlayerSynopsis
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':name	[ 玩家名称]
			[3] = 'int32':lvl	[ 玩家等级]
			[4] = 'int32':helpHeroCid	[ 帮助英雄ID]
			[5] = 'int32':coldDownTime	[助战冷却时间]
			[6] = 'int32':helpHeroFightPower	[ 帮助英雄战力]
			[7] = 'int32':portraitCid	[ 帮助英雄ID]
		},
	}
--]]
s2c.PLAYER_REPS_HELP_FIGHT_PLAYERS = 273

--[[
	[1] = {--ResEquip
		[1] = {--repeated EquipInfo
			[1] = 'int32':position	[位置]
			[2] = 'int32':equipId	[装备id]
		},
	}
--]]
s2c.SUMMER_COURAGE_RES_EQUIP = 6905

--[[
	[1] = {--SettlementNotice
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[3] = {--ApInfo
			[1] = 'int32':value	[ap值]
			[2] = 'int32':limit	[上限值]
		},
		[4] = 'repeated int32':script	[解救了精灵的剧本id]
	}
--]]
s2c.SUMMER_COURAGE_SETTLEMENT_NOTICE = 6912

--[[
	[1] = {--RspRefreshLadderCards
		[1] = {--repeated LadderCardInfo
			[1] = 'int32':cardId	[卡牌id]
			[2] = 'int32':cardLv	[卡牌等级]
		},
	}
--]]
s2c.LADDER_RSP_REFRESH_LADDER_CARDS = 8311

--[[
	[1] = {--RspThrowDice
		[1] = 'int32':diceNum	[色子投掷结果]
		[2] = 'repeated int32':moveTrack	[当轮移动轨迹(最后一位是当轮投掷最终位置)    //当轮移动轨迹(最后一位是当轮投掷最终位置)]
		[3] = 'int32':eventId	[格子上触发的事件ID]
		[4] = 'int32':chooseStatus	[当前位置道具卡选择状态----> 不存在道具选择:0 已选择:1  未选择:2]
		[5] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[6] = 'int32':totalCircel	[总圈数]
	}
--]]
s2c.ZILLIONAIRE_RSP_THROW_DICE = 5320

--[[
	[1] = {--ApInfoNotice
		[1] = {--ApInfo
			[1] = 'int32':value	[ap值]
			[2] = 'int32':limit	[上限值]
		},
	}
--]]
s2c.SUMMER_COURAGE_AP_INFO_NOTICE = 6910

--[[
	[1] = {--RespEndFight
		[1] = 'bool':win	[ 奖励信息]
		[2] = {--repeated FightResultdetails
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'int32':hurt	[ 累计伤害]
			[3] = 'bool':mvp	[ 是否是MVP]
		},
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[4] = 'int32':fightTime	[ 战斗时间]
		[5] = 'bool':isSpecial	[ 是否有特殊奖励]
		[6] = 'int64':huntingHonor	[ 追猎荣耀值]
		[7] = {--repeated GoalResult
			[1] = 'int32':id	[ 玩家ID]
			[2] = 'int32':state	[ 0 没有达标,1达标,并且发奖励 2,已经领取过奖励]
		},
		[8] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[9] = 'int32':extTips	[额外掉落提示]
	}
--]]
s2c.FIGHT_RESP_END_FIGHT = 25605

--[[
	[1] = {--RespNotice
		[1] = 'string':name
		[2] = 'int32':contribution
	}
--]]
s2c.ODEUM_RESP_NOTICE = 6502

--[[
	[1] = {--ResLimitlessSummonRefreshPool
		[1] = 'int32':activityId	[活动Id]
		[2] = 'int32':refreshCount	[手动刷新卡池次数]
		[3] = 'repeated int32':summonedList	[已抽取过的卡池id]
	}
--]]
s2c.LIMITLESS_SUMMON_RES_LIMITLESS_SUMMON_REFRESH_POOL = 3503

--[[
	[1] = {--ResGameFinish
		[1] = 'int32':type	[游戏类型]
		[2] = 'bool':success	[true成功,false失败]
		[3] = 'bool':finished	[游戏是否完成了]
	}
--]]
s2c.SUMMER_COURAGE_RES_GAME_FINISH = 6908

--[[
	[1] = {--ResNewWorldChat
		[1] = 'string':content	[  内容]
		[2] = 'int32':pid	[  说话人的id]
		[3] = 'string':pname	[  说话人名称]
		[4] = 'int32':lvl	[  玩家等级]
		[5] = 'int32':helpFightHeroCid
		[6] = 'int32':portraitCid	[玩家头像]
		[7] = 'int32':portraitFrameCid	[玩家头像框]
	}
--]]
s2c.NEW_WORLD_RES_NEW_WORLD_CHAT = 6808

--[[
	[1] = {--RespChoices
		[1] = 'int32':datingType	[约会类型1 外传 2 主线]
		[2] = 'int32':datingValue	[当类型为外传时,值传外传ID,主线则为主线章节]
		[3] = 'repeated int32':eventId	[id列表]
	}
--]]
s2c.EXTRA_DATING_RESP_CHOICES = 5640

--[[
	[1] = {--UpdateTeamLeader
		[1] = 'int32':newLeaderId
	}
--]]
s2c.NEW_WORLD_UPDATE_TEAM_LEADER = 6812

--[[
	[1] = {--SellInfo
		[1] = 'bool':success
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.STORE_SELL_INFO = 2565

--[[
	[1] = {--ResExitGroupTeam
		[1] = 'string':teamId
	}
--]]
s2c.RECHARGE_RES_EXIT_GROUP_TEAM = 4379

--[[
	[1] = {--RespAIProp
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'int32':intimacy	[亲密度]
		[3] = 'int32':chatDays	[通信]
		[4] = 'int32':hateVal	[反转值]
	}
--]]
s2c.DATING_RESP_AIPROP = 1562

--[[
	[1] = {--QliphothMissionsMsg
		[1] = {--repeated QliphothMission
			[1] = 'int32':missionId	[ 任务id]
			[2] = 'int32':progress	[ 任务进度]
		},
		[2] = 'bool':completed	[ 当前阶段任务是否完成]
	}
--]]
s2c.QLIPHOTH_QLIPHOTH_MISSIONS = 6207

--[[
	[1] = {--CommodityBuyLogs
		[1] = {--repeated StoreCommodityBuyInfo
			[1] = 'int32':type	[ 记录类型 1:个人 2:全服]
			[2] = 'int32':cid	[ 商品id]
			[3] = 'int32':nowBuyCount	[ 当前阶段购买次数]
			[4] = 'int32':totalBuyCount	[ 总购买次数]
			[5] = 'int32':storeState	[商品状态]
		},
	}
--]]
s2c.STORE_COMMODITY_BUY_LOGS = 2564

--[[
	[1] = {--SpringWishNotice
		[1] = {--repeated SpringWishInfo
			[1] = 'string':id	[唯一id]
			[2] = 'int32':senderId	[发送者id]
			[3] = 'string':senderName	[发送者名字]
			[4] = 'int32':receiverId	[接收者id]
			[5] = 'string':content	[内容]
			[6] = 'bool':read	[是否读了,true是]
		},
		[2] = {--ChangeType(enum)
			'v4':ChangeType
		},
		[3] = 'repeated int32':sendFriend	[发过的好友,所有的]
		[4] = 'int32':dayReceiveCount	[当天收的数量]
		[5] = 'int32':totalReceiveCount	[总共收的数量]
		[6] = 'int32':daySendCount	[当天发的数量]
		[7] = 'int32':totalSendCount	[总共发的数量]
		[8] = 'bool':getReward	[是否领取结算奖励,true领了]
	}
--]]
s2c.SPRING_WISH_SPRING_WISH_NOTICE = 7506

--[[
	[1] = {--ResReceiveNewFavorAward
		[1] = 'int32':awardId
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.DATING_RES_RECEIVE_NEW_FAVOR_AWARD = 1580

--[[
	[1] = {--ChatInfo
		[1] = 'int32':channel	[	聊天类型:1.公共 2.私聊;3.帮派 4.系统 5.队伍 6.队伍系统邀请]
		[2] = 'int32':fun	[ 	功能类型:1.聊天 2.深渊组队邀请  6系统消息]
		[3] = 'string':content	[	内容]
		[4] = 'int32':pid	[	说话人的id]
		[5] = 'string':pname	[	说话人名称]
		[6] = 'int32':lvl	[ 	玩家等级]
		[7] = 'int32':helpFightHeroCid
		[8] = 'int32':portraitCid	[玩家头像]
		[9] = 'int32':portraitFrameCid	[玩家头像框]
		[10] = 'int32':titleId	[称号]
		[11] = 'int32':chatFrameCid	[气泡框]
	}
--]]
s2c.CHAT_CHAT_INFO = 2306

--[[
	[1] = {--ResReadAllSpringWish
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SPRING_WISH_RES_READ_ALL_SPRING_WISH = 7503

--[[
	[1] = {--ResSendSpringWish
		[1] = 'int32':result	[1成功,2有屏蔽词]
		[2] = 'repeated string':word	[屏蔽词]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SPRING_WISH_RES_SEND_SPRING_WISH = 7501

--[[
	[1] = {--ResSFChangeScore
		[1] = 'int32':activityId
		[2] = 'int32':score
	}
--]]
s2c.SPRING_FESTIVAL_RES_SFCHANGE_SCORE = 6709

--[[
	[1] = {--RespChangeHeroSkin
		[1] = {--HeroInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int64':exp	[ 经验]
			[6] = {--repeated AttributeInfo
				[1] = 'int32':type	[ 属性类型]
				[2] = 'int32':val	[ 属性值]
			},
			[7] = 'int32':advancedLvl	[ 突破等级]
			[8] = {--repeated HeroEquipment
				[1] = 'int32':position	[装备位置]
				[2] = 'string':equipmentId	[装备id]
				[3] = {--EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
			},
			[9] = 'bool':helpFight	[ 助战]
			[10] = 'int32':angelLvl	[ 天使等级]
			[11] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[12] = 'int32':useSkillPiont	[ 已使用技能点]
			[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
			[14] = 'int32':provide	[出处]
			[15] = 'int32':fightPower	[ 战斗力]
			[16] = 'int32':skinCid	[ 皮肤cid]
			[17] = {--repeated SkillStrategy
				[1] = 'int32':id
				[2] = 'string':name
				[3] = 'int32':alreadyUseSkillPiont
				[4] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[5] = {--repeated PassiveSkillInfo
					[1] = 'int32':pos
					[2] = 'int32':skillId
				},
			},
			[18] = 'int32':useSkillStrategy
			[19] = {--repeated CrystalInfo
				[1] = 'int32':rarity
				[2] = 'int32':gridId
			},
			[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
			[21] = {--repeated EuqipFetterInfo
				[1] = 'int32':index
				[2] = {--NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
			},
			[22] = {--HeroStatus(enum)
				'v4':HeroStatus
			},
			[23] = 'int32':deadLine
			[24] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[25] = 'int32':skinCidTemp	[ 皮肤cid]
			[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
			[27] = 'int32':breakLv	[突破等级]
		},
		[2] = 'string':beforeSkinId
	}
--]]
s2c.HERO_RESP_CHANGE_HERO_SKIN = 1036

--[[
	[1] = {--ResSeekNianBeast
	}
--]]
s2c.SPRING_FESTIVAL_RES_SEEK_NIAN_BEAST = 6703

--[[
	[1] = {--ResSFRefreshCount
		[1] = 'int32':activityId
		[2] = 'int32':refreshCount
	}
--]]
s2c.SPRING_FESTIVAL_RES_SFREFRESH_COUNT = 6708

--[[
	[1] = {--ResPamphletInfo
		[1] = 'int32':pamphletLevel	[手册等级]
		[2] = 'repeated int32':finishedId	[升过级的选项]
		[3] = 'int32':exp	[手册经验]
		[4] = {--repeated PamphletBuff
			[1] = 'string':name	[buff的配置名字,比如snowFesFightLv,snowFesMemoryLv]
			[2] = 'repeated int32':value	[值,等级就是单个值,id之类的会有多个]
		},
		[5] = 'int32':dayExp	[当天获得的手册经验]
	}
--]]
s2c.SNOW_FESTIVAL_RES_PAMPHLET_INFO = 9304

--[[
	[1] = {--ResRefreshNianBeast
		[1] = 'int32':nianBeastId
		[2] = 'int32':builingId
		[3] = 'int32':randomSeed
		[4] = 'int32':datingId
		[5] = 'int32':deadline
	}
--]]
s2c.SPRING_FESTIVAL_RES_REFRESH_NIAN_BEAST = 6702

--[[
	[1] = {--RspStepEquip
		[1] = 'string':equipId	[要升阶的质点]
		[2] = 'string':costEquipId	[消耗的同名质点id]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EQUIPMENT_RSP_STEP_EQUIP = 2860

--[[
	[1] = {--RespComment
		[1] = {--repeated CommentInfo
			[1] = 'int32':playerId	[玩家id]
			[2] = 'string':name	[玩家名字]
			[3] = 'int32':heroId	[英雄id,头像]
			[4] = 'string':comment	[评论内容]
			[5] = 'int32':prise	[点赞数量]
			[6] = 'int32':commentDate	[评论日期]
			[7] = 'int32':itemId	[对象(装备/英雄)id    //对象(装备/英雄)id]
		},
		[2] = {--repeated CommentInfo
			[1] = 'int32':playerId	[玩家id]
			[2] = 'string':name	[玩家名字]
			[3] = 'int32':heroId	[英雄id,头像]
			[4] = 'string':comment	[评论内容]
			[5] = 'int32':prise	[点赞数量]
			[6] = 'int32':commentDate	[评论日期]
			[7] = 'int32':itemId	[对象(装备/英雄)id    //对象(装备/英雄)id]
		},
	}
--]]
s2c.COMMENT_RESP_COMMENT = 4001

--[[
	[1] = {--UseItemMsg
		[1] = {--repeated QliphothItem
			[1] = 'int32':itemId	[ 道具id]
			[2] = 'int32':itemNum	[ 道具数量]
		},
	}
--]]
s2c.QLIPHOTH_USE_ITEM = 6214

--[[
	[1] = {--FlyBalloonSucc
		[1] = 'int32':count	[放飞气球数量]
		[2] = 'int32':rewardLevel	[奖励等级]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_FLY_BALLOON_SUCC = 5192

--[[
	[1] = {--InitUnionChatInfo
		[1] = 'int32':unionId
		[2] = {--repeated ChatInfo
			[1] = 'int32':channel	[	聊天类型:1.公共 2.私聊;3.帮派 4.系统 5.队伍 6.队伍系统邀请]
			[2] = 'int32':fun	[ 	功能类型:1.聊天 2.深渊组队邀请  6系统消息]
			[3] = 'string':content	[	内容]
			[4] = 'int32':pid	[	说话人的id]
			[5] = 'string':pname	[	说话人名称]
			[6] = 'int32':lvl	[ 	玩家等级]
			[7] = 'int32':helpFightHeroCid
			[8] = 'int32':portraitCid	[玩家头像]
			[9] = 'int32':portraitFrameCid	[玩家头像框]
			[10] = 'int32':titleId	[称号]
			[11] = 'int32':chatFrameCid	[气泡框]
		},
	}
--]]
s2c.CHAT_INIT_UNION_CHAT_INFO = 2331

--[[
	[1] = {--GainMonthCardItem
	}
--]]
s2c.RECHARGE_GAIN_MONTH_CARD_ITEM = 4354

--[[
	[1] = {--ResEquipRemould
		[1] = 'string':equipmentId	[灵装id]
		[2] = {--repeated AttrChange
			[1] = 'int32':index	[属性id]
			[2] = 'string':value	[变化值]
		},
	}
--]]
s2c.EQUIPMENT_RES_EQUIP_REMOULD = 2826

--[[
	[1] = {--QliphothCoinMsg
		[1] = 'int32':qliphothCoin	[卡巴拉生命精华(代币)    //卡巴拉生命精华(代币)]
	}
--]]
s2c.QLIPHOTH_QLIPHOTH_COIN = 6218

--[[
	[1] = {--RespChatInfoChange
		[1] = 'int32':channel	[  聊天类型 6.队伍系统邀请]
		[2] = {--repeated ChatInfo
			[1] = 'int32':channel	[	聊天类型:1.公共 2.私聊;3.帮派 4.系统 5.队伍 6.队伍系统邀请]
			[2] = 'int32':fun	[ 	功能类型:1.聊天 2.深渊组队邀请  6系统消息]
			[3] = 'string':content	[	内容]
			[4] = 'int32':pid	[	说话人的id]
			[5] = 'string':pname	[	说话人名称]
			[6] = 'int32':lvl	[ 	玩家等级]
			[7] = 'int32':helpFightHeroCid
			[8] = 'int32':portraitCid	[玩家头像]
			[9] = 'int32':portraitFrameCid	[玩家头像框]
			[10] = 'int32':titleId	[称号]
			[11] = 'int32':chatFrameCid	[气泡框]
		},
	}
--]]
s2c.CHAT_RESP_CHAT_INFO_CHANGE = 2313

--[[
	[1] = {--RespTestMsg
		[1] = {--repeated NotMsg
			[1] = 'int32':score	[积分]
			[2] = 'int32':datingType	[约会类型]
			[3] = 'int32':currentNodeId	[当前进行到的节点]
			[4] = {--Notes
				[1] = {--repeated Node
					[1] = 'int32':datingId	[约会配置id]
					[2] = 'repeated int32':nextNodeIds	[下级节点id]
				},
			},
			[5] = 'int32':selectedNode	[被选择节点]
		},
		[2] = 'repeated int32':scriptIds	[已经通过的剧本id]
		[3] = 'repeated int32':endings	[剧本结束节点]
		[4] = 'repeated string':xxxx	[邀请约会信息列表]
	}
--]]
s2c.LOGIN_RESP_TEST = 274

--[[
	[1] = {--ResFightSpringEnvelope
		[1] = {--RedPacketDetailInfo
			[1] = 'int32':id	[ 红包id]
			[2] = 'string':blessing	[祝福语]
			[3] = 'int32':count	[ 红包数量]
			[4] = 'int32':senderId	[ 发送者id]
			[5] = 'int64':createTime	[ 发送者id]
			[6] = 'string':senderName	[ 发送者名字]
			[7] = 'int32':moneyTempId	[ 发送者icon]
			[8] = {--repeated RedPackageRecord
				[1] = 'string':playerId	[ 领取角色id]
				[2] = 'string':playerName	[ 领取角色名]
				[3] = 'int32':openCount	[ 领取数量]
				[4] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
				[5] = 'int32':portraitCid	[ 头像CID]
				[6] = 'int32':portraitFrameCid	[ 头像框CID]
				[7] = 'int32':createTime	[ 抢红包时间]
			},
			[9] = 'int32':status	[ 1 抢红包 2查看红包]
			[10] = 'int32':senderLeaderCid	[ 发送者英雄CID(队长)    // 发送者英雄CID(队长)]
			[11] = 'int32':senderPortraitCid	[ 发送者头像CID]
			[12] = 'int32':senderPortraitFrameCid	[ 发送者头像框CID]
		},
	}
--]]
s2c.RED_ENVELOPE_RES_FIGHT_SPRING_ENVELOPE = 7307

--[[
	[1] = {--ResEquipRemouldSwitch
		[1] = 'bool':isOpen	[开关]
	}
--]]
s2c.EQUIPMENT_RES_EQUIP_REMOULD_SWITCH = 2825

--[[
	[1] = {--SummonPanelInfo
		[1] = {--repeated SummonInfo
			[1] = 'int32':summonId	[ 召唤id]
			[2] = 'int32':summstart	[ 活动开始时间]
			[3] = 'int32':summend	[ 活动结束时间]
			[4] = 'int32':startShow	[ 活动开始Show时间]
			[5] = 'int32':endShow	[ 活动结束Show时间]
			[6] = {--repeated SummonShow
				[1] = 'int32':count	[次数]
				[2] = 'repeated int32':itemId	[ 道具]
				[3] = 'repeated int32':itemNums	[ 道具数量]
			},
			[7] = 'int32':summonNums	[召唤次数]
			[8] = 'repeated int32':getRewards	[已领取奖励]
			[9] = 'int32':count	[ 领奖循环轮数]
			[10] = 'repeated int32':equipRewards	[精准的质点id]
			[11] = 'int32':remainScore	[剩余积分]
			[12] = 'int32':cardNum	[ 剩余卡牌数量]
			[13] = 'int32':dayTimes	[ 今日抽卡次数]
			[14] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[15] = 'int32':preciousCount	[高级保底次数]
		},
		[2] = {--SummonNoob
			[1] = 'bool':noobStatus	[ 功能是否可用]
			[2] = 'int32':endTime	[ 结束时间]
			[3] = 'int32':summonCount	[ 召唤次数]
			[4] = 'int32':awardState	[ 领奖状态,0 条件未达 1 可领取 2 已领取]
		},
		[3] = {--repeated PersonalSummon
			[1] = 'int32':summonType	[ 卡池类型]
			[2] = 'int32':summend	[ 活动结束时间]
			[3] = 'int32':summonNums	[召唤次数]
		},
	}
--]]
s2c.SUMMON_SUMMON_PANEL_INFO = 3336

--[[
	[1] = {--RespFestival2020Finish
		[1] = 'bool':status	[游戏选项是否正确]
		[2] = 'int32':game	[游戏类型]
		[3] = 'repeated int32':cases	[或许需要例子说明,备用字段]
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SPRING_FESTIVAL_RESP_FESTIVAL2020_FINISH = 6714

--[[
	[1] = {--RspUpgradeLadderCard
		[1] = {--LadderCardInfo
			[1] = 'int32':cardId	[卡牌id]
			[2] = 'int32':cardLv	[卡牌等级]
		},
	}
--]]
s2c.LADDER_RSP_UPGRADE_LADDER_CARD = 8309

--[[
	[1] = {--RespImpeachList
		[1] = {--repeated UnionMember
			[1] = 'int32':playerId	[ 玩家ID]
			[2] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
			[3] = 'string':name	[ 名字]
			[4] = 'int32':fightPower	[ 战力]
			[5] = 'int32':lvl	[ 等级]
			[6] = 'int64':lastLoginTime	[ 最后登录时间]
			[7] = 'bool':online	[ 是否在线]
			[8] = 'int32':portraitCid	[ 头像CID]
			[9] = 'int32':portraitFrameCid	[ 头像框CID]
			[10] = 'int32':degree	[职位]
			[11] = 'int32':weekContribution	[ 周贡献]
			[12] = 'int32':allContribution	[ 全部贡献]
			[13] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[14] = 'int64':joinTime	[ 加入时间]
			[15] = 'repeated int32':groupGiftIds	[团购礼包id]
		},
	}
--]]
s2c.UNION_RESP_IMPEACH_LIST = 6671

--[[
	[1] = {--ValentineInfoMsg
		[1] = 'repeated int32':datingCids	[ 已使用约会id]
	}
--]]
s2c.VALENTINE_VALENTINE_INFO = 7405

--[[
	[1] = {--ResEnterMemory
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--MemoryStatus(enum)
			'v4':MemoryStatus
		},
	}
--]]
s2c.SNOW_FESTIVAL_RES_ENTER_MEMORY = 9307

--[[
	[1] = {--ResMemoryLocation
		[1] = {--repeated MemoryLocation
			[1] = 'int32':chapterId	[章节id]
			[2] = 'int32':itemId	[条目id]
		},
	}
--]]
s2c.SNOW_FESTIVAL_RES_MEMORY_LOCATION = 9305

--[[
	[1] = {--ResSimulateSummonExchange
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--SimulateSummon
			[1] = 'int32':cid
			[2] = 'int32':simulateSummonCount
			[3] = 'int32':sysSimulateSummonCount
			[4] = 'int32':exchangeCount
			[5] = {--repeated SimulateSummonRecord
				[1] = 'int32':order
				[2] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
				[3] = 'bool':isReceive
			},
		},
	}
--]]
s2c.SUMMON_RES_SIMULATE_SUMMON_EXCHANGE = 3352

--[[
	[1] = {--ResChooseArea
		[1] = {--repeated AreaInfo
			[1] = 'int32':areaId	[区域id]
			[2] = 'bool':isDevil	[是否封锁了,true是,false没]
			[3] = 'bool':explored	[是否探索过,true是,false没]
			[4] = {--repeated RoadInfo
				[1] = 'int32':startAreaId	[起始区域id]
				[2] = 'int32':endAreaId	[截止区域id]
				[3] = 'bool':unlocked	[是否解锁,true解锁,false未解锁]
			},
		},
		[2] = 'int32':currentAreaId	[区域id]
	}
--]]
s2c.SUMMER_COURAGE_RES_CHOOSE_AREA = 6903

--[[
	[1] = {--RespSupportActivityServerProgress
		[1] = 'int32':activityId	[应援活动ID]
		[2] = 'int32':process	[应援活动全服进度]
		[3] = 'int32':myRank	[ 我的排名]
		[4] = 'int32':realItemMinRank	[ 实物奖励最低排名]
	}
--]]
s2c.ACTIVITY_RESP_SUPPORT_ACTIVITY_SERVER_PROGRESS = 5129

--[[
	[1] = {--ResultSubmitSign
		[1] = 'int32':id	[提交的签到ID]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SIGN_RESULT_SUBMIT_SIGN = 5122

--[[
	[1] = {--RespSignInfos
		[1] = {--repeated SignInfo
			[1] = 'int32':id	[配置id 1:月签到 2:7日签到 3:体力签到 4:次日签到]
			[2] = 'int32':index	[签到位置(次日登录为0,7日签到发的是0,体力签到 也发的是0,只有月签到才发位置)    //签到位置(次日登录为0,7日签到发的是0,体力签到 也发的是0,只有月签到才发位置)]
			[3] = 'string':extendData	[月签到 发送月份]
			[4] = 'repeated int32':awardType	[领取的状态(7日签到才会发所有的) 0 已签到 1 可签到 2 不能签到    //领取的状态(7日签到才会发所有的) 0 已签到 1 可签到 2 不能签到]
			[5] = 'int32':supplyLimit	[可补签的天数]
			[6] = 'repeated int32':supplyDays	[已补签的日期]
		},
	}
--]]
s2c.SIGN_RESP_SIGN_INFOS = 5121

--[[
	[1] = {--RespPurchStore
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SIGN_RESP_PURCH_STORE = 5161

--[[
	[1] = {--RespTreatMember
	}
--]]
s2c.TEAM_RESP_TREAT_MEMBER = 5891

--[[
	[1] = {--ResGrowthFundsInfo
		[1] = 'bool':isGrowthFunds
		[2] = 'repeated int32':awards
	}
--]]
s2c.RECHARGE_RES_GROWTH_FUNDS_INFO = 4370

--[[
	[1] = {--NotifyStartFight
		[1] = 'repeated int32':pids	[ 进入的玩家]
	}
--]]
s2c.FIGHT_NOTIFY_START_FIGHT = 25602

--[[
	[1] = {--ResultShare
		[1] = 'int32':id	[提交的分享ID]
		[2] = 'bool':verify	[是否通过后端的验证,同一天如果玩家已经领过奖励,则视为无效的分享]
	}
--]]
s2c.SHARE_RESULT_SHARE = 6103

--[[
	[1] = {--ResDressNewEquip
		[1] = 'string':heroId	[英雄id]
		[2] = {--repeated EuqipFetterInfo
			[1] = 'int32':index
			[2] = {--NewEquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[新装备id]
				[3] = 'int32':cid	[新装备cid]
				[4] = 'int32':stage	[新装备阶段等级]
				[5] = 'int32':level	[新装备等级]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
			},
		},
	}
--]]
s2c.EQUIPMENT_RES_DRESS_NEW_EQUIP = 2830

--[[
	[1] = {--ResExchange
		[1] = 'int32':itemCid	[ 道具id]
	}
--]]
s2c.SUMMON_RES_EXCHANGE = 3338

--[[
	[1] = {--ResNewWorldMissionInfo
		[1] = {--repeated NewWorldChapter
			[1] = 'int32':chapter
			[2] = 'bool':isOpen
			[3] = {--repeated NewWorldMission
				[1] = 'int32':dungeonId
				[2] = 'int32':fightCount
			},
		},
		[2] = 'repeated int32':passedMission
		[3] = 'repeated int32':firstPassedMission
		[4] = 'int32':endTime
	}
--]]
s2c.NEW_WORLD_RES_NEW_WORLD_MISSION_INFO = 6811

--[[
	[1] = {--ResAcquireBulletScreen
		[1] = {--repeated BulletScreenInfo
			[1] = 'string':playerName
			[2] = 'string':content
			[3] = 'int64':sendTime
			[4] = 'int32':type	[1是自己 0是他人]
			[5] = 'int32':dialogueId	[约会弹幕 句子id]
		},
		[2] = 'int32':type
		[3] = 'int32':version	[  版本号]
	}
--]]
s2c.CHAT_RES_ACQUIRE_BULLET_SCREEN = 2316

--[[
	[1] = {--ResRewardMissionResult
		[1] = 'bool':result
	}
--]]
s2c.NEW_WORLD_RES_REWARD_MISSION_RESULT = 6816

--[[
	[1] = {--QliphothTaskRewardMsg
		[1] = {--ItemList
			[1] = {--repeated ItemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'int64':num	[ 数量]
				[5] = 'int32':outTime	[过期时间]
			},
			[2] = {--repeated EquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[灵装id]
				[3] = 'int32':cid	[灵装cid]
				[4] = 'int32':level	[灵装等级]
				[5] = 'int32':exp	[灵装经验值]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
				[8] = {--repeated SpecialAttr
					[1] = 'int32':cid	[配置id]
					[2] = 'int32':value	[属性值]
					[3] = 'int32':index	[属性服务器顺序]
				},
				[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
				[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
				[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
				[12] = 'int32':outTime	[过期时间]
				[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
				[14] = 'int32':star	[额外星数]
				[15] = 'int32':stage	[阶段]
				[16] = 'int32':num	[数量]
				[17] = 'int32':step	[质点阶级]
			},
			[3] = {--repeated DressInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'string':roleId	[ 装备精灵ID]
				[5] = 'int32':outTime	[过期时间]
			},
			[4] = {--repeated NewEquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[新装备id]
				[3] = 'int32':cid	[新装备cid]
				[4] = 'int32':stage	[新装备阶段等级]
				[5] = 'int32':level	[新装备等级]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
			},
			[5] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[6] = {--repeated TreasureInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝物id]
				[3] = 'int32':cid	[宝物cid]
				[4] = 'int32':star	[宝物星级]
			},
			[7] = {--repeated ExploreEquip
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[探索装备id]
				[3] = 'int32':cid	[探索装备cid]
				[4] = 'int32':level	[探索装备星级]
			},
		},
	}
--]]
s2c.QLIPHOTH_QLIPHOTH_TASK_REWARD = 6216

--[[
	[1] = {--ResRemouldGem
		[1] = {--GemInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[宝石id]
			[3] = 'int32':cid	[宝石cid]
			[4] = 'int32':heroId	[英雄id]
			[5] = 'repeated int32':randSkill	[随机技能]
			[6] = {--GemRandSkill
				[1] = 'int32':originalSkill	[ 原始id]
				[2] = 'int32':newSkill	[ 新id]
			},
		},
	}
--]]
s2c.EQUIPMENT_RES_REMOULD_GEM = 2836

--[[
	[1] = {--ResRewardStatus
		[1] = 'repeated int32':taskList	[领了任务奖励的阶段]
		[2] = 'repeated int32':famousList	[领了名师奖励的等级]
	}
--]]
s2c.APPRENTICE_RES_REWARD_STATUS = 7910

--[[
	[1] = {--ResPropertyChange
		[1] = 'string':heroId
		[2] = {--repeated AttributeInfo
			[1] = 'int32':type	[ 属性类型]
			[2] = 'int32':val	[ 属性值]
		},
		[3] = 'int32':fightPower
	}
--]]
s2c.HERO_RES_PROPERTY_CHANGE = 1043

--[[
	[1] = {--RespLuckyWheel
		[1] = {--TurnInfo
			[1] = 'int32':extraTimes	[ n次必中某道具]
			[2] = 'int32':turnIndex	[上次转盘的位置]
			[3] = {--repeated TurnTimes
				[1] = 'int32':turnId	[ 轮盘道具ID]
				[2] = 'int32':times	[道具的次数]
			},
			[4] = {--repeated TurnEffectInfo
				[1] = 'int32':cfgId	[配置id]
				[2] = 'int32':effectId	[1双倍 2 再转一次]
			},
		},
		[2] = 'int32':times	[轮盘次数]
		[3] = {--repeated RewardsTagMsg
			[1] = 'int32':id
			[2] = 'int32':num
			[3] = 'int32':tag
		},
		[4] = 'repeated int32':locations	[转盘转动的位置列表]
		[5] = 'repeated int32':eventLocations	[转盘转动的特殊位置列表]
	}
--]]
s2c.SACRIFICE_RESP_LUCKY_WHEEL = 8002

--[[
	[1] = {--RspNewSpiritInfo
		[1] = {--HeroSpiritInfo
			[1] = 'int32':spiritPoints	[可用灵力点数]
			[2] = 'int32':grade	[品阶从0开始]
			[3] = 'int32':level	[级数从0开始]
			[4] = 'int64':exp	[经验值]
			[5] = {--repeated HeroSpiritProperty
				[1] = 'int32':cid	[cid]
				[2] = 'int32':num	[点数]
			},
			[6] = 'bool':firstShow	[首次开启展示true即为要显示false则不显示]
			[7] = 'bool':feedback	[旧灵力系统是否已返回资源]
			[8] = {--repeated HeroAngleSpirit
				[1] = 'int32':heroCid	[cid]
				[2] = 'int32':lv	[点数]
			},
			[9] = 'int32':maxLv	[可升级上限]
		},
	}
--]]
s2c.HERO_SPIRIT_RSP_NEW_SPIRIT_INFO = 8407

--[[
	[1] = {--RespFriends
		[1] = {--repeated FriendInfo
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':name	[ 名字]
			[3] = 'int32':fightPower	[ 战力]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int32':lastLoginTime	[ 最后登录时间]
			[6] = 'int32':lastHandselTime	[ 最后送礼时间]
			[7] = 'bool':receive	[ 是否能够领取]
			[8] = 'int32':status	[ 状态:1:好友,2:屏蔽,3:申请]
			[9] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
			[10] = 'bool':online	[ 是否在线]
			[11] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[12] = 'int32':time	[ 申请时间/加入黑名单时间等]
			[13] = 'int32':helpCDtime	[ 助战cd结束时间(秒)    // 助战cd结束时间(秒)]
			[14] = 'bool':canSend	[ 是否可以赠送]
			[15] = 'int32':portraitCid	[ 头像CID]
			[16] = 'int32':portraitFrameCid	[ 头像框CID]
			[17] = 'repeated int32':groupGiftIds	[团购礼包id]
			[18] = 'int32':type	[0没有关系,1他是我师父,2他是我徒弟,不包括出师的徒弟]
		},
		[2] = 'int32':receiveCount	[ 已领取次数]
		[3] = 'int32':lastReceiveTime	[ 最后领取时间]
	}
--]]
s2c.FRIEND_RESP_FRIENDS = 3073

--[[
	[1] = {--RecordBuffList
		[1] = 'repeated int32':buffId	[buffId]
	}
--]]
s2c.SACRIFICE_RECORD_BUFF_LIST = 8006

--[[
	[1] = {--ResCompleteSTTask
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--repeated SimulateTrainTask
			[1] = 'int32':id	[ 任务id]
			[2] = {--STTaskStaus(enum)
				'v4':STTaskStaus
			},
		},
	}
--]]
s2c.HERO_RES_COMPLETE_STTASK = 1047

--[[
	[1] = {--RespUiChangeInfo
		[1] = {--repeated UiChangeInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':cid
		},
		[2] = 'int32':wearId
	}
--]]
s2c.MEDAL_RESP_UI_CHANGE_INFO = 3010

--[[
	[1] = {--TouchRole
	}
--]]
s2c.ROLE_TOUCH_ROLE = 1287

--[[
	[1] = {--RoleInfo
		[1] = {--ChangeType(enum)
			'v4':ChangeType
		},
		[2] = 'string':id	[ 实例ID]
		[3] = 'int32':cid	[ 配置ID]
		[4] = 'int32':favor	[好感度]
		[5] = 'int32':mood	[ 心情]
		[6] = 'int32':status	[ 状态 0:未使用 1:使用]
		[7] = 'repeated int32':unlockGift	[ 解锁的礼品]
		[8] = 'repeated int32':unlockHobby	[ 解锁的爱好]
		[9] = {--DressInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'string':roleId	[ 装备精灵ID]
			[5] = 'int32':outTime	[过期时间]
		},
		[10] = 'int32':roomId	[房间id]
		[11] = 'bool':favorCriticalPoint	[好感度临界点]
		[12] = 'int32':roleState	[精灵3状态]
		[13] = 'repeated int32':favoriteIds	[ 精灵喜欢的食物或者礼物]
		[14] = 'bool':isShow	[是否已经解锁]
	}
--]]
s2c.ROLE_ROLE_INFO = 1283

--[[
	[1] = {--RspEndlessRankList
		[1] = {--repeated RspEndlessRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':stage	[最高层数]
			[4] = 'int32':costTime	[总用时]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
		},
		[2] = {--RspEndlessRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':stage	[最高层数]
			[4] = 'int32':costTime	[总用时]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
		},
		[3] = 'int32':refreshMinu	[刷新周期,分钟]
		[4] = {--repeated RspEndlessRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':stage	[最高层数]
			[4] = 'int32':costTime	[总用时]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
		},
		[5] = {--RspEndlessRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':stage	[最高层数]
			[4] = 'int32':costTime	[总用时]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
		},
		[6] = {--repeated RspEndlessRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':stage	[最高层数]
			[4] = 'int32':costTime	[总用时]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
		},
		[7] = {--RspEndlessRank
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':stage	[最高层数]
			[4] = 'int32':costTime	[总用时]
			[5] = 'int32':rank	[排名,0则为未上榜]
			[6] = 'int32':headId	[头像]
			[7] = 'int32':level	[等级]
		},
	}
--]]
s2c.ENDLESS_CLOISTER_RSP_ENDLESS_RANK_LIST = 5380

--[[
	[1] = {--SpecialItemUsePush
		[1] = 'int32':cid
		[2] = 'int32':num
	}
--]]
s2c.ITEM_SPECIAL_ITEM_USE_PUSH = 520

--[[
	[1] = {--ResEquipPassiveSkill
		[1] = 'string':heroId
		[2] = {--PassiveSkillInfo
			[1] = 'int32':pos
			[2] = 'int32':skillId
		},
	}
--]]
s2c.HERO_RES_EQUIP_PASSIVE_SKILL = 1041

--[[
	[1] = {--ResModifyStrategyName
		[1] = 'string':heroId
		[2] = 'int32':skillStrategyId
		[3] = 'string':name
	}
--]]
s2c.HERO_RES_MODIFY_STRATEGY_NAME = 1039

--[[
	[1] = {--PerformEventMsg
	}
--]]
s2c.QLIPHOTH_PERFORM_EVENT = 6220

--[[
	[1] = {--ChangeRoom
	}
--]]
s2c.ROLE_CHANGE_ROOM = 1288

--[[
	[1] = {--RoleInfoList
		[1] = {--repeated RoleInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':favor	[好感度]
			[5] = 'int32':mood	[ 心情]
			[6] = 'int32':status	[ 状态 0:未使用 1:使用]
			[7] = 'repeated int32':unlockGift	[ 解锁的礼品]
			[8] = 'repeated int32':unlockHobby	[ 解锁的爱好]
			[9] = {--DressInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'string':roleId	[ 装备精灵ID]
				[5] = 'int32':outTime	[过期时间]
			},
			[10] = 'int32':roomId	[房间id]
			[11] = 'bool':favorCriticalPoint	[好感度临界点]
			[12] = 'int32':roleState	[精灵3状态]
			[13] = 'repeated int32':favoriteIds	[ 精灵喜欢的食物或者礼物]
			[14] = 'bool':isShow	[是否已经解锁]
		},
		[2] = 'repeated int32':rotationList	[轮换列表]
		[3] = 'bool':rotationState	[轮换是否开启]
	}
--]]
s2c.ROLE_ROLE_INFO_LIST = 1281

--[[
	[1] = {--UnlockRoom
	}
--]]
s2c.ROLE_UNLOCK_ROOM = 1289

--[[
	[1] = {--GroupMultipleRewardMsg
		[1] = {--repeated GroupMultipleInfo
			[1] = 'int32':groupId	[关卡组id]
			[2] = 'string':multiple	[倍数]
			[3] = 'int32':topStarsLevel	[满星通过的最高关]
		},
	}
--]]
s2c.DUNGEON_GROUP_MULTIPLE_REWARD = 1809

--[[
	[1] = {--ResMoncardSign
		[1] = {--MonthCardSignInfo
			[1] = 'int32':signDays	[累计签到天数]
			[2] = 'bool':canSign	[是否可签到]
			[3] = 'int32':actRemain	[双倍活动剩余时间]
			[4] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[5] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[6] = 'int32':extDay	[额外奖励天数]
			[7] = 'bool':subscibe	[是否已订阅月卡]
			[8] = 'int32':subscibeTime	[月卡信息]
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.RECHARGE_RES_MONCARD_SIGN = 4366

--[[
	[1] = {--UpdateDressGroup
		[1] = {--repeated DressGroup
			[1] = 'int32':group	[时装分组id]
			[2] = 'int32':curDressId	[选中的时装id]
		},
	}
--]]
s2c.ROLE_UPDATE_DRESS_GROUP = 1292

--[[
	[1] = {--RespCrossSupportInfo
		[1] = 'int64':score	[全服应援分数]
		[2] = 'int32':myScore
		[3] = 'int32':totalPay
		[4] = 'int32':onlineTime
		[5] = {--repeated CrossSupportRank
			[1] = 'int32':playerId
			[2] = 'int32':score
			[3] = 'int32':rank
			[4] = 'string':name
			[5] = 'string':unionName
			[6] = 'int32':serverId
			[7] = 'int32':headId
			[8] = 'int32':headFrameId
		},
		[6] = 'bool':isFirst
	}
--]]
s2c.ACTIVITY_RESP_CROSS_SUPPORT_INFO = 5205

--[[
	[1] = {--ResStrongholdInfo
		[1] = {--Stronghold
			[1] = 'int32':id
			[2] = 'int32':state
			[3] = 'int64':startTime
			[4] = 'int64':endTime
			[5] = 'int32':useSupTimes
			[6] = 'int32':progress
			[7] = {--repeated Event
				[1] = 'int32':id
				[2] = 'int32':state
				[3] = 'int64':startTime
			},
			[8] = {--repeated Role
				[1] = 'int32':roleId
			},
			[9] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
			[10] = {--repeated SupportRole
				[1] = 'int64':playerId
				[2] = 'string':playerName
				[3] = 'int64':startTime
				[4] = 'int32':times
				[5] = {--Role
					[1] = 'int32':roleId
				},
				[6] = {--repeated Buff
					[1] = 'int32':buffId
					[2] = 'int32':buffLv
				},
			},
		},
	}
--]]
s2c.HANGUP_ACT_RES_STRONGHOLD_INFO = 9011

--[[
	[1] = {--Dress
	}
--]]
s2c.ROLE_DRESS = 1284

--[[
	[1] = {--RespRotation
		[1] = 'repeated int32':rotationList	[轮换列表]
	}
--]]
s2c.ROLE_RESP_ROTATION = 1290

--[[
	[1] = {--SettleInfo
		[1] = {--DatingInfo
			[1] = 'int32':datingType	[约会类型1 外传 2 主线]
			[2] = 'int32':datingValue	[当类型为外传时,值传外传ID,主线则为主线章节]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'repeated int32':endings	[结局]
			[5] = 'int32':stepTime	[ 阶段时间]
			[6] = {--repeated EntranceInfo
				[1] = 'int32':entranceId	[入口id]
				[2] = 'bool':guide	[值]
			},
			[7] = {--repeated QualityInfo
				[1] = 'int32':qualityId	[对应DatingVariable表id]
				[2] = 'int32':value	[值]
			},
		},
	}
--]]
s2c.EXTRA_DATING_SETTLE_INFO = 5637

--[[
	[1] = {--RespGetUnionPlayerRank
		[1] = {--repeated UnionPlayerDamage
			[1] = 'int32':rank	[排名]
			[2] = 'int32':playerId	[玩家id]
			[3] = 'int32':damage	[伤害列表]
			[4] = 'int32':count	[玩家攻击次数]
		},
	}
--]]
s2c.JU_NAI_INVASION_RESP_GET_UNION_PLAYER_RANK = 9106

--[[
	[1] = {--RespSetRotationOpen
		[1] = 'bool':rotationState	[轮换是否开启]
	}
--]]
s2c.ROLE_RESP_SET_ROTATION_OPEN = 1291

--[[
	[1] = {--RespCookFoodbase
		[1] = 'int32':foodId
		[2] = 'int32':endTime
		[3] = 'int32':times
	}
--]]
s2c.NEW_BUILDING_RESP_COOK_FOODBASE = 2067

--[[
	[1] = {--ResDetectiveGameFinish
		[1] = 'bool':finished	[游戏是否完成了]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.DETECTIVE_RES_DETECTIVE_GAME_FINISH = 8904

--[[
	[1] = {--UpdateDiamondDebt
		[1] = 'int32':count
	}
--]]
s2c.ITEM_UPDATE_DIAMOND_DEBT = 521

--[[
	[1] = {--SyncAreaPlayerPos
		[1] = {--repeated AreaPlayerPosInfo
			[1] = 'int32':pid	[ 玩家ID]
			[2] = {--AreaPlayerPos
				[1] = 'int32':x
				[2] = 'int32':y
				[3] = 'int32':dir
				[4] = 'int32':dt
			},
			[3] = 'int32':buildId	[游戏id]
		},
		[2] = 'int32':roomType	[大世界类型]
	}
--]]
s2c.NEW_WORLD_SYNC_AREA_PLAYER_POS = 6802

--[[
	[1] = {--ResSummonPreview
		[1] = {--repeated SummonPreview
			[1] = 'int32':groupId
			[2] = 'int32':type
			[3] = 'int32':typeName
			[4] = {--repeated SummonPreviewItems
				[1] = 'int32':id
				[2] = 'int32':order
				[3] = 'int32':name
				[4] = 'int32':probability
				[5] = 'int32':noobProbability
				[6] = 'bool':showUpTips
			},
		},
	}
--]]
s2c.SUMMON_RES_SUMMON_PREVIEW = 3344

--[[
	[1] = {--ResOpenEnvelope
		[1] = 'int32':result	[1成功,2失败.失败原因是红包过期了]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.RED_ENVELOPE_RES_OPEN_ENVELOPE = 7304

--[[
	[1] = {--ResOpenAllEnvelope
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.RED_ENVELOPE_RES_OPEN_ALL_ENVELOPE = 7305

--[[
	[1] = {--UnionDonate
		[1] = 'int32':itemId	[ 货币id]
		[2] = 'int32':donateVal	[捐赠数量]
	}
--]]
s2c.UNION_UNION_DONATE = 6656

--[[
	[1] = {--RespOperate
		[1] = 'int32':type	[ 操作类型]
		[2] = 'repeated int32':targets	[ 目标ID]
	}
--]]
s2c.FRIEND_RESP_OPERATE = 3074

--[[
	[1] = {--RespKurumiCityRefresh
		[1] = {--repeated KurumiHistoryCity
			[1] = 'int32':id	[城市id]
			[2] = 'int32':dungeon	[当前关卡]
			[3] = 'bool':resOpen	[是否解锁资源]
			[4] = 'int32':resCount	[资源可用次数]
			[5] = 'int32':resUpTime	[下次资源增加时间]
			[6] = 'bool':invaded	[是否入侵]
			[7] = 'int32':invadedEnd	[入侵结束时间]
			[8] = 'repeated int32':invadedCamp	[入侵阵营]
			[9] = 'int32':resStartTime	[资源开始时间]
			[10] = 'int32':fightTime	[战斗时间]
			[11] = 'int32':score	[贡献积分]
			[12] = 'bool':pass	[是否通关]
			[13] = 'bool':dunPass	[是否已通过关卡]
		},
	}
--]]
s2c.ACTIVITY_RESP_KURUMI_CITY_REFRESH = 5167

--[[
	[1] = {--ResAnnivFlop
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ANNIVERSARY2ND_RES_ANNIV_FLOP = 9201

--[[
	[1] = {--DatingScriptMsg	[通用剧本]
		[1] = 'int32':datingRuleCid	[剧本cid]
		[2] = {--repeated BranchNode
			[1] = 'int32':datingId	[约会配置id]
			[2] = 'repeated int32':nextNodeIds	[下级节点id]
		},
		[3] = 'bool':isFirst	[是否是第一次进入该剧本]
		[4] = 'string':datingId
	}
--]]
s2c.DATING_DATING_SCRIPT = 1542

--[[
	[1] = {--RespDiceContract
		[1] = 'int32':activityId
		[2] = 'int32':step	[骰子的步数]
		[3] = 'repeated int32':locations	[当前位置地点有那些]
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[5] = 'bool':triggerClear	[是否触发了清层随机事件]
	}
--]]
s2c.ACTIVITY_RESP_DICE_CONTRACT = 5185

--[[
	[1] = {--ResFightEnvelope
		[1] = 'string':id	[唯一id,没抢到就是0]
		[2] = 'int32':result	[结果1成功,0红包不存在,-1抢完了,-2玩家已经抢过了    //结果1成功,0红包不存在,-1抢完了,-2玩家已经抢过了]
	}
--]]
s2c.RED_ENVELOPE_RES_FIGHT_ENVELOPE = 7303

--[[
	[1] = {--RspStepEquipPreview
		[1] = 'string':equipId	[要升阶的质点]
		[2] = 'string':costEquipId	[消耗的同名质点id]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EQUIPMENT_RSP_STEP_EQUIP_PREVIEW = 2861

--[[
	[1] = {--Afk7804
	}
--]]
s2c.EXPLORE_AFK7804 = 7804

--[[
	[1] = {--OfficeTransformMsg
		[1] = {--GridMapPoint
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'int32':event	[ 事件id,大于0则有事件]
			[4] = 'bool':eventValid	[ 事件是否可用]
			[5] = 'bool':visual	[ 是否可视,即是否开启格子]
			[6] = {--repeated GridPointInfo
				[1] = 'int32':x	[ x位置]
				[2] = 'int32':y	[ y位置]
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_TRANSFORM = 7211

--[[
	[1] = {--RespRefreshEntrustActivityTask
	}
--]]
s2c.ACTIVITY_RESP_REFRESH_ENTRUST_ACTIVITY_TASK = 5133

--[[
	[1] = {--SpringEnvelopeNotice
		[1] = {--repeated SpringEnvelopeInfo
			[1] = 'int32':id	[id]
			[2] = 'int32':sendCount	[发送个数]
			[3] = 'int32':receiveCount	[抢的个数]
			[4] = 'int64':lastTime	[上次发送时间]
			[5] = 'int32':money	[总金额]
		},
	}
--]]
s2c.RED_ENVELOPE_SPRING_ENVELOPE_NOTICE = 7308

--[[
	[1] = {--BuyRecordInfo
		[1] = {--ChangeType(enum)
			'v4':ChangeType
		},
		[2] = 'int32':cid
		[3] = 'int32':buy_count	[购买次数]
	}
--]]
s2c.RECHARGE_BUY_RECORD_INFO = 4358

--[[
	[1] = {--ResSaveEquipBackupDecr
		[1] = {--EquipBackupInfo
			[1] = 'int32':id	[ 方案id]
			[2] = 'string':desc	[方案描述]
			[3] = {--repeated EquipBackupServer
				[1] = 'int32':position	[质点位置]
				[2] = 'string':equipId	[质点id]
			},
		},
	}
--]]
s2c.EQUIPMENT_RES_SAVE_EQUIP_BACKUP_DECR = 2843

--[[
	[1] = {--Resp2019ChristmasFactory
		[1] = 'int32':count	[可领奖次数]
		[2] = 'int32':nextTime	[下次刷新时间点]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[5] = 'repeated int32':talents	[改造天赋]
		[6] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[7] = 'int32':maxCount	[最大次数]
	}
--]]
s2c.CHRISTMAS_RESP2019_CHRISTMAS_FACTORY = 6614

--[[
	[1] = {--Donate
		[1] = 'int32':favoriteId	[精灵喜欢的食物或者礼物]
	}
--]]
s2c.ROLE_DONATE = 1282

--[[
	[1] = {--ResHandleApprentice
		[1] = 'bool':success	[true成功]
		[2] = 'int32':type	[同请求的type]
	}
--]]
s2c.APPRENTICE_RES_HANDLE_APPRENTICE = 7902

--[[
	[1] = {--ResFavorDatingTestInfo
		[1] = {--repeated QualityInfo
			[1] = 'int32':qualityId	[对应DatingVariable表id]
			[2] = 'int32':value	[值]
		},
		[2] = 'repeated int32':signList	[拥有标记列表]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EXTRA_DATING_RES_FAVOR_DATING_TEST_INFO = 5660

--[[
	[1] = {--GetRechargeCfg
		[1] = {--repeated MonthCardCfg
			[1] = {--RechargeCfg
				[1] = 'int32':id
				[2] = 'float':price	[价格]
			},
			[2] = 'int32':upgradeId	[升级id]
			[3] = 'string':icon
			[4] = 'string':name
			[5] = 'string':des1
			[6] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[7] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[8] = 'int32':days	[持续领取天数]
			[9] = 'int32':type	[卡类型:1.月卡 2.季卡 3.年卡]
			[10] = 'string':name2
			[11] = 'string':des3
			[12] = 'int32':tagIcon
			[13] = 'int32':interfaceType	[显示类型]
			[14] = 'int32':buyType	[购买方式 0rmb充值 1代币兑换]
			[15] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[16] = 'repeated int32':packType	[可使用代金券类型]
			[17] = 'string':extendData	[扩展数据]
		},
		[2] = {--repeated RechargeGiftBagCfg
			[1] = {--RechargeCfg
				[1] = 'int32':id
				[2] = 'float':price	[价格]
			},
			[2] = 'int32':type	[所属界面]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'string':name
			[5] = 'string':icon
			[6] = 'bool':tag
			[7] = 'string':tagDes
			[8] = 'string':tagDes2
			[9] = 'string':des1
			[10] = 'string':des2
			[11] = 'int32':order	[排序]
			[12] = 'int32':startDate	[开始时间]
			[13] = 'int32':endDate	[结束时间]
			[14] = 'int32':buyCount	[限制购买次数]
			[15] = 'int32':resetType	[重置类型 0.不重置 1.每日重置 2.每周重置 3.每月重置]
			[16] = 'int32':resetDate	[重置时间 默认为周一.一日重置,否则周日=1,周一=2,以此类推]
			[17] = 'repeated int32':playerLevel	[玩家等级限制]
			[18] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[19] = 'string':name2
			[20] = 'string':des3
			[21] = 'int32':tagIcon
			[22] = 'int32':interfaceType	[显示类型]
			[23] = 'int32':buyType	[购买方式 0rmb充值 1代币兑换]
			[24] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[25] = 'repeated int32':packType	[可使用代金券类型]
			[26] = 'int32':originalPrice
			[27] = 'int32':discount
			[28] = 'int32':triggerEndDate
			[29] = 'bool':isTrigger
			[30] = 'int32':days	[持续领取天数]
			[31] = 'string':extendData	[扩展数据]
		},
	}
--]]
s2c.RECHARGE_GET_RECHARGE_CFG = 4360

--[[
	[1] = {--ResCheat
	}
--]]
s2c.PLAYER_RES_CHEAT = 286

--[[
	[1] = {--RespGetWarOrderInfo
		[1] = 'int32':level	[等级]
		[2] = 'int32':exp	[经验值]
		[3] = 'repeated int32':propList	[领取的道具列表]
	}
--]]
s2c.ACTIVITY_RESP_GET_WAR_ORDER_INFO = 5147

--[[
	[1] = {--ResFetchGift
		[1] = 'bool':success	[true成功]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.APPRENTICE_RES_FETCH_GIFT = 7905

--[[
	[1] = {--RespUploadQteIntegral
		[1] = 'int32':foodId
		[2] = 'int32':qteId
		[3] = 'int32':integral
		[4] = 'int32':qteIntegral
	}
--]]
s2c.NEW_BUILDING_RESP_UPLOAD_QTE_INTEGRAL = 2068

--[[
	[1] = {--ResMyGroupTeam
		[1] = {--repeated GroupTeamInfo
			[1] = 'string':teamId	[队伍id]
			[2] = 'int32':createTime	[创建时间]
			[3] = 'int32':giftId	[礼包id]
			[4] = 'bool':isShow	[是否显示]
			[5] = 'bool':isComplete	[是否完成]
			[6] = 'bool':isDestroy	[是否销毁]
			[7] = {--repeated GroupTeamMember
				[1] = 'int32':playerId
				[2] = 'string':playerName
				[3] = 'int32':titleId
				[4] = 'int32':level
				[5] = 'bool':isCreator
				[6] = 'int32':portraitCid
				[7] = 'int32':portraitFrameId
			},
		},
	}
--]]
s2c.RECHARGE_RES_MY_GROUP_TEAM = 4383

--[[
	[1] = {--ResChargeExchange
		[1] = 'int32':rechargeId	[充值档位id]
		[2] = 'int32':buyCount	[购买数量]
	}
--]]
s2c.RECHARGE_RES_CHARGE_EXCHANGE = 4368

--[[
	[1] = {--RspEquipItem
		[1] = 'int32':equipItemCid	[下次使用道具(当前装备道具)    //下次使用道具(当前装备道具)]
	}
--]]
s2c.ZILLIONAIRE_RSP_EQUIP_ITEM = 5321

--[[
	[1] = {--ResUpStarEquip
		[1] = {--EquipmentInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[灵装id]
			[3] = 'int32':cid	[灵装cid]
			[4] = 'int32':level	[灵装等级]
			[5] = 'int32':exp	[灵装经验值]
			[6] = 'string':heroId	[英雄id]
			[7] = 'int32':position	[装备位置]
			[8] = {--repeated SpecialAttr
				[1] = 'int32':cid	[配置id]
				[2] = 'int32':value	[属性值]
				[3] = 'int32':index	[属性服务器顺序]
			},
			[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
			[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
			[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
			[12] = 'int32':outTime	[过期时间]
			[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
			[14] = 'int32':star	[额外星数]
			[15] = 'int32':stage	[阶段]
			[16] = 'int32':num	[数量]
			[17] = 'int32':step	[质点阶级]
		},
	}
--]]
s2c.EQUIPMENT_RES_UP_STAR_EQUIP = 2835

--[[
	[1] = {--RespBuyResourcesLog
		[1] = {--repeated BuyResourcesLog
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':cid
			[3] = 'int32':count
			[4] = 'int32':discountNum	[月卡特权打折次数]
		},
	}
--]]
s2c.PLAYER_RESP_BUY_RESOURCES_LOG = 276

--[[
	[1] = {--RespWeekCardInfo
		[1] = 'int32':signDays	[累计签到天数]
		[2] = 'bool':canSign	[是否可签到]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[5] = 'int32':etime	[剩余的天数]
	}
--]]
s2c.RECHARGE_RESP_WEEK_CARD_INFO = 4387

--[[
	[1] = {--ResTriggerGiftInfo
		[1] = {--repeated RechargeGiftBagCfg
			[1] = {--RechargeCfg
				[1] = 'int32':id
				[2] = 'float':price	[价格]
			},
			[2] = 'int32':type	[所属界面]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'string':name
			[5] = 'string':icon
			[6] = 'bool':tag
			[7] = 'string':tagDes
			[8] = 'string':tagDes2
			[9] = 'string':des1
			[10] = 'string':des2
			[11] = 'int32':order	[排序]
			[12] = 'int32':startDate	[开始时间]
			[13] = 'int32':endDate	[结束时间]
			[14] = 'int32':buyCount	[限制购买次数]
			[15] = 'int32':resetType	[重置类型 0.不重置 1.每日重置 2.每周重置 3.每月重置]
			[16] = 'int32':resetDate	[重置时间 默认为周一.一日重置,否则周日=1,周一=2,以此类推]
			[17] = 'repeated int32':playerLevel	[玩家等级限制]
			[18] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[19] = 'string':name2
			[20] = 'string':des3
			[21] = 'int32':tagIcon
			[22] = 'int32':interfaceType	[显示类型]
			[23] = 'int32':buyType	[购买方式 0rmb充值 1代币兑换]
			[24] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[25] = 'repeated int32':packType	[可使用代金券类型]
			[26] = 'int32':originalPrice
			[27] = 'int32':discount
			[28] = 'int32':triggerEndDate
			[29] = 'bool':isTrigger
			[30] = 'int32':days	[持续领取天数]
			[31] = 'string':extendData	[扩展数据]
		},
		[2] = 'int32':pushStatus	[推送状态,1 增加 2 移除]
	}
--]]
s2c.RECHARGE_RES_TRIGGER_GIFT_INFO = 4372

--[[
	[1] = {--ResChapterMap
		[1] = {--repeated AreaInfo
			[1] = 'int32':areaId	[区域id]
			[2] = 'bool':isDevil	[是否封锁了,true是,false没]
			[3] = 'bool':explored	[是否探索过,true是,false没]
			[4] = {--repeated RoadInfo
				[1] = 'int32':startAreaId	[起始区域id]
				[2] = 'int32':endAreaId	[截止区域id]
				[3] = 'bool':unlocked	[是否解锁,true解锁,false未解锁]
			},
		},
		[2] = 'int32':currentAreaId	[当前所在区域]
	}
--]]
s2c.SUMMER_COURAGE_RES_CHAPTER_MAP = 6904

--[[
	[1] = {--GetBuyRecordInfo
		[1] = {--repeated BuyRecordInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':cid
			[3] = 'int32':buy_count	[购买次数]
		},
	}
--]]
s2c.RECHARGE_GET_BUY_RECORD_INFO = 4357

--[[
	[1] = {--PushChangeRechargeCfg
		[1] = {--repeated RechargeGiftBagCfg
			[1] = {--RechargeCfg
				[1] = 'int32':id
				[2] = 'float':price	[价格]
			},
			[2] = 'int32':type	[所属界面]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'string':name
			[5] = 'string':icon
			[6] = 'bool':tag
			[7] = 'string':tagDes
			[8] = 'string':tagDes2
			[9] = 'string':des1
			[10] = 'string':des2
			[11] = 'int32':order	[排序]
			[12] = 'int32':startDate	[开始时间]
			[13] = 'int32':endDate	[结束时间]
			[14] = 'int32':buyCount	[限制购买次数]
			[15] = 'int32':resetType	[重置类型 0.不重置 1.每日重置 2.每周重置 3.每月重置]
			[16] = 'int32':resetDate	[重置时间 默认为周一.一日重置,否则周日=1,周一=2,以此类推]
			[17] = 'repeated int32':playerLevel	[玩家等级限制]
			[18] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[19] = 'string':name2
			[20] = 'string':des3
			[21] = 'int32':tagIcon
			[22] = 'int32':interfaceType	[显示类型]
			[23] = 'int32':buyType	[购买方式 0rmb充值 1代币兑换]
			[24] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[25] = 'repeated int32':packType	[可使用代金券类型]
			[26] = 'int32':originalPrice
			[27] = 'int32':discount
			[28] = 'int32':triggerEndDate
			[29] = 'bool':isTrigger
			[30] = 'int32':days	[持续领取天数]
			[31] = 'string':extendData	[扩展数据]
		},
		[2] = {--repeated MonthCardCfg
			[1] = {--RechargeCfg
				[1] = 'int32':id
				[2] = 'float':price	[价格]
			},
			[2] = 'int32':upgradeId	[升级id]
			[3] = 'string':icon
			[4] = 'string':name
			[5] = 'string':des1
			[6] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[7] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[8] = 'int32':days	[持续领取天数]
			[9] = 'int32':type	[卡类型:1.月卡 2.季卡 3.年卡]
			[10] = 'string':name2
			[11] = 'string':des3
			[12] = 'int32':tagIcon
			[13] = 'int32':interfaceType	[显示类型]
			[14] = 'int32':buyType	[购买方式 0rmb充值 1代币兑换]
			[15] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[16] = 'repeated int32':packType	[可使用代金券类型]
			[17] = 'string':extendData	[扩展数据]
		},
		[3] = {--repeated RechargeGiftBagCfg
			[1] = {--RechargeCfg
				[1] = 'int32':id
				[2] = 'float':price	[价格]
			},
			[2] = 'int32':type	[所属界面]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'string':name
			[5] = 'string':icon
			[6] = 'bool':tag
			[7] = 'string':tagDes
			[8] = 'string':tagDes2
			[9] = 'string':des1
			[10] = 'string':des2
			[11] = 'int32':order	[排序]
			[12] = 'int32':startDate	[开始时间]
			[13] = 'int32':endDate	[结束时间]
			[14] = 'int32':buyCount	[限制购买次数]
			[15] = 'int32':resetType	[重置类型 0.不重置 1.每日重置 2.每周重置 3.每月重置]
			[16] = 'int32':resetDate	[重置时间 默认为周一.一日重置,否则周日=1,周一=2,以此类推]
			[17] = 'repeated int32':playerLevel	[玩家等级限制]
			[18] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[19] = 'string':name2
			[20] = 'string':des3
			[21] = 'int32':tagIcon
			[22] = 'int32':interfaceType	[显示类型]
			[23] = 'int32':buyType	[购买方式 0rmb充值 1代币兑换]
			[24] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[25] = 'repeated int32':packType	[可使用代金券类型]
			[26] = 'int32':originalPrice
			[27] = 'int32':discount
			[28] = 'int32':triggerEndDate
			[29] = 'bool':isTrigger
			[30] = 'int32':days	[持续领取天数]
			[31] = 'string':extendData	[扩展数据]
		},
		[4] = {--repeated MonthCardCfg
			[1] = {--RechargeCfg
				[1] = 'int32':id
				[2] = 'float':price	[价格]
			},
			[2] = 'int32':upgradeId	[升级id]
			[3] = 'string':icon
			[4] = 'string':name
			[5] = 'string':des1
			[6] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[7] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[8] = 'int32':days	[持续领取天数]
			[9] = 'int32':type	[卡类型:1.月卡 2.季卡 3.年卡]
			[10] = 'string':name2
			[11] = 'string':des3
			[12] = 'int32':tagIcon
			[13] = 'int32':interfaceType	[显示类型]
			[14] = 'int32':buyType	[购买方式 0rmb充值 1代币兑换]
			[15] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[16] = 'repeated int32':packType	[可使用代金券类型]
			[17] = 'string':extendData	[扩展数据]
		},
	}
--]]
s2c.RECHARGE_PUSH_CHANGE_RECHARGE_CFG = 4369

--[[
	[1] = {--ResMySupportInfo
		[1] = {--repeated SupportRole
			[1] = 'int64':playerId
			[2] = 'string':playerName
			[3] = 'int64':startTime
			[4] = 'int32':times
			[5] = {--Role
				[1] = 'int32':roleId
			},
			[6] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
		},
	}
--]]
s2c.HANGUP_ACT_RES_MY_SUPPORT_INFO = 9014

--[[
	[1] = {--OpenExchangePanel
		[1] = 'int32':friendId	[好友id]
		[2] = 'bool':result	[是否弹面板 true弹交易面板 false交易取消]
	}
--]]
s2c.ACTIVITY_OPEN_EXCHANGE_PANEL = 5196

--[[
	[1] = {--ResQuickReceiveFriendHelpTask
		[1] = {--repeated FriendHelpInfo
			[1] = 'int32':playerId
			[2] = 'string':playerName
			[3] = 'int32':portraitCid
			[4] = 'int32':portraitFrameCid
			[5] = 'int32':level
			[6] = {--repeated FriendHelpTaskInfo
				[1] = 'int32':taskId
				[2] = {--FriendHelpTaskStatus(enum)
					'v4':FriendHelpTaskStatus
				},
			},
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.FRIEND_RES_QUICK_RECEIVE_FRIEND_HELP_TASK = 3092

--[[
	[1] = {--ResTotalPayRewardCfg
		[1] = {--repeated TotalPayRewardCfg
			[1] = 'int32':id	[id]
			[2] = 'bool':canReward	[是否可以领取]
			[3] = 'int32':amount	[领取条件(累积充值x金额:分)    //领取条件(累积充值x金额:分)]
			[4] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[5] = 'int32':order	[排序]
			[6] = 'string':des	[描述]
		},
	}
--]]
s2c.RECHARGE_RES_TOTAL_PAY_REWARD_CFG = 4362

--[[
	[1] = {--ResMoncardStore
		[1] = 'int32':id	[礼包Id]
		[2] = 'int32':buyCount	[购买次数]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.RECHARGE_RES_MONCARD_STORE = 4367

--[[
	[1] = {--ResGroupGiftInfo
		[1] = {--repeated GroupGiftInfo
			[1] = 'int32':giftId
			[2] = 'int32':status	[ 0 不能领取 1 可领取  2 已领取]
		},
	}
--]]
s2c.RECHARGE_RES_GROUP_GIFT_INFO = 4384

--[[
	[1] = {--ResReceiveLevelAward
		[1] = 'int32':id	[ 成长基金id]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.RECHARGE_RES_RECEIVE_LEVEL_AWARD = 4371

--[[
	[1] = {--ResultSupplySign
		[1] = 'int32':id	[提交的签到ID]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SIGN_RESULT_SUPPLY_SIGN = 5123

--[[
	[1] = {--ResSendGift
		[1] = 'bool':success	[true成功]
	}
--]]
s2c.APPRENTICE_RES_SEND_GIFT = 7904

--[[
	[1] = {--ResReceiveGroupGift
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--repeated GroupGiftInfo
			[1] = 'int32':giftId
			[2] = 'int32':status	[ 0 不能领取 1 可领取  2 已领取]
		},
	}
--]]
s2c.RECHARGE_RES_RECEIVE_GROUP_GIFT = 4381

--[[
	[1] = {--RespCancelChallenge
	}
--]]
s2c.DUNGEON_RESP_CANCEL_CHALLENGE = 1819

--[[
	[1] = {--NewResultSubmitActivity
		[1] = 'int32':activityid	[提交的活动ID]
		[2] = 'int32':activitEntryId	[提交的活动条目ID]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_NEW_RESULT_SUBMIT_ACTIVITY = 5125

--[[
	[1] = {--RespActivateMedals
		[1] = {--repeated MedalInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':cid
			[3] = 'int32':star	[星级]
			[4] = 'int32':quality	[ 品质]
			[5] = 'int32':effectTime	[过期时间]
			[6] = 'bool':isEquip	[是否已装备]
			[7] = 'int32':createTime	[得到时间]
		},
	}
--]]
s2c.MEDAL_RESP_ACTIVATE_MEDALS = 3001

--[[
	[1] = {--FightStartMsg
		[1] = 'int32':levelCid
		[2] = {--HeroInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int64':exp	[ 经验]
			[6] = {--repeated AttributeInfo
				[1] = 'int32':type	[ 属性类型]
				[2] = 'int32':val	[ 属性值]
			},
			[7] = 'int32':advancedLvl	[ 突破等级]
			[8] = {--repeated HeroEquipment
				[1] = 'int32':position	[装备位置]
				[2] = 'string':equipmentId	[装备id]
				[3] = {--EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
			},
			[9] = 'bool':helpFight	[ 助战]
			[10] = 'int32':angelLvl	[ 天使等级]
			[11] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[12] = 'int32':useSkillPiont	[ 已使用技能点]
			[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
			[14] = 'int32':provide	[出处]
			[15] = 'int32':fightPower	[ 战斗力]
			[16] = 'int32':skinCid	[ 皮肤cid]
			[17] = {--repeated SkillStrategy
				[1] = 'int32':id
				[2] = 'string':name
				[3] = 'int32':alreadyUseSkillPiont
				[4] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[5] = {--repeated PassiveSkillInfo
					[1] = 'int32':pos
					[2] = 'int32':skillId
				},
			},
			[18] = 'int32':useSkillStrategy
			[19] = {--repeated CrystalInfo
				[1] = 'int32':rarity
				[2] = 'int32':gridId
			},
			[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
			[21] = {--repeated EuqipFetterInfo
				[1] = 'int32':index
				[2] = {--NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
			},
			[22] = {--HeroStatus(enum)
				'v4':HeroStatus
			},
			[23] = 'int32':deadLine
			[24] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[25] = 'int32':skinCidTemp	[ 皮肤cid]
			[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
			[27] = 'int32':breakLv	[突破等级]
		},
		[3] = 'string':fightId	[战斗ID]
		[4] = 'int32':randomSeed	[随机种子]
		[5] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[6] = 'int32':helpPid	[助战玩家id]
		[7] = {--repeated LimitHeroSimpleInfo
			[1] = 'int32':limitType	[限定类型,1:玩家英雄类型,2:限定英雄类型]
			[2] = 'int32':limitCid	[限定英雄id]
		},
		[8] = 'bool':isDuelMod	[ 决斗模式]
	}
--]]
s2c.DUNGEON_FIGHT_START = 1793

--[[
	[1] = {--ResDressGem
		[1] = 'int32':heroId	[英雄id]
		[2] = {--repeated GemInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[宝石id]
			[3] = 'int32':cid	[宝石cid]
			[4] = 'int32':heroId	[英雄id]
			[5] = 'repeated int32':randSkill	[随机技能]
			[6] = {--GemRandSkill
				[1] = 'int32':originalSkill	[ 原始id]
				[2] = 'int32':newSkill	[ 新id]
			},
		},
	}
--]]
s2c.EQUIPMENT_RES_DRESS_GEM = 2833

--[[
	[1] = {--OfficeAreaEventMsg
		[1] = {--GridWorldEventMsg
			[1] = 'int32':eventId	[事件id]
			[2] = 'int32':x	[ x位置]
			[3] = 'int32':y	[ y位置]
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_AREA_EVENT = 7203

--[[
	[1] = {--ResRewardTotalPay
		[1] = 'int32':id	[id]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.RECHARGE_RES_REWARD_TOTAL_PAY = 4363

--[[
	[1] = {--GetMonthCardInfo
		[1] = {--ChangeType(enum)
			'v4':ChangeType
		},
		[2] = 'int32':lastGainDate	[上次领取时间]
		[3] = 'int32':surplus_Gain_Count	[剩余领取次数]
		[4] = 'int32':cardCid	[卡cid]
		[5] = 'int32':etime	[剩余的时间]
		[6] = 'int32':lastEndTime	[上次月卡结束时间,0表示当前为首次购买]
	}
--]]
s2c.RECHARGE_GET_MONTH_CARD_INFO = 4356

--[[
	[1] = {--ResRefreshAfkAwardMsg
		[1] = {--AfkActivity
			[1] = 'int32':id	[活动配置id]
			[2] = 'bool':first
			[3] = 'int32':localCity	[当前城市]
			[4] = 'int32':localNation	[当前国家]
			[5] = 'int64':startTime	[开始探索的时间]
			[6] = 'int32':cityAwardTimes	[当前城市获得奖励点次数,只是当前城市,用来计算城市进度]
			[7] = 'int32':speed	[当前的探索速度]
			[8] = 'int64':lastAwardPointTime	[到达最后一个奖励点位的时间]
			[9] = 'int32':capacity	[当前的探索总的容量]
			[10] = 'bool':isPush	[是否是服务器主动推送]
			[11] = 'int32':totalRewardCount	[总的奖励次数]
			[12] = {--AfkReward
				[1] = 'int64':awardTime	[获得奖励的时间]
				[2] = 'int32':activityId
				[3] = 'int32':nationId
				[4] = 'int32':cityId
				[5] = 'int32':dropId
				[6] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
			},
			[13] = {--repeated AfkNation
				[1] = 'int32':id	[国家配置]
				[2] = {--repeated AfkCity
					[1] = 'int32':id	[城市配置id]
					[2] = {--repeated AfkEvent
						[1] = 'int32':id
						[2] = 'int32':state
						[3] = 'int32':progress	[多层事件已经进行的进度]
					},
					[3] = 'repeated int32':completeEvent	[已经完成事件]
				},
			},
			[14] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[15] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
	}
--]]
s2c.EXPLORE_RES_REFRESH_AFK_AWARD = 7835

--[[
	[1] = {--ContinueDating
	}
--]]
s2c.DATING_CONTINUE_DATING = 1552

--[[
	[1] = {--ResRefreshGroupTeamList
		[1] = 'int32':giftId
		[2] = {--repeated GroupTeamInfo
			[1] = 'string':teamId	[队伍id]
			[2] = 'int32':createTime	[创建时间]
			[3] = 'int32':giftId	[礼包id]
			[4] = 'bool':isShow	[是否显示]
			[5] = 'bool':isComplete	[是否完成]
			[6] = 'bool':isDestroy	[是否销毁]
			[7] = {--repeated GroupTeamMember
				[1] = 'int32':playerId
				[2] = 'string':playerName
				[3] = 'int32':titleId
				[4] = 'int32':level
				[5] = 'bool':isCreator
				[6] = 'int32':portraitCid
				[7] = 'int32':portraitFrameId
			},
		},
		[3] = {--repeated GroupTeamInfo
			[1] = 'string':teamId	[队伍id]
			[2] = 'int32':createTime	[创建时间]
			[3] = 'int32':giftId	[礼包id]
			[4] = 'bool':isShow	[是否显示]
			[5] = 'bool':isComplete	[是否完成]
			[6] = 'bool':isDestroy	[是否销毁]
			[7] = {--repeated GroupTeamMember
				[1] = 'int32':playerId
				[2] = 'string':playerName
				[3] = 'int32':titleId
				[4] = 'int32':level
				[5] = 'bool':isCreator
				[6] = 'int32':portraitCid
				[7] = 'int32':portraitFrameId
			},
		},
	}
--]]
s2c.RECHARGE_RES_REFRESH_GROUP_TEAM_LIST = 4380

--[[
	[1] = {--BalloonExchangeResult
		[1] = 'int32':result	[交换结果 1成功 2取消]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_BALLOON_EXCHANGE_RESULT = 5198

--[[
	[1] = {--RespActivityRank
		[1] = 'int32':activityId	[ 活动ID]
		[2] = {--repeated ActivityRankMsg
			[1] = 'int32':rank	[ 排行]
			[2] = 'int32':playerId	[角色ID]
			[3] = 'string':playerName	[ 角色名]
			[4] = 'int32':score	[排行榜分数]
			[5] = 'int32':headIcon	[头像id]
			[6] = 'int32':helpFightHeroId	[助战id]
			[7] = 'int32':level	[等级]
			[8] = 'int32':frameCid	[头像框]
			[9] = 'int32':groupRank	[0:单人排名,1:组队排名]
			[10] = {--repeated RankPlayerInfo
				[1] = 'string':playerName	[ 角色名]
				[2] = 'int32':playerId	[角色ID]
				[3] = 'int32':level	[等级]
				[4] = 'int32':frameCid	[头像框]
				[5] = 'int32':headIcon	[头像id]
				[6] = 'int32':helpFightHeroId	[助战id]
				[7] = 'int32':heroId	[使用英雄id]
			},
		},
		[3] = 'int32':myRank	[ 我的排名]
		[4] = 'int32':myScore	[ 我的分数]
		[5] = 'int32':myHero	[ 我的hero]
	}
--]]
s2c.ACTIVITY_RESP_ACTIVITY_RANK = 5131

--[[
	[1] = {--ExploreTreasureSkillMsg
		[1] = 'repeated int32':skillId
	}
--]]
s2c.EXPLORE_EXPLORE_TREASURE_SKILL = 7841

--[[
	[1] = {--GameEventMsg
		[1] = 'int32':eventCid	[ 事件cid]
		[2] = 'int32':gameCid	[ 游戏cid]
		[3] = 'repeated int32':options	[ 选项列表]
	}
--]]
s2c.QLIPHOTH_GAME_EVENT = 6228

--[[
	[1] = {--ResDecomposeGem
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EQUIPMENT_RES_DECOMPOSE_GEM = 2838

--[[
	[1] = {--ParticleWorldInfoMsg
		[1] = 'int32':worldCid	[当前世界cid]
		[2] = {--repeated QliphothItem
			[1] = 'int32':itemId	[ 道具id]
			[2] = 'int32':itemNum	[ 道具数量]
		},
		[3] = {--repeated QliphothMission
			[1] = 'int32':missionId	[ 任务id]
			[2] = 'int32':progress	[ 任务进度]
		},
		[4] = {--repeated ParticleMapPoint
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'int32':event	[ 事件id,大于0则有事件]
			[4] = 'bool':eventValid	[ 事件是否可用]
			[5] = 'bool':visual	[ 是否可视,即是否开启格子]
			[6] = {--repeated WorldPointInfo
				[1] = 'int32':x	[ x位置]
				[2] = 'int32':y	[ y位置]
			},
		},
		[5] = 'repeated int32':formation	[ 阵型信息]
		[6] = {--repeated HeroInfection
			[1] = 'int32':heroId	[ 英雄id]
			[2] = 'int32':infection	[ 感染值]
		},
		[7] = 'int32':qliphothCoin	[卡巴拉代币]
		[8] = 'int32':qliphothEnergy	[卡巴拉能量]
		[9] = 'int32':currentX	[当前x点]
		[10] = 'int32':currentY	[当前y点]
		[11] = 'bool':firstUse	[是否首次当前质点世界]
		[12] = 'int32':mapCid	[当前地图cid]
		[13] = 'int32':eventRefresh	[随机事件刷新时间点]
		[14] = {--repeated WorldPointInfo
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
		},
		[15] = {--QliphothBuffMsg
			[1] = {--repeated QliphothBuff
				[1] = 'int32':buffCid	[ buffCid]
				[2] = 'int32':begining	[ 开启时间点]
				[3] = 'int32':useCount	[ 使用次数]
			},
			[2] = {--ChangeType(enum)
				'v4':ChangeType
			},
		},
		[16] = {--TaskEventDiscoverMsg
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'bool':add	[ true为新增,否则为移除]
		},
		[17] = {--HiddenEventsMsg
			[1] = {--repeated HiddenEventMsg
				[1] = 'int32':eventCid	[ 事件cid]
				[2] = 'repeated int64':progress	[ 进度]
			},
		},
	}
--]]
s2c.QLIPHOTH_PARTICLE_WORLD_INFO = 6202

--[[
	[1] = {--RespYearResumeInfo
		[1] = 'string':record	[履历json]
	}
--]]
s2c.PLAYER_RESP_YEAR_RESUME_INFO = 294

--[[
	[1] = {--RspPutSpiritPoints
		[1] = {--HeroSpiritInfo
			[1] = 'int32':spiritPoints	[可用灵力点数]
			[2] = 'int32':grade	[品阶从0开始]
			[3] = 'int32':level	[级数从0开始]
			[4] = 'int64':exp	[经验值]
			[5] = {--repeated HeroSpiritProperty
				[1] = 'int32':cid	[cid]
				[2] = 'int32':num	[点数]
			},
			[6] = 'bool':firstShow	[首次开启展示true即为要显示false则不显示]
			[7] = 'bool':feedback	[旧灵力系统是否已返回资源]
			[8] = {--repeated HeroAngleSpirit
				[1] = 'int32':heroCid	[cid]
				[2] = 'int32':lv	[点数]
			},
			[9] = 'int32':maxLv	[可升级上限]
		},
	}
--]]
s2c.HERO_SPIRIT_RSP_PUT_SPIRIT_POINTS = 8401

--[[
	[1] = {--ResSuspectVote
		[1] = 'int32':id	[天]
		[2] = 'int32':voteId	[选项]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.DETECTIVE_RES_SUSPECT_VOTE = 8911

--[[
	[1] = {--QliphothEnergyMsg
		[1] = 'int32':qliphothEnergy	[卡巴拉能量]
	}
--]]
s2c.QLIPHOTH_QLIPHOTH_ENERGY = 6209

--[[
	[1] = {--ResLimitlessSummonActivityInfo
		[1] = 'int32':activityId	[活动Id]
		[2] = 'int32':score	[当前活动积分]
		[3] = 'int32':refreshCount	[手动刷新卡池次数]
		[4] = 'repeated int32':scoreRewards	[已领取过的积分奖励id]
		[5] = 'repeated int32':summonedList	[已抽取过的卡池id]
	}
--]]
s2c.LIMITLESS_SUMMON_RES_LIMITLESS_SUMMON_ACTIVITY_INFO = 3501

--[[
	[1] = {--ExploreEquipInfos
		[1] = {--repeated Equip
			[1] = 'string':id
			[2] = 'int32':cid
			[3] = 'int32':level
			[4] = 'int32':index	[镶嵌的位置,从1开始,如果为0,没有镶嵌]
			[5] = 'int32':cabinId	[舱室id]
		},
	}
--]]
s2c.EXPLORE_EXPLORE_EQUIP_INFOS = 7806

--[[
	[1] = {--RespShareInfos
		[1] = {--repeated ShareInfo
			[1] = 'int32':id	[配置id]
			[2] = 'int32':statue	[0 未分享 1分享成功可领取 2奖励已经领取]
			[3] = 'bool':show	[是否弹出提示]
			[4] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
	}
--]]
s2c.SHARE_RESP_SHARE_INFOS = 6101

--[[
	[1] = {--ParticleMapPoint
		[1] = 'int32':x	[ x位置]
		[2] = 'int32':y	[ y位置]
		[3] = 'int32':event	[ 事件id,大于0则有事件]
		[4] = 'bool':eventValid	[ 事件是否可用]
		[5] = 'bool':visual	[ 是否可视,即是否开启格子]
		[6] = {--repeated WorldPointInfo
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
		},
	}
--]]
s2c.QLIPHOTH_PARTICLE_MAP_POINT = 6205

--[[
	[1] = {--RespRecoverTime
		[1] = 'int32':recoverTime
	}
--]]
s2c.ACTIVITY_RESP_RECOVER_TIME = 5140

--[[
	[1] = {--ResultSubmitTask
		[1] = 'string':taskDbId
		[2] = 'int32':taskCid
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.TASK_RESULT_SUBMIT_TASK = 4098

--[[
	[1] = {--RespNotify
		[1] = 'int64':version	[ 最新版本号]
		[2] = {--repeated UnionNotify
			[1] = 'int64':creatTime
			[2] = 'int32':notifyType
			[3] = 'string':playerName
			[4] = 'repeated string':prams
		},
	}
--]]
s2c.UNION_RESP_NOTIFY = 6668

--[[
	[1] = {--RandomEventsMsg
		[1] = {--repeated ParticleMapPoint
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'int32':event	[ 事件id,大于0则有事件]
			[4] = 'bool':eventValid	[ 事件是否可用]
			[5] = 'bool':visual	[ 是否可视,即是否开启格子]
			[6] = {--repeated WorldPointInfo
				[1] = 'int32':x	[ x位置]
				[2] = 'int32':y	[ y位置]
			},
		},
		[2] = 'int32':eventRefresh	[随机事件刷新时间点]
	}
--]]
s2c.QLIPHOTH_RANDOM_EVENTS = 6223

--[[
	[1] = {--ReplyGameMsg
		[1] = 'int32':eventCid	[ 事件cid]
		[2] = 'int32':gameCid	[ 游戏cid]
		[3] = {--ItemList
			[1] = {--repeated ItemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'int64':num	[ 数量]
				[5] = 'int32':outTime	[过期时间]
			},
			[2] = {--repeated EquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[灵装id]
				[3] = 'int32':cid	[灵装cid]
				[4] = 'int32':level	[灵装等级]
				[5] = 'int32':exp	[灵装经验值]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
				[8] = {--repeated SpecialAttr
					[1] = 'int32':cid	[配置id]
					[2] = 'int32':value	[属性值]
					[3] = 'int32':index	[属性服务器顺序]
				},
				[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
				[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
				[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
				[12] = 'int32':outTime	[过期时间]
				[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
				[14] = 'int32':star	[额外星数]
				[15] = 'int32':stage	[阶段]
				[16] = 'int32':num	[数量]
				[17] = 'int32':step	[质点阶级]
			},
			[3] = {--repeated DressInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'string':roleId	[ 装备精灵ID]
				[5] = 'int32':outTime	[过期时间]
			},
			[4] = {--repeated NewEquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[新装备id]
				[3] = 'int32':cid	[新装备cid]
				[4] = 'int32':stage	[新装备阶段等级]
				[5] = 'int32':level	[新装备等级]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
			},
			[5] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[6] = {--repeated TreasureInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝物id]
				[3] = 'int32':cid	[宝物cid]
				[4] = 'int32':star	[宝物星级]
			},
			[7] = {--repeated ExploreEquip
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[探索装备id]
				[3] = 'int32':cid	[探索装备cid]
				[4] = 'int32':level	[探索装备星级]
			},
		},
		[4] = 'repeated int32':options	[ 参数列表]
	}
--]]
s2c.QLIPHOTH_REPLY_GAME = 6229

--[[
	[1] = {--RespHuntingBossInfo
		[1] = {--HuntingBoss
			[1] = 'int32':curDungeon	[当前boss]
			[2] = 'int32':dungeonHp	[剩余血量万分比]
			[3] = 'int32':leftCount	[个人剩余次数]
			[4] = 'repeated int32':dungeonBuffs	[boss关卡buff]
			[5] = 'int32':honor	[当前荣耀值]
		},
	}
--]]
s2c.HUNTING_DUNGEON_RESP_HUNTING_BOSS_INFO = 8508

--[[
	[1] = {--ResDetectiveSign
		[1] = 'repeated int32':sign
	}
--]]
s2c.DETECTIVE_RES_DETECTIVE_SIGN = 8914

--[[
	[1] = {--RespGetNewEquipPlans
		[1] = 'int32':heroId
		[2] = {--repeated NewEquipPlan
			[1] = 'int32':index
			[2] = 'string':name
			[3] = {--repeated Plan
				[1] = 'int32':index
				[2] = 'string':equipId
			},
		},
	}
--]]
s2c.EQUIPMENT_RESP_GET_NEW_EQUIP_PLANS = 2845

--[[
	[1] = {--RespEnterFight
		[1] = 'int32':excessTime	[剩余多少时间后开始战斗]
	}
--]]
s2c.FIGHT_RESP_ENTER_FIGHT = 25601

--[[
	[1] = {--RespAddBuff
		[1] = 'repeated int32':buffIds	[buff]
	}
--]]
s2c.SACRIFICE_RESP_ADD_BUFF = 8003

--[[
	[1] = {--RespAddHeroDispatch
	}
--]]
s2c.HERO_DISPATCH_RESP_ADD_HERO_DISPATCH = 8602

--[[
	[1] = {--ResFavorDatingPanel
		[1] = 'int32':roleId	[精灵Id]
		[2] = {--repeated FavorStatueInfo
			[1] = 'int32':favorId	[对应FavorDating表Id]
			[2] = 'int32':statue	[0未激活,1激活 2已领(奖励状态)    //0未激活,1激活 2已领(奖励状态)]
			[3] = 'int32':firstPass	[0还未通关过 1已经通关过]
			[4] = 'int32':energy	[消耗精力]
		},
	}
--]]
s2c.EXTRA_DATING_RES_FAVOR_DATING_PANEL = 5650

--[[
	[1] = {--NewRespActivityProgress
		[1] = {--repeated ActivityProgressMsg
			[1] = 'int32':id	[活动id]
			[2] = 'int32':itemId	[条目ID]
			[3] = 'int32':progress	[当前进度]
			[4] = 'string':extend	[进度扩展字段--用于记载单int型不能充分记录的复杂进度    //进度扩展字段--用于记载单int型不能充分记录的复杂进度]
			[5] = 'int32':status	[状态]
		},
	}
--]]
s2c.ACTIVITY_NEW_RESP_ACTIVITY_PROGRESS = 5128

--[[
	[1] = {--RespGetUnionPlayerAttr
		[1] = 'int32':morale	[社团的士气值]
		[2] = {--repeated UnionPlayerAttr
			[1] = 'int32':playerId	[玩家id]
			[2] = 'int32':attackNum	[攻打次数]
			[3] = 'bool':pass	[是否成功通关]
		},
	}
--]]
s2c.JU_NAI_INVASION_RESP_GET_UNION_PLAYER_ATTR = 9105

--[[
	[1] = {--ResFavorDatingNotices
		[1] = {--repeated ResTiggerRoleNotice
			[1] = 'int32':favorDatingId	[Favor表对应id]
			[2] = 'int32':statue	[0表示章节状态取消显示 1显示]
		},
	}
--]]
s2c.EXTRA_DATING_RES_FAVOR_DATING_NOTICES = 5653

--[[
	[1] = {--RespLookTriggerMessage
	}
--]]
s2c.DATING_RESP_LOOK_TRIGGER_MESSAGE = 1561

--[[
	[1] = {--ShopInfoMsg
		[1] = {--repeated QliphothShopItem
			[1] = 'int32':itemId	[ 道具id]
			[2] = 'int32':itemNum	[ 道具数量]
			[3] = 'int32':buyCount	[ 已购买次数]
		},
		[2] = 'int32':nextRefresh	[ 下次刷新时间]
	}
--]]
s2c.QLIPHOTH_SHOP_INFO = 6213

--[[
	[1] = {--ApprenticeNotice
		[1] = {--repeated ApprenticeInfo
			[1] = 'int32':playerId	[ 玩家id]
			[2] = 'int32':portraitCId	[ 头像]
			[3] = 'string':name	[ 名字]
			[4] = 'int32':fightPower	[ 战力]
			[5] = 'int32':level	[ 等级]
			[6] = 'int64':lastLoginTime	[ 最后登录时间]
			[7] = 'bool':online	[ 是否在线]
			[8] = 'int32':portraitFrameCId	[ 头像框CID]
			[9] = 'bool':isFriend	[ 是否好友]
			[10] = 'bool':isUnion	[ 是否社团成员]
			[11] = 'bool':finished	[ 是否出师,徒弟列表需要的字段]
			[12] = 'int32':type	[ 1师父,2师门,3徒弟,4申请收徒,5申请拜师]
			[13] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[14] = 'int32':famousExp	[ 名师经验]
			[15] = 'bool':hasGift	[ 师父身上的该字段表示是否有礼物可领,true是的,只有师父会展示是否有礼物可领;徒弟身上的该字段表示是否可以赠送礼物,true可以赠送]
		},
		[2] = 'bool':isCD	[是否处于cd中,处于cd中不能拜师/收徒]
		[3] = 'bool':finished	[是否出师]
	}
--]]
s2c.APPRENTICE_APPRENTICE_NOTICE = 7906

--[[
	[1] = {--PushChallengeProgress
		[1] = 'int32':floor	[挑战楼层]
		[2] = 'int32':costTime	[消耗总时间]
	}
--]]
s2c.DUNGEON_PUSH_CHALLENGE_PROGRESS = 1822

--[[
	[1] = {--RespRecruitMaid
		[1] = {--RecruitInfo
			[1] = {--repeated Recruit
				[1] = 'int32':cid	[招募id]
				[2] = 'bool':state	[招募状态]
			},
			[2] = 'int32':nextTime	[下一次的免费刷新时间]
			[3] = 'int32':recruitTimes	[每一天的招募次数]
			[4] = 'int32':recruitBuyTimes	[每一天的购买刷新次数]
		},
		[2] = 'int32':addRecruitId	[招募id]
		[3] = 'int32':roleId	[精灵头像id]
	}
--]]
s2c.MAID_ACTIVITY_RESP_RECRUIT_MAID = 9153

--[[
	[1] = {--RespAngelAddBit
	}
--]]
s2c.HERO_RESP_ANGEL_ADD_BIT = 1033

--[[
	[1] = {--HiddenEventRewardMsg
		[1] = 'int32':eventCid	[ 事件cid]
		[2] = {--ItemList
			[1] = {--repeated ItemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'int64':num	[ 数量]
				[5] = 'int32':outTime	[过期时间]
			},
			[2] = {--repeated EquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[灵装id]
				[3] = 'int32':cid	[灵装cid]
				[4] = 'int32':level	[灵装等级]
				[5] = 'int32':exp	[灵装经验值]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
				[8] = {--repeated SpecialAttr
					[1] = 'int32':cid	[配置id]
					[2] = 'int32':value	[属性值]
					[3] = 'int32':index	[属性服务器顺序]
				},
				[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
				[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
				[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
				[12] = 'int32':outTime	[过期时间]
				[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
				[14] = 'int32':star	[额外星数]
				[15] = 'int32':stage	[阶段]
				[16] = 'int32':num	[数量]
				[17] = 'int32':step	[质点阶级]
			},
			[3] = {--repeated DressInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'string':roleId	[ 装备精灵ID]
				[5] = 'int32':outTime	[过期时间]
			},
			[4] = {--repeated NewEquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[新装备id]
				[3] = 'int32':cid	[新装备cid]
				[4] = 'int32':stage	[新装备阶段等级]
				[5] = 'int32':level	[新装备等级]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
			},
			[5] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[6] = {--repeated TreasureInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝物id]
				[3] = 'int32':cid	[宝物cid]
				[4] = 'int32':star	[宝物星级]
			},
			[7] = {--repeated ExploreEquip
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[探索装备id]
				[3] = 'int32':cid	[探索装备cid]
				[4] = 'int32':level	[探索装备星级]
			},
		},
	}
--]]
s2c.QLIPHOTH_HIDDEN_EVENT_REWARD = 6227

--[[
	[1] = {--RespFightWorldOperate
		[1] = 'int32':roomType	[房间类型]
		[2] = 'string':ext	[操作信息]
	}
--]]
s2c.NEW_WORLD_RESP_FIGHT_WORLD_OPERATE = 6822

--[[
	[1] = {--ResRefreshStronghold
		[1] = {--repeated Stronghold
			[1] = 'int32':id
			[2] = 'int32':state
			[3] = 'int64':startTime
			[4] = 'int64':endTime
			[5] = 'int32':useSupTimes
			[6] = 'int32':progress
			[7] = {--repeated Event
				[1] = 'int32':id
				[2] = 'int32':state
				[3] = 'int64':startTime
			},
			[8] = {--repeated Role
				[1] = 'int32':roleId
			},
			[9] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
			[10] = {--repeated SupportRole
				[1] = 'int64':playerId
				[2] = 'string':playerName
				[3] = 'int64':startTime
				[4] = 'int32':times
				[5] = {--Role
					[1] = 'int32':roleId
				},
				[6] = {--repeated Buff
					[1] = 'int32':buffId
					[2] = 'int32':buffLv
				},
			},
		},
		[2] = 'int32':refreshTimes	[已经使用的刷新次数]
		[3] = 'int64':refreshTime	[上次刷新的时间]
	}
--]]
s2c.HANGUP_ACT_RES_REFRESH_STRONGHOLD = 9012

--[[
	[1] = {--ChallengeInfoMsg
		[1] = {--repeated ChallengeStatus
			[1] = 'int32':levelCid	[关卡cid]
			[2] = 'int32':status	[通关状态,0:未通过,1:通过]
		},
		[2] = 'int32':leftTime	[下一阶段倒计时]
		[3] = 'int32':count	[阶段挑战次数]
		[4] = 'int32':buffCid	[buffid]
		[5] = 'int32':buffCount	[buff刷新次数]
		[6] = 'int32':awardStatus	[挑战奖励领取状态,0:不可领取,1:可领取,2:已领取]
		[7] = 'bool':finishAny	[完成过挑战]
	}
--]]
s2c.HERO_CHALLENGE_CHALLENGE_INFO = 6301

--[[
	[1] = {--QliphothTreeInfoMsg
		[1] = 'int32':openWorldCid	[当前世界cid,为0则还没有开放的世界]
		[2] = 'int32':missionComplete	[净化任务阶段完成数]
		[3] = 'int32':qliphothCoin	[卡巴拉代币]
		[4] = 'int32':qliphothEnergy	[卡巴拉能量]
		[5] = 'bool':firstUse	[是否首次使用功能]
		[6] = {--repeated WorldOpenTime
			[1] = 'int32':worldCid	[ 质点世界id]
			[2] = 'int32':begining	[ 开启时间点]
			[3] = 'int32':endTime	[ 结束时间点]
			[4] = 'int32':beSoon	[ 客户端展示阶段时间]
		},
	}
--]]
s2c.QLIPHOTH_QLIPHOTH_TREE_INFO = 6201

--[[
	[1] = {--RspPlantLadderCardMsg
		[1] = 'repeated int32':usingCards	[已使用的卡牌]
	}
--]]
s2c.LADDER_RSP_PLANT_LADDER_CARD = 8310

--[[
	[1] = {--ParticleWorldAmbushMsg
		[1] = 'int32':ambushId	[伏击关卡id]
	}
--]]
s2c.QLIPHOTH_PARTICLE_WORLD_AMBUSH = 6210

--[[
	[1] = {--LevelInfos
		[1] = {--repeated LevelInfo
			[1] = 'int32':cid	[关卡cid]
			[2] = 'repeated int32':goals	[达成目标的下标]
			[3] = 'int32':fightCount	[战斗次数]
			[4] = 'bool':win	[是否胜利]
			[5] = 'int32':buyCount	[购买次数]
			[6] = 'int32':freeCount	[ 周卡或者是月卡的免费次数]
		},
	}
--]]
s2c.DUNGEON_LEVEL_INFOS = 1804

--[[
	[1] = {--RespDynamicCommodity
		[1] = {--repeated DynamicCommodity
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':data	[json格式]
		},
	}
--]]
s2c.STORE_RESP_DYNAMIC_COMMODITY = 2566

--[[
	[1] = {--HeroInfectionsMsg
		[1] = {--repeated HeroInfection
			[1] = 'int32':heroId	[ 英雄id]
			[2] = 'int32':infection	[ 感染值]
		},
	}
--]]
s2c.QLIPHOTH_HERO_INFECTIONS = 6208

--[[
	[1] = {--Resp2019ChristmasProduct
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.CHRISTMAS_RESP2019_CHRISTMAS_PRODUCT = 6617

--[[
	[1] = {--QliphothBuffMsg
		[1] = {--repeated QliphothBuff
			[1] = 'int32':buffCid	[ buffCid]
			[2] = 'int32':begining	[ 开启时间点]
			[3] = 'int32':useCount	[ 使用次数]
		},
		[2] = {--ChangeType(enum)
			'v4':ChangeType
		},
	}
--]]
s2c.QLIPHOTH_QLIPHOTH_BUFF = 6225

--[[
	[1] = {--Resp2019ChristmasDungeon
		[1] = 'int32':refreshCount	[本日手动刷新次数]
		[2] = 'int32':refreshTime	[下次自动刷新时间点]
		[3] = 'int32':helpCount	[协助次数]
		[4] = {--repeated Christmas2019Level
			[1] = 'int32':cid	[关卡cid]
			[2] = 'bool':pass	[是否通关]
		},
	}
--]]
s2c.CHRISTMAS_RESP2019_CHRISTMAS_DUNGEON = 6613

--[[
	[1] = {--ParticleWorldStatusMsg
		[1] = {--QliphothTreeInfoMsg
			[1] = 'int32':openWorldCid	[当前世界cid,为0则还没有开放的世界]
			[2] = 'int32':missionComplete	[净化任务阶段完成数]
			[3] = 'int32':qliphothCoin	[卡巴拉代币]
			[4] = 'int32':qliphothEnergy	[卡巴拉能量]
			[5] = 'bool':firstUse	[是否首次使用功能]
			[6] = {--repeated WorldOpenTime
				[1] = 'int32':worldCid	[ 质点世界id]
				[2] = 'int32':begining	[ 开启时间点]
				[3] = 'int32':endTime	[ 结束时间点]
				[4] = 'int32':beSoon	[ 客户端展示阶段时间]
			},
		},
		[2] = 'bool':openStatus	[开启状态]
	}
--]]
s2c.QLIPHOTH_PARTICLE_WORLD_STATUS = 6221

--[[
	[1] = {--ExploreTechInfos
		[1] = {--repeated TechTree
			[1] = 'int32':techType
			[2] = 'int32':nationId	[如果是国家天赋,则发送国家id,如果是形态天赋没有数据]
			[3] = {--repeated Tech
				[1] = 'int32':techId
				[2] = 'int32':state	[0:解锁未学习 ,1:已学习  未解锁不发]
			},
		},
	}
--]]
s2c.EXPLORE_EXPLORE_TECH_INFOS = 7815

--[[
	[1] = {--ResCancelMark
		[1] = 'int32':portraitType	[1头像 2头像框 3气泡框]
	}
--]]
s2c.PORTRAIL_RES_CANCEL_MARK = 7003

--[[
	[1] = {--ResDealEventMsg
		[1] = 'int32':id
		[2] = 'int32':eventId
		[3] = 'bool':isSkip	[true 跳过 false 开始]
	}
--]]
s2c.HANGUP_ACT_RES_DEAL_EVENT = 9004

--[[
	[1] = {--RespEquipSystemTitle
		[1] = 'int32':id
	}
--]]
s2c.SYSTEM_TITLE_RESP_EQUIP_SYSTEM_TITLE = 8151

--[[
	[1] = {--ResApprenticeList
		[1] = 'bool':success	[true成功]
	}
--]]
s2c.APPRENTICE_RES_APPRENTICE_LIST = 7903

--[[
	[1] = {--ResReportAD
		[1] = 'int32':pid	[被举报的玩家id]
	}
--]]
s2c.PLAYER_RES_REPORT_AD = 285

--[[
	[1] = {--ReturnTestMsg
		[1] = 'repeated int32':x1
		[2] = 'int32':x2
		[3] = 'int32':x3
	}
--]]
s2c.PLAYER_RETURN_TEST = 266

--[[
	[1] = {--UpdateRefreshTime
		[1] = 'repeated int32':recoverTimeList	[体力精力回复时间]
	}
--]]
s2c.PLAYER_UPDATE_REFRESH_TIME = 293

--[[
	[1] = {--ResAttrInfo
		[1] = {--repeated AttrInfo
			[1] = 'int32':attrId
			[2] = 'int32':attrType	[0:只有baseValue 1:baseValue + addValue    //0:只有baseValue 1:baseValue + addValue]
			[3] = 'int32':baseValue
			[4] = 'int32':addValue
		},
	}
--]]
s2c.EXPLORE_RES_ATTR_INFO = 7840

--[[
	[1] = {--RefreshDungeonLevelGroupList
		[1] = {--repeated DungeonLevelGroupInfo
			[1] = 'string':id	[id]
			[2] = 'int32':cid	[cid]
			[3] = 'int32':fightCount	[战斗次数]
			[4] = 'int32':buyCount	[购买次数]
			[5] = {--repeated ListMap
				[1] = 'int32':key
				[2] = 'repeated int32':list
			},
			[6] = 'int32':mainLineCid	[当前关卡标记]
			[7] = 'int32':maxMainLine	[最大关卡进度]
		},
	}
--]]
s2c.DUNGEON_REFRESH_DUNGEON_LEVEL_GROUP_LIST = 1801

--[[
	[1] = {--RespSendEventInfo
		[1] = {--repeated HangUpEventInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':eventId	[事件id]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'repeated int32':roleIds	[挂机的精灵信息]
			[5] = 'int32':eventEndTime	[事件结束时间]
			[6] = 'bool':isSpecial
		},
		[2] = 'int32':activityId	[活动id]
	}
--]]
s2c.ACTIVITY_RESP_SEND_EVENT_INFO = 5172

--[[
	[1] = {--FormationInfoList
		[1] = {--repeated FormationInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':type	[ 阵型类型]
			[3] = 'int32':status	[ 阵型状态 0 未启用 1 启用]
			[4] = 'repeated string':stance	[ 阵型英雄]
		},
	}
--]]
s2c.PLAYER_FORMATION_INFO_LIST = 265

--[[
	[1] = {--AfkActivity
		[1] = 'int32':id	[活动配置id]
		[2] = 'bool':first
		[3] = 'int32':localCity	[当前城市]
		[4] = 'int32':localNation	[当前国家]
		[5] = 'int64':startTime	[开始探索的时间]
		[6] = 'int32':cityAwardTimes	[当前城市获得奖励点次数,只是当前城市,用来计算城市进度]
		[7] = 'int32':speed	[当前的探索速度]
		[8] = 'int64':lastAwardPointTime	[到达最后一个奖励点位的时间]
		[9] = 'int32':capacity	[当前的探索总的容量]
		[10] = 'bool':isPush	[是否是服务器主动推送]
		[11] = 'int32':totalRewardCount	[总的奖励次数]
		[12] = {--AfkReward
			[1] = 'int64':awardTime	[获得奖励的时间]
			[2] = 'int32':activityId
			[3] = 'int32':nationId
			[4] = 'int32':cityId
			[5] = 'int32':dropId
			[6] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
		[13] = {--repeated AfkNation
			[1] = 'int32':id	[国家配置]
			[2] = {--repeated AfkCity
				[1] = 'int32':id	[城市配置id]
				[2] = {--repeated AfkEvent
					[1] = 'int32':id
					[2] = 'int32':state
					[3] = 'int32':progress	[多层事件已经进行的进度]
				},
				[3] = 'repeated int32':completeEvent	[已经完成事件]
			},
		},
		[14] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[15] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EXPLORE_AFK_ACTIVITY = 7823

--[[
	[1] = {--GetMonthCardWelfareInfo
		[1] = {--MonthCardSignInfo
			[1] = 'int32':signDays	[累计签到天数]
			[2] = 'bool':canSign	[是否可签到]
			[3] = 'int32':actRemain	[双倍活动剩余时间]
			[4] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[5] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[6] = 'int32':extDay	[额外奖励天数]
			[7] = 'bool':subscibe	[是否已订阅月卡]
			[8] = 'int32':subscibeTime	[月卡信息]
		},
		[2] = {--repeated MonthCardStoreInfo
			[1] = 'int32':id	[id]
			[2] = 'string':name	[礼包名称]
			[3] = 'int32':order	[排序]
			[4] = 'string':limitDes	[限购说明]
			[5] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[6] = 'int32':limitType	[限购类型]
			[7] = 'int32':limitVal	[限购次数]
			[8] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[9] = 'int32':buyCount	[购买次数]
			[10] = 'int32':color	[底板样式]
			[11] = 'string':ext	[额外信息]
		},
	}
--]]
s2c.RECHARGE_GET_MONTH_CARD_WELFARE_INFO = 4365

--[[
	[1] = {--ResQuickActiveCrystal
		[1] = 'string':heroId
		[2] = {--repeated CrystalInfo
			[1] = 'int32':rarity
			[2] = 'int32':gridId
		},
	}
--]]
s2c.HERO_RES_QUICK_ACTIVE_CRYSTAL = 1050

--[[
	[1] = {--ResSetBackground
		[1] = 'int32':dayBackground	[ 白天背景]
		[2] = 'int32':nightBackground	[夜晚背景]
		[3] = 'int32':dayBGM	[白天bgm]
		[4] = 'int32':nightBGM	[夜晚bgm]
	}
--]]
s2c.PLAYER_RES_SET_BACKGROUND = 290

--[[
	[1] = {--PlayerInfo
		[1] = 'int32':pid	[ 玩家ID]
		[2] = 'string':name	[ 玩家名称]
		[3] = 'int32':lvl	[ 玩家等级]
		[4] = 'int64':exp	[ 玩家经验]
		[5] = 'int32':vip_lvl	[ VIP等级]
		[6] = 'int64':vip_exp	[ VIP经验]
		[7] = {--Language(enum)
			'v4':Language
		},
		[8] = 'string':remark	[ 宣言]
		[9] = 'int32':helpFightHeroCid	[ 助战英雄ID]
		[10] = {--repeated PlayerAttr
			[1] = {--PlayerAttrKey(enum)
				'v4':PlayerAttrKey
			},
			[2] = 'int32':attrVal	[ 属性值]
		},
		[11] = 'bool':isFirstLogin	[是否初次登录]
		[12] = 'string':clientDiscreteData	[客户端离散数据]
		[13] = 'string':settings	[ 设置信息]
		[14] = 'repeated int32':recoverTimeList	[体力精力回复时间]
		[15] = 'int32':portraitCid	[ 玩家头像CID]
		[16] = 'int32':portraitFrameCid	[ 玩家头像框CID]
		[17] = {--GetAllElement
			[1] = {--repeated Elements
				[1] = 'int32':type	[类型]
				[2] = {--repeated Element
					[1] = 'int32':cid	[cid]
					[2] = 'int32':reward	[领奖状态 0不可领取  1可领取 2 已领取]
				},
				[3] = 'int32':trophy	[奖杯数]
				[4] = 'bool':scan	[是否可以浏览]
			},
			[2] = 'int32':rank	[排名]
			[3] = 'int32':totleTrophy	[总奖杯数]
		},
		[18] = 'int32':unionId	[ 玩家社团Id]
		[19] = 'string':unionName	[ 玩家社团名]
		[20] = 'int32':titleId	[ 称号id]
		[21] = 'int32':createTime	[ 建号时间]
		[22] = 'int32':famousExp	[ 名师经验]
	}
--]]
s2c.PLAYER_PLAYER_INFO = 267

--[[
	[1] = {--OfficeBuffMsg
		[1] = {--GridBuffMsg
			[1] = {--repeated GridBuff
				[1] = 'int32':buffCid	[ buffCid]
				[2] = 'int32':begining	[ 开启时间点]
				[3] = 'int32':useCount	[ 使用次数]
			},
			[2] = {--ChangeType(enum)
				'v4':ChangeType
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_BUFF = 7225

--[[
	[1] = {--RespTimeContract
		[1] = 'int32':activityId
		[2] = 'int32':contractId	[当前是那个配置表]
		[3] = 'int32':location	[当前坐落与那个位置]
		[4] = 'int32':round	[当前轮数]
		[5] = 'repeated int32':awardList	[已经领取过后的奖励列表]
	}
--]]
s2c.ACTIVITY_RESP_TIME_CONTRACT = 5184

--[[
	[1] = {--RespExplore
		[1] = {--EventInfo
			[1] = 'int32':eventId	[事件id]
			[2] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
	}
--]]
s2c.BIRTH_DAY_RESP_EXPLORE = 8102

--[[
	[1] = {--RespRedPoint
		[1] = 'int32':id
		[2] = 'bool':isShow
	}
--]]
s2c.PLAYER_RESP_RED_POINT = 300

--[[
	[1] = {--PushUiChangeInfo
		[1] = 'bool':needChange
		[2] = 'string':data	[离散json]
		[3] = 'int32':id	[配置id]
	}
--]]
s2c.PLAYER_PUSH_UI_CHANGE_INFO = 304

--[[
	[1] = {--WorldPointsRefreshMsg
		[1] = {--repeated ParticleMapPoint
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'int32':event	[ 事件id,大于0则有事件]
			[4] = 'bool':eventValid	[ 事件是否可用]
			[5] = 'bool':visual	[ 是否可视,即是否开启格子]
			[6] = {--repeated WorldPointInfo
				[1] = 'int32':x	[ x位置]
				[2] = 'int32':y	[ y位置]
			},
		},
	}
--]]
s2c.QLIPHOTH_WORLD_POINTS_REFRESH = 6219

--[[
	[1] = {--RespResetSpeedLink
	}
--]]
s2c.ACTIVITY_RESP_RESET_SPEED_LINK = 5150

--[[
	[1] = {--RespFinishHeroDispatch
		[1] = {--repeated FinishDispatchAward
			[1] = 'int32':type	[ 派遣类型, 1 日常副本, 2  精灵试炼, 3  雷霆圣堂, 4  联机作战, 5  日常约会]
			[2] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
	}
--]]
s2c.HERO_DISPATCH_RESP_FINISH_HERO_DISPATCH = 8604

--[[
	[1] = {--RespSendSpringWithTree
	}
--]]
s2c.ACTIVITY2_RESP_SEND_SPRING_WITH_TREE = 9412

--[[
	[1] = {--ChallengeAwardMsg
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.HERO_CHALLENGE_CHALLENGE_AWARD = 6303

--[[
	[1] = {--FormationInfo
		[1] = {--ChangeType(enum)
			'v4':ChangeType
		},
		[2] = 'int32':type	[ 阵型类型]
		[3] = 'int32':status	[ 阵型状态 0 未启用 1 启用]
		[4] = 'repeated string':stance	[ 阵型英雄]
	}
--]]
s2c.PLAYER_FORMATION_INFO = 264

--[[
	[1] = {--BuyFightCount
		[1] = 'int32':cid	[副本组cid]
	}
--]]
s2c.DUNGEON_BUY_FIGHT_COUNT = 1800

--[[
	[1] = {--UpdateBackgroundTime
		[1] = 'int32':time	[ 1白天2夜晚]
	}
--]]
s2c.PLAYER_UPDATE_BACKGROUND_TIME = 292

--[[
	[1] = {--RespPullNetFrame
		[1] = {--repeated NetFrame
			[1] = 'int32':index	[ 帧序]
			[2] = {--repeated OperateFrame
				[1] = 'int32':pid	[ 玩家ID]
				[2] = 'int32':keyCode	[ 按键键值 (摇杆.按键)    // 按键键值 (摇杆.按键)]
				[3] = 'int32':keyEvent	[ 按键状态  down/doing/up/摇杆角度]
				[4] = 'int32':keyEventEx	[按键状态扩展]
				[5] = 'int32':posX	[位置X]
				[6] = 'int32':posY	[位置Y]
				[7] = 'int32':dir	[角色朝向]
				[8] = 'int32':hp	[角色血量]
				[9] = 'int32':sp	[怒气]
			},
			[3] = {--repeated DataFrame
				[1] = 'int32':pid
				[2] = 'int32':action	[1:复活 2:离开]
			},
			[4] = {--repeated BossFrame
				[1] = 'int32':id	[Boss ID]
				[2] = 'int32':posX	[位置X]
				[3] = 'int32':posY	[位置Y]
				[4] = 'int32':dir	[角色朝向]
				[5] = 'int32':hp	[角色血量]
				[6] = 'int32':operate	[操作]
				[7] = 'int32':sp	[怒气]
			},
			[5] = {--repeated AIStepFrame
				[1] = 'int32':id	[Boss ID]
				[2] = 'int32':pid	[玩家id]
				[3] = 'int32':lastStep	[上一步AI]
				[4] = 'int32':curStep	[当前AI]
				[5] = 'int32':funcID	[执行方法ID]
				[6] = 'int32':param1	[参数1]
				[7] = 'int32':param2	[参数2]
				[8] = 'int32':param3	[参数3]
			},
		},
	}
--]]
s2c.FIGHT_RESP_PULL_NET_FRAME = 25606

--[[
	[1] = {--ResChangeAntiAddiction
		[1] = 'int32':anti	[当前防沉迷状态]
	}
--]]
s2c.PLAYER_RES_CHANGE_ANTI_ADDICTION = 284

--[[
	[1] = {--ResEquipBackupInfo
		[1] = {--repeated EquipBackupInfo
			[1] = 'int32':id	[ 方案id]
			[2] = 'string':desc	[方案描述]
			[3] = {--repeated EquipBackupServer
				[1] = 'int32':position	[质点位置]
				[2] = 'string':equipId	[质点id]
			},
		},
	}
--]]
s2c.EQUIPMENT_RES_EQUIP_BACKUP_INFO = 2841

--[[
	[1] = {--ResResultPreview
		[1] = 'string':equipmentId	[灵装id]
		[2] = {--repeated RemouldResultPreview
			[1] = 'int32':index	[属性id]
			[2] = {--repeated ResultPreview
				[1] = 'int32':head	[范围第一个值]
				[2] = 'int32':tail	[范围第二个值]
				[3] = 'int32':rate	[概率]
			},
		},
	}
--]]
s2c.EQUIPMENT_RES_RESULT_PREVIEW = 2827

--[[
	[1] = {--HelpFightHero
	}
--]]
s2c.PLAYER_HELP_FIGHT_HERO = 269

--[[
	[1] = {--ResRankInfo
		[1] = 'int32':type	[1是社团内部,2是社团之间]
		[2] = {--repeated RankInfo
			[1] = 'int32':id	[玩家id或者社团id]
			[2] = 'string':name	[1是个人奖励,2是全服奖励]
			[3] = 'string':score	[积分]
			[4] = 'int32':rank	[排名]
			[5] = 'int32':portraitCid	[头像id]
			[6] = 'int32':portraitFrameCid	[头像框id]
			[7] = 'int32':unionIcon	[社团icon]
		},
		[3] = {--RankInfo
			[1] = 'int32':id	[玩家id或者社团id]
			[2] = 'string':name	[1是个人奖励,2是全服奖励]
			[3] = 'string':score	[积分]
			[4] = 'int32':rank	[排名]
			[5] = 'int32':portraitCid	[头像id]
			[6] = 'int32':portraitFrameCid	[头像框id]
			[7] = 'int32':unionIcon	[社团icon]
		},
	}
--]]
s2c.WORLD_HELP_RES_RANK_INFO = 8802

--[[
	[1] = {--RefreshAreaRiddles
		[1] = 'int32':roomType	[大世界类型]
		[2] = {--repeated AreaRiddles
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':decryptTeamId	[谜语teamId]
			[3] = 'bool':success	[是否完成]
			[4] = 'int32':nextTriggerTime	[下一次的触发时间]
			[5] = {--repeated Riddles
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'int32':id	[谜语id]
				[3] = 'int32':lox	[x坐标]
				[4] = 'int32':loy	[y坐标]
				[5] = 'bool':correct	[是否正确]
				[6] = 'int32':playerId	[玩家id]
			},
		},
		[3] = 'string':roomId	[ 房间id]
	}
--]]
s2c.NEW_WORLD_REFRESH_AREA_RIDDLES = 6827

--[[
	[1] = {--OfficeItemsMsg
		[1] = {--repeated GridItem
			[1] = 'int32':itemId	[ 道具id]
			[2] = 'int32':itemNum	[ 道具数量]
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_ITEMS = 7206

--[[
	[1] = {--RespPhantomInfo
		[1] = {--repeated PhantomInfo
			[1] = 'int32':pos	[位置1,2,3]
			[2] = 'int32':phantomId	[id,没有就传0]
		},
		[2] = 'int32':type	[1表示请求返回,2表示服务器主动推送]
	}
--]]
s2c.PLAYER_RESP_PHANTOM_INFO = 301

--[[
	[1] = {--ExchangeBalloonNotify
		[1] = 'int32':friendId	[好友id]
		[2] = 'string':friendName	[好友名字]
		[3] = 'int64':timeout	[过期时间点]
	}
--]]
s2c.ACTIVITY_EXCHANGE_BALLOON_NOTIFY = 5194

--[[
	[1] = {--ResAskSwitch
		[1] = 'bool':openAsk	[是否开启问卷调查]
		[2] = 'string':askUrl	[问卷调查地址]
	}
--]]
s2c.PLAYER_RES_ASK_SWITCH = 287

--[[
	[1] = {--RespFormationBackupDesc
		[1] = {--FormationBackupInfo
			[1] = {--FormationInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'int32':type	[ 阵型类型]
				[3] = 'int32':status	[ 阵型状态 0 未启用 1 启用]
				[4] = 'repeated string':stance	[ 阵型英雄]
			},
			[2] = 'int32':id
			[3] = 'string':desc	[描述名称]
		},
	}
--]]
s2c.PLAYER_RESP_FORMATION_BACKUP_DESC = 299

--[[
	[1] = {--FightOverMsg
		[1] = {--LevelInfo
			[1] = 'int32':cid	[关卡cid]
			[2] = 'repeated int32':goals	[达成目标的下标]
			[3] = 'int32':fightCount	[战斗次数]
			[4] = 'bool':win	[是否胜利]
			[5] = 'int32':buyCount	[购买次数]
			[6] = 'int32':freeCount	[ 周卡或者是月卡的免费次数]
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[3] = 'bool':win	[是否胜利]
		[4] = {--repeated AdditionRewards
			[1] = 'int32':additionId	[配置表id]
			[2] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
		[5] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.DUNGEON_FIGHT_OVER = 1794

--[[
	[1] = {--RespAllActivityItem
		[1] = 'int32':activityId	[ 活动ID]
		[2] = 'int64':num	[ 活动道具数量]
	}
--]]
s2c.ACTIVITY_RESP_ALL_ACTIVITY_ITEM = 5156

--[[
	[1] = {--RespChristmasDungeons
		[1] = {--repeated ChristmasLevel
			[1] = 'int32':cid	[关卡cid]
			[2] = 'repeated int32':goals	[达成目标的下标]
			[3] = 'int32':fightCount	[战斗次数]
			[4] = 'bool':win	[是否胜利]
			[5] = 'int32':buyCount	[购买次数]
		},
		[2] = {--repeated ChristmasDungeonInfo
			[1] = 'int32':dungeonId	[章节id]
			[2] = 'int32':time	[开放时间]
		},
		[3] = {--ChristmasEnemyOccupy
			[1] = 'int32':invadeId	[配置id]
			[2] = 'int32':time	[开启时间]
		},
		[4] = {--repeated ChristmasMapBoxes
			[1] = 'int32':location	[位置信息]
			[2] = 'int32':eventCid	[事件信息]
		},
	}
--]]
s2c.CHRISTMAS_RESP_CHRISTMAS_DUNGEONS = 6608

--[[
	[1] = {--OfficeWorldInfoMsg
		[1] = 'int32':worldCid	[当前世界cid]
		[2] = {--repeated GridItem
			[1] = 'int32':itemId	[ 道具id]
			[2] = 'int32':itemNum	[ 道具数量]
		},
		[3] = {--repeated GridMission
			[1] = 'int32':missionId	[ 任务id]
			[2] = 'int32':progress	[ 任务进度]
		},
		[4] = {--repeated GridMapPoint
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'int32':event	[ 事件id,大于0则有事件]
			[4] = 'bool':eventValid	[ 事件是否可用]
			[5] = 'bool':visual	[ 是否可视,即是否开启格子]
			[6] = {--repeated GridPointInfo
				[1] = 'int32':x	[ x位置]
				[2] = 'int32':y	[ y位置]
			},
		},
		[5] = 'repeated int32':formation	[ 阵型信息]
		[6] = 'int32':currentX	[当前x点]
		[7] = 'int32':currentY	[当前y点]
		[8] = 'bool':firstUse	[是否首次当前世界]
		[9] = 'int32':mapCid	[当前地图cid]
		[10] = 'int32':eventRefresh	[随机事件刷新时间点]
		[11] = {--repeated GridPointInfo
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
		},
		[12] = {--GridBuffMsg
			[1] = {--repeated GridBuff
				[1] = 'int32':buffCid	[ buffCid]
				[2] = 'int32':begining	[ 开启时间点]
				[3] = 'int32':useCount	[ 使用次数]
			},
			[2] = {--ChangeType(enum)
				'v4':ChangeType
			},
		},
		[13] = {--GridTaskDiscoverMsg
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'bool':add	[ true为新增,否则为移除]
		},
		[14] = {--OfficeHiddenEventsMsg
			[1] = {--repeated GridHiddenEventMsg
				[1] = 'int32':eventCid	[ 事件cid]
				[2] = 'repeated int64':progress	[ 进度]
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_WORLD_INFO = 7202

--[[
	[1] = {--AreaOutlineMsg
		[1] = 'int32':curAreaCid	[当前区域cid]
		[2] = 'repeated int32':openAreas	[已激活的区域]
		[3] = 'repeated int32':finTasks	[已完成的任务]
		[4] = {--repeated OfficeComplteEvents
			[1] = 'int32':areaCid	[ 区域id]
			[2] = {--repeated OfficeComplteEvent
				[1] = 'int32':cid	[ 事件id]
				[2] = 'int32':num	[ 完成数量]
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_AREA_OUTLINE = 7102

--[[
	[1] = {--RespElementRank
		[1] = 'int32':rank	[排名]
	}
--]]
s2c.ELEMENT_COLLECT_RESP_ELEMENT_RANK = 4868

--[[
	[1] = {--RespFormationBackupUse
	}
--]]
s2c.PLAYER_RESP_FORMATION_BACKUP_USE = 298

--[[
	[1] = {--OfficeAreaAmbushMsg
		[1] = 'int32':ambushId	[伏击关卡id]
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_AREA_AMBUSH = 7210

--[[
	[1] = {--NoticeComposeFinish
		[1] = 'repeated int32':cid
	}
--]]
s2c.SUMMON_NOTICE_COMPOSE_FINISH = 3334

--[[
	[1] = {--RespInvestorScoreInfo
		[1] = 'int64':rechargeAmount	[历史充值金额(分)    //历史充值金额(分)]
		[2] = 'int64':onlineTime	[历史在线时间(毫秒)    //历史在线时间(毫秒)]
		[3] = 'int32':rechargeScore	[历史充值金额转化的积分]
		[4] = 'int32':onlineScore	[历史在线时间转化的积分]
		[5] = 'bool':asked	[是否请求过,true是]
		[6] = 'int32':activeScore	[历史活跃度积分]
	}
--]]
s2c.PLAYER_RESP_INVESTOR_SCORE_INFO = 295

--[[
	[1] = {--ResClueVote
	}
--]]
s2c.DETECTIVE_RES_CLUE_VOTE = 8910

--[[
	[1] = {--RespHalloweenPass
		[1] = {--repeated passInfo
			[1] = 'int32':dunId	[副本id]
			[2] = 'int32':passCount	[通过数量]
		},
	}
--]]
s2c.ACTIVITY_RESP_HALLOWEEN_PASS = 5202

--[[
	[1] = {--OfficePointExploreloMsg
		[1] = {--GridPointExploreloMsg
			[1] = 'bool':result	[ 探索结果]
			[2] = {--repeated GridPointInfo
				[1] = 'int32':x	[ x位置]
				[2] = 'int32':y	[ y位置]
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_POINT_EXPLORELO = 7217

--[[
	[1] = {--RspLadderLastData
		[1] = {--LastCycleRankList
			[1] = {--repeated RspLadderRank
				[1] = 'int32':pid	[玩家id]
				[2] = 'string':pName	[玩家名字]
				[3] = 'int32':segment	[段位]
				[4] = 'int32':laderScore	[天梯分]
				[5] = 'int32':rank	[排名,0则为未上榜]
				[6] = 'int32':headId	[头像]
				[7] = 'int32':level	[等级]
				[8] = 'int32':battleScore	[区域作战分]
				[9] = 'int32':ladderAddtion	[天梯加减分]
			},
			[2] = {--RspLadderRank
				[1] = 'int32':pid	[玩家id]
				[2] = 'string':pName	[玩家名字]
				[3] = 'int32':segment	[段位]
				[4] = 'int32':laderScore	[天梯分]
				[5] = 'int32':rank	[排名,0则为未上榜]
				[6] = 'int32':headId	[头像]
				[7] = 'int32':level	[等级]
				[8] = 'int32':battleScore	[区域作战分]
				[9] = 'int32':ladderAddtion	[天梯加减分]
			},
		},
		[2] = {--LastSeasonData
			[1] = 'int32':segment	[段位]
			[2] = 'int32':laderScore	[天梯分]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'int32':clientSeason	[客户端赛季显示]
		},
	}
--]]
s2c.LADDER_RSP_LADDER_LAST_DATA = 8303

--[[
	[1] = {--RespUpdateFinishProcess
		[1] = 'int32':id	[完成进度id]
		[2] = 'int32':chapterId	[章节id]
	}
--]]
s2c.ODEUM_RESP_UPDATE_FINISH_PROCESS = 6513

--[[
	[1] = {--OfficeItemsEventMsg
		[1] = {--GridItemsEventMsg
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = {--ItemList
				[1] = {--repeated ItemInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[ 实例ID]
					[3] = 'int32':cid	[ 配置ID]
					[4] = 'int64':num	[ 数量]
					[5] = 'int32':outTime	[过期时间]
				},
				[2] = {--repeated EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
				[3] = {--repeated DressInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[ 实例ID]
					[3] = 'int32':cid	[ 配置ID]
					[4] = 'string':roleId	[ 装备精灵ID]
					[5] = 'int32':outTime	[过期时间]
				},
				[4] = {--repeated NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
				[5] = {--repeated GemInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[宝石id]
					[3] = 'int32':cid	[宝石cid]
					[4] = 'int32':heroId	[英雄id]
					[5] = 'repeated int32':randSkill	[随机技能]
					[6] = {--GemRandSkill
						[1] = 'int32':originalSkill	[ 原始id]
						[2] = 'int32':newSkill	[ 新id]
					},
				},
				[6] = {--repeated TreasureInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[宝物id]
					[3] = 'int32':cid	[宝物cid]
					[4] = 'int32':star	[宝物星级]
				},
				[7] = {--repeated ExploreEquip
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[探索装备id]
					[3] = 'int32':cid	[探索装备cid]
					[4] = 'int32':level	[探索装备星级]
				},
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_ITEMS_EVENT = 7215

--[[
	[1] = {--RespQueryPlayer
		[1] = {--repeated FriendInfo
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':name	[ 名字]
			[3] = 'int32':fightPower	[ 战力]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int32':lastLoginTime	[ 最后登录时间]
			[6] = 'int32':lastHandselTime	[ 最后送礼时间]
			[7] = 'bool':receive	[ 是否能够领取]
			[8] = 'int32':status	[ 状态:1:好友,2:屏蔽,3:申请]
			[9] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
			[10] = 'bool':online	[ 是否在线]
			[11] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[12] = 'int32':time	[ 申请时间/加入黑名单时间等]
			[13] = 'int32':helpCDtime	[ 助战cd结束时间(秒)    // 助战cd结束时间(秒)]
			[14] = 'bool':canSend	[ 是否可以赠送]
			[15] = 'int32':portraitCid	[ 头像CID]
			[16] = 'int32':portraitFrameCid	[ 头像框CID]
			[17] = 'repeated int32':groupGiftIds	[团购礼包id]
			[18] = 'int32':type	[0没有关系,1他是我师父,2他是我徒弟,不包括出师的徒弟]
		},
	}
--]]
s2c.FRIEND_RESP_QUERY_PLAYER = 3076

--[[
	[1] = {--RespGetZZAllServerMsg
		[1] = 'int64':serverContribution	[贡献度]
	}
--]]
s2c.ACTIVITY_RESP_GET_ZZALL_SERVER = 5137

--[[
	[1] = {--Afk7810
	}
--]]
s2c.EXPLORE_AFK7810 = 7810

--[[
	[1] = {--ValentinePresentMsg
		[1] = 'int32':roleid	[ 情人节看板娘id]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.VALENTINE_VALENTINE_PRESENT = 7403

--[[
	[1] = {--OfficeTaskDiscoverMsg
		[1] = {--GridTaskDiscoverMsg
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'bool':add	[ true为新增,否则为移除]
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_TASK_DISCOVER = 7224

--[[
	[1] = {--AreaMoveMsg
		[1] = 'int32':areaCid	[目标区域cid]
	}
--]]
s2c.OFFICE_EXPLORE_AREA_MOVE = 7103

--[[
	[1] = {--RespSupportAddress
		[1] = 'string':address	[邮寄地址]
	}
--]]
s2c.ACTIVITY_RESP_SUPPORT_ADDRESS = 5155

--[[
	[1] = {--ResSFChangeStage
		[1] = 'int32':activityId
		[2] = 'int32':stage
	}
--]]
s2c.SPRING_FESTIVAL_RES_SFCHANGE_STAGE = 6706

--[[
	[1] = {--OfficePointsRefreshMsg
		[1] = {--repeated GridMapPoint
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'int32':event	[ 事件id,大于0则有事件]
			[4] = 'bool':eventValid	[ 事件是否可用]
			[5] = 'bool':visual	[ 是否可视,即是否开启格子]
			[6] = {--repeated GridPointInfo
				[1] = 'int32':x	[ x位置]
				[2] = 'int32':y	[ y位置]
			},
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_POINTS_REFRESH = 7219

--[[
	[1] = {--OfficePerformEventMsg
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_PERFORM_EVENT = 7220

--[[
	[1] = {--OfficeReplyGameMsg
		[1] = {--GridReplyGameMsg
			[1] = 'int32':eventCid	[ 事件cid]
			[2] = 'int32':gameCid	[ 游戏cid]
			[3] = {--ItemList
				[1] = {--repeated ItemInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[ 实例ID]
					[3] = 'int32':cid	[ 配置ID]
					[4] = 'int64':num	[ 数量]
					[5] = 'int32':outTime	[过期时间]
				},
				[2] = {--repeated EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
				[3] = {--repeated DressInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[ 实例ID]
					[3] = 'int32':cid	[ 配置ID]
					[4] = 'string':roleId	[ 装备精灵ID]
					[5] = 'int32':outTime	[过期时间]
				},
				[4] = {--repeated NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
				[5] = {--repeated GemInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[宝石id]
					[3] = 'int32':cid	[宝石cid]
					[4] = 'int32':heroId	[英雄id]
					[5] = 'repeated int32':randSkill	[随机技能]
					[6] = {--GemRandSkill
						[1] = 'int32':originalSkill	[ 原始id]
						[2] = 'int32':newSkill	[ 新id]
					},
				},
				[6] = {--repeated TreasureInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[宝物id]
					[3] = 'int32':cid	[宝物cid]
					[4] = 'int32':star	[宝物星级]
				},
				[7] = {--repeated ExploreEquip
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[探索装备id]
					[3] = 'int32':cid	[探索装备cid]
					[4] = 'int32':level	[探索装备星级]
				},
			},
			[4] = 'repeated int32':options	[ 参数列表]
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_REPLY_GAME = 7229

--[[
	[1] = {--ResEquipRecycle
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EQUIPMENT_RES_EQUIP_RECYCLE = 2824

--[[
	[1] = {--UpdateContributionMsg
		[1] = 'int64':serverContribution	[贡献度]
	}
--]]
s2c.ODEUM_UPDATE_CONTRIBUTION = 6505

--[[
	[1] = {--ResDecomposeMaterials
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.HERO_RES_DECOMPOSE_MATERIALS = 1049

--[[
	[1] = {--LevelSpecialConditions
		[1] = 'repeated int32':datingNodes	[完成的相关约会节点]
	}
--]]
s2c.ODEUM_LEVEL_SPECIAL_CONDITIONS = 6511

--[[
	[1] = {--ComposeSummon
		[1] = {--ComposeInfo
			[1] = 'int32':cid	[合成配置id]
			[2] = 'int32':finishTime	[完成时间]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'int32':costTime	[消耗时间]
		},
	}
--]]
s2c.SUMMON_COMPOSE_SUMMON = 3330

--[[
	[1] = {--RespAreaShowTime
		[1] = 'int32':roomType	[大世界类型]
		[2] = {--AreaShowTime
			[1] = 'int32':decorateId
			[2] = 'int32':stime	[开始时间]
			[3] = 'int32':etime	[结束时间]
			[4] = 'int32':needToShow	[需要展示的时间分钟数]
		},
	}
--]]
s2c.NEW_WORLD_RESP_AREA_SHOW_TIME = 6825

--[[
	[1] = {--RespFinishProcess
		[1] = 'int32':id	[完成进度id]
		[2] = 'int32':chapterId	[章节id]
	}
--]]
s2c.ODEUM_RESP_FINISH_PROCESS = 6514

--[[
	[1] = {--QliphothTimeMsg
		[1] = 'int32':startTime	[开启时间点]
		[2] = 'int32':endTime	[关闭时间点]
	}
--]]
s2c.QLIPHOTH_QLIPHOTH_TIME = 6222

--[[
	[1] = {--ResBlackWhite
		[1] = 'int32':dayTimes	[本日参与次数]
	}
--]]
s2c.NEW_WORLD_RES_BLACK_WHITE = 6818

--[[
	[1] = {--ChristmasInvadeRefresh
		[1] = {--ChristmasEnemyOccupy
			[1] = 'int32':invadeId	[配置id]
			[2] = 'int32':time	[开启时间]
		},
	}
--]]
s2c.CHRISTMAS_CHRISTMAS_INVADE_REFRESH = 6610

--[[
	[1] = {--ResSaveEquipBackupPos
		[1] = {--EquipBackupInfo
			[1] = 'int32':id	[ 方案id]
			[2] = 'string':desc	[方案描述]
			[3] = {--repeated EquipBackupServer
				[1] = 'int32':position	[质点位置]
				[2] = 'string':equipId	[质点id]
			},
		},
	}
--]]
s2c.EQUIPMENT_RES_SAVE_EQUIP_BACKUP_POS = 2842

--[[
	[1] = {--RespCatUpLevel
		[1] = {--CatInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[猫咪id]
			[3] = 'int32':level	[猫咪等级]
			[4] = 'int32':exp	[猫咪经验]
			[5] = 'int32':status	[猫咪状态]
			[6] = 'int32':taskId	[任务id]
			[7] = 'int32':creatAt	[获取时间]
		},
		[2] = 'int32':oldLevel	[旧的猫咪等级]
	}
--]]
s2c.ACTIVITY_RESP_CAT_UP_LEVEL = 5216

--[[
	[1] = {--ResDrawCompass
		[1] = {--repeated Pair
			[1] = 'int32':key
			[2] = 'int32':value
		},
	}
--]]
s2c.ACTIVITY_RES_DRAW_COMPASS = 5302

--[[
	[1] = {--ResAreaPlayerEnter
		[1] = {--AreaPlayerInfo
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':pname	[ 玩家昵称]
			[3] = 'int32':level
			[4] = 'int32':heroCid
			[5] = 'int32':skinCid
			[6] = 'int32':unionId
			[7] = 'string':unionName
			[8] = 'int32':titleId
			[9] = {--AreaPlayerPos
				[1] = 'int32':x
				[2] = 'int32':y
				[3] = 'int32':dir
				[4] = 'int32':dt
			},
			[10] = 'int32':buildId	[游戏id]
			[11] = 'int32':effectId	[特效id]
		},
		[2] = 'int32':roomType	[大世界类型]
	}
--]]
s2c.NEW_WORLD_RES_AREA_PLAYER_ENTER = 6804

--[[
	[1] = {--RespMainAdBoardInfo
		[1] = {--repeated MainAdBoardInfo
			[1] = 'int32':Id
			[2] = 'int32':activityType
			[3] = 'string':jumpId
			[4] = 'string':adicon
			[5] = 'int32':isOpen
			[6] = 'int32':sort
			[7] = 'string':name
			[8] = 'int32':startTime
			[9] = 'int32':endTime
			[10] = 'repeated int32':os
		},
	}
--]]
s2c.SIGN_RESP_MAIN_AD_BOARD_INFO = 5120

--[[
	[1] = {--UpdateBossDungeonMsg
		[1] = 'int32':bossDungeonId	[boss关卡id]
	}
--]]
s2c.ODEUM_UPDATE_BOSS_DUNGEON = 6506

--[[
	[1] = {--RespSyncFightWorldDecorate
		[1] = 'int32':roomType	[大世界类型]
		[2] = {--repeated RoomDecorate
			[1] = 'int32':decorateId	[建筑id]
			[2] = 'string':pid	[实例id]
			[3] = {--AreaPlayerPos
				[1] = 'int32':x
				[2] = 'int32':y
				[3] = 'int32':dir
				[4] = 'int32':dt
			},
			[4] = 'string':ext	[额外信息]
		},
	}
--]]
s2c.NEW_WORLD_RESP_SYNC_FIGHT_WORLD_DECORATE = 6823

--[[
	[1] = {--RefreshRiddles
		[1] = 'int32':roomType	[大世界类型]
		[2] = 'int32':decryptTeamId	[谜语teamId]
		[3] = {--repeated Riddles
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[谜语id]
			[3] = 'int32':lox	[x坐标]
			[4] = 'int32':loy	[y坐标]
			[5] = 'bool':correct	[是否正确]
			[6] = 'int32':playerId	[玩家id]
		},
		[4] = 'string':roomId	[ 房间id]
	}
--]]
s2c.NEW_WORLD_REFRESH_RIDDLES = 6828

--[[
	[1] = {--RespAITrainingRank
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'int32':type	[类型-1 周榜  2月榜    //类型-1 周榜  2月榜]
		[3] = {--repeated AITrainingRankDetail
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':headId	[头像]
			[4] = 'int32':headFrame	[头像框]
			[5] = 'int32':pLevel	[玩家等级]
			[6] = 'int32':fightPower	[战力]
			[7] = 'int32':rank	[名次]
			[8] = 'int32':gid	[服务器组id,不同组之间pid可能有相同]
			[9] = 'string':channel	[渠道appid,不同组之间pid可能有相同]
			[10] = 'int32':trainLv	[调教等级]
			[11] = 'int32':sucNum	[通过量]
			[12] = 'int32':totalNum	[总量]
		},
		[4] = {--AITrainingRankDetail
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':headId	[头像]
			[4] = 'int32':headFrame	[头像框]
			[5] = 'int32':pLevel	[玩家等级]
			[6] = 'int32':fightPower	[战力]
			[7] = 'int32':rank	[名次]
			[8] = 'int32':gid	[服务器组id,不同组之间pid可能有相同]
			[9] = 'string':channel	[渠道appid,不同组之间pid可能有相同]
			[10] = 'int32':trainLv	[调教等级]
			[11] = 'int32':sucNum	[通过量]
			[12] = 'int32':totalNum	[总量]
		},
	}
--]]
s2c.DATING_RESP_AITRAINING_RANK = 1564

--[[
	[1] = {--RspRollYouci
		[1] = 'repeated int32':rollNum	[投掷的数字  (存在多次投掷,按顺序解析)    //投掷的数字  (存在多次投掷,按顺序解析)]
		[2] = 'repeated int32':movePos	[每次移动的位置]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[4] = {--repeated YouciRecordsMsg
			[1] = 'int64':time	[日期时间]
			[2] = 'int32':result	[投掷结果]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
		[5] = 'int32':rounds	[总轮数(圈数)    //总轮数(圈数)]
	}
--]]
s2c.YOUCI_RSP_ROLL_YOUCI = 9352

--[[
	[1] = {--ResAreaPlayerLeave
		[1] = 'int32':pid
		[2] = 'int32':roomType	[大世界类型]
	}
--]]
s2c.NEW_WORLD_RES_AREA_PLAYER_LEAVE = 6805

--[[
	[1] = {--RespWeekUpdate
		[1] = 'int32':weekExp	[周活跃]
		[2] = 'int32':lastWeekActive	[上周活跃度]
	}
--]]
s2c.UNION_RESP_WEEK_UPDATE = 6670

--[[
	[1] = {--ShopPurchaseMsg
		[1] = {--repeated QliphothShopItem
			[1] = 'int32':itemId	[ 道具id]
			[2] = 'int32':itemNum	[ 道具数量]
			[3] = 'int32':buyCount	[ 已购买次数]
		},
		[2] = {--repeated QliphothItem
			[1] = 'int32':itemId	[ 道具id]
			[2] = 'int32':itemNum	[ 道具数量]
		},
	}
--]]
s2c.QLIPHOTH_SHOP_PURCHASE = 6212

--[[
	[1] = {--GetScriptMsg
	}
--]]
s2c.DATING_GET_SCRIPT = 1537

--[[
	[1] = {--RespUpdateBuildingInfo
		[1] = {--repeated NewBuildingInfo
			[1] = 'int32':buildingId	[配置id]
			[2] = 'repeated int32':buildingFuns
		},
		[2] = {--repeated RoleInRoom
			[1] = 'int64':dressId	[配置功能模型id]
			[2] = 'int32':buildingId	[配置id;]
			[3] = 'int32':cityRoleId	[配置id;]
		},
		[3] = {--repeated RemindEvent
			[1] = 'int32':buildingId	[建筑id]
			[2] = 'int32':funId	[功能id]
			[3] = 'int32':exeId	[执行Id]
			[4] = 'int32':eventType	[提醒类型]
		},
		[4] = 'int32':dayType	[是白天还是黑夜]
	}
--]]
s2c.NEW_BUILDING_RESP_UPDATE_BUILDING_INFO = 2072

--[[
	[1] = {--GetAllElement
		[1] = {--repeated Elements
			[1] = 'int32':type	[类型]
			[2] = {--repeated Element
				[1] = 'int32':cid	[cid]
				[2] = 'int32':reward	[领奖状态 0不可领取  1可领取 2 已领取]
			},
			[3] = 'int32':trophy	[奖杯数]
			[4] = 'bool':scan	[是否可以浏览]
		},
		[2] = 'int32':rank	[排名]
		[3] = 'int32':totleTrophy	[总奖杯数]
	}
--]]
s2c.ELEMENT_COLLECT_GET_ALL_ELEMENT = 4865

--[[
	[1] = {--RespSetChallengeHero
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
s2c.DUNGEON_RESP_SET_CHALLENGE_HERO = 1821

--[[
	[1] = {--RespGetHeartState
		[1] = {--repeated RespHeartState
			[1] = 'int32':roleId	[精灵id]
			[2] = 'int32':sealState	[精灵封印状态  0:未封印 1:封印]
			[3] = 'int32':sealType	[解锁方式  0:时间解锁 1:道具解锁]
		},
	}
--]]
s2c.DATING_RESP_GET_HEART_STATE = 1558

--[[
	[1] = {--GetGashaponInfo
		[1] = 'string':eggPool	[抓娃娃蛋池]
		[2] = 'int64':pollRefreshCdEndTime	[蛋池刷新cd结束时间]
		[3] = 'int64':catchEndTime	[本次抓娃娃结束时间]
		[4] = 'int32':eggPoolId	[蛋池id]
	}
--]]
s2c.NEW_BUILDING_GET_GASHAPON_INFO = 2062

--[[
	[1] = {--RespGetHandWorkInfo
		[1] = {--HandWorkInfo
			[1] = 'int32':manualId
			[2] = 'int32':endTime
			[3] = 'int32':integral
			[4] = 'int32':times
		},
	}
--]]
s2c.NEW_BUILDING_RESP_GET_HAND_WORK_INFO = 2080

--[[
	[1] = {--NotifyWorldNotice
		[1] = 'int32':type	[世界情报类型]
		[2] = 'string':playerName	[玩家名]
		[3] = 'int32':param	[参数]
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.CHRISTMAS_NOTIFY_WORLD_NOTICE = 6605

--[[
	[1] = {--RespStartGashapon
		[1] = 'int64':catchEndTime	[本次抓娃娃结束时间]
	}
--]]
s2c.NEW_BUILDING_RESP_START_GASHAPON = 2063

--[[
	[1] = {--RespPartTimeJobAward
		[1] = {--JobInfoList
			[1] = 'int32':buildingId	[建筑ID]
			[2] = {--repeated JobInfo
				[1] = 'int32':buildingId	[建筑ID]
				[2] = 'int32':type	[白天还是黑夜]
				[3] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
				[4] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
				[5] = 'int32':jobId	[兼职ID]
				[6] = 'int32':jobType	[兼职任务状态]
				[7] = 'int32':etime	[兼职任务结束时间]
			},
			[3] = 'int32':level	[建筑兼职等级]
			[4] = 'int64':exp	[建筑兼职经验值]
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[4] = 'int64':addExp	[兼职任务获得的兼职经验]
	}
--]]
s2c.NEW_BUILDING_RESP_PART_TIME_JOB_AWARD = 2078

--[[
	[1] = {--ResDetectiveEnter
	}
--]]
s2c.DETECTIVE_RES_DETECTIVE_ENTER = 8906

--[[
	[1] = {--WorldTransformMsg
		[1] = {--ParticleMapPoint
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
			[3] = 'int32':event	[ 事件id,大于0则有事件]
			[4] = 'bool':eventValid	[ 事件是否可用]
			[5] = 'bool':visual	[ 是否可视,即是否开启格子]
			[6] = {--repeated WorldPointInfo
				[1] = 'int32':x	[ x位置]
				[2] = 'int32':y	[ y位置]
			},
		},
	}
--]]
s2c.QLIPHOTH_WORLD_TRANSFORM = 6211

--[[
	[1] = {--RespChangeLinkAgeDesire
		[1] = 'int32':attributeId	[属性id]
		[2] = 'int32':heroId	[英雄id]
	}
--]]
s2c.DUNGEON_RESP_CHANGE_LINK_AGE_DESIRE = 1827

--[[
	[1] = {--ExploreUpdateSkin
		[1] = 'int32':skinId
	}
--]]
s2c.EXPLORE_EXPLORE_UPDATE_SKIN = 7842

--[[
	[1] = {--RespResetFlopGame
	}
--]]
s2c.ACTIVITY_RESP_RESET_FLOP_GAME = 5158

--[[
	[1] = {--ResVoteResult
		[1] = {--repeated DetectiveVoteStat
			[1] = 'int32':day
			[2] = {--repeated DetectiveStat
				[1] = 'int32':id	[id]
				[2] = 'int32':count	[票数]
			},
		},
	}
--]]
s2c.DETECTIVE_RES_VOTE_RESULT = 8912

--[[
	[1] = {--RespPartTimeJobList
		[1] = {--JobInfo
			[1] = 'int32':buildingId	[建筑ID]
			[2] = 'int32':type	[白天还是黑夜]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[5] = 'int32':jobId	[兼职ID]
			[6] = 'int32':jobType	[兼职任务状态]
			[7] = 'int32':etime	[兼职任务结束时间]
		},
		[2] = {--repeated JobInfoList
			[1] = 'int32':buildingId	[建筑ID]
			[2] = {--repeated JobInfo
				[1] = 'int32':buildingId	[建筑ID]
				[2] = 'int32':type	[白天还是黑夜]
				[3] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
				[4] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
				[5] = 'int32':jobId	[兼职ID]
				[6] = 'int32':jobType	[兼职任务状态]
				[7] = 'int32':etime	[兼职任务结束时间]
			},
			[3] = 'int32':level	[建筑兼职等级]
			[4] = 'int64':exp	[建筑兼职经验值]
		},
	}
--]]
s2c.NEW_BUILDING_RESP_PART_TIME_JOB_LIST = 2076

--[[
	[1] = {--TakeOffMsg
		[1] = 'bool':success
	}
--]]
s2c.EQUIPMENT_TAKE_OFF = 2818

--[[
	[1] = {--ConfirmTrade
	}
--]]
s2c.ACTIVITY_CONFIRM_TRADE = 5199

--[[
	[1] = {--RespOperateFight
	}
--]]
s2c.FIGHT_RESP_OPERATE_FIGHT = 25603

--[[
	[1] = {--RespNeptune2ndHalfCityRefresh
		[1] = {--repeated Neptune2ndHalfCity
			[1] = 'int32':id	[城市id]
			[2] = 'int32':dungeon	[当前关卡,如果为0则点位不可用]
			[3] = 'bool':resOpen	[是否解锁资源]
			[4] = 'int32':resCount	[资源可用次数]
			[5] = 'int32':resStartTime	[资源开始时间]
			[6] = 'int32':resUpTime	[下次资源增加时间]
			[7] = 'bool':replace	[是否替换关卡]
			[8] = 'int32':replaceEnd	[替换结束时间]
			[9] = 'int32':replaceGame	[替换的小游戏]
			[10] = 'bool':pass	[是否通关]
		},
	}
--]]
s2c.NEPTUNE2ND_HALF_RESP_NEPTUNE2ND_HALF_CITY_REFRESH = 7703

--[[
	[1] = {--HiddenEventsMsg
		[1] = {--repeated HiddenEventMsg
			[1] = 'int32':eventCid	[ 事件cid]
			[2] = 'repeated int64':progress	[ 进度]
		},
	}
--]]
s2c.QLIPHOTH_HIDDEN_EVENTS = 6226

--[[
	[1] = {--ExploreTreasureStarUpMsg
		[1] = 'string':id	[ 宝物uid]
	}
--]]
s2c.EXPLORE_EXPLORE_TREASURE_STAR_UP = 7831

--[[
	[1] = {--RespHuntingFDAward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[2] = {--repeated HuntingBossAward
			[1] = 'int32':dungeon	[副本id]
			[2] = 'int32':status	[领取状态,1 未满足条件,2 可领取,3 已领取]
		},
	}
--]]
s2c.HUNTING_DUNGEON_RESP_HUNTING_FDAWARD = 8504

--[[
	[1] = {--GetComposePrize
		[1] = 'int32':id	[合成id]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.CHRISTMAS_GET_COMPOSE_PRIZE = 6603

--[[
	[1] = {--RespEquipMedal
		[1] = 'bool':success
	}
--]]
s2c.MEDAL_RESP_EQUIP_MEDAL = 3002

--[[
	[1] = {--RespEndFightOther
		[1] = 'int32':pid	[ 玩家ID]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[3] = 'int32':extTips	[ 玩家ID]
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.FIGHT_RESP_END_FIGHT_OTHER = 25613

--[[
	[1] = {--RespChangeUiChange
		[1] = 'int32':cid
	}
--]]
s2c.MEDAL_RESP_CHANGE_UI_CHANGE = 3011

--[[
	[1] = {--RespgetAwardSacrifice
		[1] = {--CellInfo
			[1] = 'int32':totleStep	[步数]
			[2] = 'int32':location	[位置]
			[3] = 'repeated int32':buffIds	[buff]
			[4] = 'repeated int32':cellIds	[格子id]
			[5] = {--CellEvent
				[1] = 'int32':eventId	[事件id]
				[2] = 'bool':status	[事件是否完成(0未完成 1完成)    //事件是否完成(0未完成 1完成)]
			},
			[6] = {--RecordBuffList
				[1] = 'repeated int32':buffId	[buffId]
			},
		},
		[2] = 'int32':awardStep	[向前的色子数]
		[3] = 'int32':buffStep	[buff增加向前的色子数]
		[4] = {--repeated CellAwardInfo
			[1] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[2] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
		[5] = {--EventAwardInfo
			[1] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[2] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[3] = 'int32':eventId	[格子事件Id]
		},
	}
--]]
s2c.SACRIFICE_RESPGET_AWARD_SACRIFICE = 8001

--[[
	[1] = {--RspRefreshLadderHeroCount
		[1] = {--repeated RspUsingCount
			[1] = 'int32':itemCid	[道具cid]
			[2] = 'int32':count	[次数]
		},
	}
--]]
s2c.LADDER_RSP_REFRESH_LADDER_HERO_COUNT = 8312

--[[
	[1] = {--ResSimulateSummon
		[1] = 'int32':cid
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[3] = {--SummonNoob
			[1] = 'bool':noobStatus	[ 功能是否可用]
			[2] = 'int32':endTime	[ 结束时间]
			[3] = 'int32':summonCount	[ 召唤次数]
			[4] = 'int32':awardState	[ 领奖状态,0 条件未达 1 可领取 2 已领取]
		},
		[4] = {--SimulateSummon
			[1] = 'int32':cid
			[2] = 'int32':simulateSummonCount
			[3] = 'int32':sysSimulateSummonCount
			[4] = 'int32':exchangeCount
			[5] = {--repeated SimulateSummonRecord
				[1] = 'int32':order
				[2] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
				[3] = 'bool':isReceive
			},
		},
		[5] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SUMMON_RES_SIMULATE_SUMMON = 3350

--[[
	[1] = {--Afk7814
	}
--]]
s2c.EXPLORE_AFK7814 = 7814

--[[
	[1] = {--ResRepairData
		[1] = 'string':progress	[进度]
		[2] = 'int32':level	[全服等级]
		[3] = {--repeated RepairOutput
			[1] = 'int32':index	[对应配置表顺序,从1开始]
			[2] = 'int32':output	[产量]
		},
	}
--]]
s2c.ACTIVITY2_RES_REPAIR_DATA = 9403

--[[
	[1] = {--ResManaLevelUp
		[1] = {--ManaBagInfo
			[1] = 'int32':id
			[2] = 'int32':level
		},
	}
--]]
s2c.MANA_RESONANCE_RES_MANA_LEVEL_UP = 7601

--[[
	[1] = {--RespNewYearWelfareUrl
		[1] = 'string':url	[新年福利站网页跳转url]
	}
--]]
s2c.ACTIVITY_RESP_NEW_YEAR_WELFARE_URL = 5134

--[[
	[1] = {--MailInfoList
		[1] = {--repeated MailInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 邮件ID]
			[3] = 'int32':senderId	[ 发送者id]
			[4] = 'string':senderName	[ 发送者名字]
			[5] = 'int32':createTime	[ 创建时间]
			[6] = 'int32':modifiedTime	[ 邮件时间]
			[7] = 'int32':status	[ 状态]
			[8] = 'string':title	[ 邮件标题]
			[9] = 'string':body	[ 邮件正文]
			[10] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[11] = 'int32':mailType	[1是普通邮件,3是特殊邮件]
		},
	}
--]]
s2c.MAIL_MAIL_INFO_LIST = 772

--[[
	[1] = {--RespRefreshMaid
		[1] = {--repeated MaidObject
			[1] = 'int32':onlyId	[女仆唯一id]
			[2] = 'int32':cid	[女仆配置id]
			[3] = 'int32':strength	[女仆的体力]
		},
	}
--]]
s2c.MAID_ACTIVITY_RESP_REFRESH_MAID = 9155

--[[
	[1] = {--RespSingleComment
		[1] = 'bool':success	[成功:true]
	}
--]]
s2c.COMMENT_RESP_SINGLE_COMMENT = 4002

--[[
	[1] = {--RespSpringWithTreeList
		[1] = {--WishTreeInfo
			[1] = 'int32':playerId
			[2] = 'string':name	[名字]
			[3] = 'int32':portraitCid	[头像id]
			[4] = 'int32':portraitFrameCid	[头像框id]
			[5] = 'string':context	[许愿信息]
			[6] = 'int32':time	[许愿时间,秒级时间戳]
		},
		[2] = {--repeated WishTreeInfo
			[1] = 'int32':playerId
			[2] = 'string':name	[名字]
			[3] = 'int32':portraitCid	[头像id]
			[4] = 'int32':portraitFrameCid	[头像框id]
			[5] = 'string':context	[许愿信息]
			[6] = 'int32':time	[许愿时间,秒级时间戳]
		},
		[3] = {--repeated WishTreeInfo
			[1] = 'int32':playerId
			[2] = 'string':name	[名字]
			[3] = 'int32':portraitCid	[头像id]
			[4] = 'int32':portraitFrameCid	[头像框id]
			[5] = 'string':context	[许愿信息]
			[6] = 'int32':time	[许愿时间,秒级时间戳]
		},
	}
--]]
s2c.ACTIVITY2_RESP_SPRING_WITH_TREE_LIST = 9413

--[[
	[1] = {--RespSaveNewEquipPlan
	}
--]]
s2c.EQUIPMENT_RESP_SAVE_NEW_EQUIP_PLAN = 2848

--[[
	[1] = {--RespChangeRoleId
		[1] = 'int32':roleId	[消耗类型]
	}
--]]
s2c.MAID_ACTIVITY_RESP_CHANGE_ROLE_ID = 9157

--[[
	[1] = {--RespHuntingDungeonInfo
		[1] = {--HuntingStep
			[1] = 'int32':step	[当前阶段,0 功能未开放, 1 准备期开放, 2 准备期结算, 3 准备期结束, 11 正式挑战开放, 12 正式挑战结算, 13 正式挑战结束]
			[2] = 'int32':nextTime	[下阶段开始时间点]
		},
		[2] = {--HuntingBoss
			[1] = 'int32':curDungeon	[当前boss]
			[2] = 'int32':dungeonHp	[剩余血量万分比]
			[3] = 'int32':leftCount	[个人剩余次数]
			[4] = 'repeated int32':dungeonBuffs	[boss关卡buff]
			[5] = 'int32':honor	[当前荣耀值]
		},
		[3] = {--HuntingPlayerWeakness
			[1] = {--repeated HuntingWeakness
				[1] = 'int32':dungeon	[副本id]
				[2] = 'int32':count	[通关次数]
			},
			[2] = 'int32':leftCount	[个人剩余次数]
		},
	}
--]]
s2c.HUNTING_DUNGEON_RESP_HUNTING_DUNGEON_INFO = 8501

--[[
	[1] = {--ResSendBulletScreen
		[1] = 'string':content
		[2] = 'int32':type
		[3] = 'int32':lastSendTime
		[4] = 'int32':dialogueId	[约会弹幕 句子id]
	}
--]]
s2c.CHAT_RES_SEND_BULLET_SCREEN = 2315

--[[
	[1] = {--RespBuyResources
		[1] = 'int32':cid
		[2] = 'int32':count
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.PLAYER_RESP_BUY_RESOURCES = 275

--[[
	[1] = {--RespRefreshRecruit
		[1] = {--RecruitInfo
			[1] = {--repeated Recruit
				[1] = 'int32':cid	[招募id]
				[2] = 'bool':state	[招募状态]
			},
			[2] = 'int32':nextTime	[下一次的免费刷新时间]
			[3] = 'int32':recruitTimes	[每一天的招募次数]
			[4] = 'int32':recruitBuyTimes	[每一天的购买刷新次数]
		},
	}
--]]
s2c.MAID_ACTIVITY_RESP_REFRESH_RECRUIT = 9154

--[[
	[1] = {--Cabin
		[1] = 'int32':id	[舱室id]
		[2] = 'int32':cid	[舱室配置id]
		[3] = 'int32':holeCount	[镶嵌孔位数量]
		[4] = {--repeated Equip
			[1] = 'string':id
			[2] = 'int32':cid
			[3] = 'int32':level
			[4] = 'int32':index	[镶嵌的位置,从1开始,如果为0,没有镶嵌]
			[5] = 'int32':cabinId	[舱室id]
		},
		[5] = {--repeated AfkTask
			[1] = 'int32':id
			[2] = 'int32':state	[任务状态 0 未开始 1开始 2完成,3已领奖]
			[3] = 'repeated int32':heroId	[任务派遣的hero]
			[4] = 'int64':startTime	[任务开始执行的时间 0 就是还没有开始或者已经完成]
			[5] = 'int32':cabinId	[舱室id]
		},
		[6] = {--repeated HeroDriver
			[1] = 'int32':index	[舱室指挥室位置]
			[2] = 'int32':heroId	[精灵id]
		},
		[7] = 'int32':fightPower	[精灵总战斗力]
		[8] = {--repeated Treasure
			[1] = 'int32':index	[格子索引]
			[2] = 'string':uuid	[装备在格子上的宝物uid]
		},
	}
--]]
s2c.EXPLORE_CABIN = 7802

--[[
	[1] = {--RespWorldRelevantData
		[1] = 'int32':roomType	[大世界类型]
		[2] = {--RelevantData
			[1] = {--repeated WorldGiftInfo
				[1] = 'int32':type
				[2] = 'int32':count
			},
		},
		[3] = 'string':ext	[不共用数据]
	}
--]]
s2c.NEW_WORLD_RESP_WORLD_RELEVANT_DATA = 6824

--[[
	[1] = {--RspOldSpiritView
		[1] = {--repeated OldHeroSpiritView
			[1] = 'int32':hero	[英雄cid]
			[2] = 'int32':grade	[品阶从0开始]
			[3] = 'int32':level	[级数从0开始]
			[4] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
	}
--]]
s2c.HERO_SPIRIT_RSP_OLD_SPIRIT_VIEW = 8410

--[[
	[1] = {--RespgetFoodbaseInfo
		[1] = {--FoodbaseInfo
			[1] = 'int32':foodId
			[2] = 'int32':endTime
			[3] = 'int32':integral
			[4] = 'int32':times
		},
	}
--]]
s2c.NEW_BUILDING_RESPGET_FOODBASE_INFO = 2066

--[[
	[1] = {--RespGetMaidEventAward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.MAID_ACTIVITY_RESP_GET_MAID_EVENT_AWARD = 9159

--[[
	[1] = {--QliphothItemsMsg
		[1] = {--repeated QliphothItem
			[1] = 'int32':itemId	[ 道具id]
			[2] = 'int32':itemNum	[ 道具数量]
		},
	}
--]]
s2c.QLIPHOTH_QLIPHOTH_ITEMS = 6206

--[[
	[1] = {--Afk7805
	}
--]]
s2c.EXPLORE_AFK7805 = 7805

--[[
	[1] = {--RespChangeMaidWork
		[1] = 'repeated int32':workLists	[工作列表]
	}
--]]
s2c.MAID_ACTIVITY_RESP_CHANGE_MAID_WORK = 9151

--[[
	[1] = {--NewResqYearActivityMonthProgress
		[1] = {--repeated ActivityProgressMsg
			[1] = 'int32':id	[活动id]
			[2] = 'int32':itemId	[条目ID]
			[3] = 'int32':progress	[当前进度]
			[4] = 'string':extend	[进度扩展字段--用于记载单int型不能充分记录的复杂进度    //进度扩展字段--用于记载单int型不能充分记录的复杂进度]
			[5] = 'int32':status	[状态]
		},
	}
--]]
s2c.ACTIVITY_NEW_RESQ_YEAR_ACTIVITY_MONTH_PROGRESS = 5144

--[[
	[1] = {--OfficeExploreTimeMsg
		[1] = 'int32':startTime	[开启时间点]
		[2] = 'int32':endTime	[关闭时间点]
		[3] = 'int32':showTime	[展示时间点]
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_EXPLORE_TIME = 7101

--[[
	[1] = {--RespUseNewEquipPlan
	}
--]]
s2c.EQUIPMENT_RESP_USE_NEW_EQUIP_PLAN = 2847

--[[
	[1] = {--RespReconnect
	}
--]]
s2c.LOGIN_RESP_RECONNECT = 261

--[[
	[1] = {--ResJoinGroupTeam
		[1] = {--GroupTeamInfo
			[1] = 'string':teamId	[队伍id]
			[2] = 'int32':createTime	[创建时间]
			[3] = 'int32':giftId	[礼包id]
			[4] = 'bool':isShow	[是否显示]
			[5] = 'bool':isComplete	[是否完成]
			[6] = 'bool':isDestroy	[是否销毁]
			[7] = {--repeated GroupTeamMember
				[1] = 'int32':playerId
				[2] = 'string':playerName
				[3] = 'int32':titleId
				[4] = 'int32':level
				[5] = 'bool':isCreator
				[6] = 'int32':portraitCid
				[7] = 'int32':portraitFrameId
			},
		},
	}
--]]
s2c.RECHARGE_RES_JOIN_GROUP_TEAM = 4377

--[[
	[1] = {--NewResqYearActivityMonthItems
		[1] = {--repeated ActivityItemMsg
			[1] = 'int32':id	[条目ID]
			[2] = 'int32':type	[活动类型]
			[3] = 'string':name	[标题]
			[4] = 'string':details	[条目描述]
			[5] = 'string':target	[条目目标]
			[6] = 'string':reward	[条目奖励]
			[7] = 'string':extendData	[扩展数据]
			[8] = 'int32':rank	[排序]
			[9] = 'int32':subType	[条目子类型]
		},
	}
--]]
s2c.ACTIVITY_NEW_RESQ_YEAR_ACTIVITY_MONTH_ITEMS = 5143

--[[
	[1] = {--ResTakeRepairOutput
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY2_RES_TAKE_REPAIR_OUTPUT = 9405

--[[
	[1] = {--RespRewardInvite
		[1] = {--repeated InviteRewardInfo
			[1] = 'int32':cid	[ 奖励模板ID]
			[2] = 'int32':status	[ 领取状态(0-不可领取 1-可领取 2-已领取)    // 领取状态(0-不可领取 1-可领取 2-已领取)]
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.FRIEND_RESP_REWARD_INVITE = 3080

--[[
	[1] = {--RespYearLottoNewPlayer
		[1] = {--repeated YearLottoPlayerInfo
			[1] = 'int32':pid	[玩家id]
			[2] = 'string':pName	[玩家名字]
			[3] = 'int32':headId	[头像]
			[4] = 'int32':headFrame	[头像框]
			[5] = 'int32':level	[等级]
			[6] = 'int32':fightPower	[战力]
			[7] = 'int32':round	[轮次]
			[8] = 'int32':prize	[奖次]
			[9] = 'int32':sid	[服务器组id,不同组之间pid可能有相同]
			[10] = 'string':channel	[渠道appid,不同组之间pid可能有相同]
		},
	}
--]]
s2c.YEAR_LOTTO_RESP_YEAR_LOTTO_NEW_PLAYER = 8706

--[[
	[1] = {--Pong
	}
--]]
s2c.LOGIN_PONG = 262

--[[
	[1] = {--ResValentineData
		[1] = {--repeated RoseData
			[1] = 'int32':optionId	[图鉴id]
			[2] = 'string':count	[花的数量]
		},
		[2] = 'string':totalCount	[总共收的花]
		[3] = 'repeated string':takeList	[领过的进度奖]
	}
--]]
s2c.ACTIVITY2_RES_VALENTINE_DATA = 9409

--[[
	[1] = {--RespGetHangUpInfo
		[1] = 'int32':activityId	[活动id]
		[2] = {--repeated HangUpRoleInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':roleId	[挂机精灵id]
			[3] = 'int32':level	[挂机精灵等级]
			[4] = 'int32':nextSettleTime	[挂机精灵的结算时间   0]
			[5] = 'int32':currentEventId	[挂机精灵现在的事件id]
			[6] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
		[3] = {--repeated HangUpEventInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':eventId	[事件id]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = 'repeated int32':roleIds	[挂机的精灵信息]
			[5] = 'int32':eventEndTime	[事件结束时间]
			[6] = 'bool':isSpecial
		},
		[4] = {--repeated SpecialEventAward
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[奖励的id]
			[3] = 'int32':triggerId	[特殊事件的id]
		},
	}
--]]
s2c.ACTIVITY_RESP_GET_HANG_UP_INFO = 5168

--[[
	[1] = {--ReplaceSpecialAttrMsg
		[1] = 'bool':success	[操作是否成功]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EQUIPMENT_REPLACE_SPECIAL_ATTR = 2821

--[[
	[1] = {--PhoneDatingAccept
		[1] = 'bool':accept	[预定约会返回接受还是拒绝]
	}
--]]
s2c.DATING_PHONE_DATING_ACCEPT = 1553

--[[
	[1] = {--PracticeLevelInfo
		[1] = 'int32':cid	[关卡cid]
		[2] = 'repeated int32':goals	[达成目标的下标]
		[3] = 'int32':fightCount	[战斗次数]
		[4] = 'bool':win	[是否胜利]
		[5] = 'int32':buyCount	[购买次数]
	}
--]]
s2c.HERO_PRACTICE_PRACTICE_LEVEL_INFO = 6402

--[[
	[1] = {--ResLimitlessSummon
		[1] = 'int32':activityId	[活动Id]
		[2] = 'int32':score	[积分]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[4] = 'repeated int32':summonedList	[已抽取过的卡池id]
	}
--]]
s2c.LIMITLESS_SUMMON_RES_LIMITLESS_SUMMON = 3502

--[[
	[1] = {--RespCancelHeroDispatch
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.HERO_DISPATCH_RESP_CANCEL_HERO_DISPATCH = 8603

--[[
	[1] = {--BuyLevelCountMsg
		[1] = {--LevelInfo
			[1] = 'int32':cid	[关卡cid]
			[2] = 'repeated int32':goals	[达成目标的下标]
			[3] = 'int32':fightCount	[战斗次数]
			[4] = 'bool':win	[是否胜利]
			[5] = 'int32':buyCount	[购买次数]
			[6] = 'int32':freeCount	[ 周卡或者是月卡的免费次数]
		},
	}
--]]
s2c.DUNGEON_BUY_LEVEL_COUNT = 1811

--[[
	[1] = {--RspTakeOffLadderEquipMsg
		[1] = {--repeated HeroInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int64':exp	[ 经验]
			[6] = {--repeated AttributeInfo
				[1] = 'int32':type	[ 属性类型]
				[2] = 'int32':val	[ 属性值]
			},
			[7] = 'int32':advancedLvl	[ 突破等级]
			[8] = {--repeated HeroEquipment
				[1] = 'int32':position	[装备位置]
				[2] = 'string':equipmentId	[装备id]
				[3] = {--EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
			},
			[9] = 'bool':helpFight	[ 助战]
			[10] = 'int32':angelLvl	[ 天使等级]
			[11] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[12] = 'int32':useSkillPiont	[ 已使用技能点]
			[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
			[14] = 'int32':provide	[出处]
			[15] = 'int32':fightPower	[ 战斗力]
			[16] = 'int32':skinCid	[ 皮肤cid]
			[17] = {--repeated SkillStrategy
				[1] = 'int32':id
				[2] = 'string':name
				[3] = 'int32':alreadyUseSkillPiont
				[4] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[5] = {--repeated PassiveSkillInfo
					[1] = 'int32':pos
					[2] = 'int32':skillId
				},
			},
			[18] = 'int32':useSkillStrategy
			[19] = {--repeated CrystalInfo
				[1] = 'int32':rarity
				[2] = 'int32':gridId
			},
			[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
			[21] = {--repeated EuqipFetterInfo
				[1] = 'int32':index
				[2] = {--NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
			},
			[22] = {--HeroStatus(enum)
				'v4':HeroStatus
			},
			[23] = 'int32':deadLine
			[24] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[25] = 'int32':skinCidTemp	[ 皮肤cid]
			[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
			[27] = 'int32':breakLv	[突破等级]
		},
	}
--]]
s2c.LADDER_RSP_TAKE_OFF_LADDER_EQUIP = 8306

--[[
	[1] = {--RespDoHandWork
		[1] = 'int32':manualId
		[2] = 'int32':endTime
		[3] = 'int32':times
	}
--]]
s2c.NEW_BUILDING_RESP_DO_HAND_WORK = 2081

--[[
	[1] = {--RespWriteBeCallPlayerId
		[1] = 'int32':successCode	[返回提示消息  0表示成功  其他去读string.csv里面的id]
	}
--]]
s2c.ACTIVITY_RESP_WRITE_BE_CALL_PLAYER_ID = 5178

--[[
	[1] = {--ExploreGetAward
		[1] = {--AfkActivity
			[1] = 'int32':id	[活动配置id]
			[2] = 'bool':first
			[3] = 'int32':localCity	[当前城市]
			[4] = 'int32':localNation	[当前国家]
			[5] = 'int64':startTime	[开始探索的时间]
			[6] = 'int32':cityAwardTimes	[当前城市获得奖励点次数,只是当前城市,用来计算城市进度]
			[7] = 'int32':speed	[当前的探索速度]
			[8] = 'int64':lastAwardPointTime	[到达最后一个奖励点位的时间]
			[9] = 'int32':capacity	[当前的探索总的容量]
			[10] = 'bool':isPush	[是否是服务器主动推送]
			[11] = 'int32':totalRewardCount	[总的奖励次数]
			[12] = {--AfkReward
				[1] = 'int64':awardTime	[获得奖励的时间]
				[2] = 'int32':activityId
				[3] = 'int32':nationId
				[4] = 'int32':cityId
				[5] = 'int32':dropId
				[6] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
			},
			[13] = {--repeated AfkNation
				[1] = 'int32':id	[国家配置]
				[2] = {--repeated AfkCity
					[1] = 'int32':id	[城市配置id]
					[2] = {--repeated AfkEvent
						[1] = 'int32':id
						[2] = 'int32':state
						[3] = 'int32':progress	[多层事件已经进行的进度]
					},
					[3] = 'repeated int32':completeEvent	[已经完成事件]
				},
			},
			[14] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[15] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EXPLORE_EXPLORE_GET_AWARD = 7821

--[[
	[1] = {--RespDoPartTimeJob
		[1] = {--JobInfo
			[1] = 'int32':buildingId	[建筑ID]
			[2] = 'int32':type	[白天还是黑夜]
			[3] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[4] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[5] = 'int32':jobId	[兼职ID]
			[6] = 'int32':jobType	[兼职任务状态]
			[7] = 'int32':etime	[兼职任务结束时间]
		},
	}
--]]
s2c.NEW_BUILDING_RESP_DO_PART_TIME_JOB = 2077

--[[
	[1] = {--RespGetBeCallInfo
		[1] = 'int32':activityId	[活动id]
		[2] = 'bool':isReturn	[是否是回归玩家]
		[3] = 'string':codeInfo	[验证码]
		[4] = 'int32':beCallNum	[召回的玩家数量]
		[5] = 'bool':isBind	[是否已经绑定]
		[6] = 'int32':taskSize	[被邀请人完成的任务进度]
	}
--]]
s2c.ACTIVITY_RESP_GET_BE_CALL_INFO = 5176

--[[
	[1] = {--RespPushNextStage
	}
--]]
s2c.ACTIVITY_RESP_PUSH_NEXT_STAGE = 5142

--[[
	[1] = {--ReqGuideInfo
		[1] = 'repeated int32':stepInfo	[所有步骤]
	}
--]]
s2c.EXPLORE_REQ_GUIDE_INFO = 7839

--[[
	[1] = {--ResEffectBuff
		[1] = {--repeated Buff
			[1] = 'int32':buffId
			[2] = 'int32':buffLv
		},
	}
--]]
s2c.HANGUP_ACT_RES_EFFECT_BUFF = 9010

--[[
	[1] = {--RspLadderNewEquip
		[1] = {--repeated HeroInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int64':exp	[ 经验]
			[6] = {--repeated AttributeInfo
				[1] = 'int32':type	[ 属性类型]
				[2] = 'int32':val	[ 属性值]
			},
			[7] = 'int32':advancedLvl	[ 突破等级]
			[8] = {--repeated HeroEquipment
				[1] = 'int32':position	[装备位置]
				[2] = 'string':equipmentId	[装备id]
				[3] = {--EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
			},
			[9] = 'bool':helpFight	[ 助战]
			[10] = 'int32':angelLvl	[ 天使等级]
			[11] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[12] = 'int32':useSkillPiont	[ 已使用技能点]
			[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
			[14] = 'int32':provide	[出处]
			[15] = 'int32':fightPower	[ 战斗力]
			[16] = 'int32':skinCid	[ 皮肤cid]
			[17] = {--repeated SkillStrategy
				[1] = 'int32':id
				[2] = 'string':name
				[3] = 'int32':alreadyUseSkillPiont
				[4] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[5] = {--repeated PassiveSkillInfo
					[1] = 'int32':pos
					[2] = 'int32':skillId
				},
			},
			[18] = 'int32':useSkillStrategy
			[19] = {--repeated CrystalInfo
				[1] = 'int32':rarity
				[2] = 'int32':gridId
			},
			[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
			[21] = {--repeated EuqipFetterInfo
				[1] = 'int32':index
				[2] = {--NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
			},
			[22] = {--HeroStatus(enum)
				'v4':HeroStatus
			},
			[23] = 'int32':deadLine
			[24] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[25] = 'int32':skinCidTemp	[ 皮肤cid]
			[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
			[27] = 'int32':breakLv	[突破等级]
		},
	}
--]]
s2c.LADDER_RSP_LADDER_NEW_EQUIP = 8307

--[[
	[1] = {--RespStartSpecialMakeFormula
		[1] = 'int32':formulaId	[配方id]
		[2] = 'int32':etime	[倒计时]
	}
--]]
s2c.ACTIVITY_RESP_START_SPECIAL_MAKE_FORMULA = 5221

--[[
	[1] = {--RespStatePush
		[1] = 'int32':pid
		[2] = 'int32':type
		[3] = 'string':state
	}
--]]
s2c.CHASM_RESP_STATE_PUSH = 6156

--[[
	[1] = {--OfficeRandomEventsMsg
		[1] = {--GridRandomEventsMsg
			[1] = {--repeated GridMapPoint
				[1] = 'int32':x	[ x位置]
				[2] = 'int32':y	[ y位置]
				[3] = 'int32':event	[ 事件id,大于0则有事件]
				[4] = 'bool':eventValid	[ 事件是否可用]
				[5] = 'bool':visual	[ 是否可视,即是否开启格子]
				[6] = {--repeated GridPointInfo
					[1] = 'int32':x	[ x位置]
					[2] = 'int32':y	[ y位置]
				},
			},
			[2] = 'int32':eventRefresh	[随机事件刷新时间点]
		},
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_RANDOM_EVENTS = 7223

--[[
	[1] = {--RespActivatePortrait
		[1] = 'int32':equipCid	[当前使用的头像id]
		[2] = 'bool':redMark	[是否有红点提示]
		[3] = 'repeated int32':activeCid	[激活的头像和头像框id列表]
		[4] = 'int32':equipFrameCid	[当前使用的头像框id]
		[5] = 'bool':frameRedMark	[框是否有红点提示]
		[6] = 'string':ext	[额外json串]
		[7] = 'int32':chatFrameCid	[当前使用的气泡框id]
		[8] = 'bool':chatRedMark	[框是否有红点提示]
	}
--]]
s2c.PORTRAIL_RESP_ACTIVATE_PORTRAIT = 7001

--[[
	[1] = {--RspGetARinfo
		[1] = {--repeated PicInfoMsg
			[1] = 'int32':index	[索引]
			[2] = 'int32':id	[配置ID]
			[3] = 'int32':zooming	[缩放大小]
			[4] = 'int32':rotate	[旋转度]
			[5] = 'string':text	[文本内容]
		},
		[2] = {--repeated UnlockActionMsg
			[1] = 'int32':roleId	[看板娘ID]
			[2] = 'repeated int32':actionId	[已解锁动作id]
		},
	}
--]]
s2c.ARRSP_GET_ARINFO = 9301

--[[
	[1] = {--RespSetMaidNessId
		[1] = 'int32':maidId	[看板id]
	}
--]]
s2c.ACTIVITY_RESP_SET_MAID_NESS_ID = 5219

--[[
	[1] = {--ResAnnivStart
	}
--]]
s2c.ANNIVERSARY2ND_RES_ANNIV_START = 9205

--[[
	[1] = {--ResRepairSubmit
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY2_RES_REPAIR_SUBMIT = 9404

--[[
	[1] = {--PracticeInfo
		[1] = 'int32':startTime	[开启时间点]
		[2] = 'int32':endTime	[关闭时间点]
		[3] = 'bool':status	[ 是否开启]
		[4] = 'bool':alwaysOpen	[ 是否常开]
		[5] = {--repeated PracticeLevelInfo
			[1] = 'int32':cid	[关卡cid]
			[2] = 'repeated int32':goals	[达成目标的下标]
			[3] = 'int32':fightCount	[战斗次数]
			[4] = 'bool':win	[是否胜利]
			[5] = 'int32':buyCount	[购买次数]
		},
	}
--]]
s2c.HERO_PRACTICE_PRACTICE_INFO = 6401

--[[
	[1] = {--RspSpiritUseItem
		[1] = {--HeroSpiritInfo
			[1] = 'int32':spiritPoints	[可用灵力点数]
			[2] = 'int32':grade	[品阶从0开始]
			[3] = 'int32':level	[级数从0开始]
			[4] = 'int64':exp	[经验值]
			[5] = {--repeated HeroSpiritProperty
				[1] = 'int32':cid	[cid]
				[2] = 'int32':num	[点数]
			},
			[6] = 'bool':firstShow	[首次开启展示true即为要显示false则不显示]
			[7] = 'bool':feedback	[旧灵力系统是否已返回资源]
			[8] = {--repeated HeroAngleSpirit
				[1] = 'int32':heroCid	[cid]
				[2] = 'int32':lv	[点数]
			},
			[9] = 'int32':maxLv	[可升级上限]
		},
	}
--]]
s2c.HERO_SPIRIT_RSP_SPIRIT_USE_ITEM = 8404

--[[
	[1] = {--UpdateLevelGroupInfo
		[1] = {--DungeonLevelGroupInfo
			[1] = 'string':id	[id]
			[2] = 'int32':cid	[cid]
			[3] = 'int32':fightCount	[战斗次数]
			[4] = 'int32':buyCount	[购买次数]
			[5] = {--repeated ListMap
				[1] = 'int32':key
				[2] = 'repeated int32':list
			},
			[6] = 'int32':mainLineCid	[当前关卡标记]
			[7] = 'int32':maxMainLine	[最大关卡进度]
		},
	}
--]]
s2c.DUNGEON_UPDATE_LEVEL_GROUP_INFO = 1803

--[[
	[1] = {--UseItemResult
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ITEM_USE_ITEM_RESULT = 514

--[[
	[1] = {--ResGetExploreAwardMsg
		[1] = {--Stronghold
			[1] = 'int32':id
			[2] = 'int32':state
			[3] = 'int64':startTime
			[4] = 'int64':endTime
			[5] = 'int32':useSupTimes
			[6] = 'int32':progress
			[7] = {--repeated Event
				[1] = 'int32':id
				[2] = 'int32':state
				[3] = 'int64':startTime
			},
			[8] = {--repeated Role
				[1] = 'int32':roleId
			},
			[9] = {--repeated Buff
				[1] = 'int32':buffId
				[2] = 'int32':buffLv
			},
			[10] = {--repeated SupportRole
				[1] = 'int64':playerId
				[2] = 'string':playerName
				[3] = 'int64':startTime
				[4] = 'int32':times
				[5] = {--Role
					[1] = 'int32':roleId
				},
				[6] = {--repeated Buff
					[1] = 'int32':buffId
					[2] = 'int32':buffLv
				},
			},
		},
		[2] = 'int32':completeStronghold	[完成的据点数量]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.HANGUP_ACT_RES_GET_EXPLORE_AWARD = 9009

--[[
	[1] = {--ResUseTrialCard
	}
--]]
s2c.ITEM_RES_USE_TRIAL_CARD = 517

--[[
	[1] = {--RspEndlessBuff
		[1] = {--repeated SingleLevelBuff
			[1] = 'int32':levelCid	[关卡id]
			[2] = 'repeated int32':buff	[buffid]
		},
	}
--]]
s2c.ENDLESS_CLOISTER_RSP_ENDLESS_BUFF = 5382

--[[
	[1] = {--RspActiveIndenture
		[1] = 'int32':indenture	[激活的契约阶段]
	}
--]]
s2c.INDENTURE_RSP_ACTIVE_INDENTURE = 8202

--[[
	[1] = {--NewPushActivitys
		[1] = {--repeated ActivityConfigMsg
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[活动ID]
			[3] = 'int32':activityType	[活动类型]
			[4] = 'string':activityTitle	[活动标题]
			[5] = 'int32':startTime	[开始时间]
			[6] = 'int32':endTime	[结束时间]
			[7] = 'int32':showStartTime	[显示开始时间]
			[8] = 'int32':showEndTime	[显示结束时间]
			[9] = 'string':remark	[备注信息Json]
			[10] = 'string':extendData	[扩展数据]
			[11] = 'int32':rank	[排序]
			[12] = 'string':showIcon	[广告图]
			[13] = 'repeated int32':items	[活动条目]
			[14] = 'string':titleIcon	[活动标题Icon]
		},
	}
--]]
s2c.ACTIVITY_NEW_PUSH_ACTIVITYS = 5126

--[[
	[1] = {--RespAITrainingSubmit
		[1] = 'int32':approvalNum	[等待审核的条目数]
	}
--]]
s2c.DATING_RESP_AITRAINING_SUBMIT = 1566

--[[
	[1] = {--RespClickAdActivity
	}
--]]
s2c.ACTIVITY_RESP_CLICK_AD_ACTIVITY = 5187

--[[
	[1] = {--RespTargetPlayerInfo
		[1] = {--PlayerInfo
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':name	[ 玩家名称]
			[3] = 'int32':lvl	[ 玩家等级]
			[4] = 'int64':exp	[ 玩家经验]
			[5] = 'int32':vip_lvl	[ VIP等级]
			[6] = 'int64':vip_exp	[ VIP经验]
			[7] = {--Language(enum)
				'v4':Language
			},
			[8] = 'string':remark	[ 宣言]
			[9] = 'int32':helpFightHeroCid	[ 助战英雄ID]
			[10] = {--repeated PlayerAttr
				[1] = {--PlayerAttrKey(enum)
					'v4':PlayerAttrKey
				},
				[2] = 'int32':attrVal	[ 属性值]
			},
			[11] = 'bool':isFirstLogin	[是否初次登录]
			[12] = 'string':clientDiscreteData	[客户端离散数据]
			[13] = 'string':settings	[ 设置信息]
			[14] = 'repeated int32':recoverTimeList	[体力精力回复时间]
			[15] = 'int32':portraitCid	[ 玩家头像CID]
			[16] = 'int32':portraitFrameCid	[ 玩家头像框CID]
			[17] = {--GetAllElement
				[1] = {--repeated Elements
					[1] = 'int32':type	[类型]
					[2] = {--repeated Element
						[1] = 'int32':cid	[cid]
						[2] = 'int32':reward	[领奖状态 0不可领取  1可领取 2 已领取]
					},
					[3] = 'int32':trophy	[奖杯数]
					[4] = 'bool':scan	[是否可以浏览]
				},
				[2] = 'int32':rank	[排名]
				[3] = 'int32':totleTrophy	[总奖杯数]
			},
			[18] = 'int32':unionId	[ 玩家社团Id]
			[19] = 'string':unionName	[ 玩家社团名]
			[20] = 'int32':titleId	[ 称号id]
			[21] = 'int32':createTime	[ 建号时间]
			[22] = 'int32':famousExp	[ 名师经验]
		},
		[2] = {--FormationInfoList
			[1] = {--repeated FormationInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'int32':type	[ 阵型类型]
				[3] = 'int32':status	[ 阵型状态 0 未启用 1 启用]
				[4] = 'repeated string':stance	[ 阵型英雄]
			},
		},
		[3] = {--repeated HeroInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int64':exp	[ 经验]
			[6] = {--repeated AttributeInfo
				[1] = 'int32':type	[ 属性类型]
				[2] = 'int32':val	[ 属性值]
			},
			[7] = 'int32':advancedLvl	[ 突破等级]
			[8] = {--repeated HeroEquipment
				[1] = 'int32':position	[装备位置]
				[2] = 'string':equipmentId	[装备id]
				[3] = {--EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
			},
			[9] = 'bool':helpFight	[ 助战]
			[10] = 'int32':angelLvl	[ 天使等级]
			[11] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[12] = 'int32':useSkillPiont	[ 已使用技能点]
			[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
			[14] = 'int32':provide	[出处]
			[15] = 'int32':fightPower	[ 战斗力]
			[16] = 'int32':skinCid	[ 皮肤cid]
			[17] = {--repeated SkillStrategy
				[1] = 'int32':id
				[2] = 'string':name
				[3] = 'int32':alreadyUseSkillPiont
				[4] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[5] = {--repeated PassiveSkillInfo
					[1] = 'int32':pos
					[2] = 'int32':skillId
				},
			},
			[18] = 'int32':useSkillStrategy
			[19] = {--repeated CrystalInfo
				[1] = 'int32':rarity
				[2] = 'int32':gridId
			},
			[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
			[21] = {--repeated EuqipFetterInfo
				[1] = 'int32':index
				[2] = {--NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
			},
			[22] = {--HeroStatus(enum)
				'v4':HeroStatus
			},
			[23] = 'int32':deadLine
			[24] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[25] = 'int32':skinCidTemp	[ 皮肤cid]
			[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
			[27] = 'int32':breakLv	[突破等级]
		},
		[4] = {--repeated EquipmentInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[灵装id]
			[3] = 'int32':cid	[灵装cid]
			[4] = 'int32':level	[灵装等级]
			[5] = 'int32':exp	[灵装经验值]
			[6] = 'string':heroId	[英雄id]
			[7] = 'int32':position	[装备位置]
			[8] = {--repeated SpecialAttr
				[1] = 'int32':cid	[配置id]
				[2] = 'int32':value	[属性值]
				[3] = 'int32':index	[属性服务器顺序]
			},
			[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
			[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
			[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
			[12] = 'int32':outTime	[过期时间]
			[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
			[14] = 'int32':star	[额外星数]
			[15] = 'int32':stage	[阶段]
			[16] = 'int32':num	[数量]
			[17] = 'int32':step	[质点阶级]
		},
		[5] = {--repeated MedalInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':cid
			[3] = 'int32':star	[星级]
			[4] = 'int32':quality	[ 品质]
			[5] = 'int32':effectTime	[过期时间]
			[6] = 'bool':isEquip	[是否已装备]
			[7] = 'int32':createTime	[得到时间]
		},
		[6] = {--repeated Switch
			[1] = 'int32':type	[1 : 好友交易开关]
			[2] = 'int32':value
		},
	}
--]]
s2c.PLAYER_RESP_TARGET_PLAYER_INFO = 271

--[[
	[1] = {--RespHuntingWeaknessInfo
		[1] = {--HuntingPlayerWeakness
			[1] = {--repeated HuntingWeakness
				[1] = 'int32':dungeon	[副本id]
				[2] = 'int32':count	[通关次数]
			},
			[2] = 'int32':leftCount	[个人剩余次数]
		},
	}
--]]
s2c.HUNTING_DUNGEON_RESP_HUNTING_WEAKNESS_INFO = 8509

--[[
	[1] = {--RespHuntingStepInfo
		[1] = {--HuntingStep
			[1] = 'int32':step	[当前阶段,0 功能未开放, 1 准备期开放, 2 准备期结算, 3 准备期结束, 11 正式挑战开放, 12 正式挑战结算, 13 正式挑战结束]
			[2] = 'int32':nextTime	[下阶段开始时间点]
		},
	}
--]]
s2c.HUNTING_DUNGEON_RESP_HUNTING_STEP_INFO = 8507

--[[
	[1] = {--CityDatingInfoList
		[1] = {--repeated CityDatingInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':cityDatingId	[城市约会id]
			[3] = 'repeated int32':datingTimeFrame	[约会时段]
			[4] = 'int32':datingRuleCid	[约会cid]
			[5] = 'int32':date	[约会日期]
			[6] = 'int32':state	[预定约会状态 0:无约会 1:有邀请,未接受 2:已接受邀请 3:正常约会时间 4:约会时间已过]
			[7] = 'bool':inDating	[ 是否在剧情中 true   false]
		},
	}
--]]
s2c.DATING_CITY_DATING_INFO_LIST = 1548

--[[
	[1] = {--RespHuntingRank
		[1] = {--repeated HuntingDamage
			[1] = 'int32':unionId	[社团id]
			[2] = 'int32':unionLv	[社团等级]
			[3] = 'string':unionName	[社团名]
			[4] = 'int32':bossLv	[boss等级]
			[5] = 'int32':dmgRate	[伤害万分比]
			[6] = 'int32':rank	[名次]
			[7] = 'int32':icon	[icon]
		},
		[2] = {--HuntingDamage
			[1] = 'int32':unionId	[社团id]
			[2] = 'int32':unionLv	[社团等级]
			[3] = 'string':unionName	[社团名]
			[4] = 'int32':bossLv	[boss等级]
			[5] = 'int32':dmgRate	[伤害万分比]
			[6] = 'int32':rank	[名次]
			[7] = 'int32':icon	[icon]
		},
		[3] = {--repeated HuntingHonor
			[1] = 'int32':playerId	[玩家id]
			[2] = 'string':playerName	[玩家id]
			[3] = 'int32':playerLv	[玩家等级]
			[4] = 'int32':honor	[荣耀值]
			[5] = 'int32':fightCount	[挑战次数]
			[6] = 'int32':rank	[名次]
			[7] = 'int32':headId	[头像]
			[8] = 'int32':dmgRate	[伤害占比,万分比]
		},
		[4] = {--HuntingHonor
			[1] = 'int32':playerId	[玩家id]
			[2] = 'string':playerName	[玩家id]
			[3] = 'int32':playerLv	[玩家等级]
			[4] = 'int32':honor	[荣耀值]
			[5] = 'int32':fightCount	[挑战次数]
			[6] = 'int32':rank	[名次]
			[7] = 'int32':headId	[头像]
			[8] = 'int32':dmgRate	[伤害占比,万分比]
		},
	}
--]]
s2c.HUNTING_DUNGEON_RESP_HUNTING_RANK = 8502

--[[
	[1] = {--ResExchangeApply
		[1] = 'int32':friendId	[好友id]
		[2] = 'string':friendName	[好友名字]
		[3] = 'int64':timeout	[过期时间点]
		[4] = 'int32':operType	[操作类型 1 请求 2 取消]
	}
--]]
s2c.ACTIVITY_RES_EXCHANGE_APPLY = 5193

--[[
	[1] = {--ResSpeedPartTimeJob
		[1] = 'int32':freeSpeedNum	[免费 当日已加速次数 月卡特权]
		[2] = 'int32':speedNum	[当日已加速次数]
		[3] = 'int32':etime	[兼职任务结束时间]
	}
--]]
s2c.NEW_BUILDING_RES_SPEED_PART_TIME_JOB = 2075

--[[
	[1] = {--RespActivityPrayTask
	}
--]]
s2c.ACTIVITY_RESP_ACTIVITY_PRAY_TASK = 5180

--[[
	[1] = {--RespSettleExperiment
		[1] = 'int32':id	[配置表id]
		[2] = 'int32':score	[关卡对应的本次积分]
		[3] = 'int32':history	[关卡对应的历史积分]
	}
--]]
s2c.DUNGEON_RESP_SETTLE_EXPERIMENT = 1818

--[[
	[1] = {--NewEnvelopeNotice
		[1] = {--MailInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 邮件ID]
			[3] = 'int32':senderId	[ 发送者id]
			[4] = 'string':senderName	[ 发送者名字]
			[5] = 'int32':createTime	[ 创建时间]
			[6] = 'int32':modifiedTime	[ 邮件时间]
			[7] = 'int32':status	[ 状态]
			[8] = 'string':title	[ 邮件标题]
			[9] = 'string':body	[ 邮件正文]
			[10] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[11] = 'int32':mailType	[1是普通邮件,3是特殊邮件]
		},
	}
--]]
s2c.RED_ENVELOPE_NEW_ENVELOPE_NOTICE = 7302

--[[
	[1] = {--RsepChasmStartFight
		[1] = 'string':fightId	[ 战斗ID]
		[2] = 'string':fightServerHost	[ 战斗服务器地址]
		[3] = 'int32':fightServerPort	[ 战斗服务器端口]
		[4] = {--repeated FightPlayer
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':pname	[ 玩家昵称]
			[3] = {--repeated HeroInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[ 实例ID]
				[3] = 'int32':cid	[ 配置ID]
				[4] = 'int32':lvl	[ 等级]
				[5] = 'int64':exp	[ 经验]
				[6] = {--repeated AttributeInfo
					[1] = 'int32':type	[ 属性类型]
					[2] = 'int32':val	[ 属性值]
				},
				[7] = 'int32':advancedLvl	[ 突破等级]
				[8] = {--repeated HeroEquipment
					[1] = 'int32':position	[装备位置]
					[2] = 'string':equipmentId	[装备id]
					[3] = {--EquipmentInfo
						[1] = {--ChangeType(enum)
							'v4':ChangeType
						},
						[2] = 'string':id	[灵装id]
						[3] = 'int32':cid	[灵装cid]
						[4] = 'int32':level	[灵装等级]
						[5] = 'int32':exp	[灵装经验值]
						[6] = 'string':heroId	[英雄id]
						[7] = 'int32':position	[装备位置]
						[8] = {--repeated SpecialAttr
							[1] = 'int32':cid	[配置id]
							[2] = 'int32':value	[属性值]
							[3] = 'int32':index	[属性服务器顺序]
						},
						[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
						[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
						[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
						[12] = 'int32':outTime	[过期时间]
						[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
						[14] = 'int32':star	[额外星数]
						[15] = 'int32':stage	[阶段]
						[16] = 'int32':num	[数量]
						[17] = 'int32':step	[质点阶级]
					},
				},
				[9] = 'bool':helpFight	[ 助战]
				[10] = 'int32':angelLvl	[ 天使等级]
				[11] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[12] = 'int32':useSkillPiont	[ 已使用技能点]
				[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
				[14] = 'int32':provide	[出处]
				[15] = 'int32':fightPower	[ 战斗力]
				[16] = 'int32':skinCid	[ 皮肤cid]
				[17] = {--repeated SkillStrategy
					[1] = 'int32':id
					[2] = 'string':name
					[3] = 'int32':alreadyUseSkillPiont
					[4] = {--repeated AngeSkillInfo
						[1] = 'int32':type
						[2] = 'int32':pos
						[3] = 'int32':lvl
					},
					[5] = {--repeated PassiveSkillInfo
						[1] = 'int32':pos
						[2] = 'int32':skillId
					},
				},
				[18] = 'int32':useSkillStrategy
				[19] = {--repeated CrystalInfo
					[1] = 'int32':rarity
					[2] = 'int32':gridId
				},
				[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
				[21] = {--repeated EuqipFetterInfo
					[1] = 'int32':index
					[2] = {--NewEquipmentInfo
						[1] = {--ChangeType(enum)
							'v4':ChangeType
						},
						[2] = 'string':id	[新装备id]
						[3] = 'int32':cid	[新装备cid]
						[4] = 'int32':stage	[新装备阶段等级]
						[5] = 'int32':level	[新装备等级]
						[6] = 'string':heroId	[英雄id]
						[7] = 'int32':position	[装备位置]
					},
				},
				[22] = {--HeroStatus(enum)
					'v4':HeroStatus
				},
				[23] = 'int32':deadLine
				[24] = {--repeated GemInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[宝石id]
					[3] = 'int32':cid	[宝石cid]
					[4] = 'int32':heroId	[英雄id]
					[5] = 'repeated int32':randSkill	[随机技能]
					[6] = {--GemRandSkill
						[1] = 'int32':originalSkill	[ 原始id]
						[2] = 'int32':newSkill	[ 新id]
					},
				},
				[25] = 'int32':skinCidTemp	[ 皮肤cid]
				[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
				[27] = 'int32':breakLv	[突破等级]
			},
			[4] = 'int32':reviveCount	[ 复活次数]
			[5] = 'int32':portraitCid	[ 玩家头像ID]
			[6] = 'int32':titleId	[ 玩家称号ID]
			[7] = 'string':unionName	[ 公会名字]
			[8] = 'int32':portraitFrameId	[ 头像框]
			[9] = {--repeated ManaBagInfo
				[1] = 'int32':id
				[2] = 'int32':level
			},
		},
		[5] = 'int32':randomSeed	[随机种子]
		[6] = 'int32':dungeonCid	[副本ID]
		[7] = 'int32':netType	[ 通信方式 1 kcp 2 tcp]
		[8] = {--repeated NewWorldandomDungeon
			[1] = 'int32':dungeonId	[ 关卡id]
			[2] = 'int32':index	[ 所在格子索引]
			[3] = 'int32':branchDungeonId	[ 支线关卡id]
			[4] = 'int32':branchIndex	[支线格子索引]
		},
		[9] = 'int32':teamType	[ 队伍类型 1组队,2春季特训,3大世界,4招募令,5追猎计划]
		[10] = 'repeated int32':actBuffId	[ 开启活动给副本添加的buff]
		[11] = {--repeated ItemBuff
			[1] = 'int32':pid
			[2] = 'repeated int32':buffId
		},
	}
--]]
s2c.CHASM_RSEP_CHASM_START_FIGHT = 6145

--[[
	[1] = {--ResFreshRoleNotice
	}
--]]
s2c.EXTRA_DATING_RES_FRESH_ROLE_NOTICE = 5661

--[[
	[1] = {--RespSpringSacrifice
		[1] = {--CellInfo
			[1] = 'int32':totleStep	[步数]
			[2] = 'int32':location	[位置]
			[3] = 'repeated int32':buffIds	[buff]
			[4] = 'repeated int32':cellIds	[格子id]
			[5] = {--CellEvent
				[1] = 'int32':eventId	[事件id]
				[2] = 'bool':status	[事件是否完成(0未完成 1完成)    //事件是否完成(0未完成 1完成)]
			},
			[6] = {--RecordBuffList
				[1] = 'repeated int32':buffId	[buffId]
			},
		},
		[2] = {--TurnInfo
			[1] = 'int32':extraTimes	[ n次必中某道具]
			[2] = 'int32':turnIndex	[上次转盘的位置]
			[3] = {--repeated TurnTimes
				[1] = 'int32':turnId	[ 轮盘道具ID]
				[2] = 'int32':times	[道具的次数]
			},
			[4] = {--repeated TurnEffectInfo
				[1] = 'int32':cfgId	[配置id]
				[2] = 'int32':effectId	[1双倍 2 再转一次]
			},
		},
	}
--]]
s2c.SACRIFICE_RESP_SPRING_SACRIFICE = 8000

--[[
	[1] = {--ResManaEquip
		[1] = {--ManaEquipInfo
			[1] = 'int32':id
			[2] = 'int32':pos
		},
	}
--]]
s2c.MANA_RESONANCE_RES_MANA_EQUIP = 7602

--[[
	[1] = {--RespRefreshDailyTask
		[1] = 'int32':count	[刷新日常刷新次数]
	}
--]]
s2c.ACTIVITY_RESP_REFRESH_DAILY_TASK = 5220

--[[
	[1] = {--RespBindInviteCode
		[1] = 'string':inviteCode	[ 邀请码]
	}
--]]
s2c.FRIEND_RESP_BIND_INVITE_CODE = 3079

--[[
	[1] = {--RespVoteActivity
		[1] = 'int32':addNum	[客户端增加的票数]
		[2] = 'int32':itemId	[条目]
		[3] = 'int32':activityId	[活动id]
		[4] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.ACTIVITY_RESP_VOTE_ACTIVITY = 5189

--[[
	[1] = {--ChangeNationOrCity
		[1] = 'int32':type	[0 切换城市 , 1 切换国家]
		[2] = 'int32':nationId	[国家id]
		[3] = 'int32':cityId	[城市id]
		[4] = {--AfkActivity
			[1] = 'int32':id	[活动配置id]
			[2] = 'bool':first
			[3] = 'int32':localCity	[当前城市]
			[4] = 'int32':localNation	[当前国家]
			[5] = 'int64':startTime	[开始探索的时间]
			[6] = 'int32':cityAwardTimes	[当前城市获得奖励点次数,只是当前城市,用来计算城市进度]
			[7] = 'int32':speed	[当前的探索速度]
			[8] = 'int64':lastAwardPointTime	[到达最后一个奖励点位的时间]
			[9] = 'int32':capacity	[当前的探索总的容量]
			[10] = 'bool':isPush	[是否是服务器主动推送]
			[11] = 'int32':totalRewardCount	[总的奖励次数]
			[12] = {--AfkReward
				[1] = 'int64':awardTime	[获得奖励的时间]
				[2] = 'int32':activityId
				[3] = 'int32':nationId
				[4] = 'int32':cityId
				[5] = 'int32':dropId
				[6] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
			},
			[13] = {--repeated AfkNation
				[1] = 'int32':id	[国家配置]
				[2] = {--repeated AfkCity
					[1] = 'int32':id	[城市配置id]
					[2] = {--repeated AfkEvent
						[1] = 'int32':id
						[2] = 'int32':state
						[3] = 'int32':progress	[多层事件已经进行的进度]
					},
					[3] = 'repeated int32':completeEvent	[已经完成事件]
				},
			},
			[14] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[15] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
		[5] = 'int32':activityId	[id]
	}
--]]
s2c.EXPLORE_CHANGE_NATION_OR_CITY = 7829

--[[
	[1] = {--ResTaskReward
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.APPRENTICE_RES_TASK_REWARD = 7908

--[[
	[1] = {--ResRefreshAnnivDress
	}
--]]
s2c.ANNIVERSARY2ND_RES_REFRESH_ANNIV_DRESS = 9207

--[[
	[1] = {--RespKurumiHistoryRank
		[1] = {--repeated KurumiHistoryCampRank
			[1] = 'int32':camp	[阵营id]
			[2] = 'int32':score	[阵营得分]
			[3] = {--repeated KurumiHistoryPlayerRank
				[1] = 'int32':pid	[玩家id]
				[2] = 'string':pName	[玩家名字]
				[3] = 'int32':bestTime	[最佳时间]
				[4] = 'int32':headFrame	[头像框]
				[5] = 'int32':rank	[排名,0则为未上榜]
				[6] = 'int32':headId	[头像]
				[7] = 'int32':level	[等级]
			},
			[4] = {--KurumiHistoryPlayerRank
				[1] = 'int32':pid	[玩家id]
				[2] = 'string':pName	[玩家名字]
				[3] = 'int32':bestTime	[最佳时间]
				[4] = 'int32':headFrame	[头像框]
				[5] = 'int32':rank	[排名,0则为未上榜]
				[6] = 'int32':headId	[头像]
				[7] = 'int32':level	[等级]
			},
		},
	}
--]]
s2c.ACTIVITY_RESP_KURUMI_HISTORY_RANK = 5164

--[[
	[1] = {--ChristmasBoxRefresh
		[1] = {--repeated ChristmasMapBoxes
			[1] = 'int32':location	[位置信息]
			[2] = 'int32':eventCid	[事件信息]
		},
	}
--]]
s2c.CHRISTMAS_CHRISTMAS_BOX_REFRESH = 6611

--[[
	[1] = {--RspOldSpiritFeedback
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.HERO_SPIRIT_RSP_OLD_SPIRIT_FEEDBACK = 8408

--[[
	[1] = {--ResArrestNianBeast
		[1] = 'int32':type
		[2] = 'int32':param
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.SPRING_FESTIVAL_RES_ARREST_NIAN_BEAST = 6704

--[[
	[1] = {--RspManRefreshYouci
		[1] = 'int32':rewardId	[本轮奖池ID (客户端需要自己清空	repeated int32 posRewarded = 5; //已领取了奖励的位置)    //本轮奖池ID (客户端需要自己清空	repeated int32 posRewarded = 5; //已领取了奖励的位置)]
	}
--]]
s2c.YOUCI_RSP_MAN_REFRESH_YOUCI = 9353

--[[
	[1] = {--RespGetFriendInviteInfo
		[1] = 'bool':open	[ 功能是否开启]
		[2] = 'bool':showInviteCode	[ 是否显示邀请码(达到指定等级后显示自己的邀请码)    // 是否显示邀请码(达到指定等级后显示自己的邀请码)]
		[3] = 'int32':limitLev	[邀请码限制等级]
		[4] = 'string':selfInviteCode	[自己的邀请码]
		[5] = 'string':bindInviteCode	[已绑定的别人的邀请码]
		[6] = 'int32':maxBindNum	[邀请码最大可绑定数量]
		[7] = {--repeated InviteRewardInfo
			[1] = 'int32':cid	[ 奖励模板ID]
			[2] = 'int32':status	[ 领取状态(0-不可领取 1-可领取 2-已领取)    // 领取状态(0-不可领取 1-可领取 2-已领取)]
		},
		[8] = 'int32':bindNum	[自己的邀请码已被绑定的次数]
	}
--]]
s2c.FRIEND_RESP_GET_FRIEND_INVITE_INFO = 3078

--[[
	[1] = {--HeroInfo
		[1] = {--ChangeType(enum)
			'v4':ChangeType
		},
		[2] = 'string':id	[ 实例ID]
		[3] = 'int32':cid	[ 配置ID]
		[4] = 'int32':lvl	[ 等级]
		[5] = 'int64':exp	[ 经验]
		[6] = {--repeated AttributeInfo
			[1] = 'int32':type	[ 属性类型]
			[2] = 'int32':val	[ 属性值]
		},
		[7] = 'int32':advancedLvl	[ 突破等级]
		[8] = {--repeated HeroEquipment
			[1] = 'int32':position	[装备位置]
			[2] = 'string':equipmentId	[装备id]
			[3] = {--EquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[灵装id]
				[3] = 'int32':cid	[灵装cid]
				[4] = 'int32':level	[灵装等级]
				[5] = 'int32':exp	[灵装经验值]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
				[8] = {--repeated SpecialAttr
					[1] = 'int32':cid	[配置id]
					[2] = 'int32':value	[属性值]
					[3] = 'int32':index	[属性服务器顺序]
				},
				[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
				[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
				[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
				[12] = 'int32':outTime	[过期时间]
				[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
				[14] = 'int32':star	[额外星数]
				[15] = 'int32':stage	[阶段]
				[16] = 'int32':num	[数量]
				[17] = 'int32':step	[质点阶级]
			},
		},
		[9] = 'bool':helpFight	[ 助战]
		[10] = 'int32':angelLvl	[ 天使等级]
		[11] = {--repeated AngeSkillInfo
			[1] = 'int32':type
			[2] = 'int32':pos
			[3] = 'int32':lvl
		},
		[12] = 'int32':useSkillPiont	[ 已使用技能点]
		[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
		[14] = 'int32':provide	[出处]
		[15] = 'int32':fightPower	[ 战斗力]
		[16] = 'int32':skinCid	[ 皮肤cid]
		[17] = {--repeated SkillStrategy
			[1] = 'int32':id
			[2] = 'string':name
			[3] = 'int32':alreadyUseSkillPiont
			[4] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[5] = {--repeated PassiveSkillInfo
				[1] = 'int32':pos
				[2] = 'int32':skillId
			},
		},
		[18] = 'int32':useSkillStrategy
		[19] = {--repeated CrystalInfo
			[1] = 'int32':rarity
			[2] = 'int32':gridId
		},
		[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
		[21] = {--repeated EuqipFetterInfo
			[1] = 'int32':index
			[2] = {--NewEquipmentInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[新装备id]
				[3] = 'int32':cid	[新装备cid]
				[4] = 'int32':stage	[新装备阶段等级]
				[5] = 'int32':level	[新装备等级]
				[6] = 'string':heroId	[英雄id]
				[7] = 'int32':position	[装备位置]
			},
		},
		[22] = {--HeroStatus(enum)
			'v4':HeroStatus
		},
		[23] = 'int32':deadLine
		[24] = {--repeated GemInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[宝石id]
			[3] = 'int32':cid	[宝石cid]
			[4] = 'int32':heroId	[英雄id]
			[5] = 'repeated int32':randSkill	[随机技能]
			[6] = {--GemRandSkill
				[1] = 'int32':originalSkill	[ 原始id]
				[2] = 'int32':newSkill	[ 新id]
			},
		},
		[25] = 'int32':skinCidTemp	[ 皮肤cid]
		[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
		[27] = 'int32':breakLv	[突破等级]
	}
--]]
s2c.HERO_HERO_INFO = 1026

--[[
	[1] = {--ResSpecialTrain
		[1] = 'bool':isOpen	[ 活动是否开始]
		[2] = 'int32':deadline	[ 截止时间]
		[3] = {--repeated TrainChapterInfo
			[1] = 'int32':id
			[2] = 'bool':isOpen
			[3] = 'int32':startTime
			[4] = 'int32':endTime
		},
	}
--]]
s2c.CHASM_RES_SPECIAL_TRAIN = 6151

--[[
	[1] = {--RspShowNewSpirit
	}
--]]
s2c.HERO_SPIRIT_RSP_SHOW_NEW_SPIRIT = 8406

--[[
	[1] = {--SummonValue
		[1] = 'int32':summonNums	[召唤次数]
		[2] = 'repeated int32':getRewards	[已领取奖励]
		[3] = 'int32':count	[领奖循环轮数]
		[4] = 'int32':summonType	[ 召唤类型]
		[5] = {--repeated AwardShow
			[1] = 'int32':itemId	[ 道具]
			[2] = 'int32':itemNums	[ 道具数量]
		},
		[6] = 'int32':remainScore	[剩余积分]
		[7] = 'repeated int32':cidList	[主列表]
	}
--]]
s2c.SUMMON_SUMMON_VALUE = 3337

--[[
	[1] = {--RespTimeLinkageInfo
		[1] = {--repeated TimeLinkageInfo
			[1] = 'int32':chapterCid	[章节id]
			[2] = 'int32':begin	[开始时间]
			[3] = 'int32':end	[结束时间]
		},
		[2] = 'repeated int32':CGCids	[ 联动开场动画标识,客户端用]
	}
--]]
s2c.DUNGEON_RESP_TIME_LINKAGE_INFO = 1815

--[[
	[1] = {--ResActiveCrystal
		[1] = 'string':heroId
		[2] = 'int32':rarity
		[3] = 'int32':gridId
	}
--]]
s2c.HERO_RES_ACTIVE_CRYSTAL = 1042

--[[
	[1] = {--RespAttrChange
		[1] = 'int32':heroId	[英雄id]
		[2] = 'int32':level	[当前等级]
		[3] = 'int32':lastLv	[上一个等级]
		[4] = {--AttributeLinkAge
			[1] = 'int32':attributeId
			[2] = 'int32':value
		},
	}
--]]
s2c.DUNGEON_RESP_ATTR_CHANGE = 1828

--[[
	[1] = {--QuickExplorationMsg
		[1] = 'int32':activityId	[ 活动id]
		[2] = 'int32':useTime	[当前快速次数]
		[3] = 'int32':nationId
		[4] = 'int32':cityId
		[5] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EXPLORE_QUICK_EXPLORATION = 7834

--[[
	[1] = {--ResGetSupportAwardMsg
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.HANGUP_ACT_RES_GET_SUPPORT_AWARD = 9008

--[[
	[1] = {--pushChat
		[1] = 'int32':roleId	[精灵id]
		[2] = 'repeated string':returnMsg	[黑桃返回的消息]
		[3] = 'int32':state	[ 喜怒哀乐]
		[4] = 'int32':type	[ 手机约会类型   自由聊天type=1  视频聊天 type=2]
		[5] = 'int32':sealState	[精灵封印状态  0:未封印 1:封印]
	}
--]]
s2c.DATINGPUSH_CHAT = 1556

--[[
	[1] = {--RespActivityNotice
		[1] = 'string':name
		[2] = 'int32':contribution
	}
--]]
s2c.ACTIVITY_RESP_ACTIVITY_NOTICE = 5139

--[[
	[1] = {--RespChangeVoteInfo
		[1] = 'int32':itemId	[条目id]
	}
--]]
s2c.ACTIVITY_RESP_CHANGE_VOTE_INFO = 5191

--[[
	[1] = {--ResAppreciate
		[1] = 'int32':pid	[ 谁点的赞]
		[2] = 'string':name	[名字]
	}
--]]
s2c.TEAM_RES_APPRECIATE = 5899

--[[
	[1] = {--ParticleWorldEventMsg
		[1] = 'int32':eventId	[事件id]
		[2] = 'int32':x	[ x位置]
		[3] = 'int32':y	[ y位置]
	}
--]]
s2c.QLIPHOTH_PARTICLE_WORLD_EVENT = 6203

--[[
	[1] = {--RespUpdateSupportAddress
		[1] = 'string':address	[邮寄地址]
	}
--]]
s2c.ACTIVITY_RESP_UPDATE_SUPPORT_ADDRESS = 5154

--[[
	[1] = {--RspStartFightEndless
		[1] = 'int32':levelCid	[起始关卡id]
		[2] = 'repeated int32':buff	[当前关卡服务器限定buff,可能为空]
	}
--]]
s2c.ENDLESS_CLOISTER_RSP_START_FIGHT_ENDLESS = 5378

--[[
	[1] = {--HeroAdvanceResult
		[1] = {--HeroInfo
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'string':id	[ 实例ID]
			[3] = 'int32':cid	[ 配置ID]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int64':exp	[ 经验]
			[6] = {--repeated AttributeInfo
				[1] = 'int32':type	[ 属性类型]
				[2] = 'int32':val	[ 属性值]
			},
			[7] = 'int32':advancedLvl	[ 突破等级]
			[8] = {--repeated HeroEquipment
				[1] = 'int32':position	[装备位置]
				[2] = 'string':equipmentId	[装备id]
				[3] = {--EquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[灵装id]
					[3] = 'int32':cid	[灵装cid]
					[4] = 'int32':level	[灵装等级]
					[5] = 'int32':exp	[灵装经验值]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
					[8] = {--repeated SpecialAttr
						[1] = 'int32':cid	[配置id]
						[2] = 'int32':value	[属性值]
						[3] = 'int32':index	[属性服务器顺序]
					},
					[9] = 'int32':oldAttrIndex	[临时特殊属性:属性位置]
					[10] = 'int32':newAttrType	[临时特殊属性:新属性类型]
					[11] = 'int32':newAttrValue	[临时特殊属性:新属性值]
					[12] = 'int32':outTime	[过期时间]
					[13] = 'bool':isLock	[是否已经锁定,false:否,ture:是]
					[14] = 'int32':star	[额外星数]
					[15] = 'int32':stage	[阶段]
					[16] = 'int32':num	[数量]
					[17] = 'int32':step	[质点阶级]
				},
			},
			[9] = 'bool':helpFight	[ 助战]
			[10] = 'int32':angelLvl	[ 天使等级]
			[11] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[12] = 'int32':useSkillPiont	[ 已使用技能点]
			[13] = 'int32':quality	[ 品质(进阶等级)    // 品质(进阶等级)]
			[14] = 'int32':provide	[出处]
			[15] = 'int32':fightPower	[ 战斗力]
			[16] = 'int32':skinCid	[ 皮肤cid]
			[17] = {--repeated SkillStrategy
				[1] = 'int32':id
				[2] = 'string':name
				[3] = 'int32':alreadyUseSkillPiont
				[4] = {--repeated AngeSkillInfo
					[1] = 'int32':type
					[2] = 'int32':pos
					[3] = 'int32':lvl
				},
				[5] = {--repeated PassiveSkillInfo
					[1] = 'int32':pos
					[2] = 'int32':skillId
				},
			},
			[18] = 'int32':useSkillStrategy
			[19] = {--repeated CrystalInfo
				[1] = 'int32':rarity
				[2] = 'int32':gridId
			},
			[20] = 'repeated int32':equipSkillIds	[装备激活的skillId,对应PassiveSkills表的id]
			[21] = {--repeated EuqipFetterInfo
				[1] = 'int32':index
				[2] = {--NewEquipmentInfo
					[1] = {--ChangeType(enum)
						'v4':ChangeType
					},
					[2] = 'string':id	[新装备id]
					[3] = 'int32':cid	[新装备cid]
					[4] = 'int32':stage	[新装备阶段等级]
					[5] = 'int32':level	[新装备等级]
					[6] = 'string':heroId	[英雄id]
					[7] = 'int32':position	[装备位置]
				},
			},
			[22] = {--HeroStatus(enum)
				'v4':HeroStatus
			},
			[23] = 'int32':deadLine
			[24] = {--repeated GemInfo
				[1] = {--ChangeType(enum)
					'v4':ChangeType
				},
				[2] = 'string':id	[宝石id]
				[3] = 'int32':cid	[宝石cid]
				[4] = 'int32':heroId	[英雄id]
				[5] = 'repeated int32':randSkill	[随机技能]
				[6] = {--GemRandSkill
					[1] = 'int32':originalSkill	[ 原始id]
					[2] = 'int32':newSkill	[ 新id]
				},
			},
			[25] = 'int32':skinCidTemp	[ 皮肤cid]
			[26] = 'repeated int32':exploreTreasureSkill	[ 探索宝物技能]
			[27] = 'int32':breakLv	[突破等级]
		},
	}
--]]
s2c.HERO_HERO_ADVANCE_RESULT = 1028

--[[
	[1] = {--ResResetSkill
		[1] = 'string':heroId
		[2] = {--SkillStrategy
			[1] = 'int32':id
			[2] = 'string':name
			[3] = 'int32':alreadyUseSkillPiont
			[4] = {--repeated AngeSkillInfo
				[1] = 'int32':type
				[2] = 'int32':pos
				[3] = 'int32':lvl
			},
			[5] = {--repeated PassiveSkillInfo
				[1] = 'int32':pos
				[2] = 'int32':skillId
			},
		},
	}
--]]
s2c.HERO_RES_RESET_SKILL = 1044

--[[
	[1] = {--ChangCellInfo
		[1] = 'int32':location	[事件id]
		[2] = 'int32':chessesId	[事件类型]
	}
--]]
s2c.SACRIFICE_CHANG_CELL_INFO = 8005

--[[
	[1] = {--RespChallengeInfo
		[1] = 'int32':currentFloor	[正在挑战的楼层]
		[2] = {--repeated FloorFormation
			[1] = 'int32':floor	[派遣的关卡]
			[2] = {--repeated Formation
				[1] = 'int32':round	[派遣的关卡]
				[2] = {--repeated HeroIndex
					[1] = 'int32':index
					[2] = 'int32':hero
				},
			},
		},
		[3] = {--repeated FloorRecord
			[1] = 'int32':floorId	[楼层]
			[2] = 'int32':score	[通关总时间]
		},
	}
--]]
s2c.DUNGEON_RESP_CHALLENGE_INFO = 1820

--[[
	[1] = {--RespActivityItemRefresh
	}
--]]
s2c.ACTIVITY_RESP_ACTIVITY_ITEM_REFRESH = 5179

--[[
	[1] = {--ResDonateActivity
		[1] = 'int32':activityId	[ 活动ID]
		[2] = 'int32':dailyGetNum	[当日获得积分]
		[3] = {--repeated Pair
			[1] = 'int32':key
			[2] = 'int32':value
		},
	}
--]]
s2c.ACTIVITY_RES_DONATE_ACTIVITY = 5304

--[[
	[1] = {--RespFestival2020Info
		[1] = 'int32':stage	[阶段]
		[2] = 'int32':stageEnd	[阶段通用结束时间]
		[3] = {--repeated SpringFestival2020City
			[1] = 'int32':id	[城市id]
			[2] = {--repeated SpringFestival2020Area
				[1] = 'int32':area	[点位]
				[2] = 'int32':dungeon	[当前关卡,如果为0则点位不可用]
				[3] = 'bool':resOpen	[是否解锁资源]
				[4] = 'int32':resCount	[资源可用次数]
				[5] = 'int32':resStartTime	[资源开始时间]
				[6] = 'int32':resUpTime	[下次资源增加时间]
				[7] = 'bool':replace	[是否替换关卡]
				[8] = 'int32':replaceEnd	[替换结束时间]
				[9] = 'int32':replaceGame	[替换的小游戏]
				[10] = 'int64':damage	[最佳伤害值]
				[11] = 'int32':score	[伤害积分]
				[12] = 'bool':pass	[是否通关]
				[13] = 'bool':dunPass	[是否已通过关卡]
			},
		},
		[4] = 'int32':totalScore	[总得分]
		[5] = 'int32':round	[魔王轮次,0则未开启]
		[6] = 'int32':roundScore	[轮次得分]
	}
--]]
s2c.SPRING_FESTIVAL_RESP_FESTIVAL2020_INFO = 6710

--[[
	[1] = {--ExploreTaskInfos
		[1] = {--repeated AfkTask
			[1] = 'int32':id
			[2] = 'int32':state	[任务状态 0 未开始 1开始 2完成,3已领奖]
			[3] = 'repeated int32':heroId	[任务派遣的hero]
			[4] = 'int64':startTime	[任务开始执行的时间 0 就是还没有开始或者已经完成]
			[5] = 'int32':cabinId	[舱室id]
		},
	}
--]]
s2c.EXPLORE_EXPLORE_TASK_INFOS = 7813

--[[
	[1] = {--RespHeroDispatchInfo
		[1] = {--repeated CurHeroDispatchInfo
			[1] = 'int32':dungeonType	[ 派遣类型, 1 日常副本, 2  精灵试炼, 3  雷霆圣堂, 4  联机作战, 5  日常约会]
			[2] = {--repeated HeroDispatchFightPower
				[1] = 'int32':hero
				[2] = 'int32':fightPower
			},
			[3] = {--repeated DispatchDungeonInfo
				[1] = 'int32':dungeonCid	[ 关卡id]
				[2] = 'int32':multiple	[ 关卡奖励倍数,万分比]
				[3] = 'int32':eTime	[ 完成时间点]
				[4] = 'int32':awardCount	[可用奖励次数]
				[5] = 'int32':runCount	[正在进行的次数]
				[6] = 'int32':maxCount	[最大进行次数]
			},
		},
		[2] = {--repeated HeroDispatchExhaustion
			[1] = 'int32':hero
			[2] = 'int32':exhaustion
			[3] = 'int32':nextTime	[ 下一次恢复时间点]
		},
		[3] = {--repeated DispatchTypeHero
			[1] = 'int32':type	[1 日常副本, 2  精灵试炼, 3  雷霆圣堂, 4  联机作战, 5  日常约会]
			[2] = 'repeated int32':heroes	[请求派遣的精灵]
		},
	}
--]]
s2c.HERO_DISPATCH_RESP_HERO_DISPATCH_INFO = 8601

--[[
	[1] = {--OfficeMissionsMsg
		[1] = {--repeated GridMission
			[1] = 'int32':missionId	[ 任务id]
			[2] = 'int32':progress	[ 任务进度]
		},
		[2] = 'bool':completed	[ 当前阶段任务是否完成]
	}
--]]
s2c.OFFICE_EXPLORE_OFFICE_MISSIONS = 7207

--[[
	[1] = {--RespHeroDispatches
		[1] = {--repeated CurHeroDispatchInfo
			[1] = 'int32':dungeonType	[ 派遣类型, 1 日常副本, 2  精灵试炼, 3  雷霆圣堂, 4  联机作战, 5  日常约会]
			[2] = {--repeated HeroDispatchFightPower
				[1] = 'int32':hero
				[2] = 'int32':fightPower
			},
			[3] = {--repeated DispatchDungeonInfo
				[1] = 'int32':dungeonCid	[ 关卡id]
				[2] = 'int32':multiple	[ 关卡奖励倍数,万分比]
				[3] = 'int32':eTime	[ 完成时间点]
				[4] = 'int32':awardCount	[可用奖励次数]
				[5] = 'int32':runCount	[正在进行的次数]
				[6] = 'int32':maxCount	[最大进行次数]
			},
		},
	}
--]]
s2c.HERO_DISPATCH_RESP_HERO_DISPATCHES = 8606

--[[
	[1] = {--RespFestival2020CityRefresh
		[1] = {--repeated SpringFestival2020City
			[1] = 'int32':id	[城市id]
			[2] = {--repeated SpringFestival2020Area
				[1] = 'int32':area	[点位]
				[2] = 'int32':dungeon	[当前关卡,如果为0则点位不可用]
				[3] = 'bool':resOpen	[是否解锁资源]
				[4] = 'int32':resCount	[资源可用次数]
				[5] = 'int32':resStartTime	[资源开始时间]
				[6] = 'int32':resUpTime	[下次资源增加时间]
				[7] = 'bool':replace	[是否替换关卡]
				[8] = 'int32':replaceEnd	[替换结束时间]
				[9] = 'int32':replaceGame	[替换的小游戏]
				[10] = 'int64':damage	[最佳伤害值]
				[11] = 'int32':score	[伤害积分]
				[12] = 'bool':pass	[是否通关]
				[13] = 'bool':dunPass	[是否已通过关卡]
			},
		},
	}
--]]
s2c.SPRING_FESTIVAL_RESP_FESTIVAL2020_CITY_REFRESH = 6712

--[[
	[1] = {--ResGroupTeamInfo
		[1] = {--GroupTeamInfo
			[1] = 'string':teamId	[队伍id]
			[2] = 'int32':createTime	[创建时间]
			[3] = 'int32':giftId	[礼包id]
			[4] = 'bool':isShow	[是否显示]
			[5] = 'bool':isComplete	[是否完成]
			[6] = 'bool':isDestroy	[是否销毁]
			[7] = {--repeated GroupTeamMember
				[1] = 'int32':playerId
				[2] = 'string':playerName
				[3] = 'int32':titleId
				[4] = 'int32':level
				[5] = 'bool':isCreator
				[6] = 'int32':portraitCid
				[7] = 'int32':portraitFrameId
			},
		},
	}
--]]
s2c.RECHARGE_RES_GROUP_TEAM_INFO = 4376

--[[
	[1] = {--ResTrainDungeonInfo
		[1] = {--repeated TrainDungeonInfo
			[1] = 'int32':dungeonId
			[2] = 'bool':isOpen
			[3] = 'int32':fightCount	[ 已挑战次数]
		},
	}
--]]
s2c.CHASM_RES_TRAIN_DUNGEON_INFO = 6152

--[[
	[1] = {--RespEnter
		[1] = 'bool':enter	[能不能进入约会]
	}
--]]
s2c.EXTRA_DATING_RESP_ENTER = 5662

--[[
	[1] = {--TechTree
		[1] = 'int32':techType
		[2] = 'int32':nationId	[如果是国家天赋,则发送国家id,如果是形态天赋没有数据]
		[3] = {--repeated Tech
			[1] = 'int32':techId
			[2] = 'int32':state	[0:解锁未学习 ,1:已学习  未解锁不发]
		},
	}
--]]
s2c.EXPLORE_TECH_TREE = 7828

--[[
	[1] = {--RespRecommendFriends
		[1] = {--repeated FriendInfo
			[1] = 'int32':pid	[ 玩家ID]
			[2] = 'string':name	[ 名字]
			[3] = 'int32':fightPower	[ 战力]
			[4] = 'int32':lvl	[ 等级]
			[5] = 'int32':lastLoginTime	[ 最后登录时间]
			[6] = 'int32':lastHandselTime	[ 最后送礼时间]
			[7] = 'bool':receive	[ 是否能够领取]
			[8] = 'int32':status	[ 状态:1:好友,2:屏蔽,3:申请]
			[9] = 'int32':leaderCid	[ 英雄CID(队长)    // 英雄CID(队长)]
			[10] = 'bool':online	[ 是否在线]
			[11] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[12] = 'int32':time	[ 申请时间/加入黑名单时间等]
			[13] = 'int32':helpCDtime	[ 助战cd结束时间(秒)    // 助战cd结束时间(秒)]
			[14] = 'bool':canSend	[ 是否可以赠送]
			[15] = 'int32':portraitCid	[ 头像CID]
			[16] = 'int32':portraitFrameCid	[ 头像框CID]
			[17] = 'repeated int32':groupGiftIds	[团购礼包id]
			[18] = 'int32':type	[0没有关系,1他是我师父,2他是我徒弟,不包括出师的徒弟]
		},
	}
--]]
s2c.FRIEND_RESP_RECOMMEND_FRIENDS = 3075

--[[
	[1] = {--NewRespActivitys
		[1] = {--repeated ActivityConfigMsg
			[1] = {--ChangeType(enum)
				'v4':ChangeType
			},
			[2] = 'int32':id	[活动ID]
			[3] = 'int32':activityType	[活动类型]
			[4] = 'string':activityTitle	[活动标题]
			[5] = 'int32':startTime	[开始时间]
			[6] = 'int32':endTime	[结束时间]
			[7] = 'int32':showStartTime	[显示开始时间]
			[8] = 'int32':showEndTime	[显示结束时间]
			[9] = 'string':remark	[备注信息Json]
			[10] = 'string':extendData	[扩展数据]
			[11] = 'int32':rank	[排序]
			[12] = 'string':showIcon	[广告图]
			[13] = 'repeated int32':items	[活动条目]
			[14] = 'string':titleIcon	[活动标题Icon]
		},
	}
--]]
s2c.ACTIVITY_NEW_RESP_ACTIVITYS = 5124

--[[
	[1] = {--RespChangeRoom
		[1] = {--RespInitChatInfo
			[1] = 'int32':roomId
			[2] = {--repeated ChatInfo
				[1] = 'int32':channel	[	聊天类型:1.公共 2.私聊;3.帮派 4.系统 5.队伍 6.队伍系统邀请]
				[2] = 'int32':fun	[ 	功能类型:1.聊天 2.深渊组队邀请  6系统消息]
				[3] = 'string':content	[	内容]
				[4] = 'int32':pid	[	说话人的id]
				[5] = 'string':pname	[	说话人名称]
				[6] = 'int32':lvl	[ 	玩家等级]
				[7] = 'int32':helpFightHeroCid
				[8] = 'int32':portraitCid	[玩家头像]
				[9] = 'int32':portraitFrameCid	[玩家头像框]
				[10] = 'int32':titleId	[称号]
				[11] = 'int32':chatFrameCid	[气泡框]
			},
		},
	}
--]]
s2c.CHAT_RESP_CHANGE_ROOM = 2307

--[[
	[1] = {--DetectiveLogNotice
		[1] = {--repeated DetectiveMainLogInfo
			[1] = 'int32':logId	[id]
			[2] = 'bool':finished	[是否完成,true完成]
			[3] = 'int64':time	[发生时间]
		},
		[2] = 'int32':type	[更新类型:1表示进入的时候全量,2表示只发的更新的]
	}
--]]
s2c.DETECTIVE_DETECTIVE_LOG_NOTICE = 8907

--[[
	[1] = {--RespAITrainingInfo
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'int32':sTime	[调教卡开始时间]
		[3] = 'int32':eTime	[调教卡结束时间]
		[4] = 'int32':totalNum	[总通过量]
		[5] = 'int32':sucNum	[成功通过量]
		[6] = 'int32':level	[调教等级]
		[7] = 'int32':exp	[调教经验]
		[8] = 'int32':days	[调教天数]
		[9] = 'string':bestQuery	[最赞调教]
		[10] = 'string':bestReply	[最赞调教]
	}
--]]
s2c.DATING_RESP_AITRAINING_INFO = 1563

--[[
	[1] = {--ExploreGetInfos
		[1] = {--repeated AfkActivity
			[1] = 'int32':id	[活动配置id]
			[2] = 'bool':first
			[3] = 'int32':localCity	[当前城市]
			[4] = 'int32':localNation	[当前国家]
			[5] = 'int64':startTime	[开始探索的时间]
			[6] = 'int32':cityAwardTimes	[当前城市获得奖励点次数,只是当前城市,用来计算城市进度]
			[7] = 'int32':speed	[当前的探索速度]
			[8] = 'int64':lastAwardPointTime	[到达最后一个奖励点位的时间]
			[9] = 'int32':capacity	[当前的探索总的容量]
			[10] = 'bool':isPush	[是否是服务器主动推送]
			[11] = 'int32':totalRewardCount	[总的奖励次数]
			[12] = {--AfkReward
				[1] = 'int64':awardTime	[获得奖励的时间]
				[2] = 'int32':activityId
				[3] = 'int32':nationId
				[4] = 'int32':cityId
				[5] = 'int32':dropId
				[6] = {--repeated RewardsMsg
					[1] = 'int32':id
					[2] = 'int32':num
				},
			},
			[13] = {--repeated AfkNation
				[1] = 'int32':id	[国家配置]
				[2] = {--repeated AfkCity
					[1] = 'int32':id	[城市配置id]
					[2] = {--repeated AfkEvent
						[1] = 'int32':id
						[2] = 'int32':state
						[3] = 'int32':progress	[多层事件已经进行的进度]
					},
					[3] = 'repeated int32':completeEvent	[已经完成事件]
				},
			},
			[14] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
			[15] = {--repeated RewardsMsg
				[1] = 'int32':id
				[2] = 'int32':num
			},
		},
		[2] = 'int32':quickTimes
		[3] = {--ShipAttr
			[1] = 'int32':shape	[飞机形态]
			[2] = {--repeated Attr
				[1] = 'int32':systemId	[0:全体系统,1:舱室升级(包含英雄上阵),2:形态天赋,3:武器培养,4:护甲培养,5:操作仓上阵, 6:宝物收集,7:配件上阵 ,8:飞舰皮肤    //0:全体系统,1:舱室升级(包含英雄上阵),2:形态天赋,3:武器培养,4:护甲培养,5:操作仓上阵, 6:宝物收集,7:配件上阵 ,8:飞舰皮肤]
				[2] = 'int32':fightPower
			},
		},
	}
--]]
s2c.EXPLORE_EXPLORE_GET_INFOS = 7820

--[[
	[1] = {--RespHeartState
		[1] = 'int32':roleId	[精灵id]
		[2] = 'int32':sealState	[精灵封印状态  0:未封印 1:封印]
		[3] = 'int32':sealType	[解锁方式  0:时间解锁 1:道具解锁]
	}
--]]
s2c.DATING_RESP_HEART_STATE = 1557

--[[
	[1] = {--ResSummerCourageEnter
		[1] = {--ApInfo
			[1] = 'int32':value	[ap值]
			[2] = 'int32':limit	[上限值]
		},
		[2] = {--repeated AreaInfo
			[1] = 'int32':areaId	[区域id]
			[2] = 'bool':isDevil	[是否封锁了,true是,false没]
			[3] = 'bool':explored	[是否探索过,true是,false没]
			[4] = {--repeated RoadInfo
				[1] = 'int32':startAreaId	[起始区域id]
				[2] = 'int32':endAreaId	[截止区域id]
				[3] = 'bool':unlocked	[是否解锁,true解锁,false未解锁]
			},
		},
		[3] = {--repeated EquipInfo
			[1] = 'int32':position	[位置]
			[2] = 'int32':equipId	[装备id]
		},
		[4] = 'int32':currentAreaId	[当前所在区域]
		[5] = 'int32':currentChapterId	[当前周目]
		[6] = 'int32':currentEvtId	[当前事件id]
		[7] = 'bool':isNewChapter	[是否新周目]
		[8] = 'repeated int32':unlockChapterInfo	[解锁了的周目id]
	}
--]]
s2c.SUMMER_COURAGE_RES_SUMMER_COURAGE_ENTER = 6909

--[[
	[1] = {--RespCompletedEvent
		[1] = 'int32':activityid	[提交的活动ID]
		[2] = 'int32':activitEntryId	[提交的活动条目ID]
		[3] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[4] = 'string':extendData	[额外信息]
	}
--]]
s2c.ACTIVITY_RESP_COMPLETED_EVENT = 5141

--[[
	[1] = {--DialogueMsg
		[1] = 'int32':score	[积分]
	}
--]]
s2c.DATING_DIALOGUE = 1538

--[[
	[1] = {--RespAIAuditUpdate
		[1] = 'int32':roleId	[精灵ID]
		[2] = 'int32':type	[变动类型- 1 问题池  2 审核列表    //变动类型- 1 问题池  2 审核列表]
		[3] = 'int32':param	[类型参数- 1 审核列表审核通过 2 审核列表审核失败    //类型参数- 1 审核列表审核通过 2 审核列表审核失败]
	}
--]]
s2c.DATING_RESP_AIAUDIT_UPDATE = 1569

--[[
{}
--]]
s2c.CHASM_RESP_RANDOM_BUFF = 6155

--[[
	[1] = {--ResNewPlayerGuide
		[1] = 'int32':guideId	[ 玩家当前已完成Id(新号默认0)    // 玩家当前已完成Id(新号默认0)]
		[2] = 'bool':finish	[ 玩家是否完成新手指引]
	}
--]]
s2c.PLAYER_RES_NEW_PLAYER_GUIDE = 278

--[[
	[1] = {--UpdateComposeInfo
		[1] = {--ChristmasComposeInfo
			[1] = 'int32':id
			[2] = 'int32':composeTimes
			[3] = 'int32':countDown
		},
	}
--]]
s2c.CHRISTMAS_UPDATE_COMPOSE_INFO = 6602

--[[
	[1] = {--ResqChasmExitFight
	}
--]]
s2c.CHASM_RESQ_CHASM_EXIT_FIGHT = 6147

--[[
	[1] = {--ExploreEventAddTimes
		[1] = 'int32':activityId
		[2] = 'int32':nationId
		[3] = 'int32':cityId
		[4] = {--AfkEvent
			[1] = 'int32':id
			[2] = 'int32':state
			[3] = 'int32':progress	[多层事件已经进行的进度]
		},
	}
--]]
s2c.EXPLORE_EXPLORE_EVENT_ADD_TIMES = 7819

--[[
	[1] = {--RefreshBuffMsg
		[1] = 'int32':buffCid	[buffid]
		[2] = 'int32':buffCount	[buff刷新次数]
	}
--]]
s2c.HERO_CHALLENGE_REFRESH_BUFF = 6302

--[[
	[1] = {--Resp2019ChristmasRefresh
	}
--]]
s2c.CHRISTMAS_RESP2019_CHRISTMAS_REFRESH = 6616

--[[
	[1] = {--RespRankActivity
		[1] = 'int32':activityId	[ 活动ID]
		[2] = {--repeated ActivityRankMsg
			[1] = 'int32':rank	[ 排行]
			[2] = 'int32':playerId	[角色ID]
			[3] = 'string':playerName	[ 角色名]
			[4] = 'int32':score	[排行榜分数]
			[5] = 'int32':headIcon	[头像id]
			[6] = 'int32':helpFightHeroId	[助战id]
			[7] = 'int32':level	[等级]
			[8] = 'int32':frameCid	[头像框]
			[9] = 'int32':groupRank	[0:单人排名,1:组队排名]
			[10] = {--repeated RankPlayerInfo
				[1] = 'string':playerName	[ 角色名]
				[2] = 'int32':playerId	[角色ID]
				[3] = 'int32':level	[等级]
				[4] = 'int32':frameCid	[头像框]
				[5] = 'int32':headIcon	[头像id]
				[6] = 'int32':helpFightHeroId	[助战id]
				[7] = 'int32':heroId	[使用英雄id]
			},
		},
	}
--]]
s2c.ACTIVITY_RESP_RANK_ACTIVITY = 5132

--[[
	[1] = {--RsepEnterChasm
		[1] = {--repeated ChasmInfo
			[1] = 'int32':id	[ 副本ID]
			[2] = 'int32':status	[ 状态		0:关闭 1:开启]
			[3] = 'int32':fightCount	[ 已挑战次数]
			[4] = 'int32':buyCount	[ 已购买次数]
			[5] = 'int32':remainCount	[ 剩余奖励次数]
			[6] = 'int32':awardStartTime	[ 特殊奖励开始时间]
			[7] = 'int32':awardEndTime	[ 特殊奖励结束时间]
			[8] = 'bool':isSpecial	[ 是否有特殊奖励]
			[9] = 'bool':finishOnce	[ 是否完成过]
		},
	}
--]]
s2c.CHASM_RSEP_ENTER_CHASM = 6149

--[[
	[1] = {--OpenComposePanel
		[1] = {--repeated ChristmasComposeInfo
			[1] = 'int32':id
			[2] = 'int32':composeTimes
			[3] = 'int32':countDown
		},
	}
--]]
s2c.CHRISTMAS_OPEN_COMPOSE_PANEL = 6607

--[[
	[1] = {--ResqOdeumLevelInfo
		[1] = {--LevelSpecialConditions
			[1] = 'repeated int32':datingNodes	[完成的相关约会节点]
		},
		[2] = 'repeated int32':levels	[通关顺序]
	}
--]]
s2c.ODEUM_RESQ_ODEUM_LEVEL_INFO = 6509

--[[
	[1] = {--GetLevelGroupReward
		[1] = 'int32':cid	[副本组cid]
		[2] = 'int32':difficulty	[难度]
		[3] = 'int32':starNum	[星数]
		[4] = {--repeated ListMap
			[1] = 'int32':key
			[2] = 'repeated int32':list
		},
	}
--]]
s2c.DUNGEON_GET_LEVEL_GROUP_REWARD = 1802

--[[
	[1] = {--WorldPointExploreloMsg
		[1] = 'bool':result	[ 探索结果]
		[2] = {--repeated WorldPointInfo
			[1] = 'int32':x	[ x位置]
			[2] = 'int32':y	[ y位置]
		},
	}
--]]
s2c.QLIPHOTH_WORLD_POINT_EXPLORELO = 6217

--[[
	[1] = {--ResTotalPayRewardInfo
		[1] = 'int32':totalPay	[累积充值金额(单位:分)    //累积充值金额(单位:分)]
		[2] = 'repeated int32':rewardIds	[已领取过的累充奖励id集合]
	}
--]]
s2c.RECHARGE_RES_TOTAL_PAY_REWARD_INFO = 4361

--[[
	[1] = {--ResDecomposeGemDesign
		[1] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EQUIPMENT_RES_DECOMPOSE_GEM_DESIGN = 2840

--[[
	[1] = {--SceneSynchronizeMsg
	}
--]]
s2c.DUNGEON_SCENE_SYNCHRONIZE = 1810

--[[
	[1] = {--ResLimitlessSummonReward
		[1] = 'int32':activityId	[活动Id]
		[2] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
		[3] = 'repeated int32':scoreRewards	[已领取过的积分奖励id]
	}
--]]
s2c.LIMITLESS_SUMMON_RES_LIMITLESS_SUMMON_REWARD = 3504

--[[
	[1] = {--OperateFormationMsg
		[1] = 'repeated int32':formation	[ 阵型信息]
	}
--]]
s2c.QLIPHOTH_OPERATE_FORMATION = 6204

--[[
	[1] = {--ResSummerCourageExplore
		[1] = 'int32':evtId	[事件id]
	}
--]]
s2c.SUMMER_COURAGE_RES_SUMMER_COURAGE_EXPLORE = 6901

--[[
	[1] = {--RespAssistanceFlopRank
		[1] = 'int32':activityId	[活动id]
		[2] = {--repeated AssistanceRankInfo
			[1] = 'int32':rank	[名次]
			[2] = 'string':playerName	[玩家名称]
			[3] = 'string':unionName	[ 社团名称]
			[4] = 'string':successTime	[完成时间]
			[5] = 'int32':group	[分组]
			[6] = 'int32':layer	[层数]
			[7] = 'int32':location	[位置]
		},
		[3] = {--AssistanceRankInfo
			[1] = 'int32':rank	[名次]
			[2] = 'string':playerName	[玩家名称]
			[3] = 'string':unionName	[ 社团名称]
			[4] = 'string':successTime	[完成时间]
			[5] = 'int32':group	[分组]
			[6] = 'int32':layer	[层数]
			[7] = 'int32':location	[位置]
		},
	}
--]]
s2c.ACTIVITY_RESP_ASSISTANCE_FLOP_RANK = 5213

--[[
	[1] = {--RespGetExperiment
		[1] = {--repeated Experiment
			[1] = 'int32':id	[配置表id]
			[2] = 'int32':score	[关卡对应的积分信息]
			[3] = 'bool':up	[是否加成关卡buff]
		},
		[2] = {--repeated ExperimentHeroBuff
			[1] = 'int32':heroId	[配置英雄id]
			[2] = 'int32':buffId	[buffId]
		},
		[3] = 'repeated int32':taskList	[任务列表]
		[4] = 'repeated int32':attackOrder	[攻打关卡的顺序]
	}
--]]
s2c.DUNGEON_RESP_GET_EXPERIMENT = 1817

--[[
	[1] = {--RespSpeedLinkInfo
		[1] = {--repeated SpeedLink
			[1] = 'int32':location	[位置]
			[2] = 'int32':id
		},
	}
--]]
s2c.ACTIVITY_RESP_SPEED_LINK_INFO = 5149

--[[
	[1] = {--RespKurumiCamp
		[1] = 'int32':camp	[阵营]
	}
--]]
s2c.ACTIVITY_RESP_KURUMI_CAMP = 5166

--[[
	[1] = {--RspModifyPicInfo
		[1] = {--PicInfoMsg
			[1] = 'int32':index	[索引]
			[2] = 'int32':id	[配置ID]
			[3] = 'int32':zooming	[缩放大小]
			[4] = 'int32':rotate	[旋转度]
			[5] = 'string':text	[文本内容]
		},
	}
--]]
s2c.ARRSP_MODIFY_PIC_INFO = 9302

--[[
	[1] = {--ExploreEventGetAward
		[1] = 'int32':activityId
		[2] = 'int32':nationId
		[3] = 'int32':cityId
		[4] = 'int32':eventId
		[5] = {--repeated RewardsMsg
			[1] = 'int32':id
			[2] = 'int32':num
		},
	}
--]]
s2c.EXPLORE_EXPLORE_EVENT_GET_AWARD = 7817

--[[
	[1] = {--ResFriendHelpActivityPre
		[1] = 'string':address	[ 之前填的地址 可能为空]
	}
--]]
s2c.ACTIVITY_RES_FRIEND_HELP_ACTIVITY_PRE = 5300

return s2c