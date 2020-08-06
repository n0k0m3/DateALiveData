
local LoginWating = class("LoginWating", BaseLayer)

function LoginWating:ctor(waitnum,waittime)
    self.super.ctor(self,data)
    self.waitnum,self.waittime = waitnum,waittime
    self:init("lua.uiconfig.loginScene.loginWaiting")

    EventMgr:addEventListener(self, EV_FUNC_LOGINWAITING, handler(self.onUpdating, self))
end

function LoginWating:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	self.Label_tips 	= TFDirector:getChildByPath(ui,"Label_tips");
	self.Label_detail  	= TFDirector:getChildByPath(ui,"Label_detail");

	self.Label_tips:setTextById(223001)
	self.Label_detail:setTextById("r100001", self.waitnum, self.waittime)

end

function LoginWating:onUpdating(waitnum,waittime)

	if waitnum >0 then
		self.Label_detail:setTextById("r100001",waitnum,waittime)
	else
		LoginWatingDataMgr:setOpenState(false)
		AlertManager:close()
	end
end

return LoginWating
