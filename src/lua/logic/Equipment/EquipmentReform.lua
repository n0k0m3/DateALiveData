local EquipmentReform = class("EquipmentReform", BaseLayer)


function EquipmentReform:ctor(data)
    self.super.ctor(self,data)
    self.showId = data.equipmentId
    self.heroid = data.heroid;
    self.equips = data.equips or {}
    self.fromBag = data.fromBag
    self:init("lua.uiconfig.Equip.EquipReform")
    local msg = {
        self.showId
    };
    local idx = table.indexOf(self.equips,self.showId)
    self.equipPageIdx = idx > 0 and idx or 1
    TFDirector:send(c2s.EQUIPMENT_REQ_EQUIP_REMOULD_INFO,msg)
    
end

function EquipmentReform:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
    self:showTopBar()

   -- 
    self.backBtn        = TFDirector:getChildByPath(ui,"Button_back");
    self.mainBtn        = TFDirector:getChildByPath(ui,"Button_main");
    self.Button_reform = TFDirector:getChildByPath(ui,"Button_reform")
    self.equipsPageView = TFDirector:getChildByPath(ui,"PageView_Equip")
    self.Label_gold = TFDirector:getChildByPath(ui,"Label_gold")
    self.ScrollView_goods =  TFDirector:getChildByPath(ui,"ScrollView_goods")
    self.Label_lv = TFDirector:getChildByPath(ui,"Label_lv")
    self.Image_Equip    = TFDirector:getChildByPath(ui,"Image_Equip")

    self.Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()

    self.GridView_reward = UIGridView:create(self.ScrollView_goods)
    self.GridView_reward:setItemModel(self.Panel_goodsItem_prefab)
    self.GridView_reward:setColumn(5)

    self.TeShuItem = TFDirector:getChildByPath(ui,"Panel_Attrs")
    local ScrollView_all = TFDirector:getChildByPath(ui, "ScrollView_allElements");
    self.allElementsListView = UIListView:create(ScrollView_all)

    self.Label_tili = TFDirector:getChildByPath(ui, "Label_tili")
    self.Label_coin = TFDirector:getChildByPath(ui, "Label_coin")
    self.Label_zuan = TFDirector:getChildByPath(ui, "Label_zuan")

    self.Label_coin:setText(GoodsDataMgr:getItemCount(EC_SItemType.GOLD))

    local levelupconf = TabDataMgr:getData("LevelUp", MainPlayer:getPlayerLv()) or {}
    local tiliTop = levelupconf.maxEnergy or 0
    self.Label_tili:setText(GoodsDataMgr:getItemCount(EC_SItemType.POWER).."/"..tiliTop)
    
    self.Label_zuan:setText(GoodsDataMgr:getItemCount(EC_SItemType.DIAMOND))

    
	
    self:updatePageView();


    
end

function EquipmentReform:updatePageView()
    local equipmentId   = self.showId;
    
    local paintPath = EquipmentDataMgr:getEquipPaint(equipmentId);
    self.Image_Equip:setTexture(paintPath);
    me.TextureCache:removeUnusedTextures()
    local pos = EquipmentDataMgr:getEquipPaintPosition(equipmentId);
    local scale = EquipmentDataMgr:getEquipPaintScale(equipmentId);
    self.Image_Equip:setScale(scale);
    self.Image_Equip:setPosition(pos);
    if self.fromBag and self.equips then
        local idx = table.indexOf(self.equips,equipmentId)
        self.equipPageIdx = idx > 0 and idx or 1
        self.equipPos_ = pos
    end

    self:updateUI()
end
    



