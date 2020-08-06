require "lua.public.ScrollMenu"
local SelectHeroLayer = class("SelectHeroLayer", BaseLayer)

function SelectHeroLayer:ctor(params)
    self.super.ctor(self)
    HeroDataMgr:resetShowList(true)
    -- dump(params)
    -- Box("aaaaaaaaaaaaaa")
    self.selectCallFunc = params.callFunc
    self.showid         = params.heroId
    self.showidx        = HeroDataMgr:getShowIdxById(self.showid)

    -- 大世界正在使用的skinID
    self.useSkinID = params.skinId
    self:showPopAnim(true)
    --记录当前战斗中的角色ID 和skinID
    self:init("lua.uiconfig.osd.HeroListLayer")


 
end


function SelectHeroLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    --关闭按钮
    self.btnClose = TFDirector:getChildByPath(ui, "Button_close")
    --使用皮肤
    self.btnSave = TFDirector:getChildByPath(ui, "TextButton_save")
    self.btnSave:setGrayEnabled(true,true);
    self.btnSave:setTouchEnabled(false);
    --皮肤
    self.Panel_skin_item    = TFDirector:getChildByPath(ui, "Panel_skin_model")
    self.Panel_skin_item:setVisible(false)

    self.Panel_right    = TFDirector:getChildByPath(self.ui,"Panel_right")
    self.skinScrollView = TFDirector:getChildByPath(self.Panel_right,"ScrollView_skin");
    self.skinListView   = UITurnView:create(self.skinScrollView);
    self.skinScrollView:setVisible(true)
    self.skinListView:setItemModel(self.Panel_skin_item)



    self.Panel_left = TFDirector:getChildByPath(ui, "Panel_left")

    self.Label_hero_name        = TFDirector:getChildByPath(ui, "Label_hero_name")
    self.Label_en_hero_name     = TFDirector:getChildByPath(ui, "Label_enName2")
    self.Label_en_hero_name2    = TFDirector:getChildByPath(ui, "Label_enName")



    self.panel_list             = TFDirector:getChildByPath(self.ui,"Panel_scroll");

    self.Panel_hero_list        = TFDirector:getChildByPath(ui, "Panel_scroll")
    self.Panel_hero_item_s      = TFDirector:getChildByPath(ui, "Panel_hero_item_s")
    self.Panel_hero_item_uns    = TFDirector:getChildByPath(ui, "Panel_hero_item_uns")

    self.image_tray             = TFDirector:getChildByPath(ui, "Image_tray")
    self.image_tray:hide()
    --特效
    self.spine_tray             = TFDirector:getChildByPath(ui, "Spine_tray")
    self.Image_hero             = TFDirector:getChildByPath(ui, "Image_hero")

    self:initHeroListView()






end








function SelectHeroLayer:updateSkinItem(idx)
    local foo = self.skinItemsList_[idx]
    local skinData = TabDataMgr:getData("HeroSkin",foo.skinId)
    local item = foo.root
    item:setVisible(true)
    item:setTouchEnabled(true)
    local isUnlock = HeroDataMgr:checkSkinUnlock(foo.skinId)
    local isUsing  = tobool(self.useSkinID  == foo.skinId) --是否在战斗中
    if isUsing or not isUnlock then
        self.btnSave:setGrayEnabled(true,true);
        self.btnSave:setTouchEnabled(false);
    else
        self.btnSave:setGrayEnabled(false);
        self.btnSave:setTouchEnabled(true);
    end
    foo.Image_using:setVisible(isUsing)
    foo.imageLock:setVisible(not isUnlock)
    foo.Label_skin_name:setTextById(skinData.nameTextId)
    foo.image:setTexture(TabDataMgr:getData("HeroSkin", foo.skinId).skinImg)
    foo.Panel_Touch:onClick(function()
       if self.showSkinID ~= foo.skinId then    
            self.showSkinID = foo.skinId   
            self.skinListView:scrollToItem(idx)
            self:refreshAimation()
       end
   end)
    foo.Button_skinDetail:onClick(function()
        if self.showSkinID then
            -- self.notHide = true
            Utils:showInfo(self.showSkinID)
        end
    end)
end




