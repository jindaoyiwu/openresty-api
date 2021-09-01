local require = require

local _M = require("vendor.Model")

local Users = _M.model:extend("users", {
    primary_key = "id"
})

function _M:register(user)
    local db = self.mysql:instance()
    local res = db.query("INSERT INTO test_users (phone, password, token) VALUES (?, ?, ?)", user["phone"],
            user["password"], user["token"])
    ngx.log(ngx.ERR, "cyzlog:", self.jsonSafe.encode(res))

    return res
end

function _M:register2(user)

end

return _M
