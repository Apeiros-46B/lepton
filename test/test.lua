---@diagnostic disable: redefined-local
-- {{{ imports
local lepton = dofile(arg[1] or '../lepton.lua')

lepton.default.indentation = '\t'
lepton.default.mapLines = false

local load = require('lepton.util').load
-- }}}

-- {{{ text formatting
local colors = {
    black  = 30,
    red    = 31,
    green  = 32,
    yellow = 33,
    blue   = 34,
    purple = 35,
    cyan   = 36,
    white  = 37,

    bgBlack  = 40,
    bgRed    = 41,
    bgGreen  = 42,
    bgYellow = 43,
    bgBlue   = 44,
    bgPurple = 45,
    bgCyan   = 46,
    bgWhite  = 47,

    bold      = 1,
    underline = 4
}

local function c(text, ...)
    local codes = {}
    for _, color in ipairs{...} do
        table.insert(codes, colors[color])
    end
    return ('\027[%sm%s\027[0m'):format(table.concat(codes, ';'), text)
end
-- }}}

-- {{{ test helper
local results = {} -- tests result
local function test(name, leptonCode, expectedResult, options)
    results[name] = { result = 'not finished', message = 'no info' }
    local self = results[name]

    -- options
    options = options or {}
    options.chunkname = name

    -- make code
    local success, code = pcall(function() return assert(lepton.make(leptonCode, options)) end)
    if not success then
        self.result = 'error'
        self.message = c('[!] error while making code:\n', 'bold', 'red')..c(code, 'red')
        return
    end

    -- load code
    local env = {}
    for k, v in pairs(_G) do env[k] = v end
    local success, func = pcall(load, code, nil, env)
    if not success then
        self.result = 'error'
        self.message = c('[!] error while loading code:\n'..func..'\ngenerated code:\n', 'bold', 'red')..c(code, 'red')
        return
    end

    -- run code
    local success, output = pcall(func)
    if not success then
        self.result = 'error'
        self.message = c('[!] error while running code:\n'..output..'\ngenerated code:\n', 'bold', 'red')..c(code, 'red')
        return
    end

    -- check result
    if output ~= expectedResult then
        self.result = 'fail'
        self.message = c('[!] invalid result from the code; it returned '..tostring(output)..' instead of '..tostring(expectedResult)..'; generated code:\n', 'bold', 'purple')..c(code, 'purple')
        return
    else
        self.result = 'success'
        return
    end
end
-- }}}

