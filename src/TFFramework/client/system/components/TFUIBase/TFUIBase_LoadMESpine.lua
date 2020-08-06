local TFUIBase 					= TFUIBase
local TFUIBase_setFuncs 		= TFUIBase_setFuncs
local TFUIBase_setFuncs_new 	= TFUIBase_setFuncs_new
local TFUI_VERSION_MEEDITOR 	= TFUI_VERSION_MEEDITOR
local TFUI_VERSION_NEWMEEDITOR 	= TFUI_VERSION_NEWMEEDITOR
local TFUI_VERSION_ALPHA 		= TFUI_VERSION_ALPHA
local TF_TEX_TYPE_LOCAL 		= TF_TEX_TYPE_LOCAL
local TF_TEX_TYPE_PLIST 		= TF_TEX_TYPE_PLIST
local ccc3 						= ccc3
local ccp 						= ccp
local bit_and 					= bit_and
local bit_rshift				= bit_rshift
local CCSizeMake 				= CCSizeMake
local CCRectMake 				= CCRectMake
local string 					= string

function TFUIBase:initMESpine(pval, parent)
	if TFUIBase.version == TFUI_VERSION_COCOSTUDIO then
		self:initMESpine_COCOSTUDIO(pval, parent)
	elseif TFUIBase.version == TFUI_VERSION_ALPHA then
		self:initMESpine_ALPHA(pval, parent)
	elseif TFUIBase.version == TFUI_VERSION_MEEDITOR then
		self:initMESpine_MEEDITOR(pval, parent)
	elseif TFUIBase.version == TFUI_VERSION_NEWMEEDITOR then
		self:initMESpine_NEWMEEDITOR(pval, parent)
	end
end

function TFUIBase:initMESpine_MEEDITOR(pval, parent)
	self:initMEWidget(pval, parent)
	local val = pval['spineModel']
	if val == nil then
		return
	end
	if val['IsPlay'] == true or val['IsPlay'] == "True" then
		if val['IsUseQueue'] then
			self:stop()
			self:clearTracks()

			local animations = val['AnimationQueue']
			local isLastLoop = val['IsPlay']
			
			for k,v in ipairs(animations) do		
				isLoop = (i == count) and isLastLoop 		
				self:addAnimation(1, v, isLoop)
			end
			self:resume()
		elseif val['animationName'] ~= '' then 
			self:play(val['animationName'], val['IsLoop'] == "True" or val['IsLoop'] == true)			
		else
			--todo
			self:play()
		end
	end

	self:initMEColorProps(pval, parent)
	self:initBaseControl(pval, parent)
end

function TFUIBase:initMESpine_NEWMEEDITOR(pval, parent)
	self:initMEWidget(pval, parent)
	local val = pval.tSpineProperty
	if val == nil then
		return
	end
	if val['IsPlay'] then
		if val['IsUseQueue'] then
			self:stop()
			self:clearTracks()

			local animations = val['AnimationQueue']
			local isLastLoop = val['IsPlay']
			
			for k,v in ipairs(animations) do		
				isLoop = (i == count) and isLastLoop 		
				self:addAnimation(1, v, isLoop)
			end
			self:resume()
		elseif val['animationName'] ~= '' then 
			self:play(val['animationName'], val['IsLoop'])			
		else
			--todo
			self:play()
		end
	end

	self:initMEColorProps(pval, parent)
	self:initBaseControl(pval, parent)
end

function TFUIBase:initMESpine_COCOSTUDIO(pval, parent)
	local val = pval.options
	self:initMEWidget(pval, parent)
	self:initMEColorProps(pval, parent)
	if val['play'] and self.play then
		self:play(val['play'])
	end
	self:initBaseControl(pval, parent)
end

function TFUIBase:initMESpine_ALPHA(pval, parent)
	local val = pval
	self:initMEWidget(pval, parent)
	self:initMEColorProps(pval, parent)
	if val['play'] and self.play then
		self:play(val['play'])
	end
	self:initBaseControl(pval, parent)
end