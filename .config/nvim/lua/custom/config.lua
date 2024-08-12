local client = vim.lsp.start_client {
  name = 'rgblsp',
  cmd = { '/Users/boubli/Development/rgblsp/zig-out/bin/rgblsp' },
}

if not client then
  vim.notify "RGBLSP didn't start, you suck"
  return
end

vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'markdown',
  callback = function()
    vim.lsp.buf_attach_client(0, client)
  end,
})

-- vim: ts=2 sts=2 sw=2 et
