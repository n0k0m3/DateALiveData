--[[
    公共方法

    --By: haidong.gan
    --2013/11/11
]]
local Public = {}

local yueyu_id = "314|301|288|217|211|105|221|143|198|133|132|118|129|199|168|182|288"

function showLongLoading(isReconect)
    LoadingLayer:show(2);
end

function showLoading(isReconect)
    LoadingLayer:show();
end

function hideAllLoading()
    LoadingLayer:clearForCuurentScene()
end

function hideLoading()
    hideAllLoading();
end

function createUIByLuaNew(uiPath)
    --添加多语言ui文件读取
    local language = GAME_LANGUAGE_VAR
    if language ~= ""then
        uiPath = string.gsub(uiPath , 'uiconfig' , 'uiconfig'..language)
    end
    if me.platform == "win32" then
        TFDirector:unRequire(uiPath);
    end
    return createUIByLua(uiPath);
end

function requireNew(uiPath)
    local unRequireTable = {
        "lua.logic.activity.ActivityMainView",
        "lua.logic.fuben.FubenTheaterLevelView",
        "TFFramework.luacomponents.common.TFMultiTouchPanel",
    }
    if me.platform == "win32" or table.find(unRequireTable,uiPath) ~= -1 then
        TFDirector:unRequire(uiPath);
    end
    return require(uiPath);
end

function Public:currentScene()
    local currentScene = nil;
    if me.Director.getNextScene then
        currentScene = me.Director:getNextScene();
    end
    if not currentScene then
        currentScene = me.Director:getRunningScene();
    end
    return currentScene;
end


function Public:bindScrollFun(scrollView)

    function scrollView:bindScrollArrow(ui)
        local img_arrow_left        = TFDirector:getChildByPath(ui, 'img_arrow_left');
        local img_arrow_right       = TFDirector:getChildByPath(ui, 'img_arrow_right');
        local img_arrow_top         = TFDirector:getChildByPath(ui, 'img_arrow_top');
        local img_arrow_bottom      = TFDirector:getChildByPath(ui, 'img_arrow_bottom');

        if img_arrow_left then
            img_arrow_left:setVisible(false);
        end
        if img_arrow_right then
            img_arrow_right:setVisible(false);
        end
        if img_arrow_top then
            img_arrow_top:setVisible(false);
        end
        if img_arrow_bottom then
            img_arrow_bottom:setVisible(false);
        end

        local onUpdated = function(event)
            if img_arrow_left and img_arrow_right then
                local scrollViewWidth = (self.getTableViewSize and self:getTableViewSize().width) or self:getContentSize().width;
                local innerContainerWidth = (self.getInnerContainerSize and self:getInnerContainerSize().width) or self:getContentSize().width;
                local contentOffset = self:getContentOffset();

                if contentOffset.x > - 100 then
                    img_arrow_right:setVisible(false);
                else
                    img_arrow_right:setVisible(true);
                end

                if contentOffset.x < scrollViewWidth - innerContainerWidth + 100 then
                    img_arrow_left:setVisible(false);
                else
                    img_arrow_left:setVisible(true);
                end
            end

            if img_arrow_top and img_arrow_bottom then
                local scrollViewHeight =(self.getTableViewSize and self:getTableViewSize().height) or self:getContentSize().height;
                local innerContainerHeight = (self.getInnerContainerSize and self:getInnerContainerSize().height) or self:getContentSize().height;

                local contentOffset = self:getContentOffset();

                if contentOffset.y > - 100 then
                    img_arrow_top:setVisible(false);
                else
                    img_arrow_top:setVisible(true);
                end

                if contentOffset.y < scrollViewHeight - innerContainerHeight + 100 then
                    img_arrow_bottom:setVisible(false);
                else
                    img_arrow_bottom:setVisible(true);
                end
            end
        end;
        self.arrowIimer = TFDirector:addTimer(0.3, -1, nil, onUpdated);
    end


    function scrollView:cancelScrollArrow()
        TFDirector:removeTimer(self.arrowIimer);
        self.onUpdated = nil;
    end


    --使某个位置，按X居中
    function scrollView:setInnerContainerSizeForHeight(height)
        local innerContainerSizeForHeight = height
        self:setInnerContainerSize(CCSizeMake(self:getInnerContainerSize().width,innerContainerSizeForHeight));

        local offsetY = self:getSize().height - height;
        if offsetY > 0 then
            local childrenArr = self:getChildren();
            for i=0,childrenArr:count()-1 do
                local child = childrenArr:objectAtIndex(i);
                child:setPosition(ccp(child:getPosition().x, child:getPosition().y + offsetY));
            end
        end
    end

    --使某个位置，按X居中
    function scrollView:scrollToCenterForPositionX(forPositionX, dt)
        dt = dt or 0;
        local scrollViewWidth = (self.getTableViewSize and self:getTableViewSize().width) or self:getContentSize().width;
        local innerContainerWidth = (self.getInnerContainerSize and self:getInnerContainerSize().width) or self:getContentSize().width;

        --置左
        if(innerContainerWidth < scrollViewWidth) then
            self:setContentOffset(ccp(0, 0),dt);

            --底部1/2以下
        elseif forPositionX < scrollViewWidth/2 then
            self:setContentOffset(ccp(0, 0),dt);
        else
            local pt = math.max(scrollViewWidth/2 - forPositionX , scrollViewWidth - innerContainerWidth);
            self:setContentOffset(ccp(pt,0), dt);
        end
    end

    --使某个位置，按Y居中
    function scrollView:scrollToCenterForPositionY(forPositionY, dt)
        dt = dt or 0;
        local scrollViewHeight =(self.getTableViewSize and self:getTableViewSize().height) or self:getContentSize().height;
        local innerContainerHeight = (self.getInnerContainerSize and self:getInnerContainerSize().height) or self:getContentSize().height;

        --置顶
        if(innerContainerHeight < scrollViewHeight) then
            self:setContentOffset(ccp(0, scrollViewHeight - innerContainerHeight), dt);
            --底部1/2以下
        elseif forPositionY < scrollViewHeight/2 then
            self:setContentOffset(ccp(0, 0), dt);
        else
            local pt = math.max(scrollViewHeight/2 - forPositionY,scrollViewHeight - innerContainerHeight);
            self:setContentOffset(ccp(0, pt), dt);
        end
    end

    --纵向，滚动到最后一条
    function scrollView:scrollToYLast(dt)
        dt = dt or 0;
        local scrollViewHeight = (self.getTableViewSize and self:getTableViewSize().height) or self:getContentSize().height;
        local innerContainerHeight = (self.getInnerContainerSize and self:getInnerContainerSize().height) or self:getContentSize().height;

        if(innerContainerHeight < scrollViewHeight) then
            self:setContentOffset(ccp(0, scrollViewHeight-innerContainerHeight), dt);
        else
            self:setContentOffset(ccp(0, 0), dt);
        end
    end

    --纵向，滚动到第一条
    function scrollView:scrollToYTop(dt)
        dt = dt or 0;
        local scrollViewHeight = (self.getTableViewSize and self:getTableViewSize().height) or  self:getContentSize().height;
        local innerContainerHeight = (self.getInnerContainerSize and self:getInnerContainerSize().height) or self:getContentSize().height;

        self:setContentOffset(ccp(0, scrollViewHeight-innerContainerHeight), dt);
    end

    --横向，滚动到最后一条
    function scrollView:scrollToXLast(dt)
        dt = dt or 0;
        local scrollViewWidth = (self.getTableViewSize and self:getTableViewSize().width) or self:getContentSize().width;
        local innerContainerWidth = (self.getInnerContainerSize and self:getInnerContainerSize().width) or self:getContentSize().width;

        if innerContainerWidth < scrollViewWidth then
            self:setContentOffset(ccp(0, 0), dt);
        else
            self:setContentOffset(ccp(scrollViewWidth-innerContainerWidth, 0), dt);
        end
    end

    --横向，滚动到第一条
    function scrollView:scrollToXTop(dt)
        dt = dt or 0;
        local scrollViewWidth = (self.getTableViewSize and self:getTableViewSize().width) or self:getContentSize().width;
        local innerContainerWidth = (self.getInnerContainerSize and self:getInnerContainerSize().width) or self:getContentSize().width;

        self:setContentOffset(ccp(0, 0), dt);
    end


    --纵向，滚动的百分比
    function scrollView:getScrollYPercent()
        local contentOffset = self:getContentOffset();
        local innerContainerHeight = (self.getInnerContainerSize and self:getInnerContainerSize().height) or self:getContentSize().height;
        local percent = contentOffset.y/innerContainerHeight*(-1)
        percent = percent <= 1 and percent or 1
        return math.floor(percent*100)
    end
    --横向，滚动的百分比
    function scrollView:getScrollXPercent()
        local contentOffset = self:getContentOffset();
        local innerContainerWidth = (self.getInnerContainerSize and self:getInnerContainerSize().width) or self:getContentSize().width;
        local percent = contentOffset.x/innerContainerWidth*(-1)
        percent = percent <= 1 and percent or 1
        return math.floor(percent*100)
    end
