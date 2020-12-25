
local HeroGrowUpView = class("HeroGrowUpView", BaseLayer)

local GROWUP_TYPE =
{
    SHU_XING = 1 , --属性
    TIAN_SHI = 2 , --天使
    XING_WU  = 3 , --信物
    ZHI_DIAN = 4 , --质点
    BAO_SHI  = 5   --宝石
}

local TAB_INDEX = { 1,3,4,2,5  }
-- local CHAPTERS  = { 500002 , 500003 }
local function createDelayShowAction(time)
    return Sequence:create({
                DelayTime:create(time),
                Show:create()
            })
end

function HeroGrowUpView:initData(rewards)
    self.heroId    = FubenDataMgr:getSelectSimulationHeroId() or 110211
    local cfg = FubenDataMgr:getSimulationTrialCfg(self.heroId)
    if not cfg then
        Box("no heroId "..tostring(self.heroId).." in SimulationTrialHigh")
        return
    end
    self.resConfig = cfg.heroGrowUp
--     rewards = {
--     {id=599801},
--     {id=599802},
--     {id=599803},
--     {id=599804},
--     {id=599805},
--     {id=599806},
--     {id=599807},
--     {id=599808},
--     {id=599809},
--     {id=599810},
--     {id=599811},
--     {id=599812},
--     {id=599812},
--     {id=599813},
--     {id=599814},
--     {id=599815},
--     {id=599816},
--     {id=599817},
--     {id=599818},
--     {id=599819},
-- }
    local datas = {}
    local itemDatas = TabDataMgr:getData("Item")
    local rewardEx  = {}
    for i,v in ipairs(rewards) do
        local cfg = itemDatas[v.id]
        if cfg then
            local superType = cfg.superType
            if superType == EC_SimulationTrialRewradType.JinYan then
                datas[1] = datas[1] or {attrs={}}
                local stringID = cfg.useProfit.stringID
                local value1   = cfg.useProfit.value1
                local value2   = cfg.useProfit.value2
                table.insert(datas[1].attrs,{stringID = stringID ,value1 = value1,value2 = value2}) 
            elseif superType == EC_SimulationTrialRewradType.JinJie then
                datas[1] = datas[1] or {attrs={}}
                local value1   = cfg.useProfit.value1
                local value2   = cfg.useProfit.value2
                datas[1].quality = {value1 = value1,value2 = value2}
            elseif superType == EC_SimulationTrialRewradType.TuPo then
                datas[1] = datas[1] or {attrs={}}
                local stringID = cfg.useProfit.stringID 
                local value1   = cfg.useProfit.value1
                local value2   = cfg.useProfit.value2
                table.insert(datas[1].attrs,{stringID = stringID ,value1 = value1,value2 = value2}) 
            elseif superType == EC_SimulationTrialRewradType.JiNeng then
                datas[2] = datas[2] or {}
                table.insert(datas[2],cfg.useProfit.stringID) 
            elseif superType == EC_SimulationTrialRewradType.XinWu then
                datas[3] = datas[3] or {}
                table.insert(datas[3],cfg.useProfit.newequipID) 
            elseif superType == EC_SimulationTrialRewradType.ZhiDian then
                datas[4] = datas[4] or {}
                table.insert(datas[4],cfg.useProfit.equipID) 
            elseif superType == EC_SimulationTrialRewradType.BaoShi then
                datas[5] = datas[5] or {}
                table.insert(datas[5],cfg.useProfit.stoneID) 
            else
                dump({v.id ,superType})
            end
        else
            Box("not found:"..tostring(v.id))
        end
    end
    self.datas = {}
    for k,v in pairs(datas) do
        local data = {growType = k , data = v}
        table.insert(self.datas,data)
    end
    dump(self.datas)
    self.startTime = os.time()
    self.jumpTab = 1
end

function HeroGrowUpView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    -- self:showPopAnim(true)
    self:init("lua.uiconfig."..self.resConfig.ui)
end

function HeroGrowUpView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root   = TFDirector:getChildByPath(ui, "Panel_root")

    self.Button_details     = TFDirector:getChildByPath(self.Panel_root, "Button_details")
    self.Panel_types = {}
    for i=1,5 do
        self.Panel_types[i] = TFDirector:getChildByPath(self.Panel_root, "Panel_type"..i):hide()
    end

    self.skeletonNode_title = TFDirector:getChildByPath(self.Panel_root, "Spine_title")
    self.skeletonNode_bg = TFDirector:getChildByPath(self.Panel_root, "Spine_bg")
    self.skeletonNode_bg:show()
    if self.resConfig.skeleton_default then 
        self.skeletonNode_bg:setupPoseWhenPlay(false)
        self.skeletonNode_bg:playByIndex(0,-1,-1,1)
    else
        self.skeletonNode_bg:setupPoseWhenPlay(false)
        self.skeletonNode_bg:playByIndex(0,0)
        self.skeletonNode_bg:addMEListener(TFARMATURE_COMPLETE,function()
            self.skeletonNode_bg:removeMEListener(TFARMATURE_COMPLETE)
            self.skeletonNode_bg:playByIndex(1,-1,-1,1)

        end)
    end
    self.spine_yindao        = TFDirector:getChildByPath(self.Panel_root  , "Spine_yindao"):hide()
    self.Label_continue      = TFDirector:getChildByPath(self.Panel_root  , "Label_continue"):hide()

    self:nextPanel()
