local BaseDataMgr = import(".BaseDataMgr")
local MakeFoodDataMgr = class("MakeFoodDataMgr", BaseDataMgr)
local UserDefalt = CCUserDefault:sharedUserDefault()
function MakeFoodDataMgr:ctor()
    self:init()
end

function MakeFoodDataMgr:init()

    --料理烹饪本地数据
    self.foodInfo = {}
    self.foodMap = TabDataMgr:getData("Foodbase")
    local orderFood = {}
    local datingFood = {}
    for _,v in pairs(self.foodMap) do
        table.insert(orderFood, v)
    end
    table.sort(orderFood, function(a, b)
        if a.foodType == b.foodType then
           return a.order < b.order
       end
       return a.foodType < b.foodType
    end)

    self.foodlist = {}
    for k ,v in pairs(orderFood) do
        self.foodlist[v.foodType] = self.foodlist[v.foodType] or {}
        table.insert(self.foodlist[v.foodType],v)
    end


    self.datingFoodList ={}
    local ditingFood = self.foodlist[4]
    if ditingFood then
        for k,v in pairs(self.foodlist[4]) do
            self.datingFoodList[v.datingId] = self.datingFoodList[v.datingId] or {}
            table.insert(self.datingFoodList[v.datingId],v)  
        end
    end
end

function MakeFoodDataMgr:saveRecordCnt()

    local pid = MainPlayer:getPlayerId()
    local recordCnt = UserDefalt:getStringForKey("Makefood"..pid)
    recordCnt = tonumber(recordCnt)
    if not recordCnt then
        recordCnt = 0
    end
    recordCnt = recordCnt + 1
    UserDefalt:setStringForKey("Makefood"..pid,recordCnt)
    UserDefalt:flush()
end

function MakeFoodDataMgr:getRecordCnt()

    local pid = MainPlayer:getPlayerId()
    local recordCnt = UserDefalt:getStringForKey("Makefood"..pid)
    recordCnt = tonumber(recordCnt) and tonumber(recordCnt) or 0
    return recordCnt
end

function MakeFoodDataMgr:onLogin()
    self:init();
    TFDirector:addProto(s2c.NEW_BUILDING_RESPGET_FOODBASE_INFO, self, self.onRecvGetFoodBaseInfo)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_COOK_FOODBASE, self, self.onRecvCookFood)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_UPLOAD_QTE_INTEGRAL, self, self.onRecvQte)
    TFDirector:addProto(s2c.NEW_BUILDING_RESP_GET_FOOD_BASE_AWARD, self, self.onRecvGetFoodBaseAward)

end

function MakeFoodDataMgr:onLoginOut()
    self.foodInfo = {}
    self.foodlist = {}
    self.datingFoodList ={}
end

function MakeFoodDataMgr:getFoodlistByType(foodType)

   return self.foodlist[foodType]
end

function MakeFoodDataMgr:getFoodInfoById(foodId)

    for type,info in ipairs(self.foodlist) do
        for k,v in ipairs(info) do
            if v.id == foodId then
                return v
            end
        end
    end
    return nil
end

function MakeFoodDataMgr:getFoodListIndex(foodType,foodId)

    local foodGroup = self.foodlist[foodType]
    if not foodGroup then
        return
    end

    for k,v in ipairs(foodGroup) do
        if v.id == foodId then
            return k
        end
    end

    return nil
end

function MakeFoodDataMgr:getFoodBaseInfo()

   return self.baseFoodInfo
end

function MakeFoodDataMgr:getDatingFood(datingId)

    if not datingId then
        return
    end

    if not self.datingFoodList[datingId] then
        return
    end

    return self.datingFoodList[datingId]
end

function MakeFoodDataMgr:getDatingId()
    return self.datingId
end

function MakeFoodDataMgr:setDatingId(datingId)
    self.datingId = datingId
end

function MakeFoodDataMgr:openMakeFoodView(param)

    if param and param.id then
        self.datingId = param.id
        TFDirector:send(c2s.NEW_BUILDING_REQGET_FOODBASE_INFO, {false})
    else
        TFDirector:send(c2s.NEW_BUILDING_REQGET_FOODBASE_INFO, {true})
    end
end

--请求料理制作消息
function MakeFoodDataMgr:onRecvGetFoodBaseInfo(event)
    
    local data = event.data
    local foodbaseInfo = data.foodbaseInfo
    self.baseFoodInfo = foodbaseInfo
    Utils:openView("newCity.MakeFoodView")
end

--开始制作料理
function MakeFoodDataMgr:onRecvCookFood(event)
    
    local data = event.data
    EventMgr:dispatchEvent(EV_FUNC_START_COOK, data)
end

--QTE操作
function MakeFoodDataMgr:onRecvQte(event)
     
    local data = event.data
    EventMgr:dispatchEvent(EV_FUNC_AFTER_QTE, data)
end

--领取奖励
function MakeFoodDataMgr:onRecvGetFoodBaseAward(event)
    
    local data = event.data
    EventMgr:dispatchEvent(EV_FUNC_GET_BASE_AWARD, data)
end


function MakeFoodDataMgr:existCookFood(foodType)

    if not foodType then
        return false
    end

    local foodList = self:getFoodlistByType(foodType)
    if not foodList then
        return false
    end
    for k,v in ipairs(foodList) do
        local isEnough = self:isEnoughCook(v.materials)
        if isEnough then
            local isEnoughAbility = self:isEnoughAbility(v.ability)
            if isEnoughAbility then
                return true
            end
        end
    end

    return false

end

function MakeFoodDataMgr:isEnoughCook(materialItem)

    if not materialItem then
        return false
    end

    local enoughCnt = 0
    for k,v in pairs(materialItem) do
        local count = GoodsDataMgr:getItemCount(v[1])
        if count < v[2] then
            return false
        end
    end

    return true
end

function MakeFoodDataMgr:isEnoughAbility(ability)

    if not ability then
        return false
    end

    local enoughCnt = 0
    for k,v in pairs(ability) do
        local count = GoodsDataMgr:getItemCount(v[1])
        if count < v[2] then
            return false
        end
    end

    return true
end

return MakeFoodDataMgr:new()
