local db = require("lapis.db")

local _M = {
}
function _M:new(conf)
    return db
end
return _M
