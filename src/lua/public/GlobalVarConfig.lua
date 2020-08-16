
-- 配置名称 = {"键名",类型[,默认值[,是否本地缓存]]}

local function make(key, type_, defaultValue, isCache)
    assert(type(key) == "string")
    assert(type_ == "boolean" or type == "string" or type_ == "number")
    return {key, type_, defaultValue, isCache}
end

-- 七日狂欢主界面显示flag
GV_FULI_SEVENSIGNIN_FLAG = make("GV_FULI_SEVENSIGNIN_FLAG", "boolean", false, false)
-- 月卡弹窗红点提示
GV_MONTH_CARD_TIP = make("GV_MONTH_CARD_TIP", "boolean", false, false)
-- 副本准备界面剧情提示
GV_FUBEN_PREPLOT_FLAG = make("GV_FUBEN_PREPLOT_FLAG", "boolean", false, false)
-- 精灵契约提示
GV_ELF_CONTRACT_TIP = make("GV_ELF_CONTRACT_TIP", "boolean", false, false)
-- 是否进入过女仆咖啡厅
GV_COFFEE_IS_FIRSTENTER = make("GV_COFFEE_IS_FIRSTENTER", "boolean", true, true)
-- 是否第一次进入端午活动
GV_DUANWU_IS_FIRSTENTER = make("GV_DUANWU_IS_FIRSTENTER", "boolean", true, true)
-- 是否第一次制作五谷粽子
GV_DUANWU_WUGU_FIRSTMAKE = make("GV_DUANWU_WUGU_FIRSTMAKE", "boolean", true, true)
-- 是否第一次制作鲜肉粽子
GV_DUANWU_XIANROU_FIRSTMAKE = make("GV_DUANWU_XIANROU_FIRSTMAKE", "boolean", true, true)
-- 是否第一次制作豆沙粽子
GV_DUANWU_DOUSHA_FIRSTMAKE = make("GV_DUANWU_DOUSHA_FIRSTMAKE", "boolean", true, true)


-- 是否第一次进入中秋活动
GV_MIDAUTUMN_IS_FIRSTENTER = make("GV_MIDAUTUMN_IS_FIRSTENTER", "boolean", true, true)
-- 奖励id:580127
GV_MIDAUTUMN_580127_FIRSTMAKE = make("GV_MIDAUTUMN_580127_FIRSTMAKE", "boolean", true, true)
-- 奖励id:580128
GV_MIDAUTUMN_580128_FIRSTMAKE = make("GV_MIDAUTUMN_580128_FIRSTMAKE", "boolean", true, true)
-- 奖励id:580129
GV_MIDAUTUMN_580129_FIRSTMAKE = make("GV_MIDAUTUMN_580129_FIRSTMAKE", "boolean", true, true)


GV_UTC_TIME_ZONE = -7   ---Utc时区设置 目前 正负即为 对应+ - 时区
GV_UTC_TIME_STRING = "(UTC-7)"
