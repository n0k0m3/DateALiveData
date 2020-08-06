
local BeforeEvloutionShowView = class("BeforeEvloutionShowView", BaseLayer)

--[[
    --@_data: {
        [1]:图片纹理
        [2]:数量
        [3]:精灵id
    }
]]
function BeforeEvloutionShowView:ctor(_data)
    self.super.ctor(self, _data)

    self:initData()
    self:showPopAnim(true)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.fairyNew.beforeRoleEvlutionShow")
end

function BeforeEvloutionShowView:initData()
    local str = string.split(self.data[2], "/")
    self.currentNum = tonumber(str[1])
    self.needNum    = tonumber(str[2])
    
    self.roleId     = self.data[3]
    self.costId     = HeroDataMgr:getProgressNeed(self.roleId)[1]

    local heroConfig = HeroDataMgr:getHeroInfoByID(self.roleId)
    local lv         = HeroDataMgr:getLv(self.roleId);
    local progressId = heroConfig.attribute * 100  + heroConfig.quality
    local oldGr      = TabDataMgr:getData("HeroProgress",progressId).upAttr

    self.oldQuality  =  heroConfig.quality
    self.dataOld     = {math.floor(oldGr[EC_Attr.ATK]  / 100),
                        math.floor(oldGr[EC_Attr.DEF]  / 100),
                        math.floor(oldGr[EC_Attr.HP]  / 100),
                        math.floor(heroConfig.attr[EC_Attr.ATTR_SKILL_POINT] / 100) }

    local progressIdNew  = heroConfig.attribute * 100  + self.oldQuality + 1
    local function getSkillPointId(progressId)
        return math.floor(TabDataMgr:getData("HeroProgress",progressId).baseAttr[EC_Attr.ATTR_SKILL_POINT] / 100)
    end
    local disSkillPoint  = getSkillPointId(progressIdNew) - getSkillPointId(progressId)
    local curGr          = TabDataMgr:getData("HeroProgress",progressIdNew).upAttr
    self.dataNew         = {math.floor(curGr[EC_Attr.ATK]  / 100),
                            math.floor(curGr[EC_Attr.DEF]  / 100),
                            math.floor(curGr[EC_Attr.HP]   / 100),
                            disSkillPoint + self.dataOld[4] }
end

function BeforeEvloutionShowView:initUI(ui)
    self.super.initUI(self,ui)

    self._ui.Image_old_level:setTexture(HeroDataMgr:getQualityPic(self.roleId))
    self._ui.Image_new_level:setTexture(HeroDataMgr:getQualityPic(self.roleId, self.oldQuality + 1))

    self:setRoleAttributeTxt(self._ui.Pannel_OldNature, self.dataOld)
    self:setRoleAttributeTxt(self._ui.Pannel_NewNature, self.dataNew)
    
    self._ui.Image_unlock_item_icon:setTexture(self.data[1])
    self._ui.Label_unlock_item_count:setString(self.data[2])
    if self.currentNum >= self.needNum then 
        self._ui.Label_unlock_item_count:setColor(ccc3(255,255,255))
        self._ui.Lab_evloution:setTextById(100000056)
    else
        self._ui.Label_unlock_item_count:setColor(ccc3(220,20,60))
        self._ui.Lab_evloution:setTextById(100000055)
    end

end

function BeforeEvloutionShowView:setRoleAttributeTxt(node, data)
    for i, linePannel in  ipairs(node:getChildren()) do
        -- local icon    = linePannel:getChildByName("TypeBg")
        -- local discTxt = linePannel:getChildByName("LabDisc")
        local numTxt  = linePannel:getChildByName("LabNum")

        numTxt:setString(data[i])
    end
end

function BeforeEvloutionShowView:registerEvents()

    self._ui.BtnClose:onClick(function()
        AlertManager:closeLayer(self)
    end)
    
    self._ui.Btn_evloution:onClick(function(sender)
        if self.currentNum >= self.needNum then 
            HeroDataMgr:heroProgress(self.roleId)
            AlertManager:closeLayer(self)
        else
            Utils:showAccess(self.costId)
        end
    end)
end 

return BeforeEvloutionShowView