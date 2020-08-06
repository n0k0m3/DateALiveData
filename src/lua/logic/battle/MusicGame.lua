local ResLoader   = import(".ResLoader")
local BattleUtils = import(".BattleUtils")
local BattleConfig= import(".BattleConfig")
local enum        = import(".enum")
local eAttrType   = enum.eAttrType
local eArmtureEvent =enum.eArmtureEvent
local ePKeyCode = enum.ePKeyCode
--评级
local eGrade = 
{
    PREFECT  = 1 ,
    GOOD     = 2 ,
    BAD      = 3 ,
    MISS     = 4,
}
--音符类型
local eSymbolType= 
{
    ShortNote     = 1,--短音符
    LongNote      = 2,--长音符
    LLongNote     = 3,--还是长音符
}


local TextureInfos = 
{
{
    [1]={res="ui/musicgame/note1.png" ,scaleX = -1},
    [2]={res="ui/musicgame/note2.png" ,scaleX = -1},
    [3]={res="ui/musicgame/note3.png" ,scaleX = 1},
    [4]={res="ui/musicgame/note2.png" ,scaleX = 1},
    [5]={res="ui/musicgame/note1.png" ,scaleX = 1},
},
{
    [1]={res="ui/musicgame/long_note1.png" ,scaleX = -1},
    [2]={res="ui/musicgame/long_note2.png" ,scaleX = -1},
    [3]={res="ui/musicgame/long_note3.png" ,scaleX = 1},
    [4]={res="ui/musicgame/long_note2.png" ,scaleX = 1},
    [5]={res="ui/musicgame/long_note1.png" ,scaleX = 1},
},

{
    [1]={res="ui/musicgame/llong_note1.png" ,scaleX = -1},
    [2]={res="ui/musicgame/llong_note2.png" ,scaleX = -1},
    [3]={res="ui/musicgame/llong_note3.png" ,scaleX = 1},
    [4]={res="ui/musicgame/llong_note2.png" ,scaleX = 1},
    [5]={res="ui/musicgame/llong_note1.png" ,scaleX = 1},
}

}




local resPath = "effect/effects_11001_skillD/effects_11001_skillD"



local GradeRes =
{
    [eGrade.PREFECT] ="ui/musicgame/profect.png",
    [eGrade.GOOD]    ="ui/musicgame/good.png",
    [eGrade.BAD]="ui/musicgame/bad.png",
    [eGrade.MISS]    ="ui/musicgame/miss.png",
}



local Animation =
{
    Pressed = "effects_11001_skillD2_loop",
    Down    = "effects_11001_skillD2",
}




local COLORS = 
{

-- me.WHITE    ,
me.YELLOW   ,
-- me.BLUE      ,
me.GREEN     ,
me.RED        ,
me.MAGENTA   ,
-- me.BLACK  ,
me.ORANGE    ,
me.GRAY      

}



-- --音符
local Note = class("Note",function ()
    return CCNode:create()
end)

function Note:ctor(track,data,moveTime)
    self.data  = data
    self.track = track --位置
    local distance = me.pGetDistance(self.track.ed_point,self.track.st_point)
    -- local verticalSize  = math.abs(self.endPos.y - self.starPos.y) 
    self.nXYV   = distance / moveTime --速度
    self.vector = ccp(0,0)

    self.vector.x = (self.track.ed_point.x - self.track.st_point.x)/distance * self.nXYV 
    self.vector.y = (self.track.ed_point.y - self.track.st_point.y)/distance * self.nXYV 
    self.position = ccp(self.track.st_point)
    self:setPosition(self.track.st_point)







    local textureInfo --= TextureInfos[self.track.index]
    if self.data.symbolType == 1 then
        textureInfo = TextureInfos[1][self.track.index]
    elseif self.data.symbolType == 2 then
        textureInfo = TextureInfos[2][self.track.index]
    elseif self.data.symbolType == 3 then
        textureInfo = TextureInfos[3][self.track.index]
    end

    -- local textureInfo = TextureInfos[self.track.index]
    self.renderNode   = TFImage:create(textureInfo.res)
    self.renderNode:setScaleX(textureInfo.scaleX)
    self:addChild(self.renderNode)
    self:setScale(0.22)


    self.tarckSize  = math.abs(self.track.ed_point.y - self.track.st_point.y) 

    self.bActive = true
    self.nAtkValue  = 0

