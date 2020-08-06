TFIMManager = nil
local userIMSDK = true

if not userIMSDK then
	return TFIMManager
end
if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
	return TFIMManager
end

if QQIMSDKManager  == nil then
	return TFIMManager
end

if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
	if TFDeviceInfo:getCurAppVersion() < "2.00" then
		return TFIMManager
	end
end 

if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 then
	TFIMManager = QQIMSDKManager:Inst()
end


local strAppKey = "1543541937"
local strAppSecurity = "f613d6158474d4bdf2fe986e2261de8d"


local function getFormatValue(str,beginStr,endStr,beginPos,valueType)
	local len = string.len(str)
	beginPos = beginPos or 0
	local pos = string.find(str,beginStr,beginPos)
	if pos >= len then
		return nil,pos
	end 
	pos = pos + string.len(beginStr)
	local pos0 = len
	if endStr ~= nil then
		pos0 = string.find(str,endStr,pos) - 1  
	end
	local value = string.sub(str,pos,pos0)
	if valueType == "number" then
		value = tonumber(value)
	end
	return value,pos0
end


function TFIMManager:initSDk( openID )
	if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 then
		print("TFIMManager -->init")
	    TFIMManager:Init(strAppKey,strAppSecurity,openID)

	    if self.pollTimer == nil then
	    	self.pollTimer = TFDirector:addTimer( 1,-1, nil ,function ()
	    		TFIMManager:Poll()
	    	end)
	    end

	    local function OnUploadFileHandlerCallBack( code, filePath , fileID )
	    	if code ~= 0 then
	    		return
	    	end
			ChatManager:fillTalkMyMsg(nil,filePath,fileID)
		end

		TFIMManager:setOnUploadFileHandler(OnUploadFileHandlerCallBack);


		--[[
			Callback when download voice file successful or failed.
			
			@param code: a GCloudVoiceCompleteCode code . You should check this first.
			@param filePath: file to download to .
			@param fileID: if success ,get back the id for the file.
		]]
		local function OnDownloadFileHandlerCallBack( code, filePath , fileID )
			if code ~= 0 then
	    		return
	    	end
	    	if fileID == ChatManager.curDowUrlId then
	    		ChatManager:playTalk(fileID,filePath)
	    	end
		end


		TFIMManager:setOnDownloadFileHandler(OnDownloadFileHandlerCallBack);

		--[[
		Callback when finish a voice file play end.
		@param filePath: file had been plaied.
		]]

		local function OnPlayRecordedFileHandlerCallBack( code, filePath )
			if code ~= 0 then
	    		return
	    	end
	    	ChatManager:talkFinish(filePath)
		end
		TFIMManager:setOnPlayRecordedFileHandler(OnPlayRecordedFileHandlerCallBack);

		--转文本回调
		local function OnSpeechToTextHandlerCallBack( code, filePath , result )
			if code ~= 0 then
	    		return
	    	end
			if filePath ~= nil and result ~= nil then
				ChatManager:sendTalkMessage(result,filePath)
			end
		end

		TFIMManager:setOnSpeechToTextHandler(OnSpeechToTextHandlerCallBack);

		--录音过程回调完成回调
		-- local function OnRecordingHandlerCallBack( code, pAudioData , nDataLength )
		-- 	if code ~= 0 then
	 --    		return
	 --    	end
		-- end
		-- TFIMManager:setOnRecordingHandler(OnRecordingHandlerCallBack);
	end
end

function TFIMManager:Logout()

end

return TFIMManager