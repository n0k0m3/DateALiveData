
local Utils = Utils or {}

-- scrollView -> TableView
function Utils:scrollView2TableView(scrollView)
    local tableView = TFTableView:create()
    tableView
        :Pos(scrollView:Pos())
        :AnchorPoint(scrollView:AnchorPoint())
        :ScaleX(scrollView:ScaleX())
        :ScaleY(scrollView:ScaleY())
        :AddTo(scrollView:getParent())
    tableView:setTableViewSize(scrollView:Size())
    tableView:setDirection(scrollView:getDirection())
    tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
    tableView:setBounceable(scrollView:isBounceEnabled())
    scrollView:RemoveSelf()
    return tableView
end

function Utils:showNoticeNode( parent, content )
        local layer =  parent:getChildByName("NoticeLayer")
        if not layer then
            layer = require("lua.logic.common.NoticeMarQueeLayer"):new()
            layer:setName("NoticeLayer")
            parent:addChild(layer)
            local anchor = parent:getAnchorPoint()
            layer:setPosition(ccp((0-anchor.x)*parent:getSize().width,(0-anchor.y)*parent:getSize().height))
            layer:setZOrder(999)
        end
        layer:addContent(content)
        return layer
end

-- pram = {
--     parent -- 父节点
--     type -- 弹幕类型  
--     autoRun -- 自动播放 
--     rowNum -- 显示行数
-- -- }

function Utils:createDanmuFrame( pram )
    return require("lua.public.DanmuFrame"):new(pram)
end

 -- pram = {
--     id -- 弹幕类型  
--     autoRun -- 自动播放
--     offset  -- 距上边距偏移
--     danmuHeight -- 弹幕显示范围
--     autoRun -- 自动播放 
--     rowNum -- 显示行数
-- -- }

function Utils:getDanmuId(type, detail)
    -- body
    local data = TabDataMgr:getData("Barrage")
    for k, v in pairs(data) do
        if v.barrageType == type and v.path == tostring(detail) then
            return v.id
        end
    end
    return nil
end

function Utils:createDanmuMark( pram )
    return require("lua.logic.common.DanmuMark"):new(pram)
end

function Utils:getKVP(id, key, default)
    local config = TabDataMgr:getData("DiscreteData", id)
    local data = config["data"]
    if key then
        return data[key] or default
    else
        return data
    end
end

function Utils:showTips(idOrText, ...)
    local id, text
    if type(idOrText) == "number" then
        id = idOrText
    else
        text = idOrText
    end

    if id then
        text = TextDataMgr:getText(id, ...)
    else
        text = string.format(text, ...)
    end

    toastMessage(text)
end

function Utils:showError(idOrText, ...)
    local id, text
    if type(idOrText) == "number" then
        id = idOrText
    else
        text = idOrText
    end

    if id then
        text = TextDataMgr:getText(id, ...)
    end

    toastMessage(text)
    --printError(text)
end


function Utils:blinkRepeatAni(node, duration)
    duration = duration or 1.0

    local seq = Sequence:create({
            FadeOut:create(duration),
            FadeIn:create(duration),
    })
    local action = RepeatForever:create(seq)

    node:runAction(action)
end

function Utils:showInfo(cid, id, isShowAccess)
    isShowAccess = tobool(isShowAccess)
    local itemCfg = GoodsDataMgr:getItemCfg(cid)

    
    -- 道具
    if itemCfg.superType == EC_ResourceType.SPIRIT then

        local _id = cid;

        if id  then
            _id = id;
        end

        local isFromPokedex = false;
        local topLayer = TFDirector:currentScene():getTopLayer()
        local topname = topLayer and topLayer.__cname or ""
        --图鉴界面等级显示最高
        isFromPokedex = (topname == "CollectEquipView" or topname == "CollectBaseView")

        Utils:openView("Equipment.EquipmentInfo", {equipmentId = _id,fromBag = true,isFromPokedex = isFromPokedex})
        -- local equipmentInfoView = requireNew("lua.logic.Equipment.EquipmentInfo"):new({equipmentId = _id,fromBag = true})
        -- AlertManager:addLayer(equipmentInfoView)
        -- AlertManager:show()
    elseif itemCfg.superType == EC_ResourceType.BAOSHI then
        Utils:openView("fairyNew.BaoshiDetailView", {id = id or 0,cid = cid,heroId = itemCfg.heroId,pos = itemCfg.skillType,fromBag = true})
    elseif itemCfg.desTextId and itemCfg.desTextId ~= 0 then
        local itemInfoView = requireNew("lua.logic.bag.ItemInfoView"):new(cid, id, isShowAccess)
        AlertManager:addLayer(itemInfoView, AlertManager.BLOCK_AND_GRAY_CLOSE)
        AlertManager:show()
    end
end

function Utils:showReConfirm(data)
    local confirmCall = data.confirmCall
    local reType = data.reType
    if confirmCall then
        if reType and MainPlayer:getOneLoginStatus(reType) then
            confirmCall()
        else
            Utils:openView("common.ReConfirmTipsView", data)
        end
    end
end

function Utils:showAccess(itemCid)
    if itemCid == EC_SItemType.DIAMOND or itemCid == EC_SItemType.TokenMoney then
        self:openView("common.RechargeJumpView",itemCid)
    else
        self:openView("bag.ItemAccessView", itemCid)
    end
end

function Utils:showReward(rewardList,staticRewardList,hideCallBack)
    if not next(rewardList) and not next(staticRewardList) then
        return
    end

    local cardList = {}
    local isSkyCardCnt = 0
    for k,v in ipairs(rewardList) do
        local itemCfg = GoodsDataMgr:getItemCfg(v.id)
        if itemCfg == nil then
            Bugly:ReportLuaException("Utils:showReward: ========================= " .. tostring(v.id))
        else
            if itemCfg.superType == EC_ResourceType.SKYLADDER then
                if itemCfg.subType == 1 then
                    isSkyCardCnt = isSkyCardCnt + 1
                    table.insert(cardList,{id = v.id,num = v.num})
                else
                    local cardId = SkyLadderDataMgr:getCovertOrigalId(v.id)
                    if cardId then
                        isSkyCardCnt = isSkyCardCnt + 1
                        table.insert(cardList,{id = cardId,num = v.num})
                    end
                end
            end
            if itemCfg.isHide then
                table.remove(rewardList,k)
            end
        end
    end

    if table.count(rewardList) == 0 then return end

    local isSkyLadderCardBag = isSkyCardCnt > 0

    if not isSkyLadderCardBag then
        local view = requireNew("lua.logic.bag.GetItemView"):new(rewardList,staticRewardList,hideCallBack)
        AlertManager:addLayer(view)--,AlertManager.BLOCK_AND_GRAY_CLOSE)
        AlertManager:show()
    else
        self:openView("skyLadder.SkyLadderCardPackageView",cardList)
    end
end

function Utils:previewReward(view, reward, scale)
    local view = requireNew("lua.logic.common.PreviewRewardView"):new(reward)
    AlertManager:addLayer(view,AlertManager.BLOCK_AND_GRAY_CLOSE)
    AlertManager:show()
    return view
end