-- {{{ tests
print('running tests...')

-- {{{ PREPROCESSOR
test('preprocessor', [[
#local foo = true
return true
]], true)

test('preprocessor condition', [[
#local foo = true
#if !foo then
    return false
#else
    return true
#end
]], true)

test('preprocessor lepton table', [[
#write(('return %q'):format(lepton.VERSION))
]], lepton.VERSION)

test('preprocessor output variable', [[
#output = 'return 5'
]], 5)

test('preprocessor import function', [[
#import('toInclude')
return toInclude
]], 5)

test('preprocessor include function', [[
#include('toInclude.lua')
]], 5)

test('preprocessor write function', [[
#write('local a = true')
return a
]], true)

test('preprocessor placeholder function', [[
#placeholder('foo')
]], 5, { preprocessorEnv = { foo = 'return 5' } })

test('preprocessor options', [[
#if not foo == 'sky' then
    error('Invalid foo argument')
#end
return true
]], true, { foo = 'sky' })

test('preprocessor long comment', '--[[\n'..[[
#error('preprocessor should ignore long comments')
]]..']]'..[[
return true
]], true)

test('preprocessor long comment in long string', [[
a=]]..'[[--[[\n'..[[
#error('preprocessor should ignore long strings')
]]..']]'..[[
return a
]], '--[[\n'..[[
#error('preprocessor should ignore long strings')
]])

test('preprocessor macro remove function', [[
#define('log(...)', '')
log('test')
return true
]], true)

test('preprocessor macro replace function', [[
#define('log(x)', 'a = x')
log('test')
return a
]], 'test')

test('preprocessor macro identifier replace function', [[
#define('test(x)', 'x = 42')
test(hello)
return hello
]], 42)

test('preprocessor macro replace function with vararg', [[
#define('log(...)', 'a, b, c = ...')
log(1, 2, 3)
assert(a == 1)
assert(b == 2)
assert(c == 3)
return true
]], true)

test('preprocessor macro replace function with vararg and arg', [[
#define('log(x, ...)', 'a, b, c = x, ...')
log(1, 2, 3)
assert(a == 1)
assert(b == 2)
assert(c == 3)
return true
]], true)

test('preprocessor macro replace variable', [[
#define('a', '42')
return a
]], 42)

test('preprocessor macro prevent recursive macro', [[
#define('f(x)', 'x')
local x = 42
x = f(x)
return x
]], 42)

test('preprocessor macro replace variable with function', [[
#define('a', () -> { return '42' })
return a
]], 42)

test('preprocessor macro replace function with function', [[
#define('test(x)', x -> ('%s = 42'):format(x))
test(hello)
return hello
]], 42)
-- }}}

-- {{{ SYNTAX ADDITIONS
-- {{{ assignment operators
test('+=', [[
    local a = 5
    a += 2
    return a
]], 7)
test('-=', [[
    local a = 5
    a -= 2
    return a
]], 3)
test('*=', [[
    local a = 5
    a *= 2
    return a
]], 10)
test('/=', [[
    local a = 5
    a /= 2
    return a
]], 5/2)
test('//=', [[
    local a = 5
    a //= 2
    return a
]], 2)
test('^=', [[
    local a = 5
    a ^= 2
    return a
]], 25)
test('%=', [[
    local a = 5
    a %= 2
    return a
]], 5%2)
test('++=', [[
    local a = 'hello'
    a ++= ' world'
    return a
]], 'hello world')
test('&&=', [[
    local a = true
    a &&= 'world'
    return a
]], 'world')
test('||=', [[
    local a = false
    a ||= 'world'
    return a
]], 'world')
test('&=', [[
    local a = 5
    a &= 3
    return a
]], 1)
test('|=', [[
    local a = 5
    a |= 3
    return a
]], 7)
test('<<=', [[
    local a = 23
    a <<= 2
    return a
]], 92)
test('>>=', [[
    local a = 23
    a >>= 2
    return a
]], 5)

test('right assignment operators', [[
    local a = 5
    a =+ 2 assert(a == 7, '=+')
    a =- 2 assert(a == -5, '=-')
    a =* -2 assert(a == 10, '=*')
    a =/ 2 assert(a == 0.2, '=/')
    a =// 2 assert(a == 10, '=//')
    a =^ 2 assert(a == 1024, '=^')
    a =% 2000 assert(a == 976, '=%')

    a = 'world'
    a =++ 'hello ' assert(a == 'hello world', '=++')
    a =&& true assert(a == 'hello world', '=&&')

    a = false
    a =|| nil assert(a == false, '=||')

    a = 3
    a =& 5 assert(a == 1, '=&')
    a =| 20 assert(a == 21, '=|')
    a =<< 1 assert(a == 2097152, '=<<')

    a = 2
    a =>> 23 assert(a == 5, '=>>')
]], nil)

test('some left+right assignment operators', [[
    local a = 5
    a -=+ 2
    assert(a == 8, '-=+')

    a = 'hello'
    a ++=++ ' world ' assert(a == 'hello world hello', '++=++')
]], nil)

test('left assignment operators priority', [[
    local a = 5
    a *= 2 + 3
    return a
]], 25)
test('right assignment operators priority', [[
    local a = 5
    a =/ 2 + 3
    return a
]], 1)
test('left+right assignment operators priority', [[
    local a = 5
    a *=/ 2 + 3
    return a
]], 5)
-- }}}

-- {{{ default function parameters
test('default parameters', [[
    local fn test(hey, def='re', no, foo=('bar'):gsub('bar', 'batru')) {
        return def ++ foo
    }
    return test(78, 'SANDWICH', true)
]], 'SANDWICHbatru')
-- }}}

-- {{{ @ as self alias
test('@ as self alias', [[
    local a = {}
    fn a:hey() {
        return @ == self
    }
    return a:hey()
]], true)
test('@ as self alias with arrow method', [[
    local a = {}
    a.hey = :() -> @ == self
    return a:hey()
]], true)
test('@ as self alias and indexation', [[
    local a = {
        foo = 'Hoi'
    }
    fn a:hey() {
        return @.foo
    }
    return a:hey()
]], 'Hoi')
test('@ as self alias and indexation with arrow method', [[
    local a = {
        foo = 'Hoi'
    }
    a.hey = :() -> @.foo
    return a:hey()
]], 'Hoi')
test('@name indexation', [[
    local a = {
        foo = 'Hoi'
    }
    fn a:hey() {
        return @foo
    }
    return a:hey()
]], 'Hoi')
test('@name indexation with arrow method', [[
    local a = {
        foo = 'Hoi'
    }
    a.hey = :() -> @foo
    return a:hey()
]], 'Hoi')
test('@name method call', [[
    local a = {
        foo = 'Hoi',
        bar = fn(self) {
            return self.foo
        }
    }
    fn a:hey() {
        return @bar()
    }
    return a:hey()
]], 'Hoi')
test('@name method call with arrow method', [[
    local a = {
        foo = 'Hoi',
        bar = :() -> {
            return self.foo
        }
    }
    a.hey = :() -> @bar()
    return a:hey()
]], 'Hoi')
test('@[expt] indexation', [[
    local a = {
        foo = 'Hoi'
    }
    fn a:hey() {
        return @['foo']
    }
    return a:hey()
]], 'Hoi')
test('@[expt] indexation with arrow method', [[
    local a = {
        foo = 'Hoi'
    }
    a.hey = :() -> @['foo']
    return a:hey()
]], 'Hoi')
-- }}}

-- {{{ arrow functions
-- {{{ basic tests
test('arrow function', [[
    local a = (x) -> {
        return x
    }
    return a(5)
]], 5)
test('arrow method', [[
    local a = :(x) -> {
        return self + x
    }
    return a(2, 3)
]], 5)
test('arrow function', [[
    local a = (x) -> {
        return x
    }
    return a(5)
]], 5)
test('arrow method', [[
    local a = :(x) -> {
        return self + x
    }
    return a(2, 3)
]], 5)
-- }}}

-- {{{ implicit return
test('arrow function with implicit return', [[
    local a = (x) -> 2 * x
    return a(3)
]], 6)
test('arrow method with implicit return', [[
    local a = :(x) -> self * x
    return a(3, 3)
]], 9)
-- }}}

-- {{{ no parentheses
test('arrow function with no parens', [[
    local a = x -> {
        return 2 * x
    }
    return a(3)
]], 6)
test('arrow method with no parens', [[
    local a = :x -> {
        return self * x
    }
    return a(3, 3)
]], 9)
-- }}}

-- {{{ no parentheses and implicit return
test('arrow function with no parens and implicit return', [[
    local a = x -> 2 * x
    return a(3)
]], 6)
test('arrow method with no parens and implicit return', [[
    local a = :x -> self * x
    return a(3, 3)
]], 9)
-- }}}

-- {{{ implicit return and multiple parameters
test('arrow function with multiple parameters and implicit return', [[
    local a = (x, y) -> 2 * (x + y)
    return a(2, 3)
]], 10)
test('arrow method with multiple parameters and implicit return', [[
    local a = :(x, y) -> self * (x + y)
    return a(3, 4, 5)
]], 27)
-- }}}

-- {{{ horror
test('arrow function parsing edge cases', [[
    -- Taken from the file I used when solving this horror, too tired to make separate tests.
    x = ''
    fn a(s) {
        x = x ++ tostring(s || '+')
    }
    k=true
    while (k) {
        k=false
        cap = {[0] = op, a}
        a(tostring(h))
        if (true) {
            a()
            if (false) {
                a = x, (a)
                c()
            }
            a()
        }
        a()
    }
    a()
    a('l')
    let h = (h) -> {
        a('h')
    }
    h()
    a('lol')
    if (false) { exit() }
    a('pmo')
    if (true) {
        if (false) {
            a = (h)
        }

        a()
        a('pom')
    }
    a('lo')
    a('kol')
    if (false) {
        j()
        p()
    }
    do {
        b = [
        k = () -> {}
        if (false) {
            k = (lol) -> {
                error('niet')
            }
        }

        k()
        a()]
    }
    if (a()) { h() }
    local fn f(...) {
      if (select('#', ...) == 1) {
        return (...)
      } else {
        return '***'
      }
    }
    return f(x)
]], 'nil++++lhlolpmo+pomlokol++')
-- }}}
-- }}}

-- {{{ let variable declaration
test('let variable declaration', [[
    let a = {
        foo = fn() {
            return type(a)
        }
    }
    return a.foo()
]], 'table')
-- }}}

-- {{{ continue keyword
test('continue keyword in while', [[
    local a = ''
    local i = 0
    while (i < 10) {
        i = i + 1
        if (i % 2 == 0) {
            continue
        }
        a = a ++ i
    }
    return a
]], '13579')
test('continue keyword in while, used with break', [[
    local a = ''
    local i = 0
    while (i < 10) {
        i = i + 1
        if (i % 2 == 0) {
            continue
        }
        a = a ++ i
        if (i == 5) {
            break
        }
    }
    return a
]], '135')
test('continue keyword in repeat', [[
    local a = ''
    local i = 0
    repeat {
        i = i + 1
        if (i % 2 == 0) {
            continue
        }
        a = a ++ i
    } until (i == 10)
    return a
]], '13579')
test('continue keyword in repeat, used with break', [[
    local a = ''
    local i = 0
    repeat {
        i = i + 1
        if (i % 2 == 0) {
            continue
        }
        a = a ++ i
        if (i == 5) {
            break
        }
    } until (i == 10)
    return a
]], '135')
test('continue keyword in fornum', [[
    local a = ''
    for (i : 1, 10) {
        if (i % 2 == 0) {
            continue
        }
        a = a ++ i
    }
    return a
]], '13579')
test('continue keyword in fornum, used with break', [[
    local a = ''
    for (i : 1, 10) {
        if (i % 2 == 0) {
            continue
        }
        a = a ++ i
        if (i == 5) {
            break
        }
    }
    return a
]], '135')
test('continue keyword in for', [[
    local t = {1,2,3,4,5,6,7,8,9,10}
    local a = ''
    for (_, i : ipairs(t)) {
        if (i % 2 == 0) {
            continue
        }
        a = a ++ i
    }
    return a
]], '13579')
test('continue keyword in for, used with break', [[
    local t = {1,2,3,4,5,6,7,8,9,10}
    local a = ''
    for (_, i : ipairs(t)) {
        if (i % 2 == 0) {
            continue
        }
        a = a ++ i
        if (i == 5) {
            break
        }
    }
    return a
]], '135')
-- }}}

-- {{{ push keyword
test('push keyword', [[
    fn a() {
        for (i : 1, 5) {
            push i, 'next'
        }
        return 'done'
    }
    return table.concat({a()})
]], '1next2next3next4next5nextdone')
test('push keyword variable length', [[
    fn v() {
        return 'hey', 'hop'
    }
    fn w() {
        return 'foo', 'bar'
    }
    fn a() {
        push 5, v(), w()
        return
    }
    return table.concat({a()})
]], '5heyfoobar')
-- }}}

-- {{{ statement expressions
test('if statement expressions', [[
    a = if (false) {
        'foo' -- i.e. push 'foo', i.e. return 'foo'
    } else {
        'bar'
    }
    return a
]], 'bar')
-- FIX: do statement
test('do statement expressions', [[
    a = do {
        'bar'
    }
    return a
]], 'bar')
test('while statement expressions', [[
    i=0
    a, b, c = while (i < 2) { i = i + 1; i }
    return table.concat({a, b, tostring(c)})
]], '12nil')
test('repeat statement expressions', [[
    local i = 0
    a, b, c = repeat { i = i + 1; i } until (i == 2)
    return table.concat({a, b, tostring(c)})
]], '12nil')
test('for statement expressions', [[
    a, b, c = for (i : 1, 2) { i }
    return table.concat({a, b, tostring(c)})
]], '12nil')
-- }}}

-- {{{ table comprehension
test('table comprehension sequence', [[
    return table.concat([for (i : 1, 10) { i }])
]], '12345678910')
test('table comprehension associative/self', [[
    a = [for (i : 1, 10) { @[i] = true }]
    return a[1] && a[10]
]], true)
test('table comprehension variable length', [[
    local unpack = table.unpack || unpack
    t1 = {'hey', 'hop'}
    t2 = {'foo', 'bar'}
    return table.concat([push unpack(t1); push unpack(t2)])
]], 'heyhopfoobar')
-- }}}

-- {{{ one line statements
-- one line statements
test("one line if", [[
	a = 5
    if (false)
		a = 0
	return a
]], 5)
test("one line if-else if", [[
	a = 3
	if (false)
		a = 0
	else if (true)
		a = 5
	else if (false)
		a = -1
	return a
]], 5)
test("one line for", [[
	a = 0
    for (i : 1, 5)
		a = a + 1
	return a
]], 5)
test("one line while", [[
	a = 0
    while (a < 5)
		a = a + 1
	return a
]], 5)
test("one line function", [[
    a = 3
    b = fn(x)
        a = x
    a = 0
    b(5)
    return a
]], 5)
-- }}}

-- {{{ suffixables
-- {{{ string literals
test('suffixable string literal method', [[
    return 'foo':len()
]], 3)
test('suffixable string literal dot index', [[
    local a = 'foo'.len
    return a('foo')
]], 3)
test('suffixable string literal array index', [[
    local a = 'foo'['len']
    return a('foo')
]], 3)
-- }}}

-- {{{ table literals
test('suffixable table literal method', [[
    return {a=3,len=fn(t) { return t.a }}:len()
]], 3)
test('suffixable table literal dot index', [[
    return {len=3}.len
]], 3)
test('suffixable table literal array index', [[
    return {len=3}['len']
]], 3)
-- }}}

-- {{{ table comprehension
test('suffixable table comprehension method', [[
    return [@len = fn() { return 3 }]:len()
]], 3)
test('suffixable table comprehension dot index', [[
    return [@len = 3].len
]], 3)
test('suffixable table comprehension array index', [[
    return [@len=3]['len']
]], 3)
-- }}}
-- }}}

-- {{{ let in condition expression
-- {{{ while loop
test('let in while condition, evaluation each iteration', [[
    local s = ''
    local i = 0
    while ((a = i + 2) && i < 3) {
        s = s ++ tostring(a)
        i = i + 1
        a = 0
    }
    return s
]], '234')
test('let in while condition, scope', [[
    local s = ''
    local i = 0
    while ((a = i + 2) && i < 3) {
        s = s ++ tostring(a)
        i = i + 1
        a = 0
    }
    return a
]], nil)
test('several let in while condition, evaluation order', [[
    local s = ''
    local i = 0
    while ((a = (b = i + 1) + 1) && i < 3) {
        assert(b == i + 1)
        s = s ++ tostring(a)
        i = i + 1
        a = 0
    }
    return s
]], '234')
test('several let in while condition, only test the first', [[
    local s = ''
    local i = 0
    while ((a, b = false, i) && i < 3) {
        s = s ++ tostring(a)
        i = i + 1
    }
    return s
]], '')
-- }}}

-- {{{ if statement
test('let in if condition', [[
    if (a = false) {
        error('condition was false')
    } else if (b = nil) {
        error('condition was nil')
    } else if (c = true) {
        return 'ok'
    } else if (d = true) {
        error('should not be reachable')
    }
]], 'ok')
test('let in if condition, scope', [[
    local r
    if (a = false) {
        error('condition was false')
    } else if (b = nil) {
        error('condition was nil')
    } else if (c = true) {
        assert(a == false)
        assert(d == nil)
        r = 'ok'
    } else if (d = true) {
        error('should not be reachable')
    }
    assert(c == nil)
    return r
]], 'ok')
test('several let in if condition, only test the first', [[
    if (a = false) {
        error('condition was false')
    } else if (b = nil) {
        error('condition was nil')
    } else if (c, d = false, 'ok') {
        error('should have tested against c')
    } else {
        return d
    }
]], 'ok')
test('several let in if condition, evaluation order', [[
    local t = { k = 'ok' }
    if (a = t[b,c = 'k', 'l']) {
        assert(c == 'l')
        assert(b == 'k')
        return a
    }
]], 'ok')
-- }}}
-- }}}

-- {{{ method stubs
test('method stub, basic', [[
    local t = { s = 'ok', m = fn(self) { return self.s } }
    local f = t:m
    return f()
]], 'ok')
test('method stub, store method', [[
    local t = { s = 'ok', m = fn(self) { return self.s } }
    local f = t:m
    t.m = fn() { return 'not ok' }
    return f()
]], 'ok')
test('method stub, store object', [[
    local t = { s = 'ok', m = fn(self) { return self.s } }
    local f = t:m
    t = {}
    return f()
]], 'ok')
test('method stub, returns nil if method nil', [[
    local t = { m = nil }
    return t:m
]], nil)
-- }}}

-- {{{ safe prefixes
test('safe method stub, when nil', [[
    return t?:m
]], nil)
test('safe method stub, when non-nil', [[
    local t = { s = 'ok', m = fn(self) { return self.s } }
    return t?:m()
]], 'ok')

test('safe call, when nil', [[
    return f?()
]], nil)
test('safe call, when non nil', [[
    f = fn() { return 'ok' }
    return f?()
]], 'ok')

test('safe index, when nil', [[
    return f?.l
]], nil)
test('safe index, when non nil', [[
    f = { l = 'ok' }
    return f?.l
]], 'ok')

test('safe prefixes, random chaining', [[
    f = { l = { m = fn(s) { return s || 'ok' } } }
    assert(f?.l?.m() == 'ok')
    assert(f?.l?.o == nil)
    assert(f?.l?.o?() == nil)
    assert(f?.lo?.o?() == nil)
    assert(f?.l?:m?() == f.l)
    assert(f?.l:mo == nil)
    assert(f.l?:o?() == nil)
]])
-- }}}

-- {{{ destructuring assignments
-- {{{ normal
test('destructuring assignment with an expression', [[
    local {x, y} = { x = 5, y = 1 }
    return x + y
]], 6)
test('destructuring assignment with local', [[
    t = { x = 5, y = 1 }
    local {x, y} = t
    return x + y
]], 6)
test('destructuring assignment', [[
    t = { x = 5, y = 1 }
    {x, y} = t
    return x + y
]], 6)
test('destructuring assignment with +=', [[
    t = { x = 5, y = 1 }
    local x, y = 5, 9
    {x, y} += t
    return x + y
]], 20)
test('destructuring assignment with =-', [[
    t = { x = 5, y = 1 }
    local x, y = 5, 9
    {x, y} =- t
    return x + y
]], -8)
test('destructuring assignment with +=-', [[
    t = { x = 5, y = 1 }
    local x, y = 5, 9
    {x, y} +=- t
    return x + y
]], 6)
test('destructuring assignment with =-', [[
    t = { x = 5, y = 1 }
    local x, y = 5, 9
    {x, y} =- t
    return x + y
]], -8)
test('destructuring assignment with let', [[
    t = { x = 5, y = 1 }
    let {x, y} = t
    return x + y
]], 6)
test('destructuring assignment with for in', [[
    t = {{ x = 5, y = 1 }}
    for (k, {x, y} : pairs(t)) {
        return x + y
    }
]], 6)
test('destructuring assignment with if with assignment', [[
    t = { x = 5, y = 1 }
    if ({x, y} = t) {
        return x + y
    }
]], 6)
test('destructuring assignment with if-else if with assignment', [[
    t = { x = 5, y = 1 }
    if (({u} = t) && u) {
        return 0
    } else if ({x, y} = t) {
        return x + y
    }
]], 6)
-- }}}

-- {{{ custom name
test('destructuring assignment with an expression with custom name', [[
    local {o = x, y} = { o = 5, y = 1 }
    return x + y
]], 6)
test('destructuring assignment with local with custom name', [[
    t = { o = 5, y = 1 }
    local {o = x, y} = t
    return x + y
]], 6)
test('destructuring assignment with custom name', [[
    t = { o = 5, y = 1 }
    {o = x, y} = t
    return x + y
]], 6)
test('destructuring assignment with += with custom name', [[
    t = { o = 5, y = 1 }
    local x, y = 5, 9
    {o = x, y} += t
    return x + y
]], 20)
test('destructuring assignment with =- with custom name', [[
    t = { o = 5, y = 1 }
    local x, y = 5, 9
    {o = x, y} =- t
    return x + y
]], -8)
test('destructuring assignment with +=- with custom name', [[
    t = { o = 5, y = 1 }
    local x, y = 5, 9
    {o = x, y} +=- t
    return x + y
]], 6)
test('destructuring assignment with let with custom name', [[
    t = { o = 5, y = 1 }
    let {o = x, y} = t
    return x + y
]], 6)
test('destructuring assignment with for in with custom name', [[
    t = {{ o = 5, y = 1 }}
    for (k, {o = x, y} : pairs(t)) {
        return x + y
    }
]], 6)
test('destructuring assignment with if with assignment with custom name', [[
    t = { o = 5, y = 1 }
    if ({o = x, y} = t) {
        return x + y
    }
]], 6)
test('destructuring assignment with if-else if with assignment with custom name', [[
    t = { o = 5, y = 1 }
    if (({x} = t) && x) {
        return 0
    } else if ({o = x, y} = t) {
        return x + y
    }
]], 6)
-- }}}

-- {{{ expression as key
test('destructuring assignment with an expression with expression as key', [[
    local {[1] = x, y} = { 5, y = 1 }
    return x + y
]], 6)
test('destructuring assignment with local with expression as key', [[
    t = { 5, y = 1 }
    local {[1] = x, y} = t
    return x + y
]], 6)
test('destructuring assignment with expression as key', [[
    t = { 5, y = 1 }
    {[1] = x, y} = t
    return x + y
]], 6)
test('destructuring assignment with += with expression as key', [[
    t = { 5, y = 1 }
    local x, y = 5, 9
    {[1] = x, y} += t
    return x + y
]], 20)
test('destructuring assignment with =- with expression as key', [[
    t = { 5, y = 1 }
    local x, y = 5, 9
    {[1] = x, y} =- t
    return x + y
]], -8)
test('destructuring assignment with +=- with expression as key', [[
    t = { 5, y = 1 }
    local x, y = 5, 9
    {[1] = x, y} +=- t
    return x + y
]], 6)
test('destructuring assignment with let with expression as key', [[
    t = { 5, y = 1 }
    let {[1] = x, y} = t
    return x + y
]], 6)
test('destructuring assignment with for in with expression as key', [[
    t = {{ 5, y = 1 }}
    for (k, {[1] = x, y} : pairs(t)) {
        return x + y
    }
]], 6)
test('destructuring assignment with if with assignment with expression as key', [[
    t = { 5, y = 1 }
    if ({[1] = x, y} = t) {
        return x + y
    }
]], 6)
test('destructuring assignment with if-else if with assignment with expression as key', [[
    t = { 5, y = 1 }
    if (({x} = t) && x) {
        return 0
    } else if ({[1] = x, y} = t) {
        return x + y
    }
]], 6)
-- }}}
-- }}}

-- {{{ table concat
test('table.concat operator', [[
    return { 'Hello', 'world!' } +++ ' '
]], 'Hello world!')
test('table.concat operator priority over concat', [[
    return { 'Hello', 'world' } +++ ' ' ++ '!'
]], 'Hello world!')

test('table.concat with empty opts', [[
    return { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } +++ {}
]], '12345678910')
test('table.concat with sep in opts table', [[
    return { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } +++ { ' ' }
]], '1 2 3 4 5 6 7 8 9 10')
test('table.concat with i only', [[
    return { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } +++ { ' ', 6 }
]], '6 7 8 9 10')
test('table.concat with j only', [[
    return { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } +++ { ' ', nil, 5 }
]], '1 2 3 4 5')
test('table.concat with i and j', [[
    return { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } +++ { ' ', 2, 8 }
]], '2 3 4 5 6 7 8')
-- }}}

-- {{{ table append
test('table append assignment', [[
    local t = { 1, 2 }
    t #= 3
    return table.concat(t)
]], '123')
test('table append multiple assignment', [[
    local t, u, v = { 1, 2 }, { 4, 5 }, { 7, 8 }
    t, u, v #= 3, 6, 9
    return table.concat({ table.concat(t), table.concat(u), table.concat(v) })
]], '123456789')
-- }}}

-- {{{ broadcasting
test('broadcasting', [[
    t = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    func = v -> v * v

    return table.concat(func.(t), ' ')
]], '1 4 9 16 25 36 49 64 81 100')
test('broadcasting with key and value', [[
    t = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    func = (k, v) -> k * v

    return table.concat(func..(t), ' ')
]], '1 4 9 16 25 36 49 64 81 100')
test('broadcasting with key replacement', [[
    t = { 1, 2, 3 }
    func = v -> { v * 2, v * v }
    result = func.(t)

    return table.concat({ result[2], result[4], result[6] }, ' ')
]], '1 4 9')
-- }}}

-- {{{ filtering
test('filtering', [[
    t = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    predicate = v -> v !% 2

    return table.concat(predicate-<(t), ' ')
]], '1 3 5 7 9')
test('filtering with key and value', [[
    t = { 1, 4, 9, 16, 25, 36, 49, 64, 81, 100 }
    predicate = (k, v) -> k + v %% 4

    return table.concat(predicate-<<(t), ' ')
]], '9 16 49 64')
-- }}}

-- {{{ piping
-- {{{ normal
test('piping', [[
    func1 = x -> x * 2
    func2 = x -> x + 3

    return 3 |> func1 |> func2
]], 9)
test('piping with broadcast', [[
    t = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    func = x -> x * x

    return (t .|> func) +++ ' '
]], '1 4 9 16 25 36 49 64 81 100')
test('piping with key value broadcast', [[
    t = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    func = (x, y) -> x + y

    return (t ..|> func) +++ ' '
]], '2 4 6 8 10 12 14 16 18 20')
test('piping with key replacement broadcast', [[
    t = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    func = (x, y) -> x + y

    return (t ..|> func) +++ ' '
]], '2 4 6 8 10 12 14 16 18 20')
-- }}}

-- {{{ using arrow function inline
test('piping with arrow function', [[
    return 3 |> x -> x * 2 |> x -> x + 3
]], 9)
test('piping with arrow function and broadcast', [[
    t = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }

    return (t .|> x -> x * x) +++ ' '
]], '1 4 9 16 25 36 49 64 81 100')
test('piping with arrow function and key value broadcast', [[
    t = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }

    return (t ..|> (x, y) -> x + y) +++ ' '
]], '2 4 6 8 10 12 14 16 18 20')
test('piping with arrow function and key replacement broadcast', [[
    t = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }

    return (t ..|> (x, y) -> x + y) +++ ' '
]], '2 4 6 8 10 12 14 16 18 20')
-- }}}
-- }}}

-- {{{ string format
test('string.format shorthand', [[
    return 'my fav number: %d'(42)
]], 'my fav number: 42')
test('string.format shorthand with float', [[
    return 'pi: %.8f'(math.pi)
]], 'pi: 3.14159265')
-- }}}
-- }}}
-- }}}

-- {{{ print results
-- results
local resultCounter = {}
local testCounter = 0
for name, t in pairs(results) do
    -- print errors & fails
    if t.result ~= 'success' then
        print(c(t.result, 'bold') .. ': [' .. testCounter + 1 .. '] ' .. name)
        if t.message then print(t.message) end
        print('──────────')
    end
    -- count tests results
    resultCounter[t.result] = (resultCounter[t.result] or 0) + 1
    testCounter = testCounter + 1
end

-- final stats
for _, name in pairs({ { 'error', 'red' }, { 'fail', 'purple' }, { 'success', 'green' } }) do
    local count = resultCounter[name[1]] or 0
    print(c(count, 'bold', name[2]) .. c(' ' .. name[1] .. ' [' .. math.floor((count / testCounter * 100)*100)/100 .. '%]', name[2]))
end
print(c(testCounter .. ' total', 'bold'))
-- }}}
