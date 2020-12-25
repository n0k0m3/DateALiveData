--[[
    @师徒申请列表
]]

local MasterList = class("MasterList", BaseLayer)

function MasterList:initData(_uiType)
    self.uiType = _uiType
    self.data = nil
    self.convertToServerType = nil
    self.txtId = nil

    local ViewUiTypeSwitchFunc = {
        [EC_FriendMasterApply.ApplyList] = function()
            self.txtId = 1340020
            self.data = FriendDataMgr:getMasterApplyList()
        end,
        [EC_FriendMasterApply.ApplyMaster] = function()
            self.txtId = 1340021
            self.convertToServerType = 2
        end,
        [EC_FriendMasterApply.GetApprentice] = function()
            self.txtId = 1340022
            self.convertToServerType = 1
        end
    }
    local _func = ViewUiTypeSwitchFunc[self.uiType]
    if _func then
        _func()
        if not self.data then
            FriendDataMgr:send_APPRENTICE_REQ_RECOMMEND_LIST(1, self.convertToServerType)
        end
    else
        Box("没有此类型uiType:"..self.uiType)
    end
end

function MasterList:ctor(...)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.friend.masterList")
end


function MasterList:initUI(ui)
    self.super.initUI(self, ui)

    if self.uiType == EC_FriendMasterApply.ApplyList then
        local size = self._ui.Img_1:getContentSize()
        local viewSize = self._ui.ScrollView_master:getContentSize()
        self._ui.Img_1:setContentSize(CCSizeMake(size.width, size.height + self._ui.Panel_find:getContentSize().height))
        self._ui.ScrollView_master:setContentSize(CCSizeMake(viewSize.width, viewSize.height + self._ui.Panel_find:getContentSize().height))
    end

    self.tableView = Utils:scrollView2TableView(self._ui.ScrollView_master):hide()
    self:refreshView()
end

