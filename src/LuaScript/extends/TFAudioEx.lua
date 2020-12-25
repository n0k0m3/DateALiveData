
--Encapsulate SimpleAudioEngine to AudioEngine,Play music and sound effects.
local M = {}
local sharedEngine = SimpleAudioEngine:sharedEngine()

local useNewAudioEngine = true;--(CC_TARGET_PLATFORM ~= CC_PLATFORM_IOS)
local backID = -1
local backVolume = 1

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

function M.useNewEngine(enable)
	if nil == enable then
		enable = true
	end
	useNewAudioEngine = enable
	SafeAudioExchangePlay().setUseNewEngine(useNewAudioEngine)
end

function M.stopAllEffects(notForce)
	if useNewAudioEngine then
		AudioEngine:stopAll()
		--AudioEngine:uncacheAll()
		SafeAudioExchangePlay().stopAllBgm(notForce)
	else
		sharedEngine:stopAllEffects()
	end
end

function M.getMusicVolume()
	if useNewAudioEngine then
		return backVolume
	else
		return sharedEngine:getBackgroundMusicVolume()
	end
end

function M.isMusicPlaying()
	if useNewAudioEngine then
		if backID ~= -1 then
			return AudioEngine:isPlaying(backID)
		else
			return false
		end
	else
		return sharedEngine:isBackgroundMusicPlaying()
	end
end

function M.isEffectPlaying(id)
	if useNewAudioEngine then
		if id ~= -1 then
			return AudioEngine:isPlaying(id)
		else
			return false
		end
	else
		return sharedEngine:isEffectPlaying()
	end
end

function M.getEffectsVolume()
	if useNewAudioEngine then
		return AudioEngine:getVolume()
	else
		return sharedEngine:getEffectsVolume()
	end
end

function M.setMusicVolume(volume)
	if volume < 0.0 then
		volume = 0.0
	elseif volume > 1.0 then
		volume = 1.0
	end

	if useNewAudioEngine then
		if backID ~= -1 then
			AudioEngine:setVolume(backID, volume)
		end
		backVolume = volume
	else
		sharedEngine:setBackgroundMusicVolume(volume)
	end
end

function M.stopEffect(handle)
	if useNewAudioEngine then
		AudioEngine:stop(handle)
	else
		sharedEngine:stopEffect(handle)
	end
end

function M.stopMusic(isReleaseData)
	local releaseDataValue = false
	if nil ~= isReleaseData then
		releaseDataValue = isReleaseData
	end
	if useNewAudioEngine then
		if backID ~= -1 then
			AudioEngine:stop(backID)
		end
		if releaseDataValue and M.currentMusic ~= nil then
			AudioEngine:uncache(M.currentMusic)
		end
		backID = -1
	else
		sharedEngine:stopBackgroundMusic(releaseDataValue)
	end
end

function M.playMusic(filename, isLoop)
	local loopValue = false
	if nil ~= isLoop then
		loopValue = isLoop
	end
	if not TFFileUtil:existFile(filename) then
		return
	end

	local lastName = M.currentMusic
	M.currentMusic = filename

	useNewAudioEngine = true;
	if useNewAudioEngine then		
		if lastName then 
			cookieList[lastName] = TFLuaTime:clock()
		end
		if backID ~= -1 then
			AudioEngine:stop(backID)
		end
		-- if lastName and lastName ~= filename then
		-- 	AudioEngine:uncache(lastName)
		-- end
		local baseVol = SettingDataMgr:getSoundMainVal()
    	local bgmVol = SettingDataMgr:getSoundBgmVal()
		backID = AudioEngine:play2d(filename, isLoop, backVolume)
		AudioEngine:setVolume(backID,baseVol * bgmVol);
		return backID
	else
		-- print("setTexture success,play backgroundMusic file url = \""..filename.."\"");
		sharedEngine:playBackgroundMusic(filename, loopValue)
	end
end

function M.pauseAllEffects()
	if useNewAudioEngine then
		AudioEngine:pauseAll()
	else
		sharedEngine:pauseAllEffects()
	end
end

function M.preloadMusic(filename)
	if useNewAudioEngine then
		AudioEngine:preload(filename)
	else
		sharedEngine:preloadBackgroundMusic(filename)
	end
end

