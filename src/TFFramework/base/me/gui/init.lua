if not imgui then return end


local newIM = {}
for key, val in pairs(imgui) do 
    local newKey = string.title(key)
    newIM[key] = val 
    newIM[newKey] = val
end
newIM.End = newIM.endToLua
newIM.PushID = newIM.PushId
newIM.PopID = newIM.PopId
imgui = newIM
ImGui = imgui
IM_COL32 = ccc4
ImVec2 = ccp

ImGui.C = ImGui.IsItemClicked
ImGui.H = ImGui.IsItemHoveredRect

ImGui.KeyType = {
    TAB = 9,
    ENTER = 13,
    SHIFT = 16,
    CTRL = 17,
    ALT = 18,
    LEFT = 37, RIGHT = 39, UP = 38, DOWN = 40,
    DEL = 46,
    A = 65, B = 66, C = 67, D = 68, E = 69, F = 70, G = 71, H = 72, I = 73, J = 74, K = 75, L = 76, M = 77, N = 78,
    O = 79, P = 80, Q = 81, R = 82, S = 83, T = 84, U = 85, V = 86, W = 87, X = 88, Y = 89, Z = 90
}



ImGui.Root = {
    popups = {}, removePopups = {},
    toasts = {},
}

function ImGui.OnGUI()

end

function ImGui.draw()
    xpcall(function()
        ImGui.OnGUI()
        ImGui.OnRootGUI() 
    end, function (msg)
        print("----------------------------------------")
        print(msg)
        print()
        print(debug.traceback())
        print("----------------------------------------")
    end)
end

local ImGui_DragInt2 = ImGui.DragInt2
ImGui.DragInt2 = function(label, x, y, speed, min, max, fmt)
    speed = speed or 1
    min = min or 0
    max = max or 0
    fmt = fmt or "%.0f"

    local ok, x, y = ImGui_DragInt2(label, x, y, speed, min, max, fmt)
    if min < max then 
        x = clamp(x, min, max)
        y = clamp(y, min, max)
    end
    return ok, x, y
end

local ImGui_DragInt = ImGui.DragInt
ImGui.DragInt = function(label, x, speed, min, max, fmt)
    speed = speed or 1
    min = min or 0
    max = max or 0
    fmt = fmt or "%.0f"

    local ok, x = ImGui_DragInt(label, x, speed, min, max, fmt)
    if min < max then 
        x = clamp(x, min, max)
    end
    return ok, x
end

function ImGui.Block(tag, pos, size, color, mask)
    color = color or ccc4(255, 0, 0, 255)
    ImGui.AddRectFilled(pos, pos + size, color, 0)

    ImGui.Pos(pos)
    ImGui.InvisibleButton(tag, size)   
end

local Toast = class("Toast")
function Toast:ctor(text, bgcolor, fcolor)
    self.text = text or ""
    self.bgcolor = bgcolor or ccc4(0, 0, 0, 255)
    self.fcolor = fcolor or ccc4(255, 0, 0, 255)

    self.elapse = 0
    self.silence = 1
    self.fly = 2
    self.offset = ccp(0, -200)
    self.toRemove = false
end
function Toast:OnGUI()
    if self.toRemove then return end
    local displayPos = ImGui.GetWindowPos() - ccp(10, -30)

    self.elapse = self.elapse + 0.016
    if self.silence < self.elapse then 
        if self.elapse > self.fly then 
            self.toRemove = true
        end

        displayPos = displayPos + self.offset * (self.elapse - self.silence)
    end

	local displaySize = ImGui.Size() / 2
    local textSize = ImGui.GetTextSize(self.text)
    local bgcolor = self.bgcolor
    local fcolor = self.fcolor
    local text = self.text

    displayPos = displayPos + displaySize

	ImGui.AddRectFilled(ImVec2(0 - textSize.x - 9, 2) + displayPos, ImVec2(0, textSize.y + 9) + displayPos, bgcolor, 2)
    ImGui.AddText(ImVec2(0 - textSize.x - 3, 2) + displayPos, fcolor, text)
end

function ImGui.Toast(text, bgcolor, fcolor)   
    ImGui.Root.toasts[Toast:create(text, bgcolor, fcolor)] = true
end

