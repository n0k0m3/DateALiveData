--[[
    @名师特权界面
]]

local MasterPrivilegeView = class("MasterPrivilegeView", BaseLayer)

function MasterPrivilegeView:initData()
    self.items = {}
    local experienceItemId  = Utils:getKVP(90023, "experienceItemId")
    self.exprienceItemNum = GoodsDataMgr:getItemCount(experienceItemId) or 0
    self.curFamousLv = FriendDataMgr:getFamousLvByExperience(self.exprienceItemNum)
    self.cfgs = FriendDataMgr:getInstructorLevelCfg()
    self.curSelectLv = 1
    self.curSelectIdx = 1
end

function MasterPrivilegeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.friend.masterPrivilegeView")
end

function MasterPrivilegeView:initUI(ui)
    self.super.initUI(self, ui)
    self:showPopAnim(true)
    
    self._ui.scrollView:setTouchEnabled(false)
    self.turnView = UITurnView:create(self._ui.scrollView)
    self.turnView:setItemModel(self._ui.Panel_info)

    self._ui.lab_TopTxt:setTextById(1340026)
    self._ui.lab_lvDesc:setTextById(1340084)
    self:refreshView()
end

function MasterPrivilegeView:refreshView()
    for i = 1, #self.cfgs do
        self:addItem()
    end
    self:refreshItemData()
end

function MasterPrivilegeView:addItem()
    local item = self.turnView:pushBackItem()
    local foo = {}
    foo.rewards = {}
    foo.root = item
    foo.lab_lv = TFDirector:getChildByPath(foo.root, "img_icon.lab_lv")
    foo.bg = TFDirector:getChildByPath(foo.root, "bg")
    foo.lab_exp = TFDirector:getChildByPath(foo.bg, "lab_exp")
    foo.lab_name = TFDirector:getChildByPath(foo.bg, "lab_name")
    foo.progressBar = TFDirector:getChildByPath(foo.bg, "img_progress.progressBar")
    foo.Panel_reward = TFDirector:getChildByPath(foo.root, "Panel_reward")
    foo.img_rewardBg = TFDirector:getChildByPath(foo.Panel_reward, "img_rewardBg")
    foo.lab_rewardDisc = TFDirector:getChildByPath(foo.img_rewardBg, "lab_rewardDisc")
    foo.Panel_rewards = TFDirector:getChildByPath(foo.Panel_reward, "Panel_rewards")
    for i = 1, #foo.Panel_rewards:getChildren() do
        local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        goodsItem:setScale(0.7)
        local pos = TFDirector:getChildByPath(foo.Panel_rewards,string.format("pos_%s", i)):getPosition()
        goodsItem:AddTo(foo.Panel_rewards):Pos(pos):ZO(1)
        foo.rewards[i] = goodsItem
    end
    self.items[foo.root] = foo
    return foo.root
end

function MasterPrivilegeView:refreshItemData()
    for idx, cfg in ipairs(self.cfgs) do
        local item = self.items[self.turnView:getItem(idx)]
        item.lab_lv:setText(cfg.instructorlevel)
        item.lab_exp:setText(self.exprienceItemNum.."/"..cfg.updateExp)
        item.lab_name:setText(cfg.des)
        local perCent = self.exprienceItemNum / cfg.updateExp
        perCent = perCent > 1 and 1 or perCent
        item.progressBar:setPercent(perCent*100)
        item.lab_rewardDisc:setTextById(1340053, cfg.instructorlevel)

        local num = #cfg.reward
        local dis = 100
        local posBeginX = (num - 1) * dis / 2
        for i, v in ipairs(item.rewards) do 
            if cfg.reward[i] then
                PrefabDataMgr:setInfo(v, cfg.reward[i][1],cfg.reward[i][2])
                v:setVisible(true)
                v:setPositionX(posBeginX - (i - 1) * dis)
            else
                v:setVisible(false)
            end
        end
    end
    self:refreshBtns()
end

function MasterPrivilegeView:refreshBtns()
    local cfg = nil
    for i, v in ipairs(self.cfgs) do
        if v.instructorlevel == self.curSelectLv then
            cfg = v
            break
        end
    end

    local isHadGet = FriendDataMgr:getFamousBoolByLv(cfg.instructorlevel)
    self._ui.btn_getReward:setVisible(cfg.instructorlevel <= self.curFamousLv and not isHadGet)
    self._ui.btn_getReward:onClick(function()
        FriendDataMgr:send_APPRENTICE_REQ_FAMOUS_REWARD(cfg.instructorlevel)
    end)

    self._ui.btn_left:setVisible(self.curSelectLv ~= 1)
    self._ui.btn_right:setVisible(self.curSelectLv ~= #self.cfgs)
end

function MasterPrivilegeView:registerEvents()
    self._ui.btn_close:onClick(function()
        AlertManager:close(self)
    end)
    self.turnView:registerSelectCallback(handler(self.onTurnViewSelect, self))
    EventMgr:addEventListener(self,EV_FRIEND_MASTERGETREWARD_UPDATE, handler(self.refreshBtns,self))

    self._ui.btn_left:onClick(function()
        self.turnView:scrollToItem(self.curSelectIdx - 1)
    end)
    self._ui.btn_right:onClick(function()
        self.turnView:scrollToItem(self.curSelectIdx + 1)
    end)
end

function MasterPrivilegeView:onTurnViewSelect(target, idx)
    local _cfg = self.cfgs[idx]
    self.curSelectIdx = idx
    self.curSelectLv = _cfg.instructorlevel
    self:refreshBtns()
end

return MasterPrivilegeView