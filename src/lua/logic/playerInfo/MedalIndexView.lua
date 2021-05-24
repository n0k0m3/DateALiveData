
local MedalIndexView = class("MedalIndexView", BaseLayer)

function MedalIndexView:initData()
    MedalDataMgr:sendReqActivateMedals()
    self.medalCfgArray_ = {}
    self.loadedIndex_ = 1
    self.firstLoad = true
    self.medalItem_ = {}
    self.isReplaceModel_ = false    --是否是更换模式
    self.selectedMedalId_ = nil     --选中的准备穿戴的ID
end

function MedalIndexView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.playerInfo.medalIndexView")
end

function MedalIndexView:initUI(ui)
    self:showTopBar()
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_medal_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_medal_item")

    local Panel_animBg = TFDirector:getChildByPath(self.Panel_root, "Panel_animBg")
    local Panel_middle = TFDirector:getChildByPath(self.Panel_root, "Panel_middle")
    local Panel_top = TFDirector:getChildByPath(self.Panel_root, "Panel_top")

    self.ScrollView_item = TFDirector:getChildByPath(Panel_middle, "ScrollView_item")
    self.Image_scrollBarModel = TFDirector:getChildByPath(Panel_middle, "Image_scrollBarModel")
    self.LoadingBar_ownProgress = TFDirector:getChildByPath(Panel_top, "LoadingBar_ownProgress")
    self.Label_medal_count = TFDirector:getChildByPath(Panel_top, "Label_medal_count")
    self.Label_medal_percent = TFDirector:getChildByPath(Panel_top, "Label_medal_percent")

    self.Button_change = TFDirector:getChildByPath(Panel_top, "Button_change"):hide()

    self:refreshView()
end

