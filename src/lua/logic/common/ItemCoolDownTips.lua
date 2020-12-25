--[[
  道具冷却提示
  itemId 道具ID
  targetNode 展示参考节点
]]

local lastCoolDownTipsTime = 0
local itemCoolDownTimes = {}
function showItemCoolDownTips(itemId, targetNode)
    if ServerDataMgr:getServerTime() - lastCoolDownTipsTime < 3 then
        return
    end
    local currentScene = Public:currentScene()
    local coolDownTips = currentScene:getChildByName("ItemCoolDownTips")

    if coolDownTips then
        coolDownTips:setVisible(false)
        coolDownTips:stopAllActions()
        currentScene:removeLayer(coolDownTips)
    end
    coolDownTips = ItemCoolDownTips:new("lua.uiconfig.common.itemCoolDownTips", itemId, targetNode)
    coolDownTips:showAnimIn()
    lastCoolDownTipsTime = ServerDataMgr:getServerTime()
    return coolDownTips
end

function getItemCoolDownTime(itemId)
    return itemCoolDownTimes[itemId]
end

function initItemCoolDownTimes(recoverTimeList)
    if recoverTimeList then
        for i, time in ipairs(recoverTimeList) do
            if i == 1 then
                if time > 0 then
                    itemCoolDownTimes[EC_SItemType.POWER] = time
                else
                    itemCoolDownTimes[EC_SItemType.POWER] = ServerDataMgr:getServerTime()
                end
            elseif i == 2 then
                if time > 0 then
                    itemCoolDownTimes[EC_SItemType.ENERGY] = time
                else
                    itemCoolDownTimes[EC_SItemType.ENERGY] = ServerDataMgr:getServerTime()
                end
            elseif i == 3 then
                if time > 0 then
                    itemCoolDownTimes[EC_SItemType.KABALA_ENERGY] = time
                else
                    itemCoolDownTimes[EC_SItemType.KABALA_ENERGY] = ServerDataMgr:getServerTime()
                end
            elseif i == 4 then
                if time > 0 then
                    itemCoolDownTimes[EC_SItemType.THEATER_COUNT] = time
                else
                    itemCoolDownTimes[EC_SItemType.THEATER_COUNT] = ServerDataMgr:getServerTime()
                end
            elseif i == 5 then
                if time > 0 then
                    itemCoolDownTimes[EC_SItemType.SX_BIRTHDAY_POWER] = time
                else
                    itemCoolDownTimes[EC_SItemType.SX_BIRTHDAY_POWER] = ServerDataMgr:getServerTime()
                end
			elseif i == 6 then
                if time > 0 then
                    itemCoolDownTimes[EC_SItemType.SZDY_TOUZI] = time
                else
                    itemCoolDownTimes[EC_SItemType.SZDY_TOUZI] = ServerDataMgr:getServerTime()
                end
            end
        end
    end
end

function updateItemCoolDownTimes(oldItem, newItem)
    local lastNum = oldItem and oldItem.num or 0
    if newItem then
        local itemId = tonumber(newItem.id)
        local maxNum = 99999
        if itemId == EC_SItemType.POWER then
            maxNum = TabDataMgr:getData("LevelUp", MainPlayer:getPlayerLv()).maxEnergy
        elseif itemId == EC_SItemType.ENERGY then
            maxNum = TabDataMgr:getData("LevelUp", MainPlayer:getPlayerLv()).maxVigour
        elseif itemId == EC_SItemType.KABALA_ENERGY then
            maxNum = KabalaTreeDataMgr:getMaxEnergy()
        elseif itemId == EC_SItemType.THEATER_COUNT then
            local itemCfg = GoodsDataMgr:getItemCfg(itemId)
            maxNum = itemCfg.totalMax
        elseif itemId == EC_SItemType.SX_BIRTHDAY_POWER then
            local itemCfg = GoodsDataMgr:getItemCfg(itemId)
            maxNum = itemCfg.totalMax

		elseif itemId == EC_SItemType.SZDY_TOUZI then
            local maxRecoverCount = StoreDataMgr:getItemRecoverCfg(30).maxRecoverCount
			if maxRecoverCount > 0 then
				maxNum = maxRecoverCount
			end
        end
		if (newItem.num - lastNum == 1) or (lastNum >= maxNum and newItem.num < maxNum) then
		    itemCoolDownTimes[tonumber(newItem.id)] = ServerDataMgr:getServerTime()
		end
    end
end


local ItemCoolDownTips = class("ItemCoolDownTips", BaseLayer)

function ItemCoolDownTips:ctor(uiPath, itemId, targetNode)
    self.super.ctor(self)
    self.m_itemId = itemId
    self.m_targetNode = targetNode
    self:init(uiPath)
end

