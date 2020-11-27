
local NewGiftByEnglishVerView = class("NewGiftByEnglishVerView", BaseLayer)

function NewGiftByEnglishVerView:initData(activityId)
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(activityId)
end

function NewGiftByEnglishVerView:ctor(...)
    self.super.ctor(self)
    self:initData(...)    
    self:init("lua.uiconfig.activity.newGiftByEnglishVer")
end

function NewGiftByEnglishVerView:initUI(ui)
    self.super.initUI(self, ui)
    self.uiRoot = ui

    self:initTopPanel(ui)
    self:initPanel_1()
    self:initPanel_2()
    self:initPanel_3()
    self:initPanel_4()
    self:initPanel_5()
    self:initPanel_6(ui)
    
    self:selectPanelTab(1)

    self:addCountDownTimer()

end

--面板1首充奖励
function NewGiftByEnglishVerView:initTopPanel( ui )

    local Image_top = TFDirector:getChildByPath(ui , "Image_top")
    self.Panel_show_ui = {}
    self.Panel_tab = {}

    for i=1,5 do
        local tabPanel = TFDirector:getChildByPath(Image_top , "Panel_tab_"..i)
        tabPanel:setTouchEnabled(true)
        table.insert(self.Panel_tab , tabPanel)

        local showPanel = TFDirector:getChildByPath(ui , "Panel_show_"..i)
        table.insert(self.Panel_show_ui , showPanel)
    end
end

function NewGiftByEnglishVerView:initPanel_1()
    local panelUI = self.Panel_show_ui[1]


    local ScrollView_panel = TFDirector:getChildByPath(panelUI, "ScrollView_panel")
    self.ScrollView_panel = UIListView:create(ScrollView_panel)

    self.Panel_recharge_item = TFDirector:getChildByPath(self.uiRoot , "Panel_recharge_item")
    self.Panel_recharge_reward = TFDirector:getChildByPath(self.uiRoot , "Panel_recharge_reward")

end

--面板2 限定福利
function NewGiftByEnglishVerView:initPanel_2( )
   local panelUI = self.Panel_show_ui[2]
   local Label_time = panelUI:getChildByName("Image_time"):getChildByName("Label_time")

   self.PanelUI_2_items = {}
   for i=1,6 do
       local Image_reward = TFDirector:getChildByPath(panelUI , "Image_reward_bg_"..i)
       Image_reward.label_name = Image_reward:getChildByName("label_name")
       Image_reward.image_icon = Image_reward:getChildByName("image_reward")
       table.insert( self.PanelUI_2_items ,Image_reward )
   end

   self.Button_buy_2 = TFDirector:getChildByPath(panelUI , "Button_buy")
   self.Button_buy_2.image_cost = self.Button_buy_2:getChildByName("Image_icon")
   self.Button_buy_2.label_cost = self.Button_buy_2:getChildByName("Label_cost")

end

--面板3 1.99礼包
function NewGiftByEnglishVerView:initPanel_3()
    local panelUI = self.Panel_show_ui[3]
   local Label_time = panelUI:getChildByName("Image_time"):getChildByName("Label_time")
    self.Button_buy_3 = TFDirector:getChildByPath(panelUI , "Button_buy")
   self.Button_buy_3.image_cost = self.Button_buy_3:getChildByName("Image_icon")
   self.Button_buy_3.label_cost = self.Button_buy_3:getChildByName("Label_cost")

   self.PanelUI_3_items = {}
   for i=1,3 do
        local Image_reward = TFDirector:getChildByPath(panelUI , "Image_reward_bg_"..i)
        Image_reward.label_name = Image_reward:getChildByName("label_name")
        Image_reward.label_des = Image_reward:getChildByName("label_des")
        Image_reward.panel_group = {}
        for k=1,5 do
            Image_reward.panel_group[k] = TFDirector:getChildByPath(Image_reward , "Panel_ground_"..k)
        end
        Image_reward.label_des = Image_reward:getChildByName("label_des")
        table.insert(self.PanelUI_3_items , Image_reward)
   end
end

--面板4 2.99礼包
function NewGiftByEnglishVerView:initPanel_4()
    local panelUI = self.Panel_show_ui[4]
   local Label_time = panelUI:getChildByName("Image_time"):getChildByName("Label_time")
    self.Button_buy_4 = TFDirector:getChildByPath(panelUI , "Button_buy")
   self.Button_buy_4.image_cost = self.Button_buy_4:getChildByName("Image_icon")
   self.Button_buy_4.label_cost = self.Button_buy_4:getChildByName("Label_cost")

   self.PanelUI_4_items = {}
   for i=1,3 do
        local Image_reward = TFDirector:getChildByPath(panelUI , "Image_reward_bg_"..i)
        Image_reward:setTouchEnabled(true)
        Image_reward.label_name = Image_reward:getChildByName("label_name")
        Image_reward.image_icon = {}
        for k=1,6 do
            Image_reward.image_icon[k] = TFDirector:getChildByPath(Image_reward , "Image_reward_"..k)
        end

        table.insert(self.PanelUI_4_items , Image_reward)
   end
