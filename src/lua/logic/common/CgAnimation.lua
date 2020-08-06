local CgAnimation = class("CgAnimation")

local bgBlurEffectTime = 0

function CgAnimation:ctor(parentNode,imageBg,id)

    self.curAfterId = 1
    self.id = id
    self:initRootNode(parentNode,imageBg,id)
end

function CgAnimation:initRootNode(parentNode,imageBg,id)

    if self.rootNode == nil then
        local _rootNode = CCNode:create()
        print("type(imageBg) ",type(imageBg))
        if type(imageBg) == "string" then
            self.imageBg = TFImage:create(imageBg)
            self.imageBg.isNew = true
            self.imageBg:Pos(ccp(me.Director:getWinSize().width/2,me.Director:getWinSize().height/2))
            parentNode:addChild(self.imageBg,999)
        elseif type(imageBg) == "userdata" then
            self.imageBg = imageBg
        end

        self.imageBg.savePos = self.imageBg:Pos()


        local ws = GameConfig.WS
        self.isResetBgSize = ws.width < 1386 and true or false

        --if self.isResetBgSize then
        --    print("GameConfig.WS.width ",GameConfig.WS.width)
        --    self.disScale = GameConfig.WS.width / 1386
        --    self.imageBg:setContentSize(CCSizeMake(self.imageBg:Size().width * self.disScale,self.imageBg:Size().height * self.disScale))
        --end

        parentNode:addChild(_rootNode,self.imageBg:getZOrder())
        self.rootNode = _rootNode
    end
end

function CgAnimation:start(overListener)
    self.overListener = overListener
    self:playCg(self.id)
    self:bgBlurEffect()
end

function CgAnimation:stop()

    if self.timerBlur then
        TFDirector:removeTimer(self.timerBlur)
    end
    if self.imageBg then
        self.imageBg:stopAllActions()
        self.imageBg:setPosition(self.imageBg.savePos)
    end
    self:free()
end

function CgAnimation:playCg(id)
    local fileName = id
    self:getDatas(fileName)
    self:checkData()
end

function CgAnimation:getDatas(fileName)
    --print "-----------测试读取"
    local filePath = "res.basic.cgAnimation"
    local str = string.format("%s.%s", filePath,fileName)
    --print("str " .. str)
    self.saveData = table.load(str)
end

function CgAnimation:checkData()
    if self.saveData.toData == nil or self.saveData.fromData == nil then
        return
    end

    if self.saveData.toData.imageBgInfo ~= nil then
        local toData = clone(self.saveData.toData)
        self.saveData.toData = {toData}
    end

    if type(self.saveData.time) == "table" then

    elseif type(self.saveData.time) == "number" then
        local time = clone(self.saveData.time)
        self.saveData.time = {time}
    end
    self:bindImageAnimationInfos()
end

function CgAnimation:bindImageAnimationInfos()
    if self.curAfterId > table.count(self.saveData.time) then
        if self.overListener then
            self.overListener()
        end
        return
    end

    local time = self.saveData.time[self.curAfterId]


    if self.curAfterId ~= 1 then
        self.curFromBgData = self.saveData.toData[self.curAfterId-1].imageBgInfo
        self.curFromNpcsData = self.saveData.toData[self.curAfterId-1].imageNpcsInfo
    else
        self.curFromBgData = self.saveData.fromData.imageBgInfo
        self.curFromNpcsData = self.saveData.fromData.imageNpcsInfo
    end
    self.imageBg.imageFromData = self.curFromBgData
    self.imageBg.imageToData = self.saveData.toData[self.curAfterId].imageBgInfo
    self.curToNpcsData = self.saveData.toData[self.curAfterId].imageNpcsInfo

    if self.playImageNpcs then
        for i,v in ipairs(self.curFromNpcsData) do
            local imageNpcInfo = v
            local data = imageNpcInfo.status
            self.playImageNpcs[i].imageFromData = data
        end
    else
        self.playImageNpcs = {}
        for i,v in ipairs(self.curFromNpcsData) do
            local imageNpcInfo = v
            local filePath = imageNpcInfo.filePath
            local tablePath = string.split(filePath, "cg\\")
            filePath = "modle/cg/" .. tablePath[table.count(tablePath)]
            local data = imageNpcInfo.status
            local imageNpc = TFImage:create(filePath)
            imageNpc.filePath = filePath
            imageNpc.imageFromData = data

            -- local imageWidth = imageNpc:Size().width
            -- local imageHeight = imageNpc:Size().height
            -- if self.isResetBgSize and self.disScale and imageHeight > 640 then
            --     imageNpc:setContentSize(CCSizeMake(imageWidth * self.disScale,imageHeight * self.disScale))
            -- end

            self.rootNode:addChild(imageNpc,500)
            table.insert(self.playImageNpcs,imageNpc)
        end
    end

    for i,v in ipairs(self.curToNpcsData) do
        local imageNpcInfo = v
        local imageNpc = nil
        local filePath = imageNpcInfo.filePath
        local tablePath = string.split(filePath, "cg\\")
        filePath = "modle/cg/" .. tablePath[table.count(tablePath)]
        for i,v in ipairs(self.playImageNpcs) do
            if filePath == v.filePath then
                imageNpc = v
            end
        end
        local data = imageNpcInfo.status
        imageNpc.imageToData = data
    end

    self:bindImageAnimationInfo(self.imageBg,time)
    for i,v in ipairs(self.playImageNpcs) do
        local imageNpc = v
        self:bindImageAnimationInfo(imageNpc,time)
    end

    local aniArr = {}
    table.insert(aniArr,DelayTime:create(time))
    local function acFun()
        self.curAfterId = self.curAfterId + 1
        self:bindImageAnimationInfos()
    end
    table.insert(aniArr,CallFunc:create(acFun))

    self.rootNode:runAction(CCSequence:createWithTable(aniArr))
