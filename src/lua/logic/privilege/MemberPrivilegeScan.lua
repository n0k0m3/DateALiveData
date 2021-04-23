local MemberPrivilegeScan = class("MemberPrivilegeScan", BaseLayer)

function MemberPrivilegeScan:initData(privilegeType)

    self.mapPrivilege = {}
    self.privilegeType = privilegeType
end

function MemberPrivilegeScan:ctor(privilegeType)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData(privilegeType)
    self:init("lua.uiconfig.privilege.memberPrivilegeScan")
end

function MemberPrivilegeScan:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")


    local ScrollView_priviledge = TFDirector:getChildByPath(self.Panel_root, "ScrollView_priviledge")
    self.TableView_priviledge = Utils:scrollView2TableView(ScrollView_priviledge)
    Public:bindScrollFun(self.TableView_priviledge)
    self.TableView_priviledge:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_priviledge:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_priviledge:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_privilegeItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_privilegeItem")

    self:loadMemberShipPrivilege()
end



function MemberPrivilegeScan:loadMemberShipPrivilege()

    local privilegeData = {}
    local mapPrivilegeCfg = PrivilegeDataMgr:getWishTreeCfg() or {}
    for k,v in ipairs(mapPrivilegeCfg) do
        local curCid = PrivilegeDataMgr:getWishTreeCid()
        if not privilegeData[v.privilegeId] then
            privilegeData[v.privilegeId] = {}
            privilegeData[v.privilegeId].cnt = 0
            privilegeData[v.privilegeId].finish = 0
        end
        privilegeData[v.privilegeId].cnt = privilegeData[v.privilegeId].cnt + 1
        if v.id <= curCid then
            privilegeData[v.privilegeId].finish = privilegeData[v.privilegeId].finish + 1
        end
    end

    self.mapPrivilege = {}
    for k,v in pairs(privilegeData) do
        table.insert(self.mapPrivilege,{privilegeId = k,cnt = v.cnt,finish = v.finish})
    end
    table.sort(self.mapPrivilege,function (a,b)
        return a.privilegeId < b.privilegeId
    end)

    self.TableView_priviledge:reloadData()
end

function MemberPrivilegeScan:cellSizeForTable()
    local size = self.Panel_privilegeItem:getSize()
    return size.height, size.width
end

function MemberPrivilegeScan:numberOfCellsInTableView()
    return #self.mapPrivilege
end

function MemberPrivilegeScan:tableCellAtIndex(tab, idx)
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

function MemberPrivilegeScan:updatePrivilegeItem(item,data)

    local privilegeId = data.privilegeId
    local privilegeCfg = PrivilegeDataMgr:getPrivilegeCfg(privilegeId)
    if not privilegeCfg then
        return
    end

    local Label_info = TFDirector:getChildByPath(item, "Label_info")
    Label_info:setTextById(privilegeCfg.describe)
    Label_info:setDimensions(520,0)

    local Label_cnt = TFDirector:getChildByPath(item, "Label_cnt")
    Label_cnt:setText(data.finish.."/"..data.cnt)
end

function MemberPrivilegeScan:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

end


return MemberPrivilegeScan
