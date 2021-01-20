
local SummonHotNoticeView = class("SummonHotNoticeView", BaseLayer)

function SummonHotNoticeView:initData(loopType)
    self.summon_, self.endTime_ = SummonDataMgr:getNoticeHotSummon(loopType)
end

function SummonHotNoticeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.summon.summonHotNoticeView")
end

function SummonHotNoticeView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_noticeItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_noticeItem")
    self.Panel_stayItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_stayItem")

    self.PageView_notice = TFDirector:getChildByPath(self.Panel_root, "PageView_notice")
    self.Button_left = TFDirector:getChildByPath(self.Panel_root, "Button_left")
    self.Button_right = TFDirector:getChildByPath(self.Panel_root, "Button_right")

    self:refreshView()
end

function SummonHotNoticeView:refreshView()
    for i, v in ipairs(self.summon_) do
        local summonCfg = SummonDataMgr:getSummonCfg(v)
        local Panel_noticeItem = self.Panel_noticeItem:clone()
        local Image_ad = TFDirector:getChildByPath(Panel_noticeItem, "Image_ad")
        local Label_time = TFDirector:getChildByPath(Panel_noticeItem, "Label_time")
        Image_ad:setTexture(summonCfg.icon)
        local endTime = self.endTime_[i]
        Label_time:setText(TextDataMgr:getText(1200071, TFDate(endTime[1]+ GV_UTC_TIME_ZONE * 3600):fmt("%Y-%m-%d"), TFDate(endTime[2]+ GV_UTC_TIME_ZONE * 3600):fmt("%Y-%m-%d"))..GV_UTC_TIME_STRING)
        self.PageView_notice:addPage(Panel_noticeItem)
    end

    local Panel_stayItem = self.Panel_stayItem:clone()
    local Label_tips = TFDirector:getChildByPath(Panel_stayItem, "Label_tips")
    Label_tips:setTextById(1200069)
    self.PageView_notice:addPage(Panel_stayItem)

    self:updatePageState()
end

function SummonHotNoticeView:updatePageState()
    local curPageIndex = self.PageView_notice:getCurPageIndex()
    local count = self.PageView_notice:getPageCount()
    self.Button_left:setVisible(curPageIndex > 0)
    self.Button_right:setVisible(curPageIndex < count - 1)
end

function SummonHotNoticeView:registerEvents()
    self.Button_left:onClick(function()
            local curPageIndex = self.PageView_notice:getCurPageIndex()
            local count = self.PageView_notice:getPageCount()
            self.PageView_notice:scrollToPage(curPageIndex - 1)
    end)


    self.Button_right:onClick(function()
            local curPageIndex = self.PageView_notice:getCurPageIndex()
            local count = self.PageView_notice:getPageCount()
            self.PageView_notice:scrollToPage(curPageIndex + 1)
    end)

    self.PageView_notice:addMEListener(TFPAGEVIEW_CHANGED, function()
                                           self:updatePageState()
    end)
end

return SummonHotNoticeView
