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

local ActivityMainView5 = requireNew("lua.logic.activity.ActivityMainView")
ActivityMainView5.__cname = "ActivityMainView5"
ActivityMainView5.activityShowType = 5


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
    self.ImageSelect.activityName:setText(Utils:splitLanguageStringByTag(name)) 
    self.ImageNormal.activityName:setText(Utils:splitLanguageStringByTag(name))
end

Panel_activityItem.setImage = function (self,select,normal)
    self.ImageSelect:setTexture(select)
    self.ImageNormal:setTexture(normal)
end

Panel_activityItem.setSelect = function (self,_select,icon)
    self.ImageSelect:setVisible(_select)
    self.ImageNormal:setVisible(not _select)

    if _select then
        if icon and #icon > 1 then 
            if TFFileUtil:existFile(icon) then 
                self.ImageSelect:setTexture(icon)
            end
        end 
        local size  = self.ImageSelect:getSize()
        size.height = size.height + 2
        Panel_activityItem:setSize(size)
        self.ImageSelect:setPosition(ccp(size.width*0.5,size.height*0.5))
    else
        local size  = self.ImageNormal:getSize()
        size.height = size.height + 2
        Panel_activityItem:setSize(size)
        self.ImageNormal:setPosition(ccp(size.width*0.5,size.height*0.5))
    end
end

Panel_activityItem.setVisibleRedpoint = function (self,select)
    self.ImageSelect.Image_new:setVisible(select)
    self.ImageNormal.Image_new:setVisible(select)
end


    self.activityItem_[Panel_activityItem] = Panel_activityItem
    self.ListView_activity:pushBackCustomItem(Panel_activityItem)
end


rawset(ActivityMainView5, "addActivityItem", addActivityItem)

function updateActivtyItem(self,index)
	local activity = self.activityInfo_[index]

    local item = self.ListView_activity:getItem(index)
    local foo  = self.activityItem_[item]
    foo:setActivityName(activity.extendData.name)
    local select = string.sub(activity.titleIcon,1,-5)
    foo:setImage(activity.titleIcon,select.."_normal.png")
    foo:setTouchEnabled(true)
    foo:onClick(function()
        self:selectActivity(index)
    end)

    self:updateActivtyItemRedPoint(index)
end
rawset(ActivityMainView5, "updateActivtyItem", updateActivtyItem)

function selectActivity(self, index, force)

    if #self.activityInfo_ == 0 then return end
    if self.selectIndex_ == index and not force then return end
    self.selectIndex_ = index

    for i, v in ipairs(self.ListView_activity:getItems()) do
        local isSelect = i == index
        local activity = self.activityInfo_[i] 

        local foo = self.activityItem_[v]
        -- local iconPath = activity.titleIcon or "ui/activity/picture/icon67.png"
        -- foo.Image_flag:setTexture(isSelect and iconPath or string.sub(iconPath,0,-5) .. "_1.png")
        -- foo.Image_item_bg:setTexture(isSelect and "ui/activity/activityMain2/c1.png" or "ui/activity/activityMain2/c1_1.png")
        -- if isSelect then
        --     foo.Image_flag:setPositionX(-165)
        --     foo.activityName:setPositionX(-119)
        --     foo.activityName:setFontColor(ccc3(255,255,255))
        -- else
        --     foo.Image_flag:setPositionX(-181)
        --     foo.activityName:setPositionX(-129)
        --     foo.activityName:setFontColor(ccc3(219,254,255))
        -- end
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
rawset(ActivityMainView5, "selectActivity", selectActivity)


function updateActivtyItemRedPoint(self,index)
    local activity = self.activityInfo_[index]
    local item = self.ListView_activity:getItem(index)
    local foo = self.activityItem_[item]

    local isShow = ActivityDataMgr2:isShowRedPoint(activity.id)
    foo:setVisibleRedpoint(isShow)
end


rawset(ActivityMainView5, "updateActivtyItemRedPoint", updateActivtyItemRedPoint)
return ActivityMainView5