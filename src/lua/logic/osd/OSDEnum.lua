--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 地图枚举
* 
]]

local enum = {}
--地图编辑器类型枚举
enum.MapNodeType = {
	MapLayer    ="MapLayer",
	MapImage    ="MapImage",
	MapEffect   ="MapEffect",      --spine动画
	MoveLayer   ="MoveLayer",      --行走面
	ResistLayer ="ResistLayer",    --阻挡 
	PointLayer  ="PointLayer",     --点控件
	NpcList 	="NpcList",		   --NPCList
}

--地图层级枚举
enum.MapLayerType = {
	Render    = 1,
	Role      = 2,
	Boss      = 3,		
	Occlusion = 4,		--遮挡
	Logic     = 5,		
}

--同屏中角色类型
enum.HeroType = {
	MainHero = 1,	--主角
	OtherHero = 2,	--其他玩家
	NPC = 3,		--NPC
	TRANSFER = 4,   --传送点
}

--角色状态
enum.HeroState = {
	OSD_BORN   = 1,		--出生
	OSD_STAND  = 2,		--站立
	OSD_MOVE   = 3,		--移动
}

--状态事件
enum.StateEvent = {
	FSM_BORN   = "FSM_BORN",		--出生
	FSM_STAND  = "FSM_STAND",		--站立	   
	FSM_MOVE   = "FSM_MOVE",   	    --移动
}

--连接服务器事件
enum.ServerEvent = {
	Connected    = "Connected",   --连接成功
	ConnectError = "ConnectError",--连接失败
}

--NPC 功能类型
enum.FuncType = {
	Task     = 1, --任务
	WarStore = 2, --战争商店
	LuckDraw = 3, --抽奖
	Bounty   = 4, --悬赏
	FUN_BEN  = 5, --副本
	Seq_War  = 6, --序列战争
}


--互动按钮状态变更
enum.FocusChange  = "FocusChange" 


--同屏错误码
enum.ErrorCode =
{
  E_240024     = 240024	,--组队提示信息	您正在进入多人场景中																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
  E_240025     = 240025	,--组队提示信息	房间不存在！																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
  E_240026     = 240026	,--组队提示信息	房间人数已满，请重新尝试。																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
  E_240027     = 240027	,--组队提示信息	你已经处于该场景中。																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
  E_240028     = 240028	,--组队提示信息	连接出现异常，请稍后再试！																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													
  E_240029     = 240029	,--组队提示信息	处于异常的多人场景中，请稍后再试！		
  E_240030     = 240030	,--组队提示信息	进入工会异常	
}


return enum