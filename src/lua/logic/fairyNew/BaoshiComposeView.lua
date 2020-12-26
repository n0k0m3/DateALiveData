local BaoshiComposeView = class("BaoshiComposeView", BaseLayer)

function BaoshiComposeView:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data or {}
    self:initData()
    self:init("lua.uiconfig.fairyNew.baoshiComposeView")
end

function BaoshiComposeView:initData()

    self.minRarity = 2
    self.maxRarity = 6


    self.gem_group = {}
    self.spineLineAnim = {}
    self.spineEffectAnim = {}

    self.rarity_ = self.paramData_.rarity or self.minRarity
    self.heroId_ = nil
    self.selectPos = nil
    self.selectTuzhiIdx = nil
    self.selectData = {}
    self.composeCfgs = {}
    self.tuzhiData = {}
    self.curSelectGem = nil
    self.gemPos_ = {
            {ccp(68,280),ccp(326,280),ccp(199,64)},
            {ccp(68,200),ccp(199,327),ccp(332,200),ccp(199,69)},
            {ccp(68,247),ccp(199,327),ccp(332,247),ccp(280,93),ccp(118,93)}
    }
end

function BaoshiComposeView:getClosingStateParams()
    return {self.paramData_}
end

function BaoshiComposeView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_left        = TFDirector:getChildByPath(ui,"Panel_left")
    self.Panel_right        = TFDirector:getChildByPath(ui,"Panel_right")
    self.Panel_tuzhi        = TFDirector:getChildByPath(ui,"Panel_tuzhi")
    self.Panel_quality        = TFDirector:getChildByPath(ui,"Panel_quality")
    self.Panel_pos        = TFDirector:getChildByPath(ui,"Panel_pos")
    self.Panel_detail        = TFDirector:getChildByPath(ui,"Panel_detail")
    self.Panel_di        = TFDirector:getChildByPath(ui,"Panel_di")
    self.Panel_tuzhi_item = TFDirector:getChildByPath(ui,"Panel_tuzhi_item")
    self.Panel_baoshi_item    = TFDirector:getChildByPath(ui,"Panel_baoshi_item")
    self.Panel_touch = TFDirector:getChildByPath(ui,"Panel_touch")

    self.Panel_center = TFDirector:getChildByPath(self.Panel_left,"Panel_center"):hide()
    self.PageView_center = TFDirector:getChildByPath(self.Panel_left,"PageView_center")
    self.PageView_center:setMinTouchMoveDistance(200)
    self.PageView_center:addMEListener(TFPAGEVIEW_SCROLLENDED, function()
        self:pageScrollEnd()
    end)

    self.Panel_scroll_bg = TFDirector:getChildByPath(self.Panel_left,"Panel_scroll_bg")

    local ScrollView_tuzhi    = TFDirector:getChildByPath(self.Panel_left,"ScrollView_tuzhi")
    self.TableView_tuzhi = Utils:scrollView2TableView(ScrollView_tuzhi)

    self.TableView_tuzhi:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_tuzhi:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_tuzhi:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    
    self.button_left = TFDirector:getChildByPath(self.Panel_left,"button_left")
    self.button_right = TFDirector:getChildByPath(self.Panel_left,"button_right")

    self.quality_imgs = {}
    self.Panel_quality_item    = TFDirector:getChildByPath(ui,"Panel_quality_item")
    for i=1,6 do
        local Image_quality = TFDirector:getChildByPath(self.Panel_quality_item,"Image_quality"..i)
        self.quality_imgs[i] = Image_quality
    end

    self.Spine_compose = TFDirector:getChildByPath(self.Panel_left,"Spine_compose"):hide()
    self.Label_tuzhi_desc = TFDirector:getChildByPath(self.Panel_left,"Label_tuzhi_desc"):hide()

    self.Label_no_tuzhi = TFDirector:getChildByPath(self.Panel_detail,"Label_no_tuzhi"):hide()
    self.Label_no_tuzhi:setTextById(1100035)
    self.ScrollView_items = TFDirector:getChildByPath(self.Panel_detail,"ScrollView_items")
    self.listView_items = UIGridView:create(self.ScrollView_items)
    self.listView_items:setItemModel(self.Panel_baoshi_item)
    self.listView_items:setColumn(4)
    self.listView_items:setColumnMargin(-1)
    self.listView_items:setRowMargin(-1)

    self.Image_gem_select = TFImage:create("ui/common/select.png")
    self.Image_gem_select:setVisible(false)
    self.Image_gem_select:setScale(0.9)
    self.Panel_detail:addChild(self.Image_gem_select)

    self.Button_compose    = TFDirector:getChildByPath(self.Panel_di,"Button_compose")
    self.Button_fast_compose    = TFDirector:getChildByPath(self.Panel_di,"Button_fast_compose")
    self.Button_view    = TFDirector:getChildByPath(self.Panel_di,"Button_view")
    self.Button_sort    = TFDirector:getChildByPath(self.Panel_di,"Button_sort"):hide()
    self.Button_gem_sort = TFDirector:getChildByPath(self.Panel_right,"Button_gem_sort"):hide()
    self.Image_cost_bg = TFDirector:getChildByPath(self.Panel_di,"Image_cost_bg")
    self.Image_res_icon = TFDirector:getChildByPath(self.Image_cost_bg,"Image_res_icon")
    self.Label_res_num = TFDirector:getChildByPath(self.Image_cost_bg,"Label_res_num")

    self:loadPage()

