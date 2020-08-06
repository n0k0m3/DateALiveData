local DatingResLoader = {}

DatingResLoader.resType = {
    SPINE = 1,
    IMAGE = 2,
    SOUND = 3,
    LIVE2D = 4
}

local function gettime()
    return socket.gettime()*1000
end

function DatingResLoader.loadTableRes(resTable)
    print("resTable")
    dump(resTable)

    for i,v in ipairs(resTable) do
        local resInfo = v
        DatingResLoader.loadRes(resInfo)
    end
end

function DatingResLoader.freeTableRes(resTable)
    print("resTable")
    dump(resTable)

    for i,v in ipairs(resTable) do
        local resInfo = v
        DatingResLoader.freeRes(resInfo)
    end
end

function DatingResLoader.loadRes(resInfo)
    local time = gettime()
    local resType = resInfo.resType
    if resType == DatingResLoader.resType.SPINE then
        DatingResLoader.loadSpine(resInfo.resName)
    elseif resType == DatingResLoader.resType.IMAGE then
        DatingResLoader.loadImage(resInfo.resName)
    elseif resType == DatingResLoader.resType.SOUND then
        DatingResLoader.loadSound(resInfo.resName)
    elseif resType == DatingResLoader.resType.LIVE2D then
        DatingResLoader.loadLive2d(resInfo.resName)
    end
    return gettime() - time
end

function DatingResLoader.freeRes(resInfo)
    local time = gettime()
    local resType = resInfo.resType
    if resType == DatingResLoader.resType.SPINE then
        DatingResLoader.freeSpine(resInfo.resName)
    elseif resType == DatingResLoader.resType.IMAGE then
        DatingResLoader.freeImage(resInfo.resName)
    elseif resType == DatingResLoader.resType.SOUND then
        DatingResLoader.freeSound(resInfo.resName)
    elseif resType == DatingResLoader.resType.LIVE2D then
        DatingResLoader.freeLive2d(resInfo.resName)
    end
    return gettime() - time
end


--图片
function DatingResLoader.loadImage(resName)
    me.TextureCache:addImage(resName)
end

function DatingResLoader.freeImage()
    me.TextureCache:removeUnusedTextures()
end

--spine
function DatingResLoader.loadSpine(filePath,scale)
    scale =  scale or 1
    SpineCache:getInstance():addFile(filePath..".json",filePath..".atlas",scale)
end

function DatingResLoader.freeSpine(resName)

end

--音效
function DatingResLoader.loadSound(filePath)
     TFAudio.preloadMusic(filePath)
end

function DatingResLoader.freeSound(resName)

end

--live2d
function DatingResLoader.loadLive2d(filePath)

end

function DatingResLoader.freeLive2d(resName)

end


return DatingResLoader