function Utils:mergeReward(reward)
    local notMergeType = {
        EC_ResourceType.HERO,
        EC_ResourceType.EQUIPMENT,
    }
    local rewardMap = {}
    local rewardList = {}
    for i, v in ipairs(reward) do
        local goodsCfg = GoodsDataMgr:getItemCfg(v.id)
        if table.indexOf(notMergeType, goodsCfg.superType) == -1 then
            local rawNum = rewardMap[v.id] or 0
            rewardMap[v.id] = rawNum + v.num
        else
            table.insert(rewardList, v)
        end
    end
    for k, v in pairs(rewardMap) do
        local item = self:makeRewardItem(k, v)
        table.insert(rewardList, item)
    end
    table.sort(rewardList, function(a, b)
                   local cfgA = GoodsDataMgr:getItemCfg(a.id)
                   local cfgB = GoodsDataMgr:getItemCfg(b.id)
                   if cfgA.quality == cfgB.quality then
                       return a.id < b.id
                   end
                   return cfgA.quality > cfgB.quality
    end)
    return rewardList
end

function Utils:makeRewardItem(itemId, itemNum)
    return {
        id = itemId,
        num = itemNum,
    }
end

function Utils:notOpenTips()
    local str = TextDataMgr:getText(800002)
    toastMessage(str)
end

function Utils:isStringContainSpecialChars(str, specialChars)
    local defaultSpecialChars = "[%`%~%!%@%#%$%%%^%&]"
    if specialChars then
        local chars = "["
        local len = string.len(specialChars)
        for i = 1, len do
            chars = chars .. "%" .. string.sub(specialChars, i, i)
        end
        chars = chars .. "]"
        specialChars = chars
    else
        specialChars = defaultSpecialChars
    end
    return string.find(str, specialChars)
end

-- 准确时间格式化
function Utils:getDHMS(sec, formating)
    local date = TFDate(sec)
    local day = date:getyearday()
    local hour = date:gethours()
    local min = date:getminutes()
    local sec = date:getseconds()
    if formating then
        day = string.format("%.2d", day)
        hour = string.format("%.2d", hour)
        min = string.format("%.2d", min)
        sec = string.format("%.2d", sec)
    end
    return day, hour, min, sec
end

function Utils:getTimeDHMZ( time ,formating)
    local day = 0
    local hour = 0
    local min = 0
    local sec = 0
    if time > 0 then
        day = math.floor(time/(24*3600))
        time = time%(24*3600)
        hour = math.floor(time/3600)
        time = time%3600
        min = math.floor(time/60)
        time = time%60
        sec = time
    end
    if formating then
        day = string.format("%.2d", day)
        hour = string.format("%.2d", hour)
        min = string.format("%.2d", min)
        sec = string.format("%.2d", sec)
    end
    return day,hour,min,sec
end

function Utils:getTime(timestamp, formating)
    local date = TFDate(timestamp):tolocal()
    local hour, min, sec = date:gettime()
    if formating then
        hour = string.format("%.2d", hour)
        min = string.format("%.2d", min)
        sec = string.format("%.2d", sec)
    end
    return hour, min, sec
end

function Utils:getDate(timestamp, formating)
    local date = TFDate(timestamp):tolocal()
    local year, month, day = date:getdate()
    if formating then
        month = string.format("%.2d", month)
        day = string.format("%.2d", day)
    end
    return year, month, day
end

-- 模糊时间格式化（秒数不为0则分钟向上取整）
-- 适合倒计时显示到分的情况
function Utils:getFuzzyTime(intervals, formating)
    local date = TFDate(intervals)
    local hour, min, sec = date:gettime()
    if sec > 0 then
        sec = 0
        min = min + 1
        hour = hour + math.floor(min / 60)
        min = math.mod(min, 60)
        hour = math.mod(hour, 24)
    end
    if formating then
        hour = string.format("%.2d", hour)
        min = string.format("%.2d", min)
        sec = string.format("%.2d", sec)
    end
    return hour, min, sec
end


-- 模糊时间格式化（秒数不为0则分钟向上取整）
-- 适合倒计时显示到分的情况
function Utils:getFuzzyDHMS(sec, formating)
    local day, hour, min, sec = self:getDHMS(sec)
    if sec > 0 then
        sec = 0
        min = min + 1
        hour = hour + math.floor(min / 60)
        min = math.mod(min, 60)
        day = day + math.floor(hour / 24) - 1
        hour = math.mod(hour, 24)
    else
        day = day - 1
    end
    if formating then
        day = string.format("%.2d", day)
        hour = string.format("%.2d", hour)
        min = string.format("%.2d", min)
        sec = string.format("%.2d", sec)
    end
    return day, hour, min, sec
end

function Utils:string2time(timeString)
    if type(timeString) ~= 'string' then error('string2time: timeString is not a string') return 0 end
    local fun = string.gmatch( timeString, "%d+")
    local y = fun() or 0
    if y == 0 then error('timeString is a invalid time string') return 0 end
    local m = fun() or 0
    if m == 0 then error('timeString is a invalid time string') return 0 end
    local d = fun() or 0
    if d == 0 then error('timeString is a invalid time string') return 0 end
    local H = fun() or 0
    if H == 0 then error('timeString is a invalid time string') return 0 end
    local M = fun() or 0
    if M == 0 then error('timeString is a invalid time string') return 0 end
    local S = fun() or 0
    if S == 0 then error('timeString is a invalid time string') return 0 end
    return os.time({year=y, month=m, day=d, hour=H,min=M,sec=S})
end

-- 布局为相对位置(即ME_LAYOUT_RELATIVE)时可用
function Utils:adaptSize(node, isFixWidth, isFixHeight)
    local layoutType = node:getLayoutType()
    if layoutType ~= 3 then return end

    local rawSize = node:Size()
    local width = isFixWidth and rawSize.width or 0
    local height = isFixHeight and rawSize.height or 0
    node:Size(CCSize(width, height))

    local rect = node:boundingBox()
    local oldSize = node:Size()
    local size = clone(rect.size)
    if isFixWidth then
        size.width = oldSize.width
    end
    if isFixHeight then
        size.height = oldSize.height
    end
    node:Size(size)
end

function Utils:setNodeGray(node, enabled)
    local color
    if enabled then
        color = ccc3(0x80, 0x80, 0x80)
    else
        color = ccc3(0xff, 0xff, 0xff)
    end
    self:setNodeColor(node,color)
end

function Utils:setNodeColor(node,color)
    local childrenArr = node:getChildren()
    for i, v in ipairs(childrenArr) do
        v:setColor(color)
        self:setNodeColor(v, color)
    end
end

function Utils:setNodeWhite(node)
    local color = ccc3(255,255,255)
    Utils:setNodeColor(node,color);
end
--不需要缓存的UI列表
local not_cache_views = {
    "ReConfirmTipsView",
}
function Utils:openView(moduleName, ...)
    local fullModuleName = string.format("lua.logic.%s", moduleName)
    local view = requireNew(fullModuleName):new(...)
    local currentScene = Public:currentScene();
    if currentScene.__cname == "LoginScene" then
        view:setAnchorPoint(me.p(0.5,0.5))
        currentScene:addCustomLayer(view)
    else
        AlertManager:addLayer(view)
        AlertManager:show()
        if table.indexOf(not_cache_views,view.__cname) == -1 then  --排除不需要缓存的ui
            AlertManager:addMainSceneLayerParamsCache(view.__cname, moduleName, ...)
        end
    end
    return view
