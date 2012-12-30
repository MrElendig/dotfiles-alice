" -[ Fuck compatible mode ] -
set nocompatible

" -[ Runtime and Stuff(tm) ]-
" pathogen for using ~/.vim/bundle
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" -[ General behaviour ]-
" general
set nowrap
syntax on
filetype plugin indent on

" search
set nohls
set incsearch
set showmatch

" identing
set autoindent

" command mode
set wildmenu
set wildmode=list:longest,full

" -[ Look ]-
" general
set showcmd
set showmode
set number
set colorcolumn=80

" statusline
set statusline=%<%f\ %{fugitive#statusline()}\ %y%h%m%r\ PWD:%{getcwd()}%=%-14.(%l,%c%V%)\ %P
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

" Common Lisp
autocmd FileType lisp let g:slimv_client='python /usr/share/vim/vimfiles/ftplugin/slimv.py -r "urxvt -T Slimv -e @p @s -l sbcl -s"'

" -[ Mappings ]-"
" Tagbar
nnoremap <silent> <F8> :TagbarToggle<CR>
inoremap <silent> <F8> <esc>:TagbarToggle<CR>a

