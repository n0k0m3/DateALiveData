--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 情人节回顾
]]

local ValentineReviewView = class("ValentineReviewView",BaseLayer)

function ValentineReviewView:ctor(data )
	self.super.ctor(self,data)
	self.activityId = data.id
	self.list = clone(TabDataMgr:getData(data.huigu))
	self:init("lua.uiconfig.activity.valentineReviewView")
end

function ValentineReviewView:initUI(ui)
	self.super.initUI(self,ui)
	local panel_scroll = TFDirector:getChildByPath(ui,"panel_scroll")
	self.btn_letter = TFDirector:getChildByPath(ui,"btn_letter")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self.btn_letter:onClick(function ( ... )
		local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
		Utils:openView("activity.ValentineLetterView",activityInfo.extendData.stringId)
	end)


	self.listView = TFTableView:create()
    self.listView:setTableViewSize(panel_scroll:getContentSize())
    self.listView:setDirection(TFTableView.TFSCROLLVERTICAL)
    --列表设置为从小到大显示，及idx从0开始
    self.listView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)

	self.listView:onNumberOfCells(handler(self.tableNumberOfCells,self))
	self.listView:onCellSize(handler(self.tableSizeOfCell,self))
	self.listView:onCellAtIndex(handler(self.tableCellAtIndex,self))
    panel_scroll:addChild(self.listView,200)
    self.listView.logic = self
    self.listView:reloadData()

    for i = 1,7 do
    	local pos = TFDirector:getChildByPath(ui,"panel_pos"..i)
    	local info = self.list[i]
        local roleconf = clone(TabDataMgr:getData("CityRoleModel", info.cityRole))
        local shapeAnim = SkeletonAnimation:create(roleconf.rolePath)--TODO 要还原代码
	    shapeAnim:setAnimationFps(GameConfig.ANIM_FPS)
	    shapeAnim:play(info.giftIdle, true)
	    shapeAnim:setScaleY(math.abs(info.scale/100))
	    shapeAnim:setScaleX(info.scale/100)
	    pos:addChild(shapeAnim)
    end
end

function ValentineReviewView:tableNumberOfCells( table )
	return #self.list
end

function ValentineReviewView:tableSizeOfCell( table ,idx)
	local size = self.Panel_item:getContentSize()
	return size.height,size.width
end

function ValentineReviewView:tableCellAtIndex( table ,idx )
	local cell = table:dequeueCell()
   	if nil == cell then
	  	table.cells = table.cells or {}
        cell = TFTableViewCell:create()
   		local parentNode = self.Panel_item:clone()
   		parentNode:setVisible(true)
   		parentNode:setPosition(ccp(0,0))
	    cell:addChild(parentNode)
	    cell.node = parentNode
		table.cells[cell] = true
    end

    local itemNode = cell.node

    self:flushItemNode(itemNode,idx + 1)

    return cell
end

function ValentineReviewView:flushItemNode(itemNode,idx)
	local parentNode = TFDirector:getChildByPath(itemNode,"panel_rank1")
	parentNode:hide()
	parentNode = TFDirector:getChildByPath(itemNode,"panel_rank2")
	parentNode:hide()
	parentNode = TFDirector:getChildByPath(itemNode,"panel_rank3")
	parentNode:hide()
	parentNode = TFDirector:getChildByPath(itemNode,"panel_rank_normal")
	parentNode:hide()

	parentNode = TFDirector:getChildByPath(itemNode,"panel_rank"..idx)
	if not parentNode then
		parentNode = TFDirector:getChildByPath(itemNode,"panel_rank_normal")
	end
	parentNode:show()
	local head = TFDirector:getChildByPath(parentNode,"head")
	local name = TFDirector:getChildByPath(parentNode,"name")
	local num = TFDirector:getChildByPath(parentNode,"num")
	local rank = TFDirector:getChildByPath(parentNode,"rank")

	local info = self.list[idx]
	head:setTexture(info.head)
	head:setScale(80/head:getContentSize().width)
	name:setTextById(info.name)
	rank:setText(idx)
	num:setText(info.ticket)
end

return ValentineReviewView