end

function Utils:setAliginCenterByListView(listView, isHorizontal)
    local originContentSize = listView:getContentSize()
    local size = CCSize(originContentSize.width, originContentSize.height)
    if isHorizontal then
        size.width = 1
    else
        size.height = 1
    end
    listView:setContentSize(size)
    local innerContentSize = listView:getInnerContainerSize()
    if isHorizontal then
        size.width = innerContentSize.width
    else
        size.height = innerContentSize.height
    end
    listView:setContentSize(size)
end

function Utils:format_number(count)
    local pow_6 = math.pow(10, 5)
    local pow_8 = math.pow(10, 7)
    local rets = tostring(count)
    if count < pow_8 and count >= pow_6 then
        local foo = math.floor(count / math.pow(10, 3))
        rets = tostring(foo) .. "k"
    elseif count >= pow_8 then
        local foo = math.floor(count / math.pow(10, 6))
        rets = tostring(foo) .. "m"
    end
    return rets
end

function Utils:format_number_w(count, boundaryNumber)
    boundaryNumber = boundaryNumber or math.pow(10, 5)
    local rets = tostring(count)
    if count > boundaryNumber then
        local foo = math.floor(count / 10000)
        rets = tostring(foo) .. "w"
    end
    return rets
end

function Utils:loadingBarChangeActionInTime(bar,percent,allTime, perCallback, completeCallback, updateCallBack)
    perCallback = perCallback or function() end
    completeCallback = completeCallback or function() end
    updateCallBack = updateCallBack or function() end
    percent = percent or 0

    --local img = bar:getChildByName("img")
    --if img then
    --    img:removeFromParent();
    --    img = nil;
    --end

    if bar.timer then
        TFDirector:stopTimer(bar.timer)
        TFDirector:removeTimer(bar.timer)
        bar.timer = nil;
    end

    --local size  = bar:getSize();
    --img     = TFImage:create()
    --img:setTexture("ui/290.png");
    --img:setSize(CCSizeMake(size.width * percent / 100,size.height))
    --img:setName("img");
    --img:setScale9Enabled(true)
    --img:setAnchorPoint(bar:getAnchorPoint());
    -- local zorder = bar:getZOrder();
    -- bar:setZOrder(zorder + 1)
    --local pos = bar:getPosition()
    --bar:getParent():addChild(img,zorder + 1);
    --img:setRotation(bar:getRotation())
    --bar:setZOrder(zorder + 2)
    --img:setPosition(pos.x - size.width / 2 * (1 - percent / 100),pos.y)

    local per = bar:getPercent();
    local offsetPercent = percent - per 
    local timer_ = nil
    local scaleTime = 1/allTime
    local function addfunction(dt)
        if tolua.isnull(bar) then --bugFIX
            if timer_ then
                TFDirector:removeTimer(timer_)
            end
            return
        end
        local _Pt = dt*offsetPercent*scaleTime
        per = per + _Pt
        bar:setPercent(per)
        updateCallBack()

        if math.abs(per - percent) <= math.abs(_Pt) then
            local beginPercent, endPercent = perCallback()
            --img:setVisible(false)
            if beginPercent and endPercent then
                bar:setPercent(beginPercent)
                per = beginPercent
                percent = endPercent
            else
                -- bar:setZOrder(zorder);
                --img:removeFromParent();
                if timer_ then
                    TFDirector:removeTimer(timer_)
                end
                completeCallback()
                bar:setPercent(percent)
                return
            end
        end
     end
    timer_ = TFDirector:addTimer(0, -1, nil, addfunction)
    bar.time = time_
    bar:addMEListener(TFWIDGET_EXIT,function()
        if timer_ then
            TFDirector:removeTimer(timer_)
        end
    end)
end

function Utils:loadingBarAddAction(bar,percent, perCallback, completeCallback, updateCallBack)
    perCallback = perCallback or function() end
    completeCallback = completeCallback or function() end
    updateCallBack = updateCallBack or function() end
    percent = percent or 0

    --local img = bar:getChildByName("img")
    --if img then
    --    img:removeFromParent();
    --    img = nil;
    --end

    if bar.timer then
        TFDirector:removeTimer(bar.timer)
        bar.timer = nil;
    end

    --local size  = bar:getSize();
    --img     = TFImage:create()
    --img:setTexture("ui/290.png");
    --img:setSize(CCSizeMake(size.width * percent / 100,size.height))
    --img:setName("img");
    --img:setScale9Enabled(true)
    --img:setAnchorPoint(bar:getAnchorPoint());
    local zorder = bar:getZOrder();
    bar:setZOrder(zorder + 1)
    --local pos = bar:getPosition()
    --bar:getParent():addChild(img,zorder + 1);
    --img:setRotation(bar:getRotation())
    --bar:setZOrder(zorder + 2)
    --img:setPosition(pos.x - size.width / 2 * (1 - percent / 100),pos.y)

    local per = bar:getPercent();
    if per > percent then
        bar:setPercent(0);
        per = 0;
    end

    local timer_ = nil
    local speed = 1.5
    local function addfunction(dt)
        if tolua.isnull(bar) then --bugFIX
            if timer_ then
                TFDirector:removeTimer(timer_)
            end
            return
        end

        per = per + speed
        if per >= percent then
            local beginPercent, endPercent = perCallback()
            --img:setVisible(false)
            if beginPercent and endPercent then
                bar:setPercent(beginPercent)
                per = beginPercent
                percent = endPercent
            else
                bar:setZOrder(zorder);
                --img:removeFromParent();
                if timer_ then
                    TFDirector:removeTimer(timer_)
                end
                completeCallback()
            end

        end
        bar:setPercent(per)
        updateCallBack()
     end
    timer_ = TFDirector:addTimer(0, -1, nil, addfunction)
    bar.timer = timer_
    bar:addMEListener(TFWIDGET_EXIT,function()
        if timer_ then
            TFDirector:removeTimer(timer_)
        end
    end)
end

function Utils:getTimeData(timeVal)
    local timeData = {};
    local val = timeVal or os.time();
    timeData.Year = tonumber(os.date("%Y", val));
    timeData.Month = tonumber(os.date("%m", val));
    timeData.Day = tonumber(os.date("%d", val));
    timeData.Hour = tonumber(os.date("%H", val));
    timeData.Minute = tonumber(os.date("%M", val));
    timeData.Second = tonumber(os.date("%S", val));
    timeData.WeekDay = tonumber(os.date("%w", val));
    if(timeData.WeekDay == 0) then
        timeData.WeekDay = 7;
    end
    return timeData;
end

function Utils:getTimeDiff(timeVal)
    local diff = os.time() - timeVal;
    local day = diff / 86400;
    local hour= diff % 86400 / 3600;
    local min = diff % 86400 % 3600 / 60;
    local seconds = diff % 86400 % 3600 % 60 / 1;
    return day,hour,min,seconds;
end

function Utils:howManyTimeAgo(timeVal)
    local day,hour,min,seconds = self:getTimeDiff(timeVal);
    if day >= 1 then
        return TextDataMgr:getText(600008, day)
    elseif hour >= 1 then
        return TextDataMgr:getText(600007, hour)
    elseif min >= 1 then
        return TextDataMgr:getText(600006, min)
    else
        return TextDataMgr:getText(600005, seconds)
    end
