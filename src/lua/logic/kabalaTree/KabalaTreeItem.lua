local KabalaTreeItem = class("KabalaTreeItem")
function KabalaTreeItem:ctor()

end

--进入地图初始化元素
function KabalaTreeItem:initItem(Image_mapItem)

	self.tileMap = KabalaTreeDataMgr:getTileMap()
	self.Image_mapItem = Image_mapItem
	self.mapItem = {}
    self.KabalaTreeItemMap = KabalaTreeDataMgr:getKabalaTreeItemMap()
	for k,v in pairs(self.KabalaTreeItemMap) do 

        --如果是占领后的据点的特殊处理
        local strnghold = KabalaTreeDataMgr:getStronghold()
        if strnghold and v.pos.x == strnghold.x and v.pos.y == strnghold.y then
            v.res = "ui/kabalatree/event/floor_spot_1.png"
        end     
		self:createItem(v.pos,v.res,v.smallRes,v.offset,v.scaleInMap)
	end
end

--开地图新产生item
function KabalaTreeItem:spawnNewItem(tilePosMN,itemRes,smallRes,offset,scaleInMap)

	if not tilePosMN or not itemRes or not offset or not scaleInMap then
		return
	end
	self:createItem(tilePosMN,itemRes,smallRes,offset,scaleInMap)
end

function KabalaTreeItem:cleanItem(tilePosMN)

    if not self.mapItem then
        return
    end
	local item,index 
	for k,v in pairs(self.mapItem) do
		if v.pos.x == tilePosMN.x and tilePosMN.y == v.pos.y then
			item = v.item
			index = k
		end
	end
	if not item or not self.tileMap then
		return
	end

	local function acFun()
        item:removeFromParent()
        table.remove(self.mapItem,index)
        KabalaTreeDataMgr:removeKabalaTreeItem(tilePosMN)   
    end

	local seqact = Sequence:create({
        FadeOut:create(0.5),
        CallFunc:create(acFun)
    })
    item:runAction(seqact)

    local layer = self.tileMap:getLayer("Plain")
    local sprite = layer:getTileAt(tilePosMN)
    if not sprite then
    	return
    end
    local normalGid =  KabalaTreeDataMgr:getGroundLayerGid(EC_EventLayerGid.Tile_Normal)
    local action = Sequence:create({
        FadeOut:create(0.5),
        CallFunc:create(function()
        	layer:setTileGID(normalGid,tilePosMN)
        	sprite:runAction(FadeIn:create(0.5))
        end)
    })
    sprite:runAction(action)
end

function KabalaTreeItem:createItem(tilePosMN,itemRes,smallRes,offset,scaleInMap)

	if not self.tileMap or not offset or not smallRes then
        Box(itemRes..": Wrong offset")
		return
	end 

    local position = KabalaTreeDataMgr:convertToPos(tilePosMN.x,tilePosMN.y)
    position =  KabalaTreeDataMgr:convertToPosAR(position.x,position.y)

    for k,v in pairs(self.mapItem) do
        if v.pos.x == tilePosMN.x and tilePosMN.y == v.pos.y then
            return
        end
    end

    local Image_mapItem = self.Image_mapItem:clone()
    local offsetX = offset.x or 0
    local offsetY = offset.y or 0
    Image_mapItem:setPosition(ccp(position.x+offsetX,position.y+offsetY))
    Image_mapItem:setZOrder(1)
    scaleInMap = scaleInMap or 1.5
    Image_mapItem:setScale(scaleInMap)
    Image_mapItem:setOpacity(0)
    Image_mapItem:setTexture(itemRes)
    local seqact = Sequence:create({
        FadeIn:create(0.5),
        CallFunc:create(function ()
            local offsetY = 10
            local seqact = Sequence:create({
                MoveBy:create(0.5, ccp(0, offsetY)),
                MoveBy:create(0.5, ccp(0, -offsetY)),
            })
            Image_mapItem:runAction(RepeatForever:create(seqact))
        end)
    })
    Image_mapItem:runAction(seqact)
    self.tileMap:addChild(Image_mapItem)
	table.insert(self.mapItem,{pos = tilePosMN,item = Image_mapItem})

    local kabalaItem = KabalaTreeDataMgr:getKabalaTreeItem(tilePosMN)
    if not kabalaItem then
        KabalaTreeDataMgr:addKabalaTreeItem({pos = tilePosMN,res = itemRes,smallRes = smallRes,offset=offset,scaleInMap = scaleInMap})
    end
end

function KabalaTreeItem:updateItem(tilePosMN,titledType,itemRes)

    local item,index 
    for k,v in pairs(self.mapItem) do
        if v.pos.x == tilePosMN.x and tilePosMN.y == v.pos.y then
            item = v.item
            index = k
        end
    end

    if not item or not self.tileMap then
        return
    end

    local seqact = Sequence:create({
        FadeOut:create(0.5),
        CallFunc:create(function ()
            item:setTexture(itemRes)
            item:runAction(FadeIn:create(0.5))
        end)
    })
    item:runAction(seqact)

    local layer = self.tileMap:getLayer("Plain")
    local sprite = layer:getTileAt(tilePosMN)
    if not sprite then
        return
    end
    local titledGid =  KabalaTreeDataMgr:getGroundLayerGid(titledType)
    local action = Sequence:create({
        FadeOut:create(0.5),
        CallFunc:create(function()
            layer:setTileGID(titledGid,tilePosMN)
            sprite:runAction(FadeIn:create(0.5))
        end)
    })
    sprite:runAction(action)

end

return KabalaTreeItem