end
--面板5 3.99礼包
function NewGiftByEnglishVerView:initPanel_5()
    local panelUI = self.Panel_show_ui[5]
   local Label_time = panelUI:getChildByName("Image_time"):getChildByName("Label_time")
    self.Button_buy_5 = TFDirector:getChildByPath(panelUI , "Button_buy")
   self.Button_buy_5.image_cost = self.Button_buy_5:getChildByName("Image_icon")
   self.Button_buy_5.label_cost = self.Button_buy_5:getChildByName("Label_cost")
   self.Button_buy_5.label_price = self.Button_buy_5:getChildByName("Label_price")
   self.Button_buy_5.label_get = self.Button_buy_5:getChildByName("Label_get")

   self.PanelUI_5_items = {}
   for i=1,4 do
        local Image_reward = TFDirector:getChildByPath(panelUI , "Image_reward_bg_"..i)
        Image_reward.label_name = Image_reward:getChildByName("label_name")
        Image_reward.panel_lock = Image_reward:getChildByName("Panel_lock")
        Image_reward.image_icon = {}
        for k=1,6 do
            local image_icon_bg = TFDirector:getChildByPath(Image_reward , "Image_reward_"..k)
            if image_icon_bg then
                Image_reward.image_icon[k] = image_icon_bg
            end
        end
        table.insert(self.PanelUI_5_items , Image_reward)
   end
end


--面板6 1.99已购买
function NewGiftByEnglishVerView:initPanel_6(ui)
    local panelUI = TFDirector:getChildByPath(ui , "Panel_yigoumai")
    panelUI:hide()
    self.Panel_yigoumai = panelUI
   local Label_time = panelUI:getChildByName("Image_time"):getChildByName("Label_time")
    

   self.Panel_reward_show = panelUI:getChildByName("Image_reward")
   self.Panel_reward_show.Label_name = self.Panel_reward_show:getChildByName("label_name")
   self.Panel_reward_show.panel_group = {}

   for i=1,5 do
        self.Panel_reward_show.panel_group[i] = panelUI:getChildByName("Panel_ground_"..i)
   end

   local panel_mid = TFDirector:getChildByPath(panelUI , "Panel_mid")

   self.Button_get = panel_mid:getChildByName("Button_get")

   self.Image_des_1 = panel_mid:getChildByName("Image_des_1")
   self.Image_des_2 = panel_mid:getChildByName("Image_des_2")
end



function NewGiftByEnglishVerView:onShow( )
    self.super.onShow(self)
    self:updateActivity()
end

function NewGiftByEnglishVerView:updateActivity()
   

    self.Panel_yigoumai:hide()


   if self.selectIndex_ == 1 then
      self:updatePanel_1()
   elseif self.selectIndex_ == 2 then
      self:updatePanel_2()
   elseif self.selectIndex_ == 3 then
      self:updatePanel_3()
   elseif self.selectIndex_ == 4 then
      self:updatePanel_4()
   elseif self.selectIndex_ == 5 then
      self:updatePanel_5()
   end

end

function NewGiftByEnglishVerView:updatePanel_1( ... )

     local taskData = ActivityDataMgr2:getActivityItemsInfoBySubType(self.activityInfo_.id, 28004)
     local taskData_2 = ActivityDataMgr2:getActivityItemsInfoBySubType(self.activityInfo_.id, 1002)

     local itemDatas = {}
    for k,v in ipairs(taskData) do
      table.insert(itemDatas , v)
    end
    for k,v in ipairs(taskData_2) do
      table.insert(itemDatas , v)
    end


    local items = self.ScrollView_panel:getItems()
    local gap = #items - #itemDatas

    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.ScrollView_panel:getItem(1)
            self.ScrollView_panel:removeItem(1)
        else
          local item = self.Panel_recharge_item:clone()
          self.ScrollView_panel:pushBackCustomItem(item)
        end
    end
    for i, v in ipairs(self.ScrollView_panel:getItems()) do
        self:updatePaneItem(i , itemDatas[i])
    end
end