end
function HeroGrowUpView:showGuide()
        self.spine_yindao:show()
        self.spine_yindao:playByIndex(0,0)
        self.spine_yindao:addMEListener(TFARMATURE_COMPLETE,function()
            self.spine_yindao:removeMEListener(TFARMATURE_COMPLETE)
            self.spine_yindao:playByIndex(2,1)
        end)
end
function HeroGrowUpView:nextPanel()
    if #self.datas > 0 then 
        for i, panel in ipairs(self.Panel_types) do
            panel:hide()
        end
        local curData = self.datas[#self.datas]
        self.datas[#self.datas] = nil
        dump(curData)
        self["initPanelType"..curData.growType](self,curData.data)
        self.jumpTab = curData.growType
        self.startTime = os.time()
        self:showGuide()
    end
end




function HeroGrowUpView:initSkeletonTitle(growType)
    local anmaitonIndex = (growType -1)*2
    self.skeletonNode_title:setupPoseWhenPlay(true)
    self.skeletonNode_title:playByIndex(anmaitonIndex,0)
    self.skeletonNode_title:show()
    TFAudio.playEffect("sound/ui/function_014.mp3",false,1,0)
    self.skeletonNode_title:addMEListener(TFARMATURE_COMPLETE,function()
        self.skeletonNode_title:removeMEListener(TFARMATURE_COMPLETE)
        self.skeletonNode_title:setupPoseWhenPlay(false)
        self.skeletonNode_title:playByIndex(anmaitonIndex + 1,1)
    end)
end

function HeroGrowUpView:initPanelType1(data)
    self:initSkeletonTitle(1)
    local panel = self.Panel_types[1]
    panel:show()
    for i=1,2 do
        local node  = panel:getChildByName("Panel_item"..i)
        if i <= #data.attrs then 
            local attr = data.attrs[i]
            node:getChildByName("Label_attr"):setTextById(attr.stringID)
            node:getChildByName("Label_value1"):setText(attr.value1)
            node:getChildByName("Label_value2"):setText(attr.value2)
            node:hide()
            node:runAction(createDelayShowAction(0.05*(i+3)))
        else
            node:hide()
        end
    end
    local Image_next              = panel:getChildByName("Image_next"):hide()
    local Image_level_parent      = panel:getChildByName("Image_level_parent"):hide() 
    local Image_level_next_parent = panel:getChildByName("Image_level_next_parent"):hide()
    local Image_level      = Image_level_parent:getChildByName("Image_level")
    local Image_level_next = Image_level_next_parent:getChildByName("Image_level_next")
    Image_level:setTexture(HeroDataMgr:getQualityPicNotHave(1,data.quality.value1))
    Image_level:setScale(0.3)
    Image_level_next:setTexture(HeroDataMgr:getQualityPicNotHave(1,data.quality.value2))
    Image_level_next:setScale(0.3)
    Image_level_parent:runAction(createDelayShowAction(0.05*1))
    Image_next:runAction(createDelayShowAction(0.05*2))
    Image_level_next_parent:runAction(createDelayShowAction(0.05*3))
end

function HeroGrowUpView:initPanelType2(datas)
    self:initSkeletonTitle(2)
    local panel = self.Panel_types[2]
    panel:show()
    -- local datas = 
    -- {
    --     {attr = "天使技能点20", value1 = 100 , value2 = 150} ,
    --     {attr = "解锁被动技能栏", value1 = 200 , value2 = 350} ,
    -- }

    for i=1,3 do
        local node  = panel:getChildByName("Panel_item"..i)
        if i <= #datas then 
            local data = datas[i]
            node:getChildByName("Label_desc"):setTextById(data)
            -- node:getChildByName("Label_value"):setText(data.value1)
            node:getChildByName("Label_value"):hide()
            node:hide()
            node:runAction(createDelayShowAction(0.05*i))
        else
            node:hide()
        end
    end
end

--信物
function HeroGrowUpView:initPanelType3(datas)
    self:initSkeletonTitle(3)
    local panel = self.Panel_types[3]
    panel:show()
    -- local datas = 
    -- {
    --     300024,
    --     300025,
    --     300026,
    --     300027,
    --     300028,
    --     300029,
    -- }

    for i=1,6 do
        local node  = panel:getChildByName("Panel_item"..i)
        if i <= #datas then 
            local tokenCfg = CollectDataMgr:getTokenCfg(datas[i])
            node.cid = datas[i]
            self:updateItemCard3(node,tokenCfg)
            node:hide()
            node:runAction(createDelayShowAction(0.05*i))
        else
            node:hide()
        end
    end
end

function HeroGrowUpView:updateItemCard3(itemCard,tokenCfg)
    itemCard:getChildByName("Image_frame"):setTexture(EC_ItemIcon[tokenCfg.quality])
    local scroll_star = itemCard:getChildByName("ScrollView_star")
    local star_cell = scroll_star:getChildByName("Panel_star")
    local starsize = star_cell:getContentSize()
    local star_listView = UIListView:create(scroll_star)
    star_listView:setItemModel(star_cell)
    star_listView:setContentSize(me.size(starsize.width*tokenCfg.star,starsize.height))
    for st =1,tokenCfg.star do
        star_listView:pushBackDefaultItem()
    end

    TFDirector:getChildByPath(itemCard,"Label_level_title"):setTextById(800006, "")
    TFDirector:getChildByPath(itemCard,"Label_level"):setText(tokenCfg.level)


    itemCard:getChildByName("Image_icon"):setTexture(tokenCfg.icon)
    itemCard:onClick(function()
        Utils:showInfo(itemCard.cid)
    end)
end


function HeroGrowUpView:updateItemCard4(itemCard,equipCfg)
    dump(equipCfg)
    itemCard:getChildByName("Image_equip_back"):setTexture(EC_EquipBoard[equipCfg.quality])
    itemCard:getChildByName("Image_frame"):setTexture(EC_EquipFrame[equipCfg.quality])
    for t = 1, 5 do
        itemCard:getChildByName("Image_star_"..t):setVisible(t <= equipCfg.star)
    end
    itemCard:getChildByName("Label_levelTitle"):setTextById(800006, "")
    itemCard:getChildByName("Label_level"):setText(equipCfg.maxLevel)
    itemCard:getChildByName("Image_type"):setTexture(EC_EquipSubTypeIconBag[equipCfg.subType])
    itemCard:getChildByName("Label_cost"):setText(equipCfg.cost)
    itemCard:getChildByName("Image_icon"):setTexture(equipCfg.halfPaint)
    itemCard:getChildByName("Label_name"):setTextById(tonumber(equipCfg.nameTextId))
    itemCard:onClick(function()
        Utils:showInfo(itemCard.cid)
    end)
end


function HeroGrowUpView:updateItem5(node, cfg)
    local Image_bg         = TFDirector:getChildByPath(node,"Image_bg")
    local Image_quality_bg = TFDirector:getChildByPath(node,"Image_quality_bg")
    local Image_quality    = TFDirector:getChildByPath(node,"Image_quality")
    local Image_icon       = TFDirector:getChildByPath(node,"Image_icon")
    Image_icon:setTexture(cfg.icon)
    Image_bg:setTexture(EquipmentDataMgr:getGemIconBg(cfg.quality))
    Image_quality_bg:setTexture(EquipmentDataMgr:getGemQualityBg(cfg.quality))
    Image_quality:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))
    node:setTouchEnabled(true)
    node:onClick(function()
        Utils:showInfo(node.cid)
    end)
