local tMESpine = {}
-- tMESpine.__index = tMESpine
-- setmetatable(tMESpine, EditLua)

function EditLua:createSpine(szId, tParams)
	print("createSpine")
	if targets[szId] ~= nil then
		return
	end
	if tParams.szFileName and tParams.szFileName ~= "" then
		path = tParams.szFileName
	end

	local objSpine = SkeletonAnimation:create("test/spine/pveBtnEffect")

	targets[szId] = objSpine
	targets[szId]._szSpinePath = path

	EditLua:addToParent(szId, tParams)

	targets[szId]:playByIndex(0, 1)

	function objSpine:getSize()
		local rect = self:boundingBox()
		local sx = self:getScaleX()
		local sy = self:getScaleY()

		local size = ccs(rect.size.width / math.abs(sx), rect.size.height / math.abs(sy))
		if size.width < 100 then size.width = 100 end
		if size.height < 100 then size.height = 100 end

		return size
	end

	function objSpine:getAnchorPoint()
		return ccp(0.5, 0)
	end

	function objSpine:hitTest(pos)
		local size = self:getSize()
		local ap = self:getAnchorPoint()

		local rect = ccr(-size.width * ap.x, -size.height * ap.y, size.width, size.height)
		pos = self:convertToNodeSpace(pos)
		return rect:containsPoint(pos)
	end

	szGlobleResult = "spineNames = " .. objSpine:getMovementNameStrings()
	szGlobleResult = szGlobleResult .. ",nX = " .. objSpine:getPosition().x
	szGlobleResult = szGlobleResult .. ",nY = " .. objSpine:getPosition().y
	szGlobleResult = szGlobleResult .. ",nWidth = " .. objSpine:getSize().width
	szGlobleResult = szGlobleResult .. ",nHeight = " .. objSpine:getSize().height
	setGlobleString(szGlobleResult)

	print("create success")
end


function tMESpine:setSpinePath(szId, tParams)
	if targets[szId] == nil then
		print("target is nil")
		return
	end
	if tParams.szPath == "" then
		tParams.szPath = "test/spine/pveBtnEffect"
	end
	if targets[szId]._szSpinePath == tParams.szPath then
		print("is same spine", tParams.szPath)
		return
	end

	print("setSpinePath", tParams.szPath)

	targets[szId]:setFile(tParams.szPath)

	szGlobleResult = "spineNames = " .. targets[szId]:getMovementNameStrings()
	szGlobleResult = szGlobleResult .. ",nX = " .. targets[szId]:getPosition().x
	szGlobleResult = szGlobleResult .. ",nY = " .. targets[szId]:getPosition().y
	setGlobleString(szGlobleResult)
	

	print("setSpinePath success", szNameStrings)
end

function tMESpine:playSpineByName(szId, tParams)
	print("play", tParams.szName)
	targets[szId]:stop()
	targets[szId]:clearTracks()
	if targets[szId] == nil then
		return
	end
	tParams.szName 	= tParams.szName or "default"
	
	TFFunction.call(targets[szId].play, targets[szId], tParams.szName, tParams.isLoop)
	targets[szId]:resume()
	print("play success", tParams.szName)
end

function tMESpine:stop(szId, tParams)
	print("tMESpine stop")
	targets[szId]:stop()
	targets[szId]:clearTracks()
	print("tMESpine stop success")
end

function tMESpine:playQueue(szId, tParams)
	print("tMESpine playQueue")
	targets[szId]:stop()
	targets[szId]:clearTracks()

	local animations = tParams.szNames
	local isLastLoop = tParams.isLoop
	local count = #animations
	for i = 1, count do		
		isLoop = (i == count) and isLastLoop 		
		targets[szId]:addAnimation(1, animations[i], isLoop)
		print("add animation:", animations[i])
	end
	targets[szId]:resume()
	print("tMESpine playQueue Success")
end

return tMESpine