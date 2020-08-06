local BaseDataMgr = import(".BaseDataMgr")
local NoticeDataMgr = class("NoticeDataMgr", BaseDataMgr)

function NoticeDataMgr:ctor()
    self:reset()
end

function NoticeDataMgr:init()

end

function NoticeDataMgr:reset()
    self.noticeData = nil
    self.noticeData = {active = {}, game = {}}
    self.noticeList = {}
end

function NoticeDataMgr:onLogin()
    TFDirector:addProto(s2c.NOTICE_GET_BILL_BOARD_NOTICE, self, self.onRespGetNotice)

    TFDirector:send(c2s.NOTICE_GET_BILLBOARD_NOTICE, {})
    return {s2c.NOTICE_GET_BILL_BOARD_NOTICE}
end

function NoticeDataMgr:onRespGetNotice(tData)
    self:reset()
    dump(tData.data.billBoardNotice, "onRespGetNotice")
    local data = tData.data.billBoardNotice or {}
    for i,v in ipairs(data) do
        table.insert(self.noticeList, clone(v))
        if v.type == 1 then--活动公告
            table.insert(self.noticeData.active, clone(v))
        elseif v.type == 2 then--游戏公告
            table.insert(self.noticeData.game, clone(v))
        end            
    end

    local function sortfunc(a,b)
		return a.index < b.index
	end
    table.sort(self.noticeList, sortfunc)
    table.sort(self.noticeData.active, sortfunc)
    table.sort(self.noticeData.game, sortfunc)
    -- EventMgr:dispatchEvent(EV_NOTICE_UPDATE)
end

function NoticeDataMgr:getNoticeDataByType(noticetype)
    local data = nil
    if noticetype == EC_NoticeType.ACTIVE then
        data = clone(self.noticeData.active)
    elseif noticetype == EC_NoticeType.GAME then
        data = clone(self.noticeData.game)
    end
    return data
end

function NoticeDataMgr:getNoticeDataList()
    return self.noticeList
end

function NoticeDataMgr:getNoticeCount()
    if self.noticeList then
        return #self.noticeList
    end
    return 0
end

return NoticeDataMgr:new()