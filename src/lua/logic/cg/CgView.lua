
local CgView = class("cgView", BaseLayer)
CREATE_SCENE_FUN(CgView)

local CG_TYPE = {
    PIC = 1,                     -- 图片
    MASK = 2,                    -- 白色蒙版
    MUSIC = 3,                   -- 背景音乐
    SOUNDEFFECT = 4,             -- 音效
    END = 5,                     -- 结束标志
}

function CgView:initData()
    self.cgIndex_ = 1
    self.data_ = {}
    for i, v in ipairs(self.cgId_) do
        local data = CgDataMgr:getCg(v)
        table.insert(self.data_, data)
    end
end

function CgView:ctor(cgId, completeCallback)
    self.super.ctor(self)

    self.cgId_ = cgId
    self.completeCallback_ = completeCallback
    self:initData()

    self:init("lua.uiconfig.cg.cgView")
end

function CgView:initUI(ui)
	self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_root_size = self.Panel_root:Size()
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Image_cg = TFDirector:getChildByPath(self.Panel_prefab, "Image_cg")
    self.Panel_mask = TFDirector:getChildByPath(self.Panel_prefab, "Panel_mask")
    self.Panel_mask_size = self.Panel_mask:Size()
    self.Button_back = TFDirector:getChildByPath(self.Panel_root, "Button_back")

    self:refreshView()
end

function CgView:registerEvents()
    self.super.registerEvents(self)

    self.Button_back:addMEListener(TFWIDGET_CLICK, function()
                                       TFAudio.stopMusic()
                                       TFAudio.stopAllEffects()
                                       AlertManager:close()
    end)
end

function CgView:refreshView()
    self:trigger()
end

function CgView:trigger()
    local data = self.data_[self.cgIndex_]
    for i, v in ipairs(data) do
        self:generateCg(v)
    end
end

function CgView:calCgPos(imageAlignPos, screenAlignPos, target)
    local size = target:Size()
    local dap = target:AnchorPoint()
    local offsetAp = ccpSub(dap, imageAlignPos)
    local offsetP = ccp(offsetAp.x * size.width, offsetAp.y * size.height)
    local pos = ccp(self.Panel_root_size.width * screenAlignPos.x,  self.Panel_root_size.height * screenAlignPos.y)
    pos = ccpAdd(offsetP, pos)
    return pos
end

function CgView:updatePositionByAnchorPoint(newAp, target)
    local size = target:Size()
    local oldAp = target:AnchorPoint()
    local oldP = target:Pos()
    -- 计算改变锚点后的位置
    local offsetAp = ccpSub(newAp, oldAp)
    local offsetP = ccp(size.width * offsetAp.x, size.height * offsetAp.y)
    local newP = ccpAdd(oldP, offsetP)
    target:Pos(newP)
end

function CgView:generateCg(item)
    local target
    if item.cgType == CG_TYPE.PIC then
        target = self.Image_cg:clone():show()
        local imgPath = item.param
        target:setTexture(imgPath)
        target:AddTo(self.Panel_root)
        self:doDisplay(item, target)
    elseif item.cgType == CG_TYPE.MASK then
        target = self.Panel_mask:clone():show()
        target:AddTo(self.Panel_root)
        target:Size(self.Panel_mask_size)
        self:doDisplay(item, target)
    elseif item.cgType == CG_TYPE.MUSIC then
        target = self.Image_cg:clone():hide()
        target:AddTo(self.Panel_root)
        self:doPlaySound(item, target, true)
    elseif item.cgType == CG_TYPE.SOUNDEFFECT then
        target = self.Image_cg:clone():hide()
        target:AddTo(self.Panel_root)
        self:doPlaySound(item, target, false)
    elseif item.cgType == CG_TYPE.END then
        target = self.Image_cg:clone():hide()
        target:AddTo(self.Panel_root)
        self:doEnd(item, target, false)
    end
end

function CgView:doDisplay(item, target)
    local pos = self:calCgPos(item.imageAlignPos, item.screenAlignPos, target)
    target:Pos(pos)
    target:setOpacity(0)

    local aniArr = {
        CCDelayTime:create(item.appearTimeLine),
        CCCallFuncN:create(bind(self, self.appearCg, item)),
    }
    local aniSeq = CCSequence:createWithTable(aniArr)
    target:runAction(aniSeq)
end

function CgView:doEnd(item, target)
    local aniArr = {
        CCDelayTime:create(item.appearTimeLine),
        CCCallFunc:create(handler(self.onComplete, self)),
    }
    local aniSeq = CCSequence:createWithTable(aniArr)
    target:runAction(aniSeq)
end

