" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
    syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
    filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
"set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
set incsearch           " Incremental search
set autowrite           " Automatically save before commands like :next and :make
"set hidden              " Hide buffers when they are abandoned
"set mouse=a            " Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif
let g:solarized_termcolors=256

" colorscheme solarized
 colorscheme zenburn
set exrc
set secure
silent! runtime macros/machit.vim
set autochdir
set backspace=indent,eol,start
set foldenable
set laststatus=2
set ruler
set switchbuf=useopen,usetab
set wildmenu
set hlsearch
" diff open vertical
set diffopt+=vertical

"nnoremap gb :buffer<CR>:sb<Space>
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab


"Wild ingore these files

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.bin     " MacOSX/Linux
set t_Co=256 

" CtrlP include and enable
set runtimepath^=/home/ahmed/.vim/bundle/ctrlp.vim

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll|bin|ciu)$',
            \ }
"\ 'link': 'some_bad_symbolic_links',
"""""""""""""""""""""""""""""""""""""""


"" Vundle set up

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'git://github.com/will133/vim-dirdiff'
Plugin 'Chiel92/vim-autoformat'
Plugin 'git://github.com/AndrewRadev/linediff.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'https://github.com/msanders/snipmate.vim.git'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'vim-syntastic/syntastic'
"Plugin 'https://github.com/will133/vim-dirdiff'

" Optional:
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
":PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" End of Vundle setup
let g:formatdef_astyle_c = '"astyle --mode=c --style=1tbs -pcH"'

noremap <F3> :Autoformat<CR>



" add cscope library by searching all the up to the up directory

function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
    endif
endfunction
au BufEnter /* call LoadCscope()

" ignore whitespace in diff mode

if &diff
    " diff mode
    set diffopt+=iwhite
endif
""""""""""""""""
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
highlight Pmenu ctermfg=15 ctermbg=blue guifg=#ffffff guibg=#0000ff


" Type dts to insert date
iab <expr> dts  strftime("%a %d %b %Y")
" change cursor to block in nomral mode
"
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" map \s to replace the word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
" map over shortcuts for leader
nnoremap <leader>w :w<cr>
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>te :tabedit

"" pressing F5 display the buffers and write buffer
"" you can switch to a buffer number by pressing the number (n) followed by
"" Ctr-^

noremap <F5> :buffers<CR>:buffer<Space>
" Fix the difficult-to-read default setting for diff text highlighting.  The
" " bang (!) is required since we are overwriting the DiffText setting. The
" highlighting
" " for "Todo" also looks nice (yellow) if you don't like the "MatchParen"
" colors.
" highlight! link DiffText MatchParen


if &diff
"    colorscheme industry
endif
