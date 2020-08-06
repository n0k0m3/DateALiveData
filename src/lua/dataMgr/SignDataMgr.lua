local BaseDataMgr = import(".BaseDataMgr")
local SignDataMgr = class("SignDataMgr", BaseDataMgr)


function SignDataMgr:ctor()
	local signData = TabDataMgr:getData("Sign")
	self.signData = {}
	for k, v in ipairs(signData) do
		self.signData[v.month] = self.signData[v.month] or {}
		table.insert(self.signData[v.month], v)
	end
end

function SignDataMgr:getRewardList(month)
	if not month then
		month = tonumber(os.date("%m", os.time()))
	end

	return self.signData[month] 
end


return SignDataMgr:new()
