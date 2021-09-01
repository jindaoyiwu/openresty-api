local helper = require("vendor.utils.helper")
local _E = {
    path = "",
}

function _E:load()
    local filename = self.path.."/.env"
    local data = {}
    local file = io.open(filename, "r")
    for line in file:lines() do
        --处理注释
        line = helper.trim(line)
        if (line ~= "" and string.find(line, "#") == nil) then
            --查找第一个等于号位置
            local pos = string.find(line, "=")
            --有等于号，并且不是第一个和最后一个位置
            if pos and pos ~= 1 and pos ~= string.len(line) then
                data[string.sub(line, 1, pos - 1)] = string.sub(line, pos + 1)


            end
        end
    end
    file:close()
    return data
end

function _E:get(key)
    local result = self:load()
    return result[key]
end

function _E:setPath(path)
    _E.path = path
end

return _E