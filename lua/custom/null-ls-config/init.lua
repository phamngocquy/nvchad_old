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
            filetypes = { "html", "markdown", "css", "typescript", "javascript", "json", "svelte" },
         },
         formatting.black.with { filetypes = { "python" } },
         formatting.gofmt.with { filetypes = { "go" } },
         formatting.clang_format,
         diagnostics.ruff,
    },
    on_attach = function (client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({
          group = augroup,
          buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function ()
            vim.lsp.buf.format({bufnr = bufnr})
          end
        })
      end
    end
}
end

return M
