local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

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
  ["e"] = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
  i = {
    name = "Iron (Repl)",
    o = {"<cmd>IronRepl<cr>", "Toggle Repl"},
    s = {"<cmd>lua require'iron'.core.send_line()<cr>", "Send Line"},
    v = {"<cmd>lua require'iron'.core.send_visual()<cr>", "Send Visual"},
    },
  m = {
    name = "Magma",
    o = {},
  },
  s = {
    name = "Split",
    v = { "<cmd>vsplit<cr>", "Split Vertical"},
    h = {"<cmd>split<cr>", "Split Horizontal"},
    c = {"<cmd>close<cr>", "Close Window"},
    },
  d = {
    name = "Debugger",
    b = {"<Cmd>lua require'dap'.toggle_breakpoint()<CR>","Set Breakpoint"},
    d = {"<Cmd>lua require'dap'.continue()<CR>","Start/Continue Debug"},
    s = {"<Cmd>lua require'dap'.step_over()<CR>", "Step Over"},
    a = {"<Cmd>lua require'dap'.step_into()<CR>", "Step Into"},
    f = {"<Cmd>lua require'dap'.step_out()<CR>", "Step Out"},
    },

  f = {
    name = "Files/Search",
    s = {"<cmd>SidebarNvimToggle<cr>", "Sidebar"},
    f = {"<cmd>Telescope find_files<cr>", "Find Files"},
    g = {"<cmd>Telescope live_grep<cr>", "Live Grep"},
    t = {"<cmd>NvimTreeToggle<cr>","NVIM Tree"}
    },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
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
    p = {
      name = "Python",
      c = {"<CMD>Telescope conda conda<CR>","Change Conda Env"},
      },
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
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>ToggleTerm direction=tab<cr>", "Tab" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
  o = {
    name = "Neorg",
    t = {"<cmd>Neorg tangle current-file<CR>", "Tangle current File"}
    }
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
  ["s"] = {"<cmd>lua require'iron'.core.visual_send()<cr>", "Send Visual"},

}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)

