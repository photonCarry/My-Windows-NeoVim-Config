-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        height = 0.9,
        preview_cutoff = 0,
        width = 0.9
      }
      -- other layout configuration here
    },
    -- other defaults configuration here
  },

  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "respect_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
  mappings = {
    global = {
      org_agenda = 'ga',
      org_capture = 'gc'
    },
    agenda = {
      org_agenda_todo = 't'
    },
    org={
      org_todo = 't',
      org_global_cycle = 'X',
      org_cycle = 'x',
      org_insert_todo_heading = '<leader>a'
    }
  },
})

require('octo').setup{}
require('calltree').setup({})

-- 其实还是可以研究一下，毕竟可以可以配置放到 quickfix 和 terminal 中的
-- 但是如何正确的描述 % 才是大问题啊
require('yabs'):setup({
  languages = { -- List of languages in vim's `filetype` format
    lua = {
      tasks = {
        run = {
          command = 'luafile %', -- The command to run (% and other
          -- wildcards will be automatically
          -- expanded)
          type = 'vim',  -- The type of command (can be `vim`, `lua`, or
          -- `shell`, default `shell`)
        },
      },
    },
    c = {
      default_task = 'build_and_run',
      tasks = {
        build = {
          command = 'gcc % -o main',
          output = 'quickfix', -- Where to show output of the
          -- command. Can be `buffer`,
          -- `consolation`, `echo`,
          -- `quickfix`, `terminal`, or `none`
          opts = { -- Options for output (currently, there's only
            -- `open_on_run`, which defines the behavior
            -- for the quickfix list opening) (can be
            -- `never`, `always`, or `auto`, the default)
            open_on_run = 'always',
          },
        },
        run = { -- You can specify as many tasks as you want per
          -- filetype
          command = './main',
          output = 'quickfix',
        },
        build_and_run = { -- Setting the type to lua means the command
          -- is a lua function
          command = function()
            -- The following api can be used to run a task when a
            -- previous one finishes
            -- WARNING: this api is experimental and subject to
            -- changes
            require('yabs'):run_task('build', {
              -- Job here is a plenary.job object that represents
              -- the finished task, read more about it here:
              -- https://github.com/nvim-lua/plenary.nvim#plenaryjob
              on_exit = function(Job, exit_code)
                -- The parameters `Job` and `exit_code` are optional,
                -- you can omit extra arguments or
                -- skip some of them using _ for the name
                if exit_code == 0 then
                  require('yabs').languages.c:run_task('run')
                end
              end,
            })
          end,
          type = 'lua',
        },
      },
    },
  },
  tasks = { -- Same values as `language.tasks`, but global
    build = {
      command = 'echo building project...',
      output = 'consolation',
    },
    run = {
      command = 'echo running project...',
      output = 'echo',
    },
    optional = {
      command = 'echo runs on condition',
      -- You can specify a condition which determines whether to enable a
      -- specific task
      -- It should be a function that returns boolean,
      -- not a boolean directly
      -- Here we use a helper from yabs that returns such function
      -- to check if the files exists
      condition = require('yabs.conditions').file_exists('filename.txt'),
    },
  },
  opts = { -- Same values as `language.opts`
    output_types = {
      quickfix = {
        open_on_run = 'always',
      },
    },
  },
})

local notify = require("notify")
local t = os.date ("*t") --> produces a table like this:
local time_left = 30 - t.min % 30
local function min(m)
  return m * 60 * 1000
end

local function drink_water()
		local timer = vim.loop.new_timer()
		timer:start(min(time_left), min(30), function()
			notify({"Drink Water", "🦁" }, "info", {
				title = "Drink water",
				timeout = 10000,
			})
		end)
end

drink_water()
