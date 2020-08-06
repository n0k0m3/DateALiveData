local BaseDataMgr = import(".BaseDataMgr")
local LoginWatingDataMgr = class("LoginWatingDataMgr", BaseDataMgr)

function LoginWatingDataMgr:ctor()
	self:init()
end

function LoginWatingDataMgr:init()

	self.isOpenWnd = false
end

function LoginWatingDataMgr:updateLoginWaiting(queue,queueTime)

	EventMgr:dispatchEvent(EV_FUNC_LOGINWAITING,queue,queueTime)
	if not self.isOpenWnd then
		Utils:openView("login.LoginWating",queue,queueTime)
		self.isOpenWnd = true
	end
end

function LoginWatingDataMgr:setOpenState(openState)
	self.isOpenWnd = openState
end

function LoginWatingDataMgr:closeLoginWaiting()	
	EventMgr:dispatchEvent(EV_FUNC_LOGINWAITING,0)
end

return LoginWatingDataMgr:new();
