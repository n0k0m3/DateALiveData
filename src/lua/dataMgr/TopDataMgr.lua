local BaseDataMgr = import(".BaseDataMgr")
local TopDataMgr = class("TopDataMgr", BaseDataMgr)


function TopDataMgr:ctor()
	local topData = TabDataMgr:getData("TopHelp");
	self.topData = {}
	for k,v in pairs(topData) do
		self.topData[v.fileName] = v
	end
    self:init()
end

function TopDataMgr:init()
	
end

function TopDataMgr:isShowTop(__cname)
	if self.topData[__cname] then
		return true;
	end

	return false;
end

function TopDataMgr:isShowAnimBg(__cname)
	local topdata = self.topData[__cname]
	if topdata and topdata.dynamic then
		return true;
	end

	return false;
end

function TopDataMgr:getTopData(__cname)
	return self.topData[__cname];
end

return TopDataMgr:new();
