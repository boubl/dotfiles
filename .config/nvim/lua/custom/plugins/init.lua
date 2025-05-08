-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'norcalli/nvim-colorizer.lua', opts = {} },
  {
    'stevearc/oil.nvim',
    opts = {},
    config = function()
      require('oil').setup()
    end,
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'vyfor/cord.nvim',
    build = './build',
    event = 'VeryLazy',
    opts = {},
    config = function()
      require('cord').setup {
        buttons = {
          enabled = true,
          log_level = vim.log.levels.OFF,
          editor = {
            client = 'neovim',
            tooltip = 'The Superior Text Editor',
            icon = nil,
          },
          display = {
            theme = 'default',
            flavor = 'dark',
            swap_fields = false,
            swap_icons = false,
          },
          timestamp = {
            enabled = true,
            reset_on_idle = false,
            reset_on_change = false,
          },
          idle = {
            enabled = true,
            timeout = 300000,
            show_status = true,
            ignore_focus = true,
            unidle_on_focus = true,
            smart_idle = true,
            details = 'Idling',
            state = nil,
            tooltip = '💤',
            icon = nil,
          },
          text = {
            workspace = function(opts)
              return 'In ' .. opts.workspace
            end,
            viewing = function(opts)
              return 'Viewing ' .. opts.filename
            end,
            editing = function(opts)
              return 'Editing ' .. opts.filename
            end,
            file_browser = function(opts)
              return 'Browsing files in ' .. opts.name
            end,
            plugin_manager = function(opts)
              return 'Managing plugins in ' .. opts.name
            end,
            lsp = function(opts)
              return 'Configuring LSP in ' .. opts.name
            end,
            docs = function(opts)
              return 'Reading ' .. opts.name
            end,
            vcs = function(opts)
              return 'Committing changes in ' .. opts.name
            end,
            notes = function(opts)
              return 'Taking notes in ' .. opts.name
            end,
            debug = function(opts)
              return 'Debugging in ' .. opts.name
            end,
            test = function(opts)
              return 'Testing in ' .. opts.name
            end,
            diagnostics = function(opts)
              return 'Fixing problems in ' .. opts.name
            end,
            games = function(opts)
              return 'Playing ' .. opts.name
            end,
            terminal = function(opts)
              return 'Running commands in ' .. opts.name
            end,
            dashboard = 'Home',
          },
          {
            label = function(opts)
              return opts.repo_url and 'View Repository' or 'Website'
            end,
            url = function(opts)
              return opts.repo_url or 'https://boubli.dev'
            end,
          },
          {
            label = 'Click me!',
            url = 'https://cookky.dev/',
          },
          assets = nil,
          variables = nil,
          hooks = {
            ready = nil,
            shutdown = nil,
            pre_activity = nil,
            post_activity = nil,
            idle_enter = nil,
            idle_leave = nil,
            workspace_change = nil,
          },
          plugins = nil,
          advanced = {
            plugin = {
              autocmds = true,
              cursor_update = 'on_hold',
              match_in_mappings = true,
            },
            server = {
              update = 'fetch',
              pipe_path = nil,
              executable_path = nil,
              timeout = 300000,
            },
            discord = {
              reconnect = {
                enabled = false,
                interval = 5000,
                initial = true,
              },
            },
          },
        },
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    '3rd/image.nvim',
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {},
    config = function()
      require('image').setup {
        backend = 'kitty',
        processor = 'magick_cli',
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            floating_windows = false, -- if true, images will be rendered in floating markdown windows
            filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            filetypes = { 'norg' },
          },
          typst = {
            enabled = true,
            filetypes = { 'typst' },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', 'snacks_notif', 'scrollview', 'scrollview_sign' },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' }, -- render image files as images when opened
      }
    end,
  },
}
