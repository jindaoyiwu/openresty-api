local require = require
local pairs = pairs


local _M = {
	model = require("lapis.db.model").Model,
	jsonSafe = require("cjson.safe"),
	env = require("config"),
	helper = require("vendor.utils.helper"),
	apisUtil = require("lapis.util"),
	memcache = require("config.memcache"),
	mysql = require("config.mysql"),
	redis = require("config.redis"),
	redisCluster = require("config.redis_cluster")
}

--新建Model
function _M:new(o)
	o = o or {}
	o.err = {} --存储错误信息
	for k,v in pairs(self) do
		if not o[k] then
			o[k] = v
		end
	end
	return o
end



return _M
