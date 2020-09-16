--[[
******游戏场景配置*******
]]
local SceneType = {}


SceneType.DEFAULT 			= "lua.logic.default.DefaultScene"
SceneType.LOGIN 			= "lua.logic.login.LoginScene"
SceneType.LOGO				= "lua.logic.login.LogoScene"
SceneType.NOTE	 			= "lua.logic.note.NoteScene"
SceneType.BATTLE			= "lua.logic.battle.BattleScene"
SceneType.BATTLERESULT		= "lua.logic.battle.BattleResultScene"
SceneType.DATING 		    = "lua.logic.dating.DatingScene"
SceneType.TESTVIEW 			= "lua.logic.test.TestView"
SceneType.MainScene 		= "lua.logic.MainScene.MainScene"
SceneType.Load              = "lua.logic.load.LoadScene"
SceneType.CATCHDOLL         = "lua.logic.catchDoll.CatchDollScene"
SceneType.NewCity           = "lua.logic.newCity.NewCityMainScene"
SceneType.NewCityLoad       = "lua.logic.newCity.NewCityLoadScene"
SceneType.LEAGUE       		= "lua.logic.league.LeagueMainScene"

SceneType.Phone       		= "lua.logic.datingPhone.PhoneScene"

SceneType.MOVIE 			= "lua.logic.movie.MovieScene"
SceneType.OSD 				= "lua.logic.osd.BaseOSDScene"
SceneType.TRANSITION        = "lua.logic.osd.TransitionScene" --组队战斗场景切换过渡场景
SceneType.PACKBRANCH		= "lua.logic.packbranch.PackBranchScene"
return SceneType