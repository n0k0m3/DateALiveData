local BattleGuide = BattleGuide or {}
local KeyStateMgr = import(".KeyStateMgr")
local ResLoader      = import(".ResLoader")
local AIAgent      = import(".AIAgent")
local enum  = import(".enum")
local eVKeyCode = enum.eVKeyCode
function BattleGuide:clear()
	self.keyboard = {}
	self.directCtrl = nil
	self.battleMap = nil
	self.guidePanel = nil
	self.tarPosAnim = nil
	self.tarMonsterAnim = nil
	self.skillKeyBG = nil
	self.guideStart = false
	self.guideStatus = {idx = 0,progress = 1}
	self:resetData()
end

function BattleGuide:isGuideStart()
	return self.guideStart
end

function BattleGuide:registCtrlKey(keycode,ctrlnode)
	self.keyboard[keycode] = {ctrl = ctrlnode,show = false,bindAnim = nil,isShow = false}
end

function BattleGuide:registCtrlKeyBG(node)
	self.skillKeyBG = node
	local curlevelId = BattleDataMgr:getCurLevelCid()
	if curlevelId ~= 101101 then
		return
	end
    if FubenDataMgr:isPassPlotLevel(curlevelId) == false then
    	self.skillKeyBG:setVisible(false)
    end
end

function BattleGuide:updateKeyShowStat(keycode,isShow)
	self.keyboard[keycode].isShow = isShow
end

function BattleGuide:getGuideKeyEnable(keycode)
	return self.keyboard[keycode].show
end

function BattleGuide:registDirectCtrl(directCtrl) --方向控制 --摇杆
	self.directCtrl = directCtrl
end

function BattleGuide:registBattleMap(bmap)
	self.battleMap = bmap
end

function BattleGuide:registController(controller)
	self.battleController = controller
end

function BattleGuide:onCtrlKeyClicked(skillCode)
	local keycode = eVKeyCode["SKILL_"..skillCode]
	if self.guideStatus.keycode == keycode then
		if self.guideStatus.progress == 2 then
			self.guideStatus.progress = self.guideStatus.progress + 1
			return
		end
	end
	if self.guideStatus.equalCode then
		for k,v in pairs(self.guideStatus.equalCode) do
			if v == keycode then
				if self.guideStatus.progress == 2 then
					self.guideStatus.progress = self.guideStatus.progress + 1
					return
				end
			end
		end
	end
end

function BattleGuide:onDirectTouch()
	if self.directCtrl.guideAnim then
		self.directCtrl.guideAnim:removeMEListener(TFARMATURE_COMPLETE)
		self.directCtrl.guideAnim:stop()
		self.directCtrl.guideAnim:removeFromParent()
		self.directCtrl.guideAnim = nil
	end
end

function BattleGuide:registGuidePanel(gpanel)
	self.guidePanel = gpanel
	self.guidePanel:setVisible(true)
	self.img_guide_tip = self.guidePanel:getChildByName("Image_guide_bg")
	self.img_guide_tip:setVisible(false)
end
function BattleGuide:resetData()
	self.guideCfg = {}
	local cfg = TabDataMgr:getData("BattleGuideStep")
	for k,v in pairs(cfg) do
		self.guideCfg[v.guideId] = v
	end
	self.guideStatus = {idx = 1,progress = 1}
end

function BattleGuide:runGuide(gid,callback)
	if gid == 1 then
		Utils:sendHttpLog("numerical_fight_P")
	end
    self.guideStart = false
	for k,v in pairs(self.keyboard) do
		if v.bindAnim then
			v.bindAnim:removeMEListener(TFARMATURE_COMPLETE)
			v.bindAnim:stop()
			v.bindAnim:removeFromParent()
			v.bindAnim = nil
		end
	end
	if self.directCtrl.guideAnim then
		self.directCtrl.guideAnim:removeMEListener(TFARMATURE_COMPLETE)
		self.directCtrl.guideAnim:stop()
		self.directCtrl.guideAnim:removeFromParent()
		self.directCtrl.guideAnim = nil
	end
	if self.tarPosAnim and self.tarPosAnim.isRemoving == false then
		local actArr = {FadeOut:create(0.5),CallFunc:create(function( ... )
					self.tarPosAnim.bottomAnim:stop()
					self.tarPosAnim.bottomAnim:removeFromParent()
					self.tarPosAnim.bottomAnim = nil
					self.tarPosAnim:removeMEListener(TFARMATURE_COMPLETE)
					self.tarPosAnim:stop()
					self.tarPosAnim:removeFromParent()
					self.tarPosAnim = nil
				end)}
		self.tarPosAnim.isRemoving = true
		self.tarPosAnim:runAction(Sequence:create(actArr))
	end
	self.guideStatus = {idx = gid,progress = 1}
	self.callback = callback
	self.guideStart = true
