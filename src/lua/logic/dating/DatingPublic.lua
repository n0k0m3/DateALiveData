
do
    -- declare local variables
    --// exportstring( string )
    --// returns a "Lua" portable version of the string
    local function exportstring( s )
        return string.format("%q", s)
    end

    function saveDataTolua(tbl,filename)
        local charK,charS,charE = " ","   ","\n"
        local file,err = io.open( filename, "wb" )
        if err then return err end

        local tables = tbl
        file:write( "return {"..charE )
        for kd, t in pairs(tables) do
            file:write(charS .."[" .. kd .. "]" .. charK .. "=" .. charK .."{" .. charE)
            for k, v in pairs(t) do
                if type(v) == "table" then
                    file:write(charS .. charS .. k .. charK .. "=".. charK .. "{" .. charE)
                    for i, vi in ipairs(v) do
                        file:write(charS .. charS ..charS .. "[" .. i .. "]" .. charK .. "=" .. charK .. vi .. "," .. charE)
                    end
                    file:write(charS .. charS .."},"..charE)
                elseif type(v) == "string" then
                    file:write(charS .. charS .. k .. charK .. "=" .. charK .. exportstring( v ) .. "," .. charE)
                elseif type(v) == "number" then
                    file:write(charS .. charS .. k .. charK .. "=" .. charK .. v .. "," .. charE)
                end

            end
            file:write(charS .."},"..charE)
        end
        file:write( "}" )
        file:close()
    end

    function table.save(tbl,filename )
        local charS,charE = "   ","\n"
        local file,err = io.open( filename, "wb" )
        if err then return err end

        -- initiate variables for save procedure
        local tables,lookup = { tbl },{ [tbl] = 1 }
        file:write( "return {"..charE )

        for idx,t in ipairs( tables ) do
            file:write( "-- Table: {"..idx.."}"..charE )
            file:write( "{"..charE )
            local thandled = {}

            for i,v in ipairs( t ) do
    --// The Save Function
                thandled[i] = true
                local stype = type( v )
                -- only handle value
                if stype == "table" then
                    if not lookup[v] then
                        table.insert( tables, v )
                        lookup[v] = #tables
                    end
                    file:write( charS.."{"..lookup[v].."},"..charE )
                elseif stype == "string" then
                    file:write(  charS..exportstring( v )..","..charE )
                elseif stype == "number" then
                    file:write(  charS..tostring( v )..","..charE )
                end
            end

            for i,v in pairs( t ) do
                -- escape handled values
                if (not thandled[i]) then

                    local str = ""
                    local stype = type( i )
                    -- handle index
                    if stype == "table" then
                        if not lookup[i] then
                            table.insert( tables,i )
                            lookup[i] = #tables
                        end
                        str = charS.."[{"..lookup[i].."}]="
                    elseif stype == "string" then
                        str = charS.."["..exportstring( i ).."]="
                    elseif stype == "number" then
                        str = charS.."["..tostring( i ).."]="
                    end

                    if str ~= "" then
                        stype = type( v )
                        -- handle value
                        if stype == "table" then
                            if not lookup[v] then
                                table.insert( tables,v )
                                lookup[v] = #tables
                            end
                            file:write( str.."{"..lookup[v].."},"..charE )
                        elseif stype == "string" then
                            file:write( str..exportstring( v )..","..charE )
                        elseif stype == "number" then
                            file:write( str..tostring( v )..","..charE )
                        end
                    end
                end
            end
            file:write( "},"..charE )
        end
        file:write( "}" )
        file:close()
    end

    --// The Load Function
    function table.load( sfile )
        local tab =  require( sfile )

        local tables = clone(tab)
        for idx = 1,#tables do
            local tolinki = {}
            for i,v in pairs( tables[idx] ) do
                if type( v ) == "table" then
                    tables[idx][i] = tables[v[1]]
                end
                if type( i ) == "table" and tables[i[1]] then
                    table.insert( tolinki,{ i,tables[i[1]] } )
                end
            end
            -- link indices
            for _,v in ipairs( tolinki ) do
                tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
            end
        end
        return tables[1]
    end

    local isCache = true

    function table.saveTable(tab,key)
        if isCache == false then
            return
        end
        local tableCopy = clone(tab)
        -- local userKey = CCUserDefault:sharedUserDefault():getStringForKey("account")
        local userKey = MainPlayer:getPlayerId()
        key = userKey .. "_" .. key
        local writJson = json.encode(tableCopy)
        CCUserDefault:sharedUserDefault():setStringForKey(key, writJson)
        CCUserDefault:sharedUserDefault():flush()
    end

    function table.readTable(key)
        if isCache == false then
            return
        end
        -- local userKey = CCUserDefault:sharedUserDefault():getStringForKey("account")
        local userKey = MainPlayer:getPlayerId()
        key = userKey .. "_" .. key

        local readJson = CCUserDefault:sharedUserDefault():getStringForKey(key)


        local strPath = CCUserDefault:getXMLFilePath()

        if #readJson == 0 then
            return nil
        end
        local tab = json.decode(readJson)
        return tab
    end


    function table2Str(t)
            local str = ""
            if(t == nil)then
                return "nil"
            end
            if( type(t) ~= "table" )then
                return "NOT a table"
            end

            str = "{\n"

            for k,v in pairs(t) do
                if( type(v) ~= "table" )then
                    if( type(v) == "string" )then
                        if( type(k) == "number" )then
                            str = str .. "["..k.."]='"..tostring(v).."',\n"
                        else
                            str = str .. tostring(k).."='"..tostring(v).."',\n"
                        end
                    else
                        if( type(k) == "number" )then
                            str = str .. "["..k.."]="..tostring(v) ..",\n"
                        else
                            str = str .. tostring(k).."="..tostring(v) ..",\n"
                        end
                    end
                else
                    if( type(k) == "number" )then
                        str = str .. "["..k.."]="
                    else
                        str = str .. tostring(k).."="
                    end
                    str = str .. table2Str(v) .. ",\n"
                end
            end

            str = str .. "\n}"

            return str
        end

        function writeTable(t, path)
            local file = io.open(path, "w")
            file:write("local t = ")
            if t then
                file:write(table2Str(t))
            else
                assert(0, "writeTable")
            end
            file:write("\nreturn t")
            io.close( file )
        end

        --// The Load Function
        function readTable( sfile )
            local tab  =  require( sfile )
            return tab
        end

     function ToStringEx(value)
         if type(value)=='table' then
            return TableToStr(value)
         elseif type(value)=='string' then
             return "\'"..value.."\'"
         else
            return tostring(value)
         end
     end

     function TableToStr(t)
         if t == nil then return "" end
         local retstr= "{"

         local i = 1
         for key,value in pairs(t) do
             local signal = ","
             if i==1 then
               signal = ""
             end

             if key == i then
                 retstr = retstr..signal..ToStringEx(value)
             else
                 if type(key)=='number' or type(key) == 'string' then
                     retstr = retstr..signal..'['..ToStringEx(key).."]="..ToStringEx(value)
                 else
                     if type(key)=='userdata' then
                         retstr = retstr..signal.."*s"..TableToStr(getmetatable(key)).."*e".."="..ToStringEx(value)
                     else
                         retstr = retstr..signal..key.."="..ToStringEx(value)
                     end
                 end
             end

             i = i+1
         end

          retstr = retstr.."}"

           local file,err = io.open( "D:test.lua", "wb" )
             if err then return err end
             file:write( retstr)
             file:close()
          return retstr
     end

        function changeBgmVolume(target,outTime,deyTime,inTime,outMusicCallBack,inMusicCallBack)
            local count = 50
            outTime = outTime * count
            inTime = inTime * count
            --修改音量方法真机才有效
            local maxVolume = TFAudio.getMusicVolume()
            local isOutAction = true
            if outTime == 0 then
                TFAudio.setMusicVolume(0)
                outTime = 0.1
                isOutAction = false
            end
            local minusValue = string.format("%0.3f", maxVolume/outTime)
            local addValue = string.format("%0.3f", maxVolume/inTime)

            print("maxVolume:")
            print(maxVolume)
            print("minusValue:")
            print(minusValue)
            print("addValue:")
            print(addValue)

            local function outFun()
                TFAudio.setMusicVolume(TFAudio.getMusicVolume() - minusValue)
                print("outFun musicVolume:")
                print(TFAudio.getMusicVolume())
            end

            local function inFun()
                TFAudio.setMusicVolume(TFAudio:getMusicVolume() + addValue)
                print("inFun musicVolume:")
                print(TFAudio.getMusicVolume())
            end

            local acArr = TFVector:create()
            local bmOutFun = CCCallFunc:create(outFun)
            local outDey = CCDelayTime:create(0.05)
            local outSeq = CCSequence:create({bmOutFun,outDey})
            local reOutAc = Repeat:create(outSeq,outTime)

            local outBackFun = outMusicCallBack and CCCallFunc:create(outMusicCallBack) or CCCallFunc:create(function() end)

            local deyAc = CCDelayTime:create(deyTime)
            local bmInFun = CCCallFunc:create(inFun)
            local inDey = CCDelayTime:create(0.05)
            local inSeq = CCSequence:create({bmInFun,inDey})
            local reInAc = Repeat:create(inSeq,inTime)

            local inBackFun = inMusicCallBack and CCCallFunc:create(inMusicCallBack) or CCCallFunc:create(function() end)

            if isOutAction then
                acArr:addObject(reOutAc)
                acArr:addObject(outBackFun)
            end
            acArr:addObject(deyAc)
            acArr:addObject(reInAc)
            acArr:addObject(inBackFun)
            target:runAction(bmOutFun)
            target:runAction(CCSequence:create(acArr))
            -- target:runAction(reOutAc)
        end

        function changeEffectVolume(target,outTime,deyTime,inTime,outMusicCallBack,inMusicCallBack)
            local count = 50
            outTime = outTime * count
            inTime = inTime * count
            --修改音量方法真机才有效
            local maxVolume = TFAudio.getEffectsVolume()
            local isOutAction = true
            if outTime == 0 then
                TFAudio.setEffectsVolume(0)
                outTime = 0.1
                isOutAction = false
            end
            local minusValue = string.format("%0.3f", maxVolume/outTime)
            local addValue = string.format("%0.3f", maxVolume/inTime)

            print("maxVolume:")
            print(maxVolume)
            print("minusValue:")
            print(minusValue)
            print("addValue:")
            print(addValue)

            local function outFun()
                TFAudio.setEffectsVolume(TFAudio.getEffectsVolume() - minusValue)
                print("outFun effectsVolume:")
                print(TFAudio.setEffectsVolume())
            end

            local function inFun()
                TFAudio.setEffectsVolume(TFAudio:getEffectsVolume() + addValue)
                print("inFun effectsVolume:")
                print(TFAudio.setEffectsVolume())
            end

            local acArr = TFVector:create()
            local bmOutFun = CCCallFunc:create(outFun)
            local outDey = CCDelayTime:create(0.05)
            local outSeq = CCSequence:create({bmOutFun,outDey})
            local reOutAc = Repeat:create(outSeq,outTime)

            local outBackFun = outMusicCallBack and CCCallFunc:create(outMusicCallBack) or CCCallFunc:create(function() end)

            local deyAc = CCDelayTime:create(deyTime)
            local bmInFun = CCCallFunc:create(inFun)
            local inDey = CCDelayTime:create(0.05)
            local inSeq = CCSequence:create({bmInFun,inDey})
            local reInAc = Repeat:create(inSeq,inTime)

            local inBackFun = inMusicCallBack and CCCallFunc:create(inMusicCallBack) or CCCallFunc:create(function() end)

            if isOutAction then
                acArr:addObject(reOutAc)
                acArr:addObject(outBackFun)
            end
            acArr:addObject(deyAc)
            acArr:addObject(reInAc)
            acArr:addObject(inBackFun)
            target:runAction(bmOutFun)
            target:runAction(CCSequence:create(acArr))
            -- target:runAction(reOutAc)
        end

        --检测特殊文字（暂时用于剧本文本特殊文字着色）isDyColor为true时表示可以根据配置表动态设置颜色（配置如：(255,0,0)）
        function checkSpecText(text,isDyColor,isDeyTime)
            -- local list,len = Public:stringSplit(text)
            local list = string.UTF8ToCharArray(text)

            local leIdxList_ = {}
            local idx = 1
            local isInsert = false
            local deyTimeMap_ = {}
            local deyIdx = 0
            local deyTimeNum = 0
            local secNum = 0
            isDyColor = isDyColor or false
            for i,v in ipairs(list) do
                if isDeyTime then
                    if v == "@" then
                        if deyIdx == 0 then
                            deyIdx = i - 1 - deyTimeNum
                        end
                        deyTimeNum = deyTimeNum + 1
                        deyTimeMap_[deyIdx] = deyTimeMap_[deyIdx] or 0.5
                        deyTimeMap_[deyIdx] = deyTimeMap_[deyIdx] + 0.5
                    else
                        deyIdx = 0
                    end
                end
                if v == "[" then
                    secNum = secNum + 1
                    deyTimeNum = deyTimeNum + 1
                    leIdxList_[idx] = {}
                    leIdxList_[idx].startChr = list[i+1]
                    leIdxList_[idx].loStartIdx = i + 1 - secNum  --这里要减去特殊字符站位
                end

                if v == "]" and leIdxList_[idx] and leIdxList_[idx].startChr then
                    secNum = secNum + 1
                    deyTimeNum = deyTimeNum + 1
                    leIdxList_[idx].endChr = list[i-1]
                    leIdxList_[idx].loEndIdx = i - secNum --这里要减去特殊字符站位
                    if not isDyColor then
                        idx = idx + 1
                    end
                end

                if v == "(" and leIdxList_[idx] and leIdxList_[idx].endChr then
                    deyTimeNum = deyTimeNum + 1
                    leIdxList_[idx].startIdx = i
                    isInsert = true
                end

                if isInsert and leIdxList_[idx] and leIdxList_[idx].startIdx then
                    leIdxList_[idx].colorTable = leIdxList_[idx].colorTable or {}
                    table.insert(leIdxList_[idx].colorTable,v)
                end

                if v == ")" and leIdxList_[idx] and leIdxList_[idx].startIdx then
                    deyTimeNum = deyTimeNum + 1
                    leIdxList_[idx].endIdx = i
                    if isDyColor then
                        idx = idx + 1
                    end
                    isInsert = false
                end
            end
            local str = clone(text)
            for i,v in ipairs(leIdxList_) do
                if v.colorTable then
                    local colorTable = clone(v.colorTable)
                    for ic,vc in ipairs(colorTable) do
                        if ic ~= 1 and ic ~= #colorTable then
                            str = LuaReomve(str,vc)
                        end
                    end
                    v.colorChar = table.concat(colorTable,nil,2,#colorTable-1)
                    v.color = string.split(v.colorChar, ",")
                end
            end

            local str = removeSpecText(str)

            return leIdxList_,str,deyTimeMap_
        end

        function removeSpecText(text)
            local str = LuaReomve(text,"%[")
            str = LuaReomve(str,"%]")
            if isDyColor then
                str = LuaReomve(str,"%(")
                str = LuaReomve(str,"%)")
            end
            str = LuaReomve(str,"%@")

            return str
        end

        function LuaReomve(str,remove)
            local lcSubStrTab = {}
            while true do
                local lcPos = string.find(str,remove)
                if not lcPos then
                    lcSubStrTab[#lcSubStrTab+1] =  str
                    break
                end
                local lcSubStr  = string.sub(str,1,lcPos-1)
                lcSubStrTab[#lcSubStrTab+1] = lcSubStr
                str = string.sub(str,lcPos+1,#str)
            end
            local lcMergeStr =""
            local lci = 1
            while true do
                if lcSubStrTab[lci] then
                    lcMergeStr = lcMergeStr .. lcSubStrTab[lci]
                    lci = lci + 1
                else
                    break
                end
            end
            return lcMergeStr
        end
-- close do
end