function NewGiftByEnglishVerView:updatePaneItem( index , itemData )
    
    local rewardData =  {}

    for k , v in pairs(itemData.reward) do
        table.insert(rewardData , {id = k , num = v})
    end

     local item = self.ScrollView_panel:getItem(index)
     if item.ScrollView_reward  then
        local ScrollView_reward = item.ScrollView_reward
        local items = ScrollView_reward:getItems()
        local gap = #items - #rewardData
        for i = 1, math.abs(gap) do
            if gap > 0 then
                local rewardItem = ScrollView_reward:getItem(1)
                ScrollView_reward:removeItem(1)
            else
              local rewardItem = self.Panel_recharge_reward:clone()
              ScrollView_reward:pushBackCustomItem(rewardItem)
            end
        end
        for i, v in ipairs(ScrollView_reward:getItems()) do
            self:updatePaneRewardItem(item ,i, rewardData[i])
        end
     else
        local ScrollView_reward_ui = TFDirector:getChildByPath(item , "ScrollView_reward")
        item.ScrollView_reward  = UIListView:create(ScrollView_reward_ui)
        ScrollView_reward = item.ScrollView_reward 
        local items = ScrollView_reward:getItems()
        local gap = #items - #rewardData
        for i = 1, math.abs(gap) do
            if gap > 0 then
                local rewardItem = ScrollView_reward:getItem(1)
                ScrollView_reward:removeItem(1)
            else
              local rewardItem = self.Panel_recharge_reward:clone()
              ScrollView_reward:pushBackCustomItem(rewardItem)
            end
        end
        for i, v in ipairs(ScrollView_reward:getItems()) do
            self:updatePaneRewardItem(item ,i , rewardData[i])
        end
     end

     local Label_name = item:getChildByName("Label_name")  --名字

     local Button_getReward = item:getChildByName("Button_getReward") --领取奖励按钮


     Label_name:setText(Utils:MultiLanguageStringDeal(itemData.extendData.des2))

     local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemData.id)

      Button_getReward:setTouchEnabled(false)
      Button_getReward:setGrayEnabled(true)


     if progressInfo.status == EC_TaskStatus.ING then
          Button_getReward:getChildByName("Label_button"):setTextById(300984)
     elseif progressInfo.status == EC_TaskStatus.GET then
        Button_getReward:setTouchEnabled(true)
        Button_getReward:setGrayEnabled(false)
        Button_getReward:getChildByName("Label_button"):setTextById(300984)
     elseif progressInfo.status == EC_TaskStatus.GETED then
        Button_getReward:getChildByName("Label_button"):setTextById(1300015)
     end

     Button_getReward:onClick(function ( ... )
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, itemData.id)
     end)

end

function NewGiftByEnglishVerView:updatePaneRewardItem(parentItem, index , itemData )
    
     local item = parentItem.ScrollView_reward:getItem(index)

      local imageIcon = item:getChildByName("Image_bg")
      if not imageIcon.goodsItem then
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setTouchEnabled(false)
        Panel_goodsItem:Pos(0, 0)
        Panel_goodsItem:AddTo(imageIcon)
        imageIcon.goodsItem = Panel_goodsItem
        imageIcon.goodsItem:setTouchEnabled(true)
      end
      PrefabDataMgr:setInfo(imageIcon.goodsItem, itemData.id, itemData.num)

end


function NewGiftByEnglishVerView:updatePanel_2( ... )
    local shopData = RechargeDataMgr:getOneRechargeCfg(self.activityInfo_.extendData.rechargeId)

    local buyItmes = shopData.item
    for k , v in pairs(self.PanelUI_2_items) do
        local itemData = buyItmes[k]
        local itemCfg = GoodsDataMgr:getItemCfg(itemData.id)
        v.label_name:setTextById(itemCfg.nameTextId)
        v.image_icon:setTexture(itemCfg.icon)
        if not v.image_icon.isClick then
            v.image_icon:setTouchEnabled(true)
            v.image_icon:onClick(function( ... )
              Utils:showInfo(itemCfg.id, nil, not(GuideDataMgr and GuideDataMgr:isInNewGuide() and  not isNotAccess))
            end)
            v.image_icon.isClick = true
        end
        v:getChildByName("label_count"):setTextById(800007 ,itemData.num)
    end
    local itemCfg = GoodsDataMgr:getItemCfg(shopData.exchangeCost[1].id)
    self.Button_buy_2.image_cost:setTexture(itemCfg.icon)
    self.Button_buy_2.image_cost:setScale(0.5)
    self.Button_buy_2.label_cost:setTextById(800007 ,shopData.exchangeCost[1].num)
    self.Button_buy_2.shopId = shopData.rechargeCfg.id

    if RechargeDataMgr:getBuyCount(shopData.rechargeCfg.id) >= 1 then
        self.Button_buy_2:setTouchEnabled(false)
        self.Button_buy_2:setGrayEnabled(true)


        self.Button_buy_2.label_cost:hide()
        self.Button_buy_2.image_cost:hide()
        self.Button_buy_2:getChildByName("Label_price"):hide()
        self.Button_buy_2:getChildByName("Label_bought"):show()

    else
      self.Button_buy_2:setTouchEnabled(true)
        self.Button_buy_2:setGrayEnabled(false)

        self.Button_buy_2.label_cost:show()
        self.Button_buy_2.image_cost:show()
        self.Button_buy_2:getChildByName("Label_price"):show()
        self.Button_buy_2:getChildByName("Label_bought"):hide()
    end

end