end

--字符串拆分单个字符
function Public:stringSplit(str)
    local list = {}
    local len = string.len(str)
    local i = 1
    while i <= len do
        local c = string.byte(str, i)
        local shift = 1
        if c > 0 and c <= 127 then
            shift = 1
        elseif (c >= 192 and c <= 223) then
            shift = 2
        elseif (c >= 224 and c <= 239) then
            shift = 3
        elseif (c >= 240 and c <= 247) then
            shift = 4
        end
        local char = string.sub(str, i, i+shift-1)
        i = i + shift
        table.insert(list, char)
    end
    return list, len
end

function Public:BlinkAction(node)

    if not node:isVisible() then
        return;
    end

    local tween =
        {
            target = node,
            repeated = -1,
            {
                duration = 1,
                alpha    = 0,
            },

            {
                duration = 1,
                alpha    = 1,
            },
        }
    TFDirector:toTween(tween)
end

function Public:checkSpecialCharacters(input)
    local bl_out_limit = false;
    local len  = string.len(input)
    local left = len
    local cnt  = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = string.byte(input, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        --超出汉字字节
        if i >= 3 then
            bl_out_limit = true;
            break;
        end

        --不是汉字
        if i ~= 3 then
            if not(tmp >= 48 and tmp <=57) and --数字
                not(tmp >= 65 and tmp <= 90) and -- 字母
                not(tmp >= 97 and tmp <= 122) --字母
            then
                bl_out_limit = true;
                break;
            end
        end

        cnt = cnt + 1
    end

    if bl_out_limit then
        return bl_out_limit
    end

    local newLen = 0;
    for m in string.gmatch(input,"[%z\48-\57\61-\126\226-\233][\128-\191]*") do
        newLen = newLen + 1;
    end

    if newLen ~= cnt then
        bl_out_limit = true;
    end

    return bl_out_limit;
end

function audioClickfun(fun,effectFun,self)
    return function( sender )
        --effectFun = effectFun or play_press;
        -- effectFun();
        if self then
            fun(self,sender)
        else
            fun(sender);
        end
    end
end

return Public;
