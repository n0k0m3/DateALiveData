
local CardResult = class("CardResult",BaseLayer)

function CardResult:ctor( luckyCardData,callback)
    self.super.ctor(self)
    self:initData(luckyCardData,callback)
    self:init("lua.uiconfig.NewYear.cardResult")
end

function CardResult:initData(luckyCardData,callback)
    self.luckyCardData_ = luckyCardData
    dump(self.luckyCardData_)
    self.callback = callback
    self.color = {ccc3(92,180,241),ccc3(234,92,241),ccc3(255,153,0)}
end

function CardResult:initUI( ui )
    -- body
    self.super.initUI(self,ui)
    self.Button_confirm = TFDirector:getChildByPath(ui, "Button_confirm")
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    self.Image_bg = TFDirector:getChildByPath(ui, "Image_bg")
    self.pos = self.Image_bg:getPosition()
    local h = GameConfig.WS.height
    self.Image_bg:setPositionY(-h/2-10)

    self.info_ = {}
    for i=1,3 do
        local pl = TFDirector:getChildByPath(ui, "Panel_cardData_"..i)
        pl:setOpacity(0)
        local Label_name = TFDirector:getChildByPath(pl, "Label_name")
        local Label_score = TFDirector:getChildByPath(pl, "Label_score")
        local img_icon = TFDirector:getChildByPath(pl, "img_icon")
        table.insert(self.info_,{pl = pl, name = Label_name, score = Label_score, icon = img_icon})
    end

    self:initUILogic()
end

function CardResult:initUILogic()

    for i=1,3 do
        local data = self.luckyCardData_[i]
        if data then
            self.info_[i].pl:setVisible(true)
            self.info_[i].name:setText(data.name)
            local scoreNum = 0
            local itemId = 0
            for k,v in pairs(data.score) do
                itemId = k
                scoreNum = v
                break
            end
            local itemCfg = GoodsDataMgr:getItemCfg(itemId)
            self.info_[i].icon:setTexture(itemCfg.icon)
            self.info_[i].score:setText("+"..scoreNum)
            local quality = data.param
            self.info_[i].name:setColor(self.color[quality])
            self.info_[i].score:setColor(self.color[quality])

        end
    end
    local act = CCSequence:create({
        CCMoveTo:create(0.2,self.pos),
        CCDelayTime:create(0.2),
        CCCallFunc:create(function()
            self:FadeIn(1)
        end)
    })
    self.Image_bg:runAction(act)
end

function CardResult:FadeIn(id)
    local data = self.luckyCardData_[id]
    if not data then
        return
    end
    local act = CCSequence:create({
        CCFadeIn:create(0.3),
        CCCallFunc:create(function()
            local nextId = id + 1
            self:FadeIn(nextId)
        end)
    })
    self.info_[id].pl:runAction(act)
end

function CardResult:registerEvents()

    self.Button_close:onClick(function()
        if self.callback then
            self.callback()
        end
        AlertManager:closeLayer(self)
    end)

    self.Button_confirm:onClick(function()
        if self.callback then
            self.callback()
        end
        AlertManager:closeLayer(self)
    end)
end


return CardResult