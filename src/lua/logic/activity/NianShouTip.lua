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
* -- 年兽简介
* 
]]

local NianShouTip = class("NianShouTip",BaseLayer)
function NianShouTip:ctor( data)
	self.super.ctor(self,data)
	self.nianBeastId = data
    self:showPopAnim(true)
	self:init("lua.uiconfig.activity.NianShouTip")
end

function NianShouTip:initUI( ui )
	self.super.initUI(self,ui)
	self.image_half = TFDirector:getChildByPath(ui,"image_half")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.txt_des = TFDirector:getChildByPath(ui,"txt_des")
	self.txt_refreshTime = TFDirector:getChildByPath(ui,"txt_refreshTime")

	local nianshouCfg = TabDataMgr:getData("NianBeast", self.nianBeastId)
	self.image_half:setTexture(nianshouCfg.headIcon)
	self.txt_des:setTextById(nianshouCfg.name)
	self:flushTime()
end

function NianShouTip:flushTime( dt )
	local nianshouCfg = TabDataMgr:getData("NianBeast", self.nianBeastId)
    local remainTime = nianshouCfg.escapeTime*60
    local day, hour, min, sec = Utils:getDHMS(remainTime, true)
    
    if hour ~="00" then
        self.txt_refreshTime:setTextById(13100055, hour, min)
    else
        self.txt_refreshTime:setTextById(13100056, min, sec)
    end
end

function NianShouTip:registerEvents( )
	self.super.registerEvents(self)

	self.Button_close:onClick(function (  )
		AlertManager:closeLayer(self)
	end)
end

return NianShouTip