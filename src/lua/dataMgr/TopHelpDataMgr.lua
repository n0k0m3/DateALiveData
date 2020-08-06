local BaseDataMgr = import(".BaseDataMgr")
local TopHelpDataMgr = class("TopHelpDataMgr", BaseDataMgr)


function TopHelpDataMgr:ctor()
	local topHelpData = TabDataMgr:getData("HelpView")
	self.topHelpData = {}
	for k,v in pairs(topHelpData) do
		v.id = tonumber(k)
		self.topHelpData[k] = v
	end
    self:init()
end

function TopHelpDataMgr:init()
	
end

function TopHelpDataMgr:getHelpDataByIds(ids)
	local helpData = {}
	for k,id in pairs(ids) do
		local data = self.topHelpData[id]
		if data then
			helpData[#helpData + 1] = data
		end
	end
	table.sort(helpData, function(a, b)
		return a.id < b.id
	end)
	return helpData
end

function TopHelpDataMgr:getHelpDataById(id)
	return self.topHelpData[id]
end

return TopHelpDataMgr:new()
