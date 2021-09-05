local api = {}
function api:route(app)
    app:get("/api/test", function()
        --ngx.log(ngx.ERR, "cyzlog:", "11")
        return app.c:new("index/index", self):run();
    end)

    app:get("/api/test-redis", function() return app.c:new("index/testRedis", self):run(); end)

    app:get("/api/test-redis-cluster", function() return app.c:new("index/testRedisCluster", self):run(); end)

    app:get("/api/test-mysql", function(self) return app.c:new("index/testMysql", self):run(); end)

    app:post("/user/register", function (self) return app.c:new("user/register", self):run() end)

    app:get("/api/test1", function() return app.c:new("index/login", self):run(); end)

    app:match("/test", function(self)
        return { json = {
            success = true,
            message = "hello world"
        }}
    end)

    app:get("/", function()
        return "Welcome to Lapis112221 ";
    end)
end
return api