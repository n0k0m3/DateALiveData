
---弹幕显示规则
---弹幕从区域1到区域14，每个区域铺满3条，若不足三条，这将弹幕总数%3的数目铺在当前区域或者当前区域加1
---例如：有5条弹幕，优先铺满1区域，多余的2条，则显示在 区域2和区域3中随机的区域
---14个区域铺满之后，又循环从1区域铺至14区域

local DatingDanMuView = class("DatingDanMuView", BaseLayer)
local DanMuState ={
    stop = 0,
    ing = 1
}
function DatingDanMuView:initData(barrageCid)
    self:resetData(barrageCid)
end

function DatingDanMuView:resetData(barrageCid)

    DanmuDataMgr:resetDatingIndex(barrageCid)

    self.danMudata = {}
    self.barrageCid = barrageCid
    
    self.perNum = 3

    self.danmuCfg = TabDataMgr:getData("Bulletscreencontrol")
    self.danmuPool = {}
    self.allDanmuItem = {}
    self.speed = {}
    for k,v in ipairs(self.danmuCfg) do
        self.speed[k] = v.speed
    end
    self.maxAreaId = #self.danmuCfg
    self.upSpeed = 0
    self.outDanmuCnt = 0
    self.lineSpace = 15
    self.waitSpace = 100
    self.upBaseSpeed = 20
    
    self.pageIds = {}
end

function DatingDanMuView:ctor(danMudata)
    self.super.ctor(self)
    self:initData(danMudata)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dating.datingDanMuView")
end

function DatingDanMuView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_Area = TFDirector:getChildByPath(self.Panel_root, "Panel_Area")
    local h = self.Panel_Area:getContentSize().height
    self.size = CCSize(GameConfig.WS.width,h)
    self.Panel_Area:setSize(self.size)

    self.Button_upspeed = TFDirector:getChildByPath(self.Panel_root, "Button_upspeed")

    self.Panel_word = TFDirector:getChildByPath(self.Panel_root, "Panel_word")

end

function DatingDanMuView:getDanmuCfg(areaId)
    return self.danmuCfg[areaId]
end

function DatingDanMuView:showDamu()
    self:startDanMu(1)
end

function DatingDanMuView:startDanMu(areaId)

    if self.state == DanMuState.stop then
        return
    end

    local curAreaData = self.word[areaId]
    if not curAreaData then
        return
    end

    self:moveAreaDanmu(areaId,curAreaData)
    local waitTime = 0
    self:timeOut(function()
        self:startDanMu(areaId+1)
    end,waitTime)
end

function DatingDanMuView:moveAreaDanmu(areaId)
    self:outDanmu(areaId,1)
end

function DatingDanMuView:outDanmu(areaId,index)

    if self.state == DanMuState.stop then
        return
    end

    local cfg = self:getDanmuCfg(areaId)
    if not cfg then
        return
    end

    local curAreaTab = self.word[areaId]
    if not curAreaTab then
        return
    end

    local curWordTab = curAreaTab[index]
    if not curWordTab then
        return
    end

    local curWord = curWordTab.data
    curWordTab.isStart = true
    self.outDanmuCnt = self.outDanmuCnt + 1
    local Panel_word = self:getCloneItem(areaId)
    if not Panel_word then
        Panel_word = self.Panel_word:clone()
        self.Panel_Area:addChild(Panel_word)
        if not self.allDanmuItem[areaId] then
            self.allDanmuItem[areaId] = {}
        end
        table.insert(self.allDanmuItem[areaId],Panel_word)
    end
    local Label_word = Panel_word:getChildByName("Label_word")
    local Image_out = Panel_word:getChildByName("Image_out")
    Label_word:setFontName(cfg.name)
    Label_word:setFontSize(cfg.fontSize)
    Label_word:setOpacity(cfg.transparency*255)

    Label_word:setText(curWord.content)
    local size = Label_word:getContentSize()
    Panel_word:setContentSize(size)
    Label_word:setPosition(ccp(size.width/2,-size.height/2))
    Image_out:setContentSize(CCSizeMake(size.width+10,size.height+4))
    Image_out:setVisible(curWordTab.isSelf)
    Image_out:setPosition(ccp(size.width/2,-size.height/2))

    local color = curWordTab.isSelf and ccc3(249,219,71) or ccc3(246,254,255)
    Label_word:setColor(color)
    local outLineColor = curWordTab.isSelf and ccc4(89,64,21,255) or ccc4(48,53,74,255)
    Label_word:enableOutline(outLineColor,2)

    local posX = self.size.width/2+5
    local posY = self.size.height/2 - (areaId - 1)*(cfg.fontSize+self.lineSpace)
    local srcPos = ccp(posX,posY)
    Panel_word:setPosition(srcPos)

    local targetPosX = -self.size.width/2 - size.width - 2
    local targetPos = ccp(targetPosX,posY)
    local speed = self.speed[areaId] + self.upSpeed

    local waitTime = (size.width+self.waitSpace)/speed
    local nextPawnPosX = srcPos.x - (size.width+self.waitSpace)
    local time = math.abs((targetPosX - nextPawnPosX) /speed)

    local act = CCSequence:create({
        CCMoveTo:create(waitTime,ccp(nextPawnPosX,targetPos.y)),
        CCCallFunc:create(function()
            if areaId == self.lastDamu.areaId and index == self.lastDamu.index then
                table.remove(self.pageIds,1)
                self.curDanmu = nil
                dump({},"normalNext")
                self:startNextPageDanmu()
            end
            index = index + 1
            self:outDanmu(areaId,index)
        end),
        CCMoveTo:create(time,targetPos),
        CCCallFunc:create(function()
            Panel_word:setPosition(srcPos)
            self:insertClonePool(areaId,Panel_word)
        end)
    })
    Panel_word:runAction(act)

