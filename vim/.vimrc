""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on

" Highligh
syntax on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations like <leader>w
" saves the current file
let mapleader = ','
let g:mapleader = ','
let maplocalleader = ';'
let g:maplocalleader = ';'

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" Indent
filetype indent on

" Insert space characters whenever the tab key is pressed
set tabstop=4
set shiftwidth=4
set expandtab

" Read modelines at the end and begging
set modeline

" Vim insert delete over line breaks, or automatically-inserted indentation
set backspace=indent,eol,start

" Set relative numbers
set relativenumber

" Position of cursor
set ruler

" Better wrapping
set breakindent
set showbreak=\\\\\

" Only syntax highlighting the first 200 characters of each line.
"set synmaxcol=200

" Opening new files via :e, a breeze with TAB expansion.
set wildmenu
set wildmode=full

" Folding
set foldmethod=indent
set foldnestmax=2
" disable folding at the begging
set nofoldenable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save movements larger than 5 lines to the jumplist.
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Buffer movement
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
"set viminfo^=%

" Clipboard to use it exterior
set clipboard=unnamedplus

" Format-Flowed text
setlocal fo+=aw

" Escape using jj
:imap jj <Esc>

""""""""""""""
"  Filetype  "
""""""""""""""
au FileType mail setlocal sw=2 sts=2 textwidth=0 wrapmargin=0 wrap linebreak nolist
au FileType vimwiki  setlocal tabstop=2 shiftwidth=2 expandtab
au FileType javascript  setlocal tabstop=2 shiftwidth=2 expandtab
au FileType json  setlocal tabstop=2 shiftwidth=2 expandtab
au FileType typescript  setlocal tabstop=2 shiftwidth=2 expandtab
au FileType markdown  setlocal tabstop=2 shiftwidth=2 expandtab
au FileType text  setlocal tabstop=2 shiftwidth=2 expandtab
au FileType html  setlocal tabstop=2 shiftwidth=2 expandtab
au FileType yaml  setlocal tabstop=2 shiftwidth=2 expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Set local language (en_us, en_gb, fr, es)
nmap <Leader>sf :setlocal spell! spelllang=fr<CR>
nmap <Leader>sl :setlocal spell! spelllang=es<CR>
nmap <Leader>se :setlocal spell! spelllang=en_gb<CR>

" Automatically correct spell with first suggestion
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"""""""""""""""
"  Gramarous  "
"""""""""""""""

" Use global languatetool
let g:grammarous#languagetool_cmd = '/usr/bin/languagetool'

" Open window on first error
let g:grammarous#show_first_error = 1

" Ose location list for errors
let g:grammarous#use_location_list = 1

" Use spelllang as language
let g:grammarous#use_vim_spelllang = 1

" Shortcuts
nmap <F5> <Plug>(grammarous-fixit)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'lifepillar/vim-solarized8'
Plug 'hkupty/iron.nvim'
Plug 'rhysd/vim-grammarous'
Plug 'davidhalter/jedi-vim'
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'jalvesaq/Nvim-R' " R - vim
"Plug 'junegunn/vim-easy-align' " Align text <Shift><Enter>
Plug 'lervag/vimtex' " Latex suite that replace gerw/vim-latex-suite
Plug 'majutsushi/tagbar' " Ctags <F6>
Plug 'pangloss/vim-javascript' "Js hightlight
"Plug 'roxma/vim-paste-easy' " Avoid indent break when paste
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }  " File manager <F3>
Plug 'w0rp/ale' " Asynchronous linter <leader>sc
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive' " Git-vim
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'easymotion/vim-easymotion' " Simple motion <leader><leader>w
Plug 'othree/html5.vim' " Hightlight
Plug 'luochen1990/rainbow' " Parentheses highlight <leader>R
Plug 'leafgarland/typescript-vim' " Typescript lighting
"Plug 'quramy/tsuquyomi' "Special linter for Typescript
Plug 'vimwiki/vimwiki' " Vimwiki notes <leader>ww
call plug#end()


""""""""""""""""""""""
"  CoC  "
""""""""""""""""""""""

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""
"  NerdTreeToogle  "
""""""""""""""""""""
" Ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" Disable that old Press ? for help
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Automatically close NerdTree when you open a file
let NERDTreeQuitOnOpen = 1

" Automatically delete the buffer of the file you just deleted with NerdTree:
let NERDTreeAutoDeleteBuffer = 1

" Activate with <F3>
nmap <silent> <F3> :NERDTreeToggle<CR>

"""""""""""""
"  Airline  "
"""""""""""""

"Disable vim-airline integration:
let g:airline#extensions#coc#enabled = 1

"Change error symbol:
let airline#extensions#coc#error_symbol = 'Error:'

"Change warning symbol:
let airline#extensions#coc#warning_symbol = 'Warning:'

"Change error format:
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

"Change warning format:
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Use tabline (for buffers)
let g:airline#extensions#tabline#enabled = 1

" Show terminals in tabline
let g:airline#extensions#tabline#ignore_bufadd_pat =
  \ 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify|!'

" Use powerline fonts
let g:airline_powerline_fonts = 1

