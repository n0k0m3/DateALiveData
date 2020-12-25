local EquipConvertTips = class("EquipConvertTips", BaseLayer)


function EquipConvertTips:ctor(data)
    self.super.ctor(self,data)
    self.oldData = data.oldData;
    self.newData = data.newData;
    self.oldAllData = data.oldAllData;
    self.newAllData = data.newAllData;
    self.okCallFunc = data.okCallFunc;
    self.showId = data.showid
    self.isCallback = false;
    self:showPopAnim(true)
    self:init("lua.uiconfig.Equip.EquipConvertTips")
    if EquipmentDataMgr:getEquipStarLevel(self.showId) < 1  and  EquipmentDataMgr:getEquipLv(self.showId) > 1 then
        EquipmentDataMgr:getEquipRecycleItems(self.showId)
    end
    --EventMgr:addEventListener(self,EV_EQUIPMENT_OPERATION,handler(self.updateUI, self));
end

function EquipConvertTips:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	EquipConvertTips.ui = ui

    self.Button_ok = TFDirector:getChildByPath(ui,"Button_ok");
    self.Button_close = TFDirector:getChildByPath(ui,"Button_close");
    self.Button_cancel = TFDirector:getChildByPath(ui,"Button_cancel")
    self.Label_returnTips = TFDirector:getChildByPath(ui,"Label_returnTips")
    self.Label_change = TFDirector:getChildByPath(ui,"Label_change")
    self.Label_returnTips:setVisible(EquipmentDataMgr:getEquipLv(self.showId) > 1 and EquipmentDataMgr:getEquipStarLevel(self.showId) < 1 )

    -- self.RichText_item1 = TFDirector:getChildByPath(ui,"Label_tips1");
    -- self.RichText_item2 = TFDirector:getChildByPath(ui,"Label_tips2");

    local data = Utils:getKVP(4003)
    self.Label_change:setTextById(492002, data.normal.ratio / 100 .. "%")

    self.Panel_att_item = TFDirector:getChildByPath(ui, "Panel_att_item")
    self.Panel_att_item:setVisible(false)

    self.ListView_old_atts = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_old_atts"))
    self.ListView_new_atts = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_new_atts"))

    for i, v in ipairs(self.oldAllData) do
        local item = self.Panel_att_item:clone()
        local isHave = false
        for i2, v2 in ipairs(self.oldData) do
            if v.index == v2.index then
                isHave = true
                break
            end
        end
        self:initOneAttItem(item, v, isHave)
        self.ListView_old_atts:pushBackCustomItem(item)
    end

    for i, v in ipairs(self.newData) do
        local item = self.Panel_att_item:clone()
        -- local isHave = false
        -- for i2, v2 in ipairs(self.newData) do
        --     if v.index == v2.index then
        --         isHave = true
        --         break
        --     end
        -- end
        -- self:initOneAttItem(item, v, isHave)
        self:initOneAttItem(item, v, true)
        self.ListView_new_atts:pushBackCustomItem(item)
    end

    for i, v in ipairs(self.oldAllData) do
        local item = self.Panel_att_item:clone()
        local isChange = false
        for i2, v2 in ipairs(self.oldData) do
            if v.index == v2.index then
                isChange = true
                break
            end
        end
        if not isChange then
            self:initOneAttItem(item, v, isChange)
            self.ListView_new_atts:pushBackCustomItem(item)
        end
        
    end



    local size = self.ListView_old_atts:getContentSize()
    size.height = #self.oldAllData * self.Panel_att_item:getContentSize().height

    self.ListView_old_atts:setContentSize(size)
    self.ListView_new_atts:setContentSize(size)


    -- self.RichText_item1:setString(self.oldData.desc);
    

    -- local desc = EC_AttrAddText[self.newData.newAttrType];
    -- if self.newData.newAttrValue >= 1000 then
    --     self.newData.newAttrValue = math.floor(self.newData.newAttrValue / 100);
    -- end
    --desc = TextDataMgr:getText(desc,self.newData.newAttrValue);
    -- self.RichText_item2:setString(self.newData.desc);

    self.Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
        local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
        Panel_goodsItem:setScale(0.8)
    self.ScrollView_recycles = TFDirector:getChildByPath(self.ui,"ScrollView_recycles")
    self.GridView_reward = UIGridView:create(self.ScrollView_recycles)
    self.GridView_reward:setItemModel(Panel_goodsItem)
