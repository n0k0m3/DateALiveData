--[[
    弹框队列管理类

    --By: haidong.gan
    --2013/11/11
]]

--[[
--用法举例

toastMessage("baby");
toastMessage("baby",ccp(100, 100));

]]

function toastMessageHide(text,position,size)
    return toastMessage(text,position,size,ToastMessage.TYPE_SHOW_TO_HIDE)
end

function toastMessageUp(text,position,size)
    return toastMessage(text,position,size,ToastMessage.TYPE_MOVE_TO_UP)
end

--链接或网络问题时调用
function toastMessageLink(text,position)
    return toastMessage(text, position, nil, ToastMessage.TYPE_MOVE_TO_UP, nil, nil, true)
end

--[[解锁xxx时调用
  textFront 前置文本
  text 变色文本
  textBihand 后置文本
]]
function toastMessageUnlock(textFront, text, textBihand, showTime)
    local richParam= {
        [1] = {
            baseName = "MFYueHei_Noncommercial",
            name = "font/fangzheng_zhunyuan.ttf",
            color = "#FFFFFF",
            text = "%s ",
            clickId = "",
            size = 20,
        },
        [2] = {
            baseName = "MFYueHei_Noncommercial",
            name = "font/fangzheng_zhunyuan.ttf",
            color = "#62ff78",
            text = "%s",
            clickId = "",
            size = 20,
        },
        [3] = {
            baseName = "MFYueHei_Noncommercial",
            name = "font/fangzheng_zhunyuan.ttf",
            color = "#FFFFFF",
            text = " %s",
            clickId = "",
            size = 20,
        },
        align = "center",
    }
    local newText = TextDataMgr:getFormatText(richParam, textFront or "", text, textBihand or "")
    return toastMessage(newText, nil, nil, ToastMessage.TYPE_MOVE_TO_UP, nil, showTime, nil, true)
end

function toastMessage(text,position,size,showType,isAdd, showTime, isLinkMsg, textColor)

    if isAdd == nil then
        isAdd = false;
    end

    local currentScene = Public:currentScene();
    local toastMessageLayer = currentScene:getChildByName("ToastMessage");

    if not toastMessageLayer or (showType and toastMessageLayer.showType ~= showType) or isAdd then
        toastMessageLayer = ToastMessage:new("lua.uiconfig.common.ToastMessage",showType, nil, showTime);
    else
        toastMessageLayer:setVisible(false);
        toastMessageLayer:stopAllActions();
        toastMessageLayer:setName("ToastMessage_old")
        currentScene:removeLayer(toastMessageLayer)
        toastMessageLayer = ToastMessage:new("lua.uiconfig.common.ToastMessage",showType, nil, showTime);
    end


    if not position then
        position = ToastMessage.DEFUALT_POSITION
    end

    if currentScene.__cname == "PhoneScene" then
        local winSize = me.Director:getVisibleSize()
        position = ccp(winSize.width/2,winSize.height/2)
    end

    toastMessageLayer:setPosition(position);
    local message_icon = TFDirector:getChildByPath(toastMessageLayer, 'Image_ToastMessage_icon')
    local text_label = TFDirector:getChildByPath(toastMessageLayer, 'text')
    text_label:setText(text);
    text_label:setFontSize(28);
    if isLinkMsg then
        message_icon:setTexture("ui/common/tips_icon.png")
    elseif textColor then
        message_icon:setTexture("ui/common/tips_icon_unlock.png")
        text_label:setTextEx(text, true)
        text_label:setFontSize(20)
    else
        message_icon:setTexture("ui/common/tips_icon_normal.png")
    end

   -- local bgImg = TFDirector:getChildByPath(toastMessageLayer, 'bg');
   -- bgImg:setSize(ccs(math.max(math.min(bgImg:getSize().width * string.utf8len(text)/20, bgImg:getSize().width),400)  ,bgImg:getSize().height))

   --  if size then
   --     bgImg:setSize(size);
   --  end

    toastMessageLayer:beginToast();
    return toastMessageLayer;

end