end

function Note:getSymbolType()
    return self.data.symbolType
end

function Note:move(time)
    local xv = self.vector.x * time --* 0.001
    local yv = self.vector.y * time --* 0.001
    self.position.x = self.position.x + xv
    self.position.y = self.position.y + yv
    self:setPosition(self.position)
    local scale = math.abs(self.position.y - self.track.st_point.y)/self.tarckSize *0.78
    self:setScale(math.min(0.22 + scale, 1))
    -- print("0.22 + scale ",0.22 + scale )

end

--检查评级
function Note:hitTest(trackIndex) 
    if not self.bActive then return  end
    if self.track.index == trackIndex then
        if self.data.symbolType == 2 or self.data.symbolType == 1 then
            -- print("self.position.y",self.position.y)
            for grade , size in ipairs(self.data.area) do
               if math.abs(self.position.y) <= size/2 then
                    return grade , self.data.score[grade]
               end
            end
        end
    end
end



function Note:update(time)
    if not self.bActive then 
        return 
    end
    self:move(time)
    --检查触发miss
    if self.position.y < 0 then
        if math.abs(self.position.y) > self.data.area[#self.data.area]*0.5 then
            self.bActive = false
            self.manger:showGrade(eGrade.MISS)
            self.manger:setCombo(0)
            self.track.continue = nil
            self.track.isPressed= false
            return 
        end
    end
    -- if self.track.continue = { result = result, score = score , id = note.data.id  }
    if self.data.symbolType == eSymbolType.LLongNote then
        local continue = self.track.continue
        if continue then
            if self.data.id == continue.id then
                -- local grade ,score = self:hitTest(self.track.index) 
                -- if grade == 1 then 
                    if self.position.y < 0 then
                        print("asdfffffffffff")
                        self.manger:showGrade(continue.grade)
                        self.manger:addScore(continue.score)
                        self.manger:addCombo(1)
                        self.manger:playHitEffect(self.track.key:getPosition())
                    end
                -- end
            end
        end
    end
end

--检查是否出界
function Note:isActive()
    return self.bActive
end

--根据当前的位置缩放
function Note:doScale()

end

function Note:evaluate()
    
end

local TouchEvent = {}
TouchEvent.began = "began"
TouchEvent.ended = "ended"
TouchEvent.moved = "moved"







local MusicGame = class("MusicGame",BaseLayer)

function MusicGame:ctor( id ,host)
    self.super.ctor(self)
    self:init("lua.uiconfig.battle.musicgame")
    self.noteList = {}
    -- self.timer = TFDirector:addTimer(100, -1, nil, handler(self.generator,self))
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    self.host = host
    --计时器
    self.nClockTime = nil
    self.nStartTime = nil
    self.nNoteIndex = 0
    self.bActive    = true
    self:initlize(id)
end



-- return {
--     [1] = {
--         showEffect = "effects_11001_skillD",
--         endEffect = "effects_11001_skillD",
--         symbolGroup = 101,
--         id = 1,
--         gameMusic = "sound/battle_sound/battle_001.mp3",
--         startAction = "",
--         gameTime = 17000,
--         skillEffectId = 86010,
--         gameUi = "",
--         showAction = "effects_11001_skillD3_loop",
--         startEffect = "",
--         endAction = "effects_11001_skillD4",
--     },
-- }



--初始化
function MusicGame:initlize(id)
    id = id or 1
    self.data = TabDataMgr:getData("MusicGame",id) 
    local groupId = self.data.symbolGroup
    self.nCountDownTime = self.data.gameTime*0.001
    self.nScore    = 0
    self.nCombo    = 0
    self.noteDatas = {}
    local datas   = TabDataMgr:getData("MusicSymbol")
    for k , data in pairs(datas) do
        -- if data.symbolGroup == 101 then
            if data.symbolType == eSymbolType.ShortNote then
                self.noteDatas[#self.noteDatas + 1] =  clone(data)
            elseif data.symbolType == eSymbolType.LongNote then 
                local longData = data.longData
                for index = 1,longData[1] do
                    local copyData = clone(data)
                    if index > 1 then
                        copyData.symbolType = eSymbolType.LLongNote --连击音符
                    end
                    copyData.knockTime = copyData.knockTime + (index -1)*longData[2]
                    self.noteDatas[#self.noteDatas + 1] =  copyData
                end
            end
        -- end
    end
    table.sort(self.noteDatas,function ( a  ,b)
        return a.knockTime < b.knockTime
    end)

    self:setAtkValue(0)
    self:addScore(0)
    self:setCombo(0)
    self:registerPKeyEvent()
end


function MusicGame:doExit()
    self:playEndEffect(function()
        if battleController then
            battleController.resume()
            BattleUtils.playPreMusic(true)
        end
        AlertManager:closeLayer(self)
    end)
end

--初始化
function MusicGame:playEndEffect(callFunc)
    local _resPath  = self.data.endEffect
    local animation = self.data.endAction
    _resPath = string.format("effect/%s/%s",_resPath,_resPath)
    local skeletonNode = ResLoader.createSkeletonAnimation(_resPath)
    skeletonNode:play(animation,0)
    skeletonNode:setScale(0.48)
    -- skeletonNode:addMEListener(TFARMATURE_EVENT,handler(self.onArmtureEvent,self))
    skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
                skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                skeletonNode:removeMEListener(TFARMATURE_EVENT)
                skeletonNode:removeFromParent()
                if callFunc then
                    callFunc()
                end
            end)
    local size   = self.panel_effect:getSize()
    skeletonNode:setPosition(ccp(size.width/2,size.height/2))
    self.panel_effect:addChild(skeletonNode,999)

end


function MusicGame:onArmtureEvent(...)
    -- local event = BattleUtils.translateArmtureEventData(...)
    -- if event.name == eArmtureEvent.EFFECT then
    --     event.skeleton:removeMEListener(TFARMATURE_EVENT)
    --     self.panel_root:fadeOut(0.1)
    --     if battleController then
    --         battleController.resume()
    --     end
    -- end
end


function MusicGame:initUI(ui)
    self.super.initUI(self, ui)
    self.root = ui
    self.tracks = {}
    for index = 1, 5 do
        local track = {}
        track.index        = index 
        track.st_point     = ccp(TFDirector:getChildByPath(ui, "st_point"..index):getPosition())
        track.ed_point     = ccp(TFDirector:getChildByPath(ui, "ed_point"..index):getPosition())
        track.hightlight   = TFDirector:getChildByPath(ui, "Image_hightlight"..index):hide()
        track.key          = TFDirector:getChildByPath(ui, "Button_key"..index)
        track.skeletonNode = TFDirector:getChildByPath(ui, "Spine_longpress"..index):hide()
        track.skeletonNode:setScale(0.475) --BattleConfig.MODAL_SCALE)
        self.tracks[index] = track
        track.key.track    = track
        track.key:onTouch(handler(self.onTouch,self))
    end
    self.panel_root  = TFDirector:getChildByPath(ui, "Panel_root")
    self.panel_effect = TFDirector:getChildByPath(ui, "Panel_effect")
    self.panel_notes = TFDirector:getChildByPath(ui, "Panel_notes")
    self.panel_notes:removeAllChildren()

    local line = TFDirector:getChildByPath(ui, "Image_line")
   -- line:hide()
    -- dump(self.tracks)
    -- Box("asdf")
    self.textTime  = TFDirector:getChildByPath(ui, "LabelBMFont_time")
    self.textScore = TFDirector:getChildByPath(ui, "LabelBMFont_score")
    --连击数
    self.textCombo     = TFDirector:getChildByPath(ui, "Label_combo")
    self.textAtkValue  = TFDirector:getChildByPath(ui, "Label_atk_value")

    self.btnExit = TFDirector:getChildByPath(ui, "Button_exit")
    self.btnExit:onClick(function()
            if battleController then
                battleController.resume()
                BattleUtils.playPreMusic(true)
            end
            AlertManager:closeLayer(self)
        end)
    --TODO test
    -- local button = TFImage:create("ui/musicgame/note1.png")
    -- button:setTouchEnabled(true)
    -- button:onClick(function ( )
    --     AlertManager:closeLayer(self)
    --     TFDirector:unRequire("lua.logic.battle.MusicGame")
    -- end)
    -- button:setPosition(ccp(200,600))
    -- self:addChild(button,999)
end

--连击数
function MusicGame:addCombo(combo)
    self.nCombo = self.nCombo + combo
    self.textCombo:setText(tostring(self.nCombo))
end

function MusicGame:setCombo(combo)
    self.nCombo = combo
    self.textCombo:setText(tostring(self.nCombo))
end
--增加攻击力
function MusicGame:setAtkValue(value)
    -- self.nCombo = combo
    self.textAtkValue:setText(string.format("+%s%%",value))
end

function MusicGame:addScore(score)
    self.nScore = self.nScore + score
    self.textScore:setText(self.nScore)
    self:calcuAtk()
    self:setAtkValue(math.floor(self.nAtkValue*0.01))
end
--计算攻击加层
function MusicGame:calcuAtk()
    self.nAtkValue = math.floor(self.nScore/self.data.score*0.3*10000)
    if self.host then
        local property = self.host:getProperty()
        property:setExpandValue(eAttrType.ATTR_DMADD_JX,self.nAtkValue)
    end
end

function MusicGame:playHitEffect(position)
    local skeletonNode = ResLoader.createSkeletonAnimation(resPath)
    skeletonNode:play(Animation.Down,0)
    skeletonNode:setPosition(position)
    skeletonNode:setScale(0.475)
    skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
                skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                skeletonNode:removeFromParent()
            end)
    self.panel_root:addChild(skeletonNode,999)