end

function EquipConvertTips:initOneAttItem(item, data, isHave)
    item:setVisible(true)

    local Label_att_desc = TFDirector:getChildByPath(item, "Label_att_desc")
    Label_att_desc:setString(data.desc)

    local Image_zhuangshi = TFDirector:getChildByPath(item, "Image_zhuangshi")
    Image_zhuangshi:setTexture(EC_equip_Special_icon[data.level])

    if not isHave then
        item:setColor(ccc3(180, 180, 180))
    end
end


function EquipConvertTips:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_CHANGE_SPECIAL_ATTRTIPS,handler(self.onGetRecycleItems, self))

	self.Button_ok:onClick(function ()
            if self.okCallFunc then
                self.okCallFunc(true);
                AlertManager:close();
                self.isCallback = true
            end
    end)

    self.Button_close:onClick(function()
    		if self.okCallFunc then
                self.okCallFunc(false);
                AlertManager:close();
                self.isCallback = true
            end
    	end)

    self.Button_cancel:onClick(function()
            if self.okCallFunc then
                self.okCallFunc(false);
                AlertManager:close();
                self.isCallback = true
            end
        end)
end

function EquipConvertTips:onGetRecycleItems(data)
    dump(data)
    local info = data.returnItem
    if info then
        for k, v in pairs(info) do
            local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
            Panel_goodsItem:setScale(0.8)
            PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
            self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
        end
    elseif EquipmentDataMgr:getEquipStarLevel(self.showId) < 1 then
        local star = EquipmentDataMgr:getEquiGrowthpStar(self.showId)
        local lv     = EquipmentDataMgr:getEquipLv(self.showId)
        local totalExpCur = EquipmentDataMgr:getEquipCurExp(self.showId)
        for i=1,lv - 1 do
            totalExpCur = totalExpCur + TabDataMgr:getData("EquipmentGrowth",star).needExp[i];
        end
        local ratio = TabDataMgr:getData("DiscreteData",4005).data.ratio
        local totalExp = totalExpCur * ratio / 10000

        local item = {}
        item[1], item[2], item[3], item[4] = TabDataMgr:getData("DiscreteData",4004).data.equipment[1], 
        TabDataMgr:getData("DiscreteData",4004).data.equipment[2],
        TabDataMgr:getData("DiscreteData",4004).data.equipment[3], 
        TabDataMgr:getData("DiscreteData",4004).data.equipment[4];

        local exp1, exp2, exp3, exp4 = EquipmentDataMgr:getEquipTotalExp(item[1]), 
        EquipmentDataMgr:getEquipTotalExp(item[2]),
        EquipmentDataMgr:getEquipTotalExp(item[3]), 
        EquipmentDataMgr:getEquipTotalExp(item[4]);

        local num = {}
        local yu1 = totalExp % exp1
        num[1] = (totalExp - yu1) / exp1

        local yu2 = yu1 % exp2
        num[2] = (yu1 - yu2) / exp2

        local yu3 = yu2 % exp3
        num[3] = (yu2 - yu3) / exp3
        
        local yu4 = yu3 % exp4
        num[4] = (yu3 - yu4) / exp4

        
        
        
        

        for i = 1, 4 do
            if num[i] ~= 0 then
                local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
                Panel_goodsItem:setScale(0.8)

                PrefabDataMgr:setInfo(Panel_goodsItem, item[i], num[i])
                self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
            end
        end
        local strengthRatio = TabDataMgr:getData("DiscreteData",4002).data.ratio
        local goldNum = totalExp * strengthRatio / 10000

        if goldNum ~= 0 then
            local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
            Panel_goodsItem:setScale(0.8)
            PrefabDataMgr:setInfo(Panel_goodsItem, 500001, goldNum)
            self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
        end
    else
        self.Label_change:setTextById(492003)
    end
end

function EquipConvertTips:onHide()
	self.super.onHide(self)
end

function EquipConvertTips:removeUI()
	self.super.removeUI(self)
    if self.okCallFunc and not self.isCallback then
        self.okCallFunc(false);
    end
end

return EquipConvertTips;