# openresty-api
[中文](https://github.com/jindaoyiwu/openresty-api/blob/main/README-CN.md)
1. Introduction: This is the API framework of openresty, which arranges the operation method in openresty, and is that developers who use openresty can develop more efficiently. (this framework does not contain HTML templates)

2、What is openresty? It is a high-performance web platform based on nginx and Lua[ [official website](http://openresty.org/)

3、What can openresty do? Openresty is the first mock exam in nginx, which is equivalent to Lua being a fast model of nginx and not penetrated into java/php/python/go. It is often used to do some work requiring relatively high response speed, such as CDN, current limiting, WAF, high concurrency interface, etc[ [picture](https://github.com/jindaoyiwu/openresty-api/blob/main/storage/image/openresty.png)

4、Which companies are using openresty? Many companies using openresty feel that they are lonely and users. In fact, it is not. As far as I know, openresty is used in Jingdong, Alibaba, 360, Baidu, Hikvision and other companies.

5、Openresty related tutorials[ Lua tutorial](https://www.bilibili.com/video/BV1H4411b7o9?p=1) , [introduction to openresty](https://www.bilibili.com/video/BV1S4411d7rx?from=search&seid=1245851150900242422)

6、How should this framework be used?

	① This framework combines Lapis (a well-known Lua framework) and re encapsulates it on the basis of lapi, making the development more simple and convenient.

	② if docker is used, it will be easier[ Docker image]（ https://registry.hub.docker.com/repository/docker/jindaoyiwu/openresty-lapis ）, because the image contains not only Lapis but also redis cluster connection components. If you do not use this image, you need to manually install Lapis and redis cluster components.

	③ nginx configuration

        server
        {
            listen 80;
            server_name cyzlapis.com;
            charset utf-8;
        
        
            lua_code_cache off;
        
        
            location /
            {
                fastcgi_param     OPENRESTY_API_PATH /www/php/openresty-api;
                include           fastcgi_params;
                default_type text/html;
                content_by_lua '
                   require("lapis").serve("app")
                ';
            }
            location = /favicon.ico { access_log off; log_not_found off; }
            access_log  /var/log/nginx/nginx.lapis.access.log  main;
            error_log  /var/log/nginx/nginx.lapis.error.log  warn;
        }
        http {
          lua_package_path "/www/php/openresty-api/?.lua;;";
          lua_shared_dict redis_cluster_slot_locks 100k;
        }
        
7、example

    First, add a route in lapis, and then operate in controller and model

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

