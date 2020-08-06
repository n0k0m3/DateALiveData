
local BaseDataMgr = import(".BaseDataMgr")
local LanguageResMgr = class("LanguageResMgr", BaseDataMgr)

function LanguageResMgr:init()
    local pitctureData = TabDataMgr:getData("PictureTable")
    self.languageResTable = {}
    local language = GAME_LANGUAGE_VAR
    for k ,v in pairs(pitctureData) do
        self.languageResTable[v["res"]] = v["res"..language]
    end
end

function LanguageResMgr:reset()
   
end

function LanguageResMgr:onLogin()
   
end

function LanguageResMgr:onEnterMain()

end

function LanguageResMgr:getData()
    return self.languageResTable
end



return LanguageResMgr:new()
