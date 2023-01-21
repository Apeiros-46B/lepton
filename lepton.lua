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
local indentLevel = 0 -- ./compiler/lua54.lpt:15
local function newline() -- ./compiler/lua54.lpt:17
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.lpt:18
if options["mapLines"] then -- ./compiler/lua54.lpt:19
local sub = code:sub(lastInputPos) -- ./compiler/lua54.lpt:20
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.lpt:21
if source and line then -- ./compiler/lua54.lpt:23
lastSource = source -- ./compiler/lua54.lpt:24
lastLine = tonumber(line) -- ./compiler/lua54.lpt:25
else -- ./compiler/lua54.lpt:25
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.lpt:27
lastLine = lastLine + (1) -- ./compiler/lua54.lpt:28
end -- ./compiler/lua54.lpt:28
end -- ./compiler/lua54.lpt:28
prevLinePos = lastInputPos -- ./compiler/lua54.lpt:32
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.lpt:34
end -- ./compiler/lua54.lpt:34
return r -- ./compiler/lua54.lpt:36
end -- ./compiler/lua54.lpt:36
local function indent() -- ./compiler/lua54.lpt:39
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:40
return newline() -- ./compiler/lua54.lpt:41
end -- ./compiler/lua54.lpt:41
local function unindent() -- ./compiler/lua54.lpt:44
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:45
return newline() -- ./compiler/lua54.lpt:46
end -- ./compiler/lua54.lpt:46
local states = { -- ./compiler/lua54.lpt:51
["push"] = {}, -- ./compiler/lua54.lpt:52
["destructuring"] = {}, -- ./compiler/lua54.lpt:53
["scope"] = {}, -- ./compiler/lua54.lpt:54
["macroargs"] = {} -- ./compiler/lua54.lpt:55
} -- ./compiler/lua54.lpt:55
local function push(name, state) -- ./compiler/lua54.lpt:58
table["insert"](states[name], state) -- ./compiler/lua54.lpt:59
return "" -- ./compiler/lua54.lpt:60
end -- ./compiler/lua54.lpt:60
local function pop(name) -- ./compiler/lua54.lpt:63
table["remove"](states[name]) -- ./compiler/lua54.lpt:64
return "" -- ./compiler/lua54.lpt:65
end -- ./compiler/lua54.lpt:65
local function set(name, state) -- ./compiler/lua54.lpt:68
states[name][# states[name]] = state -- ./compiler/lua54.lpt:69
return "" -- ./compiler/lua54.lpt:70
end -- ./compiler/lua54.lpt:70
local function peek(name) -- ./compiler/lua54.lpt:73
return states[name][# states[name]] -- ./compiler/lua54.lpt:74
end -- ./compiler/lua54.lpt:74
local function var(name) -- ./compiler/lua54.lpt:79
return options["variablePrefix"] .. name -- ./compiler/lua54.lpt:80
end -- ./compiler/lua54.lpt:80
local function tmp() -- ./compiler/lua54.lpt:84
local scope = peek("scope") -- ./compiler/lua54.lpt:85
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.lpt:86
table["insert"](scope, var) -- ./compiler/lua54.lpt:87
return var -- ./compiler/lua54.lpt:88
end -- ./compiler/lua54.lpt:88
local nomacro = { -- ./compiler/lua54.lpt:92
["variables"] = {}, -- ./compiler/lua54.lpt:92
["functions"] = {} -- ./compiler/lua54.lpt:92
} -- ./compiler/lua54.lpt:92
local required = {} -- ./compiler/lua54.lpt:95
local requireStr = "" -- ./compiler/lua54.lpt:96
local function addRequire(mod, name, field) -- ./compiler/lua54.lpt:98
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.lpt:99
if not required[req] then -- ./compiler/lua54.lpt:100
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.lpt:101
required[req] = true -- ./compiler/lua54.lpt:102
end -- ./compiler/lua54.lpt:102
end -- ./compiler/lua54.lpt:102
local loop = { -- ./compiler/lua54.lpt:107
"While", -- ./compiler/lua54.lpt:107
"Repeat", -- ./compiler/lua54.lpt:107
"Fornum", -- ./compiler/lua54.lpt:107
"Forin", -- ./compiler/lua54.lpt:107
"WhileExpr", -- ./compiler/lua54.lpt:107
"RepeatExpr", -- ./compiler/lua54.lpt:107
"FornumExpr", -- ./compiler/lua54.lpt:107
"ForinExpr" -- ./compiler/lua54.lpt:107
} -- ./compiler/lua54.lpt:107
local func = { -- ./compiler/lua54.lpt:108
"Function", -- ./compiler/lua54.lpt:108
"TableCompr", -- ./compiler/lua54.lpt:108
"DoExpr", -- ./compiler/lua54.lpt:108
"WhileExpr", -- ./compiler/lua54.lpt:108
"RepeatExpr", -- ./compiler/lua54.lpt:108
"IfExpr", -- ./compiler/lua54.lpt:108
"FornumExpr", -- ./compiler/lua54.lpt:108
"ForinExpr" -- ./compiler/lua54.lpt:108
} -- ./compiler/lua54.lpt:108
local function any(list, tags, nofollow) -- ./compiler/lua54.lpt:112
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:112
local tagsCheck = {} -- ./compiler/lua54.lpt:113
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:114
tagsCheck[tag] = true -- ./compiler/lua54.lpt:115
end -- ./compiler/lua54.lpt:115
local nofollowCheck = {} -- ./compiler/lua54.lpt:117
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:118
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:119
end -- ./compiler/lua54.lpt:119
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:121
if type(node) == "table" then -- ./compiler/lua54.lpt:122
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:123
return node -- ./compiler/lua54.lpt:124
end -- ./compiler/lua54.lpt:124
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:126
local r = any(node, tags, nofollow) -- ./compiler/lua54.lpt:127
if r then -- ./compiler/lua54.lpt:128
return r -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
return nil -- ./compiler/lua54.lpt:132
end -- ./compiler/lua54.lpt:132
local function search(list, tags, nofollow) -- ./compiler/lua54.lpt:137
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:137
local tagsCheck = {} -- ./compiler/lua54.lpt:138
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:139
tagsCheck[tag] = true -- ./compiler/lua54.lpt:140
end -- ./compiler/lua54.lpt:140
local nofollowCheck = {} -- ./compiler/lua54.lpt:142
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:143
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:144
end -- ./compiler/lua54.lpt:144
local found = {} -- ./compiler/lua54.lpt:146
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:147
if type(node) == "table" then -- ./compiler/lua54.lpt:148
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:149
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.lpt:150
table["insert"](found, n) -- ./compiler/lua54.lpt:151
end -- ./compiler/lua54.lpt:151
end -- ./compiler/lua54.lpt:151
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:154
table["insert"](found, node) -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
return found -- ./compiler/lua54.lpt:159
end -- ./compiler/lua54.lpt:159
local function all(list, tags) -- ./compiler/lua54.lpt:163
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:164
local ok = false -- ./compiler/lua54.lpt:165
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:166
if node["tag"] == tag then -- ./compiler/lua54.lpt:167
ok = true -- ./compiler/lua54.lpt:168
break -- ./compiler/lua54.lpt:169
end -- ./compiler/lua54.lpt:169
end -- ./compiler/lua54.lpt:169
if not ok then -- ./compiler/lua54.lpt:172
return false -- ./compiler/lua54.lpt:173
end -- ./compiler/lua54.lpt:173
end -- ./compiler/lua54.lpt:173
return true -- ./compiler/lua54.lpt:176
end -- ./compiler/lua54.lpt:176
local tags -- ./compiler/lua54.lpt:180
local function lua(ast, forceTag, ...) -- ./compiler/lua54.lpt:182
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.lpt:183
lastInputPos = ast["pos"] -- ./compiler/lua54.lpt:184
end -- ./compiler/lua54.lpt:184
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.lpt:186
end -- ./compiler/lua54.lpt:186
local UNPACK = function(list, i, j) -- ./compiler/lua54.lpt:190
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.lpt:191
end -- ./compiler/lua54.lpt:191
local APPEND = function(t, toAppend) -- ./compiler/lua54.lpt:193
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.lpt:194
end -- ./compiler/lua54.lpt:194
local CONTINUE_START = function() -- ./compiler/lua54.lpt:196
return "do" .. indent() -- ./compiler/lua54.lpt:197
end -- ./compiler/lua54.lpt:197
local CONTINUE_STOP = function() -- ./compiler/lua54.lpt:199
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.lpt:200
end -- ./compiler/lua54.lpt:200
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.lpt:202
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.lpt:202
if noLocal == nil then noLocal = false end -- ./compiler/lua54.lpt:202
local vars = {} -- ./compiler/lua54.lpt:203
local values = {} -- ./compiler/lua54.lpt:204
for _, list in ipairs(destructured) do -- ./compiler/lua54.lpt:205
for _, v in ipairs(list) do -- ./compiler/lua54.lpt:206
local var, val -- ./compiler/lua54.lpt:207
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.lpt:208
var = v -- ./compiler/lua54.lpt:209
val = { -- ./compiler/lua54.lpt:210
["tag"] = "Index", -- ./compiler/lua54.lpt:210
{ -- ./compiler/lua54.lpt:210
["tag"] = "Id", -- ./compiler/lua54.lpt:210
list["id"] -- ./compiler/lua54.lpt:210
}, -- ./compiler/lua54.lpt:210
{ -- ./compiler/lua54.lpt:210
["tag"] = "String", -- ./compiler/lua54.lpt:210
v[1] -- ./compiler/lua54.lpt:210
} -- ./compiler/lua54.lpt:210
} -- ./compiler/lua54.lpt:210
elseif v["tag"] == "Pair" then -- ./compiler/lua54.lpt:211
var = v[2] -- ./compiler/lua54.lpt:212
val = { -- ./compiler/lua54.lpt:213
["tag"] = "Index", -- ./compiler/lua54.lpt:213
{ -- ./compiler/lua54.lpt:213
["tag"] = "Id", -- ./compiler/lua54.lpt:213
list["id"] -- ./compiler/lua54.lpt:213
}, -- ./compiler/lua54.lpt:213
v[1] -- ./compiler/lua54.lpt:213
} -- ./compiler/lua54.lpt:213
else -- ./compiler/lua54.lpt:213
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.lpt:215
end -- ./compiler/lua54.lpt:215
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.lpt:217
val = { -- ./compiler/lua54.lpt:218
["tag"] = "Op", -- ./compiler/lua54.lpt:218
destructured["rightOp"], -- ./compiler/lua54.lpt:218
var, -- ./compiler/lua54.lpt:218
{ -- ./compiler/lua54.lpt:218
["tag"] = "Op", -- ./compiler/lua54.lpt:218
destructured["leftOp"], -- ./compiler/lua54.lpt:218
val, -- ./compiler/lua54.lpt:218
var -- ./compiler/lua54.lpt:218
} -- ./compiler/lua54.lpt:218
} -- ./compiler/lua54.lpt:218
elseif destructured["rightOp"] then -- ./compiler/lua54.lpt:219
val = { -- ./compiler/lua54.lpt:220
["tag"] = "Op", -- ./compiler/lua54.lpt:220
destructured["rightOp"], -- ./compiler/lua54.lpt:220
var, -- ./compiler/lua54.lpt:220
val -- ./compiler/lua54.lpt:220
} -- ./compiler/lua54.lpt:220
elseif destructured["leftOp"] then -- ./compiler/lua54.lpt:221
val = { -- ./compiler/lua54.lpt:222
["tag"] = "Op", -- ./compiler/lua54.lpt:222
destructured["leftOp"], -- ./compiler/lua54.lpt:222
val, -- ./compiler/lua54.lpt:222
var -- ./compiler/lua54.lpt:222
} -- ./compiler/lua54.lpt:222
end -- ./compiler/lua54.lpt:222
table["insert"](vars, lua(var)) -- ./compiler/lua54.lpt:224
table["insert"](values, lua(val)) -- ./compiler/lua54.lpt:225
end -- ./compiler/lua54.lpt:225
end -- ./compiler/lua54.lpt:225
if # vars > 0 then -- ./compiler/lua54.lpt:228
local decl = noLocal and "" or "local " -- ./compiler/lua54.lpt:229
if newlineAfter then -- ./compiler/lua54.lpt:230
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.lpt:231
else -- ./compiler/lua54.lpt:231
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.lpt:233
end -- ./compiler/lua54.lpt:233
else -- ./compiler/lua54.lpt:233
return "" -- ./compiler/lua54.lpt:236
end -- ./compiler/lua54.lpt:236
end -- ./compiler/lua54.lpt:236
tags = setmetatable({ -- ./compiler/lua54.lpt:241
["Block"] = function(t) -- ./compiler/lua54.lpt:243
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.lpt:244
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.lpt:245
hasPush["tag"] = "Return" -- ./compiler/lua54.lpt:246
hasPush = false -- ./compiler/lua54.lpt:247
end -- ./compiler/lua54.lpt:247
local r = push("scope", {}) -- ./compiler/lua54.lpt:249
if hasPush then -- ./compiler/lua54.lpt:250
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:251
end -- ./compiler/lua54.lpt:251
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:253
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:254
end -- ./compiler/lua54.lpt:254
if t[# t] then -- ./compiler/lua54.lpt:256
r = r .. (lua(t[# t])) -- ./compiler/lua54.lpt:257
end -- ./compiler/lua54.lpt:257
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:259
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
return r .. pop("scope") -- ./compiler/lua54.lpt:262
end, -- ./compiler/lua54.lpt:262
["Do"] = function(t) -- ./compiler/lua54.lpt:268
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.lpt:269
end, -- ./compiler/lua54.lpt:269
["Set"] = function(t) -- ./compiler/lua54.lpt:272
local expr = t[# t] -- ./compiler/lua54.lpt:274
local vars, values = {}, {} -- ./compiler/lua54.lpt:275
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.lpt:276
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:277
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.lpt:278
table["insert"](destructuringVars, n) -- ./compiler/lua54.lpt:279
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.lpt:280
else -- ./compiler/lua54.lpt:280
table["insert"](vars, n) -- ./compiler/lua54.lpt:282
table["insert"](values, expr[i]) -- ./compiler/lua54.lpt:283
end -- ./compiler/lua54.lpt:283
end -- ./compiler/lua54.lpt:283
if # t == 2 or # t == 3 then -- ./compiler/lua54.lpt:287
local r = "" -- ./compiler/lua54.lpt:288
if # vars > 0 then -- ./compiler/lua54.lpt:289
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.lpt:290
end -- ./compiler/lua54.lpt:290
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:292
local destructured = {} -- ./compiler/lua54.lpt:293
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:294
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:295
end -- ./compiler/lua54.lpt:295
return r -- ./compiler/lua54.lpt:297
elseif # t == 4 then -- ./compiler/lua54.lpt:298
if t[3] == "=" then -- ./compiler/lua54.lpt:299
local r = "" -- ./compiler/lua54.lpt:300
if # vars > 0 then -- ./compiler/lua54.lpt:301
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:302
t[2], -- ./compiler/lua54.lpt:302
vars[1], -- ./compiler/lua54.lpt:302
{ -- ./compiler/lua54.lpt:302
["tag"] = "Paren", -- ./compiler/lua54.lpt:302
values[1] -- ./compiler/lua54.lpt:302
} -- ./compiler/lua54.lpt:302
}, "Op")) -- ./compiler/lua54.lpt:302
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.lpt:303
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:304
t[2], -- ./compiler/lua54.lpt:304
vars[i], -- ./compiler/lua54.lpt:304
{ -- ./compiler/lua54.lpt:304
["tag"] = "Paren", -- ./compiler/lua54.lpt:304
values[i] -- ./compiler/lua54.lpt:304
} -- ./compiler/lua54.lpt:304
}, "Op")) -- ./compiler/lua54.lpt:304
end -- ./compiler/lua54.lpt:304
end -- ./compiler/lua54.lpt:304
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:307
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.lpt:308
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:309
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:310
end -- ./compiler/lua54.lpt:310
return r -- ./compiler/lua54.lpt:312
else -- ./compiler/lua54.lpt:312
local r = "" -- ./compiler/lua54.lpt:314
if # vars > 0 then -- ./compiler/lua54.lpt:315
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:316
t[3], -- ./compiler/lua54.lpt:316
{ -- ./compiler/lua54.lpt:316
["tag"] = "Paren", -- ./compiler/lua54.lpt:316
values[1] -- ./compiler/lua54.lpt:316
}, -- ./compiler/lua54.lpt:316
vars[1] -- ./compiler/lua54.lpt:316
}, "Op")) -- ./compiler/lua54.lpt:316
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.lpt:317
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:318
t[3], -- ./compiler/lua54.lpt:318
{ -- ./compiler/lua54.lpt:318
["tag"] = "Paren", -- ./compiler/lua54.lpt:318
values[i] -- ./compiler/lua54.lpt:318
}, -- ./compiler/lua54.lpt:318
vars[i] -- ./compiler/lua54.lpt:318
}, "Op")) -- ./compiler/lua54.lpt:318
end -- ./compiler/lua54.lpt:318
end -- ./compiler/lua54.lpt:318
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:321
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.lpt:322
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:323
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:324
end -- ./compiler/lua54.lpt:324
return r -- ./compiler/lua54.lpt:326
end -- ./compiler/lua54.lpt:326
else -- ./compiler/lua54.lpt:326
local r = "" -- ./compiler/lua54.lpt:329
if # vars > 0 then -- ./compiler/lua54.lpt:330
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:331
t[2], -- ./compiler/lua54.lpt:331
vars[1], -- ./compiler/lua54.lpt:331
{ -- ./compiler/lua54.lpt:331
["tag"] = "Op", -- ./compiler/lua54.lpt:331
t[4], -- ./compiler/lua54.lpt:331
{ -- ./compiler/lua54.lpt:331
["tag"] = "Paren", -- ./compiler/lua54.lpt:331
values[1] -- ./compiler/lua54.lpt:331
}, -- ./compiler/lua54.lpt:331
vars[1] -- ./compiler/lua54.lpt:331
} -- ./compiler/lua54.lpt:331
}, "Op")) -- ./compiler/lua54.lpt:331
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.lpt:332
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:333
t[2], -- ./compiler/lua54.lpt:333
vars[i], -- ./compiler/lua54.lpt:333
{ -- ./compiler/lua54.lpt:333
["tag"] = "Op", -- ./compiler/lua54.lpt:333
t[4], -- ./compiler/lua54.lpt:333
{ -- ./compiler/lua54.lpt:333
["tag"] = "Paren", -- ./compiler/lua54.lpt:333
values[i] -- ./compiler/lua54.lpt:333
}, -- ./compiler/lua54.lpt:333
vars[i] -- ./compiler/lua54.lpt:333
} -- ./compiler/lua54.lpt:333
}, "Op")) -- ./compiler/lua54.lpt:333
end -- ./compiler/lua54.lpt:333
end -- ./compiler/lua54.lpt:333
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:336
local destructured = { -- ./compiler/lua54.lpt:337
["rightOp"] = t[2], -- ./compiler/lua54.lpt:337
["leftOp"] = t[4] -- ./compiler/lua54.lpt:337
} -- ./compiler/lua54.lpt:337
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:338
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:339
end -- ./compiler/lua54.lpt:339
return r -- ./compiler/lua54.lpt:341
end -- ./compiler/lua54.lpt:341
end, -- ./compiler/lua54.lpt:341
["While"] = function(t) -- ./compiler/lua54.lpt:345
local r = "" -- ./compiler/lua54.lpt:346
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.lpt:347
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:348
if # lets > 0 then -- ./compiler/lua54.lpt:349
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:350
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:351
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:352
end -- ./compiler/lua54.lpt:352
end -- ./compiler/lua54.lpt:352
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.lpt:355
if # lets > 0 then -- ./compiler/lua54.lpt:356
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:357
end -- ./compiler/lua54.lpt:357
if hasContinue then -- ./compiler/lua54.lpt:359
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:360
end -- ./compiler/lua54.lpt:360
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:362
if hasContinue then -- ./compiler/lua54.lpt:363
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:364
end -- ./compiler/lua54.lpt:364
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:366
if # lets > 0 then -- ./compiler/lua54.lpt:367
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:368
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.lpt:369
end -- ./compiler/lua54.lpt:369
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.lpt:371
end -- ./compiler/lua54.lpt:371
return r -- ./compiler/lua54.lpt:373
end, -- ./compiler/lua54.lpt:373
["Repeat"] = function(t) -- ./compiler/lua54.lpt:376
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.lpt:377
local r = "repeat" .. indent() -- ./compiler/lua54.lpt:378
if hasContinue then -- ./compiler/lua54.lpt:379
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:380
end -- ./compiler/lua54.lpt:380
r = r .. (lua(t[1])) -- ./compiler/lua54.lpt:382
if hasContinue then -- ./compiler/lua54.lpt:383
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:384
end -- ./compiler/lua54.lpt:384
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.lpt:386
return r -- ./compiler/lua54.lpt:387
end, -- ./compiler/lua54.lpt:387
["If"] = function(t) -- ./compiler/lua54.lpt:390
local r = "" -- ./compiler/lua54.lpt:391
local toClose = 0 -- ./compiler/lua54.lpt:392
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:393
if # lets > 0 then -- ./compiler/lua54.lpt:394
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:395
toClose = toClose + (1) -- ./compiler/lua54.lpt:396
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:397
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:398
end -- ./compiler/lua54.lpt:398
end -- ./compiler/lua54.lpt:398
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.lpt:401
for i = 3, # t - 1, 2 do -- ./compiler/lua54.lpt:402
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.lpt:403
if # lets > 0 then -- ./compiler/lua54.lpt:404
r = r .. ("else" .. indent()) -- ./compiler/lua54.lpt:405
toClose = toClose + (1) -- ./compiler/lua54.lpt:406
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:407
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:408
end -- ./compiler/lua54.lpt:408
else -- ./compiler/lua54.lpt:408
r = r .. ("else") -- ./compiler/lua54.lpt:411
end -- ./compiler/lua54.lpt:411
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.lpt:413
end -- ./compiler/lua54.lpt:413
if # t % 2 == 1 then -- ./compiler/lua54.lpt:415
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.lpt:416
end -- ./compiler/lua54.lpt:416
r = r .. ("end") -- ./compiler/lua54.lpt:418
for i = 1, toClose do -- ./compiler/lua54.lpt:419
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:420
end -- ./compiler/lua54.lpt:420
return r -- ./compiler/lua54.lpt:422
end, -- ./compiler/lua54.lpt:422
["Fornum"] = function(t) -- ./compiler/lua54.lpt:425
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.lpt:426
if # t == 5 then -- ./compiler/lua54.lpt:427
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.lpt:428
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.lpt:429
if hasContinue then -- ./compiler/lua54.lpt:430
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:431
end -- ./compiler/lua54.lpt:431
r = r .. (lua(t[5])) -- ./compiler/lua54.lpt:433
if hasContinue then -- ./compiler/lua54.lpt:434
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:435
end -- ./compiler/lua54.lpt:435
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:437
else -- ./compiler/lua54.lpt:437
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.lpt:439
r = r .. (" do" .. indent()) -- ./compiler/lua54.lpt:440
if hasContinue then -- ./compiler/lua54.lpt:441
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:442
end -- ./compiler/lua54.lpt:442
r = r .. (lua(t[4])) -- ./compiler/lua54.lpt:444
if hasContinue then -- ./compiler/lua54.lpt:445
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:446
end -- ./compiler/lua54.lpt:446
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:448
end -- ./compiler/lua54.lpt:448
end, -- ./compiler/lua54.lpt:448
["Forin"] = function(t) -- ./compiler/lua54.lpt:452
local destructured = {} -- ./compiler/lua54.lpt:453
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.lpt:454
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.lpt:455
if hasContinue then -- ./compiler/lua54.lpt:456
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:457
end -- ./compiler/lua54.lpt:457
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.lpt:459
if hasContinue then -- ./compiler/lua54.lpt:460
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:461
end -- ./compiler/lua54.lpt:461
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:463
end, -- ./compiler/lua54.lpt:463
["Local"] = function(t) -- ./compiler/lua54.lpt:466
local destructured = {} -- ./compiler/lua54.lpt:467
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:468
if t[2][1] then -- ./compiler/lua54.lpt:469
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:470
end -- ./compiler/lua54.lpt:470
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:472
end, -- ./compiler/lua54.lpt:472
["Let"] = function(t) -- ./compiler/lua54.lpt:475
local destructured = {} -- ./compiler/lua54.lpt:476
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:477
local r = "local " .. nameList -- ./compiler/lua54.lpt:478
if t[2][1] then -- ./compiler/lua54.lpt:479
if all(t[2], { -- ./compiler/lua54.lpt:480
"Nil", -- ./compiler/lua54.lpt:480
"Dots", -- ./compiler/lua54.lpt:480
"Boolean", -- ./compiler/lua54.lpt:480
"Number", -- ./compiler/lua54.lpt:480
"String" -- ./compiler/lua54.lpt:480
}) then -- ./compiler/lua54.lpt:480
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:481
else -- ./compiler/lua54.lpt:481
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:483
end -- ./compiler/lua54.lpt:483
end -- ./compiler/lua54.lpt:483
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:486
end, -- ./compiler/lua54.lpt:486
["Localrec"] = function(t) -- ./compiler/lua54.lpt:489
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.lpt:490
end, -- ./compiler/lua54.lpt:490
["Goto"] = function(t) -- ./compiler/lua54.lpt:493
return "goto " .. lua(t, "Id") -- ./compiler/lua54.lpt:494
end, -- ./compiler/lua54.lpt:494
["Label"] = function(t) -- ./compiler/lua54.lpt:497
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.lpt:498
end, -- ./compiler/lua54.lpt:498
["Return"] = function(t) -- ./compiler/lua54.lpt:501
local push = peek("push") -- ./compiler/lua54.lpt:502
if push then -- ./compiler/lua54.lpt:503
local r = "" -- ./compiler/lua54.lpt:504
for _, val in ipairs(t) do -- ./compiler/lua54.lpt:505
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.lpt:506
end -- ./compiler/lua54.lpt:506
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.lpt:508
else -- ./compiler/lua54.lpt:508
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.lpt:510
end -- ./compiler/lua54.lpt:510
end, -- ./compiler/lua54.lpt:510
["Push"] = function(t) -- ./compiler/lua54.lpt:514
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.lpt:515
r = "" -- ./compiler/lua54.lpt:516
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:517
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:518
end -- ./compiler/lua54.lpt:518
if t[# t] then -- ./compiler/lua54.lpt:520
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.lpt:521
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.lpt:522
else -- ./compiler/lua54.lpt:522
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
return r -- ./compiler/lua54.lpt:527
end, -- ./compiler/lua54.lpt:527
["Break"] = function() -- ./compiler/lua54.lpt:530
return "break" -- ./compiler/lua54.lpt:531
end, -- ./compiler/lua54.lpt:531
["Continue"] = function() -- ./compiler/lua54.lpt:534
return "goto " .. var("continue") -- ./compiler/lua54.lpt:535
end, -- ./compiler/lua54.lpt:535
["Nil"] = function() -- ./compiler/lua54.lpt:542
return "nil" -- ./compiler/lua54.lpt:543
end, -- ./compiler/lua54.lpt:543
["Dots"] = function() -- ./compiler/lua54.lpt:546
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:547
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.lpt:548
nomacro["variables"]["..."] = true -- ./compiler/lua54.lpt:549
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.lpt:550
nomacro["variables"]["..."] = nil -- ./compiler/lua54.lpt:551
return r -- ./compiler/lua54.lpt:552
else -- ./compiler/lua54.lpt:552
return "..." -- ./compiler/lua54.lpt:554
end -- ./compiler/lua54.lpt:554
end, -- ./compiler/lua54.lpt:554
["Boolean"] = function(t) -- ./compiler/lua54.lpt:558
return tostring(t[1]) -- ./compiler/lua54.lpt:559
end, -- ./compiler/lua54.lpt:559
["Number"] = function(t) -- ./compiler/lua54.lpt:562
return tostring(t[1]) -- ./compiler/lua54.lpt:563
end, -- ./compiler/lua54.lpt:563
["String"] = function(t) -- ./compiler/lua54.lpt:566
return ("%q"):format(t[1]) -- ./compiler/lua54.lpt:567
end, -- ./compiler/lua54.lpt:567
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.lpt:570
local r = "(" -- ./compiler/lua54.lpt:571
local decl = {} -- ./compiler/lua54.lpt:572
if t[1][1] then -- ./compiler/lua54.lpt:573
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:574
local id = lua(t[1][1][1]) -- ./compiler/lua54.lpt:575
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:576
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.lpt:577
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:578
r = r .. (id) -- ./compiler/lua54.lpt:579
else -- ./compiler/lua54.lpt:579
r = r .. (lua(t[1][1])) -- ./compiler/lua54.lpt:581
end -- ./compiler/lua54.lpt:581
for i = 2, # t[1], 1 do -- ./compiler/lua54.lpt:583
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:584
local id = lua(t[1][i][1]) -- ./compiler/lua54.lpt:585
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:586
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.lpt:587
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:588
r = r .. (", " .. id) -- ./compiler/lua54.lpt:589
else -- ./compiler/lua54.lpt:589
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
r = r .. (")" .. indent()) -- ./compiler/lua54.lpt:595
for _, d in ipairs(decl) do -- ./compiler/lua54.lpt:596
r = r .. (d .. newline()) -- ./compiler/lua54.lpt:597
end -- ./compiler/lua54.lpt:597
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.lpt:599
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.lpt:600
end -- ./compiler/lua54.lpt:600
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.lpt:602
if hasPush then -- ./compiler/lua54.lpt:603
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:604
else -- ./compiler/lua54.lpt:604
push("push", false) -- ./compiler/lua54.lpt:606
end -- ./compiler/lua54.lpt:606
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:608
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:609
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:610
end -- ./compiler/lua54.lpt:610
pop("push") -- ./compiler/lua54.lpt:612
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:613
end, -- ./compiler/lua54.lpt:613
["Function"] = function(t) -- ./compiler/lua54.lpt:615
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.lpt:616
end, -- ./compiler/lua54.lpt:616
["Pair"] = function(t) -- ./compiler/lua54.lpt:619
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.lpt:620
end, -- ./compiler/lua54.lpt:620
["Table"] = function(t) -- ./compiler/lua54.lpt:622
if # t == 0 then -- ./compiler/lua54.lpt:623
return "{}" -- ./compiler/lua54.lpt:624
elseif # t == 1 then -- ./compiler/lua54.lpt:625
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.lpt:626
else -- ./compiler/lua54.lpt:626
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.lpt:628
end -- ./compiler/lua54.lpt:628
end, -- ./compiler/lua54.lpt:628
["TableCompr"] = function(t) -- ./compiler/lua54.lpt:632
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.lpt:633
end, -- ./compiler/lua54.lpt:633
["Op"] = function(t) -- ./compiler/lua54.lpt:636
local r -- ./compiler/lua54.lpt:637
if # t == 2 then -- ./compiler/lua54.lpt:638
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:639
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.lpt:640
else -- ./compiler/lua54.lpt:640
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.lpt:642
end -- ./compiler/lua54.lpt:642
else -- ./compiler/lua54.lpt:642
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:645
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.lpt:646
else -- ./compiler/lua54.lpt:646
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.lpt:648
end -- ./compiler/lua54.lpt:648
end -- ./compiler/lua54.lpt:648
return r -- ./compiler/lua54.lpt:651
end, -- ./compiler/lua54.lpt:651
["Paren"] = function(t) -- ./compiler/lua54.lpt:654
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.lpt:655
end, -- ./compiler/lua54.lpt:655
["MethodStub"] = function(t) -- ./compiler/lua54.lpt:658
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:664
end, -- ./compiler/lua54.lpt:664
["SafeMethodStub"] = function(t) -- ./compiler/lua54.lpt:667
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:674
end, -- ./compiler/lua54.lpt:674
["LetExpr"] = function(t) -- ./compiler/lua54.lpt:681
return lua(t[1][1]) -- ./compiler/lua54.lpt:682
end, -- ./compiler/lua54.lpt:682
["_statexpr"] = function(t, stat) -- ./compiler/lua54.lpt:686
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.lpt:687
local r = "(function()" .. indent() -- ./compiler/lua54.lpt:688
if hasPush then -- ./compiler/lua54.lpt:689
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:690
else -- ./compiler/lua54.lpt:690
push("push", false) -- ./compiler/lua54.lpt:692
end -- ./compiler/lua54.lpt:692
r = r .. (lua(t, stat)) -- ./compiler/lua54.lpt:694
if hasPush then -- ./compiler/lua54.lpt:695
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:696
end -- ./compiler/lua54.lpt:696
pop("push") -- ./compiler/lua54.lpt:698
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.lpt:699
return r -- ./compiler/lua54.lpt:700
end, -- ./compiler/lua54.lpt:700
["DoExpr"] = function(t) -- ./compiler/lua54.lpt:703
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.lpt:704
t[# t]["tag"] = "Return" -- ./compiler/lua54.lpt:705
end -- ./compiler/lua54.lpt:705
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.lpt:707
end, -- ./compiler/lua54.lpt:707
["WhileExpr"] = function(t) -- ./compiler/lua54.lpt:710
return lua(t, "_statexpr", "While") -- ./compiler/lua54.lpt:711
end, -- ./compiler/lua54.lpt:711
["RepeatExpr"] = function(t) -- ./compiler/lua54.lpt:714
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.lpt:715
end, -- ./compiler/lua54.lpt:715
["IfExpr"] = function(t) -- ./compiler/lua54.lpt:718
for i = 2, # t do -- ./compiler/lua54.lpt:719
local block = t[i] -- ./compiler/lua54.lpt:720
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.lpt:721
block[# block]["tag"] = "Return" -- ./compiler/lua54.lpt:722
end -- ./compiler/lua54.lpt:722
end -- ./compiler/lua54.lpt:722
return lua(t, "_statexpr", "If") -- ./compiler/lua54.lpt:725
end, -- ./compiler/lua54.lpt:725
["FornumExpr"] = function(t) -- ./compiler/lua54.lpt:728
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.lpt:729
end, -- ./compiler/lua54.lpt:729
["ForinExpr"] = function(t) -- ./compiler/lua54.lpt:732
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.lpt:733
end, -- ./compiler/lua54.lpt:733
["Call"] = function(t) -- ./compiler/lua54.lpt:739
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:740
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:741
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.lpt:742
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.lpt:743
local replacement = macro["replacement"] -- ./compiler/lua54.lpt:744
local r -- ./compiler/lua54.lpt:745
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.lpt:746
if type(replacement) == "function" then -- ./compiler/lua54.lpt:747
local args = {} -- ./compiler/lua54.lpt:748
for i = 2, # t do -- ./compiler/lua54.lpt:749
table["insert"](args, lua(t[i])) -- ./compiler/lua54.lpt:750
end -- ./compiler/lua54.lpt:750
r = replacement(unpack(args)) -- ./compiler/lua54.lpt:752
else -- ./compiler/lua54.lpt:752
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.lpt:754
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.lpt:755
if arg["tag"] == "Dots" then -- ./compiler/lua54.lpt:756
macroargs["..."] = (function() -- ./compiler/lua54.lpt:757
local self = {} -- ./compiler/lua54.lpt:757
for j = i + 1, # t do -- ./compiler/lua54.lpt:757
self[#self+1] = t[j] -- ./compiler/lua54.lpt:757
end -- ./compiler/lua54.lpt:757
return self -- ./compiler/lua54.lpt:757
end)() -- ./compiler/lua54.lpt:757
elseif arg["tag"] == "Id" then -- ./compiler/lua54.lpt:758
if t[i + 1] == nil then -- ./compiler/lua54.lpt:759
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.lpt:760
end -- ./compiler/lua54.lpt:760
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.lpt:762
else -- ./compiler/lua54.lpt:762
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.lpt:764
end -- ./compiler/lua54.lpt:764
end -- ./compiler/lua54.lpt:764
push("macroargs", macroargs) -- ./compiler/lua54.lpt:767
r = lua(replacement) -- ./compiler/lua54.lpt:768
pop("macroargs") -- ./compiler/lua54.lpt:769
end -- ./compiler/lua54.lpt:769
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.lpt:771
return r -- ./compiler/lua54.lpt:772
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.lpt:773
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.lpt:774
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:775
else -- ./compiler/lua54.lpt:775
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:777
end -- ./compiler/lua54.lpt:777
else -- ./compiler/lua54.lpt:777
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:780
end -- ./compiler/lua54.lpt:780
end, -- ./compiler/lua54.lpt:780
["SafeCall"] = function(t) -- ./compiler/lua54.lpt:784
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:785
return lua(t, "SafeIndex") -- ./compiler/lua54.lpt:786
else -- ./compiler/lua54.lpt:786
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.lpt:788
end -- ./compiler/lua54.lpt:788
end, -- ./compiler/lua54.lpt:788
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.lpt:793
if start == nil then start = 1 end -- ./compiler/lua54.lpt:793
local r -- ./compiler/lua54.lpt:794
if t[start] then -- ./compiler/lua54.lpt:795
r = lua(t[start]) -- ./compiler/lua54.lpt:796
for i = start + 1, # t, 1 do -- ./compiler/lua54.lpt:797
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.lpt:798
end -- ./compiler/lua54.lpt:798
else -- ./compiler/lua54.lpt:798
r = "" -- ./compiler/lua54.lpt:801
end -- ./compiler/lua54.lpt:801
return r -- ./compiler/lua54.lpt:803
end, -- ./compiler/lua54.lpt:803
["Id"] = function(t) -- ./compiler/lua54.lpt:806
local r = t[1] -- ./compiler/lua54.lpt:807
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:808
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.lpt:809
nomacro["variables"][t[1]] = true -- ./compiler/lua54.lpt:810
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.lpt:811
r = lua(macroargs[t[1]]) -- ./compiler/lua54.lpt:812
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.lpt:813
local macro = macros["variables"][t[1]] -- ./compiler/lua54.lpt:814
if type(macro) == "function" then -- ./compiler/lua54.lpt:815
r = macro() -- ./compiler/lua54.lpt:816
else -- ./compiler/lua54.lpt:816
r = lua(macro) -- ./compiler/lua54.lpt:818
end -- ./compiler/lua54.lpt:818
end -- ./compiler/lua54.lpt:818
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.lpt:821
end -- ./compiler/lua54.lpt:821
return r -- ./compiler/lua54.lpt:823
end, -- ./compiler/lua54.lpt:823
["AttributeId"] = function(t) -- ./compiler/lua54.lpt:826
if t[2] then -- ./compiler/lua54.lpt:827
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.lpt:828
else -- ./compiler/lua54.lpt:828
return t[1] -- ./compiler/lua54.lpt:830
end -- ./compiler/lua54.lpt:830
end, -- ./compiler/lua54.lpt:830
["DestructuringId"] = function(t) -- ./compiler/lua54.lpt:834
if t["id"] then -- ./compiler/lua54.lpt:835
return t["id"] -- ./compiler/lua54.lpt:836
else -- ./compiler/lua54.lpt:836
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.lpt:838
local vars = { ["id"] = tmp() } -- ./compiler/lua54.lpt:839
for j = 1, # t, 1 do -- ./compiler/lua54.lpt:840
table["insert"](vars, t[j]) -- ./compiler/lua54.lpt:841
end -- ./compiler/lua54.lpt:841
table["insert"](d, vars) -- ./compiler/lua54.lpt:843
t["id"] = vars["id"] -- ./compiler/lua54.lpt:844
return vars["id"] -- ./compiler/lua54.lpt:845
end -- ./compiler/lua54.lpt:845
end, -- ./compiler/lua54.lpt:845
["Index"] = function(t) -- ./compiler/lua54.lpt:849
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:850
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:851
else -- ./compiler/lua54.lpt:851
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:853
end -- ./compiler/lua54.lpt:853
end, -- ./compiler/lua54.lpt:853
["SafeIndex"] = function(t) -- ./compiler/lua54.lpt:857
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:858
local l = {} -- ./compiler/lua54.lpt:859
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.lpt:860
table["insert"](l, 1, t) -- ./compiler/lua54.lpt:861
t = t[1] -- ./compiler/lua54.lpt:862
end -- ./compiler/lua54.lpt:862
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.lpt:864
for _, e in ipairs(l) do -- ./compiler/lua54.lpt:865
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.lpt:866
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.lpt:867
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.lpt:868
else -- ./compiler/lua54.lpt:868
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.lpt:870
end -- ./compiler/lua54.lpt:870
end -- ./compiler/lua54.lpt:870
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.lpt:873
return r -- ./compiler/lua54.lpt:874
else -- ./compiler/lua54.lpt:874
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.lpt:876
end -- ./compiler/lua54.lpt:876
end, -- ./compiler/lua54.lpt:876
["_opid"] = { -- ./compiler/lua54.lpt:881
["add"] = "+", -- ./compiler/lua54.lpt:882
["sub"] = "-", -- ./compiler/lua54.lpt:882
["mul"] = "*", -- ./compiler/lua54.lpt:882
["div"] = "/", -- ./compiler/lua54.lpt:882
["idiv"] = "//", -- ./compiler/lua54.lpt:883
["mod"] = "%", -- ./compiler/lua54.lpt:883
["pow"] = "^", -- ./compiler/lua54.lpt:883
["concat"] = "..", -- ./compiler/lua54.lpt:883
["band"] = "&", -- ./compiler/lua54.lpt:884
["bor"] = "|", -- ./compiler/lua54.lpt:884
["bxor"] = "~", -- ./compiler/lua54.lpt:884
["shl"] = "<<", -- ./compiler/lua54.lpt:884
["shr"] = ">>", -- ./compiler/lua54.lpt:884
["eq"] = "==", -- ./compiler/lua54.lpt:885
["ne"] = "~=", -- ./compiler/lua54.lpt:885
["lt"] = "<", -- ./compiler/lua54.lpt:885
["gt"] = ">", -- ./compiler/lua54.lpt:885
["le"] = "<=", -- ./compiler/lua54.lpt:885
["ge"] = ">=", -- ./compiler/lua54.lpt:885
["and"] = "and", -- ./compiler/lua54.lpt:886
["or"] = "or", -- ./compiler/lua54.lpt:886
["unm"] = "-", -- ./compiler/lua54.lpt:886
["len"] = "#", -- ./compiler/lua54.lpt:886
["bnot"] = "~", -- ./compiler/lua54.lpt:886
["not"] = "not" -- ./compiler/lua54.lpt:886
} -- ./compiler/lua54.lpt:886
}, { ["__index"] = function(self, key) -- ./compiler/lua54.lpt:889
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.lpt:890
end }) -- ./compiler/lua54.lpt:890
local code = lua(ast) .. newline() -- ./compiler/lua54.lpt:896
return requireStr .. code -- ./compiler/lua54.lpt:897
end -- ./compiler/lua54.lpt:897
end -- ./compiler/lua54.lpt:897
local lua54 = _() or lua54 -- ./compiler/lua54.lpt:902
package["loaded"]["compiler.lua54"] = lua54 or true -- ./compiler/lua54.lpt:903
local function _() -- ./compiler/lua54.lpt:906
local function _() -- ./compiler/lua54.lpt:908
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
local indentLevel = 0 -- ./compiler/lua54.lpt:15
local function newline() -- ./compiler/lua54.lpt:17
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.lpt:18
if options["mapLines"] then -- ./compiler/lua54.lpt:19
local sub = code:sub(lastInputPos) -- ./compiler/lua54.lpt:20
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.lpt:21
if source and line then -- ./compiler/lua54.lpt:23
lastSource = source -- ./compiler/lua54.lpt:24
lastLine = tonumber(line) -- ./compiler/lua54.lpt:25
else -- ./compiler/lua54.lpt:25
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.lpt:27
lastLine = lastLine + (1) -- ./compiler/lua54.lpt:28
end -- ./compiler/lua54.lpt:28
end -- ./compiler/lua54.lpt:28
prevLinePos = lastInputPos -- ./compiler/lua54.lpt:32
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.lpt:34
end -- ./compiler/lua54.lpt:34
return r -- ./compiler/lua54.lpt:36
end -- ./compiler/lua54.lpt:36
local function indent() -- ./compiler/lua54.lpt:39
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:40
return newline() -- ./compiler/lua54.lpt:41
end -- ./compiler/lua54.lpt:41
local function unindent() -- ./compiler/lua54.lpt:44
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:45
return newline() -- ./compiler/lua54.lpt:46
end -- ./compiler/lua54.lpt:46
local states = { -- ./compiler/lua54.lpt:51
["push"] = {}, -- ./compiler/lua54.lpt:52
["destructuring"] = {}, -- ./compiler/lua54.lpt:53
["scope"] = {}, -- ./compiler/lua54.lpt:54
["macroargs"] = {} -- ./compiler/lua54.lpt:55
} -- ./compiler/lua54.lpt:55
local function push(name, state) -- ./compiler/lua54.lpt:58
table["insert"](states[name], state) -- ./compiler/lua54.lpt:59
return "" -- ./compiler/lua54.lpt:60
end -- ./compiler/lua54.lpt:60
local function pop(name) -- ./compiler/lua54.lpt:63
table["remove"](states[name]) -- ./compiler/lua54.lpt:64
return "" -- ./compiler/lua54.lpt:65
end -- ./compiler/lua54.lpt:65
local function set(name, state) -- ./compiler/lua54.lpt:68
states[name][# states[name]] = state -- ./compiler/lua54.lpt:69
return "" -- ./compiler/lua54.lpt:70
end -- ./compiler/lua54.lpt:70
local function peek(name) -- ./compiler/lua54.lpt:73
return states[name][# states[name]] -- ./compiler/lua54.lpt:74
end -- ./compiler/lua54.lpt:74
local function var(name) -- ./compiler/lua54.lpt:79
return options["variablePrefix"] .. name -- ./compiler/lua54.lpt:80
end -- ./compiler/lua54.lpt:80
local function tmp() -- ./compiler/lua54.lpt:84
local scope = peek("scope") -- ./compiler/lua54.lpt:85
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.lpt:86
table["insert"](scope, var) -- ./compiler/lua54.lpt:87
return var -- ./compiler/lua54.lpt:88
end -- ./compiler/lua54.lpt:88
local nomacro = { -- ./compiler/lua54.lpt:92
["variables"] = {}, -- ./compiler/lua54.lpt:92
["functions"] = {} -- ./compiler/lua54.lpt:92
} -- ./compiler/lua54.lpt:92
local required = {} -- ./compiler/lua54.lpt:95
local requireStr = "" -- ./compiler/lua54.lpt:96
local function addRequire(mod, name, field) -- ./compiler/lua54.lpt:98
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.lpt:99
if not required[req] then -- ./compiler/lua54.lpt:100
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.lpt:101
required[req] = true -- ./compiler/lua54.lpt:102
end -- ./compiler/lua54.lpt:102
end -- ./compiler/lua54.lpt:102
local loop = { -- ./compiler/lua54.lpt:107
"While", -- ./compiler/lua54.lpt:107
"Repeat", -- ./compiler/lua54.lpt:107
"Fornum", -- ./compiler/lua54.lpt:107
"Forin", -- ./compiler/lua54.lpt:107
"WhileExpr", -- ./compiler/lua54.lpt:107
"RepeatExpr", -- ./compiler/lua54.lpt:107
"FornumExpr", -- ./compiler/lua54.lpt:107
"ForinExpr" -- ./compiler/lua54.lpt:107
} -- ./compiler/lua54.lpt:107
local func = { -- ./compiler/lua54.lpt:108
"Function", -- ./compiler/lua54.lpt:108
"TableCompr", -- ./compiler/lua54.lpt:108
"DoExpr", -- ./compiler/lua54.lpt:108
"WhileExpr", -- ./compiler/lua54.lpt:108
"RepeatExpr", -- ./compiler/lua54.lpt:108
"IfExpr", -- ./compiler/lua54.lpt:108
"FornumExpr", -- ./compiler/lua54.lpt:108
"ForinExpr" -- ./compiler/lua54.lpt:108
} -- ./compiler/lua54.lpt:108
local function any(list, tags, nofollow) -- ./compiler/lua54.lpt:112
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:112
local tagsCheck = {} -- ./compiler/lua54.lpt:113
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:114
tagsCheck[tag] = true -- ./compiler/lua54.lpt:115
end -- ./compiler/lua54.lpt:115
local nofollowCheck = {} -- ./compiler/lua54.lpt:117
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:118
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:119
end -- ./compiler/lua54.lpt:119
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:121
if type(node) == "table" then -- ./compiler/lua54.lpt:122
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:123
return node -- ./compiler/lua54.lpt:124
end -- ./compiler/lua54.lpt:124
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:126
local r = any(node, tags, nofollow) -- ./compiler/lua54.lpt:127
if r then -- ./compiler/lua54.lpt:128
return r -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
return nil -- ./compiler/lua54.lpt:132
end -- ./compiler/lua54.lpt:132
local function search(list, tags, nofollow) -- ./compiler/lua54.lpt:137
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:137
local tagsCheck = {} -- ./compiler/lua54.lpt:138
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:139
tagsCheck[tag] = true -- ./compiler/lua54.lpt:140
end -- ./compiler/lua54.lpt:140
local nofollowCheck = {} -- ./compiler/lua54.lpt:142
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:143
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:144
end -- ./compiler/lua54.lpt:144
local found = {} -- ./compiler/lua54.lpt:146
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:147
if type(node) == "table" then -- ./compiler/lua54.lpt:148
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:149
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.lpt:150
table["insert"](found, n) -- ./compiler/lua54.lpt:151
end -- ./compiler/lua54.lpt:151
end -- ./compiler/lua54.lpt:151
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:154
table["insert"](found, node) -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
return found -- ./compiler/lua54.lpt:159
end -- ./compiler/lua54.lpt:159
local function all(list, tags) -- ./compiler/lua54.lpt:163
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:164
local ok = false -- ./compiler/lua54.lpt:165
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:166
if node["tag"] == tag then -- ./compiler/lua54.lpt:167
ok = true -- ./compiler/lua54.lpt:168
break -- ./compiler/lua54.lpt:169
end -- ./compiler/lua54.lpt:169
end -- ./compiler/lua54.lpt:169
if not ok then -- ./compiler/lua54.lpt:172
return false -- ./compiler/lua54.lpt:173
end -- ./compiler/lua54.lpt:173
end -- ./compiler/lua54.lpt:173
return true -- ./compiler/lua54.lpt:176
end -- ./compiler/lua54.lpt:176
local tags -- ./compiler/lua54.lpt:180
local function lua(ast, forceTag, ...) -- ./compiler/lua54.lpt:182
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.lpt:183
lastInputPos = ast["pos"] -- ./compiler/lua54.lpt:184
end -- ./compiler/lua54.lpt:184
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.lpt:186
end -- ./compiler/lua54.lpt:186
local UNPACK = function(list, i, j) -- ./compiler/lua54.lpt:190
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.lpt:191
end -- ./compiler/lua54.lpt:191
local APPEND = function(t, toAppend) -- ./compiler/lua54.lpt:193
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.lpt:194
end -- ./compiler/lua54.lpt:194
local CONTINUE_START = function() -- ./compiler/lua54.lpt:196
return "do" .. indent() -- ./compiler/lua54.lpt:197
end -- ./compiler/lua54.lpt:197
local CONTINUE_STOP = function() -- ./compiler/lua54.lpt:199
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.lpt:200
end -- ./compiler/lua54.lpt:200
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.lpt:202
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.lpt:202
if noLocal == nil then noLocal = false end -- ./compiler/lua54.lpt:202
local vars = {} -- ./compiler/lua54.lpt:203
local values = {} -- ./compiler/lua54.lpt:204
for _, list in ipairs(destructured) do -- ./compiler/lua54.lpt:205
for _, v in ipairs(list) do -- ./compiler/lua54.lpt:206
local var, val -- ./compiler/lua54.lpt:207
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.lpt:208
var = v -- ./compiler/lua54.lpt:209
val = { -- ./compiler/lua54.lpt:210
["tag"] = "Index", -- ./compiler/lua54.lpt:210
{ -- ./compiler/lua54.lpt:210
["tag"] = "Id", -- ./compiler/lua54.lpt:210
list["id"] -- ./compiler/lua54.lpt:210
}, -- ./compiler/lua54.lpt:210
{ -- ./compiler/lua54.lpt:210
["tag"] = "String", -- ./compiler/lua54.lpt:210
v[1] -- ./compiler/lua54.lpt:210
} -- ./compiler/lua54.lpt:210
} -- ./compiler/lua54.lpt:210
elseif v["tag"] == "Pair" then -- ./compiler/lua54.lpt:211
var = v[2] -- ./compiler/lua54.lpt:212
val = { -- ./compiler/lua54.lpt:213
["tag"] = "Index", -- ./compiler/lua54.lpt:213
{ -- ./compiler/lua54.lpt:213
["tag"] = "Id", -- ./compiler/lua54.lpt:213
list["id"] -- ./compiler/lua54.lpt:213
}, -- ./compiler/lua54.lpt:213
v[1] -- ./compiler/lua54.lpt:213
} -- ./compiler/lua54.lpt:213
else -- ./compiler/lua54.lpt:213
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.lpt:215
end -- ./compiler/lua54.lpt:215
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.lpt:217
val = { -- ./compiler/lua54.lpt:218
["tag"] = "Op", -- ./compiler/lua54.lpt:218
destructured["rightOp"], -- ./compiler/lua54.lpt:218
var, -- ./compiler/lua54.lpt:218
{ -- ./compiler/lua54.lpt:218
["tag"] = "Op", -- ./compiler/lua54.lpt:218
destructured["leftOp"], -- ./compiler/lua54.lpt:218
val, -- ./compiler/lua54.lpt:218
var -- ./compiler/lua54.lpt:218
} -- ./compiler/lua54.lpt:218
} -- ./compiler/lua54.lpt:218
elseif destructured["rightOp"] then -- ./compiler/lua54.lpt:219
val = { -- ./compiler/lua54.lpt:220
["tag"] = "Op", -- ./compiler/lua54.lpt:220
destructured["rightOp"], -- ./compiler/lua54.lpt:220
var, -- ./compiler/lua54.lpt:220
val -- ./compiler/lua54.lpt:220
} -- ./compiler/lua54.lpt:220
elseif destructured["leftOp"] then -- ./compiler/lua54.lpt:221
val = { -- ./compiler/lua54.lpt:222
["tag"] = "Op", -- ./compiler/lua54.lpt:222
destructured["leftOp"], -- ./compiler/lua54.lpt:222
val, -- ./compiler/lua54.lpt:222
var -- ./compiler/lua54.lpt:222
} -- ./compiler/lua54.lpt:222
end -- ./compiler/lua54.lpt:222
table["insert"](vars, lua(var)) -- ./compiler/lua54.lpt:224
table["insert"](values, lua(val)) -- ./compiler/lua54.lpt:225
end -- ./compiler/lua54.lpt:225
end -- ./compiler/lua54.lpt:225
if # vars > 0 then -- ./compiler/lua54.lpt:228
local decl = noLocal and "" or "local " -- ./compiler/lua54.lpt:229
if newlineAfter then -- ./compiler/lua54.lpt:230
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.lpt:231
else -- ./compiler/lua54.lpt:231
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.lpt:233
end -- ./compiler/lua54.lpt:233
else -- ./compiler/lua54.lpt:233
return "" -- ./compiler/lua54.lpt:236
end -- ./compiler/lua54.lpt:236
end -- ./compiler/lua54.lpt:236
tags = setmetatable({ -- ./compiler/lua54.lpt:241
["Block"] = function(t) -- ./compiler/lua54.lpt:243
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.lpt:244
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.lpt:245
hasPush["tag"] = "Return" -- ./compiler/lua54.lpt:246
hasPush = false -- ./compiler/lua54.lpt:247
end -- ./compiler/lua54.lpt:247
local r = push("scope", {}) -- ./compiler/lua54.lpt:249
if hasPush then -- ./compiler/lua54.lpt:250
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:251
end -- ./compiler/lua54.lpt:251
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:253
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:254
end -- ./compiler/lua54.lpt:254
if t[# t] then -- ./compiler/lua54.lpt:256
r = r .. (lua(t[# t])) -- ./compiler/lua54.lpt:257
end -- ./compiler/lua54.lpt:257
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:259
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
return r .. pop("scope") -- ./compiler/lua54.lpt:262
end, -- ./compiler/lua54.lpt:262
["Do"] = function(t) -- ./compiler/lua54.lpt:268
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.lpt:269
end, -- ./compiler/lua54.lpt:269
["Set"] = function(t) -- ./compiler/lua54.lpt:272
local expr = t[# t] -- ./compiler/lua54.lpt:274
local vars, values = {}, {} -- ./compiler/lua54.lpt:275
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.lpt:276
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:277
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.lpt:278
table["insert"](destructuringVars, n) -- ./compiler/lua54.lpt:279
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.lpt:280
else -- ./compiler/lua54.lpt:280
table["insert"](vars, n) -- ./compiler/lua54.lpt:282
table["insert"](values, expr[i]) -- ./compiler/lua54.lpt:283
end -- ./compiler/lua54.lpt:283
end -- ./compiler/lua54.lpt:283
if # t == 2 or # t == 3 then -- ./compiler/lua54.lpt:287
local r = "" -- ./compiler/lua54.lpt:288
if # vars > 0 then -- ./compiler/lua54.lpt:289
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.lpt:290
end -- ./compiler/lua54.lpt:290
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:292
local destructured = {} -- ./compiler/lua54.lpt:293
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:294
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:295
end -- ./compiler/lua54.lpt:295
return r -- ./compiler/lua54.lpt:297
elseif # t == 4 then -- ./compiler/lua54.lpt:298
if t[3] == "=" then -- ./compiler/lua54.lpt:299
local r = "" -- ./compiler/lua54.lpt:300
if # vars > 0 then -- ./compiler/lua54.lpt:301
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:302
t[2], -- ./compiler/lua54.lpt:302
vars[1], -- ./compiler/lua54.lpt:302
{ -- ./compiler/lua54.lpt:302
["tag"] = "Paren", -- ./compiler/lua54.lpt:302
values[1] -- ./compiler/lua54.lpt:302
} -- ./compiler/lua54.lpt:302
}, "Op")) -- ./compiler/lua54.lpt:302
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.lpt:303
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:304
t[2], -- ./compiler/lua54.lpt:304
vars[i], -- ./compiler/lua54.lpt:304
{ -- ./compiler/lua54.lpt:304
["tag"] = "Paren", -- ./compiler/lua54.lpt:304
values[i] -- ./compiler/lua54.lpt:304
} -- ./compiler/lua54.lpt:304
}, "Op")) -- ./compiler/lua54.lpt:304
end -- ./compiler/lua54.lpt:304
end -- ./compiler/lua54.lpt:304
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:307
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.lpt:308
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:309
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:310
end -- ./compiler/lua54.lpt:310
return r -- ./compiler/lua54.lpt:312
else -- ./compiler/lua54.lpt:312
local r = "" -- ./compiler/lua54.lpt:314
if # vars > 0 then -- ./compiler/lua54.lpt:315
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:316
t[3], -- ./compiler/lua54.lpt:316
{ -- ./compiler/lua54.lpt:316
["tag"] = "Paren", -- ./compiler/lua54.lpt:316
values[1] -- ./compiler/lua54.lpt:316
}, -- ./compiler/lua54.lpt:316
vars[1] -- ./compiler/lua54.lpt:316
}, "Op")) -- ./compiler/lua54.lpt:316
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.lpt:317
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:318
t[3], -- ./compiler/lua54.lpt:318
{ -- ./compiler/lua54.lpt:318
["tag"] = "Paren", -- ./compiler/lua54.lpt:318
values[i] -- ./compiler/lua54.lpt:318
}, -- ./compiler/lua54.lpt:318
vars[i] -- ./compiler/lua54.lpt:318
}, "Op")) -- ./compiler/lua54.lpt:318
end -- ./compiler/lua54.lpt:318
end -- ./compiler/lua54.lpt:318
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:321
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.lpt:322
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:323
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:324
end -- ./compiler/lua54.lpt:324
return r -- ./compiler/lua54.lpt:326
end -- ./compiler/lua54.lpt:326
else -- ./compiler/lua54.lpt:326
local r = "" -- ./compiler/lua54.lpt:329
if # vars > 0 then -- ./compiler/lua54.lpt:330
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:331
t[2], -- ./compiler/lua54.lpt:331
vars[1], -- ./compiler/lua54.lpt:331
{ -- ./compiler/lua54.lpt:331
["tag"] = "Op", -- ./compiler/lua54.lpt:331
t[4], -- ./compiler/lua54.lpt:331
{ -- ./compiler/lua54.lpt:331
["tag"] = "Paren", -- ./compiler/lua54.lpt:331
values[1] -- ./compiler/lua54.lpt:331
}, -- ./compiler/lua54.lpt:331
vars[1] -- ./compiler/lua54.lpt:331
} -- ./compiler/lua54.lpt:331
}, "Op")) -- ./compiler/lua54.lpt:331
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.lpt:332
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:333
t[2], -- ./compiler/lua54.lpt:333
vars[i], -- ./compiler/lua54.lpt:333
{ -- ./compiler/lua54.lpt:333
["tag"] = "Op", -- ./compiler/lua54.lpt:333
t[4], -- ./compiler/lua54.lpt:333
{ -- ./compiler/lua54.lpt:333
["tag"] = "Paren", -- ./compiler/lua54.lpt:333
values[i] -- ./compiler/lua54.lpt:333
}, -- ./compiler/lua54.lpt:333
vars[i] -- ./compiler/lua54.lpt:333
} -- ./compiler/lua54.lpt:333
}, "Op")) -- ./compiler/lua54.lpt:333
end -- ./compiler/lua54.lpt:333
end -- ./compiler/lua54.lpt:333
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:336
local destructured = { -- ./compiler/lua54.lpt:337
["rightOp"] = t[2], -- ./compiler/lua54.lpt:337
["leftOp"] = t[4] -- ./compiler/lua54.lpt:337
} -- ./compiler/lua54.lpt:337
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:338
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:339
end -- ./compiler/lua54.lpt:339
return r -- ./compiler/lua54.lpt:341
end -- ./compiler/lua54.lpt:341
end, -- ./compiler/lua54.lpt:341
["While"] = function(t) -- ./compiler/lua54.lpt:345
local r = "" -- ./compiler/lua54.lpt:346
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.lpt:347
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:348
if # lets > 0 then -- ./compiler/lua54.lpt:349
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:350
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:351
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:352
end -- ./compiler/lua54.lpt:352
end -- ./compiler/lua54.lpt:352
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.lpt:355
if # lets > 0 then -- ./compiler/lua54.lpt:356
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:357
end -- ./compiler/lua54.lpt:357
if hasContinue then -- ./compiler/lua54.lpt:359
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:360
end -- ./compiler/lua54.lpt:360
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:362
if hasContinue then -- ./compiler/lua54.lpt:363
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:364
end -- ./compiler/lua54.lpt:364
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:366
if # lets > 0 then -- ./compiler/lua54.lpt:367
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:368
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.lpt:369
end -- ./compiler/lua54.lpt:369
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.lpt:371
end -- ./compiler/lua54.lpt:371
return r -- ./compiler/lua54.lpt:373
end, -- ./compiler/lua54.lpt:373
["Repeat"] = function(t) -- ./compiler/lua54.lpt:376
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.lpt:377
local r = "repeat" .. indent() -- ./compiler/lua54.lpt:378
if hasContinue then -- ./compiler/lua54.lpt:379
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:380
end -- ./compiler/lua54.lpt:380
r = r .. (lua(t[1])) -- ./compiler/lua54.lpt:382
if hasContinue then -- ./compiler/lua54.lpt:383
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:384
end -- ./compiler/lua54.lpt:384
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.lpt:386
return r -- ./compiler/lua54.lpt:387
end, -- ./compiler/lua54.lpt:387
["If"] = function(t) -- ./compiler/lua54.lpt:390
local r = "" -- ./compiler/lua54.lpt:391
local toClose = 0 -- ./compiler/lua54.lpt:392
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:393
if # lets > 0 then -- ./compiler/lua54.lpt:394
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:395
toClose = toClose + (1) -- ./compiler/lua54.lpt:396
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:397
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:398
end -- ./compiler/lua54.lpt:398
end -- ./compiler/lua54.lpt:398
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.lpt:401
for i = 3, # t - 1, 2 do -- ./compiler/lua54.lpt:402
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.lpt:403
if # lets > 0 then -- ./compiler/lua54.lpt:404
r = r .. ("else" .. indent()) -- ./compiler/lua54.lpt:405
toClose = toClose + (1) -- ./compiler/lua54.lpt:406
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:407
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:408
end -- ./compiler/lua54.lpt:408
else -- ./compiler/lua54.lpt:408
r = r .. ("else") -- ./compiler/lua54.lpt:411
end -- ./compiler/lua54.lpt:411
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.lpt:413
end -- ./compiler/lua54.lpt:413
if # t % 2 == 1 then -- ./compiler/lua54.lpt:415
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.lpt:416
end -- ./compiler/lua54.lpt:416
r = r .. ("end") -- ./compiler/lua54.lpt:418
for i = 1, toClose do -- ./compiler/lua54.lpt:419
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:420
end -- ./compiler/lua54.lpt:420
return r -- ./compiler/lua54.lpt:422
end, -- ./compiler/lua54.lpt:422
["Fornum"] = function(t) -- ./compiler/lua54.lpt:425
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.lpt:426
if # t == 5 then -- ./compiler/lua54.lpt:427
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.lpt:428
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.lpt:429
if hasContinue then -- ./compiler/lua54.lpt:430
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:431
end -- ./compiler/lua54.lpt:431
r = r .. (lua(t[5])) -- ./compiler/lua54.lpt:433
if hasContinue then -- ./compiler/lua54.lpt:434
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:435
end -- ./compiler/lua54.lpt:435
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:437
else -- ./compiler/lua54.lpt:437
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.lpt:439
r = r .. (" do" .. indent()) -- ./compiler/lua54.lpt:440
if hasContinue then -- ./compiler/lua54.lpt:441
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:442
end -- ./compiler/lua54.lpt:442
r = r .. (lua(t[4])) -- ./compiler/lua54.lpt:444
if hasContinue then -- ./compiler/lua54.lpt:445
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:446
end -- ./compiler/lua54.lpt:446
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:448
end -- ./compiler/lua54.lpt:448
end, -- ./compiler/lua54.lpt:448
["Forin"] = function(t) -- ./compiler/lua54.lpt:452
local destructured = {} -- ./compiler/lua54.lpt:453
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.lpt:454
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.lpt:455
if hasContinue then -- ./compiler/lua54.lpt:456
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:457
end -- ./compiler/lua54.lpt:457
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.lpt:459
if hasContinue then -- ./compiler/lua54.lpt:460
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:461
end -- ./compiler/lua54.lpt:461
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:463
end, -- ./compiler/lua54.lpt:463
["Local"] = function(t) -- ./compiler/lua54.lpt:466
local destructured = {} -- ./compiler/lua54.lpt:467
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:468
if t[2][1] then -- ./compiler/lua54.lpt:469
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:470
end -- ./compiler/lua54.lpt:470
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:472
end, -- ./compiler/lua54.lpt:472
["Let"] = function(t) -- ./compiler/lua54.lpt:475
local destructured = {} -- ./compiler/lua54.lpt:476
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:477
local r = "local " .. nameList -- ./compiler/lua54.lpt:478
if t[2][1] then -- ./compiler/lua54.lpt:479
if all(t[2], { -- ./compiler/lua54.lpt:480
"Nil", -- ./compiler/lua54.lpt:480
"Dots", -- ./compiler/lua54.lpt:480
"Boolean", -- ./compiler/lua54.lpt:480
"Number", -- ./compiler/lua54.lpt:480
"String" -- ./compiler/lua54.lpt:480
}) then -- ./compiler/lua54.lpt:480
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:481
else -- ./compiler/lua54.lpt:481
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:483
end -- ./compiler/lua54.lpt:483
end -- ./compiler/lua54.lpt:483
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:486
end, -- ./compiler/lua54.lpt:486
["Localrec"] = function(t) -- ./compiler/lua54.lpt:489
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.lpt:490
end, -- ./compiler/lua54.lpt:490
["Goto"] = function(t) -- ./compiler/lua54.lpt:493
return "goto " .. lua(t, "Id") -- ./compiler/lua54.lpt:494
end, -- ./compiler/lua54.lpt:494
["Label"] = function(t) -- ./compiler/lua54.lpt:497
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.lpt:498
end, -- ./compiler/lua54.lpt:498
["Return"] = function(t) -- ./compiler/lua54.lpt:501
local push = peek("push") -- ./compiler/lua54.lpt:502
if push then -- ./compiler/lua54.lpt:503
local r = "" -- ./compiler/lua54.lpt:504
for _, val in ipairs(t) do -- ./compiler/lua54.lpt:505
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.lpt:506
end -- ./compiler/lua54.lpt:506
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.lpt:508
else -- ./compiler/lua54.lpt:508
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.lpt:510
end -- ./compiler/lua54.lpt:510
end, -- ./compiler/lua54.lpt:510
["Push"] = function(t) -- ./compiler/lua54.lpt:514
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.lpt:515
r = "" -- ./compiler/lua54.lpt:516
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:517
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:518
end -- ./compiler/lua54.lpt:518
if t[# t] then -- ./compiler/lua54.lpt:520
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.lpt:521
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.lpt:522
else -- ./compiler/lua54.lpt:522
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
return r -- ./compiler/lua54.lpt:527
end, -- ./compiler/lua54.lpt:527
["Break"] = function() -- ./compiler/lua54.lpt:530
return "break" -- ./compiler/lua54.lpt:531
end, -- ./compiler/lua54.lpt:531
["Continue"] = function() -- ./compiler/lua54.lpt:534
return "goto " .. var("continue") -- ./compiler/lua54.lpt:535
end, -- ./compiler/lua54.lpt:535
["Nil"] = function() -- ./compiler/lua54.lpt:542
return "nil" -- ./compiler/lua54.lpt:543
end, -- ./compiler/lua54.lpt:543
["Dots"] = function() -- ./compiler/lua54.lpt:546
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:547
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.lpt:548
nomacro["variables"]["..."] = true -- ./compiler/lua54.lpt:549
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.lpt:550
nomacro["variables"]["..."] = nil -- ./compiler/lua54.lpt:551
return r -- ./compiler/lua54.lpt:552
else -- ./compiler/lua54.lpt:552
return "..." -- ./compiler/lua54.lpt:554
end -- ./compiler/lua54.lpt:554
end, -- ./compiler/lua54.lpt:554
["Boolean"] = function(t) -- ./compiler/lua54.lpt:558
return tostring(t[1]) -- ./compiler/lua54.lpt:559
end, -- ./compiler/lua54.lpt:559
["Number"] = function(t) -- ./compiler/lua54.lpt:562
return tostring(t[1]) -- ./compiler/lua54.lpt:563
end, -- ./compiler/lua54.lpt:563
["String"] = function(t) -- ./compiler/lua54.lpt:566
return ("%q"):format(t[1]) -- ./compiler/lua54.lpt:567
end, -- ./compiler/lua54.lpt:567
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.lpt:570
local r = "(" -- ./compiler/lua54.lpt:571
local decl = {} -- ./compiler/lua54.lpt:572
if t[1][1] then -- ./compiler/lua54.lpt:573
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:574
local id = lua(t[1][1][1]) -- ./compiler/lua54.lpt:575
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:576
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.lpt:577
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:578
r = r .. (id) -- ./compiler/lua54.lpt:579
else -- ./compiler/lua54.lpt:579
r = r .. (lua(t[1][1])) -- ./compiler/lua54.lpt:581
end -- ./compiler/lua54.lpt:581
for i = 2, # t[1], 1 do -- ./compiler/lua54.lpt:583
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:584
local id = lua(t[1][i][1]) -- ./compiler/lua54.lpt:585
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:586
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.lpt:587
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:588
r = r .. (", " .. id) -- ./compiler/lua54.lpt:589
else -- ./compiler/lua54.lpt:589
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
r = r .. (")" .. indent()) -- ./compiler/lua54.lpt:595
for _, d in ipairs(decl) do -- ./compiler/lua54.lpt:596
r = r .. (d .. newline()) -- ./compiler/lua54.lpt:597
end -- ./compiler/lua54.lpt:597
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.lpt:599
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.lpt:600
end -- ./compiler/lua54.lpt:600
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.lpt:602
if hasPush then -- ./compiler/lua54.lpt:603
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:604
else -- ./compiler/lua54.lpt:604
push("push", false) -- ./compiler/lua54.lpt:606
end -- ./compiler/lua54.lpt:606
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:608
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:609
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:610
end -- ./compiler/lua54.lpt:610
pop("push") -- ./compiler/lua54.lpt:612
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:613
end, -- ./compiler/lua54.lpt:613
["Function"] = function(t) -- ./compiler/lua54.lpt:615
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.lpt:616
end, -- ./compiler/lua54.lpt:616
["Pair"] = function(t) -- ./compiler/lua54.lpt:619
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.lpt:620
end, -- ./compiler/lua54.lpt:620
["Table"] = function(t) -- ./compiler/lua54.lpt:622
if # t == 0 then -- ./compiler/lua54.lpt:623
return "{}" -- ./compiler/lua54.lpt:624
elseif # t == 1 then -- ./compiler/lua54.lpt:625
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.lpt:626
else -- ./compiler/lua54.lpt:626
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.lpt:628
end -- ./compiler/lua54.lpt:628
end, -- ./compiler/lua54.lpt:628
["TableCompr"] = function(t) -- ./compiler/lua54.lpt:632
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.lpt:633
end, -- ./compiler/lua54.lpt:633
["Op"] = function(t) -- ./compiler/lua54.lpt:636
local r -- ./compiler/lua54.lpt:637
if # t == 2 then -- ./compiler/lua54.lpt:638
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:639
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.lpt:640
else -- ./compiler/lua54.lpt:640
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.lpt:642
end -- ./compiler/lua54.lpt:642
else -- ./compiler/lua54.lpt:642
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:645
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.lpt:646
else -- ./compiler/lua54.lpt:646
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.lpt:648
end -- ./compiler/lua54.lpt:648
end -- ./compiler/lua54.lpt:648
return r -- ./compiler/lua54.lpt:651
end, -- ./compiler/lua54.lpt:651
["Paren"] = function(t) -- ./compiler/lua54.lpt:654
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.lpt:655
end, -- ./compiler/lua54.lpt:655
["MethodStub"] = function(t) -- ./compiler/lua54.lpt:658
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:664
end, -- ./compiler/lua54.lpt:664
["SafeMethodStub"] = function(t) -- ./compiler/lua54.lpt:667
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:674
end, -- ./compiler/lua54.lpt:674
["LetExpr"] = function(t) -- ./compiler/lua54.lpt:681
return lua(t[1][1]) -- ./compiler/lua54.lpt:682
end, -- ./compiler/lua54.lpt:682
["_statexpr"] = function(t, stat) -- ./compiler/lua54.lpt:686
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.lpt:687
local r = "(function()" .. indent() -- ./compiler/lua54.lpt:688
if hasPush then -- ./compiler/lua54.lpt:689
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:690
else -- ./compiler/lua54.lpt:690
push("push", false) -- ./compiler/lua54.lpt:692
end -- ./compiler/lua54.lpt:692
r = r .. (lua(t, stat)) -- ./compiler/lua54.lpt:694
if hasPush then -- ./compiler/lua54.lpt:695
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:696
end -- ./compiler/lua54.lpt:696
pop("push") -- ./compiler/lua54.lpt:698
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.lpt:699
return r -- ./compiler/lua54.lpt:700
end, -- ./compiler/lua54.lpt:700
["DoExpr"] = function(t) -- ./compiler/lua54.lpt:703
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.lpt:704
t[# t]["tag"] = "Return" -- ./compiler/lua54.lpt:705
end -- ./compiler/lua54.lpt:705
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.lpt:707
end, -- ./compiler/lua54.lpt:707
["WhileExpr"] = function(t) -- ./compiler/lua54.lpt:710
return lua(t, "_statexpr", "While") -- ./compiler/lua54.lpt:711
end, -- ./compiler/lua54.lpt:711
["RepeatExpr"] = function(t) -- ./compiler/lua54.lpt:714
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.lpt:715
end, -- ./compiler/lua54.lpt:715
["IfExpr"] = function(t) -- ./compiler/lua54.lpt:718
for i = 2, # t do -- ./compiler/lua54.lpt:719
local block = t[i] -- ./compiler/lua54.lpt:720
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.lpt:721
block[# block]["tag"] = "Return" -- ./compiler/lua54.lpt:722
end -- ./compiler/lua54.lpt:722
end -- ./compiler/lua54.lpt:722
return lua(t, "_statexpr", "If") -- ./compiler/lua54.lpt:725
end, -- ./compiler/lua54.lpt:725
["FornumExpr"] = function(t) -- ./compiler/lua54.lpt:728
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.lpt:729
end, -- ./compiler/lua54.lpt:729
["ForinExpr"] = function(t) -- ./compiler/lua54.lpt:732
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.lpt:733
end, -- ./compiler/lua54.lpt:733
["Call"] = function(t) -- ./compiler/lua54.lpt:739
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:740
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:741
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.lpt:742
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.lpt:743
local replacement = macro["replacement"] -- ./compiler/lua54.lpt:744
local r -- ./compiler/lua54.lpt:745
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.lpt:746
if type(replacement) == "function" then -- ./compiler/lua54.lpt:747
local args = {} -- ./compiler/lua54.lpt:748
for i = 2, # t do -- ./compiler/lua54.lpt:749
table["insert"](args, lua(t[i])) -- ./compiler/lua54.lpt:750
end -- ./compiler/lua54.lpt:750
r = replacement(unpack(args)) -- ./compiler/lua54.lpt:752
else -- ./compiler/lua54.lpt:752
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.lpt:754
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.lpt:755
if arg["tag"] == "Dots" then -- ./compiler/lua54.lpt:756
macroargs["..."] = (function() -- ./compiler/lua54.lpt:757
local self = {} -- ./compiler/lua54.lpt:757
for j = i + 1, # t do -- ./compiler/lua54.lpt:757
self[#self+1] = t[j] -- ./compiler/lua54.lpt:757
end -- ./compiler/lua54.lpt:757
return self -- ./compiler/lua54.lpt:757
end)() -- ./compiler/lua54.lpt:757
elseif arg["tag"] == "Id" then -- ./compiler/lua54.lpt:758
if t[i + 1] == nil then -- ./compiler/lua54.lpt:759
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.lpt:760
end -- ./compiler/lua54.lpt:760
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.lpt:762
else -- ./compiler/lua54.lpt:762
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.lpt:764
end -- ./compiler/lua54.lpt:764
end -- ./compiler/lua54.lpt:764
push("macroargs", macroargs) -- ./compiler/lua54.lpt:767
r = lua(replacement) -- ./compiler/lua54.lpt:768
pop("macroargs") -- ./compiler/lua54.lpt:769
end -- ./compiler/lua54.lpt:769
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.lpt:771
return r -- ./compiler/lua54.lpt:772
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.lpt:773
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.lpt:774
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:775
else -- ./compiler/lua54.lpt:775
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:777
end -- ./compiler/lua54.lpt:777
else -- ./compiler/lua54.lpt:777
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:780
end -- ./compiler/lua54.lpt:780
end, -- ./compiler/lua54.lpt:780
["SafeCall"] = function(t) -- ./compiler/lua54.lpt:784
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:785
return lua(t, "SafeIndex") -- ./compiler/lua54.lpt:786
else -- ./compiler/lua54.lpt:786
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.lpt:788
end -- ./compiler/lua54.lpt:788
end, -- ./compiler/lua54.lpt:788
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.lpt:793
if start == nil then start = 1 end -- ./compiler/lua54.lpt:793
local r -- ./compiler/lua54.lpt:794
if t[start] then -- ./compiler/lua54.lpt:795
r = lua(t[start]) -- ./compiler/lua54.lpt:796
for i = start + 1, # t, 1 do -- ./compiler/lua54.lpt:797
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.lpt:798
end -- ./compiler/lua54.lpt:798
else -- ./compiler/lua54.lpt:798
r = "" -- ./compiler/lua54.lpt:801
end -- ./compiler/lua54.lpt:801
return r -- ./compiler/lua54.lpt:803
end, -- ./compiler/lua54.lpt:803
["Id"] = function(t) -- ./compiler/lua54.lpt:806
local r = t[1] -- ./compiler/lua54.lpt:807
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:808
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.lpt:809
nomacro["variables"][t[1]] = true -- ./compiler/lua54.lpt:810
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.lpt:811
r = lua(macroargs[t[1]]) -- ./compiler/lua54.lpt:812
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.lpt:813
local macro = macros["variables"][t[1]] -- ./compiler/lua54.lpt:814
if type(macro) == "function" then -- ./compiler/lua54.lpt:815
r = macro() -- ./compiler/lua54.lpt:816
else -- ./compiler/lua54.lpt:816
r = lua(macro) -- ./compiler/lua54.lpt:818
end -- ./compiler/lua54.lpt:818
end -- ./compiler/lua54.lpt:818
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.lpt:821
end -- ./compiler/lua54.lpt:821
return r -- ./compiler/lua54.lpt:823
end, -- ./compiler/lua54.lpt:823
["AttributeId"] = function(t) -- ./compiler/lua54.lpt:826
if t[2] then -- ./compiler/lua54.lpt:827
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.lpt:828
else -- ./compiler/lua54.lpt:828
return t[1] -- ./compiler/lua54.lpt:830
end -- ./compiler/lua54.lpt:830
end, -- ./compiler/lua54.lpt:830
["DestructuringId"] = function(t) -- ./compiler/lua54.lpt:834
if t["id"] then -- ./compiler/lua54.lpt:835
return t["id"] -- ./compiler/lua54.lpt:836
else -- ./compiler/lua54.lpt:836
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.lpt:838
local vars = { ["id"] = tmp() } -- ./compiler/lua54.lpt:839
for j = 1, # t, 1 do -- ./compiler/lua54.lpt:840
table["insert"](vars, t[j]) -- ./compiler/lua54.lpt:841
end -- ./compiler/lua54.lpt:841
table["insert"](d, vars) -- ./compiler/lua54.lpt:843
t["id"] = vars["id"] -- ./compiler/lua54.lpt:844
return vars["id"] -- ./compiler/lua54.lpt:845
end -- ./compiler/lua54.lpt:845
end, -- ./compiler/lua54.lpt:845
["Index"] = function(t) -- ./compiler/lua54.lpt:849
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:850
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:851
else -- ./compiler/lua54.lpt:851
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:853
end -- ./compiler/lua54.lpt:853
end, -- ./compiler/lua54.lpt:853
["SafeIndex"] = function(t) -- ./compiler/lua54.lpt:857
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:858
local l = {} -- ./compiler/lua54.lpt:859
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.lpt:860
table["insert"](l, 1, t) -- ./compiler/lua54.lpt:861
t = t[1] -- ./compiler/lua54.lpt:862
end -- ./compiler/lua54.lpt:862
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.lpt:864
for _, e in ipairs(l) do -- ./compiler/lua54.lpt:865
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.lpt:866
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.lpt:867
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.lpt:868
else -- ./compiler/lua54.lpt:868
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.lpt:870
end -- ./compiler/lua54.lpt:870
end -- ./compiler/lua54.lpt:870
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.lpt:873
return r -- ./compiler/lua54.lpt:874
else -- ./compiler/lua54.lpt:874
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.lpt:876
end -- ./compiler/lua54.lpt:876
end, -- ./compiler/lua54.lpt:876
["_opid"] = { -- ./compiler/lua54.lpt:881
["add"] = "+", -- ./compiler/lua54.lpt:882
["sub"] = "-", -- ./compiler/lua54.lpt:882
["mul"] = "*", -- ./compiler/lua54.lpt:882
["div"] = "/", -- ./compiler/lua54.lpt:882
["idiv"] = "//", -- ./compiler/lua54.lpt:883
["mod"] = "%", -- ./compiler/lua54.lpt:883
["pow"] = "^", -- ./compiler/lua54.lpt:883
["concat"] = "..", -- ./compiler/lua54.lpt:883
["band"] = "&", -- ./compiler/lua54.lpt:884
["bor"] = "|", -- ./compiler/lua54.lpt:884
["bxor"] = "~", -- ./compiler/lua54.lpt:884
["shl"] = "<<", -- ./compiler/lua54.lpt:884
["shr"] = ">>", -- ./compiler/lua54.lpt:884
["eq"] = "==", -- ./compiler/lua54.lpt:885
["ne"] = "~=", -- ./compiler/lua54.lpt:885
["lt"] = "<", -- ./compiler/lua54.lpt:885
["gt"] = ">", -- ./compiler/lua54.lpt:885
["le"] = "<=", -- ./compiler/lua54.lpt:885
["ge"] = ">=", -- ./compiler/lua54.lpt:885
["and"] = "and", -- ./compiler/lua54.lpt:886
["or"] = "or", -- ./compiler/lua54.lpt:886
["unm"] = "-", -- ./compiler/lua54.lpt:886
["len"] = "#", -- ./compiler/lua54.lpt:886
["bnot"] = "~", -- ./compiler/lua54.lpt:886
["not"] = "not" -- ./compiler/lua54.lpt:886
} -- ./compiler/lua54.lpt:886
}, { ["__index"] = function(self, key) -- ./compiler/lua54.lpt:889
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.lpt:890
end }) -- ./compiler/lua54.lpt:890
targetName = "Lua 5.3" -- ./compiler/lua53.lpt:1
tags["AttributeId"] = function(t) -- ./compiler/lua53.lpt:4
if t[2] then -- ./compiler/lua53.lpt:5
error("target " .. targetName .. " does not support variable attributes") -- ./compiler/lua53.lpt:6
else -- ./compiler/lua53.lpt:6
return t[1] -- ./compiler/lua53.lpt:8
end -- ./compiler/lua53.lpt:8
end -- ./compiler/lua53.lpt:8
local code = lua(ast) .. newline() -- ./compiler/lua54.lpt:896
return requireStr .. code -- ./compiler/lua54.lpt:897
end -- ./compiler/lua54.lpt:897
end -- ./compiler/lua54.lpt:897
local lua54 = _() or lua54 -- ./compiler/lua54.lpt:902
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
local indentLevel = 0 -- ./compiler/lua54.lpt:15
local function newline() -- ./compiler/lua54.lpt:17
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.lpt:18
if options["mapLines"] then -- ./compiler/lua54.lpt:19
local sub = code:sub(lastInputPos) -- ./compiler/lua54.lpt:20
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.lpt:21
if source and line then -- ./compiler/lua54.lpt:23
lastSource = source -- ./compiler/lua54.lpt:24
lastLine = tonumber(line) -- ./compiler/lua54.lpt:25
else -- ./compiler/lua54.lpt:25
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.lpt:27
lastLine = lastLine + (1) -- ./compiler/lua54.lpt:28
end -- ./compiler/lua54.lpt:28
end -- ./compiler/lua54.lpt:28
prevLinePos = lastInputPos -- ./compiler/lua54.lpt:32
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.lpt:34
end -- ./compiler/lua54.lpt:34
return r -- ./compiler/lua54.lpt:36
end -- ./compiler/lua54.lpt:36
local function indent() -- ./compiler/lua54.lpt:39
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:40
return newline() -- ./compiler/lua54.lpt:41
end -- ./compiler/lua54.lpt:41
local function unindent() -- ./compiler/lua54.lpt:44
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:45
return newline() -- ./compiler/lua54.lpt:46
end -- ./compiler/lua54.lpt:46
local states = { -- ./compiler/lua54.lpt:51
["push"] = {}, -- ./compiler/lua54.lpt:52
["destructuring"] = {}, -- ./compiler/lua54.lpt:53
["scope"] = {}, -- ./compiler/lua54.lpt:54
["macroargs"] = {} -- ./compiler/lua54.lpt:55
} -- ./compiler/lua54.lpt:55
local function push(name, state) -- ./compiler/lua54.lpt:58
table["insert"](states[name], state) -- ./compiler/lua54.lpt:59
return "" -- ./compiler/lua54.lpt:60
end -- ./compiler/lua54.lpt:60
local function pop(name) -- ./compiler/lua54.lpt:63
table["remove"](states[name]) -- ./compiler/lua54.lpt:64
return "" -- ./compiler/lua54.lpt:65
end -- ./compiler/lua54.lpt:65
local function set(name, state) -- ./compiler/lua54.lpt:68
states[name][# states[name]] = state -- ./compiler/lua54.lpt:69
return "" -- ./compiler/lua54.lpt:70
end -- ./compiler/lua54.lpt:70
local function peek(name) -- ./compiler/lua54.lpt:73
return states[name][# states[name]] -- ./compiler/lua54.lpt:74
end -- ./compiler/lua54.lpt:74
local function var(name) -- ./compiler/lua54.lpt:79
return options["variablePrefix"] .. name -- ./compiler/lua54.lpt:80
end -- ./compiler/lua54.lpt:80
local function tmp() -- ./compiler/lua54.lpt:84
local scope = peek("scope") -- ./compiler/lua54.lpt:85
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.lpt:86
table["insert"](scope, var) -- ./compiler/lua54.lpt:87
return var -- ./compiler/lua54.lpt:88
end -- ./compiler/lua54.lpt:88
local nomacro = { -- ./compiler/lua54.lpt:92
["variables"] = {}, -- ./compiler/lua54.lpt:92
["functions"] = {} -- ./compiler/lua54.lpt:92
} -- ./compiler/lua54.lpt:92
local required = {} -- ./compiler/lua54.lpt:95
local requireStr = "" -- ./compiler/lua54.lpt:96
local function addRequire(mod, name, field) -- ./compiler/lua54.lpt:98
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.lpt:99
if not required[req] then -- ./compiler/lua54.lpt:100
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.lpt:101
required[req] = true -- ./compiler/lua54.lpt:102
end -- ./compiler/lua54.lpt:102
end -- ./compiler/lua54.lpt:102
local loop = { -- ./compiler/lua54.lpt:107
"While", -- ./compiler/lua54.lpt:107
"Repeat", -- ./compiler/lua54.lpt:107
"Fornum", -- ./compiler/lua54.lpt:107
"Forin", -- ./compiler/lua54.lpt:107
"WhileExpr", -- ./compiler/lua54.lpt:107
"RepeatExpr", -- ./compiler/lua54.lpt:107
"FornumExpr", -- ./compiler/lua54.lpt:107
"ForinExpr" -- ./compiler/lua54.lpt:107
} -- ./compiler/lua54.lpt:107
local func = { -- ./compiler/lua54.lpt:108
"Function", -- ./compiler/lua54.lpt:108
"TableCompr", -- ./compiler/lua54.lpt:108
"DoExpr", -- ./compiler/lua54.lpt:108
"WhileExpr", -- ./compiler/lua54.lpt:108
"RepeatExpr", -- ./compiler/lua54.lpt:108
"IfExpr", -- ./compiler/lua54.lpt:108
"FornumExpr", -- ./compiler/lua54.lpt:108
"ForinExpr" -- ./compiler/lua54.lpt:108
} -- ./compiler/lua54.lpt:108
local function any(list, tags, nofollow) -- ./compiler/lua54.lpt:112
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:112
local tagsCheck = {} -- ./compiler/lua54.lpt:113
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:114
tagsCheck[tag] = true -- ./compiler/lua54.lpt:115
end -- ./compiler/lua54.lpt:115
local nofollowCheck = {} -- ./compiler/lua54.lpt:117
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:118
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:119
end -- ./compiler/lua54.lpt:119
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:121
if type(node) == "table" then -- ./compiler/lua54.lpt:122
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:123
return node -- ./compiler/lua54.lpt:124
end -- ./compiler/lua54.lpt:124
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:126
local r = any(node, tags, nofollow) -- ./compiler/lua54.lpt:127
if r then -- ./compiler/lua54.lpt:128
return r -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
return nil -- ./compiler/lua54.lpt:132
end -- ./compiler/lua54.lpt:132
local function search(list, tags, nofollow) -- ./compiler/lua54.lpt:137
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:137
local tagsCheck = {} -- ./compiler/lua54.lpt:138
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:139
tagsCheck[tag] = true -- ./compiler/lua54.lpt:140
end -- ./compiler/lua54.lpt:140
local nofollowCheck = {} -- ./compiler/lua54.lpt:142
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:143
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:144
end -- ./compiler/lua54.lpt:144
local found = {} -- ./compiler/lua54.lpt:146
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:147
if type(node) == "table" then -- ./compiler/lua54.lpt:148
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:149
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.lpt:150
table["insert"](found, n) -- ./compiler/lua54.lpt:151
end -- ./compiler/lua54.lpt:151
end -- ./compiler/lua54.lpt:151
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:154
table["insert"](found, node) -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
return found -- ./compiler/lua54.lpt:159
end -- ./compiler/lua54.lpt:159
local function all(list, tags) -- ./compiler/lua54.lpt:163
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:164
local ok = false -- ./compiler/lua54.lpt:165
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:166
if node["tag"] == tag then -- ./compiler/lua54.lpt:167
ok = true -- ./compiler/lua54.lpt:168
break -- ./compiler/lua54.lpt:169
end -- ./compiler/lua54.lpt:169
end -- ./compiler/lua54.lpt:169
if not ok then -- ./compiler/lua54.lpt:172
return false -- ./compiler/lua54.lpt:173
end -- ./compiler/lua54.lpt:173
end -- ./compiler/lua54.lpt:173
return true -- ./compiler/lua54.lpt:176
end -- ./compiler/lua54.lpt:176
local tags -- ./compiler/lua54.lpt:180
local function lua(ast, forceTag, ...) -- ./compiler/lua54.lpt:182
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.lpt:183
lastInputPos = ast["pos"] -- ./compiler/lua54.lpt:184
end -- ./compiler/lua54.lpt:184
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.lpt:186
end -- ./compiler/lua54.lpt:186
local UNPACK = function(list, i, j) -- ./compiler/lua54.lpt:190
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.lpt:191
end -- ./compiler/lua54.lpt:191
local APPEND = function(t, toAppend) -- ./compiler/lua54.lpt:193
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.lpt:194
end -- ./compiler/lua54.lpt:194
local CONTINUE_START = function() -- ./compiler/lua54.lpt:196
return "do" .. indent() -- ./compiler/lua54.lpt:197
end -- ./compiler/lua54.lpt:197
local CONTINUE_STOP = function() -- ./compiler/lua54.lpt:199
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.lpt:200
end -- ./compiler/lua54.lpt:200
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.lpt:202
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.lpt:202
if noLocal == nil then noLocal = false end -- ./compiler/lua54.lpt:202
local vars = {} -- ./compiler/lua54.lpt:203
local values = {} -- ./compiler/lua54.lpt:204
for _, list in ipairs(destructured) do -- ./compiler/lua54.lpt:205
for _, v in ipairs(list) do -- ./compiler/lua54.lpt:206
local var, val -- ./compiler/lua54.lpt:207
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.lpt:208
var = v -- ./compiler/lua54.lpt:209
val = { -- ./compiler/lua54.lpt:210
["tag"] = "Index", -- ./compiler/lua54.lpt:210
{ -- ./compiler/lua54.lpt:210
["tag"] = "Id", -- ./compiler/lua54.lpt:210
list["id"] -- ./compiler/lua54.lpt:210
}, -- ./compiler/lua54.lpt:210
{ -- ./compiler/lua54.lpt:210
["tag"] = "String", -- ./compiler/lua54.lpt:210
v[1] -- ./compiler/lua54.lpt:210
} -- ./compiler/lua54.lpt:210
} -- ./compiler/lua54.lpt:210
elseif v["tag"] == "Pair" then -- ./compiler/lua54.lpt:211
var = v[2] -- ./compiler/lua54.lpt:212
val = { -- ./compiler/lua54.lpt:213
["tag"] = "Index", -- ./compiler/lua54.lpt:213
{ -- ./compiler/lua54.lpt:213
["tag"] = "Id", -- ./compiler/lua54.lpt:213
list["id"] -- ./compiler/lua54.lpt:213
}, -- ./compiler/lua54.lpt:213
v[1] -- ./compiler/lua54.lpt:213
} -- ./compiler/lua54.lpt:213
else -- ./compiler/lua54.lpt:213
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.lpt:215
end -- ./compiler/lua54.lpt:215
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.lpt:217
val = { -- ./compiler/lua54.lpt:218
["tag"] = "Op", -- ./compiler/lua54.lpt:218
destructured["rightOp"], -- ./compiler/lua54.lpt:218
var, -- ./compiler/lua54.lpt:218
{ -- ./compiler/lua54.lpt:218
["tag"] = "Op", -- ./compiler/lua54.lpt:218
destructured["leftOp"], -- ./compiler/lua54.lpt:218
val, -- ./compiler/lua54.lpt:218
var -- ./compiler/lua54.lpt:218
} -- ./compiler/lua54.lpt:218
} -- ./compiler/lua54.lpt:218
elseif destructured["rightOp"] then -- ./compiler/lua54.lpt:219
val = { -- ./compiler/lua54.lpt:220
["tag"] = "Op", -- ./compiler/lua54.lpt:220
destructured["rightOp"], -- ./compiler/lua54.lpt:220
var, -- ./compiler/lua54.lpt:220
val -- ./compiler/lua54.lpt:220
} -- ./compiler/lua54.lpt:220
elseif destructured["leftOp"] then -- ./compiler/lua54.lpt:221
val = { -- ./compiler/lua54.lpt:222
["tag"] = "Op", -- ./compiler/lua54.lpt:222
destructured["leftOp"], -- ./compiler/lua54.lpt:222
val, -- ./compiler/lua54.lpt:222
var -- ./compiler/lua54.lpt:222
} -- ./compiler/lua54.lpt:222
end -- ./compiler/lua54.lpt:222
table["insert"](vars, lua(var)) -- ./compiler/lua54.lpt:224
table["insert"](values, lua(val)) -- ./compiler/lua54.lpt:225
end -- ./compiler/lua54.lpt:225
end -- ./compiler/lua54.lpt:225
if # vars > 0 then -- ./compiler/lua54.lpt:228
local decl = noLocal and "" or "local " -- ./compiler/lua54.lpt:229
if newlineAfter then -- ./compiler/lua54.lpt:230
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.lpt:231
else -- ./compiler/lua54.lpt:231
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.lpt:233
end -- ./compiler/lua54.lpt:233
else -- ./compiler/lua54.lpt:233
return "" -- ./compiler/lua54.lpt:236
end -- ./compiler/lua54.lpt:236
end -- ./compiler/lua54.lpt:236
tags = setmetatable({ -- ./compiler/lua54.lpt:241
["Block"] = function(t) -- ./compiler/lua54.lpt:243
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.lpt:244
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.lpt:245
hasPush["tag"] = "Return" -- ./compiler/lua54.lpt:246
hasPush = false -- ./compiler/lua54.lpt:247
end -- ./compiler/lua54.lpt:247
local r = push("scope", {}) -- ./compiler/lua54.lpt:249
if hasPush then -- ./compiler/lua54.lpt:250
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:251
end -- ./compiler/lua54.lpt:251
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:253
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:254
end -- ./compiler/lua54.lpt:254
if t[# t] then -- ./compiler/lua54.lpt:256
r = r .. (lua(t[# t])) -- ./compiler/lua54.lpt:257
end -- ./compiler/lua54.lpt:257
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:259
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
return r .. pop("scope") -- ./compiler/lua54.lpt:262
end, -- ./compiler/lua54.lpt:262
["Do"] = function(t) -- ./compiler/lua54.lpt:268
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.lpt:269
end, -- ./compiler/lua54.lpt:269
["Set"] = function(t) -- ./compiler/lua54.lpt:272
local expr = t[# t] -- ./compiler/lua54.lpt:274
local vars, values = {}, {} -- ./compiler/lua54.lpt:275
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.lpt:276
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:277
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.lpt:278
table["insert"](destructuringVars, n) -- ./compiler/lua54.lpt:279
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.lpt:280
else -- ./compiler/lua54.lpt:280
table["insert"](vars, n) -- ./compiler/lua54.lpt:282
table["insert"](values, expr[i]) -- ./compiler/lua54.lpt:283
end -- ./compiler/lua54.lpt:283
end -- ./compiler/lua54.lpt:283
if # t == 2 or # t == 3 then -- ./compiler/lua54.lpt:287
local r = "" -- ./compiler/lua54.lpt:288
if # vars > 0 then -- ./compiler/lua54.lpt:289
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.lpt:290
end -- ./compiler/lua54.lpt:290
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:292
local destructured = {} -- ./compiler/lua54.lpt:293
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:294
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:295
end -- ./compiler/lua54.lpt:295
return r -- ./compiler/lua54.lpt:297
elseif # t == 4 then -- ./compiler/lua54.lpt:298
if t[3] == "=" then -- ./compiler/lua54.lpt:299
local r = "" -- ./compiler/lua54.lpt:300
if # vars > 0 then -- ./compiler/lua54.lpt:301
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:302
t[2], -- ./compiler/lua54.lpt:302
vars[1], -- ./compiler/lua54.lpt:302
{ -- ./compiler/lua54.lpt:302
["tag"] = "Paren", -- ./compiler/lua54.lpt:302
values[1] -- ./compiler/lua54.lpt:302
} -- ./compiler/lua54.lpt:302
}, "Op")) -- ./compiler/lua54.lpt:302
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.lpt:303
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:304
t[2], -- ./compiler/lua54.lpt:304
vars[i], -- ./compiler/lua54.lpt:304
{ -- ./compiler/lua54.lpt:304
["tag"] = "Paren", -- ./compiler/lua54.lpt:304
values[i] -- ./compiler/lua54.lpt:304
} -- ./compiler/lua54.lpt:304
}, "Op")) -- ./compiler/lua54.lpt:304
end -- ./compiler/lua54.lpt:304
end -- ./compiler/lua54.lpt:304
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:307
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.lpt:308
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:309
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:310
end -- ./compiler/lua54.lpt:310
return r -- ./compiler/lua54.lpt:312
else -- ./compiler/lua54.lpt:312
local r = "" -- ./compiler/lua54.lpt:314
if # vars > 0 then -- ./compiler/lua54.lpt:315
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:316
t[3], -- ./compiler/lua54.lpt:316
{ -- ./compiler/lua54.lpt:316
["tag"] = "Paren", -- ./compiler/lua54.lpt:316
values[1] -- ./compiler/lua54.lpt:316
}, -- ./compiler/lua54.lpt:316
vars[1] -- ./compiler/lua54.lpt:316
}, "Op")) -- ./compiler/lua54.lpt:316
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.lpt:317
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:318
t[3], -- ./compiler/lua54.lpt:318
{ -- ./compiler/lua54.lpt:318
["tag"] = "Paren", -- ./compiler/lua54.lpt:318
values[i] -- ./compiler/lua54.lpt:318
}, -- ./compiler/lua54.lpt:318
vars[i] -- ./compiler/lua54.lpt:318
}, "Op")) -- ./compiler/lua54.lpt:318
end -- ./compiler/lua54.lpt:318
end -- ./compiler/lua54.lpt:318
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:321
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.lpt:322
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:323
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:324
end -- ./compiler/lua54.lpt:324
return r -- ./compiler/lua54.lpt:326
end -- ./compiler/lua54.lpt:326
else -- ./compiler/lua54.lpt:326
local r = "" -- ./compiler/lua54.lpt:329
if # vars > 0 then -- ./compiler/lua54.lpt:330
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:331
t[2], -- ./compiler/lua54.lpt:331
vars[1], -- ./compiler/lua54.lpt:331
{ -- ./compiler/lua54.lpt:331
["tag"] = "Op", -- ./compiler/lua54.lpt:331
t[4], -- ./compiler/lua54.lpt:331
{ -- ./compiler/lua54.lpt:331
["tag"] = "Paren", -- ./compiler/lua54.lpt:331
values[1] -- ./compiler/lua54.lpt:331
}, -- ./compiler/lua54.lpt:331
vars[1] -- ./compiler/lua54.lpt:331
} -- ./compiler/lua54.lpt:331
}, "Op")) -- ./compiler/lua54.lpt:331
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.lpt:332
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:333
t[2], -- ./compiler/lua54.lpt:333
vars[i], -- ./compiler/lua54.lpt:333
{ -- ./compiler/lua54.lpt:333
["tag"] = "Op", -- ./compiler/lua54.lpt:333
t[4], -- ./compiler/lua54.lpt:333
{ -- ./compiler/lua54.lpt:333
["tag"] = "Paren", -- ./compiler/lua54.lpt:333
values[i] -- ./compiler/lua54.lpt:333
}, -- ./compiler/lua54.lpt:333
vars[i] -- ./compiler/lua54.lpt:333
} -- ./compiler/lua54.lpt:333
}, "Op")) -- ./compiler/lua54.lpt:333
end -- ./compiler/lua54.lpt:333
end -- ./compiler/lua54.lpt:333
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:336
local destructured = { -- ./compiler/lua54.lpt:337
["rightOp"] = t[2], -- ./compiler/lua54.lpt:337
["leftOp"] = t[4] -- ./compiler/lua54.lpt:337
} -- ./compiler/lua54.lpt:337
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:338
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:339
end -- ./compiler/lua54.lpt:339
return r -- ./compiler/lua54.lpt:341
end -- ./compiler/lua54.lpt:341
end, -- ./compiler/lua54.lpt:341
["While"] = function(t) -- ./compiler/lua54.lpt:345
local r = "" -- ./compiler/lua54.lpt:346
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.lpt:347
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:348
if # lets > 0 then -- ./compiler/lua54.lpt:349
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:350
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:351
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:352
end -- ./compiler/lua54.lpt:352
end -- ./compiler/lua54.lpt:352
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.lpt:355
if # lets > 0 then -- ./compiler/lua54.lpt:356
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:357
end -- ./compiler/lua54.lpt:357
if hasContinue then -- ./compiler/lua54.lpt:359
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:360
end -- ./compiler/lua54.lpt:360
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:362
if hasContinue then -- ./compiler/lua54.lpt:363
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:364
end -- ./compiler/lua54.lpt:364
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:366
if # lets > 0 then -- ./compiler/lua54.lpt:367
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:368
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.lpt:369
end -- ./compiler/lua54.lpt:369
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.lpt:371
end -- ./compiler/lua54.lpt:371
return r -- ./compiler/lua54.lpt:373
end, -- ./compiler/lua54.lpt:373
["Repeat"] = function(t) -- ./compiler/lua54.lpt:376
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.lpt:377
local r = "repeat" .. indent() -- ./compiler/lua54.lpt:378
if hasContinue then -- ./compiler/lua54.lpt:379
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:380
end -- ./compiler/lua54.lpt:380
r = r .. (lua(t[1])) -- ./compiler/lua54.lpt:382
if hasContinue then -- ./compiler/lua54.lpt:383
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:384
end -- ./compiler/lua54.lpt:384
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.lpt:386
return r -- ./compiler/lua54.lpt:387
end, -- ./compiler/lua54.lpt:387
["If"] = function(t) -- ./compiler/lua54.lpt:390
local r = "" -- ./compiler/lua54.lpt:391
local toClose = 0 -- ./compiler/lua54.lpt:392
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:393
if # lets > 0 then -- ./compiler/lua54.lpt:394
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:395
toClose = toClose + (1) -- ./compiler/lua54.lpt:396
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:397
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:398
end -- ./compiler/lua54.lpt:398
end -- ./compiler/lua54.lpt:398
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.lpt:401
for i = 3, # t - 1, 2 do -- ./compiler/lua54.lpt:402
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.lpt:403
if # lets > 0 then -- ./compiler/lua54.lpt:404
r = r .. ("else" .. indent()) -- ./compiler/lua54.lpt:405
toClose = toClose + (1) -- ./compiler/lua54.lpt:406
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:407
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:408
end -- ./compiler/lua54.lpt:408
else -- ./compiler/lua54.lpt:408
r = r .. ("else") -- ./compiler/lua54.lpt:411
end -- ./compiler/lua54.lpt:411
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.lpt:413
end -- ./compiler/lua54.lpt:413
if # t % 2 == 1 then -- ./compiler/lua54.lpt:415
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.lpt:416
end -- ./compiler/lua54.lpt:416
r = r .. ("end") -- ./compiler/lua54.lpt:418
for i = 1, toClose do -- ./compiler/lua54.lpt:419
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:420
end -- ./compiler/lua54.lpt:420
return r -- ./compiler/lua54.lpt:422
end, -- ./compiler/lua54.lpt:422
["Fornum"] = function(t) -- ./compiler/lua54.lpt:425
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.lpt:426
if # t == 5 then -- ./compiler/lua54.lpt:427
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.lpt:428
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.lpt:429
if hasContinue then -- ./compiler/lua54.lpt:430
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:431
end -- ./compiler/lua54.lpt:431
r = r .. (lua(t[5])) -- ./compiler/lua54.lpt:433
if hasContinue then -- ./compiler/lua54.lpt:434
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:435
end -- ./compiler/lua54.lpt:435
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:437
else -- ./compiler/lua54.lpt:437
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.lpt:439
r = r .. (" do" .. indent()) -- ./compiler/lua54.lpt:440
if hasContinue then -- ./compiler/lua54.lpt:441
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:442
end -- ./compiler/lua54.lpt:442
r = r .. (lua(t[4])) -- ./compiler/lua54.lpt:444
if hasContinue then -- ./compiler/lua54.lpt:445
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:446
end -- ./compiler/lua54.lpt:446
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:448
end -- ./compiler/lua54.lpt:448
end, -- ./compiler/lua54.lpt:448
["Forin"] = function(t) -- ./compiler/lua54.lpt:452
local destructured = {} -- ./compiler/lua54.lpt:453
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.lpt:454
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.lpt:455
if hasContinue then -- ./compiler/lua54.lpt:456
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:457
end -- ./compiler/lua54.lpt:457
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.lpt:459
if hasContinue then -- ./compiler/lua54.lpt:460
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:461
end -- ./compiler/lua54.lpt:461
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:463
end, -- ./compiler/lua54.lpt:463
["Local"] = function(t) -- ./compiler/lua54.lpt:466
local destructured = {} -- ./compiler/lua54.lpt:467
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:468
if t[2][1] then -- ./compiler/lua54.lpt:469
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:470
end -- ./compiler/lua54.lpt:470
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:472
end, -- ./compiler/lua54.lpt:472
["Let"] = function(t) -- ./compiler/lua54.lpt:475
local destructured = {} -- ./compiler/lua54.lpt:476
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:477
local r = "local " .. nameList -- ./compiler/lua54.lpt:478
if t[2][1] then -- ./compiler/lua54.lpt:479
if all(t[2], { -- ./compiler/lua54.lpt:480
"Nil", -- ./compiler/lua54.lpt:480
"Dots", -- ./compiler/lua54.lpt:480
"Boolean", -- ./compiler/lua54.lpt:480
"Number", -- ./compiler/lua54.lpt:480
"String" -- ./compiler/lua54.lpt:480
}) then -- ./compiler/lua54.lpt:480
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:481
else -- ./compiler/lua54.lpt:481
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:483
end -- ./compiler/lua54.lpt:483
end -- ./compiler/lua54.lpt:483
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:486
end, -- ./compiler/lua54.lpt:486
["Localrec"] = function(t) -- ./compiler/lua54.lpt:489
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.lpt:490
end, -- ./compiler/lua54.lpt:490
["Goto"] = function(t) -- ./compiler/lua54.lpt:493
return "goto " .. lua(t, "Id") -- ./compiler/lua54.lpt:494
end, -- ./compiler/lua54.lpt:494
["Label"] = function(t) -- ./compiler/lua54.lpt:497
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.lpt:498
end, -- ./compiler/lua54.lpt:498
["Return"] = function(t) -- ./compiler/lua54.lpt:501
local push = peek("push") -- ./compiler/lua54.lpt:502
if push then -- ./compiler/lua54.lpt:503
local r = "" -- ./compiler/lua54.lpt:504
for _, val in ipairs(t) do -- ./compiler/lua54.lpt:505
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.lpt:506
end -- ./compiler/lua54.lpt:506
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.lpt:508
else -- ./compiler/lua54.lpt:508
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.lpt:510
end -- ./compiler/lua54.lpt:510
end, -- ./compiler/lua54.lpt:510
["Push"] = function(t) -- ./compiler/lua54.lpt:514
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.lpt:515
r = "" -- ./compiler/lua54.lpt:516
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:517
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:518
end -- ./compiler/lua54.lpt:518
if t[# t] then -- ./compiler/lua54.lpt:520
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.lpt:521
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.lpt:522
else -- ./compiler/lua54.lpt:522
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
return r -- ./compiler/lua54.lpt:527
end, -- ./compiler/lua54.lpt:527
["Break"] = function() -- ./compiler/lua54.lpt:530
return "break" -- ./compiler/lua54.lpt:531
end, -- ./compiler/lua54.lpt:531
["Continue"] = function() -- ./compiler/lua54.lpt:534
return "goto " .. var("continue") -- ./compiler/lua54.lpt:535
end, -- ./compiler/lua54.lpt:535
["Nil"] = function() -- ./compiler/lua54.lpt:542
return "nil" -- ./compiler/lua54.lpt:543
end, -- ./compiler/lua54.lpt:543
["Dots"] = function() -- ./compiler/lua54.lpt:546
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:547
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.lpt:548
nomacro["variables"]["..."] = true -- ./compiler/lua54.lpt:549
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.lpt:550
nomacro["variables"]["..."] = nil -- ./compiler/lua54.lpt:551
return r -- ./compiler/lua54.lpt:552
else -- ./compiler/lua54.lpt:552
return "..." -- ./compiler/lua54.lpt:554
end -- ./compiler/lua54.lpt:554
end, -- ./compiler/lua54.lpt:554
["Boolean"] = function(t) -- ./compiler/lua54.lpt:558
return tostring(t[1]) -- ./compiler/lua54.lpt:559
end, -- ./compiler/lua54.lpt:559
["Number"] = function(t) -- ./compiler/lua54.lpt:562
return tostring(t[1]) -- ./compiler/lua54.lpt:563
end, -- ./compiler/lua54.lpt:563
["String"] = function(t) -- ./compiler/lua54.lpt:566
return ("%q"):format(t[1]) -- ./compiler/lua54.lpt:567
end, -- ./compiler/lua54.lpt:567
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.lpt:570
local r = "(" -- ./compiler/lua54.lpt:571
local decl = {} -- ./compiler/lua54.lpt:572
if t[1][1] then -- ./compiler/lua54.lpt:573
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:574
local id = lua(t[1][1][1]) -- ./compiler/lua54.lpt:575
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:576
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.lpt:577
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:578
r = r .. (id) -- ./compiler/lua54.lpt:579
else -- ./compiler/lua54.lpt:579
r = r .. (lua(t[1][1])) -- ./compiler/lua54.lpt:581
end -- ./compiler/lua54.lpt:581
for i = 2, # t[1], 1 do -- ./compiler/lua54.lpt:583
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:584
local id = lua(t[1][i][1]) -- ./compiler/lua54.lpt:585
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:586
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.lpt:587
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:588
r = r .. (", " .. id) -- ./compiler/lua54.lpt:589
else -- ./compiler/lua54.lpt:589
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
r = r .. (")" .. indent()) -- ./compiler/lua54.lpt:595
for _, d in ipairs(decl) do -- ./compiler/lua54.lpt:596
r = r .. (d .. newline()) -- ./compiler/lua54.lpt:597
end -- ./compiler/lua54.lpt:597
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.lpt:599
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.lpt:600
end -- ./compiler/lua54.lpt:600
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.lpt:602
if hasPush then -- ./compiler/lua54.lpt:603
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:604
else -- ./compiler/lua54.lpt:604
push("push", false) -- ./compiler/lua54.lpt:606
end -- ./compiler/lua54.lpt:606
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:608
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:609
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:610
end -- ./compiler/lua54.lpt:610
pop("push") -- ./compiler/lua54.lpt:612
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:613
end, -- ./compiler/lua54.lpt:613
["Function"] = function(t) -- ./compiler/lua54.lpt:615
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.lpt:616
end, -- ./compiler/lua54.lpt:616
["Pair"] = function(t) -- ./compiler/lua54.lpt:619
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.lpt:620
end, -- ./compiler/lua54.lpt:620
["Table"] = function(t) -- ./compiler/lua54.lpt:622
if # t == 0 then -- ./compiler/lua54.lpt:623
return "{}" -- ./compiler/lua54.lpt:624
elseif # t == 1 then -- ./compiler/lua54.lpt:625
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.lpt:626
else -- ./compiler/lua54.lpt:626
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.lpt:628
end -- ./compiler/lua54.lpt:628
end, -- ./compiler/lua54.lpt:628
["TableCompr"] = function(t) -- ./compiler/lua54.lpt:632
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.lpt:633
end, -- ./compiler/lua54.lpt:633
["Op"] = function(t) -- ./compiler/lua54.lpt:636
local r -- ./compiler/lua54.lpt:637
if # t == 2 then -- ./compiler/lua54.lpt:638
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:639
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.lpt:640
else -- ./compiler/lua54.lpt:640
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.lpt:642
end -- ./compiler/lua54.lpt:642
else -- ./compiler/lua54.lpt:642
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:645
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.lpt:646
else -- ./compiler/lua54.lpt:646
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.lpt:648
end -- ./compiler/lua54.lpt:648
end -- ./compiler/lua54.lpt:648
return r -- ./compiler/lua54.lpt:651
end, -- ./compiler/lua54.lpt:651
["Paren"] = function(t) -- ./compiler/lua54.lpt:654
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.lpt:655
end, -- ./compiler/lua54.lpt:655
["MethodStub"] = function(t) -- ./compiler/lua54.lpt:658
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:664
end, -- ./compiler/lua54.lpt:664
["SafeMethodStub"] = function(t) -- ./compiler/lua54.lpt:667
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:674
end, -- ./compiler/lua54.lpt:674
["LetExpr"] = function(t) -- ./compiler/lua54.lpt:681
return lua(t[1][1]) -- ./compiler/lua54.lpt:682
end, -- ./compiler/lua54.lpt:682
["_statexpr"] = function(t, stat) -- ./compiler/lua54.lpt:686
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.lpt:687
local r = "(function()" .. indent() -- ./compiler/lua54.lpt:688
if hasPush then -- ./compiler/lua54.lpt:689
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:690
else -- ./compiler/lua54.lpt:690
push("push", false) -- ./compiler/lua54.lpt:692
end -- ./compiler/lua54.lpt:692
r = r .. (lua(t, stat)) -- ./compiler/lua54.lpt:694
if hasPush then -- ./compiler/lua54.lpt:695
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:696
end -- ./compiler/lua54.lpt:696
pop("push") -- ./compiler/lua54.lpt:698
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.lpt:699
return r -- ./compiler/lua54.lpt:700
end, -- ./compiler/lua54.lpt:700
["DoExpr"] = function(t) -- ./compiler/lua54.lpt:703
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.lpt:704
t[# t]["tag"] = "Return" -- ./compiler/lua54.lpt:705
end -- ./compiler/lua54.lpt:705
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.lpt:707
end, -- ./compiler/lua54.lpt:707
["WhileExpr"] = function(t) -- ./compiler/lua54.lpt:710
return lua(t, "_statexpr", "While") -- ./compiler/lua54.lpt:711
end, -- ./compiler/lua54.lpt:711
["RepeatExpr"] = function(t) -- ./compiler/lua54.lpt:714
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.lpt:715
end, -- ./compiler/lua54.lpt:715
["IfExpr"] = function(t) -- ./compiler/lua54.lpt:718
for i = 2, # t do -- ./compiler/lua54.lpt:719
local block = t[i] -- ./compiler/lua54.lpt:720
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.lpt:721
block[# block]["tag"] = "Return" -- ./compiler/lua54.lpt:722
end -- ./compiler/lua54.lpt:722
end -- ./compiler/lua54.lpt:722
return lua(t, "_statexpr", "If") -- ./compiler/lua54.lpt:725
end, -- ./compiler/lua54.lpt:725
["FornumExpr"] = function(t) -- ./compiler/lua54.lpt:728
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.lpt:729
end, -- ./compiler/lua54.lpt:729
["ForinExpr"] = function(t) -- ./compiler/lua54.lpt:732
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.lpt:733
end, -- ./compiler/lua54.lpt:733
["Call"] = function(t) -- ./compiler/lua54.lpt:739
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:740
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:741
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.lpt:742
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.lpt:743
local replacement = macro["replacement"] -- ./compiler/lua54.lpt:744
local r -- ./compiler/lua54.lpt:745
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.lpt:746
if type(replacement) == "function" then -- ./compiler/lua54.lpt:747
local args = {} -- ./compiler/lua54.lpt:748
for i = 2, # t do -- ./compiler/lua54.lpt:749
table["insert"](args, lua(t[i])) -- ./compiler/lua54.lpt:750
end -- ./compiler/lua54.lpt:750
r = replacement(unpack(args)) -- ./compiler/lua54.lpt:752
else -- ./compiler/lua54.lpt:752
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.lpt:754
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.lpt:755
if arg["tag"] == "Dots" then -- ./compiler/lua54.lpt:756
macroargs["..."] = (function() -- ./compiler/lua54.lpt:757
local self = {} -- ./compiler/lua54.lpt:757
for j = i + 1, # t do -- ./compiler/lua54.lpt:757
self[#self+1] = t[j] -- ./compiler/lua54.lpt:757
end -- ./compiler/lua54.lpt:757
return self -- ./compiler/lua54.lpt:757
end)() -- ./compiler/lua54.lpt:757
elseif arg["tag"] == "Id" then -- ./compiler/lua54.lpt:758
if t[i + 1] == nil then -- ./compiler/lua54.lpt:759
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.lpt:760
end -- ./compiler/lua54.lpt:760
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.lpt:762
else -- ./compiler/lua54.lpt:762
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.lpt:764
end -- ./compiler/lua54.lpt:764
end -- ./compiler/lua54.lpt:764
push("macroargs", macroargs) -- ./compiler/lua54.lpt:767
r = lua(replacement) -- ./compiler/lua54.lpt:768
pop("macroargs") -- ./compiler/lua54.lpt:769
end -- ./compiler/lua54.lpt:769
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.lpt:771
return r -- ./compiler/lua54.lpt:772
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.lpt:773
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.lpt:774
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:775
else -- ./compiler/lua54.lpt:775
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:777
end -- ./compiler/lua54.lpt:777
else -- ./compiler/lua54.lpt:777
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:780
end -- ./compiler/lua54.lpt:780
end, -- ./compiler/lua54.lpt:780
["SafeCall"] = function(t) -- ./compiler/lua54.lpt:784
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:785
return lua(t, "SafeIndex") -- ./compiler/lua54.lpt:786
else -- ./compiler/lua54.lpt:786
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.lpt:788
end -- ./compiler/lua54.lpt:788
end, -- ./compiler/lua54.lpt:788
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.lpt:793
if start == nil then start = 1 end -- ./compiler/lua54.lpt:793
local r -- ./compiler/lua54.lpt:794
if t[start] then -- ./compiler/lua54.lpt:795
r = lua(t[start]) -- ./compiler/lua54.lpt:796
for i = start + 1, # t, 1 do -- ./compiler/lua54.lpt:797
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.lpt:798
end -- ./compiler/lua54.lpt:798
else -- ./compiler/lua54.lpt:798
r = "" -- ./compiler/lua54.lpt:801
end -- ./compiler/lua54.lpt:801
return r -- ./compiler/lua54.lpt:803
end, -- ./compiler/lua54.lpt:803
["Id"] = function(t) -- ./compiler/lua54.lpt:806
local r = t[1] -- ./compiler/lua54.lpt:807
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:808
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.lpt:809
nomacro["variables"][t[1]] = true -- ./compiler/lua54.lpt:810
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.lpt:811
r = lua(macroargs[t[1]]) -- ./compiler/lua54.lpt:812
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.lpt:813
local macro = macros["variables"][t[1]] -- ./compiler/lua54.lpt:814
if type(macro) == "function" then -- ./compiler/lua54.lpt:815
r = macro() -- ./compiler/lua54.lpt:816
else -- ./compiler/lua54.lpt:816
r = lua(macro) -- ./compiler/lua54.lpt:818
end -- ./compiler/lua54.lpt:818
end -- ./compiler/lua54.lpt:818
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.lpt:821
end -- ./compiler/lua54.lpt:821
return r -- ./compiler/lua54.lpt:823
end, -- ./compiler/lua54.lpt:823
["AttributeId"] = function(t) -- ./compiler/lua54.lpt:826
if t[2] then -- ./compiler/lua54.lpt:827
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.lpt:828
else -- ./compiler/lua54.lpt:828
return t[1] -- ./compiler/lua54.lpt:830
end -- ./compiler/lua54.lpt:830
end, -- ./compiler/lua54.lpt:830
["DestructuringId"] = function(t) -- ./compiler/lua54.lpt:834
if t["id"] then -- ./compiler/lua54.lpt:835
return t["id"] -- ./compiler/lua54.lpt:836
else -- ./compiler/lua54.lpt:836
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.lpt:838
local vars = { ["id"] = tmp() } -- ./compiler/lua54.lpt:839
for j = 1, # t, 1 do -- ./compiler/lua54.lpt:840
table["insert"](vars, t[j]) -- ./compiler/lua54.lpt:841
end -- ./compiler/lua54.lpt:841
table["insert"](d, vars) -- ./compiler/lua54.lpt:843
t["id"] = vars["id"] -- ./compiler/lua54.lpt:844
return vars["id"] -- ./compiler/lua54.lpt:845
end -- ./compiler/lua54.lpt:845
end, -- ./compiler/lua54.lpt:845
["Index"] = function(t) -- ./compiler/lua54.lpt:849
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:850
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:851
else -- ./compiler/lua54.lpt:851
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:853
end -- ./compiler/lua54.lpt:853
end, -- ./compiler/lua54.lpt:853
["SafeIndex"] = function(t) -- ./compiler/lua54.lpt:857
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:858
local l = {} -- ./compiler/lua54.lpt:859
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.lpt:860
table["insert"](l, 1, t) -- ./compiler/lua54.lpt:861
t = t[1] -- ./compiler/lua54.lpt:862
end -- ./compiler/lua54.lpt:862
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.lpt:864
for _, e in ipairs(l) do -- ./compiler/lua54.lpt:865
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.lpt:866
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.lpt:867
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.lpt:868
else -- ./compiler/lua54.lpt:868
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.lpt:870
end -- ./compiler/lua54.lpt:870
end -- ./compiler/lua54.lpt:870
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.lpt:873
return r -- ./compiler/lua54.lpt:874
else -- ./compiler/lua54.lpt:874
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.lpt:876
end -- ./compiler/lua54.lpt:876
end, -- ./compiler/lua54.lpt:876
["_opid"] = { -- ./compiler/lua54.lpt:881
["add"] = "+", -- ./compiler/lua54.lpt:882
["sub"] = "-", -- ./compiler/lua54.lpt:882
["mul"] = "*", -- ./compiler/lua54.lpt:882
["div"] = "/", -- ./compiler/lua54.lpt:882
["idiv"] = "//", -- ./compiler/lua54.lpt:883
["mod"] = "%", -- ./compiler/lua54.lpt:883
["pow"] = "^", -- ./compiler/lua54.lpt:883
["concat"] = "..", -- ./compiler/lua54.lpt:883
["band"] = "&", -- ./compiler/lua54.lpt:884
["bor"] = "|", -- ./compiler/lua54.lpt:884
["bxor"] = "~", -- ./compiler/lua54.lpt:884
["shl"] = "<<", -- ./compiler/lua54.lpt:884
["shr"] = ">>", -- ./compiler/lua54.lpt:884
["eq"] = "==", -- ./compiler/lua54.lpt:885
["ne"] = "~=", -- ./compiler/lua54.lpt:885
["lt"] = "<", -- ./compiler/lua54.lpt:885
["gt"] = ">", -- ./compiler/lua54.lpt:885
["le"] = "<=", -- ./compiler/lua54.lpt:885
["ge"] = ">=", -- ./compiler/lua54.lpt:885
["and"] = "and", -- ./compiler/lua54.lpt:886
["or"] = "or", -- ./compiler/lua54.lpt:886
["unm"] = "-", -- ./compiler/lua54.lpt:886
["len"] = "#", -- ./compiler/lua54.lpt:886
["bnot"] = "~", -- ./compiler/lua54.lpt:886
["not"] = "not" -- ./compiler/lua54.lpt:886
} -- ./compiler/lua54.lpt:886
}, { ["__index"] = function(self, key) -- ./compiler/lua54.lpt:889
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.lpt:890
end }) -- ./compiler/lua54.lpt:890
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
local code = lua(ast) .. newline() -- ./compiler/lua54.lpt:896
return requireStr .. code -- ./compiler/lua54.lpt:897
end -- ./compiler/lua54.lpt:897
end -- ./compiler/lua54.lpt:897
local lua54 = _() or lua54 -- ./compiler/lua54.lpt:902
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
local indentLevel = 0 -- ./compiler/lua54.lpt:15
local function newline() -- ./compiler/lua54.lpt:17
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.lpt:18
if options["mapLines"] then -- ./compiler/lua54.lpt:19
local sub = code:sub(lastInputPos) -- ./compiler/lua54.lpt:20
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.lpt:21
if source and line then -- ./compiler/lua54.lpt:23
lastSource = source -- ./compiler/lua54.lpt:24
lastLine = tonumber(line) -- ./compiler/lua54.lpt:25
else -- ./compiler/lua54.lpt:25
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.lpt:27
lastLine = lastLine + (1) -- ./compiler/lua54.lpt:28
end -- ./compiler/lua54.lpt:28
end -- ./compiler/lua54.lpt:28
prevLinePos = lastInputPos -- ./compiler/lua54.lpt:32
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.lpt:34
end -- ./compiler/lua54.lpt:34
return r -- ./compiler/lua54.lpt:36
end -- ./compiler/lua54.lpt:36
local function indent() -- ./compiler/lua54.lpt:39
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:40
return newline() -- ./compiler/lua54.lpt:41
end -- ./compiler/lua54.lpt:41
local function unindent() -- ./compiler/lua54.lpt:44
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:45
return newline() -- ./compiler/lua54.lpt:46
end -- ./compiler/lua54.lpt:46
local states = { -- ./compiler/lua54.lpt:51
["push"] = {}, -- ./compiler/lua54.lpt:52
["destructuring"] = {}, -- ./compiler/lua54.lpt:53
["scope"] = {}, -- ./compiler/lua54.lpt:54
["macroargs"] = {} -- ./compiler/lua54.lpt:55
} -- ./compiler/lua54.lpt:55
local function push(name, state) -- ./compiler/lua54.lpt:58
table["insert"](states[name], state) -- ./compiler/lua54.lpt:59
return "" -- ./compiler/lua54.lpt:60
end -- ./compiler/lua54.lpt:60
local function pop(name) -- ./compiler/lua54.lpt:63
table["remove"](states[name]) -- ./compiler/lua54.lpt:64
return "" -- ./compiler/lua54.lpt:65
end -- ./compiler/lua54.lpt:65
local function set(name, state) -- ./compiler/lua54.lpt:68
states[name][# states[name]] = state -- ./compiler/lua54.lpt:69
return "" -- ./compiler/lua54.lpt:70
end -- ./compiler/lua54.lpt:70
local function peek(name) -- ./compiler/lua54.lpt:73
return states[name][# states[name]] -- ./compiler/lua54.lpt:74
end -- ./compiler/lua54.lpt:74
local function var(name) -- ./compiler/lua54.lpt:79
return options["variablePrefix"] .. name -- ./compiler/lua54.lpt:80
end -- ./compiler/lua54.lpt:80
local function tmp() -- ./compiler/lua54.lpt:84
local scope = peek("scope") -- ./compiler/lua54.lpt:85
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.lpt:86
table["insert"](scope, var) -- ./compiler/lua54.lpt:87
return var -- ./compiler/lua54.lpt:88
end -- ./compiler/lua54.lpt:88
local nomacro = { -- ./compiler/lua54.lpt:92
["variables"] = {}, -- ./compiler/lua54.lpt:92
["functions"] = {} -- ./compiler/lua54.lpt:92
} -- ./compiler/lua54.lpt:92
local required = {} -- ./compiler/lua54.lpt:95
local requireStr = "" -- ./compiler/lua54.lpt:96
local function addRequire(mod, name, field) -- ./compiler/lua54.lpt:98
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.lpt:99
if not required[req] then -- ./compiler/lua54.lpt:100
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.lpt:101
required[req] = true -- ./compiler/lua54.lpt:102
end -- ./compiler/lua54.lpt:102
end -- ./compiler/lua54.lpt:102
local loop = { -- ./compiler/lua54.lpt:107
"While", -- ./compiler/lua54.lpt:107
"Repeat", -- ./compiler/lua54.lpt:107
"Fornum", -- ./compiler/lua54.lpt:107
"Forin", -- ./compiler/lua54.lpt:107
"WhileExpr", -- ./compiler/lua54.lpt:107
"RepeatExpr", -- ./compiler/lua54.lpt:107
"FornumExpr", -- ./compiler/lua54.lpt:107
"ForinExpr" -- ./compiler/lua54.lpt:107
} -- ./compiler/lua54.lpt:107
local func = { -- ./compiler/lua54.lpt:108
"Function", -- ./compiler/lua54.lpt:108
"TableCompr", -- ./compiler/lua54.lpt:108
"DoExpr", -- ./compiler/lua54.lpt:108
"WhileExpr", -- ./compiler/lua54.lpt:108
"RepeatExpr", -- ./compiler/lua54.lpt:108
"IfExpr", -- ./compiler/lua54.lpt:108
"FornumExpr", -- ./compiler/lua54.lpt:108
"ForinExpr" -- ./compiler/lua54.lpt:108
} -- ./compiler/lua54.lpt:108
local function any(list, tags, nofollow) -- ./compiler/lua54.lpt:112
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:112
local tagsCheck = {} -- ./compiler/lua54.lpt:113
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:114
tagsCheck[tag] = true -- ./compiler/lua54.lpt:115
end -- ./compiler/lua54.lpt:115
local nofollowCheck = {} -- ./compiler/lua54.lpt:117
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:118
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:119
end -- ./compiler/lua54.lpt:119
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:121
if type(node) == "table" then -- ./compiler/lua54.lpt:122
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:123
return node -- ./compiler/lua54.lpt:124
end -- ./compiler/lua54.lpt:124
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:126
local r = any(node, tags, nofollow) -- ./compiler/lua54.lpt:127
if r then -- ./compiler/lua54.lpt:128
return r -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
return nil -- ./compiler/lua54.lpt:132
end -- ./compiler/lua54.lpt:132
local function search(list, tags, nofollow) -- ./compiler/lua54.lpt:137
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:137
local tagsCheck = {} -- ./compiler/lua54.lpt:138
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:139
tagsCheck[tag] = true -- ./compiler/lua54.lpt:140
end -- ./compiler/lua54.lpt:140
local nofollowCheck = {} -- ./compiler/lua54.lpt:142
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:143
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:144
end -- ./compiler/lua54.lpt:144
local found = {} -- ./compiler/lua54.lpt:146
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:147
if type(node) == "table" then -- ./compiler/lua54.lpt:148
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:149
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.lpt:150
table["insert"](found, n) -- ./compiler/lua54.lpt:151
end -- ./compiler/lua54.lpt:151
end -- ./compiler/lua54.lpt:151
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:154
table["insert"](found, node) -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
return found -- ./compiler/lua54.lpt:159
end -- ./compiler/lua54.lpt:159
local function all(list, tags) -- ./compiler/lua54.lpt:163
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:164
local ok = false -- ./compiler/lua54.lpt:165
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:166
if node["tag"] == tag then -- ./compiler/lua54.lpt:167
ok = true -- ./compiler/lua54.lpt:168
break -- ./compiler/lua54.lpt:169
end -- ./compiler/lua54.lpt:169
end -- ./compiler/lua54.lpt:169
if not ok then -- ./compiler/lua54.lpt:172
return false -- ./compiler/lua54.lpt:173
end -- ./compiler/lua54.lpt:173
end -- ./compiler/lua54.lpt:173
return true -- ./compiler/lua54.lpt:176
end -- ./compiler/lua54.lpt:176
local tags -- ./compiler/lua54.lpt:180
local function lua(ast, forceTag, ...) -- ./compiler/lua54.lpt:182
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.lpt:183
lastInputPos = ast["pos"] -- ./compiler/lua54.lpt:184
end -- ./compiler/lua54.lpt:184
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.lpt:186
end -- ./compiler/lua54.lpt:186
local UNPACK = function(list, i, j) -- ./compiler/lua54.lpt:190
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.lpt:191
end -- ./compiler/lua54.lpt:191
local APPEND = function(t, toAppend) -- ./compiler/lua54.lpt:193
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.lpt:194
end -- ./compiler/lua54.lpt:194
local CONTINUE_START = function() -- ./compiler/lua54.lpt:196
return "do" .. indent() -- ./compiler/lua54.lpt:197
end -- ./compiler/lua54.lpt:197
local CONTINUE_STOP = function() -- ./compiler/lua54.lpt:199
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.lpt:200
end -- ./compiler/lua54.lpt:200
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.lpt:202
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.lpt:202
if noLocal == nil then noLocal = false end -- ./compiler/lua54.lpt:202
local vars = {} -- ./compiler/lua54.lpt:203
local values = {} -- ./compiler/lua54.lpt:204
for _, list in ipairs(destructured) do -- ./compiler/lua54.lpt:205
for _, v in ipairs(list) do -- ./compiler/lua54.lpt:206
local var, val -- ./compiler/lua54.lpt:207
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.lpt:208
var = v -- ./compiler/lua54.lpt:209
val = { -- ./compiler/lua54.lpt:210
["tag"] = "Index", -- ./compiler/lua54.lpt:210
{ -- ./compiler/lua54.lpt:210
["tag"] = "Id", -- ./compiler/lua54.lpt:210
list["id"] -- ./compiler/lua54.lpt:210
}, -- ./compiler/lua54.lpt:210
{ -- ./compiler/lua54.lpt:210
["tag"] = "String", -- ./compiler/lua54.lpt:210
v[1] -- ./compiler/lua54.lpt:210
} -- ./compiler/lua54.lpt:210
} -- ./compiler/lua54.lpt:210
elseif v["tag"] == "Pair" then -- ./compiler/lua54.lpt:211
var = v[2] -- ./compiler/lua54.lpt:212
val = { -- ./compiler/lua54.lpt:213
["tag"] = "Index", -- ./compiler/lua54.lpt:213
{ -- ./compiler/lua54.lpt:213
["tag"] = "Id", -- ./compiler/lua54.lpt:213
list["id"] -- ./compiler/lua54.lpt:213
}, -- ./compiler/lua54.lpt:213
v[1] -- ./compiler/lua54.lpt:213
} -- ./compiler/lua54.lpt:213
else -- ./compiler/lua54.lpt:213
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.lpt:215
end -- ./compiler/lua54.lpt:215
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.lpt:217
val = { -- ./compiler/lua54.lpt:218
["tag"] = "Op", -- ./compiler/lua54.lpt:218
destructured["rightOp"], -- ./compiler/lua54.lpt:218
var, -- ./compiler/lua54.lpt:218
{ -- ./compiler/lua54.lpt:218
["tag"] = "Op", -- ./compiler/lua54.lpt:218
destructured["leftOp"], -- ./compiler/lua54.lpt:218
val, -- ./compiler/lua54.lpt:218
var -- ./compiler/lua54.lpt:218
} -- ./compiler/lua54.lpt:218
} -- ./compiler/lua54.lpt:218
elseif destructured["rightOp"] then -- ./compiler/lua54.lpt:219
val = { -- ./compiler/lua54.lpt:220
["tag"] = "Op", -- ./compiler/lua54.lpt:220
destructured["rightOp"], -- ./compiler/lua54.lpt:220
var, -- ./compiler/lua54.lpt:220
val -- ./compiler/lua54.lpt:220
} -- ./compiler/lua54.lpt:220
elseif destructured["leftOp"] then -- ./compiler/lua54.lpt:221
val = { -- ./compiler/lua54.lpt:222
["tag"] = "Op", -- ./compiler/lua54.lpt:222
destructured["leftOp"], -- ./compiler/lua54.lpt:222
val, -- ./compiler/lua54.lpt:222
var -- ./compiler/lua54.lpt:222
} -- ./compiler/lua54.lpt:222
end -- ./compiler/lua54.lpt:222
table["insert"](vars, lua(var)) -- ./compiler/lua54.lpt:224
table["insert"](values, lua(val)) -- ./compiler/lua54.lpt:225
end -- ./compiler/lua54.lpt:225
end -- ./compiler/lua54.lpt:225
if # vars > 0 then -- ./compiler/lua54.lpt:228
local decl = noLocal and "" or "local " -- ./compiler/lua54.lpt:229
if newlineAfter then -- ./compiler/lua54.lpt:230
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.lpt:231
else -- ./compiler/lua54.lpt:231
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.lpt:233
end -- ./compiler/lua54.lpt:233
else -- ./compiler/lua54.lpt:233
return "" -- ./compiler/lua54.lpt:236
end -- ./compiler/lua54.lpt:236
end -- ./compiler/lua54.lpt:236
tags = setmetatable({ -- ./compiler/lua54.lpt:241
["Block"] = function(t) -- ./compiler/lua54.lpt:243
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.lpt:244
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.lpt:245
hasPush["tag"] = "Return" -- ./compiler/lua54.lpt:246
hasPush = false -- ./compiler/lua54.lpt:247
end -- ./compiler/lua54.lpt:247
local r = push("scope", {}) -- ./compiler/lua54.lpt:249
if hasPush then -- ./compiler/lua54.lpt:250
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:251
end -- ./compiler/lua54.lpt:251
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:253
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:254
end -- ./compiler/lua54.lpt:254
if t[# t] then -- ./compiler/lua54.lpt:256
r = r .. (lua(t[# t])) -- ./compiler/lua54.lpt:257
end -- ./compiler/lua54.lpt:257
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:259
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
return r .. pop("scope") -- ./compiler/lua54.lpt:262
end, -- ./compiler/lua54.lpt:262
["Do"] = function(t) -- ./compiler/lua54.lpt:268
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.lpt:269
end, -- ./compiler/lua54.lpt:269
["Set"] = function(t) -- ./compiler/lua54.lpt:272
local expr = t[# t] -- ./compiler/lua54.lpt:274
local vars, values = {}, {} -- ./compiler/lua54.lpt:275
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.lpt:276
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:277
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.lpt:278
table["insert"](destructuringVars, n) -- ./compiler/lua54.lpt:279
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.lpt:280
else -- ./compiler/lua54.lpt:280
table["insert"](vars, n) -- ./compiler/lua54.lpt:282
table["insert"](values, expr[i]) -- ./compiler/lua54.lpt:283
end -- ./compiler/lua54.lpt:283
end -- ./compiler/lua54.lpt:283
if # t == 2 or # t == 3 then -- ./compiler/lua54.lpt:287
local r = "" -- ./compiler/lua54.lpt:288
if # vars > 0 then -- ./compiler/lua54.lpt:289
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.lpt:290
end -- ./compiler/lua54.lpt:290
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:292
local destructured = {} -- ./compiler/lua54.lpt:293
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:294
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:295
end -- ./compiler/lua54.lpt:295
return r -- ./compiler/lua54.lpt:297
elseif # t == 4 then -- ./compiler/lua54.lpt:298
if t[3] == "=" then -- ./compiler/lua54.lpt:299
local r = "" -- ./compiler/lua54.lpt:300
if # vars > 0 then -- ./compiler/lua54.lpt:301
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:302
t[2], -- ./compiler/lua54.lpt:302
vars[1], -- ./compiler/lua54.lpt:302
{ -- ./compiler/lua54.lpt:302
["tag"] = "Paren", -- ./compiler/lua54.lpt:302
values[1] -- ./compiler/lua54.lpt:302
} -- ./compiler/lua54.lpt:302
}, "Op")) -- ./compiler/lua54.lpt:302
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.lpt:303
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:304
t[2], -- ./compiler/lua54.lpt:304
vars[i], -- ./compiler/lua54.lpt:304
{ -- ./compiler/lua54.lpt:304
["tag"] = "Paren", -- ./compiler/lua54.lpt:304
values[i] -- ./compiler/lua54.lpt:304
} -- ./compiler/lua54.lpt:304
}, "Op")) -- ./compiler/lua54.lpt:304
end -- ./compiler/lua54.lpt:304
end -- ./compiler/lua54.lpt:304
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:307
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.lpt:308
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:309
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:310
end -- ./compiler/lua54.lpt:310
return r -- ./compiler/lua54.lpt:312
else -- ./compiler/lua54.lpt:312
local r = "" -- ./compiler/lua54.lpt:314
if # vars > 0 then -- ./compiler/lua54.lpt:315
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:316
t[3], -- ./compiler/lua54.lpt:316
{ -- ./compiler/lua54.lpt:316
["tag"] = "Paren", -- ./compiler/lua54.lpt:316
values[1] -- ./compiler/lua54.lpt:316
}, -- ./compiler/lua54.lpt:316
vars[1] -- ./compiler/lua54.lpt:316
}, "Op")) -- ./compiler/lua54.lpt:316
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.lpt:317
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:318
t[3], -- ./compiler/lua54.lpt:318
{ -- ./compiler/lua54.lpt:318
["tag"] = "Paren", -- ./compiler/lua54.lpt:318
values[i] -- ./compiler/lua54.lpt:318
}, -- ./compiler/lua54.lpt:318
vars[i] -- ./compiler/lua54.lpt:318
}, "Op")) -- ./compiler/lua54.lpt:318
end -- ./compiler/lua54.lpt:318
end -- ./compiler/lua54.lpt:318
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:321
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.lpt:322
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:323
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:324
end -- ./compiler/lua54.lpt:324
return r -- ./compiler/lua54.lpt:326
end -- ./compiler/lua54.lpt:326
else -- ./compiler/lua54.lpt:326
local r = "" -- ./compiler/lua54.lpt:329
if # vars > 0 then -- ./compiler/lua54.lpt:330
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:331
t[2], -- ./compiler/lua54.lpt:331
vars[1], -- ./compiler/lua54.lpt:331
{ -- ./compiler/lua54.lpt:331
["tag"] = "Op", -- ./compiler/lua54.lpt:331
t[4], -- ./compiler/lua54.lpt:331
{ -- ./compiler/lua54.lpt:331
["tag"] = "Paren", -- ./compiler/lua54.lpt:331
values[1] -- ./compiler/lua54.lpt:331
}, -- ./compiler/lua54.lpt:331
vars[1] -- ./compiler/lua54.lpt:331
} -- ./compiler/lua54.lpt:331
}, "Op")) -- ./compiler/lua54.lpt:331
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.lpt:332
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:333
t[2], -- ./compiler/lua54.lpt:333
vars[i], -- ./compiler/lua54.lpt:333
{ -- ./compiler/lua54.lpt:333
["tag"] = "Op", -- ./compiler/lua54.lpt:333
t[4], -- ./compiler/lua54.lpt:333
{ -- ./compiler/lua54.lpt:333
["tag"] = "Paren", -- ./compiler/lua54.lpt:333
values[i] -- ./compiler/lua54.lpt:333
}, -- ./compiler/lua54.lpt:333
vars[i] -- ./compiler/lua54.lpt:333
} -- ./compiler/lua54.lpt:333
}, "Op")) -- ./compiler/lua54.lpt:333
end -- ./compiler/lua54.lpt:333
end -- ./compiler/lua54.lpt:333
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:336
local destructured = { -- ./compiler/lua54.lpt:337
["rightOp"] = t[2], -- ./compiler/lua54.lpt:337
["leftOp"] = t[4] -- ./compiler/lua54.lpt:337
} -- ./compiler/lua54.lpt:337
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:338
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:339
end -- ./compiler/lua54.lpt:339
return r -- ./compiler/lua54.lpt:341
end -- ./compiler/lua54.lpt:341
end, -- ./compiler/lua54.lpt:341
["While"] = function(t) -- ./compiler/lua54.lpt:345
local r = "" -- ./compiler/lua54.lpt:346
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.lpt:347
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:348
if # lets > 0 then -- ./compiler/lua54.lpt:349
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:350
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:351
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:352
end -- ./compiler/lua54.lpt:352
end -- ./compiler/lua54.lpt:352
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.lpt:355
if # lets > 0 then -- ./compiler/lua54.lpt:356
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:357
end -- ./compiler/lua54.lpt:357
if hasContinue then -- ./compiler/lua54.lpt:359
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:360
end -- ./compiler/lua54.lpt:360
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:362
if hasContinue then -- ./compiler/lua54.lpt:363
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:364
end -- ./compiler/lua54.lpt:364
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:366
if # lets > 0 then -- ./compiler/lua54.lpt:367
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:368
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.lpt:369
end -- ./compiler/lua54.lpt:369
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.lpt:371
end -- ./compiler/lua54.lpt:371
return r -- ./compiler/lua54.lpt:373
end, -- ./compiler/lua54.lpt:373
["Repeat"] = function(t) -- ./compiler/lua54.lpt:376
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.lpt:377
local r = "repeat" .. indent() -- ./compiler/lua54.lpt:378
if hasContinue then -- ./compiler/lua54.lpt:379
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:380
end -- ./compiler/lua54.lpt:380
r = r .. (lua(t[1])) -- ./compiler/lua54.lpt:382
if hasContinue then -- ./compiler/lua54.lpt:383
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:384
end -- ./compiler/lua54.lpt:384
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.lpt:386
return r -- ./compiler/lua54.lpt:387
end, -- ./compiler/lua54.lpt:387
["If"] = function(t) -- ./compiler/lua54.lpt:390
local r = "" -- ./compiler/lua54.lpt:391
local toClose = 0 -- ./compiler/lua54.lpt:392
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:393
if # lets > 0 then -- ./compiler/lua54.lpt:394
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:395
toClose = toClose + (1) -- ./compiler/lua54.lpt:396
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:397
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:398
end -- ./compiler/lua54.lpt:398
end -- ./compiler/lua54.lpt:398
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.lpt:401
for i = 3, # t - 1, 2 do -- ./compiler/lua54.lpt:402
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.lpt:403
if # lets > 0 then -- ./compiler/lua54.lpt:404
r = r .. ("else" .. indent()) -- ./compiler/lua54.lpt:405
toClose = toClose + (1) -- ./compiler/lua54.lpt:406
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:407
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:408
end -- ./compiler/lua54.lpt:408
else -- ./compiler/lua54.lpt:408
r = r .. ("else") -- ./compiler/lua54.lpt:411
end -- ./compiler/lua54.lpt:411
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.lpt:413
end -- ./compiler/lua54.lpt:413
if # t % 2 == 1 then -- ./compiler/lua54.lpt:415
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.lpt:416
end -- ./compiler/lua54.lpt:416
r = r .. ("end") -- ./compiler/lua54.lpt:418
for i = 1, toClose do -- ./compiler/lua54.lpt:419
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:420
end -- ./compiler/lua54.lpt:420
return r -- ./compiler/lua54.lpt:422
end, -- ./compiler/lua54.lpt:422
["Fornum"] = function(t) -- ./compiler/lua54.lpt:425
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.lpt:426
if # t == 5 then -- ./compiler/lua54.lpt:427
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.lpt:428
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.lpt:429
if hasContinue then -- ./compiler/lua54.lpt:430
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:431
end -- ./compiler/lua54.lpt:431
r = r .. (lua(t[5])) -- ./compiler/lua54.lpt:433
if hasContinue then -- ./compiler/lua54.lpt:434
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:435
end -- ./compiler/lua54.lpt:435
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:437
else -- ./compiler/lua54.lpt:437
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.lpt:439
r = r .. (" do" .. indent()) -- ./compiler/lua54.lpt:440
if hasContinue then -- ./compiler/lua54.lpt:441
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:442
end -- ./compiler/lua54.lpt:442
r = r .. (lua(t[4])) -- ./compiler/lua54.lpt:444
if hasContinue then -- ./compiler/lua54.lpt:445
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:446
end -- ./compiler/lua54.lpt:446
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:448
end -- ./compiler/lua54.lpt:448
end, -- ./compiler/lua54.lpt:448
["Forin"] = function(t) -- ./compiler/lua54.lpt:452
local destructured = {} -- ./compiler/lua54.lpt:453
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.lpt:454
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.lpt:455
if hasContinue then -- ./compiler/lua54.lpt:456
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:457
end -- ./compiler/lua54.lpt:457
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.lpt:459
if hasContinue then -- ./compiler/lua54.lpt:460
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:461
end -- ./compiler/lua54.lpt:461
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:463
end, -- ./compiler/lua54.lpt:463
["Local"] = function(t) -- ./compiler/lua54.lpt:466
local destructured = {} -- ./compiler/lua54.lpt:467
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:468
if t[2][1] then -- ./compiler/lua54.lpt:469
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:470
end -- ./compiler/lua54.lpt:470
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:472
end, -- ./compiler/lua54.lpt:472
["Let"] = function(t) -- ./compiler/lua54.lpt:475
local destructured = {} -- ./compiler/lua54.lpt:476
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:477
local r = "local " .. nameList -- ./compiler/lua54.lpt:478
if t[2][1] then -- ./compiler/lua54.lpt:479
if all(t[2], { -- ./compiler/lua54.lpt:480
"Nil", -- ./compiler/lua54.lpt:480
"Dots", -- ./compiler/lua54.lpt:480
"Boolean", -- ./compiler/lua54.lpt:480
"Number", -- ./compiler/lua54.lpt:480
"String" -- ./compiler/lua54.lpt:480
}) then -- ./compiler/lua54.lpt:480
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:481
else -- ./compiler/lua54.lpt:481
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:483
end -- ./compiler/lua54.lpt:483
end -- ./compiler/lua54.lpt:483
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:486
end, -- ./compiler/lua54.lpt:486
["Localrec"] = function(t) -- ./compiler/lua54.lpt:489
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.lpt:490
end, -- ./compiler/lua54.lpt:490
["Goto"] = function(t) -- ./compiler/lua54.lpt:493
return "goto " .. lua(t, "Id") -- ./compiler/lua54.lpt:494
end, -- ./compiler/lua54.lpt:494
["Label"] = function(t) -- ./compiler/lua54.lpt:497
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.lpt:498
end, -- ./compiler/lua54.lpt:498
["Return"] = function(t) -- ./compiler/lua54.lpt:501
local push = peek("push") -- ./compiler/lua54.lpt:502
if push then -- ./compiler/lua54.lpt:503
local r = "" -- ./compiler/lua54.lpt:504
for _, val in ipairs(t) do -- ./compiler/lua54.lpt:505
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.lpt:506
end -- ./compiler/lua54.lpt:506
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.lpt:508
else -- ./compiler/lua54.lpt:508
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.lpt:510
end -- ./compiler/lua54.lpt:510
end, -- ./compiler/lua54.lpt:510
["Push"] = function(t) -- ./compiler/lua54.lpt:514
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.lpt:515
r = "" -- ./compiler/lua54.lpt:516
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:517
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:518
end -- ./compiler/lua54.lpt:518
if t[# t] then -- ./compiler/lua54.lpt:520
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.lpt:521
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.lpt:522
else -- ./compiler/lua54.lpt:522
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
return r -- ./compiler/lua54.lpt:527
end, -- ./compiler/lua54.lpt:527
["Break"] = function() -- ./compiler/lua54.lpt:530
return "break" -- ./compiler/lua54.lpt:531
end, -- ./compiler/lua54.lpt:531
["Continue"] = function() -- ./compiler/lua54.lpt:534
return "goto " .. var("continue") -- ./compiler/lua54.lpt:535
end, -- ./compiler/lua54.lpt:535
["Nil"] = function() -- ./compiler/lua54.lpt:542
return "nil" -- ./compiler/lua54.lpt:543
end, -- ./compiler/lua54.lpt:543
["Dots"] = function() -- ./compiler/lua54.lpt:546
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:547
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.lpt:548
nomacro["variables"]["..."] = true -- ./compiler/lua54.lpt:549
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.lpt:550
nomacro["variables"]["..."] = nil -- ./compiler/lua54.lpt:551
return r -- ./compiler/lua54.lpt:552
else -- ./compiler/lua54.lpt:552
return "..." -- ./compiler/lua54.lpt:554
end -- ./compiler/lua54.lpt:554
end, -- ./compiler/lua54.lpt:554
["Boolean"] = function(t) -- ./compiler/lua54.lpt:558
return tostring(t[1]) -- ./compiler/lua54.lpt:559
end, -- ./compiler/lua54.lpt:559
["Number"] = function(t) -- ./compiler/lua54.lpt:562
return tostring(t[1]) -- ./compiler/lua54.lpt:563
end, -- ./compiler/lua54.lpt:563
["String"] = function(t) -- ./compiler/lua54.lpt:566
return ("%q"):format(t[1]) -- ./compiler/lua54.lpt:567
end, -- ./compiler/lua54.lpt:567
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.lpt:570
local r = "(" -- ./compiler/lua54.lpt:571
local decl = {} -- ./compiler/lua54.lpt:572
if t[1][1] then -- ./compiler/lua54.lpt:573
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:574
local id = lua(t[1][1][1]) -- ./compiler/lua54.lpt:575
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:576
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.lpt:577
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:578
r = r .. (id) -- ./compiler/lua54.lpt:579
else -- ./compiler/lua54.lpt:579
r = r .. (lua(t[1][1])) -- ./compiler/lua54.lpt:581
end -- ./compiler/lua54.lpt:581
for i = 2, # t[1], 1 do -- ./compiler/lua54.lpt:583
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:584
local id = lua(t[1][i][1]) -- ./compiler/lua54.lpt:585
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:586
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.lpt:587
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:588
r = r .. (", " .. id) -- ./compiler/lua54.lpt:589
else -- ./compiler/lua54.lpt:589
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
r = r .. (")" .. indent()) -- ./compiler/lua54.lpt:595
for _, d in ipairs(decl) do -- ./compiler/lua54.lpt:596
r = r .. (d .. newline()) -- ./compiler/lua54.lpt:597
end -- ./compiler/lua54.lpt:597
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.lpt:599
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.lpt:600
end -- ./compiler/lua54.lpt:600
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.lpt:602
if hasPush then -- ./compiler/lua54.lpt:603
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:604
else -- ./compiler/lua54.lpt:604
push("push", false) -- ./compiler/lua54.lpt:606
end -- ./compiler/lua54.lpt:606
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:608
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:609
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:610
end -- ./compiler/lua54.lpt:610
pop("push") -- ./compiler/lua54.lpt:612
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:613
end, -- ./compiler/lua54.lpt:613
["Function"] = function(t) -- ./compiler/lua54.lpt:615
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.lpt:616
end, -- ./compiler/lua54.lpt:616
["Pair"] = function(t) -- ./compiler/lua54.lpt:619
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.lpt:620
end, -- ./compiler/lua54.lpt:620
["Table"] = function(t) -- ./compiler/lua54.lpt:622
if # t == 0 then -- ./compiler/lua54.lpt:623
return "{}" -- ./compiler/lua54.lpt:624
elseif # t == 1 then -- ./compiler/lua54.lpt:625
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.lpt:626
else -- ./compiler/lua54.lpt:626
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.lpt:628
end -- ./compiler/lua54.lpt:628
end, -- ./compiler/lua54.lpt:628
["TableCompr"] = function(t) -- ./compiler/lua54.lpt:632
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.lpt:633
end, -- ./compiler/lua54.lpt:633
["Op"] = function(t) -- ./compiler/lua54.lpt:636
local r -- ./compiler/lua54.lpt:637
if # t == 2 then -- ./compiler/lua54.lpt:638
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:639
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.lpt:640
else -- ./compiler/lua54.lpt:640
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.lpt:642
end -- ./compiler/lua54.lpt:642
else -- ./compiler/lua54.lpt:642
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:645
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.lpt:646
else -- ./compiler/lua54.lpt:646
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.lpt:648
end -- ./compiler/lua54.lpt:648
end -- ./compiler/lua54.lpt:648
return r -- ./compiler/lua54.lpt:651
end, -- ./compiler/lua54.lpt:651
["Paren"] = function(t) -- ./compiler/lua54.lpt:654
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.lpt:655
end, -- ./compiler/lua54.lpt:655
["MethodStub"] = function(t) -- ./compiler/lua54.lpt:658
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:664
end, -- ./compiler/lua54.lpt:664
["SafeMethodStub"] = function(t) -- ./compiler/lua54.lpt:667
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:674
end, -- ./compiler/lua54.lpt:674
["LetExpr"] = function(t) -- ./compiler/lua54.lpt:681
return lua(t[1][1]) -- ./compiler/lua54.lpt:682
end, -- ./compiler/lua54.lpt:682
["_statexpr"] = function(t, stat) -- ./compiler/lua54.lpt:686
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.lpt:687
local r = "(function()" .. indent() -- ./compiler/lua54.lpt:688
if hasPush then -- ./compiler/lua54.lpt:689
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:690
else -- ./compiler/lua54.lpt:690
push("push", false) -- ./compiler/lua54.lpt:692
end -- ./compiler/lua54.lpt:692
r = r .. (lua(t, stat)) -- ./compiler/lua54.lpt:694
if hasPush then -- ./compiler/lua54.lpt:695
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:696
end -- ./compiler/lua54.lpt:696
pop("push") -- ./compiler/lua54.lpt:698
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.lpt:699
return r -- ./compiler/lua54.lpt:700
end, -- ./compiler/lua54.lpt:700
["DoExpr"] = function(t) -- ./compiler/lua54.lpt:703
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.lpt:704
t[# t]["tag"] = "Return" -- ./compiler/lua54.lpt:705
end -- ./compiler/lua54.lpt:705
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.lpt:707
end, -- ./compiler/lua54.lpt:707
["WhileExpr"] = function(t) -- ./compiler/lua54.lpt:710
return lua(t, "_statexpr", "While") -- ./compiler/lua54.lpt:711
end, -- ./compiler/lua54.lpt:711
["RepeatExpr"] = function(t) -- ./compiler/lua54.lpt:714
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.lpt:715
end, -- ./compiler/lua54.lpt:715
["IfExpr"] = function(t) -- ./compiler/lua54.lpt:718
for i = 2, # t do -- ./compiler/lua54.lpt:719
local block = t[i] -- ./compiler/lua54.lpt:720
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.lpt:721
block[# block]["tag"] = "Return" -- ./compiler/lua54.lpt:722
end -- ./compiler/lua54.lpt:722
end -- ./compiler/lua54.lpt:722
return lua(t, "_statexpr", "If") -- ./compiler/lua54.lpt:725
end, -- ./compiler/lua54.lpt:725
["FornumExpr"] = function(t) -- ./compiler/lua54.lpt:728
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.lpt:729
end, -- ./compiler/lua54.lpt:729
["ForinExpr"] = function(t) -- ./compiler/lua54.lpt:732
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.lpt:733
end, -- ./compiler/lua54.lpt:733
["Call"] = function(t) -- ./compiler/lua54.lpt:739
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:740
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:741
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.lpt:742
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.lpt:743
local replacement = macro["replacement"] -- ./compiler/lua54.lpt:744
local r -- ./compiler/lua54.lpt:745
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.lpt:746
if type(replacement) == "function" then -- ./compiler/lua54.lpt:747
local args = {} -- ./compiler/lua54.lpt:748
for i = 2, # t do -- ./compiler/lua54.lpt:749
table["insert"](args, lua(t[i])) -- ./compiler/lua54.lpt:750
end -- ./compiler/lua54.lpt:750
r = replacement(unpack(args)) -- ./compiler/lua54.lpt:752
else -- ./compiler/lua54.lpt:752
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.lpt:754
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.lpt:755
if arg["tag"] == "Dots" then -- ./compiler/lua54.lpt:756
macroargs["..."] = (function() -- ./compiler/lua54.lpt:757
local self = {} -- ./compiler/lua54.lpt:757
for j = i + 1, # t do -- ./compiler/lua54.lpt:757
self[#self+1] = t[j] -- ./compiler/lua54.lpt:757
end -- ./compiler/lua54.lpt:757
return self -- ./compiler/lua54.lpt:757
end)() -- ./compiler/lua54.lpt:757
elseif arg["tag"] == "Id" then -- ./compiler/lua54.lpt:758
if t[i + 1] == nil then -- ./compiler/lua54.lpt:759
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.lpt:760
end -- ./compiler/lua54.lpt:760
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.lpt:762
else -- ./compiler/lua54.lpt:762
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.lpt:764
end -- ./compiler/lua54.lpt:764
end -- ./compiler/lua54.lpt:764
push("macroargs", macroargs) -- ./compiler/lua54.lpt:767
r = lua(replacement) -- ./compiler/lua54.lpt:768
pop("macroargs") -- ./compiler/lua54.lpt:769
end -- ./compiler/lua54.lpt:769
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.lpt:771
return r -- ./compiler/lua54.lpt:772
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.lpt:773
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.lpt:774
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:775
else -- ./compiler/lua54.lpt:775
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:777
end -- ./compiler/lua54.lpt:777
else -- ./compiler/lua54.lpt:777
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:780
end -- ./compiler/lua54.lpt:780
end, -- ./compiler/lua54.lpt:780
["SafeCall"] = function(t) -- ./compiler/lua54.lpt:784
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:785
return lua(t, "SafeIndex") -- ./compiler/lua54.lpt:786
else -- ./compiler/lua54.lpt:786
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.lpt:788
end -- ./compiler/lua54.lpt:788
end, -- ./compiler/lua54.lpt:788
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.lpt:793
if start == nil then start = 1 end -- ./compiler/lua54.lpt:793
local r -- ./compiler/lua54.lpt:794
if t[start] then -- ./compiler/lua54.lpt:795
r = lua(t[start]) -- ./compiler/lua54.lpt:796
for i = start + 1, # t, 1 do -- ./compiler/lua54.lpt:797
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.lpt:798
end -- ./compiler/lua54.lpt:798
else -- ./compiler/lua54.lpt:798
r = "" -- ./compiler/lua54.lpt:801
end -- ./compiler/lua54.lpt:801
return r -- ./compiler/lua54.lpt:803
end, -- ./compiler/lua54.lpt:803
["Id"] = function(t) -- ./compiler/lua54.lpt:806
local r = t[1] -- ./compiler/lua54.lpt:807
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:808
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.lpt:809
nomacro["variables"][t[1]] = true -- ./compiler/lua54.lpt:810
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.lpt:811
r = lua(macroargs[t[1]]) -- ./compiler/lua54.lpt:812
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.lpt:813
local macro = macros["variables"][t[1]] -- ./compiler/lua54.lpt:814
if type(macro) == "function" then -- ./compiler/lua54.lpt:815
r = macro() -- ./compiler/lua54.lpt:816
else -- ./compiler/lua54.lpt:816
r = lua(macro) -- ./compiler/lua54.lpt:818
end -- ./compiler/lua54.lpt:818
end -- ./compiler/lua54.lpt:818
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.lpt:821
end -- ./compiler/lua54.lpt:821
return r -- ./compiler/lua54.lpt:823
end, -- ./compiler/lua54.lpt:823
["AttributeId"] = function(t) -- ./compiler/lua54.lpt:826
if t[2] then -- ./compiler/lua54.lpt:827
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.lpt:828
else -- ./compiler/lua54.lpt:828
return t[1] -- ./compiler/lua54.lpt:830
end -- ./compiler/lua54.lpt:830
end, -- ./compiler/lua54.lpt:830
["DestructuringId"] = function(t) -- ./compiler/lua54.lpt:834
if t["id"] then -- ./compiler/lua54.lpt:835
return t["id"] -- ./compiler/lua54.lpt:836
else -- ./compiler/lua54.lpt:836
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.lpt:838
local vars = { ["id"] = tmp() } -- ./compiler/lua54.lpt:839
for j = 1, # t, 1 do -- ./compiler/lua54.lpt:840
table["insert"](vars, t[j]) -- ./compiler/lua54.lpt:841
end -- ./compiler/lua54.lpt:841
table["insert"](d, vars) -- ./compiler/lua54.lpt:843
t["id"] = vars["id"] -- ./compiler/lua54.lpt:844
return vars["id"] -- ./compiler/lua54.lpt:845
end -- ./compiler/lua54.lpt:845
end, -- ./compiler/lua54.lpt:845
["Index"] = function(t) -- ./compiler/lua54.lpt:849
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:850
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:851
else -- ./compiler/lua54.lpt:851
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:853
end -- ./compiler/lua54.lpt:853
end, -- ./compiler/lua54.lpt:853
["SafeIndex"] = function(t) -- ./compiler/lua54.lpt:857
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:858
local l = {} -- ./compiler/lua54.lpt:859
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.lpt:860
table["insert"](l, 1, t) -- ./compiler/lua54.lpt:861
t = t[1] -- ./compiler/lua54.lpt:862
end -- ./compiler/lua54.lpt:862
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.lpt:864
for _, e in ipairs(l) do -- ./compiler/lua54.lpt:865
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.lpt:866
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.lpt:867
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.lpt:868
else -- ./compiler/lua54.lpt:868
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.lpt:870
end -- ./compiler/lua54.lpt:870
end -- ./compiler/lua54.lpt:870
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.lpt:873
return r -- ./compiler/lua54.lpt:874
else -- ./compiler/lua54.lpt:874
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.lpt:876
end -- ./compiler/lua54.lpt:876
end, -- ./compiler/lua54.lpt:876
["_opid"] = { -- ./compiler/lua54.lpt:881
["add"] = "+", -- ./compiler/lua54.lpt:882
["sub"] = "-", -- ./compiler/lua54.lpt:882
["mul"] = "*", -- ./compiler/lua54.lpt:882
["div"] = "/", -- ./compiler/lua54.lpt:882
["idiv"] = "//", -- ./compiler/lua54.lpt:883
["mod"] = "%", -- ./compiler/lua54.lpt:883
["pow"] = "^", -- ./compiler/lua54.lpt:883
["concat"] = "..", -- ./compiler/lua54.lpt:883
["band"] = "&", -- ./compiler/lua54.lpt:884
["bor"] = "|", -- ./compiler/lua54.lpt:884
["bxor"] = "~", -- ./compiler/lua54.lpt:884
["shl"] = "<<", -- ./compiler/lua54.lpt:884
["shr"] = ">>", -- ./compiler/lua54.lpt:884
["eq"] = "==", -- ./compiler/lua54.lpt:885
["ne"] = "~=", -- ./compiler/lua54.lpt:885
["lt"] = "<", -- ./compiler/lua54.lpt:885
["gt"] = ">", -- ./compiler/lua54.lpt:885
["le"] = "<=", -- ./compiler/lua54.lpt:885
["ge"] = ">=", -- ./compiler/lua54.lpt:885
["and"] = "and", -- ./compiler/lua54.lpt:886
["or"] = "or", -- ./compiler/lua54.lpt:886
["unm"] = "-", -- ./compiler/lua54.lpt:886
["len"] = "#", -- ./compiler/lua54.lpt:886
["bnot"] = "~", -- ./compiler/lua54.lpt:886
["not"] = "not" -- ./compiler/lua54.lpt:886
} -- ./compiler/lua54.lpt:886
}, { ["__index"] = function(self, key) -- ./compiler/lua54.lpt:889
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.lpt:890
end }) -- ./compiler/lua54.lpt:890
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
local code = lua(ast) .. newline() -- ./compiler/lua54.lpt:896
return requireStr .. code -- ./compiler/lua54.lpt:897
end -- ./compiler/lua54.lpt:897
end -- ./compiler/lua54.lpt:897
local lua54 = _() or lua54 -- ./compiler/lua54.lpt:902
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
local indentLevel = 0 -- ./compiler/lua54.lpt:15
local function newline() -- ./compiler/lua54.lpt:17
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.lpt:18
if options["mapLines"] then -- ./compiler/lua54.lpt:19
local sub = code:sub(lastInputPos) -- ./compiler/lua54.lpt:20
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.lpt:21
if source and line then -- ./compiler/lua54.lpt:23
lastSource = source -- ./compiler/lua54.lpt:24
lastLine = tonumber(line) -- ./compiler/lua54.lpt:25
else -- ./compiler/lua54.lpt:25
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.lpt:27
lastLine = lastLine + (1) -- ./compiler/lua54.lpt:28
end -- ./compiler/lua54.lpt:28
end -- ./compiler/lua54.lpt:28
prevLinePos = lastInputPos -- ./compiler/lua54.lpt:32
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.lpt:34
end -- ./compiler/lua54.lpt:34
return r -- ./compiler/lua54.lpt:36
end -- ./compiler/lua54.lpt:36
local function indent() -- ./compiler/lua54.lpt:39
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:40
return newline() -- ./compiler/lua54.lpt:41
end -- ./compiler/lua54.lpt:41
local function unindent() -- ./compiler/lua54.lpt:44
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:45
return newline() -- ./compiler/lua54.lpt:46
end -- ./compiler/lua54.lpt:46
local states = { -- ./compiler/lua54.lpt:51
["push"] = {}, -- ./compiler/lua54.lpt:52
["destructuring"] = {}, -- ./compiler/lua54.lpt:53
["scope"] = {}, -- ./compiler/lua54.lpt:54
["macroargs"] = {} -- ./compiler/lua54.lpt:55
} -- ./compiler/lua54.lpt:55
local function push(name, state) -- ./compiler/lua54.lpt:58
table["insert"](states[name], state) -- ./compiler/lua54.lpt:59
return "" -- ./compiler/lua54.lpt:60
end -- ./compiler/lua54.lpt:60
local function pop(name) -- ./compiler/lua54.lpt:63
table["remove"](states[name]) -- ./compiler/lua54.lpt:64
return "" -- ./compiler/lua54.lpt:65
end -- ./compiler/lua54.lpt:65
local function set(name, state) -- ./compiler/lua54.lpt:68
states[name][# states[name]] = state -- ./compiler/lua54.lpt:69
return "" -- ./compiler/lua54.lpt:70
end -- ./compiler/lua54.lpt:70
local function peek(name) -- ./compiler/lua54.lpt:73
return states[name][# states[name]] -- ./compiler/lua54.lpt:74
end -- ./compiler/lua54.lpt:74
local function var(name) -- ./compiler/lua54.lpt:79
return options["variablePrefix"] .. name -- ./compiler/lua54.lpt:80
end -- ./compiler/lua54.lpt:80
local function tmp() -- ./compiler/lua54.lpt:84
local scope = peek("scope") -- ./compiler/lua54.lpt:85
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.lpt:86
table["insert"](scope, var) -- ./compiler/lua54.lpt:87
return var -- ./compiler/lua54.lpt:88
end -- ./compiler/lua54.lpt:88
local nomacro = { -- ./compiler/lua54.lpt:92
["variables"] = {}, -- ./compiler/lua54.lpt:92
["functions"] = {} -- ./compiler/lua54.lpt:92
} -- ./compiler/lua54.lpt:92
local required = {} -- ./compiler/lua54.lpt:95
local requireStr = "" -- ./compiler/lua54.lpt:96
local function addRequire(mod, name, field) -- ./compiler/lua54.lpt:98
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.lpt:99
if not required[req] then -- ./compiler/lua54.lpt:100
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.lpt:101
required[req] = true -- ./compiler/lua54.lpt:102
end -- ./compiler/lua54.lpt:102
end -- ./compiler/lua54.lpt:102
local loop = { -- ./compiler/lua54.lpt:107
"While", -- ./compiler/lua54.lpt:107
"Repeat", -- ./compiler/lua54.lpt:107
"Fornum", -- ./compiler/lua54.lpt:107
"Forin", -- ./compiler/lua54.lpt:107
"WhileExpr", -- ./compiler/lua54.lpt:107
"RepeatExpr", -- ./compiler/lua54.lpt:107
"FornumExpr", -- ./compiler/lua54.lpt:107
"ForinExpr" -- ./compiler/lua54.lpt:107
} -- ./compiler/lua54.lpt:107
local func = { -- ./compiler/lua54.lpt:108
"Function", -- ./compiler/lua54.lpt:108
"TableCompr", -- ./compiler/lua54.lpt:108
"DoExpr", -- ./compiler/lua54.lpt:108
"WhileExpr", -- ./compiler/lua54.lpt:108
"RepeatExpr", -- ./compiler/lua54.lpt:108
"IfExpr", -- ./compiler/lua54.lpt:108
"FornumExpr", -- ./compiler/lua54.lpt:108
"ForinExpr" -- ./compiler/lua54.lpt:108
} -- ./compiler/lua54.lpt:108
local function any(list, tags, nofollow) -- ./compiler/lua54.lpt:112
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:112
local tagsCheck = {} -- ./compiler/lua54.lpt:113
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:114
tagsCheck[tag] = true -- ./compiler/lua54.lpt:115
end -- ./compiler/lua54.lpt:115
local nofollowCheck = {} -- ./compiler/lua54.lpt:117
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:118
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:119
end -- ./compiler/lua54.lpt:119
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:121
if type(node) == "table" then -- ./compiler/lua54.lpt:122
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:123
return node -- ./compiler/lua54.lpt:124
end -- ./compiler/lua54.lpt:124
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:126
local r = any(node, tags, nofollow) -- ./compiler/lua54.lpt:127
if r then -- ./compiler/lua54.lpt:128
return r -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
end -- ./compiler/lua54.lpt:128
return nil -- ./compiler/lua54.lpt:132
end -- ./compiler/lua54.lpt:132
local function search(list, tags, nofollow) -- ./compiler/lua54.lpt:137
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.lpt:137
local tagsCheck = {} -- ./compiler/lua54.lpt:138
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:139
tagsCheck[tag] = true -- ./compiler/lua54.lpt:140
end -- ./compiler/lua54.lpt:140
local nofollowCheck = {} -- ./compiler/lua54.lpt:142
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.lpt:143
nofollowCheck[tag] = true -- ./compiler/lua54.lpt:144
end -- ./compiler/lua54.lpt:144
local found = {} -- ./compiler/lua54.lpt:146
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:147
if type(node) == "table" then -- ./compiler/lua54.lpt:148
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.lpt:149
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.lpt:150
table["insert"](found, n) -- ./compiler/lua54.lpt:151
end -- ./compiler/lua54.lpt:151
end -- ./compiler/lua54.lpt:151
if tagsCheck[node["tag"]] then -- ./compiler/lua54.lpt:154
table["insert"](found, node) -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
end -- ./compiler/lua54.lpt:155
return found -- ./compiler/lua54.lpt:159
end -- ./compiler/lua54.lpt:159
local function all(list, tags) -- ./compiler/lua54.lpt:163
for _, node in ipairs(list) do -- ./compiler/lua54.lpt:164
local ok = false -- ./compiler/lua54.lpt:165
for _, tag in ipairs(tags) do -- ./compiler/lua54.lpt:166
if node["tag"] == tag then -- ./compiler/lua54.lpt:167
ok = true -- ./compiler/lua54.lpt:168
break -- ./compiler/lua54.lpt:169
end -- ./compiler/lua54.lpt:169
end -- ./compiler/lua54.lpt:169
if not ok then -- ./compiler/lua54.lpt:172
return false -- ./compiler/lua54.lpt:173
end -- ./compiler/lua54.lpt:173
end -- ./compiler/lua54.lpt:173
return true -- ./compiler/lua54.lpt:176
end -- ./compiler/lua54.lpt:176
local tags -- ./compiler/lua54.lpt:180
local function lua(ast, forceTag, ...) -- ./compiler/lua54.lpt:182
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.lpt:183
lastInputPos = ast["pos"] -- ./compiler/lua54.lpt:184
end -- ./compiler/lua54.lpt:184
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.lpt:186
end -- ./compiler/lua54.lpt:186
local UNPACK = function(list, i, j) -- ./compiler/lua54.lpt:190
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.lpt:191
end -- ./compiler/lua54.lpt:191
local APPEND = function(t, toAppend) -- ./compiler/lua54.lpt:193
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.lpt:194
end -- ./compiler/lua54.lpt:194
local CONTINUE_START = function() -- ./compiler/lua54.lpt:196
return "do" .. indent() -- ./compiler/lua54.lpt:197
end -- ./compiler/lua54.lpt:197
local CONTINUE_STOP = function() -- ./compiler/lua54.lpt:199
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.lpt:200
end -- ./compiler/lua54.lpt:200
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.lpt:202
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.lpt:202
if noLocal == nil then noLocal = false end -- ./compiler/lua54.lpt:202
local vars = {} -- ./compiler/lua54.lpt:203
local values = {} -- ./compiler/lua54.lpt:204
for _, list in ipairs(destructured) do -- ./compiler/lua54.lpt:205
for _, v in ipairs(list) do -- ./compiler/lua54.lpt:206
local var, val -- ./compiler/lua54.lpt:207
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.lpt:208
var = v -- ./compiler/lua54.lpt:209
val = { -- ./compiler/lua54.lpt:210
["tag"] = "Index", -- ./compiler/lua54.lpt:210
{ -- ./compiler/lua54.lpt:210
["tag"] = "Id", -- ./compiler/lua54.lpt:210
list["id"] -- ./compiler/lua54.lpt:210
}, -- ./compiler/lua54.lpt:210
{ -- ./compiler/lua54.lpt:210
["tag"] = "String", -- ./compiler/lua54.lpt:210
v[1] -- ./compiler/lua54.lpt:210
} -- ./compiler/lua54.lpt:210
} -- ./compiler/lua54.lpt:210
elseif v["tag"] == "Pair" then -- ./compiler/lua54.lpt:211
var = v[2] -- ./compiler/lua54.lpt:212
val = { -- ./compiler/lua54.lpt:213
["tag"] = "Index", -- ./compiler/lua54.lpt:213
{ -- ./compiler/lua54.lpt:213
["tag"] = "Id", -- ./compiler/lua54.lpt:213
list["id"] -- ./compiler/lua54.lpt:213
}, -- ./compiler/lua54.lpt:213
v[1] -- ./compiler/lua54.lpt:213
} -- ./compiler/lua54.lpt:213
else -- ./compiler/lua54.lpt:213
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.lpt:215
end -- ./compiler/lua54.lpt:215
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.lpt:217
val = { -- ./compiler/lua54.lpt:218
["tag"] = "Op", -- ./compiler/lua54.lpt:218
destructured["rightOp"], -- ./compiler/lua54.lpt:218
var, -- ./compiler/lua54.lpt:218
{ -- ./compiler/lua54.lpt:218
["tag"] = "Op", -- ./compiler/lua54.lpt:218
destructured["leftOp"], -- ./compiler/lua54.lpt:218
val, -- ./compiler/lua54.lpt:218
var -- ./compiler/lua54.lpt:218
} -- ./compiler/lua54.lpt:218
} -- ./compiler/lua54.lpt:218
elseif destructured["rightOp"] then -- ./compiler/lua54.lpt:219
val = { -- ./compiler/lua54.lpt:220
["tag"] = "Op", -- ./compiler/lua54.lpt:220
destructured["rightOp"], -- ./compiler/lua54.lpt:220
var, -- ./compiler/lua54.lpt:220
val -- ./compiler/lua54.lpt:220
} -- ./compiler/lua54.lpt:220
elseif destructured["leftOp"] then -- ./compiler/lua54.lpt:221
val = { -- ./compiler/lua54.lpt:222
["tag"] = "Op", -- ./compiler/lua54.lpt:222
destructured["leftOp"], -- ./compiler/lua54.lpt:222
val, -- ./compiler/lua54.lpt:222
var -- ./compiler/lua54.lpt:222
} -- ./compiler/lua54.lpt:222
end -- ./compiler/lua54.lpt:222
table["insert"](vars, lua(var)) -- ./compiler/lua54.lpt:224
table["insert"](values, lua(val)) -- ./compiler/lua54.lpt:225
end -- ./compiler/lua54.lpt:225
end -- ./compiler/lua54.lpt:225
if # vars > 0 then -- ./compiler/lua54.lpt:228
local decl = noLocal and "" or "local " -- ./compiler/lua54.lpt:229
if newlineAfter then -- ./compiler/lua54.lpt:230
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.lpt:231
else -- ./compiler/lua54.lpt:231
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.lpt:233
end -- ./compiler/lua54.lpt:233
else -- ./compiler/lua54.lpt:233
return "" -- ./compiler/lua54.lpt:236
end -- ./compiler/lua54.lpt:236
end -- ./compiler/lua54.lpt:236
tags = setmetatable({ -- ./compiler/lua54.lpt:241
["Block"] = function(t) -- ./compiler/lua54.lpt:243
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.lpt:244
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.lpt:245
hasPush["tag"] = "Return" -- ./compiler/lua54.lpt:246
hasPush = false -- ./compiler/lua54.lpt:247
end -- ./compiler/lua54.lpt:247
local r = push("scope", {}) -- ./compiler/lua54.lpt:249
if hasPush then -- ./compiler/lua54.lpt:250
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:251
end -- ./compiler/lua54.lpt:251
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:253
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:254
end -- ./compiler/lua54.lpt:254
if t[# t] then -- ./compiler/lua54.lpt:256
r = r .. (lua(t[# t])) -- ./compiler/lua54.lpt:257
end -- ./compiler/lua54.lpt:257
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:259
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.lpt:260
end -- ./compiler/lua54.lpt:260
return r .. pop("scope") -- ./compiler/lua54.lpt:262
end, -- ./compiler/lua54.lpt:262
["Do"] = function(t) -- ./compiler/lua54.lpt:268
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.lpt:269
end, -- ./compiler/lua54.lpt:269
["Set"] = function(t) -- ./compiler/lua54.lpt:272
local expr = t[# t] -- ./compiler/lua54.lpt:274
local vars, values = {}, {} -- ./compiler/lua54.lpt:275
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.lpt:276
for i, n in ipairs(t[1]) do -- ./compiler/lua54.lpt:277
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.lpt:278
table["insert"](destructuringVars, n) -- ./compiler/lua54.lpt:279
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.lpt:280
else -- ./compiler/lua54.lpt:280
table["insert"](vars, n) -- ./compiler/lua54.lpt:282
table["insert"](values, expr[i]) -- ./compiler/lua54.lpt:283
end -- ./compiler/lua54.lpt:283
end -- ./compiler/lua54.lpt:283
if # t == 2 or # t == 3 then -- ./compiler/lua54.lpt:287
local r = "" -- ./compiler/lua54.lpt:288
if # vars > 0 then -- ./compiler/lua54.lpt:289
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.lpt:290
end -- ./compiler/lua54.lpt:290
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:292
local destructured = {} -- ./compiler/lua54.lpt:293
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:294
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:295
end -- ./compiler/lua54.lpt:295
return r -- ./compiler/lua54.lpt:297
elseif # t == 4 then -- ./compiler/lua54.lpt:298
if t[3] == "=" then -- ./compiler/lua54.lpt:299
local r = "" -- ./compiler/lua54.lpt:300
if # vars > 0 then -- ./compiler/lua54.lpt:301
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:302
t[2], -- ./compiler/lua54.lpt:302
vars[1], -- ./compiler/lua54.lpt:302
{ -- ./compiler/lua54.lpt:302
["tag"] = "Paren", -- ./compiler/lua54.lpt:302
values[1] -- ./compiler/lua54.lpt:302
} -- ./compiler/lua54.lpt:302
}, "Op")) -- ./compiler/lua54.lpt:302
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.lpt:303
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:304
t[2], -- ./compiler/lua54.lpt:304
vars[i], -- ./compiler/lua54.lpt:304
{ -- ./compiler/lua54.lpt:304
["tag"] = "Paren", -- ./compiler/lua54.lpt:304
values[i] -- ./compiler/lua54.lpt:304
} -- ./compiler/lua54.lpt:304
}, "Op")) -- ./compiler/lua54.lpt:304
end -- ./compiler/lua54.lpt:304
end -- ./compiler/lua54.lpt:304
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:307
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.lpt:308
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:309
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:310
end -- ./compiler/lua54.lpt:310
return r -- ./compiler/lua54.lpt:312
else -- ./compiler/lua54.lpt:312
local r = "" -- ./compiler/lua54.lpt:314
if # vars > 0 then -- ./compiler/lua54.lpt:315
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:316
t[3], -- ./compiler/lua54.lpt:316
{ -- ./compiler/lua54.lpt:316
["tag"] = "Paren", -- ./compiler/lua54.lpt:316
values[1] -- ./compiler/lua54.lpt:316
}, -- ./compiler/lua54.lpt:316
vars[1] -- ./compiler/lua54.lpt:316
}, "Op")) -- ./compiler/lua54.lpt:316
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.lpt:317
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:318
t[3], -- ./compiler/lua54.lpt:318
{ -- ./compiler/lua54.lpt:318
["tag"] = "Paren", -- ./compiler/lua54.lpt:318
values[i] -- ./compiler/lua54.lpt:318
}, -- ./compiler/lua54.lpt:318
vars[i] -- ./compiler/lua54.lpt:318
}, "Op")) -- ./compiler/lua54.lpt:318
end -- ./compiler/lua54.lpt:318
end -- ./compiler/lua54.lpt:318
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:321
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.lpt:322
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:323
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:324
end -- ./compiler/lua54.lpt:324
return r -- ./compiler/lua54.lpt:326
end -- ./compiler/lua54.lpt:326
else -- ./compiler/lua54.lpt:326
local r = "" -- ./compiler/lua54.lpt:329
if # vars > 0 then -- ./compiler/lua54.lpt:330
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.lpt:331
t[2], -- ./compiler/lua54.lpt:331
vars[1], -- ./compiler/lua54.lpt:331
{ -- ./compiler/lua54.lpt:331
["tag"] = "Op", -- ./compiler/lua54.lpt:331
t[4], -- ./compiler/lua54.lpt:331
{ -- ./compiler/lua54.lpt:331
["tag"] = "Paren", -- ./compiler/lua54.lpt:331
values[1] -- ./compiler/lua54.lpt:331
}, -- ./compiler/lua54.lpt:331
vars[1] -- ./compiler/lua54.lpt:331
} -- ./compiler/lua54.lpt:331
}, "Op")) -- ./compiler/lua54.lpt:331
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.lpt:332
r = r .. (", " .. lua({ -- ./compiler/lua54.lpt:333
t[2], -- ./compiler/lua54.lpt:333
vars[i], -- ./compiler/lua54.lpt:333
{ -- ./compiler/lua54.lpt:333
["tag"] = "Op", -- ./compiler/lua54.lpt:333
t[4], -- ./compiler/lua54.lpt:333
{ -- ./compiler/lua54.lpt:333
["tag"] = "Paren", -- ./compiler/lua54.lpt:333
values[i] -- ./compiler/lua54.lpt:333
}, -- ./compiler/lua54.lpt:333
vars[i] -- ./compiler/lua54.lpt:333
} -- ./compiler/lua54.lpt:333
}, "Op")) -- ./compiler/lua54.lpt:333
end -- ./compiler/lua54.lpt:333
end -- ./compiler/lua54.lpt:333
if # destructuringVars > 0 then -- ./compiler/lua54.lpt:336
local destructured = { -- ./compiler/lua54.lpt:337
["rightOp"] = t[2], -- ./compiler/lua54.lpt:337
["leftOp"] = t[4] -- ./compiler/lua54.lpt:337
} -- ./compiler/lua54.lpt:337
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.lpt:338
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.lpt:339
end -- ./compiler/lua54.lpt:339
return r -- ./compiler/lua54.lpt:341
end -- ./compiler/lua54.lpt:341
end, -- ./compiler/lua54.lpt:341
["While"] = function(t) -- ./compiler/lua54.lpt:345
local r = "" -- ./compiler/lua54.lpt:346
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.lpt:347
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:348
if # lets > 0 then -- ./compiler/lua54.lpt:349
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:350
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:351
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:352
end -- ./compiler/lua54.lpt:352
end -- ./compiler/lua54.lpt:352
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.lpt:355
if # lets > 0 then -- ./compiler/lua54.lpt:356
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:357
end -- ./compiler/lua54.lpt:357
if hasContinue then -- ./compiler/lua54.lpt:359
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:360
end -- ./compiler/lua54.lpt:360
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:362
if hasContinue then -- ./compiler/lua54.lpt:363
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:364
end -- ./compiler/lua54.lpt:364
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:366
if # lets > 0 then -- ./compiler/lua54.lpt:367
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:368
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.lpt:369
end -- ./compiler/lua54.lpt:369
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.lpt:371
end -- ./compiler/lua54.lpt:371
return r -- ./compiler/lua54.lpt:373
end, -- ./compiler/lua54.lpt:373
["Repeat"] = function(t) -- ./compiler/lua54.lpt:376
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.lpt:377
local r = "repeat" .. indent() -- ./compiler/lua54.lpt:378
if hasContinue then -- ./compiler/lua54.lpt:379
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:380
end -- ./compiler/lua54.lpt:380
r = r .. (lua(t[1])) -- ./compiler/lua54.lpt:382
if hasContinue then -- ./compiler/lua54.lpt:383
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:384
end -- ./compiler/lua54.lpt:384
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.lpt:386
return r -- ./compiler/lua54.lpt:387
end, -- ./compiler/lua54.lpt:387
["If"] = function(t) -- ./compiler/lua54.lpt:390
local r = "" -- ./compiler/lua54.lpt:391
local toClose = 0 -- ./compiler/lua54.lpt:392
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.lpt:393
if # lets > 0 then -- ./compiler/lua54.lpt:394
r = r .. ("do" .. indent()) -- ./compiler/lua54.lpt:395
toClose = toClose + (1) -- ./compiler/lua54.lpt:396
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:397
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:398
end -- ./compiler/lua54.lpt:398
end -- ./compiler/lua54.lpt:398
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.lpt:401
for i = 3, # t - 1, 2 do -- ./compiler/lua54.lpt:402
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.lpt:403
if # lets > 0 then -- ./compiler/lua54.lpt:404
r = r .. ("else" .. indent()) -- ./compiler/lua54.lpt:405
toClose = toClose + (1) -- ./compiler/lua54.lpt:406
for _, l in ipairs(lets) do -- ./compiler/lua54.lpt:407
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.lpt:408
end -- ./compiler/lua54.lpt:408
else -- ./compiler/lua54.lpt:408
r = r .. ("else") -- ./compiler/lua54.lpt:411
end -- ./compiler/lua54.lpt:411
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.lpt:413
end -- ./compiler/lua54.lpt:413
if # t % 2 == 1 then -- ./compiler/lua54.lpt:415
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.lpt:416
end -- ./compiler/lua54.lpt:416
r = r .. ("end") -- ./compiler/lua54.lpt:418
for i = 1, toClose do -- ./compiler/lua54.lpt:419
r = r .. (unindent() .. "end") -- ./compiler/lua54.lpt:420
end -- ./compiler/lua54.lpt:420
return r -- ./compiler/lua54.lpt:422
end, -- ./compiler/lua54.lpt:422
["Fornum"] = function(t) -- ./compiler/lua54.lpt:425
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.lpt:426
if # t == 5 then -- ./compiler/lua54.lpt:427
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.lpt:428
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.lpt:429
if hasContinue then -- ./compiler/lua54.lpt:430
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:431
end -- ./compiler/lua54.lpt:431
r = r .. (lua(t[5])) -- ./compiler/lua54.lpt:433
if hasContinue then -- ./compiler/lua54.lpt:434
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:435
end -- ./compiler/lua54.lpt:435
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:437
else -- ./compiler/lua54.lpt:437
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.lpt:439
r = r .. (" do" .. indent()) -- ./compiler/lua54.lpt:440
if hasContinue then -- ./compiler/lua54.lpt:441
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:442
end -- ./compiler/lua54.lpt:442
r = r .. (lua(t[4])) -- ./compiler/lua54.lpt:444
if hasContinue then -- ./compiler/lua54.lpt:445
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:446
end -- ./compiler/lua54.lpt:446
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:448
end -- ./compiler/lua54.lpt:448
end, -- ./compiler/lua54.lpt:448
["Forin"] = function(t) -- ./compiler/lua54.lpt:452
local destructured = {} -- ./compiler/lua54.lpt:453
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.lpt:454
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.lpt:455
if hasContinue then -- ./compiler/lua54.lpt:456
r = r .. (CONTINUE_START()) -- ./compiler/lua54.lpt:457
end -- ./compiler/lua54.lpt:457
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.lpt:459
if hasContinue then -- ./compiler/lua54.lpt:460
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.lpt:461
end -- ./compiler/lua54.lpt:461
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:463
end, -- ./compiler/lua54.lpt:463
["Local"] = function(t) -- ./compiler/lua54.lpt:466
local destructured = {} -- ./compiler/lua54.lpt:467
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:468
if t[2][1] then -- ./compiler/lua54.lpt:469
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:470
end -- ./compiler/lua54.lpt:470
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:472
end, -- ./compiler/lua54.lpt:472
["Let"] = function(t) -- ./compiler/lua54.lpt:475
local destructured = {} -- ./compiler/lua54.lpt:476
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.lpt:477
local r = "local " .. nameList -- ./compiler/lua54.lpt:478
if t[2][1] then -- ./compiler/lua54.lpt:479
if all(t[2], { -- ./compiler/lua54.lpt:480
"Nil", -- ./compiler/lua54.lpt:480
"Dots", -- ./compiler/lua54.lpt:480
"Boolean", -- ./compiler/lua54.lpt:480
"Number", -- ./compiler/lua54.lpt:480
"String" -- ./compiler/lua54.lpt:480
}) then -- ./compiler/lua54.lpt:480
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:481
else -- ./compiler/lua54.lpt:481
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.lpt:483
end -- ./compiler/lua54.lpt:483
end -- ./compiler/lua54.lpt:483
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.lpt:486
end, -- ./compiler/lua54.lpt:486
["Localrec"] = function(t) -- ./compiler/lua54.lpt:489
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.lpt:490
end, -- ./compiler/lua54.lpt:490
["Goto"] = function(t) -- ./compiler/lua54.lpt:493
return "goto " .. lua(t, "Id") -- ./compiler/lua54.lpt:494
end, -- ./compiler/lua54.lpt:494
["Label"] = function(t) -- ./compiler/lua54.lpt:497
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.lpt:498
end, -- ./compiler/lua54.lpt:498
["Return"] = function(t) -- ./compiler/lua54.lpt:501
local push = peek("push") -- ./compiler/lua54.lpt:502
if push then -- ./compiler/lua54.lpt:503
local r = "" -- ./compiler/lua54.lpt:504
for _, val in ipairs(t) do -- ./compiler/lua54.lpt:505
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.lpt:506
end -- ./compiler/lua54.lpt:506
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.lpt:508
else -- ./compiler/lua54.lpt:508
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.lpt:510
end -- ./compiler/lua54.lpt:510
end, -- ./compiler/lua54.lpt:510
["Push"] = function(t) -- ./compiler/lua54.lpt:514
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.lpt:515
r = "" -- ./compiler/lua54.lpt:516
for i = 1, # t - 1, 1 do -- ./compiler/lua54.lpt:517
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.lpt:518
end -- ./compiler/lua54.lpt:518
if t[# t] then -- ./compiler/lua54.lpt:520
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.lpt:521
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.lpt:522
else -- ./compiler/lua54.lpt:522
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
end -- ./compiler/lua54.lpt:524
return r -- ./compiler/lua54.lpt:527
end, -- ./compiler/lua54.lpt:527
["Break"] = function() -- ./compiler/lua54.lpt:530
return "break" -- ./compiler/lua54.lpt:531
end, -- ./compiler/lua54.lpt:531
["Continue"] = function() -- ./compiler/lua54.lpt:534
return "goto " .. var("continue") -- ./compiler/lua54.lpt:535
end, -- ./compiler/lua54.lpt:535
["Nil"] = function() -- ./compiler/lua54.lpt:542
return "nil" -- ./compiler/lua54.lpt:543
end, -- ./compiler/lua54.lpt:543
["Dots"] = function() -- ./compiler/lua54.lpt:546
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:547
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.lpt:548
nomacro["variables"]["..."] = true -- ./compiler/lua54.lpt:549
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.lpt:550
nomacro["variables"]["..."] = nil -- ./compiler/lua54.lpt:551
return r -- ./compiler/lua54.lpt:552
else -- ./compiler/lua54.lpt:552
return "..." -- ./compiler/lua54.lpt:554
end -- ./compiler/lua54.lpt:554
end, -- ./compiler/lua54.lpt:554
["Boolean"] = function(t) -- ./compiler/lua54.lpt:558
return tostring(t[1]) -- ./compiler/lua54.lpt:559
end, -- ./compiler/lua54.lpt:559
["Number"] = function(t) -- ./compiler/lua54.lpt:562
return tostring(t[1]) -- ./compiler/lua54.lpt:563
end, -- ./compiler/lua54.lpt:563
["String"] = function(t) -- ./compiler/lua54.lpt:566
return ("%q"):format(t[1]) -- ./compiler/lua54.lpt:567
end, -- ./compiler/lua54.lpt:567
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.lpt:570
local r = "(" -- ./compiler/lua54.lpt:571
local decl = {} -- ./compiler/lua54.lpt:572
if t[1][1] then -- ./compiler/lua54.lpt:573
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:574
local id = lua(t[1][1][1]) -- ./compiler/lua54.lpt:575
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:576
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.lpt:577
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:578
r = r .. (id) -- ./compiler/lua54.lpt:579
else -- ./compiler/lua54.lpt:579
r = r .. (lua(t[1][1])) -- ./compiler/lua54.lpt:581
end -- ./compiler/lua54.lpt:581
for i = 2, # t[1], 1 do -- ./compiler/lua54.lpt:583
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.lpt:584
local id = lua(t[1][i][1]) -- ./compiler/lua54.lpt:585
indentLevel = indentLevel + (1) -- ./compiler/lua54.lpt:586
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.lpt:587
indentLevel = indentLevel - (1) -- ./compiler/lua54.lpt:588
r = r .. (", " .. id) -- ./compiler/lua54.lpt:589
else -- ./compiler/lua54.lpt:589
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
end -- ./compiler/lua54.lpt:591
r = r .. (")" .. indent()) -- ./compiler/lua54.lpt:595
for _, d in ipairs(decl) do -- ./compiler/lua54.lpt:596
r = r .. (d .. newline()) -- ./compiler/lua54.lpt:597
end -- ./compiler/lua54.lpt:597
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.lpt:599
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.lpt:600
end -- ./compiler/lua54.lpt:600
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.lpt:602
if hasPush then -- ./compiler/lua54.lpt:603
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:604
else -- ./compiler/lua54.lpt:604
push("push", false) -- ./compiler/lua54.lpt:606
end -- ./compiler/lua54.lpt:606
r = r .. (lua(t[2])) -- ./compiler/lua54.lpt:608
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.lpt:609
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:610
end -- ./compiler/lua54.lpt:610
pop("push") -- ./compiler/lua54.lpt:612
return r .. unindent() .. "end" -- ./compiler/lua54.lpt:613
end, -- ./compiler/lua54.lpt:613
["Function"] = function(t) -- ./compiler/lua54.lpt:615
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.lpt:616
end, -- ./compiler/lua54.lpt:616
["Pair"] = function(t) -- ./compiler/lua54.lpt:619
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.lpt:620
end, -- ./compiler/lua54.lpt:620
["Table"] = function(t) -- ./compiler/lua54.lpt:622
if # t == 0 then -- ./compiler/lua54.lpt:623
return "{}" -- ./compiler/lua54.lpt:624
elseif # t == 1 then -- ./compiler/lua54.lpt:625
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.lpt:626
else -- ./compiler/lua54.lpt:626
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.lpt:628
end -- ./compiler/lua54.lpt:628
end, -- ./compiler/lua54.lpt:628
["TableCompr"] = function(t) -- ./compiler/lua54.lpt:632
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.lpt:633
end, -- ./compiler/lua54.lpt:633
["Op"] = function(t) -- ./compiler/lua54.lpt:636
local r -- ./compiler/lua54.lpt:637
if # t == 2 then -- ./compiler/lua54.lpt:638
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:639
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.lpt:640
else -- ./compiler/lua54.lpt:640
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.lpt:642
end -- ./compiler/lua54.lpt:642
else -- ./compiler/lua54.lpt:642
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.lpt:645
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.lpt:646
else -- ./compiler/lua54.lpt:646
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.lpt:648
end -- ./compiler/lua54.lpt:648
end -- ./compiler/lua54.lpt:648
return r -- ./compiler/lua54.lpt:651
end, -- ./compiler/lua54.lpt:651
["Paren"] = function(t) -- ./compiler/lua54.lpt:654
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.lpt:655
end, -- ./compiler/lua54.lpt:655
["MethodStub"] = function(t) -- ./compiler/lua54.lpt:658
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:664
end, -- ./compiler/lua54.lpt:664
["SafeMethodStub"] = function(t) -- ./compiler/lua54.lpt:667
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.lpt:674
end, -- ./compiler/lua54.lpt:674
["LetExpr"] = function(t) -- ./compiler/lua54.lpt:681
return lua(t[1][1]) -- ./compiler/lua54.lpt:682
end, -- ./compiler/lua54.lpt:682
["_statexpr"] = function(t, stat) -- ./compiler/lua54.lpt:686
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.lpt:687
local r = "(function()" .. indent() -- ./compiler/lua54.lpt:688
if hasPush then -- ./compiler/lua54.lpt:689
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.lpt:690
else -- ./compiler/lua54.lpt:690
push("push", false) -- ./compiler/lua54.lpt:692
end -- ./compiler/lua54.lpt:692
r = r .. (lua(t, stat)) -- ./compiler/lua54.lpt:694
if hasPush then -- ./compiler/lua54.lpt:695
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.lpt:696
end -- ./compiler/lua54.lpt:696
pop("push") -- ./compiler/lua54.lpt:698
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.lpt:699
return r -- ./compiler/lua54.lpt:700
end, -- ./compiler/lua54.lpt:700
["DoExpr"] = function(t) -- ./compiler/lua54.lpt:703
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.lpt:704
t[# t]["tag"] = "Return" -- ./compiler/lua54.lpt:705
end -- ./compiler/lua54.lpt:705
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.lpt:707
end, -- ./compiler/lua54.lpt:707
["WhileExpr"] = function(t) -- ./compiler/lua54.lpt:710
return lua(t, "_statexpr", "While") -- ./compiler/lua54.lpt:711
end, -- ./compiler/lua54.lpt:711
["RepeatExpr"] = function(t) -- ./compiler/lua54.lpt:714
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.lpt:715
end, -- ./compiler/lua54.lpt:715
["IfExpr"] = function(t) -- ./compiler/lua54.lpt:718
for i = 2, # t do -- ./compiler/lua54.lpt:719
local block = t[i] -- ./compiler/lua54.lpt:720
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.lpt:721
block[# block]["tag"] = "Return" -- ./compiler/lua54.lpt:722
end -- ./compiler/lua54.lpt:722
end -- ./compiler/lua54.lpt:722
return lua(t, "_statexpr", "If") -- ./compiler/lua54.lpt:725
end, -- ./compiler/lua54.lpt:725
["FornumExpr"] = function(t) -- ./compiler/lua54.lpt:728
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.lpt:729
end, -- ./compiler/lua54.lpt:729
["ForinExpr"] = function(t) -- ./compiler/lua54.lpt:732
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.lpt:733
end, -- ./compiler/lua54.lpt:733
["Call"] = function(t) -- ./compiler/lua54.lpt:739
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:740
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:741
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.lpt:742
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.lpt:743
local replacement = macro["replacement"] -- ./compiler/lua54.lpt:744
local r -- ./compiler/lua54.lpt:745
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.lpt:746
if type(replacement) == "function" then -- ./compiler/lua54.lpt:747
local args = {} -- ./compiler/lua54.lpt:748
for i = 2, # t do -- ./compiler/lua54.lpt:749
table["insert"](args, lua(t[i])) -- ./compiler/lua54.lpt:750
end -- ./compiler/lua54.lpt:750
r = replacement(unpack(args)) -- ./compiler/lua54.lpt:752
else -- ./compiler/lua54.lpt:752
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.lpt:754
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.lpt:755
if arg["tag"] == "Dots" then -- ./compiler/lua54.lpt:756
macroargs["..."] = (function() -- ./compiler/lua54.lpt:757
local self = {} -- ./compiler/lua54.lpt:757
for j = i + 1, # t do -- ./compiler/lua54.lpt:757
self[#self+1] = t[j] -- ./compiler/lua54.lpt:757
end -- ./compiler/lua54.lpt:757
return self -- ./compiler/lua54.lpt:757
end)() -- ./compiler/lua54.lpt:757
elseif arg["tag"] == "Id" then -- ./compiler/lua54.lpt:758
if t[i + 1] == nil then -- ./compiler/lua54.lpt:759
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.lpt:760
end -- ./compiler/lua54.lpt:760
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.lpt:762
else -- ./compiler/lua54.lpt:762
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.lpt:764
end -- ./compiler/lua54.lpt:764
end -- ./compiler/lua54.lpt:764
push("macroargs", macroargs) -- ./compiler/lua54.lpt:767
r = lua(replacement) -- ./compiler/lua54.lpt:768
pop("macroargs") -- ./compiler/lua54.lpt:769
end -- ./compiler/lua54.lpt:769
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.lpt:771
return r -- ./compiler/lua54.lpt:772
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.lpt:773
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.lpt:774
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:775
else -- ./compiler/lua54.lpt:775
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:777
end -- ./compiler/lua54.lpt:777
else -- ./compiler/lua54.lpt:777
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.lpt:780
end -- ./compiler/lua54.lpt:780
end, -- ./compiler/lua54.lpt:780
["SafeCall"] = function(t) -- ./compiler/lua54.lpt:784
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:785
return lua(t, "SafeIndex") -- ./compiler/lua54.lpt:786
else -- ./compiler/lua54.lpt:786
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.lpt:788
end -- ./compiler/lua54.lpt:788
end, -- ./compiler/lua54.lpt:788
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.lpt:793
if start == nil then start = 1 end -- ./compiler/lua54.lpt:793
local r -- ./compiler/lua54.lpt:794
if t[start] then -- ./compiler/lua54.lpt:795
r = lua(t[start]) -- ./compiler/lua54.lpt:796
for i = start + 1, # t, 1 do -- ./compiler/lua54.lpt:797
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.lpt:798
end -- ./compiler/lua54.lpt:798
else -- ./compiler/lua54.lpt:798
r = "" -- ./compiler/lua54.lpt:801
end -- ./compiler/lua54.lpt:801
return r -- ./compiler/lua54.lpt:803
end, -- ./compiler/lua54.lpt:803
["Id"] = function(t) -- ./compiler/lua54.lpt:806
local r = t[1] -- ./compiler/lua54.lpt:807
local macroargs = peek("macroargs") -- ./compiler/lua54.lpt:808
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.lpt:809
nomacro["variables"][t[1]] = true -- ./compiler/lua54.lpt:810
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.lpt:811
r = lua(macroargs[t[1]]) -- ./compiler/lua54.lpt:812
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.lpt:813
local macro = macros["variables"][t[1]] -- ./compiler/lua54.lpt:814
if type(macro) == "function" then -- ./compiler/lua54.lpt:815
r = macro() -- ./compiler/lua54.lpt:816
else -- ./compiler/lua54.lpt:816
r = lua(macro) -- ./compiler/lua54.lpt:818
end -- ./compiler/lua54.lpt:818
end -- ./compiler/lua54.lpt:818
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.lpt:821
end -- ./compiler/lua54.lpt:821
return r -- ./compiler/lua54.lpt:823
end, -- ./compiler/lua54.lpt:823
["AttributeId"] = function(t) -- ./compiler/lua54.lpt:826
if t[2] then -- ./compiler/lua54.lpt:827
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.lpt:828
else -- ./compiler/lua54.lpt:828
return t[1] -- ./compiler/lua54.lpt:830
end -- ./compiler/lua54.lpt:830
end, -- ./compiler/lua54.lpt:830
["DestructuringId"] = function(t) -- ./compiler/lua54.lpt:834
if t["id"] then -- ./compiler/lua54.lpt:835
return t["id"] -- ./compiler/lua54.lpt:836
else -- ./compiler/lua54.lpt:836
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.lpt:838
local vars = { ["id"] = tmp() } -- ./compiler/lua54.lpt:839
for j = 1, # t, 1 do -- ./compiler/lua54.lpt:840
table["insert"](vars, t[j]) -- ./compiler/lua54.lpt:841
end -- ./compiler/lua54.lpt:841
table["insert"](d, vars) -- ./compiler/lua54.lpt:843
t["id"] = vars["id"] -- ./compiler/lua54.lpt:844
return vars["id"] -- ./compiler/lua54.lpt:845
end -- ./compiler/lua54.lpt:845
end, -- ./compiler/lua54.lpt:845
["Index"] = function(t) -- ./compiler/lua54.lpt:849
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.lpt:850
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:851
else -- ./compiler/lua54.lpt:851
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.lpt:853
end -- ./compiler/lua54.lpt:853
end, -- ./compiler/lua54.lpt:853
["SafeIndex"] = function(t) -- ./compiler/lua54.lpt:857
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.lpt:858
local l = {} -- ./compiler/lua54.lpt:859
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.lpt:860
table["insert"](l, 1, t) -- ./compiler/lua54.lpt:861
t = t[1] -- ./compiler/lua54.lpt:862
end -- ./compiler/lua54.lpt:862
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.lpt:864
for _, e in ipairs(l) do -- ./compiler/lua54.lpt:865
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.lpt:866
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.lpt:867
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.lpt:868
else -- ./compiler/lua54.lpt:868
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.lpt:870
end -- ./compiler/lua54.lpt:870
end -- ./compiler/lua54.lpt:870
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.lpt:873
return r -- ./compiler/lua54.lpt:874
else -- ./compiler/lua54.lpt:874
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.lpt:876
end -- ./compiler/lua54.lpt:876
end, -- ./compiler/lua54.lpt:876
["_opid"] = { -- ./compiler/lua54.lpt:881
["add"] = "+", -- ./compiler/lua54.lpt:882
["sub"] = "-", -- ./compiler/lua54.lpt:882
["mul"] = "*", -- ./compiler/lua54.lpt:882
["div"] = "/", -- ./compiler/lua54.lpt:882
["idiv"] = "//", -- ./compiler/lua54.lpt:883
["mod"] = "%", -- ./compiler/lua54.lpt:883
["pow"] = "^", -- ./compiler/lua54.lpt:883
["concat"] = "..", -- ./compiler/lua54.lpt:883
["band"] = "&", -- ./compiler/lua54.lpt:884
["bor"] = "|", -- ./compiler/lua54.lpt:884
["bxor"] = "~", -- ./compiler/lua54.lpt:884
["shl"] = "<<", -- ./compiler/lua54.lpt:884
["shr"] = ">>", -- ./compiler/lua54.lpt:884
["eq"] = "==", -- ./compiler/lua54.lpt:885
["ne"] = "~=", -- ./compiler/lua54.lpt:885
["lt"] = "<", -- ./compiler/lua54.lpt:885
["gt"] = ">", -- ./compiler/lua54.lpt:885
["le"] = "<=", -- ./compiler/lua54.lpt:885
["ge"] = ">=", -- ./compiler/lua54.lpt:885
["and"] = "and", -- ./compiler/lua54.lpt:886
["or"] = "or", -- ./compiler/lua54.lpt:886
["unm"] = "-", -- ./compiler/lua54.lpt:886
["len"] = "#", -- ./compiler/lua54.lpt:886
["bnot"] = "~", -- ./compiler/lua54.lpt:886
["not"] = "not" -- ./compiler/lua54.lpt:886
} -- ./compiler/lua54.lpt:886
}, { ["__index"] = function(self, key) -- ./compiler/lua54.lpt:889
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.lpt:890
end }) -- ./compiler/lua54.lpt:890
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
local code = lua(ast) .. newline() -- ./compiler/lua54.lpt:896
return requireStr .. code -- ./compiler/lua54.lpt:897
end -- ./compiler/lua54.lpt:897
end -- ./compiler/lua54.lpt:897
local lua54 = _() or lua54 -- ./compiler/lua54.lpt:902
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
if tag == "Nil" or tag == "Boolean" or tag == "Number" or tag == "String" then -- ./lepton/lpt-parser/validator.lua:343
return true -- ./lepton/lpt-parser/validator.lua:344
elseif tag == "Dots" then -- ./lepton/lpt-parser/validator.lua:345
return traverse_vararg(env, exp) -- ./lepton/lpt-parser/validator.lua:346
elseif tag == "Function" then -- ./lepton/lpt-parser/validator.lua:347
return traverse_function(env, exp) -- ./lepton/lpt-parser/validator.lua:348
elseif tag == "Table" then -- ./lepton/lpt-parser/validator.lua:349
return traverse_table(env, exp) -- ./lepton/lpt-parser/validator.lua:350
elseif tag == "Op" then -- ./lepton/lpt-parser/validator.lua:351
return traverse_op(env, exp) -- ./lepton/lpt-parser/validator.lua:352
elseif tag == "Paren" then -- ./lepton/lpt-parser/validator.lua:353
return traverse_paren(env, exp) -- ./lepton/lpt-parser/validator.lua:354
elseif tag == "Call" or tag == "SafeCall" then -- ./lepton/lpt-parser/validator.lua:355
return traverse_call(env, exp) -- ./lepton/lpt-parser/validator.lua:356
elseif tag == "Id" or tag == "Index" then -- ./lepton/lpt-parser/validator.lua:358
return traverse_var(env, exp) -- ./lepton/lpt-parser/validator.lua:359
elseif tag == "SafeIndex" then -- ./lepton/lpt-parser/validator.lua:360
return traverse_safeindex(env, exp) -- ./lepton/lpt-parser/validator.lua:361
elseif tag == "TableCompr" then -- ./lepton/lpt-parser/validator.lua:362
return traverse_tablecompr(env, exp) -- ./lepton/lpt-parser/validator.lua:363
elseif tag == "MethodStub" or tag == "SafeMethodStub" then -- ./lepton/lpt-parser/validator.lua:364
return traverse_methodstub(env, exp) -- ./lepton/lpt-parser/validator.lua:365
elseif tag:match("Expr$") then -- ./lepton/lpt-parser/validator.lua:366
return traverse_statexpr(env, exp) -- ./lepton/lpt-parser/validator.lua:367
else -- ./lepton/lpt-parser/validator.lua:367
error("expecting an expression, but got a " .. tag) -- ./lepton/lpt-parser/validator.lua:369
end -- ./lepton/lpt-parser/validator.lua:369
end -- ./lepton/lpt-parser/validator.lua:369
traverse_explist = function(env, explist) -- ./lepton/lpt-parser/validator.lua:373
for k, v in ipairs(explist) do -- ./lepton/lpt-parser/validator.lua:374
local status, msg = traverse_exp(env, v) -- ./lepton/lpt-parser/validator.lua:375
if not status then -- ./lepton/lpt-parser/validator.lua:376
return status, msg -- ./lepton/lpt-parser/validator.lua:376
end -- ./lepton/lpt-parser/validator.lua:376
end -- ./lepton/lpt-parser/validator.lua:376
return true -- ./lepton/lpt-parser/validator.lua:378
end -- ./lepton/lpt-parser/validator.lua:378
traverse_stm = function(env, stm) -- ./lepton/lpt-parser/validator.lua:381
local tag = stm["tag"] -- ./lepton/lpt-parser/validator.lua:382
if tag == "Do" then -- ./lepton/lpt-parser/validator.lua:383
return traverse_block(env, stm) -- ./lepton/lpt-parser/validator.lua:384
elseif tag == "Set" then -- ./lepton/lpt-parser/validator.lua:385
return traverse_assignment(env, stm) -- ./lepton/lpt-parser/validator.lua:386
elseif tag == "While" then -- ./lepton/lpt-parser/validator.lua:387
return traverse_while(env, stm) -- ./lepton/lpt-parser/validator.lua:388
elseif tag == "Repeat" then -- ./lepton/lpt-parser/validator.lua:389
return traverse_repeat(env, stm) -- ./lepton/lpt-parser/validator.lua:390
elseif tag == "If" then -- ./lepton/lpt-parser/validator.lua:391
return traverse_if(env, stm) -- ./lepton/lpt-parser/validator.lua:392
elseif tag == "Fornum" then -- ./lepton/lpt-parser/validator.lua:393
return traverse_fornum(env, stm) -- ./lepton/lpt-parser/validator.lua:394
elseif tag == "Forin" then -- ./lepton/lpt-parser/validator.lua:395
return traverse_forin(env, stm) -- ./lepton/lpt-parser/validator.lua:396
elseif tag == "Local" or tag == "Let" then -- ./lepton/lpt-parser/validator.lua:398
return traverse_let(env, stm) -- ./lepton/lpt-parser/validator.lua:399
elseif tag == "Localrec" then -- ./lepton/lpt-parser/validator.lua:400
return traverse_letrec(env, stm) -- ./lepton/lpt-parser/validator.lua:401
elseif tag == "Goto" then -- ./lepton/lpt-parser/validator.lua:402
return traverse_goto(env, stm) -- ./lepton/lpt-parser/validator.lua:403
elseif tag == "Label" then -- ./lepton/lpt-parser/validator.lua:404
return traverse_label(env, stm) -- ./lepton/lpt-parser/validator.lua:405
elseif tag == "Return" then -- ./lepton/lpt-parser/validator.lua:406
return traverse_return(env, stm) -- ./lepton/lpt-parser/validator.lua:407
elseif tag == "Break" then -- ./lepton/lpt-parser/validator.lua:408
return traverse_break(env, stm) -- ./lepton/lpt-parser/validator.lua:409
elseif tag == "Call" then -- ./lepton/lpt-parser/validator.lua:410
return traverse_call(env, stm) -- ./lepton/lpt-parser/validator.lua:411
elseif tag == "Continue" then -- ./lepton/lpt-parser/validator.lua:412
return traverse_continue(env, stm) -- ./lepton/lpt-parser/validator.lua:413
elseif tag == "Push" then -- ./lepton/lpt-parser/validator.lua:414
return traverse_push(env, stm) -- ./lepton/lpt-parser/validator.lua:415
else -- ./lepton/lpt-parser/validator.lua:415
error("expecting a statement, but got a " .. tag) -- ./lepton/lpt-parser/validator.lua:417
end -- ./lepton/lpt-parser/validator.lua:417
end -- ./lepton/lpt-parser/validator.lua:417
traverse_block = function(env, block) -- ./lepton/lpt-parser/validator.lua:421
local l = {} -- ./lepton/lpt-parser/validator.lua:422
new_scope(env) -- ./lepton/lpt-parser/validator.lua:423
for k, v in ipairs(block) do -- ./lepton/lpt-parser/validator.lua:424
local status, msg = traverse_stm(env, v) -- ./lepton/lpt-parser/validator.lua:425
if not status then -- ./lepton/lpt-parser/validator.lua:426
return status, msg -- ./lepton/lpt-parser/validator.lua:426
end -- ./lepton/lpt-parser/validator.lua:426
end -- ./lepton/lpt-parser/validator.lua:426
end_scope(env) -- ./lepton/lpt-parser/validator.lua:428
return true -- ./lepton/lpt-parser/validator.lua:429
end -- ./lepton/lpt-parser/validator.lua:429
local function traverse(ast, errorinfo) -- ./lepton/lpt-parser/validator.lua:433
assert(type(ast) == "table") -- ./lepton/lpt-parser/validator.lua:434
assert(type(errorinfo) == "table") -- ./lepton/lpt-parser/validator.lua:435
local env = { -- ./lepton/lpt-parser/validator.lua:436
["errorinfo"] = errorinfo, -- ./lepton/lpt-parser/validator.lua:436
["function"] = {} -- ./lepton/lpt-parser/validator.lua:436
} -- ./lepton/lpt-parser/validator.lua:436
new_function(env) -- ./lepton/lpt-parser/validator.lua:437
set_vararg(env, true) -- ./lepton/lpt-parser/validator.lua:438
local status, msg = traverse_block(env, ast) -- ./lepton/lpt-parser/validator.lua:439
if not status then -- ./lepton/lpt-parser/validator.lua:440
return status, msg -- ./lepton/lpt-parser/validator.lua:440
end -- ./lepton/lpt-parser/validator.lua:440
end_function(env) -- ./lepton/lpt-parser/validator.lua:441
status, msg = verify_pending_gotos(env) -- ./lepton/lpt-parser/validator.lua:442
if not status then -- ./lepton/lpt-parser/validator.lua:443
return status, msg -- ./lepton/lpt-parser/validator.lua:443
end -- ./lepton/lpt-parser/validator.lua:443
return ast -- ./lepton/lpt-parser/validator.lua:444
end -- ./lepton/lpt-parser/validator.lua:444
return { -- ./lepton/lpt-parser/validator.lua:447
["validate"] = traverse, -- ./lepton/lpt-parser/validator.lua:447
["syntaxerror"] = syntaxerror -- ./lepton/lpt-parser/validator.lua:447
} -- ./lepton/lpt-parser/validator.lua:447
end -- ./lepton/lpt-parser/validator.lua:447
local validator = _() or validator -- ./lepton/lpt-parser/validator.lua:451
package["loaded"]["lepton.lpt-parser.validator"] = validator or true -- ./lepton/lpt-parser/validator.lua:452
local function _() -- ./lepton/lpt-parser/validator.lua:455
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
local Rec, T = lpeg["Rec"], lpeg["T"] -- ./lepton/lpt-parser/parser.lua:82
local alpha, digit, alnum = lpeg["alpha"], lpeg["digit"], lpeg["alnum"] -- ./lepton/lpt-parser/parser.lua:84
local xdigit = lpeg["xdigit"] -- ./lepton/lpt-parser/parser.lua:85
local space = lpeg["space"] -- ./lepton/lpt-parser/parser.lua:86
local labels = { -- ./lepton/lpt-parser/parser.lua:90
{ -- ./lepton/lpt-parser/parser.lua:91
"ErrExtra", -- ./lepton/lpt-parser/parser.lua:91
"unexpected character(s), expected EOF" -- ./lepton/lpt-parser/parser.lua:91
}, -- ./lepton/lpt-parser/parser.lua:91
{ -- ./lepton/lpt-parser/parser.lua:92
"ErrInvalidStat", -- ./lepton/lpt-parser/parser.lua:92
"unexpected token, invalid start of statement" -- ./lepton/lpt-parser/parser.lua:92
}, -- ./lepton/lpt-parser/parser.lua:92
{ -- ./lepton/lpt-parser/parser.lua:94
"ErrExprIf", -- ./lepton/lpt-parser/parser.lua:94
"expected a condition after 'if'" -- ./lepton/lpt-parser/parser.lua:94
}, -- ./lepton/lpt-parser/parser.lua:94
{ -- ./lepton/lpt-parser/parser.lua:95
"ErrOIf", -- ./lepton/lpt-parser/parser.lua:95
"expected '{' after the condition" -- ./lepton/lpt-parser/parser.lua:95
}, -- ./lepton/lpt-parser/parser.lua:95
{ -- ./lepton/lpt-parser/parser.lua:96
"ErrExprEIf", -- ./lepton/lpt-parser/parser.lua:96
"expected a condition after 'elseif'" -- ./lepton/lpt-parser/parser.lua:96
}, -- ./lepton/lpt-parser/parser.lua:96
{ -- ./lepton/lpt-parser/parser.lua:97
"ErrOEIf", -- ./lepton/lpt-parser/parser.lua:97
"expected '{' after the condition" -- ./lepton/lpt-parser/parser.lua:97
}, -- ./lepton/lpt-parser/parser.lua:97
{ -- ./lepton/lpt-parser/parser.lua:98
"ErrOElse", -- ./lepton/lpt-parser/parser.lua:98
"expected '{' after 'else'" -- ./lepton/lpt-parser/parser.lua:98
}, -- ./lepton/lpt-parser/parser.lua:98
{ -- ./lepton/lpt-parser/parser.lua:99
"ErrCIf", -- ./lepton/lpt-parser/parser.lua:99
"expected '}' to close the if statement" -- ./lepton/lpt-parser/parser.lua:99
}, -- ./lepton/lpt-parser/parser.lua:99
{ -- ./lepton/lpt-parser/parser.lua:101
"ErrODo", -- ./lepton/lpt-parser/parser.lua:101
"expected '{' after 'do'" -- ./lepton/lpt-parser/parser.lua:101
}, -- ./lepton/lpt-parser/parser.lua:101
{ -- ./lepton/lpt-parser/parser.lua:102
"ErrCDo", -- ./lepton/lpt-parser/parser.lua:102
"expected '}' to close the do block" -- ./lepton/lpt-parser/parser.lua:102
}, -- ./lepton/lpt-parser/parser.lua:102
{ -- ./lepton/lpt-parser/parser.lua:103
"ErrExprWhile", -- ./lepton/lpt-parser/parser.lua:103
"expected a condition after 'while'" -- ./lepton/lpt-parser/parser.lua:103
}, -- ./lepton/lpt-parser/parser.lua:103
{ -- ./lepton/lpt-parser/parser.lua:104
"ErrDoWhile", -- ./lepton/lpt-parser/parser.lua:104
"expected '{' after the condition" -- ./lepton/lpt-parser/parser.lua:104
}, -- ./lepton/lpt-parser/parser.lua:104
{ -- ./lepton/lpt-parser/parser.lua:105
"ErrEndWhile", -- ./lepton/lpt-parser/parser.lua:105
"expected '}' to close the while loop" -- ./lepton/lpt-parser/parser.lua:105
}, -- ./lepton/lpt-parser/parser.lua:105
{ -- ./lepton/lpt-parser/parser.lua:106
"ErrORep", -- ./lepton/lpt-parser/parser.lua:106
"expected '{' after 'repeat'" -- ./lepton/lpt-parser/parser.lua:106
}, -- ./lepton/lpt-parser/parser.lua:106
{ -- ./lepton/lpt-parser/parser.lua:107
"ErrCRep", -- ./lepton/lpt-parser/parser.lua:107
"expected '}' to close the repeat loop" -- ./lepton/lpt-parser/parser.lua:107
}, -- ./lepton/lpt-parser/parser.lua:107
{ -- ./lepton/lpt-parser/parser.lua:108
"ErrUntilRep", -- ./lepton/lpt-parser/parser.lua:108
"expected 'until' after the end of the repeat loop" -- ./lepton/lpt-parser/parser.lua:108
}, -- ./lepton/lpt-parser/parser.lua:108
{ -- ./lepton/lpt-parser/parser.lua:109
"ErrExprRep", -- ./lepton/lpt-parser/parser.lua:109
"expected a condition after 'until'" -- ./lepton/lpt-parser/parser.lua:109
}, -- ./lepton/lpt-parser/parser.lua:109
{ -- ./lepton/lpt-parser/parser.lua:111
"ErrOFor", -- ./lepton/lpt-parser/parser.lua:111
"expected '{' after the range of the for loop" -- ./lepton/lpt-parser/parser.lua:111
}, -- ./lepton/lpt-parser/parser.lua:111
{ -- ./lepton/lpt-parser/parser.lua:112
"ErrForRange", -- ./lepton/lpt-parser/parser.lua:112
"expected a numeric or generic range after 'for'" -- ./lepton/lpt-parser/parser.lua:112
}, -- ./lepton/lpt-parser/parser.lua:112
{ -- ./lepton/lpt-parser/parser.lua:113
"ErrForRangeStart", -- ./lepton/lpt-parser/parser.lua:113
"expected a starting expression for the numeric range" -- ./lepton/lpt-parser/parser.lua:113
}, -- ./lepton/lpt-parser/parser.lua:113
{ -- ./lepton/lpt-parser/parser.lua:114
"ErrForRangeComma", -- ./lepton/lpt-parser/parser.lua:114
"expected ',' to split the start and end of the range" -- ./lepton/lpt-parser/parser.lua:114
}, -- ./lepton/lpt-parser/parser.lua:114
{ -- ./lepton/lpt-parser/parser.lua:115
"ErrForRangeEnd", -- ./lepton/lpt-parser/parser.lua:115
"expected an ending expression for the numeric range" -- ./lepton/lpt-parser/parser.lua:115
}, -- ./lepton/lpt-parser/parser.lua:115
{ -- ./lepton/lpt-parser/parser.lua:116
"ErrForRangeStep", -- ./lepton/lpt-parser/parser.lua:116
"expected a step expression for the numeric range after ','" -- ./lepton/lpt-parser/parser.lua:116
}, -- ./lepton/lpt-parser/parser.lua:116
{ -- ./lepton/lpt-parser/parser.lua:117
"ErrInFor", -- ./lepton/lpt-parser/parser.lua:117
"expected ':' after the variable(s)" -- ./lepton/lpt-parser/parser.lua:117
}, -- ./lepton/lpt-parser/parser.lua:117
{ -- ./lepton/lpt-parser/parser.lua:118
"ErrEListFor", -- ./lepton/lpt-parser/parser.lua:118
"expected one or more expressions after ':'" -- ./lepton/lpt-parser/parser.lua:118
}, -- ./lepton/lpt-parser/parser.lua:118
{ -- ./lepton/lpt-parser/parser.lua:119
"ErrCFor", -- ./lepton/lpt-parser/parser.lua:119
"expected 'end' to close the for loop" -- ./lepton/lpt-parser/parser.lua:119
}, -- ./lepton/lpt-parser/parser.lua:119
{ -- ./lepton/lpt-parser/parser.lua:121
"ErrDefLocal", -- ./lepton/lpt-parser/parser.lua:121
"expected a function definition or assignment after local" -- ./lepton/lpt-parser/parser.lua:121
}, -- ./lepton/lpt-parser/parser.lua:121
{ -- ./lepton/lpt-parser/parser.lua:122
"ErrDefLet", -- ./lepton/lpt-parser/parser.lua:122
"expected an assignment after let" -- ./lepton/lpt-parser/parser.lua:122
}, -- ./lepton/lpt-parser/parser.lua:122
{ -- ./lepton/lpt-parser/parser.lua:123
"ErrDefClose", -- ./lepton/lpt-parser/parser.lua:123
"expected an assignment after close" -- ./lepton/lpt-parser/parser.lua:123
}, -- ./lepton/lpt-parser/parser.lua:123
{ -- ./lepton/lpt-parser/parser.lua:124
"ErrDefConst", -- ./lepton/lpt-parser/parser.lua:124
"expected an assignment after const" -- ./lepton/lpt-parser/parser.lua:124
}, -- ./lepton/lpt-parser/parser.lua:124
{ -- ./lepton/lpt-parser/parser.lua:125
"ErrNameLFunc", -- ./lepton/lpt-parser/parser.lua:125
"expected a function name after 'function'" -- ./lepton/lpt-parser/parser.lua:125
}, -- ./lepton/lpt-parser/parser.lua:125
{ -- ./lepton/lpt-parser/parser.lua:126
"ErrEListLAssign", -- ./lepton/lpt-parser/parser.lua:126
"expected one or more expressions after '='" -- ./lepton/lpt-parser/parser.lua:126
}, -- ./lepton/lpt-parser/parser.lua:126
{ -- ./lepton/lpt-parser/parser.lua:127
"ErrEListAssign", -- ./lepton/lpt-parser/parser.lua:127
"expected one or more expressions after '='" -- ./lepton/lpt-parser/parser.lua:127
}, -- ./lepton/lpt-parser/parser.lua:127
{ -- ./lepton/lpt-parser/parser.lua:129
"ErrFuncName", -- ./lepton/lpt-parser/parser.lua:129
"expected a function name after 'function'" -- ./lepton/lpt-parser/parser.lua:129
}, -- ./lepton/lpt-parser/parser.lua:129
{ -- ./lepton/lpt-parser/parser.lua:130
"ErrNameFunc1", -- ./lepton/lpt-parser/parser.lua:130
"expected a function name after '.'" -- ./lepton/lpt-parser/parser.lua:130
}, -- ./lepton/lpt-parser/parser.lua:130
{ -- ./lepton/lpt-parser/parser.lua:131
"ErrNameFunc2", -- ./lepton/lpt-parser/parser.lua:131
"expected a method name after ':'" -- ./lepton/lpt-parser/parser.lua:131
}, -- ./lepton/lpt-parser/parser.lua:131
{ -- ./lepton/lpt-parser/parser.lua:132
"ErrOParenPList", -- ./lepton/lpt-parser/parser.lua:132
"expected '(' before the parameter list" -- ./lepton/lpt-parser/parser.lua:132
}, -- ./lepton/lpt-parser/parser.lua:132
{ -- ./lepton/lpt-parser/parser.lua:133
"ErrCParenPList", -- ./lepton/lpt-parser/parser.lua:133
"expected ')' to close the parameter list" -- ./lepton/lpt-parser/parser.lua:133
}, -- ./lepton/lpt-parser/parser.lua:133
{ -- ./lepton/lpt-parser/parser.lua:134
"ErrOFunc", -- ./lepton/lpt-parser/parser.lua:134
"expected '{' after the parameter list" -- ./lepton/lpt-parser/parser.lua:134
}, -- ./lepton/lpt-parser/parser.lua:134
{ -- ./lepton/lpt-parser/parser.lua:135
"ErrCFunc", -- ./lepton/lpt-parser/parser.lua:135
"expected '}' to close the function body" -- ./lepton/lpt-parser/parser.lua:135
}, -- ./lepton/lpt-parser/parser.lua:135
{ -- ./lepton/lpt-parser/parser.lua:136
"ErrArrowFuncArrow", -- ./lepton/lpt-parser/parser.lua:136
"expected '->' after the arrow function parameter(s)" -- ./lepton/lpt-parser/parser.lua:136
}, -- ./lepton/lpt-parser/parser.lua:136
{ -- ./lepton/lpt-parser/parser.lua:137
"ErrOArrowFunc", -- ./lepton/lpt-parser/parser.lua:137
"expected '{' after '->'" -- ./lepton/lpt-parser/parser.lua:137
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
"ErrOrExpr", -- ./lepton/lpt-parser/parser.lua:152
"expected an expression after '||'" -- ./lepton/lpt-parser/parser.lua:152
}, -- ./lepton/lpt-parser/parser.lua:152
{ -- ./lepton/lpt-parser/parser.lua:153
"ErrAndExpr", -- ./lepton/lpt-parser/parser.lua:153
"expected an expression after '&&'" -- ./lepton/lpt-parser/parser.lua:153
}, -- ./lepton/lpt-parser/parser.lua:153
{ -- ./lepton/lpt-parser/parser.lua:154
"ErrRelExpr", -- ./lepton/lpt-parser/parser.lua:154
"expected an expression after the relational operator" -- ./lepton/lpt-parser/parser.lua:154
}, -- ./lepton/lpt-parser/parser.lua:154
{ -- ./lepton/lpt-parser/parser.lua:155
"ErrBOrExpr", -- ./lepton/lpt-parser/parser.lua:155
"expected an expression after '|'" -- ./lepton/lpt-parser/parser.lua:155
}, -- ./lepton/lpt-parser/parser.lua:155
{ -- ./lepton/lpt-parser/parser.lua:156
"ErrBXorExpr", -- ./lepton/lpt-parser/parser.lua:156
"expected an expression after '~'" -- ./lepton/lpt-parser/parser.lua:156
}, -- ./lepton/lpt-parser/parser.lua:156
{ -- ./lepton/lpt-parser/parser.lua:157
"ErrBAndExpr", -- ./lepton/lpt-parser/parser.lua:157
"expected an expression after '&'" -- ./lepton/lpt-parser/parser.lua:157
}, -- ./lepton/lpt-parser/parser.lua:157
{ -- ./lepton/lpt-parser/parser.lua:158
"ErrShiftExpr", -- ./lepton/lpt-parser/parser.lua:158
"expected an expression after the bit shift" -- ./lepton/lpt-parser/parser.lua:158
}, -- ./lepton/lpt-parser/parser.lua:158
{ -- ./lepton/lpt-parser/parser.lua:159
"ErrConcatExpr", -- ./lepton/lpt-parser/parser.lua:159
"expected an expression after '++'" -- ./lepton/lpt-parser/parser.lua:159
}, -- ./lepton/lpt-parser/parser.lua:159
{ -- ./lepton/lpt-parser/parser.lua:160
"ErrAddExpr", -- ./lepton/lpt-parser/parser.lua:160
"expected an expression after the additive operator" -- ./lepton/lpt-parser/parser.lua:160
}, -- ./lepton/lpt-parser/parser.lua:160
{ -- ./lepton/lpt-parser/parser.lua:161
"ErrMulExpr", -- ./lepton/lpt-parser/parser.lua:161
"expected an expression after the multiplicative operator" -- ./lepton/lpt-parser/parser.lua:161
}, -- ./lepton/lpt-parser/parser.lua:161
{ -- ./lepton/lpt-parser/parser.lua:162
"ErrUnaryExpr", -- ./lepton/lpt-parser/parser.lua:162
"expected an expression after the unary operator" -- ./lepton/lpt-parser/parser.lua:162
}, -- ./lepton/lpt-parser/parser.lua:162
{ -- ./lepton/lpt-parser/parser.lua:163
"ErrPowExpr", -- ./lepton/lpt-parser/parser.lua:163
"expected an expression after '^'" -- ./lepton/lpt-parser/parser.lua:163
}, -- ./lepton/lpt-parser/parser.lua:163
{ -- ./lepton/lpt-parser/parser.lua:165
"ErrExprParen", -- ./lepton/lpt-parser/parser.lua:165
"expected an expression after '('" -- ./lepton/lpt-parser/parser.lua:165
}, -- ./lepton/lpt-parser/parser.lua:165
{ -- ./lepton/lpt-parser/parser.lua:166
"ErrCParenExpr", -- ./lepton/lpt-parser/parser.lua:166
"expected ')' to close the expression" -- ./lepton/lpt-parser/parser.lua:166
}, -- ./lepton/lpt-parser/parser.lua:166
{ -- ./lepton/lpt-parser/parser.lua:167
"ErrNameIndex", -- ./lepton/lpt-parser/parser.lua:167
"expected a field name after '.'" -- ./lepton/lpt-parser/parser.lua:167
}, -- ./lepton/lpt-parser/parser.lua:167
{ -- ./lepton/lpt-parser/parser.lua:168
"ErrExprIndex", -- ./lepton/lpt-parser/parser.lua:168
"expected an expression after '['" -- ./lepton/lpt-parser/parser.lua:168
}, -- ./lepton/lpt-parser/parser.lua:168
{ -- ./lepton/lpt-parser/parser.lua:169
"ErrCBracketIndex", -- ./lepton/lpt-parser/parser.lua:169
"expected ']' to close the indexing expression" -- ./lepton/lpt-parser/parser.lua:169
}, -- ./lepton/lpt-parser/parser.lua:169
{ -- ./lepton/lpt-parser/parser.lua:170
"ErrNameMeth", -- ./lepton/lpt-parser/parser.lua:170
"expected a method name after ':'" -- ./lepton/lpt-parser/parser.lua:170
}, -- ./lepton/lpt-parser/parser.lua:170
{ -- ./lepton/lpt-parser/parser.lua:171
"ErrMethArgs", -- ./lepton/lpt-parser/parser.lua:171
"expected some arguments for the method call (or '()')" -- ./lepton/lpt-parser/parser.lua:171
}, -- ./lepton/lpt-parser/parser.lua:171
{ -- ./lepton/lpt-parser/parser.lua:173
"ErrArgList", -- ./lepton/lpt-parser/parser.lua:173
"expected an expression after ',' in the argument list" -- ./lepton/lpt-parser/parser.lua:173
}, -- ./lepton/lpt-parser/parser.lua:173
{ -- ./lepton/lpt-parser/parser.lua:174
"ErrOParenArgs", -- ./lepton/lpt-parser/parser.lua:174
"expected '(' before the argument list" -- ./lepton/lpt-parser/parser.lua:174
}, -- ./lepton/lpt-parser/parser.lua:174
{ -- ./lepton/lpt-parser/parser.lua:175
"ErrCParenArgs", -- ./lepton/lpt-parser/parser.lua:175
"expected ')' to close the argument list" -- ./lepton/lpt-parser/parser.lua:175
}, -- ./lepton/lpt-parser/parser.lua:175
{ -- ./lepton/lpt-parser/parser.lua:177
"ErrCBraceTable", -- ./lepton/lpt-parser/parser.lua:177
"expected '}' to close the table constructor" -- ./lepton/lpt-parser/parser.lua:177
}, -- ./lepton/lpt-parser/parser.lua:177
{ -- ./lepton/lpt-parser/parser.lua:178
"ErrEqField", -- ./lepton/lpt-parser/parser.lua:178
"expected '=' after the table key" -- ./lepton/lpt-parser/parser.lua:178
}, -- ./lepton/lpt-parser/parser.lua:178
{ -- ./lepton/lpt-parser/parser.lua:179
"ErrExprField", -- ./lepton/lpt-parser/parser.lua:179
"expected an expression after '='" -- ./lepton/lpt-parser/parser.lua:179
}, -- ./lepton/lpt-parser/parser.lua:179
{ -- ./lepton/lpt-parser/parser.lua:180
"ErrExprFKey", -- ./lepton/lpt-parser/parser.lua:180
"expected an expression after '[' for the table key" -- ./lepton/lpt-parser/parser.lua:180
}, -- ./lepton/lpt-parser/parser.lua:180
{ -- ./lepton/lpt-parser/parser.lua:181
"ErrCBracketFKey", -- ./lepton/lpt-parser/parser.lua:181
"expected ']' to close the table key" -- ./lepton/lpt-parser/parser.lua:181
}, -- ./lepton/lpt-parser/parser.lua:181
{ -- ./lepton/lpt-parser/parser.lua:183
"ErrCBraceDestructuring", -- ./lepton/lpt-parser/parser.lua:183
"expected '}' to close the destructuring variable list" -- ./lepton/lpt-parser/parser.lua:183
}, -- ./lepton/lpt-parser/parser.lua:183
{ -- ./lepton/lpt-parser/parser.lua:184
"ErrDestructuringEqField", -- ./lepton/lpt-parser/parser.lua:184
"expected '=' after the table key in destructuring variable list" -- ./lepton/lpt-parser/parser.lua:184
}, -- ./lepton/lpt-parser/parser.lua:184
{ -- ./lepton/lpt-parser/parser.lua:185
"ErrDestructuringExprField", -- ./lepton/lpt-parser/parser.lua:185
"expected an identifier after '=' in destructuring variable list" -- ./lepton/lpt-parser/parser.lua:185
}, -- ./lepton/lpt-parser/parser.lua:185
{ -- ./lepton/lpt-parser/parser.lua:187
"ErrCBracketTableCompr", -- ./lepton/lpt-parser/parser.lua:187
"expected ']' to close the table comprehension" -- ./lepton/lpt-parser/parser.lua:187
}, -- ./lepton/lpt-parser/parser.lua:187
{ -- ./lepton/lpt-parser/parser.lua:189
"ErrDigitHex", -- ./lepton/lpt-parser/parser.lua:189
"expected one or more hexadecimal digits after '0x'" -- ./lepton/lpt-parser/parser.lua:189
}, -- ./lepton/lpt-parser/parser.lua:189
{ -- ./lepton/lpt-parser/parser.lua:190
"ErrDigitDeci", -- ./lepton/lpt-parser/parser.lua:190
"expected one or more digits after the decimal point" -- ./lepton/lpt-parser/parser.lua:190
}, -- ./lepton/lpt-parser/parser.lua:190
{ -- ./lepton/lpt-parser/parser.lua:191
"ErrDigitExpo", -- ./lepton/lpt-parser/parser.lua:191
"expected one or more digits for the exponent" -- ./lepton/lpt-parser/parser.lua:191
}, -- ./lepton/lpt-parser/parser.lua:191
{ -- ./lepton/lpt-parser/parser.lua:193
"ErrQuote", -- ./lepton/lpt-parser/parser.lua:193
"unclosed string" -- ./lepton/lpt-parser/parser.lua:193
}, -- ./lepton/lpt-parser/parser.lua:193
{ -- ./lepton/lpt-parser/parser.lua:194
"ErrHexEsc", -- ./lepton/lpt-parser/parser.lua:194
"expected exactly two hexadecimal digits after '\\x'" -- ./lepton/lpt-parser/parser.lua:194
}, -- ./lepton/lpt-parser/parser.lua:194
{ -- ./lepton/lpt-parser/parser.lua:195
"ErrOBraceUEsc", -- ./lepton/lpt-parser/parser.lua:195
"expected '{' after '\\u'" -- ./lepton/lpt-parser/parser.lua:195
}, -- ./lepton/lpt-parser/parser.lua:195
{ -- ./lepton/lpt-parser/parser.lua:196
"ErrDigitUEsc", -- ./lepton/lpt-parser/parser.lua:196
"expected one or more hexadecimal digits for the UTF-8 code point" -- ./lepton/lpt-parser/parser.lua:196
}, -- ./lepton/lpt-parser/parser.lua:196
{ -- ./lepton/lpt-parser/parser.lua:197
"ErrCBraceUEsc", -- ./lepton/lpt-parser/parser.lua:197
"expected '}' after the code point" -- ./lepton/lpt-parser/parser.lua:197
}, -- ./lepton/lpt-parser/parser.lua:197
{ -- ./lepton/lpt-parser/parser.lua:198
"ErrEscSeq", -- ./lepton/lpt-parser/parser.lua:198
"invalid escape sequence" -- ./lepton/lpt-parser/parser.lua:198
}, -- ./lepton/lpt-parser/parser.lua:198
{ -- ./lepton/lpt-parser/parser.lua:199
"ErrCloseLStr", -- ./lepton/lpt-parser/parser.lua:199
"unclosed long string" -- ./lepton/lpt-parser/parser.lua:199
}, -- ./lepton/lpt-parser/parser.lua:199
{ -- ./lepton/lpt-parser/parser.lua:201
"ErrUnknownAttribute", -- ./lepton/lpt-parser/parser.lua:201
"unknown variable attribute" -- ./lepton/lpt-parser/parser.lua:201
}, -- ./lepton/lpt-parser/parser.lua:201
{ -- ./lepton/lpt-parser/parser.lua:202
"ErrCBracketAttribute", -- ./lepton/lpt-parser/parser.lua:202
"expected '>' to close the variable attribute" -- ./lepton/lpt-parser/parser.lua:202
} -- ./lepton/lpt-parser/parser.lua:202
} -- ./lepton/lpt-parser/parser.lua:202
local function throw(label) -- ./lepton/lpt-parser/parser.lua:205
label = "Err" .. label -- ./lepton/lpt-parser/parser.lua:206
for i, labelinfo in ipairs(labels) do -- ./lepton/lpt-parser/parser.lua:208
if labelinfo[1] == label then -- ./lepton/lpt-parser/parser.lua:209
return T(i) -- ./lepton/lpt-parser/parser.lua:210
end -- ./lepton/lpt-parser/parser.lua:210
end -- ./lepton/lpt-parser/parser.lua:210
error("Label not found: " .. label) -- ./lepton/lpt-parser/parser.lua:214
end -- ./lepton/lpt-parser/parser.lua:214
local function e(patt, label) -- ./lepton/lpt-parser/parser.lua:217
return patt + throw(label) -- ./lepton/lpt-parser/parser.lua:218
end -- ./lepton/lpt-parser/parser.lua:218
local function token(patt) -- ./lepton/lpt-parser/parser.lua:223
return patt * V("Skip") -- ./lepton/lpt-parser/parser.lua:224
end -- ./lepton/lpt-parser/parser.lua:224
local function sym(str) -- ./lepton/lpt-parser/parser.lua:227
return token(P(str)) -- ./lepton/lpt-parser/parser.lua:228
end -- ./lepton/lpt-parser/parser.lua:228
local function kw(str) -- ./lepton/lpt-parser/parser.lua:231
return token(P(str) * - V("IdRest")) -- ./lepton/lpt-parser/parser.lua:232
end -- ./lepton/lpt-parser/parser.lua:232
local function parenAround(expr) -- ./lepton/lpt-parser/parser.lua:235
return sym("(") * expr * sym(")") -- ./lepton/lpt-parser/parser.lua:236
end -- ./lepton/lpt-parser/parser.lua:236
local function tagC(tag, patt) -- ./lepton/lpt-parser/parser.lua:239
return Ct(Cg(Cp(), "pos") * Cg(Cc(tag), "tag") * patt) -- ./lepton/lpt-parser/parser.lua:240
end -- ./lepton/lpt-parser/parser.lua:240
local function unaryOp(op, e) -- ./lepton/lpt-parser/parser.lua:243
return { -- ./lepton/lpt-parser/parser.lua:244
["tag"] = "Op", -- ./lepton/lpt-parser/parser.lua:244
["pos"] = e["pos"], -- ./lepton/lpt-parser/parser.lua:244
[1] = op, -- ./lepton/lpt-parser/parser.lua:244
[2] = e -- ./lepton/lpt-parser/parser.lua:244
} -- ./lepton/lpt-parser/parser.lua:244
end -- ./lepton/lpt-parser/parser.lua:244
local function binaryOp(e1, op, e2) -- ./lepton/lpt-parser/parser.lua:247
if not op then -- ./lepton/lpt-parser/parser.lua:248
return e1 -- ./lepton/lpt-parser/parser.lua:249
else -- ./lepton/lpt-parser/parser.lua:249
return { -- ./lepton/lpt-parser/parser.lua:251
["tag"] = "Op", -- ./lepton/lpt-parser/parser.lua:251
["pos"] = e1["pos"], -- ./lepton/lpt-parser/parser.lua:251
[1] = op, -- ./lepton/lpt-parser/parser.lua:251
[2] = e1, -- ./lepton/lpt-parser/parser.lua:251
[3] = e2 -- ./lepton/lpt-parser/parser.lua:251
} -- ./lepton/lpt-parser/parser.lua:251
end -- ./lepton/lpt-parser/parser.lua:251
end -- ./lepton/lpt-parser/parser.lua:251
local function sepBy(patt, sep, label) -- ./lepton/lpt-parser/parser.lua:255
if label then -- ./lepton/lpt-parser/parser.lua:256
return patt * Cg(sep * e(patt, label)) ^ 0 -- ./lepton/lpt-parser/parser.lua:257
else -- ./lepton/lpt-parser/parser.lua:257
return patt * Cg(sep * patt) ^ 0 -- ./lepton/lpt-parser/parser.lua:259
end -- ./lepton/lpt-parser/parser.lua:259
end -- ./lepton/lpt-parser/parser.lua:259
local function chainOp(patt, sep, label) -- ./lepton/lpt-parser/parser.lua:263
return Cf(sepBy(patt, sep, label), binaryOp) -- ./lepton/lpt-parser/parser.lua:264
end -- ./lepton/lpt-parser/parser.lua:264
local function commaSep(patt, label) -- ./lepton/lpt-parser/parser.lua:267
return sepBy(patt, sym(","), label) -- ./lepton/lpt-parser/parser.lua:268
end -- ./lepton/lpt-parser/parser.lua:268
local function tagDo(block) -- ./lepton/lpt-parser/parser.lua:271
block["tag"] = "Do" -- ./lepton/lpt-parser/parser.lua:272
return block -- ./lepton/lpt-parser/parser.lua:273
end -- ./lepton/lpt-parser/parser.lua:273
local function fixFuncStat(func) -- ./lepton/lpt-parser/parser.lua:276
if func[1]["is_method"] then -- ./lepton/lpt-parser/parser.lua:277
table["insert"](func[2][1], 1, { -- ./lepton/lpt-parser/parser.lua:277
["tag"] = "Id", -- ./lepton/lpt-parser/parser.lua:277
[1] = "self" -- ./lepton/lpt-parser/parser.lua:277
}) -- ./lepton/lpt-parser/parser.lua:277
end -- ./lepton/lpt-parser/parser.lua:277
func[1] = { func[1] } -- ./lepton/lpt-parser/parser.lua:278
func[2] = { func[2] } -- ./lepton/lpt-parser/parser.lua:279
return func -- ./lepton/lpt-parser/parser.lua:280
end -- ./lepton/lpt-parser/parser.lua:280
local function addDots(params, dots) -- ./lepton/lpt-parser/parser.lua:283
if dots then -- ./lepton/lpt-parser/parser.lua:284
table["insert"](params, dots) -- ./lepton/lpt-parser/parser.lua:284
end -- ./lepton/lpt-parser/parser.lua:284
return params -- ./lepton/lpt-parser/parser.lua:285
end -- ./lepton/lpt-parser/parser.lua:285
local function insertIndex(t, index) -- ./lepton/lpt-parser/parser.lua:288
return { -- ./lepton/lpt-parser/parser.lua:289
["tag"] = "Index", -- ./lepton/lpt-parser/parser.lua:289
["pos"] = t["pos"], -- ./lepton/lpt-parser/parser.lua:289
[1] = t, -- ./lepton/lpt-parser/parser.lua:289
[2] = index -- ./lepton/lpt-parser/parser.lua:289
} -- ./lepton/lpt-parser/parser.lua:289
end -- ./lepton/lpt-parser/parser.lua:289
local function markMethod(t, method) -- ./lepton/lpt-parser/parser.lua:292
if method then -- ./lepton/lpt-parser/parser.lua:293
return { -- ./lepton/lpt-parser/parser.lua:294
["tag"] = "Index", -- ./lepton/lpt-parser/parser.lua:294
["pos"] = t["pos"], -- ./lepton/lpt-parser/parser.lua:294
["is_method"] = true, -- ./lepton/lpt-parser/parser.lua:294
[1] = t, -- ./lepton/lpt-parser/parser.lua:294
[2] = method -- ./lepton/lpt-parser/parser.lua:294
} -- ./lepton/lpt-parser/parser.lua:294
end -- ./lepton/lpt-parser/parser.lua:294
return t -- ./lepton/lpt-parser/parser.lua:296
end -- ./lepton/lpt-parser/parser.lua:296
local function makeSuffixedExpr(t1, t2) -- ./lepton/lpt-parser/parser.lua:299
if t2["tag"] == "Call" or t2["tag"] == "SafeCall" then -- ./lepton/lpt-parser/parser.lua:300
local t = { -- ./lepton/lpt-parser/parser.lua:301
["tag"] = t2["tag"], -- ./lepton/lpt-parser/parser.lua:301
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:301
[1] = t1 -- ./lepton/lpt-parser/parser.lua:301
} -- ./lepton/lpt-parser/parser.lua:301
for k, v in ipairs(t2) do -- ./lepton/lpt-parser/parser.lua:302
table["insert"](t, v) -- ./lepton/lpt-parser/parser.lua:303
end -- ./lepton/lpt-parser/parser.lua:303
return t -- ./lepton/lpt-parser/parser.lua:305
elseif t2["tag"] == "MethodStub" or t2["tag"] == "SafeMethodStub" then -- ./lepton/lpt-parser/parser.lua:306
return { -- ./lepton/lpt-parser/parser.lua:307
["tag"] = t2["tag"], -- ./lepton/lpt-parser/parser.lua:307
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:307
[1] = t1, -- ./lepton/lpt-parser/parser.lua:307
[2] = t2[1] -- ./lepton/lpt-parser/parser.lua:307
} -- ./lepton/lpt-parser/parser.lua:307
elseif t2["tag"] == "SafeDotIndex" or t2["tag"] == "SafeArrayIndex" then -- ./lepton/lpt-parser/parser.lua:308
return { -- ./lepton/lpt-parser/parser.lua:309
["tag"] = "SafeIndex", -- ./lepton/lpt-parser/parser.lua:309
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:309
[1] = t1, -- ./lepton/lpt-parser/parser.lua:309
[2] = t2[1] -- ./lepton/lpt-parser/parser.lua:309
} -- ./lepton/lpt-parser/parser.lua:309
elseif t2["tag"] == "DotIndex" or t2["tag"] == "ArrayIndex" then -- ./lepton/lpt-parser/parser.lua:310
return { -- ./lepton/lpt-parser/parser.lua:311
["tag"] = "Index", -- ./lepton/lpt-parser/parser.lua:311
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:311
[1] = t1, -- ./lepton/lpt-parser/parser.lua:311
[2] = t2[1] -- ./lepton/lpt-parser/parser.lua:311
} -- ./lepton/lpt-parser/parser.lua:311
else -- ./lepton/lpt-parser/parser.lua:311
error("unexpected tag in suffixed expression") -- ./lepton/lpt-parser/parser.lua:313
end -- ./lepton/lpt-parser/parser.lua:313
end -- ./lepton/lpt-parser/parser.lua:313
local function fixArrowFunc(t) -- ./lepton/lpt-parser/parser.lua:317
if t[1] == ":" then -- ./lepton/lpt-parser/parser.lua:318
table["insert"](t[2], 1, { -- ./lepton/lpt-parser/parser.lua:319
["tag"] = "Id", -- ./lepton/lpt-parser/parser.lua:319
"self" -- ./lepton/lpt-parser/parser.lua:319
}) -- ./lepton/lpt-parser/parser.lua:319
table["remove"](t, 1) -- ./lepton/lpt-parser/parser.lua:320
t["is_method"] = true -- ./lepton/lpt-parser/parser.lua:321
end -- ./lepton/lpt-parser/parser.lua:321
t["is_short"] = true -- ./lepton/lpt-parser/parser.lua:323
return t -- ./lepton/lpt-parser/parser.lua:324
end -- ./lepton/lpt-parser/parser.lua:324
local function markImplicit(t) -- ./lepton/lpt-parser/parser.lua:340
t["implicit"] = true -- ./lepton/lpt-parser/parser.lua:341
return t -- ./lepton/lpt-parser/parser.lua:342
end -- ./lepton/lpt-parser/parser.lua:342
local function statToExpr(t) -- ./lepton/lpt-parser/parser.lua:345
t["tag"] = t["tag"] .. "Expr" -- ./lepton/lpt-parser/parser.lua:346
return t -- ./lepton/lpt-parser/parser.lua:347
end -- ./lepton/lpt-parser/parser.lua:347
local function fixStructure(t) -- ./lepton/lpt-parser/parser.lua:350
local i = 1 -- ./lepton/lpt-parser/parser.lua:351
while i <= # t do -- ./lepton/lpt-parser/parser.lua:352
if type(t[i]) == "table" then -- ./lepton/lpt-parser/parser.lua:353
fixStructure(t[i]) -- ./lepton/lpt-parser/parser.lua:354
for j = # t[i], 1, - 1 do -- ./lepton/lpt-parser/parser.lua:355
local stat = t[i][j] -- ./lepton/lpt-parser/parser.lua:356
if type(stat) == "table" and stat["move_up_block"] and stat["move_up_block"] > 0 then -- ./lepton/lpt-parser/parser.lua:357
table["remove"](t[i], j) -- ./lepton/lpt-parser/parser.lua:358
table["insert"](t, i + 1, stat) -- ./lepton/lpt-parser/parser.lua:359
if t["tag"] == "Block" or t["tag"] == "Do" then -- ./lepton/lpt-parser/parser.lua:360
stat["move_up_block"] = stat["move_up_block"] - 1 -- ./lepton/lpt-parser/parser.lua:361
end -- ./lepton/lpt-parser/parser.lua:361
end -- ./lepton/lpt-parser/parser.lua:361
end -- ./lepton/lpt-parser/parser.lua:361
end -- ./lepton/lpt-parser/parser.lua:361
i = i + 1 -- ./lepton/lpt-parser/parser.lua:366
end -- ./lepton/lpt-parser/parser.lua:366
return t -- ./lepton/lpt-parser/parser.lua:368
end -- ./lepton/lpt-parser/parser.lua:368
local function eStart(label) -- ./lepton/lpt-parser/parser.lua:371
return e(sym("{"), label) -- ./lepton/lpt-parser/parser.lua:372
end -- ./lepton/lpt-parser/parser.lua:372
local function eEnd(label) -- ./lepton/lpt-parser/parser.lua:375
return e(sym("}"), label) -- ./lepton/lpt-parser/parser.lua:376
end -- ./lepton/lpt-parser/parser.lua:376
local function eBlkStartEnd(startLabel, endLabel, canFollow) -- ./lepton/lpt-parser/parser.lua:379
if canFollow then -- ./lepton/lpt-parser/parser.lua:380
return eStart(startLabel) * V("Block") * eEnd(endLabel) * canFollow ^ - 1 -- ./lepton/lpt-parser/parser.lua:381
else -- ./lepton/lpt-parser/parser.lua:381
return eStart(startLabel) * V("Block") * eEnd(endLabel) -- ./lepton/lpt-parser/parser.lua:383
end -- ./lepton/lpt-parser/parser.lua:383
end -- ./lepton/lpt-parser/parser.lua:383
local function mb(patt) -- ./lepton/lpt-parser/parser.lua:387
return # patt / 0 * patt -- ./lepton/lpt-parser/parser.lua:388
end -- ./lepton/lpt-parser/parser.lua:388
local function setAttribute(attribute) -- ./lepton/lpt-parser/parser.lua:391
return function(assign) -- ./lepton/lpt-parser/parser.lua:392
assign[1]["tag"] = "AttributeNameList" -- ./lepton/lpt-parser/parser.lua:393
for _, id in ipairs(assign[1]) do -- ./lepton/lpt-parser/parser.lua:394
if id["tag"] == "Id" then -- ./lepton/lpt-parser/parser.lua:395
id["tag"] = "AttributeId" -- ./lepton/lpt-parser/parser.lua:396
id[2] = attribute -- ./lepton/lpt-parser/parser.lua:397
elseif id["tag"] == "DestructuringId" then -- ./lepton/lpt-parser/parser.lua:398
for _, did in ipairs(id) do -- ./lepton/lpt-parser/parser.lua:399
did["tag"] = "AttributeId" -- ./lepton/lpt-parser/parser.lua:400
did[2] = attribute -- ./lepton/lpt-parser/parser.lua:401
end -- ./lepton/lpt-parser/parser.lua:401
end -- ./lepton/lpt-parser/parser.lua:401
end -- ./lepton/lpt-parser/parser.lua:401
return assign -- ./lepton/lpt-parser/parser.lua:405
end -- ./lepton/lpt-parser/parser.lua:405
end -- ./lepton/lpt-parser/parser.lua:405
local stacks = { ["lexpr"] = {} } -- ./lepton/lpt-parser/parser.lua:410
local function push(f) -- ./lepton/lpt-parser/parser.lua:412
return Cmt(P(""), function() -- ./lepton/lpt-parser/parser.lua:413
table["insert"](stacks[f], true) -- ./lepton/lpt-parser/parser.lua:414
return true -- ./lepton/lpt-parser/parser.lua:415
end) -- ./lepton/lpt-parser/parser.lua:415
end -- ./lepton/lpt-parser/parser.lua:415
local function pop(f) -- ./lepton/lpt-parser/parser.lua:418
return Cmt(P(""), function() -- ./lepton/lpt-parser/parser.lua:419
table["remove"](stacks[f]) -- ./lepton/lpt-parser/parser.lua:420
return true -- ./lepton/lpt-parser/parser.lua:421
end) -- ./lepton/lpt-parser/parser.lua:421
end -- ./lepton/lpt-parser/parser.lua:421
local function when(f) -- ./lepton/lpt-parser/parser.lua:424
return Cmt(P(""), function() -- ./lepton/lpt-parser/parser.lua:425
return # stacks[f] > 0 -- ./lepton/lpt-parser/parser.lua:426
end) -- ./lepton/lpt-parser/parser.lua:426
end -- ./lepton/lpt-parser/parser.lua:426
local function set(f, patt) -- ./lepton/lpt-parser/parser.lua:429
return push(f) * patt * pop(f) -- ./lepton/lpt-parser/parser.lua:430
end -- ./lepton/lpt-parser/parser.lua:430
local G = { -- ./lepton/lpt-parser/parser.lua:435
V("Lua"), -- ./lepton/lpt-parser/parser.lua:435
["Lua"] = (V("Shebang") ^ - 1 * V("Skip") * V("Block") * e(P(- 1), "Extra")) / fixStructure, -- ./lepton/lpt-parser/parser.lua:436
["Shebang"] = P("#!") * (P(1) - P("\
")) ^ 0, -- ./lepton/lpt-parser/parser.lua:437
["Block"] = tagC("Block", (V("Stat") + - V("BlockEnd") * throw("InvalidStat")) ^ 0 * ((V("RetStat") + V("ImplicitPushStat")) * sym(";") ^ - 1) ^ - 1), -- ./lepton/lpt-parser/parser.lua:439
["Stat"] = V("IfStat") + V("DoStat") + V("WhileStat") + V("RepeatStat") + V("ForStat") + V("LocalStat") + V("FuncStat") + V("BreakStat") + V("LabelStat") + V("GoToStat") + V("LetStat") + V("ConstStat") + V("CloseStat") + V("FuncCall") + V("Assignment") + V("ContinueStat") + V("PushStat") + sym(";"), -- ./lepton/lpt-parser/parser.lua:445
["BlockEnd"] = P("return") + sym("}") + (sym("}") * "elseif") + (sym("}") * "else") + (sym("}") * "until") + "]" + - 1 + V("ImplicitPushStat") + V("Assignment"), -- ./lepton/lpt-parser/parser.lua:446
["SingleStatBlock"] = tagC("Block", V("Stat") + V("RetStat") + V("ImplicitPushStat")), -- ./lepton/lpt-parser/parser.lua:448
["BlockNoErr"] = tagC("Block", V("Stat") ^ 0 * ((V("RetStat") + V("ImplicitPushStat")) * sym(";") ^ - 1) ^ - 1), -- ./lepton/lpt-parser/parser.lua:449
["IfStat"] = tagC("If", V("IfPart")), -- ./lepton/lpt-parser/parser.lua:451
["IfPart"] = kw("if") * set("lexpr", e(parenAround(V("Expr")), "ExprIf")) * eBlkStartEnd("OIf", "CIf", V("ElseIfPart") + V("ElsePart")), -- ./lepton/lpt-parser/parser.lua:452
["ElseIfPart"] = kw("elseif") * set("lexpr", e(parenAround(V("Expr")), "ExprEIf")) * eBlkStartEnd("OEIf", "CIf", V("ElseIfPart") + V("ElsePart")), -- ./lepton/lpt-parser/parser.lua:453
["ElsePart"] = kw("else") * eBlkStartEnd("OElse", "CIf"), -- ./lepton/lpt-parser/parser.lua:454
["DoStat"] = kw("do") * eBlkStartEnd("ODo", "CDo") / tagDo, -- ./lepton/lpt-parser/parser.lua:456
["WhileStat"] = tagC("While", kw("while") * set("lexpr", e(parenAround(V("Expr")), "ExprWhile")) * V("WhileBody")), -- ./lepton/lpt-parser/parser.lua:457
["WhileBody"] = eBlkStartEnd("DoWhile", "EndWhile"), -- ./lepton/lpt-parser/parser.lua:458
["RepeatStat"] = tagC("Repeat", kw("repeat") * eBlkStartEnd("ORep", "CRep") * e(kw("until"), "UntilRep") * e(parenAround(V("Expr")), "ExprRep")), -- ./lepton/lpt-parser/parser.lua:459
["ForStat"] = kw("for") * e(V("ForNum") + V("ForIn"), "ForRange"), -- ./lepton/lpt-parser/parser.lua:461
["ForNum"] = tagC("Fornum", parenAround(V("Id") * sym(":") * V("NumRange")) * V("ForBody")), -- ./lepton/lpt-parser/parser.lua:462
["NumRange"] = e(V("Expr"), "ForRangeStart") * e(sym(","), "ForRangeComma") * e(V("Expr"), "ForRangeEnd") * (sym(":") * e(V("Expr"), "ForRangeStep")) ^ - 1, -- ./lepton/lpt-parser/parser.lua:464
["ForIn"] = tagC("Forin", parenAround(V("DestructuringNameList") * e(sym(":"), "InFor") * e(V("ExprList"), "EListFor")) * V("ForBody")), -- ./lepton/lpt-parser/parser.lua:465
["ForBody"] = eBlkStartEnd("OFor", "CFor"), -- ./lepton/lpt-parser/parser.lua:466
["LocalStat"] = kw("local") * e(V("LocalFunc") + V("LocalAssign"), "DefLocal"), -- ./lepton/lpt-parser/parser.lua:468
["LocalFunc"] = tagC("Localrec", kw("function") * e(V("Id"), "NameLFunc") * V("FuncBody")) / fixFuncStat, -- ./lepton/lpt-parser/parser.lua:469
["LocalAssign"] = tagC("Local", V("AttributeNameList") * (sym("=") * e(V("ExprList"), "EListLAssign") + Ct(Cc()))) + tagC("Local", V("DestructuringNameList") * sym("=") * e(V("ExprList"), "EListLAssign")), -- ./lepton/lpt-parser/parser.lua:471
["LetStat"] = kw("let") * e(V("LetAssign"), "DefLet"), -- ./lepton/lpt-parser/parser.lua:473
["LetAssign"] = tagC("Let", V("NameList") * (sym("=") * e(V("ExprList"), "EListLAssign") + Ct(Cc()))) + tagC("Let", V("DestructuringNameList") * sym("=") * e(V("ExprList"), "EListLAssign")), -- ./lepton/lpt-parser/parser.lua:475
["ConstStat"] = kw("const") * e(V("AttributeAssign") / setAttribute("const"), "DefConst"), -- ./lepton/lpt-parser/parser.lua:477
["CloseStat"] = kw("close") * e(V("AttributeAssign") / setAttribute("close"), "DefClose"), -- ./lepton/lpt-parser/parser.lua:478
["AttributeAssign"] = tagC("Local", V("NameList") * (sym("=") * e(V("ExprList"), "EListLAssign") + Ct(Cc()))) + tagC("Local", V("DestructuringNameList") * sym("=") * e(V("ExprList"), "EListLAssign")), -- ./lepton/lpt-parser/parser.lua:480
["Assignment"] = tagC("Set", (V("VarList") + V("DestructuringNameList")) * V("BinOp") ^ - 1 * ((P("=") - "==") / "=") * ((V("BinOp") - P("-")) + # (P("-") * V("Space")) * V("BinOp")) ^ - 1 * V("Skip") * e(V("ExprList"), "EListAssign")), -- ./lepton/lpt-parser/parser.lua:483
["FuncStat"] = tagC("Set", kw("function") * e(V("FuncName"), "FuncName") * V("FuncBody")) / fixFuncStat, -- ./lepton/lpt-parser/parser.lua:485
["FuncName"] = Cf(V("Id") * (sym(".") * e(V("StrId"), "NameFunc1")) ^ 0, insertIndex) * (sym(":") * e(V("StrId"), "NameFunc2")) ^ - 1 / markMethod, -- ./lepton/lpt-parser/parser.lua:487
["FuncBody"] = tagC("Function", V("FuncParams") * eBlkStartEnd("OFunc", "CFunc")), -- ./lepton/lpt-parser/parser.lua:488
["FuncParams"] = e(sym("("), "OParenPList") * V("ParList") * e(sym(")"), "CParenPList"), -- ./lepton/lpt-parser/parser.lua:489
["ParList"] = V("NamedParList") * (sym(",") * e(tagC("Dots", sym("...")), "ParList")) ^ - 1 / addDots + Ct(tagC("Dots", sym("..."))) + Ct(Cc()), -- ./lepton/lpt-parser/parser.lua:492
["ArrowFuncDef"] = tagC("Function", V("ArrowFuncParams") * sym("->") * V("ArrowFuncBody")) / fixArrowFunc, -- ./lepton/lpt-parser/parser.lua:494
["ArrowFuncParams"] = (sym(":") / ":") ^ - 1 * (parenAround(V("ParList")) + tagC("NamedPar", V("NamedPar"))), -- ./lepton/lpt-parser/parser.lua:495
["ArrowFuncBody"] = (- sym("{") * tagC("Block", tagC("Push", V("Expr"))) * - sym("}")) + eBlkStartEnd("OArrowFunc", "CArrowFunc"), -- ./lepton/lpt-parser/parser.lua:496
["NamedParList"] = tagC("NamedParList", commaSep(V("NamedPar"))), -- ./lepton/lpt-parser/parser.lua:498
["NamedPar"] = tagC("ParPair", V("ParKey") * e(sym("="), "EqField") * e(V("Expr"), "ExprField")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:499
["ParKey"] = V("Id") * # ("=" * - P("=")), -- ./lepton/lpt-parser/parser.lua:500
["LabelStat"] = tagC("Label", sym("::") * e(V("Name"), "Label") * e(sym("::"), "CloseLabel")), -- ./lepton/lpt-parser/parser.lua:502
["GoToStat"] = tagC("Goto", kw("goto") * e(V("Name"), "Goto")), -- ./lepton/lpt-parser/parser.lua:503
["BreakStat"] = tagC("Break", kw("break")), -- ./lepton/lpt-parser/parser.lua:504
["ContinueStat"] = tagC("Continue", kw("continue")), -- ./lepton/lpt-parser/parser.lua:505
["RetStat"] = tagC("Return", kw("return") * commaSep(V("Expr"), "RetList") ^ - 1), -- ./lepton/lpt-parser/parser.lua:506
["PushStat"] = tagC("Push", kw("push") * commaSep(V("Expr"), "RetList") ^ - 1), -- ./lepton/lpt-parser/parser.lua:508
["ImplicitPushStat"] = tagC("Push", commaSep(V("Expr"), "RetList")) / markImplicit, -- ./lepton/lpt-parser/parser.lua:509
["NameList"] = tagC("NameList", commaSep(V("Id"))), -- ./lepton/lpt-parser/parser.lua:511
["DestructuringNameList"] = tagC("NameList", commaSep(V("DestructuringId"))), -- ./lepton/lpt-parser/parser.lua:512
["AttributeNameList"] = tagC("AttributeNameList", commaSep(V("AttributeId"))), -- ./lepton/lpt-parser/parser.lua:513
["VarList"] = tagC("VarList", commaSep(V("VarExpr"))), -- ./lepton/lpt-parser/parser.lua:514
["ExprList"] = tagC("ExpList", commaSep(V("Expr"), "ExprList")), -- ./lepton/lpt-parser/parser.lua:515
["DestructuringId"] = tagC("DestructuringId", sym("{") * V("DestructuringIdFieldList") * e(sym("}"), "CBraceDestructuring")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:517
["DestructuringIdFieldList"] = sepBy(V("DestructuringIdField"), V("FieldSep")) * V("FieldSep") ^ - 1, -- ./lepton/lpt-parser/parser.lua:518
["DestructuringIdField"] = tagC("Pair", V("FieldKey") * e(sym("="), "DestructuringEqField") * e(V("Id"), "DestructuringExprField")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:519
["Expr"] = V("OrExpr"), -- ./lepton/lpt-parser/parser.lua:521
["OrExpr"] = chainOp(V("AndExpr"), V("OrOp"), "OrExpr"), -- ./lepton/lpt-parser/parser.lua:522
["AndExpr"] = chainOp(V("RelExpr"), V("AndOp"), "AndExpr"), -- ./lepton/lpt-parser/parser.lua:523
["RelExpr"] = chainOp(V("BOrExpr"), V("RelOp"), "RelExpr"), -- ./lepton/lpt-parser/parser.lua:524
["BOrExpr"] = chainOp(V("BXorExpr"), V("BOrOp"), "BOrExpr"), -- ./lepton/lpt-parser/parser.lua:525
["BXorExpr"] = chainOp(V("BAndExpr"), V("BXorOp"), "BXorExpr"), -- ./lepton/lpt-parser/parser.lua:526
["BAndExpr"] = chainOp(V("ShiftExpr"), V("BAndOp"), "BAndExpr"), -- ./lepton/lpt-parser/parser.lua:527
["ShiftExpr"] = chainOp(V("ConcatExpr"), V("ShiftOp"), "ShiftExpr"), -- ./lepton/lpt-parser/parser.lua:528
["ConcatExpr"] = V("AddExpr") * (V("ConcatOp") * e(V("ConcatExpr"), "ConcatExpr")) ^ - 1 / binaryOp, -- ./lepton/lpt-parser/parser.lua:529
["AddExpr"] = chainOp(V("MulExpr"), V("AddOp"), "AddExpr"), -- ./lepton/lpt-parser/parser.lua:530
["MulExpr"] = chainOp(V("UnaryExpr"), V("MulOp"), "MulExpr"), -- ./lepton/lpt-parser/parser.lua:531
["UnaryExpr"] = V("UnaryOp") * e(V("UnaryExpr"), "UnaryExpr") / unaryOp + V("PowExpr"), -- ./lepton/lpt-parser/parser.lua:533
["PowExpr"] = V("SimpleExpr") * (V("PowOp") * e(V("UnaryExpr"), "PowExpr")) ^ - 1 / binaryOp, -- ./lepton/lpt-parser/parser.lua:534
["SimpleExpr"] = tagC("Number", V("Number")) + tagC("Nil", kw("nil")) + tagC("Boolean", kw("false") * Cc(false)) + tagC("Boolean", kw("true") * Cc(true)) + tagC("Dots", sym("...")) + V("FuncDef") + V("ArrowFuncDef") + (when("lexpr") * tagC("LetExpr", mb(V("DestructuringNameList")) * sym("=") * - sym("=") * e(V("ExprList"), "EListLAssign"))) + V("SuffixedExpr") + V("StatExpr"), -- ./lepton/lpt-parser/parser.lua:544
["StatExpr"] = (V("IfStat") + V("DoStat") + V("WhileStat") + V("RepeatStat") + V("ForStat")) / statToExpr, -- ./lepton/lpt-parser/parser.lua:546
["FuncCall"] = Cmt(V("SuffixedExpr"), function(s, i, exp) -- ./lepton/lpt-parser/parser.lua:548
return exp["tag"] == "Call" or exp["tag"] == "SafeCall", exp -- ./lepton/lpt-parser/parser.lua:548
end), -- ./lepton/lpt-parser/parser.lua:548
["VarExpr"] = Cmt(V("SuffixedExpr"), function(s, i, exp) -- ./lepton/lpt-parser/parser.lua:549
return exp["tag"] == "Id" or exp["tag"] == "Index", exp -- ./lepton/lpt-parser/parser.lua:549
end), -- ./lepton/lpt-parser/parser.lua:549
["SuffixedExpr"] = Cf(V("PrimaryExpr") * (V("Index") + V("MethodStub") + V("Call")) ^ 0 + V("NoCallPrimaryExpr") * - V("Call") * (V("Index") + V("MethodStub") + V("Call")) ^ 0 + V("NoCallPrimaryExpr"), makeSuffixedExpr), -- ./lepton/lpt-parser/parser.lua:553
["PrimaryExpr"] = V("SelfId") * (V("SelfCall") + V("SelfIndex")) + V("Id") + tagC("Paren", sym("(") * e(V("Expr"), "ExprParen") * e(sym(")"), "CParenExpr")), -- ./lepton/lpt-parser/parser.lua:556
["NoCallPrimaryExpr"] = tagC("String", V("String")) + V("Table") + V("TableCompr"), -- ./lepton/lpt-parser/parser.lua:557
["Index"] = tagC("DotIndex", sym("." * - P(".")) * e(V("StrId"), "NameIndex")) + tagC("ArrayIndex", sym("[" * - P(S("=["))) * e(V("Expr"), "ExprIndex") * e(sym("]"), "CBracketIndex")) + tagC("SafeDotIndex", sym("?." * - P(".")) * e(V("StrId"), "NameIndex")) + tagC("SafeArrayIndex", sym("?[" * - P(S("=["))) * e(V("Expr"), "ExprIndex") * e(sym("]"), "CBracketIndex")), -- ./lepton/lpt-parser/parser.lua:561
["MethodStub"] = tagC("MethodStub", sym(":" * - P(":")) * e(V("StrId"), "NameMeth")) + tagC("SafeMethodStub", sym("?:" * - P(":")) * e(V("StrId"), "NameMeth")), -- ./lepton/lpt-parser/parser.lua:563
["Call"] = tagC("Call", V("FuncArgs")) + tagC("SafeCall", P("?") * V("FuncArgs")), -- ./lepton/lpt-parser/parser.lua:565
["SelfCall"] = tagC("MethodStub", V("StrId")) * V("Call"), -- ./lepton/lpt-parser/parser.lua:566
["SelfIndex"] = tagC("DotIndex", V("StrId")), -- ./lepton/lpt-parser/parser.lua:567
["FuncDef"] = (kw("function") * V("FuncBody")), -- ./lepton/lpt-parser/parser.lua:569
["FuncArgs"] = sym("(") * commaSep(V("Expr"), "ArgList") ^ - 1 * e(sym(")"), "CParenArgs"), -- ./lepton/lpt-parser/parser.lua:570
["Table"] = tagC("Table", sym("{") * V("FieldList") ^ - 1 * e(sym("}"), "CBraceTable")), -- ./lepton/lpt-parser/parser.lua:572
["FieldList"] = sepBy(V("Field"), V("FieldSep")) * V("FieldSep") ^ - 1, -- ./lepton/lpt-parser/parser.lua:573
["Field"] = tagC("Pair", V("FieldKey") * e(sym("="), "EqField") * e(V("Expr"), "ExprField")) + V("Expr"), -- ./lepton/lpt-parser/parser.lua:575
["FieldKey"] = sym("[" * - P(S("=["))) * e(V("Expr"), "ExprFKey") * e(sym("]"), "CBracketFKey") + V("StrId") * # ("=" * - P("=")), -- ./lepton/lpt-parser/parser.lua:577
["FieldSep"] = sym(",") + sym(";"), -- ./lepton/lpt-parser/parser.lua:578
["TableCompr"] = tagC("TableCompr", sym("[") * V("Block") * e(sym("]"), "CBracketTableCompr")), -- ./lepton/lpt-parser/parser.lua:580
["SelfId"] = tagC("Id", sym("@") / "self"), -- ./lepton/lpt-parser/parser.lua:582
["Id"] = tagC("Id", V("Name")) + V("SelfId"), -- ./lepton/lpt-parser/parser.lua:583
["AttributeSelfId"] = tagC("AttributeId", sym("@") / "self" * V("Attribute") ^ - 1), -- ./lepton/lpt-parser/parser.lua:584
["AttributeId"] = tagC("AttributeId", V("Name") * V("Attribute") ^ - 1) + V("AttributeSelfId"), -- ./lepton/lpt-parser/parser.lua:585
["StrId"] = tagC("String", V("Name")), -- ./lepton/lpt-parser/parser.lua:586
["Attribute"] = sym("<") * e(kw("const") / "const" + kw("close") / "close", "UnknownAttribute") * e(sym(">"), "CBracketAttribute"), -- ./lepton/lpt-parser/parser.lua:588
["Skip"] = (V("Space") + V("Comment")) ^ 0, -- ./lepton/lpt-parser/parser.lua:591
["Space"] = space ^ 1, -- ./lepton/lpt-parser/parser.lua:592
["Comment"] = P("--") * V("LongStr") / 0 + P("--") * (P(1) - P("\
")) ^ 0, -- ./lepton/lpt-parser/parser.lua:594
["Name"] = token(- V("Reserved") * C(V("Ident"))), -- ./lepton/lpt-parser/parser.lua:596
["Reserved"] = V("Keywords") * - V("IdRest"), -- ./lepton/lpt-parser/parser.lua:597
["Keywords"] = P("break") + "elseif" + "else" + "false" + "for" + "function" + "goto" + "if" + "local" + "nil" + "repeat" + "return" + "true" + "until" + "while", -- ./lepton/lpt-parser/parser.lua:601
["Ident"] = V("IdStart") * V("IdRest") ^ 0, -- ./lepton/lpt-parser/parser.lua:602
["IdStart"] = alpha + P("_"), -- ./lepton/lpt-parser/parser.lua:603
["IdRest"] = alnum + P("_"), -- ./lepton/lpt-parser/parser.lua:604
["Number"] = token(C(V("Hex") + V("Float") + V("Int"))), -- ./lepton/lpt-parser/parser.lua:606
["Hex"] = (P("0x") + "0X") * ((xdigit ^ 0 * V("DeciHex")) + (e(xdigit ^ 1, "DigitHex") * V("DeciHex") ^ - 1)) * V("ExpoHex") ^ - 1, -- ./lepton/lpt-parser/parser.lua:607
["Float"] = V("Decimal") * V("Expo") ^ - 1 + V("Int") * V("Expo"), -- ./lepton/lpt-parser/parser.lua:609
["Decimal"] = digit ^ 1 * "." * digit ^ 0 + P(".") * - P(".") * e(digit ^ 1, "DigitDeci"), -- ./lepton/lpt-parser/parser.lua:611
["DeciHex"] = P(".") * xdigit ^ 0, -- ./lepton/lpt-parser/parser.lua:612
["Expo"] = S("eE") * S("+-") ^ - 1 * e(digit ^ 1, "DigitExpo"), -- ./lepton/lpt-parser/parser.lua:613
["ExpoHex"] = S("pP") * S("+-") ^ - 1 * e(xdigit ^ 1, "DigitExpo"), -- ./lepton/lpt-parser/parser.lua:614
["Int"] = digit ^ 1, -- ./lepton/lpt-parser/parser.lua:615
["String"] = token(V("ShortStr") + V("LongStr")), -- ./lepton/lpt-parser/parser.lua:617
["ShortStr"] = P("\"") * Cs((V("EscSeq") + (P(1) - S("\"\
"))) ^ 0) * e(P("\""), "Quote") + P("'") * Cs((V("EscSeq") + (P(1) - S("'\
"))) ^ 0) * e(P("'"), "Quote"), -- ./lepton/lpt-parser/parser.lua:619
["EscSeq"] = P("\\") / "" * (P("a") / "\7" + P("b") / "\8" + P("f") / "\12" + P("n") / "\
" + P("r") / "\13" + P("t") / "\9" + P("v") / "\11" + P("\
") / "\
" + P("\13") / "\
" + P("\\") / "\\" + P("\"") / "\"" + P("'") / "'" + P("z") * space ^ 0 / "" + digit * digit ^ - 2 / tonumber / string["char"] + P("x") * e(C(xdigit * xdigit), "HexEsc") * Cc(16) / tonumber / string["char"] + P("u") * e("{", "OBraceUEsc") * e(C(xdigit ^ 1), "DigitUEsc") * Cc(16) * e("}", "CBraceUEsc") / tonumber / (utf8 and utf8["char"] or string["char"]) + throw("EscSeq")), -- ./lepton/lpt-parser/parser.lua:649
["LongStr"] = V("Open") * C((P(1) - V("CloseEq")) ^ 0) * e(V("Close"), "CloseLStr") / function(s, eqs) -- ./lepton/lpt-parser/parser.lua:652
return s -- ./lepton/lpt-parser/parser.lua:652
end, -- ./lepton/lpt-parser/parser.lua:652
["Open"] = "[" * Cg(V("Equals"), "openEq") * "[" * P("\
") ^ - 1, -- ./lepton/lpt-parser/parser.lua:653
["Close"] = "]" * C(V("Equals")) * "]", -- ./lepton/lpt-parser/parser.lua:654
["Equals"] = P("=") ^ 0, -- ./lepton/lpt-parser/parser.lua:655
["CloseEq"] = Cmt(V("Close") * Cb("openEq"), function(s, i, closeEq, openEq) -- ./lepton/lpt-parser/parser.lua:656
return # openEq == # closeEq -- ./lepton/lpt-parser/parser.lua:656
end), -- ./lepton/lpt-parser/parser.lua:656
["OrOp"] = sym("||") / "or", -- ./lepton/lpt-parser/parser.lua:658
["AndOp"] = sym("&&") / "and", -- ./lepton/lpt-parser/parser.lua:659
["RelOp"] = sym("!=") / "ne" + sym("==") / "eq" + sym("<=") / "le" + sym(">=") / "ge" + sym("<") / "lt" + sym(">") / "gt", -- ./lepton/lpt-parser/parser.lua:665
["BOrOp"] = sym("|" - P("||")) / "bor", -- ./lepton/lpt-parser/parser.lua:666
["BXorOp"] = sym("~") / "bxor", -- ./lepton/lpt-parser/parser.lua:667
["BAndOp"] = sym("&" - P("&&")) / "band", -- ./lepton/lpt-parser/parser.lua:668
["ShiftOp"] = sym("<<") / "shl" + sym(">>") / "shr", -- ./lepton/lpt-parser/parser.lua:670
["ConcatOp"] = sym("++") / "concat", -- ./lepton/lpt-parser/parser.lua:671
["AddOp"] = sym("+" - P("++")) / "add" + sym("-" - P("->")) / "sub", -- ./lepton/lpt-parser/parser.lua:673
["MulOp"] = sym("*") / "mul" + sym("//") / "idiv" + sym("/") / "div" + sym("%") / "mod", -- ./lepton/lpt-parser/parser.lua:677
["UnaryOp"] = sym("!") / "not" + sym("-") / "unm" + sym("#") / "len" + sym("~") / "bnot", -- ./lepton/lpt-parser/parser.lua:681
["PowOp"] = sym("^") / "pow", -- ./lepton/lpt-parser/parser.lua:682
["BinOp"] = V("OrOp") + V("AndOp") + V("BOrOp") + V("BXorOp") + V("BAndOp") + V("ShiftOp") + V("ConcatOp") + V("AddOp") + V("MulOp") + V("PowOp") -- ./lepton/lpt-parser/parser.lua:683
} -- ./lepton/lpt-parser/parser.lua:683
local macroidentifier = { -- ./lepton/lpt-parser/parser.lua:688
e(V("MacroIdentifier"), "InvalidStat") * e(P(- 1), "Extra"), -- ./lepton/lpt-parser/parser.lua:689
["MacroIdentifier"] = tagC("MacroFunction", V("Id") * sym("(") * V("MacroFunctionArgs") * e(sym(")"), "CParenPList")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:692
["MacroFunctionArgs"] = V("NameList") * (sym(",") * e(tagC("Dots", sym("...")), "ParList")) ^ - 1 / addDots + Ct(tagC("Dots", sym("..."))) + Ct(Cc()) -- ./lepton/lpt-parser/parser.lua:696
} -- ./lepton/lpt-parser/parser.lua:696
for k, v in pairs(G) do -- ./lepton/lpt-parser/parser.lua:700
if macroidentifier[k] == nil then -- ./lepton/lpt-parser/parser.lua:701
macroidentifier[k] = v -- ./lepton/lpt-parser/parser.lua:702
end -- ./lepton/lpt-parser/parser.lua:702
end -- ./lepton/lpt-parser/parser.lua:702
local parser = {} -- ./lepton/lpt-parser/parser.lua:708
local validator = require("lepton.lpt-parser.validator") -- ./lepton/lpt-parser/parser.lua:710
local validate = validator["validate"] -- ./lepton/lpt-parser/parser.lua:711
local syntaxerror = validator["syntaxerror"] -- ./lepton/lpt-parser/parser.lua:712
parser["parse"] = function(subject, filename) -- ./lepton/lpt-parser/parser.lua:714
local errorinfo = { -- ./lepton/lpt-parser/parser.lua:715
["subject"] = subject, -- ./lepton/lpt-parser/parser.lua:715
["filename"] = filename -- ./lepton/lpt-parser/parser.lua:715
} -- ./lepton/lpt-parser/parser.lua:715
lpeg["setmaxstack"](1000) -- ./lepton/lpt-parser/parser.lua:716
local ast, label, errpos = lpeg["match"](G, subject, nil, errorinfo) -- ./lepton/lpt-parser/parser.lua:717
if not ast then -- ./lepton/lpt-parser/parser.lua:718
local errmsg = labels[label][2] -- ./lepton/lpt-parser/parser.lua:719
return ast, syntaxerror(errorinfo, errpos, errmsg) -- ./lepton/lpt-parser/parser.lua:720
end -- ./lepton/lpt-parser/parser.lua:720
return validate(ast, errorinfo) -- ./lepton/lpt-parser/parser.lua:722
end -- ./lepton/lpt-parser/parser.lua:722
parser["parsemacroidentifier"] = function(subject, filename) -- ./lepton/lpt-parser/parser.lua:725
local errorinfo = { -- ./lepton/lpt-parser/parser.lua:726
["subject"] = subject, -- ./lepton/lpt-parser/parser.lua:726
["filename"] = filename -- ./lepton/lpt-parser/parser.lua:726
} -- ./lepton/lpt-parser/parser.lua:726
lpeg["setmaxstack"](1000) -- ./lepton/lpt-parser/parser.lua:727
local ast, label, errpos = lpeg["match"](macroidentifier, subject, nil, errorinfo) -- ./lepton/lpt-parser/parser.lua:728
if not ast then -- ./lepton/lpt-parser/parser.lua:729
local errmsg = labels[label][2] -- ./lepton/lpt-parser/parser.lua:730
return ast, syntaxerror(errorinfo, errpos, errmsg) -- ./lepton/lpt-parser/parser.lua:731
end -- ./lepton/lpt-parser/parser.lua:731
return ast -- ./lepton/lpt-parser/parser.lua:733
end -- ./lepton/lpt-parser/parser.lua:733
return parser -- ./lepton/lpt-parser/parser.lua:736
end -- ./lepton/lpt-parser/parser.lua:736
local parser = _() or parser -- ./lepton/lpt-parser/parser.lua:741
package["loaded"]["lepton.lpt-parser.parser"] = parser or true -- ./lepton/lpt-parser/parser.lua:742
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
