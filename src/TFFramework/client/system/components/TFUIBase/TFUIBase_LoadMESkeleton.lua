local TFUIBase 					= TFUIBase

function TFUIBase:initMESkeleton(pval, parent)
	self:initMESkeleton_NEWMEEDITOR(pval, parent)
end

function TFUIBase:initMESkeleton_NEWMEEDITOR(pval, parent)
	self:initMEWidget(pval, parent)

	
	self:initMEColorProps(pval, parent)
	self:initBaseControl(pval, parent)
end