end

function MusicGame:showGrade(grade)
    local size = self.panel_root:getSize()
    local res = GradeRes[grade]
    local image = TFImage:create(res)
    image:setPosition(ccp(size.width/2,size.height/2))
    self.panel_root:addChild(image,999)
    BattleUtils.tipAniYellow(image)
end

function MusicGame:onTouch(event)
    -- print("onTouch",event)
    local name    = event.name
    local target = event.target
    local track  = target.track
    if name == TouchEvent.began then
        self:doPKeyPressed(track)
    elseif name == TouchEvent.ended then
        self:doPKeyReleased(track)
    end

end

local function getTime()
    return socket.gettime() --*1000
end

function MusicGame:update(object,time)
    if not self.bActive then 
        return
    end 
    local clockTime = getTime()
    if not self.nClockTime then
        self.nClockTime = clockTime
        self.nStartTime = self.nClockTime
        --开始播放背景音乐
        BattleUtils.playMusic(self.data.gameMusic,false)
    end    
    local dtTime =  clockTime - self.nClockTime 
    self.nClockTime = clockTime
    --print(self.nClockTime - self.nStartTime ,BattleUtils.round(self.nClockTime - self.nStartTime))  
    --更新时间
    local showTime = self.nCountDownTime - (self.nClockTime - self.nStartTime)
    showTime = math.max(showTime,0) 
    self.textTime:setText(BattleUtils.round(showTime))
    -- print(getTime())
    -- print("dtTime",os.clock(),os.time())
    for index = #self.noteList, 1 ,-1 do
            -- print("index",index,#self.noteList)
        local note = self.noteList[index]
        note:update(dtTime)
        if not note:isActive() then
            note:removeFromParent()
            table.remove(self.noteList, index)
        end
    end
    --音符生成
    self:generator(self.nClockTime - self.nStartTime)
    if showTime <= 0 then 
         self.bActive = false
         self:doExit()
         --清理音符
         --播放动画
    end
end



--生成音符
function MusicGame:generator(clockTime)
    if #self.noteDatas > 0 then
        local noteData   = self.noteDatas[1] 
        local targetTime = noteData.knockTime*0.001
        local moveTime   = noteData.processTime*0.001
        local dtTime = targetTime - clockTime
        if dtTime > 0 then
            if  dtTime <= moveTime then
                --创建note
                table.remove(self.noteDatas,1)
                local track = self.tracks[noteData.pathway]
                local note  = Note:new(track,noteData,dtTime)
                note.manger = self
                self.panel_notes:addChild(note)
                table.insert(self.noteList,note)
            end
        else
            --时间已过pass 掉了
            table.remove(self.noteDatas,1)
        end

    end
end


function MusicGame:removeEvents()
    --
    -- Box("移除事件")
    self:unRegisterPKeyEvent()
end



function MusicGame:doPKeyPressed(track)
 
    if not track.isKeyDown then
        track.isKeyDown = true
        -- print("pressed:",track.index)
        track.hightlight:show()
        track.isPressed = true
        -- track.skeletonNode:play(Animation.Pressed,1)
        -- track.skeletonNode:show()
        for index, note in ipairs(self.noteList ) do
            local grade , score = note:hitTest(track.index)
            if grade then
                self:addCombo(1)
                self:addScore(score)
                self:playHitEffect(track.key:getPosition())
                self:showGrade(grade)
                if note:getSymbolType() == 2 then
                    track.continue = { grade = grade, score = score , id = note.data.id  }
                end  
                table.remove(self.noteList, index)
                note:removeFromParent()
                break
            end
        end
    end
end

function MusicGame:doPKeyReleased(track)
    -- print("release:",track.index)
    track.isPressed = false
    track.continue  = nil
    track.hightlight:hide()
    track.skeletonNode:hide()
    track.isKeyDown = false
end


local KeyValues =
{
    ePKeyCode.Z,
    ePKeyCode.X,
    ePKeyCode.C,
    ePKeyCode.N,
    ePKeyCode.M
}
function MusicGame:registerPKeyEvent(pKeyCode,vKeyNode)
    if me.platform == "win32" and DEBUG == 1 then
        self.pKeyPressedHandles  = {}
        self.pKeyReleasedHandles = {}
        for i = 1,5 do
            local track = self.tracks[i]
            if TFDirector.registerKeyDown then
                self.pKeyPressedHandles[KeyValues[i]] = handler(self.doPKeyPressed,self)
                TFDirector:registerKeyDown(KeyValues[i], {nGap = 0}, self.pKeyPressedHandles[KeyValues[i]],track)
            end
            if TFDirector.registerKeyUp then
                self.pKeyReleasedHandles[KeyValues[i]] = handler(self.doPKeyReleased,self)
                TFDirector:registerKeyUp(KeyValues[i], {nGap = 0}, self.pKeyReleasedHandles[KeyValues[i]] ,track)
            end
        end
    end
end

function MusicGame:unRegisterPKeyEvent()
    if me.platform == "win32" and DEBUG == 1 then
        if self.pKeyPressedHandles then
            for pKeyCode , pKeyHandle in pairs(self.pKeyPressedHandles) do
                TFDirector:unRegisterKeyDown(pKeyCode,pKeyHandle)
            end
            self.pKeyPressedHandles = nil
        end
        if self.pKeyReleasedHandles then
            for pKeyCode , pKeyHandle in pairs(self.pKeyReleasedHandles) do
                TFDirector:unRegisterKeyUp(pKeyCode,pKeyHandle)
            end
            self.pKeyReleasedHandles = nil
        end
    end
end







return MusicGame