end

function BaoshiComposeView:refreshUI()

    self:updateTuzhiUI()
    self:updateGemPosUI()
    self:updateRarityImage()
    self:updateGemsItems()
    self:updateComposeCost()
    self:updateButtonState()
    self:updateSpineLineAnim(false)
end


function BaoshiComposeView:cellSizeForTable()
    local size = self.Panel_tuzhi_item:getSize()
    return size.height, size.width
end

function BaoshiComposeView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_tuzhi_item:clone():show()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        self:updateTuzhiItem(cell, idx)
    end

    return cell
end

function BaoshiComposeView:numberOfCellsInTableView()
    return #self.tuzhiData
end

function BaoshiComposeView:updateTuzhiItem(item, idx)

    local data = self.tuzhiData[idx]
    if not data then
        return
    end
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
    local Label_count = TFDirector:getChildByPath(item,"Label_count")
    local Image_select = TFDirector:getChildByPath(item,"Image_select"):hide()
    local Image_pos_bg = TFDirector:getChildByPath(item,"Image_pos_bg")
    Label_count:setText(tostring(GoodsDataMgr:getItemCount(data.drawingId)))
    local gemCfg = EquipmentDataMgr:getGemCfg(data.drawingId)
    Image_bg:setTextureNormal(EC_ItemIcon[gemCfg.quality])
    Image_bg:setTouchEnabled(true)
    Image_icon:setTexture(gemCfg.icon)
    Image_quality:setTexture(EquipmentDataMgr:getGemRarityIcon(gemCfg.rarity))
    Image_pos_bg:setTexture(EquipmentDataMgr:getGemPosBg(gemCfg.quality))

    for i=1,4 do
        local Image_pos = TFDirector:getChildByPath(item,"Image_pos"..i)
        Image_pos:setTexture(gemCfg.skillType == i and "ui/fairy/new_ui/baoshi/032.png" or "ui/fairy/new_ui/baoshi/031.png")
    end

    Image_bg:onClick(function()
        self:selectTuzhi(idx, item)
    end)

    if idx == 1 then
        self:selectTuzhi(idx, item)
    end
end


function BaoshiComposeView:loadPage()

    self.PageView_center:removeAllPages()
    for i=self.minRarity,self.maxRarity do
        local page = self.Panel_center:clone()
        page:show()
        self:addPageItem(page,i)
        self.PageView_center:addPage(page)
    end
    local pageId = self.rarity_ - 2
    self.PageView_center:scrollToPage(pageId,0)
end

