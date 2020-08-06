c2s = require("lua.net.codes_c2s")
s2c = require("lua.net.codes_s2c")
tblS2CData = require("lua.net.protos_s2c")
tblC2SData = require("lua.net.protos_c2s")
NetWork = require("lua.net.NetWork")

EventMgr = require("lua.public.EventMgr")
require("lua.public.EnumConfig")
require("lua.public.EventConfig")
require("lua.public.GlobalVarConfig")
require("lua.public.MEMapArray")
require("lua.public.TPageView")
require("lua.public.TFTimeLabel")
TFWebView = require("TFFramework.utils.TFWebView")
Utils = require("lua.public.Utils")
AlertManager  = require("lua.public.AlertManager")
Public = require("lua.public.Public")
stringUtils = require("language.StringUtils_format")
--TFLanguageManager = require("lua.public.TFLanguageUtils")
TimeRecoverProperty = require("lua.public.TimeRecoverProperty");
GroupLayerManager  = require("lua.public.GroupLayerManager")
GroupButtonManager  = require("lua.public.GroupButtonManager")
TFScrollRichText  = require("lua.public.TFScrollRichText")
DeviceAdpter = require("lua.public.DeviceAdpter")
AudioExchangePlay = require("lua.public.AudioExchangePlay")
GameGuide = require("lua.logic.guide.GameGuide")
ViewAnimationHelper = require("lua.public.ViewAnimationHelper")
TFAssetsManager = require('LuaScript.TFAssetsManager')

GameConfig = require("lua.logic.common.GameConfig");
MainPlayer= require("lua.gamedata.MainPlayer")
SettingDataMgr= require("lua.dataMgr.SettingDataMgr")
BaseLayer = require("lua.logic.BaseLayer")
BaseScene = require("lua.logic.BaseScene")
SceneType = require("lua.logic.SceneType")
MovieScene= require("lua.logic.movie.MovieScene")


LoadingLayer = require("lua.logic.common.LoadingLayer")


ElvesNpcTable = require("lua.logic.common.ElvesNpc")
cityController = require("lua.logic.newCity.CityController"):new()

ToastMessage  = require("lua.logic.common.ToastMessage")
require("lua.logic.common.MessageBox")
require("lua.logic.common.GameAlertView")
require("lua.logic.battle.TeamFightReviveView")
ItemCoolDownTips = require("lua.logic.common.ItemCoolDownTips")
--ToastPowerChange  = require("lua.logic.common.ToastPowerChange")
-- 适配 start
MEArray     = TFArray
TFMapArray      = MEMapArray

-- MainPlayer   = require("lua.gamedata.MainPlayer")

if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
    local TFTimerManager 		= require('TFFramework.client.manager.TFTimerManager')

    function imgui.draw()
        if imgui.begin("Debug") then
            me.Director:setDebugModel(1)
            local directorInfo = loadstring(me.Director:getDebugInfo())() or {[8] = 1}
            local mpf = directorInfo[8]
            local fps = 1 / mpf
            if fps > 1 / me.Director:getAnimationInterval() then fps = 1 / me.Director:getAnimationInterval() end

            local timerCount = string.format("定时器数量: %d", TFTimerManager:getTimerCount())
            local timerElapse = string.format("定时器耗时: %.5f", TFTimerManager:getTimerRunTime())
            local fpsInfo = string.format("FPS: %.1f  MPF: %.4f", fps or 0, mpf or 0)
            imgui.text(fpsInfo)
            imgui.text(timerCount)            
            if imgui.IsItemClicked(1) then 
                imgui.OpenPopup("定时器列表")
            end
            if imgui.BeginPopup("定时器列表") then 
                local timers = TFTimerManager:getTimers()
                for id, tTimer in pairs(timers) do     	
                    if tTimer then
                        local title = string.format("ID: %d  %s [%.5f]", tTimer.nTimerId, tTimer.bIsStop and "已结束" or "执行中", tTimer.nLastExcuteTime)
                        imgui.text(title)
                        if imgui.IsItemClicked(1) then 
                            imgui.OpenPopup("定时器" .. tTimer.nTimerId)
                        end
                        if imgui.isItemHovered() then 
                            imgui.BeginTooltip() 
                            imgui.text("右键点击查看信息!")
                            imgui.EndTooltip()
                        end
                        
                        if imgui.BeginPopup("定时器" .. tTimer.nTimerId) then
                            imgui.text(tTimer.debuginfo or "无信息")
                            imgui.EndPopup()
                        end
                    end
                end

                imgui.EndPopup()
            end

            imgui.text(timerElapse)

            imgui.text("事件派发器[右键点击查看信息]")
            if imgui.IsItemClicked(1) then 
                imgui.OpenPopup("事件派发器列表[右键点击查看信息]")
            end
            if imgui.BeginPopup("事件派发器列表[右键点击查看信息]") then 
                local events = EventMgr.event_ or {}
                imgui.text("事件派发器列表")
                for eventName, event in pairs(events) do
                    imgui.text(eventName)
                    if imgui.IsItemClicked(1) then 
                        imgui.OpenPopup(eventName)
                    end                 
                    if imgui.BeginPopup(eventName) then
                        local index = 1                        
                        local title = ""
                        for target, funcs in pairs(event) do
                            for _, func in pairs(funcs) do
                                title = title .. string.format("堆栈信息[%d]:%s\n",index,(func.debuginfo or "无信息"))
                                index = index + 1
                            end
                            imgui.text(title)
                            if imgui.IsItemClicked(1) then 
                                imgui.OpenPopup(title)
                            end
                            if imgui.BeginPopup(title) then
                                imgui.text(title)
                                imgui.EndPopup()
                            end
                        end
                        imgui.EndPopup()
                    end                    
                end
                imgui.EndPopup()
            end
        end
        imgui.endToLua()
    end
end