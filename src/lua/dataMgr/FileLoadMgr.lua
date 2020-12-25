local FileLoadMgr = class("FileLoadMgr")
local json = require("LuaScript.extends.json")
local UserCenterHttpClient = TFClientNetHttp:GetInstance()
local TFClientUpdate =  TFClientResourceUpdate:GetClientResourceUpdate()
FileLoadStatus = {
    NONE = 0,
    CHECK = 1,
    DOWNLOADING = 2,
    SUCCESS = 3,
    NEEDNOT = 4,
}

local updatePath = CCFileUtils:sharedFileUtils():getWritablePath()
local tblResPath = {}
if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
    updatePath = updatePath .. '../Library/'
    updatePath = updatePath .. "TFDebug/"
elseif CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID then
    updatePath = updatePath .. "TFDebug/"
else
    updatePath = updatePath .. '../Library/'
    updatePath = updatePath .. "TFDebug/"
end


function FileLoadMgr:ctor()
    self:init()
    self.needDownlads = {}
    self.nByCEvent = {}

    if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        self.url = "http://cdn.datealive.com/dal/DAL_IOS/MainSorceCode/source/"
    else
        self.url = "http://cdn.datealive.com/dal/DAL_ANDROID/MainSorceCode/source/"
    end
    self.status = FileLoadStatus.NONE
end

function FileLoadMgr:init()
	
end

function FileLoadMgr:start()
    if FileCheckMgr then
        self.flist = FileCheckMgr:getList()
        self:startCheckFile()
    end
end

function FileLoadMgr:startCheckFile()
    if not self.flist or table.count(self.flist) <= 0 then
        return;
    end

    self.status = FileLoadStatus.CHECK
    self.checkIndex = 1;
    self.startTime = os.clock()
    self.timer = TFDirector:addTimer(0, #self.flist,
        function ()
            self:checkEnd();
        end,
        function()
            self:checkOneFile();
        end
    )
end

