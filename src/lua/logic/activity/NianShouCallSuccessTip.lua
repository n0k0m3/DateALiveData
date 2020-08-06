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
* -- 召唤年兽成功
* 
]]

local NianShouCallSuccessTip = class("NianShouCallSuccessTip",BaseLayer)
local tipId = { [201] = 13100001,  -- 年兽刷新建筑对应提示语ID
				[108] = 13100002,
				[109] = 13100003,
				[110] = 13100004,
				[103] = 13100005,
				[102] = 13100006,
				[106] = 13100007,
				[111] = 13100008,
				[107] = 13100009,
				[104] = 13100010,
				[105] = 13100011,
				[101] = 13100012,
				[112] = 13100067,}

function NianShouCallSuccessTip:ctor( data , isExtendUi)
	self.super.ctor(self,data)
    self:showPopAnim(true)
    self.nianBeastId = data.id
    self.buildId = data.bid
    self.isExtendUi = isExtendUi
	self:init("lua.uiconfig.activity.NianShouCallSuccessTip")
end

function NianShouCallSuccessTip:initUI( ui )
	self.super.initUI(self,ui)
	self.image_half = TFDirector:getChildByPath(ui,"image_half")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.txt_des = TFDirector:getChildByPath(ui,"txt_des")
	self.txt_des1 = TFDirector:getChildByPath(ui,"txt_des1")
	self.txt_refreshTime = TFDirector:getChildByPath(ui,"txt_refreshTime")
	self.btn_go = TFDirector:getChildByPath(ui,"btn_go")


	local nianshouCfg = TabDataMgr:getData("NianBeast", self.nianBeastId)
	self.image_half:setTexture(nianshouCfg.headIcon)
	self.txt_des:setTextById(nianshouCfg.name)
	self.txt_des1:setTextById(tipId[self.buildId])
    self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.flushTime, self))
	self:flushTime( 0 )
end

function NianShouCallSuccessTip:dispose()
	self.super.dispose(self)
	if self.countDownTimer_ then
		TFDirector:stopTimer(self.countDownTimer_)
		TFDirector:removeTimer(self.countDownTimer_)
		self.countDownTimer_ = nil
	end
end

function NianShouCallSuccessTip:flushTime( dt )
	local remainTime = ActivityDataMgr2:getNianShouEscapeTime( )
    local day, hour, min, sec = Utils:getDHMS(remainTime, true)
    
    if hour ~="00" then
        self.txt_refreshTime:setTextById(13100055, hour, min)
    else
        self.txt_refreshTime:setTextById(13100056, min, sec)
    end
end

function NianShouCallSuccessTip:registerEvents( )
	self.super.registerEvents(self)

	self.btn_go:onClick(function (  )
		-- 调转城建主界面
			AlertManager:closeLayer(self)
			if self.isExtendUi then
				return
			end
			FunctionDataMgr:jCity()
		end)

	self.Button_close:onClick(function (  )
		AlertManager:closeLayer(self)
	end)
end

return NianShouCallSuccessTip