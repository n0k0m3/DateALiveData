
local string = string 
local type = type
local table = table 
local math = math 
local tostring = tostring


local tblTypeNum = {
	["n1"]	= 0,
	["n2"]	= 0,
	["n4"]	= 0,
	["s"]	= 2,
	["a"]	= 2,
	['v4']	= 0,
	['v8']	= 0,
	["av4"]	= 2,
	["av8"] = 2,
	["an1"]	= 2,
	['t']	= 2,
	['ts']	= 2,
	['tv4'] = 0,
	['tv8'] = 0,
	['pv4'] = 2,
	['pv8'] = 2,
	["srsa"]= 2,
	['f4']	= 5,
	['b']	= 0,
	['sv4'] = 0,
}

local tblUnpackFunc = 0
local tblPackFunc = 0

local NetOP = class("NetOP")

function NetOP:ctor(connType, notSingleton)
	self.bRecvSerialize	= true
	self.bSendSerialize	= false
	self.funcRecvData	= nil

	connType = connType or 0

	self.connType = connType

	if connType == 0 then 
        if notSingleton then 
			self.clientNet = TFClientSocket:create(0)
            TFDirector:addRetainObj(self.clientNet)
        else        
			self.clientNet = TFClientSocket:GetInstance()
        end
	else 
		self.clientNet = TFClientSocket:create(connType)
        TFDirector:addRetainObj(self.clientNet)
	end
	self.clientNet:setUseNetCheck(false)
end

function NetOP:isValid()
	return not tolua.isnull(self.clientNet)
end

function NetOP:setConnectType(nType) --0 long ,1 short
	if nType == 0 then
		self.clientNet:setNetType(0)
	else
		self.clientNet:setNetType(1)
	end
end

function NetOP:SetConnTOT(nSec)
	self.clientNet:SetConnTOT(nSec)
end

function NetOP:setMaxCloseSec(nSec)
	self.clientNet:setMaxCloseSec(nSec)
end

function NetOP:PackSubStruct(tblName , tblData)
	local tblSubStruct	= {}
	local bMulTable		= tblName[1]
	local tblName		= tblName[2]
	local szName		= 0
--	table.remove(tblName , 1)
	if bMulTable == false then
		for i = 2 , #tblName do
			szName = self:GetValueName(tblName[i])
			tblSubStruct[szName] = self:PackSingleValue(tblName[i] , tblData[i - 1])
		end
	else
		for i = 1 , #tblData do
			local tblTemp = {}
			for k = 2 , #tblName do
				szName = self:GetValueName(tblName[k])
				tblTemp[szName] = self:PackSingleValue(tblName[k] , tblData[i][k - 1])
			end
			table.insert(tblSubStruct , tblTemp)
		end
	end
	return tblSubStruct
end

function NetOP:PackSingleValue(tblName , tblData)
	local tblPack
	if tblData == NULL then
		tblPack = nil
	elseif type(tblName) == 'table' then
		tblPack = self:PackSubStruct(tblName , tblData)
	else
		tblPack = tblData
	end
	return tblPack
end

function NetOP:GetValueName(tblName)
	if type(tblName) == 'table' then
		return tblName[2][1]
	end
	return tblName
end

function NetOP:PackStruct(tblName , tblData)
	local tblStruct = {}
	local szName	= 0
	for i = 1 , #tblName do
		szName = self:GetValueName(tblName[i])
		tblStruct[szName] = self:PackSingleValue(tblName[i] , tblData[i])
	end
	return tblStruct;
end


function NetOP:SetEncodeKeysImpl(tblInt , bEncode)
	return self.clientNet:SetEncodeKeys(tblInt[1],tblInt[2],tblInt[3],tblInt[4],tblInt[5],tblInt[6],tblInt[7],tblInt[8] , bEncode)
end

function NetOP:UnpackType()
	return self.clientNet:UnpackType()
end

function NetOP:UnpackInt()
	return self.clientNet:UnpackInt()
end

function NetOP:UnpackShort()
	return self.clientNet:UnpackShort()
end

function NetOP:UnpackByte()
	return self.clientNet:UnpackByte()
end

function NetOP:UnpackHeadInt()
	return self.clientNet:UnpackHeadInt()
end

function NetOP:UnpackHeadInt64()
	return self.clientNet:UnpackHeadInt64Lua()
end

