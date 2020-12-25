
local function KVP(key, value)
    return {
        moduleName = key,
        fileName = value,
    }
end

local __dataMgr = {
    KVP("TabDataMgr", "lua.dataMgr.TabDataMgr"),
    KVP("LanguageResMgr" , "lua.dataMgr.LanguageResMgr"),
    KVP("TextDataMgr", "lua.dataMgr.TextDataMgr"),
    KVP("GlobalVarDataMgr", "lua.dataMgr.GlobalVarDataMgr"),
    KVP("FunctionDataMgr", "lua.dataMgr.FunctionDataMgr"),
    KVP("TopDataMgr", "lua.dataMgr.TopDataMgr"),
    KVP("ServerDataMgr", "lua.dataMgr.ServerDataMgr"),
    KVP("LogonHelper","lua.manager.LogonHelper"),
    KVP("FubenDataMgr", "lua.dataMgr.FubenDataMgr"),
    KVP("RoleDataMgr", "lua.dataMgr.RoleDataMgr"),
    KVP("DatingDataMgr", "lua.dataMgr.DatingDataMgr"),
    KVP("CommonManager", "lua.gamedata.CommonManager"),
    KVP("SaveManager", "lua.save.SaveManager"),
    KVP("GoodsDataMgr", "lua.dataMgr.GoodsDataMgr"),
    KVP("BattleDataMgr", "lua.dataMgr.BattleDataMgr"),
    KVP("CatchDollDataMgr", "lua.dataMgr.CatchDollDataMgr"),
    KVP("SettingDataMgr", "lua.dataMgr.SettingDataMgr"),
    KVP("HeroDataMgr","lua.dataMgr.HeroDataMgr"),
    KVP("PrefabDataMgr","lua.dataMgr.PrefabDataMgr"),
    KVP("StoreDataMgr","lua.dataMgr.StoreDataMgr"),
    KVP("CityDataMgr","lua.dataMgr.CityDataMgr"),
    KVP("CityJobDataMgr","lua.dataMgr.CityJobDataMgr"),
    KVP("EquipmentDataMgr","lua.dataMgr.EquipmentDataMgr"),
    KVP("AngelDataMgr","lua.dataMgr.AngelDataMgr"),
    KVP("MailDataMgr","lua.dataMgr.MailDataMgr"),
    KVP("FriendDataMgr","lua.dataMgr.FriendDataMgr"),
    KVP("SummonDataMgr","lua.dataMgr.SummonDataMgr"),
    KVP("TaskDataMgr","lua.dataMgr.TaskDataMgr"),
    KVP("GuideDataMgr","lua.dataMgr.GuideDataMgr"),
    KVP("RechargeDataMgr","lua.dataMgr.RechargeDataMgr"),
    KVP("SignDataMgr","lua.dataMgr.SignDataMgr"),
    KVP("CollectDataMgr","lua.dataMgr.CollectDataMgr"),
    KVP("ActivityDataMgr","lua.dataMgr.ActivityDataMgr"),
    KVP("VoiceDataMgr","lua.dataMgr.VoiceDataMgr"),
    KVP("NoticeDataMgr", "lua.dataMgr.NoticeDataMgr"),
    KVP("TeamFightDataMgr","lua.dataMgr.TeamFightDataMgr"),
    KVP("NewCityDataMgr", "lua.dataMgr.NewCityDataMgr"),
    KVP("MedalDataMgr", "lua.dataMgr.MedalDataMgr"),
    KVP("TopHelpDataMgr", "lua.dataMgr.TopHelpDataMgr"),
    KVP("CommentDataMgr", "lua.dataMgr.CommentDataMgr"),
    KVP("ManualMakeDataMgr", "lua.dataMgr.ManualMakeDataMgr"),
    KVP("KabalaTreeDataMgr", "lua.dataMgr.KabalaTreeDataMgr"),
    KVP("DatingPhoneDataMgr", "lua.dataMgr.DatingPhoneDataMgr"),
    KVP("LoginWatingDataMgr", "lua.dataMgr.LoginWatingDataMgr"),
    KVP("ActivityDataMgr2","lua.dataMgr.ActivityDataMgr2"),
    KVP("MakeFoodDataMgr","lua.dataMgr.MakeFoodDataMgr"),
    KVP("MainAdDataMgr","lua.dataMgr.MainAdDataMgr"),
    KVP("ShareDataMgr","lua.dataMgr.ShareDataMgr"),
    KVP("InfoStationDataMgr","lua.dataMgr.InfoStationDataMgr"),
    KVP("AvatarDataMgr","lua.dataMgr.AvatarDataMgr"),
    KVP("AgoraDataMgr","lua.dataMgr.AgoraDataMgr"),
    KVP("LeagueDataMgr","lua.dataMgr.LeagueDataMgr"),
    KVP("TiledMapDataMgr","lua.dataMgr.TiledMapDataMgr"),
    KVP("DlsDataMgr","lua.dataMgr.DlsDataMgr"),
    KVP("DalMapDataMgr","lua.dataMgr.DalMapDataMgr"),
    KVP("ChatDataMgr","lua.dataMgr.ChatDataMgr"),
    KVP("ValentineDataMgr","lua.dataMgr.ValentineDataMgr"),
    KVP("TeamPveDataMgr","lua.dataMgr.TeamPveDataMgr"),
    KVP("DfwDataMgr","lua.dataMgr.DfwDataMgr"),
    KVP("OSDDataMgr","lua.dataMgr.OSDDataMgr"),
    KVP("SxBirthdayDataMgr","lua.dataMgr.SxBirthdayDataMgr"),
    KVP("SkyLadderDataMgr","lua.dataMgr.SkyLadderDataMgr"),
    KVP("TitleDataMgr","lua.dataMgr.TitleDataMgr"),
    KVP("CoffeeDataMgr","lua.dataMgr.CoffeeDataMgr"),
    KVP("SceneSoundDataMgr","lua.dataMgr.SceneSoundDataMgr"),
    KVP("BingoDataMgr","lua.dataMgr.BingoDataMgr"),
    KVP("ChronoCrossDataMgr","lua.dataMgr.ChronoCrossDataMgr"),
    KVP("DispatchDataMgr","lua.dataMgr.DispatchDataMgr"),
    KVP("RoleSwitchDataMgr","lua.dataMgr.RoleSwitchDataMgr"),
    KVP("BlackAndWhiteDataMgr", "lua.dataMgr.BlackAndWhiteDataMgr"),
    KVP("SimulationSummonDataMgr", "lua.dataMgr.SimulationSummonDataMgr"),
    KVP("OneYearDataMgr","lua.dataMgr.OneYearDataMgr"),
    KVP("DanmuDataMgr","lua.dataMgr.DanmuDataMgr"),
    KVP("RoleTeachDataMgr", "lua.dataMgr.RoleTeachDataMgr"),
	KVP("MainUISettingMgr", "lua.dataMgr.MainUISettingMgr"),
    KVP("CourageDataMgr","lua.dataMgr.CourageDataMgr"),
    KVP("BlockGameDataMgr", "lua.dataMgr.BlockGameDataMgr"),
    KVP("KsanCardDataMgr", "lua.dataMgr.KsanCardDataMgr"),
    KVP("FamilyDataMgr", "lua.dataMgr.FamilyDataMgr"),
    KVP("EnvelopeDataMgr", "lua.dataMgr.EnvelopeDataMgr"),
    KVP("ResonanceDataMgr","lua.dataMgr.ResonanceDataMgr"),
    KVP("AssistanceDataMgr","lua.dataMgr.AssistanceDataMgr"),
    KVP("LinkageHwxDataMgr","lua.dataMgr.LinkageHwxDataMgr"),
    KVP("CrazyDiamondDataMgr","lua.dataMgr.CrazyDiamondDataMgr"),
    KVP("ExploreDataMgr","lua.dataMgr.ExploreDataMgr"),
    KVP("DuanwuHangUpDataMgr","lua.dataMgr.DuanwuHangUpDataMgr"),
    KVP("DetectiveDataMgr","lua.dataMgr.DetectiveDataMgr"),
    KVP("WorldRoomDataMgr","lua.dataMgr.WorldRoomDataMgr"),
    KVP("PrivilegeDataMgr","lua.dataMgr.PrivilegeDataMgr"),
    KVP("TurnTabletMgr", "lua.dataMgr.TurnTabletMgr"),
    KVP("GlobalFuncDataMgr","lua.dataMgr.GlobalFuncDataMgr"),
}

local __loadList = {}
table.merge(__loadList, __dataMgr)

local moduleName ={}
local fileName = {}

-- 配置表列表
-- local configList = require("lua.table.ConfigList")
-- for i = #configList, 1, -1 doNE
--     table.insert(__loadList, 1, KVP("", configList[i]))
-- end

for i,v in ipairs(__loadList) do
    table.insert(moduleName, v.moduleName)
    table.insert(fileName, v.fileName)
end

return {
    total = #__loadList,
    managers = moduleName,
    managerFile = fileName,
    dataMgr = __dataMgr,
}