function BaoshiComposeView:addPageItem(pageItem,pageId)

    if not self.gem_group[pageId] then
        self.gem_group[pageId] = {}
    end
    for i = 1, 5 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(pageItem,"Panel_pos_"..i):hide()
        foo.Image_add   = TFDirector:getChildByPath(foo.root,"Image_add")
        foo.Image_bg  = TFDirector:getChildByPath(foo.root,"Image_bg")
        foo.Image_quality_bg    = TFDirector:getChildByPath(foo.root,"Image_quality_bg")
        foo.Image_quality  = TFDirector:getChildByPath(foo.root,"Image_quality")
        foo.Image_icon    = TFDirector:getChildByPath(foo.root,"Image_icon")
        self.gem_group[pageId][i] = foo
    end


    self.gem_group[pageId].centerItem = TFDirector:getChildByPath(pageItem,"Panel_get_gem"):hide()
    self.gem_group[pageId].centerImagebg = TFDirector:getChildByPath(pageItem,"Image_bg")
    self.gem_group[pageId].centerQualitybg = TFDirector:getChildByPath(pageItem,"Image_quality_bg")
    self.gem_group[pageId].centerQualityIcon = TFDirector:getChildByPath(pageItem,"Image_quality")
    self.gem_group[pageId].centerItemIcon = TFDirector:getChildByPath(pageItem,"Image_icon")
    self.gem_group[pageId].Image_tuzhi_icon = TFDirector:getChildByPath(pageItem,"Image_tuzhi_icon")
    self.gem_group[pageId].Image_pos_bg = TFDirector:getChildByPath(pageItem,"Image_pos_bg")


    if not self.spineLineAnim[pageId] then
        self.spineLineAnim[pageId] = {}
    end
    for i=1,5 do
        local Spine_line = TFDirector:getChildByPath(pageItem,"Spine_line"..i):hide()
        self.spineLineAnim[pageId][i] = Spine_line
    end

    if not self.spineEffectAnim[pageId] then
        self.spineEffectAnim[pageId] = {}
    end
    for i=1,5 do
        local Spine_effect = TFDirector:getChildByPath(pageItem,"Spine_effect"..i):hide()
        self.spineEffectAnim[pageId][i] = Spine_effect
    end
end


function BaoshiComposeView:updateTuzhiUI()
    self.composeCfgs = {}
    self.tuzhiData = {}
    self.selectData = {}
    self.selectTuzhiIdx = nil
    self.lastTuzhiSelect = nil
    if self.rarity_ < 4 then
        self.composeCfgs = EquipmentDataMgr:getGemComposeCfgs(self.rarity_)
    else
        self.composeCfgs = EquipmentDataMgr:getGemComposeCfgs(self.rarity_, self.heroId_, self.selectPos)
    end
    
    for i,v in ipairs(self.composeCfgs) do
        if v.needDrawing and GoodsDataMgr:getItemCount(v.drawingId) > 0 then
            table.insert(self.tuzhiData, v)
        end
    end

    self.Panel_tuzhi:setVisible(self.rarity_ > 4)
    self.Label_no_tuzhi:setVisible(self.rarity_ > 4 and #self.tuzhiData < 1)

    self.TableView_tuzhi:reloadData()
end


function BaoshiComposeView:selectTuzhi(idx, item)

    if self.selectTuzhiIdx == idx then
        return
    end
    self.selectTuzhiIdx = idx
    if self.lastTuzhiSelect then
        self.lastTuzhiSelect:hide()
    end
    local Image_select = TFDirector:getChildByPath(item,"Image_select")
    Image_select:show()
    self.lastTuzhiSelect = Image_select
    self.selectData = {}
    self:updateGemPosUI()
    self:updateGemsItems()
    self:updateButtonState()
    self:updateComposeCost()
    self:updateSpineLineAnim(false)
end

function BaoshiComposeView:updateGemPosUI()

    local composeCfg = self.selectTuzhiIdx and self.tuzhiData[self.selectTuzhiIdx] or self.composeCfgs[1]
    local graph = composeCfg and composeCfg.graph or 3
    local tuzhiCfg = EquipmentDataMgr:getGemCfg(composeCfg and composeCfg.drawingId or 0) or {}
    self.gem_group[self.rarity_].Image_pos_bg:setTexture(EquipmentDataMgr:getGemComposeBg(graph))
    self.gem_group[self.rarity_].Image_tuzhi_icon:setTexture(self.selectTuzhiIdx and tuzhiCfg.icon or self:getDefaultTuzhi())

    self.Label_tuzhi_desc:setVisible(false)
    if composeCfg and composeCfg.needDrawing and GoodsDataMgr:getItemCount(composeCfg.drawingId) > 0 then
        local cfg = EquipmentDataMgr:getGemCfg(composeCfg.drawingId)
        local heroName = HeroDataMgr:getName(cfg.heroId)
        local desc = heroName.." "..TextDataMgr:getText(cfg.skillName)
        self.Label_tuzhi_desc:setVisible(true)
        self.Label_tuzhi_desc:setText(desc)
    end
    local style = graph - 2

    local gem_pos = self.gem_group[self.rarity_]

    for i,v in ipairs(gem_pos) do
        if i <= graph then
            v.root:show()
            v.root:setPosition(self.gemPos_[style][i])
            self:updatePosItem(i, v)
        else
            v.root:hide()
        end
    end
    for i = 1, graph do
        self.spineEffectAnim[self.rarity_][i]:setVisible(false)
    end
end

function BaoshiComposeView:getDefaultTuzhi()
    if self.rarity_ == 2 then
        return "ui/fairy/new_ui/baoshi/Drawing_c.png"
    elseif self.rarity_ == 3 then
        return "ui/fairy/new_ui/baoshi/Drawing_b.png"
    elseif self.rarity_ == 4 then
        return "ui/fairy/new_ui/baoshi/Drawing_a.png"
    end
end

function BaoshiComposeView:updatePosItem(idx, item)

    local Image_add = item.Image_add
    local Image_bg = item.Image_bg
    local Image_quality_bg = item.Image_quality_bg
    local Image_quality = item.Image_quality
    local Image_icon = item.Image_icon
    local gemInfo = self.selectData[idx]
    if gemInfo then
        Image_bg:setVisible(true)
        Image_quality_bg:setVisible(true)
        Image_quality:setVisible(true)
        Image_icon:setVisible(true)
        local cfg = EquipmentDataMgr:getGemCfg(gemInfo.cid)
        Image_icon:setTexture(cfg.icon)
        Image_bg:setTexture(EquipmentDataMgr:getGemIconBg(cfg.quality))
        Image_quality_bg:setTexture(EquipmentDataMgr:getGemQualityBg(cfg.quality))
        Image_quality:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))
    else
        Image_bg:setVisible(false)
        Image_quality_bg:setVisible(false)
        Image_quality:setVisible(false)
        Image_icon:setVisible(false)
    end
