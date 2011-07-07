" ==========================================================$
" Basic Settings$
" ==========================================================$
syntax on                     " syntax highlighing
filetype on                   " try to detect filetypes$
filetype plugin indent on     " enable loading indent file for filetype$
"set number                    " Display line numbers$
set numberwidth=1             " using only 1 column (and 1 space) while possible$
set background=dark           " We are using dark background in vim$
set title                     " show title in console title bar$
set wildmenu                  " Menu completion in command mode on <Tab>$
set wildmode=full             " <Tab> cycles between all matching choices.$

""" Insert completion$
" don't select first item, follow typing in autocomplete$
"set completeopt=menuone,longest,preview$
"set pumheight=6             " Keep a small completion window$
" show a line at column 79$
"if exists("&colorcolumn")
"    set colorcolumn=79
"endif

set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide
set softtabstop=4           " <BS> over an autoindent deletes both spaces
set expandtab               " Use spaces, not tabs, for autoindent/tab key
set shiftround              " rounds indent to a multiple of shiftwidth

" don't outdent hashes$
inoremap # #

set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files
set ls=2                    " allways show status line
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
"set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently-
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

"filetype off
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

" close preview window automatically when we move around$
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
autocmd VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"
snor <c-j> <esc>i<right><c-r>=TriggerSnippet()<cr>
let g:acp_completeoptPreview=1

" Paste from clipboard
map <leader>p "+gP

"filetype off
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

filetype plugin on
filetype plugin indent on
"let g:pylint_onwrite = 0
let g:pydiction_location = '/home/wcleveland/pydiction-1.2/complete-dict'
autocmd BufRead,BufNewFile *.py syntax on
autocmd BufRead,BufNewFile *.py set ai

"remove all trailing whitespace for specified files before write
autocmd BufWritePre *.py :call <SID>StripTrailingWhitespaces()

au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
"autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
" Detect long lines
" ":au BufWinEnter *.py let w:m1=matchadd('Search', '\%<80v.\%>77v', -1)
:au BufWinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)
"autocmd FileType python compiler pylint
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Remove trailing whitespace
function <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
