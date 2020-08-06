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
*
* 
]]

local MapActivityContainer = class("MapActivityContainer",BaseLayer)

-- controller function begin
 local titleCfg = {
            [6001] = {
                      icon = "ui/activity/charistmas_fight/005.png",
                      name = 2130038,
                      callFunc = function ( self )
                          -- body
                          Utils:openView("activity.ChristmasHangUpView")
                      end,
                      checkRedPoint = function ( self )
                          return self.activityInfo.factoryInfo and self.activityInfo.factoryInfo.count > 0 or false
                      end,
                    },
            [6002] = {
                      icon = "ui/activity/charistmas_fight/004.png",
                      name = 2130037,
                      callFunc = function ( self )
                          -- body 商店
                          -- Utils:openView("activity.ChristmasHangUpView")
                          FunctionDataMgr:jActivity(self.activityInfo.extendData.JumpShop)
                      end,
                      checkRedPoint = function ( self )
                          -- body
                      end,
                    }, 
            [6003] = {
                      icon = "ui/activity/charistmas_fight/003.png",
                      name = 2130036,
                      callFunc = function ( self )
                          -- body
                          Utils:openView("activity.ChristmasTaskView")
                      end,
                      checkRedPoint = function ( self )
                          if not self.activityInfo.dungeonInfo then return false end
                          local hasDungeonNotPass = false
                          for k,v in pairs(self.activityInfo.dungeonInfo.levels) do
                              if not v.pass then
                                  hasDungeonNotPass= true
                                  break
                              end
                          end
                          return hasDungeonNotPass
                      end,
                    }, 
            [6004] = {
                      icon = "ui/activity/charistmas_fight/002.png",
                      name = 2130035,
                      callFunc = function ( self )
                          -- body 圣诞节复刻活动
                          -- Utils:openView("activity.ChristmasTaskView")
                          Utils:openView("activity.ActivityEntrustView",self.activityInfo.extendData.JumpAct)
                      end,
                      checkRedPoint = function ( self )
                          -- body
                      end,
                    },
        }



function MapActivityContainer:update(dt)
    for k, v in pairs(self.shapes) do
       v:update(dt)
    end
end


function MapActivityContainer:reorderISOItem(  )
    -- body
    table.sort(self.shapes,function ( a, b )
      -- body
      if a:getPositionY() == b:getPositionY() then 
        return a:getPositionX() >  b:getPositionX() 
      end
      return a:getPositionY() > b:getPositionY()
    end)
    for k,v in pairs(self.shapes) do
        v:setZOrder(k)
    end
end

function MapActivityContainer:getMapInfo(  )
    -- body
    return self.cityMap
end

function MapActivityContainer:getRandomInterActPoints(  )
    -- body
end

function MapActivityContainer:lockInterActPoint(  )
    -- body
end

function MapActivityContainer:getMapRenderNode(id)
    id = tonumber(id)
    return self.cityMap.renderNodes[id]
end

function MapActivityContainer:parseCityMap()
    local mapPath = self.activityInfo.extendData.map
    self.cityMap = requireNew("lua.logic.newCity.MapParse"):new(mapPath)
    self.mapSize = self.cityMap.rect.size

    local restructPointData = function(tb)
        local ptb = {}
        local children = tb.children or {}
        for i, v in ipairs(children) do
            ptb[v.ID] = me.p(v.Position.X, v.Position.Y)
        end
        return ptb
    end
    self.basePointInfo = restructPointData(self.cityMap.visualNodes[5000])
    self.basePoint = clone(self.cityMap.visualNodes[5000].children) or {}
    self.titleIconPoint = restructPointData(self.cityMap.visualNodes[6000])


    local mapinfo = {}
    mapinfo.road = self:getMapRenderNode(3000)
    mapinfo.titleIcon = self:getMapRenderNode(6000)
    return self.cityMap:getMapNode(), mapinfo

end

function MapActivityContainer:getBaseMapPointPos(rand)
    local leftcount = #self.basePoint
    local randidx = math.random(1, leftcount)
    if leftcount > 0 and self.basePoint[randidx] then
        local randomp = self.basePoint[randidx]
        local pos = self.basePointInfo[randomp.ID]
        if not pos then
            --Box("路面生成点错误, 点id"..randomp.ID)
        end
        table.remove(self.basePoint, randidx)
        return pos
    end
    return me.p(0, 0)
