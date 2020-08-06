PopWindow = class("PopWindow")

function PopWindow:ctor(name, flags, isModal)
    self.GUITag = tostring(self)
    self.IsOpen = false
    self.IsModal = isModal
    self.Flags = flags or { ImGui.ImGuiWindowFlags_NoMove, ImGui.ImGuiWindowFlags_AlwaysAutoResize }
    self.Title = string.format("%s##%s", name or "Default", self.GUITag)
    self:AddToScene()

    self.BeginFunc = self.IsModal and ImGui.BeginPopupModal or ImGui.BeginPopup
end

function PopWindow:Open()
    self.IsOpen = true
end

function PopWindow:AddToScene()
    ImGui.AddPopup(self)
end

function PopWindow:Remove()
    ImGui.RemovePopup(self)
end

-- extern
function PopWindow:OnGUIImpl()

end

function PopWindow:OnGUI()
    if self.IsOpen then 
        self.IsOpen = false
        ImGui.OpenPopup(self.Title)
    end
    if self.BeginFunc(self.Title, true, self.Flags) then 
        self:OnGUIImpl()
        ImGui.EndPopup()
    end
end


return PopWindow