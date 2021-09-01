local redis = require "resty.redis"
local _M = {
}
function _M:new(config)
    local red = redis:new()
    red:set_timeouts(config.timeout, config.timeout, config.timeout) -- 1 sec connect, send, and read timeout thresholds (in ms)
    local ok, err = red:connect(config.host, config.port)
    if not ok then
        ngx.log(ngx.ERR, "redis connected fail:", err)
        return err
    end
    if (config.password) ~= nil then
        local res, err = red:auth(config.password)
        if not res then
            ngx.log(ngx.ERR, "rfailed to authenticate: ", err)
            return
        end
    end
    return red
end

return _M
