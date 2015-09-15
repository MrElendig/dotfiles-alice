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
Plug 'SirVer/ultisnips'
Plug 'Rykka/riv.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'lukerandall/haskellmode-vim'
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
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

" vim-indent-guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
" Shows indent level while typing
set list listchars=tab:»-,trail:·,extends:»,precedes:«

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

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
set laststatus=2
colorscheme candycode

" -[ FileTypes ]-
" mail
autocmd FileType mail,human set formatoptions+=t textwidth=72

" Python stuff
autocmd FileType python let python_highlight_all = 1
autocmd FileType python let python_slow_sync = 1
autocmd FileType python set expandtab shiftwidth=4 softtabstop=4

" PKGBUILD stuff
autocmd FileType PKGBUILD set expandtab shiftwidth=2 softtabstop=4

" sh stuff
autocmd FileType sh set expandtab shiftwidth=2 softtabstop=4

" -[ Mappings ]-
" tagbar
nnoremap <silent> <F8> :TagbarToggle<CR>
inoremap <silent> <F8> <esc>:TagbarToggle<CR>a
