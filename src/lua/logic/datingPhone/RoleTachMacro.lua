--[[
    @desc:精灵调教控制模块宏
]]
local RoleTachMacro = {}
-- 页面tag
RoleTachMacro.PAGETYPE = {
    ACHIEVE = 1,     -- 成就
    TEACH   = 2,     -- 调教   
    RANK    = 3      -- 排行   
}
-- 二级页签tag
RoleTachMacro.ACHIEVE = {
    Info     = 1,   -- 信息
    -- Achieve  = 2    -- 成就 
}
RoleTachMacro.TEACH = {
    Issue = 1,      -- 问题集
    TeachSelf = 2,      -- 调教
    CHECK = 3       -- 审核列表
}
RoleTachMacro.RANK = {
    WeekRank = 1,   -- 周榜
    SumRank  = 2    -- 总榜
}
-- 三级审核页签tag
RoleTachMacro.CHECK = {
    Doing = 1, -- 审核中
    Success = 2, -- 审核成功
    Failed = 3 -- 审核失败
}

return RoleTachMacro