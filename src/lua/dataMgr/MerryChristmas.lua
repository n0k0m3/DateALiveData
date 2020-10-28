local FileCheckMgr = class("FileCheckMgr")
local UserCenterHttpClient = TFClientNetHttp:GetInstance()
local TFClientUpdate =  TFClientResourceUpdate:GetClientResourceUpdate()

function FileCheckMgr:ctor()
    self.strCfg = require("lua.table.String" ..GAME_LANGUAGE_VAR)
	--self.checkUrl = "http://192.168.10.16:8000/version_3.0.05.xml"
    self.checkUrl = "http://192.168.101.16:8000/check.xml"
    self.urlIndex = 0;
  --   self.urlHeads = {
	 -- "http://cdn.datealive.com/dal/",
  --      "http://c.dal.heitao2014.com/dal/",
  --     }
    --ÔÝÊ±ÆÁ±Îº«·þÉèÖÃ
    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        self.urlHeads = {
            "https://c-en.datealive.com/dal_eng/",
            "https://c-dal-en.heitaoglobal.com/dal_eng/",
        }
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        self.urlHeads = {
            "http://cdn.datealive.com/dal/",
        }
    else
        self.urlHeads = {
            "https://c-en.datealive.com/dal_eng/",
            "https://c-dal-en.heitaoglobal.com/dal_eng/",
        }
    end

    -- self.needCheck = {
    --     "LoginScene.lua",
    --     "DefaultLayer.lua",
    --     "MainScene.lua",
    -- }
    self.needCheck = {
        "LoginScene.lua",
        "DefaultLayer.lua",
        "MainScene.lua",
        "TFGameStartup.lua",
    }

    self.isSuccess = false;
end

function FileCheckMgr:init()
	
end

function FileCheckMgr:getCheckUrl()
    self.urlIndex = self.urlIndex + 1;
    if self.urlIndex > #self.urlHeads then
        return;
    end

    local checkUrl = nil
    local urlHead = self.urlHeads[self.urlIndex]
    local currenVer = TFClientUpdate:getCurVersion();
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        currenVer = "2.0.56"
    end

    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 or RELEASE_TEST then
        checkUrl = urlHead.."DAL_TEST/MainSorceCode/history/version_"..currenVer.."_org.xml";
    elseif EXPERIENCE then
        checkUrl = urlHead.."DAL_EXPERIENCE/MainSorceCode/history/version_"..currenVer.."_org.xml";
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        checkUrl = urlHead.."DAL_IOS/MainSorceCode/history/version_"..currenVer.."_org.xml";
    elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
        checkUrl = urlHead.."DAL_ANDROID/MainSorceCode/history/version_"..currenVer.."_org.xml";
    end
    return checkUrl;
end

function FileCheckMgr:start(endCall)
    self.endCall = self.endCall or endCall;

    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 or VERSION_DEBUG or MD5_DEBUG then
        self.isSuccess = true;
        self.endCall(0)
        return
    end


    self.checkUrl = self:getCheckUrl();
    if not self.checkUrl then
        self.endCall(0)
        return;
    end

    local url = self.checkUrl
    url = string.gsub(url," ","");
    print(url);
    UserCenterHttpClient:addMERecvListener(handler(self.listFromServer,self))
    UserCenterHttpClient:httpRequest(TFHTTP_TYPE_GET,url)
    self.s = os.clock();
end

function FileCheckMgr:isNeedCheck(filename)
    for k,v in pairs(self.needCheck) do
        if string.find(filename,v) then
            return true;
        end
    end

    if string.find(filename,"lua/table") or string.find(filename,"lua/dataMgr") or string.find(filename,"lua/logic/battle") then
        return true;
    end

    return false;
end

function FileCheckMgr:listFromServer(type,ret,data)
    dump({type,ret})

    if ret ~= 200 then
        self:start();
        return
    end


    local list = {}
    local s = os.clock();
    string.gsub(data, "<f(.-)/>", function (props)
        local need = false;
        local k = "";
        local v = "";
        string.gsub(props, "([^%s]+)%s*=%s*\"([^%s]+)\"", function (key, val)
            if key == "p" then
                k = val
                need = self:isNeedCheck(val);
            end

            if key == "m" then
                v = val
            end
        end)

        if need then
            local t = {}
            t[k] = v;
            table.insert(list,t);
        end
    end)

    local e = os.clock();
    dump(e - s)
    dump(table.count(list));

    self.flist = list;

    self:startCheckFile();
