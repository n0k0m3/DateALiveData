local StoryTestView = class("StoryTestView",BaseLayer)
local function write_to_file( msg, file_handle )
	msg = msg.."\n"
	file_handle:write(msg)
end
local function luaTostringFunc( t, indent, file_handle )

	local pre = string.rep("\t",indent)
	local function handleTab(k,v)
		local valueType = type(v)
		local keyType = type(k)
		if valueType == "table" then
			if keyType == "number" then
				write_to_file(pre .. "[" .. k .. "]" .. " = {", file_handle)
				luaTostringFunc(v, indent + 1, file_handle)
				write_to_file(pre .. "},", file_handle)
			elseif keyType == "string" then
				if tonumber(k) then
					write_to_file(pre .. "[\"" .. k .. "\"] = {", file_handle)
				elseif (tonumber(string.sub(k, 1, 1))) then
					write_to_file(pre .. "[\"" .. k .. "\"] = {", file_handle)
				else
					write_to_file(pre .. k .. " = {", file_handle)
				end
				luaTostringFunc(v, indent + 1, file_handle)
				write_to_file(pre .. "},", file_handle)
			end
		elseif valueType == "number" then
			if keyType == "number" then
				write_to_file(pre .. "[" .. k .. "]" .. " = " .. v .. ",", file_handle)
			elseif keyType == "string" then
				if tonumber(k) then
					write_to_file(pre .. "[\"" .. k .. "\"] = " .. v .. ",", file_handle)
				elseif (tonumber(string.sub(k, 1, 1))) then
					write_to_file(pre .. "[\"" .. k .. "\"] = " .. v .. ",", file_handle)
				else
					write_to_file(pre .. k .. " = " .. v .. ",", file_handle)
				end
			end
		elseif valueType == "string" then
			local text = string.gsub(v, "[\n]", "")
			text = string.gsub(text, "\"", "\\\"")
			if keyType == "number" then
				write_to_file(pre .. "[" .. k .. "]" .. " = \"" .. text .. "\",", file_handle)
			elseif keyType == "string" then
				if tonumber(k) then
					write_to_file(pre .. "[\"" .. k .. "\"] = \"" .. text .. "\",", file_handle)
				elseif (tonumber(string.sub(k, 1, 1))) then
					write_to_file(pre .. "[\"" .. k .. "\"] = \"" .. text .. "\",", file_handle)
				else
					write_to_file(pre .. k .. " = \"" .. text .. "\",", file_handle)
				end
			end
		elseif valueType == "boolean" then
			if keyType == "number" then
				write_to_file(pre .. "[" .. k .. "]" .. " = " .. tostring(v) .. ",", file_handle)
			elseif keyType == "string" then
				if tonumber(k) then
					write_to_file(pre .. "[\"" .. k .. "\"] = " .. tostring(v) .. ",", file_handle)
				elseif (tonumber(string.sub(k, 1, 1))) then
					write_to_file(pre .. "[\"" .. k .. "\"] = " .. tostring(v) .. ",", file_handle)
				else
					write_to_file(pre .. k .. " = " .. tostring(v) .. ",", file_handle)
				end
			end

		end
	end

	
	if type(t) == "table" then
		local isDict = false
		for k,v in pairs(t) do
			if type(k) == "string" then
				isDict = true
				break
			end
		end
		if isDict == true then
			for k,v in pairs(t) do
				handleTab(k,v)
			end
		else
			for k,v in ipairs(t) do
				handleTab(k,v)
			end
		end
	else

	end
	
