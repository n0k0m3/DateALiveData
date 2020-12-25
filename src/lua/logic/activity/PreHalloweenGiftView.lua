local PreHalloweenGiftView = class("PreHalloweenGiftView",BaseLayer)

function PreHalloweenGiftView:initData(ghostPos,ghostId,callback)

    self.callback = callback
    self.ghostPos = ghostPos
    self.ghostId = ghostId
    self.phantomCfg = TabDataMgr:getData("Phantom")

end

function PreHalloweenGiftView:ctor(ghostPos,ghostId,callback)
    self.super.ctor(self)
    self:initData(ghostPos,ghostId,callback)
    self:init("lua.uiconfig.activity.preHalloweenGiftView")
end

function PreHalloweenGiftView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_role_talk = TFDirector:getChildByPath(ui,"Panel_role_talk")
    self.Image_talk_bg = TFDirector:getChildByPath(self.Panel_role_talk,"Image_talk_bg")
    self.TextArea_talk = TFDirector:getChildByPath(self.Panel_role_talk,"TextArea_talk")
    self.Image_talk_bg = TFDirector:getChildByPath(self.Panel_role_talk,"Image_talk_bg")
    self.Button_talk_next = TFDirector:getChildByPath(self.Panel_role_talk,"Button_talk_next")
    self.Image_role = TFDirector:getChildByPath(self.Panel_role_talk,"Image_role")

    self.default_roleLineH = self.TextArea_talk:getLineHeight()
    self.default_roleFontSize = self.TextArea_talk:getFontSize()


    self.Button_exit = TFDirector:getChildByPath(ui,"Button_exit")
    self.Button_choose = TFDirector:getChildByPath(ui,"Button_choose")
    self.Label_back = TFDirector:getChildByPath(ui,"Label_back"):hide()
    self.Label_finish = TFDirector:getChildByPath(ui,"Label_finish"):hide()
    self:initUILogic()
end

function PreHalloweenGiftView:initUILogic()

    local cfg = self.phantomCfg[self.ghostId]
    if not cfg then
        return
    end

    self.Image_role:setTexture(cfg.phantomIcon)

    self.Label_back:show()
    self.Label_finish:hide()
    local openIndex = math.random(1,#cfg.open)
    local openWorlds = cfg.open[openIndex] or ""
    self:updateGhostWorld(openWorlds)
end

function PreHalloweenGiftView:updateGhostWorld(strId,isEnd)

    local strlen = 0
    local str = TextDataMgr:getText(strId)
    local defaultLineH = self.default_roleLineH
    local maxLineHeight = defaultLineH

    local curlen = string.utf8len(str)
    local seidx = {strlen + 1,strlen + curlen}
    strlen = strlen + curlen

    local cuttxtinfo = {txtpos = seidx,times = curlen}

    self.TextArea_talk:setLineBreakWithoutSpace(true)
    self.TextArea_talk:setText(str)
    self.TextArea_talk:setLineHeight(maxLineHeight)
    local actionArr = {}
    self.TextArea_talk.fidx = 0
    self.TextArea_talk.strlen = strlen

    for j = cuttxtinfo.txtpos[1],cuttxtinfo.txtpos[2] do
        local letter = self.TextArea_talk:getLetter(j-1)
        if letter then
            letter:setVisible(false)
            local doShowLetter = CallFunc:create(function()
                local tmletter = self.TextArea_talk:getLetter(self.TextArea_talk.fidx)
                if tmletter then
                    tmletter:setVisible(true)
                end
                self.TextArea_talk.fidx = self.TextArea_talk.fidx + 1
            end)
            local delayTime = DelayTime:create(0.04)
            local actsequence = Sequence:create({doShowLetter,delayTime})
            actionArr[#actionArr + 1] = actsequence
        end
    end

    --if not isEnd then
    --    local act = CCCallFunc:create(function ()
    --        Utils:openView("activity.PreHalloweenPopView",self.ghostPos,self.ghostId)
    --    end)
    --    actionArr[#actionArr + 1] = act
    --end


    local tmSequence = Sequence:create(actionArr)
    self.TextArea_talk:runAction(tmSequence)

end

function PreHalloweenGiftView:afterGift(award,giftIndex)

    self.Button_choose:hide()
    self.Label_back:hide()
    self.Label_finish:show()
    self.award = award or {}

    local cfg = self.phantomCfg[self.ghostId]
    if not cfg then
        self:close()
        return
    end

    if not giftIndex then
        self:close()
        return
    end

    local endWorlds = cfg.ed[giftIndex]
    if not endWorlds then
        self:close()
        return
    end

    self:updateGhostWorld(endWorlds,true)
end

function PreHalloweenGiftView:close()
    if self.callback then
        self.callback(self.award)
    end
    AlertManager:closeLayer(self)
end


function PreHalloweenGiftView:registerEvents()

    EventMgr:addEventListener(self, EV_PRE_HALLOWEEN_GIFT, handler(self.afterGift, self))

    self.Button_exit:onClick(function()
       self:close()
    end)

    self.Button_talk_next:onClick(function()
        self:close()
    end)

    self.Button_choose:onClick(function()
        Utils:openView("activity.PreHalloweenPopView",self.ghostPos,self.ghostId)
    end)
end



return PreHalloweenGiftView