local ToastMessage = class("ToastMessage", BaseLayer)
ToastMessage.TYPE_MOVE_TO_UP   = 0;
ToastMessage.TYPE_SHOW_TO_HIDE = 1;

ToastMessage.LAYER_TYPE_PATH   = 0;
ToastMessage.LAYER_TYPE_LAYER  = 1;

ToastMessage.DEFUALT_POSITION  = ccp(GameConfig.WS.width/2, GameConfig.WS.height/2 - 80);

function ToastMessage:ctor(data,showType,layerType, showTime)
    self.super.ctor(self)

    self.showType = showType or ToastMessage.TYPE_MOVE_TO_UP;

    layerType = layerType or ToastMessage.LAYER_TYPE_PATH;
    if layerType == ToastMessage.LAYER_TYPE_PATH then
        self:init(data)
    end

    if layerType == ToastMessage.LAYER_TYPE_LAYER then
        self:addLayer(data);
    end
    self.showTime = showTime
end

function ToastMessage:onExit()
    self.super.onExit(self)
    local currentScene = self:getParent();
    if currentScene.__cname == "LoginScene" then
        self:removeFromParent();
    else
        currentScene:removeLayer(self);
    end
end

function ToastMessage:ctorLayer(layer,showType)
    self.super.ctor(self)
    self.showType=showType;

end

function ToastMessage:initUI(ui)
    self.super.initUI(self,ui);
end

function ToastMessage:beginToast()
    local currentScene = Public:currentScene();
    self:setName("ToastMessage");

    if not self:getParent() then
        if currentScene.__cname == "LoginScene" then
            currentScene:addCustomLayer(self)
        else
            currentScene:addLayer(self);
        end
    end
    self:setZOrder(500);
    local toY = self:getPosition().y + 80;
    local toX = self:getPosition().x;

    if toY > GameConfig.WS.height - 50 then
       toY = GameConfig.WS.height - 50;
    end

    self:setOpacity(150)

    if self.showType == ToastMessage.TYPE_MOVE_TO_UP then
        self.toastTween = {
          target = self,
          {
            duration = 0.1,
            x = toX,
            y = toY,
            alpha = 0.9,
          },
          {
            duration = 0.05,
            y = toY +2,
          },
          {
            duration = 0.05,
            y = toY -1,
          },
          {
             duration = 0.1,
             alpha = 1,
          },
          {
            duration = 0,
            delay = self.showTime or 1
          },
          {
            duration = 0.1,
            y = toY - 4,
            alpha = 0.7,
          },
          {
            duration = 0.1,
            y = toY + 2,

          },
          {
             duration = 0,

          },
          {
             duration = 0.1,
             alpha = 0,
             y = toY + 100,
          },
          {
            duration = 0,
            onComplete = function()
                local currentScene = Public:currentScene();
                if currentScene.__cname == "LoginScene" then
                    self:removeFromParent();
                else
                    currentScene:removeLayer(self);
                end
           end
          }
        }
    end

    if self.showType == ToastMessage.TYPE_SHOW_TO_HIDE then
        self.toastTween = {
          target = self,
          {
            duration = 0,
            delay = self.showTime or 2
          },
          {
             duration = 1,
             alpha = 0.2,
          },
          {
            duration = 0,
            onComplete = function()
                local currentScene = Public:currentScene();
                if currentScene.__cname == "LoginScene" then
                    self:removeFromParent();
                else
                    currentScene:removeLayer(self);
                end
           end
          }
        }
    end

    TFDirector:toTween(self.toastTween)
end

function ToastMessage:removeUI()
    self.super.removeUI(self)
    TFDirector:killTween(self.toastTween)
    self.toastTween = nil;
    self.showType=nil;
end


function ToastMessage:showSureMessage( msg , okhandle , cancelhandle )
    local layer = require('lua.logic.common.OperateSure'):new()
    layer:setType( nil )
    if msg then
        layer:setMsg( msg )
    end
    layer:setBtnHandle(okhandle , cancelhandle )
    AlertManager:addLayer(layer)
    AlertManager:show()

    return layer;
end
return ToastMessage;
