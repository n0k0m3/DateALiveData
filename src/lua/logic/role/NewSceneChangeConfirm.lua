local NewSceneChangeConfirm =  class("NewSceneChangeConfirm", BaseLayer)

function NewSceneChangeConfirm:initData(confirmCallBack,cancleCallBack)
    self.tipData = {}
    self.confirmCallBack = confirmCallBack
    self.cancleCallBack = cancleCallBack
end

function NewSceneChangeConfirm:ctor(data,confirmCallBack,cancleCallBack)
    self.super.ctor(self)
    self:initData(data,confirmCallBack,cancleCallBack)
    self:init("lua.uiconfig.role.newSceneChangeConfirm")
end

function NewSceneChangeConfirm:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.Button_cancle = TFDirector:getChildByPath(self.ui, "Button_cancel")

    self.Panel_dayScene = TFDirector:getChildByPath(self.ui, "Panel_dayScene")
    self.Panel_nightScene = TFDirector:getChildByPath(self.ui, "Panel_nightScene")
    self.Panel_dayBgm = TFDirector:getChildByPath(self.ui, "Panel_dayBgm")
    self.Panel_nightBgm = TFDirector:getChildByPath(self.ui, "Panel_nightBgm")

    self:groupTipinfo()
end

function NewSceneChangeConfirm:groupTipinfo()

    local curDayCid,curNightCid = SceneSoundDataMgr:getCurSceneCid()
    local daySceneCfg = SceneSoundDataMgr:getMainSceneChange(curDayCid)
    local nightSceneCfg = SceneSoundDataMgr:getMainSceneChange(curNightCid)
    local curBgmCid,curNightBgmCid = SceneSoundDataMgr:getCurSceneBgmId()
    local curSoundCfg = SceneSoundDataMgr:getSoundInfoByCid(curBgmCid)
    local curNightCfg = SceneSoundDataMgr:getSoundInfoByCid(curNightBgmCid)
    local tempDaySceneCid,tempNightSceneCid = SceneSoundDataMgr:getTempSceneCid()

    local strNone = TextDataMgr:getText(100000152 )  --无变动字符id
    local strChangeTo = TextDataMgr:getText(100000153)
    local beforeName = strNone
    local afterName = ""
    if tempDaySceneCid and  tempDaySceneCid ~= curDayCid then
        local afterDayCfg = SceneSoundDataMgr:getMainSceneChange(tempDaySceneCid)
        afterName = TextDataMgr:getText(afterDayCfg.name)
        if daySceneCfg then
            beforeName = "["..TextDataMgr:getText(daySceneCfg.name).."] "..strChangeTo
        else
            beforeName = strChangeTo
        end
    end
    self:updateItem(self.Panel_dayScene,beforeName,afterName)

    beforeName,afterName = strNone,""
    if tempNightSceneCid and tempNightSceneCid ~= curNightCid then
        local afterDayCfg = SceneSoundDataMgr:getMainSceneChange(tempNightSceneCid)
        afterName = TextDataMgr:getText(afterDayCfg.name)
        if nightSceneCfg then
            beforeName = "["..TextDataMgr:getText(nightSceneCfg.name).."] "..strChangeTo
        else
            beforeName = strChangeTo
        end
    end
    self:updateItem(self.Panel_nightScene,beforeName,afterName)

    beforeName,afterName = strNone,""
    local tempDayBgmCid,tempNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
    if tempDayBgmCid and tempDayBgmCid ~= curBgmCid then
        local afterDayCfg = SceneSoundDataMgr:getSoundInfoByCid(tempDayBgmCid)
        afterName = TextDataMgr:getText(afterDayCfg.name)
        if curSoundCfg then
            beforeName = "["..TextDataMgr:getText(curSoundCfg.name).."] "..strChangeTo
        else
            beforeName = strChangeTo
        end
    end
    self:updateItem(self.Panel_dayBgm,beforeName,afterName)

    beforeName,afterName = strNone,""
    if tempNightBgmCid and tempNightBgmCid ~= curNightBgmCid then
        local afterDayCfg = SceneSoundDataMgr:getSoundInfoByCid(tempNightBgmCid)
        afterName = TextDataMgr:getText(afterDayCfg.name)
        if curNightCfg then
            beforeName = "["..TextDataMgr:getText(curNightCfg.name).."] "..strChangeTo
        else
            beforeName = strChangeTo
        end
    end
    self:updateItem(self.Panel_nightBgm,beforeName,afterName)
end

function NewSceneChangeConfirm:updateItem(panle,beforeName,afterName)

    local Label_beforname = TFDirector:getChildByPath(panle, "Label_beforname")
    local Label_aftername = TFDirector:getChildByPath(panle, "Label_aftername")
    Label_beforname:setText(beforeName)
    Label_aftername:setText(afterName)
    local posX = Label_beforname:getPositionX()
    local w = Label_beforname:getContentSize().width
    Label_aftername:setPositionX(posX + w + 2)

end

function NewSceneChangeConfirm:registerEvents()

    self.Button_ok:onClick(function()
        if self.confirmCallBack then
            self.confirmCallBack()
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_cancle:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return NewSceneChangeConfirm
