" plugins
let need_to_install_plugins = 0
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let need_to_install_plugins = 1
endif

call plug#begin()
    " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'

    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'
    Plug 'kien/ctrlp.vim'

    " Completion / linters / formatters
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'plasticboy/vim-markdown'
    Plug 'pangloss/vim-javascript'

    " Git
    Plug 'airblade/vim-gitgutter'

    " Install rigel
    Plug 'Rigellute/rigel'

    call plug#end()

" To Install Plugins
if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif


" Syntax
filetype on
filetype plugin indent on
syntax on

" always show the status bar
set laststatus=2

" Options
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu


" editing
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2

" True color if available
let term_program=$TERM_PROGRAM

" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
    set termguicolors
else
    if $TERM !=? 'xterm-256color'
        set termguicolors
    endif
endif

" Color scheme and themes
colorscheme rigel

set t_Co=256
highlight LineNr ctermfg=241

" Once vim-javascript is installed you enable flow highlighting
let g:javascript_plugin_flow = 1


" Airline
let g:rigel_airline = 1
let g:airline_theme = 'rigel'


" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" File browser
let NERDTreeShowHidden=1

" Language server stuff
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" CTRLP: Ignore based on gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']

" Disable math tex conceal feature
let g:tex_conceal = ''
let g:vim_markdown_math = 1

" Leader
let mapleader = ','

" Normal mode remappings
nnoremap <C-q> :q!<CR>
nnoremap <F4> :bd<CR>
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F6> :sp<CR>:terminal<CR>
nnoremap <F10> :CocCommand tsserver.organizeImports<CR>

"" Tabs
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>

" Show highlight groups
map <F12> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" Auto Commands
augroup auto_commands
	autocmd BufWrite *.py call CocAction('format')
	autocmd FileType scss setlocal iskeyword+=@-@
augroup END
