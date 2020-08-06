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

function TFUIBase:initTFClippingNode(pval, parent)
	if TFUIBase.version == TFUI_VERSION_MEEDITOR then
		self:initTFClippingNode_MEEDITOR(pval, parent)
	elseif TFUIBase.version == TFUI_VERSION_NEWMEEDITOR then
		self:initTFClippingNode_NEWMEEDITOR(pval, parent)
	end
end

function TFUIBase:initTFClippingNode_MEEDITOR(pval, parent)
	self:initMEWidget(pval, parent)
	local val = pval

	local stencil = self:getStencil()
	if not stencil then 
		stencil = TFImage:create()
		self:setStencil(stencil)
	end
	if val['stencilPath'] then 
		stencil:setTexture(val['stencilPath'])
	end

    if val['revertAlpha'] then 
        local revertAlpha = val['revertAlpha'] == "True"
		self:setInverted(revertAlpha)
	end

	if val['alphaThreshold'] then 
		self:setAlphaThreshold(val['alphaThreshold'])
	else 
		self:setAlphaThreshold(0.01)
	end

	if val['clipNodeRotate'] then 
		stencil:setRotation(val['clipNodeRotate'])
	end

	if val['clipNodeScaleX'] then 
		stencil:setScaleX(val['clipNodeScaleX'])
	end
	if val['clipNodeScaleY'] then 
		stencil:setScaleY(val['clipNodeScaleY'])
	end

	if val['clipNodeX'] then 
		stencil:setPositionX(val['clipNodeX'])
	end
	if val['clipNodeY'] then 
		stencil:setPositionY(val['clipNodeY'])
	end
	
	self:initMEColorProps(pval, parent)
	self:initBaseControl(pval, parent)
end

function TFUIBase:initTFClippingNode_NEWMEEDITOR(pval, parent)
	self:initMEWidget(pval, parent)
	local val = pval
	if val['szText'] and self.setText then 
		self:setText(val['szText'])
	end
	self:initMEColorProps(pval, parent)
	self:initBaseControl(pval, parent)
end