function SelectHeroLayer:reLoadSkins()
    self.skinListView:removeAllItems()
    self.skinItemsList_ =  {}
    local skins = HeroDataMgr:getSkins(self.showid);
    for i,v in ipairs(skins) do
        if not self.skinItemsList_[i] then
            self:addSkinItem(i, v)
        end
        self:updateSkinItem(i)
    end 
    --初始默认选中的skin
    local selectIndex
    for index, item in ipairs(self.skinItemsList_) do
        local isUnlock = HeroDataMgr:checkSkinUnlock(item.skinId)
        if isUnlock then 
            if item.skinId == self.useSkinID then 
                selectIndex = index
                break
            end
            if not selectIndex then 
                selectIndex = index
            end  
        end
    end
    selectIndex = selectIndex or 1
    self.skinListView:jumpToItem(selectIndex)
    local item      = self.skinItemsList_[selectIndex]    
    self.showSkinID = item.skinId
    self:refreshAimation()
end



function SelectHeroLayer:addSkinItem(idx, skinId) 
    -- print("ADD SKIN iTEM")
    local item = self.skinListView:pushBackItem()
    local foo = {}
    foo.root = item
    item:setVisible(true)
    foo.image                = TFDirector:getChildByPath(foo.root,"Image_skin")
    foo.skinId               = skinId
    foo.imageLock            = TFDirector:getChildByPath(foo.root,"Image_lock")
    foo.Label_skin_name      = TFDirector:getChildByName(foo.root,"Label_skin")
    foo.Panel_Touch          = TFDirector:getChildByName(foo.root,"Panel_Touch")
    foo.Button_skinDetail    = TFDirector:getChildByName(foo.root,"Button_skinDetail") --:hide()
    foo.Image_using          = TFDirector:getChildByPath(foo.root, "Image_using")
    self.skinItemsList_[idx] = foo
    
    return foo.root
end




function SelectHeroLayer:scrollCallback(target, offsetRate, customOffsetRate)
    local items = target:getItem()
    for i, item in ipairs(items) do
        local rate = offsetRate[i]
        local rrate = 1 - rate
        local customRate = customOffsetRate[i]
        local rCustomRate = 1 - customRate
        item:setOpacity(255 * rrate)
        item:setPositionZ(-customRate * 100)
        item:setZOrder(rrate * 100)
    end
end



function SelectHeroLayer:onSelectItems(target, selectIndex)
    local foo = self.skinItemsList_[selectIndex]
    if foo then 
        if self.showSkinID ~= foo.skinId then
            self.showSkinID = foo.skinId         
            self:refreshAimation()
        end
    end
end



function SelectHeroLayer:createHeroModel(heroId, heroImg,_skinId)
    local skinId = _skinId or HeroDataMgr:getCurSkin(heroId)
    local skinInfo = TabDataMgr:getData("HeroSkin", skinId)
    local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint);
    local scale =  modelInfo.TeampaintSize or 0.25
    modelInfo.TeampaintPosition = modelInfo.TeampaintPosition or ccp(0,0)
    if heroImg and heroImg.model then
        if heroImg.heroId == heroId and heroImg.skinId == _skinId then
            heroImg.model:setPosition(modelInfo.TeampaintPosition)
            heroImg.model:setScale(scale)
            return heroImg.model
        else
            heroImg.model:removeFromParent()
            heroImg.heroId = nil
            heroImg.skinId = nil
            heroImg.model = nil
        end
    end
    local model = SkeletonAnimation:create(modelInfo.paint)
    model:setAnimationFps(GameConfig.ANIM_FPS)
    model:playByIndex(0, -1, -1, 1)
    model:setScale(scale)
    --TODO 临时解决批量渲染的导致spine动画层级错误的问题
    local tt= TFLabel:create()
    tt:setText(" ")
    model:addChild(tt)
    local particleEffect        =   modelInfo.particleEffect
    local particleEffectOffset  =   modelInfo.particleEffectOffset
    if #particleEffect > 0 then
        for index, particleRes in ipairs(particleEffect) do
            local particles_pos = particleEffectOffset[index]
            local particleNode  = TFParticle:create(particleRes)
            particleNode:resetSystem()
            particleNode:setZOrder(99)
            particleNode:setPosition(ccp(particles_pos.x,particles_pos.y))
            model:addChild(particleNode)
            local textAttrs = TFLabel:create()  --没暖用只是用来打断bate
            textAttrs:setText(" ")
            textAttrs:setFontColor(ccc3(0,255,0))
            textAttrs:setFontSize(18)
            textAttrs:setPosition(ccp(particles_pos.x,particles_pos.y))
            model:addChild(textAttrs)
        end
    end

    if heroImg then
        heroImg.model = model
        heroImg.heroId = heroId
        heroImg.skinId = skinId
        heroImg:addChild(model)
        model:setPosition(modelInfo.TeampaintPosition)
    end
    return model
