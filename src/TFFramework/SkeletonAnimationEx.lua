
-- SkeletonAnimation.create_ = SkeletonAnimation.create

function SkeletonAnimation:create(resPath,...)
    local jsonFile  = resPath..".skel"
    local atlasFile = resPath..".atlas"
    local acts = ...
    -- print("SkeletonAnimation:createWithFile",jsonFile,atlasFile)
    if acts then
        return SkeletonAnimation:createWithFile(jsonFile,atlasFile,...)
    else
        return SkeletonAnimation:createWithFile(jsonFile,atlasFile)
    end
end
