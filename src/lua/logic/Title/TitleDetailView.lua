local TitleDetailView = class("TitleDetailView", BaseLayer)

function TitleDetailView:ctor(titleId)
    self.super.ctor(self)
    self:initData(titleId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.playerInfo.titleDetailView")
end

function TitleDetailView:initData(titleId)
    self.titleId = titleId
    self.titleCfg = TitleDataMgr:getTitleCfg(titleId)
end

function TitleDetailView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    self.Label_percent_title = TFDirector:getChildByPath(ui, "Label_percent_title")
    self.Label_percent = TFDirector:getChildByPath(ui, "Label_percent")
    self.Label_get_desc_title = TFDirector:getChildByPath(ui, "Label_get_desc_title")
    self.Label_get_desc = TFDirector:getChildByPath(ui, "Label_get_desc")
    self.Label_tips = TFDirector:getChildByPath(ui, "Label_tips")
    self.Label_percent_title:setTextById(1326519)
    self.Label_get_desc_title:setTextById(1326520)
    self:updateUI()
end

function TitleDetailView:updateUI()
    self.Label_get_desc:setTextById(self.titleCfg.accessdes)
    self.Label_percent:setDimensions(380, 0)
    self.Label_get_desc:setDimensions(380, 0)

    if self.titleId == 9200106  then
        self.Label_percent:setString(TextDataMgr:getText(1326518))
    elseif self.titleId == 9200107 then
        self.Label_percent:setString(TextDataMgr:getText(1326522))
    else
        if self.titleCfg.relatedTask > 0 then
            local taskCfg  = TaskDataMgr:getTaskCfg(self.titleCfg.relatedTask)
            local taskInfo = TaskDataMgr:getTaskInfo(self.titleCfg.relatedTask)
            local progress = taskInfo and math.min(taskInfo.progress,taskCfg.progress) or 0
            self.Label_percent:setString(progress.."/"..taskCfg.progress)
        else
            self.Label_percent:setString(TextDataMgr:getText(1326518))
        end
    end
    if self.titleCfg.chatShow then
        self.Label_tips:setText(TextDataMgr:getText(1326521)..TextDataMgr:getText(1326514))
    else
        self.Label_tips:setText(TextDataMgr:getText(1326521)..TextDataMgr:getText(1326515))
    end

    self.Label_get_desc_title:setPositionY(self.Label_percent:getPositionY() - self.Label_percent:getContentSize().height - 30)
    self.Label_get_desc:setPositionY(self.Label_percent:getPositionY() - self.Label_percent:getContentSize().height - 30)
    self.Label_tips:setPositionY(self.Label_get_desc:getPositionY() - self.Label_get_desc:getContentSize().height - 30)
end

function TitleDetailView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return TitleDetailView