function EquipmentReform:onRecvResults(data)
    dump(data)
    if data.equipmentId ~= self.showId then
        return
    end

    for kd, vd in ipairs(data.attr) do
        for ki, vi in pairs(self.allElementsListView:getItems()) do
            if vi.index == vd.index then
                local Label_curNum = TFDirector:getChildByPath(vi,"Label_curNum")
                Label_curNum:setScale(0.2)
                Label_curNum:stopAllActions()
                Label_curNum:setOpacity(255)
                Label_curNum:runAction(Sequence:create({ EaseBackOut:create(ScaleTo:create(0.1, 1)), DelayTime:create(3), FadeOut:create(0.1)}))
                Label_curNum:setText("+" .. vd.value / 100 .. "%")

                local Label_totalNum = TFDirector:getChildByPath(vi,"Label_totalNum")
                
                local num = Label_totalNum:getText()
                local value = vd.value
                vi.totalNum = vi.totalNum + vd.value
                Label_totalNum:setText("(+" .. vi.totalNum / 100 .. "%)")
                if Label_totalNum.preTotalNum then
                    Label_totalNum:setText("(+" .. (vi.totalNum + Label_totalNum.preTotalNum) / 100 .. "%)")
                end

                local EquipmentRandom = TabDataMgr:getData("EquipmentRandom")
                local ratio = (vi.preNum + vi.totalNum) / vi.maxReform
                local LoadingBar_total = TFDirector:getChildByPath(vi,"LoadingBar_total")
                LoadingBar_total:setPercent(ratio * 100)

                if LoadingBar_total.preTotalNum then
                    local ratio = (LoadingBar_total.preTotalNum  + vi.totalNum) / vi.maxReform
                    LoadingBar_total:setPercent(ratio * 100)
                end

                local Image_maxIcon = TFDirector:getChildByPath(vi,"Image_maxIcon")
                local Label_maxNum = TFDirector:getChildByPath(vi,"Label_maxNum")
                local Image_select_di = TFDirector:getChildByPath(vi,"Image_select_di")
                local Image_select_diMax = TFDirector:getChildByPath(vi,"Image_select_diMax")
                local Image_select = TFDirector:getChildByPath(vi,"Image_select")
                local Label_totalNum = TFDirector:getChildByPath(vi,"Label_totalNum")
                local Image_curValdi = TFDirector:getChildByPath(vi,"Image_curValdi")
                local LoadingBar_total = TFDirector:getChildByPath(vi,"LoadingBar_total")
                local Image_loadingbarCover = TFDirector:getChildByPath(vi,"Image_loadingbarCover")

                Image_maxIcon:setVisible(ratio >= 1)
                Label_maxNum:setVisible(ratio < 1)

                Image_select_di:setVisible(ratio < 1)
                Image_select_diMax:setVisible(ratio >= 1)
                Image_select:setVisible(ratio < 1)
               -- Label_totalNum:setVisible(ratio >= 1)
                Image_curValdi:setVisible(ratio < 1)
                LoadingBar_total:setVisible(ratio < 1)
                Image_loadingbarCover:setVisible(ratio < 1)

                Label_curNum:setVisible(ratio < 1)

                if ratio >= 1 then
                    for i3, v3 in ipairs(self.attrIndexsAndIds) do
                        
                        if v3.index == vd.index then
                            table.remove(self.attrIndexsAndIds, i3)
                            break
                        end
                    end
                end


                local Spine_success = TFDirector:getChildByPath(vi,"Spine_success")
                Spine_success:setVisible(true)
                Spine_success:play("animation",false)




            end
        end
    end
    self.Label_coin:setText(GoodsDataMgr:getItemCount(EC_SItemType.GOLD))

    self:updateGoodsList()

end

function EquipmentReform:onRecvNums(data)
    self.changeData = data
    self:updateUI()
end


