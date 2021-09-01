local api = {}
function api:route(app)
    app:get("/api/test", function()
        --ngx.log(ngx.ERR, "cyzlog:", "11")
        return app.c:new("index/index", self):run();
    end)
    app:get("/api/testredis", function()
        --ngx.log(ngx.ERR, "cyzlog:", "11")
        return app.c:new("index/testRedis", self):run();
    end)
    app:get("/api/test-redis-cluster", function()
        --ngx.log(ngx.ERR, "cyzlog:", "11")
        return app.c:new("index/testRedisCluster", self):run();
    end)

    app:get("/api/test-mysql", function(self) return app.c:new("index/testMysql", self):run(); end)

    app:post("/user/register", function (self) return app.c:new("user/register", self):run() end)

    app:post("/user/register1", function(self)
        ngx.log(ngx.ERR, "cyzlog:", type(self.params.user))
        return  "222222"..self.params.user
    end)

    app:get("/api/test1", function() return app.c:new("index/login", self):run(); end)

    app:match("/test", function(self)
        return { json = {
            success = true,
            message = "hello world"
        }}
    end)

    app:get("/", function()
        return "Welcome to Lapis112221 " .. env:get("DOCUMENT_PATH");
    end)
end
return api