end

function BaoshiComposeView:updateGemsItems()
    self.loadIndex = 1
    self.Panel_detail:stopAllActions()
    self.ScrollView_items:scrollToTop()
    self.Image_gem_select:retain()
    self.Image_gem_select:removeFromParent()
    self.Panel_detail:addChild(self.Image_gem_select,0,0)
    self.Image_gem_select:setVisible(false)
    self.Image_gem_select:release()
    self.curSelectGem = nil
    local rarity, heroId, pos
    local composeCfg = self.tuzhiData[self.selectTuzhiIdx] or self.composeCfgs[1]
    if not composeCfg then
        self.listView_items:removeAllItems()
        return
    end
    if #self.tuzhiData < 1 and self.rarity_ > 4 then
        self.listView_items:removeAllItems()
        return
    end
    local condition = composeCfg.materialCondition
    rarity = condition[1]
    if self.selectTuzhiIdx and composeCfg.needDrawing then
        heroId = condition[2]
        pos = condition[3]
    elseif not composeCfg.needDrawing then
        heroId = self.heroId_
        pos = self.selectPos
    end
    self.gemsData = EquipmentDataMgr:getUnUseGemInfosByHeroIdAndPos(rarity, heroId, pos)
    local items = self.listView_items:getItems()
    local gap = #items - #self.gemsData
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self.listView_items:removeItem(1)
        end
    end

    local function loadGemItem()
        if self.loadIndex > #self.gemsData then
            return
        end
        local item = self.listView_items:getItem(self.loadIndex)
        if not item then
            item = self.Panel_baoshi_item:clone()
            self.listView_items:pushBackCustomItem(item)
        end
        self:updateBaoshiItem(self.loadIndex, item, self.gemsData[self.loadIndex])
        local seq = Sequence:create({
                DelayTime:create(0.02),
                CallFunc:create(function()
                        self.loadIndex = self.loadIndex + 1
                        loadGemItem()
                end)
        })
        self.Panel_detail:stopAllActions()
        self.Panel_detail:runAction(seq)
    end
    loadGemItem()