end

function Utils:createHeroModelByModelId(modelCid, scale)
    local modelInfo = TabDataMgr:getData("HeroModle", modelCid)
    scale = scale or modelInfo.paintSize
    local offsetScale = 1 - scale
    local scaleOffsetPosition = me.pMult(modelInfo.paintPosition, -offsetScale)
    local offsetPosition = me.pAdd(modelInfo.paintPosition, scaleOffsetPosition)
    local model = SkeletonAnimation:create(modelInfo.paint)
    model:setAnimationFps(GameConfig.ANIM_FPS)
    model:playByIndex(0, -1, -1, 1)
    model:setScale(scale)
    model:setPosition(offsetPosition)
    return model
end

function Utils:createHeroModel(heroId, heroImg, scale,_skinId,notShowParticle)
    local skinId = _skinId or HeroDataMgr:getCurSkin(heroId)
    local skinInfo = TabDataMgr:getData("HeroSkin", skinId)
    local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint);
    scale = scale or modelInfo.paintSize
    if heroImg and heroImg.model then
        if heroImg.heroId == heroId and heroImg.skinId == _skinId then
            local offsetScale = 1 - scale
            local scaleOffsetPosition = me.pMult(modelInfo.paintPosition, -offsetScale)
            local offsetPosition = me.pAdd(modelInfo.paintPosition, scaleOffsetPosition)
            heroImg.model:setPosition(offsetPosition)
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
    --TODO 临时解决批量渲染的导致spine动画层级错误的问题
    local tt= TFLabel:create()
    tt:setText(" ")
    model:addChild(tt)

    model:setScale(scale)
    if not notShowParticle then
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
                local textAttrs = TFLabel:create()
                textAttrs:setText(" ")
                textAttrs:setFontColor(ccc3(0,255,0))
                textAttrs:setFontSize(18)
                textAttrs:setPosition(ccp(particles_pos.x,particles_pos.y))
                model:addChild(textAttrs)
            end
        end
    end

    if heroImg then
        heroImg.model = model
        heroImg.heroId = heroId
        heroImg.skinId = skinId
        heroImg:addChild(model)
        local offsetScale = 1 - scale
        local scaleOffsetPosition = me.pMult(modelInfo.paintPosition, -offsetScale)
        local offsetPosition = me.pAdd(modelInfo.paintPosition, scaleOffsetPosition)
        model:setPosition(offsetPosition)
    end

    if heroImg then
        heroImg:addMEListener(TFWIDGET_CLEANUP, function (...)
            --print("name " ..heroImg:getName())
            if heroImg.model then
                heroImg.model:removeFromParent()
            end      
            heroImg.model = nil    
        end)
    end

    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()
    return model
end

function Utils:createTeamHeroModel(heroId, heroImg,_skinId,isHuntingModelPos)
    local skinId = _skinId or HeroDataMgr:getCurSkin(heroId)
    local skinInfo = TabDataMgr:getData("HeroSkin", skinId)
    local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint);
    local scale =  modelInfo.teamModelScale
    local modelPos = modelInfo.teamModelPos
    if isHuntingModelPos then 
        modelPos = modelInfo.huntingModelPos
    end
    if heroImg and heroImg.model then
        if heroImg.heroId == heroId and heroImg.skinId == _skinId then
            heroImg.model:setPosition(modelPos)
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
        model:setPosition(modelPos)
    end

    if heroImg then
        heroImg:addMEListener(TFWIDGET_CLEANUP, function (...)
            if heroImg.model then
                heroImg.model:removeFromParent()
            end          
        end)
    end
    
    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()
    return model
end

function Utils:getUTCDate(timestamp , timeZone)
    local timeStep = timestamp
    if timeZone then
        timeStep = timeStep + timeZone * 3600
    end
    local date = TFDate(timeStep)
    return date
end

function Utils:getLocalDate(timestamp)
    local date = TFDate(timestamp)
    return date:tolocal()
end

function Utils:getChineseNumber(number)
    if GAME_LANGUAGE_VAR ~= "" then
        return number
    end
    local retTab = {}
    if number < 10000 then
        local bits = #tostring(number)
        local tempNumber = number
        local preNum
        for i = bits - 1, 0, -1 do
            local scale = math.pow(10, i)
            local num = math.floor(tempNumber / scale)
            tempNumber = math.fmod(tempNumber, scale)
            if not preNum or num ~= 0 or preNum ~= 0 then
                table.insert(retTab, num)
                if num ~=0 and scale ~= 1 then
                    table.insert(retTab, scale)
                end
                if tempNumber == 0 then
                    break
                end
                preNum = num
            end
        end
    end
    if retTab[1] == 1 and retTab[2] == 10 then
        table.remove(retTab, 1)
    end
    local rets = ""
    for i, v in ipairs(retTab) do
        local str = TextDataMgr:getText(EC_ChineseNumber[v])
        rets = rets .. str
    end
    return rets
end

function Utils:openActivityPage(actType)
    Utils:openView("activity.ActivityMain",actType);
end


local function exportstring(s)
  return string.format("%q", s)
end

   --// The Save Function
function Utils:saveTable( tbl)
  local charS,charE = "   ","\n"
  local result = ""

  -- initiate variables for save procedure
  local tables,lookup = { tbl },{ [tbl] = 1 }
  result = "return {"..charE

  for idx,t in ipairs(tables) do
     result = result .. "-- Table: {"..idx.."}"..charE
     result = result .. "{"..charE
     local thandled = {}

     for i,v in ipairs(t) do
        thandled[i] = true
        local stype = type(v)
        -- only handle value
        if stype == "table" then
           if not lookup[v] then
              table.insert(tables, v)
              lookup[v] = #tables
           end
           result = result .. charS.."{"..lookup[v].."},"..charE
        elseif stype == "string" then
           result = result ..  charS..exportstring(v)..","..charE
        elseif stype == "number" then
           result = result ..  charS..tostring(v)..","..charE
        end
     end

     for i,v in pairs(t) do
        -- escape handled values
        if (not thandled[i]) then

           local str = ""
           local stype = type(i)
           -- handle index
           if stype == "table" then
              if not lookup[i] then
                 table.insert(tables,i)
                 lookup[i] = #tables
              end
              str = charS.."[{"..lookup[i].."}]="
           elseif stype == "string" then
              str = charS.."["..exportstring(i).."]="
           elseif stype == "number" then
              str = charS.."["..tostring(i).."]="
           end

           if str ~= "" then
              stype = type(v)
              -- handle value
              if stype == "table" then
                 if not lookup[v] then
                    table.insert(tables,v)
                    lookup[v] = #tables
                 end
                 result = result .. str.."{"..lookup[v].."},"..charE
              elseif stype == "string" then
                 result = result .. str..exportstring(v)..","..charE
              elseif stype == "number" then
                 result = result .. str..tostring(v)..","..charE
              end
           end
        end
     end
     result = result .. "},"..charE
  end
  result = result .. "}"

  return result
end

