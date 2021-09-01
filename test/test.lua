local _M = {}

function _M:test(s) print(s[2]); end
local a = {1,2}
local status, err = pcall(_M:test(), a);
if status then print("正常,呵呵");
else
    print("哎,函数出错了,我正在帮你处理");
    print(err);
end