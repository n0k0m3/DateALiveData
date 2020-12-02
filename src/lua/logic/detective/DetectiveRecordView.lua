local DetectiveRecordView = class("DetectiveRecordView", BaseLayer)

function DetectiveRecordView:initData(selectType)

    self.selectType = selectType or 1

    self.archives_ = TabDataMgr:getData("DetectiveArchives")
    self.hero_items = {}
end

function DetectiveRecordView:ctor(selectType)
    self.super.ctor(self)
    self:initData(selectType)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.detectiveRecordView")
end

function DetectiveRecordView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_base")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    local ScrollView_target = TFDirector:getChildByPath(self.Panel_root, "ScrollView_target")
    self.ListView_target = UIListView:create(ScrollView_target)
    local ScrollView_info = TFDirector:getChildByPath(self.Panel_root, "ScrollView_info")
    self.ListView_Info = UIListView:create(ScrollView_info)

    self.Image_info_hero = TFDirector:getChildByPath(self.Panel_root, "Image_info_hero")
    self.Label_title = TFDirector:getChildByPath(self.Panel_root, "Label_title")

    self.select_ = {}
    for i=1,2 do
        local Panel = TFDirector:getChildByPath(self.Panel_root, "Panel_"..i)
        local select = TFDirector:getChildByPath(Panel, "Button_select")
        local normal = TFDirector:getChildByPath(Panel, "Image_normal")
        local view = i==1 and ScrollView_target or ScrollView_info
        table.insert(self.select_,{Panel = Panel, select = select, normal = normal, view = view})
    end

    self.Panel_hero_show = TFDirector:getChildByPath(self.Panel_root, "Panel_hero_show")

    self.Panel_item = TFDirector:getChildByPath(self.Panel_root, "Panel_item"):hide()
    self.Panel_item1 = TFDirector:getChildByPath(self.Panel_root, "Panel_item1"):hide()
    self.Panel_hero_item = TFDirector:getChildByPath(self.Panel_root, "Panel_hero_item"):hide()
    self:initUILogic()
end

function DetectiveRecordView:onShow()
    self.super.onShow(self)
end

function DetectiveRecordView:initUILogic()
    self:loadTarget()
    self:loadHeroShow()
    self:loadInfo()
    self:chooseType(self.selectType)
end

function DetectiveRecordView:loadTarget()
    self.ListView_target:removeAllItems()
    local mainLogInfo = DetectiveDataMgr:getMainLogInfo()
    local allMainLogInfo = {}
    table.insertTo(allMainLogInfo,mainLogInfo)

    table.sort(allMainLogInfo,function(a,b)
        local stateA = a.finished and  1 or 0
        local stateB = b.finished and  1 or 0
        if stateA == stateB then
            return a.time < b.time
        else
            return stateA < stateB
        end
    end)

    for k,v in ipairs(allMainLogInfo) do
        
        local cfg = DetectiveDataMgr:getLogCfgData(v.logId)
        if cfg then
            if v.finished then
                local subItem = self.Panel_item1:clone():show()
                TFDirector:getChildByPath(subItem, "Label_title"):setTextById(190000373)
                local Label_info = TFDirector:getChildByPath(subItem, "Label_info")
                Label_info:setTextById(cfg.finishLog)
                self.ListView_target:pushBackCustomItem(subItem)
            else
                local mainItem = self.Panel_item:clone():show()
                TFDirector:getChildByPath(mainItem, "Label_title"):setTextById(190000374)
                TFDirector:getChildByPath(mainItem, "Label_info"):setText(cfg.logBase)
                self.ListView_target:insertCustomItem(mainItem,1)
            end
        end
    end
end

function DetectiveRecordView:loadHeroShow()
    local count = 1
    local idx = 1
    local row = 1
    for k,v in pairs(self.archives_) do
        if not self.selectHero then
            self.selectHero = v.id
        end
        idx = (count - 1) % 3
        row = math.ceil(count / 3)
        local hero_item = self.Panel_hero_item:clone():show()
        TFDirector:getChildByPath(hero_item, "Image_icon"):setTexture(v.icon)
        self.hero_items[v.id] = hero_item
        hero_item:setTouchEnabled(true)
        self.Panel_hero_show:addChild(hero_item)
        hero_item:setPosition(ccp(70 + idx * 140, 560 - row * 122))
        if idx == 0 then
            local image_line = TFImage:create("ui/activity/detective/main/015.png")
            image_line:setPosition(ccp(210,500 - row * 122))
            self.Panel_hero_show:addChild(image_line)
        end
        count = count + 1
    end
    self:updateHeroShow()
end

function DetectiveRecordView:updateHeroShow()
    for k,v in pairs(self.hero_items) do
        TFDirector:getChildByPath(v, "Image_select"):setVisible(self.selectHero == tonumber(k))
    end
end

function DetectiveRecordView:loadInfo()
    self.ListView_Info:removeAllItems()
    local cfg = self.archives_[self.selectHero]
    local item1 = self.Panel_item:clone():show()
    TFDirector:getChildByPath(item1, "Label_title"):setText(cfg.name)
    TFDirector:getChildByPath(item1, "Label_info"):setTextById(cfg.des1)
    self.ListView_Info:pushBackCustomItem(item1)
    local item2 = self.Panel_item:clone():show()
    TFDirector:getChildByPath(item2, "Label_title"):setTextById(190000375)
    TFDirector:getChildByPath(item2, "Label_info"):setTextById(cfg.des2)
    self.ListView_Info:pushBackCustomItem(item2)
end

function DetectiveRecordView:chooseType(id)
    for k,v in ipairs(self.select_) do
        v.select:setVisible(k == id)
        v.view:setVisible(k == id)
        v.normal:setVisible(k ~= id)
        v.Panel:setZOrder(k == id and 3 or 2)
    end
    self.Image_info_hero:setVisible(id == 1)
    self.Panel_hero_show:setVisible(id == 2)
    local res = id == 1 and "003.png" or "001.png"

    local str = id == 1 and TextDataMgr:getText(2101009) or TextDataMgr:getText(190000376)
    self.Label_title:setText(str)
end

function DetectiveRecordView:registerEvents()

    EventMgr:addEventListener(self, EV_COURAGE.EV_UPDATE_EVENT_LOG, handler(self.loadTarget, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for k,v in pairs(self.hero_items) do
        v:onClick(function()
            self.selectHero = tonumber(k)
            self:updateHeroShow()
            self:loadInfo()
        end)
    end

    for k,v in ipairs(self.select_) do
        v.Panel:onClick(function()
            self:chooseType(k)
        end)
    end
end


return DetectiveRecordView
