
local EndlessPlusLevelResultView = class("EndlessPlusLevelResultView", BaseLayer)

function EndlessPlusLevelResultView:initData(levelCid,callback)
    self.levelCfg_ = BattleDataMgr:getLevelCfg()
    self.levelCid = levelCid
    self.callback = callback
end

function EndlessPlusLevelResultView:ctor(levelCid,callback)
    self.super.ctor(self)
    self:initData(levelCid,callback)
    self:init("lua.uiconfig.battle.endlessLevelResultView")
end

function EndlessPlusLevelResultView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_roleItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_roleItem")

    self.Spine_win = TFDirector:getChildByPath(self.Panel_root, "Spine_win")
    self.Image_remainTime = TFDirector:getChildByPath(self.Panel_root, "Image_remainTime")
    self.Label_remainTime_title = TFDirector:getChildByPath(self.Image_remainTime, "Label_remainTime_title")
    self.Label_remainTime = TFDirector:getChildByPath(self.Image_remainTime, "Label_remainTime")
    self.Image_jump = TFDirector:getChildByPath(self.Panel_root, "Image_jump")
    self.Label_jump_title = TFDirector:getChildByPath(self.Image_jump, "Label_jump_title")
    self.Label_cur_level = TFDirector:getChildByPath(self.Image_jump, "Label_cur_level")
    self.Image_goto = TFDirector:getChildByPath(self.Image_jump, "Image_goto"):hide()
    self.Label_goto = TFDirector:getChildByPath(self.Image_goto, "Label_goto")
    self.Label_goto:setPositionY(17)
    self.Label_goto_level = TFDirector:getChildByPath(self.Image_goto, "Label_goto_level")
    self.Label_jump_level = TFDirector:getChildByPath(self.Image_goto, "Label_jump_level")
    self.Image_hp = TFDirector:getChildByPath(self.Panel_root, "Image_hp"):hide()
    self.Label_hp_title = TFDirector:getChildByPath(self.Image_hp, "Label_hp_title")
    local ScrollView_role = TFDirector:getChildByPath(self.Image_hp, "ScrollView_role")
    self.ListView_role = UIListView:create(ScrollView_role)
    self.Image_reward = TFDirector:getChildByPath(self.Panel_root, "Image_reward"):hide()
    self.Label_reward_title = TFDirector:getChildByPath(self.Image_reward, "Label_reward_title")
    local ScrollView_reward = TFDirector:getChildByPath(self.Image_reward, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_role:setItemsMargin(5)
    self:refreshView()
end

function EndlessPlusLevelResultView:refreshView()

    self.Image_goto:show()
    self.Label_remainTime_title:setTextById(300870)
    self.Label_jump_title:setTextById(310030)

    local cfg = FubenEndlessPlusDataMgr:getFloorDungeonLevelCfg(self.levelCid)
    if not cfg then
        return
    end
    self.Label_cur_level:setTextById(cfg.dungeonName)
    self.Label_jump_level:setText("")

    local x = self.Label_cur_level:getPositionX() + self.Label_cur_level:getContentSize().width
    self.Image_goto:setPositionX(x + 45+5)

    local nextLevelCfg = FubenEndlessPlusDataMgr:getFloorDungeonLevelCfg(cfg.nextDungeon)
    if not nextLevelCfg then
        return
    end
    self.Label_goto_level:setTextById(nextLevelCfg.dungeonName)

    local remainMsec = self.levelCfg_.time * 1000 - battleController.getTime()
    local _, hour, min, sec = Utils:getDHMS(math.floor(remainMsec / 1000), true)
    self.Label_remainTime:setTextById(800014, min, sec)

end

function EndlessPlusLevelResultView:registerEvents()
    self.Panel_touch:onClick(function()

        local isInstage = FubenEndlessPlusDataMgr:inStageTime()
        if isInstage then
            EventMgr:dispatchEvent(EV_FUBEN_ENDLESSPLUS_CONTINUE,self.levelCid)
            AlertManager:closeLayer(self)
        else
            print("EndlessPlusLevelResultViewEndlessPlusLevelResultView")
            if self.callback then
                print("xxxxx1sdasdadada")
                self.callback()
            end
        end   
    end)
end

return EndlessPlusLevelResultView
