local KsOutbountCampChooseView = class("KsOutbountCampChooseView",BaseLayer)

function KsOutbountCampChooseView:initData()
    
end

function KsOutbountCampChooseView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.activity.ksOutbountCampChooseView")
end

function KsOutbountCampChooseView:initUI(ui)
    self.super.initUI(self, ui)

    local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    local strName = {3006604 , 3006605 , 3006606}
    for k,i in pairs(activityInfo.extendData.campChose) do
        local camp = self._ui[string.format( "camp%d",i)]
        local campBtn = camp:getChildByName(string.format("btnCamp%d",i))
        camp:setTexture(string.format("ui/activity/kuangsan_fuben/pop/boss_%d.png",i))
        campBtn:setTextureNormal(string.format("ui/activity/kuangsan_fuben/pop/bossBtn_%d.png",i))
        campBtn:setTexturePressed(string.format("ui/activity/kuangsan_fuben/pop/bossBtn_%d.png",i))
        campBtn:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_REQ_KURUMI_CAMP(i)
            AlertManager:closeLayer(self)
        end)
        local label_empyTetx = TFLabel:create()
        label_empyTetx:setFontName("font/MFLiHei_Noncommercial.ttf")
        label_empyTetx:setFontSize(18)
        label_empyTetx:setTextAreaSize(CCSize(180 , 0))
        label_empyTetx:setAnchorPoint(ccp(0.5 , 0.5))
        label_empyTetx:setPosition(45 , -180)
        label_empyTetx:setFontColor(ccc3(111 , 30 , 33))
        label_empyTetx:setTextById(strName[i])
        label_empyTetx:setRotation(-12)
        --self.label_empyTetx:enableOutline(ccc4(0,0,0,255), 1)

        camp:addChild(label_empyTetx , 1)
    end  
end

function KsOutbountCampChooseView:refreshCampTexture()
   
end

function KsOutbountCampChooseView:registerEvents()
    self._ui.pannel_touch:setTouchEnabled(false)
    self._ui.pannel_touch:onClick(function()
        -- AlertManager:closeLayer(self)
    end)
end

return KsOutbountCampChooseView