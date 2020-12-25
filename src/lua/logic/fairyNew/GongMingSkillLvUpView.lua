local GongMingSkillLvUpView = class("GongMingSkillLvUpView", BaseLayer)


function GongMingSkillLvUpView:ctor(cid)
    self.super.ctor(self)
    self.gmSkillCid = cid
    self:init("lua.uiconfig.fairyNew.gongmingLvUpView")
end

function GongMingSkillLvUpView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    local old_lv 		= TFDirector:getChildByPath(ui,"old_lv")
    local cur_lv 		= TFDirector:getChildByPath(ui,"cur_lv")
    local old_desc      = TFDirector:getChildByPath(ui,"old_desc")
    local cur_desc      = TFDirector:getChildByPath(ui,"cur_desc")
    local Image_to2     = TFDirector:getChildByPath(ui,"Image_to2")

    old_desc:setText("")
    cur_desc:setText("")

    self.Spine_break_up = TFDirector:getChildByPath(ui, "Spine_break_up")

    local lv = ResonanceDataMgr:getSkillLv(self.gmSkillCid)
    local lastLv = lv - 1
    old_lv:setString("Lv"..lastLv)
    cur_lv:setString("Lv"..lv)

    local posX = lastLv <= 0 and 441 or 642
    cur_desc:setPositionX(posX)

    Image_to2:setVisible(lastLv > 0)

    local curpassiveSkillId = ResonanceDataMgr:getPassiveSkillId(self.gmSkillCid,lv)
    if curpassiveSkillId then
        local curCfg = ResonanceDataMgr:getPassiveSkillCfg(curpassiveSkillId)
        if curCfg then
            cur_desc:setTextById(curCfg.des)
        end
    end
    local lastpassiveSkillId = ResonanceDataMgr:getPassiveSkillId(self.gmSkillCid,lastLv)
    if lastpassiveSkillId then
        local curCfg = ResonanceDataMgr:getPassiveSkillCfg(lastpassiveSkillId)
        if curCfg then
            old_desc:setTextById(curCfg.des)
        end
    end

    self.Spine_break_up:play("chuxian",false)
    self.Spine_break_up:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_break_up:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_break_up:play("xunhuan",true)
        end, 0)
    end)

    self:timeOut(function()
        self.ui:setTouchEnabled(true)
        self.ui:onClick(function()
            AlertManager:closeLayer(self)
        end)
    end, 1)
end

return GongMingSkillLvUpView;
