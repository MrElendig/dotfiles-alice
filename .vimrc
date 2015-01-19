" -[ vim-plug ]-
runtime bundle/vim-plug/plug.vim
call plug#begin('~/.vim/bundle')
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
call plug#end()
" -[ Plugin configurations ] -
" jedi
let g:jedi#popup_on_dot = 0

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

" -[ Various stuff ]-
set nowrap
set autoindent

" search
set nohls
set incsearch
set showmatch

" command mode
set wildmenu
set wildmode=list:longest,full

" -[ Look ]-
" general
set showcmd
set showmode
set number
set colorcolumn=80
colorscheme candycode

" statusline
"set statusline=%<%f\ %{fugitive#statusline()}\ %y%h%m%r\ PWD:%{getcwd()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2

" -[ FileTypes ]-
" mail
autocmd FileType mail,human set formatoptions+=t textwidth=72

" Python stuff
autocmd FileType python let python_highlight_all = 1
autocmd FileType python let python_slow_sync = 1
autocmd FileType python set expandtab shiftwidth=4 softtabstop=4 
"autocmd FileType python set completeopt=preview

" PKGBUILD stuff
autocmd FileType PKGBUILD set expandtab shiftwidth=2 softtabstop=4 

" sh stuff
autocmd FileType sh set expandtab shiftwidth=2 softtabstop=4 

" -[ Mappings ]-
" tagbar
nnoremap <silent> <F8> :TagbarToggle<CR>
inoremap <silent> <F8> <esc>:TagbarToggle<CR>a