function EquipmentReform:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_REFORM_RESULT,handler(self.onRecvResults, self));
    EventMgr:addEventListener(self,EQUIPMENT_RES_EQUIP_REMOULD_INFO,handler(self.onRecvNums, self));

    self.backBtn:onClick(function ()
            AlertManager:close();
    end)

    self.mainBtn:onClick(function()
            AlertManager:changeScene(SceneType.MainScene);
        end)

    self.Button_reform:onClick(function()
            if #self.attrIndexs > 0 then
                EquipmentDataMgr:equipReform(self.showId, self.attrIndexs)
            else
                Utils:showTips(100000038)
            end
        end)

    if self.fromBag and self.equips then
        local function pageUp()
            if self.equipPageIdx < #self.equips then
                self.equipPageIdx = self.equipPageIdx + 1
                local function callBack()
                    self.Image_Equip:setOpacity(0)
                    self.Image_Equip:setPositionX(1500)
                    self:changeEquipPage(true)
                end
                local act1 = CCMoveTo:create(0.2, ccp(-400, self.equipPos_.y))
                local act2 = CCCallFuncN:create(callBack)
                self.Image_Equip:runAction(CCSequence:create({act1, act2}))
            else
                self.Image_Equip:setTouchEnabled(true)
                self.Image_Equip:runAction(CCMoveTo:create(0.2, self.equipPos_))
            end
        end

        local function pageDown()
            if self.equipPageIdx > 1 then
                self.equipPageIdx = self.equipPageIdx - 1
                local function callBack()
                    self.Image_Equip:setOpacity(0)
                    self.Image_Equip:setPositionX(-400)
                    self:changeEquipPage(false)
                end
                local act1 = CCMoveTo:create(0.2, ccp(1500, self.equipPos_.y))
                local act2 = CCCallFuncN:create(callBack)
                self.Image_Equip:runAction(CCSequence:create({act1, act2}))
            else
                self.Image_Equip:setTouchEnabled(true)
                self.Image_Equip:runAction(CCMoveTo:create(0.2, self.equipPos_))
            end
        end

        local function onTouchBegan(touch, location)
            touch.startPos = location
            return true
        end

        local function onTouchMoved(touch, location)
            touch.isMoved = true
            local offsetx = location.x - touch.startPos.x
            local offsety = location.y - touch.startPos.y
            self.Image_Equip:setPosition(ccp(self.equipPos_.x + offsetx, self.equipPos_.y))
        end

        local function onTouchUp(touch, location)
            local offsetx = location.x - touch.startPos.x
            if touch.isMoved then
                if math.abs(offsetx) > 100 then
                    self.Image_Equip:setTouchEnabled(false)
                    if offsetx < 0 then
                        pageUp()
                    else
                        pageDown()
                    end
                else
                    self.Image_Equip:runAction(CCMoveTo:create(0.04, self.equipPos_))
                end
            end
        end

        self.Image_Equip:setTouchEnabled(true)
        self.Image_Equip:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)
        self.Image_Equip:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved)
        self.Image_Equip:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp)
    end

    
end


function EquipmentReform:changeEquipPage(isUp)
    self.showId = self.equips[self.equipPageIdx]
    local msg = {
        self.showId
    };
    TFDirector:send(c2s.EQUIPMENT_REQ_EQUIP_REMOULD_INFO,msg)

    self.Image_Equip:stopAllActions()
    if EquipmentDataMgr:isUesing(self.showId) then
        self.pos = EquipmentDataMgr:getPosition(self.showId)
    end
    local paintPath = EquipmentDataMgr:getEquipPaint(self.showId)
    self.Image_Equip:setTexture(paintPath)
    me.TextureCache:removeUnusedTextures()
    local pos = EquipmentDataMgr:getEquipPaintPosition(self.showId)
    local scale = EquipmentDataMgr:getEquipPaintScale(self.showId)
    self.Image_Equip:setScale(scale)
    self.Image_Equip:setOpacity(255)
    self.equipPos_ = pos
    self.Image_Equip:setPositionY(self.equipPos_.y)
    local function callBack()
        self.Image_Equip:setTouchEnabled(true)
        self:updateUI();
        self:updateGoodsList()
    end
    local delay = isUp and 0.2 or 0.15
    local act1 = CCMoveTo:create(delay, self.equipPos_)
    act1 = EaseSineOut:create(act1)
    local act2 = CCCallFuncN:create(callBack)
    self.Image_Equip:runAction(CCSequence:create({act1, act2}))

end

