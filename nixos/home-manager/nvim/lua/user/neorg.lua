require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    home = "~/notes",
                }
            }
        },
        ["core.completion"] = {
            config = { -- Note that this table is optional and doesn't need to be provided
                engine = "nvim-cmp" -- Configuration here
            }
        },  
        ["core.concealer"] = {
            config = { -- Note that this table is optional and doesn't need to be provided
                icon_preset = "basic",
                dim_code_blocks = {
                    enabled = true,
                    conceal = true
                },
                folds = false
            }
        },
        ["core.export"] = {
            config = { -- Note that this table is optional and doesn't need to be provided
               -- Configuration here
            }
        }
    }
}