end

function DatingDanMuView:insertClonePool(areaId,item)
    if not self.danmuPool[areaId] then
        self.danmuPool[areaId] = {}
    end
    item:stopAllActions()
    table.insert(self.danmuPool[areaId],item)
end

function DatingDanMuView:getCloneItem(areaId)

    if not self.danmuPool[areaId] then
        return
    end
    local item = self.danmuPool[areaId][1]
    if not item then
        return
    end
    table.remove(self.danmuPool[areaId],1)
    return item
end

function DatingDanMuView:accelerationDanmu(mul)

    self.upSpeed = self.upBaseSpeed*mul
    dump(self.lastDamu,"accelerationDanmu")
    local srcPosX = self.size.width/2+5
    for k,tab in pairs(self.allDanmuItem) do
        for index,item in ipairs(tab) do
            item:stopAllActions()
            local posX = item:getPositionX()
            local width = item:getContentSize().width
            local targetPosX = -self.size.width/2 - width - 2
            local cfg = self:getDanmuCfg(k)
            local posY = self.size.height/2 - (k - 1)*(cfg.fontSize+self.lineSpace)
            local targetPos = ccp(targetPosX,posY)
            if posX < srcPosX and posX > targetPosX then
                local speed = self.speed[k] + self.upSpeed

                local act
                local time = math.abs((targetPosX-posX)/speed)
                local nextPawnPosX = srcPosX - (width+self.waitSpace)
                if posX > nextPawnPosX then
                    local waitTime = (posX - nextPawnPosX)/speed
                    time = math.abs((targetPosX - nextPawnPosX) /speed)
                    act = CCSequence:create({
                        CCMoveTo:create(waitTime,ccp(nextPawnPosX,targetPos.y)),
                        CCCallFunc:create(function()
                            if k == self.lastDamu.areaId and index == self.lastDamu.index then
                                table.remove(self.pageIds,1)
                                self.curDanmu = nil
                                dump({},"accelerationDanmu")
                                self:startNextPageDanmu()
                            end
                            index = index + 1
                            self:outDanmu(k,index)
                        end),
                        CCMoveTo:create(time,targetPos),
                        CCCallFunc:create(function()
                            item:setPosition(ccp(srcPosX,posY))
                            self:insertClonePool(k,item)
                        end)
                    })
                else
                    act = CCSequence:create({
                        CCCallFunc:create(function()
                            if k == self.lastDamu.areaId and index == self.lastDamu.index then
                                table.remove(self.pageIds,1)
                                self.curDanmu = nil
                                dump({},"accelerationDanmuNormal")
                                --self:startNextPageDanmu()
                            end
                        end),
                        CCMoveTo:create(time,targetPos),
                        CCCallFunc:create(function()
                            item:setPosition(ccp(srcPosX,posY))
                            self:insertClonePool(k,item)
                        end)
                    })
                end
                if act then
                    item:runAction(act)
                end
            end
        end
    end
end

function DatingDanMuView:startNextPageDanmu()

    self:makeWord()
    self:showDamu()
end