function EquipmentReform:updateUI()
    self.Label_name     = TFDirector:getChildByPath(self.ui,"Label_name")
    local name      = EquipmentDataMgr:getEquipName(self.showId);
    self.Label_name:setString(name..EquipmentDataMgr:getStepText(self.showId));

    self.Label_Owner = TFDirector:getChildByPath(self.ui,"Label_Owner")
    self.Label_title = TFDirector:getChildByPath(self.ui,"Label_title")
    if EquipmentDataMgr:isUesing(self.showId) then
        local name = HeroDataMgr:getNameById(tonumber(EquipmentDataMgr:getHeroSid(self.showId)))
        self.Label_Owner:setText(name)
        self.Label_Owner:setVisible(true)
        self.Label_title:setVisible(true)
    else
        self.Label_Owner:setVisible(false)
        self.Label_title:setVisible(false)
    end

    local starLv = EquipmentDataMgr:getEquipStarLv(self.showId);
    for i=1,5 do
        TFDirector:getChildByPath(self.ui,"Image_star"..i):setVisible(true);  
    end
    for i=1,5 do
        if i > starLv then
            TFDirector:getChildByPath(self.ui,"Image_star"..i):setVisible(false);
        end    
    end
    local starLevel = EquipmentDataMgr:getEquipStarLevel(self.showId)
    self.Image_stage1 = TFDirector:getChildByPath(self.ui,"Image_stage1")
    self.Image_stage2 = TFDirector:getChildByPath(self.ui,"Image_stage2")
    self.Image_stage3 = TFDirector:getChildByPath(self.ui,"Image_stage3")
    self.Image_stage1:setVisible(starLevel >= 1 and starLevel < 3)
    self.Image_stage2:setVisible(starLevel == 2)
    self.Image_stage3:setVisible(starLevel == 3)

    local equipmentId   = self.showId
    self.allElementsListView:removeAllItems()
    local EquipmentRandom = TabDataMgr:getData("EquipmentRandom")
    self.attrIndexs = {}
    self.attrIds = {}
    self.attrIndexsAndIds = {}
    if EquipmentDataMgr:getIsHaveSpecialAttr(equipmentId) then
        local specialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(equipmentId);
        for k,v in ipairs(specialAttrs) do
           
            local TeShuItem = self.TeShuItem:clone();
            local desc = TFDirector:getChildByPath(TeShuItem,"Label_attrName");
            local Label_curNum = TFDirector:getChildByPath(TeShuItem,"Label_curNum")
            Label_curNum:setOpacity(0)

            desc:setString(v.desc);
            local Image_zhuangshi = TFDirector:getChildByPath(TeShuItem,"Image_zhuangshi");
            Image_zhuangshi:setTexture(EC_equip_Special_icon[v.level]);
            local Label_maxNum = TFDirector:getChildByPath(TeShuItem,"Label_maxNum")
            Label_maxNum:setText(EquipmentRandom[v.id].maxReform / 100 .. "%")
            local ratio = (v.val * 100) / EquipmentRandom[v.id].maxReform
            local Image_loadingbarCover = TFDirector:getChildByPath(TeShuItem,"Image_loadingbarCover")
            Image_loadingbarCover:setScaleX(ratio)

            local Image_maxIcon = TFDirector:getChildByPath(TeShuItem,"Image_maxIcon")
            local Image_select_di = TFDirector:getChildByPath(TeShuItem,"Image_select_di")
            local Image_select_diMax = TFDirector:getChildByPath(TeShuItem,"Image_select_diMax")
            local Image_select = TFDirector:getChildByPath(TeShuItem,"Image_select")
            local Label_totalNum = TFDirector:getChildByPath(TeShuItem,"Label_totalNum")
            local Image_curValdi = TFDirector:getChildByPath(TeShuItem,"Image_curValdi")
            local LoadingBar_total = TFDirector:getChildByPath(TeShuItem,"LoadingBar_total")

            Image_maxIcon:setVisible(ratio >= 1)
            Label_maxNum:setVisible(ratio < 1)

            Image_select_di:setVisible(ratio < 1)
            Image_select_diMax:setVisible(ratio >= 1)
            Image_select:setVisible(ratio < 1)
            --Label_totalNum:setVisible(ratio < 1)
            Image_curValdi:setVisible(ratio < 1)
            LoadingBar_total:setVisible(ratio < 1)
            Image_loadingbarCover:setVisible(ratio < 1)

            local LoadingBar_total = TFDirector:getChildByPath(TeShuItem,"LoadingBar_total")
            LoadingBar_total:setPercent(ratio * 100)
            if self.changeData and self.changeData.attrChange then
                for kc,vc in pairs(self.changeData.attrChange) do
                    if vc.index == v.index then
                        Label_totalNum:setText("(+" .. vc.value / 100 .. "%)")
                        Label_totalNum.preTotalNum = vc.value
                        local ratio = (v.val * 100) / EquipmentRandom[v.id].maxReform
                        LoadingBar_total:setPercent(ratio * 100)
                        LoadingBar_total.preTotalNum = v.val * 100

                        local EquipmentRandom = TabDataMgr:getData("EquipmentRandom")
                        local EqType = EquipmentRandom[v.id].attrType
                        local descID = EC_AttrAddText + EqType
                        local num = v.val  - vc.value / 100
                        local ratio2 = (num * 100) / EquipmentRandom[v.id].maxReform
                        Image_loadingbarCover:setScaleX(ratio2)
                        local desc2 = TextDataMgr:getText(descID,num);
                        desc:setString(desc2);
                    end
                end
            end

            TeShuItem.index = v.index
            TeShuItem.totalNum = 0
            TeShuItem.preNum = v.val * 100
            TeShuItem.maxReform = EquipmentRandom[v.id].maxReform
            self.allElementsListView:pushBackCustomItem(TeShuItem)

            local Image_select_di = TFDirector:getChildByPath(TeShuItem,"Image_select_di");
            local Image_select    = TFDirector:getChildByPath(TeShuItem,"Image_select"):hide();

            Image_select_di:onClick(function()
                    if Image_select:isVisible() then
                        Image_select:hide();
                        for i2, v2 in ipairs(self.attrIndexs) do
                            if v2 == v.index then
                                table.remove(self.attrIndexs, i2)
                                break
                            end
                        end
                        for i4, v4 in ipairs(self.attrIndexsAndIds) do
                            if v4.index == v.index then
                                table.remove(self.attrIndexsAndIds, i4)
                                break
                            end
                        end
                        for i3, v3 in ipairs(self.attrIds) do
                            if v3 == v.id then
                                table.remove(self.attrIds, i3)
                                break
                            end
                        end
                        self:updateGoodsList()
                    else
                        Image_select:show();
                        table.insert(self.attrIndexs, v.index)
                        table.insert(self.attrIds, v.id)
                        local t = {}
                        t.index = v.index
                        t.id = v.id
                        table.insert(self.attrIndexsAndIds, t)
                        self:updateGoodsList()
                        
                    end
                end)
           -- end
        end
        --self.allElementsListView.pushed = true
    else

        --self.specialListView:removeAllItems();

    end

    

    self.Label_lv:setText(EquipmentDataMgr:getEquipLv(self.showId))
