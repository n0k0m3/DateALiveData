--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 通用提示悬浮界面
* 
]]

local TipTool = class("TipTool", BaseLayer)

function TipTool:ctor(uiPath, targetNode, offsetPos)
    self.super.ctor(self)
    self.m_targetNode = targetNode
    self.offsetPos = offsetPos or ccp(0, 0)
    self:init(uiPath)
end

function TipTool:initUI(ui)
    self.super.initUI(self, ui)
    local Label_tips_single = TFDirector:getChildByPath(ui, "Label_tips_single")
    local Label_tips_total = TFDirector:getChildByPath(ui, "Label_tips_total")

    Label_tips_single:setTextById(800137)
    local cnt = GoodsDataMgr.minusDiamond or 0
    Label_tips_total:setTextById(800138, cnt)

    local size = self.m_targetNode:getContentSize()
    local anchorPoint = self.m_targetNode:getAnchorPoint()
    local boundingBox = self.m_targetNode:boundingBox()
    local pos = ccp(boundingBox.origin.x + boundingBox.size.width / 2, boundingBox.origin.y + boundingBox.size.height / 2)
    pos = self.m_targetNode:getParent():convertToWorldSpace(pos)
    pos.x = pos.x + size.width * anchorPoint.x / 2 - 20
    pos.y = pos.y + size.height * anchorPoint.y / 2 - 60
    pos.x = pos.x + self.offsetPos.x
    pos.y = pos.y + self.offsetPos.y
    self:setPosition(pos)
end

function TipTool:showAnimIn()
    local currentScene = Public:currentScene()
    self:setName("TipTool")

    if not self:getParent() then
        currentScene:addLayer(self)
    end
    self:setZOrder(777)
    self:setOpacity(100)
    self.toScene = currentScene

    local toastTween = {
      target = self,
      {
         duration = 0.2,
         alpha = 1,
      },
      {
        duration = 0,
        delay = 1.5
      },
      {
         duration = 0.2,
         alpha = 0,
      },
      {
        duration = 0,
        onComplete = function()
            local currentScene = Public:currentScene()
            if self.toScene == currentScene then
                currentScene:removeLayer(self)
            end
       end
      }
    }
    TFDirector:toTween(toastTween)
end

function TipTool:onExit()
    self.super.onExit(self)
    local currentScene = self:getParent()
    currentScene:removeLayer(self)
end

return TipTool