function NewGiftByEnglishVerView:updatePanel_3( ... )
    local giftData = self.activityInfo_.extendData.gift_1

    local buyId = 0
    for k , v in pairs(giftData) do
        local shopData = RechargeDataMgr:getOneRechargeCfg(v)
        self.PanelUI_3_items[k].label_name:setText(Utils:MultiLanguageStringDeal(shopData.name2))
        self.PanelUI_3_items[k].label_des:setText(Utils:MultiLanguageStringDeal(shopData.des3))

        self.PanelUI_3_items[k]:setTouchEnabled(true)
        self.PanelUI_3_items[k]:onClick(function(sender )
            local shopData = RechargeDataMgr:getOneRechargeCfg(v)
            local itemCfg = GoodsDataMgr:getItemCfg(shopData.exchangeCost[1].id)
            self.Button_buy_3.image_cost:setTexture(itemCfg.icon)
            self.Button_buy_3.image_cost:setScale(0.5)
            self.Button_buy_3.label_cost:setTextById(800007 ,shopData.exchangeCost[1].num)
            self.Button_buy_3.shopId = shopData.rechargeCfg.id

            for seleK , seleImg in pairs(self.PanelUI_3_items) do
                if seleImg == sender then
                    seleImg:getChildByName("Image_select"):show()
                else
                    seleImg:getChildByName("Image_select"):hide()
                end

            end
            
        end)

        if not self.Button_buy_3.shopId  and k == 1 then  --默认选择第一个
            local shopData = RechargeDataMgr:getOneRechargeCfg(giftData[1])
            local itemCfg = GoodsDataMgr:getItemCfg(shopData.exchangeCost[1].id)
            self.Button_buy_3.image_cost:setTexture(itemCfg.icon)
            self.Button_buy_3.image_cost:setScale(0.5)
            self.Button_buy_3.label_cost:setTextById(800007 ,shopData.exchangeCost[1].num)
            self.Button_buy_3.shopId = shopData.rechargeCfg.id

            

            for seleK , seleImg in pairs(self.PanelUI_3_items) do
                seleImg:getChildByName("Image_select"):hide()
                seleImg:getChildByName("Image_select"):setTexture("ui/activity/assist/kuangsan/009.png")
            end

            self.PanelUI_3_items[1]:getChildByName("Image_select"):show()
        end

        for i=1,4 do
            if i == #shopData.item then
                self.PanelUI_3_items[k].panel_group[i]:show()
                for index=1,i do
                    local imageIcon = self.PanelUI_3_items[k].panel_group[i]:getChildByName("Image_icon_"..index)
                    if not imageIcon.goodsItem then
                        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                        Panel_goodsItem:setTouchEnabled(false)
                        Panel_goodsItem:Pos(0, 0)
                        Panel_goodsItem:AddTo(imageIcon)
                        imageIcon.goodsItem = Panel_goodsItem
                        imageIcon.goodsItem:setTouchEnabled(true)
                        imageIcon:setScale(0.8)
                    end
                    local itemData = shopData.item[index]
                    PrefabDataMgr:setInfo(imageIcon.goodsItem, itemData.id, itemData.num)
                end
            else
                self.PanelUI_3_items[k].panel_group[i]:hide()
            end
        end

        if RechargeDataMgr:getBuyCount(shopData.rechargeCfg.id) >= 1 then
           buyId = shopData.rechargeCfg.id
        end
    end

    if buyId ~= 0 then
        self.Button_buy_3:setTouchEnabled(false)
        self.Button_buy_3:setGrayEnabled(true)
        self.Panel_show_ui[3]:hide()
        self.Panel_yigoumai:show()
        self:updateYigoumai_1(buyId)
    else
        self.Button_buy_3:setTouchEnabled(true)
        self.Button_buy_3:setGrayEnabled(false)
        self.Panel_show_ui[3]:show()
        self.Panel_yigoumai:hide()
    end

   
end

