local LinkageHwxBuffView = class("LinkageHwxBuffView",BaseLayer)

local itemState = {
    lock = 1,
    Get = 2,
    Geted = 3
}

function LinkageHwxBuffView:initData()

    self.buffData = {}
    self.buffItems_ = {}
    self.hwxDungeonFloorCfg = TabDataMgr:getData("HwxDungeonFloor")
end

function LinkageHwxBuffView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.linkageHwx.linkageHwxBuffView")
end

function LinkageHwxBuffView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.btnClose = TFDirector:getChildByPath(self.Panel_root, "btnClose")

    self.Panel_buff_item = TFDirector:getChildByPath(ui, "Panel_buff_item")
    local ScrollView_buff = TFDirector:getChildByPath(self.Panel_root, "ScrollView_buff")
    self.GridView_buff = UIGridView:create(ScrollView_buff)
    self.GridView_buff:setItemModel(self.Panel_buff_item)
    self.GridView_buff:setColumn(4)
    self.GridView_buff:setColumnMargin(0)

    self.Label_title =  TFDirector:getChildByPath(self.Panel_root, "Label_title")
    self.Label_title:setTextById(12031195)

    self:refreshView()
end

function LinkageHwxBuffView:refreshView()

    self.towerInfo = LinkageHwxDataMgr:getTowerInfo()
    if not self.towerInfo  then
        return
    end

    local dungeonInfo = self.towerInfo.base.dungeonList or {}
    table.sort(dungeonInfo,function(a, b)
        return a.key < b.key
    end)

    self.curDungeon = self.towerInfo.base.dungeon
    self.dungeonList = {}
    for k,v in ipairs(dungeonInfo) do
        self.dungeonList[v.key] = v.value
    end

    self.targetFloorId = table.indexOf(self.dungeonList,self.curDungeon)

    ---bestTime == 0标识boss关卡未通过
    self.bestTime = self.towerInfo.base.bestTime

    for k,v in ipairs(self.hwxDungeonFloorCfg) do
        ---v.buffPool 元素为空，代表是boss或者女生关卡 没有buff显示
        if next(v.buffPool) then
            self:addBuffItem(k)
            self:updateBuffItem(k, v.id)
        end
    end

end

function LinkageHwxBuffView:addBuffItem(index)

    local item = self.GridView_buff:pushBackDefaultItem()
    local Image_geted = TFDirector:getChildByPath(item, "Image_geted")
    local Label_skill = TFDirector:getChildByPath(Image_geted, "Label_skill")
    local Label_skillName = TFDirector:getChildByPath(Image_geted, "Label_skillName")
    local Image_buff =  TFDirector:getChildByPath(Image_geted, "Image_buff")
    local Image_icon = TFDirector:getChildByPath(Image_geted, "Image_icon")
    local ScrollView_desc = TFDirector:getChildByPath(Image_geted, "ScrollView_desc")
    local listView_desc = UIListView:create(ScrollView_desc)

    local Image_lock = TFDirector:getChildByPath(item, "Image_lock")
    local Label_lock = TFDirector:getChildByPath(Image_lock, "Label_lock")

    local Panel_nr = TFDirector:getChildByPath(item, "Panel_nr")
    local Image_icon_nr = TFDirector:getChildByPath(Panel_nr, "Image_icon")
    local Label_name= TFDirector:getChildByPath(Panel_nr, "Label_name")

    local Image_get = TFDirector:getChildByPath(item, "Image_get")
    local Button_getBuff = TFDirector:getChildByPath(Image_get, "Button_getBuff")


    self.buffItems_[index] = { root = item, Image_geted = Image_geted,Image_get = Image_get,
                               Image_lock = Image_lock, Panel_nr = Panel_nr, Button_getBuff = Button_getBuff,
                               Image_icon = Image_icon, Image_icon_nr = Image_icon_nr, Label_name = Label_name, Label_lock = Label_lock, Label_skill = Label_skill,Label_skillName = Label_skillName,
                               Image_buff = Image_buff, listView_desc = listView_desc}
    return item
end

function LinkageHwxBuffView:updateBuffItem(index, floorId)

    local buffItem = self.buffItems_[index]
    if not buffItem then
        return
    end

    local levelCid = self.dungeonList[floorId]
    if not levelCid then
        return
    end

    local displayCfg = LinkageHwxDataMgr:getCityDisplayCfg(levelCid)
    if not displayCfg then
        return
    end


    ---图标显示
    buffItem.Image_icon:setTexture(displayCfg.invadeIcon2)
    buffItem.Image_icon:setContentSize(CCSizeMake(104,104))
    buffItem.Image_icon_nr:setTexture(displayCfg.invadeIcon2)

    local levelCfg_ = TabDataMgr:getData("DungeonLevel", levelCid)
    if not levelCfg_ then
        return
    end

    buffItem.Label_name:setTextById(levelCfg_.name)

    ---显示名字
    local floorCfg = self.hwxDungeonFloorCfg[index]
    if not floorCfg then
        return
    end

    buffItem.Label_skillName:setTextById(floorCfg.name)

    local buffId = LinkageHwxDataMgr:getActiveBuffInfo(floorId)

    --state：1-锁定。2-可领取。3-已领取
    local buffState = 1
    if not buffId then
        if index < self.targetFloorId then
            buffState = 2
        else
            if self.targetFloorId == #self.hwxDungeonFloorCfg  and self.bestTime > 0 then
                buffState = 2
            else
                buffState = 1
            end
        end
    else
        buffState = 3
    end

    buffItem.Image_lock:setVisible(itemState.lock == buffState)
    buffItem.Image_geted:setVisible(itemState.Geted == buffState)
    buffItem.Image_get:setVisible(itemState.Get == buffState)
    buffItem.Panel_nr:setVisible(itemState.Geted ~= buffState)

    ---解锁条件
    local str = TextDataMgr:getText(floorCfg.name)
    buffItem.Label_lock:setTextById(12031163,str)
    buffItem.listView_desc:removeAllItems()
    ---buff信息
    if buffId then
        local buffCfg = LinkageHwxDataMgr:getHwxBuffManageCfg(buffId)
        if not buffCfg then
            return
        end
        buffItem.Label_skill:setText("")
        buffItem.Image_buff:setTexture(buffCfg.buffIcon)
        local descText = buffItem.Label_skill:clone()
        descText:setTextById(buffCfg.buffDescribe)
        descText:setDimensions(158,0)
        local h =descText:getContentSize().height
        if h > 21 then
            descText:setTextHorizontalAlignment(0)
        end
        buffItem.listView_desc:pushBackCustomItem(descText)
    end

    local color = itemState.Get == buffState and ccc3(123, 187, 231) or ccc3(169, 186, 235)
    buffItem.Label_name:setColor(color)
    buffItem.Button_getBuff:onClick(function()
        Utils:openView("linkageHwx.LinkageHwxSelectBuffView",floorId)
    end)
end

function LinkageHwxBuffView:updateBuff()

    for k,v in ipairs(self.hwxDungeonFloorCfg) do
        if next(v.buffPool) then
            self:updateBuffItem(k, v.id)
        end
    end
end

function LinkageHwxBuffView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_LINKAGEHWX_BUFF, handler(self.updateBuff, self))
    self.btnClose:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return LinkageHwxBuffView