---按照弹幕显示规则标记弹幕
function DatingDanMuView:makeWord()

    self.word = {}

    local dialogueId = self.dialogueId--self.pageIds[1] or self.dialogueId
    if not dialogueId then
        self.curDanmu = nil
        return
    end

    self.curDanmu = self.danMudata[dialogueId]
    table.remove(self.pageIds,1)
    dump(self.curDanmu,"dialogueId:"..dialogueId)
    if not self.curDanmu then
        DanmuDataMgr:getDanmu(self.barrageCid)
        return
    end


    local totalSize = #self.curDanmu

    ---计算需要随机区域的弹幕ID,区域ID
    local danmuId,randomAreaId,overCnt
    if totalSize > self.perNum then
        overCnt = math.mod(totalSize,self.perNum)
        local areaId = math.floor(totalSize/self.perNum)
        if overCnt > 0 then
            areaId = math.mod(areaId,self.maxAreaId)
            if areaId == 0 then
                randomAreaId = 1
            else
                randomAreaId = areaId+1
                if randomAreaId > self.maxAreaId then
                    randomAreaId = self.maxAreaId
                end
            end
        end
    end

    for k,v in ipairs(self.curDanmu) do
        local areaId = math.ceil(k/self.perNum)
        if areaId > self.maxAreaId then
            areaId = math.mod(areaId-1,self.maxAreaId)+1
        end
        if randomAreaId and k > totalSize - overCnt then
            areaId = randomAreaId
        end

        if not self.word[areaId] then
            self.word[areaId] = {}
        end

        table.insert(self.word[areaId],{data = v, isStart = false, isSelf = v.type ==1})
    end

    self:findLastDanMu()

end

---找出最后一条消失的弹幕
function DatingDanMuView:findLastDanMu()
    local minTime = -1
    self.lastDamu = {areaId = 0,index = 0}
    for areaId,tab in ipairs(self.word) do
        local len = 0
        for k,v in ipairs(tab) do
            if v.data.content then
                len = len + #v.data.content
            end
        end

        ---最大速度来计算最后出现的弹幕，防止速度变化导致的最后一条弹幕计算错误
        local time = len/(self.speed[areaId] + self.upBaseSpeed*3)
        if time >minTime then
            minTime = time
            self.lastDamu.areaId = areaId
            self.lastDamu.index = #tab
        end
    end
end

function DatingDanMuView:insertWord(data)

    local tab = self.word[1]
    if not tab then
        self:onRecvDanMuData(self.barrageCid,{data})
        return
    end

    local index
    for k,v in ipairs(tab) do
        if v.isStart then
            index = k
        end
    end
    if index then
        table.insert(self.word[1],index+1,{data = data,isStart = false, isSelf = true})
    end
    self:findLastDanMu()
end

---itemData: 约会的itemData
function DatingDanMuView:updateDanMuData(itemData)
    self.dialogueId = itemData.id
    dump({self.dialogueId,self.curDanmu == nil},"当前句子ID：")
    table.insert(self.pageIds,itemData.id)
    if not self.curDanmu and self.state ~= DanMuState.stop then
        dump({},"updateDanMuData")
        self:startNextPageDanmu()
    end
end

---停止所有弹幕
function DatingDanMuView:stopAllDanum()
    local srcPosX = self.size.width/2+5
    for k,tab in pairs(self.allDanmuItem) do
        for _,item in ipairs(tab) do
            item:stopAllActions()
            local cfg = self:getDanmuCfg(k)
            local posY = self.size.height/2 - (k - 1)*(cfg.fontSize+self.lineSpace)
            item:setPosition(ccp(srcPosX,posY))
        end
    end
    self.state = DanMuState.stop
end

function DatingDanMuView:jumpDanMu()
    for i=#self.pageIds,1,-1 do
        if i~= #self.pageIds then
            table.remove(self.pageIds,i)
        end
    end
    self.state = DanMuState.ing
    self:startNextPageDanmu()
end

function DatingDanMuView:onRecvDanMuData(barrageCid,data)
    if self.barrageCid ~= barrageCid then
        return
    end

    for k,v in ipairs(data) do
        if v.dialogueId then
            if not self.danMudata[v.dialogueId] then
                print(v.dialogueId,type(v.dialogueId))
                self.danMudata[v.dialogueId] = {}
            end
            table.insert(self.danMudata[v.dialogueId],v)
        end
    end
    if not self.curDanmu and self.state ~= DanMuState.stop then
        self:startNextPageDanmu()
    end
end

function DatingDanMuView:registerEvents()

    EventMgr:addEventListener(self, EV_DATING_EVENT.updateDanMuData, handler(self.updateDanMuData, self))
    EventMgr:addEventListener(self, EV_DANMU_DISPACTH,handler(self.onRecvDanMuData,self))
    EventMgr:addEventListener(self, EV_DANMU_SEND, handler(self.insertWord, self))
    self.Button_upspeed:onClick(function()
        self:accelerationDanmu(5)
    end)
end

return DatingDanMuView