
local MainLinePassView = class("MainLinePassView", BaseLayer)

function MainLinePassView:initData(chapterId)
    self.chapterId_ = chapterId
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(chapterId)
end

function MainLinePassView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.mainLinePassView")
end

function MainLinePassView:initUI(ui)
	self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Image_role = TFDirector:getChildByPath(self.Image_arrow, "Image_role")
    self.Image_reach = TFDirector:getChildByPath(self.Panel_root, "Image_reach")
    self.Label_reach = TFDirector:getChildByPath(self.Image_reach, "Label_reach")
    self.Image_reach2 = TFDirector:getChildByPath(self.Panel_root, "Image_reach2")
    self.Label_reach2 = TFDirector:getChildByPath(self.Image_reach2, "Label_reach2")
    self.Image_info = TFDirector:getChildByPath(self.Panel_root, "Image_info")
    self.Label_chapterName = TFDirector:getChildByPath(self.Image_info, "Label_chapterName")
    self.Label_orderName = TFDirector:getChildByPath(self.Image_info, "Label_orderName")
    self.Label_continue = TFDirector:getChildByPath(self.Panel_root, "Label_continue")
    self.Panel_roleOne = TFDirector:getChildByPath(self.Panel_root, "Panel_roleOne")
    self.Panel_roleOne:setBackGroundColorType(0)
    self.Panel_roleTwo = {}
    for i = 1, 2 do
        self.Panel_roleTwo[i] = TFDirector:getChildByPath(self.Panel_root, "Panel_roleTwo_" .. i)
        self.Panel_roleTwo[i]:setBackGroundColorType(0)
    end
    self.Image_roleName = TFDirector:getChildByPath(self.Panel_root, "Image_roleName")
    self.Label_roleName = TFDirector:getChildByPath(self.Image_roleName, "Label_roleName")
    self.Label_roleEnName = TFDirector:getChildByPath(self.Image_roleName, "Label_roleEnName")
    self.Image_title = TFDirector:getChildByPath(self.Panel_root, "Image_title")
    self.Label_title = TFDirector:getChildByPath(self.Image_title, "Label_title")

    self:refreshView()
end

function MainLinePassView:refreshView()
    self.Label_continue:setTextById(800018)
    self.Label_title:setTextById(300610)
    self.Label_reach:setTextById(300611)
    self.Label_reach2:setTextById(300611)

    local heroCid = self.chapterCfg_.endShowRole[1]
    local heroCfg = TabDataMgr:getData("Hero", heroCid)
    self.Label_chapterName:setTextById(self.chapterCfg_.name)
    local name = FubenDataMgr:getChapterOrderName(self.chapterId_)
    self.Label_orderName:setText(name)
    self.Label_roleName:setTextById(heroCfg.name)
    self.Label_roleEnName:setTextById(heroCfg.enName)

    local count = #self.chapterCfg_.endShowRole
    if count == 1 then
        Utils:createHeroModel(heroCid, self.Panel_roleOne, 0.6)

        self.Panel_roleOne:PosX(self.Panel_roleOne:PosX() - 100):Alpha(0)
        self.Panel_roleOne:moveBy(0.3, 100)
        self.Panel_roleOne:fadeIn(0.3)

    elseif count == 2 then
        for i, v in ipairs(self.Panel_roleTwo) do
            local heroCid = self.chapterCfg_.endShowRole[i]
            Utils:createHeroModel(heroCid, v, 0.6)

            v:PosX(v:PosX() - 100):Alpha(0)
            v:moveBy(0.3, 100)
            v:fadeIn(0.3)
        end
    end

    local size = self.Image_title:Size()
    self.Image_title:Pos(self.Image_title:PosX() + size.width, self.Image_title:PosY() + size.height)
    self.Image_title:moveBy(0.3, -size.width, -size.height)

    self.Image_roleName:Alpha(0)
    self.Image_roleName:fadeIn(0.5)
    self.Image_roleName:Pos(self.Image_roleName:PosX() + 300, self.Image_roleName:PosY() + 300)
    self.Image_roleName:moveBy(0.3, -300, -300)

    self.Image_info:PosX(self.Image_info:PosX() - 300):Alpha(0)
    self.Image_info:moveBy(0.3, 300)
    self.Image_info:fadeIn(0.3)

    self.Image_reach:Scale(1.2)
    self.Image_reach:scaleTo(0.2, 1.0)

    self.Image_reach2:Alpha(0.5)
    self.Image_reach2:scaleTo(0.2, 1.4)
    self.Image_reach2:fadeOut(0.3)

    self.Panel_root:setTouchEnabled(false)
    self.Panel_root:timeOut(function()
            self.Panel_root:setTouchEnabled(true)
    end, 0.4)
end


function MainLinePassView:registerEvents()
    self.Panel_root:onClick(function()
            -- if not GuideDataMgr:isStart() then
            --     GuideDataMgr:setIsStart(FubenDataMgr:isPassMainLine(1001))
            --     AlertManager:close()
            --     AlertManager:close()
            -- else
                AlertManager:close()
            -- end
    end)
end

return MainLinePassView
