
local LuckyListView = class("LuckyListView", BaseLayer)

local AwardLvTxt = {
    [1] = 63593,
    [2] = 63594,
    [3] = 267009,
}

function LuckyListView:initData(robe)
    self.robe = robe or ""
    self.curSelectAwardLv = 1 -- 当前选中的奖励等级
    self.keepHidelv = {       -- 隐藏的奖励等级序列  
        [1] = 2,
        [2] = 3
    }
end

function LuckyListView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.oneYear.LuckyListView")
end

function LuckyListView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.Panel_list_item = TFDirector:getChildByPath(self.Panel_root, "Panel_list_item")

    self.Label_my_lucky_Info = TFDirector:getChildByPath(self.Panel_root, "Label_my_lucky_Info")


    local ScrollView_turn = TFDirector:getChildByPath(self.Panel_root, "ScrollView_turn")
    self.ListView_turn = UIListView:create(ScrollView_turn)

    self.Panel_Scend = TFDirector:getChildByPath(self.Panel_root, "Panel_Scend")
    self.Label_nobody_scecond = TFDirector:getChildByPath(self.Panel_root, "Label_nobody_scecond")
    self.Label_nobody_scecond:setTextById(63615)
    local ScrollView_scend = TFDirector:getChildByPath(self.Panel_root, "ScrollView_scend")
    self.TableView_lucky_scend = Utils:scrollView2TableView(ScrollView_scend)

    self.img_choose = TFDirector:getChildByPath(self.Panel_root, "img_choose"):hide()
    self.Panel_click = TFDirector:getChildByPath(self.Panel_root, "Panel_click")

    self.TableView_lucky_scend:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_lucky_scend:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_lucky_scend:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    self.Panel_turn_item_1 = TFDirector:getChildByPath(self.Panel_root, "Panel_turn_item_1")
    self.Panel_turn_item_2 = TFDirector:getChildByPath(self.Panel_root, "Panel_turn_item_2")
    self.btn_turn = {}

    self:initUILogic()
end

function LuckyListView:initUILogic()

    self.ListView_turn:removeAllItems()
    local extendData = OneYearDataMgr:getalternately()
    if not extendData then
        return
    end
    for k,v in ipairs(extendData) do
        local turnItem = k%2 ~= 0 and self.Panel_turn_item_1 or self.Panel_turn_item_2
        local item = turnItem:clone()
        self:addTurnItem(item)
        self:updateTurnItem(k,v)
        self.ListView_turn:pushBackCustomItem(item)
    end

    self:chooseTurn(1)
end

function LuckyListView:addTurnItem(root)

    local btn = TFDirector:getChildByPath(root, "Button_turn")
    local Label_btn = TFDirector:getChildByPath(btn, "Label_btn")
    local Image_select = TFDirector:getChildByPath(btn, "Image_select"):hide()
    local Image_lock = TFDirector:getChildByPath(btn, "Image_lock"):hide()
    local Image_line = TFDirector:getChildByPath(btn, "Image_line")
    table.insert(self.btn_turn,{btn = btn,lable_btn = Label_btn,select = Image_select, lock = Image_lock, line = Image_line})
end

function LuckyListView:updateTurnItem(index,data)
    local curItem = self.btn_turn[index]
    if not curItem then
        return
    end
    local stageIndex = OneYearDataMgr:getCurTurnIndex()
    local isUnLock = index <= stageIndex
    -- local color = isUnLock and ccc3(197,46,48) or ccc3(255,255,255)
    curItem.lable_btn:setText(index)
    -- curItem.lable_btn:setColor(color)
    curItem.btn:setTouchEnabled(isUnLock)
    curItem.lock:setVisible(not isUnLock)
    --local res = isUnLock and "018.png" or "019.png"
    --curItem.line:setTexture("ui/activity/oneYear/luckyReward/pop/"..res)
end


function LuckyListView:cellSizeForTable()
    local size = self.Panel_list_item:getSize()
    return size.height, size.width
end

function LuckyListView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_list_item:clone():show()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        local curExtendData = OneYearDataMgr:getStageInfoByIndex(self.turnIndex)
        local prize = OneYearDataMgr:getLuckyList(curExtendData.sign,curExtendData.drawInfo[self:lvConverToIdx(curExtendData.drawInfo)].prize)
        self:updateItem(cell.item,prize[idx])
    end
    return cell
end

function LuckyListView:numberOfCellsInTableView()
    local curExtendData = OneYearDataMgr:getStageInfoByIndex(self.turnIndex)
    local prizeScend = OneYearDataMgr:getLuckyList(curExtendData.sign,curExtendData.drawInfo[self:lvConverToIdx(curExtendData.drawInfo)].prize)
    prizeScend = prizeScend and #prizeScend or 0
    return prizeScend
end

function LuckyListView:lvConverToIdx(drawInfo)
    for i, v in ipairs(drawInfo) do
        if v.prize == self.turnIndex *100 + self.curSelectAwardLv then
            return i
        end
    end
end

