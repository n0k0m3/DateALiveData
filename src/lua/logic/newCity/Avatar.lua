local Avatar = class("Avatar")

function Avatar:ctor(obj,points)
	self.obj = obj
	self.points = points
end

function Avatar:registPosUpdate()
	self.obj:registPosCallback(handler(self.updatePoints,self))
end

function Avatar:updatePoints(pos)
	self.points = {me.pAdd(pos,me.p(-120,0)),me.pAdd(pos,me.p(120,0))}
end
return Avatar