end



--质点
function HeroGrowUpView:initPanelType4(datas)
    self:initSkeletonTitle(4)
    local panel = self.Panel_types[4]
    panel:show()
    -- local datas = 
    -- {
    --     220027,
    --     220028
    -- }
    for i=1,3 do
        local node  = panel:getChildByName("Panel_item"..i)
        if i <= #datas then 
            local equipCfg = CollectDataMgr:getEquipCfg(datas[i])
            node.cid = datas[i]
            self:updateItemCard4(node,equipCfg)
            node:hide()
            node:runAction(createDelayShowAction(0.1*i))
        else
            node:hide()
        end
    end
end


--宝石
function HeroGrowUpView:initPanelType5(datas)
    self:initSkeletonTitle(5)
    local panel = self.Panel_types[5]
    panel:show()
    -- local datas = 
    -- {
    --     1309421,
    --     1305331,
    --     1318631,
    --     1301241
    -- }
    for i=1,4 do
        local node  = panel:getChildByName("Panel_item"..i)
        if i <= #datas then 
            node:hide()
            local cfg =  TabDataMgr:getData("Stone",datas[i])    
            node.cid = datas[i]
            self:updateItem5(node,cfg)
            node:runAction(createDelayShowAction(0.1*i))
        else
            node:hide()
        end
    end
end


function HeroGrowUpView:registerEvents()
    -- EventMgr:addEventListener(self, EV_FUBEN_LEVELGROUPREWARD, handler(self.onGetLevelGroupRewardEvent, self))
    self.Button_details:onClick(function()
        local heroId = FubenDataMgr:getSelectSimulationHeroId()
        HeroDataMgr.showid =  heroId
        local tabIdx = TAB_INDEX[self.jumpTab] or 1
        AlertManager:closeLayer(self)
        Utils:openView("simulationTrial.FairyTrailDetailsLayer", {showid=HeroDataMgr.showid , friend=false, gotoWhichTab = tabIdx, isGuide = true})

    end)
    self.Panel_root:setTouchEnabled(true)
    self.Panel_root:onClick(function()
        -- AlertManager:closeLayer(self)
        -- dump({os.time() , self.startTime})
        if os.time() - self.startTime >= 1 then
            if #self.datas > 0 then 
                self:nextPanel()
            -- else
                -- AlertManager:closeLayer(self)
            end
        end
    end)
end

return HeroGrowUpView