end
local EventTrigger = import("lua.logic.battle.EventTrigger")
function StoryTestView:initData()
	local dialogData = TabDataMgr:getData("Dialog")
	local groupIdDict = {}
	for k,v in pairs(dialogData) do
		groupIdDict[v.scriptId] = 1
	end
	local groupIdArr = {}
	for k,v in pairs(groupIdDict) do
		groupIdArr[#groupIdArr + 1] = k
	end
	if #groupIdArr > 1 then
		table.sort(groupIdArr, function(a,b)
			return a < b
		end )
	end
	self.list_data = groupIdArr
end

function StoryTestView:ctor( ... )
	self.super.ctor(self,...)
	self:initData()
	self:init("lua.uiconfig.test.storyTestView")
	-- body
end

function StoryTestView:initUI(ui)
	self.super.initUI(self,ui)
	local root_panel = ui:getChildByName("Panel_root")
	root_panel:getChildByName("Button_close"):onClick(function()
		AlertManager:closeLayer(self)
	end)

	root_panel:getChildByName("Button_visualBattle"):onClick(function()
		local MusicGame = require("lua.logic.battle.MusicGame")
    	local musicGame = MusicGame:new()
		AlertManager:addLayer(musicGame,BLOCK_AND_GRAY)
		AlertManager:show()
	end)
	root_panel:getChildByName("Button_teamBattle"):getChildByName("Label_title"):setText("外挂测试")
	root_panel:getChildByName("Button_teamBattle"):onClick(function()
		-- TeamFightDataMgr:openTeamLevelSelView(402)
		-- TFDirector:send(c2s.PLAYER_REQ_CHEAT, {})
		local testparam1 = {
			areainfo = {pos = me.p(500,250),size = me.size(100,100)},
			sp = me.p(550,300),
			ep = me.p(650,400)
		}
		local testparam2 = {
			areainfo = {pos = me.p(500,250),size = me.size(100,100)},
			sp = me.p(300,100),
			ep = me.p(650,400)
		}
		local testparam3 = {
			areainfo = {pos = me.p(500,250),size = me.size(100,100)},
			sp = me.p(300,100),
			ep = me.p(650,120)
		}
		local testparam4 = {
			areainfo = {pos = me.p(500,250),size = me.size(100,100)},
			sp = me.p(200,300),
			ep = me.p(300,300)
		}
		if EventTrigger:isCrossArea(testparam1.areainfo,testparam1.sp,testparam1.ep) == true then
			Box("OK1")
		end
		if EventTrigger:isCrossArea(testparam2.areainfo,testparam2.sp,testparam2.ep) == true then
			Box("OK2")
		end
		if EventTrigger:isCrossArea(testparam3.areainfo,testparam3.sp,testparam3.ep) == false then
			Box("OK3")
		end
		if EventTrigger:isCrossArea(testparam4.areainfo,testparam4.sp,testparam4.ep) == false then
			Box("OK4")
		end

	end)


	local scroll_view = root_panel:getChildByName("ScrollView_list")
	self.list_view = UIListView:create(scroll_view)
	self.cell_model = root_panel:getChildByName("Panel_cell")
	local list_data_count = #self.list_data
	local cellCount = math.ceil(list_data_count/8)
	for i=1,cellCount do
		local tmCell = self.cell_model:clone()
		tmCell:setPosition(me.p(0,0))
		for j = 1,8 do
			local idx = 8*(i - 1) + j
			local tmitem = tmCell:getChildByName("Panel_item_"..j)
			if self.list_data[idx] then
				tmitem:getChildByName("Label_id"):setText(tostring(self.list_data[idx]))
				tmitem.groupid = self.list_data[idx]
				tmitem:onClick(function()
					local param = {groupid = tmitem.groupid}
					local layer = require("lua.logic.talk.TalkMainLayer"):new(param)
					AlertManager:addLayer(layer,BLOCK_AND_GRAY)
    				AlertManager:show()
				end)
				tmitem:setVisible(true)
			else
				tmitem:setVisible(false)
			end
		end
		self.list_view:pushBackCustomItem(tmCell)
	end
	-- self:TransScript(12001)
	--快速打开关卡
	local level_input = root_panel:getChildByName("TextField_levelid")
	local btn_openlevel = root_panel:getChildByName("Button_openLevel")
	btn_openlevel:onClick(function()
		level_input:closeIME()
		local levelid = level_input:getString()
		if levelid ~= "" then
			levelid = tonumber(levelid)
			local levelCfg = FubenDataMgr:getLevelCfg(levelid)
			if levelCfg == nil then
				Utils:showError("错误的关卡Id")
				return
			end
			local levelGroupCid = levelCfg.levelGroupId
            FubenDataMgr:cacheSelectLevelGroup(levelGroupCid)
            FubenDataMgr:cacheSelectLevel(levelid)
            Utils:openView("fuben.FubenReadyView", levelid)
		end
	end)
end

function StoryTestView:TransScript(scriptId)
	local scriptCont = import("res.basic.storyscript.story_"..tostring(scriptId))
	local jsonStr = json.encode(scriptCont)
	local path = me.FileUtils:fullPathForFilename("res/basic/storyscript").."/story_"..scriptId..".json"
	local luapath = me.FileUtils:fullPathForFilename("res/basic/storyscript").."/story_a_"..scriptId..".lua"
	io.writefile(path,jsonStr,"w+")
	local filelua = io.open(luapath,"w+")
	write_to_file("return {", filelua)
	luaTostringFunc(json.decode(jsonStr),1,filelua)
	write_to_file("}", filelua)
	filelua:close()
end

return StoryTestView