function ImGui.AddPopup(popup, flags, isModal, ongui)
    if type(popup) == 'string' then 
        local text = popup
        popup = PopWindow:create(text, flags, isModal)
        popup.OnGUIImpl = ongui or (function() end)
    end
    table.insert(ImGui.Root.popups, popup)
end

function ImGui.RemovePopup(popup)
    table.insert(ImGui.Root.removePopups, popup)
end

function ImGui.RemovePopupImpl(item)
    for idx, popup in ipairs(ImGui.Root.popups) do 
        if item == popup then 
            table.remove(ImGui.Root.popups, idx)
            break
        end
    end
end

function ImGui.OnRootGUI()   
    if #ImGui.Root.removePopups > 0 then 
        for idx, popup in ipairs(ImGui.Root.removePopups) do 
            ImGui.RemovePopupImpl(popup)
        end
        ImGui.Root.removePopups = {}
    end

    for idx, popup in ipairs(ImGui.Root.popups) do 
        popup:OnGUI()
    end
end

function ImGui.OnToastGUI()   
    local toRemoveToast = {}
    for toast in pairs(ImGui.Root.toasts) do 
        toast:OnGUI()
        if toast.toRemove then 
            toRemoveToast[toast] = true
        end
    end
    for toast in pairs(toRemoveToast) do 
        ImGui.Root.toasts[toast] = nil
    end
end

function ImGui.Pos(x, y)
    if x and y then 
        ImGui.SetCursorScreenPos(ccp(x, y))
        return ImGui
    elseif x then 
        ImGui.SetCursorScreenPos(x)
        return ImGui
    else 
        return ImGui.GetCursorScreenPos()
    end
end

function ImGui.PosX(x)
    if x then 
        ImGui.SetCursorPosX(x)
        return ImGui
    else 
        return ImGui.GetCursorPosX()
    end
end

function ImGui.PosY(y)
    if y then 
        ImGui.SetCursorPosY(y)
        return ImGui
    else 
        return ImGui.GetCursorPosY()
    end
end

function ImGui.Size(x, y)
    if x and y then 
        ImGui.SetWindowSize(ccp(x, y))
        return ImGui
    elseif x then 
        ImGui.SetWindowSize(x)
        return ImGui
    else 
        return ImGui.GetWindowSize()
    end
end

function ImGui.GetImageInfo(path)
    local tex = me.TextureCache:addImage(path)
    if tex then 
        local size = tex:getContentSize()
        return size
    end
    return ccs(1, 1)
end

local tailCallList = {
    EndChild        = ImGui.EndChild,
    Indent          = ImGui.Indent,
    Unindent        = ImGui.Unindent,
    Text            = ImGui.Text,
    AddLine         = ImGui.AddLine,
    PushStyleColor  = ImGui.PushStyleColor,
    PopStyleColor   = ImGui.PopStyleColor,
    BeginTooltip    = ImGui.BeginTooltip,
    EndTooltip      = ImGui.EndTooltip,
    BeginChild      = ImGui.BeginChild,
    EndChild        = ImGui.EndChild,
    PushItemWidth   = ImGui.PushItemWidth,
    PopItemWidth    = ImGui.PopItemWidth,

}
for name, handle in pairs(tailCallList) do 
    ImGui[name] = function (...)
        local ret = handle(...) or {}
        table.insert(ret, ImGui)
        return unpack(ret)
    end
end

local function CCNode_GetRect(sender)
    local size = sender:Size()
    return ccr(0, 0, size.width, size.height)
end
rawset(CCNode, "GetRect", CCNode_GetRect)

local function SkeletonAnimation_GetRect(sender)
    local rect = sender:boundingBox()
    local pos = sender:Pos()
    local _scaleX = sender:ScaleX()
    local _scaleY = sender:ScaleY()

	rect.origin = rect.origin - pos
	rect.origin.x = rect.origin.x / math.abs(_scaleX)
	rect.origin.y = rect.origin.y / math.abs(_scaleY)
	rect.size.width = rect.size.width / math.abs(_scaleX)
    rect.size.height = rect.size.height / math.abs(_scaleY)
    
    rect.size.width = rect.size.width + rect.origin.x
    rect.size.height = rect.size.height + rect.origin.y
    return rect
end
rawset(SkeletonAnimation, "GetRect", SkeletonAnimation_GetRect)

import(".PopWindow")