function MedalIndexView:refreshView()
    local Image_scrollBarInner = TFDirector:getChildByPath(self.Image_scrollBarModel, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(self.Image_scrollBarModel, Image_scrollBarInner)

    self.ScrollView_item = UIGridView:create(self.ScrollView_item)
    self.ScrollView_item:setItemModel(self.Panel_medal_item)
    self.ScrollView_item:setColumn(6)
    self.ScrollView_item:setColumnMargin(20)
    self.ScrollView_item:setRowMargin(15)
    self.ScrollView_item:setScrollBar(scrollBar)
end

function MedalIndexView:loadMedalItemUI()
    self.loadedIndex_ = 1
    if self.firstLoad then
        self:loadMedalItem()
        self.firstLoad = false
    else
        self:refreshMedalItem()
    end
    local ownCount = MedalDataMgr:getUnlockMedelCount()
    local percent = ownCount / #self.medalCfgArray_ * 100
    self.LoadingBar_ownProgress:setPercent(percent)
    self.Label_medal_count:setText(ownCount.."/"..#self.medalCfgArray_)
    self.Label_medal_percent:setText(percent.."%")
end

function MedalIndexView:loadMedalItem()
    local loadedIndex = self.loadedIndex_
    local medalCfg = self.medalCfgArray_[loadedIndex]
    if not medalCfg then return end

    local item = self.ScrollView_item:getItem(loadedIndex)
    if not item then
        item = self:createMedalItem()
        item:Alpha(0)
    end
    self:updateMedalItem(item, medalCfg)
    local fadeInDuration = 0.2
    local delayDuration = 0.05
    item:fadeIn(fadeInDuration)
    local action = Sequence:create({
            DelayTime:create(delayDuration),
            CallFunc:create(function()
                    self.loadedIndex_ = loadedIndex + 1
                    self:loadMedalItem()
            end)
    })
    item:runAction(action)
end

function MedalIndexView:refreshMedalItem()
    local loadedIndex = self.loadedIndex_
    local medalCfg = self.medalCfgArray_[loadedIndex]
    if not medalCfg then return end

    local column = self.ScrollView_item:getColumn()
    local fadeInDuration = 0.15
    local delayDuration = 0.05
    for i = loadedIndex, math.min(loadedIndex + column - 1, #self.medalCfgArray_) do
        local item = self.ScrollView_item:getItem(i)
        if not item then
            item = self:createMedalItem()
            item:Alpha(0)
        end
        item:fadeIn(fadeInDuration)
        self:updateMedalItem(item, self.medalCfgArray_[i])
    end
    local action = Sequence:create({
            DelayTime:create(delayDuration),
            CallFunc:create(function()
                    self.loadedIndex_ = loadedIndex + column
                    self:refreshMedalItem()
            end)
    })
    self.Panel_root:stopAllActions()
    self.Panel_root:runAction(action)
end

function MedalIndexView:createMedalItem()
    local item = self.ScrollView_item:pushBackDefaultItem()
    local target = {}
    target.node = item
    target.Image_medal_icon = TFDirector:getChildByPath(item, "Image_medal_icon")
    target.Panel_wearing = TFDirector:getChildByPath(item, "Panel_wearing")
    target.Label_medal_name = TFDirector:getChildByPath(item, "Label_medal_name")
    target.Image_select = TFDirector:getChildByPath(item, "Image_select")
    target.Panel_click = TFDirector:getChildByPath(item, "Panel_click")
    target.Panel_star = TFDirector:getChildByPath(item, "Panel_star")
    target.Image_grey = TFDirector:getChildByPath(item, "Image_grey")
    target.Image_medal_lock = TFDirector:getChildByPath(item, "Image_medal_lock")

    for i=1,5 do
        local str = "Image_star"..i
        target[str] = TFDirector:getChildByPath(item, str)
    end
    self.medalItem_[item] = target
    return item
end


function MedalIndexView:updateMedalItem(item, medalCfg)
    local target = self.medalItem_[item]
    if not target then
        target = self.medalItem_[self:createMedalItem()]
    end
    target.Image_select:setVisible(false)
    target.Panel_wearing:setVisible(false)
    target.Image_medal_icon:setTexture(medalCfg.showicon)
    local scaleRate = medalCfg.size[1] or 100
    target.Image_medal_icon:setScale(scaleRate / 100)
    local medalInfo = MedalDataMgr:getMedelInfoById(medalCfg.id)
    if medalInfo then
        if medalInfo.isEquip then
            target.Panel_wearing:setVisible(true)
        end
        target.Image_grey:setVisible(false)
        target.Image_medal_lock:setVisible(false)
    else
        target.Image_grey:setVisible(true)
        target.Image_medal_lock:setVisible(true)
    end
    target.Label_medal_name:setTextById(medalCfg.name)
    for i=1,5 do
        if medalCfg.star >= i then
            target["Image_star"..i]:setVisible(true)
            target["Image_star"..i]:setPositionX((5 - medalCfg.star) * 9 + i * 20)
        else
            target["Image_star"..i]:setVisible(false)
        end
    end
    target.Panel_click:onClick(function()
        if self.isReplaceModel_ then
            if medalInfo and not medalInfo.isEquip then
                target.Image_select:setVisible(true)
                self.selectedMedalId_ = medalInfo.cid
                self.Button_change:setVisible(true)
            else
                Utils:showTips(600033)
            end
        else
            Utils:openView("playerInfo.MedalInfoView", medalCfg.id)   --目前仅显示基本信息使用
            --Utils:openView("playerInfo.MedalDetailView", medalCfg.id) --后期展示属性和技能和相关操作时使用
        end
    end)
end

function MedalIndexView:onReadyToReplaceMedal()
    self.isReplaceModel_ = true
end

function MedalIndexView:onGetActivateMedals()
    self.medalCfgArray_ = MedalDataMgr:getMedalCfgArrayData()
    self:loadMedalItemUI()
end

function MedalIndexView:registerEvents()
    EventMgr:addEventListener(self, EV_MEDAL_RESP_ACTIVATE_MEDALS, handler(self.onGetActivateMedals, self))
    EventMgr:addEventListener(self, EV_MEDAL_READY_TO_REPLACE, handler(self.onReadyToReplaceMedal, self))
    
    self.Button_change:onClick(function()
        MedalDataMgr:sendReqEquipMedal(self.selectedMedalId_)
        self.isReplaceModel_ = false
        self.selectedMedalId_ = nil
        self.Button_change:hide()
    end)
end

return MedalIndexView
