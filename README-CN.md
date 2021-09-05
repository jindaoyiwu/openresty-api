# openresty-api
1、简介：这个是openresty的api框架，编排了openresty中的操作方法，是使用openresty的开发人员能够更高效的开发。（这个框架中不含html的模板）

2、什么是openresty？是一个基于 Nginx 与 Lua 的高性能 Web 平台。[官网](http://openresty.org/)

3、openresty可以做什么？openresty因为直接是在nginx内部做得工作，相当于lua作为了nginx的一模快，没有穿透到应用（java/php/python/go）中去，所以性能非常高。常用于做一些对响应速度要求相对较高的工作，如：cdn，限流，waf，高并发的接口等。[图片](https://github.com/jindaoyiwu/openresty-api/blob/main/storage/image/openresty.png)

4、那些公司正在用openresty？很多用openresty的公司都觉得自己是孤独是使用者，其实不然，据我所知openresty在京东，阿里，360，百度，海康威视等公司都有使用。

5、openresty 相关教程。[lua教程](https://www.bilibili.com/video/BV1H4411b7o9?p=1) , [openresty简介](https://www.bilibili.com/video/BV1S4411d7rx?from=search&seid=1245851150900242422)

6、本框架该如何使用？

    ①、本框架糅合了lapis(一个知名的lua框架)，在lapi的基础上重新封装，使开发更加简单，便捷。
    ②、如果使用docker，将更加简便。[docker镜像](https://registry.hub.docker.com/repository/docker/jindaoyiwu/openresty-lapis),因为该镜像中不仅包含了lapis还包含了redis-cluster连接组件。如果不使用该镜像，则需要手动安装lapis和redis-cluster组件。
    ③、nginx 配置
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
        
7、使用示例

    首先在lapis中添加路由，然后在controler和model中操作即可
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
