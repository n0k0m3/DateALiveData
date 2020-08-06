local tblProto = {
	[270] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[6606] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'records', }
		}
	end,
	[9101] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v8', 'tv4', {true,{'v8', 'v4', {true,{'v4', 'v4', }},}},},
			{'curPos', 'rounds', 'rewardId', 'nextRefreshTime', 'posRewarded', {true,{'records','time', 'result', {true,{'rewards','id', 'num', }},}},}
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
	[2063] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', },
			{'catchEndTime', }
		}
	end,
	[2072] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv4', }},{true,{'v8', 'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', }},'v4', },
			{{true,{'buildinginfos','buildingId', 'buildingFuns', }},{true,{'roleInRooms','dressId', 'buildingId', 'cityRoleId', }},{true,{'remindEvents','buildingId', 'funId', 'exeId', 'eventType', }},'dayType', }
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
	[5889] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', 'v4', {true,{'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', }},'v4', 'v4', 'v4', 'b', }},},
			{{false,{'team','teamId', 'leaderPid', {true,{'members','pid', 'status', 'heroCid', 'name', 'plv', 'skinCid', 'heroLevel', 'heroQuality', 'titleId', 'unionName', 'fightPower', }},'status', 'teamType', 'battleId', 'open', }},}
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
	[5893] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'type', }
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
	[2076] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},{true,{'v4', {true,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},'v4', 'v8', }},},
			{{false,{'jobEvent','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},{true,{'jobLists','buildingId', {true,{'jobInfos','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},'level', 'exp', }},}
		}
	end,
	[4367] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'id', 'buyCount', {true,{'rewards','id', 'num', }},}
		}
	end,
	[7202] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},'tv4', 'v4', 'v4', 'b', 'v4', 'v4', {true,{'v4', 'v4', }},{false,{{true,{'v4', 'v4', 'v4', }},'v4',}},{false,{'v4', 'v4', 'b', }},{false,{{true,{'v4', 'tv8', }},}},},
			{'worldCid', {true,{'items','itemId', 'itemNum', }},{true,{'missions','missionId', 'progress', }},{true,{'points','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},'formation', 'currentX', 'currentY', 'firstUse', 'mapCid', 'eventRefresh', {true,{'exploredPoints','x', 'y', }},{false,{'buffs',{true,{'buffs','buffCid', 'begining', 'useCount', }},'ct',}},{false,{'foundLocation','x', 'y', 'add', }},{false,{'hiddenEvents',{true,{'events','eventCid', 'progress', }},}},}
		}
	end,
	[4362] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'v4', {true,{'v4', 'v4', }},'v4', 's', }},},
			{{true,{'rewardCfgs','id', 'canReward', 'amount', {true,{'items','id', 'num', }},'order', 'des', }},}
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
			{{true,{'v4', {false,{'s', 'v4', 'v4', 'tv4', 'b', 'b', 'v4', 'tv4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'tv4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 's', }},{false,{'v4', 'v4', 'v4', }},}},},
			{{true,{'stores','storeId', {false,{'store','icon', 'name', 'roleSet', 'showCurrency', 'autoRefreshCorn', 'manualRefresh', 'refreshCostId', 'refreshCostNum', 'openContVal', 'openContType', 'commoditySupplyType', 'showBeginTime', 'buyBeginTime', 'buyEndTime', 'showEndTime', 'rank', 'storeType', 'openTimeType', 'extra', }},{true,{'commoditys','id', 'grid', 'order', 'openContType', 'openContVal', 'buyBeginTime', 'buyEndTime', 'sellTimeType', 'limitType', 'batchBuy', 'serLimit', 'sellDescribtion', {true,{'goodInfo','id', 'num', }},'priceType', 'priceVal', 'des', 'title', 'tag', 'autoRefreshCorn', 'showBeginTime', 'showEndTime', 'limitVal', 'extra', }},{false,{'storeRefresh','todayRefreshCount', 'totalRefreshCount', 'nextRefreshTime', }},}},}
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
	[7215] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},}},}},},
			{{false,{'eventItems','x', 'y', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}},}},}
		}
	end,
	[515] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},},
			{{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}
		}
	end,
	[6807] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 's', 'v4', },
			{'roomId', 'fightServerHost', 'fightServerPort', }
		}
	end,
	[5146] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'activityid', 'propId', {true,{'rewards','id', 'num', }},}
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
	[6225] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},'v4',},
			{{true,{'buffs','buffCid', 'begining', 'useCount', }},'ct',}
		}
	end,
	[6819] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'dayTimes', }
		}
	end,
	[5143] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 's', 's', 's', 's', 'v4', 'v4', }},},
			{{true,{'items','id', 'type', 'name', 'details', 'target', 'reward', 'extendData', 'rank', 'subType', }},}
		}
	end,
	[8608] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv4', }},},
			{{true,{'heroes','type', 'heroes', }},}
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
	[8409] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[284] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'anti', }
		}
	end,
	[4374] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'b', 'v4',}},},
			{{true,{'fundInfo','id', 'restDays', 'todayAward', 'ct',}},}
		}
	end,
	[6658] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'rewards','id', 'num', }},}
		}
	end,
	[1567] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6804] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 'v4', {false,{'v4', 'v4', 'v4', }},}},},
			{{false,{'playerInfo','pid', 'pname', 'level', 'heroCid', 'skinCid', 'unionId', 'unionName', 'titleId', {false,{'pos','x', 'y', 'dir', }},}},}
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
			{'s', 's', 'v4', },
			{'roomId', 'fightServerHost', 'fightServerPort', }
		}
	end,
	[2828] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},}},},
			{'equipmentId', {true,{'recycleInfo','type', {true,{'costItem','id', 'num', }},{true,{'returnItem','id', 'num', }},}},}
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
	[4357] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', }},},
			{{true,{'info','ct','cid', 'buy_count', }},}
		}
	end,
	[2073] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', },
			{'isSuccess', 'eventType', }
		}
	end,
	[7217] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'b', {true,{'v4', 'v4', }},}},},
			{{false,{'exploreInfo','result', {true,{'exploredPoints','x', 'y', }},}},}
		}
	end,
	[288] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'b', 's', 'b', 'v4', }},},
			{{true,{'buttonShowInfos','openWelfare', 'welfareUrl', 'isShowRed', 'type', }},}
		}
	end,
	[3585] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 's', 's', 's', 's', }},},
			{{true,{'billBoardNotice','type', 'index', 'tag', 'title', 'content', 'contextImg', 'param', }},}
		}
	end,
	[2062] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v8', 'v8', 'v4', },
			{'eggPool', 'pollRefreshCdEndTime', 'catchEndTime', 'eggPoolId', }
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
			{{false,{'v4', {true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},},
			{{false,{'netFrame','index', {true,{'operateFrame','pid', 'keyCode', 'keyEvent', 'keyEventEx', 'posX', 'posY', 'dir', 'hp', 'sp', }},{true,{'dataFrame','pid', 'action', }},{true,{'bossFrame','id', 'posX', 'posY', 'dir', 'hp', 'operate', 'sp', }},}},}
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
	[8506] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'fdAward','dungeon', 'status', }},{true,{'passAward','dungeon', 'status', }},}
		}
	end,
	[1285] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', }},},
			{{true,{'Rolestatus','roleId', 'status', }},}
		}
	end,
	[6814] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'dayRecord','difficulty', 'count', }},{true,{'weekRecord','difficulty', 'count', }},}
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
			{'v4', {false,{'v4', 's', 'v4', 'v8', 'v4', 'v8', 'v4','s', 'v4', {true,{'v4','v4', }},'b', 's', 's', 'tv4', 'v4', 'v4', {false,{{true,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},'v4', 'v4', }},'v4', 's', 'v4', }},'v4', 'v4', },
			{'serverTime', {false,{'playerinfo','pid', 'name', 'lvl', 'exp', 'vip_lvl', 'vip_exp', 'language','remark', 'helpFightHeroCid', {true,{'attr','attrKey','attrVal', }},'isFirstLogin', 'clientDiscreteData', 'settings', 'recoverTimeList', 'portraitCid', 'portraitFrameCid', {false,{'element',{true,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},'rank', 'totleTrophy', }},'unionId', 'unionName', 'titleId', }},'queue', 'queueTime', }
		}
	end,
	[4869] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'eTypes','elementType', 'type', }},}
		}
	end,
	[6503] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', 'v4', },
			{'rankType', {true,{'ranks','rank', 'playerId', 'playerName', 'score', 'headIcon', 'helpFightHeroId', 'level', 'frameCid', }},'myRank', 'myScore', }
		}
	end,
	[5152] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 's', },
			{'actType', 'actId', 'jsonData', }
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
	[5892] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6215] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},}},},
			{'x', 'y', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}},}
		}
	end,
	[4097] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v4', }},},
			{{true,{'taks','ct','id', 'cid', 'progress', 'status', }},}
		}
	end,
	[261] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7216] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},}},},
			{{false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}},}
		}
	end,
	[6654] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', },
			{'type', 'param', }
		}
	end,
	[2839] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},}
		}
	end,
	[3340] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'b', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{false,{'info','noobStatus', 'endTime', 'summonCount', 'awardState', }},{true,{'item','id', 'num', }},}
		}
	end,
	[4358] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','v4', 'v4', },
			{'ct','cid', 'buy_count', }
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
			{'v4', },
			{'cid', }
		}
	end,
	[8301] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', 'v4', {false,{'v4', 'v4', 'v4', {true,{'s', 'v4', }},{true,{'s', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4', 'pv4', 'v4', 'b', 'v4', }},}},'v4', 'tv4', }},{true,{'v4', 'v4', }},'b', 'v4', }},},
			{{false,{'info','step', 'historyBest', 'todayBest', 'seasonBalance', 'nextStepTime', {false,{'curCycle','segment', 'laderScore', 'cardPoint', {true,{'boundEquips','itemId', 'heroCid', }},{true,{'boundNewEquips','itemId', 'heroCid', }},{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},{true,{'heroCount','itemCid', 'count', }},{true,{'cardCount','itemCid', 'count', }},'usingCards', {true,{'levelInfos','battleScore', {false,{'levelInfo','cid', 'goals', 'fightCount', 'win', 'buyCount', }},}},'battleScore', 'regionBuffs', }},{true,{'cardInfos','cardId', 'cardLv', }},'showTips', 'clientSeason', }},}
		}
	end,
	[7226] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv8', }},},
			{{true,{'events','eventCid', 'progress', }},}
		}
	end,
	[5191] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', },
			{'entityId', 'address', }
		}
	end,
	[1803] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', 'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},'v4', 'v4', }},},
			{{false,{'group','id', 'cid', 'fightCount', 'buyCount', {true,{'rewardInfo','key', 'list', }},'mainLineCid', 'maxMainLine', }},}
		}
	end,
	[2832] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'isSuccess', }
		}
	end,
	[293] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'recoverTimeList', }
		}
	end,
	[7106] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', }},}},},
			{{false,{'complteEvents','areaCid', {true,{'events','cid', 'num', }},}},}
		}
	end,
	[3586] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'content', }
		}
	end,
	[514] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},}
		}
	end,
	[7104] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'finTasks', }
		}
	end,
	[1026] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', },
			{'ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }
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
	[6666] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4','v8', }},},
			{{true,{'member','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'degree', 'weekContribution', 'allContribution', 'ct','joinTime', }},}
		}
	end,
	[5193] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 's', 'v4', 'v4', }},{true,{'v4', 's', 'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'b', },
			{'id', {true,{'allCrazyDiamondRank','playerId', 'playerName', 'itemId', 'itemNum', }},{true,{'ownCrazyDiamondRank','playerId', 'playerName', 'itemId', 'itemNum', }},{true,{'rewards','id', 'num', }},'surplusDraw', 'isDraw', }
		}
	end,
	[9151] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'workLists', }
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
			{{true,{'v4', {false,{'s', 'v4', 'v4', 'tv4', 'b', 'b', 'v4', 'tv4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'tv4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 's', }},{false,{'v4', 'v4', 'v4', }},}},},
			{{true,{'stores','storeId', {false,{'store','icon', 'name', 'roleSet', 'showCurrency', 'autoRefreshCorn', 'manualRefresh', 'refreshCostId', 'refreshCostNum', 'openContVal', 'openContType', 'commoditySupplyType', 'showBeginTime', 'buyBeginTime', 'buyEndTime', 'showEndTime', 'rank', 'storeType', 'openTimeType', 'extra', }},{true,{'commoditys','id', 'grid', 'order', 'openContType', 'openContVal', 'buyBeginTime', 'buyEndTime', 'sellTimeType', 'limitType', 'batchBuy', 'serLimit', 'sellDescribtion', {true,{'goodInfo','id', 'num', }},'priceType', 'priceVal', 'des', 'title', 'tag', 'autoRefreshCorn', 'showBeginTime', 'showEndTime', 'limitVal', 'extra', }},{false,{'storeRefresh','todayRefreshCount', 'totalRefreshCount', 'nextRefreshTime', }},}},}
		}
	end,
	[2078] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},'v4', 'v8', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v8', },
			{{false,{'jobList','buildingId', {true,{'jobInfos','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},'level', 'exp', }},{true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'addExp', }
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
			{{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'b', 's', 's', }},},
			{{false,{'union','id', 'name', 'level', 'icon', 'memberCount', 'memberCountMax', 'active', 'limitLevel', 'limitPower', 'apply', 'canApply', 'leaderName', 'notice', }},}
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
			{{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},},
			{{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},}
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
	[5137] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', },
			{'serverContribution', }
		}
	end,
	[5135] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4',{true,{'v4', {true,{'v4', 'v4', }},}},'tv4', {true,{'v4', 'v4', 'v4', }},},
			{'ct',{true,{'drawRecord','drawId', {true,{'drawRecord','itemId', 'num', }},}},'drawId', {true,{'dating','type', 'winNum', 'loseNum', }},}
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
	[1291] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'rotationState', }
		}
	end,
	[5898] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', {true,{'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', }},'v4', 'v4', 'v4', 'b', },
			{'teamId', 'leaderPid', {true,{'members','pid', 'status', 'heroCid', 'name', 'plv', 'skinCid', 'heroLevel', 'heroQuality', 'titleId', 'unionName', 'fightPower', }},'status', 'teamType', 'battleId', 'open', }
		}
	end,
	[8305] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},},
			{{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},}
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
	[6902] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'ap','value', 'limit', }},}
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
	[6208] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'infections','heroId', 'infection', }},}
		}
	end,
	[8303] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},{false,{'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'rankList',{true,{'rankList','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},{false,{'rank','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},}},{false,{'seasonData','segment', 'laderScore', {true,{'rewards','id', 'num', }},'clientSeason', }},}
		}
	end,
	[772] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 's', 'v4', 'v4', 'v4', 's', 's', {true,{'v4', 'v4', }},}},},
			{{true,{'mails','ct','id', 'senderId', 'senderName', 'createTime', 'modifiedTime', 'status', 'title', 'body', {true,{'rewards','id', 'num', }},}},}
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
	[6661] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', 'v4', 'v4', 'v8', 's', 'v4', {true,{'s', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', },
			{'id', 'blessing', 'count', 'senderId', 'createTime', 'senderName', 'moneyTempId', {true,{'record','playerId', 'playerName', 'openCount', 'leaderCid', 'portraitCid', 'portraitFrameCid', 'createTime', }},'status', 'senderLeaderCid', 'senderPortraitCid', 'senderPortraitFrameCid', }
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
	[263] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 's', 's', 's', 's', }},},
			{{true,{'info','id', 'inx', 'type', 'tag', 'title', 'context', 'contextImg', }},}
		}
	end,
	[7204] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'formation', }
		}
	end,
	[5165] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[5159] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},'tv4', {true,{'v4', 'v4', }},},
			{{false,{'cardInfo','pos', 'id', }},'cardId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[1035] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},},
			{{false,{'hero','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},}
		}
	end,
	[3003] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
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
	[2307] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', 's', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},},
			{{false,{'roomInfo','roomId', {true,{'msgs','channel', 'fun', 'content', 'pid', 'pname', 'lvl', 'helpFightHeroCid', 'portraitCid', 'portraitFrameCid', 'titleId', 'chatFrameCid', }},}},}
		}
	end,
	[5153] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', 'v4', },
			{'activityId', {true,{'ranks','rank', 'playerId', 'playerName', 'score', 'headIcon', 'helpFightHeroId', 'level', 'frameCid', }},'myRank', 'myScore', }
		}
	end,
	[1557] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'roleId', 'sealState', 'sealType', }
		}
	end,
	[2562] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'goods','id', 'num', }},}
		}
	end,
	[8403] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirit','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
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
	[5223] = function()
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
	[6703] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6801] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 'v4', {false,{'v4', 'v4', 'v4', }},}},},
			{{true,{'playerInfos','pid', 'pname', 'level', 'heroCid', 'skinCid', 'unionId', 'unionName', 'titleId', {false,{'pos','x', 'y', 'dir', }},}},}
		}
	end,
	[3077] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
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
	[2071] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv4', }},{true,{'v8', 'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', }},'v4', },
			{{true,{'buildinginfos','buildingId', 'buildingFuns', }},{true,{'roleInRooms','dressId', 'buildingId', 'cityRoleId', }},{true,{'remindEvents','buildingId', 'funId', 'exeId', 'eventType', }},'dayType', }
		}
	end,
	[4368] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'rechargeId', }
		}
	end,
	[518] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'v4', },
			{'preNum', 'afterNum', 'roleId', 'itemId', 'state', }
		}
	end,
	[2305] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'time', }
		}
	end,
	[1286] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', }},},
			{{true,{'infos','roleId', 'mood', }},}
		}
	end,
	[5377] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', {false,{{true,{'v4', 'v4', }},}},}},},
			{{false,{'info','step', 'historyBest', 'todayBest', 'todayCostTime', 'nextStepTime', 'curStage', 'nonStopStage', {false,{'heroHealth',{true,{'heroHealth','heroCid', 'health', }},}},}},}
		}
	end,
	[6607] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},},
			{{true,{'composeInfo','id', 'composeTimes', 'countDown', }},}
		}
	end,
	[5634] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', },
			{'datingType', 'first', }
		}
	end,
	[3075] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'b', 'v4','v4', 'v4', 'b', 'v4', 'v4', }},},
			{{true,{'friends','pid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'lastHandselTime', 'receive', 'status', 'leaderCid', 'online', 'ct','time', 'helpCDtime', 'canSend', 'portraitCid', 'portraitFrameCid', }},}
		}
	end,
	[7210] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'ambushId', }
		}
	end,
	[8313] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'cardCount','itemCid', 'count', }},}
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
			{{true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},}},'v4', {false,{'v4','v4', 'v4', 'ts', }},},
			{{true,{'heros','limitId', {false,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},}},'leveId', {false,{'limitFormation','ct','type', 'status', 'stance', }},}
		}
	end,
	[1796] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'pv4', 'v4', 'b', 'v4', }},}},{false,{{true,{'s', 'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},'v4', 'v4', }},}},},
			{{false,{'levelInfos',{true,{'levelInfos','cid', 'goals', 'fightCount', 'win', 'buyCount', }},}},{false,{'groups',{true,{'group','id', 'cid', 'fightCount', 'buyCount', {true,{'rewardInfo','key', 'list', }},'mainLineCid', 'maxMainLine', }},}},}
		}
	end,
	[4373] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},'v4', },
			{'giftId', {true,{'item','id', 'num', }},'receiveCount', }
		}
	end,
	[2837] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},},
			{{false,{'gem','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}
		}
	end,
	[6655] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'index', {true,{'rewards','id', 'num', }},}
		}
	end,
	[1554] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},'v4', },
			{'datingRuleCid', {true,{'rewards','id', 'num', }},'outTime', }
		}
	end,
	[2312] = function()
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
	[1044] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {false,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},},
			{'heroId', {false,{'skillStrategy','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},}
		}
	end,
	[6701] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2836] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},},
			{{false,{'gem','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}
		}
	end,
	[1029] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v8', 'v4', },
			{'id', 'exp', 'cid', }
		}
	end,
	[2079] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},{false,{'v4', {true,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},'v4', 'v8', }},},
			{{false,{'jobEvent','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},{false,{'jobList','buildingId', {true,{'jobInfos','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},'level', 'exp', }},}
		}
	end,
	[4372] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{false,{'v4', 'f4', }},'v4', {true,{'v4', 'v4', }},'s', 's', 'b', 's', 's', 's', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'pv4', {true,{'v4', 'v4', }},'s', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'v4', 'v4', 'v4', 'b', 'v4', }},},
			{{false,{'rechargeGiftBagCfg',{false,{'rechargeCfg','id', 'price', }},'type', {true,{'item','id', 'num', }},'name', 'icon', 'tag', 'tagDes', 'tagDes2', 'des1', 'des2', 'order', 'startDate', 'endDate', 'buyCount', 'resetType', 'resetDate', 'playerLevel', {true,{'firstBuyItem','id', 'num', }},'name2', 'des3', 'tagIcon', 'interfaceType', 'buyType', {true,{'exchangeCost','id', 'num', }},'packType', 'originalPrice', 'discount', 'triggerEndDate', 'isTrigger', 'days', }},}
		}
	end,
	[5149] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'speedLink','location', 'id', }},}
		}
	end,
	[5163] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', {true,{'v4', 'v4', 'b', 'v4', 'v4', 'b', 'v4', 'tv4', 'v4', 'v4', 'v4', 'b', 'b', }},},
			{'camp', 'stage', 'stageEnd', {true,{'cities','id', 'dungeon', 'resOpen', 'resCount', 'resUpTime', 'invaded', 'invadedEnd', 'invadedCamp', 'resStartTime', 'fightTime', 'score', 'pass', 'dunPass', }},}
		}
	end,
	[8701] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', 'v4', 's', 'v4', 'v4', },
			{'joinStatus', 'rewardStatus', 'joinNum', 'address', 'realPrize', 'realRound', }
		}
	end,
	[283] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'status', 'time', }
		}
	end,
	[9303] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'tv4', }},},
			{{false,{'roleAction','roleId', 'actionId', }},}
		}
	end,
	[3333] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},},
			{{true,{'composeInfos','cid', 'finishTime', {true,{'items','id', 'num', }},'costTime', }},}
		}
	end,
	[2822] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', },
			{'ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }
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
	[1025] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},},
			{{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},}
		}
	end,
	[6501] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v8', {true,{'v4', {true,{'v4', 'v4', }},}},'v4', 'v8', 'v4', 'v4', 'tv4', 'v4', {true,{'v4', 'v4', }},'tv4', 'b', },
			{'bossDungeonId', 'serverContribution', {true,{'nodeStatus','contribution', {true,{'nodeRewards','id', 'num', }},}},'odeumType', 'closeTime', 'status', 'lingbo', 'lingboGroup', 'receiveStatus', {true,{'selfContriRewards','id', 'num', }},'selfContriPrizeStatus', 'fightState', }
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
			{{true,{'v4','s', 'v4', 's', 'v4', 'v4', 'v4', 's', 's', {true,{'v4', 'v4', }},}},},
			{{true,{'redEnvelopeInfo','ct','id', 'senderId', 'senderName', 'createTime', 'modifiedTime', 'status', 'title', 'body', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[1551] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'datingRuleCid', }
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
	[9150] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},{false,{'v8', 'v4', 'v4', 'v4', 'tv4', }},'tv4', {false,{{true,{'v4', 'b', }},'v4', 'v4', 'v4', }},'v4', },
			{{true,{'maidObjects','onlyId', 'cid', 'strength', }},{false,{'maidInfo','totle', 'customer', 'cost', 'turnOver', 'attributes', }},'workLists', {false,{'recruitInfo',{true,{'recruits','cid', 'state', }},'nextTime', 'recruitTimes', 'recruitBuyTimes', }},'enterType', }
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
	[519] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'originItem','id', 'num', }},{true,{'convertItem','id', 'num', }},}
		}
	end,
	[25609] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', 'v4', }},},
			{'time', {true,{'data','pid', 'delayTime', }},}
		}
	end,
	[1544] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[8402] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirit','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
		}
	end,
	[2311] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{'roomId', {true,{'msgs','channel', 'fun', 'content', 'pid', 'pname', 'lvl', 'helpFightHeroCid', 'portraitCid', 'portraitFrameCid', 'titleId', 'chatFrameCid', }},}
		}
	end,
	[266] = function()
		return {
			{"net.NetHelper", "receive"},
			{'pv4', 'v4', 'v4', },
			{'x1', 'x2', 'x3', }
		}
	end,
	[8202] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'indenture', }
		}
	end,
	[9152] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', }},},
			{{false,{'maidObject','onlyId', 'cid', 'strength', }},}
		}
	end,
	[1046] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 'v4', 'v4', {true,{'v4', 'tv4', {true,{'v4', 'v4',}},}},},
			{'isOpen', 'startTime', 'endTime', {true,{'info','heroId', 'dungeonId', {true,{'tasks','id', 'status',}},}},}
		}
	end,
	[1540] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},'v4', 'tv4', 'b', 'v4', },
			{'score', 'favor', {true,{'rewards','id', 'num', }},'scriptId', 'starList', 'obsolete', 'endId', }
		}
	end,
	[4360] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{{false,{'v4', 'f4', }},'v4', 's', 's', 's', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 's', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', }},{true,{{false,{'v4', 'f4', }},'v4', {true,{'v4', 'v4', }},'s', 's', 'b', 's', 's', 's', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'pv4', {true,{'v4', 'v4', }},'s', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'v4', 'v4', 'v4', 'b', 'v4', }},},
			{{true,{'monthCardCfg',{false,{'rechargeCfg','id', 'price', }},'upgradeId', 'icon', 'name', 'des1', {true,{'presentItem','id', 'num', }},{true,{'gainItem','id', 'num', }},'days', 'type', 'name2', 'des3', 'tagIcon', 'interfaceType', 'buyType', {true,{'exchangeCost','id', 'num', }},'packType', }},{true,{'rechargeGiftBagCfg',{false,{'rechargeCfg','id', 'price', }},'type', {true,{'item','id', 'num', }},'name', 'icon', 'tag', 'tagDes', 'tagDes2', 'des1', 'des2', 'order', 'startDate', 'endDate', 'buyCount', 'resetType', 'resetDate', 'playerLevel', {true,{'firstBuyItem','id', 'num', }},'name2', 'des3', 'tagIcon', 'interfaceType', 'buyType', {true,{'exchangeCost','id', 'num', }},'packType', 'originalPrice', 'discount', 'triggerEndDate', 'isTrigger', 'days', }},}
		}
	end,
	[4867] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},{true,{'v4', 'v4', }},},
			{{false,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},{true,{'rewardlist','id', 'num', }},}
		}
	end,
	[6663] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 's', {true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},},
			{{true,{'record','playerId', 'playerName', {true,{'rewards','id', 'num', }},'leaderCid', 'portraitCid', 'portraitFrameCid', }},}
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
	[5635] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', },
			{'datingType', 'datingValue', {true,{'items','id', 'num', }},{true,{'endItems','id', 'num', }},{true,{'costItems','id', 'num', }},{true,{'quality','qualityId', 'value', }},'stepEnd', 'endId', }
		}
	end,
	[6202] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},'tv4', {true,{'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', {true,{'v4', 'v4', }},{false,{{true,{'v4', 'v4', 'v4', }},'v4',}},{false,{'v4', 'v4', 'b', }},{false,{{true,{'v4', 'tv8', }},}},},
			{'worldCid', {true,{'items','itemId', 'itemNum', }},{true,{'missions','missionId', 'progress', }},{true,{'points','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},'formation', {true,{'infections','heroId', 'infection', }},'qliphothCoin', 'qliphothEnergy', 'currentX', 'currentY', 'firstUse', 'mapCid', 'eventRefresh', {true,{'exploredPoints','x', 'y', }},{false,{'buffs',{true,{'buffs','buffCid', 'begining', 'useCount', }},'ct',}},{false,{'foundLocation','x', 'y', 'add', }},{false,{'hiddenEvents',{true,{'events','eventCid', 'progress', }},}},}
		}
	end,
	[1283] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','s', 'v4', 'v4', 'v4', 'v4', 'pv4', 'pv4', {false,{'v4','s', 'v4', 's', 'v4', }},'v4', 'b', 'v4', 'tv4', 'b', },
			{'ct','id', 'cid', 'favor', 'mood', 'status', 'unlockGift', 'unlockHobby', {false,{'dress','ct','id', 'cid', 'roleId', 'outTime', }},'roomId', 'favorCriticalPoint', 'roleState', 'favoriteIds', 'isShow', }
		}
	end,
	[8505] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},{true,{'passAward','dungeon', 'status', }},}
		}
	end,
	[6511] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'datingNodes', }
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
	[3093] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4',}},}},},
			{{false,{'friendHelpInfo','playerId', 'playerName', 'portraitCid', 'portraitFrameCid', 'level', {true,{'taskInfos','taskId', 'status',}},}},}
		}
	end,
	[273] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'players','pid', 'name', 'lvl', 'helpHeroCid', 'coldDownTime', 'helpHeroFightPower', 'portraitCid', }},}
		}
	end,
	[8311] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'card','cardId', 'cardLv', }},}
		}
	end,
	[5220] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', 'v4', 'v4', {true,{'v4', 'v4', }},'v4', },
			{'diceNum', 'moveTrack', 'eventId', 'chooseStatus', {true,{'reward','id', 'num', }},'totalCircel', }
		}
	end,
	[25605] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {true,{'v4', 'v4', 'b', }},{true,{'v4', 'v4', }},'v4', 'b', 'v8', },
			{'win', {true,{'results','pid', 'hurt', 'mvp', }},{true,{'rewards','id', 'num', }},'fightTime', 'isSpecial', 'huntingHonor', }
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
	[6812] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'newLeaderId', }
		}
	end,
	[1562] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', },
			{'roleId', 'intimacy', 'chatDays', 'hateVal', }
		}
	end,
	[1580] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'awardId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6227] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},}},},
			{'eventCid', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}},}
		}
	end,
	[1036] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},'s', },
			{{false,{'hero','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},'beforeSkinId', }
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
			{{true,{'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 'tv4', 'tv4', }},'v4', 'tv4', 'v4', 'tv4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', }},}},{false,{'b', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', 'v4', }},},
			{{true,{'summonInfo','summonId', 'summstart', 'summend', 'startShow', 'endShow', {true,{'summonShow','count', 'itemId', 'itemNums', }},'summonNums', 'getRewards', 'count', 'equipRewards', 'remainScore', 'cardNum', 'dayTimes', {true,{'cardPrizes','id', 'num', }},}},{false,{'noobInfo','noobStatus', 'endTime', 'summonCount', 'awardState', }},{true,{'personalSummons','summonType', 'summend', 'summonNums', }},}
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
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4','v8', }},},
			{{true,{'members','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'degree', 'weekContribution', 'allContribution', 'ct','joinTime', }},}
		}
	end,
	[7405] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'datingCids', }
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
	[6229] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},}},'tv4', },
			{'eventCid', 'gameCid', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}},'options', }
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
			{{false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},}},},
			{{false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}},}
		}
	end,
	[6913] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1043] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', 'v4', }},'v4', },
			{'heroId', {true,{'attr','type', 'val', }},'fightPower', }
		}
	end,
	[3073] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'b', 'v4','v4', 'v4', 'b', 'v4', 'v4', }},'v4', 'v4', },
			{{true,{'friends','pid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'lastHandselTime', 'receive', 'status', 'leaderCid', 'online', 'ct','time', 'helpCDtime', 'canSend', 'portraitCid', 'portraitFrameCid', }},'receiveCount', 'lastReceiveTime', }
		}
	end,
	[5380] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'rankList','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},{false,{'rank','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},'refreshMinu', {true,{'lastCycleList','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},{false,{'lastCycleRank','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},{true,{'presentRankList','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},{false,{'presentRank','pid', 'pName', 'stage', 'costTime', 'rank', 'headId', 'level', }},}
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
	[1809] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', }},},
			{{true,{'multipleInfo','groupId', 'multiple', 'topStarsLevel', }},}
		}
	end,
	[280] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'b', }},},
			{{true,{'switchs','ct','switchType', 'open', }},}
		}
	end,
	[5637] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'v4', {true,{'v4', 'b', }},{true,{'v4', 'v4', }},}},},
			{{false,{'info','datingType', 'datingValue', {true,{'bag','id', 'num', }},'endings', 'stepTime', {true,{'entrances','entranceId', 'guide', }},{true,{'quality','qualityId', 'value', }},}},}
		}
	end,
	[3343] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', },
			{'heroHotSummonOrder', 'heroHotSummonTime', 'equipHotSummonOrder', 'equipHotSummonTime', 'hotHeroSummonScore', 'hotEquipSummonScore', }
		}
	end,
	[2067] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'foodId', 'endTime', 'times', }
		}
	end,
	[262] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7003] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'portraitType', }
		}
	end,
	[6802] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {false,{'v4', 'v4', 'v4', }},}},},
			{{true,{'playerInfos','pid', {false,{'pos','x', 'y', 'dir', }},}},}
		}
	end,
	[3344] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', {true,{'v4', 'v4', 'v4', 'v4', 'v4', 'b', }},}},},
			{{true,{'summonPreview','groupId', 'type', 'typeName', {true,{'previewItems','id', 'order', 'name', 'probability', 'noobProbability', 'showUpTips', }},}},}
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
	[5126] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 's', 'v4', 's', 'tv4', 's', }},},
			{{true,{'activitys','ct','id', 'activityType', 'activityTitle', 'startTime', 'endTime', 'showStartTime', 'showEndTime', 'remark', 'extendData', 'rank', 'showIcon', 'items', 'titleIcon', }},}
		}
	end,
	[1542] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'pv4', }},'b', 's', },
			{'datingRuleCid', {true,{'branchNodes','datingId', 'nextNodeIds', }},'isFirst', 'datingId', }
		}
	end,
	[2861] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 's', {true,{'v4', 'v4', }},},
			{'equipId', 'costEquipId', {true,{'items','id', 'num', }},}
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
	[9153] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'b', }},'v4', 'v4', 'v4', }},'v4', },
			{{false,{'recruitInfo',{true,{'recruits','cid', 'state', }},'nextTime', 'recruitTimes', 'recruitBuyTimes', }},'addRecruitId', }
		}
	end,
	[5660] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'tv4', {true,{'v4', 'v4', }},},
			{{true,{'qualityInfo','qualityId', 'value', }},'signList', {true,{'items','id', 'num', }},}
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
	[2068] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', },
			{'foodId', 'qteId', 'integral', 'qteIntegral', }
		}
	end,
	[5221] = function()
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
			{{true,{'v4','v4', 'v4', }},},
			{{true,{'logs','ct','cid', 'count', }},}
		}
	end,
	[6904] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'b', {true,{'v4', 'v4', 'b', }},}},'v4', },
			{{true,{'areaInfoList','areaId', 'isDevil', 'explored', {true,{'roadInfoList','startAreaId', 'endAreaId', 'unlocked', }},}},'currentAreaId', }
		}
	end,
	[1289] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[3092] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', {true,{'v4', 'v4',}},}},{true,{'v4', 'v4', }},},
			{{true,{'friendHelpInfos','playerId', 'playerName', 'portraitCid', 'portraitFrameCid', 'level', {true,{'taskInfos','taskId', 'status',}},}},{true,{'rewardItems','id', 'num', }},}
		}
	end,
	[8707] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'num', }
		}
	end,
	[7002] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'portraitType', 'equipCid', 'changCid', }
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
			{'v4', {false,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},'s', 'v4', {true,{'v4', 'v4', }},'v4', {true,{'v4', 'v4', }},'b', },
			{'levelCid', {false,{'hero','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},'fightId', 'randomSeed', {true,{'rewards','id', 'num', }},'helpPid', {true,{'limitHeros','limitType', 'limitCid', }},'isDuelMod', }
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
	[1552] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7224] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'b', }},},
			{{false,{'eventInfo','x', 'y', 'add', }},}
		}
	end,
	[1548] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'pv4', 'v4', 'v4', 'v4', 'b', }},},
			{{true,{'cityDatingInfo','ct','cityDatingId', 'datingTimeFrame', 'datingRuleCid', 'date', 'state', 'inDating', }},}
		}
	end,
	[2838] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},}
		}
	end,
	[294] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'record', }
		}
	end,
	[8307] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},},
			{{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},}
		}
	end,
	[5161] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[3501] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'tv4', 'tv4', },
			{'activityId', 'score', 'refreshCount', 'scoreRewards', 'summonedList', }
		}
	end,
	[5164] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},},
			{{true,{'campRank','camp', 'score', {true,{'innerRank','pid', 'pName', 'bestTime', 'headFrame', 'rank', 'headId', 'level', }},{false,{'selfRank','pid', 'pName', 'bestTime', 'headFrame', 'rank', 'headId', 'level', }},}},}
		}
	end,
	[6101] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'b', {true,{'v4', 'v4', }},}},},
			{{true,{'shareInfos','id', 'statue', 'show', {true,{'rewards','id', 'num', }},}},}
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
	[8508] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'tv4', 'v4', }},},
			{{false,{'boss','curDungeon', 'dungeonHp', 'leftCount', 'dungeonBuffs', 'honor', }},}
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
	[5653] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'favorRoleStatue','favorDatingId', 'statue', }},}
		}
	end,
	[8310] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'usingCards', }
		}
	end,
	[4003] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[1804] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'pv4', 'v4', 'b', 'v4', }},},
			{{true,{'levelInfos','cid', 'goals', 'fightCount', 'win', 'buyCount', }},}
		}
	end,
	[2566] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', }},},
			{{true,{'datas','ct','data', }},}
		}
	end,
	[6514] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'id', 'chapterId', }
		}
	end,
	[6613] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', {true,{'v4', 'b', }},},
			{'refreshCount', 'refreshTime', 'helpCount', {true,{'levels','cid', 'pass', }},}
		}
	end,
	[3011] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'cid', }
		}
	end,
	[8151] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'id', }
		}
	end,
	[9104] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'info','pid', 'pName', 'headId', 'frameId', 'rank', 'rounds', 'lvl', }},{false,{'self','pid', 'pName', 'headId', 'frameId', 'rank', 'rounds', 'lvl', }},}
		}
	end,
	[8407] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirits','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
		}
	end,
	[1801] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},'v4', 'v4', }},},
			{{true,{'group','id', 'cid', 'fightCount', 'buyCount', {true,{'rewardInfo','key', 'list', }},'mainLineCid', 'maxMainLine', }},}
		}
	end,
	[2840] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},}
		}
	end,
	[9105] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v8', },
			{'rewardId', 'nextRefreshTime', }
		}
	end,
	[285] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'pid', }
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
	[8705] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1290] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'rotationList', }
		}
	end,
	[7225] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'v4', 'v4', }},'v4',}},},
			{{false,{'buffInfo',{true,{'buffs','buffCid', 'begining', 'useCount', }},'ct',}},}
		}
	end,
	[8702] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', }},},
			{{true,{'list','pid', 'pName', 'headId', 'headFrame', 'level', 'fightPower', 'round', 'prize', 'sid', 'channel', }},}
		}
	end,
	[8102] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {true,{'v4', 'v4', }},}},},
			{{false,{'eventInfo','eventId', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[8704] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[7401] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v8', }},},
			{'circleMinu', {true,{'rankInfo','roleid', 'privity', }},}
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
	[5902] = function()
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
	[7404] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'datingCid', }
		}
	end,
	[1800] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'cid', }
		}
	end,
	[6657] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'buildingId', 'targetLevel', }
		}
	end,
	[25606] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},}},},
			{{true,{'netFrames','index', {true,{'operateFrame','pid', 'keyCode', 'keyEvent', 'keyEventEx', 'posX', 'posY', 'dir', 'hp', 'sp', }},{true,{'dataFrame','pid', 'action', }},{true,{'bossFrame','id', 'posX', 'posY', 'dir', 'hp', 'operate', 'sp', }},}},}
		}
	end,
	[6650] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 's', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4',}},{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4','v8', }},'b', 'b', 'b', 'v4', 'v4', 'v8', 'v4', 'tv4', 'v4', 'v4', 'v4', 'v4', }},},
			{'succ', {false,{'union','id', 'name', 'level', 'icon', 'memberCount', 'exp', 'leaderName', 'notice', {true,{'applyList','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'ct',}},{true,{'members','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'degree', 'weekContribution', 'allContribution', 'ct','joinTime', }},'canApply', 'autoJoin', 'joinLimit', 'limitLevel', 'limitPower', 'delateEndTime', 'weekExp', 'weekExpPrizeReceiveIndex', 'lastWeekActive', 'receiveTimes', 'goldRedpacketTime', 'rechargeRedpacketTime', }},}
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
	[6651] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'b', 's', 's', }},},
			{{true,{'union','id', 'name', 'level', 'icon', 'memberCount', 'memberCountMax', 'active', 'limitLevel', 'limitPower', 'apply', 'canApply', 'leaderName', 'notice', }},}
		}
	end,
	[6653] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'degree', 'target', }
		}
	end,
	[6662] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 's', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4',}},{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4','v8', }},'b', 'b', 'b', 'v4', 'v4', 'v8', 'v4', 'tv4', 'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'union','id', 'name', 'level', 'icon', 'memberCount', 'exp', 'leaderName', 'notice', {true,{'applyList','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'ct',}},{true,{'members','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'degree', 'weekContribution', 'allContribution', 'ct','joinTime', }},'canApply', 'autoJoin', 'joinLimit', 'limitLevel', 'limitPower', 'delateEndTime', 'weekExp', 'weekExpPrizeReceiveIndex', 'lastWeekActive', 'receiveTimes', 'goldRedpacketTime', 'rechargeRedpacketTime', }},}
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
	[6914] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', 'b', },
			{'stepInfo', 'open', }
		}
	end,
	[6672] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'index', {true,{'rewards','id', 'num', }},}
		}
	end,
	[5130] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', },
			{'activityId', {true,{'ranks','rank', 'playerId', 'playerName', 'score', 'headIcon', 'helpFightHeroId', 'level', 'frameCid', }},'myRank', }
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
	[6673] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'index', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6667] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v8', 'b', 'v4', 'v4', 'v4',}},},
			{{true,{'applyInfo','playerId', 'leaderCid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'online', 'portraitCid', 'portraitFrameCid', 'ct',}},}
		}
	end,
	[4868] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'rank', }
		}
	end,
	[5894] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'s', 'v4', {true,{'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', }},'v4', 'v4', 'v4', 'b', }},},
			{{false,{'team','teamId', 'leaderPid', {true,{'members','pid', 'status', 'heroCid', 'name', 'plv', 'skinCid', 'heroLevel', 'heroQuality', 'titleId', 'unionName', 'fightPower', }},'status', 'teamType', 'battleId', 'open', }},}
		}
	end,
	[5890] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[3334] = function()
		return {
			{"net.NetHelper", "receive"},
			{'pv4', },
			{'cid', }
		}
	end,
	[5895] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'type', }
		}
	end,
	[6905] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'equipInfoList','position', 'equipId', }},}
		}
	end,
	[6916] = function()
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
	[5896] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6513] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'id', 'chapterId', }
		}
	end,
	[1810] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[3076] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'b', 'v4','v4', 'v4', 'b', 'v4', 'v4', }},},
			{{true,{'friends','pid', 'name', 'fightPower', 'lvl', 'lastLoginTime', 'lastHandselTime', 'receive', 'status', 'leaderCid', 'online', 'ct','time', 'helpCDtime', 'canSend', 'portraitCid', 'portraitFrameCid', }},}
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
			{{true,{'s', 'v4', {true,{'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', }},'v4', 'v4', 'v4', 'b', }},'v4', 'v4', },
			{{true,{'teamInfo','teamId', 'leaderPid', {true,{'members','pid', 'status', 'heroCid', 'name', 'plv', 'skinCid', 'heroLevel', 'heroQuality', 'titleId', 'unionName', 'fightPower', }},'status', 'teamType', 'battleId', 'open', }},'teamType', 'nextTime', }
		}
	end,
	[7403] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'roleid', {true,{'rewards','id', 'num', }},}
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
	[6146] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'isSuccess', }
		}
	end,
	[7220] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1559] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'trigger', }
		}
	end,
	[2824] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','id', 'num', }},}
		}
	end,
	[3346] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', {true,{'v4', 'v4', 'v4', 'v4', }},},
			{'cid', 'count', 'startTime', 'endTime', {true,{'statistics','id', 'num', 'count', 'probability', }},}
		}
	end,
	[1049] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[3349] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', {true,{'v4', {true,{'v4', 'v4', }},'b', }},}},'v4', {true,{'v4', 'v4', }},},
			{{true,{'simulateSummons','cid', 'simulateSummonCount', 'sysSimulateSummonCount', 'exchangeCount', {true,{'records','order', {true,{'items','id', 'num', }},'isReceive', }},}},'lastCid', {true,{'lastResult','id', 'num', }},}
		}
	end,
	[3330] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'composeInfo','cid', 'finishTime', {true,{'items','id', 'num', }},'costTime', }},}
		}
	end,
	[3329] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{false,{'b', 'v4', 'v4', 'v4', }},'tv4', 'v4', 'v4', {true,{'v4', 'v4', }},'v4', },
			{{true,{'item','id', 'num', }},{false,{'noobInfo','noobStatus', 'endTime', 'summonCount', 'awardState', }},'activeId', 'hotHeroSummonScore', 'hotEquipSummonScore', {true,{'fixItem','id', 'num', }},'id', }
		}
	end,
	[3348] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'cid', 'dayTimes', }
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
	[9155] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},},
			{{true,{'maidObject','onlyId', 'cid', 'strength', }},}
		}
	end,
	[2842] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', {true,{'v4', 's', }},}},},
			{{false,{'info','id', 'desc', {true,{'detail','position', 'equipId', }},}},}
		}
	end,
	[3342] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'item','id', 'num', }},}
		}
	end,
	[5192] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewardNum','key', 'value', }},}
		}
	end,
	[3345] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'composeInfo','cid', 'finishTime', {true,{'items','id', 'num', }},'costTime', }},}
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
	[5151] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},'tv4', },
			{{false,{'speedLink','location', 'id', }},'remove', }
		}
	end,
	[3347] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'cid', 'cardNum', {true,{'cardPrizes','id', 'num', }},}
		}
	end,
	[3351] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', {true,{'v4', {true,{'v4', 'v4', }},'b', }},}},},
			{{false,{'simulateSummon','cid', 'simulateSummonCount', 'sysSimulateSummonCount', 'exchangeCount', {true,{'records','order', {true,{'items','id', 'num', }},'isReceive', }},}},}
		}
	end,
	[9102] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', 'tv4', {true,{'v4', 'v4', }},{true,{'v8', 'v4', {true,{'v4', 'v4', }},}},'v4', },
			{'rollNum', 'movePos', {true,{'rewards','id', 'num', }},{true,{'records','time', 'result', {true,{'rewards','id', 'num', }},}},'rounds', }
		}
	end,
	[6911] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', 'v8', }},{true,{'v4', 'v8', }},'v4', },
			{{true,{'mainLogInfo','logId', 'finished', 'time', }},{true,{'minorInfo','logId', 'time', }},'type', }
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
	[5124] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 's', 's', 'v4', 's', 'tv4', 's', }},},
			{{true,{'activitys','ct','id', 'activityType', 'activityTitle', 'startTime', 'endTime', 'showStartTime', 'showEndTime', 'remark', 'extendData', 'rank', 'showIcon', 'items', 'titleIcon', }},}
		}
	end,
	[6915] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'open', }
		}
	end,
	[4865] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},'v4', 'v4', },
			{{true,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},'rank', 'totleTrophy', }
		}
	end,
	[6906] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'equipInfoList','position', 'equipId', }},}
		}
	end,
	[1558] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},},
			{{true,{'sealStateInfo','roleId', 'sealState', 'sealType', }},}
		}
	end,
	[6917] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'scriptId', }
		}
	end,
	[6912] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{false,{'v4', 'v4', }},{false,{'v4', 'v4', }},'tv4', },
			{{true,{'rewardInfo','id', 'num', }},{false,{'apItemInfo','id', 'num', }},{false,{'ap','value', 'limit', }},'script', }
		}
	end,
	[6605] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', 'v4', {true,{'v4', 'v4', }},},
			{'type', 'playerName', 'param', {true,{'composePrizes','id', 'num', }},}
		}
	end,
	[6907] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'orderList', }
		}
	end,
	[6910] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'apInfo','value', 'limit', }},}
		}
	end,
	[6908] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', 'b', },
			{'type', 'success', 'finished', }
		}
	end,
	[6211] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},},
			{{false,{'currentPoint','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},}
		}
	end,
	[5640] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'tv4', },
			{'datingType', 'datingValue', 'eventId', }
		}
	end,
	[6803] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'pid', 'heroCid', 'skinCid', }
		}
	end,
	[5158] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[2565] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', {true,{'v4', 'v4', }},},
			{'success', {true,{'rewards','id', 'num', }},}
		}
	end,
	[2564] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'buyLogs','type', 'cid', 'nowBuyCount', 'totalBuyCount', 'storeState', }},}
		}
	end,
	[8306] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},},
			{{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},}
		}
	end,
	[6709] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'activityId', 'score', }
		}
	end,
	[25603] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1561] = function()
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
	[7102] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', 'tv4', {true,{'v4', {true,{'v4', 'v4', }},}},},
			{'curAreaCid', 'openAreas', 'finTasks', {true,{'complteEvents','areaCid', {true,{'events','cid', 'num', }},}},}
		}
	end,
	[6708] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'activityId', 'refreshCount', }
		}
	end,
	[5652] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'favorDatingId', 'statue', }
		}
	end,
	[6702] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'v4', },
			{'nianBeastId', 'builingId', 'randomSeed', 'datingId', 'deadline', }
		}
	end,
	[25613] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'pid', {true,{'rewards','id', 'num', }},}
		}
	end,
	[2306] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 's', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', },
			{'channel', 'fun', 'content', 'pid', 'pname', 'lvl', 'helpFightHeroCid', 'portraitCid', 'portraitFrameCid', 'titleId', 'chatFrameCid', }
		}
	end,
	[8001] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'tv4', 'tv4', }},'v4', 'v4', {true,{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},}},{false,{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', }},},
			{{false,{'cellInfo','totleStep', 'location', 'buffIds', 'cellIds', }},'awardStep', 'buffStep', {true,{'awardInfo',{true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},}},{false,{'eventAward',{true,{'eventRewards','id', 'num', }},{true,{'eventExRewards','id', 'num', }},'eventId', }},}
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
	[7229] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},}},'tv4', }},},
			{{false,{'gameInfo','eventCid', 'gameCid', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}},'options', }},}
		}
	end,
	[6201] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'b', {true,{'v4', 'v4', 'v4', 'v4', }},},
			{'openWorldCid', 'missionComplete', 'qliphothCoin', 'qliphothEnergy', 'firstUse', {true,{'worldTimes','worldCid', 'begining', 'endTime', 'beSoon', }},}
		}
	end,
	[6603] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{'id', {true,{'rewards','id', 'num', }},{true,{'extRewards','id', 'num', }},}
		}
	end,
	[5122] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'rewards','id', 'num', }},}
		}
	end,
	[2817] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'equipment','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{false,{'oldEquipment','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}
		}
	end,
	[5121] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'tv4', }},},
			{{true,{'signInfos','id', 'index', 'extendData', 'awardType', }},}
		}
	end,
	[517] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6213] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', }},'v4', },
			{{true,{'produces','itemId', 'itemNum', 'buyCount', }},'nextRefresh', }
		}
	end,
	[6817] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', }},}},},
			{{true,{'rankInfo','rank', 'costTime', {true,{'playerInfo','pid', 'pName', 'level', 'headId', 'portraitFrameCid', }},}},}
		}
	end,
	[6103] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', },
			{'id', 'verify', }
		}
	end,
	[6102] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'rewards','id', 'num', }},}
		}
	end,
	[2315] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', 'v4', },
			{'content', 'type', 'lastSendTime', }
		}
	end,
	[275] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'cid', 'count', }
		}
	end,
	[5134] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'url', }
		}
	end,
	[8302] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'rankList','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},{false,{'rank','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},'refreshMinu', {true,{'curSeason','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},{false,{'curRank','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},{true,{'lastSeason','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},{false,{'lastRank','pid', 'pName', 'segment', 'laderScore', 'rank', 'headId', 'level', 'battleScore', 'ladderAddtion', }},}
		}
	end,
	[8501] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},{false,{'v4', 'v4', 'v4', 'tv4', 'v4', }},{false,{{true,{'v4', 'v4', }},'v4', }},},
			{{false,{'step','step', 'nextTime', }},{false,{'curBoss','curDungeon', 'dungeonHp', 'leftCount', 'dungeonBuffs', 'honor', }},{false,{'playerWeakness',{true,{'weakness','dungeon', 'count', }},'leftCount', }},}
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
	[8002] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},},
			{{false,{'turnInfo','extraTimes', 'turnIndex', {true,{'turnTimes','turnId', 'times', }},}},'times', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6206] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','itemId', 'itemNum', }},}
		}
	end,
	[6301] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', 'b', },
			{{true,{'levels','levelCid', 'status', }},'leftTime', 'count', 'buffCid', 'buffCount', 'awardStatus', 'finishAny', }
		}
	end,
	[1564] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 'v4', 'v4', 'v4', }},},
			{'roleId', 'type', {true,{'list','pid', 'pName', 'headId', 'headFrame', 'pLevel', 'fightPower', 'rank', 'gid', 'channel', 'trainLv', 'sucNum', 'totalNum', }},{false,{'selfRank','pid', 'pName', 'headId', 'headFrame', 'pLevel', 'fightPower', 'rank', 'gid', 'channel', 'trainLv', 'sucNum', 'totalNum', }},}
		}
	end,
	[1287] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[7101] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'startTime', 'endTime', 'showTime', }
		}
	end,
	[1288] = function()
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
	[5144] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 's', 'v4', }},},
			{{true,{'items','id', 'itemId', 'progress', 'extend', 'status', }},}
		}
	end,
	[6209] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'qliphothEnergy', }
		}
	end,
	[1284] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
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
	[7103] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'areaCid', }
		}
	end,
	[7304] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'result', {true,{'rewards','id', 'num', }},}
		}
	end,
	[7305] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
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
	[7303] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', },
			{'id', 'result', }
		}
	end,
	[2316] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'s', 's', 'v8', 'v4', }},'v4', 'v4', },
			{{true,{'infos','playerName', 'content', 'sendTime', 'type', }},'type', 'version', }
		}
	end,
	[1811] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'pv4', 'v4', 'b', 'v4', }},},
			{{false,{'levelInfo','cid', 'goals', 'fightCount', 'win', 'buyCount', }},}
		}
	end,
	[8314] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {false,{'v4', 'pv4', 'v4', 'b', 'v4', }},}},'v4', 'v4', },
			{{false,{'levelInfos','battleScore', {false,{'levelInfo','cid', 'goals', 'fightCount', 'win', 'buyCount', }},}},'battleScore', 'cardPoint', }
		}
	end,
	[2081] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', },
			{'manualId', 'endTime', 'times', }
		}
	end,
	[8601] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', }},}},{true,{'v4', 'v4', 'v4', }},{true,{'v4', 'tv4', }},},
			{{true,{'dispatches','dungeonType', {true,{'fightPower','hero', 'fightPower', }},{true,{'dungeonInfo','dungeonCid', 'multiple', 'eTime', 'awardCount', }},}},{true,{'exhaustions','hero', 'exhaustion', 'nextTime', }},{true,{'heroes','type', 'heroes', }},}
		}
	end,
	[5154] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'address', }
		}
	end,
	[2077] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', }},},
			{{false,{'jobInfo','buildingId', 'type', {true,{'rewards','id', 'num', }},{true,{'extraRewards','id', 'num', }},'jobId', 'jobType', 'etime', }},}
		}
	end,
	[8408] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[5142] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[5139] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', },
			{'name', 'contribution', }
		}
	end,
	[8502] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},{false,{'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{{true,{'damages','unionId', 'unionLv', 'unionName', 'bossLv', 'dmgRate', 'rank', 'icon', }},{false,{'selfDamage','unionId', 'unionLv', 'unionName', 'bossLv', 'dmgRate', 'rank', 'icon', }},{true,{'honors','playerId', 'playerName', 'playerLv', 'honor', 'fightCount', 'rank', 'headId', }},{false,{'selfHonor','playerId', 'playerName', 'playerLv', 'honor', 'fightCount', 'rank', 'headId', }},}
		}
	end,
	[8603] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
		}
	end,
	[4371] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'reward','id', 'num', }},}
		}
	end,
	[4366] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'b', 'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', }},'v4', 'b', 'v4', }},{true,{'v4', 'v4', }},},
			{{false,{'signInfo','signDays', 'canSign', 'actRemain', {true,{'basrReward','id', 'num', }},{true,{'specialReward','id', 'num', }},'extDay', 'subscibe', 'subscibeTime', }},{true,{'rewards','id', 'num', }},}
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
	[5140] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'recoverTime', }
		}
	end,
	[1034] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[4359] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','v4', 'v4', 'v4', 'v4', }},{false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},}},},
			{{false,{'monthCardInfo','ct','lastGainDate', 'surplus_Gain_Count', 'cardCid', 'lastEndTime', }},{false,{'itemList',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}},}
		}
	end,
	[5167] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'b', 'v4', 'v4', 'b', 'v4', 'tv4', 'v4', 'v4', 'v4', 'b', 'b', }},},
			{{true,{'cities','id', 'dungeon', 'resOpen', 'resCount', 'resUpTime', 'invaded', 'invadedEnd', 'invadedCamp', 'resStartTime', 'fightTime', 'score', 'pass', 'dunPass', }},}
		}
	end,
	[4363] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'id', {true,{'items','id', 'num', }},}
		}
	end,
	[9301] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', 's', }},{true,{'v4', 'tv4', }},},
			{{true,{'infoList','index', 'id', 'zooming', 'rotate', 'text', }},{true,{'roleActionList','roleId', 'actionId', }},}
		}
	end,
	[4356] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','v4', 'v4', 'v4', 'v4', },
			{'ct','lastGainDate', 'surplus_Gain_Count', 'cardCid', 'lastEndTime', }
		}
	end,
	[6228] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'tv4', },
			{'eventCid', 'gameCid', 'options', }
		}
	end,
	[8504] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},{true,{'fdAward','dungeon', 'status', }},}
		}
	end,
	[5382] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'tv4', }},},
			{{true,{'levelBuffs','levelCid', 'buff', }},}
		}
	end,
	[6205] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},},
			{'x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}
		}
	end,
	[6604] = function()
		return {
			{"net.NetHelper", "receive"},
			{'tv4', },
			{'records', }
		}
	end,
	[5125] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'activityid', 'activitEntryId', {true,{'rewards','id', 'num', }},}
		}
	end,
	[1566] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'approvalNum', }
		}
	end,
	[5381] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'heroHealth','heroCid', 'health', }},}
		}
	end,
	[271] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 's', 'v4', 'v8', 'v4', 'v8', 'v4','s', 'v4', {true,{'v4','v4', }},'b', 's', 's', 'tv4', 'v4', 'v4', {false,{{true,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},'v4', 'v4', }},'v4', 's', 'v4', }},{false,{{true,{'v4','v4', 'v4', 'ts', }},}},{true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','v4', 'v4', 'v4', 'v4', 'b', 'v4', }},},
			{{false,{'playerInfo','pid', 'name', 'lvl', 'exp', 'vip_lvl', 'vip_exp', 'language','remark', 'helpFightHeroCid', {true,{'attr','attrKey','attrVal', }},'isFirstLogin', 'clientDiscreteData', 'settings', 'recoverTimeList', 'portraitCid', 'portraitFrameCid', {false,{'element',{true,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},'rank', 'totleTrophy', }},'unionId', 'unionName', 'titleId', }},{false,{'formationInfo',{true,{'formations','ct','type', 'status', 'stance', }},}},{true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'medal','ct','cid', 'star', 'quality', 'effectTime', 'isEquip', 'createTime', }},}
		}
	end,
	[6223] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},'v4', },
			{{true,{'points','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},'eventRefresh', }
		}
	end,
	[5131] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},'v4', 'v4', },
			{'activityId', {true,{'ranks','rank', 'playerId', 'playerName', 'score', 'headIcon', 'helpFightHeroId', 'level', 'frameCid', }},'myRank', 'myScore', }
		}
	end,
	[5633] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', {true,{'v4', 'v4', }},'tv4', 'v4', {true,{'v4', 'b', }},{true,{'v4', 'v4', }},}},},
			{{false,{'info','datingType', 'datingValue', {true,{'bag','id', 'num', }},'endings', 'stepTime', {true,{'entrances','entranceId', 'guide', }},{true,{'quality','qualityId', 'value', }},}},}
		}
	end,
	[8401] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirit','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
		}
	end,
	[1047] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},{true,{'v4', 'v4',}},},
			{{true,{'rewards','id', 'num', }},{true,{'tasks','id', 'status',}},}
		}
	end,
	[6210] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'ambushId', }
		}
	end,
	[7206] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'items','itemId', 'itemNum', }},}
		}
	end,
	[3339] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'info','cid', 'count', }},}
		}
	end,
	[7302] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 's', 'v4', 'v4', 'v4', 's', 's', {true,{'v4', 'v4', }},}},},
			{{false,{'redEnvelopeInfo','ct','id', 'senderId', 'senderName', 'createTime', 'modifiedTime', 'status', 'title', 'body', {true,{'rewards','id', 'num', }},}},}
		}
	end,
	[6145] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 's', 'v4', {true,{'v4', 's', {true,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},'v4', 'v4', 'v4', 's', 'v4', }},'v4', 'v4', 'v4', {true,{'v4', 'v4', 'v4', 'v4', }},'v4', },
			{'fightId', 'fightServerHost', 'fightServerPort', {true,{'players','pid', 'pname', {true,{'heros','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},'reviveCount', 'portraitCid', 'titleId', 'unionName', 'portraitFrameId', }},'randomSeed', 'dungeonCid', 'netType', {true,{'randomDungeons','dungeonId', 'index', 'branchDungeonId', 'branchIndex', }},'teamType', }
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
			{{false,{'v4', 'v4', 'tv4', 'tv4', }},{false,{'v4', 'v4', {true,{'v4', 'v4', }},}},},
			{{false,{'cellInfo','totleStep', 'location', 'buffIds', 'cellIds', }},{false,{'turnInfo','extraTimes', 'turnIndex', {true,{'turnTimes','turnId', 'times', }},}},}
		}
	end,
	[6805] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'pid', }
		}
	end,
	[6207] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'b', },
			{{true,{'missions','missionId', 'progress', }},'completed', }
		}
	end,
	[1033] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[1549] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','s', 'pv4', 'v4', 'v4', 'v4', 'b', },
			{'ct','cityDatingId', 'datingTimeFrame', 'datingRuleCid', 'date', 'state', 'inDating', }
		}
	end,
	[2829] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', {true,{'v4', 's', }},},
			{'equipmentId', {true,{'attrChange','index', 'value', }},}
		}
	end,
	[6221] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', 'b', {true,{'v4', 'v4', 'v4', 'v4', }},}},'b', },
			{{false,{'treeInfo','openWorldCid', 'missionComplete', 'qliphothCoin', 'qliphothEnergy', 'firstUse', {true,{'worldTimes','worldCid', 'begining', 'endTime', 'beSoon', }},}},'openStatus', }
		}
	end,
	[8509] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'v4', }},'v4', }},},
			{{false,{'playerWeakness',{true,{'weakness','dungeon', 'count', }},'leftCount', }},}
		}
	end,
	[267] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 's', 'v4', 'v8', 'v4', 'v8', 'v4','s', 'v4', {true,{'v4','v4', }},'b', 's', 's', 'tv4', 'v4', 'v4', {false,{{true,{'v4', {true,{'v4', 'v4', }},'v4', 'b', }},'v4', 'v4', }},'v4', 's', 'v4', },
			{'pid', 'name', 'lvl', 'exp', 'vip_lvl', 'vip_exp', 'language','remark', 'helpFightHeroCid', {true,{'attr','attrKey','attrVal', }},'isFirstLogin', 'clientDiscreteData', 'settings', 'recoverTimeList', 'portraitCid', 'portraitFrameCid', {false,{'element',{true,{'elments','type', {true,{'element','cid', 'reward', }},'trophy', 'scan', }},'rank', 'totleTrophy', }},'unionId', 'unionName', 'titleId', }
		}
	end,
	[6611] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'mapBoxes','location', 'eventCid', }},}
		}
	end,
	[264] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4','v4', 'v4', 'ts', },
			{'ct','type', 'status', 'stance', }
		}
	end,
	[6704] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},},
			{'type', 'param', {true,{'rewards','id', 'num', }},}
		}
	end,
	[9103] = function()
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
	[6617] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},},
			{{true,{'rewards','id', 'num', }},}
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
	[265] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', 'v4', 'ts', }},},
			{{true,{'formations','ct','type', 'status', 'stance', }},}
		}
	end,
	[8606] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', {true,{'v4', 'v4', }},{true,{'v4', 'v4', 'v4', 'v4', }},}},},
			{{true,{'dispatches','dungeonType', {true,{'fightPower','hero', 'fightPower', }},{true,{'dungeonInfo','dungeonCid', 'multiple', 'eTime', 'awardCount', }},}},}
		}
	end,
	[287] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', 's', },
			{'openAsk', 'askUrl', }
		}
	end,
	[290] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', },
			{'dayBackground', 'nightBackground', 'dayBGM', 'nightBGM', }
		}
	end,
	[1556] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'ts', 'v4', 'v4', 'v4', },
			{'roleId', 'returnMsg', 'state', 'type', 'sealState', }
		}
	end,
	[292] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'time', }
		}
	end,
	[3010] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4','v4', }},'v4', },
			{{true,{'uiChange','ct','cid', }},'wearId', }
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
	[7205] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},},
			{{false,{'mapPoint','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},}
		}
	end,
	[5378] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'tv4', },
			{'levelCid', 'buff', }
		}
	end,
	[1794] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'pv4', 'v4', 'b', 'v4', }},{true,{'v4', 'v4', }},'b', },
			{{false,{'levelInfo','cid', 'goals', 'fightCount', 'win', 'buyCount', }},{true,{'rewards','id', 'num', }},'win', }
		}
	end,
	[6504] = function()
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
	[7227] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', {false,{{true,{'v4','s', 'v4', 'v8', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},{true,{'v4','s', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},{true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},}},}},},
			{{false,{'rewardInfo','eventCid', {false,{'items',{true,{'items','ct','id', 'cid', 'num', 'outTime', }},{true,{'equipments','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},{true,{'dresss','ct','id', 'cid', 'roleId', 'outTime', }},{true,{'newEquipments','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},{true,{'gems','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}},}},}
		}
	end,
	[7219] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'b', 'b', {true,{'v4', 'v4', }},}},},
			{{true,{'points','x', 'y', 'event', 'eventValid', 'visual', {true,{'foundPoints','x', 'y', }},}},}
		}
	end,
	[6505] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v8', },
			{'serverContribution', }
		}
	end,
	[1028] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4','s', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'v4', {true,{'v4', 's', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'b', 'v4', 'v4', 'v4', 'v4', }},}},'b', 'v4', {true,{'v4', 'v4', 'v4', }},'v4', 'v4', 'v4', 'v4', 'v4', {true,{'v4', 's', 'v4', {true,{'v4', 'v4', 'v4', }},{true,{'v4', 'v4', }},}},'v4', {true,{'v4', 'v4', }},'tv4', {true,{'v4', {false,{'v4','s', 'v4', 'v4', 'v4', 's', 'v4', }},}},'v4','v4', {true,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},'v4', }},},
			{{false,{'hero','ct','id', 'cid', 'lvl', 'exp', {true,{'attr','type', 'val', }},'advancedLvl', {true,{'equipments','position', 'equipmentId', {false,{'equip','ct','id', 'cid', 'level', 'exp', 'heroId', 'position', {true,{'attrs','cid', 'value', 'index', }},'oldAttrIndex', 'newAttrType', 'newAttrValue', 'outTime', 'isLock', 'star', 'stage', 'num', 'step', }},}},'helpFight', 'angelLvl', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},'useSkillPiont', 'quality', 'provide', 'fightPower', 'skinCid', {true,{'skillStrategyInfo','id', 'name', 'alreadyUseSkillPiont', {true,{'angeSkillInfos','type', 'pos', 'lvl', }},{true,{'passiveSkillInfo','pos', 'skillId', }},}},'useSkillStrategy', {true,{'crystalInfo','rarity', 'gridId', }},'equipSkillIds', {true,{'euqipFetterInfo','index', {false,{'newEquipmentInfo','ct','id', 'cid', 'stage', 'level', 'heroId', 'position', }},}},'heroStatus','deadLine', {true,{'gemInfos','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},'skinCidTemp', }},}
		}
	end,
	[6401] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'b', 'b', {true,{'v4', 'pv4', 'v4', 'b', 'v4', }},},
			{'startTime', 'endTime', 'status', 'alwaysOpen', {true,{'levelInfos','cid', 'goals', 'fightCount', 'win', 'buyCount', }},}
		}
	end,
	[2831] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'isSuccess', }
		}
	end,
	[7207] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', }},'b', },
			{{true,{'missions','missionId', 'progress', }},'completed', }
		}
	end,
	[6610] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'enemy','invadeId', 'time', }},}
		}
	end,
	[5379] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {true,{'v4', 'v4', }},},
			{'nextLevelCid', {true,{'rewards','id', 'num', }},}
		}
	end,
	[6808] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', 's', 'v4', 'v4', 'v4', 'v4', },
			{'content', 'pid', 'pname', 'lvl', 'helpFightHeroCid', 'portraitCid', 'portraitFrameCid', }
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
	[1537] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[6800] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 's', 'v4', },
			{'roomId', 'fightServerHost', 'fightServerPort', }
		}
	end,
	[2818] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[6811] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'b', {true,{'v4', 'v4', }},}},'tv4', 'tv4', 'v4', },
			{{true,{'chapterInfo','chapter', 'isOpen', {true,{'mission','dungeonId', 'fightCount', }},}},'passedMission', 'firstPassedMission', 'endTime', }
		}
	end,
	[1814] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'pv4', 'v4', 'b', 'v4', }},}},{false,{{true,{'s', 'v4', 'v4', 'v4', {true,{'v4', 'pv4', }},'v4', 'v4', }},}},},
			{{false,{'levelInfos',{true,{'levelInfos','cid', 'goals', 'fightCount', 'win', 'buyCount', }},}},{false,{'groups',{true,{'group','id', 'cid', 'fightCount', 'buyCount', {true,{'rewardInfo','key', 'list', }},'mainLineCid', 'maxMainLine', }},}},}
		}
	end,
	[1563] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 's', 's', },
			{'roleId', 'sTime', 'eTime', 'totalNum', 'sucNum', 'level', 'exp', 'days', 'bestQuery', 'bestReply', }
		}
	end,
	[5190] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'address', }
		}
	end,
	[2080] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', }},},
			{{false,{'handWorkInfo','manualId', 'endTime', 'integral', 'times', }},}
		}
	end,
	[6909] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},{true,{'v4', 'b', 'b', {true,{'v4', 'v4', 'b', }},}},{true,{'v4', 'v4', }},'v4', 'v4', 'v4', 'b', 'tv4', },
			{{false,{'ap','value', 'limit', }},{true,{'areaInfoList','areaId', 'isDevil', 'explored', {true,{'roadInfoList','startAreaId', 'endAreaId', 'unlocked', }},}},{true,{'equipInfoList','position', 'equipId', }},'currentAreaId', 'currentChapterId', 'currentEvtId', 'isNewChapter', 'unlockChapterInfo', }
		}
	end,
	[3002] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
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
	[6602] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', }},},
			{{false,{'composeInfo','id', 'composeTimes', 'countDown', }},}
		}
	end,
	[278] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'b', },
			{'guideId', 'finish', }
		}
	end,
	[4002] = function()
		return {
			{"net.NetHelper", "receive"},
			{'b', },
			{'success', }
		}
	end,
	[6147] = function()
		return {
			{"net.NetHelper", "receive"},
			{},
			{}
		}
	end,
	[9154] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{{true,{'v4', 'b', }},'v4', 'v4', 'v4', }},},
			{{false,{'recruitInfo',{true,{'recruits','cid', 'state', }},'nextTime', 'recruitTimes', 'recruitBuyTimes', }},}
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
			{'v4', {true,{'v4', 'v4', 's', 'v4', 'v4', 'v4', 'v4', 'v4', }},},
			{'activityId', {true,{'ranks','rank', 'playerId', 'playerName', 'score', 'headIcon', 'helpFightHeroId', 'level', 'frameCid', }},}
		}
	end,
	[6149] = function()
		return {
			{"net.NetHelper", "receive"},
			{{true,{'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'v4', 'b', 'b', }},},
			{{true,{'chashs','id', 'status', 'fightCount', 'buyCount', 'remainCount', 'awardStartTime', 'awardEndTime', 'isSpecial', 'finishOnce', }},}
		}
	end,
	[3502] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},'tv4', },
			{'activityId', 'score', {true,{'item','id', 'num', }},'summonedList', }
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
	[2834] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', {false,{'v4','s', 'v4', 'v4', 'tv4', {false,{'v4', 'v4', }},}},},
			{'id', {false,{'gem','ct','id', 'cid', 'heroId', 'randSkill', {false,{'randSkillTemp','originalSkill', 'newSkill', }},}},}
		}
	end,
	[8507] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', }},},
			{{false,{'step','step', 'nextTime', }},}
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
	[8404] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v8', {true,{'v4', 'v4', }},'b', 'b', {true,{'v4', 'v4', }},'v4', }},},
			{{false,{'spirit','spiritPoints', 'grade', 'level', 'exp', {true,{'specialism','cid', 'num', }},'firstShow', 'feedback', {true,{'angleSpirits','heroCid', 'lv', }},'maxLv', }},}
		}
	end,
	[2317] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', },
			{'barrageId', 'lastSendTime', }
		}
	end,
	[3079] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', },
			{'inviteCode', }
		}
	end,
	[5166] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', },
			{'camp', }
		}
	end,
	[1042] = function()
		return {
			{"net.NetHelper", "receive"},
			{'s', 'v4', 'v4', },
			{'heroId', 'rarity', 'gridId', }
		}
	end,
	[9302] = function()
		return {
			{"net.NetHelper", "receive"},
			{{false,{'v4', 'v4', 'v4', 'v4', 's', }},},
			{{false,{'picInfo','index', 'id', 'zooming', 'rotate', 'text', }},}
		}
	end,
	[5141] = function()
		return {
			{"net.NetHelper", "receive"},
			{'v4', 'v4', {true,{'v4', 'v4', }},'s', },
			{'activityid', 'activitEntryId', {true,{'rewards','id', 'num', }},'extendData', }
		}
	end,
}
return tblProto