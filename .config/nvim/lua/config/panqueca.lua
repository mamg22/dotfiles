panqueca = require('panqueca')

panqueca.setup({
    shifts = {
        {"true", "false"},
        {"enabled", "disabled",},
        {"yes", "no",},
        {"first", "second", "third"},
        {"systemd", "systemD", config = {case_sensitive = true}},
        --[[ In the future, I'll add something like
        lisp = {
            {"t", "nil"},
        }
        ]]
    }
})
