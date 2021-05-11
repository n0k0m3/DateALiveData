
local TopBar = class("TopBar", BaseLayer)

CREATE_PANEL_FUN(TopBar)

function TopBar:ctor(data)
    self.super.ctor(self,data)

    self.topData = data;

    self.topBarType_ = {EC_TopbarType.DIAMOND, EC_TopbarType.GOLD, EC_TopbarType.POWER}

    self:init("lua.uiconfig.common.topLayer")
end

function TopBar:initUI(ui)
    self.super.initUI(self,ui)

    self.top_part1      = TFDirector:getChildByPath(ui,"top_part1");
    self.resourcePanel      = TFDirector:getChildByPath(ui,"top_part2");
    self.item1Label         = TFDirector:getChildByPath(ui,"Label_tili"):hide();
    self.item2Label         = TFDirector:getChildByPath(ui,"Label_coin"):hide();
    self.item3Label         = TFDirector:getChildByPath(ui,"Label_zuan"):hide();
    self.item1Icon          = TFDirector:getChildByPath(ui,"Image_tili"):hide();
    self.item2Icon          = TFDirector:getChildByPath(ui,"Image_coin"):hide();
    self.item3Icon          = TFDirector:getChildByPath(ui,"Image_zuan"):hide();
    self.item1Add           = TFDirector:getChildByPath(ui,"Button_add_tili"):hide();
    self.item2Add           = TFDirector:getChildByPath(ui,"Button_add_coin"):hide();
    self.item3Add           = TFDirector:getChildByPath(ui,"Button_add_zuan"):hide();
    self.Image_tili_bg = TFDirector:getChildByPath(ui,"Image_tili_bg")

    self.Button_main        = TFDirector:getChildByPath(ui,"Button_main");
    self.Button_back        = TFDirector:getChildByPath(ui,"Button_back");
    self.Button_help        = TFDirector:getChildByPath(ui,"Button_help");
    self.Image_top_bar_bg = TFDirector:getChildByPath(ui,"Image_top_bar_bg")
    self.titleLabel         = TFDirector:getChildByPath(ui,"TextArea_title");
    self.TextArea_title_1         = TFDirector:getChildByPath(ui,"TextArea_title_1")

    --基本信息
    self.Button_main:setVisible(self.topData.isMain);
    self.Button_back:setVisible(self.topData.isBack);
    self.titleLabel:setString(TextDataMgr:getText(self.topData.name))
    self.Button_help:setVisible(self.topData.isHelp)

    --资源道具
    self.resourcePanel:setVisible(self.topData.isResource)
    if self.topData.isResource then
        --local idx = 1;
        for k,v in pairs(self.topData.resource) do
            self["item"..k.."Label"]:setVisible(true);
            self["item"..k.."Icon"]:setVisible(true);
            self["item"..k.."Add"]:setVisible(v[2] > 0);
            local itemCfg = GoodsDataMgr:getItemCfg(v[1]);
            self["item"..k.."Icon"].itemId = v[1]
            self["item"..k.."Icon"]:setTexture(itemCfg.icon);
            self["item"..k.."Icon"]:setSize(CCSizeMake(100,100));

            if v[2] > 0 then
                self["item"..k.."Add"]:onClick(
                    function()
                        dump(itemCfg.buyItemRecover)
                        ---宾果游戏特殊处理
                        if v[1] == 500125 then
                            FunctionDataMgr:jStore(306000)
                            return
                        end
                        if v[1] == EC_SItemType.TIANGONGBI
                            or v[1] == EC_SItemType.FRIENDSHIP  then
                                Utils:openView("bag.ItemAccessView", v[1])
                        elseif itemCfg.buyItemRecover == 0 then
                            --Utils:notOpenTips()
                            --RechargeDataMgr:showRechageLayer();
                            FunctionDataMgr:jPay()
                            Utils:sendHttpLog("Diamond")
                        else
                            if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
								if EC_SItemType.POWER == v[1] then
									Utils:openView("common.BuyTiliLayer", v[1])
                                    Utils:sendHttpLog("strength")
								else
									Utils:openView("common.BuyResourceView", v[1])
                                    Utils:sendHttpLog("gold")

								end
                            else
                                Utils:showTips(800021)
                            end

                        end
                                              end)
            end

            --idx = idx + 1;
        end

        self:updateTopbar();
    end
    ViewAnimationHelper.displayMoveNodes({self.titleLabel, self.TextArea_title_1}, {direction = 1, distance = 20, wait = 0.15, time = 0.15, delay = 0})
    ViewAnimationHelper.displayMoveNodes({self.Image_top_bar_bg, self.Button_back, self.Button_help, self.Button_main, self.resourcePanel}, {direction = 3, distance = 20, time = 0.15, delay = 0})
end

function TopBar:hideResource()
    self.resourcePanel:setVisible(false)
end

function TopBar:setCustomTittle(tittle, ...)
    local id, text
    if type(tittle) == "number" then
        id = tittle
    else
        text = tittle
    end

    if id then
        text = TextDataMgr:getText(id, ...)
    end
    self.titleLabel:setText(text)
end

function TopBar:setCustomTittleEn(tittle, ...)

    local id, text
    if type(tittle) == "number" then
        id = tittle
    else
        text = tittle
    end

    if id then
        text = TextDataMgr:getText(id, ...)
    end
    self.TextArea_title_1:setText(text)
end

function TopBar:setBackBtnCallback(callback)
    self.backCallback = callback;
end

function TopBar:setMainBtnCallback(callback)
    self.mainCallback = callback;
end