function NewGiftByEnglishVerView:updateYigoumai_1(buyId )
    local shopData = RechargeDataMgr:getOneRechargeCfg(buyId)
    local  items =  ActivityDataMgr2:getItems(self.activityInfo_.id)
    local itemList = {}
    for k , v in pairs(items) do
      local itemData = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType , v)
        if itemData.extendData["gift_1"] then  
            if itemData.subType == 3001 then
              table.insert(itemList , itemData)
            end
        end
    end

    local panel_group_idx = #shopData.item

    for i=1,5 do
        local panle_group = self.Panel_reward_show.panel_group[i]
        if panel_group_idx == i then
            panle_group:show()
        else
            panle_group:hide()
        end
    end
    for i=1,panel_group_idx do
      local ImagIcon = self.Panel_reward_show.panel_group[panel_group_idx]:getChildByName("Image_icon_"..i)
      ImagIcon:hide()
    end
    for k ,v in pairs(shopData.item) do
        local ImagIcon = self.Panel_reward_show.panel_group[panel_group_idx]:getChildByName("Image_icon_"..k)
        ImagIcon:show()
        if not ImagIcon.goodsItem then
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setTouchEnabled(false)
            Panel_goodsItem:Pos(0, 0)
            Panel_goodsItem:AddTo(ImagIcon)
            ImagIcon.goodsItem = Panel_goodsItem
            Panel_goodsItem:setTouchEnabled(true)
            Panel_goodsItem:setScale(0.7)
        end
        PrefabDataMgr:setInfo(ImagIcon.goodsItem, v.id, v.num)
    end

    self.Panel_reward_show:getChildByName("label_name"):setText(Utils:MultiLanguageStringDeal(shopData.name2))

    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemList[1].id)
    self.Image_des_1:getChildByName("label_des"):setTextById(190000359 , progressInfo.progress)
    self.Image_des_1:getChildByName("label_info"):setText(Utils:MultiLanguageStringDeal(itemList[1].extendData.des2))

    self.Image_des_2:getChildByName("label_des"):setTextById(190000355 ,MainPlayer:getPlayerLv())
    self.Image_des_2:getChildByName("label_info"):setTextById(190000356 ,itemList[1].extendData.levelBonus)

    local itemReward = {}
    for k ,v in pairs(itemList[1].reward) do
        table.insert(itemReward , {id = k , num = v })
    end

    for i=1,3 do
       local image_icon = self.Image_des_1:getChildByName("Image_reward_"..i)
      image_icon:show()


       local image_icon_2 = self.Image_des_2:getChildByName("Image_reward_"..i)
       image_icon_2:show()

       if i <= #itemReward then
         if not image_icon.goodsItem then
              local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
              Panel_goodsItem:setTouchEnabled(false)
              Panel_goodsItem:Pos(0, 0)
              Panel_goodsItem:AddTo(image_icon)
              image_icon.goodsItem = Panel_goodsItem
              Panel_goodsItem:setTouchEnabled(true)
              Panel_goodsItem:setScale(0.7)
          end
          PrefabDataMgr:setInfo(image_icon.goodsItem, itemReward[i].id, itemReward[i].num)


          if not image_icon_2.goodsItem then
              local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
              Panel_goodsItem:setTouchEnabled(false)
              Panel_goodsItem:Pos(0, 0)
              Panel_goodsItem:AddTo(image_icon_2)
              image_icon_2.goodsItem = Panel_goodsItem
              Panel_goodsItem:setTouchEnabled(true)
              Panel_goodsItem:setScale(0.7)
          end
          PrefabDataMgr:setInfo(image_icon_2.goodsItem, itemReward[i].id, itemReward[i].num * 2)
        else
          image_icon:hide()
          image_icon_2:hide()
        end
    end

     if progressInfo.status == EC_TaskStatus.ING then
        self.Button_get:getChildByName("btn_label"):setTextById(700013)
        self.Button_get:setTouchEnabled(false)
        self.Button_get:setGrayEnabled(true)
    elseif progressInfo.status == EC_TaskStatus.GET then
        self.Button_get:getChildByName("btn_label"):setTextById(700013)
        self.Button_get:setTouchEnabled(true)
        self.Button_get:setGrayEnabled(false)
    elseif progressInfo.status == EC_TaskStatus.GETED then
        self.Button_get:getChildByName("btn_label"):setTextById(14220068)
        self.Button_get:setTouchEnabled(false)
        self.Button_get:setGrayEnabled(true)
    end
    self.Button_get.id = itemList[1].id
    self.Button_get.lv = itemList[1].extendData.levelBonus
end

function NewGiftByEnglishVerView:updatePanel_4( ... )
  local giftData = self.activityInfo_.extendData.gift_2

   local buyId = 0
  for k , v in pairs(giftData) do
        local shopData = RechargeDataMgr:getOneRechargeCfg(v)
        self.PanelUI_4_items[k].label_name:setText(Utils:MultiLanguageStringDeal(shopData.name2))
        self.PanelUI_4_items[k].id = shopData.rechargeCfg.id

        local image_icons = self.PanelUI_4_items[k].image_icon
        for iconKey , icon in pairs(image_icons) do
            local shopItem = shopData.item[iconKey]
            if shopItem then
                icon:show()
                if not icon.goodsItem then
              local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
              Panel_goodsItem:setTouchEnabled(false)
              Panel_goodsItem:Pos(0, 0)
              Panel_goodsItem:AddTo(icon)
              icon.goodsItem = Panel_goodsItem
              Panel_goodsItem:setTouchEnabled(true)
              Panel_goodsItem:setScale(0.7)
            end
            PrefabDataMgr:setInfo(icon.goodsItem, shopItem.id, shopItem.num)
            else
                icon:hide()
            end
        end

        self.PanelUI_4_items[k]:onClick(function( sender )
            self.Button_buy_4.shopId = sender.id
            local shopDataNow = RechargeDataMgr:getOneRechargeCfg(sender.id)
            local itemCfg = GoodsDataMgr:getItemCfg(shopDataNow.exchangeCost[1].id)
            self.Button_buy_4.image_cost:setTexture(itemCfg.icon)
            self.Button_buy_4.image_cost:setScale(0.5)
            self.Button_buy_4.label_cost:setTextById(800007 ,shopDataNow.exchangeCost[1].num)

            for seleK , seleImg in pairs(self.PanelUI_4_items) do
                if sender == seleImg then
                    seleImg:getChildByName("Image_select"):show()
                else
                    seleImg:getChildByName("Image_select"):hide()
                end
            end
        end)
        
        if not self.Button_buy_4.shopId and k == 1 then  --默认选择第一个
            self.Button_buy_4.shopId = shopData.rechargeCfg.id
            local itemCfg = GoodsDataMgr:getItemCfg(shopData.exchangeCost[1].id)
            self.Button_buy_4.image_cost:setTexture(itemCfg.icon)
            self.Button_buy_4.image_cost:setScale(0.5)
            self.Button_buy_4.label_cost:setTextById(800007 ,shopData.exchangeCost[1].num)

            for seleK , seleImg in pairs(self.PanelUI_4_items) do
                seleImg:getChildByName("Image_select"):hide()
                seleImg:getChildByName("Image_select"):setTexture("ui/activity/assist/kuangsan/009.png")
            end
            self.PanelUI_4_items[k]:getChildByName("Image_select"):show()

        end


        if RechargeDataMgr:getBuyCount(shopData.rechargeCfg.id) >= 1 then
            buyId = shopData.rechargeCfg.id
        end
    end

    if buyId ~= 0 then
        self.Button_buy_4:setTouchEnabled(false)
        self.Button_buy_4:setGrayEnabled(true)
        self.Panel_show_ui[4]:hide()
        self.Panel_yigoumai:show()
        self:updateYigoumai_2(buyId)
    else
        self.Button_buy_4:setTouchEnabled(true)
        self.Button_buy_4:setGrayEnabled(false)
        self.Panel_show_ui[4]:show()
        self.Panel_yigoumai:hide()
    end

  
