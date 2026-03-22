" ================================================================================ VIM-Plug Install
" ================================================================================
call plug#begin('~/.local/share/nvim/plugged')
"
" Finding stuff
" ------------------------------------------------------------------------------
Plug 'nvim-lua/plenary.nvim'                          " Async programming module
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }

" Language markup and parsing
" ------------------------------------------------------------------------------
Plug 'frazrepo/vim-rainbow'                                " Rainbow parentheses
Plug 'pprovost/vim-ps1'                                      " Powershell markup
Plug 'fedorenchik/qt-support.vim'
Plug 'nvim-treesitter/nvim-treesitter', { 'tag': 'v0.10.0', 'do': ':TSUpdate' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mason-org/mason.nvim'                         " package manager for neovim
Plug 'mason-org/mason-lspconfig.nvim'                         " LSP-mason bridge
Plug 'neovim/nvim-lspconfig'                                       " LSP support

" Navigation and simplified actions
" ------------------------------------------------------------------------------
Plug 'justinmk/vim-sneak'                    " Use s## to go to next instance of
Plug 'moll/vim-bbye'                    " Delete a buffer without closing window
Plug 'tpope/vim-surround'                              " Brackets and quotations 
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'                      " Use gcc to comment out a line
Plug 'tpope/vim-repeat'                            " Enhanced action repeating .  

" Git
" -------------------------------------------------------------------------------
Plug 'airblade/vim-gitgutter' 
Plug 'tpope/vim-fugitive' 

" Miscellaneous
" -------------------------------------------------------------------------------
Plug 'folke/which-key.nvim'                               " Can tab into commands
Plug 'lervag/wiki.vim'                                      " maybe a better wiki
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'echasnovski/mini.icons'
Plug 'tpope/vim-dispatch'                           " Asynch building using Make
Plug  'mwcz/rust-termdebug.nvim'

call plug#end()

" ================================================================================
" Leader remapping
" ================================================================================
let mapleader=" "

" theme 
" -------------------------------------------------------------------------------
set noshowmode                              " Remove duplication of mode display
colorscheme slate
:lua << THEME
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'nord',
  },
  sections = {
    lualine_b = { 'branch' },
    lualine_c = {
      {
        'filename',
        path = 1, -- 1 = Relative path, 2 = Absolute path, 3 = Absolute with ~
        shorting_target = 40, 
      }
    },
  }
})

require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()
THEME

" Devicons
" -------------------------------------------------------------------------------
let g:webdevicons_enable_ctrlp = 1

" ================================================================================
" Interface setup
" ================================================================================
filetype plugin indent on
filetype plugin on                                         " required for vimwiki
set relativenumber                                      " show relative numbering
set number                                                    " show line numbers
set nowrap
set formatoptions-=t
set encoding=UTF-8
set showmatch
set tabstop=4
set shiftwidth=4
set expandtab
set ttyfast
set mouse=a 
set title
set splitbelow
set nosplitright
set updatetime=100
set signcolumn=auto
set showmode
set showcmd
set wildmenu                              " visual autocomplete for command menu
set scrolloff=12         " Keep cursor in approximately the middle of the screen
set cursorline                                           " highight current line
set guioptions-=T                                               " Remove toolbar
syntax off                                      " treesitter is slow with syntax

" ================================================================================
" Sensible stuff 
" ================================================================================
set backspace=indent,eol,start   " Make backspace behave in a more intuitive way
let g:rainbow_active = 1                      " Rainbox parentheses highlighting

" ================================================================================
" Searching settings 
" ================================================================================
set ignorecase                              " Ignore case in searches by default
set smartcase            " But make it case sensitive if an uppercase is entered
set hlsearch                                                 " highlight matches
set noincsearch

