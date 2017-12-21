" be improved
set nocompatible
filetype off

" Use Vundle if installed
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if filereadable(vundle_readme)
  set rtp+=${HOME}/.vim/bundle/Vundle.vim
  call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'vim-scripts/Gundo'
    Plugin 'vim-airline/vim-airline'
    Plugin 'sheerun/vim-polyglot'
    Plugin 'vim-scripts/Syntastic'
  call vundle#end()
endif

" DEFAULT SET
filetype plugin indent on
set encoding=utf-8            " utf-8 yay
set title                     " Show filename
set showcmd                   " Show command mode
set noshowmode                " let vim-airline do the job
set bs=2                      " Allow backspacing over everything in insert mode
set ai                        " Always set auto-indenting on
set history=50                " keep 50 lines of command history
set ruler                     " Show the cursor position all the time
set viminfo='20,\"500         " Keep a .viminfo file
set pastetoggle=<F8>          " Toggle between paste mode on/off
set hlsearch                  " Highlight search
set icon                      " Icon text of the window
set confirm                   " Extra dialog
set laststatus=2              " Always show the statusline
set t_Co=256                  " Explicitly tell vim that the terminal has 256 colors
set hlsearch                  " Highlight searching result
set noincsearch               " Disable incremental searching
set ignorecase smartcase      " Case-insensitive searching
set ttyfast                   " fast scrolling
set visualbell                " bong bong bong
syntax on                     " fancy colors
set synmaxcol=800             " don't highlight longer than 800 chars

" Backup options
set backup
set backupskip=/tmp/*,/private/tmp/*"
set noswapfile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//

" tabs, spaces, wrapping
set smartindent               " Set indention
set shiftwidth=4              " Shift width
set tabstop=4                 " Tab size
set noexpandtab
set wrap
set textwidth=80

" show special characters
set lcs=tab:»·
set lcs+=trail:·
set lcs+=eol:¶
set lcs+=precedes:«
set lcs+=extends:»
if v:version >= 700
    set lcs+=nbsp:·
endif
set showbreak=↪

" COLORSCHEME
set background=dark
let g:badwolf_html_link_underline = 0
colorscheme badwolf

" line length
set textwidth=120
set colorcolumn=80
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd FileType gitcommit setlocal textwidth=72

" syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

" KEY MAPS
map <F3> :set cursorline!<CR><Bar>:echo "Highlight active cursor line: " . strpart("OffOn", 3 * &cursorline, 3)<CR>
map <F4> :set list!<CR><Bar>:echo "Showing special Characters: " . strpart("OffOn", 3 * &cursorline, 3)<CR>
map <F5> :set number!<CR><Bar>:echo "Display Number: " . strpart("OffOn", 3 * &number, 3)<CR>
nnoremap <F6> :GundoToggle<CR>
inoremap <C-u> <esc>mzgUiw`za     " Change case
nnoremap <f9> mzggg?G`z           " Panic Button
nnoremap <C-N> :next<Enter>       " Next Buffer
nnoremap <C-P> :prev<Enter>       " Previous Buffer
cmap w!! w !sudo tee % >/dev/null

" Typos
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