function CgView:doPlaySound(item, target, isMusic)
    local play = isMusic and TFAudio.playMusic or TFAudio.playEffect
    local soundPath = item.param
    local appearTime = item.appearTime
    local showTime = item.showTime
    local disappearTime = item.disappearTime
    local totalTime = appearTime + showTime + disappearTime

    local soundHandle

    local aniArr = {
        CCDelayTime:create(item.appearTimeLine),
        CCCallFunc:create(function()
                if isMusic then
                    TFAudio.playMusic(soundPath)
                else
                    soundHandle = TFAudio.playEffect(soundPath)
                end
        end),
        CCDelayTime:create(totalTime),
        CCCallFunc:create(function()
                if isMusic then
                    TFAudio.stopMusic()
                else
                    TFAudio.stopEffect(soundHandle)
                end
        end)
    }
    local aniSeq = CCSequence:createWithTable(aniArr)
    target:runAction(aniSeq)
end

function CgView:appearCg(item, target)
    -- 出现
    local aniArr = {
        CCFadeIn:create(item.appearTime),
        CCDelayTime:create(item.showTime),
        CCCallFuncN:create(bind(self, self.disappearCg, item)),
    }
    local aniSeq = CCSequence:createWithTable(aniArr)
    target:runAction(aniSeq)

    local index = 1

    -- 移动
    index = 1
    while true do
        if not item["isMove_" .. index] then break end
        local imageAlignPos = item["imageAlignPos_" .. index]
        local screenAlignPos = item["screenAlignPos_" .. index]
        local pos = self:calCgPos(imageAlignPos, screenAlignPos, target)
        local moveTimeLine = item["moveTimeLine_" .. index]
        local moveTime = item["moveTime_" .. index]

        local aniArr = {
            CCDelayTime:create(moveTimeLine),
            CCMoveTo:create(moveTime, pos),
        }
        local aniSeq = CCSequence:createWithTable(aniArr)
        target:runAction(aniSeq)
        index = index + 1
    end

    -- 抖动
    index = 1
    while true do
        if not item["isShake_" .. index] then break end
        local offsetMin = item["shakeOffsetMin_" .. index]
        local offsetMax = item["shakeOffsetMax_" .. index]
        local count = item["shakeCount_" .. index]
        local shakeTimeLine = item["shakeTimeLine_" .. index]
        local shakeType = item["shakeType_" .. index]
        local seq = self:screenShakeSeq(offsetMin, offsetMax, count)
        local aniArr = {
            CCDelayTime:create(shakeTimeLine),
            seq,
        }
        local aniSeq = CCSequence:createWithTable(aniArr)
        if shakeType == 1 then
            self.Panel_root:runAction(aniSeq)
        elseif shakeType == 2 then
            target:runAction(aniSeq)
        end
        index = index + 1
    end

    -- 缩放
    index = 1
    while true do
        if not item["isScale_" .. index] then break end
        local scaleTimeLine = item["scaleTimeLine_" .. index]
        local scaleTime = item["scaleTime_" .. index]
        local scaneAp = item["scaneAp_" .. index]
        local scaleFactor = item["scaleFactor_".. index]
        local aniArr = {
            CCCallFunc:create(function()
                    self:updatePositionByAnchorPoint(scaneAp, target)
                    target:AnchorPoint(scaneAp)
            end),
            CCDelayTime:create(scaleTimeLine),
            CCScaleTo:create(scaleTime, scaleFactor),
        }
        local aniSeq = CCSequence:createWithTable(aniArr)
        target:runAction(aniSeq)
        index = index + 1
    end
end

function CgView:screenShakeSeq(offsetMin, offsetMax, count)
    local aniArr = {}
    for i = 1, count do
        local x = math.random(offsetMin, offsetMax)
        local y = math.random(offsetMin, offsetMax)
        -- aniArr:addObject(CCMoveBy:create(0.05, ccp(x, y)))
        -- aniArr:addObject(CCMoveBy:create(0.05, ccp(-x, -y)))
        table.insert(aniArr, CCMoveBy:create(0.05, ccp(x, y)))
        table.insert(aniArr, CCMoveBy:create(0.05, ccp(-x, -y)))
    end
    local seq = CCSequence:createWithTable(aniArr)
    return seq
end

function CgView:disappearCg(item, target)
    local aniArr = {
        CCFadeOut:create(item.disappearTime),
        CCCallFunc:create(function()
                target:RemoveSelf()
        end),
    }
    local aniSeq = CCSequence:createWithTable(aniArr)
    target:runAction(aniSeq)
end

function CgView:onComplete()
    TFAudio.stopMusic()
    TFAudio.stopAllEffects()
    if self.cgIndex_ + 1 > #self.data_ then
        if self.completeCallback_ then
            self.completeCallback_()
        end
    else
        self.cgIndex_ = self.cgIndex_ + 1
        self:trigger()
    end
end

return CgView
