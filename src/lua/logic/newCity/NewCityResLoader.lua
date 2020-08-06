local NewCityResLoader = {}

local this = NewCityResLoader
this.cachedModelRes = {}
this.cachedCityShapeNode = {}
function NewCityResLoader.loadAllRes(reslist, loadtype)
    this.clean()
    local objsc = AlertManager:changeScene(SceneType.NewCityLoad, loadtype)
    --objsc:timeOut(function()
        local allres = {}
        for k, v1 in pairs(reslist) do
            for i, v2 in ipairs(v1) do
                allres[v2.dressId] = v2
            end
        end

        --同步加载
        local size = table.count(allres)
        local loadindex = 1
        if size < loadindex then
            --if loadtype == EC_NewCityLoadType.Update then
            --    EventMgr:dispatchEvent(EV_NEW_CITY.resUpdateFinish)
            --else
                EventMgr:dispatchEvent(EV_NEW_CITY.resLoadStatus, 1, 1)
            --end
            return
        end

        local allkeys = table.keys(allres)
        objsc.loadtimer = TFDirector:addTimer(100, -1, nil, function()
            if loadindex <= size then
                local resconf = allres[allkeys[loadindex]]
                if not this.cachedCityShapeNode[resconf.dressId] then
                    this.createSpine(resconf.rolePath, resconf.roleType, resconf.dressId, resconf.roleId, resconf.aiWord, resconf.iconPos, resconf.isFlip)
                    --this.createSpine(resconf.rolePath, resconf.roleType, resconf.dressId, resconf.roleId, resconf.aiWord)--TODO 要还原代码
                    --if loadtype == EC_NewCityLoadType.Update then
                    --    if loadindex >= size then EventMgr:dispatchEvent(EV_NEW_CITY.resUpdateFinish) end
                    --else
                        EventMgr:dispatchEvent(EV_NEW_CITY.resLoadStatus, loadindex, size)
                    --end
                end
                loadindex = loadindex + 1
            else
                TFDirector:removeTimer(objsc.loadtimer)
                objsc.loadtimer = nil
            end
        end)

        --异步加载
        --local size = table.count(reslist)
        --local count = 0
        --if size <= count then
        --    if loadtype == EC_NewCityLoadType.Update then
        --        EventMgr:dispatchEvent(EV_NEW_CITY.resUpdateFinish)
        --    else
        --        EventMgr:dispatchEvent(EV_NEW_CITY.resLoadStatus, 1, 1)
        --    end
        --    return
        --end
        --for i, v in pairs(reslist) do
        --    if not this.cachedModelRes[v.rolePath] then
        --        SpineCache:getInstance():addFileAsync(v.rolePath..".json", v.rolePath..".atlas",function (result)
        --            if not result then
        --                return
        --            end
        --            count = count + 1
        --            this.cachedModelRes[v.rolePath] = 1
        --            this.createSpine(v.rolePath, v.roleType, v.dressId, v.roleId, v.aiWord)
        --            if loadtype == EC_NewCityLoadType.Update then
        --                if size <= count then EventMgr:dispatchEvent(EV_NEW_CITY.resUpdateFinish) end
        --            else
        --                EventMgr:dispatchEvent(EV_NEW_CITY.resLoadStatus, count, size)
        --            end
        --        end)
        --    else
        --        if not this.cachedCityShapeNode[v.dressId] then
        --            this.createSpine(v.rolePath, v.roleType, v.dressId, v.roleId, v.aiWord)
        --        end
        --    end
        --end
    --end, 0.2)
end

function NewCityResLoader.createSpine(res, stype, mid, rid, word, iconpos, flip)
    local conf = {
        path = res,
        stype = stype,
        mid = mid,
        rid = rid,
        word = word,
        iconpos = iconpos,
        isflip = flip,
    }
    local shape = requireNew("lua.logic.newCity.CityShape"):new(conf)
    shape:retain()
    this.cachedCityShapeNode[mid] = shape
end

function NewCityResLoader.getCachedShapeNode(mid)
    local shape = this.cachedCityShapeNode[mid]
    if tolua.isnull(shape) then
        local id = mid or 0
        local errormsg = TextDataMgr:getText(500043, id)
        Bugly:ReportLuaException(errormsg)
        Box(errormsg)
    end
    return shape
end

function NewCityResLoader.clean()
    for k, v in pairs(this.cachedCityShapeNode) do
        if v then
            if v:getParent() then
                v:removeFromParent()
            end
            v:release()
        end
    end
    this.cachedCityShapeNode = {}
    this.cachedModelRes = {}
end

return NewCityResLoader