--// The Load Function
function Utils:loadTable(sTable)
  local ftables,err = load(sTable)
  if err then return _,err end
  local tables = ftables()
  for idx = 1,#tables do
     local tolinki = {}
     for i,v in pairs(tables[idx]) do
        if type(v) == "table" then
           tables[idx][i] = tables[v[1]]
        end
        if type(i) == "table" and tables[i[1]] then
           table.insert(tolinki,{ i,tables[i[1]] })
        end
     end
     -- link indices
     for _,v in ipairs(tolinki) do
        tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
     end
  end
  return tables[1]
end

function Utils:writeTable(tbl, fileName)
    local file = io.open(fileName, "w")
    file:write(self:saveTable(tbl))
    io.close(file)
end

function Utils:readTable(fileName)
    local file = io.open(fileName, "r")
    local str = file:read("*a")
    io.close(file)

    return self:loadTable(str)
end

function Utils:randomProbability(probability)
    local rMin = 1
    local rMax = 0
    table.walk(probability, function(v, k)
                   rMax = rMax + v
    end)

    local r = math.random(rMin, rMax)
    for i, v in ipairs(probability) do
        if r <= v then
            return i
        end
        r = r - v
    end
end

function Utils:makeTimeCountdown(tarNode,timelong)
    local oldCountdownLabel = tarNode:getChildByTag(9898)
    local timeCountDownLabel
    if oldCountdownLabel then
        if oldCountdownLabel.countdownTimer then
            TFDirector:removeTimer(oldCountdownLabel.countdownTimer)
            oldCountdownLabel.countdownTimer = nil
        end
        oldCountdownLabel:removeFromParent()
    end
    tarNode:setGrayEnabled(true)
    tarNode:setTouchEnabled(false)
    timeCountDownLabel = TFLabel:create()
    timeCountDownLabel.timelong = timelong
    timeCountDownLabel.tarNode = tarNode
    timeCountDownLabel:setText(string.format("%ds",timelong))
    timeCountDownLabel:setFontSize(36)
    local targetSize = tarNode:getContentSize()
    local targetAnch = tarNode:getAnchorPoint()
    timeCountDownLabel:setPosition(ccp(targetSize.width*(0.5 - targetAnch.x),targetSize.height*(0.5- targetAnch.y)))
    timeCountDownLabel:setAnchorPoint(me.p(0.5,0.5))
    timeCountDownLabel:setFontColor(ccc3(255,255,255))
    timeCountDownLabel:enableStroke(ccc3(233,43,99),1)
    tarNode:addChild(timeCountDownLabel,999,9898)
    timeCountDownLabel:addMEListener(TFWIDGET_CLEANUP,function()
            TFDirector:removeTimer(timeCountDownLabel.countdownTimer)
            timeCountDownLabel.tarNode:setGrayEnabled(false)
            timeCountDownLabel.tarNode:setTouchEnabled(true)
        end)

    timeCountDownLabel.countdownTimer = TFDirector:addTimer(1000,timeCountDownLabel.timelong,nil,function()
        if timeCountDownLabel and timeCountDownLabel.timelong then
            timeCountDownLabel.timelong = timeCountDownLabel.timelong - 1
            timeCountDownLabel:setText(string.format("%ds",timeCountDownLabel.timelong))
            if timeCountDownLabel.timelong <= 0 then
                timeCountDownLabel:removeFromParent()
            end
        end
    end)
end

--isTouch 冷却结束后是否需要开启触摸事件，默认开启
function Utils:makeCDProgressBar(tarNode,timelong,img,isTouch)
    local oldCDProgressBar = tarNode:getChildByTag(9798)
    if oldCDProgressBar then
        oldCDProgressBar:removeFromParent()
    end
    tarNode:setTouchEnabled(false)
    local CDProgressBar = TFLoadingBar:create(img)
    CDProgressBar:setColor(ccc4(51,51,51,255))
    -- CDProgressBar:setGrayEnabled(true)
    CDProgressBar:setOpacity(180)
    CDProgressBar:setDirection(TFLOADINGBAR_BOTTOM)
    CDProgressBar:setPercent(100)
    CDProgressBar.timelong = timelong
    CDProgressBar.timeRemain = timelong
    CDProgressBar.isTouch = isTouch
    CDProgressBar.tarNode = tarNode
    tarNode:addChild(CDProgressBar,999,9798)
    CDProgressBar:addMEListener(TFWIDGET_CLEANUP,function()
            TFDirector:removeTimer(CDProgressBar.countdownTimer)
            if CDProgressBar.isTouch == false then

            else
                CDProgressBar.tarNode:setTouchEnabled(true)
            end
        end)

    CDProgressBar.countdownTimer = TFDirector:addTimer(100,CDProgressBar.timelong*10,function()
        CDProgressBar:removeFromParent()
    end,function()
        if CDProgressBar and CDProgressBar.timeRemain then
            CDProgressBar.timeRemain = CDProgressBar.timeRemain - 0.1
            CDProgressBar:setPercent(math.floor(CDProgressBar.timeRemain/CDProgressBar.timelong*100))
        end
    end)
end

function Utils:progressToEx(bar, duration, endValue, callback)
    local shadowBar = bar.shadowBar
    if not shadowBar then
        shadowBar = bar:clone()
        shadowBar:setTexture("ui/common/progress_05.png")
        local position = bar:getPosition()
        position.y = position.y
        shadowBar:setPosition(position)
        local originSize = bar:getSize()
        local size = CCSizeMake(originSize.width + 10, 26)
        shadowBar:setSize(size)
        shadowBar:setZOrder(0)
        bar:getParent():addChild(shadowBar)
        bar.shadowBar = shadowBar
    end
    bar.callback = callback
    shadowBar:setPercent(bar:getPercent())
    shadowBar:setVisible(true)
    shadowBar:setOpacity(0)
    shadowBar:runAction(FadeIn:create(duration + 0.3))
    self:progressTo(
        shadowBar, duration, endValue,
        function()
            shadowBar:runAction(FadeOut:create(duration + 0.3))
            self:progressTo(
                bar, duration, endValue,
                function()
                    shadowBar:setVisible(false)
                    if bar.callback then
                        bar.callback()
                    end
                end
            )
        end
    )
end

function Utils:progressTo(bar, duration, endValue, completeCallback, perCallback)

    local pointSpine = TFDirector:getChildByPath(bar, "Spine_point")
    if pointSpine then
        pointSpine:hide()
    end
    if bar.timerId then
        bar:setPercent(bar.endValue)
        TFDirector:removeTimer(bar.timerId)
        bar.timerId = nil
    end
    local curValue = bar:getPercent()
    if curValue == endValue then
        bar:setPercent(endValue)
        if completeCallback then
            completeCallback()
        end
        return
    end
    bar.step = (endValue - curValue) / (duration / 0.01)
    bar.endValue = endValue
    bar.timerId = TFDirector:addTimer(
        10, -1, nil,
        function()
            if not bar.timerId then return end
            curValue = curValue + bar.step
            if bar.step > 0 then
                if curValue > bar.endValue then
                    bar:setPercent(bar.endValue)
                    if pointSpine then
                        pointSpine:hide()
                    end
                    TFDirector:removeTimer(bar.timerId)
                    bar.timerId = nil
                    if completeCallback then
                        completeCallback()
                    end
                    return
                end
            elseif bar.step == 0 then
                TFDirector:removeTimer(bar.timerId)
                bar.timerId = nil
                if completeCallback then
                    completeCallback()
                end
            else
                if curValue < bar.endValue then
                    bar:setPercent(bar.endValue)
                    TFDirector:removeTimer(bar.timerId)
                    bar.timerId = nil
                    if completeCallback then
                        completeCallback()
                    end
                    return
                end
            end
            bar:setPercent(curValue)
            if pointSpine then
                pointSpine:show()
                local w = bar:getContentSize().width
                local curLen = math.floor(w*curValue/100)
                pointSpine:setPositionX(-w/2+curLen)
            end
        end
    )