end




function SelectHeroLayer:refreshAimation()
    self.anim_hero  = self:createHeroModel(self.showid, self.Image_hero,self.showSkinID)
    self:updateSkinBtnState()
end



function SelectHeroLayer:initHeroListView()
    -- HeroDataMgr:resetShowList(true)
    local showCount = HeroDataMgr:getShowCount()
    local params = {
        ["upItem"]                  = self.Panel_hero_item_uns,
        ["downItem"]                = self.Panel_hero_item_uns,
        ["selItem"]                 = self.Panel_hero_item_s,
        ["offsetX"]                 = 0,
        ["updateCellInfo"]          = handler(self.updateCellInfo,self),
        ["selCallback"]             = handler(self.selCallback,self),
        ["cellCount"]               = showCount ,
        ["isLoop"]                  = true,
        ["size"]                    = self.Panel_hero_list:getContentSize(),
        ["isFromFairy"]             = true,
        ["numberInView"]            = 4
    }
     local scrollMenu = ScrollMenu:create(params);
     scrollMenu:setPosition(self.Panel_hero_list:getPosition())
     self.Panel_hero_list:getParent():removeChild(self.Panel_hero_list:getParent():getChildByName("heroHeads"))
     self.Panel_hero_list:getParent():addChild(scrollMenu,10)
     scrollMenu:setName("heroHeads")
     self.scrollMenu = scrollMenu
     -- local jumpTo = HeroDataMgr:getSelectedHeroIdx(self.showid)
     -- Box("ASdf:"..tostring(self.showid).." "..tostring(jumpTo))
     self.scrollMenu:jumpTo(self.showidx)
end



function SelectHeroLayer:updateCellInfo(cell,cellIdx)
    local heroid = HeroDataMgr:getSelectedHeroId(cellIdx)
    if not heroid then return end

    local ishave = HeroDataMgr:getIsHave(heroid)

    local imgQuality = TFDirector:getChildByPath(cell,"Image_item_quality");
    if ishave then
        imgQuality:setTexture(HeroDataMgr:getQualityPic(heroid))
    else
        imgQuality:setTexture(HeroDataMgr:getQualityPicNotHave(heroid))
    end
    imgQuality:setVisible(true)

    local icon = TFDirector:getChildByPath(cell,"Image_icon")
    icon:setTexture(HeroDataMgr:getIconPathById(heroid))
    --icon:setContentSize(CCSizeMake( 90,90))

    local Image_duty = TFDirector:getChildByPath(cell,"Image_duty")
    local Image_duty_1 = TFDirector:getChildByPath(cell,"Image_duty_1")
  
    local job = HeroDataMgr:getHeroJob(heroid)
    if job then
        if job == 1 then
            Image_duty:setVisible(ishave)
            Image_duty_1:setVisible(false)
        elseif job < 4 then
            Image_duty:setVisible(false)
            Image_duty_1:setVisible(ishave)
        else
            Image_duty:setVisible(false)
            Image_duty_1:setVisible(false)
        end
    end
    local lock = TFDirector:getChildByPath(cell,"Image_lock")
    local Image_lock_word = TFDirector:getChildByPath(cell,"Image_lock_word")
    local Image_over_lock = TFDirector:getChildByPath(cell,"Image_over_lock")
    
    lock:setVisible(not ishave)
end

function SelectHeroLayer:selCallback(cell,cellIdx)

    local selCell = self.scrollMenu:getSelCell()

    -- print("xxxxx",cell,selCell,cellIdx)
    -- self.Panel_name_info:stopAllActions()
    -- self.Panel_right:stopAllActions()
    -- self.Image_hero:stopAllActions()
    -- self.Panel_name_info:setPosition(self.info_pos)
    -- self.Panel_right:setPosition(self.right_pos)
    -- self.Image_hero:setPosition(self.hero_pos)
    -- if self.selectCellItem then
    --    --self.selectCellItem:stopAllActions() --获得精灵时会报错，先注释掉
    -- end
    self.selectCellItem = cell
    self.selectCellItem:runAction(CCMoveBy:create(0.2, ccp(15, 0)))
    -- ViewAnimationHelper.doMoveFadeInAction(self.Image_hero, {direction = 1, distance = 30, ease = 1})
    -- ViewAnimationHelper.doMoveFadeInAction(self.Panel_name_info, {direction = 1, distance = 30, ease = 1})
    -- ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})


    local heroid = HeroDataMgr:getSelectedHeroId(cellIdx)
    -- local ishave = HeroDataMgr:getIsHave(heroid)
    self.showid  = heroid
    self.showidx = cellIdx
    self:reLoadSkins()
    self:updateHeroBaseInfo()
