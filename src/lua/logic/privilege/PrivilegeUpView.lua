local PrivilegeUpView = class("PrivilegeUpView", BaseLayer)

function PrivilegeUpView:initData()

    self.mapPrivilege = {}
end

function PrivilegeUpView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.privilege.privilegeUpView")
end

function PrivilegeUpView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Button_up = TFDirector:getChildByPath(self.Panel_root, "Button_up")
    self.Label_max = TFDirector:getChildByPath(self.Panel_root, "Label_max"):hide()
    self.Image_up_cost = TFDirector:getChildByPath(self.Panel_root, "Image_up_cost")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Image_up_cost, "Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(self.Image_up_cost, "Label_cost_num")
    self.Button_check = TFDirector:getChildByPath(self.Panel_root, "Button_check")

    local ScrollView_priviledge = TFDirector:getChildByPath(self.Panel_root, "ScrollView_priviledge")
    self.TableView_priviledge = Utils:scrollView2TableView(ScrollView_priviledge)
    Public:bindScrollFun(self.TableView_priviledge)
    self.TableView_priviledge:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_priviledge:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_priviledge:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    self.Spine_level_up_tip = TFDirector:getChildByPath(self.Panel_root, "Spine_level_up_tip"):hide()

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_privilegeItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_privilegeItem")

    self:initUILogic()
end



function PrivilegeUpView:initUILogic()

    self:loadMemberShipPrivilege()
    self:updateMemberShipUpCost()
end

function PrivilegeUpView:loadMemberShipPrivilege()
    self.mapPrivilege = PrivilegeDataMgr:getWishTreeCfg() or {}
    self.oldCid = PrivilegeDataMgr:getWishTreeCid()
    self.TableView_priviledge:reloadData()
    self:tableViewScrollToCell(self.oldCid)
end

function PrivilegeUpView:cellSizeForTable()
    local size = self.Panel_privilegeItem:getSize()
    return size.height, size.width
end

function PrivilegeUpView:numberOfCellsInTableView()
    return #self.mapPrivilege
end

function PrivilegeUpView:tableViewScrollToCell(idx,dt)
    dt = dt or 0
    local container = self.TableView_priviledge:getContainer()
    local containerSize = container:getSize()
    local viewSize = self.TableView_priviledge:getSize()
    local cellSize = self.Panel_privilegeItem:getSize()
    local offset = self.TableView_priviledge:getContentOffset()
    local minY = viewSize.height - containerSize.height
    local y = -cellSize.height * ( math.max(#self.mapPrivilege - idx, 0)) + viewSize.height - cellSize.height
    y = math.max(minY, y)
    y = math.min(0, y)
    self.TableView_priviledge:setContentOffsetInDuration(ccp(offset.x, y),dt)
end

function PrivilegeUpView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_privilegeItem:clone()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        self:updatePrivilegeItem(cell.item, self.mapPrivilege[idx])
    end

    return cell
end

function PrivilegeUpView:updatePrivilegeItem(item,data)

    local privilegeId = data.privilegeId
    local privilegeCfg = PrivilegeDataMgr:getPrivilegeCfg(privilegeId)
    if not privilegeCfg then
        return
    end

    local name = TextDataMgr:getText(15010117 )
    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    Label_name:setText(name.." Lv."..data.level)

    local Label_info = TFDirector:getChildByPath(item, "Label_info")
    Label_info:setTextById(privilegeCfg.describe)
    Label_info:setDimensions(490,0)

    local curCid = PrivilegeDataMgr:getWishTreeCid()
    local isUnLock = data.id <= curCid
    local Image_cell = TFDirector:getChildByPath(item, "Image_cell")
    Image_cell:setVisible(isUnLock)
    local Image_cell_bg = TFDirector:getChildByPath(item, "Image_cell_bg")
    Image_cell_bg:setVisible(not isUnLock)
end

---刷新乐园卡升级消耗
function PrivilegeUpView:updateMemberShipUpCost()

    local curCid = PrivilegeDataMgr:getWishTreeCid()
    local nextCid = curCid + 1
    local memberShipCfg = PrivilegeDataMgr:getWishTreeCfg(nextCid)
    if not memberShipCfg then
        self.Label_max:show()
        self.Image_up_cost:hide()
        return
    end

    self.Image_up_cost:show()
    local costId,costNum
    for k,v in pairs(memberShipCfg.cost) do
        costId,costNum = k,v
        break
    end

    if not costId or not costNum then
        return
    end

    local costItemCfg = GoodsDataMgr:getItemCfg(costId)
    if not costItemCfg then
        return
    end

    self.costId = costId
    local ownCnt = GoodsDataMgr:getItemCount(costId)
    self.Image_cost_icon:setTexture(costItemCfg.icon)
    self.Label_cost_num:setText(ownCnt.."/"..costNum)

    local  color = ownCnt >= costNum and me.WHITE or me.RED
    self.Label_cost_num:setColor(color)

end


function PrivilegeUpView:afterUpMemberShipLv()
    local curCid = PrivilegeDataMgr:getWishTreeCid()
    if self.oldCid < curCid then
        self:playEffect()
        self.oldCid = curCid
    end

    self:updateMemberShipUpCost()
    self.TableView_priviledge:reloadData()
    self:tableViewScrollToCell(self.oldCid,0.3)
end

function PrivilegeUpView:playEffect()

    Utils:playSound(1002)
    self.Spine_level_up_tip:show()
    self.Spine_level_up_tip:play("chuxian",false)
    self.Spine_level_up_tip:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_level_up_tip:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_level_up_tip:play("xunhuan",true)
            self:timeOut(function()
                self.Spine_level_up_tip:hide()
            end, 1)
        end, 0)
    end)
end

function PrivilegeUpView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_WISHTREE_LV, handler(self.afterUpMemberShipLv, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateMemberShipUpCost, self))

    self.Button_check:onClick(function()
        Utils:openView("privilege.MemberPrivilegeScan")
    end)

    self.Button_up:onClick(function()
        PrivilegeDataMgr:Send_UpWishTreeLv()
    end)

    self.Image_up_cost:onClick(function()
        if self.costId then
            Utils:showInfo(self.costId)
        end
    end)

end


return PrivilegeUpView
