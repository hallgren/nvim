call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" Options
set termguicolors
syntax enable
filetype plugin indent on
set relativenumber         " Line numbers
set number         " Line numbers
set cursorline	   " Show current line
set tabstop=4      " Show existing tab with 4 spaces
set shiftwidth=4   " When indenting with >, use 4 spaces
set completeopt=menuone,noinsert,noselect
set background=dark
colorscheme gruvbox
set wildmenu
set path+=**
set autowrite
set autoread

" Setup LSP
lua << EOF
local lsp = require('lspconfig')
lsp.gopls.setup{
	on_attach = require('completion').on_attach,
}
EOF

" Mappings
nnoremap <space> <nop>
let mapleader=" "
" go auto import on save
let g:go_fmt_command = "goimports"

nnoremap <silent> <C-n> :tabnext<cr>
nnoremap <leader>r :source $MYVIMRC<cr>
nnoremap <silent> <C-m> :tabprevious<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent>gb :GoBuild<cr>
nnoremap <silent>gt :GoTestFunc<cr>
nnoremap <silent>gd :GoDef<cr>

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>


augroup LSP
    autocmd!

    autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc
    autocmd FileType go inoremap <silent> <C-Space> <C-x><C-o>
    " Diagnostics
    autocmd FileType go nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next{ wrap = true }<CR>
    autocmd FileType go nnoremap <leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev{ wrap = true }<CR>
    autocmd FileType go nnoremap <leader>dl <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
    " Documentation
    autocmd FileType go nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
    autocmd FileType go inoremap <silent> <C-p> <cmd>lua vim.lsp.buf.signature_help()<CR>
    " Navigation
    "autocmd FileType go nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    "autocmd FileType go nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
    autocmd FileType go nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
    autocmd FileType go nnoremap <silent> gR <cmd>lua vim.lsp.buf.references()<CR>:copen<CR>
    " Refactoring
    autocmd FileType go nnoremap <silent> gr <cmd>lua vim.lsp.buf.rename()<CR>
    autocmd FileType go nnoremap <silent> gf <cmd>lua vim.lsp.buf.formatting()<CR>
    autocmd FileType go nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
augroup END

" copy to / paste from clipboard in visual mode
noremap  <silent>gy "+y
noremap  <silent>gp "+p

" telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>p :lua require('telescope.builtin').git_files()<CR>

