" syntax on set colorcolumn=80
highlight ColorColumn ctermbg=DarkGrey

"set number
filetype plugin indent on
"Set background colour"
set t_ut=
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" cursor color
"hi CursorLineNr guifg=#050505
set cursorline

set laststatus=2        "show statusbar
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
hi StatusLine ctermbg=White ctermfg=DarkGrey
set mouse=a "turn mouse on

autocmd bufnewfile *.{c,h} 0r ~/.vim/c_template.c
autocmd bufnewfile *.{c,h} exe "1," . 10 . "g/File:.*/s//File: " .expand("%")
autocmd bufnewfile *.{c,h} exe "1," . 10 . "g/Date:.*/s//Date: " .strftime("%c")

function! s:insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! GA#ifndef " . gatename
    execute "normal! o#define " . gatename . " "
    normal! o
    execute "normal! Go#endif /* " . gatename . " */"
    normal! kkkkkk
endfunction

autocmd BufNewFile *.{c,cpp} call <SID>cursormove()
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

set number "turn linenumbering on"

" Copy and paste
set clipboard+=unnamedplus

"CocConfig
"Allow tab to traverse options in auto-complete window, refresh on backspace
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Check if backspace was just pressed
function! s:check_back_space() abort
  let col = col('.') - 1    
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Commenting
let s:comment_map = { 
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "typescript": '\/\/',
    \   "typescriptreact": '\/\/',
    \   "lua": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "python": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ '^\s*$'
            " Skip empty line
            return
        endif
        if getline('.') =~ '^\s*' . comment_leader
            " Uncomment the line
            execute 'silent s/\v\s*\zs' . comment_leader . '\s*\ze//'
        else
            " Comment the line
            execute 'silent s/\v^(\s*)/\1' . comment_leader . ' /'
        endif
    else
        echo "No comment leader found for filetype " &filetype
    endif
endfunction

command -nargs=1 Sch noautocmd vimgrep /<args>/gj `git ls-files` | cw

" Comment maps
nnoremap <C-c> :call ToggleComment()<cr>
vnoremap <C-c> :call ToggleComment()<cr>

" mapleader
let mapleader=","

" useful for git conflicts
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

" Find next capital letter
nmap <C-s> :call search('[A-Z]', 'W')<CR>


" Fzf
nnoremap <C-g> :GFiles<CR>
nnoremap <C-f> :Rg 