end

function BaoshiComposeView:updateBaoshiItem(idx, item, data)
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
    local Image_select = TFDirector:getChildByPath(item,"Image_select"):hide()
    local Image_pos_bg = TFDirector:getChildByPath(item,"Image_pos_bg")

    local cfg = EquipmentDataMgr:getGemCfg(data.cid)
    Image_bg:setTexture(EC_ItemIcon[cfg.quality])
    Image_icon:setTexture(cfg.icon)
    Image_quality:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))
    Image_pos_bg:setTexture(EquipmentDataMgr:getGemPosBg(cfg.quality))
    
    for i=1,4 do
        local Image_pos = TFDirector:getChildByPath(item,"Image_pos"..i)
        Image_pos:setTexture(cfg.skillType == i and "ui/fairy/new_ui/baoshi/032.png" or "ui/fairy/new_ui/baoshi/031.png")
    end
    
    item:setTouchEnabled(true)
    item:onClick(function()
        local success = self:addGemToCompose(data, item)
        Image_select:setVisible(success)
        self:updateGemPosUI()
        self:updateButtonState()
        self:updateSpineLineAnim(success)
    end)
end

function BaoshiComposeView:updateSpineLineAnim(success)
    local composeCfg = self.tuzhiData[self.selectTuzhiIdx or 1] or self.composeCfgs[1]
    local graph = composeCfg and composeCfg.graph or 3
    local count = table.count(self.selectData)
    if count >= graph and success then
        local style = graph - 2
        local linePos = {
            {ccp(197,279),ccp(260,166),ccp(139,164)},
            {ccp(130,286),ccp(279,275),ccp(275,122),ccp(122,120)},
            {ccp(135,290),ccp(268,289),ccp(302,174),ccp(198,96),ccp(95,172)},
        }
        local lineAngle = {
            {0, 120, -120},
            {-45,45,135,225},
            {-36,36,108,180,252},
        }
        for i = 1, graph do
            local line = self.spineLineAnim[self.rarity_][i]
            line:setVisible(true)
            line:setPosition(linePos[style][i])
            line:setRotation(lineAngle[style][i])
            line:play("stone_compose_1_0",false)
            line:addMEListener(TFARMATURE_COMPLETE,function()
                line:removeMEListener(TFARMATURE_COMPLETE)
                line:setAnimationFps(30)
                line:play("stone_compose_1_1",true)
            end) 
        end
        Utils:playSound(803, false)
    elseif count < graph then
        for i = 1, graph do
            self.spineLineAnim[self.rarity_][i]:setVisible(false)
        end
    end
end

function BaoshiComposeView:addGemToCompose(data, item)
    local composeCfg = self.tuzhiData[self.selectTuzhiIdx or 1] or self.composeCfgs[1]
    local graph = composeCfg.graph or 3
    local added = 0
    local idx
    for i=1, graph do
        local info = self.selectData[i]
        if info then
            added = added + 1
            if info.id == data.id then
                self.selectData[i] = nil
                self.curSelectGem = nil
                self.Image_gem_select:retain()
                self.Image_gem_select:removeFromParent()
                self.Panel_detail:addChild(self.Image_gem_select,0,0)
                self.Image_gem_select:setVisible(false)
                self.Image_gem_select:release()
                return false
            end
        else
            if not idx then
                idx = i
            end
        end
    end
    
    if added >= graph then
        Utils:showTips(1100024)
        return false
    end
    self.selectData[idx] = data
    self.curSelectGem = data

    self.Image_gem_select:retain()
    self.Image_gem_select:removeFromParent()
    item:addChild(self.Image_gem_select,0,0)
    self.Image_gem_select:setVisible(true)
    self.Image_gem_select:release()

    return true
end

