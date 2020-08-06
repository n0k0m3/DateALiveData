local FavorAndMoodView = class("FavorAndMoodView",BaseLayer)

function FavorAndMoodView:initData(data)
    self.roleId = data.roleId or RoleDataMgr:getCurId()
    self.lastRoleInfo = data.lastRoleInfo
    self.lastFavorLevel = self.lastRoleInfo.favorLevel
    self.curFavorLevel = self.lastFavorLevel
    self.lastFavor = clone(self.lastRoleInfo.favor)
    self.curFavor = self.lastFavor
    self.curLvMaxFavor = self.lastRoleInfo.curLvMaxFavor
    self.ruleId = data.ruleId
    self.hideBg = data.hideBg

    self.useRoleInfo = clone(RoleDataMgr:getRoleInfo(self.roleId))
    self.sMsg = DatingDataMgr:getDatingSettlementMsg() or {}
    if #self.sMsg == 0 then
      self.sMsg.favor = self.useRoleInfo.favor - self.lastFavor
      self.sMsg.mood = self.useRoleInfo.mood - self.lastRoleInfo.mood
    end

    print("self.lastFavor ",self.lastFavor)
    print("self.useRoleInfo.favor ",self.useRoleInfo.favor)
    print("self.lastRoleInfo.mood ",self.lastRoleInfo.mood)
    print("self.useRoleInfo.mood ",self.useRoleInfo.mood)
    print("self.sMsg ",self.sMsg)
end

function FavorAndMoodView:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.favorAndMoodView")
end

function FavorAndMoodView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui
    self:initFavorMood()
end

function FavorAndMoodView:initFavorMood()
    local Panel_favor = TFDirector:getChildByPath(self.ui,"Panel_favor")
    local Panel_mood = TFDirector:getChildByPath(self.ui,"Panel_mood")
    self.Label_desc = TFDirector:getChildByPath(self.ui,"Label_desc")
    local curScript = DatingDataMgr:getCurDatingScript()
    local ruleId = self.ruleId or curScript.datingRuleCid
    local ruleData = DatingDataMgr:getDatingRuleData(ruleId)

    local Image_head_bg1 = TFDirector:getChildByPath(self.ui,"Image_head_bg1")
    local Image_head = TFDirector:getChildByPath(self.ui,"Image_head")
    local Image_head_bg2 = TFDirector:getChildByPath(self.ui,"Image_head_bg2")
    if self.hideBg then
        Image_head_bg1:setVisible(false)
        Image_head:setVisible(false)
        Image_head_bg2:setVisible(false)
        self.Label_desc:setVisible(false)
        Panel_favor:setPosition(ccp(413, 362))
        Panel_mood:setPosition(ccp(413, 252))
    end

    Image_head:setContentSize(CCSizeMake(130, 150))
    Image_head:setTexture(ruleData.portail)
    self.Label_desc:setTextById(ruleData.endSynopsis)

    self.Label_favor = TFDirector:getChildByPath(Panel_favor,"Label_favor")
    self.addFavor = self.sMsg.favor or self.useRoleInfo.favor - self.lastRoleInfo.favor
    if self.addFavor then
        if self.addFavor < 0 then
            self.Label_favor:setText(tostring(self.addFavor))
        else
            self.Label_favor:setText("+"..self.addFavor)
        end
    else
        self.Label_favor:setText("+0")
    end
    
    self.Label_mod = TFDirector:getChildByPath(Panel_mood,"Label_mod")
    if self.sMsg.mood and self.sMsg.mood ~= 0 then
      if self.sMsg.mood < 0 then
        self.Label_mod:setText(tostring(self.sMsg.mood))
      else
        self.Label_mod:setText("+"..self.sMsg.mood)
      end
    else
        self.Label_mod:setText("+0")
    end
end

function FavorAndMoodView:playAction()
    local time = 1

    self:timeOut(function()
        local newFavorLevel = self.useRoleInfo.favorLevel
        local p = self.useRoleInfo.favorPercent
        local percents = {}
        for i = 1 , newFavorLevel-self.lastFavorLevel do
            table.insert(percents,{0,100})
        end
        table.insert(percents,{0,p})
        local index = 1
        if self.sMsg.favor and self.sMsg.favor ~= 0 then
            Utils:loadingBarAddAction(self.LoadingBar_favor, percents[index][2],
                                        function()
                                          index = index + 1
                                          if percents[index] and self.curFavorLevel ~= self.lastFavorLevel+(index-1) then
                                              local data = {}
                                              data.lastLevel = self.lastFavorLevel
                                              data.newLevel = self.lastFavorLevel + (index-1)
                                              self.curFavorLevel = data.newLevel
                                              favorUpgradeLayer = require("lua.logic.dating.FavorUpgradeLayer"):new(data)
                                              AlertManager:addLayer(favorUpgradeLayer,AlertManager.BLOCK,AlertManager.TWEEN_NONE)
                                              AlertManager:show()
                                              return percents[index][1], percents[index][2]
                                          end
                                          return nil
                                        end,
                                        nil,
                                        function()
                                          if self.LoadingBar_favor:getParent():getChildByName("img") then
                                              self.LoadingBar_favor:getParent():getChildByName("img"):hide()
                                          end
                                          local sFavor = RoleDataMgr:percentToFavor(self.LoadingBar_favor:getPercent(),self.roleId,self.curFavorLevel)
                                          self.curLvMaxFavor = RoleDataMgr:getLvMaxFavor(self.roleId, self.curFavorLevel)
                                          if self.curFavorLevel == self.useRoleInfo.favorLevel and sFavor > self.useRoleInfo.favor then
                                            sFavor = self.useRoleInfo.favor
                                          end

                                          if self.sMsg.favor < 0 then
                                            self.Label_barFavorValue:setTextById("r50003",sFavor,"("..self.sMsg.favor..")"," /"..self.curLvMaxFavor)
                                          else
                                            self.Label_barFavorValue:setTextById("r50003",sFavor,"(+"..self.sMsg.favor..")"," /"..self.curLvMaxFavor)
                                          end
                                        end
                                        )
        end

        if self.sMsg.mood and self.sMsg.mood ~= 0 then
            Utils:loadingBarAddAction(self.LoadingBar_mood, self.useRoleInfo.mood,
                                       function()
                                          return nil
                                        end,
                                        nil,
                                        function()
                                            if self.LoadingBar_mood:getParent():getChildByName("img") then
                                                self.LoadingBar_mood:getParent():getChildByName("img"):hide()
                                            end
                                            local moodValue = math.ceil(self.LoadingBar_mood:getPercent())
                                            moodValue = moodValue > self.useRoleInfo.mood and self.useRoleInfo.mood or moodValue
                                            if self.sMsg.mood < 0 then
                                              self.Label_barMoodValue:setTextById("r50004",moodValue,"("..self.sMsg.mood..")"," /"..100)
                                            else
                                              self.Label_barMoodValue:setTextById("r50004",moodValue,"(+"..self.sMsg.mood..")"," /"..100)
                                            end
                                        end
                                          )

        end
    end,time)

end


function FavorAndMoodView:onShow()
    self.super.onShow(self)
end

function FavorAndMoodView:onClose()
    self.super.onClose(self)
    TFAudio.stopMusic()
end

function FavorAndMoodView:registerEvents()

end

return FavorAndMoodView;
