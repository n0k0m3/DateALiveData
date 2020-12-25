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

local CommonOpenRedPacketView = class("CommonOpenRedPacketView", BaseLayer)

function CommonOpenRedPacketView:initData(redPacketData)
    self.redPacketData = redPacketData
end

function CommonOpenRedPacketView:ctor(redPacketData)
    self.super.ctor(self)
    self:initData(redPacketData)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.commonOpenRedPacketView")
end

function CommonOpenRedPacketView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_base = TFDirector:getChildByPath(ui, "Panel_base")
    self.Panel_content = TFDirector:getChildByPath(ui, "Panel_content")

    self.Label_zhufuyu = TFDirector:getChildByPath(self.Panel_content, "Label_zhufuyu")
    self.Image_res_big = TFDirector:getChildByPath(self.Panel_content, "Image_res_big")
    self.Image_res = TFDirector:getChildByPath(self.Panel_content, "Image_res")
    self.Label_num = TFDirector:getChildByPath(self.Panel_content, "Label_num")
    self.Image_head = TFDirector:getChildByPath(self.Panel_content, "Image_head")
    self.Image_head_frame_cover = TFDirector:getChildByPath(self.Panel_content, "Image_head_frame_cover")
    self.Label_player_name = TFDirector:getChildByPath(self.Panel_content, "Label_player_name")

    self.Button_check = TFDirector:getChildByPath(self.Panel_content, "Button_check")

    self:refreshView()
end

function CommonOpenRedPacketView:refreshView()
    local itemCfg = GoodsDataMgr:getItemCfg(self.redPacketData.moneyTempId)

    self.Label_zhufuyu:setText(self.redPacketData.blessing)
    if string.match(self.redPacketData.blessing,"^[1-9]*") ~= "" then
        self.Label_zhufuyu:setTextById(tonumber(self.redPacketData.blessing))
    end

    self.Image_res_big:setTexture(itemCfg.icon)
    self.Image_res:setTexture(itemCfg.icon)
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

    local num = 0
    if self.redPacketData.record then 
        for k, v in pairs(self.redPacketData.record) do
            if tonumber(v.playerId) == MainPlayer:getPlayerId() then
                num = v.openCount
                break
            end
        end
    end
    self.Label_num:setText("x"..num)
end


function CommonOpenRedPacketView:registerEvents()
    self.Button_check:onClick(function()
        AlertManager:closeLayer(self)
        Utils:openView("redPack.CommonRedPacketDetailView", self.redPacketData)
    end)
end

return CommonOpenRedPacketView
