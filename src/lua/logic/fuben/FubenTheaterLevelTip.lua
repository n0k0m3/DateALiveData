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
local FubenTheaterContor = class("FubenTheaterContor")

function FubenTheaterContor:ctor( ... )
    self:init(...)
end

function FubenTheaterContor:init( logic, chapterId, stage)
end

function FubenTheaterContor:distory()
end

function FubenTheaterContor:onShow( )
end

function FubenTheaterContor:onLimitHeroEvent()
end

function FubenTheaterContor:getFirstStepId()
    local firstStepId = nil
   
    return firstStepId
end

function FubenTheaterContor:checkProcess() -- 进入流程或者等待服务器返回数据就进入流程
    return false
end

function FubenTheaterContor:isPassCond( conds )
    return false
end

function FubenTheaterContor:actionStep( step )
end

function FubenTheaterContor:saveStep( id, chapterId ) -- 保存下一步的id 
end

local FubenTheaterLevelTip = requireNew("lua.logic.fuben.FubenTheaterLevelView")
FubenTheaterLevelTip.__cname = "FubenTheaterLevelTip"


function _ctor(self, ...)
	self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self.processContro = FubenTheaterContor:new()
    self:init("lua.uiconfig.activity.chapterListTip")
end
rawset(FubenTheaterLevelTip, "ctor", _ctor)

local _registerEvents = FubenTheaterLevelTip.registerEvents
function registerEvents( self )
	-- body
	_registerEvents(self)
	local Button_close = TFDirector:getChildByPath(self.ui,"Button_close")
	Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

    EventMgr:addEventListener(self, EV_BATTLE_FIGHTOVER, handler(self.refreshView, self))
end
rawset(FubenTheaterLevelTip, "registerEvents", registerEvents)

local _refreshView = FubenTheaterLevelTip.refreshView
function refreshView( self )
    -- body
    _refreshView(self )
    self.Panel_content:setPositionX(-494)
    self.Image_chapter:setPositionX(-446)
    self:updateContent(self.selectChapterIndex_)
end
rawset(FubenTheaterLevelTip, "refreshView", refreshView)

function addContent(self,index)
    local chapterCid = self.chapter_[index]
    local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
    local Panel_content_item = self.Panel_content_item:clone()
    local ScrollView_content = TFDirector:getChildByPath(Panel_content_item, "ScrollView_content")
    Panel_content_item:setPosition(0, 0)

    local contentSize = ScrollView_content:getSize()
    self.Panel_content:addChild(Panel_content_item)
    local contentMap = self:parseMap(chapterCfg.map)
    local size = contentMap.root:Size()
    ScrollView_content:setInnerContainerSize(size)

    ScrollView_content:setBounceEnabled(true)
    contentMap.root:setPosition(ccp(size.width*contentMap.root:getAnchorPoint().x, size.height * contentMap.root:getAnchorPoint().y))
    ScrollView_content:addChild(contentMap.root)


    local foo = {}
    foo.root = Panel_content_item
    foo.ScrollView_content = ScrollView_content
    contentMap.defaultPos = contentMap.root:getPosition()
    self.contentItems_[index] = foo
    self.contentMaps_[index] = contentMap
end
rawset(FubenTheaterLevelTip, "addContent", addContent)

return FubenTheaterLevelTip