TFClientUpdateClass = TFClientUpdate
TFClientUpdate = TFClientUpdate:GetClientUpdate()

if not TFClientUpdate.initConfig then 
    function TFClientUpdate:initConfig()
        if TFClientResourceUpdate then
            local newUpdateFun =  TFClientResourceUpdate:GetClientResourceUpdate()

            newUpdateFun:SetUpdateLastBinFile("/../Library/lastfile.bin")
            if CC_PLATFORM_WIN32 == CC_TARGET_PLATFORM then
                newUpdateFun:SetUpdateLastestFile("check.xml")
            else
                newUpdateFun:SetUpdateLastestFile("check.xml?xxx=" .. TFDeviceInfo:getMachineOnlyID())
            end
            newUpdateFun:SetUpdateDefaultVersion("1.0.01")
            return
        end
        
        TFClientUpdate:SetUpdateLastBinFile("/../Library/lastfile.bin")
        TFClientUpdate:SetUpdateLastestFile("version.xml")
        TFClientUpdate:SetUpdateEditionPath("edition/")
        TFClientUpdate:SetUpateVersionFileType(".xml")
        TFClientUpdate:SetUpdateDefaultVersion("1.0.0")

    end
end

TFClientUpdate:initConfig()
return  TFClientUpdate