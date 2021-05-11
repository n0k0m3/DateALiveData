local tblProto = {
	[6676] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', 'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v8', {true,{'v4', {true,{'v4', 'v4', }},}},},
			{'open', 'index', 'total', {true,{'playerReCallRank','playerId', 'playerName', 'portraitCid', 'recallScore', 'level', 'rank', 'portraitFrameCid', }},'score', {true,{'awardInfo','awardScore', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[270] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[4388] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},{true,{'srewards','id', 'num', }},}
		}
	end,
	[6606] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'records', }
		}
	end,
	[5305] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 'v4', 'v4', 's', 'v4', }},'v4', },
			{'activityId', {true,{'ranks','rank', 'score', 'unionId', 'unionIcon', 'unionName', 'unionLvl', }},'myRank', }
		}
	end,
	[8901] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'evtId', }
		}
	end,
	[9351] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v8', 'tv4', {true,{'v8', 'v4', {true,{'v4', 'v4', }},}},},
			{'curPos', 'rounds', 'rewardId', 'nextRefreshTime', 'posRewarded', {true,{'records','time', 'result', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[7808] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[3090] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4',}},}},},
			{'inviteCode', {true,{'friendHelpInfos','playerId', 'playerName', 'portraitCid', 'portraitFrameCid', 'level', {true,{'taskInfos','taskId', 'status',}},}},}
		}
	end,
	[3335] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v8', 'v4', 'v4', }},}},},
			{{true,{'historyRecords','type', {true,{'records','time', 'itemId', 'itemNum', }},}},}
		}
	end,
	[8103] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', }},}},},
			{{false,{'eventInfo','eventId', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[1559] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'trigger', }
		}
	end,
	[9203] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[9156] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v8', 'v4', 'v4', 'v4', 'tv4', }},'tv4', },
			{{false,{'maidInfo','totle', 'customer', 'cost', 'turnOver', 'attributes', }},'workLists', }
		}
	end,
	[1038] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {false,{'v4', 'v4', 'v4', }},'v4', },
			{'heroId', {false,{'angeSkillInfo','type', 'pos', 'lvl', }},'useSkillPiont', }
		}
	end,
	[7504] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1040] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', },
			{'heroId', 'skillStrategyId', }
		}
	end,
	[8405] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirits','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
		}
	end,
	[6507] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'lingbo', }
		}
	end,
	[7811] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5893] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'type', }
		}
	end,
	[9407] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'v4', },
			{'leftRiddleCount', 'leftRewardCount', 'rightCount', 'id', 'type', }
		}
	end,
	[8703] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1795] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', 'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},'v4', 'v4', }},},
			{{false,{'group','id', 'cid', 'fightCount', 'buyCount', {true,{'rewardInfo','key', 'list', }},'mainLineCid', 'maxMainLine', }},}
		}
	end,
	[6665] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2817] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'equipment','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{false,{'oldEquipment','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}
		}
	end,
	[6817] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', }},}},},
			{{true,{'rankInfo','rank', 'costTime', {true,{'playerInfo','pid', 'pName', 'level', 'headId', 'portraitFrameCid', }},}},}
		}
	end,
	[7836] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', }},}},},
			{{false,{'ship','shape', {true,{'attr','systemId', 'fightPower', }},}},}
		}
	end,
	[5173] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4','v4', 'v4', }},},
			{'activityId', {true,{'specialAward','ct','id', 'triggerId', }},}
		}
	end,
	[8302] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'rankList','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},{false,{'rank','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},'refreshMinu', {true,{'curSeason','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},{false,{'curRank','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},{true,{'lastSeason','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},{false,{'lastRank','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},}
		}
	end,
	[6711] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[6510] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'level', }
		}
	end,
	[268] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'serverTime', }
		}
	end,
	[2569] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {false,{'s', 'v4', 'v4', 'tv4', 'b', 'b', 'v4', 'tv4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'tv4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 's', }},{false,{'v4', 'v4', 'v4', 'v4', }},'s', 'v4', }},},
			{{true,{'stores','storeId', {false,{'store','icon', 'name', 'roleSet', 'showCurrency', 'autoRefreshCorn', 'manualRefresh', 'refreshCostId', 'refreshCostNum', 'openContVal', 'openContType', 'commoditySupplyType', 'showBeginTime', 'buyBeginTime', 'buyEndTime', 'showEndTime', 'rank', 'storeType', 'openTimeType', 'extra', }},{true,{'commoditys','id', 'grid', 'order', 'openContType', 'openContVal', 'buyBeginTime', 'buyEndTime', 'sellTimeType', 'limitType', 'batchBuy', 'serLimit', 'sellDescribtion', {true,{'goodInfo','id', 'num', }},'priceType', 'priceVal', 'des', 'title', 'tag', 'autoRefreshCorn', 'showBeginTime', 'showEndTime', 'limitVal', 'extra', }},{false,{'storeRefresh','todayRefreshCount', 'totalRefreshCount', 'nextRefreshTime', 'freeNum', }},'pic', 'groupRefreshTime', }},}
		}
	end,
	[5663] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', 'v4', 'v4', }},}},},
			{{true,{'favorList','roleId', {true,{'info','favorId', 'statue', 'firstPass', 'energy', }},}},}
		}
	end,
	[6150] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'b', }},},
			{{false,{'chasmInfo','id', 'status', 'fightCount', 'buyCount', 'remainCount', 'awardStartTime', 'awardEndTime', 'isSpecial', 'finishOnce', }},}
		}
	end,
	[9158] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'b', 'v4', 'v4', {true,{'v4', 'v4', }},'s', }},},
			{{true,{'eventList','ct','id', 'reward', 'cfgId', 'creatAt', {true,{'rewards','id', 'num', }},'weather', }},}
		}
	end,
	[515] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},{true,{'v4','s', 'v4', 'v4', }},{true,{'v4','s', 'v4', 'v4', }},},
			{{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},{true,{'treasures','ct','id', 'cid', 'star', }},{true,{'exploreEquip','ct','id', 'cid', 'level', }},}
		}
	end,
	[6807] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 's', 'v4', 'v4', },
			{'roomId', 'fightServerHost', 'fightServerPort', 'roomType', }
		}
	end,
	[5146] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'activityid', 'propId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[5306] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v8', },
			{'activityId', 'num', }
		}
	end,
	[6707] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2567] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[9408] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'answer', {true,{'rewardsMsg','id', 'num', }},}
		}
	end,
	[6826] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'areaShowData','type', 'total', }},}
		}
	end,
	[2846] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6819] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'dayTimes', }
		}
	end,
	[1825] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},'tv4', },
			{{true,{'linkHero','heroId', 'level', 'exp', 'desire', 'index', {true,{'attrs','attributeId', 'value', }},}},'additionHero', }
		}
	end,
	[8608] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv4', }},},
			{{true,{'heroes','type', 'heroes', }},}
		}
	end,
	[9006] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},},
			{{true,{'supportRole','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},}
		}
	end,
	[6660] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v8', 'v4', 'v4', },
			{'id', 'senderId', 'createTime', 'moneyType', 'moneyNum', }
		}
	end,
	[2819] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {true,{'v4', 'v4', }},},
			{'success', {true,{'returnItem','id', 'num', }},}
		}
	end,
	[5201] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'switch','type', 'value', }},}
		}
	end,
	[8409] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[8314] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {false,{'v4', 'pv4', 'v4', 'b', 'v4', 'v4', }},}},'v4', 'v4', },
			{{false,{'levelInfos','battleScore', {false,{'levelInfo','cid', 'goals', 'fightCount', 'win', 'buyCount', 'freeCount', }},}},'battleScore', 'cardPoint', }
		}
	end,
	[4374] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'b', 'v4',}},},
			{{true,{'fundInfo','id', 'restDays', 'todayAward', 'ct',}},}
		}
	end,
	[5218] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[1567] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7838] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5195] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6508] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'status', }
		}
	end,
	[8607] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'stars','hero', 'star', }},}
		}
	end,
	[1799] = function()
		return {
			{"net.NetHelper", "receive"},
			{'pv4', 'pv4', },
			{'startIds', 'endIds', }
		}
	end,
	[6806] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 's', 'v4', 'v4', },
			{'roomId', 'fightServerHost', 'fightServerPort', 'roomType', }
		}
	end,
	[2828] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},}},},
			{'equipmentId', {true,{'recycleInfo','type', {true,{'costItem','id', 'num', }},{true,{'returnItem','id', 'num', }},}},}
		}
	end,
	[6153] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[8609] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[5160] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},'v4', },
			{'day', {true,{'storeList','storeId', 'num', }},'state', }
		}
	end,
	[5197] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'b', 'b', },
			{'friendId', {true,{'items','key', 'value', }},{true,{'friendItems','key', 'value', }},'confirm', 'friendConfirm', }
		}
	end,
	[7907] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'b', 'b', 'b', 'v4', 'v4','v4', 'b', }},'b', },
			{{true,{'apprenticeInfo','playerId', 'portraitCId', 'name', 'fightPower', 'level', 'lastLoginTime', 'online', 'portraitFrameCId', 'isFriend', 'isUnion', 'finished', 'type', 'ct','famousExp', 'hasGift', }},'success', }
		}
	end,
	[2073] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', },
			{'isSuccess', 'eventType', }
		}
	end,
	[7818] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', {true,{'v4', 's', 'v4', 'v4', 'v4', }},'v4', 's', {true,{'v4', 'tv4', 'ts', }},}},},
			{{false,{'fightData','fid', {true,{'fighters','id', 'name', 'type', 'hp', 'shield', }},'winner', 'version', {true,{'data','event', 'intParams', 'strParams', }},}},}
		}
	end,
	[1034] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[288] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'b', 's', 'b', 'v4', }},},
			{{true,{'buttonShowInfos','openWelfare', 'welfareUrl', 'isShowRed', 'type', }},}
		}
	end,
	[5215] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','v4', 'v4', }},{true,{'v4','v4', 'v4', 'v4', }},{true,{'v4','v4', 'v4', }},'v4', 'v4', 'v8', 'v4', 'v4', 'v4', },
			{{true,{'catList','ct','id', 'level', 'exp', 'status', 'taskId', 'creatAt', }},{true,{'formulaList','ct','id', 'level', 'exp', 'creatAt', 'num', }},{true,{'maidList','ct','id', 'creatAt', }},{true,{'taskList','ct','id', 'stime', 'etime', }},{true,{'toyList','ct','id', 'etime', }},'totalCat', 'totalNum', 'total', 'triggerTime', 'maidId', 'count', }
		}
	end,
	[3585] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 's', 's', 's', 's', }},},
			{{true,{'billBoardNotice','type', 'index', 'tag', 'title', 'content', 'contextImg', 'param', }},}
		}
	end,
	[5190] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v8', }},},
			{{true,{'voteInfo','itemId', 'total', }},}
		}
	end,
	[5188] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', }},},
			{{true,{'rankList','playerId', 'playerName', 'playerLv', 'fightPower', 'rank', 'headId', 'headFrame', 'unionId', 'unionName', }},{false,{'selfRank','playerId', 'playerName', 'playerLv', 'fightPower', 'rank', 'headId', 'headFrame', 'unionId', 'unionName', }},}
		}
	end,
	[6677] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', },
			{'score', }
		}
	end,
	[279] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[25612] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'progressList','pid', 'progress', }},}
		}
	end,
	[25604] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},},
			{{false,{'netFrame','index', {true,{'operateFrame','pid', 'keyCode', 'keyEvent', 'keyEventEx', 'posX', 'posY', 'dir', 'hp', 'sp', }},{true,{'dataFrame','pid', 'action', }},{true,{'bossFrame','id', 'posX', 'posY', 'dir', 'hp', 'operate', 'sp', }},{true,{'aiFrame','id', 'pid', 'lastStep', 'curStep', 'funcID', 'param1', 'param2', 'param3', }},}},}
		}
	end,
	[1027] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[282] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', 'v4', },
			{'status', 'content', 'errCode', }
		}
	end,
	[7812] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'tv4', 'v8', 'v4', }},'b', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{false,{'task','id', 'state', 'heroId', 'startTime', 'cabinId', }},'bigAward', {true,{'rewards','id', 'num', }},{true,{'extRewards','id', 'num', }},}
		}
	end,
	[8506] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},{false,{'v4', 'v4', }},},
			{{true,{'fdAward','dungeon', 'status', }},{true,{'passAward','dungeon', 'status', }},{false,{'dmgAward','awardIndex', 'status', }},}
		}
	end,
	[1285] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', }},},
			{{true,{'Rolestatus','roleId', 'status', }},}
		}
	end,
	[9411] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'ts', },
			{{true,{'rewardsMsg','id', 'num', }},'takeList', }
		}
	end,
	[6814] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'dayRecord','difficulty', 'count', }},{true,{'weekRecord','difficulty', 'count', }},}
		}
	end,
	[2074] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'freeSpeedNum', 'speedNum', }
		}
	end,
	[5145] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 's', 's', }},},
			{{true,{'configList','id', 'month', 'openTime', 'eventGroup', 'extendData', }},}
		}
	end,
	[257] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {false,{'v4', 's', 'v4', 'v8', 'v4', 'v8', 'v4','s', 'v4', {true,{'v4','v4', }},'b', 's', 's', 'tv4', 'v4', 'v4', {false,{{true,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},'v4', 'v4', }},'v4', 's', 'v4', 'v4', 'v4', }},'v4', 'v4', },
			{'serverTime', {false,{'playerinfo','pid', 'name', 'lvl', 'exp', 'vip_lvl', 'vip_exp', 'language','remark', 'helpFightHeroCid', {true,{'attr','attrKey','attrVal', }},'isFirstLogin', 'clientDiscreteData', 'settings', 'recoverTimeList', 'portraitCid', 'portraitFrameCid', {false,{'element',{true,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},'rank', 'totleTrophy', }},'unionId', 'unionName', 'titleId', 'createTime', 'famousExp', }},'queue', 'queueTime', }
		}
	end,
	[4869] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'eTypes','elementType', 'type', }},}
		}
	end,
	[9410] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6503] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', {true,{'s', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},'v4', 'v4', },
			{'rankType', {true,{'ranks','rank', 'playerId', 'playerName', 'score', 'headIcon', 'helpFightHeroId', 'level', 'frameCid', 'groupRank', {true,{'rankPlayerInfo','playerName', 'playerId', 'level', 'frameCid', 'headIcon', 'helpFightHeroId', 'heroId', }},}},'myRank', 'myScore', }
		}
	end,
	[9001] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', 'v8', 'v4', 'v8', 'v4', 'v4', {true,{'v4', 'v4', 'v8', 'v8', 'v4', 'v4', {true,{'v4', 'v4', 'v8', }},{true,{'v4', }},{true,{'v4', 'v4', }},{true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},}},{true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},},
			{'supAwardTime', 'supAwardTimes', 'refreshTimes', 'refreshTime', 'completeStronghold', 'useSupTimes', {true,{'stronghold','id', 'state', 'startTime', 'endTime', 'useSupTimes', 'progress', {true,{'event','id', 'state', 'startTime', }},{true,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},{true,{'supportRole','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},}},{true,{'supportRole','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},}
		}
	end,
	[5152] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 's', },
			{'actType', 'actId', 'jsonData', }
		}
	end,
	[4378] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', 'v4', 'v4', 'b', 'b', 'b', {true,{'v4', 's', 'v4', 'v4', 'b', 'v4', 'v4', }},}},},
			{{false,{'teamInfo','teamId', 'createTime', 'giftId', 'isShow', 'isComplete', 'isDestroy', {true,{'members','playerId', 'playerName', 'titleId', 'level', 'isCreator', 'portraitCid', 'portraitFrameId', }},}},}
		}
	end,
	[7004] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4',},
			{'cid', 'ct',}
		}
	end,
	[291] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', },
			{'dayBackground', 'nightBackground', 'dayBGM', 'nightBGM', }
		}
	end,
	[7845] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1826] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},},
			{{false,{'linkHero','heroId', 'level', 'exp', 'desire', 'index', {true,{'attrs','attributeId', 'value', }},}},}
		}
	end,
	[6215] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},{true,{'v4','s', 'v4', 'v4', }},{true,{'v4','s', 'v4', 'v4', }},}},},
			{'x', 'y', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},{true,{'treasures','ct','id', 'cid', 'star', }},{true,{'exploreEquip','ct','id', 'cid', 'level', }},}},}
		}
	end,
	[4097] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v4', }},},
			{{true,{'taks','ct','id', 'cid', 'progress', 'status', }},}
		}
	end,
	[9007] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'taskId', 'goodId', 'count', }
		}
	end,
	[7822] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'tv4', 'v8', 'v4', },
			{'id', 'state', 'heroId', 'startTime', 'cabinId', }
		}
	end,
	[7216] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},{true,{'v4','s', 'v4', 'v4', }},{true,{'v4','s', 'v4', 'v4', }},}},},
			{{false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},{true,{'treasures','ct','id', 'cid', 'star', }},{true,{'exploreEquip','ct','id', 'cid', 'level', }},}},}
		}
	end,
	[5169] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5177] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7505] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[2839] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},}
		}
	end,
	[9308] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5200] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'switch','type', 'value', }},}
		}
	end,
	[3341] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', }},},
			{{true,{'combination','id', 'isActive', }},}
		}
	end,
	[4355] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'cid', 'buyCount', }
		}
	end,
	[8301] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', 'v4', {false,{'v4', 'v4', 'v4', {true,{'s', 'v4', }},{true,{'s', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4', 'pv4', 'v4', 'b', 'v4', 'v4', }},}},'v4', 'tv4', }},{true,{'v4', 'v4', }},'b', 'v4', }},},
			{{false,{'info','step', 'historyBest', 'todayBest', 'seasonBalance', 'nextStepTime', {false,{'curCycle','segment', 'laderScore', 'cardPoint', {true,{'boundEquips','itemId', 'heroCid', }},{true,{'boundNewEquips','itemId', 'heroCid', }},{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},{true,{'heroCount','itemCid', 'count', }},{true,{'cardCount','itemCid', 'count', }},'usingCards', {true,{'levelInfos','battleScore', {false,{'levelInfo','cid', 'goals', 'fightCount', 'win', 'buyCount', 'freeCount', }},}},'battleScore', 'regionBuffs', }},{true,{'cardInfos','cardId', 'cardLv', }},'showTips', 'clientSeason', }},}
		}
	end,
	[7226] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv8', }},},
			{{true,{'events','eventCid', 'progress', }},}
		}
	end,
	[5301] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', },
			{'entityId', 'address', }
		}
	end,
	[5633] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'v4', {true,{'v4', 'b', }},{true,{'v4', 'v4', }},}},},
			{{false,{'info','datingType', 'datingValue', {true,{'bag','id', 'num', }},'endings', 'stepTime', {true,{'entrances','entranceId', 'guide', }},{true,{'quality','qualityId', 'value', }},}},}
		}
	end,
	[2832] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'isSuccess', }
		}
	end,
	[7807] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', 'v4', 'v4', 'v4', },
			{'id', 'cid', 'level', 'index', 'cabinId', }
		}
	end,
	[2829] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', 's', }},},
			{'equipmentId', {true,{'attrChange','index', 'value', }},}
		}
	end,
	[5171] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'activityId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[7106] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', }},}},},
			{{false,{'complteEvents','areaCid', {true,{'events','cid', 'num', }},}},}
		}
	end,
	[8004] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', },
			{'eventId', 'status', }
		}
	end,
	[8913] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},},
			{{true,{'voteInfo','day', 'clueVote', 'suspectVote', }},}
		}
	end,
	[3586] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'content', }
		}
	end,
	[8903] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'currentAreaId', }
		}
	end,
	[7837] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'shape', {true,{'attr','systemId', 'fightPower', }},}
		}
	end,
	[5174] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4','v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},},
			{'activityId', {true,{'hangUpRoleInfo','ct','roleId', 'level', 'nextSettleTime', 'currentEventId', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[6146] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'isSuccess', }
		}
	end,
	[5211] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'b', }},'v4', },
			{'activityId', 'round', {true,{'asInfo','id', 'status', }},'roundNum', }
		}
	end,
	[272] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2820] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[7701] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'b', }},{false,{{false,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', 'tv4', }},}},'v4', 'v4', },
			{'stage', 'stageEnd', {true,{'cities','id', 'dungeon', 'resOpen', 'resCount', 'resStartTime', 'resUpTime', 'replace', 'replaceEnd', 'replaceGame', 'pass', }},{false,{'liftInfo',{false,{'base','id', 'round', 'dungeon', 'startTime', 'endTime', 'roundScore', 'totalScore', {true,{'dungeonList','key', 'value', }},'bestTime', }},{true,{'heroCount','key', 'value', }},{true,{'buyCount','key', 'value', }},'battleCount', {true,{'dungeonBuff','key', 'value', }},'roundBuff', {true,{'chosenBuff','liftId', 'buff', }},}},'map', 'totalScore', }
		}
	end,
	[5303] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 's', 'v4', 'v4', }},{true,{'v4', 's', 'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'b', 'v4', },
			{'id', {true,{'allCrazyDiamondRank','playerId', 'playerName', 'itemId', 'itemNum', }},{true,{'ownCrazyDiamondRank','playerId', 'playerName', 'itemId', 'itemNum', }},{true,{'rewards','id', 'num', }},'surplusDraw', 'isDraw', 'totalMoney', }
		}
	end,
	[5175] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'up', }
		}
	end,
	[5639] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', 'tv4', },
			{'activeOutsideIds', 'newOutsideIds', }
		}
	end,
	[2082] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2563] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {false,{'s', 'v4', 'v4', 'tv4', 'b', 'b', 'v4', 'tv4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'tv4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 's', }},{false,{'v4', 'v4', 'v4', 'v4', }},'s', 'v4', }},},
			{{true,{'stores','storeId', {false,{'store','icon', 'name', 'roleSet', 'showCurrency', 'autoRefreshCorn', 'manualRefresh', 'refreshCostId', 'refreshCostNum', 'openContVal', 'openContType', 'commoditySupplyType', 'showBeginTime', 'buyBeginTime', 'buyEndTime', 'showEndTime', 'rank', 'storeType', 'openTimeType', 'extra', }},{true,{'commoditys','id', 'grid', 'order', 'openContType', 'openContVal', 'buyBeginTime', 'buyEndTime', 'sellTimeType', 'limitType', 'batchBuy', 'serLimit', 'sellDescribtion', {true,{'goodInfo','id', 'num', }},'priceType', 'priceVal', 'des', 'title', 'tag', 'autoRefreshCorn', 'showBeginTime', 'showEndTime', 'limitVal', 'extra', }},{false,{'storeRefresh','todayRefreshCount', 'totalRefreshCount', 'nextRefreshTime', 'freeNum', }},'pic', 'groupRefreshTime', }},}
		}
	end,
	[9204] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2083] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'manualId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6664] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'b', 's', 's', 'v4', 'b', }},},
			{{false,{'union','id', 'name', 'level', 'icon', 'memberCount', 'memberCountMax', 'active', 'limitLevel', 'limitPower', 'apply', 'canApply', 'leaderName', 'notice', 'country', 'showCountry', }},}
		}
	end,
	[5383] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'b', },
			{{true,{'rewards','id', 'num', }},'nonstop', }
		}
	end,
	[289] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'b', 's', 'b', 'v4', }},},
			{{true,{'buttonShowInfos','openWelfare', 'welfareUrl', 'isShowRed', 'type', }},}
		}
	end,
	[1031] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[4870] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[8304] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},},
			{{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},}
		}
	end,
	[6705] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'fireworkId', 'randomSeed', {true,{'rewards','id', 'num', }},}
		}
	end,
	[1037] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', },
			{'heroId', 'angelLvl', }
		}
	end,
	[5127] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 's', 's', 's', 's', 'v4', 'v4', }},},
			{{true,{'items','id', 'type', 'name', 'details', 'target', 'reward', 'extendData', 'rank', 'subType', }},}
		}
	end,
	[5151] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},'tv4', },
			{{false,{'speedLink','location', 'id', }},'remove', }
		}
	end,
	[5135] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4',{true,{'v4', {true,{'v4', 'v4', }},}},'tv4', {true,{'v4', 'v4', 'v4', }},},
			{'ct',{true,{'drawRecord','drawId', {true,{'drawRecord','itemId', 'num', }},}},'drawId', {true,{'dating','type', 'winNum', 'loseNum', }},}
		}
	end,
	[7832] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', },
			{'id', 'index', }
		}
	end,
	[1568] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 's', 'v4', 'v4', },
			{'roleId', 'type', 'jsonList', 'page', 'totlaPage', }
		}
	end,
	[6609] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},{true,{'mapBoxes','location', 'eventCid', }},}
		}
	end,
	[5222] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {false,{'v4', 'v4', }},},
			{'index', {false,{'reward','id', 'num', }},}
		}
	end,
	[5157] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'tv4', },
			{{true,{'cardInfo','pos', 'id', }},'ids', }
		}
	end,
	[8902] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[296] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{{false,{'v4','v4', 'v4', 'ts', }},'v4', 's', }},},
			{{true,{'formations',{false,{'base','ct','type', 'status', 'stance', }},'id', 'desc', }},}
		}
	end,
	[5904] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5898] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', {true,{'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', },
			{'teamId', 'leaderPid', {true,{'members','pid', 'status', 'heroCid', 'name', 'plv', 'skinCid', 'heroLevel', 'heroQuality', 'titleId', 'unionName', 'fightPower', }},'status', 'teamType', 'battleId', 'show_type', 'level_limit', }
		}
	end,
	[8305] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},},
			{{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},}
		}
	end,
	[1032] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[3091] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4',}},}},{true,{'v4', 'v4', }},},
			{{false,{'friendHelpInfo','playerId', 'playerName', 'portraitCid', 'portraitFrameCid', 'level', {true,{'taskInfos','taskId', 'status',}},}},{true,{'rewardItems','id', 'num', }},}
		}
	end,
	[1048] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4',}},},
			{{true,{'tasks','id', 'status',}},}
		}
	end,
	[7827] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1565] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 's', },
			{'roleId', 'page', 'jsonList', }
		}
	end,
	[1550] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', },
			{'roleId', 'datingRuleCid', }
		}
	end,
	[260] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7706] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'buyCount','key', 'value', }},}
		}
	end,
	[5186] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[9104] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'morale', }
		}
	end,
	[9230] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'id', }
		}
	end,
	[2831] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'isSuccess', }
		}
	end,
	[7105] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'worldCid', }
		}
	end,
	[1539] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},'v4', 'tv4', 'v4', 'b', }},'pv4', 'pv4', {true,{'v4','s', 'pv4', 'v4', 'v4', 'v4', 'b', }},{true,{'v4', 'tv4', }},'v4', {true,{'v4', 'tv4', }},},
			{{true,{'notFinishDating','score', 'datingType', 'currentNodeId', {true,{'branchNodes','datingId', 'nextNodeIds', }},'selectedNode', 'roleCid', 'datingRuleCid', 'isFirst', }},'datingRuleCid', 'endings', {true,{'cityDatingInfoList','ct','cityDatingId', 'datingTimeFrame', 'datingRuleCid', 'date', 'state', 'inDating', }},{true,{'triggerDating','roleId', 'datingRuleCid', }},'weChatSendTime', {true,{'favorAward','roleId', 'awardId', }},}
		}
	end,
	[3331] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'v4', },
			{{true,{'item','id', 'num', }},'zPointType', }
		}
	end,
	[7801] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', {true,{'s', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', 'tv4', 'v8', 'v4', }},{true,{'v4', 'v4', }},'v4', {true,{'v4', 's', }},}},'v4', },
			{{true,{'exploreCabin','id', 'cid', 'holeCount', {true,{'equip','id', 'cid', 'level', 'index', 'cabinId', }},{true,{'task','id', 'state', 'heroId', 'startTime', 'cabinId', }},{true,{'driver','index', 'heroId', }},'fightPower', {true,{'treasure','index', 'uuid', }},}},'skinId', }
		}
	end,
	[5148] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6615] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5379] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'nextLevelCid', {true,{'rewards','id', 'num', }},}
		}
	end,
	[4387] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', },
			{'signDays', 'canSign', {true,{'basrReward','id', 'num', }},{true,{'specialReward','id', 'num', }},'etime', }
		}
	end,
	[7204] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'formation', }
		}
	end,
	[6910] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'apInfo','value', 'limit', }},}
		}
	end,
	[5165] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[6657] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'buildingId', 'targetLevel', }
		}
	end,
	[5159] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},'tv4', {true,{'v4', 'v4', }},},
			{{false,{'cardInfo','pos', 'id', }},'cardId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[9354] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'info','pid', 'pName', 'headId', 'frameId', 'rank', 'rounds', 'lvl', }},{false,{'self','pid', 'pName', 'headId', 'frameId', 'rank', 'rounds', 'lvl', }},}
		}
	end,
	[1035] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},},
			{{false,{'hero','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},}
		}
	end,
	[6803] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', },
			{'changeType', 'pid', 'heroCid', 'skinCid', 'effectId', 'roomType', }
		}
	end,
	[6713] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'tv4', 'tv4', },
			{'game', 'group', 'result', 'pool', }
		}
	end,
	[3003] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[9355] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v8', },
			{'rewardId', 'nextRefreshTime', }
		}
	end,
	[7901] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'b', 'b', 'b', 'v4', 'v4','v4', 'b', }},},
			{{true,{'recommendList','playerId', 'portraitCId', 'name', 'fightPower', 'level', 'lastLoginTime', 'online', 'portraitFrameCId', 'isFriend', 'isUnion', 'finished', 'type', 'ct','famousExp', 'hasGift', }},}
		}
	end,
	[2331] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{'unionId', {true,{'msgs','channel', 'fun', 'content', 'pid', 'pname', 'lvl', 'helpFightHeroCid', 'portraitCid', 'portraitFrameCid', 'titleId', 'chatFrameCid', }},}
		}
	end,
	[516] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'itemList','id', 'num', }},{true,{'recoverProfit','id', 'num', }},}
		}
	end,
	[258] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4',},
			{'type',}
		}
	end,
	[8705] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[263] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 's', 's', 's', 's', }},},
			{{true,{'info','id', 'inx', 'type', 'tag', 'title', 'context', 'contextImg', }},}
		}
	end,
	[8707] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'num', }
		}
	end,
	[9206] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', 'v4', 'v4', 's', },
			{'randomDress', 'leftFreeCount', 'leftCount', 'nextRestTime', }
		}
	end,
	[6820] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', },
			{'roomType', 'ext', }
		}
	end,
	[8702] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', }},},
			{{true,{'list','pid', 'pName', 'headId', 'headFrame', 'level', 'fightPower', 'round', 'prize', 'sid', 'channel', }},}
		}
	end,
	[5182] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'rankList','playerId', 'playerName', 'playerLv', 'score', 'rank', 'headId', }},{false,{'selfRank','playerId', 'playerName', 'playerLv', 'score', 'rank', 'headId', }},}
		}
	end,
	[5153] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', {true,{'s', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},'v4', 'v4', },
			{'activityId', {true,{'ranks','rank', 'playerId', 'playerName', 'score', 'headIcon', 'helpFightHeroId', 'level', 'frameCid', 'groupRank', {true,{'rankPlayerInfo','playerName', 'playerId', 'level', 'frameCid', 'headIcon', 'helpFightHeroId', 'heroId', }},}},'myRank', 'myScore', }
		}
	end,
	[5183] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','itemCid', 'totalNum', }},}
		}
	end,
	[7903] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[8704] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[1814] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'pv4', 'v4', 'b', 'v4', 'v4', }},}},{false,{{true,{'s', 'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},'v4', 'v4', }},}},},
			{{false,{'levelInfos',{true,{'levelInfos','cid', 'goals', 'fightCount', 'win', 'buyCount', 'freeCount', }},}},{false,{'groups',{true,{'group','id', 'cid', 'fightCount', 'buyCount', {true,{'rewardInfo','key', 'list', }},'mainLineCid', 'maxMainLine', }},}},}
		}
	end,
	[2562] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'goods','id', 'num', }},}
		}
	end,
	[7404] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'datingCid', }
		}
	end,
	[8801] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'type', {true,{'rewards','id', 'num', }},}
		}
	end,
	[8403] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirit','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
		}
	end,
	[7210] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'ambushId', }
		}
	end,
	[7401] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v8', }},},
			{'circleMinu', {true,{'rankInfo','roleid', 'privity', }},}
		}
	end,
	[7224] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'b', }},},
			{{false,{'eventInfo','x', 'y', 'add', }},}
		}
	end,
	[9307] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'v4',},
			{{true,{'reward','id', 'num', }},'status',}
		}
	end,
	[2844] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7228] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'tv4', }},},
			{{false,{'gameInfo','eventCid', 'gameCid', 'options', }},}
		}
	end,
	[7830] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'id', }
		}
	end,
	[8803] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', 'tv4', 's', },
			{'personalRecord', 'serverRecord', 'serverScore', }
		}
	end,
	[6652] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', },
			{'operType', 'targets', }
		}
	end,
	[5651] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'favorDatingId', 'statue', }
		}
	end,
	[6914] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', 'b', },
			{'stepInfo', 'open', }
		}
	end,
	[5223] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6650] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 's', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4',}},{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4','v8', 'tv4', }},'b', 'b', 'b', 'v4', 'v4', 'v8', 'v4', 'tv4', 'v4', 'v4', 'v4', 'b', {true,{'v4', 'v4', }},}},},
			{'succ', {false,{'union','id', 'name', 'level', 'icon', 'memberCount', 'exp', 'leaderName', 'notice', {true,{'applyList','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'ct',}},{true,{'members','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'degree', 'weekContribution', 'allContribution', 'ct','joinTime', 'groupGiftIds', }},'canApply', 'autoJoin', 'joinLimit', 'limitLevel', 'limitPower', 'delateEndTime', 'weekExp', 'weekExpPrizeReceiveIndex', 'lastWeekActive', 'receiveTimes', 'country', 'showCountry', {true,{'redpackettimes','type', 'num', }},}},}
		}
	end,
	[6655] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'index', {true,{'rewards','id', 'num', }},}
		}
	end,
	[297] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{false,{'v4','v4', 'v4', 'ts', }},'v4', 's', }},},
			{{false,{'formation',{false,{'base','ct','type', 'status', 'stance', }},'id', 'desc', }},}
		}
	end,
	[7303] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', },
			{'id', 'result', }
		}
	end,
	[6654] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', },
			{'type', 'param', }
		}
	end,
	[6651] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'b', 's', 's', 'v4', 'b', }},},
			{{true,{'union','id', 'name', 'level', 'icon', 'memberCount', 'memberCountMax', 'active', 'limitLevel', 'limitPower', 'apply', 'canApply', 'leaderName', 'notice', 'country', 'showCountry', }},}
		}
	end,
	[6675] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'myUnionRank','id', 'name', 'icon', 'recallScore', 'recallNum', 'rank', }},{true,{'recallRank','id', 'name', 'icon', 'recallScore', 'recallNum', 'rank', }},}
		}
	end,
	[5225] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1816] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'cids', }
		}
	end,
	[8905] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4','v4', 'b', 'v4', 'tv4', 'b', }},'tv4', },
			{{true,{'chapterInfo','chapterId', 'status','currentAreaId', 'isNewChapter', 'currentEvtId', 'saveEvtId', 'first', }},'rewardGame', }
		}
	end,
	[7306] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v8', 'v4', {true,{'v4', 'v4', }},},
			{'senderId', 'createTime', 'id', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6154] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'tv4', }},'v4', },
			{{true,{'buff','playerId', 'buffId', 'canUseBuff', }},'functionType', }
		}
	end,
	[6653] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'degree', 'target', }
		}
	end,
	[6801] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 'v4', {false,{'v4', 'v4', 'v4', 'v4', }},'v4', 'v4', }},{true,{'v4', 's', {false,{'v4', 'v4', 'v4', 'v4', }},'s', }},'v4', },
			{{true,{'playerInfos','pid', 'pname', 'level', 'heroCid', 'skinCid', 'unionId', 'unionName', 'titleId', {false,{'pos','x', 'y', 'dir', 'dt', }},'buildId', 'effectId', }},{true,{'roomDecorate','decorateId', 'pid', {false,{'pos','x', 'y', 'dir', 'dt', }},'ext', }},'roomType', }
		}
	end,
	[3077] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6662] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 's', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4',}},{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4','v8', 'tv4', }},'b', 'b', 'b', 'v4', 'v4', 'v8', 'v4', 'tv4', 'v4', 'v4', 'v4', 'b', {true,{'v4', 'v4', }},}},},
			{{false,{'union','id', 'name', 'level', 'icon', 'memberCount', 'exp', 'leaderName', 'notice', {true,{'applyList','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'ct',}},{true,{'members','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'degree', 'weekContribution', 'allContribution', 'ct','joinTime', 'groupGiftIds', }},'canApply', 'autoJoin', 'joinLimit', 'limitLevel', 'limitPower', 'delateEndTime', 'weekExp', 'weekExpPrizeReceiveIndex', 'lastWeekActive', 'receiveTimes', 'country', 'showCountry', {true,{'redpackettimes','type', 'num', }},}},}
		}
	end,
	[6813] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'index', 'restTime', }
		}
	end,
	[5136] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},'tv4', 'v4', 'v4', 'tv4', },
			{'type', {true,{'rewards','id', 'num', }},'infomation', 'winNum', 'loseNum', 'winType', }
		}
	end,
	[6663] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 's', {true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},},
			{{true,{'record','playerId', 'playerName', {true,{'rewards','id', 'num', }},'leaderCid', 'portraitCid', 'portraitFrameCid', }},}
		}
	end,
	[2071] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv4', }},{true,{'v8', 'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', }},'v4', },
			{{true,{'buildinginfos','buildingId', 'buildingFuns', }},{true,{'roleInRooms','dressId', 'buildingId', 'cityRoleId', }},{true,{'remindEvents','buildingId', 'funId', 'exeId', 'eventType', }},'dayType', }
		}
	end,
	[6659] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'id', }
		}
	end,
	[6669] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'tv4', 'v4', 'tv4', },
			{'theme', 'remain', 'remainTimes', 'receivePrizeIndex', 'score', 'selfTrainPrizeIndex', }
		}
	end,
	[7909] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[6800] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 's', 'v4', 'v4', },
			{'roomId', 'fightServerHost', 'fightServerPort', 'roomType', }
		}
	end,
	[518] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'v4', },
			{'preNum', 'afterNum', 'roleId', 'itemId', 'state', }
		}
	end,
	[6661] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v8', 's', 'v4', {true,{'s', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'redPacketDetailInfo','id', 'blessing', 'count', 'senderId', 'createTime', 'senderName', 'moneyTempId', {true,{'record','playerId', 'playerName', 'openCount', 'leaderCid', 'portraitCid', 'portraitFrameCid', 'createTime', }},'status', 'senderLeaderCid', 'senderPortraitCid', 'senderPortraitFrameCid', }},}
		}
	end,
	[2305] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'time', }
		}
	end,
	[9013] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v8', 'v8', 'v4', 'v4', {true,{'v4', 'v4', 'v8', }},{true,{'v4', }},{true,{'v4', 'v4', }},{true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},}},},
			{{false,{'stronghold','id', 'state', 'startTime', 'endTime', 'useSupTimes', 'progress', {true,{'event','id', 'state', 'startTime', }},{true,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},{true,{'supportRole','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},}},}
		}
	end,
	[6672] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'index', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6673] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'index', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6674] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1286] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', }},},
			{{true,{'infos','roleId', 'mood', }},}
		}
	end,
	[6658] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'rewards','id', 'num', }},}
		}
	end,
	[9401] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'coin','id', 'num', }},}
		}
	end,
	[5377] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', {false,{{true,{'v4', 'v4', }},}},}},},
			{{false,{'info','step', 'historyBest', 'todayBest', 'todayCostTime', 'nextStepTime', 'curStage', 'nonStopStage', {false,{'heroHealth',{true,{'heroHealth','heroCid', 'health', }},}},}},}
		}
	end,
	[9231] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'clubInfo','id', 'exp', 'submitTimes', 'expLimit', }},}
		}
	end,
	[6667] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4',}},},
			{{true,{'applyInfo','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'ct',}},}
		}
	end,
	[7707] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'map', }
		}
	end,
	[6666] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4','v8', 'tv4', }},},
			{{true,{'member','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'degree', 'weekContribution', 'allContribution', 'ct','joinTime', 'groupGiftIds', }},}
		}
	end,
	[5634] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', },
			{'datingType', 'first', }
		}
	end,
	[5212] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'b', {true,{'v4', 'v4', }},},
			{'activityId', 'count', 'open', {true,{'rewards','id', 'num', }},}
		}
	end,
	[9101] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'tv4', 'v4', },
			{'id', 'type', 'showTime', 'buffIds', 'morale', }
		}
	end,
	[5179] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[8313] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'cardCount','itemCid', 'count', }},}
		}
	end,
	[9015] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', 'v8', 'v4', 'v8', 'v4', 'v4', },
			{'supAwardTime', 'supAwardTimes', 'refreshTimes', 'refreshTime', 'completeStronghold', 'useSupTimes', }
		}
	end,
	[9003] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v8', 'v8', 'v4', 'v4', {true,{'v4', 'v4', 'v8', }},{true,{'v4', }},{true,{'v4', 'v4', }},{true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},}},'v4', },
			{{false,{'stronghold','id', 'state', 'startTime', 'endTime', 'useSupTimes', 'progress', {true,{'event','id', 'state', 'startTime', }},{true,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},{true,{'supportRole','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},}},'useSupTimes', }
		}
	end,
	[9107] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v8', 's', }},{false,{'v4', 'v4', 'v8', 's', }},'v4', 'v4', },
			{{true,{'unionDamage','rank', 'unionId', 'damage', 'unionName', }},{false,{'myUnionDamage','rank', 'unionId', 'damage', 'unionName', }},'type', 'damage', }
		}
	end,
	[6223] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},'v4', },
			{{true,{'points','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},'eventRefresh', }
		}
	end,
	[4382] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'teamId', }
		}
	end,
	[2823] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'b', 's', },
			{'success', 'isLock', 'equipmentId', }
		}
	end,
	[1808] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},}},'v4', {false,{'v4','v4', 'v4', 'ts', }},},
			{{true,{'heros','limitId', {false,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},}},'leveId', {false,{'limitFormation','ct','type', 'status', 'stance', }},}
		}
	end,
	[1796] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'pv4', 'v4', 'b', 'v4', 'v4', }},}},{false,{{true,{'s', 'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},'v4', 'v4', }},}},},
			{{false,{'levelInfos',{true,{'levelInfos','cid', 'goals', 'fightCount', 'win', 'buyCount', 'freeCount', }},}},{false,{'groups',{true,{'group','id', 'cid', 'fightCount', 'buyCount', {true,{'rewardInfo','key', 'list', }},'mainLineCid', 'maxMainLine', }},}},}
		}
	end,
	[5894] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', 'v4', {true,{'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'team','teamId', 'leaderPid', {true,{'members','pid', 'status', 'heroCid', 'name', 'plv', 'skinCid', 'heroLevel', 'heroQuality', 'titleId', 'unionName', 'fightPower', }},'status', 'teamType', 'battleId', 'show_type', 'level_limit', }},}
		}
	end,
	[4386] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7844] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[2837] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},},
			{{false,{'gem','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}
		}
	end,
	[5224] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'taskId', 'etime', }
		}
	end,
	[1554] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},'v4', },
			{'datingRuleCid', {true,{'rewards','id', 'num', }},'outTime', }
		}
	end,
	[5890] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'status', }
		}
	end,
	[6103] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', },
			{'id', 'verify', }
		}
	end,
	[5892] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7705] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'tv4', }},},
			{{true,{'dungeonBuff','key', 'value', }},{true,{'chosenBuff','liftId', 'buff', }},}
		}
	end,
	[5895] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'type', }
		}
	end,
	[2312] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5897] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[8605] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},},
			{{true,{'exhaustions','hero', 'exhaustion', 'nextTime', }},}
		}
	end,
	[5896] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5889] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', 'v4', {true,{'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'team','teamId', 'leaderPid', {true,{'members','pid', 'status', 'heroCid', 'name', 'plv', 'skinCid', 'heroLevel', 'heroQuality', 'titleId', 'unionName', 'fightPower', }},'status', 'teamType', 'battleId', 'show_type', 'level_limit', }},}
		}
	end,
	[5162] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'langugeSign', }
		}
	end,
	[1560] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5170] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'activityId', 'hangUpEventId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[7843] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv4', }},},
			{{true,{'taskPlan','taskId', 'heroId', }},}
		}
	end,
	[5903] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'rank', }
		}
	end,
	[6701] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6604] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'records', }
		}
	end,
	[5900] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', },
			{'pid', 'name', }
		}
	end,
	[5901] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', {true,{'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', 'v4', },
			{{true,{'teamInfo','teamId', 'leaderPid', {true,{'members','pid', 'status', 'heroCid', 'name', 'plv', 'skinCid', 'heroLevel', 'heroQuality', 'titleId', 'unionName', 'fightPower', }},'status', 'teamType', 'battleId', 'show_type', 'level_limit', }},'teamType', 'nextTime', }
		}
	end,
	[1029] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v8', 'v4', },
			{'id', 'exp', 'cid', }
		}
	end,
	[5902] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'showType', }
		}
	end,
	[5191] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'itemId', }
		}
	end,
	[2079] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},{false,{'v4', {true,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},'v4', 'v8', }},},
			{{false,{'jobEvent','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},{false,{'jobList','buildingId', {true,{'jobInfos','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},'level', 'exp', }},}
		}
	end,
	[9402] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'reward','id', 'num', }},}
		}
	end,
	[8915] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5216] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', },
			{{false,{'cat','ct','id', 'level', 'exp', 'status', 'taskId', 'creatAt', }},'oldLevel', }
		}
	end,
	[5163] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', {true,{'v4', 'v4', 'b', 'v4', 'v4', 'b', 'v4', 'tv4', 'v4', 'v4', 'v4', 'b', 'b', }},},
			{'camp', 'stage', 'stageEnd', {true,{'cities','id', 'dungeon', 'resOpen', 'resCount', 'resUpTime', 'invaded', 'invadedEnd', 'invadedCamp', 'resStartTime', 'fightTime', 'score', 'pass', 'dunPass', }},}
		}
	end,
	[4096] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', {true,{'v4', 'v4', }},}},{true,{'v4', 'v4', }},},
			{{true,{'result','taskDbId', 'taskCid', {true,{'rewards','id', 'num', }},}},{true,{'rewards','id', 'num', }},}
		}
	end,
	[8150] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', 'b', 'v4', }},},
			{{true,{'systemTitleInfos','ct','titleId', 'effectTime', 'isEquip', 'createTime', }},}
		}
	end,
	[8152] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'id', }
		}
	end,
	[8701] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'v4', }},'s', 'v4', 'v4', },
			{{true,{'roundInfo','round', 'joinStatus', 'joinNum', }},'address', 'realPrize', 'realRound', }
		}
	end,
	[283] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'status', 'time', }
		}
	end,
	[6714] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', 'tv4', {true,{'v4', 'v4', }},},
			{'status', 'game', 'cases', {true,{'rewards','id', 'num', }},}
		}
	end,
	[9303] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'tv4', }},},
			{{false,{'roleAction','roleId', 'actionId', }},}
		}
	end,
	[7816] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},}},{true,{'v4', 'v4', }},},
			{{false,{'techTree','techType', 'nationId', {true,{'tech','techId', 'state', }},}},{true,{'rewards','id', 'num', }},}
		}
	end,
	[3340] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'b', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{false,{'info','noobStatus', 'endTime', 'summonCount', 'awardState', }},{true,{'item','id', 'num', }},}
		}
	end,
	[3333] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},'v4', },
			{{true,{'composeInfos','cid', 'finishTime', {true,{'items','id', 'num', }},'costTime', }},'freeNum', }
		}
	end,
	[6205] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},},
			{'x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}
		}
	end,
	[7502] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[7603] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'manaBagInfo','id', 'level', }},{true,{'manaEquipInfo','id', 'pos', }},}
		}
	end,
	[2822] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', },
			{'ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }
		}
	end,
	[3346] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', 'v4', 'v4', }},},
			{'cid', 'count', 'startTime', 'endTime', {true,{'statistics','id', 'num', 'count', 'probability', }},}
		}
	end,
	[6224] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'b', },
			{'x', 'y', 'add', }
		}
	end,
	[1555] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', 'v4', },
			{'msg', 'roleId', 'datingType', }
		}
	end,
	[4866] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},'v4', 'v4', },
			{{true,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},'rank', 'totleTrophy', }
		}
	end,
	[5138] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', 'v4', }},},
			{{true,{'rank','playerName', 'serverCount', 'ranking', }},}
		}
	end,
	[7704] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{false,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', 'tv4', }},}},},
			{{false,{'liftInfo',{false,{'base','id', 'round', 'dungeon', 'startTime', 'endTime', 'roundScore', 'totalScore', {true,{'dungeonList','key', 'value', }},'bestTime', }},{true,{'heroCount','key', 'value', }},{true,{'buyCount','key', 'value', }},'battleCount', {true,{'dungeonBuff','key', 'value', }},'roundBuff', {true,{'chosenBuff','liftId', 'buff', }},}},}
		}
	end,
	[1025] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},},
			{{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},}
		}
	end,
	[3349] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', {true,{'v4', {true,{'v4', 'v4', }},'b', }},}},'v4', {true,{'v4', 'v4', }},},
			{{true,{'simulateSummons','cid', 'simulateSummonCount', 'sysSimulateSummonCount', 'exchangeCount', {true,{'records','order', {true,{'items','id', 'num', }},'isReceive', }},}},'lastCid', {true,{'lastResult','id', 'num', }},}
		}
	end,
	[6501] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v8', {true,{'v4', {true,{'v4', 'v4', }},}},'v4', 'v8', 'v4', 'v4', 'tv4', 'v4', {true,{'v4', 'v4', }},'tv4', 'b', },
			{'bossDungeonId', 'serverContribution', {true,{'nodeStatus','contribution', {true,{'nodeRewards','id', 'num', }},}},'odeumType', 'closeTime', 'status', 'lingbo', 'lingboGroup', 'receiveStatus', {true,{'selfContriRewards','id', 'num', }},'selfContriPrizeStatus', 'fightState', }
		}
	end,
	[3329] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{false,{'b', 'v4', 'v4', 'v4', }},'tv4', 'v4', 'v4', {true,{'v4', 'v4', }},'v4', {false,{'v4', 'v4', 'v4', }},{false,{'v4', 'v4', 'v4', }},'v4', },
			{{true,{'item','id', 'num', }},{false,{'noobInfo','noobStatus', 'endTime', 'summonCount', 'awardState', }},'activeId', 'hotHeroSummonScore', 'hotEquipSummonScore', {true,{'fixItem','id', 'num', }},'id', {false,{'freeInfo','type', 'nextFreeTime', 'summonNums', }},{false,{'freeTime','type', 'nextFreeTime', 'summonNums', }},'preciousCount', }
		}
	end,
	[8510] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{false,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},{false,{'dmgAward','awardIndex', 'status', }},}
		}
	end,
	[6612] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'pv4', 'v4', 'b', 'v4', }},},
			{{false,{'curLevel','cid', 'goals', 'fightCount', 'win', 'buyCount', }},}
		}
	end,
	[6601] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2314] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'ts', },
			{'scrollId', 'params', }
		}
	end,
	[7301] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 's', 'v4', 'v4', 'v4', 's', 's', {true,{'v4', 'v4', }},'v4', }},},
			{{true,{'redEnvelopeInfo','ct','id', 'senderId', 'senderName', 'createTime', 'modifiedTime', 'status', 'title', 'body', {true,{'rewards','id', 'num', }},'mailType', }},}
		}
	end,
	[1551] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'datingRuleCid', }
		}
	end,
	[7304] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'result', {true,{'rewards','id', 'num', }},}
		}
	end,
	[3348] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'cid', 'dayTimes', }
		}
	end,
	[3355] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'itemCid', }
		}
	end,
	[3342] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'item','id', 'num', }},}
		}
	end,
	[7205] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},},
			{{false,{'mapPoint','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},}
		}
	end,
	[2065] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v8', 'v4', },
			{'eggPool', 'pollRefreshCdEndTime', 'eggPoolId', }
		}
	end,
	[8101] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', {true,{'v4', 'v4', }},{false,{'v4', {true,{'v4', 'v4', }},}},}},},
			{{true,{'cityInfo','changeType','cityId', {true,{'partInfo','cityPartId', 'state', }},{false,{'eventInfo','eventId', {true,{'rewards','id', 'num', }},}},}},}
		}
	end,
	[3345] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},'v4', },
			{{true,{'composeInfo','cid', 'finishTime', {true,{'items','id', 'num', }},'costTime', }},'freeNum', }
		}
	end,
	[9150] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},{false,{'v8', 'v4', 'v4', 'v4', 'tv4', }},'tv4', {false,{{true,{'v4', 'b', }},'v4', 'v4', 'v4', }},'v4', {false,{'v4', 'tv4', }},{true,{'v4','v4', 'b', 'v4', 'v4', {true,{'v4', 'v4', }},'s', }},},
			{{true,{'maidObjects','onlyId', 'cid', 'strength', }},{false,{'maidInfo','totle', 'customer', 'cost', 'turnOver', 'attributes', }},'workLists', {false,{'recruitInfo',{true,{'recruits','cid', 'state', }},'nextTime', 'recruitTimes', 'recruitBuyTimes', }},'enterType', {false,{'maidRole','roleId', 'roleList', }},{true,{'eventList','ct','id', 'reward', 'cfgId', 'creatAt', {true,{'rewards','id', 'num', }},'weather', }},}
		}
	end,
	[3343] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', },
			{'heroHotSummonOrder', 'heroHotSummonTime', 'equipHotSummonOrder', 'equipHotSummonTime', 'hotHeroSummonScore', 'hotEquipSummonScore', }
		}
	end,
	[2064] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'tv4', {true,{'v4', 'v4', }},},
			{'eggPool', 'eggIds', {true,{'rewards','id', 'num', }},}
		}
	end,
	[8201] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {false,{'v4', 'v4', 'v4', }},'tv4', },
			{'taskIndenture', {false,{'summonInfo','indenture', 'endTime', 'leftCount', }},'actIndentures', }
		}
	end,
	[2069] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'foodId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[3353] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},},
			{{true,{'freeInfo','type', 'nextFreeTime', 'summonNums', }},}
		}
	end,
	[6823] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 's', {false,{'v4', 'v4', 'v4', 'v4', }},'s', }},},
			{'roomType', {true,{'roomDecorate','decorateId', 'pid', {false,{'pos','x', 'y', 'dir', 'dt', }},'ext', }},}
		}
	end,
	[3339] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'info','cid', 'count', }},}
		}
	end,
	[519] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'originItem','id', 'num', }},{true,{'convertItem','id', 'num', }},}
		}
	end,
	[5227] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', {true,{'v4', 'v4', }},},
			{'success', 'formulaId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[25609] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', 'v4', }},'v4', },
			{'time', {true,{'data','pid', 'delayTime', }},'hostPlayerId', }
		}
	end,
	[6825] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {false,{'v4', 'v4', 'v4', 'v4', }},},
			{'roomType', {false,{'areaShowTime','decorateId', 'stime', 'etime', 'needToShow', }},}
		}
	end,
	[3347] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'cid', 'cardNum', {true,{'cardPrizes','id', 'num', }},}
		}
	end,
	[5226] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', {true,{'v4', 'v4', }},},
			{'success', 'formulaId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[1544] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[3354] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},},
			{{true,{'freeTimeSummon','type', 'nextFreeTime', 'summonNums', }},}
		}
	end,
	[8402] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirit','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
		}
	end,
	[3351] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', {true,{'v4', {true,{'v4', 'v4', }},'b', }},}},},
			{{false,{'simulateSummon','cid', 'simulateSummonCount', 'sysSimulateSummonCount', 'exchangeCount', {true,{'records','order', {true,{'items','id', 'num', }},'isReceive', }},}},}
		}
	end,
	[2311] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{'roomId', {true,{'msgs','channel', 'fun', 'content', 'pid', 'pname', 'lvl', 'helpFightHeroCid', 'portraitCid', 'portraitFrameCid', 'titleId', 'chatFrameCid', }},}
		}
	end,
	[9306] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[302] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewardInfo','id', 'num', }},}
		}
	end,
	[7809] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5130] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', {true,{'s', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},'v4', },
			{'activityId', {true,{'ranks','rank', 'playerId', 'playerName', 'score', 'headIcon', 'helpFightHeroId', 'level', 'frameCid', 'groupRank', {true,{'rankPlayerInfo','playerName', 'playerId', 'level', 'frameCid', 'headIcon', 'helpFightHeroId', 'heroId', }},}},'myRank', }
		}
	end,
	[6902] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'ap','value', 'limit', }},}
		}
	end,
	[9005] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},'v8', },
			{{true,{'role','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},'lastReqTime', }
		}
	end,
	[9152] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', }},},
			{{false,{'maidObject','onlyId', 'cid', 'strength', }},}
		}
	end,
	[303] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1046] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', 'v4', {true,{'v4', 'tv4', {true,{'v4', 'v4',}},}},},
			{'isOpen', 'startTime', 'endTime', {true,{'info','heroId', 'dungeonId', {true,{'tasks','id', 'status',}},}},}
		}
	end,
	[6821] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','v4', {true,{'v4', 's', {false,{'v4', 'v4', 'v4', 'v4', }},'s', }},},
			{'ct','roomType', {true,{'roomDecorate','decorateId', 'pid', {false,{'pos','x', 'y', 'dir', 'dt', }},'ext', }},}
		}
	end,
	[1540] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},'v4', 'tv4', 'b', 'v4', },
			{'score', 'favor', {true,{'rewards','id', 'num', }},'scriptId', 'starList', 'obsolete', 'endId', }
		}
	end,
	[9002] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', {true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},{true,{'v4', 'v4', }},},
			{'roleId', {true,{'supportHero','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},{true,{'buff','buffId', 'buffLv', }},}
		}
	end,
	[6911] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'v8', }},{true,{'v4', 'v8', }},'v4', },
			{{true,{'mainLogInfo','logId', 'finished', 'time', }},{true,{'minorInfo','logId', 'time', }},'type', }
		}
	end,
	[4385] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[4867] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},{true,{'v4', 'v4', }},},
			{{false,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},{true,{'rewardlist','id', 'num', }},}
		}
	end,
	[7100] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 's', 'v4', 'v4', 's', 'v4', 'v4', }},'v4', 'v4', {false,{'v4', 's', 'v4', 'v4', 'v4', 's', 'v4', 'v4', 's', 'v4', 'v4', }},},
			{{true,{'rankList','pid', 'pName', 'headId', 'frameId', 'rank', 'params', 'unionId', 'unionIcon', 'unionName', 'heroId', 'skinCid', }},'refreshMinu', 'type', {false,{'selfRank','pid', 'pName', 'headId', 'frameId', 'rank', 'params', 'unionId', 'unionIcon', 'unionName', 'heroId', 'skinCid', }},}
		}
	end,
	[7402] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[769] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[6915] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'open', }
		}
	end,
	[6815] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'b', 'b', {true,{'v4', 'v4', }},},
			{'isFighting', 'isShowResult', 'isWin', {true,{'rewards','id', 'num', }},}
		}
	end,
	[4353] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', },
			{'orderNo', 'goodsId', }
		}
	end,
	[6906] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'equipInfoList','position', 'equipId', }},}
		}
	end,
	[6917] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'scriptId', }
		}
	end,
	[4357] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', }},},
			{{true,{'info','ct','cid', 'buy_count', }},}
		}
	end,
	[5635] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', },
			{'datingType', 'datingValue', {true,{'items','id', 'num', }},{true,{'endItems','id', 'num', }},{true,{'costItems','id', 'num', }},{true,{'quality','qualityId', 'value', }},'stepEnd', 'endId', }
		}
	end,
	[9233] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'id', }
		}
	end,
	[5652] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'favorDatingId', 'statue', }
		}
	end,
	[9202] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', 'b', {true,{'v4', 'v4', }},},
			{'openIndex', {true,{'leftReward','id', 'num', 'total', }},'layer', 'freeCount', 'freeCountLimit', 'passIndex', 'passId', 'started', {true,{'passCount','passId', 'count', }},}
		}
	end,
	[8505] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},{true,{'passAward','dungeon', 'status', }},}
		}
	end,
	[7803] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', {true,{'s', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', 'tv4', 'v8', 'v4', }},{true,{'v4', 'v4', }},'v4', {true,{'v4', 's', }},}},{true,{'v4', 'v4', }},},
			{{false,{'exploreCabin','id', 'cid', 'holeCount', {true,{'equip','id', 'cid', 'level', 'index', 'cabinId', }},{true,{'task','id', 'state', 'heroId', 'startTime', 'cabinId', }},{true,{'driver','index', 'heroId', }},'fightPower', {true,{'treasure','index', 'uuid', }},}},{true,{'rewards','id', 'num', }},}
		}
	end,
	[5217] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','v4', 'v4', 'v4', 'v4', 'v4', }},'v4', },
			{{false,{'formula','ct','id', 'level', 'exp', 'creatAt', 'num', }},'oldLevel', }
		}
	end,
	[4375] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'reward','id', 'num', }},}
		}
	end,
	[8308] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', }},{true,{'s', 'v4', }},},
			{{true,{'boundEquips','itemId', 'heroCid', }},{true,{'boundNewEquips','itemId', 'heroCid', }},}
		}
	end,
	[6913] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6916] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[3093] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4',}},}},},
			{{false,{'friendHelpInfo','playerId', 'playerName', 'portraitCid', 'portraitFrameCid', 'level', {true,{'taskInfos','taskId', 'status',}},}},}
		}
	end,
	[6905] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'equipInfoList','position', 'equipId', }},}
		}
	end,
	[7702] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[273] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'players','pid', 'name', 'lvl', 'helpHeroCid', 'coldDownTime', 'helpHeroFightPower', 'portraitCid', }},}
		}
	end,
	[6912] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{false,{'v4', 'v4', }},{false,{'v4', 'v4', }},'tv4', },
			{{true,{'rewardInfo','id', 'num', }},{false,{'apItemInfo','id', 'num', }},{false,{'ap','value', 'limit', }},'script', }
		}
	end,
	[6907] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'orderList', }
		}
	end,
	[8311] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'card','cardId', 'cardLv', }},}
		}
	end,
	[5320] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', 'v4', 'v4', {true,{'v4', 'v4', }},'v4', },
			{'diceNum', 'moveTrack', 'eventId', 'chooseStatus', {true,{'reward','id', 'num', }},'totalCircel', }
		}
	end,
	[6908] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', 'b', },
			{'type', 'success', 'finished', }
		}
	end,
	[25605] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {true,{'v4', 'v4', 'b', }},{true,{'v4', 'v4', }},'v4', 'b', 'v8', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', },
			{'win', {true,{'results','pid', 'hurt', 'mvp', }},{true,{'rewards','id', 'num', }},'fightTime', 'isSpecial', 'huntingHonor', {true,{'goalResult','id', 'state', }},{true,{'extRewards','id', 'num', }},'extTips', }
		}
	end,
	[6502] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', },
			{'name', 'contribution', }
		}
	end,
	[3503] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'tv4', },
			{'activityId', 'refreshCount', 'summonedList', }
		}
	end,
	[5122] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'rewards','id', 'num', }},}
		}
	end,
	[5640] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'tv4', },
			{'datingType', 'datingValue', 'eventId', }
		}
	end,
	[2565] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {true,{'v4', 'v4', }},},
			{'success', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6812] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'newLeaderId', }
		}
	end,
	[6208] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'infections','heroId', 'infection', }},}
		}
	end,
	[4379] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'teamId', }
		}
	end,
	[1562] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', },
			{'roleId', 'intimacy', 'chatDays', 'hateVal', }
		}
	end,
	[2564] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'buyLogs','type', 'cid', 'nowBuyCount', 'totalBuyCount', 'storeState', }},}
		}
	end,
	[7506] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', 's', 'v4', 's', 'b', }},'v4','tv4', 'v4', 'v4', 'v4', 'v4', 'b', },
			{{true,{'springWishInfo','id', 'senderId', 'senderName', 'receiverId', 'content', 'read', }},'changeType','sendFriend', 'dayReceiveCount', 'totalReceiveCount', 'daySendCount', 'totalSendCount', 'getReward', }
		}
	end,
	[7503] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[1580] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'awardId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[2306] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 's', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', },
			{'channel', 'fun', 'content', 'pid', 'pname', 'lvl', 'helpFightHeroCid', 'portraitCid', 'portraitFrameCid', 'titleId', 'chatFrameCid', }
		}
	end,
	[7501] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'ts', {true,{'v4', 'v4', }},},
			{'result', 'word', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6709] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'activityId', 'score', }
		}
	end,
	[6703] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1036] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},'s', },
			{{false,{'hero','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},'beforeSkinId', }
		}
	end,
	[6708] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'activityId', 'refreshCount', }
		}
	end,
	[6702] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'v4', },
			{'nianBeastId', 'builingId', 'randomSeed', 'datingId', 'deadline', }
		}
	end,
	[9304] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', 'v4', {true,{'s', 'tv4', }},'v4', },
			{'pamphletLevel', 'finishedId', 'exp', {true,{'buff','name', 'value', }},'dayExp', }
		}
	end,
	[8408] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[2860] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 's', {true,{'v4', 'v4', }},},
			{'equipId', 'costEquipId', {true,{'items','id', 'num', }},}
		}
	end,
	[4001] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 's', 'v4', 'v4', 'v4', }},{true,{'v4', 's', 'v4', 's', 'v4', 'v4', 'v4', }},},
			{{true,{'newInfo','playerId', 'name', 'heroId', 'comment', 'prise', 'commentDate', 'itemId', }},{true,{'hotInfo','playerId', 'name', 'heroId', 'comment', 'prise', 'commentDate', 'itemId', }},}
		}
	end,
	[6214] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','itemId', 'itemNum', }},}
		}
	end,
	[5192] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'count', 'rewardLevel', {true,{'rewards','id', 'num', }},}
		}
	end,
	[8606] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},},
			{{true,{'dispatches','dungeonType', {true,{'fightPower','hero', 'fightPower', }},{true,{'dungeonInfo','dungeonCid', 'multiple', 'eTime', 'awardCount', 'runCount', 'maxCount', }},}},}
		}
	end,
	[4354] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2826] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', 's', }},},
			{'equipmentId', {true,{'attr','index', 'value', }},}
		}
	end,
	[6218] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'qliphothCoin', }
		}
	end,
	[2313] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{'channel', {true,{'msgs','channel', 'fun', 'content', 'pid', 'pname', 'lvl', 'helpFightHeroCid', 'portraitCid', 'portraitFrameCid', 'titleId', 'chatFrameCid', }},}
		}
	end,
	[274] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', {false,{{true,{'v4', 'pv4', }},}},'v4', }},'pv4', 'pv4', 'ts', },
			{{true,{'notMsgs','score', 'datingType', 'currentNodeId', {false,{'notes',{true,{'nodes','datingId', 'nextNodeIds', }},}},'selectedNode', }},'scriptIds', 'endings', 'xxxx', }
		}
	end,
	[7307] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v8', 's', 'v4', {true,{'s', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'redPacketDetailInfo','id', 'blessing', 'count', 'senderId', 'createTime', 'senderName', 'moneyTempId', {true,{'record','playerId', 'playerName', 'openCount', 'leaderCid', 'portraitCid', 'portraitFrameCid', 'createTime', }},'status', 'senderLeaderCid', 'senderPortraitCid', 'senderPortraitFrameCid', }},}
		}
	end,
	[2825] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'isOpen', }
		}
	end,
	[3336] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'tv4', 'tv4', }},'v4', 'tv4', 'v4', 'tv4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},{false,{'b', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', 'v4', }},},
			{{true,{'summonInfo','summonId', 'summstart', 'summend', 'startShow', 'endShow', {true,{'summonShow','count', 'itemId', 'itemNums', }},'summonNums', 'getRewards', 'count', 'equipRewards', 'remainScore', 'cardNum', 'dayTimes', {true,{'cardPrizes','id', 'num', }},'preciousCount', }},{false,{'noobInfo','noobStatus', 'endTime', 'summonCount', 'awardState', }},{true,{'personalSummons','summonType', 'summend', 'summonNums', }},}
		}
	end,
	[7219] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},},
			{{true,{'points','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},}
		}
	end,
	[8309] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'card','cardId', 'cardLv', }},}
		}
	end,
	[6671] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4','v8', 'tv4', }},},
			{{true,{'members','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'degree', 'weekContribution', 'allContribution', 'ct','joinTime', 'groupGiftIds', }},}
		}
	end,
	[7405] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'datingCids', }
		}
	end,
	[9305] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'location','chapterId', 'itemId', }},}
		}
	end,
	[2834] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {false,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},},
			{'id', {false,{'gem','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}
		}
	end,
	[3352] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{false,{'v4', 'v4', 'v4', 'v4', {true,{'v4', {true,{'v4', 'v4', }},'b', }},}},},
			{{true,{'rewards','id', 'num', }},{false,{'simulateSummon','cid', 'simulateSummonCount', 'sysSimulateSummonCount', 'exchangeCount', {true,{'records','order', {true,{'items','id', 'num', }},'isReceive', }},}},}
		}
	end,
	[6903] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'b', {true,{'v4', 'v4', 'b', }},}},'v4', },
			{{true,{'areaInfoList','areaId', 'isDevil', 'explored', {true,{'roadInfoList','startAreaId', 'endAreaId', 'unlocked', }},}},'currentAreaId', }
		}
	end,
	[5129] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', },
			{'activityId', 'process', 'myRank', 'realItemMinRank', }
		}
	end,
	[5121] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'tv4', 'v4', 'tv4', }},},
			{{true,{'signInfos','id', 'index', 'extendData', 'awardType', 'supplyLimit', 'supplyDays', }},}
		}
	end,
	[5161] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[6104] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5891] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[4370] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'tv4', },
			{'isGrowthFunds', 'awards', }
		}
	end,
	[25602] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'pids', }
		}
	end,
	[6102] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'rewards','id', 'num', }},}
		}
	end,
	[2830] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},},
			{'heroId', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},}
		}
	end,
	[3338] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'itemCid', }
		}
	end,
	[1561] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2316] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 's', 'v8', 'v4', 'v4', }},'v4', 'v4', },
			{{true,{'infos','playerName', 'content', 'sendTime', 'type', 'dialogueId', }},'type', 'version', }
		}
	end,
	[6816] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'result', }
		}
	end,
	[6216] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},{true,{'v4','s', 'v4', 'v4', }},{true,{'v4','s', 'v4', 'v4', }},}},},
			{{false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},{true,{'treasures','ct','id', 'cid', 'star', }},{true,{'exploreEquip','ct','id', 'cid', 'level', }},}},}
		}
	end,
	[8002] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', 'v4', }},'tv4', 'tv4', },
			{{false,{'turnInfo','extraTimes', 'turnIndex', {true,{'turnTimes','turnId', 'times', }},{true,{'effectInfo','cfgId', 'effectId', }},}},'times', {true,{'rewards','id', 'num', 'tag', }},'locations', 'eventLocations', }
		}
	end,
	[7910] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', 'tv4', },
			{'taskList', 'famousList', }
		}
	end,
	[1043] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', 'v4', }},'v4', },
			{'heroId', {true,{'attr','type', 'val', }},'fightPower', }
		}
	end,
	[1026] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', },
			{'ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }
		}
	end,
	[8006] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'buffId', }
		}
	end,
	[3073] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'b', 'v4','v4', 'v4', 'b', 'v4', 'v4', 'tv4', 'v4', }},'v4', 'v4', },
			{{true,{'friends','pid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'lastHandselTime', 'receive', 'status', 'leaderCid', 'online', 'ct','time', 'helpCDtime', 'canSend', 'portraitCid', 'portraitFrameCid', 'groupGiftIds', 'type', }},'receiveCount', 'lastReceiveTime', }
		}
	end,
	[1044] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {false,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},},
			{'heroId', {false,{'skillStrategy','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},}
		}
	end,
	[3010] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', }},'v4', },
			{{true,{'uiChange','ct','cid', }},'wearId', }
		}
	end,
	[1287] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1283] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','s', 'v4', 'v4', 'v4', 'v4', 'pv4', 'pv4', {false,{'v4','s', 'v4', 's', 'v4', }},'v4', 'b', 'v4', 'tv4', 'b', },
			{'ct','id', 'cid', 'favor', 'mood', 'status', 'unlockGift', 'unlockHobby', {false,{'dress','ct','id', 'cid', 'roleId', 'outTime', }},'roomId', 'favorCriticalPoint', 'roleState', 'favoriteIds', 'isShow', }
		}
	end,
	[1288] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5380] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'rankList','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},{false,{'rank','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},'refreshMinu', {true,{'lastCycleList','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},{false,{'lastCycleRank','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},{true,{'presentRankList','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},{false,{'presentRank','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},}
		}
	end,
	[520] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'cid', 'num', }
		}
	end,
	[1041] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {false,{'v4', 'v4', }},},
			{'heroId', {false,{'passiveSkillInfo','pos', 'skillId', }},}
		}
	end,
	[1039] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', 's', },
			{'heroId', 'skillStrategyId', 'name', }
		}
	end,
	[6220] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1281] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v4', 'v4', 'pv4', 'pv4', {false,{'v4','s', 'v4', 's', 'v4', }},'v4', 'b', 'v4', 'tv4', 'b', }},'tv4', 'b', },
			{{true,{'roles','ct','id', 'cid', 'favor', 'mood', 'status', 'unlockGift', 'unlockHobby', {false,{'dress','ct','id', 'cid', 'roleId', 'outTime', }},'roomId', 'favorCriticalPoint', 'roleState', 'favoriteIds', 'isShow', }},'rotationList', 'rotationState', }
		}
	end,
	[1289] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[4360] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{{false,{'v4', 'f4', }},'v4', 's', 's', 's', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 's', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 's', }},{true,{{false,{'v4', 'f4', }},'v4', {true,{'v4', 'v4', }},'s', 's', 'b', 's', 's', 's', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'pv4', {true,{'v4', 'v4', }},'s', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'v4', 'v4', 'v4', 'b', 'v4', 's', }},},
			{{true,{'monthCardCfg',{false,{'rechargeCfg','id', 'price', }},'upgradeId', 'icon', 'name', 'des1', {true,{'presentItem','id', 'num', }},{true,{'gainItem','id', 'num', }},'days', 'type', 'name2', 'des3', 'tagIcon', 'interfaceType', 'buyType', {true,{'exchangeCost','id', 'num', }},'packType', 'extendData', }},{true,{'rechargeGiftBagCfg',{false,{'rechargeCfg','id', 'price', }},'type', {true,{'item','id', 'num', }},'name', 'icon', 'tag', 'tagDes', 'tagDes2', 'des1', 'des2', 'order', 'startDate', 'endDate', 'buyCount', 'resetType', 'resetDate', 'playerLevel', {true,{'firstBuyItem','id', 'num', }},'name2', 'des3', 'tagIcon', 'interfaceType', 'buyType', {true,{'exchangeCost','id', 'num', }},'packType', 'originalPrice', 'discount', 'triggerEndDate', 'isTrigger', 'days', 'extendData', }},}
		}
	end,
	[1809] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', }},},
			{{true,{'multipleInfo','groupId', 'multiple', 'topStarsLevel', }},}
		}
	end,
	[1292] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'dressGroups','group', 'curDressId', }},}
		}
	end,
	[1284] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5205] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', 'v4', 'v4', 'v4', {true,{'v4', 'v4', 'v4', 's', 's', 'v4', 'v4', 'v4', }},'b', },
			{'score', 'myScore', 'totalPay', 'onlineTime', {true,{'info','playerId', 'score', 'rank', 'name', 'unionName', 'serverId', 'headId', 'headFrameId', }},'isFirst', }
		}
	end,
	[9011] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v8', 'v8', 'v4', 'v4', {true,{'v4', 'v4', 'v8', }},{true,{'v4', }},{true,{'v4', 'v4', }},{true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},}},},
			{{false,{'stronghold','id', 'state', 'startTime', 'endTime', 'useSupTimes', 'progress', {true,{'event','id', 'state', 'startTime', }},{true,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},{true,{'supportRole','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},}},}
		}
	end,
	[1290] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'rotationList', }
		}
	end,
	[1291] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'rotationState', }
		}
	end,
	[5637] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'v4', {true,{'v4', 'b', }},{true,{'v4', 'v4', }},}},},
			{{false,{'info','datingType', 'datingValue', {true,{'bag','id', 'num', }},'endings', 'stepTime', {true,{'entrances','entranceId', 'guide', }},{true,{'quality','qualityId', 'value', }},}},}
		}
	end,
	[9106] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'playerDamage','rank', 'playerId', 'damage', 'count', }},}
		}
	end,
	[1293] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'dressId', 'groupId', }
		}
	end,
	[2067] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'foodId', 'endTime', 'times', }
		}
	end,
	[8904] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {true,{'v4', 'v4', }},},
			{'finished', {true,{'rewardInfo','id', 'num', }},}
		}
	end,
	[521] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'count', }
		}
	end,
	[6802] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {false,{'v4', 'v4', 'v4', 'v4', }},'v4', }},'v4', },
			{{true,{'playerInfos','pid', {false,{'pos','x', 'y', 'dir', 'dt', }},'buildId', }},'roomType', }
		}
	end,
	[3344] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', {true,{'v4', 'v4', 'v4', 'v4', 'v4', 'b', }},}},},
			{{true,{'summonPreview','groupId', 'type', 'typeName', {true,{'previewItems','id', 'order', 'name', 'probability', 'noobProbability', 'showUpTips', }},}},}
		}
	end,
	[7305] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[1827] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'attributeId', 'heroId', }
		}
	end,
	[6656] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'itemId', 'donateVal', }
		}
	end,
	[3074] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'pv4', },
			{'type', 'targets', }
		}
	end,
	[5167] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'b', 'v4', 'v4', 'b', 'v4', 'tv4', 'v4', 'v4', 'v4', 'b', 'b', }},},
			{{true,{'cities','id', 'dungeon', 'resOpen', 'resCount', 'resUpTime', 'invaded', 'invadedEnd', 'invadedCamp', 'resStartTime', 'fightTime', 'score', 'pass', 'dunPass', }},}
		}
	end,
	[9201] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'reward','id', 'num', }},}
		}
	end,
	[1542] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'pv4', }},'b', 's', },
			{'datingRuleCid', {true,{'branchNodes','datingId', 'nextNodeIds', }},'isFirst', 'datingId', }
		}
	end,
	[5185] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'tv4', {true,{'v4', 'v4', }},'b', },
			{'activityId', 'step', 'locations', {true,{'rewards','id', 'num', }},'triggerClear', }
		}
	end,
	[7308] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v8', 'v4', }},},
			{{true,{'springEnvelopeInfo','id', 'sendCount', 'receiveCount', 'lastTime', 'money', }},}
		}
	end,
	[2861] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 's', {true,{'v4', 'v4', }},},
			{'equipId', 'costEquipId', {true,{'items','id', 'num', }},}
		}
	end,
	[7804] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7211] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},},
			{{false,{'currentPoint','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},}
		}
	end,
	[5133] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[4358] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','v4', 'v4', },
			{'ct','cid', 'buy_count', }
		}
	end,
	[4366] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'b', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'b', 'v4', }},{true,{'v4', 'v4', }},},
			{{false,{'signInfo','signDays', 'canSign', 'actRemain', {true,{'basrReward','id', 'num', }},{true,{'specialReward','id', 'num', }},'extDay', 'subscibe', 'subscibeTime', }},{true,{'rewards','id', 'num', }},}
		}
	end,
	[2843] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', {true,{'v4', 's', }},}},},
			{{false,{'info','id', 'desc', {true,{'detail','position', 'equipId', }},}},}
		}
	end,
	[6614] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'tv4', {true,{'v4', 'v4', }},'v4', },
			{'count', 'nextTime', {true,{'fixed','id', 'num', }},{true,{'extra','id', 'num', }},'talents', {true,{'fixedCycle','id', 'num', }},'maxCount', }
		}
	end,
	[1282] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'favoriteId', }
		}
	end,
	[7902] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', },
			{'success', 'type', }
		}
	end,
	[5660] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'tv4', {true,{'v4', 'v4', }},},
			{{true,{'qualityInfo','qualityId', 'value', }},'signList', {true,{'items','id', 'num', }},}
		}
	end,
	[7905] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {true,{'v4', 'v4', }},},
			{'success', {true,{'rewards','id', 'num', }},}
		}
	end,
	[286] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5147] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'tv4', },
			{'level', 'exp', 'propList', }
		}
	end,
	[4383] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', 'v4', 'b', 'b', 'b', {true,{'v4', 's', 'v4', 'v4', 'b', 'v4', 'v4', }},}},},
			{{true,{'teamInfo','teamId', 'createTime', 'giftId', 'isShow', 'isComplete', 'isDestroy', {true,{'members','playerId', 'playerName', 'titleId', 'level', 'isCreator', 'portraitCid', 'portraitFrameId', }},}},}
		}
	end,
	[2068] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', },
			{'foodId', 'qteId', 'integral', 'qteIntegral', }
		}
	end,
	[4368] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'rechargeId', 'buyCount', }
		}
	end,
	[280] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'b', }},},
			{{true,{'switchs','ct','switchType', 'open', }},}
		}
	end,
	[5321] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'equipItemCid', }
		}
	end,
	[2835] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'equipmentInfo','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}
		}
	end,
	[276] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', 'v4', }},},
			{{true,{'logs','ct','cid', 'count', 'discountNum', }},}
		}
	end,
	[4372] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{{false,{'v4', 'f4', }},'v4', {true,{'v4', 'v4', }},'s', 's', 'b', 's', 's', 's', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'pv4', {true,{'v4', 'v4', }},'s', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'v4', 'v4', 'v4', 'b', 'v4', 's', }},'v4', },
			{{true,{'rechargeGiftBagCfg',{false,{'rechargeCfg','id', 'price', }},'type', {true,{'item','id', 'num', }},'name', 'icon', 'tag', 'tagDes', 'tagDes2', 'des1', 'des2', 'order', 'startDate', 'endDate', 'buyCount', 'resetType', 'resetDate', 'playerLevel', {true,{'firstBuyItem','id', 'num', }},'name2', 'des3', 'tagIcon', 'interfaceType', 'buyType', {true,{'exchangeCost','id', 'num', }},'packType', 'originalPrice', 'discount', 'triggerEndDate', 'isTrigger', 'days', 'extendData', }},'pushStatus', }
		}
	end,
	[4359] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','v4', 'v4', 'v4', 'v4', 'v4', }},{false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},{true,{'v4','s', 'v4', 'v4', }},{true,{'v4','s', 'v4', 'v4', }},}},},
			{{false,{'monthCardInfo','ct','lastGainDate', 'surplus_Gain_Count', 'cardCid', 'etime', 'lastEndTime', }},{false,{'itemList',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},{true,{'treasures','ct','id', 'cid', 'star', }},{true,{'exploreEquip','ct','id', 'cid', 'level', }},}},}
		}
	end,
	[6904] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'b', {true,{'v4', 'v4', 'b', }},}},'v4', },
			{{true,{'areaInfoList','areaId', 'isDevil', 'explored', {true,{'roadInfoList','startAreaId', 'endAreaId', 'unlocked', }},}},'currentAreaId', }
		}
	end,
	[4369] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{{false,{'v4', 'f4', }},'v4', {true,{'v4', 'v4', }},'s', 's', 'b', 's', 's', 's', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'pv4', {true,{'v4', 'v4', }},'s', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'v4', 'v4', 'v4', 'b', 'v4', 's', }},{true,{{false,{'v4', 'f4', }},'v4', 's', 's', 's', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 's', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 's', }},{true,{{false,{'v4', 'f4', }},'v4', {true,{'v4', 'v4', }},'s', 's', 'b', 's', 's', 's', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'pv4', {true,{'v4', 'v4', }},'s', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'v4', 'v4', 'v4', 'b', 'v4', 's', }},{true,{{false,{'v4', 'f4', }},'v4', 's', 's', 's', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 's', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 's', }},},
			{{true,{'updateCreateGiftCfg',{false,{'rechargeCfg','id', 'price', }},'type', {true,{'item','id', 'num', }},'name', 'icon', 'tag', 'tagDes', 'tagDes2', 'des1', 'des2', 'order', 'startDate', 'endDate', 'buyCount', 'resetType', 'resetDate', 'playerLevel', {true,{'firstBuyItem','id', 'num', }},'name2', 'des3', 'tagIcon', 'interfaceType', 'buyType', {true,{'exchangeCost','id', 'num', }},'packType', 'originalPrice', 'discount', 'triggerEndDate', 'isTrigger', 'days', 'extendData', }},{true,{'updateCreateMonthCardCfg',{false,{'rechargeCfg','id', 'price', }},'upgradeId', 'icon', 'name', 'des1', {true,{'presentItem','id', 'num', }},{true,{'gainItem','id', 'num', }},'days', 'type', 'name2', 'des3', 'tagIcon', 'interfaceType', 'buyType', {true,{'exchangeCost','id', 'num', }},'packType', 'extendData', }},{true,{'deleteGiftCfg',{false,{'rechargeCfg','id', 'price', }},'type', {true,{'item','id', 'num', }},'name', 'icon', 'tag', 'tagDes', 'tagDes2', 'des1', 'des2', 'order', 'startDate', 'endDate', 'buyCount', 'resetType', 'resetDate', 'playerLevel', {true,{'firstBuyItem','id', 'num', }},'name2', 'des3', 'tagIcon', 'interfaceType', 'buyType', {true,{'exchangeCost','id', 'num', }},'packType', 'originalPrice', 'discount', 'triggerEndDate', 'isTrigger', 'days', 'extendData', }},{true,{'deleteMonthCardCfg',{false,{'rechargeCfg','id', 'price', }},'upgradeId', 'icon', 'name', 'des1', {true,{'presentItem','id', 'num', }},{true,{'gainItem','id', 'num', }},'days', 'type', 'name2', 'des3', 'tagIcon', 'interfaceType', 'buyType', {true,{'exchangeCost','id', 'num', }},'packType', 'extendData', }},}
		}
	end,
	[290] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', },
			{'dayBackground', 'nightBackground', 'dayBGM', 'nightBGM', }
		}
	end,
	[9014] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},},
			{{true,{'supportRole','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},}
		}
	end,
	[4362] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'v4', {true,{'v4', 'v4', }},'v4', 's', }},},
			{{true,{'rewardCfgs','id', 'canReward', 'amount', {true,{'items','id', 'num', }},'order', 'des', }},}
		}
	end,
	[3092] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4',}},}},{true,{'v4', 'v4', }},},
			{{true,{'friendHelpInfos','playerId', 'playerName', 'portraitCid', 'portraitFrameCid', 'level', {true,{'taskInfos','taskId', 'status',}},}},{true,{'rewardItems','id', 'num', }},}
		}
	end,
	[4367] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'id', 'buyCount', {true,{'rewards','id', 'num', }},}
		}
	end,
	[4384] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'giftInfos','giftId', 'status', }},}
		}
	end,
	[4371] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'reward','id', 'num', }},}
		}
	end,
	[4373] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},'v4', },
			{'giftId', {true,{'item','id', 'num', }},'receiveCount', }
		}
	end,
	[5123] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'rewards','id', 'num', }},}
		}
	end,
	[4381] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},{true,{'giftInfos','giftId', 'status', }},}
		}
	end,
	[4363] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'items','id', 'num', }},}
		}
	end,
	[1819] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5125] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'activityid', 'activitEntryId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[3001] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', 'v4', 'v4', 'b', 'v4', }},},
			{{true,{'medal','ct','cid', 'star', 'quality', 'effectTime', 'isEquip', 'createTime', }},}
		}
	end,
	[1793] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {false,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},'s', 'v4', {true,{'v4', 'v4', }},'v4', {true,{'v4', 'v4', }},'b', },
			{'levelCid', {false,{'hero','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},'fightId', 'randomSeed', {true,{'rewards','id', 'num', }},'helpPid', {true,{'limitHeros','limitType', 'limitCid', }},'isDuelMod', }
		}
	end,
	[2833] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},},
			{'heroId', {true,{'euqipGemInfo','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}
		}
	end,
	[7203] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', }},},
			{{false,{'eventInfo','eventId', 'x', 'y', }},}
		}
	end,
	[4356] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','v4', 'v4', 'v4', 'v4', 'v4', },
			{'ct','lastGainDate', 'surplus_Gain_Count', 'cardCid', 'etime', 'lastEndTime', }
		}
	end,
	[4380] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'s', 'v4', 'v4', 'b', 'b', 'b', {true,{'v4', 's', 'v4', 'v4', 'b', 'v4', 'v4', }},}},{true,{'s', 'v4', 'v4', 'b', 'b', 'b', {true,{'v4', 's', 'v4', 'v4', 'b', 'v4', 'v4', }},}},},
			{'giftId', {true,{'allTeamInfos','teamId', 'createTime', 'giftId', 'isShow', 'isComplete', 'isDestroy', {true,{'members','playerId', 'playerName', 'titleId', 'level', 'isCreator', 'portraitCid', 'portraitFrameId', }},}},{true,{'friendTeamInfos','teamId', 'createTime', 'giftId', 'isShow', 'isComplete', 'isDestroy', {true,{'members','playerId', 'playerName', 'titleId', 'level', 'isCreator', 'portraitCid', 'portraitFrameId', }},}},}
		}
	end,
	[7835] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'b', 'v4', 'v4', 'v8', 'v4', 'v4', 'v8', 'v4', 'b', 'v4', {false,{'v8', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},{true,{'v4', {true,{'v4', {true,{'v4', 'v4', 'v4', }},'tv4', }},}},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},}},},
			{{false,{'activity','id', 'first', 'localCity', 'localNation', 'startTime', 'cityAwardTimes', 'speed', 'lastAwardPointTime', 'capacity', 'isPush', 'totalRewardCount', {false,{'rewards','awardTime', 'activityId', 'nationId', 'cityId', 'dropId', {true,{'rewards','id', 'num', }},}},{true,{'nation','id', {true,{'city','id', {true,{'event','id', 'state', 'progress', }},'completeEvent', }},}},{true,{'totalRewards','id', 'num', }},{true,{'actRewards','id', 'num', }},}},}
		}
	end,
	[1552] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6228] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'tv4', },
			{'eventCid', 'gameCid', 'options', }
		}
	end,
	[5198] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'result', {true,{'rewards','id', 'num', }},}
		}
	end,
	[5131] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', {true,{'s', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},'v4', 'v4', 'v4', },
			{'activityId', {true,{'ranks','rank', 'playerId', 'playerName', 'score', 'headIcon', 'helpFightHeroId', 'level', 'frameCid', 'groupRank', {true,{'rankPlayerInfo','playerName', 'playerId', 'level', 'frameCid', 'headIcon', 'helpFightHeroId', 'heroId', }},}},'myRank', 'myScore', 'myHero', }
		}
	end,
	[7841] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'skillId', }
		}
	end,
	[6202] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},'tv4', {true,{'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', {true,{'v4', 'v4', }},{false,{{true,{'v4', 'v4', 'v4', }},'v4',}},{false,{'v4', 'v4', 'b', }},{false,{{true,{'v4', 'tv8', }},}},},
			{'worldCid', {true,{'items','itemId', 'itemNum', }},{true,{'missions','missionId', 'progress', }},{true,{'points','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},'formation', {true,{'infections','heroId', 'infection', }},'qliphothCoin', 'qliphothEnergy', 'currentX', 'currentY', 'firstUse', 'mapCid', 'eventRefresh', {true,{'exploredPoints','x', 'y', }},{false,{'buffs',{true,{'buffs','buffCid', 'begining', 'useCount', }},'ct',}},{false,{'foundLocation','x', 'y', 'add', }},{false,{'hiddenEvents',{true,{'events','eventCid', 'progress', }},}},}
		}
	end,
	[2838] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},}
		}
	end,
	[6209] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'qliphothEnergy', }
		}
	end,
	[294] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'record', }
		}
	end,
	[8401] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirit','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
		}
	end,
	[8911] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'id', 'voteId', {true,{'rewardInfo','id', 'num', }},}
		}
	end,
	[6811] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', {true,{'v4', 'v4', }},}},'tv4', 'tv4', 'v4', },
			{{true,{'chapterInfo','chapter', 'isOpen', {true,{'mission','dungeonId', 'fightCount', }},}},'passedMission', 'firstPassedMission', 'endTime', }
		}
	end,
	[3501] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'tv4', 'tv4', },
			{'activityId', 'score', 'refreshCount', 'scoreRewards', 'summonedList', }
		}
	end,
	[7806] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'equip','id', 'cid', 'level', 'index', 'cabinId', }},}
		}
	end,
	[6101] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'b', {true,{'v4', 'v4', }},}},},
			{{true,{'shareInfos','id', 'statue', 'show', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[264] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','v4', 'v4', 'ts', },
			{'ct','type', 'status', 'stance', }
		}
	end,
	[5381] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'heroHealth','heroCid', 'health', }},}
		}
	end,
	[4098] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', {true,{'v4', 'v4', }},},
			{'taskDbId', 'taskCid', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6668] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', {true,{'v8', 'v4', 's', 'ts', }},},
			{'version', {true,{'notify','creatTime', 'notifyType', 'playerName', 'prams', }},}
		}
	end,
	[6229] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},{true,{'v4','s', 'v4', 'v4', }},{true,{'v4','s', 'v4', 'v4', }},}},'tv4', },
			{'eventCid', 'gameCid', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},{true,{'treasures','ct','id', 'cid', 'star', }},{true,{'exploreEquip','ct','id', 'cid', 'level', }},}},'options', }
		}
	end,
	[2836] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},},
			{{false,{'gem','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}
		}
	end,
	[8508] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'tv4', 'v4', }},},
			{{false,{'boss','curDungeon', 'dungeonHp', 'leftCount', 'dungeonBuffs', 'honor', }},}
		}
	end,
	[8914] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'sign', }
		}
	end,
	[2845] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 's', {true,{'v4', 's', }},}},},
			{'heroId', {true,{'plan','index', 'name', {true,{'plan','index', 'equipId', }},}},}
		}
	end,
	[25601] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'excessTime', }
		}
	end,
	[8003] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'buffIds', }
		}
	end,
	[8602] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5650] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 'v4', 'v4', }},},
			{'roleId', {true,{'info','favorId', 'statue', 'firstPass', 'energy', }},}
		}
	end,
	[5128] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 's', 'v4', }},},
			{{true,{'items','id', 'itemId', 'progress', 'extend', 'status', }},}
		}
	end,
	[9105] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 'b', }},},
			{'morale', {true,{'attr','playerId', 'attackNum', 'pass', }},}
		}
	end,
	[5653] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'favorRoleStatue','favorDatingId', 'statue', }},}
		}
	end,
	[6213] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},'v4', },
			{{true,{'produces','itemId', 'itemNum', 'buyCount', }},'nextRefresh', }
		}
	end,
	[9153] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'b', }},'v4', 'v4', 'v4', }},'v4', 'v4', },
			{{false,{'recruitInfo',{true,{'recruits','cid', 'state', }},'nextTime', 'recruitTimes', 'recruitBuyTimes', }},'addRecruitId', 'roleId', }
		}
	end,
	[7906] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'b', 'b', 'b', 'v4', 'v4','v4', 'b', }},'b', 'b', },
			{{true,{'apprenticeList','playerId', 'portraitCId', 'name', 'fightPower', 'level', 'lastLoginTime', 'online', 'portraitFrameCId', 'isFriend', 'isUnion', 'finished', 'type', 'ct','famousExp', 'hasGift', }},'isCD', 'finished', }
		}
	end,
	[1822] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'floor', 'costTime', }
		}
	end,
	[2317] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'barrageId', 'lastSendTime', }
		}
	end,
	[6227] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},{true,{'v4','s', 'v4', 'v4', }},{true,{'v4','s', 'v4', 'v4', }},}},},
			{'eventCid', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},{true,{'treasures','ct','id', 'cid', 'star', }},{true,{'exploreEquip','ct','id', 'cid', 'level', }},}},}
		}
	end,
	[6201] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'b', {true,{'v4', 'v4', 'v4', 'v4', }},},
			{'openWorldCid', 'missionComplete', 'qliphothCoin', 'qliphothEnergy', 'firstUse', {true,{'worldTimes','worldCid', 'begining', 'endTime', 'beSoon', }},}
		}
	end,
	[6822] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', },
			{'roomType', 'ext', }
		}
	end,
	[9012] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v8', 'v8', 'v4', 'v4', {true,{'v4', 'v4', 'v8', }},{true,{'v4', }},{true,{'v4', 'v4', }},{true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},}},'v4', 'v8', },
			{{true,{'stronghold','id', 'state', 'startTime', 'endTime', 'useSupTimes', 'progress', {true,{'event','id', 'state', 'startTime', }},{true,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},{true,{'supportRole','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},}},'refreshTimes', 'refreshTime', }
		}
	end,
	[6301] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', 'b', },
			{{true,{'levels','levelCid', 'status', }},'leftTime', 'count', 'buffCid', 'buffCount', 'awardStatus', 'finishAny', }
		}
	end,
	[8310] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'usingCards', }
		}
	end,
	[6210] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'ambushId', }
		}
	end,
	[6207] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'b', },
			{{true,{'missions','missionId', 'progress', }},'completed', }
		}
	end,
	[1804] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'pv4', 'v4', 'b', 'v4', 'v4', }},},
			{{true,{'levelInfos','cid', 'goals', 'fightCount', 'win', 'buyCount', 'freeCount', }},}
		}
	end,
	[2566] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', }},},
			{{true,{'datas','ct','data', }},}
		}
	end,
	[6225] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},'v4',},
			{{true,{'buffs','buffCid', 'begining', 'useCount', }},'ct',}
		}
	end,
	[6617] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[6221] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', 'b', {true,{'v4', 'v4', 'v4', 'v4', }},}},'b', },
			{{false,{'treeInfo','openWorldCid', 'missionComplete', 'qliphothCoin', 'qliphothEnergy', 'firstUse', {true,{'worldTimes','worldCid', 'begining', 'endTime', 'beSoon', }},}},'openStatus', }
		}
	end,
	[6613] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', {true,{'v4', 'b', }},},
			{'refreshCount', 'refreshTime', 'helpCount', {true,{'levels','cid', 'pass', }},}
		}
	end,
	[7003] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'portraitType', }
		}
	end,
	[7815] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', {true,{'v4', 'v4', }},}},},
			{{true,{'techTree','techType', 'nationId', {true,{'tech','techId', 'state', }},}},}
		}
	end,
	[7002] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'portraitType', 'equipCid', 'changCid', }
		}
	end,
	[9004] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'b', },
			{'id', 'eventId', 'isSkip', }
		}
	end,
	[8151] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'id', }
		}
	end,
	[285] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'pid', }
		}
	end,
	[266] = function()
		return {
			{"net.NetHelper", "receive"},
			{'pv4', 'v4', 'v4', },
			{'x1', 'x2', 'x3', }
		}
	end,
	[293] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'recoverTimeList', }
		}
	end,
	[265] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', 'ts', }},},
			{{true,{'formations','ct','type', 'status', 'stance', }},}
		}
	end,
	[7840] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'attr','attrId', 'attrType', 'baseValue', 'addValue', }},}
		}
	end,
	[1801] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},'v4', 'v4', }},},
			{{true,{'group','id', 'cid', 'fightCount', 'buyCount', {true,{'rewardInfo','key', 'list', }},'mainLineCid', 'maxMainLine', }},}
		}
	end,
	[5172] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', {true,{'v4', 'v4', }},'tv4', 'v4', 'b', }},'v4', },
			{{true,{'eventList','ct','eventId', {true,{'rewards','id', 'num', }},'roleIds', 'eventEndTime', 'isSpecial', }},'activityId', }
		}
	end,
	[5196] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', },
			{'friendId', 'result', }
		}
	end,
	[7823] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', 'v4', 'v4', 'v8', 'v4', 'v4', 'v8', 'v4', 'b', 'v4', {false,{'v8', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},{true,{'v4', {true,{'v4', {true,{'v4', 'v4', 'v4', }},'tv4', }},}},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{'id', 'first', 'localCity', 'localNation', 'startTime', 'cityAwardTimes', 'speed', 'lastAwardPointTime', 'capacity', 'isPush', 'totalRewardCount', {false,{'rewards','awardTime', 'activityId', 'nationId', 'cityId', 'dropId', {true,{'rewards','id', 'num', }},}},{true,{'nation','id', {true,{'city','id', {true,{'event','id', 'state', 'progress', }},'completeEvent', }},}},{true,{'totalRewards','id', 'num', }},{true,{'actRewards','id', 'num', }},}
		}
	end,
	[4365] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'b', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'b', 'v4', }},{true,{'v4', 's', 'v4', 's', {true,{'v4', 'v4', }},'v4', 'v4', {true,{'v4', 'v4', }},'v4', 'v4', 's', }},},
			{{false,{'signInfo','signDays', 'canSign', 'actRemain', {true,{'basrReward','id', 'num', }},{true,{'specialReward','id', 'num', }},'extDay', 'subscibe', 'subscibeTime', }},{true,{'storeInfo','id', 'name', 'order', 'limitDes', {true,{'items','id', 'num', }},'limitType', 'limitVal', {true,{'price','id', 'num', }},'buyCount', 'color', 'ext', }},}
		}
	end,
	[1050] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', 'v4', }},},
			{'heroId', {true,{'crystalInfo','rarity', 'gridId', }},}
		}
	end,
	[267] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', 'v4', 'v8', 'v4', 'v8', 'v4','s', 'v4', {true,{'v4','v4', }},'b', 's', 's', 'tv4', 'v4', 'v4', {false,{{true,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},'v4', 'v4', }},'v4', 's', 'v4', 'v4', 'v4', },
			{'pid', 'name', 'lvl', 'exp', 'vip_lvl', 'vip_exp', 'language','remark', 'helpFightHeroCid', {true,{'attr','attrKey','attrVal', }},'isFirstLogin', 'clientDiscreteData', 'settings', 'recoverTimeList', 'portraitCid', 'portraitFrameCid', {false,{'element',{true,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},'rank', 'totleTrophy', }},'unionId', 'unionName', 'titleId', 'createTime', 'famousExp', }
		}
	end,
	[5126] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 's', 'v4', 's', 'tv4', 's', }},},
			{{true,{'activitys','ct','id', 'activityType', 'activityTitle', 'startTime', 'endTime', 'showStartTime', 'showEndTime', 'remark', 'extendData', 'rank', 'showIcon', 'items', 'titleIcon', }},}
		}
	end,
	[7225] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'v4', 'v4', }},'v4',}},},
			{{false,{'buffInfo',{true,{'buffs','buffCid', 'begining', 'useCount', }},'ct',}},}
		}
	end,
	[300] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', },
			{'id', 'isShow', }
		}
	end,
	[8102] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', }},}},},
			{{false,{'eventInfo','eventId', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[304] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 's', 'v4', },
			{'needChange', 'data', 'id', }
		}
	end,
	[8501] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},{false,{'v4', 'v4', 'v4', 'tv4', 'v4', }},{false,{{true,{'v4', 'v4', }},'v4', }},},
			{{false,{'step','step', 'nextTime', }},{false,{'curBoss','curDungeon', 'dungeonHp', 'leftCount', 'dungeonBuffs', 'honor', }},{false,{'playerWeakness',{true,{'weakness','dungeon', 'count', }},'leftCount', }},}
		}
	end,
	[6219] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},},
			{{true,{'points','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},}
		}
	end,
	[5150] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[8604] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', }},}},},
			{{true,{'rewards','type', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[9412] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6303] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[292] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'time', }
		}
	end,
	[1800] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'cid', }
		}
	end,
	[284] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'anti', }
		}
	end,
	[25606] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},},
			{{true,{'netFrames','index', {true,{'operateFrame','pid', 'keyCode', 'keyEvent', 'keyEventEx', 'posX', 'posY', 'dir', 'hp', 'sp', }},{true,{'dataFrame','pid', 'action', }},{true,{'bossFrame','id', 'posX', 'posY', 'dir', 'hp', 'operate', 'sp', }},{true,{'aiFrame','id', 'pid', 'lastStep', 'curStep', 'funcID', 'param1', 'param2', 'param3', }},}},}
		}
	end,
	[7217] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'b', {true,{'v4', 'v4', }},}},},
			{{false,{'exploreInfo','result', {true,{'exploredPoints','x', 'y', }},}},}
		}
	end,
	[2841] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', {true,{'v4', 's', }},}},},
			{{true,{'info','id', 'desc', {true,{'detail','position', 'equipId', }},}},}
		}
	end,
	[2827] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', {true,{'v4', 'v4', 'v4', }},}},},
			{'equipmentId', {true,{'remouldResult','index', {true,{'resultPreview','head', 'tail', 'rate', }},}},}
		}
	end,
	[269] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[8802] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 's', 's', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 's', 'v4', 'v4', 'v4', 'v4', }},},
			{'type', {true,{'rank','id', 'name', 'score', 'rank', 'portraitCid', 'portraitFrameCid', 'unionIcon', }},{false,{'myUnionRank','id', 'name', 'score', 'rank', 'portraitCid', 'portraitFrameCid', 'unionIcon', }},}
		}
	end,
	[6827] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4','v4', 'b', 'v4', {true,{'v4','v4', 'v4', 'v4', 'b', 'v4', }},}},'s', },
			{'roomType', {true,{'areaRiddles','ct','decryptTeamId', 'success', 'nextTriggerTime', {true,{'riddles','ct','id', 'lox', 'loy', 'correct', 'playerId', }},}},'roomId', }
		}
	end,
	[301] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'v4', },
			{{true,{'phantomInfo','pos', 'phantomId', }},'type', }
		}
	end,
	[287] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 's', },
			{'openAsk', 'askUrl', }
		}
	end,
	[5194] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', 'v8', },
			{'friendId', 'friendName', 'timeout', }
		}
	end,
	[299] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{false,{'v4','v4', 'v4', 'ts', }},'v4', 's', }},},
			{{false,{'formation',{false,{'base','ct','type', 'status', 'stance', }},'id', 'desc', }},}
		}
	end,
	[7202] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},'tv4', 'v4', 'v4', 'b', 'v4', 'v4', {true,{'v4', 'v4', }},{false,{{true,{'v4', 'v4', 'v4', }},'v4',}},{false,{'v4', 'v4', 'b', }},{false,{{true,{'v4', 'tv8', }},}},},
			{'worldCid', {true,{'items','itemId', 'itemNum', }},{true,{'missions','missionId', 'progress', }},{true,{'points','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},'formation', 'currentX', 'currentY', 'firstUse', 'mapCid', 'eventRefresh', {true,{'exploredPoints','x', 'y', }},{false,{'buffs',{true,{'buffs','buffCid', 'begining', 'useCount', }},'ct',}},{false,{'foundLocation','x', 'y', 'add', }},{false,{'hiddenEvents',{true,{'events','eventCid', 'progress', }},}},}
		}
	end,
	[1794] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'pv4', 'v4', 'b', 'v4', 'v4', }},{true,{'v4', 'v4', }},'b', {true,{'v4', {true,{'v4', 'v4', }},}},{true,{'v4', 'v4', }},},
			{{false,{'levelInfo','cid', 'goals', 'fightCount', 'win', 'buyCount', 'freeCount', }},{true,{'rewards','id', 'num', }},'win', {true,{'additionAward','additionId', {true,{'rewards','id', 'num', }},}},{true,{'original','id', 'num', }},}
		}
	end,
	[5156] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v8', },
			{'activityId', 'num', }
		}
	end,
	[6608] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'pv4', 'v4', 'b', 'v4', }},{true,{'v4', 'v4', }},{false,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'levelInfos','cid', 'goals', 'fightCount', 'win', 'buyCount', }},{true,{'dungeonInfos','dungeonId', 'time', }},{false,{'enemy','invadeId', 'time', }},{true,{'mapBoxes','location', 'eventCid', }},}
		}
	end,
	[7102] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', 'tv4', {true,{'v4', {true,{'v4', 'v4', }},}},},
			{'curAreaCid', 'openAreas', 'finTasks', {true,{'complteEvents','areaCid', {true,{'events','cid', 'num', }},}},}
		}
	end,
	[7206] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','itemId', 'itemNum', }},}
		}
	end,
	[4868] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'rank', }
		}
	end,
	[298] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7104] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'finTasks', }
		}
	end,
	[3334] = function()
		return {
			{"net.NetHelper", "receive"},
			{'pv4', },
			{'cid', }
		}
	end,
	[295] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', 'v8', 'v4', 'v4', 'b', 'v4', },
			{'rechargeAmount', 'onlineTime', 'rechargeScore', 'onlineScore', 'asked', 'activeScore', }
		}
	end,
	[8910] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5202] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'passInfo','dunId', 'passCount', }},}
		}
	end,
	[6156] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 's', },
			{'pid', 'type', 'state', }
		}
	end,
	[7215] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},{true,{'v4','s', 'v4', 'v4', }},{true,{'v4','s', 'v4', 'v4', }},}},}},},
			{{false,{'eventItems','x', 'y', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},{true,{'treasures','ct','id', 'cid', 'star', }},{true,{'exploreEquip','ct','id', 'cid', 'level', }},}},}},}
		}
	end,
	[6513] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'id', 'chapterId', }
		}
	end,
	[8601] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},{true,{'v4', 'v4', 'v4', }},{true,{'v4', 'tv4', }},},
			{{true,{'dispatches','dungeonType', {true,{'fightPower','hero', 'fightPower', }},{true,{'dungeonInfo','dungeonCid', 'multiple', 'eTime', 'awardCount', 'runCount', 'maxCount', }},}},{true,{'exhaustions','hero', 'exhaustion', 'nextTime', }},{true,{'heroes','type', 'heroes', }},}
		}
	end,
	[3076] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'b', 'v4','v4', 'v4', 'b', 'v4', 'v4', 'tv4', 'v4', }},},
			{{true,{'friends','pid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'lastHandselTime', 'receive', 'status', 'leaderCid', 'online', 'ct','time', 'helpCDtime', 'canSend', 'portraitCid', 'portraitFrameCid', 'groupGiftIds', 'type', }},}
		}
	end,
	[5144] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 's', 'v4', }},},
			{{true,{'items','id', 'itemId', 'progress', 'extend', 'status', }},}
		}
	end,
	[7810] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7403] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'roleid', {true,{'rewards','id', 'num', }},}
		}
	end,
	[7103] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'areaCid', }
		}
	end,
	[7227] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},{true,{'v4','s', 'v4', 'v4', }},{true,{'v4','s', 'v4', 'v4', }},}},}},},
			{{false,{'rewardInfo','eventCid', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},{true,{'treasures','ct','id', 'cid', 'star', }},{true,{'exploreEquip','ct','id', 'cid', 'level', }},}},}},}
		}
	end,
	[5155] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'address', }
		}
	end,
	[6706] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'activityId', 'stage', }
		}
	end,
	[7229] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},{true,{'v4','s', 'v4', 'v4', }},{true,{'v4','s', 'v4', 'v4', }},}},'tv4', }},},
			{{false,{'gameInfo','eventCid', 'gameCid', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},{true,{'treasures','ct','id', 'cid', 'star', }},{true,{'exploreEquip','ct','id', 'cid', 'level', }},}},'options', }},}
		}
	end,
	[7220] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6505] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', },
			{'serverContribution', }
		}
	end,
	[2824] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},}
		}
	end,
	[6511] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'datingNodes', }
		}
	end,
	[1049] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[6512] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'prizeIndex', {true,{'selfContriRewards','id', 'num', }},}
		}
	end,
	[3330] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'composeInfo','cid', 'finishTime', {true,{'items','id', 'num', }},'costTime', }},}
		}
	end,
	[6514] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'id', 'chapterId', }
		}
	end,
	[6504] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[6222] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'startTime', 'endTime', }
		}
	end,
	[6818] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'dayTimes', }
		}
	end,
	[6610] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'enemy','invadeId', 'time', }},}
		}
	end,
	[2842] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', {true,{'v4', 's', }},}},},
			{{false,{'info','id', 'desc', {true,{'detail','position', 'equipId', }},}},}
		}
	end,
	[6804] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 'v4', {false,{'v4', 'v4', 'v4', 'v4', }},'v4', 'v4', }},'v4', },
			{{false,{'playerInfo','pid', 'pname', 'level', 'heroCid', 'skinCid', 'unionId', 'unionName', 'titleId', {false,{'pos','x', 'y', 'dir', 'dt', }},'buildId', 'effectId', }},'roomType', }
		}
	end,
	[5302] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewardNum','key', 'value', }},}
		}
	end,
	[6808] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', 's', 'v4', 'v4', 'v4', 'v4', },
			{'content', 'pid', 'pname', 'lvl', 'helpFightHeroCid', 'portraitCid', 'portraitFrameCid', }
		}
	end,
	[5120] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 's', 'v4', 'v4', 's', 'v4', 'v4', 'tv4', }},},
			{{true,{'mainAdBoardInfo','Id', 'activityType', 'jumpId', 'adicon', 'isOpen', 'sort', 'name', 'startTime', 'endTime', 'os', }},}
		}
	end,
	[6506] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'bossDungeonId', }
		}
	end,
	[6828] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4','v4', 'v4', 'v4', 'b', 'v4', }},'s', },
			{'roomType', 'decryptTeamId', {true,{'riddles','ct','id', 'lox', 'loy', 'correct', 'playerId', }},'roomId', }
		}
	end,
	[9159] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[2157] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[9352] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', 'tv4', {true,{'v4', 'v4', }},{true,{'v8', 'v4', {true,{'v4', 'v4', }},}},'v4', },
			{'rollNum', 'movePos', {true,{'rewards','id', 'num', }},{true,{'records','time', 'result', {true,{'rewards','id', 'num', }},}},'rounds', }
		}
	end,
	[6805] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'pid', 'roomType', }
		}
	end,
	[6670] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'weekExp', 'lastWeekActive', }
		}
	end,
	[6212] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'produces','itemId', 'itemNum', 'buyCount', }},{true,{'rewardItems','itemId', 'itemNum', }},}
		}
	end,
	[1537] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2072] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv4', }},{true,{'v8', 'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', }},'v4', },
			{{true,{'buildinginfos','buildingId', 'buildingFuns', }},{true,{'roleInRooms','dressId', 'buildingId', 'cityRoleId', }},{true,{'remindEvents','buildingId', 'funId', 'exeId', 'eventType', }},'dayType', }
		}
	end,
	[4865] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},'v4', 'v4', },
			{{true,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},'rank', 'totleTrophy', }
		}
	end,
	[1821] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', {true,{'v4', 'v4', }},}},},
			{'floor', {true,{'roundFormation','round', {true,{'heroes','index', 'hero', }},}},}
		}
	end,
	[1558] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},},
			{{true,{'sealStateInfo','roleId', 'sealState', 'sealType', }},}
		}
	end,
	[2062] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v8', 'v8', 'v4', },
			{'eggPool', 'pollRefreshCdEndTime', 'catchEndTime', 'eggPoolId', }
		}
	end,
	[2080] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'handWorkInfo','manualId', 'endTime', 'integral', 'times', }},}
		}
	end,
	[6605] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', 'v4', {true,{'v4', 'v4', }},},
			{'type', 'playerName', 'param', {true,{'composePrizes','id', 'num', }},}
		}
	end,
	[2063] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', },
			{'catchEndTime', }
		}
	end,
	[2078] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},'v4', 'v8', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v8', },
			{{false,{'jobList','buildingId', {true,{'jobInfos','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},'level', 'exp', }},{true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'addExp', }
		}
	end,
	[1564] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', }},},
			{'roleId', 'type', {true,{'list','pid', 'pName', 'headId', 'headFrame', 'pLevel', 'fightPower', 'rank', 'gid', 'channel', 'trainLv', 'sucNum', 'totalNum', }},{false,{'selfRank','pid', 'pName', 'headId', 'headFrame', 'pLevel', 'fightPower', 'rank', 'gid', 'channel', 'trainLv', 'sucNum', 'totalNum', }},}
		}
	end,
	[6211] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},},
			{{false,{'currentPoint','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},}
		}
	end,
	[8502] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'damages','unionId', 'unionLv', 'unionName', 'bossLv', 'dmgRate', 'rank', 'icon', }},{false,{'selfDamage','unionId', 'unionLv', 'unionName', 'bossLv', 'dmgRate', 'rank', 'icon', }},{true,{'honors','playerId', 'playerName', 'playerLv', 'honor', 'fightCount', 'rank', 'headId', 'dmgRate', }},{false,{'selfHonor','playerId', 'playerName', 'playerLv', 'honor', 'fightCount', 'rank', 'headId', 'dmgRate', }},}
		}
	end,
	[7842] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'skinId', }
		}
	end,
	[5158] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[8912] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', }},}},},
			{{true,{'voteInfo','day', {true,{'detectiveStat','id', 'count', }},}},}
		}
	end,
	[2076] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},{true,{'v4', {true,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},'v4', 'v8', }},},
			{{false,{'jobEvent','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},{true,{'jobLists','buildingId', {true,{'jobInfos','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},'level', 'exp', }},}
		}
	end,
	[2818] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[7703] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'b', }},},
			{{true,{'cities','id', 'dungeon', 'resOpen', 'resCount', 'resStartTime', 'resUpTime', 'replace', 'replaceEnd', 'replaceGame', 'pass', }},}
		}
	end,
	[25603] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5199] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6226] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv8', }},},
			{{true,{'events','eventCid', 'progress', }},}
		}
	end,
	[7831] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'id', }
		}
	end,
	[8504] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},{true,{'fdAward','dungeon', 'status', }},}
		}
	end,
	[3002] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[6603] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{'id', {true,{'rewards','id', 'num', }},{true,{'extRewards','id', 'num', }},}
		}
	end,
	[25613] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},'v4', {true,{'v4', 'v4', }},},
			{'pid', {true,{'rewards','id', 'num', }},'extTips', {true,{'extRewards','id', 'num', }},}
		}
	end,
	[3011] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'cid', }
		}
	end,
	[8001] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'tv4', 'tv4', {false,{'v4', 'b', }},{false,{'tv4', }},}},'v4', 'v4', {true,{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},}},{false,{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', }},},
			{{false,{'cellInfo','totleStep', 'location', 'buffIds', 'cellIds', {false,{'event','eventId', 'status', }},{false,{'list','buffId', }},}},'awardStep', 'buffStep', {true,{'awardInfo',{true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},}},{false,{'eventAward',{true,{'eventRewards','id', 'num', }},{true,{'eventExRewards','id', 'num', }},'eventId', }},}
		}
	end,
	[8312] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'heroCount','itemCid', 'count', }},}
		}
	end,
	[3350] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},{false,{'b', 'v4', 'v4', 'v4', }},{false,{'v4', 'v4', 'v4', 'v4', {true,{'v4', {true,{'v4', 'v4', }},'b', }},}},{true,{'v4', 'v4', }},},
			{'cid', {true,{'item','id', 'num', }},{false,{'noobInfo','noobStatus', 'endTime', 'summonCount', 'awardState', }},{false,{'simulateSummon','cid', 'simulateSummonCount', 'sysSimulateSummonCount', 'exchangeCount', {true,{'records','order', {true,{'items','id', 'num', }},'isReceive', }},}},{true,{'lastResult','id', 'num', }},}
		}
	end,
	[7814] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[9403] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', {true,{'v4', 'v4', }},},
			{'progress', 'level', {true,{'repairOutput','index', 'output', }},}
		}
	end,
	[7601] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'manaBagInfo','id', 'level', }},}
		}
	end,
	[772] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 's', 'v4', 'v4', 'v4', 's', 's', {true,{'v4', 'v4', }},'v4', }},},
			{{true,{'mails','ct','id', 'senderId', 'senderName', 'createTime', 'modifiedTime', 'status', 'title', 'body', {true,{'rewards','id', 'num', }},'mailType', }},}
		}
	end,
	[5134] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'url', }
		}
	end,
	[9155] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},},
			{{true,{'maidObject','onlyId', 'cid', 'strength', }},}
		}
	end,
	[4002] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[9413] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 's', 'v4', }},{true,{'v4', 's', 'v4', 'v4', 's', 'v4', }},{true,{'v4', 's', 'v4', 'v4', 's', 'v4', }},},
			{{false,{'myInfo','playerId', 'name', 'portraitCid', 'portraitFrameCid', 'context', 'time', }},{true,{'friendWish','playerId', 'name', 'portraitCid', 'portraitFrameCid', 'context', 'time', }},{true,{'unionWish','playerId', 'name', 'portraitCid', 'portraitFrameCid', 'context', 'time', }},}
		}
	end,
	[9157] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'roleId', }
		}
	end,
	[2848] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5140] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'recoverTime', }
		}
	end,
	[2315] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', 'v4', 'v4', },
			{'content', 'type', 'lastSendTime', 'dialogueId', }
		}
	end,
	[275] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'cid', 'count', {true,{'reward','id', 'num', }},}
		}
	end,
	[9154] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'b', }},'v4', 'v4', 'v4', }},},
			{{false,{'recruitInfo',{true,{'recruits','cid', 'state', }},'nextTime', 'recruitTimes', 'recruitBuyTimes', }},}
		}
	end,
	[7802] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', {true,{'s', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', 'tv4', 'v8', 'v4', }},{true,{'v4', 'v4', }},'v4', {true,{'v4', 's', }},},
			{'id', 'cid', 'holeCount', {true,{'equip','id', 'cid', 'level', 'index', 'cabinId', }},{true,{'task','id', 'state', 'heroId', 'startTime', 'cabinId', }},{true,{'driver','index', 'heroId', }},'fightPower', {true,{'treasure','index', 'uuid', }},}
		}
	end,
	[6824] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {false,{{true,{'v4', 'v4', }},}},'s', },
			{'roomType', {false,{'relevantData',{true,{'giftInfo','type', 'count', }},}},'ext', }
		}
	end,
	[8410] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},},
			{{true,{'heroViews','hero', 'grade', 'level', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[2066] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'foodbaseInfo','foodId', 'endTime', 'integral', 'times', }},}
		}
	end,
	[8906] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6206] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','itemId', 'itemNum', }},}
		}
	end,
	[7805] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[9151] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'workLists', }
		}
	end,
	[1549] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','s', 'pv4', 'v4', 'v4', 'v4', 'b', },
			{'ct','cityDatingId', 'datingTimeFrame', 'datingRuleCid', 'date', 'state', 'inDating', }
		}
	end,
	[7101] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'startTime', 'endTime', 'showTime', }
		}
	end,
	[2847] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[261] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[4377] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', 'v4', 'v4', 'b', 'b', 'b', {true,{'v4', 's', 'v4', 'v4', 'b', 'v4', 'v4', }},}},},
			{{false,{'teamInfo','teamId', 'createTime', 'giftId', 'isShow', 'isComplete', 'isDestroy', {true,{'members','playerId', 'playerName', 'titleId', 'level', 'isCreator', 'portraitCid', 'portraitFrameId', }},}},}
		}
	end,
	[5143] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 's', 's', 's', 's', 'v4', 'v4', }},},
			{{true,{'items','id', 'type', 'name', 'details', 'target', 'reward', 'extendData', 'rank', 'subType', }},}
		}
	end,
	[9405] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewardsMsg','id', 'num', }},}
		}
	end,
	[3080] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'rewardInfos','cid', 'status', }},{true,{'rewardItems','id', 'num', }},}
		}
	end,
	[8706] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', }},},
			{{true,{'players','pid', 'pName', 'headId', 'headFrame', 'level', 'fightPower', 'round', 'prize', 'sid', 'channel', }},}
		}
	end,
	[262] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[9409] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', }},'s', 'ts', },
			{{true,{'roseData','optionId', 'count', }},'totalCount', 'takeList', }
		}
	end,
	[5168] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4','v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},{true,{'v4','v4', {true,{'v4', 'v4', }},'tv4', 'v4', 'b', }},{true,{'v4','v4', 'v4', }},},
			{'activityId', {true,{'hangUpRoleInfo','ct','roleId', 'level', 'nextSettleTime', 'currentEventId', {true,{'rewards','id', 'num', }},}},{true,{'eventList','ct','eventId', {true,{'rewards','id', 'num', }},'roleIds', 'eventEndTime', 'isSpecial', }},{true,{'specialAward','ct','id', 'triggerId', }},}
		}
	end,
	[2821] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {true,{'v4', 'v4', }},},
			{'success', {true,{'items','id', 'num', }},}
		}
	end,
	[1553] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'accept', }
		}
	end,
	[6402] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'pv4', 'v4', 'b', 'v4', },
			{'cid', 'goals', 'fightCount', 'win', 'buyCount', }
		}
	end,
	[3502] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},'tv4', },
			{'activityId', 'score', {true,{'item','id', 'num', }},'summonedList', }
		}
	end,
	[8306] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},},
			{{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},}
		}
	end,
	[1811] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'pv4', 'v4', 'b', 'v4', 'v4', }},},
			{{false,{'levelInfo','cid', 'goals', 'fightCount', 'win', 'buyCount', 'freeCount', }},}
		}
	end,
	[8603] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[2081] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'manualId', 'endTime', 'times', }
		}
	end,
	[5178] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'successCode', }
		}
	end,
	[7821] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'b', 'v4', 'v4', 'v8', 'v4', 'v4', 'v8', 'v4', 'b', 'v4', {false,{'v8', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},{true,{'v4', {true,{'v4', {true,{'v4', 'v4', 'v4', }},'tv4', }},}},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},}},{true,{'v4', 'v4', }},},
			{{false,{'activity','id', 'first', 'localCity', 'localNation', 'startTime', 'cityAwardTimes', 'speed', 'lastAwardPointTime', 'capacity', 'isPush', 'totalRewardCount', {false,{'rewards','awardTime', 'activityId', 'nationId', 'cityId', 'dropId', {true,{'rewards','id', 'num', }},}},{true,{'nation','id', {true,{'city','id', {true,{'event','id', 'state', 'progress', }},'completeEvent', }},}},{true,{'totalRewards','id', 'num', }},{true,{'actRewards','id', 'num', }},}},{true,{'rewards','id', 'num', }},}
		}
	end,
	[2077] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},},
			{{false,{'jobInfo','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},}
		}
	end,
	[5176] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', 's', 'v4', 'b', 'v4', },
			{'activityId', 'isReturn', 'codeInfo', 'beCallNum', 'isBind', 'taskSize', }
		}
	end,
	[5142] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7839] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'stepInfo', }
		}
	end,
	[9010] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'buff','buffId', 'buffLv', }},}
		}
	end,
	[8307] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},},
			{{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},}
		}
	end,
	[5221] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'formulaId', 'etime', }
		}
	end,
	[8303] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},{false,{'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'rankList',{true,{'rankList','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},{false,{'rank','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},}},{false,{'seasonData','segment', 'laderScore', {true,{'rewards','id', 'num', }},'clientSeason', }},}
		}
	end,
	[7223] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},'v4', }},},
			{{false,{'eventsInfo',{true,{'points','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},'eventRefresh', }},}
		}
	end,
	[7001] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', 'tv4', 'v4', 'b', 's', 'v4', 'b', },
			{'equipCid', 'redMark', 'activeCid', 'equipFrameCid', 'frameRedMark', 'ext', 'chatFrameCid', 'chatRedMark', }
		}
	end,
	[9301] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', 's', }},{true,{'v4', 'tv4', }},},
			{{true,{'infoList','index', 'id', 'zooming', 'rotate', 'text', }},{true,{'roleActionList','roleId', 'actionId', }},}
		}
	end,
	[5219] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'maidId', }
		}
	end,
	[6401] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'b', 'b', {true,{'v4', 'pv4', 'v4', 'b', 'v4', }},},
			{'startTime', 'endTime', 'status', 'alwaysOpen', {true,{'levelInfos','cid', 'goals', 'fightCount', 'win', 'buyCount', }},}
		}
	end,
	[9205] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[9404] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewardsMsg','id', 'num', }},}
		}
	end,
	[5164] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},},
			{{true,{'campRank','camp', 'score', {true,{'innerRank','pid', 'pName', 'bestTime', 'headFrame', 'rank', 'headId', 'level', }},{false,{'selfRank','pid', 'pName', 'bestTime', 'headFrame', 'rank', 'headId', 'level', }},}},}
		}
	end,
	[1803] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', 'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},'v4', 'v4', }},},
			{{false,{'group','id', 'cid', 'fightCount', 'buyCount', {true,{'rewardInfo','key', 'list', }},'mainLineCid', 'maxMainLine', }},}
		}
	end,
	[514] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},}
		}
	end,
	[9009] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v8', 'v8', 'v4', 'v4', {true,{'v4', 'v4', 'v8', }},{true,{'v4', }},{true,{'v4', 'v4', }},{true,{'v8', 's', 'v8', 'v4', {false,{'v4', }},{true,{'v4', 'v4', }},}},}},'v4', {true,{'v4', 'v4', }},},
			{{false,{'stronghold','id', 'state', 'startTime', 'endTime', 'useSupTimes', 'progress', {true,{'event','id', 'state', 'startTime', }},{true,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},{true,{'supportRole','playerId', 'playerName', 'startTime', 'times', {false,{'role','roleId', }},{true,{'buff','buffId', 'buffLv', }},}},}},'completeStronghold', {true,{'reward','id', 'num', }},}
		}
	end,
	[3075] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'b', 'v4','v4', 'v4', 'b', 'v4', 'v4', 'tv4', 'v4', }},},
			{{true,{'friends','pid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'lastHandselTime', 'receive', 'status', 'leaderCid', 'online', 'ct','time', 'helpCDtime', 'canSend', 'portraitCid', 'portraitFrameCid', 'groupGiftIds', 'type', }},}
		}
	end,
	[517] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5382] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv4', }},},
			{{true,{'levelBuffs','levelCid', 'buff', }},}
		}
	end,
	[8202] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'indenture', }
		}
	end,
	[1566] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'approvalNum', }
		}
	end,
	[5187] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[271] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v8', 'v4', 'v8', 'v4','s', 'v4', {true,{'v4','v4', }},'b', 's', 's', 'tv4', 'v4', 'v4', {false,{{true,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},'v4', 'v4', }},'v4', 's', 'v4', 'v4', 'v4', }},{false,{{true,{'v4','v4', 'v4', 'ts', }},}},{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','v4', 'v4', 'v4', 'v4', 'b', 'v4', }},{true,{'v4', 'v4', }},},
			{{false,{'playerInfo','pid', 'name', 'lvl', 'exp', 'vip_lvl', 'vip_exp', 'language','remark', 'helpFightHeroCid', {true,{'attr','attrKey','attrVal', }},'isFirstLogin', 'clientDiscreteData', 'settings', 'recoverTimeList', 'portraitCid', 'portraitFrameCid', {false,{'element',{true,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},'rank', 'totleTrophy', }},'unionId', 'unionName', 'titleId', 'createTime', 'famousExp', }},{false,{'formationInfo',{true,{'formations','ct','type', 'status', 'stance', }},}},{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'medal','ct','cid', 'star', 'quality', 'effectTime', 'isEquip', 'createTime', }},{true,{'switch','type', 'value', }},}
		}
	end,
	[5184] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'tv4', },
			{'activityId', 'contractId', 'location', 'round', 'awardList', }
		}
	end,
	[8509] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'v4', }},'v4', }},},
			{{false,{'playerWeakness',{true,{'weakness','dungeon', 'count', }},'leftCount', }},}
		}
	end,
	[8507] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'step','step', 'nextTime', }},}
		}
	end,
	[1548] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'pv4', 'v4', 'v4', 'v4', 'b', }},},
			{{true,{'cityDatingInfo','ct','cityDatingId', 'datingTimeFrame', 'datingRuleCid', 'date', 'state', 'inDating', }},}
		}
	end,
	[5193] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', 'v8', 'v4', },
			{'friendId', 'friendName', 'timeout', 'operType', }
		}
	end,
	[2075] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'freeSpeedNum', 'speedNum', 'etime', }
		}
	end,
	[5180] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1818] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'id', 'score', 'history', }
		}
	end,
	[7302] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 's', 'v4', 'v4', 'v4', 's', 's', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'redEnvelopeInfo','ct','id', 'senderId', 'senderName', 'createTime', 'modifiedTime', 'status', 'title', 'body', {true,{'rewards','id', 'num', }},'mailType', }},}
		}
	end,
	[6145] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 's', 'v4', {true,{'v4', 's', {true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', }},}},'v4', 'v4', 'v4', {true,{'v4', 'v4', 'v4', 'v4', }},'v4', 'tv4', {true,{'v4', 'tv4', }},},
			{'fightId', 'fightServerHost', 'fightServerPort', {true,{'players','pid', 'pname', {true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},'reviveCount', 'portraitCid', 'titleId', 'unionName', 'portraitFrameId', {true,{'manaInfo','id', 'level', }},}},'randomSeed', 'dungeonCid', 'netType', {true,{'randomDungeons','dungeonId', 'index', 'branchDungeonId', 'branchIndex', }},'teamType', 'actBuffId', {true,{'itemBuff','pid', 'buffId', }},}
		}
	end,
	[5661] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[8000] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'tv4', 'tv4', {false,{'v4', 'b', }},{false,{'tv4', }},}},{false,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},}},},
			{{false,{'cellInfo','totleStep', 'location', 'buffIds', 'cellIds', {false,{'event','eventId', 'status', }},{false,{'list','buffId', }},}},{false,{'turnInfo','extraTimes', 'turnIndex', {true,{'turnTimes','turnId', 'times', }},{true,{'effectInfo','cfgId', 'effectId', }},}},}
		}
	end,
	[7602] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'manaEquipInfo','id', 'pos', }},}
		}
	end,
	[5220] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'count', }
		}
	end,
	[3079] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'inviteCode', }
		}
	end,
	[8407] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirits','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
		}
	end,
	[7829] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', {false,{'v4', 'b', 'v4', 'v4', 'v8', 'v4', 'v4', 'v8', 'v4', 'b', 'v4', {false,{'v8', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},{true,{'v4', {true,{'v4', {true,{'v4', 'v4', 'v4', }},'tv4', }},}},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', },
			{'type', 'nationId', 'cityId', {false,{'activity','id', 'first', 'localCity', 'localNation', 'startTime', 'cityAwardTimes', 'speed', 'lastAwardPointTime', 'capacity', 'isPush', 'totalRewardCount', {false,{'rewards','awardTime', 'activityId', 'nationId', 'cityId', 'dropId', {true,{'rewards','id', 'num', }},}},{true,{'nation','id', {true,{'city','id', {true,{'event','id', 'state', 'progress', }},'completeEvent', }},}},{true,{'totalRewards','id', 'num', }},{true,{'actRewards','id', 'num', }},}},'activityId', }
		}
	end,
	[7908] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[5189] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', {true,{'v4', 'v4', }},},
			{'addNum', 'itemId', 'activityId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[9207] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6611] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'mapBoxes','location', 'eventCid', }},}
		}
	end,
	[8404] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirit','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
		}
	end,
	[6704] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'type', 'param', {true,{'rewards','id', 'num', }},}
		}
	end,
	[9353] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'rewardId', }
		}
	end,
	[3078] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'b', 'v4', 's', 's', 'v4', {true,{'v4', 'v4', }},'v4', },
			{'open', 'showInviteCode', 'limitLev', 'selfInviteCode', 'bindInviteCode', 'maxBindNum', {true,{'rewardInfos','cid', 'status', }},'bindNum', }
		}
	end,
	[9232] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{false,{'clubInfo','id', 'exp', 'submitTimes', 'expLimit', }},{true,{'reward','id', 'num', }},}
		}
	end,
	[6151] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', {true,{'v4', 'b', 'v4', 'v4', }},},
			{'isOpen', 'deadline', {true,{'trainChapterInfos','id', 'isOpen', 'startTime', 'endTime', }},}
		}
	end,
	[8406] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[3337] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', 'v4', 'v4', {true,{'v4', 'v4', }},'v4', 'tv4', },
			{'summonNums', 'getRewards', 'count', 'summonType', {true,{'awards','itemId', 'itemNums', }},'remainScore', 'cidList', }
		}
	end,
	[1815] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},'tv4', },
			{{true,{'dungeons','chapterCid', 'begin', 'end', }},'CGCids', }
		}
	end,
	[4003] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[1828] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', {false,{'v4', 'v4', }},},
			{'heroId', 'level', 'lastLv', {false,{'attr','attributeId', 'value', }},}
		}
	end,
	[7834] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},},
			{'activityId', 'useTime', 'nationId', 'cityId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[1042] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', 'v4', },
			{'heroId', 'rarity', 'gridId', }
		}
	end,
	[1556] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'ts', 'v4', 'v4', 'v4', },
			{'roleId', 'returnMsg', 'state', 'type', 'sealState', }
		}
	end,
	[9008] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'reward','id', 'num', }},}
		}
	end,
	[5139] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', },
			{'name', 'contribution', }
		}
	end,
	[5899] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', },
			{'pid', 'name', }
		}
	end,
	[6203] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'eventId', 'x', 'y', }
		}
	end,
	[1033] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5378] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', },
			{'levelCid', 'buff', }
		}
	end,
	[5154] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'address', }
		}
	end,
	[1028] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', 'tv4', 'v4', }},},
			{{false,{'hero','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', 'exploreTreasureSkill', 'breakLv', }},}
		}
	end,
	[8005] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'location', 'chessesId', }
		}
	end,
	[1820] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', {true,{'v4', {true,{'v4', 'v4', }},}},}},{true,{'v4', 'v4', }},},
			{'currentFloor', {true,{'floorFormation','floor', {true,{'formation','round', {true,{'heroes','index', 'hero', }},}},}},{true,{'passFloor','floorId', 'score', }},}
		}
	end,
	[1047] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4',}},},
			{{true,{'rewards','id', 'num', }},{true,{'tasks','id', 'status',}},}
		}
	end,
	[5304] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'activityId', 'dailyGetNum', {true,{'donateNum','key', 'value', }},}
		}
	end,
	[6710] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', {true,{'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v8', 'v4', 'b', 'b', }},}},'v4', 'v4', 'v4', },
			{'stage', 'stageEnd', {true,{'cities','id', {true,{'areas','area', 'dungeon', 'resOpen', 'resCount', 'resStartTime', 'resUpTime', 'replace', 'replaceEnd', 'replaceGame', 'damage', 'score', 'pass', 'dunPass', }},}},'totalScore', 'round', 'roundScore', }
		}
	end,
	[7813] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'tv4', 'v8', 'v4', }},},
			{{true,{'task','id', 'state', 'heroId', 'startTime', 'cabinId', }},}
		}
	end,
	[5181] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'totalScore', }
		}
	end,
	[7207] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'b', },
			{{true,{'missions','missionId', 'progress', }},'completed', }
		}
	end,
	[5137] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', },
			{'serverContribution', }
		}
	end,
	[6712] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v8', 'v4', 'b', 'b', }},}},},
			{{true,{'cities','id', {true,{'areas','area', 'dungeon', 'resOpen', 'resCount', 'resStartTime', 'resUpTime', 'replace', 'replaceEnd', 'replaceGame', 'damage', 'score', 'pass', 'dunPass', }},}},}
		}
	end,
	[4376] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', 'v4', 'v4', 'b', 'b', 'b', {true,{'v4', 's', 'v4', 'v4', 'b', 'v4', 'v4', }},}},},
			{{false,{'teamInfo','teamId', 'createTime', 'giftId', 'isShow', 'isComplete', 'isDestroy', {true,{'members','playerId', 'playerName', 'titleId', 'level', 'isCreator', 'portraitCid', 'portraitFrameId', }},}},}
		}
	end,
	[6152] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'v4', }},},
			{{true,{'trainDungeonInfos','dungeonId', 'isOpen', 'fightCount', }},}
		}
	end,
	[5662] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'enter', }
		}
	end,
	[7904] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[7828] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'techType', 'nationId', {true,{'tech','techId', 'state', }},}
		}
	end,
	[5124] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 's', 'v4', 's', 'tv4', 's', }},},
			{{true,{'activitys','ct','id', 'activityType', 'activityTitle', 'startTime', 'endTime', 'showStartTime', 'showEndTime', 'remark', 'extendData', 'rank', 'showIcon', 'items', 'titleIcon', }},}
		}
	end,
	[2307] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', 's', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},},
			{{false,{'roomInfo','roomId', {true,{'msgs','channel', 'fun', 'content', 'pid', 'pname', 'lvl', 'helpFightHeroCid', 'portraitCid', 'portraitFrameCid', 'titleId', 'chatFrameCid', }},}},}
		}
	end,
	[8907] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'v8', }},'v4', },
			{{true,{'mainLogInfo','logId', 'finished', 'time', }},'type', }
		}
	end,
	[1563] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 's', },
			{'roleId', 'sTime', 'eTime', 'totalNum', 'sucNum', 'level', 'exp', 'days', 'bestQuery', 'bestReply', }
		}
	end,
	[7820] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'v4', 'v4', 'v8', 'v4', 'v4', 'v8', 'v4', 'b', 'v4', {false,{'v8', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},{true,{'v4', {true,{'v4', {true,{'v4', 'v4', 'v4', }},'tv4', }},}},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {false,{'v4', {true,{'v4', 'v4', }},}},},
			{{true,{'activity','id', 'first', 'localCity', 'localNation', 'startTime', 'cityAwardTimes', 'speed', 'lastAwardPointTime', 'capacity', 'isPush', 'totalRewardCount', {false,{'rewards','awardTime', 'activityId', 'nationId', 'cityId', 'dropId', {true,{'rewards','id', 'num', }},}},{true,{'nation','id', {true,{'city','id', {true,{'event','id', 'state', 'progress', }},'completeEvent', }},}},{true,{'totalRewards','id', 'num', }},{true,{'actRewards','id', 'num', }},}},'quickTimes', {false,{'ship','shape', {true,{'attr','systemId', 'fightPower', }},}},}
		}
	end,
	[1557] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'roleId', 'sealState', 'sealType', }
		}
	end,
	[6909] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},{true,{'v4', 'b', 'b', {true,{'v4', 'v4', 'b', }},}},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', 'b', 'tv4', },
			{{false,{'ap','value', 'limit', }},{true,{'areaInfoList','areaId', 'isDevil', 'explored', {true,{'roadInfoList','startAreaId', 'endAreaId', 'unlocked', }},}},{true,{'equipInfoList','position', 'equipId', }},'currentAreaId', 'currentChapterId', 'currentEvtId', 'isNewChapter', 'unlockChapterInfo', }
		}
	end,
	[5141] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},'s', },
			{'activityid', 'activitEntryId', {true,{'rewards','id', 'num', }},'extendData', }
		}
	end,
	[1538] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'score', }
		}
	end,
	[1569] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'roleId', 'type', 'param', }
		}
	end,
	[6155] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[278] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', },
			{'guideId', 'finish', }
		}
	end,
	[6602] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', }},},
			{{false,{'composeInfo','id', 'composeTimes', 'countDown', }},}
		}
	end,
	[6147] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7819] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', {false,{'v4', 'v4', 'v4', }},},
			{'activityId', 'nationId', 'cityId', {false,{'event','id', 'state', 'progress', }},}
		}
	end,
	[6302] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'buffCid', 'buffCount', }
		}
	end,
	[6616] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5132] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', {true,{'s', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},},
			{'activityId', {true,{'ranks','rank', 'playerId', 'playerName', 'score', 'headIcon', 'helpFightHeroId', 'level', 'frameCid', 'groupRank', {true,{'rankPlayerInfo','playerName', 'playerId', 'level', 'frameCid', 'headIcon', 'helpFightHeroId', 'heroId', }},}},}
		}
	end,
	[6149] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'b', }},},
			{{true,{'chashs','id', 'status', 'fightCount', 'buyCount', 'remainCount', 'awardStartTime', 'awardEndTime', 'isSpecial', 'finishOnce', }},}
		}
	end,
	[6607] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},},
			{{true,{'composeInfo','id', 'composeTimes', 'countDown', }},}
		}
	end,
	[6509] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'tv4', }},'tv4', },
			{{false,{'conditons','datingNodes', }},'levels', }
		}
	end,
	[1802] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},},
			{'cid', 'difficulty', 'starNum', {true,{'rewardInfo','key', 'list', }},}
		}
	end,
	[6217] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {true,{'v4', 'v4', }},},
			{'result', {true,{'exploredPoints','x', 'y', }},}
		}
	end,
	[4361] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', },
			{'totalPay', 'rewardIds', }
		}
	end,
	[2840] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},}
		}
	end,
	[1810] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[3504] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},'tv4', },
			{'activityId', {true,{'item','id', 'num', }},'scoreRewards', }
		}
	end,
	[6204] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'formation', }
		}
	end,
	[6901] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'evtId', }
		}
	end,
	[5213] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 's', 's', 's', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 's', 's', 'v4', 'v4', 'v4', }},},
			{'activityId', {true,{'rankInfo','rank', 'playerName', 'unionName', 'successTime', 'group', 'layer', 'location', }},{false,{'myRank','rank', 'playerName', 'unionName', 'successTime', 'group', 'layer', 'location', }},}
		}
	end,
	[1817] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'b', }},{true,{'v4', 'v4', }},'tv4', 'tv4', },
			{{true,{'experiment','id', 'score', 'up', }},{true,{'heroBuff','heroId', 'buffId', }},'taskList', 'attackOrder', }
		}
	end,
	[5149] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'speedLink','location', 'id', }},}
		}
	end,
	[5166] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'camp', }
		}
	end,
	[9302] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', 's', }},},
			{{false,{'picInfo','index', 'id', 'zooming', 'rotate', 'text', }},}
		}
	end,
	[7817] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},},
			{'activityId', 'nationId', 'cityId', 'eventId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[5300] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'address', }
		}
	end,
}
return tblProto