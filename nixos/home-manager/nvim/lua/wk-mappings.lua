local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>qa!<CR>", "Quit without saving" },
  ["b"] = { "<cmd>Telescope buffers<CR>", "Open Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["n"] = { "<cmd>tabnew<cr>", "New Tab"},
  ["x"] = { "<cmd>tabclose<cr>", "Close Tab"},
  ["d"] = { "<cmd>bdelete<cr>", "Close Buffer"},
  ["e"] = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
  ["z"] = { "<cmd>:ZenMode<cr>", "Zen Mode"},

  r = {
    name = "Rest Client",
    r = {"<Plug>RestNvim","Run Rest Client"}
    },
  s = {
    name = "Split",
    v = { "<cmd>vsplit<cr>", "Split Vertical"},
    h = {"<cmd>split<cr>", "Split Horizontal"},
    c = {"<cmd>close<cr>", "Close Window"},
    },

  f = {
    name = "Files/Search",
    s = {"<cmd>SidebarNvimToggle<cr>", "Sidebar"},
    f = {"<cmd>Telescope find_files<cr>", "Find Files"},
    g = {"<cmd>Telescope live_grep<cr>", "Live Grep"},
    t = {"<cmd>NvimTreeToggle<cr>","NVIM Tree"}
    },

  g = {
    name = "Git",

    g = { "<cmd>Neogit<cr>", "NeoGit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },

    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  c = {
    name = "Code Actions",
    t = {"<cmd>TodoTelescope<cr>", "Todos"},
    h = {"<cmd>HexToggle<cr>", "Toggle Hexedit"},
    c = {"<cmd>ColorizerToggle<cr>", "Toggle Colorizer"},
    j = {
      name = "JSON",
      f = {"<CMD>:%! jq .<cr>","Format JSON"}
    },
  },

    l = {
      name = "LSP",
      d = { "<cmd>Lspsaga hover_doc<cr>", "Documenation"},
      o = { "<cmd>SymbolsOutline<cr>", "Code Outline"},
      r = { "<cmd>Lspsaga rename<cr>", "Rename Definition"},
      s = { "<cmd>Telescope diagnostics<CR>", "Diagnostic List"},
      c = { "<cmd>Telescope lsp_references<CR>", "Declaration"},
      f = { "<cmd>Telescope lsp_definitions<CR>", "Definition"},
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    },

  t = {
    name = "Terminal",
    t = { "<cmd>ToggleTerm direction=tab<cr>", "Tab" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
  ["/"] = { "<ESC><CMD>lua require(\"Comment.api\").toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
  ["s"] = {"<cmd>ToggleTermSendVisualLines<cr>", "Send Visual"},

}

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

wk.register(mappings, opts)
wk.register(vmappings, vopts)