function MasterList:refreshView()
    local params = {
        _type = EC_InputLayerType.OK,
        buttonCallback = function()
        end,
        closeCallback = function()

        end
    }
    self.inputLayer_ = requireNew("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer_, 1000)

    self._ui.lab_TopTxt:setTextById(self.txtId)
    self._ui.btn_agree:setVisible(self.uiType == EC_FriendMasterApply.ApplyList)
    self._ui.btn_refuse:setVisible(self.uiType == EC_FriendMasterApply.ApplyList)
    self._ui.btn_apply:setVisible(not self._ui.btn_agree:isVisible())
    self._ui.Panel_find:setVisible(self.uiType ~= EC_FriendMasterApply.ApplyList)
    self._ui.btn_refresh:setVisible(self._ui.Panel_find:isVisible())
    self._ui.lab_refreshTxt:setTextById(100000131)
end

function MasterList:registerEvents()
    self._ui.btn_close:onClick(function()
        AlertManager:close(self)
    end)

    self._ui.btn_refresh:onClick(function()
        FriendDataMgr:send_APPRENTICE_REQ_RECOMMEND_LIST(2, self.convertToServerType)
        Utils:showTips(1340002)
        local cdTime = Utils:getKVP(90023, "btnRefreshTimeCd")
        self._ui.btn_refresh:setTouchEnabled(false)
        self._ui.btn_refresh:setGrayEnabled(true)
        self._ui.lab_refreshTxt:setTextById(800040, cdTime)
        self.refreshTimerId_ = TFDirector:addTimer(
                1000,
                cdTime,
                function()
                    self._ui.btn_refresh:setTouchEnabled(true)
                    self._ui.btn_refresh:setGrayEnabled(false)
                    self._ui.lab_refreshTxt:setTextById(100000131)
                    self.refreshTimerId_ = nil
                end,
                function()
                    cdTime = cdTime - 1
                    self._ui.lab_refreshTxt:setTextById(800040, cdTime)
                end
        )
    end)

    EventMgr:addEventListener(self,EV_FRIEND_MASTERRECOMMEND_UPDATE, handler(self.refreshTableView,self))
    EventMgr:addEventListener(self,EV_FRIEND_MASTERAPPLYLIST_UPDATE,handler(self.refreshByApply,self))

    self._ui.TextField_find:addMEListener(TFTEXTFIELD_DETACH, function(input)
        self.inputLayer_:listener(input:getText())
    end)
    self._ui.TextField_find:addMEListener(TFTEXTFIELD_ATTACH, function(input)
        self.inputLayer_:show()
        self.inputLayer_:listener(input:getText())
    end)
    self._ui.TextField_find:addMEListener(TFTEXTFIELD_TEXTCHANGE, function(input)
        self.inputLayer_:listener(input:getText())
    end)

    self._ui.btn_find:onClick(function()
        local id = tonumber(self._ui.TextField_find:getText())
        if id then
            if id == MainPlayer:getPlayerId() then
                Utils:showTips(1340082)
                return
            end
            FriendDataMgr:send_APPRENTICE_REQ_SEARCH_PLAYER(id)
        else
            Utils:showTips(700025)
        end
    end)

    self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.getCellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.getNumberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.cellAtIndex,self))
    if self.data then
        self.tableView:reloadData()
        self.tableView:show()
        self._ui.img_noData:setVisible(self.uiType == EC_FriendMasterApply.ApplyList and #self.data == 0)
    end
end

function MasterList:getCellSize()
    local size = self._ui.Panel_masterItem:getSize()
    return size.height + 5, size.width
end

function MasterList:getNumberOfCells()
    return table.count(self.data)
end

function MasterList:cellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local index = idx + 1
    local item = nil

    if nil == cell then
        cell = TFTableViewCell:create()
        item = self._ui.Panel_masterItem:clone()

        if item == nil then
            return
        end
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item
    else
        item = cell.item
    end

    self:refreshCellItem(item,index)
    return cell
end

function MasterList:refreshCellItem(item,index)
    local data = self.data[index]

    local Image_diban = TFDirector:getChildByPath(item, "Image_diban")
    local Image_icon = TFDirector:getChildByPath(Image_diban, "Image_icon")
    local Image_icon_cover_frame = TFDirector:getChildByPath(Image_diban, "Image_icon_cover_frame")
    local Label_name = TFDirector:getChildByPath(Image_diban, "Label_name")
    local Label_level = TFDirector:getChildByPath(Image_diban, "Label_level")
    local Label_power = TFDirector:getChildByPath(Image_diban, "Label_power")
    local Label_recentLogin = TFDirector:getChildByPath(Image_diban, "Label_recentLogin")
    local btn_agree = TFDirector:getChildByPath(Image_diban, "btn_agree")
    local btn_refuse = TFDirector:getChildByPath(Image_diban, "btn_refuse")
    local btn_apply = TFDirector:getChildByPath(Image_diban, "btn_apply")
    local img_isFriend = TFDirector:getChildByPath(Image_diban, "img_isFriend")
    local img_isSameClub = TFDirector:getChildByPath(Image_diban, "img_isSameClub")
    local lab_masterLv = TFDirector:getChildByPath(Image_diban, "lab_masterLv")

    img_isFriend:setTexture(EC_MasterTagImgSrc.Friend)
    img_isSameClub:setTexture(EC_MasterTagImgSrc.Club)

    local portraitCid = data.portraitCId
    local icon = AvatarDataMgr:getAvatarIconPath(portraitCid)
    Image_icon:setTexture(icon)
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(data.portraitFrameCid)
    Image_icon_cover_frame:setTexture(avatarFrameIcon)
    local headFrameEffect = Image_icon_cover_frame:getChildByName("headFrameEffect")
    if headFrameEffect then
        headFrameEffect:removeFromParent()
    end
    if avatarFrameEffect ~= "" then
        headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
        headFrameEffect:setAnchorPoint(ccp(0,0))
        headFrameEffect:setPosition(ccp(0,0))
        headFrameEffect:play("animation", true)
        headFrameEffect:setName("headFrameEffect")
        Image_icon_cover_frame:addChild(headFrameEffect, 1)
    end

    Label_name:setText(data.name)
    Label_level:setTextById(800006, data.level)
    Label_power:setText(data.fightPower)
    if data.online then
        Label_recentLogin:setTextById(700037)
    else
        local nowDate = Utils:getUTCDate(ServerDataMgr:getServerTime())
        local lastLoginDate = Utils:getUTCDate(data.lastLoginTime)
        local diffDate = TFDate.diff(nowDate, lastLoginDate)
        local day = diffDate:spandays()
        local hour = diffDate:spanhours()
        local min = diffDate:spanminutes()
        if day >= 1 then
            Label_recentLogin:setTextById(700036, math.floor(day))
        elseif hour >= 1 then
            Label_recentLogin:setTextById(700035, math.floor(hour))
        else
            Label_recentLogin:setTextById(700010, math.max(1, math.floor(min)))
        end
    end

    img_isFriend:setVisible(data.isFriend)
    img_isSameClub:setVisible(data.isUnion)
    
    local lv = FriendDataMgr:getFamousLvByExperience(data.famousExp)
    lab_masterLv:setText(lv)
    lab_masterLv:setVisible(lv > 0)

    btn_agree:onClick(function()
        local type 
        local isHadMaster, isHadApprentice = FriendDataMgr:isHaveMasterApprentice()
        local isInCd = FriendDataMgr:getIsInCD()
        if data.type == EC_FriendMasterType.ApplyApprentice then
            type = 3
        end
        if data.type == EC_FriendMasterType.ApplyMaster then
            type = 5
        end
        if not isHadMaster and not isHadApprentice then
            FriendDataMgr:send_APPRENTICE_REQ_HANDLE_APPRENTICE(type, data.playerId)
        else
            if isInCd then
                Utils:showTips(1340013)
                return
            end
            if isHadMaster then
                Utils:showTips(1340014)
            end
            if isHadApprentice then
                Utils:showTips(1340015)
            end
        end
    end)

    btn_refuse:onClick(function()
        local type 
        if data.type == EC_FriendMasterType.ApplyApprentice then
            type = 4
        end
        if data.type == EC_FriendMasterType.ApplyMaster then
            type = 6
        end
        FriendDataMgr:send_APPRENTICE_REQ_HANDLE_APPRENTICE(type, data.playerId)
    end)

    btn_apply:onClick(function()
        local type = nil
        if FriendDataMgr:isCanApplyMater() then
            type = 2
        end
        if FriendDataMgr:isCanGetApprentice() then
            type = 1
        end

        if nil == type then
            local state1, state2 = FriendDataMgr:isHaveMasterApprentice()
            if state1 then
                Utils:showTips(1340014)
            elseif state2 then
                Utils:showTips(1340008)
            end
            return
        end
        
        FriendDataMgr:send_APPRENTICE_REQ_HANDLE_APPRENTICE(type, data.playerId)
    end)
end

function MasterList:refreshTableView(_data)
    self.data = _data
    self.tableView:reloadData()
    self.tableView:show()
    self._ui.img_noData:setVisible(self.uiType == EC_FriendMasterApply.ApplyList and #self.data == 0)
end

function MasterList:refreshByApply(_data)
    if self.uiType == EC_FriendMasterApply.ApplyList then 
        self:refreshTableView(_data)
    end
end

function MasterList:removeEvents()
    if self.refreshTimerId_ then
        TFDirector:removeTimer(self.refreshTimerId_)
    end
end

return MasterList
