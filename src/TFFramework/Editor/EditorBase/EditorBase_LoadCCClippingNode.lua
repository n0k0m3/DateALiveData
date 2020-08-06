
local tClippingNode = {}

function EditLua:createClippingNode(szId, tParams)
    print("createClippingNode:", tParams)
	
	local texture = "test/blocks.png"
	local img = TFImage:create(texture)
	img:setPosition(ccp(50, 50))

    local node = CCClippingNode:create(img)

	node:setSize(ccs(100, 100))
	node:setAnchorPoint(ccp(0.5, 0.5))
	node:setAlphaThreshold(0.01)

	node.clip = img

    targets[szId] = node
    
    EditLua:addToParent(szId, tParams)
    print("createClippingNode success")
end


function EditLua:setStencilPath(szId, tParams)
	print("setStencilPath")
	if not tolua.isnull(targets[szId].clip) then 
		targets[szId].clip:setTexture(tParams.stencilPath)
	end
	print("setStencilPath success")
end

function EditLua:setAlphaThreshold(szId, tParams)
	print("setAlphaThreshold:", tParams)
	if not tolua.isnull(targets[szId]) then 
		targets[szId]:setAlphaThreshold(tParams.alphaThreshold)
	end
	print("setAlphaThreshold success")
end

function EditLua:setRevertAlpha(szId, tParams)
	print("setRevertAlpha:", tParams)
	if not tolua.isnull(targets[szId]) then 
		targets[szId]:setInverted(tParams.revertAlpha == "True")
	end
	print("setRevertAlpha success")
end

function EditLua:setClipNodeRotate(szId, tParams)
	print("setClipNodeRotate:", tParams)
	if not tolua.isnull(targets[szId].clip) then 
		targets[szId].clip:setRotation(tParams.clipNodeRotate)
	end
	print("setClipNodeRotate success")
end

function EditLua:setClipNodeScaleX(szId, tParams)
	print("setClipNodeScaleX:", tParams)
	if not tolua.isnull(targets[szId].clip) then 
		targets[szId].clip:setScaleX(tParams.clipNodeScaleX)
	end
	print("setClipNodeScaleX success")
end

function EditLua:setClipNodeScaleY(szId, tParams)
	print("setClipNodeScaleY:", tParams)
	if not tolua.isnull(targets[szId].clip) then 
		targets[szId].clip:setScaleY(tParams.clipNodeScaleY)
	end
	print("setClipNodeScaleY success")
end

function EditLua:setClipNodeX(szId, tParams)
	print("setClipNodeX:", tParams)
	if not tolua.isnull(targets[szId].clip) then 
		targets[szId].clip:setPositionX(tParams.clipNodeX)
	end
	print("setClipNodeX success")
end

function EditLua:setClipNodeY(szId, tParams)
	print("setClipNodeY:", tParams)
	if not tolua.isnull(targets[szId].clip) then 
		targets[szId].clip:setPositionY(tParams.clipNodeY)
	end
	print("setClipNodeY success")
end

return tClippingNode