local AngelAwakenResult = class("AngelAwakenResult", BaseLayer)


function AngelAwakenResult:ctor(data)
    self.super.ctor(self,data)
    self.heroid = data[1];
    self.oldSkillPoint = data[2]
    self:init("lua.uiconfig.angel.angelWakenResult")
end

function AngelAwakenResult:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	AngelAwakenResult.ui = ui

	local curLv = HeroDataMgr:getAngelLevel(self.heroid);
	local oldLv = curLv - 1;

	for i=1,5 do
		local oldStar = TFDirector:getChildByPath(ui,"old_star"..i);
		local newStar = TFDirector:getChildByPath(ui,"new_star"..i);

		oldStar:setVisible(i<=oldLv);
		newStar:setVisible(i<=curLv);
	end

	local slotOld = TFDirector:getChildByPath(ui,"Label_slotOld")
	local slotNew = TFDirector:getChildByPath(ui,"Label_slotNew")
	slotOld:setText(oldLv - 1)
	slotNew:setText(oldLv)

	local lvOld = TFDirector:getChildByPath(ui,"Label_lvOld")
	local lvNew = TFDirector:getChildByPath(ui,"Label_lvNew")
	lvOld:setText(oldLv)
	lvNew:setText(curLv)

	local juexingIcon = TFDirector:getChildByPath(ui,"Image_old_icon")
	local skillid = HeroDataMgr:getSkinAngleSkillID(self.heroid,EC_SKILL_TYPE.JUEXING)
	local skillInfo = TabDataMgr:getData("Skill",skillid)
	juexingIcon:setTexture(skillInfo.icon)


	local heroPassiveConfig = AngelDataMgr:getPassiveSkillConfig(self.heroid)
	local idx = 1
    for i=1, 16 do
        local config = heroPassiveConfig[i]
        local needAngelLv = config.needAngelLvl
        if needAngelLv == curLv then
        	local icon = TFDirector:getChildByPath(ui,"Image_skIcon" .. idx)
        	icon:setTexture(config.icon)
        	local name = TFDirector:getChildByPath(ui,"skillName" .. idx)
        	name:setTextById(config.nameId)
        	idx = idx + 1
        	if idx > 4 then
        		break
        	end
        end   
    end
	
	self.ui:setTouchEnabled(true);
	self.ui:onClick(function()
			AlertManager:closeLayer(self)
		end)

	local Spine_title = TFDirector:getChildByPath(ui,"Spine_title")
	Spine_title:play("chuxian" , false)
	Spine_title:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:play("xunhuan" , true)
    end)
end

function AngelAwakenResult:onHide()
	self.super.onHide(self)
end

function AngelAwakenResult:removeUI()
	self.super.removeUI(self)
end

function AngelAwakenResult:onShow()
	self.super.onShow(self)
	-- self.ui:runAnimation("Action0",1);

	-- local delay = CCDelayTime:create(0.3);
	-- local callfunc = CCCallFunc:create(function()
	-- 		self.ui:runAnimation("Action1",-1);
	-- 	end
	-- 	)
	
	-- self:runAction(CCSequence:create({delay,callfunc}));
	

end


return AngelAwakenResult;