let MRU_Window_Height=120
nnoremap <C-t> :vertical topleft MRUToggle<cr>       " Toggle Most Recently Used
nnoremap <C-h> :set hlsearch! hlsearch?<cr>
set wildignore+=*/.git/*,*/tmp/*,*.swp

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" ================================================================================
" Folding 
" ================================================================================
set foldmethod=expr
set nofoldenable                                     " Disable folding at startup
autocmd BufReadPost,FileReadPost * normal zR

" ================================================================================
" Navigation
" ================================================================================
nnoremap <leader>dd :cd %:h<CR>
set hidden
map <leader>n :bnext<cr>
map <leader>p :bprevious<cr>
nnoremap <leader>bd :Bdelete<CR>                                         

" Telescope
" ------------------------------------------------------------------------------
:lua << TELESCOPE
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').setup{
      defaults = {
			  previewer = false,
			  path_display={'smart'},
			  scroll_strategy = "limit";
			  file_ignore_patterns = { ".git/[^h]", "%.idx"};
			  layout_strategy = 'vertical', 
			  layout_config = {
					  prompt_position = "top",
					  height=0.5,
					  },
			  ensure_installed = {
					  'lua',
					  'cpp',
					  'vimscript',
			  },
      },
      pickers = {
				find_files = {
						previewer = false,
						hidden = true,
						theme = "ivy",
						layout_config = { height=0.5 },
						},
				live_grep = {
						previewer = false,
						hidden = true,
						theme = "ivy",
						layout_config = { height=0.5 },
						},              
				buffers = {
						previewer = false,
						hidden = true,
						theme = "ivy",
						layout_config = { height=0.5 },
						},              
      },
      extensions = {
      },
}
TELESCOPE

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Vim wiki
" ------------------------------------------------------------------------------
let g:wiki_root = '/home/juan/workspace/vimwiki'
let g:gitgutter_enabled = 1

"" Treesitter (syntax highligting)
"" -------------------------------------------------------------------------------
:lua << EOF
local async_ok, async = pcall(require, "plenary.async")
function _G.setup_treesitter()
    local status, configs = pcall(require, "nvim-treesitter.configs")
    if status then
        configs.setup({
            highlight = { 
                enable = true, 
                additional_vim_regex_highlighting = false 
            },
            ensure_installed = { 
                "comment", "c", "cpp", "python", "gitattributes", "lua", 
                "vim", "vimdoc", "tsx", "html", "markdown", 
                "typescript", "javascript", "php", "rust", "json"
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
        })
    else
        print("error occured with treesitter")
    end
end
EOF

" 2. Trigger that function after plugins are loaded
augroup TreesitterSetup
    autocmd!
    autocmd VimEnter * lua _G.setup_treesitter()
augroup END

"" LSP
"" -------------------------------------------------------------------------------
:lua << LSP
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "ts_ls" } })
vim.lsp.enable('ts_ls')

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "gl",  vim.diagnostic.open_float) -- open diagnostic
vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)

vim.env.PATH = vim.fn.expand("~/.cargo/bin") .. ":" .. vim.env.PATH -- for rustc
vim.lsp.config('rust_analyzer', {
    cmd = { vim.fn.expand("~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer") }, 
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'Dockerfile' }, -- Where to start
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = true,
            check = {
                command = 'clippy',
                extraArgs = { '--', '-W', 'clippy::all' },
            },
            cargo = {
                allFeatures = true,
                },
        },
    },
})
-- Enable it
vim.lsp.enable('rust_analyzer')

vim.keymap.set('n', '<leader>de', function()
    -- Check if enabled, then toggle the opposite
    if vim.diagnostic.is_enabled() then
        vim.diagnostic.enable(false) -- pass false to disable
        print("Diagnostics Disabled")
    else
        vim.diagnostic.enable(true)  -- pass true to enable
        print("Diagnostics Enabled")
    end
end, { desc = "Toggle Diagnostics" })
LSP

"" Async commands
"" -------------------------------------------------------------------------------

:lua << ASYNC
local function async_run(cmd_str)
  local lines = {}
  local cmd = vim.split(cmd_str, " ")
  local function on_event(_, data)
    if data then
      for _, line in ipairs(data) do
        if line ~= "" then table.insert(lines, line) end
      end
    end
  end

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true, 
    on_stdout = on_event,
    on_stderr = on_event,
    on_exit = function()
      if #lines > 0 then
        vim.fn.setqflist({}, ' ', { title = cmd_str, lines = lines })
        vim.cmd("copen")
      else
        print("Command finished with no output.")
      end
    end,
  })
end

vim.api.nvim_create_user_command('RunCommand', function(opts) async_run(opts.args) end, { nargs = '+' })
ASYNC

"" Debug 
"" -------------------------------------------------------------------------------
packadd! termdebug

:lua << DEBUG
require('rust-termdebug').setup({
    -- Whether to enter insert mode upon entering the gdb window.
    gdb_auto_insert = true,
    gdb_startup_commands = {},
    keep_cursor_in_place = true,
    use_default_keymaps = true,
    swap_termdebug_windows = true,
    -- The suffix to append to options in selection menus to pin that choice
    -- for the current session. For example, " [pin]" or " 📌"
    pin_suffix = " [pin]",
    persist_breakpoints = false,
    enable_telescope = false,
    termdebug_config = {
        wide = 1,
        map_K = 0,
        map_minus = 0,
        map_plus = 0,
        command = "rust-gdb",
    },
})
DEBUG


" ================================================================================
" EOF 
" ================================================================================
