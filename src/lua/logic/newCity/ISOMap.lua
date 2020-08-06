local ISOMap = class("ISOMap")

function ISOMap:ctor()
	self:clearMap()
	self.showZValue = false
end
function ISOMap:clearMap()
	self.objList = {}
end

function ISOMap:addObj(obj)
	self.objList[#self.objList + 1] = obj
end

function ISOMap:removeObj(obj)
	if #self.objList == 0 then
		return
	end
	for i = #self.objList,1,-1 do
		if self.objList[i] == obj then
			table.remove(self.objList,i)
		end
	end
end

function ISOMap:reorderObjs()
	if #self.objList < 2 then
		return
	end
	table.sort(self.objList,function(obja,objb)
		local minleftA
		local maxrightA
		for k,v in pairs(obja.points) do
			if minleftA == nil then
				minleftA = v
			end
			if maxrightA == nil then
				maxrightA = v
			end
			if v.x < minleftA.x then
				minleftA = v
			end
			if v.x > maxrightA.x then
				maxrightA = v
			end
		end
		local minleftB
		local maxrightB
		for k,v in pairs(objb.points) do
			if minleftB == nil then
				minleftB = v
			end
			if maxrightB == nil then
				maxrightB = v
			end
			if v.x < minleftB.x then
				minleftB = v
			end
			if v.x > maxrightB.x then
				maxrightB = v
			end
		end
		local unexchange = true
		if minleftB.x > maxrightA.x or minleftA.x > maxrightB.x then
			unexchange = (minleftA.y + maxrightA.y > minleftB.y + maxrightB.y)
		else
			local sx = {minleftA.x,maxrightA.x,minleftB.x,maxrightB.x}
			table.sort( sx, function(a,b)
				return a < b
			end)
			local intersection = {sx[2],sx[3]}
			local centerX = (intersection[2] + intersection[1])/2
			local centerAY = (maxrightA.y - minleftA.y)/(maxrightA.x - minleftA.x)*(centerX - minleftA.x) + minleftA.y
			local centerBY = (maxrightB.y - minleftB.y)/(maxrightB.x - minleftB.x)*(centerX - minleftB.x) + minleftB.y
			unexchange = centerAY > centerBY
		end
		--if unexchange == true then
		--	if obja.obj.mid and objb.obj.mid then
		--		unexchange = (obja.obj.mid < objb.obj.mid)
		--	end
		--end
		return unexchange
			
	end)
	for i,v in ipairs(self.objList) do
		v.obj:setZOrder(100+i)
		if self.showZValue then
			if v.obj:getChildByTag(9090) == nil then
				local tmlabel = TFLabel:create()
				tmlabel:setFontSize(20)
				tmlabel:setColor(ccc3(0,0,255))
				tmlabel:setPosition(me.p(0,10))
				v.obj:addChild(tmlabel,99,9090)
			end
			v.obj:getChildByTag(9090):setString(string.format("Z:%d",100+i))
		end
	end
end

return ISOMap