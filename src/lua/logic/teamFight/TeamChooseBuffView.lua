--[[
    @desc：TeamChooseBuffView
    @date: 2020-12-07 15:31:55
]]

local TeamChooseBuffView = class("TeamChooseBuffView",BaseLayer)

function TeamChooseBuffView:initData(teamInfo)
    self.teamInfo = teamInfo
    self.buffCfg = TabDataMgr:getData("ItemOfBattleBuff")
    self.selectBuffId = nil

    local data = ActivityDataMgr2:getSnowFestivalTeamData() or {}
    self.buff = {}
    for i, v in ipairs(self.teamInfo) do
        for j, _buff in ipairs(data) do
            if v.pid == _buff.playerId then
                _buff.name = v.name
                table.insert(self.buff, _buff)
                break
            end
        end
    end
    dump(self.buff)
end

function TeamChooseBuffView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.teamFight.teamChooseBuffView")
end

function TeamChooseBuffView:initUI(ui)
    self.super.initUI(self,ui)

    self.listViewBuff = UIListView:create(self._ui.ScrollView_buff)
    self:initListView()
end

function TeamChooseBuffView:initListView()
    self.listViewBuff:removeAllItems()

    for i, v in ipairs(self.buff) do
        local item = self._ui.Panel_buffChooseItem:clone()
        item.img_bgMine = TFDirector:getChildByPath(item, "img_bgMine")
        item.img_bgOther = TFDirector:getChildByPath(item, "img_bgOther")
        item.lab_name = TFDirector:getChildByPath(item, "lab_name")
        item.lab_buffName = TFDirector:getChildByPath(item, "lab_buffName")
        item.lab_desc = TFDirector:getChildByPath(item, "lab_desc")
        item.lab_idx = TFDirector:getChildByPath(item, "lab_idx")
        item.lab_noSelect = TFDirector:getChildByPath(item, "lab_noSelect")

        item.Panel_buffs = TFDirector:getChildByPath(item, "Panel_buffs")
        item.buffs = {}
        for j = 1, 3 do
            local _buffId = v.canUseBuff[j]
            local buff = TFDirector:getChildByPath(item.Panel_buffs, string.format("buff_%d", j))
            buff:setVisible(nil ~= _buffId)
            if not _buffId then return end
            item.buffs[_buffId] = {}
            item.buffs[_buffId].img_normal = TFDirector:getChildByPath(buff, "img_normal")
            item.buffs[_buffId].img_normal:setVisible(_buffId ~= v.buffId)
            item.buffs[_buffId].img_select = TFDirector:getChildByPath(buff, "img_select")
            item.buffs[_buffId].img_select:setVisible(_buffId == v.buffId)
            item.buffs[_buffId].img_buffIcon = TFDirector:getChildByPath(buff, "img_buffIcon"):setTexture(self.buffCfg[_buffId].iconShow)
            if v.playerId == MainPlayer:getPlayerId() then
                buff:setTouchEnabled(true)
            end
            buff:onClick(function()
                self:selectBuff(item, _buffId)                
            end)
        end 

        item.img_bgMine:setVisible(v.playerId == MainPlayer:getPlayerId())
        item.img_bgOther:setVisible(v.playerId ~= MainPlayer:getPlayerId())
        item.lab_name:setText(v.name)
        item.lab_buffName:setVisible(v.buffId ~= 0)
        item.lab_desc:setVisible(v.buffId ~= 0)
        item.lab_noSelect:setVisible(v.buffId == 0)
        if v.buffId ~= 0 then
            item.lab_buffName:setTextById(self.buffCfg[v.buffId].nameTextId)
            item.lab_desc:setTextById(self.buffCfg[v.buffId].desTextId)
        end
        item.lab_idx:setText(i.."P")
        self.listViewBuff:pushBackCustomItem(item)
    end
end

function TeamChooseBuffView:selectBuff(item, buffId)
    local buffCfg = self.buffCfg[buffId]
    item.lab_noSelect:setVisible(false)
    item.lab_buffName:setTextById(buffCfg.nameTextId)
    item.lab_buffName:show()
    item.lab_desc:setTextById(buffCfg.desTextId)
    item.lab_desc:show()

    for _buffId, v in pairs(item.buffs) do
        v.img_normal:setVisible(_buffId ~= buffId)
        v.img_select:setVisible(_buffId == buffId)
    end
    self.selectBuffId = buffId
end

function TeamChooseBuffView:onClose()
    self.super.onClose(self)

    if self.selectBuffId then
        ActivityDataMgr2:SEND_CHASM_REQ_USE_BUFF(self.selectBuffId)
    end
end

function TeamChooseBuffView:registerEvents()
    self._ui.Button_close:onClick(function()
        AlertManager:close(self)
    end)
end

return TeamChooseBuffView