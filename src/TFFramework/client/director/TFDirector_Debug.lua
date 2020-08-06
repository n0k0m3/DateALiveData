--
-- Author: MiYu
-- Date: 2014-02-08 10:33:13
--
local moduleName 			= ...

function TFDirector:description(...)

	-- debug params
	TFDirector.bIsShowDebugInfo 		= nil
	TFDirector.bShowLuaMemmory			= nil
	TFDirector.bShowProfile				= nil	
	TFDirector.bShowLog					= nil
	TFDirector.testDebuger 				= nil
	TFDirector.tLuaProfile 				= nil

	-- debug functions
	TFDirector:initDebugEnv()
	TFDirector:initLUAProfile()
	TFDirector:hook()
	TFDirector:getName()
	TFDirector:showProfile(bVisible)
	TFDirector:showLuaMemmory(bVisible)
end

function TFDirector:initDebugEnv()
	print('TFDirector:initDebugEnv()')
	import(".TFDirector_KeyHook", moduleName)

	self.objKeyHookNode = TFPanel:create()
	self.objKeyHookNode:setTag(9527)
	me.Director:getNotificationNode():addChild(self.objKeyHookNode)
	self.objKeyHookNode:setKeyboardEnabled(true)

	self.objKeyHookNode:addMEListener(TFWIDGET_KEYUP, TFDirector.onKeyUpFunc)
	self.objKeyHookNode:addMEListener(TFWIDGET_KEYDOWN, TFDirector.onKeyDownFunc)

	TFDirector:registerKeyDown(123, {nGap = 500}, function() -- 'F12'
		if not TFDirector.EditorModel then
			TFDirector.bShowLuaMemmory = not TFDirector.bShowLuaMemmory
			TFDirector:showLuaMemmory(TFDirector.bShowLuaMemmory)
		end
	end)

--[[
	TFDirector:registerKeyDown(me.keys['BACK_SPACE'], {nGap = 500}, function() -- 'back'
		print("press BACK_SPACE")
	end)

	TFDirector:registerKeyDown(me.keys['TFNU'], {nGap = 500}, function() -- 'menu'
		print("press TFNU")
	end)
]]

	TFDirector:registerKeyDown(122, {nGap = 500}, function() -- 'F11'
		if not TFDirector.EditorModel then
			TFDirector.bShowProfile = not TFDirector.bShowProfile
			TFDirector:showProfile(TFDirector.bShowProfile)
		end
	end)

	TFDirector:registerKeyDown(120, {nGap = 500}, function() -- 'F9'
		if not TFDirector.EditorModel then
			if TFClientNet then
				TFClientNet:SetNetLogEnable(not TFClientNet.bShowLog)
				TFClientNet.bShowLog = not TFClientNet.bShowLog
			end
		end
	end)
	
	TFDirector:registerKeyDown(118, {nGap = 500}, function() -- 'F7'
		if not TFDirector.EditorModel then
			-- 关闭游戏网络连接
			TFDirector:dispatchGlobalEventWith("Engine_Will_Restart", {})
			restartLuaEngine("");
		end
	end)

	-- TFDirector:registerKeyUp(82, {bEnableCtrl = true, nGap = 500}, function() -- 'ctrl+r'
	-- 	TFDirector:closeSocket()
	-- 	TFResolution:setResolutionRect(1300, 780, 1300, 780)
	-- 	TFDirector:changeScene("LuaScript.scene.entry.EntryScene")
	-- end)

	TFDirector:registerKeyDown(110, {nGap = 500}, function() -- '.'
		TFDirector.bShowKey = not TFDirector.bShowKey 
	end)

	TFDirector:registerKeyDown(116, {nGap = 500}, function() -- 'F5'
		if TFDirector.EditorModel then
			--TFDirector.bIsEditorDebug = not TFDirector.bIsEditorDebug
			if TFDirector.bIsEditorDebug then
				print("------------------------------------- open debug model ---------------------------------------")
			else
				print("------------------------------------- close debug model ---------------------------------------")
			end
			return 
		end
		local szFileName = "debugScript.lua"
		local szFullFilePath = me.FileUtils:fullPathForFilename(szFileName)
		if szFullFilePath ~= szFileName then
			dofile(szFullFilePath)
		end
	end)

	TFDirector:initLUAProfile()
