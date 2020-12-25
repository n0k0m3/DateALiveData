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
* 
]]

local  WorldRoomExtendDataBasicControl = class("WorldRoomExtendDataBasicControl")

function WorldRoomExtendDataBasicControl:parseWorldRelevantData( data )
    -- body
    self.extentData = json.decode(data.ext)
end

function WorldRoomExtendDataBasicControl:parseShowTimerData( data )
    -- body
    self.showTimeInfo = data.areaShowTime
end

function WorldRoomExtendDataBasicControl:getShowTimeInfo( ... )
    -- body
    return self.showTimeInfo or {}
end

function WorldRoomExtendDataBasicControl:getExtendData( ... )
    -- body
    return self.extentData or {}
end

return WorldRoomExtendDataBasicControl