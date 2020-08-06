local format = string.format

local NetOP = require("TFFramework.net.TFClientNetOp")
if tblS2CData then
	return require("TFFramework.net.TFClientNet")
end

tblS2CData = tblS2CData or {}
tblC2SData = tblC2SData or {}

TFClientNet = class ("TFClientNet", NetOP)

local TFClientNet = TFClientNet
local TFFunction = TFFunction

local instance
function TFClientNet:getInstance()
	if not instance then 
		instance = TFClientNet:create(0,true)
	end
	return instance
end

function TFClientNet:ctor(connType, notSingleton)
	TFClientNet.super.ctor(self, connType, notSingleton)

	self.recvHeadFunc = nil
	self.sendHeadFunc = nil
end

function TFClientNet:RecvCallback(nRet)
	if nRet <= 0 then
		print("net Recv error nRet = " , nRet);
		return ;
	end

	nProtoType = self:UnpackType()

	local headInfo = TFFunction.call(self.recvHeadFunc, self , nProtoType)
	if tblS2CData[nProtoType] == nil then
		print("[error]no this protocol " , format("%d",nProtoType))
		print(debug.traceback())
	else
		self:RecvData(nProtoType , tblS2CData[nProtoType](), headInfo)
	end
end

function TFClientNet:setName(name)
	self.clientNet:setName(name)
end


function TFClientNet:DecodeRecord(nProtoType)
	if tblS2CData[nProtoType] == nil then
		print("[error]no this protocol " , format("%d",nProtoType))
		print(debug.traceback())
	else
		self:RecvData(nProtoType , tblS2CData[nProtoType]())
	end
end

function TFClientNet:ConnectCallback(nRet)
	print("ConnectCallback ",nRet)
end

function TFClientNet:CloseCallback(nRet)
	print("CloseCallback ",nRet)
end

function TFClientNet:Send(nType, tblData, bEncrypteByRsa)
	if tolua.isnull(self.clientNet) then return end

	self:PackType(nType)
	TFFunction.call(self.sendHeadFunc, self, nType)
	return self:SendData(tblC2SData[nType](), tblData, nType, bEncrypteByRsa)
end

function TFClientNet:Connect(szIp , nPort, ConnectCallback, RecvCallback, CloseCallback , bType)
	bType = bType or 0
	self:setConnectType(bType)
	ConnectCallback = ConnectCallback 	or function(...) self:ConnectCallback(...) end
	RecvCallback 	= RecvCallback 		or function(...) self:RecvCallback(...) end
	CloseCallback 	= CloseCallback 	or function(...) self:CloseCallback(...) end
	return TFClientNet.super.Connect(self, szIp , nPort , ConnectCallback , RecvCallback , CloseCallback)
end

function TFClientNet:SetEncodeKeys(tblInt , bEncode)--true Encode , false Decode , nil Both
	if bEncode == nil then
		self:SetEncodeKeysImpl(tblInt , true)
		self:SetEncodeKeysImpl(tblInt , false)
	else
		self:SetEncodeKeysImpl(tblInt , bEncode)
	end
end

function TFClientNet:SetDecodeKeys(tblInt)
	return self:SetEncodeKeysImpl(tblInt , false)
end

function TFClientNet.createStruct(nProtoType, tblRecv)-- stream server to client packet
	local tblStruct
	tblProtoData = tblS2CData[nProtoType]()
	if tblProtoData == nil then
		print("can't find the code :" , nProtoType)
	else
		local tblName = tblProtoData[3]
		tblStruct = self:PackStruct(tblName , tblRecv)
	end
	return tblStruct
end

function TFClientNet:setRecvSerialize(bSerialize)
	self.bRecvSerialize = bSerialize
end

function TFClientNet:setSendSerialize(bSerialize)
	self.bSendSerialize = bSerialize
end

function TFClientNet:setRecvCallBack(funcCallBack)
	self.funcRecvData = funcCallBack
end

function TFClientNet:SetUseDKeys(enable) 
	self.clientNet:SetUseDKeys(enable) 
end

function TFClientNet:setKCPWndSize(sndwnd, rcvwnd) 
	self.clientNet:setKCPWndSize(sndwnd, rcvwnd) 
end

function TFClientNet:setKCPMTU(mtu)
	self.clientNet:setKCPMTU(mtu)
end

function TFClientNet:setKCPSession(session)
	self.clientNet:	setKCPSession(session)
end

function TFClientNet:setKCPMinRTO(rto)
	self.clientNet:setKCPMinRTO(rto)
end

function TFClientNet:setKCPParams(nodelay, rval, resend, nc)
	self.clientNet:setKCPParams(nodelay, rval, resend, nc)
end

return TFClientNet