local db = require("lapis.db")

local _M = {
}
function _M:new()
    return db
end
return _M
