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
    local foo = {}
    foo.root = Panel_activityItem

    foo.Image_item_bg_n = TFDirector:getChildByPath(foo.root, "Image_item_bg_n")
    foo.Image_item_bg_s = TFDirector:getChildByPath(foo.root, "Image_item_bg_s")
    foo.Image_flag = TFDirector:getChildByPath(foo.root, "Image_flag")
    foo.activityName = TFDirector:getChildByPath(foo.root, "activityName")
    foo.Image_new = TFDirector:getChildByPath(foo.root, "Image_new"):hide()
    self.activityItem_[foo.root] = foo
    self.ListView_activity:pushBackCustomItem(foo.root)
end


rawset(ActivityMainView2, "addActivityItem", addActivityItem)

function updateActivtyItem(self,index)
	local activity = self.activityInfo_[index]

    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]
    foo.activityName:setText(activity.extendData.name)
    foo.root:onClick(function()
            self:selectActivity(index)
    end)

    self:updateActivtyItemRedPoint(index)
end
rawset(ActivityMainView2, "updateActivtyItem", updateActivtyItem)

function selectActivity(self, index, force)
    if #self.activityInfo_ == 0 then return end
    if self.selectIndex_ == index and not force then return end
    self.selectIndex_ = index

    for i, v in ipairs(self.ListView_activity:getItems()) do
        local isSelect = i == index
        local activity = self.activityInfo_[i] 

        local foo = self.activityItem_[v]
        local iconPath = activity.titleIcon or "ui/activity/picture/icon67.png"
        foo.Image_flag:setTexture(isSelect and iconPath or string.sub(iconPath,0,-5) .. "_1.png")
        foo.Image_item_bg_n:setVisible(not isSelect)
        foo.Image_item_bg_s:setVisible(isSelect)
        if isSelect then
            foo.Image_flag:setPositionX(-159)
            foo.activityName:setPositionX(-119)
            foo.activityName:setFontColor(ccc3(255,255,255))
        else
            foo.Image_flag:setPositionX(-163)
            foo.activityName:setPositionX(-129)
            foo.activityName:setFontColor(ccc3(219,254,255))
        end
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
end
rawset(ActivityMainView2, "selectActivity", selectActivity)

return ActivityMainView2