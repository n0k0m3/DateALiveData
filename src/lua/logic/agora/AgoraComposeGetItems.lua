local AgoraComposeGetItems = class("GetItemView", BaseLayer)

function AgoraComposeGetItems:ctor(reward, luckyreward)
    self.super.ctor(self)
    self:initData(reward, luckyreward)
    self:init("lua.uiconfig.agora.agoraComposeGetItems")
end

function AgoraComposeGetItems:initData(reward, luckyreward)
    self.reward = reward[1]
    self.luckyReward = luckyreward[1]
end

function AgoraComposeGetItems:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_normal = TFDirector:getChildByPath(ui, "Panel_normal")
    self.Panel_lucky = TFDirector:getChildByPath(ui, "Panel_lucky")

    self:showReward()
end

function AgoraComposeGetItems:showReward()
    local Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
    
    local goodsItem_n = Panel_goodsItem_prefab:clone():Scale(0.8):Pos(0, 0)
    PrefabDataMgr:setInfo(goodsItem_n, self.reward.id, self.reward.num)
    self.Panel_normal:addChild(goodsItem_n)

    local goodsItem_l = Panel_goodsItem_prefab:clone():Scale(0.8):Pos(0, 0)
    PrefabDataMgr:setInfo(goodsItem_l, self.luckyReward.id, self.luckyReward.num)
    self.Panel_lucky:addChild(goodsItem_l)

    local offsetX = self.Panel_normal:Size().width * 0.5
    self.Panel_normal:runAction(Sequence:create({
        CallFunc:create(function()
            self.Panel_normal:Alpha(0)
            self.Panel_normal:PosX(self.Panel_normal:PosX() - offsetX)
        end),
        Spawn:create({
                CCFadeIn:create(0.2),
                MoveBy:create(0.2, ccp(offsetX, 0)),
        })
    }))
    self.Panel_lucky:runAction(Sequence:create({
        CallFunc:create(function()
            self.Panel_lucky:Alpha(0)
            self.Panel_lucky:PosX(self.Panel_lucky:PosX() - offsetX)
        end),
        Spawn:create({
                CCFadeIn:create(0.2),
                MoveBy:create(0.2, ccp(offsetX, 0)),
        })
    }))
end

return AgoraComposeGetItems