function TopBar:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateTopbar, self))
    EventMgr:addEventListener(self, EV_UPDATE_RESOURCE, handler(self.updateTopbar, self))
    
    self.Button_back:onClick(function ()
            if self:getParent().doing then
                return;
            end

            if self.backCallback then
                self.backCallback();
                return;
            end
            GameGuide:checkGuideEnd()
            AlertManager:close();
    end)

    self.Button_main:onClick(function()
            if self:getParent().doing then
                return;
            end

            if self.topData.fileName ~= "TeamFightTeamView" then
                --除开组队界面，点击主页按钮都发送协议，服务器处理队伍相关
                TeamFightDataMgr:reqBackHomePage()
            end

            if self.mainCallback then
                if self.mainCallback() then
                    return
                end
            end

            GameGuide:checkGuideEnd()
            local currentScene = Public:currentScene();
            if currentScene.__cname == "MainScene" then
                AlertManager:closeAll()
            elseif currentScene.__cname == "BaseOSDScene" then -- 大世界场景中 所有界面退回主场景弹出提示
                local args = {
                    tittle = 2107025,
                    content = TextDataMgr:getText(14110234),
                    reType = EC_OneLoginStatusType.ReConfirm_ExitTeamScene,
                    confirmCall = function()
                        AlertManager:changeScene(SceneType.MainScene);
                    end,
                }
                Utils:showReConfirm(args) 
            elseif currentScene.__cname == "AmusementPackScene" then -- 大世界场景中 所有界面退回主场景弹出提示
                local args = {
                    tittle = 2107025,
                    content = TextDataMgr:getText(14110234),
                    reType = EC_OneLoginStatusType.ReConfirm_ExitTeamScene,
                    confirmCall = function()
                        AlertManager:changeScene(SceneType.MainScene);
                    end,
                }
                Utils:showReConfirm(args)
            else
                AlertManager:changeScene(SceneType.MainScene);
            end
    end)

    self.Button_help:onClick(function()
        local layer = require("lua.logic.common.HelpView"):new(self.topData.helpInterface)
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)

    self.Image_tili_bg:setTouchEnabled(true)
    self.Image_tili_bg:onClick(function ()
        for k,v in pairs(self.topData.resource) do
            if v[1] ==  EC_SItemType.POWER or v[1] == EC_SItemType.ENERGY or v[1] == EC_SItemType.KABALA_ENERGY or v[1] == EC_SItemType.SX_BIRTHDAY_POWER then
                showItemCoolDownTips(v[1], self.Image_tili_bg)
                break
            end
        end
    end)

    for i = 1, 3 do
        self["item".. i .."Icon"]:setTouchEnabled(true)
        self["item".. i .."Icon"]:onClick(handler(self.onClickIcon, self))
    end
end

function TopBar:onClickIcon(sender)
    if not sender.itemId or sender.itemId ~= EC_SItemType.DIAMOND then return end
    if GoodsDataMgr.minusDiamond and GoodsDataMgr.minusDiamond > 0 then
        Utils:showTipTool(sender, ccp(60, -15))
    end
end

function TopBar:onUpdateTopbarEvent(oldItem, item)
    local topBarItemId = {}
    for i, v in ipairs(self.topBarType_) do
        local resource = EC_TopbarResource[v]
        table.insert(topBarItemId, resource.itemId)
    end
    local itemId
    for _, v in pairs({oldItem, item}) do
        if v then
            itemId = v.cid
            break
        end
    end

    if itemId and table.indexOf(topBarItemId, itemId) ~= -1 then
        self:updateTopbar()
    end
end

function TopBar:updateTopbar()
    --local idx = 1
    if not self.topData then
        return
    end

    for k,v in pairs(self.topData.resource) do
        if v[1] ==  EC_SItemType.POWER then
            local levelupconf = TabDataMgr:getData("LevelUp", MainPlayer:getPlayerLv()) or {}
            local tiliTop = levelupconf.maxEnergy or 0
            self["item"..k.."Label"]:setText(GoodsDataMgr:getItemCount(EC_SItemType.POWER).."/"..tiliTop)
        elseif v[1] == EC_SItemType.ENERGY then
            local levelupconf = TabDataMgr:getData("LevelUp", MainPlayer:getPlayerLv()) or {}
            local tiliTop1 = levelupconf.maxVigour or 0
            self["item"..k.."Label"]:setText(GoodsDataMgr:getItemCount(EC_SItemType.ENERGY).."/"..tiliTop1)
        elseif v[1] == EC_SItemType.KABALA_ESSENCE then
            self["item"..k.."Label"]:setText(GoodsDataMgr:getItemCount(EC_SItemType.KABALA_ESSENCE))
        elseif v[1] == EC_SItemType.KABALA_ENERGY then
            self["item"..k.."Label"]:setText(KabalaTreeDataMgr:getEnergy())
        elseif v[1] == EC_SItemType.SX_BIRTHDAY_POWER then
            local count = GoodsDataMgr:getItemCount(v[1], true)
            local itemCfg = GoodsDataMgr:getItemCfg(v[1])
            self["item"..k.."Label"]:setTextById(800005, count, itemCfg.totalMax)
        elseif v[1] == EC_SItemType.DIAMOND then
            self["item"..k.."Label"]:setText(GoodsDataMgr:getItemCount(v[1]))
        else
            self["item"..k.."Label"]:setText(GoodsDataMgr:getItemCount(v[1], true))
        end
        --idx = idx + 1;
    end
end

function TopBar:setTopName(name)
    self.titleLabel:setString(name);
end

function TopBar:removeUI()
    self.super.removeUI(self);
end

return TopBar;
