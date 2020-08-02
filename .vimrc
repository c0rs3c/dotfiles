" Fisa-vim-config
" http://fisadev.github.io/fisa-vim-config/
" version: 8.3.1

" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:
" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.vim/plugged')

" Plugins from github repos:

" Better file browser
Plug 'scrooloose/nerdtree'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Terminal Vim with 256 colors colorscheme
Plug 'rafi/awesome-vim-colorschemes'
" cs"'--> This will replace surrounding " with '
" cs'<q> --> This will replace surroundig ' with <q>
" ysiw{ --> This will surround the word with {
" yss{ --> This shall surround the sentence with {
" ds{ --> This will remove the surrounding {     
Plug 'tpope/vim-surround'
" Autoclose. Puts closing tag automatically if opening tag given. For example
" if { is typed } is automatically placed
Plug 'Townk/vim-autoclose'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative 
" numbering every time you go to normal mode. Author refuses to add a setting 
" to avoid that)
" Plug 'myusuf3/numbers.vim'


"For Commenting in vim use #gcc for # number of lines commenting. gc<motion>
"is used to comment according to motion. For example gca< , it will comment
"around <
"FROM GITHUB">> Comment stuff out. Use gcc to comment out a line (takes a count)
", gc to comment out the target of a motion (for example, gcap to comment out a 
"paragraph), gc in visual mode to comment out the selection, and gc in operator 
"pending mode to target a comment. You can also use it as a command, either with 
"a range like :7,17Commentary, or as part of a :global invocation like with :g/TODO/Commentary
Plug 'tpope/vim-commentary'
"For Syntax highligting in different language
Plug 'sheerun/vim-polyglot'
"For code-completion like any IDE. Need to install language engine as well.
"Hence do :CocInstall coc-json coc-tsserver coc-html coc-css coc-prettier(it
"is prettier extension for JS in COC.VIM) etc after the installation
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tell vimuplug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif
" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" no vi-compatible
set nocompatible

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

"Set leader key
let mapleader = ","

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4

" always show status bar
set ls=2

" incremental search
set incsearch
" highlighted search results
set hlsearch

" syntax highlight on
syntax on

" show line numbers
set nu


" navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

"Quit vim with zz and save and quit with wzz
nmap zz :q!<CR>
nmap wzz :wq!<CR>

"colorschme selected from installed awesome-vim-fonts 
colorscheme dracula

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3



" NERDTree ----------------------------- 

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']


" Airline ------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'luna'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1

" Colorscheme
if &t_Co == 256
    try
        color xoria256
    catch /^Vim\%((\a\+)\)\=:E185/
        " Oh well
    endtry
endif
"Set no creation of swap file
set noswapfile
" Map a key for grepping word under cursor and opening result in new tab (here
"<C-R><C-W> is putting the word under the cursor
nmap <leader>g :tabnew <bar>r !grep -rhin <C-R><C-W> ./*<CR>
nmap <leader>gh:tabnew <bar>r !grep -riHn <C-R><C-W> ./*<CR>
"Mapping for navigating between next and previous buffers

"Using Tab and Shift-Tab to navigate back and forth between buffers
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" For showing list characters like space tab new line etc. It toggles the
" viewing of list characters
nmap <leader>l :set list!<CR>

" Base64 decode word under cursor
nmap <Leader>b :!echo <C-R><C-W> \| base64 -d<CR>

" sort the buffer removing duplicates
nmap <Leader>s :%!sort -u --version-sort<CR>

"Remaps copy pasting from system clipboard to quote plus registers as present
"in normal system like ctrl+c , ctrl+v and ctrl+x
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-x> "+d
"To toggle higlighting of the searched word in VIM. When a word is searched in
"VIM it remains higlighted even afterwards
nnoremap <F2> :set hlsearch!<CR>