function BaoshiComposeView:updateComposeCost()
    local composeCfg = self.tuzhiData[self.selectTuzhiIdx or 1] or self.composeCfgs[1]
    if not composeCfg then
        self.Label_res_num:setText("0")
        self.Label_res_num:setFontColor(ccc3(255,255,255))
        return
    end
    self.Image_cost_bg:setTouchEnabled(false)
    local cost = composeCfg.currency
    for k, v in pairs(cost) do
        local itemCfg = GoodsDataMgr:getItemCfg(tonumber(k))
        self.Label_res_num:setText(v)
        if GoodsDataMgr:getItemCount(tonumber(k)) < v then
            self.Label_res_num:setColor(ccc3(219,50,50))
        else
            self.Label_res_num:setColor(ccc3(255,255,255))
        end
        self.Image_res_icon:setTexture(itemCfg.icon)
        self.Image_cost_bg:setTouchEnabled(true)
        self.Image_cost_bg:onClick(function()
            Utils:showInfo(itemCfg.id, nil, true)
        end)
        break
    end
end

function BaoshiComposeView:updateButtonState()
    self.button_left:setVisible(self.rarity_ > self.minRarity)
    self.button_right:setVisible(self.rarity_ < self.maxRarity)
    local composeCfg = self.tuzhiData[self.selectTuzhiIdx or 1] or self.composeCfgs[1]
    local graph = composeCfg and composeCfg.graph or 3
    local count = table.count(self.selectData)
    self.Button_compose:setGrayEnabled(count< graph)
    self.Button_compose:setTouchEnabled(count >= graph)
    self.Button_sort:setVisible(self.rarity_ > 4)

    self.Button_gem_sort:setVisible(self.rarity_ <= 4)
    if self.curSelectGem then
        self.Button_view:setTouchEnabled(true)
        self.Button_view:setGrayEnabled(false)
    else
        self.Button_view:setTouchEnabled(false)
        self.Button_view:setGrayEnabled(true)
    end
    self.Button_fast_compose:setVisible(self.rarity_ <= 4)
end

function BaoshiComposeView:updateRarityImage()
    for i,v in ipairs(self.quality_imgs) do
        if self.rarity_ == (i + 1) then
            v:setOpacity(255)
        else
            v:setOpacity(120)
        end
    end
end

function BaoshiComposeView:changeRarity(isRight)
    if isRight then
        self.rarity_ = self.rarity_ + 1
    else
        self.rarity_ = self.rarity_ - 1
    end
    if self.rarity_ < self.minRarity then
        self.rarity_ = self.minRarity
    end
    if self.rarity_ > self.maxRarity then
        self.rarity_ = self.maxRarity
    end

    local pageId = self.rarity_ - 2
    self.PageView_center:scrollToPage(pageId,0.5)

    self:playRarityChangeAnim()
end

function BaoshiComposeView:playRarityChangeAnim()
    local function callBack()
        self.selectData = {}
        self.heroId_ = nil
        self.selectPos = nil
        --self:refreshUI()
    end
    local actions = {
        CCMoveTo:create(0.2, ccp(-(self.rarity_ - 3) * 80, 0)),
        CallFunc:create(callBack)
    }
    self.Panel_quality_item:runAction(Sequence:createWithTable(actions))
end

