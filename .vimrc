call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'kien/ctrlp.vim'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/YankRing.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tomasr/molokai'

" Plugin options
Plug 'nsf/gocode', { 'tag': 'go.weekly.2012-03-13', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

call plug#end()


" Globals {{{
set nocompatible
set modelines=0
set autoread
" make mouse to work with gnu screen
set ttymouse=xterm2
set ttyfast
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100
set wildmode=longest,full
set wildignore+=*.o,*.obj,.git,.svn,*.pyc
set hidden
set switchbuf=useopen
" }}}

" Backups {{{
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
" }}}

" User Interface {{{
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
set laststatus=2
set encoding=utf-8 " Necessary to show unicode glyphs
let g:Powerline_symbols = 'fancy' " 'fancy' needs special patched fonts
" }}}

" Tabline {{{
set tabline=%!tabber#TabLine()
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

" Search {{{
set hlsearch
"set nowrap
set shiftround
set autoindent
set ignorecase
set smartcase
set gdefault
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
let g:syntastic_javascript_gjslint_conf = "-strict --custom_jsdoc_tags=todo"
" }}} 

" Python {{{
aug python
    au Filetype python inoremap <silent> <buffer> <F7> import pdb; pdb.set_trace()
    au Filetype python noremap <silent> <buffer> <F7> Oimport pdb; pdb.set_trace()<ESC>j
    " completion is now handled by vim-jedi
    " au FileType python setlocal omnifunc=pythoncomplete#Complete
aug end
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

" Special filetype conf {{{
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au FileType coffee setlocal ts=2 sts=2 sw=2 expandtab
au FileType html setlocal textwidth=0
au BufNewFile,BufRead *.less setf less
au BufNewFile,BufRead *.map setf map
au BufNewFile,BufRead *.tmux.conf setf tmux
au BufNewFile,BufRead *.pp setf puppet
au BufNewFile,BufRead *.penta setf pentadactyl
au BufNewFile,BufRead .pentadactylrc setf pentadactyl
" }}}

" Utilities {{{

" Reload molokai colorscheme
map <leader>c :colorscheme molokai<cr>

" Disable highlight
map <leader><space> :noh<cr>:call clearmatches()<cr>

" Hidden chars
nmap <leader>l :set list!<CR>

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

" Order CSS properties
nnoremap <leader>S ?{<CR>jV/}$<CR>k:sort<CR>:noh<CR>

" Quicker window switching
nnoremap <leader>, <c-w><c-w>

" ack-grep word under cursor
let g:ackprg="ack-standalone -H --nocolor --nogroup --column --ignore-dir=buildout --ignore-dir=build"
noremap <leader>a "cyiw:Ack <c-r>c<CR>

" Select previous selection
nnoremap <expr> gV '`[' . getregtype()[0] . '`]'

" Sudo save
cmap w!! w !sudo tee % >/dev/null

" From tab to vsplit
nnoremap <c-w>V mAZZ<c-w>v`A

" Gstatus shortcut
noremap <leader>g :Gstatus<cr>
noremap <leader>G :Gstatus<cr>:q<cr>
" }}}

" Fast file opening {{{
map <leader>p :CtrlP<CR>
map <leader>P :CtrlPBuffer<CR>
map <leader>e :CtrlPCurFile<CR>
map <leader>t :CtrlPTag<CR>
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files && git ls-files -o --exclude-standard', 'find %s -type f']
let g:ctrlp_mruf_exclude = '/tmp/.*\|.*\.git/.*'
" Note: In some terminals, it’s not possible to remap <c-h> without also
" changing <bs> (|key-codes|). So if pressing <bs> moves the cursor to the left
" instead of deleting a char for you, add this to your |vimrc| to change the
" default <c-h> mapping:
let g:ctrlp_prompt_mappings = {
    \ 'PrtBS()': ['<bs>', '<c-]>', '<c-h>'],
    \ 'PrtCurLeft()': ['<left>', '<c-^>'],
    \ }
" }}}
