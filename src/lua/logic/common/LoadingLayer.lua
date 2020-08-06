--[[
    正品菊花
    前提：假设除战斗场景外，只能存在一个场景，即当前最多只能存在一个“非战斗”场景和一个“战斗场景，
    当不满足条件时，此类不可用

    --By: haidong.gan
    --2013/11/11
]]
local LoadingLayer = class("LoadingLayer", BaseLayer)

CREATE_PANEL_FUN(LoadingLayer)

local loading = nil

function LoadingLayer:ctor(data)
    self.strCfg = require("lua.table.String" ..GAME_LANGUAGE_VAR)
    self.super.ctor(self,data)
end

function LoadingLayer:setType(showType)
    local blockUI = TFPanel:create();
    blockUI:setSize(CCSize(30000,30000));
    blockUI:setPosition(ccp(-15000,-15000));
    blockUI:setTouchEnabled(true); 
    self:addLayer(blockUI);
    local index = 1
    local skillEff = nil;

    skillEff = SkeletonAnimation:create("effect/newLoading/effects_loading2")
    skillEff:setPosition(ccp(0, GameConfig.WS.height/2))

    blockUI:setBackGroundColorType(TF_LAYOUT_COLOR_SOLID);
    blockUI:setBackGroundColorOpacity(178);
    blockUI:setBackGroundColor(ccc3(  0,   0,   0));
    self.blockUI = blockUI;

    skillEff:setAnimationFps(GameConfig.ANIM_FPS)
    skillEff:playByIndex(0, -1, -1, 1)
    self:addChild(skillEff,2)

    local _currentScene = Public:currentScene()
    if _currentScene ~= nil and _currentScene.__cname ~= "LoginScene" then
        self.skillEff = skillEff:hide();
        self.blockUI:setBackGroundColorOpacity(0);
    end
    self:update();
end

function LoadingLayer:update()
    local _time = 0
    local function step(dt)
        _time = _time + dt;

        if not self.skillEff or not self.blockUI then
            TFDirector:removeTimer(self.Timer);
            return
        end

        if _time >= 1 then
            self.skillEff:show();
            self.blockUI:setBackGroundColorOpacity(178);
        end

        if _time >= 45 then
            TFDirector:removeTimer(self.Timer);
            toastMessageLink(self.strCfg[100000019].text);
            local _currentScene = Public:currentScene()
            if _currentScene ~= nil and _currentScene.getTopLayer and _currentScene.__cname == "LoginScene" then
                self:hide();
            else
                CommonManager:closeConnection2();
            end
        end
    end

    self.Timer = TFDirector:addTimer(0, -1, nil,step);
end

function LoadingLayer:initUI(ui)
	self.super.initUI(self,ui)
end

-- 每次c++调用onEnter之后调用
function LoadingLayer:onEnter()

end
-- 每次c++调用onExit之后调用
function LoadingLayer:onExit()
    self:clearForCuurentScene()
end

function LoadingLayer:removeUI()
	self.super.removeUI(self);
	self.img_loading = nil;
    TFDirector:removeTimer(self.Timer);
end

function LoadingLayer:show(showType)
    -- -- print("LoadingLayer:show");
    -- showType = showType or 1;
    -- if not LoadingLayer.loadingCount then
    --     LoadingLayer.loadingCount = 0;
    -- end

    -- local loading = LoadingLayer.loading;
    if not loading then

        LoadingLayer.loadingCount = 0;
        loading = LoadingLayer:new();
        loading:setZOrder(500);
        loading:setName("LoadingLayer");
        loading:setType(showType);
        loading:setPosition(ccp(GameConfig.WS.width/2, 0))
        local currentScene = Public:currentScene();
        dump(currentScene.__cname)
        if currentScene.__cname == "LoginScene" then
            currentScene:addLoadingLayer(loading);
        else
            currentScene:addLayer(loading);
        end
        loading.toScene = currentScene;
    end
    -- end

    -- if LoadingLayer.loadingCount == 0 then
    --     local currentScene = Public:currentScene();
    --     currentScene:addLayer(loading);
    --     loading.toScene = currentScene;
    -- end

    -- LoadingLayer.loadingCount = LoadingLayer.loadingCount + 1;
    -- LoadingLayer.loading = loading;
end

function LoadingLayer:clearForCuurentScene()
    if loading then
        if loading.toScene then
            if loading.toScene.__cname == "LoginScene" then
                loading:removeFromParent();
            else
                loading.toScene:removeLayer(loading);
            end
        end

        if not tolua.isnull(loading) then
            loading:removeFromParent();
        end

        loading = nil;
    end
end

return LoadingLayer;