function M.resumeMusic()
	if useNewAudioEngine then
		if backID ~= -1 then
			AudioEngine:resume(backID)
		end
	else
		sharedEngine:resumeBackgroundMusic()
	end
end

function M.playEffect(filename, isLoop, pitch, pan, gain, ...)
	local loopValue = false
	if nil ~= isLoop then
		loopValue = isLoop
	end
	if not TFFileUtil:existFile(filename) then
		return -1
	end
	pitch = pitch or 1
	pan = pan or 0
	gain = gain or 1
	if useNewAudioEngine then		
		-- cookieList[filename] = TFLuaTime:clock()
		local baseVol = SettingDataMgr:getSoundMainVal()
    	local effectVol = SettingDataMgr:getSoundEffectVal()
		local id = AudioEngine:play2d(filename, isLoop, gain)--AudioEngine:getVolume())
		AudioEngine:setVolume(id,gain * baseVol * effectVol)
		return id
	else
		-- print("setTexture success,play effect file url = \""..filename.."\"");
		return sharedEngine:playEffect(filename, loopValue, gain, ...)
	end
end

function M.rewindMusic()
	if useNewAudioEngine then

	else
		sharedEngine:rewindBackgroundMusic()
	end
end

function M.willPlayMusic()
	if useNewAudioEngine then
		return false
	else
		return sharedEngine:willPlayBackgroundMusic()
	end
end

function M.unloadEffect(filename)
	if useNewAudioEngine then
		AudioEngine:uncache(filename)
	else
		sharedEngine:unloadEffect(filename)
	end
end

function M.preloadEffect(filename)
	if useNewAudioEngine then
		AudioEngine:preload(filename)
	else
		sharedEngine:preloadEffect(filename)
	end
end

function M.setEffectsVolume(volume)
	volume = volume or 1.0
	if volume < 0.0 then
		volume = 0.0
	elseif volume > 1.0 then
		volume = 1.0
	end
	if useNewAudioEngine then
		AudioEngine:setVolume(volume)

		if backID ~= -1 then
			AudioEngine:setVolume(backID, backVolume)
		end
	else
		sharedEngine:setEffectsVolume(volume)
	end
end

function M.setEffectsVolumeById( handlerId, volume )
	volume = volume or 1.0
	if volume < 0.0 then
		volume = 0.0
	elseif volume > 1.0 then
		volume = 1.0
	end

	if useNewAudioEngine then 
		AudioEngine:setVolume(handlerId,volume)
	else
		sharedEngine:setEffectsVolume(volume)
	end
end

function M.pauseEffect(handle)
	if useNewAudioEngine then
		AudioEngine:pause(handle)
	else
		sharedEngine:pauseEffect(handle)
	end
end

function M.resumeAllEffects(handle)
	if useNewAudioEngine then
		AudioEngine:resumeAll()
	else
		sharedEngine:resumeAllEffects()
	end
end

function M.pauseMusic()
	if useNewAudioEngine then
		if backID ~= -1 then
			AudioEngine:pause(backID)
		end
	else
		sharedEngine:pauseBackgroundMusic()
	end
end

function M.resumeEffect(handle)
	if useNewAudioEngine then
		AudioEngine:resume(handle)
	else
		sharedEngine:resumeEffect(handle)
	end
end

local EmptyFunc = function() end
function M.setFinishCallback(handle, callback)
	local finishCall = EmptyFunc
    if callback then
        finishCall = function()
			local timer
			timer = TFDirector:addTimer(10, 1, function()
	            callback()
				TFDirector:removeTimer(timer)
			end)
    	end
    end

	if useNewAudioEngine then
		AudioEngine:setFinishCallback(handle, finishCall)
	else

	end
end

local modename = "TFAudio"
local proxy = {}
local mt    = {
	__index = M,
	__newindex =  function (t ,k ,v)
		print("attemp to update a read-only table")
	end
}
setmetatable(proxy,mt)
_G[modename] = proxy
package.loaded[modename] = proxy

function M.playBmg(filename, isLoop)
    SettingDataMgr:updateBgmVolume()
    TFAudio.playMusic(filename, isLoop)
end

function M.playSound(filename, isLoop)
    SettingDataMgr:updateSoundVolume()
    return TFAudio.playEffect(filename, isLoop)
end

function M.playVoice(filename, isLoop)
    SettingDataMgr:updateVoiceVolume()
    return TFAudio.playEffect(filename, isLoop)
end