end
function CgAnimation:bindImageAnimationInfo(image,time)
    local imageFromData = image.imageFromData
    local imageToData = image.imageToData

    local fromPos = imageFromData.pos
    local toPos = imageToData.pos
    local fromScale = imageFromData.scale
    local toScale = imageToData.scale
    local fromOpacity = imageFromData.opacity
    local toOpacity= imageToData.opacity

    local disx =  toPos.x - fromPos.x
    local disy = toPos.y - fromPos.y
    image.uDisx = disx / time
    image.uDisy = disy / time
    image.uScale = (toScale - fromScale)/time
    image.uOpacity = (toOpacity- fromOpacity)/time

    local info = {}
    info.pos = fromPos
    info.scale = fromScale
    info.opacity = fromOpacity
    self:defaultStatus(image,info)

    local spawnAc = {
        MoveTo:create(time,toPos),
        ScaleTo:create(time,toScale),
        FadeTo:create(time, toOpacity)
    }
    local aniArr = {}
    table.insert(aniArr,CCSpawn:create(spawnAc))
    if self.saveData.screenShake then
        local screenShakeAc = self:screenShakeSeq(5,20,10)
        table.insert(aniArr,screenShakeAc)
    end

    image:runAction(CCSequence:createWithTable(aniArr))

end

function CgAnimation:screenShakeSeq(offsetMin, offsetMax, count)
    local aniArr = {}
    for i = 1, count do
        local x = math.random(offsetMin, offsetMax)
        local y = math.random(offsetMin, offsetMax)
        table.insert(aniArr, CCMoveBy:create(0.05, ccp(x, y)))
        table.insert(aniArr, CCMoveBy:create(0.05, ccp(-x, -y)))
    end
    local seq = CCSequence:createWithTable(aniArr)
    return seq
end

function CgAnimation:defaultStatus(image,info)
    image:setPosition(info.pos)
    image:setScale(info.scale)
    image:setOpacity(info.opacity)
end

function CgAnimation:free()
    if self.rootNode then
        self.rootNode:removeFromParent()
        self.rootNode = nil
    end
    if self.imageBg then
        if self.imageBg.isNew then
            self.imageBg:removeFromParent()
        end
        self.imageBg = nil
    end
end

function CgAnimation:bgBlurEffect()

    if bgBlurEffectTime == 0 then
        return
    end
    self.imageBg:setShaderProgram("DalBlur", true)
    local gLProgramState = self.imageBg:getGLProgramState();
    self.imageBg.blurRadiusValue = 0.006
    gLProgramState:setUniformFloat("sampleNum", 2);
    gLProgramState:setUniformFloat("blurRadius", self.imageBg.blurRadiusValue);
    self.imageBg.gLProgramState = gLProgramState

    local timeCount = 10
    local interval = bgBlurEffectTime*1000/timeCount

    self.timerBlur = TFDirector:addTimer(interval, -1, nil, handler(self.updateBlurValue, self))
end

function CgAnimation:updateBlurValue(delta)
    self.imageBg.blurRadiusValue = self.imageBg.blurRadiusValue - 0.001
    self.imageBg.gLProgramState:setUniformFloat("blurRadius", self.imageBg.blurRadiusValue);
    if self.imageBg.blurRadiusValue <= 0.001 then
        TFDirector:removeTimer(self.timerBlur)
        return
    end
end

return CgAnimation