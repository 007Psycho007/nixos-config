return {
    "ahmedkhalf/project.nvim",
    main = "project_nvim",
    opts = {
        detection_methods = { "lsp", "pattern" },
        patterns = { "shell.nix", ".git", "main.py",">Projects",">production",">private",">learning"},

    }
}