function NetOP:UnpackString()
	local nLen = self.clientNet:UnpackIntVar32()
	local s = ""
	if nLen ~= 0 then
		s = self.clientNet:UnpackString(nLen)
	end
	return s
end

function NetOP:UnpackStringNoLen()
	return self.clientNet:UnpackString()
end

function NetOP:UnpackIntVar32()
	return self.clientNet:UnpackIntVar32()
end

function NetOP:UnpackSIntVar32()
	return self.clientNet:UnpackSIntVar32()
end

function NetOP:UnpackBool()
	local bRet = self.clientNet:UnpackIntVar32()
	if bRet == 0 then
		return false
	else
		return true
	end
end


function NetOP:UnpackIntVar64()
	return self.clientNet:UnpackIntVar64()
end

function NetOP:UnpackIntVar64Lua()
	return self.clientNet:UnpackIntVar64Lua()
end

function NetOP:UnpackFloat()
	return self.clientNet:UnpackFloat()
end

function NetOP:CloseSocket(release)
	if not tolua.isnull(self.clientNet) then 
		self.clientNet:CloseSocket()
		if release then 
			TFDirector:removeRetainObj(self.clientNet)
		end
	end
end

function NetOP:Connect(szIp , nPort , connectHandle , receiveHandle , closeHandle)
	return self.clientNet:Connect(szIp, nPort,connectHandle,receiveHandle,closeHandle)
end


function NetOP:PreUnpackByte()
	return self.clientNet:PreUnpackTagType()
end

function NetOP:PreUnpackIntVar32()
	return self.clientNet:PreUnpackWiretype()
end

function NetOP:GetReadPacketSize()
	return self.clientNet:GetReadPacketSize()
end

function NetOP:TypeCount(nIndex , szType)
	nIndex = nIndex or 0
	local nType = 0
	if type(szType) == "table" then
		nType = tblTypeNum['t']
	else
		nType = tblTypeNum[szType]
	end
	return (nIndex * 8 + nType)
end

function NetOP:UnpackArray(szType)
	local tblArray = {}
	local szSubType = string.sub(szType,2,-1)
	local nLen = self:UnpackIntVar32()
	for i = 1 , nLen do
		table.insert(tblArray , tblUnpackFunc[szSubType](self))
	end
	return tblArray
end

function NetOP:UnpackTable(tblData , nTagType , nLimitLen)
	local tblRecv = {}
	local bMulTable = tblData[1]
	local tblData = tblData[2]
	local nLastLen = self:GetReadPacketSize()

	while self:PreUnpackIntVar32() == nTagType do
		local nLen = nil
		if #tblData > 1 or bMulTable == false then-- no repeat msg
			self:UnpackIntVar32()--wire type
			nLen = self:UnpackIntVar32()--single list length
		elseif #tblData == 1 and type(tblData[1]) == 'table' then -- repeated include only one repeated
			self:UnpackIntVar32()--wire type
			nLen = self:UnpackIntVar32()--single list length
        elseif #tblData == 1 and bMulTable then
			self:UnpackIntVar32()--wire type
			nLen = self:UnpackIntVar32()--single list length
		end
		local tblSubRecv = {}
		for i = 1 , #tblData do
			local nTempLen = self:GetReadPacketSize()
			
			if nLen and nLen == 0 then 
				tblSubRecv[i] = NULL
			else 
				tblSubRecv[i] = self:UnpackSingleVaule(tblData , i , nLen)
			end
			if nLen then
				nLen = nLen - (nTempLen - self:GetReadPacketSize())
			end
		end

		if bMulTable == true then
			table.insert(tblRecv , tblSubRecv)
		else
			tblRecv = tblSubRecv
			break;
		end

		if nLastLen and nLimitLen and nLastLen - self:GetReadPacketSize() == nLimitLen then
			break;
		end
	end
	return tblRecv
end

function NetOP:UnpackRepeatInt(szData , nIndex)
	local tblArray = {}
	local szSubType = string.sub(szData , 2 , -1)
	while self:PreUnpackIntVar32() == self:TypeCount(nIndex , szSubType) do
		self:UnpackIntVar32()
		table.insert(tblArray , tblUnpackFunc[szSubType](self))
	end
	return tblArray
end

function NetOP:UnpackRepeatIntPacked(szData)
	local nLen		 = self:UnpackIntVar32()
	local nPacketLen = self:GetReadPacketSize();
	local tblArray	 = {}
	local szType	 = string.sub(szData , 2 , -1)
	while nPacketLen - self:GetReadPacketSize() < nLen do
		table.insert(tblArray,tblUnpackFunc[szType](self))
	end
	return tblArray;
