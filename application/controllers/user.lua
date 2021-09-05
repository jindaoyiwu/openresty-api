local _C = require("vendor.Controller")
local userModel = require("application.model.user")

function _C:register()
    self.validate.assert_valid(self['lc'].params, {
        { "phone", exists = true, min_length = 11, max_length = 11 },
        { "password", exists = true, min_length = 6, max_length = 20 },
    })
    local user = {}
    user['password'] = self.helper.sha1(self['lc'].params.password)
    user['phone'] = self['lc'].params.phone

    userModel:queryUserByPhone(user['phone'])
    local redis = self.redis:instance()
    local _,error = redis:get("user_lock")

    if error ~= nil then
        redis:set("user_lock", 1)
    end
    local userLock, _ = redis:incr("user_lock")

    local token = user['phone']..userLock
    user['token'] = self.helper.sha1(token)
    local res = userModel:register(user)
    if (res["affected_rows"] >= 1 ) then
        return self:success({})
    end
    return self:showError("插入失败")
end


return _C