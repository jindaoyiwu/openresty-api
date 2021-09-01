--controller基类
local pairs = pairs

local _A = {
    jsonSafe = require("cjson.safe"),
    env = require("config"),
    helper = require("vendor.utils.helper"),
    apisUtil = require("lapis.util"),
    validate = require("lapis.validate"),
    memcache = require("config.memcache"),
    mysql = require("config.mysql"),
    redis = require("config.redis"),
    redisCluster = require("config.redis_cluster")
}

--新建controller实例
function _A:new(o)
    o = o or {}
    for k,v in pairs(self) do
        if not o[k] then
            o[k] = v
        end
    end
    return o
end



--页面没有找到
function _A:notFound(message)
    message = message or "not found"
    local res = {code=404,data={},message=message}
    return {json = res};
end

--显示错误
function _A:showError(message)
    message = message or "error"
    local res = {code=400,data={},message=message}
    return {json = res};
end

--返回成功
function _A:success(data,message)
    message = message or "success"
    data = data or {}
    local res = {code=200,data = data,message=message}
    return {json = res}
end

return _A
