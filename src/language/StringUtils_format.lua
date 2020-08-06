local StringUtils = {}
StringUtils.format = function(formatStr, ...) 
	--example 
	--StringUtils.format("start {p1} is {p2} not {p3} end", "superman", "hero", "badguy")

	local params = {}
	for k, v in ipairs{...} do
		table.insert(params, v)
	end

	local len = string.len(formatStr)

	local strs = {}
	local paramNum = {}
	local paramTemps = {}
	local preEndPos = 0

	for i = 1, len do 
		local charTemp1 = formatStr[i]
		if(charTemp1 == '{') then
			local charTemp2 = formatStr[i + 1]
			local charTemp3 = formatStr[i + 2]
			local charTemp4 = formatStr[i + 3]
			if charTemp2 == 'p' and charTemp4 == '}' and tonumber(charTemp3) then
				--table.insert(paramNum, tonumber(charTemp3))
				local paramTemp = params[tonumber(charTemp3)]
				if not paramTemp then
					return nil
				end
				table.insert(paramTemps, paramTemp)
				
				local str = string.sub(formatStr, preEndPos + 1, i - 1)
				table.insert(strs, str)

				i = i + 3 
				preEndPos = i

			--VIP特殊处理
			elseif charTemp2 == 'v' and charTemp4 == '}' and tonumber(charTemp3) then
				--table.insert(paramNum, tonumber(charTemp3))
				local vipLevel = params[tonumber(charTemp3)]
				if not vipLevel then
					return nil
				end
				
				local paramTemp
				if vipLevel <= 15 then 
					paramTemp = StringUtils.format(localizable.VIP_UNDER_15, vipLevel)
				elseif vipLevel == 16 then
					paramTemp = localizable.VIP16
				elseif vipLevel == 17 then
					paramTemp = localizable.VIP17
				elseif vipLevel == 18 then
					paramTemp = localizable.VIP18
				end

				table.insert(paramTemps, paramTemp)
				local str = string.sub(formatStr, preEndPos + 1, i - 1)
				table.insert(strs, str)

				i = i + 3 
				preEndPos = i
			end			
		end

		i = i + 1
	end

	local strEnd = string.sub(formatStr, preEndPos + 1, len)
	table.insert(strs, strEnd)

	local count = table.getn(strs)

	local ret = ""
	for i = 1, count do
		if i ~= count then
			--local paramTemp = params[paramNum[i]]
			--ret = ret .. strs[i] .. paramTemp
			ret = ret .. strs[i] .. paramTemps[i]
		else 
			ret = ret .. strs[i]
		end
	end

	-- print('string.format:', ret)
	return ret
end

--  富文本格式 #R2XXX#
StringUtils.richText = function(formatStr)
	local text 			= [[<p style="text-align:left; margin:5px" >]];
	local defaultColor 	= [[<font color="#5A1F08" face = "Game_Font">]]
	local arrColor = {
						"#FFFFFF",	--白1
						"#FF0000",	--红2
						"#FFA500",	--橙3
						"#FFFF00",	--黄4
						"#00FF00",	--绿5
						"#006400",	--青6
						"#0000FF",	--蓝7
						"#A020F0",	--紫8
					}
	local function getColorText(idColor, _text)
		local des = (idColor == 0) and defaultColor or string.gsub(defaultColor, "#5A1F08", arrColor[tonumber(idColor)])
	    des = des .. _text
	    des = des .. [[</font>]]
		return des
	end
	
	local desInfo 	= string.split(formatStr, "#")
	local len 		= table.getn(desInfo)
	for i = 1, len do 
		local strTemp 		= desInfo[i]
		local idColor 		= tonumber(strTemp[2])
		local typeColor 	= strTemp[1]
		
		if(type(idColor) == "number" and typeColor == "R") then
			text = text .. getColorText(idColor, string.sub(strTemp, 3))
		else
			--默认黑色
			text = text .. getColorText(0, strTemp)
		end
	end
	text = text .. [[</p>]]
	return text
end
return StringUtils