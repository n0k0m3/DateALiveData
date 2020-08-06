
local BaseDataMgr = import(".BaseDataMgr")
local TeamPveDataMgr = class("TeamPveDataMgr", BaseDataMgr)

function TeamPveDataMgr:init()

    self.TrainDungeonCfg = TabDataMgr:getData("TrainDungeon")
    self.TrainDungeonLevelCfg = TabDataMgr:getData("TrainDungeonLevel")
    self.trainDungeonInfos = {}
    self:registerMsgEvent()
end

--注册服务器消息事件
function TeamPveDataMgr:registerMsgEvent()

    TFDirector:addProto(s2c.CHASM_RES_SPECIAL_TRAIN, self, self.onRecvResSpecialTrin)
    TFDirector:addProto(s2c.CHASM_RES_TRAIN_DUNGEON_INFO, self, self.onRecvResTrainDungeonInfo)

end

function TeamPveDataMgr:reset()
end

function TeamPveDataMgr:onLogin()
    TFDirector:send(c2s.CHASM_REQ_SPECIAL_TRAIN_INFO, {})
    TFDirector:send(c2s.CHASM_REQ_TRAIN_DUNGEON_INFO, {})
    return {s2c.CHASM_RES_SPECIAL_TRAIN,s2c.CHASM_RES_TRAIN_DUNGEON_INFO}
end

function TeamPveDataMgr:onEnterMain()

end

function TeamPveDataMgr:getTrainDungeonCfg(cid)

    if not cid then
        return self.TrainDungeonCfg
    end
    return self.TrainDungeonCfg[cid]
end

function TeamPveDataMgr:getTrainDungeonLevelCfg(levelCid)

    return self.TrainDungeonLevelCfg[levelCid]
end

function TeamPveDataMgr:openMainView()
    Utils:openView("teamPve.TeamPveMainView")
end

function TeamPveDataMgr:openLevelView(cid)
    Utils:openView("teamPve.TeamPveLevelView",cid)
end

function TeamPveDataMgr:specialIsOpen()
    return self.specialTrianOpen
end

function TeamPveDataMgr:getDeadLine()
    return self.deadLine
end

function TeamPveDataMgr:getTrainChapterInfo(cid)

    if not cid then
        return self.trainChapterInfos
    end
    return self.trainChapterInfos[cid]
end

function TeamPveDataMgr:onRecvResSpecialTrin(event)

    local data = event.data
    if not data then
        return
    end

    self.specialTrianOpen = data.isOpen
    self.deadLine = data.deadline
    self.trainChapterInfos = data.trainChapterInfos

    EventMgr:dispatchEvent(EV_TEAMPVE_UPDATE_INFO)

end

function TeamPveDataMgr:getTrainDungeonInfo(dungeonId)
    return self.trainDungeonInfos[dungeonId]
end

function TeamPveDataMgr:onRecvResTrainDungeonInfo(event)

    local data = event.data
    if not data then
        return
    end

    self.trainDungeonInfos = {}
    local trainLevelInfos = data.trainDungeonInfos
    if trainLevelInfos then
        for k,v in ipairs(trainLevelInfos) do
            self.trainDungeonInfos[v.dungeonId] = v
        end
    end
    -- dump(trainLevelInfos)
    EventMgr:dispatchEvent(EV_TEAMPVE_LEVEL_INFO)
end

return TeamPveDataMgr:new()
