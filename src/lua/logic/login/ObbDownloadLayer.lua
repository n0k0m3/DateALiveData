
local ObbDownloadLayer = class("ObbDownloadLayer", BaseLayer)
CREATE_SCENE_FUN(ObbDownloadLayer)
CREATE_PANEL_FUN(ObbDownloadLayer)

local obbDirUrl = TFPlugins.versionPath

local TFClientObbDownload = TFClientObbDownload:GetInstance()

function ObbDownloadLayer:ctor(data)
    self.super.ctor(self,data)
    self:init("lua.uiconfig_mango_new.login.UpdateLayer")
end

function ObbDownloadLayer:initUI(ui)
    self.super.initUI(self,ui)
    self:setName("UpdateLayer_new")
    self.ui = ui
    self.ui:setName("ui")

    self.bar_update     = TFDirector:getChildByPath(ui, 'bar_update')
    self.bar_update_bg  = TFDirector:getChildByPath(ui, 'bg_bar')
    self.bar_update:setPercent(0);

    self.txt_update     = TFDirector:getChildByPath(ui, 'txt_update')
    self.txt_loading    = TFDirector:getChildByPath(ui, 'txt_loading')
    self.txt_chat       = TFDirector:getChildByPath(ui, 'txt_chat')
    self.img_bg         = TFDirector:getChildByPath(ui, 'bg')
    self.img_title      = TFDirector:getChildByPath(ui, 'img_title')
    self.txt_version    = TFDirector:getChildByPath(ui, 'txt_version')
    self.txt_update:setName("txt_update")
    
    if self.img_title then
        self.img_title:setVisible(false)
    end

    self.bar_update_bg:setVisible(false)
    self.txt_update:setVisible(true)
    -- self.img_point:setVisible(false)
    self.bar_update:setVisible(false)

    self.bar_load = TFDirector:getChildByPath(ui, 'bar_load')
    self.bar_load:setVisible(true)
    self.bar_load:setName("bar_load")
    local index     = 1;
    local timeCount = 1;
    local loadingStr = "";

        self.bar_update_bg:setVisible(true)
        self.bar_load:setPercent(0)

    function change()
        --省略号动起来
        loadingStr = loadingStr .. ".";
        index = index + 1;
        if index > 5 then
            loadingStr = "";
            index = 1;
        end

        self.txt_loading:setText(loadingStr)

        --动态显示小贴士
        timeCount = timeCount + 1
        if timeCount > 10 then
            timeCount = 1
            self:showHelpText()
        end
    end

    self.loadingTimeId = TFDirector:addTimer(500, -1, nil, change)
    self.txt_loading:setText("")

    --self.txt_update:setText("正在检测最新资源")
    --self.txt_update:setText(localizable.updateLaye_check_resource)
    local loadInfo      = GetLoadFileList()
    local addLoadNum    = loadInfo[2]
    local maxNum        = loadInfo[1]
    self.txt_update:setText(stringUtils.format(localizable.updateLaye_loading_lua, addLoadNum, maxNum))
    self.bar_load:setPercent((addLoadNum / maxNum) * 100)
    
    self:playEffect()

    self:LoadingEffect()

    -- 显示小贴士
    self:showHelpText()

    if self.checkObbTimer == nil then
        self.checkObbTimer = TFDirector:addTimer(1000,1,nil,function ()
                TFDirector:removeTimer(self.checkObbTimer)
                self.checkObbTimer = nil
                -- 开始更新版本
                self:updateVision()
        end)
    end


    -- self:showFailDiag(2)

    local wifiType = TFDeviceInfo:getNetWorkType()

    print("--------------------网络类型     =", wifiType)

    self.txt_version:setVisible(false)
end

function ObbDownloadLayer:removeUI()
    self.super.removeUI(self)
    TFDirector:removeTimer(self.loadingTimeId);
end

function ObbDownloadLayer:registerEvents()
    self.super.registerEvents(self)
end

function ObbDownloadLayer:removeEvents()
    self.super.removeEvents(self)

    ADD_KEYBOARD_CLOSE_LISTENER(self, self.ui)
end


function ObbDownloadLayer:showHelpText()
    -- if self.TipsList == nil then
    --     self.TipsList    = require("lua.table.t_s_help_tips")
    -- end
    -- local nLen = self.TipsList:length()
    -- local nIndex = math.random(1, nLen)
    -- local content = self.TipsList:getObjectAt(nIndex).tips

    -- self.txt_chat:setText(content)

    self.txt_chat:setTextById(800091)
end

function ObbDownloadLayer:updateVision()
    local function downloadingRecvData(downloadingSize, totalSize)
        local size1 = math.floor(downloadingSize/1024)
        local size2 = math.floor(totalSize/1024)

        local nRate = (size1 / size2)*100
        if nRate > 100 then
            nRate = 100
        end

        nRate  = math.floor(nRate)

        self.bar_load:setPercent(nRate)

        --local desc  = string.format("正在更新，已下载%d%%  (%dKB/%dKB)", nRate, size1, size2)
        local desc  = stringUtils.format(localizable.updateLaye_update_tips, nRate, size1, size2)

        print(desc)
        self.txt_update:setText(desc)
    end

    local function StatusUpdateHandle(ret)
        -- body
        print("ret --- ",ret)
        -- 更新完成，或者当前版本已经是最新的了
        if ret == 1 then
            print("---------------更新完成")
            print("---------------加载本地文件")
            --restartLuaEngine("CompleteUpdate")
            self:CompleteUpdate();
            return
        elseif ret < 0 then
            print("---------------更新出错")
            self:showFailDiag(1)
        end
    end


    print("new--------------------obbDirUrl  = ", obbDirUrl)
    local ifNeedDownloadObb = TFClientObbDownload:CheckDownloadObb(obbDirUrl)

    if ifNeedDownloadObb then
        TFClientObbDownload:StartDownload(downloadingRecvData, StatusUpdateHandle)
    else
        -- print("me.Scheduler:scheduleScriptFunc(self.EnterGame, 0.5, false)")
        -- me.Scheduler:scheduleScriptFunc(self.EnterGame, 0.5, false)

        self:EnterGame()
    end
