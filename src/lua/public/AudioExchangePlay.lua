
AudioExchangePlay = {}
local sharedEngine = SimpleAudioEngine:sharedEngine()

local cookieList = {}
local cookieTID = -1
local cookDuration = 5
local Cookie = function()
	if cookieTID == -1 then 
		cookieTID = TFDirector:addTimer(cookDuration * 1000, -1, nil, function()
			local delList = {}
			local cur = TFLuaTime:clock()
			for path, start in pairs(cookieList) do 
				local dt = cur - (start or cur) 
				if dt > cookDuration then 
					delList[path] = true
				end
			end

			for path in pairs(delList) do 	
				AudioEngine:uncache(path)
				cookieList[path] = nil
			end
		end)
	end
end

--AudioExchangePlay.defaultBgmFile = "sound/bgm/main_001.mp3"
AudioExchangePlay.defaultBgmFile = "sound/bgm/main_OneYear.mp3"
AudioExchangePlay.defaultBgmId = nil
AudioExchangePlay.lastBgmFile = nil
AudioExchangePlay.curBgmFile = nil
AudioExchangePlay.oldId = nil
AudioExchangePlay.newId = nil
AudioExchangePlay.useNewAudioEngine = (CC_TARGET_PLATFORM ~= CC_PLATFORM_IOS)
local addVolume = 0
local subVolume = 1
local changeTime = 0

function AudioExchangePlay.getDefaultBgm()
--	local isOneYear = FunctionDataMgr:isMainLayerOneYearUI()
--	local bgm = isOneYear and "sound/bgm/main_OneYear.mp3" or "sound/bgm/main_001.mp3"

	local uidata = TabDataMgr:getData("Uichange", MainUISettingMgr:getui())
	local bgm = uidata.bgm

	if not bgm  or bgm == "" then
		bgm = "sound/bgm/main_001.mp3"
	end
	

	AudioExchangePlay.defaultBgmId = nil

	---其他界面默认设置主界面的音乐
	local bgmCid
	local curDayBgmCid,curNightBgmCid = SceneSoundDataMgr:getCurSceneBgmId()
	local defaultDay,defaultNight,defaultDayBgm,defaultNightBgm = SceneSoundDataMgr:getDefaultData()
	local hour = Utils:getTime(ServerDataMgr:getServerTime())
	if hour <= 18 and hour >= 6 then
		bgmCid = defaultDayBgm and 0 or curDayBgmCid
	else
		bgmCid = defaultNightBgm and 0 or curNightBgmCid
	end
	
	local soundCfg = SceneSoundDataMgr:getSoundInfoByCid(bgmCid)
	if soundCfg then
		bgm = soundCfg.bgm
	else
		local dressData = RoleDataMgr:useDressFindData()
		if dressData and dressData.type and dressData.type == 2 and dressData.kanbanBgm and #dressData.kanbanBgm ~= 0 then
			bgm = dressData.kanbanBgm
		end
	end
	
	return bgm
end

function AudioExchangePlay.playBGM(viewClass, loopValue, bgmFile)
	if AudioExchangePlay.useNewAudioEngine then
		TFAudio.stopMusic()
	end
	if not viewClass then
		return
	end

	local bgmCfg = nil
	local bgmChangeMap = TabDataMgr:getData("BgmChange")
	for k, v in pairs(bgmChangeMap) do
		if viewClass.topBarFileName then 
			if viewClass.topBarFileName  == v.nameId then
				bgmCfg = v
				break
			end 
		end
	end
	if not bgmCfg then 
		for k, v in pairs(bgmChangeMap) do
			if viewClass.__cname == v.nameId then
				bgmCfg = v
				break
			end
		end
	end
	AudioExchangePlay.updateBgmState()
	changeTime = bgmCfg and bgmCfg.changeTime or 1
	if not AudioExchangePlay.lastBgmFile then

		if bgmFile then
			AudioExchangePlay.lastBgmFile = bgmFile
		else
			AudioExchangePlay.lastBgmFile = bgmCfg and bgmCfg.bgm or AudioExchangePlay.getDefaultBgm()
		end
		if not AudioExchangePlay.useNewAudioEngine then
			TFAudio.playBmg(AudioExchangePlay.lastBgmFile, true)
			return
		end
		if AudioExchangePlay.lastBgmFile == AudioExchangePlay.getDefaultBgm() then
			if AudioExchangePlay.defaultBgmId then
				AudioExchangePlay.oldId = AudioExchangePlay.defaultBgmId
			else
				AudioExchangePlay.oldId = AudioEngine:play2d(AudioExchangePlay.lastBgmFile, loopValue, addVolume)
				AudioExchangePlay.defaultBgmId = AudioExchangePlay.oldId
			end
		else
			AudioExchangePlay.oldId = AudioEngine:play2d(AudioExchangePlay.lastBgmFile, loopValue, addVolume)
		end
        AudioExchangePlay.startScheduleUpdate()
	else

		local newBgm
		if bgmFile then
			newBgm = bgmFile
		elseif bgmCfg then
			newBgm = bgmCfg.bgm
		else
			newBgm = AudioExchangePlay.getDefaultBgm()
		end
		if not AudioExchangePlay.useNewAudioEngine then
			if TFAudio:isMusicPlaying() then
				if AudioExchangePlay.lastBgmFile ~= newBgm then
					TFAudio.stopMusic()
					TFAudio.playBmg(newBgm, true)
					AudioExchangePlay.lastBgmFile = newBgm 
				end
			else
				TFAudio.playBmg(newBgm, true)
				AudioExchangePlay.lastBgmFile = newBgm 
			end
			return
		end

		if AudioExchangePlay.lastBgmFile ~= newBgm and AudioExchangePlay.curBgmFile ~= newBgm then
			AudioExchangePlay.curBgmFile = newBgm
			if AudioExchangePlay.curBgmFile == AudioExchangePlay.getDefaultBgm() then
				if AudioExchangePlay.defaultBgmId then
					AudioExchangePlay.newId = AudioExchangePlay.defaultBgmId
				else
					AudioExchangePlay.newId = AudioEngine:play2d(AudioExchangePlay.curBgmFile, loopValue, addVolume)
					AudioExchangePlay.defaultBgmId = AudioExchangePlay.newId
				end 
			else
				AudioExchangePlay.newId = AudioEngine:play2d(AudioExchangePlay.curBgmFile, loopValue, addVolume)
			end
			AudioExchangePlay.startScheduleUpdate()
		end
	end
	AudioExchangePlay.viewClass = viewClass