end

function TFDirector:purgeDebug()
	TFDirector:removeTimer(self.nDebugUpdateTID)
	TFDirector:removeTimer(self.nDebugFrameTID)
	TFDirector:pause()

	me.Director:getNotificationNode():removeChildByTag(9527, true)
	me.Director:getNotificationNode():removeChildByTag(95272, true)
	
    self:clearRetainObjs()
end

function TFDirector:printSceneTree(scene)
	scene = scene or TFDirector:currentScene()
	if scene then
		local nIndex = 1
		objTreeDict = {}
		print("================================================================")
		print("")
		print("scene:", scene:getName())
		local function travelNode(node, tb)
			if not node.getChildren then
				debug.setmetatable(node, CCNode)
			end
			local children = node:getChildren()
			if children then 
				local len = children:count()
				for i = 0, len - 1 do
					local obj = children:objectAtIndex(i)
					if type(obj) == 'userdata' and obj.getName then
						if obj:getDescription() == "TFPanel" then 
							local bbb = obj:isClippingEnabled()
							print(tb .. '├┄┄' .. obj:getName() .. '(' .. tolua.type(obj) .. ')' .. (obj:isVisible() and '+' or '-') .. '  [' .. nIndex .. ']' .. tostring(bbb))
						else 
							print(tb .. '├┄┄' .. obj:getName() .. '(' .. tolua.type(obj) .. ')' .. (obj:isVisible() and '+' or '-') .. '  [' .. nIndex .. ']')
						end
						objTreeDict[nIndex] = obj
						nIndex = nIndex + 1
						if obj.getChildren and obj:getChildren() and obj:getChildren():count() > 0 then
							travelNode(obj, tb .. '    ')
						end
					end
				end
			end
		end
		travelNode(scene, "")
		print("")
		print("Please Use : local obj = objTreeDict[nIndex] to oprand Object.")
		print("================================================================")
	end
end

local local_clock = function()
	-- return GetCpuCount()
	return TFLuaTime:clock()
end

