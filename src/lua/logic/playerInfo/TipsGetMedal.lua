
local TipsGetMedal = class("TipsGetMedal", BaseLayer)

function TipsGetMedal:ctor(text1,text2)
    self.super.ctor(self)
    self.text1 = text1
    self.text2 = text2
    self:init("lua.uiconfig.playerInfo.tipsGetMedal")
end

function TipsGetMedal:onExit()
    self.super.onExit(self)
    local currentScene = self:getParent()
    currentScene:removeLayer(self)
end

function TipsGetMedal:initUI(ui)
    self.super.initUI(self,ui)
    self:setPosition(ccp(GameConfig.WS.width/2, GameConfig.WS.height - 100))
    local currentScene = Public:currentScene()
    self:setName("TipsGetMedal")
    TFDirector:getChildByPath(ui, 'text1'):setText(self.text1)
    TFDirector:getChildByPath(ui, 'text2'):setText(self.text2)

    currentScene:addLayer(self)
    self:setZOrder(1000)
    local toY = self:getPosition().y + 80
    local toX = self:getPosition().x

    if toY > GameConfig.WS.height - 50 then
       toY = GameConfig.WS.height - 50
    end

    self:setOpacity(150)

    local actions = {
          target = self,
          {
            duration = 0.1,
            x = toX,
            y = toY,
            alpha = 0.9,
          },
          {
            duration = 0.05,
            y = toY +2,
          },
          {
            duration = 0.05,
            y = toY -1,
          },
          {
             duration = 0.1,
             alpha = 1,
          },
          {
            duration = 0,
            delay = 2
          },
          {
            duration = 0.1,
            y = toY - 4,
            alpha = 0.7,
          },
          {
            duration = 0.1,
            y = toY + 2,

          },
          {
             duration = 0,

          },
          {
             duration = 0.1,
             alpha = 0,
             y = toY + 100,
          },
          {
            duration = 0,
            onComplete = function()
                local currentScene = Public:currentScene()
                currentScene:removeLayer(self)
           end
          }
        }

    TFDirector:toTween(actions)
end

return TipsGetMedal
