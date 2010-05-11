" -[ General behaviour ]-
" general
set nocompatible
set nowrap
syntax on
filetype plugin indent on

" search
set nohls
set incsearch
set showmatch

" identing
set autoindent
set smartindent

" command mode
set wildmenu
set wildmode=list:longest,full

" -[ Look ]-
" general
set showcmd
set showmode
set number

" statusline
set statusline=%<%f\ %y%h%m%r\ PWD:%{getcwd()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2

" colours
"set t_Co=256
colorscheme candycode


" -[ FileTypes ]-
" mail
autocmd FileType mail,human set formatoptions+=t textwidth=72

" Python stuff
autocmd FileType python let python_highlight_all = 1
autocmd FileType python let python_slow_sync = 1
autocmd FileType python set expandtab shiftwidth=4 softtabstop=4 
autocmd FileType python set completeopt=preview

" PKGBUILD stuff
autocmd FileType PKGBUILD set expandtab shiftwidth=2 softtabstop=4 

" sh stuff
autocmd FileType sh set expandtab shiftwidth=2 softtabstop=4 

" LaTeX
autocmd Filetype tex,latex set grepprg=grep\ -nH\ $
autocmd Filetype tex,latex let g:tex_flavor = "latex"


" -[ Mappings ]-"
" taglist
nnoremap <silent> <F8> :TlistToggle<CR>
inoremap <silent> <F8> <esc>:TlistToggle<CR>a
nnoremap <silent> <F9> :TlistUpdate<CR>
inoremap <silent> <F9> <esc>:TlistUpdate<CR>a


" -[ Plugins and Scripts ]-
" taglist
let Tlist_Use_Right_Window = 1
let Tlist_Compart_Format = 1
let Tlist_Show_Menu = 1
let Tlist_Exit_OnlyWindow = 1
