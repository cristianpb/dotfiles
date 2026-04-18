dofile(vim.g.base46_cache .. "telescope")

return {
  defaults = {
    -- configure to use ripgrep
    vimgrep_arguments = {
      "rg",
      "--follow",        -- Follow symbolic links
      "--hidden",        -- Search for hidden files
      "--no-heading",    -- Don't group matches by each file
      "--with-filename", -- Print the file path with the matched lines
      "--line-number",   -- Show line numbers
      "--column",        -- Show column numbers
      "--smart-case",    -- Smart case search

      -- Exclude some patterns from search
      "--glob=!**/.git/*",
      "--glob=!**/.idea/*",
      "--glob=!**/.vscode/*",
      "--glob=!**/build/*",
      "--glob=!**/dist/*",
      "--glob=!**/yarn.lock",
      "--glob=!**/package-lock.json",
    },
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
  pickers = {
     find_files = {
       hidden = true,
       -- needed to exclude some files & dirs from general search
       -- when not included or specified in .gitignore
       find_command = {
         "rg",
         "--files",
         "--hidden",
         "--glob=!**/.git/*",
         "--glob=!**/.idea/*",
         "--glob=!**/.vscode/*",
         "--glob=!**/build/*",
         "--glob=!**/node_modules/*",
         "--glob=!**/dist/*",
         "--glob=!**/yarn.lock",
         "--glob=!**/package-lock.json",
       },
     },
   },
  extensions_list = { "themes", "terms" },
  extensions = {},
}
