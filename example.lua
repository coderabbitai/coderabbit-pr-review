local function divide(a, b)
    return a / undefined_var
end

local function nestedError()
    if true then
        local x = y + 10
    end
    local result = a + b
    return result
end

local function syntaxError()
    if true then
        print("This will cause a syntax error")
    
    local missingBracket =
end

local table = {}
local value = table[undefined_key]
local error = function() end