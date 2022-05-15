if !exists('g:vscode')

" BEGIN VIMPLUG CONFIG
" -----------------------
call plug#begin()
" requires node.js > 12*
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" auto-install coc extensions
let g:coc_global_extensions = [
\    'coc-css', 
\    'coc-jedi', 
\    'coc-json', 
\    'coc-markdownlint', 
\    'coc-prettier', 
\    'coc-pyright', 
\    'coc-sh', 
\    'coc-snippets', 
\    'coc-solargraph',
\    'coc-yaml', 
\    ]
" gem install solargraph for ruby completion

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdcommenter'

Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

" consistent kebindings for vim and tmux splits
" Plugin 'christoomey/vim-tmux-navigator'

" typescript syntax
Plug 'HerringtonDarkholme/yats.vim'

" other generic stuff
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

" vim and tmux integration
Plug 'christoomey/vim-tmux-navigator'

" tables
Plug 'godlygeek/tabular'
" markdown stuff
Plug 'plasticboy/vim-markdown'
Plug 'masukomi/vim-markdown-folding'

" loadsa colours
Plug 'flazz/vim-colorschemes'

" fancy statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1

" ledger stuff
Plug 'ledger/vim-ledger'

" jinja2 highlighting
Plug 'Glench/Vim-Jinja2-Syntax'

" docstring generator
Plug 'kkoomen/vim-doge'

" auto-format python code
Plug 'psf/black', { 'branch': 'stable' }
Plug 'fisadev/vim-isort'

" ukedown support
Plug 'lanky/vim-ukedown'

" snippety goodness
Plug 'honza/vim-snippets'
" ukedown support
Plug 'lanky/vim-ukedown'

" finish vundle setup
call plug#end()
endif


filetype plugin indent on

let mapleader=","
let g:python3_host_prog = expand('~/.virtualenvs/nvim/bin/python')
let g:python_host_prog = expand('~/.virtualenvs/nvim_py2/bin/python')
" gem install solargraph/neovim for this to work properly
" let g:ruby_host_prog = expand('~/.chefdk/gem/ruby/2.7.0/bin/neovim-ruby-host')

" DoGe
let g:doge_mapping = '<Leader>d'
let g:doge_enable_mappings = 1
let g:doge_doc_standard_python = 'google'

" snippets, use TAB for completion and jumping etc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

imap <C-e> <Plug>(coc-snippets-expand)

let g:coc_snippet_next = '<tab>'


" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" core settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set nohls
set scrolloff=0

color delek

" NERDTree settings
" nmap <C-N> :NERDTreeToggle<CR>

" mass commenting
vmap <C-/> <plug>NERDCommenterToggle
nmap <C-/> <plug>NERDCommenterToggle

" NERDTree highlighting of open files
" sync open file with NERDTree

" Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

function! ToggleNerdTree()
  set eventignore=BufEnter
  NERDTreeToggle
  set eventignore=
endfunction
nmap <C-n> :call ToggleNerdTree()<CR>

au bufenter * call ToggleCursorLine()

" toggle cursorline when entering and leaving NERDTree
function! ToggleCursorLine()
    if (bufname("%") =~ "NERD_Tree_")
        setlocal cursorline
    else
        setlocal nocursorline
    endif
endfunction

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" black and isort stuff
let g:black_virtualenv = '~/.virtualenvs/nvim'
let g:vim_isort_config_overrides = { 'profile': ' black' }
let g:vim_isort_python_version = 'python3'


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
"if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
set signcolumn=yes
"endif


" Stuff from my original vimrc
set modeline
set autochdir
set splitbelow
set splitright

"characters to show in `set list`
set listchars=trail:-,nbsp:+,eol:$

set ruler
set showtabline=2
" Custom keymaps
map Y y$
set pastetoggle=<F8>
map <F3> :set list! list? <CR>
" map CTRL-DIRECTION to move between split windows
" might want tweaking to work with the tmux integration
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set guifont=DejaVu\ Sans\ Code\ 14

" where do swapfiles go?
set directory=.,~/.local/share/nvim/swap

function! ColourGutter() abort
    " let's do some syntax overriding
    " DarkRed for deletion
    hi! GitGutterDelete ctermfg=1 guifg=1
    " DarkGreen for added stuff
    hi! GitGutterAdd ctermfg=2 guifg=2
    " DarkBlue for changed items
    hi! GitGutterChange ctermfg=4 guifg=4
    " EOL indicator, when in use
    hi! ColorColumn ctermbg=235
    " COC popout window colours
    hi! Pmenu ctermfg=black ctermbg=blue guifg=white guibg=blue
    hi! CocFloating ctermbg=black
    hi! CocErrorFloat ctermfg=white
    hi! CocWarningFloat ctermfg=yellow
    " folded text, white on darkish blue
    hi! Folded ctermfg=white ctermbg=blue
    " cursor
    hi! cursorline cterm=reverse
    " clear weird background colours for the gutter
    hi! clear SignColumn
endfunction


" terminal splits
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" terminal split mappings
" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>
" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" filetypes etc
" au BufWritePre * :call StripTrailingWhitespace()
augroup ColourGutter
    autocmd!
    autocmd ColorScheme * call ColourGutter()
augroup END

au FileType python set ci ts=4 sts=4 et sw=4 tw=0 nu fdm=indent nofen cc=88
au FileType puppet set ci ts=2 sts=2 sw=2 nu
au FileType ruby set ts=2 sts=2 sw=2 et ci nu
au FileType json set ts=2 sts=2 sw=2 et ci nu conceallevel=0
