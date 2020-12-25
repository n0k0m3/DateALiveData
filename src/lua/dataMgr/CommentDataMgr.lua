local BaseDataMgr = import(".BaseDataMgr")
local CommentDataMgr = class("CommentDataMgr", BaseDataMgr)

function CommentDataMgr:init()
	self.comments = {}
	TFDirector:addProto(s2c.COMMENT_RESP_COMMENT, self, self.recvCommentList)
	TFDirector:addProto(s2c.COMMENT_RESP_SINGLE_COMMENT, self, self.recvCommentResult) 
	TFDirector:addProto(s2c.COMMENT_RESP_PRISE, self, self.recvPriseResult) 
end

function CommentDataMgr:sendComment(msg)
    TFDirector:send(c2s.COMMENT_REQ_SINGLE_COMMENT, msg)
end

function CommentDataMgr:sendPrise(msg)
    TFDirector:send(c2s.COMMENT_REQ_PRISE, msg)
end

function CommentDataMgr:sendReqAllComments(msg)
	dump(msg)
	self.comments = {}
    TFDirector:send(c2s.COMMENT_REQ_COMMENT, msg)
end

function CommentDataMgr:recvCommentList(event)
	self.comments = event.data
	EventMgr:dispatchEvent(EV_COMMENT_GETCOMMENT, self.comments)
	
end

function CommentDataMgr:sendUp(msg)
	TFDirector:send(c2s.COMMENT_REQ_PRISE, msg)
end

function CommentDataMgr:recvCommentResult(event)
	local data = event.data
	if data.success then
		EventMgr:dispatchEvent(EV_COMMENT_COMMENTRESULT, {})
	end
end

function CommentDataMgr:recvPriseResult(event)
	local data = event.data
	if data.success then
		EventMgr:dispatchEvent(EV_COMMENT_PRISERESULT, {})
	end
end

function CommentDataMgr:getCommentList()
    return self.comments
end

return CommentDataMgr:new()