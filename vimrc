call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'walm/jshint.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tomasr/molokai'
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jmcantrell/vim-virtualenv'
Plug 'junegunn/vim-github-dashboard'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go'
Plug 'scrooloose/nerdtree'

" Plugin options
Plug 'nsf/gocode', { 'tag': 'go.weekly.2012-03-13', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

call plug#end()

" Globals {{{
set nocompatible
set modelines=0
set autoread
set ttyfast
set number
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100
set wildmode=longest,full
set wildignore+=*.o,*.obj,.git,.svn,*.pyc
set hidden
set switchbuf=useopen
" }}}

" Search {{{
set hlsearch
"set nowrap
set shiftround
set autoindent
set ignorecase
set smartcase
set gdefault
" }}}

" User Interface {{{
if exists('+cc')
  set cc=95
endif
set guioptions-=T
set guioptions-=r
syntax on
set listchars=tab:▸\ ,eol:¬,trail:·
set shortmess+=r
set showmode
set showcmd
set showmatch
set t_Co=256
colorscheme molokai
set ruler
set backspace=indent,eol,start
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set encoding=utf-8 " Necessary to show unicode glyphs
" }}}

" Backups {{{
" reopening a file to the last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if v:version >= 703
    set undofile
    set undodir=~/.tmp/vim/undodir//,/tmp//
else
    let g:gundo_disable = 1
endif
set backupdir=~/.tmp/vim/backupdir//,/tmp//
set directory=~/.tmp/vim/directory//,/tmp//
set history=500
set undolevels=500
noremap <C-l> :GundoToggle<cr>
" }}}

" Airline {{{
"let g:airline#extensions#whitespace#enabled = 1
"let g:airline#extensions#tabline#enabled = 1
"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif
"
"" unicode symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline#extensions#tabline#left_sep = ''
"let g:airline#extensions#tabline#left_alt_sep = ''
"let g:airline#extensions#tabline#right_sep = ''
"let g:airline#extensions#tabline#right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
"
"let g:airline_theme='zenburn'
"function! AirlineInit()
"  let g:airline_section_a = airline#section#create(['mode', 'branch'])
"  let g:airline_section_b = airline#section#create('%{virtualenv#statusline()}')
"  let g:airline_section_c = airline#section#create(['hunks', expand('%:t')])
"  let g:airline_section_x = airline#section#create(['filetype'])
"  let g:airline_section_y = airline#section#create(['%P'])
"  let g:airline_section_z = airline#section#create_right(['linenr', '%c'])
"endfunction
"autocmd VimEnter * call AirlineInit()
" }}}

" Movements {{{
" Use the damn hjkl keys, never use the arrow keys ! Never ever !
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" EasyMotion
let g:EasyMotion_leader_key = '<space>'
" }}}

" Leader {{{
let mapleader=','
" }}}

" Yankring {{{
let g:yankring_max_history = 10
let g:yankring_max_element_length = 512000
let g:yankring_history_dir = '~/.vim'
let g:yankring_clipboard_monitor = 0
let g:yankring_manual_clipboard_check = 0
function! YRRunAfterMaps()
    " Make Y yank to end of line.
    " (fix 'nnoremap Y y$<CR>' remapping)
    nnoremap Y :<C-U>YRYankCount 'y$'<CR>

    " Don't clobber the yank register when pasting over text in visual mode.
    vnoremap p :<c-u>YRPaste 'p', 'v'<cr>gv:YRYankRange 'v'<cr>
endfunction
" }}}

" Syntastic {{{
" disable signs
let g:syntastic_enable_signs=0
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '!'
let g:syntastic_html_tidy_ignore_errors = [" proprietary attribute \"ng-"]
let g:syntastic_html_tidy_ignore_errors = [" proprietary attribute \"ng-"]
let g:syntastic_javascript_checkers = ['jshint']
"let g:syntastic_javascript_gjslint_conf = "-strict --custom_jsdoc_tags=todo"
" }}}

" Cursorline {{{
aug cursorline
    " Highlight the current line in the current window.
    au!
    au BufEnter * set cursorline
    au BufLeave * set nocursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
aug end
" }}}

" Utilities {{{
" Reload molokai colorscheme
map <leader>c :colorscheme molokai<cr>

" Disable highlight
map <leader><space> :noh<cr>:call clearmatches()<cr>

" Hidden chars
"nmap <leader>l :set list!<CR>

" remap Y to follow same principle as C, D
" this used to fail due to YankRing plugin: see fix in YankRing config above
nnoremap Y y$

" Remove trailing spaces
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" Indent whole file
nmap _= :call Preserve("normal gg=G")<CR>
nmap _t :call Preserve("%!tidy -i -xml -q")<CR>
" Split/Join block
nmap _j :SplitjoinJoin<CR>
nmap _s :SplitjoinSplit<CR>

" Quicker window switching
nnoremap <leader>, <c-w><c-w>

" Close Error windows
nnoremap <leader>c :lclose<cr>

" ack-grep word under cursor
let g:ackprg="ack-standalone -H --nocolor --nogroup --column --ignore-dir=buildout --ignore-dir=build"
nnoremap <leader>a "cyiw:Ack <c-r>c<CR>

" Select previous selection
nnoremap <expr> gV '`[' . getregtype()[0] . '`]'

" Sudo save
cmap w!! w !sudo tee % >/dev/null

" Buffer mapping
nnoremap <leader>n :bnext<cr>
nnoremap <leader>p :bprevious<cr>

" Gstatus shortcut
nnoremap <leader>g :Gstatus<cr>
nnoremap <leader>d :Gdiff<cr>
" }}}

" CtrlP {{{
nnoremap <C-l> :CtrlPLine<cr>
let g:ctrl_map = '<C-p>'
let g:ctrl_cmd = 'CtrlP'

"'c' - the directory of the current file.
"'r' - the nearest ancestor that contains one of these directories or files:
"       .git .hg .svn .bzr _darcs
"'a' - like c, but only if the current working directory outside of CtrlP is
"       not a direct ancestor of the directory of the current file.
"0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|DS_Store|pyc)$',
  \ }
" }}}

" YouCompleteMe {{{
let g:ycm_confirm_extra_conf = 0
" }}}

source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
