" meinside's .vimrc file for vim and neovim,
" created by meinside@gmail.com,
"
" last update: 2019.11.10.
"
" XXX - change default text editor:
" $ sudo update-alternatives --config editor
"
" XXX - setup for nvim:
" $ sudo apt-get install python3-pip
" $ sudo pip3 install --upgrade neovim

""""""""""""""""""""""""""""""""""""
" settings for nvim
"
"
" for nvim, symbolic link '~/.vimrc' to '~/.config/nvim/init.vim'
if !filereadable(expand('~/.config/nvim/init.vim'))
    silent !mkdir -p ~/.config/nvim
    silent !ln -sf ~/.vimrc ~/.config/nvim/init.vim
endif
if has('nvim')	" settings for nvim only
    set termguicolors
    colo pablo
    set mouse-=a	" not to enter visual mode when dragging text
    let g:go_term_enabled = 1	" XXX - it needs to be set for 'delve' (2017.02.10.)
else	" settings for vim only
    set t_Co=256
    colo elflord
endif

""""""""""""""""""""""""""""""""""""
" settings for vim-plug (https://github.com/junegunn/vim-plug)
if has('nvim')
    " for nvim
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    " for vim
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" Specify a directory for plugins
if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

""""""""
" plugins

" Useful plugins
Plug 'jiangmiao/auto-pairs'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-ragtag' " TAG + <ctrl-x> + @, !, #, $, /, <space>, <cr>, ...
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
let g:airline#extensions#ale#enabled = 1
Plug 'airblade/vim-gitgutter'        " [c, ]c for prev/next hunk
let g:gitgutter_highlight_lines = 1
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '⎸'
let g:indentLine_enabled = 0	" :IndentLinesToggle
Plug 'docunext/closetag.vim'
Plug 'tpope/vim-sleuth'
Plug 'johngrib/vim-f-hangul'	" can use f/t/;/, on Hangul characters

" For autocompletion
if has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " XXX - nodejs needed!

    " coc.nvim default settings
    "
    " if hidden is not set, TextEdit might fail.
    set hidden
    " Better display for messages
    set cmdheight=2
    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=300
    " don't give |ins-completion-menu| messages.
    set shortmess+=c
    " always show signcolumns
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    vmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    " float-preview
    "Plug 'ncm2/float-preview.nvim'
    "set completeopt-=preview

    " To close preview window after selection
    autocmd CompleteDone * pclose

    " coc extensions (:CocInstall <extension-name>)
    "
    " - clojure: coc-conjure
    " - go: coc-go
    " - ruby: coc-solargraph ($ gem install solargraph)
    let g:coc_global_extensions = ['coc-json',
        \ 'coc-conjure', 'coc-go', 'coc-solargraph']
endif

" For source file browsing, XXX: ctags and vim-nox is needed! ($ sudo apt-get install vim-nox ctags)
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" For uploading Gist (:Gist / :Gist -p / ...)
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

" For syntax checking
Plug 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#
if exists('*SyntasticStatuslineFlag')
    set statusline+=%{SyntasticStatuslineFlag()}
endif
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" For vim-codefmt (:FormatLines, :FormatCode)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'

" For Clojure
if has('nvim')
    Plug 'Olical/conjure', { 'tag': 'v2.1.0', 'do': 'bin/compile'  }
    let g:conjure_log_direction = "horizontal"
endif
" $ go get github.com/cespare/goclj/cljfmt
Plug 'dmac/vim-cljfmt', {'for': 'clojure'}

" For Go
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
if has('nvim')
    Plug 'jodosha/vim-godebug', {'for': 'go'}	" For :GoToggleBreakpoint / :GoDebug ($ brew install go-delve/delve/delve)

    " disable vim-go :GoDef short cut (gd), this is handled by LanguageClient [LC]
    let g:go_def_mapping_enabled = 0
endif
let g:go_fmt_command = "goimports"     " auto import dependencies
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:syntastic_go_checkers = ['go', 'errcheck', 'golint']
let g:syntastic_aggregate_errors = 1

" For JavaScript frameworks
Plug 'pangloss/vim-javascript'

" For Ruby
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'tpope/vim-endwise', {'for': 'ruby'}

"
""""""""

" Initialize plugin system
call plug#end()
"
""""""""""""""""""""""""""""""""""""

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup	" do not keep a backup file, use versions instead
set history=50	" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch	" do incremental searching
set cindent
set ai
set smartindent
set nu
set ts=4
set sw=4
set sts=4
set fencs=ucs-bom,utf-8,korea
set termencoding=utf-8
set wildmenu   " visual autocomplete for command menu
set showbreak=↳
set breakindent

" for running correct rvm ruby in zsh
set shell=/bin/bash

" Don't use Ex mode, use Q for formatting
map Q gq

" file browser (netrw)
" :Ex, :Sex, :Vex
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
" <F2> for vertical file browser
nmap <F2> :Vex <CR>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " For html/javascript/css
        autocmd FileType htm,html,js,json set ai sw=2 ts=2 sts=2 et
        autocmd FileType css,scss set ai sw=2 ts=2 sts=2 et

        " For programming languages
        " Golang
        autocmd FileType go set ai sw=4 ts=4 sts=4 noet
        " Ruby
        autocmd FileType ruby,eruby,yaml set ai sw=2 ts=2 sts=2 et
        " Python
        autocmd FileType python set ai sw=2 ts=2 sts=2 et

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif
    augroup END
else
    set autoindent		" always set autoindenting on
endif " has("autocmd")