" Theme
"let g:airline_theme='solarized'
let g:airline_theme='gruvbox'

""""""""""""""
"  Tmuxline  "
""""""""""""""
" Create snapshot using: 'TmuxlineSnapshot! .tmux.theme'
"
" use airline
let g:airline#extensions#tmuxline#enabled = 1

" Conf tmuxline
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#(~/.dotfiles/new_mail.sh)',
      \'win'  : ['#W'],
      \'cwin' : '#F #W',
      \'z'    : '%R'}

""""""""""""""""
"  Promptline  "
""""""""""""""""
" Create snapshot using ':PromptlineSnapshot! .shell_prompt.sh airline'
"
" Conf promptline
let g:promptline_preset = {
        \'a'    : [ promptline#slices#host() ],
        \'b'    : [ promptline#slices#cwd() ],
        \'c'    : [ promptline#slices#vcs_branch() ],
        \'warn' : [ promptline#slices#last_exit_code() ],
        \'z'    : [ promptline#slices#python_virtualenv() ]}

"""""""""""""""""""""""""""
"  Nvim-R: use R and vim  "
"""""""""""""""""""""""""""
" Default pdf viewer
let R_pdfviewer = 'zathura'

" tmux and R
let R_in_buffer = 0

" Dont use R.app (mac) or Rstudio for graphic
let R_applescript = 0

" Make a tmux split
let R_tmux_split = 1

" Disable _ to <-
let R_assign = 0

" need of setwith Console width adapted to window
"let R_setwidth = 0

" need of colorout
let R_hl_term = 1 " need of colorout

" If exit buffer then exit the command ligne
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

"""""""""""""""""""""""""""
"  Jedi: python vim help  "
"""""""""""""""""""""""""""
let python_highlight_all = 1

" Completions command
"let g:jedi#completions_command = '<C-N>'
let g:jedi#completions_enabled = 0

" See usages of a variable
let g:jedi#usages_command = '<leader>z'

" Dont show popup when writing dot
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0

" Max doc height
let g:jedi#max_doc_height = 30

" No automatic import after
let g:jedi#smart_auto_mappings = 0
"map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Work with virtualenvs
let g:python3_host_prog = '/bin/python3' " Python 3


""""""""""""""""""""""
"  Snippets  "
""""""""""""""""""""""

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

""""""""""""""""
"  Easy align  "
""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Ale: requires flake8 for python and vint for vim lighting (pip install
"  vim-vint  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle ALE with <leader>sc
nnoremap <leader>sc :ALEToggle<CR>

" Not enable by default
let g:ale_enabled = 0

" Do compleition
let g:ale_completion_enabled = 1

let g:ale_linters = {'python': ['flake8', 'mypy']}

" Use fixers
"let g:ale_fixers = {
"\   'javascript': ['eslint'],
"\   'python': ['autopep8', 'yapf'],
"\   'vim': ['vint'],
"\}

""""""""""""
"  Tagbar  "
""""""""""""
" Open tag list with <F6>
nmap <F6> :TagbarToggle<CR>

"""""""""""
"  Theme  "
"""""""""""
" Black theme
set background=dark
"set background=light

" Add underline syntax details
syntax enable

" 16 colors theme
let g:gruvbox_termcolors = 16
"let g:solarized_use16 = 1

" Set italics
"let g:solarized_term_italics=1
let g:gruvbox_italic=1

" Set color scheme
colorscheme gruvbox
"colorscheme solarized8

""""""""""""""
"  Fugitive  "
""""""""""""""
" When doing Gdiff make a vertical split by default
set diffopt+=vertical

"""""""""""""""""""""""""""
"  Git gutter (git diff)  "
"""""""""""""""""""""""""""
" Not enable by default
let g:gitgutter_enabled=0

" Activate using <leader>d
nnoremap <silent> <leader>d :GitGutterToggle<cr>

""""""""""""
"  Js vim  "
""""""""""""
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

"""""""""""""
"  Vimwiki  "
"""""""""""""
" Configuration
let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'template_path': '~/Documents/vimwiki/templates/',
          \ 'template_default': 'default', 'syntax': 'markdown', 'ext': '.wiki',
          \ 'path_html': '~/Documents/vimwiki/site_html/', 'custom_wiki2html': '',
          \ 'template_ext': '.tpl'}]

" Transform to html
nmap <silent> <leader>wah :VimwikiAll2HTML<cr>
let g:vimwiki_table_mappings = 0

"""""""""""""""""""""""""
"  Rainbow Parentheses  "
"""""""""""""""""""""""""
" 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 0

" Toggle rainbow with <leader>R
nmap <leader>R :RainbowToggle<cr>


""""""""""""
"  Neovim  "
""""""""""""
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <M-[> <Esc>
    tnoremap <C-v><Esc> <Esc>
    nmap <localleader>t <Plug>(iron-send-motion)
    autocmd TermOpen * set bufhidden=hide
    au TermOpen * setlocal nonumber norelativenumber
    :hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE
endif

nmap <localleader>t <Plug>(iron-send-motion)
let g:iron_new_python_repl_hooks='ipython'

command Mail e term://mutt

set termguicolors " Enable true color support.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
