if ENABLE_DEBUG_FOR_AUTO_TEST then 
    local cmds = {}
    cmds.isLoading = false

    function __Console_CMD_Func(args) 
        args = string.split(args, "%s", false)

        print("__Console_CMD_Func:", args)

        local cmdName = args[1]
        table.remove(args, 1)

        --发送协议 需要转换字符串变为对应变量
        if cmdName == "send_protocol" then
            local argsStr = ""
            for k, v in ipairs(args) do
                -- v = cmds.unserialize(v)
                argsStr = argsStr .. v 
                if k ~= #args then
                   argsStr = argsStr .. ","
                end
            end
            print("cmds[send_protocol](".. argsStr ..")")
            local func = loadstring("me.console['send_protocol'](".. argsStr ..")")
            if func == nil then
                print("error")
                return                 
            end
            return func()
        elseif cmdName == "listen_protocol" then
            args[1] = cmds.unserialize(args[1])
        end


        if cmds[cmdName] then 
            return cmds[cmdName](args) or "not init"
        end

        return "not init"
    end

    function getVisibleReverse(node)
        if not node:isVisible() then
            return false
        end

        while node.getParent and node:getParent() do
            node = node:getParent()
            if not node:isVisible() then
                return false
            end
        end

        return true
    end

    function cmds.find_ele(args)
        local scene = me.Director:getRunningScene()
        name = args[1]

        local node = scene:getChildByNameReverse(name)
        if not node then
            return "Error"
        end
        
        local nodes = node:getChildren()
        local ret = ""
        if nodes == nil then
            return "Error"
        end

        for i=0,nodes:count()-1 do
            local nodeTemp = nodes:objectAtIndex(i);

            if nodeTemp == nil then            
                return "Error"
            end

            if i > 0 then
                ret  = ret .. "$"
            end

            local name = nodeTemp:getName()
            local size = nodeTemp:getSize()
            local pos 
            if nodeTemp:getDescription() == "TFButton" then
                pos = nodeTemp:convertToWorldSpace(ccp((0.5 - nodeTemp:getAnchorPoint().x) * size.width / 2, (0.5 - nodeTemp:getAnchorPoint().y) * size.height / 2))
            else
                pos = nodeTemp:convertToWorldSpace(ccp(size.width / 2, size.height / 2))
            end

            if nodeTemp:getDescription() == "TFButton" then
                local lbs = nodeTemp:getChildrenWithType("Label")
                local texture = nodeTemp:getTextureNormalName()
                local text = "None"
                if #lbs > 0 then 
                    text = lbs[1]:getString()
                    text = text == "" and "None" or text
                end

                ret = ret .. string.format("%s|%s|%s|%d,%d|%d,%d|%s|%s", "btn", name, tostring(getVisibleReverse(nodeTemp)), math.floor(pos.x), math.floor(pos.y), 
                        math.floor(size.width), math.floor(size.height), text, texture)
            elseif nodeTemp:getDescription()["-5:"] == "Label" or nodeTemp:getDescription()["-11:"] == "LabelBMFont" then
                local text = ""
                if nodeTemp.getText then
                    text = nodeTemp:getText()
                elseif nodeTemp.getString then
                    text = nodeTemp:getString()
                else 
                    return "Error"
                end
                text = text == "" and "None" or text

                ret = ret .. string.format("%s|%s|%s|%d,%d|%d,%d|%s", "text", name, tostring(getVisibleReverse(nodeTemp)), math.floor(pos.x), math.floor(pos.y), 
                        math.floor(size.width), math.floor(size.height), text)
            elseif nodeTemp:getDescription() == "TFImage" then
                local texture = "None"
                if nodeTemp:getTexture() then 
                    texture = nodeTemp:getTexture():getPath()
                    texture = texture == "" and "None" or texture
                end

                ret = ret .. string.format("%s|%s|%s|%d,%d|%d,%d|%s", "pic", name, tostring(getVisibleReverse(nodeTemp)), math.floor(pos.x), math.floor(pos.y), 
                        math.floor(size.width), math.floor(size.height), texture)
            elseif nodeTemp:getDescription() == "TFPanel" then
                ret = ret .. string.format("%s|%s", "panel", name)
            else                
                if nodeTemp.getDescription and nodeTemp:getDescription() then
                    ret = ret .. string.format("%s|%s", nodeTemp:getDescription(), name)
                end
            end
        end

        return ret
    end

    function cmds.get_button(args)
        local scene = me.Director:getRunningScene()
        local name = args[1]

        local btn = scene:getChildByNameReverse(name)
        if not btn or btn:getDescription() ~= "TFButton" then 
            return "Error"
        end

        local size = btn:getSize()
        local lbs = btn:getChildrenWithType("Label")
        local texture = btn:getTextureNormalName()
        local pos = btn:convertToWorldSpace(ccp((0.5 - btn:getAnchorPoint().x) * size.width / 2, (0.5 - btn:getAnchorPoint().y) * size.height / 2))

        local text = "None"
        if #lbs > 0 then 
            text = lbs[1]:getString()
            text = text == "" and "None" or text
        end

        if texture == "" then 
            texture = "None"
        end

        local ret = string.format("%s|%s|%d,%d|%d,%d|%s|%s", name, tostring(getVisibleReverse(btn)), math.floor(pos.x), math.floor(pos.y), 
                        math.floor(size.width), math.floor(size.height), text, texture)
        return ret
    end

    function cmds.get_text(args)
        local scene = me.Director:getRunningScene()
        local name = args[1]

        local label = scene:getChildByNameReverse(name)
        if not label or (label:getDescription()["-5:"] ~= "Label" and label:getDescription()["-11:"] ~= "LabelBMFont") then 
            return "Error"
        end
        
        local size = label:getSize()
        local pos = label:convertToWorldSpace(ccp(size.width / 2, size.height / 2)) 

        local text = label:getText()
        text = text == "" and "None" or text

        local ret = string.format("%s|%s|%d,%d|%d,%d|%s", name, tostring(getVisibleReverse(label)), math.floor(pos.x), math.floor(pos.y), 
                        math.floor(size.width), math.floor(size.height), text)
        return ret
    end

    function cmds.get_pic(args)
        local scene = me.Director:getRunningScene()
        local name = args[1]

        local img = scene:getChildByNameReverse(name)
        if not img or img:getDescription() ~= "TFImage" then 
            return "Error"
        end

        local size = img:getSize()
        local pos = img:convertToWorldSpace(ccp(size.width / 2, size.height / 2)) 

        local texture = "None"
        if img:getTexture() then 
            texture = img:getTexture():getPath()
            texture = texture == "" and "None" or texture
        end

        local ret = string.format("%s|%s|%d,%d|%d,%d|%s", name, tostring(getVisibleReverse(img)), math.floor(pos.x), math.floor(pos.y), 
                        math.floor(size.width), math.floor(size.height), texture)
        return ret
    end

        function cmds.get_pic(args)
        local scene = me.Director:getRunningScene()
        local name = args[1]

        local img = scene:getChildByNameReverse(name)
        if not img or img:getDescription() ~= "TFImage" then 
            return "Error"
        end

        local size = img:getSize()
        local pos = img:convertToWorldSpace(ccp(size.width / 2, size.height / 2)) 

        local texture = "None"
        if img:getTexture() then 
            texture = img:getTexture():getPath()
            texture = texture == "" and "None" or texture
        end

        local ret = string.format("%s|%s|%d,%d|%d,%d|%s", name, tostring(getVisibleReverse(img)), math.floor(pos.x), math.floor(pos.y), 
                        math.floor(size.width), math.floor(size.height), texture)
        return ret
    end

    function cmds.get_input(args)
        local scene = me.Director:getRunningScene()
        local name = args[1]

        local label = scene:getChildByNameReverse(name)
        if not label or label:getDescription() ~= "TFTextField" then 
            return "Error"
        end

        local size = label:getSize()
        local pos = label:convertToWorldSpace(ccp(size.width / 2, size.height / 2)) 

        local text = label:getText()
        text = text == "" and "None" or text
        local ret = string.format("%s|%s|%d,%d|%d,%d|%s", name, tostring(getVisibleReverse(label)), math.floor(pos.x), math.floor(pos.y), 
                        math.floor(size.width), math.floor(size.height), text)
        return ret
    end


    function cmds.get_topLayer()
        local scene = me.Director:getRunningScene()
        local layer = AlertManager:getTopLayer()

        local layerName = "unknow"
        local sceneName = "unknow"
        if layer ~= nil then
            layerName = layer.__cname
        end

        if scene ~= nil then
            sceneName = scene.__cname
        end

        local ret = string.format("%s|%s", sceneName ,layerName)
        return ret
    end

    function cmds.is_loading()
        return(tostring(cmds.isLoading))
    end


    function cmds.input_string_to(args)
        local scene = me.Director:getRunningScene()
        local name = args[1]
        local content = args[2]

        local input = scene:getChildByNameReverse(name)
        if not input or input:getDescription() ~= "TFTextField" then 
            return "Error"
        end

        
        input:setText(content)
        return string.format("%s|%s,success", name, content)
    end

    function cmds.restart()
        -- 关闭游戏网络连接
		-- TFDirector:dispatchGlobalEventWith("Engine_Will_Restart", {})
        if MainPlayer and AlertManager and CommonManager then
            MainPlayer:reset()
            AlertManager:clearAllCache()
            CommonManager:closeConnection()
            restartLuaEngine("");
            return "restart success"
        else
            return "Error"
        end

		
    end

    function cmds.sendMiji(args)
        local count = #args
        local content = args[1]
        for i = 2, count do
            content = content .. " "  .. args[i]
        end
        
        if ChatManager then
            local Msg = {
                1,
                content,
                NULL,
                0,
            }

            ChatManager:send(Msg)
            return "sendMiji Success"
        else
            return "Error"
        end
    end

    local touchQueue = {count = 0, index = 1, lastIndex = 1}
    local TOUCH_TYPE = {
        DOWN = 1,
        UP = 2,
        MOVE = 3,
        HOLD = 4,
    } 

    function touchQueue:pushback(pos, type)
        -- local ret = {pos,type}
        -- self[#self + 1] = ret
        -- return ret 

        if self.count > 9000 then
            toastMessage("点击超过90%存储了")
        end
        self[self.lastIndex] = {pos,type}
        self.lastIndex = self.lastIndex + 1

        self.count = self.count + 1

        if self.lastIndex > 10000 then
            self.lastIndex = 1
        end

    end

    function touchQueue:pop()
        -- local ret = self[1]
        -- if ret == nil then
        --     return nil
        -- end
        -- if #self > 0 then 
        --     table.remove(self, 1)
        -- end

        if self.count <= 0 then
            return nil
        end
        if self.index > 10000 then  
            self.index = 1
        end

        local ret = self[self.index]
        self.index = self.index + 1
        self.count = self.count - 1
        return ret            
    end

    function __Console_UpdateTouchEvent_Func()    
        local touch = touchQueue:pop()
        if touch == nil then
            return
        end

        local pos = touch[1]
        if touch[2] == TOUCH_TYPE.DOWN then
            TFConsole:touchDown(pos.x, pos.y)
            return "touch_down:" .. pos.x .. "," ..  pos.y
        elseif touch[2] == TOUCH_TYPE.UP then
            TFConsole:touchUp(pos.x, pos.y) 
            return "touch_up:" .. pos.x .. "," ..  pos.y
        elseif touch[2] == TOUCH_TYPE.MOVE then
            TFConsole:touchMove(pos.x, pos.y)
            return "touch_move:" .. pos.x .. "," ..  pos.y
        elseif touch[2] == TOUCH_TYPE.HOLD then
            return "touch_hold:" .. pos.x .. "," ..  pos.y
        end 
    end

    function cmds.click(args)
        local scene = me.Director:getRunningScene()
        local name = args[1]

        local node = scene:getChildByNameReverse(name)
        if not node then 
            return "Error"
        end


        local size = node:getSize()
        local pos
        if node:getDescription() == "TFButton" then
            pos = node:convertToWorldSpace(ccp((0.5 - node:getAnchorPoint().x) * size.width / 2, (0.5 - node:getAnchorPoint().y) * size.height / 2))
        else
            pos = node:convertToWorldSpace(ccp(size.width / 2, size.height / 2))
        end

        touchQueue:pushback(pos, TOUCH_TYPE.DOWN)
        touchQueue:pushback(pos, TOUCH_TYPE.UP)
    end

    function cmds.click_pos(args)
        local pos = ccp(args[1], args[2])

        touchQueue:pushback(pos, TOUCH_TYPE.DOWN)
        touchQueue:pushback(pos, TOUCH_TYPE.UP)
    end


    function cmds.swipe(args)
        local scene = me.Director:getRunningScene()
        local name = args[1]

        local node = scene:getChildByNameReverse(name)
        if not node then 
            return "Error"
        end

        local size = node:getSize()
        local pos = node:convertToWorldSpace(ccp(size.width / 2, size.height / 2)) 
        local desPos = ccp(args[2], args[3])
        touchQueue:pushback(pos, TOUCH_TYPE.DOWN)

        --1秒10次 
        local totalCount = args[4] * 10
        local disX = (desPos.x - pos.x) / totalCount
        local disY = (desPos.y - pos.y) / totalCount

        for i = 1, totalCount do
            local posTemp = ccp(pos.x + disX * i, pos.y + disY * i)
            touchQueue:pushback(posTemp, TOUCH_TYPE.MOVE)
        end 

        --目标停留一秒 防止惯性移动
        for i = 1, 10 do
            touchQueue:pushback(desPos, TOUCH_TYPE.MOVE)
        end

        touchQueue:pushback(desPos, TOUCH_TYPE.UP)
    end

    function cmds.swipe_pos(args)
        local srcPos = ccp(args[1], args[2])
        local desPos = ccp(args[3], args[4])

        touchQueue:pushback(srcPos, TOUCH_TYPE.DOWN)
        --1秒10次 
        local totalCount = args[5] * 10
        local disX = (desPos.x - srcPos.x) / totalCount
        local disY = (desPos.y - srcPos.y) / totalCount
        for i = 1, totalCount do
            local posTemp = ccp(srcPos.x + disX * i, srcPos.y + disY * i)
            touchQueue:pushback(posTemp, TOUCH_TYPE.MOVE)
        end 

        --目标停留一秒 防止惯性移动
        for i = 1, 10 do
            touchQueue:pushback(desPos, TOUCH_TYPE.MOVE)
        end
        touchQueue:pushback(desPos, TOUCH_TYPE.UP)
    end


    function cmds.long_press(args)
        local scene = me.Director:getRunningScene()
        local name = args[1]

        local node = scene:getChildByNameReverse(name)
        if not node then 
            return "Error"
        end

        local size = node:getSize()
        local pos = node:convertToWorldSpace(ccp(size.width / 2, size.height / 2)) 

        local holdTime = args[2] * 10
        touchQueue:pushback(pos, TOUCH_TYPE.DOWN)
        for i = 1, holdTime do
            touchQueue:pushback(pos, TOUCH_TYPE.HOLD)
        end
        touchQueue:pushback(pos, TOUCH_TYPE.UP)
    end

    function cmds.long_press_pos(args)
        local pos = ccp(args[1], args[2])

        local holdTime = args[3] * 10
        touchQueue:pushback(pos, TOUCH_TYPE.DOWN)
        for i = 1, holdTime do
            touchQueue:pushback(pos, TOUCH_TYPE.HOLD)
        end
        touchQueue:pushback(pos, TOUCH_TYPE.UP)    
    end

    --服务器发送协议
    function cmds.send_protocol(...)
        print("send_protocol:", ...)
        TFDirector:send(...)
        return "send_protocol_success"
    end

    --服务器监听协议
    function cmds.listen_protocol(args)
        print("listen_protocol:", args)
        TFDirector:addProto(args[1], cmds, function(self, event)
                local ret = 'receive_protocol ' .. event.name .. ' '  .. serialize(event.data)
                print("receive_protocol:", ret)
                self.sendMsg(ret)
            end);
        return "listen success"
    end

    --发送信息给自动测试服务器
    function cmds.sendMsg(msg)
        TFConsole:Send_Msg(msg)
    end

    function cmds.capture()
        local winSize = me.Director:getWinSize()
        local render = TFRenderTexture:create(winSize.width, winSize.height)
        render:begin()
        me.Director:getRunningScene():visit()
        render:endToLua()
        local pngName = "testCapture_" .. tostring(os.date("%y%m%d%H%M%S") .. ".png"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                )

        render:saveToFile(pngName , kCCImageFormatPNG)
        return "capture ".. pngName
    end

    --序列化lua object
    function cmds.serialize(obj)  
        local lua = ""  
        local t = type(obj)  
        if t == "number" then  
            lua = lua .. obj  
        elseif t == "boolean" then  
            lua = lua .. tostring(obj)  
        elseif t == "string" then  
            lua = lua .. string.format("%q", obj)  
        elseif t == "table" then  
            lua = lua .. "{\n"  
        for k, v in pairs(obj) do  
            lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"  
        end  
        local metatable = getmetatable(obj)  
            if metatable ~= nil and type(metatable.__index) == "table" then  
            for k, v in pairs(metatable.__index) do  
                lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"  
            end  
        end  
            lua = lua .. "}"  
        elseif t == "nil" then  
            return nil  
        else  
            error("can not serialize a " .. t .. " type.")  
        end  
        return lua  
    end  
      
    function cmds.unserialize(lua)  
        local t = type(lua)  
        if t == "nil" or lua == "" then  
            return nil  
        elseif t == "number" or t == "string" or t == "boolean" then  
            lua = tostring(lua)  
        else  
            error("can not unserialize a " .. t .. " type.")  
        end  
        lua = "return " .. lua  
        local func = loadstring(lua)  
        if func == nil then  
            return nil  
        end  
        return func()  
    end  

    return cmds
end

