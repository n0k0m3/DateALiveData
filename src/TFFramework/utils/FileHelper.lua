local FileHelper = {}

local function GetDirs(root, pathes)
	pathes = pathes or { dirs = {}, files = {} }
    for entry in lfs.dir(root) do
        if entry ~= '.' and entry ~= '..' then
            local path = root .. '/' .. entry
            local attr = lfs.attributes(path)            
            if attr.mode == 'directory' then
				pathes.dirs[entry] = { dirs = {}, files = {} }
                GetDirs(path, pathes.dirs[entry])
            else
                table.insert(pathes.files, entry)
            end
        end
    end
    return pathes
end

function FileHelper:GetDirInfos(root)
    return GetDirs(root)
end

return FileHelper