end


function NewGiftByEnglishVerView:updateYigoumai_2(buyId )
    local shopData = RechargeDataMgr:getOneRechargeCfg(buyId)
    local  items =  ActivityDataMgr2:getItems(self.activityInfo_.id)
    local itemList = {}
    for k , v in pairs(items) do
      local itemData = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType , v)
        if itemData.extendData["gift_2"] then  
            if itemData.subType == 3001 then
              table.insert(itemList , itemData)
            end
        end
    end

    local panel_group_idx = 5

    for i=1,5 do
        local panle_group = self.Panel_reward_show.panel_group[i]
        if panel_group_idx == i then
            panle_group:show()
        else
            panle_group:hide()
        end
    end

    for i=1,6 do
        ImagIcon = self.Panel_reward_show.panel_group[panel_group_idx]:getChildByName("Image_icon_"..i):hide()
    end

    for k ,v in pairs(shopData.item) do
        local ImagIcon = self.Panel_reward_show.panel_group[panel_group_idx]:getChildByName("Image_icon_"..k)
        ImagIcon:show()
        if not ImagIcon.goodsItem then
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setTouchEnabled(false)
            Panel_goodsItem:Pos(0, 0)
            Panel_goodsItem:AddTo(ImagIcon)
            ImagIcon.goodsItem = Panel_goodsItem
            Panel_goodsItem:setTouchEnabled(true)
            Panel_goodsItem:setScale(0.7)
        end
        PrefabDataMgr:setInfo(ImagIcon.goodsItem, v.id, v.num)
    end

    self.Panel_reward_show:getChildByName("label_name"):setText(Utils:MultiLanguageStringDeal(shopData.name2))

    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType,itemList[1].id)
    self.Image_des_1:getChildByName("label_des"):setTextById(190000359 , progressInfo.progress)
    self.Image_des_1:getChildByName("label_info"):setText(Utils:MultiLanguageStringDeal(itemList[1].extendData.des2))

    self.Image_des_2:getChildByName("label_des"):setTextById(190000355 ,MainPlayer:getPlayerLv())
    self.Image_des_2:getChildByName("label_info"):setTextById(190000356 ,itemList[1].extendData.levelBonus)


    local itemReward = {}
    for k ,v in pairs(itemList[1].reward) do
        table.insert(itemReward , {id = k , num = v })
    end

    for i=1,3 do
       local image_icon = self.Image_des_1:getChildByName("Image_reward_"..i)
      image_icon:show()


       local image_icon_2 = self.Image_des_2:getChildByName("Image_reward_"..i)
       image_icon_2:show()

       if i <= #itemReward then
         if not image_icon.goodsItem then
              local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
              Panel_goodsItem:setTouchEnabled(false)
              Panel_goodsItem:Pos(0, 0)
              Panel_goodsItem:AddTo(image_icon)
              image_icon.goodsItem = Panel_goodsItem
              Panel_goodsItem:setTouchEnabled(true)
              Panel_goodsItem:setScale(0.7)
          end
          PrefabDataMgr:setInfo(image_icon.goodsItem, itemReward[i].id, itemReward[i].num)


          if not image_icon_2.goodsItem then
              local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
              Panel_goodsItem:setTouchEnabled(false)
              Panel_goodsItem:Pos(0, 0)
              Panel_goodsItem:AddTo(image_icon_2)
              image_icon_2.goodsItem = Panel_goodsItem
              Panel_goodsItem:setTouchEnabled(true)
              Panel_goodsItem:setScale(0.7)
          end
          PrefabDataMgr:setInfo(image_icon_2.goodsItem, itemReward[i].id, itemReward[i].num * 2)
        else
          image_icon:hide()
          image_icon_2:hide()
        end
    end

    if progressInfo.status == EC_TaskStatus.ING then
        self.Button_get:getChildByName("btn_label"):setTextById(700013)
        self.Button_get:setTouchEnabled(false)
        self.Button_get:setGrayEnabled(true)
    elseif progressInfo.status == EC_TaskStatus.GET then
        self.Button_get:getChildByName("btn_label"):setTextById(700013)
        self.Button_get:setTouchEnabled(true)
        self.Button_get:setGrayEnabled(false)
    elseif progressInfo.status == EC_TaskStatus.GETED then
        self.Button_get:getChildByName("btn_label"):setTextById(14220068)
        self.Button_get:setTouchEnabled(false)
        self.Button_get:setGrayEnabled(true)
    end

    self.Button_get.id = itemList[1].id
    self.Button_get.lv = itemList[1].extendData.levelBonus
end