function TFDirector:initLUAProfile()
	TFDirector.tLuaProfile = TFDirector.tLuaProfile or {}
	local tProfile = TFDirector.tLuaProfile
	tProfile.tCounters = {}
        tProfile.tTimers = {}
	tProfile.tNames = {}

	local kickFilter = {}
    local kickFilter2 = {
        print = 1,
        writeToDebugerLayer = 1,
        addTimer = 1,
        call = 1,
        execute = 1,
        pop = 1,
        iterator = 1,
        __index = 1,
        update = 1,
        ["(for generator)"] = 1,
        sendCompMessage = 1,
        onComplete = 1,
        nilCheck = 1,
        applyNormalScaleBtn = 1,
        handler = 1,
        getChild = 1,
        __newindex = 1,
        initControl = 1,
        new = 1,
        extends = 1,
        reorganizeData = 1,
        name = 1,
        UIEditorData = 1,
        tag = 1,
        touchAble = 1,
        Scale = 1,
        rotation = 1,
        visible = 1,
        ZOrder = 1,
        opacity = 1, 
        HitType = 1,
        BlendFunc = 1,
        Size = 1,
        setLayoutByTable = 1,
        UILayout = 1,
        ColorMixing = 1,
        Script = 1,
        anchorPoint = 1,
        passDataBase = 1,
        passButtonData = 1,
        passIconLabelData = 1,
        passCheckBoxData = 1,
        passImageData = 1,
        passPanelData = 1,
        passTextDataBase = 1,

        initBaseControl = 1,
        initChild = 1,
        --generateAction = 1,
        initMEImage = 1,
        initMEColorProps = 1,
        initMEImage_NEWMEEDITOR = 1,
        initAction = 1,
        createUIByLua = 1,
        --create = 1,

    }
	function TFDirector.hook(tp)
        if tp == 'call' then
		    local func = debug.getinfo(2, 'f').func
		    if tProfile.tNames[func] == nil then
			    tProfile.tNames[func] = debug.getinfo(2, 'Sn')
			    local szName = TFDirector.getName(func)
			    if not szName then return end
			    tProfile.tCounters[szName] = 1
                tProfile.tTimers[szName] = {0, local_clock()}
		    else
			    local szName, name = TFDirector.getName(func)
			    if not szName then return end
			    tProfile.tCounters[szName] = tProfile.tCounters[szName] + 1
                if not kickFilter[name] then 
                    tProfile.tTimers[szName][2] = local_clock()
                end
		    end
        elseif tp == "return" or tp == "tail return" then
		    local func = debug.getinfo(2, 'f').func
			local szName, name = TFDirector.getName(func)
			if not szName then return end
			tProfile.tCounters[szName] = tProfile.tCounters[szName] + 1
            if not kickFilter[name] then 
                tProfile.tTimers[szName][1] = (tProfile.tTimers[szName][1] + local_clock() - tProfile.tTimers[szName][2])-- / 2
                --print(szName, tProfile.tTimers[szName][1])
            end
        end
	end

	function TFDirector.getName(func)
		local tInfo = TFDirector.tLuaProfile.tNames[func]
        	if not tInfo then return end
		if tInfo and tInfo.what == 'C' then
			return tInfo.name
		end
		local szLoc = string.format("[%s:%s]", tInfo.short_src, tInfo.linedefined)
		if tInfo.namewhat ~= '' then 
			return string.format("%s(%s)", szLoc, tInfo.name), tInfo.name
		else
			--return string.format('%s', szLoc)
		end
	end
end