end

function AudioExchangePlay.updateBgmState()
	if not AudioExchangePlay.useNewAudioEngine then
		return
	end
	local baseVol = SettingDataMgr:getSoundMainVal()
    local bgmVol = SettingDataMgr:getSoundBgmVal()
    local maxVolume = baseVol * bgmVol
    addVolume = maxVolume
    subVolume = 0
    AudioExchangePlay.updateCurBgmVolume()
    AudioExchangePlay.stopScheduleUpdate()
	if AudioExchangePlay.oldId and AudioExchangePlay.newId then
   		if AudioExchangePlay.lastBgmFile and AudioExchangePlay.curBgmFile then
			if AudioExchangePlay.defaultBgmId and AudioExchangePlay.defaultBgmId == AudioExchangePlay.oldId then

	    	else
		    	AudioEngine:stop(AudioExchangePlay.oldId)
		    	if AudioExchangePlay.lastBgmFile ~= AudioExchangePlay.curBgmFile then
					-- AudioEngine:uncache(AudioExchangePlay.lastBgmFile)
					if AudioExchangePlay.lastBgmFile then 
						cookieList[AudioExchangePlay.lastBgmFile] = TFLuaTime:clock()
					end
				end
		    end
		    AudioExchangePlay.oldId = clone(AudioExchangePlay.newId)
			AudioExchangePlay.newId = nil
		    AudioExchangePlay.lastBgmFile = clone(AudioExchangePlay.curBgmFile)
			AudioExchangePlay.curBgmFile = nil
		end
    end
end

function AudioExchangePlay.stopScheduleUpdate()
	local baseVol = SettingDataMgr:getSoundMainVal()
    local bgmVol = SettingDataMgr:getSoundBgmVal()
    local maxVolume = baseVol * bgmVol
    addVolume = 0
    subVolume = maxVolume
   	
	if AudioExchangePlay.scheduleID then
        TFDirector:removeTimer(AudioExchangePlay.scheduleID)
        AudioExchangePlay.scheduleID = nil
    end
end

function AudioExchangePlay.scheduleUpdate(dt)
    local baseVol = SettingDataMgr:getSoundMainVal()
    local bgmVol = SettingDataMgr:getSoundBgmVal()
    local maxVolume = baseVol * bgmVol
    local changeValue = maxVolume / (changeTime * 20)
    addVolume = addVolume + changeValue
    subVolume = subVolume - changeValue
    AudioExchangePlay.updateCurBgmVolume()
    if addVolume > maxVolume or subVolume < 0 then
    	AudioExchangePlay.updateBgmState()
    	AudioExchangePlay.stopScheduleUpdate()
    end
end

function AudioExchangePlay.updateCurBgmVolume()
	if not AudioExchangePlay.useNewAudioEngine then
		return
	end
	if AudioExchangePlay.newId then
    	AudioEngine:setVolume(AudioExchangePlay.newId, addVolume)
    	if AudioExchangePlay.oldId then
    		AudioEngine:setVolume(AudioExchangePlay.oldId, subVolume)
    	end
    else
    	if AudioExchangePlay.oldId then
    		AudioEngine:setVolume(AudioExchangePlay.oldId, addVolume)
    	end
    end
end

function AudioExchangePlay.startScheduleUpdate()
	if not AudioExchangePlay.useNewAudioEngine then
		return
	end
    if not AudioExchangePlay.scheduleID then
        AudioExchangePlay.scheduleID = TFDirector:addTimer(50, -1, nil, handler(AudioExchangePlay.scheduleUpdate, AudioExchangePlay))
    end
end

function AudioExchangePlay.updateBgmVolume()
	local baseVol = SettingDataMgr:getSoundMainVal()
    local bgmVol = SettingDataMgr:getSoundBgmVal()
    local maxVolume = baseVol * bgmVol
    subVolume = maxVolume
    addVolume = maxVolume
    AudioExchangePlay.updateCurBgmVolume()
end

function AudioExchangePlay.stopAllBgm(notForce)
	if AudioExchangePlay.useNewAudioEngine then
		AudioExchangePlay.stopScheduleUpdate()
		if AudioExchangePlay.oldId then
	    	AudioEngine:stop(AudioExchangePlay.oldId)
	    end
	    if AudioExchangePlay.newId then
	    	AudioEngine:stop(AudioExchangePlay.newId)
	    end
		
		if notForce then
			AudioExchangePlay.playBGM(AudioExchangePlay.viewClass, true)
		end

		AudioExchangePlay.lastBgmFile = nil
		AudioExchangePlay.curBgmFile = nil
		AudioExchangePlay.defaultBgmId = nil
		AudioExchangePlay.oldId = nil
		AudioExchangePlay.newId = nil
	else
		TFAudio.stopMusic()
	end
end

function AudioExchangePlay.setUseNewEngine(enable)
	AudioExchangePlay.useNewAudioEngine = enable
end

return AudioExchangePlay