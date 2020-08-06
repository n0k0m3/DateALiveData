local tMETextButton = {}
tMETextButton.__index = tMETextButton
setmetatable(tMETextButton, require("TFFramework.Editor.EditorBase.EditorBase_LoadTFButton"))

function EditLua:createTextButton(szId, tParams)
	print("createTextButton")
	if targets[szId] ~= nil then
		return
	end
	local createBtn = TFTextButton:create()
	createBtn:setTextureNormal("test/button/com_btn3_n.png")
	createBtn:setText("Text Button")
	createBtn:setFontSize(10)
	createBtn:setPosition(VisibleRect:center())
	-- tTouchEventManager:registerEvents(createBtn)
	targets[szId] = createBtn
	targets[szId]._useOutline = false
	targets[szId]._useShadow = false
	targets[szId]._outLineSize = 1
	targets[szId]._outLineColor = ccc3(0, 0, 0)
	targets[szId]._shadowSize = ccs(0, 0)
	targets[szId]._shadowColor = ccc3(0, 0, 0)
	
	EditLua:addToParent(szId, tParams)
	
	print("create success")
end



return tMETextButton