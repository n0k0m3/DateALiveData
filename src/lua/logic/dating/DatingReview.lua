local DatingReview = class("DatingReview",BaseLayer)
local isAddStoryText = false
function DatingReview:initData(data)
    self.reviewTable = data.reviewTable
    self.infoData = data.infoData
    self.closeCallBack = data.closeCallBack
end

function DatingReview:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)

    self:init("lua.uiconfig.dating.datingReview")
end

function DatingReview:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self:initHuiGu()

    self.ui:runAnimation("Action0",1)
end

--剧情回顾
function DatingReview:initHuiGu()
    self.reviewBoard = TFDirector:getChildByPath(self.ui,"Panel_board")

    self.reviewBack  = TFDirector:getChildByPath(self.ui,"Button_reviewBack")
    self.reviewBack:setOpacity(0)

    self:initScrollView()
    self:initSlider()

end

--剧情回顾滚动面板
function DatingReview:initScrollView()

    self.tableItem = TFDirector:getChildByPath(self.ui,"Image_item")
    self.tableItem.saveSize = self.tableItem:Size()
    self.tableItem.textPos = self.tableItem:getChildByName("Image_nameBottom"):Pos()
    self.tableItem:retain()
    self.tableItem:removeFromParent()

    local scrollView = TFDirector:getChildByPath(self.ui,"ScrollView_datingLayer")
    self.tableView = Utils:scrollView2TableView(scrollView)
    self.tableView:setZOrder(1000)
    Public:bindScrollFun(self.tableView)
end

--剧情回顾滚动进度条
function DatingReview:initSlider()
    self.slider_gundongtiao = TFDirector:getChildByPath(self.ui, 'Slider_gundongtiao');
    self.slider_gundongtiao.logic = self

    self.img_slider  = TFDirector:getChildByPath(self.ui, 'Image_slider');
end

function DatingReview:sliderTouchMoveHandle(sender)
    local contentSize   = self.tableView:getContentSize()
    local size          = self.tableView:getSize()
    local length        = contentSize.height - size.height
    local percent       = sender:getPercent() * length / 100

    self.tableView:setContentOffset(ccp(0,percent*-1) , 0)

    TFAudio.playEffect(Utils:getKVP(1003,"ui_flipSound"))
end

function DatingReview:tableScroll(tableView)
    local contentOffset = tableView:getContentOffset()
    local contentSize   = tableView:getContentSize()
    local size          = tableView:getSize()
    local length        = contentSize.height - size.height
    local percent       = -contentOffset.y/length
    percent = percent <= 1 and percent or 1
    self.slider_gundongtiao:setPercent(math.floor(percent*100))
    TFAudio.playEffect(Utils:getKVP(1003,"ui_flipSound"))
end

function DatingReview:startGundongtiaoTimer()
    self:removeGundongtiaoTimer()
    local interval= 0.1
    self.timerGundongtiaoID_ = TFDirector:addTimer(interval, -1, nil, handler(self.updateGundongtiao, self))
end

function DatingReview:removeGundongtiaoTimer()
    if self.timerGundongtiaoID_ then
        TFDirector:removeTimer(self.timerGundongtiaoID_)
        self.timerGundongtiaoID_ = nil
    end
end

function DatingReview:updateGundongtiao(delta)
    self:tableScroll(self.tableView)
end

function DatingReview:showReview()
    self.isJumpOk = false
    self.reviewBack:setTouchEnabled(true)
    self.tableView:reloadData()

    self.img_slider:hide()

    local function cb()
        local contentSize   = self.tableView:getContentSize()
        local size          = self.tableView:getSize()
        local length        = contentSize.height - size.height
        if length <= 0 then
            self.img_slider:setVisible(false)
        else
            self.img_slider:setVisible(true)
            self.tableView:scrollToXLast()
            self:startGundongtiaoTimer()
        end
        self.reviewBack:fadeIn(1)
    end
    local acArr = TFVector:create()
    local delayAc = CCDelayTime:create(0)
    local moveDown1 = MoveBy:create(.3,ccp(-GameConfig.WS.width,0))
    local moveDown2 = MoveBy:create(.3,ccp(GameConfig.WS.width,0))
    local faIAc = FadeIn:create(2.0)
    local eaInAc1 = EaseBackIn:create(moveDown1)
    local eaInAc2 = EaseBackIn:create(moveDown2)
    local spawnArr = {moveDown1, faIAc}
    local spawn = CCSpawn:create(spawnArr)
    local callFunc = CCCallFunc:create(cb)
    --acArr:addObject(delayAc)
    acArr:addObject(callFunc)
    --acArr:addObject(spawn)


    self.reviewBoard:runAction(CCSequence:create(acArr))
end

function DatingReview:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    local index = idx + 1

    local item = nil

    if nil == cell then
        cell = TFTableViewCell:create()

        item = self.tableItem:clone()
        if item == nil then
            return
        end
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item
    else
        item = cell.item
    end

    self:refreshItem(item,index)
    return cell
end

function DatingReview:numberOfCells(table)
    return #self.reviewTable
end

function DatingReview:cellSize(table,index)
    return self:calcuCellSize(index+1)
end

function DatingReview:calcuCellSize(index)
    return self:refreshItem(self.tableItem,index)
end

