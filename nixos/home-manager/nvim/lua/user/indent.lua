require("ibl").setup {
    scope = { enabled = true },
    exclude = {
        filetypes = {
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "norg",
        "",
        }
    },
    indent = { char = "▎",tab_char = " " }

}
