local lepton = require("lepton") -- util.can:1
local util = {} -- util.can:2
util["search"] = function(modpath, exts) -- util.can:4
if exts == nil then exts = {} end -- util.can:4
for _, ext in ipairs(exts) do -- util.can:5
for path in package["path"]:gmatch("[^;]+") do -- util.can:6
local fpath = path:gsub("%.lua", "." .. ext):gsub("%?", (modpath:gsub("%.", "/"))) -- util.can:7
local f = io["open"](fpath) -- util.can:8
if f then -- util.can:9
f:close() -- util.can:10
return fpath -- util.can:11
end -- util.can:11
end -- util.can:11
end -- util.can:11
end -- util.can:11
util["load"] = function(str, name, env) -- util.can:17
if _VERSION == "Lua 5.1" then -- util.can:18
local fn, err = loadstring(str, name) -- util.can:19
if not fn then -- util.can:20
return fn, err -- util.can:20
end -- util.can:20
return env ~= nil and setfenv(fn, env) or fn -- util.can:21
else -- util.can:21
if env then -- util.can:23
return load(str, name, nil, env) -- util.can:24
else -- util.can:24
return load(str, name) -- util.can:26
end -- util.can:26
end -- util.can:26
end -- util.can:26
util["recmerge"] = function(...) -- util.can:31
local r = {} -- util.can:32
for _, t in ipairs({ ... }) do -- util.can:33
for k, v in pairs(t) do -- util.can:34
if type(v) == "table" then -- util.can:35
r[k] = util["merge"](v, r[k]) -- util.can:36
else -- util.can:36
r[k] = v -- util.can:38
end -- util.can:38
end -- util.can:38
end -- util.can:38
return r -- util.can:42
end -- util.can:42
util["merge"] = function(...) -- util.can:45
local r = {} -- util.can:46
for _, t in ipairs({ ... }) do -- util.can:47
for k, v in pairs(t) do -- util.can:48
r[k] = v -- util.can:49
end -- util.can:49
end -- util.can:49
return r -- util.can:52
end -- util.can:52
util["cli"] = { -- util.can:55
["addLeptonOptions"] = function(parser) -- util.can:57
parser:group("Compiler options", parser:option("-t --target"):description("Target Lua version: lua54, lua53, lua52, luajit or lua51"):default(lepton["default"]["target"]), parser:option("--indentation"):description("Character(s) used for indentation in the compiled file"):default(lepton["default"]["indentation"]), parser:option("--newline"):description("Character(s) used for newlines in the compiled file"):default(lepton["default"]["newline"]), parser:option("--variable-prefix"):description("Prefix used when lepton needs to set a local variable to provide some functionality"):default(lepton["default"]["variablePrefix"]), parser:flag("--no-map-lines"):description("Do not add comments at the end of each line indicating the associated source line and file (error rewriting will not work)")) -- util.can:76
parser:group("Preprocessor options", parser:flag("--no-builtin-macros"):description("Disable built-in macros"), parser:option("-D --define"):description("Define a preprocessor constant"):args("1-2"):argname({ -- util.can:86
"name", -- util.can:86
"value" -- util.can:86
}):count("*"), parser:option("-I --import"):description("Statically import a module into the compiled file"):argname("module"):count("*")) -- util.can:92
parser:option("--chunkname"):description("Chunkname used when running the code") -- util.can:96
parser:flag("--no-rewrite-errors"):description("Disable error rewriting when running the code") -- util.can:99
end, -- util.can:99
["makeLeptonOptions"] = function(args) -- util.can:103
local preprocessorEnv = {} -- util.can:104
for _, o in ipairs(args["define"]) do -- util.can:105
preprocessorEnv[o[1]] = tonumber(o[2]) or o[2] or true -- util.can:106
end -- util.can:106
local options = { -- util.can:109
["target"] = args["target"], -- util.can:110
["indentation"] = args["indentation"], -- util.can:111
["newline"] = args["newline"], -- util.can:112
["variablePrefix"] = args["variable_prefix"], -- util.can:113
["mapLines"] = not args["no_map_lines"], -- util.can:114
["chunkname"] = args["chunkname"], -- util.can:115
["rewriteErrors"] = not args["no_rewrite_errors"], -- util.can:116
["builtInMacros"] = not args["no_builtin_macros"], -- util.can:117
["preprocessorEnv"] = preprocessorEnv, -- util.can:118
["import"] = args["import"] -- util.can:119
} -- util.can:119
return options -- util.can:121
end -- util.can:121
} -- util.can:121
return util -- util.can:125
