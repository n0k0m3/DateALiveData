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
* -- 新邮件提示界面
]]

local MailNoticeLayer = class("MailNoticeLayer",BaseLayer)

function MailNoticeLayer:ctor( data, callBack )
	-- body
	self.super.ctor(self,data)
	self.mailInfo = data
	self.callBack = callBack
	self:init("lua.uiconfig.mail.mailNoticeLayer")
end

function MailNoticeLayer:initUI( ui )
	self.super.initUI(self,ui)

	self.Panel_mail = TFDirector:getChildByPath(ui,"Panel_mail")
	self.btn_qiangHongBao = TFDirector:getChildByPath(ui,"btn_qiangHongBao")
	self.Image_head = TFDirector:getChildByPath(ui,"Image_head")
	self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
	self.Label_text = TFDirector:getChildByPath(ui,"Label_text")

	self.Label_title:setText(self.mailInfo.title)
	self.Label_text:setText(self.mailInfo.body)
    -- self.btn_qiangHongBao:onClick(function ( ... )
    --     MailDataMgr:fightEnvelope(self.mailInfo.id)
    -- end)
    self.btn_qiangHongBao:setVisible(self.mailInfo.status == 1)
    self.btn_qiangHongBao:setTouchEnabled(false)
    self.Panel_mail:onClick(function ( ... )
        self.Panel_mail:stopAllActions()
        local spawnAct1 = CCSpawn:create({
            CCFadeOut:create(0.5),
            CCMoveBy:create(0.5,ccp(0, 100)),
        })

        local seqAct = Sequence:create({
        spawnAct1,
        CCCallFunc:create(function()
                if self.callBack then
                    self.callBack()
                end
            end)
        })
        self.Panel_mail:runAction(seqAct)
        if self.mailInfo.status == 1 then
            MailDataMgr:fightEnvelope(self.mailInfo.id)
        end
    end)
    self.Panel_mail:setTouchEnabled(true)
	self:playAni(  )
end

function MailNoticeLayer:playAni(  )
	self.Panel_mail:stopAllActions()
    self.Panel_mail:setVisible(true)
    self.Panel_mail:setOpacity(0)
    local spawnAct = CCSpawn:create({
        CCFadeIn:create(0.5),
        CCMoveBy:create(0.5,ccp(0, -100)),
    })
	local spawnAct1 = CCSpawn:create({
        CCFadeOut:create(0.5),
        CCMoveBy:create(0.5,ccp(0, 100)),
    })

    local seqAct = Sequence:create({
        spawnAct,
        CCDelayTime:create(5),
        spawnAct1,
        CCCallFunc:create(function()
        	if self.callBack then
	            self.callBack()
	        end
        end)
    })
    self.Panel_mail:runAction(seqAct)
end

return MailNoticeLayer