function LuckyListView:chooseTurn(turnIndex)
    self.turnIndex = turnIndex
    if self.oldSelectIndex then
        self.btn_turn[self.oldSelectIndex].select:setVisible(false)
        -- self.btn_turn[self.oldSelectIndex].lable_btn:setColor(ccc3(197,46,48))
    end

    self.btn_turn[turnIndex].select:setVisible(true)
    -- self.btn_turn[turnIndex].lable_btn:setColor(ccc3(255,255,255))
    self.oldSelectIndex = turnIndex

    local prizeId,turnNo = OneYearDataMgr:getPrizeId()
    local award,prizeType,luckyTurnIndex = OneYearDataMgr:getRewardsByPrizeId(prizeId)
    if turnIndex == luckyTurnIndex and prizeType ~= 0 then
        local stringId 
        if prizeType == 1 then
            stringId = 63596
        elseif prizeType == 2 then
            stringId = 63597
        else
            stringId = 267011
        end
        local btnText = self.btn_turn[turnIndex].lable_btn:getText()
        self.Label_my_lucky_Info:setTextById(stringId,btnText)
    else
        self.Label_my_lucky_Info:setTextById(63598)
    end

    -- 当前轮是否在报名
    local curIndex = OneYearDataMgr:getCurTurnIndex()
    if self.turnIndex == curIndex then
        local curTime = ServerDataMgr:getServerTime()
        local data = OneYearDataMgr:getStageInfoByIndex(curIndex)
        local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.ONEYEAR_CELEBRATION)
        local activityInfo_ = ActivityDataMgr2:getActivityInfo(activity[1])
        local endTime = data.registrationTime + activityInfo_.extendData.postTime
        if curTime < endTime then
            self.Label_my_lucky_Info:hide()
        end
    else
        self.Label_my_lucky_Info:show()
    end 

    self:updateList()
end

function LuckyListView:updateList()
    self.curSelectAwardLv = 1 
    self.keepHidelv = {      
        [1] = 2,
        [2] = 3
    }
    self:selectAwardLv()
end

---更新cell
function LuckyListView:updateItem(item,data)
    local Label_name = item:getChildByName("Label_name")
    local Label_id = item:getChildByName("Label_id")
    local Label_power = item:getChildByName("Label_power")
    local Image_icon = item:getChildByName("Image_icon")
    local Label_chanel = item:getChildByName("Label_chanel")
    local Image_icon_cover_frame = item:getChildByName("Image_icon_cover_frame")
    Label_name:setText(data.pName)
    Label_id:setText(data.pid)
    Label_power:setText(data.fightPower)

    local sid = tonumber(data.sid)
    local channelTextID = sid == self.robe and 63639 or 63640
    Label_chanel:setTextById(channelTextID)

    local headIcon = data.headId
    if headIcon == 0 then
        headIcon = 101
    end
    local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
    Image_icon:setTexture(icon)
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(data.headFrame)
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
end

function LuckyListView:selectAwardLv(idx)
    local curExtendData = OneYearDataMgr:getStageInfoByIndex(self.turnIndex)
    if not curExtendData then
        return
    end
    if idx then
        local _temp = self.curSelectAwardLv
        self.curSelectAwardLv = self.keepHidelv[idx]
        self.keepHidelv[idx] = _temp
    end

    TFDirector:getChildByPath(self.Panel_click, "Label_title_first"):setTextById(AwardLvTxt[self.curSelectAwardLv])
    TFDirector:getChildByPath(self.Panel_click, "Label_num_first"):setText(curExtendData.drawInfo[self:lvConverToIdx(curExtendData.drawInfo)].activity.."人")

    for i, v in ipairs(self.img_choose:getChildren()) do
        local _txt = TFDirector:getChildByPath(v, "txt")
        _txt:setTextById(AwardLvTxt[self.keepHidelv[i]])
    end
    self.img_choose:hide()

    local curExtendData = OneYearDataMgr:getStageInfoByIndex(self.turnIndex)
    local prizeScend = OneYearDataMgr:getLuckyList(curExtendData.sign, curExtendData.drawInfo[self:lvConverToIdx(curExtendData.drawInfo)].prize)
    local prizeScendCnt = prizeScend and #prizeScend or 0
    self.Label_nobody_scecond:setVisible(prizeScendCnt <= 0)

    self.TableView_lucky_scend:reloadData()
end

function LuckyListView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for k,v in ipairs(self.btn_turn) do
        v.btn:onClick(function()
            self:chooseTurn(k)
        end)
    end

    self.Panel_click:setTouchEnabled(true)
    self.Panel_click:onClick(function()
        self.img_choose:setVisible(not self.img_choose:isVisible())
    end)

    for i, v in ipairs(self.img_choose:getChildren()) do
        v:setTouchEnabled(true)
        local idx = string.gsub(v:getName(),"Panel_click","")
        idx = tonumber(idx)
        v:onClick(function()
            self:selectAwardLv(idx)
        end)
    end
end

return LuckyListView
