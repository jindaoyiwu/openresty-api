local pairs = pairs
local type = type
local floor = math.floor
local tonumber = tonumber
local gsub = string.gsub
local table_insert = table.insert
local resty_sha1 = require "resty.sha1"
local resty_string = require "resty.string"


local helper = {}

function helper:trim(str)
    if str == nil then
        return  nil, "the string parameter is nil"
    end
    str = string.gsub(str," ", "")
    str = string.gsub(str,"\r","")
    str = string.gsub(str,"\n","")
    return str
end


-- 字符串 split 分割
function helper.split(s, p)
    local rt= {}
    gsub(s, '[^'..p..']+', function(w) table_insert(rt, w) end )
    return rt
end

--字符串转整数
function helper.intval(str)
    return floor(tonumber(str) or 0)
end


--检查变量是否为空
function helper.empty(val)
    return val==nil or (type(val)=='string' and val=='')
            or (type(val)=='number' and val==0)
            or (type(val)=='table' and next(val)==nil )
            or (type(val)=='boolean' and val==false )
end

function helper.trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function helper.ltrim(s)
    return (s:gsub("^%s*", ""))
end

function helper.rtrim(s)
    local n = #s
    while n > 0 and s:find("^%s", n) do n = n - 1 end
    return s:sub(1, n)
end

--检查值是否在一个表里
function helper.in_array(val,arr)
    for _,v in pairs(arr) do
        if v==val then return true end
    end
    return false
end

function helper.sha1(str, salt)
    local salt = salt or ''
    local sha1 = resty_sha1:new()
    local key = str..salt
    sha1:update(key)
    local digest = sha1:final()  -- binary digest
    return resty_string.to_hex(digest)
end






return helper