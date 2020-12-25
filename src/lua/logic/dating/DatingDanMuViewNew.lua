
local DatingDanMuViewNew = class("DatingDanMuViewNew", BaseLayer)

function DatingDanMuViewNew:initData(barrageCid)

    self.danMudata = {}
    self.barrageCid = barrageCid

    self.perNum = 3

    self.danmuCfg = TabDataMgr:getData("Bulletscreencontrol")
    self.danmuPool = {}

    self.speed = {}
    for k,v in ipairs(self.danmuCfg) do
        self.speed[k] = {base = v.speed, up = v.addSpeed}
        --self.speed[k] = {base = 4, up = v.addSpeed}
    end
    --v
    self.mul = 0

    self.lineSpace = 15
    self.waitSpace = 100

    self.pageIds = {}

    self.danmuShowID = 0;    ---弹幕展示ID

    self.panel_world_ = {}

    self.recvFlag = false    ---收到弹幕消息才开始移动弹幕，避免第一个剧本被误伤
    self.state = true

end

function DatingDanMuViewNew:ctor(barrageCid)
    self.super.ctor(self)
    self:initData(barrageCid)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dating.datingDanMuView")
end

function DatingDanMuViewNew:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_Area = TFDirector:getChildByPath(self.Panel_root, "Panel_Area")
    local h = self.Panel_Area:getContentSize().height
    self.size = CCSize(GameConfig.WS.width,h)
    self.Panel_Area:setSize(self.size)

    self.Button_upspeed = TFDirector:getChildByPath(self.Panel_root, "Button_upspeed")

    self.Panel_word = TFDirector:getChildByPath(self.Panel_root, "Panel_word")

    DanmuDataMgr:resetDatingIndex(self.barrageCid)
    self:timeOut(function()
        --DanmuDataMgr:getTestDanmu()
        DanmuDataMgr:getDanmu(self.barrageCid)
    end)

end

---itemData: 约会的itemData
function DatingDanMuViewNew:updateDanMuData(itemData)
    self.dialogueId = itemData.id
    print(self.dialogueId)
    table.insert(self.pageIds,itemData.id)
end

function DatingDanMuViewNew:onRecvDanMuData(barrageCid,data)

    if self.barrageCid ~= barrageCid then
        return
    end

    self.recvFlag = true

    for k,v in ipairs(clone(data)) do
        if v.dialogueId then
            if not self.danMudata[v.dialogueId] then
                self.danMudata[v.dialogueId] = {}
            end
            --v.content = v.content.."-"..v.dialogueId
            --v.type = 1
            table.insert(self.danMudata[v.dialogueId],v)
        end
    end
end

function DatingDanMuViewNew:getCloneItem(lineId)

    if not self.danmuPool then
        return
    end

    local item = self.danmuPool[1]
    if not item then
        return
    end

    table.remove(self.danmuPool,1)

    return item
end

function DatingDanMuViewNew:insertClonePool(item)
    item:stopAllActions()
    table.insert(self.danmuPool,item)
end

function DatingDanMuViewNew:createDanmu(lineId,data)

    local cfg = self.danmuCfg[lineId]
    if not cfg then
        return
    end

    local Panel_word = self:getCloneItem(lineId)
    if not Panel_word then
        Panel_word = self.Panel_word:clone()
        self.Panel_Area:addChild(Panel_word)
        self.cloneNum = self.cloneNum or 0
        if not self.cloneNum then
            self.cloneNum = 0
        end
        self.cloneNum = self.cloneNum + 1
    end

    local Label_word = Panel_word:getChildByName("Label_word")
    local Image_out = Panel_word:getChildByName("Image_out")
    Label_word:setFontName(cfg.name)
    Label_word:setFontSize(cfg.fontSize)
    Label_word:setOpacity(cfg.transparency*255)

    Label_word:setText(data.content)
    local size = Label_word:getContentSize()
    Panel_word:setContentSize(size)
    Panel_word.w = size.width + 10
    Label_word:setPosition(ccp(size.width/2,-size.height/2))
    Image_out:setContentSize(CCSizeMake(size.width+10,size.height+4))
    Image_out:setVisible(data.type == 1)
    Image_out:setPosition(ccp(size.width/2,-size.height/2))

    local color = data.type == 1 and ccc3(249,219,71) or ccc3(246,254,255)
    Label_word:setColor(color)
    local outLineColor = data.type == 1 and ccc4(89,64,21,255) or ccc4(48,53,74,255)
    Label_word:enableOutline(outLineColor,2)

    local posX = self.size.width/2+5
    local posY = self.size.height/2 - (lineId - 1)*(cfg.fontSize+self.lineSpace)

    local srcPos = ccp(posX,posY)
    Panel_word:setPosition(srcPos)

    return Panel_word