end



tblUnpackFunc = {
				n1	 = NetOP.UnpackByte ,
				n2	 = NetOP.UnpackShort ,
				n4	 = NetOP.UnpackInt,
				s	 = NetOP.UnpackString,
				v4 	 = NetOP.UnpackIntVar32,
				v8 	 = NetOP.UnpackIntVar64, --NetOP.UnpackIntVar64Lua or NetOP.UnpackIntVar64,
				av4  = NetOP.UnpackArray,
				av8	 = NetOP.UnpackArray,
				an1	 = NetOP.UnpackArray,
				t 	 = NetOP.UnpackTable,
				ts	 = NetOP.UnpackRepeatInt,
				tv4	 = NetOP.UnpackRepeatInt,
				tv8	 = NetOP.UnpackRepeatInt,
				pv4	 = NetOP.UnpackRepeatIntPacked,
				pv8	 = NetOP.UnpackRepeatIntPacked,
				f4	 = NetOP.UnpackFloat,
				b	 = NetOP.UnpackBool,
				sv4  = NetOP.UnpackSIntVar32,
				
				}

function NetOP:UnpackSingleVaule(tblData , i , nLimitLen)
	local tblRecv	= 0
	local tblSubData= tblData[i]
	local nType	= self:PreUnpackIntVar32();
	local nCurType	= self:TypeCount(i , tblSubData)
	if  nType == nCurType then
		if type(tblSubData) == "table" then
			tblRecv = tblUnpackFunc['t'](self, tblSubData , nType , nLimitLen)
		else
			if string.sub(tblSubData , 1, 1) ~= 't' then
				self:UnpackIntVar32()
			end
			tblRecv = tblUnpackFunc[tblSubData](self, tblSubData , i);
		end
	else
		if math.floor(nType * 0.125) == math.floor(nCurType * 0.125) then
			print("[error]not the same type at " , i , tblSubData , tblData, nType, nCurType, nLimitLen)
		end
		tblRecv = NULL
	end
	return tblRecv
end

function NetOP:RecvData(nProtoType , tblProtoData, headInfo) 
	local tblRecv = {}
	local tblCB = tblProtoData[1]
	local tblData = tblProtoData[2]
	local tblName = tblProtoData[3]
	for i = 1, #tblData do
		tblRecv[i] = self:UnpackSingleVaule(tblData , i)
	end
	local h = require('TFFramework.'..tblCB[1])
	local funcCallBack = nil
	if h == nil then
		funcCallBack = _G[tblCB[2]]
	else
		funcCallBack = h[tblCB[2]]
	end

	if self.bRecvSerialize then
		tblRecv = self:PackStruct(tblName , tblRecv)
	end
	if self.funcRecvData then
		funcCallBack = self.funcRecvData
	end

	tblRecv.__headInfo__ = headInfo

	funcCallBack(nProtoType , tblRecv)
end

--------------------------------------------------------------------Send
function NetOP:SendImpl(bRsa)
	if bRsa then
		return self.clientNet:Send(bRsa)
	else
		return self.clientNet:Send()
	end
end

function NetOP:GetWritePacketSize()
	return self.clientNet:GetWritePacketSize();
end


function NetOP:PacketBufInsert(nNum , nIndex)
	return self.clientNet:PacketBufInsert(nNum , nIndex)
end

function NetOP:SubPack()
	return self.clientNet:SubPack()
end
function NetOP:PackType(nNum)
	return self.clientNet:PackType(nNum)
end

function NetOP:PackInt(nNum)
	return self.clientNet:PackInt(nNum)
end

function NetOP:PackShort(nNum)
	return self.clientNet:PackShort(nNum)
end

function NetOP:PackByte(nNum)
	return self.clientNet:PackByte(nNum)
end

function NetOP:PackHeadInt(nNum)
	return self.clientNet:PackHeadInt(nNum)
end