function BaoshiComposeView:onComposeBack(data)

    self.Button_compose:setTouchEnabled(false)
    local function comeposeOver()
        self.playingAnim = false
        self.Panel_touch:setTouchEnabled(false)

        self.gem_group[self.rarity_].centerItem:hide()

        if data.gem then
            local reward = {{id = data.gem.cid,originId = data.gem.id, num = 1}}
            Utils:showReward(reward)
        end
        self.selectTuzhiIdx = nil
        self.selectData = {}
        self.composeCfgs = {}
        self.tuzhiData = {}
        self:refreshUI()
    end
    if self.fastCompose then
        comeposeOver()
        self.fastCompose = false
        return
    end
    self.playingAnim = true
    self.Panel_touch:setTouchEnabled(true)
    self.Panel_touch:setSwallowTouch(true)
    self.Panel_touch:onClick(function()
        self.gem_group[self.rarity_].centerItem:hide()
        self.Spine_compose:setVisible(false)
        for k, effect in pairs(self.spineEffectAnim[self.rarity_]) do
            effect:setVisible(false)
        end
        comeposeOver()
    end)

    local composeCfg = self.tuzhiData[self.selectTuzhiIdx or 1] or self.composeCfgs[1]
    local graph = composeCfg and composeCfg.graph or 3
    local style = graph - 2
    local effectPos = {
        {ccp(68,280),ccp(326,280),ccp(199,64)},
        {ccp(68,200),ccp(199,327),ccp(332,200),ccp(199,69)},
        {ccp(68,247),ccp(199,327),ccp(332,247),ccp(280,93),ccp(118,93)},
    }
    local effectAngle = {
        {30, 150, -90},
        {0,90,180,-90},
        {18,90,168,-108,-72},
    }

    for i = 1, graph do
        local effect = self.spineEffectAnim[self.rarity_][i]
        effect:setVisible(true)
        effect:setPosition(effectPos[style][i])
        effect:setRotation(effectAngle[style][i])
        effect:play("stone_compose_2_0",false)
        effect:addMEListener(TFARMATURE_COMPLETE,function()
            effect:removeMEListener(TFARMATURE_COMPLETE)
            effect:play("stone_compose_3_0",true)
            effect:runAction(CCSequence:create({
            CCMoveTo:create(0.5, ccp(199, 200)),
            CCCallFunc:create(function()
                effect:setVisible(false)
            end)}))
        end)
    end
    self:timeOut(function()
        if not self.playingAnim then
            return
        end
        self.Spine_compose:play("stone_compose_5_0",false)
        self.Spine_compose:setVisible(true)
        self.Spine_compose:addMEListener(TFARMATURE_COMPLETE,function()
            self.Spine_compose:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_compose:play("stone_compose_6_1",false)
            self.Spine_compose:addMEListener(TFARMATURE_COMPLETE,function()
                if not self.playingAnim then
                    return
                end
                self.Spine_compose:setVisible(false)
                self.gem_group[self.rarity_].centerItem:hide()
                if data.gem then
                    local cfg = EquipmentDataMgr:getGemCfg(data.gem.cid)

                    self.gem_group[self.rarity_].centerImagebg:setTexture(EquipmentDataMgr:getGemIconBg(cfg.quality))
                    self.gem_group[self.rarity_].centerQualitybg:setTexture(EquipmentDataMgr:getGemQualityBg(cfg.quality))
                    self.gem_group[self.rarity_].centerQualityIcon:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))
                    self.gem_group[self.rarity_].centerItemIcon:setTexture(cfg.icon)

                    self:timeOut(function()
                        comeposeOver()
                    end, 0.4)
                end
            end)
        end)
    end,1.2)
end

function BaoshiComposeView:onTuzhiChooseBack(heroId, pos , isDecompose)
    if isDecompose then return end
    self.heroId_ = heroId
    self.selectPos = pos
    self:refreshUI()
end

function BaoshiComposeView:onItemUpdate()
    self:updateComposeCost()
end

function BaoshiComposeView:resetPageInfo(rarity)
    
    if not self.gem_group[rarity] then
        return
    end

    for i = 1, 5 do
        self.gem_group[rarity][i].root:hide()
    end

    if not self.spineLineAnim[rarity] then
        return
    end
    for i=1,5 do
        self.spineLineAnim[rarity][i]:hide()
    end


    if not self.spineEffectAnim[rarity] then
        self.spineEffectAnim[rarity] = {}
    end

    for i=1,5 do
        self.spineEffectAnim[rarity][i]:hide()
    end

end

function BaoshiComposeView:pageScrollEnd()

    local pageId = self.PageView_center:getCurPageIndex()
    self.rarity_ = pageId + 2
    if self.rarity_ < self.minRarity then
        self.rarity_ = self.minRarity
    end

    if self.rarity_ > self.maxRarity then
        self.rarity_ = self.maxRarity
    end

    if self.oldRarity_ == self.rarity_ then
        return
    end

    self:resetPageInfo(self.oldRarity_)
    self:playRarityChangeAnim()
    self:refreshUI()

    self.oldRarity_ = self.rarity_
end

