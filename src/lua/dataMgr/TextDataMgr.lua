
local BaseDataMgr = import(".BaseDataMgr")
local TextDataMgr = class("TextDataMgr", BaseDataMgr)

function TextDataMgr:cacheFontFace()
    local fontFace = TabDataMgr:getData("FontFace")
    for _, attr in ipairs(fontFace) do
        for _, size in ipairs(attr.fontSize) do
            local face = attr.baseName .. size
            TFRichTextManager:addFont(face, attr.fontName, 0xffffffff, size)
        end
    end
end

function TextDataMgr:init()
    self:cacheFontFace()
    self.rstrTab_ = TabDataMgr:getData("RString")
    self.strTab_ = TabDataMgr:getData("String")
end

function TextDataMgr:getText(id, ...)
    local textAttr = self:getTextAttr(id)
    local text = ""
    if textAttr and not self:isRString(textAttr) then
        if #{...} > 0 then
            text = string.format(textAttr.text, ...)
        else
            text = textAttr.text
        end
    else
        text = string.format("Can not find a string with id %s", id)
    end
    return text
end

function TextDataMgr:getRText(id, ...)
    local textAttr = self:getTextAttr(id)
    local text = ""
    if textAttr and self:isRString(textAttr) then
        text = self:getFormatText(textAttr, ...)
    else
        text = string.format("Can not find a string with id %s", id)
    end
    return text
end

function TextDataMgr:getTextEx(id, ...)
    local textAttr = self:getTextAttr(id)
    local text = ""
    if textAttr then
        if self:isRString(textAttr) then
            text = self:getRText(id, ...)
        else
            text = self:getText(id, ...)
        end
    end
    return text
end

function TextDataMgr:getTextAttr(id)
    id = tostring(id)
    local rid = string.match(id, "r(%d+)")
    if rid then
        id = tonumber(rid)
        return self.rstrTab_[id] or {text = "no rstring id :"..(id or "nil")}
    else
        id = tonumber(id)
        return self.strTab_[id] or {text = "no rstring id :"..(id or "nil")}
    end
end

function TextDataMgr:isRString(textAttr)
    local ret = not (not (textAttr and textAttr.align))
    return ret
end

function TextDataMgr:getFormatText(textAttr, ...)
    local args = {...}
    local style = [[<p style="text-align:%s">%s</p>]]
    local content = ""
    --[[for i, v in ipairs(args) do
        if type(v) == "string" then
            args[i] = string.htmlspecialchars(v)
        end
    end--]]
    for i, v in ipairs(textAttr) do
        local font = [[<font face="%s" color="%s">%s</font>]]
        local text = string.gsub(v.text, "\n", "<br/>")
        face = v.baseName .. v.size
        local clickId = v.clickId
        if #clickId ~= 0 then
            font = [[<a id="%s" underline="true" ><font face="%s" color="%s">%s</font></a>]]
            content = content .. string.format(font, clickId, face, v.color, text)
        else
            content = content .. string.format(font, face, v.color, text)
        end

    end 

    if #args > 0 then
        local rawContent = content
        content = string.format(content, unpack(args))
        for w in string.gmatch(rawContent, "%%s") do
            table.remove(args, 1)
        end
    end

    content = string.format(style, textAttr.align, content)
    return content
end

function TextDataMgr:concat(text, delimiter)
    local isRString = nil
    for i, v in ipairs(text) do
        local ps = string.find(v, "<p")
        if ps then
            if isRString == false then
                isRString = nil
                break
            else
                isRString = true
            end
        else
            if isRString == true then
                isRString = nil
                break
            else
                isRString = false
            end
        end
    end
    if isRString == nil then
        -- Utils:showError("富文本不能与普通文本连接:")
        Utils:showError(TextDataMgr:getText(100000080))
        return
    end

    local content = ""
    if isRString then
        if delimiter == "\n" then
            delimiter = "<br/>"
        end
        for i, v in ipairs(text) do
            if #content > 0 then
                content = content .. delimiter
            end
            local pe = string.find(v, ">")
            if i == 1 then
                local ps = string.find(v, "<p")
                local p = string.sub(v, ps, pe)
                content = content .. p
            end
            local fs = pe + 1
            local fe = -5
            local f = string.sub(v, fs, fe)
            content = content .. f
        end
        content = content .. "</p>"
    else
        content = table.concat(text, delimiter)
    end
    return content, isRString
end

function TextDataMgr:getNoFormatText(textAttr, ...)
    local text = {}
    for i, v in ipairs(textAttr) do
        table.insert(text, v.text)
    end
    local content = table.concat(text)
    if #{...} > 0 then
        content = string.format(content, ...)
    end
    return content
end

function TextDataMgr:reset()

end

return TextDataMgr:new()
