" Encoding (important that this is set early in .vimrc)
se enc=utf8 " use UTF-8 internally
se fencs=ucs-bom,utf-8,default,latin1 " detect detectable Unicode, but fall back
let mapleader = ","
map <leader>nt :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>
nmap <leader>v :tabedit $MYVIMRC<CR>

syntax on
set mouse=a
set colorcolumn=80
set laststatus=2
set ignorecase
set smartcase
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap
set backspace=2
set autoindent
set smartindent
set incsearch
set hlsearch
set t_Co=256
set directory=~/.vim/swap//,/tmp/vim-swap//,/tmp//
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set background=dark
set clipboard=unnamedplus,unnamed,autoselect
set rtp+=~/.vim/bundle/Vundle.vim
colorscheme dandelion
let g:solarized_termcolors=256

let g:ctrlp_show_hidden = 1
nm <leader>n :CtrlPCurFile<CR>

let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
r

call rnu#setup()

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

if &term == "xterm-color"
  fixdel
endif

hi CursorLine ctermbg=white ctermfg=NONE guibg=white guifg=none
hi CursorColumn ctermbg=white ctermfg=NONE guibg=white guifg=none
nnoremap <Leader>C :set cursorline! cursorcolumn!<CR>
inoremap jk <Esc>
inoremap kj <Esc>
inoremap jj <Esc>
inoremap kk <Esc>
autocmd BufRead,BufNewFile *.py setlocal tabstop=4 expandtab
autocmd BufRead,BufNewFile *.rb setlocal tabstop=2 expandtab softtabstop=2 shiftwidth=2

" Wrap visual selectiosn with chars
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
vnoremap " "zdi"<C-R>z"<ESC>

filetype on
" reload vimrc on save
augroup vimrc
  autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

aug filetypedetect
  au! BufNewFile,BufRead *.markdown,*.md,*.mkd se ft=markdown
aug END


nmap <leader>v :tabedit $MYVIMRC<CR>
if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif

" Check for file changes
au CursorHold * checktime

augroup Programming
  " clear auto commands for this group
  autocmd!
  autocmd BufWritePost *.js !test -f ~/jslint/jsl && ~/jslint/jsl -conf ~/jslint/jsl.default.conf -nologo -nosummary -process <afile>
  autocmd BufWritePost *.rb !ruby -c <afile>
  autocmd BufWritePost *.rake !ruby -c <afile>
  autocmd BufWritePost *.erb !erb -x -T '-' <afile> | ruby -ci
  autocmd BufWritePost *.py !python -c "compile(open('<afile>').read(), '<afile>', 'exec')"
  autocmd BufWritePost *.php !php -d display_errors=on -l <afile>
  autocmd BufWritePost *.inc !php -d display_errors=on -l <afile>
  autocmd BufWritePost *httpd*.conf !/etc/rc.d/init.d/httpd configtest
  autocmd BufWritePost *.bash !bash -n <afile>
  autocmd BufWritePost *.sh !bash -n <afile>
  autocmd BufWritePost *.pl !perl -c <afile>
  autocmd BufWritePost *.perl !perl -c <afile>
  autocmd BufWritePost *.xml !xmllint --noout <afile>
  autocmd BufWritePost *.xsl !xmllint --noout <afile>
  autocmd BufWritePost *.pp !puppet --parseonly <afile>
augroup END

untime plugin/RainbowParenthsis.vim

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-fugitive'
Plugin 'Markdown'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/Rainbow-Parenthesis'
Plugin 'tpope/vim-endwise'
Plugin 'airblade/vim-gitgutter'
"Plugin "MarcWeber/vim-addon-mw-utils"
"Plugin "tomtom/tlib_vim"
"Plugin "honza/vim-snippets"
"Plugin "garbas/vim-snipmate"
Plugin 'rcyrus/snipmate-snippets-rubymotion'
Plugin 'mhinz/vim-startify'
Plugin 'justinxreese/vim-dandelion'
Plugin 'vim-scripts/bad-whitespace'
Plugin 'scrooloose/nerdcommenter'
Plugin 'rodjek/vim-puppet'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'

call vundle#end()
filetype plugin indent on     " required!by Vundle

"" Reset search highlighting when refreshing the screen (Ctrl+l)
nn <silent> <C-l> :nohls<CR><C-l>
