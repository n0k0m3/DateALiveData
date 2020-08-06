
import(".extends.BaseFunction")
import(".extends.TFAudioEx")
import(".extends.ShaderEx")
import(".extends.Action")
import(".extends.TFLabelEx")
import(".extends.CCNodeEx")
import(".extends.TFCheckBoxEx")
import(".extends.TFTableViewEx")
UIListView = import(".extends.UIListView")
UIGridView = import(".extends.UIGridView")
UIScrollBar = import(".extends.UIScrollBar")
UITurnView = import(".extends.UITurnView")
UIPageView = import(".extends.UIPageView")

TFDate = import(".extends.date")
ErrorCodeManager = require("lua.gamedata.ErrorCodeManager")

USE_NATIVE_VLC = true
if me.platform == "android" then 
	--USE_NATIVE_VLC = false
end

require("lua.public.VlcPlayer")

function DelayCall(func, dt)
	if func then 
		dt = dt or 0
		local tid = -1
		tid = TFDirector:addTimer(dt * 1000, 1, function()
			TFDirector:removeTimer(tid)
			func()
		end)
	end
end
TimeOut = DelayCall

require("lua.manager.SdkManager")

if BlockUseSysAlloca then
	BlockUseSysAlloca(true)
end

_G["TabDataMgr"] = require("lua.dataMgr.TabDataMgr")
_G["TextDataMgr"] = require("lua.dataMgr.TextDataMgr")

function downloadFileByCEvent(event)
    if FileLoadMgr then
        FileLoadMgr:downloadFileByCEvent(event.data[1])
    end
end
TFDirector:addMEGlobalListener("cDownloadFile",downloadFileByCEvent)
