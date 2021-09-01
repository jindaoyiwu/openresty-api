local redisCluster = require "resty.rediscluster"
local _M = {
}
function _M:new(config)
    local con = {
        name = "testCluster",
        serv_list = {                           --redis cluster node list(host and port),
            { ip = config.host1, port = config.port1 },
            { ip = config.host2, port = config.port2 },
            { ip = config.host3, port = config.port3 },
            { ip = config.host4, port = config.port4 },
            { ip = config.host5, port = config.port5 },
            { ip = config.host6, port = config.port6 }
        },

    }
    if (config.password) ~= nil then
        con.auth = config.password
    end

    local redCluster = redisCluster:new(con)
    if not redisCluster then
        ngx.log(ngx.ERR, "redis cluster connected fail: ")
    end
    return redCluster
end

return _M
