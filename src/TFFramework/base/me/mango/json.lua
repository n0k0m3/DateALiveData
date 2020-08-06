json = {}
local json = json

local cjson = require("cjson")
cjson.encode_keep_buffer(false)

function json.encode(var)
    local status, result = pcall(cjson.encode, var)
    if status then return result end
    print("json.encode() - encoding failed: %s", tostring(result))
end

function json.decode(text)
    if type(text) ~= "string" then
        return nil
    end
    local status, result = pcall(cjson.decode, text)
    if status then return result end
    print("json.decode() - decoding failed: %s", tostring(result))
end

json.null = cjson.null

return json