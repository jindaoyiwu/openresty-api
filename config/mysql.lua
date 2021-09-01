local mysql = require('vendor.Mysql')
local _M = {}

function _M:instance()
    return mysql:new({
    })
end

return _M