end

function Utils:shuffle(tbl)
    if type(tbl)~="table" then
        return
    end
    local t = clone(tbl)
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    local tab={}
    local index=1
    while #t~=0 do
        local n=math.random(0,#t)
        if t[n]~=nil then
            tab[index]=t[n]
            table.remove(t,n)
            index=index+1
        end
    end
    return tab
end

function Utils:playSound(soundCid, isLoop)
    isLoop = tobool(isLoop)
    local soundCfg = TabDataMgr:getData("SystemMusic", soundCid)
    if soundCfg then
        return TFAudio.playEffect(soundCfg.soundEffect, isLoop, nil, nil, soundCfg.size / 100)
    else
        Utils:showTips(800106, soundCid)
    end
end

function Utils:gameShare()
    if HeitaoSdk then
        HeitaoSdk.takeScreenshot();
        return;
    end

    takeScreenshot();
end

-- showType: 1.主界面加载  2.约会 3.战斗
local showDatas = {}
function Utils:randomAD(showType)
    if not showDatas[showType] then
        showDatas[showType] = {}
        local datas = TabDataMgr:getData("AdWeight")
        local start = 0
        for i, data in pairs(datas) do
            if data.showType == showType then
                data.section = data.probability + start
                start = data.section
                table.insert(showDatas[showType],data)
            end
        end
    end
    local showData = showDatas[showType]
    if #showData > 0 then
        local maxValue = showData[#showData].section
        local ranValue =  math.random(maxValue)
        print("randomAD maxValue:"..maxValue.." ranValue:"..ranValue)
        for i, data in ipairs(showData) do
            if ranValue <= data.section then
                -- print(showType , ranValue ,data)
                if TFFileUtil:existFile(data.res) then
                    return data.res ,data.descID
                end
                return "ui/update/s1.png",data.descID
            end
        end
    end
    Box("random ad data error showType:"..tostring(showType).." random:"..tostring(ranValue))
    return "ui/update/s1.png" , {}
end

function Utils:showWebView(url,size,noAppend,attach)
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        dump({url,size,noAppend,attach})
        return;
    end

    local fullModuleName = string.format("lua.logic.%s", "login.NoticeBoard")
    local view = requireNew(fullModuleName):new()
    AlertManager:addLayer(view,AlertManager.BLOCK)
    AlertManager:show()

    view:setUrl(url,noAppend,attach);
    view:setViewSize(size);
    view:show();

    return view
end

--设置屏幕朝向
function Utils:setScreenOrientation(Orientation)

    TFLuaOcJava.setScreenOrientation(Orientation)
    local pDirector = CCDirector:sharedDirector();
    local designSize = pDirector:getOpenGLView():getDesignResolutionSize()
    local frameSize = pDirector:getOpenGLView():getFrameSize();

    local newFrameSize,newDesignSize = frameSize,designSize
    if Orientation == SCREEN_ORIENTATION_LANDSCAPE then
        MainPlayer:setShareSdkState(1)
        if designSize.height > designSize.width then
            newFrameSize = CCSizeMake(frameSize.height,frameSize.width)
            newDesignSize = CCSizeMake(designSize.height,designSize.width)
        else
            return
        end
    elseif Orientation == SCREEN_ORIENTATION_PORTRAIT then
        MainPlayer:setShareSdkState(0)
        if designSize.width > designSize.height then
            newFrameSize = CCSizeMake(frameSize.height,frameSize.width)
            newDesignSize = CCSizeMake(designSize.height,designSize.width)
        else
            return
        end
    end


    pDirector:getOpenGLView():setFrameSize(newFrameSize.width,newFrameSize.height);
    pDirector:getOpenGLView():setDesignResolutionSize(newDesignSize.width, newDesignSize.height, kResolutionShowAll);

    GameConfig.WS                       = CCDirector:sharedDirector():getWinSize();

end

--春节主界面时间段离散数据
function Utils:isNewYearMainLayerUi()
    local servertime = ServerDataMgr:getServerTime()
    local newYearTime = Utils:getKVP(60001, "mainLayerUi")
    local opentime = tonumber(newYearTime.opentime) / 1000
    local endtime = tonumber(newYearTime.endtime) / 1000
    if opentime <= servertime and endtime >= servertime then
        return true
    end
    return false
end


function Utils:getTimeByDate(r)
    local a = string.split(r, " ")
    local b = string.split(a[1], "-")
    local c = string.split(a[2], ":")
    local t = os.time({year=b[1],month=b[2],day=b[3], hour=c[1], min=c[2], sec=c[3]})
    return t
end

--[[
    @desc: 获取字符长度 跟引擎的字符限定数据规格保存一致
    --@str: string类型数据
]]
function Utils:getCharLength(str)
    str = str or ""
    local strLength = 0
    local len = string.len(str)
    while str do
        local fontUTF = string.byte(str, 1)

        if fontUTF == nil then
            break
        end
        --lua中字符占1byte,中文占3byte
        if fontUTF > 127 then 
            local tmp = string.sub(str, 1, 3)
            strLength = strLength + 2
            str = string.sub(str, 4, len)
        else
            local tmp = string.sub(str, 1, 1)
            strLength = strLength + 1
            str = string.sub(str, 2, len)
        end
    end
    return strLength
end

function Utils:onTraitCollectionDidChange( )
    -- body
    local currentScene = Public:currentScene()
    if (currentScene and currentScene.updateUIUserInterfaceStyle) then currentScene:updateUIUserInterfaceStyle() end
end

function Utils:onKeyBack()
    if self.isInMovieScene == true  --[[and currentScene and currentScene.__cname ~= "LoginScene"]] then
        --在播放视频是不响应返回按钮
        return
    end

    local exitFun = function()
        if HeitaoSdk then
            HeitaoSdk.loginExit()
        else
            Box("真机上调用退出")
        end
    end

    local currentScene = Public:currentScene()
    local keyBackFun = function()
        local sceneName = currentScene.__cname
        if currentScene then
            if sceneName == "LoginScene" or sceneName == "BattleScene" or sceneName == "MainScene" or sceneName == "NewCityMainScene" or sceneName == "PortraitWebScene" then               
                local topLayer = currentScene:getTopLayer()
                if topLayer and topLayer.specialKeyBackLogic then
                    local param = topLayer:specialKeyBackLogic()
                    if param then return end
                end
                currentScene:onKeyBack()
            else
                exitFun()
            end
        else
            exitFun()
        end
    end
    
    if currentScene ~= nil and currentScene.onKeyBack then
        if (GuideDataMgr and GuideDataMgr:isInNewGuide()) or (GuideDataMgr and GuideDataMgr:findCurTriggerGuideGroup()) then
            if GameGuide:isInGuide() or GuideDataMgr:findCurTriggerGuideGroup() then
                local topLayer = currentScene:getTopLayer()
                if not topLayer or topLayer.__cname ~= "ConfirmBoxView" then
                    local view = Utils:openView("common.ConfirmBoxView")
                    view:setCallback(function()   
                        --指挥作战引导
                        if (GuideDataMgr and GuideDataMgr:findCurTriggerGuideGroup()) then
                            GameGuide:skipTeamGuideGroup()
                            return
                        end                                            
                        GameGuide:skipNewGuide()
                    end)
                    view:setContent(TextDataMgr:getText(100000126))--"确定要跳过学前教育吗？")    
                else
                    AlertManager:closeTopLayer()
                end
            else
                keyBackFun()
            end
        else
            keyBackFun()
        end
    else
        keyBackFun()
    end
end

--是否支持3D Touch
function Utils:isSuport3DTouch(maxForce)
    --新手引导 OR 非IOS or maxForce为0
    maxForce = maxForce or 0
    if GameGuide:isInGuide() or CC_TARGET_PLATFORM ~= CC_PLATFORM_IOS or maxForce == 0 then
        return false
    end

    return true
end

function Utils:getPowerRate()
    return self.powerRate or 1
end

-- 固定时间格式解析
function Utils:changStrToDate(str)
    local sp1 = string.split(str," ")
    local sp2 = string.split(sp1[1], "-")
    local sp3 = string.split(sp1[2], ":")
    local _year  = sp2[1]
    local _month = sp2[2]
    local _day   = sp2[3]
    local _hour  = sp3[1]
    local _minute = sp3[2]
    local _second = sp3[3]
    return {day = _day, month = _month,  year = _year, hour = _hour, min = _minute, sec = _second}
end

-- 年月日时分秒比较( return (date1 - date2 >= 0))
function Utils:compareDate(date1,date2)
    local dataTags = {"year", "month","day","hour" ,"min" ,"sec" }
    for i ,name in ipairs(dataTags) do
        local num1 = tonumber(date1[name])
        local num2 = tonumber(date2[name])
        if num1 > num2 then
            return true
        elseif num1 < num2 then
            return false
        end
    end
    return true
end

function Utils:createRewardItemStyle1(rewardParent, data, canTouch)
    if canTouch == nil then
        canTouch = true
    end
    
    local posList = {}
    posList[1] = {{0, 0, 0.8}}
    posList[2] = {{-47, 0, 0.8}, {47, 0, 0.8}}
    posList[3] = {{-47, 40, 0.8}, {47, 40, 0.8}, {0, -40, 0.6}}
    posList[4] = {{-47, 40, 0.6}, {47, 40, 0.6}, {-47, -40, 0.6}, {47, -40, 0.6}}

    if not rewardParent.list then
        rewardParent.list = {}
    end

    local curPos = posList[4]
    if #data < 4 then
        curPos = posList[#data]
    end
    for i = 1, 4 do
        local goodItem = rewardParent.list[i]
        if i <= #data then
            if not goodItem then
                goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                rewardParent.list[i] = goodItem
                rewardParent:addChild(goodItem)
            end
            goodItem:setTouchEnabled(canTouch)
            goodItem:setScale(curPos[i][3])
            goodItem:setPosition(ccp(curPos[i][1], curPos[i][2]))
            goodItem:show()
            goodItem.id = data[i].id
            PrefabDataMgr:setInfo(goodItem, data[i].id, data[i].num)
        else
            if goodItem then
                goodItem.id = nil
                goodItem:hide()
                goodItem:setTouchEnabled(false)
            end
        end
    end
end

--创建元素icon param[[数量 父节点 起始位置 距离 缩放 ]]
function Utils:createElementPanel(parentNode ,num ,startPos , distanceX ,scale)
    local items = {}
    distanceX = distanceX or 0
    startPos = startPos or ccp(0,0)
    scale = scale or 1
    for i =1, num do
        local panelElement = PrefabDataMgr:getPrefab("Panel_element"):clone()
        parentNode:addChild(panelElement)
        panelElement:setPosition(startPos + ccp(distanceX*(i-1) , 0))
        table.insert(items , panelElement)
        panelElement:setScale(scale)
    end
    if #items> 1 then
        return items
    else
        return items[1]  --如果是一个元素单独返回此元素
    end
end
--日志上报
function Utils:sendHttpLog(flagStr, isClick)
    ---暂时屏打点功能
    -- if true then
    --     return
    -- end

    flagStr = flagStr or ""
    local osname = "WINDOWS"

    local url = ""
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        url = "https://sdk-daac-en.datealive.com:9999/data?type=event_client_event_log"
        if isClick then
            url = "https://sdk-daac-en.datealive.com:9999/data?type=event_client_click_log"
        end
    else
        url = "http://sdk-daac-en.datealive.com:9998/data?type=event_client_event_log"
        if isClick then
            url = "http://sdk-daac-en.datealive.com:9998/data?type=event_client_click_log"
        end
    end
    
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        osname = "IOS"
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        osname = "ANDROID"
    end

    local token = ""
    local userId = ""
    local playerId = ""
    local platformId = 0
    local version = ""
    local imei = ""
    if HeitaoSdk then
        token = HeitaoSdk.gettoken()
        userId = HeitaoSdk.getuserid() or ""
        platformId = HeitaoSdk.getplatformId()
    end

    if MainPlayer and MainPlayer:getPlayerId() then
        playerId = MainPlayer:getPlayerId()
    end

    require('TFFramework.net.TFClientUpdate')
    local newUpdateFun = TFClientResourceUpdate:GetClientResourceUpdate()
    if newUpdateFun and newUpdateFun.getCurVersion then
        version = newUpdateFun:getCurVersion()
    end

    if osname == "WINDOWS" then
        return
    end

    local size = CCDirector:sharedDirector():getOpenGLView():getFrameSize()
    local data = {}
    data.sdkid = userId
    data.roleid = playerId
    data.deviceid = (TFDeviceInfo:getMachineOnlyID() or "")
    data.osversion = (TFDeviceInfo:getSystemVersion() or "")
    data.osname = osname
    data.networktype = TFDeviceInfo:getNetWorkType()
    data.screenwidth = size.width
    data.screenheight = size.height
    data.clienttime = os.time()
    data.mac = (TFDeviceInfo:getMacAddress() or "")
    data.channelid = "HEI_TAO"
    data.gaid = ""
    data.property = ""

    data.appversion = TFDeviceInfo:getCurAppVersion()
    data.resourceversion = version
    data.channelappid = platformId % 10000

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        data.devicename = (TFDeviceInfo:getDeviceModel() or "")
        data.devicebrand = "Apple"
        data.idfa = (TFDeviceInfo:getMachineOnlyID() or "")
        data.idfv = (TFDeviceInfo:getIDFV() or "")
        data.imei = ""
        data.androidid = ""
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        data.devicename = (TFDeviceInfo:getSystemName() or "")
        data.devicebrand = (TFDeviceInfo:getMachineName() or "")
        data.imei = (TFDeviceInfo:getIMEI() or "")
        data.androidid = (TFDeviceInfo:getAndroidId() or "")
        data.idfa = ""
        data.idfv = ""
    else
        data.devicename = "Windows"
        data.devicebrand = "Windows"
        data.androidid = ""
        data.idfa = ""
        data.idfv = ""
        data.imei = ""
    end
    data.servergroupid = math.floor(platformId / 10000)
    data.event_name = flagStr

    local json = require("LuaScript.extends.json")
    local jsonData = json.encode(data)

    url = string.gsub(url, " ", "")
    print("上报日志的url: ", url)
    print("上报日志的内容: ", jsonData)

    local callback = function()
        print("上报日志成功")
    end
    HttpHelper:post(url, jsonData, callback)
end


function Utils:createEffectByEffectId(effectId)
    local datingEffectMgrData = TabDataMgr:getData("DatingEffectMgr")
    local effectData = datingEffectMgrData[effectId]
    if not effectData then
        return
    end
    local skPath = effectData.path
    local aniName = effectData.action
    local node = TFPanel:create()
    node:setContentSize(CCSizeMake(0,0))

    if skPath and skPath ~= "" then
        local effect = SkeletonAnimation:create(skPath)
        local la = TFLabel:create()
        la:setText(" ")
        effect:addChild(la)
        node:addChild(effect)
        if aniName then
            effect:play(aniName, true)
        end
    end

    if effectData.particle and effectData.particle ~= "" then
        local effectParticle = TFParticle:create(effectData.particle)
        if effectParticle ~= nil then
            effectParticle:setVisible(true)
            effectParticle:resetSystem()
            node:addChild(effectParticle)
        end
    end

    if effectData.speBg and effectData.speBg ~= "" then
        local effectImage = TFImage:create(effectData.speBg)
        node:addChild(effectImage)
    end

    return node
end

function Utils:getTimeCountDownString(time,stringType)
    local serverTime = ServerDataMgr:getServerTime()
    local remainTime = math.max(0, time - serverTime)
    if stringType == 1 then
        local day, hour, min, sec = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            return TextDataMgr:getText(1260001, hour, min)
        else
            return TextDataMgr:getText(800069, day, hour)
        end
    elseif stringType == 2 then  
        local day, hour, min, sec = Utils:getTimeDHMZ(remainTime, true)
        if day == "00" then
            return TextDataMgr:getText(800026, hour, min, sec)
        else
            return TextDataMgr:getText(800026, day, hour, min)
        end
    end

end

function Utils:getActivityDateString(startTime, endTime, stringType)
    local startDate = self:getUTCDate(startTime ,GV_UTC_TIME_ZONE)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = self:getUTCDate(endTime ,GV_UTC_TIME_ZONE)
    local endDateStr = endDate:fmt("%Y.%m.%d")


    if stringType == 1 then
        startDateStr = startDate:fmt("%m.%d")
        endDateStr = endDate:fmt("%m.%d")
    end
    --修改显示活动时间
    --local text1 = TextDataMgr:getText(1710002)

    local text2 = TextDataMgr:getText(800041, startDateStr, endDateStr)

    return --[[text1..]]text2..GV_UTC_TIME_STRING

end

function Utils:getLocalSettingValue(key)
    key = key..MainPlayer:getPlayerId()
    local UserDefault = CCUserDefault:sharedUserDefault()

    local value = UserDefault:getStringForKey(key)
    return value
end

function Utils:setLocalSettingValue(key,value)
    key = key..MainPlayer:getPlayerId()
    local UserDefault = CCUserDefault:sharedUserDefault()
    UserDefault:setStringForKey(key, value)
    UserDefault:flush()
end

-- 判断字符串是否是存空格
function Utils:getTxtExistSpace(...)
    local data = {...}
    for i, txt in ipairs(data) do
       local _txt = string.gsub(txt," ","")
       if _txt == "" then
            return true
       end
    end 
    return false
end

function Utils:covertToColorRGB(color)

    local r = ('0x' .. color['4:5']) + 0
    local g = ('0x' .. color['6:7']) + 0
    local b = ('0x' .. color['8:9']) + 0
    local colorRGB = ccc3(r, g, b)

    return colorRGB
end


function Utils:getStoreBuyTipId( extendData, func)
    -- body
    extendData = extendData or {}
    if extendData.tipType == func then
        local items = type(extendData.limitItemId) == "table" and extendData.limitItemId or {extendData.limitItemId}
        for k,v in pairs(items) do
            local goodsOwnCnt = GoodsDataMgr:getItemCount( v )
            if goodsOwnCnt > 0 then
                return extendData.tipId
            end
        end
    end
    return nil
end

------rewards = {[id] == num}
function Utils:createRewardListHor(scrollView, rewards)
    if not scrollView.uilist then
        scrollView.uilist = UIListView:create(scrollView)
    end

    local count = #scrollView.uilist:getItems() - table.count(rewards)

    for i = 1,math.abs(count) do
        if count > 0 then
            scrollView.uilist:removeItem(1)
        end
    end

    local id,num
    for i =1,table.count(rewards) do
        id,num = next(rewards,id)
        local panel_goodsItem = scrollView.uilist:getItem(i)
        if not panel_goodsItem then
            panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            scrollView.uilist:pushBackCustomItem(panel_goodsItem)
        end
        PrefabDataMgr:setInfo(panel_goodsItem, tonumber(id), num)
        local size = scrollView:getContentSize()
        panel_goodsItem:setScale(size.height/panel_goodsItem:getContentSize().height)
    end

end

function Utils:showTipTool(targetNode, offsetPos)
    if not GoodsDataMgr.minusDiamond or GoodsDataMgr.minusDiamond <= 0 then
        return 
    end

    local currentScene = Public:currentScene()
    local tipTool = currentScene:getChildByName("TipTool")

    local lastTipsTime = nil
    if tipTool then
        lastTipsTime = tipTool.lastTipsTime
    end 
    if lastTipsTime and ServerDataMgr:getServerTime() - lastTipsTime < 3 then
        return
    end

    if tipTool then
        tipTool:setVisible(false)
        tipTool:stopAllActions()
        currentScene:removeLayer(tipTool)
    end
    local uiPath = "lua.uiconfig.common.itemCoolDownTips"
    tipTool = requireNew("lua.logic.common.TipTool"):new(uiPath, targetNode, offsetPos)
    tipTool.lastTipsTime = ServerDataMgr:getServerTime()
    tipTool:showAnimIn()
end


function Utils:splitLanguageStringByTag(text , tag )
    tag = tag or "#####"
    local strName = string.split(text , tag)
    if GAME_LANGUAGE_VAR == EC_LanguageType.Chinese then
        text = strName[1]
    else
        text = strName[2]
    end
    return text or ""
end

function Utils:getIsDayChangeBySaveData( strName )
    local playerId = MainPlayer:getPlayerId()
    local serverTime =  ServerDataMgr:customUtcTimeForServerTimestap()
    local saveTime = CCUserDefault:sharedUserDefault():getIntegerForKey(playerId..strName)
    if (saveTime > 0 and serverTime - saveTime > 24 * 3600 )   then
        CCUserDefault:sharedUserDefault():setIntegerForKey(playerId..strName ,serverTime)
        return true
    elseif  saveTime <= 0 then
        CCUserDefault:sharedUserDefault():setIntegerForKey(playerId..strName ,serverTime)
        return true
    end
    return false
end

function Utils:clearDayChageSaveData( strName )
    local playerId = MainPlayer:getPlayerId()
    CCUserDefault:sharedUserDefault():setIntegerForKey(playerId..strName ,0)
end

return Utils