function BaoshiComposeView:registerEvents()

    EventMgr:addEventListener(self,EQUIPMENT_GEM_COMPOSE,handler(self.onComposeBack, self))
    EventMgr:addEventListener(self,EQUIPMENT_GEM_TUZHI_SORT,handler(self.onTuzhiChooseBack, self))
    EventMgr:addEventListener(self,EV_BAG_ITEM_UPDATE,handler(self.onItemUpdate, self))

    local function onTouchBegan(touch, location)
        touch.startPos = location
        return true
    end

    local function pageUp()
        local pageIndex = self.mainPageIdx + 1
        if pageIndex > #self.mainLiveList then
            pageIndex = #self.mainLiveList
        end
        self:selectMainPage(pageIndex)
    end

    local function pageDown()
        local pageIndex = self.mainPageIdx - 1
        if pageIndex < 1 then
            pageIndex = 1
            self.page_down:setVisible(false)
        end
        self:selectMainPage(pageIndex)
    end

    local function onTouchMoved(touch, location)
        local offset = location.x - touch.startPos.x
        if math.abs(offset) > 10 then
            touch.isMoved = true
        end
    end

    local function onTouchUp(touch, location)
        local offset = location.x - touch.startPos.x
        if touch.isMoved and math.abs(offset) > 30 then
            if offset < 0 then
                self:changeRarity(true)
            else
                self:changeRarity(false)
            end
        end
    end

    self.Panel_quality_item:setTouchEnabled(true)
    self.Panel_quality_item:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)
    self.Panel_quality_item:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved)
    self.Panel_quality_item:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp)
    self.Panel_quality_item:setSwallowTouch(false)

    self.button_left:onClick(function()
        self:changeRarity(false)
    end)

    self.button_right:onClick(function()
        self:changeRarity(true)
    end)

    self.Button_compose:onClick(function()
        local composeCfg = self.tuzhiData[self.selectTuzhiIdx or 1] or self.composeCfgs[1]
        for k, v in pairs(composeCfg.currency) do

            if GoodsDataMgr:getItemCount(tonumber(k)) < v then
                if tonumber(k) == EC_SItemType.GOLD then
                    Utils:showTips(493004)
                elseif tonumber(k) == EC_SItemType.DIAMOND then
                    Utils:showTips(800048)
                else
                    local itemCfg = GoodsDataMgr:getItemCfg(k)
                    if itemCfg and itemCfg.nameTextId then
                        Utils:showTips(TextDataMgr:getText(2100034 , TextDataMgr:getText(itemCfg.nameTextId)))
                    end
                end

                
                return
            end
        end
        self.fastCompose = false
        local gemIds = {}
        for k, v in pairs(self.selectData ) do
            table.insert(gemIds, v.id)
        end
        Utils:playSound(801, false)
        EquipmentDataMgr:reqComposeGem(composeCfg.id,tostring(composeCfg.drawingId),gemIds)
    end)

    self.Button_fast_compose:onClick(function()
        local composeCfg = self.tuzhiData[self.selectTuzhiIdx or 1] or self.composeCfgs[1]
        local graph = composeCfg and composeCfg.graph or 3
        if #self.gemsData < graph then
            Utils:showTips(1100026)
            return
        end
        for k, v in pairs(composeCfg.currency) do
            if GoodsDataMgr:getItemCount(tonumber(k)) < v then
                if tonumber(k) == EC_SItemType.GOLD then
                    Utils:showTips(493004)
                elseif tonumber(k) == EC_SItemType.DIAMOND then
                    Utils:showTips(800048)
                end
                return
            end
        end
        self.fastCompose = true
        local gemIds = {}
        for i = 1, graph do
            table.insert(gemIds, self.gemsData[i].id)
        end
        Utils:playSound(801, false)
        EquipmentDataMgr:reqComposeGem(composeCfg.id,tostring(composeCfg.drawingId),gemIds)
    end)
 
    self.Button_view:onClick(function()
        local cfg = EquipmentDataMgr:getGemCfg(self.curSelectGem.cid)
        Utils:openView("fairyNew.BaoshiDetailView", {id = self.curSelectGem.id,cid = self.curSelectGem.cid,heroId = cfg.heroId,pos = cfg.skillType,fromBag = true})
    end)

    self.Button_sort:onClick(function()
        Utils:openView("fairyNew.BaoshiTuzhiSortView", {rarity = self.rarity_, heroId = self.heroId_,sortGem = false})
    end)

    self.Button_gem_sort:onClick(function()
        Utils:openView("fairyNew.BaoshiTuzhiSortView", {rarity = self.rarity_, heroId = self.heroId_, sortGem = true})
    end)
end

return BaoshiComposeView