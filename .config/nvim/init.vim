""" dospore init.vim 2021
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

""" Vim-Plug
call plug#begin()

set mouse=a
" Aesthetics - Main"
Plug 'vim-airline/vim-airline'
Plug 'dunstontc/vim-vscode-theme'
Plug 'vim-airline/vim-airline-themes'
Plug 'bryanmylee/vim-colorscheme-icons'

""" Aesthetics - Extras
Plug 'morhetz/gruvbox'

" Fuzzy searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

""" Linting 


""" Functionality
Plug 'preservim/nerdtree'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'puremourning/vimspector'
" Better syntax-highlighting for filetypes in vim
Plug 'sheerun/vim-polyglot'
" Intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Git integration
Plug 'tpope/vim-fugitive'
" Auto-close braces and scopes
Plug 'jiangmiao/auto-pairs'


" Github
Plug 'github/copilot.vim'

"" JS 


""" Python


""" Rust


""" END of vim-plug
call plug#end()

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set wildmode=longest,list,full wildmenu
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\ 
set wrap breakindent
set encoding=utf-8
set textwidth=0
set hidden
set number
set title


" Main Coloring Configurations
colorscheme gruvbox
syntax on

" Enable True Color Support (ensure you're using a 256-color enabled $TERM, e.g. xterm-256color)
set termguicolors


" NERDTree
let NERDTreeShowHidden=1
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Airline
let g:airline_powerline_fonts = 1
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''
"let g:airline#extensions#tabline#enabled = 1 " Uncomment to display buffer tabline above

" Neovim :Terminal
tmap <C-w> <Esc><C-w>
"tmap <C-d> <Esc>:q<CR>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
