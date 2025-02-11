local lepton = { ["VERSION"] = "1.0.0" } -- lepton.lpt:2
package["loaded"]["lepton"] = lepton -- lepton.lpt:4
local function _() -- lepton.lpt:7
local lepton = require("lepton") -- ./lepton/util.lpt:1
local util = {} -- ./lepton/util.lpt:2
util["search"] = function(modpath, exts) -- ./lepton/util.lpt:4
if exts == nil then exts = {} end -- ./lepton/util.lpt:4
for _, ext in ipairs(exts) do -- ./lepton/util.lpt:5
for path in package["path"]:gmatch("[^;]+") do -- ./lepton/util.lpt:6
local fpath = path:gsub("%.lua", "." .. ext):gsub("%?", (modpath:gsub("%.", "/"))) -- ./lepton/util.lpt:7
local f = io["open"](fpath) -- ./lepton/util.lpt:8
if f then -- ./lepton/util.lpt:9
f:close() -- ./lepton/util.lpt:10
return fpath -- ./lepton/util.lpt:11
end -- ./lepton/util.lpt:11
end -- ./lepton/util.lpt:11
end -- ./lepton/util.lpt:11
end -- ./lepton/util.lpt:11
util["load"] = function(str, name, env) -- ./lepton/util.lpt:17
if _VERSION == "Lua 5.1" then -- ./lepton/util.lpt:18
local fn, err = loadstring(str, name) -- ./lepton/util.lpt:19
if not fn then -- ./lepton/util.lpt:20
return fn, err -- ./lepton/util.lpt:20
end -- ./lepton/util.lpt:20
return env ~= nil and setfenv(fn, env) or fn -- ./lepton/util.lpt:21
else -- ./lepton/util.lpt:21
if env then -- ./lepton/util.lpt:23
return load(str, name, nil, env) -- ./lepton/util.lpt:24
else -- ./lepton/util.lpt:24
return load(str, name) -- ./lepton/util.lpt:26
end -- ./lepton/util.lpt:26
end -- ./lepton/util.lpt:26
end -- ./lepton/util.lpt:26
util["recmerge"] = function(...) -- ./lepton/util.lpt:31
local r = {} -- ./lepton/util.lpt:32
for _, t in ipairs({ ... }) do -- ./lepton/util.lpt:33
for k, v in pairs(t) do -- ./lepton/util.lpt:34
if type(v) == "table" then -- ./lepton/util.lpt:35
r[k] = util["merge"](v, r[k]) -- ./lepton/util.lpt:36
else -- ./lepton/util.lpt:36
r[k] = v -- ./lepton/util.lpt:38
end -- ./lepton/util.lpt:38
end -- ./lepton/util.lpt:38
end -- ./lepton/util.lpt:38
return r -- ./lepton/util.lpt:42
end -- ./lepton/util.lpt:42
util["merge"] = function(...) -- ./lepton/util.lpt:45
local r = {} -- ./lepton/util.lpt:46
for _, t in ipairs({ ... }) do -- ./lepton/util.lpt:47
for k, v in pairs(t) do -- ./lepton/util.lpt:48
r[k] = v -- ./lepton/util.lpt:49
end -- ./lepton/util.lpt:49
end -- ./lepton/util.lpt:49
return r -- ./lepton/util.lpt:52
end -- ./lepton/util.lpt:52
util["cli"] = { -- ./lepton/util.lpt:55
["addLeptonOptions"] = function(parser) -- ./lepton/util.lpt:57
parser:group("Compiler options", parser:option("-t --target"):description("Target Lua version: lua54, lua53, lua52, luajit or lua51"):default(lepton["default"]["target"]), parser:option("--indentation"):description("Character(s) used for indentation in the compiled file"):default(lepton["default"]["indentation"]), parser:option("--newline"):description("Character(s) used for newlines in the compiled file"):default(lepton["default"]["newline"]), parser:option("--variable-prefix"):description("Prefix used when lepton needs to set a local variable to provide some functionality"):default(lepton["default"]["variablePrefix"]), parser:flag("--no-map-lines"):description("Do not add comments at the end of each line indicating the associated source line and file (error rewriting will not work)")) -- ./lepton/util.lpt:76
parser:group("Preprocessor options", parser:flag("--no-builtin-macros"):description("Disable built-in macros"), parser:option("-D --define"):description("Define a preprocessor constant"):args("1-2"):argname({ -- ./lepton/util.lpt:86
"name", -- ./lepton/util.lpt:86
"value" -- ./lepton/util.lpt:86
}):count("*"), parser:option("-I --import"):description("Statically import a module into the compiled file"):argname("module"):count("*")) -- ./lepton/util.lpt:92
parser:option("--chunkname"):description("Chunkname used when running the code") -- ./lepton/util.lpt:96
parser:flag("--no-rewrite-errors"):description("Disable error rewriting when running the code") -- ./lepton/util.lpt:99
end, -- ./lepton/util.lpt:99
["makeLeptonOptions"] = function(args) -- ./lepton/util.lpt:103
local preprocessorEnv = {} -- ./lepton/util.lpt:104
for _, o in ipairs(args["define"]) do -- ./lepton/util.lpt:105
preprocessorEnv[o[1]] = tonumber(o[2]) or o[2] or true -- ./lepton/util.lpt:106
end -- ./lepton/util.lpt:106
local options = { -- ./lepton/util.lpt:109
["target"] = args["target"], -- ./lepton/util.lpt:110
["indentation"] = args["indentation"], -- ./lepton/util.lpt:111
["newline"] = args["newline"], -- ./lepton/util.lpt:112
["variablePrefix"] = args["variable_prefix"], -- ./lepton/util.lpt:113
["mapLines"] = not args["no_map_lines"], -- ./lepton/util.lpt:114
["chunkname"] = args["chunkname"], -- ./lepton/util.lpt:115
["rewriteErrors"] = not args["no_rewrite_errors"], -- ./lepton/util.lpt:116
["builtInMacros"] = not args["no_builtin_macros"], -- ./lepton/util.lpt:117
["preprocessorEnv"] = preprocessorEnv, -- ./lepton/util.lpt:118
["import"] = args["import"] -- ./lepton/util.lpt:119
} -- ./lepton/util.lpt:119
return options -- ./lepton/util.lpt:121
end -- ./lepton/util.lpt:121
} -- ./lepton/util.lpt:121
return util -- ./lepton/util.lpt:125
end -- ./lepton/util.lpt:125
local util = _() or util -- ./lepton/util.lpt:129
package["loaded"]["lepton.util"] = util or true -- ./lepton/util.lpt:130
local function _() -- ./lepton/util.lpt:133
local n, v = "serpent", "0.302" -- ./lepton/serpent.lua:24
local c, d = "Paul Kulchenko", "Lua serializer and pretty printer" -- ./lepton/serpent.lua:25
local snum = { -- ./lepton/serpent.lua:26
[tostring(1 / 0)] = "1/0 --[[math.huge]]", -- ./lepton/serpent.lua:26
[tostring(- 1 / 0)] = "-1/0 --[[-math.huge]]", -- ./lepton/serpent.lua:26
[tostring(0 / 0)] = "0/0" -- ./lepton/serpent.lua:26
} -- ./lepton/serpent.lua:26
local badtype = { -- ./lepton/serpent.lua:27
["thread"] = true, -- ./lepton/serpent.lua:27
["userdata"] = true, -- ./lepton/serpent.lua:27
["cdata"] = true -- ./lepton/serpent.lua:27
} -- ./lepton/serpent.lua:27
local getmetatable = debug and debug["getmetatable"] or getmetatable -- ./lepton/serpent.lua:28
local pairs = function(t) -- ./lepton/serpent.lua:29
return next, t -- ./lepton/serpent.lua:29
end -- ./lepton/serpent.lua:29
local keyword, globals, G = {}, {}, (_G or _ENV) -- ./lepton/serpent.lua:30
for _, k in ipairs({ -- ./lepton/serpent.lua:31
"and", -- ./lepton/serpent.lua:31
"break", -- ./lepton/serpent.lua:31
"do", -- ./lepton/serpent.lua:31
"else", -- ./lepton/serpent.lua:31
"elseif", -- ./lepton/serpent.lua:31
"end", -- ./lepton/serpent.lua:31
"false", -- ./lepton/serpent.lua:31
"for", -- ./lepton/serpent.lua:32
"function", -- ./lepton/serpent.lua:32
"goto", -- ./lepton/serpent.lua:32
"if", -- ./lepton/serpent.lua:32
"in", -- ./lepton/serpent.lua:32
"local", -- ./lepton/serpent.lua:32
"nil", -- ./lepton/serpent.lua:32
"not", -- ./lepton/serpent.lua:32
"or", -- ./lepton/serpent.lua:32
"repeat", -- ./lepton/serpent.lua:32
"return", -- ./lepton/serpent.lua:33
"then", -- ./lepton/serpent.lua:33
"true", -- ./lepton/serpent.lua:33
"until", -- ./lepton/serpent.lua:33
"while" -- ./lepton/serpent.lua:33
}) do -- ./lepton/serpent.lua:33
keyword[k] = true -- ./lepton/serpent.lua:33
end -- ./lepton/serpent.lua:33
for k, v in pairs(G) do -- ./lepton/serpent.lua:34
globals[v] = k -- ./lepton/serpent.lua:34
end -- ./lepton/serpent.lua:34
for _, g in ipairs({ -- ./lepton/serpent.lua:35
"coroutine", -- ./lepton/serpent.lua:35
"debug", -- ./lepton/serpent.lua:35
"io", -- ./lepton/serpent.lua:35
"math", -- ./lepton/serpent.lua:35
"string", -- ./lepton/serpent.lua:35
"table", -- ./lepton/serpent.lua:35
"os" -- ./lepton/serpent.lua:35
}) do -- ./lepton/serpent.lua:35
for k, v in pairs(type(G[g]) == "table" and G[g] or {}) do -- ./lepton/serpent.lua:36
globals[v] = g .. "." .. k -- ./lepton/serpent.lua:36
end -- ./lepton/serpent.lua:36
end -- ./lepton/serpent.lua:36
local function s(t, opts) -- ./lepton/serpent.lua:38
local name, indent, fatal, maxnum = opts["name"], opts["indent"], opts["fatal"], opts["maxnum"] -- ./lepton/serpent.lua:39
local sparse, custom, huge = opts["sparse"], opts["custom"], not opts["nohuge"] -- ./lepton/serpent.lua:40
local space, maxl = (opts["compact"] and "" or " "), (opts["maxlevel"] or math["huge"]) -- ./lepton/serpent.lua:41
local maxlen, metatostring = tonumber(opts["maxlength"]), opts["metatostring"] -- ./lepton/serpent.lua:42
local iname, comm = "_" .. (name or ""), opts["comment"] and (tonumber(opts["comment"]) or math["huge"]) -- ./lepton/serpent.lua:43
local numformat = opts["numformat"] or "%.17g" -- ./lepton/serpent.lua:44
local seen, sref, syms, symn = {}, { "local " .. iname .. "={}" }, {}, 0 -- ./lepton/serpent.lua:45
local function gensym(val) -- ./lepton/serpent.lua:46
return "_" .. (tostring(tostring(val)):gsub("[^%w]", ""):gsub("(%d%w+)", function(s) -- ./lepton/serpent.lua:48
if not syms[s] then -- ./lepton/serpent.lua:48
symn = symn + 1 -- ./lepton/serpent.lua:48
syms[s] = symn -- ./lepton/serpent.lua:48
end -- ./lepton/serpent.lua:48
return tostring(syms[s]) -- ./lepton/serpent.lua:48
end)) -- ./lepton/serpent.lua:48
end -- ./lepton/serpent.lua:48
local function safestr(s) -- ./lepton/serpent.lua:49
return type(s) == "number" and tostring(huge and snum[tostring(s)] or numformat:format(s)) or type(s) ~= "string" and tostring(s) or ("%q"):format(s):gsub("\
", "n"):gsub("\26", "\\026") -- ./lepton/serpent.lua:51
end -- ./lepton/serpent.lua:51
local function comment(s, l) -- ./lepton/serpent.lua:52
return comm and (l or 0) < comm and " --[[" .. select(2, pcall(tostring, s)) .. "]]" or "" -- ./lepton/serpent.lua:52
end -- ./lepton/serpent.lua:52
local function globerr(s, l) -- ./lepton/serpent.lua:53
return globals[s] and globals[s] .. comment(s, l) or not fatal and safestr(select(2, pcall(tostring, s))) or error("Can't serialize " .. tostring(s)) -- ./lepton/serpent.lua:54
end -- ./lepton/serpent.lua:54
local function safename(path, name) -- ./lepton/serpent.lua:55
local n = name == nil and "" or name -- ./lepton/serpent.lua:56
local plain = type(n) == "string" and n:match("^[%l%u_][%w_]*$") and not keyword[n] -- ./lepton/serpent.lua:57
local safe = plain and n or "[" .. safestr(n) .. "]" -- ./lepton/serpent.lua:58
return (path or "") .. (plain and path and "." or "") .. safe, safe -- ./lepton/serpent.lua:59
end -- ./lepton/serpent.lua:59
local alphanumsort = type(opts["sortkeys"]) == "function" and opts["sortkeys"] or function(k, o, n) -- ./lepton/serpent.lua:60
local maxn, to = tonumber(n) or 12, { -- ./lepton/serpent.lua:61
["number"] = "a", -- ./lepton/serpent.lua:61
["string"] = "b" -- ./lepton/serpent.lua:61
} -- ./lepton/serpent.lua:61
local function padnum(d) -- ./lepton/serpent.lua:62
return ("%0" .. tostring(maxn) .. "d"):format(tonumber(d)) -- ./lepton/serpent.lua:62
end -- ./lepton/serpent.lua:62
table["sort"](k, function(a, b) -- ./lepton/serpent.lua:63
return (k[a] ~= nil and 0 or to[type(a)] or "z") .. (tostring(a):gsub("%d+", padnum)) < (k[b] ~= nil and 0 or to[type(b)] or "z") .. (tostring(b):gsub("%d+", padnum)) -- ./lepton/serpent.lua:66
end) -- ./lepton/serpent.lua:66
end -- ./lepton/serpent.lua:66
local function val2str(t, name, indent, insref, path, plainindex, level) -- ./lepton/serpent.lua:67
local ttype, level, mt = type(t), (level or 0), getmetatable(t) -- ./lepton/serpent.lua:68
local spath, sname = safename(path, name) -- ./lepton/serpent.lua:69
local tag = plainindex and ((type(name) == "number") and "" or name .. space .. "=" .. space) or (name ~= nil and sname .. space .. "=" .. space or "") -- ./lepton/serpent.lua:72
if seen[t] then -- ./lepton/serpent.lua:73
sref[# sref + 1] = spath .. space .. "=" .. space .. seen[t] -- ./lepton/serpent.lua:74
return tag .. "nil" .. comment("ref", level) -- ./lepton/serpent.lua:75
end -- ./lepton/serpent.lua:75
if type(mt) == "table" and metatostring ~= false then -- ./lepton/serpent.lua:77
local to, tr = pcall(function() -- ./lepton/serpent.lua:78
return mt["__tostring"](t) -- ./lepton/serpent.lua:78
end) -- ./lepton/serpent.lua:78
local so, sr = pcall(function() -- ./lepton/serpent.lua:79
return mt["__serialize"](t) -- ./lepton/serpent.lua:79
end) -- ./lepton/serpent.lua:79
if (to or so) then -- ./lepton/serpent.lua:80
seen[t] = insref or spath -- ./lepton/serpent.lua:81
t = so and sr or tr -- ./lepton/serpent.lua:82
ttype = type(t) -- ./lepton/serpent.lua:83
end -- ./lepton/serpent.lua:83
end -- ./lepton/serpent.lua:83
if ttype == "table" then -- ./lepton/serpent.lua:86
if level >= maxl then -- ./lepton/serpent.lua:87
return tag .. "{}" .. comment("maxlvl", level) -- ./lepton/serpent.lua:87
end -- ./lepton/serpent.lua:87
seen[t] = insref or spath -- ./lepton/serpent.lua:88
if next(t) == nil then -- ./lepton/serpent.lua:89
return tag .. "{}" .. comment(t, level) -- ./lepton/serpent.lua:89
end -- ./lepton/serpent.lua:89
if maxlen and maxlen < 0 then -- ./lepton/serpent.lua:90
return tag .. "{}" .. comment("maxlen", level) -- ./lepton/serpent.lua:90
end -- ./lepton/serpent.lua:90
local maxn, o, out = math["min"](# t, maxnum or # t), {}, {} -- ./lepton/serpent.lua:91
for key = 1, maxn do -- ./lepton/serpent.lua:92
o[key] = key -- ./lepton/serpent.lua:92
end -- ./lepton/serpent.lua:92
if not maxnum or # o < maxnum then -- ./lepton/serpent.lua:93
local n = # o -- ./lepton/serpent.lua:94
for key in pairs(t) do -- ./lepton/serpent.lua:95
if o[key] ~= key then -- ./lepton/serpent.lua:95
n = n + 1 -- ./lepton/serpent.lua:95
o[n] = key -- ./lepton/serpent.lua:95
end -- ./lepton/serpent.lua:95
end -- ./lepton/serpent.lua:95
end -- ./lepton/serpent.lua:95
if maxnum and # o > maxnum then -- ./lepton/serpent.lua:96
o[maxnum + 1] = nil -- ./lepton/serpent.lua:96
end -- ./lepton/serpent.lua:96
if opts["sortkeys"] and # o > maxn then -- ./lepton/serpent.lua:97
alphanumsort(o, t, opts["sortkeys"]) -- ./lepton/serpent.lua:97
end -- ./lepton/serpent.lua:97
local sparse = sparse and # o > maxn -- ./lepton/serpent.lua:98
for n, key in ipairs(o) do -- ./lepton/serpent.lua:99
local value, ktype, plainindex = t[key], type(key), n <= maxn and not sparse -- ./lepton/serpent.lua:100
if opts["valignore"] and opts["valignore"][value] or opts["keyallow"] and not opts["keyallow"][key] or opts["keyignore"] and opts["keyignore"][key] or opts["valtypeignore"] and opts["valtypeignore"][type(value)] or sparse and value == nil then -- ./lepton/serpent.lua:105
 -- ./lepton/serpent.lua:106
elseif ktype == "table" or ktype == "function" or badtype[ktype] then -- ./lepton/serpent.lua:106
if not seen[key] and not globals[key] then -- ./lepton/serpent.lua:107
sref[# sref + 1] = "placeholder" -- ./lepton/serpent.lua:108
local sname = safename(iname, gensym(key)) -- ./lepton/serpent.lua:109
sref[# sref] = val2str(key, sname, indent, sname, iname, true) -- ./lepton/serpent.lua:110
end -- ./lepton/serpent.lua:110
sref[# sref + 1] = "placeholder" -- ./lepton/serpent.lua:111
local path = seen[t] .. "[" .. tostring(seen[key] or globals[key] or gensym(key)) .. "]" -- ./lepton/serpent.lua:112
sref[# sref] = path .. space .. "=" .. space .. tostring(seen[value] or val2str(value, nil, indent, path)) -- ./lepton/serpent.lua:113
else -- ./lepton/serpent.lua:113
out[# out + 1] = val2str(value, key, indent, nil, seen[t], plainindex, level + 1) -- ./lepton/serpent.lua:115
if maxlen then -- ./lepton/serpent.lua:116
maxlen = maxlen - # out[# out] -- ./lepton/serpent.lua:117
if maxlen < 0 then -- ./lepton/serpent.lua:118
break -- ./lepton/serpent.lua:118
end -- ./lepton/serpent.lua:118
end -- ./lepton/serpent.lua:118
end -- ./lepton/serpent.lua:118
end -- ./lepton/serpent.lua:118
local prefix = string["rep"](indent or "", level) -- ./lepton/serpent.lua:122
local head = indent and "{\
" .. prefix .. indent or "{" -- ./lepton/serpent.lua:123
local body = table["concat"](out, "," .. (indent and "\
" .. prefix .. indent or space)) -- ./lepton/serpent.lua:124
local tail = indent and "\
" .. prefix .. "}" or "}" -- ./lepton/serpent.lua:125
return (custom and custom(tag, head, body, tail, level) or tag .. head .. body .. tail) .. comment(t, level) -- ./lepton/serpent.lua:126
elseif badtype[ttype] then -- ./lepton/serpent.lua:127
seen[t] = insref or spath -- ./lepton/serpent.lua:128
return tag .. globerr(t, level) -- ./lepton/serpent.lua:129
elseif ttype == "function" then -- ./lepton/serpent.lua:130
seen[t] = insref or spath -- ./lepton/serpent.lua:131
if opts["nocode"] then -- ./lepton/serpent.lua:132
return tag .. "function() --[[..skipped..]] end" .. comment(t, level) -- ./lepton/serpent.lua:132
end -- ./lepton/serpent.lua:132
local ok, res = pcall(string["dump"], t) -- ./lepton/serpent.lua:133
local func = ok and "((loadstring or load)(" .. safestr(res) .. ",'@serialized'))" .. comment(t, level) -- ./lepton/serpent.lua:134
return tag .. (func or globerr(t, level)) -- ./lepton/serpent.lua:135
else -- ./lepton/serpent.lua:135
return tag .. safestr(t) -- ./lepton/serpent.lua:136
end -- ./lepton/serpent.lua:136
end -- ./lepton/serpent.lua:136
local sepr = indent and "\
" or ";" .. space -- ./lepton/serpent.lua:138
local body = val2str(t, name, indent) -- ./lepton/serpent.lua:139
local tail = # sref > 1 and table["concat"](sref, sepr) .. sepr or "" -- ./lepton/serpent.lua:140
local warn = opts["comment"] and # sref > 1 and space .. "--[[incomplete output with shared/self-references skipped]]" or "" -- ./lepton/serpent.lua:141
return not name and body .. warn or "do local " .. body .. sepr .. tail .. "return " .. name .. sepr .. "end" -- ./lepton/serpent.lua:142
end -- ./lepton/serpent.lua:142
local function deserialize(data, opts) -- ./lepton/serpent.lua:145
local env = (opts and opts["safe"] == false) and G or setmetatable({}, { -- ./lepton/serpent.lua:147
["__index"] = function(t, k) -- ./lepton/serpent.lua:148
return t -- ./lepton/serpent.lua:148
end, -- ./lepton/serpent.lua:148
["__call"] = function(t, ...) -- ./lepton/serpent.lua:149
error("cannot call functions") -- ./lepton/serpent.lua:149
end -- ./lepton/serpent.lua:149
}) -- ./lepton/serpent.lua:149
local f, res = (loadstring or load)("return " .. data, nil, nil, env) -- ./lepton/serpent.lua:151
if not f then -- ./lepton/serpent.lua:152
f, res = (loadstring or load)(data, nil, nil, env) -- ./lepton/serpent.lua:152
end -- ./lepton/serpent.lua:152
if not f then -- ./lepton/serpent.lua:153
return f, res -- ./lepton/serpent.lua:153
end -- ./lepton/serpent.lua:153
if setfenv then -- ./lepton/serpent.lua:154
setfenv(f, env) -- ./lepton/serpent.lua:154
end -- ./lepton/serpent.lua:154
return pcall(f) -- ./lepton/serpent.lua:155
end -- ./lepton/serpent.lua:155
local function merge(a, b) -- ./lepton/serpent.lua:158
if b then -- ./lepton/serpent.lua:158
for k, v in pairs(b) do -- ./lepton/serpent.lua:158
a[k] = v -- ./lepton/serpent.lua:158
end -- ./lepton/serpent.lua:158
end -- ./lepton/serpent.lua:158
return a -- ./lepton/serpent.lua:158
end -- ./lepton/serpent.lua:158
return { -- ./lepton/serpent.lua:159
["_NAME"] = n, -- ./lepton/serpent.lua:159
["_COPYRIGHT"] = c, -- ./lepton/serpent.lua:159
["_DESCRIPTION"] = d, -- ./lepton/serpent.lua:159
["_VERSION"] = v, -- ./lepton/serpent.lua:159
["serialize"] = s, -- ./lepton/serpent.lua:159
["load"] = deserialize, -- ./lepton/serpent.lua:160
["dump"] = function(a, opts) -- ./lepton/serpent.lua:161
return s(a, merge({ -- ./lepton/serpent.lua:161
["name"] = "_", -- ./lepton/serpent.lua:161
["compact"] = true, -- ./lepton/serpent.lua:161
["sparse"] = true -- ./lepton/serpent.lua:161
}, opts)) -- ./lepton/serpent.lua:161
end, -- ./lepton/serpent.lua:161
["line"] = function(a, opts) -- ./lepton/serpent.lua:162
return s(a, merge({ -- ./lepton/serpent.lua:162
["sortkeys"] = true, -- ./lepton/serpent.lua:162
["comment"] = true -- ./lepton/serpent.lua:162
}, opts)) -- ./lepton/serpent.lua:162
end, -- ./lepton/serpent.lua:162
["block"] = function(a, opts) -- ./lepton/serpent.lua:163
return s(a, merge({ -- ./lepton/serpent.lua:163
["indent"] = "  ", -- ./lepton/serpent.lua:163
["sortkeys"] = true, -- ./lepton/serpent.lua:163
["comment"] = true -- ./lepton/serpent.lua:163
}, opts)) -- ./lepton/serpent.lua:163
end -- ./lepton/serpent.lua:163
} -- ./lepton/serpent.lua:163
end -- ./lepton/serpent.lua:163
local serpent = _() or serpent -- ./lepton/serpent.lua:167
package["loaded"]["lepton.serpent"] = serpent or true -- ./lepton/serpent.lua:168
local function _() -- ./lepton/serpent.lua:172
local util = require("lepton.util") -- ./compiler/lua54.lpt:1
local targetName = "Lua 5.4" -- ./compiler/lua54.lpt:3
local unpack = unpack or table["unpack"] -- ./compiler/lua54.lpt:5
return function(code, ast, options, macros) -- ./compiler/lua54.lpt:7
if macros == nil then macros = { -- ./compiler/lua54.lpt:7
["functions"] = {}, -- ./compiler/lua54.lpt:7
["variables"] = {} -- ./compiler/lua54.lpt:7
} end -- ./compiler/lua54.lpt:7
local lastInputPos = 1 -- ./compiler/lua54.lpt:9
local prevLinePos = 1 -- ./compiler/lua54.lpt:10
local lastSource = options["chunkname"] or "nil" -- ./compiler/lua54.lpt:11
local lastLine = 1 -- ./compiler/lua54.lpt:12
local indentLevel = 0 -- ./compiler/lua54.lpt:16
local function newline() -- ./compiler/lua54.lpt:18
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.lpt:19
if options["mapLines"] then -- ./compiler/lua54.lpt:20
local sub = code:sub(lastInputPos) -- ./compiler/lua54.lpt:21
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.lpt:22
if source and line then -- ./compiler/lua54.lpt:24
lastSource = source -- ./compiler/lua54.lpt:25
lastLine = tonumber(line) -- ./compiler/lua54.lpt:26
else -- ./compiler/lua54.lpt:26
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.lpt:28
lastLine = lastLine + (1) -- ./compiler/lua54.lpt:29
end -- ./compiler/lua54.lpt:29
end -- ./compiler/lua54.lpt:29
prevLinePos = lastInputPos -- ./compiler/lua54.lpt:33
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.lpt:35
end -- ./compiler/lua54.lpt:35
return r -- ./compiler/lua54.lpt:37
end -- ./compiler/lua54.lpt:37
local function indent() -- ./compiler/lua54.lpt:40
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:41
return newline() -- ./compiler/lua54.lpt:42
end -- ./compiler/lua54.lpt:42
local function unindent() -- ./compiler/lua54.lpt:45
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:46
return newline() -- ./compiler/lua54.lpt:47
end -- ./compiler/lua54.lpt:47
local states = { -- ./compiler/lua54.lpt:53
["push"] = {}, -- ./compiler/lua54.lpt:54
["destructuring"] = {}, -- ./compiler/lua54.lpt:55
["scope"] = {}, -- ./compiler/lua54.lpt:56
["macroargs"] = {} -- ./compiler/lua54.lpt:57
} -- ./compiler/lua54.lpt:57
local function push(name, state) -- ./compiler/lua54.lpt:60
states[name][# states[name] + 1] = state -- ./compiler/lua54.lpt:61
return "" -- ./compiler/lua54.lpt:62
end -- ./compiler/lua54.lpt:62
local function pop(name) -- ./compiler/lua54.lpt:65
table["remove"](states[name]) -- ./compiler/lua54.lpt:66
return "" -- ./compiler/lua54.lpt:67
end -- ./compiler/lua54.lpt:67
local function set(name, state) -- ./compiler/lua54.lpt:70
states[name][# states[name]] = state -- ./compiler/lua54.lpt:71
return "" -- ./compiler/lua54.lpt:72
end -- ./compiler/lua54.lpt:72
local function peek(name) -- ./compiler/lua54.lpt:75
return states[name][# states[name]] -- ./compiler/lua54.lpt:76
end -- ./compiler/lua54.lpt:76
local function var(name) -- ./compiler/lua54.lpt:82
return options["variablePrefix"] .. name -- ./compiler/lua54.lpt:83
end -- ./compiler/lua54.lpt:83
local function tmp() -- ./compiler/lua54.lpt:87
local scope = peek("scope") -- ./compiler/lua54.lpt:88
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.lpt:89
table["insert"](scope, var) -- ./compiler/lua54.lpt:90
return var -- ./compiler/lua54.lpt:91
end -- ./compiler/lua54.lpt:91
local nomacro = { -- ./compiler/lua54.lpt:95
["variables"] = {}, -- ./compiler/lua54.lpt:95
["functions"] = {} -- ./compiler/lua54.lpt:95
} -- ./compiler/lua54.lpt:95
local luaHeader = "" -- ./compiler/lua54.lpt:98
local function addLua(code) -- ./compiler/lua54.lpt:99
luaHeader = luaHeader .. (code) -- ./compiler/lua54.lpt:100
end -- ./compiler/lua54.lpt:100
local libraries = {} -- ./compiler/lua54.lpt:105
local function addBroadcast() -- ./compiler/lua54.lpt:107
if libraries["broadcast"] then -- ./compiler/lua54.lpt:108
return  -- ./compiler/lua54.lpt:108
end -- ./compiler/lua54.lpt:108
addLua((" -- ./compiler/lua54.lpt:110\
local function %sbroadcast(func, t) -- ./compiler/lua54.lpt:111\
    local new = {} -- ./compiler/lua54.lpt:112\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:113\
        local r1, r2 = func(v) -- ./compiler/lua54.lpt:114\
        if r2 == nil then -- ./compiler/lua54.lpt:115\
            new[k] = r1 -- ./compiler/lua54.lpt:116\
        else -- ./compiler/lua54.lpt:117\
            new[r1] = r2 -- ./compiler/lua54.lpt:118\
        end -- ./compiler/lua54.lpt:119\
    end -- ./compiler/lua54.lpt:120\
    if next(new) ~= nil then -- ./compiler/lua54.lpt:121\
        return new -- ./compiler/lua54.lpt:122\
    end -- ./compiler/lua54.lpt:123\
end -- ./compiler/lua54.lpt:124\
"):format(options["variablePrefix"], options["variablePrefix"])) -- ./compiler/lua54.lpt:125
libraries["broadcast"] = true -- ./compiler/lua54.lpt:127
end -- ./compiler/lua54.lpt:127
local function addBroadcastKV() -- ./compiler/lua54.lpt:130
if libraries["broadcastKV"] then -- ./compiler/lua54.lpt:131
return  -- ./compiler/lua54.lpt:131
end -- ./compiler/lua54.lpt:131
addLua((" -- ./compiler/lua54.lpt:133\
local function %sbroadcast_kv(func, t) -- ./compiler/lua54.lpt:134\
    local new = {} -- ./compiler/lua54.lpt:135\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:136\
        local r1, r2 = func(k, v) -- ./compiler/lua54.lpt:137\
        if r2 == nil then -- ./compiler/lua54.lpt:138\
            new[k] = r1 -- ./compiler/lua54.lpt:139\
        else -- ./compiler/lua54.lpt:140\
            new[r1] = r2 -- ./compiler/lua54.lpt:141\
        end -- ./compiler/lua54.lpt:142\
    end -- ./compiler/lua54.lpt:143\
    if next(new) ~= nil then -- ./compiler/lua54.lpt:144\
        return new -- ./compiler/lua54.lpt:145\
    end -- ./compiler/lua54.lpt:146\
end -- ./compiler/lua54.lpt:147\
"):format(options["variablePrefix"], options["variablePrefix"])) -- ./compiler/lua54.lpt:148
libraries["broadcastKV"] = true -- ./compiler/lua54.lpt:150
end -- ./compiler/lua54.lpt:150
local function addFilter() -- ./compiler/lua54.lpt:153
if libraries["filter"] then -- ./compiler/lua54.lpt:154
return  -- ./compiler/lua54.lpt:154
end -- ./compiler/lua54.lpt:154
addLua((" -- ./compiler/lua54.lpt:156\
local function %sfilter(predicate, t) -- ./compiler/lua54.lpt:157\
    local new = {} -- ./compiler/lua54.lpt:158\
    local i = 1 -- ./compiler/lua54.lpt:159\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:160\
        if predicate(v) then -- ./compiler/lua54.lpt:161\
            if type(k) == 'number' then -- ./compiler/lua54.lpt:162\
                new[i] = v -- ./compiler/lua54.lpt:163\
                i = i + 1 -- ./compiler/lua54.lpt:164\
            else -- ./compiler/lua54.lpt:165\
                new[k] = v -- ./compiler/lua54.lpt:166\
            end -- ./compiler/lua54.lpt:167\
        end -- ./compiler/lua54.lpt:168\
    end -- ./compiler/lua54.lpt:169\
    return new -- ./compiler/lua54.lpt:170\
end -- ./compiler/lua54.lpt:171\
"):format(options["variablePrefix"])) -- ./compiler/lua54.lpt:172
libraries["filter"] = true -- ./compiler/lua54.lpt:174
end -- ./compiler/lua54.lpt:174
local function addFilterKV() -- ./compiler/lua54.lpt:177
if libraries["filterKV"] then -- ./compiler/lua54.lpt:178
return  -- ./compiler/lua54.lpt:178
end -- ./compiler/lua54.lpt:178
addLua((" -- ./compiler/lua54.lpt:180\
local function %sfilter_kv(predicate, t) -- ./compiler/lua54.lpt:181\
    local new = {} -- ./compiler/lua54.lpt:182\
    local i = 1 -- ./compiler/lua54.lpt:183\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:184\
        if predicate(k, v) then -- ./compiler/lua54.lpt:185\
            if type(k) == 'number' then -- ./compiler/lua54.lpt:186\
                new[i] = v -- ./compiler/lua54.lpt:187\
                i = i + 1 -- ./compiler/lua54.lpt:188\
            else -- ./compiler/lua54.lpt:189\
                new[k] = v -- ./compiler/lua54.lpt:190\
            end -- ./compiler/lua54.lpt:191\
        end -- ./compiler/lua54.lpt:192\
    end -- ./compiler/lua54.lpt:193\
    return new -- ./compiler/lua54.lpt:194\
end -- ./compiler/lua54.lpt:195\
"):format(options["variablePrefix"])) -- ./compiler/lua54.lpt:196
libraries["filterKV"] = true -- ./compiler/lua54.lpt:198
end -- ./compiler/lua54.lpt:198
local required = {} -- ./compiler/lua54.lpt:203
local requireStr = "" -- ./compiler/lua54.lpt:204
local function addRequire(mod, name, field) -- ./compiler/lua54.lpt:206
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.lpt:207
if not required[req] then -- ./compiler/lua54.lpt:208
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.lpt:209
required[req] = true -- ./compiler/lua54.lpt:210
end -- ./compiler/lua54.lpt:210
end -- ./compiler/lua54.lpt:210
local loop = { -- ./compiler/lua54.lpt:216
"While", -- ./compiler/lua54.lpt:216
"Repeat", -- ./compiler/lua54.lpt:216
"Fornum", -- ./compiler/lua54.lpt:216
"Forin", -- ./compiler/lua54.lpt:216
"WhileExpr", -- ./compiler/lua54.lpt:216
"RepeatExpr", -- ./compiler/lua54.lpt:216
"FornumExpr", -- ./compiler/lua54.lpt:216
"ForinExpr" -- ./compiler/lua54.lpt:216
} -- ./compiler/lua54.lpt:216
local func = { -- ./compiler/lua54.lpt:217
"Function", -- ./compiler/lua54.lpt:217
"TableCompr", -- ./compiler/lua54.lpt:217
"DoExpr", -- ./compiler/lua54.lpt:217
"WhileExpr", -- ./compiler/lua54.lpt:217
"RepeatExpr", -- ./compiler/lua54.lpt:217
"IfExpr", -- ./compiler/lua54.lpt:217
"FornumExpr", -- ./compiler/lua54.lpt:217
"ForinExpr" -- ./compiler/lua54.lpt:217
} -- ./compiler/lua54.lpt:217
local function any(list, tags, nofollow) -- ./compiler/lua54.lpt:221
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:221
local tagsCheck = {} -- ./compiler/lua54.lpt:222
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:223
tagsCheck[tag] = true -- ./compiler/lua54.lpt:224
end -- ./compiler/lua54.lpt:224
local nofollowCheck = {} -- ./compiler/lua54.lpt:226
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:227
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:228
end -- ./compiler/lua54.lpt:228
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:230
if type(node) == "table" then -- ./compiler/lua54.lpt:231
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:232
return node -- ./compiler/lua54.lpt:233
end -- ./compiler/lua54.lpt:233
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:235
local r = any(node, tags, nofollow) -- ./compiler/lua54.lpt:236
if r then -- ./compiler/lua54.lpt:237
return r -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
return nil -- ./compiler/lua54.lpt:241
end -- ./compiler/lua54.lpt:241
local function search(list, tags, nofollow) -- ./compiler/lua54.lpt:246
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:246
local tagsCheck = {} -- ./compiler/lua54.lpt:247
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:248
tagsCheck[tag] = true -- ./compiler/lua54.lpt:249
end -- ./compiler/lua54.lpt:249
local nofollowCheck = {} -- ./compiler/lua54.lpt:251
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:252
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:253
end -- ./compiler/lua54.lpt:253
local found = {} -- ./compiler/lua54.lpt:255
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:256
if type(node) == "table" then -- ./compiler/lua54.lpt:257
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:258
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.lpt:259
table["insert"](found, n) -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:263
table["insert"](found, node) -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
return found -- ./compiler/lua54.lpt:268
end -- ./compiler/lua54.lpt:268
local function all(list, tags) -- ./compiler/lua54.lpt:272
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:273
local ok = false -- ./compiler/lua54.lpt:274
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:275
if node["tag"] == tag then -- ./compiler/lua54.lpt:276
ok = true -- ./compiler/lua54.lpt:277
break -- ./compiler/lua54.lpt:278
end -- ./compiler/lua54.lpt:278
end -- ./compiler/lua54.lpt:278
if not ok then -- ./compiler/lua54.lpt:281
return false -- ./compiler/lua54.lpt:282
end -- ./compiler/lua54.lpt:282
end -- ./compiler/lua54.lpt:282
return true -- ./compiler/lua54.lpt:285
end -- ./compiler/lua54.lpt:285
local tags -- ./compiler/lua54.lpt:290
local function lua(ast, forceTag, ...) -- ./compiler/lua54.lpt:292
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.lpt:293
lastInputPos = ast["pos"] -- ./compiler/lua54.lpt:294
end -- ./compiler/lua54.lpt:294
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.lpt:296
end -- ./compiler/lua54.lpt:296
local UNPACK = function(list, i, j) -- ./compiler/lua54.lpt:301
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.lpt:302
end -- ./compiler/lua54.lpt:302
local APPEND = function(t, toAppend) -- ./compiler/lua54.lpt:304
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.lpt:305
end -- ./compiler/lua54.lpt:305
local CONTINUE_START = function() -- ./compiler/lua54.lpt:307
return "do" .. indent() -- ./compiler/lua54.lpt:308
end -- ./compiler/lua54.lpt:308
local CONTINUE_STOP = function() -- ./compiler/lua54.lpt:310
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.lpt:311
end -- ./compiler/lua54.lpt:311
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.lpt:314
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.lpt:314
if noLocal == nil then noLocal = false end -- ./compiler/lua54.lpt:314
local vars = {} -- ./compiler/lua54.lpt:315
local values = {} -- ./compiler/lua54.lpt:316
for _, list in ipairs(destructured) do -- ./compiler/lua54.lpt:317
for _, v in ipairs(list) do -- ./compiler/lua54.lpt:318
local var, val -- ./compiler/lua54.lpt:319
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.lpt:320
var = v -- ./compiler/lua54.lpt:321
val = { -- ./compiler/lua54.lpt:322
["tag"] = "Index", -- ./compiler/lua54.lpt:322
{ -- ./compiler/lua54.lpt:322
["tag"] = "Id", -- ./compiler/lua54.lpt:322
list["id"] -- ./compiler/lua54.lpt:322
}, -- ./compiler/lua54.lpt:322
{ -- ./compiler/lua54.lpt:322
["tag"] = "String", -- ./compiler/lua54.lpt:322
v[1] -- ./compiler/lua54.lpt:322
} -- ./compiler/lua54.lpt:322
} -- ./compiler/lua54.lpt:322
elseif v["tag"] == "Pair" then -- ./compiler/lua54.lpt:323
var = v[2] -- ./compiler/lua54.lpt:324
val = { -- ./compiler/lua54.lpt:325
["tag"] = "Index", -- ./compiler/lua54.lpt:325
{ -- ./compiler/lua54.lpt:325
["tag"] = "Id", -- ./compiler/lua54.lpt:325
list["id"] -- ./compiler/lua54.lpt:325
}, -- ./compiler/lua54.lpt:325
v[1] -- ./compiler/lua54.lpt:325
} -- ./compiler/lua54.lpt:325
else -- ./compiler/lua54.lpt:325
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.lpt:327
end -- ./compiler/lua54.lpt:327
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.lpt:329
val = { -- ./compiler/lua54.lpt:330
["tag"] = "Op", -- ./compiler/lua54.lpt:330
destructured["rightOp"], -- ./compiler/lua54.lpt:330
var, -- ./compiler/lua54.lpt:330
{ -- ./compiler/lua54.lpt:330
["tag"] = "Op", -- ./compiler/lua54.lpt:330
destructured["leftOp"], -- ./compiler/lua54.lpt:330
val, -- ./compiler/lua54.lpt:330
var -- ./compiler/lua54.lpt:330
} -- ./compiler/lua54.lpt:330
} -- ./compiler/lua54.lpt:330
elseif destructured["rightOp"] then -- ./compiler/lua54.lpt:331
val = { -- ./compiler/lua54.lpt:332
["tag"] = "Op", -- ./compiler/lua54.lpt:332
destructured["rightOp"], -- ./compiler/lua54.lpt:332
var, -- ./compiler/lua54.lpt:332
val -- ./compiler/lua54.lpt:332
} -- ./compiler/lua54.lpt:332
elseif destructured["leftOp"] then -- ./compiler/lua54.lpt:333
val = { -- ./compiler/lua54.lpt:334
["tag"] = "Op", -- ./compiler/lua54.lpt:334
destructured["leftOp"], -- ./compiler/lua54.lpt:334
val, -- ./compiler/lua54.lpt:334
var -- ./compiler/lua54.lpt:334
} -- ./compiler/lua54.lpt:334
end -- ./compiler/lua54.lpt:334
table["insert"](vars, lua(var)) -- ./compiler/lua54.lpt:336
table["insert"](values, lua(val)) -- ./compiler/lua54.lpt:337
end -- ./compiler/lua54.lpt:337
end -- ./compiler/lua54.lpt:337
if # vars > 0 then -- ./compiler/lua54.lpt:340
local decl = noLocal and "" or "local " -- ./compiler/lua54.lpt:341
if newlineAfter then -- ./compiler/lua54.lpt:342
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.lpt:343
else -- ./compiler/lua54.lpt:343
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.lpt:345
end -- ./compiler/lua54.lpt:345
else -- ./compiler/lua54.lpt:345
return "" -- ./compiler/lua54.lpt:348
end -- ./compiler/lua54.lpt:348
end -- ./compiler/lua54.lpt:348
local BROADCAST = function(t, use_kv) -- ./compiler/lua54.lpt:352
((use_kv and addBroadcastKV) or addBroadcast)() -- ./compiler/lua54.lpt:353
return table["concat"]({ -- ./compiler/lua54.lpt:354
options["variablePrefix"], -- ./compiler/lua54.lpt:354
(use_kv and "broadcast_kv(") or "broadcast(", -- ./compiler/lua54.lpt:354
lua(t[1]), -- ./compiler/lua54.lpt:354
",", -- ./compiler/lua54.lpt:354
lua(t[2]), -- ./compiler/lua54.lpt:354
")" -- ./compiler/lua54.lpt:354
}) -- ./compiler/lua54.lpt:354
end -- ./compiler/lua54.lpt:354
local FILTER = function(t, use_kv) -- ./compiler/lua54.lpt:356
((use_kv and addFilterKV) or addFilter)() -- ./compiler/lua54.lpt:357
return table["concat"]({ -- ./compiler/lua54.lpt:358
options["variablePrefix"], -- ./compiler/lua54.lpt:358
(use_kv and "filter_kv(") or "filter(", -- ./compiler/lua54.lpt:358
lua(t[1]), -- ./compiler/lua54.lpt:358
",", -- ./compiler/lua54.lpt:358
lua(t[2]), -- ./compiler/lua54.lpt:358
")" -- ./compiler/lua54.lpt:358
}) -- ./compiler/lua54.lpt:358
end -- ./compiler/lua54.lpt:358
tags = setmetatable({ -- ./compiler/lua54.lpt:363
["Block"] = function(t) -- ./compiler/lua54.lpt:366
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.lpt:367
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.lpt:368
hasPush["tag"] = "Return" -- ./compiler/lua54.lpt:369
hasPush = false -- ./compiler/lua54.lpt:370
end -- ./compiler/lua54.lpt:370
local r = push("scope", {}) -- ./compiler/lua54.lpt:372
if hasPush then -- ./compiler/lua54.lpt:373
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:374
end -- ./compiler/lua54.lpt:374
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:376
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:377
end -- ./compiler/lua54.lpt:377
if t[# t] then -- ./compiler/lua54.lpt:379
r = r .. (lua(t[# t])) -- ./compiler/lua54.lpt:380
end -- ./compiler/lua54.lpt:380
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:382
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.lpt:383
end -- ./compiler/lua54.lpt:383
return r .. pop("scope") -- ./compiler/lua54.lpt:385
end, -- ./compiler/lua54.lpt:385
["Do"] = function(t) -- ./compiler/lua54.lpt:391
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.lpt:392
end, -- ./compiler/lua54.lpt:392
["Set"] = function(t) -- ./compiler/lua54.lpt:395
local expr = t[# t] -- ./compiler/lua54.lpt:397
local vars, values = {}, {} -- ./compiler/lua54.lpt:398
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.lpt:399
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:400
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.lpt:401
table["insert"](destructuringVars, n) -- ./compiler/lua54.lpt:402
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.lpt:403
else -- ./compiler/lua54.lpt:403
table["insert"](vars, n) -- ./compiler/lua54.lpt:405
table["insert"](values, expr[i]) -- ./compiler/lua54.lpt:406
end -- ./compiler/lua54.lpt:406
end -- ./compiler/lua54.lpt:406
if # t == 2 or # t == 3 then -- ./compiler/lua54.lpt:410
local r = "" -- ./compiler/lua54.lpt:411
if # vars > 0 then -- ./compiler/lua54.lpt:412
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.lpt:413
end -- ./compiler/lua54.lpt:413
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:415
local destructured = {} -- ./compiler/lua54.lpt:416
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:417
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:418
end -- ./compiler/lua54.lpt:418
return r -- ./compiler/lua54.lpt:420
elseif # t == 4 then -- ./compiler/lua54.lpt:421
if t[3] == "=" then -- ./compiler/lua54.lpt:422
local r = "" -- ./compiler/lua54.lpt:423
if # vars > 0 then -- ./compiler/lua54.lpt:424
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:425
t[2], -- ./compiler/lua54.lpt:425
vars[1], -- ./compiler/lua54.lpt:425
{ -- ./compiler/lua54.lpt:425
["tag"] = "Paren", -- ./compiler/lua54.lpt:425
values[1] -- ./compiler/lua54.lpt:425
} -- ./compiler/lua54.lpt:425
}, "Op")) -- ./compiler/lua54.lpt:425
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.lpt:426
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:427
t[2], -- ./compiler/lua54.lpt:427
vars[i], -- ./compiler/lua54.lpt:427
{ -- ./compiler/lua54.lpt:427
["tag"] = "Paren", -- ./compiler/lua54.lpt:427
values[i] -- ./compiler/lua54.lpt:427
} -- ./compiler/lua54.lpt:427
}, "Op")) -- ./compiler/lua54.lpt:427
end -- ./compiler/lua54.lpt:427
end -- ./compiler/lua54.lpt:427
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:430
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.lpt:431
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:432
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:433
end -- ./compiler/lua54.lpt:433
return r -- ./compiler/lua54.lpt:435
else -- ./compiler/lua54.lpt:435
local r = "" -- ./compiler/lua54.lpt:437
if # vars > 0 then -- ./compiler/lua54.lpt:438
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:439
t[3], -- ./compiler/lua54.lpt:439
{ -- ./compiler/lua54.lpt:439
["tag"] = "Paren", -- ./compiler/lua54.lpt:439
values[1] -- ./compiler/lua54.lpt:439
}, -- ./compiler/lua54.lpt:439
vars[1] -- ./compiler/lua54.lpt:439
}, "Op")) -- ./compiler/lua54.lpt:439
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.lpt:440
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:441
t[3], -- ./compiler/lua54.lpt:441
{ -- ./compiler/lua54.lpt:441
["tag"] = "Paren", -- ./compiler/lua54.lpt:441
values[i] -- ./compiler/lua54.lpt:441
}, -- ./compiler/lua54.lpt:441
vars[i] -- ./compiler/lua54.lpt:441
}, "Op")) -- ./compiler/lua54.lpt:441
end -- ./compiler/lua54.lpt:441
end -- ./compiler/lua54.lpt:441
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:444
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.lpt:445
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:446
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:447
end -- ./compiler/lua54.lpt:447
return r -- ./compiler/lua54.lpt:449
end -- ./compiler/lua54.lpt:449
else -- ./compiler/lua54.lpt:449
local r = "" -- ./compiler/lua54.lpt:452
if # vars > 0 then -- ./compiler/lua54.lpt:453
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:454
t[2], -- ./compiler/lua54.lpt:454
vars[1], -- ./compiler/lua54.lpt:454
{ -- ./compiler/lua54.lpt:454
["tag"] = "Op", -- ./compiler/lua54.lpt:454
t[4], -- ./compiler/lua54.lpt:454
{ -- ./compiler/lua54.lpt:454
["tag"] = "Paren", -- ./compiler/lua54.lpt:454
values[1] -- ./compiler/lua54.lpt:454
}, -- ./compiler/lua54.lpt:454
vars[1] -- ./compiler/lua54.lpt:454
} -- ./compiler/lua54.lpt:454
}, "Op")) -- ./compiler/lua54.lpt:454
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.lpt:455
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:456
t[2], -- ./compiler/lua54.lpt:456
vars[i], -- ./compiler/lua54.lpt:456
{ -- ./compiler/lua54.lpt:456
["tag"] = "Op", -- ./compiler/lua54.lpt:456
t[4], -- ./compiler/lua54.lpt:456
{ -- ./compiler/lua54.lpt:456
["tag"] = "Paren", -- ./compiler/lua54.lpt:456
values[i] -- ./compiler/lua54.lpt:456
}, -- ./compiler/lua54.lpt:456
vars[i] -- ./compiler/lua54.lpt:456
} -- ./compiler/lua54.lpt:456
}, "Op")) -- ./compiler/lua54.lpt:456
end -- ./compiler/lua54.lpt:456
end -- ./compiler/lua54.lpt:456
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:459
local destructured = { -- ./compiler/lua54.lpt:460
["rightOp"] = t[2], -- ./compiler/lua54.lpt:460
["leftOp"] = t[4] -- ./compiler/lua54.lpt:460
} -- ./compiler/lua54.lpt:460
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:461
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:462
end -- ./compiler/lua54.lpt:462
return r -- ./compiler/lua54.lpt:464
end -- ./compiler/lua54.lpt:464
end, -- ./compiler/lua54.lpt:464
["AppendSet"] = function(t) -- ./compiler/lua54.lpt:468
local expr = t[# t] -- ./compiler/lua54.lpt:470
local r = {} -- ./compiler/lua54.lpt:471
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:472
local value = expr[i] -- ./compiler/lua54.lpt:473
if value == nil then -- ./compiler/lua54.lpt:474
break -- ./compiler/lua54.lpt:475
end -- ./compiler/lua54.lpt:475
local var = lua(n) -- ./compiler/lua54.lpt:478
r[i] = { -- ./compiler/lua54.lpt:479
var, -- ./compiler/lua54.lpt:479
"[#", -- ./compiler/lua54.lpt:479
var, -- ./compiler/lua54.lpt:479
"+1] = ", -- ./compiler/lua54.lpt:479
lua(value) -- ./compiler/lua54.lpt:479
} -- ./compiler/lua54.lpt:479
r[i] = table["concat"](r[i]) -- ./compiler/lua54.lpt:480
end -- ./compiler/lua54.lpt:480
return table["concat"](r, "; ") -- ./compiler/lua54.lpt:482
end, -- ./compiler/lua54.lpt:482
["While"] = function(t) -- ./compiler/lua54.lpt:485
local r = "" -- ./compiler/lua54.lpt:486
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.lpt:487
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:488
if # lets > 0 then -- ./compiler/lua54.lpt:489
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:490
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:491
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:492
end -- ./compiler/lua54.lpt:492
end -- ./compiler/lua54.lpt:492
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.lpt:495
if # lets > 0 then -- ./compiler/lua54.lpt:496
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:497
end -- ./compiler/lua54.lpt:497
if hasContinue then -- ./compiler/lua54.lpt:499
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:500
end -- ./compiler/lua54.lpt:500
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:502
if hasContinue then -- ./compiler/lua54.lpt:503
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:504
end -- ./compiler/lua54.lpt:504
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:506
if # lets > 0 then -- ./compiler/lua54.lpt:507
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:508
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.lpt:509
end -- ./compiler/lua54.lpt:509
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.lpt:511
end -- ./compiler/lua54.lpt:511
return r -- ./compiler/lua54.lpt:513
end, -- ./compiler/lua54.lpt:513
["Repeat"] = function(t) -- ./compiler/lua54.lpt:516
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.lpt:517
local r = "repeat" .. indent() -- ./compiler/lua54.lpt:518
if hasContinue then -- ./compiler/lua54.lpt:519
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:520
end -- ./compiler/lua54.lpt:520
r = r .. (lua(t[1])) -- ./compiler/lua54.lpt:522
if hasContinue then -- ./compiler/lua54.lpt:523
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.lpt:526
return r -- ./compiler/lua54.lpt:527
end, -- ./compiler/lua54.lpt:527
["If"] = function(t) -- ./compiler/lua54.lpt:530
local r = "" -- ./compiler/lua54.lpt:531
local toClose = 0 -- ./compiler/lua54.lpt:532
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:533
if # lets > 0 then -- ./compiler/lua54.lpt:534
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:535
toClose = toClose + (1) -- ./compiler/lua54.lpt:536
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:537
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:538
end -- ./compiler/lua54.lpt:538
end -- ./compiler/lua54.lpt:538
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.lpt:541
for i = 3, # t - 1, 2 do -- ./compiler/lua54.lpt:542
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.lpt:543
if # lets > 0 then -- ./compiler/lua54.lpt:544
r = r .. ("else" .. indent()) -- ./compiler/lua54.lpt:545
toClose = toClose + (1) -- ./compiler/lua54.lpt:546
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:547
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:548
end -- ./compiler/lua54.lpt:548
else -- ./compiler/lua54.lpt:548
r = r .. ("else") -- ./compiler/lua54.lpt:551
end -- ./compiler/lua54.lpt:551
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.lpt:553
end -- ./compiler/lua54.lpt:553
if # t % 2 == 1 then -- ./compiler/lua54.lpt:555
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.lpt:556
end -- ./compiler/lua54.lpt:556
r = r .. ("end") -- ./compiler/lua54.lpt:558
for i = 1, toClose do -- ./compiler/lua54.lpt:559
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:560
end -- ./compiler/lua54.lpt:560
return r -- ./compiler/lua54.lpt:562
end, -- ./compiler/lua54.lpt:562
["Fornum"] = function(t) -- ./compiler/lua54.lpt:565
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.lpt:566
if # t == 5 then -- ./compiler/lua54.lpt:567
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.lpt:568
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.lpt:569
if hasContinue then -- ./compiler/lua54.lpt:570
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:571
end -- ./compiler/lua54.lpt:571
r = r .. (lua(t[5])) -- ./compiler/lua54.lpt:573
if hasContinue then -- ./compiler/lua54.lpt:574
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:575
end -- ./compiler/lua54.lpt:575
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:577
else -- ./compiler/lua54.lpt:577
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.lpt:579
r = r .. (" do" .. indent()) -- ./compiler/lua54.lpt:580
if hasContinue then -- ./compiler/lua54.lpt:581
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:582
end -- ./compiler/lua54.lpt:582
r = r .. (lua(t[4])) -- ./compiler/lua54.lpt:584
if hasContinue then -- ./compiler/lua54.lpt:585
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:586
end -- ./compiler/lua54.lpt:586
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:588
end -- ./compiler/lua54.lpt:588
end, -- ./compiler/lua54.lpt:588
["Forin"] = function(t) -- ./compiler/lua54.lpt:592
local destructured = {} -- ./compiler/lua54.lpt:593
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.lpt:594
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.lpt:595
if hasContinue then -- ./compiler/lua54.lpt:596
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:597
end -- ./compiler/lua54.lpt:597
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.lpt:599
if hasContinue then -- ./compiler/lua54.lpt:600
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:601
end -- ./compiler/lua54.lpt:601
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:603
end, -- ./compiler/lua54.lpt:603
["Local"] = function(t) -- ./compiler/lua54.lpt:606
local destructured = {} -- ./compiler/lua54.lpt:607
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:608
if t[2][1] then -- ./compiler/lua54.lpt:609
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:610
end -- ./compiler/lua54.lpt:610
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:612
end, -- ./compiler/lua54.lpt:612
["Let"] = function(t) -- ./compiler/lua54.lpt:615
local destructured = {} -- ./compiler/lua54.lpt:616
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:617
local r = "local " .. nameList -- ./compiler/lua54.lpt:618
if t[2][1] then -- ./compiler/lua54.lpt:619
if all(t[2], { -- ./compiler/lua54.lpt:620
"Nil", -- ./compiler/lua54.lpt:620
"Dots", -- ./compiler/lua54.lpt:620
"Boolean", -- ./compiler/lua54.lpt:620
"Number", -- ./compiler/lua54.lpt:620
"String" -- ./compiler/lua54.lpt:620
}) then -- ./compiler/lua54.lpt:620
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:621
else -- ./compiler/lua54.lpt:621
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:623
end -- ./compiler/lua54.lpt:623
end -- ./compiler/lua54.lpt:623
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:626
end, -- ./compiler/lua54.lpt:626
["Localrec"] = function(t) -- ./compiler/lua54.lpt:629
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.lpt:630
end, -- ./compiler/lua54.lpt:630
["Goto"] = function(t) -- ./compiler/lua54.lpt:633
return "goto " .. lua(t, "Id") -- ./compiler/lua54.lpt:634
end, -- ./compiler/lua54.lpt:634
["Label"] = function(t) -- ./compiler/lua54.lpt:637
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.lpt:638
end, -- ./compiler/lua54.lpt:638
["Return"] = function(t) -- ./compiler/lua54.lpt:641
local push = peek("push") -- ./compiler/lua54.lpt:642
if push then -- ./compiler/lua54.lpt:643
local r = "" -- ./compiler/lua54.lpt:644
for _, val in ipairs(t) do -- ./compiler/lua54.lpt:645
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.lpt:646
end -- ./compiler/lua54.lpt:646
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.lpt:648
else -- ./compiler/lua54.lpt:648
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.lpt:650
end -- ./compiler/lua54.lpt:650
end, -- ./compiler/lua54.lpt:650
["Push"] = function(t) -- ./compiler/lua54.lpt:654
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.lpt:655
r = "" -- ./compiler/lua54.lpt:656
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:657
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:658
end -- ./compiler/lua54.lpt:658
if t[# t] then -- ./compiler/lua54.lpt:660
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.lpt:661
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.lpt:662
else -- ./compiler/lua54.lpt:662
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.lpt:664
end -- ./compiler/lua54.lpt:664
end -- ./compiler/lua54.lpt:664
return r -- ./compiler/lua54.lpt:667
end, -- ./compiler/lua54.lpt:667
["Break"] = function() -- ./compiler/lua54.lpt:670
return "break" -- ./compiler/lua54.lpt:671
end, -- ./compiler/lua54.lpt:671
["Continue"] = function() -- ./compiler/lua54.lpt:674
return "goto " .. var("continue") -- ./compiler/lua54.lpt:675
end, -- ./compiler/lua54.lpt:675
["Nil"] = function() -- ./compiler/lua54.lpt:682
return "nil" -- ./compiler/lua54.lpt:683
end, -- ./compiler/lua54.lpt:683
["Dots"] = function() -- ./compiler/lua54.lpt:686
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:687
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.lpt:688
nomacro["variables"]["..."] = true -- ./compiler/lua54.lpt:689
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.lpt:690
nomacro["variables"]["..."] = nil -- ./compiler/lua54.lpt:691
return r -- ./compiler/lua54.lpt:692
else -- ./compiler/lua54.lpt:692
return "..." -- ./compiler/lua54.lpt:694
end -- ./compiler/lua54.lpt:694
end, -- ./compiler/lua54.lpt:694
["Boolean"] = function(t) -- ./compiler/lua54.lpt:698
return tostring(t[1]) -- ./compiler/lua54.lpt:699
end, -- ./compiler/lua54.lpt:699
["Number"] = function(t) -- ./compiler/lua54.lpt:702
local n = tostring(t[1]):gsub("_", "") -- ./compiler/lua54.lpt:703
do -- ./compiler/lua54.lpt:705
local match -- ./compiler/lua54.lpt:705
match = n:match("^0b(.*)") -- ./compiler/lua54.lpt:705
if match then -- ./compiler/lua54.lpt:705
n = tostring(tonumber(match, 2)) -- ./compiler/lua54.lpt:706
end -- ./compiler/lua54.lpt:706
end -- ./compiler/lua54.lpt:706
return n -- ./compiler/lua54.lpt:708
end, -- ./compiler/lua54.lpt:708
["String"] = function(t) -- ./compiler/lua54.lpt:711
return ("%q"):format(t[1]) -- ./compiler/lua54.lpt:712
end, -- ./compiler/lua54.lpt:712
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.lpt:715
local r = "(" -- ./compiler/lua54.lpt:716
local decl = {} -- ./compiler/lua54.lpt:717
if t[1][1] then -- ./compiler/lua54.lpt:718
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:719
local id = lua(t[1][1][1]) -- ./compiler/lua54.lpt:720
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:721
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.lpt:722
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:723
r = r .. (id) -- ./compiler/lua54.lpt:724
else -- ./compiler/lua54.lpt:724
r = r .. (lua(t[1][1])) -- ./compiler/lua54.lpt:726
end -- ./compiler/lua54.lpt:726
for i = 2, # t[1], 1 do -- ./compiler/lua54.lpt:728
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:729
local id = lua(t[1][i][1]) -- ./compiler/lua54.lpt:730
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:731
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.lpt:732
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:733
r = r .. (", " .. id) -- ./compiler/lua54.lpt:734
else -- ./compiler/lua54.lpt:734
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
r = r .. (")" .. indent()) -- ./compiler/lua54.lpt:740
for _, d in ipairs(decl) do -- ./compiler/lua54.lpt:741
r = r .. (d .. newline()) -- ./compiler/lua54.lpt:742
end -- ./compiler/lua54.lpt:742
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.lpt:744
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.lpt:745
end -- ./compiler/lua54.lpt:745
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.lpt:747
if hasPush then -- ./compiler/lua54.lpt:748
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:749
else -- ./compiler/lua54.lpt:749
push("push", false) -- ./compiler/lua54.lpt:751
end -- ./compiler/lua54.lpt:751
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:753
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:754
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:755
end -- ./compiler/lua54.lpt:755
pop("push") -- ./compiler/lua54.lpt:757
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:758
end, -- ./compiler/lua54.lpt:758
["Function"] = function(t) -- ./compiler/lua54.lpt:760
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.lpt:761
end, -- ./compiler/lua54.lpt:761
["Pair"] = function(t) -- ./compiler/lua54.lpt:764
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.lpt:765
end, -- ./compiler/lua54.lpt:765
["Table"] = function(t) -- ./compiler/lua54.lpt:767
if # t == 0 then -- ./compiler/lua54.lpt:768
return "{}" -- ./compiler/lua54.lpt:769
elseif # t == 1 then -- ./compiler/lua54.lpt:770
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.lpt:771
else -- ./compiler/lua54.lpt:771
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.lpt:773
end -- ./compiler/lua54.lpt:773
end, -- ./compiler/lua54.lpt:773
["TableCompr"] = function(t) -- ./compiler/lua54.lpt:777
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.lpt:778
end, -- ./compiler/lua54.lpt:778
["Op"] = function(t) -- ./compiler/lua54.lpt:781
local r -- ./compiler/lua54.lpt:782
if # t == 2 then -- ./compiler/lua54.lpt:783
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:784
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.lpt:785
else -- ./compiler/lua54.lpt:785
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.lpt:787
end -- ./compiler/lua54.lpt:787
else -- ./compiler/lua54.lpt:787
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:790
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.lpt:791
else -- ./compiler/lua54.lpt:791
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.lpt:793
end -- ./compiler/lua54.lpt:793
end -- ./compiler/lua54.lpt:793
return r -- ./compiler/lua54.lpt:796
end, -- ./compiler/lua54.lpt:796
["Paren"] = function(t) -- ./compiler/lua54.lpt:799
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.lpt:800
end, -- ./compiler/lua54.lpt:800
["MethodStub"] = function(t) -- ./compiler/lua54.lpt:803
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:809
end, -- ./compiler/lua54.lpt:809
["SafeMethodStub"] = function(t) -- ./compiler/lua54.lpt:812
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:819
end, -- ./compiler/lua54.lpt:819
["LetExpr"] = function(t) -- ./compiler/lua54.lpt:826
return lua(t[1][1]) -- ./compiler/lua54.lpt:827
end, -- ./compiler/lua54.lpt:827
["_statexpr"] = function(t, stat) -- ./compiler/lua54.lpt:831
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.lpt:832
local r = "(function()" .. indent() -- ./compiler/lua54.lpt:833
if hasPush then -- ./compiler/lua54.lpt:834
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:835
else -- ./compiler/lua54.lpt:835
push("push", false) -- ./compiler/lua54.lpt:837
end -- ./compiler/lua54.lpt:837
r = r .. (lua(t, stat)) -- ./compiler/lua54.lpt:839
if hasPush then -- ./compiler/lua54.lpt:840
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:841
end -- ./compiler/lua54.lpt:841
pop("push") -- ./compiler/lua54.lpt:843
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.lpt:844
return r -- ./compiler/lua54.lpt:845
end, -- ./compiler/lua54.lpt:845
["DoExpr"] = function(t) -- ./compiler/lua54.lpt:848
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.lpt:849
t[# t]["tag"] = "Return" -- ./compiler/lua54.lpt:850
end -- ./compiler/lua54.lpt:850
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.lpt:852
end, -- ./compiler/lua54.lpt:852
["WhileExpr"] = function(t) -- ./compiler/lua54.lpt:855
return lua(t, "_statexpr", "While") -- ./compiler/lua54.lpt:856
end, -- ./compiler/lua54.lpt:856
["RepeatExpr"] = function(t) -- ./compiler/lua54.lpt:859
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.lpt:860
end, -- ./compiler/lua54.lpt:860
["IfExpr"] = function(t) -- ./compiler/lua54.lpt:863
for i = 2, # t do -- ./compiler/lua54.lpt:864
local block = t[i] -- ./compiler/lua54.lpt:865
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.lpt:866
block[# block]["tag"] = "Return" -- ./compiler/lua54.lpt:867
end -- ./compiler/lua54.lpt:867
end -- ./compiler/lua54.lpt:867
return lua(t, "_statexpr", "If") -- ./compiler/lua54.lpt:870
end, -- ./compiler/lua54.lpt:870
["FornumExpr"] = function(t) -- ./compiler/lua54.lpt:873
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.lpt:874
end, -- ./compiler/lua54.lpt:874
["ForinExpr"] = function(t) -- ./compiler/lua54.lpt:877
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.lpt:878
end, -- ./compiler/lua54.lpt:878
["Call"] = function(t) -- ./compiler/lua54.lpt:885
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:886
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:887
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.lpt:888
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.lpt:889
local replacement = macro["replacement"] -- ./compiler/lua54.lpt:890
local r -- ./compiler/lua54.lpt:891
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.lpt:892
if type(replacement) == "function" then -- ./compiler/lua54.lpt:893
local args = {} -- ./compiler/lua54.lpt:894
for i = 2, # t do -- ./compiler/lua54.lpt:895
table["insert"](args, lua(t[i])) -- ./compiler/lua54.lpt:896
end -- ./compiler/lua54.lpt:896
r = replacement(unpack(args)) -- ./compiler/lua54.lpt:898
else -- ./compiler/lua54.lpt:898
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.lpt:900
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.lpt:901
if arg["tag"] == "Dots" then -- ./compiler/lua54.lpt:902
macroargs["..."] = (function() -- ./compiler/lua54.lpt:903
local self = {} -- ./compiler/lua54.lpt:903
for j = i + 1, # t do -- ./compiler/lua54.lpt:903
self[#self+1] = t[j] -- ./compiler/lua54.lpt:903
end -- ./compiler/lua54.lpt:903
return self -- ./compiler/lua54.lpt:903
end)() -- ./compiler/lua54.lpt:903
elseif arg["tag"] == "Id" then -- ./compiler/lua54.lpt:904
if t[i + 1] == nil then -- ./compiler/lua54.lpt:905
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.lpt:906
end -- ./compiler/lua54.lpt:906
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.lpt:908
else -- ./compiler/lua54.lpt:908
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.lpt:910
end -- ./compiler/lua54.lpt:910
end -- ./compiler/lua54.lpt:910
push("macroargs", macroargs) -- ./compiler/lua54.lpt:913
r = lua(replacement) -- ./compiler/lua54.lpt:914
pop("macroargs") -- ./compiler/lua54.lpt:915
end -- ./compiler/lua54.lpt:915
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.lpt:917
return r -- ./compiler/lua54.lpt:918
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.lpt:919
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.lpt:920
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:921
else -- ./compiler/lua54.lpt:921
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:923
end -- ./compiler/lua54.lpt:923
else -- ./compiler/lua54.lpt:923
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:926
end -- ./compiler/lua54.lpt:926
end, -- ./compiler/lua54.lpt:926
["SafeCall"] = function(t) -- ./compiler/lua54.lpt:930
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:931
return lua(t, "SafeIndex") -- ./compiler/lua54.lpt:932
else -- ./compiler/lua54.lpt:932
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.lpt:934
end -- ./compiler/lua54.lpt:934
end, -- ./compiler/lua54.lpt:934
["Broadcast"] = function(t) -- ./compiler/lua54.lpt:940
return BROADCAST(t, false) -- ./compiler/lua54.lpt:941
end, -- ./compiler/lua54.lpt:941
["BroadcastKV"] = function(t) -- ./compiler/lua54.lpt:943
return BROADCAST(t, true) -- ./compiler/lua54.lpt:944
end, -- ./compiler/lua54.lpt:944
["Filter"] = function(t) -- ./compiler/lua54.lpt:946
return FILTER(t, false) -- ./compiler/lua54.lpt:947
end, -- ./compiler/lua54.lpt:947
["FilterKV"] = function(t) -- ./compiler/lua54.lpt:949
return FILTER(t, true) -- ./compiler/lua54.lpt:950
end, -- ./compiler/lua54.lpt:950
["StringFormat"] = function(t) -- ./compiler/lua54.lpt:955
local args = {} -- ./compiler/lua54.lpt:956
for i, v in ipairs(t[2]) do -- ./compiler/lua54.lpt:957
args[i] = lua(v) -- ./compiler/lua54.lpt:958
end -- ./compiler/lua54.lpt:958
local r = { -- ./compiler/lua54.lpt:960
"(", -- ./compiler/lua54.lpt:960
"string.format(", -- ./compiler/lua54.lpt:960
("%q"):format(t[1]) -- ./compiler/lua54.lpt:960
} -- ./compiler/lua54.lpt:960
if # args ~= 0 then -- ./compiler/lua54.lpt:961
r[# r + 1] = ", " -- ./compiler/lua54.lpt:962
r[# r + 1] = table["concat"](args, ", ") -- ./compiler/lua54.lpt:963
r[# r + 1] = "))" -- ./compiler/lua54.lpt:964
end -- ./compiler/lua54.lpt:964
return table["concat"](r) -- ./compiler/lua54.lpt:966
end, -- ./compiler/lua54.lpt:966
["TableUnpack"] = function(t) -- ./compiler/lua54.lpt:971
local args = {} -- ./compiler/lua54.lpt:972
for i, v in ipairs(t[2]) do -- ./compiler/lua54.lpt:973
args[i] = lua(v) -- ./compiler/lua54.lpt:974
end -- ./compiler/lua54.lpt:974
return UNPACK(lua(t[1]), args[1], args[2]) -- ./compiler/lua54.lpt:976
end, -- ./compiler/lua54.lpt:976
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.lpt:982
if start == nil then start = 1 end -- ./compiler/lua54.lpt:982
local r -- ./compiler/lua54.lpt:983
if t[start] then -- ./compiler/lua54.lpt:984
r = lua(t[start]) -- ./compiler/lua54.lpt:985
for i = start + 1, # t, 1 do -- ./compiler/lua54.lpt:986
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.lpt:987
end -- ./compiler/lua54.lpt:987
else -- ./compiler/lua54.lpt:987
r = "" -- ./compiler/lua54.lpt:990
end -- ./compiler/lua54.lpt:990
return r -- ./compiler/lua54.lpt:992
end, -- ./compiler/lua54.lpt:992
["Id"] = function(t) -- ./compiler/lua54.lpt:995
local r = t[1] -- ./compiler/lua54.lpt:996
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:997
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.lpt:998
nomacro["variables"][t[1]] = true -- ./compiler/lua54.lpt:999
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.lpt:1000
r = lua(macroargs[t[1]]) -- ./compiler/lua54.lpt:1001
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.lpt:1002
local macro = macros["variables"][t[1]] -- ./compiler/lua54.lpt:1003
if type(macro) == "function" then -- ./compiler/lua54.lpt:1004
r = macro() -- ./compiler/lua54.lpt:1005
else -- ./compiler/lua54.lpt:1005
r = lua(macro) -- ./compiler/lua54.lpt:1007
end -- ./compiler/lua54.lpt:1007
end -- ./compiler/lua54.lpt:1007
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.lpt:1010
end -- ./compiler/lua54.lpt:1010
return r -- ./compiler/lua54.lpt:1012
end, -- ./compiler/lua54.lpt:1012
["AttributeId"] = function(t) -- ./compiler/lua54.lpt:1015
if t[2] then -- ./compiler/lua54.lpt:1016
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.lpt:1017
else -- ./compiler/lua54.lpt:1017
return t[1] -- ./compiler/lua54.lpt:1019
end -- ./compiler/lua54.lpt:1019
end, -- ./compiler/lua54.lpt:1019
["DestructuringId"] = function(t) -- ./compiler/lua54.lpt:1023
if t["id"] then -- ./compiler/lua54.lpt:1024
return t["id"] -- ./compiler/lua54.lpt:1025
else -- ./compiler/lua54.lpt:1025
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.lpt:1027
local vars = { ["id"] = tmp() } -- ./compiler/lua54.lpt:1028
for j = 1, # t, 1 do -- ./compiler/lua54.lpt:1029
table["insert"](vars, t[j]) -- ./compiler/lua54.lpt:1030
end -- ./compiler/lua54.lpt:1030
table["insert"](d, vars) -- ./compiler/lua54.lpt:1032
t["id"] = vars["id"] -- ./compiler/lua54.lpt:1033
return vars["id"] -- ./compiler/lua54.lpt:1034
end -- ./compiler/lua54.lpt:1034
end, -- ./compiler/lua54.lpt:1034
["Index"] = function(t) -- ./compiler/lua54.lpt:1038
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:1039
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:1040
else -- ./compiler/lua54.lpt:1040
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:1042
end -- ./compiler/lua54.lpt:1042
end, -- ./compiler/lua54.lpt:1042
["SafeIndex"] = function(t) -- ./compiler/lua54.lpt:1046
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:1047
local l = {} -- ./compiler/lua54.lpt:1048
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.lpt:1049
table["insert"](l, 1, t) -- ./compiler/lua54.lpt:1050
t = t[1] -- ./compiler/lua54.lpt:1051
end -- ./compiler/lua54.lpt:1051
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.lpt:1053
for _, e in ipairs(l) do -- ./compiler/lua54.lpt:1054
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.lpt:1055
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.lpt:1056
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.lpt:1057
else -- ./compiler/lua54.lpt:1057
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.lpt:1059
end -- ./compiler/lua54.lpt:1059
end -- ./compiler/lua54.lpt:1059
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.lpt:1062
return r -- ./compiler/lua54.lpt:1063
else -- ./compiler/lua54.lpt:1063
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.lpt:1065
end -- ./compiler/lua54.lpt:1065
end, -- ./compiler/lua54.lpt:1065
["_opid"] = { -- ./compiler/lua54.lpt:1071
["add"] = "+", -- ./compiler/lua54.lpt:1073
["sub"] = "-", -- ./compiler/lua54.lpt:1073
["mul"] = "*", -- ./compiler/lua54.lpt:1073
["div"] = "/", -- ./compiler/lua54.lpt:1073
["idiv"] = "//", -- ./compiler/lua54.lpt:1074
["mod"] = "%", -- ./compiler/lua54.lpt:1074
["pow"] = "^", -- ./compiler/lua54.lpt:1074
["concat"] = "..", -- ./compiler/lua54.lpt:1074
["band"] = "&", -- ./compiler/lua54.lpt:1075
["bor"] = "|", -- ./compiler/lua54.lpt:1075
["bxor"] = "~", -- ./compiler/lua54.lpt:1075
["shl"] = "<<", -- ./compiler/lua54.lpt:1075
["shr"] = ">>", -- ./compiler/lua54.lpt:1075
["eq"] = "==", -- ./compiler/lua54.lpt:1076
["ne"] = "~=", -- ./compiler/lua54.lpt:1076
["lt"] = "<", -- ./compiler/lua54.lpt:1076
["gt"] = ">", -- ./compiler/lua54.lpt:1076
["le"] = "<=", -- ./compiler/lua54.lpt:1076
["ge"] = ">=", -- ./compiler/lua54.lpt:1076
["and"] = "and", -- ./compiler/lua54.lpt:1077
["or"] = "or", -- ./compiler/lua54.lpt:1077
["unm"] = "-", -- ./compiler/lua54.lpt:1077
["len"] = "#", -- ./compiler/lua54.lpt:1077
["bnot"] = "~", -- ./compiler/lua54.lpt:1077
["not"] = "not", -- ./compiler/lua54.lpt:1077
["divb"] = function(left, right) -- ./compiler/lua54.lpt:1081
return table["concat"]({ -- ./compiler/lua54.lpt:1082
"((", -- ./compiler/lua54.lpt:1082
lua(left), -- ./compiler/lua54.lpt:1082
") % (", -- ./compiler/lua54.lpt:1082
lua(right), -- ./compiler/lua54.lpt:1082
") == 0)" -- ./compiler/lua54.lpt:1082
}) -- ./compiler/lua54.lpt:1082
end, -- ./compiler/lua54.lpt:1082
["ndivb"] = function(left, right) -- ./compiler/lua54.lpt:1085
return table["concat"]({ -- ./compiler/lua54.lpt:1086
"((", -- ./compiler/lua54.lpt:1086
lua(left), -- ./compiler/lua54.lpt:1086
") % (", -- ./compiler/lua54.lpt:1086
lua(right), -- ./compiler/lua54.lpt:1086
") ~= 0)" -- ./compiler/lua54.lpt:1086
}) -- ./compiler/lua54.lpt:1086
end, -- ./compiler/lua54.lpt:1086
["tconcat"] = function(left, right) -- ./compiler/lua54.lpt:1091
if right["tag"] == "Table" then -- ./compiler/lua54.lpt:1092
local sep = right[1] -- ./compiler/lua54.lpt:1093
local i = right[2] -- ./compiler/lua54.lpt:1094
local j = right[3] -- ./compiler/lua54.lpt:1095
local r = { -- ./compiler/lua54.lpt:1097
"table.concat(", -- ./compiler/lua54.lpt:1097
lua(left) -- ./compiler/lua54.lpt:1097
} -- ./compiler/lua54.lpt:1097
if sep ~= nil then -- ./compiler/lua54.lpt:1099
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1100
r[# r + 1] = lua(sep) -- ./compiler/lua54.lpt:1101
end -- ./compiler/lua54.lpt:1101
if i ~= nil then -- ./compiler/lua54.lpt:1104
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1105
r[# r + 1] = lua(i) -- ./compiler/lua54.lpt:1106
end -- ./compiler/lua54.lpt:1106
if j ~= nil then -- ./compiler/lua54.lpt:1109
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1110
r[# r + 1] = lua(j) -- ./compiler/lua54.lpt:1111
end -- ./compiler/lua54.lpt:1111
r[# r + 1] = ")" -- ./compiler/lua54.lpt:1114
return table["concat"](r) -- ./compiler/lua54.lpt:1116
else -- ./compiler/lua54.lpt:1116
return table["concat"]({ -- ./compiler/lua54.lpt:1118
"table.concat(", -- ./compiler/lua54.lpt:1118
lua(left), -- ./compiler/lua54.lpt:1118
", ", -- ./compiler/lua54.lpt:1118
lua(right), -- ./compiler/lua54.lpt:1118
")" -- ./compiler/lua54.lpt:1118
}) -- ./compiler/lua54.lpt:1118
end -- ./compiler/lua54.lpt:1118
end, -- ./compiler/lua54.lpt:1118
["pipe"] = function(left, right) -- ./compiler/lua54.lpt:1124
return table["concat"]({ -- ./compiler/lua54.lpt:1125
"(", -- ./compiler/lua54.lpt:1125
lua(right), -- ./compiler/lua54.lpt:1125
")", -- ./compiler/lua54.lpt:1125
"(", -- ./compiler/lua54.lpt:1125
lua(left), -- ./compiler/lua54.lpt:1125
")" -- ./compiler/lua54.lpt:1125
}) -- ./compiler/lua54.lpt:1125
end, -- ./compiler/lua54.lpt:1125
["pipebc"] = function(left, right) -- ./compiler/lua54.lpt:1127
return table["concat"]({ BROADCAST({ -- ./compiler/lua54.lpt:1128
right, -- ./compiler/lua54.lpt:1128
left -- ./compiler/lua54.lpt:1128
}, false) }) -- ./compiler/lua54.lpt:1128
end, -- ./compiler/lua54.lpt:1128
["pipebckv"] = function(left, right) -- ./compiler/lua54.lpt:1130
return table["concat"]({ BROADCAST({ -- ./compiler/lua54.lpt:1131
right, -- ./compiler/lua54.lpt:1131
left -- ./compiler/lua54.lpt:1131
}, true) }) -- ./compiler/lua54.lpt:1131
end -- ./compiler/lua54.lpt:1131
} -- ./compiler/lua54.lpt:1131
}, { ["__index"] = function(self, key) -- ./compiler/lua54.lpt:1143
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.lpt:1144
end }) -- ./compiler/lua54.lpt:1144
local code = lua(ast) .. newline() -- ./compiler/lua54.lpt:1151
return requireStr .. luaHeader .. code -- ./compiler/lua54.lpt:1152
end -- ./compiler/lua54.lpt:1152
end -- ./compiler/lua54.lpt:1152
local lua54 = _() or lua54 -- ./compiler/lua54.lpt:1157
package["loaded"]["compiler.lua54"] = lua54 or true -- ./compiler/lua54.lpt:1158
local function _() -- ./compiler/lua54.lpt:1161
local function _() -- ./compiler/lua54.lpt:1163
local util = require("lepton.util") -- ./compiler/lua54.lpt:1
local targetName = "Lua 5.4" -- ./compiler/lua54.lpt:3
local unpack = unpack or table["unpack"] -- ./compiler/lua54.lpt:5
return function(code, ast, options, macros) -- ./compiler/lua54.lpt:7
if macros == nil then macros = { -- ./compiler/lua54.lpt:7
["functions"] = {}, -- ./compiler/lua54.lpt:7
["variables"] = {} -- ./compiler/lua54.lpt:7
} end -- ./compiler/lua54.lpt:7
local lastInputPos = 1 -- ./compiler/lua54.lpt:9
local prevLinePos = 1 -- ./compiler/lua54.lpt:10
local lastSource = options["chunkname"] or "nil" -- ./compiler/lua54.lpt:11
local lastLine = 1 -- ./compiler/lua54.lpt:12
local indentLevel = 0 -- ./compiler/lua54.lpt:16
local function newline() -- ./compiler/lua54.lpt:18
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.lpt:19
if options["mapLines"] then -- ./compiler/lua54.lpt:20
local sub = code:sub(lastInputPos) -- ./compiler/lua54.lpt:21
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.lpt:22
if source and line then -- ./compiler/lua54.lpt:24
lastSource = source -- ./compiler/lua54.lpt:25
lastLine = tonumber(line) -- ./compiler/lua54.lpt:26
else -- ./compiler/lua54.lpt:26
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.lpt:28
lastLine = lastLine + (1) -- ./compiler/lua54.lpt:29
end -- ./compiler/lua54.lpt:29
end -- ./compiler/lua54.lpt:29
prevLinePos = lastInputPos -- ./compiler/lua54.lpt:33
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.lpt:35
end -- ./compiler/lua54.lpt:35
return r -- ./compiler/lua54.lpt:37
end -- ./compiler/lua54.lpt:37
local function indent() -- ./compiler/lua54.lpt:40
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:41
return newline() -- ./compiler/lua54.lpt:42
end -- ./compiler/lua54.lpt:42
local function unindent() -- ./compiler/lua54.lpt:45
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:46
return newline() -- ./compiler/lua54.lpt:47
end -- ./compiler/lua54.lpt:47
local states = { -- ./compiler/lua54.lpt:53
["push"] = {}, -- ./compiler/lua54.lpt:54
["destructuring"] = {}, -- ./compiler/lua54.lpt:55
["scope"] = {}, -- ./compiler/lua54.lpt:56
["macroargs"] = {} -- ./compiler/lua54.lpt:57
} -- ./compiler/lua54.lpt:57
local function push(name, state) -- ./compiler/lua54.lpt:60
states[name][# states[name] + 1] = state -- ./compiler/lua54.lpt:61
return "" -- ./compiler/lua54.lpt:62
end -- ./compiler/lua54.lpt:62
local function pop(name) -- ./compiler/lua54.lpt:65
table["remove"](states[name]) -- ./compiler/lua54.lpt:66
return "" -- ./compiler/lua54.lpt:67
end -- ./compiler/lua54.lpt:67
local function set(name, state) -- ./compiler/lua54.lpt:70
states[name][# states[name]] = state -- ./compiler/lua54.lpt:71
return "" -- ./compiler/lua54.lpt:72
end -- ./compiler/lua54.lpt:72
local function peek(name) -- ./compiler/lua54.lpt:75
return states[name][# states[name]] -- ./compiler/lua54.lpt:76
end -- ./compiler/lua54.lpt:76
local function var(name) -- ./compiler/lua54.lpt:82
return options["variablePrefix"] .. name -- ./compiler/lua54.lpt:83
end -- ./compiler/lua54.lpt:83
local function tmp() -- ./compiler/lua54.lpt:87
local scope = peek("scope") -- ./compiler/lua54.lpt:88
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.lpt:89
table["insert"](scope, var) -- ./compiler/lua54.lpt:90
return var -- ./compiler/lua54.lpt:91
end -- ./compiler/lua54.lpt:91
local nomacro = { -- ./compiler/lua54.lpt:95
["variables"] = {}, -- ./compiler/lua54.lpt:95
["functions"] = {} -- ./compiler/lua54.lpt:95
} -- ./compiler/lua54.lpt:95
local luaHeader = "" -- ./compiler/lua54.lpt:98
local function addLua(code) -- ./compiler/lua54.lpt:99
luaHeader = luaHeader .. (code) -- ./compiler/lua54.lpt:100
end -- ./compiler/lua54.lpt:100
local libraries = {} -- ./compiler/lua54.lpt:105
local function addBroadcast() -- ./compiler/lua54.lpt:107
if libraries["broadcast"] then -- ./compiler/lua54.lpt:108
return  -- ./compiler/lua54.lpt:108
end -- ./compiler/lua54.lpt:108
addLua((" -- ./compiler/lua54.lpt:110\
local function %sbroadcast(func, t) -- ./compiler/lua54.lpt:111\
    local new = {} -- ./compiler/lua54.lpt:112\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:113\
        local r1, r2 = func(v) -- ./compiler/lua54.lpt:114\
        if r2 == nil then -- ./compiler/lua54.lpt:115\
            new[k] = r1 -- ./compiler/lua54.lpt:116\
        else -- ./compiler/lua54.lpt:117\
            new[r1] = r2 -- ./compiler/lua54.lpt:118\
        end -- ./compiler/lua54.lpt:119\
    end -- ./compiler/lua54.lpt:120\
    if next(new) ~= nil then -- ./compiler/lua54.lpt:121\
        return new -- ./compiler/lua54.lpt:122\
    end -- ./compiler/lua54.lpt:123\
end -- ./compiler/lua54.lpt:124\
"):format(options["variablePrefix"], options["variablePrefix"])) -- ./compiler/lua54.lpt:125
libraries["broadcast"] = true -- ./compiler/lua54.lpt:127
end -- ./compiler/lua54.lpt:127
local function addBroadcastKV() -- ./compiler/lua54.lpt:130
if libraries["broadcastKV"] then -- ./compiler/lua54.lpt:131
return  -- ./compiler/lua54.lpt:131
end -- ./compiler/lua54.lpt:131
addLua((" -- ./compiler/lua54.lpt:133\
local function %sbroadcast_kv(func, t) -- ./compiler/lua54.lpt:134\
    local new = {} -- ./compiler/lua54.lpt:135\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:136\
        local r1, r2 = func(k, v) -- ./compiler/lua54.lpt:137\
        if r2 == nil then -- ./compiler/lua54.lpt:138\
            new[k] = r1 -- ./compiler/lua54.lpt:139\
        else -- ./compiler/lua54.lpt:140\
            new[r1] = r2 -- ./compiler/lua54.lpt:141\
        end -- ./compiler/lua54.lpt:142\
    end -- ./compiler/lua54.lpt:143\
    if next(new) ~= nil then -- ./compiler/lua54.lpt:144\
        return new -- ./compiler/lua54.lpt:145\
    end -- ./compiler/lua54.lpt:146\
end -- ./compiler/lua54.lpt:147\
"):format(options["variablePrefix"], options["variablePrefix"])) -- ./compiler/lua54.lpt:148
libraries["broadcastKV"] = true -- ./compiler/lua54.lpt:150
end -- ./compiler/lua54.lpt:150
local function addFilter() -- ./compiler/lua54.lpt:153
if libraries["filter"] then -- ./compiler/lua54.lpt:154
return  -- ./compiler/lua54.lpt:154
end -- ./compiler/lua54.lpt:154
addLua((" -- ./compiler/lua54.lpt:156\
local function %sfilter(predicate, t) -- ./compiler/lua54.lpt:157\
    local new = {} -- ./compiler/lua54.lpt:158\
    local i = 1 -- ./compiler/lua54.lpt:159\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:160\
        if predicate(v) then -- ./compiler/lua54.lpt:161\
            if type(k) == 'number' then -- ./compiler/lua54.lpt:162\
                new[i] = v -- ./compiler/lua54.lpt:163\
                i = i + 1 -- ./compiler/lua54.lpt:164\
            else -- ./compiler/lua54.lpt:165\
                new[k] = v -- ./compiler/lua54.lpt:166\
            end -- ./compiler/lua54.lpt:167\
        end -- ./compiler/lua54.lpt:168\
    end -- ./compiler/lua54.lpt:169\
    return new -- ./compiler/lua54.lpt:170\
end -- ./compiler/lua54.lpt:171\
"):format(options["variablePrefix"])) -- ./compiler/lua54.lpt:172
libraries["filter"] = true -- ./compiler/lua54.lpt:174
end -- ./compiler/lua54.lpt:174
local function addFilterKV() -- ./compiler/lua54.lpt:177
if libraries["filterKV"] then -- ./compiler/lua54.lpt:178
return  -- ./compiler/lua54.lpt:178
end -- ./compiler/lua54.lpt:178
addLua((" -- ./compiler/lua54.lpt:180\
local function %sfilter_kv(predicate, t) -- ./compiler/lua54.lpt:181\
    local new = {} -- ./compiler/lua54.lpt:182\
    local i = 1 -- ./compiler/lua54.lpt:183\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:184\
        if predicate(k, v) then -- ./compiler/lua54.lpt:185\
            if type(k) == 'number' then -- ./compiler/lua54.lpt:186\
                new[i] = v -- ./compiler/lua54.lpt:187\
                i = i + 1 -- ./compiler/lua54.lpt:188\
            else -- ./compiler/lua54.lpt:189\
                new[k] = v -- ./compiler/lua54.lpt:190\
            end -- ./compiler/lua54.lpt:191\
        end -- ./compiler/lua54.lpt:192\
    end -- ./compiler/lua54.lpt:193\
    return new -- ./compiler/lua54.lpt:194\
end -- ./compiler/lua54.lpt:195\
"):format(options["variablePrefix"])) -- ./compiler/lua54.lpt:196
libraries["filterKV"] = true -- ./compiler/lua54.lpt:198
end -- ./compiler/lua54.lpt:198
local required = {} -- ./compiler/lua54.lpt:203
local requireStr = "" -- ./compiler/lua54.lpt:204
local function addRequire(mod, name, field) -- ./compiler/lua54.lpt:206
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.lpt:207
if not required[req] then -- ./compiler/lua54.lpt:208
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.lpt:209
required[req] = true -- ./compiler/lua54.lpt:210
end -- ./compiler/lua54.lpt:210
end -- ./compiler/lua54.lpt:210
local loop = { -- ./compiler/lua54.lpt:216
"While", -- ./compiler/lua54.lpt:216
"Repeat", -- ./compiler/lua54.lpt:216
"Fornum", -- ./compiler/lua54.lpt:216
"Forin", -- ./compiler/lua54.lpt:216
"WhileExpr", -- ./compiler/lua54.lpt:216
"RepeatExpr", -- ./compiler/lua54.lpt:216
"FornumExpr", -- ./compiler/lua54.lpt:216
"ForinExpr" -- ./compiler/lua54.lpt:216
} -- ./compiler/lua54.lpt:216
local func = { -- ./compiler/lua54.lpt:217
"Function", -- ./compiler/lua54.lpt:217
"TableCompr", -- ./compiler/lua54.lpt:217
"DoExpr", -- ./compiler/lua54.lpt:217
"WhileExpr", -- ./compiler/lua54.lpt:217
"RepeatExpr", -- ./compiler/lua54.lpt:217
"IfExpr", -- ./compiler/lua54.lpt:217
"FornumExpr", -- ./compiler/lua54.lpt:217
"ForinExpr" -- ./compiler/lua54.lpt:217
} -- ./compiler/lua54.lpt:217
local function any(list, tags, nofollow) -- ./compiler/lua54.lpt:221
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:221
local tagsCheck = {} -- ./compiler/lua54.lpt:222
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:223
tagsCheck[tag] = true -- ./compiler/lua54.lpt:224
end -- ./compiler/lua54.lpt:224
local nofollowCheck = {} -- ./compiler/lua54.lpt:226
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:227
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:228
end -- ./compiler/lua54.lpt:228
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:230
if type(node) == "table" then -- ./compiler/lua54.lpt:231
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:232
return node -- ./compiler/lua54.lpt:233
end -- ./compiler/lua54.lpt:233
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:235
local r = any(node, tags, nofollow) -- ./compiler/lua54.lpt:236
if r then -- ./compiler/lua54.lpt:237
return r -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
return nil -- ./compiler/lua54.lpt:241
end -- ./compiler/lua54.lpt:241
local function search(list, tags, nofollow) -- ./compiler/lua54.lpt:246
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:246
local tagsCheck = {} -- ./compiler/lua54.lpt:247
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:248
tagsCheck[tag] = true -- ./compiler/lua54.lpt:249
end -- ./compiler/lua54.lpt:249
local nofollowCheck = {} -- ./compiler/lua54.lpt:251
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:252
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:253
end -- ./compiler/lua54.lpt:253
local found = {} -- ./compiler/lua54.lpt:255
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:256
if type(node) == "table" then -- ./compiler/lua54.lpt:257
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:258
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.lpt:259
table["insert"](found, n) -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:263
table["insert"](found, node) -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
return found -- ./compiler/lua54.lpt:268
end -- ./compiler/lua54.lpt:268
local function all(list, tags) -- ./compiler/lua54.lpt:272
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:273
local ok = false -- ./compiler/lua54.lpt:274
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:275
if node["tag"] == tag then -- ./compiler/lua54.lpt:276
ok = true -- ./compiler/lua54.lpt:277
break -- ./compiler/lua54.lpt:278
end -- ./compiler/lua54.lpt:278
end -- ./compiler/lua54.lpt:278
if not ok then -- ./compiler/lua54.lpt:281
return false -- ./compiler/lua54.lpt:282
end -- ./compiler/lua54.lpt:282
end -- ./compiler/lua54.lpt:282
return true -- ./compiler/lua54.lpt:285
end -- ./compiler/lua54.lpt:285
local tags -- ./compiler/lua54.lpt:290
local function lua(ast, forceTag, ...) -- ./compiler/lua54.lpt:292
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.lpt:293
lastInputPos = ast["pos"] -- ./compiler/lua54.lpt:294
end -- ./compiler/lua54.lpt:294
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.lpt:296
end -- ./compiler/lua54.lpt:296
local UNPACK = function(list, i, j) -- ./compiler/lua54.lpt:301
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.lpt:302
end -- ./compiler/lua54.lpt:302
local APPEND = function(t, toAppend) -- ./compiler/lua54.lpt:304
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.lpt:305
end -- ./compiler/lua54.lpt:305
local CONTINUE_START = function() -- ./compiler/lua54.lpt:307
return "do" .. indent() -- ./compiler/lua54.lpt:308
end -- ./compiler/lua54.lpt:308
local CONTINUE_STOP = function() -- ./compiler/lua54.lpt:310
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.lpt:311
end -- ./compiler/lua54.lpt:311
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.lpt:314
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.lpt:314
if noLocal == nil then noLocal = false end -- ./compiler/lua54.lpt:314
local vars = {} -- ./compiler/lua54.lpt:315
local values = {} -- ./compiler/lua54.lpt:316
for _, list in ipairs(destructured) do -- ./compiler/lua54.lpt:317
for _, v in ipairs(list) do -- ./compiler/lua54.lpt:318
local var, val -- ./compiler/lua54.lpt:319
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.lpt:320
var = v -- ./compiler/lua54.lpt:321
val = { -- ./compiler/lua54.lpt:322
["tag"] = "Index", -- ./compiler/lua54.lpt:322
{ -- ./compiler/lua54.lpt:322
["tag"] = "Id", -- ./compiler/lua54.lpt:322
list["id"] -- ./compiler/lua54.lpt:322
}, -- ./compiler/lua54.lpt:322
{ -- ./compiler/lua54.lpt:322
["tag"] = "String", -- ./compiler/lua54.lpt:322
v[1] -- ./compiler/lua54.lpt:322
} -- ./compiler/lua54.lpt:322
} -- ./compiler/lua54.lpt:322
elseif v["tag"] == "Pair" then -- ./compiler/lua54.lpt:323
var = v[2] -- ./compiler/lua54.lpt:324
val = { -- ./compiler/lua54.lpt:325
["tag"] = "Index", -- ./compiler/lua54.lpt:325
{ -- ./compiler/lua54.lpt:325
["tag"] = "Id", -- ./compiler/lua54.lpt:325
list["id"] -- ./compiler/lua54.lpt:325
}, -- ./compiler/lua54.lpt:325
v[1] -- ./compiler/lua54.lpt:325
} -- ./compiler/lua54.lpt:325
else -- ./compiler/lua54.lpt:325
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.lpt:327
end -- ./compiler/lua54.lpt:327
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.lpt:329
val = { -- ./compiler/lua54.lpt:330
["tag"] = "Op", -- ./compiler/lua54.lpt:330
destructured["rightOp"], -- ./compiler/lua54.lpt:330
var, -- ./compiler/lua54.lpt:330
{ -- ./compiler/lua54.lpt:330
["tag"] = "Op", -- ./compiler/lua54.lpt:330
destructured["leftOp"], -- ./compiler/lua54.lpt:330
val, -- ./compiler/lua54.lpt:330
var -- ./compiler/lua54.lpt:330
} -- ./compiler/lua54.lpt:330
} -- ./compiler/lua54.lpt:330
elseif destructured["rightOp"] then -- ./compiler/lua54.lpt:331
val = { -- ./compiler/lua54.lpt:332
["tag"] = "Op", -- ./compiler/lua54.lpt:332
destructured["rightOp"], -- ./compiler/lua54.lpt:332
var, -- ./compiler/lua54.lpt:332
val -- ./compiler/lua54.lpt:332
} -- ./compiler/lua54.lpt:332
elseif destructured["leftOp"] then -- ./compiler/lua54.lpt:333
val = { -- ./compiler/lua54.lpt:334
["tag"] = "Op", -- ./compiler/lua54.lpt:334
destructured["leftOp"], -- ./compiler/lua54.lpt:334
val, -- ./compiler/lua54.lpt:334
var -- ./compiler/lua54.lpt:334
} -- ./compiler/lua54.lpt:334
end -- ./compiler/lua54.lpt:334
table["insert"](vars, lua(var)) -- ./compiler/lua54.lpt:336
table["insert"](values, lua(val)) -- ./compiler/lua54.lpt:337
end -- ./compiler/lua54.lpt:337
end -- ./compiler/lua54.lpt:337
if # vars > 0 then -- ./compiler/lua54.lpt:340
local decl = noLocal and "" or "local " -- ./compiler/lua54.lpt:341
if newlineAfter then -- ./compiler/lua54.lpt:342
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.lpt:343
else -- ./compiler/lua54.lpt:343
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.lpt:345
end -- ./compiler/lua54.lpt:345
else -- ./compiler/lua54.lpt:345
return "" -- ./compiler/lua54.lpt:348
end -- ./compiler/lua54.lpt:348
end -- ./compiler/lua54.lpt:348
local BROADCAST = function(t, use_kv) -- ./compiler/lua54.lpt:352
((use_kv and addBroadcastKV) or addBroadcast)() -- ./compiler/lua54.lpt:353
return table["concat"]({ -- ./compiler/lua54.lpt:354
options["variablePrefix"], -- ./compiler/lua54.lpt:354
(use_kv and "broadcast_kv(") or "broadcast(", -- ./compiler/lua54.lpt:354
lua(t[1]), -- ./compiler/lua54.lpt:354
",", -- ./compiler/lua54.lpt:354
lua(t[2]), -- ./compiler/lua54.lpt:354
")" -- ./compiler/lua54.lpt:354
}) -- ./compiler/lua54.lpt:354
end -- ./compiler/lua54.lpt:354
local FILTER = function(t, use_kv) -- ./compiler/lua54.lpt:356
((use_kv and addFilterKV) or addFilter)() -- ./compiler/lua54.lpt:357
return table["concat"]({ -- ./compiler/lua54.lpt:358
options["variablePrefix"], -- ./compiler/lua54.lpt:358
(use_kv and "filter_kv(") or "filter(", -- ./compiler/lua54.lpt:358
lua(t[1]), -- ./compiler/lua54.lpt:358
",", -- ./compiler/lua54.lpt:358
lua(t[2]), -- ./compiler/lua54.lpt:358
")" -- ./compiler/lua54.lpt:358
}) -- ./compiler/lua54.lpt:358
end -- ./compiler/lua54.lpt:358
tags = setmetatable({ -- ./compiler/lua54.lpt:363
["Block"] = function(t) -- ./compiler/lua54.lpt:366
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.lpt:367
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.lpt:368
hasPush["tag"] = "Return" -- ./compiler/lua54.lpt:369
hasPush = false -- ./compiler/lua54.lpt:370
end -- ./compiler/lua54.lpt:370
local r = push("scope", {}) -- ./compiler/lua54.lpt:372
if hasPush then -- ./compiler/lua54.lpt:373
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:374
end -- ./compiler/lua54.lpt:374
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:376
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:377
end -- ./compiler/lua54.lpt:377
if t[# t] then -- ./compiler/lua54.lpt:379
r = r .. (lua(t[# t])) -- ./compiler/lua54.lpt:380
end -- ./compiler/lua54.lpt:380
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:382
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.lpt:383
end -- ./compiler/lua54.lpt:383
return r .. pop("scope") -- ./compiler/lua54.lpt:385
end, -- ./compiler/lua54.lpt:385
["Do"] = function(t) -- ./compiler/lua54.lpt:391
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.lpt:392
end, -- ./compiler/lua54.lpt:392
["Set"] = function(t) -- ./compiler/lua54.lpt:395
local expr = t[# t] -- ./compiler/lua54.lpt:397
local vars, values = {}, {} -- ./compiler/lua54.lpt:398
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.lpt:399
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:400
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.lpt:401
table["insert"](destructuringVars, n) -- ./compiler/lua54.lpt:402
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.lpt:403
else -- ./compiler/lua54.lpt:403
table["insert"](vars, n) -- ./compiler/lua54.lpt:405
table["insert"](values, expr[i]) -- ./compiler/lua54.lpt:406
end -- ./compiler/lua54.lpt:406
end -- ./compiler/lua54.lpt:406
if # t == 2 or # t == 3 then -- ./compiler/lua54.lpt:410
local r = "" -- ./compiler/lua54.lpt:411
if # vars > 0 then -- ./compiler/lua54.lpt:412
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.lpt:413
end -- ./compiler/lua54.lpt:413
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:415
local destructured = {} -- ./compiler/lua54.lpt:416
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:417
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:418
end -- ./compiler/lua54.lpt:418
return r -- ./compiler/lua54.lpt:420
elseif # t == 4 then -- ./compiler/lua54.lpt:421
if t[3] == "=" then -- ./compiler/lua54.lpt:422
local r = "" -- ./compiler/lua54.lpt:423
if # vars > 0 then -- ./compiler/lua54.lpt:424
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:425
t[2], -- ./compiler/lua54.lpt:425
vars[1], -- ./compiler/lua54.lpt:425
{ -- ./compiler/lua54.lpt:425
["tag"] = "Paren", -- ./compiler/lua54.lpt:425
values[1] -- ./compiler/lua54.lpt:425
} -- ./compiler/lua54.lpt:425
}, "Op")) -- ./compiler/lua54.lpt:425
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.lpt:426
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:427
t[2], -- ./compiler/lua54.lpt:427
vars[i], -- ./compiler/lua54.lpt:427
{ -- ./compiler/lua54.lpt:427
["tag"] = "Paren", -- ./compiler/lua54.lpt:427
values[i] -- ./compiler/lua54.lpt:427
} -- ./compiler/lua54.lpt:427
}, "Op")) -- ./compiler/lua54.lpt:427
end -- ./compiler/lua54.lpt:427
end -- ./compiler/lua54.lpt:427
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:430
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.lpt:431
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:432
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:433
end -- ./compiler/lua54.lpt:433
return r -- ./compiler/lua54.lpt:435
else -- ./compiler/lua54.lpt:435
local r = "" -- ./compiler/lua54.lpt:437
if # vars > 0 then -- ./compiler/lua54.lpt:438
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:439
t[3], -- ./compiler/lua54.lpt:439
{ -- ./compiler/lua54.lpt:439
["tag"] = "Paren", -- ./compiler/lua54.lpt:439
values[1] -- ./compiler/lua54.lpt:439
}, -- ./compiler/lua54.lpt:439
vars[1] -- ./compiler/lua54.lpt:439
}, "Op")) -- ./compiler/lua54.lpt:439
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.lpt:440
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:441
t[3], -- ./compiler/lua54.lpt:441
{ -- ./compiler/lua54.lpt:441
["tag"] = "Paren", -- ./compiler/lua54.lpt:441
values[i] -- ./compiler/lua54.lpt:441
}, -- ./compiler/lua54.lpt:441
vars[i] -- ./compiler/lua54.lpt:441
}, "Op")) -- ./compiler/lua54.lpt:441
end -- ./compiler/lua54.lpt:441
end -- ./compiler/lua54.lpt:441
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:444
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.lpt:445
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:446
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:447
end -- ./compiler/lua54.lpt:447
return r -- ./compiler/lua54.lpt:449
end -- ./compiler/lua54.lpt:449
else -- ./compiler/lua54.lpt:449
local r = "" -- ./compiler/lua54.lpt:452
if # vars > 0 then -- ./compiler/lua54.lpt:453
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:454
t[2], -- ./compiler/lua54.lpt:454
vars[1], -- ./compiler/lua54.lpt:454
{ -- ./compiler/lua54.lpt:454
["tag"] = "Op", -- ./compiler/lua54.lpt:454
t[4], -- ./compiler/lua54.lpt:454
{ -- ./compiler/lua54.lpt:454
["tag"] = "Paren", -- ./compiler/lua54.lpt:454
values[1] -- ./compiler/lua54.lpt:454
}, -- ./compiler/lua54.lpt:454
vars[1] -- ./compiler/lua54.lpt:454
} -- ./compiler/lua54.lpt:454
}, "Op")) -- ./compiler/lua54.lpt:454
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.lpt:455
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:456
t[2], -- ./compiler/lua54.lpt:456
vars[i], -- ./compiler/lua54.lpt:456
{ -- ./compiler/lua54.lpt:456
["tag"] = "Op", -- ./compiler/lua54.lpt:456
t[4], -- ./compiler/lua54.lpt:456
{ -- ./compiler/lua54.lpt:456
["tag"] = "Paren", -- ./compiler/lua54.lpt:456
values[i] -- ./compiler/lua54.lpt:456
}, -- ./compiler/lua54.lpt:456
vars[i] -- ./compiler/lua54.lpt:456
} -- ./compiler/lua54.lpt:456
}, "Op")) -- ./compiler/lua54.lpt:456
end -- ./compiler/lua54.lpt:456
end -- ./compiler/lua54.lpt:456
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:459
local destructured = { -- ./compiler/lua54.lpt:460
["rightOp"] = t[2], -- ./compiler/lua54.lpt:460
["leftOp"] = t[4] -- ./compiler/lua54.lpt:460
} -- ./compiler/lua54.lpt:460
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:461
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:462
end -- ./compiler/lua54.lpt:462
return r -- ./compiler/lua54.lpt:464
end -- ./compiler/lua54.lpt:464
end, -- ./compiler/lua54.lpt:464
["AppendSet"] = function(t) -- ./compiler/lua54.lpt:468
local expr = t[# t] -- ./compiler/lua54.lpt:470
local r = {} -- ./compiler/lua54.lpt:471
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:472
local value = expr[i] -- ./compiler/lua54.lpt:473
if value == nil then -- ./compiler/lua54.lpt:474
break -- ./compiler/lua54.lpt:475
end -- ./compiler/lua54.lpt:475
local var = lua(n) -- ./compiler/lua54.lpt:478
r[i] = { -- ./compiler/lua54.lpt:479
var, -- ./compiler/lua54.lpt:479
"[#", -- ./compiler/lua54.lpt:479
var, -- ./compiler/lua54.lpt:479
"+1] = ", -- ./compiler/lua54.lpt:479
lua(value) -- ./compiler/lua54.lpt:479
} -- ./compiler/lua54.lpt:479
r[i] = table["concat"](r[i]) -- ./compiler/lua54.lpt:480
end -- ./compiler/lua54.lpt:480
return table["concat"](r, "; ") -- ./compiler/lua54.lpt:482
end, -- ./compiler/lua54.lpt:482
["While"] = function(t) -- ./compiler/lua54.lpt:485
local r = "" -- ./compiler/lua54.lpt:486
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.lpt:487
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:488
if # lets > 0 then -- ./compiler/lua54.lpt:489
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:490
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:491
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:492
end -- ./compiler/lua54.lpt:492
end -- ./compiler/lua54.lpt:492
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.lpt:495
if # lets > 0 then -- ./compiler/lua54.lpt:496
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:497
end -- ./compiler/lua54.lpt:497
if hasContinue then -- ./compiler/lua54.lpt:499
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:500
end -- ./compiler/lua54.lpt:500
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:502
if hasContinue then -- ./compiler/lua54.lpt:503
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:504
end -- ./compiler/lua54.lpt:504
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:506
if # lets > 0 then -- ./compiler/lua54.lpt:507
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:508
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.lpt:509
end -- ./compiler/lua54.lpt:509
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.lpt:511
end -- ./compiler/lua54.lpt:511
return r -- ./compiler/lua54.lpt:513
end, -- ./compiler/lua54.lpt:513
["Repeat"] = function(t) -- ./compiler/lua54.lpt:516
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.lpt:517
local r = "repeat" .. indent() -- ./compiler/lua54.lpt:518
if hasContinue then -- ./compiler/lua54.lpt:519
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:520
end -- ./compiler/lua54.lpt:520
r = r .. (lua(t[1])) -- ./compiler/lua54.lpt:522
if hasContinue then -- ./compiler/lua54.lpt:523
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.lpt:526
return r -- ./compiler/lua54.lpt:527
end, -- ./compiler/lua54.lpt:527
["If"] = function(t) -- ./compiler/lua54.lpt:530
local r = "" -- ./compiler/lua54.lpt:531
local toClose = 0 -- ./compiler/lua54.lpt:532
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:533
if # lets > 0 then -- ./compiler/lua54.lpt:534
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:535
toClose = toClose + (1) -- ./compiler/lua54.lpt:536
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:537
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:538
end -- ./compiler/lua54.lpt:538
end -- ./compiler/lua54.lpt:538
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.lpt:541
for i = 3, # t - 1, 2 do -- ./compiler/lua54.lpt:542
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.lpt:543
if # lets > 0 then -- ./compiler/lua54.lpt:544
r = r .. ("else" .. indent()) -- ./compiler/lua54.lpt:545
toClose = toClose + (1) -- ./compiler/lua54.lpt:546
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:547
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:548
end -- ./compiler/lua54.lpt:548
else -- ./compiler/lua54.lpt:548
r = r .. ("else") -- ./compiler/lua54.lpt:551
end -- ./compiler/lua54.lpt:551
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.lpt:553
end -- ./compiler/lua54.lpt:553
if # t % 2 == 1 then -- ./compiler/lua54.lpt:555
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.lpt:556
end -- ./compiler/lua54.lpt:556
r = r .. ("end") -- ./compiler/lua54.lpt:558
for i = 1, toClose do -- ./compiler/lua54.lpt:559
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:560
end -- ./compiler/lua54.lpt:560
return r -- ./compiler/lua54.lpt:562
end, -- ./compiler/lua54.lpt:562
["Fornum"] = function(t) -- ./compiler/lua54.lpt:565
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.lpt:566
if # t == 5 then -- ./compiler/lua54.lpt:567
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.lpt:568
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.lpt:569
if hasContinue then -- ./compiler/lua54.lpt:570
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:571
end -- ./compiler/lua54.lpt:571
r = r .. (lua(t[5])) -- ./compiler/lua54.lpt:573
if hasContinue then -- ./compiler/lua54.lpt:574
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:575
end -- ./compiler/lua54.lpt:575
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:577
else -- ./compiler/lua54.lpt:577
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.lpt:579
r = r .. (" do" .. indent()) -- ./compiler/lua54.lpt:580
if hasContinue then -- ./compiler/lua54.lpt:581
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:582
end -- ./compiler/lua54.lpt:582
r = r .. (lua(t[4])) -- ./compiler/lua54.lpt:584
if hasContinue then -- ./compiler/lua54.lpt:585
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:586
end -- ./compiler/lua54.lpt:586
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:588
end -- ./compiler/lua54.lpt:588
end, -- ./compiler/lua54.lpt:588
["Forin"] = function(t) -- ./compiler/lua54.lpt:592
local destructured = {} -- ./compiler/lua54.lpt:593
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.lpt:594
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.lpt:595
if hasContinue then -- ./compiler/lua54.lpt:596
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:597
end -- ./compiler/lua54.lpt:597
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.lpt:599
if hasContinue then -- ./compiler/lua54.lpt:600
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:601
end -- ./compiler/lua54.lpt:601
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:603
end, -- ./compiler/lua54.lpt:603
["Local"] = function(t) -- ./compiler/lua54.lpt:606
local destructured = {} -- ./compiler/lua54.lpt:607
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:608
if t[2][1] then -- ./compiler/lua54.lpt:609
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:610
end -- ./compiler/lua54.lpt:610
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:612
end, -- ./compiler/lua54.lpt:612
["Let"] = function(t) -- ./compiler/lua54.lpt:615
local destructured = {} -- ./compiler/lua54.lpt:616
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:617
local r = "local " .. nameList -- ./compiler/lua54.lpt:618
if t[2][1] then -- ./compiler/lua54.lpt:619
if all(t[2], { -- ./compiler/lua54.lpt:620
"Nil", -- ./compiler/lua54.lpt:620
"Dots", -- ./compiler/lua54.lpt:620
"Boolean", -- ./compiler/lua54.lpt:620
"Number", -- ./compiler/lua54.lpt:620
"String" -- ./compiler/lua54.lpt:620
}) then -- ./compiler/lua54.lpt:620
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:621
else -- ./compiler/lua54.lpt:621
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:623
end -- ./compiler/lua54.lpt:623
end -- ./compiler/lua54.lpt:623
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:626
end, -- ./compiler/lua54.lpt:626
["Localrec"] = function(t) -- ./compiler/lua54.lpt:629
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.lpt:630
end, -- ./compiler/lua54.lpt:630
["Goto"] = function(t) -- ./compiler/lua54.lpt:633
return "goto " .. lua(t, "Id") -- ./compiler/lua54.lpt:634
end, -- ./compiler/lua54.lpt:634
["Label"] = function(t) -- ./compiler/lua54.lpt:637
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.lpt:638
end, -- ./compiler/lua54.lpt:638
["Return"] = function(t) -- ./compiler/lua54.lpt:641
local push = peek("push") -- ./compiler/lua54.lpt:642
if push then -- ./compiler/lua54.lpt:643
local r = "" -- ./compiler/lua54.lpt:644
for _, val in ipairs(t) do -- ./compiler/lua54.lpt:645
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.lpt:646
end -- ./compiler/lua54.lpt:646
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.lpt:648
else -- ./compiler/lua54.lpt:648
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.lpt:650
end -- ./compiler/lua54.lpt:650
end, -- ./compiler/lua54.lpt:650
["Push"] = function(t) -- ./compiler/lua54.lpt:654
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.lpt:655
r = "" -- ./compiler/lua54.lpt:656
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:657
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:658
end -- ./compiler/lua54.lpt:658
if t[# t] then -- ./compiler/lua54.lpt:660
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.lpt:661
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.lpt:662
else -- ./compiler/lua54.lpt:662
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.lpt:664
end -- ./compiler/lua54.lpt:664
end -- ./compiler/lua54.lpt:664
return r -- ./compiler/lua54.lpt:667
end, -- ./compiler/lua54.lpt:667
["Break"] = function() -- ./compiler/lua54.lpt:670
return "break" -- ./compiler/lua54.lpt:671
end, -- ./compiler/lua54.lpt:671
["Continue"] = function() -- ./compiler/lua54.lpt:674
return "goto " .. var("continue") -- ./compiler/lua54.lpt:675
end, -- ./compiler/lua54.lpt:675
["Nil"] = function() -- ./compiler/lua54.lpt:682
return "nil" -- ./compiler/lua54.lpt:683
end, -- ./compiler/lua54.lpt:683
["Dots"] = function() -- ./compiler/lua54.lpt:686
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:687
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.lpt:688
nomacro["variables"]["..."] = true -- ./compiler/lua54.lpt:689
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.lpt:690
nomacro["variables"]["..."] = nil -- ./compiler/lua54.lpt:691
return r -- ./compiler/lua54.lpt:692
else -- ./compiler/lua54.lpt:692
return "..." -- ./compiler/lua54.lpt:694
end -- ./compiler/lua54.lpt:694
end, -- ./compiler/lua54.lpt:694
["Boolean"] = function(t) -- ./compiler/lua54.lpt:698
return tostring(t[1]) -- ./compiler/lua54.lpt:699
end, -- ./compiler/lua54.lpt:699
["Number"] = function(t) -- ./compiler/lua54.lpt:702
local n = tostring(t[1]):gsub("_", "") -- ./compiler/lua54.lpt:703
do -- ./compiler/lua54.lpt:705
local match -- ./compiler/lua54.lpt:705
match = n:match("^0b(.*)") -- ./compiler/lua54.lpt:705
if match then -- ./compiler/lua54.lpt:705
n = tostring(tonumber(match, 2)) -- ./compiler/lua54.lpt:706
end -- ./compiler/lua54.lpt:706
end -- ./compiler/lua54.lpt:706
return n -- ./compiler/lua54.lpt:708
end, -- ./compiler/lua54.lpt:708
["String"] = function(t) -- ./compiler/lua54.lpt:711
return ("%q"):format(t[1]) -- ./compiler/lua54.lpt:712
end, -- ./compiler/lua54.lpt:712
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.lpt:715
local r = "(" -- ./compiler/lua54.lpt:716
local decl = {} -- ./compiler/lua54.lpt:717
if t[1][1] then -- ./compiler/lua54.lpt:718
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:719
local id = lua(t[1][1][1]) -- ./compiler/lua54.lpt:720
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:721
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.lpt:722
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:723
r = r .. (id) -- ./compiler/lua54.lpt:724
else -- ./compiler/lua54.lpt:724
r = r .. (lua(t[1][1])) -- ./compiler/lua54.lpt:726
end -- ./compiler/lua54.lpt:726
for i = 2, # t[1], 1 do -- ./compiler/lua54.lpt:728
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:729
local id = lua(t[1][i][1]) -- ./compiler/lua54.lpt:730
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:731
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.lpt:732
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:733
r = r .. (", " .. id) -- ./compiler/lua54.lpt:734
else -- ./compiler/lua54.lpt:734
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
r = r .. (")" .. indent()) -- ./compiler/lua54.lpt:740
for _, d in ipairs(decl) do -- ./compiler/lua54.lpt:741
r = r .. (d .. newline()) -- ./compiler/lua54.lpt:742
end -- ./compiler/lua54.lpt:742
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.lpt:744
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.lpt:745
end -- ./compiler/lua54.lpt:745
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.lpt:747
if hasPush then -- ./compiler/lua54.lpt:748
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:749
else -- ./compiler/lua54.lpt:749
push("push", false) -- ./compiler/lua54.lpt:751
end -- ./compiler/lua54.lpt:751
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:753
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:754
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:755
end -- ./compiler/lua54.lpt:755
pop("push") -- ./compiler/lua54.lpt:757
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:758
end, -- ./compiler/lua54.lpt:758
["Function"] = function(t) -- ./compiler/lua54.lpt:760
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.lpt:761
end, -- ./compiler/lua54.lpt:761
["Pair"] = function(t) -- ./compiler/lua54.lpt:764
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.lpt:765
end, -- ./compiler/lua54.lpt:765
["Table"] = function(t) -- ./compiler/lua54.lpt:767
if # t == 0 then -- ./compiler/lua54.lpt:768
return "{}" -- ./compiler/lua54.lpt:769
elseif # t == 1 then -- ./compiler/lua54.lpt:770
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.lpt:771
else -- ./compiler/lua54.lpt:771
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.lpt:773
end -- ./compiler/lua54.lpt:773
end, -- ./compiler/lua54.lpt:773
["TableCompr"] = function(t) -- ./compiler/lua54.lpt:777
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.lpt:778
end, -- ./compiler/lua54.lpt:778
["Op"] = function(t) -- ./compiler/lua54.lpt:781
local r -- ./compiler/lua54.lpt:782
if # t == 2 then -- ./compiler/lua54.lpt:783
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:784
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.lpt:785
else -- ./compiler/lua54.lpt:785
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.lpt:787
end -- ./compiler/lua54.lpt:787
else -- ./compiler/lua54.lpt:787
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:790
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.lpt:791
else -- ./compiler/lua54.lpt:791
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.lpt:793
end -- ./compiler/lua54.lpt:793
end -- ./compiler/lua54.lpt:793
return r -- ./compiler/lua54.lpt:796
end, -- ./compiler/lua54.lpt:796
["Paren"] = function(t) -- ./compiler/lua54.lpt:799
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.lpt:800
end, -- ./compiler/lua54.lpt:800
["MethodStub"] = function(t) -- ./compiler/lua54.lpt:803
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:809
end, -- ./compiler/lua54.lpt:809
["SafeMethodStub"] = function(t) -- ./compiler/lua54.lpt:812
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:819
end, -- ./compiler/lua54.lpt:819
["LetExpr"] = function(t) -- ./compiler/lua54.lpt:826
return lua(t[1][1]) -- ./compiler/lua54.lpt:827
end, -- ./compiler/lua54.lpt:827
["_statexpr"] = function(t, stat) -- ./compiler/lua54.lpt:831
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.lpt:832
local r = "(function()" .. indent() -- ./compiler/lua54.lpt:833
if hasPush then -- ./compiler/lua54.lpt:834
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:835
else -- ./compiler/lua54.lpt:835
push("push", false) -- ./compiler/lua54.lpt:837
end -- ./compiler/lua54.lpt:837
r = r .. (lua(t, stat)) -- ./compiler/lua54.lpt:839
if hasPush then -- ./compiler/lua54.lpt:840
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:841
end -- ./compiler/lua54.lpt:841
pop("push") -- ./compiler/lua54.lpt:843
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.lpt:844
return r -- ./compiler/lua54.lpt:845
end, -- ./compiler/lua54.lpt:845
["DoExpr"] = function(t) -- ./compiler/lua54.lpt:848
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.lpt:849
t[# t]["tag"] = "Return" -- ./compiler/lua54.lpt:850
end -- ./compiler/lua54.lpt:850
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.lpt:852
end, -- ./compiler/lua54.lpt:852
["WhileExpr"] = function(t) -- ./compiler/lua54.lpt:855
return lua(t, "_statexpr", "While") -- ./compiler/lua54.lpt:856
end, -- ./compiler/lua54.lpt:856
["RepeatExpr"] = function(t) -- ./compiler/lua54.lpt:859
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.lpt:860
end, -- ./compiler/lua54.lpt:860
["IfExpr"] = function(t) -- ./compiler/lua54.lpt:863
for i = 2, # t do -- ./compiler/lua54.lpt:864
local block = t[i] -- ./compiler/lua54.lpt:865
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.lpt:866
block[# block]["tag"] = "Return" -- ./compiler/lua54.lpt:867
end -- ./compiler/lua54.lpt:867
end -- ./compiler/lua54.lpt:867
return lua(t, "_statexpr", "If") -- ./compiler/lua54.lpt:870
end, -- ./compiler/lua54.lpt:870
["FornumExpr"] = function(t) -- ./compiler/lua54.lpt:873
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.lpt:874
end, -- ./compiler/lua54.lpt:874
["ForinExpr"] = function(t) -- ./compiler/lua54.lpt:877
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.lpt:878
end, -- ./compiler/lua54.lpt:878
["Call"] = function(t) -- ./compiler/lua54.lpt:885
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:886
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:887
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.lpt:888
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.lpt:889
local replacement = macro["replacement"] -- ./compiler/lua54.lpt:890
local r -- ./compiler/lua54.lpt:891
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.lpt:892
if type(replacement) == "function" then -- ./compiler/lua54.lpt:893
local args = {} -- ./compiler/lua54.lpt:894
for i = 2, # t do -- ./compiler/lua54.lpt:895
table["insert"](args, lua(t[i])) -- ./compiler/lua54.lpt:896
end -- ./compiler/lua54.lpt:896
r = replacement(unpack(args)) -- ./compiler/lua54.lpt:898
else -- ./compiler/lua54.lpt:898
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.lpt:900
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.lpt:901
if arg["tag"] == "Dots" then -- ./compiler/lua54.lpt:902
macroargs["..."] = (function() -- ./compiler/lua54.lpt:903
local self = {} -- ./compiler/lua54.lpt:903
for j = i + 1, # t do -- ./compiler/lua54.lpt:903
self[#self+1] = t[j] -- ./compiler/lua54.lpt:903
end -- ./compiler/lua54.lpt:903
return self -- ./compiler/lua54.lpt:903
end)() -- ./compiler/lua54.lpt:903
elseif arg["tag"] == "Id" then -- ./compiler/lua54.lpt:904
if t[i + 1] == nil then -- ./compiler/lua54.lpt:905
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.lpt:906
end -- ./compiler/lua54.lpt:906
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.lpt:908
else -- ./compiler/lua54.lpt:908
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.lpt:910
end -- ./compiler/lua54.lpt:910
end -- ./compiler/lua54.lpt:910
push("macroargs", macroargs) -- ./compiler/lua54.lpt:913
r = lua(replacement) -- ./compiler/lua54.lpt:914
pop("macroargs") -- ./compiler/lua54.lpt:915
end -- ./compiler/lua54.lpt:915
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.lpt:917
return r -- ./compiler/lua54.lpt:918
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.lpt:919
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.lpt:920
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:921
else -- ./compiler/lua54.lpt:921
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:923
end -- ./compiler/lua54.lpt:923
else -- ./compiler/lua54.lpt:923
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:926
end -- ./compiler/lua54.lpt:926
end, -- ./compiler/lua54.lpt:926
["SafeCall"] = function(t) -- ./compiler/lua54.lpt:930
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:931
return lua(t, "SafeIndex") -- ./compiler/lua54.lpt:932
else -- ./compiler/lua54.lpt:932
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.lpt:934
end -- ./compiler/lua54.lpt:934
end, -- ./compiler/lua54.lpt:934
["Broadcast"] = function(t) -- ./compiler/lua54.lpt:940
return BROADCAST(t, false) -- ./compiler/lua54.lpt:941
end, -- ./compiler/lua54.lpt:941
["BroadcastKV"] = function(t) -- ./compiler/lua54.lpt:943
return BROADCAST(t, true) -- ./compiler/lua54.lpt:944
end, -- ./compiler/lua54.lpt:944
["Filter"] = function(t) -- ./compiler/lua54.lpt:946
return FILTER(t, false) -- ./compiler/lua54.lpt:947
end, -- ./compiler/lua54.lpt:947
["FilterKV"] = function(t) -- ./compiler/lua54.lpt:949
return FILTER(t, true) -- ./compiler/lua54.lpt:950
end, -- ./compiler/lua54.lpt:950
["StringFormat"] = function(t) -- ./compiler/lua54.lpt:955
local args = {} -- ./compiler/lua54.lpt:956
for i, v in ipairs(t[2]) do -- ./compiler/lua54.lpt:957
args[i] = lua(v) -- ./compiler/lua54.lpt:958
end -- ./compiler/lua54.lpt:958
local r = { -- ./compiler/lua54.lpt:960
"(", -- ./compiler/lua54.lpt:960
"string.format(", -- ./compiler/lua54.lpt:960
("%q"):format(t[1]) -- ./compiler/lua54.lpt:960
} -- ./compiler/lua54.lpt:960
if # args ~= 0 then -- ./compiler/lua54.lpt:961
r[# r + 1] = ", " -- ./compiler/lua54.lpt:962
r[# r + 1] = table["concat"](args, ", ") -- ./compiler/lua54.lpt:963
r[# r + 1] = "))" -- ./compiler/lua54.lpt:964
end -- ./compiler/lua54.lpt:964
return table["concat"](r) -- ./compiler/lua54.lpt:966
end, -- ./compiler/lua54.lpt:966
["TableUnpack"] = function(t) -- ./compiler/lua54.lpt:971
local args = {} -- ./compiler/lua54.lpt:972
for i, v in ipairs(t[2]) do -- ./compiler/lua54.lpt:973
args[i] = lua(v) -- ./compiler/lua54.lpt:974
end -- ./compiler/lua54.lpt:974
return UNPACK(lua(t[1]), args[1], args[2]) -- ./compiler/lua54.lpt:976
end, -- ./compiler/lua54.lpt:976
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.lpt:982
if start == nil then start = 1 end -- ./compiler/lua54.lpt:982
local r -- ./compiler/lua54.lpt:983
if t[start] then -- ./compiler/lua54.lpt:984
r = lua(t[start]) -- ./compiler/lua54.lpt:985
for i = start + 1, # t, 1 do -- ./compiler/lua54.lpt:986
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.lpt:987
end -- ./compiler/lua54.lpt:987
else -- ./compiler/lua54.lpt:987
r = "" -- ./compiler/lua54.lpt:990
end -- ./compiler/lua54.lpt:990
return r -- ./compiler/lua54.lpt:992
end, -- ./compiler/lua54.lpt:992
["Id"] = function(t) -- ./compiler/lua54.lpt:995
local r = t[1] -- ./compiler/lua54.lpt:996
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:997
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.lpt:998
nomacro["variables"][t[1]] = true -- ./compiler/lua54.lpt:999
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.lpt:1000
r = lua(macroargs[t[1]]) -- ./compiler/lua54.lpt:1001
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.lpt:1002
local macro = macros["variables"][t[1]] -- ./compiler/lua54.lpt:1003
if type(macro) == "function" then -- ./compiler/lua54.lpt:1004
r = macro() -- ./compiler/lua54.lpt:1005
else -- ./compiler/lua54.lpt:1005
r = lua(macro) -- ./compiler/lua54.lpt:1007
end -- ./compiler/lua54.lpt:1007
end -- ./compiler/lua54.lpt:1007
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.lpt:1010
end -- ./compiler/lua54.lpt:1010
return r -- ./compiler/lua54.lpt:1012
end, -- ./compiler/lua54.lpt:1012
["AttributeId"] = function(t) -- ./compiler/lua54.lpt:1015
if t[2] then -- ./compiler/lua54.lpt:1016
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.lpt:1017
else -- ./compiler/lua54.lpt:1017
return t[1] -- ./compiler/lua54.lpt:1019
end -- ./compiler/lua54.lpt:1019
end, -- ./compiler/lua54.lpt:1019
["DestructuringId"] = function(t) -- ./compiler/lua54.lpt:1023
if t["id"] then -- ./compiler/lua54.lpt:1024
return t["id"] -- ./compiler/lua54.lpt:1025
else -- ./compiler/lua54.lpt:1025
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.lpt:1027
local vars = { ["id"] = tmp() } -- ./compiler/lua54.lpt:1028
for j = 1, # t, 1 do -- ./compiler/lua54.lpt:1029
table["insert"](vars, t[j]) -- ./compiler/lua54.lpt:1030
end -- ./compiler/lua54.lpt:1030
table["insert"](d, vars) -- ./compiler/lua54.lpt:1032
t["id"] = vars["id"] -- ./compiler/lua54.lpt:1033
return vars["id"] -- ./compiler/lua54.lpt:1034
end -- ./compiler/lua54.lpt:1034
end, -- ./compiler/lua54.lpt:1034
["Index"] = function(t) -- ./compiler/lua54.lpt:1038
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:1039
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:1040
else -- ./compiler/lua54.lpt:1040
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:1042
end -- ./compiler/lua54.lpt:1042
end, -- ./compiler/lua54.lpt:1042
["SafeIndex"] = function(t) -- ./compiler/lua54.lpt:1046
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:1047
local l = {} -- ./compiler/lua54.lpt:1048
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.lpt:1049
table["insert"](l, 1, t) -- ./compiler/lua54.lpt:1050
t = t[1] -- ./compiler/lua54.lpt:1051
end -- ./compiler/lua54.lpt:1051
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.lpt:1053
for _, e in ipairs(l) do -- ./compiler/lua54.lpt:1054
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.lpt:1055
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.lpt:1056
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.lpt:1057
else -- ./compiler/lua54.lpt:1057
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.lpt:1059
end -- ./compiler/lua54.lpt:1059
end -- ./compiler/lua54.lpt:1059
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.lpt:1062
return r -- ./compiler/lua54.lpt:1063
else -- ./compiler/lua54.lpt:1063
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.lpt:1065
end -- ./compiler/lua54.lpt:1065
end, -- ./compiler/lua54.lpt:1065
["_opid"] = { -- ./compiler/lua54.lpt:1071
["add"] = "+", -- ./compiler/lua54.lpt:1073
["sub"] = "-", -- ./compiler/lua54.lpt:1073
["mul"] = "*", -- ./compiler/lua54.lpt:1073
["div"] = "/", -- ./compiler/lua54.lpt:1073
["idiv"] = "//", -- ./compiler/lua54.lpt:1074
["mod"] = "%", -- ./compiler/lua54.lpt:1074
["pow"] = "^", -- ./compiler/lua54.lpt:1074
["concat"] = "..", -- ./compiler/lua54.lpt:1074
["band"] = "&", -- ./compiler/lua54.lpt:1075
["bor"] = "|", -- ./compiler/lua54.lpt:1075
["bxor"] = "~", -- ./compiler/lua54.lpt:1075
["shl"] = "<<", -- ./compiler/lua54.lpt:1075
["shr"] = ">>", -- ./compiler/lua54.lpt:1075
["eq"] = "==", -- ./compiler/lua54.lpt:1076
["ne"] = "~=", -- ./compiler/lua54.lpt:1076
["lt"] = "<", -- ./compiler/lua54.lpt:1076
["gt"] = ">", -- ./compiler/lua54.lpt:1076
["le"] = "<=", -- ./compiler/lua54.lpt:1076
["ge"] = ">=", -- ./compiler/lua54.lpt:1076
["and"] = "and", -- ./compiler/lua54.lpt:1077
["or"] = "or", -- ./compiler/lua54.lpt:1077
["unm"] = "-", -- ./compiler/lua54.lpt:1077
["len"] = "#", -- ./compiler/lua54.lpt:1077
["bnot"] = "~", -- ./compiler/lua54.lpt:1077
["not"] = "not", -- ./compiler/lua54.lpt:1077
["divb"] = function(left, right) -- ./compiler/lua54.lpt:1081
return table["concat"]({ -- ./compiler/lua54.lpt:1082
"((", -- ./compiler/lua54.lpt:1082
lua(left), -- ./compiler/lua54.lpt:1082
") % (", -- ./compiler/lua54.lpt:1082
lua(right), -- ./compiler/lua54.lpt:1082
") == 0)" -- ./compiler/lua54.lpt:1082
}) -- ./compiler/lua54.lpt:1082
end, -- ./compiler/lua54.lpt:1082
["ndivb"] = function(left, right) -- ./compiler/lua54.lpt:1085
return table["concat"]({ -- ./compiler/lua54.lpt:1086
"((", -- ./compiler/lua54.lpt:1086
lua(left), -- ./compiler/lua54.lpt:1086
") % (", -- ./compiler/lua54.lpt:1086
lua(right), -- ./compiler/lua54.lpt:1086
") ~= 0)" -- ./compiler/lua54.lpt:1086
}) -- ./compiler/lua54.lpt:1086
end, -- ./compiler/lua54.lpt:1086
["tconcat"] = function(left, right) -- ./compiler/lua54.lpt:1091
if right["tag"] == "Table" then -- ./compiler/lua54.lpt:1092
local sep = right[1] -- ./compiler/lua54.lpt:1093
local i = right[2] -- ./compiler/lua54.lpt:1094
local j = right[3] -- ./compiler/lua54.lpt:1095
local r = { -- ./compiler/lua54.lpt:1097
"table.concat(", -- ./compiler/lua54.lpt:1097
lua(left) -- ./compiler/lua54.lpt:1097
} -- ./compiler/lua54.lpt:1097
if sep ~= nil then -- ./compiler/lua54.lpt:1099
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1100
r[# r + 1] = lua(sep) -- ./compiler/lua54.lpt:1101
end -- ./compiler/lua54.lpt:1101
if i ~= nil then -- ./compiler/lua54.lpt:1104
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1105
r[# r + 1] = lua(i) -- ./compiler/lua54.lpt:1106
end -- ./compiler/lua54.lpt:1106
if j ~= nil then -- ./compiler/lua54.lpt:1109
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1110
r[# r + 1] = lua(j) -- ./compiler/lua54.lpt:1111
end -- ./compiler/lua54.lpt:1111
r[# r + 1] = ")" -- ./compiler/lua54.lpt:1114
return table["concat"](r) -- ./compiler/lua54.lpt:1116
else -- ./compiler/lua54.lpt:1116
return table["concat"]({ -- ./compiler/lua54.lpt:1118
"table.concat(", -- ./compiler/lua54.lpt:1118
lua(left), -- ./compiler/lua54.lpt:1118
", ", -- ./compiler/lua54.lpt:1118
lua(right), -- ./compiler/lua54.lpt:1118
")" -- ./compiler/lua54.lpt:1118
}) -- ./compiler/lua54.lpt:1118
end -- ./compiler/lua54.lpt:1118
end, -- ./compiler/lua54.lpt:1118
["pipe"] = function(left, right) -- ./compiler/lua54.lpt:1124
return table["concat"]({ -- ./compiler/lua54.lpt:1125
"(", -- ./compiler/lua54.lpt:1125
lua(right), -- ./compiler/lua54.lpt:1125
")", -- ./compiler/lua54.lpt:1125
"(", -- ./compiler/lua54.lpt:1125
lua(left), -- ./compiler/lua54.lpt:1125
")" -- ./compiler/lua54.lpt:1125
}) -- ./compiler/lua54.lpt:1125
end, -- ./compiler/lua54.lpt:1125
["pipebc"] = function(left, right) -- ./compiler/lua54.lpt:1127
return table["concat"]({ BROADCAST({ -- ./compiler/lua54.lpt:1128
right, -- ./compiler/lua54.lpt:1128
left -- ./compiler/lua54.lpt:1128
}, false) }) -- ./compiler/lua54.lpt:1128
end, -- ./compiler/lua54.lpt:1128
["pipebckv"] = function(left, right) -- ./compiler/lua54.lpt:1130
return table["concat"]({ BROADCAST({ -- ./compiler/lua54.lpt:1131
right, -- ./compiler/lua54.lpt:1131
left -- ./compiler/lua54.lpt:1131
}, true) }) -- ./compiler/lua54.lpt:1131
end -- ./compiler/lua54.lpt:1131
} -- ./compiler/lua54.lpt:1131
}, { ["__index"] = function(self, key) -- ./compiler/lua54.lpt:1143
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.lpt:1144
end }) -- ./compiler/lua54.lpt:1144
targetName = "Lua 5.3" -- ./compiler/lua53.lpt:1
tags["AttributeId"] = function(t) -- ./compiler/lua53.lpt:4
if t[2] then -- ./compiler/lua53.lpt:5
error("target " .. targetName .. " does not support variable attributes") -- ./compiler/lua53.lpt:6
else -- ./compiler/lua53.lpt:6
return t[1] -- ./compiler/lua53.lpt:8
end -- ./compiler/lua53.lpt:8
end -- ./compiler/lua53.lpt:8
local code = lua(ast) .. newline() -- ./compiler/lua54.lpt:1151
return requireStr .. luaHeader .. code -- ./compiler/lua54.lpt:1152
end -- ./compiler/lua54.lpt:1152
end -- ./compiler/lua54.lpt:1152
local lua54 = _() or lua54 -- ./compiler/lua54.lpt:1157
return lua54 -- ./compiler/lua53.lpt:18
end -- ./compiler/lua53.lpt:18
local lua53 = _() or lua53 -- ./compiler/lua53.lpt:22
package["loaded"]["compiler.lua53"] = lua53 or true -- ./compiler/lua53.lpt:23
local function _() -- ./compiler/lua53.lpt:26
local function _() -- ./compiler/lua53.lpt:28
local function _() -- ./compiler/lua53.lpt:30
local util = require("lepton.util") -- ./compiler/lua54.lpt:1
local targetName = "Lua 5.4" -- ./compiler/lua54.lpt:3
local unpack = unpack or table["unpack"] -- ./compiler/lua54.lpt:5
return function(code, ast, options, macros) -- ./compiler/lua54.lpt:7
if macros == nil then macros = { -- ./compiler/lua54.lpt:7
["functions"] = {}, -- ./compiler/lua54.lpt:7
["variables"] = {} -- ./compiler/lua54.lpt:7
} end -- ./compiler/lua54.lpt:7
local lastInputPos = 1 -- ./compiler/lua54.lpt:9
local prevLinePos = 1 -- ./compiler/lua54.lpt:10
local lastSource = options["chunkname"] or "nil" -- ./compiler/lua54.lpt:11
local lastLine = 1 -- ./compiler/lua54.lpt:12
local indentLevel = 0 -- ./compiler/lua54.lpt:16
local function newline() -- ./compiler/lua54.lpt:18
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.lpt:19
if options["mapLines"] then -- ./compiler/lua54.lpt:20
local sub = code:sub(lastInputPos) -- ./compiler/lua54.lpt:21
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.lpt:22
if source and line then -- ./compiler/lua54.lpt:24
lastSource = source -- ./compiler/lua54.lpt:25
lastLine = tonumber(line) -- ./compiler/lua54.lpt:26
else -- ./compiler/lua54.lpt:26
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.lpt:28
lastLine = lastLine + (1) -- ./compiler/lua54.lpt:29
end -- ./compiler/lua54.lpt:29
end -- ./compiler/lua54.lpt:29
prevLinePos = lastInputPos -- ./compiler/lua54.lpt:33
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.lpt:35
end -- ./compiler/lua54.lpt:35
return r -- ./compiler/lua54.lpt:37
end -- ./compiler/lua54.lpt:37
local function indent() -- ./compiler/lua54.lpt:40
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:41
return newline() -- ./compiler/lua54.lpt:42
end -- ./compiler/lua54.lpt:42
local function unindent() -- ./compiler/lua54.lpt:45
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:46
return newline() -- ./compiler/lua54.lpt:47
end -- ./compiler/lua54.lpt:47
local states = { -- ./compiler/lua54.lpt:53
["push"] = {}, -- ./compiler/lua54.lpt:54
["destructuring"] = {}, -- ./compiler/lua54.lpt:55
["scope"] = {}, -- ./compiler/lua54.lpt:56
["macroargs"] = {} -- ./compiler/lua54.lpt:57
} -- ./compiler/lua54.lpt:57
local function push(name, state) -- ./compiler/lua54.lpt:60
states[name][# states[name] + 1] = state -- ./compiler/lua54.lpt:61
return "" -- ./compiler/lua54.lpt:62
end -- ./compiler/lua54.lpt:62
local function pop(name) -- ./compiler/lua54.lpt:65
table["remove"](states[name]) -- ./compiler/lua54.lpt:66
return "" -- ./compiler/lua54.lpt:67
end -- ./compiler/lua54.lpt:67
local function set(name, state) -- ./compiler/lua54.lpt:70
states[name][# states[name]] = state -- ./compiler/lua54.lpt:71
return "" -- ./compiler/lua54.lpt:72
end -- ./compiler/lua54.lpt:72
local function peek(name) -- ./compiler/lua54.lpt:75
return states[name][# states[name]] -- ./compiler/lua54.lpt:76
end -- ./compiler/lua54.lpt:76
local function var(name) -- ./compiler/lua54.lpt:82
return options["variablePrefix"] .. name -- ./compiler/lua54.lpt:83
end -- ./compiler/lua54.lpt:83
local function tmp() -- ./compiler/lua54.lpt:87
local scope = peek("scope") -- ./compiler/lua54.lpt:88
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.lpt:89
table["insert"](scope, var) -- ./compiler/lua54.lpt:90
return var -- ./compiler/lua54.lpt:91
end -- ./compiler/lua54.lpt:91
local nomacro = { -- ./compiler/lua54.lpt:95
["variables"] = {}, -- ./compiler/lua54.lpt:95
["functions"] = {} -- ./compiler/lua54.lpt:95
} -- ./compiler/lua54.lpt:95
local luaHeader = "" -- ./compiler/lua54.lpt:98
local function addLua(code) -- ./compiler/lua54.lpt:99
luaHeader = luaHeader .. (code) -- ./compiler/lua54.lpt:100
end -- ./compiler/lua54.lpt:100
local libraries = {} -- ./compiler/lua54.lpt:105
local function addBroadcast() -- ./compiler/lua54.lpt:107
if libraries["broadcast"] then -- ./compiler/lua54.lpt:108
return  -- ./compiler/lua54.lpt:108
end -- ./compiler/lua54.lpt:108
addLua((" -- ./compiler/lua54.lpt:110\
local function %sbroadcast(func, t) -- ./compiler/lua54.lpt:111\
    local new = {} -- ./compiler/lua54.lpt:112\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:113\
        local r1, r2 = func(v) -- ./compiler/lua54.lpt:114\
        if r2 == nil then -- ./compiler/lua54.lpt:115\
            new[k] = r1 -- ./compiler/lua54.lpt:116\
        else -- ./compiler/lua54.lpt:117\
            new[r1] = r2 -- ./compiler/lua54.lpt:118\
        end -- ./compiler/lua54.lpt:119\
    end -- ./compiler/lua54.lpt:120\
    if next(new) ~= nil then -- ./compiler/lua54.lpt:121\
        return new -- ./compiler/lua54.lpt:122\
    end -- ./compiler/lua54.lpt:123\
end -- ./compiler/lua54.lpt:124\
"):format(options["variablePrefix"], options["variablePrefix"])) -- ./compiler/lua54.lpt:125
libraries["broadcast"] = true -- ./compiler/lua54.lpt:127
end -- ./compiler/lua54.lpt:127
local function addBroadcastKV() -- ./compiler/lua54.lpt:130
if libraries["broadcastKV"] then -- ./compiler/lua54.lpt:131
return  -- ./compiler/lua54.lpt:131
end -- ./compiler/lua54.lpt:131
addLua((" -- ./compiler/lua54.lpt:133\
local function %sbroadcast_kv(func, t) -- ./compiler/lua54.lpt:134\
    local new = {} -- ./compiler/lua54.lpt:135\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:136\
        local r1, r2 = func(k, v) -- ./compiler/lua54.lpt:137\
        if r2 == nil then -- ./compiler/lua54.lpt:138\
            new[k] = r1 -- ./compiler/lua54.lpt:139\
        else -- ./compiler/lua54.lpt:140\
            new[r1] = r2 -- ./compiler/lua54.lpt:141\
        end -- ./compiler/lua54.lpt:142\
    end -- ./compiler/lua54.lpt:143\
    if next(new) ~= nil then -- ./compiler/lua54.lpt:144\
        return new -- ./compiler/lua54.lpt:145\
    end -- ./compiler/lua54.lpt:146\
end -- ./compiler/lua54.lpt:147\
"):format(options["variablePrefix"], options["variablePrefix"])) -- ./compiler/lua54.lpt:148
libraries["broadcastKV"] = true -- ./compiler/lua54.lpt:150
end -- ./compiler/lua54.lpt:150
local function addFilter() -- ./compiler/lua54.lpt:153
if libraries["filter"] then -- ./compiler/lua54.lpt:154
return  -- ./compiler/lua54.lpt:154
end -- ./compiler/lua54.lpt:154
addLua((" -- ./compiler/lua54.lpt:156\
local function %sfilter(predicate, t) -- ./compiler/lua54.lpt:157\
    local new = {} -- ./compiler/lua54.lpt:158\
    local i = 1 -- ./compiler/lua54.lpt:159\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:160\
        if predicate(v) then -- ./compiler/lua54.lpt:161\
            if type(k) == 'number' then -- ./compiler/lua54.lpt:162\
                new[i] = v -- ./compiler/lua54.lpt:163\
                i = i + 1 -- ./compiler/lua54.lpt:164\
            else -- ./compiler/lua54.lpt:165\
                new[k] = v -- ./compiler/lua54.lpt:166\
            end -- ./compiler/lua54.lpt:167\
        end -- ./compiler/lua54.lpt:168\
    end -- ./compiler/lua54.lpt:169\
    return new -- ./compiler/lua54.lpt:170\
end -- ./compiler/lua54.lpt:171\
"):format(options["variablePrefix"])) -- ./compiler/lua54.lpt:172
libraries["filter"] = true -- ./compiler/lua54.lpt:174
end -- ./compiler/lua54.lpt:174
local function addFilterKV() -- ./compiler/lua54.lpt:177
if libraries["filterKV"] then -- ./compiler/lua54.lpt:178
return  -- ./compiler/lua54.lpt:178
end -- ./compiler/lua54.lpt:178
addLua((" -- ./compiler/lua54.lpt:180\
local function %sfilter_kv(predicate, t) -- ./compiler/lua54.lpt:181\
    local new = {} -- ./compiler/lua54.lpt:182\
    local i = 1 -- ./compiler/lua54.lpt:183\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:184\
        if predicate(k, v) then -- ./compiler/lua54.lpt:185\
            if type(k) == 'number' then -- ./compiler/lua54.lpt:186\
                new[i] = v -- ./compiler/lua54.lpt:187\
                i = i + 1 -- ./compiler/lua54.lpt:188\
            else -- ./compiler/lua54.lpt:189\
                new[k] = v -- ./compiler/lua54.lpt:190\
            end -- ./compiler/lua54.lpt:191\
        end -- ./compiler/lua54.lpt:192\
    end -- ./compiler/lua54.lpt:193\
    return new -- ./compiler/lua54.lpt:194\
end -- ./compiler/lua54.lpt:195\
"):format(options["variablePrefix"])) -- ./compiler/lua54.lpt:196
libraries["filterKV"] = true -- ./compiler/lua54.lpt:198
end -- ./compiler/lua54.lpt:198
local required = {} -- ./compiler/lua54.lpt:203
local requireStr = "" -- ./compiler/lua54.lpt:204
local function addRequire(mod, name, field) -- ./compiler/lua54.lpt:206
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.lpt:207
if not required[req] then -- ./compiler/lua54.lpt:208
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.lpt:209
required[req] = true -- ./compiler/lua54.lpt:210
end -- ./compiler/lua54.lpt:210
end -- ./compiler/lua54.lpt:210
local loop = { -- ./compiler/lua54.lpt:216
"While", -- ./compiler/lua54.lpt:216
"Repeat", -- ./compiler/lua54.lpt:216
"Fornum", -- ./compiler/lua54.lpt:216
"Forin", -- ./compiler/lua54.lpt:216
"WhileExpr", -- ./compiler/lua54.lpt:216
"RepeatExpr", -- ./compiler/lua54.lpt:216
"FornumExpr", -- ./compiler/lua54.lpt:216
"ForinExpr" -- ./compiler/lua54.lpt:216
} -- ./compiler/lua54.lpt:216
local func = { -- ./compiler/lua54.lpt:217
"Function", -- ./compiler/lua54.lpt:217
"TableCompr", -- ./compiler/lua54.lpt:217
"DoExpr", -- ./compiler/lua54.lpt:217
"WhileExpr", -- ./compiler/lua54.lpt:217
"RepeatExpr", -- ./compiler/lua54.lpt:217
"IfExpr", -- ./compiler/lua54.lpt:217
"FornumExpr", -- ./compiler/lua54.lpt:217
"ForinExpr" -- ./compiler/lua54.lpt:217
} -- ./compiler/lua54.lpt:217
local function any(list, tags, nofollow) -- ./compiler/lua54.lpt:221
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:221
local tagsCheck = {} -- ./compiler/lua54.lpt:222
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:223
tagsCheck[tag] = true -- ./compiler/lua54.lpt:224
end -- ./compiler/lua54.lpt:224
local nofollowCheck = {} -- ./compiler/lua54.lpt:226
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:227
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:228
end -- ./compiler/lua54.lpt:228
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:230
if type(node) == "table" then -- ./compiler/lua54.lpt:231
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:232
return node -- ./compiler/lua54.lpt:233
end -- ./compiler/lua54.lpt:233
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:235
local r = any(node, tags, nofollow) -- ./compiler/lua54.lpt:236
if r then -- ./compiler/lua54.lpt:237
return r -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
return nil -- ./compiler/lua54.lpt:241
end -- ./compiler/lua54.lpt:241
local function search(list, tags, nofollow) -- ./compiler/lua54.lpt:246
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:246
local tagsCheck = {} -- ./compiler/lua54.lpt:247
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:248
tagsCheck[tag] = true -- ./compiler/lua54.lpt:249
end -- ./compiler/lua54.lpt:249
local nofollowCheck = {} -- ./compiler/lua54.lpt:251
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:252
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:253
end -- ./compiler/lua54.lpt:253
local found = {} -- ./compiler/lua54.lpt:255
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:256
if type(node) == "table" then -- ./compiler/lua54.lpt:257
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:258
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.lpt:259
table["insert"](found, n) -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:263
table["insert"](found, node) -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
return found -- ./compiler/lua54.lpt:268
end -- ./compiler/lua54.lpt:268
local function all(list, tags) -- ./compiler/lua54.lpt:272
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:273
local ok = false -- ./compiler/lua54.lpt:274
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:275
if node["tag"] == tag then -- ./compiler/lua54.lpt:276
ok = true -- ./compiler/lua54.lpt:277
break -- ./compiler/lua54.lpt:278
end -- ./compiler/lua54.lpt:278
end -- ./compiler/lua54.lpt:278
if not ok then -- ./compiler/lua54.lpt:281
return false -- ./compiler/lua54.lpt:282
end -- ./compiler/lua54.lpt:282
end -- ./compiler/lua54.lpt:282
return true -- ./compiler/lua54.lpt:285
end -- ./compiler/lua54.lpt:285
local tags -- ./compiler/lua54.lpt:290
local function lua(ast, forceTag, ...) -- ./compiler/lua54.lpt:292
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.lpt:293
lastInputPos = ast["pos"] -- ./compiler/lua54.lpt:294
end -- ./compiler/lua54.lpt:294
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.lpt:296
end -- ./compiler/lua54.lpt:296
local UNPACK = function(list, i, j) -- ./compiler/lua54.lpt:301
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.lpt:302
end -- ./compiler/lua54.lpt:302
local APPEND = function(t, toAppend) -- ./compiler/lua54.lpt:304
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.lpt:305
end -- ./compiler/lua54.lpt:305
local CONTINUE_START = function() -- ./compiler/lua54.lpt:307
return "do" .. indent() -- ./compiler/lua54.lpt:308
end -- ./compiler/lua54.lpt:308
local CONTINUE_STOP = function() -- ./compiler/lua54.lpt:310
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.lpt:311
end -- ./compiler/lua54.lpt:311
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.lpt:314
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.lpt:314
if noLocal == nil then noLocal = false end -- ./compiler/lua54.lpt:314
local vars = {} -- ./compiler/lua54.lpt:315
local values = {} -- ./compiler/lua54.lpt:316
for _, list in ipairs(destructured) do -- ./compiler/lua54.lpt:317
for _, v in ipairs(list) do -- ./compiler/lua54.lpt:318
local var, val -- ./compiler/lua54.lpt:319
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.lpt:320
var = v -- ./compiler/lua54.lpt:321
val = { -- ./compiler/lua54.lpt:322
["tag"] = "Index", -- ./compiler/lua54.lpt:322
{ -- ./compiler/lua54.lpt:322
["tag"] = "Id", -- ./compiler/lua54.lpt:322
list["id"] -- ./compiler/lua54.lpt:322
}, -- ./compiler/lua54.lpt:322
{ -- ./compiler/lua54.lpt:322
["tag"] = "String", -- ./compiler/lua54.lpt:322
v[1] -- ./compiler/lua54.lpt:322
} -- ./compiler/lua54.lpt:322
} -- ./compiler/lua54.lpt:322
elseif v["tag"] == "Pair" then -- ./compiler/lua54.lpt:323
var = v[2] -- ./compiler/lua54.lpt:324
val = { -- ./compiler/lua54.lpt:325
["tag"] = "Index", -- ./compiler/lua54.lpt:325
{ -- ./compiler/lua54.lpt:325
["tag"] = "Id", -- ./compiler/lua54.lpt:325
list["id"] -- ./compiler/lua54.lpt:325
}, -- ./compiler/lua54.lpt:325
v[1] -- ./compiler/lua54.lpt:325
} -- ./compiler/lua54.lpt:325
else -- ./compiler/lua54.lpt:325
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.lpt:327
end -- ./compiler/lua54.lpt:327
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.lpt:329
val = { -- ./compiler/lua54.lpt:330
["tag"] = "Op", -- ./compiler/lua54.lpt:330
destructured["rightOp"], -- ./compiler/lua54.lpt:330
var, -- ./compiler/lua54.lpt:330
{ -- ./compiler/lua54.lpt:330
["tag"] = "Op", -- ./compiler/lua54.lpt:330
destructured["leftOp"], -- ./compiler/lua54.lpt:330
val, -- ./compiler/lua54.lpt:330
var -- ./compiler/lua54.lpt:330
} -- ./compiler/lua54.lpt:330
} -- ./compiler/lua54.lpt:330
elseif destructured["rightOp"] then -- ./compiler/lua54.lpt:331
val = { -- ./compiler/lua54.lpt:332
["tag"] = "Op", -- ./compiler/lua54.lpt:332
destructured["rightOp"], -- ./compiler/lua54.lpt:332
var, -- ./compiler/lua54.lpt:332
val -- ./compiler/lua54.lpt:332
} -- ./compiler/lua54.lpt:332
elseif destructured["leftOp"] then -- ./compiler/lua54.lpt:333
val = { -- ./compiler/lua54.lpt:334
["tag"] = "Op", -- ./compiler/lua54.lpt:334
destructured["leftOp"], -- ./compiler/lua54.lpt:334
val, -- ./compiler/lua54.lpt:334
var -- ./compiler/lua54.lpt:334
} -- ./compiler/lua54.lpt:334
end -- ./compiler/lua54.lpt:334
table["insert"](vars, lua(var)) -- ./compiler/lua54.lpt:336
table["insert"](values, lua(val)) -- ./compiler/lua54.lpt:337
end -- ./compiler/lua54.lpt:337
end -- ./compiler/lua54.lpt:337
if # vars > 0 then -- ./compiler/lua54.lpt:340
local decl = noLocal and "" or "local " -- ./compiler/lua54.lpt:341
if newlineAfter then -- ./compiler/lua54.lpt:342
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.lpt:343
else -- ./compiler/lua54.lpt:343
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.lpt:345
end -- ./compiler/lua54.lpt:345
else -- ./compiler/lua54.lpt:345
return "" -- ./compiler/lua54.lpt:348
end -- ./compiler/lua54.lpt:348
end -- ./compiler/lua54.lpt:348
local BROADCAST = function(t, use_kv) -- ./compiler/lua54.lpt:352
((use_kv and addBroadcastKV) or addBroadcast)() -- ./compiler/lua54.lpt:353
return table["concat"]({ -- ./compiler/lua54.lpt:354
options["variablePrefix"], -- ./compiler/lua54.lpt:354
(use_kv and "broadcast_kv(") or "broadcast(", -- ./compiler/lua54.lpt:354
lua(t[1]), -- ./compiler/lua54.lpt:354
",", -- ./compiler/lua54.lpt:354
lua(t[2]), -- ./compiler/lua54.lpt:354
")" -- ./compiler/lua54.lpt:354
}) -- ./compiler/lua54.lpt:354
end -- ./compiler/lua54.lpt:354
local FILTER = function(t, use_kv) -- ./compiler/lua54.lpt:356
((use_kv and addFilterKV) or addFilter)() -- ./compiler/lua54.lpt:357
return table["concat"]({ -- ./compiler/lua54.lpt:358
options["variablePrefix"], -- ./compiler/lua54.lpt:358
(use_kv and "filter_kv(") or "filter(", -- ./compiler/lua54.lpt:358
lua(t[1]), -- ./compiler/lua54.lpt:358
",", -- ./compiler/lua54.lpt:358
lua(t[2]), -- ./compiler/lua54.lpt:358
")" -- ./compiler/lua54.lpt:358
}) -- ./compiler/lua54.lpt:358
end -- ./compiler/lua54.lpt:358
tags = setmetatable({ -- ./compiler/lua54.lpt:363
["Block"] = function(t) -- ./compiler/lua54.lpt:366
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.lpt:367
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.lpt:368
hasPush["tag"] = "Return" -- ./compiler/lua54.lpt:369
hasPush = false -- ./compiler/lua54.lpt:370
end -- ./compiler/lua54.lpt:370
local r = push("scope", {}) -- ./compiler/lua54.lpt:372
if hasPush then -- ./compiler/lua54.lpt:373
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:374
end -- ./compiler/lua54.lpt:374
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:376
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:377
end -- ./compiler/lua54.lpt:377
if t[# t] then -- ./compiler/lua54.lpt:379
r = r .. (lua(t[# t])) -- ./compiler/lua54.lpt:380
end -- ./compiler/lua54.lpt:380
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:382
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.lpt:383
end -- ./compiler/lua54.lpt:383
return r .. pop("scope") -- ./compiler/lua54.lpt:385
end, -- ./compiler/lua54.lpt:385
["Do"] = function(t) -- ./compiler/lua54.lpt:391
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.lpt:392
end, -- ./compiler/lua54.lpt:392
["Set"] = function(t) -- ./compiler/lua54.lpt:395
local expr = t[# t] -- ./compiler/lua54.lpt:397
local vars, values = {}, {} -- ./compiler/lua54.lpt:398
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.lpt:399
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:400
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.lpt:401
table["insert"](destructuringVars, n) -- ./compiler/lua54.lpt:402
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.lpt:403
else -- ./compiler/lua54.lpt:403
table["insert"](vars, n) -- ./compiler/lua54.lpt:405
table["insert"](values, expr[i]) -- ./compiler/lua54.lpt:406
end -- ./compiler/lua54.lpt:406
end -- ./compiler/lua54.lpt:406
if # t == 2 or # t == 3 then -- ./compiler/lua54.lpt:410
local r = "" -- ./compiler/lua54.lpt:411
if # vars > 0 then -- ./compiler/lua54.lpt:412
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.lpt:413
end -- ./compiler/lua54.lpt:413
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:415
local destructured = {} -- ./compiler/lua54.lpt:416
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:417
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:418
end -- ./compiler/lua54.lpt:418
return r -- ./compiler/lua54.lpt:420
elseif # t == 4 then -- ./compiler/lua54.lpt:421
if t[3] == "=" then -- ./compiler/lua54.lpt:422
local r = "" -- ./compiler/lua54.lpt:423
if # vars > 0 then -- ./compiler/lua54.lpt:424
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:425
t[2], -- ./compiler/lua54.lpt:425
vars[1], -- ./compiler/lua54.lpt:425
{ -- ./compiler/lua54.lpt:425
["tag"] = "Paren", -- ./compiler/lua54.lpt:425
values[1] -- ./compiler/lua54.lpt:425
} -- ./compiler/lua54.lpt:425
}, "Op")) -- ./compiler/lua54.lpt:425
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.lpt:426
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:427
t[2], -- ./compiler/lua54.lpt:427
vars[i], -- ./compiler/lua54.lpt:427
{ -- ./compiler/lua54.lpt:427
["tag"] = "Paren", -- ./compiler/lua54.lpt:427
values[i] -- ./compiler/lua54.lpt:427
} -- ./compiler/lua54.lpt:427
}, "Op")) -- ./compiler/lua54.lpt:427
end -- ./compiler/lua54.lpt:427
end -- ./compiler/lua54.lpt:427
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:430
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.lpt:431
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:432
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:433
end -- ./compiler/lua54.lpt:433
return r -- ./compiler/lua54.lpt:435
else -- ./compiler/lua54.lpt:435
local r = "" -- ./compiler/lua54.lpt:437
if # vars > 0 then -- ./compiler/lua54.lpt:438
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:439
t[3], -- ./compiler/lua54.lpt:439
{ -- ./compiler/lua54.lpt:439
["tag"] = "Paren", -- ./compiler/lua54.lpt:439
values[1] -- ./compiler/lua54.lpt:439
}, -- ./compiler/lua54.lpt:439
vars[1] -- ./compiler/lua54.lpt:439
}, "Op")) -- ./compiler/lua54.lpt:439
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.lpt:440
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:441
t[3], -- ./compiler/lua54.lpt:441
{ -- ./compiler/lua54.lpt:441
["tag"] = "Paren", -- ./compiler/lua54.lpt:441
values[i] -- ./compiler/lua54.lpt:441
}, -- ./compiler/lua54.lpt:441
vars[i] -- ./compiler/lua54.lpt:441
}, "Op")) -- ./compiler/lua54.lpt:441
end -- ./compiler/lua54.lpt:441
end -- ./compiler/lua54.lpt:441
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:444
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.lpt:445
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:446
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:447
end -- ./compiler/lua54.lpt:447
return r -- ./compiler/lua54.lpt:449
end -- ./compiler/lua54.lpt:449
else -- ./compiler/lua54.lpt:449
local r = "" -- ./compiler/lua54.lpt:452
if # vars > 0 then -- ./compiler/lua54.lpt:453
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:454
t[2], -- ./compiler/lua54.lpt:454
vars[1], -- ./compiler/lua54.lpt:454
{ -- ./compiler/lua54.lpt:454
["tag"] = "Op", -- ./compiler/lua54.lpt:454
t[4], -- ./compiler/lua54.lpt:454
{ -- ./compiler/lua54.lpt:454
["tag"] = "Paren", -- ./compiler/lua54.lpt:454
values[1] -- ./compiler/lua54.lpt:454
}, -- ./compiler/lua54.lpt:454
vars[1] -- ./compiler/lua54.lpt:454
} -- ./compiler/lua54.lpt:454
}, "Op")) -- ./compiler/lua54.lpt:454
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.lpt:455
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:456
t[2], -- ./compiler/lua54.lpt:456
vars[i], -- ./compiler/lua54.lpt:456
{ -- ./compiler/lua54.lpt:456
["tag"] = "Op", -- ./compiler/lua54.lpt:456
t[4], -- ./compiler/lua54.lpt:456
{ -- ./compiler/lua54.lpt:456
["tag"] = "Paren", -- ./compiler/lua54.lpt:456
values[i] -- ./compiler/lua54.lpt:456
}, -- ./compiler/lua54.lpt:456
vars[i] -- ./compiler/lua54.lpt:456
} -- ./compiler/lua54.lpt:456
}, "Op")) -- ./compiler/lua54.lpt:456
end -- ./compiler/lua54.lpt:456
end -- ./compiler/lua54.lpt:456
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:459
local destructured = { -- ./compiler/lua54.lpt:460
["rightOp"] = t[2], -- ./compiler/lua54.lpt:460
["leftOp"] = t[4] -- ./compiler/lua54.lpt:460
} -- ./compiler/lua54.lpt:460
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:461
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:462
end -- ./compiler/lua54.lpt:462
return r -- ./compiler/lua54.lpt:464
end -- ./compiler/lua54.lpt:464
end, -- ./compiler/lua54.lpt:464
["AppendSet"] = function(t) -- ./compiler/lua54.lpt:468
local expr = t[# t] -- ./compiler/lua54.lpt:470
local r = {} -- ./compiler/lua54.lpt:471
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:472
local value = expr[i] -- ./compiler/lua54.lpt:473
if value == nil then -- ./compiler/lua54.lpt:474
break -- ./compiler/lua54.lpt:475
end -- ./compiler/lua54.lpt:475
local var = lua(n) -- ./compiler/lua54.lpt:478
r[i] = { -- ./compiler/lua54.lpt:479
var, -- ./compiler/lua54.lpt:479
"[#", -- ./compiler/lua54.lpt:479
var, -- ./compiler/lua54.lpt:479
"+1] = ", -- ./compiler/lua54.lpt:479
lua(value) -- ./compiler/lua54.lpt:479
} -- ./compiler/lua54.lpt:479
r[i] = table["concat"](r[i]) -- ./compiler/lua54.lpt:480
end -- ./compiler/lua54.lpt:480
return table["concat"](r, "; ") -- ./compiler/lua54.lpt:482
end, -- ./compiler/lua54.lpt:482
["While"] = function(t) -- ./compiler/lua54.lpt:485
local r = "" -- ./compiler/lua54.lpt:486
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.lpt:487
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:488
if # lets > 0 then -- ./compiler/lua54.lpt:489
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:490
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:491
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:492
end -- ./compiler/lua54.lpt:492
end -- ./compiler/lua54.lpt:492
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.lpt:495
if # lets > 0 then -- ./compiler/lua54.lpt:496
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:497
end -- ./compiler/lua54.lpt:497
if hasContinue then -- ./compiler/lua54.lpt:499
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:500
end -- ./compiler/lua54.lpt:500
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:502
if hasContinue then -- ./compiler/lua54.lpt:503
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:504
end -- ./compiler/lua54.lpt:504
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:506
if # lets > 0 then -- ./compiler/lua54.lpt:507
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:508
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.lpt:509
end -- ./compiler/lua54.lpt:509
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.lpt:511
end -- ./compiler/lua54.lpt:511
return r -- ./compiler/lua54.lpt:513
end, -- ./compiler/lua54.lpt:513
["Repeat"] = function(t) -- ./compiler/lua54.lpt:516
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.lpt:517
local r = "repeat" .. indent() -- ./compiler/lua54.lpt:518
if hasContinue then -- ./compiler/lua54.lpt:519
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:520
end -- ./compiler/lua54.lpt:520
r = r .. (lua(t[1])) -- ./compiler/lua54.lpt:522
if hasContinue then -- ./compiler/lua54.lpt:523
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.lpt:526
return r -- ./compiler/lua54.lpt:527
end, -- ./compiler/lua54.lpt:527
["If"] = function(t) -- ./compiler/lua54.lpt:530
local r = "" -- ./compiler/lua54.lpt:531
local toClose = 0 -- ./compiler/lua54.lpt:532
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:533
if # lets > 0 then -- ./compiler/lua54.lpt:534
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:535
toClose = toClose + (1) -- ./compiler/lua54.lpt:536
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:537
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:538
end -- ./compiler/lua54.lpt:538
end -- ./compiler/lua54.lpt:538
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.lpt:541
for i = 3, # t - 1, 2 do -- ./compiler/lua54.lpt:542
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.lpt:543
if # lets > 0 then -- ./compiler/lua54.lpt:544
r = r .. ("else" .. indent()) -- ./compiler/lua54.lpt:545
toClose = toClose + (1) -- ./compiler/lua54.lpt:546
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:547
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:548
end -- ./compiler/lua54.lpt:548
else -- ./compiler/lua54.lpt:548
r = r .. ("else") -- ./compiler/lua54.lpt:551
end -- ./compiler/lua54.lpt:551
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.lpt:553
end -- ./compiler/lua54.lpt:553
if # t % 2 == 1 then -- ./compiler/lua54.lpt:555
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.lpt:556
end -- ./compiler/lua54.lpt:556
r = r .. ("end") -- ./compiler/lua54.lpt:558
for i = 1, toClose do -- ./compiler/lua54.lpt:559
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:560
end -- ./compiler/lua54.lpt:560
return r -- ./compiler/lua54.lpt:562
end, -- ./compiler/lua54.lpt:562
["Fornum"] = function(t) -- ./compiler/lua54.lpt:565
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.lpt:566
if # t == 5 then -- ./compiler/lua54.lpt:567
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.lpt:568
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.lpt:569
if hasContinue then -- ./compiler/lua54.lpt:570
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:571
end -- ./compiler/lua54.lpt:571
r = r .. (lua(t[5])) -- ./compiler/lua54.lpt:573
if hasContinue then -- ./compiler/lua54.lpt:574
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:575
end -- ./compiler/lua54.lpt:575
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:577
else -- ./compiler/lua54.lpt:577
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.lpt:579
r = r .. (" do" .. indent()) -- ./compiler/lua54.lpt:580
if hasContinue then -- ./compiler/lua54.lpt:581
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:582
end -- ./compiler/lua54.lpt:582
r = r .. (lua(t[4])) -- ./compiler/lua54.lpt:584
if hasContinue then -- ./compiler/lua54.lpt:585
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:586
end -- ./compiler/lua54.lpt:586
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:588
end -- ./compiler/lua54.lpt:588
end, -- ./compiler/lua54.lpt:588
["Forin"] = function(t) -- ./compiler/lua54.lpt:592
local destructured = {} -- ./compiler/lua54.lpt:593
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.lpt:594
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.lpt:595
if hasContinue then -- ./compiler/lua54.lpt:596
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:597
end -- ./compiler/lua54.lpt:597
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.lpt:599
if hasContinue then -- ./compiler/lua54.lpt:600
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:601
end -- ./compiler/lua54.lpt:601
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:603
end, -- ./compiler/lua54.lpt:603
["Local"] = function(t) -- ./compiler/lua54.lpt:606
local destructured = {} -- ./compiler/lua54.lpt:607
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:608
if t[2][1] then -- ./compiler/lua54.lpt:609
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:610
end -- ./compiler/lua54.lpt:610
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:612
end, -- ./compiler/lua54.lpt:612
["Let"] = function(t) -- ./compiler/lua54.lpt:615
local destructured = {} -- ./compiler/lua54.lpt:616
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:617
local r = "local " .. nameList -- ./compiler/lua54.lpt:618
if t[2][1] then -- ./compiler/lua54.lpt:619
if all(t[2], { -- ./compiler/lua54.lpt:620
"Nil", -- ./compiler/lua54.lpt:620
"Dots", -- ./compiler/lua54.lpt:620
"Boolean", -- ./compiler/lua54.lpt:620
"Number", -- ./compiler/lua54.lpt:620
"String" -- ./compiler/lua54.lpt:620
}) then -- ./compiler/lua54.lpt:620
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:621
else -- ./compiler/lua54.lpt:621
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:623
end -- ./compiler/lua54.lpt:623
end -- ./compiler/lua54.lpt:623
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:626
end, -- ./compiler/lua54.lpt:626
["Localrec"] = function(t) -- ./compiler/lua54.lpt:629
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.lpt:630
end, -- ./compiler/lua54.lpt:630
["Goto"] = function(t) -- ./compiler/lua54.lpt:633
return "goto " .. lua(t, "Id") -- ./compiler/lua54.lpt:634
end, -- ./compiler/lua54.lpt:634
["Label"] = function(t) -- ./compiler/lua54.lpt:637
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.lpt:638
end, -- ./compiler/lua54.lpt:638
["Return"] = function(t) -- ./compiler/lua54.lpt:641
local push = peek("push") -- ./compiler/lua54.lpt:642
if push then -- ./compiler/lua54.lpt:643
local r = "" -- ./compiler/lua54.lpt:644
for _, val in ipairs(t) do -- ./compiler/lua54.lpt:645
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.lpt:646
end -- ./compiler/lua54.lpt:646
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.lpt:648
else -- ./compiler/lua54.lpt:648
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.lpt:650
end -- ./compiler/lua54.lpt:650
end, -- ./compiler/lua54.lpt:650
["Push"] = function(t) -- ./compiler/lua54.lpt:654
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.lpt:655
r = "" -- ./compiler/lua54.lpt:656
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:657
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:658
end -- ./compiler/lua54.lpt:658
if t[# t] then -- ./compiler/lua54.lpt:660
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.lpt:661
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.lpt:662
else -- ./compiler/lua54.lpt:662
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.lpt:664
end -- ./compiler/lua54.lpt:664
end -- ./compiler/lua54.lpt:664
return r -- ./compiler/lua54.lpt:667
end, -- ./compiler/lua54.lpt:667
["Break"] = function() -- ./compiler/lua54.lpt:670
return "break" -- ./compiler/lua54.lpt:671
end, -- ./compiler/lua54.lpt:671
["Continue"] = function() -- ./compiler/lua54.lpt:674
return "goto " .. var("continue") -- ./compiler/lua54.lpt:675
end, -- ./compiler/lua54.lpt:675
["Nil"] = function() -- ./compiler/lua54.lpt:682
return "nil" -- ./compiler/lua54.lpt:683
end, -- ./compiler/lua54.lpt:683
["Dots"] = function() -- ./compiler/lua54.lpt:686
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:687
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.lpt:688
nomacro["variables"]["..."] = true -- ./compiler/lua54.lpt:689
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.lpt:690
nomacro["variables"]["..."] = nil -- ./compiler/lua54.lpt:691
return r -- ./compiler/lua54.lpt:692
else -- ./compiler/lua54.lpt:692
return "..." -- ./compiler/lua54.lpt:694
end -- ./compiler/lua54.lpt:694
end, -- ./compiler/lua54.lpt:694
["Boolean"] = function(t) -- ./compiler/lua54.lpt:698
return tostring(t[1]) -- ./compiler/lua54.lpt:699
end, -- ./compiler/lua54.lpt:699
["Number"] = function(t) -- ./compiler/lua54.lpt:702
local n = tostring(t[1]):gsub("_", "") -- ./compiler/lua54.lpt:703
do -- ./compiler/lua54.lpt:705
local match -- ./compiler/lua54.lpt:705
match = n:match("^0b(.*)") -- ./compiler/lua54.lpt:705
if match then -- ./compiler/lua54.lpt:705
n = tostring(tonumber(match, 2)) -- ./compiler/lua54.lpt:706
end -- ./compiler/lua54.lpt:706
end -- ./compiler/lua54.lpt:706
return n -- ./compiler/lua54.lpt:708
end, -- ./compiler/lua54.lpt:708
["String"] = function(t) -- ./compiler/lua54.lpt:711
return ("%q"):format(t[1]) -- ./compiler/lua54.lpt:712
end, -- ./compiler/lua54.lpt:712
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.lpt:715
local r = "(" -- ./compiler/lua54.lpt:716
local decl = {} -- ./compiler/lua54.lpt:717
if t[1][1] then -- ./compiler/lua54.lpt:718
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:719
local id = lua(t[1][1][1]) -- ./compiler/lua54.lpt:720
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:721
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.lpt:722
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:723
r = r .. (id) -- ./compiler/lua54.lpt:724
else -- ./compiler/lua54.lpt:724
r = r .. (lua(t[1][1])) -- ./compiler/lua54.lpt:726
end -- ./compiler/lua54.lpt:726
for i = 2, # t[1], 1 do -- ./compiler/lua54.lpt:728
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:729
local id = lua(t[1][i][1]) -- ./compiler/lua54.lpt:730
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:731
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.lpt:732
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:733
r = r .. (", " .. id) -- ./compiler/lua54.lpt:734
else -- ./compiler/lua54.lpt:734
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
r = r .. (")" .. indent()) -- ./compiler/lua54.lpt:740
for _, d in ipairs(decl) do -- ./compiler/lua54.lpt:741
r = r .. (d .. newline()) -- ./compiler/lua54.lpt:742
end -- ./compiler/lua54.lpt:742
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.lpt:744
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.lpt:745
end -- ./compiler/lua54.lpt:745
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.lpt:747
if hasPush then -- ./compiler/lua54.lpt:748
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:749
else -- ./compiler/lua54.lpt:749
push("push", false) -- ./compiler/lua54.lpt:751
end -- ./compiler/lua54.lpt:751
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:753
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:754
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:755
end -- ./compiler/lua54.lpt:755
pop("push") -- ./compiler/lua54.lpt:757
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:758
end, -- ./compiler/lua54.lpt:758
["Function"] = function(t) -- ./compiler/lua54.lpt:760
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.lpt:761
end, -- ./compiler/lua54.lpt:761
["Pair"] = function(t) -- ./compiler/lua54.lpt:764
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.lpt:765
end, -- ./compiler/lua54.lpt:765
["Table"] = function(t) -- ./compiler/lua54.lpt:767
if # t == 0 then -- ./compiler/lua54.lpt:768
return "{}" -- ./compiler/lua54.lpt:769
elseif # t == 1 then -- ./compiler/lua54.lpt:770
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.lpt:771
else -- ./compiler/lua54.lpt:771
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.lpt:773
end -- ./compiler/lua54.lpt:773
end, -- ./compiler/lua54.lpt:773
["TableCompr"] = function(t) -- ./compiler/lua54.lpt:777
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.lpt:778
end, -- ./compiler/lua54.lpt:778
["Op"] = function(t) -- ./compiler/lua54.lpt:781
local r -- ./compiler/lua54.lpt:782
if # t == 2 then -- ./compiler/lua54.lpt:783
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:784
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.lpt:785
else -- ./compiler/lua54.lpt:785
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.lpt:787
end -- ./compiler/lua54.lpt:787
else -- ./compiler/lua54.lpt:787
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:790
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.lpt:791
else -- ./compiler/lua54.lpt:791
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.lpt:793
end -- ./compiler/lua54.lpt:793
end -- ./compiler/lua54.lpt:793
return r -- ./compiler/lua54.lpt:796
end, -- ./compiler/lua54.lpt:796
["Paren"] = function(t) -- ./compiler/lua54.lpt:799
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.lpt:800
end, -- ./compiler/lua54.lpt:800
["MethodStub"] = function(t) -- ./compiler/lua54.lpt:803
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:809
end, -- ./compiler/lua54.lpt:809
["SafeMethodStub"] = function(t) -- ./compiler/lua54.lpt:812
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:819
end, -- ./compiler/lua54.lpt:819
["LetExpr"] = function(t) -- ./compiler/lua54.lpt:826
return lua(t[1][1]) -- ./compiler/lua54.lpt:827
end, -- ./compiler/lua54.lpt:827
["_statexpr"] = function(t, stat) -- ./compiler/lua54.lpt:831
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.lpt:832
local r = "(function()" .. indent() -- ./compiler/lua54.lpt:833
if hasPush then -- ./compiler/lua54.lpt:834
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:835
else -- ./compiler/lua54.lpt:835
push("push", false) -- ./compiler/lua54.lpt:837
end -- ./compiler/lua54.lpt:837
r = r .. (lua(t, stat)) -- ./compiler/lua54.lpt:839
if hasPush then -- ./compiler/lua54.lpt:840
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:841
end -- ./compiler/lua54.lpt:841
pop("push") -- ./compiler/lua54.lpt:843
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.lpt:844
return r -- ./compiler/lua54.lpt:845
end, -- ./compiler/lua54.lpt:845
["DoExpr"] = function(t) -- ./compiler/lua54.lpt:848
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.lpt:849
t[# t]["tag"] = "Return" -- ./compiler/lua54.lpt:850
end -- ./compiler/lua54.lpt:850
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.lpt:852
end, -- ./compiler/lua54.lpt:852
["WhileExpr"] = function(t) -- ./compiler/lua54.lpt:855
return lua(t, "_statexpr", "While") -- ./compiler/lua54.lpt:856
end, -- ./compiler/lua54.lpt:856
["RepeatExpr"] = function(t) -- ./compiler/lua54.lpt:859
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.lpt:860
end, -- ./compiler/lua54.lpt:860
["IfExpr"] = function(t) -- ./compiler/lua54.lpt:863
for i = 2, # t do -- ./compiler/lua54.lpt:864
local block = t[i] -- ./compiler/lua54.lpt:865
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.lpt:866
block[# block]["tag"] = "Return" -- ./compiler/lua54.lpt:867
end -- ./compiler/lua54.lpt:867
end -- ./compiler/lua54.lpt:867
return lua(t, "_statexpr", "If") -- ./compiler/lua54.lpt:870
end, -- ./compiler/lua54.lpt:870
["FornumExpr"] = function(t) -- ./compiler/lua54.lpt:873
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.lpt:874
end, -- ./compiler/lua54.lpt:874
["ForinExpr"] = function(t) -- ./compiler/lua54.lpt:877
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.lpt:878
end, -- ./compiler/lua54.lpt:878
["Call"] = function(t) -- ./compiler/lua54.lpt:885
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:886
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:887
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.lpt:888
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.lpt:889
local replacement = macro["replacement"] -- ./compiler/lua54.lpt:890
local r -- ./compiler/lua54.lpt:891
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.lpt:892
if type(replacement) == "function" then -- ./compiler/lua54.lpt:893
local args = {} -- ./compiler/lua54.lpt:894
for i = 2, # t do -- ./compiler/lua54.lpt:895
table["insert"](args, lua(t[i])) -- ./compiler/lua54.lpt:896
end -- ./compiler/lua54.lpt:896
r = replacement(unpack(args)) -- ./compiler/lua54.lpt:898
else -- ./compiler/lua54.lpt:898
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.lpt:900
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.lpt:901
if arg["tag"] == "Dots" then -- ./compiler/lua54.lpt:902
macroargs["..."] = (function() -- ./compiler/lua54.lpt:903
local self = {} -- ./compiler/lua54.lpt:903
for j = i + 1, # t do -- ./compiler/lua54.lpt:903
self[#self+1] = t[j] -- ./compiler/lua54.lpt:903
end -- ./compiler/lua54.lpt:903
return self -- ./compiler/lua54.lpt:903
end)() -- ./compiler/lua54.lpt:903
elseif arg["tag"] == "Id" then -- ./compiler/lua54.lpt:904
if t[i + 1] == nil then -- ./compiler/lua54.lpt:905
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.lpt:906
end -- ./compiler/lua54.lpt:906
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.lpt:908
else -- ./compiler/lua54.lpt:908
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.lpt:910
end -- ./compiler/lua54.lpt:910
end -- ./compiler/lua54.lpt:910
push("macroargs", macroargs) -- ./compiler/lua54.lpt:913
r = lua(replacement) -- ./compiler/lua54.lpt:914
pop("macroargs") -- ./compiler/lua54.lpt:915
end -- ./compiler/lua54.lpt:915
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.lpt:917
return r -- ./compiler/lua54.lpt:918
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.lpt:919
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.lpt:920
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:921
else -- ./compiler/lua54.lpt:921
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:923
end -- ./compiler/lua54.lpt:923
else -- ./compiler/lua54.lpt:923
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:926
end -- ./compiler/lua54.lpt:926
end, -- ./compiler/lua54.lpt:926
["SafeCall"] = function(t) -- ./compiler/lua54.lpt:930
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:931
return lua(t, "SafeIndex") -- ./compiler/lua54.lpt:932
else -- ./compiler/lua54.lpt:932
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.lpt:934
end -- ./compiler/lua54.lpt:934
end, -- ./compiler/lua54.lpt:934
["Broadcast"] = function(t) -- ./compiler/lua54.lpt:940
return BROADCAST(t, false) -- ./compiler/lua54.lpt:941
end, -- ./compiler/lua54.lpt:941
["BroadcastKV"] = function(t) -- ./compiler/lua54.lpt:943
return BROADCAST(t, true) -- ./compiler/lua54.lpt:944
end, -- ./compiler/lua54.lpt:944
["Filter"] = function(t) -- ./compiler/lua54.lpt:946
return FILTER(t, false) -- ./compiler/lua54.lpt:947
end, -- ./compiler/lua54.lpt:947
["FilterKV"] = function(t) -- ./compiler/lua54.lpt:949
return FILTER(t, true) -- ./compiler/lua54.lpt:950
end, -- ./compiler/lua54.lpt:950
["StringFormat"] = function(t) -- ./compiler/lua54.lpt:955
local args = {} -- ./compiler/lua54.lpt:956
for i, v in ipairs(t[2]) do -- ./compiler/lua54.lpt:957
args[i] = lua(v) -- ./compiler/lua54.lpt:958
end -- ./compiler/lua54.lpt:958
local r = { -- ./compiler/lua54.lpt:960
"(", -- ./compiler/lua54.lpt:960
"string.format(", -- ./compiler/lua54.lpt:960
("%q"):format(t[1]) -- ./compiler/lua54.lpt:960
} -- ./compiler/lua54.lpt:960
if # args ~= 0 then -- ./compiler/lua54.lpt:961
r[# r + 1] = ", " -- ./compiler/lua54.lpt:962
r[# r + 1] = table["concat"](args, ", ") -- ./compiler/lua54.lpt:963
r[# r + 1] = "))" -- ./compiler/lua54.lpt:964
end -- ./compiler/lua54.lpt:964
return table["concat"](r) -- ./compiler/lua54.lpt:966
end, -- ./compiler/lua54.lpt:966
["TableUnpack"] = function(t) -- ./compiler/lua54.lpt:971
local args = {} -- ./compiler/lua54.lpt:972
for i, v in ipairs(t[2]) do -- ./compiler/lua54.lpt:973
args[i] = lua(v) -- ./compiler/lua54.lpt:974
end -- ./compiler/lua54.lpt:974
return UNPACK(lua(t[1]), args[1], args[2]) -- ./compiler/lua54.lpt:976
end, -- ./compiler/lua54.lpt:976
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.lpt:982
if start == nil then start = 1 end -- ./compiler/lua54.lpt:982
local r -- ./compiler/lua54.lpt:983
if t[start] then -- ./compiler/lua54.lpt:984
r = lua(t[start]) -- ./compiler/lua54.lpt:985
for i = start + 1, # t, 1 do -- ./compiler/lua54.lpt:986
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.lpt:987
end -- ./compiler/lua54.lpt:987
else -- ./compiler/lua54.lpt:987
r = "" -- ./compiler/lua54.lpt:990
end -- ./compiler/lua54.lpt:990
return r -- ./compiler/lua54.lpt:992
end, -- ./compiler/lua54.lpt:992
["Id"] = function(t) -- ./compiler/lua54.lpt:995
local r = t[1] -- ./compiler/lua54.lpt:996
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:997
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.lpt:998
nomacro["variables"][t[1]] = true -- ./compiler/lua54.lpt:999
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.lpt:1000
r = lua(macroargs[t[1]]) -- ./compiler/lua54.lpt:1001
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.lpt:1002
local macro = macros["variables"][t[1]] -- ./compiler/lua54.lpt:1003
if type(macro) == "function" then -- ./compiler/lua54.lpt:1004
r = macro() -- ./compiler/lua54.lpt:1005
else -- ./compiler/lua54.lpt:1005
r = lua(macro) -- ./compiler/lua54.lpt:1007
end -- ./compiler/lua54.lpt:1007
end -- ./compiler/lua54.lpt:1007
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.lpt:1010
end -- ./compiler/lua54.lpt:1010
return r -- ./compiler/lua54.lpt:1012
end, -- ./compiler/lua54.lpt:1012
["AttributeId"] = function(t) -- ./compiler/lua54.lpt:1015
if t[2] then -- ./compiler/lua54.lpt:1016
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.lpt:1017
else -- ./compiler/lua54.lpt:1017
return t[1] -- ./compiler/lua54.lpt:1019
end -- ./compiler/lua54.lpt:1019
end, -- ./compiler/lua54.lpt:1019
["DestructuringId"] = function(t) -- ./compiler/lua54.lpt:1023
if t["id"] then -- ./compiler/lua54.lpt:1024
return t["id"] -- ./compiler/lua54.lpt:1025
else -- ./compiler/lua54.lpt:1025
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.lpt:1027
local vars = { ["id"] = tmp() } -- ./compiler/lua54.lpt:1028
for j = 1, # t, 1 do -- ./compiler/lua54.lpt:1029
table["insert"](vars, t[j]) -- ./compiler/lua54.lpt:1030
end -- ./compiler/lua54.lpt:1030
table["insert"](d, vars) -- ./compiler/lua54.lpt:1032
t["id"] = vars["id"] -- ./compiler/lua54.lpt:1033
return vars["id"] -- ./compiler/lua54.lpt:1034
end -- ./compiler/lua54.lpt:1034
end, -- ./compiler/lua54.lpt:1034
["Index"] = function(t) -- ./compiler/lua54.lpt:1038
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:1039
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:1040
else -- ./compiler/lua54.lpt:1040
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:1042
end -- ./compiler/lua54.lpt:1042
end, -- ./compiler/lua54.lpt:1042
["SafeIndex"] = function(t) -- ./compiler/lua54.lpt:1046
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:1047
local l = {} -- ./compiler/lua54.lpt:1048
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.lpt:1049
table["insert"](l, 1, t) -- ./compiler/lua54.lpt:1050
t = t[1] -- ./compiler/lua54.lpt:1051
end -- ./compiler/lua54.lpt:1051
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.lpt:1053
for _, e in ipairs(l) do -- ./compiler/lua54.lpt:1054
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.lpt:1055
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.lpt:1056
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.lpt:1057
else -- ./compiler/lua54.lpt:1057
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.lpt:1059
end -- ./compiler/lua54.lpt:1059
end -- ./compiler/lua54.lpt:1059
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.lpt:1062
return r -- ./compiler/lua54.lpt:1063
else -- ./compiler/lua54.lpt:1063
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.lpt:1065
end -- ./compiler/lua54.lpt:1065
end, -- ./compiler/lua54.lpt:1065
["_opid"] = { -- ./compiler/lua54.lpt:1071
["add"] = "+", -- ./compiler/lua54.lpt:1073
["sub"] = "-", -- ./compiler/lua54.lpt:1073
["mul"] = "*", -- ./compiler/lua54.lpt:1073
["div"] = "/", -- ./compiler/lua54.lpt:1073
["idiv"] = "//", -- ./compiler/lua54.lpt:1074
["mod"] = "%", -- ./compiler/lua54.lpt:1074
["pow"] = "^", -- ./compiler/lua54.lpt:1074
["concat"] = "..", -- ./compiler/lua54.lpt:1074
["band"] = "&", -- ./compiler/lua54.lpt:1075
["bor"] = "|", -- ./compiler/lua54.lpt:1075
["bxor"] = "~", -- ./compiler/lua54.lpt:1075
["shl"] = "<<", -- ./compiler/lua54.lpt:1075
["shr"] = ">>", -- ./compiler/lua54.lpt:1075
["eq"] = "==", -- ./compiler/lua54.lpt:1076
["ne"] = "~=", -- ./compiler/lua54.lpt:1076
["lt"] = "<", -- ./compiler/lua54.lpt:1076
["gt"] = ">", -- ./compiler/lua54.lpt:1076
["le"] = "<=", -- ./compiler/lua54.lpt:1076
["ge"] = ">=", -- ./compiler/lua54.lpt:1076
["and"] = "and", -- ./compiler/lua54.lpt:1077
["or"] = "or", -- ./compiler/lua54.lpt:1077
["unm"] = "-", -- ./compiler/lua54.lpt:1077
["len"] = "#", -- ./compiler/lua54.lpt:1077
["bnot"] = "~", -- ./compiler/lua54.lpt:1077
["not"] = "not", -- ./compiler/lua54.lpt:1077
["divb"] = function(left, right) -- ./compiler/lua54.lpt:1081
return table["concat"]({ -- ./compiler/lua54.lpt:1082
"((", -- ./compiler/lua54.lpt:1082
lua(left), -- ./compiler/lua54.lpt:1082
") % (", -- ./compiler/lua54.lpt:1082
lua(right), -- ./compiler/lua54.lpt:1082
") == 0)" -- ./compiler/lua54.lpt:1082
}) -- ./compiler/lua54.lpt:1082
end, -- ./compiler/lua54.lpt:1082
["ndivb"] = function(left, right) -- ./compiler/lua54.lpt:1085
return table["concat"]({ -- ./compiler/lua54.lpt:1086
"((", -- ./compiler/lua54.lpt:1086
lua(left), -- ./compiler/lua54.lpt:1086
") % (", -- ./compiler/lua54.lpt:1086
lua(right), -- ./compiler/lua54.lpt:1086
") ~= 0)" -- ./compiler/lua54.lpt:1086
}) -- ./compiler/lua54.lpt:1086
end, -- ./compiler/lua54.lpt:1086
["tconcat"] = function(left, right) -- ./compiler/lua54.lpt:1091
if right["tag"] == "Table" then -- ./compiler/lua54.lpt:1092
local sep = right[1] -- ./compiler/lua54.lpt:1093
local i = right[2] -- ./compiler/lua54.lpt:1094
local j = right[3] -- ./compiler/lua54.lpt:1095
local r = { -- ./compiler/lua54.lpt:1097
"table.concat(", -- ./compiler/lua54.lpt:1097
lua(left) -- ./compiler/lua54.lpt:1097
} -- ./compiler/lua54.lpt:1097
if sep ~= nil then -- ./compiler/lua54.lpt:1099
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1100
r[# r + 1] = lua(sep) -- ./compiler/lua54.lpt:1101
end -- ./compiler/lua54.lpt:1101
if i ~= nil then -- ./compiler/lua54.lpt:1104
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1105
r[# r + 1] = lua(i) -- ./compiler/lua54.lpt:1106
end -- ./compiler/lua54.lpt:1106
if j ~= nil then -- ./compiler/lua54.lpt:1109
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1110
r[# r + 1] = lua(j) -- ./compiler/lua54.lpt:1111
end -- ./compiler/lua54.lpt:1111
r[# r + 1] = ")" -- ./compiler/lua54.lpt:1114
return table["concat"](r) -- ./compiler/lua54.lpt:1116
else -- ./compiler/lua54.lpt:1116
return table["concat"]({ -- ./compiler/lua54.lpt:1118
"table.concat(", -- ./compiler/lua54.lpt:1118
lua(left), -- ./compiler/lua54.lpt:1118
", ", -- ./compiler/lua54.lpt:1118
lua(right), -- ./compiler/lua54.lpt:1118
")" -- ./compiler/lua54.lpt:1118
}) -- ./compiler/lua54.lpt:1118
end -- ./compiler/lua54.lpt:1118
end, -- ./compiler/lua54.lpt:1118
["pipe"] = function(left, right) -- ./compiler/lua54.lpt:1124
return table["concat"]({ -- ./compiler/lua54.lpt:1125
"(", -- ./compiler/lua54.lpt:1125
lua(right), -- ./compiler/lua54.lpt:1125
")", -- ./compiler/lua54.lpt:1125
"(", -- ./compiler/lua54.lpt:1125
lua(left), -- ./compiler/lua54.lpt:1125
")" -- ./compiler/lua54.lpt:1125
}) -- ./compiler/lua54.lpt:1125
end, -- ./compiler/lua54.lpt:1125
["pipebc"] = function(left, right) -- ./compiler/lua54.lpt:1127
return table["concat"]({ BROADCAST({ -- ./compiler/lua54.lpt:1128
right, -- ./compiler/lua54.lpt:1128
left -- ./compiler/lua54.lpt:1128
}, false) }) -- ./compiler/lua54.lpt:1128
end, -- ./compiler/lua54.lpt:1128
["pipebckv"] = function(left, right) -- ./compiler/lua54.lpt:1130
return table["concat"]({ BROADCAST({ -- ./compiler/lua54.lpt:1131
right, -- ./compiler/lua54.lpt:1131
left -- ./compiler/lua54.lpt:1131
}, true) }) -- ./compiler/lua54.lpt:1131
end -- ./compiler/lua54.lpt:1131
} -- ./compiler/lua54.lpt:1131
}, { ["__index"] = function(self, key) -- ./compiler/lua54.lpt:1143
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.lpt:1144
end }) -- ./compiler/lua54.lpt:1144
targetName = "Lua 5.3" -- ./compiler/lua53.lpt:1
tags["AttributeId"] = function(t) -- ./compiler/lua53.lpt:4
if t[2] then -- ./compiler/lua53.lpt:5
error("target " .. targetName .. " does not support variable attributes") -- ./compiler/lua53.lpt:6
else -- ./compiler/lua53.lpt:6
return t[1] -- ./compiler/lua53.lpt:8
end -- ./compiler/lua53.lpt:8
end -- ./compiler/lua53.lpt:8
targetName = "Lua 5.2" -- ./compiler/lua52.lpt:1
APPEND = function(t, toAppend) -- ./compiler/lua52.lpt:3
return "do" .. indent() .. "local " .. var("a") .. ", " .. var("p") .. " = { " .. toAppend .. " }, #" .. t .. "+1" .. newline() .. "for i=1, #" .. var("a") .. " do" .. indent() .. t .. "[" .. var("p") .. "] = " .. var("a") .. "[i]" .. newline() .. "" .. var("p") .. " = " .. var("p") .. " + 1" .. unindent() .. "end" .. unindent() .. "end" -- ./compiler/lua52.lpt:4
end -- ./compiler/lua52.lpt:4
tags["_opid"]["idiv"] = function(left, right) -- ./compiler/lua52.lpt:7
return "math.floor(" .. lua(left) .. " / " .. lua(right) .. ")" -- ./compiler/lua52.lpt:8
end -- ./compiler/lua52.lpt:8
tags["_opid"]["band"] = function(left, right) -- ./compiler/lua52.lpt:10
return "bit32.band(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:11
end -- ./compiler/lua52.lpt:11
tags["_opid"]["bor"] = function(left, right) -- ./compiler/lua52.lpt:13
return "bit32.bor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:14
end -- ./compiler/lua52.lpt:14
tags["_opid"]["bxor"] = function(left, right) -- ./compiler/lua52.lpt:16
return "bit32.bxor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:17
end -- ./compiler/lua52.lpt:17
tags["_opid"]["shl"] = function(left, right) -- ./compiler/lua52.lpt:19
return "bit32.lshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:20
end -- ./compiler/lua52.lpt:20
tags["_opid"]["shr"] = function(left, right) -- ./compiler/lua52.lpt:22
return "bit32.rshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:23
end -- ./compiler/lua52.lpt:23
tags["_opid"]["bnot"] = function(right) -- ./compiler/lua52.lpt:25
return "bit32.bnot(" .. lua(right) .. ")" -- ./compiler/lua52.lpt:26
end -- ./compiler/lua52.lpt:26
local code = lua(ast) .. newline() -- ./compiler/lua54.lpt:1151
return requireStr .. luaHeader .. code -- ./compiler/lua54.lpt:1152
end -- ./compiler/lua54.lpt:1152
end -- ./compiler/lua54.lpt:1152
local lua54 = _() or lua54 -- ./compiler/lua54.lpt:1157
return lua54 -- ./compiler/lua53.lpt:18
end -- ./compiler/lua53.lpt:18
local lua53 = _() or lua53 -- ./compiler/lua53.lpt:22
return lua53 -- ./compiler/lua52.lpt:35
end -- ./compiler/lua52.lpt:35
local lua52 = _() or lua52 -- ./compiler/lua52.lpt:39
package["loaded"]["compiler.lua52"] = lua52 or true -- ./compiler/lua52.lpt:40
local function _() -- ./compiler/lua52.lpt:43
local function _() -- ./compiler/lua52.lpt:45
local function _() -- ./compiler/lua52.lpt:47
local function _() -- ./compiler/lua52.lpt:49
local util = require("lepton.util") -- ./compiler/lua54.lpt:1
local targetName = "Lua 5.4" -- ./compiler/lua54.lpt:3
local unpack = unpack or table["unpack"] -- ./compiler/lua54.lpt:5
return function(code, ast, options, macros) -- ./compiler/lua54.lpt:7
if macros == nil then macros = { -- ./compiler/lua54.lpt:7
["functions"] = {}, -- ./compiler/lua54.lpt:7
["variables"] = {} -- ./compiler/lua54.lpt:7
} end -- ./compiler/lua54.lpt:7
local lastInputPos = 1 -- ./compiler/lua54.lpt:9
local prevLinePos = 1 -- ./compiler/lua54.lpt:10
local lastSource = options["chunkname"] or "nil" -- ./compiler/lua54.lpt:11
local lastLine = 1 -- ./compiler/lua54.lpt:12
local indentLevel = 0 -- ./compiler/lua54.lpt:16
local function newline() -- ./compiler/lua54.lpt:18
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.lpt:19
if options["mapLines"] then -- ./compiler/lua54.lpt:20
local sub = code:sub(lastInputPos) -- ./compiler/lua54.lpt:21
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.lpt:22
if source and line then -- ./compiler/lua54.lpt:24
lastSource = source -- ./compiler/lua54.lpt:25
lastLine = tonumber(line) -- ./compiler/lua54.lpt:26
else -- ./compiler/lua54.lpt:26
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.lpt:28
lastLine = lastLine + (1) -- ./compiler/lua54.lpt:29
end -- ./compiler/lua54.lpt:29
end -- ./compiler/lua54.lpt:29
prevLinePos = lastInputPos -- ./compiler/lua54.lpt:33
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.lpt:35
end -- ./compiler/lua54.lpt:35
return r -- ./compiler/lua54.lpt:37
end -- ./compiler/lua54.lpt:37
local function indent() -- ./compiler/lua54.lpt:40
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:41
return newline() -- ./compiler/lua54.lpt:42
end -- ./compiler/lua54.lpt:42
local function unindent() -- ./compiler/lua54.lpt:45
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:46
return newline() -- ./compiler/lua54.lpt:47
end -- ./compiler/lua54.lpt:47
local states = { -- ./compiler/lua54.lpt:53
["push"] = {}, -- ./compiler/lua54.lpt:54
["destructuring"] = {}, -- ./compiler/lua54.lpt:55
["scope"] = {}, -- ./compiler/lua54.lpt:56
["macroargs"] = {} -- ./compiler/lua54.lpt:57
} -- ./compiler/lua54.lpt:57
local function push(name, state) -- ./compiler/lua54.lpt:60
states[name][# states[name] + 1] = state -- ./compiler/lua54.lpt:61
return "" -- ./compiler/lua54.lpt:62
end -- ./compiler/lua54.lpt:62
local function pop(name) -- ./compiler/lua54.lpt:65
table["remove"](states[name]) -- ./compiler/lua54.lpt:66
return "" -- ./compiler/lua54.lpt:67
end -- ./compiler/lua54.lpt:67
local function set(name, state) -- ./compiler/lua54.lpt:70
states[name][# states[name]] = state -- ./compiler/lua54.lpt:71
return "" -- ./compiler/lua54.lpt:72
end -- ./compiler/lua54.lpt:72
local function peek(name) -- ./compiler/lua54.lpt:75
return states[name][# states[name]] -- ./compiler/lua54.lpt:76
end -- ./compiler/lua54.lpt:76
local function var(name) -- ./compiler/lua54.lpt:82
return options["variablePrefix"] .. name -- ./compiler/lua54.lpt:83
end -- ./compiler/lua54.lpt:83
local function tmp() -- ./compiler/lua54.lpt:87
local scope = peek("scope") -- ./compiler/lua54.lpt:88
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.lpt:89
table["insert"](scope, var) -- ./compiler/lua54.lpt:90
return var -- ./compiler/lua54.lpt:91
end -- ./compiler/lua54.lpt:91
local nomacro = { -- ./compiler/lua54.lpt:95
["variables"] = {}, -- ./compiler/lua54.lpt:95
["functions"] = {} -- ./compiler/lua54.lpt:95
} -- ./compiler/lua54.lpt:95
local luaHeader = "" -- ./compiler/lua54.lpt:98
local function addLua(code) -- ./compiler/lua54.lpt:99
luaHeader = luaHeader .. (code) -- ./compiler/lua54.lpt:100
end -- ./compiler/lua54.lpt:100
local libraries = {} -- ./compiler/lua54.lpt:105
local function addBroadcast() -- ./compiler/lua54.lpt:107
if libraries["broadcast"] then -- ./compiler/lua54.lpt:108
return  -- ./compiler/lua54.lpt:108
end -- ./compiler/lua54.lpt:108
addLua((" -- ./compiler/lua54.lpt:110\
local function %sbroadcast(func, t) -- ./compiler/lua54.lpt:111\
    local new = {} -- ./compiler/lua54.lpt:112\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:113\
        local r1, r2 = func(v) -- ./compiler/lua54.lpt:114\
        if r2 == nil then -- ./compiler/lua54.lpt:115\
            new[k] = r1 -- ./compiler/lua54.lpt:116\
        else -- ./compiler/lua54.lpt:117\
            new[r1] = r2 -- ./compiler/lua54.lpt:118\
        end -- ./compiler/lua54.lpt:119\
    end -- ./compiler/lua54.lpt:120\
    if next(new) ~= nil then -- ./compiler/lua54.lpt:121\
        return new -- ./compiler/lua54.lpt:122\
    end -- ./compiler/lua54.lpt:123\
end -- ./compiler/lua54.lpt:124\
"):format(options["variablePrefix"], options["variablePrefix"])) -- ./compiler/lua54.lpt:125
libraries["broadcast"] = true -- ./compiler/lua54.lpt:127
end -- ./compiler/lua54.lpt:127
local function addBroadcastKV() -- ./compiler/lua54.lpt:130
if libraries["broadcastKV"] then -- ./compiler/lua54.lpt:131
return  -- ./compiler/lua54.lpt:131
end -- ./compiler/lua54.lpt:131
addLua((" -- ./compiler/lua54.lpt:133\
local function %sbroadcast_kv(func, t) -- ./compiler/lua54.lpt:134\
    local new = {} -- ./compiler/lua54.lpt:135\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:136\
        local r1, r2 = func(k, v) -- ./compiler/lua54.lpt:137\
        if r2 == nil then -- ./compiler/lua54.lpt:138\
            new[k] = r1 -- ./compiler/lua54.lpt:139\
        else -- ./compiler/lua54.lpt:140\
            new[r1] = r2 -- ./compiler/lua54.lpt:141\
        end -- ./compiler/lua54.lpt:142\
    end -- ./compiler/lua54.lpt:143\
    if next(new) ~= nil then -- ./compiler/lua54.lpt:144\
        return new -- ./compiler/lua54.lpt:145\
    end -- ./compiler/lua54.lpt:146\
end -- ./compiler/lua54.lpt:147\
"):format(options["variablePrefix"], options["variablePrefix"])) -- ./compiler/lua54.lpt:148
libraries["broadcastKV"] = true -- ./compiler/lua54.lpt:150
end -- ./compiler/lua54.lpt:150
local function addFilter() -- ./compiler/lua54.lpt:153
if libraries["filter"] then -- ./compiler/lua54.lpt:154
return  -- ./compiler/lua54.lpt:154
end -- ./compiler/lua54.lpt:154
addLua((" -- ./compiler/lua54.lpt:156\
local function %sfilter(predicate, t) -- ./compiler/lua54.lpt:157\
    local new = {} -- ./compiler/lua54.lpt:158\
    local i = 1 -- ./compiler/lua54.lpt:159\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:160\
        if predicate(v) then -- ./compiler/lua54.lpt:161\
            if type(k) == 'number' then -- ./compiler/lua54.lpt:162\
                new[i] = v -- ./compiler/lua54.lpt:163\
                i = i + 1 -- ./compiler/lua54.lpt:164\
            else -- ./compiler/lua54.lpt:165\
                new[k] = v -- ./compiler/lua54.lpt:166\
            end -- ./compiler/lua54.lpt:167\
        end -- ./compiler/lua54.lpt:168\
    end -- ./compiler/lua54.lpt:169\
    return new -- ./compiler/lua54.lpt:170\
end -- ./compiler/lua54.lpt:171\
"):format(options["variablePrefix"])) -- ./compiler/lua54.lpt:172
libraries["filter"] = true -- ./compiler/lua54.lpt:174
end -- ./compiler/lua54.lpt:174
local function addFilterKV() -- ./compiler/lua54.lpt:177
if libraries["filterKV"] then -- ./compiler/lua54.lpt:178
return  -- ./compiler/lua54.lpt:178
end -- ./compiler/lua54.lpt:178
addLua((" -- ./compiler/lua54.lpt:180\
local function %sfilter_kv(predicate, t) -- ./compiler/lua54.lpt:181\
    local new = {} -- ./compiler/lua54.lpt:182\
    local i = 1 -- ./compiler/lua54.lpt:183\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:184\
        if predicate(k, v) then -- ./compiler/lua54.lpt:185\
            if type(k) == 'number' then -- ./compiler/lua54.lpt:186\
                new[i] = v -- ./compiler/lua54.lpt:187\
                i = i + 1 -- ./compiler/lua54.lpt:188\
            else -- ./compiler/lua54.lpt:189\
                new[k] = v -- ./compiler/lua54.lpt:190\
            end -- ./compiler/lua54.lpt:191\
        end -- ./compiler/lua54.lpt:192\
    end -- ./compiler/lua54.lpt:193\
    return new -- ./compiler/lua54.lpt:194\
end -- ./compiler/lua54.lpt:195\
"):format(options["variablePrefix"])) -- ./compiler/lua54.lpt:196
libraries["filterKV"] = true -- ./compiler/lua54.lpt:198
end -- ./compiler/lua54.lpt:198
local required = {} -- ./compiler/lua54.lpt:203
local requireStr = "" -- ./compiler/lua54.lpt:204
local function addRequire(mod, name, field) -- ./compiler/lua54.lpt:206
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.lpt:207
if not required[req] then -- ./compiler/lua54.lpt:208
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.lpt:209
required[req] = true -- ./compiler/lua54.lpt:210
end -- ./compiler/lua54.lpt:210
end -- ./compiler/lua54.lpt:210
local loop = { -- ./compiler/lua54.lpt:216
"While", -- ./compiler/lua54.lpt:216
"Repeat", -- ./compiler/lua54.lpt:216
"Fornum", -- ./compiler/lua54.lpt:216
"Forin", -- ./compiler/lua54.lpt:216
"WhileExpr", -- ./compiler/lua54.lpt:216
"RepeatExpr", -- ./compiler/lua54.lpt:216
"FornumExpr", -- ./compiler/lua54.lpt:216
"ForinExpr" -- ./compiler/lua54.lpt:216
} -- ./compiler/lua54.lpt:216
local func = { -- ./compiler/lua54.lpt:217
"Function", -- ./compiler/lua54.lpt:217
"TableCompr", -- ./compiler/lua54.lpt:217
"DoExpr", -- ./compiler/lua54.lpt:217
"WhileExpr", -- ./compiler/lua54.lpt:217
"RepeatExpr", -- ./compiler/lua54.lpt:217
"IfExpr", -- ./compiler/lua54.lpt:217
"FornumExpr", -- ./compiler/lua54.lpt:217
"ForinExpr" -- ./compiler/lua54.lpt:217
} -- ./compiler/lua54.lpt:217
local function any(list, tags, nofollow) -- ./compiler/lua54.lpt:221
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:221
local tagsCheck = {} -- ./compiler/lua54.lpt:222
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:223
tagsCheck[tag] = true -- ./compiler/lua54.lpt:224
end -- ./compiler/lua54.lpt:224
local nofollowCheck = {} -- ./compiler/lua54.lpt:226
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:227
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:228
end -- ./compiler/lua54.lpt:228
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:230
if type(node) == "table" then -- ./compiler/lua54.lpt:231
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:232
return node -- ./compiler/lua54.lpt:233
end -- ./compiler/lua54.lpt:233
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:235
local r = any(node, tags, nofollow) -- ./compiler/lua54.lpt:236
if r then -- ./compiler/lua54.lpt:237
return r -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
return nil -- ./compiler/lua54.lpt:241
end -- ./compiler/lua54.lpt:241
local function search(list, tags, nofollow) -- ./compiler/lua54.lpt:246
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:246
local tagsCheck = {} -- ./compiler/lua54.lpt:247
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:248
tagsCheck[tag] = true -- ./compiler/lua54.lpt:249
end -- ./compiler/lua54.lpt:249
local nofollowCheck = {} -- ./compiler/lua54.lpt:251
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:252
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:253
end -- ./compiler/lua54.lpt:253
local found = {} -- ./compiler/lua54.lpt:255
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:256
if type(node) == "table" then -- ./compiler/lua54.lpt:257
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:258
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.lpt:259
table["insert"](found, n) -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:263
table["insert"](found, node) -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
return found -- ./compiler/lua54.lpt:268
end -- ./compiler/lua54.lpt:268
local function all(list, tags) -- ./compiler/lua54.lpt:272
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:273
local ok = false -- ./compiler/lua54.lpt:274
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:275
if node["tag"] == tag then -- ./compiler/lua54.lpt:276
ok = true -- ./compiler/lua54.lpt:277
break -- ./compiler/lua54.lpt:278
end -- ./compiler/lua54.lpt:278
end -- ./compiler/lua54.lpt:278
if not ok then -- ./compiler/lua54.lpt:281
return false -- ./compiler/lua54.lpt:282
end -- ./compiler/lua54.lpt:282
end -- ./compiler/lua54.lpt:282
return true -- ./compiler/lua54.lpt:285
end -- ./compiler/lua54.lpt:285
local tags -- ./compiler/lua54.lpt:290
local function lua(ast, forceTag, ...) -- ./compiler/lua54.lpt:292
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.lpt:293
lastInputPos = ast["pos"] -- ./compiler/lua54.lpt:294
end -- ./compiler/lua54.lpt:294
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.lpt:296
end -- ./compiler/lua54.lpt:296
local UNPACK = function(list, i, j) -- ./compiler/lua54.lpt:301
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.lpt:302
end -- ./compiler/lua54.lpt:302
local APPEND = function(t, toAppend) -- ./compiler/lua54.lpt:304
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.lpt:305
end -- ./compiler/lua54.lpt:305
local CONTINUE_START = function() -- ./compiler/lua54.lpt:307
return "do" .. indent() -- ./compiler/lua54.lpt:308
end -- ./compiler/lua54.lpt:308
local CONTINUE_STOP = function() -- ./compiler/lua54.lpt:310
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.lpt:311
end -- ./compiler/lua54.lpt:311
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.lpt:314
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.lpt:314
if noLocal == nil then noLocal = false end -- ./compiler/lua54.lpt:314
local vars = {} -- ./compiler/lua54.lpt:315
local values = {} -- ./compiler/lua54.lpt:316
for _, list in ipairs(destructured) do -- ./compiler/lua54.lpt:317
for _, v in ipairs(list) do -- ./compiler/lua54.lpt:318
local var, val -- ./compiler/lua54.lpt:319
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.lpt:320
var = v -- ./compiler/lua54.lpt:321
val = { -- ./compiler/lua54.lpt:322
["tag"] = "Index", -- ./compiler/lua54.lpt:322
{ -- ./compiler/lua54.lpt:322
["tag"] = "Id", -- ./compiler/lua54.lpt:322
list["id"] -- ./compiler/lua54.lpt:322
}, -- ./compiler/lua54.lpt:322
{ -- ./compiler/lua54.lpt:322
["tag"] = "String", -- ./compiler/lua54.lpt:322
v[1] -- ./compiler/lua54.lpt:322
} -- ./compiler/lua54.lpt:322
} -- ./compiler/lua54.lpt:322
elseif v["tag"] == "Pair" then -- ./compiler/lua54.lpt:323
var = v[2] -- ./compiler/lua54.lpt:324
val = { -- ./compiler/lua54.lpt:325
["tag"] = "Index", -- ./compiler/lua54.lpt:325
{ -- ./compiler/lua54.lpt:325
["tag"] = "Id", -- ./compiler/lua54.lpt:325
list["id"] -- ./compiler/lua54.lpt:325
}, -- ./compiler/lua54.lpt:325
v[1] -- ./compiler/lua54.lpt:325
} -- ./compiler/lua54.lpt:325
else -- ./compiler/lua54.lpt:325
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.lpt:327
end -- ./compiler/lua54.lpt:327
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.lpt:329
val = { -- ./compiler/lua54.lpt:330
["tag"] = "Op", -- ./compiler/lua54.lpt:330
destructured["rightOp"], -- ./compiler/lua54.lpt:330
var, -- ./compiler/lua54.lpt:330
{ -- ./compiler/lua54.lpt:330
["tag"] = "Op", -- ./compiler/lua54.lpt:330
destructured["leftOp"], -- ./compiler/lua54.lpt:330
val, -- ./compiler/lua54.lpt:330
var -- ./compiler/lua54.lpt:330
} -- ./compiler/lua54.lpt:330
} -- ./compiler/lua54.lpt:330
elseif destructured["rightOp"] then -- ./compiler/lua54.lpt:331
val = { -- ./compiler/lua54.lpt:332
["tag"] = "Op", -- ./compiler/lua54.lpt:332
destructured["rightOp"], -- ./compiler/lua54.lpt:332
var, -- ./compiler/lua54.lpt:332
val -- ./compiler/lua54.lpt:332
} -- ./compiler/lua54.lpt:332
elseif destructured["leftOp"] then -- ./compiler/lua54.lpt:333
val = { -- ./compiler/lua54.lpt:334
["tag"] = "Op", -- ./compiler/lua54.lpt:334
destructured["leftOp"], -- ./compiler/lua54.lpt:334
val, -- ./compiler/lua54.lpt:334
var -- ./compiler/lua54.lpt:334
} -- ./compiler/lua54.lpt:334
end -- ./compiler/lua54.lpt:334
table["insert"](vars, lua(var)) -- ./compiler/lua54.lpt:336
table["insert"](values, lua(val)) -- ./compiler/lua54.lpt:337
end -- ./compiler/lua54.lpt:337
end -- ./compiler/lua54.lpt:337
if # vars > 0 then -- ./compiler/lua54.lpt:340
local decl = noLocal and "" or "local " -- ./compiler/lua54.lpt:341
if newlineAfter then -- ./compiler/lua54.lpt:342
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.lpt:343
else -- ./compiler/lua54.lpt:343
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.lpt:345
end -- ./compiler/lua54.lpt:345
else -- ./compiler/lua54.lpt:345
return "" -- ./compiler/lua54.lpt:348
end -- ./compiler/lua54.lpt:348
end -- ./compiler/lua54.lpt:348
local BROADCAST = function(t, use_kv) -- ./compiler/lua54.lpt:352
((use_kv and addBroadcastKV) or addBroadcast)() -- ./compiler/lua54.lpt:353
return table["concat"]({ -- ./compiler/lua54.lpt:354
options["variablePrefix"], -- ./compiler/lua54.lpt:354
(use_kv and "broadcast_kv(") or "broadcast(", -- ./compiler/lua54.lpt:354
lua(t[1]), -- ./compiler/lua54.lpt:354
",", -- ./compiler/lua54.lpt:354
lua(t[2]), -- ./compiler/lua54.lpt:354
")" -- ./compiler/lua54.lpt:354
}) -- ./compiler/lua54.lpt:354
end -- ./compiler/lua54.lpt:354
local FILTER = function(t, use_kv) -- ./compiler/lua54.lpt:356
((use_kv and addFilterKV) or addFilter)() -- ./compiler/lua54.lpt:357
return table["concat"]({ -- ./compiler/lua54.lpt:358
options["variablePrefix"], -- ./compiler/lua54.lpt:358
(use_kv and "filter_kv(") or "filter(", -- ./compiler/lua54.lpt:358
lua(t[1]), -- ./compiler/lua54.lpt:358
",", -- ./compiler/lua54.lpt:358
lua(t[2]), -- ./compiler/lua54.lpt:358
")" -- ./compiler/lua54.lpt:358
}) -- ./compiler/lua54.lpt:358
end -- ./compiler/lua54.lpt:358
tags = setmetatable({ -- ./compiler/lua54.lpt:363
["Block"] = function(t) -- ./compiler/lua54.lpt:366
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.lpt:367
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.lpt:368
hasPush["tag"] = "Return" -- ./compiler/lua54.lpt:369
hasPush = false -- ./compiler/lua54.lpt:370
end -- ./compiler/lua54.lpt:370
local r = push("scope", {}) -- ./compiler/lua54.lpt:372
if hasPush then -- ./compiler/lua54.lpt:373
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:374
end -- ./compiler/lua54.lpt:374
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:376
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:377
end -- ./compiler/lua54.lpt:377
if t[# t] then -- ./compiler/lua54.lpt:379
r = r .. (lua(t[# t])) -- ./compiler/lua54.lpt:380
end -- ./compiler/lua54.lpt:380
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:382
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.lpt:383
end -- ./compiler/lua54.lpt:383
return r .. pop("scope") -- ./compiler/lua54.lpt:385
end, -- ./compiler/lua54.lpt:385
["Do"] = function(t) -- ./compiler/lua54.lpt:391
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.lpt:392
end, -- ./compiler/lua54.lpt:392
["Set"] = function(t) -- ./compiler/lua54.lpt:395
local expr = t[# t] -- ./compiler/lua54.lpt:397
local vars, values = {}, {} -- ./compiler/lua54.lpt:398
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.lpt:399
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:400
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.lpt:401
table["insert"](destructuringVars, n) -- ./compiler/lua54.lpt:402
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.lpt:403
else -- ./compiler/lua54.lpt:403
table["insert"](vars, n) -- ./compiler/lua54.lpt:405
table["insert"](values, expr[i]) -- ./compiler/lua54.lpt:406
end -- ./compiler/lua54.lpt:406
end -- ./compiler/lua54.lpt:406
if # t == 2 or # t == 3 then -- ./compiler/lua54.lpt:410
local r = "" -- ./compiler/lua54.lpt:411
if # vars > 0 then -- ./compiler/lua54.lpt:412
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.lpt:413
end -- ./compiler/lua54.lpt:413
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:415
local destructured = {} -- ./compiler/lua54.lpt:416
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:417
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:418
end -- ./compiler/lua54.lpt:418
return r -- ./compiler/lua54.lpt:420
elseif # t == 4 then -- ./compiler/lua54.lpt:421
if t[3] == "=" then -- ./compiler/lua54.lpt:422
local r = "" -- ./compiler/lua54.lpt:423
if # vars > 0 then -- ./compiler/lua54.lpt:424
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:425
t[2], -- ./compiler/lua54.lpt:425
vars[1], -- ./compiler/lua54.lpt:425
{ -- ./compiler/lua54.lpt:425
["tag"] = "Paren", -- ./compiler/lua54.lpt:425
values[1] -- ./compiler/lua54.lpt:425
} -- ./compiler/lua54.lpt:425
}, "Op")) -- ./compiler/lua54.lpt:425
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.lpt:426
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:427
t[2], -- ./compiler/lua54.lpt:427
vars[i], -- ./compiler/lua54.lpt:427
{ -- ./compiler/lua54.lpt:427
["tag"] = "Paren", -- ./compiler/lua54.lpt:427
values[i] -- ./compiler/lua54.lpt:427
} -- ./compiler/lua54.lpt:427
}, "Op")) -- ./compiler/lua54.lpt:427
end -- ./compiler/lua54.lpt:427
end -- ./compiler/lua54.lpt:427
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:430
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.lpt:431
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:432
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:433
end -- ./compiler/lua54.lpt:433
return r -- ./compiler/lua54.lpt:435
else -- ./compiler/lua54.lpt:435
local r = "" -- ./compiler/lua54.lpt:437
if # vars > 0 then -- ./compiler/lua54.lpt:438
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:439
t[3], -- ./compiler/lua54.lpt:439
{ -- ./compiler/lua54.lpt:439
["tag"] = "Paren", -- ./compiler/lua54.lpt:439
values[1] -- ./compiler/lua54.lpt:439
}, -- ./compiler/lua54.lpt:439
vars[1] -- ./compiler/lua54.lpt:439
}, "Op")) -- ./compiler/lua54.lpt:439
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.lpt:440
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:441
t[3], -- ./compiler/lua54.lpt:441
{ -- ./compiler/lua54.lpt:441
["tag"] = "Paren", -- ./compiler/lua54.lpt:441
values[i] -- ./compiler/lua54.lpt:441
}, -- ./compiler/lua54.lpt:441
vars[i] -- ./compiler/lua54.lpt:441
}, "Op")) -- ./compiler/lua54.lpt:441
end -- ./compiler/lua54.lpt:441
end -- ./compiler/lua54.lpt:441
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:444
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.lpt:445
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:446
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:447
end -- ./compiler/lua54.lpt:447
return r -- ./compiler/lua54.lpt:449
end -- ./compiler/lua54.lpt:449
else -- ./compiler/lua54.lpt:449
local r = "" -- ./compiler/lua54.lpt:452
if # vars > 0 then -- ./compiler/lua54.lpt:453
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:454
t[2], -- ./compiler/lua54.lpt:454
vars[1], -- ./compiler/lua54.lpt:454
{ -- ./compiler/lua54.lpt:454
["tag"] = "Op", -- ./compiler/lua54.lpt:454
t[4], -- ./compiler/lua54.lpt:454
{ -- ./compiler/lua54.lpt:454
["tag"] = "Paren", -- ./compiler/lua54.lpt:454
values[1] -- ./compiler/lua54.lpt:454
}, -- ./compiler/lua54.lpt:454
vars[1] -- ./compiler/lua54.lpt:454
} -- ./compiler/lua54.lpt:454
}, "Op")) -- ./compiler/lua54.lpt:454
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.lpt:455
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:456
t[2], -- ./compiler/lua54.lpt:456
vars[i], -- ./compiler/lua54.lpt:456
{ -- ./compiler/lua54.lpt:456
["tag"] = "Op", -- ./compiler/lua54.lpt:456
t[4], -- ./compiler/lua54.lpt:456
{ -- ./compiler/lua54.lpt:456
["tag"] = "Paren", -- ./compiler/lua54.lpt:456
values[i] -- ./compiler/lua54.lpt:456
}, -- ./compiler/lua54.lpt:456
vars[i] -- ./compiler/lua54.lpt:456
} -- ./compiler/lua54.lpt:456
}, "Op")) -- ./compiler/lua54.lpt:456
end -- ./compiler/lua54.lpt:456
end -- ./compiler/lua54.lpt:456
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:459
local destructured = { -- ./compiler/lua54.lpt:460
["rightOp"] = t[2], -- ./compiler/lua54.lpt:460
["leftOp"] = t[4] -- ./compiler/lua54.lpt:460
} -- ./compiler/lua54.lpt:460
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:461
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:462
end -- ./compiler/lua54.lpt:462
return r -- ./compiler/lua54.lpt:464
end -- ./compiler/lua54.lpt:464
end, -- ./compiler/lua54.lpt:464
["AppendSet"] = function(t) -- ./compiler/lua54.lpt:468
local expr = t[# t] -- ./compiler/lua54.lpt:470
local r = {} -- ./compiler/lua54.lpt:471
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:472
local value = expr[i] -- ./compiler/lua54.lpt:473
if value == nil then -- ./compiler/lua54.lpt:474
break -- ./compiler/lua54.lpt:475
end -- ./compiler/lua54.lpt:475
local var = lua(n) -- ./compiler/lua54.lpt:478
r[i] = { -- ./compiler/lua54.lpt:479
var, -- ./compiler/lua54.lpt:479
"[#", -- ./compiler/lua54.lpt:479
var, -- ./compiler/lua54.lpt:479
"+1] = ", -- ./compiler/lua54.lpt:479
lua(value) -- ./compiler/lua54.lpt:479
} -- ./compiler/lua54.lpt:479
r[i] = table["concat"](r[i]) -- ./compiler/lua54.lpt:480
end -- ./compiler/lua54.lpt:480
return table["concat"](r, "; ") -- ./compiler/lua54.lpt:482
end, -- ./compiler/lua54.lpt:482
["While"] = function(t) -- ./compiler/lua54.lpt:485
local r = "" -- ./compiler/lua54.lpt:486
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.lpt:487
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:488
if # lets > 0 then -- ./compiler/lua54.lpt:489
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:490
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:491
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:492
end -- ./compiler/lua54.lpt:492
end -- ./compiler/lua54.lpt:492
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.lpt:495
if # lets > 0 then -- ./compiler/lua54.lpt:496
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:497
end -- ./compiler/lua54.lpt:497
if hasContinue then -- ./compiler/lua54.lpt:499
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:500
end -- ./compiler/lua54.lpt:500
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:502
if hasContinue then -- ./compiler/lua54.lpt:503
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:504
end -- ./compiler/lua54.lpt:504
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:506
if # lets > 0 then -- ./compiler/lua54.lpt:507
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:508
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.lpt:509
end -- ./compiler/lua54.lpt:509
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.lpt:511
end -- ./compiler/lua54.lpt:511
return r -- ./compiler/lua54.lpt:513
end, -- ./compiler/lua54.lpt:513
["Repeat"] = function(t) -- ./compiler/lua54.lpt:516
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.lpt:517
local r = "repeat" .. indent() -- ./compiler/lua54.lpt:518
if hasContinue then -- ./compiler/lua54.lpt:519
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:520
end -- ./compiler/lua54.lpt:520
r = r .. (lua(t[1])) -- ./compiler/lua54.lpt:522
if hasContinue then -- ./compiler/lua54.lpt:523
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.lpt:526
return r -- ./compiler/lua54.lpt:527
end, -- ./compiler/lua54.lpt:527
["If"] = function(t) -- ./compiler/lua54.lpt:530
local r = "" -- ./compiler/lua54.lpt:531
local toClose = 0 -- ./compiler/lua54.lpt:532
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:533
if # lets > 0 then -- ./compiler/lua54.lpt:534
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:535
toClose = toClose + (1) -- ./compiler/lua54.lpt:536
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:537
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:538
end -- ./compiler/lua54.lpt:538
end -- ./compiler/lua54.lpt:538
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.lpt:541
for i = 3, # t - 1, 2 do -- ./compiler/lua54.lpt:542
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.lpt:543
if # lets > 0 then -- ./compiler/lua54.lpt:544
r = r .. ("else" .. indent()) -- ./compiler/lua54.lpt:545
toClose = toClose + (1) -- ./compiler/lua54.lpt:546
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:547
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:548
end -- ./compiler/lua54.lpt:548
else -- ./compiler/lua54.lpt:548
r = r .. ("else") -- ./compiler/lua54.lpt:551
end -- ./compiler/lua54.lpt:551
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.lpt:553
end -- ./compiler/lua54.lpt:553
if # t % 2 == 1 then -- ./compiler/lua54.lpt:555
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.lpt:556
end -- ./compiler/lua54.lpt:556
r = r .. ("end") -- ./compiler/lua54.lpt:558
for i = 1, toClose do -- ./compiler/lua54.lpt:559
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:560
end -- ./compiler/lua54.lpt:560
return r -- ./compiler/lua54.lpt:562
end, -- ./compiler/lua54.lpt:562
["Fornum"] = function(t) -- ./compiler/lua54.lpt:565
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.lpt:566
if # t == 5 then -- ./compiler/lua54.lpt:567
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.lpt:568
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.lpt:569
if hasContinue then -- ./compiler/lua54.lpt:570
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:571
end -- ./compiler/lua54.lpt:571
r = r .. (lua(t[5])) -- ./compiler/lua54.lpt:573
if hasContinue then -- ./compiler/lua54.lpt:574
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:575
end -- ./compiler/lua54.lpt:575
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:577
else -- ./compiler/lua54.lpt:577
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.lpt:579
r = r .. (" do" .. indent()) -- ./compiler/lua54.lpt:580
if hasContinue then -- ./compiler/lua54.lpt:581
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:582
end -- ./compiler/lua54.lpt:582
r = r .. (lua(t[4])) -- ./compiler/lua54.lpt:584
if hasContinue then -- ./compiler/lua54.lpt:585
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:586
end -- ./compiler/lua54.lpt:586
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:588
end -- ./compiler/lua54.lpt:588
end, -- ./compiler/lua54.lpt:588
["Forin"] = function(t) -- ./compiler/lua54.lpt:592
local destructured = {} -- ./compiler/lua54.lpt:593
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.lpt:594
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.lpt:595
if hasContinue then -- ./compiler/lua54.lpt:596
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:597
end -- ./compiler/lua54.lpt:597
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.lpt:599
if hasContinue then -- ./compiler/lua54.lpt:600
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:601
end -- ./compiler/lua54.lpt:601
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:603
end, -- ./compiler/lua54.lpt:603
["Local"] = function(t) -- ./compiler/lua54.lpt:606
local destructured = {} -- ./compiler/lua54.lpt:607
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:608
if t[2][1] then -- ./compiler/lua54.lpt:609
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:610
end -- ./compiler/lua54.lpt:610
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:612
end, -- ./compiler/lua54.lpt:612
["Let"] = function(t) -- ./compiler/lua54.lpt:615
local destructured = {} -- ./compiler/lua54.lpt:616
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:617
local r = "local " .. nameList -- ./compiler/lua54.lpt:618
if t[2][1] then -- ./compiler/lua54.lpt:619
if all(t[2], { -- ./compiler/lua54.lpt:620
"Nil", -- ./compiler/lua54.lpt:620
"Dots", -- ./compiler/lua54.lpt:620
"Boolean", -- ./compiler/lua54.lpt:620
"Number", -- ./compiler/lua54.lpt:620
"String" -- ./compiler/lua54.lpt:620
}) then -- ./compiler/lua54.lpt:620
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:621
else -- ./compiler/lua54.lpt:621
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:623
end -- ./compiler/lua54.lpt:623
end -- ./compiler/lua54.lpt:623
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:626
end, -- ./compiler/lua54.lpt:626
["Localrec"] = function(t) -- ./compiler/lua54.lpt:629
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.lpt:630
end, -- ./compiler/lua54.lpt:630
["Goto"] = function(t) -- ./compiler/lua54.lpt:633
return "goto " .. lua(t, "Id") -- ./compiler/lua54.lpt:634
end, -- ./compiler/lua54.lpt:634
["Label"] = function(t) -- ./compiler/lua54.lpt:637
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.lpt:638
end, -- ./compiler/lua54.lpt:638
["Return"] = function(t) -- ./compiler/lua54.lpt:641
local push = peek("push") -- ./compiler/lua54.lpt:642
if push then -- ./compiler/lua54.lpt:643
local r = "" -- ./compiler/lua54.lpt:644
for _, val in ipairs(t) do -- ./compiler/lua54.lpt:645
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.lpt:646
end -- ./compiler/lua54.lpt:646
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.lpt:648
else -- ./compiler/lua54.lpt:648
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.lpt:650
end -- ./compiler/lua54.lpt:650
end, -- ./compiler/lua54.lpt:650
["Push"] = function(t) -- ./compiler/lua54.lpt:654
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.lpt:655
r = "" -- ./compiler/lua54.lpt:656
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:657
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:658
end -- ./compiler/lua54.lpt:658
if t[# t] then -- ./compiler/lua54.lpt:660
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.lpt:661
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.lpt:662
else -- ./compiler/lua54.lpt:662
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.lpt:664
end -- ./compiler/lua54.lpt:664
end -- ./compiler/lua54.lpt:664
return r -- ./compiler/lua54.lpt:667
end, -- ./compiler/lua54.lpt:667
["Break"] = function() -- ./compiler/lua54.lpt:670
return "break" -- ./compiler/lua54.lpt:671
end, -- ./compiler/lua54.lpt:671
["Continue"] = function() -- ./compiler/lua54.lpt:674
return "goto " .. var("continue") -- ./compiler/lua54.lpt:675
end, -- ./compiler/lua54.lpt:675
["Nil"] = function() -- ./compiler/lua54.lpt:682
return "nil" -- ./compiler/lua54.lpt:683
end, -- ./compiler/lua54.lpt:683
["Dots"] = function() -- ./compiler/lua54.lpt:686
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:687
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.lpt:688
nomacro["variables"]["..."] = true -- ./compiler/lua54.lpt:689
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.lpt:690
nomacro["variables"]["..."] = nil -- ./compiler/lua54.lpt:691
return r -- ./compiler/lua54.lpt:692
else -- ./compiler/lua54.lpt:692
return "..." -- ./compiler/lua54.lpt:694
end -- ./compiler/lua54.lpt:694
end, -- ./compiler/lua54.lpt:694
["Boolean"] = function(t) -- ./compiler/lua54.lpt:698
return tostring(t[1]) -- ./compiler/lua54.lpt:699
end, -- ./compiler/lua54.lpt:699
["Number"] = function(t) -- ./compiler/lua54.lpt:702
local n = tostring(t[1]):gsub("_", "") -- ./compiler/lua54.lpt:703
do -- ./compiler/lua54.lpt:705
local match -- ./compiler/lua54.lpt:705
match = n:match("^0b(.*)") -- ./compiler/lua54.lpt:705
if match then -- ./compiler/lua54.lpt:705
n = tostring(tonumber(match, 2)) -- ./compiler/lua54.lpt:706
end -- ./compiler/lua54.lpt:706
end -- ./compiler/lua54.lpt:706
return n -- ./compiler/lua54.lpt:708
end, -- ./compiler/lua54.lpt:708
["String"] = function(t) -- ./compiler/lua54.lpt:711
return ("%q"):format(t[1]) -- ./compiler/lua54.lpt:712
end, -- ./compiler/lua54.lpt:712
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.lpt:715
local r = "(" -- ./compiler/lua54.lpt:716
local decl = {} -- ./compiler/lua54.lpt:717
if t[1][1] then -- ./compiler/lua54.lpt:718
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:719
local id = lua(t[1][1][1]) -- ./compiler/lua54.lpt:720
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:721
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.lpt:722
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:723
r = r .. (id) -- ./compiler/lua54.lpt:724
else -- ./compiler/lua54.lpt:724
r = r .. (lua(t[1][1])) -- ./compiler/lua54.lpt:726
end -- ./compiler/lua54.lpt:726
for i = 2, # t[1], 1 do -- ./compiler/lua54.lpt:728
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:729
local id = lua(t[1][i][1]) -- ./compiler/lua54.lpt:730
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:731
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.lpt:732
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:733
r = r .. (", " .. id) -- ./compiler/lua54.lpt:734
else -- ./compiler/lua54.lpt:734
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
r = r .. (")" .. indent()) -- ./compiler/lua54.lpt:740
for _, d in ipairs(decl) do -- ./compiler/lua54.lpt:741
r = r .. (d .. newline()) -- ./compiler/lua54.lpt:742
end -- ./compiler/lua54.lpt:742
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.lpt:744
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.lpt:745
end -- ./compiler/lua54.lpt:745
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.lpt:747
if hasPush then -- ./compiler/lua54.lpt:748
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:749
else -- ./compiler/lua54.lpt:749
push("push", false) -- ./compiler/lua54.lpt:751
end -- ./compiler/lua54.lpt:751
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:753
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:754
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:755
end -- ./compiler/lua54.lpt:755
pop("push") -- ./compiler/lua54.lpt:757
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:758
end, -- ./compiler/lua54.lpt:758
["Function"] = function(t) -- ./compiler/lua54.lpt:760
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.lpt:761
end, -- ./compiler/lua54.lpt:761
["Pair"] = function(t) -- ./compiler/lua54.lpt:764
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.lpt:765
end, -- ./compiler/lua54.lpt:765
["Table"] = function(t) -- ./compiler/lua54.lpt:767
if # t == 0 then -- ./compiler/lua54.lpt:768
return "{}" -- ./compiler/lua54.lpt:769
elseif # t == 1 then -- ./compiler/lua54.lpt:770
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.lpt:771
else -- ./compiler/lua54.lpt:771
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.lpt:773
end -- ./compiler/lua54.lpt:773
end, -- ./compiler/lua54.lpt:773
["TableCompr"] = function(t) -- ./compiler/lua54.lpt:777
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.lpt:778
end, -- ./compiler/lua54.lpt:778
["Op"] = function(t) -- ./compiler/lua54.lpt:781
local r -- ./compiler/lua54.lpt:782
if # t == 2 then -- ./compiler/lua54.lpt:783
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:784
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.lpt:785
else -- ./compiler/lua54.lpt:785
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.lpt:787
end -- ./compiler/lua54.lpt:787
else -- ./compiler/lua54.lpt:787
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:790
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.lpt:791
else -- ./compiler/lua54.lpt:791
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.lpt:793
end -- ./compiler/lua54.lpt:793
end -- ./compiler/lua54.lpt:793
return r -- ./compiler/lua54.lpt:796
end, -- ./compiler/lua54.lpt:796
["Paren"] = function(t) -- ./compiler/lua54.lpt:799
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.lpt:800
end, -- ./compiler/lua54.lpt:800
["MethodStub"] = function(t) -- ./compiler/lua54.lpt:803
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:809
end, -- ./compiler/lua54.lpt:809
["SafeMethodStub"] = function(t) -- ./compiler/lua54.lpt:812
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:819
end, -- ./compiler/lua54.lpt:819
["LetExpr"] = function(t) -- ./compiler/lua54.lpt:826
return lua(t[1][1]) -- ./compiler/lua54.lpt:827
end, -- ./compiler/lua54.lpt:827
["_statexpr"] = function(t, stat) -- ./compiler/lua54.lpt:831
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.lpt:832
local r = "(function()" .. indent() -- ./compiler/lua54.lpt:833
if hasPush then -- ./compiler/lua54.lpt:834
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:835
else -- ./compiler/lua54.lpt:835
push("push", false) -- ./compiler/lua54.lpt:837
end -- ./compiler/lua54.lpt:837
r = r .. (lua(t, stat)) -- ./compiler/lua54.lpt:839
if hasPush then -- ./compiler/lua54.lpt:840
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:841
end -- ./compiler/lua54.lpt:841
pop("push") -- ./compiler/lua54.lpt:843
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.lpt:844
return r -- ./compiler/lua54.lpt:845
end, -- ./compiler/lua54.lpt:845
["DoExpr"] = function(t) -- ./compiler/lua54.lpt:848
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.lpt:849
t[# t]["tag"] = "Return" -- ./compiler/lua54.lpt:850
end -- ./compiler/lua54.lpt:850
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.lpt:852
end, -- ./compiler/lua54.lpt:852
["WhileExpr"] = function(t) -- ./compiler/lua54.lpt:855
return lua(t, "_statexpr", "While") -- ./compiler/lua54.lpt:856
end, -- ./compiler/lua54.lpt:856
["RepeatExpr"] = function(t) -- ./compiler/lua54.lpt:859
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.lpt:860
end, -- ./compiler/lua54.lpt:860
["IfExpr"] = function(t) -- ./compiler/lua54.lpt:863
for i = 2, # t do -- ./compiler/lua54.lpt:864
local block = t[i] -- ./compiler/lua54.lpt:865
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.lpt:866
block[# block]["tag"] = "Return" -- ./compiler/lua54.lpt:867
end -- ./compiler/lua54.lpt:867
end -- ./compiler/lua54.lpt:867
return lua(t, "_statexpr", "If") -- ./compiler/lua54.lpt:870
end, -- ./compiler/lua54.lpt:870
["FornumExpr"] = function(t) -- ./compiler/lua54.lpt:873
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.lpt:874
end, -- ./compiler/lua54.lpt:874
["ForinExpr"] = function(t) -- ./compiler/lua54.lpt:877
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.lpt:878
end, -- ./compiler/lua54.lpt:878
["Call"] = function(t) -- ./compiler/lua54.lpt:885
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:886
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:887
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.lpt:888
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.lpt:889
local replacement = macro["replacement"] -- ./compiler/lua54.lpt:890
local r -- ./compiler/lua54.lpt:891
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.lpt:892
if type(replacement) == "function" then -- ./compiler/lua54.lpt:893
local args = {} -- ./compiler/lua54.lpt:894
for i = 2, # t do -- ./compiler/lua54.lpt:895
table["insert"](args, lua(t[i])) -- ./compiler/lua54.lpt:896
end -- ./compiler/lua54.lpt:896
r = replacement(unpack(args)) -- ./compiler/lua54.lpt:898
else -- ./compiler/lua54.lpt:898
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.lpt:900
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.lpt:901
if arg["tag"] == "Dots" then -- ./compiler/lua54.lpt:902
macroargs["..."] = (function() -- ./compiler/lua54.lpt:903
local self = {} -- ./compiler/lua54.lpt:903
for j = i + 1, # t do -- ./compiler/lua54.lpt:903
self[#self+1] = t[j] -- ./compiler/lua54.lpt:903
end -- ./compiler/lua54.lpt:903
return self -- ./compiler/lua54.lpt:903
end)() -- ./compiler/lua54.lpt:903
elseif arg["tag"] == "Id" then -- ./compiler/lua54.lpt:904
if t[i + 1] == nil then -- ./compiler/lua54.lpt:905
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.lpt:906
end -- ./compiler/lua54.lpt:906
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.lpt:908
else -- ./compiler/lua54.lpt:908
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.lpt:910
end -- ./compiler/lua54.lpt:910
end -- ./compiler/lua54.lpt:910
push("macroargs", macroargs) -- ./compiler/lua54.lpt:913
r = lua(replacement) -- ./compiler/lua54.lpt:914
pop("macroargs") -- ./compiler/lua54.lpt:915
end -- ./compiler/lua54.lpt:915
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.lpt:917
return r -- ./compiler/lua54.lpt:918
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.lpt:919
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.lpt:920
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:921
else -- ./compiler/lua54.lpt:921
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:923
end -- ./compiler/lua54.lpt:923
else -- ./compiler/lua54.lpt:923
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:926
end -- ./compiler/lua54.lpt:926
end, -- ./compiler/lua54.lpt:926
["SafeCall"] = function(t) -- ./compiler/lua54.lpt:930
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:931
return lua(t, "SafeIndex") -- ./compiler/lua54.lpt:932
else -- ./compiler/lua54.lpt:932
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.lpt:934
end -- ./compiler/lua54.lpt:934
end, -- ./compiler/lua54.lpt:934
["Broadcast"] = function(t) -- ./compiler/lua54.lpt:940
return BROADCAST(t, false) -- ./compiler/lua54.lpt:941
end, -- ./compiler/lua54.lpt:941
["BroadcastKV"] = function(t) -- ./compiler/lua54.lpt:943
return BROADCAST(t, true) -- ./compiler/lua54.lpt:944
end, -- ./compiler/lua54.lpt:944
["Filter"] = function(t) -- ./compiler/lua54.lpt:946
return FILTER(t, false) -- ./compiler/lua54.lpt:947
end, -- ./compiler/lua54.lpt:947
["FilterKV"] = function(t) -- ./compiler/lua54.lpt:949
return FILTER(t, true) -- ./compiler/lua54.lpt:950
end, -- ./compiler/lua54.lpt:950
["StringFormat"] = function(t) -- ./compiler/lua54.lpt:955
local args = {} -- ./compiler/lua54.lpt:956
for i, v in ipairs(t[2]) do -- ./compiler/lua54.lpt:957
args[i] = lua(v) -- ./compiler/lua54.lpt:958
end -- ./compiler/lua54.lpt:958
local r = { -- ./compiler/lua54.lpt:960
"(", -- ./compiler/lua54.lpt:960
"string.format(", -- ./compiler/lua54.lpt:960
("%q"):format(t[1]) -- ./compiler/lua54.lpt:960
} -- ./compiler/lua54.lpt:960
if # args ~= 0 then -- ./compiler/lua54.lpt:961
r[# r + 1] = ", " -- ./compiler/lua54.lpt:962
r[# r + 1] = table["concat"](args, ", ") -- ./compiler/lua54.lpt:963
r[# r + 1] = "))" -- ./compiler/lua54.lpt:964
end -- ./compiler/lua54.lpt:964
return table["concat"](r) -- ./compiler/lua54.lpt:966
end, -- ./compiler/lua54.lpt:966
["TableUnpack"] = function(t) -- ./compiler/lua54.lpt:971
local args = {} -- ./compiler/lua54.lpt:972
for i, v in ipairs(t[2]) do -- ./compiler/lua54.lpt:973
args[i] = lua(v) -- ./compiler/lua54.lpt:974
end -- ./compiler/lua54.lpt:974
return UNPACK(lua(t[1]), args[1], args[2]) -- ./compiler/lua54.lpt:976
end, -- ./compiler/lua54.lpt:976
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.lpt:982
if start == nil then start = 1 end -- ./compiler/lua54.lpt:982
local r -- ./compiler/lua54.lpt:983
if t[start] then -- ./compiler/lua54.lpt:984
r = lua(t[start]) -- ./compiler/lua54.lpt:985
for i = start + 1, # t, 1 do -- ./compiler/lua54.lpt:986
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.lpt:987
end -- ./compiler/lua54.lpt:987
else -- ./compiler/lua54.lpt:987
r = "" -- ./compiler/lua54.lpt:990
end -- ./compiler/lua54.lpt:990
return r -- ./compiler/lua54.lpt:992
end, -- ./compiler/lua54.lpt:992
["Id"] = function(t) -- ./compiler/lua54.lpt:995
local r = t[1] -- ./compiler/lua54.lpt:996
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:997
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.lpt:998
nomacro["variables"][t[1]] = true -- ./compiler/lua54.lpt:999
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.lpt:1000
r = lua(macroargs[t[1]]) -- ./compiler/lua54.lpt:1001
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.lpt:1002
local macro = macros["variables"][t[1]] -- ./compiler/lua54.lpt:1003
if type(macro) == "function" then -- ./compiler/lua54.lpt:1004
r = macro() -- ./compiler/lua54.lpt:1005
else -- ./compiler/lua54.lpt:1005
r = lua(macro) -- ./compiler/lua54.lpt:1007
end -- ./compiler/lua54.lpt:1007
end -- ./compiler/lua54.lpt:1007
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.lpt:1010
end -- ./compiler/lua54.lpt:1010
return r -- ./compiler/lua54.lpt:1012
end, -- ./compiler/lua54.lpt:1012
["AttributeId"] = function(t) -- ./compiler/lua54.lpt:1015
if t[2] then -- ./compiler/lua54.lpt:1016
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.lpt:1017
else -- ./compiler/lua54.lpt:1017
return t[1] -- ./compiler/lua54.lpt:1019
end -- ./compiler/lua54.lpt:1019
end, -- ./compiler/lua54.lpt:1019
["DestructuringId"] = function(t) -- ./compiler/lua54.lpt:1023
if t["id"] then -- ./compiler/lua54.lpt:1024
return t["id"] -- ./compiler/lua54.lpt:1025
else -- ./compiler/lua54.lpt:1025
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.lpt:1027
local vars = { ["id"] = tmp() } -- ./compiler/lua54.lpt:1028
for j = 1, # t, 1 do -- ./compiler/lua54.lpt:1029
table["insert"](vars, t[j]) -- ./compiler/lua54.lpt:1030
end -- ./compiler/lua54.lpt:1030
table["insert"](d, vars) -- ./compiler/lua54.lpt:1032
t["id"] = vars["id"] -- ./compiler/lua54.lpt:1033
return vars["id"] -- ./compiler/lua54.lpt:1034
end -- ./compiler/lua54.lpt:1034
end, -- ./compiler/lua54.lpt:1034
["Index"] = function(t) -- ./compiler/lua54.lpt:1038
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:1039
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:1040
else -- ./compiler/lua54.lpt:1040
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:1042
end -- ./compiler/lua54.lpt:1042
end, -- ./compiler/lua54.lpt:1042
["SafeIndex"] = function(t) -- ./compiler/lua54.lpt:1046
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:1047
local l = {} -- ./compiler/lua54.lpt:1048
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.lpt:1049
table["insert"](l, 1, t) -- ./compiler/lua54.lpt:1050
t = t[1] -- ./compiler/lua54.lpt:1051
end -- ./compiler/lua54.lpt:1051
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.lpt:1053
for _, e in ipairs(l) do -- ./compiler/lua54.lpt:1054
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.lpt:1055
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.lpt:1056
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.lpt:1057
else -- ./compiler/lua54.lpt:1057
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.lpt:1059
end -- ./compiler/lua54.lpt:1059
end -- ./compiler/lua54.lpt:1059
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.lpt:1062
return r -- ./compiler/lua54.lpt:1063
else -- ./compiler/lua54.lpt:1063
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.lpt:1065
end -- ./compiler/lua54.lpt:1065
end, -- ./compiler/lua54.lpt:1065
["_opid"] = { -- ./compiler/lua54.lpt:1071
["add"] = "+", -- ./compiler/lua54.lpt:1073
["sub"] = "-", -- ./compiler/lua54.lpt:1073
["mul"] = "*", -- ./compiler/lua54.lpt:1073
["div"] = "/", -- ./compiler/lua54.lpt:1073
["idiv"] = "//", -- ./compiler/lua54.lpt:1074
["mod"] = "%", -- ./compiler/lua54.lpt:1074
["pow"] = "^", -- ./compiler/lua54.lpt:1074
["concat"] = "..", -- ./compiler/lua54.lpt:1074
["band"] = "&", -- ./compiler/lua54.lpt:1075
["bor"] = "|", -- ./compiler/lua54.lpt:1075
["bxor"] = "~", -- ./compiler/lua54.lpt:1075
["shl"] = "<<", -- ./compiler/lua54.lpt:1075
["shr"] = ">>", -- ./compiler/lua54.lpt:1075
["eq"] = "==", -- ./compiler/lua54.lpt:1076
["ne"] = "~=", -- ./compiler/lua54.lpt:1076
["lt"] = "<", -- ./compiler/lua54.lpt:1076
["gt"] = ">", -- ./compiler/lua54.lpt:1076
["le"] = "<=", -- ./compiler/lua54.lpt:1076
["ge"] = ">=", -- ./compiler/lua54.lpt:1076
["and"] = "and", -- ./compiler/lua54.lpt:1077
["or"] = "or", -- ./compiler/lua54.lpt:1077
["unm"] = "-", -- ./compiler/lua54.lpt:1077
["len"] = "#", -- ./compiler/lua54.lpt:1077
["bnot"] = "~", -- ./compiler/lua54.lpt:1077
["not"] = "not", -- ./compiler/lua54.lpt:1077
["divb"] = function(left, right) -- ./compiler/lua54.lpt:1081
return table["concat"]({ -- ./compiler/lua54.lpt:1082
"((", -- ./compiler/lua54.lpt:1082
lua(left), -- ./compiler/lua54.lpt:1082
") % (", -- ./compiler/lua54.lpt:1082
lua(right), -- ./compiler/lua54.lpt:1082
") == 0)" -- ./compiler/lua54.lpt:1082
}) -- ./compiler/lua54.lpt:1082
end, -- ./compiler/lua54.lpt:1082
["ndivb"] = function(left, right) -- ./compiler/lua54.lpt:1085
return table["concat"]({ -- ./compiler/lua54.lpt:1086
"((", -- ./compiler/lua54.lpt:1086
lua(left), -- ./compiler/lua54.lpt:1086
") % (", -- ./compiler/lua54.lpt:1086
lua(right), -- ./compiler/lua54.lpt:1086
") ~= 0)" -- ./compiler/lua54.lpt:1086
}) -- ./compiler/lua54.lpt:1086
end, -- ./compiler/lua54.lpt:1086
["tconcat"] = function(left, right) -- ./compiler/lua54.lpt:1091
if right["tag"] == "Table" then -- ./compiler/lua54.lpt:1092
local sep = right[1] -- ./compiler/lua54.lpt:1093
local i = right[2] -- ./compiler/lua54.lpt:1094
local j = right[3] -- ./compiler/lua54.lpt:1095
local r = { -- ./compiler/lua54.lpt:1097
"table.concat(", -- ./compiler/lua54.lpt:1097
lua(left) -- ./compiler/lua54.lpt:1097
} -- ./compiler/lua54.lpt:1097
if sep ~= nil then -- ./compiler/lua54.lpt:1099
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1100
r[# r + 1] = lua(sep) -- ./compiler/lua54.lpt:1101
end -- ./compiler/lua54.lpt:1101
if i ~= nil then -- ./compiler/lua54.lpt:1104
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1105
r[# r + 1] = lua(i) -- ./compiler/lua54.lpt:1106
end -- ./compiler/lua54.lpt:1106
if j ~= nil then -- ./compiler/lua54.lpt:1109
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1110
r[# r + 1] = lua(j) -- ./compiler/lua54.lpt:1111
end -- ./compiler/lua54.lpt:1111
r[# r + 1] = ")" -- ./compiler/lua54.lpt:1114
return table["concat"](r) -- ./compiler/lua54.lpt:1116
else -- ./compiler/lua54.lpt:1116
return table["concat"]({ -- ./compiler/lua54.lpt:1118
"table.concat(", -- ./compiler/lua54.lpt:1118
lua(left), -- ./compiler/lua54.lpt:1118
", ", -- ./compiler/lua54.lpt:1118
lua(right), -- ./compiler/lua54.lpt:1118
")" -- ./compiler/lua54.lpt:1118
}) -- ./compiler/lua54.lpt:1118
end -- ./compiler/lua54.lpt:1118
end, -- ./compiler/lua54.lpt:1118
["pipe"] = function(left, right) -- ./compiler/lua54.lpt:1124
return table["concat"]({ -- ./compiler/lua54.lpt:1125
"(", -- ./compiler/lua54.lpt:1125
lua(right), -- ./compiler/lua54.lpt:1125
")", -- ./compiler/lua54.lpt:1125
"(", -- ./compiler/lua54.lpt:1125
lua(left), -- ./compiler/lua54.lpt:1125
")" -- ./compiler/lua54.lpt:1125
}) -- ./compiler/lua54.lpt:1125
end, -- ./compiler/lua54.lpt:1125
["pipebc"] = function(left, right) -- ./compiler/lua54.lpt:1127
return table["concat"]({ BROADCAST({ -- ./compiler/lua54.lpt:1128
right, -- ./compiler/lua54.lpt:1128
left -- ./compiler/lua54.lpt:1128
}, false) }) -- ./compiler/lua54.lpt:1128
end, -- ./compiler/lua54.lpt:1128
["pipebckv"] = function(left, right) -- ./compiler/lua54.lpt:1130
return table["concat"]({ BROADCAST({ -- ./compiler/lua54.lpt:1131
right, -- ./compiler/lua54.lpt:1131
left -- ./compiler/lua54.lpt:1131
}, true) }) -- ./compiler/lua54.lpt:1131
end -- ./compiler/lua54.lpt:1131
} -- ./compiler/lua54.lpt:1131
}, { ["__index"] = function(self, key) -- ./compiler/lua54.lpt:1143
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.lpt:1144
end }) -- ./compiler/lua54.lpt:1144
targetName = "Lua 5.3" -- ./compiler/lua53.lpt:1
tags["AttributeId"] = function(t) -- ./compiler/lua53.lpt:4
if t[2] then -- ./compiler/lua53.lpt:5
error("target " .. targetName .. " does not support variable attributes") -- ./compiler/lua53.lpt:6
else -- ./compiler/lua53.lpt:6
return t[1] -- ./compiler/lua53.lpt:8
end -- ./compiler/lua53.lpt:8
end -- ./compiler/lua53.lpt:8
targetName = "Lua 5.2" -- ./compiler/lua52.lpt:1
APPEND = function(t, toAppend) -- ./compiler/lua52.lpt:3
return "do" .. indent() .. "local " .. var("a") .. ", " .. var("p") .. " = { " .. toAppend .. " }, #" .. t .. "+1" .. newline() .. "for i=1, #" .. var("a") .. " do" .. indent() .. t .. "[" .. var("p") .. "] = " .. var("a") .. "[i]" .. newline() .. "" .. var("p") .. " = " .. var("p") .. " + 1" .. unindent() .. "end" .. unindent() .. "end" -- ./compiler/lua52.lpt:4
end -- ./compiler/lua52.lpt:4
tags["_opid"]["idiv"] = function(left, right) -- ./compiler/lua52.lpt:7
return "math.floor(" .. lua(left) .. " / " .. lua(right) .. ")" -- ./compiler/lua52.lpt:8
end -- ./compiler/lua52.lpt:8
tags["_opid"]["band"] = function(left, right) -- ./compiler/lua52.lpt:10
return "bit32.band(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:11
end -- ./compiler/lua52.lpt:11
tags["_opid"]["bor"] = function(left, right) -- ./compiler/lua52.lpt:13
return "bit32.bor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:14
end -- ./compiler/lua52.lpt:14
tags["_opid"]["bxor"] = function(left, right) -- ./compiler/lua52.lpt:16
return "bit32.bxor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:17
end -- ./compiler/lua52.lpt:17
tags["_opid"]["shl"] = function(left, right) -- ./compiler/lua52.lpt:19
return "bit32.lshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:20
end -- ./compiler/lua52.lpt:20
tags["_opid"]["shr"] = function(left, right) -- ./compiler/lua52.lpt:22
return "bit32.rshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:23
end -- ./compiler/lua52.lpt:23
tags["_opid"]["bnot"] = function(right) -- ./compiler/lua52.lpt:25
return "bit32.bnot(" .. lua(right) .. ")" -- ./compiler/lua52.lpt:26
end -- ./compiler/lua52.lpt:26
targetName = "LuaJIT" -- ./compiler/luajit.lpt:1
UNPACK = function(list, i, j) -- ./compiler/luajit.lpt:3
return "unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/luajit.lpt:4
end -- ./compiler/luajit.lpt:4
tags["_opid"]["band"] = function(left, right) -- ./compiler/luajit.lpt:7
addRequire("bit", "band", "band") -- ./compiler/luajit.lpt:8
return var("band") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.lpt:9
end -- ./compiler/luajit.lpt:9
tags["_opid"]["bor"] = function(left, right) -- ./compiler/luajit.lpt:11
addRequire("bit", "bor", "bor") -- ./compiler/luajit.lpt:12
return var("bor") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.lpt:13
end -- ./compiler/luajit.lpt:13
tags["_opid"]["bxor"] = function(left, right) -- ./compiler/luajit.lpt:15
addRequire("bit", "bxor", "bxor") -- ./compiler/luajit.lpt:16
return var("bxor") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.lpt:17
end -- ./compiler/luajit.lpt:17
tags["_opid"]["shl"] = function(left, right) -- ./compiler/luajit.lpt:19
addRequire("bit", "lshift", "lshift") -- ./compiler/luajit.lpt:20
return var("lshift") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.lpt:21
end -- ./compiler/luajit.lpt:21
tags["_opid"]["shr"] = function(left, right) -- ./compiler/luajit.lpt:23
addRequire("bit", "rshift", "rshift") -- ./compiler/luajit.lpt:24
return var("rshift") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.lpt:25
end -- ./compiler/luajit.lpt:25
tags["_opid"]["bnot"] = function(right) -- ./compiler/luajit.lpt:27
addRequire("bit", "bnot", "bnot") -- ./compiler/luajit.lpt:28
return var("bnot") .. "(" .. lua(right) .. ")" -- ./compiler/luajit.lpt:29
end -- ./compiler/luajit.lpt:29
local code = lua(ast) .. newline() -- ./compiler/lua54.lpt:1151
return requireStr .. luaHeader .. code -- ./compiler/lua54.lpt:1152
end -- ./compiler/lua54.lpt:1152
end -- ./compiler/lua54.lpt:1152
local lua54 = _() or lua54 -- ./compiler/lua54.lpt:1157
return lua54 -- ./compiler/lua53.lpt:18
end -- ./compiler/lua53.lpt:18
local lua53 = _() or lua53 -- ./compiler/lua53.lpt:22
return lua53 -- ./compiler/lua52.lpt:35
end -- ./compiler/lua52.lpt:35
local lua52 = _() or lua52 -- ./compiler/lua52.lpt:39
return lua52 -- ./compiler/luajit.lpt:38
end -- ./compiler/luajit.lpt:38
local luajit = _() or luajit -- ./compiler/luajit.lpt:42
package["loaded"]["compiler.luajit"] = luajit or true -- ./compiler/luajit.lpt:43
local function _() -- ./compiler/luajit.lpt:46
local function _() -- ./compiler/luajit.lpt:48
local function _() -- ./compiler/luajit.lpt:50
local function _() -- ./compiler/luajit.lpt:52
local function _() -- ./compiler/luajit.lpt:54
local util = require("lepton.util") -- ./compiler/lua54.lpt:1
local targetName = "Lua 5.4" -- ./compiler/lua54.lpt:3
local unpack = unpack or table["unpack"] -- ./compiler/lua54.lpt:5
return function(code, ast, options, macros) -- ./compiler/lua54.lpt:7
if macros == nil then macros = { -- ./compiler/lua54.lpt:7
["functions"] = {}, -- ./compiler/lua54.lpt:7
["variables"] = {} -- ./compiler/lua54.lpt:7
} end -- ./compiler/lua54.lpt:7
local lastInputPos = 1 -- ./compiler/lua54.lpt:9
local prevLinePos = 1 -- ./compiler/lua54.lpt:10
local lastSource = options["chunkname"] or "nil" -- ./compiler/lua54.lpt:11
local lastLine = 1 -- ./compiler/lua54.lpt:12
local indentLevel = 0 -- ./compiler/lua54.lpt:16
local function newline() -- ./compiler/lua54.lpt:18
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.lpt:19
if options["mapLines"] then -- ./compiler/lua54.lpt:20
local sub = code:sub(lastInputPos) -- ./compiler/lua54.lpt:21
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.lpt:22
if source and line then -- ./compiler/lua54.lpt:24
lastSource = source -- ./compiler/lua54.lpt:25
lastLine = tonumber(line) -- ./compiler/lua54.lpt:26
else -- ./compiler/lua54.lpt:26
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.lpt:28
lastLine = lastLine + (1) -- ./compiler/lua54.lpt:29
end -- ./compiler/lua54.lpt:29
end -- ./compiler/lua54.lpt:29
prevLinePos = lastInputPos -- ./compiler/lua54.lpt:33
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.lpt:35
end -- ./compiler/lua54.lpt:35
return r -- ./compiler/lua54.lpt:37
end -- ./compiler/lua54.lpt:37
local function indent() -- ./compiler/lua54.lpt:40
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:41
return newline() -- ./compiler/lua54.lpt:42
end -- ./compiler/lua54.lpt:42
local function unindent() -- ./compiler/lua54.lpt:45
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:46
return newline() -- ./compiler/lua54.lpt:47
end -- ./compiler/lua54.lpt:47
local states = { -- ./compiler/lua54.lpt:53
["push"] = {}, -- ./compiler/lua54.lpt:54
["destructuring"] = {}, -- ./compiler/lua54.lpt:55
["scope"] = {}, -- ./compiler/lua54.lpt:56
["macroargs"] = {} -- ./compiler/lua54.lpt:57
} -- ./compiler/lua54.lpt:57
local function push(name, state) -- ./compiler/lua54.lpt:60
states[name][# states[name] + 1] = state -- ./compiler/lua54.lpt:61
return "" -- ./compiler/lua54.lpt:62
end -- ./compiler/lua54.lpt:62
local function pop(name) -- ./compiler/lua54.lpt:65
table["remove"](states[name]) -- ./compiler/lua54.lpt:66
return "" -- ./compiler/lua54.lpt:67
end -- ./compiler/lua54.lpt:67
local function set(name, state) -- ./compiler/lua54.lpt:70
states[name][# states[name]] = state -- ./compiler/lua54.lpt:71
return "" -- ./compiler/lua54.lpt:72
end -- ./compiler/lua54.lpt:72
local function peek(name) -- ./compiler/lua54.lpt:75
return states[name][# states[name]] -- ./compiler/lua54.lpt:76
end -- ./compiler/lua54.lpt:76
local function var(name) -- ./compiler/lua54.lpt:82
return options["variablePrefix"] .. name -- ./compiler/lua54.lpt:83
end -- ./compiler/lua54.lpt:83
local function tmp() -- ./compiler/lua54.lpt:87
local scope = peek("scope") -- ./compiler/lua54.lpt:88
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.lpt:89
table["insert"](scope, var) -- ./compiler/lua54.lpt:90
return var -- ./compiler/lua54.lpt:91
end -- ./compiler/lua54.lpt:91
local nomacro = { -- ./compiler/lua54.lpt:95
["variables"] = {}, -- ./compiler/lua54.lpt:95
["functions"] = {} -- ./compiler/lua54.lpt:95
} -- ./compiler/lua54.lpt:95
local luaHeader = "" -- ./compiler/lua54.lpt:98
local function addLua(code) -- ./compiler/lua54.lpt:99
luaHeader = luaHeader .. (code) -- ./compiler/lua54.lpt:100
end -- ./compiler/lua54.lpt:100
local libraries = {} -- ./compiler/lua54.lpt:105
local function addBroadcast() -- ./compiler/lua54.lpt:107
if libraries["broadcast"] then -- ./compiler/lua54.lpt:108
return  -- ./compiler/lua54.lpt:108
end -- ./compiler/lua54.lpt:108
addLua((" -- ./compiler/lua54.lpt:110\
local function %sbroadcast(func, t) -- ./compiler/lua54.lpt:111\
    local new = {} -- ./compiler/lua54.lpt:112\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:113\
        local r1, r2 = func(v) -- ./compiler/lua54.lpt:114\
        if r2 == nil then -- ./compiler/lua54.lpt:115\
            new[k] = r1 -- ./compiler/lua54.lpt:116\
        else -- ./compiler/lua54.lpt:117\
            new[r1] = r2 -- ./compiler/lua54.lpt:118\
        end -- ./compiler/lua54.lpt:119\
    end -- ./compiler/lua54.lpt:120\
    if next(new) ~= nil then -- ./compiler/lua54.lpt:121\
        return new -- ./compiler/lua54.lpt:122\
    end -- ./compiler/lua54.lpt:123\
end -- ./compiler/lua54.lpt:124\
"):format(options["variablePrefix"], options["variablePrefix"])) -- ./compiler/lua54.lpt:125
libraries["broadcast"] = true -- ./compiler/lua54.lpt:127
end -- ./compiler/lua54.lpt:127
local function addBroadcastKV() -- ./compiler/lua54.lpt:130
if libraries["broadcastKV"] then -- ./compiler/lua54.lpt:131
return  -- ./compiler/lua54.lpt:131
end -- ./compiler/lua54.lpt:131
addLua((" -- ./compiler/lua54.lpt:133\
local function %sbroadcast_kv(func, t) -- ./compiler/lua54.lpt:134\
    local new = {} -- ./compiler/lua54.lpt:135\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:136\
        local r1, r2 = func(k, v) -- ./compiler/lua54.lpt:137\
        if r2 == nil then -- ./compiler/lua54.lpt:138\
            new[k] = r1 -- ./compiler/lua54.lpt:139\
        else -- ./compiler/lua54.lpt:140\
            new[r1] = r2 -- ./compiler/lua54.lpt:141\
        end -- ./compiler/lua54.lpt:142\
    end -- ./compiler/lua54.lpt:143\
    if next(new) ~= nil then -- ./compiler/lua54.lpt:144\
        return new -- ./compiler/lua54.lpt:145\
    end -- ./compiler/lua54.lpt:146\
end -- ./compiler/lua54.lpt:147\
"):format(options["variablePrefix"], options["variablePrefix"])) -- ./compiler/lua54.lpt:148
libraries["broadcastKV"] = true -- ./compiler/lua54.lpt:150
end -- ./compiler/lua54.lpt:150
local function addFilter() -- ./compiler/lua54.lpt:153
if libraries["filter"] then -- ./compiler/lua54.lpt:154
return  -- ./compiler/lua54.lpt:154
end -- ./compiler/lua54.lpt:154
addLua((" -- ./compiler/lua54.lpt:156\
local function %sfilter(predicate, t) -- ./compiler/lua54.lpt:157\
    local new = {} -- ./compiler/lua54.lpt:158\
    local i = 1 -- ./compiler/lua54.lpt:159\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:160\
        if predicate(v) then -- ./compiler/lua54.lpt:161\
            if type(k) == 'number' then -- ./compiler/lua54.lpt:162\
                new[i] = v -- ./compiler/lua54.lpt:163\
                i = i + 1 -- ./compiler/lua54.lpt:164\
            else -- ./compiler/lua54.lpt:165\
                new[k] = v -- ./compiler/lua54.lpt:166\
            end -- ./compiler/lua54.lpt:167\
        end -- ./compiler/lua54.lpt:168\
    end -- ./compiler/lua54.lpt:169\
    return new -- ./compiler/lua54.lpt:170\
end -- ./compiler/lua54.lpt:171\
"):format(options["variablePrefix"])) -- ./compiler/lua54.lpt:172
libraries["filter"] = true -- ./compiler/lua54.lpt:174
end -- ./compiler/lua54.lpt:174
local function addFilterKV() -- ./compiler/lua54.lpt:177
if libraries["filterKV"] then -- ./compiler/lua54.lpt:178
return  -- ./compiler/lua54.lpt:178
end -- ./compiler/lua54.lpt:178
addLua((" -- ./compiler/lua54.lpt:180\
local function %sfilter_kv(predicate, t) -- ./compiler/lua54.lpt:181\
    local new = {} -- ./compiler/lua54.lpt:182\
    local i = 1 -- ./compiler/lua54.lpt:183\
    for k, v in pairs(t) do -- ./compiler/lua54.lpt:184\
        if predicate(k, v) then -- ./compiler/lua54.lpt:185\
            if type(k) == 'number' then -- ./compiler/lua54.lpt:186\
                new[i] = v -- ./compiler/lua54.lpt:187\
                i = i + 1 -- ./compiler/lua54.lpt:188\
            else -- ./compiler/lua54.lpt:189\
                new[k] = v -- ./compiler/lua54.lpt:190\
            end -- ./compiler/lua54.lpt:191\
        end -- ./compiler/lua54.lpt:192\
    end -- ./compiler/lua54.lpt:193\
    return new -- ./compiler/lua54.lpt:194\
end -- ./compiler/lua54.lpt:195\
"):format(options["variablePrefix"])) -- ./compiler/lua54.lpt:196
libraries["filterKV"] = true -- ./compiler/lua54.lpt:198
end -- ./compiler/lua54.lpt:198
local required = {} -- ./compiler/lua54.lpt:203
local requireStr = "" -- ./compiler/lua54.lpt:204
local function addRequire(mod, name, field) -- ./compiler/lua54.lpt:206
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.lpt:207
if not required[req] then -- ./compiler/lua54.lpt:208
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.lpt:209
required[req] = true -- ./compiler/lua54.lpt:210
end -- ./compiler/lua54.lpt:210
end -- ./compiler/lua54.lpt:210
local loop = { -- ./compiler/lua54.lpt:216
"While", -- ./compiler/lua54.lpt:216
"Repeat", -- ./compiler/lua54.lpt:216
"Fornum", -- ./compiler/lua54.lpt:216
"Forin", -- ./compiler/lua54.lpt:216
"WhileExpr", -- ./compiler/lua54.lpt:216
"RepeatExpr", -- ./compiler/lua54.lpt:216
"FornumExpr", -- ./compiler/lua54.lpt:216
"ForinExpr" -- ./compiler/lua54.lpt:216
} -- ./compiler/lua54.lpt:216
local func = { -- ./compiler/lua54.lpt:217
"Function", -- ./compiler/lua54.lpt:217
"TableCompr", -- ./compiler/lua54.lpt:217
"DoExpr", -- ./compiler/lua54.lpt:217
"WhileExpr", -- ./compiler/lua54.lpt:217
"RepeatExpr", -- ./compiler/lua54.lpt:217
"IfExpr", -- ./compiler/lua54.lpt:217
"FornumExpr", -- ./compiler/lua54.lpt:217
"ForinExpr" -- ./compiler/lua54.lpt:217
} -- ./compiler/lua54.lpt:217
local function any(list, tags, nofollow) -- ./compiler/lua54.lpt:221
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:221
local tagsCheck = {} -- ./compiler/lua54.lpt:222
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:223
tagsCheck[tag] = true -- ./compiler/lua54.lpt:224
end -- ./compiler/lua54.lpt:224
local nofollowCheck = {} -- ./compiler/lua54.lpt:226
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:227
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:228
end -- ./compiler/lua54.lpt:228
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:230
if type(node) == "table" then -- ./compiler/lua54.lpt:231
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:232
return node -- ./compiler/lua54.lpt:233
end -- ./compiler/lua54.lpt:233
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:235
local r = any(node, tags, nofollow) -- ./compiler/lua54.lpt:236
if r then -- ./compiler/lua54.lpt:237
return r -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
end -- ./compiler/lua54.lpt:237
return nil -- ./compiler/lua54.lpt:241
end -- ./compiler/lua54.lpt:241
local function search(list, tags, nofollow) -- ./compiler/lua54.lpt:246
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:246
local tagsCheck = {} -- ./compiler/lua54.lpt:247
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:248
tagsCheck[tag] = true -- ./compiler/lua54.lpt:249
end -- ./compiler/lua54.lpt:249
local nofollowCheck = {} -- ./compiler/lua54.lpt:251
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:252
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:253
end -- ./compiler/lua54.lpt:253
local found = {} -- ./compiler/lua54.lpt:255
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:256
if type(node) == "table" then -- ./compiler/lua54.lpt:257
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:258
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.lpt:259
table["insert"](found, n) -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:263
table["insert"](found, node) -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
end -- ./compiler/lua54.lpt:264
return found -- ./compiler/lua54.lpt:268
end -- ./compiler/lua54.lpt:268
local function all(list, tags) -- ./compiler/lua54.lpt:272
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:273
local ok = false -- ./compiler/lua54.lpt:274
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:275
if node["tag"] == tag then -- ./compiler/lua54.lpt:276
ok = true -- ./compiler/lua54.lpt:277
break -- ./compiler/lua54.lpt:278
end -- ./compiler/lua54.lpt:278
end -- ./compiler/lua54.lpt:278
if not ok then -- ./compiler/lua54.lpt:281
return false -- ./compiler/lua54.lpt:282
end -- ./compiler/lua54.lpt:282
end -- ./compiler/lua54.lpt:282
return true -- ./compiler/lua54.lpt:285
end -- ./compiler/lua54.lpt:285
local tags -- ./compiler/lua54.lpt:290
local function lua(ast, forceTag, ...) -- ./compiler/lua54.lpt:292
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.lpt:293
lastInputPos = ast["pos"] -- ./compiler/lua54.lpt:294
end -- ./compiler/lua54.lpt:294
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.lpt:296
end -- ./compiler/lua54.lpt:296
local UNPACK = function(list, i, j) -- ./compiler/lua54.lpt:301
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.lpt:302
end -- ./compiler/lua54.lpt:302
local APPEND = function(t, toAppend) -- ./compiler/lua54.lpt:304
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.lpt:305
end -- ./compiler/lua54.lpt:305
local CONTINUE_START = function() -- ./compiler/lua54.lpt:307
return "do" .. indent() -- ./compiler/lua54.lpt:308
end -- ./compiler/lua54.lpt:308
local CONTINUE_STOP = function() -- ./compiler/lua54.lpt:310
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.lpt:311
end -- ./compiler/lua54.lpt:311
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.lpt:314
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.lpt:314
if noLocal == nil then noLocal = false end -- ./compiler/lua54.lpt:314
local vars = {} -- ./compiler/lua54.lpt:315
local values = {} -- ./compiler/lua54.lpt:316
for _, list in ipairs(destructured) do -- ./compiler/lua54.lpt:317
for _, v in ipairs(list) do -- ./compiler/lua54.lpt:318
local var, val -- ./compiler/lua54.lpt:319
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.lpt:320
var = v -- ./compiler/lua54.lpt:321
val = { -- ./compiler/lua54.lpt:322
["tag"] = "Index", -- ./compiler/lua54.lpt:322
{ -- ./compiler/lua54.lpt:322
["tag"] = "Id", -- ./compiler/lua54.lpt:322
list["id"] -- ./compiler/lua54.lpt:322
}, -- ./compiler/lua54.lpt:322
{ -- ./compiler/lua54.lpt:322
["tag"] = "String", -- ./compiler/lua54.lpt:322
v[1] -- ./compiler/lua54.lpt:322
} -- ./compiler/lua54.lpt:322
} -- ./compiler/lua54.lpt:322
elseif v["tag"] == "Pair" then -- ./compiler/lua54.lpt:323
var = v[2] -- ./compiler/lua54.lpt:324
val = { -- ./compiler/lua54.lpt:325
["tag"] = "Index", -- ./compiler/lua54.lpt:325
{ -- ./compiler/lua54.lpt:325
["tag"] = "Id", -- ./compiler/lua54.lpt:325
list["id"] -- ./compiler/lua54.lpt:325
}, -- ./compiler/lua54.lpt:325
v[1] -- ./compiler/lua54.lpt:325
} -- ./compiler/lua54.lpt:325
else -- ./compiler/lua54.lpt:325
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.lpt:327
end -- ./compiler/lua54.lpt:327
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.lpt:329
val = { -- ./compiler/lua54.lpt:330
["tag"] = "Op", -- ./compiler/lua54.lpt:330
destructured["rightOp"], -- ./compiler/lua54.lpt:330
var, -- ./compiler/lua54.lpt:330
{ -- ./compiler/lua54.lpt:330
["tag"] = "Op", -- ./compiler/lua54.lpt:330
destructured["leftOp"], -- ./compiler/lua54.lpt:330
val, -- ./compiler/lua54.lpt:330
var -- ./compiler/lua54.lpt:330
} -- ./compiler/lua54.lpt:330
} -- ./compiler/lua54.lpt:330
elseif destructured["rightOp"] then -- ./compiler/lua54.lpt:331
val = { -- ./compiler/lua54.lpt:332
["tag"] = "Op", -- ./compiler/lua54.lpt:332
destructured["rightOp"], -- ./compiler/lua54.lpt:332
var, -- ./compiler/lua54.lpt:332
val -- ./compiler/lua54.lpt:332
} -- ./compiler/lua54.lpt:332
elseif destructured["leftOp"] then -- ./compiler/lua54.lpt:333
val = { -- ./compiler/lua54.lpt:334
["tag"] = "Op", -- ./compiler/lua54.lpt:334
destructured["leftOp"], -- ./compiler/lua54.lpt:334
val, -- ./compiler/lua54.lpt:334
var -- ./compiler/lua54.lpt:334
} -- ./compiler/lua54.lpt:334
end -- ./compiler/lua54.lpt:334
table["insert"](vars, lua(var)) -- ./compiler/lua54.lpt:336
table["insert"](values, lua(val)) -- ./compiler/lua54.lpt:337
end -- ./compiler/lua54.lpt:337
end -- ./compiler/lua54.lpt:337
if # vars > 0 then -- ./compiler/lua54.lpt:340
local decl = noLocal and "" or "local " -- ./compiler/lua54.lpt:341
if newlineAfter then -- ./compiler/lua54.lpt:342
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.lpt:343
else -- ./compiler/lua54.lpt:343
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.lpt:345
end -- ./compiler/lua54.lpt:345
else -- ./compiler/lua54.lpt:345
return "" -- ./compiler/lua54.lpt:348
end -- ./compiler/lua54.lpt:348
end -- ./compiler/lua54.lpt:348
local BROADCAST = function(t, use_kv) -- ./compiler/lua54.lpt:352
((use_kv and addBroadcastKV) or addBroadcast)() -- ./compiler/lua54.lpt:353
return table["concat"]({ -- ./compiler/lua54.lpt:354
options["variablePrefix"], -- ./compiler/lua54.lpt:354
(use_kv and "broadcast_kv(") or "broadcast(", -- ./compiler/lua54.lpt:354
lua(t[1]), -- ./compiler/lua54.lpt:354
",", -- ./compiler/lua54.lpt:354
lua(t[2]), -- ./compiler/lua54.lpt:354
")" -- ./compiler/lua54.lpt:354
}) -- ./compiler/lua54.lpt:354
end -- ./compiler/lua54.lpt:354
local FILTER = function(t, use_kv) -- ./compiler/lua54.lpt:356
((use_kv and addFilterKV) or addFilter)() -- ./compiler/lua54.lpt:357
return table["concat"]({ -- ./compiler/lua54.lpt:358
options["variablePrefix"], -- ./compiler/lua54.lpt:358
(use_kv and "filter_kv(") or "filter(", -- ./compiler/lua54.lpt:358
lua(t[1]), -- ./compiler/lua54.lpt:358
",", -- ./compiler/lua54.lpt:358
lua(t[2]), -- ./compiler/lua54.lpt:358
")" -- ./compiler/lua54.lpt:358
}) -- ./compiler/lua54.lpt:358
end -- ./compiler/lua54.lpt:358
tags = setmetatable({ -- ./compiler/lua54.lpt:363
["Block"] = function(t) -- ./compiler/lua54.lpt:366
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.lpt:367
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.lpt:368
hasPush["tag"] = "Return" -- ./compiler/lua54.lpt:369
hasPush = false -- ./compiler/lua54.lpt:370
end -- ./compiler/lua54.lpt:370
local r = push("scope", {}) -- ./compiler/lua54.lpt:372
if hasPush then -- ./compiler/lua54.lpt:373
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:374
end -- ./compiler/lua54.lpt:374
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:376
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:377
end -- ./compiler/lua54.lpt:377
if t[# t] then -- ./compiler/lua54.lpt:379
r = r .. (lua(t[# t])) -- ./compiler/lua54.lpt:380
end -- ./compiler/lua54.lpt:380
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:382
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.lpt:383
end -- ./compiler/lua54.lpt:383
return r .. pop("scope") -- ./compiler/lua54.lpt:385
end, -- ./compiler/lua54.lpt:385
["Do"] = function(t) -- ./compiler/lua54.lpt:391
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.lpt:392
end, -- ./compiler/lua54.lpt:392
["Set"] = function(t) -- ./compiler/lua54.lpt:395
local expr = t[# t] -- ./compiler/lua54.lpt:397
local vars, values = {}, {} -- ./compiler/lua54.lpt:398
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.lpt:399
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:400
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.lpt:401
table["insert"](destructuringVars, n) -- ./compiler/lua54.lpt:402
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.lpt:403
else -- ./compiler/lua54.lpt:403
table["insert"](vars, n) -- ./compiler/lua54.lpt:405
table["insert"](values, expr[i]) -- ./compiler/lua54.lpt:406
end -- ./compiler/lua54.lpt:406
end -- ./compiler/lua54.lpt:406
if # t == 2 or # t == 3 then -- ./compiler/lua54.lpt:410
local r = "" -- ./compiler/lua54.lpt:411
if # vars > 0 then -- ./compiler/lua54.lpt:412
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.lpt:413
end -- ./compiler/lua54.lpt:413
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:415
local destructured = {} -- ./compiler/lua54.lpt:416
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:417
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:418
end -- ./compiler/lua54.lpt:418
return r -- ./compiler/lua54.lpt:420
elseif # t == 4 then -- ./compiler/lua54.lpt:421
if t[3] == "=" then -- ./compiler/lua54.lpt:422
local r = "" -- ./compiler/lua54.lpt:423
if # vars > 0 then -- ./compiler/lua54.lpt:424
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:425
t[2], -- ./compiler/lua54.lpt:425
vars[1], -- ./compiler/lua54.lpt:425
{ -- ./compiler/lua54.lpt:425
["tag"] = "Paren", -- ./compiler/lua54.lpt:425
values[1] -- ./compiler/lua54.lpt:425
} -- ./compiler/lua54.lpt:425
}, "Op")) -- ./compiler/lua54.lpt:425
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.lpt:426
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:427
t[2], -- ./compiler/lua54.lpt:427
vars[i], -- ./compiler/lua54.lpt:427
{ -- ./compiler/lua54.lpt:427
["tag"] = "Paren", -- ./compiler/lua54.lpt:427
values[i] -- ./compiler/lua54.lpt:427
} -- ./compiler/lua54.lpt:427
}, "Op")) -- ./compiler/lua54.lpt:427
end -- ./compiler/lua54.lpt:427
end -- ./compiler/lua54.lpt:427
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:430
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.lpt:431
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:432
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:433
end -- ./compiler/lua54.lpt:433
return r -- ./compiler/lua54.lpt:435
else -- ./compiler/lua54.lpt:435
local r = "" -- ./compiler/lua54.lpt:437
if # vars > 0 then -- ./compiler/lua54.lpt:438
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:439
t[3], -- ./compiler/lua54.lpt:439
{ -- ./compiler/lua54.lpt:439
["tag"] = "Paren", -- ./compiler/lua54.lpt:439
values[1] -- ./compiler/lua54.lpt:439
}, -- ./compiler/lua54.lpt:439
vars[1] -- ./compiler/lua54.lpt:439
}, "Op")) -- ./compiler/lua54.lpt:439
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.lpt:440
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:441
t[3], -- ./compiler/lua54.lpt:441
{ -- ./compiler/lua54.lpt:441
["tag"] = "Paren", -- ./compiler/lua54.lpt:441
values[i] -- ./compiler/lua54.lpt:441
}, -- ./compiler/lua54.lpt:441
vars[i] -- ./compiler/lua54.lpt:441
}, "Op")) -- ./compiler/lua54.lpt:441
end -- ./compiler/lua54.lpt:441
end -- ./compiler/lua54.lpt:441
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:444
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.lpt:445
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:446
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:447
end -- ./compiler/lua54.lpt:447
return r -- ./compiler/lua54.lpt:449
end -- ./compiler/lua54.lpt:449
else -- ./compiler/lua54.lpt:449
local r = "" -- ./compiler/lua54.lpt:452
if # vars > 0 then -- ./compiler/lua54.lpt:453
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:454
t[2], -- ./compiler/lua54.lpt:454
vars[1], -- ./compiler/lua54.lpt:454
{ -- ./compiler/lua54.lpt:454
["tag"] = "Op", -- ./compiler/lua54.lpt:454
t[4], -- ./compiler/lua54.lpt:454
{ -- ./compiler/lua54.lpt:454
["tag"] = "Paren", -- ./compiler/lua54.lpt:454
values[1] -- ./compiler/lua54.lpt:454
}, -- ./compiler/lua54.lpt:454
vars[1] -- ./compiler/lua54.lpt:454
} -- ./compiler/lua54.lpt:454
}, "Op")) -- ./compiler/lua54.lpt:454
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.lpt:455
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:456
t[2], -- ./compiler/lua54.lpt:456
vars[i], -- ./compiler/lua54.lpt:456
{ -- ./compiler/lua54.lpt:456
["tag"] = "Op", -- ./compiler/lua54.lpt:456
t[4], -- ./compiler/lua54.lpt:456
{ -- ./compiler/lua54.lpt:456
["tag"] = "Paren", -- ./compiler/lua54.lpt:456
values[i] -- ./compiler/lua54.lpt:456
}, -- ./compiler/lua54.lpt:456
vars[i] -- ./compiler/lua54.lpt:456
} -- ./compiler/lua54.lpt:456
}, "Op")) -- ./compiler/lua54.lpt:456
end -- ./compiler/lua54.lpt:456
end -- ./compiler/lua54.lpt:456
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:459
local destructured = { -- ./compiler/lua54.lpt:460
["rightOp"] = t[2], -- ./compiler/lua54.lpt:460
["leftOp"] = t[4] -- ./compiler/lua54.lpt:460
} -- ./compiler/lua54.lpt:460
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:461
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:462
end -- ./compiler/lua54.lpt:462
return r -- ./compiler/lua54.lpt:464
end -- ./compiler/lua54.lpt:464
end, -- ./compiler/lua54.lpt:464
["AppendSet"] = function(t) -- ./compiler/lua54.lpt:468
local expr = t[# t] -- ./compiler/lua54.lpt:470
local r = {} -- ./compiler/lua54.lpt:471
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:472
local value = expr[i] -- ./compiler/lua54.lpt:473
if value == nil then -- ./compiler/lua54.lpt:474
break -- ./compiler/lua54.lpt:475
end -- ./compiler/lua54.lpt:475
local var = lua(n) -- ./compiler/lua54.lpt:478
r[i] = { -- ./compiler/lua54.lpt:479
var, -- ./compiler/lua54.lpt:479
"[#", -- ./compiler/lua54.lpt:479
var, -- ./compiler/lua54.lpt:479
"+1] = ", -- ./compiler/lua54.lpt:479
lua(value) -- ./compiler/lua54.lpt:479
} -- ./compiler/lua54.lpt:479
r[i] = table["concat"](r[i]) -- ./compiler/lua54.lpt:480
end -- ./compiler/lua54.lpt:480
return table["concat"](r, "; ") -- ./compiler/lua54.lpt:482
end, -- ./compiler/lua54.lpt:482
["While"] = function(t) -- ./compiler/lua54.lpt:485
local r = "" -- ./compiler/lua54.lpt:486
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.lpt:487
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:488
if # lets > 0 then -- ./compiler/lua54.lpt:489
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:490
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:491
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:492
end -- ./compiler/lua54.lpt:492
end -- ./compiler/lua54.lpt:492
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.lpt:495
if # lets > 0 then -- ./compiler/lua54.lpt:496
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:497
end -- ./compiler/lua54.lpt:497
if hasContinue then -- ./compiler/lua54.lpt:499
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:500
end -- ./compiler/lua54.lpt:500
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:502
if hasContinue then -- ./compiler/lua54.lpt:503
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:504
end -- ./compiler/lua54.lpt:504
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:506
if # lets > 0 then -- ./compiler/lua54.lpt:507
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:508
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.lpt:509
end -- ./compiler/lua54.lpt:509
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.lpt:511
end -- ./compiler/lua54.lpt:511
return r -- ./compiler/lua54.lpt:513
end, -- ./compiler/lua54.lpt:513
["Repeat"] = function(t) -- ./compiler/lua54.lpt:516
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.lpt:517
local r = "repeat" .. indent() -- ./compiler/lua54.lpt:518
if hasContinue then -- ./compiler/lua54.lpt:519
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:520
end -- ./compiler/lua54.lpt:520
r = r .. (lua(t[1])) -- ./compiler/lua54.lpt:522
if hasContinue then -- ./compiler/lua54.lpt:523
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.lpt:526
return r -- ./compiler/lua54.lpt:527
end, -- ./compiler/lua54.lpt:527
["If"] = function(t) -- ./compiler/lua54.lpt:530
local r = "" -- ./compiler/lua54.lpt:531
local toClose = 0 -- ./compiler/lua54.lpt:532
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:533
if # lets > 0 then -- ./compiler/lua54.lpt:534
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:535
toClose = toClose + (1) -- ./compiler/lua54.lpt:536
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:537
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:538
end -- ./compiler/lua54.lpt:538
end -- ./compiler/lua54.lpt:538
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.lpt:541
for i = 3, # t - 1, 2 do -- ./compiler/lua54.lpt:542
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.lpt:543
if # lets > 0 then -- ./compiler/lua54.lpt:544
r = r .. ("else" .. indent()) -- ./compiler/lua54.lpt:545
toClose = toClose + (1) -- ./compiler/lua54.lpt:546
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:547
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:548
end -- ./compiler/lua54.lpt:548
else -- ./compiler/lua54.lpt:548
r = r .. ("else") -- ./compiler/lua54.lpt:551
end -- ./compiler/lua54.lpt:551
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.lpt:553
end -- ./compiler/lua54.lpt:553
if # t % 2 == 1 then -- ./compiler/lua54.lpt:555
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.lpt:556
end -- ./compiler/lua54.lpt:556
r = r .. ("end") -- ./compiler/lua54.lpt:558
for i = 1, toClose do -- ./compiler/lua54.lpt:559
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:560
end -- ./compiler/lua54.lpt:560
return r -- ./compiler/lua54.lpt:562
end, -- ./compiler/lua54.lpt:562
["Fornum"] = function(t) -- ./compiler/lua54.lpt:565
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.lpt:566
if # t == 5 then -- ./compiler/lua54.lpt:567
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.lpt:568
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.lpt:569
if hasContinue then -- ./compiler/lua54.lpt:570
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:571
end -- ./compiler/lua54.lpt:571
r = r .. (lua(t[5])) -- ./compiler/lua54.lpt:573
if hasContinue then -- ./compiler/lua54.lpt:574
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:575
end -- ./compiler/lua54.lpt:575
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:577
else -- ./compiler/lua54.lpt:577
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.lpt:579
r = r .. (" do" .. indent()) -- ./compiler/lua54.lpt:580
if hasContinue then -- ./compiler/lua54.lpt:581
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:582
end -- ./compiler/lua54.lpt:582
r = r .. (lua(t[4])) -- ./compiler/lua54.lpt:584
if hasContinue then -- ./compiler/lua54.lpt:585
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:586
end -- ./compiler/lua54.lpt:586
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:588
end -- ./compiler/lua54.lpt:588
end, -- ./compiler/lua54.lpt:588
["Forin"] = function(t) -- ./compiler/lua54.lpt:592
local destructured = {} -- ./compiler/lua54.lpt:593
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.lpt:594
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.lpt:595
if hasContinue then -- ./compiler/lua54.lpt:596
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:597
end -- ./compiler/lua54.lpt:597
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.lpt:599
if hasContinue then -- ./compiler/lua54.lpt:600
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:601
end -- ./compiler/lua54.lpt:601
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:603
end, -- ./compiler/lua54.lpt:603
["Local"] = function(t) -- ./compiler/lua54.lpt:606
local destructured = {} -- ./compiler/lua54.lpt:607
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:608
if t[2][1] then -- ./compiler/lua54.lpt:609
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:610
end -- ./compiler/lua54.lpt:610
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:612
end, -- ./compiler/lua54.lpt:612
["Let"] = function(t) -- ./compiler/lua54.lpt:615
local destructured = {} -- ./compiler/lua54.lpt:616
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:617
local r = "local " .. nameList -- ./compiler/lua54.lpt:618
if t[2][1] then -- ./compiler/lua54.lpt:619
if all(t[2], { -- ./compiler/lua54.lpt:620
"Nil", -- ./compiler/lua54.lpt:620
"Dots", -- ./compiler/lua54.lpt:620
"Boolean", -- ./compiler/lua54.lpt:620
"Number", -- ./compiler/lua54.lpt:620
"String" -- ./compiler/lua54.lpt:620
}) then -- ./compiler/lua54.lpt:620
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:621
else -- ./compiler/lua54.lpt:621
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:623
end -- ./compiler/lua54.lpt:623
end -- ./compiler/lua54.lpt:623
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:626
end, -- ./compiler/lua54.lpt:626
["Localrec"] = function(t) -- ./compiler/lua54.lpt:629
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.lpt:630
end, -- ./compiler/lua54.lpt:630
["Goto"] = function(t) -- ./compiler/lua54.lpt:633
return "goto " .. lua(t, "Id") -- ./compiler/lua54.lpt:634
end, -- ./compiler/lua54.lpt:634
["Label"] = function(t) -- ./compiler/lua54.lpt:637
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.lpt:638
end, -- ./compiler/lua54.lpt:638
["Return"] = function(t) -- ./compiler/lua54.lpt:641
local push = peek("push") -- ./compiler/lua54.lpt:642
if push then -- ./compiler/lua54.lpt:643
local r = "" -- ./compiler/lua54.lpt:644
for _, val in ipairs(t) do -- ./compiler/lua54.lpt:645
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.lpt:646
end -- ./compiler/lua54.lpt:646
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.lpt:648
else -- ./compiler/lua54.lpt:648
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.lpt:650
end -- ./compiler/lua54.lpt:650
end, -- ./compiler/lua54.lpt:650
["Push"] = function(t) -- ./compiler/lua54.lpt:654
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.lpt:655
r = "" -- ./compiler/lua54.lpt:656
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:657
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:658
end -- ./compiler/lua54.lpt:658
if t[# t] then -- ./compiler/lua54.lpt:660
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.lpt:661
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.lpt:662
else -- ./compiler/lua54.lpt:662
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.lpt:664
end -- ./compiler/lua54.lpt:664
end -- ./compiler/lua54.lpt:664
return r -- ./compiler/lua54.lpt:667
end, -- ./compiler/lua54.lpt:667
["Break"] = function() -- ./compiler/lua54.lpt:670
return "break" -- ./compiler/lua54.lpt:671
end, -- ./compiler/lua54.lpt:671
["Continue"] = function() -- ./compiler/lua54.lpt:674
return "goto " .. var("continue") -- ./compiler/lua54.lpt:675
end, -- ./compiler/lua54.lpt:675
["Nil"] = function() -- ./compiler/lua54.lpt:682
return "nil" -- ./compiler/lua54.lpt:683
end, -- ./compiler/lua54.lpt:683
["Dots"] = function() -- ./compiler/lua54.lpt:686
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:687
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.lpt:688
nomacro["variables"]["..."] = true -- ./compiler/lua54.lpt:689
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.lpt:690
nomacro["variables"]["..."] = nil -- ./compiler/lua54.lpt:691
return r -- ./compiler/lua54.lpt:692
else -- ./compiler/lua54.lpt:692
return "..." -- ./compiler/lua54.lpt:694
end -- ./compiler/lua54.lpt:694
end, -- ./compiler/lua54.lpt:694
["Boolean"] = function(t) -- ./compiler/lua54.lpt:698
return tostring(t[1]) -- ./compiler/lua54.lpt:699
end, -- ./compiler/lua54.lpt:699
["Number"] = function(t) -- ./compiler/lua54.lpt:702
local n = tostring(t[1]):gsub("_", "") -- ./compiler/lua54.lpt:703
do -- ./compiler/lua54.lpt:705
local match -- ./compiler/lua54.lpt:705
match = n:match("^0b(.*)") -- ./compiler/lua54.lpt:705
if match then -- ./compiler/lua54.lpt:705
n = tostring(tonumber(match, 2)) -- ./compiler/lua54.lpt:706
end -- ./compiler/lua54.lpt:706
end -- ./compiler/lua54.lpt:706
return n -- ./compiler/lua54.lpt:708
end, -- ./compiler/lua54.lpt:708
["String"] = function(t) -- ./compiler/lua54.lpt:711
return ("%q"):format(t[1]) -- ./compiler/lua54.lpt:712
end, -- ./compiler/lua54.lpt:712
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.lpt:715
local r = "(" -- ./compiler/lua54.lpt:716
local decl = {} -- ./compiler/lua54.lpt:717
if t[1][1] then -- ./compiler/lua54.lpt:718
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:719
local id = lua(t[1][1][1]) -- ./compiler/lua54.lpt:720
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:721
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.lpt:722
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:723
r = r .. (id) -- ./compiler/lua54.lpt:724
else -- ./compiler/lua54.lpt:724
r = r .. (lua(t[1][1])) -- ./compiler/lua54.lpt:726
end -- ./compiler/lua54.lpt:726
for i = 2, # t[1], 1 do -- ./compiler/lua54.lpt:728
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:729
local id = lua(t[1][i][1]) -- ./compiler/lua54.lpt:730
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:731
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.lpt:732
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:733
r = r .. (", " .. id) -- ./compiler/lua54.lpt:734
else -- ./compiler/lua54.lpt:734
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
end -- ./compiler/lua54.lpt:736
r = r .. (")" .. indent()) -- ./compiler/lua54.lpt:740
for _, d in ipairs(decl) do -- ./compiler/lua54.lpt:741
r = r .. (d .. newline()) -- ./compiler/lua54.lpt:742
end -- ./compiler/lua54.lpt:742
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.lpt:744
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.lpt:745
end -- ./compiler/lua54.lpt:745
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.lpt:747
if hasPush then -- ./compiler/lua54.lpt:748
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:749
else -- ./compiler/lua54.lpt:749
push("push", false) -- ./compiler/lua54.lpt:751
end -- ./compiler/lua54.lpt:751
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:753
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:754
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:755
end -- ./compiler/lua54.lpt:755
pop("push") -- ./compiler/lua54.lpt:757
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:758
end, -- ./compiler/lua54.lpt:758
["Function"] = function(t) -- ./compiler/lua54.lpt:760
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.lpt:761
end, -- ./compiler/lua54.lpt:761
["Pair"] = function(t) -- ./compiler/lua54.lpt:764
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.lpt:765
end, -- ./compiler/lua54.lpt:765
["Table"] = function(t) -- ./compiler/lua54.lpt:767
if # t == 0 then -- ./compiler/lua54.lpt:768
return "{}" -- ./compiler/lua54.lpt:769
elseif # t == 1 then -- ./compiler/lua54.lpt:770
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.lpt:771
else -- ./compiler/lua54.lpt:771
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.lpt:773
end -- ./compiler/lua54.lpt:773
end, -- ./compiler/lua54.lpt:773
["TableCompr"] = function(t) -- ./compiler/lua54.lpt:777
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.lpt:778
end, -- ./compiler/lua54.lpt:778
["Op"] = function(t) -- ./compiler/lua54.lpt:781
local r -- ./compiler/lua54.lpt:782
if # t == 2 then -- ./compiler/lua54.lpt:783
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:784
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.lpt:785
else -- ./compiler/lua54.lpt:785
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.lpt:787
end -- ./compiler/lua54.lpt:787
else -- ./compiler/lua54.lpt:787
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:790
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.lpt:791
else -- ./compiler/lua54.lpt:791
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.lpt:793
end -- ./compiler/lua54.lpt:793
end -- ./compiler/lua54.lpt:793
return r -- ./compiler/lua54.lpt:796
end, -- ./compiler/lua54.lpt:796
["Paren"] = function(t) -- ./compiler/lua54.lpt:799
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.lpt:800
end, -- ./compiler/lua54.lpt:800
["MethodStub"] = function(t) -- ./compiler/lua54.lpt:803
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:809
end, -- ./compiler/lua54.lpt:809
["SafeMethodStub"] = function(t) -- ./compiler/lua54.lpt:812
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:819
end, -- ./compiler/lua54.lpt:819
["LetExpr"] = function(t) -- ./compiler/lua54.lpt:826
return lua(t[1][1]) -- ./compiler/lua54.lpt:827
end, -- ./compiler/lua54.lpt:827
["_statexpr"] = function(t, stat) -- ./compiler/lua54.lpt:831
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.lpt:832
local r = "(function()" .. indent() -- ./compiler/lua54.lpt:833
if hasPush then -- ./compiler/lua54.lpt:834
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:835
else -- ./compiler/lua54.lpt:835
push("push", false) -- ./compiler/lua54.lpt:837
end -- ./compiler/lua54.lpt:837
r = r .. (lua(t, stat)) -- ./compiler/lua54.lpt:839
if hasPush then -- ./compiler/lua54.lpt:840
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:841
end -- ./compiler/lua54.lpt:841
pop("push") -- ./compiler/lua54.lpt:843
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.lpt:844
return r -- ./compiler/lua54.lpt:845
end, -- ./compiler/lua54.lpt:845
["DoExpr"] = function(t) -- ./compiler/lua54.lpt:848
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.lpt:849
t[# t]["tag"] = "Return" -- ./compiler/lua54.lpt:850
end -- ./compiler/lua54.lpt:850
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.lpt:852
end, -- ./compiler/lua54.lpt:852
["WhileExpr"] = function(t) -- ./compiler/lua54.lpt:855
return lua(t, "_statexpr", "While") -- ./compiler/lua54.lpt:856
end, -- ./compiler/lua54.lpt:856
["RepeatExpr"] = function(t) -- ./compiler/lua54.lpt:859
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.lpt:860
end, -- ./compiler/lua54.lpt:860
["IfExpr"] = function(t) -- ./compiler/lua54.lpt:863
for i = 2, # t do -- ./compiler/lua54.lpt:864
local block = t[i] -- ./compiler/lua54.lpt:865
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.lpt:866
block[# block]["tag"] = "Return" -- ./compiler/lua54.lpt:867
end -- ./compiler/lua54.lpt:867
end -- ./compiler/lua54.lpt:867
return lua(t, "_statexpr", "If") -- ./compiler/lua54.lpt:870
end, -- ./compiler/lua54.lpt:870
["FornumExpr"] = function(t) -- ./compiler/lua54.lpt:873
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.lpt:874
end, -- ./compiler/lua54.lpt:874
["ForinExpr"] = function(t) -- ./compiler/lua54.lpt:877
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.lpt:878
end, -- ./compiler/lua54.lpt:878
["Call"] = function(t) -- ./compiler/lua54.lpt:885
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:886
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:887
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.lpt:888
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.lpt:889
local replacement = macro["replacement"] -- ./compiler/lua54.lpt:890
local r -- ./compiler/lua54.lpt:891
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.lpt:892
if type(replacement) == "function" then -- ./compiler/lua54.lpt:893
local args = {} -- ./compiler/lua54.lpt:894
for i = 2, # t do -- ./compiler/lua54.lpt:895
table["insert"](args, lua(t[i])) -- ./compiler/lua54.lpt:896
end -- ./compiler/lua54.lpt:896
r = replacement(unpack(args)) -- ./compiler/lua54.lpt:898
else -- ./compiler/lua54.lpt:898
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.lpt:900
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.lpt:901
if arg["tag"] == "Dots" then -- ./compiler/lua54.lpt:902
macroargs["..."] = (function() -- ./compiler/lua54.lpt:903
local self = {} -- ./compiler/lua54.lpt:903
for j = i + 1, # t do -- ./compiler/lua54.lpt:903
self[#self+1] = t[j] -- ./compiler/lua54.lpt:903
end -- ./compiler/lua54.lpt:903
return self -- ./compiler/lua54.lpt:903
end)() -- ./compiler/lua54.lpt:903
elseif arg["tag"] == "Id" then -- ./compiler/lua54.lpt:904
if t[i + 1] == nil then -- ./compiler/lua54.lpt:905
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.lpt:906
end -- ./compiler/lua54.lpt:906
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.lpt:908
else -- ./compiler/lua54.lpt:908
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.lpt:910
end -- ./compiler/lua54.lpt:910
end -- ./compiler/lua54.lpt:910
push("macroargs", macroargs) -- ./compiler/lua54.lpt:913
r = lua(replacement) -- ./compiler/lua54.lpt:914
pop("macroargs") -- ./compiler/lua54.lpt:915
end -- ./compiler/lua54.lpt:915
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.lpt:917
return r -- ./compiler/lua54.lpt:918
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.lpt:919
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.lpt:920
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:921
else -- ./compiler/lua54.lpt:921
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:923
end -- ./compiler/lua54.lpt:923
else -- ./compiler/lua54.lpt:923
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:926
end -- ./compiler/lua54.lpt:926
end, -- ./compiler/lua54.lpt:926
["SafeCall"] = function(t) -- ./compiler/lua54.lpt:930
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:931
return lua(t, "SafeIndex") -- ./compiler/lua54.lpt:932
else -- ./compiler/lua54.lpt:932
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.lpt:934
end -- ./compiler/lua54.lpt:934
end, -- ./compiler/lua54.lpt:934
["Broadcast"] = function(t) -- ./compiler/lua54.lpt:940
return BROADCAST(t, false) -- ./compiler/lua54.lpt:941
end, -- ./compiler/lua54.lpt:941
["BroadcastKV"] = function(t) -- ./compiler/lua54.lpt:943
return BROADCAST(t, true) -- ./compiler/lua54.lpt:944
end, -- ./compiler/lua54.lpt:944
["Filter"] = function(t) -- ./compiler/lua54.lpt:946
return FILTER(t, false) -- ./compiler/lua54.lpt:947
end, -- ./compiler/lua54.lpt:947
["FilterKV"] = function(t) -- ./compiler/lua54.lpt:949
return FILTER(t, true) -- ./compiler/lua54.lpt:950
end, -- ./compiler/lua54.lpt:950
["StringFormat"] = function(t) -- ./compiler/lua54.lpt:955
local args = {} -- ./compiler/lua54.lpt:956
for i, v in ipairs(t[2]) do -- ./compiler/lua54.lpt:957
args[i] = lua(v) -- ./compiler/lua54.lpt:958
end -- ./compiler/lua54.lpt:958
local r = { -- ./compiler/lua54.lpt:960
"(", -- ./compiler/lua54.lpt:960
"string.format(", -- ./compiler/lua54.lpt:960
("%q"):format(t[1]) -- ./compiler/lua54.lpt:960
} -- ./compiler/lua54.lpt:960
if # args ~= 0 then -- ./compiler/lua54.lpt:961
r[# r + 1] = ", " -- ./compiler/lua54.lpt:962
r[# r + 1] = table["concat"](args, ", ") -- ./compiler/lua54.lpt:963
r[# r + 1] = "))" -- ./compiler/lua54.lpt:964
end -- ./compiler/lua54.lpt:964
return table["concat"](r) -- ./compiler/lua54.lpt:966
end, -- ./compiler/lua54.lpt:966
["TableUnpack"] = function(t) -- ./compiler/lua54.lpt:971
local args = {} -- ./compiler/lua54.lpt:972
for i, v in ipairs(t[2]) do -- ./compiler/lua54.lpt:973
args[i] = lua(v) -- ./compiler/lua54.lpt:974
end -- ./compiler/lua54.lpt:974
return UNPACK(lua(t[1]), args[1], args[2]) -- ./compiler/lua54.lpt:976
end, -- ./compiler/lua54.lpt:976
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.lpt:982
if start == nil then start = 1 end -- ./compiler/lua54.lpt:982
local r -- ./compiler/lua54.lpt:983
if t[start] then -- ./compiler/lua54.lpt:984
r = lua(t[start]) -- ./compiler/lua54.lpt:985
for i = start + 1, # t, 1 do -- ./compiler/lua54.lpt:986
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.lpt:987
end -- ./compiler/lua54.lpt:987
else -- ./compiler/lua54.lpt:987
r = "" -- ./compiler/lua54.lpt:990
end -- ./compiler/lua54.lpt:990
return r -- ./compiler/lua54.lpt:992
end, -- ./compiler/lua54.lpt:992
["Id"] = function(t) -- ./compiler/lua54.lpt:995
local r = t[1] -- ./compiler/lua54.lpt:996
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:997
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.lpt:998
nomacro["variables"][t[1]] = true -- ./compiler/lua54.lpt:999
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.lpt:1000
r = lua(macroargs[t[1]]) -- ./compiler/lua54.lpt:1001
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.lpt:1002
local macro = macros["variables"][t[1]] -- ./compiler/lua54.lpt:1003
if type(macro) == "function" then -- ./compiler/lua54.lpt:1004
r = macro() -- ./compiler/lua54.lpt:1005
else -- ./compiler/lua54.lpt:1005
r = lua(macro) -- ./compiler/lua54.lpt:1007
end -- ./compiler/lua54.lpt:1007
end -- ./compiler/lua54.lpt:1007
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.lpt:1010
end -- ./compiler/lua54.lpt:1010
return r -- ./compiler/lua54.lpt:1012
end, -- ./compiler/lua54.lpt:1012
["AttributeId"] = function(t) -- ./compiler/lua54.lpt:1015
if t[2] then -- ./compiler/lua54.lpt:1016
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.lpt:1017
else -- ./compiler/lua54.lpt:1017
return t[1] -- ./compiler/lua54.lpt:1019
end -- ./compiler/lua54.lpt:1019
end, -- ./compiler/lua54.lpt:1019
["DestructuringId"] = function(t) -- ./compiler/lua54.lpt:1023
if t["id"] then -- ./compiler/lua54.lpt:1024
return t["id"] -- ./compiler/lua54.lpt:1025
else -- ./compiler/lua54.lpt:1025
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.lpt:1027
local vars = { ["id"] = tmp() } -- ./compiler/lua54.lpt:1028
for j = 1, # t, 1 do -- ./compiler/lua54.lpt:1029
table["insert"](vars, t[j]) -- ./compiler/lua54.lpt:1030
end -- ./compiler/lua54.lpt:1030
table["insert"](d, vars) -- ./compiler/lua54.lpt:1032
t["id"] = vars["id"] -- ./compiler/lua54.lpt:1033
return vars["id"] -- ./compiler/lua54.lpt:1034
end -- ./compiler/lua54.lpt:1034
end, -- ./compiler/lua54.lpt:1034
["Index"] = function(t) -- ./compiler/lua54.lpt:1038
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:1039
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:1040
else -- ./compiler/lua54.lpt:1040
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:1042
end -- ./compiler/lua54.lpt:1042
end, -- ./compiler/lua54.lpt:1042
["SafeIndex"] = function(t) -- ./compiler/lua54.lpt:1046
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:1047
local l = {} -- ./compiler/lua54.lpt:1048
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.lpt:1049
table["insert"](l, 1, t) -- ./compiler/lua54.lpt:1050
t = t[1] -- ./compiler/lua54.lpt:1051
end -- ./compiler/lua54.lpt:1051
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.lpt:1053
for _, e in ipairs(l) do -- ./compiler/lua54.lpt:1054
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.lpt:1055
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.lpt:1056
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.lpt:1057
else -- ./compiler/lua54.lpt:1057
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.lpt:1059
end -- ./compiler/lua54.lpt:1059
end -- ./compiler/lua54.lpt:1059
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.lpt:1062
return r -- ./compiler/lua54.lpt:1063
else -- ./compiler/lua54.lpt:1063
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.lpt:1065
end -- ./compiler/lua54.lpt:1065
end, -- ./compiler/lua54.lpt:1065
["_opid"] = { -- ./compiler/lua54.lpt:1071
["add"] = "+", -- ./compiler/lua54.lpt:1073
["sub"] = "-", -- ./compiler/lua54.lpt:1073
["mul"] = "*", -- ./compiler/lua54.lpt:1073
["div"] = "/", -- ./compiler/lua54.lpt:1073
["idiv"] = "//", -- ./compiler/lua54.lpt:1074
["mod"] = "%", -- ./compiler/lua54.lpt:1074
["pow"] = "^", -- ./compiler/lua54.lpt:1074
["concat"] = "..", -- ./compiler/lua54.lpt:1074
["band"] = "&", -- ./compiler/lua54.lpt:1075
["bor"] = "|", -- ./compiler/lua54.lpt:1075
["bxor"] = "~", -- ./compiler/lua54.lpt:1075
["shl"] = "<<", -- ./compiler/lua54.lpt:1075
["shr"] = ">>", -- ./compiler/lua54.lpt:1075
["eq"] = "==", -- ./compiler/lua54.lpt:1076
["ne"] = "~=", -- ./compiler/lua54.lpt:1076
["lt"] = "<", -- ./compiler/lua54.lpt:1076
["gt"] = ">", -- ./compiler/lua54.lpt:1076
["le"] = "<=", -- ./compiler/lua54.lpt:1076
["ge"] = ">=", -- ./compiler/lua54.lpt:1076
["and"] = "and", -- ./compiler/lua54.lpt:1077
["or"] = "or", -- ./compiler/lua54.lpt:1077
["unm"] = "-", -- ./compiler/lua54.lpt:1077
["len"] = "#", -- ./compiler/lua54.lpt:1077
["bnot"] = "~", -- ./compiler/lua54.lpt:1077
["not"] = "not", -- ./compiler/lua54.lpt:1077
["divb"] = function(left, right) -- ./compiler/lua54.lpt:1081
return table["concat"]({ -- ./compiler/lua54.lpt:1082
"((", -- ./compiler/lua54.lpt:1082
lua(left), -- ./compiler/lua54.lpt:1082
") % (", -- ./compiler/lua54.lpt:1082
lua(right), -- ./compiler/lua54.lpt:1082
") == 0)" -- ./compiler/lua54.lpt:1082
}) -- ./compiler/lua54.lpt:1082
end, -- ./compiler/lua54.lpt:1082
["ndivb"] = function(left, right) -- ./compiler/lua54.lpt:1085
return table["concat"]({ -- ./compiler/lua54.lpt:1086
"((", -- ./compiler/lua54.lpt:1086
lua(left), -- ./compiler/lua54.lpt:1086
") % (", -- ./compiler/lua54.lpt:1086
lua(right), -- ./compiler/lua54.lpt:1086
") ~= 0)" -- ./compiler/lua54.lpt:1086
}) -- ./compiler/lua54.lpt:1086
end, -- ./compiler/lua54.lpt:1086
["tconcat"] = function(left, right) -- ./compiler/lua54.lpt:1091
if right["tag"] == "Table" then -- ./compiler/lua54.lpt:1092
local sep = right[1] -- ./compiler/lua54.lpt:1093
local i = right[2] -- ./compiler/lua54.lpt:1094
local j = right[3] -- ./compiler/lua54.lpt:1095
local r = { -- ./compiler/lua54.lpt:1097
"table.concat(", -- ./compiler/lua54.lpt:1097
lua(left) -- ./compiler/lua54.lpt:1097
} -- ./compiler/lua54.lpt:1097
if sep ~= nil then -- ./compiler/lua54.lpt:1099
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1100
r[# r + 1] = lua(sep) -- ./compiler/lua54.lpt:1101
end -- ./compiler/lua54.lpt:1101
if i ~= nil then -- ./compiler/lua54.lpt:1104
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1105
r[# r + 1] = lua(i) -- ./compiler/lua54.lpt:1106
end -- ./compiler/lua54.lpt:1106
if j ~= nil then -- ./compiler/lua54.lpt:1109
r[# r + 1] = ", " -- ./compiler/lua54.lpt:1110
r[# r + 1] = lua(j) -- ./compiler/lua54.lpt:1111
end -- ./compiler/lua54.lpt:1111
r[# r + 1] = ")" -- ./compiler/lua54.lpt:1114
return table["concat"](r) -- ./compiler/lua54.lpt:1116
else -- ./compiler/lua54.lpt:1116
return table["concat"]({ -- ./compiler/lua54.lpt:1118
"table.concat(", -- ./compiler/lua54.lpt:1118
lua(left), -- ./compiler/lua54.lpt:1118
", ", -- ./compiler/lua54.lpt:1118
lua(right), -- ./compiler/lua54.lpt:1118
")" -- ./compiler/lua54.lpt:1118
}) -- ./compiler/lua54.lpt:1118
end -- ./compiler/lua54.lpt:1118
end, -- ./compiler/lua54.lpt:1118
["pipe"] = function(left, right) -- ./compiler/lua54.lpt:1124
return table["concat"]({ -- ./compiler/lua54.lpt:1125
"(", -- ./compiler/lua54.lpt:1125
lua(right), -- ./compiler/lua54.lpt:1125
")", -- ./compiler/lua54.lpt:1125
"(", -- ./compiler/lua54.lpt:1125
lua(left), -- ./compiler/lua54.lpt:1125
")" -- ./compiler/lua54.lpt:1125
}) -- ./compiler/lua54.lpt:1125
end, -- ./compiler/lua54.lpt:1125
["pipebc"] = function(left, right) -- ./compiler/lua54.lpt:1127
return table["concat"]({ BROADCAST({ -- ./compiler/lua54.lpt:1128
right, -- ./compiler/lua54.lpt:1128
left -- ./compiler/lua54.lpt:1128
}, false) }) -- ./compiler/lua54.lpt:1128
end, -- ./compiler/lua54.lpt:1128
["pipebckv"] = function(left, right) -- ./compiler/lua54.lpt:1130
return table["concat"]({ BROADCAST({ -- ./compiler/lua54.lpt:1131
right, -- ./compiler/lua54.lpt:1131
left -- ./compiler/lua54.lpt:1131
}, true) }) -- ./compiler/lua54.lpt:1131
end -- ./compiler/lua54.lpt:1131
} -- ./compiler/lua54.lpt:1131
}, { ["__index"] = function(self, key) -- ./compiler/lua54.lpt:1143
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.lpt:1144
end }) -- ./compiler/lua54.lpt:1144
targetName = "Lua 5.3" -- ./compiler/lua53.lpt:1
tags["AttributeId"] = function(t) -- ./compiler/lua53.lpt:4
if t[2] then -- ./compiler/lua53.lpt:5
error("target " .. targetName .. " does not support variable attributes") -- ./compiler/lua53.lpt:6
else -- ./compiler/lua53.lpt:6
return t[1] -- ./compiler/lua53.lpt:8
end -- ./compiler/lua53.lpt:8
end -- ./compiler/lua53.lpt:8
targetName = "Lua 5.2" -- ./compiler/lua52.lpt:1
APPEND = function(t, toAppend) -- ./compiler/lua52.lpt:3
return "do" .. indent() .. "local " .. var("a") .. ", " .. var("p") .. " = { " .. toAppend .. " }, #" .. t .. "+1" .. newline() .. "for i=1, #" .. var("a") .. " do" .. indent() .. t .. "[" .. var("p") .. "] = " .. var("a") .. "[i]" .. newline() .. "" .. var("p") .. " = " .. var("p") .. " + 1" .. unindent() .. "end" .. unindent() .. "end" -- ./compiler/lua52.lpt:4
end -- ./compiler/lua52.lpt:4
tags["_opid"]["idiv"] = function(left, right) -- ./compiler/lua52.lpt:7
return "math.floor(" .. lua(left) .. " / " .. lua(right) .. ")" -- ./compiler/lua52.lpt:8
end -- ./compiler/lua52.lpt:8
tags["_opid"]["band"] = function(left, right) -- ./compiler/lua52.lpt:10
return "bit32.band(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:11
end -- ./compiler/lua52.lpt:11
tags["_opid"]["bor"] = function(left, right) -- ./compiler/lua52.lpt:13
return "bit32.bor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:14
end -- ./compiler/lua52.lpt:14
tags["_opid"]["bxor"] = function(left, right) -- ./compiler/lua52.lpt:16
return "bit32.bxor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:17
end -- ./compiler/lua52.lpt:17
tags["_opid"]["shl"] = function(left, right) -- ./compiler/lua52.lpt:19
return "bit32.lshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:20
end -- ./compiler/lua52.lpt:20
tags["_opid"]["shr"] = function(left, right) -- ./compiler/lua52.lpt:22
return "bit32.rshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.lpt:23
end -- ./compiler/lua52.lpt:23
tags["_opid"]["bnot"] = function(right) -- ./compiler/lua52.lpt:25
return "bit32.bnot(" .. lua(right) .. ")" -- ./compiler/lua52.lpt:26
end -- ./compiler/lua52.lpt:26
targetName = "LuaJIT" -- ./compiler/luajit.lpt:1
UNPACK = function(list, i, j) -- ./compiler/luajit.lpt:3
return "unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/luajit.lpt:4
end -- ./compiler/luajit.lpt:4
tags["_opid"]["band"] = function(left, right) -- ./compiler/luajit.lpt:7
addRequire("bit", "band", "band") -- ./compiler/luajit.lpt:8
return var("band") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.lpt:9
end -- ./compiler/luajit.lpt:9
tags["_opid"]["bor"] = function(left, right) -- ./compiler/luajit.lpt:11
addRequire("bit", "bor", "bor") -- ./compiler/luajit.lpt:12
return var("bor") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.lpt:13
end -- ./compiler/luajit.lpt:13
tags["_opid"]["bxor"] = function(left, right) -- ./compiler/luajit.lpt:15
addRequire("bit", "bxor", "bxor") -- ./compiler/luajit.lpt:16
return var("bxor") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.lpt:17
end -- ./compiler/luajit.lpt:17
tags["_opid"]["shl"] = function(left, right) -- ./compiler/luajit.lpt:19
addRequire("bit", "lshift", "lshift") -- ./compiler/luajit.lpt:20
return var("lshift") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.lpt:21
end -- ./compiler/luajit.lpt:21
tags["_opid"]["shr"] = function(left, right) -- ./compiler/luajit.lpt:23
addRequire("bit", "rshift", "rshift") -- ./compiler/luajit.lpt:24
return var("rshift") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.lpt:25
end -- ./compiler/luajit.lpt:25
tags["_opid"]["bnot"] = function(right) -- ./compiler/luajit.lpt:27
addRequire("bit", "bnot", "bnot") -- ./compiler/luajit.lpt:28
return var("bnot") .. "(" .. lua(right) .. ")" -- ./compiler/luajit.lpt:29
end -- ./compiler/luajit.lpt:29
targetName = "Lua 5.1" -- ./compiler/lua51.lpt:1
states["continue"] = {} -- ./compiler/lua51.lpt:3
CONTINUE_START = function() -- ./compiler/lua51.lpt:5
return "local " .. var("break") .. newline() .. "repeat" .. indent() .. push("continue", var("break")) -- ./compiler/lua51.lpt:6
end -- ./compiler/lua51.lpt:6
CONTINUE_STOP = function() -- ./compiler/lua51.lpt:8
return pop("continue") .. unindent() .. "until true" .. newline() .. "if " .. var("break") .. " then break end" -- ./compiler/lua51.lpt:9
end -- ./compiler/lua51.lpt:9
tags["Continue"] = function() -- ./compiler/lua51.lpt:12
return "break" -- ./compiler/lua51.lpt:13
end -- ./compiler/lua51.lpt:13
tags["Break"] = function() -- ./compiler/lua51.lpt:15
local inContinue = peek("continue") -- ./compiler/lua51.lpt:16
if inContinue then -- ./compiler/lua51.lpt:17
return inContinue .. " = true" .. newline() .. "break" -- ./compiler/lua51.lpt:18
else -- ./compiler/lua51.lpt:18
return "break" -- ./compiler/lua51.lpt:20
end -- ./compiler/lua51.lpt:20
end -- ./compiler/lua51.lpt:20
tags["Goto"] = function() -- ./compiler/lua51.lpt:25
error("target " .. targetName .. " does not support gotos") -- ./compiler/lua51.lpt:26
end -- ./compiler/lua51.lpt:26
tags["Label"] = function() -- ./compiler/lua51.lpt:28
error("target " .. targetName .. " does not support goto labels") -- ./compiler/lua51.lpt:29
end -- ./compiler/lua51.lpt:29
local code = lua(ast) .. newline() -- ./compiler/lua54.lpt:1151
return requireStr .. luaHeader .. code -- ./compiler/lua54.lpt:1152
end -- ./compiler/lua54.lpt:1152
end -- ./compiler/lua54.lpt:1152
local lua54 = _() or lua54 -- ./compiler/lua54.lpt:1157
return lua54 -- ./compiler/lua53.lpt:18
end -- ./compiler/lua53.lpt:18
local lua53 = _() or lua53 -- ./compiler/lua53.lpt:22
return lua53 -- ./compiler/lua52.lpt:35
end -- ./compiler/lua52.lpt:35
local lua52 = _() or lua52 -- ./compiler/lua52.lpt:39
return lua52 -- ./compiler/luajit.lpt:38
end -- ./compiler/luajit.lpt:38
local luajit = _() or luajit -- ./compiler/luajit.lpt:42
return luajit -- ./compiler/lua51.lpt:38
end -- ./compiler/lua51.lpt:38
local lua51 = _() or lua51 -- ./compiler/lua51.lpt:42
package["loaded"]["compiler.lua51"] = lua51 or true -- ./compiler/lua51.lpt:43
local function _() -- ./compiler/lua51.lpt:47
local scope = {} -- ./lepton/lpt-parser/scope.lua:4
scope["lineno"] = function(s, i) -- ./lepton/lpt-parser/scope.lua:6
if i == 1 then -- ./lepton/lpt-parser/scope.lua:7
return 1, 1 -- ./lepton/lpt-parser/scope.lua:7
end -- ./lepton/lpt-parser/scope.lua:7
local l, lastline = 0, "" -- ./lepton/lpt-parser/scope.lua:8
s = s:sub(1, i) .. "\
" -- ./lepton/lpt-parser/scope.lua:9
for line in s:gmatch("[^\
]*[\
]") do -- ./lepton/lpt-parser/scope.lua:10
l = l + 1 -- ./lepton/lpt-parser/scope.lua:11
lastline = line -- ./lepton/lpt-parser/scope.lua:12
end -- ./lepton/lpt-parser/scope.lua:12
local c = lastline:len() - 1 -- ./lepton/lpt-parser/scope.lua:14
return l, c ~= 0 and c or 1 -- ./lepton/lpt-parser/scope.lua:15
end -- ./lepton/lpt-parser/scope.lua:15
scope["new_scope"] = function(env) -- ./lepton/lpt-parser/scope.lua:18
if not env["scope"] then -- ./lepton/lpt-parser/scope.lua:19
env["scope"] = 0 -- ./lepton/lpt-parser/scope.lua:20
else -- ./lepton/lpt-parser/scope.lua:20
env["scope"] = env["scope"] + 1 -- ./lepton/lpt-parser/scope.lua:22
end -- ./lepton/lpt-parser/scope.lua:22
local scope = env["scope"] -- ./lepton/lpt-parser/scope.lua:24
env["maxscope"] = scope -- ./lepton/lpt-parser/scope.lua:25
env[scope] = {} -- ./lepton/lpt-parser/scope.lua:26
env[scope]["label"] = {} -- ./lepton/lpt-parser/scope.lua:27
env[scope]["local"] = {} -- ./lepton/lpt-parser/scope.lua:28
env[scope]["goto"] = {} -- ./lepton/lpt-parser/scope.lua:29
end -- ./lepton/lpt-parser/scope.lua:29
scope["begin_scope"] = function(env) -- ./lepton/lpt-parser/scope.lua:32
env["scope"] = env["scope"] + 1 -- ./lepton/lpt-parser/scope.lua:33
end -- ./lepton/lpt-parser/scope.lua:33
scope["end_scope"] = function(env) -- ./lepton/lpt-parser/scope.lua:36
env["scope"] = env["scope"] - 1 -- ./lepton/lpt-parser/scope.lua:37
end -- ./lepton/lpt-parser/scope.lua:37
scope["new_function"] = function(env) -- ./lepton/lpt-parser/scope.lua:40
if not env["fscope"] then -- ./lepton/lpt-parser/scope.lua:41
env["fscope"] = 0 -- ./lepton/lpt-parser/scope.lua:42
else -- ./lepton/lpt-parser/scope.lua:42
env["fscope"] = env["fscope"] + 1 -- ./lepton/lpt-parser/scope.lua:44
end -- ./lepton/lpt-parser/scope.lua:44
local fscope = env["fscope"] -- ./lepton/lpt-parser/scope.lua:46
env["function"][fscope] = {} -- ./lepton/lpt-parser/scope.lua:47
end -- ./lepton/lpt-parser/scope.lua:47
scope["begin_function"] = function(env) -- ./lepton/lpt-parser/scope.lua:50
env["fscope"] = env["fscope"] + 1 -- ./lepton/lpt-parser/scope.lua:51
end -- ./lepton/lpt-parser/scope.lua:51
scope["end_function"] = function(env) -- ./lepton/lpt-parser/scope.lua:54
env["fscope"] = env["fscope"] - 1 -- ./lepton/lpt-parser/scope.lua:55
end -- ./lepton/lpt-parser/scope.lua:55
scope["begin_loop"] = function(env) -- ./lepton/lpt-parser/scope.lua:58
if not env["loop"] then -- ./lepton/lpt-parser/scope.lua:59
env["loop"] = 1 -- ./lepton/lpt-parser/scope.lua:60
else -- ./lepton/lpt-parser/scope.lua:60
env["loop"] = env["loop"] + 1 -- ./lepton/lpt-parser/scope.lua:62
end -- ./lepton/lpt-parser/scope.lua:62
end -- ./lepton/lpt-parser/scope.lua:62
scope["end_loop"] = function(env) -- ./lepton/lpt-parser/scope.lua:66
env["loop"] = env["loop"] - 1 -- ./lepton/lpt-parser/scope.lua:67
end -- ./lepton/lpt-parser/scope.lua:67
scope["insideloop"] = function(env) -- ./lepton/lpt-parser/scope.lua:70
return env["loop"] and env["loop"] > 0 -- ./lepton/lpt-parser/scope.lua:71
end -- ./lepton/lpt-parser/scope.lua:71
return scope -- ./lepton/lpt-parser/scope.lua:74
end -- ./lepton/lpt-parser/scope.lua:74
local scope = _() or scope -- ./lepton/lpt-parser/scope.lua:78
package["loaded"]["lepton.lpt-parser.scope"] = scope or true -- ./lepton/lpt-parser/scope.lua:79
local function _() -- ./lepton/lpt-parser/scope.lua:82
local scope = require("lepton.lpt-parser.scope") -- ./lepton/lpt-parser/validator.lua:4
local lineno = scope["lineno"] -- ./lepton/lpt-parser/validator.lua:6
local new_scope, end_scope = scope["new_scope"], scope["end_scope"] -- ./lepton/lpt-parser/validator.lua:7
local new_function, end_function = scope["new_function"], scope["end_function"] -- ./lepton/lpt-parser/validator.lua:8
local begin_loop, end_loop = scope["begin_loop"], scope["end_loop"] -- ./lepton/lpt-parser/validator.lua:9
local insideloop = scope["insideloop"] -- ./lepton/lpt-parser/validator.lua:10
local function syntaxerror(errorinfo, pos, msg) -- ./lepton/lpt-parser/validator.lua:13
local l, c = lineno(errorinfo["subject"], pos) -- ./lepton/lpt-parser/validator.lua:14
local error_msg = "%s:%d:%d: syntax error, %s" -- ./lepton/lpt-parser/validator.lua:15
return string["format"](error_msg, errorinfo["filename"], l, c, msg) -- ./lepton/lpt-parser/validator.lua:16
end -- ./lepton/lpt-parser/validator.lua:16
local function exist_label(env, scope, stm) -- ./lepton/lpt-parser/validator.lua:19
local l = stm[1] -- ./lepton/lpt-parser/validator.lua:20
for s = scope, 0, - 1 do -- ./lepton/lpt-parser/validator.lua:21
if env[s]["label"][l] then -- ./lepton/lpt-parser/validator.lua:22
return true -- ./lepton/lpt-parser/validator.lua:22
end -- ./lepton/lpt-parser/validator.lua:22
end -- ./lepton/lpt-parser/validator.lua:22
return false -- ./lepton/lpt-parser/validator.lua:24
end -- ./lepton/lpt-parser/validator.lua:24
local function set_label(env, label, pos) -- ./lepton/lpt-parser/validator.lua:27
local scope = env["scope"] -- ./lepton/lpt-parser/validator.lua:28
local l = env[scope]["label"][label] -- ./lepton/lpt-parser/validator.lua:29
if not l then -- ./lepton/lpt-parser/validator.lua:30
env[scope]["label"][label] = { -- ./lepton/lpt-parser/validator.lua:31
["name"] = label, -- ./lepton/lpt-parser/validator.lua:31
["pos"] = pos -- ./lepton/lpt-parser/validator.lua:31
} -- ./lepton/lpt-parser/validator.lua:31
return true -- ./lepton/lpt-parser/validator.lua:32
else -- ./lepton/lpt-parser/validator.lua:32
local msg = "label '%s' already defined at line %d" -- ./lepton/lpt-parser/validator.lua:34
local line = lineno(env["errorinfo"]["subject"], l["pos"]) -- ./lepton/lpt-parser/validator.lua:35
msg = string["format"](msg, label, line) -- ./lepton/lpt-parser/validator.lua:36
return nil, syntaxerror(env["errorinfo"], pos, msg) -- ./lepton/lpt-parser/validator.lua:37
end -- ./lepton/lpt-parser/validator.lua:37
end -- ./lepton/lpt-parser/validator.lua:37
local function set_pending_goto(env, stm) -- ./lepton/lpt-parser/validator.lua:41
local scope = env["scope"] -- ./lepton/lpt-parser/validator.lua:42
table["insert"](env[scope]["goto"], stm) -- ./lepton/lpt-parser/validator.lua:43
return true -- ./lepton/lpt-parser/validator.lua:44
end -- ./lepton/lpt-parser/validator.lua:44
local function verify_pending_gotos(env) -- ./lepton/lpt-parser/validator.lua:47
for s = env["maxscope"], 0, - 1 do -- ./lepton/lpt-parser/validator.lua:48
for k, v in ipairs(env[s]["goto"]) do -- ./lepton/lpt-parser/validator.lua:49
if not exist_label(env, s, v) then -- ./lepton/lpt-parser/validator.lua:50
local msg = "no visible label " % s(" for <goto>") -- ./lepton/lpt-parser/validator.lua:51
msg = string["format"](msg, v[1]) -- ./lepton/lpt-parser/validator.lua:52
return nil, syntaxerror(env["errorinfo"], v["pos"], msg) -- ./lepton/lpt-parser/validator.lua:53
end -- ./lepton/lpt-parser/validator.lua:53
end -- ./lepton/lpt-parser/validator.lua:53
end -- ./lepton/lpt-parser/validator.lua:53
return true -- ./lepton/lpt-parser/validator.lua:57
end -- ./lepton/lpt-parser/validator.lua:57
local function set_vararg(env, is_vararg) -- ./lepton/lpt-parser/validator.lua:60
env["function"][env["fscope"]]["is_vararg"] = is_vararg -- ./lepton/lpt-parser/validator.lua:61
end -- ./lepton/lpt-parser/validator.lua:61
local traverse_stm, traverse_exp, traverse_var -- ./lepton/lpt-parser/validator.lua:64
local traverse_block, traverse_explist, traverse_varlist, traverse_parlist -- ./lepton/lpt-parser/validator.lua:65
traverse_parlist = function(env, parlist) -- ./lepton/lpt-parser/validator.lua:67
local len = # parlist -- ./lepton/lpt-parser/validator.lua:68
local is_vararg = false -- ./lepton/lpt-parser/validator.lua:69
if len > 0 and parlist[len]["tag"] == "Dots" then -- ./lepton/lpt-parser/validator.lua:70
is_vararg = true -- ./lepton/lpt-parser/validator.lua:71
end -- ./lepton/lpt-parser/validator.lua:71
set_vararg(env, is_vararg) -- ./lepton/lpt-parser/validator.lua:73
return true -- ./lepton/lpt-parser/validator.lua:74
end -- ./lepton/lpt-parser/validator.lua:74
local function traverse_function(env, exp) -- ./lepton/lpt-parser/validator.lua:77
new_function(env) -- ./lepton/lpt-parser/validator.lua:78
new_scope(env) -- ./lepton/lpt-parser/validator.lua:79
local status, msg = traverse_parlist(env, exp[1]) -- ./lepton/lpt-parser/validator.lua:80
if not status then -- ./lepton/lpt-parser/validator.lua:81
return status, msg -- ./lepton/lpt-parser/validator.lua:81
end -- ./lepton/lpt-parser/validator.lua:81
status, msg = traverse_block(env, exp[2]) -- ./lepton/lpt-parser/validator.lua:82
if not status then -- ./lepton/lpt-parser/validator.lua:83
return status, msg -- ./lepton/lpt-parser/validator.lua:83
end -- ./lepton/lpt-parser/validator.lua:83
end_scope(env) -- ./lepton/lpt-parser/validator.lua:84
end_function(env) -- ./lepton/lpt-parser/validator.lua:85
return true -- ./lepton/lpt-parser/validator.lua:86
end -- ./lepton/lpt-parser/validator.lua:86
local function traverse_tablecompr(env, exp) -- ./lepton/lpt-parser/validator.lua:89
new_function(env) -- ./lepton/lpt-parser/validator.lua:90
new_scope(env) -- ./lepton/lpt-parser/validator.lua:91
local status, msg = traverse_block(env, exp[1]) -- ./lepton/lpt-parser/validator.lua:92
if not status then -- ./lepton/lpt-parser/validator.lua:93
return status, msg -- ./lepton/lpt-parser/validator.lua:93
end -- ./lepton/lpt-parser/validator.lua:93
end_scope(env) -- ./lepton/lpt-parser/validator.lua:94
end_function(env) -- ./lepton/lpt-parser/validator.lua:95
return true -- ./lepton/lpt-parser/validator.lua:96
end -- ./lepton/lpt-parser/validator.lua:96
local function traverse_statexpr(env, exp) -- ./lepton/lpt-parser/validator.lua:99
new_function(env) -- ./lepton/lpt-parser/validator.lua:100
new_scope(env) -- ./lepton/lpt-parser/validator.lua:101
exp["tag"] = exp["tag"]:gsub("Expr$", "") -- ./lepton/lpt-parser/validator.lua:102
local status, msg = traverse_stm(env, exp) -- ./lepton/lpt-parser/validator.lua:103
exp["tag"] = exp["tag"] .. "Expr" -- ./lepton/lpt-parser/validator.lua:104
if not status then -- ./lepton/lpt-parser/validator.lua:105
return status, msg -- ./lepton/lpt-parser/validator.lua:105
end -- ./lepton/lpt-parser/validator.lua:105
end_scope(env) -- ./lepton/lpt-parser/validator.lua:106
end_function(env) -- ./lepton/lpt-parser/validator.lua:107
return true -- ./lepton/lpt-parser/validator.lua:108
end -- ./lepton/lpt-parser/validator.lua:108
local function traverse_op(env, exp) -- ./lepton/lpt-parser/validator.lua:111
local status, msg = traverse_exp(env, exp[2]) -- ./lepton/lpt-parser/validator.lua:112
if not status then -- ./lepton/lpt-parser/validator.lua:113
return status, msg -- ./lepton/lpt-parser/validator.lua:113
end -- ./lepton/lpt-parser/validator.lua:113
if exp[3] then -- ./lepton/lpt-parser/validator.lua:114
status, msg = traverse_exp(env, exp[3]) -- ./lepton/lpt-parser/validator.lua:115
if not status then -- ./lepton/lpt-parser/validator.lua:116
return status, msg -- ./lepton/lpt-parser/validator.lua:116
end -- ./lepton/lpt-parser/validator.lua:116
end -- ./lepton/lpt-parser/validator.lua:116
return true -- ./lepton/lpt-parser/validator.lua:118
end -- ./lepton/lpt-parser/validator.lua:118
local function traverse_paren(env, exp) -- ./lepton/lpt-parser/validator.lua:121
local status, msg = traverse_exp(env, exp[1]) -- ./lepton/lpt-parser/validator.lua:122
if not status then -- ./lepton/lpt-parser/validator.lua:123
return status, msg -- ./lepton/lpt-parser/validator.lua:123
end -- ./lepton/lpt-parser/validator.lua:123
return true -- ./lepton/lpt-parser/validator.lua:124
end -- ./lepton/lpt-parser/validator.lua:124
local function traverse_table(env, fieldlist) -- ./lepton/lpt-parser/validator.lua:127
for k, v in ipairs(fieldlist) do -- ./lepton/lpt-parser/validator.lua:128
local tag = v["tag"] -- ./lepton/lpt-parser/validator.lua:129
if tag == "Pair" then -- ./lepton/lpt-parser/validator.lua:130
local status, msg = traverse_exp(env, v[1]) -- ./lepton/lpt-parser/validator.lua:131
if not status then -- ./lepton/lpt-parser/validator.lua:132
return status, msg -- ./lepton/lpt-parser/validator.lua:132
end -- ./lepton/lpt-parser/validator.lua:132
status, msg = traverse_exp(env, v[2]) -- ./lepton/lpt-parser/validator.lua:133
if not status then -- ./lepton/lpt-parser/validator.lua:134
return status, msg -- ./lepton/lpt-parser/validator.lua:134
end -- ./lepton/lpt-parser/validator.lua:134
else -- ./lepton/lpt-parser/validator.lua:134
local status, msg = traverse_exp(env, v) -- ./lepton/lpt-parser/validator.lua:136
if not status then -- ./lepton/lpt-parser/validator.lua:137
return status, msg -- ./lepton/lpt-parser/validator.lua:137
end -- ./lepton/lpt-parser/validator.lua:137
end -- ./lepton/lpt-parser/validator.lua:137
end -- ./lepton/lpt-parser/validator.lua:137
return true -- ./lepton/lpt-parser/validator.lua:140
end -- ./lepton/lpt-parser/validator.lua:140
local function traverse_vararg(env, exp) -- ./lepton/lpt-parser/validator.lua:143
if not env["function"][env["fscope"]]["is_vararg"] then -- ./lepton/lpt-parser/validator.lua:144
local msg = "cannot use '...' outside a vararg function" -- ./lepton/lpt-parser/validator.lua:145
return nil, syntaxerror(env["errorinfo"], exp["pos"], msg) -- ./lepton/lpt-parser/validator.lua:146
end -- ./lepton/lpt-parser/validator.lua:146
return true -- ./lepton/lpt-parser/validator.lua:148
end -- ./lepton/lpt-parser/validator.lua:148
local function traverse_call(env, call) -- ./lepton/lpt-parser/validator.lua:151
local status, msg = traverse_exp(env, call[1]) -- ./lepton/lpt-parser/validator.lua:152
if not status then -- ./lepton/lpt-parser/validator.lua:153
return status, msg -- ./lepton/lpt-parser/validator.lua:153
end -- ./lepton/lpt-parser/validator.lua:153
for i = 2, # call do -- ./lepton/lpt-parser/validator.lua:154
status, msg = traverse_exp(env, call[i]) -- ./lepton/lpt-parser/validator.lua:155
if not status then -- ./lepton/lpt-parser/validator.lua:156
return status, msg -- ./lepton/lpt-parser/validator.lua:156
end -- ./lepton/lpt-parser/validator.lua:156
end -- ./lepton/lpt-parser/validator.lua:156
return true -- ./lepton/lpt-parser/validator.lua:158
end -- ./lepton/lpt-parser/validator.lua:158
local function traverse_assignment(env, stm) -- ./lepton/lpt-parser/validator.lua:161
local status, msg = traverse_varlist(env, stm[1]) -- ./lepton/lpt-parser/validator.lua:162
if not status then -- ./lepton/lpt-parser/validator.lua:163
return status, msg -- ./lepton/lpt-parser/validator.lua:163
end -- ./lepton/lpt-parser/validator.lua:163
status, msg = traverse_explist(env, stm[# stm]) -- ./lepton/lpt-parser/validator.lua:164
if not status then -- ./lepton/lpt-parser/validator.lua:165
return status, msg -- ./lepton/lpt-parser/validator.lua:165
end -- ./lepton/lpt-parser/validator.lua:165
return true -- ./lepton/lpt-parser/validator.lua:166
end -- ./lepton/lpt-parser/validator.lua:166
local function traverse_break(env, stm) -- ./lepton/lpt-parser/validator.lua:169
if not insideloop(env) then -- ./lepton/lpt-parser/validator.lua:170
local msg = "<break> not inside a loop" -- ./lepton/lpt-parser/validator.lua:171
return nil, syntaxerror(env["errorinfo"], stm["pos"], msg) -- ./lepton/lpt-parser/validator.lua:172
end -- ./lepton/lpt-parser/validator.lua:172
return true -- ./lepton/lpt-parser/validator.lua:174
end -- ./lepton/lpt-parser/validator.lua:174
local function traverse_continue(env, stm) -- ./lepton/lpt-parser/validator.lua:177
if not insideloop(env) then -- ./lepton/lpt-parser/validator.lua:178
local msg = "<continue> not inside a loop" -- ./lepton/lpt-parser/validator.lua:179
return nil, syntaxerror(env["errorinfo"], stm["pos"], msg) -- ./lepton/lpt-parser/validator.lua:180
end -- ./lepton/lpt-parser/validator.lua:180
return true -- ./lepton/lpt-parser/validator.lua:182
end -- ./lepton/lpt-parser/validator.lua:182
local function traverse_push(env, stm) -- ./lepton/lpt-parser/validator.lua:185
local status, msg = traverse_explist(env, stm) -- ./lepton/lpt-parser/validator.lua:186
if not status then -- ./lepton/lpt-parser/validator.lua:187
return status, msg -- ./lepton/lpt-parser/validator.lua:187
end -- ./lepton/lpt-parser/validator.lua:187
return true -- ./lepton/lpt-parser/validator.lua:188
end -- ./lepton/lpt-parser/validator.lua:188
local function traverse_forin(env, stm) -- ./lepton/lpt-parser/validator.lua:191
begin_loop(env) -- ./lepton/lpt-parser/validator.lua:192
new_scope(env) -- ./lepton/lpt-parser/validator.lua:193
local status, msg = traverse_explist(env, stm[2]) -- ./lepton/lpt-parser/validator.lua:194
if not status then -- ./lepton/lpt-parser/validator.lua:195
return status, msg -- ./lepton/lpt-parser/validator.lua:195
end -- ./lepton/lpt-parser/validator.lua:195
status, msg = traverse_block(env, stm[3]) -- ./lepton/lpt-parser/validator.lua:196
if not status then -- ./lepton/lpt-parser/validator.lua:197
return status, msg -- ./lepton/lpt-parser/validator.lua:197
end -- ./lepton/lpt-parser/validator.lua:197
end_scope(env) -- ./lepton/lpt-parser/validator.lua:198
end_loop(env) -- ./lepton/lpt-parser/validator.lua:199
return true -- ./lepton/lpt-parser/validator.lua:200
end -- ./lepton/lpt-parser/validator.lua:200
local function traverse_fornum(env, stm) -- ./lepton/lpt-parser/validator.lua:203
local status, msg -- ./lepton/lpt-parser/validator.lua:204
begin_loop(env) -- ./lepton/lpt-parser/validator.lua:205
new_scope(env) -- ./lepton/lpt-parser/validator.lua:206
status, msg = traverse_exp(env, stm[2]) -- ./lepton/lpt-parser/validator.lua:207
if not status then -- ./lepton/lpt-parser/validator.lua:208
return status, msg -- ./lepton/lpt-parser/validator.lua:208
end -- ./lepton/lpt-parser/validator.lua:208
status, msg = traverse_exp(env, stm[3]) -- ./lepton/lpt-parser/validator.lua:209
if not status then -- ./lepton/lpt-parser/validator.lua:210
return status, msg -- ./lepton/lpt-parser/validator.lua:210
end -- ./lepton/lpt-parser/validator.lua:210
if stm[5] then -- ./lepton/lpt-parser/validator.lua:211
status, msg = traverse_exp(env, stm[4]) -- ./lepton/lpt-parser/validator.lua:212
if not status then -- ./lepton/lpt-parser/validator.lua:213
return status, msg -- ./lepton/lpt-parser/validator.lua:213
end -- ./lepton/lpt-parser/validator.lua:213
status, msg = traverse_block(env, stm[5]) -- ./lepton/lpt-parser/validator.lua:214
if not status then -- ./lepton/lpt-parser/validator.lua:215
return status, msg -- ./lepton/lpt-parser/validator.lua:215
end -- ./lepton/lpt-parser/validator.lua:215
else -- ./lepton/lpt-parser/validator.lua:215
status, msg = traverse_block(env, stm[4]) -- ./lepton/lpt-parser/validator.lua:217
if not status then -- ./lepton/lpt-parser/validator.lua:218
return status, msg -- ./lepton/lpt-parser/validator.lua:218
end -- ./lepton/lpt-parser/validator.lua:218
end -- ./lepton/lpt-parser/validator.lua:218
end_scope(env) -- ./lepton/lpt-parser/validator.lua:220
end_loop(env) -- ./lepton/lpt-parser/validator.lua:221
return true -- ./lepton/lpt-parser/validator.lua:222
end -- ./lepton/lpt-parser/validator.lua:222
local function traverse_goto(env, stm) -- ./lepton/lpt-parser/validator.lua:225
local status, msg = set_pending_goto(env, stm) -- ./lepton/lpt-parser/validator.lua:226
if not status then -- ./lepton/lpt-parser/validator.lua:227
return status, msg -- ./lepton/lpt-parser/validator.lua:227
end -- ./lepton/lpt-parser/validator.lua:227
return true -- ./lepton/lpt-parser/validator.lua:228
end -- ./lepton/lpt-parser/validator.lua:228
local function traverse_let(env, stm) -- ./lepton/lpt-parser/validator.lua:231
local status, msg = traverse_explist(env, stm[2]) -- ./lepton/lpt-parser/validator.lua:232
if not status then -- ./lepton/lpt-parser/validator.lua:233
return status, msg -- ./lepton/lpt-parser/validator.lua:233
end -- ./lepton/lpt-parser/validator.lua:233
return true -- ./lepton/lpt-parser/validator.lua:234
end -- ./lepton/lpt-parser/validator.lua:234
local function traverse_letrec(env, stm) -- ./lepton/lpt-parser/validator.lua:237
local status, msg = traverse_exp(env, stm[2][1]) -- ./lepton/lpt-parser/validator.lua:238
if not status then -- ./lepton/lpt-parser/validator.lua:239
return status, msg -- ./lepton/lpt-parser/validator.lua:239
end -- ./lepton/lpt-parser/validator.lua:239
return true -- ./lepton/lpt-parser/validator.lua:240
end -- ./lepton/lpt-parser/validator.lua:240
local function traverse_if(env, stm) -- ./lepton/lpt-parser/validator.lua:243
local len = # stm -- ./lepton/lpt-parser/validator.lua:244
if len % 2 == 0 then -- ./lepton/lpt-parser/validator.lua:245
for i = 1, len, 2 do -- ./lepton/lpt-parser/validator.lua:246
local status, msg = traverse_exp(env, stm[i]) -- ./lepton/lpt-parser/validator.lua:247
if not status then -- ./lepton/lpt-parser/validator.lua:248
return status, msg -- ./lepton/lpt-parser/validator.lua:248
end -- ./lepton/lpt-parser/validator.lua:248
status, msg = traverse_block(env, stm[i + 1]) -- ./lepton/lpt-parser/validator.lua:249
if not status then -- ./lepton/lpt-parser/validator.lua:250
return status, msg -- ./lepton/lpt-parser/validator.lua:250
end -- ./lepton/lpt-parser/validator.lua:250
end -- ./lepton/lpt-parser/validator.lua:250
else -- ./lepton/lpt-parser/validator.lua:250
for i = 1, len - 1, 2 do -- ./lepton/lpt-parser/validator.lua:253
local status, msg = traverse_exp(env, stm[i]) -- ./lepton/lpt-parser/validator.lua:254
if not status then -- ./lepton/lpt-parser/validator.lua:255
return status, msg -- ./lepton/lpt-parser/validator.lua:255
end -- ./lepton/lpt-parser/validator.lua:255
status, msg = traverse_block(env, stm[i + 1]) -- ./lepton/lpt-parser/validator.lua:256
if not status then -- ./lepton/lpt-parser/validator.lua:257
return status, msg -- ./lepton/lpt-parser/validator.lua:257
end -- ./lepton/lpt-parser/validator.lua:257
end -- ./lepton/lpt-parser/validator.lua:257
local status, msg = traverse_block(env, stm[len]) -- ./lepton/lpt-parser/validator.lua:259
if not status then -- ./lepton/lpt-parser/validator.lua:260
return status, msg -- ./lepton/lpt-parser/validator.lua:260
end -- ./lepton/lpt-parser/validator.lua:260
end -- ./lepton/lpt-parser/validator.lua:260
return true -- ./lepton/lpt-parser/validator.lua:262
end -- ./lepton/lpt-parser/validator.lua:262
local function traverse_label(env, stm) -- ./lepton/lpt-parser/validator.lua:265
local status, msg = set_label(env, stm[1], stm["pos"]) -- ./lepton/lpt-parser/validator.lua:266
if not status then -- ./lepton/lpt-parser/validator.lua:267
return status, msg -- ./lepton/lpt-parser/validator.lua:267
end -- ./lepton/lpt-parser/validator.lua:267
return true -- ./lepton/lpt-parser/validator.lua:268
end -- ./lepton/lpt-parser/validator.lua:268
local function traverse_repeat(env, stm) -- ./lepton/lpt-parser/validator.lua:271
begin_loop(env) -- ./lepton/lpt-parser/validator.lua:272
local status, msg = traverse_block(env, stm[1]) -- ./lepton/lpt-parser/validator.lua:273
if not status then -- ./lepton/lpt-parser/validator.lua:274
return status, msg -- ./lepton/lpt-parser/validator.lua:274
end -- ./lepton/lpt-parser/validator.lua:274
status, msg = traverse_exp(env, stm[2]) -- ./lepton/lpt-parser/validator.lua:275
if not status then -- ./lepton/lpt-parser/validator.lua:276
return status, msg -- ./lepton/lpt-parser/validator.lua:276
end -- ./lepton/lpt-parser/validator.lua:276
end_loop(env) -- ./lepton/lpt-parser/validator.lua:277
return true -- ./lepton/lpt-parser/validator.lua:278
end -- ./lepton/lpt-parser/validator.lua:278
local function traverse_return(env, stm) -- ./lepton/lpt-parser/validator.lua:281
local status, msg = traverse_explist(env, stm) -- ./lepton/lpt-parser/validator.lua:282
if not status then -- ./lepton/lpt-parser/validator.lua:283
return status, msg -- ./lepton/lpt-parser/validator.lua:283
end -- ./lepton/lpt-parser/validator.lua:283
return true -- ./lepton/lpt-parser/validator.lua:284
end -- ./lepton/lpt-parser/validator.lua:284
local function traverse_while(env, stm) -- ./lepton/lpt-parser/validator.lua:287
begin_loop(env) -- ./lepton/lpt-parser/validator.lua:288
local status, msg = traverse_exp(env, stm[1]) -- ./lepton/lpt-parser/validator.lua:289
if not status then -- ./lepton/lpt-parser/validator.lua:290
return status, msg -- ./lepton/lpt-parser/validator.lua:290
end -- ./lepton/lpt-parser/validator.lua:290
status, msg = traverse_block(env, stm[2]) -- ./lepton/lpt-parser/validator.lua:291
if not status then -- ./lepton/lpt-parser/validator.lua:292
return status, msg -- ./lepton/lpt-parser/validator.lua:292
end -- ./lepton/lpt-parser/validator.lua:292
end_loop(env) -- ./lepton/lpt-parser/validator.lua:293
return true -- ./lepton/lpt-parser/validator.lua:294
end -- ./lepton/lpt-parser/validator.lua:294
traverse_var = function(env, var) -- ./lepton/lpt-parser/validator.lua:297
local tag = var["tag"] -- ./lepton/lpt-parser/validator.lua:298
if tag == "Id" then -- ./lepton/lpt-parser/validator.lua:299
return true -- ./lepton/lpt-parser/validator.lua:300
elseif tag == "Index" then -- ./lepton/lpt-parser/validator.lua:301
local status, msg = traverse_exp(env, var[1]) -- ./lepton/lpt-parser/validator.lua:302
if not status then -- ./lepton/lpt-parser/validator.lua:303
return status, msg -- ./lepton/lpt-parser/validator.lua:303
end -- ./lepton/lpt-parser/validator.lua:303
status, msg = traverse_exp(env, var[2]) -- ./lepton/lpt-parser/validator.lua:304
if not status then -- ./lepton/lpt-parser/validator.lua:305
return status, msg -- ./lepton/lpt-parser/validator.lua:305
end -- ./lepton/lpt-parser/validator.lua:305
return true -- ./lepton/lpt-parser/validator.lua:306
elseif tag == "DestructuringId" then -- ./lepton/lpt-parser/validator.lua:307
return traverse_table(env, var) -- ./lepton/lpt-parser/validator.lua:308
else -- ./lepton/lpt-parser/validator.lua:308
error("expecting a variable, but got a " .. tag) -- ./lepton/lpt-parser/validator.lua:310
end -- ./lepton/lpt-parser/validator.lua:310
end -- ./lepton/lpt-parser/validator.lua:310
traverse_varlist = function(env, varlist) -- ./lepton/lpt-parser/validator.lua:314
for k, v in ipairs(varlist) do -- ./lepton/lpt-parser/validator.lua:315
local status, msg = traverse_var(env, v) -- ./lepton/lpt-parser/validator.lua:316
if not status then -- ./lepton/lpt-parser/validator.lua:317
return status, msg -- ./lepton/lpt-parser/validator.lua:317
end -- ./lepton/lpt-parser/validator.lua:317
end -- ./lepton/lpt-parser/validator.lua:317
return true -- ./lepton/lpt-parser/validator.lua:319
end -- ./lepton/lpt-parser/validator.lua:319
local function traverse_methodstub(env, var) -- ./lepton/lpt-parser/validator.lua:322
local status, msg = traverse_exp(env, var[1]) -- ./lepton/lpt-parser/validator.lua:323
if not status then -- ./lepton/lpt-parser/validator.lua:324
return status, msg -- ./lepton/lpt-parser/validator.lua:324
end -- ./lepton/lpt-parser/validator.lua:324
status, msg = traverse_exp(env, var[2]) -- ./lepton/lpt-parser/validator.lua:325
if not status then -- ./lepton/lpt-parser/validator.lua:326
return status, msg -- ./lepton/lpt-parser/validator.lua:326
end -- ./lepton/lpt-parser/validator.lua:326
return true -- ./lepton/lpt-parser/validator.lua:327
end -- ./lepton/lpt-parser/validator.lua:327
local function traverse_safeindex(env, var) -- ./lepton/lpt-parser/validator.lua:330
local status, msg = traverse_exp(env, var[1]) -- ./lepton/lpt-parser/validator.lua:331
if not status then -- ./lepton/lpt-parser/validator.lua:332
return status, msg -- ./lepton/lpt-parser/validator.lua:332
end -- ./lepton/lpt-parser/validator.lua:332
status, msg = traverse_exp(env, var[2]) -- ./lepton/lpt-parser/validator.lua:333
if not status then -- ./lepton/lpt-parser/validator.lua:334
return status, msg -- ./lepton/lpt-parser/validator.lua:334
end -- ./lepton/lpt-parser/validator.lua:334
return true -- ./lepton/lpt-parser/validator.lua:335
end -- ./lepton/lpt-parser/validator.lua:335
traverse_exp = function(env, exp) -- ./lepton/lpt-parser/validator.lua:338
local tag = exp["tag"] -- ./lepton/lpt-parser/validator.lua:339
local calls = { -- ./lepton/lpt-parser/validator.lua:340
["Call"] = true, -- ./lepton/lpt-parser/validator.lua:341
["SafeCall"] = true, -- ./lepton/lpt-parser/validator.lua:342
["Broadcast"] = true, -- ./lepton/lpt-parser/validator.lua:343
["BroadcastKV"] = true, -- ./lepton/lpt-parser/validator.lua:344
["Filter"] = true, -- ./lepton/lpt-parser/validator.lua:345
["FilterKV"] = true, -- ./lepton/lpt-parser/validator.lua:346
["TableUnpack"] = true -- ./lepton/lpt-parser/validator.lua:347
} -- ./lepton/lpt-parser/validator.lua:347
if tag == "Nil" or tag == "Boolean" or tag == "Number" or tag == "String" or tag == "StringFormat" then -- ./lepton/lpt-parser/validator.lua:353
return true -- ./lepton/lpt-parser/validator.lua:354
elseif tag == "Dots" then -- ./lepton/lpt-parser/validator.lua:355
return traverse_vararg(env, exp) -- ./lepton/lpt-parser/validator.lua:356
elseif tag == "Function" then -- ./lepton/lpt-parser/validator.lua:357
return traverse_function(env, exp) -- ./lepton/lpt-parser/validator.lua:358
elseif tag == "Table" then -- ./lepton/lpt-parser/validator.lua:359
return traverse_table(env, exp) -- ./lepton/lpt-parser/validator.lua:360
elseif tag == "Op" then -- ./lepton/lpt-parser/validator.lua:361
return traverse_op(env, exp) -- ./lepton/lpt-parser/validator.lua:362
elseif tag == "Paren" then -- ./lepton/lpt-parser/validator.lua:363
return traverse_paren(env, exp) -- ./lepton/lpt-parser/validator.lua:364
elseif calls[tag] then -- ./lepton/lpt-parser/validator.lua:365
return traverse_call(env, exp) -- ./lepton/lpt-parser/validator.lua:366
elseif tag == "Id" or tag == "Index" then -- ./lepton/lpt-parser/validator.lua:368
return traverse_var(env, exp) -- ./lepton/lpt-parser/validator.lua:369
elseif tag == "SafeIndex" then -- ./lepton/lpt-parser/validator.lua:370
return traverse_safeindex(env, exp) -- ./lepton/lpt-parser/validator.lua:371
elseif tag == "TableCompr" then -- ./lepton/lpt-parser/validator.lua:372
return traverse_tablecompr(env, exp) -- ./lepton/lpt-parser/validator.lua:373
elseif tag == "MethodStub" or tag == "SafeMethodStub" then -- ./lepton/lpt-parser/validator.lua:374
return traverse_methodstub(env, exp) -- ./lepton/lpt-parser/validator.lua:375
elseif tag:match("Expr$") then -- ./lepton/lpt-parser/validator.lua:376
return traverse_statexpr(env, exp) -- ./lepton/lpt-parser/validator.lua:377
else -- ./lepton/lpt-parser/validator.lua:377
error("expecting an expression, but got a " .. tag) -- ./lepton/lpt-parser/validator.lua:379
end -- ./lepton/lpt-parser/validator.lua:379
end -- ./lepton/lpt-parser/validator.lua:379
traverse_explist = function(env, explist) -- ./lepton/lpt-parser/validator.lua:383
for k, v in ipairs(explist) do -- ./lepton/lpt-parser/validator.lua:384
local status, msg = traverse_exp(env, v) -- ./lepton/lpt-parser/validator.lua:385
if not status then -- ./lepton/lpt-parser/validator.lua:386
return status, msg -- ./lepton/lpt-parser/validator.lua:386
end -- ./lepton/lpt-parser/validator.lua:386
end -- ./lepton/lpt-parser/validator.lua:386
return true -- ./lepton/lpt-parser/validator.lua:388
end -- ./lepton/lpt-parser/validator.lua:388
traverse_stm = function(env, stm) -- ./lepton/lpt-parser/validator.lua:391
local tag = stm["tag"] -- ./lepton/lpt-parser/validator.lua:392
if tag == "Do" then -- ./lepton/lpt-parser/validator.lua:393
return traverse_block(env, stm) -- ./lepton/lpt-parser/validator.lua:394
elseif tag == "Set" then -- ./lepton/lpt-parser/validator.lua:395
return traverse_assignment(env, stm) -- ./lepton/lpt-parser/validator.lua:396
elseif tag == "AppendSet" then -- ./lepton/lpt-parser/validator.lua:397
return traverse_assignment(env, stm) -- ./lepton/lpt-parser/validator.lua:398
elseif tag == "While" then -- ./lepton/lpt-parser/validator.lua:399
return traverse_while(env, stm) -- ./lepton/lpt-parser/validator.lua:400
elseif tag == "Repeat" then -- ./lepton/lpt-parser/validator.lua:401
return traverse_repeat(env, stm) -- ./lepton/lpt-parser/validator.lua:402
elseif tag == "If" then -- ./lepton/lpt-parser/validator.lua:403
return traverse_if(env, stm) -- ./lepton/lpt-parser/validator.lua:404
elseif tag == "Fornum" then -- ./lepton/lpt-parser/validator.lua:405
return traverse_fornum(env, stm) -- ./lepton/lpt-parser/validator.lua:406
elseif tag == "Forin" then -- ./lepton/lpt-parser/validator.lua:407
return traverse_forin(env, stm) -- ./lepton/lpt-parser/validator.lua:408
elseif tag == "Local" or tag == "Let" then -- ./lepton/lpt-parser/validator.lua:410
return traverse_let(env, stm) -- ./lepton/lpt-parser/validator.lua:411
elseif tag == "Localrec" then -- ./lepton/lpt-parser/validator.lua:412
return traverse_letrec(env, stm) -- ./lepton/lpt-parser/validator.lua:413
elseif tag == "Goto" then -- ./lepton/lpt-parser/validator.lua:414
return traverse_goto(env, stm) -- ./lepton/lpt-parser/validator.lua:415
elseif tag == "Label" then -- ./lepton/lpt-parser/validator.lua:416
return traverse_label(env, stm) -- ./lepton/lpt-parser/validator.lua:417
elseif tag == "Return" then -- ./lepton/lpt-parser/validator.lua:418
return traverse_return(env, stm) -- ./lepton/lpt-parser/validator.lua:419
elseif tag == "Break" then -- ./lepton/lpt-parser/validator.lua:420
return traverse_break(env, stm) -- ./lepton/lpt-parser/validator.lua:421
elseif tag == "Call" then -- ./lepton/lpt-parser/validator.lua:422
return traverse_call(env, stm) -- ./lepton/lpt-parser/validator.lua:423
elseif tag == "Continue" then -- ./lepton/lpt-parser/validator.lua:424
return traverse_continue(env, stm) -- ./lepton/lpt-parser/validator.lua:425
elseif tag == "Push" then -- ./lepton/lpt-parser/validator.lua:426
return traverse_push(env, stm) -- ./lepton/lpt-parser/validator.lua:427
elseif tag == "Broadcast" or tag == "BroadcastKV" or tag == "Filter" or tag == "FilterKV" then -- ./lepton/lpt-parser/validator.lua:428
return traverse_call(env, stm) -- ./lepton/lpt-parser/validator.lua:429
else -- ./lepton/lpt-parser/validator.lua:429
error("expecting a statement, but got a " .. tag) -- ./lepton/lpt-parser/validator.lua:431
end -- ./lepton/lpt-parser/validator.lua:431
end -- ./lepton/lpt-parser/validator.lua:431
traverse_block = function(env, block) -- ./lepton/lpt-parser/validator.lua:435
local l = {} -- ./lepton/lpt-parser/validator.lua:436
new_scope(env) -- ./lepton/lpt-parser/validator.lua:437
for k, v in ipairs(block) do -- ./lepton/lpt-parser/validator.lua:438
local status, msg = traverse_stm(env, v) -- ./lepton/lpt-parser/validator.lua:439
if not status then -- ./lepton/lpt-parser/validator.lua:440
return status, msg -- ./lepton/lpt-parser/validator.lua:440
end -- ./lepton/lpt-parser/validator.lua:440
end -- ./lepton/lpt-parser/validator.lua:440
end_scope(env) -- ./lepton/lpt-parser/validator.lua:442
return true -- ./lepton/lpt-parser/validator.lua:443
end -- ./lepton/lpt-parser/validator.lua:443
local function traverse(ast, errorinfo) -- ./lepton/lpt-parser/validator.lua:447
assert(type(ast) == "table") -- ./lepton/lpt-parser/validator.lua:448
assert(type(errorinfo) == "table") -- ./lepton/lpt-parser/validator.lua:449
local env = { -- ./lepton/lpt-parser/validator.lua:450
["errorinfo"] = errorinfo, -- ./lepton/lpt-parser/validator.lua:450
["function"] = {} -- ./lepton/lpt-parser/validator.lua:450
} -- ./lepton/lpt-parser/validator.lua:450
new_function(env) -- ./lepton/lpt-parser/validator.lua:451
set_vararg(env, true) -- ./lepton/lpt-parser/validator.lua:452
local status, msg = traverse_block(env, ast) -- ./lepton/lpt-parser/validator.lua:453
if not status then -- ./lepton/lpt-parser/validator.lua:454
return status, msg -- ./lepton/lpt-parser/validator.lua:454
end -- ./lepton/lpt-parser/validator.lua:454
end_function(env) -- ./lepton/lpt-parser/validator.lua:455
status, msg = verify_pending_gotos(env) -- ./lepton/lpt-parser/validator.lua:456
if not status then -- ./lepton/lpt-parser/validator.lua:457
return status, msg -- ./lepton/lpt-parser/validator.lua:457
end -- ./lepton/lpt-parser/validator.lua:457
return ast -- ./lepton/lpt-parser/validator.lua:458
end -- ./lepton/lpt-parser/validator.lua:458
return { -- ./lepton/lpt-parser/validator.lua:461
["validate"] = traverse, -- ./lepton/lpt-parser/validator.lua:461
["syntaxerror"] = syntaxerror -- ./lepton/lpt-parser/validator.lua:461
} -- ./lepton/lpt-parser/validator.lua:461
end -- ./lepton/lpt-parser/validator.lua:461
local validator = _() or validator -- ./lepton/lpt-parser/validator.lua:465
package["loaded"]["lepton.lpt-parser.validator"] = validator or true -- ./lepton/lpt-parser/validator.lua:466
local function _() -- ./lepton/lpt-parser/validator.lua:469
local pp = {} -- ./lepton/lpt-parser/pp.lua:4
local block2str, stm2str, exp2str, var2str -- ./lepton/lpt-parser/pp.lua:6
local explist2str, varlist2str, parlist2str, fieldlist2str -- ./lepton/lpt-parser/pp.lua:7
local function iscntrl(x) -- ./lepton/lpt-parser/pp.lua:9
if (x >= 0 and x <= 31) or (x == 127) then -- ./lepton/lpt-parser/pp.lua:10
return true -- ./lepton/lpt-parser/pp.lua:10
end -- ./lepton/lpt-parser/pp.lua:10
return false -- ./lepton/lpt-parser/pp.lua:11
end -- ./lepton/lpt-parser/pp.lua:11
local function isprint(x) -- ./lepton/lpt-parser/pp.lua:14
return not iscntrl(x) -- ./lepton/lpt-parser/pp.lua:15
end -- ./lepton/lpt-parser/pp.lua:15
local function fixed_string(str) -- ./lepton/lpt-parser/pp.lua:18
local new_str = "" -- ./lepton/lpt-parser/pp.lua:19
for i = 1, string["len"](str) do -- ./lepton/lpt-parser/pp.lua:20
char = string["byte"](str, i) -- ./lepton/lpt-parser/pp.lua:21
if char == 34 then -- ./lepton/lpt-parser/pp.lua:22
new_str = new_str .. string["format"]("\\\"") -- ./lepton/lpt-parser/pp.lua:22
elseif char == 92 then -- ./lepton/lpt-parser/pp.lua:23
new_str = new_str .. string["format"]("\\\\") -- ./lepton/lpt-parser/pp.lua:23
elseif char == 7 then -- ./lepton/lpt-parser/pp.lua:24
new_str = new_str .. string["format"]("\\a") -- ./lepton/lpt-parser/pp.lua:24
elseif char == 8 then -- ./lepton/lpt-parser/pp.lua:25
new_str = new_str .. string["format"]("\\b") -- ./lepton/lpt-parser/pp.lua:25
elseif char == 12 then -- ./lepton/lpt-parser/pp.lua:26
new_str = new_str .. string["format"]("\\f") -- ./lepton/lpt-parser/pp.lua:26
elseif char == 10 then -- ./lepton/lpt-parser/pp.lua:27
new_str = new_str .. string["format"]("\\n") -- ./lepton/lpt-parser/pp.lua:27
elseif char == 13 then -- ./lepton/lpt-parser/pp.lua:28
new_str = new_str .. string["format"]("\\r") -- ./lepton/lpt-parser/pp.lua:28
elseif char == 9 then -- ./lepton/lpt-parser/pp.lua:29
new_str = new_str .. string["format"]("\\t") -- ./lepton/lpt-parser/pp.lua:29
elseif char == 11 then -- ./lepton/lpt-parser/pp.lua:30
new_str = new_str .. string["format"]("\\v") -- ./lepton/lpt-parser/pp.lua:30
else -- ./lepton/lpt-parser/pp.lua:30
if isprint(char) then -- ./lepton/lpt-parser/pp.lua:32
new_str = new_str .. string["format"]("%c", char) -- ./lepton/lpt-parser/pp.lua:33
else -- ./lepton/lpt-parser/pp.lua:33
new_str = new_str .. string["format"]("\\%03d", char) -- ./lepton/lpt-parser/pp.lua:35
end -- ./lepton/lpt-parser/pp.lua:35
end -- ./lepton/lpt-parser/pp.lua:35
end -- ./lepton/lpt-parser/pp.lua:35
return new_str -- ./lepton/lpt-parser/pp.lua:39
end -- ./lepton/lpt-parser/pp.lua:39
local function name2str(name) -- ./lepton/lpt-parser/pp.lua:42
return string["format"]("\"%s\"", name) -- ./lepton/lpt-parser/pp.lua:43
end -- ./lepton/lpt-parser/pp.lua:43
local function boolean2str(b) -- ./lepton/lpt-parser/pp.lua:46
return string["format"]("\"%s\"", tostring(b)) -- ./lepton/lpt-parser/pp.lua:47
end -- ./lepton/lpt-parser/pp.lua:47
local function number2str(n) -- ./lepton/lpt-parser/pp.lua:50
return string["format"]("\"%s\"", tostring(n)) -- ./lepton/lpt-parser/pp.lua:51
end -- ./lepton/lpt-parser/pp.lua:51
local function string2str(s) -- ./lepton/lpt-parser/pp.lua:54
return string["format"]("\"%s\"", fixed_string(s)) -- ./lepton/lpt-parser/pp.lua:55
end -- ./lepton/lpt-parser/pp.lua:55
var2str = function(var) -- ./lepton/lpt-parser/pp.lua:58
local tag = var["tag"] -- ./lepton/lpt-parser/pp.lua:59
local str = "`" .. tag -- ./lepton/lpt-parser/pp.lua:60
if tag == "Id" then -- ./lepton/lpt-parser/pp.lua:61
str = str .. " " .. name2str(var[1]) -- ./lepton/lpt-parser/pp.lua:62
elseif tag == "Index" then -- ./lepton/lpt-parser/pp.lua:63
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:64
str = str .. exp2str(var[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:65
str = str .. exp2str(var[2]) -- ./lepton/lpt-parser/pp.lua:66
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:67
else -- ./lepton/lpt-parser/pp.lua:67
str = str .. " \"" .. var[1] .. "\"" -- ./lepton/lpt-parser/pp.lua:70
end -- ./lepton/lpt-parser/pp.lua:70
return str -- ./lepton/lpt-parser/pp.lua:72
end -- ./lepton/lpt-parser/pp.lua:72
varlist2str = function(varlist) -- ./lepton/lpt-parser/pp.lua:75
local l = {} -- ./lepton/lpt-parser/pp.lua:76
for k, v in ipairs(varlist) do -- ./lepton/lpt-parser/pp.lua:77
l[k] = var2str(v) -- ./lepton/lpt-parser/pp.lua:78
end -- ./lepton/lpt-parser/pp.lua:78
return "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:80
end -- ./lepton/lpt-parser/pp.lua:80
parlist2str = function(parlist) -- ./lepton/lpt-parser/pp.lua:83
local l = {} -- ./lepton/lpt-parser/pp.lua:84
local len = # parlist -- ./lepton/lpt-parser/pp.lua:85
local is_vararg = false -- ./lepton/lpt-parser/pp.lua:86
if len > 0 and parlist[len]["tag"] == "Dots" then -- ./lepton/lpt-parser/pp.lua:87
is_vararg = true -- ./lepton/lpt-parser/pp.lua:88
len = len - 1 -- ./lepton/lpt-parser/pp.lua:89
end -- ./lepton/lpt-parser/pp.lua:89
local i = 1 -- ./lepton/lpt-parser/pp.lua:91
while i <= len do -- ./lepton/lpt-parser/pp.lua:92
l[i] = var2str(parlist[i]) -- ./lepton/lpt-parser/pp.lua:93
i = i + 1 -- ./lepton/lpt-parser/pp.lua:94
end -- ./lepton/lpt-parser/pp.lua:94
if is_vararg then -- ./lepton/lpt-parser/pp.lua:96
l[i] = "`" .. parlist[i]["tag"] -- ./lepton/lpt-parser/pp.lua:97
end -- ./lepton/lpt-parser/pp.lua:97
return "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:99
end -- ./lepton/lpt-parser/pp.lua:99
fieldlist2str = function(fieldlist) -- ./lepton/lpt-parser/pp.lua:102
local l = {} -- ./lepton/lpt-parser/pp.lua:103
for k, v in ipairs(fieldlist) do -- ./lepton/lpt-parser/pp.lua:104
local tag = v["tag"] -- ./lepton/lpt-parser/pp.lua:105
if tag == "Pair" then -- ./lepton/lpt-parser/pp.lua:106
l[k] = "`" .. tag .. "{ " -- ./lepton/lpt-parser/pp.lua:107
l[k] = l[k] .. exp2str(v[1]) .. ", " .. exp2str(v[2]) -- ./lepton/lpt-parser/pp.lua:108
l[k] = l[k] .. " }" -- ./lepton/lpt-parser/pp.lua:109
else -- ./lepton/lpt-parser/pp.lua:109
l[k] = exp2str(v) -- ./lepton/lpt-parser/pp.lua:111
end -- ./lepton/lpt-parser/pp.lua:111
end -- ./lepton/lpt-parser/pp.lua:111
if # l > 0 then -- ./lepton/lpt-parser/pp.lua:114
return "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:115
else -- ./lepton/lpt-parser/pp.lua:115
return "" -- ./lepton/lpt-parser/pp.lua:117
end -- ./lepton/lpt-parser/pp.lua:117
end -- ./lepton/lpt-parser/pp.lua:117
exp2str = function(exp) -- ./lepton/lpt-parser/pp.lua:121
local tag = exp["tag"] -- ./lepton/lpt-parser/pp.lua:122
local str = "`" .. tag -- ./lepton/lpt-parser/pp.lua:123
if tag == "Nil" or tag == "Dots" then -- ./lepton/lpt-parser/pp.lua:125
 -- ./lepton/lpt-parser/pp.lua:126
elseif tag == "Boolean" then -- ./lepton/lpt-parser/pp.lua:126
str = str .. " " .. boolean2str(exp[1]) -- ./lepton/lpt-parser/pp.lua:127
elseif tag == "Number" then -- ./lepton/lpt-parser/pp.lua:128
str = str .. " " .. number2str(exp[1]) -- ./lepton/lpt-parser/pp.lua:129
elseif tag == "String" then -- ./lepton/lpt-parser/pp.lua:130
str = str .. " " .. string2str(exp[1]) -- ./lepton/lpt-parser/pp.lua:131
elseif tag == "Function" then -- ./lepton/lpt-parser/pp.lua:132
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:133
str = str .. parlist2str(exp[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:134
str = str .. block2str(exp[2]) -- ./lepton/lpt-parser/pp.lua:135
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:136
elseif tag == "Table" then -- ./lepton/lpt-parser/pp.lua:137
str = str .. fieldlist2str(exp) -- ./lepton/lpt-parser/pp.lua:138
elseif tag == "Op" then -- ./lepton/lpt-parser/pp.lua:139
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:140
str = str .. name2str(exp[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:141
str = str .. exp2str(exp[2]) -- ./lepton/lpt-parser/pp.lua:142
if exp[3] then -- ./lepton/lpt-parser/pp.lua:143
str = str .. ", " .. exp2str(exp[3]) -- ./lepton/lpt-parser/pp.lua:144
end -- ./lepton/lpt-parser/pp.lua:144
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:146
elseif tag == "Paren" then -- ./lepton/lpt-parser/pp.lua:147
str = str .. "{ " .. exp2str(exp[1]) .. " }" -- ./lepton/lpt-parser/pp.lua:148
elseif tag == "Call" then -- ./lepton/lpt-parser/pp.lua:149
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:150
str = str .. exp2str(exp[1]) -- ./lepton/lpt-parser/pp.lua:151
if exp[2] then -- ./lepton/lpt-parser/pp.lua:152
for i = 2, # exp do -- ./lepton/lpt-parser/pp.lua:153
str = str .. ", " .. exp2str(exp[i]) -- ./lepton/lpt-parser/pp.lua:154
end -- ./lepton/lpt-parser/pp.lua:154
end -- ./lepton/lpt-parser/pp.lua:154
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:157
elseif tag == "Invoke" then -- ./lepton/lpt-parser/pp.lua:158
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:159
str = str .. exp2str(exp[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:160
str = str .. exp2str(exp[2]) -- ./lepton/lpt-parser/pp.lua:161
if exp[3] then -- ./lepton/lpt-parser/pp.lua:162
for i = 3, # exp do -- ./lepton/lpt-parser/pp.lua:163
str = str .. ", " .. exp2str(exp[i]) -- ./lepton/lpt-parser/pp.lua:164
end -- ./lepton/lpt-parser/pp.lua:164
end -- ./lepton/lpt-parser/pp.lua:164
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:167
elseif tag == "Id" or tag == "Index" then -- ./lepton/lpt-parser/pp.lua:169
str = var2str(exp) -- ./lepton/lpt-parser/pp.lua:170
else -- ./lepton/lpt-parser/pp.lua:170
str = str .. " \"" .. exp[1] .. "\"" -- ./lepton/lpt-parser/pp.lua:173
end -- ./lepton/lpt-parser/pp.lua:173
return str -- ./lepton/lpt-parser/pp.lua:175
end -- ./lepton/lpt-parser/pp.lua:175
explist2str = function(explist) -- ./lepton/lpt-parser/pp.lua:178
local l = {} -- ./lepton/lpt-parser/pp.lua:179
for k, v in ipairs(explist) do -- ./lepton/lpt-parser/pp.lua:180
l[k] = exp2str(v) -- ./lepton/lpt-parser/pp.lua:181
end -- ./lepton/lpt-parser/pp.lua:181
if # l > 0 then -- ./lepton/lpt-parser/pp.lua:183
return "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:184
else -- ./lepton/lpt-parser/pp.lua:184
return "" -- ./lepton/lpt-parser/pp.lua:186
end -- ./lepton/lpt-parser/pp.lua:186
end -- ./lepton/lpt-parser/pp.lua:186
stm2str = function(stm) -- ./lepton/lpt-parser/pp.lua:190
local tag = stm["tag"] -- ./lepton/lpt-parser/pp.lua:191
local str = "`" .. tag -- ./lepton/lpt-parser/pp.lua:192
if tag == "Do" then -- ./lepton/lpt-parser/pp.lua:193
local l = {} -- ./lepton/lpt-parser/pp.lua:194
for k, v in ipairs(stm) do -- ./lepton/lpt-parser/pp.lua:195
l[k] = stm2str(v) -- ./lepton/lpt-parser/pp.lua:196
end -- ./lepton/lpt-parser/pp.lua:196
str = str .. "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:198
elseif tag == "Set" then -- ./lepton/lpt-parser/pp.lua:199
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:200
str = str .. varlist2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:201
str = str .. explist2str(stm[2]) -- ./lepton/lpt-parser/pp.lua:202
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:203
elseif tag == "While" then -- ./lepton/lpt-parser/pp.lua:204
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:205
str = str .. exp2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:206
str = str .. block2str(stm[2]) -- ./lepton/lpt-parser/pp.lua:207
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:208
elseif tag == "Repeat" then -- ./lepton/lpt-parser/pp.lua:209
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:210
str = str .. block2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:211
str = str .. exp2str(stm[2]) -- ./lepton/lpt-parser/pp.lua:212
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:213
elseif tag == "If" then -- ./lepton/lpt-parser/pp.lua:214
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:215
local len = # stm -- ./lepton/lpt-parser/pp.lua:216
if len % 2 == 0 then -- ./lepton/lpt-parser/pp.lua:217
local l = {} -- ./lepton/lpt-parser/pp.lua:218
for i = 1, len - 2, 2 do -- ./lepton/lpt-parser/pp.lua:219
str = str .. exp2str(stm[i]) .. ", " .. block2str(stm[i + 1]) .. ", " -- ./lepton/lpt-parser/pp.lua:220
end -- ./lepton/lpt-parser/pp.lua:220
str = str .. exp2str(stm[len - 1]) .. ", " .. block2str(stm[len]) -- ./lepton/lpt-parser/pp.lua:222
else -- ./lepton/lpt-parser/pp.lua:222
local l = {} -- ./lepton/lpt-parser/pp.lua:224
for i = 1, len - 3, 2 do -- ./lepton/lpt-parser/pp.lua:225
str = str .. exp2str(stm[i]) .. ", " .. block2str(stm[i + 1]) .. ", " -- ./lepton/lpt-parser/pp.lua:226
end -- ./lepton/lpt-parser/pp.lua:226
str = str .. exp2str(stm[len - 2]) .. ", " .. block2str(stm[len - 1]) .. ", " -- ./lepton/lpt-parser/pp.lua:228
str = str .. block2str(stm[len]) -- ./lepton/lpt-parser/pp.lua:229
end -- ./lepton/lpt-parser/pp.lua:229
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:231
elseif tag == "Fornum" then -- ./lepton/lpt-parser/pp.lua:232
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:233
str = str .. var2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:234
str = str .. exp2str(stm[2]) .. ", " -- ./lepton/lpt-parser/pp.lua:235
str = str .. exp2str(stm[3]) .. ", " -- ./lepton/lpt-parser/pp.lua:236
if stm[5] then -- ./lepton/lpt-parser/pp.lua:237
str = str .. exp2str(stm[4]) .. ", " -- ./lepton/lpt-parser/pp.lua:238
str = str .. block2str(stm[5]) -- ./lepton/lpt-parser/pp.lua:239
else -- ./lepton/lpt-parser/pp.lua:239
str = str .. block2str(stm[4]) -- ./lepton/lpt-parser/pp.lua:241
end -- ./lepton/lpt-parser/pp.lua:241
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:243
elseif tag == "Forin" then -- ./lepton/lpt-parser/pp.lua:244
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:245
str = str .. varlist2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:246
str = str .. explist2str(stm[2]) .. ", " -- ./lepton/lpt-parser/pp.lua:247
str = str .. block2str(stm[3]) -- ./lepton/lpt-parser/pp.lua:248
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:249
elseif tag == "Local" then -- ./lepton/lpt-parser/pp.lua:250
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:251
str = str .. varlist2str(stm[1]) -- ./lepton/lpt-parser/pp.lua:252
if # stm[2] > 0 then -- ./lepton/lpt-parser/pp.lua:253
str = str .. ", " .. explist2str(stm[2]) -- ./lepton/lpt-parser/pp.lua:254
else -- ./lepton/lpt-parser/pp.lua:254
str = str .. ", " .. "{  }" -- ./lepton/lpt-parser/pp.lua:256
end -- ./lepton/lpt-parser/pp.lua:256
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:258
elseif tag == "Localrec" then -- ./lepton/lpt-parser/pp.lua:259
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:260
str = str .. "{ " .. var2str(stm[1][1]) .. " }, " -- ./lepton/lpt-parser/pp.lua:261
str = str .. "{ " .. exp2str(stm[2][1]) .. " }" -- ./lepton/lpt-parser/pp.lua:262
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:263
elseif tag == "Goto" or tag == "Label" then -- ./lepton/lpt-parser/pp.lua:265
str = str .. "{ " .. name2str(stm[1]) .. " }" -- ./lepton/lpt-parser/pp.lua:266
elseif tag == "Return" then -- ./lepton/lpt-parser/pp.lua:267
str = str .. explist2str(stm) -- ./lepton/lpt-parser/pp.lua:268
elseif tag == "Break" then -- ./lepton/lpt-parser/pp.lua:269
 -- ./lepton/lpt-parser/pp.lua:270
elseif tag == "Call" then -- ./lepton/lpt-parser/pp.lua:270
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:271
str = str .. exp2str(stm[1]) -- ./lepton/lpt-parser/pp.lua:272
if stm[2] then -- ./lepton/lpt-parser/pp.lua:273
for i = 2, # stm do -- ./lepton/lpt-parser/pp.lua:274
str = str .. ", " .. exp2str(stm[i]) -- ./lepton/lpt-parser/pp.lua:275
end -- ./lepton/lpt-parser/pp.lua:275
end -- ./lepton/lpt-parser/pp.lua:275
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:278
elseif tag == "Invoke" then -- ./lepton/lpt-parser/pp.lua:279
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:280
str = str .. exp2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:281
str = str .. exp2str(stm[2]) -- ./lepton/lpt-parser/pp.lua:282
if stm[3] then -- ./lepton/lpt-parser/pp.lua:283
for i = 3, # stm do -- ./lepton/lpt-parser/pp.lua:284
str = str .. ", " .. exp2str(stm[i]) -- ./lepton/lpt-parser/pp.lua:285
end -- ./lepton/lpt-parser/pp.lua:285
end -- ./lepton/lpt-parser/pp.lua:285
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:288
else -- ./lepton/lpt-parser/pp.lua:288
str = str .. " \"" .. stm[1] .. "\"" -- ./lepton/lpt-parser/pp.lua:291
end -- ./lepton/lpt-parser/pp.lua:291
return str -- ./lepton/lpt-parser/pp.lua:293
end -- ./lepton/lpt-parser/pp.lua:293
block2str = function(block) -- ./lepton/lpt-parser/pp.lua:296
local l = {} -- ./lepton/lpt-parser/pp.lua:297
for k, v in ipairs(block) do -- ./lepton/lpt-parser/pp.lua:298
l[k] = stm2str(v) -- ./lepton/lpt-parser/pp.lua:299
end -- ./lepton/lpt-parser/pp.lua:299
return "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:301
end -- ./lepton/lpt-parser/pp.lua:301
pp["tostring"] = function(t) -- ./lepton/lpt-parser/pp.lua:304
assert(type(t) == "table") -- ./lepton/lpt-parser/pp.lua:305
return block2str(t) -- ./lepton/lpt-parser/pp.lua:306
end -- ./lepton/lpt-parser/pp.lua:306
pp["print"] = function(t) -- ./lepton/lpt-parser/pp.lua:309
assert(type(t) == "table") -- ./lepton/lpt-parser/pp.lua:310
print(pp["tostring"](t)) -- ./lepton/lpt-parser/pp.lua:311
end -- ./lepton/lpt-parser/pp.lua:311
pp["dump"] = function(t, i) -- ./lepton/lpt-parser/pp.lua:314
if i == nil then -- ./lepton/lpt-parser/pp.lua:315
i = 0 -- ./lepton/lpt-parser/pp.lua:315
end -- ./lepton/lpt-parser/pp.lua:315
io["write"](string["format"]("{\
")) -- ./lepton/lpt-parser/pp.lua:316
io["write"](string["format"]("%s[tag] = %s\
", string["rep"](" ", i + 2), t["tag"] or "nil")) -- ./lepton/lpt-parser/pp.lua:317
io["write"](string["format"]("%s[pos] = %s\
", string["rep"](" ", i + 2), t["pos"] or "nil")) -- ./lepton/lpt-parser/pp.lua:318
for k, v in ipairs(t) do -- ./lepton/lpt-parser/pp.lua:319
io["write"](string["format"]("%s[%s] = ", string["rep"](" ", i + 2), tostring(k))) -- ./lepton/lpt-parser/pp.lua:320
if type(v) == "table" then -- ./lepton/lpt-parser/pp.lua:321
pp["dump"](v, i + 2) -- ./lepton/lpt-parser/pp.lua:322
else -- ./lepton/lpt-parser/pp.lua:322
io["write"](string["format"]("%s\
", tostring(v))) -- ./lepton/lpt-parser/pp.lua:324
end -- ./lepton/lpt-parser/pp.lua:324
end -- ./lepton/lpt-parser/pp.lua:324
io["write"](string["format"]("%s}\
", string["rep"](" ", i))) -- ./lepton/lpt-parser/pp.lua:327
end -- ./lepton/lpt-parser/pp.lua:327
return pp -- ./lepton/lpt-parser/pp.lua:330
end -- ./lepton/lpt-parser/pp.lua:330
local pp = _() or pp -- ./lepton/lpt-parser/pp.lua:334
package["loaded"]["lepton.lpt-parser.pp"] = pp or true -- ./lepton/lpt-parser/pp.lua:335
local function _() -- ./lepton/lpt-parser/pp.lua:338
local lpeg = require("lpeglabel") -- ./lepton/lpt-parser/parser.lua:75
lpeg["locale"](lpeg) -- ./lepton/lpt-parser/parser.lua:77
local P, S, V = lpeg["P"], lpeg["S"], lpeg["V"] -- ./lepton/lpt-parser/parser.lua:79
local C, Carg, Cb, Cc = lpeg["C"], lpeg["Carg"], lpeg["Cb"], lpeg["Cc"] -- ./lepton/lpt-parser/parser.lua:80
local Cf, Cg, Cmt, Cp, Cs, Ct = lpeg["Cf"], lpeg["Cg"], lpeg["Cmt"], lpeg["Cp"], lpeg["Cs"], lpeg["Ct"] -- ./lepton/lpt-parser/parser.lua:81
local Rec, T = lpeg["Rec"], lpeg["T"] -- ./lepton/lpt-parser/parser.lua:84
local alpha, alnum = lpeg["alpha"], lpeg["alnum"] -- ./lepton/lpt-parser/parser.lua:86
local digit = lpeg["digit"] + P("_") -- ./lepton/lpt-parser/parser.lua:87
local xdigit = lpeg["xdigit"] + P("_") -- ./lepton/lpt-parser/parser.lua:88
local space = lpeg["space"] -- ./lepton/lpt-parser/parser.lua:89
local labels = { -- ./lepton/lpt-parser/parser.lua:93
{ -- ./lepton/lpt-parser/parser.lua:94
"ErrExtra", -- ./lepton/lpt-parser/parser.lua:94
"unexpected character(s), expected EOF" -- ./lepton/lpt-parser/parser.lua:94
}, -- ./lepton/lpt-parser/parser.lua:94
{ -- ./lepton/lpt-parser/parser.lua:95
"ErrInvalidStat", -- ./lepton/lpt-parser/parser.lua:95
"unexpected token, invalid start of statement" -- ./lepton/lpt-parser/parser.lua:95
}, -- ./lepton/lpt-parser/parser.lua:95
{ -- ./lepton/lpt-parser/parser.lua:97
"ErrExprIf", -- ./lepton/lpt-parser/parser.lua:97
"expected a condition after 'if'" -- ./lepton/lpt-parser/parser.lua:97
}, -- ./lepton/lpt-parser/parser.lua:97
{ -- ./lepton/lpt-parser/parser.lua:98
"ErrOIf", -- ./lepton/lpt-parser/parser.lua:98
"expected '{' after the condition" -- ./lepton/lpt-parser/parser.lua:98
}, -- ./lepton/lpt-parser/parser.lua:98
{ -- ./lepton/lpt-parser/parser.lua:99
"ErrCIf", -- ./lepton/lpt-parser/parser.lua:99
"expected '}' to close the if statement" -- ./lepton/lpt-parser/parser.lua:99
}, -- ./lepton/lpt-parser/parser.lua:99
{ -- ./lepton/lpt-parser/parser.lua:100
"ErrOElse", -- ./lepton/lpt-parser/parser.lua:100
"expected '{' after 'else'" -- ./lepton/lpt-parser/parser.lua:100
}, -- ./lepton/lpt-parser/parser.lua:100
{ -- ./lepton/lpt-parser/parser.lua:102
"ErrODo", -- ./lepton/lpt-parser/parser.lua:102
"expected '{' after 'do'" -- ./lepton/lpt-parser/parser.lua:102
}, -- ./lepton/lpt-parser/parser.lua:102
{ -- ./lepton/lpt-parser/parser.lua:103
"ErrCDo", -- ./lepton/lpt-parser/parser.lua:103
"expected '}' to close the do block" -- ./lepton/lpt-parser/parser.lua:103
}, -- ./lepton/lpt-parser/parser.lua:103
{ -- ./lepton/lpt-parser/parser.lua:104
"ErrExprWhile", -- ./lepton/lpt-parser/parser.lua:104
"expected a condition after 'while'" -- ./lepton/lpt-parser/parser.lua:104
}, -- ./lepton/lpt-parser/parser.lua:104
{ -- ./lepton/lpt-parser/parser.lua:105
"ErrDoWhile", -- ./lepton/lpt-parser/parser.lua:105
"expected '{' after the condition" -- ./lepton/lpt-parser/parser.lua:105
}, -- ./lepton/lpt-parser/parser.lua:105
{ -- ./lepton/lpt-parser/parser.lua:106
"ErrEndWhile", -- ./lepton/lpt-parser/parser.lua:106
"expected '}' to close the while loop" -- ./lepton/lpt-parser/parser.lua:106
}, -- ./lepton/lpt-parser/parser.lua:106
{ -- ./lepton/lpt-parser/parser.lua:107
"ErrORep", -- ./lepton/lpt-parser/parser.lua:107
"expected '{' after 'repeat'" -- ./lepton/lpt-parser/parser.lua:107
}, -- ./lepton/lpt-parser/parser.lua:107
{ -- ./lepton/lpt-parser/parser.lua:108
"ErrCRep", -- ./lepton/lpt-parser/parser.lua:108
"expected '}' to close the repeat loop" -- ./lepton/lpt-parser/parser.lua:108
}, -- ./lepton/lpt-parser/parser.lua:108
{ -- ./lepton/lpt-parser/parser.lua:109
"ErrUntilRep", -- ./lepton/lpt-parser/parser.lua:109
"expected 'until' after the end of the repeat loop" -- ./lepton/lpt-parser/parser.lua:109
}, -- ./lepton/lpt-parser/parser.lua:109
{ -- ./lepton/lpt-parser/parser.lua:110
"ErrExprRep", -- ./lepton/lpt-parser/parser.lua:110
"expected a condition after 'until'" -- ./lepton/lpt-parser/parser.lua:110
}, -- ./lepton/lpt-parser/parser.lua:110
{ -- ./lepton/lpt-parser/parser.lua:112
"ErrOFor", -- ./lepton/lpt-parser/parser.lua:112
"expected '{' after the range of the for loop" -- ./lepton/lpt-parser/parser.lua:112
}, -- ./lepton/lpt-parser/parser.lua:112
{ -- ./lepton/lpt-parser/parser.lua:113
"ErrForRange", -- ./lepton/lpt-parser/parser.lua:113
"expected a numeric or generic range after 'for'" -- ./lepton/lpt-parser/parser.lua:113
}, -- ./lepton/lpt-parser/parser.lua:113
{ -- ./lepton/lpt-parser/parser.lua:114
"ErrForRangeStart", -- ./lepton/lpt-parser/parser.lua:114
"expected a starting expression for the numeric range" -- ./lepton/lpt-parser/parser.lua:114
}, -- ./lepton/lpt-parser/parser.lua:114
{ -- ./lepton/lpt-parser/parser.lua:115
"ErrForRangeComma", -- ./lepton/lpt-parser/parser.lua:115
"expected ',' to split the start and end of the range" -- ./lepton/lpt-parser/parser.lua:115
}, -- ./lepton/lpt-parser/parser.lua:115
{ -- ./lepton/lpt-parser/parser.lua:116
"ErrForRangeEnd", -- ./lepton/lpt-parser/parser.lua:116
"expected an ending expression for the numeric range" -- ./lepton/lpt-parser/parser.lua:116
}, -- ./lepton/lpt-parser/parser.lua:116
{ -- ./lepton/lpt-parser/parser.lua:117
"ErrForRangeStep", -- ./lepton/lpt-parser/parser.lua:117
"expected a step expression for the numeric range after ','" -- ./lepton/lpt-parser/parser.lua:117
}, -- ./lepton/lpt-parser/parser.lua:117
{ -- ./lepton/lpt-parser/parser.lua:118
"ErrInFor", -- ./lepton/lpt-parser/parser.lua:118
"expected ':' after the variable(s)" -- ./lepton/lpt-parser/parser.lua:118
}, -- ./lepton/lpt-parser/parser.lua:118
{ -- ./lepton/lpt-parser/parser.lua:119
"ErrEListFor", -- ./lepton/lpt-parser/parser.lua:119
"expected one or more expressions after ':'" -- ./lepton/lpt-parser/parser.lua:119
}, -- ./lepton/lpt-parser/parser.lua:119
{ -- ./lepton/lpt-parser/parser.lua:120
"ErrCFor", -- ./lepton/lpt-parser/parser.lua:120
"expected '}' to close the for loop" -- ./lepton/lpt-parser/parser.lua:120
}, -- ./lepton/lpt-parser/parser.lua:120
{ -- ./lepton/lpt-parser/parser.lua:122
"ErrDefLocal", -- ./lepton/lpt-parser/parser.lua:122
"expected a function definition or assignment after 'local'" -- ./lepton/lpt-parser/parser.lua:122
}, -- ./lepton/lpt-parser/parser.lua:122
{ -- ./lepton/lpt-parser/parser.lua:123
"ErrDefLet", -- ./lepton/lpt-parser/parser.lua:123
"expected an assignment after 'let'" -- ./lepton/lpt-parser/parser.lua:123
}, -- ./lepton/lpt-parser/parser.lua:123
{ -- ./lepton/lpt-parser/parser.lua:124
"ErrDefClose", -- ./lepton/lpt-parser/parser.lua:124
"expected an assignment after 'close'" -- ./lepton/lpt-parser/parser.lua:124
}, -- ./lepton/lpt-parser/parser.lua:124
{ -- ./lepton/lpt-parser/parser.lua:125
"ErrDefConst", -- ./lepton/lpt-parser/parser.lua:125
"expected an assignment after 'const'" -- ./lepton/lpt-parser/parser.lua:125
}, -- ./lepton/lpt-parser/parser.lua:125
{ -- ./lepton/lpt-parser/parser.lua:126
"ErrNameLFunc", -- ./lepton/lpt-parser/parser.lua:126
"expected a function name after 'local fn'" -- ./lepton/lpt-parser/parser.lua:126
}, -- ./lepton/lpt-parser/parser.lua:126
{ -- ./lepton/lpt-parser/parser.lua:127
"ErrEListLAssign", -- ./lepton/lpt-parser/parser.lua:127
"expected one or more expressions after '='" -- ./lepton/lpt-parser/parser.lua:127
}, -- ./lepton/lpt-parser/parser.lua:127
{ -- ./lepton/lpt-parser/parser.lua:128
"ErrEListAssign", -- ./lepton/lpt-parser/parser.lua:128
"expected one or more expressions after '='" -- ./lepton/lpt-parser/parser.lua:128
}, -- ./lepton/lpt-parser/parser.lua:128
{ -- ./lepton/lpt-parser/parser.lua:130
"ErrFuncName", -- ./lepton/lpt-parser/parser.lua:130
"expected a function name after 'fn'" -- ./lepton/lpt-parser/parser.lua:130
}, -- ./lepton/lpt-parser/parser.lua:130
{ -- ./lepton/lpt-parser/parser.lua:131
"ErrNameFunc1", -- ./lepton/lpt-parser/parser.lua:131
"expected a function name after '.'" -- ./lepton/lpt-parser/parser.lua:131
}, -- ./lepton/lpt-parser/parser.lua:131
{ -- ./lepton/lpt-parser/parser.lua:132
"ErrNameFunc2", -- ./lepton/lpt-parser/parser.lua:132
"expected a method name after ':'" -- ./lepton/lpt-parser/parser.lua:132
}, -- ./lepton/lpt-parser/parser.lua:132
{ -- ./lepton/lpt-parser/parser.lua:133
"ErrOParenPList", -- ./lepton/lpt-parser/parser.lua:133
"expected '(' before the parameter list" -- ./lepton/lpt-parser/parser.lua:133
}, -- ./lepton/lpt-parser/parser.lua:133
{ -- ./lepton/lpt-parser/parser.lua:134
"ErrCParenPList", -- ./lepton/lpt-parser/parser.lua:134
"expected ')' to close the parameter list" -- ./lepton/lpt-parser/parser.lua:134
}, -- ./lepton/lpt-parser/parser.lua:134
{ -- ./lepton/lpt-parser/parser.lua:135
"ErrOFunc", -- ./lepton/lpt-parser/parser.lua:135
"expected '{' after the parameter list" -- ./lepton/lpt-parser/parser.lua:135
}, -- ./lepton/lpt-parser/parser.lua:135
{ -- ./lepton/lpt-parser/parser.lua:136
"ErrCFunc", -- ./lepton/lpt-parser/parser.lua:136
"expected '}' to close the function body" -- ./lepton/lpt-parser/parser.lua:136
}, -- ./lepton/lpt-parser/parser.lua:136
{ -- ./lepton/lpt-parser/parser.lua:137
"ErrArrowFuncArrow", -- ./lepton/lpt-parser/parser.lua:137
"expected '->' after the arrow function parameter(s)" -- ./lepton/lpt-parser/parser.lua:137
}, -- ./lepton/lpt-parser/parser.lua:137
{ -- ./lepton/lpt-parser/parser.lua:138
"ErrCArrowFunc", -- ./lepton/lpt-parser/parser.lua:138
"expected '}' to close the arrow function" -- ./lepton/lpt-parser/parser.lua:138
}, -- ./lepton/lpt-parser/parser.lua:138
{ -- ./lepton/lpt-parser/parser.lua:139
"ErrParList", -- ./lepton/lpt-parser/parser.lua:139
"expected a variable name or '...' after ','" -- ./lepton/lpt-parser/parser.lua:139
}, -- ./lepton/lpt-parser/parser.lua:139
{ -- ./lepton/lpt-parser/parser.lua:141
"ErrLabel", -- ./lepton/lpt-parser/parser.lua:141
"expected a label name after '::'" -- ./lepton/lpt-parser/parser.lua:141
}, -- ./lepton/lpt-parser/parser.lua:141
{ -- ./lepton/lpt-parser/parser.lua:142
"ErrCloseLabel", -- ./lepton/lpt-parser/parser.lua:142
"expected '::' after the label" -- ./lepton/lpt-parser/parser.lua:142
}, -- ./lepton/lpt-parser/parser.lua:142
{ -- ./lepton/lpt-parser/parser.lua:143
"ErrGoto", -- ./lepton/lpt-parser/parser.lua:143
"expected a label after 'goto'" -- ./lepton/lpt-parser/parser.lua:143
}, -- ./lepton/lpt-parser/parser.lua:143
{ -- ./lepton/lpt-parser/parser.lua:144
"ErrRetList", -- ./lepton/lpt-parser/parser.lua:144
"expected an expression after ',' in the return statement" -- ./lepton/lpt-parser/parser.lua:144
}, -- ./lepton/lpt-parser/parser.lua:144
{ -- ./lepton/lpt-parser/parser.lua:146
"ErrVarList", -- ./lepton/lpt-parser/parser.lua:146
"expected a variable name after ','" -- ./lepton/lpt-parser/parser.lua:146
}, -- ./lepton/lpt-parser/parser.lua:146
{ -- ./lepton/lpt-parser/parser.lua:147
"ErrExprList", -- ./lepton/lpt-parser/parser.lua:147
"expected an expression after ','" -- ./lepton/lpt-parser/parser.lua:147
}, -- ./lepton/lpt-parser/parser.lua:147
{ -- ./lepton/lpt-parser/parser.lua:149
"ErrOParenExpr", -- ./lepton/lpt-parser/parser.lua:149
"expected '(' before the expression" -- ./lepton/lpt-parser/parser.lua:149
}, -- ./lepton/lpt-parser/parser.lua:149
{ -- ./lepton/lpt-parser/parser.lua:150
"ErrCParenExpr", -- ./lepton/lpt-parser/parser.lua:150
"expected ')' after the expression" -- ./lepton/lpt-parser/parser.lua:150
}, -- ./lepton/lpt-parser/parser.lua:150
{ -- ./lepton/lpt-parser/parser.lua:152
"ErrPipeExpr", -- ./lepton/lpt-parser/parser.lua:152
"expected an expression after the pipe operator" -- ./lepton/lpt-parser/parser.lua:152
}, -- ./lepton/lpt-parser/parser.lua:152
{ -- ./lepton/lpt-parser/parser.lua:153
"ErrOrExpr", -- ./lepton/lpt-parser/parser.lua:153
"expected an expression after '||'" -- ./lepton/lpt-parser/parser.lua:153
}, -- ./lepton/lpt-parser/parser.lua:153
{ -- ./lepton/lpt-parser/parser.lua:154
"ErrAndExpr", -- ./lepton/lpt-parser/parser.lua:154
"expected an expression after '&&'" -- ./lepton/lpt-parser/parser.lua:154
}, -- ./lepton/lpt-parser/parser.lua:154
{ -- ./lepton/lpt-parser/parser.lua:155
"ErrRelExpr", -- ./lepton/lpt-parser/parser.lua:155
"expected an expression after the relational operator" -- ./lepton/lpt-parser/parser.lua:155
}, -- ./lepton/lpt-parser/parser.lua:155
{ -- ./lepton/lpt-parser/parser.lua:156
"ErrBOrExpr", -- ./lepton/lpt-parser/parser.lua:156
"expected an expression after '|'" -- ./lepton/lpt-parser/parser.lua:156
}, -- ./lepton/lpt-parser/parser.lua:156
{ -- ./lepton/lpt-parser/parser.lua:157
"ErrBXorExpr", -- ./lepton/lpt-parser/parser.lua:157
"expected an expression after '~'" -- ./lepton/lpt-parser/parser.lua:157
}, -- ./lepton/lpt-parser/parser.lua:157
{ -- ./lepton/lpt-parser/parser.lua:158
"ErrBAndExpr", -- ./lepton/lpt-parser/parser.lua:158
"expected an expression after '&'" -- ./lepton/lpt-parser/parser.lua:158
}, -- ./lepton/lpt-parser/parser.lua:158
{ -- ./lepton/lpt-parser/parser.lua:159
"ErrShiftExpr", -- ./lepton/lpt-parser/parser.lua:159
"expected an expression after the bit shift" -- ./lepton/lpt-parser/parser.lua:159
}, -- ./lepton/lpt-parser/parser.lua:159
{ -- ./lepton/lpt-parser/parser.lua:160
"ErrConcatExpr", -- ./lepton/lpt-parser/parser.lua:160
"expected an expression after '++'" -- ./lepton/lpt-parser/parser.lua:160
}, -- ./lepton/lpt-parser/parser.lua:160
{ -- ./lepton/lpt-parser/parser.lua:161
"ErrTConcatExpr", -- ./lepton/lpt-parser/parser.lua:161
"expected an expression after '+++'" -- ./lepton/lpt-parser/parser.lua:161
}, -- ./lepton/lpt-parser/parser.lua:161
{ -- ./lepton/lpt-parser/parser.lua:162
"ErrAddExpr", -- ./lepton/lpt-parser/parser.lua:162
"expected an expression after the additive operator" -- ./lepton/lpt-parser/parser.lua:162
}, -- ./lepton/lpt-parser/parser.lua:162
{ -- ./lepton/lpt-parser/parser.lua:163
"ErrMulExpr", -- ./lepton/lpt-parser/parser.lua:163
"expected an expression after the multiplicative operator" -- ./lepton/lpt-parser/parser.lua:163
}, -- ./lepton/lpt-parser/parser.lua:163
{ -- ./lepton/lpt-parser/parser.lua:164
"ErrUnaryExpr", -- ./lepton/lpt-parser/parser.lua:164
"expected an expression after the unary operator" -- ./lepton/lpt-parser/parser.lua:164
}, -- ./lepton/lpt-parser/parser.lua:164
{ -- ./lepton/lpt-parser/parser.lua:165
"ErrPowExpr", -- ./lepton/lpt-parser/parser.lua:165
"expected an expression after '^'" -- ./lepton/lpt-parser/parser.lua:165
}, -- ./lepton/lpt-parser/parser.lua:165
{ -- ./lepton/lpt-parser/parser.lua:167
"ErrExprParen", -- ./lepton/lpt-parser/parser.lua:167
"expected an expression after '('" -- ./lepton/lpt-parser/parser.lua:167
}, -- ./lepton/lpt-parser/parser.lua:167
{ -- ./lepton/lpt-parser/parser.lua:168
"ErrCParenExpr", -- ./lepton/lpt-parser/parser.lua:168
"expected ')' to close the expression" -- ./lepton/lpt-parser/parser.lua:168
}, -- ./lepton/lpt-parser/parser.lua:168
{ -- ./lepton/lpt-parser/parser.lua:169
"ErrNameIndex", -- ./lepton/lpt-parser/parser.lua:169
"expected a field name after '.'" -- ./lepton/lpt-parser/parser.lua:169
}, -- ./lepton/lpt-parser/parser.lua:169
{ -- ./lepton/lpt-parser/parser.lua:170
"ErrExprIndex", -- ./lepton/lpt-parser/parser.lua:170
"expected an expression after '['" -- ./lepton/lpt-parser/parser.lua:170
}, -- ./lepton/lpt-parser/parser.lua:170
{ -- ./lepton/lpt-parser/parser.lua:171
"ErrCBracketIndex", -- ./lepton/lpt-parser/parser.lua:171
"expected ']' to close the indexing expression" -- ./lepton/lpt-parser/parser.lua:171
}, -- ./lepton/lpt-parser/parser.lua:171
{ -- ./lepton/lpt-parser/parser.lua:172
"ErrNameMeth", -- ./lepton/lpt-parser/parser.lua:172
"expected a method name after ':'" -- ./lepton/lpt-parser/parser.lua:172
}, -- ./lepton/lpt-parser/parser.lua:172
{ -- ./lepton/lpt-parser/parser.lua:173
"ErrMethArgs", -- ./lepton/lpt-parser/parser.lua:173
"expected some arguments for the method call (or '()')" -- ./lepton/lpt-parser/parser.lua:173
}, -- ./lepton/lpt-parser/parser.lua:173
{ -- ./lepton/lpt-parser/parser.lua:175
"ErrArgList", -- ./lepton/lpt-parser/parser.lua:175
"expected an expression after ',' in the argument list" -- ./lepton/lpt-parser/parser.lua:175
}, -- ./lepton/lpt-parser/parser.lua:175
{ -- ./lepton/lpt-parser/parser.lua:176
"ErrOParenArgs", -- ./lepton/lpt-parser/parser.lua:176
"expected '(' before the argument list" -- ./lepton/lpt-parser/parser.lua:176
}, -- ./lepton/lpt-parser/parser.lua:176
{ -- ./lepton/lpt-parser/parser.lua:177
"ErrCParenArgs", -- ./lepton/lpt-parser/parser.lua:177
"expected ')' to close the argument list" -- ./lepton/lpt-parser/parser.lua:177
}, -- ./lepton/lpt-parser/parser.lua:177
{ -- ./lepton/lpt-parser/parser.lua:179
"ErrCBraceTable", -- ./lepton/lpt-parser/parser.lua:179
"expected '}' to close the table constructor" -- ./lepton/lpt-parser/parser.lua:179
}, -- ./lepton/lpt-parser/parser.lua:179
{ -- ./lepton/lpt-parser/parser.lua:180
"ErrEqField", -- ./lepton/lpt-parser/parser.lua:180
"expected '=' after the table key" -- ./lepton/lpt-parser/parser.lua:180
}, -- ./lepton/lpt-parser/parser.lua:180
{ -- ./lepton/lpt-parser/parser.lua:181
"ErrExprField", -- ./lepton/lpt-parser/parser.lua:181
"expected an expression after '='" -- ./lepton/lpt-parser/parser.lua:181
}, -- ./lepton/lpt-parser/parser.lua:181
{ -- ./lepton/lpt-parser/parser.lua:182
"ErrExprFKey", -- ./lepton/lpt-parser/parser.lua:182
"expected an expression after '[' for the table key" -- ./lepton/lpt-parser/parser.lua:182
}, -- ./lepton/lpt-parser/parser.lua:182
{ -- ./lepton/lpt-parser/parser.lua:183
"ErrCBracketFKey", -- ./lepton/lpt-parser/parser.lua:183
"expected ']' to close the table key" -- ./lepton/lpt-parser/parser.lua:183
}, -- ./lepton/lpt-parser/parser.lua:183
{ -- ./lepton/lpt-parser/parser.lua:185
"ErrCBraceDestructuring", -- ./lepton/lpt-parser/parser.lua:185
"expected '}' to close the destructuring variable list" -- ./lepton/lpt-parser/parser.lua:185
}, -- ./lepton/lpt-parser/parser.lua:185
{ -- ./lepton/lpt-parser/parser.lua:186
"ErrDestructuringEqField", -- ./lepton/lpt-parser/parser.lua:186
"expected '=' after the table key in destructuring variable list" -- ./lepton/lpt-parser/parser.lua:186
}, -- ./lepton/lpt-parser/parser.lua:186
{ -- ./lepton/lpt-parser/parser.lua:187
"ErrDestructuringExprField", -- ./lepton/lpt-parser/parser.lua:187
"expected an identifier after '=' in destructuring variable list" -- ./lepton/lpt-parser/parser.lua:187
}, -- ./lepton/lpt-parser/parser.lua:187
{ -- ./lepton/lpt-parser/parser.lua:189
"ErrCBracketTableCompr", -- ./lepton/lpt-parser/parser.lua:189
"expected ']' to close the table comprehension" -- ./lepton/lpt-parser/parser.lua:189
}, -- ./lepton/lpt-parser/parser.lua:189
{ -- ./lepton/lpt-parser/parser.lua:191
"ErrDigitHex", -- ./lepton/lpt-parser/parser.lua:191
"expected one or more hexadecimal digits after '0x'" -- ./lepton/lpt-parser/parser.lua:191
}, -- ./lepton/lpt-parser/parser.lua:191
{ -- ./lepton/lpt-parser/parser.lua:192
"ErrDigitBin", -- ./lepton/lpt-parser/parser.lua:192
"expected one or more binary digits after '0b'" -- ./lepton/lpt-parser/parser.lua:192
}, -- ./lepton/lpt-parser/parser.lua:192
{ -- ./lepton/lpt-parser/parser.lua:193
"ErrDigitDeci", -- ./lepton/lpt-parser/parser.lua:193
"expected one or more digits after the decimal point" -- ./lepton/lpt-parser/parser.lua:193
}, -- ./lepton/lpt-parser/parser.lua:193
{ -- ./lepton/lpt-parser/parser.lua:194
"ErrDigitExpo", -- ./lepton/lpt-parser/parser.lua:194
"expected one or more digits for the exponent" -- ./lepton/lpt-parser/parser.lua:194
}, -- ./lepton/lpt-parser/parser.lua:194
{ -- ./lepton/lpt-parser/parser.lua:196
"ErrQuote", -- ./lepton/lpt-parser/parser.lua:196
"unclosed string" -- ./lepton/lpt-parser/parser.lua:196
}, -- ./lepton/lpt-parser/parser.lua:196
{ -- ./lepton/lpt-parser/parser.lua:197
"ErrHexEsc", -- ./lepton/lpt-parser/parser.lua:197
"expected exactly two hexadecimal digits after '\\x'" -- ./lepton/lpt-parser/parser.lua:197
}, -- ./lepton/lpt-parser/parser.lua:197
{ -- ./lepton/lpt-parser/parser.lua:198
"ErrOBraceUEsc", -- ./lepton/lpt-parser/parser.lua:198
"expected '{' after '\\u'" -- ./lepton/lpt-parser/parser.lua:198
}, -- ./lepton/lpt-parser/parser.lua:198
{ -- ./lepton/lpt-parser/parser.lua:199
"ErrDigitUEsc", -- ./lepton/lpt-parser/parser.lua:199
"expected one or more hexadecimal digits for the UTF-8 code point" -- ./lepton/lpt-parser/parser.lua:199
}, -- ./lepton/lpt-parser/parser.lua:199
{ -- ./lepton/lpt-parser/parser.lua:200
"ErrCBraceUEsc", -- ./lepton/lpt-parser/parser.lua:200
"expected '}' after the code point" -- ./lepton/lpt-parser/parser.lua:200
}, -- ./lepton/lpt-parser/parser.lua:200
{ -- ./lepton/lpt-parser/parser.lua:201
"ErrEscSeq", -- ./lepton/lpt-parser/parser.lua:201
"invalid escape sequence" -- ./lepton/lpt-parser/parser.lua:201
}, -- ./lepton/lpt-parser/parser.lua:201
{ -- ./lepton/lpt-parser/parser.lua:202
"ErrCloseLStr", -- ./lepton/lpt-parser/parser.lua:202
"unclosed long string" -- ./lepton/lpt-parser/parser.lua:202
}, -- ./lepton/lpt-parser/parser.lua:202
{ -- ./lepton/lpt-parser/parser.lua:204
"ErrUnknownAttribute", -- ./lepton/lpt-parser/parser.lua:204
"unknown variable attribute" -- ./lepton/lpt-parser/parser.lua:204
}, -- ./lepton/lpt-parser/parser.lua:204
{ -- ./lepton/lpt-parser/parser.lua:205
"ErrCBracketAttribute", -- ./lepton/lpt-parser/parser.lua:205
"expected '>' to close the variable attribute" -- ./lepton/lpt-parser/parser.lua:205
} -- ./lepton/lpt-parser/parser.lua:205
} -- ./lepton/lpt-parser/parser.lua:205
local function throw(label) -- ./lepton/lpt-parser/parser.lua:208
label = "Err" .. label -- ./lepton/lpt-parser/parser.lua:209
for i, labelinfo in ipairs(labels) do -- ./lepton/lpt-parser/parser.lua:211
if labelinfo[1] == label then -- ./lepton/lpt-parser/parser.lua:212
return T(i) -- ./lepton/lpt-parser/parser.lua:213
end -- ./lepton/lpt-parser/parser.lua:213
end -- ./lepton/lpt-parser/parser.lua:213
error("Label not found: " .. label) -- ./lepton/lpt-parser/parser.lua:217
end -- ./lepton/lpt-parser/parser.lua:217
local function e(patt, label) -- ./lepton/lpt-parser/parser.lua:220
return patt + throw(label) -- ./lepton/lpt-parser/parser.lua:221
end -- ./lepton/lpt-parser/parser.lua:221
local function dump(t) -- ./lepton/lpt-parser/parser.lua:227
require("lepton.lpt-parser.pp")["dump"](t) -- ./lepton/lpt-parser/parser.lua:228
return t -- ./lepton/lpt-parser/parser.lua:229
end -- ./lepton/lpt-parser/parser.lua:229
local function isAny(item, comparisons) -- ./lepton/lpt-parser/parser.lua:232
for _, v in ipairs(comparisons) do -- ./lepton/lpt-parser/parser.lua:233
if item == v then -- ./lepton/lpt-parser/parser.lua:234
return true -- ./lepton/lpt-parser/parser.lua:234
end -- ./lepton/lpt-parser/parser.lua:234
end -- ./lepton/lpt-parser/parser.lua:234
return false -- ./lepton/lpt-parser/parser.lua:236
end -- ./lepton/lpt-parser/parser.lua:236
local function token(patt) -- ./lepton/lpt-parser/parser.lua:239
return patt * V("Skip") -- ./lepton/lpt-parser/parser.lua:240
end -- ./lepton/lpt-parser/parser.lua:240
local function sym(str) -- ./lepton/lpt-parser/parser.lua:243
return token(P(str)) -- ./lepton/lpt-parser/parser.lua:244
end -- ./lepton/lpt-parser/parser.lua:244
local function kw(str) -- ./lepton/lpt-parser/parser.lua:247
return token(P(str) * - V("IdRest")) -- ./lepton/lpt-parser/parser.lua:248
end -- ./lepton/lpt-parser/parser.lua:248
local function parenAround(expr) -- ./lepton/lpt-parser/parser.lua:251
return sym("(") * expr * sym(")") -- ./lepton/lpt-parser/parser.lua:252
end -- ./lepton/lpt-parser/parser.lua:252
local function tag(tag, patt) -- ./lepton/lpt-parser/parser.lua:255
return Ct(Cg(Cp(), "pos") * Cg(Cc(tag), "tag") * patt) -- ./lepton/lpt-parser/parser.lua:256
end -- ./lepton/lpt-parser/parser.lua:256
local function unaryOp(op, e) -- ./lepton/lpt-parser/parser.lua:259
return { -- ./lepton/lpt-parser/parser.lua:260
["tag"] = "Op", -- ./lepton/lpt-parser/parser.lua:260
["pos"] = e["pos"], -- ./lepton/lpt-parser/parser.lua:260
[1] = op, -- ./lepton/lpt-parser/parser.lua:260
[2] = e -- ./lepton/lpt-parser/parser.lua:260
} -- ./lepton/lpt-parser/parser.lua:260
end -- ./lepton/lpt-parser/parser.lua:260
local function binaryOp(e1, op, e2) -- ./lepton/lpt-parser/parser.lua:263
if not op then -- ./lepton/lpt-parser/parser.lua:264
return e1 -- ./lepton/lpt-parser/parser.lua:265
else -- ./lepton/lpt-parser/parser.lua:265
return { -- ./lepton/lpt-parser/parser.lua:267
["tag"] = "Op", -- ./lepton/lpt-parser/parser.lua:267
["pos"] = e1["pos"], -- ./lepton/lpt-parser/parser.lua:267
[1] = op, -- ./lepton/lpt-parser/parser.lua:267
[2] = e1, -- ./lepton/lpt-parser/parser.lua:267
[3] = e2 -- ./lepton/lpt-parser/parser.lua:267
} -- ./lepton/lpt-parser/parser.lua:267
end -- ./lepton/lpt-parser/parser.lua:267
end -- ./lepton/lpt-parser/parser.lua:267
local function sepBy(patt, sep, label) -- ./lepton/lpt-parser/parser.lua:271
if label then -- ./lepton/lpt-parser/parser.lua:272
return patt * Cg(sep * e(patt, label)) ^ 0 -- ./lepton/lpt-parser/parser.lua:273
else -- ./lepton/lpt-parser/parser.lua:273
return patt * Cg(sep * patt) ^ 0 -- ./lepton/lpt-parser/parser.lua:275
end -- ./lepton/lpt-parser/parser.lua:275
end -- ./lepton/lpt-parser/parser.lua:275
local function chainOp(patt, sep, label) -- ./lepton/lpt-parser/parser.lua:279
return Cf(sepBy(patt, sep, label), binaryOp) -- ./lepton/lpt-parser/parser.lua:280
end -- ./lepton/lpt-parser/parser.lua:280
local function commaSep(patt, label) -- ./lepton/lpt-parser/parser.lua:283
return sepBy(patt, sym(","), label) -- ./lepton/lpt-parser/parser.lua:284
end -- ./lepton/lpt-parser/parser.lua:284
local function tagDo(block) -- ./lepton/lpt-parser/parser.lua:287
block["tag"] = "Do" -- ./lepton/lpt-parser/parser.lua:288
return block -- ./lepton/lpt-parser/parser.lua:289
end -- ./lepton/lpt-parser/parser.lua:289
local function fixFuncStat(func) -- ./lepton/lpt-parser/parser.lua:292
if func[1]["is_method"] then -- ./lepton/lpt-parser/parser.lua:293
table["insert"](func[2][1], 1, { -- ./lepton/lpt-parser/parser.lua:293
["tag"] = "Id", -- ./lepton/lpt-parser/parser.lua:293
[1] = "self" -- ./lepton/lpt-parser/parser.lua:293
}) -- ./lepton/lpt-parser/parser.lua:293
end -- ./lepton/lpt-parser/parser.lua:293
func[1] = { func[1] } -- ./lepton/lpt-parser/parser.lua:294
func[2] = { func[2] } -- ./lepton/lpt-parser/parser.lua:295
return func -- ./lepton/lpt-parser/parser.lua:296
end -- ./lepton/lpt-parser/parser.lua:296
local function addDots(params, dots) -- ./lepton/lpt-parser/parser.lua:299
if dots then -- ./lepton/lpt-parser/parser.lua:300
table["insert"](params, dots) -- ./lepton/lpt-parser/parser.lua:300
end -- ./lepton/lpt-parser/parser.lua:300
return params -- ./lepton/lpt-parser/parser.lua:301
end -- ./lepton/lpt-parser/parser.lua:301
local function insertIndex(t, index) -- ./lepton/lpt-parser/parser.lua:304
return { -- ./lepton/lpt-parser/parser.lua:305
["tag"] = "Index", -- ./lepton/lpt-parser/parser.lua:305
["pos"] = t["pos"], -- ./lepton/lpt-parser/parser.lua:305
[1] = t, -- ./lepton/lpt-parser/parser.lua:305
[2] = index -- ./lepton/lpt-parser/parser.lua:305
} -- ./lepton/lpt-parser/parser.lua:305
end -- ./lepton/lpt-parser/parser.lua:305
local function markMethod(t, method) -- ./lepton/lpt-parser/parser.lua:308
if method then -- ./lepton/lpt-parser/parser.lua:309
return { -- ./lepton/lpt-parser/parser.lua:310
["tag"] = "Index", -- ./lepton/lpt-parser/parser.lua:310
["pos"] = t["pos"], -- ./lepton/lpt-parser/parser.lua:310
["is_method"] = true, -- ./lepton/lpt-parser/parser.lua:310
[1] = t, -- ./lepton/lpt-parser/parser.lua:310
[2] = method -- ./lepton/lpt-parser/parser.lua:310
} -- ./lepton/lpt-parser/parser.lua:310
end -- ./lepton/lpt-parser/parser.lua:310
return t -- ./lepton/lpt-parser/parser.lua:312
end -- ./lepton/lpt-parser/parser.lua:312
local function fixLuaKeywords(t) -- ./lepton/lpt-parser/parser.lua:316
local keywords = { -- ./lepton/lpt-parser/parser.lua:317
["and"] = true, -- ./lepton/lpt-parser/parser.lua:318
["do"] = true, -- ./lepton/lpt-parser/parser.lua:319
["elseif"] = true, -- ./lepton/lpt-parser/parser.lua:320
["end"] = true, -- ./lepton/lpt-parser/parser.lua:321
["function"] = true, -- ./lepton/lpt-parser/parser.lua:322
["in"] = true, -- ./lepton/lpt-parser/parser.lua:323
["not"] = true, -- ./lepton/lpt-parser/parser.lua:324
["or"] = true, -- ./lepton/lpt-parser/parser.lua:325
["then"] = true -- ./lepton/lpt-parser/parser.lua:326
} -- ./lepton/lpt-parser/parser.lua:326
if t["tag"] == "Pair" then -- ./lepton/lpt-parser/parser.lua:328
if keywords[t[1][1]] then -- ./lepton/lpt-parser/parser.lua:329
t[1][1] = "_" .. t[1][1] -- ./lepton/lpt-parser/parser.lua:330
end -- ./lepton/lpt-parser/parser.lua:330
else -- ./lepton/lpt-parser/parser.lua:330
if keywords[t[1]] then -- ./lepton/lpt-parser/parser.lua:333
t[1] = "_" .. t[1] -- ./lepton/lpt-parser/parser.lua:334
end -- ./lepton/lpt-parser/parser.lua:334
end -- ./lepton/lpt-parser/parser.lua:334
return t -- ./lepton/lpt-parser/parser.lua:337
end -- ./lepton/lpt-parser/parser.lua:337
local calls = { -- ./lepton/lpt-parser/parser.lua:340
["Call"] = true, -- ./lepton/lpt-parser/parser.lua:341
["SafeCall"] = true, -- ./lepton/lpt-parser/parser.lua:342
["Broadcast"] = true, -- ./lepton/lpt-parser/parser.lua:343
["BroadcastKV"] = true, -- ./lepton/lpt-parser/parser.lua:344
["Filter"] = true, -- ./lepton/lpt-parser/parser.lua:345
["FilterKV"] = true -- ./lepton/lpt-parser/parser.lua:346
} -- ./lepton/lpt-parser/parser.lua:346
local function makeSuffixedExpr(t1, t2) -- ./lepton/lpt-parser/parser.lua:349
if calls[t2["tag"]] then -- ./lepton/lpt-parser/parser.lua:350
local t = { -- ./lepton/lpt-parser/parser.lua:351
["tag"] = t2["tag"], -- ./lepton/lpt-parser/parser.lua:351
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:351
[1] = t1 -- ./lepton/lpt-parser/parser.lua:351
} -- ./lepton/lpt-parser/parser.lua:351
for _, v in ipairs(t2) do -- ./lepton/lpt-parser/parser.lua:352
t[# t + 1] = v -- ./lepton/lpt-parser/parser.lua:353
end -- ./lepton/lpt-parser/parser.lua:353
return t -- ./lepton/lpt-parser/parser.lua:355
elseif t2["tag"] == "MethodStub" or t2["tag"] == "SafeMethodStub" then -- ./lepton/lpt-parser/parser.lua:356
return { -- ./lepton/lpt-parser/parser.lua:357
["tag"] = t2["tag"], -- ./lepton/lpt-parser/parser.lua:357
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:357
[1] = t1, -- ./lepton/lpt-parser/parser.lua:357
[2] = fixLuaKeywords(t2[1]) -- ./lepton/lpt-parser/parser.lua:357
} -- ./lepton/lpt-parser/parser.lua:357
elseif t2["tag"] == "SafeDotIndex" or t2["tag"] == "SafeArrayIndex" then -- ./lepton/lpt-parser/parser.lua:358
return { -- ./lepton/lpt-parser/parser.lua:359
["tag"] = "SafeIndex", -- ./lepton/lpt-parser/parser.lua:359
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:359
[1] = t1, -- ./lepton/lpt-parser/parser.lua:359
[2] = fixLuaKeywords(t2[1]) -- ./lepton/lpt-parser/parser.lua:359
} -- ./lepton/lpt-parser/parser.lua:359
elseif t2["tag"] == "DotIndex" or t2["tag"] == "ArrayIndex" then -- ./lepton/lpt-parser/parser.lua:360
return { -- ./lepton/lpt-parser/parser.lua:361
["tag"] = "Index", -- ./lepton/lpt-parser/parser.lua:361
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:361
[1] = t1, -- ./lepton/lpt-parser/parser.lua:361
[2] = fixLuaKeywords(t2[1]) -- ./lepton/lpt-parser/parser.lua:361
} -- ./lepton/lpt-parser/parser.lua:361
else -- ./lepton/lpt-parser/parser.lua:361
error("unexpected tag in suffixed expression") -- ./lepton/lpt-parser/parser.lua:363
end -- ./lepton/lpt-parser/parser.lua:363
end -- ./lepton/lpt-parser/parser.lua:363
local function fixArrowFunc(t) -- ./lepton/lpt-parser/parser.lua:367
if t[1] == ":" then -- ./lepton/lpt-parser/parser.lua:368
table["insert"](t[2], 1, { -- ./lepton/lpt-parser/parser.lua:369
["tag"] = "Id", -- ./lepton/lpt-parser/parser.lua:369
"self" -- ./lepton/lpt-parser/parser.lua:369
}) -- ./lepton/lpt-parser/parser.lua:369
table["remove"](t, 1) -- ./lepton/lpt-parser/parser.lua:370
t["is_method"] = true -- ./lepton/lpt-parser/parser.lua:371
end -- ./lepton/lpt-parser/parser.lua:371
t["is_short"] = true -- ./lepton/lpt-parser/parser.lua:373
return t -- ./lepton/lpt-parser/parser.lua:374
end -- ./lepton/lpt-parser/parser.lua:374
local function markImplicit(t) -- ./lepton/lpt-parser/parser.lua:377
t["implicit"] = true -- ./lepton/lpt-parser/parser.lua:378
return t -- ./lepton/lpt-parser/parser.lua:379
end -- ./lepton/lpt-parser/parser.lua:379
local function statToExpr(t) -- ./lepton/lpt-parser/parser.lua:382
t["tag"] = t["tag"] .. "Expr" -- ./lepton/lpt-parser/parser.lua:383
return t -- ./lepton/lpt-parser/parser.lua:384
end -- ./lepton/lpt-parser/parser.lua:384
local function fixStructure(t) -- ./lepton/lpt-parser/parser.lua:387
local i = 1 -- ./lepton/lpt-parser/parser.lua:388
while i <= # t do -- ./lepton/lpt-parser/parser.lua:389
if type(t[i]) == "table" then -- ./lepton/lpt-parser/parser.lua:390
fixStructure(t[i]) -- ./lepton/lpt-parser/parser.lua:391
for j = # t[i], 1, - 1 do -- ./lepton/lpt-parser/parser.lua:392
local stat = t[i][j] -- ./lepton/lpt-parser/parser.lua:393
if type(stat) == "table" and stat["move_up_block"] and stat["move_up_block"] > 0 then -- ./lepton/lpt-parser/parser.lua:394
table["remove"](t[i], j) -- ./lepton/lpt-parser/parser.lua:395
table["insert"](t, i + 1, stat) -- ./lepton/lpt-parser/parser.lua:396
if t["tag"] == "Block" or t["tag"] == "Do" then -- ./lepton/lpt-parser/parser.lua:397
stat["move_up_block"] = stat["move_up_block"] - 1 -- ./lepton/lpt-parser/parser.lua:398
end -- ./lepton/lpt-parser/parser.lua:398
end -- ./lepton/lpt-parser/parser.lua:398
end -- ./lepton/lpt-parser/parser.lua:398
end -- ./lepton/lpt-parser/parser.lua:398
i = i + 1 -- ./lepton/lpt-parser/parser.lua:403
end -- ./lepton/lpt-parser/parser.lua:403
return t -- ./lepton/lpt-parser/parser.lua:405
end -- ./lepton/lpt-parser/parser.lua:405
local function eStart(label) -- ./lepton/lpt-parser/parser.lua:408
return e(sym("{"), label) -- ./lepton/lpt-parser/parser.lua:409
end -- ./lepton/lpt-parser/parser.lua:409
local function eEnd(label) -- ./lepton/lpt-parser/parser.lua:412
return e(sym("}"), label) -- ./lepton/lpt-parser/parser.lua:413
end -- ./lepton/lpt-parser/parser.lua:413
local function eBlkStartEndOrSingleStat(startLabel, endLabel, canFollow) -- ./lepton/lpt-parser/parser.lua:416
local start = sym("{") -- ./lepton/lpt-parser/parser.lua:417
if canFollow then -- ./lepton/lpt-parser/parser.lua:418
return (- start * V("SingleStatBlock") * canFollow ^ - 1) + (eStart(startLabel) * V("Block") * (eEnd(endLabel) * canFollow + eEnd(endLabel))) -- ./lepton/lpt-parser/parser.lua:420
else -- ./lepton/lpt-parser/parser.lua:420
return (- start * V("SingleStatBlock")) + (eStart(startLabel) * V("Block") * eEnd(endLabel)) -- ./lepton/lpt-parser/parser.lua:423
end -- ./lepton/lpt-parser/parser.lua:423
end -- ./lepton/lpt-parser/parser.lua:423
local function mb(patt) -- ./lepton/lpt-parser/parser.lua:427
return # patt / 0 * patt -- ./lepton/lpt-parser/parser.lua:428
end -- ./lepton/lpt-parser/parser.lua:428
local function setAttribute(attribute) -- ./lepton/lpt-parser/parser.lua:431
return function(assign) -- ./lepton/lpt-parser/parser.lua:432
assign[1]["tag"] = "AttributeNameList" -- ./lepton/lpt-parser/parser.lua:433
for _, id in ipairs(assign[1]) do -- ./lepton/lpt-parser/parser.lua:434
if id["tag"] == "Id" then -- ./lepton/lpt-parser/parser.lua:435
id["tag"] = "AttributeId" -- ./lepton/lpt-parser/parser.lua:436
id[2] = attribute -- ./lepton/lpt-parser/parser.lua:437
elseif id["tag"] == "DestructuringId" then -- ./lepton/lpt-parser/parser.lua:438
for _, did in ipairs(id) do -- ./lepton/lpt-parser/parser.lua:439
did["tag"] = "AttributeId" -- ./lepton/lpt-parser/parser.lua:440
did[2] = attribute -- ./lepton/lpt-parser/parser.lua:441
end -- ./lepton/lpt-parser/parser.lua:441
end -- ./lepton/lpt-parser/parser.lua:441
end -- ./lepton/lpt-parser/parser.lua:441
return assign -- ./lepton/lpt-parser/parser.lua:445
end -- ./lepton/lpt-parser/parser.lua:445
end -- ./lepton/lpt-parser/parser.lua:445
local stacks = { ["lexpr"] = {} } -- ./lepton/lpt-parser/parser.lua:450
local function push(f) -- ./lepton/lpt-parser/parser.lua:452
return Cmt(P(""), function() -- ./lepton/lpt-parser/parser.lua:453
table["insert"](stacks[f], true) -- ./lepton/lpt-parser/parser.lua:454
return true -- ./lepton/lpt-parser/parser.lua:455
end) -- ./lepton/lpt-parser/parser.lua:455
end -- ./lepton/lpt-parser/parser.lua:455
local function pop(f) -- ./lepton/lpt-parser/parser.lua:458
return Cmt(P(""), function() -- ./lepton/lpt-parser/parser.lua:459
table["remove"](stacks[f]) -- ./lepton/lpt-parser/parser.lua:460
return true -- ./lepton/lpt-parser/parser.lua:461
end) -- ./lepton/lpt-parser/parser.lua:461
end -- ./lepton/lpt-parser/parser.lua:461
local function when(f) -- ./lepton/lpt-parser/parser.lua:464
return Cmt(P(""), function() -- ./lepton/lpt-parser/parser.lua:465
return # stacks[f] > 0 -- ./lepton/lpt-parser/parser.lua:466
end) -- ./lepton/lpt-parser/parser.lua:466
end -- ./lepton/lpt-parser/parser.lua:466
local function set(f, patt) -- ./lepton/lpt-parser/parser.lua:469
return push(f) * patt * pop(f) -- ./lepton/lpt-parser/parser.lua:470
end -- ./lepton/lpt-parser/parser.lua:470
local G = { -- ./lepton/lpt-parser/parser.lua:475
V("Lua"), -- ./lepton/lpt-parser/parser.lua:475
["Lua"] = (V("Shebang") ^ - 1 * V("Skip") * V("Block") * e(P(- 1), "Extra")) / fixStructure, -- ./lepton/lpt-parser/parser.lua:476
["Shebang"] = P("#!") * (P(1) - P("\
")) ^ 0, -- ./lepton/lpt-parser/parser.lua:477
["Block"] = tag("Block", (V("Stat") + - V("BlockEnd") * throw("InvalidStat")) ^ 0 * ((V("RetStat") + V("ImplicitPushStat")) * sym(";") ^ - 1) ^ - 1), -- ./lepton/lpt-parser/parser.lua:479
["Stat"] = V("IfStat") + V("DoStat") + V("WhileStat") + V("RepeatStat") + V("ForStat") + V("LocalStat") + V("FuncStat") + V("BreakStat") + V("LabelStat") + V("GoToStat") + V("LetStat") + V("ConstStat") + V("CloseStat") + V("FuncCall") + V("Assignment") + V("AppendAssignment") + V("ContinueStat") + V("PushStat") + sym(";"), -- ./lepton/lpt-parser/parser.lua:485
["BlockEnd"] = P("return") + sym("}") + "]" + - 1 + V("ImplicitPushStat") + V("Assignment"), -- ./lepton/lpt-parser/parser.lua:486
["SingleStatBlock"] = tag("Block", V("Stat") + V("RetStat") + V("ImplicitPushStat")), -- ./lepton/lpt-parser/parser.lua:488
["BlockNoErr"] = tag("Block", V("Stat") ^ 0 * ((V("RetStat") + V("ImplicitPushStat")) * sym(";") ^ - 1) ^ - 1), -- ./lepton/lpt-parser/parser.lua:489
["IfStat"] = tag("If", V("IfPart")), -- ./lepton/lpt-parser/parser.lua:491
["IfPart"] = kw("if") * set("lexpr", e(parenAround(V("Expr")), "ExprIf")) * eBlkStartEndOrSingleStat("OIf", "CIf", V("ElseIfPart") + V("ElsePart")), -- ./lepton/lpt-parser/parser.lua:492
["ElseIfPart"] = kw("else") * V("IfPart"), -- ./lepton/lpt-parser/parser.lua:493
["ElsePart"] = kw("else") * eBlkStartEndOrSingleStat("OElse", "CIf"), -- ./lepton/lpt-parser/parser.lua:494
["DoStat"] = kw("do") * eBlkStartEndOrSingleStat("ODo", "CDo") / tagDo, -- ./lepton/lpt-parser/parser.lua:496
["WhileStat"] = tag("While", kw("while") * set("lexpr", e(parenAround(V("Expr")), "ExprWhile")) * V("WhileBody")), -- ./lepton/lpt-parser/parser.lua:497
["WhileBody"] = eBlkStartEndOrSingleStat("DoWhile", "EndWhile"), -- ./lepton/lpt-parser/parser.lua:498
["RepeatStat"] = tag("Repeat", kw("repeat") * eBlkStartEndOrSingleStat("ORep", "CRep") * e(kw("until"), "UntilRep") * e(parenAround(V("Expr")), "ExprRep")), -- ./lepton/lpt-parser/parser.lua:499
["ForStat"] = kw("for") * e(V("ForNum") + V("ForIn"), "ForRange"), -- ./lepton/lpt-parser/parser.lua:501
["ForNum"] = tag("Fornum", parenAround(V("Id") * sym(":") * V("NumRange")) * V("ForBody")), -- ./lepton/lpt-parser/parser.lua:502
["NumRange"] = e(V("Expr"), "ForRangeStart") * e(sym(","), "ForRangeComma") * e(V("Expr"), "ForRangeEnd") * (sym(":") * e(V("Expr"), "ForRangeStep")) ^ - 1, -- ./lepton/lpt-parser/parser.lua:504
["ForIn"] = tag("Forin", parenAround(V("DestructuringNameList") * e(sym(":"), "InFor") * e(V("ExprList"), "EListFor")) * V("ForBody")), -- ./lepton/lpt-parser/parser.lua:505
["ForBody"] = eBlkStartEndOrSingleStat("OFor", "CFor"), -- ./lepton/lpt-parser/parser.lua:506
["LocalStat"] = kw("local") * e(V("LocalFunc") + V("LocalAssign"), "DefLocal"), -- ./lepton/lpt-parser/parser.lua:508
["LocalFunc"] = tag("Localrec", kw("fn") * e(V("Id"), "NameLFunc") * V("FuncBody")) / fixFuncStat, -- ./lepton/lpt-parser/parser.lua:509
["LocalAssign"] = tag("Local", V("AttributeNameList") * (sym("=") * e(V("ExprList"), "EListLAssign") + Ct(Cc()))) + tag("Local", V("DestructuringNameList") * sym("=") * e(V("ExprList"), "EListLAssign")), -- ./lepton/lpt-parser/parser.lua:511
["LetStat"] = kw("let") * e(V("LetAssign"), "DefLet"), -- ./lepton/lpt-parser/parser.lua:513
["LetAssign"] = tag("Let", V("NameList") * (sym("=") * e(V("ExprList"), "EListLAssign") + Ct(Cc()))) + tag("Let", V("DestructuringNameList") * sym("=") * e(V("ExprList"), "EListLAssign")), -- ./lepton/lpt-parser/parser.lua:515
["ConstStat"] = kw("const") * e(V("AttributeAssign") / setAttribute("const"), "DefConst"), -- ./lepton/lpt-parser/parser.lua:517
["CloseStat"] = kw("close") * e(V("AttributeAssign") / setAttribute("close"), "DefClose"), -- ./lepton/lpt-parser/parser.lua:518
["AttributeAssign"] = tag("Local", V("NameList") * (sym("=") * e(V("ExprList"), "EListLAssign") + Ct(Cc()))) + tag("Local", V("DestructuringNameList") * sym("=") * e(V("ExprList"), "EListLAssign")), -- ./lepton/lpt-parser/parser.lua:520
["Assignment"] = tag("Set", (V("VarList") + V("DestructuringNameList")) * V("BinOp") ^ - 1 * ((P("=") - "==") / "=") * ((V("BinOp") - P("-")) + # (P("-") * V("Space")) * V("BinOp")) ^ - 1 * V("Skip") * e(V("ExprList"), "EListAssign")), -- ./lepton/lpt-parser/parser.lua:523
["AppendAssignment"] = tag("AppendSet", V("VarList") * sym("#=") * e(V("ExprList"), "EListAssign")), -- ./lepton/lpt-parser/parser.lua:525
["FuncStat"] = tag("Set", kw("fn") * e(V("FuncName"), "FuncName") * V("FuncBody")) / fixFuncStat, -- ./lepton/lpt-parser/parser.lua:527
["FuncName"] = Cf(V("Id") * (sym(".") * e(V("StrId"), "NameFunc1")) ^ 0, insertIndex) * (sym(":") * e(V("StrId"), "NameFunc2")) ^ - 1 / markMethod, -- ./lepton/lpt-parser/parser.lua:529
["FuncBody"] = tag("Function", V("FuncParams") * eBlkStartEndOrSingleStat("OFunc", "CFunc")), -- ./lepton/lpt-parser/parser.lua:530
["FuncParams"] = e(sym("("), "OParenPList") * V("ParList") * e(sym(")"), "CParenPList"), -- ./lepton/lpt-parser/parser.lua:531
["ParList"] = V("NamedParList") * (sym(",") * e(tag("Dots", sym("...")), "ParList")) ^ - 1 / addDots + Ct(tag("Dots", sym("..."))) + Ct(Cc()), -- ./lepton/lpt-parser/parser.lua:534
["ArrowFuncDef"] = tag("Function", V("ArrowFuncParams") * sym("->") * V("ArrowFuncBody")) / fixArrowFunc, -- ./lepton/lpt-parser/parser.lua:536
["ArrowFuncParams"] = (sym(":") / ":") ^ - 1 * (parenAround(V("ParList")) + tag("NamedPar", V("NamedPar"))), -- ./lepton/lpt-parser/parser.lua:537
["ArrowFuncBody"] = (- sym("{") * tag("Block", tag("Push", V("OrExpr"))) * - sym("}")) + sym("{") * V("Block") * eEnd("CArrowFunc"), -- ./lepton/lpt-parser/parser.lua:538
["NamedParList"] = tag("NamedParList", commaSep(V("NamedPar"))), -- ./lepton/lpt-parser/parser.lua:540
["NamedPar"] = tag("ParPair", V("ParKey") * e(sym("="), "EqField") * e(V("Expr"), "ExprField")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:541
["ParKey"] = V("Id") * # ("=" * - P("=")), -- ./lepton/lpt-parser/parser.lua:542
["LabelStat"] = tag("Label", sym("::") * e(V("Name"), "Label") * e(sym("::"), "CloseLabel")), -- ./lepton/lpt-parser/parser.lua:544
["GoToStat"] = tag("Goto", kw("goto") * e(V("Name"), "Goto")), -- ./lepton/lpt-parser/parser.lua:545
["BreakStat"] = tag("Break", kw("break")), -- ./lepton/lpt-parser/parser.lua:546
["ContinueStat"] = tag("Continue", kw("continue")), -- ./lepton/lpt-parser/parser.lua:547
["RetStat"] = tag("Return", kw("return") * commaSep(V("Expr"), "RetList") ^ - 1), -- ./lepton/lpt-parser/parser.lua:548
["PushStat"] = tag("Push", kw("push") * commaSep(V("Expr"), "RetList") ^ - 1), -- ./lepton/lpt-parser/parser.lua:550
["ImplicitPushStat"] = tag("Push", commaSep(V("Expr"), "RetList")) / markImplicit, -- ./lepton/lpt-parser/parser.lua:551
["NameList"] = tag("NameList", commaSep(V("Id"))), -- ./lepton/lpt-parser/parser.lua:553
["DestructuringNameList"] = tag("NameList", commaSep(V("DestructuringId"))), -- ./lepton/lpt-parser/parser.lua:554
["AttributeNameList"] = tag("AttributeNameList", commaSep(V("AttributeId"))), -- ./lepton/lpt-parser/parser.lua:555
["VarList"] = tag("VarList", commaSep(V("VarExpr"))), -- ./lepton/lpt-parser/parser.lua:556
["ExprList"] = tag("ExpList", commaSep(V("Expr"), "ExprList")), -- ./lepton/lpt-parser/parser.lua:557
["DestructuringId"] = tag("DestructuringId", sym("{") * V("DestructuringIdFieldList") * eEnd("CBraceDestructuring")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:559
["DestructuringIdFieldList"] = sepBy(V("DestructuringIdField"), V("FieldSep")) * V("FieldSep") ^ - 1, -- ./lepton/lpt-parser/parser.lua:560
["DestructuringIdField"] = tag("Pair", V("FieldKey") * e(sym("="), "DestructuringEqField") * e(V("Id"), "DestructuringExprField")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:561
["Expr"] = V("PipeExpr"), -- ./lepton/lpt-parser/parser.lua:563
["PipeExpr"] = chainOp(V("OrExpr"), V("PipeOp"), "PipeExpr"), -- ./lepton/lpt-parser/parser.lua:564
["OrExpr"] = chainOp(V("AndExpr"), V("OrOp"), "OrExpr"), -- ./lepton/lpt-parser/parser.lua:565
["AndExpr"] = chainOp(V("RelExpr"), V("AndOp"), "AndExpr"), -- ./lepton/lpt-parser/parser.lua:566
["RelExpr"] = chainOp(V("BOrExpr"), V("RelOp"), "RelExpr"), -- ./lepton/lpt-parser/parser.lua:567
["BOrExpr"] = chainOp(V("BXorExpr"), V("BOrOp"), "BOrExpr"), -- ./lepton/lpt-parser/parser.lua:568
["BXorExpr"] = chainOp(V("BAndExpr"), V("BXorOp"), "BXorExpr"), -- ./lepton/lpt-parser/parser.lua:569
["BAndExpr"] = chainOp(V("ShiftExpr"), V("BAndOp"), "BAndExpr"), -- ./lepton/lpt-parser/parser.lua:570
["ShiftExpr"] = chainOp(V("ConcatExpr"), V("ShiftOp"), "ShiftExpr"), -- ./lepton/lpt-parser/parser.lua:571
["ConcatExpr"] = V("TConcatExpr") * (V("ConcatOp") * e(V("ConcatExpr"), "ConcatExpr")) ^ - 1 / binaryOp, -- ./lepton/lpt-parser/parser.lua:572
["TConcatExpr"] = V("AddExpr") * (V("TConcatOp") * e(V("TConcatExpr"), "TConcatExpr")) ^ - 1 / binaryOp, -- ./lepton/lpt-parser/parser.lua:573
["AddExpr"] = chainOp(V("MulExpr"), V("AddOp"), "AddExpr"), -- ./lepton/lpt-parser/parser.lua:574
["MulExpr"] = chainOp(V("UnaryExpr"), V("MulOp"), "MulExpr"), -- ./lepton/lpt-parser/parser.lua:575
["UnaryExpr"] = V("UnaryOp") * e(V("UnaryExpr"), "UnaryExpr") / unaryOp + V("PowExpr"), -- ./lepton/lpt-parser/parser.lua:577
["PowExpr"] = V("SimpleExpr") * (V("PowOp") * e(V("UnaryExpr"), "PowExpr")) ^ - 1 / binaryOp, -- ./lepton/lpt-parser/parser.lua:578
["SimpleExpr"] = tag("Number", V("Number")) + tag("Nil", kw("nil")) + tag("Boolean", kw("false") * Cc(false)) + tag("Boolean", kw("true") * Cc(true)) + tag("Dots", sym("...")) + V("FuncDef") + V("ArrowFuncDef") + (when("lexpr") * tag("LetExpr", mb(V("DestructuringNameList")) * sym("=") * - sym("=") * e(V("ExprList"), "EListLAssign"))) + V("SuffixedExpr") + V("StatExpr"), -- ./lepton/lpt-parser/parser.lua:588
["StatExpr"] = (V("IfStat") + V("DoStat") + V("WhileStat") + V("RepeatStat") + V("ForStat")) / statToExpr, -- ./lepton/lpt-parser/parser.lua:590
["FuncCall"] = Cmt(V("SuffixedExpr"), function(s, i, exp) -- ./lepton/lpt-parser/parser.lua:592
return calls[exp["tag"]] or false, exp -- ./lepton/lpt-parser/parser.lua:592
end), -- ./lepton/lpt-parser/parser.lua:592
["VarExpr"] = Cmt(V("SuffixedExpr"), function(s, i, exp) -- ./lepton/lpt-parser/parser.lua:593
return exp["tag"] == "Id" or exp["tag"] == "Index", exp -- ./lepton/lpt-parser/parser.lua:593
end), -- ./lepton/lpt-parser/parser.lua:593
["SuffixedExpr"] = Cf(V("PrimaryExpr") * (V("Index") + V("MethodStub") + V("Call")) ^ 0 + V("NoCallPrimaryExpr") * - V("Call") * (V("Index") + V("MethodStub") + V("Call")) ^ 0 + V("NoCallPrimaryExpr"), makeSuffixedExpr), -- ./lepton/lpt-parser/parser.lua:597
["PrimaryExpr"] = V("SelfId") * (V("SelfCall") + V("SelfIndex")) + V("Id") + tag("Paren", sym("(") * e(V("Expr"), "ExprParen") * e(sym(")"), "CParenExpr")) + V("StringFormat"), -- ./lepton/lpt-parser/parser.lua:601
["NoCallPrimaryExpr"] = tag("String", V("String")) + V("TableUnpack") + V("Table") + V("TableCompr"), -- ./lepton/lpt-parser/parser.lua:602
["Index"] = tag("DotIndex", sym("." * - P(".") * - V("Call") * - V("PipeOp") * - V("Table")) * e(V("StrId"), "NameIndex")) + tag("ArrayIndex", sym("[" * - P(S("=["))) * e(V("Expr"), "ExprIndex") * e(sym("]"), "CBracketIndex")) + tag("SafeDotIndex", sym("?." * - P(".")) * e(V("StrId"), "NameIndex")) + tag("SafeArrayIndex", sym("?[" * - P(S("=["))) * e(V("Expr"), "ExprIndex") * e(sym("]"), "CBracketIndex")), -- ./lepton/lpt-parser/parser.lua:606
["MethodStub"] = tag("MethodStub", sym(":" * - P(":")) * e(V("StrId"), "NameMeth")) + tag("SafeMethodStub", sym("?:" * - P(":")) * e(V("StrId"), "NameMeth")), -- ./lepton/lpt-parser/parser.lua:608
["Call"] = tag("Call", V("FuncArgs")) + tag("SafeCall", sym("?") * V("FuncArgs")) + tag("Broadcast", sym(".") * V("FuncArgs")) + tag("BroadcastKV", sym("..") * V("FuncArgs")) + tag("Filter", sym("-<") * V("FuncArgs")) + tag("FilterKV", sym("-<<") * V("FuncArgs")), -- ./lepton/lpt-parser/parser.lua:614
["SelfCall"] = tag("MethodStub", V("StrId")) * V("Call"), -- ./lepton/lpt-parser/parser.lua:615
["SelfIndex"] = tag("DotIndex", V("StrId")), -- ./lepton/lpt-parser/parser.lua:616
["FuncDef"] = (kw("fn") * V("FuncBody")), -- ./lepton/lpt-parser/parser.lua:618
["FuncArgs"] = sym("(") * commaSep(V("Expr"), "ArgList") ^ - 1 * e(sym(")"), "CParenArgs"), -- ./lepton/lpt-parser/parser.lua:619
["Table"] = tag("Table", sym("{") * V("FieldList") ^ - 1 * eEnd("CBraceTable")), -- ./lepton/lpt-parser/parser.lua:621
["FieldList"] = sepBy(V("Field"), V("FieldSep")) * V("FieldSep") ^ - 1, -- ./lepton/lpt-parser/parser.lua:622
["Field"] = tag("Pair", V("FieldKey") * e(sym("="), "EqField") * e(V("Expr"), "ExprField")) / fixLuaKeywords + V("Expr"), -- ./lepton/lpt-parser/parser.lua:624
["FieldKey"] = sym("[" * - P(S("=["))) * e(V("Expr"), "ExprFKey") * e(sym("]"), "CBracketFKey") + V("StrId") * # ("=" * - P("=")), -- ./lepton/lpt-parser/parser.lua:626
["FieldSep"] = sym(",") + sym(";"), -- ./lepton/lpt-parser/parser.lua:627
["TableUnpack"] = tag("TableUnpack", (V("Name") + V("Table")) * sym(".") * V("Table")), -- ./lepton/lpt-parser/parser.lua:629
["TableCompr"] = tag("TableCompr", sym("[") * V("Block") * e(sym("]"), "CBracketTableCompr")), -- ./lepton/lpt-parser/parser.lua:630
["SelfId"] = tag("Id", sym("@") / "self"), -- ./lepton/lpt-parser/parser.lua:632
["Id"] = (tag("Id", V("Name")) / fixLuaKeywords) + V("SelfId"), -- ./lepton/lpt-parser/parser.lua:633
["AttributeSelfId"] = tag("AttributeId", sym("@") / "self" * V("Attribute") ^ - 1), -- ./lepton/lpt-parser/parser.lua:634
["AttributeId"] = tag("AttributeId", V("Name") * V("Attribute") ^ - 1) / fixLuaKeywords + V("AttributeSelfId"), -- ./lepton/lpt-parser/parser.lua:635
["StrId"] = tag("String", V("Name")), -- ./lepton/lpt-parser/parser.lua:636
["Attribute"] = sym("<") * e(kw("const") / "const" + kw("close") / "close", "UnknownAttribute") * e(sym(">"), "CBracketAttribute"), -- ./lepton/lpt-parser/parser.lua:638
["Skip"] = (V("Space") + V("Comment")) ^ 0, -- ./lepton/lpt-parser/parser.lua:641
["Space"] = space ^ 1, -- ./lepton/lpt-parser/parser.lua:642
["Comment"] = P("--") * V("LongStr") / 0 + P("--") * (P(1) - P("\
")) ^ 0, -- ./lepton/lpt-parser/parser.lua:644
["Name"] = token(- V("Reserved") * C(V("Ident"))), -- ./lepton/lpt-parser/parser.lua:646
["Reserved"] = V("Keywords") * - V("IdRest"), -- ./lepton/lpt-parser/parser.lua:647
["Keywords"] = P("close") + "const" + "fn" + "global" + "let" + "push" + "break" + "else" + "false" + "for" + "goto" + "if" + "local" + "nil" + "repeat" + "return" + "true" + "until" + "while", -- ./lepton/lpt-parser/parser.lua:652
["Ident"] = V("IdStart") * V("IdRest") ^ 0, -- ./lepton/lpt-parser/parser.lua:653
["IdStart"] = alpha + P("_"), -- ./lepton/lpt-parser/parser.lua:654
["IdRest"] = alnum + P("_"), -- ./lepton/lpt-parser/parser.lua:655
["Number"] = token(C(V("Hex") + V("Bin") + V("Float") + V("Int"))), -- ./lepton/lpt-parser/parser.lua:657
["Hex"] = (P("0x") + "0X") * ((xdigit ^ 0 * V("DeciHex")) + (e(xdigit ^ 1, "DigitHex") * V("DeciHex") ^ - 1)) * V("ExpoHex") ^ - 1, -- ./lepton/lpt-parser/parser.lua:658
["Bin"] = (P("0b") + "0B") * ((S("_01") ^ 0 * V("DeciBin")) + (e(S("_01") ^ 1, "DigitBin") * V("DeciBin") ^ - 1)), -- ./lepton/lpt-parser/parser.lua:659
["Float"] = V("Decimal") * V("Expo") ^ - 1 + V("Int") * V("Expo"), -- ./lepton/lpt-parser/parser.lua:661
["Decimal"] = digit ^ 1 * "." * digit ^ 0 + P(".") * - P(".") * - V("Table") * e(digit ^ 1, "DigitDeci"), -- ./lepton/lpt-parser/parser.lua:663
["DeciHex"] = P(".") * xdigit ^ 0, -- ./lepton/lpt-parser/parser.lua:664
["DeciBin"] = P(".") * S("_01") ^ 0, -- ./lepton/lpt-parser/parser.lua:665
["Expo"] = S("eE") * S("+-") ^ - 1 * e(digit ^ 1, "DigitExpo"), -- ./lepton/lpt-parser/parser.lua:666
["ExpoHex"] = S("pP") * S("+-") ^ - 1 * e(xdigit ^ 1, "DigitExpo"), -- ./lepton/lpt-parser/parser.lua:667
["Int"] = digit ^ 1, -- ./lepton/lpt-parser/parser.lua:668
["StringFormat"] = tag("StringFormat", V("String") * V("Call")), -- ./lepton/lpt-parser/parser.lua:670
["String"] = token(V("ShortStr") + V("LongStr")), -- ./lepton/lpt-parser/parser.lua:671
["ShortStr"] = P("\"") * Cs((V("EscSeq") + (P(1) - S("\"\
"))) ^ 0) * e(P("\""), "Quote") + P("'") * Cs((V("EscSeq") + (P(1) - S("'\
"))) ^ 0) * e(P("'"), "Quote"), -- ./lepton/lpt-parser/parser.lua:673
["EscSeq"] = P("\\") / "" * (P("a") / "\7" + P("b") / "\8" + P("f") / "\12" + P("n") / "\
" + P("r") / "\13" + P("t") / "\9" + P("v") / "\11" + P("\
") / "\
" + P("\13") / "\
" + P("\\") / "\\" + P("\"") / "\"" + P("'") / "'" + P("z") * space ^ 0 / "" + digit * digit ^ - 2 / tonumber / string["char"] + P("x") * e(C(xdigit * xdigit), "HexEsc") * Cc(16) / tonumber / string["char"] + P("u") * e("{", "OBraceUEsc") * e(C(xdigit ^ 1), "DigitUEsc") * Cc(16) * e("}", "CBraceUEsc") / tonumber / (utf8 and utf8["char"] or string["char"]) + throw("EscSeq")), -- ./lepton/lpt-parser/parser.lua:703
["LongStr"] = V("Open") * C((P(1) - V("CloseEq")) ^ 0) * e(V("Close"), "CloseLStr") / function(s, eqs) -- ./lepton/lpt-parser/parser.lua:706
return s -- ./lepton/lpt-parser/parser.lua:706
end, -- ./lepton/lpt-parser/parser.lua:706
["Open"] = "[" * Cg(V("Equals"), "openEq") * "[" * P("\
") ^ - 1, -- ./lepton/lpt-parser/parser.lua:707
["Close"] = "]" * C(V("Equals")) * "]", -- ./lepton/lpt-parser/parser.lua:708
["Equals"] = P("=") ^ 0, -- ./lepton/lpt-parser/parser.lua:709
["CloseEq"] = Cmt(V("Close") * Cb("openEq"), function(s, i, closeEq, openEq) -- ./lepton/lpt-parser/parser.lua:710
return # openEq == # closeEq -- ./lepton/lpt-parser/parser.lua:710
end), -- ./lepton/lpt-parser/parser.lua:710
["PipeOp"] = sym("|>") / "pipe" + sym(".|>") / "pipebc" + sym("..|>") / "pipebckv", -- ./lepton/lpt-parser/parser.lua:714
["OrOp"] = sym("||") / "or", -- ./lepton/lpt-parser/parser.lua:718
["AndOp"] = sym("&&") / "and", -- ./lepton/lpt-parser/parser.lua:719
["RelOp"] = sym("!=") / "ne" + sym("==") / "eq" + sym("<=") / "le" + sym(">=") / "ge" + sym("<") / "lt" + sym(">") / "gt" + sym("%%") / "divb" + sym("!%") / "ndivb", -- ./lepton/lpt-parser/parser.lua:727
["BOrOp"] = sym("|" - P("||") - P("|>")) / "bor", -- ./lepton/lpt-parser/parser.lua:728
["BXorOp"] = sym("~") / "bxor", -- ./lepton/lpt-parser/parser.lua:729
["BAndOp"] = sym("&" - P("&&")) / "band", -- ./lepton/lpt-parser/parser.lua:730
["ShiftOp"] = sym("<<") / "shl" + sym(">>") / "shr", -- ./lepton/lpt-parser/parser.lua:732
["ConcatOp"] = sym("++") / "concat", -- ./lepton/lpt-parser/parser.lua:733
["TConcatOp"] = sym("+++") / "tconcat", -- ./lepton/lpt-parser/parser.lua:734
["AddOp"] = sym("+" - P("++")) / "add" + sym("-" - P("->") - P("-<")) / "sub", -- ./lepton/lpt-parser/parser.lua:736
["AppendOp"] = sym("#=") / "tappend", -- ./lepton/lpt-parser/parser.lua:737
["MulOp"] = sym("*") / "mul" + sym("//") / "idiv" + sym("/") / "div" + sym("%" - P("%%")) / "mod", -- ./lepton/lpt-parser/parser.lua:741
["UnaryOp"] = sym("!") / "not" + sym("-") / "unm" + sym("#") / "len" + sym("~") / "bnot", -- ./lepton/lpt-parser/parser.lua:745
["PowOp"] = sym("^") / "pow", -- ./lepton/lpt-parser/parser.lua:746
["BinOp"] = V("PipeOp") + V("OrOp") + V("AndOp") + V("BOrOp") + V("BXorOp") + V("BAndOp") + V("ShiftOp") + V("ConcatOp") + V("TConcatOp") + V("AddOp") + V("MulOp") + V("PowOp") -- ./lepton/lpt-parser/parser.lua:747
} -- ./lepton/lpt-parser/parser.lua:747
local macroidentifier = { -- ./lepton/lpt-parser/parser.lua:752
e(V("MacroIdentifier"), "InvalidStat") * e(P(- 1), "Extra"), -- ./lepton/lpt-parser/parser.lua:753
["MacroIdentifier"] = tag("MacroFunction", V("Id") * sym("(") * V("MacroFunctionArgs") * e(sym(")"), "CParenPList")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:756
["MacroFunctionArgs"] = V("NameList") * (sym(",") * e(tag("Dots", sym("...")), "ParList")) ^ - 1 / addDots + Ct(tag("Dots", sym("..."))) + Ct(Cc()) -- ./lepton/lpt-parser/parser.lua:760
} -- ./lepton/lpt-parser/parser.lua:760
for k, v in pairs(G) do -- ./lepton/lpt-parser/parser.lua:764
if macroidentifier[k] == nil then -- ./lepton/lpt-parser/parser.lua:765
macroidentifier[k] = v -- ./lepton/lpt-parser/parser.lua:766
end -- ./lepton/lpt-parser/parser.lua:766
end -- ./lepton/lpt-parser/parser.lua:766
local parser = {} -- ./lepton/lpt-parser/parser.lua:772
local validator = require("lepton.lpt-parser.validator") -- ./lepton/lpt-parser/parser.lua:774
local validate = validator["validate"] -- ./lepton/lpt-parser/parser.lua:775
local syntaxerror = validator["syntaxerror"] -- ./lepton/lpt-parser/parser.lua:776
parser["parse"] = function(subject, filename) -- ./lepton/lpt-parser/parser.lua:778
local errorinfo = { -- ./lepton/lpt-parser/parser.lua:779
["subject"] = subject, -- ./lepton/lpt-parser/parser.lua:779
["filename"] = filename -- ./lepton/lpt-parser/parser.lua:779
} -- ./lepton/lpt-parser/parser.lua:779
lpeg["setmaxstack"](1000) -- ./lepton/lpt-parser/parser.lua:780
local ast, label, errpos = lpeg["match"](G, subject, nil, errorinfo) -- ./lepton/lpt-parser/parser.lua:781
if not ast then -- ./lepton/lpt-parser/parser.lua:782
local errmsg = labels[label][2] -- ./lepton/lpt-parser/parser.lua:783
return ast, syntaxerror(errorinfo, errpos, errmsg) -- ./lepton/lpt-parser/parser.lua:784
end -- ./lepton/lpt-parser/parser.lua:784
return validate(ast, errorinfo) -- ./lepton/lpt-parser/parser.lua:786
end -- ./lepton/lpt-parser/parser.lua:786
parser["parsemacroidentifier"] = function(subject, filename) -- ./lepton/lpt-parser/parser.lua:789
local errorinfo = { -- ./lepton/lpt-parser/parser.lua:790
["subject"] = subject, -- ./lepton/lpt-parser/parser.lua:790
["filename"] = filename -- ./lepton/lpt-parser/parser.lua:790
} -- ./lepton/lpt-parser/parser.lua:790
lpeg["setmaxstack"](1000) -- ./lepton/lpt-parser/parser.lua:791
local ast, label, errpos = lpeg["match"](macroidentifier, subject, nil, errorinfo) -- ./lepton/lpt-parser/parser.lua:792
if not ast then -- ./lepton/lpt-parser/parser.lua:793
local errmsg = labels[label][2] -- ./lepton/lpt-parser/parser.lua:794
return ast, syntaxerror(errorinfo, errpos, errmsg) -- ./lepton/lpt-parser/parser.lua:795
end -- ./lepton/lpt-parser/parser.lua:795
return ast -- ./lepton/lpt-parser/parser.lua:797
end -- ./lepton/lpt-parser/parser.lua:797
return parser -- ./lepton/lpt-parser/parser.lua:800
end -- ./lepton/lpt-parser/parser.lua:800
local parser = _() or parser -- ./lepton/lpt-parser/parser.lua:805
package["loaded"]["lepton.lpt-parser.parser"] = parser or true -- ./lepton/lpt-parser/parser.lua:806
local unpack = unpack or table["unpack"] -- lepton.lpt:20
lepton["default"] = { -- lepton.lpt:23
["target"] = "lua54", -- lepton.lpt:24
["indentation"] = "", -- lepton.lpt:25
["newline"] = "\
", -- lepton.lpt:26
["variablePrefix"] = "__LPT_", -- lepton.lpt:27
["mapLines"] = true, -- lepton.lpt:28
["chunkname"] = "nil", -- lepton.lpt:29
["rewriteErrors"] = true, -- lepton.lpt:30
["builtInMacros"] = true, -- lepton.lpt:31
["preprocessorEnv"] = {}, -- lepton.lpt:32
["import"] = {} -- lepton.lpt:33
} -- lepton.lpt:33
if _VERSION == "Lua 5.1" then -- lepton.lpt:37
if package["loaded"]["jit"] then -- lepton.lpt:38
lepton["default"]["target"] = "luajit" -- lepton.lpt:39
else -- lepton.lpt:39
lepton["default"]["target"] = "lua51" -- lepton.lpt:41
end -- lepton.lpt:41
elseif _VERSION == "Lua 5.2" then -- lepton.lpt:43
lepton["default"]["target"] = "lua52" -- lepton.lpt:44
elseif _VERSION == "Lua 5.3" then -- lepton.lpt:45
lepton["default"]["target"] = "lua53" -- lepton.lpt:46
end -- lepton.lpt:46
lepton["preprocess"] = function(input, options, _env) -- lepton.lpt:56
if options == nil then options = {} end -- lepton.lpt:56
options = util["merge"](lepton["default"], options) -- lepton.lpt:57
local macros = { -- lepton.lpt:58
["functions"] = {}, -- lepton.lpt:59
["variables"] = {} -- lepton.lpt:60
} -- lepton.lpt:60
for _, mod in ipairs(options["import"]) do -- lepton.lpt:64
input = (("#import(%q, {loadLocal=false})\
"):format(mod)) .. input -- lepton.lpt:65
end -- lepton.lpt:65
local preprocessor = "" -- lepton.lpt:69
local i = 0 -- lepton.lpt:70
local inLongString = false -- lepton.lpt:71
local inComment = false -- lepton.lpt:72
for line in (input .. "\
"):gmatch("(.-\
)") do -- lepton.lpt:73
i = i + (1) -- lepton.lpt:74
if inComment then -- lepton.lpt:76
inComment = not line:match("%]%]") -- lepton.lpt:77
elseif inLongString then -- lepton.lpt:78
inLongString = not line:match("%]%]") -- lepton.lpt:79
else -- lepton.lpt:79
if line:match("[^%-]%[%[") then -- lepton.lpt:81
inLongString = true -- lepton.lpt:82
elseif line:match("%-%-%[%[") then -- lepton.lpt:83
inComment = true -- lepton.lpt:84
end -- lepton.lpt:84
end -- lepton.lpt:84
if not inComment and not inLongString and line:match("^%s*#") and not line:match("^#!") then -- lepton.lpt:87
preprocessor = preprocessor .. (line:gsub("^%s*#", "")) -- lepton.lpt:88
else -- lepton.lpt:88
local l = line:sub(1, - 2) -- lepton.lpt:90
if not inLongString and options["mapLines"] and not l:match("%-%- (.-)%:(%d+)$") then -- lepton.lpt:91
preprocessor = preprocessor .. (("write(%q)"):format(l .. " -- " .. options["chunkname"] .. ":" .. i) .. "\
") -- lepton.lpt:92
else -- lepton.lpt:92
preprocessor = preprocessor .. (("write(%q)"):format(line:sub(1, - 2)) .. "\
") -- lepton.lpt:94
end -- lepton.lpt:94
end -- lepton.lpt:94
end -- lepton.lpt:94
preprocessor = preprocessor .. ("return output") -- lepton.lpt:98
local exportenv = {} -- lepton.lpt:101
local env = util["merge"](_G, options["preprocessorEnv"]) -- lepton.lpt:102
env["lepton"] = lepton -- lepton.lpt:104
env["output"] = "" -- lepton.lpt:106
env["import"] = function(modpath, margs) -- lepton.lpt:113
if margs == nil then margs = {} end -- lepton.lpt:113
local filepath = assert(util["search"](modpath, { -- lepton.lpt:114
"lpt", -- lepton.lpt:114
"lua" -- lepton.lpt:114
}), "No module named '" .. modpath .. "'") -- lepton.lpt:114
local f = io["open"](filepath) -- lepton.lpt:117
if not f then -- lepton.lpt:118
error("can't open the module file to import") -- lepton.lpt:118
end -- lepton.lpt:118
margs = util["merge"](options, { -- lepton.lpt:120
["chunkname"] = filepath, -- lepton.lpt:120
["loadLocal"] = true, -- lepton.lpt:120
["loadPackage"] = true -- lepton.lpt:120
}, margs) -- lepton.lpt:120
margs["import"] = {} -- lepton.lpt:121
local modcontent, modmacros, modenv = assert(lepton["preprocess"](f:read("*a"), margs)) -- lepton.lpt:122
macros = util["recmerge"](macros, modmacros) -- lepton.lpt:123
for k, v in pairs(modenv) do -- lepton.lpt:124
env[k] = v -- lepton.lpt:124
end -- lepton.lpt:124
f:close() -- lepton.lpt:125
local modname = modpath:match("[^%.]+$") -- lepton.lpt:128
env["write"]("-- MODULE " .. modpath .. " --\
" .. "local function _()\
" .. modcontent .. "\
" .. "end\
" .. (margs["loadLocal"] and ("local %s = _() or %s\
"):format(modname, modname) or "") .. (margs["loadPackage"] and ("package.loaded[%q] = %s or true\
"):format(modpath, margs["loadLocal"] and modname or "_()") or "") .. "-- END OF MODULE " .. modpath .. " --") -- lepton.lpt:137
end -- lepton.lpt:137
env["include"] = function(file) -- lepton.lpt:142
local f = io["open"](file) -- lepton.lpt:143
if not f then -- lepton.lpt:144
error("can't open the file " .. file .. " to include") -- lepton.lpt:144
end -- lepton.lpt:144
env["write"](f:read("*a")) -- lepton.lpt:145
f:close() -- lepton.lpt:146
end -- lepton.lpt:146
env["write"] = function(...) -- lepton.lpt:150
env["output"] = env["output"] .. (table["concat"]({ ... }, "\9") .. "\
") -- lepton.lpt:151
end -- lepton.lpt:151
env["placeholder"] = function(name) -- lepton.lpt:155
if env[name] then -- lepton.lpt:156
env["write"](env[name]) -- lepton.lpt:157
end -- lepton.lpt:157
end -- lepton.lpt:157
env["define"] = function(identifier, replacement) -- lepton.lpt:160
local iast, ierr = parser["parsemacroidentifier"](identifier, options["chunkname"]) -- lepton.lpt:162
if not iast then -- lepton.lpt:163
return error(("in macro identifier: %s"):format(tostring(ierr))) -- lepton.lpt:164
end -- lepton.lpt:164
if type(replacement) == "string" then -- lepton.lpt:167
local rast, rerr = parser["parse"](replacement, options["chunkname"]) -- lepton.lpt:168
if not rast then -- lepton.lpt:169
return error(("in macro replacement: %s"):format(tostring(rerr))) -- lepton.lpt:170
end -- lepton.lpt:170
if # rast == 1 and rast[1]["tag"] == "Push" and rast[1]["implicit"] then -- lepton.lpt:173
rast = rast[1][1] -- lepton.lpt:174
end -- lepton.lpt:174
replacement = rast -- lepton.lpt:176
elseif type(replacement) ~= "function" then -- lepton.lpt:177
error("bad argument #2 to 'define' (string or function expected)") -- lepton.lpt:178
end -- lepton.lpt:178
if iast["tag"] == "MacroFunction" then -- lepton.lpt:181
macros["functions"][iast[1][1]] = { -- lepton.lpt:182
["args"] = iast[2], -- lepton.lpt:182
["replacement"] = replacement -- lepton.lpt:182
} -- lepton.lpt:182
elseif iast["tag"] == "Id" then -- lepton.lpt:183
macros["variables"][iast[1]] = replacement -- lepton.lpt:184
else -- lepton.lpt:184
error(("invalid macro type %s"):format(tostring(iast["tag"]))) -- lepton.lpt:186
end -- lepton.lpt:186
end -- lepton.lpt:186
env["set"] = function(identifier, value) -- lepton.lpt:189
exportenv[identifier] = value -- lepton.lpt:190
env[identifier] = value -- lepton.lpt:191
end -- lepton.lpt:191
if options["builtInMacros"] then -- lepton.lpt:195
env["define"]("__STR__(x)", function(x) -- lepton.lpt:196
return ("%q"):format(x) -- lepton.lpt:196
end) -- lepton.lpt:196
local s = require("lepton.serpent") -- lepton.lpt:197
env["define"]("__CONSTEXPR__(expr)", function(expr) -- lepton.lpt:198
return s["block"](assert(lepton["load"](expr))(), { ["fatal"] = true }) -- lepton.lpt:199
end) -- lepton.lpt:199
end -- lepton.lpt:199
local preprocess, err = lepton["compile"](preprocessor, options) -- lepton.lpt:204
if not preprocess then -- lepton.lpt:205
return nil, "in preprocessor: " .. err -- lepton.lpt:206
end -- lepton.lpt:206
preprocess, err = util["load"](preprocessor, "lepton preprocessor", env) -- lepton.lpt:209
if not preprocess then -- lepton.lpt:210
return nil, "in preprocessor: " .. err -- lepton.lpt:211
end -- lepton.lpt:211
local success, output = pcall(preprocess) -- lepton.lpt:215
if not success then -- lepton.lpt:216
return nil, "in preprocessor: " .. output -- lepton.lpt:217
end -- lepton.lpt:217
return output, macros, exportenv -- lepton.lpt:220
end -- lepton.lpt:220
lepton["compile"] = function(input, options, macros) -- lepton.lpt:230
if options == nil then options = {} end -- lepton.lpt:230
options = util["merge"](lepton["default"], options) -- lepton.lpt:231
local ast, errmsg = parser["parse"](input, options["chunkname"]) -- lepton.lpt:233
if not ast then -- lepton.lpt:235
return nil, errmsg -- lepton.lpt:236
end -- lepton.lpt:236
return require("compiler." .. options["target"])(input, ast, options, macros) -- lepton.lpt:239
end -- lepton.lpt:239
lepton["make"] = function(code, options) -- lepton.lpt:248
local r, err = lepton["preprocess"](code, options) -- lepton.lpt:249
if r then -- lepton.lpt:250
r, err = lepton["compile"](r, options, err) -- lepton.lpt:251
if r then -- lepton.lpt:252
return r -- lepton.lpt:253
end -- lepton.lpt:253
end -- lepton.lpt:253
return r, err -- lepton.lpt:256
end -- lepton.lpt:256
local errorRewritingActive = false -- lepton.lpt:259
local codeCache = {} -- lepton.lpt:260
lepton["loadfile"] = function(filepath, env, options) -- lepton.lpt:263
local f, err = io["open"](filepath) -- lepton.lpt:264
if not f then -- lepton.lpt:265
return nil, ("cannot open %s"):format(tostring(err)) -- lepton.lpt:266
end -- lepton.lpt:266
local content = f:read("*a") -- lepton.lpt:268
f:close() -- lepton.lpt:269
return lepton["load"](content, filepath, env, options) -- lepton.lpt:271
end -- lepton.lpt:271
lepton["load"] = function(chunk, chunkname, env, options) -- lepton.lpt:276
if options == nil then options = {} end -- lepton.lpt:276
options = util["merge"]({ ["chunkname"] = tostring(chunkname or chunk) }, options) -- lepton.lpt:277
local code, err = lepton["make"](chunk, options) -- lepton.lpt:279
if not code then -- lepton.lpt:280
return code, err -- lepton.lpt:281
end -- lepton.lpt:281
codeCache[options["chunkname"]] = code -- lepton.lpt:284
local f -- lepton.lpt:285
f, err = util["load"](code, ("=%s(%s)"):format(options["chunkname"], "compiled lepton"), env) -- lepton.lpt:286
if f == nil then -- lepton.lpt:291
return f, "lepton unexpectedly generated invalid code: " .. err -- lepton.lpt:292
end -- lepton.lpt:292
if options["rewriteErrors"] == false then -- lepton.lpt:295
return f -- lepton.lpt:296
else -- lepton.lpt:296
return function(...) -- lepton.lpt:298
if not errorRewritingActive then -- lepton.lpt:299
errorRewritingActive = true -- lepton.lpt:300
local t = { xpcall(f, lepton["messageHandler"], ...) } -- lepton.lpt:301
errorRewritingActive = false -- lepton.lpt:302
if t[1] == false then -- lepton.lpt:303
error(t[2], 0) -- lepton.lpt:304
end -- lepton.lpt:304
return unpack(t, 2) -- lepton.lpt:306
else -- lepton.lpt:306
return f(...) -- lepton.lpt:308
end -- lepton.lpt:308
end -- lepton.lpt:308
end -- lepton.lpt:308
end -- lepton.lpt:308
lepton["dofile"] = function(filename, options) -- lepton.lpt:316
local f, err = lepton["loadfile"](filename, nil, options) -- lepton.lpt:317
if f == nil then -- lepton.lpt:319
error(err) -- lepton.lpt:320
else -- lepton.lpt:320
return f() -- lepton.lpt:322
end -- lepton.lpt:322
end -- lepton.lpt:322
lepton["messageHandler"] = function(message, noTraceback) -- lepton.lpt:328
message = tostring(message) -- lepton.lpt:329
if not noTraceback and not message:match("\
stack traceback:\
") then -- lepton.lpt:330
message = debug["traceback"](message, 2) -- lepton.lpt:331
end -- lepton.lpt:331
return message:gsub("(\
?%s*)([^\
]-)%:(%d+)%:", function(indentation, source, line) -- lepton.lpt:333
line = tonumber(line) -- lepton.lpt:334
local originalFile -- lepton.lpt:336
local strName = source:match("^(.-)%(compiled lepton%)$") -- lepton.lpt:337
if strName then -- lepton.lpt:338
if codeCache[strName] then -- lepton.lpt:339
originalFile = codeCache[strName] -- lepton.lpt:340
source = strName -- lepton.lpt:341
end -- lepton.lpt:341
else -- lepton.lpt:341
do -- lepton.lpt:344
local fi -- lepton.lpt:344
fi = io["open"](source, "r") -- lepton.lpt:344
if fi then -- lepton.lpt:344
originalFile = fi:read("*a") -- lepton.lpt:345
fi:close() -- lepton.lpt:346
end -- lepton.lpt:346
end -- lepton.lpt:346
end -- lepton.lpt:346
if originalFile then -- lepton.lpt:350
local i = 0 -- lepton.lpt:351
for l in (originalFile .. "\
"):gmatch("([^\
]*)\
") do -- lepton.lpt:352
i = i + 1 -- lepton.lpt:353
if i == line then -- lepton.lpt:354
local extSource, lineMap = l:match(".*%-%- (.-)%:(%d+)$") -- lepton.lpt:355
if lineMap then -- lepton.lpt:356
if extSource ~= source then -- lepton.lpt:357
return indentation .. extSource .. ":" .. lineMap .. "(" .. extSource .. ":" .. line .. "):" -- lepton.lpt:358
else -- lepton.lpt:358
return indentation .. extSource .. ":" .. lineMap .. "(" .. line .. "):" -- lepton.lpt:360
end -- lepton.lpt:360
end -- lepton.lpt:360
break -- lepton.lpt:363
end -- lepton.lpt:363
end -- lepton.lpt:363
end -- lepton.lpt:363
end) -- lepton.lpt:363
end -- lepton.lpt:363
lepton["searcher"] = function(modpath) -- lepton.lpt:371
local filepath = util["search"](modpath, { "lpt" }) -- lepton.lpt:372
if not filepath then -- lepton.lpt:373
if _VERSION == "Lua 5.4" then -- lepton.lpt:374
return "no lepton file in package.path" -- lepton.lpt:375
else -- lepton.lpt:375
return "\
\9no lepton file in package.path" -- lepton.lpt:377
end -- lepton.lpt:377
end -- lepton.lpt:377
return function(modpath) -- lepton.lpt:380
local r, s = lepton["loadfile"](filepath) -- lepton.lpt:381
if r then -- lepton.lpt:382
return r(modpath, filepath) -- lepton.lpt:383
else -- lepton.lpt:383
error(("error loading lepton module '%s' from file '%s':\
\9%s"):format(modpath, filepath, tostring(s)), 0) -- lepton.lpt:385
end -- lepton.lpt:385
end, filepath -- lepton.lpt:387
end -- lepton.lpt:387
lepton["setup"] = function() -- lepton.lpt:391
local searchers = (function() -- lepton.lpt:392
if _VERSION == "Lua 5.1" then -- lepton.lpt:392
return package["loaders"] -- lepton.lpt:393
else -- lepton.lpt:393
return package["searchers"] -- lepton.lpt:395
end -- lepton.lpt:395
end)() -- lepton.lpt:395
for _, s in ipairs(searchers) do -- lepton.lpt:398
if s == lepton["searcher"] then -- lepton.lpt:399
return lepton -- lepton.lpt:400
end -- lepton.lpt:400
end -- lepton.lpt:400
table["insert"](searchers, 1, lepton["searcher"]) -- lepton.lpt:404
return lepton -- lepton.lpt:405
end -- lepton.lpt:405
return lepton -- lepton.lpt:408