function ItemCoolDownTips:onExit()
    self.super.onExit(self)
    local currentScene = self:getParent()
    currentScene:removeLayer(self)
end


function ItemCoolDownTips:initUI(ui)
    self.super.initUI(self, ui)
    local Label_tips_single = TFDirector:getChildByPath(ui, "Label_tips_single")
    local Label_tips_total = TFDirector:getChildByPath(ui, "Label_tips_total")
    local itemRecoverMap = TabDataMgr:getData("ItemRecover")

    local recoverCfg, maxNum, curNum, tipsId
    for k,v in pairs(itemRecoverMap) do
        if v.item_id == self.m_itemId and v.cooldown > 0 then
            recoverCfg = v
            break
        end
    end
    if self.m_itemId == EC_SItemType.POWER then
        maxNum = TabDataMgr:getData("LevelUp", MainPlayer:getPlayerLv()).maxEnergy
        curNum = GoodsDataMgr:getItemCount(EC_SItemType.POWER)
        tipsId = 800052
    elseif self.m_itemId == EC_SItemType.ENERGY then
        maxNum = TabDataMgr:getData("LevelUp", MainPlayer:getPlayerLv()).maxVigour
        curNum = GoodsDataMgr:getItemCount(EC_SItemType.ENERGY)
        tipsId = 800053
    elseif self.m_itemId == EC_SItemType.KABALA_ENERGY then
        maxNum = KabalaTreeDataMgr:getMaxEnergy()
        curNum = KabalaTreeDataMgr:getEnergy()
        tipsId = 800055
    elseif self.m_itemId == EC_SItemType.SX_BIRTHDAY_POWER then
        local itemCfg = GoodsDataMgr:getItemCfg(self.m_itemId)
        maxNum = itemCfg.totalMax
        curNum = GoodsDataMgr:getItemCount(self.m_itemId)
        tipsId = 1023023
    elseif self.m_itemId == EC_SItemType.REVERSAL then
        recoverCfg = true
        curNum = 1
        maxNum = 0
        tipsId = 800132
    elseif self.m_itemId == EC_SItemType.LOVER then
        recoverCfg = true
        curNum = 1
        maxNum = 0
        tipsId = 800133
	elseif self.m_itemId == EC_SItemType.SZDY_TOUZI then
		recoverCfg = true
        curNum = 1
        maxNum = 0
        tipsId = 800052
    end
    if not recoverCfg or not curNum then
        return
    end
    if curNum >= maxNum then
        Label_tips_single:setVisible(false)
        Label_tips_total:setVisible(true)
        Label_tips_total:setPositionY(-3)
        Label_tips_total:setTextById(tipsId)
    else
        Label_tips_single:setVisible(true)
        Label_tips_total:setVisible(true)
        Label_tips_total:setPositionY(-15)
        local subNum = maxNum - curNum
        local coolDownTime = itemCoolDownTimes[self.m_itemId]
        local passTime = ServerDataMgr:getServerTime() - coolDownTime
        if coolDownTime and passTime > 0 then
            coolDownTime = recoverCfg.cooldown - passTime % recoverCfg.cooldown
        else
            itemCoolDownTimes[self.m_itemId] = ServerDataMgr:getServerTime()
            coolDownTime = recoverCfg.cooldown
        end
        coolDownTime = math.max(coolDownTime, 0)
        if coolDownTime == 0 then
            coolDownTime = recoverCfg.cooldown
            itemCoolDownTimes[self.m_itemId] = ServerDataMgr:getServerTime()
        end
        local day, hour, min, sec = Utils:getDHMS(coolDownTime, true)
        Label_tips_single:setTextById(800050, min, sec)
        day, hour, min, sec = Utils:getTimeDHMZ(math.max(((subNum - 1) * recoverCfg.cooldown + coolDownTime), 0), true)
        dump((subNum - 1) * recoverCfg.cooldown + coolDownTime)
        hour = day*24 + hour
        Label_tips_total:setTextById(800051, hour, min, sec)
    end

    local size = self.m_targetNode:getContentSize()
    local anchorPoint = self.m_targetNode:getAnchorPoint()
    local boundingBox = self.m_targetNode:boundingBox()
    local pos = ccp(boundingBox.origin.x + boundingBox.size.width / 2, boundingBox.origin.y + boundingBox.size.height / 2)
    pos = self.m_targetNode:getParent():convertToWorldSpace(pos)
    pos.x = pos.x + size.width * anchorPoint.x / 2 - 20
    pos.y = pos.y + size.height * anchorPoint.y / 2 - 60
    self:setPosition(pos)
end

function ItemCoolDownTips:showAnimIn()
    local currentScene = Public:currentScene()
    self:setName("ItemCoolDownTips")

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
        delay = 2.2
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

return ItemCoolDownTips