function DatingReview:refreshItem(item,index)

    print("DatingReview:refreshItem")
    print("index ",index)
    print("self.reviewTable[index] ",self.reviewTable[index])

    local info = self.infoData[self.reviewTable[index]];
    info.name = info.name or ""
    local nameLabel = TFDirector:getChildByPath(item,"Label_name");
    local Image_nameBottom = TFDirector:getChildByPath(item, "Image_nameBottom")
    local nameCopy = ""
    if info.name == "1" then
        nameCopy = MainPlayer:getPlayerName()
    else
        nameCopy = info.name
    end
    nameLabel:setText(nameCopy);
    local contentLabel = item:getChildByName("TextArea_text");
    contentLabel:setColor(ccc3(255,255,255))
    local cSaveHeight = 34
    local textCopy = ""
    if info.storyId and isAddStoryText then
        self.talkdata = {}
        local dialogData = TabDataMgr:getData("Dialog")

        for k,v in pairs(dialogData) do
            if v.scriptId == info.storyId then
                self.talkdata[#self.talkdata + 1] = v
            end
        end
        if #self.talkdata > 1 then
            table.sort( self.talkdata, function(a,b)
                return a.order < b.order
            end)
        end
        textCopy = ""
        for i, v in ipairs(self.talkdata) do
            if #textCopy ~= 0 then
                textCopy = textCopy .. " "
            end
            for it, vt in ipairs(v.text) do
                textCopy = textCopy .. vt.text
            end
        end
    else
        textCopy =  string.gsub(info.text, "%%s", MainPlayer:getPlayerName())
    end

    local leIdxList_,strCopy = checkSpecText(clone(textCopy))
    contentLabel:setText(strCopy)

    local list,len = Public:stringSplit(strCopy)

    --local idxLen = 1
    --local leIdx = 1
    --local isColor = false
    ----单个字符着色功能
    -- for i,v in ipairs(list) do
    --     if leIdx <= #leIdxList_ and v == leIdxList_[leIdx].startChr then
    --         isColor = true
    --     end
    --
    --     if isColor then
    --         local letter = contentLabel:getLetter(i-1);
    --         if letter then
    --             if leIdxList_[leIdx].color then
    --                 letter:setColor(ccc3(leIdxList_[leIdx].color[1],leIdxList_[leIdx].color[2],leIdxList_[leIdx].color[3]))
    --             else
    --                 letter:setColor(ccc3(235,70,116))
    --             end
    --             if leIdxList_[leIdx].scale then
    --                 letter:Scale(leIdxList_[leIdx].scale)
    --             else
    --                 letter:Scale(1.3)
    --             end
    --         end
    --     end
    --
    --     if leIdx <= #leIdxList_ and v == leIdxList_[leIdx].endChr then
    --         isColor = false
    --         leIdx = leIdx + 1
    --     end
    -- end

    contentLabel:setWidth(900)

    local disHeight = 0

    local newHeight = contentLabel:Size().height
    if newHeight > cSaveHeight then
        disHeight = newHeight - cSaveHeight
    end

    if info.name == "" then
        --disHeight = disHeight - nameLabel:Size().height
        Image_nameBottom:hide()
    else
        Image_nameBottom:show()
        Image_nameBottom:Pos(self.tableItem.textPos.x,self.tableItem.textPos.y + disHeight)
    end

    item:Size(self.tableItem.saveSize.width,self.tableItem.saveSize.height + disHeight)

    return  item:Size().height, item:Size().width
end

function DatingReview:onShow()
    self.super.onShow(self)
    self:showReview()
end

--注册事件
function DatingReview:registerEvents()
    self.super.registerEvents(self)

    -- table view 事件
    self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
    self.tableView:addMEListener(TFTABLEVIEW_SCROLL, handler(self.tableScroll,self))
    --slider事件
    self.slider_gundongtiao:addMEListener(TFWIDGET_TOUCHMOVED, handler(self.sliderTouchMoveHandle,self))

    self.reviewBack:onClick(function()
            local backGround2 = TFDirector:getChildByPath(self.ui,"backGround2")
            self.reviewBack:setTouchEnabled(false)
            local function cb()
                self:removeGundongtiaoTimer()
                if self.closeCallBack then
                    self.closeCallBack()
                end
                AlertManager:closeLayer(self)
            end
            local acArr = TFVector:create()

            local delayAc = CCDelayTime:create(0.1)
            local moveUp1 = MoveBy:create(.3,ccp(GameConfig.WS.width,0))
            local moveUp2 = MoveBy:create(.3,ccp(-GameConfig.WS.width,0))
            local eaOutAc1 = EaseBackOut:create(moveUp1)
            local eaOutAc2 = EaseBackOut:create(moveUp2)

            local callFunc = CCCallFunc:create(cb)
            --acArr:addObject(delayAc)
            --acArr:addObject(moveUp1)
            acArr:addObject(callFunc)

            self.reviewBoard:runAction(CCSequence:create(acArr))
            self.lastPer = nil
            self.reviewBack:hide()
        end,EC_BTN.BACK);

end
--移除事件
function DatingReview:removeEvents()
    self.super.removeEvents(self)

    self:removeGundongtiaoTimer()
end

function DatingReview:specialKeyBackLogic( )
    self:closeCallBack()
    return false
end

return DatingReview