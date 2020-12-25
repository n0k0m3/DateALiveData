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
*-- 新类型活动主界面
* 
]]

local ActivityMainView2 = requireNew("lua.logic.activity.ActivityMainView")
ActivityMainView2.__cname = "ActivityMainView2"
ActivityMainView2.activityShowType = 2


function addActivityItem(self)
    local Panel_activityItem = self.Panel_activityItem:clone()
    Panel_activityItem.defaultSize = Panel_activityItem:getContentSize()
    Panel_activityItem.ImageSelect = TFDirector:getChildByPath(Panel_activityItem, "ImageSelect")
    Panel_activityItem.ImageNormal = TFDirector:getChildByPath(Panel_activityItem, "ImageNormal")

    Panel_activityItem.ImageNormal.activityName = TFDirector:getChildByPath(Panel_activityItem.ImageNormal, "activityName")
    Panel_activityItem.ImageNormal.Image_new   = TFDirector:getChildByPath(Panel_activityItem.ImageNormal, "Image_new"):hide()

    Panel_activityItem.ImageSelect.activityName = TFDirector:getChildByPath(Panel_activityItem.ImageSelect ,"activityName")
    Panel_activityItem.ImageSelect.Image_new   = TFDirector:getChildByPath(Panel_activityItem.ImageSelect, "Image_new"):hide()

    Panel_activityItem.setActivityName = function (self,name)
        self.ImageSelect.activityName:setText(Utils:MultiLanguageStringDeal(name))
        self.ImageNormal.activityName:setText(Utils:MultiLanguageStringDeal(name))
    end

    Panel_activityItem.setSelect = function (self,_select)
        self.ImageSelect:setVisible(_select)
        self.ImageNormal:setVisible(not _select)

        local nodeSize = _select and self.ImageSelect:getContentSize() or self.ImageNormal:getContentSize()
        Panel_activityItem:setContentSize(CCSizeMake(math.max(Panel_activityItem.defaultSize.width,nodeSize.width),math.max(Panel_activityItem.defaultSize.height, nodeSize.height+2)))
    end

    Panel_activityItem.setTabBtnIcon = function (self,activity)
        local iconPath = activity.titleIcon or "ui/activity/picture/icon67.png"
        self.ImageSelect:setTexture(string.sub(iconPath,0,-5) .. "_1.png")
        self.ImageNormal:setTexture(iconPath)
    end

    Panel_activityItem.setVisibleRedpoint = function (self,select)
        self.ImageSelect.Image_new:setVisible(select)
        self.ImageNormal.Image_new:setVisible(select)
    end

    self.activityItem_[Panel_activityItem] = Panel_activityItem
    self.ListView_activity:pushBackCustomItem(Panel_activityItem)
end


rawset(ActivityMainView2, "addActivityItem", addActivityItem)

function updateActivtyItem(self,index)
    local activity = self.activityInfo_[index]

    local item = self.ListView_activity:getItem(index)
    local foo  = self.activityItem_[item]
    foo:setActivityName(activity.extendData.name)
    if activity.extendData.skewX then
        foo.ImageSelect.activityName:setSkewX(activity.extendData.skewX)
        foo.ImageNormal.activityName:setSkewX(activity.extendData.skewX)
    end
    foo:setTabBtnIcon(activity)
    foo:setTouchEnabled(true)
    foo:onClick(function()
        self:selectActivity(index)
    end)

    self:updateActivtyItemRedPoint(index)
end
rawset(ActivityMainView2, "updateActivtyItem", updateActivtyItem)

function selectActivity(self, index, force)
    if #self.activityInfo_ == 0 then return end
    if self.selectIndex_ == index and not force then return end

    ---关闭上一个页签model
    if self.selectIndex_ then
        local oldActivityInfo = self.activityInfo_[self.selectIndex_]
        local oldModel = self.activityModel_[oldActivityInfo.id]
        if oldModel and oldModel.hideActivityModel then
            oldModel:hideActivityModel()
        end
    end

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
rawset(ActivityMainView2, "selectActivity", selectActivity)


function updateActivtyItemRedPoint(self,index)
    local activity = self.activityInfo_[index]
    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]

    local isShow = ActivityDataMgr2:isShowRedPoint(activity.id)
    foo:setVisibleRedpoint(isShow)
end


rawset(ActivityMainView2, "updateActivtyItemRedPoint", updateActivtyItemRedPoint)
return ActivityMainView2