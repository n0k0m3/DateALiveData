local KabalaTreeCleanTask = class("KabalaTreeCleanTask", BaseLayer)

function KabalaTreeCleanTask:ctor(openWorldId)
    self.super.ctor(self)
    self:initData(openWorldId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeCleanTask")
end

function KabalaTreeCleanTask:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function KabalaTreeCleanTask:initData(openWorldId)

    --openWorldId 表示玩家所在di(或许以后会有两个同时开的情况需要修改)
    self.openWorldId = openWorldId
    self.KabalaWorldCfg = TabDataMgr:getData("KabalaWorld")
end

function KabalaTreeCleanTask:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.title_award = TFDirector:getChildByPath(self.ui, "title_award")
    self.title_effect = TFDirector:getChildByPath(self.ui, "title_effect")
    self.Label_taskName = TFDirector:getChildByPath(self.ui, "Label_taskName")
    self.Label_taskinfo = TFDirector:getChildByPath(self.ui, "Label_taskinfo")
    self.Panel_award = TFDirector:getChildByPath(self.ui, "Panel_award")
    self.Label_taskdesc = TFDirector:getChildByPath(self.ui, "Label_taskdesc")
    self.Label_taskinfoName = TFDirector:getChildByPath(self.ui, "Label_taskinfoName") 
    self:initUiInfo()
end

function KabalaTreeCleanTask:initUiInfo()

    self.Label_title:setTextById(3004003)
    self.title_award:setTextById(3004027)
    self.title_effect:setTextById(3004028)

    local worldCfg = self.KabalaWorldCfg[self.openWorldId]
    if not worldCfg then
        return
    end

    --质点世界名
    local worldNameStr = TextDataMgr:getText(worldCfg.worldName)
    self.Label_taskName:setTextById("r110001",worldNameStr)
    
    --任务内容
    self.Label_taskinfoName:setTextById(3004015)
    self.Label_taskinfo:setTextById(worldCfg.missionDescription)

    --任务描述 110001
    self.Label_taskdesc:setTextById(worldCfg.worldBackground)

    local awardTab = worldCfg.itemShow
    local itemCnt = 0
    for k,v in pairs(awardTab) do      
        local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(item, v)
        item:setAnchorPoint(me.p(0.5,0.5))
        item:setScale(0.65)
        itemCnt = itemCnt + 1
        item:setName("item"..itemCnt)
        self.Panel_award:addChild(item)
    end

    local evenNumber = itemCnt%2
    local leftNumber = math.floor(itemCnt/2)
    local dis = 100
    local firstPosX = 0
    if evenNumber == 0 then
        firstPosX = -dis*(leftNumber-1)-dis/2
    else
        firstPosX = -dis*leftNumber
    end

    for i=1,itemCnt do
        local item = self.Panel_award:getChildByName("item"..i)
        if item then
            item:setPosition(ccp(firstPosX+(i-1)*dis,0))
        end
    end
end




return KabalaTreeCleanTask