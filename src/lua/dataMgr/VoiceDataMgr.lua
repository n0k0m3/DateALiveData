local BaseDataMgr = import(".BaseDataMgr")
local VoiceDataMgr = class("VoiceDataMgr", BaseDataMgr)

function VoiceDataMgr:ctor()
	self.voiceTable = clone(TabDataMgr:getData("Voice"));
	local voiceTable = {}
	for k,v in pairs(self.voiceTable) do
		voiceTable[v.type] = voiceTable[v.type] or {};
		voiceTable[v.type][v.role] = v;
		if v.hero and v.hero ~= 0 then
			voiceTable[v.type][v.hero] = v
		end

	end

	self.voiceTable = voiceTable;
	self:init();
end

function VoiceDataMgr:init()

end

function VoiceDataMgr:getVoice(_type,roleID,dressId)
	if not self.voiceTable[_type] then
		print("没有此类型");
		return;
	end

	if not self.voiceTable[_type][roleID] then
		print("没有配置音效");
		return;
	end

	local voiceTable = self.voiceTable[_type][roleID].voice
	local voicePath = voiceTable[math.random(1,#voiceTable)]
	if roleID and not dressId then
		if 	roleID == RoleDataMgr:getUseId() then
			dressId = RoleDataMgr:getUseRoleInfo().dressId
		end
	end
	if dressId then
		local suffixStr = ".mp3"
		local tablePath = string.split(voicePath, suffixStr)
		local kz = TabDataMgr:getData("Dress",dressId).speVoiceSuffix or ""
		local dressVoicePath = tablePath[1] .. "_" .. kz .. suffixStr
		if self:file_exists(dressVoicePath) then
			voicePath = dressVoicePath			
		end
	end

	return voicePath
end

function VoiceDataMgr:file_exists(path)

	local filePath = me.FileUtils:fullPathForFilename(path)

	local file = io.open(filePath, "rb")
	if file then
		file:close()
		return true
	end
	return false
end

function VoiceDataMgr:playVoice(_type,roleID,dressId)
	local voicePath = self:getVoice(_type,roleID,dressId);
	dump(voicePath);
	return TFAudio.playSound(voicePath)
end

function VoiceDataMgr:playVoiceByHeroID(_type,heroID)
	local voicePath = self:getVoice(_type,heroID)
	if not voicePath then
		local roleID 	= HeroDataMgr:getHeroRoleId(heroID)
		voicePath = self:getVoice(_type,roleID);
	end
	dump(voicePath);
	local handle = TFAudio.playEffect(voicePath);
	return handle
end

return VoiceDataMgr:new();
