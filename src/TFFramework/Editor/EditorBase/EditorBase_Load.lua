require('TFFramework.Editor.EditorBase.EditorBase_LoadTFButton')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFCheckBox')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFDragPanel')
-- require('TFFramework.Editor.EditorBase.EditorBase_LoadTFEditBox')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFImage')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFLabel')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFIconLabel')
-- require('TFFramework.Editor.EditorBase.EditorBase_LoadTFLabelAtlas')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFLabelBMFont')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFLayout')
-- require('TFFramework.Editor.EditorBase.EditorBase_LoadTFListView')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFLoadingBar')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFMovieClip')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFNPC')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFPageView')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFPanel')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFScrollView')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFSlider')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFTableView')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFTextArea')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFTextButton')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFTextField')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFParticle')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFRichText')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFButtonGroup')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFGroupButton')

require('TFFramework.Editor.EditorBase.EditorBase_LoadCCClippingNode')
require('TFFramework.Editor.EditorBase.EditorBase_LoadSkeletonAnimation')

-- require('TFFramework.Editor.EditorBase.EditorBase_LoadTFStoneMap')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFBigMap')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFArmature')
require('TFFramework.Editor.EditorBase.EditorBase_LoadTFAction')

require('TFFramework.Editor.EditorBase.EditorBase_LoadTFWidget')

require('TFFramework.Editor.EditBigMap')
require('TFFramework.Editor.EditMapData')
require('TFFramework.Editor.EditVirtualBase')
require('TFFramework.Editor.EditUtils')

function EditLua:addToParent(szId, tParams)
	local szParentID
	targets[szId]:setPosition(ccp(0, 0))
	if tTouchEventManager.bIsCreate then
		tParams = tTouchEventManager:setMoveCreate(targets[szId], tParams)
	end
	if not tParams or tParams.szParent == nil or targets[tParams.szParent] == nil then
		targets["root"]:addChild(targets[szId])
		szParentID = "root"
		targets["root"].children:push(szId)
		szCurRootPanelID = szId
		print("root add children")
	else
		szParentID = tParams.szParent
		EditVirtualBase:addChild(szParentID, szId)
		targets[szParentID].children:push(szId)
	end
	
	tLuaDataManager:addObjLuaData(szId, szParentID)
end

function EditLua:getTargetMarginOrPosition_CmdGet(szId)
	local szRes = ""
	local touchObj = targets[szId]
	local parentID = touchObj.szParentID
	szRes = string.format("ID=%s;positionX=%f,positionY=%f,nXPer=%.2f, nYPer=%.2f|", 
		touchObj.szId, touchObj:getPosition().x, touchObj:getPosition().y,touchObj:getPositionPercentX()*100, touchObj:getPositionPercentY()*100)
	local pParent = targets[parentID]
	if EditorUtils:TargetIsContainer(pParent) then
		local lp
		if EditorUtils:TargetIsLinearLayout(pParent) then
			lp = touchObj:getLayoutParameter(TF_LAYOUT_PARAMETER_LINEAR)
		elseif EditorUtils:TargetIsRelativeLayout(pParent) then
			lp = touchObj:getLayoutParameter(TF_LAYOUT_PARAMETER_RELATIVE)
		elseif EditorUtils:TargetIsGridLayout(pParent) then
			lp = touchObj:getLayoutParameter(TF_LAYOUT_PARAMETER_GRID)
		end
		if lp then
			local objMargin = lp:getMargin()
			szRes = string.format("ID=%s;nLeft=%f,nTop=%f,nRight=%f,nBottom=%f,positionX=%f,positionY=%f,nXPer=%.2f, nYPer=%.2f|", 
				touchObj.szId or "root", objMargin.left, objMargin.top, objMargin.right, objMargin.bottom, touchObj:getPosition().x, touchObj:getPosition().y,touchObj:getPositionPercentX()*100, touchObj:getPositionPercentY()*100)
		end
	end
	return szRes
end