function NetOP:PackHeadInt64(nNum)
	local num = tostring(nNum)
	return self.clientNet:PackHeadInt64Lua(num, #num)
end

function NetOP:PackString(szStr)
	self.clientNet:PackIntVar32(#szStr)
	self.clientNet:PackString(szStr , #szStr)
end

function NetOP:PackStringByRsa(szStr)
	self.clientNet:PackStringByRsa(szStr , #szStr)
end

function NetOP:PackIntVar32(nNum)
	return self.clientNet:PackIntVar32(nNum)
end

function NetOP:PackIntVar64(nNum)
	return self.clientNet:PackIntVar64(nNum)
end

function NetOP:PackIntVar64Lua(nNum)
	local num = tostring(nNum)
	return self.clientNet:PackIntVar64Lua(num, #num)
end

function NetOP:PackSIntVar32(nNum)
	return self.clientNet:PackSIntVar32(nNum)
end

function NetOP:PackBool(nNum)
	if nNum then
		nNum = 1
	else
		nNum = 0
	end
	return self.clientNet:PackIntVar32(nNum)
end

function NetOP:PackFloat(nNum)
	return self.clientNet:PackFloat(nNum)
end

function NetOP:PackEncytpeByRsa()
	return self.clientNet:PackEncytpeByRsa()
end

function NetOP:PackArray(tblData , szType)
	local nLen = #tblData
	if nLen <=0 then
		print("PackArray nLen errr, ",nLen)
		return nil
	end
	local nPreSize = self:GetWritePacketSize()
	local szSubType = string.sub(szType,2,-1)
	for i = 1 , nLen do
		tblPackFunc[szSubType](self, tblData[i])
	end
	self:PacketBufInsert(self:GetWritePacketSize() - nPreSize, nPreSize)--single list length
end

function NetOP:PackSingleElement(tblData , tblType , nType)
	for k = 1 , #tblData do
		self:PackIntVar32(nType)--wire type
		for i = 1, #tblType do
			local nSubType = self:TypeCount(i , tblType[i])
			if type(tblType[i]) == "table" then
				tblPackFunc['t'](self, tblData[k][i], tblType[i] , nSubType)
			else
				if string.sub(tblType[i] , 1, 1) ~= 't' then
					tblPackFunc[tblType[i]](self, tblData[k][i], tblType[i])
				else
					tblPackFunc[tblType[i]](self, tblData[k][i], tblType[i], nSubType)
				end
			end
		end
	end
end

function NetOP:PackTable(tblData , tblType , nType)
	local bMulTable = tblType[1]
	local tblType = tblType[2]
	if bMulTable == true then
		if #tblType == 1 then--{an1}
			self:PackSingleElement(tblData ,tblType , nType)
			return
		else--{sub msg repeat}
			for k = 1 , #tblData do
				self:PackIntVar32(nType)--wire type
				local nPreSize = self:GetWritePacketSize()
				self:PackSubTable(tblData[k] , tblType)
				self:PacketBufInsert(self:GetWritePacketSize() - nPreSize, nPreSize)--single list length
			end
		end
	else-- submsg no repeat
		self:PackIntVar32(nType)--wire type
		local nPreSize = self:GetWritePacketSize()
		self:PackSubTable(tblData , tblType , true)
		self:PacketBufInsert(self:GetWritePacketSize() - nPreSize, nPreSize)--single list length
	end
end

function NetOP:PackSubTable(tblData , tblType , bNoRepeat)
	for i = 1, #tblType do
		if tblData[i] ~= NULL then
			local nSubType = self:TypeCount(i , tblType[i])
			if type(tblType[i]) == "table" then
				tblPackFunc['t'](self, tblData[i], tblType[i], nSubType)
			else
				if string.sub(tblType[i] , 1, 1) ~= 't' then
					if #tblType > 1 or bNoRepeat then
						self:PackIntVar32(nSubType)
					end
					tblPackFunc[tblType[i]](self, tblData[i], tblType[i])
				else
					tblPackFunc[tblType[i]](self, tblData[i],tblType[i], nSubType)
				end
			end
		end
	end
end

function NetOP:PackRepeatInt(tblData ,szType, nType)
	local tblArray = {}
	local szSubType = string.sub(szType , 2 , -1)
	for i = 1 , #tblData do
		self:PackIntVar32(nType)
		tblPackFunc[szSubType](self, tblData[i])
	end
end

function NetOP:PackRepeatIntPacked(tblData , szType)
	local nLen		 = self:UnpackIntVar32()
	local nPacketLen = self:GetWritePacketSize();
	local szSubType	 = string.sub(szType , 2 , -1)
	for i = 1 , #tblData do
		tblPackFunc[szSubType](self, tblData[i])
	end
	self:PacketBufInsert(self:GetWritePacketSize() - nPacketLen , nPacketLen)--single list length
	return tblArray;
end

tblPackFunc   = {
				n1	 = NetOP.PackByte ,
				n2	 = NetOP.PackShort ,
				n4	 = NetOP.PackInt,
				s	 = NetOP.PackString,
				srsa = NetOP.PackStringByRsa,
				v4 	 = NetOP.PackIntVar32,
				v8 	 = NetOP.PackIntVar64, --NetOP.PackIntVar64Lua or NetOP.PackIntVar64,
				av4  = NetOP.PackArray,
				av8	 = NetOP.PackArray,
				an1  = NetOP.PackArray,
				t 	 = NetOP.PackTable,
				ts	 = NetOP.PackRepeatInt,
				tv4	 = NetOP.PackRepeatInt,
				tv8	 = NetOP.PackRepeatInt,
				pv4	 = NetOP.PackRepeatIntPacked,
				pv8	 = NetOP.PackRepeatIntPacked,
				f4	 = NetOP.PackFloat,
				b	 = NetOP.PackBool,
				sv4  = NetOP.PackSIntVar32,
}

function NetOP:UnpackSingleValue(tblName , tblData)
	local valData = {}
	if tblData == nil then
		valData = NULL
	elseif type(tblName) == 'table' then
		valData = self:UnpackSubStruct(tblName , tblData)
	else
		valData = tblData
	end
	return valData
end

function NetOP:UnpackSubStruct(tblName , tblData)
	local tblSubStruct	= {}
	local bMulTable		= tblName[1]
	local tblName		= tblName[2]
	local szName		= 0
	local i				= 0
	local k				= 0

	if bMulTable == false then
		for i = 2 , #tblName do
			szName = self:GetValueName(tblName[i])
			tblSubStruct[i - 1] = self:UnpackSingleValue(tblName[i] , tblData[szName])
		end
	else
		for i = 1 , #tblData do
			local tblTemp = {}
			for k = 2 , #tblName do
				szName = self:GetValueName(tblName[k])
				tblTemp[k - 1] = self:UnpackSingleValue(tblName[k] , tblData[i][szName])
			end
			table.insert(tblSubStruct , tblTemp)
		end
	end
	return tblSubStruct
end

function NetOP:UnpackStruct(tblName , tblData)
	local tblStruct = {}
	local szName 	= 0
	for i = 1 , #tblName do
		szName = self:GetValueName(tblName[i])
		tblStruct[i] =  self:UnpackSingleValue(tblName[i] , tblData[szName])
	end
	return tblStruct
end

function NetOP:SendData(tblType , tblData , nProtoType , bEncrypteByRsa)
	local tblName	= tblType[3]
	local tblType	= tblType[2]

--	self:UnpackStruct(tblName , tblData)
	if self.bSendSerialize then
		tblData = self:UnpackStruct(tblName , tblData)
	end
	if #tblData < #tblType then
		print("Send Packet Data not long enough, add NULL for option")
		--return nil

		local n = #tblType
		local idx = #tblData
		while idx < n do 
			table.insert(tblData, NULL)
			idx = idx + 1
		end
	end
	for i = 1, #tblData do
		if tblData[i] ~= NULL then
			local nType = self:TypeCount(i , tblType[i])
			if type(tblType[i]) == "table" then
				tblPackFunc['t'](self, tblData[i],tblType[i] , nType)
			else
				if string.sub(tblType[i] , 1, 1) ~= 't' then
					self:PackIntVar32(nType)
					tblPackFunc[tblType[i]](self, tblData[i],tblType[i])
				else
					tblPackFunc[tblType[i]](self, tblData[i],tblType[i] , nType)
				end
			end
		end
	end
	if bEncrypteByRsa then
		self:PackEncytpeByRsa()
	end
	return self:SendImpl()
end

function NetOP:SetNetLogEnable(bEnable)
	self.clientNet:SetNetLogEnable(bEnable)
end

function NetOP:getTotFlow()
	return self.clientNet:getTotFlow()
end

function NetOP:setMaxConnectSec(nSec)
	self.clientNet:setMaxConnectSec(nSec)
end

function NetOP:setEncodeEnable(bEnable)
	self.clientNet:setEncodeEnable(bEnable)
end

function NetOP:setDKeys(...)
	self.clientNet:setDKeys(...)
end

function NetOP:setHeadToken(...)
	self.clientNet:setHeadToken(...)
end

function NetOP:setUseShortPackLen(...)
	self.clientNet:setUseShortPackLen(...)
end

return NetOP