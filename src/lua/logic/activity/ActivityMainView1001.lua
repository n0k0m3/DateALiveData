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
*-- 狂三应援活动主界面
* 
]]

local ActivityMainView1001 = requireNew("lua.logic.activity.ActivityMainView")
ActivityMainView1001.__cname = "ActivityMainView1001"
ActivityMainView1001.activityShowType = 1001

function addActivityItem(self)
    local Panel_activityItem = self.Panel_activityItem:clone()

Panel_activityItem.ImageSelect = TFDirector:getChildByPath(Panel_activityItem, "ImageSelect")
Panel_activityItem.ImageNormal = TFDirector:getChildByPath(Panel_activityItem, "ImageNormal")



Panel_activityItem.ImageNormal.activityName = TFDirector:getChildByPath(Panel_activityItem.ImageNormal, "activityName")
Panel_activityItem.ImageNormal.Image_new   = TFDirector:getChildByPath(Panel_activityItem.ImageNormal, "Image_new"):hide()


Panel_activityItem.ImageSelect.activityName = TFDirector:getChildByPath(Panel_activityItem.ImageSelect ,"activityName")
Panel_activityItem.ImageSelect.Image_new   = TFDirector:getChildByPath(Panel_activityItem.ImageSelect, "Image_new"):hide()

Panel_activityItem.ImageSelect.activityName:setSkewX(15)
Panel_activityItem.ImageNormal.activityName:setSkewX(15)

Panel_activityItem.setActivityName = function (self,name)
    self.ImageSelect.activityName:setTextById(name) 
    self.ImageNormal.activityName:setTextById(name)

    self.ImageNormal.activityName:setFontColor(ccc3(235 , 149 , 245))
end

Panel_activityItem.setImage = function (self,titleIcon)
    local iconPath = titleIcon
    self.ImageNormal:setTexture(iconPath)
    if iconPath then
        self.ImageSelect:setTexture(string.sub(iconPath,0,-6) .. "s.png")
    end
end

Panel_activityItem.setSelect = function (self,_select,icon)
    self.ImageSelect:setVisible(_select)
    self.ImageNormal:setVisible(not _select)
end

Panel_activityItem.setVisibleRedpoint = function (self,select)
    self.ImageSelect.Image_new:setVisible(select)
    self.ImageNormal.Image_new:setVisible(select)
end

    self.activityItem_[Panel_activityItem] = Panel_activityItem
    self.ListView_activity:pushBackCustomItem(Panel_activityItem)
end


rawset(ActivityMainView1001, "addActivityItem", addActivityItem)

function updateActivtyItem(self,index)
	local activity = self.activityInfo_[index]

    local item = self.ListView_activity:getItem(index)
    local foo  = self.activityItem_[item]
    foo:setActivityName(activity.extendData.name)
    --local select = string.sub(activity.titleIcon,1,-5)
    foo:setImage(activity.titleIcon)

    foo:setTouchEnabled(true)
    foo:onClick(function()
        self:selectActivity(index)
    end)

    self:updateActivtyItemRedPoint(index)
end
rawset(ActivityMainView1001, "updateActivtyItem", updateActivtyItem)

function selectActivity(self, index, force)

    if #self.activityInfo_ == 0 then return end
    if self.selectIndex_ == index and not force then return end
    self.selectIndex_ = index

    for i, v in ipairs(self.ListView_activity:getItems()) do
        local isSelect = i == index
        local activity = self.activityInfo_[i] 

        local foo = self.activityItem_[v]
        foo:setSelect(isSelect,activity.titleIcon)
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
rawset(ActivityMainView1001, "selectActivity", selectActivity)


function updateActivtyItemRedPoint(self,index)
    local activity = self.activityInfo_[index]
    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]

    local isShow = ActivityDataMgr2:isShowRedPoint(activity.id)
    foo:setVisibleRedpoint(isShow)
end


rawset(ActivityMainView1001, "updateActivtyItemRedPoint", updateActivtyItemRedPoint)
return ActivityMainView1001