local PlayerInfoPublic = {}

local musicVolume = 5
local musicMaxVolume = 10
local effectVolume = 5
local effectMaxVolume = 10

function PlayerInfoPublic.setMusicVolume(volume)
    musicVolume = volume
end

function PlayerInfoPublic.getMusicVolume()
    return musicVolume
end

function PlayerInfoPublic.getMusicMaxVolume()
    return musicMaxVolume
end

function PlayerInfoPublic.setEffectVolume(volume)
    effectVolume = volume
end

function PlayerInfoPublic.getEffectVolume()
    return effectVolume
end

function PlayerInfoPublic.getEffectMaxVolume()
    return effectMaxVolume
end

function PlayerInfoPublic.volumeToValue(volume)
    return volume/10
end

return PlayerInfoPublic