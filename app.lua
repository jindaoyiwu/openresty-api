local lapis = require("lapis")
local app = lapis.Application()
local routes = require("routes.api")
local ngx_header = ngx.header
--设置默认输出类型
ngx_header["Content-Type"] = "text/html; charset=utf-8"
--初始化请求生命周期内自定义容器
app.c = require("vendor.Application")
--路由
routes:route(app)

return app