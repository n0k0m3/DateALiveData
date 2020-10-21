
local BingoActivityView = class("BingoActivityView", BaseLayer)

function BingoActivityView:initData(activityId)
    self.activityId_ = activityId
    self.isHandle_ = false
    self.taskItems_ = {}
    self.resource = {}
end

function BingoActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.bingoActivityView")
end

function BingoActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_theme = TFDirector:getChildByPath(self.Panel_root, "Panel_theme")
    self.Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Panel_cg = TFDirector:getChildByPath(self.Image_content, "Image_frame.Panel_cg")
    self.Label_time_title = TFDirector:getChildByPath(self.Image_content, "Label_time_title")
    self.Label_time = TFDirector:getChildByPath(self.Image_content, "Label_time")
    self.Button_goto = TFDirector:getChildByPath(self.Image_content, "Button_goto")
    self.Label_goto = TFDirector:getChildByPath(self.Button_goto, "Label_goto")
    self.Label_tip = TFDirector:getChildByPath(self.Image_content, "Label_tip")

    self.Image_theme = TFDirector:getChildByPath(self.Panel_root, "Image_theme")

    self.itemtab = {}
    for i=1,2 do
        self.itemtab[i] = {}
        self.itemtab[i].bg = TFDirector:getChildByPath(self.Image_content, "Image_icon"..i)
        self.itemtab[i].numTx = TFDirector:getChildByPath(self.itemtab[i].bg, "Label_num")
        self.itemtab[i].icon = TFDirector:getChildByPath(self.itemtab[i].bg, "Image_icon")
    end

    self:refreshView()
end

function BingoActivityView:updateItem()
    for i=1,2 do
        local itemId = self.resource[i]
        if itemId then
            local itemCfg = GoodsDataMgr:getItemCfg(itemId)
            local num = GoodsDataMgr:getItemCount(itemId)
            self.itemtab[i].icon:setTexture(itemCfg.icon)
            self.itemtab[i].numTx:setText(num)
            self.itemtab[i].bg:setVisible(true)
        else
            self.itemtab[i].bg:setVisible(false)
        end
    end
end

function BingoActivityView:refreshView()
    self.Label_goto:setTextById(310016)
    self.Label_time_title:setTextById(1710002)
    BingoDataMgr:Send_enterBingGame()
end

function BingoActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.Label_time:setText(Utils:getActivityDateString(self.activityInfo_.startTime, self.activityInfo_.endTime, self.activityInfo_.extendData.dateStyle))
    dump(self.activityInfo_)
    if not self.cgView_ then
        if self.activityInfo_.extendData.cg then
            local cg_cfg = TabDataMgr:getData("Cg")[self.activityInfo_.extendData.cg]
            local cgView = requireNew("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil, false, function() end)
            local size = self.Panel_cg:getSize()
            local scaleX = size.width/cgView:Size().width
            local scaleY = size.height/cgView:Size().height
            cgView:setScale(math.max(scaleX, scaleY))
            self.Panel_cg:addChild(cgView)
            self.cgView_ = cgView
        end
    end

    self.Image_theme:setTexture(self.activityInfo_.showIcon)
    self.Image_theme:setScale(0.75)
    self.Label_tip:setText(self.activityInfo_.extendData.dec)

    local extendData = self.activityInfo_.extendData or {}
    self.resource = extendData.resourceView or {}
    self:updateItem()
end

function BingoActivityView:registerEvents()

    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateItem, self))

    self.Button_goto:onClick(function()
        local layerName = {"ItemAccessView","ItemInfoView","BingoMainView"}
        for k,v in ipairs(layerName) do
            local isLayerInQueue,layer = AlertManager:isLayerInQueue(v)
            if isLayerInQueue then
                AlertManager:closeLayer(layer)
            end
        end
        Utils:openView("bingo.BingoMainView")
    end)
end

function BingoActivityView:onShow()
    self.super.onShow(self)
end


return BingoActivityView
