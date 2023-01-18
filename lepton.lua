local lepton = { ["VERSION"] = "1.0.0" } -- lepton.can:2
package["loaded"]["lepton"] = lepton -- lepton.can:4
local function _() -- lepton.can:7
local lepton = require("lepton") -- ./lepton/util.can:1
local util = {} -- ./lepton/util.can:2
util["search"] = function(modpath, exts) -- ./lepton/util.can:4
if exts == nil then exts = {} end -- ./lepton/util.can:4
for _, ext in ipairs(exts) do -- ./lepton/util.can:5
for path in package["path"]:gmatch("[^;]+") do -- ./lepton/util.can:6
local fpath = path:gsub("%.lua", "." .. ext):gsub("%?", (modpath:gsub("%.", "/"))) -- ./lepton/util.can:7
local f = io["open"](fpath) -- ./lepton/util.can:8
if f then -- ./lepton/util.can:9
f:close() -- ./lepton/util.can:10
return fpath -- ./lepton/util.can:11
end -- ./lepton/util.can:11
end -- ./lepton/util.can:11
end -- ./lepton/util.can:11
end -- ./lepton/util.can:11
util["load"] = function(str, name, env) -- ./lepton/util.can:17
if _VERSION == "Lua 5.1" then -- ./lepton/util.can:18
local fn, err = loadstring(str, name) -- ./lepton/util.can:19
if not fn then -- ./lepton/util.can:20
return fn, err -- ./lepton/util.can:20
end -- ./lepton/util.can:20
return env ~= nil and setfenv(fn, env) or fn -- ./lepton/util.can:21
else -- ./lepton/util.can:21
if env then -- ./lepton/util.can:23
return load(str, name, nil, env) -- ./lepton/util.can:24
else -- ./lepton/util.can:24
return load(str, name) -- ./lepton/util.can:26
end -- ./lepton/util.can:26
end -- ./lepton/util.can:26
end -- ./lepton/util.can:26
util["recmerge"] = function(...) -- ./lepton/util.can:31
local r = {} -- ./lepton/util.can:32
for _, t in ipairs({ ... }) do -- ./lepton/util.can:33
for k, v in pairs(t) do -- ./lepton/util.can:34
if type(v) == "table" then -- ./lepton/util.can:35
r[k] = util["merge"](v, r[k]) -- ./lepton/util.can:36
else -- ./lepton/util.can:36
r[k] = v -- ./lepton/util.can:38
end -- ./lepton/util.can:38
end -- ./lepton/util.can:38
end -- ./lepton/util.can:38
return r -- ./lepton/util.can:42
end -- ./lepton/util.can:42
util["merge"] = function(...) -- ./lepton/util.can:45
local r = {} -- ./lepton/util.can:46
for _, t in ipairs({ ... }) do -- ./lepton/util.can:47
for k, v in pairs(t) do -- ./lepton/util.can:48
r[k] = v -- ./lepton/util.can:49
end -- ./lepton/util.can:49
end -- ./lepton/util.can:49
return r -- ./lepton/util.can:52
end -- ./lepton/util.can:52
util["cli"] = { -- ./lepton/util.can:55
["addLeptonOptions"] = function(parser) -- ./lepton/util.can:57
parser:group("Compiler options", parser:option("-t --target"):description("Target Lua version: lua54, lua53, lua52, luajit or lua51"):default(lepton["default"]["target"]), parser:option("--indentation"):description("Character(s) used for indentation in the compiled file"):default(lepton["default"]["indentation"]), parser:option("--newline"):description("Character(s) used for newlines in the compiled file"):default(lepton["default"]["newline"]), parser:option("--variable-prefix"):description("Prefix used when lepton needs to set a local variable to provide some functionality"):default(lepton["default"]["variablePrefix"]), parser:flag("--no-map-lines"):description("Do not add comments at the end of each line indicating the associated source line and file (error rewriting will not work)")) -- ./lepton/util.can:76
parser:group("Preprocessor options", parser:flag("--no-builtin-macros"):description("Disable built-in macros"), parser:option("-D --define"):description("Define a preprocessor constant"):args("1-2"):argname({ -- ./lepton/util.can:86
"name", -- ./lepton/util.can:86
"value" -- ./lepton/util.can:86
}):count("*"), parser:option("-I --import"):description("Statically import a module into the compiled file"):argname("module"):count("*")) -- ./lepton/util.can:92
parser:option("--chunkname"):description("Chunkname used when running the code") -- ./lepton/util.can:96
parser:flag("--no-rewrite-errors"):description("Disable error rewriting when running the code") -- ./lepton/util.can:99
end, -- ./lepton/util.can:99
["makeLeptonOptions"] = function(args) -- ./lepton/util.can:103
local preprocessorEnv = {} -- ./lepton/util.can:104
for _, o in ipairs(args["define"]) do -- ./lepton/util.can:105
preprocessorEnv[o[1]] = tonumber(o[2]) or o[2] or true -- ./lepton/util.can:106
end -- ./lepton/util.can:106
local options = { -- ./lepton/util.can:109
["target"] = args["target"], -- ./lepton/util.can:110
["indentation"] = args["indentation"], -- ./lepton/util.can:111
["newline"] = args["newline"], -- ./lepton/util.can:112
["variablePrefix"] = args["variable_prefix"], -- ./lepton/util.can:113
["mapLines"] = not args["no_map_lines"], -- ./lepton/util.can:114
["chunkname"] = args["chunkname"], -- ./lepton/util.can:115
["rewriteErrors"] = not args["no_rewrite_errors"], -- ./lepton/util.can:116
["builtInMacros"] = not args["no_builtin_macros"], -- ./lepton/util.can:117
["preprocessorEnv"] = preprocessorEnv, -- ./lepton/util.can:118
["import"] = args["import"] -- ./lepton/util.can:119
} -- ./lepton/util.can:119
return options -- ./lepton/util.can:121
end -- ./lepton/util.can:121
} -- ./lepton/util.can:121
return util -- ./lepton/util.can:125
end -- ./lepton/util.can:125
local util = _() or util -- ./lepton/util.can:129
package["loaded"]["lepton.util"] = util or true -- ./lepton/util.can:130
local function _() -- ./lepton/util.can:133
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
local util = require("lepton.util") -- ./compiler/lua54.can:1
local targetName = "Lua 5.4" -- ./compiler/lua54.can:3
local unpack = unpack or table["unpack"] -- ./compiler/lua54.can:5
return function(code, ast, options, macros) -- ./compiler/lua54.can:7
if macros == nil then macros = { -- ./compiler/lua54.can:7
["functions"] = {}, -- ./compiler/lua54.can:7
["variables"] = {} -- ./compiler/lua54.can:7
} end -- ./compiler/lua54.can:7
local lastInputPos = 1 -- ./compiler/lua54.can:9
local prevLinePos = 1 -- ./compiler/lua54.can:10
local lastSource = options["chunkname"] or "nil" -- ./compiler/lua54.can:11
local lastLine = 1 -- ./compiler/lua54.can:12
local indentLevel = 0 -- ./compiler/lua54.can:15
local function newline() -- ./compiler/lua54.can:17
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.can:18
if options["mapLines"] then -- ./compiler/lua54.can:19
local sub = code:sub(lastInputPos) -- ./compiler/lua54.can:20
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.can:21
if source and line then -- ./compiler/lua54.can:23
lastSource = source -- ./compiler/lua54.can:24
lastLine = tonumber(line) -- ./compiler/lua54.can:25
else -- ./compiler/lua54.can:25
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.can:27
lastLine = lastLine + (1) -- ./compiler/lua54.can:28
end -- ./compiler/lua54.can:28
end -- ./compiler/lua54.can:28
prevLinePos = lastInputPos -- ./compiler/lua54.can:32
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.can:34
end -- ./compiler/lua54.can:34
return r -- ./compiler/lua54.can:36
end -- ./compiler/lua54.can:36
local function indent() -- ./compiler/lua54.can:39
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:40
return newline() -- ./compiler/lua54.can:41
end -- ./compiler/lua54.can:41
local function unindent() -- ./compiler/lua54.can:44
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:45
return newline() -- ./compiler/lua54.can:46
end -- ./compiler/lua54.can:46
local states = { -- ./compiler/lua54.can:51
["push"] = {}, -- ./compiler/lua54.can:52
["destructuring"] = {}, -- ./compiler/lua54.can:53
["scope"] = {}, -- ./compiler/lua54.can:54
["macroargs"] = {} -- ./compiler/lua54.can:55
} -- ./compiler/lua54.can:55
local function push(name, state) -- ./compiler/lua54.can:58
table["insert"](states[name], state) -- ./compiler/lua54.can:59
return "" -- ./compiler/lua54.can:60
end -- ./compiler/lua54.can:60
local function pop(name) -- ./compiler/lua54.can:63
table["remove"](states[name]) -- ./compiler/lua54.can:64
return "" -- ./compiler/lua54.can:65
end -- ./compiler/lua54.can:65
local function set(name, state) -- ./compiler/lua54.can:68
states[name][# states[name]] = state -- ./compiler/lua54.can:69
return "" -- ./compiler/lua54.can:70
end -- ./compiler/lua54.can:70
local function peek(name) -- ./compiler/lua54.can:73
return states[name][# states[name]] -- ./compiler/lua54.can:74
end -- ./compiler/lua54.can:74
local function var(name) -- ./compiler/lua54.can:79
return options["variablePrefix"] .. name -- ./compiler/lua54.can:80
end -- ./compiler/lua54.can:80
local function tmp() -- ./compiler/lua54.can:84
local scope = peek("scope") -- ./compiler/lua54.can:85
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.can:86
table["insert"](scope, var) -- ./compiler/lua54.can:87
return var -- ./compiler/lua54.can:88
end -- ./compiler/lua54.can:88
local nomacro = { -- ./compiler/lua54.can:92
["variables"] = {}, -- ./compiler/lua54.can:92
["functions"] = {} -- ./compiler/lua54.can:92
} -- ./compiler/lua54.can:92
local required = {} -- ./compiler/lua54.can:95
local requireStr = "" -- ./compiler/lua54.can:96
local function addRequire(mod, name, field) -- ./compiler/lua54.can:98
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.can:99
if not required[req] then -- ./compiler/lua54.can:100
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.can:101
required[req] = true -- ./compiler/lua54.can:102
end -- ./compiler/lua54.can:102
end -- ./compiler/lua54.can:102
local loop = { -- ./compiler/lua54.can:107
"While", -- ./compiler/lua54.can:107
"Repeat", -- ./compiler/lua54.can:107
"Fornum", -- ./compiler/lua54.can:107
"Forin", -- ./compiler/lua54.can:107
"WhileExpr", -- ./compiler/lua54.can:107
"RepeatExpr", -- ./compiler/lua54.can:107
"FornumExpr", -- ./compiler/lua54.can:107
"ForinExpr" -- ./compiler/lua54.can:107
} -- ./compiler/lua54.can:107
local func = { -- ./compiler/lua54.can:108
"Function", -- ./compiler/lua54.can:108
"TableCompr", -- ./compiler/lua54.can:108
"DoExpr", -- ./compiler/lua54.can:108
"WhileExpr", -- ./compiler/lua54.can:108
"RepeatExpr", -- ./compiler/lua54.can:108
"IfExpr", -- ./compiler/lua54.can:108
"FornumExpr", -- ./compiler/lua54.can:108
"ForinExpr" -- ./compiler/lua54.can:108
} -- ./compiler/lua54.can:108
local function any(list, tags, nofollow) -- ./compiler/lua54.can:112
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.can:112
local tagsCheck = {} -- ./compiler/lua54.can:113
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:114
tagsCheck[tag] = true -- ./compiler/lua54.can:115
end -- ./compiler/lua54.can:115
local nofollowCheck = {} -- ./compiler/lua54.can:117
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.can:118
nofollowCheck[tag] = true -- ./compiler/lua54.can:119
end -- ./compiler/lua54.can:119
for _, node in ipairs(list) do -- ./compiler/lua54.can:121
if type(node) == "table" then -- ./compiler/lua54.can:122
if tagsCheck[node["tag"]] then -- ./compiler/lua54.can:123
return node -- ./compiler/lua54.can:124
end -- ./compiler/lua54.can:124
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.can:126
local r = any(node, tags, nofollow) -- ./compiler/lua54.can:127
if r then -- ./compiler/lua54.can:128
return r -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
return nil -- ./compiler/lua54.can:132
end -- ./compiler/lua54.can:132
local function search(list, tags, nofollow) -- ./compiler/lua54.can:137
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.can:137
local tagsCheck = {} -- ./compiler/lua54.can:138
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:139
tagsCheck[tag] = true -- ./compiler/lua54.can:140
end -- ./compiler/lua54.can:140
local nofollowCheck = {} -- ./compiler/lua54.can:142
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.can:143
nofollowCheck[tag] = true -- ./compiler/lua54.can:144
end -- ./compiler/lua54.can:144
local found = {} -- ./compiler/lua54.can:146
for _, node in ipairs(list) do -- ./compiler/lua54.can:147
if type(node) == "table" then -- ./compiler/lua54.can:148
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.can:149
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.can:150
table["insert"](found, n) -- ./compiler/lua54.can:151
end -- ./compiler/lua54.can:151
end -- ./compiler/lua54.can:151
if tagsCheck[node["tag"]] then -- ./compiler/lua54.can:154
table["insert"](found, node) -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
return found -- ./compiler/lua54.can:159
end -- ./compiler/lua54.can:159
local function all(list, tags) -- ./compiler/lua54.can:163
for _, node in ipairs(list) do -- ./compiler/lua54.can:164
local ok = false -- ./compiler/lua54.can:165
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:166
if node["tag"] == tag then -- ./compiler/lua54.can:167
ok = true -- ./compiler/lua54.can:168
break -- ./compiler/lua54.can:169
end -- ./compiler/lua54.can:169
end -- ./compiler/lua54.can:169
if not ok then -- ./compiler/lua54.can:172
return false -- ./compiler/lua54.can:173
end -- ./compiler/lua54.can:173
end -- ./compiler/lua54.can:173
return true -- ./compiler/lua54.can:176
end -- ./compiler/lua54.can:176
local tags -- ./compiler/lua54.can:180
local function lua(ast, forceTag, ...) -- ./compiler/lua54.can:182
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.can:183
lastInputPos = ast["pos"] -- ./compiler/lua54.can:184
end -- ./compiler/lua54.can:184
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.can:186
end -- ./compiler/lua54.can:186
local UNPACK = function(list, i, j) -- ./compiler/lua54.can:190
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.can:191
end -- ./compiler/lua54.can:191
local APPEND = function(t, toAppend) -- ./compiler/lua54.can:193
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.can:194
end -- ./compiler/lua54.can:194
local CONTINUE_START = function() -- ./compiler/lua54.can:196
return "do" .. indent() -- ./compiler/lua54.can:197
end -- ./compiler/lua54.can:197
local CONTINUE_STOP = function() -- ./compiler/lua54.can:199
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.can:200
end -- ./compiler/lua54.can:200
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.can:202
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.can:202
if noLocal == nil then noLocal = false end -- ./compiler/lua54.can:202
local vars = {} -- ./compiler/lua54.can:203
local values = {} -- ./compiler/lua54.can:204
for _, list in ipairs(destructured) do -- ./compiler/lua54.can:205
for _, v in ipairs(list) do -- ./compiler/lua54.can:206
local var, val -- ./compiler/lua54.can:207
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.can:208
var = v -- ./compiler/lua54.can:209
val = { -- ./compiler/lua54.can:210
["tag"] = "Index", -- ./compiler/lua54.can:210
{ -- ./compiler/lua54.can:210
["tag"] = "Id", -- ./compiler/lua54.can:210
list["id"] -- ./compiler/lua54.can:210
}, -- ./compiler/lua54.can:210
{ -- ./compiler/lua54.can:210
["tag"] = "String", -- ./compiler/lua54.can:210
v[1] -- ./compiler/lua54.can:210
} -- ./compiler/lua54.can:210
} -- ./compiler/lua54.can:210
elseif v["tag"] == "Pair" then -- ./compiler/lua54.can:211
var = v[2] -- ./compiler/lua54.can:212
val = { -- ./compiler/lua54.can:213
["tag"] = "Index", -- ./compiler/lua54.can:213
{ -- ./compiler/lua54.can:213
["tag"] = "Id", -- ./compiler/lua54.can:213
list["id"] -- ./compiler/lua54.can:213
}, -- ./compiler/lua54.can:213
v[1] -- ./compiler/lua54.can:213
} -- ./compiler/lua54.can:213
else -- ./compiler/lua54.can:213
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.can:215
end -- ./compiler/lua54.can:215
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.can:217
val = { -- ./compiler/lua54.can:218
["tag"] = "Op", -- ./compiler/lua54.can:218
destructured["rightOp"], -- ./compiler/lua54.can:218
var, -- ./compiler/lua54.can:218
{ -- ./compiler/lua54.can:218
["tag"] = "Op", -- ./compiler/lua54.can:218
destructured["leftOp"], -- ./compiler/lua54.can:218
val, -- ./compiler/lua54.can:218
var -- ./compiler/lua54.can:218
} -- ./compiler/lua54.can:218
} -- ./compiler/lua54.can:218
elseif destructured["rightOp"] then -- ./compiler/lua54.can:219
val = { -- ./compiler/lua54.can:220
["tag"] = "Op", -- ./compiler/lua54.can:220
destructured["rightOp"], -- ./compiler/lua54.can:220
var, -- ./compiler/lua54.can:220
val -- ./compiler/lua54.can:220
} -- ./compiler/lua54.can:220
elseif destructured["leftOp"] then -- ./compiler/lua54.can:221
val = { -- ./compiler/lua54.can:222
["tag"] = "Op", -- ./compiler/lua54.can:222
destructured["leftOp"], -- ./compiler/lua54.can:222
val, -- ./compiler/lua54.can:222
var -- ./compiler/lua54.can:222
} -- ./compiler/lua54.can:222
end -- ./compiler/lua54.can:222
table["insert"](vars, lua(var)) -- ./compiler/lua54.can:224
table["insert"](values, lua(val)) -- ./compiler/lua54.can:225
end -- ./compiler/lua54.can:225
end -- ./compiler/lua54.can:225
if # vars > 0 then -- ./compiler/lua54.can:228
local decl = noLocal and "" or "local " -- ./compiler/lua54.can:229
if newlineAfter then -- ./compiler/lua54.can:230
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.can:231
else -- ./compiler/lua54.can:231
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.can:233
end -- ./compiler/lua54.can:233
else -- ./compiler/lua54.can:233
return "" -- ./compiler/lua54.can:236
end -- ./compiler/lua54.can:236
end -- ./compiler/lua54.can:236
tags = setmetatable({ -- ./compiler/lua54.can:241
["Block"] = function(t) -- ./compiler/lua54.can:243
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.can:244
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.can:245
hasPush["tag"] = "Return" -- ./compiler/lua54.can:246
hasPush = false -- ./compiler/lua54.can:247
end -- ./compiler/lua54.can:247
local r = push("scope", {}) -- ./compiler/lua54.can:249
if hasPush then -- ./compiler/lua54.can:250
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:251
end -- ./compiler/lua54.can:251
for i = 1, # t - 1, 1 do -- ./compiler/lua54.can:253
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.can:254
end -- ./compiler/lua54.can:254
if t[# t] then -- ./compiler/lua54.can:256
r = r .. (lua(t[# t])) -- ./compiler/lua54.can:257
end -- ./compiler/lua54.can:257
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.can:259
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.can:260
end -- ./compiler/lua54.can:260
return r .. pop("scope") -- ./compiler/lua54.can:262
end, -- ./compiler/lua54.can:262
["Do"] = function(t) -- ./compiler/lua54.can:268
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.can:269
end, -- ./compiler/lua54.can:269
["Set"] = function(t) -- ./compiler/lua54.can:272
local expr = t[# t] -- ./compiler/lua54.can:274
local vars, values = {}, {} -- ./compiler/lua54.can:275
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.can:276
for i, n in ipairs(t[1]) do -- ./compiler/lua54.can:277
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.can:278
table["insert"](destructuringVars, n) -- ./compiler/lua54.can:279
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.can:280
else -- ./compiler/lua54.can:280
table["insert"](vars, n) -- ./compiler/lua54.can:282
table["insert"](values, expr[i]) -- ./compiler/lua54.can:283
end -- ./compiler/lua54.can:283
end -- ./compiler/lua54.can:283
if # t == 2 or # t == 3 then -- ./compiler/lua54.can:287
local r = "" -- ./compiler/lua54.can:288
if # vars > 0 then -- ./compiler/lua54.can:289
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.can:290
end -- ./compiler/lua54.can:290
if # destructuringVars > 0 then -- ./compiler/lua54.can:292
local destructured = {} -- ./compiler/lua54.can:293
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:294
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:295
end -- ./compiler/lua54.can:295
return r -- ./compiler/lua54.can:297
elseif # t == 4 then -- ./compiler/lua54.can:298
if t[3] == "=" then -- ./compiler/lua54.can:299
local r = "" -- ./compiler/lua54.can:300
if # vars > 0 then -- ./compiler/lua54.can:301
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:302
t[2], -- ./compiler/lua54.can:302
vars[1], -- ./compiler/lua54.can:302
{ -- ./compiler/lua54.can:302
["tag"] = "Paren", -- ./compiler/lua54.can:302
values[1] -- ./compiler/lua54.can:302
} -- ./compiler/lua54.can:302
}, "Op")) -- ./compiler/lua54.can:302
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.can:303
r = r .. (", " .. lua({ -- ./compiler/lua54.can:304
t[2], -- ./compiler/lua54.can:304
vars[i], -- ./compiler/lua54.can:304
{ -- ./compiler/lua54.can:304
["tag"] = "Paren", -- ./compiler/lua54.can:304
values[i] -- ./compiler/lua54.can:304
} -- ./compiler/lua54.can:304
}, "Op")) -- ./compiler/lua54.can:304
end -- ./compiler/lua54.can:304
end -- ./compiler/lua54.can:304
if # destructuringVars > 0 then -- ./compiler/lua54.can:307
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.can:308
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:309
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:310
end -- ./compiler/lua54.can:310
return r -- ./compiler/lua54.can:312
else -- ./compiler/lua54.can:312
local r = "" -- ./compiler/lua54.can:314
if # vars > 0 then -- ./compiler/lua54.can:315
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:316
t[3], -- ./compiler/lua54.can:316
{ -- ./compiler/lua54.can:316
["tag"] = "Paren", -- ./compiler/lua54.can:316
values[1] -- ./compiler/lua54.can:316
}, -- ./compiler/lua54.can:316
vars[1] -- ./compiler/lua54.can:316
}, "Op")) -- ./compiler/lua54.can:316
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.can:317
r = r .. (", " .. lua({ -- ./compiler/lua54.can:318
t[3], -- ./compiler/lua54.can:318
{ -- ./compiler/lua54.can:318
["tag"] = "Paren", -- ./compiler/lua54.can:318
values[i] -- ./compiler/lua54.can:318
}, -- ./compiler/lua54.can:318
vars[i] -- ./compiler/lua54.can:318
}, "Op")) -- ./compiler/lua54.can:318
end -- ./compiler/lua54.can:318
end -- ./compiler/lua54.can:318
if # destructuringVars > 0 then -- ./compiler/lua54.can:321
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.can:322
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:323
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:324
end -- ./compiler/lua54.can:324
return r -- ./compiler/lua54.can:326
end -- ./compiler/lua54.can:326
else -- ./compiler/lua54.can:326
local r = "" -- ./compiler/lua54.can:329
if # vars > 0 then -- ./compiler/lua54.can:330
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:331
t[2], -- ./compiler/lua54.can:331
vars[1], -- ./compiler/lua54.can:331
{ -- ./compiler/lua54.can:331
["tag"] = "Op", -- ./compiler/lua54.can:331
t[4], -- ./compiler/lua54.can:331
{ -- ./compiler/lua54.can:331
["tag"] = "Paren", -- ./compiler/lua54.can:331
values[1] -- ./compiler/lua54.can:331
}, -- ./compiler/lua54.can:331
vars[1] -- ./compiler/lua54.can:331
} -- ./compiler/lua54.can:331
}, "Op")) -- ./compiler/lua54.can:331
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.can:332
r = r .. (", " .. lua({ -- ./compiler/lua54.can:333
t[2], -- ./compiler/lua54.can:333
vars[i], -- ./compiler/lua54.can:333
{ -- ./compiler/lua54.can:333
["tag"] = "Op", -- ./compiler/lua54.can:333
t[4], -- ./compiler/lua54.can:333
{ -- ./compiler/lua54.can:333
["tag"] = "Paren", -- ./compiler/lua54.can:333
values[i] -- ./compiler/lua54.can:333
}, -- ./compiler/lua54.can:333
vars[i] -- ./compiler/lua54.can:333
} -- ./compiler/lua54.can:333
}, "Op")) -- ./compiler/lua54.can:333
end -- ./compiler/lua54.can:333
end -- ./compiler/lua54.can:333
if # destructuringVars > 0 then -- ./compiler/lua54.can:336
local destructured = { -- ./compiler/lua54.can:337
["rightOp"] = t[2], -- ./compiler/lua54.can:337
["leftOp"] = t[4] -- ./compiler/lua54.can:337
} -- ./compiler/lua54.can:337
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:338
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:339
end -- ./compiler/lua54.can:339
return r -- ./compiler/lua54.can:341
end -- ./compiler/lua54.can:341
end, -- ./compiler/lua54.can:341
["While"] = function(t) -- ./compiler/lua54.can:345
local r = "" -- ./compiler/lua54.can:346
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.can:347
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.can:348
if # lets > 0 then -- ./compiler/lua54.can:349
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:350
for _, l in ipairs(lets) do -- ./compiler/lua54.can:351
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:352
end -- ./compiler/lua54.can:352
end -- ./compiler/lua54.can:352
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.can:355
if # lets > 0 then -- ./compiler/lua54.can:356
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:357
end -- ./compiler/lua54.can:357
if hasContinue then -- ./compiler/lua54.can:359
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:360
end -- ./compiler/lua54.can:360
r = r .. (lua(t[2])) -- ./compiler/lua54.can:362
if hasContinue then -- ./compiler/lua54.can:363
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:364
end -- ./compiler/lua54.can:364
r = r .. (unindent() .. "end") -- ./compiler/lua54.can:366
if # lets > 0 then -- ./compiler/lua54.can:367
for _, l in ipairs(lets) do -- ./compiler/lua54.can:368
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.can:369
end -- ./compiler/lua54.can:369
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.can:371
end -- ./compiler/lua54.can:371
return r -- ./compiler/lua54.can:373
end, -- ./compiler/lua54.can:373
["Repeat"] = function(t) -- ./compiler/lua54.can:376
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.can:377
local r = "repeat" .. indent() -- ./compiler/lua54.can:378
if hasContinue then -- ./compiler/lua54.can:379
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:380
end -- ./compiler/lua54.can:380
r = r .. (lua(t[1])) -- ./compiler/lua54.can:382
if hasContinue then -- ./compiler/lua54.can:383
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:384
end -- ./compiler/lua54.can:384
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.can:386
return r -- ./compiler/lua54.can:387
end, -- ./compiler/lua54.can:387
["If"] = function(t) -- ./compiler/lua54.can:390
local r = "" -- ./compiler/lua54.can:391
local toClose = 0 -- ./compiler/lua54.can:392
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.can:393
if # lets > 0 then -- ./compiler/lua54.can:394
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:395
toClose = toClose + (1) -- ./compiler/lua54.can:396
for _, l in ipairs(lets) do -- ./compiler/lua54.can:397
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:398
end -- ./compiler/lua54.can:398
end -- ./compiler/lua54.can:398
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.can:401
for i = 3, # t - 1, 2 do -- ./compiler/lua54.can:402
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.can:403
if # lets > 0 then -- ./compiler/lua54.can:404
r = r .. ("else" .. indent()) -- ./compiler/lua54.can:405
toClose = toClose + (1) -- ./compiler/lua54.can:406
for _, l in ipairs(lets) do -- ./compiler/lua54.can:407
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:408
end -- ./compiler/lua54.can:408
else -- ./compiler/lua54.can:408
r = r .. ("else") -- ./compiler/lua54.can:411
end -- ./compiler/lua54.can:411
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.can:413
end -- ./compiler/lua54.can:413
if # t % 2 == 1 then -- ./compiler/lua54.can:415
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.can:416
end -- ./compiler/lua54.can:416
r = r .. ("end") -- ./compiler/lua54.can:418
for i = 1, toClose do -- ./compiler/lua54.can:419
r = r .. (unindent() .. "end") -- ./compiler/lua54.can:420
end -- ./compiler/lua54.can:420
return r -- ./compiler/lua54.can:422
end, -- ./compiler/lua54.can:422
["Fornum"] = function(t) -- ./compiler/lua54.can:425
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.can:426
if # t == 5 then -- ./compiler/lua54.can:427
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.can:428
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.can:429
if hasContinue then -- ./compiler/lua54.can:430
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:431
end -- ./compiler/lua54.can:431
r = r .. (lua(t[5])) -- ./compiler/lua54.can:433
if hasContinue then -- ./compiler/lua54.can:434
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:435
end -- ./compiler/lua54.can:435
return r .. unindent() .. "end" -- ./compiler/lua54.can:437
else -- ./compiler/lua54.can:437
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.can:439
r = r .. (" do" .. indent()) -- ./compiler/lua54.can:440
if hasContinue then -- ./compiler/lua54.can:441
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:442
end -- ./compiler/lua54.can:442
r = r .. (lua(t[4])) -- ./compiler/lua54.can:444
if hasContinue then -- ./compiler/lua54.can:445
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:446
end -- ./compiler/lua54.can:446
return r .. unindent() .. "end" -- ./compiler/lua54.can:448
end -- ./compiler/lua54.can:448
end, -- ./compiler/lua54.can:448
["Forin"] = function(t) -- ./compiler/lua54.can:452
local destructured = {} -- ./compiler/lua54.can:453
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.can:454
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.can:455
if hasContinue then -- ./compiler/lua54.can:456
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:457
end -- ./compiler/lua54.can:457
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.can:459
if hasContinue then -- ./compiler/lua54.can:460
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:461
end -- ./compiler/lua54.can:461
return r .. unindent() .. "end" -- ./compiler/lua54.can:463
end, -- ./compiler/lua54.can:463
["Local"] = function(t) -- ./compiler/lua54.can:466
local destructured = {} -- ./compiler/lua54.can:467
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.can:468
if t[2][1] then -- ./compiler/lua54.can:469
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:470
end -- ./compiler/lua54.can:470
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.can:472
end, -- ./compiler/lua54.can:472
["Let"] = function(t) -- ./compiler/lua54.can:475
local destructured = {} -- ./compiler/lua54.can:476
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.can:477
local r = "local " .. nameList -- ./compiler/lua54.can:478
if t[2][1] then -- ./compiler/lua54.can:479
if all(t[2], { -- ./compiler/lua54.can:480
"Nil", -- ./compiler/lua54.can:480
"Dots", -- ./compiler/lua54.can:480
"Boolean", -- ./compiler/lua54.can:480
"Number", -- ./compiler/lua54.can:480
"String" -- ./compiler/lua54.can:480
}) then -- ./compiler/lua54.can:480
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:481
else -- ./compiler/lua54.can:481
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:483
end -- ./compiler/lua54.can:483
end -- ./compiler/lua54.can:483
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.can:486
end, -- ./compiler/lua54.can:486
["Localrec"] = function(t) -- ./compiler/lua54.can:489
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.can:490
end, -- ./compiler/lua54.can:490
["Goto"] = function(t) -- ./compiler/lua54.can:493
return "goto " .. lua(t, "Id") -- ./compiler/lua54.can:494
end, -- ./compiler/lua54.can:494
["Label"] = function(t) -- ./compiler/lua54.can:497
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.can:498
end, -- ./compiler/lua54.can:498
["Return"] = function(t) -- ./compiler/lua54.can:501
local push = peek("push") -- ./compiler/lua54.can:502
if push then -- ./compiler/lua54.can:503
local r = "" -- ./compiler/lua54.can:504
for _, val in ipairs(t) do -- ./compiler/lua54.can:505
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.can:506
end -- ./compiler/lua54.can:506
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.can:508
else -- ./compiler/lua54.can:508
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.can:510
end -- ./compiler/lua54.can:510
end, -- ./compiler/lua54.can:510
["Push"] = function(t) -- ./compiler/lua54.can:514
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.can:515
r = "" -- ./compiler/lua54.can:516
for i = 1, # t - 1, 1 do -- ./compiler/lua54.can:517
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.can:518
end -- ./compiler/lua54.can:518
if t[# t] then -- ./compiler/lua54.can:520
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.can:521
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.can:522
else -- ./compiler/lua54.can:522
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.can:524
end -- ./compiler/lua54.can:524
end -- ./compiler/lua54.can:524
return r -- ./compiler/lua54.can:527
end, -- ./compiler/lua54.can:527
["Break"] = function() -- ./compiler/lua54.can:530
return "break" -- ./compiler/lua54.can:531
end, -- ./compiler/lua54.can:531
["Continue"] = function() -- ./compiler/lua54.can:534
return "goto " .. var("continue") -- ./compiler/lua54.can:535
end, -- ./compiler/lua54.can:535
["Nil"] = function() -- ./compiler/lua54.can:542
return "nil" -- ./compiler/lua54.can:543
end, -- ./compiler/lua54.can:543
["Dots"] = function() -- ./compiler/lua54.can:546
local macroargs = peek("macroargs") -- ./compiler/lua54.can:547
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.can:548
nomacro["variables"]["..."] = true -- ./compiler/lua54.can:549
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.can:550
nomacro["variables"]["..."] = nil -- ./compiler/lua54.can:551
return r -- ./compiler/lua54.can:552
else -- ./compiler/lua54.can:552
return "..." -- ./compiler/lua54.can:554
end -- ./compiler/lua54.can:554
end, -- ./compiler/lua54.can:554
["Boolean"] = function(t) -- ./compiler/lua54.can:558
return tostring(t[1]) -- ./compiler/lua54.can:559
end, -- ./compiler/lua54.can:559
["Number"] = function(t) -- ./compiler/lua54.can:562
return tostring(t[1]) -- ./compiler/lua54.can:563
end, -- ./compiler/lua54.can:563
["String"] = function(t) -- ./compiler/lua54.can:566
return ("%q"):format(t[1]) -- ./compiler/lua54.can:567
end, -- ./compiler/lua54.can:567
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.can:570
local r = "(" -- ./compiler/lua54.can:571
local decl = {} -- ./compiler/lua54.can:572
if t[1][1] then -- ./compiler/lua54.can:573
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.can:574
local id = lua(t[1][1][1]) -- ./compiler/lua54.can:575
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:576
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.can:577
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:578
r = r .. (id) -- ./compiler/lua54.can:579
else -- ./compiler/lua54.can:579
r = r .. (lua(t[1][1])) -- ./compiler/lua54.can:581
end -- ./compiler/lua54.can:581
for i = 2, # t[1], 1 do -- ./compiler/lua54.can:583
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.can:584
local id = lua(t[1][i][1]) -- ./compiler/lua54.can:585
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:586
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.can:587
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:588
r = r .. (", " .. id) -- ./compiler/lua54.can:589
else -- ./compiler/lua54.can:589
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
r = r .. (")" .. indent()) -- ./compiler/lua54.can:595
for _, d in ipairs(decl) do -- ./compiler/lua54.can:596
r = r .. (d .. newline()) -- ./compiler/lua54.can:597
end -- ./compiler/lua54.can:597
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.can:599
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.can:600
end -- ./compiler/lua54.can:600
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.can:602
if hasPush then -- ./compiler/lua54.can:603
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:604
else -- ./compiler/lua54.can:604
push("push", false) -- ./compiler/lua54.can:606
end -- ./compiler/lua54.can:606
r = r .. (lua(t[2])) -- ./compiler/lua54.can:608
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.can:609
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.can:610
end -- ./compiler/lua54.can:610
pop("push") -- ./compiler/lua54.can:612
return r .. unindent() .. "end" -- ./compiler/lua54.can:613
end, -- ./compiler/lua54.can:613
["Function"] = function(t) -- ./compiler/lua54.can:615
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.can:616
end, -- ./compiler/lua54.can:616
["Pair"] = function(t) -- ./compiler/lua54.can:619
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.can:620
end, -- ./compiler/lua54.can:620
["Table"] = function(t) -- ./compiler/lua54.can:622
if # t == 0 then -- ./compiler/lua54.can:623
return "{}" -- ./compiler/lua54.can:624
elseif # t == 1 then -- ./compiler/lua54.can:625
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.can:626
else -- ./compiler/lua54.can:626
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.can:628
end -- ./compiler/lua54.can:628
end, -- ./compiler/lua54.can:628
["TableCompr"] = function(t) -- ./compiler/lua54.can:632
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.can:633
end, -- ./compiler/lua54.can:633
["Op"] = function(t) -- ./compiler/lua54.can:636
local r -- ./compiler/lua54.can:637
if # t == 2 then -- ./compiler/lua54.can:638
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.can:639
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.can:640
else -- ./compiler/lua54.can:640
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.can:642
end -- ./compiler/lua54.can:642
else -- ./compiler/lua54.can:642
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.can:645
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.can:646
else -- ./compiler/lua54.can:646
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.can:648
end -- ./compiler/lua54.can:648
end -- ./compiler/lua54.can:648
return r -- ./compiler/lua54.can:651
end, -- ./compiler/lua54.can:651
["Paren"] = function(t) -- ./compiler/lua54.can:654
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.can:655
end, -- ./compiler/lua54.can:655
["MethodStub"] = function(t) -- ./compiler/lua54.can:658
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.can:664
end, -- ./compiler/lua54.can:664
["SafeMethodStub"] = function(t) -- ./compiler/lua54.can:667
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.can:674
end, -- ./compiler/lua54.can:674
["LetExpr"] = function(t) -- ./compiler/lua54.can:681
return lua(t[1][1]) -- ./compiler/lua54.can:682
end, -- ./compiler/lua54.can:682
["_statexpr"] = function(t, stat) -- ./compiler/lua54.can:686
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.can:687
local r = "(function()" .. indent() -- ./compiler/lua54.can:688
if hasPush then -- ./compiler/lua54.can:689
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:690
else -- ./compiler/lua54.can:690
push("push", false) -- ./compiler/lua54.can:692
end -- ./compiler/lua54.can:692
r = r .. (lua(t, stat)) -- ./compiler/lua54.can:694
if hasPush then -- ./compiler/lua54.can:695
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.can:696
end -- ./compiler/lua54.can:696
pop("push") -- ./compiler/lua54.can:698
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.can:699
return r -- ./compiler/lua54.can:700
end, -- ./compiler/lua54.can:700
["DoExpr"] = function(t) -- ./compiler/lua54.can:703
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.can:704
t[# t]["tag"] = "Return" -- ./compiler/lua54.can:705
end -- ./compiler/lua54.can:705
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.can:707
end, -- ./compiler/lua54.can:707
["WhileExpr"] = function(t) -- ./compiler/lua54.can:710
return lua(t, "_statexpr", "While") -- ./compiler/lua54.can:711
end, -- ./compiler/lua54.can:711
["RepeatExpr"] = function(t) -- ./compiler/lua54.can:714
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.can:715
end, -- ./compiler/lua54.can:715
["IfExpr"] = function(t) -- ./compiler/lua54.can:718
for i = 2, # t do -- ./compiler/lua54.can:719
local block = t[i] -- ./compiler/lua54.can:720
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.can:721
block[# block]["tag"] = "Return" -- ./compiler/lua54.can:722
end -- ./compiler/lua54.can:722
end -- ./compiler/lua54.can:722
return lua(t, "_statexpr", "If") -- ./compiler/lua54.can:725
end, -- ./compiler/lua54.can:725
["FornumExpr"] = function(t) -- ./compiler/lua54.can:728
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.can:729
end, -- ./compiler/lua54.can:729
["ForinExpr"] = function(t) -- ./compiler/lua54.can:732
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.can:733
end, -- ./compiler/lua54.can:733
["Call"] = function(t) -- ./compiler/lua54.can:739
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.can:740
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:741
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.can:742
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.can:743
local replacement = macro["replacement"] -- ./compiler/lua54.can:744
local r -- ./compiler/lua54.can:745
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.can:746
if type(replacement) == "function" then -- ./compiler/lua54.can:747
local args = {} -- ./compiler/lua54.can:748
for i = 2, # t do -- ./compiler/lua54.can:749
table["insert"](args, lua(t[i])) -- ./compiler/lua54.can:750
end -- ./compiler/lua54.can:750
r = replacement(unpack(args)) -- ./compiler/lua54.can:752
else -- ./compiler/lua54.can:752
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.can:754
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.can:755
if arg["tag"] == "Dots" then -- ./compiler/lua54.can:756
macroargs["..."] = (function() -- ./compiler/lua54.can:757
local self = {} -- ./compiler/lua54.can:757
for j = i + 1, # t do -- ./compiler/lua54.can:757
self[#self+1] = t[j] -- ./compiler/lua54.can:757
end -- ./compiler/lua54.can:757
return self -- ./compiler/lua54.can:757
end)() -- ./compiler/lua54.can:757
elseif arg["tag"] == "Id" then -- ./compiler/lua54.can:758
if t[i + 1] == nil then -- ./compiler/lua54.can:759
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.can:760
end -- ./compiler/lua54.can:760
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.can:762
else -- ./compiler/lua54.can:762
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.can:764
end -- ./compiler/lua54.can:764
end -- ./compiler/lua54.can:764
push("macroargs", macroargs) -- ./compiler/lua54.can:767
r = lua(replacement) -- ./compiler/lua54.can:768
pop("macroargs") -- ./compiler/lua54.can:769
end -- ./compiler/lua54.can:769
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.can:771
return r -- ./compiler/lua54.can:772
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.can:773
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.can:774
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:775
else -- ./compiler/lua54.can:775
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:777
end -- ./compiler/lua54.can:777
else -- ./compiler/lua54.can:777
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:780
end -- ./compiler/lua54.can:780
end, -- ./compiler/lua54.can:780
["SafeCall"] = function(t) -- ./compiler/lua54.can:784
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.can:785
return lua(t, "SafeIndex") -- ./compiler/lua54.can:786
else -- ./compiler/lua54.can:786
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.can:788
end -- ./compiler/lua54.can:788
end, -- ./compiler/lua54.can:788
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.can:793
if start == nil then start = 1 end -- ./compiler/lua54.can:793
local r -- ./compiler/lua54.can:794
if t[start] then -- ./compiler/lua54.can:795
r = lua(t[start]) -- ./compiler/lua54.can:796
for i = start + 1, # t, 1 do -- ./compiler/lua54.can:797
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.can:798
end -- ./compiler/lua54.can:798
else -- ./compiler/lua54.can:798
r = "" -- ./compiler/lua54.can:801
end -- ./compiler/lua54.can:801
return r -- ./compiler/lua54.can:803
end, -- ./compiler/lua54.can:803
["Id"] = function(t) -- ./compiler/lua54.can:806
local r = t[1] -- ./compiler/lua54.can:807
local macroargs = peek("macroargs") -- ./compiler/lua54.can:808
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.can:809
nomacro["variables"][t[1]] = true -- ./compiler/lua54.can:810
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.can:811
r = lua(macroargs[t[1]]) -- ./compiler/lua54.can:812
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.can:813
local macro = macros["variables"][t[1]] -- ./compiler/lua54.can:814
if type(macro) == "function" then -- ./compiler/lua54.can:815
r = macro() -- ./compiler/lua54.can:816
else -- ./compiler/lua54.can:816
r = lua(macro) -- ./compiler/lua54.can:818
end -- ./compiler/lua54.can:818
end -- ./compiler/lua54.can:818
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.can:821
end -- ./compiler/lua54.can:821
return r -- ./compiler/lua54.can:823
end, -- ./compiler/lua54.can:823
["AttributeId"] = function(t) -- ./compiler/lua54.can:826
if t[2] then -- ./compiler/lua54.can:827
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.can:828
else -- ./compiler/lua54.can:828
return t[1] -- ./compiler/lua54.can:830
end -- ./compiler/lua54.can:830
end, -- ./compiler/lua54.can:830
["DestructuringId"] = function(t) -- ./compiler/lua54.can:834
if t["id"] then -- ./compiler/lua54.can:835
return t["id"] -- ./compiler/lua54.can:836
else -- ./compiler/lua54.can:836
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.can:838
local vars = { ["id"] = tmp() } -- ./compiler/lua54.can:839
for j = 1, # t, 1 do -- ./compiler/lua54.can:840
table["insert"](vars, t[j]) -- ./compiler/lua54.can:841
end -- ./compiler/lua54.can:841
table["insert"](d, vars) -- ./compiler/lua54.can:843
t["id"] = vars["id"] -- ./compiler/lua54.can:844
return vars["id"] -- ./compiler/lua54.can:845
end -- ./compiler/lua54.can:845
end, -- ./compiler/lua54.can:845
["Index"] = function(t) -- ./compiler/lua54.can:849
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.can:850
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.can:851
else -- ./compiler/lua54.can:851
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.can:853
end -- ./compiler/lua54.can:853
end, -- ./compiler/lua54.can:853
["SafeIndex"] = function(t) -- ./compiler/lua54.can:857
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.can:858
local l = {} -- ./compiler/lua54.can:859
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.can:860
table["insert"](l, 1, t) -- ./compiler/lua54.can:861
t = t[1] -- ./compiler/lua54.can:862
end -- ./compiler/lua54.can:862
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.can:864
for _, e in ipairs(l) do -- ./compiler/lua54.can:865
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.can:866
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.can:867
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.can:868
else -- ./compiler/lua54.can:868
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.can:870
end -- ./compiler/lua54.can:870
end -- ./compiler/lua54.can:870
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.can:873
return r -- ./compiler/lua54.can:874
else -- ./compiler/lua54.can:874
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.can:876
end -- ./compiler/lua54.can:876
end, -- ./compiler/lua54.can:876
["_opid"] = { -- ./compiler/lua54.can:881
["add"] = "+", -- ./compiler/lua54.can:882
["sub"] = "-", -- ./compiler/lua54.can:882
["mul"] = "*", -- ./compiler/lua54.can:882
["div"] = "/", -- ./compiler/lua54.can:882
["idiv"] = "//", -- ./compiler/lua54.can:883
["mod"] = "%", -- ./compiler/lua54.can:883
["pow"] = "^", -- ./compiler/lua54.can:883
["concat"] = "..", -- ./compiler/lua54.can:883
["band"] = "&", -- ./compiler/lua54.can:884
["bor"] = "|", -- ./compiler/lua54.can:884
["bxor"] = "~", -- ./compiler/lua54.can:884
["shl"] = "<<", -- ./compiler/lua54.can:884
["shr"] = ">>", -- ./compiler/lua54.can:884
["eq"] = "==", -- ./compiler/lua54.can:885
["ne"] = "~=", -- ./compiler/lua54.can:885
["lt"] = "<", -- ./compiler/lua54.can:885
["gt"] = ">", -- ./compiler/lua54.can:885
["le"] = "<=", -- ./compiler/lua54.can:885
["ge"] = ">=", -- ./compiler/lua54.can:885
["and"] = "and", -- ./compiler/lua54.can:886
["or"] = "or", -- ./compiler/lua54.can:886
["unm"] = "-", -- ./compiler/lua54.can:886
["len"] = "#", -- ./compiler/lua54.can:886
["bnot"] = "~", -- ./compiler/lua54.can:886
["not"] = "not" -- ./compiler/lua54.can:886
} -- ./compiler/lua54.can:886
}, { ["__index"] = function(self, key) -- ./compiler/lua54.can:889
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.can:890
end }) -- ./compiler/lua54.can:890
local code = lua(ast) .. newline() -- ./compiler/lua54.can:896
return requireStr .. code -- ./compiler/lua54.can:897
end -- ./compiler/lua54.can:897
end -- ./compiler/lua54.can:897
local lua54 = _() or lua54 -- ./compiler/lua54.can:902
package["loaded"]["compiler.lua54"] = lua54 or true -- ./compiler/lua54.can:903
local function _() -- ./compiler/lua54.can:906
local function _() -- ./compiler/lua54.can:908
local util = require("lepton.util") -- ./compiler/lua54.can:1
local targetName = "Lua 5.4" -- ./compiler/lua54.can:3
local unpack = unpack or table["unpack"] -- ./compiler/lua54.can:5
return function(code, ast, options, macros) -- ./compiler/lua54.can:7
if macros == nil then macros = { -- ./compiler/lua54.can:7
["functions"] = {}, -- ./compiler/lua54.can:7
["variables"] = {} -- ./compiler/lua54.can:7
} end -- ./compiler/lua54.can:7
local lastInputPos = 1 -- ./compiler/lua54.can:9
local prevLinePos = 1 -- ./compiler/lua54.can:10
local lastSource = options["chunkname"] or "nil" -- ./compiler/lua54.can:11
local lastLine = 1 -- ./compiler/lua54.can:12
local indentLevel = 0 -- ./compiler/lua54.can:15
local function newline() -- ./compiler/lua54.can:17
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.can:18
if options["mapLines"] then -- ./compiler/lua54.can:19
local sub = code:sub(lastInputPos) -- ./compiler/lua54.can:20
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.can:21
if source and line then -- ./compiler/lua54.can:23
lastSource = source -- ./compiler/lua54.can:24
lastLine = tonumber(line) -- ./compiler/lua54.can:25
else -- ./compiler/lua54.can:25
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.can:27
lastLine = lastLine + (1) -- ./compiler/lua54.can:28
end -- ./compiler/lua54.can:28
end -- ./compiler/lua54.can:28
prevLinePos = lastInputPos -- ./compiler/lua54.can:32
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.can:34
end -- ./compiler/lua54.can:34
return r -- ./compiler/lua54.can:36
end -- ./compiler/lua54.can:36
local function indent() -- ./compiler/lua54.can:39
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:40
return newline() -- ./compiler/lua54.can:41
end -- ./compiler/lua54.can:41
local function unindent() -- ./compiler/lua54.can:44
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:45
return newline() -- ./compiler/lua54.can:46
end -- ./compiler/lua54.can:46
local states = { -- ./compiler/lua54.can:51
["push"] = {}, -- ./compiler/lua54.can:52
["destructuring"] = {}, -- ./compiler/lua54.can:53
["scope"] = {}, -- ./compiler/lua54.can:54
["macroargs"] = {} -- ./compiler/lua54.can:55
} -- ./compiler/lua54.can:55
local function push(name, state) -- ./compiler/lua54.can:58
table["insert"](states[name], state) -- ./compiler/lua54.can:59
return "" -- ./compiler/lua54.can:60
end -- ./compiler/lua54.can:60
local function pop(name) -- ./compiler/lua54.can:63
table["remove"](states[name]) -- ./compiler/lua54.can:64
return "" -- ./compiler/lua54.can:65
end -- ./compiler/lua54.can:65
local function set(name, state) -- ./compiler/lua54.can:68
states[name][# states[name]] = state -- ./compiler/lua54.can:69
return "" -- ./compiler/lua54.can:70
end -- ./compiler/lua54.can:70
local function peek(name) -- ./compiler/lua54.can:73
return states[name][# states[name]] -- ./compiler/lua54.can:74
end -- ./compiler/lua54.can:74
local function var(name) -- ./compiler/lua54.can:79
return options["variablePrefix"] .. name -- ./compiler/lua54.can:80
end -- ./compiler/lua54.can:80
local function tmp() -- ./compiler/lua54.can:84
local scope = peek("scope") -- ./compiler/lua54.can:85
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.can:86
table["insert"](scope, var) -- ./compiler/lua54.can:87
return var -- ./compiler/lua54.can:88
end -- ./compiler/lua54.can:88
local nomacro = { -- ./compiler/lua54.can:92
["variables"] = {}, -- ./compiler/lua54.can:92
["functions"] = {} -- ./compiler/lua54.can:92
} -- ./compiler/lua54.can:92
local required = {} -- ./compiler/lua54.can:95
local requireStr = "" -- ./compiler/lua54.can:96
local function addRequire(mod, name, field) -- ./compiler/lua54.can:98
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.can:99
if not required[req] then -- ./compiler/lua54.can:100
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.can:101
required[req] = true -- ./compiler/lua54.can:102
end -- ./compiler/lua54.can:102
end -- ./compiler/lua54.can:102
local loop = { -- ./compiler/lua54.can:107
"While", -- ./compiler/lua54.can:107
"Repeat", -- ./compiler/lua54.can:107
"Fornum", -- ./compiler/lua54.can:107
"Forin", -- ./compiler/lua54.can:107
"WhileExpr", -- ./compiler/lua54.can:107
"RepeatExpr", -- ./compiler/lua54.can:107
"FornumExpr", -- ./compiler/lua54.can:107
"ForinExpr" -- ./compiler/lua54.can:107
} -- ./compiler/lua54.can:107
local func = { -- ./compiler/lua54.can:108
"Function", -- ./compiler/lua54.can:108
"TableCompr", -- ./compiler/lua54.can:108
"DoExpr", -- ./compiler/lua54.can:108
"WhileExpr", -- ./compiler/lua54.can:108
"RepeatExpr", -- ./compiler/lua54.can:108
"IfExpr", -- ./compiler/lua54.can:108
"FornumExpr", -- ./compiler/lua54.can:108
"ForinExpr" -- ./compiler/lua54.can:108
} -- ./compiler/lua54.can:108
local function any(list, tags, nofollow) -- ./compiler/lua54.can:112
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.can:112
local tagsCheck = {} -- ./compiler/lua54.can:113
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:114
tagsCheck[tag] = true -- ./compiler/lua54.can:115
end -- ./compiler/lua54.can:115
local nofollowCheck = {} -- ./compiler/lua54.can:117
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.can:118
nofollowCheck[tag] = true -- ./compiler/lua54.can:119
end -- ./compiler/lua54.can:119
for _, node in ipairs(list) do -- ./compiler/lua54.can:121
if type(node) == "table" then -- ./compiler/lua54.can:122
if tagsCheck[node["tag"]] then -- ./compiler/lua54.can:123
return node -- ./compiler/lua54.can:124
end -- ./compiler/lua54.can:124
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.can:126
local r = any(node, tags, nofollow) -- ./compiler/lua54.can:127
if r then -- ./compiler/lua54.can:128
return r -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
return nil -- ./compiler/lua54.can:132
end -- ./compiler/lua54.can:132
local function search(list, tags, nofollow) -- ./compiler/lua54.can:137
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.can:137
local tagsCheck = {} -- ./compiler/lua54.can:138
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:139
tagsCheck[tag] = true -- ./compiler/lua54.can:140
end -- ./compiler/lua54.can:140
local nofollowCheck = {} -- ./compiler/lua54.can:142
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.can:143
nofollowCheck[tag] = true -- ./compiler/lua54.can:144
end -- ./compiler/lua54.can:144
local found = {} -- ./compiler/lua54.can:146
for _, node in ipairs(list) do -- ./compiler/lua54.can:147
if type(node) == "table" then -- ./compiler/lua54.can:148
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.can:149
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.can:150
table["insert"](found, n) -- ./compiler/lua54.can:151
end -- ./compiler/lua54.can:151
end -- ./compiler/lua54.can:151
if tagsCheck[node["tag"]] then -- ./compiler/lua54.can:154
table["insert"](found, node) -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
return found -- ./compiler/lua54.can:159
end -- ./compiler/lua54.can:159
local function all(list, tags) -- ./compiler/lua54.can:163
for _, node in ipairs(list) do -- ./compiler/lua54.can:164
local ok = false -- ./compiler/lua54.can:165
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:166
if node["tag"] == tag then -- ./compiler/lua54.can:167
ok = true -- ./compiler/lua54.can:168
break -- ./compiler/lua54.can:169
end -- ./compiler/lua54.can:169
end -- ./compiler/lua54.can:169
if not ok then -- ./compiler/lua54.can:172
return false -- ./compiler/lua54.can:173
end -- ./compiler/lua54.can:173
end -- ./compiler/lua54.can:173
return true -- ./compiler/lua54.can:176
end -- ./compiler/lua54.can:176
local tags -- ./compiler/lua54.can:180
local function lua(ast, forceTag, ...) -- ./compiler/lua54.can:182
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.can:183
lastInputPos = ast["pos"] -- ./compiler/lua54.can:184
end -- ./compiler/lua54.can:184
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.can:186
end -- ./compiler/lua54.can:186
local UNPACK = function(list, i, j) -- ./compiler/lua54.can:190
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.can:191
end -- ./compiler/lua54.can:191
local APPEND = function(t, toAppend) -- ./compiler/lua54.can:193
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.can:194
end -- ./compiler/lua54.can:194
local CONTINUE_START = function() -- ./compiler/lua54.can:196
return "do" .. indent() -- ./compiler/lua54.can:197
end -- ./compiler/lua54.can:197
local CONTINUE_STOP = function() -- ./compiler/lua54.can:199
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.can:200
end -- ./compiler/lua54.can:200
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.can:202
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.can:202
if noLocal == nil then noLocal = false end -- ./compiler/lua54.can:202
local vars = {} -- ./compiler/lua54.can:203
local values = {} -- ./compiler/lua54.can:204
for _, list in ipairs(destructured) do -- ./compiler/lua54.can:205
for _, v in ipairs(list) do -- ./compiler/lua54.can:206
local var, val -- ./compiler/lua54.can:207
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.can:208
var = v -- ./compiler/lua54.can:209
val = { -- ./compiler/lua54.can:210
["tag"] = "Index", -- ./compiler/lua54.can:210
{ -- ./compiler/lua54.can:210
["tag"] = "Id", -- ./compiler/lua54.can:210
list["id"] -- ./compiler/lua54.can:210
}, -- ./compiler/lua54.can:210
{ -- ./compiler/lua54.can:210
["tag"] = "String", -- ./compiler/lua54.can:210
v[1] -- ./compiler/lua54.can:210
} -- ./compiler/lua54.can:210
} -- ./compiler/lua54.can:210
elseif v["tag"] == "Pair" then -- ./compiler/lua54.can:211
var = v[2] -- ./compiler/lua54.can:212
val = { -- ./compiler/lua54.can:213
["tag"] = "Index", -- ./compiler/lua54.can:213
{ -- ./compiler/lua54.can:213
["tag"] = "Id", -- ./compiler/lua54.can:213
list["id"] -- ./compiler/lua54.can:213
}, -- ./compiler/lua54.can:213
v[1] -- ./compiler/lua54.can:213
} -- ./compiler/lua54.can:213
else -- ./compiler/lua54.can:213
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.can:215
end -- ./compiler/lua54.can:215
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.can:217
val = { -- ./compiler/lua54.can:218
["tag"] = "Op", -- ./compiler/lua54.can:218
destructured["rightOp"], -- ./compiler/lua54.can:218
var, -- ./compiler/lua54.can:218
{ -- ./compiler/lua54.can:218
["tag"] = "Op", -- ./compiler/lua54.can:218
destructured["leftOp"], -- ./compiler/lua54.can:218
val, -- ./compiler/lua54.can:218
var -- ./compiler/lua54.can:218
} -- ./compiler/lua54.can:218
} -- ./compiler/lua54.can:218
elseif destructured["rightOp"] then -- ./compiler/lua54.can:219
val = { -- ./compiler/lua54.can:220
["tag"] = "Op", -- ./compiler/lua54.can:220
destructured["rightOp"], -- ./compiler/lua54.can:220
var, -- ./compiler/lua54.can:220
val -- ./compiler/lua54.can:220
} -- ./compiler/lua54.can:220
elseif destructured["leftOp"] then -- ./compiler/lua54.can:221
val = { -- ./compiler/lua54.can:222
["tag"] = "Op", -- ./compiler/lua54.can:222
destructured["leftOp"], -- ./compiler/lua54.can:222
val, -- ./compiler/lua54.can:222
var -- ./compiler/lua54.can:222
} -- ./compiler/lua54.can:222
end -- ./compiler/lua54.can:222
table["insert"](vars, lua(var)) -- ./compiler/lua54.can:224
table["insert"](values, lua(val)) -- ./compiler/lua54.can:225
end -- ./compiler/lua54.can:225
end -- ./compiler/lua54.can:225
if # vars > 0 then -- ./compiler/lua54.can:228
local decl = noLocal and "" or "local " -- ./compiler/lua54.can:229
if newlineAfter then -- ./compiler/lua54.can:230
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.can:231
else -- ./compiler/lua54.can:231
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.can:233
end -- ./compiler/lua54.can:233
else -- ./compiler/lua54.can:233
return "" -- ./compiler/lua54.can:236
end -- ./compiler/lua54.can:236
end -- ./compiler/lua54.can:236
tags = setmetatable({ -- ./compiler/lua54.can:241
["Block"] = function(t) -- ./compiler/lua54.can:243
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.can:244
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.can:245
hasPush["tag"] = "Return" -- ./compiler/lua54.can:246
hasPush = false -- ./compiler/lua54.can:247
end -- ./compiler/lua54.can:247
local r = push("scope", {}) -- ./compiler/lua54.can:249
if hasPush then -- ./compiler/lua54.can:250
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:251
end -- ./compiler/lua54.can:251
for i = 1, # t - 1, 1 do -- ./compiler/lua54.can:253
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.can:254
end -- ./compiler/lua54.can:254
if t[# t] then -- ./compiler/lua54.can:256
r = r .. (lua(t[# t])) -- ./compiler/lua54.can:257
end -- ./compiler/lua54.can:257
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.can:259
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.can:260
end -- ./compiler/lua54.can:260
return r .. pop("scope") -- ./compiler/lua54.can:262
end, -- ./compiler/lua54.can:262
["Do"] = function(t) -- ./compiler/lua54.can:268
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.can:269
end, -- ./compiler/lua54.can:269
["Set"] = function(t) -- ./compiler/lua54.can:272
local expr = t[# t] -- ./compiler/lua54.can:274
local vars, values = {}, {} -- ./compiler/lua54.can:275
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.can:276
for i, n in ipairs(t[1]) do -- ./compiler/lua54.can:277
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.can:278
table["insert"](destructuringVars, n) -- ./compiler/lua54.can:279
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.can:280
else -- ./compiler/lua54.can:280
table["insert"](vars, n) -- ./compiler/lua54.can:282
table["insert"](values, expr[i]) -- ./compiler/lua54.can:283
end -- ./compiler/lua54.can:283
end -- ./compiler/lua54.can:283
if # t == 2 or # t == 3 then -- ./compiler/lua54.can:287
local r = "" -- ./compiler/lua54.can:288
if # vars > 0 then -- ./compiler/lua54.can:289
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.can:290
end -- ./compiler/lua54.can:290
if # destructuringVars > 0 then -- ./compiler/lua54.can:292
local destructured = {} -- ./compiler/lua54.can:293
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:294
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:295
end -- ./compiler/lua54.can:295
return r -- ./compiler/lua54.can:297
elseif # t == 4 then -- ./compiler/lua54.can:298
if t[3] == "=" then -- ./compiler/lua54.can:299
local r = "" -- ./compiler/lua54.can:300
if # vars > 0 then -- ./compiler/lua54.can:301
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:302
t[2], -- ./compiler/lua54.can:302
vars[1], -- ./compiler/lua54.can:302
{ -- ./compiler/lua54.can:302
["tag"] = "Paren", -- ./compiler/lua54.can:302
values[1] -- ./compiler/lua54.can:302
} -- ./compiler/lua54.can:302
}, "Op")) -- ./compiler/lua54.can:302
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.can:303
r = r .. (", " .. lua({ -- ./compiler/lua54.can:304
t[2], -- ./compiler/lua54.can:304
vars[i], -- ./compiler/lua54.can:304
{ -- ./compiler/lua54.can:304
["tag"] = "Paren", -- ./compiler/lua54.can:304
values[i] -- ./compiler/lua54.can:304
} -- ./compiler/lua54.can:304
}, "Op")) -- ./compiler/lua54.can:304
end -- ./compiler/lua54.can:304
end -- ./compiler/lua54.can:304
if # destructuringVars > 0 then -- ./compiler/lua54.can:307
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.can:308
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:309
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:310
end -- ./compiler/lua54.can:310
return r -- ./compiler/lua54.can:312
else -- ./compiler/lua54.can:312
local r = "" -- ./compiler/lua54.can:314
if # vars > 0 then -- ./compiler/lua54.can:315
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:316
t[3], -- ./compiler/lua54.can:316
{ -- ./compiler/lua54.can:316
["tag"] = "Paren", -- ./compiler/lua54.can:316
values[1] -- ./compiler/lua54.can:316
}, -- ./compiler/lua54.can:316
vars[1] -- ./compiler/lua54.can:316
}, "Op")) -- ./compiler/lua54.can:316
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.can:317
r = r .. (", " .. lua({ -- ./compiler/lua54.can:318
t[3], -- ./compiler/lua54.can:318
{ -- ./compiler/lua54.can:318
["tag"] = "Paren", -- ./compiler/lua54.can:318
values[i] -- ./compiler/lua54.can:318
}, -- ./compiler/lua54.can:318
vars[i] -- ./compiler/lua54.can:318
}, "Op")) -- ./compiler/lua54.can:318
end -- ./compiler/lua54.can:318
end -- ./compiler/lua54.can:318
if # destructuringVars > 0 then -- ./compiler/lua54.can:321
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.can:322
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:323
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:324
end -- ./compiler/lua54.can:324
return r -- ./compiler/lua54.can:326
end -- ./compiler/lua54.can:326
else -- ./compiler/lua54.can:326
local r = "" -- ./compiler/lua54.can:329
if # vars > 0 then -- ./compiler/lua54.can:330
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:331
t[2], -- ./compiler/lua54.can:331
vars[1], -- ./compiler/lua54.can:331
{ -- ./compiler/lua54.can:331
["tag"] = "Op", -- ./compiler/lua54.can:331
t[4], -- ./compiler/lua54.can:331
{ -- ./compiler/lua54.can:331
["tag"] = "Paren", -- ./compiler/lua54.can:331
values[1] -- ./compiler/lua54.can:331
}, -- ./compiler/lua54.can:331
vars[1] -- ./compiler/lua54.can:331
} -- ./compiler/lua54.can:331
}, "Op")) -- ./compiler/lua54.can:331
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.can:332
r = r .. (", " .. lua({ -- ./compiler/lua54.can:333
t[2], -- ./compiler/lua54.can:333
vars[i], -- ./compiler/lua54.can:333
{ -- ./compiler/lua54.can:333
["tag"] = "Op", -- ./compiler/lua54.can:333
t[4], -- ./compiler/lua54.can:333
{ -- ./compiler/lua54.can:333
["tag"] = "Paren", -- ./compiler/lua54.can:333
values[i] -- ./compiler/lua54.can:333
}, -- ./compiler/lua54.can:333
vars[i] -- ./compiler/lua54.can:333
} -- ./compiler/lua54.can:333
}, "Op")) -- ./compiler/lua54.can:333
end -- ./compiler/lua54.can:333
end -- ./compiler/lua54.can:333
if # destructuringVars > 0 then -- ./compiler/lua54.can:336
local destructured = { -- ./compiler/lua54.can:337
["rightOp"] = t[2], -- ./compiler/lua54.can:337
["leftOp"] = t[4] -- ./compiler/lua54.can:337
} -- ./compiler/lua54.can:337
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:338
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:339
end -- ./compiler/lua54.can:339
return r -- ./compiler/lua54.can:341
end -- ./compiler/lua54.can:341
end, -- ./compiler/lua54.can:341
["While"] = function(t) -- ./compiler/lua54.can:345
local r = "" -- ./compiler/lua54.can:346
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.can:347
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.can:348
if # lets > 0 then -- ./compiler/lua54.can:349
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:350
for _, l in ipairs(lets) do -- ./compiler/lua54.can:351
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:352
end -- ./compiler/lua54.can:352
end -- ./compiler/lua54.can:352
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.can:355
if # lets > 0 then -- ./compiler/lua54.can:356
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:357
end -- ./compiler/lua54.can:357
if hasContinue then -- ./compiler/lua54.can:359
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:360
end -- ./compiler/lua54.can:360
r = r .. (lua(t[2])) -- ./compiler/lua54.can:362
if hasContinue then -- ./compiler/lua54.can:363
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:364
end -- ./compiler/lua54.can:364
r = r .. (unindent() .. "end") -- ./compiler/lua54.can:366
if # lets > 0 then -- ./compiler/lua54.can:367
for _, l in ipairs(lets) do -- ./compiler/lua54.can:368
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.can:369
end -- ./compiler/lua54.can:369
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.can:371
end -- ./compiler/lua54.can:371
return r -- ./compiler/lua54.can:373
end, -- ./compiler/lua54.can:373
["Repeat"] = function(t) -- ./compiler/lua54.can:376
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.can:377
local r = "repeat" .. indent() -- ./compiler/lua54.can:378
if hasContinue then -- ./compiler/lua54.can:379
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:380
end -- ./compiler/lua54.can:380
r = r .. (lua(t[1])) -- ./compiler/lua54.can:382
if hasContinue then -- ./compiler/lua54.can:383
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:384
end -- ./compiler/lua54.can:384
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.can:386
return r -- ./compiler/lua54.can:387
end, -- ./compiler/lua54.can:387
["If"] = function(t) -- ./compiler/lua54.can:390
local r = "" -- ./compiler/lua54.can:391
local toClose = 0 -- ./compiler/lua54.can:392
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.can:393
if # lets > 0 then -- ./compiler/lua54.can:394
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:395
toClose = toClose + (1) -- ./compiler/lua54.can:396
for _, l in ipairs(lets) do -- ./compiler/lua54.can:397
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:398
end -- ./compiler/lua54.can:398
end -- ./compiler/lua54.can:398
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.can:401
for i = 3, # t - 1, 2 do -- ./compiler/lua54.can:402
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.can:403
if # lets > 0 then -- ./compiler/lua54.can:404
r = r .. ("else" .. indent()) -- ./compiler/lua54.can:405
toClose = toClose + (1) -- ./compiler/lua54.can:406
for _, l in ipairs(lets) do -- ./compiler/lua54.can:407
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:408
end -- ./compiler/lua54.can:408
else -- ./compiler/lua54.can:408
r = r .. ("else") -- ./compiler/lua54.can:411
end -- ./compiler/lua54.can:411
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.can:413
end -- ./compiler/lua54.can:413
if # t % 2 == 1 then -- ./compiler/lua54.can:415
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.can:416
end -- ./compiler/lua54.can:416
r = r .. ("end") -- ./compiler/lua54.can:418
for i = 1, toClose do -- ./compiler/lua54.can:419
r = r .. (unindent() .. "end") -- ./compiler/lua54.can:420
end -- ./compiler/lua54.can:420
return r -- ./compiler/lua54.can:422
end, -- ./compiler/lua54.can:422
["Fornum"] = function(t) -- ./compiler/lua54.can:425
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.can:426
if # t == 5 then -- ./compiler/lua54.can:427
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.can:428
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.can:429
if hasContinue then -- ./compiler/lua54.can:430
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:431
end -- ./compiler/lua54.can:431
r = r .. (lua(t[5])) -- ./compiler/lua54.can:433
if hasContinue then -- ./compiler/lua54.can:434
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:435
end -- ./compiler/lua54.can:435
return r .. unindent() .. "end" -- ./compiler/lua54.can:437
else -- ./compiler/lua54.can:437
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.can:439
r = r .. (" do" .. indent()) -- ./compiler/lua54.can:440
if hasContinue then -- ./compiler/lua54.can:441
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:442
end -- ./compiler/lua54.can:442
r = r .. (lua(t[4])) -- ./compiler/lua54.can:444
if hasContinue then -- ./compiler/lua54.can:445
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:446
end -- ./compiler/lua54.can:446
return r .. unindent() .. "end" -- ./compiler/lua54.can:448
end -- ./compiler/lua54.can:448
end, -- ./compiler/lua54.can:448
["Forin"] = function(t) -- ./compiler/lua54.can:452
local destructured = {} -- ./compiler/lua54.can:453
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.can:454
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.can:455
if hasContinue then -- ./compiler/lua54.can:456
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:457
end -- ./compiler/lua54.can:457
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.can:459
if hasContinue then -- ./compiler/lua54.can:460
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:461
end -- ./compiler/lua54.can:461
return r .. unindent() .. "end" -- ./compiler/lua54.can:463
end, -- ./compiler/lua54.can:463
["Local"] = function(t) -- ./compiler/lua54.can:466
local destructured = {} -- ./compiler/lua54.can:467
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.can:468
if t[2][1] then -- ./compiler/lua54.can:469
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:470
end -- ./compiler/lua54.can:470
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.can:472
end, -- ./compiler/lua54.can:472
["Let"] = function(t) -- ./compiler/lua54.can:475
local destructured = {} -- ./compiler/lua54.can:476
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.can:477
local r = "local " .. nameList -- ./compiler/lua54.can:478
if t[2][1] then -- ./compiler/lua54.can:479
if all(t[2], { -- ./compiler/lua54.can:480
"Nil", -- ./compiler/lua54.can:480
"Dots", -- ./compiler/lua54.can:480
"Boolean", -- ./compiler/lua54.can:480
"Number", -- ./compiler/lua54.can:480
"String" -- ./compiler/lua54.can:480
}) then -- ./compiler/lua54.can:480
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:481
else -- ./compiler/lua54.can:481
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:483
end -- ./compiler/lua54.can:483
end -- ./compiler/lua54.can:483
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.can:486
end, -- ./compiler/lua54.can:486
["Localrec"] = function(t) -- ./compiler/lua54.can:489
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.can:490
end, -- ./compiler/lua54.can:490
["Goto"] = function(t) -- ./compiler/lua54.can:493
return "goto " .. lua(t, "Id") -- ./compiler/lua54.can:494
end, -- ./compiler/lua54.can:494
["Label"] = function(t) -- ./compiler/lua54.can:497
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.can:498
end, -- ./compiler/lua54.can:498
["Return"] = function(t) -- ./compiler/lua54.can:501
local push = peek("push") -- ./compiler/lua54.can:502
if push then -- ./compiler/lua54.can:503
local r = "" -- ./compiler/lua54.can:504
for _, val in ipairs(t) do -- ./compiler/lua54.can:505
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.can:506
end -- ./compiler/lua54.can:506
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.can:508
else -- ./compiler/lua54.can:508
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.can:510
end -- ./compiler/lua54.can:510
end, -- ./compiler/lua54.can:510
["Push"] = function(t) -- ./compiler/lua54.can:514
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.can:515
r = "" -- ./compiler/lua54.can:516
for i = 1, # t - 1, 1 do -- ./compiler/lua54.can:517
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.can:518
end -- ./compiler/lua54.can:518
if t[# t] then -- ./compiler/lua54.can:520
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.can:521
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.can:522
else -- ./compiler/lua54.can:522
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.can:524
end -- ./compiler/lua54.can:524
end -- ./compiler/lua54.can:524
return r -- ./compiler/lua54.can:527
end, -- ./compiler/lua54.can:527
["Break"] = function() -- ./compiler/lua54.can:530
return "break" -- ./compiler/lua54.can:531
end, -- ./compiler/lua54.can:531
["Continue"] = function() -- ./compiler/lua54.can:534
return "goto " .. var("continue") -- ./compiler/lua54.can:535
end, -- ./compiler/lua54.can:535
["Nil"] = function() -- ./compiler/lua54.can:542
return "nil" -- ./compiler/lua54.can:543
end, -- ./compiler/lua54.can:543
["Dots"] = function() -- ./compiler/lua54.can:546
local macroargs = peek("macroargs") -- ./compiler/lua54.can:547
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.can:548
nomacro["variables"]["..."] = true -- ./compiler/lua54.can:549
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.can:550
nomacro["variables"]["..."] = nil -- ./compiler/lua54.can:551
return r -- ./compiler/lua54.can:552
else -- ./compiler/lua54.can:552
return "..." -- ./compiler/lua54.can:554
end -- ./compiler/lua54.can:554
end, -- ./compiler/lua54.can:554
["Boolean"] = function(t) -- ./compiler/lua54.can:558
return tostring(t[1]) -- ./compiler/lua54.can:559
end, -- ./compiler/lua54.can:559
["Number"] = function(t) -- ./compiler/lua54.can:562
return tostring(t[1]) -- ./compiler/lua54.can:563
end, -- ./compiler/lua54.can:563
["String"] = function(t) -- ./compiler/lua54.can:566
return ("%q"):format(t[1]) -- ./compiler/lua54.can:567
end, -- ./compiler/lua54.can:567
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.can:570
local r = "(" -- ./compiler/lua54.can:571
local decl = {} -- ./compiler/lua54.can:572
if t[1][1] then -- ./compiler/lua54.can:573
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.can:574
local id = lua(t[1][1][1]) -- ./compiler/lua54.can:575
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:576
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.can:577
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:578
r = r .. (id) -- ./compiler/lua54.can:579
else -- ./compiler/lua54.can:579
r = r .. (lua(t[1][1])) -- ./compiler/lua54.can:581
end -- ./compiler/lua54.can:581
for i = 2, # t[1], 1 do -- ./compiler/lua54.can:583
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.can:584
local id = lua(t[1][i][1]) -- ./compiler/lua54.can:585
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:586
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.can:587
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:588
r = r .. (", " .. id) -- ./compiler/lua54.can:589
else -- ./compiler/lua54.can:589
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
r = r .. (")" .. indent()) -- ./compiler/lua54.can:595
for _, d in ipairs(decl) do -- ./compiler/lua54.can:596
r = r .. (d .. newline()) -- ./compiler/lua54.can:597
end -- ./compiler/lua54.can:597
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.can:599
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.can:600
end -- ./compiler/lua54.can:600
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.can:602
if hasPush then -- ./compiler/lua54.can:603
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:604
else -- ./compiler/lua54.can:604
push("push", false) -- ./compiler/lua54.can:606
end -- ./compiler/lua54.can:606
r = r .. (lua(t[2])) -- ./compiler/lua54.can:608
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.can:609
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.can:610
end -- ./compiler/lua54.can:610
pop("push") -- ./compiler/lua54.can:612
return r .. unindent() .. "end" -- ./compiler/lua54.can:613
end, -- ./compiler/lua54.can:613
["Function"] = function(t) -- ./compiler/lua54.can:615
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.can:616
end, -- ./compiler/lua54.can:616
["Pair"] = function(t) -- ./compiler/lua54.can:619
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.can:620
end, -- ./compiler/lua54.can:620
["Table"] = function(t) -- ./compiler/lua54.can:622
if # t == 0 then -- ./compiler/lua54.can:623
return "{}" -- ./compiler/lua54.can:624
elseif # t == 1 then -- ./compiler/lua54.can:625
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.can:626
else -- ./compiler/lua54.can:626
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.can:628
end -- ./compiler/lua54.can:628
end, -- ./compiler/lua54.can:628
["TableCompr"] = function(t) -- ./compiler/lua54.can:632
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.can:633
end, -- ./compiler/lua54.can:633
["Op"] = function(t) -- ./compiler/lua54.can:636
local r -- ./compiler/lua54.can:637
if # t == 2 then -- ./compiler/lua54.can:638
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.can:639
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.can:640
else -- ./compiler/lua54.can:640
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.can:642
end -- ./compiler/lua54.can:642
else -- ./compiler/lua54.can:642
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.can:645
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.can:646
else -- ./compiler/lua54.can:646
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.can:648
end -- ./compiler/lua54.can:648
end -- ./compiler/lua54.can:648
return r -- ./compiler/lua54.can:651
end, -- ./compiler/lua54.can:651
["Paren"] = function(t) -- ./compiler/lua54.can:654
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.can:655
end, -- ./compiler/lua54.can:655
["MethodStub"] = function(t) -- ./compiler/lua54.can:658
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.can:664
end, -- ./compiler/lua54.can:664
["SafeMethodStub"] = function(t) -- ./compiler/lua54.can:667
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.can:674
end, -- ./compiler/lua54.can:674
["LetExpr"] = function(t) -- ./compiler/lua54.can:681
return lua(t[1][1]) -- ./compiler/lua54.can:682
end, -- ./compiler/lua54.can:682
["_statexpr"] = function(t, stat) -- ./compiler/lua54.can:686
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.can:687
local r = "(function()" .. indent() -- ./compiler/lua54.can:688
if hasPush then -- ./compiler/lua54.can:689
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:690
else -- ./compiler/lua54.can:690
push("push", false) -- ./compiler/lua54.can:692
end -- ./compiler/lua54.can:692
r = r .. (lua(t, stat)) -- ./compiler/lua54.can:694
if hasPush then -- ./compiler/lua54.can:695
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.can:696
end -- ./compiler/lua54.can:696
pop("push") -- ./compiler/lua54.can:698
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.can:699
return r -- ./compiler/lua54.can:700
end, -- ./compiler/lua54.can:700
["DoExpr"] = function(t) -- ./compiler/lua54.can:703
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.can:704
t[# t]["tag"] = "Return" -- ./compiler/lua54.can:705
end -- ./compiler/lua54.can:705
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.can:707
end, -- ./compiler/lua54.can:707
["WhileExpr"] = function(t) -- ./compiler/lua54.can:710
return lua(t, "_statexpr", "While") -- ./compiler/lua54.can:711
end, -- ./compiler/lua54.can:711
["RepeatExpr"] = function(t) -- ./compiler/lua54.can:714
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.can:715
end, -- ./compiler/lua54.can:715
["IfExpr"] = function(t) -- ./compiler/lua54.can:718
for i = 2, # t do -- ./compiler/lua54.can:719
local block = t[i] -- ./compiler/lua54.can:720
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.can:721
block[# block]["tag"] = "Return" -- ./compiler/lua54.can:722
end -- ./compiler/lua54.can:722
end -- ./compiler/lua54.can:722
return lua(t, "_statexpr", "If") -- ./compiler/lua54.can:725
end, -- ./compiler/lua54.can:725
["FornumExpr"] = function(t) -- ./compiler/lua54.can:728
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.can:729
end, -- ./compiler/lua54.can:729
["ForinExpr"] = function(t) -- ./compiler/lua54.can:732
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.can:733
end, -- ./compiler/lua54.can:733
["Call"] = function(t) -- ./compiler/lua54.can:739
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.can:740
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:741
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.can:742
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.can:743
local replacement = macro["replacement"] -- ./compiler/lua54.can:744
local r -- ./compiler/lua54.can:745
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.can:746
if type(replacement) == "function" then -- ./compiler/lua54.can:747
local args = {} -- ./compiler/lua54.can:748
for i = 2, # t do -- ./compiler/lua54.can:749
table["insert"](args, lua(t[i])) -- ./compiler/lua54.can:750
end -- ./compiler/lua54.can:750
r = replacement(unpack(args)) -- ./compiler/lua54.can:752
else -- ./compiler/lua54.can:752
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.can:754
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.can:755
if arg["tag"] == "Dots" then -- ./compiler/lua54.can:756
macroargs["..."] = (function() -- ./compiler/lua54.can:757
local self = {} -- ./compiler/lua54.can:757
for j = i + 1, # t do -- ./compiler/lua54.can:757
self[#self+1] = t[j] -- ./compiler/lua54.can:757
end -- ./compiler/lua54.can:757
return self -- ./compiler/lua54.can:757
end)() -- ./compiler/lua54.can:757
elseif arg["tag"] == "Id" then -- ./compiler/lua54.can:758
if t[i + 1] == nil then -- ./compiler/lua54.can:759
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.can:760
end -- ./compiler/lua54.can:760
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.can:762
else -- ./compiler/lua54.can:762
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.can:764
end -- ./compiler/lua54.can:764
end -- ./compiler/lua54.can:764
push("macroargs", macroargs) -- ./compiler/lua54.can:767
r = lua(replacement) -- ./compiler/lua54.can:768
pop("macroargs") -- ./compiler/lua54.can:769
end -- ./compiler/lua54.can:769
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.can:771
return r -- ./compiler/lua54.can:772
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.can:773
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.can:774
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:775
else -- ./compiler/lua54.can:775
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:777
end -- ./compiler/lua54.can:777
else -- ./compiler/lua54.can:777
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:780
end -- ./compiler/lua54.can:780
end, -- ./compiler/lua54.can:780
["SafeCall"] = function(t) -- ./compiler/lua54.can:784
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.can:785
return lua(t, "SafeIndex") -- ./compiler/lua54.can:786
else -- ./compiler/lua54.can:786
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.can:788
end -- ./compiler/lua54.can:788
end, -- ./compiler/lua54.can:788
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.can:793
if start == nil then start = 1 end -- ./compiler/lua54.can:793
local r -- ./compiler/lua54.can:794
if t[start] then -- ./compiler/lua54.can:795
r = lua(t[start]) -- ./compiler/lua54.can:796
for i = start + 1, # t, 1 do -- ./compiler/lua54.can:797
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.can:798
end -- ./compiler/lua54.can:798
else -- ./compiler/lua54.can:798
r = "" -- ./compiler/lua54.can:801
end -- ./compiler/lua54.can:801
return r -- ./compiler/lua54.can:803
end, -- ./compiler/lua54.can:803
["Id"] = function(t) -- ./compiler/lua54.can:806
local r = t[1] -- ./compiler/lua54.can:807
local macroargs = peek("macroargs") -- ./compiler/lua54.can:808
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.can:809
nomacro["variables"][t[1]] = true -- ./compiler/lua54.can:810
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.can:811
r = lua(macroargs[t[1]]) -- ./compiler/lua54.can:812
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.can:813
local macro = macros["variables"][t[1]] -- ./compiler/lua54.can:814
if type(macro) == "function" then -- ./compiler/lua54.can:815
r = macro() -- ./compiler/lua54.can:816
else -- ./compiler/lua54.can:816
r = lua(macro) -- ./compiler/lua54.can:818
end -- ./compiler/lua54.can:818
end -- ./compiler/lua54.can:818
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.can:821
end -- ./compiler/lua54.can:821
return r -- ./compiler/lua54.can:823
end, -- ./compiler/lua54.can:823
["AttributeId"] = function(t) -- ./compiler/lua54.can:826
if t[2] then -- ./compiler/lua54.can:827
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.can:828
else -- ./compiler/lua54.can:828
return t[1] -- ./compiler/lua54.can:830
end -- ./compiler/lua54.can:830
end, -- ./compiler/lua54.can:830
["DestructuringId"] = function(t) -- ./compiler/lua54.can:834
if t["id"] then -- ./compiler/lua54.can:835
return t["id"] -- ./compiler/lua54.can:836
else -- ./compiler/lua54.can:836
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.can:838
local vars = { ["id"] = tmp() } -- ./compiler/lua54.can:839
for j = 1, # t, 1 do -- ./compiler/lua54.can:840
table["insert"](vars, t[j]) -- ./compiler/lua54.can:841
end -- ./compiler/lua54.can:841
table["insert"](d, vars) -- ./compiler/lua54.can:843
t["id"] = vars["id"] -- ./compiler/lua54.can:844
return vars["id"] -- ./compiler/lua54.can:845
end -- ./compiler/lua54.can:845
end, -- ./compiler/lua54.can:845
["Index"] = function(t) -- ./compiler/lua54.can:849
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.can:850
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.can:851
else -- ./compiler/lua54.can:851
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.can:853
end -- ./compiler/lua54.can:853
end, -- ./compiler/lua54.can:853
["SafeIndex"] = function(t) -- ./compiler/lua54.can:857
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.can:858
local l = {} -- ./compiler/lua54.can:859
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.can:860
table["insert"](l, 1, t) -- ./compiler/lua54.can:861
t = t[1] -- ./compiler/lua54.can:862
end -- ./compiler/lua54.can:862
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.can:864
for _, e in ipairs(l) do -- ./compiler/lua54.can:865
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.can:866
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.can:867
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.can:868
else -- ./compiler/lua54.can:868
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.can:870
end -- ./compiler/lua54.can:870
end -- ./compiler/lua54.can:870
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.can:873
return r -- ./compiler/lua54.can:874
else -- ./compiler/lua54.can:874
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.can:876
end -- ./compiler/lua54.can:876
end, -- ./compiler/lua54.can:876
["_opid"] = { -- ./compiler/lua54.can:881
["add"] = "+", -- ./compiler/lua54.can:882
["sub"] = "-", -- ./compiler/lua54.can:882
["mul"] = "*", -- ./compiler/lua54.can:882
["div"] = "/", -- ./compiler/lua54.can:882
["idiv"] = "//", -- ./compiler/lua54.can:883
["mod"] = "%", -- ./compiler/lua54.can:883
["pow"] = "^", -- ./compiler/lua54.can:883
["concat"] = "..", -- ./compiler/lua54.can:883
["band"] = "&", -- ./compiler/lua54.can:884
["bor"] = "|", -- ./compiler/lua54.can:884
["bxor"] = "~", -- ./compiler/lua54.can:884
["shl"] = "<<", -- ./compiler/lua54.can:884
["shr"] = ">>", -- ./compiler/lua54.can:884
["eq"] = "==", -- ./compiler/lua54.can:885
["ne"] = "~=", -- ./compiler/lua54.can:885
["lt"] = "<", -- ./compiler/lua54.can:885
["gt"] = ">", -- ./compiler/lua54.can:885
["le"] = "<=", -- ./compiler/lua54.can:885
["ge"] = ">=", -- ./compiler/lua54.can:885
["and"] = "and", -- ./compiler/lua54.can:886
["or"] = "or", -- ./compiler/lua54.can:886
["unm"] = "-", -- ./compiler/lua54.can:886
["len"] = "#", -- ./compiler/lua54.can:886
["bnot"] = "~", -- ./compiler/lua54.can:886
["not"] = "not" -- ./compiler/lua54.can:886
} -- ./compiler/lua54.can:886
}, { ["__index"] = function(self, key) -- ./compiler/lua54.can:889
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.can:890
end }) -- ./compiler/lua54.can:890
targetName = "Lua 5.3" -- ./compiler/lua53.can:1
tags["AttributeId"] = function(t) -- ./compiler/lua53.can:4
if t[2] then -- ./compiler/lua53.can:5
error("target " .. targetName .. " does not support variable attributes") -- ./compiler/lua53.can:6
else -- ./compiler/lua53.can:6
return t[1] -- ./compiler/lua53.can:8
end -- ./compiler/lua53.can:8
end -- ./compiler/lua53.can:8
local code = lua(ast) .. newline() -- ./compiler/lua54.can:896
return requireStr .. code -- ./compiler/lua54.can:897
end -- ./compiler/lua54.can:897
end -- ./compiler/lua54.can:897
local lua54 = _() or lua54 -- ./compiler/lua54.can:902
return lua54 -- ./compiler/lua53.can:18
end -- ./compiler/lua53.can:18
local lua53 = _() or lua53 -- ./compiler/lua53.can:22
package["loaded"]["compiler.lua53"] = lua53 or true -- ./compiler/lua53.can:23
local function _() -- ./compiler/lua53.can:26
local function _() -- ./compiler/lua53.can:28
local function _() -- ./compiler/lua53.can:30
local util = require("lepton.util") -- ./compiler/lua54.can:1
local targetName = "Lua 5.4" -- ./compiler/lua54.can:3
local unpack = unpack or table["unpack"] -- ./compiler/lua54.can:5
return function(code, ast, options, macros) -- ./compiler/lua54.can:7
if macros == nil then macros = { -- ./compiler/lua54.can:7
["functions"] = {}, -- ./compiler/lua54.can:7
["variables"] = {} -- ./compiler/lua54.can:7
} end -- ./compiler/lua54.can:7
local lastInputPos = 1 -- ./compiler/lua54.can:9
local prevLinePos = 1 -- ./compiler/lua54.can:10
local lastSource = options["chunkname"] or "nil" -- ./compiler/lua54.can:11
local lastLine = 1 -- ./compiler/lua54.can:12
local indentLevel = 0 -- ./compiler/lua54.can:15
local function newline() -- ./compiler/lua54.can:17
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.can:18
if options["mapLines"] then -- ./compiler/lua54.can:19
local sub = code:sub(lastInputPos) -- ./compiler/lua54.can:20
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.can:21
if source and line then -- ./compiler/lua54.can:23
lastSource = source -- ./compiler/lua54.can:24
lastLine = tonumber(line) -- ./compiler/lua54.can:25
else -- ./compiler/lua54.can:25
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.can:27
lastLine = lastLine + (1) -- ./compiler/lua54.can:28
end -- ./compiler/lua54.can:28
end -- ./compiler/lua54.can:28
prevLinePos = lastInputPos -- ./compiler/lua54.can:32
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.can:34
end -- ./compiler/lua54.can:34
return r -- ./compiler/lua54.can:36
end -- ./compiler/lua54.can:36
local function indent() -- ./compiler/lua54.can:39
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:40
return newline() -- ./compiler/lua54.can:41
end -- ./compiler/lua54.can:41
local function unindent() -- ./compiler/lua54.can:44
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:45
return newline() -- ./compiler/lua54.can:46
end -- ./compiler/lua54.can:46
local states = { -- ./compiler/lua54.can:51
["push"] = {}, -- ./compiler/lua54.can:52
["destructuring"] = {}, -- ./compiler/lua54.can:53
["scope"] = {}, -- ./compiler/lua54.can:54
["macroargs"] = {} -- ./compiler/lua54.can:55
} -- ./compiler/lua54.can:55
local function push(name, state) -- ./compiler/lua54.can:58
table["insert"](states[name], state) -- ./compiler/lua54.can:59
return "" -- ./compiler/lua54.can:60
end -- ./compiler/lua54.can:60
local function pop(name) -- ./compiler/lua54.can:63
table["remove"](states[name]) -- ./compiler/lua54.can:64
return "" -- ./compiler/lua54.can:65
end -- ./compiler/lua54.can:65
local function set(name, state) -- ./compiler/lua54.can:68
states[name][# states[name]] = state -- ./compiler/lua54.can:69
return "" -- ./compiler/lua54.can:70
end -- ./compiler/lua54.can:70
local function peek(name) -- ./compiler/lua54.can:73
return states[name][# states[name]] -- ./compiler/lua54.can:74
end -- ./compiler/lua54.can:74
local function var(name) -- ./compiler/lua54.can:79
return options["variablePrefix"] .. name -- ./compiler/lua54.can:80
end -- ./compiler/lua54.can:80
local function tmp() -- ./compiler/lua54.can:84
local scope = peek("scope") -- ./compiler/lua54.can:85
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.can:86
table["insert"](scope, var) -- ./compiler/lua54.can:87
return var -- ./compiler/lua54.can:88
end -- ./compiler/lua54.can:88
local nomacro = { -- ./compiler/lua54.can:92
["variables"] = {}, -- ./compiler/lua54.can:92
["functions"] = {} -- ./compiler/lua54.can:92
} -- ./compiler/lua54.can:92
local required = {} -- ./compiler/lua54.can:95
local requireStr = "" -- ./compiler/lua54.can:96
local function addRequire(mod, name, field) -- ./compiler/lua54.can:98
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.can:99
if not required[req] then -- ./compiler/lua54.can:100
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.can:101
required[req] = true -- ./compiler/lua54.can:102
end -- ./compiler/lua54.can:102
end -- ./compiler/lua54.can:102
local loop = { -- ./compiler/lua54.can:107
"While", -- ./compiler/lua54.can:107
"Repeat", -- ./compiler/lua54.can:107
"Fornum", -- ./compiler/lua54.can:107
"Forin", -- ./compiler/lua54.can:107
"WhileExpr", -- ./compiler/lua54.can:107
"RepeatExpr", -- ./compiler/lua54.can:107
"FornumExpr", -- ./compiler/lua54.can:107
"ForinExpr" -- ./compiler/lua54.can:107
} -- ./compiler/lua54.can:107
local func = { -- ./compiler/lua54.can:108
"Function", -- ./compiler/lua54.can:108
"TableCompr", -- ./compiler/lua54.can:108
"DoExpr", -- ./compiler/lua54.can:108
"WhileExpr", -- ./compiler/lua54.can:108
"RepeatExpr", -- ./compiler/lua54.can:108
"IfExpr", -- ./compiler/lua54.can:108
"FornumExpr", -- ./compiler/lua54.can:108
"ForinExpr" -- ./compiler/lua54.can:108
} -- ./compiler/lua54.can:108
local function any(list, tags, nofollow) -- ./compiler/lua54.can:112
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.can:112
local tagsCheck = {} -- ./compiler/lua54.can:113
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:114
tagsCheck[tag] = true -- ./compiler/lua54.can:115
end -- ./compiler/lua54.can:115
local nofollowCheck = {} -- ./compiler/lua54.can:117
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.can:118
nofollowCheck[tag] = true -- ./compiler/lua54.can:119
end -- ./compiler/lua54.can:119
for _, node in ipairs(list) do -- ./compiler/lua54.can:121
if type(node) == "table" then -- ./compiler/lua54.can:122
if tagsCheck[node["tag"]] then -- ./compiler/lua54.can:123
return node -- ./compiler/lua54.can:124
end -- ./compiler/lua54.can:124
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.can:126
local r = any(node, tags, nofollow) -- ./compiler/lua54.can:127
if r then -- ./compiler/lua54.can:128
return r -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
return nil -- ./compiler/lua54.can:132
end -- ./compiler/lua54.can:132
local function search(list, tags, nofollow) -- ./compiler/lua54.can:137
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.can:137
local tagsCheck = {} -- ./compiler/lua54.can:138
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:139
tagsCheck[tag] = true -- ./compiler/lua54.can:140
end -- ./compiler/lua54.can:140
local nofollowCheck = {} -- ./compiler/lua54.can:142
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.can:143
nofollowCheck[tag] = true -- ./compiler/lua54.can:144
end -- ./compiler/lua54.can:144
local found = {} -- ./compiler/lua54.can:146
for _, node in ipairs(list) do -- ./compiler/lua54.can:147
if type(node) == "table" then -- ./compiler/lua54.can:148
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.can:149
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.can:150
table["insert"](found, n) -- ./compiler/lua54.can:151
end -- ./compiler/lua54.can:151
end -- ./compiler/lua54.can:151
if tagsCheck[node["tag"]] then -- ./compiler/lua54.can:154
table["insert"](found, node) -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
return found -- ./compiler/lua54.can:159
end -- ./compiler/lua54.can:159
local function all(list, tags) -- ./compiler/lua54.can:163
for _, node in ipairs(list) do -- ./compiler/lua54.can:164
local ok = false -- ./compiler/lua54.can:165
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:166
if node["tag"] == tag then -- ./compiler/lua54.can:167
ok = true -- ./compiler/lua54.can:168
break -- ./compiler/lua54.can:169
end -- ./compiler/lua54.can:169
end -- ./compiler/lua54.can:169
if not ok then -- ./compiler/lua54.can:172
return false -- ./compiler/lua54.can:173
end -- ./compiler/lua54.can:173
end -- ./compiler/lua54.can:173
return true -- ./compiler/lua54.can:176
end -- ./compiler/lua54.can:176
local tags -- ./compiler/lua54.can:180
local function lua(ast, forceTag, ...) -- ./compiler/lua54.can:182
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.can:183
lastInputPos = ast["pos"] -- ./compiler/lua54.can:184
end -- ./compiler/lua54.can:184
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.can:186
end -- ./compiler/lua54.can:186
local UNPACK = function(list, i, j) -- ./compiler/lua54.can:190
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.can:191
end -- ./compiler/lua54.can:191
local APPEND = function(t, toAppend) -- ./compiler/lua54.can:193
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.can:194
end -- ./compiler/lua54.can:194
local CONTINUE_START = function() -- ./compiler/lua54.can:196
return "do" .. indent() -- ./compiler/lua54.can:197
end -- ./compiler/lua54.can:197
local CONTINUE_STOP = function() -- ./compiler/lua54.can:199
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.can:200
end -- ./compiler/lua54.can:200
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.can:202
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.can:202
if noLocal == nil then noLocal = false end -- ./compiler/lua54.can:202
local vars = {} -- ./compiler/lua54.can:203
local values = {} -- ./compiler/lua54.can:204
for _, list in ipairs(destructured) do -- ./compiler/lua54.can:205
for _, v in ipairs(list) do -- ./compiler/lua54.can:206
local var, val -- ./compiler/lua54.can:207
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.can:208
var = v -- ./compiler/lua54.can:209
val = { -- ./compiler/lua54.can:210
["tag"] = "Index", -- ./compiler/lua54.can:210
{ -- ./compiler/lua54.can:210
["tag"] = "Id", -- ./compiler/lua54.can:210
list["id"] -- ./compiler/lua54.can:210
}, -- ./compiler/lua54.can:210
{ -- ./compiler/lua54.can:210
["tag"] = "String", -- ./compiler/lua54.can:210
v[1] -- ./compiler/lua54.can:210
} -- ./compiler/lua54.can:210
} -- ./compiler/lua54.can:210
elseif v["tag"] == "Pair" then -- ./compiler/lua54.can:211
var = v[2] -- ./compiler/lua54.can:212
val = { -- ./compiler/lua54.can:213
["tag"] = "Index", -- ./compiler/lua54.can:213
{ -- ./compiler/lua54.can:213
["tag"] = "Id", -- ./compiler/lua54.can:213
list["id"] -- ./compiler/lua54.can:213
}, -- ./compiler/lua54.can:213
v[1] -- ./compiler/lua54.can:213
} -- ./compiler/lua54.can:213
else -- ./compiler/lua54.can:213
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.can:215
end -- ./compiler/lua54.can:215
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.can:217
val = { -- ./compiler/lua54.can:218
["tag"] = "Op", -- ./compiler/lua54.can:218
destructured["rightOp"], -- ./compiler/lua54.can:218
var, -- ./compiler/lua54.can:218
{ -- ./compiler/lua54.can:218
["tag"] = "Op", -- ./compiler/lua54.can:218
destructured["leftOp"], -- ./compiler/lua54.can:218
val, -- ./compiler/lua54.can:218
var -- ./compiler/lua54.can:218
} -- ./compiler/lua54.can:218
} -- ./compiler/lua54.can:218
elseif destructured["rightOp"] then -- ./compiler/lua54.can:219
val = { -- ./compiler/lua54.can:220
["tag"] = "Op", -- ./compiler/lua54.can:220
destructured["rightOp"], -- ./compiler/lua54.can:220
var, -- ./compiler/lua54.can:220
val -- ./compiler/lua54.can:220
} -- ./compiler/lua54.can:220
elseif destructured["leftOp"] then -- ./compiler/lua54.can:221
val = { -- ./compiler/lua54.can:222
["tag"] = "Op", -- ./compiler/lua54.can:222
destructured["leftOp"], -- ./compiler/lua54.can:222
val, -- ./compiler/lua54.can:222
var -- ./compiler/lua54.can:222
} -- ./compiler/lua54.can:222
end -- ./compiler/lua54.can:222
table["insert"](vars, lua(var)) -- ./compiler/lua54.can:224
table["insert"](values, lua(val)) -- ./compiler/lua54.can:225
end -- ./compiler/lua54.can:225
end -- ./compiler/lua54.can:225
if # vars > 0 then -- ./compiler/lua54.can:228
local decl = noLocal and "" or "local " -- ./compiler/lua54.can:229
if newlineAfter then -- ./compiler/lua54.can:230
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.can:231
else -- ./compiler/lua54.can:231
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.can:233
end -- ./compiler/lua54.can:233
else -- ./compiler/lua54.can:233
return "" -- ./compiler/lua54.can:236
end -- ./compiler/lua54.can:236
end -- ./compiler/lua54.can:236
tags = setmetatable({ -- ./compiler/lua54.can:241
["Block"] = function(t) -- ./compiler/lua54.can:243
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.can:244
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.can:245
hasPush["tag"] = "Return" -- ./compiler/lua54.can:246
hasPush = false -- ./compiler/lua54.can:247
end -- ./compiler/lua54.can:247
local r = push("scope", {}) -- ./compiler/lua54.can:249
if hasPush then -- ./compiler/lua54.can:250
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:251
end -- ./compiler/lua54.can:251
for i = 1, # t - 1, 1 do -- ./compiler/lua54.can:253
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.can:254
end -- ./compiler/lua54.can:254
if t[# t] then -- ./compiler/lua54.can:256
r = r .. (lua(t[# t])) -- ./compiler/lua54.can:257
end -- ./compiler/lua54.can:257
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.can:259
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.can:260
end -- ./compiler/lua54.can:260
return r .. pop("scope") -- ./compiler/lua54.can:262
end, -- ./compiler/lua54.can:262
["Do"] = function(t) -- ./compiler/lua54.can:268
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.can:269
end, -- ./compiler/lua54.can:269
["Set"] = function(t) -- ./compiler/lua54.can:272
local expr = t[# t] -- ./compiler/lua54.can:274
local vars, values = {}, {} -- ./compiler/lua54.can:275
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.can:276
for i, n in ipairs(t[1]) do -- ./compiler/lua54.can:277
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.can:278
table["insert"](destructuringVars, n) -- ./compiler/lua54.can:279
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.can:280
else -- ./compiler/lua54.can:280
table["insert"](vars, n) -- ./compiler/lua54.can:282
table["insert"](values, expr[i]) -- ./compiler/lua54.can:283
end -- ./compiler/lua54.can:283
end -- ./compiler/lua54.can:283
if # t == 2 or # t == 3 then -- ./compiler/lua54.can:287
local r = "" -- ./compiler/lua54.can:288
if # vars > 0 then -- ./compiler/lua54.can:289
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.can:290
end -- ./compiler/lua54.can:290
if # destructuringVars > 0 then -- ./compiler/lua54.can:292
local destructured = {} -- ./compiler/lua54.can:293
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:294
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:295
end -- ./compiler/lua54.can:295
return r -- ./compiler/lua54.can:297
elseif # t == 4 then -- ./compiler/lua54.can:298
if t[3] == "=" then -- ./compiler/lua54.can:299
local r = "" -- ./compiler/lua54.can:300
if # vars > 0 then -- ./compiler/lua54.can:301
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:302
t[2], -- ./compiler/lua54.can:302
vars[1], -- ./compiler/lua54.can:302
{ -- ./compiler/lua54.can:302
["tag"] = "Paren", -- ./compiler/lua54.can:302
values[1] -- ./compiler/lua54.can:302
} -- ./compiler/lua54.can:302
}, "Op")) -- ./compiler/lua54.can:302
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.can:303
r = r .. (", " .. lua({ -- ./compiler/lua54.can:304
t[2], -- ./compiler/lua54.can:304
vars[i], -- ./compiler/lua54.can:304
{ -- ./compiler/lua54.can:304
["tag"] = "Paren", -- ./compiler/lua54.can:304
values[i] -- ./compiler/lua54.can:304
} -- ./compiler/lua54.can:304
}, "Op")) -- ./compiler/lua54.can:304
end -- ./compiler/lua54.can:304
end -- ./compiler/lua54.can:304
if # destructuringVars > 0 then -- ./compiler/lua54.can:307
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.can:308
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:309
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:310
end -- ./compiler/lua54.can:310
return r -- ./compiler/lua54.can:312
else -- ./compiler/lua54.can:312
local r = "" -- ./compiler/lua54.can:314
if # vars > 0 then -- ./compiler/lua54.can:315
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:316
t[3], -- ./compiler/lua54.can:316
{ -- ./compiler/lua54.can:316
["tag"] = "Paren", -- ./compiler/lua54.can:316
values[1] -- ./compiler/lua54.can:316
}, -- ./compiler/lua54.can:316
vars[1] -- ./compiler/lua54.can:316
}, "Op")) -- ./compiler/lua54.can:316
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.can:317
r = r .. (", " .. lua({ -- ./compiler/lua54.can:318
t[3], -- ./compiler/lua54.can:318
{ -- ./compiler/lua54.can:318
["tag"] = "Paren", -- ./compiler/lua54.can:318
values[i] -- ./compiler/lua54.can:318
}, -- ./compiler/lua54.can:318
vars[i] -- ./compiler/lua54.can:318
}, "Op")) -- ./compiler/lua54.can:318
end -- ./compiler/lua54.can:318
end -- ./compiler/lua54.can:318
if # destructuringVars > 0 then -- ./compiler/lua54.can:321
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.can:322
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:323
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:324
end -- ./compiler/lua54.can:324
return r -- ./compiler/lua54.can:326
end -- ./compiler/lua54.can:326
else -- ./compiler/lua54.can:326
local r = "" -- ./compiler/lua54.can:329
if # vars > 0 then -- ./compiler/lua54.can:330
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:331
t[2], -- ./compiler/lua54.can:331
vars[1], -- ./compiler/lua54.can:331
{ -- ./compiler/lua54.can:331
["tag"] = "Op", -- ./compiler/lua54.can:331
t[4], -- ./compiler/lua54.can:331
{ -- ./compiler/lua54.can:331
["tag"] = "Paren", -- ./compiler/lua54.can:331
values[1] -- ./compiler/lua54.can:331
}, -- ./compiler/lua54.can:331
vars[1] -- ./compiler/lua54.can:331
} -- ./compiler/lua54.can:331
}, "Op")) -- ./compiler/lua54.can:331
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.can:332
r = r .. (", " .. lua({ -- ./compiler/lua54.can:333
t[2], -- ./compiler/lua54.can:333
vars[i], -- ./compiler/lua54.can:333
{ -- ./compiler/lua54.can:333
["tag"] = "Op", -- ./compiler/lua54.can:333
t[4], -- ./compiler/lua54.can:333
{ -- ./compiler/lua54.can:333
["tag"] = "Paren", -- ./compiler/lua54.can:333
values[i] -- ./compiler/lua54.can:333
}, -- ./compiler/lua54.can:333
vars[i] -- ./compiler/lua54.can:333
} -- ./compiler/lua54.can:333
}, "Op")) -- ./compiler/lua54.can:333
end -- ./compiler/lua54.can:333
end -- ./compiler/lua54.can:333
if # destructuringVars > 0 then -- ./compiler/lua54.can:336
local destructured = { -- ./compiler/lua54.can:337
["rightOp"] = t[2], -- ./compiler/lua54.can:337
["leftOp"] = t[4] -- ./compiler/lua54.can:337
} -- ./compiler/lua54.can:337
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:338
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:339
end -- ./compiler/lua54.can:339
return r -- ./compiler/lua54.can:341
end -- ./compiler/lua54.can:341
end, -- ./compiler/lua54.can:341
["While"] = function(t) -- ./compiler/lua54.can:345
local r = "" -- ./compiler/lua54.can:346
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.can:347
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.can:348
if # lets > 0 then -- ./compiler/lua54.can:349
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:350
for _, l in ipairs(lets) do -- ./compiler/lua54.can:351
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:352
end -- ./compiler/lua54.can:352
end -- ./compiler/lua54.can:352
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.can:355
if # lets > 0 then -- ./compiler/lua54.can:356
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:357
end -- ./compiler/lua54.can:357
if hasContinue then -- ./compiler/lua54.can:359
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:360
end -- ./compiler/lua54.can:360
r = r .. (lua(t[2])) -- ./compiler/lua54.can:362
if hasContinue then -- ./compiler/lua54.can:363
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:364
end -- ./compiler/lua54.can:364
r = r .. (unindent() .. "end") -- ./compiler/lua54.can:366
if # lets > 0 then -- ./compiler/lua54.can:367
for _, l in ipairs(lets) do -- ./compiler/lua54.can:368
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.can:369
end -- ./compiler/lua54.can:369
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.can:371
end -- ./compiler/lua54.can:371
return r -- ./compiler/lua54.can:373
end, -- ./compiler/lua54.can:373
["Repeat"] = function(t) -- ./compiler/lua54.can:376
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.can:377
local r = "repeat" .. indent() -- ./compiler/lua54.can:378
if hasContinue then -- ./compiler/lua54.can:379
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:380
end -- ./compiler/lua54.can:380
r = r .. (lua(t[1])) -- ./compiler/lua54.can:382
if hasContinue then -- ./compiler/lua54.can:383
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:384
end -- ./compiler/lua54.can:384
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.can:386
return r -- ./compiler/lua54.can:387
end, -- ./compiler/lua54.can:387
["If"] = function(t) -- ./compiler/lua54.can:390
local r = "" -- ./compiler/lua54.can:391
local toClose = 0 -- ./compiler/lua54.can:392
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.can:393
if # lets > 0 then -- ./compiler/lua54.can:394
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:395
toClose = toClose + (1) -- ./compiler/lua54.can:396
for _, l in ipairs(lets) do -- ./compiler/lua54.can:397
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:398
end -- ./compiler/lua54.can:398
end -- ./compiler/lua54.can:398
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.can:401
for i = 3, # t - 1, 2 do -- ./compiler/lua54.can:402
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.can:403
if # lets > 0 then -- ./compiler/lua54.can:404
r = r .. ("else" .. indent()) -- ./compiler/lua54.can:405
toClose = toClose + (1) -- ./compiler/lua54.can:406
for _, l in ipairs(lets) do -- ./compiler/lua54.can:407
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:408
end -- ./compiler/lua54.can:408
else -- ./compiler/lua54.can:408
r = r .. ("else") -- ./compiler/lua54.can:411
end -- ./compiler/lua54.can:411
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.can:413
end -- ./compiler/lua54.can:413
if # t % 2 == 1 then -- ./compiler/lua54.can:415
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.can:416
end -- ./compiler/lua54.can:416
r = r .. ("end") -- ./compiler/lua54.can:418
for i = 1, toClose do -- ./compiler/lua54.can:419
r = r .. (unindent() .. "end") -- ./compiler/lua54.can:420
end -- ./compiler/lua54.can:420
return r -- ./compiler/lua54.can:422
end, -- ./compiler/lua54.can:422
["Fornum"] = function(t) -- ./compiler/lua54.can:425
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.can:426
if # t == 5 then -- ./compiler/lua54.can:427
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.can:428
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.can:429
if hasContinue then -- ./compiler/lua54.can:430
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:431
end -- ./compiler/lua54.can:431
r = r .. (lua(t[5])) -- ./compiler/lua54.can:433
if hasContinue then -- ./compiler/lua54.can:434
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:435
end -- ./compiler/lua54.can:435
return r .. unindent() .. "end" -- ./compiler/lua54.can:437
else -- ./compiler/lua54.can:437
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.can:439
r = r .. (" do" .. indent()) -- ./compiler/lua54.can:440
if hasContinue then -- ./compiler/lua54.can:441
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:442
end -- ./compiler/lua54.can:442
r = r .. (lua(t[4])) -- ./compiler/lua54.can:444
if hasContinue then -- ./compiler/lua54.can:445
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:446
end -- ./compiler/lua54.can:446
return r .. unindent() .. "end" -- ./compiler/lua54.can:448
end -- ./compiler/lua54.can:448
end, -- ./compiler/lua54.can:448
["Forin"] = function(t) -- ./compiler/lua54.can:452
local destructured = {} -- ./compiler/lua54.can:453
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.can:454
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.can:455
if hasContinue then -- ./compiler/lua54.can:456
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:457
end -- ./compiler/lua54.can:457
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.can:459
if hasContinue then -- ./compiler/lua54.can:460
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:461
end -- ./compiler/lua54.can:461
return r .. unindent() .. "end" -- ./compiler/lua54.can:463
end, -- ./compiler/lua54.can:463
["Local"] = function(t) -- ./compiler/lua54.can:466
local destructured = {} -- ./compiler/lua54.can:467
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.can:468
if t[2][1] then -- ./compiler/lua54.can:469
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:470
end -- ./compiler/lua54.can:470
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.can:472
end, -- ./compiler/lua54.can:472
["Let"] = function(t) -- ./compiler/lua54.can:475
local destructured = {} -- ./compiler/lua54.can:476
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.can:477
local r = "local " .. nameList -- ./compiler/lua54.can:478
if t[2][1] then -- ./compiler/lua54.can:479
if all(t[2], { -- ./compiler/lua54.can:480
"Nil", -- ./compiler/lua54.can:480
"Dots", -- ./compiler/lua54.can:480
"Boolean", -- ./compiler/lua54.can:480
"Number", -- ./compiler/lua54.can:480
"String" -- ./compiler/lua54.can:480
}) then -- ./compiler/lua54.can:480
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:481
else -- ./compiler/lua54.can:481
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:483
end -- ./compiler/lua54.can:483
end -- ./compiler/lua54.can:483
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.can:486
end, -- ./compiler/lua54.can:486
["Localrec"] = function(t) -- ./compiler/lua54.can:489
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.can:490
end, -- ./compiler/lua54.can:490
["Goto"] = function(t) -- ./compiler/lua54.can:493
return "goto " .. lua(t, "Id") -- ./compiler/lua54.can:494
end, -- ./compiler/lua54.can:494
["Label"] = function(t) -- ./compiler/lua54.can:497
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.can:498
end, -- ./compiler/lua54.can:498
["Return"] = function(t) -- ./compiler/lua54.can:501
local push = peek("push") -- ./compiler/lua54.can:502
if push then -- ./compiler/lua54.can:503
local r = "" -- ./compiler/lua54.can:504
for _, val in ipairs(t) do -- ./compiler/lua54.can:505
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.can:506
end -- ./compiler/lua54.can:506
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.can:508
else -- ./compiler/lua54.can:508
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.can:510
end -- ./compiler/lua54.can:510
end, -- ./compiler/lua54.can:510
["Push"] = function(t) -- ./compiler/lua54.can:514
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.can:515
r = "" -- ./compiler/lua54.can:516
for i = 1, # t - 1, 1 do -- ./compiler/lua54.can:517
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.can:518
end -- ./compiler/lua54.can:518
if t[# t] then -- ./compiler/lua54.can:520
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.can:521
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.can:522
else -- ./compiler/lua54.can:522
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.can:524
end -- ./compiler/lua54.can:524
end -- ./compiler/lua54.can:524
return r -- ./compiler/lua54.can:527
end, -- ./compiler/lua54.can:527
["Break"] = function() -- ./compiler/lua54.can:530
return "break" -- ./compiler/lua54.can:531
end, -- ./compiler/lua54.can:531
["Continue"] = function() -- ./compiler/lua54.can:534
return "goto " .. var("continue") -- ./compiler/lua54.can:535
end, -- ./compiler/lua54.can:535
["Nil"] = function() -- ./compiler/lua54.can:542
return "nil" -- ./compiler/lua54.can:543
end, -- ./compiler/lua54.can:543
["Dots"] = function() -- ./compiler/lua54.can:546
local macroargs = peek("macroargs") -- ./compiler/lua54.can:547
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.can:548
nomacro["variables"]["..."] = true -- ./compiler/lua54.can:549
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.can:550
nomacro["variables"]["..."] = nil -- ./compiler/lua54.can:551
return r -- ./compiler/lua54.can:552
else -- ./compiler/lua54.can:552
return "..." -- ./compiler/lua54.can:554
end -- ./compiler/lua54.can:554
end, -- ./compiler/lua54.can:554
["Boolean"] = function(t) -- ./compiler/lua54.can:558
return tostring(t[1]) -- ./compiler/lua54.can:559
end, -- ./compiler/lua54.can:559
["Number"] = function(t) -- ./compiler/lua54.can:562
return tostring(t[1]) -- ./compiler/lua54.can:563
end, -- ./compiler/lua54.can:563
["String"] = function(t) -- ./compiler/lua54.can:566
return ("%q"):format(t[1]) -- ./compiler/lua54.can:567
end, -- ./compiler/lua54.can:567
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.can:570
local r = "(" -- ./compiler/lua54.can:571
local decl = {} -- ./compiler/lua54.can:572
if t[1][1] then -- ./compiler/lua54.can:573
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.can:574
local id = lua(t[1][1][1]) -- ./compiler/lua54.can:575
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:576
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.can:577
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:578
r = r .. (id) -- ./compiler/lua54.can:579
else -- ./compiler/lua54.can:579
r = r .. (lua(t[1][1])) -- ./compiler/lua54.can:581
end -- ./compiler/lua54.can:581
for i = 2, # t[1], 1 do -- ./compiler/lua54.can:583
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.can:584
local id = lua(t[1][i][1]) -- ./compiler/lua54.can:585
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:586
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.can:587
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:588
r = r .. (", " .. id) -- ./compiler/lua54.can:589
else -- ./compiler/lua54.can:589
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
r = r .. (")" .. indent()) -- ./compiler/lua54.can:595
for _, d in ipairs(decl) do -- ./compiler/lua54.can:596
r = r .. (d .. newline()) -- ./compiler/lua54.can:597
end -- ./compiler/lua54.can:597
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.can:599
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.can:600
end -- ./compiler/lua54.can:600
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.can:602
if hasPush then -- ./compiler/lua54.can:603
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:604
else -- ./compiler/lua54.can:604
push("push", false) -- ./compiler/lua54.can:606
end -- ./compiler/lua54.can:606
r = r .. (lua(t[2])) -- ./compiler/lua54.can:608
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.can:609
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.can:610
end -- ./compiler/lua54.can:610
pop("push") -- ./compiler/lua54.can:612
return r .. unindent() .. "end" -- ./compiler/lua54.can:613
end, -- ./compiler/lua54.can:613
["Function"] = function(t) -- ./compiler/lua54.can:615
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.can:616
end, -- ./compiler/lua54.can:616
["Pair"] = function(t) -- ./compiler/lua54.can:619
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.can:620
end, -- ./compiler/lua54.can:620
["Table"] = function(t) -- ./compiler/lua54.can:622
if # t == 0 then -- ./compiler/lua54.can:623
return "{}" -- ./compiler/lua54.can:624
elseif # t == 1 then -- ./compiler/lua54.can:625
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.can:626
else -- ./compiler/lua54.can:626
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.can:628
end -- ./compiler/lua54.can:628
end, -- ./compiler/lua54.can:628
["TableCompr"] = function(t) -- ./compiler/lua54.can:632
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.can:633
end, -- ./compiler/lua54.can:633
["Op"] = function(t) -- ./compiler/lua54.can:636
local r -- ./compiler/lua54.can:637
if # t == 2 then -- ./compiler/lua54.can:638
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.can:639
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.can:640
else -- ./compiler/lua54.can:640
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.can:642
end -- ./compiler/lua54.can:642
else -- ./compiler/lua54.can:642
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.can:645
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.can:646
else -- ./compiler/lua54.can:646
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.can:648
end -- ./compiler/lua54.can:648
end -- ./compiler/lua54.can:648
return r -- ./compiler/lua54.can:651
end, -- ./compiler/lua54.can:651
["Paren"] = function(t) -- ./compiler/lua54.can:654
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.can:655
end, -- ./compiler/lua54.can:655
["MethodStub"] = function(t) -- ./compiler/lua54.can:658
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.can:664
end, -- ./compiler/lua54.can:664
["SafeMethodStub"] = function(t) -- ./compiler/lua54.can:667
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.can:674
end, -- ./compiler/lua54.can:674
["LetExpr"] = function(t) -- ./compiler/lua54.can:681
return lua(t[1][1]) -- ./compiler/lua54.can:682
end, -- ./compiler/lua54.can:682
["_statexpr"] = function(t, stat) -- ./compiler/lua54.can:686
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.can:687
local r = "(function()" .. indent() -- ./compiler/lua54.can:688
if hasPush then -- ./compiler/lua54.can:689
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:690
else -- ./compiler/lua54.can:690
push("push", false) -- ./compiler/lua54.can:692
end -- ./compiler/lua54.can:692
r = r .. (lua(t, stat)) -- ./compiler/lua54.can:694
if hasPush then -- ./compiler/lua54.can:695
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.can:696
end -- ./compiler/lua54.can:696
pop("push") -- ./compiler/lua54.can:698
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.can:699
return r -- ./compiler/lua54.can:700
end, -- ./compiler/lua54.can:700
["DoExpr"] = function(t) -- ./compiler/lua54.can:703
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.can:704
t[# t]["tag"] = "Return" -- ./compiler/lua54.can:705
end -- ./compiler/lua54.can:705
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.can:707
end, -- ./compiler/lua54.can:707
["WhileExpr"] = function(t) -- ./compiler/lua54.can:710
return lua(t, "_statexpr", "While") -- ./compiler/lua54.can:711
end, -- ./compiler/lua54.can:711
["RepeatExpr"] = function(t) -- ./compiler/lua54.can:714
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.can:715
end, -- ./compiler/lua54.can:715
["IfExpr"] = function(t) -- ./compiler/lua54.can:718
for i = 2, # t do -- ./compiler/lua54.can:719
local block = t[i] -- ./compiler/lua54.can:720
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.can:721
block[# block]["tag"] = "Return" -- ./compiler/lua54.can:722
end -- ./compiler/lua54.can:722
end -- ./compiler/lua54.can:722
return lua(t, "_statexpr", "If") -- ./compiler/lua54.can:725
end, -- ./compiler/lua54.can:725
["FornumExpr"] = function(t) -- ./compiler/lua54.can:728
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.can:729
end, -- ./compiler/lua54.can:729
["ForinExpr"] = function(t) -- ./compiler/lua54.can:732
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.can:733
end, -- ./compiler/lua54.can:733
["Call"] = function(t) -- ./compiler/lua54.can:739
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.can:740
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:741
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.can:742
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.can:743
local replacement = macro["replacement"] -- ./compiler/lua54.can:744
local r -- ./compiler/lua54.can:745
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.can:746
if type(replacement) == "function" then -- ./compiler/lua54.can:747
local args = {} -- ./compiler/lua54.can:748
for i = 2, # t do -- ./compiler/lua54.can:749
table["insert"](args, lua(t[i])) -- ./compiler/lua54.can:750
end -- ./compiler/lua54.can:750
r = replacement(unpack(args)) -- ./compiler/lua54.can:752
else -- ./compiler/lua54.can:752
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.can:754
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.can:755
if arg["tag"] == "Dots" then -- ./compiler/lua54.can:756
macroargs["..."] = (function() -- ./compiler/lua54.can:757
local self = {} -- ./compiler/lua54.can:757
for j = i + 1, # t do -- ./compiler/lua54.can:757
self[#self+1] = t[j] -- ./compiler/lua54.can:757
end -- ./compiler/lua54.can:757
return self -- ./compiler/lua54.can:757
end)() -- ./compiler/lua54.can:757
elseif arg["tag"] == "Id" then -- ./compiler/lua54.can:758
if t[i + 1] == nil then -- ./compiler/lua54.can:759
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.can:760
end -- ./compiler/lua54.can:760
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.can:762
else -- ./compiler/lua54.can:762
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.can:764
end -- ./compiler/lua54.can:764
end -- ./compiler/lua54.can:764
push("macroargs", macroargs) -- ./compiler/lua54.can:767
r = lua(replacement) -- ./compiler/lua54.can:768
pop("macroargs") -- ./compiler/lua54.can:769
end -- ./compiler/lua54.can:769
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.can:771
return r -- ./compiler/lua54.can:772
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.can:773
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.can:774
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:775
else -- ./compiler/lua54.can:775
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:777
end -- ./compiler/lua54.can:777
else -- ./compiler/lua54.can:777
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:780
end -- ./compiler/lua54.can:780
end, -- ./compiler/lua54.can:780
["SafeCall"] = function(t) -- ./compiler/lua54.can:784
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.can:785
return lua(t, "SafeIndex") -- ./compiler/lua54.can:786
else -- ./compiler/lua54.can:786
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.can:788
end -- ./compiler/lua54.can:788
end, -- ./compiler/lua54.can:788
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.can:793
if start == nil then start = 1 end -- ./compiler/lua54.can:793
local r -- ./compiler/lua54.can:794
if t[start] then -- ./compiler/lua54.can:795
r = lua(t[start]) -- ./compiler/lua54.can:796
for i = start + 1, # t, 1 do -- ./compiler/lua54.can:797
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.can:798
end -- ./compiler/lua54.can:798
else -- ./compiler/lua54.can:798
r = "" -- ./compiler/lua54.can:801
end -- ./compiler/lua54.can:801
return r -- ./compiler/lua54.can:803
end, -- ./compiler/lua54.can:803
["Id"] = function(t) -- ./compiler/lua54.can:806
local r = t[1] -- ./compiler/lua54.can:807
local macroargs = peek("macroargs") -- ./compiler/lua54.can:808
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.can:809
nomacro["variables"][t[1]] = true -- ./compiler/lua54.can:810
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.can:811
r = lua(macroargs[t[1]]) -- ./compiler/lua54.can:812
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.can:813
local macro = macros["variables"][t[1]] -- ./compiler/lua54.can:814
if type(macro) == "function" then -- ./compiler/lua54.can:815
r = macro() -- ./compiler/lua54.can:816
else -- ./compiler/lua54.can:816
r = lua(macro) -- ./compiler/lua54.can:818
end -- ./compiler/lua54.can:818
end -- ./compiler/lua54.can:818
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.can:821
end -- ./compiler/lua54.can:821
return r -- ./compiler/lua54.can:823
end, -- ./compiler/lua54.can:823
["AttributeId"] = function(t) -- ./compiler/lua54.can:826
if t[2] then -- ./compiler/lua54.can:827
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.can:828
else -- ./compiler/lua54.can:828
return t[1] -- ./compiler/lua54.can:830
end -- ./compiler/lua54.can:830
end, -- ./compiler/lua54.can:830
["DestructuringId"] = function(t) -- ./compiler/lua54.can:834
if t["id"] then -- ./compiler/lua54.can:835
return t["id"] -- ./compiler/lua54.can:836
else -- ./compiler/lua54.can:836
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.can:838
local vars = { ["id"] = tmp() } -- ./compiler/lua54.can:839
for j = 1, # t, 1 do -- ./compiler/lua54.can:840
table["insert"](vars, t[j]) -- ./compiler/lua54.can:841
end -- ./compiler/lua54.can:841
table["insert"](d, vars) -- ./compiler/lua54.can:843
t["id"] = vars["id"] -- ./compiler/lua54.can:844
return vars["id"] -- ./compiler/lua54.can:845
end -- ./compiler/lua54.can:845
end, -- ./compiler/lua54.can:845
["Index"] = function(t) -- ./compiler/lua54.can:849
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.can:850
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.can:851
else -- ./compiler/lua54.can:851
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.can:853
end -- ./compiler/lua54.can:853
end, -- ./compiler/lua54.can:853
["SafeIndex"] = function(t) -- ./compiler/lua54.can:857
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.can:858
local l = {} -- ./compiler/lua54.can:859
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.can:860
table["insert"](l, 1, t) -- ./compiler/lua54.can:861
t = t[1] -- ./compiler/lua54.can:862
end -- ./compiler/lua54.can:862
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.can:864
for _, e in ipairs(l) do -- ./compiler/lua54.can:865
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.can:866
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.can:867
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.can:868
else -- ./compiler/lua54.can:868
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.can:870
end -- ./compiler/lua54.can:870
end -- ./compiler/lua54.can:870
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.can:873
return r -- ./compiler/lua54.can:874
else -- ./compiler/lua54.can:874
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.can:876
end -- ./compiler/lua54.can:876
end, -- ./compiler/lua54.can:876
["_opid"] = { -- ./compiler/lua54.can:881
["add"] = "+", -- ./compiler/lua54.can:882
["sub"] = "-", -- ./compiler/lua54.can:882
["mul"] = "*", -- ./compiler/lua54.can:882
["div"] = "/", -- ./compiler/lua54.can:882
["idiv"] = "//", -- ./compiler/lua54.can:883
["mod"] = "%", -- ./compiler/lua54.can:883
["pow"] = "^", -- ./compiler/lua54.can:883
["concat"] = "..", -- ./compiler/lua54.can:883
["band"] = "&", -- ./compiler/lua54.can:884
["bor"] = "|", -- ./compiler/lua54.can:884
["bxor"] = "~", -- ./compiler/lua54.can:884
["shl"] = "<<", -- ./compiler/lua54.can:884
["shr"] = ">>", -- ./compiler/lua54.can:884
["eq"] = "==", -- ./compiler/lua54.can:885
["ne"] = "~=", -- ./compiler/lua54.can:885
["lt"] = "<", -- ./compiler/lua54.can:885
["gt"] = ">", -- ./compiler/lua54.can:885
["le"] = "<=", -- ./compiler/lua54.can:885
["ge"] = ">=", -- ./compiler/lua54.can:885
["and"] = "and", -- ./compiler/lua54.can:886
["or"] = "or", -- ./compiler/lua54.can:886
["unm"] = "-", -- ./compiler/lua54.can:886
["len"] = "#", -- ./compiler/lua54.can:886
["bnot"] = "~", -- ./compiler/lua54.can:886
["not"] = "not" -- ./compiler/lua54.can:886
} -- ./compiler/lua54.can:886
}, { ["__index"] = function(self, key) -- ./compiler/lua54.can:889
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.can:890
end }) -- ./compiler/lua54.can:890
targetName = "Lua 5.3" -- ./compiler/lua53.can:1
tags["AttributeId"] = function(t) -- ./compiler/lua53.can:4
if t[2] then -- ./compiler/lua53.can:5
error("target " .. targetName .. " does not support variable attributes") -- ./compiler/lua53.can:6
else -- ./compiler/lua53.can:6
return t[1] -- ./compiler/lua53.can:8
end -- ./compiler/lua53.can:8
end -- ./compiler/lua53.can:8
targetName = "Lua 5.2" -- ./compiler/lua52.can:1
APPEND = function(t, toAppend) -- ./compiler/lua52.can:3
return "do" .. indent() .. "local " .. var("a") .. ", " .. var("p") .. " = { " .. toAppend .. " }, #" .. t .. "+1" .. newline() .. "for i=1, #" .. var("a") .. " do" .. indent() .. t .. "[" .. var("p") .. "] = " .. var("a") .. "[i]" .. newline() .. "" .. var("p") .. " = " .. var("p") .. " + 1" .. unindent() .. "end" .. unindent() .. "end" -- ./compiler/lua52.can:4
end -- ./compiler/lua52.can:4
tags["_opid"]["idiv"] = function(left, right) -- ./compiler/lua52.can:7
return "math.floor(" .. lua(left) .. " / " .. lua(right) .. ")" -- ./compiler/lua52.can:8
end -- ./compiler/lua52.can:8
tags["_opid"]["band"] = function(left, right) -- ./compiler/lua52.can:10
return "bit32.band(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:11
end -- ./compiler/lua52.can:11
tags["_opid"]["bor"] = function(left, right) -- ./compiler/lua52.can:13
return "bit32.bor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:14
end -- ./compiler/lua52.can:14
tags["_opid"]["bxor"] = function(left, right) -- ./compiler/lua52.can:16
return "bit32.bxor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:17
end -- ./compiler/lua52.can:17
tags["_opid"]["shl"] = function(left, right) -- ./compiler/lua52.can:19
return "bit32.lshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:20
end -- ./compiler/lua52.can:20
tags["_opid"]["shr"] = function(left, right) -- ./compiler/lua52.can:22
return "bit32.rshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:23
end -- ./compiler/lua52.can:23
tags["_opid"]["bnot"] = function(right) -- ./compiler/lua52.can:25
return "bit32.bnot(" .. lua(right) .. ")" -- ./compiler/lua52.can:26
end -- ./compiler/lua52.can:26
local code = lua(ast) .. newline() -- ./compiler/lua54.can:896
return requireStr .. code -- ./compiler/lua54.can:897
end -- ./compiler/lua54.can:897
end -- ./compiler/lua54.can:897
local lua54 = _() or lua54 -- ./compiler/lua54.can:902
return lua54 -- ./compiler/lua53.can:18
end -- ./compiler/lua53.can:18
local lua53 = _() or lua53 -- ./compiler/lua53.can:22
return lua53 -- ./compiler/lua52.can:35
end -- ./compiler/lua52.can:35
local lua52 = _() or lua52 -- ./compiler/lua52.can:39
package["loaded"]["compiler.lua52"] = lua52 or true -- ./compiler/lua52.can:40
local function _() -- ./compiler/lua52.can:43
local function _() -- ./compiler/lua52.can:45
local function _() -- ./compiler/lua52.can:47
local function _() -- ./compiler/lua52.can:49
local util = require("lepton.util") -- ./compiler/lua54.can:1
local targetName = "Lua 5.4" -- ./compiler/lua54.can:3
local unpack = unpack or table["unpack"] -- ./compiler/lua54.can:5
return function(code, ast, options, macros) -- ./compiler/lua54.can:7
if macros == nil then macros = { -- ./compiler/lua54.can:7
["functions"] = {}, -- ./compiler/lua54.can:7
["variables"] = {} -- ./compiler/lua54.can:7
} end -- ./compiler/lua54.can:7
local lastInputPos = 1 -- ./compiler/lua54.can:9
local prevLinePos = 1 -- ./compiler/lua54.can:10
local lastSource = options["chunkname"] or "nil" -- ./compiler/lua54.can:11
local lastLine = 1 -- ./compiler/lua54.can:12
local indentLevel = 0 -- ./compiler/lua54.can:15
local function newline() -- ./compiler/lua54.can:17
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.can:18
if options["mapLines"] then -- ./compiler/lua54.can:19
local sub = code:sub(lastInputPos) -- ./compiler/lua54.can:20
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.can:21
if source and line then -- ./compiler/lua54.can:23
lastSource = source -- ./compiler/lua54.can:24
lastLine = tonumber(line) -- ./compiler/lua54.can:25
else -- ./compiler/lua54.can:25
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.can:27
lastLine = lastLine + (1) -- ./compiler/lua54.can:28
end -- ./compiler/lua54.can:28
end -- ./compiler/lua54.can:28
prevLinePos = lastInputPos -- ./compiler/lua54.can:32
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.can:34
end -- ./compiler/lua54.can:34
return r -- ./compiler/lua54.can:36
end -- ./compiler/lua54.can:36
local function indent() -- ./compiler/lua54.can:39
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:40
return newline() -- ./compiler/lua54.can:41
end -- ./compiler/lua54.can:41
local function unindent() -- ./compiler/lua54.can:44
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:45
return newline() -- ./compiler/lua54.can:46
end -- ./compiler/lua54.can:46
local states = { -- ./compiler/lua54.can:51
["push"] = {}, -- ./compiler/lua54.can:52
["destructuring"] = {}, -- ./compiler/lua54.can:53
["scope"] = {}, -- ./compiler/lua54.can:54
["macroargs"] = {} -- ./compiler/lua54.can:55
} -- ./compiler/lua54.can:55
local function push(name, state) -- ./compiler/lua54.can:58
table["insert"](states[name], state) -- ./compiler/lua54.can:59
return "" -- ./compiler/lua54.can:60
end -- ./compiler/lua54.can:60
local function pop(name) -- ./compiler/lua54.can:63
table["remove"](states[name]) -- ./compiler/lua54.can:64
return "" -- ./compiler/lua54.can:65
end -- ./compiler/lua54.can:65
local function set(name, state) -- ./compiler/lua54.can:68
states[name][# states[name]] = state -- ./compiler/lua54.can:69
return "" -- ./compiler/lua54.can:70
end -- ./compiler/lua54.can:70
local function peek(name) -- ./compiler/lua54.can:73
return states[name][# states[name]] -- ./compiler/lua54.can:74
end -- ./compiler/lua54.can:74
local function var(name) -- ./compiler/lua54.can:79
return options["variablePrefix"] .. name -- ./compiler/lua54.can:80
end -- ./compiler/lua54.can:80
local function tmp() -- ./compiler/lua54.can:84
local scope = peek("scope") -- ./compiler/lua54.can:85
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.can:86
table["insert"](scope, var) -- ./compiler/lua54.can:87
return var -- ./compiler/lua54.can:88
end -- ./compiler/lua54.can:88
local nomacro = { -- ./compiler/lua54.can:92
["variables"] = {}, -- ./compiler/lua54.can:92
["functions"] = {} -- ./compiler/lua54.can:92
} -- ./compiler/lua54.can:92
local required = {} -- ./compiler/lua54.can:95
local requireStr = "" -- ./compiler/lua54.can:96
local function addRequire(mod, name, field) -- ./compiler/lua54.can:98
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.can:99
if not required[req] then -- ./compiler/lua54.can:100
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.can:101
required[req] = true -- ./compiler/lua54.can:102
end -- ./compiler/lua54.can:102
end -- ./compiler/lua54.can:102
local loop = { -- ./compiler/lua54.can:107
"While", -- ./compiler/lua54.can:107
"Repeat", -- ./compiler/lua54.can:107
"Fornum", -- ./compiler/lua54.can:107
"Forin", -- ./compiler/lua54.can:107
"WhileExpr", -- ./compiler/lua54.can:107
"RepeatExpr", -- ./compiler/lua54.can:107
"FornumExpr", -- ./compiler/lua54.can:107
"ForinExpr" -- ./compiler/lua54.can:107
} -- ./compiler/lua54.can:107
local func = { -- ./compiler/lua54.can:108
"Function", -- ./compiler/lua54.can:108
"TableCompr", -- ./compiler/lua54.can:108
"DoExpr", -- ./compiler/lua54.can:108
"WhileExpr", -- ./compiler/lua54.can:108
"RepeatExpr", -- ./compiler/lua54.can:108
"IfExpr", -- ./compiler/lua54.can:108
"FornumExpr", -- ./compiler/lua54.can:108
"ForinExpr" -- ./compiler/lua54.can:108
} -- ./compiler/lua54.can:108
local function any(list, tags, nofollow) -- ./compiler/lua54.can:112
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.can:112
local tagsCheck = {} -- ./compiler/lua54.can:113
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:114
tagsCheck[tag] = true -- ./compiler/lua54.can:115
end -- ./compiler/lua54.can:115
local nofollowCheck = {} -- ./compiler/lua54.can:117
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.can:118
nofollowCheck[tag] = true -- ./compiler/lua54.can:119
end -- ./compiler/lua54.can:119
for _, node in ipairs(list) do -- ./compiler/lua54.can:121
if type(node) == "table" then -- ./compiler/lua54.can:122
if tagsCheck[node["tag"]] then -- ./compiler/lua54.can:123
return node -- ./compiler/lua54.can:124
end -- ./compiler/lua54.can:124
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.can:126
local r = any(node, tags, nofollow) -- ./compiler/lua54.can:127
if r then -- ./compiler/lua54.can:128
return r -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
return nil -- ./compiler/lua54.can:132
end -- ./compiler/lua54.can:132
local function search(list, tags, nofollow) -- ./compiler/lua54.can:137
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.can:137
local tagsCheck = {} -- ./compiler/lua54.can:138
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:139
tagsCheck[tag] = true -- ./compiler/lua54.can:140
end -- ./compiler/lua54.can:140
local nofollowCheck = {} -- ./compiler/lua54.can:142
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.can:143
nofollowCheck[tag] = true -- ./compiler/lua54.can:144
end -- ./compiler/lua54.can:144
local found = {} -- ./compiler/lua54.can:146
for _, node in ipairs(list) do -- ./compiler/lua54.can:147
if type(node) == "table" then -- ./compiler/lua54.can:148
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.can:149
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.can:150
table["insert"](found, n) -- ./compiler/lua54.can:151
end -- ./compiler/lua54.can:151
end -- ./compiler/lua54.can:151
if tagsCheck[node["tag"]] then -- ./compiler/lua54.can:154
table["insert"](found, node) -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
return found -- ./compiler/lua54.can:159
end -- ./compiler/lua54.can:159
local function all(list, tags) -- ./compiler/lua54.can:163
for _, node in ipairs(list) do -- ./compiler/lua54.can:164
local ok = false -- ./compiler/lua54.can:165
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:166
if node["tag"] == tag then -- ./compiler/lua54.can:167
ok = true -- ./compiler/lua54.can:168
break -- ./compiler/lua54.can:169
end -- ./compiler/lua54.can:169
end -- ./compiler/lua54.can:169
if not ok then -- ./compiler/lua54.can:172
return false -- ./compiler/lua54.can:173
end -- ./compiler/lua54.can:173
end -- ./compiler/lua54.can:173
return true -- ./compiler/lua54.can:176
end -- ./compiler/lua54.can:176
local tags -- ./compiler/lua54.can:180
local function lua(ast, forceTag, ...) -- ./compiler/lua54.can:182
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.can:183
lastInputPos = ast["pos"] -- ./compiler/lua54.can:184
end -- ./compiler/lua54.can:184
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.can:186
end -- ./compiler/lua54.can:186
local UNPACK = function(list, i, j) -- ./compiler/lua54.can:190
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.can:191
end -- ./compiler/lua54.can:191
local APPEND = function(t, toAppend) -- ./compiler/lua54.can:193
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.can:194
end -- ./compiler/lua54.can:194
local CONTINUE_START = function() -- ./compiler/lua54.can:196
return "do" .. indent() -- ./compiler/lua54.can:197
end -- ./compiler/lua54.can:197
local CONTINUE_STOP = function() -- ./compiler/lua54.can:199
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.can:200
end -- ./compiler/lua54.can:200
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.can:202
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.can:202
if noLocal == nil then noLocal = false end -- ./compiler/lua54.can:202
local vars = {} -- ./compiler/lua54.can:203
local values = {} -- ./compiler/lua54.can:204
for _, list in ipairs(destructured) do -- ./compiler/lua54.can:205
for _, v in ipairs(list) do -- ./compiler/lua54.can:206
local var, val -- ./compiler/lua54.can:207
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.can:208
var = v -- ./compiler/lua54.can:209
val = { -- ./compiler/lua54.can:210
["tag"] = "Index", -- ./compiler/lua54.can:210
{ -- ./compiler/lua54.can:210
["tag"] = "Id", -- ./compiler/lua54.can:210
list["id"] -- ./compiler/lua54.can:210
}, -- ./compiler/lua54.can:210
{ -- ./compiler/lua54.can:210
["tag"] = "String", -- ./compiler/lua54.can:210
v[1] -- ./compiler/lua54.can:210
} -- ./compiler/lua54.can:210
} -- ./compiler/lua54.can:210
elseif v["tag"] == "Pair" then -- ./compiler/lua54.can:211
var = v[2] -- ./compiler/lua54.can:212
val = { -- ./compiler/lua54.can:213
["tag"] = "Index", -- ./compiler/lua54.can:213
{ -- ./compiler/lua54.can:213
["tag"] = "Id", -- ./compiler/lua54.can:213
list["id"] -- ./compiler/lua54.can:213
}, -- ./compiler/lua54.can:213
v[1] -- ./compiler/lua54.can:213
} -- ./compiler/lua54.can:213
else -- ./compiler/lua54.can:213
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.can:215
end -- ./compiler/lua54.can:215
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.can:217
val = { -- ./compiler/lua54.can:218
["tag"] = "Op", -- ./compiler/lua54.can:218
destructured["rightOp"], -- ./compiler/lua54.can:218
var, -- ./compiler/lua54.can:218
{ -- ./compiler/lua54.can:218
["tag"] = "Op", -- ./compiler/lua54.can:218
destructured["leftOp"], -- ./compiler/lua54.can:218
val, -- ./compiler/lua54.can:218
var -- ./compiler/lua54.can:218
} -- ./compiler/lua54.can:218
} -- ./compiler/lua54.can:218
elseif destructured["rightOp"] then -- ./compiler/lua54.can:219
val = { -- ./compiler/lua54.can:220
["tag"] = "Op", -- ./compiler/lua54.can:220
destructured["rightOp"], -- ./compiler/lua54.can:220
var, -- ./compiler/lua54.can:220
val -- ./compiler/lua54.can:220
} -- ./compiler/lua54.can:220
elseif destructured["leftOp"] then -- ./compiler/lua54.can:221
val = { -- ./compiler/lua54.can:222
["tag"] = "Op", -- ./compiler/lua54.can:222
destructured["leftOp"], -- ./compiler/lua54.can:222
val, -- ./compiler/lua54.can:222
var -- ./compiler/lua54.can:222
} -- ./compiler/lua54.can:222
end -- ./compiler/lua54.can:222
table["insert"](vars, lua(var)) -- ./compiler/lua54.can:224
table["insert"](values, lua(val)) -- ./compiler/lua54.can:225
end -- ./compiler/lua54.can:225
end -- ./compiler/lua54.can:225
if # vars > 0 then -- ./compiler/lua54.can:228
local decl = noLocal and "" or "local " -- ./compiler/lua54.can:229
if newlineAfter then -- ./compiler/lua54.can:230
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.can:231
else -- ./compiler/lua54.can:231
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.can:233
end -- ./compiler/lua54.can:233
else -- ./compiler/lua54.can:233
return "" -- ./compiler/lua54.can:236
end -- ./compiler/lua54.can:236
end -- ./compiler/lua54.can:236
tags = setmetatable({ -- ./compiler/lua54.can:241
["Block"] = function(t) -- ./compiler/lua54.can:243
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.can:244
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.can:245
hasPush["tag"] = "Return" -- ./compiler/lua54.can:246
hasPush = false -- ./compiler/lua54.can:247
end -- ./compiler/lua54.can:247
local r = push("scope", {}) -- ./compiler/lua54.can:249
if hasPush then -- ./compiler/lua54.can:250
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:251
end -- ./compiler/lua54.can:251
for i = 1, # t - 1, 1 do -- ./compiler/lua54.can:253
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.can:254
end -- ./compiler/lua54.can:254
if t[# t] then -- ./compiler/lua54.can:256
r = r .. (lua(t[# t])) -- ./compiler/lua54.can:257
end -- ./compiler/lua54.can:257
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.can:259
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.can:260
end -- ./compiler/lua54.can:260
return r .. pop("scope") -- ./compiler/lua54.can:262
end, -- ./compiler/lua54.can:262
["Do"] = function(t) -- ./compiler/lua54.can:268
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.can:269
end, -- ./compiler/lua54.can:269
["Set"] = function(t) -- ./compiler/lua54.can:272
local expr = t[# t] -- ./compiler/lua54.can:274
local vars, values = {}, {} -- ./compiler/lua54.can:275
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.can:276
for i, n in ipairs(t[1]) do -- ./compiler/lua54.can:277
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.can:278
table["insert"](destructuringVars, n) -- ./compiler/lua54.can:279
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.can:280
else -- ./compiler/lua54.can:280
table["insert"](vars, n) -- ./compiler/lua54.can:282
table["insert"](values, expr[i]) -- ./compiler/lua54.can:283
end -- ./compiler/lua54.can:283
end -- ./compiler/lua54.can:283
if # t == 2 or # t == 3 then -- ./compiler/lua54.can:287
local r = "" -- ./compiler/lua54.can:288
if # vars > 0 then -- ./compiler/lua54.can:289
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.can:290
end -- ./compiler/lua54.can:290
if # destructuringVars > 0 then -- ./compiler/lua54.can:292
local destructured = {} -- ./compiler/lua54.can:293
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:294
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:295
end -- ./compiler/lua54.can:295
return r -- ./compiler/lua54.can:297
elseif # t == 4 then -- ./compiler/lua54.can:298
if t[3] == "=" then -- ./compiler/lua54.can:299
local r = "" -- ./compiler/lua54.can:300
if # vars > 0 then -- ./compiler/lua54.can:301
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:302
t[2], -- ./compiler/lua54.can:302
vars[1], -- ./compiler/lua54.can:302
{ -- ./compiler/lua54.can:302
["tag"] = "Paren", -- ./compiler/lua54.can:302
values[1] -- ./compiler/lua54.can:302
} -- ./compiler/lua54.can:302
}, "Op")) -- ./compiler/lua54.can:302
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.can:303
r = r .. (", " .. lua({ -- ./compiler/lua54.can:304
t[2], -- ./compiler/lua54.can:304
vars[i], -- ./compiler/lua54.can:304
{ -- ./compiler/lua54.can:304
["tag"] = "Paren", -- ./compiler/lua54.can:304
values[i] -- ./compiler/lua54.can:304
} -- ./compiler/lua54.can:304
}, "Op")) -- ./compiler/lua54.can:304
end -- ./compiler/lua54.can:304
end -- ./compiler/lua54.can:304
if # destructuringVars > 0 then -- ./compiler/lua54.can:307
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.can:308
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:309
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:310
end -- ./compiler/lua54.can:310
return r -- ./compiler/lua54.can:312
else -- ./compiler/lua54.can:312
local r = "" -- ./compiler/lua54.can:314
if # vars > 0 then -- ./compiler/lua54.can:315
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:316
t[3], -- ./compiler/lua54.can:316
{ -- ./compiler/lua54.can:316
["tag"] = "Paren", -- ./compiler/lua54.can:316
values[1] -- ./compiler/lua54.can:316
}, -- ./compiler/lua54.can:316
vars[1] -- ./compiler/lua54.can:316
}, "Op")) -- ./compiler/lua54.can:316
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.can:317
r = r .. (", " .. lua({ -- ./compiler/lua54.can:318
t[3], -- ./compiler/lua54.can:318
{ -- ./compiler/lua54.can:318
["tag"] = "Paren", -- ./compiler/lua54.can:318
values[i] -- ./compiler/lua54.can:318
}, -- ./compiler/lua54.can:318
vars[i] -- ./compiler/lua54.can:318
}, "Op")) -- ./compiler/lua54.can:318
end -- ./compiler/lua54.can:318
end -- ./compiler/lua54.can:318
if # destructuringVars > 0 then -- ./compiler/lua54.can:321
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.can:322
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:323
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:324
end -- ./compiler/lua54.can:324
return r -- ./compiler/lua54.can:326
end -- ./compiler/lua54.can:326
else -- ./compiler/lua54.can:326
local r = "" -- ./compiler/lua54.can:329
if # vars > 0 then -- ./compiler/lua54.can:330
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:331
t[2], -- ./compiler/lua54.can:331
vars[1], -- ./compiler/lua54.can:331
{ -- ./compiler/lua54.can:331
["tag"] = "Op", -- ./compiler/lua54.can:331
t[4], -- ./compiler/lua54.can:331
{ -- ./compiler/lua54.can:331
["tag"] = "Paren", -- ./compiler/lua54.can:331
values[1] -- ./compiler/lua54.can:331
}, -- ./compiler/lua54.can:331
vars[1] -- ./compiler/lua54.can:331
} -- ./compiler/lua54.can:331
}, "Op")) -- ./compiler/lua54.can:331
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.can:332
r = r .. (", " .. lua({ -- ./compiler/lua54.can:333
t[2], -- ./compiler/lua54.can:333
vars[i], -- ./compiler/lua54.can:333
{ -- ./compiler/lua54.can:333
["tag"] = "Op", -- ./compiler/lua54.can:333
t[4], -- ./compiler/lua54.can:333
{ -- ./compiler/lua54.can:333
["tag"] = "Paren", -- ./compiler/lua54.can:333
values[i] -- ./compiler/lua54.can:333
}, -- ./compiler/lua54.can:333
vars[i] -- ./compiler/lua54.can:333
} -- ./compiler/lua54.can:333
}, "Op")) -- ./compiler/lua54.can:333
end -- ./compiler/lua54.can:333
end -- ./compiler/lua54.can:333
if # destructuringVars > 0 then -- ./compiler/lua54.can:336
local destructured = { -- ./compiler/lua54.can:337
["rightOp"] = t[2], -- ./compiler/lua54.can:337
["leftOp"] = t[4] -- ./compiler/lua54.can:337
} -- ./compiler/lua54.can:337
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:338
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:339
end -- ./compiler/lua54.can:339
return r -- ./compiler/lua54.can:341
end -- ./compiler/lua54.can:341
end, -- ./compiler/lua54.can:341
["While"] = function(t) -- ./compiler/lua54.can:345
local r = "" -- ./compiler/lua54.can:346
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.can:347
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.can:348
if # lets > 0 then -- ./compiler/lua54.can:349
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:350
for _, l in ipairs(lets) do -- ./compiler/lua54.can:351
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:352
end -- ./compiler/lua54.can:352
end -- ./compiler/lua54.can:352
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.can:355
if # lets > 0 then -- ./compiler/lua54.can:356
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:357
end -- ./compiler/lua54.can:357
if hasContinue then -- ./compiler/lua54.can:359
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:360
end -- ./compiler/lua54.can:360
r = r .. (lua(t[2])) -- ./compiler/lua54.can:362
if hasContinue then -- ./compiler/lua54.can:363
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:364
end -- ./compiler/lua54.can:364
r = r .. (unindent() .. "end") -- ./compiler/lua54.can:366
if # lets > 0 then -- ./compiler/lua54.can:367
for _, l in ipairs(lets) do -- ./compiler/lua54.can:368
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.can:369
end -- ./compiler/lua54.can:369
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.can:371
end -- ./compiler/lua54.can:371
return r -- ./compiler/lua54.can:373
end, -- ./compiler/lua54.can:373
["Repeat"] = function(t) -- ./compiler/lua54.can:376
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.can:377
local r = "repeat" .. indent() -- ./compiler/lua54.can:378
if hasContinue then -- ./compiler/lua54.can:379
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:380
end -- ./compiler/lua54.can:380
r = r .. (lua(t[1])) -- ./compiler/lua54.can:382
if hasContinue then -- ./compiler/lua54.can:383
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:384
end -- ./compiler/lua54.can:384
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.can:386
return r -- ./compiler/lua54.can:387
end, -- ./compiler/lua54.can:387
["If"] = function(t) -- ./compiler/lua54.can:390
local r = "" -- ./compiler/lua54.can:391
local toClose = 0 -- ./compiler/lua54.can:392
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.can:393
if # lets > 0 then -- ./compiler/lua54.can:394
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:395
toClose = toClose + (1) -- ./compiler/lua54.can:396
for _, l in ipairs(lets) do -- ./compiler/lua54.can:397
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:398
end -- ./compiler/lua54.can:398
end -- ./compiler/lua54.can:398
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.can:401
for i = 3, # t - 1, 2 do -- ./compiler/lua54.can:402
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.can:403
if # lets > 0 then -- ./compiler/lua54.can:404
r = r .. ("else" .. indent()) -- ./compiler/lua54.can:405
toClose = toClose + (1) -- ./compiler/lua54.can:406
for _, l in ipairs(lets) do -- ./compiler/lua54.can:407
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:408
end -- ./compiler/lua54.can:408
else -- ./compiler/lua54.can:408
r = r .. ("else") -- ./compiler/lua54.can:411
end -- ./compiler/lua54.can:411
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.can:413
end -- ./compiler/lua54.can:413
if # t % 2 == 1 then -- ./compiler/lua54.can:415
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.can:416
end -- ./compiler/lua54.can:416
r = r .. ("end") -- ./compiler/lua54.can:418
for i = 1, toClose do -- ./compiler/lua54.can:419
r = r .. (unindent() .. "end") -- ./compiler/lua54.can:420
end -- ./compiler/lua54.can:420
return r -- ./compiler/lua54.can:422
end, -- ./compiler/lua54.can:422
["Fornum"] = function(t) -- ./compiler/lua54.can:425
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.can:426
if # t == 5 then -- ./compiler/lua54.can:427
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.can:428
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.can:429
if hasContinue then -- ./compiler/lua54.can:430
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:431
end -- ./compiler/lua54.can:431
r = r .. (lua(t[5])) -- ./compiler/lua54.can:433
if hasContinue then -- ./compiler/lua54.can:434
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:435
end -- ./compiler/lua54.can:435
return r .. unindent() .. "end" -- ./compiler/lua54.can:437
else -- ./compiler/lua54.can:437
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.can:439
r = r .. (" do" .. indent()) -- ./compiler/lua54.can:440
if hasContinue then -- ./compiler/lua54.can:441
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:442
end -- ./compiler/lua54.can:442
r = r .. (lua(t[4])) -- ./compiler/lua54.can:444
if hasContinue then -- ./compiler/lua54.can:445
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:446
end -- ./compiler/lua54.can:446
return r .. unindent() .. "end" -- ./compiler/lua54.can:448
end -- ./compiler/lua54.can:448
end, -- ./compiler/lua54.can:448
["Forin"] = function(t) -- ./compiler/lua54.can:452
local destructured = {} -- ./compiler/lua54.can:453
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.can:454
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.can:455
if hasContinue then -- ./compiler/lua54.can:456
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:457
end -- ./compiler/lua54.can:457
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.can:459
if hasContinue then -- ./compiler/lua54.can:460
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:461
end -- ./compiler/lua54.can:461
return r .. unindent() .. "end" -- ./compiler/lua54.can:463
end, -- ./compiler/lua54.can:463
["Local"] = function(t) -- ./compiler/lua54.can:466
local destructured = {} -- ./compiler/lua54.can:467
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.can:468
if t[2][1] then -- ./compiler/lua54.can:469
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:470
end -- ./compiler/lua54.can:470
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.can:472
end, -- ./compiler/lua54.can:472
["Let"] = function(t) -- ./compiler/lua54.can:475
local destructured = {} -- ./compiler/lua54.can:476
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.can:477
local r = "local " .. nameList -- ./compiler/lua54.can:478
if t[2][1] then -- ./compiler/lua54.can:479
if all(t[2], { -- ./compiler/lua54.can:480
"Nil", -- ./compiler/lua54.can:480
"Dots", -- ./compiler/lua54.can:480
"Boolean", -- ./compiler/lua54.can:480
"Number", -- ./compiler/lua54.can:480
"String" -- ./compiler/lua54.can:480
}) then -- ./compiler/lua54.can:480
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:481
else -- ./compiler/lua54.can:481
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:483
end -- ./compiler/lua54.can:483
end -- ./compiler/lua54.can:483
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.can:486
end, -- ./compiler/lua54.can:486
["Localrec"] = function(t) -- ./compiler/lua54.can:489
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.can:490
end, -- ./compiler/lua54.can:490
["Goto"] = function(t) -- ./compiler/lua54.can:493
return "goto " .. lua(t, "Id") -- ./compiler/lua54.can:494
end, -- ./compiler/lua54.can:494
["Label"] = function(t) -- ./compiler/lua54.can:497
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.can:498
end, -- ./compiler/lua54.can:498
["Return"] = function(t) -- ./compiler/lua54.can:501
local push = peek("push") -- ./compiler/lua54.can:502
if push then -- ./compiler/lua54.can:503
local r = "" -- ./compiler/lua54.can:504
for _, val in ipairs(t) do -- ./compiler/lua54.can:505
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.can:506
end -- ./compiler/lua54.can:506
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.can:508
else -- ./compiler/lua54.can:508
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.can:510
end -- ./compiler/lua54.can:510
end, -- ./compiler/lua54.can:510
["Push"] = function(t) -- ./compiler/lua54.can:514
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.can:515
r = "" -- ./compiler/lua54.can:516
for i = 1, # t - 1, 1 do -- ./compiler/lua54.can:517
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.can:518
end -- ./compiler/lua54.can:518
if t[# t] then -- ./compiler/lua54.can:520
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.can:521
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.can:522
else -- ./compiler/lua54.can:522
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.can:524
end -- ./compiler/lua54.can:524
end -- ./compiler/lua54.can:524
return r -- ./compiler/lua54.can:527
end, -- ./compiler/lua54.can:527
["Break"] = function() -- ./compiler/lua54.can:530
return "break" -- ./compiler/lua54.can:531
end, -- ./compiler/lua54.can:531
["Continue"] = function() -- ./compiler/lua54.can:534
return "goto " .. var("continue") -- ./compiler/lua54.can:535
end, -- ./compiler/lua54.can:535
["Nil"] = function() -- ./compiler/lua54.can:542
return "nil" -- ./compiler/lua54.can:543
end, -- ./compiler/lua54.can:543
["Dots"] = function() -- ./compiler/lua54.can:546
local macroargs = peek("macroargs") -- ./compiler/lua54.can:547
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.can:548
nomacro["variables"]["..."] = true -- ./compiler/lua54.can:549
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.can:550
nomacro["variables"]["..."] = nil -- ./compiler/lua54.can:551
return r -- ./compiler/lua54.can:552
else -- ./compiler/lua54.can:552
return "..." -- ./compiler/lua54.can:554
end -- ./compiler/lua54.can:554
end, -- ./compiler/lua54.can:554
["Boolean"] = function(t) -- ./compiler/lua54.can:558
return tostring(t[1]) -- ./compiler/lua54.can:559
end, -- ./compiler/lua54.can:559
["Number"] = function(t) -- ./compiler/lua54.can:562
return tostring(t[1]) -- ./compiler/lua54.can:563
end, -- ./compiler/lua54.can:563
["String"] = function(t) -- ./compiler/lua54.can:566
return ("%q"):format(t[1]) -- ./compiler/lua54.can:567
end, -- ./compiler/lua54.can:567
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.can:570
local r = "(" -- ./compiler/lua54.can:571
local decl = {} -- ./compiler/lua54.can:572
if t[1][1] then -- ./compiler/lua54.can:573
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.can:574
local id = lua(t[1][1][1]) -- ./compiler/lua54.can:575
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:576
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.can:577
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:578
r = r .. (id) -- ./compiler/lua54.can:579
else -- ./compiler/lua54.can:579
r = r .. (lua(t[1][1])) -- ./compiler/lua54.can:581
end -- ./compiler/lua54.can:581
for i = 2, # t[1], 1 do -- ./compiler/lua54.can:583
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.can:584
local id = lua(t[1][i][1]) -- ./compiler/lua54.can:585
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:586
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.can:587
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:588
r = r .. (", " .. id) -- ./compiler/lua54.can:589
else -- ./compiler/lua54.can:589
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
r = r .. (")" .. indent()) -- ./compiler/lua54.can:595
for _, d in ipairs(decl) do -- ./compiler/lua54.can:596
r = r .. (d .. newline()) -- ./compiler/lua54.can:597
end -- ./compiler/lua54.can:597
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.can:599
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.can:600
end -- ./compiler/lua54.can:600
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.can:602
if hasPush then -- ./compiler/lua54.can:603
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:604
else -- ./compiler/lua54.can:604
push("push", false) -- ./compiler/lua54.can:606
end -- ./compiler/lua54.can:606
r = r .. (lua(t[2])) -- ./compiler/lua54.can:608
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.can:609
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.can:610
end -- ./compiler/lua54.can:610
pop("push") -- ./compiler/lua54.can:612
return r .. unindent() .. "end" -- ./compiler/lua54.can:613
end, -- ./compiler/lua54.can:613
["Function"] = function(t) -- ./compiler/lua54.can:615
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.can:616
end, -- ./compiler/lua54.can:616
["Pair"] = function(t) -- ./compiler/lua54.can:619
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.can:620
end, -- ./compiler/lua54.can:620
["Table"] = function(t) -- ./compiler/lua54.can:622
if # t == 0 then -- ./compiler/lua54.can:623
return "{}" -- ./compiler/lua54.can:624
elseif # t == 1 then -- ./compiler/lua54.can:625
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.can:626
else -- ./compiler/lua54.can:626
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.can:628
end -- ./compiler/lua54.can:628
end, -- ./compiler/lua54.can:628
["TableCompr"] = function(t) -- ./compiler/lua54.can:632
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.can:633
end, -- ./compiler/lua54.can:633
["Op"] = function(t) -- ./compiler/lua54.can:636
local r -- ./compiler/lua54.can:637
if # t == 2 then -- ./compiler/lua54.can:638
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.can:639
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.can:640
else -- ./compiler/lua54.can:640
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.can:642
end -- ./compiler/lua54.can:642
else -- ./compiler/lua54.can:642
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.can:645
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.can:646
else -- ./compiler/lua54.can:646
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.can:648
end -- ./compiler/lua54.can:648
end -- ./compiler/lua54.can:648
return r -- ./compiler/lua54.can:651
end, -- ./compiler/lua54.can:651
["Paren"] = function(t) -- ./compiler/lua54.can:654
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.can:655
end, -- ./compiler/lua54.can:655
["MethodStub"] = function(t) -- ./compiler/lua54.can:658
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.can:664
end, -- ./compiler/lua54.can:664
["SafeMethodStub"] = function(t) -- ./compiler/lua54.can:667
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.can:674
end, -- ./compiler/lua54.can:674
["LetExpr"] = function(t) -- ./compiler/lua54.can:681
return lua(t[1][1]) -- ./compiler/lua54.can:682
end, -- ./compiler/lua54.can:682
["_statexpr"] = function(t, stat) -- ./compiler/lua54.can:686
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.can:687
local r = "(function()" .. indent() -- ./compiler/lua54.can:688
if hasPush then -- ./compiler/lua54.can:689
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:690
else -- ./compiler/lua54.can:690
push("push", false) -- ./compiler/lua54.can:692
end -- ./compiler/lua54.can:692
r = r .. (lua(t, stat)) -- ./compiler/lua54.can:694
if hasPush then -- ./compiler/lua54.can:695
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.can:696
end -- ./compiler/lua54.can:696
pop("push") -- ./compiler/lua54.can:698
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.can:699
return r -- ./compiler/lua54.can:700
end, -- ./compiler/lua54.can:700
["DoExpr"] = function(t) -- ./compiler/lua54.can:703
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.can:704
t[# t]["tag"] = "Return" -- ./compiler/lua54.can:705
end -- ./compiler/lua54.can:705
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.can:707
end, -- ./compiler/lua54.can:707
["WhileExpr"] = function(t) -- ./compiler/lua54.can:710
return lua(t, "_statexpr", "While") -- ./compiler/lua54.can:711
end, -- ./compiler/lua54.can:711
["RepeatExpr"] = function(t) -- ./compiler/lua54.can:714
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.can:715
end, -- ./compiler/lua54.can:715
["IfExpr"] = function(t) -- ./compiler/lua54.can:718
for i = 2, # t do -- ./compiler/lua54.can:719
local block = t[i] -- ./compiler/lua54.can:720
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.can:721
block[# block]["tag"] = "Return" -- ./compiler/lua54.can:722
end -- ./compiler/lua54.can:722
end -- ./compiler/lua54.can:722
return lua(t, "_statexpr", "If") -- ./compiler/lua54.can:725
end, -- ./compiler/lua54.can:725
["FornumExpr"] = function(t) -- ./compiler/lua54.can:728
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.can:729
end, -- ./compiler/lua54.can:729
["ForinExpr"] = function(t) -- ./compiler/lua54.can:732
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.can:733
end, -- ./compiler/lua54.can:733
["Call"] = function(t) -- ./compiler/lua54.can:739
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.can:740
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:741
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.can:742
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.can:743
local replacement = macro["replacement"] -- ./compiler/lua54.can:744
local r -- ./compiler/lua54.can:745
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.can:746
if type(replacement) == "function" then -- ./compiler/lua54.can:747
local args = {} -- ./compiler/lua54.can:748
for i = 2, # t do -- ./compiler/lua54.can:749
table["insert"](args, lua(t[i])) -- ./compiler/lua54.can:750
end -- ./compiler/lua54.can:750
r = replacement(unpack(args)) -- ./compiler/lua54.can:752
else -- ./compiler/lua54.can:752
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.can:754
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.can:755
if arg["tag"] == "Dots" then -- ./compiler/lua54.can:756
macroargs["..."] = (function() -- ./compiler/lua54.can:757
local self = {} -- ./compiler/lua54.can:757
for j = i + 1, # t do -- ./compiler/lua54.can:757
self[#self+1] = t[j] -- ./compiler/lua54.can:757
end -- ./compiler/lua54.can:757
return self -- ./compiler/lua54.can:757
end)() -- ./compiler/lua54.can:757
elseif arg["tag"] == "Id" then -- ./compiler/lua54.can:758
if t[i + 1] == nil then -- ./compiler/lua54.can:759
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.can:760
end -- ./compiler/lua54.can:760
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.can:762
else -- ./compiler/lua54.can:762
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.can:764
end -- ./compiler/lua54.can:764
end -- ./compiler/lua54.can:764
push("macroargs", macroargs) -- ./compiler/lua54.can:767
r = lua(replacement) -- ./compiler/lua54.can:768
pop("macroargs") -- ./compiler/lua54.can:769
end -- ./compiler/lua54.can:769
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.can:771
return r -- ./compiler/lua54.can:772
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.can:773
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.can:774
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:775
else -- ./compiler/lua54.can:775
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:777
end -- ./compiler/lua54.can:777
else -- ./compiler/lua54.can:777
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:780
end -- ./compiler/lua54.can:780
end, -- ./compiler/lua54.can:780
["SafeCall"] = function(t) -- ./compiler/lua54.can:784
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.can:785
return lua(t, "SafeIndex") -- ./compiler/lua54.can:786
else -- ./compiler/lua54.can:786
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.can:788
end -- ./compiler/lua54.can:788
end, -- ./compiler/lua54.can:788
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.can:793
if start == nil then start = 1 end -- ./compiler/lua54.can:793
local r -- ./compiler/lua54.can:794
if t[start] then -- ./compiler/lua54.can:795
r = lua(t[start]) -- ./compiler/lua54.can:796
for i = start + 1, # t, 1 do -- ./compiler/lua54.can:797
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.can:798
end -- ./compiler/lua54.can:798
else -- ./compiler/lua54.can:798
r = "" -- ./compiler/lua54.can:801
end -- ./compiler/lua54.can:801
return r -- ./compiler/lua54.can:803
end, -- ./compiler/lua54.can:803
["Id"] = function(t) -- ./compiler/lua54.can:806
local r = t[1] -- ./compiler/lua54.can:807
local macroargs = peek("macroargs") -- ./compiler/lua54.can:808
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.can:809
nomacro["variables"][t[1]] = true -- ./compiler/lua54.can:810
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.can:811
r = lua(macroargs[t[1]]) -- ./compiler/lua54.can:812
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.can:813
local macro = macros["variables"][t[1]] -- ./compiler/lua54.can:814
if type(macro) == "function" then -- ./compiler/lua54.can:815
r = macro() -- ./compiler/lua54.can:816
else -- ./compiler/lua54.can:816
r = lua(macro) -- ./compiler/lua54.can:818
end -- ./compiler/lua54.can:818
end -- ./compiler/lua54.can:818
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.can:821
end -- ./compiler/lua54.can:821
return r -- ./compiler/lua54.can:823
end, -- ./compiler/lua54.can:823
["AttributeId"] = function(t) -- ./compiler/lua54.can:826
if t[2] then -- ./compiler/lua54.can:827
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.can:828
else -- ./compiler/lua54.can:828
return t[1] -- ./compiler/lua54.can:830
end -- ./compiler/lua54.can:830
end, -- ./compiler/lua54.can:830
["DestructuringId"] = function(t) -- ./compiler/lua54.can:834
if t["id"] then -- ./compiler/lua54.can:835
return t["id"] -- ./compiler/lua54.can:836
else -- ./compiler/lua54.can:836
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.can:838
local vars = { ["id"] = tmp() } -- ./compiler/lua54.can:839
for j = 1, # t, 1 do -- ./compiler/lua54.can:840
table["insert"](vars, t[j]) -- ./compiler/lua54.can:841
end -- ./compiler/lua54.can:841
table["insert"](d, vars) -- ./compiler/lua54.can:843
t["id"] = vars["id"] -- ./compiler/lua54.can:844
return vars["id"] -- ./compiler/lua54.can:845
end -- ./compiler/lua54.can:845
end, -- ./compiler/lua54.can:845
["Index"] = function(t) -- ./compiler/lua54.can:849
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.can:850
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.can:851
else -- ./compiler/lua54.can:851
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.can:853
end -- ./compiler/lua54.can:853
end, -- ./compiler/lua54.can:853
["SafeIndex"] = function(t) -- ./compiler/lua54.can:857
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.can:858
local l = {} -- ./compiler/lua54.can:859
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.can:860
table["insert"](l, 1, t) -- ./compiler/lua54.can:861
t = t[1] -- ./compiler/lua54.can:862
end -- ./compiler/lua54.can:862
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.can:864
for _, e in ipairs(l) do -- ./compiler/lua54.can:865
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.can:866
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.can:867
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.can:868
else -- ./compiler/lua54.can:868
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.can:870
end -- ./compiler/lua54.can:870
end -- ./compiler/lua54.can:870
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.can:873
return r -- ./compiler/lua54.can:874
else -- ./compiler/lua54.can:874
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.can:876
end -- ./compiler/lua54.can:876
end, -- ./compiler/lua54.can:876
["_opid"] = { -- ./compiler/lua54.can:881
["add"] = "+", -- ./compiler/lua54.can:882
["sub"] = "-", -- ./compiler/lua54.can:882
["mul"] = "*", -- ./compiler/lua54.can:882
["div"] = "/", -- ./compiler/lua54.can:882
["idiv"] = "//", -- ./compiler/lua54.can:883
["mod"] = "%", -- ./compiler/lua54.can:883
["pow"] = "^", -- ./compiler/lua54.can:883
["concat"] = "..", -- ./compiler/lua54.can:883
["band"] = "&", -- ./compiler/lua54.can:884
["bor"] = "|", -- ./compiler/lua54.can:884
["bxor"] = "~", -- ./compiler/lua54.can:884
["shl"] = "<<", -- ./compiler/lua54.can:884
["shr"] = ">>", -- ./compiler/lua54.can:884
["eq"] = "==", -- ./compiler/lua54.can:885
["ne"] = "~=", -- ./compiler/lua54.can:885
["lt"] = "<", -- ./compiler/lua54.can:885
["gt"] = ">", -- ./compiler/lua54.can:885
["le"] = "<=", -- ./compiler/lua54.can:885
["ge"] = ">=", -- ./compiler/lua54.can:885
["and"] = "and", -- ./compiler/lua54.can:886
["or"] = "or", -- ./compiler/lua54.can:886
["unm"] = "-", -- ./compiler/lua54.can:886
["len"] = "#", -- ./compiler/lua54.can:886
["bnot"] = "~", -- ./compiler/lua54.can:886
["not"] = "not" -- ./compiler/lua54.can:886
} -- ./compiler/lua54.can:886
}, { ["__index"] = function(self, key) -- ./compiler/lua54.can:889
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.can:890
end }) -- ./compiler/lua54.can:890
targetName = "Lua 5.3" -- ./compiler/lua53.can:1
tags["AttributeId"] = function(t) -- ./compiler/lua53.can:4
if t[2] then -- ./compiler/lua53.can:5
error("target " .. targetName .. " does not support variable attributes") -- ./compiler/lua53.can:6
else -- ./compiler/lua53.can:6
return t[1] -- ./compiler/lua53.can:8
end -- ./compiler/lua53.can:8
end -- ./compiler/lua53.can:8
targetName = "Lua 5.2" -- ./compiler/lua52.can:1
APPEND = function(t, toAppend) -- ./compiler/lua52.can:3
return "do" .. indent() .. "local " .. var("a") .. ", " .. var("p") .. " = { " .. toAppend .. " }, #" .. t .. "+1" .. newline() .. "for i=1, #" .. var("a") .. " do" .. indent() .. t .. "[" .. var("p") .. "] = " .. var("a") .. "[i]" .. newline() .. "" .. var("p") .. " = " .. var("p") .. " + 1" .. unindent() .. "end" .. unindent() .. "end" -- ./compiler/lua52.can:4
end -- ./compiler/lua52.can:4
tags["_opid"]["idiv"] = function(left, right) -- ./compiler/lua52.can:7
return "math.floor(" .. lua(left) .. " / " .. lua(right) .. ")" -- ./compiler/lua52.can:8
end -- ./compiler/lua52.can:8
tags["_opid"]["band"] = function(left, right) -- ./compiler/lua52.can:10
return "bit32.band(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:11
end -- ./compiler/lua52.can:11
tags["_opid"]["bor"] = function(left, right) -- ./compiler/lua52.can:13
return "bit32.bor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:14
end -- ./compiler/lua52.can:14
tags["_opid"]["bxor"] = function(left, right) -- ./compiler/lua52.can:16
return "bit32.bxor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:17
end -- ./compiler/lua52.can:17
tags["_opid"]["shl"] = function(left, right) -- ./compiler/lua52.can:19
return "bit32.lshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:20
end -- ./compiler/lua52.can:20
tags["_opid"]["shr"] = function(left, right) -- ./compiler/lua52.can:22
return "bit32.rshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:23
end -- ./compiler/lua52.can:23
tags["_opid"]["bnot"] = function(right) -- ./compiler/lua52.can:25
return "bit32.bnot(" .. lua(right) .. ")" -- ./compiler/lua52.can:26
end -- ./compiler/lua52.can:26
targetName = "LuaJIT" -- ./compiler/luajit.can:1
UNPACK = function(list, i, j) -- ./compiler/luajit.can:3
return "unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/luajit.can:4
end -- ./compiler/luajit.can:4
tags["_opid"]["band"] = function(left, right) -- ./compiler/luajit.can:7
addRequire("bit", "band", "band") -- ./compiler/luajit.can:8
return var("band") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.can:9
end -- ./compiler/luajit.can:9
tags["_opid"]["bor"] = function(left, right) -- ./compiler/luajit.can:11
addRequire("bit", "bor", "bor") -- ./compiler/luajit.can:12
return var("bor") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.can:13
end -- ./compiler/luajit.can:13
tags["_opid"]["bxor"] = function(left, right) -- ./compiler/luajit.can:15
addRequire("bit", "bxor", "bxor") -- ./compiler/luajit.can:16
return var("bxor") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.can:17
end -- ./compiler/luajit.can:17
tags["_opid"]["shl"] = function(left, right) -- ./compiler/luajit.can:19
addRequire("bit", "lshift", "lshift") -- ./compiler/luajit.can:20
return var("lshift") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.can:21
end -- ./compiler/luajit.can:21
tags["_opid"]["shr"] = function(left, right) -- ./compiler/luajit.can:23
addRequire("bit", "rshift", "rshift") -- ./compiler/luajit.can:24
return var("rshift") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.can:25
end -- ./compiler/luajit.can:25
tags["_opid"]["bnot"] = function(right) -- ./compiler/luajit.can:27
addRequire("bit", "bnot", "bnot") -- ./compiler/luajit.can:28
return var("bnot") .. "(" .. lua(right) .. ")" -- ./compiler/luajit.can:29
end -- ./compiler/luajit.can:29
local code = lua(ast) .. newline() -- ./compiler/lua54.can:896
return requireStr .. code -- ./compiler/lua54.can:897
end -- ./compiler/lua54.can:897
end -- ./compiler/lua54.can:897
local lua54 = _() or lua54 -- ./compiler/lua54.can:902
return lua54 -- ./compiler/lua53.can:18
end -- ./compiler/lua53.can:18
local lua53 = _() or lua53 -- ./compiler/lua53.can:22
return lua53 -- ./compiler/lua52.can:35
end -- ./compiler/lua52.can:35
local lua52 = _() or lua52 -- ./compiler/lua52.can:39
return lua52 -- ./compiler/luajit.can:38
end -- ./compiler/luajit.can:38
local luajit = _() or luajit -- ./compiler/luajit.can:42
package["loaded"]["compiler.luajit"] = luajit or true -- ./compiler/luajit.can:43
local function _() -- ./compiler/luajit.can:46
local function _() -- ./compiler/luajit.can:48
local function _() -- ./compiler/luajit.can:50
local function _() -- ./compiler/luajit.can:52
local function _() -- ./compiler/luajit.can:54
local util = require("lepton.util") -- ./compiler/lua54.can:1
local targetName = "Lua 5.4" -- ./compiler/lua54.can:3
local unpack = unpack or table["unpack"] -- ./compiler/lua54.can:5
return function(code, ast, options, macros) -- ./compiler/lua54.can:7
if macros == nil then macros = { -- ./compiler/lua54.can:7
["functions"] = {}, -- ./compiler/lua54.can:7
["variables"] = {} -- ./compiler/lua54.can:7
} end -- ./compiler/lua54.can:7
local lastInputPos = 1 -- ./compiler/lua54.can:9
local prevLinePos = 1 -- ./compiler/lua54.can:10
local lastSource = options["chunkname"] or "nil" -- ./compiler/lua54.can:11
local lastLine = 1 -- ./compiler/lua54.can:12
local indentLevel = 0 -- ./compiler/lua54.can:15
local function newline() -- ./compiler/lua54.can:17
local r = options["newline"] .. string["rep"](options["indentation"], indentLevel) -- ./compiler/lua54.can:18
if options["mapLines"] then -- ./compiler/lua54.can:19
local sub = code:sub(lastInputPos) -- ./compiler/lua54.can:20
local source, line = sub:sub(1, sub:find("\
")):match(".*%-%- (.-)%:(%d+)\
") -- ./compiler/lua54.can:21
if source and line then -- ./compiler/lua54.can:23
lastSource = source -- ./compiler/lua54.can:24
lastLine = tonumber(line) -- ./compiler/lua54.can:25
else -- ./compiler/lua54.can:25
for _ in code:sub(prevLinePos, lastInputPos):gmatch("\
") do -- ./compiler/lua54.can:27
lastLine = lastLine + (1) -- ./compiler/lua54.can:28
end -- ./compiler/lua54.can:28
end -- ./compiler/lua54.can:28
prevLinePos = lastInputPos -- ./compiler/lua54.can:32
r = " -- " .. lastSource .. ":" .. lastLine .. r -- ./compiler/lua54.can:34
end -- ./compiler/lua54.can:34
return r -- ./compiler/lua54.can:36
end -- ./compiler/lua54.can:36
local function indent() -- ./compiler/lua54.can:39
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:40
return newline() -- ./compiler/lua54.can:41
end -- ./compiler/lua54.can:41
local function unindent() -- ./compiler/lua54.can:44
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:45
return newline() -- ./compiler/lua54.can:46
end -- ./compiler/lua54.can:46
local states = { -- ./compiler/lua54.can:51
["push"] = {}, -- ./compiler/lua54.can:52
["destructuring"] = {}, -- ./compiler/lua54.can:53
["scope"] = {}, -- ./compiler/lua54.can:54
["macroargs"] = {} -- ./compiler/lua54.can:55
} -- ./compiler/lua54.can:55
local function push(name, state) -- ./compiler/lua54.can:58
table["insert"](states[name], state) -- ./compiler/lua54.can:59
return "" -- ./compiler/lua54.can:60
end -- ./compiler/lua54.can:60
local function pop(name) -- ./compiler/lua54.can:63
table["remove"](states[name]) -- ./compiler/lua54.can:64
return "" -- ./compiler/lua54.can:65
end -- ./compiler/lua54.can:65
local function set(name, state) -- ./compiler/lua54.can:68
states[name][# states[name]] = state -- ./compiler/lua54.can:69
return "" -- ./compiler/lua54.can:70
end -- ./compiler/lua54.can:70
local function peek(name) -- ./compiler/lua54.can:73
return states[name][# states[name]] -- ./compiler/lua54.can:74
end -- ./compiler/lua54.can:74
local function var(name) -- ./compiler/lua54.can:79
return options["variablePrefix"] .. name -- ./compiler/lua54.can:80
end -- ./compiler/lua54.can:80
local function tmp() -- ./compiler/lua54.can:84
local scope = peek("scope") -- ./compiler/lua54.can:85
local var = ("%s_%s"):format(options["variablePrefix"], # scope) -- ./compiler/lua54.can:86
table["insert"](scope, var) -- ./compiler/lua54.can:87
return var -- ./compiler/lua54.can:88
end -- ./compiler/lua54.can:88
local nomacro = { -- ./compiler/lua54.can:92
["variables"] = {}, -- ./compiler/lua54.can:92
["functions"] = {} -- ./compiler/lua54.can:92
} -- ./compiler/lua54.can:92
local required = {} -- ./compiler/lua54.can:95
local requireStr = "" -- ./compiler/lua54.can:96
local function addRequire(mod, name, field) -- ./compiler/lua54.can:98
local req = ("require(%q)%s"):format(mod, field and "." .. field or "") -- ./compiler/lua54.can:99
if not required[req] then -- ./compiler/lua54.can:100
requireStr = requireStr .. (("local %s = %s%s"):format(var(name), req, options["newline"])) -- ./compiler/lua54.can:101
required[req] = true -- ./compiler/lua54.can:102
end -- ./compiler/lua54.can:102
end -- ./compiler/lua54.can:102
local loop = { -- ./compiler/lua54.can:107
"While", -- ./compiler/lua54.can:107
"Repeat", -- ./compiler/lua54.can:107
"Fornum", -- ./compiler/lua54.can:107
"Forin", -- ./compiler/lua54.can:107
"WhileExpr", -- ./compiler/lua54.can:107
"RepeatExpr", -- ./compiler/lua54.can:107
"FornumExpr", -- ./compiler/lua54.can:107
"ForinExpr" -- ./compiler/lua54.can:107
} -- ./compiler/lua54.can:107
local func = { -- ./compiler/lua54.can:108
"Function", -- ./compiler/lua54.can:108
"TableCompr", -- ./compiler/lua54.can:108
"DoExpr", -- ./compiler/lua54.can:108
"WhileExpr", -- ./compiler/lua54.can:108
"RepeatExpr", -- ./compiler/lua54.can:108
"IfExpr", -- ./compiler/lua54.can:108
"FornumExpr", -- ./compiler/lua54.can:108
"ForinExpr" -- ./compiler/lua54.can:108
} -- ./compiler/lua54.can:108
local function any(list, tags, nofollow) -- ./compiler/lua54.can:112
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.can:112
local tagsCheck = {} -- ./compiler/lua54.can:113
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:114
tagsCheck[tag] = true -- ./compiler/lua54.can:115
end -- ./compiler/lua54.can:115
local nofollowCheck = {} -- ./compiler/lua54.can:117
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.can:118
nofollowCheck[tag] = true -- ./compiler/lua54.can:119
end -- ./compiler/lua54.can:119
for _, node in ipairs(list) do -- ./compiler/lua54.can:121
if type(node) == "table" then -- ./compiler/lua54.can:122
if tagsCheck[node["tag"]] then -- ./compiler/lua54.can:123
return node -- ./compiler/lua54.can:124
end -- ./compiler/lua54.can:124
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.can:126
local r = any(node, tags, nofollow) -- ./compiler/lua54.can:127
if r then -- ./compiler/lua54.can:128
return r -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
end -- ./compiler/lua54.can:128
return nil -- ./compiler/lua54.can:132
end -- ./compiler/lua54.can:132
local function search(list, tags, nofollow) -- ./compiler/lua54.can:137
if nofollow == nil then nofollow = {} end -- ./compiler/lua54.can:137
local tagsCheck = {} -- ./compiler/lua54.can:138
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:139
tagsCheck[tag] = true -- ./compiler/lua54.can:140
end -- ./compiler/lua54.can:140
local nofollowCheck = {} -- ./compiler/lua54.can:142
for _, tag in ipairs(nofollow) do -- ./compiler/lua54.can:143
nofollowCheck[tag] = true -- ./compiler/lua54.can:144
end -- ./compiler/lua54.can:144
local found = {} -- ./compiler/lua54.can:146
for _, node in ipairs(list) do -- ./compiler/lua54.can:147
if type(node) == "table" then -- ./compiler/lua54.can:148
if not nofollowCheck[node["tag"]] then -- ./compiler/lua54.can:149
for _, n in ipairs(search(node, tags, nofollow)) do -- ./compiler/lua54.can:150
table["insert"](found, n) -- ./compiler/lua54.can:151
end -- ./compiler/lua54.can:151
end -- ./compiler/lua54.can:151
if tagsCheck[node["tag"]] then -- ./compiler/lua54.can:154
table["insert"](found, node) -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
end -- ./compiler/lua54.can:155
return found -- ./compiler/lua54.can:159
end -- ./compiler/lua54.can:159
local function all(list, tags) -- ./compiler/lua54.can:163
for _, node in ipairs(list) do -- ./compiler/lua54.can:164
local ok = false -- ./compiler/lua54.can:165
for _, tag in ipairs(tags) do -- ./compiler/lua54.can:166
if node["tag"] == tag then -- ./compiler/lua54.can:167
ok = true -- ./compiler/lua54.can:168
break -- ./compiler/lua54.can:169
end -- ./compiler/lua54.can:169
end -- ./compiler/lua54.can:169
if not ok then -- ./compiler/lua54.can:172
return false -- ./compiler/lua54.can:173
end -- ./compiler/lua54.can:173
end -- ./compiler/lua54.can:173
return true -- ./compiler/lua54.can:176
end -- ./compiler/lua54.can:176
local tags -- ./compiler/lua54.can:180
local function lua(ast, forceTag, ...) -- ./compiler/lua54.can:182
if options["mapLines"] and ast["pos"] then -- ./compiler/lua54.can:183
lastInputPos = ast["pos"] -- ./compiler/lua54.can:184
end -- ./compiler/lua54.can:184
return tags[forceTag or ast["tag"]](ast, ...) -- ./compiler/lua54.can:186
end -- ./compiler/lua54.can:186
local UNPACK = function(list, i, j) -- ./compiler/lua54.can:190
return "table.unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/lua54.can:191
end -- ./compiler/lua54.can:191
local APPEND = function(t, toAppend) -- ./compiler/lua54.can:193
return "do" .. indent() .. "local " .. var("a") .. " = table.pack(" .. toAppend .. ")" .. newline() .. "table.move(" .. var("a") .. ", 1, " .. var("a") .. ".n, #" .. t .. "+1, " .. t .. ")" .. unindent() .. "end" -- ./compiler/lua54.can:194
end -- ./compiler/lua54.can:194
local CONTINUE_START = function() -- ./compiler/lua54.can:196
return "do" .. indent() -- ./compiler/lua54.can:197
end -- ./compiler/lua54.can:197
local CONTINUE_STOP = function() -- ./compiler/lua54.can:199
return unindent() .. "end" .. newline() .. "::" .. var("continue") .. "::" -- ./compiler/lua54.can:200
end -- ./compiler/lua54.can:200
local DESTRUCTURING_ASSIGN = function(destructured, newlineAfter, noLocal) -- ./compiler/lua54.can:202
if newlineAfter == nil then newlineAfter = false end -- ./compiler/lua54.can:202
if noLocal == nil then noLocal = false end -- ./compiler/lua54.can:202
local vars = {} -- ./compiler/lua54.can:203
local values = {} -- ./compiler/lua54.can:204
for _, list in ipairs(destructured) do -- ./compiler/lua54.can:205
for _, v in ipairs(list) do -- ./compiler/lua54.can:206
local var, val -- ./compiler/lua54.can:207
if v["tag"] == "Id" or v["tag"] == "AttributeId" then -- ./compiler/lua54.can:208
var = v -- ./compiler/lua54.can:209
val = { -- ./compiler/lua54.can:210
["tag"] = "Index", -- ./compiler/lua54.can:210
{ -- ./compiler/lua54.can:210
["tag"] = "Id", -- ./compiler/lua54.can:210
list["id"] -- ./compiler/lua54.can:210
}, -- ./compiler/lua54.can:210
{ -- ./compiler/lua54.can:210
["tag"] = "String", -- ./compiler/lua54.can:210
v[1] -- ./compiler/lua54.can:210
} -- ./compiler/lua54.can:210
} -- ./compiler/lua54.can:210
elseif v["tag"] == "Pair" then -- ./compiler/lua54.can:211
var = v[2] -- ./compiler/lua54.can:212
val = { -- ./compiler/lua54.can:213
["tag"] = "Index", -- ./compiler/lua54.can:213
{ -- ./compiler/lua54.can:213
["tag"] = "Id", -- ./compiler/lua54.can:213
list["id"] -- ./compiler/lua54.can:213
}, -- ./compiler/lua54.can:213
v[1] -- ./compiler/lua54.can:213
} -- ./compiler/lua54.can:213
else -- ./compiler/lua54.can:213
error("unknown destructuring element type: " .. tostring(v["tag"])) -- ./compiler/lua54.can:215
end -- ./compiler/lua54.can:215
if destructured["rightOp"] and destructured["leftOp"] then -- ./compiler/lua54.can:217
val = { -- ./compiler/lua54.can:218
["tag"] = "Op", -- ./compiler/lua54.can:218
destructured["rightOp"], -- ./compiler/lua54.can:218
var, -- ./compiler/lua54.can:218
{ -- ./compiler/lua54.can:218
["tag"] = "Op", -- ./compiler/lua54.can:218
destructured["leftOp"], -- ./compiler/lua54.can:218
val, -- ./compiler/lua54.can:218
var -- ./compiler/lua54.can:218
} -- ./compiler/lua54.can:218
} -- ./compiler/lua54.can:218
elseif destructured["rightOp"] then -- ./compiler/lua54.can:219
val = { -- ./compiler/lua54.can:220
["tag"] = "Op", -- ./compiler/lua54.can:220
destructured["rightOp"], -- ./compiler/lua54.can:220
var, -- ./compiler/lua54.can:220
val -- ./compiler/lua54.can:220
} -- ./compiler/lua54.can:220
elseif destructured["leftOp"] then -- ./compiler/lua54.can:221
val = { -- ./compiler/lua54.can:222
["tag"] = "Op", -- ./compiler/lua54.can:222
destructured["leftOp"], -- ./compiler/lua54.can:222
val, -- ./compiler/lua54.can:222
var -- ./compiler/lua54.can:222
} -- ./compiler/lua54.can:222
end -- ./compiler/lua54.can:222
table["insert"](vars, lua(var)) -- ./compiler/lua54.can:224
table["insert"](values, lua(val)) -- ./compiler/lua54.can:225
end -- ./compiler/lua54.can:225
end -- ./compiler/lua54.can:225
if # vars > 0 then -- ./compiler/lua54.can:228
local decl = noLocal and "" or "local " -- ./compiler/lua54.can:229
if newlineAfter then -- ./compiler/lua54.can:230
return decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") .. newline() -- ./compiler/lua54.can:231
else -- ./compiler/lua54.can:231
return newline() .. decl .. table["concat"](vars, ", ") .. " = " .. table["concat"](values, ", ") -- ./compiler/lua54.can:233
end -- ./compiler/lua54.can:233
else -- ./compiler/lua54.can:233
return "" -- ./compiler/lua54.can:236
end -- ./compiler/lua54.can:236
end -- ./compiler/lua54.can:236
tags = setmetatable({ -- ./compiler/lua54.can:241
["Block"] = function(t) -- ./compiler/lua54.can:243
local hasPush = peek("push") == nil and any(t, { "Push" }, func) -- ./compiler/lua54.can:244
if hasPush and hasPush == t[# t] then -- ./compiler/lua54.can:245
hasPush["tag"] = "Return" -- ./compiler/lua54.can:246
hasPush = false -- ./compiler/lua54.can:247
end -- ./compiler/lua54.can:247
local r = push("scope", {}) -- ./compiler/lua54.can:249
if hasPush then -- ./compiler/lua54.can:250
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:251
end -- ./compiler/lua54.can:251
for i = 1, # t - 1, 1 do -- ./compiler/lua54.can:253
r = r .. (lua(t[i]) .. newline()) -- ./compiler/lua54.can:254
end -- ./compiler/lua54.can:254
if t[# t] then -- ./compiler/lua54.can:256
r = r .. (lua(t[# t])) -- ./compiler/lua54.can:257
end -- ./compiler/lua54.can:257
if hasPush and (t[# t] and t[# t]["tag"] ~= "Return") then -- ./compiler/lua54.can:259
r = r .. (newline() .. "return " .. UNPACK(var("push")) .. pop("push")) -- ./compiler/lua54.can:260
end -- ./compiler/lua54.can:260
return r .. pop("scope") -- ./compiler/lua54.can:262
end, -- ./compiler/lua54.can:262
["Do"] = function(t) -- ./compiler/lua54.can:268
return "do" .. indent() .. lua(t, "Block") .. unindent() .. "end" -- ./compiler/lua54.can:269
end, -- ./compiler/lua54.can:269
["Set"] = function(t) -- ./compiler/lua54.can:272
local expr = t[# t] -- ./compiler/lua54.can:274
local vars, values = {}, {} -- ./compiler/lua54.can:275
local destructuringVars, destructuringValues = {}, {} -- ./compiler/lua54.can:276
for i, n in ipairs(t[1]) do -- ./compiler/lua54.can:277
if n["tag"] == "DestructuringId" then -- ./compiler/lua54.can:278
table["insert"](destructuringVars, n) -- ./compiler/lua54.can:279
table["insert"](destructuringValues, expr[i]) -- ./compiler/lua54.can:280
else -- ./compiler/lua54.can:280
table["insert"](vars, n) -- ./compiler/lua54.can:282
table["insert"](values, expr[i]) -- ./compiler/lua54.can:283
end -- ./compiler/lua54.can:283
end -- ./compiler/lua54.can:283
if # t == 2 or # t == 3 then -- ./compiler/lua54.can:287
local r = "" -- ./compiler/lua54.can:288
if # vars > 0 then -- ./compiler/lua54.can:289
r = lua(vars, "_lhs") .. " = " .. lua(values, "_lhs") -- ./compiler/lua54.can:290
end -- ./compiler/lua54.can:290
if # destructuringVars > 0 then -- ./compiler/lua54.can:292
local destructured = {} -- ./compiler/lua54.can:293
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:294
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:295
end -- ./compiler/lua54.can:295
return r -- ./compiler/lua54.can:297
elseif # t == 4 then -- ./compiler/lua54.can:298
if t[3] == "=" then -- ./compiler/lua54.can:299
local r = "" -- ./compiler/lua54.can:300
if # vars > 0 then -- ./compiler/lua54.can:301
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:302
t[2], -- ./compiler/lua54.can:302
vars[1], -- ./compiler/lua54.can:302
{ -- ./compiler/lua54.can:302
["tag"] = "Paren", -- ./compiler/lua54.can:302
values[1] -- ./compiler/lua54.can:302
} -- ./compiler/lua54.can:302
}, "Op")) -- ./compiler/lua54.can:302
for i = 2, math["min"](# t[4], # vars), 1 do -- ./compiler/lua54.can:303
r = r .. (", " .. lua({ -- ./compiler/lua54.can:304
t[2], -- ./compiler/lua54.can:304
vars[i], -- ./compiler/lua54.can:304
{ -- ./compiler/lua54.can:304
["tag"] = "Paren", -- ./compiler/lua54.can:304
values[i] -- ./compiler/lua54.can:304
} -- ./compiler/lua54.can:304
}, "Op")) -- ./compiler/lua54.can:304
end -- ./compiler/lua54.can:304
end -- ./compiler/lua54.can:304
if # destructuringVars > 0 then -- ./compiler/lua54.can:307
local destructured = { ["rightOp"] = t[2] } -- ./compiler/lua54.can:308
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:309
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:310
end -- ./compiler/lua54.can:310
return r -- ./compiler/lua54.can:312
else -- ./compiler/lua54.can:312
local r = "" -- ./compiler/lua54.can:314
if # vars > 0 then -- ./compiler/lua54.can:315
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:316
t[3], -- ./compiler/lua54.can:316
{ -- ./compiler/lua54.can:316
["tag"] = "Paren", -- ./compiler/lua54.can:316
values[1] -- ./compiler/lua54.can:316
}, -- ./compiler/lua54.can:316
vars[1] -- ./compiler/lua54.can:316
}, "Op")) -- ./compiler/lua54.can:316
for i = 2, math["min"](# t[4], # t[1]), 1 do -- ./compiler/lua54.can:317
r = r .. (", " .. lua({ -- ./compiler/lua54.can:318
t[3], -- ./compiler/lua54.can:318
{ -- ./compiler/lua54.can:318
["tag"] = "Paren", -- ./compiler/lua54.can:318
values[i] -- ./compiler/lua54.can:318
}, -- ./compiler/lua54.can:318
vars[i] -- ./compiler/lua54.can:318
}, "Op")) -- ./compiler/lua54.can:318
end -- ./compiler/lua54.can:318
end -- ./compiler/lua54.can:318
if # destructuringVars > 0 then -- ./compiler/lua54.can:321
local destructured = { ["leftOp"] = t[3] } -- ./compiler/lua54.can:322
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:323
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:324
end -- ./compiler/lua54.can:324
return r -- ./compiler/lua54.can:326
end -- ./compiler/lua54.can:326
else -- ./compiler/lua54.can:326
local r = "" -- ./compiler/lua54.can:329
if # vars > 0 then -- ./compiler/lua54.can:330
r = r .. (lua(vars, "_lhs") .. " = " .. lua({ -- ./compiler/lua54.can:331
t[2], -- ./compiler/lua54.can:331
vars[1], -- ./compiler/lua54.can:331
{ -- ./compiler/lua54.can:331
["tag"] = "Op", -- ./compiler/lua54.can:331
t[4], -- ./compiler/lua54.can:331
{ -- ./compiler/lua54.can:331
["tag"] = "Paren", -- ./compiler/lua54.can:331
values[1] -- ./compiler/lua54.can:331
}, -- ./compiler/lua54.can:331
vars[1] -- ./compiler/lua54.can:331
} -- ./compiler/lua54.can:331
}, "Op")) -- ./compiler/lua54.can:331
for i = 2, math["min"](# t[5], # t[1]), 1 do -- ./compiler/lua54.can:332
r = r .. (", " .. lua({ -- ./compiler/lua54.can:333
t[2], -- ./compiler/lua54.can:333
vars[i], -- ./compiler/lua54.can:333
{ -- ./compiler/lua54.can:333
["tag"] = "Op", -- ./compiler/lua54.can:333
t[4], -- ./compiler/lua54.can:333
{ -- ./compiler/lua54.can:333
["tag"] = "Paren", -- ./compiler/lua54.can:333
values[i] -- ./compiler/lua54.can:333
}, -- ./compiler/lua54.can:333
vars[i] -- ./compiler/lua54.can:333
} -- ./compiler/lua54.can:333
}, "Op")) -- ./compiler/lua54.can:333
end -- ./compiler/lua54.can:333
end -- ./compiler/lua54.can:333
if # destructuringVars > 0 then -- ./compiler/lua54.can:336
local destructured = { -- ./compiler/lua54.can:337
["rightOp"] = t[2], -- ./compiler/lua54.can:337
["leftOp"] = t[4] -- ./compiler/lua54.can:337
} -- ./compiler/lua54.can:337
r = r .. ("local " .. push("destructuring", destructured) .. lua(destructuringVars, "_lhs") .. pop("destructuring") .. " = " .. lua(destructuringValues, "_lhs")) -- ./compiler/lua54.can:338
return r .. DESTRUCTURING_ASSIGN(destructured, nil, true) -- ./compiler/lua54.can:339
end -- ./compiler/lua54.can:339
return r -- ./compiler/lua54.can:341
end -- ./compiler/lua54.can:341
end, -- ./compiler/lua54.can:341
["While"] = function(t) -- ./compiler/lua54.can:345
local r = "" -- ./compiler/lua54.can:346
local hasContinue = any(t[2], { "Continue" }, loop) -- ./compiler/lua54.can:347
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.can:348
if # lets > 0 then -- ./compiler/lua54.can:349
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:350
for _, l in ipairs(lets) do -- ./compiler/lua54.can:351
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:352
end -- ./compiler/lua54.can:352
end -- ./compiler/lua54.can:352
r = r .. ("while " .. lua(t[1]) .. " do" .. indent()) -- ./compiler/lua54.can:355
if # lets > 0 then -- ./compiler/lua54.can:356
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:357
end -- ./compiler/lua54.can:357
if hasContinue then -- ./compiler/lua54.can:359
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:360
end -- ./compiler/lua54.can:360
r = r .. (lua(t[2])) -- ./compiler/lua54.can:362
if hasContinue then -- ./compiler/lua54.can:363
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:364
end -- ./compiler/lua54.can:364
r = r .. (unindent() .. "end") -- ./compiler/lua54.can:366
if # lets > 0 then -- ./compiler/lua54.can:367
for _, l in ipairs(lets) do -- ./compiler/lua54.can:368
r = r .. (newline() .. lua(l, "Set")) -- ./compiler/lua54.can:369
end -- ./compiler/lua54.can:369
r = r .. (unindent() .. "end" .. unindent() .. "end") -- ./compiler/lua54.can:371
end -- ./compiler/lua54.can:371
return r -- ./compiler/lua54.can:373
end, -- ./compiler/lua54.can:373
["Repeat"] = function(t) -- ./compiler/lua54.can:376
local hasContinue = any(t[1], { "Continue" }, loop) -- ./compiler/lua54.can:377
local r = "repeat" .. indent() -- ./compiler/lua54.can:378
if hasContinue then -- ./compiler/lua54.can:379
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:380
end -- ./compiler/lua54.can:380
r = r .. (lua(t[1])) -- ./compiler/lua54.can:382
if hasContinue then -- ./compiler/lua54.can:383
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:384
end -- ./compiler/lua54.can:384
r = r .. (unindent() .. "until " .. lua(t[2])) -- ./compiler/lua54.can:386
return r -- ./compiler/lua54.can:387
end, -- ./compiler/lua54.can:387
["If"] = function(t) -- ./compiler/lua54.can:390
local r = "" -- ./compiler/lua54.can:391
local toClose = 0 -- ./compiler/lua54.can:392
local lets = search({ t[1] }, { "LetExpr" }) -- ./compiler/lua54.can:393
if # lets > 0 then -- ./compiler/lua54.can:394
r = r .. ("do" .. indent()) -- ./compiler/lua54.can:395
toClose = toClose + (1) -- ./compiler/lua54.can:396
for _, l in ipairs(lets) do -- ./compiler/lua54.can:397
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:398
end -- ./compiler/lua54.can:398
end -- ./compiler/lua54.can:398
r = r .. ("if " .. lua(t[1]) .. " then" .. indent() .. lua(t[2]) .. unindent()) -- ./compiler/lua54.can:401
for i = 3, # t - 1, 2 do -- ./compiler/lua54.can:402
lets = search({ t[i] }, { "LetExpr" }) -- ./compiler/lua54.can:403
if # lets > 0 then -- ./compiler/lua54.can:404
r = r .. ("else" .. indent()) -- ./compiler/lua54.can:405
toClose = toClose + (1) -- ./compiler/lua54.can:406
for _, l in ipairs(lets) do -- ./compiler/lua54.can:407
r = r .. (lua(l, "Let") .. newline()) -- ./compiler/lua54.can:408
end -- ./compiler/lua54.can:408
else -- ./compiler/lua54.can:408
r = r .. ("else") -- ./compiler/lua54.can:411
end -- ./compiler/lua54.can:411
r = r .. ("if " .. lua(t[i]) .. " then" .. indent() .. lua(t[i + 1]) .. unindent()) -- ./compiler/lua54.can:413
end -- ./compiler/lua54.can:413
if # t % 2 == 1 then -- ./compiler/lua54.can:415
r = r .. ("else" .. indent() .. lua(t[# t]) .. unindent()) -- ./compiler/lua54.can:416
end -- ./compiler/lua54.can:416
r = r .. ("end") -- ./compiler/lua54.can:418
for i = 1, toClose do -- ./compiler/lua54.can:419
r = r .. (unindent() .. "end") -- ./compiler/lua54.can:420
end -- ./compiler/lua54.can:420
return r -- ./compiler/lua54.can:422
end, -- ./compiler/lua54.can:422
["Fornum"] = function(t) -- ./compiler/lua54.can:425
local r = "for " .. lua(t[1]) .. " = " .. lua(t[2]) .. ", " .. lua(t[3]) -- ./compiler/lua54.can:426
if # t == 5 then -- ./compiler/lua54.can:427
local hasContinue = any(t[5], { "Continue" }, loop) -- ./compiler/lua54.can:428
r = r .. (", " .. lua(t[4]) .. " do" .. indent()) -- ./compiler/lua54.can:429
if hasContinue then -- ./compiler/lua54.can:430
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:431
end -- ./compiler/lua54.can:431
r = r .. (lua(t[5])) -- ./compiler/lua54.can:433
if hasContinue then -- ./compiler/lua54.can:434
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:435
end -- ./compiler/lua54.can:435
return r .. unindent() .. "end" -- ./compiler/lua54.can:437
else -- ./compiler/lua54.can:437
local hasContinue = any(t[4], { "Continue" }, loop) -- ./compiler/lua54.can:439
r = r .. (" do" .. indent()) -- ./compiler/lua54.can:440
if hasContinue then -- ./compiler/lua54.can:441
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:442
end -- ./compiler/lua54.can:442
r = r .. (lua(t[4])) -- ./compiler/lua54.can:444
if hasContinue then -- ./compiler/lua54.can:445
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:446
end -- ./compiler/lua54.can:446
return r .. unindent() .. "end" -- ./compiler/lua54.can:448
end -- ./compiler/lua54.can:448
end, -- ./compiler/lua54.can:448
["Forin"] = function(t) -- ./compiler/lua54.can:452
local destructured = {} -- ./compiler/lua54.can:453
local hasContinue = any(t[3], { "Continue" }, loop) -- ./compiler/lua54.can:454
local r = "for " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") .. " in " .. lua(t[2], "_lhs") .. " do" .. indent() -- ./compiler/lua54.can:455
if hasContinue then -- ./compiler/lua54.can:456
r = r .. (CONTINUE_START()) -- ./compiler/lua54.can:457
end -- ./compiler/lua54.can:457
r = r .. (DESTRUCTURING_ASSIGN(destructured, true) .. lua(t[3])) -- ./compiler/lua54.can:459
if hasContinue then -- ./compiler/lua54.can:460
r = r .. (CONTINUE_STOP()) -- ./compiler/lua54.can:461
end -- ./compiler/lua54.can:461
return r .. unindent() .. "end" -- ./compiler/lua54.can:463
end, -- ./compiler/lua54.can:463
["Local"] = function(t) -- ./compiler/lua54.can:466
local destructured = {} -- ./compiler/lua54.can:467
local r = "local " .. push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.can:468
if t[2][1] then -- ./compiler/lua54.can:469
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:470
end -- ./compiler/lua54.can:470
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.can:472
end, -- ./compiler/lua54.can:472
["Let"] = function(t) -- ./compiler/lua54.can:475
local destructured = {} -- ./compiler/lua54.can:476
local nameList = push("destructuring", destructured) .. lua(t[1], "_lhs") .. pop("destructuring") -- ./compiler/lua54.can:477
local r = "local " .. nameList -- ./compiler/lua54.can:478
if t[2][1] then -- ./compiler/lua54.can:479
if all(t[2], { -- ./compiler/lua54.can:480
"Nil", -- ./compiler/lua54.can:480
"Dots", -- ./compiler/lua54.can:480
"Boolean", -- ./compiler/lua54.can:480
"Number", -- ./compiler/lua54.can:480
"String" -- ./compiler/lua54.can:480
}) then -- ./compiler/lua54.can:480
r = r .. (" = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:481
else -- ./compiler/lua54.can:481
r = r .. (newline() .. nameList .. " = " .. lua(t[2], "_lhs")) -- ./compiler/lua54.can:483
end -- ./compiler/lua54.can:483
end -- ./compiler/lua54.can:483
return r .. DESTRUCTURING_ASSIGN(destructured) -- ./compiler/lua54.can:486
end, -- ./compiler/lua54.can:486
["Localrec"] = function(t) -- ./compiler/lua54.can:489
return "local function " .. lua(t[1][1]) .. lua(t[2][1], "_functionWithoutKeyword") -- ./compiler/lua54.can:490
end, -- ./compiler/lua54.can:490
["Goto"] = function(t) -- ./compiler/lua54.can:493
return "goto " .. lua(t, "Id") -- ./compiler/lua54.can:494
end, -- ./compiler/lua54.can:494
["Label"] = function(t) -- ./compiler/lua54.can:497
return "::" .. lua(t, "Id") .. "::" -- ./compiler/lua54.can:498
end, -- ./compiler/lua54.can:498
["Return"] = function(t) -- ./compiler/lua54.can:501
local push = peek("push") -- ./compiler/lua54.can:502
if push then -- ./compiler/lua54.can:503
local r = "" -- ./compiler/lua54.can:504
for _, val in ipairs(t) do -- ./compiler/lua54.can:505
r = r .. (push .. "[#" .. push .. "+1] = " .. lua(val) .. newline()) -- ./compiler/lua54.can:506
end -- ./compiler/lua54.can:506
return r .. "return " .. UNPACK(push) -- ./compiler/lua54.can:508
else -- ./compiler/lua54.can:508
return "return " .. lua(t, "_lhs") -- ./compiler/lua54.can:510
end -- ./compiler/lua54.can:510
end, -- ./compiler/lua54.can:510
["Push"] = function(t) -- ./compiler/lua54.can:514
local var = assert(peek("push"), "no context given for push") -- ./compiler/lua54.can:515
r = "" -- ./compiler/lua54.can:516
for i = 1, # t - 1, 1 do -- ./compiler/lua54.can:517
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[i]) .. newline()) -- ./compiler/lua54.can:518
end -- ./compiler/lua54.can:518
if t[# t] then -- ./compiler/lua54.can:520
if t[# t]["tag"] == "Call" then -- ./compiler/lua54.can:521
r = r .. (APPEND(var, lua(t[# t]))) -- ./compiler/lua54.can:522
else -- ./compiler/lua54.can:522
r = r .. (var .. "[#" .. var .. "+1] = " .. lua(t[# t])) -- ./compiler/lua54.can:524
end -- ./compiler/lua54.can:524
end -- ./compiler/lua54.can:524
return r -- ./compiler/lua54.can:527
end, -- ./compiler/lua54.can:527
["Break"] = function() -- ./compiler/lua54.can:530
return "break" -- ./compiler/lua54.can:531
end, -- ./compiler/lua54.can:531
["Continue"] = function() -- ./compiler/lua54.can:534
return "goto " .. var("continue") -- ./compiler/lua54.can:535
end, -- ./compiler/lua54.can:535
["Nil"] = function() -- ./compiler/lua54.can:542
return "nil" -- ./compiler/lua54.can:543
end, -- ./compiler/lua54.can:543
["Dots"] = function() -- ./compiler/lua54.can:546
local macroargs = peek("macroargs") -- ./compiler/lua54.can:547
if macroargs and not nomacro["variables"]["..."] and macroargs["..."] then -- ./compiler/lua54.can:548
nomacro["variables"]["..."] = true -- ./compiler/lua54.can:549
local r = lua(macroargs["..."], "_lhs") -- ./compiler/lua54.can:550
nomacro["variables"]["..."] = nil -- ./compiler/lua54.can:551
return r -- ./compiler/lua54.can:552
else -- ./compiler/lua54.can:552
return "..." -- ./compiler/lua54.can:554
end -- ./compiler/lua54.can:554
end, -- ./compiler/lua54.can:554
["Boolean"] = function(t) -- ./compiler/lua54.can:558
return tostring(t[1]) -- ./compiler/lua54.can:559
end, -- ./compiler/lua54.can:559
["Number"] = function(t) -- ./compiler/lua54.can:562
return tostring(t[1]) -- ./compiler/lua54.can:563
end, -- ./compiler/lua54.can:563
["String"] = function(t) -- ./compiler/lua54.can:566
return ("%q"):format(t[1]) -- ./compiler/lua54.can:567
end, -- ./compiler/lua54.can:567
["_functionWithoutKeyword"] = function(t) -- ./compiler/lua54.can:570
local r = "(" -- ./compiler/lua54.can:571
local decl = {} -- ./compiler/lua54.can:572
if t[1][1] then -- ./compiler/lua54.can:573
if t[1][1]["tag"] == "ParPair" then -- ./compiler/lua54.can:574
local id = lua(t[1][1][1]) -- ./compiler/lua54.can:575
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:576
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][1][2]) .. " end") -- ./compiler/lua54.can:577
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:578
r = r .. (id) -- ./compiler/lua54.can:579
else -- ./compiler/lua54.can:579
r = r .. (lua(t[1][1])) -- ./compiler/lua54.can:581
end -- ./compiler/lua54.can:581
for i = 2, # t[1], 1 do -- ./compiler/lua54.can:583
if t[1][i]["tag"] == "ParPair" then -- ./compiler/lua54.can:584
local id = lua(t[1][i][1]) -- ./compiler/lua54.can:585
indentLevel = indentLevel + (1) -- ./compiler/lua54.can:586
table["insert"](decl, "if " .. id .. " == nil then " .. id .. " = " .. lua(t[1][i][2]) .. " end") -- ./compiler/lua54.can:587
indentLevel = indentLevel - (1) -- ./compiler/lua54.can:588
r = r .. (", " .. id) -- ./compiler/lua54.can:589
else -- ./compiler/lua54.can:589
r = r .. (", " .. lua(t[1][i])) -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
end -- ./compiler/lua54.can:591
r = r .. (")" .. indent()) -- ./compiler/lua54.can:595
for _, d in ipairs(decl) do -- ./compiler/lua54.can:596
r = r .. (d .. newline()) -- ./compiler/lua54.can:597
end -- ./compiler/lua54.can:597
if t[2][# t[2]] and t[2][# t[2]]["tag"] == "Push" then -- ./compiler/lua54.can:599
t[2][# t[2]]["tag"] = "Return" -- ./compiler/lua54.can:600
end -- ./compiler/lua54.can:600
local hasPush = any(t[2], { "Push" }, func) -- ./compiler/lua54.can:602
if hasPush then -- ./compiler/lua54.can:603
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:604
else -- ./compiler/lua54.can:604
push("push", false) -- ./compiler/lua54.can:606
end -- ./compiler/lua54.can:606
r = r .. (lua(t[2])) -- ./compiler/lua54.can:608
if hasPush and (t[2][# t[2]] and t[2][# t[2]]["tag"] ~= "Return") then -- ./compiler/lua54.can:609
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.can:610
end -- ./compiler/lua54.can:610
pop("push") -- ./compiler/lua54.can:612
return r .. unindent() .. "end" -- ./compiler/lua54.can:613
end, -- ./compiler/lua54.can:613
["Function"] = function(t) -- ./compiler/lua54.can:615
return "function" .. lua(t, "_functionWithoutKeyword") -- ./compiler/lua54.can:616
end, -- ./compiler/lua54.can:616
["Pair"] = function(t) -- ./compiler/lua54.can:619
return "[" .. lua(t[1]) .. "] = " .. lua(t[2]) -- ./compiler/lua54.can:620
end, -- ./compiler/lua54.can:620
["Table"] = function(t) -- ./compiler/lua54.can:622
if # t == 0 then -- ./compiler/lua54.can:623
return "{}" -- ./compiler/lua54.can:624
elseif # t == 1 then -- ./compiler/lua54.can:625
return "{ " .. lua(t, "_lhs") .. " }" -- ./compiler/lua54.can:626
else -- ./compiler/lua54.can:626
return "{" .. indent() .. lua(t, "_lhs", nil, true) .. unindent() .. "}" -- ./compiler/lua54.can:628
end -- ./compiler/lua54.can:628
end, -- ./compiler/lua54.can:628
["TableCompr"] = function(t) -- ./compiler/lua54.can:632
return push("push", "self") .. "(function()" .. indent() .. "local self = {}" .. newline() .. lua(t[1]) .. newline() .. "return self" .. unindent() .. "end)()" .. pop("push") -- ./compiler/lua54.can:633
end, -- ./compiler/lua54.can:633
["Op"] = function(t) -- ./compiler/lua54.can:636
local r -- ./compiler/lua54.can:637
if # t == 2 then -- ./compiler/lua54.can:638
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.can:639
r = tags["_opid"][t[1]] .. " " .. lua(t[2]) -- ./compiler/lua54.can:640
else -- ./compiler/lua54.can:640
r = tags["_opid"][t[1]](t[2]) -- ./compiler/lua54.can:642
end -- ./compiler/lua54.can:642
else -- ./compiler/lua54.can:642
if type(tags["_opid"][t[1]]) == "string" then -- ./compiler/lua54.can:645
r = lua(t[2]) .. " " .. tags["_opid"][t[1]] .. " " .. lua(t[3]) -- ./compiler/lua54.can:646
else -- ./compiler/lua54.can:646
r = tags["_opid"][t[1]](t[2], t[3]) -- ./compiler/lua54.can:648
end -- ./compiler/lua54.can:648
end -- ./compiler/lua54.can:648
return r -- ./compiler/lua54.can:651
end, -- ./compiler/lua54.can:651
["Paren"] = function(t) -- ./compiler/lua54.can:654
return "(" .. lua(t[1]) .. ")" -- ./compiler/lua54.can:655
end, -- ./compiler/lua54.can:655
["MethodStub"] = function(t) -- ./compiler/lua54.can:658
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.can:664
end, -- ./compiler/lua54.can:664
["SafeMethodStub"] = function(t) -- ./compiler/lua54.can:667
return "(function()" .. indent() .. "local " .. var("object") .. " = " .. lua(t[1]) .. newline() .. "if " .. var("object") .. " == nil then return nil end" .. newline() .. "local " .. var("method") .. " = " .. var("object") .. "." .. lua(t[2], "Id") .. newline() .. "if " .. var("method") .. " == nil then return nil end" .. newline() .. "return function(...) return " .. var("method") .. "(" .. var("object") .. ", ...) end" .. unindent() .. "end)()" -- ./compiler/lua54.can:674
end, -- ./compiler/lua54.can:674
["LetExpr"] = function(t) -- ./compiler/lua54.can:681
return lua(t[1][1]) -- ./compiler/lua54.can:682
end, -- ./compiler/lua54.can:682
["_statexpr"] = function(t, stat) -- ./compiler/lua54.can:686
local hasPush = any(t, { "Push" }, func) -- ./compiler/lua54.can:687
local r = "(function()" .. indent() -- ./compiler/lua54.can:688
if hasPush then -- ./compiler/lua54.can:689
r = r .. (push("push", var("push")) .. "local " .. var("push") .. " = {}" .. newline()) -- ./compiler/lua54.can:690
else -- ./compiler/lua54.can:690
push("push", false) -- ./compiler/lua54.can:692
end -- ./compiler/lua54.can:692
r = r .. (lua(t, stat)) -- ./compiler/lua54.can:694
if hasPush then -- ./compiler/lua54.can:695
r = r .. (newline() .. "return " .. UNPACK(var("push"))) -- ./compiler/lua54.can:696
end -- ./compiler/lua54.can:696
pop("push") -- ./compiler/lua54.can:698
r = r .. (unindent() .. "end)()") -- ./compiler/lua54.can:699
return r -- ./compiler/lua54.can:700
end, -- ./compiler/lua54.can:700
["DoExpr"] = function(t) -- ./compiler/lua54.can:703
if t[# t]["tag"] == "Push" then -- ./compiler/lua54.can:704
t[# t]["tag"] = "Return" -- ./compiler/lua54.can:705
end -- ./compiler/lua54.can:705
return lua(t, "_statexpr", "Do") -- ./compiler/lua54.can:707
end, -- ./compiler/lua54.can:707
["WhileExpr"] = function(t) -- ./compiler/lua54.can:710
return lua(t, "_statexpr", "While") -- ./compiler/lua54.can:711
end, -- ./compiler/lua54.can:711
["RepeatExpr"] = function(t) -- ./compiler/lua54.can:714
return lua(t, "_statexpr", "Repeat") -- ./compiler/lua54.can:715
end, -- ./compiler/lua54.can:715
["IfExpr"] = function(t) -- ./compiler/lua54.can:718
for i = 2, # t do -- ./compiler/lua54.can:719
local block = t[i] -- ./compiler/lua54.can:720
if block[# block] and block[# block]["tag"] == "Push" then -- ./compiler/lua54.can:721
block[# block]["tag"] = "Return" -- ./compiler/lua54.can:722
end -- ./compiler/lua54.can:722
end -- ./compiler/lua54.can:722
return lua(t, "_statexpr", "If") -- ./compiler/lua54.can:725
end, -- ./compiler/lua54.can:725
["FornumExpr"] = function(t) -- ./compiler/lua54.can:728
return lua(t, "_statexpr", "Fornum") -- ./compiler/lua54.can:729
end, -- ./compiler/lua54.can:729
["ForinExpr"] = function(t) -- ./compiler/lua54.can:732
return lua(t, "_statexpr", "Forin") -- ./compiler/lua54.can:733
end, -- ./compiler/lua54.can:733
["Call"] = function(t) -- ./compiler/lua54.can:739
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.can:740
return "(" .. lua(t[1]) .. ")(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:741
elseif t[1]["tag"] == "Id" and not nomacro["functions"][t[1][1]] and macros["functions"][t[1][1]] then -- ./compiler/lua54.can:742
local macro = macros["functions"][t[1][1]] -- ./compiler/lua54.can:743
local replacement = macro["replacement"] -- ./compiler/lua54.can:744
local r -- ./compiler/lua54.can:745
nomacro["functions"][t[1][1]] = true -- ./compiler/lua54.can:746
if type(replacement) == "function" then -- ./compiler/lua54.can:747
local args = {} -- ./compiler/lua54.can:748
for i = 2, # t do -- ./compiler/lua54.can:749
table["insert"](args, lua(t[i])) -- ./compiler/lua54.can:750
end -- ./compiler/lua54.can:750
r = replacement(unpack(args)) -- ./compiler/lua54.can:752
else -- ./compiler/lua54.can:752
local macroargs = util["merge"](peek("macroargs")) -- ./compiler/lua54.can:754
for i, arg in ipairs(macro["args"]) do -- ./compiler/lua54.can:755
if arg["tag"] == "Dots" then -- ./compiler/lua54.can:756
macroargs["..."] = (function() -- ./compiler/lua54.can:757
local self = {} -- ./compiler/lua54.can:757
for j = i + 1, # t do -- ./compiler/lua54.can:757
self[#self+1] = t[j] -- ./compiler/lua54.can:757
end -- ./compiler/lua54.can:757
return self -- ./compiler/lua54.can:757
end)() -- ./compiler/lua54.can:757
elseif arg["tag"] == "Id" then -- ./compiler/lua54.can:758
if t[i + 1] == nil then -- ./compiler/lua54.can:759
error(("bad argument #%s to macro %s (value expected)"):format(i, t[1][1])) -- ./compiler/lua54.can:760
end -- ./compiler/lua54.can:760
macroargs[arg[1]] = t[i + 1] -- ./compiler/lua54.can:762
else -- ./compiler/lua54.can:762
error(("unexpected argument type %s in macro %s"):format(arg["tag"], t[1][1])) -- ./compiler/lua54.can:764
end -- ./compiler/lua54.can:764
end -- ./compiler/lua54.can:764
push("macroargs", macroargs) -- ./compiler/lua54.can:767
r = lua(replacement) -- ./compiler/lua54.can:768
pop("macroargs") -- ./compiler/lua54.can:769
end -- ./compiler/lua54.can:769
nomacro["functions"][t[1][1]] = nil -- ./compiler/lua54.can:771
return r -- ./compiler/lua54.can:772
elseif t[1]["tag"] == "MethodStub" then -- ./compiler/lua54.can:773
if t[1][1]["tag"] == "String" or t[1][1]["tag"] == "Table" then -- ./compiler/lua54.can:774
return "(" .. lua(t[1][1]) .. "):" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:775
else -- ./compiler/lua54.can:775
return lua(t[1][1]) .. ":" .. lua(t[1][2], "Id") .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:777
end -- ./compiler/lua54.can:777
else -- ./compiler/lua54.can:777
return lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ")" -- ./compiler/lua54.can:780
end -- ./compiler/lua54.can:780
end, -- ./compiler/lua54.can:780
["SafeCall"] = function(t) -- ./compiler/lua54.can:784
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.can:785
return lua(t, "SafeIndex") -- ./compiler/lua54.can:786
else -- ./compiler/lua54.can:786
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "(" .. lua(t, "_lhs", 2) .. ") or nil)" -- ./compiler/lua54.can:788
end -- ./compiler/lua54.can:788
end, -- ./compiler/lua54.can:788
["_lhs"] = function(t, start, newlines) -- ./compiler/lua54.can:793
if start == nil then start = 1 end -- ./compiler/lua54.can:793
local r -- ./compiler/lua54.can:794
if t[start] then -- ./compiler/lua54.can:795
r = lua(t[start]) -- ./compiler/lua54.can:796
for i = start + 1, # t, 1 do -- ./compiler/lua54.can:797
r = r .. ("," .. (newlines and newline() or " ") .. lua(t[i])) -- ./compiler/lua54.can:798
end -- ./compiler/lua54.can:798
else -- ./compiler/lua54.can:798
r = "" -- ./compiler/lua54.can:801
end -- ./compiler/lua54.can:801
return r -- ./compiler/lua54.can:803
end, -- ./compiler/lua54.can:803
["Id"] = function(t) -- ./compiler/lua54.can:806
local r = t[1] -- ./compiler/lua54.can:807
local macroargs = peek("macroargs") -- ./compiler/lua54.can:808
if not nomacro["variables"][t[1]] then -- ./compiler/lua54.can:809
nomacro["variables"][t[1]] = true -- ./compiler/lua54.can:810
if macroargs and macroargs[t[1]] then -- ./compiler/lua54.can:811
r = lua(macroargs[t[1]]) -- ./compiler/lua54.can:812
elseif macros["variables"][t[1]] ~= nil then -- ./compiler/lua54.can:813
local macro = macros["variables"][t[1]] -- ./compiler/lua54.can:814
if type(macro) == "function" then -- ./compiler/lua54.can:815
r = macro() -- ./compiler/lua54.can:816
else -- ./compiler/lua54.can:816
r = lua(macro) -- ./compiler/lua54.can:818
end -- ./compiler/lua54.can:818
end -- ./compiler/lua54.can:818
nomacro["variables"][t[1]] = nil -- ./compiler/lua54.can:821
end -- ./compiler/lua54.can:821
return r -- ./compiler/lua54.can:823
end, -- ./compiler/lua54.can:823
["AttributeId"] = function(t) -- ./compiler/lua54.can:826
if t[2] then -- ./compiler/lua54.can:827
return t[1] .. " <" .. t[2] .. ">" -- ./compiler/lua54.can:828
else -- ./compiler/lua54.can:828
return t[1] -- ./compiler/lua54.can:830
end -- ./compiler/lua54.can:830
end, -- ./compiler/lua54.can:830
["DestructuringId"] = function(t) -- ./compiler/lua54.can:834
if t["id"] then -- ./compiler/lua54.can:835
return t["id"] -- ./compiler/lua54.can:836
else -- ./compiler/lua54.can:836
local d = assert(peek("destructuring"), "DestructuringId not in a destructurable assignement") -- ./compiler/lua54.can:838
local vars = { ["id"] = tmp() } -- ./compiler/lua54.can:839
for j = 1, # t, 1 do -- ./compiler/lua54.can:840
table["insert"](vars, t[j]) -- ./compiler/lua54.can:841
end -- ./compiler/lua54.can:841
table["insert"](d, vars) -- ./compiler/lua54.can:843
t["id"] = vars["id"] -- ./compiler/lua54.can:844
return vars["id"] -- ./compiler/lua54.can:845
end -- ./compiler/lua54.can:845
end, -- ./compiler/lua54.can:845
["Index"] = function(t) -- ./compiler/lua54.can:849
if t[1]["tag"] == "String" or t[1]["tag"] == "Table" then -- ./compiler/lua54.can:850
return "(" .. lua(t[1]) .. ")[" .. lua(t[2]) .. "]" -- ./compiler/lua54.can:851
else -- ./compiler/lua54.can:851
return lua(t[1]) .. "[" .. lua(t[2]) .. "]" -- ./compiler/lua54.can:853
end -- ./compiler/lua54.can:853
end, -- ./compiler/lua54.can:853
["SafeIndex"] = function(t) -- ./compiler/lua54.can:857
if t[1]["tag"] ~= "Id" then -- ./compiler/lua54.can:858
local l = {} -- ./compiler/lua54.can:859
while t["tag"] == "SafeIndex" or t["tag"] == "SafeCall" do -- ./compiler/lua54.can:860
table["insert"](l, 1, t) -- ./compiler/lua54.can:861
t = t[1] -- ./compiler/lua54.can:862
end -- ./compiler/lua54.can:862
local r = "(function()" .. indent() .. "local " .. var("safe") .. " = " .. lua(l[1][1]) .. newline() -- ./compiler/lua54.can:864
for _, e in ipairs(l) do -- ./compiler/lua54.can:865
r = r .. ("if " .. var("safe") .. " == nil then return nil end" .. newline()) -- ./compiler/lua54.can:866
if e["tag"] == "SafeIndex" then -- ./compiler/lua54.can:867
r = r .. (var("safe") .. " = " .. var("safe") .. "[" .. lua(e[2]) .. "]" .. newline()) -- ./compiler/lua54.can:868
else -- ./compiler/lua54.can:868
r = r .. (var("safe") .. " = " .. var("safe") .. "(" .. lua(e, "_lhs", 2) .. ")" .. newline()) -- ./compiler/lua54.can:870
end -- ./compiler/lua54.can:870
end -- ./compiler/lua54.can:870
r = r .. ("return " .. var("safe") .. unindent() .. "end)()") -- ./compiler/lua54.can:873
return r -- ./compiler/lua54.can:874
else -- ./compiler/lua54.can:874
return "(" .. lua(t[1]) .. " ~= nil and " .. lua(t[1]) .. "[" .. lua(t[2]) .. "] or nil)" -- ./compiler/lua54.can:876
end -- ./compiler/lua54.can:876
end, -- ./compiler/lua54.can:876
["_opid"] = { -- ./compiler/lua54.can:881
["add"] = "+", -- ./compiler/lua54.can:882
["sub"] = "-", -- ./compiler/lua54.can:882
["mul"] = "*", -- ./compiler/lua54.can:882
["div"] = "/", -- ./compiler/lua54.can:882
["idiv"] = "//", -- ./compiler/lua54.can:883
["mod"] = "%", -- ./compiler/lua54.can:883
["pow"] = "^", -- ./compiler/lua54.can:883
["concat"] = "..", -- ./compiler/lua54.can:883
["band"] = "&", -- ./compiler/lua54.can:884
["bor"] = "|", -- ./compiler/lua54.can:884
["bxor"] = "~", -- ./compiler/lua54.can:884
["shl"] = "<<", -- ./compiler/lua54.can:884
["shr"] = ">>", -- ./compiler/lua54.can:884
["eq"] = "==", -- ./compiler/lua54.can:885
["ne"] = "~=", -- ./compiler/lua54.can:885
["lt"] = "<", -- ./compiler/lua54.can:885
["gt"] = ">", -- ./compiler/lua54.can:885
["le"] = "<=", -- ./compiler/lua54.can:885
["ge"] = ">=", -- ./compiler/lua54.can:885
["and"] = "and", -- ./compiler/lua54.can:886
["or"] = "or", -- ./compiler/lua54.can:886
["unm"] = "-", -- ./compiler/lua54.can:886
["len"] = "#", -- ./compiler/lua54.can:886
["bnot"] = "~", -- ./compiler/lua54.can:886
["not"] = "not" -- ./compiler/lua54.can:886
} -- ./compiler/lua54.can:886
}, { ["__index"] = function(self, key) -- ./compiler/lua54.can:889
error("don't know how to compile a " .. tostring(key) .. " to " .. targetName) -- ./compiler/lua54.can:890
end }) -- ./compiler/lua54.can:890
targetName = "Lua 5.3" -- ./compiler/lua53.can:1
tags["AttributeId"] = function(t) -- ./compiler/lua53.can:4
if t[2] then -- ./compiler/lua53.can:5
error("target " .. targetName .. " does not support variable attributes") -- ./compiler/lua53.can:6
else -- ./compiler/lua53.can:6
return t[1] -- ./compiler/lua53.can:8
end -- ./compiler/lua53.can:8
end -- ./compiler/lua53.can:8
targetName = "Lua 5.2" -- ./compiler/lua52.can:1
APPEND = function(t, toAppend) -- ./compiler/lua52.can:3
return "do" .. indent() .. "local " .. var("a") .. ", " .. var("p") .. " = { " .. toAppend .. " }, #" .. t .. "+1" .. newline() .. "for i=1, #" .. var("a") .. " do" .. indent() .. t .. "[" .. var("p") .. "] = " .. var("a") .. "[i]" .. newline() .. "" .. var("p") .. " = " .. var("p") .. " + 1" .. unindent() .. "end" .. unindent() .. "end" -- ./compiler/lua52.can:4
end -- ./compiler/lua52.can:4
tags["_opid"]["idiv"] = function(left, right) -- ./compiler/lua52.can:7
return "math.floor(" .. lua(left) .. " / " .. lua(right) .. ")" -- ./compiler/lua52.can:8
end -- ./compiler/lua52.can:8
tags["_opid"]["band"] = function(left, right) -- ./compiler/lua52.can:10
return "bit32.band(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:11
end -- ./compiler/lua52.can:11
tags["_opid"]["bor"] = function(left, right) -- ./compiler/lua52.can:13
return "bit32.bor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:14
end -- ./compiler/lua52.can:14
tags["_opid"]["bxor"] = function(left, right) -- ./compiler/lua52.can:16
return "bit32.bxor(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:17
end -- ./compiler/lua52.can:17
tags["_opid"]["shl"] = function(left, right) -- ./compiler/lua52.can:19
return "bit32.lshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:20
end -- ./compiler/lua52.can:20
tags["_opid"]["shr"] = function(left, right) -- ./compiler/lua52.can:22
return "bit32.rshift(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/lua52.can:23
end -- ./compiler/lua52.can:23
tags["_opid"]["bnot"] = function(right) -- ./compiler/lua52.can:25
return "bit32.bnot(" .. lua(right) .. ")" -- ./compiler/lua52.can:26
end -- ./compiler/lua52.can:26
targetName = "LuaJIT" -- ./compiler/luajit.can:1
UNPACK = function(list, i, j) -- ./compiler/luajit.can:3
return "unpack(" .. list .. (i and (", " .. i .. (j and (", " .. j) or "")) or "") .. ")" -- ./compiler/luajit.can:4
end -- ./compiler/luajit.can:4
tags["_opid"]["band"] = function(left, right) -- ./compiler/luajit.can:7
addRequire("bit", "band", "band") -- ./compiler/luajit.can:8
return var("band") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.can:9
end -- ./compiler/luajit.can:9
tags["_opid"]["bor"] = function(left, right) -- ./compiler/luajit.can:11
addRequire("bit", "bor", "bor") -- ./compiler/luajit.can:12
return var("bor") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.can:13
end -- ./compiler/luajit.can:13
tags["_opid"]["bxor"] = function(left, right) -- ./compiler/luajit.can:15
addRequire("bit", "bxor", "bxor") -- ./compiler/luajit.can:16
return var("bxor") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.can:17
end -- ./compiler/luajit.can:17
tags["_opid"]["shl"] = function(left, right) -- ./compiler/luajit.can:19
addRequire("bit", "lshift", "lshift") -- ./compiler/luajit.can:20
return var("lshift") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.can:21
end -- ./compiler/luajit.can:21
tags["_opid"]["shr"] = function(left, right) -- ./compiler/luajit.can:23
addRequire("bit", "rshift", "rshift") -- ./compiler/luajit.can:24
return var("rshift") .. "(" .. lua(left) .. ", " .. lua(right) .. ")" -- ./compiler/luajit.can:25
end -- ./compiler/luajit.can:25
tags["_opid"]["bnot"] = function(right) -- ./compiler/luajit.can:27
addRequire("bit", "bnot", "bnot") -- ./compiler/luajit.can:28
return var("bnot") .. "(" .. lua(right) .. ")" -- ./compiler/luajit.can:29
end -- ./compiler/luajit.can:29
targetName = "Lua 5.1" -- ./compiler/lua51.can:1
states["continue"] = {} -- ./compiler/lua51.can:3
CONTINUE_START = function() -- ./compiler/lua51.can:5
return "local " .. var("break") .. newline() .. "repeat" .. indent() .. push("continue", var("break")) -- ./compiler/lua51.can:6
end -- ./compiler/lua51.can:6
CONTINUE_STOP = function() -- ./compiler/lua51.can:8
return pop("continue") .. unindent() .. "until true" .. newline() .. "if " .. var("break") .. " then break end" -- ./compiler/lua51.can:9
end -- ./compiler/lua51.can:9
tags["Continue"] = function() -- ./compiler/lua51.can:12
return "break" -- ./compiler/lua51.can:13
end -- ./compiler/lua51.can:13
tags["Break"] = function() -- ./compiler/lua51.can:15
local inContinue = peek("continue") -- ./compiler/lua51.can:16
if inContinue then -- ./compiler/lua51.can:17
return inContinue .. " = true" .. newline() .. "break" -- ./compiler/lua51.can:18
else -- ./compiler/lua51.can:18
return "break" -- ./compiler/lua51.can:20
end -- ./compiler/lua51.can:20
end -- ./compiler/lua51.can:20
tags["Goto"] = function() -- ./compiler/lua51.can:25
error("target " .. targetName .. " does not support gotos") -- ./compiler/lua51.can:26
end -- ./compiler/lua51.can:26
tags["Label"] = function() -- ./compiler/lua51.can:28
error("target " .. targetName .. " does not support goto labels") -- ./compiler/lua51.can:29
end -- ./compiler/lua51.can:29
local code = lua(ast) .. newline() -- ./compiler/lua54.can:896
return requireStr .. code -- ./compiler/lua54.can:897
end -- ./compiler/lua54.can:897
end -- ./compiler/lua54.can:897
local lua54 = _() or lua54 -- ./compiler/lua54.can:902
return lua54 -- ./compiler/lua53.can:18
end -- ./compiler/lua53.can:18
local lua53 = _() or lua53 -- ./compiler/lua53.can:22
return lua53 -- ./compiler/lua52.can:35
end -- ./compiler/lua52.can:35
local lua52 = _() or lua52 -- ./compiler/lua52.can:39
return lua52 -- ./compiler/luajit.can:38
end -- ./compiler/luajit.can:38
local luajit = _() or luajit -- ./compiler/luajit.can:42
return luajit -- ./compiler/lua51.can:38
end -- ./compiler/lua51.can:38
local lua51 = _() or lua51 -- ./compiler/lua51.can:42
package["loaded"]["compiler.lua51"] = lua51 or true -- ./compiler/lua51.can:43
local function _() -- ./compiler/lua51.can:47
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
local msg = "no visible label '%s' for <goto>" -- ./lepton/lpt-parser/validator.lua:51
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
error("expecting a variable, but got a " .. tag) -- ./lepton/lpt-parser/pp.lua:69
end -- ./lepton/lpt-parser/pp.lua:69
return str -- ./lepton/lpt-parser/pp.lua:71
end -- ./lepton/lpt-parser/pp.lua:71
varlist2str = function(varlist) -- ./lepton/lpt-parser/pp.lua:74
local l = {} -- ./lepton/lpt-parser/pp.lua:75
for k, v in ipairs(varlist) do -- ./lepton/lpt-parser/pp.lua:76
l[k] = var2str(v) -- ./lepton/lpt-parser/pp.lua:77
end -- ./lepton/lpt-parser/pp.lua:77
return "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:79
end -- ./lepton/lpt-parser/pp.lua:79
parlist2str = function(parlist) -- ./lepton/lpt-parser/pp.lua:82
local l = {} -- ./lepton/lpt-parser/pp.lua:83
local len = # parlist -- ./lepton/lpt-parser/pp.lua:84
local is_vararg = false -- ./lepton/lpt-parser/pp.lua:85
if len > 0 and parlist[len]["tag"] == "Dots" then -- ./lepton/lpt-parser/pp.lua:86
is_vararg = true -- ./lepton/lpt-parser/pp.lua:87
len = len - 1 -- ./lepton/lpt-parser/pp.lua:88
end -- ./lepton/lpt-parser/pp.lua:88
local i = 1 -- ./lepton/lpt-parser/pp.lua:90
while i <= len do -- ./lepton/lpt-parser/pp.lua:91
l[i] = var2str(parlist[i]) -- ./lepton/lpt-parser/pp.lua:92
i = i + 1 -- ./lepton/lpt-parser/pp.lua:93
end -- ./lepton/lpt-parser/pp.lua:93
if is_vararg then -- ./lepton/lpt-parser/pp.lua:95
l[i] = "`" .. parlist[i]["tag"] -- ./lepton/lpt-parser/pp.lua:96
end -- ./lepton/lpt-parser/pp.lua:96
return "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:98
end -- ./lepton/lpt-parser/pp.lua:98
fieldlist2str = function(fieldlist) -- ./lepton/lpt-parser/pp.lua:101
local l = {} -- ./lepton/lpt-parser/pp.lua:102
for k, v in ipairs(fieldlist) do -- ./lepton/lpt-parser/pp.lua:103
local tag = v["tag"] -- ./lepton/lpt-parser/pp.lua:104
if tag == "Pair" then -- ./lepton/lpt-parser/pp.lua:105
l[k] = "`" .. tag .. "{ " -- ./lepton/lpt-parser/pp.lua:106
l[k] = l[k] .. exp2str(v[1]) .. ", " .. exp2str(v[2]) -- ./lepton/lpt-parser/pp.lua:107
l[k] = l[k] .. " }" -- ./lepton/lpt-parser/pp.lua:108
else -- ./lepton/lpt-parser/pp.lua:108
l[k] = exp2str(v) -- ./lepton/lpt-parser/pp.lua:110
end -- ./lepton/lpt-parser/pp.lua:110
end -- ./lepton/lpt-parser/pp.lua:110
if # l > 0 then -- ./lepton/lpt-parser/pp.lua:113
return "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:114
else -- ./lepton/lpt-parser/pp.lua:114
return "" -- ./lepton/lpt-parser/pp.lua:116
end -- ./lepton/lpt-parser/pp.lua:116
end -- ./lepton/lpt-parser/pp.lua:116
exp2str = function(exp) -- ./lepton/lpt-parser/pp.lua:120
local tag = exp["tag"] -- ./lepton/lpt-parser/pp.lua:121
local str = "`" .. tag -- ./lepton/lpt-parser/pp.lua:122
if tag == "Nil" or tag == "Dots" then -- ./lepton/lpt-parser/pp.lua:124
 -- ./lepton/lpt-parser/pp.lua:125
elseif tag == "Boolean" then -- ./lepton/lpt-parser/pp.lua:125
str = str .. " " .. boolean2str(exp[1]) -- ./lepton/lpt-parser/pp.lua:126
elseif tag == "Number" then -- ./lepton/lpt-parser/pp.lua:127
str = str .. " " .. number2str(exp[1]) -- ./lepton/lpt-parser/pp.lua:128
elseif tag == "String" then -- ./lepton/lpt-parser/pp.lua:129
str = str .. " " .. string2str(exp[1]) -- ./lepton/lpt-parser/pp.lua:130
elseif tag == "Function" then -- ./lepton/lpt-parser/pp.lua:131
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:132
str = str .. parlist2str(exp[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:133
str = str .. block2str(exp[2]) -- ./lepton/lpt-parser/pp.lua:134
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:135
elseif tag == "Table" then -- ./lepton/lpt-parser/pp.lua:136
str = str .. fieldlist2str(exp) -- ./lepton/lpt-parser/pp.lua:137
elseif tag == "Op" then -- ./lepton/lpt-parser/pp.lua:138
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:139
str = str .. name2str(exp[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:140
str = str .. exp2str(exp[2]) -- ./lepton/lpt-parser/pp.lua:141
if exp[3] then -- ./lepton/lpt-parser/pp.lua:142
str = str .. ", " .. exp2str(exp[3]) -- ./lepton/lpt-parser/pp.lua:143
end -- ./lepton/lpt-parser/pp.lua:143
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:145
elseif tag == "Paren" then -- ./lepton/lpt-parser/pp.lua:146
str = str .. "{ " .. exp2str(exp[1]) .. " }" -- ./lepton/lpt-parser/pp.lua:147
elseif tag == "Call" then -- ./lepton/lpt-parser/pp.lua:148
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:149
str = str .. exp2str(exp[1]) -- ./lepton/lpt-parser/pp.lua:150
if exp[2] then -- ./lepton/lpt-parser/pp.lua:151
for i = 2, # exp do -- ./lepton/lpt-parser/pp.lua:152
str = str .. ", " .. exp2str(exp[i]) -- ./lepton/lpt-parser/pp.lua:153
end -- ./lepton/lpt-parser/pp.lua:153
end -- ./lepton/lpt-parser/pp.lua:153
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:156
elseif tag == "Invoke" then -- ./lepton/lpt-parser/pp.lua:157
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:158
str = str .. exp2str(exp[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:159
str = str .. exp2str(exp[2]) -- ./lepton/lpt-parser/pp.lua:160
if exp[3] then -- ./lepton/lpt-parser/pp.lua:161
for i = 3, # exp do -- ./lepton/lpt-parser/pp.lua:162
str = str .. ", " .. exp2str(exp[i]) -- ./lepton/lpt-parser/pp.lua:163
end -- ./lepton/lpt-parser/pp.lua:163
end -- ./lepton/lpt-parser/pp.lua:163
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:166
elseif tag == "Id" or tag == "Index" then -- ./lepton/lpt-parser/pp.lua:168
str = var2str(exp) -- ./lepton/lpt-parser/pp.lua:169
else -- ./lepton/lpt-parser/pp.lua:169
error("expecting an expression, but got a " .. tag) -- ./lepton/lpt-parser/pp.lua:171
end -- ./lepton/lpt-parser/pp.lua:171
return str -- ./lepton/lpt-parser/pp.lua:173
end -- ./lepton/lpt-parser/pp.lua:173
explist2str = function(explist) -- ./lepton/lpt-parser/pp.lua:176
local l = {} -- ./lepton/lpt-parser/pp.lua:177
for k, v in ipairs(explist) do -- ./lepton/lpt-parser/pp.lua:178
l[k] = exp2str(v) -- ./lepton/lpt-parser/pp.lua:179
end -- ./lepton/lpt-parser/pp.lua:179
if # l > 0 then -- ./lepton/lpt-parser/pp.lua:181
return "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:182
else -- ./lepton/lpt-parser/pp.lua:182
return "" -- ./lepton/lpt-parser/pp.lua:184
end -- ./lepton/lpt-parser/pp.lua:184
end -- ./lepton/lpt-parser/pp.lua:184
stm2str = function(stm) -- ./lepton/lpt-parser/pp.lua:188
local tag = stm["tag"] -- ./lepton/lpt-parser/pp.lua:189
local str = "`" .. tag -- ./lepton/lpt-parser/pp.lua:190
if tag == "Do" then -- ./lepton/lpt-parser/pp.lua:191
local l = {} -- ./lepton/lpt-parser/pp.lua:192
for k, v in ipairs(stm) do -- ./lepton/lpt-parser/pp.lua:193
l[k] = stm2str(v) -- ./lepton/lpt-parser/pp.lua:194
end -- ./lepton/lpt-parser/pp.lua:194
str = str .. "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:196
elseif tag == "Set" then -- ./lepton/lpt-parser/pp.lua:197
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:198
str = str .. varlist2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:199
str = str .. explist2str(stm[2]) -- ./lepton/lpt-parser/pp.lua:200
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:201
elseif tag == "While" then -- ./lepton/lpt-parser/pp.lua:202
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:203
str = str .. exp2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:204
str = str .. block2str(stm[2]) -- ./lepton/lpt-parser/pp.lua:205
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:206
elseif tag == "Repeat" then -- ./lepton/lpt-parser/pp.lua:207
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:208
str = str .. block2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:209
str = str .. exp2str(stm[2]) -- ./lepton/lpt-parser/pp.lua:210
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:211
elseif tag == "If" then -- ./lepton/lpt-parser/pp.lua:212
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:213
local len = # stm -- ./lepton/lpt-parser/pp.lua:214
if len % 2 == 0 then -- ./lepton/lpt-parser/pp.lua:215
local l = {} -- ./lepton/lpt-parser/pp.lua:216
for i = 1, len - 2, 2 do -- ./lepton/lpt-parser/pp.lua:217
str = str .. exp2str(stm[i]) .. ", " .. block2str(stm[i + 1]) .. ", " -- ./lepton/lpt-parser/pp.lua:218
end -- ./lepton/lpt-parser/pp.lua:218
str = str .. exp2str(stm[len - 1]) .. ", " .. block2str(stm[len]) -- ./lepton/lpt-parser/pp.lua:220
else -- ./lepton/lpt-parser/pp.lua:220
local l = {} -- ./lepton/lpt-parser/pp.lua:222
for i = 1, len - 3, 2 do -- ./lepton/lpt-parser/pp.lua:223
str = str .. exp2str(stm[i]) .. ", " .. block2str(stm[i + 1]) .. ", " -- ./lepton/lpt-parser/pp.lua:224
end -- ./lepton/lpt-parser/pp.lua:224
str = str .. exp2str(stm[len - 2]) .. ", " .. block2str(stm[len - 1]) .. ", " -- ./lepton/lpt-parser/pp.lua:226
str = str .. block2str(stm[len]) -- ./lepton/lpt-parser/pp.lua:227
end -- ./lepton/lpt-parser/pp.lua:227
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:229
elseif tag == "Fornum" then -- ./lepton/lpt-parser/pp.lua:230
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:231
str = str .. var2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:232
str = str .. exp2str(stm[2]) .. ", " -- ./lepton/lpt-parser/pp.lua:233
str = str .. exp2str(stm[3]) .. ", " -- ./lepton/lpt-parser/pp.lua:234
if stm[5] then -- ./lepton/lpt-parser/pp.lua:235
str = str .. exp2str(stm[4]) .. ", " -- ./lepton/lpt-parser/pp.lua:236
str = str .. block2str(stm[5]) -- ./lepton/lpt-parser/pp.lua:237
else -- ./lepton/lpt-parser/pp.lua:237
str = str .. block2str(stm[4]) -- ./lepton/lpt-parser/pp.lua:239
end -- ./lepton/lpt-parser/pp.lua:239
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:241
elseif tag == "Forin" then -- ./lepton/lpt-parser/pp.lua:242
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:243
str = str .. varlist2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:244
str = str .. explist2str(stm[2]) .. ", " -- ./lepton/lpt-parser/pp.lua:245
str = str .. block2str(stm[3]) -- ./lepton/lpt-parser/pp.lua:246
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:247
elseif tag == "Local" then -- ./lepton/lpt-parser/pp.lua:248
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:249
str = str .. varlist2str(stm[1]) -- ./lepton/lpt-parser/pp.lua:250
if # stm[2] > 0 then -- ./lepton/lpt-parser/pp.lua:251
str = str .. ", " .. explist2str(stm[2]) -- ./lepton/lpt-parser/pp.lua:252
else -- ./lepton/lpt-parser/pp.lua:252
str = str .. ", " .. "{  }" -- ./lepton/lpt-parser/pp.lua:254
end -- ./lepton/lpt-parser/pp.lua:254
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:256
elseif tag == "Localrec" then -- ./lepton/lpt-parser/pp.lua:257
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:258
str = str .. "{ " .. var2str(stm[1][1]) .. " }, " -- ./lepton/lpt-parser/pp.lua:259
str = str .. "{ " .. exp2str(stm[2][1]) .. " }" -- ./lepton/lpt-parser/pp.lua:260
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:261
elseif tag == "Goto" or tag == "Label" then -- ./lepton/lpt-parser/pp.lua:263
str = str .. "{ " .. name2str(stm[1]) .. " }" -- ./lepton/lpt-parser/pp.lua:264
elseif tag == "Return" then -- ./lepton/lpt-parser/pp.lua:265
str = str .. explist2str(stm) -- ./lepton/lpt-parser/pp.lua:266
elseif tag == "Break" then -- ./lepton/lpt-parser/pp.lua:267
 -- ./lepton/lpt-parser/pp.lua:268
elseif tag == "Call" then -- ./lepton/lpt-parser/pp.lua:268
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:269
str = str .. exp2str(stm[1]) -- ./lepton/lpt-parser/pp.lua:270
if stm[2] then -- ./lepton/lpt-parser/pp.lua:271
for i = 2, # stm do -- ./lepton/lpt-parser/pp.lua:272
str = str .. ", " .. exp2str(stm[i]) -- ./lepton/lpt-parser/pp.lua:273
end -- ./lepton/lpt-parser/pp.lua:273
end -- ./lepton/lpt-parser/pp.lua:273
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:276
elseif tag == "Invoke" then -- ./lepton/lpt-parser/pp.lua:277
str = str .. "{ " -- ./lepton/lpt-parser/pp.lua:278
str = str .. exp2str(stm[1]) .. ", " -- ./lepton/lpt-parser/pp.lua:279
str = str .. exp2str(stm[2]) -- ./lepton/lpt-parser/pp.lua:280
if stm[3] then -- ./lepton/lpt-parser/pp.lua:281
for i = 3, # stm do -- ./lepton/lpt-parser/pp.lua:282
str = str .. ", " .. exp2str(stm[i]) -- ./lepton/lpt-parser/pp.lua:283
end -- ./lepton/lpt-parser/pp.lua:283
end -- ./lepton/lpt-parser/pp.lua:283
str = str .. " }" -- ./lepton/lpt-parser/pp.lua:286
else -- ./lepton/lpt-parser/pp.lua:286
error("expecting a statement, but got a " .. tag) -- ./lepton/lpt-parser/pp.lua:288
end -- ./lepton/lpt-parser/pp.lua:288
return str -- ./lepton/lpt-parser/pp.lua:290
end -- ./lepton/lpt-parser/pp.lua:290
block2str = function(block) -- ./lepton/lpt-parser/pp.lua:293
local l = {} -- ./lepton/lpt-parser/pp.lua:294
for k, v in ipairs(block) do -- ./lepton/lpt-parser/pp.lua:295
l[k] = stm2str(v) -- ./lepton/lpt-parser/pp.lua:296
end -- ./lepton/lpt-parser/pp.lua:296
return "{ " .. table["concat"](l, ", ") .. " }" -- ./lepton/lpt-parser/pp.lua:298
end -- ./lepton/lpt-parser/pp.lua:298
pp["tostring"] = function(t) -- ./lepton/lpt-parser/pp.lua:301
assert(type(t) == "table") -- ./lepton/lpt-parser/pp.lua:302
return block2str(t) -- ./lepton/lpt-parser/pp.lua:303
end -- ./lepton/lpt-parser/pp.lua:303
pp["print"] = function(t) -- ./lepton/lpt-parser/pp.lua:306
assert(type(t) == "table") -- ./lepton/lpt-parser/pp.lua:307
print(pp["tostring"](t)) -- ./lepton/lpt-parser/pp.lua:308
end -- ./lepton/lpt-parser/pp.lua:308
pp["dump"] = function(t, i) -- ./lepton/lpt-parser/pp.lua:311
if i == nil then -- ./lepton/lpt-parser/pp.lua:312
i = 0 -- ./lepton/lpt-parser/pp.lua:312
end -- ./lepton/lpt-parser/pp.lua:312
io["write"](string["format"]("{\
")) -- ./lepton/lpt-parser/pp.lua:313
io["write"](string["format"]("%s[tag] = %s\
", string["rep"](" ", i + 2), t["tag"] or "nil")) -- ./lepton/lpt-parser/pp.lua:314
io["write"](string["format"]("%s[pos] = %s\
", string["rep"](" ", i + 2), t["pos"] or "nil")) -- ./lepton/lpt-parser/pp.lua:315
for k, v in ipairs(t) do -- ./lepton/lpt-parser/pp.lua:316
io["write"](string["format"]("%s[%s] = ", string["rep"](" ", i + 2), tostring(k))) -- ./lepton/lpt-parser/pp.lua:317
if type(v) == "table" then -- ./lepton/lpt-parser/pp.lua:318
pp["dump"](v, i + 2) -- ./lepton/lpt-parser/pp.lua:319
else -- ./lepton/lpt-parser/pp.lua:319
io["write"](string["format"]("%s\
", tostring(v))) -- ./lepton/lpt-parser/pp.lua:321
end -- ./lepton/lpt-parser/pp.lua:321
end -- ./lepton/lpt-parser/pp.lua:321
io["write"](string["format"]("%s}\
", string["rep"](" ", i))) -- ./lepton/lpt-parser/pp.lua:324
end -- ./lepton/lpt-parser/pp.lua:324
return pp -- ./lepton/lpt-parser/pp.lua:327
end -- ./lepton/lpt-parser/pp.lua:327
local pp = _() or pp -- ./lepton/lpt-parser/pp.lua:331
package["loaded"]["lepton.lpt-parser.pp"] = pp or true -- ./lepton/lpt-parser/pp.lua:332
local function _() -- ./lepton/lpt-parser/pp.lua:335
local lpeg = require("lpeglabel") -- ./lepton/lpt-parser/parser.lua:72
lpeg["locale"](lpeg) -- ./lepton/lpt-parser/parser.lua:74
local P, S, V = lpeg["P"], lpeg["S"], lpeg["V"] -- ./lepton/lpt-parser/parser.lua:76
local C, Carg, Cb, Cc = lpeg["C"], lpeg["Carg"], lpeg["Cb"], lpeg["Cc"] -- ./lepton/lpt-parser/parser.lua:77
local Cf, Cg, Cmt, Cp, Cs, Ct = lpeg["Cf"], lpeg["Cg"], lpeg["Cmt"], lpeg["Cp"], lpeg["Cs"], lpeg["Ct"] -- ./lepton/lpt-parser/parser.lua:78
local Rec, T = lpeg["Rec"], lpeg["T"] -- ./lepton/lpt-parser/parser.lua:79
local alpha, digit, alnum = lpeg["alpha"], lpeg["digit"], lpeg["alnum"] -- ./lepton/lpt-parser/parser.lua:81
local xdigit = lpeg["xdigit"] -- ./lepton/lpt-parser/parser.lua:82
local space = lpeg["space"] -- ./lepton/lpt-parser/parser.lua:83
local labels = { -- ./lepton/lpt-parser/parser.lua:86
{ -- ./lepton/lpt-parser/parser.lua:87
"ErrExtra", -- ./lepton/lpt-parser/parser.lua:87
"unexpected character(s), expected EOF" -- ./lepton/lpt-parser/parser.lua:87
}, -- ./lepton/lpt-parser/parser.lua:87
{ -- ./lepton/lpt-parser/parser.lua:88
"ErrInvalidStat", -- ./lepton/lpt-parser/parser.lua:88
"unexpected token, invalid start of statement" -- ./lepton/lpt-parser/parser.lua:88
}, -- ./lepton/lpt-parser/parser.lua:88
{ -- ./lepton/lpt-parser/parser.lua:90
"ErrEndIf", -- ./lepton/lpt-parser/parser.lua:90
"expected 'end' to close the if statement" -- ./lepton/lpt-parser/parser.lua:90
}, -- ./lepton/lpt-parser/parser.lua:90
{ -- ./lepton/lpt-parser/parser.lua:91
"ErrExprIf", -- ./lepton/lpt-parser/parser.lua:91
"expected a condition after 'if'" -- ./lepton/lpt-parser/parser.lua:91
}, -- ./lepton/lpt-parser/parser.lua:91
{ -- ./lepton/lpt-parser/parser.lua:92
"ErrThenIf", -- ./lepton/lpt-parser/parser.lua:92
"expected 'then' after the condition" -- ./lepton/lpt-parser/parser.lua:92
}, -- ./lepton/lpt-parser/parser.lua:92
{ -- ./lepton/lpt-parser/parser.lua:93
"ErrExprEIf", -- ./lepton/lpt-parser/parser.lua:93
"expected a condition after 'elseif'" -- ./lepton/lpt-parser/parser.lua:93
}, -- ./lepton/lpt-parser/parser.lua:93
{ -- ./lepton/lpt-parser/parser.lua:94
"ErrThenEIf", -- ./lepton/lpt-parser/parser.lua:94
"expected 'then' after the condition" -- ./lepton/lpt-parser/parser.lua:94
}, -- ./lepton/lpt-parser/parser.lua:94
{ -- ./lepton/lpt-parser/parser.lua:96
"ErrEndDo", -- ./lepton/lpt-parser/parser.lua:96
"expected 'end' to close the do block" -- ./lepton/lpt-parser/parser.lua:96
}, -- ./lepton/lpt-parser/parser.lua:96
{ -- ./lepton/lpt-parser/parser.lua:97
"ErrExprWhile", -- ./lepton/lpt-parser/parser.lua:97
"expected a condition after 'while'" -- ./lepton/lpt-parser/parser.lua:97
}, -- ./lepton/lpt-parser/parser.lua:97
{ -- ./lepton/lpt-parser/parser.lua:98
"ErrDoWhile", -- ./lepton/lpt-parser/parser.lua:98
"expected 'do' after the condition" -- ./lepton/lpt-parser/parser.lua:98
}, -- ./lepton/lpt-parser/parser.lua:98
{ -- ./lepton/lpt-parser/parser.lua:99
"ErrEndWhile", -- ./lepton/lpt-parser/parser.lua:99
"expected 'end' to close the while loop" -- ./lepton/lpt-parser/parser.lua:99
}, -- ./lepton/lpt-parser/parser.lua:99
{ -- ./lepton/lpt-parser/parser.lua:100
"ErrUntilRep", -- ./lepton/lpt-parser/parser.lua:100
"expected 'until' at the end of the repeat loop" -- ./lepton/lpt-parser/parser.lua:100
}, -- ./lepton/lpt-parser/parser.lua:100
{ -- ./lepton/lpt-parser/parser.lua:101
"ErrExprRep", -- ./lepton/lpt-parser/parser.lua:101
"expected a conditions after 'until'" -- ./lepton/lpt-parser/parser.lua:101
}, -- ./lepton/lpt-parser/parser.lua:101
{ -- ./lepton/lpt-parser/parser.lua:103
"ErrForRange", -- ./lepton/lpt-parser/parser.lua:103
"expected a numeric or generic range after 'for'" -- ./lepton/lpt-parser/parser.lua:103
}, -- ./lepton/lpt-parser/parser.lua:103
{ -- ./lepton/lpt-parser/parser.lua:104
"ErrEndFor", -- ./lepton/lpt-parser/parser.lua:104
"expected 'end' to close the for loop" -- ./lepton/lpt-parser/parser.lua:104
}, -- ./lepton/lpt-parser/parser.lua:104
{ -- ./lepton/lpt-parser/parser.lua:105
"ErrExprFor1", -- ./lepton/lpt-parser/parser.lua:105
"expected a starting expression for the numeric range" -- ./lepton/lpt-parser/parser.lua:105
}, -- ./lepton/lpt-parser/parser.lua:105
{ -- ./lepton/lpt-parser/parser.lua:106
"ErrCommaFor", -- ./lepton/lpt-parser/parser.lua:106
"expected ',' to split the start and end of the range" -- ./lepton/lpt-parser/parser.lua:106
}, -- ./lepton/lpt-parser/parser.lua:106
{ -- ./lepton/lpt-parser/parser.lua:107
"ErrExprFor2", -- ./lepton/lpt-parser/parser.lua:107
"expected an ending expression for the numeric range" -- ./lepton/lpt-parser/parser.lua:107
}, -- ./lepton/lpt-parser/parser.lua:107
{ -- ./lepton/lpt-parser/parser.lua:108
"ErrExprFor3", -- ./lepton/lpt-parser/parser.lua:108
"expected a step expression for the numeric range after ','" -- ./lepton/lpt-parser/parser.lua:108
}, -- ./lepton/lpt-parser/parser.lua:108
{ -- ./lepton/lpt-parser/parser.lua:109
"ErrInFor", -- ./lepton/lpt-parser/parser.lua:109
"expected '=' or 'in' after the variable(s)" -- ./lepton/lpt-parser/parser.lua:109
}, -- ./lepton/lpt-parser/parser.lua:109
{ -- ./lepton/lpt-parser/parser.lua:110
"ErrEListFor", -- ./lepton/lpt-parser/parser.lua:110
"expected one or more expressions after 'in'" -- ./lepton/lpt-parser/parser.lua:110
}, -- ./lepton/lpt-parser/parser.lua:110
{ -- ./lepton/lpt-parser/parser.lua:111
"ErrDoFor", -- ./lepton/lpt-parser/parser.lua:111
"expected 'do' after the range of the for loop" -- ./lepton/lpt-parser/parser.lua:111
}, -- ./lepton/lpt-parser/parser.lua:111
{ -- ./lepton/lpt-parser/parser.lua:113
"ErrDefLocal", -- ./lepton/lpt-parser/parser.lua:113
"expected a function definition or assignment after local" -- ./lepton/lpt-parser/parser.lua:113
}, -- ./lepton/lpt-parser/parser.lua:113
{ -- ./lepton/lpt-parser/parser.lua:114
"ErrDefLet", -- ./lepton/lpt-parser/parser.lua:114
"expected an assignment after let" -- ./lepton/lpt-parser/parser.lua:114
}, -- ./lepton/lpt-parser/parser.lua:114
{ -- ./lepton/lpt-parser/parser.lua:115
"ErrDefClose", -- ./lepton/lpt-parser/parser.lua:115
"expected an assignment after close" -- ./lepton/lpt-parser/parser.lua:115
}, -- ./lepton/lpt-parser/parser.lua:115
{ -- ./lepton/lpt-parser/parser.lua:116
"ErrDefConst", -- ./lepton/lpt-parser/parser.lua:116
"expected an assignment after const" -- ./lepton/lpt-parser/parser.lua:116
}, -- ./lepton/lpt-parser/parser.lua:116
{ -- ./lepton/lpt-parser/parser.lua:117
"ErrNameLFunc", -- ./lepton/lpt-parser/parser.lua:117
"expected a function name after 'function'" -- ./lepton/lpt-parser/parser.lua:117
}, -- ./lepton/lpt-parser/parser.lua:117
{ -- ./lepton/lpt-parser/parser.lua:118
"ErrEListLAssign", -- ./lepton/lpt-parser/parser.lua:118
"expected one or more expressions after '='" -- ./lepton/lpt-parser/parser.lua:118
}, -- ./lepton/lpt-parser/parser.lua:118
{ -- ./lepton/lpt-parser/parser.lua:119
"ErrEListAssign", -- ./lepton/lpt-parser/parser.lua:119
"expected one or more expressions after '='" -- ./lepton/lpt-parser/parser.lua:119
}, -- ./lepton/lpt-parser/parser.lua:119
{ -- ./lepton/lpt-parser/parser.lua:121
"ErrFuncName", -- ./lepton/lpt-parser/parser.lua:121
"expected a function name after 'function'" -- ./lepton/lpt-parser/parser.lua:121
}, -- ./lepton/lpt-parser/parser.lua:121
{ -- ./lepton/lpt-parser/parser.lua:122
"ErrNameFunc1", -- ./lepton/lpt-parser/parser.lua:122
"expected a function name after '.'" -- ./lepton/lpt-parser/parser.lua:122
}, -- ./lepton/lpt-parser/parser.lua:122
{ -- ./lepton/lpt-parser/parser.lua:123
"ErrNameFunc2", -- ./lepton/lpt-parser/parser.lua:123
"expected a method name after ':'" -- ./lepton/lpt-parser/parser.lua:123
}, -- ./lepton/lpt-parser/parser.lua:123
{ -- ./lepton/lpt-parser/parser.lua:124
"ErrOParenPList", -- ./lepton/lpt-parser/parser.lua:124
"expected '(' for the parameter list" -- ./lepton/lpt-parser/parser.lua:124
}, -- ./lepton/lpt-parser/parser.lua:124
{ -- ./lepton/lpt-parser/parser.lua:125
"ErrCParenPList", -- ./lepton/lpt-parser/parser.lua:125
"expected ')' to close the parameter list" -- ./lepton/lpt-parser/parser.lua:125
}, -- ./lepton/lpt-parser/parser.lua:125
{ -- ./lepton/lpt-parser/parser.lua:126
"ErrEndFunc", -- ./lepton/lpt-parser/parser.lua:126
"expected 'end' to close the function body" -- ./lepton/lpt-parser/parser.lua:126
}, -- ./lepton/lpt-parser/parser.lua:126
{ -- ./lepton/lpt-parser/parser.lua:127
"ErrParList", -- ./lepton/lpt-parser/parser.lua:127
"expected a variable name or '...' after ','" -- ./lepton/lpt-parser/parser.lua:127
}, -- ./lepton/lpt-parser/parser.lua:127
{ -- ./lepton/lpt-parser/parser.lua:129
"ErrLabel", -- ./lepton/lpt-parser/parser.lua:129
"expected a label name after '::'" -- ./lepton/lpt-parser/parser.lua:129
}, -- ./lepton/lpt-parser/parser.lua:129
{ -- ./lepton/lpt-parser/parser.lua:130
"ErrCloseLabel", -- ./lepton/lpt-parser/parser.lua:130
"expected '::' after the label" -- ./lepton/lpt-parser/parser.lua:130
}, -- ./lepton/lpt-parser/parser.lua:130
{ -- ./lepton/lpt-parser/parser.lua:131
"ErrGoto", -- ./lepton/lpt-parser/parser.lua:131
"expected a label after 'goto'" -- ./lepton/lpt-parser/parser.lua:131
}, -- ./lepton/lpt-parser/parser.lua:131
{ -- ./lepton/lpt-parser/parser.lua:132
"ErrRetList", -- ./lepton/lpt-parser/parser.lua:132
"expected an expression after ',' in the return statement" -- ./lepton/lpt-parser/parser.lua:132
}, -- ./lepton/lpt-parser/parser.lua:132
{ -- ./lepton/lpt-parser/parser.lua:134
"ErrVarList", -- ./lepton/lpt-parser/parser.lua:134
"expected a variable name after ','" -- ./lepton/lpt-parser/parser.lua:134
}, -- ./lepton/lpt-parser/parser.lua:134
{ -- ./lepton/lpt-parser/parser.lua:135
"ErrExprList", -- ./lepton/lpt-parser/parser.lua:135
"expected an expression after ','" -- ./lepton/lpt-parser/parser.lua:135
}, -- ./lepton/lpt-parser/parser.lua:135
{ -- ./lepton/lpt-parser/parser.lua:137
"ErrOrExpr", -- ./lepton/lpt-parser/parser.lua:137
"expected an expression after 'or'" -- ./lepton/lpt-parser/parser.lua:137
}, -- ./lepton/lpt-parser/parser.lua:137
{ -- ./lepton/lpt-parser/parser.lua:138
"ErrAndExpr", -- ./lepton/lpt-parser/parser.lua:138
"expected an expression after 'and'" -- ./lepton/lpt-parser/parser.lua:138
}, -- ./lepton/lpt-parser/parser.lua:138
{ -- ./lepton/lpt-parser/parser.lua:139
"ErrRelExpr", -- ./lepton/lpt-parser/parser.lua:139
"expected an expression after the relational operator" -- ./lepton/lpt-parser/parser.lua:139
}, -- ./lepton/lpt-parser/parser.lua:139
{ -- ./lepton/lpt-parser/parser.lua:140
"ErrBOrExpr", -- ./lepton/lpt-parser/parser.lua:140
"expected an expression after '|'" -- ./lepton/lpt-parser/parser.lua:140
}, -- ./lepton/lpt-parser/parser.lua:140
{ -- ./lepton/lpt-parser/parser.lua:141
"ErrBXorExpr", -- ./lepton/lpt-parser/parser.lua:141
"expected an expression after '~'" -- ./lepton/lpt-parser/parser.lua:141
}, -- ./lepton/lpt-parser/parser.lua:141
{ -- ./lepton/lpt-parser/parser.lua:142
"ErrBAndExpr", -- ./lepton/lpt-parser/parser.lua:142
"expected an expression after '&'" -- ./lepton/lpt-parser/parser.lua:142
}, -- ./lepton/lpt-parser/parser.lua:142
{ -- ./lepton/lpt-parser/parser.lua:143
"ErrShiftExpr", -- ./lepton/lpt-parser/parser.lua:143
"expected an expression after the bit shift" -- ./lepton/lpt-parser/parser.lua:143
}, -- ./lepton/lpt-parser/parser.lua:143
{ -- ./lepton/lpt-parser/parser.lua:144
"ErrConcatExpr", -- ./lepton/lpt-parser/parser.lua:144
"expected an expression after '..'" -- ./lepton/lpt-parser/parser.lua:144
}, -- ./lepton/lpt-parser/parser.lua:144
{ -- ./lepton/lpt-parser/parser.lua:145
"ErrAddExpr", -- ./lepton/lpt-parser/parser.lua:145
"expected an expression after the additive operator" -- ./lepton/lpt-parser/parser.lua:145
}, -- ./lepton/lpt-parser/parser.lua:145
{ -- ./lepton/lpt-parser/parser.lua:146
"ErrMulExpr", -- ./lepton/lpt-parser/parser.lua:146
"expected an expression after the multiplicative operator" -- ./lepton/lpt-parser/parser.lua:146
}, -- ./lepton/lpt-parser/parser.lua:146
{ -- ./lepton/lpt-parser/parser.lua:147
"ErrUnaryExpr", -- ./lepton/lpt-parser/parser.lua:147
"expected an expression after the unary operator" -- ./lepton/lpt-parser/parser.lua:147
}, -- ./lepton/lpt-parser/parser.lua:147
{ -- ./lepton/lpt-parser/parser.lua:148
"ErrPowExpr", -- ./lepton/lpt-parser/parser.lua:148
"expected an expression after '^'" -- ./lepton/lpt-parser/parser.lua:148
}, -- ./lepton/lpt-parser/parser.lua:148
{ -- ./lepton/lpt-parser/parser.lua:150
"ErrExprParen", -- ./lepton/lpt-parser/parser.lua:150
"expected an expression after '('" -- ./lepton/lpt-parser/parser.lua:150
}, -- ./lepton/lpt-parser/parser.lua:150
{ -- ./lepton/lpt-parser/parser.lua:151
"ErrCParenExpr", -- ./lepton/lpt-parser/parser.lua:151
"expected ')' to close the expression" -- ./lepton/lpt-parser/parser.lua:151
}, -- ./lepton/lpt-parser/parser.lua:151
{ -- ./lepton/lpt-parser/parser.lua:152
"ErrNameIndex", -- ./lepton/lpt-parser/parser.lua:152
"expected a field name after '.'" -- ./lepton/lpt-parser/parser.lua:152
}, -- ./lepton/lpt-parser/parser.lua:152
{ -- ./lepton/lpt-parser/parser.lua:153
"ErrExprIndex", -- ./lepton/lpt-parser/parser.lua:153
"expected an expression after '['" -- ./lepton/lpt-parser/parser.lua:153
}, -- ./lepton/lpt-parser/parser.lua:153
{ -- ./lepton/lpt-parser/parser.lua:154
"ErrCBracketIndex", -- ./lepton/lpt-parser/parser.lua:154
"expected ']' to close the indexing expression" -- ./lepton/lpt-parser/parser.lua:154
}, -- ./lepton/lpt-parser/parser.lua:154
{ -- ./lepton/lpt-parser/parser.lua:155
"ErrNameMeth", -- ./lepton/lpt-parser/parser.lua:155
"expected a method name after ':'" -- ./lepton/lpt-parser/parser.lua:155
}, -- ./lepton/lpt-parser/parser.lua:155
{ -- ./lepton/lpt-parser/parser.lua:156
"ErrMethArgs", -- ./lepton/lpt-parser/parser.lua:156
"expected some arguments for the method call (or '()')" -- ./lepton/lpt-parser/parser.lua:156
}, -- ./lepton/lpt-parser/parser.lua:156
{ -- ./lepton/lpt-parser/parser.lua:158
"ErrArgList", -- ./lepton/lpt-parser/parser.lua:158
"expected an expression after ',' in the argument list" -- ./lepton/lpt-parser/parser.lua:158
}, -- ./lepton/lpt-parser/parser.lua:158
{ -- ./lepton/lpt-parser/parser.lua:159
"ErrCParenArgs", -- ./lepton/lpt-parser/parser.lua:159
"expected ')' to close the argument list" -- ./lepton/lpt-parser/parser.lua:159
}, -- ./lepton/lpt-parser/parser.lua:159
{ -- ./lepton/lpt-parser/parser.lua:161
"ErrCBraceTable", -- ./lepton/lpt-parser/parser.lua:161
"expected '}' to close the table constructor" -- ./lepton/lpt-parser/parser.lua:161
}, -- ./lepton/lpt-parser/parser.lua:161
{ -- ./lepton/lpt-parser/parser.lua:162
"ErrEqField", -- ./lepton/lpt-parser/parser.lua:162
"expected '=' after the table key" -- ./lepton/lpt-parser/parser.lua:162
}, -- ./lepton/lpt-parser/parser.lua:162
{ -- ./lepton/lpt-parser/parser.lua:163
"ErrExprField", -- ./lepton/lpt-parser/parser.lua:163
"expected an expression after '='" -- ./lepton/lpt-parser/parser.lua:163
}, -- ./lepton/lpt-parser/parser.lua:163
{ -- ./lepton/lpt-parser/parser.lua:164
"ErrExprFKey", -- ./lepton/lpt-parser/parser.lua:164
"expected an expression after '[' for the table key" -- ./lepton/lpt-parser/parser.lua:164
}, -- ./lepton/lpt-parser/parser.lua:164
{ -- ./lepton/lpt-parser/parser.lua:165
"ErrCBracketFKey", -- ./lepton/lpt-parser/parser.lua:165
"expected ']' to close the table key" -- ./lepton/lpt-parser/parser.lua:165
}, -- ./lepton/lpt-parser/parser.lua:165
{ -- ./lepton/lpt-parser/parser.lua:167
"ErrCBraceDestructuring", -- ./lepton/lpt-parser/parser.lua:167
"expected '}' to close the destructuring variable list" -- ./lepton/lpt-parser/parser.lua:167
}, -- ./lepton/lpt-parser/parser.lua:167
{ -- ./lepton/lpt-parser/parser.lua:168
"ErrDestructuringEqField", -- ./lepton/lpt-parser/parser.lua:168
"expected '=' after the table key in destructuring variable list" -- ./lepton/lpt-parser/parser.lua:168
}, -- ./lepton/lpt-parser/parser.lua:168
{ -- ./lepton/lpt-parser/parser.lua:169
"ErrDestructuringExprField", -- ./lepton/lpt-parser/parser.lua:169
"expected an identifier after '=' in destructuring variable list" -- ./lepton/lpt-parser/parser.lua:169
}, -- ./lepton/lpt-parser/parser.lua:169
{ -- ./lepton/lpt-parser/parser.lua:171
"ErrCBracketTableCompr", -- ./lepton/lpt-parser/parser.lua:171
"expected ']' to close the table comprehension" -- ./lepton/lpt-parser/parser.lua:171
}, -- ./lepton/lpt-parser/parser.lua:171
{ -- ./lepton/lpt-parser/parser.lua:173
"ErrDigitHex", -- ./lepton/lpt-parser/parser.lua:173
"expected one or more hexadecimal digits after '0x'" -- ./lepton/lpt-parser/parser.lua:173
}, -- ./lepton/lpt-parser/parser.lua:173
{ -- ./lepton/lpt-parser/parser.lua:174
"ErrDigitDeci", -- ./lepton/lpt-parser/parser.lua:174
"expected one or more digits after the decimal point" -- ./lepton/lpt-parser/parser.lua:174
}, -- ./lepton/lpt-parser/parser.lua:174
{ -- ./lepton/lpt-parser/parser.lua:175
"ErrDigitExpo", -- ./lepton/lpt-parser/parser.lua:175
"expected one or more digits for the exponent" -- ./lepton/lpt-parser/parser.lua:175
}, -- ./lepton/lpt-parser/parser.lua:175
{ -- ./lepton/lpt-parser/parser.lua:177
"ErrQuote", -- ./lepton/lpt-parser/parser.lua:177
"unclosed string" -- ./lepton/lpt-parser/parser.lua:177
}, -- ./lepton/lpt-parser/parser.lua:177
{ -- ./lepton/lpt-parser/parser.lua:178
"ErrHexEsc", -- ./lepton/lpt-parser/parser.lua:178
"expected exactly two hexadecimal digits after '\\x'" -- ./lepton/lpt-parser/parser.lua:178
}, -- ./lepton/lpt-parser/parser.lua:178
{ -- ./lepton/lpt-parser/parser.lua:179
"ErrOBraceUEsc", -- ./lepton/lpt-parser/parser.lua:179
"expected '{' after '\\u'" -- ./lepton/lpt-parser/parser.lua:179
}, -- ./lepton/lpt-parser/parser.lua:179
{ -- ./lepton/lpt-parser/parser.lua:180
"ErrDigitUEsc", -- ./lepton/lpt-parser/parser.lua:180
"expected one or more hexadecimal digits for the UTF-8 code point" -- ./lepton/lpt-parser/parser.lua:180
}, -- ./lepton/lpt-parser/parser.lua:180
{ -- ./lepton/lpt-parser/parser.lua:181
"ErrCBraceUEsc", -- ./lepton/lpt-parser/parser.lua:181
"expected '}' after the code point" -- ./lepton/lpt-parser/parser.lua:181
}, -- ./lepton/lpt-parser/parser.lua:181
{ -- ./lepton/lpt-parser/parser.lua:182
"ErrEscSeq", -- ./lepton/lpt-parser/parser.lua:182
"invalid escape sequence" -- ./lepton/lpt-parser/parser.lua:182
}, -- ./lepton/lpt-parser/parser.lua:182
{ -- ./lepton/lpt-parser/parser.lua:183
"ErrCloseLStr", -- ./lepton/lpt-parser/parser.lua:183
"unclosed long string" -- ./lepton/lpt-parser/parser.lua:183
}, -- ./lepton/lpt-parser/parser.lua:183
{ -- ./lepton/lpt-parser/parser.lua:185
"ErrUnknownAttribute", -- ./lepton/lpt-parser/parser.lua:185
"unknown variable attribute" -- ./lepton/lpt-parser/parser.lua:185
}, -- ./lepton/lpt-parser/parser.lua:185
{ -- ./lepton/lpt-parser/parser.lua:186
"ErrCBracketAttribute", -- ./lepton/lpt-parser/parser.lua:186
"expected '>' to close the variable attribute" -- ./lepton/lpt-parser/parser.lua:186
} -- ./lepton/lpt-parser/parser.lua:186
} -- ./lepton/lpt-parser/parser.lua:186
local function throw(label) -- ./lepton/lpt-parser/parser.lua:189
label = "Err" .. label -- ./lepton/lpt-parser/parser.lua:190
for i, labelinfo in ipairs(labels) do -- ./lepton/lpt-parser/parser.lua:191
if labelinfo[1] == label then -- ./lepton/lpt-parser/parser.lua:192
return T(i) -- ./lepton/lpt-parser/parser.lua:193
end -- ./lepton/lpt-parser/parser.lua:193
end -- ./lepton/lpt-parser/parser.lua:193
error("Label not found: " .. label) -- ./lepton/lpt-parser/parser.lua:197
end -- ./lepton/lpt-parser/parser.lua:197
local function expect(patt, label) -- ./lepton/lpt-parser/parser.lua:200
return patt + throw(label) -- ./lepton/lpt-parser/parser.lua:201
end -- ./lepton/lpt-parser/parser.lua:201
local function token(patt) -- ./lepton/lpt-parser/parser.lua:206
return patt * V("Skip") -- ./lepton/lpt-parser/parser.lua:207
end -- ./lepton/lpt-parser/parser.lua:207
local function sym(str) -- ./lepton/lpt-parser/parser.lua:210
return token(P(str)) -- ./lepton/lpt-parser/parser.lua:211
end -- ./lepton/lpt-parser/parser.lua:211
local function kw(str) -- ./lepton/lpt-parser/parser.lua:214
return token(P(str) * - V("IdRest")) -- ./lepton/lpt-parser/parser.lua:215
end -- ./lepton/lpt-parser/parser.lua:215
local function tagC(tag, patt) -- ./lepton/lpt-parser/parser.lua:218
return Ct(Cg(Cp(), "pos") * Cg(Cc(tag), "tag") * patt) -- ./lepton/lpt-parser/parser.lua:219
end -- ./lepton/lpt-parser/parser.lua:219
local function unaryOp(op, e) -- ./lepton/lpt-parser/parser.lua:222
return { -- ./lepton/lpt-parser/parser.lua:223
["tag"] = "Op", -- ./lepton/lpt-parser/parser.lua:223
["pos"] = e["pos"], -- ./lepton/lpt-parser/parser.lua:223
[1] = op, -- ./lepton/lpt-parser/parser.lua:223
[2] = e -- ./lepton/lpt-parser/parser.lua:223
} -- ./lepton/lpt-parser/parser.lua:223
end -- ./lepton/lpt-parser/parser.lua:223
local function binaryOp(e1, op, e2) -- ./lepton/lpt-parser/parser.lua:226
if not op then -- ./lepton/lpt-parser/parser.lua:227
return e1 -- ./lepton/lpt-parser/parser.lua:228
else -- ./lepton/lpt-parser/parser.lua:228
return { -- ./lepton/lpt-parser/parser.lua:230
["tag"] = "Op", -- ./lepton/lpt-parser/parser.lua:230
["pos"] = e1["pos"], -- ./lepton/lpt-parser/parser.lua:230
[1] = op, -- ./lepton/lpt-parser/parser.lua:230
[2] = e1, -- ./lepton/lpt-parser/parser.lua:230
[3] = e2 -- ./lepton/lpt-parser/parser.lua:230
} -- ./lepton/lpt-parser/parser.lua:230
end -- ./lepton/lpt-parser/parser.lua:230
end -- ./lepton/lpt-parser/parser.lua:230
local function sepBy(patt, sep, label) -- ./lepton/lpt-parser/parser.lua:234
if label then -- ./lepton/lpt-parser/parser.lua:235
return patt * Cg(sep * expect(patt, label)) ^ 0 -- ./lepton/lpt-parser/parser.lua:236
else -- ./lepton/lpt-parser/parser.lua:236
return patt * Cg(sep * patt) ^ 0 -- ./lepton/lpt-parser/parser.lua:238
end -- ./lepton/lpt-parser/parser.lua:238
end -- ./lepton/lpt-parser/parser.lua:238
local function chainOp(patt, sep, label) -- ./lepton/lpt-parser/parser.lua:242
return Cf(sepBy(patt, sep, label), binaryOp) -- ./lepton/lpt-parser/parser.lua:243
end -- ./lepton/lpt-parser/parser.lua:243
local function commaSep(patt, label) -- ./lepton/lpt-parser/parser.lua:246
return sepBy(patt, sym(","), label) -- ./lepton/lpt-parser/parser.lua:247
end -- ./lepton/lpt-parser/parser.lua:247
local function tagDo(block) -- ./lepton/lpt-parser/parser.lua:250
block["tag"] = "Do" -- ./lepton/lpt-parser/parser.lua:251
return block -- ./lepton/lpt-parser/parser.lua:252
end -- ./lepton/lpt-parser/parser.lua:252
local function fixFuncStat(func) -- ./lepton/lpt-parser/parser.lua:255
if func[1]["is_method"] then -- ./lepton/lpt-parser/parser.lua:256
table["insert"](func[2][1], 1, { -- ./lepton/lpt-parser/parser.lua:256
["tag"] = "Id", -- ./lepton/lpt-parser/parser.lua:256
[1] = "self" -- ./lepton/lpt-parser/parser.lua:256
}) -- ./lepton/lpt-parser/parser.lua:256
end -- ./lepton/lpt-parser/parser.lua:256
func[1] = { func[1] } -- ./lepton/lpt-parser/parser.lua:257
func[2] = { func[2] } -- ./lepton/lpt-parser/parser.lua:258
return func -- ./lepton/lpt-parser/parser.lua:259
end -- ./lepton/lpt-parser/parser.lua:259
local function addDots(params, dots) -- ./lepton/lpt-parser/parser.lua:262
if dots then -- ./lepton/lpt-parser/parser.lua:263
table["insert"](params, dots) -- ./lepton/lpt-parser/parser.lua:263
end -- ./lepton/lpt-parser/parser.lua:263
return params -- ./lepton/lpt-parser/parser.lua:264
end -- ./lepton/lpt-parser/parser.lua:264
local function insertIndex(t, index) -- ./lepton/lpt-parser/parser.lua:267
return { -- ./lepton/lpt-parser/parser.lua:268
["tag"] = "Index", -- ./lepton/lpt-parser/parser.lua:268
["pos"] = t["pos"], -- ./lepton/lpt-parser/parser.lua:268
[1] = t, -- ./lepton/lpt-parser/parser.lua:268
[2] = index -- ./lepton/lpt-parser/parser.lua:268
} -- ./lepton/lpt-parser/parser.lua:268
end -- ./lepton/lpt-parser/parser.lua:268
local function markMethod(t, method) -- ./lepton/lpt-parser/parser.lua:271
if method then -- ./lepton/lpt-parser/parser.lua:272
return { -- ./lepton/lpt-parser/parser.lua:273
["tag"] = "Index", -- ./lepton/lpt-parser/parser.lua:273
["pos"] = t["pos"], -- ./lepton/lpt-parser/parser.lua:273
["is_method"] = true, -- ./lepton/lpt-parser/parser.lua:273
[1] = t, -- ./lepton/lpt-parser/parser.lua:273
[2] = method -- ./lepton/lpt-parser/parser.lua:273
} -- ./lepton/lpt-parser/parser.lua:273
end -- ./lepton/lpt-parser/parser.lua:273
return t -- ./lepton/lpt-parser/parser.lua:275
end -- ./lepton/lpt-parser/parser.lua:275
local function makeSuffixedExpr(t1, t2) -- ./lepton/lpt-parser/parser.lua:278
if t2["tag"] == "Call" or t2["tag"] == "SafeCall" then -- ./lepton/lpt-parser/parser.lua:279
local t = { -- ./lepton/lpt-parser/parser.lua:280
["tag"] = t2["tag"], -- ./lepton/lpt-parser/parser.lua:280
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:280
[1] = t1 -- ./lepton/lpt-parser/parser.lua:280
} -- ./lepton/lpt-parser/parser.lua:280
for k, v in ipairs(t2) do -- ./lepton/lpt-parser/parser.lua:281
table["insert"](t, v) -- ./lepton/lpt-parser/parser.lua:282
end -- ./lepton/lpt-parser/parser.lua:282
return t -- ./lepton/lpt-parser/parser.lua:284
elseif t2["tag"] == "MethodStub" or t2["tag"] == "SafeMethodStub" then -- ./lepton/lpt-parser/parser.lua:285
return { -- ./lepton/lpt-parser/parser.lua:286
["tag"] = t2["tag"], -- ./lepton/lpt-parser/parser.lua:286
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:286
[1] = t1, -- ./lepton/lpt-parser/parser.lua:286
[2] = t2[1] -- ./lepton/lpt-parser/parser.lua:286
} -- ./lepton/lpt-parser/parser.lua:286
elseif t2["tag"] == "SafeDotIndex" or t2["tag"] == "SafeArrayIndex" then -- ./lepton/lpt-parser/parser.lua:287
return { -- ./lepton/lpt-parser/parser.lua:288
["tag"] = "SafeIndex", -- ./lepton/lpt-parser/parser.lua:288
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:288
[1] = t1, -- ./lepton/lpt-parser/parser.lua:288
[2] = t2[1] -- ./lepton/lpt-parser/parser.lua:288
} -- ./lepton/lpt-parser/parser.lua:288
elseif t2["tag"] == "DotIndex" or t2["tag"] == "ArrayIndex" then -- ./lepton/lpt-parser/parser.lua:289
return { -- ./lepton/lpt-parser/parser.lua:290
["tag"] = "Index", -- ./lepton/lpt-parser/parser.lua:290
["pos"] = t1["pos"], -- ./lepton/lpt-parser/parser.lua:290
[1] = t1, -- ./lepton/lpt-parser/parser.lua:290
[2] = t2[1] -- ./lepton/lpt-parser/parser.lua:290
} -- ./lepton/lpt-parser/parser.lua:290
else -- ./lepton/lpt-parser/parser.lua:290
error("unexpected tag in suffixed expression") -- ./lepton/lpt-parser/parser.lua:292
end -- ./lepton/lpt-parser/parser.lua:292
end -- ./lepton/lpt-parser/parser.lua:292
local function fixShortFunc(t) -- ./lepton/lpt-parser/parser.lua:296
if t[1] == ":" then -- ./lepton/lpt-parser/parser.lua:297
table["insert"](t[2], 1, { -- ./lepton/lpt-parser/parser.lua:298
["tag"] = "Id", -- ./lepton/lpt-parser/parser.lua:298
"self" -- ./lepton/lpt-parser/parser.lua:298
}) -- ./lepton/lpt-parser/parser.lua:298
table["remove"](t, 1) -- ./lepton/lpt-parser/parser.lua:299
t["is_method"] = true -- ./lepton/lpt-parser/parser.lua:300
end -- ./lepton/lpt-parser/parser.lua:300
t["is_short"] = true -- ./lepton/lpt-parser/parser.lua:302
return t -- ./lepton/lpt-parser/parser.lua:303
end -- ./lepton/lpt-parser/parser.lua:303
local function markImplicit(t) -- ./lepton/lpt-parser/parser.lua:306
t["implicit"] = true -- ./lepton/lpt-parser/parser.lua:307
return t -- ./lepton/lpt-parser/parser.lua:308
end -- ./lepton/lpt-parser/parser.lua:308
local function statToExpr(t) -- ./lepton/lpt-parser/parser.lua:311
t["tag"] = t["tag"] .. "Expr" -- ./lepton/lpt-parser/parser.lua:312
return t -- ./lepton/lpt-parser/parser.lua:313
end -- ./lepton/lpt-parser/parser.lua:313
local function fixStructure(t) -- ./lepton/lpt-parser/parser.lua:316
local i = 1 -- ./lepton/lpt-parser/parser.lua:317
while i <= # t do -- ./lepton/lpt-parser/parser.lua:318
if type(t[i]) == "table" then -- ./lepton/lpt-parser/parser.lua:319
fixStructure(t[i]) -- ./lepton/lpt-parser/parser.lua:320
for j = # t[i], 1, - 1 do -- ./lepton/lpt-parser/parser.lua:321
local stat = t[i][j] -- ./lepton/lpt-parser/parser.lua:322
if type(stat) == "table" and stat["move_up_block"] and stat["move_up_block"] > 0 then -- ./lepton/lpt-parser/parser.lua:323
table["remove"](t[i], j) -- ./lepton/lpt-parser/parser.lua:324
table["insert"](t, i + 1, stat) -- ./lepton/lpt-parser/parser.lua:325
if t["tag"] == "Block" or t["tag"] == "Do" then -- ./lepton/lpt-parser/parser.lua:326
stat["move_up_block"] = stat["move_up_block"] - 1 -- ./lepton/lpt-parser/parser.lua:327
end -- ./lepton/lpt-parser/parser.lua:327
end -- ./lepton/lpt-parser/parser.lua:327
end -- ./lepton/lpt-parser/parser.lua:327
end -- ./lepton/lpt-parser/parser.lua:327
i = i + 1 -- ./lepton/lpt-parser/parser.lua:332
end -- ./lepton/lpt-parser/parser.lua:332
return t -- ./lepton/lpt-parser/parser.lua:334
end -- ./lepton/lpt-parser/parser.lua:334
local function searchEndRec(block, isRecCall) -- ./lepton/lpt-parser/parser.lua:337
for i, stat in ipairs(block) do -- ./lepton/lpt-parser/parser.lua:338
if stat["tag"] == "Set" or stat["tag"] == "Push" or stat["tag"] == "Return" or stat["tag"] == "Local" or stat["tag"] == "Let" or stat["tag"] == "Localrec" then -- ./lepton/lpt-parser/parser.lua:340
local exprlist -- ./lepton/lpt-parser/parser.lua:341
if stat["tag"] == "Set" or stat["tag"] == "Local" or stat["tag"] == "Let" or stat["tag"] == "Localrec" then -- ./lepton/lpt-parser/parser.lua:343
exprlist = stat[# stat] -- ./lepton/lpt-parser/parser.lua:344
elseif stat["tag"] == "Push" or stat["tag"] == "Return" then -- ./lepton/lpt-parser/parser.lua:345
exprlist = stat -- ./lepton/lpt-parser/parser.lua:346
end -- ./lepton/lpt-parser/parser.lua:346
local last = exprlist[# exprlist] -- ./lepton/lpt-parser/parser.lua:349
if last["tag"] == "Function" and last["is_short"] and not last["is_method"] and # last[1] == 1 then -- ./lepton/lpt-parser/parser.lua:353
local p = i -- ./lepton/lpt-parser/parser.lua:354
for j, fstat in ipairs(last[2]) do -- ./lepton/lpt-parser/parser.lua:355
p = i + j -- ./lepton/lpt-parser/parser.lua:356
table["insert"](block, p, fstat) -- ./lepton/lpt-parser/parser.lua:357
if stat["move_up_block"] then -- ./lepton/lpt-parser/parser.lua:359
fstat["move_up_block"] = (fstat["move_up_block"] or 0) + stat["move_up_block"] -- ./lepton/lpt-parser/parser.lua:360
end -- ./lepton/lpt-parser/parser.lua:360
if block["is_singlestatblock"] then -- ./lepton/lpt-parser/parser.lua:363
fstat["move_up_block"] = (fstat["move_up_block"] or 0) + 1 -- ./lepton/lpt-parser/parser.lua:364
end -- ./lepton/lpt-parser/parser.lua:364
end -- ./lepton/lpt-parser/parser.lua:364
exprlist[# exprlist] = last[1] -- ./lepton/lpt-parser/parser.lua:368
exprlist[# exprlist]["tag"] = "Paren" -- ./lepton/lpt-parser/parser.lua:369
if not isRecCall then -- ./lepton/lpt-parser/parser.lua:371
for j = p + 1, # block, 1 do -- ./lepton/lpt-parser/parser.lua:372
block[j]["move_up_block"] = (block[j]["move_up_block"] or 0) + 1 -- ./lepton/lpt-parser/parser.lua:373
end -- ./lepton/lpt-parser/parser.lua:373
end -- ./lepton/lpt-parser/parser.lua:373
return block, i -- ./lepton/lpt-parser/parser.lua:377
elseif last["tag"]:match("Expr$") then -- ./lepton/lpt-parser/parser.lua:380
local r = searchEndRec({ last }) -- ./lepton/lpt-parser/parser.lua:381
if r then -- ./lepton/lpt-parser/parser.lua:382
for j = 2, # r, 1 do -- ./lepton/lpt-parser/parser.lua:383
table["insert"](block, i + j - 1, r[j]) -- ./lepton/lpt-parser/parser.lua:384
end -- ./lepton/lpt-parser/parser.lua:384
return block, i -- ./lepton/lpt-parser/parser.lua:386
end -- ./lepton/lpt-parser/parser.lua:386
elseif last["tag"] == "Function" then -- ./lepton/lpt-parser/parser.lua:388
local r = searchEndRec(last[2]) -- ./lepton/lpt-parser/parser.lua:389
if r then -- ./lepton/lpt-parser/parser.lua:390
return block, i -- ./lepton/lpt-parser/parser.lua:391
end -- ./lepton/lpt-parser/parser.lua:391
end -- ./lepton/lpt-parser/parser.lua:391
elseif stat["tag"]:match("^If") or stat["tag"]:match("^While") or stat["tag"]:match("^Repeat") or stat["tag"]:match("^Do") or stat["tag"]:match("^Fornum") or stat["tag"]:match("^Forin") then -- ./lepton/lpt-parser/parser.lua:396
local blocks -- ./lepton/lpt-parser/parser.lua:397
if stat["tag"]:match("^If") or stat["tag"]:match("^While") or stat["tag"]:match("^Repeat") or stat["tag"]:match("^Fornum") or stat["tag"]:match("^Forin") then -- ./lepton/lpt-parser/parser.lua:399
blocks = stat -- ./lepton/lpt-parser/parser.lua:400
elseif stat["tag"]:match("^Do") then -- ./lepton/lpt-parser/parser.lua:401
blocks = { stat } -- ./lepton/lpt-parser/parser.lua:402
end -- ./lepton/lpt-parser/parser.lua:402
for _, iblock in ipairs(blocks) do -- ./lepton/lpt-parser/parser.lua:405
if iblock["tag"] == "Block" then -- ./lepton/lpt-parser/parser.lua:406
local oldLen = # iblock -- ./lepton/lpt-parser/parser.lua:407
local newiBlock, newEnd = searchEndRec(iblock, true) -- ./lepton/lpt-parser/parser.lua:408
if newiBlock then -- ./lepton/lpt-parser/parser.lua:409
local p = i -- ./lepton/lpt-parser/parser.lua:410
for j = newEnd + (# iblock - oldLen) + 1, # iblock, 1 do -- ./lepton/lpt-parser/parser.lua:411
p = p + 1 -- ./lepton/lpt-parser/parser.lua:412
table["insert"](block, p, iblock[j]) -- ./lepton/lpt-parser/parser.lua:413
iblock[j] = nil -- ./lepton/lpt-parser/parser.lua:414
end -- ./lepton/lpt-parser/parser.lua:414
if not isRecCall then -- ./lepton/lpt-parser/parser.lua:417
for j = p + 1, # block, 1 do -- ./lepton/lpt-parser/parser.lua:418
block[j]["move_up_block"] = (block[j]["move_up_block"] or 0) + 1 -- ./lepton/lpt-parser/parser.lua:419
end -- ./lepton/lpt-parser/parser.lua:419
end -- ./lepton/lpt-parser/parser.lua:419
return block, i -- ./lepton/lpt-parser/parser.lua:423
end -- ./lepton/lpt-parser/parser.lua:423
end -- ./lepton/lpt-parser/parser.lua:423
end -- ./lepton/lpt-parser/parser.lua:423
end -- ./lepton/lpt-parser/parser.lua:423
end -- ./lepton/lpt-parser/parser.lua:423
return nil -- ./lepton/lpt-parser/parser.lua:429
end -- ./lepton/lpt-parser/parser.lua:429
local function searchEnd(s, p, t) -- ./lepton/lpt-parser/parser.lua:432
local r = searchEndRec(fixStructure(t)) -- ./lepton/lpt-parser/parser.lua:433
if not r then -- ./lepton/lpt-parser/parser.lua:434
return false -- ./lepton/lpt-parser/parser.lua:435
end -- ./lepton/lpt-parser/parser.lua:435
return true, r -- ./lepton/lpt-parser/parser.lua:437
end -- ./lepton/lpt-parser/parser.lua:437
local function expectBlockOrSingleStatWithStartEnd(start, startLabel, stopLabel, canFollow) -- ./lepton/lpt-parser/parser.lua:440
if canFollow then -- ./lepton/lpt-parser/parser.lua:441
return (- start * V("SingleStatBlock") * canFollow ^ - 1) + (expect(start, startLabel) * ((V("Block") * (canFollow + kw("end"))) + (Cmt(V("Block"), searchEnd) + throw(stopLabel)))) -- ./lepton/lpt-parser/parser.lua:444
else -- ./lepton/lpt-parser/parser.lua:444
return (- start * V("SingleStatBlock")) + (expect(start, startLabel) * ((V("Block") * kw("end")) + (Cmt(V("Block"), searchEnd) + throw(stopLabel)))) -- ./lepton/lpt-parser/parser.lua:448
end -- ./lepton/lpt-parser/parser.lua:448
end -- ./lepton/lpt-parser/parser.lua:448
local function expectBlockWithEnd(label) -- ./lepton/lpt-parser/parser.lua:452
return (V("Block") * kw("end")) + (Cmt(V("Block"), searchEnd) + throw(label)) -- ./lepton/lpt-parser/parser.lua:454
end -- ./lepton/lpt-parser/parser.lua:454
local function maybeBlockWithEnd() -- ./lepton/lpt-parser/parser.lua:457
return (V("BlockNoErr") * kw("end")) + Cmt(V("BlockNoErr"), searchEnd) -- ./lepton/lpt-parser/parser.lua:459
end -- ./lepton/lpt-parser/parser.lua:459
local function maybe(patt) -- ./lepton/lpt-parser/parser.lua:462
return # patt / 0 * patt -- ./lepton/lpt-parser/parser.lua:463
end -- ./lepton/lpt-parser/parser.lua:463
local function setAttribute(attribute) -- ./lepton/lpt-parser/parser.lua:466
return function(assign) -- ./lepton/lpt-parser/parser.lua:467
assign[1]["tag"] = "AttributeNameList" -- ./lepton/lpt-parser/parser.lua:468
for _, id in ipairs(assign[1]) do -- ./lepton/lpt-parser/parser.lua:469
if id["tag"] == "Id" then -- ./lepton/lpt-parser/parser.lua:470
id["tag"] = "AttributeId" -- ./lepton/lpt-parser/parser.lua:471
id[2] = attribute -- ./lepton/lpt-parser/parser.lua:472
elseif id["tag"] == "DestructuringId" then -- ./lepton/lpt-parser/parser.lua:473
for _, did in ipairs(id) do -- ./lepton/lpt-parser/parser.lua:474
did["tag"] = "AttributeId" -- ./lepton/lpt-parser/parser.lua:475
did[2] = attribute -- ./lepton/lpt-parser/parser.lua:476
end -- ./lepton/lpt-parser/parser.lua:476
end -- ./lepton/lpt-parser/parser.lua:476
end -- ./lepton/lpt-parser/parser.lua:476
return assign -- ./lepton/lpt-parser/parser.lua:480
end -- ./lepton/lpt-parser/parser.lua:480
end -- ./lepton/lpt-parser/parser.lua:480
local stacks = { ["lexpr"] = {} } -- ./lepton/lpt-parser/parser.lua:485
local function push(f) -- ./lepton/lpt-parser/parser.lua:487
return Cmt(P(""), function() -- ./lepton/lpt-parser/parser.lua:488
table["insert"](stacks[f], true) -- ./lepton/lpt-parser/parser.lua:489
return true -- ./lepton/lpt-parser/parser.lua:490
end) -- ./lepton/lpt-parser/parser.lua:490
end -- ./lepton/lpt-parser/parser.lua:490
local function pop(f) -- ./lepton/lpt-parser/parser.lua:493
return Cmt(P(""), function() -- ./lepton/lpt-parser/parser.lua:494
table["remove"](stacks[f]) -- ./lepton/lpt-parser/parser.lua:495
return true -- ./lepton/lpt-parser/parser.lua:496
end) -- ./lepton/lpt-parser/parser.lua:496
end -- ./lepton/lpt-parser/parser.lua:496
local function when(f) -- ./lepton/lpt-parser/parser.lua:499
return Cmt(P(""), function() -- ./lepton/lpt-parser/parser.lua:500
return # stacks[f] > 0 -- ./lepton/lpt-parser/parser.lua:501
end) -- ./lepton/lpt-parser/parser.lua:501
end -- ./lepton/lpt-parser/parser.lua:501
local function set(f, patt) -- ./lepton/lpt-parser/parser.lua:504
return push(f) * patt * pop(f) -- ./lepton/lpt-parser/parser.lua:505
end -- ./lepton/lpt-parser/parser.lua:505
local G = { -- ./lepton/lpt-parser/parser.lua:510
V("Lua"), -- ./lepton/lpt-parser/parser.lua:510
["Lua"] = (V("Shebang") ^ - 1 * V("Skip") * V("Block") * expect(P(- 1), "Extra")) / fixStructure, -- ./lepton/lpt-parser/parser.lua:511
["Shebang"] = P("#!") * (P(1) - P("\
")) ^ 0, -- ./lepton/lpt-parser/parser.lua:512
["Block"] = tagC("Block", (V("Stat") + - V("BlockEnd") * throw("InvalidStat")) ^ 0 * ((V("RetStat") + V("ImplicitPushStat")) * sym(";") ^ - 1) ^ - 1), -- ./lepton/lpt-parser/parser.lua:514
["Stat"] = V("IfStat") + V("DoStat") + V("WhileStat") + V("RepeatStat") + V("ForStat") + V("LocalStat") + V("FuncStat") + V("BreakStat") + V("LabelStat") + V("GoToStat") + V("LetStat") + V("ConstStat") + V("CloseStat") + V("FuncCall") + V("Assignment") + V("ContinueStat") + V("PushStat") + sym(";"), -- ./lepton/lpt-parser/parser.lua:520
["BlockEnd"] = P("return") + "end" + "elseif" + "else" + "until" + "]" + - 1 + V("ImplicitPushStat") + V("Assignment"), -- ./lepton/lpt-parser/parser.lua:521
["SingleStatBlock"] = tagC("Block", V("Stat") + V("RetStat") + V("ImplicitPushStat")) / function(t) -- ./lepton/lpt-parser/parser.lua:523
t["is_singlestatblock"] = true -- ./lepton/lpt-parser/parser.lua:523
return t -- ./lepton/lpt-parser/parser.lua:523
end, -- ./lepton/lpt-parser/parser.lua:523
["BlockNoErr"] = tagC("Block", V("Stat") ^ 0 * ((V("RetStat") + V("ImplicitPushStat")) * sym(";") ^ - 1) ^ - 1), -- ./lepton/lpt-parser/parser.lua:524
["IfStat"] = tagC("If", V("IfPart")), -- ./lepton/lpt-parser/parser.lua:526
["IfPart"] = kw("if") * set("lexpr", expect(V("Expr"), "ExprIf")) * expectBlockOrSingleStatWithStartEnd(kw("then"), "ThenIf", "EndIf", V("ElseIfPart") + V("ElsePart")), -- ./lepton/lpt-parser/parser.lua:527
["ElseIfPart"] = kw("elseif") * set("lexpr", expect(V("Expr"), "ExprEIf")) * expectBlockOrSingleStatWithStartEnd(kw("then"), "ThenEIf", "EndIf", V("ElseIfPart") + V("ElsePart")), -- ./lepton/lpt-parser/parser.lua:528
["ElsePart"] = kw("else") * expectBlockWithEnd("EndIf"), -- ./lepton/lpt-parser/parser.lua:529
["DoStat"] = kw("do") * expectBlockWithEnd("EndDo") / tagDo, -- ./lepton/lpt-parser/parser.lua:531
["WhileStat"] = tagC("While", kw("while") * set("lexpr", expect(V("Expr"), "ExprWhile")) * V("WhileBody")), -- ./lepton/lpt-parser/parser.lua:532
["WhileBody"] = expectBlockOrSingleStatWithStartEnd(kw("do"), "DoWhile", "EndWhile"), -- ./lepton/lpt-parser/parser.lua:533
["RepeatStat"] = tagC("Repeat", kw("repeat") * V("Block") * expect(kw("until"), "UntilRep") * expect(V("Expr"), "ExprRep")), -- ./lepton/lpt-parser/parser.lua:534
["ForStat"] = kw("for") * expect(V("ForNum") + V("ForIn"), "ForRange"), -- ./lepton/lpt-parser/parser.lua:536
["ForNum"] = tagC("Fornum", V("Id") * sym("=") * V("NumRange") * V("ForBody")), -- ./lepton/lpt-parser/parser.lua:537
["NumRange"] = expect(V("Expr"), "ExprFor1") * expect(sym(","), "CommaFor") * expect(V("Expr"), "ExprFor2") * (sym(",") * expect(V("Expr"), "ExprFor3")) ^ - 1, -- ./lepton/lpt-parser/parser.lua:539
["ForIn"] = tagC("Forin", V("DestructuringNameList") * expect(kw("in"), "InFor") * expect(V("ExprList"), "EListFor") * V("ForBody")), -- ./lepton/lpt-parser/parser.lua:540
["ForBody"] = expectBlockOrSingleStatWithStartEnd(kw("do"), "DoFor", "EndFor"), -- ./lepton/lpt-parser/parser.lua:541
["LocalStat"] = kw("local") * expect(V("LocalFunc") + V("LocalAssign"), "DefLocal"), -- ./lepton/lpt-parser/parser.lua:543
["LocalFunc"] = tagC("Localrec", kw("function") * expect(V("Id"), "NameLFunc") * V("FuncBody")) / fixFuncStat, -- ./lepton/lpt-parser/parser.lua:544
["LocalAssign"] = tagC("Local", V("AttributeNameList") * (sym("=") * expect(V("ExprList"), "EListLAssign") + Ct(Cc()))) + tagC("Local", V("DestructuringNameList") * sym("=") * expect(V("ExprList"), "EListLAssign")), -- ./lepton/lpt-parser/parser.lua:546
["LetStat"] = kw("let") * expect(V("LetAssign"), "DefLet"), -- ./lepton/lpt-parser/parser.lua:548
["LetAssign"] = tagC("Let", V("NameList") * (sym("=") * expect(V("ExprList"), "EListLAssign") + Ct(Cc()))) + tagC("Let", V("DestructuringNameList") * sym("=") * expect(V("ExprList"), "EListLAssign")), -- ./lepton/lpt-parser/parser.lua:550
["ConstStat"] = kw("const") * expect(V("AttributeAssign") / setAttribute("const"), "DefConst"), -- ./lepton/lpt-parser/parser.lua:552
["CloseStat"] = kw("close") * expect(V("AttributeAssign") / setAttribute("close"), "DefClose"), -- ./lepton/lpt-parser/parser.lua:553
["AttributeAssign"] = tagC("Local", V("NameList") * (sym("=") * expect(V("ExprList"), "EListLAssign") + Ct(Cc()))) + tagC("Local", V("DestructuringNameList") * sym("=") * expect(V("ExprList"), "EListLAssign")), -- ./lepton/lpt-parser/parser.lua:555
["Assignment"] = tagC("Set", (V("VarList") + V("DestructuringNameList")) * V("BinOp") ^ - 1 * (P("=") / "=") * ((V("BinOp") - P("-")) + # (P("-") * V("Space")) * V("BinOp")) ^ - 1 * V("Skip") * expect(V("ExprList"), "EListAssign")), -- ./lepton/lpt-parser/parser.lua:557
["FuncStat"] = tagC("Set", kw("function") * expect(V("FuncName"), "FuncName") * V("FuncBody")) / fixFuncStat, -- ./lepton/lpt-parser/parser.lua:559
["FuncName"] = Cf(V("Id") * (sym(".") * expect(V("StrId"), "NameFunc1")) ^ 0, insertIndex) * (sym(":") * expect(V("StrId"), "NameFunc2")) ^ - 1 / markMethod, -- ./lepton/lpt-parser/parser.lua:561
["FuncBody"] = tagC("Function", V("FuncParams") * expectBlockWithEnd("EndFunc")), -- ./lepton/lpt-parser/parser.lua:562
["FuncParams"] = expect(sym("("), "OParenPList") * V("ParList") * expect(sym(")"), "CParenPList"), -- ./lepton/lpt-parser/parser.lua:563
["ParList"] = V("NamedParList") * (sym(",") * expect(tagC("Dots", sym("...")), "ParList")) ^ - 1 / addDots + Ct(tagC("Dots", sym("..."))) + Ct(Cc()), -- ./lepton/lpt-parser/parser.lua:566
["ShortFuncDef"] = tagC("Function", V("ShortFuncParams") * maybeBlockWithEnd()) / fixShortFunc, -- ./lepton/lpt-parser/parser.lua:568
["ShortFuncParams"] = (sym(":") / ":") ^ - 1 * sym("(") * V("ParList") * sym(")"), -- ./lepton/lpt-parser/parser.lua:569
["NamedParList"] = tagC("NamedParList", commaSep(V("NamedPar"))), -- ./lepton/lpt-parser/parser.lua:571
["NamedPar"] = tagC("ParPair", V("ParKey") * expect(sym("="), "EqField") * expect(V("Expr"), "ExprField")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:573
["ParKey"] = V("Id") * # ("=" * - P("=")), -- ./lepton/lpt-parser/parser.lua:574
["LabelStat"] = tagC("Label", sym("::") * expect(V("Name"), "Label") * expect(sym("::"), "CloseLabel")), -- ./lepton/lpt-parser/parser.lua:576
["GoToStat"] = tagC("Goto", kw("goto") * expect(V("Name"), "Goto")), -- ./lepton/lpt-parser/parser.lua:577
["BreakStat"] = tagC("Break", kw("break")), -- ./lepton/lpt-parser/parser.lua:578
["ContinueStat"] = tagC("Continue", kw("continue")), -- ./lepton/lpt-parser/parser.lua:579
["RetStat"] = tagC("Return", kw("return") * commaSep(V("Expr"), "RetList") ^ - 1), -- ./lepton/lpt-parser/parser.lua:580
["PushStat"] = tagC("Push", kw("push") * commaSep(V("Expr"), "RetList") ^ - 1), -- ./lepton/lpt-parser/parser.lua:582
["ImplicitPushStat"] = tagC("Push", commaSep(V("Expr"), "RetList")) / markImplicit, -- ./lepton/lpt-parser/parser.lua:583
["NameList"] = tagC("NameList", commaSep(V("Id"))), -- ./lepton/lpt-parser/parser.lua:585
["DestructuringNameList"] = tagC("NameList", commaSep(V("DestructuringId"))), -- ./lepton/lpt-parser/parser.lua:586
["AttributeNameList"] = tagC("AttributeNameList", commaSep(V("AttributeId"))), -- ./lepton/lpt-parser/parser.lua:587
["VarList"] = tagC("VarList", commaSep(V("VarExpr"))), -- ./lepton/lpt-parser/parser.lua:588
["ExprList"] = tagC("ExpList", commaSep(V("Expr"), "ExprList")), -- ./lepton/lpt-parser/parser.lua:589
["DestructuringId"] = tagC("DestructuringId", sym("{") * V("DestructuringIdFieldList") * expect(sym("}"), "CBraceDestructuring")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:591
["DestructuringIdFieldList"] = sepBy(V("DestructuringIdField"), V("FieldSep")) * V("FieldSep") ^ - 1, -- ./lepton/lpt-parser/parser.lua:592
["DestructuringIdField"] = tagC("Pair", V("FieldKey") * expect(sym("="), "DestructuringEqField") * expect(V("Id"), "DestructuringExprField")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:594
["Expr"] = V("OrExpr"), -- ./lepton/lpt-parser/parser.lua:596
["OrExpr"] = chainOp(V("AndExpr"), V("OrOp"), "OrExpr"), -- ./lepton/lpt-parser/parser.lua:597
["AndExpr"] = chainOp(V("RelExpr"), V("AndOp"), "AndExpr"), -- ./lepton/lpt-parser/parser.lua:598
["RelExpr"] = chainOp(V("BOrExpr"), V("RelOp"), "RelExpr"), -- ./lepton/lpt-parser/parser.lua:599
["BOrExpr"] = chainOp(V("BXorExpr"), V("BOrOp"), "BOrExpr"), -- ./lepton/lpt-parser/parser.lua:600
["BXorExpr"] = chainOp(V("BAndExpr"), V("BXorOp"), "BXorExpr"), -- ./lepton/lpt-parser/parser.lua:601
["BAndExpr"] = chainOp(V("ShiftExpr"), V("BAndOp"), "BAndExpr"), -- ./lepton/lpt-parser/parser.lua:602
["ShiftExpr"] = chainOp(V("ConcatExpr"), V("ShiftOp"), "ShiftExpr"), -- ./lepton/lpt-parser/parser.lua:603
["ConcatExpr"] = V("AddExpr") * (V("ConcatOp") * expect(V("ConcatExpr"), "ConcatExpr")) ^ - 1 / binaryOp, -- ./lepton/lpt-parser/parser.lua:604
["AddExpr"] = chainOp(V("MulExpr"), V("AddOp"), "AddExpr"), -- ./lepton/lpt-parser/parser.lua:605
["MulExpr"] = chainOp(V("UnaryExpr"), V("MulOp"), "MulExpr"), -- ./lepton/lpt-parser/parser.lua:606
["UnaryExpr"] = V("UnaryOp") * expect(V("UnaryExpr"), "UnaryExpr") / unaryOp + V("PowExpr"), -- ./lepton/lpt-parser/parser.lua:608
["PowExpr"] = V("SimpleExpr") * (V("PowOp") * expect(V("UnaryExpr"), "PowExpr")) ^ - 1 / binaryOp, -- ./lepton/lpt-parser/parser.lua:609
["SimpleExpr"] = tagC("Number", V("Number")) + tagC("Nil", kw("nil")) + tagC("Boolean", kw("false") * Cc(false)) + tagC("Boolean", kw("true") * Cc(true)) + tagC("Dots", sym("...")) + V("FuncDef") + (when("lexpr") * tagC("LetExpr", maybe(V("DestructuringNameList")) * sym("=") * - sym("=") * expect(V("ExprList"), "EListLAssign"))) + V("ShortFuncDef") + V("SuffixedExpr") + V("StatExpr"), -- ./lepton/lpt-parser/parser.lua:619
["StatExpr"] = (V("IfStat") + V("DoStat") + V("WhileStat") + V("RepeatStat") + V("ForStat")) / statToExpr, -- ./lepton/lpt-parser/parser.lua:621
["FuncCall"] = Cmt(V("SuffixedExpr"), function(s, i, exp) -- ./lepton/lpt-parser/parser.lua:623
return exp["tag"] == "Call" or exp["tag"] == "SafeCall", exp -- ./lepton/lpt-parser/parser.lua:623
end), -- ./lepton/lpt-parser/parser.lua:623
["VarExpr"] = Cmt(V("SuffixedExpr"), function(s, i, exp) -- ./lepton/lpt-parser/parser.lua:624
return exp["tag"] == "Id" or exp["tag"] == "Index", exp -- ./lepton/lpt-parser/parser.lua:624
end), -- ./lepton/lpt-parser/parser.lua:624
["SuffixedExpr"] = Cf(V("PrimaryExpr") * (V("Index") + V("MethodStub") + V("Call")) ^ 0 + V("NoCallPrimaryExpr") * - V("Call") * (V("Index") + V("MethodStub") + V("Call")) ^ 0 + V("NoCallPrimaryExpr"), makeSuffixedExpr), -- ./lepton/lpt-parser/parser.lua:628
["PrimaryExpr"] = V("SelfId") * (V("SelfCall") + V("SelfIndex")) + V("Id") + tagC("Paren", sym("(") * expect(V("Expr"), "ExprParen") * expect(sym(")"), "CParenExpr")), -- ./lepton/lpt-parser/parser.lua:631
["NoCallPrimaryExpr"] = tagC("String", V("String")) + V("Table") + V("TableCompr"), -- ./lepton/lpt-parser/parser.lua:632
["Index"] = tagC("DotIndex", sym("." * - P(".")) * expect(V("StrId"), "NameIndex")) + tagC("ArrayIndex", sym("[" * - P(S("=["))) * expect(V("Expr"), "ExprIndex") * expect(sym("]"), "CBracketIndex")) + tagC("SafeDotIndex", sym("?." * - P(".")) * expect(V("StrId"), "NameIndex")) + tagC("SafeArrayIndex", sym("?[" * - P(S("=["))) * expect(V("Expr"), "ExprIndex") * expect(sym("]"), "CBracketIndex")), -- ./lepton/lpt-parser/parser.lua:636
["MethodStub"] = tagC("MethodStub", sym(":" * - P(":")) * expect(V("StrId"), "NameMeth")) + tagC("SafeMethodStub", sym("?:" * - P(":")) * expect(V("StrId"), "NameMeth")), -- ./lepton/lpt-parser/parser.lua:638
["Call"] = tagC("Call", V("FuncArgs")) + tagC("SafeCall", P("?") * V("FuncArgs")), -- ./lepton/lpt-parser/parser.lua:640
["SelfCall"] = tagC("MethodStub", V("StrId")) * V("Call"), -- ./lepton/lpt-parser/parser.lua:641
["SelfIndex"] = tagC("DotIndex", V("StrId")), -- ./lepton/lpt-parser/parser.lua:642
["FuncDef"] = (kw("function") * V("FuncBody")), -- ./lepton/lpt-parser/parser.lua:644
["FuncArgs"] = sym("(") * commaSep(V("Expr"), "ArgList") ^ - 1 * expect(sym(")"), "CParenArgs") + V("Table") + tagC("String", V("String")), -- ./lepton/lpt-parser/parser.lua:647
["Table"] = tagC("Table", sym("{") * V("FieldList") ^ - 1 * expect(sym("}"), "CBraceTable")), -- ./lepton/lpt-parser/parser.lua:649
["FieldList"] = sepBy(V("Field"), V("FieldSep")) * V("FieldSep") ^ - 1, -- ./lepton/lpt-parser/parser.lua:650
["Field"] = tagC("Pair", V("FieldKey") * expect(sym("="), "EqField") * expect(V("Expr"), "ExprField")) + V("Expr"), -- ./lepton/lpt-parser/parser.lua:652
["FieldKey"] = sym("[" * - P(S("=["))) * expect(V("Expr"), "ExprFKey") * expect(sym("]"), "CBracketFKey") + V("StrId") * # ("=" * - P("=")), -- ./lepton/lpt-parser/parser.lua:654
["FieldSep"] = sym(",") + sym(";"), -- ./lepton/lpt-parser/parser.lua:655
["TableCompr"] = tagC("TableCompr", sym("[") * V("Block") * expect(sym("]"), "CBracketTableCompr")), -- ./lepton/lpt-parser/parser.lua:657
["SelfId"] = tagC("Id", sym("@") / "self"), -- ./lepton/lpt-parser/parser.lua:659
["Id"] = tagC("Id", V("Name")) + V("SelfId"), -- ./lepton/lpt-parser/parser.lua:660
["AttributeSelfId"] = tagC("AttributeId", sym("@") / "self" * V("Attribute") ^ - 1), -- ./lepton/lpt-parser/parser.lua:661
["AttributeId"] = tagC("AttributeId", V("Name") * V("Attribute") ^ - 1) + V("AttributeSelfId"), -- ./lepton/lpt-parser/parser.lua:662
["StrId"] = tagC("String", V("Name")), -- ./lepton/lpt-parser/parser.lua:663
["Attribute"] = sym("<") * expect(kw("const") / "const" + kw("close") / "close", "UnknownAttribute") * expect(sym(">"), "CBracketAttribute"), -- ./lepton/lpt-parser/parser.lua:665
["Skip"] = (V("Space") + V("Comment")) ^ 0, -- ./lepton/lpt-parser/parser.lua:668
["Space"] = space ^ 1, -- ./lepton/lpt-parser/parser.lua:669
["Comment"] = P("--") * V("LongStr") / function() -- ./lepton/lpt-parser/parser.lua:670
return  -- ./lepton/lpt-parser/parser.lua:670
end + P("--") * (P(1) - P("\
")) ^ 0, -- ./lepton/lpt-parser/parser.lua:671
["Name"] = token(- V("Reserved") * C(V("Ident"))), -- ./lepton/lpt-parser/parser.lua:673
["Reserved"] = V("Keywords") * - V("IdRest"), -- ./lepton/lpt-parser/parser.lua:674
["Keywords"] = P("and") + "break" + "do" + "elseif" + "else" + "end" + "false" + "for" + "function" + "goto" + "if" + "in" + "local" + "nil" + "not" + "or" + "repeat" + "return" + "then" + "true" + "until" + "while", -- ./lepton/lpt-parser/parser.lua:678
["Ident"] = V("IdStart") * V("IdRest") ^ 0, -- ./lepton/lpt-parser/parser.lua:679
["IdStart"] = alpha + P("_"), -- ./lepton/lpt-parser/parser.lua:680
["IdRest"] = alnum + P("_"), -- ./lepton/lpt-parser/parser.lua:681
["Number"] = token(C(V("Hex") + V("Float") + V("Int"))), -- ./lepton/lpt-parser/parser.lua:683
["Hex"] = (P("0x") + "0X") * ((xdigit ^ 0 * V("DeciHex")) + (expect(xdigit ^ 1, "DigitHex") * V("DeciHex") ^ - 1)) * V("ExpoHex") ^ - 1, -- ./lepton/lpt-parser/parser.lua:684
["Float"] = V("Decimal") * V("Expo") ^ - 1 + V("Int") * V("Expo"), -- ./lepton/lpt-parser/parser.lua:686
["Decimal"] = digit ^ 1 * "." * digit ^ 0 + P(".") * - P(".") * expect(digit ^ 1, "DigitDeci"), -- ./lepton/lpt-parser/parser.lua:688
["DeciHex"] = P(".") * xdigit ^ 0, -- ./lepton/lpt-parser/parser.lua:689
["Expo"] = S("eE") * S("+-") ^ - 1 * expect(digit ^ 1, "DigitExpo"), -- ./lepton/lpt-parser/parser.lua:690
["ExpoHex"] = S("pP") * S("+-") ^ - 1 * expect(xdigit ^ 1, "DigitExpo"), -- ./lepton/lpt-parser/parser.lua:691
["Int"] = digit ^ 1, -- ./lepton/lpt-parser/parser.lua:692
["String"] = token(V("ShortStr") + V("LongStr")), -- ./lepton/lpt-parser/parser.lua:694
["ShortStr"] = P("\"") * Cs((V("EscSeq") + (P(1) - S("\"\
"))) ^ 0) * expect(P("\""), "Quote") + P("'") * Cs((V("EscSeq") + (P(1) - S("'\
"))) ^ 0) * expect(P("'"), "Quote"), -- ./lepton/lpt-parser/parser.lua:696
["EscSeq"] = P("\\") / "" * (P("a") / "\7" + P("b") / "\8" + P("f") / "\12" + P("n") / "\
" + P("r") / "\13" + P("t") / "\9" + P("v") / "\11" + P("\
") / "\
" + P("\13") / "\
" + P("\\") / "\\" + P("\"") / "\"" + P("'") / "'" + P("z") * space ^ 0 / "" + digit * digit ^ - 2 / tonumber / string["char"] + P("x") * expect(C(xdigit * xdigit), "HexEsc") * Cc(16) / tonumber / string["char"] + P("u") * expect("{", "OBraceUEsc") * expect(C(xdigit ^ 1), "DigitUEsc") * Cc(16) * expect("}", "CBraceUEsc") / tonumber / (utf8 and utf8["char"] or string["char"]) + throw("EscSeq")), -- ./lepton/lpt-parser/parser.lua:726
["LongStr"] = V("Open") * C((P(1) - V("CloseEq")) ^ 0) * expect(V("Close"), "CloseLStr") / function(s, eqs) -- ./lepton/lpt-parser/parser.lua:729
return s -- ./lepton/lpt-parser/parser.lua:729
end, -- ./lepton/lpt-parser/parser.lua:729
["Open"] = "[" * Cg(V("Equals"), "openEq") * "[" * P("\
") ^ - 1, -- ./lepton/lpt-parser/parser.lua:730
["Close"] = "]" * C(V("Equals")) * "]", -- ./lepton/lpt-parser/parser.lua:731
["Equals"] = P("=") ^ 0, -- ./lepton/lpt-parser/parser.lua:732
["CloseEq"] = Cmt(V("Close") * Cb("openEq"), function(s, i, closeEq, openEq) -- ./lepton/lpt-parser/parser.lua:733
return # openEq == # closeEq -- ./lepton/lpt-parser/parser.lua:733
end), -- ./lepton/lpt-parser/parser.lua:733
["OrOp"] = kw("or") / "or", -- ./lepton/lpt-parser/parser.lua:735
["AndOp"] = kw("and") / "and", -- ./lepton/lpt-parser/parser.lua:736
["RelOp"] = sym("~=") / "ne" + sym("==") / "eq" + sym("<=") / "le" + sym(">=") / "ge" + sym("<") / "lt" + sym(">") / "gt", -- ./lepton/lpt-parser/parser.lua:742
["BOrOp"] = sym("|") / "bor", -- ./lepton/lpt-parser/parser.lua:743
["BXorOp"] = sym("~" * - P("=")) / "bxor", -- ./lepton/lpt-parser/parser.lua:744
["BAndOp"] = sym("&") / "band", -- ./lepton/lpt-parser/parser.lua:745
["ShiftOp"] = sym("<<") / "shl" + sym(">>") / "shr", -- ./lepton/lpt-parser/parser.lua:747
["ConcatOp"] = sym("..") / "concat", -- ./lepton/lpt-parser/parser.lua:748
["AddOp"] = sym("+") / "add" + sym("-") / "sub", -- ./lepton/lpt-parser/parser.lua:750
["MulOp"] = sym("*") / "mul" + sym("//") / "idiv" + sym("/") / "div" + sym("%") / "mod", -- ./lepton/lpt-parser/parser.lua:754
["UnaryOp"] = kw("not") / "not" + sym("-") / "unm" + sym("#") / "len" + sym("~") / "bnot", -- ./lepton/lpt-parser/parser.lua:758
["PowOp"] = sym("^") / "pow", -- ./lepton/lpt-parser/parser.lua:759
["BinOp"] = V("OrOp") + V("AndOp") + V("BOrOp") + V("BXorOp") + V("BAndOp") + V("ShiftOp") + V("ConcatOp") + V("AddOp") + V("MulOp") + V("PowOp") -- ./lepton/lpt-parser/parser.lua:760
} -- ./lepton/lpt-parser/parser.lua:760
local macroidentifier = { -- ./lepton/lpt-parser/parser.lua:764
expect(V("MacroIdentifier"), "InvalidStat") * expect(P(- 1), "Extra"), -- ./lepton/lpt-parser/parser.lua:765
["MacroIdentifier"] = tagC("MacroFunction", V("Id") * sym("(") * V("MacroFunctionArgs") * expect(sym(")"), "CParenPList")) + V("Id"), -- ./lepton/lpt-parser/parser.lua:768
["MacroFunctionArgs"] = V("NameList") * (sym(",") * expect(tagC("Dots", sym("...")), "ParList")) ^ - 1 / addDots + Ct(tagC("Dots", sym("..."))) + Ct(Cc()) -- ./lepton/lpt-parser/parser.lua:772
} -- ./lepton/lpt-parser/parser.lua:772
for k, v in pairs(G) do -- ./lepton/lpt-parser/parser.lua:775
if macroidentifier[k] == nil then -- ./lepton/lpt-parser/parser.lua:775
macroidentifier[k] = v -- ./lepton/lpt-parser/parser.lua:775
end -- ./lepton/lpt-parser/parser.lua:775
end -- ./lepton/lpt-parser/parser.lua:775
local parser = {} -- ./lepton/lpt-parser/parser.lua:777
local validator = require("lepton.lpt-parser.validator") -- ./lepton/lpt-parser/parser.lua:779
local validate = validator["validate"] -- ./lepton/lpt-parser/parser.lua:780
local syntaxerror = validator["syntaxerror"] -- ./lepton/lpt-parser/parser.lua:781
parser["parse"] = function(subject, filename) -- ./lepton/lpt-parser/parser.lua:783
local errorinfo = { -- ./lepton/lpt-parser/parser.lua:784
["subject"] = subject, -- ./lepton/lpt-parser/parser.lua:784
["filename"] = filename -- ./lepton/lpt-parser/parser.lua:784
} -- ./lepton/lpt-parser/parser.lua:784
lpeg["setmaxstack"](1000) -- ./lepton/lpt-parser/parser.lua:785
local ast, label, errpos = lpeg["match"](G, subject, nil, errorinfo) -- ./lepton/lpt-parser/parser.lua:786
if not ast then -- ./lepton/lpt-parser/parser.lua:787
local errmsg = labels[label][2] -- ./lepton/lpt-parser/parser.lua:788
return ast, syntaxerror(errorinfo, errpos, errmsg) -- ./lepton/lpt-parser/parser.lua:789
end -- ./lepton/lpt-parser/parser.lua:789
return validate(ast, errorinfo) -- ./lepton/lpt-parser/parser.lua:791
end -- ./lepton/lpt-parser/parser.lua:791
parser["parsemacroidentifier"] = function(subject, filename) -- ./lepton/lpt-parser/parser.lua:794
local errorinfo = { -- ./lepton/lpt-parser/parser.lua:795
["subject"] = subject, -- ./lepton/lpt-parser/parser.lua:795
["filename"] = filename -- ./lepton/lpt-parser/parser.lua:795
} -- ./lepton/lpt-parser/parser.lua:795
lpeg["setmaxstack"](1000) -- ./lepton/lpt-parser/parser.lua:796
local ast, label, errpos = lpeg["match"](macroidentifier, subject, nil, errorinfo) -- ./lepton/lpt-parser/parser.lua:797
if not ast then -- ./lepton/lpt-parser/parser.lua:798
local errmsg = labels[label][2] -- ./lepton/lpt-parser/parser.lua:799
return ast, syntaxerror(errorinfo, errpos, errmsg) -- ./lepton/lpt-parser/parser.lua:800
end -- ./lepton/lpt-parser/parser.lua:800
return ast -- ./lepton/lpt-parser/parser.lua:802
end -- ./lepton/lpt-parser/parser.lua:802
return parser -- ./lepton/lpt-parser/parser.lua:805
end -- ./lepton/lpt-parser/parser.lua:805
local parser = _() or parser -- ./lepton/lpt-parser/parser.lua:809
package["loaded"]["lepton.lpt-parser.parser"] = parser or true -- ./lepton/lpt-parser/parser.lua:810
local unpack = unpack or table["unpack"] -- lepton.can:20
lepton["default"] = { -- lepton.can:23
["target"] = "lua54", -- lepton.can:24
["indentation"] = "", -- lepton.can:25
["newline"] = "\
", -- lepton.can:26
["variablePrefix"] = "__CAN_", -- lepton.can:27
["mapLines"] = true, -- lepton.can:28
["chunkname"] = "nil", -- lepton.can:29
["rewriteErrors"] = true, -- lepton.can:30
["builtInMacros"] = true, -- lepton.can:31
["preprocessorEnv"] = {}, -- lepton.can:32
["import"] = {} -- lepton.can:33
} -- lepton.can:33
if _VERSION == "Lua 5.1" then -- lepton.can:37
if package["loaded"]["jit"] then -- lepton.can:38
lepton["default"]["target"] = "luajit" -- lepton.can:39
else -- lepton.can:39
lepton["default"]["target"] = "lua51" -- lepton.can:41
end -- lepton.can:41
elseif _VERSION == "Lua 5.2" then -- lepton.can:43
lepton["default"]["target"] = "lua52" -- lepton.can:44
elseif _VERSION == "Lua 5.3" then -- lepton.can:45
lepton["default"]["target"] = "lua53" -- lepton.can:46
end -- lepton.can:46
lepton["preprocess"] = function(input, options, _env) -- lepton.can:56
if options == nil then options = {} end -- lepton.can:56
options = util["merge"](lepton["default"], options) -- lepton.can:57
local macros = { -- lepton.can:58
["functions"] = {}, -- lepton.can:59
["variables"] = {} -- lepton.can:60
} -- lepton.can:60
for _, mod in ipairs(options["import"]) do -- lepton.can:64
input = (("#import(%q, {loadLocal=false})\
"):format(mod)) .. input -- lepton.can:65
end -- lepton.can:65
local preprocessor = "" -- lepton.can:69
local i = 0 -- lepton.can:70
local inLongString = false -- lepton.can:71
local inComment = false -- lepton.can:72
for line in (input .. "\
"):gmatch("(.-\
)") do -- lepton.can:73
i = i + (1) -- lepton.can:74
if inComment then -- lepton.can:76
inComment = not line:match("%]%]") -- lepton.can:77
elseif inLongString then -- lepton.can:78
inLongString = not line:match("%]%]") -- lepton.can:79
else -- lepton.can:79
if line:match("[^%-]%[%[") then -- lepton.can:81
inLongString = true -- lepton.can:82
elseif line:match("%-%-%[%[") then -- lepton.can:83
inComment = true -- lepton.can:84
end -- lepton.can:84
end -- lepton.can:84
if not inComment and not inLongString and line:match("^%s*#") and not line:match("^#!") then -- lepton.can:87
preprocessor = preprocessor .. (line:gsub("^%s*#", "")) -- lepton.can:88
else -- lepton.can:88
local l = line:sub(1, - 2) -- lepton.can:90
if not inLongString and options["mapLines"] and not l:match("%-%- (.-)%:(%d+)$") then -- lepton.can:91
preprocessor = preprocessor .. (("write(%q)"):format(l .. " -- " .. options["chunkname"] .. ":" .. i) .. "\
") -- lepton.can:92
else -- lepton.can:92
preprocessor = preprocessor .. (("write(%q)"):format(line:sub(1, - 2)) .. "\
") -- lepton.can:94
end -- lepton.can:94
end -- lepton.can:94
end -- lepton.can:94
preprocessor = preprocessor .. ("return output") -- lepton.can:98
local exportenv = {} -- lepton.can:101
local env = util["merge"](_G, options["preprocessorEnv"]) -- lepton.can:102
env["lepton"] = lepton -- lepton.can:104
env["output"] = "" -- lepton.can:106
env["import"] = function(modpath, margs) -- lepton.can:113
if margs == nil then margs = {} end -- lepton.can:113
local filepath = assert(util["search"](modpath, { -- lepton.can:114
"can", -- lepton.can:114
"lua" -- lepton.can:114
}), "No module named \"" .. modpath .. "\"") -- lepton.can:114
local f = io["open"](filepath) -- lepton.can:117
if not f then -- lepton.can:118
error("can't open the module file to import") -- lepton.can:118
end -- lepton.can:118
margs = util["merge"](options, { -- lepton.can:120
["chunkname"] = filepath, -- lepton.can:120
["loadLocal"] = true, -- lepton.can:120
["loadPackage"] = true -- lepton.can:120
}, margs) -- lepton.can:120
margs["import"] = {} -- lepton.can:121
local modcontent, modmacros, modenv = assert(lepton["preprocess"](f:read("*a"), margs)) -- lepton.can:122
macros = util["recmerge"](macros, modmacros) -- lepton.can:123
for k, v in pairs(modenv) do -- lepton.can:124
env[k] = v -- lepton.can:124
end -- lepton.can:124
f:close() -- lepton.can:125
local modname = modpath:match("[^%.]+$") -- lepton.can:128
env["write"]("-- MODULE " .. modpath .. " --\
" .. "local function _()\
" .. modcontent .. "\
" .. "end\
" .. (margs["loadLocal"] and ("local %s = _() or %s\
"):format(modname, modname) or "") .. (margs["loadPackage"] and ("package.loaded[%q] = %s or true\
"):format(modpath, margs["loadLocal"] and modname or "_()") or "") .. "-- END OF MODULE " .. modpath .. " --") -- lepton.can:137
end -- lepton.can:137
env["include"] = function(file) -- lepton.can:142
local f = io["open"](file) -- lepton.can:143
if not f then -- lepton.can:144
error("can't open the file " .. file .. " to include") -- lepton.can:144
end -- lepton.can:144
env["write"](f:read("*a")) -- lepton.can:145
f:close() -- lepton.can:146
end -- lepton.can:146
env["write"] = function(...) -- lepton.can:150
env["output"] = env["output"] .. (table["concat"]({ ... }, "\9") .. "\
") -- lepton.can:151
end -- lepton.can:151
env["placeholder"] = function(name) -- lepton.can:155
if env[name] then -- lepton.can:156
env["write"](env[name]) -- lepton.can:157
end -- lepton.can:157
end -- lepton.can:157
env["define"] = function(identifier, replacement) -- lepton.can:160
local iast, ierr = parser["parsemacroidentifier"](identifier, options["chunkname"]) -- lepton.can:162
if not iast then -- lepton.can:163
return error(("in macro identifier: %s"):format(tostring(ierr))) -- lepton.can:164
end -- lepton.can:164
if type(replacement) == "string" then -- lepton.can:167
local rast, rerr = parser["parse"](replacement, options["chunkname"]) -- lepton.can:168
if not rast then -- lepton.can:169
return error(("in macro replacement: %s"):format(tostring(rerr))) -- lepton.can:170
end -- lepton.can:170
if # rast == 1 and rast[1]["tag"] == "Push" and rast[1]["implicit"] then -- lepton.can:173
rast = rast[1][1] -- lepton.can:174
end -- lepton.can:174
replacement = rast -- lepton.can:176
elseif type(replacement) ~= "function" then -- lepton.can:177
error("bad argument #2 to 'define' (string or function expected)") -- lepton.can:178
end -- lepton.can:178
if iast["tag"] == "MacroFunction" then -- lepton.can:181
macros["functions"][iast[1][1]] = { -- lepton.can:182
["args"] = iast[2], -- lepton.can:182
["replacement"] = replacement -- lepton.can:182
} -- lepton.can:182
elseif iast["tag"] == "Id" then -- lepton.can:183
macros["variables"][iast[1]] = replacement -- lepton.can:184
else -- lepton.can:184
error(("invalid macro type %s"):format(tostring(iast["tag"]))) -- lepton.can:186
end -- lepton.can:186
end -- lepton.can:186
env["set"] = function(identifier, value) -- lepton.can:189
exportenv[identifier] = value -- lepton.can:190
env[identifier] = value -- lepton.can:191
end -- lepton.can:191
if options["builtInMacros"] then -- lepton.can:195
env["define"]("__STR__(x)", function(x) -- lepton.can:196
return ("%q"):format(x) -- lepton.can:196
end) -- lepton.can:196
local s = require("lepton.serpent") -- lepton.can:197
env["define"]("__CONSTEXPR__(expr)", function(expr) -- lepton.can:198
return s["block"](assert(lepton["load"](expr))(), { ["fatal"] = true }) -- lepton.can:199
end) -- lepton.can:199
end -- lepton.can:199
local preprocess, err = lepton["compile"](preprocessor, options) -- lepton.can:204
if not preprocess then -- lepton.can:205
return nil, "in preprocessor: " .. err -- lepton.can:206
end -- lepton.can:206
preprocess, err = util["load"](preprocessor, "lepton preprocessor", env) -- lepton.can:209
if not preprocess then -- lepton.can:210
return nil, "in preprocessor: " .. err -- lepton.can:211
end -- lepton.can:211
local success, output = pcall(preprocess) -- lepton.can:215
if not success then -- lepton.can:216
return nil, "in preprocessor: " .. output -- lepton.can:217
end -- lepton.can:217
return output, macros, exportenv -- lepton.can:220
end -- lepton.can:220
lepton["compile"] = function(input, options, macros) -- lepton.can:230
if options == nil then options = {} end -- lepton.can:230
options = util["merge"](lepton["default"], options) -- lepton.can:231
local ast, errmsg = parser["parse"](input, options["chunkname"]) -- lepton.can:233
if not ast then -- lepton.can:235
return nil, errmsg -- lepton.can:236
end -- lepton.can:236
return require("compiler." .. options["target"])(input, ast, options, macros) -- lepton.can:239
end -- lepton.can:239
lepton["make"] = function(code, options) -- lepton.can:248
local r, err = lepton["preprocess"](code, options) -- lepton.can:249
if r then -- lepton.can:250
r, err = lepton["compile"](r, options, err) -- lepton.can:251
if r then -- lepton.can:252
return r -- lepton.can:253
end -- lepton.can:253
end -- lepton.can:253
return r, err -- lepton.can:256
end -- lepton.can:256
local errorRewritingActive = false -- lepton.can:259
local codeCache = {} -- lepton.can:260
lepton["loadfile"] = function(filepath, env, options) -- lepton.can:263
local f, err = io["open"](filepath) -- lepton.can:264
if not f then -- lepton.can:265
return nil, ("cannot open %s"):format(tostring(err)) -- lepton.can:266
end -- lepton.can:266
local content = f:read("*a") -- lepton.can:268
f:close() -- lepton.can:269
return lepton["load"](content, filepath, env, options) -- lepton.can:271
end -- lepton.can:271
lepton["load"] = function(chunk, chunkname, env, options) -- lepton.can:276
if options == nil then options = {} end -- lepton.can:276
options = util["merge"]({ ["chunkname"] = tostring(chunkname or chunk) }, options) -- lepton.can:277
local code, err = lepton["make"](chunk, options) -- lepton.can:279
if not code then -- lepton.can:280
return code, err -- lepton.can:281
end -- lepton.can:281
codeCache[options["chunkname"]] = code -- lepton.can:284
local f -- lepton.can:285
f, err = util["load"](code, ("=%s(%s)"):format(options["chunkname"], "compiled lepton"), env) -- lepton.can:286
if f == nil then -- lepton.can:291
return f, "lepton unexpectedly generated invalid code: " .. err -- lepton.can:292
end -- lepton.can:292
if options["rewriteErrors"] == false then -- lepton.can:295
return f -- lepton.can:296
else -- lepton.can:296
return function(...) -- lepton.can:298
if not errorRewritingActive then -- lepton.can:299
errorRewritingActive = true -- lepton.can:300
local t = { xpcall(f, lepton["messageHandler"], ...) } -- lepton.can:301
errorRewritingActive = false -- lepton.can:302
if t[1] == false then -- lepton.can:303
error(t[2], 0) -- lepton.can:304
end -- lepton.can:304
return unpack(t, 2) -- lepton.can:306
else -- lepton.can:306
return f(...) -- lepton.can:308
end -- lepton.can:308
end -- lepton.can:308
end -- lepton.can:308
end -- lepton.can:308
lepton["dofile"] = function(filename, options) -- lepton.can:316
local f, err = lepton["loadfile"](filename, nil, options) -- lepton.can:317
if f == nil then -- lepton.can:319
error(err) -- lepton.can:320
else -- lepton.can:320
return f() -- lepton.can:322
end -- lepton.can:322
end -- lepton.can:322
lepton["messageHandler"] = function(message, noTraceback) -- lepton.can:328
message = tostring(message) -- lepton.can:329
if not noTraceback and not message:match("\
stack traceback:\
") then -- lepton.can:330
message = debug["traceback"](message, 2) -- lepton.can:331
end -- lepton.can:331
return message:gsub("(\
?%s*)([^\
]-)%:(%d+)%:", function(indentation, source, line) -- lepton.can:333
line = tonumber(line) -- lepton.can:334
local originalFile -- lepton.can:336
local strName = source:match("^(.-)%(compiled lepton%)$") -- lepton.can:337
if strName then -- lepton.can:338
if codeCache[strName] then -- lepton.can:339
originalFile = codeCache[strName] -- lepton.can:340
source = strName -- lepton.can:341
end -- lepton.can:341
else -- lepton.can:341
do -- lepton.can:344
local fi -- lepton.can:344
fi = io["open"](source, "r") -- lepton.can:344
if fi then -- lepton.can:344
originalFile = fi:read("*a") -- lepton.can:345
fi:close() -- lepton.can:346
end -- lepton.can:346
end -- lepton.can:346
end -- lepton.can:346
if originalFile then -- lepton.can:350
local i = 0 -- lepton.can:351
for l in (originalFile .. "\
"):gmatch("([^\
]*)\
") do -- lepton.can:352
i = i + 1 -- lepton.can:353
if i == line then -- lepton.can:354
local extSource, lineMap = l:match(".*%-%- (.-)%:(%d+)$") -- lepton.can:355
if lineMap then -- lepton.can:356
if extSource ~= source then -- lepton.can:357
return indentation .. extSource .. ":" .. lineMap .. "(" .. extSource .. ":" .. line .. "):" -- lepton.can:358
else -- lepton.can:358
return indentation .. extSource .. ":" .. lineMap .. "(" .. line .. "):" -- lepton.can:360
end -- lepton.can:360
end -- lepton.can:360
break -- lepton.can:363
end -- lepton.can:363
end -- lepton.can:363
end -- lepton.can:363
end) -- lepton.can:363
end -- lepton.can:363
lepton["searcher"] = function(modpath) -- lepton.can:371
local filepath = util["search"](modpath, { "can" }) -- lepton.can:372
if not filepath then -- lepton.can:373
if _VERSION == "Lua 5.4" then -- lepton.can:374
return "no lepton file in package.path" -- lepton.can:375
else -- lepton.can:375
return "\
\9no lepton file in package.path" -- lepton.can:377
end -- lepton.can:377
end -- lepton.can:377
return function(modpath) -- lepton.can:380
local r, s = lepton["loadfile"](filepath) -- lepton.can:381
if r then -- lepton.can:382
return r(modpath, filepath) -- lepton.can:383
else -- lepton.can:383
error(("error loading lepton module '%s' from file '%s':\
\9%s"):format(modpath, filepath, tostring(s)), 0) -- lepton.can:385
end -- lepton.can:385
end, filepath -- lepton.can:387
end -- lepton.can:387
lepton["setup"] = function() -- lepton.can:391
local searchers = (function() -- lepton.can:392
if _VERSION == "Lua 5.1" then -- lepton.can:392
return package["loaders"] -- lepton.can:393
else -- lepton.can:393
return package["searchers"] -- lepton.can:395
end -- lepton.can:395
end)() -- lepton.can:395
for _, s in ipairs(searchers) do -- lepton.can:398
if s == lepton["searcher"] then -- lepton.can:399
return lepton -- lepton.can:400
end -- lepton.can:400
end -- lepton.can:400
table["insert"](searchers, 1, lepton["searcher"]) -- lepton.can:404
return lepton -- lepton.can:405
end -- lepton.can:405
return lepton -- lepton.can:408
