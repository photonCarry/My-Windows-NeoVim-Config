require('bufferline').setup {
  options = {
    numbers = function(opts)
      -- return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
      return string.format('%s', opts.ordinal)
    end,
    diagnostics = "coc",
    show_buffer_close_icons = false,
    show_close_icon = false,
    max_name_length = 80,
    offsets = {
      {
        filetype = "NvimTree",
        text = function()
          return vim.fn.getcwd()
        end,
        highlight = "Directory",
        separator = true 
      }
    },
  },
}
