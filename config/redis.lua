local env = require("config")
local redis = require('vendor.Redis')
local _M = {}

function _M:instance()
    return redis:new({
        host = env:get("REDIS_HOST") or "127.0.0.1",
        port = env:get("REDIS_PORT") or 11211,
        password = env:get("REDIS_PASSWORD") or nil,
        timeout = env:get("REDIS_TIMEOUT") or 10000
    })
end

return _M
