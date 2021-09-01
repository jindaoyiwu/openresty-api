local env = require("vendor.utils.env")
local redis = require('vendor.RedisCluster')
local _M = {}

function _M:instance()
    return redis:new({
        host1 = env:get("REDIS_CLUSTER_HOST_1") or "127.0.0.1",
        port1 = env:get("REDIS_CLUSTER_PORT_1") or 6379,
        host2 = env:get("REDIS_CLUSTER_HOST_2") or "127.0.0.1",
        port2 = env:get("REDIS_CLUSTER_PORT_2") or 6379,
        host3 = env:get("REDIS_CLUSTER_HOST_3") or "127.0.0.1",
        port3 = env:get("REDIS_CLUSTER_PORT_3") or 6379,
        host4 = env:get("REDIS_CLUSTER_HOST_4") or "127.0.0.1",
        port4 = env:get("REDIS_CLUSTER_PORT_4") or 6379,
        host5 = env:get("REDIS_CLUSTER_HOST_5") or "127.0.0.1",
        port5 = env:get("REDIS_CLUSTER_PORT_5") or 6379,
        host6 = env:get("REDIS_CLUSTER_HOST_6") or "127.0.0.1",
        port6 = env:get("REDIS_CLUSTER_PORT_6") or 6379,
        password = env:get("REDIS_PASSWORD") or nil,
        timeout = env:get("REDIS_TIMEOUT") or 10000
    })
end

return _M
