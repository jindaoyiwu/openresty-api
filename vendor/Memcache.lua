local memcached = require "resty.memcached"
local _M = {
}

function _M:new(config)
    local memcache, err = memcached:new()
    if not memcache then
        ngx.log(ngx.ERR, "memcache:", err)
        return err
    end
    memcache:set_timeout(config.timeout)
    local ok, err = memcache:connect(config.host, config.port)
    if not ok then
        ngx.log(ngx.ERR, "memcache connected fail:", err)
        return err
    end
    return memcache
end

return _M
