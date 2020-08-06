--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*-- 周年庆活动主界面
* 
]]

local ActivityMainView3 = requireNew("lua.logic.activity.ActivityMainView")
ActivityMainView3.__cname = "ActivityMainView3"
ActivityMainView3.activityShowType = 3

local tabBtnIcon = {
    [EC_ActivityType2.WELFARE_SIGN] = {normal = "ui/activity/anniversary/ui_002.png", selected = "ui/activity/anniversary/ui_001.png"},
    [EC_ActivityType2.ZNQ_HG] = {normal = "ui/activity/anniversary/ui_008.png", selected = "ui/activity/anniversary/ui_007.png"},
    [EC_ActivityType2.ONEYEAR_CELEBRATION] = {normal = "ui/activity/anniversary/ui_021.png", selected = "ui/activity/anniversary/ui_020.png"},
    [EC_ActivityType2.ONEYEAR_WELFARE] = {normal = "ui/activity/anniversary/ui_006.png", selected = "ui/activity/anniversary/ui_005.png"},
    [EC_ActivityType2.BLACK_WHITE] = {normal = "ui/activity/anniversary/ui_004.png", selected = "ui/activity/anniversary/ui_003.png"},
    [EC_ActivityType2.WELFARE_RECHEAGE] = {normal = "ui/activity/anniversary/ui_017.png", selected = "ui/activity/anniversary/ui_016.png"},
    [EC_ActivityType2.WELFARE_GIFT] = {normal = "ui/activity/anniversary/ui_019.png", selected = "ui/activity/anniversary/ui_018.png"},
    [EC_ActivityType2.ADD_RECHARGE] = {normal = "ui/activity/anniversary/ui_015.png", selected = "ui/activity/anniversary/ui_014.png"},
}


function addActivityItem(self)
    local Panel_activityItem = self.Panel_activityItem:clone()

Panel_activityItem.ImageSelect = TFDirector:getChildByPath(Panel_activityItem, "ImageSelect")
Panel_activityItem.ImageNormal = TFDirector:getChildByPath(Panel_activityItem, "ImageNormal")

Panel_activityItem.ImageNormal.activityName = TFDirector:getChildByPath(Panel_activityItem.ImageNormal, "activityName")
Panel_activityItem.ImageNormal.Image_new   = TFDirector:getChildByPath(Panel_activityItem.ImageNormal, "Image_new"):hide()

Panel_activityItem.ImageSelect.activityName = TFDirector:getChildByPath(Panel_activityItem.ImageSelect ,"activityName")
Panel_activityItem.ImageSelect.Image_new   = TFDirector:getChildByPath(Panel_activityItem.ImageSelect, "Image_new"):hide()

Panel_activityItem.setActivityName = function (self,name)
    self.ImageSelect.activityName:setText(name) 
    self.ImageNormal.activityName:setText(name)
end

Panel_activityItem.setImage = function (self,name)
    self.ImageSelect:setTexture(name) 
    self.ImageNormal:setTexture(name)
end

Panel_activityItem.setSelect = function (self,_select)
    self.ImageSelect:setVisible(_select)
    self.ImageNormal:setVisible(not _select)
end

Panel_activityItem.setTabBtnIcon = function (self,activity)
    local tabIcon = tabBtnIcon[activity.activityType]
    if tabIcon then
        self.ImageSelect:setTexture(tabIcon.selected)
        self.ImageNormal:setTexture(tabIcon.normal)
    end
end

Panel_activityItem.setVisibleRedpoint = function (self,select)
    self.ImageSelect.Image_new:setVisible(select)
    self.ImageNormal.Image_new:setVisible(select)
end

    self.activityItem_[Panel_activityItem] = Panel_activityItem
    self.ListView_activity:pushBackCustomItem(Panel_activityItem)
end


rawset(ActivityMainView3, "addActivityItem", addActivityItem)

function updateActivtyItem(self,index)
	local activity = self.activityInfo_[index]

    local item = self.ListView_activity:getItem(index)
    local foo  = self.activityItem_[item]
    foo:setActivityName(activity.extendData.name)
    foo:setTabBtnIcon(activity)
    foo:setTouchEnabled(true)
    foo:onClick(function()
        self:selectActivity(index)
    end)

    self:updateActivtyItemRedPoint(index)
end
rawset(ActivityMainView3, "updateActivtyItem", updateActivtyItem)

function selectActivity(self, index, force)
    if #self.activityInfo_ == 0 then return end
    if self.selectIndex_ == index and not force then return end
    self.selectIndex_ = index

    for i, v in ipairs(self.ListView_activity:getItems()) do
        local isSelect = i == index
        local activity = self.activityInfo_[i] 

        local foo = self.activityItem_[v]
        foo:setSelect(isSelect)
    end

    local activityInfo = self.activityInfo_[index]
    local type_ = activityInfo.activityType

    local model = self.activityModel_[activityInfo.id]
    if not model then
        model = self:addModelItem(activityInfo.id, type_)
        self.activityModel_[activityInfo.id] = model
    end
    if model and model.updateActivity then
        model:updateActivity()
    end

    for k, v in pairs(self.activityModel_) do
        v:setVisible(activityInfo.id == k)
    end

    self.ListView_activity:doLayout()
end
rawset(ActivityMainView3, "selectActivity", selectActivity)


function updateActivtyItemRedPoint(self,index)
    local activity = self.activityInfo_[index]
    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]

    local isShow = ActivityDataMgr2:isShowRedPoint(activity.id)
    foo:setVisibleRedpoint(isShow)
end


rawset(ActivityMainView3, "updateActivtyItemRedPoint", updateActivtyItemRedPoint)
return ActivityMainView3