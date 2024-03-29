set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "elixir", "go", "java", "javascript", "kotlin", "lua", "ruby", "rust", "scala", "typescript", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = { "markdown", "ruby", "vim" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- python highlight customization
vim.api.nvim_set_hl(0, "@variable.python", { link = "Method" })
vim.api.nvim_set_hl(0, "@parameter.python", { link = "Method" })
vim.api.nvim_set_hl(0, "@field.python", { link = "Method" })

vim.api.nvim_set_hl(0, "@punctuation.delimiter.python", { link = "Method" })
vim.api.nvim_set_hl(0, "@punctuation.bracket.python", { link = "Method" })
vim.api.nvim_set_hl(0, "@punctuation.special.python", { link = "Method" })

vim.api.nvim_set_hl(0, "@variable.builtin.python", { link = "Type" })
vim.api.nvim_set_hl(0, "@method.call.python", { link = "Method" })

-- go highlight customization
vim.api.nvim_set_hl(0, "@function.go", { link = "Special" })
vim.api.nvim_set_hl(0, "@method.go", { link = "Special" })
vim.api.nvim_set_hl(0, "@namespace.go", { link = "Type" })
vim.api.nvim_set_hl(0, "@variable.go", { link = "Method" })
EOF