end
-- controller function end

function MapActivityContainer:findPath(st, ed )
    -- body
    local path = {}
    path = self.cityMap:find(st, ed)
    return path
end

function MapActivityContainer:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:initData(...)
  self.titleNodes = {}
	self:init("lua.uiconfig.activity.mapActivityContainer")
end

function MapActivityContainer:initData( activityId )
    -- body
    self.activityId = activityId
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
end

function MapActivityContainer:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.ScrollView_map = TFDirector:getChildByPath(ui,"ScrollView_map")
	self.label_date = TFDirector:getChildByPath(ui,"label_date")
	self.Panel_BuildItem = TFDirector:getChildByPath(ui,"Panel_BuildItem")
	self:initMap()
	self:refreshView()
  self.label_date:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, self.activityInfo.extendData.dateStyle))

end

function MapActivityContainer:initMap()
	-- body 
	self.cityMapNode, self.foreMap = self:parseCityMap()
    local layer = TFPanel:create()
    layer:setSize(self.mapSize)
    layer:addChild(self.cityMapNode)
    self.ScrollView_map:setInnerContainerSize(self.mapSize)
    self.ScrollView_map:addChild(layer)
    self:initShape()
    self:initTitleState()
end

function MapActivityContainer:initShape()
    self.shapes = {}
    local roles = self.activityInfo.extendData.model or {410112,410113}
    for k, cityRoleId in pairs(roles) do
        local shape = self:createShape(cityRoleId)
        local pos = self:getBaseMapPointPos()
        shape:setScale(0.5)
        shape:setShapeBornPos(pos, 0)
        --shape:setShapeLevel(EC_NewCityLevel.NewCity_Fore)
        self.foreMap.road:addChild(shape)
        shape:awake()
        table.insert(self.shapes, shape)
    end
    self:reorderISOItem()
end

function MapActivityContainer:initTitleState()
    -- body
    for k,v in pairs(self.titleIconPoint) do
        if not self.titleNodes[k] then
            local titleItem= self.Panel_BuildItem:clone()
            titleItem:setPosition(v)
            self.foreMap.titleIcon:addChild(titleItem)
            self.titleNodes[k] = titleItem
        end

        self:updateTitleStatus(self.titleNodes[k], k)
    end
end

function MapActivityContainer:updateTitleStatus( item, key)
    -- body
   
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Label_name = TFDirector:getChildByPath(item,"Label_name")
    local Image_new = TFDirector:getChildByPath(item,"Image_new")

    Image_icon:setTexture(titleCfg[key].icon)
    item:setTouchEnabled(true)
    item:onClick(handler(titleCfg[key].callFunc,self))
    Image_new:setVisible(titleCfg[key].checkRedPoint(self))
    Label_name:setTextById(titleCfg[key].name)

end

function MapActivityContainer:createShape( id )
	local roleconf = clone(TabDataMgr:getData("CityRoleModel", id))
	local conf = {
	        path = roleconf.rolePath,
	        stype = EC_NewCityModelType.NewCity_Npc,
	        mid = 0,
	        rid = roleconf.modelId,
	        word = {normal = {}},
	        iconpos = roleconf.iconPos,
	        isflip = roleconf.flip,
            controller = self,
	    }
	local shape = requireNew("lua.logic.newCity.CityShape"):new(conf)
    shape:setClickEnabled(false)
	return shape

end

function MapActivityContainer:refreshView( ... )
	-- body
  self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)

  if not self.activityInfo then return end
  if not self.activityInfo.dungeonInfo then
    ActivityDataMgr2:request_CHRISTMAS_REQ2019_CHRISTMAS_DUNGEON()
  end

  if not self.activityInfo.factoryInfo then
    ActivityDataMgr2:request_CHRISTMAS_REQ2019_CHRISTMAS_FACTORY()
  end

  for k,v in pairs(self.titleNodes) do
      local Image_new = TFDirector:getChildByPath(v,"Image_new")
      Image_new:setVisible(titleCfg[k].checkRedPoint(self))
  end
end

function MapActivityContainer:registerEvents( ... )
    -- body
    self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
        self:refreshView()
    end)

end

function MapActivityContainer:onUpdateCountDownEvent(  )
  -- body
  if not self:isVisible() then return end
  self:update(1000)
end

return MapActivityContainer