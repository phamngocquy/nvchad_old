local augroup = vim.api.nvim_create_augroup("LspFormatiing", {})
local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local M = {}

M.setup = function()
  null_ls.setup {
    sources = {
      formatting.stylua.with { filetypes = { "lua" } },
      formatting.prettier.with {
        filetypes = { "html", "markdown", "css", "typescript", "javascript", "javascriptreact", "svelte", "jsx" },
      },
      formatting.black.with { filetypes = { "python" } },
      formatting.gofmt.with { filetypes = { "go" } },
      formatting.shfmt.with { filetypes = { "sh" } },
      formatting.yamlfmt.with {
        filetypes = { "yml", "yaml" },
      },
      formatting.clang_format,
      diagnostics.ruff.with { filetypes = { "python" } },
    },
  }
end

return M
