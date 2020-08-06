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
* --- 跑马灯界面
]]

local NoticeMarQueeLayer = class("NoticeMarQueeLayer",BaseLayer)

function NoticeMarQueeLayer:ctor( data )
	self.super.ctor(self,data)
	self.noticeList = {}
	self:init("lua.uiconfig.common.marqueeLayer")
end

function NoticeMarQueeLayer:initUI( ui )
	self.super.initUI(self,ui)
	self.Panel_system = TFDirector:getChildByPath(ui,"Panel_system")
    self.TextArea_system = TFDirector:getChildByPath(ui,"TextArea_system")
    self.TextArea_system.oPos = self.TextArea_system:Pos()
    self.Panel_content = TFDirector:getChildByPath(ui,"Panel_content")
    self.Label_content = TFDirector:getChildByPath(ui,"Label_content")

end

function NoticeMarQueeLayer:dispose(  )
	self.super.dispose(self)
end

function NoticeMarQueeLayer:showNotice( )
    if self.isScrolling then return end
	local content = self.noticeList[1]
	if not content then -- 跑马灯显示完成
		self:removeFromParent(true)
		return
	end
    self.isScrolling = true
    self.Panel_content:setVisible(false)
    self.TextArea_system:setVisible(true)
	local perfabNode = self.TextArea_system
    local speed = 150
    local interval = 0.1
    local totalWidth = 0
    if type(content) == "table" then
        if content.customContent then
            self.Panel_content:setVisible(true)
            self.Panel_content:removeAllChildren()
            self.TextArea_system:setVisible(false)
            perfabNode = self.Panel_content
            for i,v in ipairs(content.param) do
                local labelText = self.Label_content:clone()
                labelText:setText(v.text)
                labelText:setColor(v.color)
                self.Panel_content:addChild(labelText)
                labelText:setPosition(ccp(totalWidth, 0))
                totalWidth = totalWidth + labelText:getSize().width + 2
            end
        else
            self.TextArea_system:setTextById(content.formatId,unpack(content.param))
            if self.TextArea_system.__richText then
                perfabNode = self.TextArea_system.__richText
            end
            totalWidth = perfabNode:getSize().width
        end
        interval = content.Interval/1000.0 or interval
        speed = content.Mulriple or speed
    else
        self.TextArea_system:setText(content)
        perfabNode = self.TextArea_system
        totalWidth = perfabNode:getSize().width
    end
    perfabNode:Pos(ccp(self.Panel_system:getSize().width, perfabNode:getPositionY()))

    local disx = totalWidth + self.Panel_system:getSize().width
    local time = disx / speed
    perfabNode:stopAllActions()
    local acList = {
        DelayTime:create(interval),
        MoveTo:create(time,ccp(-totalWidth,perfabNode:getPositionY())),
        CCCallFunc:create(function()
            perfabNode:stopAllActions()
            self.isScrolling = false
            table.remove(self.noticeList,1)
            self:showNotice()
        end)
    }
    local seqAc = Sequence:create(acList)
    perfabNode:runAction(seqAc)
end

function NoticeMarQueeLayer:addContent( content )
	table.insert(self.noticeList,content)
	self:showNotice()
end

return NoticeMarQueeLayer