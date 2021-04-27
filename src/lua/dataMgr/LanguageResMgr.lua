
local BaseDataMgr = import(".BaseDataMgr")
local LanguageResMgr = class("LanguageResMgr", BaseDataMgr)

function LanguageResMgr:init()
    self.languageResTable = {}
    local language = TFLanguageMgr:getUsingLanguageCode("_")
    local pitctureData = TabDataMgr:getData("PictureTable")
    for k ,v in pairs(pitctureData) do
        self.languageResTable[v["res"]] = v["res_en"]
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

function LanguageResMgr:changeGameLanguage()
    self:init()
end


return LanguageResMgr:new()
