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

local CommonRedPacketDetailView = class("CommonRedPacketDetailView", BaseLayer)

function CommonRedPacketDetailView:initData(redPacketData)
    self.redPacketData = redPacketData
end

function CommonRedPacketDetailView:ctor(redPacketData)
    self.super.ctor(self)
    self:initData(redPacketData)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.commonRedPacketDetailView")
end

function CommonRedPacketDetailView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_base = TFDirector:getChildByPath(ui, "Panel_base")
    self.Panel_content = TFDirector:getChildByPath(ui, "Panel_content")
    self.Panel_get_item = TFDirector:getChildByPath(ui, "Panel_get_item")
    self.Label_zhufuyu = TFDirector:getChildByPath(self.Panel_base, "Label_zhufuyu")
    self.Label_get_num = TFDirector:getChildByPath(self.Panel_base, "Label_get_num")
    self.Image_head = TFDirector:getChildByPath(self.Panel_base, "Image_head")
    self.Image_head_frame_cover = TFDirector:getChildByPath(self.Panel_base, "Image_head_frame_cover")
    self.Label_player_name = TFDirector:getChildByPath(self.Panel_base, "Label_player_name")
    local ScrollView_list = TFDirector:getChildByPath(self.Panel_content, "ScrollView_list")

    local Image_scrollBar = TFDirector:getChildByPath(self.Panel_base, "Image_scrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
    self.ScrollView_list = UIListView:create(ScrollView_list)
    self.ScrollView_list:setItemsMargin(2)
    local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)
    self.ScrollView_list:setScrollBar(scrollBar)

    self.Button_send = TFDirector:getChildByPath(self.Panel_base, "Button_send")

    self:refreshView()
end

function CommonRedPacketDetailView:refreshView()
    self.Button_send:setVisible(self.redPacketData.senderId == MainPlayer:getPlayerId())
    local itemCfg = GoodsDataMgr:getItemCfg(self.redPacketData.moneyTempId)
    local getCount = self.redPacketData.record and #self.redPacketData.record or 0
    self.Label_get_num:setText(getCount.."/"..self.redPacketData.count)

    self.Label_player_name:setText(self.redPacketData.senderName)
    self.Image_head:setTexture(AvatarDataMgr:getAvatarIconPath(self.redPacketData.senderPortraitCid))
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(self.redPacketData.senderPortraitFrameCid)
    self.Image_head_frame_cover:setTexture(avatarFrameIcon)
    if avatarFrameEffect ~= "" then
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
        if not self.HeadFrameEffect then
            self.HeadFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
            self.HeadFrameEffect:setAnchorPoint(ccp(0,0))
            self.HeadFrameEffect:setPosition(ccp(0,0))
            self.HeadFrameEffect:play("animation", true)
            self.Image_head_frame_cover:addChild(self.HeadFrameEffect, 1)
        end
    else
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
    end

    self.ScrollView_list:removeAllItems()

    

    if self.redPacketData.record then
		for k,v in pairs(self.redPacketData.record) do
	        if tonumber(v.playerId) == MainPlayer:getPlayerId() then
	            table.remove(self.redPacketData.record,k)
	            table.insert(self.redPacketData.record, 1, v)
				break
	        end
	    end
        for i = 1,20 do
            if self.redPacketData.record[i] then
				local v = self.redPacketData.record[i]
                local item = self.Panel_get_item:clone()
                local Image_head = TFDirector:getChildByPath(item, "Image_head")
                local Image_head_frame = TFDirector:getChildByPath(item, "Image_head_frame")
                local Image_head_frame_cover = TFDirector:getChildByPath(item, "Image_head_frame_cover")
                local Label_player_name = TFDirector:getChildByPath(item, "Label_player_name")
                local Label_get_time = TFDirector:getChildByPath(item, "Label_get_time")
                local Image_res = TFDirector:getChildByPath(item, "Image_res")
                local Label_get_num = TFDirector:getChildByPath(item, "Label_get_num")
                Image_head:setTexture(AvatarDataMgr:getAvatarIconPath(v.portraitCid))

                local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(v.portraitFrameCid)
                Image_head_frame_cover:setTexture(avatarFrameIcon)
                local headFrameEffect = Image_head_frame_cover:getChildByName("headFrameEffect")
                if headFrameEffect then
                    headFrameEffect:removeFromParent()
                end
                if avatarFrameEffect ~= "" then
                    headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
                    headFrameEffect:setAnchorPoint(ccp(0,0))
                    headFrameEffect:setPosition(ccp(0,0))
                    headFrameEffect:play("animation", true)
                    headFrameEffect:setName("headFrameEffect")
                    Image_head_frame_cover:addChild(headFrameEffect, 1)
                end

                Label_player_name:setText(v.playerName)
                Image_res:setTexture(itemCfg.icon)
                Label_get_num:setText(v.openCount)
                local timeData = Utils:getTimeData(v.createTime)
                local timeStr = ""
                timeStr = timeStr..string.format("%.2d", timeData.Hour)..":"..string.format("%.2d", timeData.Minute)..":"..string.format("%.2d", timeData.Second)
                Label_get_time:setText(timeStr)
                self.ScrollView_list:pushBackCustomItem(item)
            end
        end
    end
end


function CommonRedPacketDetailView:registerEvents()
    self.Button_send:onClick(function()
        AlertManager:closeLayer(self)
        Utils:openView("redPack.CommonRedPack")
    end)
end

return CommonRedPacketDetailView
