require('TFFramework.base.class')
DEBUG = 1
require('init')
EditLua = require('Editor.EditLua')

local print_ = print
function __G__TRACKBACK__(msg)
	if not DEBUG_EDITOR then return end

	print_("----------------------------------------");
	local msg = "LUA ERROR: " .. tostring(msg) .. "/n"
	msg = msg .. debug.traceback()
	print_(msg)
	TFLOGERROR(msg)
	bIsError = true
	print_("----------------------------------------");
end

function main()
    echo = print

	if DEBUG_EDITOR then 

	else 
		print = function () end
		TFLOGINFO = function () end
	end

	TFDirector.EditorModel = true
	TFDirector:start()
	local gameStartup = require('LuaScript.TFGameStartup'):new()
	TFLogManager:sharedLogManager():TFFtpSetUpload(false)
	TFLogManager:sharedLogManager():setCanWriteInfo(false)

	gameStartup:run()
	EditLua:init()
end
szGlobleResult = ""
nCmdNum = 0
function test(id, command, args)
	nCmdNum = nCmdNum + 1
	setGlobleString("")
	szGlobleResult = ""
	EditLua:cmd(id, command, args)
end

xpcall(main, __G__TRACKBACK__);
