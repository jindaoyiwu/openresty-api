local require = require

local _M = require("vendor.Model")

local Users = _M.model:extend("users", {
    primary_key = "id"
})
local db = _M.mysql:instance()
function _M:register(user)
    local res = db.query("INSERT INTO test_users (phone, password, token) VALUES (?, ?, ?)", user["phone"],
            user["password"], user["token"])
    return res
end

function _M:queryUserByPhone(phone)
    local res = db.query("select * from test_users where phone=? ", phone)
    ngx.log(ngx.ERR, "cyzlog:", self.jsonSafe.encode(res));
    return res
end

return _M
