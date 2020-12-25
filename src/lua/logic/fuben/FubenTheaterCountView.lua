
local FubenTheaterCountView = class("FubenTheaterCountView", BaseLayer)

function FubenTheaterCountView:initData(levelCid, count)
    self.levelCid_ = levelCid
    self.count_ = count
    self.defaultSelectIndex_ = 1
end

function FubenTheaterCountView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fuben.fubenTheaterCountView")
end

function FubenTheaterCountView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_remain = TFDirector:getChildByPath(Image_content, "Label_remain")
    self.Label_remainCount = TFDirector:getChildByPath(Image_content, "Label_remainCount")
    self.Button_ok = TFDirector:getChildByPath(Image_content, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Image_tips.Label_tips")
    self.Panel_count = {}
    for i = 1, 5 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(Image_content, "Panel_count_" .. i)
        foo.Image_count_normal = TFDirector:getChildByPath(foo.root, "Image_count_normal")
        local Label_count_normal = TFDirector:getChildByPath(foo.Image_count_normal, "Label_count_normal")
        Label_count_normal:setText(i)
        foo.Image_count_select = TFDirector:getChildByPath(foo.root, "Image_count_select")
        local Label_count_select = TFDirector:getChildByPath(foo.Image_count_select, "Label_count_select")
        Label_count_select:setText(i)
        foo.Image_count_disable = TFDirector:getChildByPath(foo.root, "Image_count_disable")
        local Label_count_disable = TFDirector:getChildByPath(foo.Image_count_disable, "Label_count_disable")
        Label_count_disable:setText(i)
        self.Panel_count[i] = foo
    end

    self:refreshView()
end

function FubenTheaterCountView:refreshView()
    self.Label_remain:setTextById(300979)
    self.Label_remainCount:setText(self.count_)
    self.Label_ok:setTextById(490030)
    self.Label_name:setTextById(301173)
    self.Label_tips:setTextById(301174)

    for i, v in ipairs(self.Panel_count) do
        v.root:setTouchEnabled(i <= self.count_)
        v.Image_count_disable:setVisible(i > self.count_)
    end

    self:selectCount(self.defaultSelectIndex_)
end

function FubenTheaterCountView:selectCount(index)
    if self.selectIndex_ == index then return end
    self.selectIndex_ = index
    for i, v in ipairs(self.Panel_count) do
        v.Image_count_normal:setVisible(i ~= index)
        v.Image_count_select:setVisible(i == index)
    end
end

function FubenTheaterCountView:registerEvents()
    self.Button_ok:onClick(function()
            local chapter = FubenDataMgr:getChapter(EC_FBType.THEATER_HARD)
            local chapterCid = chapter[1]
            FubenDataMgr:cacheSelectFubenType(EC_FBType.THEATER)
            FubenDataMgr:cacheSelectChapter(chapterCid)
            Utils:openView("fuben.FubenSquadView", EC_FBType.THEATER_BOSS, self.levelCid_, self.selectIndex_)
            AlertManager:closeLayer(self)
    end)

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    for i, v in ipairs(self.Panel_count) do
        v.root:onClick(function()
                self:selectCount(i)
        end)
    end
end

return FubenTheaterCountView
