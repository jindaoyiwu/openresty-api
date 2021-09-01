local require = require
local pairs = pairs
local pcall = pcall
local ngx = ngx

local _C = {
    helper = require("vendor.utils.helper"),
    controllerName = "index",
    actionName = "index"
}

function _C:getController(app)
    local ok, res = pcall(require, "application.controllers." .. self.controllerName)
    if not ok then
        ngx.log(ngx.ERR, res)
    end
    res = res:new(app)
    return res
end

function _C:new(controllerAndAction, container)
    local ca = self.helper.split(controllerAndAction, '/')
    self.controllerName = ca[1] or self.controllerName
    self.actionName = ca[2] or self.actionName
    self.lc = container
    local app = {}
    for k, v in pairs(self) do
        app[k] = v
    end
    return self:getController(app)
end

function _C:run()
    local mod = self[self.actionName]
    if type(mod) ~= 'function' then
        return self:notFound()
    end
    local ok, res = pcall(mod, self)
    if not ok then
        ngx.log(ngx.ERR, res)
        return self:showError(res)
    end

    return res
end
return _C
