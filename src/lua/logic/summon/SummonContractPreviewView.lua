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
* -- 精灵召唤预览界面
]]

local SummonContractPreviewView = class("SummonContractPreviewView",BaseLayer)

function SummonContractPreviewView:ctor( data )
	self.super.ctor(self,data)
	self.summonCfg = data
	self:initData()
    self:init("lua.uiconfig.summon.summonContractPreviewVIew")
end

function SummonContractPreviewView:initData( ... )
    EventMgr:addEventListener(self, EV_FUBEN_UPDATE_LIMITHERO, handler(self.onLimitHeroEvent, self))
end


function SummonContractPreviewView:onLimitHeroEvent()
    local levelFormation =  FubenDataMgr:getLevelFormation(self.selectDungeonId)
    if not levelFormation then
    	self.selectDungeonId = nil
        return
    end

    local formationData_ = FubenDataMgr:getInitFormation(self.selectDungeonId)
    if formationData_ then
        HeroDataMgr:changeDataByFuben(self.selectDungeonId, formationData_)
    end

    local heros = {}
    for i, v in ipairs(formationData_) do
        table.insert(heros, {limitType = v.type, limitCid = v.id})
    end

    FubenDataMgr:setFormation(levelFormation)
    local battleController = require("lua.logic.battle.BattleController")
    battleController.enterBattle(
            {
                levelCid = self.selectDungeonId,
                limitHeros = heros,
                isDuelMod = false,
            },
            EC_BattleType.COMMON
    )
    self.selectDungeonId = nil
end

function SummonContractPreviewView:initUI( ui )
	self.super.initUI(self,ui)
	local image_1 = TFDirector:getChildByPath(ui,"image_1")
	local image_2 = TFDirector:getChildByPath(ui,"image_2")
	local button_sw1 = TFDirector:getChildByPath(ui,"button_sw1")
	local button_sw2 = TFDirector:getChildByPath(ui,"button_sw2")
	image_1:setTexture(self.summonCfg.image_l)
	image_2:setTexture(self.summonCfg.image_r)

	local function fight( dungeonId )
		if not self.selectDungeonId then
			local args = {
		        tittle = 2107025,
		        content = TextDataMgr:getText(2107037),
		        reType = EC_OneLoginStatusType.ReConfirm_NoobPractice,
		        confirmCall = function()
					self.selectDungeonId = dungeonId
		            FubenDataMgr:send_DUNGEON_LIMIT_HERO_DUNGEON(self.selectDungeonId)
		        end,
		    }
		    Utils:showReConfirm(args)
		end
	end
	button_sw1:onClick(function ( ... )
		fight(self.summonCfg.dungeonId1)
	end)

	button_sw2:onClick(function ( ... )
		fight(self.summonCfg.dungeonId2)
	end)
	image_1:onClick(function ( ... )
		image_1:setZOrder(4)
		image_2:setZOrder(2)
		button_sw1:setVisible(true)
		button_sw2:setVisible(false)
	end)

	image_2:onClick(function ( ... )
		image_2:setZOrder(4)
		image_1:setZOrder(2)
		button_sw2:setVisible(true)
		button_sw1:setVisible(false)
	end)
end

return SummonContractPreviewView