end

function BattleGuide:endGuide()
	-- self.guideStart = false
	self.skillKeyBG:setVisible(true)
	if self.callback then
		self.callback()
		self.callback = nil
	end
end

function BattleGuide:update(dt)
	if self.guideStart == false then
		return
	end
	for k,v in pairs(self.keyboard) do
		v.ctrl:setVisible(v.show and v.isShow)
	end
	local curGuideCfg = self.guideCfg[self.guideStatus.idx]
	if curGuideCfg then
		self.skillKeyBG:setVisible(curGuideCfg.showKeyBG == 1)
	end
	if self.guideStatus.progress == 1 then
		if curGuideCfg == nil then
			for k,v in pairs(self.keyboard) do
				v.show = true
				v.ctrl:setVisible(v.show and v.isShow)
			end
			self.guideStart = false
			self.skillKeyBG:setVisible(true)
			return
		end
		for k,v in pairs(self.keyboard) do
			v.show = false
			v.ctrl:setVisible(v.show and v.isShow)
		end
		for k,v in pairs(curGuideCfg.skillShowList) do
			local keycode = eVKeyCode["SKILL_"..v]
			local tmkey = self.keyboard[keycode]
			tmkey.show = true
			tmkey.ctrl:setVisible(tmkey.show and tmkey.isShow)
		end
		
		self.guideStatus.guideType = curGuideCfg.guideType
		local tipstr = curGuideCfg.tip
		if tipstr == 0 then
			tipstr = curGuideCfg.tmtip
		end
		if self.guideStatus.guideType == 1 then
			local tarpos = me.p(curGuideCfg.tarpos[1][1],curGuideCfg.tarpos[1][2])
			local localSize = me.size(curGuideCfg.tarpos[2][1],curGuideCfg.tarpos[2][2])
			local animScale = curGuideCfg.tarpos[3]
			self.guideStatus.tarpos = tarpos
			self.guideStatus.tarsize = localSize
			self.guideStatus.tarscale = animScale
			self:makeMoveTarAnim(tarpos,localSize,animScale,tipstr)
			self.guideStatus.progress = self.guideStatus.progress + 1
		elseif self.guideStatus.guideType == 2 then
			local keycode = eVKeyCode["SKILL_A"]
			-- if self.keyboard[keycode].ctrl:isTouchEnabled() then
			self.guideStatus.keycode = keycode
			local equalCode = {}
			for k,v in pairs(curGuideCfg.equalCode) do
				equalCode[#equalCode + 1] = eVKeyCode["SKILL_"..v]
			end
			self.guideStatus.equalCode = equalCode
			self:makeAttackTouchAnim(tipstr)
			self.guideStatus.progress = self.guideStatus.progress + 1
			-- end
		elseif self.guideStatus.guideType == 3 then
			local keycode = eVKeyCode["SKILL_"..curGuideCfg.skillCode]
			if self.keyboard[keycode].ctrl:isTouchEnabled() then
				local equalCode = {}
				for k,v in pairs(curGuideCfg.equalCode) do
					equalCode[#equalCode + 1] = eVKeyCode["SKILL_"..v]
				end
				self.guideStatus.keycode = keycode
				self.guideStatus.equalCode = equalCode
				self:makeSkillTouchAnim(keycode,tipstr)
				self.guideStatus.progress = self.guideStatus.progress + 1
			end
		else

		end
		return
	end
	if self.guideStatus.progress == 2 then
		if self.guideStatus.guideType == 1 then
			self:updateMoveToPos()
		elseif self.guideStatus.guideType == 2 then
			self:updateAttckStat()
		elseif self.guideStatus.guideType == 3 then
			self:updateSkillStat()
		else

		end
		return
	end
	if self.guideStatus.progress == 3 then
		if self.guideStatus.keycode then
			local guideAnim = self.keyboard[self.guideStatus.keycode].bindAnim
			if guideAnim then
				guideAnim:removeMEListener(TFARMATURE_COMPLETE)
				guideAnim:stop()
				guideAnim:removeFromParent()
				self.keyboard[self.guideStatus.keycode].bindAnim = nil
			end
			self.guideStatus.keycode = nil
		end
		-- local previdx = self.guideStatus.idx
		-- self.guideStatus = {idx = previdx,progress = 1}
		self.img_guide_tip:setVisible(false)
		self.guideStatus.progress = self.guideStatus.progress + 1
		self:endGuide()
	end
end

function BattleGuide:updateMoveToPos()
	if self.tarPosAnim == nil or self.tarPosAnim.isRemoving == true then
		return
	end	
	if self.battleController then
		local mainrole = self.battleController.getCaptain()
		if mainrole and mainrole.actor then
			local curpos = mainrole:getPosition()
			local tarpos = self.guideStatus.tarpos
			local tarsize = self.guideStatus.tarsize
			-- local dots = {
			-- 	[1] = me.p(-(tarsize.width/2) + tarpos.x,-(tarsize.height/2) + tarpos.y),
			-- 	[2] = me.p((tarsize.width/2) + tarpos.x,-(tarsize.height/2) + tarpos.y),
			-- 	[3] = me.p((tarsize.width/2) + tarpos.x,(tarsize.height/2) + tarpos.y),
			-- 	[4] = me.p(-(tarsize.width/2) + tarpos.x,(tarsize.height/2) + tarpos.y),
			-- }
			-- local isIn = me.pIsLineIntersect(dots[1], dots[2], dots[3], dots[4], curpos, curpos)
			local isIn = false
			if (curpos.x > -(tarsize.width/2) + tarpos.x) and 
				(curpos.x < (tarsize.width/2) + tarpos.x) and 
				(curpos.y > -(tarsize.height/2) + tarpos.y) and 
				(curpos.y < (tarsize.height/2) + tarpos.y) then
				isIn = true
			end
			if isIn == true then
				local actArr = {FadeOut:create(0.5),CallFunc:create(function( ... )
					self.tarPosAnim.bottomAnim:stop()
					self.tarPosAnim.bottomAnim:removeFromParent()
					self.tarPosAnim.bottomAnim = nil
					self.tarPosAnim:removeMEListener(TFARMATURE_COMPLETE)
					self.tarPosAnim:stop()
					self.tarPosAnim:removeFromParent()
					self.tarPosAnim = nil
				end)}
				self.tarPosAnim.isRemoving = true
				self.guideStatus.progress = self.guideStatus.progress + 1
				self.tarPosAnim:runAction(Sequence:create(actArr))
			end
		end
	end
end

function BattleGuide:updateSkillStat()
	
end

function BattleGuide:updateAttckStat()
	
end

function BattleGuide:makeMoveTarAnim(pos,tsize,tscale,tip)
	if self.tarPosAnim == nil then
		local skeletonNode = ResLoader.createEffect("effect_guide_02",1)
	    skeletonNode:play("shang", -1)
		self.battleMap:addObject(skeletonNode,3)
		self.tarPosAnim = skeletonNode

		local bottomSkelet = ResLoader.createEffect("effect_guide_02",1)
		bottomSkelet:play("xia", -1)
		self.battleMap:addObject(bottomSkelet,1)
		bottomSkelet:setPosition(pos)
		bottomSkelet:setScale(tscale)
		self.tarPosAnim.bottomAnim = bottomSkelet
	end
	self.tarPosAnim:setPosition(pos)
	self.tarPosAnim:setScale(tscale)
	self.tarPosAnim:setVisible(true)
	self.tarPosAnim.isRemoving = false

	if self.directCtrl.guideAnim == nil then
		local skeletonNode = ResLoader.createEffect("effect_guide_01",1)
		self.guidePanel:addChild(skeletonNode)
		self.directCtrl.guideAnim = skeletonNode
	end
	local keypos = self.directCtrl:getPosition()
	local worldpos = self.directCtrl:getParent():convertToWorldSpace(keypos)
	local animpos = self.guidePanel:convertToNodeSpace(worldpos)
	self.directCtrl.guideAnim:setPosition(animpos)
	self:playMoveAnim(self.directCtrl.guideAnim)
	self:fitchGuideTip(tip)
end

function BattleGuide:fitchGuideTip(tip)
	self.img_guide_tip:stopAllActions()
	self.img_guide_tip:getChildByName("Label_guide_tip"):setString(tip)
	local labelsize = self.img_guide_tip:getChildByName("Label_guide_tip"):getContentSize()
	local labelpos = self.img_guide_tip:getChildByName("Label_guide_tip"):getPosition()
	local img_tip_width = labelpos.x + labelsize.width + 20
	local cur_img_tip_size = self.img_guide_tip:getContentSize()
	local cur_img_tip_pos = self.img_guide_tip:getPosition()
	cur_img_tip_size.width = img_tip_width
	self.img_guide_tip:setContentSize(cur_img_tip_size)
	self.img_guide_tip:setPosition(me.p(693-img_tip_width/2,cur_img_tip_pos.y))
	self.img_guide_tip:setVisible(true)
end


function BattleGuide:makeMonsterTarAnim(monster)

end

function BattleGuide:makeSkillTouchAnim(keycode,tip)
	if self.keyboard[keycode].bindAnim == nil then
		local skeletonNode = ResLoader.createEffect("effect_guide_01",1)
		self.guidePanel:addChild(skeletonNode)
		self.keyboard[keycode].bindAnim = skeletonNode
	end
	local tmkey = self.keyboard[keycode]
	tmkey.show = true
	tmkey.ctrl:setVisible(tmkey.show and tmkey.isShow)
	local pos = self.keyboard[keycode].ctrl:getPosition()
	local worldpos = self.keyboard[keycode].ctrl:getParent():convertToWorldSpace(pos)
	local animpos = self.guidePanel:convertToNodeSpace(worldpos)
	self.keyboard[keycode].bindAnim:setPosition(animpos)
	self:playSkillAnim(self.keyboard[keycode].bindAnim)
	self:fitchGuideTip(tip)
end

function BattleGuide:makeAttackTouchAnim(tip)
	if self.keyboard[eVKeyCode["SKILL_A"]].bindAnim == nil then
		local skeletonNode = ResLoader.createEffect("effect_guide_01",1)
		self.guidePanel:addChild(skeletonNode)
		self.keyboard[eVKeyCode["SKILL_A"]].bindAnim = skeletonNode
	end
	local tmkey = self.keyboard[eVKeyCode["SKILL_A"]]
	tmkey.show = true
	tmkey.ctrl:setVisible(tmkey.show and tmkey.isShow)
	local pos = self.keyboard[eVKeyCode["SKILL_A"]].ctrl:getPosition()
	local worldpos = self.keyboard[eVKeyCode["SKILL_A"]].ctrl:getParent():convertToWorldSpace(pos)
	local animpos = self.guidePanel:convertToNodeSpace(worldpos)
	self.keyboard[eVKeyCode["SKILL_A"]].bindAnim:setPosition(animpos)
	self:playAttackAnim(self.keyboard[eVKeyCode["SKILL_A"]].bindAnim)
	self:fitchGuideTip(tip)

end

function BattleGuide:playSkillAnim(anim)
	if anim == nil then
		return
	end
	anim:setScale(0.7)
	anim:setVisible(true)
	anim:addMEListener(TFARMATURE_COMPLETE,function(sklete)
		sklete:removeMEListener(TFARMATURE_COMPLETE)
		sklete:play("pugong2",-1)
	end)
	anim:play("jineng",0)
end

function BattleGuide:playAttackAnim(anim)
	if anim == nil then
		return
	end
	anim:setScale(1)
	anim:setVisible(true)
	anim:addMEListener(TFARMATURE_COMPLETE,function(sklete)
		sklete:removeMEListener(TFARMATURE_COMPLETE)
		sklete:play("pugong2",-1)
	end)
	anim:play("pugong1",0)
end

function BattleGuide:playMoveAnim(anim)
	if anim == nil then
		return
	end
	anim:setScale(1)
	anim:addMEListener(TFARMATURE_COMPLETE,function(sklete)
		sklete:removeMEListener(TFARMATURE_COMPLETE)
		sklete:play("yidong2",-1)
	end)
	anim:play("yidong1",0)
end

return BattleGuide