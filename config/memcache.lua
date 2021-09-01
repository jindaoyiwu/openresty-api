local env = require("vendor.utils.env")
local memcache = require('vendor.Memcache')
local _M = {}

function _M:instance()
    return memcache:new({
        host = env:get("MEMCACHE_HOST") or "127.0.0.1",
        port = env:get("MEMCACHE_PORT") or 11211,
        timeout = env:get("MEMCACHE_TIMEOUT") or 10000}
    )
end

return _M