function NewGiftByEnglishVerView:updatePanel_5( ... )
    local giftData = self.activityInfo_.extendData.gift_3
    local rewardList = {}
    for k , v in pairs(giftData) do
        local shopData = RechargeDataMgr:getOneRechargeCfg(v)
        table.insert(rewardList , {reward = shopData.item , name =  shopData.name2 , isShop = true , shopId = shopData.rechargeCfg.id})
    end

    local  items =  ActivityDataMgr2:getItems(self.activityInfo_.id)
    local itemList = {}
    for k , v in pairs(items) do
      local itemData = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType , v)
        if itemData.extendData["gift_3"] then  
            if itemData.subType == 1010 then
                table.insert(itemList , itemData)
                local rewards = {}
                for rewardKey , rewardValue in pairs(itemData.reward) do
                    table.insert(rewards , {id = rewardKey , num = rewardValue})
                end
                table.insert(rewardList , {reward = rewards , name =  itemData.extendData.des2 , isShop = false , shopId = itemData.id})
            end
        end
    end

    local isBuyAll = false
    for k ,v in pairs(rewardList) do
        self.PanelUI_5_items[k]:getChildByName("Image_select"):hide()
         self.PanelUI_5_items[k]:getChildByName("Image_select"):setTexture("ui/activity/assist/kuangsan/009.png")
        local imgIcons = self.PanelUI_5_items[k].image_icon
        self.PanelUI_5_items[k].label_name:setText(Utils:MultiLanguageStringDeal(v.name))
        for rewardKey , reward in pairs(v.reward) do
            local image_icon = imgIcons[rewardKey]
            if not image_icon.goodsItem then
                local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                Panel_goodsItem:setTouchEnabled(false)
                Panel_goodsItem:Pos(0, 0)
                Panel_goodsItem:AddTo(image_icon)
                image_icon.goodsItem = Panel_goodsItem
                Panel_goodsItem:setTouchEnabled(true)
                Panel_goodsItem:setScale(0.7)
            end
            PrefabDataMgr:setInfo(image_icon.goodsItem, reward.id, reward.num)
        end

        local panel_lock = self.PanelUI_5_items[k].panel_lock
        self.PanelUI_5_items[k]:getChildByName("Panel_geted"):hide()
        if k <= 3 then   --商品购买流程
            if RechargeDataMgr:getBuyCount(v.shopId) >= 1 then
                  self.PanelUI_5_items[k]:getChildByName("Panel_geted"):show()
              end

            if RechargeDataMgr:getBuyCount(v.shopId) >= 1  and k == 3 then   
                panel_lock:hide()
                self.Button_buy_5.shopId = v.shopId
                local shopDataNow = RechargeDataMgr:getOneRechargeCfg(v.shopId)
                local itemCfg = GoodsDataMgr:getItemCfg(shopDataNow.exchangeCost[1].id)
                self.Button_buy_5.image_cost:setTexture(itemCfg.icon)
                self.Button_buy_5.image_cost:setScale(0.5)
                self.Button_buy_5.label_cost:setTextById(800007 ,shopDataNow.exchangeCost[1].num)


                self.Button_buy_5.image_cost:show()
                self.Button_buy_5.label_cost:show()
                self.Button_buy_5.label_price:show()
                self.Button_buy_5.label_get:hide()


                isBuyAll = true
            else
                if k == 1 then
                    panel_lock:hide()

                    self.Button_buy_5.shopId = v.shopId
                    local shopDataNow = RechargeDataMgr:getOneRechargeCfg(v.shopId)
                    local itemCfg = GoodsDataMgr:getItemCfg(shopDataNow.exchangeCost[1].id)
                    self.Button_buy_5.image_cost:setTexture(itemCfg.icon)
                    self.Button_buy_5.image_cost:setScale(0.5)
                    self.Button_buy_5.label_cost:setTextById(800007 ,shopDataNow.exchangeCost[1].num)


                    self.Button_buy_5.image_cost:show()
                    self.Button_buy_5.label_cost:show()
                    self.Button_buy_5.label_price:show()
                    self.Button_buy_5.label_get:hide()

                    if RechargeDataMgr:getBuyCount(rewardList[k].shopId) < 1 then
                        self.PanelUI_5_items[k]:getChildByName("Image_select"):show()
                    end
                else
                    if RechargeDataMgr:getBuyCount(rewardList[k-1].shopId) >= 1 then   
                        panel_lock:hide()
                        self.Button_buy_5.shopId = v.shopId
                        local shopDataNow = RechargeDataMgr:getOneRechargeCfg(v.shopId)
                        local itemCfg = GoodsDataMgr:getItemCfg(shopDataNow.exchangeCost[1].id)
                        self.Button_buy_5.image_cost:setTexture(itemCfg.icon)
                        self.Button_buy_5.image_cost:setScale(0.5)
                        self.Button_buy_5.label_cost:setTextById(800007 ,shopDataNow.exchangeCost[1].num)


                        self.Button_buy_5.image_cost:show()
                        self.Button_buy_5.label_cost:show()
                        self.Button_buy_5.label_price:show()
                        self.Button_buy_5.label_get:hide()

                        if RechargeDataMgr:getBuyCount(rewardList[k].shopId) < 1 then
                          self.PanelUI_5_items[k]:getChildByName("Image_select"):show()
                        end
                      else
                          panel_lock:show()
                      end

                end
            end
        else  --领取进度
            if isBuyAll == true then
                panel_lock:hide()
                self.Button_buy_5.shopId = v.shopId


                self.Button_buy_5.image_cost:hide()
                self.Button_buy_5.label_cost:hide()
                self.Button_buy_5.label_price:hide()
                self.Button_buy_5.label_get:show()

                self.Button_buy_5.get_reward = true

                local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v.shopId)
                self.PanelUI_5_items[k]:getChildByName("Image_select"):show()

                if progressInfo.status == EC_TaskStatus.ING then
                 elseif progressInfo.status == EC_TaskStatus.GET then
                    self.Button_buy_5:setTouchEnabled(true)
                    self.Button_buy_5:setGrayEnabled(false)
                 elseif progressInfo.status == EC_TaskStatus.GETED then
                    self.Button_buy_5:setTouchEnabled(false)
                    self.Button_buy_5:setGrayEnabled(true)
                    self.PanelUI_5_items[k]:getChildByName("Image_select"):hide()
                    self.PanelUI_5_items[k]:getChildByName("Panel_geted"):show()
                 end
            else
                panel_lock:show()
            end

        end
            
    end

