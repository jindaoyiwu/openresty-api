local _C = require("vendor.Controller"):new { _VERSION = '1.00' }

--测试memcache
function _C:index()
    local mem = self.memcache:instance()
    mem:set('name', 11)
    local a = mem:get('name')
    mem:set_keepalive(10000, 100)
    return self:success({ name = "1111", a = a })
end
--测试redis
function _C:testRedis()
    local redis = self.redis:instance()
    redis:set("name", 22)
    local a = redis:get("name")

    return self:success({ name = "2222", a = a, b = { 1, 2, 3 } })
end
--测试RedisCluster
function _C:testRedisCluster()
    local redisCluster = self.redisCluster:instance()
    redisCluster:set("name", "cyz")
    redisCluster:set("name1", "cyz1")
    redisCluster:set("name2", "cyz2")
    local v, err = redisCluster:get("name")
    redisCluster:init_pipeline()
    redisCluster:get("name")
    redisCluster:get("name1")
    redisCluster:get("name2")

    local res, err = redisCluster:commit_pipeline()
    if not res then
        return self:showError(err)
    else
        return self:success({ a = v, b = { 1, 2, 3 }, pipline = res })
    end

end

--测试数据库
function _C:testMysql()
    local db = self.mysql:instance()
    local res1 = db.query("SELECT * FROM test")
    local res2 = db.query("UPDATE test SET name = ?", "blue")
    --local res3 = db.query("INSERT INTO test (id, name) VALUES (?, ?)", 25, "dogman")
    return self:success({ res1 = res1, res3 = res3, res2 = res2 })
end

function _C:testModel()

end

function _C:login()
    return self:success({ name = "2222" })
end
return _C