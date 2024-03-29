local config = require("lapis.config")
local env = require("vendor.utils.env")
--设置项目目录
env:setPath("/www/php/openresty-api")
config(env:get("LAPIS_ENVIRONMENT"), {
    mysql = {
        host = env:get("DB_HOST") or "127.0.0.1",
        port = env:get("DB_PORT") or 3306,
        password = env:get("DB_PASSWORD") or 123456,
        user = env:get("DB_USERNAME") or "root",
        database = env:get("DB_DATABASE") or "user",
    },
})

local _M = {}

function _M:get(key)
    return env:get(key)
end

return _M