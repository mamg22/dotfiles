local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")

ls.config.set_config({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = {{"●", "GruvboxOrange"}}
			}
		},
		[types.insertNode] = {
			active = {
				virt_text = {{"●", "GruvboxBlue"}}
			}
		}
	},
	enable_autosnippets = false,
})

ls.snippets = {
    sh = {
        s("#!", {
            c(1, {
                t("#!/bin/sh"),
                t("#!/usr/bin/env bash"),
                t("#!/usr/bin/env zsh"),
                t("#!/usr/bin/bash"),
                t("#!/usr/bin/zsh"),
            }),
            t({"", ""}),
        }, {
            condition = function(line_to_cursor, matched_trigger, captures)
                -- Only expand on the first line of the file
                return vim.api.nvim_win_get_cursor(0)[1] == 1
            end,
        }),

        s("while", {
            t("while "), i(1), t({"; do", "\t"}),
                i(0),
            t({"", "done"}),
        }),

        s("for", {
            t("for "), i(1, "i"), t(" in "), i(2), t({"; do", "\t"}),
                i(0),
            t({"", "done"}),
        }),

        s("case", {
            t("case "), i(1), t({" in", "\t"}),
                i(0),
            t({"", "esac"}),
        }),

        -- case item
        s("caseit", {
            t("("), i(1), t({")", "\t"}),
                i(0),
            t({"", "\t;;"}),
        }),

        s("if", {
            t("if "), c(1, {
                t(""),
                sn(nil, {
                    t("[ "), i(1), t(" ]")
                }),
                sn(nil, {
                    t("! "), i(1)
                }),
                sn(nil, {
                    t("! [ "), i(1), t(" ]")
                }),
            }),
            t({"; then", "\t"}),
                i(0),
            t({"", "fi"}),
        }),

        s("heredoc", {
            t("<<"), i(1, "EOF"), t({"",""}),
            i(0), t({"",""}),
            r(1), t({"",""}),
        }),

        s("function", {
            i(1), t({"()", "{", "\t"}),
                i(0),
            t({"", "}", ""}),
        }),

        s("getopts", {
            t("while getopts "), i(1), t(" "), i(2, "name"), t({"; do", "\tcase "}),
            t('"$'), r(2), t({'" in', "\t\t"}),
            -- TODO: Split the option names string (1) and add a case item for each one
                i(0),
            t({"", "\tesac", "done", "shift $((OPTIND - 1))"}),
        }),
    }
}

ls.filetype_extend("zsh", {"sh"})
