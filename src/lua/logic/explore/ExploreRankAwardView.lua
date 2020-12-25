local ExploreRankAwardView = class("ExploreRankAwardView", BaseLayer)


function ExploreRankAwardView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.explore.exploreRankAwardView")
end

function ExploreRankAwardView:initData()

    self.pointsReward = {}
    local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.EXPLORE)
    local activityInfo = ActivityDataMgr2:getActivityInfo(activityId[1])
    if activityInfo and activityInfo.extendData and activityInfo.extendData.pointsReward then
        self.pointsReward = activityInfo.extendData.pointsReward
    end

    self.bgRes = {"ui/explore/award/02.png","ui/explore/award/03.png","ui/explore/award/04.png"}

end

function ExploreRankAwardView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")
    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

    self.Pannle_prefab = TFDirector:getChildByPath(ui,"Pannle_prefab")
    self.rank_item = TFDirector:getChildByPath(self.Pannle_prefab,"rank_item")

    local ScrollView_info = TFDirector:getChildByPath(self.Panel_root,"ScrollView_info")
    self.UIListView_rank = UIListView:create(ScrollView_info)

    local Label_tip = TFDirector:getChildByPath(self.Panel_root,"Label_tip")
    Label_tip:setTextById(15010045)

    self:initUILogic()
end

function ExploreRankAwardView:initUILogic()

    self.UIListView_rank:removeAllItems()
    for k,v in ipairs(self.pointsReward) do
        local item = self.rank_item:clone()
        self:updateRankItem(item,k)
        self.UIListView_rank:pushBackCustomItem(item)
    end

end

function ExploreRankAwardView:updateRankItem(item,index)

    local data = self.pointsReward[index]
    if not data then
        return
    end
    local id = data[1]
    local Label_tiltle = TFDirector:getChildByPath(item,"Label_tiltle")
    local Image_item = TFDirector:getChildByPath(item,"Image_item")
    local res = self.bgRes[index] and self.bgRes[index] or "ui/explore/award/05.png"
    Image_item:setTexture(res)

    if index == 1 then
        Label_tiltle:setTextById(15010043,id)
    else
        local beforeData =  self.pointsReward[index-1]
        if beforeData then
            if index == #self.pointsReward then
                Label_tiltle:setTextById(15010046,beforeData[1]+1)
            else
                local str = (beforeData[1]+1).."-"..id
                Label_tiltle:setTextById(15010043,str)
            end

        end
    end


    local ScrollView_award = TFDirector:getChildByPath(item,"ScrollView_award")
    local UIListView_ward = UIListView:create(ScrollView_award)

    UIListView_ward:removeAllItems()
    local award = data[2] or {}
    for k,v in pairs(award) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, tonumber(k), v)
        Panel_goodsItem:Scale(0.6)
        UIListView_ward:pushBackCustomItem(Panel_goodsItem)
    end

end

function ExploreRankAwardView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:close(self)
    end)
end

return ExploreRankAwardView