function TFDirector:showProfile(bVisible)
	if bVisible then
		print("=============Start show Profile=============", TFDirector.hook)
		debug.sethook(TFDirector.hook, 'cr')
		TFDirector.tLuaProfile.nShowTid = TFDirector.tLuaProfile.nShowTid or TFDirector:addTimer(10000, -1, nil, function ( ... )
			local tInfos = {}
			for k, v in pairs(TFDirector.tLuaProfile.tTimers) do
				tInfos[#tInfos + 1] = {key = k, val = v[1]}
			end
			table.sort(tInfos, function (a, b)
				return a.val > b.val
			end)

			local out = "\n==============================================================" .. #tInfos .. "\n"
			for k, v in pairs(tInfos) do
				if v.val >= 0.001 then 
                    out = out .. v.key .. " => " .. v.val .. ' [' .. TFDirector.tLuaProfile.tCounters[v.key] .. ']\n'
                end
			end
			out = out .. "==============================================================\n"
            print(out)
            
            do return end
			local tInfos = {}
			for k, v in pairs(TFDirector.tLuaProfile.tCounters) do
				tInfos[#tInfos + 1] = {key = k, val = v}
			end
			table.sort(tInfos, function (a, b)
				return a.val > b.val
			end)
			for k, v in pairs(tInfos) do
                local tm = TFDirector.tLuaProfile.tTimers[k] or {-1}
				print(v.key, ':', v.val, tm[1])
			end
		end)
		TFDirector:startTimer(TFDirector.tLuaProfile.nShowTid)
	else
		print("==============Stop show Profile=============")
		debug.sethook()
		TFDirector:stopTimer(TFDirector.tLuaProfile.nShowTid)
	end
end

function TFDirector:showLuaMemmory(bVisible)
	if bVisible then
		print("=============Start show LUA Memmory=============")
		TFDirector.nSlmTid1 = TFDirector.nSlmTid1 or TFDirector:addTimer(2000, -1, nil, function ( ... )
			print('[Memory] ', collectgarbage("count"), '\t\tat time:(' .. tostring(os.clock()) .. ')')
		end)
		TFDirector.nSlmTid2 = TFDirector.nSlmTid2 or TFDirector:addTimer(10000, -1, nil, function ( ... )
			collectgarbage("collect")
		end)

		TFDirector:startTimer(TFDirector.nSlmTid1)
		TFDirector:startTimer(TFDirector.nSlmTid2)
	else
		print("=============Stop show LUA Memmory=============")
		TFDirector:stopTimer(TFDirector.nSlmTid1)
		TFDirector:stopTimer(TFDirector.nSlmTid2)
	end
end

local function createDebugUI(panel)
	local SwitchNode = class('SwitchNode', function(size) return TFPanel:create({backColor=ccc3(0, 0, 0), size = size}) end)
	function SwitchNode:ctor(size, callback, isOn)
		self:setBackGroundColorOpacity(50)

		local onLabel = TFLabel:create()
		onLabel:setString('ON')
		onLabel:setPosition(ccp(size.width / 4, size.height / 2))
		self:addChild(onLabel, 1)

		local offLabel = TFLabel:create()
		offLabel:setString('OFF')
		offLabel:setPosition(ccp(size.width / 4 * 3, size.height / 2))
		self:addChild(offLabel, 1)

		size.width = size.width / 2
		self.block = TFPanel:create({backColor=ccc3(0, 255, 255), size = size})
		self.block:setOpacity(160)
		self:addChild(self.block)
		self:setTouchEnabled(true)

		self.isOn = (isOn ~= false)
		self.curState = self.isOn
		self.canTouch = true
		self:addMEListener(TFWIDGET_CLICK, function(sender)
			if self.canTouch then 
				self.canTouch = false
				self:changeState()
			end
		end)
		if not self.isOn then 
			self.block:setPosition(ccp(size.width, 0))
		end
		self.callback = callback
		if self.callback then self.callback(self.isOn) end
	end

	function SwitchNode:work()
		if self.curState ~= self.isOn then 
			self.curState = self.isOn
			local seek = self:getSize().width / 2
			local xBy = 0
			if self.isOn then 
				xBy = -seek
			else 
				xBy = seek
			end
			local tween = {
				target = self.block,
				{
					duration = 0.25,
					xBy = xBy,
					yBy = 0,
				},
				onComplete = function()
					self.canTouch = true
				end
			}
			TFDirector:toTween(tween)
			if self.callback then self.callback(self.isOn) end
		end
	end

	function SwitchNode:changeState()
		self.isOn = not self.isOn
		self:work()
	end

	function SwitchNode:on()
		self.isOn = true
		self:work()
	end

	function SwitchNode:off()
		self.isOn = false
		self:work()
	end

	local nWidth = 0

	local isWriteFile = CCLog_isDebugFileEnabled() == 1 or CCLog_isDebugFileEnabled() == 3
	local txtSwitch = SwitchNode:new(ccs(70, 25), function (isOn)
		if isOn then 
			CCLog_setDebugFileEnabled(1) 
			print("Open write log in file.")
		else 
			CCLog_setDebugFileDisabled(1)
			print("Close write log in file.")
		end
	end, isWriteFile)
	local txtLabel = TFLabel:create()
	txtLabel:setString("文件写入:")
	txtLabel:setAnchorPoint(ccp(0, 0))
	txtLabel:addChild(txtSwitch)
	txtSwitch:setPosition(ccp(txtLabel:getSize().width + 2, -4))
	panel:addChild(txtLabel, 2)
	txtLabel:setPosition(ccp(nWidth + 5, 8))
	nWidth = nWidth + txtLabel:getSize().width + txtSwitch:getSize().width + 5

	local isWriteNSLog = CCLog_isDebugFileEnabled() == 2 or CCLog_isDebugFileEnabled() == 3
	local NSSwitch = SwitchNode:new(ccs(70, 25), function (isOn)
		if isOn then 
			CCLog_setDebugFileEnabled(2) 
			print("Open write log in NSLog.")
		else 
			CCLog_setDebugFileDisabled(2)
			print("Close write log in NSLog.")
		end
	end, isWriteNSLog)
	local nsLabel = TFLabel:create()
	nsLabel:setString("NSLog:")
	nsLabel:setAnchorPoint(ccp(0, 0))
	nsLabel:addChild(NSSwitch)
	NSSwitch:setPosition(ccp(nsLabel:getSize().width + 2, -4))
	panel:addChild(nsLabel, 2)
	nsLabel:setPosition(ccp(nWidth + 5, 8))
	nWidth = nWidth + nsLabel:getSize().width + NSSwitch:getSize().width + 5

	local netSwitch = SwitchNode:new(ccs(70, 25), function (isOn)
		if isOn then 
			TFDirector:getNetWork():SetNetLogEnable(true)
			print("Open log for Network.")
		else 
			TFDirector:getNetWork():SetNetLogEnable(false)
			print("Close log for Network.")
		end
	end, false)
	local netLabel = TFLabel:create()
	netLabel:setString("NetLog:")
	netLabel:setAnchorPoint(ccp(0, 0))
	netLabel:addChild(netSwitch)
	netSwitch:setPosition(ccp(netLabel:getSize().width + 2, -4))
	panel:addChild(netLabel, 2)
	netLabel:setPosition(ccp(nWidth + 5, 8))
end


local oldMap,newMap
local showNew = false
local is_close_debugLayer = true
function TFDirector:createDebugerLayer(objScene)
	if self.testDebuger then
	else
        print("Debug Panel inited...")
		local nFPS = 0
		local testDebuger = {}
		self.testDebuger = testDebuger
		testDebuger.debugPanel = TFDirector:createMEModule("TFFramework.res.uiConfig.Debug")
		testDebuger.debugPanel:setVisible(false)
		-- createDebugUI(testDebuger.debugPanel)

		local function __open()
			testDebuger.debugPanel:setVisible(true)
			me.Director:setDebugModel(1)
			TFDirector:startTimer(self.nDebugFrameTID)
			TFDirector:startTimer(self.nDebugUpdateTID)
			CCTextureCache:getInstance():dumpCachedTextureInfo()
		end

		local function __close()
			if is_close_debugLayer then
				testDebuger.debugPanel:setVisible(false)
				me.Director:setDebugModel(0)
				TFDirector:stopTimer(self.nDebugFrameTID)
				TFDirector:stopTimer(self.nDebugUpdateTID)
				return
			end
			


			-- todo
			newMap = me.TextureCache:getTexturesMap()
			local nLen = newMap:size()
			local keys = newMap:keys()

			echo("坑爹的内存泄漏,一共多少图片占坑：",nLen)
			for i = 0, nLen - 1 do 
				local name = keys:at(i)
				local img_name = name:getCString()
				local tex = newMap:objectForKey(img_name)
				local bpp = tex:bitsPerPixelForFormat()
        		local bytes = tex:getPixelsWide() * tex:getPixelsHigh() * bpp / 8 / 1024
        	  
        		local use_count = tex:retainCount()
        		if use_count > 1 then 
        			local index = string.find(img_name,"Resource")
        			index = index  or 1
        			if index ~= 1 then index = index + 9 end
        			local shortName = string.sub(img_name,index)
        			echo("使用:"..shortName,use_count, string.format("%.3f", bytes/1024))	
        		else
        			-- echo("缓存中的资源：",img_name, use_count, bytes/1024)	
        		end

			end


			for i = 0, nLen - 1 do 
				local name = keys:at(i)
				local img_name = name:getCString()
				local tex = newMap:objectForKey(img_name)
				local bpp = tex:bitsPerPixelForFormat()
        		local bytes = tex:getPixelsWide() * tex:getPixelsHigh() * bpp / 8 / 1024
        	        	
        		local use_count = tex:retainCount()
        		if use_count > 1 then 
        			-- echo("使用中的资源：",img_name,use_count, bytes/1024)	
        		else
        			local index = string.find(img_name,"Resource")
        			index = index  or 1
        			if index ~= 1 then index = index + 9 end
        			local shortName = string.sub(img_name,index)
        			echo("缓存:"..shortName,use_count, string.format("%.3f", bytes/1024))	
        		end

			end

			if oldMap and showNew then
				echo("新增资源" )

				local old_nLen = #oldMap
				-- local old_keys = oldMap:keys()
				echo("旧资源old_nLen：",old_nLen)
				echo("新资源nLen：",nLen)
				-- echo(oldMap)
				local newCount = 0
				for i = 0, nLen - 1 do
					local name = keys:at(i)
					local isNewName = true
					--遍历就的资源map
					for j = 1, old_nLen do
							local old_name = oldMap[j]


							if old_name == name:getCString() then
								isNewName = false
							end
					end


					local img_name = name:getCString()
					local tex = newMap:objectForKey(img_name)

					if isNewName then 	--判定是否是新增name
						newCount = newCount + 1
						local bpp = tex:bitsPerPixelForFormat()
		        		local bytes = tex:getPixelsWide() * tex:getPixelsHigh() * bpp / 8 / 1024
		        	        	
		        		local use_count = tex:retainCount()

		        		local index = string.find(img_name,"Resource")
		        		index = index  or 1
		        		if index ~= 1 then index = index + 9 end
		        		local shortName = string.sub(img_name,index)
		        		if use_count > 1 then 
		        			echo("使用:"..shortName,use_count, string.format("%.3f", bytes/1024))	
		        		else
		        			echo("缓存:"..shortName,use_count, string.format("%.3f", bytes/1024))	
		        		end
					end
				end
				echo("新增资源 end", newCount)

			end



			-- oldMap = newMap
			oldMap = {}
			for i = 0, nLen - 1 do 
				local name = keys:at(i)
				local img_name = name:getCString()
        		oldMap[#oldMap+1] = img_name
			end


			-- testDebuger.textureCacheLabel:setString(string.format("TextureCache: %.2fM / %.2fM", nUsedMem/1024, nMem/1024))
			-- testDebuger.textureCountLabel:setString(string.format('TextureCount: %d/%d   Use Rate: %d%%', nUsed, nLen, nUsed/nLen*100))

		end

		testDebuger.exitBtn = testDebuger.debugPanel:getChildByName("exitBtn")
		testDebuger.exitBtn:addMEListener(TFWIDGET_CLICK, __close)

		testDebuger.fpsLabel 			= TFDirector:getChildByPath(testDebuger.debugPanel, "fpsLabel")
		testDebuger.textureCacheLabel 	= TFDirector:getChildByPath(testDebuger.debugPanel, "textureCacheLabel")
		testDebuger.textureCountLabel 	= TFDirector:getChildByPath(testDebuger.debugPanel, "textureCountLabel")
		testDebuger.batchCountLabel 	= TFDirector:getChildByPath(testDebuger.debugPanel, "batchCountLabel")
		testDebuger.imgCountLabel 		= TFDirector:getChildByPath(testDebuger.debugPanel, "imgCountLabel")
		testDebuger.labelCountLabel 	= TFDirector:getChildByPath(testDebuger.debugPanel, "labelCountLabel")
		testDebuger.armatureCountLabel 	= TFDirector:getChildByPath(testDebuger.debugPanel, "ArmatureCountLabel")
		testDebuger.boneCountLabel 		= TFDirector:getChildByPath(testDebuger.debugPanel, "BoneCountLabel")
		testDebuger.netRecvLabel 		= TFDirector:getChildByPath(testDebuger.debugPanel, "netRecvLabel")
		testDebuger.netSendLabel 		= TFDirector:getChildByPath(testDebuger.debugPanel, "netSendLabel")
		testDebuger.partCountLabel 		= TFDirector:getChildByPath(testDebuger.debugPanel, "particleCountLabel")
		testDebuger.partNumLabel 		= TFDirector:getChildByPath(testDebuger.debugPanel, "particleNumLabel")
		testDebuger.memCountLabel 		= TFDirector:getChildByPath(testDebuger.debugPanel, "memLabel")
		testDebuger.luaMemLabel 		= TFDirector:getChildByPath(testDebuger.debugPanel, "luaMemLabel")
	
		testDebuger.luaMemLabel:setPositionY(testDebuger.luaMemLabel:getPositionY() + 15)
		testDebuger.memCountLabel:setPositionY(testDebuger.memCountLabel:getPositionY() + 20)
	
		testDebuger.memCountLabel:setHorizontalAlignment(0)
		testDebuger.memCountLabel:setVerticalAlignment(0)
		testDebuger.memCountLabel:setAnchorPoint(ccp(0, 1))
		testDebuger.memCountLabel:setLineHeight(20)

		testDebuger.touchPanel = TFPanel:create()

		testDebuger.touchPanel:setSize(CCSizeMake(100, 100))
		testDebuger.touchPanel:setTouchEnabled(true)
		testDebuger.touchPanel:setDoubleClickEnabled(true)
		testDebuger.touchPanel:setDoubleClickGap(0.2)
		testDebuger.touchPanel:setSwallowTouch(false)
		testDebuger.touchPanel:addMEListener(TFWIDGET_DOUBLECLICK, __open)
		testDebuger.touchPanel:addChild(testDebuger.debugPanel)
		testDebuger.touchPanel:setTag(95272)


		local node = me.Director:getNotificationNode()
		if node then 
			node:addChild(testDebuger.touchPanel)
		else 
			me.Director:setNotificationNode(testDebuger.touchPanel)	
		end

		testDebuger.touchPanel:addMEListener(TFWIDGET_ENTER, function() print("debug enter") end)
		testDebuger.touchPanel:addMEListener(TFWIDGET_CLEANUP, function() print("debug clean") end)
		testDebuger.touchPanel:addMEListener(TFWIDGET_EXIT, function() print("debug exit") end)

		local function updateNetFlow()
			local insTance  = TFDirector:getNetWorkInstance()
			nRecvFlow = insTance.clientNet:getRecvFlow()
			nSendFlow = insTance.clientNet:getSendFlow()
			self.testDebuger.netRecvLabel:setString('RecvFlow: ' .. nRecvFlow .. ' bytes')
			self.testDebuger.netSendLabel:setString('SendFlow: ' .. nSendFlow .. ' bytes')
		end

		local function checkStringNum(str)
			if type(str) == 'string' and (str[#str] == 'K' or str[#str] == 'k') then 
				str = str[{1, #str-1}]
			end
			return str
		end

		local function updateCounters()
			local info = loadstring(me.Director:getDebugInfo())()
			if not info then return end
			local imageCnt = info[1]
			local labelCnt = info[2]
			local batchCnt = info[3]
			local armatCnt = info[4]
			local boneCnt = info[5]
			local drawCnt = info[6]
			local vertCnt = info[7]
			local mpfCnt = info[8]
			local partCnt = info[9]
			local partNum = info[10]
			local block = (info[11] or 0) / (1024 * 1024)
			local usedblock = (info[12] or 0) / (1024 * 1024)
			local sysMem = (info[13] or 0) / (1024 * 1024)

			local appmem = TFDeviceInfo:getAppMem() or 0
			local totPss = TFDeviceInfo:getPSS() or 0
			local allMem = checkStringNum(TFDeviceInfo.getTotalMem())
			local freeMem = checkStringNum(TFDeviceInfo.getFreeMem())

			testDebuger.batchCountLabel 	:setString('Batch Count: ' .. batchCnt)
			testDebuger.imgCountLabel 		:setString('Image Count: ' .. (imageCnt - 9))
			testDebuger.labelCountLabel 	:setString('Label Count: ' .. (labelCnt - 15))
			testDebuger.armatureCountLabel 	:setString('Armature Count: ' .. armatCnt)
			testDebuger.boneCountLabel 		:setString('Bone Count: ' .. boneCnt)

			testDebuger.fpsLabel			:setString(string.format('FPS: %.1f/%.3f | DRW: %d | VERT: %d', nFPS, mpfCnt, drawCnt, vertCnt))
			testDebuger.partCountLabel 		:setString(string.format('Particle Count: %d', partCnt))
			testDebuger.partNumLabel 		:setString(string.format('Particle Num: %d', partNum))
			testDebuger.memCountLabel 		:setString(string.format('Free:%dM Tot:%dM \nPss:%.1fM App:%.1fM', freeMem/1024, allMem/1024, totPss, appmem))
			testDebuger.luaMemLabel 		:setString(string.format('Lua Mem: %.2fM Block:%.1fM/%.1fM Sys:%.1fM', collectgarbage("count")/1024, usedblock, block, sysMem))	
		end

		local function updateTexture()
			local keys = me.TextureCache:textureKeys()
			local nLen = keys:size()

			local nUsed = 0
			local nVisited = 0
			local nMem = 0
			local nUsedMem = 0
			local nVisitedMem = 0
			local newVersion = false
			if Texture2D.getBitsPerPixelForFormat then 
				newVersion = true
			end 
			for i = 0, nLen - 1 do 
				local name = keys:at(i)
				local tex = me.TextureCache:textureForKey(name:getCString())
				local bpp = newVersion and tex:getBitsPerPixelForFormat() or tex:bitsPerPixelForFormat()
        		local bytes = tex:getPixelsWide() * tex:getPixelsHigh() * bpp / 8 / 1024
				nMem = nMem + bytes

				local isVisiting = true
				if tex.isVisiting then 
					isVisiting = tex:isVisiting()
				else 
					isVisiting = tex:retainCount() > 1
				end

				if isVisiting then 
					nVisited = nVisited + 1
					nVisitedMem = nVisitedMem + bytes
				end

        		if tex:retainCount() > 1 then 
        			nUsed = nUsed + 1 
        			nUsedMem = nUsedMem + bytes
        		end
			end

			testDebuger.textureCacheLabel:setString(string.format("TextureCache: %.2fM / %.2fM / %.2fM", nVisitedMem/1024, nUsedMem/1024, nMem/1024))
			testDebuger.textureCountLabel:setString(string.format('TextureCount: %d/%d/%d   Use Rate: %d%%/%d%%', nVisited, nUsed, nLen, nVisited/nLen*100, nUsed/nLen*100))
		end

		local nFrameRate = 0
		self.nDebugUpdateTID = TFDirector:addTimer(1000, -1, nil, function(dt)
			if testDebuger.debugPanel:isVisible() then 
				updateNetFlow()
				updateCounters()
				updateTexture()
			end
		end)

		local nFrameRate = 0
		local nFrameDelta = 0
		self.nDebugFrameTID = TFDirector:addTimer(0, -1, nil, function(dt)
			nFrameRate = nFrameRate + 1
			nFrameDelta = nFrameDelta + dt
			if nFrameDelta > 0.2 then 
				nFPS = nFrameRate / nFrameDelta
				nFrameRate = 0
				nFrameDelta = 0
			end
		end)

		updateNetFlow()
		updateCounters()
		updateTexture()

		__close()
	end
end

function TFDirector:writeToDebugerLayer(...)
end

function TFDirector:startRemoteDebug(host)
	print('Try to start remote debug...')
	host = host or 'localhost'
	return meStartDebug(host)
end

return TFDirector