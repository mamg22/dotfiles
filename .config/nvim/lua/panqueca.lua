--[[
    ABOUT: panqueca is a plugin to flip and shift across a set of values
    like C-A or C-X but for user-selected words
    well, actually there's only a C-A, I still haven't implemented reverse order

    NOTE: This is a work in progress

    USAGE:
    panqueca = require('panqueca')
    panqueca.setup({
        shifts = {
            {"true", "false"},
            {"enabled", "disabled",},
            {"yes", "no",},
            {"first", "second", "third"},
            {"systemd", "systemD", config = {case_sensitive = true}},
        }
    })
    vim.api.nvim_set_keymap("n", "<Leader>pf", "<Cmd>lua require('panqueca').convert()<CR>",  {silent = true, noremap = true})

    TODO:
    LuaSnip-like filetype activation:
        all is always enabled
        <filetype> is enabled for the specific filetype
]]

local shifts

local case_types = {
    unknown   = 0,
    lowercase = 1,
    uppercase = 2,
    sentence  = 3,
}

local function string_equal(rhs, lhs, case_sensitive)
    if case_sensitive then
        return rhs == lhs
    else
        return string.lower(rhs) == string.lower(lhs)
    end
end

local function detect_case(str)
    if string.match(str, "^%u%l+") then
        return case_types.sentence
    elseif string.match(str, "^%l+") then
        return case_types.lowercase
    elseif string.match(str, "^%u+") then
        return case_types.uppercase
    else
        return case_types.unknown
    end
end

local function change_case(case, str)
    if case == case_types.lowercase then
        return string.lower(str)
    elseif case == case_types.uppercase then
        return string.upper(str)
    elseif case == case_types.sentence then
        head = string.sub(str, 1, 1)
        tail = string.sub(str, 2)
        return string.upper(head) .. string.lower(tail)
    elseif case == case_types.unknown then
        return str
    end
end

local function get_next_value(current, value_list)
    local case = detect_case(current)
    local case_sensitive = false

    if value_list.config then
        if value_list.config.case_sensitive == true then
            case_sensitive = true
        end
    end

    for idx, value in ipairs(value_list) do
        idx = idx + 1
        if idx == #value_list + 1 then
            idx = 1
        end

        if string_equal(current, value, case_sensitive) then
            local ret = value_list[idx]
            if case_sensitive then
                return ret
            else
                return change_case(case, ret)
            end
        end
    end
    -- Not found, maybe return `nil` signaling "unchanged"?
    return nil
end

local function find_next_value(val)
    for _, shift in ipairs(shifts) do
        local next_val = get_next_value(val, shift)
        if next_val ~= nil then
            return next_val
        end
    end

    return nil
end

local function convert()
    current_word = vim.fn.expand("<cword>")
    next_word = find_next_value(current_word)

    if next_word ~= nil then
        -- I'm pretty sure something is gonna break here, but it works
        esc = vim.api.nvim_replace_termcodes([[<Esc>]], true, true, true)
        command = [[norm "_ciw]] .. next_word .. esc
        vim.cmd(command)
    end
end

local function setup(config)
    if config.shifts then
        shifts = config.shifts
    end
end

return {
    convert = convert,
    setup = setup,
}