end

function ObbDownloadLayer:showOperateSureLayer(okhandle,cancelhandle,param)

    print("ObbDownloadLayer:showOperateSureLayer")
    param = param or {}

    param.showtype = param.showtype or AlertManager.BLOCK_AND_GRAY_CLOSE;
    param.tweentype = param.tweentype or AlertManager.TWEEN_1;

    param.uiconfig = param.uiconfig or "lua.uiconfig_mango_new.common.OperateSure";


    -- local layer = AlertManager:addLayerToQueueAndCacheByFile("lua.logic.common.OperateSure",param.showtype,param.tweentype);
    local layer = AlertManager:addLayerByFile("lua.logic.common.OperateSure",param.showtype,param.tweentype);
    layer.toScene = Public:currentScene();

    layer:setUIConfig(param.uiconfig);

    layer:setBtnHandle(okhandle, cancelhandle);
    layer:setData(param.data);
    layer:setTitle(param.title);
    layer:setMsg(param.msg);
    layer:setTitleImg(param.titleImg);

    layer:setBtnOkText(param.okText);
    layer:setBtnCancelText(param.cancelText);
    print("layer = ", layer)
    AlertManager:show()

    return layer;
end

-- type == 1检查失败 type == 2 更新失败
function ObbDownloadLayer:showFailDiag(errorType)
    --local displayTitle   = "检查资源更新"
    local displayTitle   = localizable.updateLaye_check_resource_update
    --local displayContent = "检查资源更新失败，是否重试"
    local displayContent = localizable.updateLaye_check_resource_update_fail

    if errorType and errorType == 2 then
        --displayTitle   = "更新失败"
        displayTitle   = localizable.updateLaye_update_fail

        --displayContent = "资源更新失败，请检查你的网络后重试"
        displayContent = localizable.updateLaye_update_fail_check_net

    end

    local function restart()
        local ObbDownloadLayer   = require("lua.logic.login.ObbDownloadLayer")
        AlertManager:changeScene(ObbDownloadLayer:scene())
    end

    local layer = self:showOperateSureLayer(
                function()
                    AlertManager:closeAll()
                    self.bShowFailDaig = false

                    restart()
                end,
                function()
                    AlertManager:closeAll()
                    self.bShowFailDaig = false
                end,
                {
                    msg = displayContent,
                    showtype = AlertManager.BLOCK_AND_GRAY,
                    title = displayTitle,
                    --okText = "重试",
                    okText = localizable.updateLaye_reset,

                    uiconfig = "lua.uiconfig_mango_new.common.OperateSure2"
                }
    )
    layer.isCanNotClose = true
end

function ObbDownloadLayer:EnterGame()
    print("ObbDownloadLayer:EnterGame")
    restartLuaEngine("ObbDownload")
end

function ObbDownloadLayer:CompleteUpdate()
    self:EnterGame()
end

function ObbDownloadLayer:playEffect()

    if not self.img_bg then
        return
    end
    if 1 then
        return
    end
    if self.ChooseEffect == nil then
        local resPath = "effect/logineffect.xml"
        TFResourceHelper:instance():addArmatureFromJsonFile(resPath)
        local effect = TFArmature:create("logineffect_anim")

        effect:setAnimationFps(GameConfig.ANIM_FPS)
        effect:setPosition(ccp(self.img_bg:getSize().width/2,self.img_bg:getSize().height/2))

        self.img_bg:addChild(effect, 1)


        effect:addMEListener(TFARMATURE_COMPLETE,function()
            -- effect:removeMEListener(TFARMATURE_COMPLETE)
            -- effect:removeFromParent()
            -- self.ChooseEffect:playByIndex(1, -1, -1, 1)
        end)

        self.ChooseEffect = effect
    end

    self.ChooseEffect:playByIndex(0, -1, -1, 1)
end

function ObbDownloadLayer:LoadingEffect()

    if not self.img_bg then
        return
    end

    if self.loading == nil then
        local effect = SkeletonAnimation:create("ui_effect/spine/loading")
        effect:setAnimationFps(GameConfig.ANIM_FPS)
        effect:setPosition(ccp(0, GameConfig.WS.height/2 - 100))

        -- self.img_bg:addChild(effect, 1)

        self.img_bg:getParent():addChild(effect, 1)

        effect:addMEListener(TFARMATURE_COMPLETE,function()
            -- effect:removeMEListener(TFARMATURE_COMPLETE)
            -- effect:removeFromParent()
            -- self.loading:playByIndex(1, -1, -1, 1)
        end)

        self.loading = effect
    end

    self.loading:playByIndex(0, -1, -1, 1)
    self.loading:setVisible(true)
end




function ObbDownloadLayer:InitDownloadInfo(size)



end

return ObbDownloadLayer