end

function NewGiftByEnglishVerView:registerEvents()

  EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
  EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updatePlayerInfo, self))
  EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onRespGetReward, self))
   
    --EventMgr:addEventListener(self, EV_SUMMON_HISTORY, handler(self.onSummonHistoryEvent, self))
    
   for k , v in pairs(self.Panel_tab) do
        v.id = k
        v:onClick(function( toucItem )
            self:selectPanelTab(toucItem.id)
        end)
   end

   self.Button_buy_2:onClick(function( sender )
      RechargeDataMgr:getOrderNO(sender.shopId)
   end)

   self.Button_buy_3:onClick(function( sender)
        RechargeDataMgr:getOrderNO(sender.shopId)
  end)

   self.Button_buy_4:onClick(function( sender )
      RechargeDataMgr:getOrderNO(sender.shopId)
   end)

   self.Button_get:onClick(function( sender )
      if sender.lv > MainPlayer:getPlayerLv() then
          local view = Utils:openView("common.ConfirmBoxView")
          view:setCallback(function()
              ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, sender.id)
          end)
          local content = TextDataMgr:getText(63822)
          view:setContent(190000357)
      else
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, sender.id)
       end
   end)

   self.Button_buy_5:onClick(function( sender )
       if sender.get_reward then
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, sender.shopId)
       else
            RechargeDataMgr:getOrderNO(sender.shopId)
       end
   end)

end


function NewGiftByEnglishVerView:selectPanelTab(panelId)
    if self.selectIndex_ == panelId then
        return
    end
    for panelKey , panelUI in pairs(self.Panel_show_ui) do
        if panelKey == panelId then
            self.Panel_tab[panelKey]:getChildByName("Image_select"):setTexture("ui/activity/newGiftByEnglishVer/04.png")
            panelUI:show()
        else
            panelUI:hide()
            self.Panel_tab[panelKey]:getChildByName("Image_select"):setTexture("")
        end
    end
    self.selectIndex_ = panelId
    self:updateActivity()
end

function NewGiftByEnglishVerView:onUpdateProgressEvent( ... )
    self:updateActivity()
end

function NewGiftByEnglishVerView:updatePlayerInfo( ... )
   self:updateActivity()
end

function NewGiftByEnglishVerView:onRespGetReward(activityID, Entry, reward)
  if activityID == self.activityInfo_.id then
      Utils:showReward(reward)
      self:updateActivity()
  end
end

function NewGiftByEnglishVerView:removeEvents( ... )
     self:removeCountDownTimer()
end

function NewGiftByEnglishVerView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.updateCountDonw, self))
    end
end

function NewGiftByEnglishVerView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end


function NewGiftByEnglishVerView:updateCountDonw()

    self.isEnd = ActivityDataMgr2:isEnd(self.activityInfo_.id)
    local serverTime = ServerDataMgr:getServerTime()
    if self.isEnd then
        for k , v in pairs(self.Panel_show_ui) do
            local  image_time = v:getChildByName("Image_time")
            if image_time then
                image_time:getChildByName("Label_time"):setTextById(219009)
            end
        end
        self.Panel_yigoumai:getChildByName("Label_time"):setTextById(219009)
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            for k , v in pairs(self.Panel_show_ui) do
                local  image_time = v:getChildByName("Image_time")
                if image_time then
                    image_time:getChildByName("Label_time"):setTextById("r41002", hour, min)
                end
            end
            self.Panel_yigoumai:getChildByName("Label_time"):setTextById("r41002", hour, min)
        else
            for k , v in pairs(self.Panel_show_ui) do
                  local  image_time = v:getChildByName("Image_time")
                  if image_time then
                      image_time:getChildByName("Label_time"):setTextById("r41001", day, hour)
                  end
            end
            self.Panel_yigoumai:getChildByName("Label_time"):setTextById("r41001", day, hour)
        end
    end
end

return NewGiftByEnglishVerView
