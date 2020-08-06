local RoomView = class("RoomView",BaseLayer)

function RoomView:initData(roomId,elvesNpc,isClick)
    roomId = roomId or RoleDataMgr:getRoleUseRoomId()
    print("roomId ",roomId)
    local roomData = RoleDataMgr:getRoleRoomInfoById(roomId)
    self.elvesNpc = elvesNpc
    self.roomUIName_ = roomData.roomUIName
    self.decorationsInfoList_ = roomData.decorationsInfoList
    self.decItemList_ ={}
    self.isClick = isClick
end

function RoomView:ctor(roomData,elvesNpc,isClick)
    self.super.ctor(self)

    self:initData(roomData,elvesNpc,isClick)

    local uiPath = string.format("lua.uiconfig.dating.%s",self.roomUIName_)
    self:init(uiPath)
end

function RoomView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self:initDecorations()
end

function RoomView:initDecorations()
    for i,v in ipairs(self.decorationsInfoList_) do
        local decData = v
        local decItem = TFDirector:getChildByPath(self.ui,decData.decUIName)
        print("decItem Size",decItem:Size())
        -- decItem:hide()
        -- local imgItem = TFImage:create(decItem:getTexture())
        -- imgItem:AnchorPoint(decItem:AnchorPoint())
        -- decItem:getParent():addChild(imgItem)
        -- imgItem:Pos(decItem:Pos())
        local effectIdList =  decData.effectIdList
        decItem.effectIdList = effectIdList
        table.insert(self.decItemList_,decItem)
    end
end

function RoomView:registerEvents()
    for i,v in ipairs(self.decItemList_) do
        local decItem = v
        decItem:Touchable(self.isClick)
        decItem:onClick(function()
            --点击间隔1秒
            if not decItem.lastTime or (os.time() - decItem.lastTime) > 1 then
                decItem.lastTime = os.time()
            else
                return
            end
            print("decItem.effectIdList ",decItem.effectIdList)
            for i,v in ipairs(decItem.effectIdList) do
                local effectId = v
                local decEffect = require("lua.logic.dating.DecorationsEffect"):new(decItem,effectId,self.elvesNpc)
                decEffect:play()
            end

            end)
    end
end

return RoomView