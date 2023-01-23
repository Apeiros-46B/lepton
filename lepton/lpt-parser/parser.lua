-- {{{
--[[
This module implements a parser for Lua 5.3 with LPeg,
and generates an Abstract Syntax Tree that is similar to the one generated by Metalua.
For more information about Metalua, please, visit:
https://github.com/fab13n/metalua-parser

block: { stat* }

stat:
    `Do{ stat* }
  | `Set{ {lhs+} (opid? = opid?)? {expr+} }   -- lhs1, lhs2... op=op e1, e2...
  | `While{ lexpr block }                      -- while e do b end
  | `Repeat{ block expr }                     -- repeat b until e
  | `If{ (lexpr block)+ block? }              -- if e1 then b1 [elseif e2 then b2] ... [else bn] end
  | `Fornum{ ident expr expr expr? block }    -- for ident = e, e[, e] do b end
  | `Forin{ {ident+} {expr+} block }          -- for i1, i2... in e1, e2... do b end
  | `Local{ {attributeident+} {expr+}? }      -- local i1, i2... = e1, e2...
  | `Let{ {ident+} {expr+}? }                 -- let i1, i2... = e1, e2...
  | `Localrec{ {ident} {expr} }               -- only used for 'local function'
  | `Goto{ <string> }                         -- goto str
  | `Label{ <string> }                        -- ::str::
  | `Return{ <expr*> }                        -- return e1, e2...
  | `Break                                    -- break
  | `Push{ <exper*> }                         -- push
  | `Continue                                 -- continue
  | apply

expr:
    `Nil
  | `Dots
  | `Boolean{ <boolean> }
  | `Number{ <string> }  -- we don't use convert to number to avoid losing precision when tostring()-ing it later
  | `String{ <string> }
  | `Function{ { ( `ParPair{ Id expr } | `Id{ <string> } )* `Dots? } block }
  | `Table{ ( `Pair{ expr expr } | expr )* }
  | `Op{ opid expr expr? }
  | `Paren{ expr }       -- significant to cut multiple values returns
  | `TableCompr{ block }
  | `MethodStub{ expr expr }
  | `SafeMethodStub{ expr expr }
  | `SafeIndex{ expr expr }
  | statexpr
  | apply
  | lhs

lexpr:
    `LetExpr{ {ident+} {expr+}? }
  | every node from expr

statexpr:
    `DoExpr{ stat* }
  | `WhileExpr{ expr block }                    -- while e do b end
  | `RepeatExpr{ block expr }                   -- repeat b until e
  | `IfExpr{ (expr block)+ block? }             -- if e1 then b1 [elseif e2 then b2] ... [else bn] end
  | `FornumExpr{ ident expr expr expr? block }  -- for ident = e, e[, e] do b end
  | `ForinExpr{ {ident+} {expr+} block }        -- for i1, i2... in e1, e2... do b end

apply:
    `Call{ expr expr* }
  | `SafeCall{ expr expr* }

lhs: `Id{ <string> } | AttributeId{ <string> <string>? } | `Index{ expr expr } | ˇDestructuringId{ Id | Pair+ }

opid:  -- includes additional operators from Lua 5.3 and all relational operators
    'add'  | 'sub' | 'mul'  | 'div'
  | 'idiv' | 'mod' | 'pow'  | 'concat'
  | 'band' | 'bor' | 'bxor' | 'shl' | 'shr'
  | 'eq'   | 'ne'  | 'lt'   | 'gt'  | 'le'   | 'ge'
  | 'and'  | 'or'  | 'unm'  | 'len' | 'bnot' | 'not'
]]
-- }}}

-- {{{ import lpeg
local lpeg = require('lpeglabel')

lpeg.locale(lpeg)

local P, S, V = lpeg.P, lpeg.S, lpeg.V
local C, Carg, Cb, Cc = lpeg.C, lpeg.Carg, lpeg.Cb, lpeg.Cc
local Cf, Cg, Cmt, Cp, Cs, Ct = lpeg.Cf, lpeg.Cg, lpeg.Cmt, lpeg.Cp, lpeg.Cs, lpeg.Ct

-- lpeglabel
local Rec, T = lpeg.Rec, lpeg.T

local alpha, digit, alnum = lpeg.alpha, lpeg.digit, lpeg.alnum
local xdigit = lpeg.xdigit
local space = lpeg.space
-- }}}

-- {{{ error message auxiliary functions
local labels = {
    { 'ErrExtra', [[unexpected character(s), expected EOF]] },
    { 'ErrInvalidStat', [[unexpected token, invalid start of statement]] },

    { 'ErrExprIf', [[expected a condition after 'if']] },
    { 'ErrOIf', [[expected '{' after the condition]] },
    { 'ErrCIf', [[expected '}' to close the if statement]] },
    { 'ErrOElse', [[expected '{' after 'else']] },

    { 'ErrODo', [[expected '{' after 'do']] },
    { 'ErrCDo', [[expected '}' to close the do block]] },
    { 'ErrExprWhile', [[expected a condition after 'while']] },
    { 'ErrDoWhile', [[expected '{' after the condition]] },
    { 'ErrEndWhile', [[expected '}' to close the while loop]] },
    { 'ErrORep', [[expected '{' after 'repeat']] },
    { 'ErrCRep', [[expected '}' to close the repeat loop]] },
    { 'ErrUntilRep', [[expected 'until' after the end of the repeat loop]] },
    { 'ErrExprRep', [[expected a condition after 'until']] },

    { 'ErrOFor', [[expected '{' after the range of the for loop]] },
    { 'ErrForRange', [[expected a numeric or generic range after 'for']] },
    { 'ErrForRangeStart', [[expected a starting expression for the numeric range]] },
    { 'ErrForRangeComma', [[expected ',' to split the start and end of the range]] },
    { 'ErrForRangeEnd', [[expected an ending expression for the numeric range]] },
    { 'ErrForRangeStep', [[expected a step expression for the numeric range after ',']] },
    { 'ErrInFor', [[expected ':' after the variable(s)]] },
    { 'ErrEListFor', [[expected one or more expressions after ':']] },
    { 'ErrCFor', [[expected '}' to close the for loop]] },

    { 'ErrDefLocal', [[expected a function definition or assignment after 'local']] },
    { 'ErrDefLet', [[expected an assignment after 'let']] },
    { 'ErrDefClose', [[expected an assignment after 'close']] },
    { 'ErrDefConst', [[expected an assignment after 'const']] },
    { 'ErrNameLFunc', [[expected a function name after 'local fn']] },
    { 'ErrEListLAssign', [[expected one or more expressions after '=']] },
    { 'ErrEListAssign', [[expected one or more expressions after '=']] },

    { 'ErrFuncName', [[expected a function name after 'fn']] },
    { 'ErrNameFunc1', [[expected a function name after '.']] },
    { 'ErrNameFunc2', [[expected a method name after ':']] },
    { 'ErrOParenPList', [[expected '(' before the parameter list]] },
    { 'ErrCParenPList', [[expected ')' to close the parameter list]] },
    { 'ErrOFunc', [[expected '{' after the parameter list]] },
    { 'ErrCFunc', [[expected '}' to close the function body]] },
    { 'ErrArrowFuncArrow', [[expected '->' after the arrow function parameter(s)]] },
    { 'ErrOArrowFunc', [[expected '{' after '->']] },
    { 'ErrCArrowFunc', [[expected '}' to close the arrow function]] },
    { 'ErrParList', [[expected a variable name or '...' after ',']] },

    { 'ErrLabel', [[expected a label name after '::']] },
    { 'ErrCloseLabel', [[expected '::' after the label]] },
    { 'ErrGoto', [[expected a label after 'goto']] },
    { 'ErrRetList', [[expected an expression after ',' in the return statement]] },

    { 'ErrVarList', [[expected a variable name after ',']] },
    { 'ErrExprList', [[expected an expression after ',']] },

    { 'ErrOParenExpr', [[expected '(' before the expression]] },
    { 'ErrCParenExpr', [[expected ')' after the expression]] },

    { 'ErrOrExpr', [[expected an expression after '||']] },
    { 'ErrAndExpr', [[expected an expression after '&&']] },
    { 'ErrRelExpr', [[expected an expression after the relational operator]] },
    { 'ErrBOrExpr', [[expected an expression after '|']] },
    { 'ErrBXorExpr', [[expected an expression after '~']] },
    { 'ErrBAndExpr', [[expected an expression after '&']] },
    { 'ErrShiftExpr', [[expected an expression after the bit shift]] },
    { 'ErrConcatExpr', [[expected an expression after '++']] },
    { 'ErrTConcatExpr', [[expected an expression after '+++']] },
    { 'ErrAddExpr', [[expected an expression after the additive operator]] },
    { 'ErrMulExpr', [[expected an expression after the multiplicative operator]] },
    { 'ErrUnaryExpr', [[expected an expression after the unary operator]] },
    { 'ErrPowExpr', [[expected an expression after '^']] },

    { 'ErrExprParen', [[expected an expression after '(']] },
    { 'ErrCParenExpr', [[expected ')' to close the expression]] },
    { 'ErrNameIndex', [[expected a field name after '.']] },
    { 'ErrExprIndex', [[expected an expression after '[']] },
    { 'ErrCBracketIndex', [[expected ']' to close the indexing expression]] },
    { 'ErrNameMeth', [[expected a method name after ':']] },
    { 'ErrMethArgs', [[expected some arguments for the method call (or '()')]] },

    { 'ErrArgList', [[expected an expression after ',' in the argument list]] },
    { 'ErrOParenArgs', [[expected '(' before the argument list]] },
    { 'ErrCParenArgs', [[expected ')' to close the argument list]] },

    { 'ErrCBraceTable', [[expected '}' to close the table constructor]] },
    { 'ErrEqField', [[expected '=' after the table key]] },
    { 'ErrExprField', [[expected an expression after '=']] },
    { 'ErrExprFKey', [[expected an expression after '[' for the table key]] },
    { 'ErrCBracketFKey', [[expected ']' to close the table key]] },

    { 'ErrCBraceDestructuring', [[expected '}' to close the destructuring variable list]] },
    { 'ErrDestructuringEqField', [[expected '=' after the table key in destructuring variable list]] },
    { 'ErrDestructuringExprField', [[expected an identifier after '=' in destructuring variable list]] },

    { 'ErrCBracketTableCompr', [[expected ']' to close the table comprehension]] },

    { 'ErrDigitHex', [[expected one or more hexadecimal digits after '0x']] },
    { 'ErrDigitDeci', [[expected one or more digits after the decimal point]] },
    { 'ErrDigitExpo', [[expected one or more digits for the exponent]] },

    { 'ErrQuote', [[unclosed string]] },
    { 'ErrHexEsc', [[expected exactly two hexadecimal digits after '\x']] },
    { 'ErrOBraceUEsc', [[expected '{' after '\u']] },
    { 'ErrDigitUEsc', [[expected one or more hexadecimal digits for the UTF-8 code point]] },
    { 'ErrCBraceUEsc', [[expected '}' after the code point]] },
    { 'ErrEscSeq', [[invalid escape sequence]] },
    { 'ErrCloseLStr', [[unclosed long string]] },

    { 'ErrUnknownAttribute', [[unknown variable attribute]] },
    { 'ErrCBracketAttribute', [[expected '>' to close the variable attribute]] },
}

local function throw(label)
    label = 'Err' .. label

    for i, labelinfo in ipairs(labels) do
        if labelinfo[1] == label then
            return T(i)
        end
    end

    error('Label not found: ' .. label)
end

local function e(patt, label)
    return patt + throw(label)
end
-- }}}

-- {{{ regular combinators and auxiliary functions
local function token(patt)
    return patt * V'Skip'
end

local function sym(str)
    return token(P(str))
end

local function kw(str)
    return token(P(str) * -V'IdRest')
end

local function parenAround(expr)
    return sym('(') * expr * sym(')')
end

local function tagC(tag, patt)
    return Ct(Cg(Cp(), 'pos') * Cg(Cc(tag), 'tag') * patt)
end

local function unaryOp(op, e)
    return { tag = 'Op', pos = e.pos, [1] = op, [2] = e }
end

local function binaryOp(e1, op, e2)
    if not op then
        return e1
    else
        return { tag = 'Op', pos = e1.pos, [1] = op, [2] = e1, [3] = e2 }
    end
end

local function sepBy(patt, sep, label)
    if label then
        return patt * Cg(sep * e(patt, label))^0
    else
        return patt * Cg(sep * patt)^0
    end
end

local function chainOp(patt, sep, label)
    return Cf(sepBy(patt, sep, label), binaryOp)
end

local function commaSep(patt, label)
    return sepBy(patt, sym(','), label)
end

local function tagDo(block)
    block.tag = 'Do'
    return block
end

local function fixFuncStat(func)
    if func[1].is_method then table.insert(func[2][1], 1, { tag = 'Id', [1] = 'self' }) end
    func[1] = {func[1]}
    func[2] = {func[2]}
    return func
end

local function addDots(params, dots)
    if dots then table.insert(params, dots) end
    return params
end

local function insertIndex(t, index)
    return { tag = 'Index', pos = t.pos, [1] = t, [2] = index }
end

local function markMethod(t, method)
    if method then
        return { tag = 'Index', pos = t.pos, is_method = true, [1] = t, [2] = method }
    end
    return t
end

-- lets you name variables with names that are keywords in Lua but not Lepton
local function fixLuaKeywords(t)
    local keywords = { 'and', 'do', 'elseif', 'end', 'function', 'in', 'not', 'or', 'then' }
    if t.tag == 'Pair' then
        for _, v in pairs(keywords) do
            if t[1][1] == v then
                t[1][1] = '_' .. t[1][1]
                break
            end
        end
    else
        for _, v in pairs(keywords) do
            if t[1] == v then
                t[1] = '_' .. t[1]
                break
            end
        end
    end
    return t
end

local function makeSuffixedExpr(t1, t2)
    if t2.tag == 'Call' or t2.tag == 'SafeCall' then
        local t = { tag = t2.tag, pos = t1.pos, [1] = t1 }
        for k, v in ipairs(t2) do
            table.insert(t, v)
        end
        return t
    elseif t2.tag == 'MethodStub' or t2.tag == 'SafeMethodStub' then
        return { tag = t2.tag, pos = t1.pos, [1] = t1, [2] = fixLuaKeywords(t2[1]) }
    elseif t2.tag == 'SafeDotIndex' or t2.tag == 'SafeArrayIndex' then
        return { tag = 'SafeIndex', pos = t1.pos, [1] = t1, [2] = fixLuaKeywords(t2[1]) }
    elseif t2.tag == 'DotIndex' or t2.tag == 'ArrayIndex' then
        return { tag = 'Index', pos = t1.pos, [1] = t1, [2] = fixLuaKeywords(t2[1]) }
    else
        error('unexpected tag in suffixed expression')
    end
end

local function fixArrowFunc(t)
    if t[1] == ':' then -- self method
        table.insert(t[2], 1, { tag = 'Id', 'self' })
        table.remove(t, 1)
        t.is_method = true
    end
    t.is_short = true
    return t
end

local function markImplicit(t)
    t.implicit = true
    return t
end

local function statToExpr(t) -- tag a StatExpr
    t.tag = t.tag .. 'Expr'
    return t
end

local function fixStructure(t) -- fix the AST structure if needed
    local i = 1
    while i <= #t do
        if type(t[i]) == 'table' then
            fixStructure(t[i])
            for j=#t[i], 1, -1 do
                local stat = t[i][j]
                if type(stat) == 'table' and stat.move_up_block and stat.move_up_block > 0 then
                    table.remove(t[i], j)
                    table.insert(t, i+1, stat)
                    if t.tag == 'Block' or t.tag == 'Do' then
                        stat.move_up_block = stat.move_up_block - 1
                    end
                end
            end
        end
        i = i + 1
    end
    return t
end

local function eStart(label)
    return e(sym('{'), label)
end

local function eEnd(label)
    return e(sym('}'), label)
end

local function eBlkStartEnd(startLabel, endLabel, canFollow)
    if canFollow then
        return eStart(startLabel) * V'Block' * eEnd(endLabel) * canFollow^-1
    else
        return eStart(startLabel) * V'Block' * eEnd(endLabel)
    end
end

local function eBlkStartEndOrSingleStat(startLabel, endLabel, canFollow) -- will try a SingleStat if start doesn't match
    local start = sym('{')
    if canFollow then
        return (-start * V'SingleStatBlock' * canFollow^-1)
             + (eStart(startLabel) * V'Block' * (eEnd(endLabel) * canFollow + eEnd(endLabel)))
    else
        return (-start * V'SingleStatBlock')
             + (eStart(startLabel) * V'Block' * eEnd(endLabel))
    end
end

local function mb(patt) -- fail pattern instead of propagating errors
    return #patt/0 * patt
end

local function setAttribute(attribute)
    return function(assign)
        assign[1].tag = 'AttributeNameList'
        for _, id in ipairs(assign[1]) do
            if id.tag == 'Id' then
                id.tag = 'AttributeId'
                id[2] = attribute
            elseif id.tag == 'DestructuringId' then
                for _, did in ipairs(id) do
                    did.tag = 'AttributeId'
                    did[2] = attribute
                end
            end
        end
        return assign
    end
end

local stacks = {
    lexpr = {}
}
local function push(f)
    return Cmt(P'', function()
        table.insert(stacks[f], true)
        return true
    end)
end
local function pop(f)
    return Cmt(P'', function()
        table.remove(stacks[f])
        return true
    end)
end
local function when(f)
    return Cmt(P'', function()
        return #stacks[f] > 0
    end)
end
local function set(f, patt) -- patt *must* succeed (or throw an error) to preserve stack integrity
    return push(f) * patt * pop(f)
end
-- }}}

-- {{{ grammar
local G = { V'Lua',
    Lua      = (V'Shebang'^-1 * V'Skip' * V'Block' * e(P(-1), 'Extra')) / fixStructure;
    Shebang  = P'#!' * (P(1) - P'\n')^0;

    Block       = tagC('Block', (V'Stat' + -V'BlockEnd' * throw('InvalidStat'))^0 * ((V'RetStat' + V'ImplicitPushStat') * sym(';')^-1)^-1);
    Stat        = V'IfStat' + V'DoStat' + V'WhileStat' + V'RepeatStat' + V'ForStat'
                + V'LocalStat' + V'FuncStat' + V'BreakStat' + V'LabelStat' + V'GoToStat'
                + V'LetStat' + V'ConstStat' + V'CloseStat'
                + V'FuncCall' + V'Assignment'
                + V'ContinueStat' + V'PushStat'
                + sym(';');
    BlockEnd    = P'return' + sym('}') + ']' + -1 + V'ImplicitPushStat' + V'Assignment';

    SingleStatBlock = tagC('Block', V'Stat' + V'RetStat' + V'ImplicitPushStat');
    BlockNoErr      = tagC('Block', V'Stat'^0 * ((V'RetStat' + V'ImplicitPushStat') * sym(';')^-1)^-1); -- used to check if something a valid block without throwing an error

    IfStat      = tagC('If', V'IfPart');
    IfPart      = kw('if') * set('lexpr', e(parenAround(V'Expr'), 'ExprIf')) * eBlkStartEndOrSingleStat('OIf', 'CIf', V'ElseIfPart' + V'ElsePart');
    ElseIfPart  = kw('else') * V'IfPart';
    ElsePart    = kw('else') * eBlkStartEndOrSingleStat('OElse', 'CIf');

    DoStat      = kw('do') * eBlkStartEndOrSingleStat('ODo', 'CDo') / tagDo;
    WhileStat   = tagC('While', kw('while') * set('lexpr', e(parenAround(V'Expr'), 'ExprWhile')) * V'WhileBody');
    WhileBody   = eBlkStartEndOrSingleStat('DoWhile', 'EndWhile');
    RepeatStat  = tagC('Repeat', kw('repeat') * eBlkStartEndOrSingleStat('ORep', 'CRep') * e(kw('until'), 'UntilRep') * e(parenAround(V'Expr'), 'ExprRep'));

    ForStat   = kw('for') * e(V'ForNum' + V'ForIn', 'ForRange');
    ForNum    = tagC('Fornum', parenAround(V'Id' * sym(':') * V'NumRange') * V'ForBody');
    NumRange  = e(V'Expr', 'ForRangeStart') * e(sym(','), 'ForRangeComma') * e(V'Expr', 'ForRangeEnd')
              * (sym(':') * e(V'Expr', 'ForRangeStep'))^-1;
    ForIn     = tagC('Forin', parenAround(V'DestructuringNameList' * e(sym(':'), 'InFor') * e(V'ExprList', 'EListFor')) * V'ForBody');
    ForBody   = eBlkStartEndOrSingleStat('OFor', 'CFor');

    LocalStat    = kw('local') * e(V'LocalFunc' + V'LocalAssign', 'DefLocal');
    LocalFunc    = tagC('Localrec', kw('fn') * e(V'Id', 'NameLFunc') * V'FuncBody') / fixFuncStat;
    LocalAssign  = tagC('Local', V'AttributeNameList' * (sym('=') * e(V'ExprList', 'EListLAssign') + Ct(Cc())))
                 + tagC('Local', V'DestructuringNameList' * sym('=') * e(V'ExprList', 'EListLAssign'));

    LetStat      = kw('let') * e(V'LetAssign', 'DefLet');
    LetAssign    = tagC('Let', V'NameList' * (sym('=') * e(V'ExprList', 'EListLAssign') + Ct(Cc())))
                 + tagC('Let', V'DestructuringNameList' * sym('=') * e(V'ExprList', 'EListLAssign'));

    ConstStat       = kw('const') * e(V'AttributeAssign' / setAttribute('const'), 'DefConst');
    CloseStat       = kw('close') * e(V'AttributeAssign' / setAttribute('close'), 'DefClose');
    AttributeAssign = tagC('Local', V'NameList' * (sym('=') * e(V'ExprList', 'EListLAssign') + Ct(Cc())))
                    + tagC('Local', V'DestructuringNameList' * sym('=') * e(V'ExprList', 'EListLAssign'));

    Assignment  = tagC('Set', (V'VarList' + V'DestructuringNameList') * V'BinOp'^-1 * ((P'=' - '==') / '=')
                * ((V'BinOp' - P'-') + #(P'-' * V'Space') * V'BinOp')^-1 * V'Skip' * e(V'ExprList', 'EListAssign'));

    FuncStat    = tagC('Set', kw('fn') * e(V'FuncName', 'FuncName') * V'FuncBody') / fixFuncStat;
    FuncName    = Cf(V'Id' * (sym('.') * e(V'StrId', 'NameFunc1'))^0, insertIndex)
                * (sym(':') * e(V'StrId', 'NameFunc2'))^-1 / markMethod;
    FuncBody    = tagC('Function', V'FuncParams' * eBlkStartEndOrSingleStat('OFunc', 'CFunc'));
    FuncParams  = e(sym('('), 'OParenPList') * V'ParList' * e(sym(')'), 'CParenPList');
    ParList     = V'NamedParList' * (sym(',') * e(tagC('Dots', sym('...')), 'ParList'))^-1 / addDots
                + Ct(tagC('Dots', sym('...')))
                + Ct(Cc()); -- Cc({}) generates a bug since the {} would be shared across parses

    ArrowFuncDef    = tagC('Function', V'ArrowFuncParams' * sym('->') * V'ArrowFuncBody') / fixArrowFunc;
    ArrowFuncParams = (sym(':') / ':')^-1 * (parenAround(V'ParList') + tagC('NamedPar', V'NamedPar'));
    ArrowFuncBody   = (-sym('{') * tagC('Block', tagC('Push', V'Expr')) * -sym('}')) + eBlkStartEnd('OArrowFunc', 'CArrowFunc');

    NamedParList  = tagC('NamedParList', commaSep(V'NamedPar'));
    NamedPar      = tagC('ParPair', V'ParKey' * e(sym('='), 'EqField') * e(V'Expr', 'ExprField')) + V'Id';
    ParKey        = V'Id' * #('=' * -P'=');

    LabelStat       = tagC('Label', sym('::') * e(V'Name', 'Label') * e(sym('::'), 'CloseLabel'));
    GoToStat        = tagC('Goto', kw('goto') * e(V'Name', 'Goto'));
    BreakStat       = tagC('Break', kw('break'));
    ContinueStat    = tagC('Continue', kw('continue'));
    RetStat         = tagC('Return', kw('return') * commaSep(V'Expr', 'RetList')^-1);

    PushStat         = tagC('Push', kw('push') * commaSep(V'Expr', 'RetList')^-1);
    ImplicitPushStat = tagC('Push', commaSep(V'Expr', 'RetList')) / markImplicit;

    NameList              = tagC('NameList', commaSep(V'Id'));
    DestructuringNameList = tagC('NameList', commaSep(V'DestructuringId')),
    AttributeNameList     = tagC('AttributeNameList', commaSep(V'AttributeId'));
    VarList               = tagC('VarList', commaSep(V'VarExpr'));
    ExprList              = tagC('ExpList', commaSep(V'Expr', 'ExprList'));

    DestructuringId          = tagC('DestructuringId', sym('{') * V'DestructuringIdFieldList' * e(sym('}'), 'CBraceDestructuring')) + V'Id',
    DestructuringIdFieldList = sepBy(V'DestructuringIdField', V'FieldSep') * V'FieldSep'^-1;
    DestructuringIdField     = tagC('Pair', V'FieldKey' * e(sym('='), 'DestructuringEqField') * e(V'Id', 'DestructuringExprField')) + V'Id';

    Expr        = V'OrExpr';
    OrExpr      = chainOp(V'AndExpr', V'OrOp', 'OrExpr');
    AndExpr     = chainOp(V'RelExpr', V'AndOp', 'AndExpr');
    RelExpr     = chainOp(V'BOrExpr', V'RelOp', 'RelExpr');
    BOrExpr     = chainOp(V'BXorExpr', V'BOrOp', 'BOrExpr');
    BXorExpr    = chainOp(V'BAndExpr', V'BXorOp', 'BXorExpr');
    BAndExpr    = chainOp(V'ShiftExpr', V'BAndOp', 'BAndExpr');
    ShiftExpr   = chainOp(V'ConcatExpr', V'ShiftOp', 'ShiftExpr');
    ConcatExpr  = V'TConcatExpr' * (V'ConcatOp' * e(V'ConcatExpr', 'ConcatExpr'))^-1 / binaryOp;
    TConcatExpr = V'AddExpr' * (V'TConcatOp' * e(V'TConcatExpr', 'TConcatExpr'))^-1 / binaryOp;
    AddExpr     = chainOp(V'MulExpr', V'AddOp', 'AddExpr');
    MulExpr     = chainOp(V'UnaryExpr', V'MulOp', 'MulExpr');
    UnaryExpr   = V'UnaryOp' * e(V'UnaryExpr', 'UnaryExpr') / unaryOp
                + V'PowExpr';
    PowExpr     = V'SimpleExpr' * (V'PowOp' * e(V'UnaryExpr', 'PowExpr'))^-1 / binaryOp;
    SimpleExpr  = tagC('Number', V'Number')
                + tagC('Nil', kw('nil'))
                + tagC('Boolean', kw('false') * Cc(false))
                + tagC('Boolean', kw('true') * Cc(true))
                + tagC('Dots', sym('...'))
                + V'FuncDef'
                + V'ArrowFuncDef'
                + (when('lexpr') * tagC('LetExpr', mb(V'DestructuringNameList') * sym('=') * -sym('=') * e(V'ExprList', 'EListLAssign')))
                + V'SuffixedExpr'
                + V'StatExpr';

    StatExpr = (V'IfStat' + V'DoStat' + V'WhileStat' + V'RepeatStat' + V'ForStat') / statToExpr;

    FuncCall  = Cmt(V'SuffixedExpr', function(s, i, exp) return exp.tag == 'Call' or exp.tag == 'SafeCall', exp end);
    VarExpr   = Cmt(V'SuffixedExpr', function(s, i, exp) return exp.tag == 'Id' or exp.tag == 'Index', exp end);

    SuffixedExpr      = Cf(V'PrimaryExpr' * (V'Index' + V'MethodStub' + V'Call')^0
                      + V'NoCallPrimaryExpr' * -V'Call' * (V'Index' + V'MethodStub' + V'Call')^0
                      + V'NoCallPrimaryExpr', makeSuffixedExpr);
    PrimaryExpr       = V'SelfId' * (V'SelfCall' + V'SelfIndex')
                      + V'Id'
                      + tagC('Paren', sym('(') * e(V'Expr', 'ExprParen') * e(sym(')'), 'CParenExpr'));
    NoCallPrimaryExpr = tagC('String', V'String') + V'Table' + V'TableCompr';
    Index             = tagC('DotIndex', sym('.' * -P'.') * e(V'StrId', 'NameIndex'))
                      + tagC('ArrayIndex', sym('[' * -P(S'=[')) * e(V'Expr', 'ExprIndex') * e(sym(']'), 'CBracketIndex'))
                      + tagC('SafeDotIndex', sym('?.' * -P'.') * e(V'StrId', 'NameIndex'))
                      + tagC('SafeArrayIndex', sym('?[' * -P(S'=[')) * e(V'Expr', 'ExprIndex') * e(sym(']'), 'CBracketIndex'));
    MethodStub        = tagC('MethodStub', sym(':' * -P':') * e(V'StrId', 'NameMeth'))
                      + tagC('SafeMethodStub', sym('?:' * -P':') * e(V'StrId', 'NameMeth'));
    Call              = tagC('Call', V'FuncArgs')
                      + tagC('SafeCall', P'?' * V'FuncArgs');
    SelfCall          = tagC('MethodStub', V'StrId') * V'Call';
    SelfIndex         = tagC('DotIndex', V'StrId');

    FuncDef   = (kw('fn') * V'FuncBody');
    FuncArgs  = sym('(') * commaSep(V'Expr', 'ArgList')^-1 * e(sym(')'), 'CParenArgs');

    Table      = tagC('Table', sym('{') * V'FieldList'^-1 * e(sym('}'), 'CBraceTable'));
    FieldList  = sepBy(V'Field', V'FieldSep') * V'FieldSep'^-1;
    Field      = tagC('Pair', V'FieldKey' * e(sym('='), 'EqField') * e(V'Expr', 'ExprField')) / fixLuaKeywords
               + V'Expr';
    FieldKey   = sym('[' * -P(S'=[')) * e(V'Expr', 'ExprFKey') * e(sym(']'), 'CBracketFKey')
               + V'StrId' * #('=' * -P'=');
    FieldSep   = sym(',') + sym(';');

    TableCompr = tagC('TableCompr', sym('[') * V'Block' * e(sym(']'), 'CBracketTableCompr'));

    SelfId = tagC('Id', sym('@') / 'self');
    Id     = (tagC('Id', V'Name') / fixLuaKeywords) + V'SelfId';
    AttributeSelfId = tagC('AttributeId', sym'@' / 'self' * V'Attribute'^-1);
    AttributeId     = tagC('AttributeId', V'Name' * V'Attribute'^-1) / fixLuaKeywords + V'AttributeSelfId';
    StrId  = tagC('String', V'Name');

    Attribute = sym('<') * e(kw'const' / 'const' + kw'close' / 'close', 'UnknownAttribute') * e(sym('>'), 'CBracketAttribute');

    -- lexer
    Skip     = (V'Space' + V'Comment')^0;
    Space    = space^1;
    Comment  = P'--' * V'LongStr' / 0
             + P'--' * (P(1) - P'\n')^0;

    Name        = token(-V'Reserved' * C(V'Ident'));
    Reserved    = V'Keywords' * -V'IdRest';
    Keywords    = P'close' + 'const' + 'fn' + 'global'
                + 'let' + 'push' + 'break' + 'else'
                + 'false' + 'for' + 'goto' + 'if'
                + 'local' + 'nil' + 'repeat'
                + 'return' + 'true' + 'until' + 'while';
    Ident       = V'IdStart' * V'IdRest'^0;
    IdStart     = alpha + P'_';
    IdRest      = alnum + P'_';

    Number   = token(C(V'Hex' + V'Float' + V'Int'));
    Hex      = (P'0x' + '0X') * ((xdigit^0 * V'DeciHex') + (e(xdigit^1, 'DigitHex') * V'DeciHex'^-1)) * V'ExpoHex'^-1;
    Float    = V'Decimal' * V'Expo'^-1
             + V'Int' * V'Expo';
    Decimal  = digit^1 * '.' * digit^0
             + P'.' * -P'.' * e(digit^1, 'DigitDeci');
    DeciHex  = P'.' * xdigit^0;
    Expo     = S'eE' * S'+-'^-1 * e(digit^1, 'DigitExpo');
    ExpoHex  = S'pP' * S'+-'^-1 * e(xdigit^1, 'DigitExpo');
    Int      = digit^1;

    String    = token(V'ShortStr' + V'LongStr');
    ShortStr  = P'"' * Cs((V'EscSeq' + (P(1)-S'"\n'))^0) * e(P'"', 'Quote')
              + P"'" * Cs((V'EscSeq' + (P(1)-S"'\n"))^0) * e(P"'", 'Quote');

    EscSeq = P'\\' / ''  -- remove backslash
           * ( P'a' / '\a'
             + P'b' / '\b'
             + P'f' / '\f'
             + P'n' / '\n'
             + P'r' / '\r'
             + P't' / '\t'
             + P'v' / '\v'

             + P'\n' / '\n'
             + P'\r' / '\n'

             + P'\\' / '\\'
             + P'\"' / '\"'
             + P'\'' / '\''

             + P'z' * space^0  / ''

             + digit * digit^-2 / tonumber / string.char
             + P'x' * e(C(xdigit * xdigit), 'HexEsc') * Cc(16) / tonumber / string.char
             + P'u' * e('{', 'OBraceUEsc')
                    * e(C(xdigit^1), 'DigitUEsc') * Cc(16)
                    * e('}', 'CBraceUEsc')
                    / tonumber
                    / (utf8 and utf8.char or string.char)  -- true max is \u{10FFFF}
                                                           -- utf8.char needs Lua 5.3
                                                           -- string.char works only until \u{FF}

             + throw('EscSeq')
             );

    LongStr  = V'Open' * C((P(1) - V'CloseEq')^0) * e(V'Close', 'CloseLStr') / function (s, eqs) return s end;
    Open     = '[' * Cg(V'Equals', 'openEq') * '[' * P'\n'^-1;
    Close    = ']' * C(V'Equals') * ']';
    Equals   = P'='^0;
    CloseEq  = Cmt(V'Close' * Cb('openEq'), function (s, i, closeEq, openEq) return #openEq == #closeEq end);

    OrOp      = sym('||')         / 'or';
    AndOp     = sym('&&')         / 'and';
    RelOp     = sym('!=')         / 'ne'
              + sym('==')         / 'eq'
              + sym('<=')         / 'le'
              + sym('>=')         / 'ge'
              + sym('<')          / 'lt'
              + sym('>')          / 'gt'
              + sym('%%')         / 'divb'; -- divisibility operator
    BOrOp     = sym('|' - P'||')  / 'bor';
    BXorOp    = sym('~')          / 'bxor';
    BAndOp    = sym('&' - P'&&')  / 'band';
    ShiftOp   = sym('<<')         / 'shl'
              + sym('>>')         / 'shr';
    ConcatOp  = sym('++')         / 'concat';
    TConcatOp = sym('+++')        / 'tconcat'; -- table.concat sugar
    AddOp     = sym('+' - P'++')  / 'add'
              + sym('-' - P'->')  / 'sub';
    AppendOp  = sym('#=')         / 'tappend'; -- t
    MulOp     = sym('*')          / 'mul'
              + sym('//')         / 'idiv'
              + sym('/')          / 'div'
              + sym('%' - P'%%')  / 'mod';
    UnaryOp   = sym('!')          / 'not'
              + sym('-')          / 'unm'
              + sym('#' - P'#=')  / 'len'
              + sym('~')          / 'bnot';
    PowOp     = sym('^')          / 'pow';
    BinOp     = V'OrOp' + V'AndOp' + V'BOrOp' + V'BXorOp' + V'BAndOp' + V'ShiftOp' + V'ConcatOp' + V'TConcatOp' + V'AddOp' + V'MulOp' + V'PowOp';
}
-- }}}

-- {{{ macro grammar
local macroidentifier = {
    e(V'MacroIdentifier', 'InvalidStat') * e(P(-1), 'Extra'),

    MacroIdentifier   = tagC('MacroFunction', V'Id' * sym('(') * V'MacroFunctionArgs' * e(sym(')'), 'CParenPList'))
                      + V'Id';

    MacroFunctionArgs = V'NameList' * (sym(',') * e(tagC('Dots', sym('...')), 'ParList'))^-1 / addDots
                      + Ct(tagC('Dots', sym('...')))
                      + Ct(Cc());
}

-- copy other rules from main syntax
for k, v in pairs(G) do
    if macroidentifier[k] == nil then
        macroidentifier[k] = v
    end
end
-- }}}

-- {{{ parse
local parser = {}

local validator = require('lepton.lpt-parser.validator')
local validate = validator.validate
local syntaxerror = validator.syntaxerror

function parser.parse(subject, filename)
    local errorinfo = { subject = subject, filename = filename }
    lpeg.setmaxstack(1000)
    local ast, label, errpos = lpeg.match(G, subject, nil, errorinfo)
    if not ast then
        local errmsg = labels[label][2]
        return ast, syntaxerror(errorinfo, errpos, errmsg)
    end
    return validate(ast, errorinfo)
end

function parser.parsemacroidentifier(subject, filename)
    local errorinfo = { subject = subject, filename = filename }
    lpeg.setmaxstack(1000)
    local ast, label, errpos = lpeg.match(macroidentifier, subject, nil, errorinfo)
    if not ast then
        local errmsg = labels[label][2]
        return ast, syntaxerror(errorinfo, errpos, errmsg)
    end
    return ast
end

return parser
-- }}}
