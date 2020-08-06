local FairySkillInfo = class("FairySkillInfo", BaseLayer)


function FairySkillInfo:ctor(skillId,skillDesc)
    self.super.ctor(self)
    self:initData(skillId,skillDesc)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.fairySkillInfo")
end

function FairySkillInfo:initData(skillId,skillDesc)

	self.skillId = skillId
	self.skillDesc = skillDesc
	if not self.skillId then
		print("no skillId")
		return
	end

	self.skillCfg = TabDataMgr:getData("Skill")[self.skillId]
	if not self.skillCfg then
		self.skillCfg = TabDataMgr:getData("PassiveSkills")[self.skillId]
		if not self.skillCfg then
			self.skillCfg = TabDataMgr:getData("AngelSkillTree")[self.skillId]
			if not self.skillCfg then
				print("wrong skillId",self.skillId)
				return
			else
				self.skillName = TextDataMgr:getText(self.skillCfg.nameId)
				self.skillDes = skillDesc
				self.skillDesc = ""
			end
		else
			self.skillName = TextDataMgr:getText(self.skillCfg.name)
			self.skillDes = TextDataMgr:getText(self.skillCfg.des)
		end
	else
		self.skillName = TextDataMgr:getText(self.skillCfg.name)
		self.skillDes = TextDataMgr:getText(self.skillCfg.des)
	end

end

function FairySkillInfo:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self:showTopBar()

	self.Button_cancel 		= TFDirector:getChildByPath(ui, "Button_cancel")
	self.Label_title   		= TFDirector:getChildByPath(ui, "Label_title")
	self.Image_skillIcon 	= TFDirector:getChildByPath(ui, "Image_skillIcon")
	self.Label_skillName 	= TFDirector:getChildByPath(ui, "Label_skillName")
	self.Label_skillfeature = TFDirector:getChildByPath(ui, "Label_skillfeature")
	self.Label_skilleffect 	= TFDirector:getChildByPath(ui, "Label_skilleffect")
	self.Label_skilldesc 	= TFDirector:getChildByPath(ui, "Label_skilldesc"):hide()
	self.Label_skilleffectTitle = TFDirector:getChildByPath(ui, "Label_skilleffectTitle")
	local ScrollView_desc 	= TFDirector:getChildByPath(ui, "ScrollView_desc")
	self.ListView_desc = UIListView:create(ScrollView_desc)

	self:initUILogic()
end

function FairySkillInfo:initUILogic()

	if not self.skillCfg then
		return
	end

	self.Label_title:setTextById(800077)
	self.Label_skilleffectTitle:setTextById(800078)
	self.Image_skillIcon:setTexture(self.skillCfg.icon)
	self.Label_skillName:setText(self.skillName)
	self.Label_skillfeature:setString("")
	--self.Label_skilldesc:setTextById(self.skillCfg.des)
	self.Label_skilleffect:setString(self.skillDesc)

	local size = self.ListView_desc:getContentSize()
    local Label_content = self.Label_skilldesc:clone():Show()
    Label_content:setText(self.skillDes)
    Label_content:setDimensions(size.width, 0)
    self.ListView_desc:pushBackCustomItem(Label_content)

end


function FairySkillInfo:registerEvents()

	self.Button_cancel:onClick(function()
        AlertManager:closeLayer(self)
    end)

end

return FairySkillInfo
