local WishTree = class("WishTree",BaseLayer)

function WishTree:ctor( data )
    -- body
    self.super.ctor(self,data)
    self:initData(data)
    --self:showPopAnim(true)
    self:init("lua.uiconfig.NewYear.wishTree")
end

function WishTree:initData( data )
    local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEAR_WISH)[1]
    self.activityId = data
    self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)

    self.cgIds = {}
    if self.activityInfo and self.activityInfo.extendData then
        self.cgIds = self.activityInfo.extendData.cg or {}
    end

    TFDirector:send(c2s.ACTIVITY2_REQ_SPRING_WITH_TREE_LIST,{})
end

function WishTree:initUI( ui )
    self.super.initUI(self,ui)
    self.Panel_danmu = TFDirector:getChildByPath(ui,"Panel_danmu")
    self.Panel_cg = TFDirector:getChildByPath(ui,"Panel_cg")
    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
    self.Button_checkWish = TFDirector:getChildByPath(ui,"Button_checkWish")
    self.Button_fsdm = TFDirector:getChildByPath(ui,"Button_fsdm")
    self.Label_huigu = TFDirector:getChildByPath(self.Button_fsdm,"Label_huigu")

    local panel_wish_item = TFDirector:getChildByPath(ui,"Panel_wish_item")
    self.Label_wish = TFDirector:getChildByPath(panel_wish_item,"Label_wish")
    self.Image_head = TFDirector:getChildByPath(panel_wish_item,"Image_head")
    self.Image_head_cover_frame = TFDirector:getChildByPath(panel_wish_item,"Image_head_cover_frame")

    self.cgIndex = 1

    local function circlePlayCg( )
        -- body
        if self.cgView then
            self.cgView:removeFromParent(true)
        end

        local cgId = self.cgIds[self.cgIndex]
        if not cgId then
            return
        end
        local cg_cfg = TabDataMgr:getData("Cg")[cgId]
        if not cg_cfg then
            return
        end
        local layer = requireNew("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil,false,function ()
            circlePlayCg( )
        end)

        local parentSize = self.Panel_cg:getSize()
        local scaleX = parentSize.width/layer:Size().width
        local scaleY = parentSize.height/layer:Size().height
        print("scale:",math.max(scaleX,scaleY))
        layer:setScale(math.max(scaleX,scaleY))


        dump(layer:Size())

        self.Panel_cg:addChild(layer)
        self.cgView = layer
        self.cgIndex = self.cgIndex%#self.cgIds + 1
    end

    if #self.cgIds > 1 then
        circlePlayCg( )
    end

    self.danmuId = Utils:getDanmuId(EC_DanmuType.Wish,"cg1")
    if self.danmuId then
        local pram = {
            parent = self.Panel_danmu,
            type = self.danmuId,
            autoRun = true,
            rowNum = 6,
        }
        self.danmuFrame = requireNew("lua.public.DanmuFrame"):new(pram) --Utils:createDanmuFrame(pram)

        TFDirector:send(c2s.CHAT_REQ_BULLET_INFO,{self.danmuId})
    end

    self:updateView()
end

function WishTree:updateView( ... )
    --self:initData(self.activityId)
    self:updateMyWish()
end

function WishTree:updateMyWish()
    local wishMyInfo,wishList = ActivityDataMgr2:getNewYearWishInfo()
    local isSend = wishMyInfo.time ~= 0
    local strId = isSend and 13205003 or 13205001
    self.Label_huigu:setTextById(strId)

    if wishMyInfo.context == "" then
        self.Label_wish:setTextById(13205002)
    else
        self.Label_wish:setText(wishMyInfo.context)
    end
    
    self.Image_head:setTexture(AvatarDataMgr:getSelfAvatarIconPath())
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath()
    self.Image_head_cover_frame:setTexture(avatarFrameIcon)
    if avatarFrameEffect ~= "" then
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
        if not self.HeadFrameEffect then
            self.HeadFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
            self.HeadFrameEffect:setAnchorPoint(ccp(0,0))
            self.HeadFrameEffect:setPosition(ccp(0,0))
            self.HeadFrameEffect:play("animation", true)
            self.Image_head_cover_frame:addChild(self.HeadFrameEffect, 1)
        end
    else
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
    end
end

function WishTree:onShow()
    self.super.onShow(self)
end

function WishTree:removeEvents( )
    self.super.removeEvents(self)
    self.danmuFrame:removeEvents()
end


function WishTree:registerEvents( )

    EventMgr:addEventListener(self, EV_FRIEND_WISH_LIST, handler(self.updateMyWish, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
        if self.activityId and self.activityId == activityId then
            Utils:showTips(14110403)
            AlertManager:closeLayer(self)
        end
    end)
    -- body
    self.Button_fsdm:onClick(function (  )
        if not self.danmuId then
            return
        end
        local codeTime = Utils:getKVP(81026,"barrageTime")
        local lastSendTime = DanmuDataMgr:getLastSendTimeByType(self.danmuId)
        local remandTime = lastSendTime - ServerDataMgr:getServerTime() + codeTime
        if remandTime > 0 then
            local day,hour, min, sec = Utils:getFuzzyDHMS(remandTime, true)
            Utils:showTips(14210173,hour, min, sec)
            return
        end
        Utils:openView("newYear.SendWishView",self.danmuId)
    end)

    self.Button_close:onClick(function ( ... )
        -- body
        AlertManager:closeLayer(self)
    end)

    self.Button_checkWish:onClick(function ( ... )
        --Utils:openView("newYear.FriendWishView")

        local view = requireNew("lua.logic.newYear.FriendWishView"):new()
        AlertManager:addLayer(view,AlertManager.BLOCK_CLOSE)
        AlertManager:show()
    end)

end

return WishTree