end


function SelectHeroLayer:updateHeroBaseInfo()
    self.Label_hero_name:setString(HeroDataMgr:getName(self.showid))
    self.Label_en_hero_name:setString(HeroDataMgr:getEnName2(self.showid))
    self.Label_en_hero_name2:setString(HeroDataMgr:getEnName(self.showid))
end







function SelectHeroLayer:panelHide(panel)
    if not panel:isVisible() then
        return
    end
    local background = panel:getChildByName("Image_back")
    local subPanel   = panel:getChildByName("Panel");
    if not background.orgpos then
        background.orgpos = background:getPosition();
    end

    panel:stopAllActions();
    background:stopAllActions();
    subPanel:stopAllActions();
    background:setPosition(background.orgpos);
    subPanel:setPosition(0,0);
    background:setOpacity(255);
    subPanel:setOpacity(255);


    local actions1 = {
        CCMoveBy:create(0.2,ccp(0,-30));
        CCFadeOut:create(0.2);
    }

    background:runAction(Spawn:create(actions1));

    local actions2 = {
        CCMoveBy:create(0.2,ccp(30,0));
        CCFadeOut:create(0.2);
    }

    subPanel:runAction(Spawn:create(actions2));

    local delay = CCDelayTime:create(0.25);
    local callfunc = CCCallFunc:create(function()
            background:setPositionY(background:getPositionY() + 30);
            subPanel:setPositionX(subPanel:getPositionX() - 30);
            panel:setVisible(false);
            background:setOpacity(255);
            subPanel:setOpacity(255);
        end)

    local actions3 = {
        delay,
        callfunc
    }
    panel:runAction(CCSequence:create(actions3));
end

function SelectHeroLayer:panelShow(panel)
    local background = panel:getChildByName("Image_back")
    local subPanel   = panel:getChildByName("Panel");

    if not background.orgpos then
        background.orgpos = background:getPosition();
    end

    panel:stopAllActions();
    background:stopAllActions();
    subPanel:stopAllActions();
    background:setPosition(background.orgpos);
    subPanel:setPosition(0,0);
    background:setOpacity(255);
    subPanel:setOpacity(255);

    background:setPositionY(background:getPositionY() + 30)
    subPanel:setPositionX(subPanel:getPositionX() + 30)
    background:setOpacity(0)
    subPanel:setOpacity(0)
    panel:setVisible(true);

    local actions1 = {
        CCMoveBy:create(0.2,ccp(0,-30));
        CCFadeIn:create(0.2);
    }

    background:runAction(Spawn:create(actions1));

    local actions2 = {
        CCMoveBy:create(0.2,ccp(-30,0));
        CCFadeIn:create(0.2);
    }

    subPanel:runAction(Spawn:create(actions2));
end







function SelectHeroLayer:registerEvents()
    
    self.skinListView:registerScrollCallback(handler(self.scrollCallback,self))
    self.skinListView:registerSelectCallback(handler(self.onSelectItems, self))

    self.btnClose:onClick(function()
         AlertManager:close()
        end)
    --发送给服务器
    self.btnSave:onClick(function()
            if self.selectCallFunc then
                self.selectCallFunc(self.showid,self.showSkinID)
            end
            AlertManager:close()
        end)

    
end


function SelectHeroLayer:updateSkinBtnState()
    local curskinID     = self.useSkinID
    if self.showSkinID then
        local skinID        = self.showSkinID
        local isUnlock      = HeroDataMgr:checkSkinUnlock(skinID)
        if curskinID == skinID or not isUnlock then
            self.btnSave:setGrayEnabled(true,true);
            self.btnSave:setTouchEnabled(false);
        else
            self.btnSave:setGrayEnabled(false);
            self.btnSave:setTouchEnabled(true);
        end
    else
        self.btnSave:setGrayEnabled(true,true);
        self.btnSave:setTouchEnabled(false);
    end
end



function SelectHeroLayer:onHide()
    self.super.onHide(self)
end

function SelectHeroLayer:removeUI()
    self.super.removeUI(self)
    -- --测试移除 lua
    -- local TFUILoadManager       = require('TFFramework.client.manager.TFUILoadManager')
    -- TFUILoadManager:unLoadModule("lua.logic.osd.SelectHeroLayer")
end



function SelectHeroLayer:onShow()
    self.super.onShow(self)
end

return SelectHeroLayer;