end

function FileCheckMgr:startCheckFile()
    if not self.flist or table.count(self.flist) <= 0 then
        return;
    end

    self.checkIndex = 1;
    self.loadInfo = import("lua.gamedata.FileLoader")
    self.timer = TFDirector:addTimer(0, #self.flist,
        function ()
            self:checkEnd();
        end,
        function()
            self:checkOneFile();
        end
    )
    --无用代码为了更新
end

function FileCheckMgr:onFileError()
    local function okhandle()
        LogonHelper = require("lua.manager.LogonHelper")
        SettingDataMgr = require("lua.dataMgr.SettingDataMgr")
        local CommonManager = require("lua.gamedata.CommonManager")
        CommonManager:autoFixRes();
    end

    local function cancelhandle()
        me.Director:endToLua();
    end
    local params = {
        ["message"]                 = self.strCfg[100000120].text,
        ["okhandle"]                = okhandle,
        ["cancelhandle"]            = cancelhandle,
        ["_type"]                   = 2,
    }

    local layer = require("lua.logic.common.MessageBox"):new(params)
    local currentScene = TFDirector:currentScene()
    currentScene:addChild(layer,998)
end

function FileCheckMgr:checkOneFile()

    local bar_load      = nil
    local txt_update    = nil

    local data = self.flist[self.checkIndex]
    for filename,_md5 in pairs(data) do

        local continue = true
        if string.find(filename,"ui_prj.lua") or string.find(filename,"EditorBase_LoadTFLua") or string.find(filename,"PackBranch.lua") or string.find(filename,"MerryChristmas.lua")  then
            continue = false;
        end

        if continue then
            local fullpath = me.FileUtils:fullPathForFilename(filename);
            dump(fullpath);
            --if not string.find(fullpath,"assets/") then
                --local file = io.open(fullpath, "rb")
                local file = me.FileUtils:getFileDataLua(fullpath,'rb')
                if file then
                    --local filedata = file:read("*a")
                    local _localmd5 = md5.sumhexa(file)

                    print("-----------------------------")
                    print("filename = "..filename)
                    print("server MD5 = ".._md5)
                    print("local  MD5 = ".._localmd5)
                    print("-----------------------------")

                    if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and _localmd5 ~= _md5 and MD5_DEBUG ~= true then
                        Box(filename.." is error!!!")
                        self:onFileError();
                        TFDirector:removeTimer(self.timer)
                        self.timer = nil
                    end
                    --file:close()
                else
                    if CC_PLATFORM_WIN32 == CC_TARGET_PLATFORM then
                        
                    else
                        self:onFileError();
                        TFDirector:removeTimer(self.timer)
                        self.timer = nil
                    end
                end
            --end
        end
    end

    self.checkIndex = self.checkIndex + 1

    if (txt_update == nil or bar_load == nil) then
        local currentScene = TFDirector:currentScene()
        local childrenArr = currentScene:getChildren()
        for i=0,childrenArr:count()-1 do
            local child = childrenArr:objectAtIndex(i)
            local updateLayer = child:getChildByName("UpdateLayer_new")
            if (updateLayer) then
                local ui = updateLayer:getChildByName("ui")
                if (ui) then
                    bar_load    = ui:getChildByName("bar_load")
                    txt_update  = ui:getChildByName("txt_update")
                end
            end
        end
    end
    local maxSize       =  #self.flist + #(self.loadInfo.managers);

    if (bar_load) then
        if (currLoad == 0) then
            currLoad        = math.ceil(bar_load:getPercent() / 100 * maxSize) + 1
            currLoad        = currLoad + 1
        end
        currLoad = currLoad or 0
        currLoad = currLoad + 1
        bar_load.currLoad = currLoad;
        bar_load:setPercent((currLoad / maxSize) * 100)
    end

    if (txt_update) then
        if (bar_load:getPercent() >= 100) then
            txt_update:setText(self.strCfg[800060].text)
        else
            txt_update:setText(self.strCfg[800061].text)
        end
    end
end

function FileCheckMgr:checkEnd()
    self.isSuccess = true;

    if self.endCall then
        self.endCall(#self.flist)
    end
end

function FileCheckMgr:getIsSuccess()
    if self.isSuccess or MD5_DEBUG then
        return "true"
    end

    return "false";
end

return FileCheckMgr:new();
