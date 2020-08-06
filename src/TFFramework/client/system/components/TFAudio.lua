--Encapsulate SimpleAudioEngine to AudioEngine,Play music and sound effects. 
local M = {}
local sharedEngine = SimpleAudioEngine:sharedEngine()

local useNewAudioEngine = false

local backID = -1
local backVolume = 1

function M.useNewEngine(enable)
	if nil == enable then
		enable = true
	end
	useNewAudioEngine = enable
end

function M.stopAllEffects()
	if useNewAudioEngine then 
		AudioEngine:stopAll()
		AudioEngine:uncacheAll()
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
	
	if useNewAudioEngine then 
		if backID ~= -1 then
			AudioEngine:stop(backID)
		end
		if lastName and lastName ~= filename then
			AudioEngine:uncache(lastName)
		end
		backID = AudioEngine:play2d(filename, isLoop, backVolume)
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
		return AudioEngine:play2d(filename, isLoop, gain * AudioEngine:getVolume())
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
	end
	sharedEngine:setEffectsVolume(volume)
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
	callback = callback or EmptyFunc
	
	if useNewAudioEngine then 
		AudioEngine:setFinishCallback(handle, callback)
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


local bIsMusicPlaying = false

-- TFDirector:addTimer(0, -1, nil, function ()
-- 	if bIsMusicPlaying ~= sharedEngine:isBackgroundMusicPlaying() then
-- 		bIsMusicPlaying = sharedEngine:isBackgroundMusicPlaying()
-- 		if bIsMusicPlaying then
-- 			TFDirector:dispatchGlobalEventWith("TFMUSICEVENTPLAY")
-- 			print("music play")
-- 		else
-- 			TFDirector:dispatchGlobalEventWith("TFMUSICEVENTSTOP")
-- 			print("music stop")
-- 		end
-- 	end
-- end)