end

function DatingDanMuViewNew:getDanMuData()
    local dialogueId = self.pageIds[1]
    if not self.danMudata[dialogueId] then
        table.remove(self.pageIds,1)
        DanmuDataMgr:getDanmu(self.barrageCid)
        return
    end
    local data = self.danMudata[dialogueId][1]
    table.remove(self.danMudata[dialogueId],1)
    if #self.danMudata[dialogueId] == 0 then
        local index = table.indexOf(self.pageIds,dialogueId)
        if index ~= -1 then
            table.remove(self.pageIds,index)
        end
        self.danMudata[dialogueId] = nil
    end

    return data
end

function DatingDanMuViewNew:checkGetNewDanmuData()

    local cnt = 0
    for k, v in pairs(self.danMudata) do
        cnt = cnt + #v
    end

    if cnt <= 10 then
        DanmuDataMgr:getDanmu(self.barrageCid)
        --DanmuDataMgr:addTestDanmu()
    end
end

function DatingDanMuViewNew:loadDanMu()

    local nextShowId = self.danmuShowID + 1

    ----计算显示的行数
    local lineId = math.ceil(nextShowId/self.perNum) % self.perNum
    lineId = lineId == 0 and self.perNum or lineId

    ---计算该行上一个弹幕的位置
    local canGo = true
    if self.panel_world_[lineId] then
        local lastPanel = self.panel_world_[lineId][#self.panel_world_[lineId]]
        if lastPanel then
            local posX = lastPanel:getPositionX()
            canGo = (posX + lastPanel.w + self.waitSpace) <= self.size.width/2
        end
    end

    if not canGo then
        return
    end

    --self:checkGetNewDanmuData()

    local data
    if self.sendDanmu then
        data = clone(self.sendDanmu)
        self.sendDanmu = nil
    else
        data = self:getDanMuData()
    end

    if not data then
        return
    end

    self.danmuShowID = nextShowId

    local Panel_word = self:createDanmu(lineId,data)
    if not self.panel_world_[lineId] then
        self.panel_world_[lineId] = {}
    end
    table.insert(self.panel_world_[lineId],Panel_word)

end

function DatingDanMuViewNew:moveDanMu()
    for line,v in pairs(self.panel_world_) do
        for i=#v,1,-1 do
            local p = v[i]
            local posX = p:getPositionX()
            if posX + p.w <= -self.size.width/2 then
                self:insertClonePool(p)
                table.remove(v,i)
            else
                p:setPositionX(posX - (self.speed[line].base + self.speed[line].up*self.mul))
            end
        end
    end
end

function DatingDanMuViewNew:update()

    if not self.recvFlag then
        return
    end

    if not self.state then
        return
    end

    self:loadDanMu()
    self:moveDanMu()
end

function DatingDanMuViewNew:accelerationDanmu(mul)
    self.mul = mul
end

function DatingDanMuViewNew:jumpDanMu()
    for i=#self.pageIds,1,-1 do
        if i~= #self.pageIds then
            table.remove(self.pageIds,i)
        end
    end
    self.state = true
end

---停止所有弹幕
function DatingDanMuViewNew:stopAllDanum()
    self.state = false
end

function DatingDanMuViewNew:onRecvSendDanMu(data)
    self.sendDanmu = data
    self.recvFlag = true
end

function DatingDanMuViewNew:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
end

function DatingDanMuViewNew:registerEvents()

    EventMgr:addEventListener(self, EV_DATING_EVENT.updateDanMuData, handler(self.updateDanMuData, self))
    EventMgr:addEventListener(self, EV_DANMU_DISPACTH,handler(self.onRecvDanMuData,self))
    EventMgr:addEventListener(self, EV_DANMU_SEND, handler(self.onRecvSendDanMu, self))

    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
end

return DatingDanMuViewNew