end



function EquipmentReform:onHide()
	self.super.onHide(self)
    EquipmentDataMgr:setBackFromReform(self.showId)
end

function EquipmentReform:removeUI()
	self.super.removeUI(self)
end

function EquipmentReform:updateGoodsList()
    self.GridView_reward:removeAllItems()
    local allGoods = {}
    self.Coin = 0
    local EquipmentRandom = TabDataMgr:getData("EquipmentRandom")
    for k, v in ipairs(self.attrIndexsAndIds) do
        for kg, vg in pairs(EquipmentRandom[v.id].reformCost) do
            local isFind = false
            for ka, va in pairs(allGoods) do
                if va.id == kg then
                    va.num = va.num + vg
                    isFind = true
                    break
                end
            end

            if not isFind then
                local t = {}
                t.id = kg
                t.num = vg
                if kg ~= EC_SItemType.GOLD then
                    table.insert(allGoods, t)
                else
                    self.Coin = self.Coin + vg
                end
            end
        end
    end

    for k, v in pairs(allGoods) do
        local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
        Panel_goodsItem:setScale(0.7)
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        Panel_goodsItem:onClick(function()
                Utils:showInfo(v.id, nil, true)
        end)
        --local Label_countHava = TFDirector:getChildByPath(Panel_goodsItem,"Label_countHava")
        local Label_count = TFDirector:getChildByPath(Panel_goodsItem,"Label_count")

        local haveCount = GoodsDataMgr:getItemCount(v.id)
        --Label_countHava:setText(haveCount)
        Label_count:setText(haveCount .. "/" .. v.num)
        Label_count:setColor(haveCount >= v.num and ccc3(255,255,255) or ccc3(255,0,0))
        self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
    end
    self.Label_gold:setText(self.Coin)
    self.Label_gold:setColor(GoodsDataMgr:getItemCount((EC_SItemType.GOLD)) >= self.Coin and ccc3(255,255,255) or ccc3(255,0,0))
end


function EquipmentReform:onShow()
   self.super.onShow(self)
end

return EquipmentReform;