function FileLoadMgr:checkOneFile()
    local index = self.checkIndex
    self.checkIndex = self.checkIndex + 1
    local filename = self.flist[index].filename;


    if string.find(filename,"TFGameStartup") 
        or string.find(filename,"logic/login/LoginLayer")
        or string.find(filename,"CleanUpView")
        or string.find(filename,"cleanUpView")
        or string.find(filename,"TFClientUpdate")
        or string.find(filename,"dataMgr/MerryChristmas")
        or string.find(filename,"TFAssetsManager")
        or string.find(filename,"TFFramework/")
        or string.find(filename,"/uiconfig/")
    then
        return
    end

    local pathinfo = io.pathinfo(filename)
    if pathinfo.extname == ".ttf" then
        return
    end

    local file = me.FileUtils:getFileDataLua(filename,'rb')
    if file and file ~= "" then
        if pathinfo.extname == ".lua" then
            local _localmd5 = md5.sumhexa(file)
            if _localmd5 ~= self.flist[index].md5 then
                print(#self.needDownlads)
                dump(file,filename)
                table.insert(self.needDownlads,self.flist[index])
            end
        end
    else
        table.insert(self.needDownlads,self.flist[index])
    end

    if self.ui then
        self.ui:update();
    end
end

local function genKey(k)
    return "['".. tostring(k) .. "']"
end
local function table2string(t)
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
                str = str .. genKey(k) .. "='"..tostring(v).."',\n"
            else
                str = str .. genKey(k) .. "="..tostring(v) ..",\n"
            end
        else
            str = str .. genKey(k) .. "="
            str = str .. table2string(v) .. ",\n"
        end
    end
    
    str = str .. "\n}"
    return str
end

function writefile(path, content, mode)
    mode = mode or "w+b"
    local file = io.open(path, mode)
    if file then
        if file:write(content) == nil then return false end
        io.close(file)
        return true
    else
        return false
    end
end

function FileLoadMgr:checkEnd()
    local str = table2string(self.needDownlads)
    writefile(updatePath.."xxx.lua",str)
    if #self.needDownlads > 0 then
        self:startDownloading();
    else
        self.status = FileLoadStatus.NEEDNOT
    end
end

url = "http://192.168.10.16:8000/source/"
function FileLoadMgr:startDownloading()
    self.status = FileLoadStatus.DOWNLOADING
    self.downIndx = 0;
    self:downloadOneFile()
end

function FileLoadMgr:downloadOneFile()

    self.downIndx = self.downIndx + 1
    
    if self.downIndx > #self.needDownlads then
        --Box("下载完成")
        self.status = FileLoadStatus.SUCCESS;
    else
        local curDownloadUrl = string.format("%s/%s",url,self.needDownlads[self.downIndx].filename)--url.."/"..self.needDownlads[self.downIndx].filename;
        local _path = self.needDownlads[self.downIndx].filename;
        HttpHelper:get(curDownloadUrl,function(data)
            self:downloadOneFileFinish(nil,nil,data,_path)
        end
            );
    end

    if self.ui then
        self.ui:update();
    end
end

function FileLoadMgr:downloadOneFileFinish(type,ret,data,path)

    local writePath = updatePath .. path;
    local dir = string.match(writePath,".*/")
    if not CCFileUtils:sharedFileUtils():isDirectoryExist(dir) then
        CCFileUtils:sharedFileUtils():createDirectory(dir)
    end

    print(writePath)
    writefile(writePath,data)
    self:downloadOneFile()
end

function FileLoadMgr:setUI(ui)
    self.ui = ui
end

function FileLoadMgr:getStatus()
    return self.status;
end

function FileLoadMgr:getLoadinPercent()
    if self.status == FileLoadStatus.CHECK then
        return self.checkIndex / #self.flist * 100,"("..self.checkIndex.."/"..#self.flist..")"
    end

    if self.status == FileLoadStatus.DOWNLOADING then
        return self.downIndx / #self.needDownlads * 100,"("..self.downIndx.."/"..#self.needDownlads..")"
    end

    return "" 
end

function FileLoadMgr:stop()
    self.status = FileLoadStatus.NONE
    TFDirector:removeTimer(self.timer)
    self.timer = nil
    self.ui = nil;
end

function FileLoadMgr:downloadFile(filename)
    local curDownloadUrl = string.format("%s/res/basic/%s",self.url,filename)
    HttpHelper:get(curDownloadUrl,function(data)
        self:downloadFileByCEventFinish(nil,nil,data,filename)
    end)
end

function FileLoadMgr:downloadFileByCEventFinish(type,ret,data,path)
    dump({type,ret,data,path})
    if data == "" or string.find(data,"404 Not Found") then
        --Box("服务器无此文件："..path)
        return
    end

    local writePath = updatePath .."/res/basic/".. path;
    local dir = string.match(writePath,".*/")
    if not CCFileUtils:sharedFileUtils():isDirectoryExist(dir) then
        CCFileUtils:sharedFileUtils():createDirectory(dir)
    end

    print(writePath)
    writefile(writePath,data)

    if self:isLive2dFile(path) then
        self:downloadLive2dFiles(path)
    end
end

function FileLoadMgr:isLive2dFile(filename)
    if string.find(filename,"model3.json") or string.find(filename,"model.json") then
        return true;
    end
    return false;
end

function FileLoadMgr:getLive2dFiles(path)
    local files = {}
    local data = me.FileUtils:getFileDataLua(path,'rb')
    local dataTab = json.decode(data);
    local pathinfo = io.pathinfo(path)
    if pathinfo.extname == ".model3.json" then
        for k,v in pairs(dataTab) do
            if k == "FileReferences" then
                for k2,v2 in pairs(v) do
                    if k2 == "Moc" then
                        files[pathinfo.dirname..v2] = true;
                    elseif k2 == "Physics" then
                        files[pathinfo.dirname..v2] = true;
                    elseif k2 == "Textures" then
                        for k3,v3 in pairs(v2) do
                            files[pathinfo.dirname..v3] = true; 
                        end
                    elseif k2 == "Motions" then
                        for k3,v3 in pairs(v2) do
                            for k4,v4 in pairs(v3) do
                                for k5,v5 in pairs(v4) do
                                    if k5 == "File" then
                                        files[pathinfo.dirname..v5] = true; 
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        for k,v in pairs(dataTab) do
            if k == "model" then
                files[pathinfo.dirname..v] = true;
            elseif k == "physics" then
                files[pathinfo.dirname..v] = true;
            elseif k == "project_settings" then
                files[pathinfo.dirname..v] = true;
            elseif k == "textures" then
                for k3,v3 in pairs(v) do
                    files[pathinfo.dirname..v3] = true; 
                end
            elseif k == "motions" then
                for k3,v3 in pairs(v) do
                    for k4,v4 in pairs(v3) do
                        for k5,v5 in pairs(v4) do
                            if k5 == "file" then
                                files[pathinfo.dirname..v5] = true; 
                            end
                        end
                    end
                end
            end
        end
    end
    return files;
end

function FileLoadMgr:downloadLive2dFiles(path)
    local files = self:getLive2dFiles(path);
    for k,v in pairs(files) do
        print(k)
        local filename = k;
        self:downloadFile(filename)
    end
end

function FileLoadMgr:downloadFileByCEvent(filename)
    if self.nByCEvent[filename] or CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        return;
    end
    --Box(filename)
    self.nByCEvent[filename] = true;
    self:downloadFile(filename);
end

return FileLoadMgr:new();
